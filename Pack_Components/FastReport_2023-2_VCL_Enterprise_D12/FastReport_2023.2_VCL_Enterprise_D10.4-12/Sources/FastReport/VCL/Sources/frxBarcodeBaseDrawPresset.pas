
{******************************************}
{                                          }
{             FastReport VCL               }
{         Barcode BaseDrawPresset          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeBaseDrawPresset;

interface

{$I frx.inc}

uses
  Classes, Types, SysUtils, Graphics, Menus, frxClass, frxBarcode, frxBarcod,
  frxCustomEditors, frx2DBarcodesPresets, frxBarcodeComposite;

type
  TfrxBarcodeDrawPresset = class(TfrxObjectDataPreset, IStringClassNameContainer)
  private
    function GetSupportedClasses: TList;
  public
    //constructor Create(AOwner: TfrxComponent);
    //destructor Destroy; override;
    //procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect); virtual;
    //procedure EndDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect); virtual;
    //function GetData(aReport: TfrxReport): String; virtual;
    //function IsHasPresetData: Boolean; virtual;
  end;

  TfrxBaseDrawPreset = class(TfrxCustomObjectPreset)
  public
    //constructor Create; override;
    //destructor Destroy; override;
    function GetData(aReport: TfrxReport): String; override;
    procedure ApplySettings(aComponent: TfrxComponent); override;
    procedure SaveComponentState(aComponent: TfrxComponent); override;
    procedure RestoreComponentState(aComponent: TfrxComponent); override;
    procedure Draw(c: TfrxBarCodeCompositeView; Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); virtual;
  end;

function frxBarcodeDrawPresetList: TList;

implementation

var
  FBarcodeDrawPresetList: TList;

{ TfrxBarcodePresset }

function TfrxBarcodeDrawPresset.GetSupportedClasses: TList;
begin
  Result := frxBarcodeDrawPresetList;
end;

{ TfrxCompositeBasePreset }

function TfrxBaseDrawPreset.GetData(aReport: TfrxReport): String;
begin
  Result := '';
end;

procedure TfrxBaseDrawPreset.ApplySettings(aComponent: TfrxComponent);
begin
  //none
end;

procedure TfrxBaseDrawPreset.SaveComponentState(aComponent: TfrxComponent);
begin
  //none
end;

procedure TfrxBaseDrawPreset.RestoreComponentState(aComponent: TfrxComponent);
begin
  //none
end;

procedure TfrxBaseDrawPreset.Draw(c: TfrxBarCodeCompositeView; Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  //none
end;

{ other }

function frxBarcodeDrawPresetList: TList;
begin
  if not Assigned(FBarcodeDrawPresetList) then
  begin
    FBarcodeDrawPresetList := TList.Create;
    FBarcodeDrawPresetList.Add(nil); // empty !
  end;
  Result := FBarcodeDrawPresetList;
end;

initialization
  RegisterClasses([TfrxBarcodeDrawPresset]);

finalization
  FreeAndNil(FBarcodeDrawPresetList);

end.
