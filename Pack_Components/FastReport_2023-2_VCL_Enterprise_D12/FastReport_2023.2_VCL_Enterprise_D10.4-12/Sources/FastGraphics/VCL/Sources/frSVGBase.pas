
{******************************************}
{                                          }
{             FastReport VCL               }
{            SVG Base Elements             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGBase;

interface

{$I frVer.inc}

uses
  Windows, Classes, Graphics, Types,
  frCoreClasses,
  frSVGHelpers, frSVGCanvas, frSVGColor,
  frSVGElement, frSVGComponents, frCSSStyle, frSVGParse;

type
  TSVGBaseObj = class(TSVGElementObj)
  private
    FCanvasClipList: TfrOwnObjList;

    function GetStrokeData: TSVGStrokeData;
    procedure SetFiller(DrawType: TSVGDrawType; SVGPaint: TSVGPaint; Opacity: Single; const Graphics: TSVGCanvas);

  protected
    FPath: TSVGCanvasPath;

    procedure ConstructPath; override;
    procedure CalcClipPathList;
    function CalcSelfBounds: TSingleBounds; override;

    procedure DoPaintToGraphics(Graphics: TSVGCanvas); virtual;
    procedure PaintToPath(Path: TSVGCanvasPath); virtual;
  public
    destructor Destroy; override;
    procedure PaintToGraphics(Graphics: TSVGCanvas); virtual;
  end;

  Tel_svg = class(TSVGBaseObj)
  private
    procedure Paint(const Graphics: TSVGCanvas);
  protected
    FRootMatrix: TSVGTransform;

    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function CalcSelfBounds: TSingleBounds; override;
    function CalcXYTranslation(X, Y: Single): TSVGTransform; virtual;
    procedure CalcRootMatrix;
    function CalcCenteredShift(Offset: TSinglePoint): TSinglePoint; virtual;
    function CalcExternalTranslateMatrix: TSVGTransform; virtual;
    function CalcExternalScaleMatrix: TSVGTransform; virtual;
    function CalcAngleMatrix: TSVGTransform; virtual;
    function GetViewBox: TSingleBounds; virtual;
    procedure PaintTo(DC: HDC); virtual;
  public
    constructor Create; override;

    function GetHeight: Single; override;
    function GetWidth: Single; override;
    function GetTransform: TSVGTransform; override;

    function GetViewBoxWidth: Single;
    function GetViewBoxHeight: Single;
    function GetViewBoxDiagonal: Single;

    property RootMatrix: TSVGTransform read FRootMatrix;
  end;

  TSVGRootObj = class(Tel_svg)
  private
    FSource: string;
    FFileName: string;
    FStyleList: TfrxCSSList;
    FExternalOpacity: Single;
    FExternalAngle: Single;
    FExternalFontSize: Single;
    FExternalFontName: string;
    FExternalBounds: TSingleBounds;
    FExternalScale: TSinglePoint;
    FExternalCentered: Boolean;

    procedure SetExternalBounds(const Value: TSingleBounds);
    procedure SetExternalAngle(const Value: Single);
    procedure SetExternalFontName(const Value: string);
    procedure SetExternalFontSize(const Value: Single);
    procedure SetExternalOpacity(const Value: Single);
    procedure SetExternalScale(const Value: TSinglePoint);
    procedure SetExternalCentered(const Value: Boolean);
  protected
    FSVGCanvasClass: TSVGCanvasClass;
    FIsPrepared: Boolean;
    FIsFullOpacity: Boolean;

    procedure AssignTo(Dest: TPersistent); override;
    procedure AssignStylesApplyingSequenceTo(Obj: TSVGElementObj); override; // Empty
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function GetCanvasClass: TSVGCanvasClass; override;
    function CalcCenteredShift(Offset: TSinglePoint): TSinglePoint; override;
    function CalcExternalTranslateMatrix: TSVGTransform; override;
    function CalcExternalScaleMatrix: TSVGTransform; override;
    function CalcAngleMatrix: TSVGTransform; override;
    function GetIsFullOpacity: Boolean; override;
    procedure SetIsFullOpacity(const Value: Boolean); override;
    function IsSizeless: Boolean;
    procedure Prepare;
  public
    constructor Create; override; // SVGCanvasClass = TSVGGDIPCanvas;
    constructor Create(SVGCanvasClass: TSVGCanvasClass); overload;
    destructor Destroy; override;
    procedure Clear; override;
    function IsRoot: Boolean; override;

    procedure ReadStyle(const Node: TfrxSVGXMLItem);
    procedure ClarifyOwnShorthandProperties; override;

    procedure LoadFromText(const Text: string);
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream); overload;
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);

    procedure PaintTo(DC: HDC); override;

    function GetHeight: Single; override;
    function GetWidth: Single; override;

    function CalcFillOpacity: Single; override;
    function CalcStrokeOpacity: Single; override;

    function GetOuterHeight: Single;
    function GetOuterWidth: Single;
    procedure SureSizeAndViewBox;
    procedure atSetLengthSW(a: TSVGAttribute; LengthSW: TSVGLengthSW);

    function GetHostWidth: Single; override;
    function GetHostHeight: Single; override;
    function GetHostDiagonal: Single; override;

    property StyleList: TfrxCSSList read FStyleList;

    property ExternalOpacity: Single read FExternalOpacity write SetExternalOpacity;
    property ExternalAngle: Single write SetExternalAngle;  // Degree
    property ExternalFontSize: Single read FExternalFontSize write SetExternalFontSize;
    property ExternalFontName: string read FExternalFontName write SetExternalFontName;
    property ExternalBounds: TSingleBounds read FExternalBounds write SetExternalBounds;
    property ExternalScale: TSinglePoint write SetExternalScale;
    property ExternalCentered: Boolean write SetExternalCentered;

    property Source: string read FSource;
  end;

  Tel_g = class(TSVGBaseObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;
  end;

  Tel_a = class(TSVGBaseObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;
  end;

  Tel_switch = class(TSVGBaseObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function IsAnyChildHaveSystemLanguage: boolean;
    procedure SwitchChildren; override;
    procedure GetLanguage(out Language, PartLanguage: string);
  public
    constructor Create; override;
  end;

  Tel_use = class(TSVGBaseObj)
  protected
    FHrefObj: TSVGElementObj;

    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function IsHrefObjExists: Boolean;
  public
    constructor Create; override;
    procedure Construct;
    procedure PaintToGraphics(Graphics: TSVGCanvas); override;
    procedure PaintToPath(Path: TSVGCanvasPath); override;
  end;

  Tel_rect = class(TSVGBaseObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
  end;

  Tel_line = class(TSVGBaseObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
  end;

  Tel_polyline = class(TSVGBaseObj)
  private
    FPoints: TSinglePointDynArray;
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
    function IsHasPoints: Boolean;
  public
    constructor Create; override;
  end;

  Tel_polygon = class(Tel_polyline)
  private
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
  end;

  Tel_circle = class(TSVGBaseObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
  end;

  Tel_ellipse = class(TSVGBaseObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
  end;

  Tel_image = class(TSVGBaseObj)
  private
    FImage: TSVGCanvasImage;
    FStream: TMemoryStream;
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function IsFoundImage(S: string): boolean;
    function CalcSelfBounds: TSingleBounds; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure PaintToGraphics(Graphics: TSVGCanvas); override;
  end;

  Tel_clipPath = class(TSVGBaseObj)
    private
      FInnerClipPath: TSVGCanvasPath;
      FTransformedPath: TSVGCanvasPath;
      FLastMatrix: TSVGTransform;
    protected
      function New(Parent: TSVGElementObj): TSVGElementObj; override;
      procedure ConstructClipPath;
    public
      constructor Create; override;
      destructor Destroy; override;
      function GetInnerClipPath(BoundingBox: TSingleBounds; UserMatrix: TSVGTransform): TSVGCanvasPath;
    end;

  TSVGFontMetric = record
    Descent, Ascent, InternalLeading, Capital, ExternalLeading: double;
  end;

  TSVGCustomText = class(TSVGBaseObj)
  private
    FText: string;
    FTextWidth: Single;
    FDecorations: TTextDecorations;
    FTextOrigin: TTextOrigin;
    FFontHeight: Single;

    function GetCompleteWidth: Single;
    procedure SetSize;
    function IsCalcSVGFontMetric(var Font: TFont; out FM: TSVGFontMetric): Boolean; // Frees Font

    function IsInTextPath: Boolean;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure ConstructPath; override;
    procedure DoPaintToGraphics(Graphics: TSVGCanvas); override;
    function GetFontData: TSVGFontData;
    procedure ClearDecorations;
    procedure ReadTextOrigin;
    procedure DeleteCRLF;
  public
    class function CreatePlainText(AParent: TSVGElementObj; ChildNodeText: string;
      ChildNodeIndex, ChildNodeCount: Integer): TSVGCustomText;
    destructor Destroy; override;
  end;

  Tel_text = class(TSVGCustomText)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;
  end;

  Tel_tspan = class(TSVGCustomText)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;
  end;

  Tel_textPath = class(TSVGCustomText)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
  end;

implementation

uses
  Math, SysUtils, StrUtils,
  frSVGPaint, frSVGPath, frUtils, frSVGGDIPCanvas,
  frHashUtils;

const
  DefaultStrokeWidth = 1.0;
  DefaultStrokeDashOffset = 0.0;

{ TSVGBaseObj }

destructor TSVGBaseObj.Destroy;
begin
  FPath.Free;
  FCanvasClipList.Free;
  inherited Destroy;
end;

procedure TSVGBaseObj.DoPaintToGraphics(Graphics: TSVGCanvas);
begin
  Graphics.PaintPath(FPath, atSpecificWord(at_fill_rule));
end;

procedure TSVGBaseObj.CalcClipPathList;
var
  Path: TSVGElementObj;
  ClipURIHost: TSVGElementObj;
  ClipRoot: Tel_clipPath;
  CanvasPath, CP: TSVGCanvasPath;
begin
  if Assigned(FCanvasClipList) then
    FCanvasClipList.Clear
  else
    FCanvasClipList := TfrOwnObjList.Create;

  ClipURIHost := Self;
  while (ClipURIHost <> nil) and not (ClipURIHost is Tel_svg) do
  begin
    if (ClipURIHost is TSVGBaseObj)  then
    begin
      Path := FRoot.FindByID(ClipURIHost.atURI(at_clip_path));
      if Path is Tel_clipPath then
      begin
        ClipRoot := Tel_clipPath(Path);
        CanvasPath := ClipRoot.GetInnerClipPath(ClipURIHost.GetBounds, ClipURIHost.InnerMatrix);
        CP := CanvasPath.Clone;
        CP.Matrix := ClipRoot.CompleteMatrix;
        FCanvasClipList.Insert(0, CP);
      end;
    end;
    ClipURIHost := ClipURIHost.Parent;
  end;
end;

function TSVGBaseObj.CalcSelfBounds: TSingleBounds;
begin
  if FPath = nil then
    Result := EmptySingleBounds
  else
    Result := FPath.Bounds;
end;

procedure TSVGBaseObj.PaintToGraphics(Graphics: TSVGCanvas);
var
  i: Integer;
  CP: TSVGCanvasPath;
begin
  if FPath = nil then
    Exit;

  CalcClipPathList;
  try
    if Assigned(FCanvasClipList) then
      for i := 0 to FCanvasClipList.Count - 1 do
      begin
        CP := TSVGCanvasPath(FCanvasClipList[i]);
        Graphics.SetTransform(CP.Matrix);
        if i = 0 then
          Graphics.SetClip(CP)
        else
          Graphics.IntersectClip(CP);
      end;

    Graphics.SetTransform(CompleteMatrix);

    SetFiller(dtFill, atPaint(at_fill), CalcFillOpacity, Graphics);
    SetFiller(dtStroke, atPaint(at_stroke), CalcStrokeOpacity, Graphics);
    Graphics.SetStroke(GetStrokeData);

    DoPaintToGraphics(Graphics);

  finally
    Graphics.ResetTransform;
    Graphics.ResetClip;
  end;
end;

procedure TSVGBaseObj.PaintToPath(Path: TSVGCanvasPath);
begin
  if FPath <> nil then
    Path.AddPath(FPath, False);
end;

procedure TSVGBaseObj.SetFiller(DrawType: TSVGDrawType; SVGPaint: TSVGPaint; Opacity: Single; const Graphics: TSVGCanvas);
var
  Filler: TSVGElementObj;
  GradientData: TSVGGradientData;
  PatternData: TSVGPatternData;
begin
  if SVGPaint.SW = frx_URI then
  begin
    Filler := FRoot.FindByID(string(SVGPaint.URI));
    if      Filler = nil then
      Graphics.SetSolidColor(DrawType, SVGColorTransparent)
    else if Filler is TSVGGradient then
    begin
      TSVGGradient(Filler).GetGradientData(Opacity, Self, GradientData);
      Graphics.SetGradient(DrawType, GradientData);
    end
    else if Filler is Tel_pattern then
    begin
      Tel_pattern(Filler).GetPatternData(Opacity, Self, PatternData);
      Graphics.SetPattern(DrawType, PatternData);
    end
  end
  else
    Graphics.SetSolidColor(DrawType, ToSVGColor(SVGPaint, Opacity));
end;

function TSVGBaseObj.GetStrokeData: TSVGStrokeData;
begin
  Result.Width :=       atLengthInherit(at_stroke_width);
  Result.Miterlimit :=  atNumberInherit(at_stroke_miterlimit);
  Result.LineCap :=     atSpecificWord(at_stroke_linecap);
  Result.LineJoin :=    atSpecificWord(at_stroke_linejoin);
  Result.Dash.Offset := atLengthInherit(at_stroke_dashoffset);
  Result.Dash.Arr :=    atLengthListNoneInherit(at_stroke_dasharray);
end;

procedure TSVGBaseObj.ConstructPath;
begin
  FreeAndNil(FPath);
end;

{ Tel_svg }

function Tel_svg.CalcAngleMatrix: TSVGTransform;
begin
  Result := tmIdentity;
end;

function Tel_svg.CalcCenteredShift(Offset: TSinglePoint): TSinglePoint;
begin
  Result := Offset;
end;

function Tel_svg.CalcExternalScaleMatrix: TSVGTransform;
begin
  Result := tmIdentity;
end;

function Tel_svg.CalcExternalTranslateMatrix: TSVGTransform;
begin
  Result := tmIdentity;
end;

procedure Tel_svg.CalcRootMatrix;
var
  TranslateMatrix, ViewBoxScaleMatrix, ViewBoxTranslateMatrix: TSVGTransform;
  Scale, Offset, CenteredShift: TSinglePoint;
  X, Y, W, H: Single;
  VB: TSingleBounds;
  PAR: TSVGPreserveAspectRatio;
begin
  X := atLength(at_x);
  Y := atLength(at_y);
  W := atLengthAuto(at_width);
  H := atLengthAuto(at_height);

  TranslateMatrix := CalcXYTranslation(X, Y);

  VB := GetViewBox;
  PAR := atPAR;

  Scale := CalcScale(W, H, VB, PAR);
  Offset := CalcOffset(Scale, W, H, VB, PAR);
  CenteredShift := CalcCenteredShift(Offset);
  ViewBoxTranslateMatrix := tmTranslation(-CenteredShift.X, -CenteredShift.Y);
  ViewBoxScaleMatrix := tmScaling(Scale.X, Scale.Y);

  FRootMatrix := tmIdentity;

  FRootMatrix := tmMultiply(CalcExternalTranslateMatrix, FRootMatrix);
  FRootMatrix := tmMultiply(TranslateMatrix, FRootMatrix);
  FRootMatrix := tmMultiply(ViewBoxTranslateMatrix, FRootMatrix);
  FRootMatrix := tmMultiply(ViewBoxScaleMatrix, FRootMatrix);
  FRootMatrix := tmMultiply(CalcExternalScaleMatrix, FRootMatrix);
  FRootMatrix := tmMultiply(CalcAngleMatrix, FRootMatrix);
end;

function Tel_svg.CalcSelfBounds: TSingleBounds;
begin
  Result := GetViewBox;
end;

function Tel_svg.CalcXYTranslation(X, Y: Single): TSVGTransform;
begin
  Result := tmTranslation(X, Y);
end;

constructor Tel_svg.Create;
begin
  inherited Create;
  ConstructAttributes(el_svg);
end;

function Tel_svg.GetHeight: Single;
begin
  Result := atLengthAuto(at_height);
end;

function Tel_svg.GetViewBox: TSingleBounds;
begin
  if atIsDefault(at_viewBox) then
    Result := ToSingleBounds(0,
                             0,
                             atLengthAuto(at_width),
                             atLengthAuto(at_height))
  else
    Result := AttrObj[at_viewBox].GetBounds;
end;

function Tel_svg.GetViewBoxHeight: Single;
begin
  Result := GetViewBox.Height;
end;

function Tel_svg.GetViewBoxWidth: Single;
begin
  Result := GetViewBox.Width;
end;

function Tel_svg.GetWidth: Single;
begin
  Result := atLengthAuto(at_width)
end;

function Tel_svg.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_svg.Create(Parent);
end;

procedure Tel_svg.Paint(const Graphics: TSVGCanvas);

  procedure PaintItem(const Item: TSVGElementObj; const Graphics: TSVGCanvas);
  var
    i: Integer;
  begin
    if Item.IsNeedsPainting then
    begin
      TSVGBaseObj(Item).PaintToGraphics(Graphics);
      for i := 0 to Item.Count - 1 do
        PaintItem(Item[i], Graphics);
    end;
  end;

begin
  PaintItem(Self, Graphics);
end;

procedure Tel_svg.PaintTo(DC: HDC);
var
  Graphics: TSVGCanvas;
begin
  Graphics := CanvasClass.Create(DC);
  try
    CalculateMatrices;
    Paint(Graphics);
  finally
    Graphics.Free;
  end;
end;

function Tel_svg.GetViewBoxDiagonal: Single;
begin
  with GetViewBox do
    Result := Sqrt((Sqr(Width) + Sqr(Height)) / 2.0);
end;

function Tel_svg.GetTransform: TSVGTransform;
begin
  if IsEmptyTransform(FRootMatrix) then
    CalcRootMatrix;
  Result := FRootMatrix;
end;

{ Tel_g }

constructor Tel_g.Create;
begin
  inherited Create;
  ConstructAttributes(el_g);
end;

function Tel_g.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_g.Create(Parent);
end;

{ Tel_switch }

constructor Tel_switch.Create;
begin
  inherited Create;
  ConstructAttributes(el_switch);
end;


{$IFNDEF Delphi15}
//function LCIDToLocaleName(Locale: LCID; lpName: LPWSTR; cchName: Integer;
//  dwFlags: DWORD): Integer; stdcall;external kernel32 name 'LCIDToLocaleName';
function GetWindowsLanguage(LCTYPE: LCTYPE {type of information}): string;
var
  Buffer : PChar;
  Size : integer;
begin
  Size := GetLocaleInfo (LOCALE_USER_DEFAULT, LCType, nil, 0);
  GetMem(Buffer, Size);
  try
    GetLocaleInfo (LOCALE_USER_DEFAULT, LCTYPE, Buffer, Size);
    Result := string(Buffer);
  finally
    FreeMem(Buffer);
  end;
end;
{$ENDIF}

procedure Tel_switch.GetLanguage(out Language, PartLanguage: string);
var
{$IFDEF Delphi15}
  Buffer: array [0..255] of WideChar;
{$ENDIF}
  DefisPos: Integer;
begin
{$IFNDEF Delphi15}
  Language := GetWindowsLanguage(LOCALE_SISO639LANGNAME) + '-' + GetWindowsLanguage(LOCALE_SISO3166CTRYNAME);
{$ELSE}
  LCIDToLocaleName(GetSystemDefaultLCID, Buffer, 255, 0);
  Language := Buffer;
{$ENDIF}
  Language := AnsiLowercase(Language);
  DefisPos := Pos('-', Language);
  if DefisPos > 0 then
    PartLanguage := Copy(Language, 1, Pos('-', Language) - 1)
  else
    PartLanguage := '';
end;

function Tel_switch.IsAnyChildHaveSystemLanguage: boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Count - 1 do
    if Items[i].IsAttrEnabled[at_systemLanguage] and
       not Items[i].atIsDefault(at_systemLanguage) then
      Exit;
  Result := False;
end;

function Tel_switch.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_switch.Create(Parent);
end;

procedure Tel_switch.SwitchChildren;
const
  Unknown = -1;
var
  Language, PartLanguage, S, st: string;
  i, j, PartFit, CatchAll: Integer;
  SL: TStrings;
begin
  if not IsAnyChildHaveSystemLanguage then
    Exit;

  GetLanguage(Language, PartLanguage);

  for i := 0 to Count - 1 do
    Items[i].SwitchedOn := False;

  PartFit := Unknown;
  CatchAll := Unknown;

  for i := 0 to Count - 1 do
  begin
    S := Items[i].atString(at_systemLanguage);
    if S <> '' then
    begin
      SL := frToStringList(S, ',');
      try
        for j := 0 to SL.Count - 1  do
        begin
          st := AnsiLowercase(SL[j]);
          if Language = st then
          begin
            Items[i].SwitchedOn := True;
            Exit;
          end
          else if PartFit = Unknown then
            if      PartLanguage = st then
              PartFit := i
            else if SVGSpecificWord[svg_catch_all] = st then
              CatchAll := 1;
        end;
      finally
        SL.Free;
      end;
    end;
  end;

  if      PartFit <> Unknown then
    Items[PartFit].SwitchedOn := True
  else if CatchAll <> Unknown then
    Items[CatchAll].SwitchedOn := True;
end;

{ Tel_use }

procedure Tel_use.Construct;
var
  Container: Tel_g;
  ReferenceObjClone: TSVGElementObj;
  Matrix: TSVGTransform;
begin
  ClearItems;
  if IsHrefObjExists then
  begin
    Matrix := tmTranslation(atLength(at_x), atLength(at_y));

    Container := Tel_g.Create(Self);
    Container.AttrObj[at_transform].SetTransform(Matrix);
    ReferenceObjClone := FHrefObj.Clone(Container);

    ReferenceObjClone.ClarifyUses;
  end;
end;

constructor Tel_use.Create;
begin
  inherited Create;
  ConstructAttributes(el_use);
end;

function Tel_use.IsHrefObjExists: Boolean;

  procedure TryFind(const Href: string);
  begin
    if (Href <> '') and (Href[1] = '#') then
      FHrefObj := FRoot.FindByID(Copy(Href, 2, MaxInt));
  end;
begin
  if FHrefObj = nil then
    TryFind(atString(at_href));

  Result := FHrefObj <> nil;
end;

function Tel_use.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_use.Create(Parent);
end;

procedure Tel_use.PaintToGraphics(Graphics: TSVGCanvas);
begin
  if Count > 0 then
    TSVGBaseObj(Items[0]).PaintToGraphics(Graphics);
end;

procedure Tel_use.PaintToPath(Path: TSVGCanvasPath);
begin
  if IsHrefObjExists then
    TSVGBaseObj(FHrefObj).PaintToPath(Path);
end;

{ Tel_rect }

procedure Tel_rect.ConstructPath;
var
  rx, ry, width, height: single;
begin
  inherited ConstructPath;
  FPath := CanvasClass.CreatePath;

  rx := atLengthAuto(at_rx);
  ry := atLengthAuto(at_ry);
  width := atLengthAuto(at_width);
  height := atLengthAuto(at_height);
  // The way the value of the rx attribute is interpreted depend on both the ry attribute and the width of the rectangle:
  // If a properly specified value is provided for rx but not for ry (or the opposite), then the browser will consider the missing value equal to the defined one.
  // If neither rx nor ry has a properly specified value, then the browser will draw a rectangle with square corners.
  // If rx is greater than half of the width of the rectangle, then the browser will consider the value for rx as half of the width of the rectangle.
  if      atIsDefault(at_rx) then rx := ry
  else if atIsDefault(at_ry) then ry := rx;
  rx := Min(rx, width / 2);
  ry := Min(ry, height / 2);

  FPath.AddRectangle(ToSingleBounds(atLength(at_x), atLength(at_y), width, height), rx, ry);
  FObjBounds := FPath.Bounds;
end;

constructor Tel_rect.Create;
begin
  inherited Create;
  ConstructAttributes(el_rect);
end;

function Tel_rect.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_rect.Create(Parent);
end;

{ Tel_line }

procedure Tel_line.ConstructPath;
begin
  inherited ConstructPath;
  FPath := CanvasClass.CreatePath;
  FPath.AddLine(atLength(at_x1), atLength(at_y1), atLength(at_x2), atLength(at_y2));
  FObjBounds := FPath.Bounds;
end;

constructor Tel_line.Create;
begin
  inherited Create;
  ConstructAttributes(el_line);
end;

function Tel_line.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_line.Create(Parent);
end;

{ Tel_polyline }
procedure Tel_polyline.ConstructPath;
var
  i: Integer;
begin
  inherited ConstructPath;
  FPoints := atPoints;
  if IsHasPoints then
  begin
    FPath := CanvasClass.CreatePath;
    for i := 1 to High(FPoints) do
      FPath.AddLine(FPoints[i - 1].X, FPoints[i - 1].Y, FPoints[i].X, FPoints[i].Y);
    FObjBounds := FPath.Bounds;
  end;
end;

constructor Tel_polyline.Create;
begin
  inherited Create;
  ConstructAttributes(el_polyline);
end;

function Tel_polyline.IsHasPoints: Boolean;
begin
  Result := FPoints <> nil;
end;

function Tel_polyline.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_polyline.Create(Parent);
end;

{ Tel_polygon }

procedure Tel_polygon.ConstructPath;
begin
  inherited ConstructPath;

  if IsHasPoints then
    FPath.CloseFigure;
end;

constructor Tel_polygon.Create;
begin
  inherited Create;
  ConstructAttributes(el_polygon);
end;

function Tel_polygon.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_polygon.Create(Parent);
end;

{ Tel_ellipse }

procedure Tel_ellipse.ConstructPath;
var
  rx, ry: Single;
begin
  inherited ConstructPath;
  FPath := CanvasClass.CreatePath;

  // rx / ry: With a value lower or equal to zero the ellipse won't be drawn at all.
  rx := atLengthAuto(at_rx);
  ry := atLengthAuto(at_ry);
  if Min(rx, ry) > 0 then
  begin
    FPath.AddEllipse(atLength(at_cx), atLength(at_cy), rx, ry);
    FObjBounds := FPath.Bounds;
  end;
end;

constructor Tel_ellipse.Create;
begin
  inherited Create;
  ConstructAttributes(el_ellipse);
end;

function Tel_ellipse.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_ellipse.Create(Parent);
end;

{ Tel_image }

function Tel_image.CalcSelfBounds: TSingleBounds;
begin
  Result := FObjBounds;
end;

procedure Tel_image.ConstructPath;
begin
  if (FImage <> nil) or IsFoundImage(atString(at_href)) then
  begin
    atSetLengthAuto(at_width, FImage.GetWidth);
    atSetLengthAuto(at_height, FImage.GetHeight);
  end;
  FObjBounds := ToSingleBounds(atLength(at_x), atLength(at_y),
    atLengthAuto(at_width), atLengthAuto(at_height));
end;

constructor Tel_image.Create;
begin
  inherited Create;
  ConstructAttributes(el_image);
end;

destructor Tel_image.Destroy;
begin
  FImage.Free;
  FStream.Free;
  inherited Destroy;
end;

function Tel_image.IsFoundImage(S: string): boolean;

  function IsValidInlineImage: Boolean;
  var
    Semicolon: Integer;
  begin
    Result := False;
    if AnsiStartsStr('data:', S) then
    begin
      Semicolon := Pos(';', S);
      Result := (Semicolon > 0)
            and (Copy(S, Semicolon, 8) = ';base64,');
      if Result then
        S := Copy(S, Semicolon + 8, MaxInt);
    end;
  end;

  procedure CreateImage;
  var
    SA: TStreamAdapter;
  begin
    FStream.Position := 0;
    SA := TStreamAdapter.Create(FStream);
    FImage := CanvasClass.CreateImage(SA);
  end;

var
  AnsiSt: AnsiString;
begin
  if FImage = nil then
    if IsValidInlineImage then
    begin
      AnsiSt := frBase64Decode(AnsiString(S));
      FStream := TMemoryStream.Create;
      FStream.Write(AnsiSt[1], Length(AnsiSt));
      CreateImage;
    end
    else if FileExists(S) then
    begin
      FStream := TMemoryStream.Create;
      FStream.LoadFromFile(S);
      CreateImage;
    end;

  Result := FImage <> nil;
end;

function Tel_image.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_image.Create(Parent);
end;

procedure Tel_image.PaintToGraphics(Graphics: TSVGCanvas);
var
  i: Integer;
  CP: TSVGCanvasPath;
begin
  if (FImage <> nil) or IsFoundImage(atString(at_href)) then
  begin
    CalcClipPathList;
    try
      if Assigned(FCanvasClipList) then
        for i := 0 to FCanvasClipList.Count - 1 do
        begin
          CP := TSVGCanvasPath(FCanvasClipList[i]);
          Graphics.SetTransform(CP.Matrix);
          if i = 0 then
            Graphics.SetClip(CP)
          else
            Graphics.IntersectClip(CP);
        end;

      Graphics.SetTransform(CompleteMatrix);

      Graphics.DrawImage(FImage, GetBounds, CalcFillOpacity);
    finally
      Graphics.ResetTransform;
      Graphics.ResetClip;
    end;
  end;
end;

{ TSVGCustomText }

procedure TSVGCustomText.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TSVGCustomText then
  begin
    TSVGCustomText(Dest).FText := FText;
    TSVGCustomText(Dest).FTextWidth := FTextWidth;
    TSVGCustomText(Dest).FDecorations := FDecorations;
    TSVGCustomText(Dest).FTextOrigin := FTextOrigin;
    TSVGCustomText(Dest).FFontHeight := FFontHeight;
  end;
end;

function TSVGCustomText.IsCalcSVGFontMetric(var Font: TFont; out FM: TSVGFontMetric): Boolean; // Frees Font
var
  rSize, Factor: double;
  BM: TBitmap;
  TextMetric: {$IFDEF FPC}{$IFDEF Linux}OUTLINETEXTMETRIC{$ELSE}LPOUTLINETEXTMETRICA{$ENDIF}{$ELSE}^OUTLINETEXTMETRICA{$ENDIF};
  cjCopy: UINT;
begin
  rSize := frIfReal(Font.Size > 0, Font.Size, -Font.Size * 72 / Font.PixelsPerInch);
  TextMetric := nil;

  BM := TBitmap.Create;
  try
    BM.Canvas.Font := Font;
    cjCopy := GetOutlineTextMetrics(BM.Canvas.Handle, 0, nil);
    if cjCopy <> 0 then
    begin
      TextMetric := GetMemory(cjCopy);
      if TextMetric <> nil then
        GetOutlineTextMetricsA(BM.Canvas.Handle, cjCopy, TextMetric);
    end;
  finally
    FreeMemory(TextMetric);
    BM.Free;
    Font.Free;
  end;

  Result := TextMetric <> nil;
  if not Result then
    Exit;

  Factor := rSize / TextMetric^.otmTextMetrics.tmHeight;

  FM.Descent := TextMetric^.otmTextMetrics.tmDescent * Factor;
  FM.Ascent := TextMetric^.otmTextMetrics.tmAscent * Factor;
  FM.InternalLeading := TextMetric^.otmTextMetrics.tmInternalLeading * Factor;
  FM.Capital := FM.Ascent - FM.InternalLeading;
  FM.ExternalLeading := TextMetric^.otmTextMetrics.tmExternalLeading * Factor;
end;

procedure TSVGCustomText.ClearDecorations;
begin
  FreeAndNil(FDecorations[tdUnderline]);
  FreeAndNil(FDecorations[tdLineThrow]);
  FreeAndNil(FDecorations[tdOwerline]);
end;

procedure TSVGCustomText.ConstructPath;
  procedure CreateDecorations(FD: TSVGFontData);
  begin
    ClearDecorations;
    if svg_underline in FD.Decoration then    FDecorations[tdUnderline] := CanvasClass.CreatePath;
    if svg_line_through in FD.Decoration then FDecorations[tdLineThrow] := CanvasClass.CreatePath;
    if svg_overline in FD.Decoration then     FDecorations[tdOwerline] := CanvasClass.CreatePath;
  end;

  procedure Shift(A: TSingleDynArray; Value: Single);
  var
    i: Integer;
  begin
    for i := 0 to High(A) do
      A[i] := A[i] + Value;
  end;
var
  FontData: TSVGFontData;
begin
  inherited ConstructPath;

  DeleteCRLF;

  SetSize;

  if (FText = '') or IsInTextPath then
    Exit;

  FPath := CanvasClass.CreatePath;

  FontData := GetFontData;

  CreateDecorations(FontData);

  Shift(FTextOrigin.Y, -FFontHeight);

  {$IFDEF Delphi12}
  CanvasClass.AddStringToPath(FText, FPath, FDecorations, FTextOrigin, FontData);
  {$ELSE}
  CanvasClass.AddStringToPath(UTF8Decode(FText), FPath, FDecorations, FTextOrigin, FontData);
  {$ENDIF}

  Shift(FTextOrigin.Y, FFontHeight);

  FObjBounds := FPath.Bounds;
end;

class function TSVGCustomText.CreatePlainText(AParent: TSVGElementObj; ChildNodeText: string; ChildNodeIndex, ChildNodeCount: Integer): TSVGCustomText;
begin
  Result := nil;
  if        AParent is TSVGCustomText then
    if ChildNodeCount = 1 then // only child
    begin
      if (AParent.Parent is TSVGCustomText) and (AParent.SerialNumber > 0) then
        ChildNodeText := ' ' + ChildNodeText;
      TSVGCustomText(AParent).FText := ChildNodeText;
    end
    else
    begin
      case AParent.Element of
        el_text:     Result := Tel_text.Create(AParent);
        el_textPath: Result := Tel_textPath.Create(AParent);
        el_tspan:    Result := Tel_tspan.Create(AParent);
      end;
      if (ChildNodeIndex > 0) and (ChildNodeCount > 1) then
        ChildNodeText := ' ' + ChildNodeText;
      Result.FText := ChildNodeText;
    end;
end;

procedure TSVGCustomText.DeleteCRLF;
var
  pCRLF: Integer;
begin
  repeat
    pCRLF := Pos(AnsiString(#$D#$A), FText);
    if pCRLF > 0 then
      FText := Trim(Copy(FText, 1, pCRLF - 1)) + ' ' + Trim(Copy(FText, pCRLF + 1, MaxInt))
  until pCRLF = 0;
end;

destructor TSVGCustomText.Destroy;
begin
  ClearDecorations;
  inherited Destroy;
end;

procedure TSVGCustomText.DoPaintToGraphics(Graphics: TSVGCanvas);
begin
  Graphics.PaintPath(FDecorations[tdUnderline], atSpecificWord(at_fill_rule));
  Graphics.PaintPath(FDecorations[tdOwerline], atSpecificWord(at_fill_rule));

  inherited DoPaintToGraphics(Graphics);

  Graphics.PaintPath(FDecorations[tdLineThrow], atSpecificWord(at_fill_rule));
end;

function TSVGCustomText.GetCompleteWidth: Single;
var
  i: Integer;
begin
  Result := FTextWidth;
  for i := 0 to Count - 1 do
    if Items[i] is TSVGCustomText then
      Result := Result + TSVGCustomText(Items[i]).GetCompleteWidth;
end;

function TSVGCustomText.GetFontData: TSVGFontData;
begin
  Result.Names := atStringInherit(at_font_family);
  Result.Size := atLengthInherit(at_font_size);
  Result.Style := atSpecificWord(at_font_style);
  Result.Weight := Round(atFontWeight);
  Result.Decoration := atSpecificWordSet(at_text_decoration);
end;

function TSVGCustomText.IsInTextPath: Boolean;
var
  Obj: TSVGElementObj;
begin
  Obj := Self;
  while not Obj.IsRoot and (Obj.Element <> el_textPath) do
    Obj := Obj.Parent;
  Result := Obj.Element = el_textPath;
end;

procedure TSVGCustomText.ReadTextOrigin;
  function Sure(A: TSingleDynArray): TSingleDynArray;
  begin
    if Length(A) = 0 then
    begin
      SetLength(Result, 1);
      Result[0] := 0.0;
    end
    else
      Result := A;
  end;
begin
  FTextOrigin.X := Sure(atLengthList(at_x));
  FTextOrigin.Y := Sure(atLengthList(at_y));
  FTextOrigin.DX := Sure(atLengthList(at_dx));
  FTextOrigin.DY := Sure(atLengthList(at_dy));
end;

procedure TSVGCustomText.SetSize;
var
  Graphics: TSVGCanvas;
  Index: Integer;
  Previous: TSVGCustomText;
  DC: HDC;
  Size: TSingleSize;
  FontData: TSVGFontData;
  i: Integer;
  FM: TSVGFontMetric;
  Font: TFont;
begin
  FontData := GetFontData;

  DC := GetDC(0);
  Graphics := CanvasClass.Create(DC);
  try
    Font := Graphics.GetFont(FontData);
    Size := Graphics.MeasureString(FText, FontData, { out -=> } FFontHeight);
  finally
    Graphics.Free;
    ReleaseDC(0, DC);
  end;

  FTextWidth := Size.Width;

  ReadTextOrigin;

  if Assigned(Parent) and (Parent is TSVGCustomText) then
  begin
    Index := SerialNumber;

    Previous := nil;
    if      (Index > 0) and (Parent[Index - 1] is TSVGCustomText) then
    begin
      Previous := TSVGCustomText(Parent[Index - 1]);
      if atIsDefault(at_x) then
      begin
        FTextOrigin.X := DynArrayCopy(Previous.FTextOrigin.X);
        for i := 0 to High(FTextOrigin.X) do
          FTextOrigin.X[i] := Previous.FTextOrigin.X[i] + Previous.GetCompleteWidth;
      end;
    end
    else if (Index = 0) and (Parent is TSVGCustomText) then
    begin
      Previous := TSVGCustomText(Parent);
      if atIsDefault(at_x)  then
        FTextOrigin.X := DynArrayCopy(Previous.FTextOrigin.X);
    end;

    if Assigned(Previous) then
    begin
      if atIsDefault(at_y) then
        FTextOrigin.Y := DynArrayCopy(Previous.FTextOrigin.Y);
      if atIsDefault(at_dx) then
        FTextOrigin.DX := DynArrayCopy(Previous.FTextOrigin.DX);
      if atIsDefault(at_dy) then
        FTextOrigin.DY := DynArrayCopy(Previous.FTextOrigin.DY);
    end;
  end;

  case atSpecificWord(at_text_anchor) of
    svg_middle:
      FTextOrigin.DX[0] := FTextOrigin.DX[0] - FTextWidth / 2;
    svg_end:
      FTextOrigin.DX[0] := FTextOrigin.DX[0] - FTextWidth;
  end;

  if not IsCalcSVGFontMetric(Font, FM) { Frees Font }  then
    Exit;

  case atSpecificWord(at_dominant_baseline) of
    svg_auto: ;
    svg_use_script: ;
    svg_no_change: ;
    svg_reset_size: ;
    svg_ideographic:
      FTextOrigin.DY[0] := FTextOrigin.DY[0] - FM.Descent;
    svg_alphabetic: ;
    svg_hanging:
      FTextOrigin.DY[0] := FTextOrigin.DY[0] + FM.Capital + FM.ExternalLeading;
    svg_mathematical:
      FTextOrigin.DY[0] := FTextOrigin.DY[0] + FM.Ascent / 2;
    svg_central:
      FTextOrigin.DY[0] := FTextOrigin.DY[0] + FM.Capital / 2;
    svg_middle:
      FTextOrigin.DY[0] := FTextOrigin.DY[0] + FM.Capital / 3;
    svg_text_after_edge:
      FTextOrigin.DY[0] := FTextOrigin.DY[0] - FM.Descent;
    svg_text_before_edge:
      FTextOrigin.DY[0] := FTextOrigin.DY[0] + FM.Ascent + FM.Descent / 2;
    svg_text_top: ;
  end;

end;

{ Tel_text }

constructor Tel_text.Create;
begin
  inherited Create;
  ConstructAttributes(el_text);
end;

function Tel_text.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_text.Create(Parent);
end;

{ Tel_tspan }

constructor Tel_tspan.Create;
begin
  inherited Create;
  ConstructAttributes(el_tspan);
end;

function Tel_tspan.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_tspan.Create(Parent);
end;

{ Tel_clipPath }

procedure Tel_clipPath.ConstructClipPath;

  procedure AddPath(SVGBasic: TSVGBaseObj);
  var
    i: Integer;
  begin
    if  SVGBasic.IsOpt(eoPaint) then
      SVGBasic.PaintToPath(FInnerClipPath);
    for i := 0 to SVGBasic.Count - 1 do
      AddPath(TSVGBaseObj(SVGBasic[i]));
  end;
begin
  FInnerClipPath := CanvasClass.CreatePath;
  AddPath(Self);
end;

constructor Tel_clipPath.Create;
begin
  inherited Create;
  ConstructAttributes(el_clipPath);
end;

destructor Tel_clipPath.Destroy;
begin
  FInnerClipPath.Free;
  FTransformedPath.Free;
  inherited Destroy;
end;

function Tel_clipPath.GetInnerClipPath(BoundingBox: TSingleBounds; UserMatrix: TSVGTransform): TSVGCanvasPath;
var
  Matrix, ScaleMatrix, TranslateMatrix: TSVGTransform;
begin
  if FInnerClipPath = nil then
    ConstructClipPath;

  Matrix := UserMatrix;
  if atSpecificWord(at_clipPathUnits) = svg_objectBoundingBox then
  begin
    TranslateMatrix := tmTranslation(BoundingBox.X, BoundingBox.Y);
    ScaleMatrix := tmScaling(BoundingBox.Width, BoundingBox.Height);
    Matrix := tmMultiply(TranslateMatrix, Matrix);
    Matrix := tmMultiply(ScaleMatrix, Matrix);
  end;

  if (FTransformedPath = nil) or not IsSameTransform(Matrix, FLastMatrix) then
  begin
    FTransformedPath.Free;
    FTransformedPath := FInnerClipPath.Clone;
    FLastMatrix := Matrix;
    FTransformedPath.Transform(FLastMatrix);
  end;
  Result := FTransformedPath;
end;

function Tel_clipPath.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_clipPath.Create(Parent);
end;

{ Tel_textPath }

procedure Tel_textPath.ConstructPath;
  function Find(const HRef: string): TSVGElementObj;
  begin
    Result := nil;
    if (HRef <> '') and (HRef[1] = '#') then
      Result := FRoot.FindByID(Copy(Href, 2, MaxInt));
  end;
var
  Obj: TSVGElementObj;
  GuidePath: Tel_path;
  PT: TSVGCanvasPathText;
  Position: Single;
  Offset: Single;

  procedure RenderTextElement(const CustomText: TSVGCustomText);
  var
    i: Integer;
    FontData: TSVGFontData;
  begin
    CustomText.ClearDecorations;
    FreeAndNil(CustomText.FPath);

    if CustomText.FText <> '' then
    begin
      FontData := CustomText.GetFontData;

      PT.AdditionalMatrix := CustomText.atMatrix(at_transform);
      CustomText.FPath := CanvasClass.CreatePath;

      Position := Position +
        PT.AddPathText(CustomText.FPath, Trim(CustomText.FText),
        Offset + Position, FontData);
    end;

    for i := 0 to CustomText.Count - 1 do
      if CustomText[i] is TSVGCustomText then
        RenderTextElement(TSVGCustomText(CustomText[i]));
  end;

begin
  Obj := Find(atString(at_href));
  if (Obj = nil) or (Obj.Element <> el_path)  then
    Exit;
  GuidePath := Tel_path(Obj);
  PT := CanvasClass.CreatePathText(TSVGBaseObj(GuidePath).FPath);
  try
    Position := 0;
    Offset := atLength(at_startOffset, CanvasClass.GetPathLength(GuidePath.FPath));
    RenderTextElement(Self);
  finally
    PT.Free;
  end;
end;

constructor Tel_textPath.Create;
begin
  inherited Create;
  ConstructAttributes(el_textPath);
end;

function Tel_textPath.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_textPath.Create(Parent);
end;

{ Tel_circle }

procedure Tel_circle.ConstructPath;
var
  r: Single;
begin
  inherited ConstructPath;
  FPath := CanvasClass.CreatePath;
  r := atLength(at_r);
  if r > 0 then
  begin
    FPath.AddCircle(atLength(at_cx), atLength(at_cy), r);
    FObjBounds := FPath.Bounds;
  end;
end;

constructor Tel_circle.Create;
begin
  inherited Create;
  ConstructAttributes(el_circle);
end;

function Tel_circle.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_circle.Create(Parent);
end;

{ Tel_a }

constructor Tel_a.Create;
begin
  inherited Create;
  ConstructAttributes(el_a);
end;

function Tel_a.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_a.Create(Parent);
end;

{ TSVGRootObj }

procedure TSVGRootObj.AssignStylesApplyingSequenceTo(Obj: TSVGElementObj);
begin
  // Empty
end;

procedure TSVGRootObj.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);

  if Dest is TSVGRootObj then
  begin
    TSVGRootObj(Dest).StyleList.Assign(FStyleList);
    TSVGRootObj(Dest).FSource := FSource;
  end;
end;

procedure TSVGRootObj.atSetLengthSW(a: TSVGAttribute; LengthSW: TSVGLengthSW);
begin
  AttrObj[a].SetLengthSW(LengthSW);
end;

function TSVGRootObj.CalcAngleMatrix: TSVGTransform;
var
  w2, h2: Single;
begin
  w2 := atLengthAuto(at_width) / 2.0;
  h2 := atLengthAuto(at_height) / 2.0;

  Result := tmTranslation(w2, h2);
  Result := tmMultiply(tmRotation(FExternalAngle), Result);
  Result := tmMultiply(tmTranslation(-w2, -h2), Result);
end;

function TSVGRootObj.CalcCenteredShift(Offset: TSinglePoint): TSinglePoint;
begin
  if FExternalCentered or IsSizeless then
    Result := ToSinglePoint(
      Offset.X * FExternalScale.X,
      Offset.Y * FExternalScale.Y
    )
  else
    Result := Offset
end;

function TSVGRootObj.CalcExternalScaleMatrix: TSVGTransform;
begin
  Result := tmScaling(FExternalScale.X, FExternalScale.Y);
end;

function TSVGRootObj.CalcExternalTranslateMatrix: TSVGTransform;
begin
  Result := tmTranslation(FExternalBounds.X, FExternalBounds.Y)
end;

function TSVGRootObj.CalcFillOpacity: Single;
begin
  if IsFullOpacity then
    Result := 1.0
  else
    Result := atAlpha(at_fill_opacity) * atAlpha(at_opacity) * ExternalOpacity;
end;

function TSVGRootObj.CalcStrokeOpacity: Single;
begin
  if IsFullOpacity then
    Result := 1.0
  else
    Result := atAlpha(at_stroke_opacity) * atAlpha(at_opacity) * ExternalOpacity;
end;

procedure TSVGRootObj.ClarifyOwnShorthandProperties;
var
  i: integer;
begin
  inherited ClarifyOwnShorthandProperties;
  for i := 0 to FStyleList.Count - 1 do
    SplitShorthandProperties(FStyleList.GetStyle(i), css_font);
end;

procedure TSVGRootObj.Clear;
begin
  inherited Clear;

  FSource := '';
  if Assigned(FStyleList) then
    FStyleList.Clear;
  FIsPrepared := False;
  FRootMatrix := EmptyTransform;
end;

constructor TSVGRootObj.Create(SVGCanvasClass: TSVGCanvasClass);
begin
  Create;

  FSVGCanvasClass := SVGCanvasClass;
end;

constructor TSVGRootObj.Create;
begin
  inherited Create;
  FStyleList := TfrxCSSList.Create;
  // Default External Values
  FExternalOpacity := 1.0;
  FExternalAngle := 0.0;
  FExternalFontSize := 16.0;
  FExternalFontName := 'times';
  FExternalBounds := ToSingleBounds(0.0, 0.0, 300.0, 150.0);
  FExternalScale := ToSinglePoint(1.0, 1.0);
  FExternalCentered := False;

  FRoot := Self;
  FSVGCanvasClass := TSVGGDIPCanvas;
  FIsPrepared := False;
  FRootMatrix := EmptyTransform;
end;

destructor TSVGRootObj.Destroy;
begin
  FreeAndNil(FStyleList);
  inherited Destroy;
end;

function TSVGRootObj.GetCanvasClass: TSVGCanvasClass;
begin
  Result := FSVGCanvasClass;
end;

function TSVGRootObj.GetHeight: Single;
begin
  atSetLengthAuto(at_height, FExternalBounds.Height);
  Result := atLengthAuto(at_height);
end;

function TSVGRootObj.GetHostDiagonal: Single;
begin
  with FExternalBounds do
    Result := Sqrt((Sqr(Width) + Sqr(Height)) / 2.0);
end;

function TSVGRootObj.GetHostHeight: Single;
begin
  Result := FExternalBounds.Height;
end;

function TSVGRootObj.GetHostWidth: Single;
begin
  Result := FExternalBounds.Width;
end;

function TSVGRootObj.GetIsFullOpacity: Boolean;
begin
  Result := FIsFullOpacity;
end;

function TSVGRootObj.GetOuterHeight: Single;
begin
  Prepare;
  if IsAttrDefault(at_height) and IsAttrDefault(at_viewBox) then
    Result := CalcUnitedChildrenBounds.Height
  else
    Result := GetHeight;
end;

function TSVGRootObj.GetOuterWidth: Single;
begin
  Prepare;
  if IsAttrDefault(at_width) and IsAttrDefault(at_viewBox) then
    Result := CalcUnitedChildrenBounds.Width
  else
    Result := GetWidth;
end;

function TSVGRootObj.GetWidth: Single;
begin
  atSetLengthAuto(at_width, FExternalBounds.Width);
  Result := atLengthAuto(at_width);
end;

function TSVGRootObj.IsRoot: Boolean;
begin
  Result := True;
end;

function TSVGRootObj.IsSizeless: Boolean;
begin
  Result := (atIsDefault(at_height) or atIsDefault(at_width)) and
    not atIsDefault(at_viewBox);
end;

procedure TSVGRootObj.LoadFromFile(const FileName: string);
var
  FS: TFileStream;
begin
//Log('---------------------' + FileName);
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(FS);
    FFileName := FileName;
  finally
    FS.Free;
  end;
end;

procedure TSVGRootObj.LoadFromStream(Stream: TStream);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromStream(Stream{$IFDEF Delphi12}, TEncoding.UTF8{$ENDIF});
    LoadFromText(SL.Text);
  finally
    SL.Free;
  end;
end;

procedure TSVGRootObj.LoadFromText(const Text: string);
var
  XML: TfrxSVGXMLDocument;
  WithoutBOM: string;
begin
  Clear;

  if (Length(Text) >= 3) and
     (Text[1] + Text[2] + Text[3] = #239#187#191) then // BOM
    WithoutBOM := Copy(Text, 4, MaxInt)
  else
    WithoutBOM := Text;

  XML := TfrxSVGXMLDocument.Create(nil);
  try
    FSource := WithoutBOM;
    XML.LoadFromXML(WithoutBOM);

    if (XML <> nil) and (TfrxSVGXMLItem(XML.Root).nodeName = SVGElement[el_svg].Name) then
      ReadIn(TfrxSVGXMLItem(XML.Root))
    else
      FSource := '';
    Prepare;
  finally
    XML.Free;
  end;
end;

function TSVGRootObj.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := TSVGRootObj.Create(Parent);
end;

procedure TSVGRootObj.PaintTo(DC: HDC);
begin
  Prepare;

  inherited PaintTo(DC);
end;

procedure TSVGRootObj.Prepare;
begin
  SureSizeAndViewBox;
  if not FIsPrepared then
  begin
    ClarifyShorthandProperties;
    ClarifyStyleSequences;
    ClarifyUses;
    ConstructPathes;
    SwitchAll;
    ClarifyBounds;
    FIsPrepared := True;
  end;
end;

procedure TSVGRootObj.ReadStyle(const Node: TfrxSVGXMLItem);
begin
  FStyleList.AddText(Node.Text);
end;

procedure TSVGRootObj.SaveToFile(const FileName: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TSVGRootObj.SaveToStream(Stream: TStream);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Text := FSource;
    SL.SaveToStream(Stream{$IFDEF Delphi12}, TEncoding.UTF8{$ENDIF});
  finally
    SL.Free;
  end;
end;

procedure TSVGRootObj.SetExternalAngle(const Value: Single);
begin
  if not IsSameSingle(FExternalAngle, Value) then
  begin
    FExternalAngle := Value;
    FIsPrepared := False;
    FRootMatrix := EmptyTransform;
  end;
end;

procedure TSVGRootObj.SetExternalBounds(const Value: TSingleBounds);
begin
  if not IsSameBounds(FExternalBounds, Value) then
  begin
    FExternalBounds := Value;
    FIsPrepared := False;
    FRootMatrix := EmptyTransform;
  end;
end;

procedure TSVGRootObj.SetExternalCentered(const Value: Boolean);
begin
  if FExternalCentered <> Value then
  begin
    FExternalCentered := Value;
    FIsPrepared := False;
    FRootMatrix := EmptyTransform;
  end;
end;

procedure TSVGRootObj.SetExternalFontName(const Value: string);
begin
  if FExternalFontName <> Value then
  begin
    FExternalFontName := Value;
    FIsPrepared := False;
//    FRootMatrix := EmptyTransform;
  end;
end;

procedure TSVGRootObj.SetExternalFontSize(const Value: Single);
begin
  if not IsSameSingle(FExternalFontSize, Value) then
  begin
    FExternalFontSize := Value;
    FIsPrepared := False;
    FRootMatrix := EmptyTransform;
  end;
end;

procedure TSVGRootObj.SetExternalOpacity(const Value: Single);
begin
  if not IsSameSingle(FExternalOpacity, Value) then
  begin
    FExternalOpacity := Value;
    FIsPrepared := False;
//    FRootMatrix := EmptyTransform;
  end;
end;

procedure TSVGRootObj.SetExternalScale(const Value: TSinglePoint);
begin
  if not IsSameSinglePoint(FExternalScale, Value) then
  begin
    FExternalScale := Value;
    FIsPrepared := False;
    FRootMatrix := EmptyTransform;
  end;
end;

procedure TSVGRootObj.SetIsFullOpacity(const Value: Boolean);
begin
  FIsFullOpacity := Value;
end;

procedure TSVGRootObj.SureSizeAndViewBox;
const
  at_widthDefault =   100;
  at_heightDefault =  010;
  at_viewBoxDefault = 001;
var
  atSum: Integer;
begin
  atSum :=
    frIfInt(IsAttrDefault(at_width), 0, at_widthDefault) +
    frIfInt(IsAttrDefault(at_height), 0, at_heightDefault) +
    frIfInt(IsAttrDefault(at_viewBox), 0, at_viewBoxDefault);
  case atSum of
    001:
      with AttrObj[at_viewBox].GetBounds do
      begin
        atSetLengthSW(at_width, ToLengthSW(frx_noMater, Width));
        atSetLengthSW(at_height, ToLengthSW(frx_noMater, Height));
      end;
    011:
      with AttrObj[at_viewBox].GetBounds do
        atSetLengthSW(at_width, ToLengthSW(frx_noMater, (Width / Height) * AttrObj[at_height].GetLengthAuto));
    101:
      with AttrObj[at_viewBox].GetBounds do
        atSetLengthSW(at_height, ToLengthSW(frx_noMater, (Height / Width) * AttrObj[at_width].GetLengthAuto));
  end;
end;

end.
