
{******************************************}
{                                          }
{             FastReport VCL               }
{                                          }
{         List of available reports        }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerReportsList;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, Classes, frxClass, frxServerTemplates, frXML, SyncObjs;

type
  TfrxServerReportsListItem = class (TCollectionItem)
  private
    FFileName: String;
    FDescription: String;
    FName: String;
    FGroups: TStringList;
    FCacheLatency: Integer;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property FileName: String read FFileName write FFileName;
    property ReportName: String read FName write FName;
    property Description: String read FDescription write FDescription;
    property Groups: TStringList read FGroups;
    property CacheLatency: Integer read FCacheLatency write FCacheLatency;
  end;

  TfrxServerReportsList = class (TCollection)
  private
    FReportsPath: String;
    function GetItems(Index: Integer): TfrxServerReportsListItem;
    procedure BuildListInFolder(const Folder: String);
    function GetItem(Name: String): TfrxServerReportsListItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[Index: Integer]: TfrxServerReportsListItem read GetItems;
    procedure BuildListOfReports;
    function GetCacheLatency(const FileName: String): Integer;
    function GetGroupMembership(const FileName: String; const Group: String): boolean;
  published
    function Add: TfrxServerReportsListItem;
    property ReportsPath: String read FReportsPath write FReportsPath;
    procedure GetReports4Group(const GroupName: String; var Html: AnsiString; var Lines: AnsiString);
  end;

var
  ReportsList: TfrxServerReportsList;


implementation

uses frxServerUtils, frxNetUtils, frxUtils, frxServerConfig;

var
  ReportsListCS: TCriticalSection;


{ TfrxServerReportsList }

function TfrxServerReportsList.Add: TfrxServerReportsListItem;
begin
  Result := TfrxServerReportsListItem.Create(Self);
end;

procedure TfrxServerReportsList.BuildListInFolder(const Folder: String);
var
  SRec: TSearchRec;
  i: Integer;
  s: String;
  List: TStringList;
  ListFolders: TStringList;
  xml: TfrXMLDocument;
begin
  List := TStringList.Create;
  ListFolders := TStringList.Create;
  try
    i := FindFirst(FReportsPath + Folder + '*.*', faAnyFile {faDirectory + faArchive}, SRec);
    try
      while i = 0 do
      begin
        if (SRec.Name <> '.') and (SRec.Name <> '..') then
        begin
          if (LowerCase(ExtractFileExt(SRec.Name)) = '.fr3') then
            List.Add(Folder + SRec.Name)
          else
            if (SRec.Attr and faDirectory) = faDirectory then
              ListFolders.Add(SRec.Name);
        end;
        i := FindNext(SRec);
        PMessages;
      end;
    finally
      FindClose(SRec);
    end;
    ListFolders.Sort;
    for i := 0 to ListFolders.Count - 1 do
      BuildListInFolder(Folder + ListFolders[i] + PathDelim);
    List.Sort;
    for i := 0 to List.Count - 1 do
    begin
      xml := TfrXMLDocument.Create;
      try
        try
          xml.LoadFromFile(FReportsPath + List[i]);
        except
        end;
        if xml.Root.Count > 0 then
        begin
          with Add do
          begin
            if xml.Root.Prop['ReportOptions.Name'] = '' then
            begin
              s := ExtractFileName(List[i]);
              SetLength(s, Length(s) - 4);
              ReportName := s;
            end
            else
              ReportName := xml.Root.Prop['ReportOptions.Name'];
            Description := xml.Root.Prop['ReportOptions.Description.Text'];
            FileName := List[i];
          end;
        end;
      finally
        xml.Free;
      end;
//      Sleep(1);
      PMessages;
    end;
  finally
    List.Free;
    ListFolders.Free;
  end;
end;

procedure TfrxServerReportsList.BuildListOfReports;
var
  i: Integer;
  xml: TfrXMLDocument;
  xmlItem, xmlRep: TfrXMLItem;
  reportRec: TfrxServerReportsListItem;
begin
  ReportsListCS.Enter;
  try
    Clear;
    if DirectoryExists(FReportsPath) then
      BuildListInFolder('');
    xml := TfrXMLDocument.Create;
    try
      xml.LoadFromFile(frxGetAbsPathDir(ServerConfig.GetValue('server.reports.reportsfile'), ServerConfig.ConfigFolder));
      xmlItem := xml.Root;
      for i := 0 to xmlItem.Count - 1 do
      begin
        xmlRep := xmlItem[i];
        reportRec := GetItem(xmlRep.Prop['name']);
        if reportRec <> nil then
        begin
          if xmlRep.Prop['cache'] <> '' then
            reportRec.CacheLatency := StrToInt(xmlRep.Prop['cache']);
{$IFDEF DELPHI6}
          reportRec.Groups.DelimitedText := xmlRep.Prop['groups'];
{$ELSE}
          reportRec.Groups.Text := xmlRep.Prop['groups'];
{$ENDIF}
        end;
      end;
    finally
      xml.Free;
    end;
  finally
    ReportsListCS.Leave;
  end;
end;

procedure TfrxServerReportsList.GetReports4Group(const GroupName: String;
  var Html, Lines: AnsiString);
