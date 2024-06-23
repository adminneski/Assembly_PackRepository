{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{             DBGridEh import/export routines           }
{                                                       }
{   Copyright (c) 2000-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhXlsMemFileExporters;

interface

uses
  SysUtils, Classes, Graphics, Dialogs, Controls, Variants,
  Contnrs, Db, Clipbrd, StdCtrls,

{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}

{$IFDEF FPC}
  EhLibLCL, LCLType, LCLIntf, DBGridsEh,
  {$IFDEF FPC_CROSSP}
  {$ELSE}
     Windows,
  {$ENDIF}
{$ELSE}
  EhLibVCL, Messages, SqlTimSt, DBGridEh, Windows,
{$ENDIF}
  GridsEh, DBAxisGridsEh, XlsMemFilesEh, DBGridEhGrouping, MemTableEh;

type

{ TDBGridEhXlsMemFileExportOptions }

  TDBGridEhXlsMemFileExportOptions = class(TPersistent)
  private
    FIsExportFreezeZones: Boolean;
    FExportColumns: TColumnsEhList;
    FIsExportFontFormat: Boolean;
    FIsExportFillColor: Boolean;
    FIsExportDataGrouping: Boolean;
    FIsCreateAutoFilter: Boolean;
    FIsExportTitle: Boolean;
    FIsExportCellFormat: Boolean;
    FIsFooterSumsAsFormula: Boolean;
    FIsExportDisplayFormat: Boolean;
    FIsExportSelecting: Boolean;
    FIsExportFooter: Boolean;
    FGridFooterText: String;
    FGridHeaderFont: TFont;
    FGridHeaderFontStored: Boolean;
    FGridFooterFont: TFont;
    FGridHeaderText: String;
    FGridFooterFontStored: Boolean;
    FSheetName: String;
    procedure SetExportColumns(const Value: TColumnsEhList);
    procedure SetGridFooterFont(const Value: TFont);
    procedure SetGridHeaderFont(const Value: TFont);
    procedure FontChanged(Sender: TObject);

  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property IsExportSelecting: Boolean read FIsExportSelecting write FIsExportSelecting default True;
    property ExportColumns: TColumnsEhList read FExportColumns write SetExportColumns;
    property IsExportTitle: Boolean read FIsExportTitle write FIsExportTitle default True;
    property IsExportFooter: Boolean read FIsExportFooter write FIsExportFooter default True;
    property IsExportFontFormat: Boolean read FIsExportFontFormat write FIsExportFontFormat default True;
    property IsExportFillColor: Boolean read FIsExportFillColor write FIsExportFillColor default True;
    property IsExportCellFormat: Boolean read FIsExportCellFormat write FIsExportCellFormat default True;
    property IsExportDisplayFormat: Boolean read FIsExportDisplayFormat write FIsExportDisplayFormat default True;
    property IsCreateAutoFilter: Boolean read FIsCreateAutoFilter write FIsCreateAutoFilter default True;
    property IsExportFreezeZones: Boolean read FIsExportFreezeZones write FIsExportFreezeZones default True;
    property IsFooterSumsAsFormula: Boolean read FIsFooterSumsAsFormula write FIsFooterSumsAsFormula default True;
    property IsExportDataGrouping: Boolean read FIsExportDataGrouping write FIsExportDataGrouping default True;

    property GridHeaderText: String read FGridHeaderText write FGridHeaderText;
    property GridHeaderFont: TFont read FGridHeaderFont write SetGridHeaderFont;
    property GridHeaderFontStored: Boolean read FGridHeaderFontStored write FGridHeaderFontStored;

    property GridFooterText: String read FGridFooterText write FGridFooterText;
    property GridFooterFont: TFont read FGridFooterFont write SetGridFooterFont;
    property GridFooterFontStored: Boolean read FGridFooterFontStored write FGridFooterFontStored;

    property SheetName: String read FSheetName write FSheetName;
  end;

{ TDBGridEhXlsMemFileExportCellParams }

  TDBGridEhXlsMemFileExportCellParams = class(TPersistent)
  private
    FFillColor: TColor;
    FFontIsBold: Boolean;
    FFontSize: Integer;
    FNumberFormat: String;
    FHorzAlign: TXlsFileCellHorzAlign;
    FFontIsUnderline: Boolean;
    FWrapText: Boolean;
    FFontName: String;
    FValue: Variant;
    FFontIsItalic: Boolean;
    FFontColor: TColor;
    FVertAlign: TXlsFileCellVertAlign;
    FFormula: String;
  public
    procedure Clear;

    property Value: Variant read FValue write FValue;
    property Formula: String read FFormula write FFormula;
    property HorzAlign: TXlsFileCellHorzAlign read FHorzAlign write FHorzAlign;
    property VertAlign: TXlsFileCellVertAlign read FVertAlign write FVertAlign;
    property WrapText: Boolean read FWrapText write FWrapText;
    property NumberFormat: String read FNumberFormat write FNumberFormat;
    property FillColor: TColor read FFillColor write FFillColor;
    property FontName: String read FFontName write FFontName;
    property FontColor: TColor read FFontColor write FFontColor;
    property FontSize: Integer read FFontSize write FFontSize;
    property FontIsBold: Boolean read FFontIsBold write FFontIsBold;
    property FontIsItalic: Boolean read FFontIsItalic write FFontIsItalic;
    property FontIsUnderline: Boolean read FFontIsUnderline write FFontIsUnderline;
  end;

{ TDBGridEhXlsMemFileExportDataCellParams }

  TDBGridEhXlsMemFileExportInDataCellParamsEh = class(TPersistent)
  private
    FColumn: TColumnEh;
    FGridCellParams: TColCellParamsEh;
    FXlsColIndex: Integer;
  public
    property XlsColIndex: Integer read FXlsColIndex;
    property Column: TColumnEh read FColumn;
    property GridCellParams: TColCellParamsEh read FGridCellParams;
  end;

{ TDBGridEhXlsMemFileExportFooterCellParams }

  TDBGridEhXlsMemFileExportFooterCellParams = class(TPersistent)
  private
    FColumn: TColumnEh;
    FXlsColIndex: Integer;
    FFooterRowInex: Integer;
    FFooter: TPersistent;
  public
    property XlsColIndex: Integer read FXlsColIndex;
    property Column: TColumnEh read FColumn;
    property FooterRowInex: Integer read FFooterRowInex;
    property Footer: TPersistent read FFooter;
  end;

{ TDBGridEhXlsMemFileExportTitleCellParams }

  TDBGridEhXlsMemFileExportTitleCellParams = class(TPersistent)
  private
    FColumn: TColumnEh;
    FXlsColIndex: Integer;
    FTitleRowIndex: Integer;
    FMultiTitleNode: TDBGridMultiTitleExportNodeEh;
  public
    property XlsColIndex: Integer read FXlsColIndex;
    property Column: TColumnEh read FColumn;
    property TitleRowIndex: Integer read FTitleRowIndex;
    property MultiTitleNode: TDBGridMultiTitleExportNodeEh read FMultiTitleNode;
  end;

{ TDBGridEhToXlsMemFileExporter }

  TDBGridEhToXlsMemFileExporter = class
  private
    FFromRow: Integer;
    FFromCol: Integer;
    FFinishRow: Integer;
    FFinishCol: Integer;
    FXlsFile: TXlsMemFileEh;
    FWorksheet: TXlsWorksheetEh;
    FGrid: TCustomDBGridEh;
    FColCellParamsEh: TColCellParamsEh;

    FExpCols: TColumnsEhList;

    FExportOptions: TDBGridEhXlsMemFileExportOptions;

    FGroupRowParams: TGroupRowParamsEh;
    FGroupFooterParams: TGroupFooterParamsEh;
    FInDataCellParams: TDBGridEhXlsMemFileExportInDataCellParamsEh;
    FInFooterCellParams: TDBGridEhXlsMemFileExportFooterCellParams;
    FInTitleCellParams: TDBGridEhXlsMemFileExportTitleCellParams;
    FOutCellParams: TDBGridEhXlsMemFileExportCellParams;
    FFooterObjVals: TFooterObjectValuesEh;

    function GetWorksheet: TXlsWorksheetEh;
    function GetXlsFile: TXlsMemFileEh;
    procedure SetWorksheet(const Value: TXlsWorksheetEh);
    procedure SetXlsFile(const Value: TXlsMemFileEh);
    procedure SetExportOptions(const Value: TDBGridEhXlsMemFileExportOptions);

  protected
    FooterValues: TFooterValues;
    NextExportRowIndex: Integer;
    GridHeaderTextRowCount: Integer;
    TitleRowCount: Integer;
    DataRowCount: Integer;
    FooterRowCount: Integer;
    ViewRowIndex: Integer;
    FlatGroupingList: TObjectList;
    InstantReadCurDataNode: TGroupDataTreeNodeEh;

    function GetDefaultWorksheet: TXlsWorksheetEh; virtual;
    function GetDefaultFromCol: Integer; virtual;
    function GetDefaultFromRow: Integer; virtual;
    function GetGridCellValue(Column: TColumnEh; AColCellParams: TColCellParamsEh): Variant; virtual;
    function GetFooterValue(FooterRowIndex, ColIndex: Integer): Variant; virtual;
    function VCLDisplayFormatToXlsNumFormat(const VCLDisplayFormat: String): String; virtual;
    function DataEof: Boolean; virtual;
    function IsUseGroupingList: Boolean; virtual;


    procedure InstantReadRecordEnter(DataRowIndex: Integer);
    procedure InstantReadRecordLeave;
    procedure InitDataEnumeration; virtual;
    procedure FillDataGroupRowParams(AGroupNode: TGroupDataTreeNodeEh; AGroupRowParams: TGroupRowParamsEh); virtual;
    procedure FillDataGroupFooterCellParams(AGroupNode: TGroupDataTreeNodeEh; AColumn: TColumnEh; AFooterColumnItem: TGridDataGroupFooterColumnItemEh; AGroupFooterParams: TGroupFooterParamsEh); virtual;
    procedure FillDataCellParams(InCellParams: TDBGridEhXlsMemFileExportInDataCellParamsEh; OutCellParams: TDBGridEhXlsMemFileExportCellParams); virtual;
    procedure FillFooterCellParams(InCellParams: TDBGridEhXlsMemFileExportFooterCellParams; OutCellParams: TDBGridEhXlsMemFileExportCellParams); virtual;
    procedure FillTitleCellParams(InCellParams: TDBGridEhXlsMemFileExportTitleCellParams; OutCellParams: TDBGridEhXlsMemFileExportCellParams); virtual;
    procedure ReleaseDataEnumeration; virtual;
    procedure SetFreezeTitleRows; virtual;
    procedure WriteGroupCaptionRow; virtual;
    procedure WriteGroupFooterRow; virtual;
    procedure WriteGroupFooterCell(FooterRowNode: TGroupDataTreeNodeEh; ColIndex: Integer; Column: TColumnEh); virtual;
    procedure WriteColumns; virtual;
    procedure WriteSheetAttributes; virtual;
    procedure WriteGridHeader; virtual;
    procedure WriteGridFooter; virtual;
    procedure WritePrefix; virtual;
    procedure WriteSuffix; virtual;
    procedure WriteRecord; virtual;
    procedure WriteTitle; virtual;
    procedure WriteTitleCell(ColIndex: Integer; Column: TColumnEh; MultiTitleNode: TDBGridMultiTitleExportNodeEh); virtual;
    procedure WriteDataCellFormat(XlsCellsRange: IXlsFileCellsRangeEh; InCellParams: TDBGridEhXlsMemFileExportInDataCellParamsEh; CellFormatParams: TDBGridEhXlsMemFileExportCellParams); virtual;
    procedure WriteDataCell(ColIndex: Integer; Column: TColumnEh; AColCellParamsEh: TColCellParamsEh); virtual;
    procedure WriteTitleCellFormat(XlsCellsRange: IXlsFileCellsRangeEh; InCellParams: TDBGridEhXlsMemFileExportTitleCellParams; CellFormatParams: TDBGridEhXlsMemFileExportCellParams); virtual;
    procedure WriteFooter; virtual;
    procedure WriteFooterInGroupCaptionRow; virtual;
    procedure WriteFooterRow(FooterRowIndex: Integer); virtual;
    procedure WriteFooterCell(FooterCellParams: TDBGridEhXlsMemFileExportFooterCellParams); virtual;
    procedure WriteFooterCellFormat(XlsCellsRange: IXlsFileCellsRangeEh; InCellParams: TDBGridEhXlsMemFileExportFooterCellParams; CellFormatParams: TDBGridEhXlsMemFileExportCellParams); virtual;
    procedure WriteDataLines; virtual;
    procedure WriteFooterLines; virtual;
    procedure WriteAutoFilter; virtual;
    procedure WriteRowGrouping; virtual;

    procedure DataFirst; virtual;
    procedure GotoNextRow; virtual;
    procedure DoExport; virtual;
    procedure CalcFooterValues; virtual;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure ExportGrid; virtual;

    property Grid: TCustomDBGridEh read FGrid write FGrid;
    property ExpCols: TColumnsEhList read FExpCols;

    property ExportOptions: TDBGridEhXlsMemFileExportOptions read FExportOptions write SetExportOptions;
    property XlsFile: TXlsMemFileEh read GetXlsFile write SetXlsFile;
    property Worksheet: TXlsWorksheetEh read GetWorksheet write SetWorksheet;
    property FromCol: Integer read FFromCol write FFromCol;
    property FromRow: Integer read FFromRow write FFromRow;

    property FinishCol: Integer read FFinishCol;
    property FinishRow: Integer read FFinishRow;
  end;

  TDBGridEhToXlsMemFileExporterClass = class of TDBGridEhToXlsMemFileExporter;

procedure ExportDBGridEhToXlsMemFile(DBGridEh: TCustomDBGridEh; XlsFile: TXlsMemFileEh); overload;

procedure ExportDBGridEhToXlsMemFile(DBGridEh: TCustomDBGridEh; XlsFile: TXlsMemFileEh;
  ExportOptions: TDBGridEhXlsMemFileExportOptions); overload;

procedure ExportDBGridEhToXlsMemFile(DBGridEh: TCustomDBGridEh; XlsFile: TXlsMemFileEh;
  ExportOptions: TDBGridEhXlsMemFileExportOptions; ExporterClass: TDBGridEhToXlsMemFileExporterClass); overload;

implementation

uses DBGridEhImpExp, ToolCtrlsEh;

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh);

procedure ExportDBGridEhToXlsMemFile(DBGridEh: TCustomDBGridEh; XlsFile: TXlsMemFileEh);
begin
  ExportDBGridEhToXlsMemFile(DBGridEh, XlsFile, nil);
end;

procedure ExportDBGridEhToXlsMemFile(DBGridEh: TCustomDBGridEh;
  XlsFile: TXlsMemFileEh; ExportOptions: TDBGridEhXlsMemFileExportOptions);
begin
  ExportDBGridEhToXlsMemFile(DBGridEh, XlsFile, ExportOptions, TDBGridEhToXlsMemFileExporterClass(nil));
end;

procedure ExportDBGridEhToXlsMemFile(DBGridEh: TCustomDBGridEh; XlsFile: TXlsMemFileEh;
  ExportOptions: TDBGridEhXlsMemFileExportOptions; ExporterClass: TDBGridEhToXlsMemFileExporterClass);
var
  Exporter: TDBGridEhToXlsMemFileExporter;
begin
  if ExporterClass <> nil
    then Exporter := ExporterClass.Create
    else Exporter := TDBGridEhToXlsMemFileExporter.Create;

  Exporter.XlsFile := XlsFile;
  Exporter.Grid := DBGridEh;
  if ExportOptions <> nil then
    Exporter.ExportOptions := ExportOptions;

  Exporter.ExportGrid;

  Exporter.Free;
end;

{ TDBGridEhXlsMemFileExportOptions }

constructor TDBGridEhXlsMemFileExportOptions.Create;
begin
  FExportColumns := TColumnsEhList.Create;

  FIsExportSelecting := False;
  FIsExportTitle := True;
  FIsExportFooter := True;
  FIsExportFontFormat := True;
  FIsExportFillColor := True;
  FIsExportCellFormat := True;
  FIsExportDisplayFormat := True;
  FIsCreateAutoFilter := True;
  FIsExportFreezeZones := True;
  FIsFooterSumsAsFormula := True;
  FIsExportDataGrouping := True;

  FGridHeaderFont := TFont.Create;
  FGridHeaderFont.OnChange := FontChanged;

  FGridFooterFont  := TFont.Create;
  FGridFooterFont.OnChange := FontChanged;
end;

destructor TDBGridEhXlsMemFileExportOptions.Destroy;
begin
  FreeAndNil(FExportColumns);
  FreeAndNil(FGridHeaderFont);
  FreeAndNil(FGridFooterFont);

  inherited Destroy;
end;

procedure TDBGridEhXlsMemFileExportOptions.FontChanged(Sender: TObject);
begin
  if Sender = FGridHeaderFont then
    FGridHeaderFontStored := True
  else if Sender = FGridFooterFont then
    FGridFooterFontStored := True;
end;

procedure TDBGridEhXlsMemFileExportOptions.Assign(Source: TPersistent);
var
  SrcOp: TDBGridEhXlsMemFileExportOptions;
begin
  if not (Source is TDBGridEhXlsMemFileExportOptions) then Exit;

  SrcOp := TDBGridEhXlsMemFileExportOptions(Source);

  IsExportSelecting := SrcOp.IsExportSelecting;
  ExportColumns := SrcOp.ExportColumns;
  IsExportTitle := SrcOp.IsExportTitle;
  IsExportFooter := SrcOp.IsExportFooter;
  IsExportFontFormat := SrcOp.IsExportFontFormat;
  IsExportFillColor := SrcOp.IsExportFillColor;
  IsExportCellFormat := SrcOp.IsExportCellFormat;
  IsExportDisplayFormat := SrcOp.IsExportDisplayFormat;
  IsCreateAutoFilter := SrcOp.IsCreateAutoFilter;
  IsExportFreezeZones := SrcOp.IsExportFreezeZones;
  IsFooterSumsAsFormula := SrcOp.IsFooterSumsAsFormula;
  IsExportDataGrouping := SrcOp.IsExportDataGrouping;

  GridHeaderText := SrcOp.GridHeaderText;
  GridHeaderFont := SrcOp.GridHeaderFont;
  GridHeaderFontStored := SrcOp.GridHeaderFontStored;

  GridFooterText := SrcOp.GridFooterText;
  GridFooterFont := SrcOp.GridFooterFont;
  GridFooterFontStored := SrcOp.GridFooterFontStored;

  SheetName := SrcOp.SheetName;
end;

procedure TDBGridEhXlsMemFileExportOptions.SetExportColumns(const Value: TColumnsEhList);
var
  i: Integer;
begin
  FExportColumns.Clear;
  for i := 0 to Value.Count-1 do
    FExportColumns.Add(Value[i]);
end;

procedure TDBGridEhXlsMemFileExportOptions.SetGridFooterFont(const Value: TFont);
begin
  FGridFooterFont.Assign(Value);
end;

procedure TDBGridEhXlsMemFileExportOptions.SetGridHeaderFont(const Value: TFont);
begin
  FGridHeaderFont.Assign(Value);
end;

{ TDBGridEhToXlsMemFileExporter }

constructor TDBGridEhToXlsMemFileExporter.Create;
begin
  FFromCol := -1;
  FFromRow := -1;
  FFinishCol := -1;
  FFinishRow := -1;
  FExpCols := TColumnsEhList.Create;
  FColCellParamsEh := TColCellParamsEh.Create;
  FGroupRowParams := TGroupRowParamsEh.Create;
  FGroupFooterParams := TGroupFooterParamsEh.Create;
  FInDataCellParams := TDBGridEhXlsMemFileExportInDataCellParamsEh.Create;
  FInFooterCellParams := TDBGridEhXlsMemFileExportFooterCellParams.Create;
  FInTitleCellParams := TDBGridEhXlsMemFileExportTitleCellParams.Create;
  FOutCellParams := TDBGridEhXlsMemFileExportCellParams.Create;
  FFooterObjVals := TFooterObjectValuesEh.Create;

  FExportOptions := TDBGridEhXlsMemFileExportOptions.Create;
end;

destructor TDBGridEhToXlsMemFileExporter.Destroy;
begin
  FreeAndNil(FExportOptions);
  FreeAndNil(FExpCols);
  FreeAndNil(FColCellParamsEh);
  FreeAndNil(FGroupRowParams);
  FreeAndNil(FGroupFooterParams);
  FreeAndNil(FInDataCellParams);
  FreeAndNil(FInFooterCellParams);
  FreeAndNil(FInTitleCellParams);
  FreeAndNil(FOutCellParams);
  FreeAndNil(FFooterObjVals);
  inherited Destroy;
end;

procedure TDBGridEhToXlsMemFileExporter.ExportGrid;
begin
  if Worksheet = nil then
    Worksheet := GetDefaultWorksheet;
  if (FromCol = -1) then
    FromCol := GetDefaultFromCol;
  if (FromRow = -1) then
    FromRow := GetDefaultFromRow;
  NextExportRowIndex := FromRow;

  DoExport;
end;

procedure TDBGridEhToXlsMemFileExporter.DoExport;
var
  i: Integer;
  ASelectionType: TDBGridEhSelectionType;
  ds: TDataSet;
  RestoreBookmarkIsNeed: Boolean;
begin
  if (ExportOptions.ExportColumns.Count > 0)
    then FExpCols.Assign(ExportOptions.ExportColumns)
    else FExpCols.Clear;

  if ExportOptions.IsExportSelecting
    then ASelectionType := Grid.Selection.SelectionType
    else ASelectionType := gstAll;

  ds := Grid.DataSource.Dataset;

  InitDataEnumeration;
  ds.DisableControls;
  Grid.SaveBookmark;

  RestoreBookmarkIsNeed := True;
  try
    case ASelectionType of

      gstNon:
        begin
          RestoreBookmarkIsNeed := False;
          if not ( (Grid.DataSource <> nil) and (Grid.DataSource.DataSet <> nil) and
                not Grid.DataSource.DataSet.IsEmpty )
          then
            Exit;
          if ExpCols.Count = 0 then
            FExpCols.Add(Grid.Columns[Grid.SelectedIndex]);
          WritePrefix;
          WriteRecord;
        end;

      gstRecordBookmarks:
        begin
          if ExpCols.Count = 0 then
            ExpCols.Assign(Grid.VisibleColumns);
          SetLength(FooterValues, ExpCols.Count * Grid.FullFooterRowCount);
          WritePrefix;
          if ExportOptions.IsExportTitle then
            WriteTitle;
          DataRowCount := 0;
          for i := 0 to Grid.Selection.Rows.Count - 1 do
          begin
            ds.Bookmark := Grid.Selection.Rows[I];
            CalcFooterValues;
            WriteRecord;
          end;
          DataRowCount := Grid.Selection.Rows.Count;
          WriteFooter;
        end;

      gstRectangle:
        begin
          if ExpCols.Count = 0 then
          begin
            for i := Grid.Selection.Rect.LeftCol to Grid.Selection.Rect.RightCol do
              if Grid.Columns[i].Visible then
                ExpCols.Add(Grid.Columns[i]);
          end;
          SetLength(FooterValues, ExpCols.Count * Grid.FullFooterRowCount);
          WritePrefix;
          if ExportOptions.IsExportTitle then
            WriteTitle;
          ds.Bookmark := Grid.Selection.Rect.TopRow;
          DataRowCount := 0;
          while True do
          begin
            WriteRecord;
            DataRowCount := DataRowCount + 1;
            CalcFooterValues;
            if DataSetCompareBookmarks(ds, Grid.Selection.Rect.BottomRow, ds.Bookmark) = 0 then
                Break;
            ds.Next;
            if ds.Eof then Break;
          end;
          WriteFooter;
        end;

      gstColumns:
        begin
          if (ExpCols.Count = 0) then
            ExpCols.Assign(Grid.Selection.Columns);
          SetLength(FooterValues, ExpCols.Count * Grid.FullFooterRowCount);
          WritePrefix;
          if dgTitles in Grid.Options then WriteTitle;
          ds.First;
          DataRowCount := 0;
          while ds.Eof = False do
          begin
            WriteRecord;
            DataRowCount := DataRowCount + 1;
            CalcFooterValues;
            ds.Next;
          end;
          WriteFooter;
        end;

      gstAll:
        begin
          if ExpCols.Count = 0 then
            ExpCols.Assign(Grid.VisibleColumns);
          SetLength(FooterValues, ExpCols.Count * Grid.FullFooterRowCount);
          WritePrefix;
          if ExportOptions.IsExportTitle then
            WriteTitle;
          DataFirst;
          DataRowCount := 0;
          while DataEof = False do
          begin
            WriteRowGrouping;
            WriteRecord;
            DataRowCount := DataRowCount + 1;
            CalcFooterValues;
            GotoNextRow;
          end;
          WriteFooter;
        end;
    end;
  finally
    try
      if RestoreBookmarkIsNeed then
        Grid.RestoreBookmark;
       ReleaseDataEnumeration;
    finally
      ds.EnableControls;
    end;
  end;

  WriteSuffix;
  FFinishRow := FromRow + GridHeaderTextRowCount + TitleRowCount + DataRowCount + FooterRowCount;
end;

procedure TDBGridEhToXlsMemFileExporter.InitDataEnumeration;
var
  Node: TGroupDataTreeNodeEh;
  GroupingTree: TGridGroupDataTreeEh;
begin
  if IsUseGroupingList then
  begin
    FlatGroupingList := TObjectList.Create(False);
    GroupingTree := Grid.DataGrouping.GroupDataTree;
    Node := TGroupDataTreeNodeEh(GroupingTree.GetFirst);
    while Node <> nil do
    begin
      if (Node.NodeType = dntDataGroupFooterEh) and
         (Node.Level = 1)
      then
        //Skip root footers
      else if (Node.NodeType = dntDataGroupFooterEh) and
         Node.Parent.DataGroupLevel.FooterInGroupRow
         and (Node = Node.Parent.FooterItems[0]) then
      else if (Node.NodeType = dntDataGroupFooterEh) and
          not Node.DataGroupFooter.Visible then
      else
        FlatGroupingList.Add(Node);
      Node := TGroupDataTreeNodeEh(GroupingTree.GetNext(Node));
    end;
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.ReleaseDataEnumeration;
begin
  FreeAndNil(FlatGroupingList);
end;

function TDBGridEhToXlsMemFileExporter.DataEof: Boolean;
begin
  if IsUseGroupingList then
    Result := ViewRowIndex >= FlatGroupingList.Count
  else
    Result := Grid.DataLink.Eof;
end;

procedure TDBGridEhToXlsMemFileExporter.DataFirst;
begin
  if IsUseGroupingList then
  begin
    ViewRowIndex := 0;
    if ViewRowIndex < FlatGroupingList.Count then
      InstantReadRecordEnter(ViewRowIndex);
  end else
    Grid.DataLink.DataSet.First;
end;

procedure TDBGridEhToXlsMemFileExporter.GotoNextRow;
begin
  if IsUseGroupingList and not DataEof then
  begin
    InstantReadRecordLeave;
    ViewRowIndex := ViewRowIndex + 1;
    if ViewRowIndex < FlatGroupingList.Count then
      InstantReadRecordEnter(ViewRowIndex);
  end else
    Grid.DataLink.MoveBy(1);
end;

procedure TDBGridEhToXlsMemFileExporter.InstantReadRecordEnter(DataRowIndex: Integer);
var
  MemTable: TCustomMemTableEh;
begin
  if ViewRowIndex < FlatGroupingList.Count
    then InstantReadCurDataNode := TGroupDataTreeNodeEh(FlatGroupingList[ViewRowIndex])
    else InstantReadCurDataNode := nil;

  if (InstantReadCurDataNode <> nil) and
     (InstantReadCurDataNode.NodeType <> dntDataGroupFooterEh)
  then
  begin
    MemTable := Grid.DataLink.DataSet as TCustomMemTableEh;
    MemTable.InstantReadEnter(InstantReadCurDataNode.DataSetRecordViewNo);
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.InstantReadRecordLeave;
var
  MemTable: TCustomMemTableEh;
begin
  if InstantReadCurDataNode.NodeType <> dntDataGroupFooterEh then
  begin
    MemTable := Grid.DataLink.DataSet as TCustomMemTableEh;
    MemTable.InstantReadLeave;
  end;
  InstantReadCurDataNode := nil;
end;

function TDBGridEhToXlsMemFileExporter.IsUseGroupingList: Boolean;
begin
  Result := ExportOptions.IsExportDataGrouping and Grid.DataGrouping.IsGroupingWorks;
end;

function TDBGridEhToXlsMemFileExporter.GetDefaultWorksheet: TXlsWorksheetEh;
begin
  if XlsFile.Workbook.WorksheetCount = 0 then
    Result := XlsFile.Workbook.AddWorksheet('Worksheet')
  else
    Result := XlsFile.Workbook.Worksheets[0];
end;

function TDBGridEhToXlsMemFileExporter.GetDefaultFromCol: Integer;
begin
  Result := 0;
end;

function TDBGridEhToXlsMemFileExporter.GetDefaultFromRow: Integer;
begin
  Result := 0;
end;

function TDBGridEhToXlsMemFileExporter.GetWorksheet: TXlsWorksheetEh;
begin
  Result := FWorksheet;
end;

procedure TDBGridEhToXlsMemFileExporter.SetWorksheet(const Value: TXlsWorksheetEh);
begin
  FWorksheet := Value;
end;

function TDBGridEhToXlsMemFileExporter.GetXlsFile: TXlsMemFileEh;
begin
  Result := FXlsFile;
end;

procedure TDBGridEhToXlsMemFileExporter.SetXlsFile(const Value: TXlsMemFileEh);
begin
  FXlsFile := Value;
end;

function TDBGridEhToXlsMemFileExporter.VCLDisplayFormatToXlsNumFormat(
  const VCLDisplayFormat: String): String;
begin
  Result := XlsMemFilesEh.VCLDisplayFormatToXlsNumFormat(VCLDisplayFormat);
end;

procedure TDBGridEhToXlsMemFileExporter.WritePrefix;
begin
  WriteGridHeader;
  WriteColumns;
  WriteSheetAttributes;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteGridHeader;
var
  cr: IXlsFileCellsRangeEh;
begin
  if (ExportOptions.GridHeaderText <> '') then
  begin
    Worksheet.Cells[0, NextExportRowIndex].Value := ExportOptions.GridHeaderText;
    if (ExportOptions.GridHeaderFontStored) then
    begin
      cr := Worksheet.GetCellsRange(0, NextExportRowIndex, 0, NextExportRowIndex);
      cr.Font.Name := ExportOptions.GridHeaderFont.Name;
      cr.Font.Color := ExportOptions.GridHeaderFont.Color;
      cr.Font.Size := ExportOptions.GridHeaderFont.Size;
      cr.Font.IsBold := fsBold in ExportOptions.GridHeaderFont.Style;
      cr.Font.IsItalic := fsItalic in ExportOptions.GridHeaderFont.Style;
      cr.Font.IsUnderline := fsUnderline in ExportOptions.GridHeaderFont.Style;
      cr.ApplyChages;
    end;

    NextExportRowIndex := NextExportRowIndex + 1;
    GridHeaderTextRowCount := 1;
  end
  else
  begin
    GridHeaderTextRowCount := 0;
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteGridFooter;
var
  cr: IXlsFileCellsRangeEh;
begin
  if (ExportOptions.GridFooterText <> '') then
  begin
    Worksheet.Cells[0, NextExportRowIndex].Value := ExportOptions.GridFooterText;
    if (ExportOptions.GridFooterFontStored) then
    begin
      cr := Worksheet.GetCellsRange(0, NextExportRowIndex, 0, NextExportRowIndex);
      cr.Font.Name := ExportOptions.GridFooterFont.Name;
      cr.Font.Color := ExportOptions.GridFooterFont.Color;
      cr.Font.Size := ExportOptions.GridFooterFont.Size;
      cr.Font.IsBold := fsBold in ExportOptions.GridFooterFont.Style;
      cr.Font.IsItalic := fsItalic in ExportOptions.GridFooterFont.Style;
      cr.Font.IsUnderline := fsUnderline in ExportOptions.GridFooterFont.Style;
      cr.ApplyChages;
    end;

    NextExportRowIndex := NextExportRowIndex + 1;
  end
end;

procedure TDBGridEhToXlsMemFileExporter.WriteSheetAttributes;
begin
  if IsUseGroupingList then
    Worksheet.OutlineRowsSummaryBelow := False;

  if (ExportOptions.SheetName <> '') then
    Worksheet.Name := ExportOptions.SheetName;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteColumns;
var
  i: Integer;
begin
  for i := 0 to ExpCols.Count - 1 do
  begin
    Worksheet.Columns[i].Width := Worksheet.Columns.ScreenToXlsWidth(ExpCols[i].Width);
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteTitle;
var
  i: Integer;
  TitleMarix: TDBGridMultiTitleExportNodeMatrixEh;
  ci, ri: Integer;
  ti: TDBGridMultiTitleExportNodeEh;
  cr: IXlsFileCellsRangeEh;
  FixNextExportRowIndex: Integer;
begin
  if (Grid.TitleParams.MultiTitle) then
  begin
    CalcMultiTitleMatrix(Grid, TitleMarix);
    FixNextExportRowIndex := NextExportRowIndex;

    for ci := 0 to Length(TitleMarix)-1 do
    begin
      for ri := 0 to Length(TitleMarix[ci])-1 do
      begin
        NextExportRowIndex := FixNextExportRowIndex + ri;
        ti := TitleMarix[ci, ri];
        if (ti <> nil) then
        begin
          WriteTitleCell(ci, ti.Column, ti);

          if (ti.MergeColCount > 0) or (ti.MergeRowCount > 0) then
          begin
            Worksheet.MergeCell(ci, NextExportRowIndex, ti.MergeColCount + 1, ti.MergeRowCount + 1);
          end;
        end;
      end;
    end;

    TitleRowCount := Length(TitleMarix[0]);
    NextExportRowIndex := FixNextExportRowIndex + TitleRowCount;
    FreeMultiTitleMatrix(TitleMarix);
  end
  else
  begin
    for i := 0 to ExpCols.Count - 1 do
    begin
      WriteTitleCell(i, ExpCols[i], nil);
    end;
    TitleRowCount := 1;
    NextExportRowIndex := NextExportRowIndex + 1;
  end;

  cr := Worksheet.GetCellsRange(0, NextExportRowIndex - TitleRowCount, ExpCols.Count - 1, NextExportRowIndex - 1);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;

  cr.Border.InsideVertical.Style := clsThinEh;
  cr.Border.InsideHorizontal.Style := clsThinEh;

  cr.ApplyChages;
end;

procedure TDBGridEhToXlsMemFileExporter.FillTitleCellParams(
  InCellParams: TDBGridEhXlsMemFileExportTitleCellParams;
  OutCellParams: TDBGridEhXlsMemFileExportCellParams);
const
  HorzAlignments: array[TAlignment] of TXlsFileCellHorzAlign =
    (chaLeftEh, chaRightEh, chaCenterEh);
  VertAlignments: array[TTextLayout] of TXlsFileCellVertAlign =
    (cvaTopEh, cvaCenterEh, cvaBottomEh);
begin
  if (InCellParams.Column <> nil) then
  begin
    if (InCellParams.MultiTitleNode <> nil) then
      OutCellParams.Value := InCellParams.MultiTitleNode.Text
    else
      OutCellParams.Value := InCellParams.Column.Title.Caption;

    if ExportOptions.IsExportCellFormat then
    begin
      OutCellParams.HorzAlign := HorzAlignments[InCellParams.Column.Title.Alignment];

      if (Grid.TitleParams.MultiTitle) then
      begin
        OutCellParams.VertAlign := VertAlignments[tlCenter];
        OutCellParams.WrapText := True;
      end;
    end;
    if ExportOptions.IsExportFillColor then
    begin
      if (InCellParams.Column.Title.Color <> clBtnFace) then
        OutCellParams.FillColor := InCellParams.Column.Title.Color;
    end;

    if ExportOptions.IsExportFontFormat then
    begin
      OutCellParams.FontName := InCellParams.Column.Title.Font.Name;
      OutCellParams.FontColor := InCellParams.Column.Title.Font.Color;
      OutCellParams.FontSize := InCellParams.Column.Title.Font.Size;
      OutCellParams.FontIsBold := fsBold in InCellParams.Column.Title.Font.Style;
      OutCellParams.FontIsItalic := fsItalic in InCellParams.Column.Title.Font.Style;
      OutCellParams.FontIsUnderline := fsUnderline in InCellParams.Column.Title.Font.Style;
    end;
  end else
  begin
    OutCellParams.Value := InCellParams.MultiTitleNode.Text;

    if ExportOptions.IsExportCellFormat then
    begin
      OutCellParams.HorzAlign := HorzAlignments[taCenter];
      OutCellParams.VertAlign := VertAlignments[tlCenter];
      OutCellParams.WrapText := True;
    end;

    if ExportOptions.IsExportFillColor then
    begin
      if (Grid.ColumnDefValues.Title.Color <> clBtnFace) then
        OutCellParams.FillColor := Grid.ColumnDefValues.Title.Color;
    end;

    if ExportOptions.IsExportFontFormat then
    begin
      OutCellParams.FontName := Grid.TitleParams.Font.Name;
      OutCellParams.FontColor := Grid.TitleParams.Font.Color;
      OutCellParams.FontSize := Grid.TitleParams.Font.Size;
      OutCellParams.FontIsBold := fsBold in Grid.TitleParams.Font.Style;
      OutCellParams.FontIsItalic := fsItalic in Grid.TitleParams.Font.Style;
      OutCellParams.FontIsUnderline := fsUnderline in Grid.TitleParams.Font.Style;
    end;
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteTitleCellFormat(
  XlsCellsRange: IXlsFileCellsRangeEh;
  InCellParams: TDBGridEhXlsMemFileExportTitleCellParams;
  CellFormatParams: TDBGridEhXlsMemFileExportCellParams);
begin
  if (CellFormatParams.HorzAlign <> chaUnassignedEh) then
    XlsCellsRange.HorzAlign := CellFormatParams.HorzAlign;
  if (CellFormatParams.VertAlign <> cvaUnassignedEh) then
    XlsCellsRange.VertAlign := CellFormatParams.VertAlign;
  if (CellFormatParams.WrapText) then
    XlsCellsRange.WrapText := True;
  if (CellFormatParams.NumberFormat <> '') then
    XlsCellsRange.NumberFormat := CellFormatParams.NumberFormat;

  if (CellFormatParams.FillColor <> clNone) then
    XlsCellsRange.Fill.Color := CellFormatParams.FillColor;

  if (CellFormatParams.FontName <> '') then
    XlsCellsRange.Font.Name := CellFormatParams.FontName;
  if (CellFormatParams.FontColor <> clNone) then
    XlsCellsRange.Font.Color := CellFormatParams.FontColor;
  if (CellFormatParams.FontSize <> 0) then
    XlsCellsRange.Font.Size := CellFormatParams.FontSize;
  if (CellFormatParams.FontIsBold = True) then
    XlsCellsRange.Font.IsBold := True;
  if (CellFormatParams.FontIsItalic = True) then
    XlsCellsRange.Font.IsItalic := True;
  if (CellFormatParams.FontIsUnderline = True) then
    XlsCellsRange.Font.IsUnderline := True;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteTitleCell(ColIndex: Integer;
  Column: TColumnEh; MultiTitleNode: TDBGridMultiTitleExportNodeEh);
var
  cr: IXlsFileCellsRangeEh;
begin
  FInTitleCellParams.FColumn := Column;
  FInTitleCellParams.FXlsColIndex := ColIndex;
  FInTitleCellParams.FTitleRowIndex := 0;
  FInTitleCellParams.FMultiTitleNode := MultiTitleNode;
  FOutCellParams.Clear;

  FillTitleCellParams(FInTitleCellParams, FOutCellParams);

  Worksheet.Cells[ColIndex, NextExportRowIndex].Value := FOutCellParams.Value;

  cr := Worksheet.GetCellsRange(ColIndex, NextExportRowIndex, ColIndex, NextExportRowIndex);
  WriteTitleCellFormat(cr, FInTitleCellParams, FOutCellParams);
  cr.ApplyChages;
end;

procedure TDBGridEhToXlsMemFileExporter.FillDataGroupRowParams(AGroupNode: TGroupDataTreeNodeEh; AGroupRowParams: TGroupRowParamsEh);
begin
  TCustomDBGridEhCrack(Grid).FillDataGroupRowParams(AGroupNode, [], -1, -1, AGroupRowParams);
end;

procedure TDBGridEhToXlsMemFileExporter.WriteGroupCaptionRow;
var
  GroupLevel: TGridDataGroupLevelEh;
  RowHeight: Double;
  cr: IXlsFileCellsRangeEh;
begin
  FillDataGroupRowParams(InstantReadCurDataNode, FGroupRowParams);

  GroupLevel := InstantReadCurDataNode.DataGroupLevel;

  Worksheet.Cells[0, NextExportRowIndex].Value := FGroupRowParams.GroupRowText;

  if GroupLevel.FooterInGroupRow = False then
    Worksheet.MergeCell(0, NextExportRowIndex, ExpCols.Count-1, 0);

  if (GroupLevel.RowHeight <> 0) or (GroupLevel.RowLines <> 0) then
  begin
    RowHeight := GetFontTextHeight(nil, GroupLevel.Font) * GroupLevel.RowLines + GroupLevel.RowHeight;
    RowHeight := Worksheet.Rows.ScreenToXlsHeight(Round(RowHeight));
    Worksheet.Rows[NextExportRowIndex].Height := RowHeight;
  end;

  cr := Worksheet.GetCellsRange(0, NextExportRowIndex, 0, NextExportRowIndex);

  if ExportOptions.IsExportFillColor then
  begin
    if (FGroupRowParams.Color <> clWindow) then
      cr.Fill.Color := FGroupRowParams.Color;
  end;

  if ExportOptions.IsExportFontFormat then
  begin
    cr.Font.Name := FGroupRowParams.Font.Name;
    cr.Font.Color := FGroupRowParams.Font.Color;
    cr.Font.Size := FGroupRowParams.Font.Size;
    cr.Font.IsBold := fsBold in FGroupRowParams.Font.Style;
    cr.Font.IsItalic := fsItalic in FGroupRowParams.Font.Style;
    cr.Font.IsUnderline := fsUnderline in FGroupRowParams.Font.Style;
  end;

  cr.ApplyChages;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteFooterInGroupCaptionRow;
var
  DataGroupLevel: TGridDataGroupLevelEh;
  LevelFooter: TGridDataGroupFooterEh;
  i: Integer;
  Column: TColumnEh;
  FooterRowNode: TGroupDataTreeNodeEh;
begin
  DataGroupLevel := InstantReadCurDataNode.DataGroupLevel;
  if DataGroupLevel.FooterInGroupRow and
     (DataGroupLevel.VisibleFootersCount > 0) then
  begin
    LevelFooter := DataGroupLevel.VisibleFooter[0];

    for i := 0 to ExpCols.Count-1 do
    begin
      Column := ExpCols[i];
      if (LevelFooter.ColumnItems[Column.Index].ValueType <> gfvNonEh) then
      begin
        FooterRowNode := InstantReadCurDataNode.FooterItems[0];
        WriteGroupFooterCell(FooterRowNode, i, Column);
      end;
    end;

  end;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteGroupFooterRow;
var
  Column: TColumnEh;
  i: Integer;
begin
  for i := 0 to ExpCols.Count - 1 do
  begin
    Column := ExpCols[i];
    WriteGroupFooterCell(InstantReadCurDataNode, i, Column);
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.FillDataGroupFooterCellParams(
  AGroupNode: TGroupDataTreeNodeEh; AColumn: TColumnEh;
  AFooterColumnItem: TGridDataGroupFooterColumnItemEh;
  AGroupFooterParams: TGroupFooterParamsEh);
begin
  TCustomDBGridEhCrack(Grid).FillDataGroupFooterCellParams(AGroupNode, AColumn, AFooterColumnItem, [], -1, -1, AGroupFooterParams);
end;

procedure TDBGridEhToXlsMemFileExporter.WriteGroupFooterCell(
  FooterRowNode: TGroupDataTreeNodeEh; ColIndex: Integer; Column: TColumnEh);
var
  FooterColumnItem: TGridDataGroupFooterColumnItemEh;
  cr: IXlsFileCellsRangeEh;
begin
  FooterColumnItem := FooterRowNode.DataGroupFooter.ColumnItems[Column.Index];

  FillDataGroupFooterCellParams(FooterRowNode, Column, FooterColumnItem, FGroupFooterParams);

  Worksheet.Cells[ColIndex, NextExportRowIndex].Value := FGroupFooterParams.Value;

  cr := Worksheet.GetCellsRange(ColIndex, NextExportRowIndex, ColIndex, NextExportRowIndex);

  if ExportOptions.IsExportFillColor then
  begin
    if (FGroupFooterParams.Color <> clWindow) then
      cr.Fill.Color := FGroupFooterParams.Color;
  end;

  if ExportOptions.IsExportFontFormat then
  begin
    cr.Font.Name := FGroupFooterParams.Font.Name;
    cr.Font.Color := FGroupFooterParams.Font.Color;
    cr.Font.Size := FGroupFooterParams.Font.Size;
    cr.Font.IsBold := fsBold in FGroupFooterParams.Font.Style;
    cr.Font.IsItalic := fsItalic in FGroupFooterParams.Font.Style;
    cr.Font.IsUnderline := fsUnderline in FGroupFooterParams.Font.Style;
  end;

  if ExportOptions.IsExportDisplayFormat then
  begin
    if (FGroupFooterParams.DisplayFormat <> '') then
      cr.NumberFormat := VCLDisplayFormatToXlsNumFormat(FGroupFooterParams.DisplayFormat);
  end;

  cr.ApplyChages;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteRowGrouping;

  function NodeIsHidenInCollapse(Node: TGroupDataTreeNodeEh): Boolean;
  begin
    Result := False;
    Node := Node.Parent;
    while Node <> Grid.DataGrouping.GroupDataTree.Root do
    begin
      if Node.Expanded = False then
      begin
        Result := True;
        Exit;
      end;
      Node := Node.Parent;
    end;
  end;

begin
  if not IsUseGroupingList then Exit;

  Worksheet.Rows[NextExportRowIndex].OutlineLevel := InstantReadCurDataNode.Level - 1;

  if InstantReadCurDataNode.NodeType = dntDataGroupEh then
    Worksheet.Rows[NextExportRowIndex].OutlineNodeCollapsed := not InstantReadCurDataNode.Expanded;

  if NodeIsHidenInCollapse(InstantReadCurDataNode) then
    Worksheet.Rows[NextExportRowIndex].Visible := False;

end;

procedure TDBGridEhToXlsMemFileExporter.WriteRecord;
var
  i: Integer;
  AFont: TFont;
  NewBackground: TColor;
  p: TColCellParamsEh;
  Column: TColumnEh;
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Self.Grid);

  if IsUseGroupingList and
     (InstantReadCurDataNode <> nil) and
     (InstantReadCurDataNode.NodeType in [dntDataGroupEh, dntDataGroupFooterEh]) then
  begin
    if InstantReadCurDataNode.NodeType = dntDataGroupEh then
    begin
      WriteGroupCaptionRow;
      WriteFooterInGroupCaptionRow;
    end
    else
    begin
      WriteGroupFooterRow;
    end;
    NextExportRowIndex := NextExportRowIndex + 1;
  end else
  begin
    AFont := TFont.Create;
    try
      for i := 0 to ExpCols.Count - 1 do
      begin
        Column := ExpCols[i];
        AFont.Assign(Column.Font);

        p := FColCellParamsEh;
        p.Row := -1;
        p.Col := -1;
        p.State := [];
        p.Font := AFont;
        p.Background := Column.Color;
        p.Alignment := Column.Alignment;
        p.ImageIndex := Column.GetImageIndex;
        p.Text := Column.DisplayText;
        p.CheckboxState := Column.CheckboxState;

        if Column.Color = Grid.Color then
        begin
          if (Grid.OddRowColor <> Grid.EvenRowColor) and
             Grid.DataLink.Active and
             (Grid.DataLink.DataSet.IsSequenced or
              (Grid.SumList.Active and Grid.SumList.VirtualRecords)) then
          begin
            if Grid.SumList.RecNo mod 2 = 1
              then p.Background := Grid.OddRowColor
              else p.Background := Grid.EvenRowColor;
          end;
        end;

        NewBackground := p.Background;
        if Assigned(Grid.OnGetCellParams) then
          Grid.OnGetCellParams(Grid, ExpCols[i], p.Font, NewBackground, p.State);
        p.Background := NewBackground;

        ExpCols[i].GetColCellParams(False, FColCellParamsEh);

        WriteDataCell(i, ExpCols[i], FColCellParamsEh);
      end;
    finally
      AFont.Free;
    end;

    NextExportRowIndex := NextExportRowIndex + 1;
  end;
