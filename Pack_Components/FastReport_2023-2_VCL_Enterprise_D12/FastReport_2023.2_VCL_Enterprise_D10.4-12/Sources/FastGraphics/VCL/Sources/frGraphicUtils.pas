
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frGraphicUtils;
{$ENDIF}

interface

{$I frVer.inc}

uses
  Types, Graphics,
{$IFNDEF FPC}
  Windows,
{$ELSE}
  frLazGraphicClasses,
{$ENDIF}
  SysUtils;

type
{$IFNDEF FPC}
  /// <summary>
  ///   This class used to override standard behaviour of metafile draw
  ///   function. By default metafile size includes bottom and right bounds, so
  ///   the real size of metafile is increased by 1. Default draw function in
  ///   VCL tries to compensate it and decreases right and bottom bounds by 1
  ///   in draw method. This doesn't work because PlayEnhMetaFile stretches
  ///   output. As a result output may lose 1 pixel in width and that's very
  ///   critical for outputs like barcodes lines.
  /// </summary>
  TfrxMetafile = class(TMetafile)
  protected
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
  end;
{$ELSE}
  TfrxMetafile = class(TMetafile);
{$ENDIF}

implementation

{ TfrxMetafile }
{$IFNDEF FPC}
procedure TfrxMetafile.Draw(ACanvas: TCanvas; const Rect: TRect);
var
  MetaPal, OldPal: HPALETTE;
  R: TRect;
begin
  if Handle = 0 then Exit;
  MetaPal := Palette;
  OldPal := 0;
  if MetaPal <> 0 then
  begin
    OldPal := SelectPalette(ACanvas.Handle, MetaPal, True);
    RealizePalette(ACanvas.Handle);
  end;
  R := Rect;
  PlayEnhMetaFile(ACanvas.Handle, Handle, R);
  if MetaPal <> 0 then
    SelectPalette(ACanvas.Handle, OldPal, True);
end;
{$ENDIF}

end.
