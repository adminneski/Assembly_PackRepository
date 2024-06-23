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
unit frCoreClasses;
{$ENDIF}

{$I frVer.inc}

interface

uses
{$IFNDEF FMX}
  SysUtils, Types, Classes, Controls,
  frUnicodeUtils, frCore;
{$ELSE}
  System.SysUtils, System.Types, System.Classes,
  FMX.Types,
  FMX.frUnicodeUtils, FMX.frCore;
{$ENDIF}

type
  EfrException = class(Exception);

  TfrPointerList = array of Pointer;

  { TfrMap }

  TfrMap = class
  protected type
    THashProc = function(const AKey: Pointer): Integer;
    TAllocProc = function(const AValue: Pointer): Pointer;
    TDisposeProc = procedure(const AValue: Pointer);
    TSameKeyProc = function(const AKey1, AKey2: Pointer): Boolean;
    PItem = ^TItem;
    TItem = record
      Key: Pointer;
      Hash: Integer;
      Value: Pointer;
      Next: PItem;
    end;
    TItems = array of PItem;
  strict private const
    FDefaultItemsLength = 691;
    function GetItem(const AKey: Pointer): Pointer;
    procedure SetItem(const AKey, AValue: Pointer);
  strict private
    FAllocKeyProc: TAllocProc;
    FAllocValueProc: TAllocProc;
    FCount: Cardinal;
    FDisposeKeyProc: TDisposeProc;
    FDisposeValueProc: TDisposeProc;
    FItems: TItems;
    FHashProc: THashProc;
    FKeySize: Integer;
    FSameKeyProc: TSameKeyProc;
    FValueSize: Integer;
  protected
    function AllocKey(const AKey: Pointer): Pointer; virtual;
    function AllocValue(const AValue: Pointer): Pointer; virtual;
    procedure DoAdd(const AKey, AValue: Pointer; ACheckDuplicates: Boolean); virtual;
    procedure DisposeKey(AKey: Pointer); virtual;
    procedure DisposeItem(AItem: PItem); virtual;
    procedure DisposeValue(AValue: Pointer); virtual;
    function Hash(const AKey: Pointer): Integer;
    function NewItem(const AKey, AValue: Pointer; AHash: Cardinal): PItem;
    function SameKey(const AKey1, AKey2: Pointer): Boolean;

    property AllocKeyProc: TAllocProc read FAllocKeyProc write FAllocKeyProc;
    property AllocValueProc: TAllocProc read FAllocValueProc write FAllocValueProc;
    property DisposeKeyProc: TDisposeProc read FDisposeKeyProc write FDisposeKeyProc;
    property DisposeValueProc: TDisposeProc read FDisposeValueProc write FDisposeValueProc;
    property KeySize: Integer read FKeySize;
    property SameKeyProc: TSameKeyProc read FSameKeyProc write FSameKeyProc;
    property ValueSize: Integer read FValueSize;
  public
    constructor Create(AKeySize, AValueSize: Integer; AHashProc: THashProc);
    destructor Destroy; override;
    procedure Add(const AKey, AValue: Pointer);
    procedure AddOrSetValue(const AKey, AValue: Pointer);
    procedure Clear;
    function ContainsKey(const AKey: Pointer): Boolean;
    function Keys: TfrPointerList;
    function Remove(const AKey: Pointer): Boolean;
    function TryGetValue(const AKey: Pointer; out AValue: Pointer): Boolean;

    property Items[const AKey: Pointer]: Pointer read GetItem write SetItem; default;
    property Count: Cardinal read FCount;
  end;

  { TfrObjectMap }

  TfrObjectMap = class(TfrMap)
  strict private
    FOwnObjects: Boolean;
  protected
    function AllocValue(const AValue: Pointer): Pointer; override;
    procedure DisposeValue(AValue: Pointer); override;
  public
    constructor Create(AOwnObjects: Boolean; AKeySize: Integer; AHashProc: TfrMap.THashProc); reintroduce;
  end;

  { TfrCustomDictionary }

  TfrCustomDictionary = class
  strict private
    FMap: TfrMap;
    function GetCount: Integer;
  protected
    function CreateMap: TfrMap; virtual; abstract;

    property Map: TfrMap read FMap;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    property Count: Integer read GetCount;
  end;

  { TfrNamedDictionary }

  TfrNamedDictionary = class abstract(TfrCustomDictionary)
  protected
    function CreateMap: TfrMap; override;
    function GetValueSize: Integer; virtual; abstract;
  public
    function ContainsKey(const AKey: string): Boolean;
    function Keys: TStringDynArray;
    function Remove(const AKey: string): Boolean;
  end;

  { TfrNamedObjectDictionary }

  TfrNamedObjectDictionary = class(TfrNamedDictionary)
  strict private
    FOwnObjects: Boolean;
    function GetItem(const AKey: string): TObject;
    procedure SetItem(const AKey: string; const Value: TObject);
  protected
    function CreateMap: TfrMap; override;
    function GetValueSize: Integer; override;
  public
    constructor Create(AOwnObjects: Boolean = True); reintroduce;

    procedure Add(const AKey: string; const AValue: TObject);
    procedure AddOrSetValue(const AKey: string; const AValue: TObject);
    function TryGetValue(const AKey: string; out AValue: TObject): Boolean;

    property Items[const AKey: string]: TObject read GetItem write SetItem; default;
  end;

  { TfrStringDictionary }

  TfrStringDictionary = class(TfrNamedDictionary)
  strict private
    function GetItem(const AKey: string): string;
    procedure SetItem(const AKey, AValue: string);
  protected
    function CreateMap: TfrMap; override;
    function GetValueSize: Integer; override;
  public
    procedure Add(const AKey, AValue: string);
    procedure AddOrSetValue(const AKey, AValue: string);
    function TryGetValue(const AKey: string; out AValue: string): Boolean;

    property Items[const AKey: string]: string read GetItem write SetItem; default;
  end;

  { TfrInterfacedObject }

  TfrInterfacedObject = class(TObject, IUnknown)
  protected
  {$REGION 'IUnknown'}
    {$IFDEF FPC}
      function QueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} iid : tguid;out obj) : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    {$ELSE}
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    {$ENDIF}
    function _AddRef: Integer; {$IFDEF FPC}{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE} stdcall;{$ENDIF}
    function _Release: Integer; {$IFDEF FPC}{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE} stdcall;{$ENDIF}
  {$ENDREGION}
  end;

  { TfrCustomComponent }

  TfrCustomComponent = class(TComponent);
  TfrCollection = class;
  { TfrCollectionItem }

  TfrCollectionItem = class(TCollectionItem)
  protected
    FUniqueIndex: Integer;
    FIsInherited: Boolean;
    function GetInheritedName: String; virtual;
    procedure SetInheritedName(const Value: String); virtual;
  public
    constructor Create(ACollection: TCollection); override;
    procedure CreateUniqueIName(ACollection: TCollection);
    procedure WriteProperties(Writer: TObject; Ancestor: TfrCollection; Owner: TComponent); virtual;
    procedure ReadProperties(PropName: String; Reader: TObject; Ancestor: TfrCollection); virtual;
    function IsUniqueNameStored: Boolean; virtual;
    property IsInherited: Boolean read FIsInherited write FIsInherited;
    property InheritedName: String read GetInheritedName write SetInheritedName;
    property UniqueIndex: Integer read FUniqueIndex write FUniqueIndex;
  end;

  { TfrCollection }

  TfrCollection = class(TCollection)
  public
    procedure SerializeProperties(Writer: TObject; Ancestor: TfrCollection; Owner: TComponent); virtual;
    procedure DeserializeProperties(PropName: String; Reader: TObject; Ancestor: TfrCollection); virtual;
    function FindByName(Name: String): TfrCollectionItem; virtual;
  end;

  { TfrOwnObjList }

  TfrOwnObjList = class(TList)
  private
    FOwnsObjects: Boolean;
  protected
    function GetItem(Index: TfrListInteger): TObject;
  public
    constructor Create(AOwnsObjects: Boolean = True);
    procedure Clear; override;
    procedure AddNonZero(Item: Pointer);
    procedure Assign(SourceList: TList);

    property Items[Index: TfrListInteger]: TObject read GetItem; default;
  end;

