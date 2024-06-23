
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frPictureGraphics;

{$I frVer.inc}

interface

uses
  SysUtils, Classes,
{$IFNDEF Linux}
  Windows,
{$ENDIF}
  Graphics, Variants, frCore, frBaseGraphicsTypes,
{$IFDEF FPC}
  Types, LCLType, LCLIntf, LCLProc, frLazGraphicClasses,
{$ENDIF}
{$IFDEF DELPHI16}
  System.Types,
{$ENDIF}
  SyncObjs;

const
  frxBitmapFileFormat = 0;

type
  TfrxGraphicFormatCap = (gcSaveTo, gcLoadFrom, gcGetCanvas, gcDraw, gcConvert, gcConvertToBitmap);
  TfrxGraphicStringType = (stClassName, stName, stExtension, stMime);
  TfrxGraphicFormatCaps = set of TfrxGraphicFormatCap;
  TfrxGraphicCanvasHelper = class;
  TfrxGraphicCanvasHelperClass = class of TfrxGraphicCanvasHelper;

  TfrxCanvasClass = class of TCanvas;

  TfrxGraphicProps = packed record
    HasAlpha: Boolean;
    Transparent: Boolean;
    TransparentColor: TColor;
    Quality: Integer;
    PixelFormat: TPixelFormat;
  end;

  TfrxDrawGraphicExt = packed record
    DrawProps: TfrxGraphicDrawProps;
    TransparentColor: TColor;
    Quality: TfrxGraphicQuality;
  end;

  EAbstractGraphicFormatException = class(Exception);

  TfrxCustomGraphicFormat = class
  protected
    class function GetCanvasHelperClass: TfrxGraphicCanvasHelperClass; virtual;
    class procedure DoDrawExt(const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX: Double; ScaleY: Double); virtual;
  public
    class function ConvertFrom(Graphic: TGraphic; DestPixelFormat: TPixelFormat; DestQuality: Integer = 100): TGraphic; virtual;
    class function ConvertToBitmap(Graphic: TGraphic; DestPixelFormat: TPixelFormat): TGraphic; virtual;
    class function ConvertToMaskedBitmap(Graphic: TGraphic; DestPixelFormat: TPixelFormat; TransparentMask: TColor): TGraphic; virtual;
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; virtual;
    class function CreateFromStream(const Stream: TStream): TGraphic; virtual;
    class function CreateCanvasHelper(Graphic: TGraphic): TfrxGraphicCanvasHelper; virtual;
    class procedure ScaleGraphic(Graphic: TGraphic; NewWidth, NewHeight: Integer); virtual;
    class function ScaleGraphicToNew(Graphic: TGraphic; NewWidth, NewHeight: Integer): TGraphic; virtual;
    class procedure Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; Quality: TfrxGraphicQuality); virtual;
    class procedure DrawTransparent(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; MaskColor: TColor; Quality: TfrxGraphicQuality); virtual;
    class procedure DrawExt(const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX: Double; ScaleY: Double); virtual;
    class function GetGraphicClass: TGraphicClass; virtual;
    class function GetGraphicMime: String; virtual;
    class function GetGraphicName: String; virtual;
    class function GetGraphicExt: String; virtual;
    class function GetGraphicConst: Integer; virtual;
    class function GetGraphicProps(Graphic: TGraphic): TfrxGraphicProps; virtual;
    class function GetFormatCapabilities: TfrxGraphicFormatCaps; virtual;
    class function GetAlphaBitmap(Graphic: TGraphic): TBitmap; virtual;
    class function GetMaskBitmap(Graphic: TGraphic; TransparentMask: TColor): TBitmap; virtual;
    class function HasAlphaChanel(Graphic: TGraphic): Boolean; virtual;
    class function HasMaskColor(Graphic: TGraphic): Boolean; virtual;
    class function IsTransparent(Graphic: TGraphic): Boolean; virtual;
    class function IsTranslucent: Boolean; virtual;
    class function IsSupportedFormat(const Stream: TStream): Boolean; virtual;
    class function IsVector: Boolean; virtual;
    class function LoadFromStream(const aPictire: TPicture; Stream: TStream): Boolean; virtual;
    class procedure SetTransparent(Graphic: TGraphic; Transparent: Boolean); virtual;
    class procedure SetTransparentColor(Graphic: TGraphic; Color: TColor); virtual;
    class function GetTransparentColor(Graphic: TGraphic): TColor; virtual;

    class function IsTextData(Graphic: TGraphic): Boolean; virtual;
    class function GetTextData(Graphic: TGraphic): string; virtual;
    class procedure SetTextData(Graphic: TGraphic; st: string); virtual;
    class function CreateFromText(st: string): TGraphic; virtual;
  end;

  TfrxFullAbilitiesGraphicFormat = class(TfrxCustomGraphicFormat)
  public
    class function GetFormatCapabilities: TfrxGraphicFormatCaps; override;
  end;

  TfrxCustomVectorGraphicFormat = class(TfrxFullAbilitiesGraphicFormat)
  protected
    class function ConvertToBitmapSize(Graphic: TGraphic; DestPixelFormat: TPixelFormat; Width, Height: Integer): TGraphic;
    class function ConvertToBitmapScale(Graphic: TGraphic; DestPixelFormat: TPixelFormat; Scale: Extended): TGraphic;
    class function GetAlphaBitmapSize(Graphic: TGraphic; Width, Height: Integer): TBitmap;
  public
    class function ConvertToBitmap(Graphic: TGraphic; DestPixelFormat: TPixelFormat): TGraphic; override;
    class function HasAlphaChanel(Graphic: TGraphic): Boolean; override;
    class function GetAlphaBitmap(Graphic: TGraphic): TBitmap; override;
    class function IsVector: Boolean; override;
  end;

  TfrxCustomGraphicFormatClass = class of TfrxCustomGraphicFormat;

  TfrxGraphicCanvasHelper = class
  private
    FFormatClass: TfrxCustomGraphicFormatClass;
  protected
    FGraphic: TGraphic;
    function GetCanvas: TCanvas; virtual;
    function GetCanvasGraphic: TGraphic; virtual;
  public
    constructor Create(Graphic: TGraphic; FormatClass: TfrxCustomGraphicFormatClass); virtual;
    destructor Destroy; override;
    procedure ReleaseCanvas; virtual;
    procedure SwitchFullOpacity; virtual; // Empty
    property Canvas: TCanvas read GetCanvas;
    property CanvasGraphic: TGraphic read GetCanvasGraphic;
    property GraphicHelper: TfrxCustomGraphicFormatClass read FFormatClass;
  end;

  TfrxBitmapCanvasHelper = class(TfrxGraphicCanvasHelper)
  protected
    function GetCanvas: TCanvas; override;
  end;

  TfrxBitmapGraphicFormat = class(TfrxFullAbilitiesGraphicFormat)
  protected
    class function GetCanvasHelperClass: TfrxGraphicCanvasHelperClass; override;
    class procedure DoDrawExt(const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX: Double; ScaleY: Double); override;
  public
    class function ConvertFrom(Graphic: TGraphic; DestPixelFormat: TPixelFormat; DestQuality: Integer = 100): TGraphic; override;
    class function ConvertFromVector(Graphic: TGraphic; DestPixelFormat: TPixelFormat; Scale: Extended = 1.0): TGraphic;
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; override;
    class procedure Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; Quality: TfrxGraphicQuality); override;
    class function HasAlphaChanel(Graphic: TGraphic): Boolean; override;
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function GetGraphicProps(Graphic: TGraphic): TfrxGraphicProps; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
    class procedure SetTransparent(Graphic: TGraphic; Transparent: Boolean); override;
    class procedure SetTransparentColor(Graphic: TGraphic; Color: TColor); override;
    class function GetTransparentColor(Graphic: TGraphic): TColor; override;
    class function GetAlphaBitmap(Graphic: TGraphic): TBitmap; override;
  end;

  { Default null graphic , used for draw unregistred classes }
  TfrxDefaultGraphicFormat = class(TfrxCustomGraphicFormat)
  public
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function GetFormatCapabilities: TfrxGraphicFormatCaps; override;
  end;

  TfrxGraphicFormats = class(TList)
  private
    FGFormatsCS: TCriticalSection;
    function GetItem(Index: TfrListInteger): TfrxCustomGraphicFormatClass;
    procedure PutItem(Index: TfrListInteger;
      const Value: TfrxCustomGraphicFormatClass);
    function IsCapsSupported(ReqCaps, SourceCaps: TfrxGraphicFormatCaps): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function BuildFormatsString(stType: TfrxGraphicStringType; const Separator: String = ' '; RequiredCaps: TfrxGraphicFormatCaps = []): String;
    function BuildFormatsStrings(stType: TfrxGraphicStringType; RequiredCaps: TfrxGraphicFormatCaps = []): TStringList;
    function Convert(SourceGraphic: TGraphic; const DestFormat: String; DestPixelFormat: TPixelFormat; DestQuality: Integer = 100): TGraphic;
    function ConvertToBitmap(SourceGraphic: TGraphic; DestPixelFormat: TPixelFormat): TGraphic;
    procedure Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect; Quality: TfrxGraphicQuality);
    procedure DrawExt(const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX: Double; ScaleY: Double);
    function FindByGraphic(GraphicClass: TGraphicClass; RequiredCaps: TfrxGraphicFormatCaps = []): TfrxCustomGraphicFormatClass;
    function FindByExt(const Ext: String; RequiredCaps: TfrxGraphicFormatCaps = []): TfrxCustomGraphicFormatClass;
    function FindByFormat(Stream: TStream; RequiredCaps: TfrxGraphicFormatCaps = []): TfrxCustomGraphicFormatClass;
    function FindByConst(const Index: Integer; RequiredCaps: TfrxGraphicFormatCaps = []): TfrxCustomGraphicFormatClass;
    function FindByName(const Name: String; RequiredCaps: TfrxGraphicFormatCaps = []): TfrxCustomGraphicFormatClass;
    function GetDefault: TfrxCustomGraphicFormatClass;
    function HasAlphaChanel(Graphic: TGraphic): Boolean;
    function IsTransparent(Graphic: TGraphic): Boolean;
    function LoadFromStream(const aPictire: TPicture; Stream: TStream): Boolean; overload;
    function LoadFromStream(Stream: TStream): TGraphic; overload;
    procedure ScaleGraphic(Graphic: TGraphic; NewWidth, NewHeight: Integer);
    function ScaleGraphicToNew(Graphic: TGraphic; NewWidth, NewHeight: Integer): TGraphic;
    procedure RegisterFormat(AClass: TfrxCustomGraphicFormatClass);
    procedure UnregisterFormat(AClass: TfrxCustomGraphicFormatClass);
    property Items[Index: TfrListInteger]: TfrxCustomGraphicFormatClass read GetItem write PutItem; default;
  end;

  function GetGraphicFormats: TfrxGraphicFormats;

