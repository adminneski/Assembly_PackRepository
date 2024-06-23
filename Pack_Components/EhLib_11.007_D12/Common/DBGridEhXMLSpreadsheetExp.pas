{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{     Export DBGridEh into XML Spreadsheet Format       }
{                                                       }
{    Copyright (c) 2014-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit DBGridEhXMLSpreadsheetExp;

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
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType,
    DBGridsEh,
  {$ELSE}
    EhLibVCL, Messages, SqlTimSt, DBGridEh,
  {$ENDIF}
{$ENDIF}
  DBGridEhImpExp, ToolCtrlsEh,
  DBAxisGridsEh, Contnrs, 
  Db, {ComObj, }StdCtrls, XMLSpreadsheetFormatEh;

type

{ TDBGridEhExportAsXMLSpreadsheet }

  TDBGridEhExportAsXMLSpreadsheet = class(TDBGridEhExport)
  private
    FOptions: TExportAsXMLSpShOptionsEh;
    FSeparator: Char;
    XMLSpreadsheet: TXMLSpreadsheetExportEh;
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;

    property Options: TExportAsXMLSpShOptionsEh read FOptions write FOptions;
  end;

{$IFDEF FPC}
{$ELSE}
  procedure ExportDBGridEhToXMLSpreadsheet(DBGridEh: TCustomDBGridEh;
    const FileName: String;
    Options: TExportAsXMLSpShOptionsEh; IsSaveAll: Boolean = True);
{$ENDIF}

implementation

{ DBGridEhImpExp.pas }

type
  TTitleExpRec = record
    Height: Integer;
    PTLeafCol: TDBGridMultiTitleNodeEh;
  end;

  TTitleExpArr = array of TTitleExpRec;

procedure CalcSpan(
  ColumnsList: TColumnsEhList; ListOfHeadTreeNodeList: TObjectList;
  Row, Col: Integer;
  var AColSpan: Integer; var ARowSpan: Integer
  );
var
  Node: TDBGridMultiTitleNodeEh;
  i, k: Integer;
begin
  AColSpan := 1; ARowSpan := 1;
  Node := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[Row]).Items[Col]);
  if Node <> nil then
  begin
    for k := Row - 1 downto 0 do
      if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[Col]) = Node
        then
      begin
        Inc(ARowSpan);
        TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[Col] := nil;
      end else
        Break;

    for i := Col + 1 to ColumnsList.Count - 1 do
      if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[Row]).Items[i]) = Node
        then
      begin
        Inc(AColSpan);
        TObjectList(ListOfHeadTreeNodeList.Items[Row]).Items[i] := nil;
      end else
        Break;

    for k := Row - 1 downto Row - ARowSpan + 1 do
      for i := Col + 1 to Col + AColSpan - 1 do
        TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i] := nil;
  end;
end;

procedure CreateMultiTitleMatrix(DBGridEh: TCustomDBGridEh;
  ColumnsList: TColumnsEhList; out FPTitleExpArr: TTitleExpArr;
  var ListOfHeadTreeNodeList: TObjectList);
var
  i: Integer;
  NeedNextStep: Boolean;
  MinHeight: Integer;
  FHeadTreeNodeList: TObjectList;
begin
  ListOfHeadTreeNodeList := nil;
  SetLength(FPTitleExpArr, ColumnsList.Count);
  for i := 0 to ColumnsList.Count - 1 do
  begin
    FPTitleExpArr[i].Height := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf.Height;
    FPTitleExpArr[i].PTLeafCol := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf;
  end;
  ListOfHeadTreeNodeList := TObjectListEh.Create;
  NeedNextStep := True;
  while True do
  begin
    
    MinHeight := FPTitleExpArr[0].Height;
    for i := 1 to ColumnsList.Count - 1 do
      if FPTitleExpArr[i].Height < MinHeight then
        MinHeight := FPTitleExpArr[i].Height;
    
    FHeadTreeNodeList := TObjectListEh.Create;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      FHeadTreeNodeList.Add(FPTitleExpArr[i].PTLeafCol);
      if FPTitleExpArr[i].Height = MinHeight then
      begin
        if FPTitleExpArr[i].PTLeafCol.Parent <> nil then
        begin
          FPTitleExpArr[i].PTLeafCol := FPTitleExpArr[i].PTLeafCol.Parent;
          Inc(FPTitleExpArr[i].Height, FPTitleExpArr[i].PTLeafCol.Height);
          NeedNextStep := True;
        end;
      end;
    end;
    if not NeedNextStep then
    begin
      FreeAndNil(FHeadTreeNodeList);
      Break;
    end;
    ListOfHeadTreeNodeList.Add(FHeadTreeNodeList);
    NeedNextStep := False;
  end;
end;

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

{ TDBGridEhExportAsXMLSpreadsheet }