procedure frRegisterFrameworkComponentClass(AComponentClass: TPersistentClass); overload;
procedure frRegisterFrameworkComponentClass(AComponentClasses: array of TPersistentClass); overload;

implementation

uses
{$IFNDEF FMX}
  frHashUtils,
{$ELSE}
  FMX.frHashUtils,
{$ENDIF}
  RTLConsts;

{$IFDEF FPC}
  resourcestring
    SGenericItemNotFound = 'Item not found';
    SGenericDuplicateItem = 'Duplicates not allowed';
{$ENDIF}

function StringHash(const AKey: Pointer): Integer;
var
  S: string;
begin
  S := PChar(AKey);
  Result := frElfHash(S);
end;

function AllocStr(const AValue: Pointer): Pointer;
begin
  Result := StrNew(PChar(AValue));
end;

procedure DisposeStr(const AValue: Pointer);
begin
  StrDispose(PChar(AValue));
end;

function SameStringKey(const AKey1, AKey2: Pointer): Boolean;
begin
  Result := SameStr(PChar(AKey1), PChar(AKey2));
end;

procedure frRegisterFrameworkComponentClass(AComponentClass: TPersistentClass);
begin
{$IFDEF DELPHI16}
  {$IFDEF FMX}
    StartClassGroup(TFmxObject);
    ActivateClassGroup(TFmxObject);
    GroupDescendentsWith(AComponentClass, TFmxObject);
  {$ELSE}
    StartClassGroup(TControl);
    ActivateClassGroup(TControl);
    GroupDescendentsWith(AComponentClass, TControl);
  {$ENDIF}
{$ENDIF}
end;