end;

{ TDBGridEhXlsMemFileExportCellParams }

procedure TDBGridEhXlsMemFileExportCellParams.Clear;
begin
  FValue := Null;
  FFormula := '';

  FHorzAlign := chaUnassignedEh;
  FVertAlign := cvaUnassignedEh;
  FWrapText := False;
  FNumberFormat := '';

  FFillColor := clNone;
  FFontName := '';
  FFontSize := 0;
  FFontColor := clNone;
  FFontIsBold := False;
  FFontIsUnderline := False;
  FFontIsItalic := False;
end;

procedure TDBGridEhToXlsMemFileExporter.FillDataCellParams(
  InCellParams: TDBGridEhXlsMemFileExportInDataCellParamsEh;
  OutCellParams: TDBGridEhXlsMemFileExportCellParams);
const
  HorzAlignments: array[TAlignment] of TXlsFileCellHorzAlign =
    (chaLeftEh, chaRightEh, chaCenterEh);
var
  DisplayFormat: String;
begin
  OutCellParams.Value := GetGridCellValue(InCellParams.Column, InCellParams.GridCellParams);

  if ExportOptions.IsExportCellFormat then
  begin
    OutCellParams.HorzAlign := HorzAlignments[InCellParams.GridCellParams.Alignment];
    if InCellParams.Column.WordWrap and
       (dghAutoFitRowHeight in Grid.OptionsEh)
    then
      OutCellParams.WrapText := InCellParams.Column.WordWrap;
  end;

  if ExportOptions.IsExportDisplayFormat then
  begin
    DisplayFormat := GetColumnDisplayFormat(InCellParams.Column);

    if (DisplayFormat <> '') then
      OutCellParams.NumberFormat := VCLDisplayFormatToXlsNumFormat(DisplayFormat);
  end;

  if ExportOptions.IsExportFillColor then
  begin
    if (InCellParams.GridCellParams.Background <> clWindow) then
      OutCellParams.FillColor := InCellParams.GridCellParams.Background;
  end;

  if ExportOptions.IsExportFontFormat then
  begin
    OutCellParams.FontName := InCellParams.GridCellParams.Font.Name;
    OutCellParams.FontColor := InCellParams.GridCellParams.Font.Color;
    OutCellParams.FontSize := InCellParams.GridCellParams.Font.Size;
    OutCellParams.FontIsBold := fsBold in InCellParams.GridCellParams.Font.Style;
    OutCellParams.FontIsItalic := fsItalic in InCellParams.GridCellParams.Font.Style;
    OutCellParams.FontIsUnderline := fsUnderline in InCellParams.GridCellParams.Font.Style;
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteDataCellFormat(XlsCellsRange: IXlsFileCellsRangeEh;
  InCellParams: TDBGridEhXlsMemFileExportInDataCellParamsEh;
  CellFormatParams: TDBGridEhXlsMemFileExportCellParams);