procedure TDBGridEhExportAsXMLSpreadsheet.ExportToStream(AStream: TStream;
  IsExportAll: Boolean);
begin
  inherited ExportToStream(AStream, IsExportAll);
end;

procedure TDBGridEhExportAsXMLSpreadsheet.WriteTitle(
  ColumnsList: TColumnsEhList);
var
  i, k: Integer;
  ListOfHeadTreeNodeList: TObjectList;
  FPTitleExpArr: TTitleExpArr;
  ColSpan, RowSpan: Integer;
  CellStyle: TSpShStyleEh;
  HeaNode: TDBGridMultiTitleNodeEh;
  ColIndexNeeded: Boolean;
  ColIndex: String;
begin
  ColIndexNeeded := False;
  if ColumnsList.Count = 0 then
    Exit;
  if DBGridEh.IsUseMultiTitle then
  begin
    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);
      for k := ListOfHeadTreeNodeList.Count - 1 downto 0 do
      begin
        XMLSpreadsheet.BeginRow;
        for i := 0 to ColumnsList.Count - 1 do
        begin
          if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            XMLSpreadsheet.InitializeStyle(CellStyle);
            if (xmlssColoredEh in FOptions) then
              CellStyle.Interior.Color := ColumnsList[i].Title.Color
            else
              CellStyle.Interior.Color := TDBGridEh(DBGridEh).Color;
            if DBGridEh.TitleParams.HorzLines then
            begin
              CellStyle.Border[bpTopEh].LineStyle := lsContinuousEh;
              CellStyle.Border[bpBottomEh].LineStyle := lsContinuousEh;
              CellStyle.Border[bpTopEh].Color := DBGridEh.GridLineParams.DataHorzColor;
              CellStyle.Border[bpBottomEh].Color := DBGridEh.GridLineParams.DataHorzColor;
            end;
            if DBGridEh.TitleParams.VertLines then
            begin
              CellStyle.Border[bpLeftEh].LineStyle := lsContinuousEh;
              CellStyle.Border[bpRightEh].LineStyle := lsContinuousEh;
              CellStyle.Border[bpLeftEh].Color := DBGridEh.GridLineParams.DataVertColor;
              CellStyle.Border[bpRightEh].Color := DBGridEh.GridLineParams.DataVertColor;
            end;
            if dghAutoFitRowHeight in ColumnsList[i].Grid.OptionsEh then
              CellStyle.AlignmentWrapText := True;
            if ColumnsList[i].Title.Orientation = tohVertical then
              CellStyle.AlignmentRotate := 90;
            case ColumnsList[i].Title.Alignment of
              taLeftJustify:  CellStyle.AlignmentHorizontal := haLeftJustifyEh;
              taCenter:       CellStyle.AlignmentHorizontal := haCenterEh;
              taRightJustify: CellStyle.AlignmentHorizontal := haRightJustifyEh;
            end;
            CellStyle.AlignmentVertical := vaCenterEh;
            XMLSpreadsheet.SetFont(CellStyle, ColumnsList[i].Title.Font);
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
            if ColSpan > 1 then
              CellStyle.MergeCells.ColSpan := ColSpan - 1;
            if RowSpan > 1 then
              CellStyle.MergeCells.RowSpan := RowSpan - 1;

            HeaNode := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]);
            if ColIndexNeeded
              then ColIndex := IntToStr(i+1)
              else ColIndex := '';
            XMLSpreadsheet.AddCell(CellStyle, ColIndex, 'String', HeaNode.Text);
            ColIndexNeeded := False;
          end else
            ColIndexNeeded := True;
        end;
        XMLSpreadsheet.EndRow;
      end;

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        FreeObjectEh(ListOfHeadTreeNodeList.Items[i]);
      FreeAndNil(ListOfHeadTreeNodeList);
    end;
  end
  else
  begin
    XMLSpreadsheet.BeginRow;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      XMLSpreadsheet.InitializeStyle(CellStyle);
      if (xmlssColoredEh in FOptions) then
        CellStyle.Interior.Color := ColumnsList[i].Title.Color
      else
        CellStyle.Interior.Color := TDBGridEh(DBGridEh).Color;
      if DBGridEh.TitleParams.HorzLines then
      begin
        CellStyle.Border[bpTopEh].LineStyle := lsContinuousEh;
        CellStyle.Border[bpBottomEh].LineStyle := lsContinuousEh;
        CellStyle.Border[bpTopEh].Color := DBGridEh.GridLineParams.DataHorzColor;
        CellStyle.Border[bpBottomEh].Color := DBGridEh.GridLineParams.DataHorzColor;
      end;
      if DBGridEh.TitleParams.VertLines then
      begin
        CellStyle.Border[bpLeftEh].LineStyle  := lsContinuousEh;
        CellStyle.Border[bpRightEh].LineStyle := lsContinuousEh;
        CellStyle.Border[bpLeftEh].Color := DBGridEh.GridLineParams.DataVertColor;
        CellStyle.Border[bpRightEh].Color := DBGridEh.GridLineParams.DataVertColor;
      end;
      if dghAutoFitRowHeight in ColumnsList[i].Grid.OptionsEh then
        CellStyle.AlignmentWrapText := True;
      if ColumnsList[i].Title.Orientation = tohVertical then
        CellStyle.AlignmentRotate := 90;
      case ColumnsList[i].Title.Alignment of
        taLeftJustify:  CellStyle.AlignmentHorizontal := haLeftJustifyEh;
        taCenter:       CellStyle.AlignmentHorizontal := haCenterEh;
        taRightJustify: CellStyle.AlignmentHorizontal := haRightJustifyEh;
      end;
      CellStyle.AlignmentVertical := vaCenterEh;
      XMLSpreadsheet.SetFont(CellStyle, ColumnsList[i].Title.Font);
      XMLSpreadsheet.AddCell(CellStyle, '', 'String', ColumnsList[i].Title.Caption);
    end;
    XMLSpreadsheet.EndRow;
  end;
