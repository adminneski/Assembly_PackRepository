
{******************************************}
{                                          }
{             FastReport VCL               }
{       Parse of SVG property values       }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGParse;

interface

{$I frVer.inc}

uses
  Windows, Classes,
  frSVGHelpers, frSVGComponents, frCSSStyle;

type
  // https://www.w3.org/TR/css-values/#lengths
  TSVGUnit = (suNone, suPX, suPT, suPC, suIN, suMM, suCM, suEM, suEX, suPercent,
  // https://webref.ru/css/value/angle
    suDeg, suGrad, suRad, suTurn);

const
  SVGAbsoluteUnits = [suNone .. suCM, suDeg..suTurn];
  SVGFontRelativeUnits = [suEM .. suEX];

type
  TSVGLength = record
    Value: Single;
    SVGUnit: TSVGUnit;
  end;

  TSVGLengthSW = record
    SW: TSVGSpecificWord;
    Value: Single;
    SVGUnit: TSVGUnit;
  end;

  TNumberSW = record
    SW: TSVGSpecificWord;
    Value: Single;
  end;

  TSVGLengthArray = array of TSVGLength;

  TSVGLengthArraySW = record
    Arr: TSVGLengthArray;
    SW: TSVGSpecificWord;
  end;

  TSVGStringSW = record
    SW: TSVGSpecificWord;
    S: string;
  end;

  TSVGUnits = record
    Name: string;
    Factor: Single;
  end;

  TSVGPreserveAspectRatio = record
    Align, MeetOrSlice: TSVGSpecificWord;
  end;

procedure ParseSingle(const S: string; var Value: Single);

procedure ParseAlpha(const S: string; var Value: Single); 

procedure ParsePercentage(const S: string; var Value: Single);

procedure ParsePoints(const S: string; var Value: TSinglePointDynArray);

procedure ParseString(const S: string; var Value: string); //overload;
procedure ParseStringInherit(const S: string; var Value: TSVGStringSW);

procedure ParseLength(const S: string; var Value: TSVGLength; const Units: TSVGSpecificWord = svg_userSpaceOnUse);
procedure ParseLengthSW(const S: string; SW: TSVGSpecificWord; var Value: TSVGLengthSW);
procedure ParseLengthArray(const S: string; var Value: TSVGLengthArray);
procedure ParseLengthArrayNoneInherit(const S: string; var Value: TSVGLengthArraySW);

procedure ParseNumber(const S: string; var Value: Single);
procedure ParseNumberInherit(const S: string; var Value: TNumberSW);

procedure ParseViewBox(const S: string; var Value: TSingleBounds);

procedure ParseURI(const URI: string; var Value: string);

procedure ParseTextDecorations(const S: string; var Value: TSVGSpecificWordSet);

procedure ParseFontWeight(const S: string; var Value: TNumberSW);

procedure SplitShorthandProperties(const Style: TfrxCSSStyle; const SW: TSVGSpecificWord);
function ToSVGLength(Value: Single; SVGUnit: TSVGUnit = suNone): TSVGLength; overload;
function ToSVGLength(Value: TSVGLengthSW): TSVGLength; overload;
function ToSVGLength(Value: TSVGLengthSW; AutoLength: TSVGLength): TSVGLength; overload;
function ToLengthSW(SW: TSVGSpecificWord; Value: Single; SVGUnit: TSVGUnit = suNone): TSVGLengthSW;
function ToStringInherit(S: string): TSVGStringSW;
function RelativeFontWeight(SW: TSVGSpecificWord; BaseWeight: Single): Single;

procedure ParsePreserveAspectRatio(const S: string; var Value: TSVGPreserveAspectRatio);

function CalcScale(Width, Height: Single; ViewBox: TSingleBounds;
  PreserveAspectRatio: TSVGPreserveAspectRatio): TSinglePoint;

function CalcOffset(Scale: TSinglePoint; Width, Height: Single; ViewBox: TSingleBounds;
  PreserveAspectRatio: TSVGPreserveAspectRatio): TSinglePoint;

implementation

uses
  SysUtils, Math, StrUtils,
  frCoreClasses, frUtils;