begin
  if (CellFormatParams.HorzAlign <> chaUnassignedEh) then
    XlsCellsRange.HorzAlign := CellFormatParams.HorzAlign;
  if (CellFormatParams.VertAlign <> cvaUnassignedEh) then
    XlsCellsRange.VertAlign := CellFormatParams.VertAlign;
  if (CellFormatParams.WrapText) then
    XlsCellsRange.WrapText := True;
  if (CellFormatParams.NumberFormat <> '') then
    XlsCellsRange.NumberFormat := CellFormatParams.NumberFormat;

  if (CellFormatParams.FillColor <> clNone) then
    XlsCellsRange.Fill.Color := CellFormatParams.FillColor;

  if (CellFormatParams.FontName <> '') then
    XlsCellsRange.Font.Name := CellFormatParams.FontName;
  if (CellFormatParams.FontColor <> clNone) then
    XlsCellsRange.Font.Color := CellFormatParams.FontColor;
  if (CellFormatParams.FontSize <> 0) then
    XlsCellsRange.Font.Size := CellFormatParams.FontSize;
  if (CellFormatParams.FontIsBold = True) then
    XlsCellsRange.Font.IsBold := True;
  if (CellFormatParams.FontIsItalic = True) then
    XlsCellsRange.Font.IsItalic := True;
  if (CellFormatParams.FontIsUnderline = True) then
    XlsCellsRange.Font.IsUnderline := True;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteDataCell(ColIndex: Integer; Column: TColumnEh; AColCellParamsEh: TColCellParamsEh);
