{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{   Export DBVertGridEh into XML Spreadsheet Format     }
{                                                       }
{    Copyright (c) 2014-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit DBVertGridEhXMLSpreadsheetExp;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes, Graphics, Dialogs, GridsEh, Controls,
  Variants,
{$IFDEF EH_LIB_17} System.UITypes, System.Contnrs, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType,
    {$IFDEF FPC_CROSSP}
      LCLIntf,
    {$ELSE}
      Windows, Win32Extra,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, Messages, SqlTimSt,
  {$ENDIF}
{$ENDIF}
    DBAxisGridsEh, DBVertGridsEh, Db, XMLSpreadsheetFormatEh;

procedure DBVertGridEh_ExportToStreamAsXMLSpreadsheet(DBVertGridEh: TCustomDBVertGridEh;
  Stream: TStream; Options: TExportAsXMLSpShOptionsEh; ForWholeGrid: Boolean);

implementation

type
  TDBVertGridCrackEh = class(TCustomDBVertGridEh);

function IsNumber(const st: String): Boolean;
var
  b: Boolean;
  i, n: Integer;
begin
  b := True;
  n := Length(st);
  for i := 1 to n do
    if not CharInSetEh(st[i], ['#', '0', ',', '.']) then
      b := False;
  Result := b;
end;

procedure DBVertGridEh_ExportToStreamAsXMLSpreadsheet(DBVertGridEh: TCustomDBVertGridEh;
  Stream: TStream; Options: TExportAsXMLSpShOptionsEh; ForWholeGrid: Boolean);
var
  DBVertGridEhCrack: TDBVertGridCrackEh;
  FSeparator: Char;
  i: Integer;
  FromIndex, ToIndex: Integer;
  XMLSpreadsheet: TXMLSpreadsheetExportEh;
  RowCellParamsEh: TRowCellParamsEh;
  ASelectionType: TDBVertGridSelectionTypeEh;

  procedure FillRowLabelCellStyle(ARowLabel: TRowLabelEh; var CellStyle: TSpShStyleEh);
  begin
    if (xmlssColoredEh in Options) then
      CellStyle.Interior.Color := ARowLabel.Color
    else
      CellStyle.Interior.Color := clDefault;
    if DBVertGridEh.LabelColParams.HorzLines
       and (dgvhRowLines in DBVertGridEh.Options)
    then
    begin
      CellStyle.Border[bpTopEh].LineStyle    := lsContinuousEh;
      CellStyle.Border[bpTopEh].Color        := DBVertGridEh.LabelColParams.HorzLineColor;
      CellStyle.Border[bpBottomEh].LineStyle := lsContinuousEh;
      CellStyle.Border[bpBottomEh].Color     := DBVertGridEh.LabelColParams.HorzLineColor;
    end;
    if DBVertGridEh.LabelColParams.VertLines
       and (dgvhColLines in DBVertGridEh.Options)
    then
    begin
      CellStyle.Border[bpLeftEh].LineStyle  := lsContinuousEh;
      CellStyle.Border[bpLeftEh].Color      := DBVertGridEh.LabelColParams.VertLineColor;
      CellStyle.Border[bpRightEh].LineStyle := lsContinuousEh;
      CellStyle.Border[bpRightEh].Color     := DBVertGridEh.LabelColParams.VertLineColor;
    end;
    case ARowLabel.Alignment of
      taLeftJustify:  CellStyle.AlignmentHorizontal := haLeftJustifyEh;
      taCenter:       CellStyle.AlignmentHorizontal := haCenterEh;
      taRightJustify: CellStyle.AlignmentHorizontal := haRightJustifyEh;
    end;
    CellStyle.AlignmentVertical := vaCenterEh;
    XMLSpreadsheet.SetFont(CellStyle, ARowLabel.Font);
  end;

  procedure GetDataCellValueAsXMLSpSh(FieldRow: TFieldRowEh; RowCellParamsEh: TRowCellParamsEh; var CellStyle: TSpShStyleEh; var CellType, CellValue: String);
  var
    Data: Variant;
    dec_sep: Char;
  begin

    if FieldRow.Field = nil then
    begin
      CellValue := RowCellParamsEh.Text;
      CellType  := 'String';
    end
    else if FieldRow.GetBarType = ctKeyPickList then
    begin
      CellValue := RowCellParamsEh.Text;
      CellType  := 'String';
    end
    else if FieldRow.Field.IsNull then
    begin
      CellValue := '';
      CellType  := 'String';
    end
    else
    begin
      if (xmlssDataAsEditTextEh in Options) then
      begin
        CellValue := FieldRow.Field.Text;
        CellType  := 'String';
      end
      else if (xmlssDataAsDisplayTextEh in Options) then
      begin
        CellValue := RowCellParamsEh.Text;
        CellType  := 'String';
      end
      else if (FieldRow.Field.DataType in [ftDate, ftDateTime])
              and (not FieldRow.Field.IsNull) 
              and (FieldRow.Field.AsDateTime < EncodeDate(1900, 1, 1)) 
      then
      begin
        CellValue := RowCellParamsEh.Text;
        CellType  := 'String';
      end
      else
      begin
        if FieldRow.Field.DataType in [ftBlob, ftGraphic, ftParadoxOle, ftDBaseOle,
             ftOraBlob, ftBytes, ftTypedBinary, ftVarBytes]
        then
        begin
          CellValue := '';
          CellType  := 'String';
        end
        else
        begin
          Data := FieldRow.Field.Value;
          if (FieldRow.Field.DataType in [ftSmallint, ftInteger, ftWord, ftAutoInc,
               ftBytes, ftFloat, ftCurrency, ftBCD, ftFMTBcd,
               ftLargeInt
  {$IFDEF EH_LIB_12}
              ,ftLongWord, ftShortint, ftByte, TFieldType.ftExtended
  {$ENDIF}
  {$IFDEF EH_LIB_13}
              ,ftSingle
  {$ENDIF}
               ])
          then
          begin
            if {(FieldRow.DisplayFormat <> '') and} IsNumber(FieldRow.DisplayFormat) then
              CellType := 'Number'
            else
              CellType := 'String';
          end
          else if VarType(Data) = varDate then
            CellType := 'DateTime'
          else
            CellType := 'String';

          if VarType(Data) = varDate then
          begin
            dec_sep := FormatSettings.DecimalSeparator;
            FormatSettings.DecimalSeparator := '.';
            CellValue := FormatDateTime('YYYY"-"MM"-"DD"T"HH":"NN":"SS"."ZZZ', Data);
            FormatSettings.DecimalSeparator := dec_sep;
            CellStyle.SpShNumberFormat := 'Short Date';
          end
          else
            CellValue := VarToStr(Data);
        end;
      end;
    end;
  end;

  procedure FillFieldRowCellStyle(FieldRow: TFieldRowEh; RowCellParamsEh: TRowCellParamsEh; var CellStyle: TSpShStyleEh);
  begin
    if (xmlssColoredEh in Options)
      then CellStyle.Interior.Color := RowCellParamsEh.Background
      else  CellStyle.Interior.Color := FieldRow.Color;
    if FieldRow.Grid.GridLineParams.DataHorzLines
       and (dgvhRowLines in DBVertGridEh.Options)
    then
    begin
      CellStyle.Border[bpTopEh].LineStyle    := lsContinuousEh;
      CellStyle.Border[bpBottomEh].LineStyle := lsContinuousEh;
    end;
    if FieldRow.Grid.GridLineParams.DataVertLines
       and (dgvhColLines in DBVertGridEh.Options)
    then
    begin
      CellStyle.Border[bpLeftEh].LineStyle  := lsContinuousEh;
      CellStyle.Border[bpRightEh].LineStyle := lsContinuousEh;
    end;
    If FieldRow.FitRowHeightToData and FieldRow.WordWrap then
      CellStyle.AlignmentWrapText := True;
    case RowCellParamsEh.Alignment of
      taLeftJustify:  CellStyle.AlignmentHorizontal := haLeftJustifyEh;
      taCenter:       CellStyle.AlignmentHorizontal := haCenterEh;
      taRightJustify: CellStyle.AlignmentHorizontal := haRightJustifyEh;
    end;
    CellStyle.Font.Name  := RowCellParamsEh.Font.Name;
    CellStyle.Font.Size  := RowCellParamsEh.Font.Size;
    CellStyle.Font.Style := RowCellParamsEh.Font.Style;
    CellStyle.Font.Color := RowCellParamsEh.Font.Color;
  end;

  procedure GetFieldRowParams(FieldRow: TFieldRowEh; var CellStyle: TSpShStyleEh; var CellType, CellValue: String);
  var
    NewBackground: TColor;
    cp: TRowCellParamsEh;
  begin
    DBVertGridEh.Canvas.Font := FieldRow.Font;
    cp := RowCellParamsEh;

    cp.Row := -1;
    cp.Col := -1;
    cp.State := [];
    cp.Font := DBVertGridEh.Canvas.Font;
    cp.Background := FieldRow.Color;
    NewBackground := FieldRow.Color;
    cp.Alignment := FieldRow.Alignment;
    cp.ImageIndex := FieldRow.GetImageIndex;
    cp.Text := FieldRow.DisplayText;
    cp.CheckboxState := FieldRow.CheckboxState;

    if Assigned(DBVertGridEhCrack.OnGetCellParams) then
      DBVertGridEhCrack.OnGetCellParams(DBVertGridEh, FieldRow, cp.Font, NewBackground, cp.State);
    cp.Background := NewBackground;

    FieldRow.GetColCellParams(False, RowCellParamsEh);

    GetDataCellValueAsXMLSpSh(FieldRow, RowCellParamsEh, CellStyle, CellType, CellValue);
    FillFieldRowCellStyle(FieldRow, RowCellParamsEh, CellStyle);
  end;

  procedure ExportRow(XMLSpreadsheet: TXMLSpreadsheetExportEh; FieldRow: TFieldRowEh; ExportLabel: Boolean);
  var
    CellType, CellValue: String;
    CellStyle: TSpShStyleEh;
  begin
    XMLSpreadsheet.BeginRow;
    if ExportLabel then
    begin
      XMLSpreadsheet.InitializeStyle(CellStyle);
      FillRowLabelCellStyle(FieldRow.RowLabel, CellStyle);
      CellType  := 'String';
      CellValue := FieldRow.RowLabel.Caption;
      XMLSpreadsheet.AddCell(CellStyle, '', CellType, CellValue);
    end;

    XMLSpreadsheet.InitializeStyle(CellStyle);
    GetFieldRowParams(FieldRow, CellStyle, CellType, CellValue);
    XMLSpreadsheet.AddCell(CellStyle, '', CellType, CellValue);
    XMLSpreadsheet.EndRow;
  end;
begin
  RowCellParamsEh := TRowCellParamsEh.Create;
  FSeparator := FormatSettings.DecimalSeparator;
  try
    DBVertGridEhCrack := TDBVertGridCrackEh(DBVertGridEh);
    if not(xmlssDataAsEditTextEh in Options)
       and not(xmlssDataAsDisplayTextEh in Options)
    then
      FormatSettings.DecimalSeparator := '.';
    XMLSpreadsheet := TXMLSpreadsheetExportEh.Create;

    if dgvhLabelCol in DBVertGridEh.Options then
      XMLSpreadsheet.AddColumn(DBVertGridEh.LabelColWidth);
    XMLSpreadsheet.AddColumn(DBVertGridEh.VisibleFieldRow[0].Width);
    if ForWholeGrid
      then ASelectionType := vgstAllEh
      else ASelectionType := DBVertGridEh.Selection.SelectionType;

    case ASelectionType of
      vgstRowsEh:
        for i := 0 to DBVertGridEh.Selection.Rows.Count-1 do
          ExportRow(XMLSpreadsheet, DBVertGridEh.Selection.Rows[i], (dgvhLabelCol in DBVertGridEh.Options));
      vgstRectangleEh:
        begin
          if DBVertGridEh.Selection.AnchorRowIndex > DBVertGridEh.Selection.ShipRowIndex then
          begin
            FromIndex := DBVertGridEh.Selection.ShipRowIndex;
            ToIndex := DBVertGridEh.Selection.AnchorRowIndex;
          end
          else
          begin
            FromIndex := DBVertGridEh.Selection.AnchorRowIndex;
            ToIndex := DBVertGridEh.Selection.ShipRowIndex;
          end;
          for i := FromIndex to ToIndex do
            ExportRow(XMLSpreadsheet, DBVertGridEh.Rows[i], False);
        end;
      vgstAllEh:
        for i := 0 to DBVertGridEh.VisibleFieldRowCount-1 do
          ExportRow(XMLSpreadsheet, DBVertGridEh.VisibleFieldRow[i], (dgvhLabelCol in DBVertGridEh.Options));
      vgstNonEh:
        if DBVertGridEh.SelectedIndex >= 0 then
          ExportRow(XMLSpreadsheet, DBVertGridEh.Rows[DBVertGridEh.SelectedIndex], False);
    end;

    XMLSpreadsheet.ExportToStream(Stream);

    FreeAndNil(XMLSpreadsheet);
  finally
    FormatSettings.DecimalSeparator := FSeparator;
    RowCellParamsEh.Free;
  end;
end;

end.