procedure frRegisterFrameworkComponentClass(AComponentClasses: array of TPersistentClass);
{$IFDEF DELPHI16}
  var
    I: Integer;
{$ENDIF}
begin
{$IFDEF DELPHI16}
  {$IFDEF FMX}
    StartClassGroup(TFmxObject);
    ActivateClassGroup(TFmxObject);
    for I := Low(AComponentClasses) to High(AComponentClasses) do
      GroupDescendentsWith(AComponentClasses[I], TFmxObject);
  {$ELSE}
    StartClassGroup(TControl);
    ActivateClassGroup(TControl);
    for I := Low(AComponentClasses) to High(AComponentClasses) do
      GroupDescendentsWith(AComponentClasses[I], TControl);
  {$ENDIF}
{$ENDIF}
end;

{ TfrMap }

constructor TfrMap.Create(AKeySize, AValueSize: Integer; AHashProc: THashProc);
begin
  inherited Create;
  FKeySize := AKeySize;
  FValueSize := AValueSize;
  FHashProc := AHashProc;
  SetLength(FItems, FDefaultItemsLength);
end;

destructor TfrMap.Destroy;
begin
  Clear;
  SetLength(FItems, 0);
  inherited Destroy;
end;

function TfrMap.AllocKey(const AKey: Pointer): Pointer;
begin
  if Assigned(AllocKeyProc) then
    Result := AllocKeyProc(AKey);
  if Result = nil then
  begin
    Result := AllocMem(KeySize);
    Move(AKey, Result, KeySize);
  end;
end;

function TfrMap.AllocValue(const AValue: Pointer): Pointer;
begin
  if Assigned(AllocValueProc) then
    Result := AllocValueProc(AValue);
  if Result = nil then
  begin
    Result := AllocMem(ValueSize);
    Move(AValue, Result, ValueSize);
  end;
end;

procedure TfrMap.DoAdd(const AKey, AValue: Pointer; ACheckDuplicates: Boolean);
var
  AIndex: Cardinal;
  AItem, APrev: PItem;
  AHash: Integer;
begin
  AHash := Hash(AKey);
  AIndex := AHash mod FDefaultItemsLength;
  AItem := FItems[AIndex];
  APrev := AItem;
  repeat
    if AItem = nil then
    begin
      AItem := NewItem(AKey, AValue, AHash);
      if APrev = nil then
        FItems[AIndex] := AItem
      else
        APrev.Next := AItem;
      Break;
    end;
    if (AHash = AItem.Hash) and SameKey(AKey, AItem.Key) then
    begin
      if ACheckDuplicates then
        raise EListError.CreateRes(@SGenericDuplicateItem)
      else
      begin
        DisposeValue(AItem.Value);
        AItem.Value := AllocValue(AValue);
        Break;
      end;
    end;
    APrev := AItem;
    AItem := AItem.Next;
  until False;
end;

function TfrMap.GetItem(const AKey: Pointer): Pointer;
begin
  if not TryGetValue(AKey, Result) then
    raise EListError.CreateRes(@SGenericItemNotFound);
end;