const
  SVGUnits: array[TSVGUnit] of TSVGUnits = (
    (Name: '';     Factor: 1),         // suNone
    (Name: 'px';   Factor: 1),             // suPX
    (Name: 'pt';   Factor: 96 / 72),       // suPT
    (Name: 'pc';   Factor: 96 / 6),        // suPC
    (Name: 'in';   Factor: 96 ),           // suIN
    (Name: 'mm';   Factor: 96 / 25.4),     // suMM
    (Name: 'cm';   Factor: 96 / 2.54),     // suCM
    (Name: 'em';   Factor: 1),         // suEM
    (Name: 'ex';   Factor: 0.5),       // suEX - In the cases where it is impossible or impractical to determine the x-height, a value of 0.5em must be assumed.
    (Name: '%';    Factor: 1),             // suPercent
    (Name: 'deg';  Factor: 1),         // suDeg
    (Name: 'grad'; Factor: 400 / 360), // suGrad
    (Name: 'rad';  Factor: 180 / Pi),  // suRad
    (Name: 'turn'; Factor: 360)        // suTurn
  );

function CalcScale(Width, Height: Single; ViewBox: TSingleBounds;
  PreserveAspectRatio: TSVGPreserveAspectRatio): TSinglePoint;
var
  Ratio: TSinglePoint;
begin
  if (ViewBox.Width = 0) or (ViewBox.Height = 0) or
     (Width = 0) or (Height = 0) then
    Result := ToSinglePoint(1, 1)
  else
  begin
    Ratio.X := Width / ViewBox.Width;
    Ratio.Y := Height / ViewBox.Height;

    if PreserveAspectRatio.Align = svg_none then
      Result := Ratio
    else
    begin
      if PreserveAspectRatio.MeetOrSlice = svg_meet then
        Result.X := Min(Ratio.X, Ratio.Y)
      else // PreserveAspectRatio.MeetOrSlice = msSlice
        Result.X := Max(Ratio.X, Ratio.Y);
      Result.Y := Result.X;
    end;
  end;
end;

function CalcOffset(Scale: TSinglePoint; Width, Height: Single; ViewBox: TSingleBounds;
  PreserveAspectRatio: TSVGPreserveAspectRatio): TSinglePoint;
var
  fViewMid, fMid: TSinglePoint;
begin
  if (ViewBox.Width = 0) or (ViewBox.Height = 0) or
     (Width = 0) or (Height = 0) then
    Result := ToSinglePoint(0, 0)
  else
  begin
    fViewMid := ToSinglePoint((ViewBox.Width / 2) * Scale.X,
                       (ViewBox.Height / 2) * Scale.Y);
    fMid := ToSinglePoint(Width / 2, Height / 2);
    Result := ToSinglePoint(ViewBox.X * Scale.X, ViewBox.Y * Scale.Y);
    case PreserveAspectRatio.Align of
      svg_none: ;
      svg_xMinYMin: ;
      svg_xMinYMid:
        Result.Y := Result.Y - (fMid.Y - fViewMid.Y);
      svg_xMinYMax:
        Result.Y := Result.Y - (Height - ViewBox.Height * Scale.Y);
      svg_xMidYMin:
        Result.X := Result.X - (fMid.X - fViewMid.X);
      svg_xMidYMid:
        Result := ToSinglePoint(Result.X - (fMid.X - fViewMid.X),
                                Result.Y - (fMid.Y - fViewMid.Y));
      svg_xMidYMax:
        Result := ToSinglePoint(Result.X - (fMid.X - fViewMid.X),
                                Result.Y - (Height - ViewBox.Height * Scale.Y));
      svg_xMaxYMin:
        Result.X := Result.X - (Width - ViewBox.Width * Scale.X);
      svg_xMaxYMid:
        Result := ToSinglePoint(Result.X - (Width - ViewBox.Width * Scale.X),
                                Result.Y - (fMid.Y - fViewMid.Y));
      svg_xMaxYMax:
        Result := ToSinglePoint(Result.X - (Width - ViewBox.Width * Scale.X),
                                Result.Y - (Height - ViewBox.Height * Scale.Y));
    end;
  end;
end;

procedure ParseMeetOrSlice(S: string; var Value: TSVGSpecificWord);
begin
  if      S = SVGSpecificWord[svg_meet] then  Value := svg_meet
  else if S = SVGSpecificWord[svg_slice] then Value := svg_slice;
