
{******************************************}
{                                          }
{             FastReport VCL               }
{              SVG Elements                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
unit frSVGElement;

interface

{$I frVer.inc}

uses
  Classes, Types,
  frSVGCanvas, frSVGHelpers, frSVGComponents, frCSSStyle, frSVGAttribute,
  frSVGColor, frSVGParse;

type
  TSVGElementObj = class (TPersistent)
  private
    FParent: TSVGElementObj;
    FItems: TList;
    FHostSVG: TSVGElementObj;
    FStylesApplyingSequence: TList;
    FAttrObj: array[TSVGAttribute] of TSVGAttributeObj;
    FIsAttrEnabled: array[TSVGAttribute] of Boolean;

    function GetCount: Integer;
    function GetItem(const Index: Integer): TSVGElementObj;
    function GetIsAttrEnabled(a: TSVGAttribute): Boolean;
    procedure SetIsAttrEnabled(a: TSVGAttribute; const Value: Boolean);
    function GetAttrObj(a: TSVGAttribute): TSVGAttributeObj;
  protected
    FID: string;
    FRoot: TSVGElementObj;
    FPattern: TSVGElementObj;
    FElement: TSVGElement;
    FInlineStyle: TfrxCSSStyle;
    FAttributeStyle: TfrxCSSStyle;
    FClasses: TStrings;
    FSwitchedOn: Boolean; // to show / hide switch children
    FCompleteMatrix: TSVGTransform; // from root
    FInnerMatrix: TSVGTransform; // inside nearest svg
    FObjBounds: TSingleBounds;

    procedure AssignTo(Dest: TPersistent); override;
    procedure AssignStylesApplyingSequenceTo(Obj: TSVGElementObj); virtual;
    function New(Parent: TSVGElementObj): TSVGElementObj; virtual; abstract;
    procedure ReadIn(const Node: TfrxSVGXMLItem);
    procedure ReadClasses(st: string);
    procedure ReadChildren(const Node: TfrxSVGXMLItem);
    procedure GetValueFromStyles(aObj: TSVGAttributeObj);
    procedure ConstructPath; virtual; // Empty
    procedure ClarifyStyleSequences;
    procedure ClarifyOwnShorthandProperties; virtual;
    procedure ClarifyShorthandProperties;
    procedure ConstructPathes;
    procedure SwitchChildren; virtual; // Empty
    procedure SwitchAll;
    procedure TryAddToSequence(StyleName: string); overload;
    procedure TryAddToSequence(Style: TfrxCSSStyle); overload;
    procedure ConstructStyleSequence;
    procedure ConstructAttributes(AElement: TSVGElement);
    function GetCanvasClass: TSVGCanvasClass; virtual;
    function CalcUnitedChildrenBounds: TSingleBounds;
    function CalcSelfBounds: TSingleBounds; virtual; // raise Exception
    function IsOpt(eo: TSVGElementOptions): Boolean;
    function IsAttrDefault(a: TSVGAttribute): Boolean;
    function GetPatternFactor: Single; virtual;
    function GetIsFullOpacity: Boolean; virtual;
    procedure SetIsFullOpacity(const Value: Boolean); virtual;

    procedure LogStructure(S: string);
  public
    constructor Create; overload; virtual;
    constructor Create(AParent: TSVGElementObj); overload;
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure ClearItems;
    procedure ClarifyUses;
    function Clone(Parent: TSVGElementObj): TSVGElementObj;
    procedure CalculateMatrices;
    procedure ClarifyBounds;
    function IsRoot: Boolean; virtual;
    function IsNeedsPainting: Boolean;
    function SerialNumber: Integer;
    function IsInPattern: Boolean;

    procedure CalcMatrix;

    function ElementName: string;
    function FindByID(const SoughtID: string): TSVGElementObj;

    function GetHostWidth: Single; virtual;
    function GetHostHeight: Single; virtual;
    function GetHostDiagonal: Single; virtual;
    function GetDirectionalHostSize(Direction: TSVGDirection): Single;

    function GetWidth: Single; virtual;
    function GetHeight: Single; virtual;
    function GetBounds: TSingleBounds;
    function GetDiagonal: Single;
    function GetDirectionalSize(Direction: TSVGDirection): Single;
    function GetTransform: TSVGTransform; virtual;

    function CalcFillOpacity: Single; virtual;
    function CalcStrokeOpacity: Single; virtual;

    function atAlpha(a: TSVGAttribute): Single;
    function atIsDefault(a: TSVGAttribute): Boolean;
    function atIsPercent(a: TSVGAttribute): Boolean;

    function atLength(a: TSVGAttribute; Base: Single = DefaultBase): Single;
    function atLengthAuto(a: TSVGAttribute; Base: Single = DefaultBase): Single;
    procedure atSetLengthAuto(a: TSVGAttribute; Value: Single);
    function atLengthInherit(a: TSVGAttribute): Single;
    function atLengthList(a: TSVGAttribute): TSingleDynArray;
    function atLengthListNoneInherit(a: TSVGAttribute): TSingleDynArray;
    function IsForceLengthToPercent: Boolean; virtual;

    function atNumber(a: TSVGAttribute): Single;
    function atNumberInherit(a: TSVGAttribute): Single;
    function atFontWeight: Single;

    function atColorCurrent(a: TSVGAttribute): TSVGColor;
    function atColorInherit(a: TSVGAttribute): TSVGColor;

    function atSpecificWord(a: TSVGAttribute): TSVGSpecificWord;
    function atSpecificWordSet(a: TSVGAttribute): TSVGSpecificWordSet;

    function atString(a: TSVGAttribute): string;
    function atStringInherit(a: TSVGAttribute): string;
    function atURI(a: TSVGAttribute): string;

    function atPAR: TSVGPreserveAspectRatio;

    function atPaint(a: TSVGAttribute): TSVGPaint;

    function atPoints: TSinglePointDynArray;

    function atMatrix(a: TSVGAttribute): TSVGTransform;

    property Items[const Index: Integer]: TSVGElementObj read GetItem; default;
    property Count: Integer read GetCount;

    property Element: TSVGElement read FElement;
    property Parent: TSVGElementObj read FParent;
    property Pattern: TSVGElementObj read FPattern;
    property PatternFactor: Single read GetPatternFactor;
    property CanvasClass: TSVGCanvasClass read GetCanvasClass;
    property ID: string read FID;

    property IsFullOpacity: Boolean read GetIsFullOpacity write SetIsFullOpacity;

    property SwitchedOn: Boolean read FSwitchedOn write FSwitchedOn;

    property CompleteMatrix: TSVGTransform read FCompleteMatrix;
    property InnerMatrix: TSVGTransform read FInnerMatrix;

    property IsAttrEnabled[a: TSVGAttribute]: Boolean read GetIsAttrEnabled write SetIsAttrEnabled;
    property AttrObj[a: TSVGAttribute]: TSVGAttributeObj read GetAttrObj;
  end;

function IsElementByName(Name: string; out Element: TSVGElement): Boolean;

implementation

uses
  SysUtils,
  Math,
  frSVGBase,
  frSVGPaint,
  frSVGPath;

type
  Tel_defs = class(TSVGElementObj)
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    constructor Create; override;
  end;

{ Utility routines }

function IsElementByName(Name: string; out Element: TSVGElement): Boolean;
var
  e: TSVGElement;
begin
  Result := True;
  for e := Low(TSVGElement) to High(TSVGElement) do
    if Name = SVGElement[e].Name then
    begin
      Element := e;
      Exit;
    end;
  Result := False;
end;

{ TSVGElementObj }

procedure TSVGElementObj.AssignStylesApplyingSequenceTo(Obj: TSVGElementObj);
begin
  Obj.FStylesApplyingSequence.Clear;
  Obj.FStylesApplyingSequence.Assign(FStylesApplyingSequence);
end;

procedure TSVGElementObj.AssignTo(Dest: TPersistent);
var
  Obj: TSVGElementObj;
  a: TSVGAttribute;
begin
  if (Dest is TSVGElementObj) then
  begin
    Obj := TSVGElementObj(Dest);

    Obj.FID := FID;

    if Obj.Parent <> nil then
      if Obj.Parent.FElement = el_pattern then
        Obj.FPattern := Obj.Parent
      else
        Obj.FPattern := Obj.Parent.FPattern;

    AssignStylesApplyingSequenceTo(Obj);

    Obj.FIsAttrEnabled := FIsAttrEnabled;
    for a := Low(a) to High(a) do
      if FIsAttrEnabled[a] and not IsAttrDefault(a) then
      begin
        Obj.FAttrObj[a] := CreateAttribute(Obj, a);
        Obj.FAttrObj[a].Assign(AttrObj[a]);
      end;

     Obj.FInlineStyle.Clear;
     Obj.FInlineStyle.Assign(FInlineStyle);

     Obj.FAttributeStyle.Clear;
     Obj.FAttributeStyle.Assign(FAttributeStyle);

     Obj.FClasses.Clear;
     Obj.FClasses.Assign(FClasses);

     Obj.FSwitchedOn := FSwitchedOn;

     Obj.FCompleteMatrix := FCompleteMatrix;
     Obj.FInnerMatrix := FInnerMatrix;

     Obj.FObjBounds := FObjBounds;
  end;
end;

function TSVGElementObj.atAlpha(a: TSVGAttribute): Single;
begin
  if IsAttrEnabled[a] then
    Result := AttrObj[a].GetAlpha
  else
    Result := 1.0;
end;

function TSVGElementObj.atColorCurrent(a: TSVGAttribute): TSVGColor;
var
  CC: TSVGColorSW;
begin
  CC := AttrObj[a].GetColorCurrent;
  if CC.SW = svg_currentcolor then
    Result := atColorInherit(at_color)
  else
    Result := ToSVGColor(CC);
end;

function TSVGElementObj.atColorInherit(a: TSVGAttribute): TSVGColor;
var
  CI: TSVGColorSW;
begin
  CI := AttrObj[a].GetColorInherit;
  if      CI.SW <> svg_inherit then
    Result := ToSVGColor(CI)
  else
    Result := Parent.atColorInherit(a);
end;

function TSVGElementObj.atFontWeight: Single;
var
  FW: TNumberSW;
begin
  FW := AttrObj[at_font_weight].GetFontWeight;
  if      FW.SW = frx_noMater then
    Result := FW.Value
  else if FW.SW = svg_inherit then
    Result := Parent.atFontWeight
  else // FW.SW in [svg_bolder, svg_lighter]
    Result := RelativeFontWeight(FW.SW, Parent.atFontWeight);

end;

function TSVGElementObj.atIsDefault(a: TSVGAttribute): Boolean;
begin
  Result := AttrObj[a].IsDefault;
end;

function TSVGElementObj.atIsPercent(a: TSVGAttribute): Boolean;
begin
  Result := AttrObj[a].IsPercent;
end;

function TSVGElementObj.atLength(a: TSVGAttribute; Base: Single = DefaultBase): Single;
begin
  Result := AttrObj[a].GetLength(Base);
end;

function TSVGElementObj.atLengthAuto(a: TSVGAttribute; Base: Single = DefaultBase): Single;
begin
  Result := AttrObj[a].GetLengthAuto(Base);
end;

function TSVGElementObj.atLengthInherit(a: TSVGAttribute): Single;
var
  LS: TSVGLengthSW;
begin
  LS := AttrObj[a].GetLengthInherit;
  if LS.SW <> svg_inherit then
    Result := LS.Value
  else
    Result := Parent.atLengthInherit(a);
end;

function TSVGElementObj.atLengthList(a: TSVGAttribute): TSingleDynArray;
begin
  Result := AttrObj[a].GetLengthList;
end;

function TSVGElementObj.atLengthListNoneInherit(a: TSVGAttribute): TSingleDynArray;
begin
  if not IsAttrEnabled[a] then
    Result := Parent.atLengthListNoneInherit(a)
  else
    case AttrObj[a].GetLengthListNoneInherit(Result) of
      svg_none:
        SetLength(Result, 0);
      svg_inherit:
        Result := Parent.atLengthListNoneInherit(a);
    end;
end;

function TSVGElementObj.atMatrix(a: TSVGAttribute): TSVGTransform;
begin
  Result := AttrObj[a].GetTransform;
end;

function TSVGElementObj.atNumber(a: TSVGAttribute): Single;
begin
  Result := AttrObj[a].GetNumber;
end;

function TSVGElementObj.atNumberInherit(a: TSVGAttribute): Single;
var
  NI: TNumberSW;
begin
  NI := AttrObj[a].GetNumberSW;
  if NI.SW = svg_inherit then
    Result := Parent.atNumberInherit(a)
  else
    Result := NI.Value;
end;

function TSVGElementObj.atPaint(a: TSVGAttribute): TSVGPaint;
var
  CP: TSVGPaint;
begin
  CP := AttrObj[a].GetPaint;
  if      CP.SW = svg_currentcolor then
    Result := ToSVGPaint(atColorInherit(at_color))
  else if CP.SW <> svg_inherit then
    Result := CP
  else
    Result := Parent.atPaint(a);
end;

function TSVGElementObj.atPAR: TSVGPreserveAspectRatio;
begin
  Result := AttrObj[at_preserveAspectRatio].GetPreserveAspectRatio;
end;

function TSVGElementObj.atPoints: TSinglePointDynArray;
begin
  Result := AttrObj[at_points].GetSinglePointDynSrray;
end;

procedure TSVGElementObj.atSetLengthAuto(a: TSVGAttribute; Value: Single);
begin
  AttrObj[a].SetLengthAuto(Value);
end;

function TSVGElementObj.atSpecificWord(a: TSVGAttribute): TSVGSpecificWord;
begin
  Result := AttrObj[a].GetSpecificWord;
  if Result = svg_inherit then
    Result := Parent.atSpecificWord(a);
end;

function TSVGElementObj.atSpecificWordSet(a: TSVGAttribute): TSVGSpecificWordSet;
begin
  Result := AttrObj[a].GetSpecificWordSet;
  if svg_inherit in Result then
    Result := Parent.atSpecificWordSet(a);
end;

function TSVGElementObj.atString(a: TSVGAttribute): string;
begin
  Result := AttrObj[a].GetString;
end;

function TSVGElementObj.atStringInherit(a: TSVGAttribute): string;
var
  SI: TSVGStringSW;
begin
  SI := AttrObj[a].GetStringInherit;
  if   SI.SW <> svg_inherit then
    Result := SI.S
  else
    Result := Parent.atStringInherit(a);
end;

function TSVGElementObj.atURI(a: TSVGAttribute): string;
begin
  Result := AttrObj[a].GetURI;
end;

function TSVGElementObj.CalcFillOpacity: Single;
begin
  if IsFullOpacity then
    Result := 1.0
  else
    Result := atAlpha(at_fill_opacity) * atAlpha(at_opacity) * Parent.CalcFillOpacity;
end;

procedure TSVGElementObj.CalcMatrix;
var
  i: Integer;
  List: TList;
  Obj: TSVGElementObj;
  M: TSVGTransform;
begin
  List := TList.Create;
  try
    Obj := Self;
    repeat
      List.Add(Obj);
      if Obj.FElement = el_pattern then
        Break;
      Obj := Obj.Parent;
    until Obj = nil;

    FCompleteMatrix := tmIdentity;
    for i := List.Count - 1 downto 0 do
    begin
      Obj := TSVGElementObj(List[i]);
      M := Obj.GetTransform;
      if Obj.FElement = el_svg then
        FInnerMatrix := tmIdentity
      else
        FInnerMatrix := tmMultiply(M, FInnerMatrix);
      FCompleteMatrix := tmMultiply(M, FCompleteMatrix);
    end;
  finally
    List.Free;
  end;
end;

function TSVGElementObj.CalcSelfBounds: TSingleBounds;
begin
  raise Exception.Create(ElementName + '.CalcSelfBounds');
end;

function TSVGElementObj.CalcStrokeOpacity: Single;
begin
  if IsFullOpacity then
    Result := 1.0
  else
    Result := atAlpha(at_stroke_opacity) * atAlpha(at_opacity) * Parent.CalcStrokeOpacity;
end;

procedure TSVGElementObj.CalculateMatrices;
var
  i: Integer;
begin
  if IsOpt(eoMatrix) then
  begin
    CalcMatrix;

    for i := 0 to Count - 1 do
      Items[i].CalculateMatrices;
  end;
end;

procedure TSVGElementObj.ClarifyBounds;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].ClarifyBounds;

  if IsOpt(eoChildBounds) and (Count > 0) then
  begin
    FObjBounds := CalcUnitedChildrenBounds;
    if IsOpt(eoSelfBounds) then
      FObjBounds := SingleBoundsUnion(FObjBounds, CalcSelfBounds)
  end
  else if IsOpt(eoSelfBounds) then
    FObjBounds := CalcSelfBounds;