var
  cr: IXlsFileCellsRangeEh;
begin
  FInDataCellParams.FXlsColIndex := ColIndex;
  FInDataCellParams.FColumn := Column;
  FInDataCellParams.FGridCellParams := AColCellParamsEh;
  FOutCellParams.Clear;

  FillDataCellParams(FInDataCellParams, FOutCellParams);

  Worksheet.Cells[ColIndex, NextExportRowIndex].Value := FOutCellParams.Value;

  cr := Worksheet.GetCellsRange(ColIndex, NextExportRowIndex, ColIndex, NextExportRowIndex);
  WriteDataCellFormat(cr, FInDataCellParams, FOutCellParams);
  cr.ApplyChages;
end;

function TDBGridEhToXlsMemFileExporter.GetGridCellValue(Column: TColumnEh; AColCellParams: TColCellParamsEh): Variant;
begin
  if Column.LookupParams.LookupActive then
  begin
    Result := FColCellParamsEh.Text;
  end
  else if Column.Field = nil then
  begin
    Result := Null
  end
  else if Column.GetBarType = ctKeyPickList then
  begin
    Result := FColCellParamsEh.Text;
  end
  else if Column.Field.IsNull then
  begin
    Result := Null;
  end
  else
  begin
    if Column.Field.DataType in
      [ftBlob, ftGraphic, ftParadoxOle, ftDBaseOle, ftOraBlob,
       ftBytes, ftTypedBinary, ftVarBytes]
    then
      Result := Null
    else
      Result := Column.Field.Value;
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteFooter;
var
  i: Integer;
