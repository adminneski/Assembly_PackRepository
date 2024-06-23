{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{             DBGridEh import/export routines           }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit DBVertGridEhImpExp;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes, Graphics, Dialogs, GridsEh, Controls, Variants,
{$IFDEF EH_LIB_16} System.Zip, {$ENDIF}
{$IFDEF FPC}
  XMLRead, DOM, EhLibXmlConsts,
{$ELSE}
  xmldom, XMLIntf, XMLDoc, EhLibXmlConsts,
{$ENDIF}

{$IFDEF EH_LIB_17} System.UITypes, System.Contnrs, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType,
  {$ELSE}
    EhLibVCL, Messages, SqlTimSt,
  {$ENDIF}
{$ENDIF}
  XlsMemFilesEh,
  DBVertGridsEh,
  Db, Clipbrd, StdCtrls;

  procedure ExportDBVertGridEhToXlsx(DBVertGridEh: TCustomDBVertGridEh;
    const FileName: String);

implementation

procedure ExportDBVertGridEhToXlsx(DBVertGridEh: TCustomDBVertGridEh;
  const FileName: String);
var
  cr: IXlsFileCellsRangeEh;
  xlsFile: TXlsMemFileEh;
  Sheet: TXlsWorksheetEh;
  i: Integer;
  AFont: TFont;
begin
  xlsFile := TXlsMemFileEh.Create;
  xlsFile.Workbook.Worksheets[0].Name := 'Sheet1';
  Sheet := xlsFile.Workbook.Worksheets[0];

  Sheet.Columns[0].Width := Sheet.Columns.ScreenToXlsWidth(TDBVertGridEh(DBVertGridEh).ColWidths[0]);
  Sheet.Columns[1].Width := Sheet.Columns.ScreenToXlsWidth(TDBVertGridEh(DBVertGridEh).ColWidths[1]);

  for i := 0 to DBVertGridEh.VisibleFieldRowCount - 1 do
  begin
    Sheet.Cells[0, i].Value := DBVertGridEh.VisibleFieldRow[i].RowLabel.Caption;
    cr := Sheet.GetCellsRange(0, i, 0, i);
    cr.Fill.Color := DBVertGridEh.VisibleFieldRow[i].RowLabel.Color;

    AFont := DBVertGridEh.VisibleFieldRow[i].RowLabel.Font;
    cr.Font.Name := AFont.Name;
    cr.Font.Size := AFont.Size;
    cr.Font.Color := AFont.Color;
    cr.Font.IsBold := fsBold in AFont.Style;
    cr.Font.IsItalic := fsItalic in AFont.Style;
    cr.Font.IsUnderline := fsUnderline in AFont.Style;

    cr.ApplyChages;

    Sheet.Cells[1, i].Value := DBVertGridEh.VisibleFieldRow[i].Field.Value;
    cr := Sheet.GetCellsRange(1, i, 1, i);
    cr.Fill.Color := DBVertGridEh.VisibleFieldRow[i].Color;

    AFont := DBVertGridEh.VisibleFieldRow[i].Font;
    cr.Font.Name := AFont.Name;
    cr.Font.Size := AFont.Size;
    cr.Font.Color := AFont.Color;
    cr.Font.IsBold := fsBold in AFont.Style;
    cr.Font.IsItalic := fsItalic in AFont.Style;
    cr.Font.IsUnderline := fsUnderline in AFont.Style;

    cr.HorzAlign := AlignmentToXlsFileCellHorzAlign(DBVertGridEh.VisibleFieldRow[i].Alignment);

    cr.ApplyChages;
  end;

  cr := Sheet.GetCellsRange(0,0, 1,DBVertGridEh.VisibleFieldRowCount - 1);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;

  cr.Border.InsideVertical.Style := clsThinEh;
  cr.Border.InsideHorizontal.Style := clsThinEh;
  cr.ApplyChages;

  xlsFile.SaveToFile(FileName);
  xlsFile.Free;
end;

end.

