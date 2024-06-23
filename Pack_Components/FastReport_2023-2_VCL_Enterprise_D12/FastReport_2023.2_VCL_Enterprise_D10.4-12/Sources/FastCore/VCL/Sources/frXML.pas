
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{               XML document               }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frXML;
{$ENDIF}

interface

{$I frVer.inc}

uses
{$IFNDEF FMX}
  {$IFNDEF FPC} Windows, Variants, {$ELSE} LazFileUtils, LCLProc, {$ENDIF}
  Types, Math, SysUtils, Classes, frCore;
{$ELSE}
  System.Classes, System.SysUtils, System.Types, System.IOUtils, System.Math, System.Variants,
  FMX.frCore;
{$ENDIF}

type
  TfrInvalidXMLException = class(Exception);

  TfrXMLItem = class(TObject)
  private
    FData: Pointer;              { optional item data }
{$IFDEF FR_XML_LOW_MEM_USAGE}
    FHiOffset: Byte;             { hi-part of the offset }
    FLoOffset: Integer;          { lo-part of the offset }
{$ELSE}
    FOffset: Int64;
{$ENDIF}
    FLoaded: Boolean;            { item is loaded, no need to call LoadItem }
    FModified: Boolean;          { item is modified (used by preview designer) }
    FName: string;               { item name }
    FParent: TfrXMLItem;        { item parent }
    FText: string;               { item attributes }
    FUnloadable: Boolean;
    FValue: string;              { item value <item>Value</item> }
    function GetCount: Integer;
    function GetItems(Index: Integer): TfrXMLItem;
    function GetOffset: Int64;
    procedure SetOffset(const Value: Int64);
    function GetProp(APropertyName: string): string;
    procedure SetProp(APropertyName: string; const AValue: string);
    function GetPropAsFloat(APropertyName: string): Double;
    procedure SetPropAsFloat(APropertyName: string; const Value: Double);
    function GetPropAsBoolean(APropertyName: string): Boolean;
    procedure SetPropAsBoolean(APropertyName: string; const Value: Boolean);
    function GetPropAsInteger(APropertyName: string): Integer;
    procedure SetPropAsInteger(APropertyName: string; const Value: Integer);
    function GetPropAsDateTime(APropertyName: string): TDateTime;
    function GetPropAsInt64(APropertyName: string): Int64;
    procedure SetPropAsDateTime(APropertyName: string; const Value: TDateTime);
    procedure SetPropAsInt64(APropertyName: string; const Value: Int64);
  protected
    FItems: TList;               { subitems }
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddItem(Item: TfrXMLItem); virtual;
    procedure Clear;
    procedure InsertItem(Index: Integer; Item: TfrXMLItem);

    function Add: TfrXMLItem; overload;
    function Add(Name: string): TfrXMLItem; overload;
    function Find(const Name: string): Integer;
    function FindItem(const Name: string): TfrXMLItem;
    function IndexOf(Item: TfrXMLItem): Integer;
    function PropExists(const Index: string): Boolean;
    function Root: TfrXMLItem;
    procedure DeleteProp(const Index: string);
    procedure SetData(const AName, AText, AValue: string); virtual;

    property Count: Integer read GetCount;
    property Data: Pointer read FData write FData;
    property Items[Index: Integer]: TfrXMLItem read GetItems; default;
    property Loaded: Boolean read FLoaded;
    property Modified: Boolean read FModified write FModified;
    property Name: string read FName write FName;
{ offset is the position of the item in the tempstream. This parameter is needed
  for dynamically loading large files. Items that can be loaded on-demand must
  have Unloadable = True (in run-time) or have 'ld="0"' parameter (in the file) }
    property Offset: Int64 read GetOffset write SetOffset;
    property Parent: TfrXMLItem read FParent;
    property Prop[APropertyName: string]: string read GetProp write SetProp; // for backward capatibility
    property PropAsBoolean[APropertyName: string]: Boolean read GetPropAsBoolean write SetPropAsBoolean;
    property PropAsDateTime[APropertyName: string]: TDateTime read GetPropAsDateTime write SetPropAsDateTime;
    property PropAsFloat[APropertyName: string]: Double read GetPropAsFloat write SetPropAsFloat;
    property PropAsInt[APropertyName: string]: Integer read GetPropAsInteger write SetPropAsInteger;
    property PropAsInt64[APropertyName: string]: Int64 read GetPropAsInt64 write SetPropAsInt64;
    property PropAsText[APropertyName: string]: string read GetProp write SetProp;
//    property PropAsFloat[Index: string]: string read GetPropAsFloat write SetPropAsFloat;
    property Text: string read FText write FText;
    property Unloadable: Boolean read FUnloadable write FUnloadable;
    property Value: string read FValue write FValue;
  end;

  TfrXMLDocument = class(TObject)
  private
    FAutoIndent: Boolean;        { use indents when writing document to a file }
    FTempDir: string;            { folder for temporary files }
    FTempFile: string;           { tempfile name }
    FTempFileCreated: Boolean;   { tempfile has been created - need to delete it }
    procedure CreateTempFile;
  protected
    FRoot: TfrXMLItem;          { root item }
    FTempStream: TStream;        { temp stream associated with tempfile }
    FOldVersion: Boolean;
    procedure DeleteTempFile;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure LoadItem(Item: TfrXMLItem);
    procedure UnloadItem(Item: TfrXMLItem);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream; AllowPartialLoading: Boolean = False);
    procedure SaveToFile(const FileName: string);
    procedure LoadFromFile(const FileName: string);

    property AutoIndent: Boolean read FAutoIndent write FAutoIndent;
    property Root: TfrXMLItem read FRoot;
    property TempDir: string read FTempDir write FTempDir;
    property OldVersion: Boolean read FOldVersion;
  end;