begin
  if ExportOptions.IsExportFooter = False then
  begin
    FooterRowCount := 0;
    Exit;
  end;

  for i := 0 to Grid.FullFooterRowCount - 1 do
    WriteFooterRow(i);
  FooterRowCount := Grid.FullFooterRowCount;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteFooterRow(FooterRowIndex: Integer);
var
  i: Integer;
  Column: TColumnEh;
begin
  for i := 0 to ExpCols.Count - 1 do
  begin
    Column := ExpCols[i];
    FInFooterCellParams.FColumn := Column;
    FInFooterCellParams.FXlsColIndex := i;
    FInFooterCellParams.FFooterRowInex := FooterRowIndex;
    FInFooterCellParams.FFooter := Column.GetFooterObjectAtRow(FooterRowIndex);

    WriteFooterCell(FInFooterCellParams);
  end;

  NextExportRowIndex := NextExportRowIndex + 1;
end;

procedure TDBGridEhToXlsMemFileExporter.CalcFooterValues;

  procedure CalcFooterDataRowValues;
  var
    i, j: Integer;
    Field: TField;
    Footer: TColumnFooterEh;
  begin
    for i := 0 to Grid.FullFooterRowCount - 1 do
    begin
      for j := 0 to ExpCols.Count - 1 do
      begin
        Footer := ExpCols[j].ColumnUsedFooter(i);
        if Footer.FieldName <> '' then
          Field := Grid.DataSource.DataSet.FindField(Footer.FieldName)
        else
          Field := Grid.DataSource.DataSet.FindField(ExpCols[j].FieldName);
        if Field = nil then Continue;
        case Footer.ValueType of
          fvtSum:
            if (Field.IsNull = False) then
              FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + Field.AsFloat;
          fvtCount:
            FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + 1;
        end;
      end;
    end;
  end;