end;

procedure TDBGridEhExportAsXMLSpreadsheet.WritePrefix;
var
  i: Integer;
begin
  FSeparator := FormatSettings.DecimalSeparator;
  if not(xmlssDataAsEditTextEh in FOptions)
     and not(xmlssDataAsDisplayTextEh in FOptions)
  then
    FormatSettings.DecimalSeparator := '.';

  XMLSpreadsheet := TXMLSpreadsheetExportEh.Create;

  for i := 0 to ExpCols.Count-1 do
    XMLSpreadsheet.AddColumn(ExpCols[i].Width);
end;

procedure TDBGridEhExportAsXMLSpreadsheet.WriteRecord(
  ColumnsList: TColumnsEhList);
begin
  XMLSpreadsheet.BeginRow;
  inherited WriteRecord(ColumnsList);
  XMLSpreadsheet.EndRow;
end;

procedure TDBGridEhExportAsXMLSpreadsheet.WriteDataCell(Column: TColumnEh;
  FColCellParamsEh: TColCellParamsEh);
var
  CellStyle: TSpShStyleEh;
  CellType, CellValue: String;
  Data: Variant;
  dec_sep: Char;
begin
  XMLSpreadsheet.InitializeStyle(CellStyle);
  if (xmlssColoredEh in FOptions) then
    CellStyle.Interior.Color := FColCellParamsEh.Background
  else
    CellStyle.Interior.Color := TDBGridEh(DBGridEh).Color;
  if Column.Grid.GridLineParams.DataHorzLines then
  begin
    CellStyle.Border[bpTopEh].LineStyle := lsContinuousEh;
    CellStyle.Border[bpBottomEh].LineStyle := lsContinuousEh;
    CellStyle.Border[bpTopEh].Color := DBGridEh.GridLineParams.DataHorzColor;
    CellStyle.Border[bpBottomEh].Color := DBGridEh.GridLineParams.DataHorzColor;
  end;
  if Column.Grid.GridLineParams.DataVertLines then
  begin
    CellStyle.Border[bpLeftEh].LineStyle  := lsContinuousEh;
    CellStyle.Border[bpRightEh].LineStyle := lsContinuousEh;
    CellStyle.Border[bpLeftEh].Color := DBGridEh.GridLineParams.DataVertColor;
    CellStyle.Border[bpRightEh].Color := DBGridEh.GridLineParams.DataVertColor;
  end;
  if dghAutoFitRowHeight in Column.Grid.OptionsEh then
    CellStyle.AlignmentWrapText := True;
  case FColCellParamsEh.Alignment of
    taLeftJustify:  CellStyle.AlignmentHorizontal := haLeftJustifyEh;
    taCenter:       CellStyle.AlignmentHorizontal := haCenterEh;
    taRightJustify: CellStyle.AlignmentHorizontal := haRightJustifyEh;
  end;
  XMLSpreadsheet.SetFont(CellStyle, FColCellParamsEh.Font);

  if (Column.Field = nil) then
  begin
    CellValue := FColCellParamsEh.Text;
    CellType  := 'String';
  end
  else if ((Column.Field <> nil) and (Assigned(Column.Field.OnGetText))) then
  begin
    CellValue := Column.Field.Text; 
    CellType  := 'String';
  end
  else if Column.GetBarType = ctKeyPickList then
  begin
    CellValue := FColCellParamsEh.Text;
    CellType  := 'String';
  end
  else if Column.Field.IsNull then
  begin
    CellValue := '';
    CellType  := 'String';
  end
  else
  begin
    if (xmlssDataAsEditTextEh in FOptions) then
    begin
      CellValue := Column.Field.Text;
      CellType  := 'String';
    end
    else if (xmlssDataAsDisplayTextEh in FOptions) then
    begin
      CellValue := FColCellParamsEh.Text;
      CellType  := 'String';
    end
    else if (Column.Field.DataType in [ftDate, ftDateTime])
            and (not Column.Field.IsNull) 
            and (Column.Field.AsDateTime < EncodeDate(1900, 1, 1)) 
    then
    begin
      CellValue := FColCellParamsEh.Text;
      CellType  := 'String';
    end
    else
    begin
      if Column.Field.DataType in [ftBlob, ftGraphic, ftParadoxOle, ftDBaseOle,
           ftOraBlob, ftBytes, ftTypedBinary, ftVarBytes]
      then
      begin
        CellValue := '';
        CellType  := 'String';
      end
      else
      begin
        Data := Column.Field.Value;
        if (Column.Field.DataType in [ftSmallint, ftInteger, ftWord, ftAutoInc,
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
          if IsNumber(Column.DisplayFormat) then
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

  XMLSpreadsheet.AddCell(CellStyle, '', CellType, CellValue);
end;

procedure TDBGridEhExportAsXMLSpreadsheet.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
begin
  XMLSpreadsheet.BeginRow;
  inherited WriteFooter(ColumnsList, FooterNo);
  XMLSpreadsheet.EndRow;
end;

procedure TDBGridEhExportAsXMLSpreadsheet.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment;
  const Text: String);
var
  Footer: TColumnFooterEh;
  CellValue, CellType: String;
  CellStyle: TSpShStyleEh;
begin
  Footer := Column.ColumnUsedFooter(Row);

  XMLSpreadsheet.InitializeStyle(CellStyle);
  if (xmlssColoredEh in FOptions) then
    CellStyle.Interior.Color := Footer.Color
  else
    CellStyle.Interior.Color := TDBGridEh(DBGridEh).Color;
  if dghAutoFitRowHeight in Column.Grid.OptionsEh then
    CellStyle.AlignmentWrapText := True;

  CellStyle.Border[bpTopEh].LineStyle    := lsContinuousEh;
  CellStyle.Border[bpBottomEh].LineStyle := lsContinuousEh;
  CellStyle.Border[bpLeftEh].LineStyle   := lsContinuousEh;
  CellStyle.Border[bpRightEh].LineStyle  := lsContinuousEh;
  CellStyle.Border[bpTopEh].Color := DBGridEh.GridLineParams.DataHorzColor;
  CellStyle.Border[bpBottomEh].Color := DBGridEh.GridLineParams.DataHorzColor;
  CellStyle.Border[bpLeftEh].Color := DBGridEh.GridLineParams.DataVertColor;
  CellStyle.Border[bpRightEh].Color := DBGridEh.GridLineParams.DataVertColor;

  case Alignment of
    taLeftJustify:  CellStyle.AlignmentHorizontal := haLeftJustifyEh;
    taCenter:       CellStyle.AlignmentHorizontal := haCenterEh;
    taRightJustify: CellStyle.AlignmentHorizontal := haRightJustifyEh;
  end;
  XMLSpreadsheet.SetFont(CellStyle, AFont);

  CellValue := '';
  CellType  := 'String';
  case Footer.ValueType of
    fvtAvg, fvtCount, fvtSum, fvtFieldValue:
      begin
        if IsNumber(Text) then
          CellType := 'Number'
        else
          CellType := 'String';
        CellValue := Text;
      end;
    fvtStaticText:
      begin
        CellValue := Text;
        CellType  := 'String';
      end;
    else
      begin
        CellValue := '';
        CellType  := 'String';
      end;
  end;

  XMLSpreadsheet.AddCell(CellStyle, '', CellType, CellValue);
end;

procedure TDBGridEhExportAsXMLSpreadsheet.WriteSuffix;
begin
  XMLSpreadsheet.ExportToStream(FStream);
  FreeAndNil(XMLSpreadsheet);

  FormatSettings.DecimalSeparator := FSeparator;
end;

procedure ExportDBGridEhToXMLSpreadsheet(DBGridEh: TCustomDBGridEh;
  const FileName: String;
  Options: TExportAsXMLSpShOptionsEh; IsSaveAll: Boolean = True);
var
  XMLSpreadsheet: TDBGridEhExportAsXMLSpreadsheet;
begin
  XMLSpreadsheet := TDBGridEhExportAsXMLSpreadsheet.Create;
  try
    XMLSpreadsheet.DBGridEh := DBGridEh;
    XMLSpreadsheet.FOptions := Options;
    XMLSpreadsheet.ExportToFile(FileName, IsSaveAll);
  finally
    XMLSpreadsheet.Free;
  end;
end;

end.

