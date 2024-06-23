{*******************************************************}
{    The Delphi Unicode Controls Project                }
{                                                       }
{      http://home.ccci.org/wolbrink                    }
{                                                       }
{         Copyright (c) 1998-2021          }
{                                                       }
{*******************************************************}

{$IFNDEF FMX}
unit frUnicodeUtils;
{$ENDIF}

{$I frVer.inc}
interface

uses
  Types,
  {$IFDEF MSWINDOWS}
    Windows,
  {$ENDIF}
  {$IFNDEF FPC}
    WideStrings,
  {$ENDIF}
  Classes, SysUtils;

{$IFNDEF DELPHIVCL}
const
  DEFAULT_CHARSET = 1;
  MAC_CHARSET = 7;
  OEM_CHARSET = 255;
  VIETNAMESE_CHARSET = 163;
  JOHAB_CHARSET = 130;
  CP_MACCP = 2;
  CP_OEMCP = 1;
{$ENDIF}

{$IFNDEF FPC}
type
  TfrWideStrings = class(TWideStringList)
  private
    procedure ReadData(Reader: TReader);
    procedure ReadDataWOld(Reader: TReader);
    procedure ReadDataW(Reader: TReader);
    procedure WriteDataW(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure LoadFromWStream(Stream: TStream);
  end;
  TfrWideStringList = class(TfrWideStrings);

  function AnsiToUnicode(const s: AnsiString; Charset: LongWord; CodePage: Integer = 0): WideString;
  function _UnicodeToAnsi(const WS: WideString; Charset: LongWord; CodePage: Integer = 0): Ansistring;
{$ELSE}
type
  TWideStrings = class(TStringList);
  TWideStringList = class(TWideStrings);
  TfrWideStrings = class(TWideStringList);
  TfrWideStringList = class(TfrWideStrings);

  function AnsiToUnicode(const s: {$IFDEF FPCUNICODE}string{$ELSE}AnsiString{$ENDIF}; Charset: LongWord; CodePage: Integer = 0): {$IFDEF FPCUNICODE}String{$ELSE}AnsiString{$ENDIF};
  function _UnicodeToAnsi(const WS: {$IFDEF FPCUNICODE}string{$ELSE}WideString{$ENDIF}; Charset: LongWord; CodePage: Integer = 0): {$IFDEF FPCUNICODE}String{$ELSE}AnsiString{$ENDIF};
{$ENDIF}

function CharSetToCodePage(ciCharset: LongWord): Cardinal;

{$IFNDEF FMX}
  function OemToStr(const AnsiStr: {$IFDEF FPCUNICODE}string{$ELSE}AnsiString{$ENDIF}): {$IFDEF FPCUNICODE}string{$ELSE}AnsiString{$ENDIF};
  function GetLocalByCharSet(Charset: LongWord): Cardinal;
{$ENDIF}

implementation

{$IFNDEF FPC}
function AnsiToUnicode(const s: AnsiString; Charset: LongWord; CodePage: Integer): WideString;
var
  InputLength, OutputLength{$IFNDEF MSWINDOWS}, Flags{$ENDIF}: Integer;
begin
  Result := '';
  if CodePage = 0 then
    CodePage := CharSetToCodePage(Charset);
  InputLength := Length(S);
{$IFDEF MSWINDOWS}
  OutputLength := MultiByteToWideChar(CodePage, 0, PAnsiChar(S), InputLength, nil, 0);
  if OutputLength <> 0 then
  begin
    SetLength(Result, OutputLength);
    MultiByteToWideChar(CodePage, 0, PAnsiChar(S), InputLength, PWideChar(Result), OutputLength);
  end;
{$ELSE}
  if CodePage = CP_UTF8 then
    Flags := 0
  else
    Flags := 1;
  OutputLength := UnicodeFromLocaleChars(CodePage, 0, PAnsiChar(S), InputLength, nil, 0);
  SetLength(Result, OutputLength);
  UnicodeFromLocaleChars(CodePage, Flags, PAnsiChar(S), InputLength, PWideChar(Result), OutputLength);
{$ENDIF}
end;

function _UnicodeToAnsi(const WS: WideString; Charset: LongWord; CodePage: Integer): AnsiString;
var
  InputLength,
  OutputLength: Integer;
begin
  Result := '';
  if CodePage = 0 then
    CodePage := CharSetToCodePage(Charset);
  InputLength := Length(WS);
{$IFDEF MSWINDOWS}
  OutputLength := WideCharToMultiByte(CodePage, 0, PWideChar(WS), InputLength, nil, 0, nil, nil);
  if OutputLength <> 0 then
  begin
    SetLength(Result, OutputLength);
    WideCharToMultiByte(CodePage, 0, PWideChar(WS), InputLength, PAnsiChar(Result), OutputLength, nil, nil);
  end;
{$ELSE}
  OutputLength := LocaleCharsFromUnicode(CodePage, 0, PWideChar(WS), InputLength, nil, 0, nil, nil);
  SetLength(Result, OutputLength);
  LocaleCharsFromUnicode(CodePage, 0, PWideChar(WS), InputLength, PAnsiChar(Result), OutputLength, nil, nil);
{$ENDIF}
end;
{$ELSE}

function AnsiToUnicode(const s: {$IFDEF FPCUNICODE}String{$ELSE}AnsiString{$ENDIF}; Charset: LongWord; CodePage: Integer): {$IFDEF FPCUNICODE}String{$ELSE}AnsiString{$ENDIF};
{$IFNDEF FPC}
var
  InputLength, OutputLength: Integer;
{$ENDIF}
begin
  if CodePage = 0 then
    CodePage := CharSetToCodePage(Charset);
  {$IFDEF FPC}
  {$IFDEF FPCUNICODE}
  Result := S;
  {$ELSE}
  Result := UTF16ToUTF8(S);
  {$ENDIF}
  // UTF16ToUTF8(S);
  // AnsiToUtf8(s);
  {$ELSE}
  Result := '';
  InputLength := Length(S);
  OutputLength := MultiByteToWideChar(CodePage, 0, PAnsiChar(S), InputLength, nil, 0);
  if OutputLength <> 0 then
  begin
    SetLength(Result, OutputLength);
    MultiByteToWideChar(CodePage, 0, PAnsiChar(S), InputLength, PWideChar(Result), OutputLength);
  end;
  {$ENDIF}
end;

function _UnicodeToAnsi(const WS: {$IFDEF FPCUNICODE}String{$ELSE}WideString{$ENDIF}; Charset: LongWord; CodePage: Integer): {$IFDEF FPCUNICODE}String{$ELSE}AnsiString{$ENDIF};
{$IFNDEF FPC}
var
  InputLength,
  OutputLength: Integer;
{$ENDIF}
begin
  if CodePage = 0 then
    CodePage := CharSetToCodePage(Charset);
  {$IFDEF FPC}
  {$IFDEF FPCUNICODE}
  Result := WS;
  {$ELSE}
  Result := UTF8ToUTF16(WS);
  {$ENDIF}
  // UTF8ToUTF16(WS);
  // Utf8ToAnsi(WS);
  {$ELSE}
  Result := '';
  if CodePage = 0 then
    CodePage := CharSetToCodePage(Charset);
  InputLength := Length(WS);
  OutputLength := WideCharToMultiByte(CodePage, 0, PWideChar(WS), InputLength, nil, 0, nil, nil);
  if OutputLength <> 0 then
  begin
    SetLength(Result, OutputLength);
    WideCharToMultiByte(CodePage, 0, PWideChar(WS), InputLength, PAnsiChar(Result), OutputLength, nil, nil);
  end;
  {$ENDIF}
end;

{$ENDIF}

{$IFNDEF FPC}
  {$IFDEF MSWINDOWS}
    function TranslateCharsetInfo(lpSrc: DWORD; var lpCs: TCharsetInfo;
      dwFlags: DWORD): BOOL; stdcall; external gdi32 name 'TranslateCharsetInfo';
  {$ENDIF}
{$ENDIF}

function CharSetToCodePage(ciCharset: LongWord): Cardinal;
{$IFNDEF FPC}
  {$IFDEF MSWINDOWS}
    var
      C: TCharsetInfo;
  {$ENDIF}
{$ENDIF}
begin
{$IFDEF FPC}
  {$note warning TranslateCharsetInfo() }
  Result := 0;
{$ELSE}
  if ciCharset = DEFAULT_CHARSET then
    Result := GetACP
  else if ciCharset = MAC_CHARSET then
    Result := CP_MACCP
  else if ciCharset = OEM_CHARSET then
    Result := CP_OEMCP// GetACP
  else
  begin
    {$IFDEF MSWINDOWS}
      Win32Check(TranslateCharsetInfo(ciCharset, C, TCI_SRCCHARSET));
      Result := C.ciACP;
    {$ELSE}
      Result := DefaultSystemCodePage;
    {$ENDIF}
  end;
{$ENDIF}
end;

{$IFNDEF FMX}
function OemToStr(const AnsiStr: {$IFDEF FPCUNICODE}string{$ELSE}AnsiString{$ENDIF}): {$IFDEF FPCUNICODE}string{$ELSE}AnsiString{$ENDIF};
begin
  {$IFDEF FPC}
  {$note warning OemToStr()}
  Result := AnsiStr;
  {$ELSE}
  SetLength(Result, Length(AnsiStr));
  if Length(Result) > 0 then
    OemToAnsiBuff(PAnsiChar(AnsiStr), PAnsiChar(Result), Length(Result));
  {$ENDIF}
end;

function GetLocalByCharSet(Charset: LongWord): Cardinal;
begin
{$IFNDEF FPC}
  case Charset of
    EASTEUROPE_CHARSET:   Result := $0405; //# $040e
    RUSSIAN_CHARSET:      Result := $0419;
    GREEK_CHARSET:        Result := $0408;
    TURKISH_CHARSET:      Result := $041F;
    HEBREW_CHARSET:       Result := $040D;
    ARABIC_CHARSET:       Result := $3401;
    BALTIC_CHARSET:       Result := $0425;
    VIETNAMESE_CHARSET:   Result := $042A;
    JOHAB_CHARSET:        Result := $0812;
    THAI_CHARSET:         Result := $041E;
    SHIFTJIS_CHARSET:     Result := $0411;
    GB2312_CHARSET:       Result := $0804;
    HANGEUL_CHARSET:      Result := $0412;
    CHINESEBIG5_CHARSET:  Result := $0C04;
  else
    Result := GetThreadLocale;
  end;
{$ENDIF}
end;
{$ENDIF}

{$IFNDEF FPC}

{ TfrWideStrings }

procedure TfrWideStrings.LoadFromWStream(Stream: TStream);
var
  ASize: Integer;
  S: WideString;
begin
  ASize := Stream.Size - Stream.Position;
  SetLength(S, ASize div 2);
  Stream.Read(S[1], ASize);
  SetTextStr(S);
end;

procedure TfrWideStrings.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then
    begin
      Result := True;
      if Filer.Ancestor is TWideStrings then
        Result := not Equals(TWideStrings(Filer.Ancestor))
    end
    else Result := Count > 0;
  end;

begin
  // compatibility
  Filer.DefineProperty('Strings', ReadData, nil, Count > 0);
  Filer.DefineProperty('UTF8', ReadDataWOld, nil, Count > 0);
  Filer.DefineProperty('UTF8W', ReadDataW, WriteDataW, DoWrite);
end;

procedure TfrWideStrings.ReadData(Reader: TReader);
begin
  Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    if Reader.NextValue in [vaString, vaLString] then
      Add(Reader.ReadString) {TStrings compatiblity}
    else
      Add(Reader.ReadWideString);
  Reader.ReadListEnd;
end;

procedure TfrWideStrings.ReadDataWOld(Reader: TReader);
begin
  Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    Add(Utf8Decode(AnsiString(Reader.ReadString)));
  Reader.ReadListEnd;
end;

procedure TfrWideStrings.ReadDataW(Reader: TReader);
begin
  Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    Add(Reader.ReadString);
  Reader.ReadListEnd;
end;

procedure TfrWideStrings.WriteDataW(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do
    Writer.WriteString(Get(I));
  Writer.WriteListEnd;
end;

{$ENDIF}

end.
