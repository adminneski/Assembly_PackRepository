{
Version   11.9
Copyright (c) 1995-2008 by L. David Baldwin,
Copyright (c) 2008-2018 by HtmlViewer Team

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Note that the source modules HTMLGIF1.PAS and DITHERUNIT.PAS
are covered by separate copyright notices located in those modules.
}

{$I frxHTMLCons.inc}

unit frxHTMLImages;

interface

uses
  SysUtils, Classes,
{$ifdef LCL}
  LclIntf, IntfGraphics, FpImage, LclType, LResources, LMessages, frLazHTMLMisc,
{$else}
  Windows, Jpeg,
{$endif}
  Contnrs, Graphics,
  //Messages,
  //Variants,
  Types,
  Math,
  frxHTMLURLSubs,
  frxHTMLCaches,
  frxHTMLGlobals,
  frGif1,
  frGif2,
  frxHTMLStyleTypes,
{$ifdef Compiler20_Plus}
  PngImage,
{$endif}
  frBaseGraphicsTypes;

{$ifdef LCL}
{$else}
const
  DefaultBitmap = 1002;
  ErrBitmap = 1001;
  ErrBitmapMask = 1005;
{$endif}

type

//------------------------------------------------------------------------------
// TfrxHtImage is an image wrapper.
//------------------------------------------------------------------------------
// It is used in place of any bitmap / image type used in HtmlViewer < 11.
// Currently it supports ThtBitmap, (animated) TGifImage, TGpImage or ThtMetafile
// It replaces the unspecific TgpObject and TBitmapItem of the old image cache.
//------------------------------------------------------------------------------

  ThtImageTransparency = (itrNone, itrIntrinsic, itrLLCorner);

  //BG, 09.04.2011
  TfrxHtImage = class(ThtCachable)
  protected
    FIndex: Integer;
    FRefCount: Integer;
    FIsInternal: Boolean;
    function GetBitmap: TBitmap; virtual; abstract;
    function GetGraphic: TGraphic; virtual;
    function GetImageHeight: Integer; virtual; abstract;
    function GetImageWidth: Integer; virtual; abstract;
    function GetMask: TBitmap; virtual; abstract;

    function EnlargeBitmap(Bitmap: TBitmap; W, H: Integer): TBitmap; virtual;
    function EnlargeImage(W, H: Integer): TfrxHtImage; virtual;
    procedure DoBaseDraw(Canvas: TCanvas; X, Y, W, H: Integer; DrawProps: TfrxGraphicDrawProps; DrawQuality: TfrxGraphicQuality);
  public
    Transp: ThtImageTransparency; {identifies what the mask is for}
    constructor Create(Tr: ThtImageTransparency); overload;
    procedure AddRef;
    procedure ClearRef;
    function IsUsed: Boolean;
    procedure TileImage(PRec: PtPositionRec; DstW, DstH: Integer; var TiledImage: TfrxHtImage; var NoMask: Boolean); virtual;

    procedure Draw(Canvas: TCanvas; X, Y, W, H: Integer); virtual;
    procedure Print(Canvas: TCanvas; X, Y, W, H: Integer; BgColor: TColor); virtual;
    procedure DrawTiled(Canvas: TCanvas; XStart, YStart, XEnd, YEnd, W, H: Integer); virtual;
    // used to draw/print background images.
    // BG, 06.09.2015: Currently only TfrxHtBitmapImage and TfrxHtGdipImage implement these methods.
    procedure DrawUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean); virtual;
    procedure PrintUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean); virtual;
    procedure SaveToStream(Stream: TStream); virtual;

    property Bitmap: TBitmap read GetBitmap;
    property Mask: TBitmap read GetMask;
    property Graphic: TGraphic read GetGraphic;
    property Height: Integer read GetImageHeight;
    property Width: Integer read GetImageWidth;
    property Index: Integer read FIndex write FIndex;
    property IsInternal: Boolean read FIsInternal write FIsInternal;
  end;

//------------------------------------------------------------------------------
// TfrxHtImageCache is the image cache, that holds the above image wrappers.
//------------------------------------------------------------------------------

  TfrxHtImageCache = class(ThtCache)
  private
    FOnCacheImageChanged: TNotifyEvent;
  {a list of image filenames and their ThtImages}
  public
    function AddObject(const S: ThtString; AObject: TfrxHtImage): Integer; reintroduce; {$ifdef UseInline} inline; {$endif}
    function AddNullCachedObject(const S: ThtString; CachedIndex: Integer): Integer; {$ifdef UseInline} inline; {$endif}
    function GetImage(I: Integer): TfrxHtImage; {$ifdef UseInline} inline; {$endif}
    function IsNeedExternalCacheUpdate(CacheType: TfrxCachedGraphicType): Boolean; {$ifdef UseInline} inline; {$endif}
    procedure ClearUnused; override;
    procedure Clear; override;
    procedure FillPictureCache(const PictureCache: IfrxPictureCache);
    procedure FillFromPictureCache(const PictureCache: IfrxPictureCache; CacheType: TfrxCachedGraphicType);

    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);

    procedure WriteIndexesToStream(Stream: TStream);
    procedure ReadIndexesFromStream(Stream: TStream);
    property OnCacheImageChanged: TNotifyEvent read FOnCacheImageChanged write FOnCacheImageChanged;
  end;

  //BG, 09.04.2011
  TfrxHtBitmapImage = class(TfrxHtImage)
  private
    Bitmap, Mask: TBitmap;
    OwnsBitmap, OwnsMask: Boolean;
  protected
    function GetBitmap: TBitmap; override;
    function GetImageHeight: Integer; override;
    function GetImageWidth: Integer; override;
    function GetMask: TBitmap; override;
  public
    constructor Create(AImage: TfrxHtBitmap; Tr: ThtImageTransparency; AOwnsBitmap: Boolean = True); overload;
    constructor Create(AImage, AMask: TBitmap; Tr: ThtImageTransparency; AOwnsBitmap: Boolean = True; AOwnsMask: Boolean = True); overload;
    constructor Create(AImage: TBitmap; Tr: ThtImageTransparency; Color: TColor; AOwnsBitmap: Boolean = True); overload;
    destructor Destroy; override;
    procedure Print(Canvas: TCanvas; X, Y, W, H: Integer; BgColor: TColor); override;
    procedure DrawUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean); override;
    procedure PrintUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean); override;
  end;

