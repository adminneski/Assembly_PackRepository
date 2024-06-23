
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frGraphics;
{$ENDIF}

interface

{$I frVer.inc}

uses
{$IFNDEF FMX}
  {$IFNDEF FPC}Windows, ImgList, {$ELSE} LResources, LCLProc, LCLType, {$ENDIF}
  Types, SysUtils, Classes, Controls, Graphics, Buttons, frCore, frCoreClasses;
{$ELSE}
  System.Types, System.UITypes, System.SysUtils, System.Classes, System.Contnrs,
  {$IFDEF DELPHI19} FMX.Graphics, {$ENDIF}
  FMX.Types, FMX.Controls, FMX.frCore, FMX.frCoreClasses;
{$ENDIF}

const
  DefaultPPI = 96;
  DefaultToolBarImageWidth = 16;
  DefaultToolBarImageHeight = 16;
  DefaultLargeImageWidth = 32;
  DefaultLargeImageHeight = 32;

type
  { TfrBitmap }

  TfrBitmap = class(TBitmap)
  public
    constructor CreateSize(const ASize: TSize); overload;
    constructor CreateSize(AWidth, AHeight: Integer); overload;
  end;

{$IFNDEF FMX}
  procedure frMakeDisabledImage(ABitmap: TBitmap);

  procedure frAssignImages(Bitmap: TBitmap; dx, dy: Integer;
    ImgList1: TImageList; ImgList2: TImageList = nil);

  procedure ScaleBitmap(aBitmap: TBitmap; aScreenPPI: Integer);
{$ENDIF}

implementation

{$IFNDEF FMX}
procedure frMakeDisabledImage(ABitmap: TBitmap);
var
  i, j: Integer;
  c: TColor;
  B, G, R: Integer;
begin
  for i := 0 to ABitmap.Width - 1 do
  for j := 0 to ABitmap.Height - 1 do
  begin
    c := ABitmap.Canvas.Pixels[i, j];
    r := c and $FF0000 div $10000;
    g := c and $FF00 div $100;
    b := c and $FF;
    c := (r + g + b) div 3;
    c := Round(c / 3);
    c := c + 150;
    if c > 255 then
      c := 255;
    ABitmap.Canvas.Pixels[i, j] := c * $10000 + c * $100 + c;
  end;
end;

procedure frAssignImages(Bitmap: TBitmap; dx, dy: Integer;
  ImgList1: TImageList; ImgList2: TImageList = nil);
var
  b: TfrBitmap;
  x, y: Integer;
  Done: Boolean;
begin
  b := TfrBitmap.CreateSize(dx, dy);
  try
    x := 0; y := 0;

    repeat
      b.Canvas.CopyRect(Rect(0, 0, dx, dy), Bitmap.Canvas, Rect(x, y, x + dx, y + dy));
      Done := y > Bitmap.Height;

      if not Done then
      begin
        ImgList1.AddMasked(b, b.TransparentColor);
        if ImgList2 <> nil then
        begin
          frMakeDisabledImage(b);
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

  finally
    b.Free;
  end;
end;

procedure ScaleBitmap(aBitmap: TBitmap; aScreenPPI: Integer);
var
  tempBitmap: TBitmap;
begin
  if aScreenPPI <= DefaultPPI then Exit;
  tempBitmap := TBitmap.Create;
  try
    tempBitmap.Width := Round(aBitmap.Width * aScreenPPI / DefaultPPI);
    tempBitmap.Height := Round(aBitmap.Height * aScreenPPI / DefaultPPI);
    tempBitmap.Canvas.StretchDraw(Rect(0, 0, tempBitmap.Width,
      tempBitmap.Height), aBitmap);
    aBitmap.Assign(tempBitmap);
  finally
    tempBitmap.Free;
  end;
end;

{$ENDIF}

{ TfrBitmap }

constructor TfrBitmap.CreateSize(const ASize: TSize);
begin
  CreateSize(ASize.cx, ASize.cy);
end;

constructor TfrBitmap.CreateSize(AWidth, AHeight: Integer);
begin
{$IFDEF FMX}
  inherited Create(AWidth, AHeight);
{$ELSE}
  inherited Create;
  Width := AWidth;
  Height := AHeight;
{$ENDIF}
end;

end.
