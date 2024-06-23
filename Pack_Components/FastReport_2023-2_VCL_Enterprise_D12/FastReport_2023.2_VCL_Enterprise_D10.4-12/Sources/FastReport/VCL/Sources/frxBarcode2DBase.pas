
{ ****************************************** }
{                                            }
{             FastReport VCL                 }
{          2D Barcode base class             }
{                                            }
{         Copyright (c) 1998-2021            }
{            by Fast Reports Inc.            }
{                                            }
{ ****************************************** }

unit frxBarcode2DBase;
//{$Define RandVertCol}
interface

{$I frx.inc}

uses
  Classes, SysUtils,
{$IFDEF FPC}
  LResources, LMessages, LCLType, LCLIntf, LazarusPackageIntf,
  LCLProc, FileUtil, LazHelper,
{$ELSE}
  Windows,
{$ENDIF}
  Graphics, Types, frxPrinter, frxBarcodeInterface;

type

  T2DBooleanArray = array of array of Boolean;

  /// ////////////////////////////////////////////////////////////////////////////////////////////
  // base 2D barcode class
  /// ////////////////////////////////////////////////////////////////////////////////////////////

{$M+}
  TfrxBarcode2DBase = class(TObject)
  protected
    FBarcodeText: TfrxBarcodeText;
    FHeight: Integer; // height of barcode matrix
    FWidth: Integer; // Width of barcode matrix
    FPixelWidth: Integer;
    FPixelHeight: Integer;
    FShowText: Boolean;
    FRotation: Integer;
    FText: String;
    FTextSup: String;
    FZoom: Extended;
    FFontScaled: Boolean; // scale font with barcode
    FColor: TColor;
    FColorBar: TColor;
    FErrorText: String;
    FQuietZone: Integer; // paddings
    FOriginalHeight: Integer;  //for linear multi-line barcodes

    procedure GenerateLM(Text: string; rebase: Boolean = True); virtual;  //for linear multi-line barcodes
    procedure SetShowText(v: Boolean); virtual;
    procedure SetRotation(v: Integer); virtual;
    procedure SetText(v: String); virtual;
    procedure SetZoom(v: Extended); virtual;
    procedure SetFontScaled(v: Boolean); virtual;
    function GetFont: TFont;
    procedure SetColor(v: TColor); virtual;
    procedure SetColorBar(v: TColor); virtual;
    procedure SetErrorText(v: String); virtual;
    procedure SetHeight(const Value: Integer); virtual;

    function GetWidth: Integer; virtual;
    function GetHeight: Integer; virtual;
    procedure InternalDraw(aCanvas: TCanvas; scalex, scaley: Extended;
      x, y, footerHeight, dx, dy, paddingX, paddingY: Integer;
      kx, ky: Extended); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(src: TfrxBarcode2DBase); virtual;
    function GetFooterHeight: Integer; virtual;

    procedure Draw2DBarcode(var g: TCanvas; scalex, scaley: Extended;
      x, y: Integer); virtual;
    procedure FillRect(Canv: TCanvas; Rect: TRect);
    function IsScaled: Boolean; virtual;

    property ShowText: Boolean read FShowText write SetShowText;
    property Rotation: Integer read FRotation write SetRotation;

    property Text: String read FText write SetText;
    property TextSup: String read FTextSup write FTextSup;
    property Zoom: Extended read FZoom write SetZoom;
    property FontScaled: Boolean read FFontScaled write SetFontScaled;
    property Font: TFont read GetFont;
    property Color: TColor read FColor write SetColor;
    property ColorBar: TColor read FColorBar write SetColorBar;
    property ErrorText: String read FErrorText write SetErrorText;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight write SetHeight;
    property PixelWidth: Integer read FPixelWidth write FPixelWidth;
    property PixelHeight: Integer read FPixelHeight write FPixelHeight;
    property QuietZone: Integer read FQuietZone write FQuietZone;
    property BarcodeText: TfrxBarcodeText read FBarcodeText;
  end;

  TfrxBarcode2DBaseWithUnion = class(TfrxBarcode2DBase)
  protected
    FVectorPrimitives: TList;
    DotsR, DotsL: array of Integer;
  public
    procedure FVectorPrimitivesAdd(ALeft, ATop, AWidth, AHeight: Integer);

    constructor Create; override;
    destructor Destroy; override;

    procedure ClearFigures();
    procedure T2DBooleanArrayToVectorPrimitives(GlArr: T2DBooleanArray; x, y: Integer; QuietZone: Byte = 0);
    procedure InternalDraw(aCanvas: TCanvas; scalex, scaley: Extended;
      x, y, footerHeight, dx, dy, paddingX, paddingY: Integer;
      kx, ky: Extended); override;
  end;

  TfrxBarcode2DBaseWithOutUnion = class(TfrxBarcode2DBase)
  protected
    FImage: array of Byte; // boolean array of barcode data
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure InternalDraw(aCanvas: TCanvas; scalex, scaley: Extended;
      x, y, footerHeight, dx, dy, paddingX, paddingY: Integer;
      kx, ky: Extended); override;
  end;