var
  frxDefaultMetaCanvasClass: TfrxCanvasClass = nil;

implementation

uses
{$IFNDEF FPC}
  frWinGraphicUtils,
  frMetafileGraphics,
  frPNGGraphics,
  frGIFGraphics,
  {$IFNDEF RAD_ED}
    frSVGGraphics,
  {$ENDIF}
{$ELSE}
  frLazGraphicUtils,
  frLazPNGGraphics,
{$ENDIF}
  frICOGraphics,
  frJPEGGraphics;

type
  _BITMAPFILEHEADER = record
    bfType: Word;
    bfSize: DWORD;
    bfReserved1: Word;
    bfReserved2: Word;
    bfOffBits: DWORD;
  end;
  TfrxBitmapFileHeader = _BITMAPFILEHEADER;

var
  GraphicFormats: TfrxGraphicFormats = nil;

function GetGraphicFormats: TfrxGraphicFormats;
begin
  if GraphicFormats = nil then
    GraphicFormats := TfrxGraphicFormats.Create;
  Result := GraphicFormats;
end;

{ TfrxGraphicFormats }

function TfrxGraphicFormats.BuildFormatsString(stType: TfrxGraphicStringType; const Separator: String; RequiredCaps: TfrxGraphicFormatCaps): String;
var
  sl: TStringList;