end;

procedure ParseAlign(const S: string; var Value: TSVGSpecificWord);
begin
  if      S = SVGSpecificWord[svg_none] then     Value := svg_none
  else if S = SVGSpecificWord[svg_xMinYMin] then Value := svg_xMinYMin
  else if S = SVGSpecificWord[svg_xMinYMid] then Value := svg_xMinYMid
  else if S = SVGSpecificWord[svg_xMinYMax] then Value := svg_xMinYMax
  else if S = SVGSpecificWord[svg_xMidYMin] then Value := svg_xMidYMin
  else if S = SVGSpecificWord[svg_xMidYMid] then Value := svg_xMidYMid
  else if S = SVGSpecificWord[svg_xMidYMax] then Value := svg_xMidYMax
  else if S = SVGSpecificWord[svg_xMaxYMin] then Value := svg_xMaxYMin
  else if S = SVGSpecificWord[svg_xMaxYMid] then Value := svg_xMaxYMid
  else if S = SVGSpecificWord[svg_xMaxYMax] then Value := svg_xMaxYMax;
end;

procedure ParsePreserveAspectRatio(const S: string; var Value: TSVGPreserveAspectRatio);
const
  NotFound = 0;
var
  st: string;
  SpacePos: Integer;
begin
  st := Trim(S);
  if st <> '' then
  begin
    SpacePos := Pos(' ', st);
    if SpacePos = NotFound then
      ParseAlign(st, Value.Align)
    else
    begin
      ParseAlign(Copy(st, 1, SpacePos - 1), Value.Align);
      ParseMeetOrSlice(Copy(st, SpacePos + 1, MaxInt), Value.MeetOrSlice);
    end;
  end;
end;

function RelativeFontWeight(SW: TSVGSpecificWord; BaseWeight: Single): Single;
begin
  if      (SW = svg_bolder) and (BaseWeight < FW_NORMAL) then
    Result := FW_NORMAL
  else if (SW = svg_bolder) and (BaseWeight < FW_BOLD) then
    Result := FW_BOLD
  else if (SW = svg_lighter) and (BaseWeight > FW_BOLD) then
    Result := FW_BOLD
  else if (SW = svg_lighter) and (BaseWeight > FW_NORMAL) then
    Result := FW_NORMAL
  else
    Result := BaseWeight;

end;

function ToStringInherit(S: string): TSVGStringSW;
begin
  Result.SW := frx_noMater;
  Result.S := S;
end;

function ToLengthSW(SW: TSVGSpecificWord; Value: Single; SVGUnit: TSVGUnit = suNone): TSVGLengthSW;
begin
  Result.SW := SW;
  Result.Value := Value;
  Result.SVGUnit := SVGUnit;
end;

function ToSVGLength(Value: TSVGLengthSW): TSVGLength;
begin
  Result := ToSVGLength(Value.Value, Value.SVGUnit);
end;

function ToSVGLength(Value: TSVGLengthSW; AutoLength: TSVGLength): TSVGLength;
begin
  if Value.SW = svg_auto then
    Result := AutoLength
  else
    Result := ToSVGLength(Value.Value, Value.SVGUnit);
end;

function ToSVGLength(Value: Single; SVGUnit: TSVGUnit = suNone): TSVGLength;
begin
  Result.Value := Value;
  Result.SVGUnit := SVGUnit;
end;

procedure SplitFont(const Style: TfrxCSSStyle; const S: string);
var
  SL: TStringList;
  Value, FontFamilyName: string;
