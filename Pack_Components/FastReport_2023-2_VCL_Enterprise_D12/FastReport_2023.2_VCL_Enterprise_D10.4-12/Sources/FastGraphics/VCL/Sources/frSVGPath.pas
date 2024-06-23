
{******************************************}
{                                          }
{             FastReport VCL               }
{                SVG Path                  }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{******************************************}
{ with using SVG-Library of Martin Walter  }
{******************************************}

unit frSVGPath;

interface

{$I frVer.inc}

uses
  Classes,
  frSVGCanvas, frSVGHelpers, frSVGBase, frSVGElement;

type
  Tel_path = class(TSVGBaseObj)
  private
    FObjBounds: TSingleBounds;
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure ConstructPath; override;
  public
    constructor Create; override;
  end;

procedure ParsePath(const S: string; FPathObj: TSVGElementObj);

implementation

uses
  SysUtils, Math,
  frSVGComponents;

type
  TSVGPathElement = class(TSVGElementObj)
  private
    FStart: TSinglePoint;
    FStop: TSinglePoint;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function ReadPoint(SL: TStrings; var Position: Integer): TSinglePoint;
    function ReadSingle(SL: TStrings; var Position: Integer): Single;
  public
    constructor Create; override;
    procedure AddToPath(Path: TSVGCanvasPath); virtual; abstract;
    procedure Read(SL: TStrings; var Position: Integer;
      Previous: TSVGPathElement); virtual;
  end;

  TSVGPathMove = class(TSVGPathElement)
  private
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    procedure AddToPath(Path: TSVGCanvasPath); override;
    procedure Read(SL: TStrings; var Position: Integer;
      Previous: TSVGPathElement); override;
  end;

  TSVGPathLine = class(TSVGPathElement)
  private
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    procedure AddToPath(Path: TSVGCanvasPath); override;
    procedure Read(SL: TStrings; var Position: Integer;
      Previous: TSVGPathElement); override;
  end;

  TSVGPathCubicCurve = class(TSVGPathElement)
  private
    FControl1: TSinglePoint;
    FControl2: TSinglePoint;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    procedure AddToPath(Path: TSVGCanvasPath); override;
    procedure Read(SL: TStrings; var Position: Integer;
      Previous: TSVGPathElement); override;
  end;

  TSVGPathQuadraticCurve = class(TSVGPathCubicCurve)
  private
    FControl0: TSinglePoint;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    procedure CalcCubicPoints;
  public
    procedure Read(SL: TStrings; var Position: Integer;
      Previous: TSVGPathElement); override;
  end;

  TSVGPathEllipticArc = class(TSVGPathElement)
  private
    FRX: Single;
    FRY: Single;
    FXRot: Single;
    FLarge: Integer;
    FSweep: Integer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
    function CalculateVectorAngle(ux, uy, vx, vy: Single): Single;
  public
    procedure AddToPath(Path: TSVGCanvasPath); override;
    procedure Read(SL: TStrings; var Position: Integer;
      Previous: TSVGPathElement); override;

    property RX: Single read FRX write FRX;
    property RY: Single read FRY write FRY;
    property XRot: Single read FXRot write FXRot;
    property Large: Integer read FLarge write FLarge;
    property Sweep: Integer read FSweep write FSweep;
  end;

  TSVGPathClose = class(TSVGPathElement)
  private
    function FindLastMoveTo: TSVGPathMove;
  protected
    function New(Parent: TSVGElementObj): TSVGElementObj; override;
  public
    procedure AddToPath(Path: TSVGCanvasPath); override;
    procedure Read(SL: TStrings; var Position: Integer;
      Previous: TSVGPathElement); override;
  end;

{ Utility routines }

const
  PathCommandSet: TSysCharSet =
    ['M', 'm', 'L', 'l', 'H', 'h', 'V', 'v', 'C', 'c', 'S', 's', 'Q', 'q', 'T', 't', 'A', 'a'];
  CloseCommandSet: TSysCharSet =
    ['Z', 'z'];

procedure PrepareMoveLineCurveArc(const ACommand: Char; SL: TStrings);
var
  i: Integer;
  D: Integer;
  Command: Char;
begin
  case ACommand of
    'A', 'a':                     D := 7;
    'C', 'c':                     D := 6;
    'S', 's', 'Q', 'q':           D := 4;
    'T', 't', 'M', 'm', 'L', 'l': D := 2;
    'H', 'h', 'V', 'v':           D := 1;
  else
    Exit;
  end;

  if (SL.Count = D + 1) or ((SL.Count - 1) mod D = 1) then
    Exit;

  case ACommand of
    'M': Command := 'L';
    'm': Command := 'l';
  else
    Command := ACommand;
  end;

  for i := SL.Count - D downto (D + 1) do
    if (i - 1) mod D = 0 then
      SL.Insert(i, Command);
