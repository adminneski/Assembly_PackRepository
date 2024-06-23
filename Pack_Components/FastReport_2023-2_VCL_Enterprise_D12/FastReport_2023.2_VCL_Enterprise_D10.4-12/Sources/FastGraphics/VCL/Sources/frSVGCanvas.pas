
{******************************************}
{                                          }
{             FastReport VCL               }
{               SVG Canvas                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGCanvas;

interface

{$I frVer.inc}

uses
  Windows,
  Graphics,
  Classes,
  Types,
  frSVGHelpers,
  frSVGColor,
  frSVGComponents,
  frSVGParse;

type
  TSVGDashData = record
    Offset: Single;
    Arr: TSingleDynArray;
  end;

  TSVGStrokeData = record
    Width: Single;
    Miterlimit: Single;
    LineCap: TSVGSpecificWord;
    LineJoin: TSVGSpecificWord;
    Dash: TSVGDashData;
  end;

  TSVGFontData = record
    Names: string; // May be like "Georgia, 'Times New Roman', Times, serif"
    Size: Single;
    Style: TSVGSpecificWord;
    Weight: Integer;
    Decoration: TSVGSpecificWordSet;
  end;

  TSVGGradientStopData = record
    SVGColor: TSVGColor;
    Offset: Single;
  end;
  TSVGGradientArray = array of TSVGGradientStopData;

  TSVGDrawType = (dtFill, dtStroke);
  TSVGFillerType = (ftSolidColor, ftLinearGradient, ftRadialGradient, ftPattern);

  TSVGGradientData = record
    gradientUnits: TSVGSpecificWord;
    spreadMethod: TSVGSpecificWord;
    UserBounds: TSingleBounds;
    gradientTransform: TSVGTransform;
    GradientArray: TSVGGradientArray;
    case FillerType: TSVGFillerType of
      ftLinearGradient: (x1, x2, y1, y2: Single);
      ftRadialGradient: (cx, cy, r, fx, fy, fr: Single);
  end;
//      cx, cy, r  defines the x|y-axis coordinate, radius of the end circle for a radial gradient.
//      fx, fy, fr defines the x|y-axis coordinate, radius of the focal point for a radial gradient

  TSVGCanvasClass = class of TSVGCanvas;
  TSVGCanvas = class;

  TSVGPatternData = record
    Bitmap: TBitmap;
    x, y, Width, Height, Factor: Single;
    Offset: TSinglePoint;
    Matrix: TSVGTransform;
  end;

  TSVGCanvasImage = class
  private
  public
    constructor Create(SA: TStreamAdapter); virtual; abstract;
    function GetWidth: Cardinal; virtual; abstract;
    function GetHeight: Cardinal; virtual; abstract;
  end;

  TSVGCanvasPath = class
  private
    FMatrix: TSVGTransform;
    FFillRule: TSVGSpecificWord;
  public
    constructor Create; virtual;
    function Clone: TSVGCanvasPath; virtual; abstract;
    procedure Transform(const Matrix: TSVGTransform); virtual; abstract;
    function Bounds: TSingleBounds; virtual; abstract;

    procedure AddArc(x, y, width, height, startAngle, sweepAngle: Single); virtual; abstract;

    procedure AddBezier(x1, y1, x2, y2, x3, y3, x4, y4: Single); overload; virtual; abstract;
    procedure AddBezier(p1, p2, p3, p4: TSinglePoint); overload;

    procedure AddCircle(cx, cy, r: Single); virtual; abstract;

    procedure AddEllipse(cx, cy, rx, ry: Single); virtual; abstract;

    procedure AddLine(x1, y1, x2, y2: Single); overload; virtual; abstract;
    procedure AddLine(p1, p2: TSinglePoint); overload;

    procedure AddPath(addingPath: TSVGCanvasPath; connect: Bool); virtual; abstract;

    procedure AddRectangle(x, y, width, height, rx, ry: Single); overload; virtual; abstract;
    procedure AddRectangle(Bounds: TSingleBounds; rx, ry: Single); overload;

    procedure CloseFigure; virtual; abstract;

    procedure StartFigure; virtual; abstract;

    function Log: string; virtual; abstract;

    property Matrix: TSVGTransform read FMatrix write FMatrix;
    property FillRule: TSVGSpecificWord read FFillRule write FFillRule;
  end;

  TSVGCanvasPathText = class
  protected
    FAdditionalMatrix: TSVGTransform;
  public
    function AddPathText(const Path: TSVGCanvasPath;
      const Text: string; const Indent: Single; FontData: TSVGFontData;
      const DistanceFactor: Single = 1; const KerningFactor: Single = 1): Single; virtual; abstract;

    property AdditionalMatrix: TSVGTransform read FAdditionalMatrix write FAdditionalMatrix;
  end;

  TTextDecoration = (tdUnderline, tdLineThrow, tdOwerline);
  TTextDecorations = array[TTextDecoration] of TSVGCanvasPath;

  TTextOrigin = record
    X, Y, DX, DY: TSingleDynArray;
  end;

  TSVGCanvas = class
  private
  protected
    FFillerType: array [TSVGDrawType] of TSVGFillerType;
    FSolidColorData: array [TSVGDrawType] of TSVGColor;
    FGradientData: array [TSVGDrawType] of TSVGGradientData;
    FPatternData: array [TSVGDrawType] of TSVGPatternData;

    procedure ChangeSolidColorFiller(DrawType: TSVGDrawType); virtual; abstract;
    procedure ChangeLinearGradientFiller(DrawType: TSVGDrawType); virtual; abstract;
    procedure ChangeRadialGradientFiller(DrawType: TSVGDrawType); virtual; abstract;
    procedure ChangePatternFiller(DrawType: TSVGDrawType); virtual; abstract;

    procedure StrokePath(Path: TSVGCanvasPath); virtual; abstract;
    procedure FillPath(Path: TSVGCanvasPath); virtual; abstract;
  public
    constructor Create(hdc: HDC); virtual; abstract;
    destructor Destroy; override;

    procedure SetTransform(const Matrix: TSVGTransform); virtual; abstract;
    procedure GetTransform(out Matrix: TSVGTransform); virtual; abstract;
    procedure ResetTransform; virtual; abstract;

    procedure SetSolidColor(DrawType: TSVGDrawType; SVGColor: TSVGColor);
    procedure SetGradient(DrawType: TSVGDrawType; GradientData: TSVGGradientData);
    procedure SetPattern(DrawType: TSVGDrawType; PatternData: TSVGPatternData);

    procedure SetClip(Path: TSVGCanvasPath); virtual; abstract;
    procedure IntersectClip(Path: TSVGCanvasPath); virtual; abstract;
    procedure ResetClip; virtual; abstract;

    procedure SetStroke(StrokeData: TSVGStrokeData); virtual; abstract;

    procedure PaintPath(Path: TSVGCanvasPath; FillRule: TSVGSpecificWord);

    function MeasureString(st: string; FontData: TSVGFontData;
      out FontHeight: Single): TSingleSize; virtual; abstract;

    procedure DrawImage(FImage: TSVGCanvasImage; SVGRect: TSingleBounds; FillOpacity: Single); virtual; abstract;

    class procedure AddStringToPath(st: string; Path: TSVGCanvasPath; Decorations: TTextDecorations;
      TextOrigin: TTextOrigin; FontData: TSVGFontData); virtual; // Empty: abstract; dosn't supported in D2010

    class function CreateImage(SA: TStreamAdapter): TSVGCanvasImage; virtual; // Empty: abstract; dosn't supported in D2010
    class function CreatePath: TSVGCanvasPath; virtual; // Empty: abstract; dosn't supported in D2010
    class function CreatePathText(Path: TSVGCanvasPath): TSVGCanvasPathText; virtual; // Empty: abstract; dosn't supported in D2010

    class function GetPathLength(const Path: TSVGCanvasPath): Single; virtual; // Empty: abstract; dosn't supported in D2010
    class function GetFont(FontData: TSVGFontData): TFont; virtual; // Empty: abstract; dosn't supported in D2010
  end;

function IsSameSVGColor(F1, F2: TSVGColor): Boolean;
function IsSameGradient(G1, G2: TSVGGradientData): Boolean;
function ToSVGGradientStopData(SVGColor: TSVGColor; Offset: Single): TSVGGradientStopData;
function IsSamePattern(P1, P2: TSVGPatternData): Boolean;

implementation

uses
  Math;

{ Utility routines }

function IsSameGradientArray(A1, A2: TSVGGradientArray): Boolean;
var
  i: Integer;
begin
  Result := False;
    if Length(A1) <> Length(A2) then
      Exit
    else
      for i := 0 to High(A1) do
        if not IsSameSVGColor(A1[i].SVGColor, A2[i].SVGColor) or
           not IsSameSingle(A1[i].Offset, A2[i].Offset) then
          Exit;
  Result := True;
end;

function IsSameGradient(G1, G2: TSVGGradientData): Boolean;

  function IsSameLinearData: Boolean;
  begin
    Result := (G1.FillerType = ftLinearGradient) and
              (G2.FillerType = ftLinearGradient) and
              IsSameSingle(G1.x1, G2.x1) and
              IsSameSingle(G1.x2, G2.x2) and
              IsSameSingle(G1.y1, G2.y1) and
              IsSameSingle(G1.y2, G2.y2);
  end;

  function IsSameRadialData: Boolean;
  begin
    Result := (G1.FillerType = ftRadialGradient) and
              (G2.FillerType = ftRadialGradient) and
              IsSameSingle(G1.cx, G2.cx) and
              IsSameSingle(G1.cy, G2.cy) and
              IsSameSingle(G1.fr, G2.fr) and
              IsSameSingle(G1.fx, G2.fx) and
              IsSameSingle(G1.fy, G2.fy) and
              IsSameSingle(G1.r, G2.r);
  end;

begin
  Result := (IsSameLinearData or IsSameRadialData) and
            (G1.gradientUnits = G2.gradientUnits) and
            (G1.spreadMethod = G2.spreadMethod) and
            IsSameBounds(G1.UserBounds, G2.UserBounds) and
            IsSameTransform(G1.gradientTransform, G2.gradientTransform) and
            IsSameGradientArray(G1.GradientArray, G2.GradientArray);
end;

function IsSameSVGColor(F1, F2: TSVGColor): Boolean;
begin
  Result := (F1.R = F2.R) and (F1.G = F2.G) and (F1.B = F2.B) and IsSameSingle(F1.Alpha, F2.Alpha);
end;

function IsSamePreserveAspectRatio(PAR1, PAR2: TSVGPreserveAspectRatio): Boolean;
begin
  Result := (PAR1.Align = PAR2.Align) and (PAR1.MeetOrSlice = PAR2.MeetOrSlice);
end;

function IsSamePattern(P1, P2: TSVGPatternData): Boolean;
begin
  Result := (P1.Bitmap = P2.Bitmap) and
            IsSameSingle(P1.x, P2.x) and
            IsSameSingle(P1.y, P2.y) and
            IsSameSingle(P1.Width, P2.Width) and
            IsSameSingle(P1.Height, P2.Height);
end;

function ToSVGGradientStopData(SVGColor: TSVGColor; Offset: Single): TSVGGradientStopData;
begin
  Result.SVGColor := SVGColor;
  Result.Offset := Offset;
end;

{ TSVGGPGraphicsPath }

procedure TSVGCanvasPath.AddBezier(p1, p2, p3, p4: TSinglePoint);
begin
  AddBezier(p1.X, p1.Y, p2.X, p2.Y, p3.X, p3.Y, p4.X, p4.Y);
end;

procedure TSVGCanvasPath.AddLine(p1, p2: TSinglePoint);
begin
  AddLine(p1.X, p1.Y, p2.X, p2.Y);
end;

procedure TSVGCanvasPath.AddRectangle(Bounds: TSingleBounds; rx, ry: Single);
begin
  with Bounds do
    AddRectangle(x, y, width, height, rx, ry);
end;

constructor TSVGCanvasPath.Create;
begin
  Matrix := tmIdentity;
end;

{ TSVGCanvas }

class procedure TSVGCanvas.AddStringToPath(st: string; Path: TSVGCanvasPath; Decorations: TTextDecorations; TextOrigin: TTextOrigin; FontData: TSVGFontData);
begin
  // Empty
end;

class function TSVGCanvas.CreateImage(SA: TStreamAdapter): TSVGCanvasImage;
begin
  Result := nil;
end;

class function TSVGCanvas.CreatePath: TSVGCanvasPath;
begin
  Result := nil;
end;

class function TSVGCanvas.CreatePathText(Path: TSVGCanvasPath): TSVGCanvasPathText;
begin
  Result := nil;
end;

destructor TSVGCanvas.Destroy;
var
  dt: TSVGDrawType;
begin
  for dt := Low(TSVGDrawType) to High(TSVGDrawType) do
    FPatternData[dt].Bitmap.Free;

  inherited Destroy;
end;

class function TSVGCanvas.GetFont(FontData: TSVGFontData): TFont;
begin
  Result := nil;
end;

class function TSVGCanvas.GetPathLength(const Path: TSVGCanvasPath): Single;
begin
  Result := 0.0;
end;

procedure TSVGCanvas.PaintPath(Path: TSVGCanvasPath; FillRule: TSVGSpecificWord);
begin
  if Path <> nil then
  begin
    Path.FillRule := FillRule;
    FillPath(Path);
    StrokePath(Path);
  end;
end;

procedure TSVGCanvas.SetGradient(DrawType: TSVGDrawType; GradientData: TSVGGradientData);
begin
  FFillerType[DrawType] := GradientData.FillerType;
  if not IsSameGradient(FGradientData[DrawType], GradientData) then
  begin
    FGradientData[DrawType] := GradientData;
    with FGradientData[DrawType] do
    begin
      SetLength(GradientArray, Length(GradientData.GradientArray));
      Move(GradientData.GradientArray[0], GradientArray[0], SizeOf(GradientArray[0]) * Length(GradientArray));
    end;

    case FFillerType[DrawType] of
      ftLinearGradient: ChangeLinearGradientFiller(DrawType);
      ftRadialGradient: ChangeRadialGradientFiller(DrawType);
    end;
  end;
end;

procedure TSVGCanvas.SetPattern(DrawType: TSVGDrawType; PatternData: TSVGPatternData);
begin
  FFillerType[DrawType] := ftPattern;
  if not IsSamePattern(FPatternData[DrawType], PatternData) then
  begin
    FPatternData[DrawType].Bitmap.Free;
    FPatternData[DrawType] := PatternData;
    ChangePatternFiller(DrawType);
  end;
end;

procedure TSVGCanvas.SetSolidColor(DrawType: TSVGDrawType; SVGColor: TSVGColor);
begin
  FFillerType[DrawType] := ftSolidColor;
  if not IsSameSVGColor(FSolidColorData[DrawType], SVGColor) then
  begin
    FSolidColorData[DrawType] := SVGColor;
    ChangeSolidColorFiller(DrawType);
  end;
end;

end.