end;

procedure TSVGElementObj.ClarifyOwnShorthandProperties;
begin
  SplitShorthandProperties(FInlineStyle, css_font);
end;

procedure TSVGElementObj.ClarifyShorthandProperties;
var
  i: Integer;
begin
  ClarifyOwnShorthandProperties;
  for i := 0 to Count - 1 do
    Items[i].ClarifyOwnShorthandProperties;
end;

procedure TSVGElementObj.ClarifyUses;
var
  i: integer;
begin
  if FElement = el_use then
    Tel_use(Self).Construct;
  for i := 0 to Count - 1 do
    Items[i].ClarifyUses;
end;

procedure TSVGElementObj.ClarifyStyleSequences;
var
  i: Integer;
begin
  ConstructStyleSequence;

  for i := 0 to Count - 1 do
    Items[i].ClarifyStyleSequences;
end;

procedure TSVGElementObj.Clear;
var
  a: TSVGAttribute;
begin
  ClearItems;
  FClasses.Clear;
  FInlineStyle.Clear;
  FAttributeStyle.Clear;
  FStylesApplyingSequence.Clear;

  for a := Low(a) to High(a) do
    FreeAndNil(FAttrObj[a]);

  FID := '';
end;

procedure TSVGElementObj.ClearItems;
begin
  while Count > 0 do
    Items[Count - 1].Free;   // !!