begin
  SL := SplitCSSFont(S);
  if SL <> nil then
    try
      FontFamilyName := '';
      while SL.Count > 0 do
      begin
        Value := SL[0];
        if IsStrInSet(Value, [SVGSpecificWord[svg_italic],
                              SVGSpecificWord[svg_oblique],
                              SVGSpecificWord[svg_normal]]) then
          Style[SVGAttribute[at_font_style].Name] := Value
        else if IsStrInSet(Value, [SVGSpecificWord[svg_bold],
                                   SVGSpecificWord[svg_bolder],
                                   SVGSpecificWord[svg_lighter]]) then
          Style[SVGAttribute[at_font_weight].Name] := Value
        else if CharInSet(Value[1], ['0' .. '9']) then
          Style[SVGAttribute[at_font_size].Name] := Value
        else if Value[1] = '/' then // line-height
        begin
        end
        else // Font Family Name
          FontFamilyName := FontFamilyName + frIfStr(FontFamilyName <> '', ' ') + Value;
        SL.Delete(0);
      end;

      if Style.IsHasKey(SVGAttribute[at_font_style].Name) or
         Style.IsHasKey(SVGAttribute[at_font_weight].Name) or
         Style.IsHasKey(SVGAttribute[at_font_size].Name) then
      begin
        if not Style.IsHasKey(SVGAttribute[at_font_style].Name) then
          Style[SVGAttribute[at_font_style].Name] := SVGSpecificWord[svg_normal];

        if not Style.IsHasKey(SVGAttribute[at_font_weight].Name) then
          Style[SVGAttribute[at_font_weight].Name] := SVGSpecificWord[svg_normal];
      end;

      if FontFamilyName <> '' then
        Style[SVGAttribute[at_font_family].Name] := FontFamilyName;
    finally
      SL.Free;
    end;
end;

procedure SplitShorthandProperties(const Style: TfrxCSSStyle; const SW: TSVGSpecificWord);
var
  S: string;
begin
  S := Style[SVGSpecificWord[SW]];
  if S <> '' then
    if SW = css_font then
      SplitFont(Style, S);
end;

procedure ParseFontWeight(const S: string; var Value: TNumberSW);
begin
  if S <> '' then
  begin
    if      S = SVGSpecificWord[svg_bolder] then  Value.SW := svg_bolder
    else if S = SVGSpecificWord[svg_lighter] then Value.SW := svg_lighter
    else                                          Value.SW := frx_noMater;

    if      S = SVGSpecificWord[svg_normal] then Value.Value := FW_NORMAL
    else if S = SVGSpecificWord[svg_bold] then   Value.Value := FW_BOLD
    else                                         Value.Value := StrToInt(S);
  end;
end;

procedure ParseTextDecorations(const S: string; var Value: TSVGSpecificWordSet);
var
  SL: TStrings;
  i: Integer;
begin
  if S = '' then
    Exit;

  Value := [];
  SL := frToStringList(S, ' ');
  try
    for i := 0 to SL.Count - 1 do
      if      SL[i] = SVGSpecificWord[svg_underline] then
        Include(Value, svg_underline)
      else if SL[i] = SVGSpecificWord[svg_overline] then
        Include(Value, svg_overline)
      else if SL[i] = SVGSpecificWord[svg_line_through] then
        Include(Value, svg_line_through);
  finally
    SL.Free;
  end;
end;

function ParseAngle(const Angle: string): Single;
var
  D: Single;
  C: Integer;
  S: string;
begin
  if Angle <> '' then
  begin
    S := Angle;
    C := Pos('deg', S);
    if C <> 0 then
    begin
      S := LeftStr(S, C - 1);
      if TryStrToSingle(S, D) then
        Result := DegToRad(D)
      else
        Result := 0;
      Exit;
    end;

    C := Pos('rad', S);
    if C <> 0 then
    begin
      TryStrToSingle(S, Result);
      Exit;
    end;

    C := Pos('grad', S);
    if C <> 0 then
    begin
      S := LeftStr(S, C - 1);
      if TryStrToSingle(S, D) then
        Result := GradToRad(D)
      else
        Result := 0;
      Exit;
    end;

    if TryStrToSingle(S, D) then
      Result := DegToRad(D)
    else
      Result := 0;
  end
  else
    Result := 0;
end;

procedure ParseStringInherit(const S: string; var Value: TSVGStringSW);
begin
  if      S = SVGSpecificWord[svg_inherit] then
    Value.SW := svg_inherit
  else if S <> '' then
  begin
    Value.SW := frx_noMater;
    Value.S := S;
  end;
end;

procedure ParsePoints(const S: string; var Value: TSinglePointDynArray);
var
  st: string;
  SL: TStrings;
  i: Integer;
