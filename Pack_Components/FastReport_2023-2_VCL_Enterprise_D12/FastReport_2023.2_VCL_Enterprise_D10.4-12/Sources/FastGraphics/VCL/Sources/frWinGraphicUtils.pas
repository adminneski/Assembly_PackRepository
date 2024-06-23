
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frWinGraphicUtils;

{$I frVer.inc}

interface

uses
  SysUtils, Windows, Messages,
  Classes, Graphics, frBaseGraphicsTypes, frCore
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;
procedure frxApplyMask(MaskBM: TBitmap; SourceBM: TBitmap; MaskColor: TColor; InvertMask: Boolean = True);
function IsBlendingCompatibleDevice(aHandle: TfrHandle): Boolean;
procedure frxDrawGraphic(Canvas: TCanvas; DestRect: TRect; aGraph: TGraphic;
  IsPrinting, Smooth, Transparent: Boolean; TransparentColor: TColor; Alpha: TBitmap);

procedure frxDrawGraphicBlend(Canvas: TCanvas; Area: TRect; PF32: TBitmap; Quality: TfrxGraphicQuality);

implementation

function IsBlendingCompatibleDevice(aHandle: TfrHandle): Boolean;
begin
  if GetDeviceCaps(aHandle, TECHNOLOGY) = DT_RASPRINTER then
    Result := (GetDeviceCaps(aHandle, SHADEBLENDCAPS) <> SB_NONE) or (GetDeviceCaps(aHandle, BITSPIXEL) > 16)
  else
    Result := True;
end;

procedure frxDrawGraphicBlend(Canvas: TCanvas; Area: TRect; PF32: TBitmap; Quality: TfrxGraphicQuality);
const
  Bitmap32BF: TBlendFunction = ( BlendOp: AC_SRC_OVER; BlendFlags: 0;
    SourceConstantAlpha: 255; AlphaFormat: AC_SRC_ALPHA );
var
  oldBltMode: Integer;
begin
  oldBltMode := SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
  try
    AlphaBlend(Canvas.Handle, Area.Left, Area.Top, Area.Right - Area.Left,
      Area.Bottom - Area.Top, PF32.Canvas.Handle, 0, 0,
      PF32.Width, PF32.Height, Bitmap32BF);
  finally
    SetStretchBltMode(Canvas.Handle, oldBltMode);
  end;
end;

procedure PrintBitmap(aHandle: HDC; Dest: TRect; Bitmap: TBitmap);
var
  Info: PBitmapInfo;
  HInfo: HGLOBAL;
  InfoSize: DWord;
  Image: Pointer;
  HImage: HGLOBAL;
  ImageSize: DWord;
  PrevStretchBltMode: Integer;