end;

function TSVGElementObj.Clone(Parent: TSVGElementObj): TSVGElementObj;
var
  i: Integer;
begin
  Result := New(Parent);
  Result.Assign(Self);

  for i := 0 to Count - 1 do
    Items[i].Clone(Result);
end;

procedure TSVGElementObj.ConstructAttributes(AElement: TSVGElement);
var
  a: TSVGAttribute;
  SumAttributes: TSVGAttributeSet;
begin
  FElement := AElement;

  SumAttributes := SVGElement[Element].Attributes;
  if IsOpt(eoBaseSet) then
    SumAttributes := SumAttributes + BaseAttributes;

  for a := Low(a) to High(a) do
    FIsAttrEnabled[a] := a in SumAttributes;
end;

procedure TSVGElementObj.ConstructPathes;
var
  i: Integer;
begin
  ConstructPath;
  for i := 0 to Count - 1 do
    if Items[i].FElement <> el_pattern then
      Items[i].ConstructPathes;
end;

procedure TSVGElementObj.ConstructPath;
begin
  // Empty
end;

procedure TSVGElementObj.ConstructStyleSequence;
const
  UniversalSelectorName = '*';
var
  i: Integer;
begin
  FStylesApplyingSequence.Clear;

  // Inline style (1000)
  TryAddToSequence(FInlineStyle);

  // Identifiers (100)
  if FID <> '' then
  begin
    TryAddToSequence(ElementName + '#' + FID);
    TryAddToSequence('#' + FID);
  end;

  // Classes (10)
  for i := 0 to FClasses.Count - 1 do
    TryAddToSequence('.' + FClasses[i]);

  // Attribute selectors (10) - skipped for now

  // Pseudo-classes (10) - skipped for now

  // Tag/Element selectors (1)
  TryAddToSequence(ElementName);

  // Pseudo-elements (1) - html only, skipped for now

  // Universal selector(0)
  TryAddToSequence(UniversalSelectorName);

  // Attributes
  TryAddToSequence(FAttributeStyle);

