
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frPNGGraphics;

interface

{$I frVer.inc}

uses
  SysUtils, {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  Classes, Graphics, frPictureGraphics, frBaseGraphicsTypes;

const
  frxPNGFileFormat = 5;

implementation

{$IFNDEF FPC}
  uses
    pngimage
 , frWinGraphicUtils;
{$ENDIF}

type
  TPNGObject = class(TPngImage);
{$IFDEF FPC}
  TPNGObject = class(TPortableNetworkGraphic);
{$ENDIF}
  THackGraphic = class(TGraphic);
  TfrxPNGGraphicFormat = class(TfrxFullAbilitiesGraphicFormat)
  private
    class function GetPNGPixelFormat(PixelFormat: TPixelFormat): Integer;
    class function GetPixelFormat(PNGFormat: Integer): TPixelFormat;
  protected
    class function GetCanvasHelperClass: TfrxGraphicCanvasHelperClass; override;
    class procedure AssignBitmapToAPNG(PNG: TPngObject; ABitmap: TBitmap);
    class procedure DoDrawExt(const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX: Double; ScaleY: Double); override;
  public
    class function ConvertToBitmap(Graphic: TGraphic; DestPixelFormat: TPixelFormat): TGraphic; override;
    class function ConvertFrom(Graphic: TGraphic; DestPixelFormat: TPixelFormat; DestQuality: Integer = 100): TGraphic; override;
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; override;
    class function CreateFromStream(const Stream: TStream): TGraphic; override;
    class procedure DrawTransparent(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; MaskColor: TColor; Quality: TfrxGraphicQuality); override;
    class procedure Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; Quality: TfrxGraphicQuality); override;
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function GetAlphaBitmap(Graphic: TGraphic): TBitmap; override;
    class function GetGraphicProps(Graphic: TGraphic): TfrxGraphicProps; override;
    class function HasAlphaChanel(Graphic: TGraphic): Boolean; override;
    class function HasMaskColor(Graphic: TGraphic): Boolean; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
    class function IsTranslucent: Boolean; override;
    class function LoadFromStream(const aPictire: TPicture; Stream: TStream): Boolean; override;
    class procedure SetTransparent(Graphic: TGraphic; Transparent: Boolean); override;
    class procedure SetTransparentColor(Graphic: TGraphic; Color: TColor); override;
    class function GetTransparentColor(Graphic: TGraphic): TColor; override;
  end;

  TfrxPNGCanvasHelper = class(TfrxGraphicCanvasHelper)
  private
    FBitmap: TBitmap;
  protected
    function GetCanvas: TCanvas; override;
    function GetCanvasGraphic: TGraphic; override;
  public
    procedure ReleaseCanvas; override;
  end;

{$IFNDEF FPC}

function PNGToPNGA(PNG: TPngObject): TPngObject;
var
  PNGA: TPngObject;
  tRNS: TChunktRNS;
  PLTE: TChunkPLTE;
  dst: pRGBLine;
  src, alpha: pngimage.pByteArray;
  X, Y: Integer;
  i: byte;
