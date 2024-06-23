
{******************************************}
{                                          }
{             FastReport VCL               }
{               SVG Helpers                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frSVGHelpers;

interface

{$I frVer.inc}

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  Classes, Types, Graphics, frXML;

type
  TfrxSVGXMLReader = class(TfrValuedXMLReader)
  protected
    FLastText: Boolean; // '<' already read
    constructor Create(Stream: TStream);
    procedure ProcessSecondLeftBrocket; override;
    function CreateItem: TfrXMLItem; override;
    procedure ReadValuedItem(out {$IFDEF DELPHI12}NameS, ValueS{$ELSE}Name, Value{$ENDIF}, Text: String); override;
  end;

  TfrxSVGXMLItem = class;

  TfrxSVGXMLDocument = class(TfrValuedXMLDocument)
  protected
    procedure ReadXMLHeader; override;
    function CreateReader: TfrValuedXMLReader; override;
    procedure LoadFromValuedStream;
  public
    constructor Create(Ignored: Pointer);
    procedure LoadFromXML(const XML: String);
  end;

  TfrxSVGIXMLChildNodes = class
  private
    function GetItems(Index: Integer): TfrxSVGXMLItem;
    function GetCount: Integer;
  protected
    FItems: TList;
  public
    constructor Create(AItems: TList);
    property Items[Index: Integer]: TfrxSVGXMLItem read GetItems; default;
    property Count: Integer read GetCount;
  end;

  TfrxSVGNameValue = record
    NodeName, NodeValue: string;
  end;

  TfrxSVGAttributeNodes = class
  private
    function GetCount: Integer;
    function GetNameValue(i: Integer): TfrxSVGNameValue;
    function GetValueByName(NodeName: string): string;
  protected
    SL: TStringList;
  public
    constructor Create(Text: string);
    destructor Destroy; override;
    function IndexOfName(const s: string): Integer;
    function IsHasAttribute(const s: string): Boolean;
    function FindNode(s: string): TfrxSVGXMLItem;

    property Count: Integer read GetCount;
    property NameValue[i: Integer]: TfrxSVGNameValue read GetNameValue; default;
    property ValueByName[NodeName: string]: string read GetValueByName;
  end;

  TfrxSVGXMLItem = class(TfrXMLItem)
  private
    FChildNodes: TfrxSVGIXMLChildNodes;
    FAttributeNodes: TfrxSVGAttributeNodes;

    function GetChildNodes: TfrxSVGIXMLChildNodes;
    function GetNodeValue: string;
    function GetNodeName: string;
    function GetAttributes(s: string): string;
    function GetHRef: string;
  protected
  public
    destructor Destroy; override;
    procedure AddItem(Item: TfrXMLItem); override;
    function HasAttribute(s: string): Boolean;
    procedure SetData(const AName, AText, AValue: String); override;

    property ChildNodes: TfrxSVGIXMLChildNodes read GetChildNodes;
    property NodeValue: string read GetNodeValue;
    property NodeName: string read GetNodeName;
    property AttributeNodes: TfrxSVGAttributeNodes read FAttributeNodes;
    property Attributes[s: string]: string read GetAttributes;
    property HRef: string read GetHRef;
  end;

function SplitCSSFont(st: string): TStringList;
function SuitableFont(FontList: string): string;

function IsStrInSet(Str: string; StrSet: array of string): Boolean;

{$IFNDEF DELPHI12}
type
  TSysCharset = set of Char; 
function CharInSet(Ch: Char; CharSet: TSysCharset): Boolean;
{$ENDIF}

type
  TSinglePoint = record
    X, Y: Single;
  end;

  TSinglePointDynArray = array of TSinglePoint;

function spCreate(X, Y: Single): TSinglePoint;
function spMultiply(SP: TSinglePoint; Factor: Single): TSinglePoint;
function spDivide(SP: TSinglePoint; Factor: Single): TSinglePoint;

function DynArrayCopy(DynArray: TSinglePointDynArray): TSinglePointDynArray; overload;
function DynArrayCopy(DynArray: TSingleDynArray): TSingleDynArray; overload;

type
  TSingleSize = record
    Width, Height: Single;
  end;

  TSingleBounds = record
    case Byte of
      0: (X, Y, Width, Height: Single);
      1: (TopLeft: TSinglePoint; Size: TSingleSize);
  end;

  TSingleRect = record
    case Byte of
      0: (Left, Top, Right, Bottom: Single);
      1: (TopLeft, BottomRight: TSinglePoint);
  end;

const
  EmptySingleBounds: TSingleBounds = (X: 0.0; Y: 0.0; Width: 0.0; Height:0.0);

function ToSinglePoint(const X, Y: Single): TSinglePoint; overload;
function ToSinglePoint(const SX, SY: string): TSinglePoint; overload;
function SinglePointSum(const p1, p2: TSinglePoint): TSinglePoint;
function SinglePointDiff(const p1, p2: TSinglePoint): TSinglePoint;
function SinglePointCenter(const p1, p2: TSinglePoint): TSinglePoint;
function ToSingleSize(const Width, Height: Single): TSingleSize;
function ToSingleBounds(const X, Y, Width, Height: Single): TSingleBounds; overload;
function ToSingleBounds(const Rect: TSingleRect): TSingleBounds; overload;
function ToSingleBounds(const Rect: TRect): TSingleBounds; overload;
function SingleBoundsUnion(const B1, B2: TSingleBounds): TSingleBounds;
function ToSingleRect(const Bounds: TSingleBounds): TSingleRect; overload;
function ToSingleRect(const Left, Top, Right, Bottom: Single): TSingleRect; overload;
function ToSingleRect(const A: TSinglePointDynArray): TSingleRect; overload;
function SingleRectUnion(const R1, R2: TSingleRect): TSingleRect;

function IsSameSingle(const A, B: Single; Epsilon: Single = 0): Boolean; // for D7
function IsSameBounds(const B1, B2: TSingleBounds): boolean;
function IsSameSinglePoint(const p1, p2: TSinglePoint): boolean;

type
//[0, 0] / a / m11 / eM11     [1, 0] / b / m12 / eM12
//[0, 1] / ñ / m21 / eM21     [1, 1] / d / m22 / eM22
//[0, 2] / e / m31 / eDx      [1, 2] / f / m32 / eDy
  TSVGTransform = record
    a, b, c, d, e, f: Single;  // m11, m12, m21, m22, m31, m32
  end;

const
  EmptyTransform: TSVGTransform = (a: 0.0; b: 0.0; c: 0.0; d: 0.0; e: 0.0; f: 0.0);

function tmIdentity: TSVGTransform;
function tmMultiply(const M1, M2: TSVGTransform): TSVGTransform;

function tmMatrix(const a, b, c, d, e, f: Single): TSVGTransform; overload;
function tmMatrix(const Data: TSingleDynArray): TSVGTransform; overload;

function tmRotation(const Alpha: Single): TSVGTransform; overload;
function tmRotation(const Alpha, X, Y: Single): TSVGTransform; overload;
function tmRotation(const Data: TSingleDynArray): TSVGTransform; overload;

function tmScaling(const Data: TSingleDynArray): TSVGTransform; overload;
function tmScaling(const ScaleX, ScaleY: Single): TSVGTransform; overload;
function tmScaling(const Scale: Single): TSVGTransform; overload;
function tmScalingX(const ScaleX: Single): TSVGTransform;
function tmScalingY(const ScaleY: Single): TSVGTransform;

function tmSkewing(const Data: TSingleDynArray): TSVGTransform; overload;
function tmSkewing(const SkewX, SkewY: Single): TSVGTransform; overload;
function tmSkewing(const Skew: Single): TSVGTransform; overload;
function tmSkewingX(const SkewX: Single): TSVGTransform;
function tmSkewingY(const SkewY: Single): TSVGTransform;

function tmTranslation(const Data: TSingleDynArray): TSVGTransform; overload;
function tmTranslation(const X, Y: Single): TSVGTransform; overload;
function tmTranslation(const X: Single): TSVGTransform; overload;
function tmTranslationX(const X: Single): TSVGTransform;
function tmTranslationY(const Y: Single): TSVGTransform;

function tmTransform(const P: TSinglePoint; const M: TSVGTransform): TSinglePoint;
function IsSameTransform(const M1, M2: TSVGTransform): Boolean;
function IsEmptyTransform(const M: TSVGTransform): Boolean;
function tmToStr(const M: TSVGTransform): string;

function TryStrToSingle(const S: string; out Value: Single): Boolean;
function StrToSingle(const S: string): Single;

function Dequote(const Value: string): string;

function IsBitmapBottomUp(Bitmap: TBitmap): Boolean;
implementation

uses
  Math, SysUtils, StrUtils, Forms,
  frUtils;

const
  Serif = 'serif';
  SerifFamily: array [0..4] of string = ('Times New Roman', 'Times', 'Georgia', 'Palatino', 'Lucida Bright');

  SansSerif = 'sans-serif';
  SansSerifFamily: array [0..3] of string = ('Arial', 'Helvetica', 'Verdana', 'Tahoma');

  Cursive = 'cursive';
  CursiveFamily: array [0..4] of string = ('Comic Sans MS', 'Comic Sans', 'Bradley Hand', 'Brush Script MT', 'Brush Script Std');

  Fantasy = 'fantasy';
  FantasyFamily: array [0..4] of string = ('Copperplate', 'Luminari', 'Papyrus', 'Marker Felt', 'Trattatello');

  Monospace = 'monospace';
  MonospaceFamily: array [0..5] of string = ('Courier New', 'Courier', 'Lucida Sans Typewriter', 'Lucida Console', 'Consolas', 'Monaco');

{ TSVGTransform }

function tmToStr(const M: TSVGTransform): string;
begin
  Result := frFloatToStr(M.a) + ' ' + frFloatToStr(M.b) + ' ' + frFloatToStr(M.c)
    + ' ' + frFloatToStr(M.d) + ' ' + frFloatToStr(M.e) + ' ' + frFloatToStr(M.f);
end;

function IsEmptyTransform(const M: TSVGTransform): Boolean;
begin
  Result := IsSameTransform(M, EmptyTransform);
end;

function IsSameTransform(const M1, M2: TSVGTransform): Boolean;
begin
  Result := IsSameSingle(M1.a, M2.a) and
            IsSameSingle(M1.b, M2.b) and
            IsSameSingle(M1.c, M2.c) and
            IsSameSingle(M1.d, M2.d) and
            IsSameSingle(M1.e, M2.e) and
            IsSameSingle(M1.f, M2.f);
end;

function tmIdentity: TSVGTransform;
begin
  Result.a := 1;
  Result.b := 0;
  Result.c := 0;
  Result.d := 1;
  Result.e := 0;
  Result.f := 0;
end;

function tmMultiply(const M1, M2: TSVGTransform): TSVGTransform;
begin
  Result.a := M1.a * M2.a + M1.b * M2.c;
  Result.b := M1.a * M2.b + M1.b * M2.d;
  Result.c := M1.c * M2.a + M1.d * M2.c;
  Result.d := M1.c * M2.b + M1.d * M2.d;
  Result.e := M1.e * M2.a + M1.f * M2.c + M2.e;
  Result.f := M1.e * M2.b + M1.f * M2.d + M2.f;
end;

function tmMatrix(const Data: TSingleDynArray): TSVGTransform;
begin
  Result := tmMatrix(Data[0], Data[1], Data[2], Data[3], Data[4], Data[5]);
end;

function tmMatrix(const a, b, c, d, e, f: Single): TSVGTransform;
begin
  Result.a := a;
  Result.b := b;
  Result.c := c;
  Result.d := d;
  Result.e := e;
  Result.f := f;
end;

function tmScaling(const Data: TSingleDynArray): TSVGTransform;
begin
  case Length(Data) of
    1: Result := tmScaling(Data[0]);
    2: Result := tmScaling(Data[0], Data[1]);
  else Result := tmIdentity;
  end;
end;

function tmScaling(const ScaleX, ScaleY: Single): TSVGTransform;
begin
  Result := tmMatrix(ScaleX, 0, 0, ScaleY, 0, 0);
end;

function tmScaling(const Scale: Single): TSVGTransform;
begin
  Result := tmMatrix(Scale, 0, 0, Scale, 0, 0);
end;

function tmScalingX(const ScaleX: Single): TSVGTransform;
begin
  Result := tmMatrix(ScaleX, 0, 0, 1, 0, 0);
end;

function tmScalingY(const ScaleY: Single): TSVGTransform;
begin
  Result := tmMatrix(1, 0, 0, ScaleY, 0, 0);
end;

function tmSkewing(const Data: TSingleDynArray): TSVGTransform;
begin
  case Length(Data) of
    1: Result := tmSkewing(Data[0]);
    2: Result := tmSkewing(Data[0], Data[1]);
  else Result := tmIdentity;
  end;
end;

function tmSkewing(const SkewX, SkewY: Single): TSVGTransform;
begin
  Result := tmMatrix(1, SkewY, SkewX, 1, 0, 0);
end;

function tmSkewing(const Skew: Single): TSVGTransform;
begin
  Result := tmMatrix(1, 0, Skew, 1, 0, 0);
end;

function tmSkewingX(const SkewX: Single): TSVGTransform;
begin
  Result := tmMatrix(1, 0, SkewX, 1, 0, 0);
end;

function tmSkewingY(const SkewY: Single): TSVGTransform;
begin
  Result := tmMatrix(1, SkewY, 0, 1, 0, 0);
end;

function tmTranslation(const Data: TSingleDynArray): TSVGTransform; overload;
begin
  case Length(Data) of
    1: Result := tmTranslation(Data[0]);
    2: Result := tmTranslation(Data[0], Data[1]);
  else Result := tmIdentity;
  end;
end;

function tmTranslation(const X, Y: Single): TSVGTransform;
begin
  Result := tmMatrix(1, 0, 0, 1, X, Y);
end;

function tmTranslation(const X: Single): TSVGTransform;
begin
  Result := tmMatrix(1, 0, 0, 1, X, 0);
end;

function tmRotation(const Data: TSingleDynArray): TSVGTransform;
begin
  case Length(Data) of
    1: Result := tmRotation(Data[0]);
    3: Result := tmRotation(Data[0], Data[1], Data[2]);
  else Result := tmIdentity;
  end;
end;

function tmTranslationX(const X: Single): TSVGTransform;
begin
  Result := tmMatrix(1, 0, 0, 1, X, 0);
end;

function tmTranslationY(const Y: Single): TSVGTransform;
begin
  Result := tmMatrix(1, 0, 0, 1, 0, Y);
end;

function tmRotation(const Alpha, X, Y: Single): TSVGTransform;
begin
  Result := tmTranslation(-X, -Y);
  Result := tmMultiply(Result, tmRotation(Alpha));
  Result := tmMultiply(Result, tmTranslation(X, Y));
end;

function tmRotation(const Alpha: Single): TSVGTransform;
var
  Sine, Cosine: Extended;
begin
  SinCos(Alpha, Sine, Cosine);
  Result := tmMatrix(Cosine, Sine, -Sine, Cosine, 0, 0);
end;

function tmTransform(const P: TSinglePoint; const M: TSVGTransform): TSinglePoint;
begin
  Result.X := P.X * M.a + P.Y * M.c + M.e;
  Result.Y := P.X * M.b + P.Y * M.d + M.f;
end;

{ Utility routines }

function spCreate(X, Y: Single): TSinglePoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

function spDivide(SP: TSinglePoint; Factor: Single): TSinglePoint;
begin
  Result := spCreate(SP.X / Factor, SP.Y / Factor);
end;

function spMultiply(SP: TSinglePoint; Factor: Single): TSinglePoint;
begin
  Result := spCreate(SP.X * Factor, SP.Y * Factor);
end;

{$IFDEF FPC} {$IFDEF Linux}
  {$Define FPC_Linux}
{$ENDIF} {$ENDIF}

function IsBitmapBottomUp(Bitmap: TBitmap): Boolean;
{$IFDEF FPC_Linux}
begin
  Result := False;
end;
{$ELSE}
var
  DIBSection: TDIBSection;
begin
  GetObject(Bitmap.Handle, SizeOf(TDIBSection), @DIBSection);
  Result := DIBSection.dsBmih.biHeight > 0;
end;
{$ENDIF}

function Dequote(const Value: string): string;
begin
  if (Value = '') or not CharInSet(Value[1], ['''', '"']) or
     (Value[1] <> Value[Length(Value)]) then
    Result := Value
  else
    Result := Copy(Value, 2, Length(Value) - 2);
end;

function TryStrToSingle(const S: string; out Value: Single): Boolean;
var
  st: string;
  i: Integer;
begin
  st := S;
  for i := 1 to Length(s) do
    if CharInSet(st[i], [',', '.']) then
{$IFDEF DELPHI16}
      st[i] := FormatSettings.DecimalSeparator;
{$ELSE}
      st[i] := DecimalSeparator;
{$ENDIF}
  Result := TryStrToFloat(st, Value);
  if not Result then
    Value := 0;
end;

function ToSinglePoint(const SX, SY: string): TSinglePoint;
begin
  Result := ToSinglePoint(StrToSingle(SX), StrToSingle(SY));
end;

function SinglePointDiff(const p1, p2: TSinglePoint): TSinglePoint;
begin
  Result := ToSinglePoint(p1.X - p2.X, p1.Y - p2.Y);
end;

function SinglePointSum(const p1, p2: TSinglePoint): TSinglePoint;
begin
  Result := ToSinglePoint(p1.X + p2.X, p1.Y + p2.Y);
end;

function SinglePointCenter(const p1, p2: TSinglePoint): TSinglePoint;
begin
  Result := ToSinglePoint((p1.X + p2.X) / 2.0, (p1.Y + p2.Y) / 2.0);
end;

function StrToSingle(const S: string): Single;
begin
  TryStrToSingle(S, Result);
end;

function DynArrayCopy(DynArray: TSinglePointDynArray): TSinglePointDynArray;
begin
  SetLength(Result, Length(DynArray));
  Move(DynArray[0], Result[0], Length(Result) * SizeOf(Result[0]));
end;

function DynArrayCopy(DynArray: TSingleDynArray): TSingleDynArray;
begin
  SetLength(Result, Length(DynArray));
  Move(DynArray[0], Result[0], Length(Result) * SizeOf(Result[0]));
end;

function ToSinglePoint(const X, Y: Single): TSinglePoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

function ToSingleSize(const Width, Height: Single): TSingleSize;
begin
  Result.Width := Width;
  Result.Height := Height;
end;

function ToSingleRect(const Bounds: TSingleBounds): TSingleRect;
begin
  Result.Left := Bounds.X;
  Result.Top := Bounds.Y;
  Result.Right := Bounds.X + Bounds.Width;
  Result.Bottom := Bounds.Y + Bounds.Height;
end;

function SingleRectUnion(const R1, R2: TSingleRect): TSingleRect;
begin
  Result.Left :=   Min(R1.Left,   R2.Left);
  Result.Right :=  Max(R1.Right,  R2.Right);
  Result.Top :=    Min(R1.Top,    R2.Top);
  Result.Bottom := Max(R1.Bottom, R2.Bottom);
end;

function ToSingleRect(const A: TSinglePointDynArray): TSingleRect; overload;
var
  i: Integer;
begin
  Result := ToSingleRect(A[0].X, A[0].Y, A[0].X, A[0].Y);
  for i := 1 to High(A) do
  begin
    Result.Left := Min(Result.Left, A[i].X);
    Result.Top := Min(Result.Top, A[i].Y);
    Result.Right := Max(Result.Right, A[i].X);
    Result.Bottom := Max(Result.Bottom, A[i].Y);
  end;
end;

function ToSingleRect(const Left, Top, Right, Bottom: Single): TSingleRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Right := Right;
  Result.Bottom := Bottom;
end;

function IsSameSinglePoint(const p1, p2: TSinglePoint): boolean;
begin
  Result := IsSameSingle(p1.X, p2.X) and IsSameSingle(p1.Y, p2.Y);
end;

function IsSameSingle(const A, B: Single; Epsilon: Single = 0): Boolean; 
const
  FuzzFactor = 1000;
  SingleResolution   = 1E-7 * FuzzFactor;
begin
  if Epsilon = 0 then
    Epsilon := Max(Min(Abs(A), Abs(B)) * SingleResolution, SingleResolution);
  if A > B then
    Result := (A - B) <= Epsilon
  else
    Result := (B - A) <= Epsilon;
end;

function IsSameBounds(const B1, B2: TSingleBounds): boolean;
begin
  Result := IsSameSingle(B1.X, B2.X) and IsSameSingle(B1.Y, B2.Y) and
    IsSameSingle(B1.Width, B2.Width) and IsSameSingle(B1.Height, B2.Height);
end;

function SingleBoundsUnion(const B1, B2: TSingleBounds): TSingleBounds;
begin
  Result := ToSingleBounds(SingleRectUnion(ToSingleRect(B1), ToSingleRect(B2)));
//  Result.X := Min(B1.X, B2.X);
//  Result.Y := Min(B1.Y, B2.Y);
//  Result.Width :=  Max(B1.X + B1.Width,  B2.X + B2.Width)  - Result.X;
//  Result.Height := Max(B1.Y + B1.Height, B2.Y + B2.Height) - Result.Y;
end;


function ToSingleBounds(const Rect: TRect): TSingleBounds;
begin
  Result.X := Rect.Left;
  Result.Y := Rect.Top;
  Result.Width := Rect.Right - Rect.Left;
  Result.Height := Rect.Bottom - Rect.Top;
end;

function ToSingleBounds(const Rect: TSingleRect): TSingleBounds;
begin
  Result.X := Rect.Left;
  Result.Y := Rect.Top;
  Result.Width := Rect.Right - Rect.Left;
  Result.Height := Rect.Bottom - Rect.Top;
end;

function ToSingleBounds(const X, Y, Width, Height: Single): TSingleBounds;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Width := Width;
  Result.Height := Height;
end;

{$IFNDEF DELPHI12}
function CharInSet(Ch: Char; CharSet: TSysCharset): Boolean;
begin
  Result := Ch in CharSet;
end;
{$ENDIF}

function IsStrInSet(Str: string; StrSet: array of string): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to High(StrSet) do
    if AnsiUpperCase(Str) = AnsiUpperCase(StrSet[i]) then
      Exit;
  Result := False;
end;

function InsideQuotes(st: string): string;
var
  p: Integer;
begin
  p := PosEx(st[1], st, 2);
  if p > 0 then
    Result := Copy(st, 2, p - 2)
  else
    Result := st;
end;

function SplitFontList(st: string): TStringList;
var
  p: Integer;
  Name: string;
begin
  Result := TStringList.Create;
  st := Trim(st);
  if st <> '' then
    st := st + ',';
  while st <> '' do
  begin
    p := Pos(',', st);
    Name := Trim(Copy(st, 1, p - 1));
    st := Trim(Copy(st, p + 1, MaxInt));

    if CharInSet(Name[1], ['''', '"']) then
      Name := InsideQuotes(Name);
    Result.Add(Name);
  end;
end;

function IsFamilyName(Name: string): boolean;
begin
  Result := IsStrInSet(Name, [Serif, SansSerif, Cursive, Fantasy, Monospace]);
end;

function IsFindFont(Name: string): boolean;
begin
  Result := Screen.Fonts.IndexOf(Name) <> -1;
end;

function TryFindFont(StrSet: array of string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to High(StrSet) do
    if IsFindFont(StrSet[i]) then
    begin
      Result := StrSet[i];
      Break;
    end;
end;

function FindFontByFamily(FamilyName: string): string;
var
  fn: string;
begin
  Result := '';
  fn := AnsiLowerCase(FamilyName);
  if fn = Serif then
    Result := TryFindFont(SerifFamily)
  else if fn = SansSerif then
    Result := TryFindFont(SansSerifFamily)
  else if fn = Cursive then
    Result := TryFindFont(CursiveFamily)
  else if fn = Fantasy then
    Result := TryFindFont(FantasyFamily)
  else if fn = Monospace then
    Result := TryFindFont(MonospaceFamily)
end;

function IsFindFamily(Name: string; var FamilyName: string): boolean;
begin
  FamilyName := '';
  if      IsStrInSet(Name, SerifFamily) then     FamilyName := Serif
  else if IsStrInSet(Name, SansSerifFamily) then FamilyName := SansSerif
  else if IsStrInSet(Name, CursiveFamily) then   FamilyName := Cursive
  else if IsStrInSet(Name, FantasyFamily) then   FamilyName := Fantasy
  else if IsStrInSet(Name, MonospaceFamily) then FamilyName := Monospace;
  Result := FamilyName <> '';
end;

function SuitableFont(FontList: string): string;
var
  SL: TStringList;
  FamilyName: string;
  i: Integer;
begin
  Result := '';
  SL := SplitFontList(FontList);
  try
    for i := 0 to SL.Count - 1 do
      if IsFamilyName(SL[i]) then
      begin
        Result := FindFontByFamily(SL[i]);
        Break;
      end
      else if IsFindFont(SL[i]) then
      begin
        Result := SL[i];
        Break;
      end;
    if Result = '' then
      for i := 0 to SL.Count - 1 do
        if not IsFamilyName(SL[i]) and IsFindFamily(SL[i], FamilyName) then
        begin
          Result := FindFontByFamily(FamilyName);
          Break;
        end
  finally
    SL.Free;
  end;
  if Result = '' then
    Result := 'Arial';
end;

function SplitCSSFont(st: string): TStringList;
var
  p: Integer;
begin
  Result := TStringList.Create;
  st := st + ' ';
  repeat
    st := TrimLeft(st);
    if st = '' then
      Break;

    if CharInSet(st[1], ['''', '"']) then
    begin
      Result.Add(InsideQuotes(st));
      Break;
    end;

    p := frIfInt(st[1] = '/', 1, 0);
    while (st[p + 1] > ' ') and (st[p + 1] <> '/') do
      Inc(p);
    Result.Add(Copy(st, 1, p));
    Delete(st, 1, p);
  until False;
  if Result.Count <= 1 then // font: inherit
    FreeAndNil(Result);
end;

function ChangeSpecialCharacters(st: String): String;
begin
  Result := st;
  Result := StringReplace(Result, '&apos;', '''', [rfReplaceAll, rfIgnoreCase]);
//  Result := StringReplace(Result, '&quot;', '"', [rfReplaceAll, rfIgnoreCase]);
//  Result := StringReplace(Result, '&amp;', '&', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '&lt;', '<', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '&gt;', '>', [rfReplaceAll, rfIgnoreCase]);
end;

{ TfrxMapXMLDocument }

constructor TfrxSVGXMLDocument.Create(Ignored: Pointer);
begin
  inherited Create;
  FRoot.Free;
  FRoot := TfrxSVGXMLItem.Create;
end;

function TfrxSVGXMLDocument.CreateReader: TfrValuedXMLReader;
begin
  Result := TfrxSVGXMLReader.Create(FValuedXMLStream);
end;

procedure TfrxSVGXMLDocument.LoadFromValuedStream;
begin
  DeleteTempFile;
  FValuedXMLStreamReader := CreateReader;
  try
    FRoot.Clear;
    FRoot.Offset := 0;
    ReadXMLHeader;
    IsReadItem(FRoot);
  finally
    FValuedXMLStreamReader.Free;
  end;
end;

procedure TfrxSVGXMLDocument.LoadFromXML(const XML: String);
begin
  FValuedXMLStream := TStringStream.Create(XML);
  try
    LoadFromValuedStream;
  finally
    FValuedXMLStream.Free;
  end;
end;

procedure TfrxSVGXMLDocument.ReadXMLHeader;
begin
  FOldVersion := False;
end;

{ TfrxSVGXMLReader }

constructor TfrxSVGXMLReader.Create(Stream: TStream);
begin
  inherited Create(Stream);

  FLastText := False;
end;

function TfrxSVGXMLReader.CreateItem: TfrXMLItem;
begin
  Result := TfrxSVGXMLItem.Create;
end;

procedure TfrxSVGXMLReader.ProcessSecondLeftBrocket;
var
  c: Byte;
  Nesting: Integer;
begin
  inherited;

  Nesting := 1;
  while not EndOfStream do
  begin
    c := ReadFromBuffer;
    if c = Ord('<') then
      Inc(Nesting)
    else if c = Ord('>') then
    begin
      Dec(Nesting);
      if Nesting = 0 then
        Exit;
    end;
  end;

  RaiseException;
end;

procedure TfrxSVGXMLReader.ReadValuedItem(out {$IFDEF DELPHI12}NameS, ValueS{$ELSE}Name, Value{$ENDIF}, Text: String);
const
  LenPiece = 512;

{$IFDEF DELPHI12}
var
  Name, Value: AnsiString;
{$ENDIF}

  function NameEnd(Marker, Name: AnsiString): integer;
  begin
    Result := Pos(Marker, Name);
    if Result = 0 then
      Result := Length(Name) + 1;
  end;

  procedure PrepareOut;
  begin
  {$IFDEF DELPHI12}
    NameS := String(Name);
    ValueS := UTF8Decode(Value);
  {$ENDIF}
  end;

var
  c: Byte;
  curposName, curPosValue: Integer;
  i: Integer;
  IsNeedFindLeftBrocket: Boolean;
  Comment: Boolean;
begin
  if EndOfStream then
    Exit;
  c := 0;
  Text := '';
  Comment := False;

  curposName := 0;
  SetLength(Name, LenPiece);

  curposValue := 0;
  SetLength(Value, LenPiece);

  IsNeedFindLeftBrocket := not FLastText;
  FLastText := False;
  if IsNeedFindLeftBrocket then
    while not EndOfStream do
    begin
      c := ReadFromBuffer;
      if c = Ord('<') then
      begin
        SetLength(Value, curposValue);
        FLastText := Trim(String(Value)) <> '';
        if FLastText then
        begin
          {$IFDEF DELPHI12}
          NameS := '#text';
          ValueS := string(Value);
          {$ELSE}
          Name := '#text';
          Value := string(Value);
          {$ENDIF}
          Exit;
        end
        else
          Break
      end
      else
        AddChar(Value, curposValue, AnsiChar(Chr(c)));
    end;
  SetLength(Value, curposValue);

  while not EndOfStream do
  begin
    c := ReadFromBuffer;
    if (c = Ord('<')) and not Comment then
      ProcessSecondLeftBrocket
    else if (c = Ord('>')) and
      (not Comment or Comment and (Copy(Name, curposName - 1, 2) = '--')) then
      Break
    else
    begin
      AddChar(Name, curposName, AnsiChar(Chr(c)));
      if not Comment and (curposName = 3) and (Copy(Name, 1, 3) = '!--') then
      begin
        Comment := True;
        AddChar(Name, curposName, AnsiChar(' '));
      end;
    end;
  end;
  SetLength(Name, curposName);

  if c <> Ord('>') then
    if EndOfStream then
    begin
      PrepareOut;
      Exit;
    end
    else
      RaiseException;

  i := Min(NameEnd(' ', Name), NameEnd(#9, Name));
  i := Min(i, NameEnd(#$D#$A, Name));
  if Pos(AnsiString('![CDATA['), Name) = 1 then
  begin
    Text := String(Copy(Name, 9, curposName - i));
    SetLength(Name, 8);
  end
  else
  begin
    Text := String(Copy(Name, i + 1, curposName - i));
    SetLength(Name, i - 1);
  end;

  PrepareOut;
end;

{ TfrxSVGIXMLChildNodes }

constructor TfrxSVGIXMLChildNodes.Create(AItems: TList);
begin
  FItems := AItems;
end;

function TfrxSVGIXMLChildNodes.GetCount: Integer;
begin
  if FItems = nil then
    Result := 0
  else
    Result := FItems.Count;
end;

function TfrxSVGIXMLChildNodes.GetItems(Index: Integer): TfrxSVGXMLItem;
begin
  if FItems = nil then
    Result := nil
  else
    Result := TfrxSVGXMLItem(FItems[Index]);
end;

{ TfrxSVGXMLItem }

procedure TfrxSVGXMLItem.AddItem(Item: TfrXMLItem);
begin
  if Item.Name = '#text' then
  begin
    Item.Text := ChangeSpecialCharacters(Item.Value);
    Text := Item.Text;
  end
  else if Item.Name = '![CDATA[' then
  begin
    Item.Text := ChangeSpecialCharacters(Item.Text);
    Text := Item.Text;
  end;

  inherited AddItem(Item);
end;

destructor TfrxSVGXMLItem.Destroy;
begin
  FChildNodes.Free;
  FAttributeNodes.Free;
  inherited;
end;

function TfrxSVGXMLItem.GetAttributes(s: string): string;
begin
  Result := FAttributeNodes.ValueByName[s];
end;

function TfrxSVGXMLItem.GetChildNodes: TfrxSVGIXMLChildNodes;
begin
  if FChildNodes = nil then
    FChildNodes := TfrxSVGIXMLChildNodes.Create(FItems);
  Result := FChildNodes;
end;

function TfrxSVGXMLItem.GetHRef: string;
begin
  Result := GetAttributes('href');
  if Result = '' then
    Result := GetAttributes('xlink:href');
end;

function TfrxSVGXMLItem.GetNodeName: string;
begin
  Result := Name;
end;

function TfrxSVGXMLItem.GetNodeValue: string;
begin
  Result := Value;
end;

function TfrxSVGXMLItem.HasAttribute(s: string): Boolean;
begin
  Result := FAttributeNodes.IsHasAttribute(s);
end;

procedure TfrxSVGXMLItem.SetData(const AName, AText, AValue: String);
begin
  inherited SetData(AName, AText, AValue);

  FAttributeNodes := TfrxSVGAttributeNodes.Create(Text);
end;

{ TAttributeNodes }

constructor TfrxSVGAttributeNodes.Create(Text: string);
const
  ValueStart = '="';
  ValueFinish = '"';
  NotFound = 0;
var
  Name, Value: string;
  ValueStartPos, ValueFinishPos: Integer;
begin
  SL := TStringList.Create;
  ValueFinishPos := 0;
  while ValueFinishPos < Length(Text) do
  begin
    ValueStartPos := PosEx(ValueStart, Text, ValueFinishPos + Length(ValueFinish));
    if ValueStartPos = NotFound then
      Break;
    Name := Trim(Copy(Text,
      ValueFinishPos + Length(ValueFinish),
      ValueStartPos - 1 - (ValueFinishPos + Length(ValueFinish)) + 1));

    ValueFinishPos := PosEx(ValueFinish, Text, ValueStartPos + Length(ValueStart));
    if ValueFinishPos = NotFound then
      Break;
    Value := Trim(Copy(Text,
      ValueStartPos + Length(ValueStart),
      ValueFinishPos - 1 - (ValueStartPos + Length(ValueStart)) + 1));

    SL.AddObject(Name + SL.NameValueSeparator + Value, nil)
  end;
end;

destructor TfrxSVGAttributeNodes.Destroy;
var
  i: Integer;
begin
  for i := 0 to SL.Count - 1 do
    SL.Objects[i].Free;
  SL.Free;

  inherited;
end;

function TfrxSVGAttributeNodes.FindNode(s: string): TfrxSVGXMLItem;
var
  Index: Integer;
  Item: TfrxSVGXMLItem;
begin
  Index := SL.IndexOfName(s);
  if Index = -1 then
    Result := nil
  else
  begin
    Item := TfrxSVGXMLItem(SL.Objects[Index]);
    if Item = nil then
    begin
      Item := TfrxSVGXMLItem.Create;
      Item.Value := SL.ValueFromIndex[Index];
      SL.Objects[Index] := Item;
    end;
    Result := Item;
  end;
end;

function TfrxSVGAttributeNodes.GetCount: Integer;
begin
  Result := SL.Count;
end;

function TfrxSVGAttributeNodes.GetNameValue(i: Integer): TfrxSVGNameValue;
begin
  Result.NodeName := SL.Names[i];
  Result.NodeValue := SL.ValueFromIndex[i];
end;

function TfrxSVGAttributeNodes.GetValueByName(NodeName: string): string;
begin
  Result := SL.Values[NodeName];
end;

function TfrxSVGAttributeNodes.IndexOfName(const s: string): Integer;
begin
  Result := SL.IndexOfName(s);
end;

function TfrxSVGAttributeNodes.IsHasAttribute(const s: string): Boolean;
begin
  Result := IndexOfName(s) <> -1;
end;

end.