end;

constructor TSVGElementObj.Create(AParent: TSVGElementObj);
begin
  Create;
  if AParent <> nil then
  begin
    FParent := AParent;
    Parent.FItems.Add(Self);
    FRoot := Parent.FRoot;
    if FPattern = nil then
      FPattern := Parent.FPattern;
    if Parent.FElement = el_svg then
      FHostSVG := Parent
    else
      FHostSVG := Parent.FHostSVG;
  end;
end;

constructor TSVGElementObj.Create;
begin
  inherited Create;
  FParent := nil;
  FPattern := nil;
  FItems := TList.Create;
  FInlineStyle := TfrxCSSStyle.Create;
  FAttributeStyle := TfrxCSSStyle.Create;
  FClasses := TStringList.Create;
  FClasses.Delimiter := ' ';
  FStylesApplyingSequence := TList.Create;
  FSwitchedOn := True;
end;

destructor TSVGElementObj.Destroy;
begin
  Clear;

  if Assigned(Parent) then
    Parent.FItems.Remove(Self);

  FItems.Free;
  FInlineStyle.Free;
  FAttributeStyle.Free;
  FClasses.Free;
  FStylesApplyingSequence.Free;

  inherited Destroy;
end;

function TSVGElementObj.ElementName: string;
begin
  Result := SVGElement[FElement].Name;
