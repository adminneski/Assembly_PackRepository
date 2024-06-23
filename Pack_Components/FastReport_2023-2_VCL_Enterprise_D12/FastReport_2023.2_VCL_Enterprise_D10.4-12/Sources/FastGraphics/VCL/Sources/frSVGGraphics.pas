
{******************************************}
{                                          }
{             FastReport VCL               }
{            Graphic routines              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGGraphics;

interface

{$I frVer.inc}

uses
  SysUtils, {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  Classes, Graphics, frPictureGraphics, frSVGGraphic;

const
  frxSVGFileFormat = 6;

implementation

type

  TfrxSVGGraphicFormat = class(TfrxCustomVectorGraphicFormat)
  protected
    class function GetCanvasHelperClass: TfrxGraphicCanvasHelperClass; override;
  public
    class function ConvertFrom(Graphic: TGraphic; DestPixelFormat: TPixelFormat; DestQuality: Integer = 100): TGraphic; override;
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; override;
    class procedure DrawExt(const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX: Double; ScaleY: Double); override;
    class function HasAlphaChanel(Graphic: TGraphic): Boolean; override;
    class function ScaleGraphicToNew(Graphic: TGraphic; NewWidth, NewHeight: Integer): TGraphic; override;
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicProps(Graphic: TGraphic): TfrxGraphicProps; override;
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function GetFormatCapabilities: TfrxGraphicFormatCaps; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
    class function IsTranslucent: Boolean; override;
    class function IsTextData(Graphic: TGraphic): Boolean; override;
    class function GetTextData(Graphic: TGraphic): string; override;
    class procedure SetTextData(Graphic: TGraphic; st: string); override;
    class function CreateFromText(st: string): TGraphic; override;
  end;

  TfrxSVGCanvasHelper = class(TfrxGraphicCanvasHelper)
  public
    procedure SwitchFullOpacity; override;
  end;


{ TfrxEMFGraphicFormat }

class function TfrxSVGGraphicFormat.GetGraphicConst: Integer;
begin
  Result := frxSVGFileFormat;
end;

class function TfrxSVGGraphicFormat.GetGraphicExt: String;
begin
  Result := '.svg';
end;

class function TfrxSVGGraphicFormat.GetGraphicMime: String;
begin
  Result := 'image/svg+xml';
end;

class function TfrxSVGGraphicFormat.GetGraphicName: String;
begin
  Result := 'SVG';
end;

class function TfrxSVGGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
begin
  Result := TfrxSVGGraphic.CanLoadFromStream(Stream);
end;

class function TfrxSVGGraphicFormat.IsTextData(Graphic: TGraphic): Boolean;
begin
  Result := True;
end;

class function TfrxSVGGraphicFormat.IsTranslucent: Boolean;
begin
  Result := True;
end;

class function TfrxSVGGraphicFormat.ScaleGraphicToNew(Graphic: TGraphic;
  NewWidth, NewHeight: Integer): TGraphic;
var
  GProps: TfrxGraphicProps;
begin
  GProps := GetGraphicProps(Graphic);
  Result := CreateNew(Graphic.Width, Graphic.Height, GProps.PixelFormat, GProps.Transparent, GProps.Quality);
  Result.Assign(Graphic);
end;

class procedure TfrxSVGGraphicFormat.SetTextData(Graphic: TGraphic; st: string);
begin
  if Graphic is TfrxSVGGraphic then
    TfrxSVGGraphic(Graphic).LoadFromText(st);
end;

type
  TfrxHackSVGGraphic = class(TfrxSVGGraphic);

class function TfrxSVGGraphicFormat.ConvertFrom(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat; DestQuality: Integer): TGraphic;
var
  GHelper: TfrxCustomGraphicFormatClass;
  Bitmap: TBitmap;
  SVG: TfrxSVGGraphic absolute Result;
begin
 Result := CreateNew(Graphic.Width, Graphic.Height, DestPixelFormat, True, DestQuality);
 if Graphic is TfrxSVGGraphic then
    Result.Assign(Graphic)
  else
  begin
    GHelper := GetGraphicFormats.FindByGraphic(TGraphicClass(Graphic.ClassType));
    if Assigned(GHelper) then
    begin
      Bitmap := TBitmap(GHelper.ConvertToBitmap(Graphic, pf32bit));
      Bitmap.Canvas.Lock;
      try
        TfrxHackSVGGraphic(SVG).Draw(Bitmap.Canvas, Rect(0, 0, SVG.Width, SVG.Height));
      finally
        Bitmap.Canvas.Unlock;
        Bitmap.Free;
      end;
    end;
  end;
end;

class function TfrxSVGGraphicFormat.CreateFromText(st: string): TGraphic;
begin
  Result := TfrxSVGGraphic.Create;
  TfrxSVGGraphic(Result).LoadFromText(st);
end;

class function TfrxSVGGraphicFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
begin
  Result := TfrxSVGGraphic.Create;
  Result.Width := Width;
  Result.Height := Height;
end;

class procedure TfrxSVGGraphicFormat.DrawExt(const GProps: TfrxDrawGraphicExt;
  Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX,
  ScaleY: Double);
begin
  if TfrxHackSVGGraphic(AGraphic).IsAutoSize then
    DoDrawExt(GProps, Canvas, AGraphic, Area, ScaleX, ScaleY)
  else
    inherited DrawExt(GProps, Canvas, AGraphic, Area, ScaleX, ScaleY);
end;

class function TfrxSVGGraphicFormat.GetCanvasHelperClass: TfrxGraphicCanvasHelperClass;
begin
  Result := TfrxSVGCanvasHelper;
end;

class function TfrxSVGGraphicFormat.GetFormatCapabilities: TfrxGraphicFormatCaps;
begin
  Result := inherited GetFormatCapabilities - [gcGetCanvas];
end;

class function TfrxSVGGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TfrxSVGGraphic;
end;

class function TfrxSVGGraphicFormat.GetGraphicProps(
  Graphic: TGraphic): TfrxGraphicProps;
var
  Metafile: TMetafile absolute Graphic;
begin
  Result.HasAlpha := True;
  Result.Transparent := True;
  Result.TransparentColor := clNone;
  Result.Quality := 100;
  Result.PixelFormat := pfDevice;
end;

class function TfrxSVGGraphicFormat.GetTextData(Graphic: TGraphic): string;
begin
  Result := '';
  if Graphic is TfrxSVGGraphic then
    Result := TfrxSVGGraphic(Graphic).Source
end;

class function TfrxSVGGraphicFormat.HasAlphaChanel(Graphic: TGraphic): Boolean;
begin
  Result := True;
end;

{ TfrxSVGCanvasHelper }

procedure TfrxSVGCanvasHelper.SwitchFullOpacity;
begin
  inherited;

  (CanvasGraphic as TfrxSVGGraphic).SwitchFullOpacity;
end;

initialization
  GetGraphicFormats.RegisterFormat(TfrxSVGGraphicFormat);

finalization
  GetGraphicFormats.UnregisterFormat(TfrxSVGGraphicFormat);

end.
