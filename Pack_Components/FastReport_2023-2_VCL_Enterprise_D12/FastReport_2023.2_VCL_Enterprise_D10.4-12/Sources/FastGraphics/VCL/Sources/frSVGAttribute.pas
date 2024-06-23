
{******************************************}
{                                          }
{             FastReport VCL               }
{             SVG Attributes               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
unit frSVGAttribute;

interface

{$I frVer.inc}

uses
  Classes, Types, Math,
  frSVGParse, frSVGComponents, frSVGHelpers, frSVGColor,
  frCSSTransform, frCSSStyle;

const
  DefaultBase = -MaxSingle; 

type
  TSVGAttributeObj = class (TPersistent)
  private
  protected
    FDefault: Boolean;
    FTL: TCSSSVGTransformList;

    FLengthPercentageAuto: TSVGLength;
    FColorSWRootDefault: TSVGColorSW;
    FPaintRootDefault: TSVGPaint;

    FIsForceObjectBoundingBoxPercent: Boolean;

    procedure SetDefault; virtual;
  public
    destructor Destroy; override;

    function IsCSS: Boolean; virtual; abstract;
    function IsDefault: Boolean;
    function IsPercent: Boolean; virtual; abstract;
    function IsCanReadSVGValue(Style: TfrxCSSStyle): Boolean; virtual; abstract;

    procedure PartToPercent; virtual; abstract;
    procedure SetTransform(Matrix: TSVGTransform);

    function GetAlpha: Single; virtual; abstract;
    function GetBounds: TSingleBounds; virtual; abstract;

    function GetLength(Base: Single = DefaultBase): Single; virtual; abstract;
    function GetLengthAuto(Base: Single = DefaultBase): Single; virtual; abstract;
    procedure SetLengthAuto(Value: Single);
    procedure SetLengthSW(LengthSW: TSVGLengthSW); virtual; abstract;
    function GetLengthInherit: TSVGLengthSW; virtual; abstract;
    function GetLengthList: TSingleDynArray; virtual; abstract;
    function GetLengthListNoneInherit(out Value: TSingleDynArray): TSVGSpecificWord; virtual; abstract;

    function GetNumber: Single; virtual; abstract;
    function GetNumberSW: TNumberSW; virtual; abstract;
    function GetFontWeight: TNumberSW; virtual; abstract;

    function GetColorCurrent: TSVGColorSW; virtual; abstract;
    function GetColorInherit: TSVGColorSW; virtual; abstract;

    function GetPaint: TSVGPaint; virtual; abstract;

    function GetSinglePointDynSrray: TSinglePointDynArray; virtual; abstract;

    function GetSpecificWord: TSVGSpecificWord; virtual; abstract;
    function GetSpecificWordSet: TSVGSpecificWordSet; virtual; abstract;

    function GetString: string; virtual; abstract;
    function GetStringInherit: TSVGStringSW; virtual; abstract;
    function GetURI: string; virtual; abstract;

    function GetPreserveAspectRatio: TSVGPreserveAspectRatio; virtual; abstract;

    function GetTransform: TSVGTransform; virtual; abstract;
  end;

function CreateAttribute(ElementObj: pointer; Attribute: TSVGAttribute): TSVGAttributeObj;

implementation

uses
  SysUtils, Windows,
  frSVGElement, frSVGPaint, frSVGBase, frSVGPath;

type
  TSVGValue = (
    svAlphaPercentage,
    svBounds,
    svColorCurrent,
    svColorInherit,
    svLengthPercentage,
    svLengthPercentageAuto,
    svLengthPercentageInherit,
    svLengthPercentageList,
    svLengthPercentageListNoneInherit,
    svNumber,
    svNumberInherit,
    svNumberFontWeight,
    svPaint,
    svPath,
    svPreserveAspectRatio,
    svSinglePointList,
    svSpecificWordSet,
    svSpecificWord,
    svString,
    svStringInherit,
    svTransform,
    svURI
 );

  Tat_ = class (TSVGAttributeObj)
  private
    FElement: TSVGElement;
    FAttribute: TSVGAttribute;
    FElementObj: TSVGElementObj;
    FSVGValue: TSVGValue;
  protected
    FLengthPercentage: TSVGLength;
    FLengthPercentageRootDefault: TSVGLength;
    FLengthPercentageSW: TSVGLengthSW;
    FLengthLengthPercentageList: TSVGLengthArray;
    FLengthPercentageListNoneInherit: TSVGLengthArraySW;

    FString: string;
    FStringInherit: TSVGStringSW;
    FStringInheritRootDefault: TSVGStringSW;

    FSpecificWord: TSVGSpecificWord;
    FSpecificWordRootDefault: TSVGSpecificWord;
    FSpecificWordSet: TSVGSpecificWordSet;
    FSpecificWordSetRootDefault: TSVGSpecificWordSet;

    FColorSW: TSVGColorSW;

    FAlphaPercentage: Single;

    FNumber: Single;
    FNumberSW: TNumberSW;
    FNumberSWRootDefault: TNumberSW;

    FSinglePointList: TSinglePointDynArray;

    FTransform: TSVGTransform;

    FPreserveAspectRatio: TSVGPreserveAspectRatio;

    FBounds: TSingleBounds;

    FPaint: TSVGPaint;

    FAcceptableSW: array of TSVGSpecificWord;

    procedure AssignTo(Dest: TPersistent); override;
    function GetBaseLength: Single;
    function GetFontSize: Single; virtual;
    function CalcLength(LengthPercentage: TSVGLength; Base: Single = DefaultBase): Single;
    procedure ParseSpecificWord(const S: string);
    procedure ParseSpecificPair(const S: string); virtual; // raise Exception
    procedure UseSpecificWord(const S: string);
    function IsStyleContain(Style: TfrxCSSStyle; out S: string): Boolean; virtual;
    procedure CreateTransform(const S: string);
    procedure SetAcceptableSW(sw: array of TSVGSpecificWord);

    procedure TestValue(Value: TSVGValue);
  public
    constructor Create(ElementObj: TSVGElementObj; Attribute: TSVGAttribute);

    function IsCSS: Boolean; override;
    function IsPercent: Boolean; override;
    function IsCanReadSVGValue(Style: TfrxCSSStyle): Boolean; override;

    procedure PartToPercent; override;

    function GetBounds: TSingleBounds; override;
    function GetAlpha: Single; override;

    function GetLength(Base: Single = DefaultBase): Single; override;
    function GetLengthAuto(Base: Single = DefaultBase): Single; override;
    procedure SetLengthSW(LengthSW: TSVGLengthSW); override;
    function GetLengthInherit: TSVGLengthSW; override;
    function GetLengthList: TSingleDynArray; override;
    function GetLengthListNoneInherit(out Value: TSingleDynArray): TSVGSpecificWord; override;

    function GetNumber: Single; override;
    function GetNumberSW: TNumberSW; override;
    function GetFontWeight: TNumberSW; override;

    function GetColorCurrent: TSVGColorSW; override;
    function GetColorInherit: TSVGColorSW; override;

    function GetPaint: TSVGPaint; override;

    function GetSinglePointDynSrray: TSinglePointDynArray; override;

    function GetSpecificWord: TSVGSpecificWord; override;
    function GetSpecificWordSet: TSVGSpecificWordSet; override;

    function GetURI: string; override;
    function GetString: string; override;
    function GetStringInherit: TSVGStringSW; override;

    function GetPreserveAspectRatio: TSVGPreserveAspectRatio; override;
    function GetTransform: TSVGTransform; override;
  end;

  Tat_clip_path = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_clip_rule = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_clipPathUnits = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_color = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_cx = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_cy = class (Tat_cx);

  Tat_d = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_display = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_dominant_baseline = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_dx = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_dy = class (Tat_dx);

  Tat_fill = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_fill_opacity = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_fill_rule = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_font_family = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_font_size = class (Tat_)
  protected
    function GetFontSize: Single; override;
  protected
    procedure SetDefault; override;
  end;

  Tat_font_style = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_font_weight = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_fr = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_fx = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_fy = class (Tat_fx);

  Tat_gradientTransform = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_gradientUnits = class (Tat_clipPathUnits)
  protected
    procedure SetDefault; override;
  end;

  Tat_heigth = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_href = class (Tat_)
  protected
    function IsStyleContain(Style: TfrxCSSStyle; out S: string): Boolean; override;
  protected
    procedure SetDefault; override;
  end;

  Tat_method = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_offset = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_opacity = class (Tat_fill_opacity);

  Tat_path = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  // This attribute defines the coordinate system for the contents of the <pattern>.
  // This attribute has no effect if attribute viewBox is specified on the <pattern> element.
  Tat_patternContentUnits = class (Tat_clipPathUnits);

  Tat_patternTransform = class (Tat_gradientTransform);

  // This attribute defines the coordinate system for attributes x, y, width, and height.
  Tat_patternUnits = class(Tat_gradientUnits);

  Tat_points = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_preserveAspectRatio = class (Tat_)
  protected
    procedure ParseSpecificPair(const S: string); override;
    procedure SetDefault; override;
  end;

  Tat_r = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_rx = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_ry = class (Tat_rx);

  Tat_side = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_spacing = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_spreadMethod = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_startOffset = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_stop_color = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_stop_opacity = class (Tat_fill_opacity);

  Tat_stroke = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_stroke_dasharray = class (Tat_)
  protected
    procedure SetDefault; override;
  public
    function GetLengthListNoneInherit(out Value: TSingleDynArray): TSVGSpecificWord; override;
  end;

  Tat_stroke_dashoffset = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_stroke_linecap = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_stroke_linejoin = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_stroke_miterlimit = class (Tat_)
  protected
    procedure SetDefault; override;
  public
    function GetNumberSW: TNumberSW; override;
  end;

  Tat_stroke_opacity = class (Tat_fill_opacity);

  Tat_stroke_width = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_systemLanguage = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_text_anchor = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_text_decoration = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_transform = class (Tat_gradientTransform);

  Tat_viewBox = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_visibility = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_width = class (Tat_heigth);

  Tat_x = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_x1 = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_x2 = class (Tat_)
  protected
    procedure SetDefault; override;
  end;

  Tat_y = class (Tat_x);

  Tat_y1 = class (Tat_x1);

  Tat_y2 = class (Tat_y1);

{ Utility routines }

function CopyLengthArray(A: TSVGLengthArray): TSVGLengthArray;
begin
  SetLength(Result, Length(A));
  Move(A[0], Result[0], Length(A) * SizeOf(A[0]));
end;

function CreateAttribute(ElementObj: pointer; Attribute: TSVGAttribute): TSVGAttributeObj;
var
  EO: TSVGElementObj;
begin
  EO := TSVGElementObj(ElementObj);
  case Attribute of
//    at_class: ;
    at_clip_path:             Result := Tat_clip_path.Create(EO, Attribute);
    at_clip_rule:             Result := Tat_clip_rule.Create(EO, Attribute);
    at_clipPathUnits:         Result := Tat_clipPathUnits.Create(EO, Attribute);
    at_color:                 Result := Tat_color.Create(EO, Attribute);
    at_cx:                    Result := Tat_cx.Create(EO, Attribute);
    at_cy:                    Result := Tat_cy.Create(EO, Attribute);
    at_d:                     Result := Tat_d.Create(EO, Attribute);
    at_display:               Result := Tat_display.Create(EO, Attribute);
    at_dominant_baseline:     Result := Tat_dominant_baseline.Create(EO, Attribute);
    at_dx:                    Result := Tat_dx.Create(EO, Attribute);
    at_dy:                    Result := Tat_dy.Create(EO, Attribute);
    at_fill:                  Result := Tat_fill.Create(EO, Attribute);
    at_fill_opacity:          Result := Tat_fill_opacity.Create(EO, Attribute);
    at_fill_rule:             Result := Tat_fill_rule.Create(EO, Attribute);
    at_font_family:           Result := Tat_font_family.Create(EO, Attribute);
    at_font_size:             Result := Tat_font_size.Create(EO, Attribute);
    at_font_style:            Result := Tat_font_style.Create(EO, Attribute);
    at_font_weight:           Result := Tat_font_weight.Create(EO, Attribute);
    at_fr:                    Result := Tat_fr.Create(EO, Attribute);
    at_fx:                    Result := Tat_fx.Create(EO, Attribute);
    at_fy:                    Result := Tat_fy.Create(EO, Attribute);
    at_gradientTransform:     Result := Tat_gradientTransform.Create(EO, Attribute);
    at_gradientUnits:         Result := Tat_gradientUnits.Create(EO, Attribute);
    at_height:                Result := Tat_heigth.Create(EO, Attribute);
    at_href:                  Result := Tat_href.Create(EO, Attribute);
//    at_id: ;
    at_method:                Result := Tat_method.Create(EO, Attribute);
    at_offset:                Result := Tat_offset.Create(EO, Attribute);
    at_opacity:               Result := Tat_opacity.Create(EO, Attribute);
    at_path:                  Result := Tat_path.Create(EO, Attribute);
    at_patternContentUnits:   Result := Tat_patternContentUnits.Create(EO, Attribute);
    at_patternTransform:      Result := Tat_patternTransform.Create(EO, Attribute);
    at_patternUnits:          Result := Tat_patternUnits.Create(EO, Attribute);
    at_points:                Result := Tat_points.Create(EO, Attribute);
    at_preserveAspectRatio:   Result := Tat_preserveAspectRatio.Create(EO, Attribute);
    at_r:                     Result := Tat_r.Create(EO, Attribute);
    at_rx:                    Result := Tat_rx.Create(EO, Attribute);
    at_ry:                    Result := Tat_ry.Create(EO, Attribute);
    at_side:                  Result := Tat_side.Create(EO, Attribute);
    at_spacing:               Result := Tat_spacing.Create(EO, Attribute);
    at_spreadMethod:          Result := Tat_spreadMethod.Create(EO, Attribute);
    at_startOffset:           Result := Tat_startOffset.Create(EO, Attribute);
    at_stop_color:            Result := Tat_stop_color.Create(EO, Attribute);
    at_stop_opacity:          Result := Tat_stop_opacity.Create(EO, Attribute);
    at_stroke:                Result := Tat_stroke.Create(EO, Attribute);
    at_stroke_dasharray:      Result := Tat_stroke_dasharray.Create(EO, Attribute);
    at_stroke_dashoffset:     Result := Tat_stroke_dashoffset.Create(EO, Attribute);
    at_stroke_linecap:        Result := Tat_stroke_linecap.Create(EO, Attribute);
    at_stroke_linejoin:       Result := Tat_stroke_linejoin.Create(EO, Attribute);
    at_stroke_miterlimit:     Result := Tat_stroke_miterlimit.Create(EO, Attribute);
    at_stroke_opacity:        Result := Tat_stroke_opacity.Create(EO, Attribute);
    at_stroke_width:          Result := Tat_stroke_width.Create(EO, Attribute);
//    at_style: ;
    at_systemLanguage:        Result := Tat_systemLanguage.Create(EO, Attribute);
    at_text_anchor:           Result := Tat_text_anchor.Create(EO, Attribute);
    at_text_decoration:       Result := Tat_text_decoration.Create(EO, Attribute);
    at_transform:             Result := Tat_transform.Create(EO, Attribute);
    at_viewBox:               Result := Tat_viewBox.Create(EO, Attribute);
    at_visibility:            Result := Tat_visibility.Create(EO, Attribute);
    at_width:                 Result := Tat_width.Create(EO, Attribute);
    at_x:                     Result := Tat_x.Create(EO, Attribute);
    at_x1:                    Result := Tat_x1.Create(EO, Attribute);
    at_x2:                    Result := Tat_x2.Create(EO, Attribute);
    at_y:                     Result := Tat_y.Create(EO, Attribute);
    at_y1:                    Result := Tat_y1.Create(EO, Attribute);
    at_y2:                    Result := Tat_y2.Create(EO, Attribute);
  else
    raise Exception.Create('Unsupported SVG attribute: "' + SVGAttribute[Attribute].Name + '"');
  end;
end;

{ Tat_ }

procedure Tat_.AssignTo(Dest: TPersistent);
var
  D: Tat_;
  i: Integer;
begin
  if Dest is Tat_ then
  begin
    D := Tat_(Dest);

    D.FElement := FElement;
    D.FAttribute := FAttribute;

    D.FDefault := FDefault;
    D.FSVGValue := FSVGValue;

    case FSVGValue of
      svAlphaPercentage:         D.FAlphaPercentage := FAlphaPercentage;

      svBounds:                  D.FBounds := FBounds;

      svColorCurrent, svColorInherit:
                                 D.FColorSW := FColorSW;

      svLengthPercentage:        D.FLengthPercentage := FLengthPercentage;
      svLengthPercentageAuto, svLengthPercentageInherit:
                                 D.FLengthPercentageSW := FLengthPercentageSW;

      svLengthPercentageList:    D.FLengthLengthPercentageList := CopyLengthArray(FLengthLengthPercentageList);
      svLengthPercentageListNoneInherit:
        with D.FLengthPercentageListNoneInherit do
        begin
          Arr := CopyLengthArray(FLengthPercentageListNoneInherit.Arr);
          SW := FLengthPercentageListNoneInherit.SW;
        end;

      svNumber:                  D.FNumber := FNumber;
      svNumberInherit, svNumberFontWeight:
                                 D.FNumberSW := FNumberSW;

      svPaint:                   D.FPaint := FPaint;

      svPath:                    ;

      svPreserveAspectRatio:     D.FPreserveAspectRatio := FPreserveAspectRatio;

      svSinglePointList:         D.FSinglePointList := DynArrayCopy(FSinglePointList);

      svSpecificWord:            D.FSpecificWord := FSpecificWord;
      svSpecificWordSet:         D.FSpecificWordSet := FSpecificWordSet;

      svString:                  D.FString := FString;
      svStringInherit:           D.FStringInherit := FStringInherit;

      svTransform:
        begin
          D.FTransform := FTransform;
          if Assigned(FTL) then
          begin
            D.CreateTransform('');
            for i := 0 to FTL.Count - 1 do
              D.FTL.Add(FTL.CloneItem(i));
          end;
        end;

      svURI:                     D.FString := FString;
    end;
  end;
end;

function Tat_.CalcLength(LengthPercentage: TSVGLength; Base: Single = DefaultBase): Single;
begin
  if FElementObj.IsForceLengthToPercent and FIsForceObjectBoundingBoxPercent and
     (LengthPercentage.SVGUnit = suNone) then
  begin
    LengthPercentage.SVGUnit := suPercent;
    LengthPercentage.Value := LengthPercentage.Value * 100;
  end;

  if      LengthPercentage.SVGUnit in SVGAbsoluteUnits then
    Result := LengthPercentage.Value
  else if LengthPercentage.SVGUnit in SVGFontRelativeUnits then
    Result := GetFontSize * LengthPercentage.Value
  else if LengthPercentage.SVGUnit <> suPercent then
    raise Exception.Create('Unsupported SVG unit')
  else if IsSameSingle(Base, DefaultBase) then
    Result := GetBaseLength * LengthPercentage.Value / 100
  else // (LengthPercentage.SVGUnit = suPercent) and (Base <> DefaultBase)
    Result := Base * LengthPercentage.Value / 100;

  if (FElement = el_pattern) and
     (FElementObj.atSpecificWord(at_patternUnits) = svg_userSpaceOnUse) and
     (FAttribute in [at_height, at_width])
     or
     (FElementObj.IsInPattern) and
     (FElementObj.Pattern.atSpecificWord(at_patternUnits) = svg_userSpaceOnUse) then
    Result := Result * FElementObj.PatternFactor;
end;

constructor Tat_.Create(ElementObj: TSVGElementObj; Attribute: TSVGAttribute);
begin
  FElementObj := ElementObj;
  FElement := FElementObj.Element;
  FAttribute := Attribute;

  SetDefault;
end;

procedure Tat_.CreateTransform(const S: string);
begin
  FTL.Free;
  FTL := TCSSSVGTransformList.Create(S);
end;

function Tat_.GetAlpha: Single;
begin
  TestValue(svAlphaPercentage);
  Result := FAlphaPercentage;
end;

function Tat_.GetBaseLength: Single;
var
  Direction: TSVGDirection;
begin
  Direction := SVGAttribute[FAttribute].Direction;

  if Direction = sdNo then
    raise Exception.Create('Wrong Direction');

  if      FElement in [el_linearGradient, el_radialGradient] then
    Result := TSVGGradient(FElementObj).User.GetDirectionalSize(Direction)
  else if (FElement = el_pattern) and
          (FElementObj.atSpecificWord(at_patternUnits) = svg_objectBoundingBox) then
    Result := Tel_pattern(FElementObj).User.GetDirectionalSize(Direction)
  else if FElementObj.IsInPattern and
          (FElementObj.Pattern.atSpecificWord(at_patternContentUnits) = svg_objectBoundingBox) and
          (Tel_pattern(FElementObj.Pattern).User <> nil) then
    Result := Tel_pattern(FElementObj.Pattern).User.GetDirectionalSize(Direction)
  else
    Result := FElementObj.GetDirectionalHostSize(Direction);

  if (FElement = el_pattern) and
     (FElementObj.atSpecificWord(at_patternUnits) = svg_objectBoundingBox) and
     (FAttribute in [at_height, at_width]) then
    Result := Result * FElementObj.PatternFactor;
end;

function Tat_.GetBounds: TSingleBounds;
begin
  TestValue(svBounds);
  Result := FBounds;
end;

function Tat_.GetColorCurrent: TSVGColorSW;
begin
  TestValue(svColorCurrent);
  if      FColorSW.SW = svg_currentcolor then
    Result.SW := svg_currentcolor
  else // FColorSW.SW = frx_RGBA then
    Result := FColorSW;
end;

function Tat_.GetColorInherit: TSVGColorSW;
begin
  TestValue(svColorInherit);
  if      FColorSW.SW <> svg_inherit then // FColorSW.SW = svg_RGBA
    Result := FColorSW
  else if FElementObj.IsRoot then
    Result := FColorSWRootDefault
  else
    Result := SVGColorInherit;
end;

function Tat_.GetFontSize: Single;
begin
  TestValue(svLengthPercentage);
  Result := FElementObj.atLengthInherit(at_font_size);
end;

function Tat_.GetFontWeight: TNumberSW;
begin
  TestValue(svNumberFontWeight);
  if      not FElementObj.IsRoot then
    Result := FNumberSW
  else if FNumberSW.SW = svg_inherit then
    Result := FNumberSWRootDefault
  else if FNumberSW.SW in [svg_bolder, svg_lighter] then
  begin
    Result.SW := frx_noMater;
    Result.Value := RelativeFontWeight(FNumberSW.SW, FNumberSWRootDefault.Value);
  end;
end;

function Tat_.GetLength(Base: Single = DefaultBase): Single;
begin
  TestValue(svLengthPercentage);
  Result := CalcLength(FLengthPercentage, Base);
end;

function Tat_.GetLengthAuto(Base: Single = DefaultBase): Single;
begin
  TestValue(svLengthPercentageAuto);
  FSVGValue := svLengthPercentage;
  FLengthPercentage := ToSVGLength(FLengthPercentageSW, FLengthPercentageAuto);
  Result := GetLength(Base);
  FSVGValue := svLengthPercentageAuto;
end;

function Tat_.GetLengthInherit: TSVGLengthSW;

  function CalcLengthSW(SL: TSVGLength): TSVGLengthSW;
  begin
    FLengthPercentage := SL;
    FSVGValue := svLengthPercentage;
    Result.Value := GetLength;
    FSVGValue := svLengthPercentageInherit;
    Result.SW := frx_noMater;
    Result.SVGUnit := suNone;
  end;
begin
  TestValue(svLengthPercentageInherit);

  if      FLengthPercentageSW.SW <> svg_inherit then
    Result := CalcLengthSW(ToSVGLength(FLengthPercentageSW))
  else if FElementObj.IsRoot then
    Result := CalcLengthSW(FLengthPercentageRootDefault)
  else
    Result := FLengthPercentageSW;
end;

function Tat_.GetLengthList: TSingleDynArray;
var
  i: Integer;
begin
  TestValue(svLengthPercentageList);
  SetLength(Result, Length(FLengthLengthPercentageList));
  for i := Low(Result) to High(Result) do
    Result[i] := CalcLength(FLengthLengthPercentageList[i]);
end;

function Tat_.GetLengthListNoneInherit(out Value: TSingleDynArray): TSVGSpecificWord;
var
  i: Integer;
begin
  TestValue(svLengthPercentageListNoneInherit);
  Result := FLengthPercentageListNoneInherit.SW;
  if      not (FLengthPercentageListNoneInherit.SW in [svg_inherit, svg_none]) then
  begin
    Result := frx_noMater;
    SetLength(Value, Length(FLengthPercentageListNoneInherit.Arr));
    for i := Low(Value) to High(Value) do
      Value[i] := CalcLength(FLengthPercentageListNoneInherit.Arr[i]);
  end
  else if (FLengthPercentageListNoneInherit.SW = svg_inherit) and FElementObj.IsRoot then
    Result := svg_none;
end;

function Tat_.GetNumber: Single;
begin
  TestValue(svNumber);
  Result := FNumber;
end;

function Tat_.GetNumberSW: TNumberSW;
begin
  TestValue(svNumberInherit);
  if      FElementObj.IsRoot and (FNumberSW.SW = svg_inherit) then
    Result := FNumberSWRootDefault
  else
    Result := FNumberSW;
end;

function Tat_.GetPaint: TSVGPaint;
begin
  TestValue(svPaint);
  if (FPaint.SW = svg_inherit) and (FElementObj.IsRoot) then
    Result := FPaintRootDefault
  else
    Result := FPaint;
end;

function Tat_.GetPreserveAspectRatio: TSVGPreserveAspectRatio;
begin
  TestValue(svPreserveAspectRatio);
  Result := FPreserveAspectRatio;
end;

function Tat_.GetSinglePointDynSrray: TSinglePointDynArray;
begin
  TestValue(svSinglePointList);
  Result := FSinglePointList;
end;

function Tat_.GetSpecificWord: TSVGSpecificWord;
begin
  TestValue(svSpecificWord);
  if (FSpecificWord = svg_inherit) and FElementObj.IsRoot then
    Result := FSpecificWordRootDefault
  else
    Result := FSpecificWord;
end;

function Tat_.GetSpecificWordSet: TSVGSpecificWordSet;
begin
  TestValue(svSpecificWordSet);
  if (svg_inherit in FSpecificWordSet) and FElementObj.IsRoot then
    Result := FSpecificWordSetRootDefault
  else
    Result := FSpecificWordSet;
end;

function Tat_.GetString: string;
begin
  TestValue(svString);
  Result := FString;
end;

function Tat_.GetStringInherit: TSVGStringSW;
begin
  TestValue(svStringInherit);
  if (FStringInherit.SW = svg_inherit) and (FElementObj.IsRoot) then
    Result := ToStringInherit(TSVGRootObj(FElementObj).ExternalFontName)
  else
    Result := FStringInherit;
end;

function Tat_.GetTransform: TSVGTransform;
var
  OldAttribute: TSVGAttribute;
  RawData: TSVGLengthArray;
  Direction: TSVGDirectionArray;
  Data: TSingleDynArray;
  i: Integer;
begin
  TestValue(svTransform);
  if FTL = nil then
    Result := tmIdentity
  else
  begin
    FTL.GetRawData(RawData, Direction);
    OldAttribute := FAttribute;
    FSVGValue := svLengthPercentage;
    try
      SetLength(Data, Length(RawData));
      for i := 0 to High(RawData) do
      begin
        case Direction[i] of
          sdHorizontal: FAttribute := at_rx;
          sdVertical:   FAttribute := at_ry;
          sdDiagonal:   FAttribute := at_r;
        else            FAttribute := at_transform;
        end;
        FLengthPercentage := RawData[i];
        Data[i] := GetLength;
      end;
      FTL.SetData(Data);
    finally
      FSVGValue := svTransform;
      FAttribute := OldAttribute;
    end;
    Result := FTL.GetMatrix;
  end;
end;

function Tat_.GetURI: string;
begin
  TestValue(svURI);
  Result := FString;
end;

function Tat_.IsCanReadSVGValue(Style: TfrxCSSStyle): Boolean;
var
  S: string;
begin
  Result := IsStyleContain(Style, {out} S);
  FDefault := not Result;
  if Result then
    case FSVGValue of
      svAlphaPercentage:         ParseAlpha(S, FAlphaPercentage);

      svBounds:                  ParseViewBox(S, FBounds);

      svColorCurrent:            ParseColorSW(S, svg_currentcolor, FColorSW);
      svColorInherit:            ParseColorSW(S, svg_inherit, FColorSW);

      svLengthPercentage:        ParseLength(S, FLengthPercentage);
      svLengthPercentageAuto:    ParseLengthSW(S, svg_auto, FLengthPercentageSW);
      svLengthPercentageInherit: ParseLengthSW(S, svg_inherit, FLengthPercentageSW);

      svLengthPercentageList:    ParseLengthArray(S, FLengthLengthPercentageList);
      svLengthPercentageListNoneInherit: ParseLengthArrayNoneInherit(S, FLengthPercentageListNoneInherit);

      svNumber:                  ParseNumber(S, FNumber);
      svNumberInherit:           ParseNumberInherit(S, FNumberSW);
      svNumberFontWeight:        ParseFontWeight(S, FNumberSW);

      svPaint:                   ParsePaint(S, FPaint);

      svPath:                    ParsePath(S, FElementObj);

      svPreserveAspectRatio:     ParseSpecificPair(S);

      svSinglePointList:         ParsePoints(S, FSinglePointList);

      svSpecificWord:            ParseSpecificWord(S);
      svSpecificWordSet:         ParseTextDecorations(S, FSpecificWordSet);

      svString:                  FString := S;
      svStringInherit:           ParseStringInherit(S, FStringInherit);

      svTransform:               CreateTransform(S);

      svURI:                     ParseURI(S, FString);
    else
      raise Exception.Create('Unknown SVG Value');
    end;

end;

function Tat_.IsCSS: Boolean;
begin
  Result := FElement in SVGAttribute[FAttribute].CSS;
end;

function Tat_.IsPercent: Boolean;
begin
  Result := (FSVGValue = svLengthPercentage) and (FLengthPercentage.SVGUnit = suPercent) or
    (FSVGValue = svLengthPercentageAuto) and (FLengthPercentageSW.SVGUnit = suPercent);
end;

function Tat_.IsStyleContain(Style: TfrxCSSStyle; out S: string): Boolean;
begin
  S := Style[SVGAttribute[FAttribute].Name];
  Result := S <> '';
end;

procedure Tat_.ParseSpecificPair(const S: string);
begin
  raise Exception.Create(SVGAttribute[FAttribute].Name +  ' - Can''t parse specific value');
end;

procedure Tat_.ParseSpecificWord(const S: string);
begin
  UseSpecificWord(S);
end;

procedure Tat_.PartToPercent;
begin
  if (FSVGValue = svLengthPercentage) and (FLengthPercentage.SVGUnit = suNone) then
  begin
    FLengthPercentage.SVGUnit := suPercent;
    FLengthPercentage.Value := FLengthPercentage.Value * 100.0;
  end;
end;

procedure Tat_.SetAcceptableSW(sw: array of TSVGSpecificWord);
var
  Len: Integer;
begin
  Len := Length(sw);
  SetLength(FAcceptableSW, Len);
  Move(sw[0], FAcceptableSW[0], Len * SizeOf(sw[0]));
end;

procedure Tat_.SetLengthSW(LengthSW: TSVGLengthSW);
begin
  FLengthPercentageSW := LengthSW;
end;

procedure Tat_.TestValue(Value: TSVGValue);
begin
  if FSVGValue <> Value then
    raise Exception.Create('Wrong SVG Value');
end;

procedure Tat_.UseSpecificWord(const S: string);
var
  i: Integer;
begin
  for i := 0 to High(FAcceptableSW) do
    if S = SVGSpecificWord[FAcceptableSW[i]] then
    begin
      FSpecificWord := FAcceptableSW[i];
      Break;
    end;
end;

{ Tat_x }

procedure Tat_x.SetDefault;
begin
  inherited SetDefault;

  if FElement in [el_image, el_pattern, el_rect, el_svg, el_use] then
  begin
    FSVGValue := svLengthPercentage;
    FLengthPercentage := ToSVGLength(0.0);
  end
  else // el_text, el_tspan:
  begin
    FSVGValue := svLengthPercentageList;
    SetLength(FLengthLengthPercentageList, 0);
  end;

  FIsForceObjectBoundingBoxPercent := True;
end;

{ Tat_x1 }

procedure Tat_x1.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentage;
  if FElement = el_line then
    FLengthPercentage := ToSVGLength(0.0)
  else // el_linearGradient
    FLengthPercentage := ToSVGLength(0.0, suPercent);

  FIsForceObjectBoundingBoxPercent := FElement <> el_linearGradient;
end;

{ Tat_x2 }

procedure Tat_x2.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentage;
  if FElement = el_line then
    FLengthPercentage := ToSVGLength(0.0)
  else // el_linearGradient
    FLengthPercentage := ToSVGLength(100.0, suPercent);

  FIsForceObjectBoundingBoxPercent := FElement <> el_linearGradient;
end;

{ Tat_clip_path }

procedure Tat_clip_path.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svURI;
  FString := '';
end;

{ Tat_clip_rule }

procedure Tat_clip_rule.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_inherit;
  FSpecificWordRootDefault := svg_nonzero;
  SetAcceptableSW([svg_evenodd, svg_inherit, svg_nonzero]);
end;

{ Tat_clipPathUnits }

procedure Tat_clipPathUnits.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_userSpaceOnUse;
  SetAcceptableSW([svg_userSpaceOnUse, svg_objectBoundingBox]);
end;

{ Tat_color }

procedure Tat_color.SetDefault;
begin
  inherited SetDefault;
  // As a presentation attribute, it can be applied to any element, but it has no direct effect on SVG elements.
  FSVGValue := svColorInherit;
  FColorSW := SVGColorInherit;
  FColorSWRootDefault := SVGColorSWBlack;
end;

{ Tat_cx }

procedure Tat_cx.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentage;
  if FElement in [el_circle, el_ellipse] then
    FLengthPercentage := ToSVGLength(0.0)
  else // el_radialGradient
    FLengthPercentage := ToSVGLength(50.0, suPercent);

  FIsForceObjectBoundingBoxPercent := FElement <> el_radialGradient;
end;

{ Tat_d }

procedure Tat_d.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svPath;
  // No Value
  FIsForceObjectBoundingBoxPercent := True;
end;

{ Tat_display }

procedure Tat_display.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_inherit;
  FSpecificWordRootDefault := frx_noMater; // Any value other than none or inherit indicates that the given element will be rendered
  SetAcceptableSW([svg_inherit, svg_none]);
end;

{ Tat_dominant_baseline }

procedure Tat_dominant_baseline.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_auto;
  SetAcceptableSW([svg_auto, svg_use_script, svg_no_change, svg_reset_size,
    svg_ideographic, svg_alphabetic, svg_hanging, svg_mathematical, svg_central,
    svg_middle, svg_text_after_edge, svg_text_before_edge, svg_text_top]);
end;

{ Tat_dx }

procedure Tat_dx.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentageList;
  SetLength(FLengthLengthPercentageList, 0);
  FIsForceObjectBoundingBoxPercent := True;
end;

{ Tat_fill }

procedure Tat_fill.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svPaint;
  FPaint := SVGPaintInherit;
  FPaintRootDefault := DefaultFill;
end;

{ Tat_fill_opacity }

procedure Tat_fill_opacity.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svAlphaPercentage;
  FAlphaPercentage := 1.0;
end;

{ Tat_fill_rule }

procedure Tat_fill_rule.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_inherit;
  FSpecificWordRootDefault := svg_nonzero;
  SetAcceptableSW([svg_evenodd, svg_inherit, svg_nonzero]);
end;

{ Tat_font_family }

procedure Tat_font_family.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svStringInherit;
  FStringInherit.SW := svg_inherit;
  FStringInheritRootDefault := ToStringInherit('times');
end;

{ Tat_font_size }

function Tat_font_size.GetFontSize: Single;
begin
  TestValue(svLengthPercentage);
  if FElementObj.IsRoot then
    Result := TSVGRootObj(FElementObj).ExternalFontSize
  else
    Result := FElementObj.Parent.atLengthInherit(at_font_size);
end;

procedure Tat_font_size.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentageInherit;
  FLengthPercentageSW.SW := svg_inherit;
  FLengthPercentageRootDefault := ToSVGLength(1.0, suEM);
  FIsForceObjectBoundingBoxPercent := True;
end;

{ Tat_font_style }

procedure Tat_font_style.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_inherit;
  FSpecificWordRootDefault := svg_normal;
  SetAcceptableSW([svg_inherit, svg_italic, svg_normal, svg_oblique]);
end;

{ Tat_font_weight }

procedure Tat_font_weight.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svNumberFontWeight;
  FNumberSW.SW := svg_inherit;
  FNumberSWRootDefault.SW := frx_noMater;
  FNumberSWRootDefault.Value := FW_NORMAL;
end;

{ Tat_fr }

procedure Tat_fr.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentage;
  FLengthPercentage := ToSVGLength(0.0);
end;

{ Tat_fx }

procedure Tat_fx.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentage;
  FLengthPercentage := ToSVGLength(50.0, suPercent);
end;

{ Tat_gradientTransform }

procedure Tat_gradientTransform.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svTransform;
  FTransform := tmIdentity;
end;

{ Tat_gradientUnits }

procedure Tat_gradientUnits.SetDefault;
begin
  inherited SetDefault;

  FSpecificWord := svg_objectBoundingBox;
end;

{ Tat_href }

function Tat_href.IsStyleContain(Style: TfrxCSSStyle; out S: string): Boolean;
begin
  S := Style[SVGAttribute[FAttribute].Name];
  if S = '' then
    S := Style['xlink:' + SVGAttribute[FAttribute].Name]; // Deprecated
  Result := S <> '';
end;

procedure Tat_href.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svString;
  FString := '';
end;

{ Tat_method }

procedure Tat_method.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_align;
end;

{ Tat_offset }

procedure Tat_offset.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svAlphaPercentage;
  FAlphaPercentage := 0.0;
end;

{ Tat_path }

procedure Tat_path.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svString;
  FString := '';
  FIsForceObjectBoundingBoxPercent := True;
end;

{ Tat_points }

procedure Tat_points.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSinglePointList;
  SetLength(FSinglePointList, 0);
  FIsForceObjectBoundingBoxPercent := True;
end;

{ TpreserveAspectRatio }

procedure Tat_preserveAspectRatio.ParseSpecificPair(const S: string);
begin
  ParsePreserveAspectRatio(S, FPreserveAspectRatio);
end;

procedure Tat_preserveAspectRatio.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svPreserveAspectRatio;
  FPreserveAspectRatio.Align := svg_xMidYMid;
  FPreserveAspectRatio.MeetOrSlice := svg_meet;
end;

{ Tat_r }

procedure Tat_r.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentage;
  if FElement = el_circle then
    FLengthPercentage := ToSVGLength(0.0)
  else // el_radialGradient
    FLengthPercentage := ToSVGLength(50.0, suPercent);

  FIsForceObjectBoundingBoxPercent := FElement <> el_radialGradient;
end;

{ Tat_rx }

procedure Tat_rx.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentageAuto;
  FLengthPercentageSW.SW := svg_auto;
  FLengthPercentageAuto := ToSVGLength(0.0);
  FIsForceObjectBoundingBoxPercent := True;
end;

{ Tat_side }

procedure Tat_side.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_left;
end;

{ Tat_spacing }

procedure Tat_spacing.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_exact;
end;

{ Tat_spreadMethod }

procedure Tat_spreadMethod.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_pad;
  SetAcceptableSW([svg_pad, svg_reflect, svg_repeat]);
end;

{ Tat_startOffset }

procedure Tat_startOffset.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentage;
  FLengthPercentage := ToSVGLength(0.0);
end;

{ Tat_stop_color }

procedure Tat_stop_color.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svColorCurrent;
  FColorSW.SW := svg_currentcolor;
end;

{ Tat_stroke }

procedure Tat_stroke.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svPaint;
  FPaint := SVGPaintInherit;
  FPaintRootDefault := DefaultStroke;
end;

{ Tat_stroke_dasharray }

function Tat_stroke_dasharray.GetLengthListNoneInherit(out Value: TSingleDynArray): TSVGSpecificWord;
var
  Len: Integer;
begin
  Result := inherited GetLengthListNoneInherit(Value);
  if (Result = frx_noMater) and Odd(Length(Value)) then // duplicate
  begin
    Len := Length(Value);
    SetLength(Value, 2 * Len);
    Move(Value[0], Value[Len], SizeOf(Value[0]) * Len);
  end;
end;

procedure Tat_stroke_dasharray.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentageListNoneInherit;
  FLengthPercentageListNoneInherit.SW := svg_inherit;
end;

{ Tat_stroke_dashoffset }

procedure Tat_stroke_dashoffset.SetDefault;
begin
// The offset is usually expressed in user units resolved against the pathLength but if a <percentage> is used, the value is resolved as a percentage of the current viewport.
  inherited SetDefault;

  FSVGValue := svLengthPercentageInherit;
  FLengthPercentageSW.SW := svg_inherit;
  FLengthPercentageRootDefault := ToSVGLength(0.0);
end;

{ Tat_stroke_linecap }

procedure Tat_stroke_linecap.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_inherit;
  FSpecificWordRootDefault := svg_butt;
  SetAcceptableSW([svg_butt, svg_inherit, svg_round, svg_square]);
end;

{ Tat_stroke_linejoin }

procedure Tat_stroke_linejoin.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_inherit;
  FSpecificWordRootDefault := svg_miter;
  SetAcceptableSW([svg_arcs, svg_bevel, svg_inherit, svg_miter, svg_miter_clip, svg_round]);
end;

{ Tat_stroke_miterlimit }

function Tat_stroke_miterlimit.GetNumberSW: TNumberSW;
begin
  Result := inherited GetNumberSW;
  Result.Value := Max(1.0, Result.Value); // The value of stroke-miterlimit must be greater than or equal to 1.
end;

procedure Tat_stroke_miterlimit.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svNumberInherit;
  FNumberSW.SW := svg_inherit;
  FNumberSWRootDefault.SW := frx_noMater;
  FNumberSWRootDefault.Value := 4.0;
end;

{ Tat_stroke_width }

procedure Tat_stroke_width.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentageInherit;
  FLengthPercentageSW.SW := svg_inherit;
  FLengthPercentageRootDefault := ToSVGLength(1.0);
  FIsForceObjectBoundingBoxPercent := True;
end;

{ Tat_viewBox }

procedure Tat_viewBox.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svBounds;
  // No default
end;

{ Tat_visibility }

procedure Tat_visibility.SetDefault;
begin
  inherited SetDefault;
  // As a presentation attribute, it can be applied to any element but it has effect only on the following nineteen elements...
  FSVGValue := svSpecificWord;
  FSpecificWord := svg_visible;
  SetAcceptableSW([svg_hidden, svg_collapse, svg_visible]);
end;

{ Tat_heigth }

procedure Tat_heigth.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svLengthPercentageAuto;
  FLengthPercentageSW.SW := svg_auto;
  if      FElement = el_svg then
    FLengthPercentageAuto := ToSVGLength(100.0, suPercent)
  else if FElement in [el_rect, el_use] then
    FLengthPercentageAuto := ToSVGLength(0.0);
  FIsForceObjectBoundingBoxPercent := True;
end;

{ TSVGAttributeObj }

destructor TSVGAttributeObj.Destroy;
begin
  FTL.Free;
  inherited Destroy;
end;

function TSVGAttributeObj.IsDefault: Boolean;
begin
  Result := FDefault;
end;

procedure TSVGAttributeObj.SetDefault;
begin
  FDefault := True;
  FIsForceObjectBoundingBoxPercent := False;
end;

procedure TSVGAttributeObj.SetLengthAuto(Value: Single);
begin
  FLengthPercentageAuto := ToSVGLength(Value);
  FDefault := False;
end;

procedure TSVGAttributeObj.SetTransform(Matrix: TSVGTransform);
begin
  FTL.Free;
  FTL := TCSSSVGTransformList.Create('');
  FTL.SetTransform(Matrix);
end;

{ Tat_text_decoration }

procedure Tat_text_decoration.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWordSet;
  FSpecificWordSet := [svg_inherit];
  FSpecificWordSetRootDefault := [];
end;

{ Tat_systemLanguage }

procedure Tat_systemLanguage.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svString;
  FString := '';
end;

{ Tat_text_anchor }

procedure Tat_text_anchor.SetDefault;
begin
  inherited SetDefault;

  FSVGValue := svSpecificWord;
  FSpecificWord := svg_inherit;
  FSpecificWordRootDefault := svg_start;
  SetAcceptableSW([svg_end, svg_inherit, svg_middle, svg_start]);
end;

end.