end;

function TSVGElementObj.FindByID(const SoughtID: string): TSVGElementObj;

  procedure Walk(Obj: TSVGElementObj);
  var
    i: Integer;
  begin
    if Obj.FID = SoughtID then
      Result := Obj
    else
      for i := 0 to Obj.Count - 1 do
      begin
        Walk(Obj[i]);
        if Assigned(Result) then
          Exit;
      end;
  end;

begin
  Result := nil;
  if SoughtID <> '' then
    Walk(Self);
end;

function TSVGElementObj.GetAttrObj(a: TSVGAttribute): TSVGAttributeObj;
begin
   if not FIsAttrEnabled[a] then
     raise Exception.Create('Unsupported: ' + '"' + ElementName + '.' + SVGAttribute[a].Name + '"');

   if FAttrObj[a] = nil then
   begin
     FAttrObj[a] := CreateAttribute(Self, a);
     GetValueFromStyles(FAttrObj[a]);
   end;

   Result := FAttrObj[a];
end;

function TSVGElementObj.GetBounds: TSingleBounds;
begin
  if IsOpt(eoChildBounds) or IsOpt(eoSelfBounds) then
    Result := FObjBounds
  else
    raise Exception.Create(ElementName + '.GetBounds');
end;

function TSVGElementObj.GetCanvasClass: TSVGCanvasClass;
begin
  Result := FRoot.GetCanvasClass;