begin
  Result := '';
  sl := BuildFormatsStrings(stType, RequiredCaps);
  try
    sl.Delimiter := Separator[1];
    Result := sl.DelimitedText;
  finally
    sl.Free;
  end;
end;

function TfrxGraphicFormats.BuildFormatsStrings(
  stType: TfrxGraphicStringType;
  RequiredCaps: TfrxGraphicFormatCaps): TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to Count - 1 do
  begin
    if IsCapsSupported(RequiredCaps, TfrxCustomGraphicFormatClass(Items[i]).GetFormatCapabilities) then
    begin
      case stType of
        stClassName: Result.AddObject(Items[i].ClassName, TObject(Result.ClassType));
        stName: Result.AddObject(Items[i].GetGraphicName, TObject(Result.ClassType));
        stExtension: Result.AddObject('*' + Items[i].GetGraphicExt, TObject(Result.ClassType));
        stMime: Result.AddObject(Items[i].GetGraphicMime, TObject(Result.ClassType));
      end;
    end;
  end;
end;

function TfrxGraphicFormats.Convert(SourceGraphic: TGraphic;
  const DestFormat: String; DestPixelFormat: TPixelFormat; DestQuality: Integer): TGraphic;
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  GFormat := FindByName(DestFormat, [gcConvert]);
  Result := nil;
  if not Assigned(GFormat) then Exit;
  Result := GFormat.ConvertFrom(SourceGraphic, DestPixelFormat, DestQuality);
end;

function TfrxGraphicFormats.ConvertToBitmap(SourceGraphic: TGraphic;
  DestPixelFormat: TPixelFormat): TGraphic;
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  GFormat := FindByGraphic(TGraphicClass(SourceGraphic.ClassType), [gcConvertToBitmap]);
  Result := nil;
  if not Assigned(GFormat) then Exit;
  Result := GFormat.ConvertToBitmap(SourceGraphic, DestPixelFormat);
end;

constructor TfrxGraphicFormats.Create;
begin
  inherited Create;
  FGFormatsCS := TCriticalSection.Create;
end;

destructor TfrxGraphicFormats.Destroy;
begin
  inherited;
  FreeAndNil(FGFormatsCS);
end;

procedure TfrxGraphicFormats.Draw(Canvas: TCanvas; AGraphic: TGraphic;
  Area: TRect; Quality: TfrxGraphicQuality);
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  GFormat := FindByGraphic(TGraphicClass(AGraphic.ClassType));
  if Assigned(GFormat) then
    GFormat.Draw(Canvas, AGraphic, Area, Quality);
end;

procedure TfrxGraphicFormats.DrawExt(const GProps: TfrxDrawGraphicExt;
  Canvas: TCanvas; AGraphic: TGraphic; const Area: TRect; ScaleX,
  ScaleY: Double);
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  GFormat := FindByGraphic(TGraphicClass(AGraphic.ClassType));
  if Assigned(GFormat) then
    GFormat.DrawExt(GProps, Canvas, AGraphic, Area, ScaleX, ScaleY);
end;

function TfrxGraphicFormats.FindByConst(const Index: Integer; RequiredCaps: TfrxGraphicFormatCaps): TfrxCustomGraphicFormatClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if (TfrxCustomGraphicFormatClass(Items[i]).GetGraphicConst = Index)
        and IsCapsSupported(RequiredCaps, TfrxCustomGraphicFormatClass(Items[i]).GetFormatCapabilities) then
    begin
      Result := TfrxCustomGraphicFormatClass(Items[i]);
      Exit;
    end;
end;

function TfrxGraphicFormats.FindByExt(const Ext: String; RequiredCaps: TfrxGraphicFormatCaps): TfrxCustomGraphicFormatClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if (UpperCase(TfrxCustomGraphicFormatClass(Items[i]).GetGraphicExt) = UpperCase(Ext))
        and IsCapsSupported(RequiredCaps, TfrxCustomGraphicFormatClass(Items[i]).GetFormatCapabilities) then
    begin
      Result := TfrxCustomGraphicFormatClass(Items[i]);
      Exit;
    end;
end;

function TfrxGraphicFormats.FindByFormat(Stream: TStream; RequiredCaps: TfrxGraphicFormatCaps): TfrxCustomGraphicFormatClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if TfrxCustomGraphicFormatClass(Items[i]).IsSupportedFormat(Stream)
        and IsCapsSupported(RequiredCaps, TfrxCustomGraphicFormatClass(Items[i]).GetFormatCapabilities) then
    begin
      Result := TfrxCustomGraphicFormatClass(Items[i]);
      Exit;
    end;
end;

function TfrxGraphicFormats.FindByGraphic(
  GraphicClass: TGraphicClass; RequiredCaps: TfrxGraphicFormatCaps): TfrxCustomGraphicFormatClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if ((TfrxCustomGraphicFormatClass(Items[i]).GetGraphicClass = GraphicClass)
        or GraphicClass.InheritsFrom(TfrxCustomGraphicFormatClass(Items[i]).GetGraphicClass))
        and IsCapsSupported(RequiredCaps, TfrxCustomGraphicFormatClass(Items[i]).GetFormatCapabilities) then
    begin
      Result := TfrxCustomGraphicFormatClass(Items[i]);
      Exit;
    end;
end;