//------------------------------------------------------------------------------
// TfrxHtGraphicImage: support for all TGraphics without own TBitmap, e.g. meta files
//------------------------------------------------------------------------------

  //BG, 09.04.2011
  TfrxHtGraphicImage = class(TfrxHtImage)
  private
    FGraphic: TGraphic;
    FImage: TfrxHtBitmapImage;
    procedure Construct;
  protected
    function GetBitmap: TBitmap; override;
    function GetGraphic: TGraphic; override;
    function GetImageHeight: Integer; override;
    function GetImageWidth: Integer; override;
    function GetMask: TBitmap; override;
  public
    constructor Create(AGraphic: TGraphic); overload;
    destructor Destroy; override;
  end;


  TfrxCachedGraphicImage = class(TfrxHtGraphicImage)
  private
    FCachedGraphic: IfrxCachedGraphic;
    FCacheType: TfrxCachedGraphicType;
  protected
    function GetGraphic: TGraphic; override;
    function GetImageHeight: Integer; override;
    function GetImageWidth: Integer; override;
  public
    constructor Create(ACachedGraphic: IfrxCachedGraphic; CacheType: TfrxCachedGraphicType); overload;
    destructor Destroy; override;
    procedure SaveToStream(Stream: TStream); override;
  end;

//------------------------------------------------------------------------------
// TfrxHtImageLoader is the base class for image loaders, that the global function
// LoadImageFromStream() uses to load images of various kinds.
//
// HtmlViewer components use LoadImageFromStream() to load images.
//
// You may derive your own image loader from this class to support further
// image file formats. Your loader must load the images into a derivate of
// the TfrxHtImage declared above.
//------------------------------------------------------------------------------

type
  //BG, 24.08.2015:
  TfrxHtImageLoader = class
  public
    function LoadImageFromStream(Stream: TStream; Transparent: ThtImageTransparency): TfrxHtImage; virtual;
  end;

// LoadImageFromStream() tries to load an image from stream using the currently
// set global image loader.
//
// The HtmlViewer components use LoadImageFromStream() to load images from streams.
function LoadImageFromStream(Stream: TStream; Transparent: ThtImageTransparency): TfrxHtImage;

//------------------------------------------------------------------------------
// image methods
//------------------------------------------------------------------------------

function EnlargeImage(Image: TBitmap; W, H: Integer): TBitmap;

procedure PrintBitmap(Canvas: TCanvas; X, Y, W, H: Integer; Bitmap: TBitmap);
procedure PrintTransparentBitmap3(Canvas: TCanvas; X, Y, NewW, NewH: Integer; Bitmap, Mask: TBitmap; YI, HI: Integer);

procedure DrawBackground(ACanvas: TCanvas; ARect: TRect; XStart, YStart, XLast, YLast: Integer;
  Image: TfrxHtImage; BW, BH: Integer; BGColor: TColor);
{draw the background color and any tiled images on it}
{ARect, the cliprect, drawing outside this will not show but images may overhang
 XStart, YStart are first image position already calculated for the cliprect and parameters.
 XLast, YLast   Tiling stops here.
 BW, BH  bitmap dimensions.
}

//------------------------------------------------------------------------------

var
  DefBitMap, ErrorBitMap, ErrorBitmapMask: TBitMap;
  DefImage: TfrxHtBitmapImage;
  ErrorImage: TfrxHtBitmapImage;

implementation

uses
  frPictureGraphics, frGIFGraphic, frxHelpers;

var
  ImageLoader: TfrxHtImageLoader;

{----------------GetImageAndMaskFromStream}

function GetImageMask(Image: TBitmap; ColorValid: boolean; AColor: TColor): TBitmap;
begin
  Result := nil;
  try
    if ColorValid then
      Image.TransparentColor := AColor; {color has already been selected}
  {else the transparent color is the lower left pixel of the bitmap}

    Image.Transparent := True;

    Result := TBitmap.Create;
    Result.Handle := Image.ReleaseMaskHandle;
    Image.Transparent := False;
  except
    FreeAndNil(Result);
  end;
end;

//-- BG ---------------------------------------------------------- 24.08.2015 --
function LoadImageFromStream(Stream: TStream; Transparent: ThtImageTransparency): TfrxHtImage;
begin
  Result := ImageLoader.LoadImageFromStream(Stream, Transparent);
end;

//-- BG ---------------------------------------------------------- 26.09.2010 --
function TfrxHtImageLoader.LoadImageFromStream(Stream: TStream; Transparent: ThtImageTransparency): TfrxHtImage;
// extracted from TfrxHtDocument.GetTheBitmap(), TfrxHtDocument.InsertImage(), and TfrxHtDocument.ReplaceImage()

var
  GHelper: TfrxCustomGraphicFormatClass;
  LGraphic: TGraphic;

begin
  Result := nil;
  if not Assigned(Stream) then
    Exit;

  GHelper := GetGraphicFormats.FindByFormat(Stream, [gcLoadFrom, gcDraw, gcConvertToBitmap]);
  if GHelper <> nil then
  begin
    LGraphic := GHelper.CreateFromStream(Stream);
    try
      if Assigned(LGraphic) then
        Result := TfrxHtGraphicImage.Create(LGraphic);
    except
      LGraphic.Free;
      Result := nil;
    end;
  end;
end;

{----------------BitmapToRegion}

function BitmapToRegion(ABmp: TBitmap; XForm: PXForm; TransparentColor: TColor): HRGN;
{Find a Region corresponding to the non-transparent area of a bitmap.

 Thanks to Felipe Machado.  See http://www.DELPHI3000.com/
 Minor modifications made.}
const
  AllocUnit = 100;
type
  PRectArray = ^TRectArray;
  TRectArray = array[0..(MaxInt div SizeOf(TRect)) - 1] of TRect;