end;

function TSVGElementObj.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TSVGElementObj.GetHeight: Single;
begin
  Result := FObjBounds.Height;
end;

function TSVGElementObj.GetHostDiagonal: Single;
begin
  Result := Tel_svg(FHostSVG).GetViewBoxDiagonal;
end;

function TSVGElementObj.GetHostHeight: Single;
begin
  Result := Tel_svg(FHostSVG).GetViewBoxHeight;
end;

function TSVGElementObj.GetHostWidth: Single;
begin
  Result := Tel_svg(FHostSVG).GetViewBoxWidth;
end;

function TSVGElementObj.GetIsAttrEnabled(a: TSVGAttribute): Boolean;
begin
  Result := FIsAttrEnabled[a];
end;

function TSVGElementObj.GetItem(const Index: Integer): TSVGElementObj;
begin
  Result := FItems[Index];
end;

function TSVGElementObj.GetPatternFactor: Single;
begin
  if IsInPattern then
    Result := FPattern.GetPatternFactor
  else
    raise Exception.Create('GetPatternFactor outside <pattern>');
end;

function TSVGElementObj.GetDiagonal: Single;
begin
  Result := Sqrt((Sqr(GetWidth) + Sqr(GetHeight)) / 2);
end;

function TSVGElementObj.GetDirectionalHostSize(Direction: TSVGDirection): Single;
begin
  case Direction of
    sdHorizontal: Result := GetHostWidth;
    sdVertical:   Result := GetHostHeight;
    sdDiagonal:   Result := GetHostDiagonal;
  else // sdNo
    raise Exception.Create('Wrong Direction');
  end;
end;

function TSVGElementObj.GetDirectionalSize(Direction: TSVGDirection): Single;
begin
  case Direction of
    sdHorizontal: Result := GetWidth;
    sdVertical:   Result := GetHeight;
    sdDiagonal:   Result := GetDiagonal;
  else // sdNo
    raise Exception.Create('Wrong Direction');
  end;
