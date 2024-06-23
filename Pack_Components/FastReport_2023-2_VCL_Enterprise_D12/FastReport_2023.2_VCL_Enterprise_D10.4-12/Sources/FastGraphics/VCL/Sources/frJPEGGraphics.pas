
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frJPEGGraphics;

interface

{$I frVer.inc}

uses
  SysUtils, {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  Classes, Graphics, frPictureGraphics, frBaseGraphicsTypes;

const
  frxJPEGFileFormat = 4;

implementation

{$IFNDEF FPC}
uses jpeg;
{$ENDIF}

type
  TfrxJPEGPictureFormat = class(TfrxCustomGraphicFormat)
  private
{$IFNDEF FPC}
    class function GetJPEGPixelFormat(PixelFormat: TPixelFormat): TJPEGPixelFormat;
    class function GetBasePixelFormat(PixelFormat: TJPEGPixelFormat): TPixelFormat;
{$ELSE}
    class function GetJPEGPixelFormat(PixelFormat: TPixelFormat): TPixelFormat; inline;
    class function GetBasePixelFormat(PixelFormat: TPixelFormat): TPixelFormat; inline;
{$ENDIF}
  protected
    class function GetCanvasHelperClass: TfrxGraphicCanvasHelperClass; override;
  public
    class function ConvertFrom(Graphic: TGraphic; DestPixelFormat: TPixelFormat; DestQuality: Integer = 100): TGraphic; override;
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; override;
    class procedure Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; Quality: TfrxGraphicQuality); override;
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function GetFormatCapabilities: TfrxGraphicFormatCaps; override;
    class function GetGraphicProps(Graphic: TGraphic): TfrxGraphicProps; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
  end;

  TfrxJPEGCanvasHelper = class(TfrxGraphicCanvasHelper)
  private
    FBitmap: TBitmap;
  protected
    function GetCanvas: TCanvas; override;
  public
    procedure ReleaseCanvas; override;
  end;

{ TfrxJPEGPictureFormat }

class function TfrxJPEGPictureFormat.ConvertFrom(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat; DestQuality: Integer): TGraphic;
var
  Jpg: TJPEGImage absolute Result;
begin
  Result := CreateNew(0, 0, DestPixelFormat, False, DestQuality);
  try
    Jpg.Assign(Graphic);
  except
    on E: EConvertError do
    begin
      if DestPixelFormat = pf32bit then
        DestPixelFormat := pf24bit;
      Graphic := GetGraphicFormats.ConvertToBitmap(Graphic, DestPixelFormat);
      if Assigned(Graphic) then
      begin
        try
          Jpg.Assign(Graphic)
        finally
          Graphic.Free;
        end;
      end
      else
        raise;
    end;
  end;
end;

class function TfrxJPEGPictureFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
var
  jpg: TJPEGImage absolute Result;
  bmp: TBitmap;
begin
  Result := TJPEGImage.Create;
  jpg.PixelFormat := GetJPEGPixelFormat(PixelFormat);
  jpg.CompressionQuality := Quality;
  if (Width <> 0) and (Height <> 0) then
  begin
    bmp := TBitmap.Create;
    bmp.Width := Width;
    bmp.Height := Height;
    try
      Result.Assign(bmp);
    finally
      bmp.Free;
    end;
  end;
end;

type
  TAccessJPEGImage = class(TJPEGImage);

class procedure TfrxJPEGPictureFormat.Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect;
  Quality: TfrxGraphicQuality);
{$IFNDEF FPC}
var
  LBitmap: TBitmap;
begin
  // Issue #268
  // TJPEGImage draws via temporary bitmap and uses TBitmap.Draw
  // which uses StretchBlt and acquired context of memory bitmap but never lock it
  // so handle may be freed during FreeMemoryContexts when code used in a thread
  LBitmap := TAccessJPEGImage(AGraphic).Bitmap;
  if Assigned(LBitmap) then
    LBitmap.Canvas.Lock;
  try
    inherited Draw(Canvas, AGraphic, Area, Quality);
  finally
    if Assigned(LBitmap) then
      LBitmap.Canvas.Unlock;
  end;
end;
{$ELSE}
begin
  inherited Draw(Canvas, AGraphic, Area, Quality);
end;
{$ENDIF}

{$IFNDEF FPC}
class function TfrxJPEGPictureFormat.GetBasePixelFormat(
  PixelFormat: TJPEGPixelFormat): TPixelFormat;
