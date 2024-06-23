
{******************************************}
{                                          }
{             FastReport VCL               }
{           CSS + SVG Transform            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
unit frCSSTransform;

interface

{$I frVer.inc}

uses
  Types, Math,
  frCoreClasses,
  frSVGParse, frSVGHelpers, frSVGComponents;

type
  TCSSSVGTransformList = class (TfrOwnObjList)
  public
    constructor Create(const S: string);
    function CloneItem(i: Integer): TObject;
    function GetMatrix: TSVGTransform;
    procedure SetTransform(Matrix: TSVGTransform);
    procedure GetRawData(out RawData: TSVGLengthArray; out Direction: TSVGDirectionArray);
    procedure SetData(Data: TSingleDynArray);
  end;

implementation

uses
  SysUtils;

type
  TCSSTransformFunction = (
    tf_matrix,
    tf_rotate,
    tf_scale,
    tf_scaleX,
    tf_scaleY,
    tf_skew,
    tf_skewX,
    tf_skewY,
    tf_translate,
    tf_translateX,
    tf_translateY,
    tf_unknown
  );

const
  CSSTransformFunctionName: array[TCSSTransformFunction] of string = (
    'matrix',
    'rotate',
    'scale',
    'scaleX',
    'scaleY',
    'skew',
    'skewX',
    'skewY',
    'translate',
    'translateX',
    'translateY',
    'unknown'
  );

  UseX = MaxSingle;

type
  TCSSTransformObj = class
  private
    FFunc: TCSSTransformFunction;
    FRawData: TSVGLengthArray;
    FData: TSingleDynArray;
    FDirection: TSVGDirectionArray;

    procedure SetDirection(D: array of TSVGDirection);
  protected
    procedure ParseMatrix(const Values: string);
    procedure ParseRotate(const Values: string);
    procedure ParseScale(const Values: string; DefaultY: Single = UseX);
    procedure ParseScaleX(const Values: string);
    procedure ParseScaleY(const Values: string);
    procedure ParseSkew(const Values: string);
    procedure ParseSkewX(const Values: string);
    procedure ParseSkewY(const Values: string);
    procedure ParseTranslate(const Values: string);
    procedure ParseTranslateX(const Values: string);
    procedure ParseTranslateY(const Values: string);
  public
    constructor Create(const Name, Values: string);
    constructor CreateMatrix(Matrix: TSVGTransform);
    constructor CreateCopy(Twin: TCSSTransformObj);

    function GetMatrix: TSVGTransform;
    procedure GetRawData(RawData: TSVGLengthArray; Direction: TSVGDirectionArray; var Total: Integer);
    procedure SetData(Data: TSingleDynArray; var Current: integer); { TODO : Можно не пересчитывать второй раз? }
  end;

{ Utility routines }

function FuncByName(const Name: string): TCSSTransformFunction;
var
  f: TCSSTransformFunction;
begin
  Result := tf_unknown;
  for f := Low(f) to High(f) do
    if Name = CSSTransformFunctionName[f] then
    begin
      Result := f;
      Break;
    end;
end;

{ TCSSSVGTransformObj }

constructor TCSSTransformObj.Create(const Name, Values: string);
begin
  FFunc := FuncByName(Name);
  case FFunc of
    tf_matrix:     ParseMatrix(Values);

    tf_rotate:     ParseRotate(Values);

    tf_scale:      ParseScale(Values);
    tf_scaleX:     ParseScaleX(Values);
    tf_scaleY:     ParseScaleY(Values);

    tf_skew:       ParseSkew(Values);
    tf_skewX:      ParseSkewX(Values);
    tf_skewY:      ParseSkewY(Values);

    tf_translate:  ParseTranslate(Values);
    tf_translateX: ParseTranslateX(Values);
    tf_translateY: ParseTranslateY(Values);
  end;
end;

constructor TCSSTransformObj.CreateCopy(Twin: TCSSTransformObj);
var
  Len: Integer;
begin
  FFunc := Twin.FFunc;

  Len := Length(Twin.FRawData);

  SetLength(FRawData, Len);
  Move(Twin.FRawData[0], FRawData[0], Len * SizeOf(FRawData[0]));

  SetLength(FDirection, Len);
  Move(Twin.FDirection[0], FDirection[0], Len * SizeOf(FDirection[0]));
end;

constructor TCSSTransformObj.CreateMatrix(Matrix: TSVGTransform);
begin
  FFunc := tf_matrix;

  SetLength(FRawData, 6);
  FRawData[0] := ToSVGLength(Matrix.a);
  FRawData[1] := ToSVGLength(Matrix.b);
  FRawData[2] := ToSVGLength(Matrix.c);
  FRawData[3] := ToSVGLength(Matrix.d);
  FRawData[4] := ToSVGLength(Matrix.e);
  FRawData[5] := ToSVGLength(Matrix.f);

  SetDirection([sdNo, sdNo, sdNo, sdNo, sdHorizontal, sdVertical]);
end;

function TCSSTransformObj.GetMatrix: TSVGTransform;
begin
  case FFunc of
    tf_matrix:     Result := tmMatrix(FData);

    tf_rotate:     Result := tmRotation(FData);

    tf_scale:      Result := tmScaling(FData);
    tf_scaleX:     Result := tmScalingX(FData[0]);
    tf_scaleY:     Result := tmScalingY(FData[0]);

    tf_skew:       Result := tmSkewing(FData);
    tf_skewX:      Result := tmSkewingX(FData[0]);
    tf_skewY:      Result := tmSkewingY(FData[0]);

    tf_translate:  Result := tmTranslation(FData);
    tf_translateX: Result := tmTranslation(FData[0]);
    tf_translateY: Result := tmTranslation(FData[0]);

    tf_unknown:    Result := tmIdentity;
  end;
end;

procedure TCSSTransformObj.GetRawData(RawData: TSVGLengthArray; Direction: TSVGDirectionArray; var Total: Integer);
var
  Len: Integer;
begin
  Len := Length(FRawData);
  Move(FRawData[0], RawData[Total], Len * SizeOf(FRawData[0]));
  Move(FDirection[0], Direction[Total], Len * SizeOf(FDirection[0]));
  Total := Total + Len;
end;

procedure TCSSTransformObj.ParseMatrix(const Values: string);
begin
  ParseLengthArray(Values, FRawData);
  if Length(FRawData) <> 6 then
    FFunc := tf_unknown
  else
    SetDirection([sdNo, sdNo, sdNo, sdNo, sdHorizontal, sdVertical]);
end;

procedure TCSSTransformObj.ParseRotate(const Values: string);
begin
  ParseLengthArray(Values, FRawData);
  if  not Length(FRawData) in [1, 3] then
    FFunc := tf_unknown
  else
    SetDirection([sdNo, sdHorizontal, sdVertical]);
end;

procedure TCSSTransformObj.ParseScale(const Values: string; DefaultY: Single = UseX);
begin
  ParseLengthArray(Values, FRawData);
  if  not Length(FRawData) in [1, 2] then
    FFunc := tf_unknown
  else
  begin
    if Length(FRawData) = 1 then
    begin
      SetLength(FRawData, 2);
      if IsSameSingle(DefaultY, UseX) then
        FRawData[1] := FRawData[0]
      else
        FRawData[1] := ToSVGLength(DefaultY);
    end;
    SetDirection([sdHorizontal, sdVertical]);
  end;
end;

procedure TCSSTransformObj.ParseScaleX(const Values: string);
begin
  ParseLengthArray(Values, FRawData);
  if  not Length(FRawData) in [1] then
    FFunc := tf_unknown
  else
    SetDirection([sdHorizontal]);
end;

procedure TCSSTransformObj.ParseScaleY(const Values: string);
begin
  ParseLengthArray(Values, FRawData);
  if  not Length(FRawData) in [1] then
    FFunc := tf_unknown
  else
    SetDirection([sdVertical]);
end;

procedure TCSSTransformObj.ParseSkew(const Values: string);
begin
  ParseScale(Values, 0);
  SetDirection([sdNo, sdNo]);
end;

procedure TCSSTransformObj.ParseSkewX(const Values: string);
begin
  ParseScaleX(Values);
  SetDirection([sdNo, sdNo]);
end;

procedure TCSSTransformObj.ParseSkewY(const Values: string);
begin
  ParseScaleY(Values);
  SetDirection([sdNo, sdNo]);
end;

procedure TCSSTransformObj.ParseTranslate(const Values: string);
begin
  ParseScale(Values, 0);
end;

procedure TCSSTransformObj.ParseTranslateX(const Values: string);
begin
  ParseScaleX(Values);
end;

procedure TCSSTransformObj.ParseTranslateY(const Values: string);
begin
  ParseScaleY(Values);
end;

procedure TCSSTransformObj.SetData(Data: TSingleDynArray; var Current: integer);
var
  Len, i: Integer;
begin
  Len := Length(FRawData); // !
  SetLength(FData, Len);
  Move(Data[Current], FData[0], Len * SizeOf(FData[0]));
  Current := Current + Len;

  case FFunc of
    tf_rotate:
      FData[0] := DegToRad(FData[0]);
    tf_skew, tf_skewX, tf_skewY:
      for i := 0 to Len - 1 do
        FData[i] := Tan(DegToRad(FData[i]));
  end;
end;

{ TCSSSVGTransformList }

function TCSSSVGTransformList.CloneItem(i: Integer): TObject;
begin
  Result := TCSSTransformObj.CreateCopy(TCSSTransformObj(Items[i]));
end;

constructor TCSSSVGTransformList.Create(const S: string);
var
  Start, Stop: Integer;
  st, FunctionName, Values: string;
  TransformObj: TCSSTransformObj;
begin
  inherited Create;
  st := Trim(S);
  while st <> '' do
  begin
    Start := Pos('(', st);
    Stop := Pos(')', st);
    if (Start = 0) or (Stop = 0) then
      Exit;
    FunctionName := Copy(st, 1, Start - 1);
    Values := Trim(Copy(st, Start + 1, Stop - Start - 1));
    Values := StringReplace(Values, ' ', ',', [rfReplaceAll]);

    TransformObj := TCSSTransformObj.Create(FunctionName, Values);
    if TransformObj.FFunc = tf_unknown then
      TransformObj.Free
    else
      Add(TransformObj);

    st := Trim(Copy(st, Stop + 1, Length(st)));
  end;
end;

function TCSSSVGTransformList.GetMatrix: TSVGTransform;
var
  i: Integer;
begin
  Result := tmIdentity;
  for i := Count - 1 downto 0 do
    Result := tmMultiply(Result, TCSSTransformObj(Items[i]).GetMatrix);
end;

procedure TCSSSVGTransformList.GetRawData(out RawData: TSVGLengthArray; out Direction: TSVGDirectionArray);
var
  i, Total: Integer;
begin
  Total := 0;
  SetLength(RawData,  6 * Count); // max possible length
  SetLength(Direction, Length(RawData));

  for i := 0 to Count - 1 do
    TCSSTransformObj(Items[i]).GetRawData(RawData, Direction, Total);

  SetLength(RawData, Total); // actual length
  SetLength(Direction, Length(RawData));
end;

procedure TCSSSVGTransformList.SetData(Data: TSingleDynArray);
var
  i, Current: Integer;
begin
  Current := 0;

  for i := 0 to Count - 1 do
    TCSSTransformObj(Items[i]).SetData(Data, Current);
end;

procedure TCSSSVGTransformList.SetTransform(Matrix: TSVGTransform);
begin
  Add(TCSSTransformObj.CreateMatrix(Matrix));
end;

procedure TCSSTransformObj.SetDirection(D: array of TSVGDirection);
var
  Len: Integer;
begin
  Len := Length(D);
  SetLength(FDirection, Len);
  Move(D[0], FDirection[0], Len * SizeOf(D[0]));
end;

end.