const
  cbDefaultText = '12345678';

implementation

uses frxUtils
{$IFDEF LCLGTK2}
  , Printers
{$ENDIF};

constructor TfrxBarcode2DBase.Create;
begin
  FWidth := 0;
  FHeight := 0;
  FPixelWidth := 2;
  FPixelHeight := 2;
  FShowText := true;
  FRotation := 0;
  FText := cbDefaultText;
  FZoom := 1;
  FFontScaled := true;
  FColor := clWhite;
  FColorBar := clBlack;
  FBarcodeText := TfrxBarcodeText.Create;
  FBarcodeText.TextSettings.Font.Size := 10;
end;

constructor TfrxBarcode2DBaseWithUnion.Create;
begin
  inherited;
  FVectorPrimitives := TList.Create();
end;

constructor TfrxBarcode2DBaseWithOutUnion.Create;
begin
  inherited;
end;

procedure TfrxBarcode2DBaseWithUnion.FVectorPrimitivesAdd(ALeft, ATop, AWidth, AHeight: Integer);
var
  PonterRect: PRect;
begin
  New(PonterRect);
  PonterRect.Left   := ALeft;
  PonterRect.Top    := ATop;
  PonterRect.Right  := AWidth;
  PonterRect.Bottom := AHeight;
  FVectorPrimitives.Add(PonterRect);
end;

procedure TfrxBarcode2DBaseWithUnion.InternalDraw(aCanvas: TCanvas; scalex,
  scaley: Extended; x, y, footerHeight, dx, dy, paddingX, paddingY: Integer; kx,
  ky: Extended);
var
  k, j, i, x1, y1, x2, y2: Integer;