{ TfrXMLReader and TfrXMLWriter are doing actual read/write to the XML file.
  Read/write process is buffered. }

  TfrXMLReader = class(TObject)
  private
    FBuffer: PAnsiChar;
    FBufPos: Integer;
    FBufEnd: Integer;
    FPosition: Int64;
    FSize: Int64;
    FStream: TStream;
    FOldFormat: Boolean;
    procedure SetPosition(const Value: Int64);
    procedure ReadBuffer;
  protected
    procedure ReadItem(var {$IFDEF DELPHI12}NameS{$ELSE}Name{$ENDIF}, Text, Value: string); overload;
    procedure ReadItem(var Name, Text: string); overload;
    function EndOfStream: Boolean;
    function ReadFromBuffer: Integer;
  public
    constructor Create(Stream: TStream);
    destructor Destroy; override;
    procedure RaiseException;
    procedure ReadHeader;
    procedure ReadRootItem(AItem: TfrXMLItem; AReadChildren: Boolean = True);
    property Position: Int64 read FPosition write SetPosition;
    property Size: Int64 read FSize;
    property OldFormat: Boolean read FOldFormat;
  end;

  TfrXMLWriter = class(TObject)
  private
    FAutoIndent: Boolean;
    FBuffer: AnsiString;
    FStream: TStream;
    FTempStream: TStream;
    procedure FlushBuffer;
    procedure WriteLn(const s: AnsiString);
    procedure WriteItem(Item: TfrXMLItem; Level: Integer = 0);
  public
    constructor Create(Stream: TStream);
    procedure WriteHeader;
    procedure WriteRootItem(RootItem: TfrXMLItem);
    property TempStream: TStream read FTempStream write FTempStream;
    property AutoIndent: Boolean read FAutoIndent write FAutoIndent;
  end;

  { TfrValuedXMLReader }

  TfrValuedXMLReader = class(TfrXMLReader)
  protected
    function IsLastSlash(const InSt: String): Boolean;
    function IsFirstSlash(const InSt: String): Boolean;
    function IsFirstNumberSign(const InSt: String): Boolean;
    procedure ReadValuedItem(out {$IFDEF Delphi12}NameS, ValueS{$ELSE}Name, Value{$ENDIF}, Text: String); virtual;
    procedure ProcessSecondLeftBrocket; virtual; abstract;
    function CreateItem: TfrXMLItem; virtual;
    procedure AddChar(var st: AnsiString; var stPos: Integer; ch: AnsiChar);
  public
    function IsReadValuedXMLRootItem(Item: TfrXMLItem): Boolean;
    function IsReadValuedXMLItem(Item: TfrXMLItem): Boolean;
  end;

  { TfrValuedXMLDocument }

  TfrValuedXMLDocument = class(TfrXMLDocument)
  protected
    FValuedXMLStream: TStream;
    FValuedXMLStreamReader: TfrValuedXMLReader;

    procedure ReadXMLHeader; virtual; abstract;
    function CreateReader: TfrValuedXMLReader; virtual; abstract;
  public
    procedure InitValuedXMLFile(const FileName: String);
    procedure DoneValuedXMLFile;
    function IsReadItem(Item: TfrXMLItem): Boolean;
  end;

{ StrToXML changes '<', '>', '"', cr, lf symbols to its ascii codes }
function frxStrToXML(const s: string): string;

{ ValueToXML convert a value to the valid XML string }
function frxValueToXML(const Value: Variant): string;

{ XMLToStr is opposite to StrToXML function }
function frxXMLToStr(const s: string): string;

function frXMLStrToWStr(const AValue: string; AOldVersion: Boolean): WideString;
//function frUTF8Decode(const AValue: ): WideString;

implementation

uses
  StrUtils;

var
  XMLDefaultFormatSettings: TFormatSettings;

