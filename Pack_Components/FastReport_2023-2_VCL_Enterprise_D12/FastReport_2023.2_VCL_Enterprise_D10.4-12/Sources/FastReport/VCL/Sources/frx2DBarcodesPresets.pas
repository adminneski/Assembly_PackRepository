
{ ****************************************** }
{                                            }
{             FastReport VCL                 }
{          Barcode Add-in object             }
{                                            }
{         Copyright (c) 1998-2021            }
{            by Fast Reports Inc.            }
{                                            }
{ ****************************************** }

unit frx2DBarcodesPresets;

interface

{$I frx.inc}

uses
  Types, SysUtils, Classes, frxClass, Graphics;

type
  TfrxObjectDataPreset = class(TInterfacedPersistent, IStringClassNameContainer)
  private
    FOwner: TfrxComponent;
    FDataObject: TfrxCustomObjectPreset;
    procedure SetPresetClass(const Value: TfrxStringClassName);
    function GetPresetClass: TfrxStringClassName;
    function GetDataObject: TfrxCustomObjectPreset;
    procedure ClearPreset;
    function GetSupportedClasses: TList;
  public
    constructor Create(AOwner: TfrxComponent);
    destructor Destroy; override;
    procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect); virtual;
    procedure EndDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect); virtual;
    function GetData(aReport: TfrxReport): String; virtual;
    function IsHasPresetData: Boolean; virtual;

  published
    property PresetClass: TfrxStringClassName read GetPresetClass write SetPresetClass;
    property DataObject: TfrxCustomObjectPreset read GetDataObject;
  end;

  function frxBarcode2DPresetList: TList;

implementation
var
  FBarcode2DPresetList: TList;

function frxBarcode2DPresetList: TList;
begin
  if not Assigned(FBarcode2DPresetList) then
  begin
    FBarcode2DPresetList := TList.Create;
    FBarcode2DPresetList.Add(nil); // empty !
  end;
  Result := FBarcode2DPresetList;
end;

{ TfrxObjectDataPreset }

procedure TfrxObjectDataPreset.ClearPreset;
begin
  if Assigned(FDataObject) then
  begin
    FDataObject.RestoreComponentState(FOwner);
    FreeAndNil(FDataObject);
  end;
end;

constructor TfrxObjectDataPreset.Create(AOwner: TfrxComponent);
begin
  FOwner := AOwner;
end;

destructor TfrxObjectDataPreset.Destroy;
begin
  ClearPreset;
  inherited;
end;

procedure TfrxObjectDataPreset.BeginDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect);
begin
  if Assigned(DataObject) then
    DataObject.BeginDraw(Canvas, ScaleX, ScaleY, Area);
end;

procedure TfrxObjectDataPreset.EndDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect);
begin
  if Assigned(DataObject) then
    DataObject.EndDraw(Canvas, ScaleX, ScaleY, Area);
end;

function TfrxObjectDataPreset.GetData(aReport: TfrxReport): String;
begin
  if Assigned(DataObject) then
    Result := DataObject.GetData(aReport)
  else
    Result := '';
end;

function TfrxObjectDataPreset.GetDataObject: TfrxCustomObjectPreset;
begin
  Result := FDataObject;
end;

function TfrxObjectDataPreset.GetPresetClass: TfrxStringClassName;
begin
  Result := '';
  if Assigned(FDataObject) then
    Result := FDataObject.ClassName;
end;

function TfrxObjectDataPreset.GetSupportedClasses: TList;
begin
  Result := frxBarcode2DPresetList;
end;

function TfrxObjectDataPreset.IsHasPresetData: Boolean;
begin
  Result := Assigned(FDataObject);
end;

procedure TfrxObjectDataPreset.SetPresetClass(const Value: TfrxStringClassName);
var
  cl: TPersistentClass;
begin
  cl := nil;
  if Value <> '' then
    cl := GetClass(Value);
  if (Value = '') or Assigned(cl) then
    ClearPreset;
  if Assigned(cl) then
  begin
    FDataObject := TfrxCustomObjectPreset(cl.NewInstance);
    FDataObject.Create;
    if not FOwner.IsLoading then
      FDataObject.SaveComponentState(FOwner);
    FDataObject.ApplySettings(FOwner);
  end;
end;

initialization
  RegisterClasses([TfrxObjectDataPreset]);

finalization
  FreeAndNil(FBarcode2DPresetList);

end.