begin
  PNGA := TPngObject.CreateBlank(COLOR_RGBALPHA, 8, PNG.Width, PNG.Height);
  case PNG.Header.ColorType of
    COLOR_PALETTE:
      begin
        tRNS := PNG.Chunks.ItemFromClass(TChunktRNS) as TChunktRNS;
        PLTE := PNG.Chunks.ItemFromClass(TChunkPLTE) as TChunkPLTE;
        for Y := 0 to PNG.Height - 1 do
        begin
          dst := PNGA.Scanline[Y];
          src := PNG.Scanline[Y];
          alpha := PNGA.AlphaScanline[Y];
          for X := 0 to PNG.Width - 1 do
          begin
            case PNG.Header.BitDepth of
              8:
                i := src[X];
              2, 4:
                i := src[X div 2] shr ((1 - (X mod 2)) * 4) and $0F;
              1:
                i := src[X div 8] shr (7 - (X mod 8)) and 1;
            else
              raise Exception.Create('Unknown PNG BitDepth');
            end;
            dst[X].rgbtBlue := PLTE.Item[i].rgbBlue;
            dst[X].rgbtGreen := PLTE.Item[i].rgbGreen;
            dst[X].rgbtRed := PLTE.Item[i].rgbRed;
            if tRNS <> nil then
              alpha[X] := tRNS.PaletteValues[i]
            else
              alpha[X] := 255;
          end;
        end;
      end;

    COLOR_RGB, COLOR_GRAYSCALE:
      begin
        PNGA.Canvas.Lock;
        try
          BitBlt(PNGA.Canvas.Handle, 0, 0, PNGA.Width, PNGA.Height,
            PNG.Canvas.Handle, 0, 0, SRCCOPY);
        finally
          PNGA.Canvas.Unlock;
        end;
        for Y := 0 to PNG.Height - 1 do
          FillChar(PNGA.AlphaScanline[Y]^, PNG.Width, 255);
      end;

    COLOR_GRAYSCALEALPHA:
      begin
        PNGA.Canvas.Lock;
        try
          BitBlt(PNGA.Canvas.Handle, 0, 0, PNGA.Width, PNGA.Height,
            PNG.Canvas.Handle, 0, 0, SRCCOPY);
        finally
          PNGA.Canvas.Unlock;
        end;
        for Y := 0 to PNG.Height - 1 do
        begin
          src := PNG.AlphaScanline[Y];
          alpha := PNGA.AlphaScanline[Y];
          Move(src^, alpha^, PNG.Width);
        end;
      end;

  else
    PNGA.Assign(PNG);
  end;
  Result := PNGA;
end;

function Png32ToTransparentBitmap32(PNG: TPngObject): TBitmap;
var
  AlphaScanline: pngimage.pByteArray;
  Alpha: Byte;
  Dest: PByte;
  Source: PByte;
  y, x: Integer;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf32bit;
  Result.Width := PNG.Width;
  Result.Height := PNG.Height;
//  Bitmap.Canvas.Lock;
//  try
//    Bitmap.Canvas.Draw(0, 0, PNG);
//  finally
//    Bitmap.Canvas.Unlock;
//  end;
  for y := 0 to PNG.Height - 1 do
  begin
    AlphaScanline := PNG.AlphaScanline[y];
    Dest := Result.ScanLine[y];
    Source := PNG.Scanline[y];
    for x := 0 to PNG.Width - 1 do
    begin
      Alpha := AlphaScanline^[x];
      Dest^ := MulDiv(Source^, Alpha, 255); Inc(Dest); Inc(Source);
      Dest^ := MulDiv(Source^, Alpha, 255); Inc(Dest); Inc(Source);
      Dest^ := MulDiv(Source^, Alpha, 255); Inc(Dest); Inc(Source);
      Dest^ := Alpha;                     Inc(Dest);
    end;
  end;
end;


function IsCanPngToTransparentBitmap32(PNG: TPngObject; var ABitmap: TBitmap): Boolean;
var
  PNGA: TPngObject;
begin
  Result := PNG.TransparencyMode in [ptmBit, ptmPartial];
  if Result then
    if PNG.Header.ColorType = COLOR_RGBALPHA then
      ABitmap := Png32ToTransparentBitmap32(PNG)
    else
    begin
      PNGA := PNGToPNGA(PNG);
      ABitmap := Png32ToTransparentBitmap32(PNGA);
      PNGA.Free;
    end;
end;

const
  Bitmap32BF: TBlendFunction = ( BlendOp: AC_SRC_OVER; BlendFlags: 0;
    SourceConstantAlpha: 255; AlphaFormat: AC_SRC_ALPHA );
{$ENDIF}

{ TfrxPNGGraphicFormat }

