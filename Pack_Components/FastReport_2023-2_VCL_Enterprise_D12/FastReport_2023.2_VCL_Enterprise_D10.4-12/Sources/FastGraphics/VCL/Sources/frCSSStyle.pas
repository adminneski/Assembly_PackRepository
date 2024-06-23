
{******************************************}
{                                          }
{             FastReport VCL               }
{                CSS Style                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
unit frCSSStyle;

interface

{$I frVer.inc}

uses
  Classes;

type
  TfrxCSSStyle = class(TPersistent)
  private
    FKeys: TStrings;
    FValues: TStrings;
    FName: string;

    function GetStyle(const Key: string): string;
    procedure SetStyle(const Key, Value: string);
    procedure SetPrefixStyle(Index: string; const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function This: TfrxCSSStyle;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Clear;

    procedure SetValuesFromText(const Text: string);
    function IsHasKey(Key: string): Boolean;
    function Count: Integer;
    function Text(Formatted: Boolean = False): string;


    property Style[const Key: string]: string read GetStyle write SetStyle; default;
    property PrefixStyle[Index: string]: string write SetPrefixStyle;
    property Name: string read FName write FName;
  end;

  TfrxCSSList = class(TObject)
  private
    FStyles: TList;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(SourceStyleList: TfrxCSSList);
    procedure Save(Stream: TStream; Formatted: Boolean);

    function AddStyle(Style: TfrxCSSStyle): string;
    function AddName(const Name: string; Values: string = ''): TfrxCSSStyle;
    function AddText(const AStyle: string): Integer;

    function GetStyle(const Index: Integer): TfrxCSSStyle;
    function GetStyleByName(const Name: string): TfrxCSSStyle;

    property Count: Integer read GetCount;
  end;

implementation

uses
  SysUtils, StrUtils,
  frCoreClasses,
  frUtils,
  frSVGHelpers;

const
  Unknown = -1;

{ TfrxCSSStyle }

procedure TfrxCSSStyle.AssignTo(Dest: TPersistent);
var
  i: Integer;
begin
  if Dest is TfrxCSSStyle then
  begin
    TfrxCSSStyle(Dest).Name := FName;
    for i := 0 to Count - 1 do
      TfrxCSSStyle(Dest)[FKeys[i]] := FValues[i];
  end;
end;

procedure TfrxCSSStyle.Clear;
begin
  if FKeys <> nil then
    FKeys.Clear;
  if FValues <> nil then
    FValues.Clear;
end;

function TfrxCSSStyle.Count: Integer;
begin
  Result := FKeys.Count;
end;

constructor TfrxCSSStyle.Create;
begin
  inherited Create;
  FKeys := TStringList.Create;
  FValues := TStringList.Create;
end;

destructor TfrxCSSStyle.Destroy;
begin
  FKeys.Free;
  FValues.Free;
  inherited Destroy;
end;

function TfrxCSSStyle.GetStyle(const Key: string): string;
var
  i: integer;
begin
  Result := '';
  if Key <> '' then
  begin
    i := FKeys.IndexOf(Key);
    if i <> Unknown then
      Result := FValues[i];
  end;
end;

function TfrxCSSStyle.IsHasKey(Key: string): Boolean;
begin
  Result := FKeys.IndexOf(Key) <> Unknown;
end;

procedure TfrxCSSStyle.SetPrefixStyle(Index: string; const Value: string);
begin
  if (Index <> '') and (Value <> '') then
  begin
    SetStyle(Index, Value);
    SetStyle('-webkit-' + Index, Value);
    SetStyle('-moz-' + Index, Value);
    SetStyle('-ms-' + Index, Value);
    SetStyle('-o-' + Index, Value);
  end;
end;

procedure TfrxCSSStyle.SetStyle(const Key, Value: string);
begin
  if (Key <> '') and (Value <> '') then
  begin
    FKeys.Add(Key);
    FValues.Add(Value);
  end;
end;

procedure TfrxCSSStyle.SetValuesFromText(const Text: string);
var
  Semicolon, Colon: Integer;
  KeyValue, Key, Value, st: string;
begin
  st := Trim(Text);

  while st <> '' do
  begin
    Semicolon := Pos(';', st);
    if Semicolon = 0 then
      Semicolon := Length(st) + 1;
    KeyValue := Copy(st, 1, Semicolon - 1);
    st := Trim(Copy(st, Semicolon + 1, MaxInt));

    Colon := Pos(':', KeyValue);
    if Colon <> 0 then
    begin
      Key := Trim(Copy(KeyValue, 1, Colon - 1));
      Value := Trim(Copy(KeyValue, Colon + 1, MaxInt));
      Style[Key] := Value;
    end;
  end;
end;

function TfrxCSSStyle.Text(Formatted: Boolean): string;
var
  i: Integer;

//  function CheckSmall(const AFont: string): Boolean;
//  begin
//    Result := (Pos('8pt', AFont) > 0) or (Pos('7pt', AFont) > 0) or (Pos('9pt', AFont) > 0);
//  end;
begin
  Result := '';
  for i := 0 to Count - 1 do
    if FValues[i] <> '' then
    begin
//      if SameText('font', FKeys[i]) and CheckSmall(FValues[i]) then
//      begin
//        Result := Result + IfStr(Formatted, #13#10#9) + 'line-height' +
//        IfStr(Formatted, ': ', ':') + '110% !important';
//        if Result[Length(Result)] <> ';' then
//          Result := Result + ';';
//      end;
      Result := Result + frIfStr(Formatted, #13#10#9) + FKeys[i] +
        frIfStr(Formatted, ': ', ':') + string(UTF8Encode(FValues[i]));
      Result := Result + frIfStr(Result[Length(Result)] <> ';', ';');
    end;
end;

function TfrxCSSStyle.This: TfrxCSSStyle;
begin
  Result := Self;
end;

{ TStyleList }

function TfrxCSSList.AddStyle(Style: TfrxCSSStyle): string;

  function AutoStyleName(Index: Integer): string;
  begin
    Result := 's' + IntToStr(Index);
  end;
var
  i: Integer;
  StyleText: string;
begin
  StyleText := Style.Text;

    for i := 0 to Count - 1 do
      if GetStyle(i).Text = StyleText then
      begin
        Result := AutoStyleName(i);
        Style.Free;
        Exit;
      end;

  FStyles.Add(Style);

  Result := AutoStyleName(Count - 1);
  Style.Name := '.' + Result;
end;

function TfrxCSSList.AddText(const AStyle: string): Integer;
var
  Name: string;
  Values: string;
const
  NotFound = 0;
var
  LeftBracePos, RightBracePos: Integer;
  NoCommentsStyle: string;
begin
  NoCommentsStyle := AStyle;
  LeftBracePos := 1;
  while True do
  begin
    LeftBracePos := PosEx('/*', NoCommentsStyle, LeftBracePos);
    if LeftBracePos = NotFound then
      Break;
    RightBracePos := PosEx('*/', NoCommentsStyle, LeftBracePos + 2);
    if RightBracePos = NotFound then
      Break;

    System.Delete(NoCommentsStyle, LeftBracePos, RightBracePos - LeftBracePos + 2);
  end;

  Result := Unknown;
  RightBracePos := 0;
  while RightBracePos < Length(NoCommentsStyle) do
  begin
    LeftBracePos := PosEx('{', NoCommentsStyle, RightBracePos + 1);
    if LeftBracePos = NotFound then
      Break;
    Name := Trim(Copy(NoCommentsStyle,
      RightBracePos + 1,
      LeftBracePos - 1 - RightBracePos));

    RightBracePos := PosEx('}', NoCommentsStyle, LeftBracePos + 1);
    if RightBracePos = NotFound then
      Break;
    Values := Trim(Copy(NoCommentsStyle,
      LeftBracePos + 1,
      RightBracePos - 1 - LeftBracePos));

    AddName(Name, Values);
  end;
end;

function TfrxCSSList.AddName(const Name: string; Values: string = ''): TfrxCSSStyle;
begin
  Result := TfrxCSSStyle.Create;
  Result.FName := Name;

  if Values <> '' then
    Result.SetValuesFromText(Values);

  FStyles.Add(Result);
end;

procedure TfrxCSSList.Assign(SourceStyleList: TfrxCSSList);
var
  i: Integer;
  Style: TfrxCSSStyle;
begin
  FStyles.Clear;
  for i := 0 to SourceStyleList.Count - 1 do
  begin
    Style := TfrxCSSStyle.Create;
    Style.Assign(SourceStyleList.GetStyle(i));
    AddStyle(Style);
  end;

end;

procedure TfrxCSSList.Clear;
begin
  FStyles.Clear;
end;

constructor TfrxCSSList.Create;
begin
  inherited Create;
  FStyles := TfrOwnObjList.Create;
end;

destructor TfrxCSSList.Destroy;
begin
  FStyles.Free;
  inherited;
end;

function TfrxCSSList.GetCount: Integer;
begin
  Result := FStyles.Count;
end;

function TfrxCSSList.GetStyle(const Index: Integer): TfrxCSSStyle;
begin
  if Index < Count then
    Result := FStyles[Index]
  else
    Result := nil;
end;

function TfrxCSSList.GetStyleByName(const Name: string): TfrxCSSStyle;
var
  i: Integer;
begin
  for i := 0 to FStyles.Count - 1 do
  begin
    Result := FStyles[i];
    if Result.FName = Name then
      Exit;
  end;
  Result := nil;
end;

procedure TfrxCSSList.Save(Stream: TStream; Formatted: Boolean);

  procedure Puts(const Text: string);
  var
    s: AnsiString;
  begin
    s := AnsiString(Text);
    Stream.Write(s[1], Length(s));
  end;

var
  i: Integer;
  Sep: string;
begin
  Sep := frIfStr(Formatted, #13#10);

  for i := 0 to Count - 1 do
    with GetStyle(i) do
      Puts(This.Name +
        Sep + '{' +
        string(UTF8Encode(This.Text(Formatted))) + Sep +
        '}' + Sep);
end;

end.
