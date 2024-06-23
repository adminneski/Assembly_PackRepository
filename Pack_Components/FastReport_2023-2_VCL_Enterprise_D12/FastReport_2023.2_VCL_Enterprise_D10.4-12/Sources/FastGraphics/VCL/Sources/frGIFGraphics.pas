
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frGIFGraphics;

interface

{$I frVer.inc}

uses
  SysUtils, (* {$IFNDEF FPC}Windows, Messages,{$ENDIF}  *)
  Classes, Graphics, frPictureGraphics;

implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  Types, frGIFGraphic, frBaseGraphicsTypes;

const
  frxGIFFileFormat = 7;

type
  TfrxGIFGraphicFormat = class(TfrxCustomGraphicFormat)
  public
    class procedure Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; Quality: TfrxGraphicQuality); override;
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicMime: string; override;
    class function GetGraphicName: string; override;
    class function GetGraphicExt: string; override;
    class function GetGraphicConst: Integer; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
  end;

{ TfrxGIFGraphicFormat }

class procedure TfrxGIFGraphicFormat.Draw(Canvas: TCanvas; AGraphic: TGraphic;
  Area: TRect; Quality: TfrxGraphicQuality);
begin
  if TfrxGIFGraphic(AGraphic).IsTransparent then
    DrawTransparent(Canvas, AGraphic, Area, TfrxGIFGraphic(AGraphic).TransparentColor, Quality)
  else
    inherited Draw(Canvas, AGraphic, Area, Quality);
end;

class function TfrxGIFGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TfrxGIFGraphic;
end;

class function TfrxGIFGraphicFormat.GetGraphicConst: Integer;
begin
  Result := frxGIFFileFormat;
end;

class function TfrxGIFGraphicFormat.GetGraphicExt: string;
begin
  Result := '.gif';
end;

class function TfrxGIFGraphicFormat.GetGraphicMime: string;
begin
  Result := 'image/gif';
end;

class function TfrxGIFGraphicFormat.GetGraphicName: string;
begin
  Result := 'GIF';
end;

class function TfrxGIFGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
var
  GIFHeader: packed array[1..6] of AnsiChar;
  p: Int64;
begin
  Result := False;
  if (Stream.Size - Stream.Position) >= SizeOf(GIFHeader) then
  begin
    p := Stream.Position;
    Stream.Read(GIFHeader, 6);
    Stream.Position := p;
    Result := (UpCase(GIFHeader[1]) = 'G') and (UpCase(GIFHeader[2]) = 'I') and
      (UpCase(GIFHeader[3]) = 'F') and (GIFHeader[4] = '8') and
      (GIFHeader[5] in ['7', '9']) and (UpCase(GIFHeader[6]) = 'A');
  end;
end;

initialization
  GetGraphicFormats.RegisterFormat(TfrxGIFGraphicFormat);

finalization
  GetGraphicFormats.UnregisterFormat(TfrxGIFGraphicFormat);

end.