function TfrxGraphicFormats.FindByName(const Name: String; RequiredCaps: TfrxGraphicFormatCaps): TfrxCustomGraphicFormatClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if (TfrxCustomGraphicFormatClass(Items[i]).GetGraphicName = Name)
        and IsCapsSupported(RequiredCaps, TfrxCustomGraphicFormatClass(Items[i]).GetFormatCapabilities) then
    begin
      Result := TfrxCustomGraphicFormatClass(Items[i]);
      Exit;
    end;
end;

function TfrxGraphicFormats.GetDefault: TfrxCustomGraphicFormatClass;
begin
  Result := TfrxDefaultGraphicFormat;
end;

function TfrxGraphicFormats.GetItem(
  Index: TfrListInteger): TfrxCustomGraphicFormatClass;
begin
  Result := TfrxCustomGraphicFormatClass(Get(Index));
end;

function TfrxGraphicFormats.HasAlphaChanel(Graphic: TGraphic): Boolean;
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  Result := False;
  GFormat := FindByGraphic(TGraphicClass(Graphic.ClassType));
  if not Assigned(GFormat) then Exit;
  GFormat.HasAlphaChanel(Graphic);
end;

function TfrxGraphicFormats.IsCapsSupported(ReqCaps,
  SourceCaps: TfrxGraphicFormatCaps): Boolean;
begin
  Result := ReqCaps = [];
  if not Result then
    Result := Byte(SourceCaps) and Byte(ReqCaps) = Byte(ReqCaps);
end;

function TfrxGraphicFormats.IsTransparent(Graphic: TGraphic): Boolean;
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  Result := False;
  GFormat := FindByGraphic(TGraphicClass(Graphic.ClassType));
  if not Assigned(GFormat) then Exit;
  GFormat.HasAlphaChanel(Graphic);
end;

function TfrxGraphicFormats.LoadFromStream(Stream: TStream): TGraphic;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if IsCapsSupported([gcLoadFrom], Items[i].GetFormatCapabilities) and Items[i].IsSupportedFormat(Stream) then
    begin
      Result := Items[i].CreateFromStream(Stream);
      if Assigned(Result) then Exit;
    end;
end;

function TfrxGraphicFormats.LoadFromStream(const aPictire: TPicture;
  Stream: TStream): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
    if IsCapsSupported([gcLoadFrom], Items[i].GetFormatCapabilities) and Items[i].IsSupportedFormat(Stream) then
    begin
      Result := Items[i].LoadFromStream(aPictire, Stream);
      if Result then Exit;
    end;
end;

procedure TfrxGraphicFormats.PutItem(Index: TfrListInteger;
  const Value: TfrxCustomGraphicFormatClass);
begin
  Put(Index, Value);
end;

procedure TfrxGraphicFormats.RegisterFormat(
  AClass: TfrxCustomGraphicFormatClass);
begin
  FGFormatsCS.Enter;
  try
    Add(AClass);
  finally
    FGFormatsCS.Leave;
  end;
end;

procedure TfrxGraphicFormats.ScaleGraphic(Graphic: TGraphic; NewWidth,
  NewHeight: Integer);
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  GFormat := FindByGraphic(TGraphicClass(Graphic.ClassType), [gcGetCanvas]);
  if not Assigned(GFormat) then Exit;
  GFormat.ScaleGraphic(Graphic, NewWidth, NewHeight);
end;

function TfrxGraphicFormats.ScaleGraphicToNew(Graphic: TGraphic; NewWidth,
  NewHeight: Integer): TGraphic;
var
  GFormat: TfrxCustomGraphicFormatClass;
begin
  Result := nil;
  GFormat := FindByGraphic(TGraphicClass(Graphic.ClassType), [gcGetCanvas]);
  if not Assigned(GFormat) then Exit;
  Result := GFormat.ScaleGraphicToNew(Graphic, NewWidth, NewHeight);
end;

procedure TfrxGraphicFormats.UnregisterFormat(
  AClass: TfrxCustomGraphicFormatClass);
begin
  FGFormatsCS.Enter;
  try
    Remove(AClass);
  finally
    FGFormatsCS.Leave;
    if Count = 0 then
      FreeAndNil(GraphicFormats);
  end;
end;

{ TfrxBitmapPictureFormat }

class function TfrxBitmapGraphicFormat.ConvertFrom(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat; DestQuality: Integer): TGraphic;
var
  GHelper: TfrxCustomGraphicFormatClass;
begin
  Result := nil;
  GHelper := GetGraphicFormats.FindByGraphic(TGraphicClass(Graphic.ClassType));
  if Assigned(GHelper) then
    Result := GHelper.ConvertToBitmap(Graphic, DestPixelFormat);
end;

class function TfrxBitmapGraphicFormat.ConvertFromVector(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat; Scale: Extended = 1.0): TGraphic;
var
  GHelper: TfrxCustomGraphicFormatClass;
begin
  Result := nil;
  GHelper := GetGraphicFormats.FindByGraphic(TGraphicClass(Graphic.ClassType));
  if Assigned(GHelper) then
    if GHelper.IsVector then
      Result := TfrxCustomVectorGraphicFormat(GHelper).ConvertToBitmapScale(Graphic, DestPixelFormat, Scale)
    else
      Result := GHelper.ConvertToBitmap(Graphic, DestPixelFormat);
end;

class function TfrxBitmapGraphicFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
var
  Bitmap: TBitmap absolute Result;
begin
  Result := TBitmap.Create;
  Bitmap.PixelFormat := PixelFormat;
  Bitmap.Width := Width;
  Bitmap.Height := Height;
  Bitmap.Transparent := Transparent;
end;

class procedure TfrxBitmapGraphicFormat.DoDrawExt(
  const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic;
  const Area: TRect; ScaleX, ScaleY: Double);
