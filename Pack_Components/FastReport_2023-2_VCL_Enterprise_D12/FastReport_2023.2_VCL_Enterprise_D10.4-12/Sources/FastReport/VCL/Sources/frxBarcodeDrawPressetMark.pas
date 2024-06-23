
{******************************************}
{                                          }
{             FastReport VCL               }
{         Barcode DrawPressetMark          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeDrawPressetMark;

interface

{$I frx.inc}

uses
  Classes, Types, SysUtils, Graphics, Menus, frxClass, frxBarcode, frxBarcod,
  frxCustomEditors, frxBarcodeBaseDrawPresset, frxBarcodeComposite
{$IFNDEF RAD_ED}{$IFNDEF ACADEMIC_ED}, frxBarcode2D{$ENDIF}{$ENDIF}
;

type
  TEANType = (EAN8 = 0, EAN13 = 1);
  TUPCType = (UPC_Supp2 = 0, UPC_Supp5 = 1);

  TfrxMarkPreset = class(TfrxBaseDrawPreset)
  protected
    FColor: TColor;
  public
    procedure Draw(c: TfrxBarCodeCompositeView; Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
  published
    property Color: TColor read FColor write FColor;
  end;

implementation

uses frxBarcodeInterface;

{ TfrxEANUPCPreset }

procedure TfrxMarkPreset.Draw(c: TfrxBarCodeCompositeView; Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  X, Y, X1, Y1: Integer;
begin
  X := Round(c.AbsLeft);
  Y := Round(c.AbsTop);
  X1 := X + Round(c.Width);
  Y1 := Y + Round(c.Height);

  Canvas.Pen.Color := FColor;
  Canvas.Pen.Width := 3;

  Canvas.MoveTo(X, Y);
  Canvas.LineTo(X1, Y1);
  Canvas.MoveTo(X1, Y);
  Canvas.LineTo(X, Y1);
end;

initialization
  RegisterClasses([TfrxMarkPreset]);
  frxBarcodeDrawPresetList.Add(TfrxMarkPreset);

end.