class procedure TfrxPNGGraphicFormat.AssignBitmapToAPNG(PNG: TPngObject; ABitmap: TBitmap);
var
  SourceBM, DestPNG, AlphaPNG: PByte;
  y, x: Integer;
  S1, S2, S3, Alpha: Byte;
  Factor: Double;
begin
  for Y := 0 to ABitmap.Height - 1 do
  begin
    SourceBM := ABitmap.Scanline[Y];
    DestPNG := PNG.Scanline[Y];
    AlphaPNG := Pointer(PNG.AlphaScanline[Y]);
    for X := 0 to ABitmap.Width - 1 do
    begin
      S1 := SourceBM^; Inc(SourceBM);
      S2 := SourceBM^; Inc(SourceBM);
      S3 := SourceBM^; Inc(SourceBM);
      alpha := SourceBM^; Inc(SourceBM);

      if alpha > 0 then
        Factor := 255 / alpha
      else
        Factor := 0;

      DestPNG^ := Round(S1 * Factor); Inc(DestPNG);
      DestPNG^ := Round(S2 * Factor); Inc(DestPNG);
      DestPNG^ := Round(S3 * Factor); Inc(DestPNG);
      if AlphaPNG <> nil then
      begin
       AlphaPNG^ := alpha;
        Inc(AlphaPNG);
      end;
    end;
  end
end;

class function TfrxPNGGraphicFormat.ConvertFrom(Graphic: TGraphic; DestPixelFormat: TPixelFormat; DestQuality: Integer): TGraphic;
var
  Bitmap: TBitmap absolute Graphic;
  HasAlpha, NeedBitmap: Boolean;
begin
  if Graphic is GetGraphicClass then
  begin
    Result := CreateNew(Graphic.Width, Graphic.Height, DestPixelFormat, DestPixelFormat = pf32bit, DestQuality);
    Result.Assign(Graphic);
    Exit;
  end;
  NeedBitmap := not (Graphic is TBitmap);
  if NeedBitmap then
    Graphic := GetGraphicFormats.ConvertToBitmap(Graphic, DestPixelFormat);
  try
    HasAlpha := (DestPixelFormat = pf32bit) and (Bitmap.PixelFormat = pf32bit);
    Result := CreateNew(Bitmap.Width, Bitmap.Height, DestPixelFormat, HasAlpha, DestQuality);
    if HasAlpha then
      AssignBitmapToAPNG(TPngObject(Result), Bitmap)
    else Result.Assign(Graphic);
//    if not HasAlpha then
//      TPngObject(Result).TransparentColor := $FFFFFF;
  finally
    if NeedBitmap then Graphic.Free;
  end;
end;

class function TfrxPNGGraphicFormat.ConvertToBitmap(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat): TGraphic;
var
  PNGA: TPngObject absolute Graphic;
  ResBitmap: TBitmap absolute Result;
begin
  Result := nil;
  if (PNGA.TransparencyMode in [ptmBit, ptmPartial]) and (PNGA.Header.ColorType = COLOR_RGBALPHA) then
    ResBitmap := Png32ToTransparentBitmap32(PNGA);

  if Result = nil then
    Result := inherited ConvertToBitmap(Graphic, DestPixelFormat);
  { invert black transparent color of PNG image with alpha to white fill color }
  { used when convert PNG with alpha to non transcarent image like JPEG }
  if HasAlphaChanel(Graphic) and (DestPixelFormat <> pf32bit) then
  begin
      FreeAndNil(ResBitmap);
      ResBitmap := TBitmap.Create;
      ResBitmap.PixelFormat := DestPixelFormat;
      ResBitmap.Width := Graphic.Width;
      ResBitmap.Height := Graphic.Height;
      ResBitmap.Canvas.Lock;
      try
        ResBitmap.Canvas.Brush.Color := clBlack;
        ResBitmap.Canvas.Brush.Style := bsSolid;
        ResBitmap.Canvas.FillRect(Rect(0, 0, ResBitmap.Width, ResBitmap.Height));
        ResBitmap.Canvas.Draw(0, 0, Graphic);
      finally
        ResBitmap.Canvas.Unlock;
      end;
  end;

