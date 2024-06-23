
{******************************************}
{                                          }
{             FastReport VCL               }
{            Table Object RTTI             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxTableObjectRTTI;

interface

{$I frx.inc}

implementation

uses
  Types, Classes, SysUtils,
  fs_iinterpreter, frxClassRTTI, frxTableObject, Variants, frCore;


type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
    procedure SetProp(Instance: TObject; ClassType: TClass;
      const PropName: String; Value: Variant);
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddEnum('TfrxTablePagination', 'tpAcrossThenDown, tpDownThenAcross, tpDownThenAcrossWrapped');
    AddEnum('TfrxTableBandType', 'tbData, tbHeader, tbFooter, tbAggregateFooter, tbLocalAggregateFooter');

    with AddClass(TfrxTableCell, 'TfrxCustomMemoView') do
    begin
      AddMethod('function ParentTable: TfrxTableObject', CallMethod);
      AddMethod('function ParentRow: TfrxTableRow', CallMethod);
    end;

    with AddClass(TfrxCellData, 'TObject') do
    begin
      AddProperty('ColSpan', 'Integer', GetProp, SetProp);
      AddProperty('RowSpan', 'Integer', GetProp, SetProp);
      AddProperty('Value', 'Variant', GetProp, SetProp);
      AddProperty('Text', 'String', GetProp, SetProp);
    end;

    with AddClass(TfrxCustomTableBuilder, 'TPersistent') do
    begin
      AddMethod('procedure PrintRow(Index: Integer; TableBandType: TfrxTableBandType = tbData)', CallMethod);
      AddMethod('procedure PrintRows(Index: Integer = 0)', CallMethod);
      AddMethod('procedure PrintColumn(Index: Integer; TableBandType: TfrxTableBandType = tbData)', CallMethod);
      AddMethod('procedure PrintColumns(Index: Integer = 0)', CallMethod);
      AddMethod('procedure PageBreak', CallMethod);
      AddMethod('function ColumnCount: Integer', CallMethod);
      AddMethod('function RowCount: Integer', CallMethod);
      AddIndexProperty('CellData', 'Integer,Integer', 'TfrxCellData', CallMethod);
      AddProperty('PaginationOrder', 'TfrxTablePagination', GetProp, SetProp);
      AddProperty('PrintingRowIndex', 'Integer', GetProp, nil);
      AddProperty('PrintingColumnIndex', 'Integer', GetProp, nil);
    end;

    with AddClass(TfrxTableRowColumnBase, 'TfrxComponent') do
    begin
      AddMethod('function ParentTable: TfrxTableObject', CallMethod);
      AddProperty('Index', 'Integer', GetProp, nil);
    end;

    AddClass(TfrxTableColumn, 'TfrxTableRowColumnBase');

    with AddClass(TfrxTableRow, 'TfrxTableRowColumnBase') do
    begin
      AddProperty('CellCount', 'Integer', GetProp, nil);
      AddIndexProperty('Cells', 'Integer', 'TfrxTableCell', CallMethod);
    end;

    with AddClass(TfrxTableObject, 'TfrxStretcheable') do
    begin
      AddMethod('function CreateNewColumn(Index: Integer): TfrxTableColumn', CallMethod);
      AddMethod('function CreateNewRow(Index: Integer): TfrxTableRow', CallMethod);
      AddMethod('procedure AddColumn(Value: TfrxTableColumn)', CallMethod);
      AddMethod('procedure InsertColumn(Index: Integer; Value: TfrxTableColumn)', CallMethod);
      AddMethod('procedure MoveColumn(Index, NewIndex: Integer)', CallMethod);
      AddMethod('procedure DeleteColumn(Index: Integer)', CallMethod);
      AddMethod('procedure AddRow(Value: TfrxTableRow)', CallMethod);
      AddMethod('procedure InsertRow(Index: Integer; Value: TfrxTableRow)', CallMethod);
      AddMethod('procedure SwapRows(Row1, Row2: Integer)', CallMethod);
      AddMethod('procedure DeleteRow(Index: Integer)', CallMethod);
      AddMethod('procedure UpdateBounds;', CallMethod);
      AddMethod('procedure JoinSelection(TopX: Integer; TopY: Integer; BottomX: Integer; BottomY: Integer)', CallMethod);
      AddMethod('procedure SplitCell(aCell: TfrxTableCell)', CallMethod);
      AddMethod('function Cells(X, Y: Integer): TfrxTableCell', CallMethod);

      AddIndexProperty('Columns', 'Integer', 'TfrxTableColumn', CallMethod);
      AddIndexProperty('Rows', 'Integer', 'TfrxTableRow', CallMethod);
      AddProperty('TableHeight', 'Extended', GetProp, SetProp);
      AddProperty('TableWidth', 'Extended', GetProp, SetProp);
      AddProperty('TableBuilder', 'TfrxCustomTableBuilder', GetProp, nil);
    end;
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;
  if ClassType = TfrxCustomTableBuilder then
  begin
    if MethodName = 'PRINTROW' then
      TfrxCustomTableBuilder(Instance).PrintRow(Caller.Params[0], Caller.Params[1])
    else if MethodName = 'PRINTROWS' then
      TfrxCustomTableBuilder(Instance).PrintRows(Caller.Params[0])
    else if MethodName = 'PRINTCOLUMN' then
      TfrxCustomTableBuilder(Instance).PrintColumn(Caller.Params[0], Caller.Params[1])
    else if MethodName = 'PRINTCOLUMNS' then
      TfrxCustomTableBuilder(Instance).PrintColumns(Caller.Params[0])
    else if MethodName = 'PAGEBREAK' then
      TfrxCustomTableBuilder(Instance).PageBreak
    else if MethodName = 'COLUMNCOUNT' then
      Result := TfrxCustomTableBuilder(Instance).ColumnCount
    else if MethodName = 'ROWCOUNT' then
      Result := TfrxCustomTableBuilder(Instance).RowCount
    else if MethodName = 'CELLDATA.GET' then
      Result := frInteger(TfrxCustomTableBuilder(Instance).CellData[Caller.Params[0], Caller.Params[1]])
  end
  else if ClassType = TfrxTableCell then
  begin
    if MethodName = 'PARENTTABLE' then
      Result := frInteger(TfrxTableCell(Instance).ParentTable)
    else if MethodName = 'PARENTROW' then
      Result := frInteger(TfrxTableCell(Instance).ParentRow)
  end
  else if ClassType = TfrxTableRowColumnBase then
  begin
    if MethodName = 'PARENTTABLE' then
      Result := frInteger(TfrxTableRowColumnBase(Instance).ParentTable)
  end
  else if ClassType = TfrxTableRow then
  begin
    if MethodName = 'CELLS.GET' then
      Result := frInteger(TfrxTableRow(Instance).Cells[Caller.Params[0]])
  end
  else if ClassType = TfrxTableObject then
  begin
    if MethodName = 'CREATENEWCOLUMN' then
      Result := frInteger(TfrxTableObject(Instance).CreateNewColumn(Caller.Params[0]))
    else if MethodName = 'CREATENEWROW' then
      Result := frInteger(TfrxTableObject(Instance).CreateNewRow(Caller.Params[0]))
    else if MethodName = 'ADDCOLUMN' then
      TfrxTableObject(Instance).AddColumn(TfrxTableColumn(frInteger(Caller.Params[0])))
    else if MethodName = 'INSERTCOLUMN' then
      TfrxTableObject(Instance).InsertColumn(Caller.Params[0], TfrxTableColumn(frInteger(Caller.Params[1])))
    else if MethodName = 'MOVECOLUMN' then
      TfrxTableObject(Instance).MoveColumn(Caller.Params[0], Caller.Params[1])
    else if MethodName = 'DELETECOLUMN' then
      TfrxTableObject(Instance).DeleteColumn(Caller.Params[0])
    else if MethodName = 'ADDROW' then
      TfrxTableObject(Instance).AddRow(TfrxTableRow(frInteger(Caller.Params[0])))
    else if MethodName = 'INSERTROW' then
      TfrxTableObject(Instance).InsertRow(Caller.Params[0], TfrxTableRow(frInteger(Caller.Params[1])))
    else if MethodName = 'SWAPROWS' then
      TfrxTableObject(Instance).SwapRows(Caller.Params[0], Caller.Params[1])
    else if MethodName = 'DELETEROW' then
      TfrxTableObject(Instance).DeleteRow(Caller.Params[0])
    else if MethodName = 'UPDATEBOUNDS' then
      TfrxTableObject(Instance).UpdateBounds
    else if MethodName = 'JOINSELECTION' then
      TfrxTableObject(Instance).JoinSelection(Caller.Params[0], Caller.Params[1], Caller.Params[2], Caller.Params[3])
    else if MethodName = 'SPLITCELL' then
      TfrxTableObject(Instance).SplitCell(TfrxTableCell(frInteger(Caller.Params[0])))
    else if MethodName = 'CELLS' then
      Result := frInteger(TfrxTableObject(Instance).Cells[Caller.Params[0], Caller.Params[1]])
    else if MethodName = 'COLUMNS.GET' then
      Result := frInteger(TfrxTableObject(Instance).Columns[Caller.Params[0]])
    else if MethodName = 'ROWS.GET' then
      Result := frInteger(TfrxTableObject(Instance).Rows[Caller.Params[0]])
  end
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
var
  cData: TfrxCellData;
begin
  Result := 0;

  if ClassType = TfrxTableRowColumnBase then
  begin
    if PropName = 'INDEX' then
      Result := TfrxTableRowColumnBase(Instance).Index
  end
  else if ClassType = TfrxTableRow then
  begin
    if PropName = 'CELLCOUNT' then
      Result := TfrxTableRow(Instance).CellCount
  end
  else if ClassType = TfrxTableObject then
  begin
    if PropName = 'TABLEHEIGHT' then
      Result := TfrxTableObject(Instance).TableHeight
    else if PropName = 'TABLEWIDTH' then
      Result := TfrxTableObject(Instance).TableWidth
   else if PropName = 'TABLEBUILDER' then
      Result := frInteger(TfrxTableObject(Instance).TableBuilder);
  end
  else if ClassType = TfrxCustomTableBuilder then
  begin
    if PropName = 'PAGINATIONORDER' then
      Result := TfrxCustomTableBuilder(Instance).PaginationOrder
    else if PropName = 'PRINTINGROWINDEX' then
      Result := TfrxCustomTableBuilder(Instance).PrintingRowIndex
    else if PropName = 'PRINTINGCOLUMNINDEX' then
      Result := TfrxCustomTableBuilder(Instance).PrintingColumnIndex
  end
  else if ClassType = TfrxCellData then
  begin
    cData := TfrxCellData(Instance);
    if PropName = 'COLSPAN' then
      Result := cData.ColSpan
    else if PropName = 'COLSPAN' then
      Result := cData.ColSpan
    else if PropName = 'ROWSPAN' then
      Result := cData.RowSpan
    else if PropName = 'VALUE' then
      Result := cData.Value
    else if PropName = 'TEXT' then
      Result := cData.Text
  end
end;

procedure TFunctions.SetProp(Instance: TObject; ClassType: TClass;
  const PropName: String; Value: Variant);
var
  cData: TfrxCellData;
begin
  if ClassType = TfrxTableObject then
  begin
    if PropName = 'TABLEHEIGHT' then
      TfrxTableObject(Instance).TableHeight := Value
    else if PropName = 'TABLEWIDTH' then
      TfrxTableObject(Instance).TableWidth := Value;
  end
  else if ClassType = TfrxCustomTableBuilder then
  begin
    if PropName = 'PAGINATIONORDER' then
      TfrxCustomTableBuilder(Instance).PaginationOrder := Value
  end
  else if ClassType = TfrxCellData then
  begin
    cData := TfrxCellData(Instance);
    if PropName = 'COLSPAN' then
      cData.ColSpan := Value
    else if PropName = 'COLSPAN' then
      cData.ColSpan := Value
    else if PropName = 'ROWSPAN' then
      cData.RowSpan := Value
    else if PropName = 'VALUE' then
      cData.Value := Value
    else if PropName = 'TEXT' then
      cData.Text := Value
  end
end;

initialization
  fsRTTIModules.Add(TFunctions);

finalization
  fsRTTIModules.Remove(TFunctions);

end.