begin
  {$IFDEF FPC}
  {$warning TODO fix frxUtils.PrintBitmap}
  {$ELSE}
  with Bitmap do
  begin
    GetDIBSizes(Handle, InfoSize, ImageSize);
    HInfo := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE, InfoSize);
    Info := PBitmapInfo(GlobalLock(HInfo));
    try
      HImage := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE, ImageSize);
      Image := Pointer(GlobalLock(HImage));
      try
        GetDIB(Handle, Palette, Info^, Image^);
        with Info^.bmiHeader do
        begin
          PrevStretchBltMode := SetStretchBltMode(aHandle, STRETCH_HALFTONE);
          StretchDIBits(aHandle, Dest.Left, Dest.Top,
            Dest.RIght - Dest.Left, Dest.Bottom - Dest.Top,
            0, 0, biWidth, biHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
          SetStretchBltMode(aHandle, PrevStretchBltMode);
        end;
      finally
        GlobalUnlock(HImage);
        GlobalFree(HImage);
      end;
    finally
      GlobalUnlock(HInfo);
      GlobalFree(HInfo);
    end;
  end;
  {$ENDIF}
end;

{ Draw with smooth }
{$IFDEF FPC}
procedure DrawBitmap(aHandle: HDC; Dest: TRect; Bitmap: TBitmap);
var
  PrevStretchBltMode: Integer;
begin
  try
    PrevStretchBltMode := SetStretchBltMode(aHandle, STRETCH_HALFTONE);
    with Dest do
      StretchBlt(aHandle, Left, Top, Right - Left, Bottom - Top, Bitmap.Canvas.GetUpdatedHandle([csHandleValid]),
            0, 0, Bitmap.Width, Bitmap.Height, SRCCOPY);

  finally
    SetStretchBltMode(aHandle, PrevStretchBltMode);
  end;
end;
{$ELSE}
procedure DrawBitmap(aHandle: HDC; Dest: TRect; Bitmap: TBitmap);
var
  hMemDC: HDC;
  PrevStretchBltMode: Integer;
  hBmp: HBITMAP;
begin
  hMemDC := CreateCompatibleDC(aHandle);
  hBmp := SelectObject(hMemDC, Bitmap.Handle);
  try
    PrevStretchBltMode := SetStretchBltMode(aHandle, STRETCH_HALFTONE);
    with Dest do
      StretchBlt(aHandle, Left, Top, Right - Left, Bottom - Top, hMemDC,
            0, 0, Bitmap.Width, Bitmap.Height, SRCCOPY);
    SetStretchBltMode(aHandle, PrevStretchBltMode);
  finally
    SelectObject(hMemDC, hBmp);
    DeleteDC(hMemDC);
  end;
end;
{$ENDIF}


procedure frxApplyMask(MaskBM: TBitmap; SourceBM: TBitmap; MaskColor: TColor; InvertMask: Boolean);
var
  hMaskDC, hStrechedDC, SourceMaskDC, DestDC: HDC;
  hMask, hStrechedBM: HBITMAP;
  oldFore, oldBack, oldBkColor: Cardinal;
  bltOp: Cardinal;
begin
  bltOp := SRCCOPY;
  if InvertMask then bltOp := NOTSRCCOPY;
  SourceMaskDC := CreateCompatibleDC(GetDC(0));
  SelectObject(SourceMaskDC, SourceBM.Handle);
  hMaskDC := CreateCompatibleDC(GetDC(0));
  hMask := CreateBitmap(MaskBM.Width, MaskBM.Height, 1, 1, nil);
  DestDC := CreateCompatibleDC(GetDC(0));
  SelectObject(DestDC, MaskBM.Handle);
  SelectObject(hMaskDC, hMask);
  try
    if (MaskBM.Width <> SourceBM.Width) or (MaskBM.Height <> SourceBM.Height) then
    begin
      hStrechedDC := CreateCompatibleDC(SourceMaskDC);
      hStrechedBM := CreateCompatibleBitmap(SourceMaskDC, SourceBM.Width, SourceBM.Height);
      try
        SetStretchBltMode(hStrechedDC, STRETCH_HALFTONE);
        SelectObject(hStrechedDC, hStrechedBM);
        StretchBlt(hStrechedDC, 0, 0, MaskBM.Width, MaskBM.Height, SourceMaskDC, 0, 0, SourceBM.Width, SourceBM.Height,  SRCCOPY);
        SetBkColor(hStrechedDC, ColorToRGB(MaskColor));
        BitBlt(hMaskDC, 0, 0, MaskBM.Width, MaskBM.Height, hStrechedDC, 0, 0,  bltOp);
      finally
        DeleteObject(hStrechedBM);
        DeleteDC(hStrechedDC);
      end;
    end
    else
    begin
      oldBkColor := SetBkColor(SourceMaskDC, ColorToRGB(MaskColor));
      BitBlt(hMaskDC, 0, 0, MaskBM.Width, MaskBM.Height, SourceMaskDC, 0, 0,  bltOp);
      SetBkColor(SourceMaskDC, oldBkColor);
    end;
    oldFore := SetTextColor(DestDC, 0);
    oldBack := SetBkColor(DestDC, RGB(255,255,255));
    BitBlt(DestDC, 0, 0, MaskBM.Width, MaskBM.Height, hMaskDC, 0, 0, SRCAND);
    SetTextColor(DestDC, oldFore);
    SetBkColor(DestDC, oldBack);
  finally
    DeleteDC(DestDC);
    DeleteDC(hMaskDC);
    DeleteDC(SourceMaskDC);
    DeleteObject(hMask);
  end;
end;

{ function create 2-bits mask from SourceDC with specify color value }
{ and draw it with White fill on DestDC                              }
procedure ApplyMask(DestDC: HDC; X, Y, Width, Height: Integer; SourceDC: HDC;
  SrcX, SrcY, SrcWidth, SrcHeight: Integer; MaskColor: TColor; AMask: TBitmap);
var
  hMaskDC, hStrechedDC, SourceMaskDC: HDC;
  hMask, hStrechedBM: HBITMAP;
  oldFore, oldBack, oldBkColor: Cardinal;
begin
  hMaskDC := CreateCompatibleDC(DestDC);
  hMask := CreateBitmap(Width, Height, 1, 1, nil);
  SelectObject(hMaskDC, hMask);
  SourceMaskDC := SourceDC;
  if Assigned(AMask) then
  begin
    SourceMaskDC := AMask.Canvas.Handle;
    MaskColor := clBlack;
  end;

  if (SrcWidth <> Width) or (SrcHeight <> Height) then
  begin
    hStrechedDC := CreateCompatibleDC(SourceMaskDC);
    hStrechedBM := CreateCompatibleBitmap(SourceMaskDC, Width, Height);
    try
      //SetStretchBltMode(hStrechedDC, STRETCH_HALFTONE);
      SelectObject(hStrechedDC, hStrechedBM);
      StretchBlt(hStrechedDC, 0, 0, Width, Height, SourceMaskDC, SrcX, SrcY, SrcWidth, SrcHeight,  SRCCOPY);
      SetBkColor(hStrechedDC, ColorToRGB(MaskColor));
      BitBlt(hMaskDC, 0, 0, Width, Height, hStrechedDC, 0, 0,  SRCCOPY);
    finally
      DeleteObject(hStrechedBM);
      DeleteDC(hStrechedDC);
    end;
  end
  else
  begin
    oldBkColor := SetBkColor(SourceMaskDC, ColorToRGB(MaskColor));
    BitBlt(hMaskDC, 0, 0, Width, Height, SourceMaskDC, 0, 0,  SRCCOPY);
    SetBkColor(SourceMaskDC, oldBkColor);
  end;
  try
    oldFore := SetTextColor(DestDC, 0);
    oldBack := SetBkColor(DestDC, RGB(255,255,255));
    BitBlt(DestDC, X, Y, Width, Height, hMaskDC, 0, 0, SRCAND);
    SetTextColor(DestDC, oldFore);
    SetBkColor(DestDC, oldBack);
  finally
    DeleteObject(hMask);
    DeleteDC(hMaskDC);
  end;
end;

{ Simple dither of one 8 bit chaenel, used to emulate translucent mask }
procedure frDither(AABitmap: TBitmap);
const
  ThresholdMap: array[0 .. 7, 0 .. 7] of Byte = (
    (10, 128, 32, 160, 8, 136, 40, 168),
    (192, 64, 224, 96, 200, 72, 232, 104),
    (48, 176, 16, 144, 56, 184, 24, 152),
    (240, 112, 208, 80, 248, 120, 216, 88),
		(12, 140, 44, 172, 4, 132, 36, 164),
    (204, 76, 236, 108, 196,  68, 228, 100),
		(60, 188, 28, 156, 52, 180, 20, 148),
    (252, 124, 220, 92, 244, 116, 212, 84));

var
  Alpha: Byte;
  AlphaScanline: PByteArray;
  y, x, LRow, LCol: Integer;
  ARow, ACol: array[0 .. 7] of Byte;
begin
  for y := 0 to AABitmap.Height - 1 do
  begin
    LRow := y mod 8;
    AlphaScanline := AABitmap.Scanline[y];
    ARow[LRow] := AlphaScanline[0];
    for x := 0 to AABitmap.Width - 1 do
    begin
      LCol := x mod 8;
      Alpha := AlphaScanline[x];
      ACol[LCol] := AlphaScanline[x];
      if Alpha < ThresholdMap[LCol][LRow] then
        AlphaScanline[x] := 0
      else
        AlphaScanline[x] := 255;
    end;
  end;
end;

{ function draws an image with transparent color, it has 2 mode: }
{ 1. Draws DIB directly on canvas, this used for printing.       }
{ Using memory DC could cause unexpected behaviour on printer    }
{ like color losing and etc (i.e. both StretchDIBits             }
{ with SRCINVERT should use printer DC).                         }
{ 2. Draw bitmap with using memory compatible DC,                }
{ it used for sreen draw.                                        }
{ TransparentBlt doesn't work with EMF,                          }
{ so it replaced  with 3 ROP's operation for correct export.     }
{$IFNDEF FPC}
procedure frxDrawTransparentBitmap(Canvas: TCanvas; DestRect: TRect; Bitmap: TBitmap; Alpha: TBitmap; TransparenColor: TColor; UseDIB: Boolean);
var
  hMemDC: HDC;
  rWidth, rHeight: Integer;
  Info, InfoA: PBitmapInfo;
  HInfo, HInfoA: HGLOBAL;
  Image, ImageA: Pointer;
  HImage, HImageA: HGLOBAL;

  StretchBltMode, PrevStretchBltMode, DIBColor: Integer;

  procedure CreateDIB(LBitmap: TBitmap; var LInfo: PBitmapInfo; var LHInfo: HGLOBAL; var LImage: Pointer; var LHImage: HGLOBAL);
  var
    InfoSize: DWord;
    ImageSize: DWord;
  begin
    begin
      GetDIBSizes(LBitmap.Handle, InfoSize, ImageSize);
      LHInfo := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE, InfoSize);
      LInfo := PBitmapInfo(GlobalLock(LHInfo));
      try
        LHImage := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE, ImageSize);
        LImage := Pointer(GlobalLock(LHImage));
        try
          GetDIB(LBitmap.Handle, LBitmap.Palette, LInfo^, LImage^);
        except
          GlobalUnlock(LHImage);
          GlobalFree(LHImage);
          LHImage := 0;
        end;
      except
        GlobalUnlock(LHInfo);
        GlobalFree(LHInfo);
        LHInfo := 0;
      end;
    end;
  end;

  procedure FreeDIB(LInfo: PBitmapInfo; LHInfo: HGLOBAL; LImage: Pointer; LHImage: HGLOBAL);
  begin
    if LHImage <> 0 then
    begin
      GlobalUnlock(LHImage);
      GlobalFree(LHImage);
    end;
    if LHInfo <> 0 then
    begin
      GlobalUnlock(LHInfo);
      GlobalFree(LHInfo);
    end;
  end;

  procedure DrawDIB(LInfo: PBitmapInfo; LImage: Pointer);
  begin
    with LInfo^.bmiHeader, DestRect do
    begin
      SetStretchBltMode(Canvas.Handle, StretchBltMode);
      if UseDIB then
        StretchDIBits(Canvas.Handle, Left, Top, rWidth, rHeight,
          0, 0, biWidth, biHeight, LImage, LInfo^, DIBColor, SRCINVERT)
      else
         StretchBlt(Canvas.Handle, Left, Top, rWidth, rHeight, hMemDC,
          0, 0, Bitmap.Width, Bitmap.Height, SRCINVERT);
    end;
  end;

begin
  StretchBltMode := STRETCH_HALFTONE;
  DIBColor := DIB_RGB_COLORS;
  rWidth := DestRect.Right - DestRect.Left;
  rHeight := DestRect.Bottom - DestRect.Top;
  Info := nil;
  case   Bitmap.PixelFormat of
    pf1bit: StretchBltMode := BLACKONWHITE;
    pf4bit..pf16bit: DIBColor := DIB_PAL_COLORS;
  end;
  if UseDIB then
    CreateDIB(Bitmap, Info, HInfo, Image, HImage);
  with  DestRect do
  begin
    PrevStretchBltMode := SetStretchBltMode(Canvas.Handle, StretchBltMode);
    try
      hMemDC := CreateCompatibleDC(Canvas.Handle);
      SelectObject(hMemDC, Bitmap.Handle);
      DrawDIB(Info, Image);
      if Assigned(Alpha) then
      begin
        CreateDIB(Alpha, InfoA, HInfoA, ImageA, HImageA);
        try
          StretchDIBits(Canvas.Handle, Left, Top, rWidth, rHeight,
            0, 0, Alpha.Width, Alpha.Height, ImageA, InfoA^, DIBColor, SRCAND);
        finally
          FreeDIB(InfoA, HInfoA, ImageA, HImageA);
        end;
      end
      else
        ApplyMask(Canvas.Handle, Left, Top, rWidth, rHeight, hMemDC, 0, 0, Bitmap.Width, Bitmap.Height, TransparenColor, Alpha);
      DrawDIB(Info, Image);
  finally
      DeleteDC(hMemDC);
      SetStretchBltMode(Canvas.Handle, PrevStretchBltMode);
      if UseDIB then
        FreeDIB(Info, HInfo, Image, HImage);
    end;
  end;
end;
{$ENDIF}

{procedure frxDrawTransparentBitmap(Canvas: TCanvas; DestRect: TRect; Bitmap: TBitmap; TransparenColor: TColor);
begin
  with DestRect do
    TransparentBlt(Canvas.Handle, Left, Top, Right - Left, Bottom - Top,
      Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, ColorToRGB(TransparenColor));
end;}

{$IFDEF FPC}
procedure frxDrawGraphic(Canvas: TCanvas; DestRect: TRect; aGraph: TGraphic;
  IsPrinting, Smooth, Transparent: Boolean; TransparentColor: TColor);
var
  Bitmap: TBitmap;
begin
  if (aGraph is TMetaFile) or not IsPrinting then
    Canvas.StretchDraw(DestRect, aGraph)
  else
  begin
  {$IFDEF LCLGTK2}
  Canvas.StretchDraw(DestRect, aGraph);
  {$ELSE}
    Bitmap := TBitmap.Create;
    Bitmap.Canvas.Lock;
    try
      Bitmap.Width := aGraph.Width;
      Bitmap.Height := aGraph.Height;
      Bitmap.PixelFormat := pf32Bit;
      Bitmap.Canvas.Draw(0, 0, aGraph);
      DrawBitmap(Canvas.Handle, DestRect, Bitmap);
    finally
      Bitmap.Canvas.Unlock;
      Bitmap.Free;
    end;
    {$ENDIF}
  end;
end;
{$ELSE}
procedure frxDrawGraphic(Canvas: TCanvas; DestRect: TRect; aGraph: TGraphic;
  IsPrinting, Smooth, Transparent: Boolean; TransparentColor: TColor; Alpha: TBitmap);
var
  Bitmap, MaskBitmap, TempMaskBitmap: TBitmap;
  OldColor: TColor;
  bNeedMaskImage: Boolean;
begin
  Canvas.Brush.Color := clWhite;// reset brush style
  // metafile shold be printed here
  //Bitmaps and other non-transparet pictures draw here
  if (aGraph is TMetaFile) or
    (not IsPrinting and (not Transparent or (aGraph is TBitmap)) and
      not Smooth)  then
  begin
    //aGraph.Transparent := Transparent;
    if (aGraph is TBitmap) and Transparent then
      frxDrawTransparentBitmap(Canvas, DestRect, TBitmap(aGraph), Alpha,
        TransparentColor, False)
    else
      Canvas.StretchDraw(DestRect, aGraph);
  end
  // used for printing pictures and drawing transparent pictures like JPEG/PNG
  // for printiong use DIB, for drawing memory DC
  else
  begin
    Bitmap := TBitmap.Create;
    MaskBitmap := nil;
    TempMaskBitmap := nil;
    Bitmap.Canvas.Lock;
    bNeedMaskImage := not Assigned(Alpha) or (Alpha.PixelFormat <> pf1bit);
    try
      Bitmap.HandleType := bmDIB;
      if IsPrinting and not Transparent then
        Bitmap.PixelFormat := pf32Bit// for print output
      else
        Bitmap.PixelFormat := pf24Bit;//for screen
      Bitmap.Width := aGraph.Width;
      Bitmap.Height := aGraph.Height;

      if Transparent then
      begin
        OldColor := Bitmap.Canvas.Brush.Color;
        if Assigned(Alpha) and (TransparentColor = clNone) then
          Bitmap.Canvas.Brush.Color := clWhite
        else
          Bitmap.Canvas.Brush.Color := TransparentColor;
        Bitmap.Canvas.FillRect(Rect(0,0,Bitmap.Width, Bitmap.Height));
        Bitmap.Canvas.Brush.Color := OldColor;
      end;
      Bitmap.Canvas.Draw(0, 0, aGraph);
      // need a total refactoring and change of used API , lots of legacy code
      if Transparent and IsPrinting then
      begin
        if bNeedMaskImage then
        begin
          MaskBitmap := TBitmap.Create;
          MaskBitmap.HandleType := bmDIB;
          MaskBitmap.PixelFormat := pf1Bit;
          { we have translucent mask here, some printer doesn't support AlphaBlend }
          { so we have to emulate it with ternary operations and dithered mask }
          { create temporary bitmap using device context PPI and scale }
          { Stretch 8-bit translucent mask on new DIB }
          { Apply Dither to make 1-bit compatible mask }
          { copy to 1-bit surface }
          if Assigned(Alpha) then
          begin
            MaskBitmap.Width := DestRect.Right - DestRect.Left;
            MaskBitmap.Height := DestRect.Bottom - DestRect.Top;
            TempMaskBitmap := TBitmap.Create;
            TempMaskBitmap.PixelFormat := pf8Bit;
            TempMaskBitmap.Width := DestRect.Right - DestRect.Left;
            TempMaskBitmap.Height := DestRect.Bottom - DestRect.Top;
            TempMaskBitmap.HandleType := bmDIB;
            TempMaskBitmap.Canvas.Brush.Color := clWhite;//ColorToRGB(TransparentColor)
            TempMaskBitmap.Canvas.StretchDraw(Rect(0, 0, TempMaskBitmap.Width, TempMaskBitmap.Height), Alpha);
            frDither(TempMaskBitmap);
          end
          else
          begin
            MaskBitmap.Width := aGraph.Width;
            MaskBitmap.Height := aGraph.Height;
          end;
        end
        else
          MaskBitmap := Alpha;
        MaskBitmap.Canvas.Brush.Color := ColorToRGB(TransparentColor);
        if Assigned(Alpha) and bNeedMaskImage then
          frxApplyMask(MaskBitmap, TempMaskBitmap, ColorToRGB(clBlack), False)
        else
          frxApplyMask(MaskBitmap, Bitmap, ColorToRGB(TransparentColor), False);
      end;

      if Transparent{ and (TransparentColor <> clNone)} then
        frxDrawTransparentBitmap(Canvas, DestRect, Bitmap, MaskBitmap, TransparentColor, IsPrinting)
      else if IsPrinting then
        PrintBitmap(Canvas.Handle, DestRect, Bitmap)
      else
        DrawBitmap(Canvas.Handle, DestRect, Bitmap);
    finally
      Bitmap.Canvas.Unlock;
      Bitmap.Free;
      if bNeedMaskImage then
      begin
        MaskBitmap.Free;
        TempMaskBitmap.Free;
      end;
    end;
  end
end;
{$ENDIF}

end.