begin
  if HasAlphaChanel(AGraphic) and (fgdTransparent in GProps.DrawProps) then
    frxDrawGraphicBlend(Canvas, Area, TBitmap(AGraphic), GProps.Quality)
  else
    inherited DoDrawExt(GProps, Canvas, AGraphic, Area, ScaleX, ScaleY);
end;

class procedure TfrxBitmapGraphicFormat.Draw(Canvas: TCanvas; AGraphic: TGraphic; Area: TRect;
  Quality: TfrxGraphicQuality);
begin
  // Issue #268
  // TBitmap.Draw uses StretchBlt and acquired context of memory bitmap but never lock it
  // so handle may be freed during FreeMemoryContexts when code used in a thread
  TBitmap(AGraphic).Canvas.Lock;
  try
    inherited Draw(Canvas, AGraphic, Area, Quality);
  finally
    TBitmap(AGraphic).Canvas.Unlock;
  end;
end;

class function TfrxBitmapGraphicFormat.GetAlphaBitmap(
  Graphic: TGraphic): TBitmap;
var
  i, j: Integer;
  AlphaBitmap: TBitmap absolute Result;
  LBitmap: TBitmap absolute Graphic;
  pDest: PByte;
  pSource: PInteger;
begin
  Result := nil;
  if not (Graphic is TBitmap) then Exit;

  Result := TBitmap.Create;
  AlphaBitmap.PixelFormat := pf8bit;
  AlphaBitmap.Width := LBitmap.Width;
  AlphaBitmap.Height := LBitmap.Height;
  if LBitmap.PixelFormat = pf32bit then
    for i := 0 to AlphaBitmap.Height - 1 do
    begin
      pDest := AlphaBitmap.ScanLine[i];
      pSource := LBitmap.ScanLine[i];
      for j := 0 to AlphaBitmap.Width - 1 do
      begin
        pDest^ := Byte(pSource^ shr 24);
        Inc(pDest);
        Inc(pSource);
      end;
    end;
end;

class function TfrxBitmapGraphicFormat.GetCanvasHelperClass: TfrxGraphicCanvasHelperClass;
begin
  Result := TfrxBitmapCanvasHelper;
end;

class function TfrxBitmapGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TBitmap;
end;

class function TfrxBitmapGraphicFormat.GetGraphicConst: Integer;
begin
  Result := frxBitmapFileFormat;
end;

class function TfrxBitmapGraphicFormat.GetGraphicExt: String;
begin
  Result := '.bmp';
end;

class function TfrxBitmapGraphicFormat.GetGraphicMime: String;
begin
  Result := 'image/bitmap';
end;

class function TfrxBitmapGraphicFormat.GetGraphicName: String;
begin
  Result := 'BMP';
end;

class function TfrxBitmapGraphicFormat.GetGraphicProps(
  Graphic: TGraphic): TfrxGraphicProps;
var
  Bmp: TBitmap absolute Graphic;
begin
  Result.HasAlpha := Bmp.PixelFormat = pf32bit;
  Result.Transparent := Bmp.Transparent;
  Result.TransparentColor := Bmp.TransparentColor;
  Result.Quality := 100;
  Result.PixelFormat := Bmp.PixelFormat;
end;

class function TfrxBitmapGraphicFormat.GetTransparentColor(
  Graphic: TGraphic): TColor;
begin
  Result := TBitmap(Graphic).TransparentColor;
end;

class function TfrxBitmapGraphicFormat.HasAlphaChanel(
  Graphic: TGraphic): Boolean;
begin
  Result := (TBitmap(Graphic).PixelFormat = pf32bit) and {$IFDEF DELPHI16}((TBitmap(Graphic).AlphaFormat in [afDefined, afPremultiplied]) or TBitmap(Graphic).Transparent){$ELSE}False{$ENDIF};
end;

class function TfrxBitmapGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
var
  BMPHeader: TfrxBitmapFileHeader;
  pos: Integer;
begin
  Result := False;
  if (Stream.Size - Stream.Position) >= SizeOf(BMPHeader) then
  begin
    pos := Stream.Position;
    Stream.ReadBuffer(BMPHeader, SizeOf(BMPHeader));
    Stream.Position := pos;
    if BMPHeader.bfType = $4D42 then
      Result := True;
  end;
end;

class procedure TfrxBitmapGraphicFormat.SetTransparent(Graphic: TGraphic;
  Transparent: Boolean);
begin
  TBitmap(Graphic).Transparent := Transparent;
end;

class procedure TfrxBitmapGraphicFormat.SetTransparentColor(Graphic: TGraphic;
  Color: TColor);
begin
  TBitmap(Graphic).TransparentColor := Color;
end;

{ TfrxCustomPictureFormat }

class function TfrxCustomGraphicFormat.ConvertFrom(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat; DestQuality: Integer): TGraphic;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method ConvertFrom in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.ConvertToBitmap(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat): TGraphic;
var
  Bmp: TBitmap absolute Result;
begin
  Result := nil;
  Result := TBitmap.Create;
  Bmp.PixelFormat := DestPixelFormat;
//  Bmp.Width := Graphic.Width;
//  Bmp.Height := Graphic.Height;
//  Bmp.Canvas.Brush.Color := clWhite;
//  Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
  Bmp.Assign(Graphic);
end;

class function TfrxCustomGraphicFormat.ConvertToMaskedBitmap(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat; TransparentMask: TColor): TGraphic;
begin
  Result := nil;
end;

class function TfrxCustomGraphicFormat.CreateCanvasHelper(
  Graphic: TGraphic): TfrxGraphicCanvasHelper;
begin
  Result := TfrxGraphicCanvasHelper(GetCanvasHelperClass.NewInstance);
  Result.Create(Graphic, Self);
end;

class function TfrxCustomGraphicFormat.CreateFromStream(
  const Stream: TStream): TGraphic;
begin
  Result := TGraphic(GetGraphicClass.NewInstance);
  Result.Create;
  Result.LoadFromStream(Stream);
