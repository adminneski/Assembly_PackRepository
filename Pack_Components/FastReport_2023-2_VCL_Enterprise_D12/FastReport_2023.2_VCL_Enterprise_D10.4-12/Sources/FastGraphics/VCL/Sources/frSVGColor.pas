
{******************************************}
{                                          }
{             FastReport VCL               }
{               SVG Colors                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGColor;

interface

{$I frVer.inc}

uses
  Graphics,
  frSVGComponents;

type
  TSVGColor = record
    R, G, B: Byte; Alpha: Single;
  end;

  TSVGColorSW = record
    SW: TSVGSpecificWord;
    R, G, B: Byte; Alpha: Single;
  end;

  TSVGPaint = record
    SW: TSVGSpecificWord;
    case Byte of
      0: (R, G, B: Byte; Alpha: Single);
      1: (URI: string[255]);
  end;

procedure ParsePaint(const S: string; var Value: TSVGPaint);

procedure ParseColor(const S: string; var Value: TSVGColor);

procedure ParseColorSW(const S: string; SW: TSVGSpecificWord; var Value: TSVGColorSW);

const
  SVGColorBlack: TSVGColor = (R: 0; G: 0; B: 0; Alpha: 1.0);
  SVGColorTransparent: TSVGColor = (R: 0; G: 0; B: 0; Alpha: 0.0);
  SVGColorSWBlack: TSVGColorSW = (SW: frx_noMater; R: 0; G: 0; B: 0; Alpha: 1.0);
  SVGColorInherit: TSVGColorSW = (SW: svg_inherit);
  SVGPaintInherit: TSVGPaint = (SW: svg_inherit);

  DefaultStroke: TSVGPaint = (SW: svg_none);
  DefaultFill: TSVGPaint = (SW: frx_RGBA; R: 0; G: 0; B: 0; Alpha: 1.0);


function ToSVGColor(R, G, B: Byte; Alpha: Single): TSVGColor; overload;
function ToSVGColor(SVGPaint: TSVGPaint; Opacity: Single = 1.0): TSVGColor; overload;
function ToSVGColor(SVGColorSW: TSVGColorSW): TSVGColor; overload;

function ToSVGPaint(C: TSVGColor): TSVGPaint;

function HSL2Color(H, S, L: Single): TColor; // 0..360, 0..100, 0..100

implementation

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  SysUtils, StrUtils, Math, Classes, frSVGHelpers, frUtils;

type
  TColorNameRGBList = class (TStringList)
  public
    constructor Create;
    procedure AddColor(Name: string; R, G, B: Byte);
    procedure DecodeColorName(const Name: string; var Value: TSVGPaint);
  end;

var
  ColorNameRGBList: TColorNameRGBList;

function ToSVGPaint(C: TSVGColor): TSVGPaint;
begin
  Result.SW := frx_RGBA;
  Result.R := C.R;
  Result.G := C.G;
  Result.B := C.B;
  Result.Alpha := C.Alpha;
end;

function ToSVGColor(SVGColorSW: TSVGColorSW): TSVGColor;
begin
  with SVGColorSW do
    Result := ToSVGColor(R, G, B, Alpha);
end;

function ToSVGColor(SVGPaint: TSVGPaint; Opacity: Single = 1.0): TSVGColor;
begin
  with SVGPaint do
    Result := ToSVGColor(R, G, B, Alpha * Opacity);
end;

function ToSVGColor(R, G, B: Byte; Alpha: Single): TSVGColor;
begin
  Result.R := R;
  Result.G := G;
  Result.B := B;
  Result.Alpha := Alpha;
end;

procedure DecodeHex(const S: string; var Value: TSVGPaint);

  function IsValidHex(const S: string): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 2 to Length(S) do
      if not CharInSet(S[i], ['0' .. '9', 'a' .. 'f', 'A' .. 'F']) then
        Exit;
    Result := Length(S) in [4, 7];
  end;

var
  st: string;
begin
  if IsValidHex(S) then
  begin
    if Length(S) = 4 then st := S[1] + S[2] + S[2] + S[3] + S[3] + S[4] + S[4]
    else                  st := S;
    Value.SW := frx_RGBA;
    Value.R := StrToInt('$' + st[2] + st[3]);
    Value.G := StrToInt('$' + st[4] + st[5]);
    Value.B := StrToInt('$' + st[6] + st[7]);
    Value.Alpha := 1.0;
  end;
end;

function IsPiece(var Stub, Piece: string): Boolean;
var
  Comma: Integer;
begin
  Result := False;
  Stub := Trim(Stub);
  if Stub = '' then
    Exit;

  Comma := Pos(',', Stub);
  if Comma = 0 then
  begin
    Piece := Stub;
    Stub := '';
  end
  else
  begin
    Piece := Trim(Copy(Stub, 1, Comma - 1));
    Stub := Copy(Stub, Comma + 1, MaxInt);
  end;
  Result := True;
end;

function IsByte(var Stub: string; out B: Byte): Boolean;
var
  iB: Integer;
  Piece: string;
  Percent: Single;
begin
  Result := False;
  if not IsPiece(Stub, Piece) then
    Exit;

  if Pos('%', Piece) = Length(Piece) then
  begin
    Piece := Copy(Piece, 1, Length(Piece) - 1);
    if not TryStrToSingle(Piece, Percent) then
      Exit;
    Percent := frLimit(Percent, 0, 100);
    B := Round(255 * Percent / 100);
  end
  else
  begin
    if not TryStrToInt(Piece, iB) then
      Exit;
    B := frLimit(iB, 0, 255);
  end;
  Result := True;
end;

function IsSingle(var Stub: string; out S: Single): Boolean;
var
  Piece: string;
begin
  Result := False;
  if not IsPiece(Stub, Piece) then
    Exit;

  if not TryStrToSingle(Piece, S) then
    Exit;
  Result := True;
end;

function IsAlpha(var Stub: string; out Alpha: Single): Boolean;
begin
  Result := IsSingle(Stub, Alpha);
  if Result then
    Alpha := frLimit(Alpha, 0.0, 1.0);
end;

function IsAngle(var Stub: string; out Angle: Single): Boolean;

  function FloatMod(const A, B: Single): Single;
  begin
   Result := A - Int(A / B) * B;
  end;

begin
  Result := IsSingle(Stub, Angle);
  if Result then
  begin
    Angle := FloatMod(Angle, 360);
    if Angle < 0 then
      Angle := Angle + 360;
  end;
end;

function IsPercent(var Stub: string; out Angle: Single): Boolean;
var
  Piece: string;
  Percent: Single;
begin
  Result := False;
  if not IsPiece(Stub, Piece) or (Pos('%', Piece) <> Length(Piece)) then
    Exit;

  Piece := Copy(Piece, 1, Length(Piece) - 1);
  if not TryStrToSingle(Piece, Percent) then
    Exit;
  Percent := frLimit(Percent, 0.0, 100.0);
end;

procedure DecodeRGB(const S: string; var Value: TSVGPaint);
var
  Stub: string;
  R, G, B: Byte;
begin
  Stub := S;
  if IsByte(Stub, R) and IsByte(Stub, G) and IsByte(Stub, B) then
  begin
    Value.SW := frx_RGBA;
    Value.R := R;
    Value.G := G;
    Value.B := B;
    Value.Alpha := 1.0;
  end;
end;

procedure DecodeRGBA(const S: string; var Value: TSVGPaint);
var
  Stub: string;
  R, G, B: Byte;
  Alpha: Single;
begin
  Stub := S;
  if IsByte(Stub, R) and IsByte(Stub, G) and IsByte(Stub, B) and IsAlpha(Stub, Alpha) then
  begin
    Value.SW := frx_RGBA;
    Value.R := R;
    Value.G := G;
    Value.B := B;
    Value.Alpha := Alpha;
  end;
end;

procedure HSL2RGB(const H, S, L: Single; out R, G, B: Byte);

  function HUE2RGB(m1, m2, h: Single): Byte;
  var
    r: Single;
  begin
    if      h < 0 then h := h + 1
    else if h > 1 then h := h - 1;

    if      h * 6 < 1 then r := m1 + (m2 - m1) * h * 6
    else if h * 2 < 1 then r := m2
    else if h * 3 < 2 then r := m1 + (m2 - m1) * (2 / 3 - h) * 6
    else                   r := m1;

    Result := Round(r * 255);
  end;

var
  m1, m2: Single;
begin
  if L <= 0.5 then m2 := L * (S + 1)
  else             m2 := L + S - L*S;
  m1 := L * 2 - m2;
  R := HUE2RGB(m1, m2, H + 1 / 3);
  G := HUE2RGB(m1, m2, H);
  B := HUE2RGB(m1, m2, H - 1 / 3);
end;

procedure DecodeHSL(const Str: string; var Value: TSVGPaint);
var
  Stub: string;
  H, S, L: Single;
begin
  Stub := Str;
  if IsAngle(Stub, H) and IsPercent(Stub, S) and IsPercent(Stub, L) then
  begin
    Value.SW := frx_RGBA;
    HSL2RGB(H / 360, S / 100, L / 100, Value.R, Value.G, Value.B);
    Value.Alpha := 1.0;
  end;
end;

procedure DecodeHSLA(const Str: string; var Value: TSVGPaint);
var
  Stub: string;
  H, S, L, Alpha: Single;
begin
  Stub := Str;
  if IsAngle(Stub, H) and IsPercent(Stub, S) and IsPercent(Stub, L)  and IsAlpha(Stub, Alpha) then
  begin
    Value.SW := frx_RGBA;
    HSL2RGB(H / 360, S / 100, L / 100, Value.R, Value.G, Value.B);
    Value.Alpha := Alpha;
  end;
end;

procedure DecodeURL(const Str: string; var Value: TSVGPaint);
var
  st: string;
begin
  st := Dequote(Str);
  if st[1] = '#' then
  begin
    Value.SW := frx_URI;
    Value.URI := Ansistring(Copy(st, 2, MaxInt));
  end;
end;

procedure ParseColor(const S: string; var Value: TSVGColor);
var
  Paint: TSVGPaint;
begin
  if S <> '' then
  begin
    ParsePaint(S, Paint);
    if Paint.SW = frx_RGBA then
    begin
      Value.R := Paint.R;
      Value.G := Paint.G;
      Value.B := Paint.B;
      Value.Alpha := Paint.Alpha;
    end;
  end;
end;

procedure ParseColorSW(const S: string; SW: TSVGSpecificWord; var Value: TSVGColorSW);
var
  Paint: TSVGPaint;
begin
  if S <> '' then
  begin
    ParsePaint(S, Paint);
    if      Paint.SW = frx_RGBA then
    begin
      Value.R := Paint.R;
      Value.G := Paint.G;
      Value.B := Paint.B;
      Value.Alpha := Paint.Alpha;
      Value.SW := frx_RGBA;
    end
    else if Paint.SW = SW then
      Value.SW := SW;
  end;
end;

procedure ParsePaint(const S: string; var Value: TSVGPaint);
var
  Unwrap: string;

  function IsWrap(const S1: string): Boolean;
  begin
    Result := (LeftStr(S, Length(S1)) = S1) and (S[Length(S)] = ')');
    if Result then
      Unwrap := Copy(S, Length(S1) + 1, Length(S) - Length(S1) - 1);
  end;

begin
  if S <> '' then
    if      S = SVGSpecificWord[svg_none] then           Value.SW := svg_None
    else if S = SVGSpecificWord[svg_transparent] then    Value.SW := svg_None
    else if S = SVGSpecificWord[svg_currentcolor] then   Value.SW := svg_currentColor
    else if S = SVGSpecificWord[svg_inherit] then        Value.SW := svg_inherit
    else if S = SVGSpecificWord[svg_context_stroke] then Value.SW := svg_context_stroke
    else if S = SVGSpecificWord[svg_context_fill] then   Value.SW := svg_context_fill
    else if S[1] = '#' then           DecodeHex(S, Value)
    else if IsWrap('rgb(') then       DecodeRGB(Unwrap, Value)
    else if IsWrap('rgba(') then      DecodeRGBA(Unwrap, Value)
    else if IsWrap('hsl(') then       DecodeHSL(Unwrap, Value)
    else if IsWrap('hsla(') then      DecodeHSLA(Unwrap, Value)
    else if IsWrap('url(') then       DecodeURL(Unwrap, Value)
    else                              ColorNameRGBList.DecodeColorName(S, Value);
end;

function HSL2Color(H, S, L: Single): TColor;
var
  R, G, B: Byte;
begin
  HSL2RGB(H / 360, S / 100, L / 100, R, G, B);
  Result := RGB(R, G, B);
end;

{ TColorNameRGBList }

procedure TColorNameRGBList.AddColor(Name: string; R, G, B: Byte);
begin
  AddObject(Name, TObject(RGB(R, G, B)));
end;

constructor TColorNameRGBList.Create;
begin
  inherited Create;
  Sorted := True;

  AddColor('aliceblue', 240, 248, 255);
  AddColor('antiquewhite', 250, 235, 215);
  AddColor('aqua', 0, 255, 255);
  AddColor('aquamarine', 127, 255, 212);
  AddColor('azure', 240, 255, 255);
  AddColor('beige', 245, 245, 220);
  AddColor('bisque', 255, 228, 196);
  AddColor('black', 0, 0, 0);
  AddColor('blanchedalmond', 255, 235, 205);
  AddColor('blue', 0, 0, 255);
  AddColor('blueviolet', 138, 43, 226);
  AddColor('brown', 165, 42, 42);
  AddColor('burlywood', 222, 184, 135);
  AddColor('cadetblue', 95, 158, 160);
  AddColor('chartreuse', 127, 255, 0);
  AddColor('chocolate', 210, 105, 30);
  AddColor('coral', 255, 127, 80);
  AddColor('cornflowerblue', 100, 149, 237);
  AddColor('cornsilk', 255, 248, 220);
  AddColor('crimson', 220, 20, 60);
  AddColor('cyan', 0, 255, 255);
  AddColor('darkblue', 0, 0, 139);
  AddColor('darkcyan', 0, 139, 139);
  AddColor('darkgoldenrod', 184, 134, 11);
  AddColor('darkgray', 169, 169, 169);
  AddColor('darkgreen', 0, 100, 0);
  AddColor('darkgrey', 169, 169, 169);
  AddColor('darkkhaki', 189, 183, 107);
  AddColor('darkmagenta', 139, 0, 139);
  AddColor('darkolivegreen', 85, 107, 47);
  AddColor('darkorange', 255, 140, 0);
  AddColor('darkorchid', 153, 50, 204);
  AddColor('darkred', 139, 0, 0);
  AddColor('darksalmon', 233, 150, 122);
  AddColor('darkseagreen', 143, 188, 143);
  AddColor('darkslateblue', 72, 61, 139);
  AddColor('darkslategray', 47, 79, 79);
  AddColor('darkslategrey', 47, 79, 79);
  AddColor('darkturquoise', 0, 206, 209);
  AddColor('darkviolet', 148, 0, 211);
  AddColor('deeppink', 255, 20, 147);
  AddColor('deepskyblue', 0, 191, 255);
  AddColor('dimgray', 105, 105, 105);
  AddColor('dimgrey', 105, 105, 105);
  AddColor('dodgerblue', 30, 144, 255);
  AddColor('firebrick', 178, 34, 34);
  AddColor('floralwhite', 255, 250, 240);
  AddColor('forestgreen', 34, 139, 34);
  AddColor('fuchsia', 255, 0, 255);
  AddColor('gainsboro', 220, 220, 220);
  AddColor('ghostwhite', 248, 248, 255);
  AddColor('gold', 255, 215, 0);
  AddColor('goldenrod', 218, 165, 32);
  AddColor('gray', 128, 128, 128);
  AddColor('green', 0, 128, 0);
  AddColor('greenyellow', 173, 255, 47);
  AddColor('grey', 128, 128, 128);
  AddColor('honeydew', 240, 255, 240);
  AddColor('hotpink', 255, 105, 180);
  AddColor('indianred', 205, 92, 92);
  AddColor('indigo', 75, 0, 130);
  AddColor('ivory', 255, 255, 240);
  AddColor('khaki', 240, 230, 140);
  AddColor('lavender', 230, 230, 250);
  AddColor('lavenderblush', 255, 240, 245);
  AddColor('lawngreen', 124, 252, 0);
  AddColor('lemonchiffon', 255, 250, 205);
  AddColor('lightblue', 173, 216, 230);
  AddColor('lightcoral', 240, 128, 128);
  AddColor('lightcyan', 224, 255, 255);
  AddColor('lightgoldenrodyellow', 250, 250, 210);
  AddColor('lightgray', 211, 211, 211);
  AddColor('lightgreen', 144, 238, 144);
  AddColor('lightgrey', 211, 211, 211);
  AddColor('lightpink', 255, 182, 193);
  AddColor('lightsalmon', 255, 160, 122);
  AddColor('lightseagreen', 32, 178, 170);
  AddColor('lightskyblue', 135, 206, 250);
  AddColor('lightslategray', 119, 136, 153);
  AddColor('lightslategrey', 119, 136, 153);
  AddColor('lightsteelblue', 176, 196, 222);
  AddColor('lightyellow', 255, 255, 224);
  AddColor('lime', 0, 255, 0);
  AddColor('limegreen', 50, 205, 50);
  AddColor('linen', 250, 240, 230);
  AddColor('magenta', 255, 0, 255);
  AddColor('maroon', 128, 0, 0);
  AddColor('mediumaquamarine', 102, 205, 170);
  AddColor('mediumblue', 0, 0, 205);
  AddColor('mediumorchid', 186, 85, 211);
  AddColor('mediumpurple', 147, 112, 219);
  AddColor('mediumseagreen', 60, 179, 113);
  AddColor('mediumslateblue', 123, 104, 238);
  AddColor('mediumspringgreen', 0, 250, 154);
  AddColor('mediumturquoise', 72, 209, 204);
  AddColor('mediumvioletred', 199, 21, 133);
  AddColor('midnightblue', 25, 25, 112);
  AddColor('mintcream', 245, 255, 250);
  AddColor('mistyrose', 255, 228, 225);
  AddColor('moccasin', 255, 228, 181);
  AddColor('navajowhite', 255, 222, 173);
  AddColor('navy', 0, 0, 128);
  AddColor('oldlace', 253, 245, 230);
  AddColor('olive', 128, 128, 0);
  AddColor('olivedrab', 107, 142, 35);
  AddColor('orange', 255, 165, 0);
  AddColor('orangered', 255, 69, 0);
  AddColor('orchid', 218, 112, 214);
  AddColor('palegoldenrod', 238, 232, 170);
  AddColor('palegreen', 152, 251, 152);
  AddColor('paleturquoise', 175, 238, 238);
  AddColor('palevioletred', 219, 112, 147);
  AddColor('papayawhip', 255, 239, 213);
  AddColor('peachpuff', 255, 218, 185);
  AddColor('peru', 205, 133, 63);
  AddColor('pink', 255, 192, 203);
  AddColor('plum', 221, 160, 221);
  AddColor('powderblue', 176, 224, 230);
  AddColor('purple', 128, 0, 128);
  AddColor('red', 255, 0, 0);
  AddColor('rosybrown', 188, 143, 143);
  AddColor('royalblue', 65, 105, 225);
  AddColor('saddlebrown', 139, 69, 19);
  AddColor('salmon', 250, 128, 114);
  AddColor('sandybrown', 244, 164, 96);
  AddColor('seagreen', 46, 139, 87);
  AddColor('seashell', 255, 245, 238);
  AddColor('sienna', 160, 82, 45);
  AddColor('silver', 192, 192, 192);
  AddColor('skyblue', 135, 206, 235);
  AddColor('slateblue', 106, 90, 205);
  AddColor('slategray', 112, 128, 144);
  AddColor('slategrey', 112, 128, 144);
  AddColor('snow', 255, 250, 250);
  AddColor('springgreen', 0, 255, 127);
  AddColor('steelblue', 70, 130, 180);
  AddColor('tan', 210, 180, 140);
  AddColor('teal', 0, 128, 128);
  AddColor('thistle', 216, 191, 216);
  AddColor('tomato', 255, 99, 71);
  AddColor('turquoise', 64, 224, 208);
  AddColor('violet', 238, 130, 238);
  AddColor('wheat', 245, 222, 179);
  AddColor('white', 255, 255, 255);
  AddColor('whitesmoke', 245, 245, 245);
  AddColor('yellow', 255, 255, 0);
  AddColor('yellowgreen', 154, 205, 50);

end;

procedure TColorNameRGBList.DecodeColorName(const Name: string; var Value: TSVGPaint);
var
  Index: Integer;
begin
  if Find(Name, Index) then
  begin
    Value.SW := frx_RGBA;
    Value.R := GetRValue(Cardinal(Objects[Index]));
    Value.G := GetGValue(Cardinal(Objects[Index]));
    Value.B := GetBValue(Cardinal(Objects[Index]));
    Value.Alpha := 1.0;
  end;
end;

initialization

  ColorNameRGBList := TColorNameRGBList.Create;

finalization

  ColorNameRGBList.Free;

end.