procedure TfrMap.DisposeItem(AItem: PItem);
begin
  DisposeKey(AItem.Key);
  DisposeValue(AItem.Value);
  Dispose(AItem);
end;

procedure TfrMap.DisposeKey(AKey: Pointer);
begin
  if Assigned(DisposeKeyProc) then
    DisposeKeyProc(AKey)
  else
    FreeMem(AKey);
end;

procedure TfrMap.DisposeValue(AValue: Pointer);
begin
  if Assigned(DisposeValueProc) then
    DisposeKeyProc(AValue)
  else
    FreeMem(AValue);
end;

procedure TfrMap.Add(const AKey, AValue: Pointer);
begin
  DoAdd(AKey, AValue, True);
end;

procedure TfrMap.AddOrSetValue(const AKey, AValue: Pointer);
begin
  DoAdd(AKey, AValue, False);
end;

function TfrMap.Hash(const AKey: Pointer): Integer;
begin
  Result := FHashProc(AKey);
end;

function TfrMap.Keys: TfrPointerList;
var
  I: Integer;
  AIndex: Integer;
  AItem: PItem;
begin
  SetLength(Result, Count);
  AIndex := 0;
  for I := 0 to FDefaultItemsLength - 1 do
  begin
    AItem := FItems[I];
    while AItem <> nil do
    begin
      Result[AIndex] := AItem.Key;
      Inc(AIndex);
      AItem := AItem.Next;
    end;
  end;
end;

function TfrMap.NewItem(const AKey, AValue: Pointer; AHash: Cardinal): PItem;
begin
  New(Result);
  Result.Key := AllocKey(AKey);
  Result.Value := AllocValue(AValue);
  Result.Hash := AHash;
  Result.Next := nil;
  Inc(FCount);
end;

function TfrMap.Remove(const AKey: Pointer): Boolean;
var
  AHash: Integer;
  AIndex: Integer;
  AItem, APrev, ANext: PItem;
begin
  Result := False;
  if FCount = 0 then
    Exit;

  AHash := Hash(AKey);
  AIndex := AHash mod FDefaultItemsLength;
  AItem := FItems[AIndex];
  if AItem = nil then
    Exit;
  APrev := nil;
  while AItem <> nil do
  begin
    ANext := AItem.Next;
    Result := (AHash = AItem.Hash) and SameKey(AKey, AItem.Key);
    if Result then
    begin
      if APrev = nil then
        FItems[AIndex] := ANext
      else
        APrev.Next := ANext;
      DisposeItem(AItem);
      Dec(FCount);
      Break;
    end;
    APrev := AItem;
    AItem := ANext;
  end;
end;

function TfrMap.SameKey(const AKey1, AKey2: Pointer): Boolean;
begin
  if Assigned(FSameKeyProc) then
    Result := FSameKeyProc(AKey1, AKey2)
  else
    Result := CompareMem(AKey1, AKey2, KeySize);
end;

procedure TfrMap.SetItem(const AKey, AValue: Pointer);
begin
  AddOrSetValue(AKey, AValue);
end;

function TfrMap.TryGetValue(const AKey: Pointer; out AValue: Pointer): Boolean;
var
  AIndex: Cardinal;
  AItem: PItem;
  AHash: Integer;
begin
  AHash := Hash(AKey);
  AIndex := AHash mod FDefaultItemsLength;
  AItem := FItems[AIndex];
  Result := AItem <> nil;
  if not Result then
    Exit;
  repeat
    if AItem = nil then
      Break;
    Result := (AHash = AItem.Hash) and SameKey(AKey, AItem.Key);
    if Result then
    begin
      AValue := AItem.Value;
      Exit;
    end;
    AItem := AItem.Next;
  until False;
end;

procedure TfrMap.Clear;
var
  I: Integer;
  AItem, ANextItem: PItem;
begin
  if FCount = 0 then
    Exit;
  for I := 0 to FDefaultItemsLength - 1 do
  begin
    AItem := FItems[I];
    while AItem <> nil do
    begin
      ANextItem := AItem.Next;
      DisposeItem(AItem);
      AItem := ANextItem;
    end;
    FItems[I] := nil;
  end;
  FCount := 0;
end;

function TfrMap.ContainsKey(const AKey: Pointer): Boolean;
var
  AItem: PItem;
  AHash: Integer;
