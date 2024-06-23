
{******************************************}
{                                          }
{             FastReport VCL               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxProtocolFactory;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
{$IFDEF FPC}
  LResources, LCLType, LazHelper, LMessages,
{$ENDIF}
  SysUtils, Classes, SyncObjs;

type
  TfrxDataLinkLoadMethod = (dlmGetLink, dlmOnGetData, dlmOnLoading);

  IfrxDataLinkObject = interface
  ['{83CD083D-0399-44F2-B0F7-3A3F8109EE0E}']
    function LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
    function GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
    function IsExpressionLink: Boolean;
  end;

  TfrxCustomDatalinkProtocol = class
  public
    class function LoadBy(var Link: String; Stream: TStream; BoundData: TObject = nil): Boolean; virtual;
  end;

  TfrxCustomDatalinkProtocolClass = class of TfrxCustomDatalinkProtocol;

  TfrxProtocolItem = class
  private
    FProtocolName: String;
    FProtocol: TfrxCustomDatalinkProtocolClass;
    FData: TObject;
  public
    property ProtocolName: String read FProtocolName write FProtocolName;
    property Data: TObject read FData write FData;
    property Protocol: TfrxCustomDatalinkProtocolClass read FProtocol write FProtocol;
  end;

  TfrxDataLinkProtocols = class
  private
    FListCS: TCriticalSection;
    FList: TList;
    FWriteLock: Boolean;
    FReadLockCounter: Integer;
    function GetItem(Index: Integer): TfrxProtocolItem;
    function IndexOf(const ProtocolName: String): Integer;
    procedure Lock(IsWriting: Boolean = False);
    procedure Unlock(IsWriting: Boolean = False);
    procedure Clear;
    procedure ParseLink(var Protocol: String; var Link: String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Register(AClass: TfrxCustomDatalinkProtocolClass; const ProtocolName: String; BoundData: TObject = nil);
    procedure Unregister(const ProtocolName: String);
    function LoadByLink(var Link: String; Stream: TStream): Boolean;
    function LoadToObject(var Link: String; DataLinkObject: IfrxDataLinkObject): Boolean;
    function GetProtocol(const Link: String): TfrxCustomDatalinkProtocolClass;
    function GetProtocolItem(const Link: String): TfrxProtocolItem;
    property Items[Index: Integer]: TfrxProtocolItem read GetItem; default;
  end;


function frxDataProtocols: TfrxDataLinkProtocols;

implementation

uses
  frXML, frxDataLinkInPlaceEditor;

var
  GDataProtocols: TfrxDataLinkProtocols = nil;

function frxDataProtocols: TfrxDataLinkProtocols;
begin
  if GDataProtocols = nil then
    GDataProtocols := TfrxDataLinkProtocols.Create;
  Result := GDataProtocols;
end;

{ TfrxDatallnkProtocols }

procedure TfrxDataLinkProtocols.Clear;
var
  i: Integer;
begin
  Lock(True);
  try
    for i := 0 to FList.Count - 1 do
      TObject(FList[i]).Free;
    FList.Clear;
  finally
    Unlock(True);
  end;
end;

constructor TfrxDataLinkProtocols.Create;
begin
  FList := TList.Create;
  FListCS := TCriticalSection.Create;
end;

destructor TfrxDataLinkProtocols.Destroy;
begin
  Clear;
  FreeAndNil(FList);
  FreeAndNil(FListCS);
  inherited;
end;

function TfrxDataLinkProtocols.GetItem(Index: Integer): TfrxProtocolItem;
begin
  Result := TfrxProtocolItem(FList[Index]);
end;

function TfrxDataLinkProtocols.GetProtocol(
  const Link: String): TfrxCustomDatalinkProtocolClass;
var
  Item: TfrxProtocolItem;
begin
  Item := GetProtocolItem(Link);
  if Assigned(Item) then
    Result := Item.Protocol
  else
    Result := nil;
end;

function TfrxDataLinkProtocols.GetProtocolItem(
  const Link: String): TfrxProtocolItem;
var
  LProtocol, LLink: String;
  i: Integer;
begin
  Result := nil;
  LLink := Link;
  ParseLink(LProtocol, LLink);
  Lock;
  try
    i := IndexOf(LProtocol);
    if i < 0 then Exit;
    Result := Items[i];
  finally
    Unlock;
  end;
end;

function TfrxDataLinkProtocols.IndexOf(const ProtocolName: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  Lock;
  try
    for i := 0 to FList.Count - 1 do
    begin
      if SameText(TfrxProtocolItem(FList[i]).ProtocolName, ProtocolName) then
      begin
        Result := i;
        break;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TfrxDataLinkProtocols.LoadByLink(var Link: String; Stream: TStream): Boolean;
var
  Item: TfrxProtocolItem;
begin
  Result := False;
  Item := GetProtocolItem(Link);
  if not Assigned(Item) then Exit;
  Result := Item.Protocol.LoadBy(Link, Stream, Item.Data);
end;

function TfrxDataLinkProtocols.LoadToObject(var Link: String;
  DataLinkObject: IfrxDataLinkObject): Boolean;
var
  m: TMemoryStream;
  Item: TfrxProtocolItem;
begin
  Result := False;
  Item := GetProtocolItem(Link);
  if not Assigned(DataLinkObject) or not Assigned(Item) then Exit;
  m := TMemoryStream.Create;
  try
    if Item.Protocol.LoadBy(Link, m, Item.Data) then
    begin
      m.Position := 0;
      Result := DataLinkObject.LoadDataStream(m, Link);
    end;
  except
    Result := False;
  end;
  m.Free;
end;

procedure TfrxDataLinkProtocols.Lock(IsWriting: Boolean);
begin
  if IsWriting then
    FWriteLock := True
  else
  begin
    Inc(FReadLockCounter);
    if FReadLockCounter = 1 then
      FListCS.Enter;
  end;
  if FWriteLock then
    FListCS.Enter;
end;

procedure TfrxDataLinkProtocols.ParseLink(var Protocol, Link: String);
var
  Index: Integer;
begin
  Protocol := '';
  Index := Pos('://', Link);
  if Index <= 0 then Exit;
  Protocol := Copy(Link, 1, Index - 1);
  Delete(Link, 1, Index + 2);
end;

procedure TfrxDataLinkProtocols.Register(
  AClass: TfrxCustomDatalinkProtocolClass; const ProtocolName: String; BoundData: TObject = nil);
var
  Item: TfrxProtocolItem;
begin
  if AClass = nil then Exit;
  Item := TfrxProtocolItem.Create;
  Item.Protocol := AClass;
  Item.ProtocolName := ProtocolName;
  Item.Data := BoundData;
  Lock(True);
  try
    FList.Add(Item);
  finally
    Unlock(True);
  end;
end;

procedure TfrxDataLinkProtocols.Unlock(IsWriting: Boolean);
begin
  if FWriteLock then
    FListCS.Leave
  else
  begin
    if FReadLockCounter = 1 then
      FListCS.Leave;
    Dec(FReadLockCounter);
    if FReadLockCounter < 0 then
      FReadLockCounter := 0;
  end;
  if IsWriting then
    FWriteLock := False;
end;

procedure TfrxDataLinkProtocols.Unregister(const ProtocolName: String);
var
  Index: Integer;
  Item: TfrxProtocolItem;
begin
  Index := IndexOf(ProtocolName);
  if Index > -1 then
  begin
    Item := TfrxProtocolItem(FList[Index]);
    Lock(True);
    try
      FList.Delete(Index);
    finally
      Unlock(True);
    end;
    Item.Free;
  end;
end;

{ TfrxCustomDatalinkProtocol }

class function TfrxCustomDatalinkProtocol.LoadBy(var Link: String; Stream: TStream; BoundData: TObject): Boolean;
begin
  raise EAbstractError.Create(Format('Method LoadBy in %s', [ClassName]));
end;

initialization

finalization
  FreeAndNil(GDataProtocols);

end.