begin
  if S = '' then
    Exit;

  st := StringReplace(S, ',', ' ', [rfReplaceAll]);
  st := frNormalizeScientificNotation(st);

  SL := frToStringList(st, ' ');
  try
    if SL.Count mod 2 = 0 then
    begin
      SetLength(Value, SL.Count div 2);
      for i := 0 to High(Value) do
        Value[i] := ToSinglePoint(SL[i * 2], SL[i * 2 + 1]);
    end;
  finally
    SL.Free;
  end;
end;

procedure ParseString(const S: string; var Value: string);
begin
  if S <> '' then
    Value := S;
end;

procedure ParsePercentage(const S: string; var Value: Single);
begin
  if S <> '' then
  begin
    if S[Length(S)] = '%' then
      Value := StrToSingle(LeftStr(S, Length(S) - 1)) / 100
    else
      Value := StrToSingle(S);
  end;
end;

procedure ParseAlpha(const S: string; var Value: Single);
begin
  if S <> '' then
  begin
    if S[Length(S)] = '%' then
      Value := StrToSingle(LeftStr(S, Length(S) - 1)) / 100
    else
      Value := StrToSingle(S);
    Value := frLimit(Value, 0.0, 1.0);
  end;
end;

procedure ParseSingle(const S: string; var Value: Single);
begin
  if S <> '' then
    Value := StrToSingle(S);
end;

function ParseUnit(const S: string): TSVGUnit;
var
  u: TSVGUnit;
  P: Integer;
begin
  Result := suNone;
  for u := Low(u) to High(u) do
  begin
    P := Pos(SVGUnits[u].Name, S);
    if (P > 0) and
       (P - 1 + Length(SVGUnits[u].Name) = Length(S)) then // found at the end
    begin
      Result := u;
      Break;
    end;
  end;
end;

procedure ParseNumber(const S: string; var Value: Single);
begin
  TryStrToSingle(S, Value);
end;

procedure ParseNumberInherit(const S: string; var Value: TNumberSW);
begin
  if      S = SVGSpecificWord[svg_inherit] then
    Value.SW := svg_inherit
  else if S <> '' then
  begin
    ParseNumber(S, Value.Value);
    Value.SW := frx_noMater;
  end;
end;

procedure ParseLengthSW(const S: string; SW: TSVGSpecificWord; var Value: TSVGLengthSW);
var
  SL: TSVGLength;
begin
  if      S = SVGSpecificWord[SW] then
    Value.SW := SW
  else if S <> '' then
  begin
    ParseLength(S, SL);
    Value.Value := SL.Value;
    Value.SVGUnit := SL.SVGUnit;
    Value.SW := frx_noMater;
  end;
end;

procedure ParseLengthArrayNoneInherit(const S: string; var Value: TSVGLengthArraySW);
begin
  if S <> '' then
    if      S = SVGSpecificWord[svg_none] then
      Value.SW := svg_none
    else if S = SVGSpecificWord[svg_inherit] then
      Value.SW := svg_inherit
    else
    begin
      Value.SW := frx_noMater;
      ParseLengthArray(S, Value.Arr);
    end;

end;

procedure ParseLengthArray(const S: string; var Value: TSVGLengthArray);
var
  st: string;
  SL: TStrings;
  i: Integer;
begin
  if S <> '' then
  begin
    st := S;
    st := StringReplace(st, ',', ' ', [rfReplaceAll]);
    st := frNormalizeScientificNotation(st);
    SL := frToStringList(st, ' ');
    try
      for i := SL.Count - 1 downto 0 do
      begin
        SL[i] := Trim(SL[i]);
        if SL[i] = '' then
          SL.Delete(i);
      end;
      SetLength(Value, SL.Count);
      for i := 0 to SL.Count - 1 do
        ParseLength(Sl[i], Value[i]);
    finally
      SL.Free;
    end;
  end;
end;

procedure ParseLength(const S: string; var Value: TSVGLength; const Units: TSVGSpecificWord = svg_userSpaceOnUse);
var
  U: string;
  SVGUnit: TSVGUnit;
  V: TSVGLength;