var
  pr: PRectArray; // used to access the rects array of RgnData by index
  h: HRGN; // Handles to regions
  RgnData: PRgnData; // Pointer to structure RGNDATA used to create regions
  lr, lg, lb: Byte; // values for lowest and hightest trans. colors
  x, y, x0: Integer; // coordinates of current rect of visible pixels
  maxRects: Cardinal; // Number of rects to realloc memory by chunks of AllocUnit
{$ifdef LCL}
  bmp: TLazIntfImage;
  b: TFpColor;
{$else}
  b: PByteArray; // used to easy the task of testing the byte pixels (R,G,B)
  ScanLinePtr: Pointer; // Pointer to current ScanLine being scanned
  ScanLineInc: Integer; // Offset to next bitmap scanline (can be negative)
  bmp: TBitmap;
{$endif}
begin
  Result := 0;
  lr := GetRValue(TransparentColor);
  lg := GetGValue(TransparentColor);
  lb := GetBValue(TransparentColor);
  { ensures that the pixel format is 32-bits per pixel }
{$ifdef LCL}
  bmp := TLazIntfImage.Create(0,0);
  try
    bmp.LoadFromBitmap(ABmp.Handle, 0);
    { alloc initial region data }
    maxRects := AllocUnit;
    GetMem(RgnData, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * maxRects));
    FillChar(RgnData^, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * maxRects), 0);
    try
      with RgnData^.rdh do
      begin
        dwSize := SizeOf(TRgnDataHeader);
        iType := RDH_RECTANGLES;
        nCount := 0;
        nRgnSize := 0;
        SetRect(rcBound, MAXLONG, MAXLONG, 0, 0);
      end;
      { scan each bitmap row - the orientation doesn't matter (Bottom-up or not) }
      for y := 0 to bmp.Height - 1 do
      begin
        x := 0;
        while x < bmp.Width do
        begin
          x0 := x;
          while x < bmp.Width do
          begin
            b := bmp[x,y];
            if (b.red = lr) and (b.green = lg) and (b.blue = lb) then
              Break; // pixel is transparent
            Inc(x);
          end;
          { test to see if we have a non-transparent area in the image }
          if x > x0 then
          begin
            { increase RgnData by AllocUnit rects if we exceeds maxRects }
            if RgnData^.rdh.nCount >= maxRects then
            begin
              Inc(maxRects, AllocUnit);
              ReallocMem(RgnData, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * MaxRects));
              pr := @RgnData^.Buffer;
              FillChar(pr^[maxRects - AllocUnit], AllocUnit * SizeOf(TRect), 0);
            end;
            { Add the rect (x0, y)-(x, y+1) as a new visible area in the region }
            pr := @RgnData^.Buffer; // Buffer is an array of rects
            with RgnData^.rdh do
            begin
              SetRect(pr[nCount], x0, y, x, y + 1);
              { adjust the bound rectangle of the region if we are "out-of-bounds" }
              if x0 < rcBound.Left then
                rcBound.Left := x0;
              if y < rcBound.Top then
                rcBound.Top := y;
              if x > rcBound.Right then
                rcBound.Right := x;
              if y + 1 > rcBound.Bottom then
                rcBound.Bottom := y + 1;
              Inc(nCount);
            end;
          end; // if x > x0
          { Need to create the region by muliple calls to ExtCreateRegion, 'cause }
          { it will fail on Windows 98 if the number of rectangles is too large   }
          if RgnData^.rdh.nCount = 2000 then
          begin
            h := ExtCreateRegion(XForm, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * maxRects), RgnData^);
            if Result > 0 then
            begin // Expand the current region
              CombineRgn(Result, Result, h, RGN_OR);
              DeleteObject(h);
            end
            else // First region, assign it to Result
              Result := h;
            RgnData^.rdh.nCount := 0;
            SetRect(RgnData^.rdh.rcBound, MAXLONG, MAXLONG, 0, 0);
          end;
          Inc(x);
        end; // scan every sample byte of the image
      end;
      { need to call ExCreateRegion one more time because we could have left    }
      { a RgnData with less than 2000 rects, so it wasn't yet created/combined  }
      if RgnData^.rdh.nCount > 0 then {LDB  0 Count causes exception and abort in Win98}
        h := ExtCreateRegion(XForm, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * MaxRects), RgnData^)
      else
        h := 0;
      if Result > 0 then
      begin
        CombineRgn(Result, Result, h, RGN_OR);
        DeleteObject(h);
      end
      else
        Result := h;
    finally
      FreeMem(RgnData, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * MaxRects));
    end;
  finally
    bmp.Free;
  end;
{$else}
  bmp := TBitmap.Create;
  try
    bmp.Assign(ABmp);
    bmp.PixelFormat := pf32bit;
    { alloc initial region data }
    maxRects := AllocUnit;
    GetMem(RgnData, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * maxRects));
    FillChar(RgnData^, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * maxRects), 0);
    try
      with RgnData^.rdh do
      begin
        dwSize := SizeOf(TRgnDataHeader);
        iType := RDH_RECTANGLES;
        nCount := 0;
        nRgnSize := 0;
        SetRect(rcBound, MAXLONG, MAXLONG, 0, 0);
      end;
      { scan each bitmap row - the orientation doesn't matter (Bottom-up or not) }
      ScanLinePtr := bmp.ScanLine[0];
      if bmp.Height > 1 then
        ScanLineInc := PtrSub(bmp.ScanLine[1], ScanLinePtr)
      else
        ScanLineInc := 0;
      for y := 0 to bmp.Height - 1 do
      begin
        x := 0;
        while x < bmp.Width do
        begin
          x0 := x;
          while x < bmp.Width do
          begin
            b := @PByteArray(ScanLinePtr)[x * SizeOf(TRGBQuad)];
            // BGR-RGB: Windows 32bpp BMPs are made of BGRa quads (not RGBa)
            if (b[2] = lr) and (b[1] = lg) and (b[0] = lb) then
              Break; // pixel is transparent
            Inc(x);
          end;
          { test to see if we have a non-transparent area in the image }
          if x > x0 then
          begin
            { increase RgnData by AllocUnit rects if we exceeds maxRects }
            if RgnData^.rdh.nCount >= maxRects then
            begin
              Inc(maxRects, AllocUnit);
              ReallocMem(RgnData, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * MaxRects));
              pr := @RgnData^.Buffer;
              FillChar(pr^[maxRects - AllocUnit], AllocUnit * SizeOf(TRect), 0);
            end;
            { Add the rect (x0, y)-(x, y+1) as a new visible area in the region }
            pr := @RgnData^.Buffer; // Buffer is an array of rects
            with RgnData^.rdh do
            begin
              SetRect(pr[nCount], x0, y, x, y + 1);
              { adjust the bound rectangle of the region if we are "out-of-bounds" }
              if x0 < rcBound.Left then
                rcBound.Left := x0;
              if y < rcBound.Top then
                rcBound.Top := y;
              if x > rcBound.Right then
                rcBound.Right := x;
              if y + 1 > rcBound.Bottom then
                rcBound.Bottom := y + 1;
              Inc(nCount);
            end;
          end; // if x > x0
          { Need to create the region by muliple calls to ExtCreateRegion, 'cause }
          { it will fail on Windows 98 if the number of rectangles is too large   }
          if RgnData^.rdh.nCount = 2000 then
          begin
            h := ExtCreateRegion(XForm, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * maxRects), RgnData^);
            if Result > 0 then
            begin // Expand the current region
              CombineRgn(Result, Result, h, RGN_OR);
              DeleteObject(h);
            end
            else // First region, assign it to Result
              Result := h;
            RgnData^.rdh.nCount := 0;
            SetRect(RgnData^.rdh.rcBound, MAXLONG, MAXLONG, 0, 0);
          end;
          Inc(x);
        end; // scan every sample byte of the image
        PtrInc(ScanLinePtr, ScanLineInc);
      end;
      { need to call ExCreateRegion one more time because we could have left    }
      { a RgnData with less than 2000 rects, so it wasn't yet created/combined  }
      if RgnData^.rdh.nCount > 0 then {LDB  0 Count causes exception and abort in Win98}
        h := ExtCreateRegion(XForm, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * MaxRects), RgnData^)
      else
        h := 0;
      if Result > 0 then
      begin
        CombineRgn(Result, Result, h, RGN_OR);
        DeleteObject(h);
      end
      else
        Result := h;
    finally
      FreeMem(RgnData, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * MaxRects));
    end;
  finally
    bmp.Free;
  end;
{$endif}
end;