end;

class function TfrxPNGGraphicFormat.CreateFromStream(
  const Stream: TStream): TGraphic;
begin
  Result := inherited CreateFromStream(Stream);
  THackGraphic(Result).Changed(nil);
end;

class function TfrxPNGGraphicFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
begin
  Result := TPngObject.CreateBlank(GetPNGPixelFormat(PixelFormat), 8, Width, Height);
  if (PixelFormat = pf32bit) and Transparent then
    TPngObject(Result).CreateAlpha;
end;

class procedure TfrxPNGGraphicFormat.DoDrawExt(const GProps: TfrxDrawGraphicExt;
  Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX,
  ScaleY: Double);
begin
  { emulates old behavior dont use internal PNG flags to determinate transparency when fgdHiQuality is set #637599 }
  if (fgdHiQuality in GProps.DrawProps) and not((fgdTransparent in GProps.DrawProps) or (fgdDefaultMaskColor in GProps.DrawProps)) then
    inherited Draw(Canvas, AGraphic, Area, GProps.Quality)
  else
    inherited DoDrawExt(GProps, Canvas, AGraphic, Area, ScaleX, ScaleY);
end;

class procedure TfrxPNGGraphicFormat.Draw(Canvas: TCanvas; AGraphic: TGraphic;
  Area: TRect; Quality: TfrxGraphicQuality);
begin
{$IFNDEF FPC}
  if (Quality in [gqPrint, gqHiQuality]) and (TPngObject(AGraphic).TransparencyMode = ptmBit) then
    inherited DrawTransparent(Canvas, AGraphic, Area, TPngObject(AGraphic).TransparentColor, Quality)
  else if ((Quality in [gqPrint, gqHiQuality]) or (Canvas.ClassType = frxDefaultMetaCanvasClass)) and (HasAlphaChanel(AGraphic) or HasMaskColor(AGraphic)) then
    DrawTransparent(Canvas, AGraphic, Area, clNone, Quality)
  else
{$ENDIF}
    inherited Draw(Canvas, AGraphic, Area, Quality);
end;

class procedure TfrxPNGGraphicFormat.DrawTransparent(Canvas: TCanvas;
  AGraphic: TGraphic; Area: TRect; MaskColor: TColor;
  Quality: TfrxGraphicQuality);
var
  Bitmap: TBitmap;
  bAlphaBlend: LongBool;
  LGraphicFormat: TfrxCustomGraphicFormatClass;
begin
{$IFNDEF FPC}
  if (Quality = gqFast) and (Canvas.ClassType <> frxDefaultMetaCanvasClass) and (MaskColor = clNone) then
    Draw(Canvas, AGraphic, Area, Quality)// faster and bad smooth
  else if (MaskColor = clNone) and ((AGraphic is TPngObject){$IFDEF DELPHI12} or (AGraphic is TPngImage){$ENDIF}) and
     {IsBlendingCompatibleDevice(Canvas.Handle) and }IsCanPngToTransparentBitmap32(TPngObject(AGraphic), Bitmap) then
  begin
    bAlphaBlend := False;
    { print, metafile and HQ pnly}
    try
      if IsBlendingCompatibleDevice(Canvas.Handle) then
      begin

        Canvas.Lock;
        try
          SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
          bAlphaBlend := AlphaBlend(Canvas.Handle,
                 Area.Left, Area.Top,
                 Area.Right - Area.Left, Area.Bottom - Area.Top,
               Bitmap.Canvas.Handle,
                 0, 0,
                 AGraphic.Width, AGraphic.Height,
               Bitmap32BF);
        finally
          Canvas.Unlock;
        end;
      end;

     { blending does not supported by a device }
     { using SHADEBLENDCAPS with GetDeviceCaps returns incorrect information }
     { so we check for AlphaBlend result }
      if not bAlphaBlend then
      begin
         { print converted bitmap , because default PNG class has a blending bug }
         LGraphicFormat := GetGraphicFormats.FindByGraphic(TGraphicClass(Bitmap.ClassType));
         if Assigned(LGraphicFormat) then
         begin
           Bitmap.Transparent := True;
           LGraphicFormat.DrawTransparent(Canvas, Bitmap, Area, MaskColor, Quality);
         end
         else
           inherited DrawTransparent(Canvas, AGraphic, Area, MaskColor, Quality);
      end;
    finally
      Bitmap.Free;
    end;
  end
  else
{$ENDIF}
    inherited DrawTransparent(Canvas, AGraphic, Area, MaskColor, Quality);
end;

class function TfrxPNGGraphicFormat.GetAlphaBitmap(Graphic: TGraphic): TBitmap;
var
  PNGA: TPNGObject;
  i: Integer;
  AlphaBitmap: TBitmap absolute Result;
begin
  Result := nil;
  if not (Graphic is TPngObject)
{$IFDEF DELPHI12}
     and not (Graphic is TPngImage)
{$ENDIF}
  then Exit;

  PNGA := PNGToPNGA(TPngObject(Graphic));
  try
    Result := TBitmap.Create;
    AlphaBitmap.PixelFormat := pf8bit;
    AlphaBitmap.Width := PNGA.Width;
    AlphaBitmap.Height := PNGA.Height;
    for i := 0 to AlphaBitmap.Height - 1 do
      CopyMemory(AlphaBitmap.ScanLine[i], PNGA.AlphaScanline[i], AlphaBitmap.Width);
  finally
    PNGA.Free;
  end;
end;

class function TfrxPNGGraphicFormat.GetCanvasHelperClass: TfrxGraphicCanvasHelperClass;
begin
  Result := TfrxPNGCanvasHelper;
end;

class function TfrxPNGGraphicFormat.GetGraphicClass: TGraphicClass;
begin
{$IFDEF DELPHI12}
  Result := TPngImage;
{$ELSE}
  Result := TPngObject;
{$ENDIF}
end;

class function TfrxPNGGraphicFormat.GetGraphicConst: Integer;
begin
  Result := frxPNGFileFormat;
end;

class function TfrxPNGGraphicFormat.GetGraphicExt: String;
begin
  Result := '.png';
end;

class function TfrxPNGGraphicFormat.GetGraphicMime: String;
begin
  Result := 'image/png';
end;

class function TfrxPNGGraphicFormat.GetGraphicName: String;
begin
  Result := 'PNG';
end;

class function TfrxPNGGraphicFormat.GetGraphicProps(
  Graphic: TGraphic): TfrxGraphicProps;
var
  PNG: TPNGObject absolute Graphic;
begin
  Result.HasAlpha := HasAlphaChanel(Graphic);
  Result.Transparent := PNG.Transparent;
  Result.TransparentColor := PNG.TransparentColor;
  Result.Quality := 100;
  Result.PixelFormat := GetPixelFormat(PNG.Header.ColorType);
end;

class function TfrxPNGGraphicFormat.GetPixelFormat(
  PNGFormat: Integer): TPixelFormat;
begin
  Result := pf24bit;
  case PNGFormat of
    COLOR_GRAYSCALE: Result := pf4bit;
    COLOR_PALETTE: Result := pf8bit;
    COLOR_RGB: Result := pf24bit;
    COLOR_RGBALPHA: Result := pf32bit;
  end;
end;

class function TfrxPNGGraphicFormat.GetPNGPixelFormat(
  PixelFormat: TPixelFormat): Integer;
begin
  Result := COLOR_RGB;
  case PixelFormat of
    pf1bit .. pf4bit: Result := COLOR_GRAYSCALE;
    pf8bit: Result := COLOR_PALETTE;
    pfDevice, pfCustom,
    pf15bit .. pf24bit: Result := COLOR_RGB;
    pf32bit: Result := COLOR_RGBALPHA;
  end;
end;

class function TfrxPNGGraphicFormat.GetTransparentColor(
  Graphic: TGraphic): TColor;
begin
  Result := clNone;
  if (TPngObject(Graphic).AlphaScanline[0] = nil) and (TPngObject(Graphic).TransparencyMode = ptmBit) then
    Result := TPngObject(Graphic).TransparentColor;
end;

class function TfrxPNGGraphicFormat.HasAlphaChanel(Graphic: TGraphic): Boolean;
begin
  Result := ((Graphic is GetGraphicClass)) and (TPngObject(Graphic).TransparencyMode = ptmPartial);
end;

class function TfrxPNGGraphicFormat.HasMaskColor(Graphic: TGraphic): Boolean;
begin
  Result := ((Graphic is GetGraphicClass)) and (TPngObject(Graphic).TransparencyMode = ptmBit);
end;

class function TfrxPNGGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
const
  OriginalPngHeader: array[0..7] of AnsiChar = (#137, #80, #78, #71, #13, #10, #26, #10);
var
  PNGHeader: array[0..7] of AnsiChar;
  pos: Integer;
begin
  Result := False;
  if (Stream.Size - Stream.Position) >= SizeOf(PNGHeader) then
  begin
    pos := Stream.Position;
    Stream.ReadBuffer(PNGHeader, SizeOf(PNGHeader));
    Stream.Position := pos;
    if PNGHeader = OriginalPngHeader then
      Result := True;
  end;
end;

class function TfrxPNGGraphicFormat.IsTranslucent: Boolean;
begin
  Result := True;
end;

class function TfrxPNGGraphicFormat.LoadFromStream(const aPictire: TPicture;
  Stream: TStream): Boolean;
begin
  Result := inherited LoadFromStream(aPictire, Stream);
  THackGraphic(aPictire.Graphic).Changed(nil);
end;

class procedure TfrxPNGGraphicFormat.SetTransparent(Graphic: TGraphic;
  Transparent: Boolean);
begin
  TPngObject(Graphic).Transparent := Transparent;
end;

class procedure TfrxPNGGraphicFormat.SetTransparentColor(Graphic: TGraphic;
  Color: TColor);
begin
  if HasAlphaChanel(Graphic) then
    TPngObject(Graphic).RemoveTransparency;
  TPngObject(Graphic).TransparentColor := Color;
end;

{ TfrxPNGCanvasHelper }

function TfrxPNGCanvasHelper.GetCanvas: TCanvas;
begin
  if TfrxPNGGraphicFormat.HasAlphaChanel(FGraphic) = False then
    Result := TPngObject(FGraphic).Canvas
  else
  begin
    if FBitmap = nil then
      FBitmap := TBitmap(TfrxPNGGraphicFormat.ConvertToBitmap(FGraphic, pf32bit));
    Result := FBitmap.Canvas;
  end;
end;

function TfrxPNGCanvasHelper.GetCanvasGraphic: TGraphic;
begin
  Result := FBitmap;
end;

procedure TfrxPNGCanvasHelper.ReleaseCanvas;
begin
  if Assigned(FBitmap) then
  begin
    TfrxPNGGraphicFormat.AssignBitmapToAPNG(TPngObject(FGraphic), FBitmap);
    FreeAndNil(FBitmap);
  end;
  inherited;
end;

initialization
  TPicture.RegisterFileFormat('PNG_OLD', 'Portable Network Graphics', TPNGObject);
  GetGraphicFormats.RegisterFormat(TfrxPNGGraphicFormat);

finalization
  GetGraphicFormats.UnregisterFormat(TfrxPNGGraphicFormat);
  TPicture.UnregisterGraphicClass(TPNGObject);

end.
