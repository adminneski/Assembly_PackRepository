{******************************************}
{                                          }
{             FastReport VCL               }
{            Various routines              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

/// <summary>
///   The unit contains additional helper function used by other FastReports
///   units like type conversions, CRC calculation, image draw and others.
/// </summary>
unit frxUtils;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  LCLType, LCLIntf, LazHelper, DateUtils,
  {$IFDEF LCLGTK2} Printers, {$ENDIF}
{$ENDIF}
  SysUtils, {$IFDEF DELPHI16} System.UITypes, {$ENDIF} Classes, Graphics,
  Controls, Forms, StdCtrls, Menus, ImgList, ActnList, ComCtrls,
  frXML, frCore, frGraphics, frCoreClasses, frGraphicUtils,
  frxClass, frxVariables;

type
  TfrxRectArea = class
  public
    X, Y, X1, Y1: Extended;
    constructor Create(c: TfrxComponent); overload;
    constructor Create(Left, Top, Right, Bottom: Extended); overload;
    function InterceptsX(a: TfrxRectArea): Boolean;
    function InterceptsY(a: TfrxRectArea): Boolean;
    function InterceptX(a: TfrxRectArea): TfrxRectArea;
    function InterceptY(a: TfrxRectArea): TfrxRectArea;
    function Max(x1, x2: Extended): Extended;
    function Min(x1, x2: Extended): Extended;
  end;

procedure frxParseDilimitedText(aList: TStrings; aText: String; aDelimiter: Char);
/// <summary>
///   Searches for a component on owner by name.
/// </summary>
/// <param name="Owner">
///   Owner component.
/// </param>
/// <param name="Name">
///   Name of the searched component.
/// </param>
function frxFindComponent(Owner: TComponent; const Name: String): TComponent;
/// <summary>
///   Fills list with all found component in application with class type
///   specified in ClassRef parameter. <br />
/// </summary>
/// <param name="Owner">
///   Components owner.
/// </param>
/// <param name="ClassRef">
///   Class reference to search for.
/// </param>
/// <param name="List">
///   Out list parameter.
/// </param>
/// <param name="Skip">
///   Component to skip.
/// </param>
procedure frxGetComponents(Owner: TComponent; ClassRef: TClass;
  List: TStrings; Skip: TComponent);
/// <summary>
///   Returns full name of the component includes full sequences of owners
///   delimired by '.' sign.
/// </summary>
/// <param name="Owner">
///   Owner component.
/// </param>
/// <param name="c">
///   Component reference.
/// </param>
function frxGetFullName(Owner: TComponent; c: TComponent): String;
procedure frxSetCommaText(const Text: String; sl: TStrings; Comma: Char = ';');
function frxRemoveQuotes(const s: String): String;
/// <summary>
///   Converts stream bytes to hex string representation.
/// </summary>
/// <param name="Stream">
///   Reference to stream.
/// </param>
/// <returns>
///   Hex string.
/// </returns>
function frxStreamToString(Stream: TStream): String;
/// <summary>
///   Converts hex string representation to stream bytes and writes them to
///   stream.
/// </summary>
/// <param name="s">
///   String with hex representation of bytes.
/// </param>
/// <param name="Stream">
///   Destination stream.
/// </param>
procedure frxStringToStream(const S: string; AStream: TStream);
function frxStringToHex(const Buffer: WideString): String;
function frxHexToString(const Buffer: String): WideString;
function frxDecToBinBytes(d: Longint): string;
function frxStrToFloat(s: String): Extended;

function frxRect(ALeft, ATop, ARight, ABottom: Extended): TfrxRect;
function frxPoint(X, Y: Extended): TfrxPoint;
function frxGetBrackedVariable(const Str, OpenBracket, CloseBracket: AnsiString;
  var i, j: Integer): AnsiString;
function frxGetBrackedVariableW(const Str, OpenBracket, CloseBracket: WideString;
  var i, j: Integer): WideString;
procedure frxCommonErrorHandler(Report: TfrxReport; const Text: String);
procedure frxErrorMsg(const Text: String);
procedure frxInfoMsg(const Text: String);
function frxConfirmMsg(const Text: String; Buttons: Integer): Integer;
function frxIsValidFloat(const Value: string): Boolean;
procedure frxAssignImages(Bitmap: TBitmap; dx, dy: Integer;
  ImgList1: TImageList; ImgList2: TImageList = nil);
procedure frxDrawIcon(ImgList: TCustomImageList; aBitmap: TBitmap; IconIndex: Integer; BgColor: TColor = clNone);
procedure frxDrawTransparent(Canvas: TCanvas; x, y: Integer; bmp: TBitmap);
procedure frxDrawCheckBox(Canvas: TCanvas; ARect: TRect; aCheckColor: TColor; aFrameColor: TColor; bIsChecked: Boolean);
procedure frxDrawArrow(Canvas: TCanvas; aRect: TRect; aColor: TColor; bVertical: Boolean = True; bMirrored: Boolean = False);
procedure frxDrawArrows(Canvas: TCanvas; aRect: TRect; aColor: TColor; bVertical: Boolean = True; bMirrored: Boolean = False; LineWidth: Integer = 2; LineGap: Integer = 2; Gap: Integer = 3; Count: Integer = 2);
procedure frxParsePageNumbers(const PageNumbers: String; List: TStrings;
  Total: Integer);
function ColorText(Color: TColor) : String;
function FFColorText(Color: TColor) : String;
function HTMLRGBColor(Color: TColor): string;
procedure frxWriteCollection(Collection: TCollection; Writer: TWriter; Owner: TfrxComponent); overload;
procedure frxReadCollection(Collection: TCollection; Reader: TReader; Owner: TfrxComponent); overload;
function frxWriteCollection(Collection: TCollection; const Name: String; Item: TfrXMLItem; Owner: TfrxComponent; aAncestor: TfrCollection; ACreateNewItem: Boolean = True): TfrXMLItem; overload;
procedure frxReadCollection(Collection: TCollection; Item: TfrXMLItem; Owner: TfrxComponent;  aAncestor: TfrCollection); overload;
procedure frxWriteProperties(Instance: TPersistent; Writer: TWriter; Owner: TfrxComponent);
procedure frxReadProperties(Instance: TPersistent; Reader: TReader; Owner: TfrxComponent);

function frxCreateTempFile(const TempDir: String): String;
{$IFNDEF DELPHI7}
function frFloat2Str(const Value: Extended; const Prec: Integer = 2): String;
{$ELSE}
function frFloat2Str(const Value: Extended; const Prec: Integer = 2; const Sep: Char = '.'): String;
{$ENDIF}
function frxReverseString(const AText: string): string;
function frxStreamCRC32(Stream: TStream): Cardinal;
function frxUnixPath2WinPath(const Path: string): string;
{$IFNDEF DELPHI6}
function DirectoryExists(const Name: string): Boolean;
{$ENDIF}
{$IFNDEF DELPHI7}
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
{$ENDIF}
{lcl widgetsets don't like too many Repaint calls, so we use
 update for them, Delphi isn't disturbed}
procedure frxUpdateControl(AControl: TWinControl;
  const ARepaint: Boolean = {$IFDEF NONWINFPC}False{$ELSE}True{$ENDIF});
procedure GetDisplayScale(DevHandle: TfrHandle; IsPrinterHandle: Boolean; var aScaleX, aScaleY: Extended);
procedure TransparentFillRect(aDC: HDC; Left, Top, Right, Bottom: Integer;
  Color: TColor);
function GetStr(const Id: string): string;
function frxFloatDiff(const Val1, Val2: Extended): Boolean;

function frxSetBkMode(C: TCanvas; bkMode : Integer): Integer;
procedure ChangeGlyphColor(Index: Integer; Color: TColor);
function DateTimeToUTC(DateTime: TDateTime): TDateTime;

type
  TByteDinArray = array of Byte;
  TWordDinArray = array of Word;
  TLongWordDinArray = array of LongWord;
  TIntegerDinArray = array of Integer;

const
  PageBGName = '_pagebackground';
function IsPageBG(Obj: TfrxComponent): Boolean;

implementation

uses
  frUtils,
  frxXMLSerializer, frxRes, Types, TypInfo, Dialogs;

function IsPageBG(Obj: TfrxComponent): Boolean;
begin
  Result := (Obj is TfrxPictureView) and (Obj.Name = PageBGName);
end;

function frxSetBkMode(C: TCanvas; bkMode : Integer): Integer;
begin
{$IFDEF LCLGTK2}
  if (not (C is TPrinterCanvas)) then
{$ENDIF}
    result := SetBkMode(C.Handle, bkMode);
end;

function frxFloatDiff(const Val1, Val2: Extended): Boolean;
begin
  Result := Abs(Val1 - Val2) > 1e-4;
end;

procedure TransparentFillRect(aDC: HDC; Left, Top, Right, Bottom: Integer;
  Color: TColor);
const
  ChessBrush: array [0 .. 7] of Word = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);
var
  aSaveState: Integer;
  aBitmap: HBITMAP;
  aBrush: HBRUSH;
  OldBrush, OldPen: HPEN;
begin
  aSaveState := SaveDC(aDC);
  aBitmap := CreateBitmap(8, 8, 1, 1, @ChessBrush);
  try
    aBrush := CreatePatternBrush(aBitmap);
  finally
    DeleteObject(aBitmap);
  end;
  OldBrush := SelectObject(aDC, aBrush);
  OldPen := SelectObject(aDC, GetStockObject(NULL_PEN));
  try
    SetROP2(aDC, R2_MASKPEN);
    SetBkColor(aDC, RGB(255, 255, 255));
    SetTextColor(aDC, RGB(0, 0, 0));
    Rectangle(aDC, Left, Top, Right, Bottom);
    SetROP2(aDC, R2_MERGEPEN);
    SetBkColor(aDC, RGB(0, 0, 0));
    SetTextColor(aDC, Color);
    Rectangle(aDC, Left, Top, Right, Bottom);
  finally
    SelectObject(aDC, OldBrush);
    SelectObject(aDC, OldPen);
    DeleteObject(aBrush);
    RestoreDC(aDC, aSaveState);
  end;
end;

{ TfrxRectArea }

constructor TfrxRectArea.Create(c: TfrxComponent);
begin
  Create(c.AbsLeft, c.AbsTop, c.AbsLeft + c.Width, c.AbsTop + c.Height);
end;

constructor TfrxRectArea.Create(Left, Top, Right, Bottom: Extended);
begin
  X := Left;
  Y := Top;
  X1 := Right;
  Y1 := Bottom;
end;

function TfrxRectArea.InterceptsX(a: TfrxRectArea): Boolean;
begin
  Result := False;
  if (a.X < X1 - 1e-4) and (a.X1 > X + 1e-4) then
    Result := True;
end;

function TfrxRectArea.InterceptsY(a: TfrxRectArea): Boolean;
begin
  Result := False;
  if (a.Y < Y1 - 1e-4) and (a.Y1 > Y + 1e-4) then
    Result := True;
end;

function TfrxRectArea.InterceptX(a: TfrxRectArea): TfrxRectArea;
begin
  Result := nil;
  if InterceptsX(a) then
    Result := TfrxRectArea.Create(Max(a.X, X), 0, Min(a.X1, X1), 0);
end;

function TfrxRectArea.InterceptY(a: TfrxRectArea): TfrxRectArea;
begin
  Result := nil;
  if InterceptsY(a) then
    Result := TfrxRectArea.Create(0, Max(a.Y, Y), 0, Min(a.Y1, Y1));
end;

function TfrxRectArea.Max(x1, x2: Extended): Extended;
begin
  if x1 > x2 then
    Result := x1
  else
    Result := x2;
end;

function TfrxRectArea.Min(x1, x2: Extended): Extended;
begin
  if x1 < x2 then
    Result := x1
  else
    Result := x2;
end;

const
  CRCTable: array [0..255] of Cardinal = (
 0000000000, 1996959894, 3993919788, 2567524794,
 0124634137, 1886057615, 3915621685, 2657392035,
 0249268274, 2044508324, 3772115230, 2547177864,
 0162941995, 2125561021, 3887607047, 2428444049,
 0498536548, 1789927666, 4089016648, 2227061214,
 0450548861, 1843258603, 4107580753, 2211677639,
 0325883990, 1684777152, 4251122042, 2321926636,
 0335633487, 1661365465, 4195302755, 2366115317,
 0997073096, 1281953886, 3579855332, 2724688242,
 1006888145, 1258607687, 3524101629, 2768942443,
 0901097722, 1119000684, 3686517206, 2898065728,
 0853044451, 1172266101, 3705015759, 2882616665,
 0651767980, 1373503546, 3369554304, 3218104598,
 0565507253, 1454621731, 3485111705, 3099436303,
 0671266974, 1594198024, 3322730930, 2970347812,
 0795835527, 1483230225, 3244367275, 3060149565,
 1994146192, 0031158534, 2563907772, 4023717930,
 1907459465, 0112637215, 2680153253, 3904427059,
 2013776290, 0251722036, 2517215374, 3775830040,
 2137656763, 0141376813, 2439277719, 3865271297,
 1802195444, 0476864866, 2238001368, 4066508878,
 1812370925, 0453092731, 2181625025, 4111451223,
 1706088902, 0314042704, 2344532202, 4240017532,
 1658658271, 0366619977, 2362670323, 4224994405,
 1303535960, 0984961486, 2747007092, 3569037538,
 1256170817, 1037604311, 2765210733, 3554079995,
 1131014506, 0879679996, 2909243462, 3663771856,
 1141124467, 0855842277, 2852801631, 3708648649,
 1342533948, 0654459306, 3188396048, 3373015174,
 1466479909, 0544179635, 3110523913, 3462522015,
 1591671054, 0702138776, 2966460450, 3352799412,
 1504918807, 0783551873, 3082640443, 3233442989,
 3988292384, 2596254646, 0062317068, 1957810842,
 3939845945, 2647816111, 0081470997, 1943803523,
 3814918930, 2489596804, 0225274430, 2053790376,
 3826175755, 2466906013, 0167816743, 2097651377,
 4027552580, 2265490386, 0503444072, 1762050814,
 4150417245, 2154129355, 0426522225, 1852507879,
 4275313526, 2312317920, 0282753626, 1742555852,
 4189708143, 2394877945, 0397917763, 1622183637,
 3604390888, 2714866558, 0953729732, 1340076626,
 3518719985, 2797360999, 1068828381, 1219638859,
 3624741850, 2936675148, 0906185462, 1090812512,
 3747672003, 2825379669, 0829329135, 1181335161,
 3412177804, 3160834842, 0628085408, 1382605366,
 3423369109, 3138078467, 0570562233, 1426400815,
 3317316542, 2998733608, 0733239954, 1555261956,
 3268935591, 3050360625, 0752459403, 1541320221,
 2607071920, 3965973030, 1969922972, 0040735498,
 2617837225, 3943577151, 1913087877, 0083908371,
 2512341634, 3803740692, 2075208622, 0213261112,
 2463272603, 3855990285, 2094854071, 0198958881,
 2262029012, 4057260610, 1759359992, 0534414190,
 2176718541, 4139329115, 1873836001, 0414664567,
 2282248934, 4279200368, 1711684554, 0285281116,
 2405801727, 4167216745, 1634467795, 0376229701,
 2685067896, 3608007406, 1308918612, 0956543938,
 2808555105, 3495958263, 1231636301, 1047427035,
 2932959818, 3654703836, 1088359270, 0936918000,
 2847714899, 3736837829, 1202900863, 0817233897,
 3183342108, 3401237130, 1404277552, 0615818150,
 3134207493, 3453421203, 1423857449, 0601450431,
 3009837614, 3294710456, 1567103746, 0711928724,
 3020668471, 3272380065, 1510334235, 0755167117);

function frxStreamCRC32(Stream: TStream): Cardinal;
var
  OldPos: Integer;
  b: Byte;
  c: Cardinal;
begin
  OldPos := Stream.Position;
  Stream.Position := 0;
  c := $ffffffff;
  while Stream.Position < Stream.Size do
  begin
    Stream.Read(b,1);
    c := CrcTable[(c xor Cardinal(b)) and $ff] xor (c shr 8);
  end;
  Stream.Position := OldPos;
  Result := c xor $ffffffff;
end;

procedure frxParseDilimitedText(aList: TStrings; aText: String; aDelimiter: Char);
var
  sLen, i, sPos: Integer;
begin
  aList.Clear;
  if (aText = '') or (aText = aDelimiter) then Exit;
  aList.BeginUpdate;
  try
    sLen := Length(aText);
    i := 1;
    sPos := 1;
    while i <= sLen do
    begin
      if (aText[i] = aDelimiter) and (sPos < i) or ((i = sLen) and (aList.Count > 0)) then
      begin
        if i = sLen then Inc(i);
        aList.Add(Copy(aText, sPos, i - sPos));
        sPos := i + 1;
      end;
      inc(i);
    end;
   finally
     aList.EndUpdate;
   end;
end;

function frxFindComponent(Owner: TComponent; const Name: String): TComponent;
begin
  Result := frFindComponent(Owner, Name);
end;

{$HINTS OFF}
procedure frxGetComponents(Owner: TComponent; ClassRef: TClass;
  List: TStrings; Skip: TComponent);
var
  i, j: Integer;

  procedure EnumComponents(f: TComponent);
  var
    i: Integer;
    c: TComponent;
  begin
{$IFDEF DELPHI5}
    if f is TForm then
      for i := 0 to TForm(f).ControlCount - 1 do
      begin
        c := TForm(f).Controls[i];
        if c is TFrame then
          EnumComponents(c);
      end;
{$ENDIF}
    for i := 0 to f.ComponentCount - 1 do
    begin
      c := f.Components[i];
      if (c <> Skip) and (c is ClassRef) then
        List.AddObject(frxGetFullName(Owner, c), c);
    end;
  end;

begin
  List.Clear;
  if Owner is TfrxReport then
    EnumComponents(Owner);
  for i := 0 to Screen.FormCount - 1 do
    EnumComponents(Screen.Forms[i]);
  for i := 0 to Screen.DataModuleCount - 1 do
    EnumComponents(Screen.DataModules[i]);
{$IFDEF DELPHI6} // D6 bugfix
  with Screen do
    for i := 0 to CustomFormCount - 1 do
      with CustomForms[i] do
      if (ClassName = 'TDataModuleForm')  then
        for j := 0 to ComponentCount - 1 do
        begin
          if (Components[j] is TDataModule) then
            EnumComponents(Components[j]);
        end;
{$ENDIF}
end;
{$HINTS ON}

function frxGetFullName(Owner: TComponent; c: TComponent): String;
var
  o: TComponent;
begin
  Result := '';
  if c = nil then Exit;

  o := c.Owner;
  if (o = nil) or (o = Owner) or ((Owner is TfrxReport) and (o = Owner.Owner)) then
    Result := c.Name
  else if ((o is TForm) or (o is TDataModule)) then
    Result := o.Name + '.' + c.Name
{$IFDEF DELPHI5}
  else if o is TFrame then
    if o.Owner <> nil then
      Result := o.Owner.Name + '.' + c.Owner.Name + '.' + c.Name
    else
      Result := c.Owner.Name + '.' + c.Name
{$ENDIF}
end;

procedure frxSetCommaText(const Text: String; sl: TStrings; Comma: Char = ';');
var
  i: Integer;

  function ExtractCommaName(s: string; var Pos: Integer): string;
  var
    i: Integer;
  begin
    i := Pos;
    while (i <= Length(s)) and (s[i] <> Comma) do Inc(i);
    Result := Copy(s, Pos, i - Pos);
    if (i <= Length(s)) and (s[i] = Comma) then Inc(i);
    Pos := i;
  end;

begin
  i := 1;
  sl.Clear;
  while i <= Length(Text) do
    sl.Add(ExtractCommaName(Text, i));
end;

function frxRemoveQuotes(const s: String): String;
begin
  if (Length(s) > 2) and (s[1] = '"') and (s[Length(s)] = '"') then
    Result := Copy(s, 2, Length(s) - 2) else
    Result := s;
end;

function frxStringToHex(const Buffer: WideString): String;
begin
  SetLength(Result, Length(Buffer) * 4);
  BinToHex(PAnsiChar(PWideChar(Buffer)), PChar(Result), Length(Buffer) * 2);
end;

function frxHexToString(const Buffer: String): WideString;
begin
  SetLength(Result, Length(Buffer) div 4);
  HexToBin(PChar(Buffer), PAnsiChar(PWideChar(Result)), Length(Result) * 2);
end;

function frxDecToBinBytes(d: Longint): string;
var
  x: Integer;
  bin: string;
begin
  bin := '';
  for x := 1 to 8 * SizeOf(d) do
  begin
    if Odd(d) then bin := '1' + bin
    else
      bin := '0' + bin;
    d := d shr 1;
  end;
  Delete(bin, 1, 8 * ((Pos('1', bin) - 1) div 8));
  Result := bin;
end;

function frxStreamToString(Stream: TStream): String;
var
  Size: Integer;
{$IFDEF DELPHI12}
    p: PAnsiChar;
{$ELSE}
	p: PChar;
{$ENDIF}
begin
  Size := Stream.Size;
  SetLength(Result, Size * 2);
  GetMem(p, Size);

  Stream.Position := 0;
  Stream.Read(p^, Size);

  BinToHex(p, PChar(@Result[1]), Size);

  FreeMem(p, Size);
end;

procedure frxStringToStream(const S: string; AStream: TStream);
begin
  frStringToStream(S, AStream);
end;

function frxStrToFloat(s: String): Extended;
var
  i: Integer;
begin
  for i := 1 to Length(s) do
{$IFDEF DELPHI12}
    if CharInSet(s[i], [',', '.']) then
{$ELSE}
    if s[i] in [',', '.'] then
{$ENDIF}
{$IFDEF DELPHI16}
      s[i] := FormatSettings.DecimalSeparator;
{$ELSE}
      s[i] := DecimalSeparator;
{$ENDIF}
  while Pos(' ', s) <> 0 do
    Delete(s, Pos(' ', s), 1);
  Result := StrToFloat(s);
end;

function frxRect(ALeft, ATop, ARight, ABottom: Extended): TfrxRect;
begin
  with Result do
  begin
    Left := ALeft;
    Top := ATop;
    Right := ARight;
    Bottom := ABottom;
  end;
end;

function frxPoint(X, Y: Extended): TfrxPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

function frxGetBrackedVariable(const Str, OpenBracket, CloseBracket: AnsiString;
  var i, j: Integer): AnsiString;
var
  c: Integer;
  fl1, fl2: Boolean;
begin
  Result := '';
  j := i;
  fl1 := True;
  fl2 := True;
  c := 0;
  if (Str = '') or (j > Length(Str)) then Exit;

  Dec(j);
  repeat
    Inc(j);
    if isDBCSLeadByte(Byte(Str[j])) then  { if DBCS then skip 2 bytes }
      Inc(j, 2);

    if fl1 and fl2 then
      if Copy(Str, j, Length(OpenBracket)) = OpenBracket then
      begin
        if c = 0 then i := j;
        Inc(c);
      end
      else if Copy(Str, j, Length(CloseBracket)) = CloseBracket then
        Dec(c);
    if fl1 then
      if Str[j] = '"' then fl2 := not fl2;
    if fl2 then
      if Str[j] = '''' then fl1 := not fl1;
  until (c = 0) or (j >= Length(Str));

  Result := Copy(Str, i + Length(OpenBracket), j - i - Length(OpenBracket));
  if i <> j then
    Inc(j, Length(CloseBracket) - 1);
end;

function frxGetBrackedVariableW(const Str, OpenBracket, CloseBracket: WideString;
  var i, j: Integer): WideString;
var
  c: Integer;
  fl1, fl2: Boolean;
begin
  Result := '';
  j := i;
  fl1 := True;
  fl2 := True;
  c := 0;
  if (Str = '') or (j > Length(Str)) then Exit;

  Dec(j);
  repeat
    Inc(j);
    if fl1 and fl2 then
      if Copy(Str, j, Length(OpenBracket)) = OpenBracket then
      begin
        if c = 0 then i := j;
        Inc(c);
      end
      else if Copy(Str, j, Length(CloseBracket)) = CloseBracket then
        Dec(c);
    if fl1 then
      if Str[j] = '"' then fl2 := not fl2;
    if fl2 then
      if Str[j] = '''' then fl1 := not fl1;
  until (c = 0) or (j >= Length(Str));

  Result := Copy(Str, i + Length(OpenBracket), j - i - Length(OpenBracket));
  if i <> j then
    Inc(j, Length(CloseBracket) - 1);
end;

procedure frxCommonErrorHandler(Report: TfrxReport; const Text: String);
var
  e: Exception;
begin
  case Report.EngineOptions.NewSilentMode of
    simMessageBoxes: frxErrorMsg(Text);
    simReThrow: begin e := Exception.Create(Text); raise e; end;
  end;
end;

procedure frxErrorMsg(const Text: String);
begin
  Application.MessageBox(PChar(Text), PChar(frxResources.Get('mbError')),
    mb_Ok + mb_IconError);
end;

function frxConfirmMsg(const Text: String; Buttons: Integer): Integer;
begin
  Result := Application.MessageBox(PChar(Text),
    PChar(frxResources.Get('mbConfirm')), mb_IconQuestion + Buttons);
end;

procedure frxInfoMsg(const Text: String);
begin
  Application.MessageBox(PChar(Text), PChar(frxResources.Get('mbInfo')),
    mb_Ok + mb_IconInformation);
end;

function frxIsValidFloat(const Value: string): Boolean;
begin
  Result := True;
  try
    frxStrToFloat(Value);
  except
    Result := False;
  end;
end;

procedure frxMakeDisabledImage(Bitmap: TBitmap);
var
  i, j: Integer;
  c: TColor;
  B, G, R: Integer;
begin
  for i := 0 to Bitmap.Width - 1 do
  for j := 0 to Bitmap.Height - 1 do
  begin
    c := Bitmap.Canvas.Pixels[i, j];
    r := c and $FF0000 div $10000;
    g := c and $FF00 div $100;
    b := c and $FF;
    c := (r + g + b) div 3;
    c := Round(c / 3);
    c := c + 150;
    if c > 255 then
      c := 255;
    Bitmap.Canvas.Pixels[i, j] := c * $10000 + c * $100 + c;
  end;
end;

procedure frxAssignImages(Bitmap: TBitmap; dx, dy: Integer;
  ImgList1: TImageList; ImgList2: TImageList = nil);
var
  b: TBitmap;
  x, y: Integer;
  Done: Boolean;
begin
  b := TBitmap.Create;
  b.Width := dx;
  b.Height := dy;

  x := 0; y := 0;

  repeat
    b.Canvas.CopyRect(Rect(0, 0, dx, dy), Bitmap.Canvas, Rect(x, y, x + dx, y + dy));
    Done := y > Bitmap.Height;

    if not Done then
    begin
      ImgList1.AddMasked(b, b.TransparentColor);
      if ImgList2 <> nil then
      begin
        frxMakeDisabledImage(b);
        ImgList2.AddMasked(b, b.TransparentColor);
      end;
    end;

    Inc(x, dx);
    if x >= Bitmap.Width then
    begin
      x := 0;
      Inc(y, dy);
    end;
  until Done;

  b.Free;
end;

procedure frxDrawIcon(ImgList: TCustomImageList; aBitmap: TBitmap; IconIndex: Integer; BgColor: TColor);
begin
  aBitmap.Width := ImgList.Width;
  aBitmap.Height := ImgList.Height;
  aBitmap.Canvas.Lock;
  try
    aBitmap.Canvas.Brush.Color := BgColor;
    aBitmap.Canvas.FillRect(Rect(0, 0, aBitmap.Width, aBitmap.Height));
  finally
    aBitmap.Canvas.Unlock;
  end;
  ImgList.Draw(aBitmap.Canvas, 0, 0, IconIndex);
end;

procedure frxDrawTransparent(Canvas: TCanvas; x, y: Integer; bmp: TBitmap);
var
  img: TImageList;
begin
  if Assigned(bmp) then
  begin
    img := TImageList.Create(nil);
    try
      img.Width := bmp.Width;
      img.Height := bmp.Height;
      img.AddMasked(bmp, bmp.TransparentColor);
      img.Draw(Canvas, x, y, 0);
      img.Clear;
    finally
      img.Free;
    end;
  end;
end;

procedure frxDrawCheckBox(Canvas: TCanvas; ARect: TRect; aCheckColor: TColor; aFrameColor: TColor; bIsChecked: Boolean);
var
  rWidth, rHeight, cx, lWidth: Integer;
  lScale: Single;
  { Simplified linear function with slope y=kx+b }
  { we use only 45 and 135 angles tan = 1 and -1 }
  { these angles don't have distortions on draw and have better look at different scales }
begin
  with Canvas do
  begin
    { we use size of 11:11 as original size and calc scale based on it }
    lScale := (ARect.Right - ARect.Left) / 11;
    Pen.Color := aFrameColor;
    Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    Pen.Color := aCheckColor;
    Brush.Color := aCheckColor;
    SetRect(ARect, ARect.Left + Round(1 + lScale), ARect.Top + Round(3 + lScale), ARect.Right - Round(2 + lScale), ARect.Bottom - Round(2 + lScale));
    rWidth := ARect.Right - ARect.Left;
    rHeight := ARect.Bottom - ARect.Top;

    cx := rWidth div 2 - rWidth div 5;
    lWidth := Round(2 * lScale);
    if lScale > 1 then
      Inc(lWidth, Round(lScale));

    if bIsChecked then
      with ARect do
        Polygon([Point(Left + cx, Top + rHeight),
          Point(Left, Top + rHeight - cx),
          Point(Left, Top + rHeight - cx - lWidth),
          Point(Left + cx, Top + rHeight - lWidth),
          Point(Left + rWidth, Top + rHeight - (rWidth - cx) - lWidth)
          , Point(Left + rWidth, Top + rHeight - (rWidth - cx)),
          Point(Left + cx, Top + rHeight)]);
  end;
end;

procedure frxDrawArrow(Canvas: TCanvas; aRect: TRect; aColor: TColor; bVertical: Boolean = True; bMirrored: Boolean = False);
var
  w, h, dx, dy, td, offx, offy: Integer;

  procedure SwapInt(var X, Y: Integer);
  var
    Tmp: Integer;
  begin
    Tmp := X;
    X := Y;
    Y := Tmp;
  end;

begin
  Canvas.Brush.Color := aColor;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Color := aColor;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 1;

  w := aRect.Right - aRect.Left;
  h := aRect.Bottom - aRect.Top;
  offx := 0;
  offy := 0;
  if (w mod 2 = 0) then
    offx := -1;
  if (h mod 2 = 0) then
    offy := -1;

  dx := Round((w div 2) * 0.5);
  w := w - dx * 2;
  w := w - w mod 2;
  dy := h div 2 - (w div 2) div 2;
  h := w div 2;

  if not bVertical then
  begin
    td := dx;
    dx := dy;
    dy := td;
  end;

  Inc(aRect.Left, dx);
  Inc(aRect.Top, dy);
  Dec(aRect.Right, dx);
  Dec(aRect.Bottom, dy);
  if bVertical then
  begin
    OffsetRect(aRect, offx, 0);
    if bMirrored then
    begin
      SwapInt(aRect.Top, aRect.Bottom);
      h := -h;
    end;
    Canvas.Polygon([Point(aRect.Left, aRect.Top), Point(aRect.Left + w div 2,
      aRect.Top + h), Point(aRect.Left + w, aRect.Top), Point(aRect.Left,
      aRect.Top)])
  end
  else
  begin
    OffsetRect(aRect, 0, offy);
    if bMirrored then
    begin
      SwapInt(aRect.Left, aRect.Right);
      h := -h;
    end;
    Canvas.Polygon([Point(aRect.Left, aRect.Top), Point(aRect.Left,
      aRect.Top + w), Point(aRect.Left + h, aRect.Top + w div 2),
      Point(aRect.Left, aRect.Top)])
  end;
end;

procedure frxDrawArrows(Canvas: TCanvas; aRect: TRect; aColor: TColor; bVertical: Boolean; bMirrored: Boolean; LineWidth: Integer; LineGap: Integer; Gap: Integer; Count: Integer);
var
  dir, i, offset: Integer;

  procedure SwapInt(var X, Y: Integer);
  var
    Tmp: Integer;
  begin
    Tmp := X;
    X := Y;
    Y := Tmp;
  end;

  procedure SimpleDraw(aRect: TRect);
  var
    w, h, cx: Integer;
  begin
    w := aRect.Right - aRect.Left;
    h := aRect.Bottom - aRect.Top;
    cx := w div 2;
    if bMirrored then
    begin
      if not bVertical then
        SwapInt(aRect.Left, aRect.Right)
      else
        SwapInt(aRect.Top, aRect.Bottom);
    end;
    with ARect do
    begin
      if not bVertical then
      begin
        Canvas.Polygon([Point(Left + w * dir, Top + cx),
          Point(Left + (w - cx) * dir, Top), Point(Left + (h - cx) * dir, Top + LineWidth), Point(Left  + (h - LineWidth) * dir, Top + cx), Point(Left + w * dir, Top + cx)]);
        Canvas.Polygon([Point(Left + h * dir, Top + w - cx),
          Point(Left + (h - cx) * dir, Top + w), Point(Left + (h - cx) * dir, Top + w - LineWidth), Point(Left + (h - LineWidth) * dir, Top + w - Abs(cx)), Point(Left + h * dir, Top + w - cx)]);
      end
      else
      begin
        Canvas.Polygon([Point(Left + cx, Top + h * dir),
          Point(Left, Top + (h - cx) * dir), Point(Left, Top + (h - cx - LineWidth) * dir), Point(Left + cx, Top + (h - LineWidth) * dir), Point(Left + cx, Top + h * dir)]);
        Canvas.Polygon([Point(Left + w - cx, Top + (h) * dir),
          Point(Left + w, Top + (h - cx) * dir), Point(Left + w, Top + (h - cx - LineWidth) * dir), Point(Left + w - Abs(cx), Top + (h - LineWidth) * dir), Point(Left + w - Abs(cx), Top + (h) * dir)]);
      end;

    end;
  end;

begin
  Canvas.Brush.Color := aColor;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Color := aColor;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 1;
  dir := 1;
  if bMirrored then
    dir := -1;
  InflateRect(aRect, -Gap, -Gap);
  offset := LineGap * 2 * -dir;
  for i := 1 to Count do
  begin
    SimpleDraw(aRect);
    if bVertical then
      OffsetRect(aRect, 0, offset)
    else
      OffsetRect(aRect, offset, 0);
  end;
end;

procedure frxParsePageNumbers(const PageNumbers: String; List: TStrings;
  Total: Integer);
var
  i, j, n1, n2: Integer;
  s: String;
  IsRange: Boolean;
begin
  List.Clear;
  s := PageNumbers;
  for i := Length(s) downto 1 do
  begin 
    {$IFDEF DELPHI12}
    if not CharInSet(s[i], ['0', '1'..'9', '-', ',']) then
    {$ELSE}
    if not (Char(s[i]) in ['0', '1'..'9', '-', ',']) then
    {$ENDIF}
      Delete(s, i, 1);
  end;
  {while Pos(' ', s) <> 0 do
  Delete(s, Pos(' ', s), 1);}
  if s = '' then Exit;

  if s[Length(s)] = '-' then
    s := s + IntToStr(Total);
  s := s + ',';
  i := 1; j := 1; n1 := 1;
  IsRange := False;

  while i <= Length(s) do
  begin
    if s[i] = ',' then
    begin
      n2 := StrToInt(Copy(s, j, i - j));
      j := i + 1;
      if IsRange then
        while n1 <= n2 do
        begin
          List.Add(IntToStr(n1));
          Inc(n1);
        end
      else
        List.Add(IntToStr(n2));
      IsRange := False;
    end
    else if s[i] = '-' then
    begin
      IsRange := True;
      n1 := StrToInt(Copy(s, j, i - j));
      j := i + 1;
    end;
    Inc(i);
  end;
end;

function ColorText(Color: TColor) : String;
var
  TheRgbValue : TColorRef;
begin
  TheRgbValue := ColorToRGB(Color);
  Result := Format('%.2x%.2x%.2x', [GetRValue(TheRGBValue), GetGValue(TheRGBValue), GetBValue(TheRGBValue)]);
end;

function FFColorText(Color: TColor) : String;
begin
  Result := 'FF' + ColorText(Color);
end;

function HTMLRGBColor(Color: TColor): string;
begin
  Result := '#' + ColorText(Color);
end;

procedure ConvertOneItem(Item: TCollectionItem; ToAnsi: Boolean);
var
  i: Integer;
  TypeInfo: PTypeInfo;
  PropCount: Integer;
  PropList: PPropList;

  function Convert(const Value: String): String;
  var
    i: Integer;
  begin
    Result := '';
    i := 1;
    while i <= Length(Value) do
    begin
      if ToAnsi then
      begin
        if Value[i] >= #128 then
          Result := Result + #1 + Chr(Ord(Value[i]) - 128) else
          Result := Result + Value[i];
      end
      else
      begin
        if (Value[i] = #1) and (i < Length(Value)) then
        begin
          Result := Result + Chr(Ord(Value[i + 1]) + 128);
          Inc(i);
        end
        else
          Result := Result + Value[i];
      end;

      Inc(i);
    end;
  end;

  procedure DoStrProp;
  var
    Value, NewValue: String;
  begin
    Value := GetStrProp(Item, PropList[i]);
    NewValue := Convert(Value);
    if Value <> NewValue then
      SetStrProp(Item, PropList[i], NewValue);
  end;

  procedure DoVariantProp;
  var
    Value: Variant;
  begin
    Value := GetVariantProp(Item, PropList[i]);
    if (TVarData(Value).VType = varString) or (TVarData(Value).VType = varOleStr)
    {$IFDEF DELPHI12} or (TVarData(Value).VType = varUString){$ENDIF} then
    begin
      Value := Convert(Value);
      SetVariantProp(Item, PropList[i], Value);
    end;
  end;

begin
  TypeInfo := Item.ClassInfo;
  PropCount := GetTypeData(TypeInfo).PropCount;
  GetMem(PropList, PropCount * SizeOf(PPropInfo));
  GetPropInfos(TypeInfo, PropList);

  try
    for i := 0 to PropCount - 1 do
    begin
      case PropList[i].PropType^.Kind of
        tkString, tkLString, tkWString{$IFDEF FPC}, tkAString{$ENDIF}:
          DoStrProp;

        tkVariant:
          DoVariantProp;
      end;
    end;

  finally
    FreeMem(PropList, PropCount * SizeOf(PPropInfo));
  end;
end;


procedure frxWriteProperties(Instance: TPersistent; Writer: TWriter; Owner: TfrxComponent);
var
  xs: TfrxXMLSerializer;
begin
  xs := TfrxXMLSerializer.Create(nil);
  try
    Writer.WriteString(xs.ObjToXML(Instance));
  finally
    xs.Free;
  end;
end;

procedure frxReadProperties(Instance: TPersistent; Reader: TReader; Owner: TfrxComponent);
var
  xs: TfrxXMLSerializer;
begin
  xs := TfrxXMLSerializer.Create(nil);
  try
    xs.XMLToObj(Reader.ReadString, Instance);
  finally
    xs.Free;
  end;
end;

procedure frxWriteCollection(Collection: TCollection; Writer: TWriter;
  Owner: TfrxComponent);
var
  i: Integer;
  xs: TfrxXMLSerializer;
  s: String;
{$IFDEF DELPHI12}
{$ELSE}
  vt: TValueType;
  l: Integer;
{$ENDIF}
begin
  if Owner.IsWriting then
  begin
    { called from SaveToStream }
    Writer.WriteListBegin;
    xs := TfrxXMLSerializer.Create(nil);
    try
      xs.Owner := Owner.Report;
      for i := 0 to Collection.Count - 1 do
      begin
        Writer.WriteListBegin;
{$IFDEF DELPHI12}
        s := {UTF8Encode(}xs.ObjToXML(Collection.Items[i]);
        Writer.WriteString(s);
        Writer.WriteListEnd;
{$ELSE}
{$IFDEF FPC}
        s := {UTF8Encode(}xs.ObjToXML(Collection.Items[i]);
        Writer.WriteString(s);
        Writer.WriteListEnd;
{$ELSE}
        s := xs.ObjToXML(Collection.Items[i]);
        vt := vaLString;
        Writer.Write(vt, SizeOf(vt));
        l := Length(s);
        Writer.Write(l, SizeOf(l));
        Writer.Write(s[1], l);
        Writer.WriteListEnd;
{$ENDIF}
{$ENDIF}
      end;
    finally
      Writer.WriteListEnd;
      xs.Free;
    end;
  end
  else
  begin
    { called from Delphi streamer }
    Writer.WriteCollection(Collection);
  end;
end;

function frxWriteCollection(Collection: TCollection; const Name: String; Item: TfrXMLItem; Owner: TfrxComponent; aAncestor: TfrCollection; ACreateNewItem: Boolean): TfrXMLItem;
var
  i: Integer;
  xs: TfrxXMLSerializer;
  xi: TfrXMLItem;
  LReport: TfrxReport;
  LNeedFree: Boolean;
  frxCollection: TfrCollection;
  ItemAnc: TPersistent;
  cItem: TfrCollectionItem;
begin
  if ACreateNewItem then
  begin
    Item := Item.Add;
    Item.Name := Name;
  end;
  Result := Item;
  LNeedFree := False;
  frxCollection := nil;
  LReport := nil;
  xs := nil;
  ItemAnc := nil;
  if Assigned(Owner) then
    LReport := Owner.Report;
  if Assigned(LReport) then
    xs := TfrxXMLSerializer(LReport.XmlSerializer);

  if Collection is TfrCollection then
    frxCollection := TfrCollection(Collection);
  if xs = nil then
  begin
    xs := TfrxXMLSerializer.Create(nil);
    xs.Owner := LReport;
    LNeedFree := True;
    // todo for collection editors, to determinate ancestor
    //IsInherite := Owner.IsAncestor and (frxCollection <> nil);
  end;

  try
    for i := 0 to Collection.Count - 1 do
    begin
      if (frxCollection <> nil) and (aAncestor <> nil) then
        ItemAnc := aAncestor.FindByName(TfrCollectionItem(frxCollection.Items[i]).InheritedName);

      xi := Item.Add;
      xi.Name := 'item';
      if ItemAnc <> nil then
        xi.Text := xi.Text + ' InheritedName="' + frxStrToXML(TfrCollectionItem(ItemAnc).InheritedName) + '"';

      xi.Text := xi.Text + xs.ObjToXML(Collection.Items[i], '', ItemAnc);
      if Collection.Items[i] is TfrCollectionItem then
        TfrCollectionItem(Collection.Items[i]).WriteProperties(xi, nil, Owner);


      if Assigned(frxCollection) then
      begin
        cItem := TfrCollectionItem(Collection.Items[i]);
        if cItem.IsUniqueNameStored then
          xi.Text := xi.Text + ' uin="' + IntToStr(cItem.UniqueIndex) + '"';
      end;
    end;
  finally
    if LNeedFree then
      xs.Free;
  end;
end;

procedure frxReadCollection(Collection: TCollection; Reader: TReader;
  Owner: TfrxComponent);
var
  i: Integer;
  vt: TValueType;
  xs: TfrxXMLSerializer;
  s: String;
  Item: TCollectionItem;
  NeedFree: Boolean;
begin
  vt := Reader.ReadValue;
  if vt <> vaCollection then
  begin
    { called from LoadFromStream }
    NeedFree := False;
    xs := nil;
    if Owner.Report <> nil then
      xs := TfrxXMLSerializer(Owner.Report.XMLSerializer);

    if xs = nil then
    begin
      xs := TfrxXMLSerializer.Create(nil);
      xs.Owner := Owner.Report;
      NeedFree := True;
    end;

    try
      Collection.Clear;

      while not Reader.EndOfList do
      begin
        Reader.ReadListBegin;
        Item := Collection.Add;
{$IFDEF DELPHI12}
//UTF8Decode()
        s := Reader.ReadString;
{$ELSE}
        s := Reader.ReadString;
{$ENDIF}
        if NeedFree then
          xs.ReadPersistentStr(Owner.Report, Item, s)
        else
          xs.XMLToObj(s, Item);
        Reader.ReadListEnd;
      end;
    finally
      Reader.ReadListEnd;
      if NeedFree then
        xs.Free;
    end;
  end
  else
  begin
    { called from Delphi streamer }
    Reader.ReadCollection(Collection);
    for i := 0 to Collection.Count - 1 do
      ConvertOneItem(Collection.Items[i], False);
  end;
end;

procedure frxReadCollection(Collection: TCollection; Item: TfrXMLItem; Owner: TfrxComponent; aAncestor: TfrCollection);
var
  i, j: Integer;
  xs: TfrxXMLSerializer;
  ci: TCollectionItem;
  ci1: TfrCollectionItem;
  needFree, LIsAncestor: Boolean;
  frxCollection: TfrCollection;
  InheritedName: String;
begin
  xs := nil;
  frxCollection := nil;
  needFree := False;
  // use parent serializer if any. We need fixups.
  if Assigned(Owner) and Assigned(Owner.Report) then
    xs := TfrxXMLSerializer(Owner.Report.XmlSerializer);

  if Collection is TfrCollection then
    frxCollection := TfrCollection(Collection);

  if xs = nil then
  begin
    xs := TfrxXMLSerializer.Create(nil);
    if Assigned(Owner) then
      xs.Owner := Owner.Report;
    needFree := True;
  end;

  LIsAncestor := Assigned(Owner) and Owner.IsAncestor;
  Collection.BeginUpdate;
  try
    if LIsAncestor and (frxCollection = nil) then
      Collection.Clear;
    for i := 0 to Item.Count - 1 do
    begin
      if LIsAncestor and (frxCollection <> nil) {and (aAncestor <> nil)} then
      begin
        InheritedName := Item[i].Prop['InheritedName'];

        if InheritedName <> '' then
        begin
          ci1 := frxCollection.FindByName(InheritedName);
          if ci1 <> nil then
          begin
            xs.XMLToObj(Item[i].Text, ci1);
            ci1.IsInherited := True;
          end;
          Continue;
        end;
      end;
      ci := Collection.Add;
      xs.XMLToObj(Item[i].Text, ci);
      for j := 0 to Item[i].Count - 1 do
      begin
        if ci is TfrCollectionItem then
          TfrCollectionItem(ci).ReadProperties(Item[i].Items[j].Name, Item[i].Items[j], nil);
      end;

      if Assigned(frxCollection) then
      begin
        ci1 := TfrCollectionItem(ci);
        if ci1.IsUniqueNameStored then
        begin
          InheritedName := Item[i].Prop['uin'];
          if InheritedName <> '' then
            ci1.UniqueIndex := StrToInt(InheritedName);
        end;
      end;
    end;
  finally
    if needFree then
      xs.Free;
    Collection.EndUpdate;
  end;
end;

function GetTemporaryFolder: String;
var
  Path: String;
begin
{$IFDEF FPC}
  Result := GetTempDir(True);
{$ELSE}
  Setlength(Path, MAX_PATH);
  SetLength(Path, GetTempPath(MAX_PATH, @Path[1]));
{$IFDEF DELPHI12}
  Result := StrPas(PWideChar(@Path[1]));
{$ELSE}
  Result := StrPas(@Path[1]);
{$ENDIF}
{$ENDIF}
end;

function frxCreateTempFile(const TempDir: String): String;
var
  Path: String;
  FileName: String;
  {$IFDEF FPC}
  AFileHandle: TfrHandle;
  {$ENDIF}
begin
  Path := TempDir;
{$IFDEF FPC}
  if (Path <> '') and (Path[Length(Path)] <> PathDelim) then
    Path := Path + PathDelim;
  Result := GetTempFileName(Path,'fr');
  AFileHandle := FileCreate(Result);
  if AFileHandle <> -1 then
    FileClose(AFileHandle);
{$ELSE}
  if (Path <> '') and (Path[Length(Path)] <> '\') then
    Path := Path + '\';
  SetLength(FileName, MAX_PATH);
  if Path = '' then
  begin
    SetLength(Path, MAX_PATH);
    SetLength(Path, GetTempPath(MAX_PATH, @Path[1]));
  end
  else begin
    Path := Path + #0;
    SetLength(Path, MAX_PATH);
  end;
  Result := frGetTempFileName(Path, 'fr');
{$ENDIF}
end;

function GetAppFileName: String;
{$IFNDEF FPC}
var
  fName: String;
  nsize: cardinal;
{$ENDIF}
begin
 {$IFNDEF FPC}
  if (IsLibrary) then
  begin
    nsize := MAX_PATH;
    SetLength(fName,nsize);
    SetLength(fName, GetModuleFileName(hinstance, pchar(fName), nsize));
    Result := fName;
  end
  else
 {$ENDIF}
    Result := Application.ExeName;
end;

function GetAppPath: String;
begin
  Result := ExtractFilePath(GetAppFileName);
end;

{$IFNDEF DELPHI7}
function frFloat2Str(const Value: Extended; const Prec: Integer = 2): String;
var
  i: Integer;
  IntVal: Integer;
begin
  IntVal := Trunc(Value);
  if IntVal <> Value then
    Result := Format('%.' + IntToStr(Prec)+ 'f', [Value])
  else
    Result := IntToStr(IntVal);
  if DecimalSeparator <> '.' then
  begin
    i := Pos(DecimalSeparator, Result);
    if i > 0 then
      Result[i] := '.';
  end;
end;
{$ELSE}
function frFloat2Str(const Value: Extended; const Prec: Integer = 2; const Sep: Char = '.'): String;
var
  FormatSettings: TFormatSettings;
  Buffer: array[0..63] of Char;
begin
  FormatSettings.DecimalSeparator := Sep;
  FormatSettings.ThousandSeparator := Char(0);
  SetString(Result, Buffer, FloatToText(Buffer, Value, fvExtended,
    ffFixed, 32, Prec, FormatSettings));
end;
{$ENDIF}

function frxReverseString(const AText: string): string;
var
  I: Integer;
  P: PChar;
begin
  SetLength(Result, Length(AText));
  P := PChar(Result);
  for I := Length(AText) downto 1 do
  begin
    P^ := AText[I];
    Inc(P);
  end;
end;

function ChangeChars(const Str: string; FromChar, ToChar: Char): string;
var
  I: Integer;
begin
  Result := Str;
  for I := 1 to Length(Result) do
    if Result[I] = FromChar then
      Result[I] := ToChar;
end;

function frxUnixPath2WinPath(const Path: string): string;
begin
  Result := ChangeChars(Path, '/', '\');
end;

{$IFNDEF DELPHI6}
function DirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;
{$ENDIF}


{$IFNDEF DELPHI7}
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;
{$ENDIF}

procedure frxUpdateControl(AControl: TWinControl;
  const ARepaint: Boolean = {$IFDEF NONWINFPC}False{$ELSE}True{$ENDIF});
begin
  {$IFDEF FPC}
  if AControl.HandleAllocated then
  begin
  {$ENDIF}
    if ARepaint then
      AControl.Repaint
    else
      AControl.Update;
  {$IFDEF FPC}
  end;
  {$ENDIF}
end;

procedure GetDisplayScale(DevHandle: TfrHandle; IsPrinterHandle: Boolean; var aScaleX, aScaleY: Extended);
{$IFNDEF FPC}
var
  DevMode: TDevMode;
{$ENDIF}
begin
  aScaleX := GetDeviceCaps(DevHandle, LOGPIXELSX) / 96;
  aScaleY := GetDeviceCaps(DevHandle, LOGPIXELSY) / 96;
  if (Abs(aScaleX - 1) > 1e-4) and (Abs(aScaleY - 1) > 1e-4) or IsPrinterHandle then
    Exit;
  // scale factor for non DPI aware applications
  // msdn.microsoft.com/en-us/library/windows/desktop/dn469266(v=vs.85).aspx
{$IFNDEF FPC}
  ZeroMemory(@DevMode, sizeof(DevMode));
  if EnumDisplaySettings(nil, Cardinal(-1{ENUM_CURRENT_SETTINGS MSDN FLAG}), DevMode) then
  begin
    aScaleX := 1 / (DevMode.dmPelsWidth / GetSystemMetrics(SM_CXSCREEN));
    aScaleY := 1 / (DevMode.dmPelsHeight / GetSystemMetrics(SM_CYSCREEN));
  end;
{$ENDIF}
end;

function GetStr(const Id: string): string;
begin
  Result := frxResources.Get(Id)
end;

procedure ChangeGlyphColor(Index: Integer; Color: TColor);
var
  bmp: TBitmap;
begin
  bmp := TfrBitmap.CreateSize(
    Round(DefaultToolBarImageWidth * (frxImages.ImagesPPI / 96)),
    Round(DefaultToolBarImageHeight * (frxImages.ImagesPPI / 96)));
{$IFDEF FPC}
  bmp.TransparentColor := clOlive;
{$ENDIF}
  with bmp.Canvas do
  begin
    Brush.Color := clOlive;
    FillRect(Rect(0, 0, bmp.Width, bmp.Height));
  end;
  frxImages.MainButtonImages.Draw(bmp.Canvas, 0, 0, Index);
  with bmp.Canvas do
  begin
    Brush.Color := Color;
    FillRect(Rect(1, bmp.Height - 3, bmp.Width, bmp.Height));
  end;
  frxImages.MainButtonImages.ReplaceMasked(Index, bmp, bmp.TransparentColor);
  bmp.Free;
end;

function DateTimeToUTC(DateTime: TDateTime): TDateTime;
{$IFNDEF FPC}
var SystemTime, LocalSystemTime: TSystemTime;
    FileTime, LocalFileTime: TFileTime;
{$ENDIF}
begin
{$IFNDEF FPC}
    DateTimeToSystemTime(DateTime, SystemTime);
    SystemTimeToFileTime(SystemTime, LocalFileTime);
    LocalFileTimeToFileTime(LocalFileTime, FileTime);
    FileTimeToSystemTime(FileTime, LocalSystemTime);
    Result := SystemTimeToDateTime(LocalSystemTime);
{$ELSE}
    Result := LocalTimeToUniversal(DateTime);
{$ENDIF}
end;

end.