{----------------DrawBackground}

procedure DrawBackground(ACanvas: TCanvas; ARect: TRect; XStart, YStart, XLast, YLast: Integer;
  Image: TfrxHtImage; BW, BH: Integer; BGColor: TColor);
{draw the background color and any tiled images on it}
{ARect, the cliprect, drawing outside this will not show but images may overhang
 XStart, YStart are first image position already calculated for the cliprect and parameters.
 XLast, YLast   Tiling stops here.
 BW, BH  bitmap dimensions.
}
var
  OldBrush: HBrush;
  OldPal: HPalette;
  DC: HDC;
  OldBack, OldFore: TColorRef;
begin
  DC := ACanvas.handle;
  if DC <> 0 then
  begin
    OldPal := SelectPalette(DC, ThePalette, False);
    RealizePalette(DC);
    ACanvas.Brush.Color :=BGColor;
    OldBrush := SelectObject(DC, ACanvas.Brush.Handle);
    OldBack := SetBkColor(DC, clWhite);
    OldFore := SetTextColor(DC, clBlack);
    try
      ACanvas.FillRect(ARect); {background color}
      if Image <> nil then {tile the animated gif}
        Image.DrawTiled(ACanvas, XStart, YStart, XLast, YLast, BW, BH);
    finally
      SelectObject(DC, OldBrush);
      SelectPalette(DC, OldPal, False);
      RealizePalette(DC);
      SetBkColor(DC, OldBack);
      SetTextColor(DC, OldFore);
    end;
  end;
end;

{ TgpObject }

function EnlargeImage(Image: TBitmap; W, H: Integer): TBitmap;
{enlarge 1 pixel images for tiling.  Returns a TBitmap regardless of Image type}
begin
  Result := TBitmap.Create;
  Result.Assign(Image);
  if Image.Width = 1 then
    Result.Width := Min(100, W)
  else
    Result.Width := Image.Width;
  if Image.Height = 1 then
    Result.Height := Min(100, H)
  else
    Result.Height := Image.Height;
  Result.Canvas.StretchDraw(Rect(0, 0, Result.Width, Result.Height), Image);
end;

{----------------PrintBitmap}

{$ifdef LCL}
{$else}
type
  ThtAllocRec = class(TObject)
  public
    Ptr: Pointer;
    ASize: Integer;
    AHandle: HGLOBAL;
  end;
{$endif}

procedure PrintBitmap(Canvas: TCanvas; X, Y, W, H: Integer; Bitmap: TBitmap);
{Y relative to top of display here}

{$ifdef LCL}
begin
  Canvas.StretchDraw(Rect(X, Y, X + W, Y + H), Bitmap);
end;
{$else}

  function Allocate(Size: Integer): ThtAllocRec;
  begin
    Result := ThtAllocRec.Create;
    with Result do
    begin
      ASize := Size;
      if Size < $FF00 then
        GetMem(Ptr, Size)
      else
      begin
        AHandle := GlobalAlloc(HeapAllocFlags, Size);
        if AHandle = 0 then
          Abort;
        Ptr := GlobalLock(AHandle);
      end;
    end;
  end;

  procedure DeAllocate(AR: ThtAllocRec);
  begin
    with AR do
      if ASize < $FF00 then
        Freemem(Ptr, ASize)
      else
      begin
        GlobalUnlock(AHandle);
        GlobalFree(AHandle);
      end;
    AR.Free;
  end;

var
  OldPal: HPalette;
  DC: HDC;
  Info: PBitmapInfo;
  Image: ThtAllocRec;
  ImageSize: DWord;
  InfoSize: DWord;

begin
  if (Bitmap = nil) or (Bitmap.Handle = 0) then
    Exit;
  DC := Canvas.Handle;
  try
    GetDIBSizes(Bitmap.Handle, InfoSize, ImageSize);
    GetMem(Info, InfoSize);
    try
      Image := Allocate(ImageSize);
      OldPal := SelectPalette(DC, ThePalette, False);
      try
        GetDIB(Bitmap.Handle, ThePalette, Info^, Image.Ptr^);
        RealizePalette(DC);
        with Info^.bmiHeader do
          StretchDIBits(DC, X, Y, W, H, 0, 0, biWidth, biHeight, Image.Ptr, Info^, DIB_RGB_COLORS, SRCCOPY);
      finally
        DeAllocate(Image);
        SelectPalette(DC, OldPal, False);
      end;
    finally
      FreeMem(Info, InfoSize);
    end;
  except
  end;
end;
{$endif}

{----------------PrintTransparentBitmap3}

procedure PrintTransparentBitmap3(Canvas: TCanvas; X, Y, NewW, NewH: Integer;
  Bitmap, Mask: TBitmap; YI, HI: Integer);
{Y relative to top of display here}
{This routine prints transparently on complex background by printing through a clip region}
{X, Y are point where upper left corner will be printed.
 NewW, NewH are the Width and Height of the output (possibly stretched)
 Vertically only a portion of the Bitmap, Mask may be printed starting at
   Y=YI in the bitmap and a height of HI
}
var
  DC: HDC;
  Rgn, OldRgn: HRGN;
  Rslt: Integer;
  XForm: TXForm;
  SizeV, SizeW: TSize;
  HF, VF: double;
  ABitmap, AMask: TBitmap;
  BitmapCopy: boolean;
  Origin: TPoint; //BG, 29.08.2009: window origin for correct mask translation