var
  FTemplate: TfrxServerTemplate;
  s, t: String;
  i: Integer;

begin
  ReportsListCS.Enter;
  try
    FTemplate := TfrxServerTemplate.Create;
    try
      FTemplate.SetTemplate('list_begin');
      FTemplate.Prepare;

{$IFDEF DELPHI12}
      Html := UTF8Encode(FTemplate.TemplateStrings.Text);
{$ELSE}
      Html := AnsiString(FTemplate.TemplateStrings.Text);
{$ENDIF}
      FTemplate.Clear;
      s := '';
      t := '';
      for i := 0 to Count - 1 do
      begin
        if (GroupName = '') or (Items[i].Groups.Count = 0) or (Items[i].Groups.IndexOf(GroupName) <> -1) then
        begin
          if Pos(PathDelim, Items[i].FileName) > 0 then
          begin
            s := StringReplace(StringReplace(Items[i].FileName,
                 ExtractFileName(Items[i].FileName), '',
                 [rfReplaceAll]), PathDelim, ' ', [rfReplaceAll]);
            if s <> t then
            begin
              FTemplate.SetTemplate('list_header');
              FTemplate.Variables.AddVariable('HEADER', s);
              FTemplate.Prepare;
{$IFDEF DELPHI12}
              Html := Html + UTF8Encode(FTemplate.TemplateStrings.Text);
{$ELSE}
              Html := Html + AnsiString(FTemplate.TemplateStrings.Text);
{$ENDIF}
              FTemplate.Clear;
              t := s;
            end;
          end;
          FTemplate.SetTemplate('list_line');
          FTemplate.Variables.AddLinkVariable('FILE', items[i].FileName);
          FTemplate.Variables.AddVariable('NAME', items[i].ReportName);
          FTemplate.Variables.AddVariable('DESCRIPTION', Items[i].Description);
          FTemplate.Prepare;
{$IFDEF DELPHI12}
          Html := Html + UTF8Encode(FTemplate.TemplateStrings.Text);
{$ELSE}
          Html := Html + AnsiString(FTemplate.TemplateStrings.Text);
{$ENDIF}
          FTemplate.Clear;
{$IFDEF DELPHI12}
          Lines := Lines + UTF8Encode(items[i].ReportName) + #13#10;
          Lines := Lines + UTF8Encode(items[i].FileName) + #13#10;
          Lines := Lines + UTF8Encode(StringReplace(items[i].Description, #13#10, ' ', [rfReplaceAll])) + #13#10;
{$ELSE}
          Lines := Lines + AnsiString(items[i].ReportName) + #13#10;
          Lines := Lines + AnsiString(items[i].FileName) + #13#10;
          Lines := Lines + AnsiString(StringReplace(items[i].Description, #13#10, ' ', [rfReplaceAll])) + #13#10;
{$ENDIF}
        end;
      end;
      FTemplate.SetTemplate('list_end');
      FTemplate.Prepare;
{$IFDEF DELPHI12}
      Html := Html +  UTF8Encode(FTemplate.TemplateStrings.Text);
{$ELSE}
      Html := Html +  AnsiString(FTemplate.TemplateStrings.Text);
{$ENDIF}
    finally
      FTemplate.Free;
    end;
  finally
    ReportsListCS.Leave;
  end;
end;

constructor TfrxServerReportsList.Create;
begin
  inherited Create(TfrxServerReportsListItem);
  ReportsPath := '';
end;

destructor TfrxServerReportsList.Destroy;
begin
  Clear;
  inherited;
end;

function TfrxServerReportsList.GetCacheLatency(
  const FileName: String): Integer;
var
  i: Integer;
begin
  Result := StrToInt(ServerConfig.GetValue('server.cache.defaultlatency'));
  for i := 0 to Count - 1 do
    if Items[i].FileName = FileName then
    begin
      Result := Items[i].CacheLatency;
      break;
    end;
end;

function TfrxServerReportsList.GetGroupMembership(const FileName,
  Group: String): boolean;
var
  i: Integer;
begin
  if Group = '' then
    Result := true
  else
  begin
    Result := false;
    for i := 0 to Count - 1 do
      if Items[i].FileName = FileName then
      begin
        if Items[i].Groups.Count > 0 then
          Result := Items[i].Groups.IndexOf(Group) <> -1
        else
          Result := true;
        break;
      end;
  end;
end;

function TfrxServerReportsList.GetItem(
  Name: String): TfrxServerReportsListItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Items[i].FileName = Name then
    begin
      Result := Items[i];
      break;
    end;
end;

function TfrxServerReportsList.GetItems(Index: Integer): TfrxServerReportsListItem;
begin
  Result := TfrxServerReportsListItem(inherited Items[Index]);
end;

{ TfrxServerReportsListItem }

constructor TfrxServerReportsListItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FCacheLatency := StrToInt(ServerConfig.GetValue('server.cache.defaultlatency'));
  FGroups := TStringList.Create;
{$IFDEF DELPHI6}
  FGroups.Delimiter := ';';
{$ENDIF}  
end;

destructor TfrxServerReportsListItem.Destroy;
begin
  FGroups.Free;
  inherited;
end;

initialization
  ReportsListCS := TCriticalSection.Create;

finalization
  ReportsListCS.Free;

end.