begin
  inherited;

  //dots
  for i := 0 to length(DotsR)-1 do
  begin
    j := DotsR[i];
    k := DotsL[i];

    case round(Rotation) of
      90:
        begin
          x1 := round(x + k * PixelHeight * kx);
          x2 := round(x + k * PixelHeight * kx + PixelHeight * kx);
          y1 := round(y + dx - j * PixelWidth * ky);
          y2 := round(y + dx - j * PixelWidth * ky - PixelWidth * ky);
        end;
      180:
        begin
          x1 := round(x + dx - j * PixelWidth * kx);
          x2 := round(x + dx - j * PixelWidth * kx - PixelWidth * kx);
          y1 := round(y + footerHeight + dy - k * PixelHeight * ky);
          y2 := round(y + footerHeight + dy - k * PixelHeight * ky - PixelHeight * ky);
        end;
      270:
        begin
          x1 := round(x + footerHeight + dy - k * PixelHeight * kx);
          x2 := round(x + footerHeight + dy - k * PixelHeight * kx - PixelHeight * kx);
          y1 := round(y + j * PixelWidth * ky);
          y2 := round(y + j * PixelWidth * ky + PixelWidth * ky);
        end;
      else
        begin
          x1 := round(x + j * PixelWidth * kx);
          y1 := round(y + k * PixelHeight * ky);
          x2 := round(x + j * PixelWidth * kx + PixelWidth * kx);
          y2 := round(y + k * PixelHeight * ky + PixelHeight * ky);
        end;
    end;
    FillRect(aCanvas, Rect(x1 + paddingX, y1 + paddingY, x2 + paddingX, y2 + paddingY))
  end;

  //figures
  for i := 0 to FVectorPrimitives.Count-1 do
  begin
    j := PRect(FVectorPrimitives[i]).Left;
    k := PRect(FVectorPrimitives[i]).Top;

  {$IFDEF RandVertCol}
    aCanvas.Brush.Color := RGB(Random(256), Random(256), Random(256));
    aCanvas.Pen.Color := RGB(Random(256), Random(256), Random(256));
  {$ENDIF}

    case round(Rotation) of
      90:
        begin
          x1 := round(x + k * PixelHeight * kx );
          x2 := round(x + k * PixelHeight * kx + PixelHeight * kx* PRect(FVectorPrimitives[i]).Bottom);
          y1 := round(y + dx - j * PixelWidth * ky);
          y2 := round(y + dx - j * PixelWidth * ky - PixelWidth * ky* PRect(FVectorPrimitives[i]).Right);
        end;
      180:
        begin
          x1 := round(x + dx - j * PixelWidth * kx);
          x2 := round(x + dx - j * PixelWidth * kx - PixelWidth * kx* PRect(FVectorPrimitives[i]).Right);
          y1 := round(y + footerHeight + dy - k * PixelHeight * ky);
          y2 := round(y + footerHeight + dy - k * PixelHeight * ky - PixelHeight * ky * PRect(FVectorPrimitives[i]).Bottom);
        end;
      270:
        begin
          x1 := round(x + footerHeight + dy - k * PixelHeight * kx);
          x2 := round(x + footerHeight + dy - k * PixelHeight * kx - PixelHeight * kx* PRect(FVectorPrimitives[i]).Bottom);
          y1 := round(y + j * PixelWidth * ky);
          y2 := round(y + j * PixelWidth * ky + PixelWidth * ky* PRect(FVectorPrimitives[i]).Right);
        end;
      else
        begin
          x1 := round(x + j * PixelWidth * kx);
          x2 := round(x + j * PixelWidth * kx  + PixelWidth * kx * PRect(FVectorPrimitives[i]).Right);
          y1 := round(y + k * PixelHeight * ky);
          y2 := round(y + k * PixelHeight * ky + PixelHeight * ky * PRect(FVectorPrimitives[i]).Bottom);
        end;
    end;
    FillRect(aCanvas, Rect(x1 + paddingX, y1 + paddingY, x2 + paddingX, y2 + paddingY))
  end;
end;

procedure TfrxBarcode2DBaseWithUnion.T2DBooleanArrayToVectorPrimitives(GlArr: T2DBooleanArray; x, y: Integer; QuietZone: Byte = 0);
var
  i,j,k,l,m0,cols,rows: integer;
  res: TRect;
  arr: T2DBooleanArray;
begin
  ClearFigures();
  SetLength(arr,x,y);
  for i := 0 to x - 1 - QuietZone * 2 do
    for j := 0 to y - 1 - QuietZone * 2 do
      arr[i + QuietZone][j + QuietZone] := GlArr[i][j];

  while True do
  begin
  res := Rect(1,1,1,1);
    for i := 0 to x-1 do
    begin
      for j := 0 to y-1 do
      begin
        if arr[i][j] then
        begin
          m0:=y;
          cols:=0;
          for k := i to x-1 do
          begin
            if not arr[k,j] then break;
            inc(cols);
            rows:=0;
            for l := j to m0-1 do
            begin
              inc(rows);
              if arr[k,l] then
              begin
                if (res.Right * res.Bottom < cols*rows) then
                begin
                res := Rect(i, j, cols, rows);
                end;
              end
              else
              begin
                m0:=l;
                break;
              end;
            end;
          end;
        end;
      end;
    end;

    if res.Right * res.Bottom > 1 then
    begin
        FVectorPrimitivesAdd(res.Left, res.Top, res.Right, res.Bottom);
        for cols := res.Left to res.Left + res.Right - 1 do
        begin
          for rows := res.Top to res.Top + res.Bottom - 1 do
          begin
            arr[cols][rows] := False;
          end;
        end;
    end
    else
      break;
  end;

  l := 0;
  for i := 0 to x-1 do
    for j := 0 to y-1 do
      if arr[i][j] then
        inc(l);

  setlength(DotsR, l);
  setlength(DotsL, l);
  l := 0;
  for i := 0 to x-1 do
    for j := 0 to y-1 do
      if arr[i][j] then
      begin
        DotsR[l] := i;
        DotsL[l] := j;
        inc(l);
        arr[i][j] := False;
      end;
end;

procedure TfrxBarcode2DBase.GenerateLM(Text: string; rebase: Boolean = True);
begin
  //
