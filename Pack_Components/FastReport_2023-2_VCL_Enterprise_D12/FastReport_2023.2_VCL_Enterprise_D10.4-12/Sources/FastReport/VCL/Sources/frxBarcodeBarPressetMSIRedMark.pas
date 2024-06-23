
{******************************************}
{                                          }
{             FastReport VCL               }
{       Barcode Presset MSI-RedMark        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeBarPressetMSIRedMark;

interface

{$I frx.inc}

uses
  Classes, Types, SysUtils, Graphics, Menus, frxClass,
  frxBarcodeComposite, frxBarcodeBaseBarPresset;

type
  TfrxBarPresetMSIRedMark = class(TfrxBaseBarPreset)
  public
    procedure SetPresset(c: TfrxBarCodeCompositeView); override;
  end;

implementation

uses
  frxBarcodeInterface, frxBarcodeDrawPressetMark;

procedure TfrxBarPresetMSIRedMark.SetPresset(c: TfrxBarCodeCompositeView);
var
  lb: TfrxBarCodeInternalView;
begin
  c.Add1DBarClick(13);
  lb := c.GetLastBar as TfrxBarCodeInternalView;
  lb.Text := '12345';
  c.DrawPreset.PresetClass := 'TfrxMarkPreset';
  TfrxMarkPreset(c.DrawPreset.DataObject).Color := clRed;
end;

initialization
  frxBarcodeBarPresetList.Add(TfrxBarPresetMSIRedMark.Create('Red MSI Mark'));

end.