end;

class function TfrxCustomGraphicFormat.CreateFromText(st: string): TGraphic;
begin
  Result := nil;
end;

class function TfrxCustomGraphicFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method CreateNew in %s', [ClassName]));
end;

class procedure TfrxCustomGraphicFormat.DoDrawExt(
  const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic;
  const Area: TRect; ScaleX, ScaleY: Double);
begin
  if fgdDefaultMaskColor in GProps.DrawProps then
    DrawTransparent(Canvas, AGraphic, Area, GetTransparentColor(AGraphic), GProps.Quality)
  else if fgdTransparent in GProps.DrawProps then
    DrawTransparent(Canvas, AGraphic, Area, GProps.TransparentColor, GProps.Quality)
  else
    Draw(Canvas, AGraphic, Area, GProps.Quality);
end;

class procedure TfrxCustomGraphicFormat.Draw(Canvas: TCanvas;
  AGraphic: TGraphic; Area: TRect; Quality: TfrxGraphicQuality);
begin
  if not IsVector and (Quality in [gqPrint, gqHiQuality]) then
    frxDrawGraphic(Canvas, Area, AGraphic, gqPrint = Quality, gqHiQuality = Quality, False, clNone, nil)
  else
    Canvas.StretchDraw(Area, AGraphic);
end;

class procedure TfrxCustomGraphicFormat.DrawExt(
  const GProps: TfrxDrawGraphicExt; Canvas: TCanvas; AGraphic: TGraphic;
  const Area: TRect; ScaleX: Double; ScaleY: Double);
var
  kx, ky: Extended;
  FDX, FDY: Integer;
  LArea: TRect;
  rgn: HRGN;
begin
  rgn := 0;
  if fgdClip in GProps.DrawProps then
  begin
    rgn := CreateRectRgn(0, 0, MaxInt, MaxInt);
    GetClipRgn(Canvas.Handle, rgn);
    IntersectClipRect(Canvas.Handle, Area.Left, Area.Top, Area.Right,
      Area.Bottom);
  end;
  try
    FDX := Area.Right - Area.Left;
    FDY := Area.Bottom - Area.Top;
    LArea := Area;
    if fgdStretch in GProps.DrawProps then
    begin
      if fgdKeepAspectRatio in GProps.DrawProps then
      begin
        if AGraphic.Width <> 0 then
          kx := FDX / AGraphic.Width
        else
          kx := 0;
        if AGraphic.Height <> 0 then
          ky := FDY / AGraphic.Height
        else
          ky := 0;
        if kx < ky then
          LArea.Bottom := LArea.Top + Round(AGraphic.Height * kx)
        else
          LArea.Right := LArea.Left + Round(AGraphic.Width * ky);
        if fgdCenter in GProps.DrawProps then
          OffsetRect(LArea, (FDX - (LArea.Right - LArea.Left)) div 2,
            (FDY - (LArea.Bottom - LArea.Top)) div 2);
      end;
      DoDrawExt(GProps, Canvas, AGraphic, LArea, ScaleX, ScaleY);
    end
    else
    begin
      if fgdCenter in GProps.DrawProps then
        OffsetRect(LArea, (FDX - Round(ScaleX * AGraphic.Width)) div 2,
          (FDY - Round(ScaleY * AGraphic.Height)) div 2);

      LArea.Right := LArea.Left + Round(AGraphic.Width * ScaleX);
      LArea.Bottom := LArea.Top + Round(AGraphic.Height * ScaleY);
      DoDrawExt(GProps, Canvas, AGraphic, LArea, ScaleX, ScaleY);
    end;
  finally
    if (fgdClip in GProps.DrawProps) then
    begin
      SelectClipRgn(Canvas.Handle, rgn);
      DeleteObject(rgn);
    end;
  end;
end;

class procedure TfrxCustomGraphicFormat.DrawTransparent(Canvas: TCanvas;
  AGraphic: TGraphic; Area: TRect; MaskColor: TColor; Quality: TfrxGraphicQuality);
var
  AlphaB: TBitmap;
begin
  { TODO: clean up from this legacy function }
  if not IsVector and ((Quality in [gqPrint, gqHiQuality]) or (MaskColor <> clNone)) then
  begin
    AlphaB := nil;
    if HasAlphaChanel(AGraphic) and (MaskColor = clNone) then
       AlphaB := GetAlphaBitmap(AGraphic);
    frxDrawGraphic(Canvas, Area, AGraphic, gqPrint = Quality, gqHiQuality = Quality, (MaskColor <> clNone) or Assigned(AlphaB), MaskColor, AlphaB);
    FreeAndNil(AlphaB);
  end
  else
    Draw(Canvas, AGraphic, Area, Quality);
end;

class function TfrxCustomGraphicFormat.GetAlphaBitmap(
  Graphic: TGraphic): TBitmap;
begin
  Result := nil;
end;

class function TfrxCustomGraphicFormat.GetCanvasHelperClass: TfrxGraphicCanvasHelperClass;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method GetCanvasHelperClass in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.GetFormatCapabilities: TfrxGraphicFormatCaps;
begin
  Result := [gcLoadFrom, gcDraw, gcConvertToBitmap];
end;

class function TfrxCustomGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method GetGraphicClass in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.GetGraphicConst: Integer;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method GetGraphicConst in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.GetGraphicExt: String;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method GetGraphicExt in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.GetGraphicMime: String;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method GetGraphicMime in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.GetGraphicName: String;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method GetGraphicName in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.GetGraphicProps(Graphic: TGraphic): TfrxGraphicProps;
begin
  Result.HasAlpha := HasAlphaChanel(Graphic);
  Result.Transparent := IsTransparent(Graphic);
  Result.TransparentColor := clNone;
  Result.Quality := 100;
  Result.PixelFormat := pfDevice;
end;