end;

procedure TfrxBarcode2DBase.Assign(src: TfrxBarcode2DBase);
begin
  FShowText := src.FShowText;
  FRotation := src.FRotation;
  FText := src.FText;
  FTextSup := src.FTextSup;
  FZoom := src.FZoom;
  FPixelWidth := src.FPixelWidth;
  FPixelHeight := src.FPixelHeight;
  FFontScaled := src.FFontScaled;
  FColor := src.FColor;
  FColorBar := src.FColorBar;
  FErrorText := src.FErrorText;
  FQuietZone := src.FQuietZone;
  FBarcodeText.Assign(src.BarcodeText);
end;

procedure TfrxBarcode2DBase.SetShowText(v: Boolean);
begin
  FShowText := v;
end;

procedure TfrxBarcode2DBase.SetRotation(v: Integer);
begin
  FRotation := v;
end;

procedure TfrxBarcode2DBase.SetText(v: String);
begin
  if (FText <> v) then
    FText := v;
  if (IsScaled) then
    GenerateLM(v);
end;

procedure TfrxBarcode2DBase.SetZoom(v: Extended);
begin
  FZoom := v;
end;

procedure TfrxBarcode2DBase.SetFontScaled(v: Boolean);
begin
  FFontScaled := v;
end;

procedure TfrxBarcode2DBase.SetHeight(const Value: Integer);
begin
  if (IsScaled) then
  begin
    FOriginalHeight := Value;
    FHeight := 0;
  end
end;

function TfrxBarcode2DBase.GetFont: TFont;
begin
  Result := FBarcodeText.TextSettings.Font;
end;

procedure TfrxBarcode2DBase.SetColor(v: TColor);
begin
  FColor := v;
end;

procedure TfrxBarcode2DBase.SetColorBar(v: TColor);
begin
  FColorBar := v;
end;

procedure TfrxBarcode2DBase.SetErrorText(v: String);
begin
  FErrorText := v;
end;

function TfrxBarcode2DBase.GetFooterHeight: Integer;
begin
  if ShowText then
    Result := -Font.Height - Font.Height div 4
  else
    Result := 0;
end;

function TfrxBarcode2DBase.GetWidth: Integer;
begin
  Result := round(FWidth * FPixelWidth + FQuietZone * 2);
end;

procedure TfrxBarcode2DBase.InternalDraw(aCanvas: TCanvas; scalex,
  scaley: Extended; x, y, footerHeight, dx, dy, paddingX, paddingY: Integer; kx,
  ky: Extended);
begin
// do nothing
end;

function TfrxBarcode2DBase.IsScaled: Boolean;
begin
  Result := False;
end;

function TfrxBarcode2DBase.GetHeight: Integer;
var
  ext: Extended;
begin
  if (IsScaled) and (FHeight = 0) then
  begin
    FHeight := FOriginalHeight div FPixelHeight - Round(GetFooterHeight);
    GenerateLM(Text, False);
  end;
  ext := FHeight * FPixelHeight + FQuietZone * 2;
  if FShowText then
    ext := ext - FBarcodeText.TextSettings.Font.Height - FBarcodeText.TextSettings.Font.Height div 4;
  if (TextSup <> '') then
    ext := ext - FBarcodeText.SupSettings.Font.Height - FBarcodeText.SupSettings.Font.Height div 4;
  Result := Round(ext);
end;

destructor TfrxBarcode2DBase.Destroy;
begin
  FBarcodeText.Free;
  inherited;
end;

destructor TfrxBarcode2DBaseWithOutUnion.Destroy;
begin
  setlength(FImage, 0);
  inherited;
end;

procedure TfrxBarcode2DBaseWithOutUnion.InternalDraw(aCanvas: TCanvas; scalex,
  scaley: Extended; x, y, footerHeight, dx, dy, paddingX, paddingY: Integer; kx,
  ky: Extended);
var
  k, j, b, p: Integer;
  x1, y1, x2, y2: Integer;