begin
  case PixelFormat of
    jf8Bit: Result := pf8bit;
    else
      Result := pf24bit;
  end;
end;
{$ELSE}
class function TfrxJPEGPictureFormat.GetBasePixelFormat(
  PixelFormat: TPixelFormat): TPixelFormat;
begin
  Result := PixelFormat;
end;
{$ENDIF}

class function TfrxJPEGPictureFormat.GetCanvasHelperClass: TfrxGraphicCanvasHelperClass;
begin
  Result := TfrxJPEGCanvasHelper;
end;

class function TfrxJPEGPictureFormat.GetFormatCapabilities: TfrxGraphicFormatCaps;
begin
  Result := inherited GetFormatCapabilities + [gcGetCanvas, gcConvert, gcSaveTo];
end;

class function TfrxJPEGPictureFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TJPEGImage;
end;

class function TfrxJPEGPictureFormat.GetGraphicConst: Integer;
begin
  Result := frxJPEGFileFormat;
end;

class function TfrxJPEGPictureFormat.GetGraphicExt: String;
begin
  Result := '.jpg';
end;

class function TfrxJPEGPictureFormat.GetGraphicMime: String;
begin
  Result := 'image/jpeg';
end;

class function TfrxJPEGPictureFormat.GetGraphicName: String;
begin
  Result := 'JPG';
end;

class function TfrxJPEGPictureFormat.GetGraphicProps(
  Graphic: TGraphic): TfrxGraphicProps;
var
  JPG: TJPEGImage absolute Graphic;
begin
  Result.HasAlpha := False;
  Result.Transparent := JPG.Transparent;
  Result.TransparentColor := clNone;
  Result.Quality := JPG.CompressionQuality;
  Result.PixelFormat := GetBasePixelFormat(JPG.PixelFormat);
end;

{$IFNDEF FPC}
class function TfrxJPEGPictureFormat.GetJPEGPixelFormat(
  PixelFormat: TPixelFormat): TJPEGPixelFormat;
begin
  Result := jf24Bit;
  case PixelFormat of
    pf1bit .. pf8bit: Result := jf8Bit;
    pfDevice,
    pf15bit .. pfCustom: Result := jf24Bit;
  end;
end;
{$ELSE}
class function TfrxJPEGPictureFormat.GetJPEGPixelFormat(
  PixelFormat: TPixelFormat): TPixelFormat;
begin
  Result := PixelFormat;
end;
{$ENDIF}

class function TfrxJPEGPictureFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
var
  JPEGHeader: array[0..1] of Byte;
  pos: Integer;
begin
  Result := False;
  if (Stream.Size - Stream.Position) >= SizeOf(JPEGHeader) then
  begin
    pos := Stream.Position;
    Stream.ReadBuffer(JPEGHeader, SizeOf(JPEGHeader));
    Stream.Position := pos;
    if (JPEGHeader[0] = $FF) and (JPEGHeader[1] = $D8) then
      Result := True;
  end;
end;

{ TfrxJPEGCanvasHelper }

function TfrxJPEGCanvasHelper.GetCanvas: TCanvas;
begin
  if Assigned(FBitmap) then
    Result := FBitmap.Canvas
  else
  begin
    FBitmap := TBitmap.Create;
    FBitmap.Width := FGraphic.Width;
    FBitmap.Height := FGraphic.Height;
{$IFNDEF FPC}
    case TJPEGImage(FGraphic).PixelFormat of
      jf24Bit: FBitmap.PixelFormat := pf24bit;
      jf8Bit: FBitmap.PixelFormat := pf8bit;
    end;
{$ELSE}
    FBitmap.PixelFormat := TJPEGImage(FGraphic).PixelFormat;
{$ENDIF}
    FBitmap.Assign(FGraphic);
    Result := FBitmap.Canvas;
  end;
end;

procedure TfrxJPEGCanvasHelper.ReleaseCanvas;
begin
  inherited;
  if Assigned(FBitmap) then
  begin
    FGraphic.Assign(FBitmap);
    FreeAndNil(FBitmap);
  end;
end;

initialization
  GetGraphicFormats.RegisterFormat(TfrxJPEGPictureFormat);

finalization
  GetGraphicFormats.UnregisterFormat(TfrxJPEGPictureFormat);

end.