class function TfrxCustomGraphicFormat.GetMaskBitmap(
  Graphic: TGraphic; TransparentMask: TColor): TBitmap;
var
  Bmp: TBitmap;
begin
  Result := TBitmap.Create;
  Result.HandleType := bmDIB;
  Result.Width := Graphic.Width;
  Result.Height := Graphic.Height;
  Result.PixelFormat := pf8bit;
  Result.Canvas.Lock;
  Result.Canvas.Brush.Color := clWhite;
  Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));

  Bmp := TBitmap.Create;
  Bmp.HandleType := bmDIB;
  Bmp.Width := Graphic.Width;
  Bmp.Height := Graphic.Height;
  Bmp.PixelFormat := pf24bit;
  Bmp.Canvas.Lock;
  try
    Bmp.Canvas.Brush.Color := TransparentMask;
    Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
    Bmp.Canvas.Draw(0, 0, Graphic);
    frxApplyMask(Result, Bmp, TransparentMask);
  finally
    Bmp.Canvas.Unlock;
    Result.Canvas.Unlock;
    Bmp.Free;
  end;
end;

class function TfrxCustomGraphicFormat.GetTextData(Graphic: TGraphic): string;
begin
  Result := '';
end;

class function TfrxCustomGraphicFormat.GetTransparentColor(
  Graphic: TGraphic): TColor;
begin
  Result := clNone;
end;

class function TfrxCustomGraphicFormat.HasAlphaChanel(
  Graphic: TGraphic): Boolean;
begin
  Result := False;
end;

class function TfrxCustomGraphicFormat.HasMaskColor(Graphic: TGraphic): Boolean;
begin
  Result := False;
end;

class function TfrxCustomGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method IsSupportedFormat in %s', [ClassName]));
end;

class function TfrxCustomGraphicFormat.IsTextData(Graphic: TGraphic): Boolean;
begin
  Result := False;
end;

class function TfrxCustomGraphicFormat.IsTranslucent: Boolean;
begin
  Result := False;
end;

class function TfrxCustomGraphicFormat.IsTransparent(
  Graphic: TGraphic): Boolean;
begin
  if Assigned(Graphic) then
    Result := Graphic.Transparent
  else
    Result := False;
end;

class function TfrxCustomGraphicFormat.IsVector: Boolean;
begin
  Result := False;
end;

class function TfrxCustomGraphicFormat.LoadFromStream(const aPictire: TPicture;
  Stream: TStream): Boolean;
var
  NewGraphic: TGraphic;
begin
  NewGraphic := TGraphic(GetGraphicClass.NewInstance);
  NewGraphic.Create;
  try
    aPictire.Graphic := NewGraphic;
    aPictire.Graphic.LoadFromStream(Stream);
  finally
    NewGraphic.Free;
  end;
  Result := True;
end;

class procedure TfrxCustomGraphicFormat.ScaleGraphic(Graphic: TGraphic;
  NewWidth, NewHeight: Integer);
var
  NewGraphic: TGraphic;
begin
  NewGraphic := ScaleGraphicToNew(Graphic, NewWidth, NewHeight);
  try
    Graphic.Assign(NewGraphic);
  finally
    NewGraphic.Free
  end;
end;

class function TfrxCustomGraphicFormat.ScaleGraphicToNew(Graphic: TGraphic;
  NewWidth, NewHeight: Integer): TGraphic;
var
  GProps: TfrxGraphicProps;
  CanvasH: TfrxGraphicCanvasHelper;
  Canvas: TCanvas;
  btColor: Boolean;
begin
  GProps := GetGraphicProps(Graphic);
  btColor := (GProps.PixelFormat <> pf32bit) and (GProps.Transparent) and not GProps.HasAlpha;
  if GProps.HasAlpha then
    GProps.PixelFormat := pf32bit;
  Result := CreateNew(NewWidth, NewHeight, GProps.PixelFormat, GProps.Transparent, GProps.Quality);
  CanvasH := CreateCanvasHelper(Result);
  if btColor then
    SetTransparentColor(Result, GProps.TransparentColor);
  Canvas := CanvasH.GetCanvas;
  Canvas.Lock;
  try
    if btColor and (GProps.TransparentColor <> clNone) then
    begin
      Canvas.Brush.Color := GProps.TransparentColor;
      Canvas.FillRect(Rect(0, 0, NewWidth, NewHeight));
    end;
    Draw(Canvas, Graphic, Rect(0, 0, NewWidth, NewHeight), gqDefault);
  finally
    Canvas.Unlock;
    CanvasH.Free;
  end;
end;

class procedure TfrxCustomGraphicFormat.SetTextData(Graphic: TGraphic; st: string);
begin
  // Empty
end;

class procedure TfrxCustomGraphicFormat.SetTransparent(Graphic: TGraphic; Transparent: Boolean);
begin
  Graphic.Transparent := Transparent;
end;

class procedure TfrxCustomGraphicFormat.SetTransparentColor(Graphic: TGraphic;
  Color: TColor);
begin
  //
end;

{ TfrxGraphicCanvasHelper }

constructor TfrxGraphicCanvasHelper.Create(Graphic: TGraphic; FormatClass: TfrxCustomGraphicFormatClass);
begin
  FGraphic := Graphic;
  FFormatClass := FormatClass;
end;

destructor TfrxGraphicCanvasHelper.Destroy;
begin
  ReleaseCanvas;
  FGraphic := nil;
  FFormatClass := nil;
  inherited;
end;

function TfrxGraphicCanvasHelper.GetCanvas: TCanvas;
begin
  raise EAbstractGraphicFormatException.Create(Format('Method GetCanvas in %s', [ClassName]));
end;

function TfrxGraphicCanvasHelper.GetCanvasGraphic: TGraphic;
begin
  Result := FGraphic;
end;

procedure TfrxGraphicCanvasHelper.ReleaseCanvas;
begin
//
end;

procedure TfrxGraphicCanvasHelper.SwitchFullOpacity;
begin
  // Empty