begin
{the following converts the black masked area in the image to white.  This may look
 better in WPTools which currently doesn't handle the masking}
  if (Bitmap.Handle = 0) or (HI <= 0) or (Bitmap.Width <= 0) then
    Exit;
  BitmapCopy := Bitmap.Height <> HI;
  try
    if BitmapCopy then
    begin
      ABitmap := TBitmap.Create;
      AMask := TBitmap.Create;
    end
    else
    begin
      ABitmap := Bitmap;
      AMask := Mask;
    end;
    try
      if BitmapCopy then
      begin
        Abitmap.Assign(Bitmap);
        ABitmap.Height := HI;
        BitBlt(ABitmap.Canvas.Handle, 0, 0, Bitmap.Width, HI, Bitmap.Canvas.Handle, 0, YI, SrcCopy);
        AMask.Assign(Mask);
        AMask.Height := HI;
        BitBlt(AMask.Canvas.Handle, 0, 0, AMask.Width, HI, Mask.Canvas.Handle, 0, YI, SrcCopy);
      end;

      SetBkColor(ABitmap.Canvas.Handle, clWhite);
      SetTextColor(ABitmap.Canvas.Handle, clBlack);
      BitBlt(ABitmap.Canvas.Handle, 0, 0, Bitmap.Width, HI, AMask.Canvas.Handle, 0, 0, SRCPAINT);

      DC := Canvas.Handle;
    {calculate a transform for the clip region as it may be a different size than
     the mask and needs to be positioned on the canvas.}
      GetViewportExtEx(DC, SizeV);
      GetWindowExtEx(DC, SizeW);
      GetWindowOrgEx(DC, Origin); //BG, 29.08.2009: get origin for correct mask translation

      HF := (SizeV.cx / SizeW.cx); {Horizontal adjustment factor}
      VF := (SizeV.cy / SizeW.cy); {Vertical adjustment factor}

      XForm.eM11 := HF * (NewW / Bitmap.Width);
      XForm.eM12 := 0;
      XForm.eM21 := 0;
      XForm.eM22 := VF * (NewH / HI);
      XForm.edx := HF * (X - Origin.X); //BG, 29.08.2009: subtract origin
      XForm.edy := VF * Y;

    {Find the region for the white area of the Mask}
      Rgn := BitmapToRegion(AMask, @XForm, $FFFFFF);
      if Rgn <> 0 then {else nothing to output--this would be unusual}
      begin
        OldRgn := CreateRectRgn(0, 0, 1, 1); {a valid region is needed for the next call}
        Rslt := GetClipRgn(DC, OldRgn); {save the Old clip region}
        try
          if Rslt = 1 then
            CombineRgn(Rgn, Rgn, OldRgn, RGN_AND);
          SelectClipRgn(DC, Rgn);
          PrintBitmap(Canvas, X, Y, NewW, NewH, ABitmap);
        finally
          if Rslt = 1 then
            SelectClipRgn(DC, OldRgn)
          else
            SelectClipRgn(DC, 0);
          DeleteObject(Rgn);
          DeleteObject(OldRgn);
        end;
      end;
    finally
      if BitmapCopy then
      begin
        ABitmap.Free;
        AMask.Free;
      end;
    end;
  except
  end;
end;

{ TfrxHtImage }

//-- BG ---------------------------------------------------------- 09.04.2011 --
procedure TfrxHtImage.AddRef;
begin
  Inc(FRefCount);
end;

procedure TfrxHtImage.ClearRef;
begin
  FRefCount := 0;
end;

constructor TfrxHtImage.Create(Tr: ThtImageTransparency);
begin
  inherited Create;
  Transp := Tr;
  FIndex := -1;
  FRefCount := 0;
end;

//-- BG ---------------------------------------------------------- 31.08.2015 --
procedure TfrxHtImage.DoBaseDraw(Canvas: TCanvas; X, Y, W, H: Integer;
  DrawProps: TfrxGraphicDrawProps; DrawQuality: TfrxGraphicQuality);
var
  GProps: TfrxDrawGraphicExt;
  GHelper: TfrxCustomGraphicFormatClass;
begin
  if Graphic = nil then Exit;
  GHelper := GetGraphicFormats.FindByGraphic(TGraphicClass(Graphic.ClassType));
  if GHelper = nil then Exit;
  GProps.Quality := DrawQuality;
  GProps.DrawProps := DrawProps;
  if GHelper.IsVector then
    Include(GProps.DrawProps, fgdKeepAspectRatio);
  GHelper.DrawExt(GProps, Canvas, Graphic, Rect(X, Y, X + W, Y + H), 1, 1);
end;

procedure TfrxHtImage.Draw(Canvas: TCanvas; X, Y, W, H: Integer);
begin
  DoBaseDraw(Canvas, X, Y, W, H, [fgdStretch, fgdDefaultMaskColor], gqDefault);
end;

//-- BG ---------------------------------------------------------- 06.09.2015 --
procedure TfrxHtImage.DrawUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean);
begin
  DoBaseDraw(Canvas, X, Y, W, H, [fgdDefaultMaskColor], gqDefault);
end;

//-- BG ---------------------------------------------------------- 06.09.2015 --
function TfrxHtImage.EnlargeBitmap(Bitmap: TBitmap; W, H: Integer): TBitmap;
{enlarge 1 pixel images for tiling.  Returns a TBitmap regardless of Image type}
begin
  if Bitmap = nil then
    Result := nil
  else
  begin
    Result := TfrxHtBitmap.Create;
    Result.Assign(Bitmap);
    if Result.Width = 1 then
      Result.Width := Min(100, W);
    if Result.Height = 1 then
      Result.Height := Min(100, H);
    Result.Canvas.StretchDraw(Rect(0, 0, Result.Width, Result.Height), Bitmap);
  end;
end;

//-- BG ---------------------------------------------------------- 06.09.2015 --
function TfrxHtImage.EnlargeImage(W, H: Integer): TfrxHtImage;
begin
  Result := TfrxHtBitmapImage.Create(
    EnlargeBitmap(Bitmap, W, H),
    EnlargeBitmap(Mask  , W, H), Transp);
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
procedure TfrxHtImage.DrawTiled(Canvas: TCanvas; XStart, YStart, XEnd, YEnd, W, H: Integer);
var
  X, Y: Integer;
begin
  Y := YStart;
  while Y < YEnd do
  begin
    X := XStart;
    while X < XEnd do
    begin
      Draw(Canvas, X, Y, W, H);
      Inc(X, W);
    end;
    Inc(Y, H);
  end;
end;

//-- BG ---------------------------------------------------------- 10.04.2011 --
function TfrxHtImage.GetGraphic: TGraphic;
begin
  Result := GetBitmap;
end;

function TfrxHtImage.IsUsed: Boolean;
begin
  Result := FRefCount > 0;
end;

//-- BG ---------------------------------------------------------- 31.08.2015 --
procedure TfrxHtImage.Print(Canvas: TCanvas; X, Y, W, H: Integer; BgColor: TColor);
begin
  DoBaseDraw(Canvas, X, Y, W, H, [fgdStretch], gqPrint);
end;

//-- BG ---------------------------------------------------------- 06.09.2015 --
procedure TfrxHtImage.PrintUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean);
begin
  DoBaseDraw(Canvas, X, Y, W, H, [fgdDefaultMaskColor], gqPrint);
end;

procedure TfrxHtImage.SaveToStream(Stream: TStream);
var
  LGraphic: TGraphic;
begin
  LGraphic := GetGraphic;
  if Assigned(LGraphic) then
    LGraphic.SaveToStream(Stream);
end;

//-- BG ---------------------------------------------------------- 06.09.2015 --
procedure TfrxHtImage.TileImage(PRec: PtPositionRec; DstW, DstH: Integer; var TiledImage: TfrxHtImage; var NoMask: Boolean);
{EnlargeImage returns a TfrxHtBitmapImage in TiledImage regardless of Self type.  Descendants may return other types}

  procedure Enlarge(W, H: Integer);
  var
    LargerImage: TfrxHtImage;
  begin
    LargerImage := EnlargeImage(W + 1, H + 1);
    try
      LargerImage.TileImage(PRec, DstW, DstH, TiledImage, NoMask);
    finally
      LargerImage.Free;
    end;
  end;