begin
  inherited;

  for k := 0 to FHeight - 1 do
  begin
    p := k * ((FWidth + 7) div 8);
    for j := 0 to FWidth - 1 do
    begin
      b := FImage[p + (j div 8)] and $FF;
      b := b shl (j mod 8);

      if (b and $80) = 0 then
        continue;

      case round(Rotation) of
        90:
          begin
            x1 := round(x + k * PixelHeight * kx);
            x2 := round(x + k * PixelHeight * kx + PixelHeight * kx);
            y1 := round(y + dx - j * PixelWidth * ky);
            y2 := round(y + dx - j * PixelWidth * ky - PixelWidth * ky);
          end;
        180:
          begin
            x1 := round(x + dx - j * PixelWidth * kx);
            x2 := round(x + dx - j * PixelWidth * kx - PixelWidth * kx);
            y1 := round(y + footerHeight + dy - k * PixelHeight * ky);
            y2 := round(y + footerHeight + dy - k * PixelHeight * ky - PixelHeight * ky);
          end;
        270:
          begin
            x1 := round(x + footerHeight + dy - k * PixelHeight * kx);
            x2 := round(x + footerHeight + dy - k * PixelHeight * kx - PixelHeight * kx);
            y1 := round(y + j * PixelWidth * ky);
            y2 := round(y + j * PixelWidth * ky + PixelWidth * ky);
          end;
        else
          begin
            x1 := round(x + j * PixelWidth * kx);
            y1 := round(y + k * PixelHeight * ky);
            x2 := round(x + j * PixelWidth * kx + PixelWidth * kx);
            y2 := round(y + k * PixelHeight * ky + PixelHeight * ky);
          end;
      end;
    FillRect(aCanvas, Rect(x1 + paddingX, y1 + paddingY, x2 + paddingX, y2 + paddingY))
    end;
  end;
end;

destructor TfrxBarcode2DBaseWithUnion.Destroy;
begin
  ClearFigures();
  FVectorPrimitives.Destroy();
  inherited;
end;

procedure TfrxBarcode2DBaseWithUnion.ClearFigures();
var
  i: Integer;
begin
  for i := 0 to FVectorPrimitives.Count-1 do
    Dispose(PRect(FVectorPrimitives[i]));
  FVectorPrimitives.Clear();
end;

procedure TfrxBarcode2DBase.Draw2DBarcode(var g: TCanvas; scalex, scaley: Extended; x, y: Integer);
var
  kx, ky: Extended;
  footerHeight, dx, dy, paddingX, paddingY: Integer;
  vx, vy: Integer;
  vFont: TFont;
  TopText, BottomText: Boolean;
  OldStyle: TPenStyle;

  procedure BTextOut(str: String; x, y: Integer; Font: TFont);
  var
    F: TLogFont;
    FontHandle, OldFontHandle: HFont;
    koeff_for_font_height: Extended;
    textSemiLength, textLeftOffset, txtX, txtY: Integer;
    YDPI: Integer;
  begin
    g.Font.Assign(Font);
    GetObject(g.Font.Handle, SizeOf(TLogFont), @F);
    F.lfEscapement := round(Rotation * 10);
    F.lfOrientation := round(Rotation * 10);
    koeff_for_font_height := 1.0;
    if not (g is {$IFDEF LCLGTK2}TPrinterCanvas{$ELSE}TfrxPrinterCanvas{$ENDIF}) then
      koeff_for_font_height := scaley;
    {$IFDEF LCLGTK2}
    if g is TPrinterCanvas then
      YDPI := (g as TPrinterCanvas).YDPI
    else
    {$ENDIF}
     YDPI := GetDeviceCaps(g.Handle, LOGPIXELSY);
    if FontScaled then
      F.lfHeight := -round(MulDiv(Font.Size, YDPI, 72) * Zoom * koeff_for_font_height)
    else
      F.lfHeight := -round(MulDiv(Font.Size, YDPI, 72) * koeff_for_font_height);
    FontHandle := CreateFontIndirect(F);
    OldFontHandle := SelectObject(g.Handle, FontHandle);
    g.Font.Handle := FontHandle;
    g.Brush.Color := Color;
    frxSetBkMode(g, Transparent);
    {$IFDEF LCLGTK2}
    if g is TPrinterCanvas then
     g.Font.Height := -round(MulDiv(Font.Size, YDPI, 72) * koeff_for_font_height);
    {$ENDIF}

    textSemiLength := g.TextWidth(str) div 2;
    footerHeight := -g.Font.Height div 4 - g.Font.Height;

    textLeftOffset := dx div 2 - textSemiLength;
    if textLeftOffset < 0 then
      textLeftOffset := 0;

    txtX := 0;
    txtY := 0;

    case round(Rotation) of
      0:
        begin
          txtX := textLeftOffset;
          txtY := dy
        end;
      90:
        begin
          txtX := dy;
          txtY := dx - textLeftOffset;
        end;
      180:
        begin
          txtX := dx - textLeftOffset;
          txtY := footerHeight;
        end;
      270:
        begin
          txtX := footerHeight;
          txtY := textLeftOffset;
        end;
    end;
    inc(txtX, x);
    inc(txtY, y);

    g.TextOut(txtX + paddingX, txtY + paddingY, str);
    SelectObject(g.Handle, OldFontHandle);
    {$IFNDEF FPC}
    DeleteObject(FontHandle);
    {$ENDIF}
  end;

