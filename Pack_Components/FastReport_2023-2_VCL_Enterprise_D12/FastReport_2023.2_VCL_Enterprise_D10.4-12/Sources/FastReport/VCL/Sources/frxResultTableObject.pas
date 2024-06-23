{******************************************}
{                                          }
{             FastReport VCL               }
{          Result Table builder            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

/// <summary>
///   This unit contains classes of Result Table report object.
/// </summary>
unit frxResultTableObject;

interface

{$I frx.inc}

uses
  SysUtils, Types, Classes, Graphics, Variants, Controls,
  frCore, frxClass, frxTableObject;

type
  TfrxHackTableCell = class(TfrxTableCell);
  TfrxHackCustomTableRow = class(TfrxCustomTableRow);
  TfrxResultTableObject = class;
  TfrxHackComponent = class(TfrxComponent);

  TfrxCellDataList = class(TfrxObjectsNotifyList)
  private
    FSourceTable: TfrxResultTableObject;
  protected
    function Get(Index: TfrListInteger): Pointer; override;
    procedure Put(Index: TfrListInteger; const Value: Pointer); override;
    function GetCount: TfrListInteger; override;
  end;

  TfrxResultTableObject = class(TfrxTableObject)
  private
    FFixedColumns: TList;
    FFooterColumns: TList;
    FFixedRows: TList;
    FNullCell: TfrxTableCell;
    FAggregatesList: TList;
    FReport: TfrxReport;
  protected
    function GetAggregateResult(Report: TfrxReport; AggCell: TfrxTableCell; ResultTableAddr: TPoint): Boolean;
    function GetReport: TfrxReport; override;
    function GetSplitRow(ARow: TfrxCustomTableRow; AHeight: Extended; var IsLastPart: Boolean): TfrxCustomTableRow; override;
    function GetCurColumnsHash: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetCellData(x, y: Integer): TfrxCellData;
    class function CreateTableRow: TfrxCustomTableRow; override;
  end;

  TfrxRowPart = class
  private
    FRowForSplit: TfrxCustomTableRow;
    FPartIndex: Integer;
    FRemainHeight: Extended;
  public
    constructor Create(ARow: TfrxCustomTableRow);
    destructor Destroy; override;
  end;

  TfrxTableRow = class(TfrxCustomTableRow)
  private
    FRowForSplit: TfrxCustomTableRow;
    FSplitParts: TStringList;
    FSplitRows: TList;
    procedure ClrearCellData;
    function GetColumnsHash: String;
    procedure CreatePartsList;
    function GetExistPart(const Hash: String): TfrxRowPart;
    function AddSplitPart(const Hash: String; RowPart: TfrxCustomTableRow): TfrxRowPart;
    procedure FreeSplitRows;
  protected
    function GetCellData(Index: Integer): TfrxCellData;
    function GetCell(Index: Integer): TfrxTableCell; override;
    class function GetObjectListClass: TfrxObjectsNotifyListClass; override;
    procedure SetParent(AParent: TfrxComponent); override;
  public
    destructor Destroy; override;
    function CreateTableCell(Index: Integer; bSetUniqueName: Boolean = False): TObject; override;
    function GetSplitRow(AHeight: Extended; Wrapped: Boolean; var IsLastPart: Boolean): TfrxCustomTableRow;
  end;

  TfrxResultTableBuilder = class(TfrxCustomTableBuilder)
  protected
    class function GetResultTableClass: TfrxTableObjectClass; override;
    procedure CopyCells(OriginalColumnIndex, OriginalRowIndex,
      ResultColumnIndex, ResultRowIndex: Integer); override;
    procedure AddFixedColumn(FixedColumn: TfrxTableColumn; DestTable: TfrxTableObject); override;
    procedure AddFixedRow(FixedRow: TfrxCustomTableRow; DestTable: TfrxTableObject); override;
    procedure AddFooterColumn(ColumnFooter: TfrxTableColumn; DestTable: TfrxTableObject); override;
    procedure ClearResultObjects(ATable: TfrxTableObject); override;
    function GetCellData(X, Y: Integer): TfrxCellData; override;
  public
    constructor Create(SourceTable: TfrxTableObject); override;
    destructor Destroy; override;
  end;


implementation

uses Math, frxGraphicUtils, frxRes, frxAggregate;

{ TfrxResultTableRow }

function TfrxTableRow.AddSplitPart(const Hash: String; RowPart: TfrxCustomTableRow): TfrxRowPart;
begin
  Result := TfrxRowPart.Create(RowPart);
  FSplitParts.AddObject(Hash, Result);
end;

procedure TfrxTableRow.ClrearCellData;
var
  i: Integer;
begin
  Objects.OnNotifyList := nil;
  for i := 0 to FInternalObjects.Count - 1 do
    TObject(FInternalObjects[i]).Free;
  FInternalObjects.Clear;
  Objects.OnNotifyList := ObjectListNotify;
end;

procedure TfrxTableRow.CreatePartsList;
begin
  if FSplitRows = nil then
    FSplitRows := TList.Create;
  if Assigned(FSplitParts) then Exit;
  FSplitParts := TStringList.Create;
  FSplitParts.Sorted := True;
end;

function TfrxTableRow.CreateTableCell(Index: Integer;
  bSetUniqueName: Boolean): TObject;
var
  CellData: TfrxCellData absolute Result;
begin
  CellData := TfrxCellData.Create;
  FInternalObjects.Add(CellData);
  CellData.Index := Index;
end;

destructor TfrxTableRow.Destroy;
begin
  FreeSplitRows;
  FreeAndNil(FSplitRows);
  FreeAndNil(FRowForSplit);
  FreeAndNil(FSplitParts);
  ClrearCellData;
  inherited;
end;

procedure TfrxTableRow.FreeSplitRows;
var
  i: Integer;
begin
  if FSplitRows = nil then Exit;
  for i := 0 to FSplitRows.Count - 1 do
    TObject(FSplitRows[i]).Free;
  FSplitRows.Clear;  
  for i := 0 to FSplitParts.Count - 1 do
  begin
    if TfrxRowPart(FSplitParts.Objects[i]).FRowForSplit = FRowForSplit then
      TfrxRowPart(FSplitParts.Objects[i]).FRowForSplit := nil;
    FSplitParts.Objects[i].Free;
  end;
  FSplitParts.Clear;
end;

function TfrxTableRow.GetCell(Index: Integer): TfrxTableCell;
var
  LCell: TfrxTableCell;
begin
  if (Index < 0) or (Index > CellCount - 1) then
    Result := nil
  else
  begin
    LCell := TfrxCellData(FInternalObjects[Index]).Cell;
    if LCell = nil then
      LCell := TfrxResultTableObject(ParentTable).FNullCell;
    Result := TfrxHackTableCell(LCell).SetCellData(FInternalObjects[Index]);
    TfrxCellData(FInternalObjects[Index]).Parent := Self;
    TfrxHackTableCell(Result).FIndex := Index;
  end;
end;

function TfrxTableRow.GetCellData(Index: Integer): TfrxCellData;
begin
  Result := nil;
  if (Index >= 0) and (FInternalObjects.Count > Index) then
    Result := FInternalObjects[Index];
end;

function TfrxTableRow.GetColumnsHash: String;
var
  i: Integer;
  t: TfrxTableObject;
begin
  Result := '';
  t := ParentTable;
  if not(Assigned(t) and t.IsDynamicTable and Assigned(t.TableBuilder.OutTable)) then Exit;

  for i := 0 to t.TableBuilder.OutTable.Objects.Count - 1 do
  begin
    if TObject(t.TableBuilder.OutTable.Objects[i]) is TfrxTableColumn then
      Result := Result + IntToStr(TfrxTableColumn(t.TableBuilder.OutTable.Objects[i]).Index)
    else break;
  end;
end;

function TfrxTableRow.GetExistPart(const Hash: String): TfrxRowPart;
var
  i: Integer;
begin
  i := -1;
  Result := nil;
  if Assigned(FSplitParts) then
    i := FSplitParts.IndexOf(Hash);
  if i >= 0 then
    Result := TfrxRowPart(FSplitParts.Objects[i]);
end;

class function TfrxTableRow.GetObjectListClass: TfrxObjectsNotifyListClass;
begin
  Result := TfrxCellDataList;
end;

function TfrxTableRow.GetSplitRow(AHeight: Extended;
  Wrapped: Boolean; var IsLastPart: Boolean): TfrxCustomTableRow;
var
  CurHash: String;
  Part: TfrxRowPart;
  i: Integer;
  t: TfrxTableObject;
  LRowForSplit, AddedRow: TfrxCustomTableRow;
begin
  Result := nil;
  IsLastPart := False;
  if not AllowSplit then Exit;
  CreatePartsList;
  CurHash := GetColumnsHash;
  AddedRow := nil;
//  FreeAndNil(FRowForSplit);
  Part := GetExistPart(CurHash);
  if (Part = nil) then
  begin
    if Wrapped then
    begin
      LRowForSplit := TfrxTableObject.CreateTableRow;
      LRowForSplit.AssignAllWithOriginals(Self);
    end
    else if FRowForSplit = nil then
    begin
      LRowForSplit := TfrxTableObject.CreateTableRow;
      LRowForSplit.Assign(Self);
      TfrxHackComponent(LRowForSplit).AssignOriginals(Self);
      for i := 0 to CellCount - 1 do
      begin
        LRowForSplit.CreateTableCell(i);
        LRowForSplit.Cells[i].AssignAllWithOriginals(Cells[i]);
        LRowForSplit.Cells[i].Width := Cells[i].Width;
        LRowForSplit.Cells[i].Height := Cells[i].Height;
      end;
      FRowForSplit := LRowForSplit;
      TfrxHackComponent(LRowForSplit).FParent := Parent;
//      Part.FRowPart := LRowForSplit.GetSplitPart(AHeight);
      AddedRow := LRowForSplit.GetSplitPart(AHeight, IsLastPart);
      if Assigned(AddedRow)  then
        FSplitRows.Add(AddedRow)
      else
      begin
        FreeAndNil(FRowForSplit);
        Exit;
      end;
    end
    else
    begin
      LRowForSplit := FRowForSplit;
      AddedRow := TfrxCustomTableRow(FSplitRows[0]);
    end;

    TfrxHackComponent(LRowForSplit).FParent := Parent;
    Part := AddSplitPart(CurHash, LRowForSplit);
    Part.FRemainHeight := Height;
    t := ParentTable;
    for i := 0 to t.TableBuilder.OutTable.Objects.Count - 1 do
    begin
      if TObject(t.TableBuilder.OutTable.Objects[i]) is TfrxTableColumn then
      begin
        LRowForSplit.Cells[i].Width := TfrxTableColumn(t.TableBuilder.OutTable.Objects[i]).Width;
        LRowForSplit.Cells[i].Height := LRowForSplit.Height;
      end
      else break;
    end;
  end
  else
  begin
    Inc(Part.FPartIndex);
    LRowForSplit := Part.FRowForSplit;
    LRowForSplit.Height := Part.FRemainHeight;

    if FSplitRows.Count > 0 then
    begin
      if FSplitRows.Count <= Part.FPartIndex then
      begin
        AddedRow := LRowForSplit.GetSplitPart(AHeight, IsLastPart);
        FSplitRows.Add(AddedRow);
      end
      else
        AddedRow := TfrxCustomTableRow(FSplitRows[Part.FPartIndex]);
    end;
  end;

  if AddedRow = nil then
  begin
    Result := LRowForSplit.GetSplitPart(AHeight, IsLastPart);

    if Assigned(Part) and (Result = nil) and (Part.FPartIndex > 0) and not (Wrapped and not IsLastPart) then
    begin
      Result := TfrxTableObject.CreateTableRow;
      Result.AssignAllWithOriginals(LRowForSplit);

      if Part.FRemainHeight > AHeight then
        Result.Height := AHeight
      else
        Result.Height := Part.FRemainHeight;
    end;

  end
  else
  begin
    Result := TfrxTableObject.CreateTableRow;
    Result.Assign(AddedRow);
    TfrxHackComponent(Result).AssignOriginals(AddedRow);
    t := ParentTable;
    for i := 0 to t.TableBuilder.OutTable.Objects.Count - 1 do
    begin
      if TObject(t.TableBuilder.OutTable.Objects[i]) is TfrxTableColumn then
      begin
        Result.CreateTableCell(Result.CellCount);
        Result.Cells[Result.CellCount - 1].AssignAllWithOriginals(AddedRow.Cells[TfrxTableColumn(t.TableBuilder.OutTable.Objects[i]).Index]);
      end
      else break;
    end;
  end;

  if Assigned(Result) and Assigned(Part) then
    Part.FRemainHeight := Part.FRemainHeight - Result.Height;

  IsLastPart := not LRowForSplit.IsSplitPart and (Part.FRemainHeight <= 1E-4);
  FIsSplit := (Result <> nil) or (Part.FRemainHeight > 0);
end;

procedure TfrxTableRow.SetParent(AParent: TfrxComponent);
begin
  inherited;
  TfrxCellDataList(Objects).FSourceTable := TfrxResultTableObject(AParent);
end;

{ TfrxResultTableObject }

constructor TfrxResultTableObject.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNullCell := TfrxTableCell.Create(nil);
  FNullCell.Frame.Typ := [];
  TfrxHackTableCell(FNullCell).FParent := Self;
  FFixedColumns := TList.Create;
  FFixedRows := TList.Create;
  FFooterColumns := TList.Create;
  FAggregatesList := TList.Create;
end;

class function TfrxResultTableObject.CreateTableRow: TfrxCustomTableRow;
begin
  Result := TfrxTableRow.Create(nil);
end;

destructor TfrxResultTableObject.Destroy;
begin
  FreeAndNil(FNullCell);
  FreeAndNil(FFixedColumns);
  FreeAndNil(FFixedRows);
  FreeAndNil(FFooterColumns);
  FreeAndNil(FAggregatesList);
  inherited;
end;

function TfrxResultTableObject.GetAggregateResult(Report: TfrxReport; AggCell: TfrxTableCell;
  ResultTableAddr: TPoint): Boolean;
var
  x, y: Integer;
  cell: TfrxCellData;
  UpToIndex, FromIndex: Integer;
begin
  Result := False;
  if FAggregatesList.IndexOf(AggCell) < 0 then Exit;
  Report.Engine.Aggregates.Reset(FOriginalComponent);
  Result := True;
  FromIndex := ResultTableAddr.Y - 1;
  UpToIndex := 0;
  if Assigned(TfrxHackTableCell(AggCell).FCellData) and (AggCell.ParentRow.BandType = tbLocalAggregateFooter) then
  begin
    UpToIndex := FSerializeRows.RangeStart;
    if FSerializeRows.RangeEnd < ResultTableAddr.Y then
      FromIndex := FSerializeRows.RangeEnd - 1;
  end;

  for y := FromIndex downto UpToIndex do
  begin
    cell := GetCellData(ResultTableAddr.X, Y);
    if AggCell = cell.Cell then break;
    Result := Report.Engine.Aggregates.AddCalculatedValue(cell.OriginalCell, cell.Value) or Result;
  end;

  FromIndex := ResultTableAddr.X - 1;
  UpToIndex := 0;
  if Assigned(TfrxHackTableCell(AggCell).FCellData) and (Columns[TfrxHackTableCell(AggCell).FCellData.Index].BandType = tbLocalAggregateFooter) then
  begin
    UpToIndex := FSerializeColumns.RangeStart;
    if ResultTableAddr.X >= TfrxHackTableCell(AggCell).FCellData.Index then
      FromIndex := ResultTableAddr.X - 1;
  end;

  for X := FromIndex downto UpToIndex do
  begin
    cell := GetCellData(X, ResultTableAddr.Y);
    if AggCell = cell.Cell then break;
    Result := Report.Engine.Aggregates.AddCalculatedValue(cell.OriginalCell, cell.Value) or Result;
  end;
end;

function TfrxResultTableObject.GetCellData(x, y: Integer): TfrxCellData;
var
  R: TfrxCustomTableRow;
begin
  Result := nil;
  R := Rows[Y];
  if R <> nil then
    Result := TfrxTableRow(R).GetCellData(X);
end;

function TfrxResultTableObject.GetCurColumnsHash: String;
var
  i: Integer;
begin
  Result := '';
  if TableBuilder.OutTable = nil then Exit;
  for i := 0 to TableBuilder.OutTable.Objects.Count - 1 do
  begin
    if TObject(TableBuilder.OutTable.Objects[i]) is TfrxTableColumn then
      Result := Result + IntToStr(TfrxTableColumn(TableBuilder.OutTable.Objects[i]).Index)
    else break;
  end;
end;

function TfrxResultTableObject.GetReport: TfrxReport;
begin
  if Assigned(FReport) then
    Result := FReport
  else Result := inherited GetReport;
end;

function TfrxResultTableObject.GetSplitRow(ARow: TfrxCustomTableRow;
  AHeight: Extended; var IsLastPart: Boolean): TfrxCustomTableRow;
var
  LRow: TfrxTableRow;
  LIsPartSplit: Boolean;
begin
  Result := nil;
  if not (ARow is TfrxTableRow) then Exit;
  LIsPartSplit := (TableBuilder.PaginationOrder = tpDownThenAcrossWrapped);
  LRow := TfrxTableRow(ARow);
  Result := LRow.GetSplitRow(AHeight, LIsPartSplit, IsLastPart);
  if Assigned(Result) then
    TfrxHackCustomTableRow(Result).FIndex := ARow.Index;
end;

{ TfrxCellDataList }

function TfrxCellDataList.Get(Index: TfrListInteger): Pointer;
var
  cellData: TfrxCellData;
  cell: TfrxTableCell absolute Result;
  bUpdate: Boolean;
  Idx: Integer;
begin
  Idx := Index;
  bUpdate := False;
  if Assigned(FSourceTable) {and (FSourceTable.FSerializeColumns.X >= 0)} then
  begin
    if (FSourceTable.FFooterColumns.Count > 0) and (Index >= FSourceTable.FSerializeColumns.RangeEnd - FSourceTable.FSerializeColumns.RangeStart + FSourceTable.FFixedColumns.Count) then
      Index := TfrxTableColumn(FSourceTable.FFooterColumns[Index - (FSourceTable.FSerializeColumns.RangeEnd - FSourceTable.FSerializeColumns.RangeStart + FSourceTable.FFixedColumns.Count)]).Index
    else if FSourceTable.FFixedColumns.Count > Index then
      Index := TfrxTableColumn(FSourceTable.FFixedColumns[Index]).Index
    else
      Index := Index + FSourceTable.FSerializeColumns.RangeStart - FSourceTable.FFixedColumns.Count;
  end;
  cellData := TfrxCellData(inherited Get(Index));
  if cellData.Cell = nil then
    cellData.Cell := FSourceTable.FNullCell;
  if cellData.NeedUpdate then
    bUpdate := FSourceTable.GetAggregateResult(cellData.Report, cellData.Cell, Point(Idx + FSourceTable.FSerializeColumns.RangeStart - FSourceTable.FFixedColumns.Count, cellData.Cell.ParentRow.Index));
  Result := TfrxHackTableCell(cellData.Cell).SetCellData(cellData, bUpdate);
end;

function TfrxCellDataList.GetCount: TfrListInteger;
begin
  Result := inherited GetCount;
  if Result = 0 then Exit;
  if FSourceTable = nil then Exit;
  if (FSourceTable.FSerializeColumns.RangeEnd > 0) and (FSourceTable.FSerializeColumns.RangeEnd <= Result) then
    Result := FSourceTable.FSerializeColumns.RangeEnd;
  if (FSourceTable.FSerializeColumns.RangeStart >= 0) and (FSourceTable.FSerializeColumns.RangeStart <= Result) then
    Result := Result - FSourceTable.FSerializeColumns.RangeStart;
  if (FSourceTable.FSerializeColumns.RangeStart > 0) then
    Result := Result + FSourceTable.FFixedColumns.Count;
  Result := Result + FSourceTable.FFooterColumns.Count;
end;

procedure TfrxCellDataList.Put(Index: TfrListInteger; const Value: Pointer);
begin
  if Assigned(FSourceTable) and (FSourceTable.FSerializeColumns.RangeStart > 0) then
    Index := Index + FSourceTable.FSerializeColumns.RangeStart + FSourceTable.FFixedColumns.Count;
  TfrxCellData(inherited Get(Index)).Cell := Value;;
end;

{ TfrxTableBuilder }

procedure TfrxResultTableBuilder.AddFixedColumn(FixedColumn: TfrxTableColumn; DestTable: TfrxTableObject);
begin
  inherited;
  TfrxResultTableObject(FResultTable).FFixedColumns.Add(FixedColumn);
end;

procedure TfrxResultTableBuilder.AddFixedRow(FixedRow: TfrxCustomTableRow; DestTable: TfrxTableObject);
begin
  inherited;
  TfrxResultTableObject(FResultTable).FFixedRows.Add(FixedRow);
end;

procedure TfrxResultTableBuilder.AddFooterColumn(ColumnFooter: TfrxTableColumn;
  DestTable: TfrxTableObject);
begin
  inherited;
  TfrxResultTableObject(FResultTable).FFooterColumns.Add(ColumnFooter);
end;

procedure TfrxResultTableBuilder.ClearResultObjects(ATable: TfrxTableObject);
begin
  inherited;
  TfrxResultTableObject(FResultTable).FFixedColumns.Clear;
  TfrxResultTableObject(FResultTable).FFixedRows.Clear;
  TfrxResultTableObject(FResultTable).FFooterColumns.Clear;
end;

procedure TfrxResultTableBuilder.CopyCells(OriginalColumnIndex, OriginalRowIndex,
  ResultColumnIndex, ResultRowIndex: Integer);
var
  cell: TfrxTableCell;
  cellTo: TfrxCellData;
  LOldObject: String;
begin
  cell := FSourceTable.Cells[OriginalColumnIndex, OriginalRowIndex];
  cellTo := TfrxResultTableObject(FResultTable).GetCellData(ResultColumnIndex, ResultRowIndex);
  cell.BeforePrint;
  cell.ResetCellData;
  cell.Value := null;

  cellTo.NeedUpdate := TfrxResultTableObject(FResultTable).GetAggregateResult(FReport, cell, Point(ResultColumnIndex, ResultRowIndex)) and ((FResultTable.Rows[ResultRowIndex].BandType in [tbAggregateFooter, tbLocalAggregateFooter]) or (FResultTable.Columns[ResultColumnIndex].BandType  in [tbAggregateFooter, tbLocalAggregateFooter]));

  FReport.Engine.CurTableRow := ResultRowIndex;
  FReport.Engine.CurTableColumn := ResultColumnIndex;
  LOldObject := FReport.CurObject;
  FReport.CurObject := cell.Name;
  try
    //FReport.DoNotifyEvent(cell, cell.OnBeforePrint);
    cell.GetData;
    //FReport.DoNotifyEvent(cell, cell.OnAfterData);
  finally
    FReport.CurObject := LOldObject;
  end;

  cellTo.ColSpan := cell.ColSpan;
  cellTo.RowSpan := cell.RowSpan;
  cellTo.Text := cell.Text;
  cellTo.Index := ResultColumnIndex;
  cellTo.Report := FReport;
  cellTo.Value := cell.Value;
  if cell.Objects.Count > 0 then
  begin
    cellTo.Cell := TfrxTableCell.Create(nil);
    cellTo.OriginalCell := cell;
    cellTo.Cell.AssignAllWithOriginals(cell);
    { need for anchors }
    cellTo.Cell.Width := cell.Width;
    cellTo.Cell.Height := cell.Height;
  end
  else
    cellTo.Cell := cell;
  cell.AfterPrint;
  //FReport.DoNotifyEvent(cell, cell.OnAfterPrint);
end;


constructor TfrxResultTableBuilder.Create(SourceTable: TfrxTableObject);
var
  x, y: Integer;
  cell: TfrxTableCell;
begin
  inherited Create(SourceTable);
  TfrxResultTableObject(FResultTable).FReport := FReport;
  for y := 0 to SourceTable.RowCount - 1 do
    for x := 0 to SourceTable.ColumnCount - 1 do
    begin
      cell := SourceTable.Cells[x, y];
      if Assigned(cell) then
        if FReport.Engine.Aggregates.AddAggregatedItem(cell, nil) then
          TfrxResultTableObject(FResultTable).FAggregatesList.Add(cell);
    end;
end;

destructor TfrxResultTableBuilder.Destroy;
begin
  inherited;
end;

function TfrxResultTableBuilder.GetCellData(X, Y: Integer): TfrxCellData;
begin
  Result := TfrxResultTableObject(FResultTable).GetCellData(X, Y);
end;

class function TfrxResultTableBuilder.GetResultTableClass: TfrxTableObjectClass;
begin
  Result := TfrxResultTableObject;
end;

{ TfrxRowPart }

constructor TfrxRowPart.Create(ARow: TfrxCustomTableRow);
begin
  FPartIndex := 0;
  FRowForSplit := ARow;
  FRemainHeight := ARow.Height;
end;

destructor TfrxRowPart.Destroy;
begin
  FreeAndNil(FRowForSplit);
end;

initialization
  frxTableBuilder := TfrxResultTableBuilder;

end.
