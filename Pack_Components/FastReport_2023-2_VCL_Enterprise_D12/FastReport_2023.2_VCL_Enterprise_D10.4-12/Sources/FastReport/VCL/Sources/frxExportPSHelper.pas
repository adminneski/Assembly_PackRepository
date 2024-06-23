unit frxExportPSHelper;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, frxExportBaseDialog, SysUtils, Classes, Graphics, frxClass, frxExportMatrix, Math, frxBarcod, frxBarcode, frxBarcode2D,
  frxBarcodeMaxiCode, frxTableObject, frxRes, frxImageConverter;

type
  Dashes = (Dash, Dot, DashDot, DashDotDot, DDouble);
  PSImageFormat = (psPng, psJpeg);
  AOF = array of Double;

  function ColorToHtml(DColor:TColor): string;
  function BitMapStream(BitMap: TBitmap): TMemoryStream;
  function HexToTColor(sColor : string) : TColor;
  function GetColorFromFill(Fill: TfrxCustomFill): TColor;
  function MemoryStreamToHexStr(AStream: TMemoryStream): string;
  function MmToPt(mm: Double): Double;
  function MmToDp(mm: Double): Double;
  function DpToMm(dp: Double): Double;
  function DpToPt(dp: Double): Double;
  function GetMixedColor(StartColor, EndColor: TColor): TColor;

implementation

uses frxUtils;

function ColorToHtml(DColor:TColor):string;
var
  tmpRGB : TColorRef;
begin
  tmpRGB := ColorToRGB(DColor) ;
  Result:=Format('#%.2x%.2x%.2x', [GetRValue(tmpRGB), GetGValue(tmpRGB), GetBValue(tmpRGB)]) ;
end;

function HexToTColor(sColor : string) : TColor;
 begin
    Result :=
      RGB(
        StrToInt('$'+Copy(sColor, 1, 2)),
        StrToInt('$'+Copy(sColor, 3, 2)),
        StrToInt('$'+Copy(sColor, 5, 2))
      ) ;
 end;

function BitMapStream(BitMap: TBitmap): TMemoryStream;
begin
  result := TMemoryStream.Create;
  BitMap.SaveToStream(result);
end;

function GetColorFromFill(Fill: TfrxCustomFill): TColor;
var
  brush: TfrxBrushFill;
  //gradient: TfrxGradientFill; not work
begin
  result := clNone;
  brush := TfrxBrushFill(Fill);
  case (brush.Style) of
    bsSolid, bsClear:
      result := brush.BackColor;
    bsHorizontal, bsVertical, bsFDiagonal, bsBDiagonal, bsCross, bsDiagCross:
      result := GetMixedColor(brush.BackColor, brush.ForeColor);
  end;
end;

function MemoryStreamToHexStr(AStream: TMemoryStream): string;
const
 HexArr: array[0..15] of char =
 ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E',
   'F');
var
 AByte: Byte;
 i: Integer;
begin
 SetLength(Result, AStream.Size * 2);
 for i := 0 to AStream.Size - 1 do
 begin
   AByte := PByteArray(AStream.Memory)[i];
   Result[i * 2 + 1] := HexArr[AByte shr 4];
   Result[i * 2 + 2] := HexArr[AByte and $0F];
 end;
end;

function MmToPt(mm: Double): Double;
begin
  result := mm * 72 / 2.54 / 10;
end;

function MmToDp(mm: Double): Double;
begin
  result := mm * 96 / 2.54 / 10;
end;

function DpToMm(dp: Double): Double;
begin
  result := dp / 96 * 2.54 * 10;
end;

function DpToPt(dp: Double): Double;
begin
  result := MmToPt(DpToMm(dp));
end;

function GetMixedColor(StartColor, EndColor: TColor): TColor; //like TfrxGradientFill.GetColor
var
  R, G, B: Byte;
  FromR, FromG, FromB: Integer;
  DiffR, DiffG, DiffB: Integer;
begin
  FromR := StartColor and $000000ff;
  FromG := (StartColor shr 8) and $000000ff;
  FromB := (StartColor shr 16) and $000000ff;
  DiffR := (EndColor and $000000ff) - FromR;
  DiffG := ((EndColor shr 8) and $000000ff) - FromG;
  DiffB := ((EndColor shr 16) and $000000ff) - FromB;
  R := FromR + MulDiv(127, DiffR, 255);
  G := FromG + MulDiv(127, DiffG, 255);
  B := FromB + MulDiv(127, DiffB, 255);
  {$IFDEF FPC}
  Result := RGBToColor(R, G, B);
  {$ELSE}
  Result := RGB(R, G, B);
  {$ENDIF}
end;

end.
