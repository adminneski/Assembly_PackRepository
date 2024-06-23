{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{           Classes to work w ith Xml format            }
{                                                       }
{     Copyright (c) 2021-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit XmlReaderWriterEh;

{$I EhLib.Inc}

interface

uses
  {$IFDEF FPC}
  EhLibLCL,
  {$ELSE}
  EhLibVCL,
  {$ENDIF}
  Classes,
  SysUtils;
//   System.Generics.Collections;

type
  { The current state of an IXmlReader. }
  TXmlReaderState = (
    xrdEndOfStream,
    xrdStartElement,
    xrdEndElement,
    xrdText,
    xrdComment,
    xrdCData);

  TXmlOutputOption = (
    xmooIndent,
    xmooWriteDeclaration);
  TXmlOutputOptions = set of TXmlOutputOption;

  XmlChar = WideChar;
  PXmlChar = PWideChar;
{$IFDEF EH_LIB_12}
  XmlString = String;
{$ELSE}
  XmlString = WideString;
{$ENDIF}

  EXmlParserError = class(Exception)
  private
    FColumnNumber: Integer;
    FLineNumber: Integer;
    FPosition: Integer;
    FXml: PXmlChar;
    function GetColumnNumber: Integer;
    function GetLineNumber: Integer;
  private
    procedure CalcLineAndColumnNumber;
  public
    constructor Create(const AMsg: String; const AXml: PXmlChar; const APosition: Integer);

    property ColumnNumber: Integer read GetColumnNumber;
    property LineNumber: Integer read GetLineNumber;
    property Position: Integer read FPosition;
  end;

type

  TXmlReaderAttribute = class(TPersistent)
  public
    Name: XmlString;
    Value: XmlString;
  end;

{ TXmlReader }

  TXmlReader = class
  private
    FAttributes: TList;
    FCurrent: PXmlChar;
    FCurrentElementName: XmlString;
    FIsEmptyElement: Boolean;
    FPrev: PXmlChar;
    FValueString: XmlString;
    FXml: XmlString;

    function GetAttribute(const AIndex: Integer): TXmlReaderAttribute; //inline;
    function GetAttributeCount: Integer; //inline;
    function SetValue(const AStart, AEnd: PXmlChar): Boolean;

    procedure AddAttribute(const ANameStart, ANameEnd, AValueStart, AValueEnd: PXmlChar);
    procedure ParseCData;
    procedure ParseComment;
    procedure ParseDeclaration;
    procedure ParseEndElement;
    procedure ParseStartElement;
  protected

    procedure ClearAttributes;
  public
    constructor Create(const AXml: XmlString); overload;
    constructor Create(const AXml: XmlString; const AEncoding: TEncoding); overload;
    destructor Destroy; override;

    class function LoadFromFile(const AFilename: String): TXmlReader; overload;
    class function LoadFromStream(const AStream: TStream): TXmlReader; overload;
    class function LoadFromArray(const ABytes: TBytes): TXmlReader; overload;

    procedure ParseError(const AMsg: PResStringRec);
    function ReadNextElement(out AState: TXmlReaderState): Boolean;

    property IsEmptyElement: Boolean read FIsEmptyElement;
    property CurrentElementName: XmlString read FCurrentElementName;
    property ValueString: XmlString read FValueString;
    property AttributeCount: Integer read GetAttributeCount;
    property Attributes[const AIndex: Integer]: TXmlReaderAttribute read GetAttribute;
  end;

const INDENT_SIZE = 2;

type

{ TXmlWriter }

  TXmlWriter = class
  private
    FBuffer: TStringBuilder;
    //FBuffer: PByte;
    FLineBreak: XmlString;

    //procedure Append(const AValue; const ASize: Integer);
  public
    constructor Create(const AOptions: TXmlOutputOptions = [xmooIndent, xmooWriteDeclaration]);
    destructor Destroy; override;

    procedure WriteIndent(const ADepth: Integer);
    procedure WriteLineBreak;
    procedure Write(const AValue: XmlChar); overload;
    procedure Write(const AValue: XmlString); overload;
    procedure WriteCData(const ACData: XmlString);
    procedure WriteComment(const AComment: XmlString);
    procedure WriteEncoded(const AValue: XmlString; const AForAttribute: Boolean = False);

    function ToXml: XmlString;
    function ToBytes: TBytes;
  end;

resourcestring
  RS_XML_CDATA_NOT_ALLOWED     = 'CDATA is not allowed here.';
  RS_XML_CHARACTER_REFERENCE   = 'Invalid character reference in XML data.';
  RS_XML_ELEMENT_NAME_MISMATCH = 'Name of end element does not match start element.';
  RS_XML_EQUAL_EXPECTED        = 'Expected "=" after XML attribute name.';
  RS_XML_INVALID_CDATA         = 'Invalid CDATA in XML data.';
  RS_XML_INVALID_COMMENT       = 'Invalid comment in XML data.';
  RS_XML_INVALID_END_ELEMENT   = 'End element is not allowed here.';
  RS_XML_INVALID_QUOTE         = 'Attribute value must be enclosed in single or double quotes.';
  RS_XML_UNEXPECTED_EOF        = 'Unexpected end of XML data.';

implementation

{$IFDEF EH_LIB_12} //Delphi 2009
uses Character;
{$ELSE}
{$ENDIF}

{ EXmlParserError }

procedure EXmlParserError.CalcLineAndColumnNumber;
var
  LineNum: Integer;
  P: PXmlChar;
  LineStart: PXmlChar;
  I: Integer;
begin
  LineNum := 1;
  P := FXml;
  LineStart := P;
  for I := 0 to FPosition - 1 do
  begin
    if (P^ = #10) then
    begin
      Inc(LineNum);
      LineStart := P + 1;
    end;
    Inc(P);
  end;
  FLineNumber := LineNum;
  FColumnNumber := P - LineStart + 1;
end;

constructor EXmlParserError.Create(const AMsg: String; const AXml: PXmlChar;
  const APosition: Integer);
begin
  inherited Create(AMsg);
  FXml := AXml;
  FPosition := APosition;
end;

function EXmlParserError.GetColumnNumber: Integer;
begin
  if (FColumnNumber = 0) then
    CalcLineAndColumnNumber;

  Result := FColumnNumber;
end;

function EXmlParserError.GetLineNumber: Integer;
begin
  if (FLineNumber = 0) then
    CalcLineAndColumnNumber;

  Result := FLineNumber;
end;

{ TXmlReader }

procedure TXmlReader.AddAttribute(const ANameStart, ANameEnd, AValueStart,
  AValueEnd: PXmlChar);
var
  Attr: TXmlReaderAttribute;
  AtrName: String;
begin
  //Attr.NameIndex := FInternPool.Get(ANameStart, ANameEnd - ANameStart);
  SetString(AtrName, ANameStart, ANameEnd - ANameStart);
  if SetValue(AValueStart, AValueEnd) then
  begin
    Attr := TXmlReaderAttribute.Create;
    Attr.Name := AtrName;
    Attr.Value := FValueString;
    FAttributes.Add(Attr);
  end;
end;

constructor TXmlReader.Create(const AXml: XmlString);
begin
{$IFDEF EH_LIB_12}
  Create(AXml, TEncoding.Unicode);
{$ELSE}
  Create(AXml, TEncoding.Default);
{$ENDIF}
end;

constructor TXmlReader.Create(const AXml: XmlString; const AEncoding: TEncoding);
begin
  inherited Create;
  FAttributes := TList.Create;
  FXml := AXml;
  FCurrent := PXmlChar(FXml);
end;

destructor TXmlReader.Destroy;
begin
  ClearAttributes;
  FreeAndNil(FAttributes);
  inherited;
end;

procedure TXmlReader.ClearAttributes;
var
  I: Integer;
begin
  for I := 0 to FAttributes.Count-1 do
  begin
    TXmlReaderAttribute(FAttributes[i]).Free;
  end;
  FAttributes.Clear;
end;

function TXmlReader.GetAttribute(const AIndex: Integer): TXmlReaderAttribute;
begin
  Result := FAttributes[AIndex];
end;

function TXmlReader.GetAttributeCount: Integer;
begin
  Result := FAttributes.Count;
end;

class function TXmlReader.LoadFromFile(const AFilename: String): TXmlReader;
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(AFilename, fmOpenRead or fmShareDenyWrite);
  try
    Result := LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

class function TXmlReader.LoadFromArray(const ABytes: TBytes): TXmlReader;
var
  Stream: TBytesStream;
begin
  Stream := TBytesStream.Create(ABytes);
  try
    Result := LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

class function TXmlReader.LoadFromStream(const AStream: TStream): TXmlReader;
var
  Xml: XmlString;
{$IFDEF EH_LIB_12} //RAD Studio 2009
  BOMSize: Integer;
{$ELSE}
{$ENDIF}
  Buffer: TBytes;
  Size: Integer;
  Encoding: TEncoding;
begin
  Xml := '';

  Size := AStream.Size - AStream.Position;
  SetLength(Buffer, Size);
  AStream.Read(Buffer[0], Size);

{$IFDEF EH_LIB_12} //RAD Studio 2009
  Encoding := nil;
  {$IFDEF EH_LIB_14} //RAD Studio 2011 XE
  BOMSize := TEncoding.GetBufferEncoding(Buffer, Encoding, TEncoding.UTF8);
  {$ELSE}
  BOMSize := TEncoding.GetBufferEncoding(Buffer, Encoding);
  {$ENDIF}
  Xml := Encoding.GetString(Buffer, BOMSize, Length(Buffer) - BOMSize);
{$ELSE}
  Encoding := TEncoding.Default;
{$ENDIF}

  Result := TXmlReader.Create(Xml, Encoding);
end;

function TXmlReader.ReadNextElement(out AState: TXmlReaderState): Boolean;
var
  P: PXmlChar;
  Start: PXmlChar;
begin
  while (True) do
  begin
    FPrev := FCurrent;
    P := FCurrent;
    Start := P;

    { Scan until '<' }
    while (P^ <> #0) and (P^ <> '<') do
      Inc(P);

    if (P^ = #0) then
    begin
      AState := xrdEndOfStream;
      Result := False;
      Exit;
    end;

    if (P <> Start) then
    begin
      if (SetValue(Start, P)) then
      begin
        AState := xrdText;
        FCurrent := P;
        Result := True;
        Exit;
      end;
    end;

    Inc(P);
    FCurrent := P;
    case P^ of
      '?':
        ParseDeclaration; { Ignore and parse next }

      '/':
        begin
          ParseEndElement;
          AState := xrdEndElement;
          Result := True;
          Exit;
        end;

      '!':
        if (P[1] = '[') then
        begin
          ParseCData;
          AState := xrdCData;
          Result := True;
          Exit;
        end
        else
        begin
          ParseComment;
          AState := xrdComment;
          Result := True;
          Exit;
        end;
    else
      ParseStartElement;
      AState := xrdStartElement;
      Result := True;
      Exit;
    end;
  end;
end;

procedure TXmlReader.ParseCData;
var
  P: PXmlChar;
  Start: PXmlChar;
begin
  P := FCurrent;
  if (P[0] <> '!') or
     (P[1] <> '[') or
     (P[2] <> 'C') or
     (P[3] <> 'D') or
     (P[4] <> 'A') or
     (P[5] <> 'T') or
     (P[6] <> 'A') or
     (P[7] <> '[')
  then
    ParseError(@RS_XML_INVALID_CDATA);

  Inc(P, 8);
  Start := P;

  { Move to end of CDATA. }
  while (P^ <> #0) and
        ((P[0] <> ']') or (P[1] <> ']') or (P[2] <> '>')) do
  begin
    Inc(P);
  end;

  if (P^ = #0) then
    ParseError(@RS_XML_UNEXPECTED_EOF);

  SetString(FValueString, Start, P - Start);
  FCurrent := P + 3;
end;

procedure TXmlReader.ParseComment;
var
  P: PXmlChar;
  Start: PXmlChar;
  Level: Integer;
begin
  P := FCurrent;
  if (P[0] <> '!') or (P[1] <> '-') or (P[2] <> '-') then
    ParseError(@RS_XML_INVALID_COMMENT);

  Inc(P, 3);
  Start := P;
  Level := 1;

  { Move to end of comment, allowing for nested angled brackets. }
  while (Level > 0) do
  begin
    if (P^ = '<') then
      Inc(Level)
    else if (P^ = '>') then
      Dec(Level)
    else if (P^ = #0) then
      ParseError(@RS_XML_UNEXPECTED_EOF);

    Inc(P);
  end;

  if (P < (Start + 3)) or (P[-2] <> '-') or (P[-3] <> '-') then
    ParseError(@RS_XML_INVALID_COMMENT);

  SetString(FValueString, Start, P - Start - 3);
  FCurrent := P;
end;

procedure TXmlReader.ParseDeclaration;
var
  P: PXmlChar;
begin
  P := FCurrent;
  while (P^ <> #0) and (P^ <> '>') do
  begin
    Inc(P);
  end;

  if (P^ = #0) then
    ParseError(@RS_XML_UNEXPECTED_EOF);

  FCurrent := P + 1;
end;

procedure TXmlReader.ParseEndElement;
var
  P: PXmlChar;
  Start: PXmlChar;
begin
  FIsEmptyElement := False;
  ClearAttributes();
  P := FCurrent + 1;
  Start := P;

  while (P^ <> #0) and (P^ <> '>') do
    Inc(P);

  if (P^ = #0) then
    ParseError(@RS_XML_UNEXPECTED_EOF);

  SetString(FCurrentElementName, Start, P - Start);
  FCurrent := P + 1;
end;

procedure TXmlReader.ParseError(const AMsg: PResStringRec);
var
  Xml: PXmlChar;
  Position: Integer;
begin
  Xml := PXmlChar(FXml);
  Position := 0;
  if (FCurrent <> nil) then
    Position := FPrev - Xml;

  raise EXmlParserError.Create(LoadResString(AMsg), Xml, Position);
end;

procedure TXmlReader.ParseStartElement;
var
  P: PXmlChar;
  NameStart: PXmlChar;
  NameEnd: PXmlChar;
  AttrNameStart: PXmlChar;
  AttrNameEnd: PXmlChar;
  QuoteChar: XmlChar;
  AttrValueStart: PXmlChar;
begin
  P := FCurrent;
  NameStart := P;
  FIsEmptyElement := False;
  ClearAttributes;

  { Move to first attribute or end of element }
  while (P^ > #$20) and (P^ <> '>') do
    Inc(P);

  NameEnd := P;

  { Parse attributes }
  while (P^ <> '>') do
  begin
    if (P^ = #0) then
      ParseError(@RS_XML_UNEXPECTED_EOF);

    if (P^ = '/') then
    begin
      FIsEmptyElement := True;
      Inc(P);
    end
    else if (P^ <= #$20) then
    begin
      Inc(P);
    end else
    begin
      { At attribute name }
      FPrev := P;
      AttrNameStart := P;
      while (P^ > #$20) and (P^ <> '=') do
        Inc(P);

      if (P^ = #0) then
        ParseError(@RS_XML_UNEXPECTED_EOF);

      AttrNameEnd := P;

      while (P^ > #0) and (P^ <= #$20) do
        Inc(P);

      FPrev := P;
      if (P^ <> '=') then
        ParseError(@RS_XML_EQUAL_EXPECTED);

      Inc(P);
      FPrev := P;
      while (P^ > #0) and (P^ <= #$20) do
        Inc(P);

      if (P^ = #0) then
        ParseError(@RS_XML_UNEXPECTED_EOF);

      { At attribute value }
      QuoteChar := P^;
      if (QuoteChar <> '''') and (QuoteChar <> '"') then
        ParseError(@RS_XML_INVALID_QUOTE);
      Inc(P);
      FPrev := P;

      AttrValueStart := P;
      while (P^ > #0) and (P^ <> QuoteChar) do
        Inc(P);

      if (P^ = #0) then
        ParseError(@RS_XML_UNEXPECTED_EOF);

      AddAttribute(AttrNameStart, AttrNameEnd, AttrValueStart, P);
      Inc(P);
    end;
  end;

  if (NameEnd > NameStart) and (NameEnd[-1] = '/') then
  begin
    FIsEmptyElement := True;
    Dec(NameEnd);
  end;

  SetString(FCurrentElementName, NameStart, NameEnd - NameStart);
  FCurrent := P + 1;
end;

{$IFDEF EH_LIB_18}  //Delphi XE4
function CharConvertFromUtf32(C: UCS4Char): string;
begin
  Result := Character.ConvertFromUtf32(C);
end;

function CharIsWhiteSpace(C: UCS4Char): Boolean;
begin
  Result := Character.IsWhiteSpace(C);
end;

{$ELSE}

function CharConvertFromUtf32(C: UCS4Char): string;
begin
  Result := Char(C);
end;

function CharIsWhiteSpace(C: UCS4Char): Boolean;
begin
  Result := Char(C) = ' ';
end;
{$ENDIF}

{$IFDEF EH_LIB_25}  //Delphi XE10.2
{$ELSE}
function TryStrToUInt(const S: string; out Value: Cardinal): Boolean;
var
  I64: Int64;
  E: Integer;
begin
  Val(S, I64, E);
  Value := I64;
  Result := (E = 0) and (Low(Cardinal) <= I64) and (I64 <= High(Cardinal));
end;
{$ENDIF}

function TXmlReader.SetValue(const AStart, AEnd: PXmlChar): Boolean;
var
  Buf: TStringBuilder;
  Start: PXmlChar;
  CodePoint: Cardinal;
  S: XmlString;
  P: PXmlChar;
//  C: XmlChar;
  I: Integer;
begin
  Result := False;
  Buf := TStringBuilder.Create;
  try
    P := AStart;
    while (P < AEnd) do
    begin
      if (P^ = '&') then
      begin
        FPrev := P;
        Inc(P);
        Start := P;
        while (P < AEnd) and (P^ <> ';') do
          Inc(P);

        if (P = AEnd) then
          ParseError(@RS_XML_CHARACTER_REFERENCE);

        if (Start^ = '#') then
        begin
          { Numeric reference }
          SetString(S, Start + 1, P - Start - 1);
          if (Start[1] = 'x') then
            { Hexadicimal }
            S[1] := '$';

          if (not TryStrToUInt(S, CodePoint)) then
            ParseError(@RS_XML_CHARACTER_REFERENCE);

          if (CodePoint < $80) then
            Buf.Append(String(XmlChar(CodePoint)))
          else
          begin
            S := XmlString(CharConvertFromUtf32(Codepoint));
            for I := 1 to Length(S) do
            begin
              Buf.Append(String(S[I]));
            end;
          end;

          if (not CharIsWhiteSpace(CodePoint)) then
            Result := True;
        end
        else if (Start^ = 'a') then
        begin
          { &amp; or &apos; }
          if (Start[1] = 'm') then
          begin
            if (Start[2] = 'p') and (Start[3] = ';') then
            begin
              Buf.Append('&');
              Result := True;
            end;
          end
          else if (Start[1] = 'p') then
          begin
            if (Start[2] = 'o') and (Start[3] = 's') and (Start[4] = ';') then
            begin
              Buf.Append('''');
              Result := True;
            end;
          end;
        end
        else if (Start^ = 'g') then
        begin
          { &gt; }
          if (Start[1] = 't') and (Start[2] = ';') then
          begin
            Buf.Append('>');
            Result := True;
          end;
        end
        else if (Start^ = 'l') then
        begin
          { &lt; }
          if (Start[1] = 't') and (Start[2] = ';') then
          begin
            Buf.Append('<');
            Result := True;
          end;
        end
        else if (Start^ = 'q') then
        begin
          { &quot; }
          if (Start[1] = 'u') and (Start[2] = 'o') and (Start[3] = 't') and (Start[4] = ';') then
          begin
           Buf.Append('"');
           Result := True;
          end;
        end
        else
          ParseError(@RS_XML_CHARACTER_REFERENCE);
      end
      else
      begin
        Buf.Append(String(P^));
        if (P^ > #$20) then
          Result := True;
      end;

      Inc(P);
    end;
    if (Result) then
      FValueString := Buf.ToString;
  finally
    Buf.Free;
  end;
end;

{ TXmlWriter }

constructor TXmlWriter.Create(const AOptions: TXmlOutputOptions);
begin
  inherited Create;
  if (xmooIndent in AOptions) then
    FLineBreak := sLineBreak;

  FBuffer := TStringBuilder.Create;

  if (xmooWriteDeclaration in AOptions) then
    Write('<?xml version="1.0" encoding="UTF-8"?>');

  WriteLineBreak;
end;

destructor TXmlWriter.Destroy;
begin
  FreeAndNil(FBuffer);
  inherited Destroy;
end;

procedure TXmlWriter.WriteIndent(const ADepth: Integer);
var
  IndentCount: Integer;
begin
  if (FLineBreak = '') or (ADepth = 0) then
    Exit;

  IndentCount := ADepth * INDENT_SIZE;
  FBuffer.Append(' ', IndentCount);
end;

procedure TXmlWriter.WriteLineBreak;
begin
  if (FLineBreak <> #0) then
    Write(FLineBreak);
end;

function TXmlWriter.ToBytes: TBytes;
begin
  if (FBuffer.Length = 0) then
  begin
    Result := nil;
    Exit;
  end;

{$IFDEF EH_LIB_12}
  Result := TEncoding.UTF8.GetBytes(ToXml);
{$ELSE}
  Result := TEncoding.ANSI.GetBytes(ToXml);
{$ENDIF}
end;

function TXmlWriter.ToXml: XmlString;
begin
  Result := FBuffer.ToString;
end;

procedure TXmlWriter.Write(const AValue: XmlChar);
begin
  FBuffer.Append(String(AValue));
end;

procedure TXmlWriter.Write(const AValue: XmlString);
begin
  if (AValue <> '') then
    FBuffer.Append(AValue);
end;

procedure TXmlWriter.WriteEncoded(const AValue: XmlString; const AForAttribute: Boolean);
var
  I: Integer;
{$IFDEF EH_LIB_12}
  C: Char;
{$ELSE}
  C: WideChar;
{$ENDIF}
begin
  for I := 1 to Length(AValue) do
  begin
    C := AValue[I];
    case C of
      #0..#31:
        begin
          Write('&#');
          Write(IntToStr(Ord(C)));
          Write(';');
        end;

      '&' : Write('&amp;');
      '''': if (AForAttribute) then
              Write(C)
            else
              Write('&apos;');
      '"' : Write('&quot;');
      '<' : Write('&lt;');
      '>' : Write('&gt;');
    else
      Write(C);
    end;
  end;
end;

procedure TXmlWriter.WriteCData(const ACData: XmlString);
var
  I: Integer;
  SubStr: XmlString;
begin
  Write('<![CDATA[');

  I := Pos(ACData, (']]>'));
  if (I < 0) then
    Write(ACData)
  else
    { Text contains illegal CData terminator. Only write part until terminator. }
  begin
    SubStr := Copy(ACData, 1, I + 1);
    Write(SubStr);
  end;

  Write(']]>');
end;

procedure TXmlWriter.WriteComment(const AComment: XmlString);
var
  I: Integer;
  SubStr: XmlString;
begin
  Write('<!--');

  I := Pos(AComment, '--');
  if (I < 0) then
    Write(AComment)
  else
    { Comment contains illegal '--'. Only write part until this. }
  begin
    SubStr := Copy(AComment, 1, I + 1);
    Write(SubStr);
  end;

  Write('-->');
end;

end.
