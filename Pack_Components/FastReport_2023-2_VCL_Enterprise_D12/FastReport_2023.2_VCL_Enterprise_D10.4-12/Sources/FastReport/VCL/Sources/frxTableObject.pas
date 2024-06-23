{******************************************}
{                                          }
{             FastReport VCL               }
{              Table Object                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

/// <summary>
///   This unit contains classes of Table report object.
/// </summary>
unit frxTableObject;

interface

{$I frx.inc}

uses
  SysUtils, Types, Classes, Graphics, Variants, Controls,
  frxClass;

const
  /// <summary>
  ///   Default row height for new table.
  /// </summary>
  DefaultRowHeight: Extended = 37.7953 * 0.5;
  /// <summary>
  ///   Default column width for new table.
  /// </summary>
  DefaultColumnWidth: Extended = 37.7953 * 2;
type
  TfrxTableObject = class;
  TfrxCustomTableRow = class;
  TfrxTableColumn = class;
  TfrxHackView = class(TfrxView);
  TfrxHackComponent = class(TfrxComponent);
  TfrxCustomTableBuilder = class;
  TfrxTablePagination = (tpAcrossThenDown, tpDownThenAcross, tpDownThenAcrossWrapped);

  /// <summary>
  ///   The class represents padding data of table container (cell).
  /// </summary>
  TfrxContainerPadding = class(TPersistent)
  private
    FLeftPading: Extended;
    FTopPading: Extended;
    FRightPading: Extended;
    FBottomPading: Extended;
  public
    procedure Assign(Source: TPersistent); override;
  published
    /// <summary>
    ///   Left padding value.
    /// </summary>
    property LeftPading: Extended read FLeftPading write FLeftPading;
    /// <summary>
    ///   Top padding value.
    /// </summary>
    property TopPading: Extended read FTopPading write FTopPading;
    /// <summary>
    ///   Right padding value.
    /// </summary>
    property RightPading: Extended read FRightPading write FRightPading;
    /// <summary>
    ///   Bottom padding value.
    /// </summary>
    property BottomPading: Extended read FBottomPading write FBottomPading;
  end;

{$IFDEF DELPHI16}
/// <summary>
///   The TfrxReportTableObject allows use of the Table component in a report.
///   TfrxReportTableObject is an empty component. It is used to add table unit
///   to uses clause of an application. <br />
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxReportTableObject = class(TComponent)  // fake component
  end;

  TfrxTablePrintData = (pdNone, pdRow, pdColumn);
  TfrxTableBandType = (tbData, tbHeader, tbFooter, tbAggregateFooter, tbLocalAggregateFooter);

  TfrxRange = record
    RangeStart: Integer;
    RangeEnd: Integer
  end;

  TfrxTableCell = class;

  TfrxCellData = class
  private
    FIsOwnCell: Boolean;
    FReport: TfrxReport;
    FColSpan: Integer;
    FRowSpan: Integer;
    FIndex: Integer;
    FCell: TfrxTableCell;
    FOriginalCell: TfrxTableCell;
    FValue: Variant;
    FParent: TfrxComponent;
    FText: WideString;
    FNeedUpdate: Boolean;
    procedure SetCell(const Value: TfrxTableCell);
    function GetOriginalCell: TfrxTableCell;
    procedure SetText(const Value: WideString);
  public
    property Report: TfrxReport read FReport write FReport;
    property ColSpan: Integer read FColSpan write FColSpan;
    property RowSpan: Integer read FRowSpan write FRowSpan;
    property Index: Integer read FIndex write FIndex;
    property Cell: TfrxTableCell read FCell write SetCell;
    property OriginalCell: TfrxTableCell read GetOriginalCell write FOriginalCell;
    property Value: Variant read FValue write FValue;
    property Parent: TfrxComponent read FParent write FParent;
    property Text: WideString read FText write SetText;
    property NeedUpdate: Boolean read FNeedUpdate write FNeedUpdate;
    destructor Destroy; override;
  end;

//  TfrxCellData = record
//    ColSpan: Integer;
//    RowSpan: Integer;
//    Index: Integer;
//    Cell: TfrxTableCell;
//    Value: Variant;
//    Parent: TfrxComponent;
//    Text: WideString
//  end;
//
//  TfrxPCellData = ^TfrxCellData;

  /// <summary>
  ///   This class represent a table cell. The table call can be used as a
  ///   container for other component or as Text object. It inherits most of
  ///   the properties from "Text" object.
  /// </summary>
  TfrxTableCell = class(TfrxCustomMemoView, IfrxAggregateObject)
  private
    FColSpan: Integer;
    FRowSpan: Integer;
    FHidden: Boolean;
    FContainerPadding: TfrxContainerPadding;
    FSavedObjects: TList;
    FSplitObjects: TList;
    FSavedColSpan: Integer;
    FSavedRowSpan: Integer;
    procedure SetColSpan(Value: Integer);
    procedure SetRowSpan(Value: Integer);
    function CellWidth: Extended;
    function CellHeight: Extended;
    procedure SetContainerPadding(const Value: TfrxContainerPadding);
    function IsPaddingStored: Boolean;
    function GetParentContainer: TfrxComponent;
    function GetDataContainers: TList;
    function GetExpression: String;
    function GetExpressionDelimiters: String;
    function GetInstance: TfrxComponent;
    function GetDataRowContainer: TfrxComponent;
    function GetColSpan: Integer;
    function GetRowSpan: Integer;
  protected
    FIndex: Integer;
    FCellData: TfrxCellData;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
    procedure SetVisible(Value: Boolean); override;
    function GetRestrictions: TfrxRestrictions; override;
    procedure SetIsSelected(const Value: Boolean); override;
    function IsTopStored: Boolean; override;
    function IsLeftStored: Boolean; override;
    function IsWidthStored: Boolean; override;
    function IsHeightStored: Boolean; override;
    procedure DrawSizeBox(aCanvas: TCanvas; aScale: Extended; bForceDraw: Boolean = False); override;
    procedure StartSplit(AReport: TfrxReport);
    procedure FinishSplit(AReport: TfrxReport);
    function SetCellData(CellData: TfrxCellData; bUpdate: Boolean = False): TfrxTableCell;
    function GetText: WideString; override;
    function GetReport: TfrxReport; override;
    function GetValue: Variant; override;
    procedure SetText(const Value: WideString); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateCellTag(Ln, LinesCount, sTextCount, IDX, I: Integer); virtual;
    procedure AfterPrint; override;
    procedure BeforePrint; override;
    function CalcHeight: Extended; override;
    function CalcWidth: Extended; override;
    procedure ResetCellData;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    /// <summary>
    ///   Draws cell selection area.
    /// </summary>
    /// <param name="Color">
    ///   Selection color.
    /// </param>
    procedure DrawSelected(Color: TColor = clSkyBlue);
    function IsAcceptControl(aControl: TfrxComponent): Boolean; override;
    function IsOwnerDraw: Boolean; override;
    function Diff(AComponent: TfrxComponent): String; override;
    function DiffText(AComponent: TfrxComponent): String; override;
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; override;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoDragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; override;
    procedure GetData; override;
    function GetClientArea: TfrxRect; override;
    /// <summary>
    ///   Returns reference to a parent "Table" object.
    /// </summary>
    function ParentTable: TfrxTableObject;
    /// <summary>
    ///   Returns reference to a parent "Row" object.
    /// </summary>
    function ParentRow: TfrxCustomTableRow;
    function SplitObjects(AHeight: Extended; var IsSplit: Boolean): Extended;
    procedure CleanSplit;
    property Index: Integer read FIndex;
  published
    property AllowExpressions;
    property AllowHTMLTags;
    property BrushStyle;
    property CharSpacing;
    property Clipped;
    property Color;
    property DataField;
    property DataSet;
    property DataSetName;
    property DisplayFormat;
    property ExpressionDelimiters;
    property Font;
    property Frame;
    property FillType;
    property Fill;
    property FlowTo;
    property GapX;
    property GapY;
    property HAlign;
    property HideZeros;
    property Highlight;
    property LineSpacing;
    property Memo;
    property ParagraphGap;
    property ParentFont;
    /// <summary>
    ///   Composite padding object which stores values for padding inside Table
    ///   cell used for inner objects align.
    /// </summary>
    property ContainerPadding: TfrxContainerPadding read FContainerPadding write SetContainerPadding stored IsPaddingStored;
    property Rotation;
    property RTLReading;
    property Style;
    property SuppressRepeated;
    property Underlines;
    property UseDefaultCharset;
    property WordBreak;
    property WordWrap;
    property Wysiwyg;
    property VAlign;
    /// <summary>
    ///   Count of column spans for current cell.
    /// </summary>
    property ColSpan: Integer read GetColSpan write SetColSpan default 1;
    /// <summary>
    ///   Count of row spans for current cell.
    /// </summary>
    property RowSpan: Integer read GetRowSpan write SetRowSpan default 1;
  end;

  /// <summary>
  ///   The base class for Table rows and columns.
  /// </summary>
  TfrxTableRowColumnBase = class(TfrxComponent)
  private
    FAutoSize: Boolean;
    FPageBreak: Boolean;
    FBandType: TfrxTableBandType;
    procedure SetAutoSize(Value: Boolean);
  protected
    FIndex: Integer;
    FInternalObjects: TList;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
    procedure SetIsSelected(const Value: Boolean); override;
    function IsTopStored: Boolean; override;
    function IsLeftStored: Boolean; override;
    property InternalObjects: TList read FInternalObjects;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    ///   Returns reference to a parent "Table" object.
    /// </summary>
    function ParentTable: TfrxTableObject;
    procedure CreateUniqueNames;
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; override;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    /// <summary>
    ///   Index of current row or column.
    /// </summary>
    property Index: Integer read FIndex;
    property BandType: TfrxTableBandType read FBandType;
  published
    /// <summary>
    ///   When this property is set, Table object automatically calculates
    ///   width of column or height of row based on content inside cells.
    /// </summary>
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
  end;

  /// <summary>
  ///   Represents Table column.
  /// </summary>
  TfrxTableColumn = class(TfrxTableRowColumnBase)
  private
    FMinWidth: Extended;
    FMaxWidth: Extended;
  protected
    function IsHeightStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
  published
    function IsContain(X, Y: Extended): Boolean; override;
    property Width;
    /// <summary>
    ///   Minimal width of current column. Column width can not be less than
    ///   this value when AutoSize is turned on.
    /// </summary>
    property MinWidth: Extended read FMinWidth write FMinWidth;
    /// <summary>
    ///   Maximum width of current column. Column width can not be grater than
    ///   this value when AutoSize is turned on.
    /// </summary>
    property MaxWidth: Extended read FMaxWidth write FMaxWidth;
  end;

  /// <summary>
  ///   Represents Table Row.
  /// </summary>
  TfrxCustomTableRow = class(TfrxTableRowColumnBase)
  private
    FMinHeight: Extended;
    FMaxHeight: Extended;
    FAllowSplit: Boolean;
    //FCellsData: array of TfrxCellData;
    //FCellsData: TList;
    function GetCellCount: Integer;

  protected
    FIsSplit: Boolean;
    function GetCell(Index: Integer): TfrxTableCell; virtual;
    procedure InitCells(Value: Integer); virtual;
    procedure CorrectCellsOnColumnChange(Index, Correct: Integer); virtual;
    procedure SetLeft(Value: Extended); override;
    function IsWidthStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateTableCell(Index: Integer; bSetUniqueName: Boolean = False): TObject; virtual;
    procedure AfterPrint;
    function IsContain(X, Y: Extended): Boolean; override;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function GetSplitPart(AHeight: Extended; var IsLastPart: Boolean): TfrxCustomTableRow; virtual;
    function IsSplitPart: Boolean;
    /// <summary>
    ///   Returns count of cell in current row.
    /// </summary>
    property CellCount: Integer read GetCellCount;
    /// <summary>
    ///   List of the cell in current row.
    /// </summary>
    /// <param name="Index">
    ///   Column index.
    /// </param>
    property Cells[Index: Integer]: TfrxTableCell read GetCell;
  published
    property AllowSplit: Boolean read FAllowSplit write FAllowSplit default False;
    /// <summary>
    ///   Minimal height of current row. Row height can not be less than this
    ///   value when AutoSize is turned on.
    /// </summary>
    property MinHeight: Extended read FMinHeight write FMinHeight;
    /// <summary>
    ///   Maximum height of current row. Row height can not be greater than
    ///   this value when AutoSize is turned on.
    /// </summary>
    property MaxHeight: Extended read FMaxHeight write FMaxHeight;
    property Height;
  end;

  /// <summary>
  ///   The TfrxTableObject component represents a Table object. The table
  ///   object used to group report data or object in one big tabular
  ///   structure. With table object it's more easy to change appearance of the
  ///   tabular based reports. Table may grow in size based on content inside
  ///   cells. The table cells can contain other objects. The table size
  ///   controls by rows and column count.
  /// </summary>
  TfrxTableObject = class(TfrxStretcheable)
  private
    FRowCount: Integer;
    FColumnCount: Integer;
    FLockCorrectSpans: Boolean;
    FLockObjectsUpdate: Boolean;
    FSpanList: PfrxRectArray;
    FDragDropActive: Boolean;
    FColumnSelection: Boolean;
    FRowSelection: Boolean;
    FSelectionStart: TRect;
    FSelectionEnd: TRect;
    FCellsSelection: TRect;
    FModified: Boolean;
    FNewColumnDim: Integer;
    FNewRowDim: Integer;
    FResizeActive: Boolean;
    FBoundsUpdating: Boolean;
    FSavedTable: TfrxTableObject;
    FTableActive: Boolean;

    FSelectorPoint: TPoint;
    FSelectionFill: TfrxCustomFill;
    FSelectedGridCol: Integer;
    FSelectedGridRow: Integer;
    FCopyAppearance: Boolean;

    FVertSplitter: Integer;
    FHorzSplitter: Integer;
    FBreakRowIndex: Integer;
    FTableBuilder: TfrxCustomTableBuilder;
    FIsManualBuild: Boolean;
    FOnManualBuild: TfrxNotifyEvent;

    FLastMousePos: TPoint;
    FBrakeTo: TfrxTableObject;
    FBrakeToRows: TList;
    FBrakeToRowHeight: Extended;
    FDefaultCellHeight: Extended;
    FDefaultCellWidth: Extended;

    function GetColumn(Index: Integer): TfrxTableColumn;
    function GetRow(Index: Integer): TfrxCustomTableRow;
    function GetCell(X, Y: Integer): TfrxTableCell;
    procedure SetColumnCount(Value: Integer);
    procedure SetRowCount(Value: Integer);
    procedure CorrectSpansOnColumnChange(ColumnIndex, Correct: Integer);
    procedure CorrectSpansOnRowChange(RowIndex, Correct: Integer);
    procedure ResetSpanList;
    procedure DrawTable(Highlighted: Boolean = False);
    procedure CalcWidthInternal;
    procedure CalcHeightInternal;
    procedure NormalizeSpans;
    procedure AssignCellAppearance(FromCell, ToCell: TfrxTableCell);
    procedure UpdateDesigner;
    procedure UpdateCellDimensions(cell: TfrxTableCell);
    function GetTableHeight: Extended;
    function GetTableWidth: Extended;
    procedure SetTableHeight(const Value: Extended);
    procedure SetTableWidth(const Value: Extended);
    function GetTableBuilder: TfrxCustomTableBuilder;
  protected
    FSelectedRowCol: TfrxTableRowColumnBase;
    FSelectedRowColCount: Integer;
    procedure NormalizeObjectsList;
    procedure FillSpanList(var SpanList: TfrxRectArray);
    function IsInsideSpan(SpanList: TfrxRectArray; p: TPoint): Boolean;
    function IsTableActive: Boolean;
    function CheckColumnSelector(X, Y: Extended): Boolean;
    function CheckRowSelector(X, Y: Extended): Boolean;
    function CheckMoveArrow(X, Y: Extended): Boolean;
    function CheckSizeArrow(X, Y: Extended): Boolean;
    procedure ObjectListNotify(Ptr: Pointer; Action: TListNotification); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
    function GetRowColumnByClass(aClass: TClass; Index: Integer): TfrxTableRowColumnBase;
    function IsWidthStored: Boolean; override;
    function IsHeightStored: Boolean; override;
    function CreateTableColumn: TfrxTableColumn; virtual;
    function CreateUniqueTableColumn: TfrxTableColumn; virtual;
    function CreateUniqueTableRow: TfrxCustomTableRow; virtual;
    procedure Loaded; override;
    procedure DoMirror(MirrorModes: TfrxMirrorControlModes); override;
    procedure MoveRowsColumns(DestTable: TfrxTableObject; bClearSource: Boolean = False; RowStartIndex: Integer = 0; RowEndIndex: Integer = -1; ColStartIndex: Integer = 0; ColEndIndex: Integer = -1);
    procedure RestoreBreakTable;
    procedure RestoreSourceTable;
    procedure RestoreAfterBuilder;
    procedure AddBrakeToRow(ARow: TfrxCustomTableRow);
    procedure ClearBrakeToRows;
    function GetSplitRow(ARow: TfrxCustomTableRow; AHeight: Extended; var IsLastPart: Boolean): TfrxCustomTableRow; virtual;
  public
    FSerializeColumns: TfrxRange;
    FSerializeRows: TfrxRange;
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    class function CreateTableRow: TfrxCustomTableRow; virtual;
    destructor Destroy; override;
    procedure AlignChildren(IgnoreInvisible: Boolean = False; MirrorModes: TfrxMirrorControlModes = []); override;
    procedure Clear; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    function DrawPart: Extended; override;
    procedure InitPart; override;
    function HasNextDataPart(aFreeSpace: Extended): Boolean; override;
    procedure DoMouseEnter(aPreviousObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseLeave(aPreviousObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; override;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function IsContain(X, Y: Extended): Boolean; override;
    function IsAcceptAsChild(aParent: TfrxComponent): Boolean; override;
    function GetContainedComponent(X, Y: Extended; IsCanContain: TfrxComponent = nil): TfrxComponent; override;
//    function ContainerAdd(Obj: TfrxComponent): Boolean; override;
    procedure BeforePrint; override;
    procedure AfterPrint; override;
    function CalcHeight: Extended; override;
    { script helpers }
    /// <summary>
    ///   Helper method used to create new column and insert it by given index
    ///   into current table object.
    /// </summary>
    /// <param name="Index">
    ///   Column index.
    /// </param>
    function CreateNewColumn(Index: Integer): TfrxTableColumn;
    /// <summary>
    ///   Helper method used to create new row and insert it by given index
    ///   into current table object.
    /// </summary>
    /// <param name="Index">
    ///   Row index.
    /// </param>
    function CreateNewRow(Index: Integer): TfrxCustomTableRow;

    procedure GetData; override;
    class function GetDescription: String; override;
    function ExportInternal(Filter: TfrxCustomExportFilter): Boolean; override;
    procedure LockObjectsUpdate;
    procedure UnlockObjectsUpdate;
    function GetSaveToComponent: TfrxReportComponent; override;
    /// <summary>
    ///   Adds column by it reference to the end of the table.
    /// </summary>
    /// <param name="Value">
    ///   Reference to a column object.
    /// </param>
    procedure AddColumn(Value: TfrxTableColumn);
    /// <summary>
    ///   Inserts column by it reference to given position.
    /// </summary>
    /// <param name="Index">
    ///   Column index.
    /// </param>
    /// <param name="Value">
    ///   Reference to a column object. <br />
    /// </param>
    procedure InsertColumn(Index: Integer; Value: TfrxTableColumn);
    /// <summary>
    ///   Moves culumn of the table from one position to another.
    /// </summary>
    /// <param name="Index">
    ///   Index of column to move.
    /// </param>
    /// <param name="NewIndex">
    ///   New position of the column.
    /// </param>
    procedure MoveColumn(Index, NewIndex: Integer);
    /// <summary>
    ///   Deletes column from the table.
    /// </summary>
    /// <param name="Index">
    ///   Column index.
    /// </param>
    procedure DeleteColumn(Index: Integer);
    /// <summary>
    ///   Adds row by it reference to the end of the table.
    /// </summary>
    /// <param name="Value">
    ///   Reference to a row object. <br />
    /// </param>
    procedure AddRow(Value: TfrxCustomTableRow);
    /// <summary>
    ///   Inserts row by it reference to given position.
    /// </summary>
    /// <param name="Index">
    ///   Index of the row.
    /// </param>
    /// <param name="Value">
    ///   Reference to a row object.
    /// </param>
    procedure InsertRow(Index: Integer; Value: TfrxCustomTableRow);
    /// <summary>
    ///   Swaps positions of two rows in the table.
    /// </summary>
    /// <param name="Row1">
    ///   Index of first row.
    /// </param>
    /// <param name="Row2">
    ///   index of second row.
    /// </param>
    procedure SwapRows(Row1, Row2: Integer);
    /// <summary>
    ///   Deletes row from the table.
    /// </summary>
    /// <param name="Index">
    ///   Row index to delete.
    /// </param>
    procedure DeleteRow(Index: Integer);
    procedure UpdateBounds; override;
    function IsDynamicTable: Boolean;
    /// <summary>
    ///   Joins selected cells to one big by setting ColSpan and RowSpan
    ///   properties.
    /// </summary>
    /// <param name="TopX">
    ///   Top column position of selection.
    /// </param>
    /// <param name="TopY">
    ///   Top row position of selection. <br />
    /// </param>
    /// <param name="BottomX">
    ///   Bottom column position of selection. <br />
    /// </param>
    /// <param name="BottomY">
    ///   Bottom row position of selection.
    /// </param>
    procedure JoinSelection(TopX: Integer = MaxInt; TopY: Integer = MaxInt; BottomX: Integer = -1; BottomY: Integer = -1);
    /// <summary>
    ///   Splits selected cells by reset ColSpan and RowSpan properties.
    /// </summary>
    procedure SplitSelected;
    /// <summary>
    ///   Splits cell by reset ColSpan and RowSpan properties.
    /// </summary>
    /// <param name="aCell">
    ///   Reference to a cell object to split.
    /// </param>
    procedure SplitCell(aCell: TfrxTableCell);
    procedure SetSpanFillList(const SpanList: PfrxRectArray);
    /// <summary>
    ///   List of table columns.
    /// </summary>
    /// <param name="Index">
    ///   Column index.
    /// </param>
    property Columns[Index: Integer]: TfrxTableColumn read GetColumn;
    /// <summary>
    ///   List of table rows.
    /// </summary>
    /// <param name="Index">
    ///   Row index.
    /// </param>
    property Rows[Index: Integer]: TfrxCustomTableRow read GetRow;
    /// <summary>
    ///   Matrix of cell objects.
    /// </summary>
    /// <param name="X">
    ///   Column index.
    /// </param>
    /// <param name="Y">
    ///   Row index.
    /// </param>
    property Cells[X, Y: Integer]: TfrxTableCell read GetCell;
    /// <summary>
    ///   Default cell height used during creation of new row or column.
    /// </summary>
    property DefaultCellHeight: Extended read FDefaultCellHeight write FDefaultCellHeight;
    /// <summary>
    ///   Default cell width used during creation of new row or column.
    /// </summary>
    property DefaultCellWidth: Extended read FDefaultCellWidth write FDefaultCellWidth;
    /// <summary>
    ///   Height of the table object.
    /// </summary>
    property TableHeight: Extended read GetTableHeight write SetTableHeight;
    /// <summary>
    ///   Width of the table object
    /// </summary>
    property TableWidth: Extended read GetTableWidth write SetTableWidth;
    property TableBuilder: TfrxCustomTableBuilder read GetTableBuilder;
  published
    /// <summary>
    ///   Count of columns in the table object.
    /// </summary>
    property ColumnCount: Integer read FColumnCount write SetColumnCount stored False;
    /// <summary>
    ///   Count of rows in the table object.
    /// </summary>
    property RowCount: Integer read FRowCount write SetRowCount stored False;
    property OnManualBuild: TfrxNotifyEvent read FOnManualBuild write FOnManualBuild;
  end;

  TfrxStateTableObject = class(TfrxTableObject)
  private
    FReport: TfrxReport;
    FOriginalParent: TfrxComponent;
  protected
    function GetReport: TfrxReport; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AssignOriginals(Source: TfrxComponent); override;
  end;

  TfrxTableRow = class(TfrxCustomTableRow);

  TfrxTableObjectClass = class of TfrxTableObject;

  TfrxCustomTableBuilder = class(TPersistent)
  protected
    FResultTable: TfrxTableObject;
    FSourceTable: TfrxTableObject;
    FOutTable: TfrxTableObject;
    FIsFirstPart: Boolean;
    FLeft: Extended;
    FTop: Extended;
    FFixedColumns: TList;
    FFixedFooterColumns: TList;
    FFixedFooterRows: TList;
    FFixedRows: TList;
    FReport: TfrxReport;
    FDataPrinting: TfrxTablePrintData;
    FIsRowPriority: Boolean;
    FPageBreak: Boolean;
    FAutoSpans: Boolean;
    FColumnSpans: TList;
    FRowSpans: TList;
    FPaginationOrder: TfrxTablePagination;
    FPartHeight: Extended;
    FOriginalRowIndex: Integer;
    FOriginalColumnIndex: Integer;
    FPrintingRowIndex: Integer;
    FPrintingColumnIndex: Integer;
    FPaginateStart: TPoint;
    FPaginateEnd: TPoint;
    FFirstPartY: Extended;
    FIsLastPart: Boolean;
    FCurrentPrintPart: TfrxTablePagination;
    FIsNewPage: Boolean;
    FTempList: TList;
    FLastUpdateValue: Cardinal;
    FResultSpans: TfrxRectArray;
    FBreakeSpanCells: TList;
    FResetBreakeSpan: Boolean;
    FCurFixedColumns: TList;
    FSavedTerminated: Boolean;
    class function GetResultTableClass: TfrxTableObjectClass; virtual;
    procedure CopyCells(OriginalColumnIndex, OriginalRowIndex,
      ResultColumnIndex, ResultRowIndex: Integer); virtual; abstract;
    procedure FillUpdate;
    procedure RestoreSpanBreak;
  protected
    procedure AddFixedColumn(FixedColumn: TfrxTableColumn; DestTable: TfrxTableObject); virtual;
    procedure AddFooterColumn(ColumnFooter: TfrxTableColumn; DestTable: TfrxTableObject); virtual;
    procedure AddFooterRow(RowFooter: TfrxCustomTableRow; DestTable: TfrxTableObject); virtual;
    procedure AddFixedRow(FixedRow: TfrxCustomTableRow; DestTable: TfrxTableObject); virtual;
    procedure ClearResultObjects(ATable: TfrxTableObject); virtual;
    function GetCellData(X, Y: Integer): TfrxCellData; virtual;
  public
    constructor Create(SourceTable: TfrxTableObject); virtual;
    destructor Destroy; override;
    procedure PrintRow(Index: Integer; TableBandType: TfrxTableBandType = tbData);
    procedure PrintRows(StartIndex: Integer = 0);
    procedure PrintColumn(Index: Integer; TableBandType: TfrxTableBandType = tbData);
    procedure PrintColumns(StartIndex: Integer = 0);
    procedure PageBreak;
    procedure PrepareFirstPart(PrepareToTable: TfrxTableObject);
    function PaginateNextPartTo(ATable: TfrxTableObject; Report: TfrxReport; var UsedHeight: Extended): Boolean;
    procedure DoPaginateTo(ATable: TfrxTableObject; Report: TfrxReport);
    function ColumnCount: Integer;
    function RowCount: Integer;
    property PrintingRowIndex: Integer read FPrintingRowIndex;
    property PrintingColumnIndex: Integer read FPrintingColumnIndex;
    property CellData[X, Y: Integer]: TfrxCellData read GetCellData;
    property ResultTable: TfrxTableObject read FResultTable;
    property OutTable: TfrxTableObject read FOutTable;// hide from public
    property PaginationOrder: TfrxTablePagination read FPaginationOrder write FPaginationOrder;
    property PartHeight: Extended read FPartHeight;
  end;

  TfrxTableBuilderClass = class of TfrxCustomTableBuilder;

  TfrxTableBuilder = class(TfrxCustomTableBuilder)
  protected
    procedure CopyCells(OriginalColumnIndex, OriginalRowIndex,
      ResultColumnIndex, ResultRowIndex: Integer); override;
  end;

var
  frxTableBuilder: TfrxTableBuilderClass;

implementation

uses
  Math, frxGraphicUtils, frxRes, frxUtils, frxTableObjectRTTI,
  frxTableObjectEditor, frxTableObjectClipboard, frxResultTableObject, frXML;

const
  frxTableFillUpdate = 20000;

{ TfrxTableCell }

constructor TfrxTableCell.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frComponentStyle := frComponentStyle + [csContained, csAcceptsFrxComponents];
  FColSpan := 1;
  FRowSpan := 1;
  Frame.Typ := [ftLeft, ftRight, ftTop, ftBottom];
  LockAnchorsUpdate;
  FContainerPadding := TfrxContainerPadding.Create;
end;

function TfrxTableCell.SetCellData(CellData: TfrxCellData; bUpdate: Boolean = False): TfrxTableCell;
begin
  FColSpan := CellData.ColSpan;
  FRowSpan := CellData.RowSpan;
  Result := Self;
  if bUpdate then
  begin
    FCellData := nil;
    if Assigned(FOriginalComponent) then
      Text := TfrxCustomMemoView(FOriginalComponent).Text
    else
      CellData.Text := Text;

    BeforePrint;
    FCellData := CellData;
    GetData;
    FCellData := nil;

    CellData.Value := Value;
    CellData.Text := Text;
    AfterPrint;
  end;
  FCellData := CellData;
end;

procedure TfrxTableCell.SetColSpan(Value: Integer);
begin
  if Value < 1 then
    Value := 1;
  if Assigned(FCellData) then
  begin
    FCellData.ColSpan := Value;
    Exit;
  end;
  if not IsLoading then
    Value := Min(ParentTable.ColumnCount, FIndex + Value) - FIndex;
  if FColSpan <> Value then
  begin
    FColSpan := Value;
    if ParentTable <> nil then
      ParentTable.ResetSpanList;
  end;
end;

procedure TfrxTableCell.SetContainerPadding(const Value: TfrxContainerPadding);
begin
  FContainerPadding.Assign(Value);
end;

procedure TfrxTableCell.SetHeight(Value: Extended);
begin
  if Height = 0 then
    LockAnchorsUpdate;
  try
    inherited;
  finally
    LockAnchorsUpdate
  end;
end;

procedure TfrxTableCell.SetIsSelected(const Value: Boolean);
var
  aTable: TfrxTableObject;
begin
  inherited SetIsSelected(Value);
  aTable := ParentTable;
  if aTable <> nil then
    aTable.FTableActive := Value;
end;

procedure TfrxTableCell.SetParent(AParent: TfrxComponent);
begin
  { only row can containt cells}
  if not(AParent is TfrxCustomTableRow) and (AParent <> nil) then Exit;
  inherited;
end;

procedure TfrxTableCell.SetRowSpan(Value: Integer);
begin
  if Value < 1 then
    Value := 1;

  if Assigned(FCellData) then
  begin
    FCellData.RowSpan := Value;
    Exit;
  end;

  if not IsLoading then
    Value := Min(ParentTable.RowCount, ParentRow.FIndex + Value) - ParentRow.FIndex;
  if FRowSpan <> Value then
  begin
    FRowSpan := Value;
    if ParentTable <> nil then
      ParentTable.ResetSpanList;
  end;
end;

procedure TfrxTableCell.SetText(const Value: WideString);
begin
  if Assigned(FCellData) then
    FCellData.Text := Value
  else
    inherited SetText(Value);
end;

procedure TfrxTableCell.SetVisible(Value: Boolean);
begin
  inherited SetVisible(True);
end;

procedure TfrxTableCell.SetWidth(Value: Extended);
begin
  if Width = 0 then
    LockAnchorsUpdate;
  try
    inherited;
  finally
    LockAnchorsUpdate
  end;
end;

function TfrxTableCell.SplitObjects(AHeight: Extended; var IsSplit: Boolean): Extended;
var
  LReport: TfrxReport;
  uSpace: Extended;
  i: Integer;
  bIsFirstPart: Boolean;
begin
  Result := Height;
  LReport := Report;
  IsSplit := False;
  bIsFirstPart := (FSavedObjects = nil);
  if Assigned(LReport) then
  begin
    StartSplit(LReport);
    { correct to gap }
    { avoid empty lines at the end }
    Height := AHeight - GapY * 2;
    //if AHeight > FSaveHeight then
    //  Height := FSaveHeight;
    uSpace := DrawPart;

    if Height - uSpace < 1e-4 then
    begin
      Result := 0;
      IsSplit := True;
      Exit;
    end
    else
      Height := Inherited CalcHeight;
    if FSavedObjects.Count > 0 then
    begin
      if not bIsFirstPart then
      begin
        for i := 0 to FSavedObjects.Count - 1 do
          TfrxComponent(FSavedObjects[i]).Top := TfrxComponent(FSavedObjects[i]).Top + FContainerPadding.TopPading + FContainerPadding.BottomPading;
        Height := Height + FContainerPadding.TopPading;
      end;
      FSaveHeight := FSaveHeight + FContainerPadding.BottomPading;
      IsSplit := LReport.Engine.SplitObjects(Self, FSavedObjects, FSplitObjects, AHeight - FContainerPadding.BottomPading) or IsSplit
    end
    else if (Height - uSpace > 1e-4) and (Length(FPartMemo) > 0) then
      IsSplit := FSaveHeight - (Height + GapY * 2) > 1e-4 ;
    //FSaveHeight := FSaveHeight - Height;
    Result := Height;//  + FContainerPadding.BottomPading;
  end;
end;

procedure TfrxTableCell.StartSplit(AReport: TfrxReport);
begin
  if FSavedObjects = nil then
  begin
    InitPart;
    FSavedObjects := TList.Create;
    FSplitObjects := TList.Create;
    AReport.Engine.InitializeSplit(Self, FSavedObjects, FSplitObjects);
    FSaveHeight := Height;
  end;
end;

function TfrxTableCell.ParentTable: TfrxTableObject;
begin
  if ParentRow = nil then
    Result := nil
  else
    Result := ParentRow.ParentTable;
end;

procedure TfrxTableCell.ResetCellData;
begin
  FCellData := nil;
end;

function TfrxTableCell.ParentRow: TfrxCustomTableRow;
begin
  if Assigned(FCellData) then
    Result := FCellData.Parent as TfrxCustomTableRow
  else
    Result := Parent as TfrxCustomTableRow;
end;

procedure TfrxTableCell.AfterPrint;
var
  aReport: TfrxReport;
begin
  inherited;
  aReport := Report;
  if Assigned(aReport) then
  begin
    FinishSplit(aReport);
    if (Objects.Count > 0) then
      aReport.Engine.Unstretch(Self);
    if Assigned(aReport) then
      aReport.DoAfterPrint(Self);
  end;
  FColSpan := FSavedColSpan;
  FRowSpan := FSavedRowSpan;
end;

procedure TfrxTableCell.BeforePrint;
var
  i: Integer;
  aReport: TfrxReport;
begin
  inherited;
  aReport := Report;
  FSavedColSpan := FColSpan;
  FSavedRowSpan := FRowSpan;
  if (ParentRow <> nil) {and not(ParentRow.AutoSize)} then
  begin
    if Assigned(aReport) then
      aReport.DoBeforePrint(Self);
    for i := 0 to Objects.Count - 1 do
    begin
      TfrxView(Objects[i]).BeforePrint;
      if Assigned(aReport) then
        aReport.DoBeforePrint(TfrxView(Objects[i]));
    end;
  end;
end;

function TfrxTableCell.CalcHeight: Extended;
var
  aReport: TfrxReport;
  SaveH: Extended;
begin
  SaveH := Height;
  if Assigned(FCellData) then
    Inherited SetText(FCellData.Text);
  Result := Inherited CalcHeight;
  aReport := Report;
  if Assigned(aReport) then
    aReport.Engine.Stretch(Self, True);

  if Height > Result then
    Result := Height;
  Height := SaveH;
end;

function TfrxTableCell.CalcWidth: Extended;
begin
  if Assigned(FCellData) then
    Inherited SetText(FCellData.Text);
  Result := Inherited CalcWidth;
end;

function TfrxTableCell.CellHeight: Extended;
var
  i, y: Integer;
begin
  Result := 0;
  y := ParentRow.Index;
  for i := y to y + RowSpan - 1 do
    Result := Result + ParentTable.Rows[i].Height;
end;

function TfrxTableCell.CellWidth: Extended;
var
  i, x: Integer;
begin
  Result := 0;
  x := FIndex;
  for i := x to x + ColSpan - 1 do
    Result := Result + ParentTable.Columns[i].Width;
end;

procedure TfrxTableCell.CleanSplit;
var
  LReport: TfrxReport;
begin
  LReport := Report;
  if Assigned(LReport) then
    LReport.Engine.FinalizeSplit(Self, FSavedObjects, FSplitObjects,  Height);
end;

destructor TfrxTableCell.Destroy;
begin
  FreeAndNil(FContainerPadding);
  FinishSplit(nil);
  inherited;
end;

procedure TfrxTableCell.CreateCellTag(Ln, LinesCount, sTextCount, IDX, I: Integer);
begin
  //none
end;

function TfrxTableCell.Diff(AComponent: TfrxComponent): String;
var
  c: TfrxTableCell;
begin
//  if Assigned(FCellData) then
//    Memo.Text := FCellData.Text;
  Result := inherited Diff(AComponent);
  c := TfrxTableCell(AComponent);
  if FRowSpan <> c.FRowSpan then
    Result := Result + ' RowSpan="' + IntToStr(FRowSpan) + '"';
  if FColSpan <> c.FColSpan then
    Result := Result + ' ColSpan="' + IntToStr(FColSpan) + '"';
  if frxFloatDiff(FContainerPadding.LeftPading, c.ContainerPadding.LeftPading) then
    Result := Result + ' ContainerPadding.LeftPading="' + FloatToStr(FContainerPadding.LeftPading) + '"';
  if frxFloatDiff(FContainerPadding.RightPading, c.ContainerPadding.RightPading) then
    Result := Result + ' ContainerPadding.RightPading="' + FloatToStr(FContainerPadding.RightPading) + '"';
  if frxFloatDiff(FContainerPadding.TopPading, c.ContainerPadding.TopPading) then
    Result := Result + ' ContainerPadding.TopPading="' + FloatToStr(FContainerPadding.TopPading) + '"';
  if frxFloatDiff(FContainerPadding.BottomPading, c.ContainerPadding.BottomPading) then
    Result := Result + ' ContainerPadding.BottomPading="' + FloatToStr(FContainerPadding.BottomPading) + '"';
end;

function TfrxTableCell.DiffText(AComponent: TfrxComponent): String;
var
  s: WideString;
begin
  if Assigned(FCellData) then
  begin
    if Length(FCellData.Text) = 0 then
      Result := ' u=""'
    else
    begin
      s := FCellData.Text;
      {$IFDEF Linux}
      SetLength(s, Length(s) - 1);
      {$ELSE}
      SetLength(s, Length(s) - 2);
      {$ENDIF}
{$IFDEF DELPHI12}
      Result := ' u="' + frxStrToXML(s) + '"';
{$ELSE}
{$IFDEF FPC}
      Result := ' u="' + frxStrToXML(s) + '"';
{$ELSE}
      Result := ' u="' + frxStrToXML(Utf8Encode(s)) + '"';
{$ENDIF}
{$ENDIF}

    end;
  end
  else
    Result := inherited DiffText(AComponent);
end;

function TfrxTableCell.DoDragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  aTable: TfrxTableObject;
begin
  Result := False;
  aTable := ParentTable;
  if aTable <> nil then
    aTable.FDragDropActive := True;
end;

function TfrxTableCell.DoMouseDown(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  aTable: TfrxTableObject;
  C: TfrxComponent;
begin
  Result := inherited DoMouseDown(X, Y, Button, Shift, EventParams);
  aTable := ParentTable;
  if aTable <> nil then
  begin
    Result := aTable.DoMouseDown(X, Y, Button, Shift, EventParams);
    if not Result and Assigned(EventParams.SelectionList) and (Button = mbLeft){ and (EventParams.EventSender = esDesigner)} then
    begin

      aTable.FSelectionStart.Left := FIndex;
      aTable.FSelectionStart.Top := ParentRow.FIndex;
      aTable.FSelectionStart.Right := FIndex + ColSpan - 1;
      aTable.FSelectionStart.Bottom := ParentRow.FIndex + RowSpan - 1;
      c := GetContainedComponent(X / FScaleX, Y / FScaleY);
      if c is TfrxTableCell then
        //if not c.IsSelected then
        begin
          EventParams.SelectionList.Clear;
          EventParams.SelectionList.Add(c);
        end;
      EventParams.Refresh := True;
      Result := True;
    end;
  end;
end;

procedure TfrxTableCell.DoMouseMove(X, Y: Integer; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
var
  aTable: TfrxTableObject;
begin
  inherited;
  aTable := ParentTable;
  if aTable <> nil then
      aTable.DoMouseMove(X, Y, Shift, EventParams);
end;

procedure TfrxTableCell.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  aTable: TfrxTableObject;
begin
  inherited;
  aTable := ParentTable;
  if aTable <> nil then
    aTable.DoMouseUp(X, Y, Button, Shift, EventParams);
end;

procedure TfrxTableCell.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  // handle draw in the Table object
  if Assigned(FVC) or FObjAsMetafile then
  begin
    BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
    DrawText;
  end;
end;


procedure TfrxTableCell.DrawSelected(Color: TColor = clSkyBlue);
begin
  TransparentFillRect(FCanvas.Handle, FX + 1, FY + 1, FX1 - 1, FY1 - 1, Color);
//  ParentTable.FSelectionFill.Draw(FCanvas, FX, FY, FX1, FY1, FScaleX, FScaleY);
end;

procedure TfrxTableCell.DrawSizeBox(aCanvas: TCanvas; aScale: Extended;
  bForceDraw: Boolean);
begin
  // nothing
end;

procedure TfrxTableCell.FinishSplit(AReport: TfrxReport);
var
  i: Integer;
begin
  if Assigned(FSavedObjects) then
  begin
    Objects.Clear;
    for i := 0 to FSavedObjects.Count - 1 do
      Objects.Add(FSavedObjects[i]);
  end;
  FreeAndNil(FSavedObjects);
  FreeAndNil(FSplitObjects);
end;

function TfrxTableCell.GetClientArea: TfrxRect;
begin
  Result := frxRect(FContainerPadding.FLeftPading, FContainerPadding.TopPading, Width - FContainerPadding.RightPading - FContainerPadding.FLeftPading, Height - FContainerPadding.BottomPading - FContainerPadding.TopPading);
end;

function TfrxTableCell.GetColSpan: Integer;
begin
  if Assigned(FCellData) then
    Result := FCellData.ColSpan
  else
    Result := FColSpan;
end;

procedure TfrxTableCell.GetData;
var
  i: Integer;
  aReport: TfrxReport;
  View: TfrxView;
begin
  inherited;
  aReport := Report;
  if Assigned(aReport) then
    aReport.DoNotifyEvent(Self, OnAfterData);
  //if (ParentTable.StretchMode <> smDontStretch){ and ParentRow.AutoSize} then Exit;
  for i := 0 to Objects.Count -1 do
    if TObject(Objects[i]) is TfrxView then
    begin
      View := TfrxView(Objects[i]);
      if View.Processing.ProcessAt = paDefault then
      begin
        View.GetData;
        if Assigned(aReport) then
          aReport.DoNotifyEvent(View, View.OnAfterData);
      end;
    end;
end;

function TfrxTableCell.GetDataContainers: TList;
begin
  Result := TList.Create;
  if ParentRow <> nil then
    Result.Add(ParentRow);
  if ParentTable <> nil then
    Result.Add(ParentTable.Columns[FIndex])
end;

function TfrxTableCell.GetDataRowContainer: TfrxComponent;
begin
  Result := ParentTable;
end;

function TfrxTableCell.GetExpression: String;
begin
  Result := Text;
end;

function TfrxTableCell.GetExpressionDelimiters: String;
begin
  Result := ExpressionDelimiters;
end;

function TfrxTableCell.GetInstance: TfrxComponent;
begin
  Result := Self;
end;

function TfrxTableCell.GetParentContainer: TfrxComponent;
var
  PTable: TfrxTableObject;
begin
  PTable := ParentTable;
  Result := nil;
  if Assigned(PTable) then
  begin
    if PTable.IsDynamicTable then
      Result := TfrxHackComponent(PTable).FOriginalComponent
    else
    begin
      Result := PTable.Parent;
      while Assigned(Result) and not (Result is TfrxBand) do
        Result := Result.Parent;
    end;
  end;
end;

function TfrxTableCell.GetReport: TfrxReport;
begin
  if Assigned(FCellData) then
    Result := FCellData.Report
  else
    Result := inherited GetReport;
end;

function TfrxTableCell.GetRestrictions: TfrxRestrictions;
begin
  Result := Inherited GetRestrictions + [rfDontDelete];
end;

function TfrxTableCell.GetRowSpan: Integer;
begin
  if Assigned(FCellData) then
    Result := FCellData.RowSpan
  else
    Result := FRowSpan;
end;

function TfrxTableCell.GetText: WideString;
begin
  if Assigned(FCellData) then
    Result := FCellData.Text
  else
    Result := inherited GetText;
end;

function TfrxTableCell.GetValue: Variant;
begin
  if Assigned(FCellData) then
    Result := FCellData.Value
  else
    Result := inherited GetValue;
end;

function TfrxTableCell.IsAcceptControl(aControl: TfrxComponent): Boolean;
begin
  Result := Inherited IsAcceptControl(aControl);
  if aControl <> nil then
    Result := Result and aControl.IsAcceptAsChild(Self);
end;

function TfrxTableCell.IsHeightStored: Boolean;
begin
  Result := False;
end;

function TfrxTableCell.IsLeftStored: Boolean;
begin
  Result := False;
end;

function TfrxTableCell.IsOwnerDraw: Boolean;
begin
  Result := True;
end;

function TfrxTableCell.IsPaddingStored: Boolean;
begin
  Result := (FContainerPadding.FLeftPading <> 0) or
    (FContainerPadding.FTopPading <> 0) or (FContainerPadding.FRightPading <> 0)
    or (FContainerPadding.FBottomPading <> 0);
end;

function TfrxTableCell.IsTopStored: Boolean;
begin
  Result := False;
end;

function TfrxTableCell.IsWidthStored: Boolean;
begin
  Result := False;
end;

{ TfrxTableRowColumnBase }

procedure TfrxTableRowColumnBase.SetParent(AParent: TfrxComponent);
var
//  OldParent: TfrxComponent;
  i: Integer;
begin
  { only table can containt column/rows}
  if not(AParent is TfrxTableObject) and (AParent <> nil) then Exit;
  if FParent <> AParent then
  begin
    if FParent <> nil then
{$IFNDEF FPC}
{$IFDEF DELPHI20}
      FParent.Objects.RemoveItem(Self, FParent.Objects.SearchDirection);
{$ELSE}
      FParent.Objects.Remove(Self);
{$ENDIF}
{$ELSE}
      FParent.Objects.Remove(Self);
{$ENDIF}
    if AParent <> nil then
    begin
      if (AParent.Objects.Count = 0) or (Self is TfrxCustomTableRow) then
        AParent.Objects.Add(Self)
      else if Self is TfrxTableColumn then
        for i := 0 to AParent.Objects.Count - 1 do
          if not(TObject(AParent.Objects[i]) is TfrxTableColumn) then
          begin
            AParent.Objects.Insert(i, Self);
            break;
          end
          else if i = AParent.Objects.Count - 1  then
            AParent.Objects.Add(Self);
    end;
  end;
  FParent := AParent;
  if FParent <> nil then
    SetParentFont(ParentFont);
{
  OldParent := Parent;
  inherited SetParent(AParent);
  if Parent <> OldParent then
  begin
    if OldParent <> nil then
      (OldParent as TfrxTableObject).NormalizeObjectsList;
    if Parent <> nil then
      (Parent as TfrxTableObject).NormalizeObjectsList;
  end;}
end;

procedure TfrxTableRowColumnBase.SetWidth(Value: Extended);
begin
  if Value < 0 then Exit;
  inherited;
end;

procedure TfrxTableRowColumnBase.SetAutoSize(Value: Boolean);
begin
  FAutoSize := Value;
end;

procedure TfrxTableRowColumnBase.SetHeight(Value: Extended);
begin
  if Value < 0 then Exit;
  inherited;
end;

procedure TfrxTableRowColumnBase.SetIsSelected(const Value: Boolean);
var
  aTable: TfrxTableObject;
begin
  inherited SetIsSelected(Value);
  aTable := ParentTable;
  if aTable <> nil then
    aTable.FTableActive := Value;
end;

constructor TfrxTableRowColumnBase.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle + [csContained];
  FInternalObjects := Objects;
end;

procedure TfrxTableRowColumnBase.CreateUniqueNames;
var
  i: Integer;
begin
  CreateUniqueName;
  for i := 0 to InternalObjects.Count - 1 do
    TfrxComponent(InternalObjects[i]).CreateUniqueName;
end;

destructor TfrxTableRowColumnBase.Destroy;
var
  aTable: TfrxTableObject;
begin
  aTable := ParentTable;
  if aTable <> nil then
  begin
    aTable.FSelectedRowCol := nil;
    aTable.FSelectedRowColCount := 0;
    aTable.FSelectionStart := Rect(-1, -1, -1, -1);
    aTable.FSelectionEnd := Rect(-1, -1, -1, -1);
    aTable.FCellsSelection := Rect(-1, -1, -1, -1);
  end;
  inherited;
end;

function TfrxTableRowColumnBase.DoMouseDown(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  aTable: TfrxTableObject;
begin
  Result := False;
  if ssRight in Shift then Exit;
  aTable := ParentTable;
  if aTable <> nil then
  begin
    aTable.FSelectedRowCol := Self;
    aTable.FSelectedRowColCount := 0;
  end;
  EventParams.SelectionList.Clear;
  EventParams.SelectionList.Add(Self);
  Result := True;
end;

procedure TfrxTableRowColumnBase.DoMouseMove(X, Y: Integer; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
var
  aTable: TfrxTableObject;
  i: Integer;
  FoundColumn: TfrxTableRowColumnBase;
begin
  inherited;
  aTable := ParentTable;
//  if IsSelected then
//    aTable.FSelectedRowCol := Self;


  if aTable <> nil then
  begin
    if not(ssCtrl in Shift) then
    begin
      FoundColumn := nil;
      if aTable.FSelectedRowCol is TfrxTableColumn then
        for i := 0 to aTable.ColumnCount - 1 do
          if aTable.Columns[i].IsContain(X / aTable.FScaleX, Y / aTable.FScaleY)
          then
          begin
            FoundColumn := aTable.Columns[i];
            break;
          end;
      if aTable.FSelectedRowCol is TfrxCustomTableRow then
        for i := 0 to aTable.RowCount - 1 do
          if aTable.Rows[i].IsContain(X / aTable.FScaleX, Y / aTable.FScaleY)
          then
          begin
            FoundColumn := aTable.Rows[i];
            break;
          end;
      if (aTable.FSelectedRowCol <> nil) and (FoundColumn <> nil) and
        (aTable.FSelectedRowCol <> FoundColumn) then
        aTable.FSelectedRowColCount := FoundColumn.
          Index - aTable.FSelectedRowCol.Index
      else
        aTable.FSelectedRowColCount := 0;
    end;
    aTable.DoMouseMove(X, Y, Shift, EventParams);
  end;
end;

procedure TfrxTableRowColumnBase.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  aTable: TfrxTableObject;
  TSelection, i: Integer;
begin
  aTable := ParentTable;
  if aTable = nil then Exit;
  TSelection := aTable.FSelectedRowColCount;
  if (TSelection <> 0) and (aTable.FSelectedRowCol.ClassType = Self.ClassType) then
  begin
    i := aTable.FSelectedRowCol.Index;
    while TSelection <> 0 do
    begin
      EventParams.SelectionList.Add(aTable.GetRowColumnByClass(aTable.FSelectedRowCol.ClassType, i + TSelection));
      if TSelection > 0 then
        Dec(TSelection)
      else
        Inc(TSelection);
    end;
  end;
  aTable.FSelectedRowCol := nil;
  aTable.FSelectedRowColCount := 0;
end;

function TfrxTableRowColumnBase.IsLeftStored: Boolean;
begin
  Result := False;
end;

function TfrxTableRowColumnBase.IsTopStored: Boolean;
begin
  Result := False;
end;

function TfrxTableRowColumnBase.ParentTable: TfrxTableObject;
begin
  Result := Parent as TfrxTableObject;
end;


{ TfrxTableColumn }

constructor TfrxTableColumn.Create(AOwner: TComponent);
var
  t: TfrxTableObject;
begin
  inherited;
  t := ParentTable;
  if Assigned(t) then
    Width := t.FDefaultCellWidth
  else
    Width := DefaultColumnWidth;
  FMinWidth := 0;
  FMaxWidth := 2 * fr1cm;
end;


destructor TfrxTableColumn.Destroy;
var
  t: TfrxTableObject;
begin
  t := ParentTable;
  if Assigned(t) then
  begin
    t.CorrectSpansOnColumnChange(Index, -1);
    inherited;
    t.UpdateDesigner;
  end
  else
  inherited;
end;

procedure TfrxTableColumn.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  aTable: TfrxTableObject;
  Selected, TableSelection: TfrxTableRowColumnBase;
  i, TSelection: Integer;
begin
  aTable := ParentTable;
  Selected := nil;
  if (aTable = nil) then Exit;
  TableSelection := aTable.FSelectedRowCol;
  TSelection := aTable.FSelectedRowColCount;
  inherited;
  if not(TableSelection is TfrxTableColumn) or (TSelection <> 0) then Exit;
  for i := 0 to aTable.ColumnCount - 1 do
    if aTable.Columns[i].IsContain(X / EventParams.Scale, Y / EventParams.Scale) then
      Selected := aTable.Columns[i];
  if (Selected <> nil) and (TableSelection <> Selected) then
  begin
    aTable.MoveColumn(aTable.Objects.IndexOf(Selected), aTable.Objects.IndexOf(TableSelection));
    EventParams.Modified := True;
  end;
end;


function TfrxTableColumn.IsContain(X, Y: Extended): Boolean;
var
  Table: TfrxTableObject;
begin
  Result := inherited IsContain(X, Y);
  Table := ParentTable;
  if (Table <> nil) and (Table.IsDesigning) then
    Result := Result or (AbsLeft <= X) and (AbsLeft + Width >= X) and (AbsTop - 20 <= Y) and (AbsTop + 2 >= Y);
end;

function TfrxTableColumn.IsHeightStored: Boolean;
begin
  Result := False;
end;

{ TfrxTableRow }

constructor TfrxCustomTableRow.Create(AOwner: TComponent);
var
  t: TfrxTableObject;
begin
  inherited;
  t := ParentTable;
  if Assigned(t) then
    Height := t.FDefaultCellHeight
  else
    Height := DefaultRowHeight;
  FMinHeight := 0;
  FMaxHeight := 0;
end;

function TfrxCustomTableRow.CreateTableCell(Index: Integer; bSetUniqueName: Boolean): TObject;
begin
  Result := TfrxTableCell.Create(Self);
  TfrxTableCell(Result).FIndex := Index;
  if bSetUniqueName then
    TfrxTableCell(Result).CreateUniqueName;
end;

destructor TfrxCustomTableRow.Destroy;
var
  t: TfrxTableObject;
//  aReport: TfrxReport;
begin
  t := ParentTable;

  if Assigned(t) then
  begin
    t.CorrectSpansOnRowChange(Index, -1);
//    aReport := t.Report;
//    if t.IsDesigning and (aReport <> nil) and (aReport.Designer <> nil) and not t.FLockObjectsUpdate then
//      aReport.Designer.ReloadObjects(True);
  end;
  inherited;
end;

procedure TfrxCustomTableRow.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  aTable: TfrxTableObject;
  Selected, TableSelection: TfrxTableRowColumnBase;
  i, TSelection: Integer;
begin
  aTable := ParentTable;
  Selected := nil;
  if aTable = nil then Exit;
  TSelection := aTable.FSelectedRowColCount;
  TableSelection := aTable.FSelectedRowCol;
  Inherited;
  if not(TableSelection is TfrxCustomTableRow) or (TSelection <> 0) then Exit;
  for i := 0 to aTable.RowCount - 1 do
    if aTable.Rows[i].IsContain(X / EventParams.Scale, Y / EventParams.Scale) then
      Selected := aTable.Rows[i];
  if (Selected <> nil) and (TableSelection <> Selected) then
  begin
    aTable.InsertRow(Selected.FIndex, TfrxCustomTableRow(TableSelection));
    EventParams.Modified := True;
  end;
end;

function TfrxCustomTableRow.GetCellCount: Integer;
begin
  Result := InternalObjects.Count;
end;

function TfrxCustomTableRow.GetSplitPart(AHeight: Extended; var IsLastPart: Boolean): TfrxCustomTableRow;
var
  i: Integer;
  MaxH, Corr, SaveH: Extended;
  Cell: TfrxTableCell;
  SplitArr: array of Boolean;
  bHasPart, NonEptyPart: Boolean;
begin
  Result := nil;
  if not AllowSplit then Exit;
  MaxH := 0;
  SetLength(SplitArr, CellCount);
  bHasPart := False;
  SaveH := Height;
  NonEptyPart := False;
  for I := 0 to CellCount - 1 do
  begin
    //if not FIsSplit then Cells[i].FSaveHeight := Cells[i].Height;
    Cells[i].Width := Cells[i].CellWidth;
    MaxH := Max( MaxH, Cells[i].SplitObjects(AHeight, SplitArr[i]));
    NonEptyPart := NonEptyPart or SplitArr[i];
    if (MaxH < 1e-4) or (MaxH > AHeight) then
      Cells[i].Height := Cells[i].FSaveHeight
    else
      bHasPart := True;
  end;
  if not NonEptyPart and (MaxH < AHeight) and (AHeight <= SaveH)  then
    MaxH := AHeight
  else if not NonEptyPart and (SaveH < AHeight) and (MaxH < SaveH)  then
    MaxH := SaveH;

  FIsSplit := FIsSplit and (MaxH <= 1E-4);
  if bHasPart or NonEptyPart or (SaveH - MaxH > 1E-4) then
  begin
    Result := TfrxTableRow.Create(nil);
    Result.AssignAllWithOriginals(Self);
    Result.Height := MaxH;
    if SaveH - MaxH <= 1E-4 then
    for I := 0 to Result.CellCount - 1 do
    begin
      Cell := Result.Cells[i];
      Cell.UnlockAnchorsUpdate;
      Corr := MaxH - Cells[i].Height;
      if corr >= 1E-4 then
        Cell.UpdateAnchors(0, Corr);
      Cell.LockAnchorsUpdate;
    end;
  end;
  for I := 0 to CellCount - 1 do
  begin
    Cell := Cells[i];
    Cell.Height := MaxH - Cell.ContainerPadding.BottomPading;
    Cell.FSaveHeight := Cell.FSaveHeight - MaxH;
    Cell.CleanSplit;
    FIsSplit := FIsSplit or SplitArr[i];
  end;
  IsLastPart := not FIsSplit;
  Height := SaveH - MaxH;
end;

function TfrxCustomTableRow.GetCell(Index: Integer): TfrxTableCell;
begin
  if (Index < 0) or (Index > CellCount - 1) then
    Result := nil
  else
  begin
    Result := TfrxTableCell(Objects[Index]);
    Result.FIndex := Index;
  end;
end;

procedure TfrxCustomTableRow.InitCells(Value: Integer);
var
  i, n: Integer;
begin
  n := Value - CellCount;
  if n <= 0 then Exit;
  for i := 0 to n - 1 do
      CreateTableCell(i, ParentTable.FTableBuilder = nil);
  while Value < CellCount do
    Cells[CellCount - 1].Free;
end;

function TfrxCustomTableRow.IsContain(X, Y: Extended): Boolean;
var
  Table: TfrxTableObject;
begin
  Result := inherited IsContain(X, Y);
  Table := ParentTable;
  if (Table <> nil) and (Table.IsDesigning) then
    Result := Result or (AbsTop <= Y) and (AbsTop + Height >= Y) and (AbsLeft - 20 <= X) and (AbsLeft + 2 >= X);
end;


function TfrxCustomTableRow.IsSplitPart: Boolean;
begin
  Result := FIsSplit;
end;

function TfrxCustomTableRow.IsWidthStored: Boolean;
begin
  Result := False;
end;

procedure TfrxCustomTableRow.SetLeft(Value: Extended);
begin
  //calculated by table
  inherited SetLeft(0);
end;

procedure TfrxCustomTableRow.AfterPrint;
begin
  FIsSplit := False;
end;

procedure TfrxCustomTableRow.CorrectCellsOnColumnChange(Index, Correct: Integer);
var
  LTable: TfrxTableObject;
begin
  if Index < 0 then
    Exit;

  if Correct >= 1 then
  begin
    LTable := ParentTable;
    CreateTableCell(Index, Assigned(LTable) and (LTable.FTableBuilder = nil));
    InternalObjects.Move(CellCount - 1, Index);
  end
  else
    Cells[Index].Free;
end;


{ TfrxTableObject }

constructor TfrxTableObject.Create(AOwner: TComponent);
begin
  inherited;
  FDefaultCellHeight := DefaultRowHeight;
  FDefaultCellWidth := DefaultColumnWidth;
  FSelectionFill := TfrxBrushFill.Create;
  with TfrxBrushFill(FSelectionFill) do
  begin
    Style := bsFDiagonal;
    BackColor := clNone;
    ForeColor := clNavy;
  end;
  //FSpanList := nil;
  FLockObjectsUpdate := False;
  frComponentStyle := frComponentStyle + [csObjectsContainer];// + [csContainer, csAcceptsFrxComponents];
  FSelectedGridCol := -1;
  FSelectedGridRow := -1;
  FVertSplitter := -1;
  FHorzSplitter := -1;
  FSelectionStart := Rect(-1, -1, -1, -1);
  FSelectionEnd := Rect(-1, -1, -1, -1);
  FCellsSelection := Rect(-1, -1, -1, -1);
  FBrakeToRows := TList.Create;
end;

function TfrxTableObject.CreateNewColumn(Index: Integer): TfrxTableColumn;
begin
  Result := CreateTableColumn;
  InsertColumn(Index, Result);
end;

function TfrxTableObject.CreateNewRow(Index: Integer): TfrxCustomTableRow;
begin
  Result := CreateTableRow;
  InsertRow(Index, Result);
end;

function TfrxTableObject.CreateTableColumn: TfrxTableColumn;
begin
  Result := TfrxTableColumn.Create(Self);
end;

class function TfrxTableObject.CreateTableRow: TfrxCustomTableRow;
begin
  Result := TfrxTableRow.Create(nil);
end;

function TfrxTableObject.CreateUniqueTableColumn: TfrxTableColumn;
begin
  Result := CreateTableColumn;
  Result.CreateUniqueName;
end;

function TfrxTableObject.CreateUniqueTableRow: TfrxCustomTableRow;
begin
  Result := CreateTableRow;
  Result.CreateUniqueName(Report);
end;

constructor TfrxTableObject.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  FBoundsUpdating := True;
  FLockObjectsUpdate := True;
  frComponentStyle := frComponentStyle;// + [csContainer, csAcceptsFrxComponents];
  ColumnCount := 5;
  RowCount := 5;
  FLockObjectsUpdate := False;
  UpdateDesigner;
end;

destructor TfrxTableObject.Destroy;
begin
  FLockObjectsUpdate := True;
  FLockCorrectSpans := True;
  if FSelectionFill <> nil then
    FreeAndNil(FSelectionFill);
  inherited;
  FLockCorrectSpans := False;
  FLockObjectsUpdate := False;
  FreeAndNil(FBrakeToRows);
end;

procedure TfrxTableObject.DoMirror(MirrorModes: TfrxMirrorControlModes);
var
  x: Integer;
begin
  //inherited;
  if (mcmOnlyAllowed in MirrorModes) and not (IsSelected or AllowMirrorMode) then Exit;
  MirrorContent(MirrorModes);
  if (mcmRTLObjects in MirrorModes) then
    for X := 0 to ColumnCount - 1 do
      if (ColumnCount div 2 > X) then
        MoveColumn(X, ColumnCount - 1 - X);
end;

function TfrxTableObject.DoMouseDown(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i: Integer;
  cSize: Extended;
begin
  Result := inherited DoMouseDown(X, Y, Button, Shift, EventParams);
  if (Button = mbRight) or (not IsTableActive) then Exit;
  FLastMousePos := Point(X, Y);
  if EventParams.EventSender = esPreview then Exit;
  if CheckSizeArrow(X / FScaleX, Y / FScaleY) then
  begin
    FNewColumnDim := 0;
    FNewRowDim := 0;
    FResizeActive := True;
    Result := True;
    EventParams.Refresh := True;
  end;

  if CheckMoveArrow(X / FScaleX, Y / FScaleY) then Exit;
  if CheckRowSelector(X / FScaleX, Y / FScaleY) then
    for i := 0 to RowCount - 1 do
      if Rows[i].IsContain((X + 21) / FScaleX, Y / FScaleY) then
      begin
        EventParams.Refresh := True;
        Result := True;
        Exit;
      end;
  if CheckColumnSelector(X / FScaleX, Y / FScaleY) then
    for i := 0 to ColumnCount - 1 do
      if Columns[i].IsContain(X / FScaleX, (Y + 21) / FScaleY) then
      begin
        EventParams.Refresh := True;
        Result := True;
        Exit;
      end;
  FSelectedGridCol := -1;
  cSize := AbsLeft;
  for i := 0 to ColumnCount - 1 do
  begin
    cSize := cSize + Columns[i].Width;
    if (Abs(cSize - X / FScaleX) < 2) and (Y / FScaleY >= AbsTop) and
      (Y / FScaleY <= AbsTop + Height) then
    begin
      Result := True;
      FSelectedGridCol := i;
      break;
    end;
  end;
  FSelectedGridRow := -1;
  cSize := AbsTop;
  for i := 0 to RowCount - 1 do
  begin
    cSize := cSize + Rows[i].Height;
    if (Abs(cSize - Y / FScaleY) < 2) and (X / FScaleX >= AbsLeft) and
      (X / FScaleX <= AbsLeft + Width) then
    begin
      Result := True;
      FSelectedGridRow := i;
      break;
    end;
  end;
end;

procedure TfrxTableObject.DoMouseEnter(aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  FCellsSelection := Rect(-1, -1, -1, -1);
  if EventParams.EventSender = esPreview then Exit;
  EventParams.Refresh := True;
  FSelectedGridCol := -1;
  FSelectedGridRow := -1;
end;

procedure TfrxTableObject.DoMouseLeave(aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  EventParams.Refresh := (FSelectionStart.Top > -1) and (EventParams.EventSender = esPreview);
  FSelectionStart := Rect(-1, -1, -1, -1);
  FSelectionEnd := Rect(-1, -1, -1, -1);
  FCellsSelection := Rect(-1, -1, -1, -1);
  if EventParams.EventSender = esPreview then
  begin
    Exit;
  end;
  EventParams.Refresh := (FHorzSplitter <> -1) or (FVertSplitter <> -1) or FDragDropActive;
  FVertSplitter := -1;
  FHorzSplitter := -1;
  if FDragDropActive then
  begin
    FDragDropActive := False;
    FSelectedRowCol := nil;
    FSelectedRowColCount := 0;
  end;

end;

procedure TfrxTableObject.DoMouseMove(X, Y: Integer;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  i: Integer;
  cSize: Extended;
  c: TfrxComponent;
  kx, ky: Extended;


  { TODO Move to base class}
  function CheckMove: Boolean;
  var
    al: Boolean;
    function GridCheck: Boolean;
    begin
      Result := (kx >= EventParams.GridX) or (kx <= -EventParams.GridX) or
              (ky >= EventParams.GridY) or (ky <= -EventParams.GridY);
    end;
  begin
    al := EventParams.GridAlign;
    if ssAlt in Shift then
      al := not al;

    Result := False;

    if (al and not GridCheck) or ((kx = 0) and (ky = 0)) then
      Result := True;
    //CheckGuides(kx, ky, Result);
  end;

begin
  inherited;
  FSelectorPoint := Point(X, Y);
  if FSelectionStart.Left <> -1 then
  begin
    c := GetContainedComponent(X / FScaleX, Y / FScaleY);
    if c is TfrxTableCell then
      if not c.IsSelected then
      begin
        FSelectionEnd.Left := TfrxTableCell(c).FIndex;
        FSelectionEnd.Top := TfrxTableCell(c).ParentRow.FIndex;
        FSelectionEnd.Right := FSelectionEnd.Left + TfrxTableCell(c)
          .ColSpan - 1;
        FSelectionEnd.Bottom := FSelectionEnd.Top + TfrxTableCell(c)
          .RowSpan - 1;

        FCellsSelection.Left := FSelectionStart.Left;
        FCellsSelection.Top := FSelectionStart.Top;
        FCellsSelection.Right := FSelectionStart.Right;
        FCellsSelection.Bottom := FSelectionStart.Bottom;

        if FCellsSelection.Left > FSelectionEnd.Left then
          FCellsSelection.Left := FSelectionEnd.Left;
        if FCellsSelection.Top > FSelectionEnd.Top then
          FCellsSelection.Top := FSelectionEnd.Top;

        if FCellsSelection.Right < FSelectionEnd.Right then
          FCellsSelection.Right := FSelectionEnd.Right;
        if FCellsSelection.Bottom < FSelectionEnd.Bottom then
          FCellsSelection.Bottom := FSelectionEnd.Bottom;
      end
      else
        FSelectionEnd := Rect(-1, -1, -1, -1);
    EventParams.Refresh := True;
    Exit;
  end;
  if (EventParams.EventSender = esPreview) or (not IsTableActive) then Exit;

  FColumnSelection := CheckColumnSelector(X / FScaleX, Y / FScaleY) and not CheckMoveArrow(X / FScaleX, Y / FScaleY);
  FRowSelection := CheckRowSelector(X / FScaleX, Y / FScaleY);


  EventParams.Refresh := (FColumnSelection or FRowSelection);
  EventParams.Refresh := EventParams.Refresh or (FHorzSplitter <> -1) or (FVertSplitter <> -1);

  EventParams.Refresh := EventParams.Refresh or (FSelectedGridRow <> -1) or (FSelectedGridCol <> -1);
  cSize := AbsLeft;
  FHorzSplitter := -1;
  if (X > (FX1 + (FDefaultCellWidth * FscaleX))) and FResizeActive then
    FNewColumnDim := Abs(Round((FX1 - X) / (FDefaultCellWidth * FscaleX)));

  for i := 0 to ColumnCount - 1 do
  begin
    cSize := cSize + Columns[i].Width;
    if Columns[i].IsContain(X / FScaleX, AbsTop) and FResizeActive then
      FNewColumnDim := i -(ColumnCount - 1);
    if (Abs(cSize - X / FScaleX) < 2) and (Y / FScaleY >= AbsTop) and
      (Y / FScaleY <= AbsTop + Height) then
    begin
      TWinControl(EventParams.Sender).Cursor := crHSplit;
      FHorzSplitter := i;
      break;
    end;
  end;

  FVertSplitter := -1;
  if (Y > (FY1 + (FDefaultCellHeight * FScaleY))) and FResizeActive then
    FNewRowDim := Abs(Round((FY1 - Y) / (FDefaultCellHeight * FScaleY)));
  cSize := AbsTop;
  for i := 0 to RowCount - 1 do
    begin
      cSize := cSize + Rows[i].Height;
      if Rows[i].IsContain(AbsLeft, Y / FScaleY) and FResizeActive then
        FNewRowDim := i -(RowCount - 1);
      if (Abs(cSize - Y / FScaleY) < 2) and (X / FScaleX >= AbsLeft) and
        (X / FScaleX <= AbsLeft + Width) then
      begin
        TWinControl(EventParams.Sender).Cursor := crVSplit;
        FVertSplitter := i;
        break;
      end;
    end;
  if (FVertSplitter <> -1) and (FHorzSplitter <> -1) then
    TWinControl(EventParams.Sender).Cursor := crSizeNWSE;

  EventParams.Refresh := EventParams.Refresh or (FHorzSplitter <> -1) or (FVertSplitter <> -1) or (FNewColumnDim <> 0)or (FNewRowDim <> 0);
  if (FSelectedGridRow <> -1) or (FSelectedGridCol <> -1) then
  begin
    kx := (X - FLastMousePos.X) / FScaleX;
    ky := (Y - FLastMousePos.Y) / FScaleY;
    if CheckMove then
      Exit;

    if FSelectedGridCol <> -1 then
    begin
      Columns[FSelectedGridCol].Width := Columns[FSelectedGridCol].Width +
        kx;
      FModified := (X <> FLastMousePos.X);
    end;

    if FSelectedGridRow <> -1 then
    begin
      Rows[FSelectedGridRow].Height := Rows[FSelectedGridRow].Height +
        ky;
      FModified := (X <> FLastMousePos.X);
    end;

    FLastMousePos := Point(X, Y);
  end;
end;

procedure TfrxTableObject.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  cx, ry: Integer;
  c: TfrxTableCell;
begin
  inherited;
  if Assigned(EventParams.SelectionList) and (FSelectionStart.Left <> -1) and (FSelectionEnd.Left <> -1) then
  begin
    EventParams.SelectionList.Clear;
    for cx := FCellsSelection.Left to FCellsSelection.Right do
      for ry := FCellsSelection.Top to FCellsSelection.Bottom do
      begin
        c := Cells[cx, ry];
        if not c.IsSelected and Assigned(EventParams.SelectionList) then
        begin
          EventParams.SelectionList.Add(c);
        end;
      end;
  end;
  FSelectionStart := Rect(-1, -1, -1, -1);
  FSelectionEnd := Rect(-1, -1, -1, -1);
  FCellsSelection := Rect(-1, -1, -1, -1);
  if EventParams.EventSender = esPreview then Exit;
  EventParams.Modified := (((FSelectedGridRow <> -1) or (FSelectedGridCol <> -1)) and FModified);
  FSelectedGridCol := -1;
  FSelectedGridRow := -1;
  FModified := False;
  FSelectedRowCol := nil;
  FSelectedRowColCount := 0;

  if FResizeActive and ((FNewRowDim <> 0) or (FNewColumnDim <> 0)) then
  begin
    FCopyAppearance := True;
    FLockObjectsUpdate := True;
    try
      RowCount := RowCount + FNewRowDim;
      ColumnCount := ColumnCount + FNewColumnDim;
    finally
      FCopyAppearance := False;
      FLockObjectsUpdate := False;
      UpdateDesigner;
    end;
    EventParams.Modified := True;
  end;

  FNewColumnDim := 0;
  FNewRowDim := 0;
  FResizeActive := False;
end;

procedure TfrxTableObject.NormalizeObjectsList;
var
  i: Integer;
  cl, rl: TList;
begin
  // This method is called every time when a row/column is added, or removed from the table
  // Columns and rows are in the objects list. Newly added items are at the end of a list, so we
  // need to sort the list so it will contain columns, then rows
  cl := TList.Create;
  rl := TList.Create;
  try
    for i := 0 to Objects.Count - 1 do
    begin
      if TfrxComponent(Objects[i]) is TfrxTableColumn then
        cl.Add(Objects[i])
      else if TfrxComponent(Objects[i]) is TfrxCustomTableRow then
        rl.Add(Objects[i]);
    end;

    Objects.Clear;
    for i := 0 to cl.Count - 1 do
      Objects.Add(cl[i]);
    for i := 0 to rl.Count - 1 do
      Objects.Add(rl[i]);

    // Update FColumnCount, FRowCount
    FColumnCount := cl.Count;
    FRowCount := rl.Count;
  finally
    cl.Free;
    rl.Free;
  end;
end;

function TfrxTableObject.GetColumn(Index: Integer): TfrxTableColumn;
begin
  if (Index < 0) or (Index > ColumnCount - 1) then
    Result := nil
  else
  begin
    Result := TfrxTableColumn(Objects[Index]);
    Result.FIndex := Index;
  end;
end;

function TfrxTableObject.GetContainedComponent(X, Y: Extended;
  IsCanContain: TfrxComponent): TfrxComponent;
var
  i: Integer;
  c: TfrxComponent;
begin
  // do not use default TfrxComponent method here
  // for table we have to check from the first row, because of RowSpan
  Result := nil;
  if IsContain(X, Y){ or (RowCount > 0) }then
  begin
    if (RowCount = 0) or IsContain(X, Y) then
      Result := Self;
    if not(CheckMoveArrow(X, Y) or CheckSizeArrow(X, Y)) or Assigned(IsCanContain) then
    begin
      for i := 0 to ColumnCount - 1 do
      begin
        c := Columns[i].GetContainedComponent(X, Y, IsCanContain);
        if (c <> nil) then
        begin
          Result := c;
          break;
        end;
      end;

      for i := 0 to RowCount - 1 do
      begin
        c := Rows[i].GetContainedComponent(X, Y, IsCanContain);
        if (c <> nil) then
        begin
          Result := c;
          break;
        end;
      end;
    end;
  end;
  if (Result = Self) and ((IsCanContain = Self) or
    (not IsAcceptControl(IsCanContain))) then
    Result := nil;
end;

function TfrxTableObject.GetRow(Index: Integer): TfrxCustomTableRow;
begin
  if (Index < 0) or (Index > RowCount - 1) then
    Result := nil
  else
  begin
    Result := TfrxCustomTableRow(Objects[ColumnCount + Index]);
    Result.FIndex := Index;
  end;
end;

function TfrxTableObject.GetRowColumnByClass(aClass: TClass;
  Index: Integer): TfrxTableRowColumnBase;
begin
  Result := nil;
  if aClass.InheritsFrom(TfrxCustomTableRow) then
    Result := Rows[Index];
  if aClass = TfrxTableColumn then
    Result := Columns[Index];
end;

function TfrxTableObject.GetSaveToComponent: TfrxReportComponent;
begin
//  if Assigned(FBrakeTo) then
//    Result := FBrakeTo
//  else
    Result := Inherited GetSaveToComponent;
end;

function TfrxTableObject.GetSplitRow(ARow: TfrxCustomTableRow;
  AHeight: Extended; var IsLastPart: Boolean): TfrxCustomTableRow;
begin
  Result := ARow.GetSplitPart(AHeight, IsLastPart);
  if Assigned(Result) then
    Result.FIndex := ARow.Index;
end;

function TfrxTableObject.GetTableBuilder: TfrxCustomTableBuilder;
begin
  if not Assigned(FTableBuilder) then
  begin
    if not FIsManualBuild then raise Exception.Create('The table builder availeble only in OnManualBuild event');
    FSavedTable := TfrxStateTableObject.Create(Report);
    FSavedTable.AssignOriginals(Self);
    MoveRowsColumns(FSavedTable, True);
    FSavedTable.UpdateBounds;
    FTableBuilder := TfrxCustomTableBuilder(frxTableBuilder.NewInstance);
    FSavedTable.FTableBuilder := FTableBuilder;
    FTableBuilder.Create(FSavedTable);
  end;
  Result := FTableBuilder;
end;

function TfrxTableObject.GetTableHeight: Extended;
begin
  Result := Height;
end;

function TfrxTableObject.GetTableWidth: Extended;
begin
  Result := Width;
end;

function TfrxTableObject.HasNextDataPart(aFreeSpace: Extended): Boolean;
begin
  Result := Inherited HasNextDataPart(aFreeSpace) and (FBreakRowIndex < FBrakeTo.FRowCount);
end;

function TfrxTableObject.GetCell(X, Y: Integer): TfrxTableCell;
var
  R: TfrxCustomTableRow;
begin
  Result := nil;
  R := Rows[Y];
  if R <> nil then
    Result := R.Cells[X];
end;

procedure TfrxTableObject.SetColumnCount(Value: Integer);
var
  i, j, n, x, y: Integer;
  cc: TfrxTableCell;
begin
  FLockObjectsUpdate := True;
  FLockCorrectSpans := True;
  try
    n := Value - ColumnCount;
    for i := 0 to n - 1 do
    begin
      AddColumn(CreateUniqueTableColumn);
      if FCopyAppearance and (ColumnCount > 1) then
        for j := 0 to RowCount - 1 do
          AssignCellAppearance(Cells[ColumnCount - 2, j],
            Cells[ColumnCount - 1, j]);
    end;
    while Value < ColumnCount do
      DeleteColumn(ColumnCount - 1);

    if n < 0 then
      for y := 0 to RowCount - 1 do
        for X := 0 to ColumnCount - 1 do
        begin
          cc := Cells[X, Y];
          if ColumnCount < X + cc.ColSpan then
            cc.ColSpan := cc.ColSpan + n;
        end;
  finally
    FLockObjectsUpdate := False;
    FLockCorrectSpans := False;
    UpdateDesigner;
  end;
end;

procedure TfrxTableObject.SetHeight(Value: Extended);
begin
  if not FBoundsUpdating and IsDesigning then
  begin
    if SameValue(Value, Height, 0.01) then Exit;
    SetTableHeight(Value);
  end;
  inherited
end;

procedure TfrxTableObject.SetRowCount(Value: Integer);
var
  i, j, n: Integer;
begin
  FLockObjectsUpdate := True;
  FLockCorrectSpans := True;
  n := Value - RowCount;
  try
    for i := 0 to n - 1 do
    begin
      AddRow(CreateUniqueTableRow);
      if FCopyAppearance and (RowCount > 1) then
        for j := 0 to ColumnCount - 1 do
          AssignCellAppearance(Cells[j, RowCount - 2], Cells[j, RowCount - 1]);
    end;
    while Value < RowCount do
      DeleteRow(RowCount - 1);
  finally
    FLockObjectsUpdate := False;
    FLockCorrectSpans := False;
    if n < 0 then
      CorrectSpansOnRowChange(Value, n);
    UpdateDesigner;
  end;
end;

procedure TfrxTableObject.SetSpanFillList(const SpanList: PfrxRectArray);
begin
  FSpanList := SpanList;
end;

procedure TfrxTableObject.SetTableHeight(const Value: Extended);
var
  i: Integer;
  dx: Extended;
begin
  dx := (Value - Height) / RowCount;
  for I := 0 to RowCount - 1 do
    Rows[i].Height := Rows[i].Height + dx;
  UpdateBounds;
end;

procedure TfrxTableObject.SetTableWidth(const Value: Extended);
var
  dx: Extended;
  i: Integer;
begin
  dx := (Value - Width) / ColumnCount;
  for I := 0 to ColumnCount - 1 do
    Columns[i].Width := Columns[i].Width + dx;
  UpdateBounds;
end;

procedure TfrxTableObject.SetWidth(Value: Extended);
begin
  if not FBoundsUpdating and IsDesigning then
  begin
    if SameValue(Value, Width, 0.01) then Exit;
    SetTableWidth(Value);
  end;
  inherited;
end;

procedure TfrxTableObject.SplitCell(aCell: TfrxTableCell);
begin
  aCell.ColSpan := 1;
  aCell.RowSpan := 1;
end;

procedure TfrxTableObject.SplitSelected;
var
  c: TfrxTableCell;
  x, y: Integer;
begin
  c := nil;
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      if c.IsSelected then
        break;
      c := nil;
    end;
  if (c <> nil) then
  begin
    c.RowSpan := 1;
    c.ColSpan := 1;
  end;
end;

procedure TfrxTableObject.SwapRows(Row1, Row2: Integer);
begin
  if not((Row1 >= 0) and (Row1 < RowCount) and (Row2 >= 0) and (Row2 < RowCount)) then
    Exit;

//  begin
//    // we need this to be sure that the new item is added at the end of list
//    // note: this will also normalize the objects list
//    Value.Parent := nil;
//    Value.Parent := Self;
//    // now move the item. take into account "columns, then rows" order in the objects list
//    Objects.Move(Objects.Count - 1, ColumnCount + Index);
//    //Value.InitCells(ColumnCount);
//    //CorrectSpansOnRowChange(Index, 1);
//    if (Report <> nil) and (Report.Designer <> nil) and not FLockObjectsUpdate then
//      Report.Designer.ReloadObjects(False);
//  end;
//
end;

//function TfrxTableObject.ContainerAdd(Obj: TfrxComponent): Boolean;
//var
//  X, Y: Integer;
//begin
//  Result := False;
//  if csContained in Obj.frComponentStyle then
//    Exit;
//  for X := 0 to ColumnCount - 1 do
//    for Y := 0 to RowCount - 1 do
//      if Cells[X, Y].IsContain(Obj.AbsLeft, Obj.AbsTop) then
//      begin
//        if Obj.Parent =  Cells[X, Y] then Exit;
//        //if Obj.Owner <> nil then
//        //  Obj.Owner.RemoveComponent(Obj);
//        Obj.Parent := Cells[X, Y];
//        Obj.Left := Obj.Left - (Left + Cells[X, Y].Left);
//        Obj.Top := Obj.Top - (Top + Rows[Y].Top);
//        Result := True;
//        //NormalizeObjectsList;
//        if (Report <> nil) and (Report.Designer <> nil) and not FLockObjectsUpdate
//        then
//          Report.Designer.ReloadObjects(False);
//        Exit;
//      end;
//end;

procedure TfrxTableObject.CorrectSpansOnColumnChange(ColumnIndex, Correct: Integer);
var
  x, y: Integer;
  c: TfrxTableCell;
begin
  //if FLockCorrectSpans then Exit;

  if ColumnIndex > ColumnCount then
    ColumnIndex := ColumnCount;

  for y := 0 to RowCount - 1 do
  begin
    Rows[Y].CorrectCellsOnColumnChange(ColumnIndex, Correct);
    if not FLockCorrectSpans then
      for X := 0 to ColumnIndex - 1 do
      begin
        c := Cells[X, Y];
        if c.Name = '' then
          c.CreateUniqueName;
        if ColumnIndex < X + c.ColSpan then
          c.ColSpan := c.ColSpan + Correct;
      end;
  end;

  if not FLockCorrectSpans then
    ResetSpanList;
end;

procedure TfrxTableObject.CorrectSpansOnRowChange(RowIndex, Correct: Integer);
var
  x, y: Integer;
  c: TfrxTableCell;
begin
  if FLockCorrectSpans then
    Exit;
  if RowIndex > RowCount then
    RowIndex := RowCount;

  for y := 0 to RowIndex - 1 do
    for x := 0 to ColumnCount - 1 do
    begin
      c := Cells[x, y];
      if RowIndex < y + c.RowSpan then
        c.RowSpan := c.RowSpan + Correct;
    end;

  ResetSpanList;
end;

procedure TfrxTableObject.ResetSpanList;
begin
//  SetLength(FSpanList, 0);
end;

procedure TfrxTableObject.RestoreAfterBuilder;
begin
  FreeAndNil(FTableBuilder);
  If Assigned(FSavedTable) then
  begin
    FLockCorrectSpans := True;
    Objects.Clear;
    FRowCount := 0;
    FColumnCount := 0;
    FSavedTable.MoveRowsColumns(Self, True);

    FLockCorrectSpans := False;
    UpdateBounds;
    FreeAndNil(FSavedTable);
  end;
end;

procedure TfrxTableObject.RestoreBreakTable;
var
  i: Integer;
begin
  FLockCorrectSpans := True;
  try
    for i := 0 to Objects.Count - 1 do
      if FBrakeToRows.IndexOf(Objects[i]) < 0 then
        TfrxHackComponent(Objects[i]).FParent := FBrakeTo;
    ClearBrakeToRows;
    Objects.Clear;
  finally
    FLockCorrectSpans := False;
  end;
end;

procedure TfrxTableObject.RestoreSourceTable;
var
  i: Integer;
begin
  FBrakeTo.LockObjectsUpdate;
  try
    for i := 0 to FBrakeTo.Objects.Count - 1 do
//      if FBrakeToRow <> FBrakeTo.Objects[i] then
      if FBrakeToRows.IndexOf(FBrakeTo.Objects[i]) < 0 then
      begin
        TfrxHackComponent(FBrakeTo.Objects[i]).FParent := Self;
        Objects.Add(FBrakeTo.Objects[i]);
      end;
    //FreeAndNil(FBrakeToRow);
    ClearBrakeToRows;
    FBrakeTo.Objects.Clear;
  finally
    FBrakeTo.UnlockObjectsUpdate;
  end;
end;

procedure TfrxTableObject.FillSpanList(var SpanList: TfrxRectArray);
var
  x, y, cnt: Integer;
  c: TfrxTableCell;
begin
  if Length(SpanList) > 0 then
    Exit;

  NormalizeSpans;
  cnt := 0;
  SetLength(SpanList, ColumnCount * RowCount);

  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      if (c.ColSpan > 1) or (c.RowSpan > 1) then
      begin
        SpanList[cnt] := Rect(x, y, x + c.ColSpan, y + c.RowSpan);
        Inc(cnt);
      end;
    end;

  SetLength(SpanList, cnt);
end;

function TfrxTableObject.IsInsideSpan(SpanList: TfrxRectArray; p: TPoint): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Length(SpanList) - 1 do
    if PtInRect(SpanList[i], p) and not PointsEqual(SpanList[i].TopLeft, p) then
    begin
      Result := True;
      Exit;
    end;
end;

function TfrxTableObject.IsTableActive: Boolean;
begin
  Result := FTableActive or IsSelected or FDragDropActive;
end;

function TfrxTableObject.IsWidthStored: Boolean;
begin
  Result := False;
end;

procedure TfrxTableObject.JoinSelection(TopX: Integer; TopY: Integer; BottomX: Integer; BottomY: Integer);
var
  x, y: Integer;
  c: TfrxTableCell;
begin
  if (TopX = MaxInt) or (TopY = MaxInt) or (BottomX = -1) or (BottomY = -1) then
    for X := 0 to ColumnCount - 1 do
      for Y := 0 to RowCount - 1 do
      begin
        c := Cells[X, Y];
        if c.IsSelected then
        begin
          if X < TopX then
            TopX := X;
          if Y < TopY then
            TopY := Y;
          if X > BottomX then
            BottomX := X;
          if Y > BottomY then
            BottomY := Y;
        end;
      end;
  if (TopX <> MaxInt) and (TopY <> MaxInt) and (BottomX > -1) and (BottomY > -1) then
  begin
    c := Cells[TopX, TopY];
    c.ColSpan := BottomX - TopX + 1;
    c.RowSpan := BottomY - TopY + 1;
  end;
end;

procedure TfrxTableObject.Loaded;
begin
  inherited;
  UpdateBounds;
end;

procedure TfrxTableObject.LockObjectsUpdate;
begin
  FLockCorrectSpans := True;
  Objects.OnNotifyList := nil;
end;

procedure TfrxTableObject.MoveColumn(Index, NewIndex: Integer);
var
  i: Integer;
begin
  Objects.Exchange(Index, NewIndex);
  for i := 0 to RowCount - 1 do
    Rows[i].Objects.Exchange(Index, NewIndex);
  NormalizeSpans;
end;

procedure TfrxTableObject.MoveRowsColumns(DestTable: TfrxTableObject; bClearSource: Boolean;
  RowStartIndex, RowEndIndex, ColStartIndex, ColEndIndex: Integer);
var
  i: Integer;
begin
  for i := 0 to Objects.Count - 1 do
  begin
    TfrxHackComponent(Objects[i]).FParent := DestTable;
    DestTable.Objects.Add(Objects[i]);
  end;
  if bClearSource then
  begin
    FLockCorrectSpans := True;
    Objects.Clear;
    FLockCorrectSpans := False;
  end;
  //DestTable.UpdateBounds;
end;

procedure TfrxTableObject.NormalizeSpans;
var
  x, y, x1, y1, Idx: Integer;
  c: TfrxTableCell;
begin
  // Mainly needed after load a report to be sure that spans don't go outside the table bounds
  // (bounds checking is off during load).
  // In normal scenarios, spans are checked in the property setters.
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      c.ColSpan := c.ColSpan;
      c.RowSpan := c.RowSpan;
      c.FHidden := False;
    end;
  Idx := 0;
  if Assigned(FSpanList) then
    SetLength(FSpanList^, ColumnCount * RowCount);
  // set Hidden flag for cells inside spans
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      if c.FHidden then
        continue;
      if (c.ColSpan > 1) or (c.RowSpan > 1) then
      begin
        if Assigned(FSpanList) then
        begin
          FSpanList^[Idx] := Rect(x, y, x + c.ColSpan, y + c.RowSpan);
          Inc(Idx);
        end;
        for x1 := x to x + c.ColSpan - 1 do
          for y1 := y to y + c.RowSpan - 1 do
            if (x1 <> x) or (y1 <> y) then
              Cells[x1, y1].FHidden := True;
      end;
    end;
  if Assigned(FSpanList) then
  begin
    SetLength(FSpanList^, Idx);
    FSpanList := nil;// fill only once
  end;
end;

procedure TfrxTableObject.ObjectListNotify(Ptr: Pointer;
  Action: TListNotification);
var
  aIncremental: Integer;
begin
  inherited;
  aIncremental := 0;
  if Action = lnAdded then
    aIncremental := 1
  else if Action = lnDeleted then
    aIncremental := -1;
  if TObject(Ptr) is TfrxTableColumn then
    FColumnCount := FColumnCount + aIncremental
  else if TObject(Ptr) is TfrxCustomTableRow then
    FRowCount := FRowCount + aIncremental;
end;

procedure TfrxTableObject.CalcWidthInternal;
var
  x, y, i: Integer;
  colWidth, cellWidth, tableWidth: Extended;
  col: TfrxTableColumn;
  c: TfrxTableCell;
begin
  // first pass, calc non-spanned cells
  for x := 0 to ColumnCount - 1 do
  begin
    col := Columns[x];
    if not col.AutoSize then
      continue;
    colWidth := col.MinWidth;
    if IsDesigning then
      colWidth := 16;

    // calc the max column width
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      if not c.FHidden and (c.ColSpan = 1) and not ((c.Rotation = 90) or (c.Rotation = 270)) then
      begin
        cellWidth := c.CalcWidth;
        if cellWidth > colWidth then
          colWidth := cellWidth;
      end;
    end;

    // update column width
    if (colWidth > col.MaxWidth) and (col.MaxWidth > 0)then
      colWidth := col.MaxWidth;
    if colWidth <> -1 then
      col.Width := colWidth;
  end;

  // second pass, calc spanned cells
  for x := 0 to ColumnCount - 1 do
  begin
//    Columns[x].MinimumBreakWidth = 0;
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      if not c.FHidden and (c.ColSpan > 1) then
      begin
        cellWidth := c.CalcWidth;
//        if (AdjustSpannedCellsWidth && cellWidth > Columns[x].MinimumBreakWidth)
//          Columns[x].MinimumBreakWidth = cellWidth;

        // check that spanned columns have enough width
        colWidth := 0;
        for i := 0 to c.ColSpan - 1 do
          colWidth := colWidth + Columns[x + i].Width;

        // if cell is bigger than sum of column widths, increase one of the columns.
        // check columns with AutoSize flag only, starting from the last one
        if cellWidth > colWidth then
          for i := c.ColSpan - 1 downto 0 do
          begin
            col := Columns[x + i];
            if col.AutoSize then
            begin
              col.Width := col.Width + (cellWidth - colWidth);
              break;
            end;
          end;
      end;
      { update anchors }
      c.UnlockAnchorsUpdate;
      c.Width := c.CellWidth;
    end;
  end;

  // finally, calculate the table width
  tableWidth := 0;
  for i := 0 to ColumnCount - 1 do
    tableWidth := tableWidth + Columns[i].Width;

//  FLockColumnRowChange = true;
  FBoundsUpdating := True;
  Width := tableWidth;
//  FLockColumnRowChange = false;
  FBoundsUpdating := False;
end;

function TfrxTableObject.CheckColumnSelector(X, Y: Extended): Boolean;
begin
  Result := (AbsLeft <= X) and (AbsLeft + Width >= X) and (AbsTop - 20 <= Y) and (AbsTop + 2 >= Y);
end;

function TfrxTableObject.CheckMoveArrow(X, Y: Extended): Boolean;
begin
  Result := (AbsLeft <= X) and (AbsLeft + 16 >= X) and (AbsTop - 6 <= Y) and (AbsTop + 16 >= Y);
end;

function TfrxTableObject.CheckRowSelector(X, Y: Extended): Boolean;
begin
  Result := (AbsTop <= Y) and (AbsTop + Height >= Y) and (AbsLeft - 20 <= X) and (AbsLeft + 2 >= X);
end;

function TfrxTableObject.CheckSizeArrow(X, Y: Extended): Boolean;
begin
  Result := (AbsLeft + Width + 2 <= X) and (AbsLeft + Width + 24 >= X) and (AbsTop + Height + 24 >= Y) and (AbsTop + Height + 2 <= Y);
end;

procedure TfrxTableObject.Clear;
begin
  FLockCorrectSpans := True;
  try
    inherited;
  finally
    FLockCorrectSpans := False;
    NormalizeObjectsList;
  end;
end;

procedure TfrxTableObject.ClearBrakeToRows;
begin
  while FBrakeToRows.Count > 0 do
  begin
    TObject(FBrakeToRows[0]).Free;
    FBrakeToRows.Delete(0);
  end;
end;

procedure TfrxTableObject.CalcHeightInternal;
var
  x, y, i: Integer;
  rowHeight, cellHeight, cellWidth, tableHeight: Extended;
  row: TfrxCustomTableRow;
  c: TfrxTableCell;
begin
  // first pass, calc non-spanned cells
  for y := 0 to RowCount - 1 do
  begin
    row := Rows[y];
    if not row.AutoSize then
      continue;
    rowHeight := row.MinHeight;
    if IsDesigning then
      rowHeight := 16;

    // calc max row height
    for x := 0 to ColumnCount - 1 do
    begin
      c := Cells[x, y];
      if not c.FHidden and (c.RowSpan = 1) then
      begin
        c.UnlockAnchorsUpdate;
        c.Width := c.CellWidth;
        cellHeight := c.CalcHeight();
        if cellHeight > rowHeight then
          rowHeight := cellHeight;
      end;
    end;

    if (rowHeight > row.MaxHeight) and (row.MaxHeight > 0) then
      rowHeight := row.MaxHeight;
    // update row height
    if rowHeight <> -1 then
      row.Height := rowHeight;
  end;

  // second pass, calc spanned cells
  for y := 0 to RowCount - 1 do
  begin
    for x := 0 to ColumnCount - 1 do
    begin
      c := Cells[x, y];
      if not c.FHidden and (c.RowSpan > 1) then
      begin
        c.Width := c.CellWidth;
        cellHeight := c.CalcHeight();

        // check that spanned rows have enough height
        rowHeight := 0;
        for i := 0 to c.RowSpan - 1 do
          rowHeight := rowHeight + Rows[y + i].Height;

        // if cell is bigger than sum of row heights, increase one of the rows.
        // check rows with AutoSize flag only, starting from the last one
        if cellHeight > rowHeight then
          for i := c.RowSpan - 1 downto 0 do
          begin
            row := Rows[y + i];
            if row.AutoSize then
            begin
              row.Height := row.Height + (cellHeight - rowHeight);
              break;
            end;
          end;
      end;
      if (c.Rotation = 90) or (c.Rotation = 270) then
      begin
        c.Height := Rows[y].Height;
        cellWidth := c.CalcWidth;
        if (cellWidth > Columns[x].Width) then
        begin
          if cellWidth > Columns[x].MaxWidth then
            cellWidth := Columns[x].MaxWidth;
          Columns[x].Width := cellWidth;
        end;
      end;
      { update anchors }
      UpdateCellDimensions(c);
    end;
  end;

  // finally, calculate the table height
  tableHeight := 0;
  for i := 0 to RowCount - 1 do
    tableHeight := tableHeight + Rows[i].Height;
  FBoundsUpdating := True;
  Height := tableHeight;
  FBoundsUpdating := False;
end;

procedure TfrxTableObject.UnlockObjectsUpdate;
begin
  FLockCorrectSpans := False;
  Objects.OnNotifyList := ObjectListNotify;
end;

procedure TfrxTableObject.UpdateBounds;
var
  x, y: Integer;
  l, t: Extended;
  c: TfrxTableCell;
begin
  NormalizeSpans;

  l := 0;
  t := 0;
  for x := 0 to ColumnCount - 1 do
  begin
    t := 0;
    Columns[x].Left := l;
    for y := 0 to RowCount - 1 do
    begin
      Rows[y].Top := t;
      c := Cells[x, y];
      c.Left := l;
      UpdateCellDimensions(c);
      //c.Visible := not c.FHidden;
      //if IsPrinting and not c.Printable then
      //  c.Visible := False;
      //if not c.Visible then
      if IsPrinting and not c.Printable or c.FHidden then
      begin
        c.Width := 0;
        c.Height := 0;
      end;
      t := t + Rows[y].Height;
    end;
    l := l + Columns[x].Width;
  end;
  FBoundsUpdating := True;
  LockAnchorsUpdate;
  Width := l;
  Height := t;
  UnlockAnchorsUpdate;
  FBoundsUpdating := False;
  for x := 0 to ColumnCount - 1 do
    Columns[x].Height := t;
  for y := 0 to RowCount - 1 do
    Rows[y].Width := l;
end;

procedure TfrxTableObject.UpdateCellDimensions(cell: TfrxTableCell);
begin
  cell.UnlockAnchorsUpdate;
  cell.Width := cell.CellWidth;
  cell.UnlockAnchorsUpdate;
  cell.Height := cell.CellHeight;
end;

procedure TfrxTableObject.UpdateDesigner;
begin
  if not FLockObjectsUpdate and IsDesigning and (Report <> nil) and
    (Report.Designer <> nil) then
    Report.Designer.ReloadObjects(False);
end;

procedure TfrxTableObject.DrawTable(Highlighted: Boolean);
var
  x, y, dx, dy, RowH, ColW, i: Integer;
  c: TfrxTableCell;
  IsRowColumnSelected: Boolean;
  SelColor: TColor;
  SelectionDir, cSel: Integer;
  aReport: TfrxReport;

  procedure DrawLine(x, y, dx, dy: Extended);
  begin
    FCanvas.Pen.Width := 1;
    FCanvas.Pen.Color := clAqua;
    FCanvas.MoveTo(Round(x * FScaleX), Round(y * FScaleY));
    FCanvas.LineTo(Round((x + dx) * FScaleX), Round((y + dy) * FScaleY));
  end;

begin
  // update rows and columns positions, also cells bounds
  UpdateBounds;
  aReport := GetGlobalReport;
  // draw background
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      if not c.FHidden and (((vsPreview in c.Visibility) and not IsPrinting) or
        (IsPrinting and (vsPrint in c.Visibility))) then
      begin
        c.BeginDraw(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
        c.DrawBackground;
        c.DrawFrame;
      end;
    end;

//  // draw frame
//  for x := 0 to ColumnCount - 1 do
//    for y := 0 to RowCount - 1 do
//    begin
//      c := Cells[x, y];
//      if c.Visible then
//        c.DrawFrame;
//    end;

  // draw text
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
    begin
      c := Cells[x, y];
      SelColor := clSkyBlue;
      IsRowColumnSelected := False;
      { TODO: make boolean expression compact }
      if FSelectedRowColCount = 0 then
      begin
        { Row drag exchange selector}
        IsRowColumnSelected := ((FSelectedRowCol Is TfrxCustomTableRow) and (Rows[y].IsContain(FSelectorPoint.X / FScaleX, FSelectorPoint.Y / FScaleY)) and ((FSelectedRowCol <> Rows[y]) or not FSelectedRowCol.IsSelected));
        { Column drag exchange selector}
        IsRowColumnSelected := (IsRowColumnSelected or ((FSelectedRowCol Is TfrxTableColumn) and (Columns[x].IsContain(FSelectorPoint.X / FScaleX, FSelectorPoint.Y / FScaleY)) and ((FSelectedRowCol <> Columns[x]) or not FSelectedRowCol.IsSelected)));
      end;
      if IsRowColumnSelected then
        SelColor := clPurple;
      IsRowColumnSelected := IsRowColumnSelected or (FResizeActive and ((ColumnCount + FNewColumnDim - 1 >= x) and (RowCount + FNewRowDim - 1 >= y)));
      IsRowColumnSelected := IsRowColumnSelected or (Columns[x].IsSelected or Rows[y].IsSelected or c.IsSelected);
      if FSelectedRowColCount <> 0  then
      begin
      SelectionDir := 1;
      if FSelectedRowColCount < 0 then
        SelectionDir := -1;
        cSel := Y;
        if (FSelectedRowCol Is TfrxTableColumn) then
          cSel := X;
        cSel := cSel * SelectionDir;
        IsRowColumnSelected := IsRowColumnSelected or ((FSelectedRowCol.Index * SelectionDir < cSel) and ((FSelectedRowCol.Index + FSelectedRowColCount) * SelectionDir >= cSel));
      end;
      if (FSelectionStart.Left <> -1) and (FSelectionEnd.Left <> -1) then
        IsRowColumnSelected := IsRowColumnSelected or ((FCellsSelection.Left <= X) and (FCellsSelection.Right >= X) and (FCellsSelection.Top <= Y) and (FCellsSelection.Bottom >= Y));
      if not c.FHidden and (((vsPreview in c.Visibility) and not IsPrinting) or
        (IsPrinting and (vsPrint in c.Visibility))) then
      begin
        c.IsDesigning := IsDesigning;
        c.IsPrinting := IsPrinting;
        try
          c.FVC := FVC;
          if Assigned(aReport) then
          begin
            c.FCopyNo := aReport.PreviewPages.PrintCopyNo;
            c.FTotalPages := aReport.PreviewPages.Count;
            c.FPrintScale := aReport.PreviewPages.PrintScale;
          end;
          c.DrawText;
        finally
          c.FVC := nil;
        end;
        if IsRowColumnSelected then
          c.DrawSelected(SelColor);
//        if Highlighted then
//          c.DrawHighlight(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
        if {(c.IsDesigning and c.DrawHighlights and c.IsSelected) or} Highlighted or
            (not c.IsDesigning and c.IsSelected) then
            c.DrawHighlight(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
        if FObjAsMetafile then
          for i := 0 to c.Objects.Count - 1 do
          begin
            TfrxHackView(c.Objects[i]).FVC := FVC;
            try
              TfrxView(c.Objects[i]).Draw(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
            finally
              TfrxHackView(c.Objects[i]).FVC := nil;
            end;
          end;
      end;
      if IsTableActive and IsDesigning then
      begin
        if FColumnSelection then
          frxImages.MainButtonImages.Draw(FCanvas, FSelectorPoint.X,
            FY - 20, 112);
        if FRowSelection then
          frxImages.MainButtonImages.Draw(FCanvas, FX - 20,
            FSelectorPoint.Y, 111);
      end;
      if y = FVertSplitter then
        DrawLine(AbsLeft + FOffsetX, Rows[y].AbsTop + Rows[y].Height + FOffsetY, Width, 0)
      else if x = FHorzSplitter then
        DrawLine(Columns[x].AbsLeft + Columns[x].Width + FOffsetX, AbsTop + FOffsetY, 0, Height);
    end;
  // draw new columns/rows
  dx := FX;
  dy := FY;
  for X := 0 to ColumnCount + FNewColumnDim - 1 do
  begin
    ColW := Round(FDefaultCellWidth * FScaleX);
    if X < ColumnCount then
      ColW := Round(Columns[X].Width * FScaleX);
    Dec(ColW);
    dy := FY;
    for Y := 0 to RowCount + FNewRowDim - 1 do
    begin
      RowH := Round(FDefaultCellHeight * FScaleX);

      if Y < RowCount then
        RowH := Round(Rows[Y].Height * FScaleY);
      Dec(RowH);
      if not((X < ColumnCount) and (Y < RowCount)) then
        TransparentFillRect(FCanvas.Handle, dx, dy, dx + ColW, dy + RowH,
          clSkyBlue);
      dy := dy + 1 + RowH;
    end;
    dx := dx + 1 + ColW;
  end;
  if IsTableActive and IsDesigning then
    if FResizeActive then
      frxImages.ObjectImages.Draw(FCanvas, dx + 2, dy + 2, 65)
    else
      frxImages.ObjectImages.Draw(FCanvas, dx + 2, dy + 2, 67);
end;

type
  THackMemoView = class(TfrxCustomMemoView);

function TfrxTableObject.ExportInternal(Filter: TfrxCustomExportFilter): Boolean;
var
  x, y, i: Integer;
  cell: TfrxTableCell;
  AllObjects: TList;
  PrevPages: TfrxCustomPreviewPages;

  procedure ExtractMacro(m: TfrxCustomMemoView);
  begin
    THackMemoView(m).FTotalPages := PrevPages.Count;
    THackMemoView(m).FPrintScale := PrevPages.PrintScale;
    THackMemoView(m).FCopyNo := PrevPages.PrintCopyNo;
    THackMemoView(m).ExtractMacros();
  end;

begin
  Result := False;
  if not Filter.IsProcessInternal then
  begin
    Filter.BeginClip(Self);
    FObjAsMetafile := True;
    try
      Filter.ExportObject(Self);
    finally
      FObjAsMetafile := False;
    end;
    Filter.EndClip;
    Exit;
  end;
  PrevPages := nil;
  if Assigned(Filter.Report) then
    PrevPages := Filter.Report.PreviewPages;
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
    begin
      cell := GetCell(x, y);
      { later all mechanism of macros will be changed }
      ExtractMacro(cell);
      cell.Width := cell.CellWidth;
      cell.Height := cell.CellHeight;
      if cell.FHidden then Continue;
      AllObjects := cell.AllObjects;
      Filter.ExportObject(cell);
      Filter.BeginClip(cell);
      try
        for i := 0 to AllObjects.Count - 1 do
          if TObject(AllObjects[i]) is TfrxView then
          begin
            if TObject(AllObjects[i]) is TfrxCustomMemoView then
              ExtractMacro(TfrxCustomMemoView(AllObjects[i]));
            Filter.ExportObject(TfrxView(AllObjects[i]));
          end;
      finally
        Filter.EndClip;
      end;
    end;
  Result := True;
end;


procedure TfrxTableObject.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DrawTable(FHighlighted);
  if IsTableActive and IsDesigning then
    frxImages.MainButtonImages.Draw(Canvas, FX, FY - 6, 110);
  FBoundsUpdating := False;
end;

function TfrxTableObject.DrawPart: Extended;
var
  aReport: TfrxReport;
  i, breakRowIndex: Integer;
  rowsHeight, aHeight: Extended;
  cell, cellto: TfrxTableCell;
  SpanList: TfrxRectArray;
  LBrakeToRow: TfrxCustomTableRow;
  LastPart: Boolean;
begin
  aReport := Report;
  Result := Height;
  if (aReport = nil) or Assigned(FTableBuilder) then Exit;
  RestoreBreakTable;
  rowsHeight := 0;
  breakRowIndex := FBreakRowIndex;
  LBrakeToRow := nil;
  aHeight := Height;
  while (breakRowIndex < FBrakeTo.RowCount) and (rowsHeight + FBrakeTo.Rows[breakRowIndex].Height < aHeight) do
  begin
    if FBrakeTo.Rows[breakRowIndex].IsSplitPart then
    begin
      LBrakeToRow := FBrakeTo.Rows[breakRowIndex].GetSplitPart(aHeight, LastPart);
      AddBrakeToRow(LBrakeToRow);
      if Assigned(LBrakeToRow) then
      begin
        FSaveHeight := FSaveHeight + (LBrakeToRow.Height - FBrakeToRowHeight);
        Self.Objects.Add(LBrakeToRow);
        TfrxHackComponent(LBrakeToRow).FParent := Self;
        FBrakeToRowHeight := 0;
        rowsHeight := rowsHeight + LBrakeToRow.Height;
        if not FBrakeTo.Rows[breakRowIndex].IsSplitPart then
          Inc(FBreakRowIndex);
        LBrakeToRow := nil;
      end
      else
        Inc(FBreakRowIndex);
    end
    else
      rowsHeight := rowsHeight + FBrakeTo.Rows[breakRowIndex].Height;

    Inc(breakRowIndex);
  end;
  FBrakeTo.FillSpanList(SpanList);

  if breakRowIndex < FBrakeTo.RowCount then
  begin
    FBrakeToRowHeight := FBrakeTo.Rows[breakRowIndex].Height;
    LBrakeToRow := FBrakeTo.Rows[breakRowIndex].GetSplitPart(aHeight - rowsHeight, LastPart);
    AddBrakeToRow(LBrakeToRow);
    if (LBrakeToRow = nil) and (breakRowIndex = FBreakRowIndex) and (FBrakeTo.Rows[breakRowIndex].Height > aHeight) then
    begin
      FBrakeToRowHeight := 0;
      Result := Height;
      Exit;
    end
    else if Assigned(LBrakeToRow) then
      FBrakeToRowHeight := FBrakeToRowHeight - LBrakeToRow.Height;
  end;

  if FBrakeTo.ColumnCount <> ColumnCount then
  begin
    FLockCorrectSpans := True;
    for i := 0 to FBrakeTo.ColumnCount - 1 do
    begin
      Self.Objects.Add(FBrakeTo.Columns[i]);
      TfrxHackComponent(FBrakeTo.Columns[i]).FParent := Self;
    end;
    FLockCorrectSpans := False;
  end;
  FLockCorrectSpans := True;

  for i := FBreakRowIndex to breakRowIndex - 1 do
  begin
    if FBrakeTo.Rows[i].IsSplitPart then
    begin
      LBrakeToRow := nil;
      FBrakeToRowHeight := 0;
    end
    else
    begin
      Objects.Add(FBrakeTo.Rows[i]);
      TfrxHackComponent(FBrakeTo.Rows[i]).FParent := Self;
    end;
  end;
  FLockCorrectSpans := False;
  if Assigned(LBrakeToRow) then
  begin
    Self.Objects.Add(LBrakeToRow);
    TfrxHackComponent(LBrakeToRow).FParent := Self;
    rowsHeight := rowsHeight + LBrakeToRow.Height;
  end;

  for i := Low(SpanList) to High(SpanList) do
    if (SpanList[i].Top < FBreakRowIndex) and (SpanList[i].Bottom > FBreakRowIndex) then
    begin
      cell := FBrakeTo.Cells[SpanList[i].Left, SpanList[i].Top];
      cellto := Self.Cells[SpanList[i].Left, 0];
      cellto.Assign(cell);
      cellto.RowSpan := SpanList[i].Bottom - FBreakRowIndex;
    end;
  //Self.NormalizeSpans;

  Self.Height := rowsHeight;
  Result := 0;
  FBreakRowIndex := breakRowIndex;
end;

function TfrxTableObject.IsAcceptAsChild(aParent: TfrxComponent): Boolean;
begin
  Result := (aParent is TfrxBand) or (aParent is TfrxPage);
end;

function TfrxTableObject.IsContain(X, Y: Extended): Boolean;
begin
  if IsTableActive and (CheckColumnSelector(X, Y) or CheckRowSelector(X, Y) or CheckMoveArrow(X, Y) or CheckSizeArrow(X, Y)) then
  begin
    Result := True;
    Exit;
  end;
  Result := inherited IsContain(X, Y);
end;

function TfrxTableObject.IsDynamicTable: Boolean;
begin
  Result := Assigned(FTableBuilder);
end;

function TfrxTableObject.IsHeightStored: Boolean;
begin
  Result := False;
end;

procedure TfrxTableObject.AddBrakeToRow(ARow: TfrxCustomTableRow);
begin
  if Assigned(ARow) then
    FBrakeToRows.Add(ARow);
end;

procedure TfrxTableObject.AddColumn(Value: TfrxTableColumn);
begin
  if Value = nil then
    Exit;
  Value.Parent := nil;
  InsertColumn(ColumnCount, Value);
end;

procedure TfrxTableObject.InitPart;
begin
  inherited;
  FBreakRowIndex := 0;
  FBrakeTo := TfrxStateTableObject.Create(Report);
  FBrakeTo.Assign(Self);
  MoveRowsColumns(FBrakeTo, True);
end;

procedure TfrxTableObject.InsertColumn(Index: Integer; Value: TfrxTableColumn);
begin
  if (Index < 0) or (Value = nil) then
    Exit
  else
  begin
    // we need this to be sure that the new item is added at the end of list
    // note: this will also normalize the objects list
    Value.Parent := nil;
    Value.Parent := Self;
    // now move the item
    Objects.Move(ColumnCount - 1, Index);
    CorrectSpansOnColumnChange(Index, 1);
    UpdateDesigner;
  end;
end;

procedure TfrxTableObject.DeleteColumn(Index: Integer);
var
  c: tfrxTableColumn;
begin
  c := Columns[Index];
  if c <> nil then
  begin
    if (Report.Designer <> nil) then
      Report.Designer.DeleteObject(c)
    else
      c.Free;
    CorrectSpansOnColumnChange(Index, -1);
    UpdateDesigner;
  end;
end;

procedure TfrxTableObject.AddRow(Value: TfrxCustomTableRow);
begin
  if Value = nil then
    Exit;
  Value.Parent := nil;
  InsertRow(RowCount, Value);
end;

procedure TfrxTableObject.InsertRow(Index: Integer; Value: TfrxCustomTableRow);
begin
  if (Index < 0) or (Value = nil) then
    Exit
  else
  begin
    // we need this to be sure that the new item is added at the end of list
    // note: this will also normalize the objects list
    Value.Parent := nil;
    Value.Parent := Self;
    // now move the item. take into account "columns, then rows" order in the objects list
    Objects.Move(Objects.Count - 1, ColumnCount + Index);
    Value.InitCells(ColumnCount);
    CorrectSpansOnRowChange(Index, 1);
    UpdateDesigner;
  end;
end;

procedure TfrxTableObject.DeleteRow(Index: Integer);
var
  r: TfrxCustomTableRow;
begin
  r := Rows[Index];
  if r <> nil then
  begin
    if (Report.Designer <> nil) then
      Report.Designer.DeleteObject(r)
    else
      r.Free;
    CorrectSpansOnRowChange(Index, -1);
    UpdateDesigner;
  end;
end;

function TfrxTableObject.CalcHeight: Extended;
begin
  if Assigned(FTableBuilder) and (FTableBuilder.FResultTable <> Self) then
  begin
    Result := FTableBuilder.PartHeight;
    Exit;
  end;
  FLockCorrectSpans := False;
  NormalizeSpans;
  CalcWidthInternal;
  CalcHeightInternal;
  Result := Height;
end;

procedure TfrxTableObject.BeforePrint;
var
  x, y: Integer;
  LReport: TfrxReport;
begin
  inherited;
  { Dynamic Table }
  LReport := Report;
  if Assigned(LReport) then
  begin
    try
      try
        FIsManualBuild := True;
        if Assigned(LReport.OnObjectManualBuild) and LReport.OnObjectManualBuild(Self) then
          Exit;
        if OnManualBuild <> '' then
        begin
          LReport.DoNotifyEvent(Self, OnManualBuild);
          Exit;
        end;
      finally
        FIsManualBuild := False;
      end;
    except
      RestoreAfterBuilder;
      raise ;
    end;
  end;
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
      Cells[x, y].BeforePrint;
end;

procedure TfrxTableObject.AfterPrint;
var
  x, y: Integer;
begin
  if Assigned(FBrakeTo) then
  begin
    RestoreBreakTable;
    RestoreSourceTable;
  end;
  if Assigned(FTableBuilder) then
    try
      FTableBuilder.DoPaginateTo(Self, Report);
    except
      RestoreAfterBuilder;
      raise ;
    end;
  FBoundsUpdating := True;
  LockAnchorsUpdate;
  FreeAndNil(FBrakeTo);
  RestoreAfterBuilder;
  inherited;
  FBoundsUpdating := False;
  for x := 0 to ColumnCount - 1 do
    for y := 0 to RowCount - 1 do
      Cells[x, y].AfterPrint;

  UnLockAnchorsUpdate;
end;

procedure TfrxTableObject.AlignChildren(IgnoreInvisible: Boolean; MirrorModes: TfrxMirrorControlModes);
var
  x, y: Integer;
begin
//  NormalizeSpans;
  for x := 0 to ColumnCount - 1 do
  begin
    for y := 0 to RowCount - 1 do
    begin
      UpdateCellDimensions(Cells[x, y]);
      if Cells[x, y].Objects.Count = 0 then
        Cells[x, y].DoMirror(MirrorModes);
      Cells[x, y].AlignChildren(IgnoreInvisible, MirrorModes);
    end;
  end;
end;

procedure TfrxTableObject.AssignCellAppearance(FromCell, ToCell: TfrxTableCell);
begin
  if (FromCell = nil) or (ToCell = nil) then Exit;
  ToCell.Font.Assign(FromCell.Font);
  ToCell.Frame.Assign(FromCell.Frame);
  ToCell.FillType := FromCell.FillType;
  ToCell.Fill.Assign(FromCell.Fill);
end;

procedure TfrxTableObject.GetData;
var
  x, y: Integer;
  aReport: TfrxReport;
  aOldObject: String;
  tCell: TfrxTableCell;
begin
  if Assigned(FTableBuilder) and (FTableBuilder.FResultTable <> Self) then
  begin
    FTableBuilder.PrepareFirstPart(Self);
    { Move to Engine }
    if (Parent is TfrxBand) and (FTableBuilder.PartHeight > Parent.Height) then
      Self.Height := FTableBuilder.PartHeight;
    Exit;
  end;
  inherited;
  aReport := Report;
  for y := 0 to RowCount - 1 do
  begin
    aReport.Engine.CurTableRow := y + 1;
    for x := 0 to ColumnCount - 1 do
    begin
      aReport.Engine.CurTableColumn := x + 1;
      aOldObject := aReport.CurObject;
      tCell := Cells[x, y];
      aReport.CurObject := tCell.Name;
      try
        tCell.GetData;
      finally
        aReport.CurObject := aOldObject;
      end;
      // set Visible to True to prevent problems with serialization to previewpages
      tCell.Visible := True;
    end;
  end;
  aReport.Engine.CurTableColumn := 0;
  aReport.Engine.CurTableRow := 0;
end;

class function TfrxTableObject.GetDescription: String;
begin
  Result := frxResources.Get('obTable');
end;

{ TfrxContainerPadding }

procedure TfrxContainerPadding.Assign(Source: TPersistent);
begin
  if Source is TfrxContainerPadding then
  begin
    FLeftPading := TfrxContainerPadding(Source).FLeftPading;
    FTopPading := TfrxContainerPadding(Source).FTopPading;
    FRightPading := TfrxContainerPadding(Source).FRightPading;
    FBottomPading := TfrxContainerPadding(Source).FBottomPading;
  end;
end;

{ TfrxCustomTableBuilder }

procedure TfrxCustomTableBuilder.AddFixedColumn(FixedColumn: TfrxTableColumn; DestTable: TfrxTableObject);
begin
  DestTable.Objects.Add(FixedColumn);
  FCurFixedColumns.Add(FixedColumn);
  TfrxHackComponent(FixedColumn).FParent := DestTable;
end;

procedure TfrxCustomTableBuilder.AddFixedRow(FixedRow: TfrxCustomTableRow; DestTable: TfrxTableObject);
begin
  DestTable.Objects.Add(FixedRow);
  TfrxHackComponent(FixedRow).FParent := DestTable;
end;

procedure TfrxCustomTableBuilder.AddFooterColumn(ColumnFooter: TfrxTableColumn;
  DestTable: TfrxTableObject);
begin
  DestTable.Objects.Add(ColumnFooter);
  FCurFixedColumns.Add(ColumnFooter);
  TfrxHackComponent(ColumnFooter).FParent := DestTable;
end;

procedure TfrxCustomTableBuilder.AddFooterRow(RowFooter: TfrxCustomTableRow;
  DestTable: TfrxTableObject);
begin
  DestTable.Objects.Add(RowFooter);
  TfrxHackComponent(RowFooter).FParent := DestTable;
end;

procedure TfrxCustomTableBuilder.ClearResultObjects(ATable: TfrxTableObject);
var
  i: Integer;
begin
  for I := 0 to ATable.Objects.Count - 1 do
    if TObject(ATable.Objects[i]) is TfrxTableRow then
    begin
      TfrxHackComponent(ATable.Objects[i]).FParent := nil;
      TfrxHackComponent(ATable.Objects[i]).Free
    end
    else
      TfrxHackComponent(ATable.Objects[i]).FParent := FResultTable;
  ATable.LockObjectsUpdate;
  try
    ATable.Objects.Clear;
  finally
    ATable.UnlockObjectsUpdate;
  end;
end;

function TfrxCustomTableBuilder.ColumnCount: Integer;
begin
  Result := FResultTable.ColumnCount;
end;

constructor TfrxCustomTableBuilder.Create(SourceTable: TfrxTableObject);
begin
  FSourceTable := SourceTable;
  FReport := FSourceTable.Report;
  FColumnSpans := TList.Create;
  FRowSpans := TList.Create;
  FFixedRows := TList.Create;
  FResultTable := TfrxTableObject(GetResultTableClass.NewInstance);
  FResultTable.Create(nil);
  FResultTable.AssignOriginals(FSourceTable);
  FResultTable.FTableBuilder := Self;
  PaginationOrder := tpAcrossThenDown;
  FFixedColumns := TList.Create;
  FFixedFooterColumns := TList.Create;
  FFixedFooterRows := TList.Create;
  FTempList := TList.Create;
  FBreakeSpanCells := TList.Create;
  FCurFixedColumns := TList.Create;
  FPartHeight := 0;
  FFirstPartY := 0;
  FLastUpdateValue := 0;
end;

destructor TfrxCustomTableBuilder.Destroy;
begin
  FreeAndNil(FResultTable);
  FreeAndNil(FColumnSpans);
  FreeAndNil(FRowSpans);
  FreeAndNil(FFixedRows);
  FreeAndNil(FFixedColumns);
  FreeAndNil(FFixedFooterColumns);
  FreeAndNil(FFixedFooterRows);
  FreeAndNil(FTempList);
  FreeAndNil(FBreakeSpanCells);
  FreeAndNil(FCurFixedColumns);
  inherited;
end;

procedure TfrxCustomTableBuilder.DoPaginateTo(ATable: TfrxTableObject;
  Report: TfrxReport);
var
  cpage: Integer;
  NBand: TfrxNullBand;
  SavedY, LHeight: Extended;
  RestorePos: Boolean;
begin
  try
    ClearResultObjects(ATable);
    NBand := TfrxNullBand.Create(nil);
    NBand.Stretched := False;
    NBand.Objects.Add(ATable);
    RestorePos := False;
    ATable.StretchMode := smDontStretch;
    SavedY := report.Engine.CurY;
    cpage := report.PreviewPages.CurPage;
    if not FIsLastPart and (not(PaginationOrder = tpDownThenAcrossWrapped) or
      (PartHeight = 0)) then
    begin
      Report.Engine.NewPage;
      FFirstPartY := FFirstPartY - Report.Engine.CurY;
      RestorePos := (FCurrentPrintPart = tpDownThenAcross);
    end;
    while PaginateNextPartTo(ATable, Report, LHeight) and
      not Report.Terminated do
    begin
      NBand.Height := LHeight + ATable.Top;
      NBand.Top := Report.Engine.CurY;
      Report.PreviewPages.AddObject(NBand);
      Report.Engine.CurY := Report.Engine.CurY + NBand.Height;
      if ((PaginationOrder <> tpDownThenAcrossWrapped) or (LHeight = 0)) and not FIsLastPart
      then
      begin
        Report.Engine.NewPage;
        if not RestorePos then
          RestorePos := (FCurrentPrintPart = tpDownThenAcross);
        continue;
      end;
    end;
    ClearResultObjects(ATable);
    NBand.Objects.Clear;
    NBand.Free;
    if PaginationOrder = tpDownThenAcrossWrapped then
      Report.PreviewPages.CurPage := Report.PreviewPages.Count - 1
    else if not RestorePos then
    begin
      Report.Engine.EndPage;
      Report.PreviewPages.CurPage := cpage;
      Report.Engine.CurY := SavedY;
    end;
    Report.PreviewPages.AddPageAction := apAdd;
    FOutTable := nil;
  finally
    Report.Terminated := FSavedTerminated;
  end;
end;

procedure TfrxCustomTableBuilder.FillUpdate;
var
  LValue: Cardinal;
begin
  LValue := Cardinal(FResultTable.ColumnCount * FResultTable.RowCount);
  if ((LValue - FLastUpdateValue) div frxTableFillUpdate  > 0) and (FLastUpdateValue < LValue) then
  begin
    FLastUpdateValue := LValue;
    FReport.SetProgressMessage(Format('Filling table : %d x %d', [FResultTable.ColumnCount, FResultTable.RowCount]));
  end;
end;

function TfrxCustomTableBuilder.GetCellData(X, Y: Integer): TfrxCellData;
begin
  Result := nil;
end;

class function TfrxCustomTableBuilder.GetResultTableClass: TfrxTableObjectClass;
begin
  Result := TfrxTableObject;
end;

procedure TfrxCustomTableBuilder.PageBreak;
begin
  FPageBreak := True;
end;

function TfrxCustomTableBuilder.PaginateNextPartTo(ATable: TfrxTableObject;
  Report: TfrxReport; var UsedHeight: Extended): Boolean;
var
  i, j, ColsFit, RowsFit, Idx: Integer;
  MaxValue, FooterValue, LFreeSpace, LWidth: Extended;
  IsWrapped, IsLastPart: Boolean;
  LastCol: TfrxTableColumn;
  SpanRow, SpanCol: Integer;
  AddedRow: TfrxCustomTableRow;

  procedure BreakText(ACell, ACellTo: TfrxCellData);
  var
    FDrawText: TfrxDrawText;
    ParaBreak: Boolean;
  begin
    FDrawText := FReport.GetDrawTextObject;
    FDrawText.Lock;
    try
      ACell.Cell.Memo.Text := ACell.Text;
      ACell.Cell.BeginDraw(nil, 1, 1, 0, 0);
      ACell.Cell.SetDrawParams(nil, 1, 1, 0, 0);
      ACellTo.Text := FDrawText.GetOutBoundsText(ParaBreak);
      ACell.Text := FDrawText.GetInBoundsText;
    finally
      FDrawText.Unlock;
    end;
  end;

  procedure SpanCell(cX, cY, ctX, ctY: Integer);

    function CellHeight(ACell:TfrxTableCell): Extended;
    var
      i, y: Integer;
    begin
      Result := 0;
      y := ACell.ParentRow.Index;
      for i := y to y + ACell.RowSpan - 1 do
      Result := Result + FResultTable.Rows[i].Height;
    end;

  var
    cell, cellto: TfrxCellData;
    OldSpan: Integer;
  begin
    cell := GetCellData(cX, cY);
    cellto := GetCellData(ctX, ctY);
    if (cell = nil) or (cellto = nil) then
      Exit;
    if Assigned(cell) and (cell.Cell.Objects.Count > 0) then
    begin
      cellto.OriginalCell := cellto.Cell;
      cellto.Cell := TfrxTableCell.Create(nil);
      cellto.Cell.AssignAllWithOriginals(cell.Cell);
      { need for anchors }
      cellto.Cell.Width := cell.Cell.Width;
      cellto.Cell.Height := cell.Cell.Height;
      cellto.NeedUpdate := False;
      FBreakeSpanCells.Add(cellto);
    end
    else
    begin
      cellto.Cell.Assign(cell.Cell);
      OldSpan := cell.RowSpan;
      cell.RowSpan := cell.RowSpan - (FResultSpans[i].Bottom - ctY);
      cell.Cell.Height := CellHeight(cell.Cell);
      cell.RowSpan := OldSpan;
      BreakText(cell, cellto);
    end;
    //cellto.Text := cell.Text;
    cellto.ColSpan := FResultSpans[i].Right - ctX;
    cellto.RowSpan := FResultSpans[i].Bottom - ctY;
  end;

  procedure PrepareFixedColumns;
  var
    i: Integer;
  begin
    for i := 0 to FFixedColumns.Count - 1 do
      if FPaginateStart.X > TfrxTableColumn(FFixedColumns[i]).Index then
      begin
        if (MaxValue + TfrxTableColumn(FFixedColumns[i]).Width > LWidth) then break;
        MaxValue := MaxValue + TfrxTableColumn(FFixedColumns[i]).Width;
        AddFixedColumn(TfrxTableColumn(FFixedColumns[i]), ATable);
      end;
    FooterValue := 0;
    for i := 0 to FFixedFooterColumns.Count - 1 do
    begin
      if (MaxValue + FooterValue + TfrxTableColumn(FFixedFooterColumns[i]).Width > LWidth) then break;
      FooterValue := FooterValue + TfrxTableColumn(FFixedFooterColumns[i]).Width;
      FTempList.Add(FFixedFooterColumns[i]);
    end;
  end;

begin
  MaxValue := 0;
  ColsFit := 0;
  RowsFit := 0;
  UsedHeight := 0;
  FCurFixedColumns.Clear;
  if FResetBreakeSpan then
    RestoreSpanBreak;
  FTempList.Clear;
  IsWrapped := PaginationOrder = tpDownThenAcrossWrapped;
  Result := not((FPaginateStart.X = FResultTable.ColumnCount) and (FPaginateStart.Y = FResultTable.RowCount));
  if not Result then Exit;

  if not FIsFirstPart then
    if (FCurrentPrintPart = tpDownThenAcross) then
    begin
      if (FPaginateStart.X = 0) and not IsWrapped then
        ATable.Left := FLeft;
      ATable.Top := 0;
    end
    else
    begin
      if (FPaginateStart.Y = 0) and not IsWrapped then
        ATable.Top := FTop + FFirstPartY;
      if IsWrapped then
        ATable.Left := FLeft
      else
        ATable.Left := 0;
    end;
  LFreeSpace := Report.Engine.FreeSpace - ATable.Top;
  LWidth := Report.Engine.PageWidth - ATable.Left;

  ATable.LockObjectsUpdate;
  FResultTable.FSerializeColumns.RangeStart := FPaginateStart.X;
  FResultTable.FSerializeRows.RangeStart := FPaginateStart.Y;
  ClearResultObjects(ATable);

  PrepareFixedColumns;

  i := FPaginateStart.X;
  while (i < FResultTable.ColumnCount) and not Report.Terminated do
  begin
    if (MaxValue + FooterValue + FResultTable.Columns[i].Width > LWidth) then
    begin
      if (FooterValue > 0) and (i = FPaginateStart.X) then
      begin
        FooterValue := 0;
        FTempList.Clear;
        continue;
      end;
      if not FIsNewPage then
        break;
      MaxValue := 0;
      ClearResultObjects(ATable);
    end;
    Inc(ColsFit);
    FIsNewPage := False;
    MaxValue := MaxValue + FResultTable.Columns[i].Width;
    ATable.Objects.Add(FResultTable.Columns[i]);
    TfrxHackComponent(FResultTable.Columns[i]).FParent := ATable;
    if FResultTable.Columns[i].FPageBreak then break;
    Inc(i);
  end;

  { nothing fits try next page }
  if ColsFit = 0 then
  begin
    FIsNewPage := True;
    ClearResultObjects(ATable);
    ATable.UnlockObjectsUpdate;
    Exit;
  end;

  FResultTable.FSerializeColumns.RangeEnd := FPaginateStart.X + ColsFit;
  { add fixed foters that fits }
  for i := 0 to FTempList.Count - 1 do
    if FPaginateStart.X + ColsFit < TfrxTableColumn(FTempList[i]).FIndex then
      AddFooterColumn(TfrxTableColumn(FTempList[i]), ATable);
  MaxValue := 0;
  FTempList.Clear;

  LastCol := TfrxTableColumn(ATable.Objects[ATable.Objects.Count - 1]);

  if FPaginateStart.Y <>  0 then
    for i := 0 to FFixedRows.Count - 1 do
    begin
      if (MaxValue + TfrxTableRow(FFixedRows[i]).Height > LFreeSpace) then break;
      MaxValue := MaxValue + TfrxTableRow(FFixedRows[i]).Height;
      ATable.Objects.Add(FFixedRows[i]);
      TfrxHackComponent(FFixedRows[i]).FParent := ATable;
    end;

  FooterValue := 0;
  for i := 0 to FFixedFooterRows.Count - 1 do
  begin
    if (MaxValue + FooterValue + TfrxCustomTableRow(FFixedFooterRows[i]).Height > LFreeSpace) then break;
    FooterValue := FooterValue + TfrxCustomTableRow(FFixedFooterRows[i]).Height;
    FTempList.Add(FFixedFooterRows[i]);
  end;

  //for i := FPaginateStart.Y to FResultTable.RowCount - 1 do
  i := FPaginateStart.Y;
  AddedRow := nil;
  while (i < FResultTable.RowCount) and not Report.Terminated do
  begin
    IsLastPart := True;
    if (MaxValue + FooterValue + FResultTable.Rows[i].Height > LFreeSpace) then
    begin
      AddedRow := FResultTable.GetSplitRow(FResultTable.Rows[i], LFreeSpace - (MaxValue + FooterValue), IsLastPart);
      if AddedRow = nil then
      begin
        if (FooterValue > 0) and (i = FPaginateStart.Y) then
        begin
          FooterValue := 0;
          FTempList.Clear;
          continue;
        end;
        if not FIsNewPage then
        begin
          if i - FPaginateStart.Y > 0 then
            AddedRow := FResultTable.Rows[i - 1];
          break;
        end;
        MaxValue := 0;
        ClearResultObjects(ATable);
      end;
    end
    else
      AddedRow := FResultTable.Rows[i];
    if AddedRow.IsSplitPart and IsLastPart and (i = FPaginateStart.Y) then
      AddedRow := FResultTable.GetSplitRow(AddedRow, LFreeSpace - (MaxValue + FooterValue), IsLastPart);
   // if (MaxValue + FResultTable.Rows[i].Height > LFreeSpace) or ((FPaginateStart.Y <> i)  and (FResultTable.Rows[i].FPageBreak)) then break;
    if IsLastPart then
      Inc(RowsFit);
    FIsNewPage := False;
    ATable.Objects.Add(AddedRow);
    TfrxHackComponent(AddedRow).FParent := ATable;
    MaxValue := MaxValue + AddedRow.Height;
    if FResultTable.Rows[i].FPageBreak then break;
    Inc(i);
    if not IsLastPart then break;

  end;
  UsedHeight := MaxValue;
  if (RowsFit = 0) and (AddedRow = nil) then
  begin
    FIsNewPage := True;
    ClearResultObjects(ATable);
    ATable.UnlockObjectsUpdate;
    UsedHeight := 0;
    Exit;
  end;

  { add fixed foters that fits }
  for i := 0 to FTempList.Count - 1 do
    if FPaginateStart.Y + RowsFit < TfrxCustomTableRow(FTempList[i]).FIndex then
    begin
      AddFooterRow(TfrxCustomTableRow(FTempList[i]), ATable);
      UsedHeight := UsedHeight + TfrxCustomTableRow(FTempList[i]).Height;
    end;
  FTempList.Clear;

  FResultTable.FSerializeRows.RangeEnd := FPaginateStart.Y + RowsFit;

  if Assigned(AddedRow) and (FPaginateStart.Y + RowsFit - 1 < FResultTable.RowCount - 1) and  not IsWrapped then//(PaginationOrder <> tpWrapped) then
//    FResultTable.Rows[FPaginateStart.Y + RowsFit - 1]
    AddedRow.FPageBreak := True;
  ATable.UnlockObjectsUpdate;

  if (FPaginateStart.X + ColsFit = FResultTable.ColumnCount) and (FPaginateStart.Y + RowsFit = FResultTable.RowCount) then
  begin
    FPaginateStart.Y := FPaginateStart.Y + RowsFit;
    FPaginateStart.X := FPaginateStart.X + ColsFit;
    FCurrentPrintPart := tpDownThenAcross;
    FIsLastPart := True;
    Exit;
  end;
  if IsWrapped then
    FFirstPartY := 0;

  FResetBreakeSpan := (FBreakeSpanCells.Count > 0);
  SpanRow := TfrxTableRowColumnBase(ATable.Objects[ATable.Objects.Count - 1]).Index + 1;
  SpanCol := LastCol.Index + 1;
  for i := Low(FResultSpans) to High(FResultSpans) do
  begin
    for j := 0 to FCurFixedColumns.Count - 1 do
    begin
      idx := TfrxTableRowColumnBase(FCurFixedColumns[j]).Index;
      if (FResultSpans[i].Top < SpanRow) and (FResultSpans[i].Bottom > SpanRow)
        and (FResultSpans[i].Left <= idx ) and (FResultSpans[i].Right >= idx )then
      SpanCell(FResultSpans[i].Left, FResultSpans[i].Top, FResultSpans[i].Left,  SpanRow);
    end;
    if (FResultSpans[i].Top < SpanRow) and (FResultSpans[i].Bottom > SpanRow)
        and (FResultSpans[i].Left >= FPaginateStart.X ) and (FResultSpans[i].Right <= FPaginateStart.X + ColsFit ) then
      SpanCell(FResultSpans[i].Left, FResultSpans[i].Top, FResultSpans[i].Left,  SpanRow);
    if (FResultSpans[i].Left < SpanCol) and (FResultSpans[i].Right > SpanCol) then
      SpanCell(FResultSpans[i].Left, FResultSpans[i].Top, SpanCol,  FResultSpans[i].Top);
  end;

  if PaginationOrder in [tpDownThenAcross, tpDownThenAcrossWrapped] then
  begin
    if FPaginateStart.Y  + RowsFit < FResultTable.RowCount then
    begin
      FPaginateEnd.X := ColsFit;
      FPaginateStart.Y := FPaginateStart.Y + RowsFit;
      FCurrentPrintPart := tpDownThenAcross;
    end
    else begin
      FPaginateStart.Y := 0;
      FPaginateStart.X := FPaginateStart.X + ColsFit;
      FCurrentPrintPart := tpAcrossThenDown;
    end;
  end
  else begin
    if FPaginateStart.X + ColsFit < FResultTable.ColumnCount then
    begin
      FPaginateEnd.Y := RowsFit;
      FPaginateStart.X := FPaginateStart.X + ColsFit;
      FCurrentPrintPart := tpAcrossThenDown;
    end
    else begin
      FPaginateStart.X := 0;
      FPaginateStart.Y := FPaginateStart.Y + RowsFit;
      FCurrentPrintPart := tpDownThenAcross;
    end;
  end;
end;

procedure TfrxCustomTableBuilder.PrepareFirstPart(
  PrepareToTable: TfrxTableObject);
begin
  { we can receive terminated during matrix build }
  { now we can output prepared result }
  { otherwise when we receive terminated during output just stop it }
  { save previous state }
  FSavedTerminated := FReport.Terminated;
  FReport.Terminated := False;
  FIsFirstPart := True;
  FIsLastPart := False;
  FFirstPartY := FReport.Engine.CurY;
  FLeft := PrepareToTable.Left;
  FTop := PrepareToTable.Top;
  ResultTable.SetSpanFillList(@FResultSpans);
  FPartHeight := ResultTable.CalcHeight;
  PrepareToTable.Top := FTop;
  FOutTable := PrepareToTable;
//  FReport.Engine.CurY := FReport.Engine.CurY + FTop;
  PaginateNextPartTo(PrepareToTable, FReport, FPartHeight);
//  FReport.Engine.CurY := FFirstPartY;
  FIsFirstPart := False;
  FPrintingRowIndex := 0;
  FPrintingColumnIndex := 0;
end;

procedure TfrxCustomTableBuilder.PrintColumn(Index: Integer; TableBandType: TfrxTableBandType);
var
  tCol: TfrxTableColumn;
begin
  FillUpdate;
  FOriginalColumnIndex := Index;
  if FDataPrinting = pdNone then
    FIsRowPriority := False;

  if not FIsRowPriority then
  begin
    case FDataPrinting of
      pdNone: FPrintingColumnIndex := 0;
      pdRow: Inc(FPrintingColumnIndex);
      pdColumn: ;
    end;
    tCol := FResultTable.CreateTableColumn;
    tCol.AssignAll(FSourceTable.Columns[Index]);
    tCol.AssignOriginals(FSourceTable.Columns[Index]);
    tCol.FPageBreak := FPageBreak;
    FResultTable.AddColumn(tCol);
    tCol.FBandType := TableBandType;
    case TableBandType of
      tbHeader: FFixedColumns.Add(tCol);
      tbFooter .. tbLocalAggregateFooter: FFixedFooterColumns.Add(tCol);
    end;
    FRowSpans.Clear();
  end
  else
  begin
    if FDataPrinting = pdRow then FPrintingColumnIndex := 0
    else Inc(FPrintingColumnIndex);
    if FResultTable.ColumnCount <= FPrintingColumnIndex then
    begin
      tCol := FResultTable.CreateTableColumn;
      tCol.Assign(FSourceTable.Columns[Index]);
      tCol.AssignOriginals(FSourceTable.Columns[Index]);
      FResultTable.AddColumn(tCol);
      tCol.FBandType := TableBandType;
      case TableBandType of
        tbHeader: FFixedColumns.Add(tCol);
        tbFooter .. tbLocalAggregateFooter: FFixedFooterColumns.Add(tCol);
      end;
    end
    else
      tCol := FResultTable.Columns[FPrintingColumnIndex];
    tCol.FPageBreak := FPageBreak;
    CopyCells(FOriginalColumnIndex, FOriginalRowIndex, FPrintingColumnIndex, FPrintingRowIndex);
  end;
  FDataPrinting := pdColumn;
  FPageBreak := False;
end;

procedure TfrxCustomTableBuilder.PrintColumns(StartIndex: Integer);
var
  i: Integer;
begin
  for i := StartIndex to FSourceTable.ColumnCount - 1 do
    PrintColumn(i);
end;

procedure TfrxCustomTableBuilder.PrintRow(Index: Integer; TableBandType: TfrxTableBandType = tbData);
var
  tRow: TfrxCustomTableRow;
begin
  FillUpdate;
  FOriginalRowIndex := Index;
  if FDataPrinting = pdNone then
    FIsRowPriority := True;
  if FIsRowPriority then
  begin
    case FDataPrinting of
      pdNone: FPrintingRowIndex := 0;
      pdRow: ;
      pdColumn: Inc(FPrintingRowIndex);
    end;
    tRow := FResultTable.CreateTableRow;
    tRow.Assign(FSourceTable.Rows[Index]);
    tRow.AssignOriginals(FSourceTable.Rows[Index]);
    tRow.FPageBreak := FPageBreak;
    FResultTable.FLockCorrectSpans := True;
    FResultTable.AddRow(tRow);
    tRow.FBandType := TableBandType;
    case TableBandType of
      tbHeader: FFixedRows.Add(tRow);
      tbFooter .. tbLocalAggregateFooter: FFixedFooterRows.Add(tRow);
    end;
    FColumnSpans.Clear();
  end
  else
  begin
    if FDataPrinting = pdColumn then
      FPrintingRowIndex := 0
    else
      Inc(FPrintingRowIndex);
    if FResultTable.RowCount <= FPrintingRowIndex then
    begin
      tRow := FResultTable.CreateTableRow;
      tRow.Assign(FSourceTable.Rows[Index]);
      tRow.AssignOriginals(FSourceTable.Rows[Index]);
      FResultTable.FLockCorrectSpans := True;
      FResultTable.AddRow(tRow);
      tRow.FBandType := TableBandType;
      case TableBandType of
        tbHeader: FFixedRows.Add(tRow);
        tbFooter .. tbLocalAggregateFooter: FFixedFooterRows.Add(tRow);
      end;
    end
    else
      tRow := FResultTable.Rows[FPrintingRowIndex];
    tRow.FPageBreak := FPageBreak;
    CopyCells(FOriginalColumnIndex, FOriginalRowIndex, FPrintingColumnIndex, FPrintingRowIndex);
  end;

  FDataPrinting := pdRow;
  FPageBreak := False;
end;

procedure TfrxCustomTableBuilder.PrintRows(StartIndex: Integer);
var
  i: Integer;
begin
  for i := StartIndex to FSourceTable.RowCount - 1 do
    PrintRow(i);
end;

procedure TfrxCustomTableBuilder.RestoreSpanBreak;
var
  i: Integer;
begin
  for I := 0 to FBreakeSpanCells.Count - 1 do
  begin
    TfrxCellData(FBreakeSpanCells[i]).FCell.Free;
    TfrxCellData(FBreakeSpanCells[i]).Cell := TfrxCellData(FBreakeSpanCells[i]).FOriginalCell;
  end;
  FBreakeSpanCells.Clear;
end;

function TfrxCustomTableBuilder.RowCount: Integer;
begin
  Result := FResultTable.RowCount;
end;

{ TfrxCellData }

destructor TfrxCellData.Destroy;
begin
  if Assigned(FCell) then
  begin
    if FIsOwnCell then
      FreeAndNil(FCell)
    else
      FCell.FCellData := nil;
  end;
  inherited;
end;


function TfrxCellData.GetOriginalCell: TfrxTableCell;
begin
  if Assigned(FOriginalCell) then
    Result := FOriginalCell
  else
    Result := Cell;
end;

procedure TfrxCellData.SetCell(const Value: TfrxTableCell);
begin
  FCell := Value;
  FIsOwnCell := (FCell.Parent = nil);
end;

procedure TfrxCellData.SetText(const Value: WideString);
begin
  FText := Value;
end;

{ TfrxTableBuilder }

procedure TfrxTableBuilder.CopyCells(OriginalColumnIndex, OriginalRowIndex,
  ResultColumnIndex, ResultRowIndex: Integer);
var
  cell, cellTo: TfrxTableCell;
begin
  cell := FSourceTable.Cells[OriginalColumnIndex, OriginalRowIndex];
  cellTo := FResultTable.Cells[ResultColumnIndex, ResultRowIndex];
  cell.BeforePrint;
  cell.GetData;
  cellTo.AssignAllWithOriginals(cell);
  cell.AfterPrint;
end;

{ TfrxStateTableObject }

procedure TfrxStateTableObject.AssignOriginals(Source: TfrxComponent);
begin
  inherited AssignOriginals(Source);
  FOriginalParent := Source.Parent;
end;

constructor TfrxStateTableObject.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  if AOwner is TfrxReport then
    FReport := TfrxReport(AOwner);
end;

function TfrxStateTableObject.GetReport: TfrxReport;
begin
  Result := FReport;
end;

initialization
  if frxTableBuilder = nil then
    frxTableBuilder := TfrxTableBuilder;
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxTableObject, TControl);
{$ENDIF}

end.