function frxStrToXML(const s: string): string;
const
  SpecChars = ['<', '>', '"', #10, #13, '&', Char(0)];
var
  i, lenRes, resI, ch: Integer;
  pRes: PChar;

  procedure ReplaceChars(var s: string; i: Integer);
  begin
    Insert('#' + IntToStr(Ord(s[i])) + ';', s, i + 1);
    s[i] := '&';
  end;

begin
  lenRes := Length(s);

  if lenRes < 32 then
  begin
    Result := s;
    for i := lenRes downto 1 do
{$IFDEF DELPHI12}
      if CharInSet(s[i], SpecChars) then
{$ELSE}
      if s[i] in SpecChars then
{$ENDIF}
        if s[i] <> '&' then
          ReplaceChars(Result, i)
        else
        begin
          if Copy(s, i + 1, 5) = 'quot;' then
          begin
            Delete(Result, i, 6);
            Insert('&#34;', Result, i);
          end
          else 
		  //if (i = lenRes) or (s[i + 1] <> '#') then
            ReplaceChars(Result, i);
        end;
    Exit;
  end;

  { speed optimized code }
  SetLength(Result, lenRes);
  pRes := PChar(Result) - 1;
  resI := 1;
  i := 1;

  while i <= Length(s) do
  begin
    if resI + 5 > lenRes then
    begin
      Inc(lenRes, 256);
      SetLength(Result, lenRes);
      pRes := PChar(Result) - 1;
    end;

{$IFDEF DELPHI12}
    if CharInSet(s[i], SpecChars) then
{$ELSE}
    if s[i] in SpecChars then
{$ENDIF}
    begin
      if (s[i] = '&') and (i <= Length(s) - 5) and (s[i + 1] = 'q') and
        (s[i + 2] = 'u') and (s[i + 3] = 'o') and (s[i + 4] = 't') and (s[i + 5] = ';') then
      begin
        pRes[resI] := '&';
        pRes[resI + 1] := '#';
        pRes[resI + 2] := '3';
        pRes[resI + 3] := '4';
        pRes[resI + 4] := ';';
        Inc(resI, 4);
        Inc(i, 5);
      end
      else if s[i] = #0 then
        pRes[resI] := ' '
      else
      begin
        pRes[resI] := '&';
        pRes[resI + 1] := '#';

        ch := Ord(s[i]);
        if ch < 10 then
        begin
          pRes[resI + 2] := Char(Chr(ch + $30));
          Inc(resI, 3);
        end
        else if ch < 100 then
        begin
          pRes[resI + 2] := Char(Chr(ch div 10 + $30));
          pRes[resI + 3] := Char(Chr(ch mod 10 + $30));
          Inc(resI, 4);
        end
        else
        begin
          pRes[resI + 2] := Char(Chr(ch div 100 + $30));
          pRes[resI + 3] := Char(Chr(ch mod 100 div 10 + $30));
          pRes[resI + 4] := Char(Chr(ch mod 10 + $30));
          Inc(resI, 5);
        end;
        pRes[resI] := ';';
      end;
    end
    else
      pRes[resI] := s[i];
    Inc(resI);
    Inc(i);
  end;

  SetLength(Result, resI - 1);
end;

function frxXMLToStr(const s: string): string;
var
  i, j, h, n: Integer;
begin
  Result := s;
  i := 1;
  n := Length(s);
  while i < n do
  begin
    if Result[i] = '&' then
      if (i + 3 <= n) and (Result[i + 1] = '#') then
      begin
        j := i + 3;
        while Result[j] <> ';' do
          Inc(j);
        h := StrToInt(Copy(Result, i + 2, j - i - 2));
        Delete(Result, i, j - i);
        Result[i] := Char(Chr(h));
        Dec(n, j - i);
      end
      else if Copy(Result, i + 1, 5) = 'quot;' then
      begin
        Delete(Result, i, 5);
        Result[i] := '"';
        Dec(n, 5);
      end
      else if Copy(Result, i + 1, 4) = 'amp;' then
      begin
        Delete(Result, i, 4);
        Result[i] := '&';
        Dec(n, 4);
      end
      else if Copy(Result, i + 1, 3) = 'lt;' then
      begin
        Delete(Result, i, 3);
        Result[i] := '<';
        Dec(n, 3);
      end
      else if Copy(Result, i + 1, 3) = 'gt;' then
      begin
        Delete(Result, i, 3);
        Result[i] := '>';
        Dec(n, 3);
      end;
    Inc(i);
  end;
end;

function frxValueToXML(const Value: Variant): string;
begin
  case TVarData(Value).VType of
    varSmallint, varInteger, varByte:
      Result := IntToStr(Value);

    varSingle, varDouble, varCurrency:
      Result := FloatToStr(Value);

    varDate:
      Result := DateToStr(Value);

    varOleStr, varString, varVariant{$IFDEF DELPHI12}, varUString{$ENDIF}:
      Result := frxStrToXML(Value);

    varBoolean:
      if Value = True then Result := '1' else Result := '0';

    else
      Result := '';
  end;
end;

function frXMLStrToWStr(const AValue: string; AOldVersion: Boolean): WideString;
begin
{$IFNDEF FPC}
  if not AOldVersion then
    Result := AValue
  else
    Result := UTF8Decode(AnsiString(AValue))
{$ELSE}
  Result := frStrToWStr(AnsiString(AValue));
{$ENDIF}
end;

{ TfrXMLItem }

constructor TfrXMLItem.Create;
begin
  FLoaded := True;
end;

destructor TfrXMLItem.Destroy;
begin
  Clear;
  if FParent <> nil then
    FParent.FItems.Remove(Self);
  inherited;
end;

procedure TfrXMLItem.Clear;
begin
  if FItems <> nil then
  begin
    while FItems.Count > 0 do
      TfrXMLItem(FItems[0]).Free;
    FItems.Free;
    FItems := nil;
  end;
  if FUnloadable then
    FLoaded := False;
end;

function TfrXMLItem.GetItems(Index: Integer): TfrXMLItem;
begin
  Result := TfrXMLItem(FItems[Index]);
end;

function TfrXMLItem.GetCount: Integer;
begin
  if FItems = nil then
    Result := 0 else
    Result := FItems.Count;
end;

function TfrXMLItem.Add: TfrXMLItem;
begin
  Result := TfrXMLItem.Create;
  AddItem(Result);
end;

function TfrXMLItem.Add(Name: string): TfrXMLItem;
begin
  Result := Add;
  Result.Name := Name;
end;

procedure TfrXMLItem.AddItem(Item: TfrXMLItem);
begin
  if FItems = nil then
    FItems := TList.Create;

  FItems.Add(Item);
  if Item.FParent <> nil then
    Item.FParent.FItems.Remove(Item);
  Item.FParent := Self;
end;

procedure TfrXMLItem.InsertItem(Index: Integer; Item: TfrXMLItem);
begin
  AddItem(Item);
  FItems.Delete(FItems.Count - 1);
  FItems.Insert(Index, Item);
end;

function TfrXMLItem.Find(const Name: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, Name) = 0 then
    begin
      Result := i;
      break;
    end;
end;

function TfrXMLItem.FindItem(const Name: string): TfrXMLItem;
var
  i: Integer;
begin
  i := Find(Name);
  if i = -1 then
  begin
    Result := Add;
    Result.Name := Name;
  end
  else
    Result := Items[i];
end;

function TfrXMLItem.GetOffset: Int64;
begin
{$IFDEF FR_XML_LOW_MEM_USAGE}
  Result := Int64(FHiOffset) * $100000000 + Int64(FLoOffset);
{$ELSE}
  Result := FOffset;
{$ENDIF}
end;

procedure TfrXMLItem.SetData(const AName, AText, AValue: string);
begin
  FName := AName;
  FText := AText;
  FValue := AValue;
end;

procedure TfrXMLItem.SetOffset(const Value: Int64);
begin
{$IFDEF FR_XML_LOW_MEM_USAGE}
  FHiOffset := Value div $100000000;
  FLoOffset := Value mod $100000000;
{$ELSE}
  FOffset := Value;
{$ENDIF}
end;

function TfrXMLItem.Root: TfrXMLItem;
begin
  Result := Self;
  while Result.Parent <> nil do
    Result := Result.Parent;
end;

function TfrXMLItem.GetProp(APropertyName: string): string;
var
  i: Integer;
begin
  i := Pos(' ' + AnsiUppercase(APropertyName) + '="', AnsiUppercase(' ' + FText));
  if i <> 0 then
  begin
{$IFDEF DELPHI12}
    Result := Copy(FText, i + Length(APropertyName + '="'), MaxInt);
{$ELSE}
    Result := Copy(FText, i + Length(APropertyName + '="'), MaxInt);
{$ENDIF}
    Result := frxXMLToStr(Copy(Result, 1, Pos('"', Result) - 1));
  end
  else
    Result := '';
end;

procedure TfrXMLItem.SetProp(APropertyName: string; const AValue: string);
var
  i, j: Integer;
  s: string;
begin
  i := Pos(' ' + AnsiUppercase(APropertyName) + '="', AnsiUppercase(' ' + FText));
  if i <> 0 then
  begin
    j := i + Length(APropertyName + '="');
    while (j <= Length(FText)) and (FText[j] <> '"') do
      Inc(j);
    Delete(FText, i, j - i + 1);
  end
  else
    i := Length(FText) + 1;

  s := APropertyName + '="' + frxStrToXML(AValue) + '"';
  if (i > 1) and (FText[i - 1] <> ' ') then
    s := ' ' + s;
  Insert(s, FText, i);
end;

function TfrXMLItem.GetPropAsBoolean(APropertyName: string): Boolean;
begin
  Result := StrToBoolDef(GetProp(APropertyName), False);
end;

function TfrXMLItem.GetPropAsDateTime(APropertyName: string): TDateTime;
begin
  Result := StrToDateTimeDef(GetProp(APropertyName), 0, XMLDefaultFormatSettings);
end;

function TfrXMLItem.GetPropAsFloat(APropertyName: string): Double;
begin
  Result := StrToFloatDef(GetProp(APropertyName), 0, XMLDefaultFormatSettings);
end;

function TfrXMLItem.GetPropAsInt64(APropertyName: string): Int64;
begin
  Result := StrToInt64Def(GetProp(APropertyName), 0);
end;

function TfrXMLItem.GetPropAsInteger(APropertyName: string): Integer;
begin
  Result := StrToIntDef(GetProp(APropertyName), 0)
end;

procedure TfrXMLItem.SetPropAsBoolean(APropertyName: string; const Value: Boolean);
begin
  SetProp(APropertyName, BoolToStr(Value));
end;

procedure TfrXMLItem.SetPropAsDateTime(APropertyName: string; const Value: TDateTime);
begin
  SetProp(APropertyName, DateTimeToStr(Value, XMLDefaultFormatSettings));
end;

procedure TfrXMLItem.SetPropAsFloat(APropertyName: string; const Value: Double);
begin
  SetProp(APropertyName, FloatToStr(Value, XMLDefaultFormatSettings));
end;

procedure TfrXMLItem.SetPropAsInt64(APropertyName: string; const Value: Int64);
begin
  SetProp(APropertyName, IntToStr(Value));
end;

procedure TfrXMLItem.SetPropAsInteger(APropertyName: string; const Value: Integer);
begin
  SetProp(APropertyName, IntToStr(Value));
end;

function TfrXMLItem.PropExists(const Index: string): Boolean;
begin
  Result := Pos(' ' + AnsiUppercase(Index) + '="', ' ' + AnsiUppercase(FText)) > 0;
end;

procedure TfrXMLItem.DeleteProp(const Index: string);
var
  i: Integer;
begin
  i := Pos(' ' + AnsiUppercase(Index) + '="', ' ' + AnsiUppercase(FText));
  if i > 0 then
  begin
    SetProp(Index, '');
    Delete(FText, i, Length(Index) + 4);
  end;
end;

function TfrXMLItem.IndexOf(Item: TfrXMLItem): Integer;
begin
  Result := FItems.IndexOf(Item);
end;


{ TfrXMLDocument }

constructor TfrXMLDocument.Create;
begin
  FRoot := TfrXMLItem.Create;
{$IFNDEF DELPHI12}
  FOldVersion := True;
{$ENDIF}
end;

destructor TfrXMLDocument.Destroy;
begin
  DeleteTempFile;
  FRoot.Free;
  inherited;
end;

procedure TfrXMLDocument.Clear;
begin
  FRoot.Clear;
  DeleteTempFile;
end;

procedure TfrXMLDocument.CreateTempFile;
begin
  if FTempFileCreated then Exit;
  FTempFile := frGetTempFileName(TempDir, 'fr');
  FTempStream := TFileStream.Create(FTempFile, fmOpenReadWrite);
  FTempFileCreated := True;
end;

procedure TfrXMLDocument.DeleteTempFile;
begin
  if FTempFileCreated then
  begin
    FTempStream.Free;
    FTempStream := nil;
    DeleteFile(FTempFile);
    FTempFileCreated := False;
  end;
  if FTempStream <> nil then
    FTempStream.Free;
  FTempStream := nil;
end;

procedure TfrXMLDocument.LoadItem(Item: TfrXMLItem);
var
  rd: TfrXMLReader;
  //Text: string;
begin
  if (FTempStream = nil) or Item.FLoaded or not Item.FUnloadable then Exit;

  rd := TfrXMLReader.Create(FTempStream);
  try
    rd.Position := Item.Offset;
    //Text := Item.Text;
    rd.ReadRootItem(Item, True);
    //Item.Text := Text;
    Item.FLoaded := True;
  finally
    rd.Free;
  end;
end;

procedure TfrXMLDocument.UnloadItem(Item: TfrXMLItem);
var
  wr: TfrXMLWriter;
begin
  if not Item.FLoaded or not Item.FUnloadable then Exit;

  CreateTempFile;
  FTempStream.Position := FTempStream.Size;
  wr := TfrXMLWriter.Create(FTempStream);
  try
    Item.Offset := FTempStream.Size;
    wr.WriteRootItem(Item);
    Item.Clear;
  finally
    wr.Free;
  end;
end;

procedure TfrXMLDocument.LoadFromStream(Stream: TStream;
  AllowPartialLoading: Boolean = False);
var
  rd: TfrXMLReader;
begin
  DeleteTempFile;

  rd := TfrXMLReader.Create(Stream);
  try
    FRoot.Clear;
    FRoot.Offset := 0;
    rd.ReadHeader;
    FOldVersion := rd.FOldFormat;
    rd.ReadRootItem(FRoot, not AllowPartialLoading);
  finally
    rd.Free;
  end;

  if AllowPartialLoading then
    FTempStream := Stream else
    FTempStream := nil;
end;

procedure TfrXMLDocument.SaveToStream(Stream: TStream);
var
  wr: TfrXMLWriter;
begin
  wr := TfrXMLWriter.Create(Stream);
  wr.TempStream := FTempStream;
  wr.FAutoIndent := FAutoIndent;

  try
    wr.WriteHeader;
    wr.WriteRootItem(FRoot);
  finally
    wr.Free;
  end;
end;

procedure TfrXMLDocument.LoadFromFile(const FileName: string);
var
  s: TFileStream;
begin
  s := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  LoadFromStream(s, True);
end;

procedure TfrXMLDocument.SaveToFile(const FileName: string);
var
  s: TFileStream;
begin
  s := TFileStream.Create(FileName + '.tmp', fmCreate);
  try
    SaveToStream(s);
  finally
    s.Free;
  end;

  DeleteTempFile;
  DeleteFile(FileName);
  RenameFile(FileName + '.tmp', FileName);
  LoadFromFile(FileName);
end;


{ TfrXMLReader }

constructor TfrXMLReader.Create(Stream: TStream);
begin
  FStream := Stream;
  FSize := Stream.Size;
  FPosition := Stream.Position;
  GetMem(FBuffer, 4096);
end;

destructor TfrXMLReader.Destroy;
begin
  FreeMem(FBuffer, 4096);
  FStream.Position := FPosition;
  inherited;
end;

function TfrXMLReader.EndOfStream: Boolean;
begin
  Result := FPosition >= FSize;
end;

procedure TfrXMLReader.ReadBuffer;
begin
  FBufEnd := FStream.Read(FBuffer^, 4096);
  FBufPos := 0;
end;

procedure TfrXMLReader.SetPosition(const Value: Int64);
begin
  FPosition := Value;
  FStream.Position := Value;
  FBufPos := 0;
  FBufEnd := 0;
end;

procedure TfrXMLReader.RaiseException;
begin
  raise TfrInvalidXMLException.Create('Invalid file format');
end;

function TfrXMLReader.ReadFromBuffer: Integer;
begin
  if FBufPos = FBufEnd then
    ReadBuffer;
  Result := Ord(FBuffer[FBufPos]);
  Inc(FBufPos);
  Inc(FPosition);
end;

procedure TfrXMLReader.ReadHeader;
var
  s1, s2: string;
  i: Integer;
  Ver: string;
begin
  ReadItem(s1, s2);
  if Pos('?xml', s1) <> 1 then
    RaiseException;
  i := Pos('version=', s2);
  if i <> 0 then
    Ver := Copy(s2, i + 9, 3);
  i := Pos('standalone=', s2);
  if (Ver = '1.0') and (i = 0) then
    FOldFormat := True;
end;

procedure TfrXMLReader.ReadItem(var {$IFDEF DELPHI12}NameS{$ELSE}Name{$ENDIF}, Text, Value: string);
var
  C: Integer;
  LCurentPosition, LNameLength: Integer;
  LState: (sFindLeft, sFindRight, sFindComment, sDone);
  I, LComment: Integer;
  PS: PAnsiChar;
{$IFDEF DELPHI12}
  Name: AnsiString;
{$ENDIF}
begin
  Text := '';
  LComment := 0;
  LState := sFindLeft;
  LCurentPosition := 0;
  LNameLength := 4096;
  SetLength(Name, LNameLength);
  PS := @Name[1];

  while (FPosition < FSize) do
  begin
    if (FBufPos = FBufEnd) then
      ReadBuffer;
    C := Ord(FBuffer[FBufPos]);
    Inc(FBufPos);
    Inc(FPosition);

    if (LState = sFindLeft) then
    begin
      if (C = Ord('<')) then
        LState := sFindRight
      else
        if (not (C in [9, 10, 11, 13, 32])) then
          Value := Value + chr(C);
    end
    else
    if (LState = sFindRight) then
    begin
      if (C = Ord('>')) then
      begin
        LState := sDone;
        break;
      end
      else
      if (C = Ord('<')) then
        RaiseException
      else
      begin
        PS[LCurentPosition] := AnsiChar(Chr(C));
        Inc(LCurentPosition);
{$IFDEF DELPHI12}
//        if (LCurentPosition = 3) and (Pos(AnsiString('!--'), Name) = 1) then
        if (LCurentPosition = 3) and (LNameLength >= 3) and (Name[1] = '!') and (Name[2] = '-') and (Name[3] = '-') then
{$ELSE}
        if (LCurentPosition = 3) and (Pos('!--', Name) = 1) then
{$ENDIF}
        begin
          LState := sFindComment;
          LComment := 0;
          LCurentPosition := 0;
        end;
        if LCurentPosition >= LNameLength - 1 then
        begin
          Inc(LNameLength, 4096);
          SetLength(Name, LNameLength);
          PS := @Name[1];
        end;
      end;
    end
    else
    if (LState = sFindComment) then
    begin
      if (LComment = 2) then
      begin
        if (C = Ord('>')) then
          LState := sFindLeft
        else
          LComment := 0;
      end
      else
      begin
        if (C = Ord('-')) then
          Inc(LComment)
        else
          LComment := 0;
      end;
    end;
  end;

  LNameLength := LCurentPosition;
  SetLength(Name, LNameLength);

  if LState = sFindRight then
    RaiseException;
  if (Name <> '') and (Name[LNameLength] = ' ') then
    SetLength(Name, LNameLength - 1);

{$IFDEF DELPHI12}
  I := Pos(AnsiString(' '), Name);
{$ELSE}
  I := Pos(' ', Name);
{$ENDIF}
  if I <> 0 then
  begin
{$IFDEF DELPHI12}
if FOldFormat then
   Text := string(Copy(Name, I + 1, LNameLength - I)) else
   Text := UTF8Decode(Copy(Name, I + 1, LNameLength - I));
{$ELSE}
    Text := Copy(Name, I + 1, LNameLength - I);
{$ENDIF}
    Delete(Name, I, LNameLength - I + 1);
  end;
{$IFDEF DELPHI12}
    NameS := string(Name);
{$ENDIF}
{    Text := Copy(Name, I + 1, LNameLength - I);
    Delete(Name, I, LNameLength - I + 1);
  end;}
end;

procedure TfrXMLReader.ReadItem(var Name, Text: string);
var
  LNotUse: String;
begin
  ReadItem(Name, Text, LNotUse);
end;

procedure TfrXMLReader.ReadRootItem(AItem: TfrXMLItem; AReadChildren: Boolean = True);
var
  LLastName: string;

  function DoRead(RootItem: TfrXMLItem): Boolean;
  var
    n: Integer;
    LChildItem: TfrXMLItem;
    LDone: Boolean;
    LCurPos: Int64;
    LName, LText: string;
  begin
    Result := False;
    LCurPos := Position;
    if ((RootItem.FName = '') or AItem.FLoaded) then
      ReadItem(RootItem.FName, RootItem.FText, RootItem.FValue)
    else
      ReadItem(LName, LText);// Item already exist , read it in temp buffer to avoid fragmentation in class data table
    LLastName := RootItem.FName;

    if (RootItem.Name = '') or (RootItem.Name[1] = '/') then
    begin
      Result := True;
      Exit;
    end;

    n := Length(RootItem.Name);
    if RootItem.Name[n] = '/' then
    begin
      SetLength(RootItem.FName, n - 1);
      Exit;
    end;

    n := Length(RootItem.Text);
    if (n > 0) and (RootItem.Text[n] = '/') then
    begin
      SetLength(RootItem.FText, n - 1);
      Exit;
    end;

    repeat
      LChildItem := TfrXMLItem.Create;
      LDone := True;
      try
        LDone := DoRead(LChildItem);
        if (not LDone) then
          RootItem.AddItem(LChildItem)
        else
          RootItem.Value := LChildItem.Value;
      finally
        if (LDone) then
          LChildItem.Free;
      end;
    until LDone;

    if (LLastName <> '') and (AnsiCompareText(LLastName, '/' + RootItem.Name) <> 0) then
      RaiseException;

    n := Pos(' ld="0"', LowerCase(RootItem.Text));
    if n <> 0 then
      Delete(RootItem.FText, n, 7);
    if (not AReadChildren and (n <> 0)) then
    begin
      RootItem.Clear;
      RootItem.Offset := LCurPos;
      RootItem.FUnloadable := True;
      RootItem.FLoaded := False;
    end;
  end;

begin
  DoRead(AItem);
end;


{ TfrXMLWriter }

constructor TfrXMLWriter.Create(Stream: TStream);
begin
  FStream := Stream;
end;

procedure TfrXMLWriter.FlushBuffer;
begin
  if FBuffer <> '' then
    FStream.Write(FBuffer[1], Length(FBuffer));
  FBuffer := '';
end;

procedure TfrXMLWriter.WriteLn(const s: AnsiString);
begin
  if not FAutoIndent then
    Insert(s, FBuffer, MaxInt) else
    Insert(s + #13#10, FBuffer, MaxInt);
  if Length(FBuffer) > 4096 then
    FlushBuffer;
end;

procedure TfrXMLWriter.WriteHeader;
begin
{$IFDEF DEL12ORFPC}
  WriteLn('<?xml version="1.0" encoding="utf-8" standalone="no"?>');
{$ELSE}
  WriteLn('<?xml version="1.0" encoding="utf-8"?>');
{$ENDIF}
end;

function Dup(n: Integer): AnsiString;
begin
  SetLength(Result, n);
  FillChar(Result[1], n, ' ');
end;

procedure TfrXMLWriter.WriteItem(Item: TfrXMLItem; Level: Integer = 0);
var
  s: AnsiString;
begin
  if (Item.FText <> '') or Item.FUnloadable then
  begin
{$IFDEF DELPHI12}
    s := UTF8Encode(Item.FText);
{$ELSE}
    s := Item.FText;
{$ENDIF}
    if Item.FUnloadable then
      s := s + ' ld="0"';
    if (s = '') or (s[1] <> ' ') then
      s := ' ' + s;
  end
  else
    s := '';

  if Item.Count = 0 then
  begin
    if Item.Value = '' then
      s := s + '/>'
    else
{$IFDEF DELPHI12}
      s := s + '>' + UTF8Encode(Item.Value) + '</' + AnsiString(Item.Name) + '>'
{$ELSE}
      s := s + '>' + Item.Value + '</' + Item.Name + '>'
{$ENDIF}
  end
  else
    s := s + '>';
  if not FAutoIndent then
    s := '<' + AnsiString(Item.Name) + s else
    s := Dup(Level) + '<' + AnsiString(Item.Name) + s;
  WriteLn(s);
end;

procedure TfrXMLWriter.WriteRootItem(RootItem: TfrXMLItem);

  procedure DoWrite(RootItem: TfrXMLItem; Level: Integer = 0);
  var
    i: Integer;
    rd: TfrXMLReader;
    NeedClear: Boolean;
  begin
    NeedClear := False;
    if not FAutoIndent then
      Level := 0;

    if (FTempStream <> nil) and RootItem.FUnloadable and not RootItem.FLoaded then
    begin
      rd := TfrXMLReader.Create(FTempStream);
      try
        rd.Position := RootItem.Offset;
        rd.ReadRootItem(RootItem);
        NeedClear := True;
      finally
        rd.Free;
      end;
    end;

    WriteItem(RootItem, Level);
    for i := 0 to RootItem.Count - 1 do
      DoWrite(RootItem[i], Level + 2);
    if RootItem.Count > 0 then
      if not FAutoIndent then
        WriteLn('</' + AnsiString(RootItem.Name) + '>') else
        WriteLn(Dup(Level) + '</' + AnsiString(RootItem.Name) + '>');

    if NeedClear then
      RootItem.Clear;
  end;

begin
  DoWrite(RootItem);
  FlushBuffer;
end;

{TfrValuedXMLReader}

procedure TfrValuedXMLReader.AddChar(var st: AnsiString; var stPos: Integer; ch: AnsiChar);
begin
  Inc(stPos);
  if stPos > Length(st) then
    SetLength(st, Length(st) * 2);
  st[stPos] := ch;
end;

function TfrValuedXMLReader.CreateItem: TfrXMLItem;
begin
  Result := TfrXMLItem.Create;
end;

function TfrValuedXMLReader.IsFirstNumberSign(const InSt: String): Boolean;
begin
  Result := (InSt <> '') and (InSt[1] = '#');
end;

function TfrValuedXMLReader.IsFirstSlash(const InSt: String): Boolean;
begin
  Result := (InSt <> '') and (InSt[1] = '/');
end;

function TfrValuedXMLReader.IsLastSlash(const InSt: String): Boolean;
var
  Len: Integer;
begin
  Len := Length(InSt);
  Result := (Len > 0) and (InSt[Len] = '/');
end;

function TfrValuedXMLReader.IsReadValuedXMLItem(Item: TfrXMLItem): Boolean;
var
  ChildItem: TfrXMLItem;
begin
  Result := IsReadValuedXMLRootItem(Item);
  if not Result or IsLastSlash(Item.Text) or IsFirstNumberSign(Item.Name) or
     IsLastSlash(Item.Name) or (Item.Name = '![CDATA[') then
    Exit;

  repeat
    ChildItem := CreateItem;
    if IsReadValuedXMLItem(ChildItem) then
      Item.AddItem(ChildItem)
    else
    begin
      if IsFirstSlash(ChildItem.Name) then
        Item.Value := ChildItem.Value;
      ChildItem.Free;
      Break;
    end;
  until False;
end;

function TfrValuedXMLReader.IsReadValuedXMLRootItem(Item: TfrXMLItem): Boolean;

  procedure ApostropheToQuote(var Text: string);
  var
    First, Second, i: Integer;
  begin
    Second := 0;
    repeat
      First := PosEx('=''', Text, Second + 1);
      if First = 0 then
        Break;
      Second := PosEx('''', Text, First + 2);
      if Second = 0 then
        Break;
      Text[First + 1] := '"';
      Text[Second] := '"';
      for i := First + 2 to Second - 1 do
        if Text[i] = '"' then
          Text[i] := '''';
    until False;
  end;

  function IsSkip(Name: String): Boolean;
  begin
    Result := (Name = '?xml') or (Name = '!--') or (Name = '!DOCTYPE');
  end;
var
  Name, Text, Value, SumValue : String;
const
  Indent: array[Boolean] of string = ('', ' ');
begin
  SumValue := '';
  repeat
    ReadValuedItem(Name, Value, Text);
    SumValue := SumValue + Indent[SumValue <> ''] + Trim(Value);
  until EndOfStream or ((Name + Text <> '') and not IsSkip(Name));

  ApostropheToQuote(Text);
  Item.SetData(Name, Text, SumValue);
  Result := not IsFirstSlash(Name) and (Name + Text <> '');
end;

procedure TfrValuedXMLReader.ReadValuedItem(out {$IFDEF Delphi12}NameS, ValueS{$ELSE}Name, Value{$ENDIF}, Text: String);
const
  LenPiece = 512;

var
  c: Byte;
  curposName, curPosValue: Integer;
  i, SpacePos, LineEndPos: Integer;
{$IFDEF Delphi12}
  Name, Value: AnsiString;
{$ENDIF}
begin
  if EndOfStream then
    Exit;
  c := 0;
  Text := '';
  curposName := 0;
  SetLength(Name, LenPiece);

  curposValue := 0;
  SetLength(Value, LenPiece);

  while not EndOfStream do
  begin
    c := ReadFromBuffer;
    if c = Ord('<') then
      Break
    else
      AddChar(Value, curposValue, AnsiChar(Chr(c)));
  end;
  SetLength(Value, curposValue);

  while not EndOfStream do
  begin
    c := ReadFromBuffer;
    if      c = Ord('<') then
      ProcessSecondLeftBrocket
    else if c = Ord('>') then
      Break
    else
    begin
      AddChar(Name, curposName, AnsiChar(Chr(c)));
      if (curposName = 3) and (Copy(Name, 1, 3) = '!--') then // Comment
        AddChar(Name, curposName, AnsiChar(' '));
    end;
  end;
  SetLength(Name, curposName);

  if c <> Ord('>') then
    if EndOfStream then
    begin
      {$IFDEF Delphi12}
      NameS := String(Name);
      ValueS := UTF8Decode(Copy(Value, 1, curposValue));
      {$ENDIF}
      Exit;
    end
    else
      RaiseException;

  SpacePos := Pos(AnsiString(' '), Name);
  LineEndPos := Pos(AnsiString(#$D#$A), Name);
  i := Min(SpacePos, LineEndPos);
  if i = 0 then
    i := Max(SpacePos, LineEndPos);

  if i <> 0 then
  begin
    Text := {$IFDEF Delphi12} UTF8Decode(Copy(Name, i + 1, curposName - i));
            {$ELSE}           Copy(Name, i + 1, curposName - i);
            {$ENDIF}
    SetLength(Name, i - 1);
  end;

{$IFDEF Delphi12}
  NameS := String(Name);
  ValueS := UTF8Decode(Copy(Value, 1, curposValue));
{$ENDIF}
end;

{ TfrValuedXMLDocument }

procedure TfrValuedXMLDocument.DoneValuedXMLFile;
begin
  FValuedXMLStreamReader.Free;
  FTempStream := FValuedXMLStream;
end;

procedure TfrValuedXMLDocument.InitValuedXMLFile(const FileName: String);
begin
  DeleteTempFile;
  FValuedXMLStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);

  FValuedXMLStreamReader := CreateReader;

  Root.Clear;
  Root.Offset := 0;

  ReadXMLHeader;

  FValuedXMLStreamReader.IsReadValuedXMLRootItem(Root);
end;

function TfrValuedXMLDocument.IsReadItem(Item: TfrXMLItem): Boolean;
begin
  Result := FValuedXMLStreamReader.IsReadValuedXMLItem(Item);
end;

procedure Initialize;
begin
  XMLDefaultFormatSettings.ThousandSeparator := ' ';
  XMLDefaultFormatSettings.DecimalSeparator := '.';
  XMLDefaultFormatSettings.DateSeparator := '.';
  XMLDefaultFormatSettings.TimeSeparator := ':';
  XMLDefaultFormatSettings.ShortDateFormat := 'DD.MM.YYYY';
  XMLDefaultFormatSettings.LongDateFormat := 'DD.MM.YYYY';
  XMLDefaultFormatSettings.ShortTimeFormat := 'hh:mm:ss:zzz';
  XMLDefaultFormatSettings.LongTimeFormat := 'hh:mm:ss:zzz';
  XMLDefaultFormatSettings.TwoDigitYearCenturyWindow := 50;
end;

initialization
  Initialize;

end.

