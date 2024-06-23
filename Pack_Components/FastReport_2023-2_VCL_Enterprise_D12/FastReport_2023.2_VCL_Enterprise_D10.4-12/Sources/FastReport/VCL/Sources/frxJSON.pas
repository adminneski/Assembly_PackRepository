
{******************************************}
{                                          }
{             FastReport VCL               }
{            JSON Manipulation             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxJSON;

{$I frx.inc}

interface

uses
  {$IfDEF DELPHI20} System.JSON, {$ELSE} frxLkJSON, {$ENDIF}
  {$IFNDEF FPC}
    Windows
  {$ELSE}
    LCLType, LCLIntf, LCLProc
  {$ENDIF};

type
  TfrxJSON = class
  private
    JSONObject: {$IfDef DELPHI20} TJSONObject;
                {$Else}           TlkJSONobject;
                {$EndIf}
    Weak: boolean;
  public
    constructor Create(const JSONString: String);
    constructor CreateWeek(const SingleObject: TObject);
    destructor Destroy; override;
    function IsValid: Boolean;
    function IsNameExists(const Name: String): boolean;
    function IsNameValueExists(const Name, Value: String): boolean;
    function ValueByName(const Name: String): String;
    function ObjectByName(const Name: String): TObject;
  end;

  TfrxJSONArray = class
  private
    JSONArray: {$IfDef DELPHI20} TJSONArray;
               {$Else}           TlkJSONList;
               {$EndIf}
    FIsNULLObj: Boolean;
  public
    constructor Create(const ArrayObject: TObject);
    destructor Destroy; override;
    function Count: integer;
    function Get(Index: Integer): TfrxJSON;
    function GetString(Index: Integer): String;
  end;

implementation

{ TfrxJSON }

constructor TfrxJSON.Create(const JSONString: String);
begin
  JSONObject :=
{$IfDef DELPHI20} TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
{$Else}           TlkJSON.ParseText(AnsiString(JSONString)) as TlkJSONobject;
{$EndIf}
  Weak := False;
end;

constructor TfrxJSON.CreateWeek(const SingleObject: TObject);
begin
  JSONObject :=
{$IfDef DELPHI20} SingleObject as TJSONObject;
{$Else}           SingleObject as TlkJSONobject;
{$EndIf}
  Weak := True;
end;

destructor TfrxJSON.Destroy;
begin
  if not Weak then
    JSONObject.Free;
  inherited;
end;

function TfrxJSON.IsNameExists(const Name: String): boolean;
begin
  Result := False;
  If Assigned(JSONObject) then
    Result :=
{$IfDef DELPHI20} JSONObject.Values[Name] <> nil;
{$Else}           JSONObject.IndexOfName(Name) <> -1;
{$EndIf}
end;

function TfrxJSON.IsNameValueExists(const Name, Value: String): boolean;
begin
  Result := IsNameExists(Name) and
           (ValueByName(Name) = Value);
end;

function TfrxJSON.IsValid: Boolean;
begin
  Result := Assigned(JSONObject);
end;

function TfrxJSON.ObjectByName(const Name: String): TObject;
begin
  Result := nil;
  If Assigned(JSONObject) then
    Result :=
{$IfDef DELPHI20} JSONObject.GetValue(Name);
{$Else}           JSONObject.Field[Name];
{$EndIf}
end;

function TfrxJSON.ValueByName(const Name: String): String;
var
{$IfDef DELPHI20}
  node: TJSONValue;
{$Else}
  node: TlkJSONbase;
{$EndIf}
begin
  Result := '';
  Node := nil;
  If Assigned(JSONObject) then
    Node :=
{$IfDef DELPHI20} JSONObject.GetValue(Name);
{$Else}           JSONObject.Field[Name];
{$EndIf}
  if Assigned(Node) then
    Result := Node.Value
end;

{ TfrxJSONArray }

function TfrxJSONArray.Count: integer;
begin
  Result := JSONArray.Count;
end;

constructor TfrxJSONArray.Create(const ArrayObject: TObject);
begin
  if Assigned(ArrayObject) then
    JSONArray :=
{$IfDef DELPHI20} ArrayObject as TJSONArray
{$Else}           ArrayObject as TlkJSONList
{$EndIf}
  else // NULL obj
  begin
    JSONArray :=
{$IfDef DELPHI20} TJSONArray.Create;
{$Else}           TlkJSONList.Create;;
{$EndIf}
    FIsNULLObj := True;
  end;
end;

destructor TfrxJSONArray.Destroy;
begin
  inherited;
  if FIsNULLObj then
    JSONArray.Free;
end;

{$HINTS OFF}
function TfrxJSONArray.Get(Index: Integer): TfrxJSON;
begin
  Result := TfrxJSON.CreateWeek(
{$IfDef DELPHI20} JSONArray.Items[Index]);
{$Else}           JSONArray.Child[Index]);
{$EndIf}
end;

function TfrxJSONArray.GetString(Index: Integer): String;
begin
  Result :=
{$IfDef DELPHI20} JSONArray.Items[Index].Value;
{$Else}           JSONArray.Child[Index].Value;
{$EndIf}
end;
{$HINTS ON}

end.