end;

function SeparateValues(const ACommand: Char; const S: string): TStrings;
var
  NumberStr: string;
  HasDot, Exponent: Boolean;
  i: Integer;

  procedure AddNumber;
  begin
    if NumberStr <> '' then
      Result.Add(NumberStr);
    NumberStr := '';
    HasDot := False;
    Exponent := False;
  end;

  procedure AddChar;
  begin
    NumberStr := NumberStr + S[i];
    HasDot := HasDot or (S[i] = '.');
    Exponent := CharInSet(S[i], ['e', 'E']);
  end;

begin
  NumberStr := '';
  HasDot := False;
  Exponent := False;

  Result := TStringList.Create;

  for i := 1 to Length(S) do
  begin
    if CharInSet(S[i], [' ', #9, #$A, #$D]) or
       CharInSet(S[i], ['+', '-']) and not Exponent or
       (S[i] = '.') and HasDot then
      AddNumber;
    if CharInSet(S[i], ['.', '0' .. '9', '+', '-', 'e', 'E']) then
      AddChar;
  end;
  AddNumber;

  Result.Insert(0, ACommand);

  if Result.Count > 0 then
    if      CharInSet(ACommand, PathCommandSet) then
      PrepareMoveLineCurveArc(ACommand, Result)
    else if CharInSet(ACommand, CloseCommandSet) then
      while Result.Count > 1 do
        Result.Delete(1);
end;

function Split(const S: string): TStrings;

  function IndexOfNextCommand(const st: string; const Start: Integer): Integer;
  begin
    Result := Start;
    while (Result <= Length(st)) and not CharInSet(st[Result], PathCommandSet + CloseCommandSet) do
      Result := Result + 1;
  end;
var
  Part: string;
  SL: TStrings;
  Found: Integer;
  StartIndex: Integer;
begin
  Result := TStringList.Create;

  StartIndex := IndexOfNextCommand(S, 1);
  while StartIndex <= Length(S) do
  begin
    Found := IndexOfNextCommand(S, StartIndex + 1);
    Part := Trim(Copy(S, StartIndex + 1, Found - StartIndex - 1));
    SL := SeparateValues(S[StartIndex], Part);
    try
      Result.AddStrings(SL);
    finally
      SL.Free;
    end;
    StartIndex := Found;
  end;
end;

procedure ParsePath(const S: string; FPathObj: TSVGElementObj);
var
  SL: TStrings;
  i: Integer;
  st: string;
  Element: TSVGPathElement;
  LastElement: TSVGPathElement;
begin
  st := StringReplace(S, ',', ' ', [rfReplaceAll]);
  SL := Split(st);

  try
    i := 0;
    LastElement := nil;

    if SL.Count > 0 then
      repeat
        case SL[i][1] of
          'M', 'm':                     Element := TSVGPathMove.Create(FPathObj);
          'L', 'l', 'H', 'h', 'V', 'v': Element := TSVGPathLine.Create(FPathObj);
          'C', 'c', 'S', 's':           Element := TSVGPathCubicCurve.Create(FPathObj);
          'Q', 'q', 'T', 't':           Element := TSVGPathQuadraticCurve.Create(FPathObj);
          'A', 'a':                     Element := TSVGPathEllipticArc.Create(FPathObj);
          'Z', 'z':                     Element := TSVGPathClose.Create(FPathObj);
        else
          Element := nil;
        end;

        if Assigned(Element) then
        begin
          Element.Read(SL, i, LastElement);
          LastElement := Element;
        end;
        Inc(i);
      until i = SL.Count;
  finally
    SL.Free;
  end;
end;

{ TSVGPathElement }

procedure TSVGPathElement.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TSVGPathElement then
  begin
    TSVGPathElement(Dest).FStart := FStart;
    TSVGPathElement(Dest).FStop := FStop;
  end;
end;

constructor TSVGPathElement.Create;
begin
  inherited Create;
  ConstructAttributes(el_PathElement);
end;

function TSVGPathElement.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := nil;
end;

procedure TSVGPathElement.Read(SL: TStrings; var Position: Integer; Previous: TSVGPathElement);
begin
  if Assigned(Previous) then
    FStart := Previous.FStop;
end;

function TSVGPathElement.ReadPoint(SL: TStrings; var Position: Integer): TSinglePoint;
begin
  Result := ToSinglePoint(SL[Position + 1], SL[Position + 2]);
  Inc(Position, 2);
end;

function TSVGPathElement.ReadSingle(SL: TStrings; var Position: Integer): Single;
begin
  Result := StrToSingle(SL[Position + 1]);
  Inc(Position, 1);
end;

{ TSVGPathMove }

function TSVGPathMove.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := TSVGPathMove.Create(Parent);
end;

procedure TSVGPathMove.AddToPath(Path: TSVGCanvasPath);
begin
  Path.StartFigure;
end;

procedure TSVGPathMove.Read(SL: TStrings; var Position: Integer; Previous: TSVGPathElement);
var
  Command: string;
begin
  inherited;

  Command := SL[Position];

  FStop := ReadPoint(SL, Position);

  if Command = 'm' then
    FStop := SinglePointSum(FStart, FStop);
end;

{ TSVGPathLine }

function TSVGPathLine.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := TSVGPathLine.Create(Parent);
end;

procedure TSVGPathLine.AddToPath(Path: TSVGCanvasPath);
begin
  Path.AddLine(FStart, FStop);
end;

procedure TSVGPathLine.Read(SL: TStrings; var Position: Integer; Previous: TSVGPathElement);
var
  Command: string;
begin
  inherited;

  Command := SL[Position];
  if (Command = 'L') or (Command = 'l') then
  begin
    FStop := ReadPoint(SL, Position);

    if Command = 'l' then
      FStop := SinglePointSum(FStart, FStop);
  end;

  if (Command = 'H') or (Command = 'h') then
  begin
    FStop.X := ReadSingle(SL, Position);

    if Command = 'h' then
      FStop.X := FStart.X + FStop.X;
    FStop.Y := FStart.Y;
  end;

  if (Command = 'V') or (Command = 'v') then
  begin
    FStop.Y := ReadSingle(SL, Position);

    if Command = 'v' then
      FStop.Y := FStart.Y + FStop.Y;
    FStop.X := FStart.X;
  end;
end;

{ TSVGPathCubicCurve }

procedure TSVGPathCubicCurve.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TSVGPathCubicCurve then
  begin
    TSVGPathCubicCurve(Dest).FControl1 := FControl1;
    TSVGPathCubicCurve(Dest).FControl2 := FControl2;
  end;
end;

function TSVGPathCubicCurve.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := TSVGPathCubicCurve.Create(Parent);
end;

procedure TSVGPathCubicCurve.AddToPath(Path: TSVGCanvasPath);
begin
  Path.AddBezier(FStart, FControl1, FControl2, FStop);
end;

procedure TSVGPathCubicCurve.Read(SL: TStrings; var Position: Integer; Previous: TSVGPathElement);
var
  Command: string;
begin
  inherited;

  Command := SL[Position];
  if (Command = 'C') or (Command = 'c') then
  begin
    FControl1 := ReadPoint(SL, Position);
    FControl2 := ReadPoint(SL, Position);
    FStop := ReadPoint(SL, Position);

    if Command = 'c' then
    begin
      FControl1 := SinglePointSum(FStart, FControl1);
      FControl2 := SinglePointSum(FStart, FControl2);
      FStop := SinglePointSum(FStart, FStop);
    end;
  end;

  if (Command = 'S') or (Command = 's') then
  begin
    FControl1 := FStart;
    FControl2 := ReadPoint(SL, Position);
    FStop := ReadPoint(SL, Position);

    if Previous is TSVGPathCubicCurve then
      FControl1 := SinglePointSum(FStart,
        SinglePointDiff(FStart, TSVGPathCubicCurve(Previous).FControl2));

    if Command = 's' then
    begin
      FControl2 := SinglePointSum(FStart, FControl2);
      FStop := SinglePointSum(FStart, FStop);
    end;
  end;

end;

{ TSVGPathEllipticArc }

procedure TSVGPathEllipticArc.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TSVGPathEllipticArc then
  begin
    TSVGPathEllipticArc(Dest).FRX := FRX;
    TSVGPathEllipticArc(Dest).FRY := FRY;
    TSVGPathEllipticArc(Dest).FXRot := FXRot;
    TSVGPathEllipticArc(Dest).FLarge := FLarge;
    TSVGPathEllipticArc(Dest).FSweep := FSweep;
  end;
end;

function TSVGPathEllipticArc.CalculateVectorAngle(ux, uy, vx, vy: Single): Single;
var
  ta, tb: Single;
begin
  ta := Arctan2(uy, ux);
  tb := Arctan2(vy, vx);
  if tb >= ta then
    Result := tb - ta
  else
    Result := 2 * Pi - (ta - tb);
end;

function TSVGPathEllipticArc.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := TSVGPathEllipticArc.Create(Parent);
end;

procedure TSVGPathEllipticArc.AddToPath(Path: TSVGCanvasPath);
var
  sinPhi, cosPhi: Extended;
  x1dash, y1dash: Single;
  DX2, DY2: Single;
  root, numerator: Single;
  rx, ry, s: Single;
  cxdash, cydash: Single;
  cx, cy: Single;
  theta1, dtheta, theta2: Single;
  i, segments: Integer;
  delta, t: single;
  _startX, _startY: Single;
  cosTheta1, sinTheta1, cosTheta2, sinTheta2: Extended;
  endpointX, endpointY, dx1, dy1, dxe, dye: Single;
begin
  if IsSameSinglePoint(FStart, FStop) then
    Exit;

  if (FRX = 0) or (FRY = 0) then
  begin
    Path.AddLine(FStart, FStop);
    Exit;
  end;

  sincos(FXRot * Pi / 180, sinPhi, cosPhi);

  DX2 := (FStart.X - FStop.X) / 2.0;
  DY2 := (FStart.Y - FStop.Y) / 2.0;

  x1dash := (cosPhi * DX2 + sinPhi * DY2);
  y1dash := (-sinPhi * DX2 + cosPhi * DY2);

  numerator := FRX * FRX * FRY * FRY - FRX * FRX * y1dash * y1dash - FRY * FRY * x1dash * x1dash;

  rx := FRX;
  ry := FRY;

  if numerator < 0.0 then
  begin
    s := Sqrt(1.0 - numerator / (FRX * FRX * FRY * FRY));
    rx := rx * s;
    ry := ry * s;
    root := 0.0;
  end
  else
  begin
    root := Sqrt(numerator / (FRX * FRX * y1dash * y1dash + FRY * FRY * x1dash * x1dash));
    if FLarge = FSweep then
      root := -root;
  end;

  cxdash := root * rx * y1dash / ry;
  cydash := -root * ry * x1dash / rx;

  cx := cosPhi * cxdash - sinPhi * cydash + (FStart.X + FStop.X) / 2.0;
  cy := sinPhi * cxdash + cosPhi * cydash + (FStart.Y + FStop.Y) / 2.0;

  theta1 := CalculateVectorAngle(1.0, 0.0, (x1dash - cxdash) / rx, (y1dash - cydash) / ry);
  dtheta := CalculateVectorAngle((x1dash - cxdash) / rx, (y1dash - cydash) / ry, (-x1dash - cxdash) / rx, (-y1dash - cydash) / ry);

  if      (FSweep = 0) and (dtheta > 0) then
    dtheta := dtheta - 2 * PI
  else if (FSweep = 1) and (dtheta < 0) then
    dtheta := dtheta + 2 * Pi;

  segments := Ceil(Abs(dtheta / (Pi / 2)));
  delta := dtheta / segments;
  t := 8.0 / 3.0 * Sin(delta / 4) * Sin(delta / 4) / Sin(delta / 2);

  _startX := FStart.X;
  _startY := FStart.Y;

  for i := 0 to segments - 1 do
  begin
    SinCos(theta1, sinTheta1, cosTheta1);
    theta2 := theta1 + delta;
    SinCos(theta2, sinTheta2, cosTheta2);

    endpointX := cosPhi * rx * cosTheta2 - sinPhi * ry * sinTheta2 + cx;
    endpointY := sinPhi * rx * cosTheta2 + cosPhi * ry * sinTheta2 + cy;

    dx1 := t * (-cosPhi * rx * sinTheta1 - sinPhi * ry * cosTheta1);
    dy1 := t * (-sinPhi * rx * sinTheta1 + cosPhi * ry * cosTheta1);

    dxe := t * (cosPhi * rx * sinTheta2 + sinPhi * ry * cosTheta2);
    dye := t * (sinPhi * rx * sinTheta2 - cosPhi * ry * cosTheta2);

    Path.AddBezier(_startX, _startY, (_startX + dx1), (_startY + dy1),
                   (endpointX + dxe), (endpointY + dye), endpointX, endpointY);

    theta1 := theta2;
    _startX := endpointX;
    _startY := endpointY;
  end;
end;

procedure TSVGPathEllipticArc.Read(SL: TStrings; var Position: Integer; Previous: TSVGPathElement);
var
  Command: string;
begin
  inherited;

  Command := SL[Position];
  if (Command = 'A') or (Command = 'a') then
  begin
    FRX := ReadSingle(SL, Position);
    FRY := ReadSingle(SL, Position);
    FXRot := ReadSingle(SL, Position);

    FLarge := Round(ReadSingle(SL, Position));
    FSweep := Round(ReadSingle(SL, Position));

    FStop := ReadPoint(SL, Position);

    FRX := Abs(FRX);
    FRY := Abs(FRY);

    if FLarge <> 0 then
      FLarge := 1;

    if FSweep <> 0 then
      FSweep := 1;

    if Command = 'a' then
      FStop := SinglePointSum(FStart, FStop);
  end;
end;

{ TSVGPathClose }

function TSVGPathClose.FindLastMoveTo: TSVGPathMove;
var
  Index: Integer;
  Previous: TSVGElementObj;
begin
  for Index := Parent.Count - 2 downto 0 do
  begin
    Previous := Parent.Items[Index];
    if Previous is TSVGPathMove then
    begin
      Result := TSVGPathMove(Previous);
      Exit;
    end;
  end;
  Result := nil;
end;

function TSVGPathClose.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := TSVGPathClose.Create(Parent);
end;

procedure TSVGPathClose.Read(SL: TStrings; var Position: Integer;
  Previous: TSVGPathElement);
var
  LastMoveTo: TSVGPathMove;
begin
  FStart := Previous.FStop;
  LastMoveTo := FindLastMoveTo;
  if Assigned(LastMoveTo) then
    FStop := LastMoveTo.FStop
  else
    FStop := FStart;
end;

procedure TSVGPathClose.AddToPath(Path: TSVGCanvasPath);
begin
  Path.CloseFigure;
end;

{ TSVGPathQuadraticCurve }

procedure TSVGPathQuadraticCurve.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TSVGPathQuadraticCurve then
    TSVGPathQuadraticCurve(Dest).FControl0 := FControl0;
end;

procedure TSVGPathQuadraticCurve.CalcCubicPoints;
var
  Center, dHeight, dWidth: TSinglePoint;
begin
  Center := SinglePointCenter(FStart, FStop);
  dHeight := SinglePointDiff(FControl0, Center);
  dWidth := SinglePointDiff(FStop, FStart);

  FControl1.X := FStart.X + dWidth.X * 1 / 3 + dHeight.X * 2 / 3;
  FControl1.Y := FStart.Y + dWidth.Y * 1 / 3 + dHeight.Y * 2 / 3;

  FControl2.X := FStart.X + dWidth.X * 2 / 3 + dHeight.X * 2 / 3;
  FControl2.Y := FStart.Y + dWidth.Y * 2 / 3 + dHeight.Y * 2 / 3;
end;

function TSVGPathQuadraticCurve.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := TSVGPathQuadraticCurve.Create(Parent);
end;

procedure TSVGPathQuadraticCurve.Read(SL: TStrings; var Position: Integer; Previous: TSVGPathElement);
var
  Command: string;
begin
  inherited;

  Command := SL[Position];

  if (Command = 'Q') or (Command = 'q') then
  begin
    FControl0 := ReadPoint(SL, Position);
    FStop := ReadPoint(SL, Position);

    if Command = 'q' then
    begin
      FControl0 := SinglePointSum(FStart, FControl0);
      FStop := SinglePointSum(FStart, FStop);
    end;

    CalcCubicPoints;
  end;

  if (Command = 'T') or (Command = 't') then
  begin
    FControl0 := FStart;
    FStop := ReadPoint(SL, Position);

    if Previous is TSVGPathQuadraticCurve then
      FControl0 := SinglePointSum(FStart,
        SinglePointDiff(FStart, TSVGPathQuadraticCurve(Previous).FControl0));

    if Command = 't' then
      FStop := SinglePointSum(FStart, FStop);

    CalcCubicPoints;
  end;
end;

{ TSVGPath }

procedure Tel_path.ConstructPath;
var
  i: Integer;
begin
  inherited ConstructPath;

  AttrObj[at_d];

  FPath := CanvasClass.CreatePath;
  for i := 0 to Count - 1 do
    TSVGPathElement(Items[i]).AddToPath(FPath);

  FObjBounds := FPath.Bounds;
end;

constructor Tel_path.Create;
begin
  inherited Create;
  ConstructAttributes(el_path);
end;

function Tel_path.New(Parent: TSVGElementObj): TSVGElementObj;
begin
  Result := Tel_path.Create(Parent);
end;

end.
