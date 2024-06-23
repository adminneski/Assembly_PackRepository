
{******************************************}
{                                          }
{             FastReport VCL               }
{          Barcode BaseBarPreset           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeBaseBarPresset;

interface

{$I frx.inc}

uses
  Classes, Types, SysUtils, Graphics, Menus, frxClass, frxBarcodeComposite;

type
  TfrxBaseBarPreset = class
  private
    FName: String;
  protected
    procedure DoSetPresset(AComponent: TfrxBarCodeCompositeView); virtual; abstract;
  public
    constructor Create(AName: String); virtual;
    procedure SetPresset(AComponent: TfrxBarCodeCompositeView);
    property Name: String read FName write FName;
  end;

function frxBarcodeBarPresetList: TList;

implementation

var
  FBarcodeBarPresetList: TList;

{ TfrxBaseBarPreset }

constructor TfrxBaseBarPreset.Create(AName: String);
begin
  FName := AName;
end;

{ other }

function frxBarcodeBarPresetList: TList;
begin
  if not Assigned(FBarcodeBarPresetList) then
  begin
    FBarcodeBarPresetList := TList.Create;
    FBarcodeBarPresetList.Add(nil); // empty !
  end;
  Result := FBarcodeBarPresetList;
end;

procedure ClearBarcodeBarBarPresetList;
var
  i: Integer;
begin
  for i := 1 to FBarcodeBarPresetList.Count - 1 do
    TfrxBaseBarPreset(frxBarcodeBarPresetList.List[i]).Free;
end;

procedure TfrxBaseBarPreset.SetPresset(AComponent: TfrxBarCodeCompositeView);
begin
  AComponent.Clear;
  DoSetPresset(AComponent);
end;

initialization

finalization
  ClearBarcodeBarBarPresetList;
  FreeAndNil(FBarcodeBarPresetList);

end.
