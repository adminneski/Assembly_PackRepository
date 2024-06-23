
{******************************************}
{                                          }
{             FastReport VCL               }
{        Report Server Configurator        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerConfig;

{$I frx.inc}

interface

{$R frxServerConfig.res}

uses
  {$IFNDEF Linux}
  Windows,
  {$ELSE}
  LCLType, LCLIntf, LazHelper, Types,
  {$ENDIF}
  Classes, SysUtils, SyncObjs, 
  frCore, frXML, frxUtils,
  frxServerUtils, inifiles, frxServerLog;

type
  TfrxConfig = class (TObject)
  private
    FXML: TfrXMLDocument;
    FErrors: TStrings;
    FLines: TStringList;
    FCS: TCriticalSection;
    FFileName: String;
    FConfigFolder: String;
    procedure UpdateLines;
    procedure AddLine(const Name: String; const Value: String; XMLItem: TfrXMLItem);
    function GetCount: Integer;
  public
    ServerMessage: String;
    constructor Create;
    destructor Destroy; override;
    function LoadFromStream(Stream: TStream): HRESULT;
    function SaveToStream(Stream: TStream): HRESULT;
    function LoadFromFile(const FileName: String): HRESULT;
    function SaveToFile(const FileName: String): HRESULT;
    function GetValue(const Name: String): String;
    function GetNumber(const Name: String): Integer;
    function GetBool(const Name: String): Boolean;
    function CheckValue(const Name: String; const Current: String): String;
    procedure SetValue(const Name: String; const Value: String);
    procedure SetBool(const Name: String; const Value: Boolean);
    procedure Clear;
    procedure ConfigListToFile(const FileName: String);
    procedure Reload;

    property Lines: TStringList read FLines;
    property XML: TfrXMLDocument read FXML;
    property Count: Integer read GetCount;
    property ConfigFolder: String read FConfigFolder write FConfigFolder;
  end;

  TfrxConfigItem = class (TObject)
  private
    FValue: String;
    FXMLItem: TfrXMLItem;
  public
    property Value: String read FValue write FValue;
    property XMLItem: TfrXMLItem read FXMLItem write FXMLItem;
  end;

  TfrxServerConfig = class(TPersistent)
  private
    FGzip: Boolean;
    FIndexFileName: String;
    FLogging: Boolean;
    FLogin: String;
    FLogPath: String;
    FMIC: Boolean;
    FNoCacheHeader: Boolean;
    FOutputFormats: TfrxServerOutputFormats;
    FPassword: String;
    FPort: Integer;
    FReportPath: String;
    FRootPath: String;
    FSessionTimeOut: Integer;
    FSocketTimeOut: Integer;
    FReportCachePath: String;
    FDefaultCacheLatency: Integer;
    FReportCaching: Boolean;
    FMaxLogFiles: Integer;
    FMaxLogSize: Integer;
    FDatabase: String;
    FDatabaseLogin: String;
    FDatabasePassword: String;
    FReportsList: Boolean;
    FConfigFolder: String;
  public
    procedure LoadFromFile(const FileName: String);
    procedure SaveToFile(const FileName: String);
  published
    property Compression: Boolean read FGzip write FGzip;
    property IndexFileName: String read FIndexFileName write FIndexFileName;
    property Logging: Boolean read FLogging write FLogging;
    property MaxLogSize: Integer read FMaxLogSize write FMaxLogSize;
    property MaxLogFiles: Integer read FMaxLogFiles write FMaxLogFiles;
    property Login: String read FLogin write FLogin;
    property LogPath: String read FLogPath write FLogPath;
    property MIC: Boolean read FMIC write FMIC;
    property NoCacheHeader: Boolean read FNoCacheHeader write FNoCacheHeader;
    property OutputFormats: TfrxServerOutputFormats read FOutputFormats
      write FOutputFormats;
    property Password: String read FPassword write FPassword;
    property Port: Integer read FPort write FPort;
    property ReportPath: String read FReportPath write FReportPath;
    property ReportCachePath: String read FReportCachePath write FReportCachePath;
    property ReportCaching: Boolean read FReportCaching write FReportCaching;
    property DefaultCacheLatency: Integer read FDefaultCacheLatency write FDefaultCacheLatency;
    property RootPath: String read FRootPath write FRootPath;
    property SessionTimeOut: Integer read FSessionTimeOut write FSessionTimeOut;
    property SocketTimeOut: Integer read FSocketTimeOut write FSocketTimeOut;
    property Database: String read FDatabase write FDatabase;
    property DatabaseLogin: String read FDatabaseLogin write FDatabaseLogin;
    property DatabasePassword: String read FDatabasePassword write FDatabasePassword;
    property ReportsList: Boolean read FReportsList write FReportsList;
    property ConfigFolder: String read FConfigFolder write FConfigFolder;
  end;

var
   ServerConfig: TfrxConfig;

const
  FR_SERVER_CONFIG_VERSION = '2.4.0';

implementation

{ TfrxConfig }

procedure TfrxConfig.AddLine(const Name: String; const Value: String; XMLItem: TfrXMLItem);
var
  FValue: TfrxConfigItem;
  i: Integer;
begin
  i := FLines.IndexOf(LowerCase(Name));
  if i <> -1 then
  begin
    TfrxConfigItem(FLines.Objects[i]).Value := Value;
    TfrxConfigItem(FLines.Objects[i]).XMLItem := XMLItem;
  end
  else
  begin
    FValue := TfrxConfigItem.Create;
    FValue.Value := Value;
    FValue.XMLItem := XMLItem;
    FLines.AddObject(LowerCase(Name), FValue);
  end;
end;

function TfrxConfig.CheckValue(const Name, Current: String): String;
begin
  Result := GetValue(Name);
  if Result = '' then
    Result := Current;
end;

procedure TfrxConfig.Clear;
var
  i: Integer;
begin
  for i:= 0 to FLines.Count - 1 do
    TfrxConfigItem(FLines.Objects[i]).Free;
  FLines.Clear;
end;

procedure TfrxConfig.ConfigListToFile(const FileName: String);
var
  f: TFileStream;
  s: String;
  i: Integer;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    for i := 0 to FLines.Count - 1 do
    begin
      s := FLines[i] + ' = ' + TfrxConfigItem(FLines.Objects[i]).Value + #13#10;
      f.Write(s[1], Length(s));
    end;
  finally
    f.Free;
  end;
end;

constructor TfrxConfig.Create;
begin
  FCS := TCriticalSection.Create;
  FXML := TfrXMLDocument.Create;
  FXML.AutoIndent := True;
  FErrors := TStringList.Create;
  FLines := TStringList.Create;
  FLines.Sorted := True;
  FConfigFolder := frGetAppPath;
end;

destructor TfrxConfig.Destroy;
begin
  Clear;
  FLines.Free;
  FErrors.Free;
  FXML.Free;
  FCS.Free;
  inherited;
end;

function TfrxConfig.GetBool(const Name: String): Boolean;
begin
  Result := GetValue(Name) = 'yes';
end;

function TfrxConfig.GetCount: Integer;
begin
  Result := FLines.Count;
end;

function TfrxConfig.GetNumber(const Name: String): Integer;
var
  s: String;
begin
  s := GetValue(Name);
  if s = '' then
    Result := 0
  else
    Result := StrToInt(s);
end;

function TfrxConfig.GetValue(const Name: String): String;
var
  i: Integer;
begin
  FCS.Enter;
  try
    i := FLines.IndexOf(LowerCase(Name));
    if i <> -1 then
      {$IFNDEF Linux}
      Result := TfrxConfigItem(FLines.Objects[i]).Value
      {$ELSE}
      Result := StringReplace(TfrxConfigItem(FLines.Objects[i]).Value, '\', '/',[rfReplaceAll])
      {$ENDIF}
    else
      Result := '';
  finally
    FCS.Leave;
  end;
end;

function TfrxConfig.LoadFromFile(const FileName: String): HRESULT;
var
  f: TFileStream;
//  frc: TResourceStream;
begin
  FCS.Enter;
  try
    //try
    //  frc := TResourceStream.Create(HInstance, 'TfrxConfig', RT_RCDATA);
    //  try
    //    Result := LoadFromStream(frc);
    //  finally
    //    frc.Free;
    //  end;
    //except
    //  Result := E_FAIL;
    //end;
    if FileExists(FileName) then
    begin
      try
        f := TFileStream.Create(FileName, fmOpenRead + fmShareDenyWrite);
        try
          Result := LoadFromStream(f);
          FFileName := FileName;
        finally
          f.Free;
        end;
      except
        Result := E_FAIL;
      end;
    end
    else
      Result := E_FAIL;
  finally
    FCS.Leave;
  end;
end;

function TfrxConfig.LoadFromStream(Stream: TStream): HRESULT;
begin
  Result := S_OK;
  FCS.Enter;
  try
    try
      FXML.LoadFromStream(Stream);
      UpdateLines;
    except
      Result := E_FAIL;
    end;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxConfig.Reload;
begin
  LoadFromFile(FFileName);
end;

function TfrxConfig.SaveToFile(const FileName: String): HRESULT;
var
  f: TFileStream;
begin
  try
    f := TFileStream.Create(FileName, fmCreate);
    try
      Result := SaveToStream(f);
      FFileName := FileName;
    finally
      f.Free;
    end;
  except
    Result := E_FAIL;
  end;
end;

function TfrxConfig.SaveToStream(Stream: TStream): HRESULT;
begin
  Result := S_OK;
  FCS.Enter;
  try
    try
      FXML.Root.Prop['configversion'] := FR_SERVER_CONFIG_VERSION;
      FXML.SaveToStream(Stream);
      UpdateLines;
    except
      Result := E_FAIL;
    end;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxConfig.SetBool(const Name: String; const Value: Boolean);
begin
  if Value then
    SetValue(Name, 'yes')
  else
    SetValue(Name, 'no');
end;

procedure TfrxConfig.SetValue(const Name, Value: String);
var
  i: Integer;
begin
  i := FLines.IndexOf(Name);
  if (i <> -1) and (FLines.Objects[i] <> nil) then
  begin
    TfrxConfigItem(FLines.Objects[i]).Value := Value;
    if TfrxConfigItem(FLines.Objects[i]).XMLItem.Name = 'set' then
      TfrxConfigItem(FLines.Objects[i]).XMLItem.Prop['value'] := Value;
  end;
end;

procedure TfrxConfig.UpdateLines;

  procedure AddItemToLines(const Prefix: String; Item: TfrXMLItem);
  var
    s: String;
    i: Integer;
  begin
    if Item <> nil then
    begin
      s := Prefix;
      if s = '' then
        s := Item.Name
      else if Item.PropExists('desc') and (Item.Name <> 'set') then
        s :=  s + '.' + Item.Name;
      if Item.Name = 'set' then
        AddLine(s + '.' + Item.Prop['name'], Item.Prop['value'], Item)
      else
      begin
        if Item.PropExists('name') then
          AddLine(s + '.name', Item.Prop['name'], Item);
        for i := 0 to Item.Count - 1 do
          AddItemToLines(s, Item.Items[i]);
      end;
    end;
  end;

begin
  //Clear;
  AddLine('configversion', FXML.Root.Prop['configversion'], nil);
  AddItemToLines('', FXML.Root.FindItem('server'));
end;

{ TfrxServerConfig }

procedure TfrxServerConfig.LoadFromFile(const FileName: String);
var
  Ini: TIniFile;
begin
// compatibility code
  if FileExists(FileName) then
  begin
    LogWriter.Write(SERVER_LEVEL, 'Borrow old-style config. You should delete the file ' + FileName + ' after this launch.');
    Ini := TIniFile.Create(FileName);
    try
      Port := Ini.ReadInteger('Server', 'Port', 8097);
      ServerConfig.SetValue('server.http.port', IntToStr(Port));

      SessionTimeOut := Ini.ReadInteger('Server', 'SessionTimeOut', 300);
      ServerConfig.SetValue('server.http.sessiontimeout', IntToStr(SessionTimeOut));

      SocketTimeOut := Ini.ReadInteger('Server', 'SocketTimeOut', 300);
      ServerConfig.SetValue('server.http.sockettimeout', IntToStr(SocketTimeOut));

      IndexFileName := Ini.ReadString('Server', 'IndexFileName', 'index.html');
      ServerConfig.SetValue('server.http.indexfile', IndexFileName);

      LogPath := frxGetAbsPath(Ini.ReadString('Server', 'LogPath', 'logs'));
      ServerConfig.SetValue('server.logs.path', frxGetRelPath(LogPath));

      ReportPath := frxGetAbsPath(Ini.ReadString('Server', 'ReportPath', 'reports'));
      ServerConfig.SetValue('server.reports.path', frxGetRelPath(ReportPath));

      RootPath := frxGetAbsPath(Ini.ReadString('Server', 'RootPath', 'htdocs'));
      ServerConfig.SetValue('server.http.rootpath', frxGetRelPath(RootPath));

      NoCacheHeader := Ini.ReadBool('Server', 'NoCacheHeader', True);
      ServerConfig.SetBool('server.http.nocacheheader', NoCacheHeader);

      Compression := Ini.ReadBool('Server', 'Compression', True);
      ServerConfig.SetBool('server.http.compression', Compression);

      Login := Ini.ReadString('Server', 'Login', '');
      ServerConfig.SetValue('server.security.login', Login);

      Password := Ini.ReadString('Server', 'Password', '');
      ServerConfig.SetValue('server.security.password', Password);

      MIC := Ini.ReadBool('Server', 'MessageIntegrityCheck', True);
      ServerConfig.SetBool('server.http.mic', MIC);

      ReportsList := Ini.ReadBool('Server', 'ReportsList', True);
      ServerConfig.SetBool('server.security.reportslist', ReportsList);

      Logging := Ini.ReadBool('Server', 'WriteLogs', False);
      ServerConfig.SetBool('server.logs.active', Logging);

      MaxLogSize := Ini.ReadInteger('Server', 'MaxLogSize', 1024);
      ServerConfig.SetValue('server.logs.rotatesize', IntToStr(MaxLogSize));

      MaxLogFiles := Ini.ReadInteger('Server', 'MaxLogFiles', 5);
      ServerConfig.SetValue('server.logs.rotatefiles', IntToStr(MaxLogFiles));

      ReportCaching := Ini.ReadBool('ReportsCache', 'Enabled', False);
      ServerConfig.SetBool('server.cache.active', ReportCaching);

      ReportCachePath := frxGetAbsPath(Ini.ReadString('ReportsCache', 'CachePath', 'cache'));
      ServerConfig.SetValue('server.cache.path', frxGetRelPath(ReportCachePath));

      DefaultCacheLatency := Ini.ReadInteger('ReportsCache', 'DefaultLatency', 300);
      ServerConfig.SetValue('server.cache.defaultlatency', IntToStr(DefaultCacheLatency));


      Database :=  frxGetAbsPath(Ini.ReadString('Database', 'Connection', ''));
      ServerConfig.SetValue('server.database.pathtodatabase', frxGetRelPath(Database));
      ServerConfig.SaveToFile(frxGetAbsPath('config.xml'));
      ServerConfig.ServerMessage := 'Please restart server!';
    finally
      Ini.Free;
    end;
  end;
end;

procedure TfrxServerConfig.SaveToFile(const FileName: String);
begin
// compatibility code
  ServerConfig.SaveToFile(FileName);
end;

initialization
  ServerConfig := TfrxConfig.Create;

finalization
  ServerConfig.Free;

end.