var
  OW, OH, IW, IH: Integer;
  X, XX, Y, X2, Y2: Integer;

  procedure ValidateTiledImage;
  var
    TiledBitmap, TiledMask: TBitmap;
  begin
    {TiledImage becomes a TfrxHtBitmapImage}
    if TiledImage = nil then
    begin
      TiledBitmap := TBitmap.Create;
      TiledBitmap.Palette := CopyPalette(ThePalette);
      TiledBitmap.Height := IH;
      TiledBitmap.Width := IW;
      PatBlt(TiledBitmap.Canvas.Handle, 0, 0, IW, IH, Blackness);

      if not NoMask then
      begin
        TiledMask := TBitmap.Create;
        TiledMask.Monochrome := True;
        TiledMask.Height := IH;
        TiledMask.Width := IW;
        if Mask = nil then
          PatBlt(TiledMask.Canvas.Handle, 0, 0, IW, IH, Whiteness);
      end
      else
        TiledMask := nil;

      TiledImage := TfrxHtBitmapImage.Create(TiledBitmap, TiledMask, Transp);
    end;
  end;

  procedure Tile(W, H: Integer);
  begin

    repeat {tile BGImage in the various dc's}
      XX := X;
      repeat
        TiledImage.Bitmap.Canvas.Draw(XX, Y, Bitmap);
        if Mask <> nil then
          TiledImage.Mask.Canvas.Draw(XX, Y, Mask)
        else if not NoMask then
          PatBlt(TiledImage.Mask.Canvas.Handle, XX, Y, Bitmap.Width, Bitmap.Height, Blackness);
        Inc(XX, Bitmap.Width);
      until XX >= X2;
      Inc(Y, Bitmap.Height);
    until Y >= Y2;
  end;

begin
  IW := DstW;
  IH := DstH;
  OW := Width;
  OH := Height;

  if (IW = 0) or (IH = 0) then
  begin
    FreeAndNil(TiledImage);
    NoMask := True;
  end
  else if (OW = 1) or (OH = 1) then
  begin
    {in case a 1 pixel bitmap is being tiled}
    Enlarge(IW, IH);
  end
  else
  begin
    {compute the location and tiling of BGImage in the background}
    with PRec.X do
    begin
      X := GetPositionInRange(PosType, Value, IW - OW);
      AdjustForTiling(RepeatD, 0, IW, OW, X, X2);
    end;
    with PRec.Y do
    begin
      Y := GetPositionInRange(PosType, Value, IH - OH);
      AdjustForTiling(RepeatD, 0, IH, OH, Y, Y2);
    end;

    NoMask := not Assigned(Mask) and PRec.X.RepeatD and PRec.Y.RepeatD;

    ValidateTiledImage;
    Tile(OW, OH);
  end;
end;

{ TfrxHtBitmapImage }

//-- BG ---------------------------------------------------------- 29.09.2015 --
constructor TfrxHtBitmapImage.Create(AImage: TfrxHtBitmap; Tr: ThtImageTransparency; AOwnsBitmap: Boolean);
begin
  if AImage = nil then
    raise EInvalidImage.Create('TfrxHtBitmapImage requires an image');
  inherited Create(Tr);
  Bitmap := AImage;
  OwnsBitmap := AOwnsBitmap;
  Mask := AImage.BitmapMask;
  OwnsMask := False;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
constructor TfrxHtBitmapImage.Create(AImage, AMask: TBitmap; Tr: ThtImageTransparency; AOwnsBitmap, AOwnsMask: Boolean);
begin
  if AImage = nil then
    raise EInvalidImage.Create('TfrxHtBitmapImage requires an image');
  inherited Create(Tr);
  Bitmap := AImage;
  OwnsBitmap := AOwnsBitmap;
  Mask := AMask;
  OwnsMask := AOwnsMask;
end;

//-- BG ---------------------------------------------------------- 10.01.2015 --
constructor TfrxHtBitmapImage.Create(AImage: TBitmap; Tr: ThtImageTransparency; Color: TColor; AOwnsBitmap: Boolean);
begin
  if AImage = nil then
    raise EInvalidImage.Create('TfrxHtBitmapImage requires an image');
  inherited Create(Tr);
  Bitmap := AImage;
  OwnsBitmap := AOwnsBitmap;
  case Transp of
    itrIntrinsic:  Mask := GetImageMask(Bitmap, True, Color);
    itrLLCorner:   Mask := GetImageMask(Bitmap, False, Color);
  end;
end;

destructor TfrxHtBitmapImage.Destroy;
begin
  if OwnsBitmap then
    Bitmap.Free;
  if OwnsMask then
    Mask.Free;
  inherited;
end;

//-- BG ---------------------------------------------------------- 06.09.2015 --
procedure TfrxHtBitmapImage.DrawUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean);
var
  FullBG: TBitmap;
begin
  if Bitmap = nil then
    Exit;
  if (Mask = nil) or (Transp = itrNone) then
    BitBlt(Canvas.Handle, X, Y, W, H, Bitmap.Canvas.Handle, SrcX, SrcY, SRCCOPY)
  else
  begin
    FullBG := nil;
    InitFullBG(FullBG, W, H, False);
    try
      if FillBackground then
      begin
        FullBG.Canvas.Brush := Canvas.Brush;
        FullBG.Canvas.FillRect( Rect(0, 0, W, H));
      end
      else
        BitBlt(FullBG.Canvas.Handle, 0, 0, W, H,        Canvas.Handle, X,    Y, SRCCOPY   );

      BitBlt(FullBG.Canvas.Handle, 0, 0, W, H, Bitmap.Canvas.Handle, 0, SrcY, SRCINVERT );
      BitBlt(FullBG.Canvas.Handle, 0, 0, W, H,   Mask.Canvas.Handle, 0, SrcY, SRCAND    );
      BitBlt(FullBG.Canvas.Handle, 0, 0, W, H, Bitmap.Canvas.Handle, 0, SrcY, SRCPAINT  );

      BitBlt(       Canvas.Handle, X, Y, W, H, FullBG.Canvas.Handle, 0,    0, SRCCOPY   );
    finally
      FullBG.Free;
    end;
  end;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtBitmapImage.GetBitmap: TBitmap;
begin
  Result := Bitmap;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtBitmapImage.GetImageHeight: Integer;
begin
  if Bitmap <> nil then
    Result := Bitmap.Height
  else
    Result := 0;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtBitmapImage.GetImageWidth: Integer;
begin
  if Bitmap <> nil then
    Result := Bitmap.Width
  else
    Result := 0;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtBitmapImage.GetMask: TBitmap;