begin

  if IsUseGroupingList and
     (InstantReadCurDataNode <> nil) and
     (InstantReadCurDataNode.NodeType in [dntDataGroupEh, dntDataGroupFooterEh]) then
  begin
  end else
  begin
    CalcFooterDataRowValues;
  end;

end;

function TDBGridEhToXlsMemFileExporter.GetFooterValue(FooterRowIndex, ColIndex: Integer): Variant;
begin
  Result := FooterValues[FooterRowIndex * ExpCols.Count + ColIndex];
end;

procedure TDBGridEhToXlsMemFileExporter.FillFooterCellParams(
  InCellParams: TDBGridEhXlsMemFileExportFooterCellParams;
  OutCellParams: TDBGridEhXlsMemFileExportCellParams);
const
  HorzAlignments: array[TAlignment] of TXlsFileCellHorzAlign =
    (chaLeftEh, chaRightEh, chaCenterEh);
var
  Value: Variant;
  Formula: String;
  DisplayFormat: String;
  ci: Integer;
//  ColFooter: TColumnFooterEh;
//  GroupingColItem: TGridDataGroupFooterColumnItemEh;
begin
  InCellParams.Column.FillFooterObjectValues(InCellParams.FooterRowInex, FFooterObjVals);

  if ExportOptions.IsExportCellFormat then
  begin
    OutCellParams.HorzAlign := HorzAlignments[FFooterObjVals.Alignment];
  end;

  if ExportOptions.IsExportFontFormat then
  begin
    OutCellParams.FontName := FFooterObjVals.Font.Name;
    OutCellParams.FontColor := FFooterObjVals.Font.Color;
    OutCellParams.FontSize := FFooterObjVals.Font.Size;
    OutCellParams.FontIsBold := fsBold in FFooterObjVals.Font.Style;
    OutCellParams.FontIsItalic := fsItalic in FFooterObjVals.Font.Style;
    OutCellParams.FontIsUnderline := fsUnderline in FFooterObjVals.Font.Style;
  end;

  if ExportOptions.IsExportFillColor then
  begin
    if (FFooterObjVals.Color <> clWindow) then
      OutCellParams.FillColor := FFooterObjVals.Color;
  end;

  if FFooterObjVals.ValueType in [fvtSum, fvtCount] then
  begin
    Value := GetFooterValue(InCellParams.FooterRowInex, InCellParams.XlsColIndex);
    if ExportOptions.IsFooterSumsAsFormula then
    begin
      if (FFooterObjVals.ValueType = fvtSum) then
        Formula := 'SUM('
      else
        Formula := 'COUNT(';

      ci := InCellParams.XlsColIndex;
      Formula := Formula + Xls19ToAZPos(IntToStr((ci + 1))) + IntToStr(FromRow + TitleRowCount + 1);
      Formula := Formula + ':';
      Formula := Formula + Xls19ToAZPos(IntToStr((ci + 1))) + IntToStr(FromRow + TitleRowCount + DataRowCount);
      Formula := Formula + ')';
      DisplayFormat := FFooterObjVals.DisplayFormat;
    end else
    begin
      DisplayFormat := FFooterObjVals.DisplayFormat;
    end;

  end else
  begin
    //Value := Grid.GetFooterValue(InCellParams.Footer, InCellParams.Column);
    Value := FFooterObjVals.DislpayValue;
    Formula := '';
    DisplayFormat := '';
  end;

  OutCellParams.Value := Value;
  OutCellParams.Formula := Formula;

  if ExportOptions.IsExportDisplayFormat then
  begin
    if (DisplayFormat <> '') then
      OutCellParams.NumberFormat := VCLDisplayFormatToXlsNumFormat(DisplayFormat);
  end;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteFooterCellFormat(
  XlsCellsRange: IXlsFileCellsRangeEh;
  InCellParams: TDBGridEhXlsMemFileExportFooterCellParams;
  CellFormatParams: TDBGridEhXlsMemFileExportCellParams);
