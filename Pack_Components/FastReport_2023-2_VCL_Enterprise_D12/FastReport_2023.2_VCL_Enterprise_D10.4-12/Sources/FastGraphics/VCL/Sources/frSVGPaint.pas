
{******************************************}
{                                          }
{             FastReport VCL               }
{            SVG paint servers             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGPaint;

interface

{$I frVer.inc}

uses
  Windows, Graphics,
  frSVGCanvas, frSVGHelpers, frSVGBase, frSVGColor,
  frSVGElement, frSVGComponents;

type
  Tel_stop = class(TSVGElementObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;
    function GetStopData: TSVGGradientStopData;
  end;

  TSVGGradient = class(TSVGElementObj)
  private
    FHrefObj: TSVGGradient;
  protected
    FUser: TSVGElementObj;

    function GetGradientArray(Opacity: Single): TSVGGradientArray; virtual;
    procedure SurePercent(AA: array of TSVGAttribute);
  public
    procedure GetGradientData(Opacity: Single; const User: TSVGElementObj; out GData: TSVGGradientData); virtual;

    property User: TSVGElementObj read FUser;
  end;

  Tel_linearGradient = class(TSVGGradient)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;

    procedure GetGradientData(Opacity: Single; const User: TSVGElementObj; out GData: TSVGGradientData); override;
  end;

  Tel_radialGradient = class(TSVGGradient)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;

    procedure GetGradientData(Opacity: Single; const User: TSVGElementObj; out GData: TSVGGradientData); override;
  end;

  Tel_pattern = class(Tel_svg)
  protected
    FUser: TSVGElementObj;
    FPatternFactor: Single;

    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function CalcXYTranslation(X, Y: Single): TSVGTransform; override;
    function GetViewBox: TSingleBounds; override;

    function CreateBitmap32(W, H: Single; out StartIndex, Size: Integer): TBitmap;
    procedure SetOpacityBitmap32(Bitmap: TBitmap; StartIndex, Size: Integer; Opacity: Single);

    function GetPatternFactor: Single; override;
    procedure CalcPatternFactor;
  public
    constructor Create; override;
    function IsForceLengthToPercent: Boolean; override;

    function CalcFillOpacity: Single; override;
    function CalcStrokeOpacity: Single; override;

    procedure GetPatternData(Opacity: Single; const User: TSVGElementObj; out PData: TSVGPatternData);

    property User: TSVGElementObj read FUser;
  end;

implementation

uses
  Classes, Math, frSVGParse, frUtils;

{ TSVGStop }

constructor Tel_stop.Create;
begin
  inherited Create;
  ConstructAttributes(el_stop);
end;

function Tel_stop.GetStopData: TSVGGradientStopData;
begin
  Result.SVGColor := atColorCurrent(at_stop_color);
  Result.SVGColor.Alpha := Result.SVGColor.Alpha * atAlpha(at_stop_opacity);
  Result.Offset := atAlpha(at_offset);
end;

function Tel_stop.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_stop.Create(Parent);
end;

{ TSVGGradient }

function TSVGGradient.GetGradientArray(Opacity: Single): TSVGGradientArray;

  function IsFind(const Href: string): Boolean;
  begin
    if      Href = '' then
      FHrefObj := Self
    else if Href[1] = '#' then
      FHrefObj := TSVGGradient(FRoot.FindByID(Copy(Href, 2, MaxInt)));

    Result := Assigned(FHrefObj) and (FHrefObj is TSVGGradient) and (FHrefObj.Count > 0);
  end;

  function Stop(Index: Integer): Tel_stop;
  begin
    Result := Tel_stop(FHrefObj.Items[Index]);
  end;
var
  i, AddStart, AddEnd, Len: Integer;
begin
  SetLength(Result, 0);

  if (FHrefObj = nil) and not IsFind(atString(at_href)) then
    Exit;

  AddStart := frIfInt(Stop(0).GetStopData.Offset > 0, 1);
  AddEnd := frIfInt(Stop(FHrefObj.Count - 1).GetStopData.Offset < 1, 1);

  Len := FHrefObj.Count + AddStart + AddEnd;

  SetLength(Result, Len);

  for i := 0 to FHrefObj.Count - 1 do
    Result[i + AddStart] := Stop(i).GetStopData;

  Result[0] := ToSVGGradientStopData(Result[0 + AddStart].SVGColor, 0.0);
  Result[Len - 1] := ToSVGGradientStopData(Result[Len - 1 - AddEnd].SVGColor, 1.0);

  for i := 0 to FHrefObj.Count - 1 do
    Result[i].SVGColor.Alpha := Result[i + AddStart].SVGColor.Alpha * Opacity;
end;

procedure TSVGGradient.GetGradientData(Opacity: Single; const User: TSVGElementObj; out GData: TSVGGradientData);
begin
  FUser := User;

  GData.UserBounds := User.GetBounds;
  GData.gradientUnits := atSpecificWord(at_gradientUnits);
  GData.spreadMethod := atSpecificWord(at_spreadMethod);

  if atIsDefault(at_Transform) then
    GData.gradientTransform := atMatrix(at_gradientTransform)
  else
    GData.gradientTransform := atMatrix(at_Transform);

  GData.GradientArray := GetGradientArray(Opacity);
end;

procedure TSVGGradient.SurePercent(AA: array of TSVGAttribute);
var
  i: integer;
begin
  for i := Low(AA) to High(AA) do
    AttrObj[AA[i]].PartToPercent;
end;

{ TSVGLinearGradient }

constructor Tel_linearGradient.Create;
begin
  inherited Create;
  ConstructAttributes(el_linearGradient);
end;

procedure Tel_linearGradient.GetGradientData(Opacity: Single; const User: TSVGElementObj; out GData: TSVGGradientData);
begin
  inherited GetGradientData(Opacity, User, GData);

  GData.FillerType := ftLinearGradient;

  if GData.gradientUnits = svg_objectBoundingBox then
    SurePercent([at_x1, at_y1, at_x2, at_y2]);

  GData.x1 := atLength(at_x1) + frIfReal(atIsPercent(at_x1), GData.UserBounds.X);
  GData.y1 := atLength(at_y1) + frIfReal(atIsPercent(at_y1), GData.UserBounds.Y);
  GData.x2 := atLength(at_x2) + frIfReal(atIsPercent(at_x2), GData.UserBounds.X);
  GData.y2 := atLength(at_y2) + frIfReal(atIsPercent(at_y2), GData.UserBounds.Y);
end;

function Tel_linearGradient.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_linearGradient.Create(Parent);
end;

{ TSVGRadialGradient }

constructor Tel_radialGradient.Create;
begin
  inherited Create;
  ConstructAttributes(el_radialGradient);
end;

procedure Tel_radialGradient.GetGradientData(Opacity: Single; const User: TSVGElementObj; out GData: TSVGGradientData);
begin
  inherited GetGradientData(Opacity, User, GData);

  GData.FillerType := ftRadialGradient;

  if GData.gradientUnits = svg_objectBoundingBox then
    SurePercent([at_cx, at_cy, at_fr, at_fx, at_fy, at_r]);

  GData.cx := atLength(at_cx) + frIfReal(atIsPercent(at_cx), GData.UserBounds.X);
  GData.cy := atLength(at_cy) + frIfReal(atIsPercent(at_cy), GData.UserBounds.Y);

  // fx / fy Default: Coincides with the presentational value of cx for the element whether the value for cx was inherited or not.
  if atIsDefault(at_fx) then
    GData.fx := GData.cx
  else
    GData.fx := atLength(at_fx) + frIfReal(atIsPercent(at_fx), GData.UserBounds.X);

  if atIsDefault(at_fy) then
    GData.fy := GData.cy
  else
    GData.fy := atLength(at_fy) + frIfReal(atIsPercent(at_fx), GData.UserBounds.Y);

  GData.fr := atLength(at_fr);
  GData.r := atLength(at_r);
end;

function Tel_radialGradient.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_radialGradient.Create(Parent);
end;

{ Tel_pattern }

function Tel_pattern.CalcFillOpacity: Single;
begin
  if IsFullOpacity then
    Result := 1.0
  else
    Result := atAlpha(at_fill_opacity) * atAlpha(at_opacity);
end;

procedure Tel_pattern.CalcPatternFactor;
const
  MinPatternSize = 70.0;
begin
  FPatternFactor := 1.0;
  FPatternFactor := MinPatternSize /
    Sqrt(atLengthAuto(at_width) * atLengthAuto(at_height));
  FPatternFactor := Max(1.0, FPatternFactor);
end;

function Tel_pattern.CalcStrokeOpacity: Single;
begin
  if IsFullOpacity then
    Result := 1.0
  else
    Result := atAlpha(at_stroke_opacity) * atAlpha(at_opacity);
end;

function Tel_pattern.CalcXYTranslation(X, Y: Single): TSVGTransform;
begin
  Result := tmIdentity;
end;

constructor Tel_pattern.Create;
begin
  inherited Create;

  ConstructAttributes(el_pattern);
  FPattern := Self;
end;

function Tel_pattern.CreateBitmap32(W, H: Single; out StartIndex, Size: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  with Result do
  begin
    PixelFormat := pf32Bit;
    Width := Round(W);
    Height := Round(H);
    Size := Width * Height;
    HandleType := bmDIB;
    IgnorePalette := True;
//    AlphaFormat := afPremultiplied;
    // clear all Scanlines
    StartIndex := frIfInt(IsBitmapBottomUp(Result), Height - 1);
    FillChar(ScanLine[StartIndex]^, Size * 4 {pf32Bit}, 0);
  end;

end;

procedure Tel_pattern.GetPatternData(Opacity: Single; const User: TSVGElementObj; out PData: TSVGPatternData);
var
  StartIndex, Size: Integer;
  Inner: Boolean;
  DC: HDC;
  InitialSize: TSinglePoint;
begin
  FUser := User;
  CalcPatternFactor;

  PData.Width := atLengthAuto(at_width);
  PData.Height := atLengthAuto(at_height);
  PData.Bitmap := nil;
  if (PData.Width = 0) or (PData.Height = 0) then
    Exit;

  if      not atIsDefault(at_patternTransform) then
    PData.Matrix := atMatrix(at_patternTransform)
  else if not atIsDefault(at_Transform) then
    PData.Matrix := atMatrix(at_Transform)
  else
    PData.Matrix := tmIdentity;

  Inner := atSpecificWord(at_patternUnits) = svg_objectBoundingBox;
  PData.x := atLength(at_x) + frIfReal(Inner, User.GetBounds.X);
  PData.y := atLength(at_y) + frIfReal(Inner, User.GetBounds.Y);

  InitialSize := spCreate(PData.Width / PatternFactor, PData.Height / PatternFactor);
  PData.Offset := spCreate(PData.x, PData.y);
  while PData.Offset.X >= InitialSize.X do
    PData.Offset.X := PData.Offset.X - InitialSize.X;
  while PData.Offset.Y >= InitialSize.Y do
    PData.Offset.Y := PData.Offset.Y - InitialSize.Y;

  PData.Factor := 1 / PatternFactor;

  PData.Bitmap := CreateBitmap32(PData.Width, PData.Height, StartIndex, Size);
  DC := PData.Bitmap.Canvas.Handle;

  SVGElement[el_pattern].Options := SVGElement[el_pattern].Options + [eoPaint, eoMatrix];
  try
    FRootMatrix := EmptyTransform;
    ConstructPathes;
    PaintTo(DC);
  finally
    SVGElement[el_pattern].Options := SVGElement[el_pattern].Options - [eoPaint, eoMatrix]
  end;

  SetOpacityBitmap32(PData.Bitmap, StartIndex, Size, Opacity);
end;

function Tel_pattern.GetPatternFactor: Single;
begin
  Result := FPatternFactor;
end;

function Tel_pattern.GetViewBox: TSingleBounds;
begin
  if atIsDefault(at_viewBox) and (User <> nil) and
     (atSpecificWord(at_patternUnits) = svg_objectBoundingBox) then
    Result := ToSingleBounds(0,
                             0,
                             atLengthAuto(at_width, User.GetWidth),
                             atLengthAuto(at_height, User.GetHeight))
  else
    Result := inherited GetViewBox;
end;

function Tel_pattern.IsForceLengthToPercent: Boolean;
begin
  Result := atSpecificWord(at_patternUnits) = svg_objectBoundingBox;
end;

function Tel_pattern.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_pattern.Create(Parent);
end;

procedure Tel_pattern.SetOpacityBitmap32(Bitmap: TBitmap; StartIndex, Size: Integer; Opacity: Single);
var
  PQuad: PRGBQuad;
  i: Integer;
begin
  PQuad := Bitmap.ScanLine[StartIndex];
  if Opacity <> 1.0 then
    for i := 0 to Size - 1 do
    begin
      PQuad^.rgbBlue := Round(PQuad^.rgbBlue * Opacity);
      PQuad^.rgbGreen := Round(PQuad^.rgbGreen * Opacity);
      PQuad^.rgbRed := Round(PQuad^.rgbRed * Opacity);
      PQuad^.rgbReserved := Round(PQuad^.rgbReserved * Opacity);
      Inc(PQuad);
    end;
end;

end.