begin
  Result := False;
  if FCount = 0 then
    Exit;
  AHash := Hash(AKey);
  AItem := FItems[AHash mod FDefaultItemsLength];
  if AItem = nil then
    Exit;
  while AItem <> nil do
  begin
    Result := (AHash = AItem.Hash) and SameKey(AKey, AItem.Key);
    if Result then
      Break;
    AItem := AItem.Next;
  end;
end;

{ TfrObjectMap }

constructor TfrObjectMap.Create(AOwnObjects: Boolean; AKeySize: Integer;
  AHashProc: TfrMap.THashProc);
begin
  inherited Create(AKeySize, SizeOf(Pointer), AHashProc);
  FOwnObjects := AOwnObjects;
end;

function TfrObjectMap.AllocValue(const AValue: Pointer): Pointer;
begin
  Result := AValue;
end;

procedure TfrObjectMap.DisposeValue(AValue: Pointer);
begin
  if FOwnObjects then
    FreeAndNil(AValue);
end;

{ TfrCustomDictionary }

constructor TfrCustomDictionary.Create;
begin
  inherited Create;
  FMap := CreateMap;
end;

destructor TfrCustomDictionary.Destroy;
begin
  FreeAndNil(FMap);
  inherited Destroy;
end;

procedure TfrCustomDictionary.Clear;
begin
  FMap.Clear;
end;

function TfrCustomDictionary.GetCount: Integer;
begin
  Result := FMap.Count;
end;

{ TfrNamedDictionary }

function TfrNamedDictionary.ContainsKey(const AKey: string): Boolean;
begin
  Result := Map.ContainsKey(PChar(AKey));
end;

function TfrNamedDictionary.CreateMap: TfrMap;
begin
  Result := TfrMap.Create(SizeOf(string), GetValueSize, StringHash);
  Result.AllocKeyProc := AllocStr;
  Result.DisposeKeyProc := DisposeStr;
  Result.SameKeyProc := SameStringKey;
end;

function TfrNamedDictionary.Keys: TStringDynArray;
var
  AResult: TfrPointerList;
  ALength: Integer;
  I: Integer;
begin
  AResult := Map.Keys;
  ALength := Length(AResult);
  SetLength(Result, ALength);
  for I := 0 to ALength - 1 do
    Result[I] := PChar(AResult[I]);
end;

function TfrNamedDictionary.Remove(const AKey: string): Boolean;
begin
  Result := Map.Remove(PChar(AKey));
end;

{ TfrNamedObjectDictionary }

constructor TfrNamedObjectDictionary.Create(AOwnObjects: Boolean);
begin
  FOwnObjects := AOwnObjects;
  inherited Create;
end;

procedure TfrNamedObjectDictionary.Add(const AKey: string; const AValue: TObject);
begin
  Map.Add(PChar(AKey), AValue);
end;

procedure TfrNamedObjectDictionary.AddOrSetValue(const AKey: string; const AValue: TObject);
begin
  Map.AddOrSetValue(PChar(AKey), AValue);
end;

function TfrNamedObjectDictionary.CreateMap: TfrMap;
begin
  Result := TfrObjectMap.Create(FOwnObjects, SizeOf(string), StringHash);
  Result.AllocKeyProc := AllocStr;
  Result.DisposeKeyProc := DisposeStr;
  Result.SameKeyProc := SameStringKey;
end;

function TfrNamedObjectDictionary.GetItem(const AKey: string): TObject;
begin
  Result := TObject(Map[Pointer(AKey)])
end;

function TfrNamedObjectDictionary.GetValueSize: Integer;
begin
  Result := SizeOf(Pointer);
end;

procedure TfrNamedObjectDictionary.SetItem(const AKey: string;
  const Value: TObject);
begin
  Map[Pointer(AKey)] := Value;
end;

function TfrNamedObjectDictionary.TryGetValue(const AKey: string;
  out AValue: TObject): Boolean;
var
  AResult: Pointer;
begin
  Result := Map.TryGetValue(Pointer(AKey), AResult);
  if Result then
    AValue := TObject(AResult);
end;

{ TfrStringDictionary }

procedure TfrStringDictionary.Add(const AKey, AValue: string);
begin
  Map.Add(PChar(AKey), PChar(AValue));
end;

procedure TfrStringDictionary.AddOrSetValue(const AKey, AValue: string);
begin
  Map.AddOrSetValue(PChar(AKey), PChar(AValue));
end;