begin
  if FOutCellParams.HorzAlign <> chaUnassignedEh then
    XlsCellsRange.HorzAlign := FOutCellParams.HorzAlign;

  if FOutCellParams.NumberFormat <> '' then
    XlsCellsRange.NumberFormat := FOutCellParams.NumberFormat;

  if CellFormatParams.FillColor <> clNone then
    XlsCellsRange.Fill.Color := CellFormatParams.FillColor;

  if (CellFormatParams.FontName <> '') then
    XlsCellsRange.Font.Name := CellFormatParams.FontName;
  if (CellFormatParams.FontColor <> clNone) then
    XlsCellsRange.Font.Color := CellFormatParams.FontColor;
  if (CellFormatParams.FontSize <> 0) then
    XlsCellsRange.Font.Size := CellFormatParams.FontSize;
  if (CellFormatParams.FontIsBold = True) then
    XlsCellsRange.Font.IsBold := True;
  if (CellFormatParams.FontIsItalic = True) then
    XlsCellsRange.Font.IsItalic := True;
  if (CellFormatParams.FontIsUnderline = True) then
    XlsCellsRange.Font.IsUnderline := True;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteFooterCell(FooterCellParams: TDBGridEhXlsMemFileExportFooterCellParams);
var
  cr: IXlsFileCellsRangeEh;
