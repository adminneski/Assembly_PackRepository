{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{           Classes to work w ith Xlsx Format           }
{                                                       }
{     Copyright (c) 2020-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit XlsFileWritersEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes, Graphics, Dialogs, GridsEh, Controls,
  Variants, Types, Printers, FmtBcd,
  ZipFileProviderEh, XlsMemFilesEh,
{$IFDEF FPC}
  XMLRead, XMLWrite, xmlutils, DOM, EhLibXmlConsts, LCLIntf,
{$ELSE}
  xmldom, XMLIntf, XMLDoc, EhLibXmlConsts, Windows,
{$ENDIF}

{$IFDEF EH_LIB_17} System.UITypes, System.Contnrs, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType,
  {$ELSE}
    EhLibVCL, Messages, SqlTimSt,
  {$ENDIF}
{$ENDIF}
  Db, Clipbrd, {ComObj, }StdCtrls;

//{$IFDEF FPC}
//{$ELSE}

type

 { TXlsxFileWriterEh }

  TXlsxFileWriterEh = class(TPersistent)
  private
    FCurCol: Integer;
    FCurRow: Integer;
    //FRowNode: IXMLNode;
    FXMLSheets: array of IXMLDocument;
    FSheetRowsStreams: array of TStringBuilder;
    FXMLStyles: IXMLDocument;
    FZipFileProvider: TCustomFileZipingProviderEh;
    FColCount: Integer;
    FFileName: String;
    FXlsFile: TXlsMemFileEh;

    function GetCurColNum: Integer;
    function GetCurRowNum: Integer;
  protected
    function CreateSheetXml(FirstSheet: Boolean; Worksheet: TXlsWorksheetEh): IXMLDocument;
    function GetColWidth(SheetIndex: Integer; ACol: Integer): Double; virtual;
    function GetColumn(SheetIndex: Integer; ACol: Integer): TXlsFileColumnEh; virtual;
    function InitTableCheckEof(SheetIndex: Integer): Boolean; virtual;
    function InitRowCheckEof(SheetIndex: Integer; ARow: Integer): Boolean; virtual;
    function GetColCount(SheetIndex: Integer): Integer; virtual;
    function SysVarToStr(const Val: Variant): String;

    procedure InitFileData; virtual;
    procedure CreateXMLs; virtual;
    procedure CreateStaticXMLs; virtual;
    procedure CreateDynamicXMLs; virtual;

    procedure WriteXMLs; virtual;
    procedure WriteSheetXML(SheetIndex: Integer; XMLSheet: IXMLDocument; RowsString: TStringBuilder); virtual;
    procedure WriteColumnsSec(SheetIndex: Integer; Root: IXMLNode); virtual;
    procedure WriteStylesXML; virtual;
    procedure WriteSheetViewInfo(SheetIndex: Integer); virtual;
    procedure WriteMergeCellsInfo(Worksheet: TXlsWorksheetEh; WorksheetDocument: IXMLDocument); virtual;
    procedure WriteAutoFilterInfo(Worksheet: TXlsWorksheetEh; WorksheetDocument: IXMLDocument); virtual;
    procedure MergeSheetXMLAndRowsSream(XMLSheet: IXMLDocument; RowsStream: TStringStream; ResultStream: TStringStream); virtual;

    procedure SaveDataToFile; virtual;

    procedure WriteRow(RowsStream: TStringBuilder; SheetDataNode: IXMLNode; SheetIndex: Integer; ARow: Integer; var Eof: Boolean); virtual;
    procedure WriteValue(RowsStream: TStringBuilder; SheetIndex: Integer; ACol, ARow: Integer); virtual;
    function GetCell(SheetIndex: Integer; ACol, ARow: Integer): TXlsFileCellEh; virtual;

  public
    constructor Create(XlsFile: TXlsMemFileEh);
    destructor Destroy; override;

    procedure WritetToFile(const AFileName: String); virtual;
    property CurRowNum: Integer read GetCurRowNum;
    property CurColNum: Integer read GetCurColNum;
  end;

function ZEGetA1ByCol(ColNum: Integer; StartZero: Boolean = True): string;
function ZEGetColByA1(const A1Str: String; StartZero: Boolean = True): Integer;
function ZEA1RectToRect(const A1Rect: String): TRect;
function ZEA1CellToPoint(const A1CellRef: String): TPoint;
function XlsxNumFormatToVCLFormat(const XlsxNumFormatId, XlsxNumFormat: String): String;
function XlsxCellTypeNameToVaType(const tn: String): TVarType;


implementation


const
  ZE_STR_ARRAY: array [0..25] of char = (
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
  'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

var
  NumberFormatArr: array[0..49] of String =
  (
    '', 
    '0', 
    '0.00', 
    '#,##0', 
    '#,##0.00', 
    '', 
    '', 
    '', 
    '', 
    '0%', 
    '0.00%', 
    '0.00E+00', 
    '# ?/?', 
    '# ??/??', 
    'mm-dd-yy', 
    'd-mmm-yy', 
    'd-mmm', 
    'mmm-yy', 
    'h:nn AM/PM', 
    'h:nn:ss AM/PM', 
    'h:nn', 
    'h:nn:ss', 
    'm/d/yy h:nn', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '', 
    '#,##0; (#,##0)', 
    '#,##0;[Red](#,##0)', 
    '#,##0.00;(#,##0.00)', 
    '#,##0.00;[Red](#,##0.00)', 
    '', 
    '', 
    '', 
    '', 
    'nn:ss', 
    '[h]:nn:ss', 
    'nnss.0', 
    '##0.0E+0', 
    '@' 
  );

{*
Text code    |  Description                                      |  Example

Empty string.   General. Format depends of value type.
[1]             Simple number format show integer part or 0.       0
[2]             Simple number format with two decimal places.      0.00
[3]             Integer number format with thousands separator.    #,##0
[4]             Format with thousands separator and two decimal places.    #,##0.00
[5]             Not used
[6]             Not used
[7]             Not used
[8]             Not used
[9]             Integer percentages                                0%
[10]            Percentages with two decimal places                0.00%
[11]            Scientific format.                                 0.00E+00
[12]            Digit placeholder. This symbol follows the same rules as the 0 symbol. ?/?
[13]            Digit placeholder. This symbol follows the same rules as the 0 symbol. ??/??
[14]            ShortDateFormat from Regional settings             mm-dd-yyyy
[15]                                                               d-mmm-yy
[16]                                                               d-mmm
[17]                                                               mmm-yy
[18]            Hours:minutes AM/PM                                h:mm AM/PM
[19]                                                               h:mm:ss AM/PM
[20]            Hours:minutes (24h)                                h:mm
[22]            h:mm:ss (24h)                                      h:mm:ss
[23]            Date time                                          m/d/yy h:mm
....            Not used
[37]            Integer positif, negative number from Regional settings  #,##0 ;(#,##0)
[38]            Integer positif, negative (Rec color) number from Regional settings #,##0;[Red](#,##0)
[39]            Number with two decimal places and negative number from Regional settings #,##0.00;(#,##0.00)
[40]            Number with two decimal places and negative (Rec color) number from Regional settings #,##0.00;[Red](#,##0.00)
....            Not used
[45]            Minutes:seconds                                    mm:ss
[46]            Hours:minutes:seconds                              [h]:mm:ss
[47]            Milliseconds                                       mmss.0
[48]            Scientific format with thousands separator.        ##0.0E+0
[49]            Text placeholder. If text is typed in the cell, the text from the cell is placed in the format where the at symbol (@) appears.
...             Not used
[81]            Not used

[-1]            Long date format from Regional settings            [$-F800]dddd\,\ mmmm\ dd\,\ yyyy
[-2]            Time format from Regional settings                 [$-F400]h:mm:ss\ AM/PM
*}

const
  SecretSystLDateFormatCode = 'F800';

function ConvertXlsxNumFormatToVCLFormat(const XlsxNumFormat: String): String;
var
  i: Integer;
  InBrakets: Boolean;
  EndOfS, ElapsedSign: String;
  LocaleCode: String;
begin
  Result := '';
  i := 1;
  InBrakets := False;
  ElapsedSign := '';
  LocaleCode := '';
  while i <= Length(XlsxNumFormat) do
  begin
    if InBrakets then
    begin
      if XlsxNumFormat[i] = ']' then
      begin
        InBrakets := False;
        Result := Result + ElapsedSign;
        ElapsedSign := '';
      end else if (XlsxNumFormat[i] = 'h') and ( (Length(ElapsedSign) = 0) or (ElapsedSign[1] = 'h') ) then
        ElapsedSign := ElapsedSign + 'h'
      else if (XlsxNumFormat[i] = 'm') and ((Length(ElapsedSign) = 0) or (ElapsedSign[1] = 'm')) then
        ElapsedSign := ElapsedSign + 'n'
      else if (XlsxNumFormat[i] = 's') and ((Length(ElapsedSign) = 0) or (ElapsedSign[1] = 's')) then
        ElapsedSign := ElapsedSign + 's'
      else
        ElapsedSign := '';

      if InBrakets and CharInSetEh(XlsxNumFormat[i], ['A','B','C','D','E','F','0','1','2','3','4','5','6','7','8','9']) then
        LocaleCode := LocaleCode + XlsxNumFormat[i];

      i := i + 1;
      Continue;
    end;
    if XlsxNumFormat[i] = '[' then
    begin
      i := i + 1;
      InBrakets := True;
      Continue;
    end;
    if CharInSetEh(XlsxNumFormat[i], ['_', '*']) then
    begin
      i := i + 2;
      Continue;
    end;
    if XlsxNumFormat[i] = '\' then
    begin
      i := i + 1;
      if i <= Length(XlsxNumFormat) then
      begin
        Result := Result + '"'+XlsxNumFormat[i]+'"';
        i := i + 1;
      end;
      Continue;
    end;
    Result := Result + XlsxNumFormat[i];
    i := i + 1;
  end;

  EndOfS := Copy(Result, Length(Result)-1, 2);
  if EndOfS = ';@' then
    Result := Copy(Result, 1, Length(Result)-2);
  if LocaleCode = SecretSystLDateFormatCode then
    Result := FormatSettings.LongDateFormat;
end;

function XlsxNumFormatToVCLFormat(const XlsxNumFormatId, XlsxNumFormat: String): String;
begin
  if XlsxNumFormat <> '' then
    Result := ConvertXlsxNumFormatToVCLFormat(XlsxNumFormat)
  else if StrToInt(XlsxNumFormatId) = 14 then
    Result := FormatSettings.ShortDateFormat
  else if StrToInt(XlsxNumFormatId) <= 49 then
    Result := NumberFormatArr[StrToInt(XlsxNumFormatId)]
  else
    Result := '';
end;

function XlsxCellTypeNameToVaType(const tn: String): TVarType;
var
  StrType: TVarType;
begin
{$IFDEF EH_LIB_12}
  StrType := varUString;
{$ELSE}
  StrType := varOleStr;
{$ENDIF}
  if tn = 'b' then
    Result := varBoolean
  else if tn = 'd' then
    Result := varDate
  else if tn = 'e' then
    Result := StrType
  else if tn = 'inlineStr' then
    Result := StrType
  else if tn = 'n' then
    Result := varDouble
  else if tn = 's' then
    Result := StrType
  else if tn = 'str' then
    Result := StrType
  else
    Result := varDouble
end;

function ZEA1RectToRect(const A1Rect: String): TRect;
var
  i: Integer;
  s1, s2: String;
  Done: Boolean;
begin
  Result := EmptyRect;
  Done := False;
  for i := 1 to Length(A1Rect) do
  begin
    if A1Rect[i] = ':' then
    begin
      s1 := Copy(A1Rect, 1, i-1);
      Result.TopLeft := ZEA1CellToPoint(s1);
      s2 := Copy(A1Rect, i+1, Length(A1Rect));
      Result.BottomRight := ZEA1CellToPoint(s2);
      Done := True;
      Break;
    end;
  end;
  if not Done then
  begin
    Result.TopLeft := ZEA1CellToPoint(A1Rect);
    Result.BottomRight := ZEA1CellToPoint(A1Rect);
  end;
end;

function ZEA1CellToPoint(const A1CellRef: String): TPoint;
var
  i: Integer;
  sx, sy: String;
begin
  Result.X := 0;
  Result.Y := 0;
  for i := 1 to Length(A1CellRef) do
  begin
    if CharInSetEh(A1CellRef[i], ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
    begin
      sx := Copy(A1CellRef, 1, i-1);
      sy := Copy(A1CellRef, i, Length(A1CellRef));
      Result.X := ZEGetColByA1(sx);
      Result.Y := StrToInt(sy) - 1;
      Break;
    end;
  end;
end;

function ZEGetColByA1(const A1Str: String; StartZero: Boolean = True): Integer;
var
  i: Integer;
  c: Char;
  Mul: Integer;
begin
  Result := -1;
  Mul := -1;
  for i := Length(A1Str) downto 1 do
  begin
    if CharInSetEh(A1Str[i], ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
      Continue;
    c := UpperCase(A1Str[i])[1];
    case c of
      'A': Mul := 1;
      'B': Mul := 2;
      'C': Mul := 3;
      'D': Mul := 4;
      'E': Mul := 5;
      'F': Mul := 6;
      'G': Mul := 7;
      'H': Mul := 8;
      'I': Mul := 9;
      'J': Mul := 10;
      'K': Mul := 11;
      'L': Mul := 12;
      'M': Mul := 13;
      'N': Mul := 14;
      'O': Mul := 15;
      'P': Mul := 16;
      'Q': Mul := 17;
      'R': Mul := 18;
      'S': Mul := 19;
      'T': Mul := 20;
      'U': Mul := 21;
      'V': Mul := 22;
      'W': Mul := 23;
      'X': Mul := 24;
      'Y': Mul := 25;
      'Z': Mul := 26;
    end;
    if Result = -1 then
      Result := Mul
    else
      Result := Mul * 26 + Result;
  end;
  Result := Result - 1;
end;

function ZEGetA1byCol(ColNum: Integer; StartZero: Boolean = True): string;
var
  t, n: Integer;
  S: string;
begin
  t := ColNum;
  if (not StartZero) then
    Dec(t);
  Result := '';
  S := '';
  while t >= 0 do
  begin
    n := t mod 26;
    t := (t div 26) - 1;
    S := S + ZE_STR_ARRAY[n];
  end;
  for t := Length(S) downto 1 do
    Result := Result + S[t];
end;

function IsNumber(const st: String): Boolean;
var
  b: Boolean;
  i, n: Integer;
begin
  b := True;
  n := Length(st);
  for i := 1 to n do
    if not CharInSetEh(st[i], ['#', '0', ',', '.']) then
      b := False;
  Result := b;
end;

function ColorToHex(Acolor: TColor): String;
begin
  Result :=
    IntToHex(GetRValue(ColorToRGB(AColor)), 2) +
    IntToHex(GetGValue(ColorToRGB(AColor)), 2) +
    IntToHex(GetBValue(ColorToRGB(AColor)), 2);
end;

function VarIsDBNumeric(const V: Variant): Boolean;
begin
  Result := VarIsNumeric(V) or VarIsFMTBcd(v);
end;

function StrToXMLValue(const s: String): String;
begin
  Result := s;
  if AnsiPos('#0', Result) >= 1 then
  Result := StringReplace(Result, #0, ' ', [rfReplaceAll]);
  if AnsiPos('&', Result) >= 1 then
  Result := StringReplace(Result,   '&', '&amp;',[rfReplaceAll]);
  if AnsiPos('<', Result) >= 1 then
  Result := StringReplace(Result, '<', '&lt;',[rfReplaceAll]);
  if AnsiPos('>', Result) >= 1 then
  Result := StringReplace(Result, '>', '&gt;',[rfReplaceAll]);
end;

{ TXlsxFileWriterEh }

procedure InitXMLDocument(var XML: IXMLDocument);
begin
//  XML.Options := XML.Options - [doNamespaceDecl, doAutoPrefix];
  XML.Encoding := 'UTF-8';
  XML.StandAlone := 'yes';
end;

procedure ToTheme(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh);
{$IFDEF FPC}
var
  XML: TXMLDocument;
  SS: TStringStream;
begin
  SS := TStringStream.Create(SThemeEh);
  ReadXMLFile(XML, SS);
  SS.Free;
  XML.SetHeaderData(xmlVersion10, 'UTF-8');
  WriteXMLFile(XML, Stream);
end;
{$ELSE}
var
  XML: IXMLDocument;
begin
  XML := NewXMLDocument;
  XML.LoadFromXML(SThemeEh);
  XML.SaveToStream(Stream);
end;
{$ENDIF}

procedure ToRels(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh);
const
  st = 'http://schemas.openxmlformats.org/package/2006/relationships';
  ArrId: array [1 .. 3] of string = ('rId3', 'rId2', 'rId1');
  ArrType: array [1 .. 3] of string =
    ('http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties',
     'http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties',
     'http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument');
  ArrTarget: array [1 .. 3] of string = (
    'docProps/app.xml',
    'docProps/core.xml',
    'xl/workbook.xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
  Rel: IXMLNode;
begin
  Xml := NewXMLDocument;

  InitXMLDocument(Xml);
  Root := Xml.AddChild('Relationships');
  //Root.Attributes['xmlns'] := st;
  Root.DeclareNamespace('', st);
  //Root := Xml.CreateElement('Relationships', st);
  for i := 1 to 3 do
  begin
    //Rel := Xml.CreateElement('Relationship', st);
    Rel := Root.AddChild('Relationship', st);
    Rel.Attributes['Id'] := ArrId[i];
    Rel.Attributes['Type'] := ArrType[i];
    Rel.Attributes['Target'] := ArrTarget[i];
    //Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  //Root.Attributes['xmlns'] := st;
  Xml.SaveToStream(Stream);
end;

procedure ToRelsWorkbook(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh);
const
  st = 'http://schemas.openxmlformats.org/package/2006/relationships';
  ArrType: array [1 .. 3] of string =
    ('http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet');
  ArrTarget: array [1 .. 3] of string = ('styles.xml', 'theme/theme1.xml',
    'worksheets/sheet1.xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
  SheetCount: Integer;
begin
  Xml := NewXMLDocument;

  InitXMLDocument(Xml);
  Root := Xml.AddChild('Relationships');
  Root.DeclareNamespace('', st);

  SheetCount := XlsxFileWriter.FXlsFile.Workbook.WorksheetCount;

  for i := SheetCount downto 1 do
  begin
    Root := Xml.CreateElement('Relationship', st);
    Root.Attributes['Id'] := 'rId' + IntToStr(i);
    Root.Attributes['Type'] := ArrType[3];
    Root.Attributes['Target'] := 'worksheets/sheet' + IntToStr(i) + '.xml';
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  for i := 1 to 2 do
  begin
    Root := Xml.CreateElement('Relationship', st);
    Root.Attributes['Id'] := 'rId' + IntToStr(i + SheetCount);
    Root.Attributes['Type'] := ArrType[i];
    Root.Attributes['Target'] := ArrTarget[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Xml.SaveToStream(Stream);
end;

procedure ToApp(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh);
const
  st = 'http://schemas.openxmlformats.org/officeDocument/2006/extended-properties';
  ArrElement: array [1 .. 8] of string = ('Application', 'DocSecurity',
    'ScaleCrop', 'Company', 'LinksUpToDate', 'SharedDoc', 'HyperlinksChanged',
    'AppVersion');
  ArrText: array [1 .. 8] of string = ('Microsoft Excel', '0', 'false',
    '', 'false', 'false', 'false', '14.0300');
var
  i: Integer;
  Xml: IXMLDocument;
  Root, Node: IXMLNode;
  SheetCount: Integer;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('Properties');
  //Root.Attributes['xmlns'] := st;
  Root.DeclareNamespace('', st);
  Root.Attributes['xmlns:vt'] := 'http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes';

  for i := 1 to 8 do
  begin
    Root := Xml.CreateElement(ArrElement[i], st);
    Root.Text := ArrText[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  SheetCount := XlsxFileWriter.FXlsFile.Workbook.WorksheetCount;

  Root := Xml.CreateElement('HeadingPairs', st);
  Node := Root.AddChild('vt:vector');
  Node.Attributes['size'] := 2;
  Node.Attributes['baseType'] := 'variant';
  Node.AddChild('vt:variant').AddChild('vt:lpstr').Text := 'Sheets';
  Node.AddChild('vt:variant').AddChild('vt:i4').Text := IntToStr(SheetCount);
  Xml.DocumentElement.ChildNodes.Add(Root);

  Root := Xml.CreateElement('TitlesOfParts', st);
  Node := Root.AddChild('vt:vector');
  Node.Attributes['size'] := IntToStr(SheetCount);
  Node.Attributes['baseType'] := 'lpstr';

  for i := 0 to SheetCount-1 do
  begin
    Node.AddChild('vt:lpstr').Text := XlsxFileWriter.FXlsFile.Workbook.Worksheets[i].Name;
  end;

  Xml.DocumentElement.ChildNodes.Add(Root);

  Xml.SaveToStream(Stream);
end;

procedure ToCore(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh);
const
  st = 'http://schemas.openxmlformats.org/package/2006/metadata/core-properties';
  ArrAttribut: array [1 .. 5] of string = ('xmlns:cp', 'xmlns:dc',
    'xmlns:dcterms', 'xmlns:dcmitype', 'xmlns:xsi');
  ArrTextAttribut: array [1 .. 5] of string = (st,
    'http://purl.org/dc/elements/1.1/', 'http://purl.org/dc/terms/',
    'http://purl.org/dc/dcmitype/',
    'http://www.w3.org/2001/XMLSchema-instance');
  ArrCreator: array [1 .. 3] of string = ('dc:creator', 'cp:lastModifiedBy',
    'dcterms:created');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('cp:coreProperties');

  for i := 1 to 5 do
    Root.Attributes[ArrAttribut[i]] := ArrTextAttribut[i];

  for i := 1 to 3 do
  begin
    Root := Xml.CreateElement(ArrCreator[i], '');
    if i < 3 then
      Root.Text := 'EhLib'
    else
      Root.Text := FormatDateTime('yyyy-mm-dd', Date) + 'T' +
        FormatDateTime('hh:mm:ss', Time) + 'Z';
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Root.Attributes['xsi:type'] := 'dcterms:W3CDTF';

  Xml.SaveToStream(Stream);
end;

procedure ToWorkbook(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 8] of string = ('xl', '5', '5', '9303', '480',
    '120', '27795', '12585');
  ArrNameAttributes: array [1 .. 8] of string = ('appName', 'lastEdited',
    'lowestEdited', 'rupBuild', 'xWindow', 'yWindow', 'windowWidth',
    'windowHeight');
var
  i: Integer;
  Xml: IXMLDocument;
  Root, Node: IXMLNode;
  SheetCount: Integer;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('workbook');
  Root.DeclareNamespace('', st);

  Root.Attributes['xmlns:r'] :=
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships';

  Root := Xml.CreateElement('fileVersion', st);
  for i := 1 to 4 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('workbookPr', st);
  Root.Attributes['defaultThemeVersion'] := '124226';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('bookViews', st);
  Node := Root.AddChild('workbookView');
  for i := 5 to 8 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheets', st);

  SheetCount := XlsxFileWriter.FXlsFile.Workbook.WorksheetCount;

  for i := 1 to SheetCount do
  begin
    Node := Root.AddChild('sheet');

    Node.Attributes['name'] := XlsxFileWriter.FXlsFile.Workbook.Worksheets[i-1].Name;
    Node.Attributes['sheetId'] := IntToStr(i);
    Node.Attributes['r:id'] := 'rId' + IntToStr(i);
  end;

  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('calcPr', st);
  Root.Attributes['calcId'] := '145621';
  Xml.DocumentElement.ChildNodes.Add(Root);

  Xml.SaveToStream(Stream);
end;

procedure ToContentTypes(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh);
const
  st = 'http://schemas.openxmlformats.org/package/2006/content-types';
  ArrExtension: array [1 .. 8] of string = ('rels', 'xml', '/xl/workbook.xml',
    '/xl/worksheets/sheet1.xml', '/xl/theme/theme1.xml', '/xl/styles.xml',
    '/docProps/core.xml', '/docProps/app.xml');
  ArrContent: array [1 .. 8] of string =
    ('application/vnd.openxmlformats-package.relationships+xml',
    'application/xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml',
    'application/vnd.openxmlformats-officedocument.theme+xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml',
    'application/vnd.openxmlformats-package.core-properties+xml',
    'application/vnd.openxmlformats-officedocument.extended-properties+xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
  SheetCount: Integer;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('Types');
  //Root.Attributes['xmlns'] := st;
  Root.DeclareNamespace('', st);


  for i := 1 to 2 do
  begin
    Root := Xml.CreateElement('Default', st);
    Root.Attributes['Extension'] := ArrExtension[i];
    Root.Attributes['ContentType'] := ArrContent[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  for i := 3 to 3 do
  begin
    Root := Xml.CreateElement('Override', st);
    Root.Attributes['PartName'] := ArrExtension[i];
    Root.Attributes['ContentType'] := ArrContent[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  SheetCount := XlsxFileWriter.FXlsFile.Workbook.WorksheetCount;

  for i := 1 to SheetCount do
  begin
    Root := Xml.CreateElement('Override', st);
    Root.Attributes['PartName'] := '/xl/worksheets/sheet' + IntToStr(i) + '.xml';
    Root.Attributes['ContentType'] := ArrContent[4];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  for i := 5 to 8 do
  begin
    Root := Xml.CreateElement('Override', st);
    Root.Attributes['PartName'] := ArrExtension[i];
    Root.Attributes['ContentType'] := ArrContent[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  Xml.SaveToStream(Stream);

end;

procedure CreateStylesXml(var Xml: IXMLDocument);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 25] of string = (st,
    'http://schemas.openxmlformats.org/markup-compatibility/2006', 'x14ac',
    'http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac',
    '204', '11', '1', 'Calibri', '2', 'minor', '0', '0', '0', '0', '0', '0', '0', '0', '0',
    'Normal', '0', '0', '0', 'TableStyleMedium2', 'PivotStyleLight16');
  ArrNameAttributes: array [1 .. 25] of string = ('xmlns', 'xmlns:mc',
    'mc:Ignorable', 'xmlns:x14ac', 'val', 'val', 'theme', 'val', 'val', 'val',
    'numFmtId', 'fontId', 'fillId', 'borderId', 'numFmtId', 'fontId', 'fillId',
    'borderId', 'xfId', 'name', 'xfId', 'builtinId', 'count',
    'defaultTableStyle', 'defaultPivotStyle');
  ArrChild: array [6 .. 15] of string = ('sz', 'color', 'name', 'family',
    'scheme', 'left', 'right', 'top', 'bottom', 'diagonal');
var
  i: Integer;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('styleSheet');
  Root.DeclareNamespace('', st);

  Root := Xml.CreateElement('fonts', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('font');
  for i := 6 to 10 do
    Node.AddChild(ArrChild[i]).Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('fills', st);
  Root.Attributes['count'] := '2';
  Root.AddChild('fill').AddChild('patternFill').Attributes['patternType'] := 'none';
  Root.AddChild('fill').AddChild('patternFill').Attributes['patternType'] := 'gray125';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('borders', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('border');
  for i := 11 to 15 do
    Node.AddChild(ArrChild[i]);
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellStyleXfs', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('xf');
  for i := 11 to 14 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellXfs', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('xf');
  for i := 15 to 19 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellStyles', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('cellStyle');
  for i := 20 to 22 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('dxfs', st);
  Root.Attributes['count'] := '0';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('tableStyles', st);
  for i := 23 to 25 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('extLst', st);
  Node := Root.AddChild('ext');
  Node.Attributes['uri'] := '{EB79DEF2-80B8-43e5-95BD-54CBDDF9020C}';
  Node.Attributes['xmlns:x14'] := 'http://schemas.microsoft.com/office/spreadsheetml/2009/9/main';
  Node.AddChild('x14:slicerStyles').Attributes['defaultSlicerStyle'] := 'SlicerStyleLight1';
  Xml.DocumentElement.ChildNodes.Add(Root);
end;

constructor TXlsxFileWriterEh.Create(XlsFile: TXlsMemFileEh);
begin
  inherited Create;
  FXlsFile := XlsFile;
end;

destructor TXlsxFileWriterEh.Destroy;
begin
  inherited Destroy;
end;

procedure TXlsxFileWriterEh.InitFileData;
begin
  if ZipFileProviderClass = nil then
    raise Exception.Create('ZipFileProviderClass is not assigned');
  FZipFileProvider := ZipFileProviderClass.CreateInstance;
  FZipFileProvider.InitZipFileWriting(FFileName);
end;

procedure TXlsxFileWriterEh.CreateXMLs;
begin
  CreateStaticXMLs;
  CreateDynamicXMLs;
end;

procedure TXlsxFileWriterEh.CreateStaticXMLs;
const
  Resours: array [1 .. 7] of
    procedure(var Stream: TStream; XlsxFileWriter: TXlsxFileWriterEh) =
    (ToTheme, ToRels,
     ToApp, ToCore, ToRelsWorkbook,
     ToWorkbook, ToContentTypes);
  ResoursFile: array [1 .. 7] of string =
    ('xl/theme/theme1.xml', '_rels/.rels',
     'docProps/app.xml', 'docProps/core.xml', 'xl/_rels/workbook.xml.rels',
     'xl/workbook.xml', '[Content_Types].xml');

var
  i: Integer;
  Res: TStream;
begin

  for i := 1 to 7 do
  begin
    Res := TMemoryStream.Create;
    Resours[i](Res, Self);
    Res.Seek(System.Longint(0), soFromBeginning);
    FZipFileProvider.AddFile(Res, ResoursFile[i]);
    Res.Free;
  end;
end;

procedure TXlsxFileWriterEh.CreateDynamicXMLs;
var
  i: Integer;
begin
  SetLength(FXMLSheets, FXlsFile.Workbook.WorksheetCount);
  SetLength(FSheetRowsStreams, FXlsFile.Workbook.WorksheetCount);
  for i := 0 to Length(FXMLSheets)-1 do
  begin
    FXMLSheets[i] := CreateSheetXml(i = 0, FXlsFile.Workbook.Worksheets[i]);
    //FSheetRowsStreams[i] := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
    FSheetRowsStreams[i] := TStringBuilder.Create;
  end;

  CreateStylesXml(FXMLStyles);

  FCurRow := 1;
end;

function TXlsxFileWriterEh.CreateSheetXml(FirstSheet: Boolean; Worksheet: TXlsWorksheetEh): IXMLDocument;
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 5] of string = (st,
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
    'http://schemas.openxmlformats.org/markup-compatibility/2006', 'x14ac',
    'http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac');
  ArrNameAttributes: array [1 .. 5] of string = ('xmlns', 'xmlns:r', 'xmlns:mc',
    'mc:Ignorable', 'xmlns:x14ac');

  function PageSetupHaveData(PrintParams: TXlsFileWorksheetPrintParamsEh): Boolean;
  begin
    Result := False;
    if PrintParams.FitToPagesWide > 1 then
      Result := True;
    if PrintParams.FitToPagesTall > 1 then
      Result := True;
    if PrintParams.Orientation <> poPortrait then
      Result := True;
    if PrintParams.Scale <> 100 then
      Result := True;
  end;

var
  i: Integer;
  Root, Node: IXMLNode;
  WorksheetNode: IXMLNode;
  OutlineLevelRow: Integer;
begin
  Result := NewXMLDocument;
  InitXMLDocument(Result);
  WorksheetNode := Result.AddChild('worksheet');
  WorksheetNode.DeclareNamespace('', st);
  for i := 2 to 5 do
    WorksheetNode.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];

  if (Worksheet.PrintParams.ScalingMode = fpsmFitToPagesEh) or
     (Worksheet.TabColor <> clNone) or
     //(Worksheet.RowGrouping.Direction = drgdUpwardEh)
     (Worksheet.OutlineRowsSummaryBelow = False) or
     (Worksheet.OutlineColsSummaryRight = False)
  then
  begin
    Root := WorksheetNode.AddChild('sheetPr');
    if (Worksheet.PrintParams.ScalingMode = fpsmFitToPagesEh) then
    begin
      Node := Root.AddChild('pageSetUpPr');
      Node.Attributes['fitToPage'] := 1;
    end;

    if (Worksheet.TabColor <> clNone) then
    begin
      Node := Root.AddChild('tabColor');
      Node.Attributes['rgb'] := 'FF' + ColorToHex(Worksheet.TabColor);
    end;

    if (Worksheet.OutlineRowsSummaryBelow = False) or
       (Worksheet.OutlineColsSummaryRight = False) then
    begin
      Node := Root.AddChild('outlinePr');
      if Worksheet.OutlineColsSummaryRight = False then
        Node.Attributes['summaryRight'] := '0';
      if Worksheet.OutlineRowsSummaryBelow = False then
        Node.Attributes['summaryBelow'] := '0';
    end;
  end;

  
  Root := Result.CreateElement('dimension', st);
  Root.Attributes['ref'] :=
      ZEGetA1byCol(Worksheet.Dimension.FromCol) + IntToStr(Worksheet.Dimension.FromRow + 1) + ':' +
      ZEGetA1byCol(Worksheet.Dimension.ToCol) + IntToStr(Worksheet.Dimension.ToRow + 1);
  Result.DocumentElement.ChildNodes.Add(Root);

  
  Root := Result.CreateElement('sheetViews', st);
  Node := Root.AddChild('sheetView');
  if (FirstSheet) then
    Node.Attributes['tabSelected'] := '1';
  Node.Attributes['workbookViewId'] := '0';
  Node.Attributes['zoomScale'] := Worksheet.ZoomScale;

  
  Result.DocumentElement.ChildNodes.Add(Root);
  Root := Result.CreateElement('sheetFormatPr', st);
  if (Worksheet.DefaultColWidth <> 8.43) then
    Root.Attributes['defaultColWidth'] := SysFloatToStr(Worksheet.DefaultColWidth + 0.7109375);
  Root.Attributes['defaultRowHeight'] := SysFloatToStr(Worksheet.DefaultRowHeight);
  OutlineLevelRow := Worksheet.GetOutlineLevelForRows;
  if (OutlineLevelRow > 0) then
    Root.Attributes['outlineLevelRow'] := OutlineLevelRow;

  Root.Attributes['x14ac:dyDescent'] := '0.25';
  Result.DocumentElement.ChildNodes.Add(Root);

  
  Root := Result.CreateElement('cols', st);
  Result.DocumentElement.ChildNodes.Add(Root);

  
  Root := Result.CreateElement('sheetData', st);
  Result.DocumentElement.ChildNodes.Add(Root);

  
  WriteAutoFilterInfo(Worksheet, Result);

  
  WriteMergeCellsInfo(Worksheet, Result);

  
  if (Worksheet.PrintParams.VerticalCentered) or
     (Worksheet.PrintParams.VerticalCentered) then
  begin
    Root := Result.CreateElement('printOptions', st);
    if Worksheet.PrintParams.HorizontalCentered then
      Root.Attributes['horizontalCentered'] := 1;
    if Worksheet.PrintParams.VerticalCentered then
      Root.Attributes['verticalCentered'] := 1;
    Result.DocumentElement.ChildNodes.Add(Root);
  end;

  
  Root := Result.CreateElement('pageMargins', st);
  Root.Attributes['left'] := SysFloatToStr(Worksheet.PrintParams.PageMargins.Left);
  Root.Attributes['right'] := SysFloatToStr(Worksheet.PrintParams.PageMargins.Right);
  Root.Attributes['top'] := SysFloatToStr(Worksheet.PrintParams.PageMargins.Top);
  Root.Attributes['bottom'] := SysFloatToStr(Worksheet.PrintParams.PageMargins.Bottom);
  Root.Attributes['header'] := SysFloatToStr(Worksheet.PrintParams.PageMargins.Header);
  Root.Attributes['footer'] := SysFloatToStr(Worksheet.PrintParams.PageMargins.Footer);
  Result.DocumentElement.ChildNodes.Add(Root);

  
  if (PageSetupHaveData(Worksheet.PrintParams)) then
  begin
    Root := Result.CreateElement('pageSetup', st);

    if Worksheet.PrintParams.Scale <> 100 then
      Root.Attributes['scale'] := SysFloatToStr(Worksheet.PrintParams.Scale);
    if Worksheet.PrintParams.FitToPagesWide > 1 then
      Root.Attributes['fitToWidth'] := SysFloatToStr(Worksheet.PrintParams.FitToPagesWide);
    if Worksheet.PrintParams.FitToPagesTall > 1 then
      Root.Attributes['fitToHeight'] := SysFloatToStr(Worksheet.PrintParams.FitToPagesTall);
    if Worksheet.PrintParams.Orientation <> poPortrait then
      Root.Attributes['orientation'] := 'landscape';

    Result.DocumentElement.ChildNodes.Add(Root);
  end;

  
  if (Worksheet.PrintParams.PageHeader <> '') or
     (Worksheet.PrintParams.PageFooter <> '') then
  begin
    Root := Result.CreateElement('headerFooter', st);

    if Worksheet.PrintParams.PageHeader <> '' then
    begin
      Node := Root.AddChild('oddHeader');
      Node.NodeValue := Worksheet.PrintParams.PageHeader;
    end;

    if Worksheet.PrintParams.PageFooter <> '' then
    begin
      Node := Root.AddChild('oddFooter');
      Node.NodeValue := Worksheet.PrintParams.PageFooter;
    end;

    Result.DocumentElement.ChildNodes.Add(Root);
  end;
end;

procedure TXlsxFileWriterEh.WriteXMLs;
var
  i: Integer;
begin
  for i := 0 to Length(FXMLSheets)-1 do
  begin
    WriteSheetXML(i, FXMLSheets[i], FSheetRowsStreams[i]);
  end;

  WriteStylesXML;

  for i := 0 to Length(FSheetRowsStreams)-1 do
  begin
    FSheetRowsStreams[i].Free;
  end;
  SetLength(FSheetRowsStreams, 0);
end;

procedure TXlsxFileWriterEh.WriteSheetXML(SheetIndex: Integer; XMLSheet: IXMLDocument; RowsString: TStringBuilder);
var
  Res: TStringStream;
  Root: IXMLNode;
  RowsStreams: TStringStream;
begin
  //FRowNode := nil;

  Root := XMLSheet.DocumentElement.ChildNodes.FindNode('cols');

  WriteColumnsSec(SheetIndex, Root);

  if (Root.ChildNodes.Count = 0) then
  begin
    Root.GetParentNode.ChildNodes.Delete('cols');
  end;

//  Res := TMemoryStream.Create;
  Res := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  RowsStreams := TStringStream.Create(RowsString.ToString {$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  MergeSheetXMLAndRowsSream(XMLSheet, RowsStreams, Res);
//  XMLSheet.SaveToStream(Res);
//
//  Res.Seek(System.Longint(0), soFromBeginning);
  FZipFileProvider.AddFile(Res, 'xl/worksheets/sheet' + IntToStr(SheetIndex+1) + '.xml');

  Res.Free;
  RowsStreams.Free;
end;

procedure TXlsxFileWriterEh.MergeSheetXMLAndRowsSream(XMLSheet: IXMLDocument; RowsStream: TStringStream; ResultStream: TStringStream);
var
  XMLSheetAsStr: String;
  StartSheetDataPos: Integer;
  SheetStr1, SheetStr2: String;
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  XMLSheet.SaveToStream(StrStream);
  XMLSheetAsStr := StrStream.DataString;
  //XMLSheet.SaveToXML(XMLSheetAsStr);

  StartSheetDataPos := Pos('<sheetData/>', XMLSheetAsStr);

  SheetStr1 := Copy(XMLSheetAsStr, 1, StartSheetDataPos - 1);
  SheetStr2 := Copy(XMLSheetAsStr, StartSheetDataPos + Length('<sheetData/>'), Length(XMLSheetAsStr));

  ResultStream.WriteString(SheetStr1);
  ResultStream.WriteString('<sheetData>' + RowsStream.DataString + '</sheetData>');
  ResultStream.WriteString(SheetStr2);

//  XMLSheet.SaveToStream(ResultStream);

  ResultStream.Seek(System.Longint(0), soFromBeginning);
  StrStream.Free;
end;

procedure TXlsxFileWriterEh.WriteColumnsSec(SheetIndex: Integer; Root: IXMLNode);

  procedure InitColumnData(Column: TXlsFileColumnEh;
    out StyleNo: Integer; out IsCustomWidth: Boolean; out ColWidth: Double;
    out Hidden: Boolean; out OutlineLevel: Integer; out OutlineNodeCollapsed: Boolean);
  begin
    if (Column <> nil) then
    begin
      Hidden := not Column.Visible;
      ColWidth := Column.Width + 0.7109375;
      IsCustomWidth := True;
      OutlineLevel := Column.OutlineLevel;
      OutlineNodeCollapsed := Column.OutlineNodeCollapsed;
      if (Column.Style <> nil)
        then StyleNo := Column.Style.Index
        else StyleNo := 0;
    end else
    begin
      StyleNo := 0;
      IsCustomWidth := True;
      ColWidth := 8.43 + 0.7109375;
      Hidden := False;
      OutlineLevel := 0;
      OutlineNodeCollapsed := False;
    end;
  end;

  procedure SetColumnNode(Node: IXMLNode;
    StyleNo: Integer; IsCustomWidth: Boolean; ColWidth: Double;
    Hidden: Boolean; OutlineLevel: Integer; OutlineNodeCollapsed: Boolean;
    MaxColIndex, MinColIndex: Integer);
  begin
    Node := Root.AddChild('col');

    Node.Attributes['width'] := SysVarToStr(ColWidth);
    Node.Attributes['customWidth'] := IsCustomWidth;

    if (Hidden = True) then
      Node.Attributes['hidden'] := 1;

    if (OutlineLevel > 0) then
      Node.Attributes['outlineLevel'] := IntToStr(OutlineLevel);

    if (OutlineNodeCollapsed) then
      Node.Attributes['collapsed'] := '1';

    if (StyleNo <> 0) then
      Node.Attributes['style'] := IntToStr(StyleNo);

    Node.Attributes['max'] := IntToStr(MaxColIndex + 1);
    Node.Attributes['min'] := IntToStr(MinColIndex + 1);
  end;

var
  i: Integer;
  Node: IXMLNode;
  Column: TXlsFileColumnEh;
  Hidden, NextHidden: Boolean;
  OutlineLevel, NextOutlineLevel: Integer;
  OutlineNodeCollapsed, NextOutlineNodeCollapsed: Boolean;
  StyleNo, NextStyleNo: Integer;
  IsCustomWidth, NextIsCustomWidth: Boolean;
  ColWidth, NextColWidth: Double;
  MinColIndex, MaxColIndex: Integer;
  Columns: TXlsFileColumnsEh;
begin
  Columns := FXlsFile.Workbook.Worksheets[SheetIndex].Columns;
  if Columns.CurrentCount = 0 then Exit;
  Column := GetColumn(SheetIndex, 0);
  MinColIndex := 0;

  InitColumnData(Column,
    StyleNo, IsCustomWidth, ColWidth, Hidden, OutlineLevel, OutlineNodeCollapsed);
//  NextStyleNo := StyleNo;
//  NextIsCustomWidth := NextIsCustomWidth;
//  NextColWidth,
//  NextHidden,
//  NextOutlineLevel,
//  NextOutlineNodeCollapsed,
//  MaxColIndex,
//  MinColIndex

  for i := 1 to Columns.CurrentCount - 1 do
  begin
//    Node.Attributes['min'] := i + 1;
//    Node.Attributes['max'] := i + 1;

    Column := GetColumn(SheetIndex, i);

    InitColumnData(Column,
      NextStyleNo, NextIsCustomWidth, NextColWidth, NextHidden, NextOutlineLevel, NextOutlineNodeCollapsed);

//    if (Column <> nil) then
//    begin
//      Hidden := not Column.Visible;
//      ColWidth := Column.Width + 0.7109375;
//      OutlineLevel := Column.OutlineLevel;
//      OutlineNodeCollapsed := Column.OutlineNodeCollapsed;
//      if (Column.Style <> nil)
//        then StyleNo := Column.Style.Index
//        else StyleNo := 0;
//    end else
//    begin
//      Hidden := False;
//      ColWidth := 8.43 + 0.7109375;
//      OutlineLevel := 0;
//      OutlineNodeCollapsed := False;
//      StyleNo := 0;
//    end;

    if (NextStyleNo <> StyleNo) or
       (NextIsCustomWidth <> IsCustomWidth) or
       (NextColWidth <> ColWidth) or
       (NextHidden <> Hidden) or
       (NextOutlineLevel <> OutlineLevel) or
       (NextOutlineNodeCollapsed <> OutlineNodeCollapsed) then
    begin
      MaxColIndex :=  i - 1;

      SetColumnNode(Node, StyleNo, IsCustomWidth, ColWidth, Hidden,
        OutlineLevel, OutlineNodeCollapsed, MaxColIndex, MinColIndex);

      MinColIndex :=  i;

      StyleNo := NextStyleNo;
      IsCustomWidth := NextIsCustomWidth;
      ColWidth := NextColWidth;
      Hidden := NextHidden;
      OutlineLevel := NextOutlineLevel;
      OutlineNodeCollapsed := NextOutlineNodeCollapsed;
    end;
  end;

  MaxColIndex := Columns.CurrentCount - 1;
  SetColumnNode(Node, StyleNo, IsCustomWidth, ColWidth, Hidden,
    OutlineLevel, OutlineNodeCollapsed, MaxColIndex, MinColIndex);
end;

procedure TXlsxFileWriterEh.WriteStylesXML;
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';

  LineStyleXmlNames: array[TXlsFileCellLineStyleEh] of String =
  (
    'none',
    'thin',
    'medium',
    'thick',
    'double',
    'dashDot',
    'dashDotDot',
    'dashed',
    'dotted',
    'hair',
    'mediumDashDot',
    'mediumDashDotDot',
    'mediumDashed',
    'slantDashDot'
  );

  FillPatternTypeXmlNames: array[TXlsFileStyleFillPatternTypeEh] of String =
  (
    'none',
    'solid',
    'mediumGray',
    'darkGray',
    'lightGray',
    'darkHorizontal',
    'darkVertical',
    'darkDown',
    'darkUp',
    'darkGrid',
    'darkTrellis',
    'lightHorizontal',
    'lightVertical',
    'lightDown',
    'lightUp',
    'lightGrid',
    'lightTrellis',
    'gray125',
    'gray0625'
  );

var
  i: Integer;
  Res: TStream;
  Root, Node, Node2, BorderNode: IXMLNode;
  StyleFont: TXlsFileStyleFont;
  StyleFill: TXlsFileStyleFill;
  StyleBorder: TXlsFileStyleLinesEh;
  CellStyle: TXlsFileCellStyle;
  NumFormatStyle: TXlsFileStyleNumberFormatEh;
  FmtNode: IXMLNode;
  StyleStr, ColorStr: String;
begin
  

  if (FXlsFile.Workbook.Styles.NumberFormatCount > 1) then
  begin
    FmtNode := FXMLStyles.CreateElement('numFmts', st);
    FmtNode.Attributes['count'] := FXlsFile.Workbook.Styles.NumberFormatCount - 1;

    for i := 1 to FXlsFile.Workbook.Styles.NumberFormatCount - 1 do
    begin
      if (not FXlsFile.Workbook.Styles.NumberFormat[i].IsStandardFormat) then
      begin
        NumFormatStyle := FXlsFile.Workbook.Styles.NumberFormat[i];
        Node := FmtNode.AddChild('numFmt');
        Node.Attributes['numFmtId'] := IntToStr(NumFormatStyle.FormatId);
        Node.Attributes['formatCode'] := NumFormatStyle.FormatStr;
      end;
    end;

    FXMLStyles.DocumentElement.ChildNodes.Insert(0, FmtNode);
  end;

  
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('fonts');
  Root.Attributes['count'] := FXlsFile.Workbook.Styles.FontCount;
  for i := 1 to FXlsFile.Workbook.Styles.FontCount - 1 do
  begin
    StyleFont := FXlsFile.Workbook.Styles.Font[i];
    Node := Root.AddChild('font');
    if StyleFont.IsBold then
      Node.AddChild('b');
    if StyleFont.IsItalic then
      Node.AddChild('i');
    if StyleFont.IsUnderline then
      Node.AddChild('u');
    Node.AddChild('sz').Attributes['val'] := StyleFont.Size;

    if (StyleFont.Color <> clNone) then
      Node.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(StyleFont.Color)
    else
      Node.AddChild('color').Attributes['theme'] := '1';

    Node.AddChild('name').Attributes['val'] := StyleFont.Name;
  end;

  
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('fills');
  Root.Attributes['count'] := FXlsFile.Workbook.Styles.FillCount;
  for i := 2 to FXlsFile.Workbook.Styles.FillCount - 1 do
  begin
    StyleFill := FXlsFile.Workbook.Styles.Fill[i];
    Node := Root.AddChild('fill').AddChild('patternFill');
    Node.Attributes['patternType'] := FillPatternTypeXmlNames[StyleFill.PatternType];
    Node.AddChild('fgColor').Attributes['rgb'] := 'FF' + ColorToHex(StyleFill.Color);
    Node.AddChild('bgColor').Attributes['rgb'] := 'FF' + ColorToHex(StyleFill.PatternColor);
  end;

  
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('borders');
  Root.Attributes['count'] := FXlsFile.Workbook.Styles.BorderCount;
  for i := 1 to FXlsFile.Workbook.Styles.BorderCount - 1 do
  begin
    BorderNode := Root.AddChild('border');
    StyleBorder := FXlsFile.Workbook.Styles.Border[i];

    Node2 := BorderNode.AddChild('left');
    if StyleBorder.Left.Style <> clsNoneEh then
    begin
      Node2.Attributes['style'] := LineStyleXmlNames[StyleBorder.Left.Style];
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(StyleBorder.Left.Color);
    end;

    Node2 := BorderNode.AddChild('right');
    if StyleBorder.Right.Style <> clsNoneEh then
    begin
      Node2.Attributes['style'] := LineStyleXmlNames[StyleBorder.Right.Style];
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(StyleBorder.Right.Color);
    end;

    Node2 := BorderNode.AddChild('top');
    if StyleBorder.Top.Style <> clsNoneEh then
    begin
      Node2.Attributes['style'] := LineStyleXmlNames[StyleBorder.Top.Style];
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(StyleBorder.Top.Color);
    end;

    Node2 := BorderNode.AddChild('bottom');
    if StyleBorder.Bottom.Style <> clsNoneEh then
    begin
      Node2.Attributes['style'] := LineStyleXmlNames[StyleBorder.Bottom.Style];
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(StyleBorder.Bottom.Color);
    end;

    Node2 := BorderNode.AddChild('diagonal');
    if (StyleBorder.DiagonalDown.Style <> clsNoneEh) or
       (StyleBorder.DiagonalUp.Style <> clsNoneEh) then
    begin
      if (StyleBorder.DiagonalDown.Style <> clsNoneEh) then
      begin
        StyleStr := LineStyleXmlNames[StyleBorder.DiagonalDown.Style];
        ColorStr := 'FF' + ColorToHex(StyleBorder.DiagonalDown.Color);
        BorderNode.Attributes['diagonalDown'] := 1;
      end;

      if (StyleBorder.DiagonalUp.Style <> clsNoneEh) then
      begin
        StyleStr := LineStyleXmlNames[StyleBorder.DiagonalUp.Style];
        ColorStr := 'FF' + ColorToHex(StyleBorder.DiagonalUp.Color);
        BorderNode.Attributes['diagonalUp'] := 1;
      end;

      Node2.Attributes['style'] := StyleStr;
      Node2.AddChild('color').Attributes['rgb'] := ColorStr;
    end;
  end;

  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('cellXfs');
  Root.Attributes['count'] := FXlsFile.Workbook.Styles.CellStyleCount;
  for i := 1 to FXlsFile.Workbook.Styles.CellStyleCount - 1 do
  begin
    CellStyle := FXlsFile.Workbook.Styles.CellStyle[i];
    Node := Root.AddChild('xf');

    Node.Attributes['numFmtId'] := CellStyle.NumberFormat.FormatId;
    Node.Attributes['fontId'] := CellStyle.Font.Index;
    Node.Attributes['fillId'] := CellStyle.Fill.Index;
    Node.Attributes['borderId'] := CellStyle.Border.Index;
    Node.Attributes['xfId'] := 0;

    if (CellStyle.Font.Index <> 0) then
      Node.Attributes['applyFont'] := '1';
    if (CellStyle.Fill.Index <> 0) then
      Node.Attributes['applyFill'] := '1';
    if (CellStyle.Border.Index <> 0) then
      Node.Attributes['applyBorder'] := '1';
    if (CellStyle.NumberFormat.FormatId <> 0) then
      Node.Attributes['applyNumberFormat'] := '1';

    if (CellStyle.HorzAlign <> chaUnassignedEh) or
       (CellStyle.VertAlign <> cvaUnassignedEh) or
       (CellStyle.WrapText <> False) or
       (CellStyle.Rotation <> 0) or
       (CellStyle.Indent <> 0)
    then
    begin
      Node2 := Node.AddChild('alignment');
      Node.Attributes['applyAlignment'] := 1;

      case CellStyle.HorzAlign of
        chaLeftEh  : Node2.Attributes['horizontal'] := 'left';
        chaRightEh : Node2.Attributes['horizontal'] := 'right';
        chaCenterEh: Node2.Attributes['horizontal'] := 'center';
      end;

      case CellStyle.VertAlign of
        cvaTopEh   : Node2.Attributes['vertical'] := 'top';
        cvaBottomEh: Node2.Attributes['vertical'] := 'bottom';
        cvaCenterEh: Node2.Attributes['vertical'] := 'center';
      end;

      if CellStyle.WrapText then
        Node2.Attributes['wrapText'] := 1;

      if CellStyle.Rotation <> 0 then
      begin
        if (CellStyle.Rotation < 0)
          then Node2.Attributes['textRotation'] := 90 - CellStyle.Rotation
          else Node2.Attributes['textRotation'] := CellStyle.Rotation;
      end;

      if CellStyle.CharsFlowDirection <> chfdHorizontalEh then
      begin
        Node2.Attributes['textRotation'] := 255;
      end;

      if CellStyle.Indent <> 0 then
        Node2.Attributes['indent'] := CellStyle.Indent;
    end;


  end;

  Res := TMemoryStream.Create;
  FXMLStyles.SaveToStream(Res);
  Res.Seek(System.Longint(0), soFromBeginning);
  FZipFileProvider.AddFile(Res, 'xl/styles.xml');
  Res.Free;
end;

procedure TXlsxFileWriterEh.WritetToFile(const AFileName: String);
var
  Eof: Boolean;
  SheetIdx: Integer;
  SheetDataNode: IXMLNode;
  RowsStream: TStringBuilder;
begin
  FFileName := AFileName;

  InitFileData;
  CreateXMLs;

  for SheetIdx := 0 to Length(FXMLSheets)-1 do
  begin
    FColCount := GetColCount(SheetIdx);
    Eof := InitTableCheckEof(SheetIdx);
    FCurRow := 0;
    SheetDataNode := FXMLSheets[SheetIdx].DocumentElement.ChildNodes.FindNode('sheetData');
    RowsStream := FSheetRowsStreams[SheetIdx];

    while not Eof do
    begin
      WriteRow(RowsStream, SheetDataNode, SheetIdx, FCurRow, Eof);
      Inc(FCurRow);
    end;

    WriteSheetViewInfo(SheetIdx);
  end;

  WriteXMLs;
  SaveDataToFile;
end;

procedure TXlsxFileWriterEh.SaveDataToFile;
begin
  FZipFileProvider.FinalizeZipFile;
  FreeAndNil(FZipFileProvider);
end;

function TXlsxFileWriterEh.SysVarToStr(const Val: Variant): String;
var
  ASep: Char;
begin
  ASep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  try
    Result := VarToStr(Val);
  finally
    FormatSettings.DecimalSeparator := ASep;
  end;
end;

function TXlsxFileWriterEh.InitTableCheckEof(SheetIndex: Integer): Boolean;
var
  Worksheet: TXlsWorksheetEh;
begin
  Worksheet := FXlsFile.Workbook.Worksheets[SheetIndex];
  Result := Worksheet.Dimension.ToRow < 0;
end;

function TXlsxFileWriterEh.InitRowCheckEof(SheetIndex: Integer; ARow: Integer): Boolean;
var
  Worksheet: TXlsWorksheetEh;
begin
  Worksheet := FXlsFile.Workbook.Worksheets[SheetIndex];
  Result := ARow > Worksheet.Dimension.ToRow;
end;

procedure TXlsxFileWriterEh.WriteRow(RowsStream: TStringBuilder; SheetDataNode: IXMLNode; SheetIndex: Integer; ARow: Integer; var Eof: Boolean);
var
  i: Integer;
  Worksheet: TXlsWorksheetEh;
  Row: TXlsFileRowEh;
begin
  Eof := InitRowCheckEof(SheetIndex, ARow);
  if Eof then Exit;

  FCurCol := 0;

  Worksheet := FXlsFile.Workbook.Worksheets[SheetIndex];

  RowsStream.Append('<row r="' + IntToStr(CurRowNum)+'"');
  RowsStream.Append(' spans="1:' + IntToStr(FColCount)+'"');
  RowsStream.Append(' x14ac:dyDescent="0.25"');

  if (Worksheet.Rows.RowIsCreated(CurRowNum-1)) then
  begin

    Row := Worksheet.Rows[CurRowNum-1];

    if (Row.HeightHasValue) then
    begin
      RowsStream.Append(' customHeight="1"');
      RowsStream.Append(' ht="' + SysVarToStr(Row.Height) + '"');
    end;

    if (Row.Visible = False) then
      RowsStream.Append(' hidden="1"');

    if (Row.OutlineLevel > 0) then
      RowsStream.Append(' outlineLevel="' + IntToStr(Row.OutlineLevel) + '"');

    if (Row.OutlineNodeCollapsed) then
      RowsStream.Append(' collapsed="1"');
  end;
  RowsStream.Append('>');


  for i := 0 to FColCount-1 do
    WriteValue(RowsStream, SheetIndex, i, ARow);

  RowsStream.Append('</row>');
end;

function TXlsxFileWriterEh.GetCell(SheetIndex: Integer; ACol, ARow: Integer): TXlsFileCellEh;
begin
  if FXlsFile.Workbook.Worksheets[SheetIndex].CellDataExists[ACol, ARow] then
    Result := FXlsFile.Workbook.Worksheets[SheetIndex].Cells[ACol, ARow]
   else
    Result := nil;
end;

function TXlsxFileWriterEh.GetColCount(SheetIndex: Integer): Integer;
begin
  Result := FXlsFile.Workbook.Worksheets[SheetIndex].Dimension.ToCol + 1;
end;

function TXlsxFileWriterEh.GetColWidth(SheetIndex: Integer; ACol: Integer): Double;
begin
  if (FXlsFile.Workbook.Worksheets[SheetIndex].Columns.ColumnIsCreated(ACol)) then
    Result := FXlsFile.Workbook.Worksheets[SheetIndex].Columns[ACol].Width
  else
    Result := 8.43;
end;

function TXlsxFileWriterEh.GetColumn(SheetIndex: Integer; ACol: Integer): TXlsFileColumnEh;
begin
  if (FXlsFile.Workbook.Worksheets[SheetIndex].Columns.ColumnIsCreated(ACol)) then
    Result := FXlsFile.Workbook.Worksheets[SheetIndex].Columns[ACol]
  else
    Result := nil;
end;

function TXlsxFileWriterEh.GetCurColNum: Integer;
begin
  Result := FCurCol+1;
end;

function TXlsxFileWriterEh.GetCurRowNum: Integer;
begin
  Result := FCurRow+1;
end;

procedure TXlsxFileWriterEh.WriteValue(RowsStream: TStringBuilder; SheetIndex: Integer; ACol, ARow: Integer);
var
  AVarType: TVarType;
  ACell: TXlsFileCellEh;
  ValueText: String;
  extVal: Extended;

  rAtr: String;
  tAtr: String;
  frmStr: String;
  stlAtr: String;
begin
  tAtr := '';
  frmStr := '';
  stlAtr := '';

  ACell := GetCell(SheetIndex, ACol, ARow);
  if (ACell = nil) then
  begin
    Inc(FCurCol);
    Exit;
  end;

  rAtr := ZEGetA1byCol(FCurCol) + IntToStr(CurRowNum);

  AVarType := VarType(ACell.Value);

  if (ACell.Formula <> '') then
  begin
    frmStr := '<f>' + StrToXMLValue(ACell.Formula) + '</f>';
  end;


  if AVarType in [varEmpty, varNull] then
    ValueText := ''
  else
  begin
    if (AVarType = varDate) and (ACell.Value < EncodeDate(1900, 1, 1)) then
    begin 
      tAtr := 'str';
      ValueText := VarToStr(ACell.Value);
    end
    else
    begin
      if AVarType = varDate then
      begin
        ValueText := SysVarToStr(Double(ACell.Value));
      end
      else
      begin
        if VarIsDBNumeric(ACell.Value) and (AVarType <> varBoolean) then
        begin
          extVal := ACell.Value;
          ValueText := SysFloatToStr(extVal);
        end
        else
        begin
          tAtr := 'str';
          ValueText := SysVarToStr(ACell.Value);
        end;
      end;

    end;
  end;

  if (ACell.Style.Index <> 0) then
    stlAtr := IntToStr(ACell.Style.Index);

  if not (AVarType in [varEmpty, varNull]) or
    (frmStr <> '') or
    (stlAtr <> '') then
  begin
    RowsStream.Append('<c ');
      RowsStream.Append('r="' + rAtr + '"');
      if tAtr <> '' then
        RowsStream.Append(' t="' + tAtr + '"');
      if stlAtr <> '' then
        RowsStream.Append(' s="' + stlAtr + '"');
      RowsStream.Append('>');

      if (frmStr <> '') then
        RowsStream.Append(frmStr);
      if (ValueText <> '') then
        RowsStream.Append('<v>'+StrToXMLValue(ValueText)+'</v>');

    RowsStream.Append('</c>');
  end;

  Inc(FCurCol);
end;

procedure TXlsxFileWriterEh.WriteSheetViewInfo(SheetIndex: Integer);
var
  SheetViews: IXMLNode;
  SheetView: IXMLNode;
  PaneNode: IXMLNode;
  TopLeftCellStr: String;
  FrozCols, FrozRows: Integer;
begin

  SheetViews := FXMLSheets[SheetIndex].DocumentElement.ChildNodes.FindNode('sheetViews');
  SheetView := SheetViews.ChildNodes.Nodes[0];
  FrozCols := FXlsFile.Workbook.Worksheets[SheetIndex].FrozenColCount;
  FrozRows := FXlsFile.Workbook.Worksheets[SheetIndex].FrozenRowCount;
  if (FrozCols > 0) or (FrozRows > 0) then
  begin
    PaneNode := SheetView.AddChild('pane');
    TopLeftCellStr := ZEGetA1byCol(FrozCols) + IntToStr(FrozRows+1);
    if (FrozCols > 0) then
      PaneNode.Attributes['xSplit'] := IntToStr(FrozCols);
    if (FrozRows > 0) then
      PaneNode.Attributes['ySplit'] := IntToStr(FrozRows);

    if (FrozRows > 0) and (FrozCols > 0) then
    begin
      PaneNode.Attributes['xSplit'] := IntToStr(FrozCols);
      PaneNode.Attributes['ySplit'] := IntToStr(FrozRows);
      PaneNode.Attributes['topLeftCell'] := TopLeftCellStr;
      PaneNode.Attributes['activePane'] := 'bottomRight';
    end
    else if (FrozRows > 0) then
    begin
      PaneNode.Attributes['ySplit'] := IntToStr(FrozRows);
      PaneNode.Attributes['topLeftCell'] := TopLeftCellStr;
      PaneNode.Attributes['activePane'] := 'bottomLeft';
    end
    else if (FrozCols > 0) then
    begin
      PaneNode.Attributes['xSplit'] := IntToStr(FrozCols);
      PaneNode.Attributes['topLeftCell'] := TopLeftCellStr;
      PaneNode.Attributes['activePane'] := 'topRight';
    end;

    PaneNode.Attributes['state'] := 'frozen';
  end;

end;

procedure TXlsxFileWriterEh.WriteAutoFilterInfo(Worksheet: TXlsWorksheetEh; WorksheetDocument: IXMLDocument);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
var
  MergeCellsNode: IXMLNode;
begin

  if not Worksheet.AutoFilterRange.IsEmpty then
  begin
    MergeCellsNode := WorksheetDocument.DocumentElement.AddChild('autoFilter', st);
    MergeCellsNode.Attributes['ref'] :=
      ZEGetA1byCol(Worksheet.AutoFilterRange.FromCol) + IntToStr(Worksheet.AutoFilterRange.FromRow+1) + ':' +
      ZEGetA1byCol(Worksheet.AutoFilterRange.ToCol) + IntToStr(Worksheet.AutoFilterRange.ToRow+1);
    
  end;
end;

procedure TXlsxFileWriterEh.WriteMergeCellsInfo(Worksheet: TXlsWorksheetEh; WorksheetDocument: IXMLDocument);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
var
  MergeCellsNode: IXMLNode;
  MergeCellNode: IXMLNode;
  ci, ri: Integer;
  i: Integer;
  Cell: TXlsFileCellEh;
  mList: TStringList;
  RenageStr: String;
begin
  mList := TStringList.Create;
  for ci := 0 to Worksheet.Dimension.ToCol do
  begin
    for ri := 0 to Worksheet.Dimension.ToRow do
    begin
      if (Worksheet.CellDataExists[ci, ri]) then
      begin
        Cell := Worksheet.Cells[ci, ri];
        if (Cell.MergeRange.ColCount > 1) or (Cell.MergeRange.RowCount > 1)  then
        begin
          RenageStr := ZEGetA1byCol(ci) +
                       IntToStr(ri+1) + ':' +
                       ZEGetA1byCol(ci + Cell.MergeRange.ColCount - 1) +
                       IntToStr(ri+1 + Cell.MergeRange.RowCount - 1);
          mList.Add(RenageStr);
        end;
      end;
    end;
  end;


  if (mList.Count > 0) then
  begin
    MergeCellsNode := WorksheetDocument.DocumentElement.AddChild('mergeCells', st);
    MergeCellsNode.Attributes['count'] := mList.Count;
    for i := 0 to mList.Count-1 do
    begin
      MergeCellNode := MergeCellsNode.AddChild('mergeCell', st);
      MergeCellNode.Attributes['ref'] := mList[i];
    end;
  end;

  mList.Free;
end;

initialization
finalization
//{$ENDIF} 
end.