begin
  Result := Mask;
end;

//-- BG ---------------------------------------------------------- 31.08.2015 --
procedure TfrxHtBitmapImage.Print(Canvas: TCanvas; X, Y, W, H: Integer; BgColor: TColor);
begin
  if Transp = itrNone then
    inherited
  else if Mask = nil then
    PrintBitmap(Canvas, X, Y, W, H, Bitmap)
  else
    PrintTransparentBitmap3(Canvas, X, Y, W, H, Bitmap, Mask, 0, Bitmap.Height);
end;

//-- BG ---------------------------------------------------------- 06.09.2015 --
procedure TfrxHtBitmapImage.PrintUnstretched(Canvas: TCanvas; X, Y, W, H, SrcX, SrcY: Integer; FillBackground: Boolean);
var
  FullBG: TBitmap;
begin
  if Bitmap = nil then
    Exit;
  if (Mask = nil) or (Transp = itrNone) then
    PrintBitmap(Canvas, X, Y, W, H, Bitmap)
  else if FillBackground then
  begin
    FullBG := nil;
    InitFullBG(FullBG, W, H, True);
    try
      FullBG.Canvas.Brush := Canvas.Brush;
      FullBG.Canvas.FillRect( Rect(0, 0, W, H));

      BitBlt(FullBG.Canvas.Handle, 0, 0, W, H, Bitmap.Canvas.Handle, 0, SrcY, SRCINVERT );
      BitBlt(FullBG.Canvas.Handle, 0, 0, W, H,   Mask.Canvas.Handle, 0, SrcY, SRCAND    );
      BitBlt(FullBG.Canvas.Handle, 0, 0, W, H, Bitmap.Canvas.Handle, 0, SrcY, SRCPAINT  );

      PrintBitmap(Canvas, X, Y, W, H, FullBG);
    finally
      FullBG.Free;
    end;
  end
  else
    PrintTransparentBitmap3(Canvas, X, Y, W, H, Bitmap, Mask, SrcY, H);
end;

{ TfrxHtGraphicImage }

//-- BG ---------------------------------------------------------- 09.04.2011 --
constructor TfrxHtGraphicImage.Create(AGraphic: TGraphic);
begin
  inherited Create(itrNone);
  FGraphic := AGraphic;
end;

//-- BG ---------------------------------------------------------- 10.04.2011 --
destructor TfrxHtGraphicImage.Destroy;
begin
  FImage.Free;
  FGraphic.Free;
  inherited;
end;

procedure TfrxHtGraphicImage.Construct;
var
  Tmp: TBitmap;
  pe: TPaletteEntry;
  Color: TColor;
  FBitmap: TBitmap;
begin
  if not Assigned(FImage) then
  begin
    FBitmap := TBitmap.Create;
    try
      FBitmap.Width := Width;
      FBitmap.Height := Height;
      PatBlt(FBitmap.Canvas.Handle, 0, 0, Width, Height, Blackness);
      FBitmap.Canvas.Draw(0, 0, Graphic);

      Tmp := TBitmap.Create;
      try
        Tmp.Width := Width;
        Tmp.Height := Height;
        Tmp.PixelFormat := pf8Bit;
      {pick an odd color from the palette to represent the background color,
       one not likely in the metafile}
        GetPaletteEntries(Tmp.Palette, 115, 1, pe);
        Color := pe.peBlue shl 16 or pe.peGreen shl 8 or pe.peRed;
        Tmp.Canvas.Brush.Color := Color;
        Tmp.Canvas.FillRect(Rect(0, 0, Width, Height));
        Tmp.Canvas.Draw(0, 0, Graphic);

        FImage := TfrxHtBitmapImage.Create(FBitmap, GetImageMask(Tmp, False, Color), itrLLCorner);
      finally
        Tmp.Free;
      end;
    except
      FreeAndNil(FBitmap);
    end;
  end;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtGraphicImage.GetBitmap: TBitmap;
begin
  Construct;
  Result := FImage.Bitmap;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtGraphicImage.GetGraphic: TGraphic;
begin
  Result := FGraphic;
end;

function TfrxHtGraphicImage.GetImageHeight: Integer;
begin
  Result := Graphic.Height;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtGraphicImage.GetImageWidth: Integer;
begin
  Result := Graphic.Width;
end;

//-- BG ---------------------------------------------------------- 09.04.2011 --
function TfrxHtGraphicImage.GetMask: TBitmap;
begin
  Construct;
  Result := FImage.Mask;
end;

{ TfrxHtImageCache }

//------------------------------------------------------------------------------
function TfrxHtImageCache.AddNullCachedObject(const S: ThtString; CachedIndex: Integer): Integer;
var
  Img: TfrxCachedGraphicImage;
begin
  Img := TfrxCachedGraphicImage.Create(nil, cgNone);
  Img.Index := CachedIndex;
  Result := AddObject(S, Img);
end;

function TfrxHtImageCache.AddObject(const S: ThtString; AObject: TfrxHtImage): Integer;
begin
  Result := inherited AddObject(S, AObject);
  if Assigned(FOnCacheImageChanged) then
    FOnCacheImageChanged(Self);
end;

procedure TfrxHtImageCache.Clear;
begin
  inherited;
  if Assigned(FOnCacheImageChanged) then
    FOnCacheImageChanged(Self);
end;

procedure TfrxHtImageCache.ClearUnused;
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if not GetImage(i).IsUsed then
    begin
      Objects[i].Free;
      Delete(i);
    end
    else
    begin
      GetImage(i).ClearRef;
      Inc(i);
    end;
  end;
end;


procedure TfrxHtImageCache.FillFromPictureCache(const PictureCache: IfrxPictureCache; CacheType: TfrxCachedGraphicType);
var
  i: Integer;
  Img: TfrxHtImage;
begin
  for i := 0 to Count - 1 do
  begin
    Img := GetImage(i);
    if Img is TfrxCachedGraphicImage then
    begin
      if PictureCache.IsAutoRefMode then
        TfrxCachedGraphicImage(img).FCachedGraphic := PictureCache.GetCachedBitmap(CacheType, Img.Index)
      else
        TfrxCachedGraphicImage(img).FGraphic := PictureCache.GetGraphic(Img.Index);
      TfrxCachedGraphicImage(img).FCacheType := CacheType;
    end;
  end;
end;

procedure TfrxHtImageCache.FillPictureCache(const PictureCache: IfrxPictureCache);
var
  i: Integer;
  Img: TfrxHtImage;
begin
  for i := 0 to Count - 1 do
  begin
    Img := GetImage(I);
    if Img.Index < 0 then
      Img.Index := PictureCache.AddPicture(Img.Graphic);
  end;
end;

//-- BG ---------------------------------------------------------- 11.04.2011 --