begin
  FOutCellParams.Clear;

  FillFooterCellParams(FInFooterCellParams, FOutCellParams);

  Worksheet.Cells[FooterCellParams.XlsColIndex, NextExportRowIndex].Value := FOutCellParams.Value;
  Worksheet.Cells[FooterCellParams.XlsColIndex, NextExportRowIndex].Formula := FOutCellParams.Formula;

  cr := Worksheet.GetCellsRange(FooterCellParams.XlsColIndex, NextExportRowIndex,
                                FooterCellParams.XlsColIndex, NextExportRowIndex);
  WriteFooterCellFormat(cr, FooterCellParams, FOutCellParams);
  cr.ApplyChages;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteSuffix;
begin
  WriteDataLines;
  WriteFooterLines;
  WriteAutoFilter;
  SetFreezeTitleRows;
  WriteGridFooter;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteDataLines;
var
  cr: IXlsFileCellsRangeEh;
begin
  if (DataRowCount = 0) then Exit;

  cr := Worksheet.GetCellsRange(0, FromRow + GridHeaderTextRowCount + TitleRowCount,
                                ExpCols.Count - 1, FromRow + GridHeaderTextRowCount + TitleRowCount + DataRowCount - 1);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;

  cr.Border.InsideVertical.Style := clsThinEh;
  cr.Border.InsideHorizontal.Style := clsThinEh;

  cr.ApplyChages;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteFooterLines;
var
  cr: IXlsFileCellsRangeEh;
begin
  if (FooterRowCount = 0) then Exit;

  cr := Worksheet.GetCellsRange(0, FromRow + GridHeaderTextRowCount + TitleRowCount + DataRowCount,
                                ExpCols.Count - 1, FromRow + GridHeaderTextRowCount + TitleRowCount + DataRowCount + FooterRowCount - 1);
  cr.Border.Top.Style := clsMediumEh;
  cr.Border.Bottom.Style := clsMediumEh;
  cr.Border.Left.Style := clsMediumEh;
  cr.Border.Right.Style := clsMediumEh;

  cr.Border.InsideVertical.Style := clsThinEh;
  cr.Border.InsideHorizontal.Style := clsThinEh;

  cr.ApplyChages;
end;

procedure TDBGridEhToXlsMemFileExporter.WriteAutoFilter;
begin
  if (ExportOptions.IsCreateAutoFilter = False) then Exit;

  Worksheet.AutoFilterRange.FromCol := 0;
  Worksheet.AutoFilterRange.ToCol := ExpCols.Count - 1;
  Worksheet.AutoFilterRange.FromRow := FromRow + GridHeaderTextRowCount + TitleRowCount - 1;
  Worksheet.AutoFilterRange.ToRow := FromRow + GridHeaderTextRowCount + TitleRowCount + DataRowCount - 1;
end;

procedure TDBGridEhToXlsMemFileExporter.SetExportOptions(
  const Value: TDBGridEhXlsMemFileExportOptions);
begin
  FExportOptions.Assign(Value);
end;

procedure TDBGridEhToXlsMemFileExporter.SetFreezeTitleRows;
begin
  if (ExportOptions.IsExportFreezeZones = False) then Exit;
  Worksheet.FrozenRowCount := FromRow + GridHeaderTextRowCount + TitleRowCount;
  Worksheet.FrozenColCount := Grid.FrozenCols;
end;

end.