function TfrStringDictionary.CreateMap: TfrMap;
begin
  Result := inherited CreateMap;
  Result.AllocValueProc := AllocStr;
  Result.DisposeValueProc := DisposeStr;
end;

function TfrStringDictionary.GetItem(const AKey: string): string;
begin
  Result := PChar(Map[Pointer(AKey)]);
end;

function TfrStringDictionary.GetValueSize: Integer;
begin
  Result := SizeOf(string);
end;

procedure TfrStringDictionary.SetItem(const AKey, AValue: string);
begin
  Map[Pointer(AKey)] := PChar(AValue);
end;

function TfrStringDictionary.TryGetValue(const AKey: string;
  out AValue: string): Boolean;
var
  AResult: Pointer;
begin
  Result := Map.TryGetValue(Pointer(AKey), AResult);
  if Result then
    AValue := PChar(AResult);
end;

{ TfrInterfacedObject }

{$IFDEF FPC}
  function TfrInterfacedObject.QueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} iid : tguid;out obj) : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
{$ELSE}
  function TfrInterfacedObject.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
{$ENDIF}
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TfrInterfacedObject._AddRef: Integer;
begin
  Result := -1;
end;

function TfrInterfacedObject._Release: Integer;
begin
  Result := -1;
end;

{ TfrCollectionItem }

{ TODO: Make sorted regions list for indexes }
{ shold be enough for simple collections }
constructor TfrCollectionItem.Create(ACollection: TCollection);
begin
  if IsUniqueNameStored then
    CreateUniqueIName(ACollection);
  inherited;
end;

procedure TfrCollectionItem.CreateUniqueIName(ACollection: TCollection);
var
  i, nMax, nMin: Integer;
  Item: TfrCollectionItem;
begin
  nMin := MaxInt;
  nMax := 1;
  for i := 0 to ACollection.Count - 1 do
  begin
    Item := TfrCollectionItem(ACollection.Items[i]);
    if nMin > Item.FUniqueIndex then
      nMin := Item.FUniqueIndex;
    if nMax < Item.FUniqueIndex then
      nMax := Item.FUniqueIndex;
  end;

  if nMin > 1 then
    FUniqueIndex := 1
  else
    FUniqueIndex := nMax + 1;
end;

procedure TfrCollectionItem.ReadProperties(PropName: String;
  Reader: TObject; Ancestor: TfrCollection);
begin

end;

function TfrCollectionItem.GetInheritedName: String;
begin
  Result := 'frxUIN' + IntToStr(FUniqueIndex);
end;

function TfrCollectionItem.IsUniqueNameStored: Boolean;
begin
  Result := False;
end;

procedure TfrCollectionItem.WriteProperties(Writer: TObject;
  Ancestor: TfrCollection; Owner: TComponent);
begin

end;

procedure TfrCollectionItem.SetInheritedName(const Value: String);
begin
  // do nothing
end;

{ TfrCollection }

procedure TfrCollection.DeserializeProperties(PropName: String;
  Reader: TObject; Ancestor: TfrCollection);
begin

end;

function TfrCollection.FindByName(Name: String): TfrCollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if TfrCollectionItem(Items[i]).InheritedName = Name then
    begin
      Result := TfrCollectionItem(Items[i]);
      Exit;
    end;
end;

procedure TfrCollection.SerializeProperties(Writer: TObject;
  Ancestor: TfrCollection; Owner: TComponent);
begin
end;

{ TfrOwnObjList }

procedure TfrOwnObjList.AddNonZero(Item: Pointer);
begin
  if Item <> nil then
    Add(Item);
end;

procedure TfrOwnObjList.Assign(SourceList: TList);
begin
  inherited Assign(SourceList);
  if SourceList is TfrOwnObjList then
    FOwnsObjects := TfrOwnObjList(SourceList).FOwnsObjects;
end;

procedure TfrOwnObjList.Clear;
var
  i: Integer;
begin
  if FOwnsObjects then
    for i := 0 to Count - 1 do
      Items[i].Free;
  inherited Clear;
end;

constructor TfrOwnObjList.Create(AOwnsObjects: Boolean = True);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

function TfrOwnObjList.GetItem(Index: TfrListInteger): TObject;
begin
  Result := inherited Items[Index]; // Pointer => TObject
end;

initialization
  frRegisterFrameworkComponentClass(TfrCustomComponent);
end.
