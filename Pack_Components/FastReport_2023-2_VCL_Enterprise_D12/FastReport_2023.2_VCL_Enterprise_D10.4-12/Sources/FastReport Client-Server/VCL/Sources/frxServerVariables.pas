
{******************************************}
{                                          }
{             FastReport VCL               }
{             Server variables             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerVariables;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  Classes, SysUtils, frxServerUtils;

type
  TfrxServerVariable = class(TCollectionItem)
  private
    FName: String;
    FValue: AnsiString;
  published
    property Name: String read FName write FName;
    property Value: AnsiString read FValue write FValue;
  end;

  TfrxServerVariables = class(TCollection)
  public
    constructor Create;
    function GetValue(const Name: String): AnsiString;
    procedure AddVariable(const Name: String; const Value: AnsiString);{$IFDEF DELPHI12} overload;
    procedure AddVariable(const Name: String; const Value:String); overload;
    {$ENDIF}
    procedure AddLinkVariable(const Name: String; const Value: String);

  end;

implementation

{ TfrxServerVarables }

procedure TfrxServerVariables.AddLinkVariable(const Name: String;
  const Value: String);
begin
{$IFDEF DELPHI12}
  AddVariable(Name, Str2HTML(UTF8Encode(Value)));
{$ELSE}
  AddVariable(Name, Str2HTML(Value));
{$ENDIF}
end;


procedure TfrxServerVariables.AddVariable(const Name: String;const Value: AnsiString);
var
  i, j: Integer;
  s: String;
  v: TfrxServerVariable;
begin
  j := -1;
  s := UpperCase(Name);
  for i := 0 to Count - 1 do
    if TfrxServerVariable(Items[i]).Name = Name then
      j := i;
  if j > 0 then
    v := TfrxServerVariable(Items[j])
  else begin
    v := TfrxServerVariable(Add);
    v.Name := Name;
  end;
  v.Value := Value;
end;

{$IFDEF DELPHI12}
procedure TfrxServerVariables.AddVariable(const Name, Value: String);
begin
  AddVariable(Name, UTF8Encode(Value));
end;
{$ENDIF}

constructor TfrxServerVariables.Create;
begin
  inherited Create(TfrxServerVariable);
end;

function TfrxServerVariables.GetValue(const Name: String): AnsiString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    if TfrxServerVariable(Items[i]).Name = Name then
      Result := TfrxServerVariable(Items[i]).Value;
end;
end.