end;

function TSVGElementObj.GetIsFullOpacity: Boolean;
begin
  Result := FRoot.GetIsFullOpacity;
end;

function TSVGElementObj.GetTransform: TSVGTransform;
begin
  Result := atMatrix(at_transform);
end;

procedure TSVGElementObj.GetValueFromStyles(aObj: TSVGAttributeObj);
var
  i, iLow, iHigh: integer;
begin
  if FStylesApplyingSequence.Count > 0 then
  begin
    iHigh := FStylesApplyingSequence.Count - 1;
    if      aObj.IsCSS then
      iLow := 0
    else if FAttributeStyle.Count = 0 then
      Exit
    else
      iLow := iHigh;

    for i := iLow to iHigh do
      if aObj.IsCanReadSVGValue(TfrxCSSStyle(FStylesApplyingSequence[i])) then
        Break;
  end;
end;

function TSVGElementObj.GetWidth: Single;
begin
  Result := FObjBounds.Width;
end;

function TSVGElementObj.IsOpt(eo: TSVGElementOptions): Boolean;
begin
  Result := eo in SVGElement[FElement].Options;
end;

function TSVGElementObj.IsAttrDefault(a: TSVGAttribute): Boolean;
begin
  Result := not Assigned(FAttrObj[a]) or FAttrObj[a].IsDefault;
end;

function TSVGElementObj.IsForceLengthToPercent: Boolean;
begin
  Result := IsInPattern and FPattern.atIsDefault(at_viewBox) and
    (FPattern.atSpecificWord(at_patternContentUnits) = svg_objectBoundingBox);
end;

function TSVGElementObj.IsInPattern: Boolean;
begin
  Result := (FPattern <> nil) and (FPattern <> Self);
end;

function TSVGElementObj.IsNeedsPainting: Boolean;
begin
  Result :=
    IsOpt(eoPaint) and
    SwitchedOn and
    (atSpecificWord(at_display) <> svg_none) and
    not ((atSpecificWord(at_visibility) in [svg_collapse, svg_hidden]));
end;

function TSVGElementObj.IsRoot: Boolean;
begin
  Result := False;
end;

procedure TSVGElementObj.LogStructure(S: string);
var
  i: Integer;
begin
//  Log(S + SVGElement[FElement].Name + ':' + FID);
//  if Self is TSVGCustomText then
//  begin
//    Log(S + '    ' + '"' + TSVGCustomText(Self).Text + '"');
//    if Length(TSVGCustomText(Self).TextOrigin.X) > 0 then
//      Log(frxFloatToStr(TSVGCustomText(Self).TextOrigin.X[0]) + ':' +
//          frxFloatToStr(TSVGCustomText(Self).GetCompleteWidth));
//  end;
//  Log(S + '    ' + tmToStr(TSVGMatrix(Self).PureMatrix));
  for i := 0 to Count - 1 do
    TSVGElementObj(Items[i]).LogStructure(S + '  ');
end;

procedure TSVGElementObj.ReadChildren(const Node: TfrxSVGXMLItem);
var
  i: Integer;
  Obj: TSVGElementObj;
  Element: TSVGElement;