function TfrxHtImageCache.GetImage(I: Integer): TfrxHtImage;
begin
  Result := TfrxHtImage(inherited GetCachable(I));
end;

function TfrxHtImageCache.IsNeedExternalCacheUpdate(
  CacheType: TfrxCachedGraphicType): Boolean;
var
  i: Integer;
  img: TfrxHtImage;
begin
  Result := False;
  for i := 0 to Count - 1 do
  begin
    img := GetImage(i);
    if img is TfrxCachedGraphicImage then
      if TfrxCachedGraphicImage(img).FCacheType <> CacheType then
      begin
        Result := True;
        break;
      end;
  end;
end;

procedure TfrxHtImageCache.ReadFromStream(Stream: TStream);
var
  C, i: Integer;
  WS: WideString;
  HtImage: TfrxHtImage;
  StreamSize, StreamPos: Int64;
begin
  Clear;
  Stream.ReadBuffer(C, SizeOf(C));
  StreamSize := 0;

  for i := 0 to C - 1 do
  begin
    WS := ReadWideStringFromStream(Stream);
    Stream.ReadBuffer(StreamSize, SizeOf(StreamSize));
    StreamPos := Stream.Position;
    HtImage := LoadImageFromStream(Stream, itrNone);
    Stream.Position := StreamPos + StreamSize;
    AddObject(WS, HtImage);
  end;
end;

procedure TfrxHtImageCache.ReadIndexesFromStream(Stream: TStream);
var
  Cnt, i, Index: Integer;
  WS: WideString;
begin
  Clear;
  Stream.ReadBuffer(Cnt, SizeOf(Cnt));
  for i := 0 to Cnt - 1 do
  begin
    WS := ReadWideStringFromStream(Stream);
    Stream.Read(Index, Sizeof(Index));
    AddNullCachedObject(WS, Index);
  end;
end;

procedure TfrxHtImageCache.WriteIndexesToStream(Stream: TStream);
var
  Cnt, i, Index: Integer;
  WS: WideString;
begin
  Cnt := Count;
  Stream.WriteBuffer(Cnt, SizeOf(Cnt));
  for i := 0 to Cnt - 1 do
  begin
    WS := Strings[i];
    WriteWideStringToStream(Stream, WS);
    Index := GetImage(I).Index;
    Stream.Write(Index, SizeOf(Index));
  end;
end;


procedure TfrxHtImageCache.WriteToStream(Stream: TStream);
var
  C, i: Integer;
  WS: WideString;
  StreamPos, StreamSize: Int64;
begin
  C := 0;
  Stream.WriteBuffer(C, SizeOf(C));

  for i := 0 to Count - 1 do
  begin
    if (Objects[i] is TfrxCachedGraphicImage) or TfrxHtImage(Objects[i]).IsInternal or not Assigned(TfrxHtGraphicImage(Objects[i]).Graphic) then
      Continue;
    WS := Strings[i];
    WriteWideStringToStream(Stream, WS);
    StreamPos := Stream.Position;
    StreamSize := 0;
    Stream.WriteBuffer(StreamSize, SizeOf(StreamSize));
    TfrxHtGraphicImage(Objects[i]).SaveToStream(Stream);
    StreamSize := Stream.Position - (StreamPos + SizeOf(StreamSize));
    Stream.Position := StreamPos;
    Stream.WriteBuffer(StreamSize, SizeOf(StreamSize));
    Stream.Seek(0, soEnd);
    Inc(C);
  end;

  Stream.Position := 0;
  Stream.WriteBuffer(C, SizeOf(C));
end;

{ TfrxCachedGraphicImage }

constructor TfrxCachedGraphicImage.Create(ACachedGraphic: IfrxCachedGraphic;
  CacheType: TfrxCachedGraphicType);
var
  LGraphic: TGraphic;
begin
  LGraphic := nil;
  if Assigned(ACachedGraphic) then
  begin
    LGraphic := ACachedGraphic.GetGraphic(CacheType);
    FCachedGraphic := ACachedGraphic;
  end;
  inherited Create(LGraphic);
end;

destructor TfrxCachedGraphicImage.Destroy;
begin
  FCachedGraphic := nil;
  inherited;
end;

function TfrxCachedGraphicImage.GetGraphic: TGraphic;
begin
  if Assigned(FCachedGraphic) then
    Result := FCachedGraphic.GetGraphic(FCacheType)
  else
    Result := FGraphic;
end;

function TfrxCachedGraphicImage.GetImageHeight: Integer;
begin
  Result := -1;
  if Assigned(FCachedGraphic) then
    Result := FCachedGraphic.GetOriginalSize.cy;
  if Result <=0 then
    Result := GetGraphic.Height;
end;

function TfrxCachedGraphicImage.GetImageWidth: Integer;
begin
  Result := -1;
  if Assigned(FCachedGraphic) then
    Result := FCachedGraphic.GetOriginalSize.cx;
  if Result <=0 then
    Result := GetGraphic.Width;
end;

procedure TfrxCachedGraphicImage.SaveToStream(Stream: TStream);
var
  sz: TSize;
  LGraphic: TGraphic;
begin
  if Assigned(FCachedGraphic) then
  begin
    LGraphic := Graphic;
    sz := FCachedGraphic.GetOriginalSize;
    if (sz.cx <> LGraphic.Width) or (sz.cy <> LGraphic.Height) then
    begin
      LGraphic := GetGraphicFormats.ScaleGraphicToNew(LGraphic, sz.cx, sz.cy);
      try
        LGraphic.SaveToStream(Stream);
      finally
        LGraphic.Free;
      end;
    end;
  end
  else
    inherited SaveToStream(Stream);
end;

initialization
  DefBitMap := TBitmap.Create;
  ErrorBitMap := TBitmap.Create;
  ErrorBitMapMask := TBitmap.Create;
{$ifdef LCL}
  {$I frxHTMLun2.lrs}
  DefBitMap.LoadFromLazarusResource('DefaultBitmap');
  ErrorBitMap.LoadFromLazarusResource('ErrBitmap');
  ErrorBitMapMask.LoadFromLazarusResource('ErrBitmapMask');
{$else}
  {$R frxHTML32.res}
  DefBitMap.Handle := LoadBitmap(HInstance, MakeIntResource(DefaultBitmap));
  ErrorBitMap.Handle := LoadBitmap(HInstance, MakeIntResource(ErrBitmap));
  ErrorBitMapMask.Handle := LoadBitmap(HInstance, MakeIntResource(ErrBitmapMask));
{$endif}

  DefImage := TfrxHtBitmapImage.Create(DefBitmap, nil, itrNone);
  ErrorImage := TfrxHtBitmapImage.Create(ErrorBitmap, ErrorBitmapMask, itrLLCorner);
  ImageLoader := TfrxHtImageLoader.Create;
finalization
  ImageLoader.Free;
  ErrorImage.Free;
  DefImage.Free;
end.
