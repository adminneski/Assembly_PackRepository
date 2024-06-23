
{******************************************}
{                                          }
{             FastReport VCL               }
{       Barcode Presset EAN-UPCSupp        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeBarPressetEANUPCSupp;

interface

{$I frx.inc}

uses
  Classes, Types, SysUtils, Graphics, Menus, frxClass,
  frxBarcodeComposite, frxBarcodeBaseBarPresset;

type
  TfrxBarPresetEANUPCSupp = class(TfrxBaseBarPreset)
  private
    FType: Integer;
  protected
    procedure DoSetPresset(AComponent: TfrxBarCodeCompositeView); override;
  public
    constructor Create(vName: String; vType: Integer); reintroduce; overload;
  end;

implementation

uses
  frxBarcodeInterface, frxBarcod;

constructor TfrxBarPresetEANUPCSupp.Create(vName: String; vType: Integer);
begin
  inherited Create(vName);
  FType := vType;
end;

procedure TfrxBarPresetEANUPCSupp.DoSetPresset(AComponent: TfrxBarCodeCompositeView);
var
  lb: TfrxBarCodeInternalView;
  LTRRPositions: TfrxLeftToRightRelativityPositions;
begin
  AComponent.ContentType := ctRightToLeft;
  case (FType) of
    0, 1: AComponent.AddLinearBarcode(bcCodeEAN8);
    2, 3: AComponent.AddLinearBarcode(bcCodeEAN13);
  end;
  lb := AComponent.GetLastBar as TfrxBarCodeInternalView;
  lb.TextSup := 'ISBN 000-0-01234-567-8';
  case (FType) of
    0, 2: AComponent.AddLinearBarcode(bcCodeUPC_Supp2);
    1, 3: AComponent.AddLinearBarcode(bcCodeUPC_Supp5);
  end;
  lb := AComponent.GetLastBar as TfrxBarCodeInternalView;
  lb.Text := '12345';
  lb.BarcodeText.TextSettings.BarTextPos := btpTop;
  lb.Position.Padding.Left := 3;
  LTRRPositions := TfrxLeftToRightRelativityPositions(lb.Position.RelativityPositions);
  LTRRPositions.RelativityBootomPosition := rbTextPos;
  LTRRPositions.RelativityTopPosition := rtTextPos;
end;

initialization
  frxBarcodeBarPresetList.Add(TfrxBarPresetEANUPCSupp.Create('EAN8 + UPC_Supp2' , 0));
  frxBarcodeBarPresetList.Add(TfrxBarPresetEANUPCSupp.Create('EAN8 + UPC_Supp5' , 1));
  frxBarcodeBarPresetList.Add(TfrxBarPresetEANUPCSupp.Create('EAN13 + UPC_Supp2', 2));
  frxBarcodeBarPresetList.Add(TfrxBarPresetEANUPCSupp.Create('EAN13 + UPC_Supp5', 3));

end.
