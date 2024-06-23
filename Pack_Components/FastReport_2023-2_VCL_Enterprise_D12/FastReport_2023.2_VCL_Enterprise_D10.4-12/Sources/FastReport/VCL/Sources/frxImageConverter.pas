
{******************************************}
{                                          }
{             FastReport VCL               }
{             Image Converter              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$I frx.inc}

unit frxImageConverter;

interface

uses
  Graphics,
  Classes;

type
  TfrxPictureType = (gpPNG, gpBMP, gpJPG , gpGIF, gpEMF, gpWMF );

procedure SaveGraphicAs(Graphic: TGraphic; Stream: TStream; PicType: TfrxPictureType; Transparent: Boolean = False; TransparentColor: TColor = clNone); overload;
procedure SaveGraphicAs(Graphic: TGraphic; Path: string; PicType: TfrxPictureType); overload;

function GetPicFileExtension(PicType: TfrxPictureType): string;
function TypeToGraphicFormat(PicType: TfrxPictureType): String;

implementation

uses
  frPictureGraphics, GIF;

function TypeToGraphicFormat(PicType: TfrxPictureType): String;
begin
  case PicType of
    gpEMF: Result := 'FREMF';
    gpWMF: Result := 'WMF';
    gpBMP: Result := 'BMP';
    gpPNG: Result := 'PNG';
    gpJPG: Result := 'JPG';
    gpGIF: Result := 'JPG';
  end;
end;

function GetPicFileExtension(PicType: TfrxPictureType): string;
begin
  case PicType of
    gpPNG: Result := 'png';
    gpBMP: Result := 'bmp';
    gpJPG: Result := 'jpg';
    gpGIF: Result := 'gif';
    gpEMF: Result := 'emf';
    gpWMF: Result := 'wmf';
    else   Result := '';
  end;
end;

procedure SaveGraphicAs(Graphic: TGraphic; Path: string; PicType: TfrxPictureType);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(Path, fmCreate);

  try
    SaveGraphicAs(Graphic, Stream, PicType)
  finally
    Stream.Free
  end
end;

procedure SaveGraphicAs(Graphic: TGraphic; Stream: TStream; PicType: TfrxPictureType; Transparent: Boolean = False; TransparentColor: TColor = clNone);
var
  Format: String;
  DestG: TGraphic;
  PixF: TPixelFormat;
  GFormat: TfrxCustomGraphicFormatClass;
  LtColor: TColor;
  {$IFNDEF FPC}
  procedure SaveAsGIF;
  var
    Bitmap: TBitmap;
  begin
    Bitmap := TBitmap.Create;

    try
      Bitmap.Width := Graphic.Width;
      Bitmap.Height := Graphic.Height;
      Bitmap.Canvas.Lock;
      try
        Bitmap.Canvas.Draw(0, 0, Graphic);
      finally
        Bitmap.Canvas.Unlock;
      end;
      GIFSaveToStream(Stream, Bitmap);
    finally
      Bitmap.Free
    end
  end;
  {$ENDIF}

begin
  Format := 'BMP';
  case PicType of
    gpEMF: Format := 'FREMF';
    gpWMF: Format := 'WMF';
    gpBMP: Format := 'BMP';
    gpPNG: Format := 'PNG';
    gpJPG: Format := 'JPG';
    {$IFNDEF FPC}
    gpGIF: SaveAsGIF;
    {$ENDIF}
  end;
  if PicType <> gpGIF then
  begin
    PixF := pf24bit;

    GFormat := GetGraphicFormats.FindByName(Format, [gcConvert]);
    if Assigned(GFormat) then
    begin
      if (PicType = gpPNG) and (Transparent or GFormat.HasAlphaChanel(Graphic) or Graphic.Transparent or GFormat.HasMaskColor(Graphic)) then
        PixF := pf32bit;
      DestG := GFormat.ConvertFrom(Graphic, PixF, 100);
      //GetGraphicFormats.Convert(Graphic, Format, PixF, 100);
      if Assigned(DestG) then
        try
          LtColor := GFormat.GetTransparentColor(DestG);
          if LtColor <> clNone then
            TransparentColor := LtColor;
          if (TransparentColor = clNone) and GFormat.HasMaskColor(Graphic) then
            TransparentColor := GFormat.GetTransparentColor(Graphic);
          if TransparentColor <> clNone then
            GFormat.SetTransparentColor(DestG, TransparentColor);
          DestG.SaveToStream(Stream);
        finally
          DestG.Free;
        end
    end;
  end;
end;

end.