begin
  if S <> '' then
  begin
    SVGUnit := ParseUnit(S);

    U := Copy(S, 1, Length(S) - Length(SVGUnits[SVGUnit].Name));
    V.Value := StrToSingle(U) * SVGUnits[SVGUnit].Factor;

    if      (Units = svg_userSpaceOnUse) or (SVGUnit = suPercent) then
      V.SVGUnit := SVGUnit
    else if (Units = svg_objectBoundingBox) and (SVGUnit = suNone) then
    begin
      V.Value := V.Value * 100;
      V.SVGUnit := suPercent;
    end
    else
      Exit;

    Value := V;
  end;
end;

procedure ParseViewBox(const S: string; var Value: TSingleBounds);
var
  SL: TStrings;
  NoCommas: string;
begin
  if S <> '' then
  begin
    FillChar(Value, SizeOf(Value), 0);
    NoCommas := StringReplace(S, ',', ' ', [rfReplaceAll]);
    SL := frToStringList(Trim(NoCommas), ' ');

    try
      if SL.Count = 4 then
      begin
        Value.X := StrToSingle(SL[0]);
        Value.Y := StrToSingle(SL[1]);
        Value.Width := StrToSingle(SL[2]);
        Value.Height := StrToSingle(SL[3]);
      end;
    finally
      SL.Free;
    end;
  end;
end;

procedure ParseURI(const URI: string; var Value: string);
begin
  if (URI <> '') and (Copy(URI, 1, 5) = 'url(#') and (URI[Length(URI)] = ')') then
    Value := Dequote(Copy(URI, 6, Length(URI) - 6));
end;

function GetMatrix(const S: string): TSVGTransform;
var
  SL: TStrings;
begin
  Result := tmIdentity;
  SL := frToStringList(S, ',');
  try
    if SL.Count = 6 then
    begin
      Result.a := StrToSingle(SL[0]);
      Result.b := StrToSingle(SL[1]);
      Result.c := StrToSingle(SL[2]);
      Result.d := StrToSingle(SL[3]);
      Result.e := StrToSingle(SL[4]);
      Result.f := StrToSingle(SL[5]);
    end;
  finally
    SL.Free;
  end;
end;

function GetTranslate(const S: string): TSVGTransform;
var
  SL: TStrings;
begin
  FillChar(Result, SizeOf(Result), 0);
  SL := frToStringList(S, ',');
  try
    if SL.Count = 1 then
      SL.Add('0');

    if SL.Count = 2 then
      Result := tmTranslation(StrToSingle(SL[0]), StrToSingle(SL[1]));
  finally
    SL.Free;
  end;
end;

function GetScale(const S: string): TSVGTransform;
var
  SL: TStrings;
begin
  FillChar(Result, SizeOf(Result), 0);
  SL := frToStringList(S, ',');
  try
    if SL.Count = 1 then
      SL.Add(SL[0]);
    if SL.Count = 2 then
    begin
      Result := tmScaling(StrToSingle(SL[0]), StrToSingle(SL[1]));
    end;
  finally
    SL.Free;
  end;
end;

function GetRotation(const S: string): TSVGTransform;
var
  SL: TStrings;
  X, Y, Angle: Single;
begin
  SL := frToStringList(S, ',');
  try
    Angle := ParseAngle(SL[0]);

    if SL.Count = 3 then
    begin
      X := StrToSingle(SL[1]);
      Y := StrToSingle(SL[2]);
    end
    else
    begin
      X := 0;
      Y := 0;
    end;
  finally
    SL.Free;
  end;

  Result := tmTranslation(X, Y);
  Result := tmMultiply(tmRotation(Angle), Result);
  Result := tmMultiply(tmTranslation(-X, -Y), Result);
end;

function GetSkewX(const S: string): TSVGTransform;
var
  SL: TStrings;
begin
  FillChar(Result, SizeOf(Result), 0);

  SL := frToStringList(S, ',');
  try
    if SL.Count = 1 then
    begin
      Result := tmIdentity;
      Result.c := Tan(StrToSingle(SL[0]) * Pi / 180);
    end;
  finally
    SL.Free;
  end;
end;

function GetSkewY(const S: string): TSVGTransform;
var
  SL: TStrings;
begin
  FillChar(Result, SizeOf(Result), 0);

  SL := frToStringList(S, ',');
  try
    if SL.Count = 1 then
    begin
      Result := tmIdentity;
      Result.b := Tan(StrToSingle(SL[0]) * Pi / 180);
    end;
  finally
    SL.Free;
  end;
end;

end.
