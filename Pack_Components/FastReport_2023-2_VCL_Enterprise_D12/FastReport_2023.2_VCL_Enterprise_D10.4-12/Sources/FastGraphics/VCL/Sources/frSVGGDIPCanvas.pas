
{******************************************}
{                                          }
{             FastReport VCL               }
{             SVG GDI+ Canvas              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGGDIPCanvas;

interface

{$I frVer.inc}

uses
  Windows,
  Graphics,
  Classes,
  Types,
{$IFDEF DELPHI16}
  System.UITypes,
  Winapi.GDIPOBJ,
  Winapi.GDIPAPI,
{$ELSE}
  frGDIPOBJ,
  frGDIPAPI,
{$ENDIF}
  frGDIPPathText,
  frSVGColor,
  frSVGCanvas,
  frSVGHelpers,
  frSVGComponents;

type
  TSVGGDIPCanvas = class(TSVGCanvas)
  private
    FPen: TGPPen;
    FGPMatrix: TGPMatrix;
    FGraphics: TGPGraphics;
  protected
    FColors: packed array of ARGB;
    FPositions: packed array of Single;

    procedure CalcGradientData(SVGGradientArray: TSVGGradientArray);
    function GetStringSize(WS: WideString; Font: TGPFont): TSingleSize;
    procedure SetElementsGPMatrix(const Matrix: TSVGTransform);

    class function GetGPFont(FontData: TSVGFontData; out FontHeight: Single): TGPFont;
    class function GDIPLineJoin(SVGLineJoin: TSVGSpecificWord): TLineJoin;
    class function GDIPLineCap(SVGLineCap: TSVGSpecificWord): TLineCap;
    class function GDIPFontStyle(FontData: TSVGFontData): TFontStyle;
    class function GDIPFillMode(FillRule:  TSVGSpecificWord): TFillMode;
    class function ConvertColor(SVGColor: TSVGColor): Cardinal;
    class function ProjectionOfPointToLine(L1, L2, P: TSinglePoint): TSinglePoint;
    class function Distance(const x1, y1, x2, y2: Single): Single; overload;
    class function Distance(const P1, P2: TSinglePoint): Single; overload;
  protected
    FSolidColor: array [TSVGDrawType] of TGPSolidBrush;
    FLinearGradient: array [TSVGDrawType] of TGPLinearGradientBrush;
    FRadialGradient: array [TSVGDrawType] of TGPPathGradientBrush;
    FPattern: array [TSVGDrawType] of TGPTextureBrush;

    procedure ChangeSolidColorFiller(DrawType: TSVGDrawType); override;

    procedure ChangeLinearGradientFiller(DrawType: TSVGDrawType); override;
    procedure WidenTile(var GA: TSVGGradientArray;
      const WidenAddStart, WidenAddFinish: Integer;
      var WidenStart, WidenFinish: TSinglePoint);

    procedure ChangeRadialGradientFiller(DrawType: TSVGDrawType); override;
    procedure WidenRadius(var GA: TSVGGradientArray; out Radius: TSinglePoint;
      const ObjBounds: TSingleBounds; const cx, cy, r: Single);

    procedure ChangePatternFiller(DrawType: TSVGDrawType); override;

    procedure StrokePath(Path: TSVGCanvasPath); override;
    procedure FillPath(Path: TSVGCanvasPath); override;

    function CreateGPBitmapFromBitmap(const Bitmap: TBitmap; Offset: TPoint): TGPBitmap; overload;
    function CreateGPBitmapFromBitmap(const Bitmap: TBitmap): TGPBitmap; overload;
    function LoadGPImageFromGraphic(const Graphic: TGraphic; out Stream: TMemoryStream): TGpImage;
  public
    constructor Create(DC: HDC); override;
    destructor Destroy; override;

    procedure SetTransform(const Matrix: TSVGTransform); override;
    procedure GetTransform(out Matrix: TSVGTransform); override;
    procedure ResetTransform; override;

    procedure SetClip(Path: TSVGCanvasPath); override;
    procedure IntersectClip(Path: TSVGCanvasPath); override;
    procedure ResetClip; override;

    procedure SetStroke(StrokeData: TSVGStrokeData); override;

    function MeasureString(st: string; FontData: TSVGFontData;
      out FontHeight: Single): TSingleSize; override;

    procedure DrawImage(FImage: TSVGCanvasImage; SVGRect: TSingleBounds; FillOpacity: Single); override;

    class procedure AddStringToPath(st: string; Path: TSVGCanvasPath; Decorations: TTextDecorations;
      TextOrigin: TTextOrigin; FontData: TSVGFontData); override;

    class function GetFontFamily(const FontName: string): TGPFontFamily;

    class function CreateImage(SA: TStreamAdapter): TSVGCanvasImage; override;
    class function CreatePath: TSVGCanvasPath; override;
    class function CreatePathText(Path: TSVGCanvasPath): TSVGCanvasPathText; override;
    class function GetPathLength(const Path: TSVGCanvasPath): Single; override;

    class function GetFont(FontData: TSVGFontData): TFont; override;
  end;

implementation

uses
  SysUtils, Math,
  frGDIPKerning, frUtils;

type
  TSVGGDIPImage = class(TSVGCanvasImage)
  private
    FGPImage: TGPImage;
  public
    constructor Create(SA: TStreamAdapter); override;
    destructor Destroy; override;
    function GetWidth: Cardinal; override;
    function GetHeight: Cardinal; override;
  end;

  TSVGGDIGraphicsPath = class(TSVGCanvasPath)
  private
    FGPGraphicsPath: TGPGraphicsPath;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Clone: TSVGCanvasPath; override;
    procedure Transform(const Matrix: TSVGTransform); override;
    function Bounds: TSingleBounds; override;

    procedure AddArc(x, y, width, height, startAngle, sweepAngle: Single); override;
    procedure AddBezier(x1, y1, x2, y2, x3, y3, x4, y4: Single); override;
    procedure AddCircle(cx, cy, r: Single); override;
    procedure AddEllipse(cx, cy, rx, ry: Single); override;
    procedure AddLine(x1, y1, x2, y2: Single); override;
    procedure AddPath(addingPath: TSVGCanvasPath; connect: Bool); override;
    procedure AddRectangle(x, y, width, height, rx, ry: Single); override;
    procedure CloseFigure; override;
    procedure StartFigure; override;

    function Log: string; override;
  end;

  TSVGGDIPGraphicsPathText = class(TSVGCanvasPathText)
  private
    GPPathText: TGPPathText;
  public
    constructor Create(Path: TSVGCanvasPath);

    function AddPathText(const Path: TSVGCanvasPath;
      const Text: string; const Indent: Single; FontData: TSVGFontData;
      const DistanceFactor: Single = 1; const KerningFactor: Single = 1): Single; override;

    destructor Destroy; override;
  end;

{ Utility routines }

function GetGPMatrix(const Matrix: TSVGTransform): TGPMatrix;
begin
  with Matrix do
    Result := TGPMatrix.Create(a, b, c, d, e, f);
end;

{ TSVGGDIPlusCanvas }

procedure TSVGGDIPCanvas.CalcGradientData(SVGGradientArray: TSVGGradientArray);
var
  Len, i: Integer;
begin
  Len := Length(SVGGradientArray);
  SetLength(FColors, Len);
  SetLength(FPositions, Len);
  for i := 0 to Len - 1 do
  begin
    FColors[i] := ConvertColor(SVGGradientArray[i].SVGColor);
    FPositions[i] := SVGGradientArray[i].Offset;
  end;
end;

procedure TSVGGDIPCanvas.ChangeLinearGradientFiller(DrawType: TSVGDrawType);
var
  GD: TSVGGradientData;
  Start, Intermediate, BaseStart, BaseFinish, Finish, Part1, Part2: TSinglePoint;
  WidenStart, WidenFinish: TSinglePoint;
  GA: TSVGGradientArray;
  i: Integer;
  AddStart, AddFinish: Integer;
  Base, Factor: Single;
  BoundsRect, GradRect: TSingleRect;
  M: TSVGTransform;
begin
  GD := FGradientData[DrawType];

  BoundsRect := ToSingleRect(GD.UserBounds);
  GradRect := ToSingleRect(GD.x1, GD.y1, GD.x2, GD.y2);

  if GD.gradientUnits = svg_userSpaceOnUse then
  begin
    AddStart := frIfInt(IsSameSingle(GradRect.Left, BoundsRect.Left) and
                      IsSameSingle(GradRect.Top, BoundsRect.Top), 0, 1);
    AddFinish := frIfInt(IsSameSingle(GradRect.Right, BoundsRect.Right) and
                       IsSameSingle(GradRect.Bottom, BoundsRect.Bottom), 0, 1);

    Start := GradRect.TopLeft;
    Finish := GradRect.BottomRight;

    BaseStart := GradRect.TopLeft;
    BaseFinish := GradRect.BottomRight;
  end
  else
  begin
    if      IsSameSingle(GradRect.Left, GradRect.Right) then
    begin
      AddStart := frIfInt(IsSameSingle(GradRect.Top, BoundsRect.Top), 0, 1);
      AddFinish := frIfInt(IsSameSingle(GradRect.Bottom, BoundsRect.Bottom), 0, 1);

      Start := BoundsRect.TopLeft;
      Finish := ToSinglePoint(BoundsRect.Left, BoundsRect.Bottom);

      BaseStart := GradRect.TopLeft;
      BaseFinish := GradRect.BottomRight;
    end
    else if IsSameSingle(GradRect.Top, GradRect.Bottom) then
    begin
      AddStart := frIfInt(IsSameSingle(GradRect.Left, BoundsRect.Left), 0, 1);
      AddFinish := frIfInt(IsSameSingle(GradRect.Right, BoundsRect.Right), 0, 1);

      Start := BoundsRect.TopLeft;
      Finish := ToSinglePoint(BoundsRect.Right, BoundsRect.Top);

      BaseStart := GradRect.TopLeft;
      BaseFinish := GradRect.BottomRight;
    end
    else
    begin
      AddStart := frIfInt(IsSameSingle(GradRect.Left, BoundsRect.Left) and
                        IsSameSingle(GradRect.Top, BoundsRect.Top), 0, 1);
      AddFinish := frIfInt(IsSameSingle(GradRect.Right, BoundsRect.Right) and
                         IsSameSingle(GradRect.Bottom, BoundsRect.Bottom), 0, 1);

      Start := BoundsRect.TopLeft;

      Part1.X := (GradRect.Top - BoundsRect.Top) / GD.UserBounds.Height; // X <-> Y !
      Part1.Y := (GradRect.Left - BoundsRect.Left) / GD.UserBounds.Width;
      Part2.X := (GradRect.Bottom - BoundsRect.Top) / GD.UserBounds.Height;
      Part2.Y := (GradRect.Right - BoundsRect.Left) / GD.UserBounds.Width;

      Intermediate := ProjectionOfPointToLine(
        ToSinglePoint(BoundsRect.Left + Part1.X * GD.UserBounds.Width,
                      BoundsRect.Top + Part2.Y * GD.UserBounds.Height),
        ToSinglePoint(BoundsRect.Left + Part2.X * GD.UserBounds.Width,
                      BoundsRect.Top + Part1.Y * GD.UserBounds.Height),
        Start);

      Finish := ProjectionOfPointToLine(Start, Intermediate, BoundsRect.BottomRight);

      BaseStart := ProjectionOfPointToLine(Start, Intermediate, GradRect.TopLeft);
      BaseFinish := ProjectionOfPointToLine(Start, Intermediate, GradRect.BottomRight);
    end;
  end;

  Base := Distance(Start, BaseStart) / Distance(Start, Finish);
  Factor := Distance(BaseStart, BaseFinish) / Distance(Start, Finish);

  SetLength(GA, Length(GD.GradientArray) + AddStart + AddFinish);

  for i := 0 to High(GD.GradientArray) do
  begin
    GA[i + AddStart].SVGColor := GD.GradientArray[i].SVGColor;
    GA[i + AddStart].Offset := Base + GD.GradientArray[i].Offset * Factor;
  end;

  if High(GA) >= 0 then
  begin
    GA[0] := ToSVGGradientStopData(GA[0 + AddStart].SVGColor, 0.0);
    GA[High(GA)] := ToSVGGradientStopData(GA[High(GA) - AddFinish].SVGColor, 1.0);
  end;

(******************************************************************************)

  WidenStart := Start;
  WidenFinish := Finish;
  WidenTile(GA, 1 - AddStart, 1 - AddFinish, WidenStart, WidenFinish);

  CalcGradientData(GA);

  FLinearGradient[DrawType].Free;

  FLinearGradient[DrawType] := TGPLinearGradientBrush.Create(
    MakePoint(WidenStart.X, WidenStart.Y), MakePoint(WidenFinish.X, WidenFinish.Y), 0, 0);
//  case GD.spreadMethod of
//    svg_pad:
//      FLinearGradient[DrawType] := TGPLinearGradientBrush.Create(
//        MakePoint(WidenStart.X, WidenStart.Y), MakePoint(WidenFinish.X, WidenFinish.Y), 0, 0);
//    svg_reflect:
//      FLinearGradient[DrawType] := TGPLinearGradientBrush.Create(
//        MakePoint(BaseStart.X, BaseStart.Y), MakePoint(BaseFinish.X, BaseFinish.Y), 0, 0);
//    svg_repeat:
//      FLinearGradient[DrawType] := TGPLinearGradientBrush.Create(
//        MakePoint(BaseStart.X, BaseStart.Y), MakePoint(BaseFinish.X, BaseFinish.Y), 0, 0);
//  end;


//  {$EXTERNALSYM WrapMode}
//  WrapMode = (
//    WrapModeTile,        // 0
//    WrapModeTileFlipX,   // 1
//    WrapModeTileFlipY,   // 2
//    WrapModeTileFlipXY,  // 3
//    WrapModeClamp        // 4
//  );
//  TWrapMode = WrapMode;
//  {$EXTERNALSYM TWrapMode}
//  case GD.spreadMethod of
//    svg_pad:     FLinearGradient[DrawType].SetWrapMode(WrapModeTileFlipXY);
//    svg_reflect: FLinearGradient[DrawType].SetWrapMode(WrapModeTileFlipXY);
//    svg_repeat:  FLinearGradient[DrawType].SetWrapMode(WrapModeTile);
//  end;
  FLinearGradient[DrawType].SetWrapMode(WrapModeTileFlipX);

  M := GD.gradientTransform;
  SetElementsGPMatrix(M);
  FLinearGradient[DrawType].MultiplyTransform(FGPMatrix, MatrixOrderAppend);

  FLinearGradient[DrawType].SetInterpolationColors(PGPColor(FColors), PSingle(FPositions), Length(FColors));
end;

procedure TSVGGDIPCanvas.ChangePatternFiller(DrawType: TSVGDrawType);
var
  PD: TSVGPatternData;
  GPMatrix: TGPMatrix;
  Matrix: TSVGTransform;
begin
  PD := FPatternData[DrawType];

  FPattern[DrawType].Free;
  if PD.Bitmap <> nil then
  begin
    FPattern[DrawType] := TGPTextureBrush.Create(
      CreateGPBitmapFromBitmap(PD.Bitmap));

    Matrix := tmIdentity;
    Matrix := tmMultiply(PD.Matrix, Matrix); // !First
    Matrix := tmMultiply(tmTranslation(PD.Offset.X, PD.Offset.Y), Matrix);
    Matrix := tmMultiply(tmScaling(PD.Factor), Matrix);

    if not IsSameTransform(tmIdentity, Matrix) then
    begin
      GPMatrix := TGPMatrix.Create;
      try
        with Matrix do
          GPMatrix.SetElements(a, b, c, d, e, f);

        FPattern[DrawType].SetTransform(GPMatrix);
      finally
        GPMatrix.Free;
      end;
    end;
  end;
end;

procedure TSVGGDIPCanvas.ChangeRadialGradientFiller(DrawType: TSVGDrawType);
const
  InvertColors = True;
var
  GD: TSVGGradientData;
  Path: TSVGGDIGraphicsPath;
  GA: TSVGGradientArray;
  Radius: TSinglePoint;
  Scale: TSinglePoint;
  M: TSVGTransform;
  Diagonal: Single;
begin
  GD := FGradientData[DrawType];

  SetLength(GA, Length(GD.GradientArray));
  Move(GD.GradientArray[0], GA[0], Length(GA) * SizeOf(GA[0]));

  WidenRadius(GA, Radius, GD.UserBounds, GD.cx, GD.cy, GD.r);

  if GD.gradientUnits = svg_objectBoundingBox then
  begin
    Diagonal := Sqrt((Sqr(GD.UserBounds.Width) + Sqr(GD.UserBounds.Height)) / 2);
    Scale := ToSinglePoint(GD.UserBounds.Width / Diagonal,
                           GD.UserBounds.Height / Diagonal);
    Scale.X := frIfReal(IsSameSingle(Scale.X, 0), 1.0, Scale.X);
    Scale.Y := frIfReal(IsSameSingle(Scale.Y, 0), 1.0, Scale.Y);
    Radius := ToSinglePoint(Radius.X * Scale.X, Radius.Y * Scale.Y);
  end;

  Path := TSVGGDIGraphicsPath.Create;
  try
    Path.AddEllipse(GD.cx, GD.cy, Radius.X, Radius.Y);
    FRadialGradient[DrawType].Free;
    FRadialGradient[DrawType] := TGPPathGradientBrush.Create(Path.FGPGraphicsPath);
  finally
    Path.Free;
  end;
//  {$EXTERNALSYM WrapMode}
//  WrapMode = (
//    WrapModeTile,        // 0
//    WrapModeTileFlipX,   // 1
//    WrapModeTileFlipY,   // 2
//    WrapModeTileFlipXY,  // 3
//    WrapModeClamp        // 4
//  );
//  TWrapMode = WrapMode;
//  {$EXTERNALSYM TWrapMode}
//  case GD.spreadMethod of
//    svg_pad:     FLinearGradient[DrawType].SetWrapMode(WrapModeTileFlipXY);
//    svg_reflect: FLinearGradient[DrawType].SetWrapMode(WrapModeTileFlipXY); { TODO : Тут размеры не увеличивать!? }
//    svg_repeat:  FLinearGradient[DrawType].SetWrapMode(WrapModeTile);
//  end;
  FRadialGradient[DrawType].SetWrapMode(WrapModeTileFlipX);

  CalcGradientData(GA);

  FRadialGradient[DrawType].SetInterpolationColors(PARGB(FColors), PSingle(FPositions), Length(FColors));

  M := GD.gradientTransform;
  SetElementsGPMatrix(M);
  FRadialGradient[DrawType].MultiplyTransform(FGPMatrix, MatrixOrderAppend);

  FRadialGradient[DrawType].SetCenterPoint(MakePoint(GD.fx, GD.fy));
end;

procedure TSVGGDIPCanvas.ChangeSolidColorFiller(DrawType: TSVGDrawType);
begin
  FSolidColor[DrawType].Free;
  FSolidColor[DrawType] := TGPSolidBrush.Create(ConvertColor(FSolidColorData[DrawType]));
end;

class function TSVGGDIPCanvas.ConvertColor(SVGColor: TSVGColor): Cardinal;
begin
  with SVGColor do
    Result := MakeColor(Round(255 * Alpha), R, G, B);
end;

constructor TSVGGDIPCanvas.Create(DC: HDC);
begin
  FGPMatrix := TGPMatrix.Create;
  FGraphics := TGPGraphics.Create(DC);
  FGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
  FGraphics.SetPageUnit(UnitPixel);
end;

function TSVGGDIPCanvas.CreateGPBitmapFromBitmap(const Bitmap: TBitmap): TGPBitmap;
var
  OutData, InData: PRGBQuad;
  BitmapData: TBitmapData;
  i, h, Step: Integer;
begin
  Result := TGPbitmap.Create(Bitmap.Width, Bitmap.Height, PixelFormat32bppARGB);

  Result.LockBits(MakeRect(0, 0, Bitmap.Width, Bitmap.Height),
    ImageLockModeWrite, PixelFormat32bppPARGB, BitmapData);
  try
    OutData := BitmapData.Scan0;

    if IsBitmapBottomUp(Bitmap) then
    begin
      h := 0;
      Step := 1;
    end
    else
    begin
      h := Bitmap.Height - 1;
      Step := -1;
    end;

    for i := 0 to Bitmap.Height - 1 do
    begin
      InData := Bitmap.ScanLine[h];
      Move(InData^, OutData^, Bitmap.Width * SizeOf(RGBQuad));
      Inc(OutData, Bitmap.Width);
      h := (h + Step + Bitmap.Height) mod Bitmap.Height;
    end;
  finally
    Result.UnlockBits(BitmapData);
  end;
end;

function TSVGGDIPCanvas.CreateGPBitmapFromBitmap(const Bitmap: TBitmap; Offset: TPoint): TGPBitmap;
var
  OutData, InData: PRGBQuad;
  BitmapData: TBitmapData;
  i, h, Step, Part1Len, Part2Len: Integer;
begin
  Result := TGPbitmap.Create(Bitmap.Width, Bitmap.Height, PixelFormat32bppARGB);

  Result.LockBits(MakeRect(0, 0, Bitmap.Width, Bitmap.Height),
    ImageLockModeWrite, PixelFormat32bppPARGB, BitmapData);
  try
    OutData := BitmapData.Scan0;

    if IsBitmapBottomUp(Bitmap) then
    begin
      h := Offset.Y;
      Step := 1;
    end
    else
    begin
      h := Bitmap.Height - 1 - Offset.Y;
      Step := -1;
    end;

    Part1Len := Offset.X;
    Part2Len := Bitmap.Width - Offset.X;
    for i := 0 to Bitmap.Height - 1 do
    begin
      InData := Bitmap.ScanLine[h];
      Inc(InData, Part1Len);
      Move(InData^, OutData^, Part2Len * SizeOf(RGBQuad));
      Inc(OutData, Part2Len);

      InData := Bitmap.ScanLine[h];
      Move(InData^, OutData^, Part1Len * SizeOf(RGBQuad));
      Inc(OutData, Part1Len);

      h := (h + Step + Bitmap.Height) mod Bitmap.Height;
    end;
  finally
    Result.UnlockBits(BitmapData);
  end;
end;

class function TSVGGDIPCanvas.CreateImage(SA: TStreamAdapter): TSVGCanvasImage;
begin
  Result := TSVGGDIPImage.Create(SA);
end;

class function TSVGGDIPCanvas.CreatePath: TSVGCanvasPath;
begin
  Result := TSVGGDIGraphicsPath.Create;
end;

class function TSVGGDIPCanvas.CreatePathText(Path: TSVGCanvasPath): TSVGCanvasPathText;
begin
  Result := TSVGGDIPGraphicsPathText.Create(Path);
end;

destructor TSVGGDIPCanvas.Destroy;
var
  dt: TSVGDrawType;
begin
  FPen.Free;
  FGPMatrix.Free;

  for dt := Low(TSVGDrawType) to High(TSVGDrawType) do
  begin
    FSolidColor[dt].Free;
    FLinearGradient[dt].Free;
    FRadialGradient[dt].Free;
    FPattern[dt].Free;
  end;

  FGraphics.Free;

  Finalize(FColors);
  Finalize(FPositions);

  inherited Destroy;
end;

class function TSVGGDIPCanvas.Distance(const P1, P2: TSinglePoint): Single;
begin
  Result := Distance(P1.X, P1.Y, P2.X, P2.Y);
end;

class function TSVGGDIPCanvas.Distance(const x1, y1, x2, y2: Single): Single;
begin
  Result := Sqrt(Sqr(x1 - x2) + Sqr(y1 - y2));
end;

procedure TSVGGDIPCanvas.DrawImage(FImage: TSVGCanvasImage; SVGRect: TSingleBounds; FillOpacity: Single);
var
  ImAtt: TGPImageAttributes;
  ColorMatrix: TColorMatrix;
begin
  FillChar(ColorMatrix, Sizeof(ColorMatrix), 0);
  ColorMatrix[0, 0] := 1;
  ColorMatrix[1, 1] := 1;
  ColorMatrix[2, 2] := 1;
  ColorMatrix[3, 3] := FillOpacity;
  ColorMatrix[4, 4] := 1;

  ImAtt := TGPImageAttributes.Create;
  try
    ImAtt.SetColorMatrix(colorMatrix, ColorMatrixFlagsDefault, ColorAdjustTypeDefault);
    FGraphics.DrawImage(TSVGGDIPImage(FImage).FGPImage,
      MakeRect(SVGRect.X, SVGRect.Y, SVGRect.Width, SVGRect.Height), 0, 0,
      FImage.GetWidth, FImage.GetHeight, UnitPixel, ImAtt);
  finally
    ImAtt.Free;
  end;

end;

procedure TSVGGDIPCanvas.StrokePath(Path: TSVGCanvasPath);
begin
  if Assigned(FPen) and (FPen.GetLastStatus = OK) then
    FGraphics.DrawPath(FPen, TSVGGDIGraphicsPath(Path).FGPGraphicsPath);
end;

procedure TSVGGDIPCanvas.WidenRadius(var GA: TSVGGradientArray; out Radius: TSinglePoint;
  const ObjBounds: TSingleBounds; const cx, cy, r: Single);
const
  MaxFactor = 1000.0;
  MinRadius = 0.0001;
var
  MaxDistance, Factor: Single;
  Temp: TSVGGradientStopData;
  i, WidenLen: Integer;
  WidenGA: TSVGGradientArray;
begin
  MaxDistance := MaxValue([
    Distance(cx, cy, ObjBounds.X, ObjBounds.Y),
    Distance(cx, cy, ObjBounds.X + ObjBounds.Width, ObjBounds.Y),
    Distance(cx, cy, ObjBounds.X, ObjBounds.Y + ObjBounds.Height),
    Distance(cx, cy, ObjBounds.X + ObjBounds.Width, ObjBounds.Y + ObjBounds.Height)]);
  if      r >= MaxDistance then
  begin
    Factor := 1.0;
    Radius := ToSinglePoint(r, r);
  end
  else if r < MinRadius then
  begin
    Factor := MaxFactor;
    Radius := ToSinglePoint(MaxDistance, MaxDistance);
  end
  else
  begin
    Factor := MaxDistance / r;
    if not IsSameSingle(Min(ObjBounds.Width, ObjBounds.Height), 0.0) then
      if      ObjBounds.Width < ObjBounds.Height then
        Factor := Factor * ObjBounds.Height / ObjBounds.Width
      else
        Factor := Factor * ObjBounds.Width / ObjBounds.Height;
    Factor := Min(Factor, MaxFactor);
    Radius := ToSinglePoint(r * Factor, r * Factor);
  end;

  for i := 0 to High(GA) div 2 do
  begin
    Temp := GA[i];
    GA[i] := GA[High(GA) - i];
    GA[High(GA) - i] := Temp;
  end;

  for i := 0 to High(GA) do
    GA[i].Offset := 1.0 - GA[i].Offset / Factor;

  WidenLen := Length(GA) + 2;
  SetLength(WidenGA, WidenLen);
  Move(GA[0], WidenGA[1], Length(GA) * SizeOf(GA[0]));
  WidenGA[0] := ToSVGGradientStopData(WidenGA[1].SVGColor, 0.0);
  WidenGA[WidenLen - 1] := ToSVGGradientStopData(WidenGA[WidenLen - 2].SVGColor, 1.0);

  SetLength(GA, WidenLen);
  Move(WidenGA[0], GA[0], WidenLen * SizeOf(GA[0]));
end;

procedure TSVGGDIPCanvas.WidenTile(var GA: TSVGGradientArray;
  const WidenAddStart, WidenAddFinish: Integer;
  var WidenStart, WidenFinish: TSinglePoint);
const
  Factor = 10;
var
  Center: TSinglePoint;
  i, WidenLen: Integer;
  WidenGA: TSVGGradientArray;
begin
  Center := ToSinglePoint((WidenStart.X + WidenFinish.X) / 2.0,
                          (WidenStart.Y + WidenFinish.Y) / 2.0);
  WidenStart := ToSinglePoint((WidenStart.X - Center.X) * Factor + Center.X,
                              (WidenStart.Y - Center.Y) * Factor + Center.Y);
  WidenFinish := ToSinglePoint((WidenFinish.X - Center.X) * Factor + Center.X,
                               (WidenFinish.Y - Center.Y) * Factor + Center.Y);

  WidenLen := Length(GA) + WidenAddStart + WidenAddFinish;
  SetLength(WidenGA, WidenLen);

  for i := 0 to High(GA) do
  begin
    WidenGA[i + WidenAddStart].Offset := (GA[i].Offset - 0.5) / Factor + 0.5;
    WidenGA[i + WidenAddStart].SVGColor := GA[i].SVGColor;
  end;

  WidenGA[0] := ToSVGGradientStopData(WidenGA[0 + WidenAddStart].SVGColor, 0.0);
  WidenGA[WidenLen - 1] := ToSVGGradientStopData(WidenGA[WidenLen - 1 - WidenAddFinish].SVGColor, 1.0);

  SetLength(GA, WidenLen);
  Move(WidenGA[0], GA[0], WidenLen * SizeOf(GA[0]));
end;

procedure TSVGGDIPCanvas.FillPath(Path: TSVGCanvasPath);

  procedure Fill(B: TGPBrush);
  var
    GPPlusPath: TSVGGDIGraphicsPath;
    GPPath: TGPGraphicsPath;
  begin
    if Assigned(B) and (B.GetLastStatus = OK) then
    begin
      GPPlusPath := TSVGGDIGraphicsPath(Path);
      GPPath := GPPlusPath.FGPGraphicsPath;
      GPPath.SetFillMode(GDIPFillMode(GPPlusPath.FillRule));
      FGraphics.FillPath(B, GPPath);
    end;
  end;
begin
  case FFillerType[dtFill] of
    ftSolidColor:
      Fill(FSolidColor[dtFill]);
    ftLinearGradient:
      Fill(FLinearGradient[dtFill]);
    ftRadialGradient:
      Fill(FRadialGradient[dtFill]);
    ftPattern:
      Fill(FPattern[dtFill]);
  end;
end;

class function TSVGGDIPCanvas.GDIPFillMode(FillRule: TSVGSpecificWord): TFillMode;
begin
  Result := FillModeWinding;
  case FillRule of
    svg_evenodd: Result := FillModeAlternate;
    svg_nonzero: Result := FillModeWinding;
  end;
end;

class function TSVGGDIPCanvas.GDIPFontStyle(FontData: TSVGFontData): TFontStyle;
begin
  Result := FontStyleRegular;

  if FontData.Weight >= FW_SEMIBOLD then
    Result := Result or FontStyleBold;

  if FontData.Style in [svg_Italic, svg_Oblique] then
    Result := Result or FontStyleItalic;

  if svg_underline in FontData.Decoration then
    Result := Result or FontStyleUnderline;

  if svg_line_through in FontData.Decoration then
    Result := Result or FontStyleStrikeout;
end;

class function TSVGGDIPCanvas.GDIPLineCap(SVGLineCap: TSVGSpecificWord): TLineCap;
begin
  case SVGLineCap of
    svg_butt:   Result := LineCapFlat;
    svg_round:  Result := LineCapRound;
    svg_square: Result := LineCapSquare;
  else
    raise Exception.Create('Unknown SVGLineCap');
  end;
end;

class function TSVGGDIPCanvas.GDIPLineJoin(SVGLineJoin: TSVGSpecificWord): TLineJoin;
begin
  case SVGLineJoin of
    svg_arcs:
      Result := LineJoinMiterClipped;
    svg_bevel:
      Result := LineJoinBevel;
    svg_miter:
      Result := LineJoinMiterClipped; // LineJoinMiter;
    svg_miter_clip:
      Result := LineJoinMiterClipped;
    svg_round:
      Result := LineJoinRound;
  else
    raise Exception.Create('Unknown SVGLineJoin');
  end;
end;

class function TSVGGDIPCanvas.GetGPFont(FontData: TSVGFontData; out FontHeight: Single): TGPFont;
var
  FF: TGPFontFamily;
  FontStyle: TFontStyle;
begin
  FF := GetFontFamily(FontData.Names);

  FontStyle := GDIPFontStyle(FontData);

  FontHeight := FF.GetCellAscent(FontStyle) / FF.GetEmHeight(FontStyle);
  FontHeight := FontHeight * FontData.Size;

  Result := TGPFont.Create(FF, FontData.Size, FontStyle, UnitPixel);
  FF.Free;
end;

class function TSVGGDIPCanvas.GetFont(FontData: TSVGFontData): TFont;
var
  FF: TGPFontFamily;
  Name: string;
  FS: Integer;
begin
  Result := TFont.Create;

  Result.Size := Round(FontData.Size);

//  GetFontFamily(FontData.Names).GetFamilyName(Name);
  FF := GetFontFamily(FontData.Names);
  try
    FF.GetFamilyName(Name);
  finally
    FF.Free;
  end;
  Result.Name := Name;

  Result.Style := [];
  FS := GDIPFontStyle(FontData);
  if FontStyleBold and FS = FontStyleBold then
    Result.Style := Result.Style + [fsBold];
  if FontStyleItalic and FS = FontStyleItalic then
    Result.Style := Result.Style + [fsItalic];
  if FontStyleUnderline and FS = FontStyleUnderline then
    Result.Style := Result.Style + [fsUnderline];
  if FontStyleStrikeout and FS = FontStyleStrikeout then
    Result.Style := Result.Style + [fsStrikeout];
end;

class function TSVGGDIPCanvas.GetFontFamily(const FontName: string): TGPFontFamily;
begin
  Result := TGPFontFamily.Create(FontName);
  if Result.GetLastStatus <> OK then
  begin
    FreeAndNil(Result);
    Result := TGPFontFamily.Create(SuitableFont(FontName));
    if Result.GetLastStatus <> OK then
      FreeAndNil(Result);
  end;
  if not Assigned(Result) then
    Result := TGPFontFamily.Create('Arial');
end;

class function TSVGGDIPCanvas.GetPathLength(const Path: TSVGCanvasPath): Single;
begin
  Result := TGPPathText.GetPathLength(TSVGGDIGraphicsPath(Path).FGPGraphicsPath);
end;

procedure TSVGGDIPCanvas.SetElementsGPMatrix(const Matrix: TSVGTransform);
begin
  with Matrix do
    FGPMatrix.SetElements(a, b, c, d, e, f);
end;

procedure TSVGGDIPCanvas.GetTransform(out Matrix: TSVGTransform);
var
  M: TGPMatrix;
  MA: TMatrixArray;
begin
  M := TGPMatrix.Create;
  try
    FGraphics.GetTransform(M);
    Matrix := tmIdentity;
    M.GetElements(MA);
    Matrix.a := MA[0];
    Matrix.b := MA[1];
    Matrix.c := MA[2];
    Matrix.d := MA[3];
    Matrix.e := MA[4];
    Matrix.f := MA[5];
  finally
    M.Free;
  end;
end;

procedure TSVGGDIPCanvas.IntersectClip(Path: TSVGCanvasPath);
begin
  FGraphics.SetClip(TSVGGDIGraphicsPath(Path).FGPGraphicsPath, CombineModeIntersect);
end;

function TSVGGDIPCanvas.LoadGPImageFromGraphic(const Graphic: TGraphic; out Stream: TMemoryStream): TGpImage;
var
  SA: TStreamAdapter;
  Image: TGpImage;
begin
  Stream := TMemoryStream.Create;
  Graphic.SaveToStream(Stream);
  Stream.Position := 0;

  Image := TGPImage.Create;
  try
    SA := TStreamAdapter.Create(Stream);
    Result := Image.FromStream(SA);
  finally
    Image.Free;
  end;
end;

type
  TGrayAlpha = record
    Gray: Byte;
    Alpha: Byte;
  end;

function TSVGGDIPCanvas.GetStringSize(WS: WideString; Font: TGPFont): TSingleSize;
var
  BoundingBox: TGPRectF;
  SF: TGPStringFormat;
begin
  SF := TGPStringFormat.Create(StringFormatFlagsMeasureTrailingSpaces);
  try
    FGraphics.MeasureString(WS, -1, Font, MakePoint(0.0, 0), SF, BoundingBox);

    BoundingBox.Width := KerningText.MeasureText(WS, Font);
  finally
    SF.Free;
  end;

  with BoundingBox do
    Result := ToSingleSize(Width, Height);
end;

function TSVGGDIPCanvas.MeasureString(st: string; FontData: TSVGFontData;
  out FontHeight: Single): TSingleSize;
var
  Font: TGPFont;
begin
  Font := GetGPFont(FontData, {out -=>} FontHeight);
  try
    Result := GetStringSize(st, Font);
  finally
    Font.Free;
  end;
end;

class function TSVGGDIPCanvas.ProjectionOfPointToLine(L1, L2, P: TSinglePoint): TSinglePoint;
var
  L, x, y: Single;
begin
  x := L2.Y - L1.Y;
  y := L1.X - L2.X;
  L := (L1.X*L2.Y - L2.X*L1.Y + L1.Y*P.X - L2.Y*P.X + L2.X*P.Y - L1.X*P.Y) / (x*(L2.Y - L1.Y) + y*(L1.X - L2.X));

  Result.X := P.X + x * L;
  Result.Y := P.Y + y * L;
end;

procedure TSVGGDIPCanvas.ResetClip;
begin
  FGraphics.ResetClip;
end;

procedure TSVGGDIPCanvas.ResetTransform;
begin
  FGraphics.ResetTransform;
end;

procedure TSVGGDIPCanvas.SetClip(Path: TSVGCanvasPath);
begin
  FGraphics.SetClip(TSVGGDIGraphicsPath(Path).FGPGraphicsPath);
end;

procedure TSVGGDIPCanvas.SetStroke(StrokeData: TSVGStrokeData);
var
  DashLen, i: Integer;
  DashArr: TSingleDynArray;
  LineCap: TLineCap;
  DashCap: TDashCap;
begin
  if (FFillerType[dtStroke] = ftSolidColor) and Assigned(FSolidColor[dtStroke]) or
     (FFillerType[dtStroke] = ftLinearGradient) and Assigned(FLinearGradient[dtStroke]) or
     (FFillerType[dtStroke] = ftRadialGradient) and Assigned(FRadialGradient[dtStroke]) or
     (FFillerType[dtStroke] = ftPattern) and Assigned(FPattern[dtStroke]) then
  begin
    LineCap := GDIPLineCap(StrokeData.LineCap);
    if LineCap = LineCapRound then
      DashCap := DashCapRound
    else
      DashCap := DashCapFlat;

    FPen := TGPPen.Create(0, StrokeData.Width);
    FPen.SetLineJoin(GDIPLineJoin(StrokeData.LineJoin));
    FPen.SetMiterLimit(StrokeData.Miterlimit);
    FPen.SetLineCap(LineCap, LineCap, DashCap);

    DashLen := Length(StrokeData.Dash.Arr);
    if DashLen > 0 then
    begin
      SetLength(DashArr, DashLen);
      for i := 0 to DashLen - 1 do
        DashArr[i] := StrokeData.Dash.Arr[i] / StrokeData.Width;

      FPen.SetDashPattern(@DashArr[0], DashLen);
      FPen.SetDashStyle(DashStyleCustom);
      FPen.SetDashOffset(StrokeData.Dash.Offset);
    end;

    case FFillerType[dtStroke] of
      ftSolidColor:     FPen.SetBrush(FSolidColor[dtStroke]);
      ftLinearGradient: FPen.SetBrush(FLinearGradient[dtStroke]);
      ftRadialGradient: FPen.SetBrush(FRadialGradient[dtStroke]);
      ftPattern:        FPen.SetBrush(FPattern[dtStroke]);
    end;
  end
  else
    FreeAndNil(FPen);
end;

procedure TSVGGDIPCanvas.SetTransform(const Matrix: TSVGTransform);
begin
  SetElementsGPMatrix(Matrix);
  FGraphics.SetTransform(FGPMatrix);
end;

class procedure TSVGGDIPCanvas.AddStringToPath(st: string; Path: TSVGCanvasPath; Decorations: TTextDecorations;
  TextOrigin: TTextOrigin; FontData: TSVGFontData);

  function ToGPGraphicsPath(CanvasPath: TSVGCanvasPath): TGPGraphicsPath;
  begin
    if CanvasPath = nil then
      Result := nil
    else
      Result := TSVGGDIGraphicsPath(CanvasPath).FGPGraphicsPath;
    end;
var
  FF: TGPFontFamily;
  UnderlineGPPath, LineThrowGPPath, OwerlineGPPath: TGPGraphicsPath;
begin
  FF := GetFontFamily(FontData.Names);

  UnderlineGPPath := ToGPGraphicsPath(Decorations[tdUnderline]);
  LineThrowGPPath := ToGPGraphicsPath(Decorations[tdLineThrow]);
  OwerlineGPPath  := ToGPGraphicsPath(Decorations[tdOwerline]);

  try
    KerningText.AddToPath(TSVGGDIGraphicsPath(Path).FGPGraphicsPath,
      UnderlineGPPath, LineThrowGPPath, OwerlineGPPath, st, FF, GDIPFontStyle(FontData),
      FontData.Size, TextOrigin);
  finally
    FF.Free;
  end;
end;

{ TSVGGDIPlusImage }

constructor TSVGGDIPImage.Create(SA: TStreamAdapter);
begin
  FGPImage := TGPImage.Create(SA);
  FGPImage.GetLastStatus;
end;

destructor TSVGGDIPImage.Destroy;
begin
  FGPImage.Free;

  inherited Destroy;
end;

function TSVGGDIPImage.GetHeight: Cardinal;
begin
  Result := FGPImage.GetHeight;
end;

function TSVGGDIPImage.GetWidth: Cardinal;
begin
  Result := FGPImage.GetWidth;
end;

{ TSVGGDIPlusGraphicsPath }

procedure TSVGGDIGraphicsPath.AddArc(x, y, width, height, startAngle, sweepAngle: Single);
begin
  FGPGraphicsPath.AddArc(x, y, width, height, startAngle, sweepAngle);
end;

procedure TSVGGDIGraphicsPath.AddBezier(x1, y1, x2, y2, x3, y3, x4, y4: Single);
begin
  FGPGraphicsPath.AddBezier(x1, y1, x2, y2, x3, y3, x4, y4);
end;

procedure TSVGGDIGraphicsPath.AddCircle(cx, cy, r: Single);
begin
  FGPGraphicsPath.AddEllipse(cx - r, cy - r, r * 2, r * 2);
end;

procedure TSVGGDIGraphicsPath.AddEllipse(cx, cy, rx, ry: Single);
begin
  FGPGraphicsPath.AddEllipse(cx - rx, cy - ry, rx * 2, ry * 2);
end;

procedure TSVGGDIGraphicsPath.AddLine(x1, y1, x2, y2: Single);
begin
  FGPGraphicsPath.AddLine(x1, y1, x2, y2);
end;

procedure TSVGGDIGraphicsPath.AddPath(addingPath: TSVGCanvasPath; connect: Bool);
begin
  FGPGraphicsPath.AddPath(TSVGGDIGraphicsPath(addingPath).FGPGraphicsPath, connect);
end;

procedure TSVGGDIGraphicsPath.AddRectangle(x, y, width, height, rx, ry: Single);
begin
  if IsZero(rx) or IsZero(ry) then
    FGPGraphicsPath.AddRectangle(MakeRect(x, y, width, height))
  else
  begin
    AddLine(x + rx, y, x + width - rx, y);
    AddArc(x + width - 2 * rx, y, 2 * rx, 2 * ry, 270, 90);

    AddLine(x + width, y + ry,x + width, y + height - ry);
    AddArc(x + width - 2 * rx, y + height - 2 * ry, 2 * rx, 2 * ry, 0, 90);

    AddLine(x + width - rx, y + height, x + rx, y + height);
    AddArc(x, y + height - 2 * ry, 2 * rx, 2 * ry, 90, 90);

    AddLine(x, y + height - ry, x, y + ry);
    AddArc(x, y, 2 * rx, 2 * ry, 180, 90);

    CloseFigure;
  end;
end;

function TSVGGDIGraphicsPath.Bounds: TSingleBounds;
var
  GPBounds: TGPRectF;
begin
  FGPGraphicsPath.GetBounds(GPBounds);
  with GPBounds do
    Result := ToSingleBounds(X, Y, Width, Height);
end;

function TSVGGDIGraphicsPath.Clone: TSVGCanvasPath;
begin
  Result := TSVGGDIGraphicsPath.Create;
  TSVGGDIGraphicsPath(Result).Matrix := Matrix;
  TSVGGDIGraphicsPath(Result).FGPGraphicsPath := FGPGraphicsPath.Clone;
end;

procedure TSVGGDIGraphicsPath.CloseFigure;
begin
  FGPGraphicsPath.CloseFigure;
end;

constructor TSVGGDIGraphicsPath.Create;
begin
  inherited Create;

  FGPGraphicsPath := TGPGraphicsPath.Create(FillModeWinding);
end;

destructor TSVGGDIGraphicsPath.Destroy;
begin
  FGPGraphicsPath.Free;

  inherited Destroy;
end;

function TSVGGDIGraphicsPath.Log: string;
var
  PathData: TPathData;
  i: Integer;
  Points: PGPPointF;
begin
  PathData := TPathData.Create;
  try
    FGPGraphicsPath.GetPathData(PathData);

    Result := IntToStr(PathData.Count) + ': ';
    Points := PathData.Points;
    for i := 0 to PathData.Count - 1 do
    begin
      Points := Ptr(Cardinal(Points) + SizeOf(Points));
      Result := Result + '(' + frFloatToStr(Points^.X) + ' ' + frFloatToStr(Points^.Y) + ') ';
    end;
  finally
    PathData.Free;
  end;
end;

procedure TSVGGDIGraphicsPath.StartFigure;
begin
  FGPGraphicsPath.StartFigure;
end;

procedure TSVGGDIGraphicsPath.Transform(const Matrix: TSVGTransform);
var
  GPMatrix: TGPMatrix;
begin
  GPMatrix := GetGPMatrix(Matrix);
  try
    FGPGraphicsPath.Transform(GPMatrix);
  finally
    GPMatrix.Free;
  end;
end;

{ TSVGGDIPlusText }

function TSVGGDIPGraphicsPathText.AddPathText(const Path: TSVGCanvasPath;
  const Text: string; const Indent: Single; FontData: TSVGFontData;
  const DistanceFactor, KerningFactor: Single): Single;
var
  FF: TGPFontFamily;
  FontStyle: TFontStyle;
  SF: TGPStringFormat;
begin
  FF := TSVGGDIPCanvas.GetFontFamily(FontData.Names);
  FontStyle := TSVGGDIPCanvas.GDIPFontStyle(FontData);
  SF := TGPStringFormat.Create(StringFormatFlagsMeasureTrailingSpaces);

  Result := GPPathText.AddPathText(TSVGGDIGraphicsPath(Path).FGPGraphicsPath,
              WideString(Text), Indent, FF, FontStyle, FontData.Size, SF
            );

  SF.Free;
  FF.Free;
end;

constructor TSVGGDIPGraphicsPathText.Create(Path: TSVGCanvasPath);
begin
  GPPathText := TGPPathText.Create(TSVGGDIGraphicsPath(Path).FGPGraphicsPath);
end;

destructor TSVGGDIPGraphicsPathText.Destroy;
begin
  GPPathText.Free;

  inherited Destroy;
end;

end.
