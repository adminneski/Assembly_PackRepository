{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{                  TSettingsKeeper class                }
{                                                       }
{    Copyright (c) 2017-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit SettingsKeepersEh;

interface

uses
  Messages, SysUtils, Classes,
  {$IFDEF FPC}
  Generics.Collections, Generics.Defaults, FPJson,
  {$ELSE}
  {$IFDEF EH_LIB_17} System.UITypes, System.Generics.Collections, System.Generics.Defaults, {$ENDIF}
  {$IFDEF EH_LIB_20} System.JSON, {$ENDIF} 
  {$ENDIF}
  Variants;

{$IFDEF SettingsKeeper} 
type
  TSettingsKeeperDicEh = class(TDictionary<String, TObject>)
  protected
    {$IFDEF FPC}
    procedure KeyNotify(constref Key: String; Action: TCollectionNotification); override;
    procedure ValueNotify(constref Value: TObject; Action: TCollectionNotification); override;
    {$ELSE}
    procedure KeyNotify(const Key: String; Action: TCollectionNotification); override;
    procedure ValueNotify(const Value: TObject; Action: TCollectionNotification); override;
    {$ENDIF}
  end;

{ TSettingsKeeperEh }

  TSettingsKeeperEh = class(TObject)
  private
    FDic: TSettingsKeeperDicEh;
  public
    function ToArray: TArray<TPair<String, TObject>>;
    function TryGetValue(const Key: String; out Value: TObject): Boolean;
    function TryGetIntegerValue(const Key: String; out Value: Integer): Boolean;
    function TryGetStringValue(const Key: String; out Value: String): Boolean;
    function TryGetSubsettingsValue(const Key: String; out Value: TSettingsKeeperEh): Boolean;

    procedure Add(const Key: String; const Value: String); overload;
    procedure Add(const Key: String; const Value: Integer); overload;
    procedure Add(const Key: String; const Value: TSettingsKeeperEh); overload;

    constructor Create();
    destructor Destroy(); override;
  end;

{ TJSONSettingsWriterEh }

  TJSONSettingsWriterEh = class(TObject)
    function GetAsJSON(Keeper: TSettingsKeeperEh):String;
  end;

{ TJSONSettingsReaderEh }

  TJSONSettingsReaderEh = class(TObject)
    procedure FillByJSON(Keeper: TSettingsKeeperEh; JSon: String);
  end;

{ TSettingsKeeperCollectionByIndexComparer }

  TSettingsKeeperEhCollectionByIndexComparer = class(TCustomComparer<TPair<String,TObject>>)
  private
  public
    class function Ordinal: TSettingsKeeperEhCollectionByIndexComparer;
    {$IFDEF FPC}
    function Compare(constref Left, Right: TPair<String,TObject>): Integer; override;
    function Equals(constref Left, Right: TPair<String,TObject>): Boolean; override;
    function GetHashCode(constref Value: TPair<String,TObject>): UInt32; override;
    {$ELSE}
    function Compare(const Left, Right: TPair<String,TObject>): Integer; override;
    function Equals(const Left, Right: TPair<String,TObject>): Boolean; override;
    function GetHashCode(const Value: TPair<String,TObject>): Integer; override;
    {$ENDIF}
  end;

  function SettingsKeeperToJSONString(Keeper: TSettingsKeeperEh): String;
  procedure JSONStringToSettingsKeeper(Keeper: TSettingsKeeperEh; JSon: String);

{$ENDIF} 

implementation

{$IFDEF SettingsKeeper} 

var
  FSettingsKeeperEhCollectionByIndexComparer: TSettingsKeeperEhCollectionByIndexComparer;

function SettingsKeeperEhCollectionByIndexComparer: TSettingsKeeperEhCollectionByIndexComparer;
begin
  if FSettingsKeeperEhCollectionByIndexComparer = nil then
    FSettingsKeeperEhCollectionByIndexComparer := TSettingsKeeperEhCollectionByIndexComparer.Create;
  Result := FSettingsKeeperEhCollectionByIndexComparer;
end;

function SettingsKeeperToJSONString(Keeper: TSettingsKeeperEh): String;
var
  Writer: TJSONSettingsWriterEh;
begin
  Writer := TJSONSettingsWriterEh.Create;
  Result := Writer.GetAsJSON(Keeper);
  FreeAndNIl(Writer);
end;

procedure JSONStringToSettingsKeeper(Keeper: TSettingsKeeperEh; JSon: String);
var
  Reader: TJSONSettingsReaderEh;
begin
  Reader := TJSONSettingsReaderEh.Create;
  Reader.FillByJSON(Keeper, JSon);
  FreeAndNIl(Reader);
end;

{ TColumnIndexComparer }

{$IFDEF FPC}
function TSettingsKeeperEhCollectionByIndexComparer.Compare(constref Left,
  Right: TPair<String, TObject>): Integer;
{$ELSE}
function TSettingsKeeperEhCollectionByIndexComparer.Compare(const Left,
  Right: TPair<String, TObject>): Integer;
{$ENDIF}
var
  ColKeeper: TSettingsKeeperEh;
  IntValue: Integer;
  LeftIndex, RightIndex: Integer;
begin
  LeftIndex := 0;
  RightIndex := 0;
  ColKeeper := Left.Value as TSettingsKeeperEh;
  if ColKeeper.TryGetIntegerValue('ColIndex', IntValue) then
    LeftIndex := IntValue;

  ColKeeper := Right.Value as TSettingsKeeperEh;
  if ColKeeper.TryGetIntegerValue('ColIndex', IntValue) then
    RightIndex := IntValue;

  Result := LeftIndex - RightIndex;
end;

{$IFDEF FPC}
function TSettingsKeeperEhCollectionByIndexComparer.Equals(constref Left,
  Right: TPair<String, TObject>): Boolean;
{$ELSE}
function TSettingsKeeperEhCollectionByIndexComparer.Equals(const Left,
  Right: TPair<String, TObject>): Boolean;
{$ENDIF}
begin
  Result := Compare(Left, Right) = 0;
end;

{$IFDEF FPC}
function TSettingsKeeperEhCollectionByIndexComparer.GetHashCode(
  constref Value: TPair<String, TObject>): UInt32;
{$ELSE}
function TSettingsKeeperEhCollectionByIndexComparer.GetHashCode(
  const Value: TPair<String, TObject>): Integer;
{$ENDIF}
begin
  Result := 0;
end;

class function TSettingsKeeperEhCollectionByIndexComparer.Ordinal: TSettingsKeeperEhCollectionByIndexComparer;
begin
  Result := SettingsKeeperEhCollectionByIndexComparer;
end;

type
  TStringObject = class(TObject)
    Value: String;
    function ToString: string; override;
    constructor Create(Value: String);
  end;

{ TStringObject }

constructor TStringObject.Create(Value: String);
begin
  Self.Value := Value;
end;

function TStringObject.ToString: string;
begin
  Result := Value;
end;

type
  TIntegerObject = class(TObject)
    Value: Integer;
    function ToString: string; override;
    constructor Create(Value: Integer);
  end;

{ TIntegerObject }

constructor TIntegerObject.Create(Value: Integer);
begin
  Self.Value := Value;
end;

function TIntegerObject.ToString: string;
begin
  Result := Value.ToString;
end;

{ TSettingsKeeperDic }

{$IFDEF FPC}
procedure TSettingsKeeperDicEh.KeyNotify(constref Key: String;
  Action: TCollectionNotification);
{$ELSE}
procedure TSettingsKeeperDicEh.KeyNotify(const Key: String;
  Action: TCollectionNotification);
{$ENDIF}
begin
  inherited;
end;

{$IFDEF FPC}
procedure TSettingsKeeperDicEh.ValueNotify(constref Value: TObject;
  Action: TCollectionNotification);
begin
  inherited;
  if (Action = cnRemoved) then
    PObject(@Value)^.Free;
end;
{$ELSE}
procedure TSettingsKeeperDicEh.ValueNotify(const Value: TObject;
  Action: TCollectionNotification);
begin
  inherited;
  if (Action = cnRemoved) then
    PObject(@Value)^.DisposeOf;
end;
{$ENDIF}

{ TSettingsKeeperEh }

constructor TSettingsKeeperEh.Create;
begin
  inherited Create();
  FDic := TSettingsKeeperDicEh.Create();
end;

destructor TSettingsKeeperEh.Destroy;
begin
  FreeAndNil(FDic);
  inherited Destroy;
end;

procedure TSettingsKeeperEh.Add(const Key, Value: String);
begin
  FDic.Add(Key, TStringObject.Create(Value));
end;

procedure TSettingsKeeperEh.Add(const Key: String; const Value: Integer);
begin
  FDic.Add(Key, TIntegerObject.Create(Value));
end;

procedure TSettingsKeeperEh.Add(const Key: String; const Value: TSettingsKeeperEh);
begin
  FDic.Add(Key, Value);
end;

function TSettingsKeeperEh.ToArray: TArray<TPair<String, TObject>>;
begin
  Result := FDic.ToArray;
end;

function TSettingsKeeperEh.TryGetValue(const Key: String; out Value: TObject): Boolean;
begin
  Result := FDic.TryGetValue(Key, Value);
end;

function TSettingsKeeperEh.TryGetSubsettingsValue(const Key: String; out Value: TSettingsKeeperEh): Boolean;
var
  ObjValue: TObject;
begin
  Result := FDic.TryGetValue(Key, ObjValue);
  if Result and (ObjValue is TSettingsKeeperEh) then
    Value := ObjValue as TSettingsKeeperEh
  else
    Result := False;
end;

function TSettingsKeeperEh.TryGetIntegerValue(const Key: String; out Value: Integer): Boolean;
var
  StrVal: String;
  ObjValue: TObject;
begin
  Result := FDic.TryGetValue(Key, ObjValue);
  if Result then
  begin
    if (ObjValue is TStringObject) then
    begin
      StrVal := (ObjValue as TStringObject).Value;
      if Integer.TryParse(StrVal, Value) then
      begin
        Result := True;
        Exit;
      end;
    end
    else if (ObjValue is TIntegerObject) then
    begin
      Value := (ObjValue as TIntegerObject).Value;
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function TSettingsKeeperEh.TryGetStringValue(const Key: String;
  out Value: String): Boolean;
var
  ObjValue: TObject;
begin
  Result := FDic.TryGetValue(Key, ObjValue);
  if Result and (ObjValue is TStringObject) then
  begin
    Value := (ObjValue as TStringObject).Value;
    Result := True;
    Exit;
  end;
  Result := False;
end;

{ TJSONSettingsWriter }

procedure WriteKeeper(JSONObject: TJSONObject; Keeper: TSettingsKeeperEh);
var
  i: Integer;
  KeeperArray: TArray<TPair<String,TObject>>;
  SetPair: TPair<String,TObject>;
  SubKeeper: TSettingsKeeperEh;
  InnerObject : TJSONObject;
  JSSONStr : TJSONString;
  StrValue: String;
begin
  KeeperArray := Keeper.ToArray();
  for i := 0 to Length(KeeperArray)-1 do
  begin
    SetPair := KeeperArray[i];
    if SetPair.Value is TSettingsKeeperEh then
    begin
      SubKeeper := (SetPair.Value as TSettingsKeeperEh);
      InnerObject := TJSONObject.Create;
      WriteKeeper(InnerObject, SubKeeper);
      {$IFDEF FPC}
      JSONObject.Add(SetPair.Key, InnerObject);
      {$ELSE}
      JSONObject.AddPair(SetPair.Key, InnerObject);
      {$ENDIF}
    end else
    begin
      StrValue := SetPair.Value.ToString;
      JSSONStr := TJSONString.Create(StrValue);
      {$IFDEF FPC}
      JSONObject.Add(SetPair.Key, JSSONStr);
      {$ELSE}
      JSONObject.AddPair(SetPair.Key, JSSONStr);
      {$ENDIF}
    end;
  end;
end;

function TJSONSettingsWriterEh.GetAsJSON(Keeper: TSettingsKeeperEh): String;
var
  JSONObject: TJSONObject;
begin
  JSONObject := TJSONObject.Create;

  WriteKeeper(JSONObject, Keeper);

  {$IFDEF FPC}
  Result := JSONObject.AsJSON;
  {$ELSE}
  Result := JSONObject.ToString();
  {$ENDIF}

  FreeAndNil(JSONObject);
end;

{ TJSONSettingsReader }

procedure ReadKeeper(JSONObject: TJSONObject; Keeper: TSettingsKeeperEh);
{$IFDEF FPC}
var
  i: Integer;
  SubKeeper: TSettingsKeeperEh;
  JSData: TJSONData;
begin
  for i := 0 to JSONObject.Count-1 do
  begin
    JSData := JSONObject.Elements[JSONObject.Names[i]];
    if JSData is TJSONObject then
    begin
      SubKeeper := TSettingsKeeperEh.Create;
      ReadKeeper(JSData as TJSONObject, SubKeeper);
      Keeper.Add(JSONObject.Names[i], SubKeeper);
    end else
    begin
      Keeper.Add(JSONObject.Names[i], JSData.AsString);
    end;
  end;
end;
{$ELSE}
var
  i: Integer;
  SubKeeper: TSettingsKeeperEh;
  JSPair: TJSONPair;
begin
  for i := 0 to JSONObject.Size-1 do
  begin
    JSPair := JSONObject.Get(i);
    if JSPair.JsonValue is TJSONObject then
    begin
      SubKeeper := TSettingsKeeperEh.Create;
      ReadKeeper(JSPair.JsonValue as TJSONObject, SubKeeper);
      Keeper.Add(JSPair.JsonString.Value, SubKeeper);
    end else
    begin
      Keeper.Add(JSPair.JsonString.Value, (JSPair.JsonValue as TJSONString).Value);
    end;
  end;
end;
{$ENDIF}

procedure TJSONSettingsReaderEh.FillByJSON(Keeper: TSettingsKeeperEh; JSon: String);
var
  JSONObject: TJSONObject;
begin
  {$IFDEF FPC}
  JSONObject := GetJSON(JSon) as TJSONObject;
  {$ELSE}
  JSONObject := TJSONObject.ParseJSONValue(JSon) as TJSONObject;
  {$ENDIF}
  if JSONObject = nil then Exit;

  ReadKeeper(JSONObject, Keeper);

  FreeAndNil(JSONObject);
end;

{$ENDIF} 

procedure InitUnit;
begin
end;

procedure FinalUnit;
begin
{$IFDEF SettingsKeeper} 
  FreeAndNil(FSettingsKeeperEhCollectionByIndexComparer);
{$ENDIF}
end;

initialization
  InitUnit;
finalization
  FinalUnit;
end.