begin
  for i := 0 to Node.ChildNodes.Count - 1 do
    if IsElementByName(Node.ChildNodes[i].nodeName, Element) then
    begin
      Obj := nil;
      case Element of
        el_a:              Obj := Tel_a.Create(Self);
        el_circle:         Obj := Tel_circle.Create(Self);
        el_clipPath:       Obj := Tel_clipPath.Create(Self);
        el_defs:           Obj := Tel_defs.Create(Self);
        el_ellipse:        Obj := Tel_ellipse.Create(Self);
        el_g:              Obj := Tel_g.Create(Self);
        el_image:          Obj := Tel_image.Create(Self);
        el_line:           Obj := Tel_line.Create(Self);
        el_linearGradient: Obj := Tel_linearGradient.Create(Self);
        el_path:           Obj := Tel_path.Create(Self);
        el_pattern:        Obj := Tel_pattern.Create(Self);
        el_polygon:        Obj := Tel_polygon.Create(Self);
        el_polyline:       Obj := Tel_polyline.Create(Self);
        el_radialGradient: Obj := Tel_radialGradient.Create(Self);
        el_rect:           Obj := Tel_Rect.Create(Self);
        el_stop:           Obj := Tel_stop.Create(Self);

        el_style:          TSVGRootObj(FRoot).ReadStyle(Node.ChildNodes[i]);

        el_svg:            Obj := Tel_svg.Create(Self);
        el_switch:         Obj := Tel_switch.Create(Self);

        el_text:           Obj := Tel_text.Create(Self);
        el_textPath:       Obj := Tel_textPath.Create(Self);
        el_tspan:          Obj := Tel_tspan.Create(Self);
        el_PlainText:      Obj := TSVGCustomText.CreatePlainText(Self, Node.ChildNodes[i].Text, i, Node.ChildNodes.Count);

        el_use:            Obj := Tel_use.Create(Self);
      end;
      if Assigned(Obj) then
        Obj.ReadIn(Node.ChildNodes[i]);
    end;
end;

procedure TSVGElementObj.ReadClasses(st: string);
var
  i: Integer;
begin
  FClasses.DelimitedText := st;
  for i := FClasses.Count - 1 downto 0 do
  begin
    FClasses[i] := Trim(FClasses[i]);
    if FClasses[i] = '' then
      FClasses.Delete(i);
  end;
end;

procedure TSVGElementObj.ReadIn(const Node: TfrxSVGXMLItem);
var
  i: Integer;
begin
  FID := Node.Attributes[SVGAttribute[at_id].Name];

  for i := 0 to Node.AttributeNodes.Count - 1 do
    with Node.AttributeNodes[i] do
      if      nodeName = SVGAttribute[at_style].Name then
        FInlineStyle.SetValuesFromText(nodeValue)
      else if nodeName = SVGAttribute[at_class].Name then
        ReadClasses(nodeValue)
      else
        FAttributeStyle[nodeName] := nodeValue;

   if IsOpt(eoHaveChild) then
     ReadChildren(Node);
end;

function TSVGElementObj.SerialNumber: Integer;
begin
  Result := Parent.FItems.IndexOf(Self);
end;

procedure TSVGElementObj.SetIsAttrEnabled(a: TSVGAttribute; const Value: Boolean);
begin
  FIsAttrEnabled[a] := Value;
end;

procedure TSVGElementObj.SetIsFullOpacity(const Value: Boolean);
begin
  // Empty
end;

procedure TSVGElementObj.SwitchAll;
var
  i: Integer;
begin
  SwitchChildren;
  for i := 0 to Count - 1 do
    if Items[i].FSwitchedOn then
      Items[i].SwitchAll;
end;

procedure TSVGElementObj.SwitchChildren;
begin
  // Empty
end;

procedure TSVGElementObj.TryAddToSequence(Style: TfrxCSSStyle);
begin
  if (Style <> nil) and (Style.Count <> 0) then
    FStylesApplyingSequence.Add(Style);
end;

procedure TSVGElementObj.TryAddToSequence(StyleName: string);
var
  Style: TfrxCSSStyle;
begin
  Style := TSVGRootObj(FRoot).StyleList.GetStyleByName(StyleName);
  TryAddToSequence(Style);
end;

function TSVGElementObj.CalcUnitedChildrenBounds;
var
  i: Integer;
  R: TSingleRect;
begin
  R := ToSingleRect(MaxSingle, MaxSingle, -MaxSingle, -MaxSingle);
  for i := 0 to Count - 1 do
    if Items[i].IsOpt(eoChildBounds) or Items[i].IsOpt(eoSelfBounds) then
      R := SingleRectUnion(R, ToSingleRect(Items[i].GetBounds));

  if IsSameSingle(R.Left, MaxSingle) or IsSameSingle(R.Top, MaxSingle) then
    Result := EmptySingleBounds
  else
    Result := ToSingleBounds(R);
end;

{ TSVGDefs }

constructor Tel_defs.Create;
begin
  inherited Create;
  ConstructAttributes(el_defs);
end;

function Tel_defs.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_defs.Create(Parent);
end;

end.