begin
  Color := Color;
  kx := scalex * Zoom;
  ky := scaley * Zoom;
  footerHeight := 0;
  if IsScaled then
  begin
    FHeight := 0;
    GetHeight;
  end;
  dy := round(FHeight * PixelHeight * ky);
  dx := round(FWidth * PixelWidth * kx);
  paddingX := round(FQuietZone * kx);
  paddingY := round(FQuietZone * ky);

  if ShowText then
  begin
    TopText := (FBarcodeText.TextSettings.BarTextPos = btpTop) or ((FBarcodeText.SupSettings.BarTextPos = btpTop) and (FTextSup <> ''));
    BottomText := (FBarcodeText.TextSettings.BarTextPos = btpBottom) or ((FBarcodeText.SupSettings.BarTextPos = btpBottom) and (FTextSup <> ''));

    vx := x;
    vy := y;

    if (TopText) then
    begin

      case (FRotation mod 360) of
        180, 270:
          if (FBarcodeText.TextSettings.BarTextPos = btpTop) then
            vFont := FBarcodeText.SupSettings.Font
          else
            vFont := FBarcodeText.TextSettings.Font;
        else
          if (FBarcodeText.TextSettings.BarTextPos = btpTop) then
            vFont := FBarcodeText.TextSettings.Font
          else
            vFont := FBarcodeText.SupSettings.Font;
      end;

      case FRotation of
        0  : vy := vy - dy;
        90 : vx := vx - dx;
        180: vy := vy + dy;
        270: vx := vx + dx;
      end;

      if (BottomText) then
      case FRotation of
        180: vy := vy - round((vFont.Height + vFont.Height div 4) * scaley * FZoom);
        270: vx := vx - round((vFont.Height + vFont.Height div 4) * scalex * FZoom);
      end;

      if (FBarcodeText.TextSettings.BarTextPos = btpTop) then
        BTextOut(FText, vx, vy, FBarcodeText.TextSettings.Font)
      else
        BTextOut(FTextSup, vx, vy, FBarcodeText.SupSettings.Font);

      case FRotation of
        0  : y := y - round((vFont.Height + vFont.Height div 4) * scaley * FZoom);
        90 : x := x - round((vFont.Height + vFont.Height div 4) * scalex * FZoom);
      end;
    end;

    if (BottomText) then
    begin
      if (FBarcodeText.TextSettings.BarTextPos = btpBottom) then
        BTextOut(FText, x, y, FBarcodeText.TextSettings.Font)
      else
        BTextOut(FTextSup, x, y, FBarcodeText.SupSettings.Font);
    end;

    if (TopText and not BottomText) then
      footerHeight := 0;
  end;

  g.Brush.Color := FColorBar;
  {$IFDEF RandVertCol}
  g.Pen.Width := 0; //Width = frame(ramka) in Polygon(...) where '0' = '1 pixel'...i don't understand
  {$ELSE}
  OldStyle := g.Pen.Style;
  g.Pen.Style := psClear;
  {$ENDIF}
  InternalDraw(g, scalex, scaley, x, y, footerHeight, dx, dy, paddingX, paddingY, kx, ky);
  {$IFNDEF RandVertCol}
  g.Pen.Style := OldStyle;
  {$ENDIF}
end;

procedure TfrxBarcode2DBase.FillRect(Canv: TCanvas; Rect: TRect);
begin
  Canv.Polygon([
             Point(Rect.Left , Rect.Top),
             Point(Rect.Left , Rect.Bottom),
             Point(Rect.Right, Rect.Bottom),
             Point(Rect.Right, Rect.Top)
             ]);
end;

end.