end;

{ TfrxBitmapCanvasHelper }

function TfrxBitmapCanvasHelper.GetCanvas: TCanvas;
begin
  Result := TBitmap(FGraphic).Canvas;
end;

{ TfrxFullAbilitiesGraphicFormat }

class function TfrxFullAbilitiesGraphicFormat.GetFormatCapabilities: TfrxGraphicFormatCaps;
begin
  Result := inherited GetFormatCapabilities + [gcGetCanvas, gcConvert, gcSaveTo];
end;

{ TfrxCustomVectorGraphicFormat }

class function TfrxCustomVectorGraphicFormat.ConvertToBitmap(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat): TGraphic;
begin
  Result := ConvertToBitmapSize(Graphic, DestPixelFormat,
    Graphic.Width, Graphic.Height);
end;

class function TfrxCustomVectorGraphicFormat.ConvertToBitmapScale(
  Graphic: TGraphic; DestPixelFormat: TPixelFormat; Scale: Extended): TGraphic;
begin
  Result := ConvertToBitmapSize(Graphic, DestPixelFormat,
    Round(Scale * Graphic.Width), Round(Scale * Graphic.Height));
end;

class function TfrxCustomVectorGraphicFormat.ConvertToBitmapSize(
  Graphic: TGraphic; DestPixelFormat: TPixelFormat; Width, Height: Integer): TGraphic;
var
  Bmp: TBitmap absolute Result;
  AlphaBM: TBitmap;
  Dest, AlphaSource: PByte;
  A: Byte;
  x, y, bit: Integer;
begin
  Result := nil;
  Result := TBitmap.Create;
  Bmp.PixelFormat := DestPixelFormat;
  Bmp.Width := Width;
  Bmp.Height := Height;
  Bmp.Transparent := (DestPixelFormat = pf32bit);
  Bmp.Canvas.Lock;
  try
    Bmp.Canvas.Brush.Color := clWhite;
    Bmp.Canvas.FillRect(Bmp.Canvas.ClipRect);
    Bmp.Canvas.StretchDraw(Bmp.Canvas.ClipRect, Graphic);
  finally
    Bmp.Canvas.Unlock;
  end;

  if Bmp.Transparent then
  begin
    AlphaBM := TBitmap(GetAlphaBitmapSize(Graphic, Width, Height));
    try
      if AlphaBM.PixelFormat <> pf1bit then
        Exit;
      for y := 0 to AlphaBM.Height - 1 do
      begin
        AlphaSource := AlphaBM.ScanLine[y];
        Dest := Bmp.ScanLine[y];
        bit := 0;
        for x := 0 to Bmp.Width - 1 do
        begin
          A := AlphaSource^;
          A :=((A shr (7 - bit)) and 1) * 255;
          Inc(Dest, 3);
          Dest^ := A;
          Inc(bit);
          if bit > 7 then
          begin
            Inc(AlphaSource);
            bit := 0;
          end;
          Inc(Dest);
        end;
      end;
    finally
      AlphaBM.Free;
    end;
  end;
end;

class function TfrxCustomVectorGraphicFormat.GetAlphaBitmap(
  Graphic: TGraphic): TBitmap;
begin
  Result := GetAlphaBitmapSize(Graphic, Graphic.Width, Graphic.Height);
end;

class function TfrxCustomVectorGraphicFormat.GetAlphaBitmapSize(
  Graphic: TGraphic; Width, Height: Integer): TBitmap;

  function CreateColor(Color: TColor): TBitmap;
  begin
    Result := TBitmap.Create;
    Result.PixelFormat := pf1bit;
    Result.Width := Width;
    Result.Height := Height;
    Result.Canvas.Lock;
    try
      Result.Canvas.Brush.Color := Color;
      Result.Canvas.FillRect(Result.Canvas.ClipRect);
      Result.Canvas.StretchDraw(Result.Canvas.ClipRect, Graphic);
    finally
      Result.Canvas.Unlock;
    end;
  end;
var
  BmBlack, BmWhite: TBitmap;
  x, y: Integer;
  Pb, Pb2: PByte;
begin
  BmWhite := CreateColor(clWhite);
  BmBlack := CreateColor(clBlack);
  try
    for y := 0 to BmWhite.Height - 1 do
    begin
      Pb := BmWhite.ScanLine[y];
      Pb2 := BmBlack.ScanLine[y];
      for x := 0 to (BmWhite.Width + 7) div 8 - 1 do
      begin
        pb^ := not pb^ or pb2^;
        Inc(pb);
        Inc(pb2);
      end;
    end;
  finally
    BmBlack.Free;
    Result := BmWhite;
  end;
end;

class function TfrxCustomVectorGraphicFormat.HasAlphaChanel(
  Graphic: TGraphic): Boolean;
begin
  Result := Graphic.Transparent;
end;

class function TfrxCustomVectorGraphicFormat.IsVector: Boolean;
begin
  Result := True;
end;

{ TfrxDefaultGraphicFormat }

class function TfrxDefaultGraphicFormat.GetFormatCapabilities: TfrxGraphicFormatCaps;
begin
  Result := [gcLoadFrom, gcDraw];
end;

class function TfrxDefaultGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TGraphic;
end;

class function TfrxDefaultGraphicFormat.GetGraphicConst: Integer;
begin
  Result := MaxInt;
end;

class function TfrxDefaultGraphicFormat.GetGraphicExt: String;
begin
  Result := '';
end;

class function TfrxDefaultGraphicFormat.GetGraphicMime: String;
begin
  Result := '';
end;

class function TfrxDefaultGraphicFormat.GetGraphicName: String;
begin
  Result := '';
end;

initialization
  GetGraphicFormats.RegisterFormat(TfrxBitmapGraphicFormat);

finalization
  GetGraphicFormats.UnregisterFormat(TfrxBitmapGraphicFormat);

end.
