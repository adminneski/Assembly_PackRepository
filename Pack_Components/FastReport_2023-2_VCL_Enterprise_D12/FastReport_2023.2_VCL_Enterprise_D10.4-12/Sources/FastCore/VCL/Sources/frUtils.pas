
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frUtils;
{$ENDIF}

interface

{$I frVer.inc}

uses
  SysUtils,
{$IFDEF DELPHI16} System.UITypes, {$ENDIF}
{$IFNDEF FMX}
  frCoreCLasses,
  Graphics,
  frXML,
{$IFNDEF FPC}
  Windows,
{$ENDIF}
{$ELSE}
  FMX.frCoreClasses,
  FMX.frXML,
{$ENDIF}
{$IFDEF FPC}
  LCLType,
{$ENDIF}
  Classes;

procedure frStringToStream(const S: string; AStream: TStream);
function frToStringList(const S: string; const ADelimiter: Char): TStrings;
function frNormalizeScientificNotation(const S: string): string;

function frLimit(const AValue, AMinValue, AMaxValue: Single): Single; overload;
function frLimit(const AValue, AMinValue, AMaxValue: Double): Double; overload;
function frLimit(const AValue, AMinValue, AMaxValue: Integer): Integer; overload;

function frMulDiv(ANumber, ANumerator, ADenominator: Integer): Integer;

function frFloatToStr(D: Extended): string;

function frIfColor(AFlag: Boolean; const ATrue: TColor; AFalse: TColor = $1FFFFFFF): TColor;
function frIfInt(AFlag: Boolean; const ATrue: Integer; AFalse: Integer = 0): Integer;
function frIfStr(AFlag: Boolean; const ATrue: string; AFalse: string = ''): string;
function frIfReal(AFlag: Boolean; const ATrue: Extended; AFalse: Extended = 0.0): Extended;

function frFindComponent(AOwner: TComponent; const AName: String): TComponent;

implementation

uses
  Math;

procedure frStringToStream(const S: string; AStream: TStream);
var
  ASize: Integer;
{$IFDEF DELPHI12}
  P: PAnsiChar;
{$ELSE}
	P: PChar;
{$ENDIF}
begin
  ASize := Length(s) div 2;
  GetMem(p, ASize);

  HexToBin(PChar(@S[1]), P, ASize * 2);

  AStream.Position := 0;
  AStream.Write(P^, ASize);

  FreeMem(P, ASize);
end;

function frToStringList(const S: string; const ADelimiter: Char): TStrings;
var
  I: Integer;
begin
  Result := TStringList.Create;
  Result.Delimiter := ADelimiter;
  Result.DelimitedText := S;

  for I := Result.Count - 1 downto 0 do
  begin
    Result[I] := Trim(Result[I]);
    if Result[I] = '' then
      Result.Delete(I);
  end;
end;

function frNormalizeScientificNotation(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, 'e-', 'e<', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'e+', 'e>', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '-', ' -', [rfReplaceAll]);
  Result := StringReplace(Result, '+', ' +', [rfReplaceAll]);
  Result := StringReplace(Result, 'e<', 'e-', [rfReplaceAll]);
  Result := StringReplace(Result, 'e>', 'e+', [rfReplaceAll]);
end;

function frLimit(const AValue, AMinValue, AMaxValue: Double): Double; overload;
begin
  Result := Max(AMinValue, Min(AMaxValue, AValue));
end;

function frLimit(const AValue, AMinValue, AMaxValue: Single): Single;
begin
  Result := Max(AMinValue, Min(AMaxValue, AValue));
end;

function frLimit(const AValue, AMinValue, AMaxValue: Integer): Integer;
begin
  Result := Max(AMinValue, Min(AMaxValue, AValue));
end;

function frMulDiv(ANumber, ANumerator, ADenominator: Integer): Integer;
begin
{$IFNDEF FMX}
  Result := MulDiv(ANumber, ANumerator, ADenominator);
{$ELSE}
  if ANumerator <> ADenominator then
    Result := Round(ANumber * ANumerator / ADenominator)
  else
    Result := ANumber;
{$ENDIF}
end;

function frFloatToStr(D: Extended): string;
begin
  if Trunc(D) = D then
    Result := FloatToStr(d) else
    Result := Format('%2.2f', [d]);
end;

function frIfColor(AFlag: Boolean; const ATrue: TColor; AFalse: TColor = $1FFFFFFF): TColor;
begin
  if AFlag then
    Result := ATrue
  else
    Result := AFalse;
end;

function frIfInt(AFlag: Boolean; const ATrue: Integer; AFalse: Integer = 0): Integer;
begin
  if AFlag then
    Result := ATrue
  else
    Result := AFalse;
end;

function frIfStr(AFlag: Boolean; const ATrue: string; AFalse: string = ''): string;
begin
  if AFlag then
    Result := ATrue
  else
    Result := AFalse;
end;

function frIfReal(AFlag: Boolean; const ATrue: Extended; AFalse: Extended = 0.0): Extended;
begin
  if AFlag then
    Result := ATrue
  else
    Result := AFalse;
end;

function frFindComponent(AOwner: TComponent; const AName: String): TComponent;
var
  n: Integer;
  s1, s2: String;
begin
  Result := nil;
  n := Pos('.', AName);
  try
    if n = 0 then
    begin
      if AOwner <> nil then
        Result := AOwner.FindComponent(AName);
      if (Result = nil) and (AOwner is TfrCustomComponent) and (AOwner.Owner <> nil) then
        Result := AOwner.Owner.FindComponent(AName);
    end
    else
    begin
      s1 := Copy(AName, 1, n - 1);        // module name
      s2 := Copy(AName, n + 1, 255);      // component name
      AOwner := FindGlobalComponent(s1);
      if AOwner <> nil then
      begin
        n := Pos('.', s2);
        if n <> 0 then        // frame name - DELPHI5
        begin
          s1 := Copy(s2, 1, n - 1);
          s2 := Copy(s2, n + 1, 255);
          AOwner := AOwner.FindComponent(s1);
          if AOwner <> nil then
            Result := AOwner.FindComponent(s2);
        end
        else
          Result := AOwner.FindComponent(s2);
      end;
    end;
  except
    on Exception do
      raise EClassNotFound.Create('Missing ' + AName);
  end;
end;

end.
