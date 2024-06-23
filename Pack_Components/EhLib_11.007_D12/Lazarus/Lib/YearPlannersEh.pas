{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                     Planner Component                 }
{                                                       }
{   Copyright (c) 2020-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit YearPlannersEh;

interface

uses
  SysUtils, Messages, Controls, Forms, StdCtrls, TypInfo,
  DateUtils, ExtCtrls, Buttons, Dialogs, ImgList, GraphUtil,
  Contnrs, Variants, Types, Themes, Menus,
{$IFDEF EH_LIB_17}
  System.Generics.Collections,
  System.Generics.Defaults,
  System.UITypes,
{$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, PrintUtilsEh, Windows, UxTheme,
  {$ENDIF}
  Classes, PlannerDataEh, SpreadGridsEh, PlannersEh,
  GridsEh, ToolCtrlsEh, Graphics;

type
  TPlannerHorzYearViewEh = class;

{ TMonthBarAreaEh }

  TMonthBarAreaEh = class(THoursVertBarAreaEh)
  private
  protected
    function DefaultSize: Integer; override;
    procedure AssignFontDefaultProps; override;
  published
  end;

{ TYearViewDataBarAreaEh }

  TYearViewDataBarAreaEh = class(TPlannerViewDrawElementEh)
  private
    FMinCellHeight: Integer;
    FMinCellWidth: Integer;
    procedure SetMinCellHeight(const Value: Integer);
    procedure SetMinCellWidth(const Value: Integer);
  protected
    procedure AssignFontDefaultProps; override;

  public
    constructor Create(APlannerView: TCustomPlannerViewEh);
    destructor Destroy; override;

    function DefaultMinCellHeight: Integer; virtual;
    function DefaultMinCellWidth: Integer; virtual;

    function ActualMinCellHeight: Integer;
    function ActualMinCellWidth: Integer;

  published
    property Color;
    property Font;
    property FontStored;

    property MinCellHeight: Integer read FMinCellHeight write SetMinCellHeight default 0;
    property MinCellWidth: Integer read FMinCellWidth write SetMinCellWidth default 0;
  end;

{ THorzYearViewTimeSpanParamsEh }

  TPlannerControlTimeSpanParamsEh = class(TPersistent)
  private
    FPlannerView: TPlannerHorzYearViewEh;
    FMinHeight: Integer;
    procedure SetMinHeight(const Value: Integer);
  protected
  public
    constructor Create(APlannerView: TPlannerHorzYearViewEh);
    destructor Destroy; override;

    property PlannerView: TPlannerHorzYearViewEh read FPlannerView;

  published
    property MinHeight: Integer read FMinHeight write SetMinHeight default 0;
  end;

{ TPlannerHorzYearViewEh }

  TPlannerHorzYearViewEh = class(TCustomPlannerViewEh)
  private
    FSortedSpans: TObjectListEh;
    FMonthColArea: TMonthBarAreaEh;
    FDataBarArea: TYearViewDataBarAreaEh;
    FTimeSpanParams: TPlannerControlTimeSpanParamsEh;

    function GetDataBarsArea: TYearViewDataBarAreaEh;
    function GetDayNameArea: TDayNameVertAreaEh;
    function GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;

    procedure SetDataBarsArea(const Value: TYearViewDataBarAreaEh);
    procedure SetDayNameArea(const Value: TDayNameVertAreaEh);
    procedure SetMonthColArea(const Value: TMonthBarAreaEh);

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetTimeSpanParams(const Value: TPlannerControlTimeSpanParamsEh);

  protected
    FDataRowsFor1Res: Integer;
    FDataDayNumAreaHeight: Integer;
    FDefaultLineHeight: Integer;
    FMovingDaysShift: Integer;
    FShowMonthNoCaption: Boolean;
    FMonthColIndex: Integer;

    function AdjustDate(const Value: TDateTime): TDateTime; override;
    function CellToDateTime(ACol, ARow: Integer): TDateTime; override;
    function CreateDayNameArea: TDayNameAreaEh; override;
    function CreateHoursBarArea: THoursBarAreaEh; override;
    function CreateResourceCaptionArea: TResourceCaptionAreaEh; override;
    function DefaultHoursBarSize: Integer; override;
    function DrawMonthDayWithWeekDayName: Boolean; override;
    function GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh; override;
    function GetDataCellTimeLength: TDateTime; override;
    function GetResourceAtCell(ACol, ARow: Integer): TPlannerResourceEh; override;
    function GetResourceViewAtCell(ACol, ARow: Integer): Integer; override;
    function IsDayNameAreaNeedVisible: Boolean; override;
    function NewItemParams(var StartTime, EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean; override;

    function CalcShowKeekNoCaption(RowHeight: Integer): Boolean; virtual;
    function IsInterResourceCell(ACol, ARow: Integer): Boolean; virtual;
    function TimeToGridLineRolPos(ADateTime: TDateTime): Integer; virtual;
    function WeekNoColWidth: Integer; virtual;

    procedure BuildGridData; override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure ClearSpanItems; override;
    procedure GetCellType(ACol, ARow: Integer; var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer); override;
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime); override;
    procedure GetWeekDayNamesParams(ACol, ARow, ALocalCol, ALocalRow: Integer; var WeekDayNum: Integer; var WeekDayName: String); override;
    procedure GridLayoutChanged; override;
    procedure InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh); override;
    procedure InitSpanItemMoving(SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint); override;
    procedure ReadPlanItem(APlanItem: TPlannerDataItemEh); override;
    procedure Resize; override;
    procedure SetDisplayPosesSpanItems; override;
    procedure SetGroupPosesSpanItems(Resource: TPlannerResourceEh); override;
    procedure SortPlanItems; override;
    procedure UpdateDummySpanItemSize(MousePos: TPoint); override;

    procedure BuildYearGridMode; virtual;
    procedure CalcPosByPeriod(AStartTime, AEndTime: TDateTime; var AStartGridPos, AStopGridPos: Integer); virtual;
    procedure DrawMonthViewDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure ReadDivByMonthPlanItem(StartDate, BoundDate: TDateTime; APlanItem: TPlannerDataItemEh);
    procedure SetDisplayPosesSpanItemsForResource(AResource: TPlannerResourceEh; Index: Integer); virtual;
    procedure SetResOffsets; virtual;
    procedure TimeSpanParamsChagned; virtual;
    procedure WeekNoCellClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); virtual;

    property SortedSpan[Index: Integer]: TTimeSpanDisplayItemEh read GetSortedSpan;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AppendPeriod(ATime: TDateTime; Periods: Integer): TDateTime; override;
    function CellIsDateRelevant(ACol, ARow: Integer): Boolean; virtual;
    procedure GetRelevantColsForRow(ADataRow: Integer; out AStartDataCol, AColCount: Integer);
    function GetPeriodCaption: String; override;
    function NextDate: TDateTime; override;
    function PriorDate: TDateTime; override;
    function GetDefaultMonthBarWidth: Integer; virtual;

    procedure DrawDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawDayNamesCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawWeekNoCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawMonthNameCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure GetDataCellDrawParams(ACol, ARow: Integer; ARect: TRect; var State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure GetMonthNameCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure GetResourceCaptionCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

  published
    property DataBarsArea: TYearViewDataBarAreaEh read GetDataBarsArea write SetDataBarsArea;
    property DayNameArea: TDayNameVertAreaEh read GetDayNameArea write SetDayNameArea;
    property TimeSpanParams: TPlannerControlTimeSpanParamsEh read FTimeSpanParams write SetTimeSpanParams;
    property PopupMenu;
    property ResourceCaptionArea;
    property MonthColArea: TMonthBarAreaEh read FMonthColArea write SetMonthColArea;

    property OnContextPopup;
    property OnDblClick;
    property OnDrawCell;
    property OnReadPlannerDataItem;
    property OnSelectionChanged;
    property OnSpanItemHintShow;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF EH_LIB_10}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
{$IFDEF FPC}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

implementation

uses
{$IFDEF EH_LIB_17}
  UIConsts,
{$ENDIF}
{$IFDEF FPC}
{$ELSE}
  PrintPlannersEh,
{$ENDIF}
  EhLibLangConsts,
  PlannerItemDialog,
  PlannerToolCtrlsEh;

type
  TTimeSpanDisplayItemEhCrack = class(TTimeSpanDisplayItemEh);

{ TMonthBarAreaEh }

procedure TMonthBarAreaEh.AssignFontDefaultProps;
begin
  Font.Assign(DefaultFont);
end;

function TMonthBarAreaEh.DefaultSize: Integer;
begin
  Result := TPlannerHorzYearViewEh(PlannerView).GetDefaultMonthBarWidth;
end;

{ TPlannerHorzYearViewEh }

constructor TPlannerHorzYearViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataColsOffset := 1;
  FDataRowsOffset := 1;
  HorzScrollBar.VisibleMode := sbNeverShowEh;
  VertScrollBar.VisibleMode := sbNeverShowEh;

  FDataRowsFor1Res := 12;
  FSortedSpans := TObjectListEh.Create;
  FMonthColArea := TMonthBarAreaEh.Create(Self);
  FDataBarArea := TYearViewDataBarAreaEh.Create(Self);
  FTimeSpanParams := TPlannerControlTimeSpanParamsEh.Create(Self);
end;

destructor TPlannerHorzYearViewEh.Destroy;
begin
  FreeAndNil(FSortedSpans);
  FreeAndNil(FMonthColArea);
  FreeAndNil(FDataBarArea);
  FreeAndNil(FTimeSpanParams);
  inherited Destroy;
end;

procedure TPlannerHorzYearViewEh.ClearSpanItems;
begin
  inherited ClearSpanItems;
  if FSortedSpans <> nil then
  begin
    FSortedSpans.Clear;
  end;
end;

procedure TPlannerHorzYearViewEh.BuildGridData;
begin
  inherited BuildGridData;
  BuildYearGridMode;
  RealignGridControls;
end;

procedure TPlannerHorzYearViewEh.BuildYearGridMode;
var
  ColWidth, FitGap: Integer;
  RowHeight: Integer;
  i: Integer;
  Groups: Integer;
  ColGroups: Integer;
  ic: Integer;
  ARecNoColWidth: Integer;
  AResColWidth: Integer;
  ADataRowCount: Integer;
  AFixedRowCount: Integer;
begin
  ClearGridCells;
  FHoursBarIndex := -1;
  if FMonthColArea = nil then Exit;

  AFixedRowCount := TopGridLineCount;

  if ResourceCaptionArea.Visible then
  begin
    if (PlannerDataSource <> nil)
      then ColGroups := PlannerDataSource.Resources.Count
      else ColGroups := 0;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;

    Groups := ColGroups;
    FResourceAxisPos := 0;
    FDataColsOffset := 1;
  end else
  begin
    if (PlannerDataSource <> nil)
      then ColGroups := PlannerDataSource.Resources.Count
      else ColGroups := 0;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;
    Groups := ColGroups;
    FResourceAxisPos := -1;
    FDataColsOffset := 0;
  end;

  FDataRowsOffset := AFixedRowCount;

  if DayNameArea.Visible then
  begin
    Inc(FDataRowsOffset);
    FDayNameBarPos := FDataRowsOffset-1;
  end else
    FDayNameBarPos := -1;

  if MonthColArea.Visible then
  begin
    FixedColCount := FDataColsOffset + 1;
    FDataColsOffset := FixedColCount;
    FMonthColIndex := FResourceAxisPos + 1;
  end else
  begin
    FixedColCount := FDataColsOffset;
    FMonthColIndex := -1;
  end;

  FixedRowCount := FDataRowsOffset;

  ADataRowCount := 12 * ColGroups + (ColGroups-1);
  ColCount := 38 + FDataColsOffset;
  RowCount := FixedRowCount + ADataRowCount;

  SetGridSize(ColCount, RowCount);
  if HandleAllocated then
  begin
    if TopGridLineCount > 0 then
      RowHeights[FTopGridLineIndex] := 1;

    if FDayNameBarPos >= 0 then
      RowHeights[FDayNameBarPos] := DayNameArea.GetActualSize;
  end;

  if FResourceAxisPos >= 0 then
  begin
    AResColWidth := 80;
    ColWidths[FResourceAxisPos] := AResColWidth;
  end else
  begin
    AResColWidth := 0;
  end;

  if FMonthColIndex >= 0 then
  begin
    ARecNoColWidth := MonthColArea.GetActualSize;
    ColWidths[FMonthColIndex] := ARecNoColWidth;
    FShowMonthNoCaption := CalcShowKeekNoCaption((GridClientHeight - VertAxis.FixedBoundary) div 6);
  end else
  begin
    ARecNoColWidth := 0;
  end;

  if Groups > 0
    then FBarsPerRes := 13
    else FBarsPerRes := 12;

  
  ColWidth := (GridClientWidth - ARecNoColWidth - AResColWidth) div 38;
  if ColWidth < DataBarsArea.ActualMinCellWidth then
  begin
    ColWidth := DataBarsArea.ActualMinCellWidth;
    HorzScrollBar.VisibleMode := sbAutoShowEh;
    FitGap := 0;
  end else
  begin
    HorzScrollBar.VisibleMode := sbNeverShowEh;
    FitGap := (GridClientWidth - HorzAxis.FixedBoundary) mod 38;
  end;

  for i := FDataColsOffset to ColCount-1 do
  begin
    if IsInterResourceCell(i, 0) then
    begin
      ColWidths[i] := 3;
    end else
    begin
      if FitGap > 0
        then ColWidths[i] := ColWidth + 1
        else ColWidths[i] := ColWidth;
      Dec(FitGap);
    end;
  end;

  
  RowHeight := (GridClientHeight - VertAxis.FixedBoundary  - (ColGroups-1)*3) div (12 * Groups);
  FitGap := (GridClientHeight - VertAxis.FixedBoundary  - (ColGroups-1)*3) mod (12 * Groups);
  if (DataBarsArea.ActualMinCellHeight > RowHeight) then
  begin
    VertScrollBar.VisibleMode := sbAutoShowEh;
    RowHeight := DataBarsArea.ActualMinCellHeight;
    FitGap := 0;
  end else
  begin
    VertScrollBar.VisibleMode := sbNeverShowEh;
  end;

  for i := FixedRowCount to RowCount-1 do
  begin
    if IsInterResourceCell(0, i) then
    begin
      RowHeights[i] := 3;
    end else
    begin
      if FitGap > 0
        then RowHeights[i] := RowHeight + 1
        else RowHeights[i] := RowHeight;
      Dec(FitGap);
    end;
  end;

  if FixedColCount >= 0 then
    MergeCells(0, 0, FixedColCount-1, FixedRowCount-1);

  if FResourceAxisPos >= 0 then
  begin
    for i := 0 to ColGroups-1 do
    begin
      ic := FBarsPerRes * i;
      MergeCells(FResourceAxisPos, ic+FDataColsOffset, 0, FBarsPerRes-2);
    end;
  end;

end;

function TPlannerHorzYearViewEh.AdjustDate(const Value: TDateTime): TDateTime;
var
  y, m, d: Word;
begin
  DecodeDate(Value, y, m, d);
  Result := EncodeDate(y, 1, 1);
end;

procedure TPlannerHorzYearViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if (Cell.X < FDataColsOffset) and (Cell.Y >= FDataRowsOffset) then
    WeekNoCellClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
end;

procedure TPlannerHorzYearViewEh.WeekNoCellClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
end;

function TPlannerHorzYearViewEh.CellToDateTime(ACol, ARow: Integer): TDateTime;
var
  DataCell: TGridCoord;
  d, m, y: Word;
  FirstCellDate: TDateTime;
  CellDate: TDateTime;
  InResYPos: Integer;
begin
  if IsInterResourceCell(ACol, ARow) then
  begin
    Result := 1;
    Exit;
  end;

  DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));
  InResYPos := DataCell.Y mod FBarsPerRes;

  if (DataCell.X < 0) or (DataCell.Y < 0) then
  begin
    Result := 1;
    Exit;
  end;

  DecodeDate(StartDate, y, m, d);
  m := InResYPos + 1;
  CellDate := EncodeDate(y, m, d);
  FirstCellDate := PlannerStartOfTheWeek(CellDate);
  Result := FirstCellDate + DataCell.X;
end;

function TPlannerHorzYearViewEh.CellIsDateRelevant(ACol, ARow: Integer): Boolean;
var
  DataCell: TGridCoord;
  DateTime: TDateTime;
  d, m, y: Word;
  InResYPos: Integer;
begin
  if IsInterResourceCell(ACol, ARow) then
  begin
    Result := False;
    Exit;
  end;

  DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));
  InResYPos := DataCell.Y mod FBarsPerRes;

  DateTime := CellToDateTime(ACol, ARow);
  DecodeDate(DateTime, y, m, d);
  if (m = InResYPos + 1) then
    Result := True
  else
    Result := False;
end;

procedure TPlannerHorzYearViewEh.GetRelevantColsForRow(ADataRow: Integer;
  out AStartDataCol, AColCount: Integer);
var
  d, m, y: Word;
  FirstCellDate: TDateTime;
  CellDate: TDateTime;
  InResYPos: Integer;
begin
  DecodeDate(StartDate, y, m, d);
  InResYPos := ADataRow mod FBarsPerRes;
  CellDate := EncodeDate(y, InResYPos + 1, 1);
  FirstCellDate := StartOfTheWeek(CellDate);
  AStartDataCol := DaysBetween(FirstCellDate, CellDate);
  AColCount := DaysInAMonth(y, InResYPos + 1);
end;

procedure TPlannerHorzYearViewEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
var
  DataCell: TGridCoord;
  Resource: TPlannerResourceEh;
  CellDate: TDateTime;
  CellDateNextRight: TDateTime;
  CellDateNextDown: TDateTime;
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
  CellIsDateRel: Boolean;
  NextRightCellIsDateRel: Boolean;
  NextDownCellIsDateRel: Boolean;
  ResIndex: Integer;
begin
  inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);

  DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));

  GetCellType(ACol, ARow, CellType, ALocalCol, ALocalRow);

  CellDate := CellToDateTime(ACol, ARow);

  CellIsDateRel := CellIsDateRelevant(ACol, ARow);

  if (ACol < ColCount-1) and
     not IsInterResourceCell(ACol+1, ARow)
  then
  begin
    CellDateNextRight := CellToDateTime(ACol+1, ARow);
    NextRightCellIsDateRel := CellIsDateRelevant(ACol+1, ARow);
  end else
  begin
    CellDateNextRight := CellDate;
    NextRightCellIsDateRel := False;
  end;

  if (ARow < RowCount-1) and
     not IsInterResourceCell(ACol, ARow+1)
  then
  begin
    CellDateNextDown := CellToDateTime(ACol, ARow+1);
    NextDownCellIsDateRel := CellIsDateRelevant(ACol, ARow+1);
  end else
  begin
    CellDateNextDown := CellDate;
    NextDownCellIsDateRel := False;
  end;

  if ((ARow-FDataRowsOffset >= 0) or ((ARow-FDataRowsOffset = -1 ) and (BorderType = cbtBottomEh))) and
     (ResourcesCount > 0) then
  begin
    Resource := nil;
    if IsInterResourceCell(ACol, ARow) then
    begin
      if BorderType in [cbtLeftEh, cbtRightEh]  then
        IsDraw := False;

      ResIndex := (ARow - FDataRowsOffset) div FBarsPerRes;
      if (ResIndex < PlannerDataSource.Resources.Count-1) then
        ResIndex := ResIndex + 1;

      if (ARow-FDataRowsOffset) div FBarsPerRes < PlannerDataSource.Resources.Count then
        Resource := PlannerDataSource.Resources[ResIndex];
    end else
    begin
      ResIndex := (ARow-FDataRowsOffset) div FBarsPerRes;
      if (ResIndex >= 0) and (ResIndex < PlannerDataSource.Resources.Count) then
        Resource := PlannerDataSource.Resources[ResIndex];
    end;
    if (Resource <> nil) and (Resource.DarkLineColor <> clDefault) then
        BorderColor := Resource.DarkLineColor;
  end;

  if IsDraw and (DataCell.X >= 0) and (DataCell.Y >= 0) then
  begin
    if (not CellIsDateRel) and (not NextRightCellIsDateRel) and (BorderType = cbtRightEh) then
      BorderColor := clBtnFace;
  end;

  if (pvoHighlightTodayEh in PlannerControl.Options) then
  begin
    if (CellType = pctDataCellEh) and
       (BorderType in [cbtBottomEh, cbtRightEh]) and
       (DateOf(CellDate) = DateOf(Today)) and
       (CellIsDateRel = True)
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end
    else if (BorderType = cbtRightEh) and
            (DateOf(CellDateNextRight) = DateOf(Today)) and
            (NextRightCellIsDateRel = True)
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end
    else if (BorderType = cbtBottomEh) and
            (DateOf(CellDateNextDown) = DateOf(Today)) and
            (NextDownCellIsDateRel = True)
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end;
  end;
end;

procedure TPlannerHorzYearViewEh.GetCellType(ACol, ARow: Integer;
  var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer);
begin
  if ARow < FDataRowsOffset then
  begin
    if ACol < FDataColsOffset then
    begin
      CellType := pctTopLeftCellEh;
      ALocalCol := ACol;
      ALocalRow := ARow;
    end else
    begin
      CellType := pctDayNameCellEh;
      ALocalCol := ACol - FixedColCount;
      ALocalRow := ARow;
    end;
  end
  else if ACol < FDataColsOffset then
  begin
    if IsInterResourceCell(ACol, ARow) then
    begin
      CellType := pctInterResourceSpaceEh;
      ALocalCol := 0;
      ALocalRow := 0;
    end else if ACol = FResourceAxisPos then
    begin
      CellType := pctResourceCaptionCellEh;
      ALocalCol := 0;
      ALocalRow := 0;
    end else
    begin
      CellType := pctMonthNameCellEh;
      ALocalCol := 0;
      ALocalRow := 0;
    end;
  end else
  begin
    if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctDataCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end
end;

procedure TPlannerHorzYearViewEh.GetMonthNameCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  WeekNoDate: TDateTime;
  s: String;
  ADataRow: Integer;
begin
  if ARow >= FDataRowsOffset then
  begin
    DrawArgs.FontName := MonthColArea.Font.Name;
    DrawArgs.FontColor := MonthColArea.Font.Color;
    DrawArgs.FontSize := MonthColArea.Font.Size;
    DrawArgs.FontStyle := MonthColArea.Font.Style;
    DrawArgs.BackColor := MonthColArea.GetActualColor;
    DrawArgs.Alignment := taCenter;
    DrawArgs.Layout := tlCenter;

    ADataRow := (ARow - FDataRowsOffset) mod FBarsPerRes;
    WeekNoDate := StartDate + 7 * ADataRow;
    s := FormatSettings.LongMonthNames[ADataRow + 1];

    DrawArgs.Value := WeekNoDate;
    DrawArgs.Text := s;
  end;
end;

procedure TPlannerHorzYearViewEh.GetDataCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; var State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  s: String;
  AddDats: Integer;
  InResCol: Integer;
  CellDate: TDateTime;
  CellIsDate: Boolean;
begin
  InResCol := (ACol-FDataColsOffset) mod FBarsPerRes;
  AddDats := 7 * (ARow-FDataRowsOffset) + InResCol;

  CellDate :=  CellToDateTime(ACol, ARow);
  CellIsDate := CellIsDateRelevant(ACol, ARow);

  DrawArgs.FontName := DataBarsArea.Font.Name;
  DrawArgs.FontColor := CheckSysColor(DataBarsArea.Font.Color);
  DrawArgs.FontSize := DataBarsArea.Font.Size;
  DrawArgs.FontStyle := DataBarsArea.Font.Style;
  DrawArgs.Resource := GetResourceAtCell(ACol, ARow);

  if (CellIsDate) then
  begin
    s := FormatDateTime('D', CellDate);
    DrawArgs.BackColor := CheckSysColor(Color);

    if FStartDate + AddDats = Date then
      Canvas.Font.Style := [fsBold];

    if (SelectedRange.FromDateTime < SelectedRange.ToDateTime) then
    begin
      if (SelectedRange.FromDateTime <= CellDate) and
         (CellDate < SelectedRange.ToDateTime) and
         (DrawArgs.Resource = SelectedRange.Resource)
      then
        State := State + [gdSelected];
    end;

    if (gdCurrent in State) or (gdSelected in State) then
    begin
      SetCellCanvasParams(ACol, ARow, ARect, State);
      DrawArgs.BackColor := Canvas.Brush.Color;
      DrawArgs.FontColor := Canvas.Font.Color;
    end else
    begin
      if IsWorkingDay(CellToDateTime(ACol, ARow)) then
        DrawArgs.BackColor := CheckSysColor(Color)
      else
      begin
        DrawArgs.Resource := GetResourceAtCell(ACol, ARow);
        DrawArgs.BackColor := GetResourceNonworkingTimeBackColor(
          DrawArgs.Resource, DrawArgs.BackColor, DrawArgs.FontColor);
     end;
    end;

    DrawArgs.Value := FStartDate + AddDats;
    DrawArgs.Text := s;
    DrawArgs.HorzMargin := 2;
    DrawArgs.VertMargin := 2;
    DrawArgs.Alignment := taRightJustify;
    DrawArgs.Layout := tlTop;
    DrawArgs.WordWrap := False;

  end else
  begin
    if gdCurrent in State then
    begin
      SetCellCanvasParams(ACol, ARow, ARect, State);
      DrawArgs.BackColor := Canvas.Brush.Color;
    end else
      DrawArgs.BackColor := CheckSysColor(clBtnFace);
    s := '';
    DrawArgs.TodayDate := sbFalseEh;
  end;
end;

function TPlannerHorzYearViewEh.GetDataCellTimeLength: TDateTime;
begin
  Result := IncDay(0, 1);
end;

procedure TPlannerHorzYearViewEh.DrawMonthViewDataCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawMonthViewDataCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerHorzYearViewEh.DrawDayNamesCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  CellDate: TDateTime;
  NextDate: TDateTime;
  CellIsDateRel: Boolean;
begin

  CellDate := CellToDateTime(ACol, ARow+1);
  CellIsDateRel := CellIsDateRelevant(ACol, ARow+1);
  NextDate := CellDate + 1;
  if (CellIsDateRel = True) and (NextDate = StartOfTheWeek(NextDate)) then
  begin
    Canvas.Pen.Color := GridLineColors.GetBrightColor;
    Canvas.Polyline([Point(ARect.Right-1, ARect.Top), Point(ARect.Right-1, ARect.Bottom)]);
    ARect.Right := ARect.Right - 1;
  end;

  inherited DrawDayNamesCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
end;

procedure TPlannerHorzYearViewEh.GetWeekDayNamesParams(ACol, ARow,
  ALocalCol, ALocalRow: Integer; var WeekDayNum: Integer; var WeekDayName: String);
begin
  WeekDayNum := ALocalCol mod 7 + 1;
  WeekDayNum := WeekDayNum + FFirstWeekDayNum - 1;
  if WeekDayNum > 7 then WeekDayNum := WeekDayNum - 7;

  if FDayNameFormat = dnfLongFormatEh then
    WeekDayName := FormatSettings.LongDayNames[WeekDayNum]
  else if FDayNameFormat = dnfShortFormatEh then
    WeekDayName := FormatSettings.ShortDayNames[WeekDayNum]
  else
    WeekDayName := '';
end;

procedure TPlannerHorzYearViewEh.DrawDataCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  CellDate: TDateTime;
  NextDate: TDateTime;
  CellIsDateRel: Boolean;
begin

  CellDate := CellToDateTime(ACol, ARow);
  CellIsDateRel := CellIsDateRelevant(ACol, ARow);
  NextDate := CellDate + 1;
  if (CellIsDateRel = True) and (NextDate = PlannerStartOfTheWeek(NextDate)) then
  begin
    Canvas.Pen.Color := GridLineColors.GetBrightColor;
    Canvas.Polyline([Point(ARect.Right-1, ARect.Top), Point(ARect.Right-1, ARect.Bottom)]);
    ARect.Right := ARect.Right - 1;
  end;

  if (SelectedRange.FromDateTime < SelectedRange.ToDateTime) then
  begin
    if (SelectedRange.FromDateTime <= CellDate) and (CellDate < SelectedRange.ToDateTime) then
      State := State + [gdSelected];
  end;

  DrawMonthViewDataCell(ACol, ARow, ARect, State, DrawArgs);
end;

procedure TPlannerHorzYearViewEh.DrawWeekNoCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawMonthViewWeekNoCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerHorzYearViewEh.DrawMonthNameCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow:
  Integer;DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawYearViewMonthNameCell(Self, Canvas, ARect, State, DrawArgs);
end;

function TPlannerHorzYearViewEh.DrawMonthDayWithWeekDayName: Boolean;
begin
  Result := False;
end;

procedure TPlannerHorzYearViewEh.GetViewPeriod(var AStartDate,
  AEndDate: TDateTime);
begin
  AStartDate := StartDate;
  AEndDate := IncYear(AStartDate);
end;

procedure TPlannerHorzYearViewEh.GridLayoutChanged;
begin
  if not (csLoading in ComponentState) and ActiveMode then
  begin
    DataBarsArea.RefreshDefaultFont;
    MonthColArea.RefreshDefaultFont;
  end;
  inherited GridLayoutChanged;
end;

function TPlannerHorzYearViewEh.IsDayNameAreaNeedVisible: Boolean;
begin
  Result := True;
end;

function TPlannerHorzYearViewEh.IsInterResourceCell(ACol, ARow: Integer): Boolean;
begin
  if (ARow-FDataRowsOffset >= 0) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0)
  then
    Result := (ARow-FDataRowsOffset) mod FBarsPerRes = FBarsPerRes - 1
  else
    Result := False;
end;

function TPlannerHorzYearViewEh.NextDate: TDateTime;
var
  y,m,d: Word;
begin
  Result := IncMonth(StartDate + 7, 1);
  DecodeDate(Result, y,m,d);
  Result := EncodeDate(y,m,1);
end;

function TPlannerHorzYearViewEh.PriorDate: TDateTime;
var
  y,m,d: Word;
begin
  Result := IncMonth(StartDate + 7, -1);
  DecodeDate(Result, y,m,d);
  Result := EncodeDate(y,m,1);
end;

function TPlannerHorzYearViewEh.AppendPeriod(ATime: TDateTime;
  Periods: Integer): TDateTime;
begin
  Result := IncYear(ATime, Periods);
end;

function TPlannerHorzYearViewEh.CalcShowKeekNoCaption(RowHeight: Integer): Boolean;
var
  MaxTextHeight: Integer;
begin
  Result := False;
  if not HandleAllocated then Exit;
  Canvas.Font := Font;
  Canvas.Font.Style := [fsBold];
  MaxTextHeight := Canvas.TextWidth('  WEEK 00  ');
  Result := MaxTextHeight < RowHeight;
end;

procedure TPlannerHorzYearViewEh.Resize;
begin
  inherited Resize;
  if HandleAllocated and ActiveMode then
  begin
    Canvas.Font := Font;
    FDataDayNumAreaHeight := Canvas.TextHeight('Wg') + 5;

    Canvas.Font := GetPlannerControl.TimeSpanParams.Font;
    FDefaultLineHeight := Canvas.TextHeight('Wg') + 3;

    SetDisplayPosesSpanItems;
  end;
  ResetDayNameFormat(2, 0);
end;

function TPlannerHorzYearViewEh.GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
begin
  Result := pcpYearEh;
end;

function TPlannerHorzYearViewEh.GetPeriodCaption: String;
begin
  Result := FormatDateTime('yyyy', StartDate + 7);
end;

function TPlannerHorzYearViewEh.WeekNoColWidth: Integer;
begin
  Result := 0;
  if not HandleAllocated then Exit;
  Canvas.Font := MonthColArea.Font;
  Result := Canvas.TextHeight('Wg');
  Result := Result + 10;
end;

function TPlannerHorzYearViewEh.DefaultHoursBarSize: Integer;
begin
  Result := WeekNoColWidth;
end;

function TPlannerHorzYearViewEh.GetResourceAtCell(ACol,
  ARow: Integer): TPlannerResourceEh;
var
  ResIdx: Integer;
begin
  if (ARow-FDataRowsOffset >= 0) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0)
  then
  begin
    ResIdx := (ARow-FDataRowsOffset) div FBarsPerRes;
    if ResIdx < PlannerDataSource.Resources.Count then
      Result := PlannerDataSource.Resources[(ARow-FDataRowsOffset) div FBarsPerRes]
    else
      Result := nil;
  end else
    Result := nil;
end;

procedure TPlannerHorzYearViewEh.GetResourceCaptionCellDrawParams(ACol,
  ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol,
  ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  inherited GetResourceCaptionCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
  DrawArgs.WordWrap := True;
end;

procedure TPlannerHorzYearViewEh.SetDisplayPosesSpanItemsForResource(AResource: TPlannerResourceEh; Index: Integer);
var
  ADCol, ADRow: Integer;
  SpanItem: TTimeSpanDisplayItemEhCrack;
  i: Integer;
  ASpanRect: TRect;
  ACellDate: TDateTime;
  AStartCellPos, ACellStartPos: TPoint;
  ASpanWidth: Integer;
  InRowStartDate: TDateTime;
  InRowBoundDate: TDateTime;
  LeftIndent: Integer;
  AStartViewDate, AEndViewDate: TDateTime;
  AStartDataCol, ADataColCount: Integer;
  SpansInRowsList: TObjectList;

  function CalcSpanWidth(AStartCol, ALenght: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i:= AStartCol to AStartCol+ALenght-1 do
      Result := Result + ColWidths[i];
  end;

  procedure AddSpanInSpansInRowsList(ARow: Integer; SpanItem: TTimeSpanDisplayItemEh);
  begin
    if (SpansInRowsList[ARow] = nil) then
      SpansInRowsList[ARow] := TList.Create;
    TList(SpansInRowsList[ARow]).Add(SpanItem);
  end;

  procedure ReleaseSpansInRowsList();
  var
    i: Integer;
  begin
    for i := 0 to SpansInRowsList.Count-1 do
    begin
      if (SpansInRowsList[i] <> nil) then
      begin
        SpansInRowsList[i].Free;
        SpansInRowsList[i] := nil;
      end;
    end;
    FreeAndNil(SpansInRowsList);
  end;

  procedure AdjustSpansHeightInRows();
  var
    i, sp: Integer;
    InRowSpanList: TList;
    ASpanItem: TTimeSpanDisplayItemEhCrack;
    ASpanRect: TRect;
    SpanAreaHeight: Integer;
    CalcedSpanHeight: Integer;
    MaxSpanLevel: Integer;
    ACellRect: TRect;
  begin
    for i := 0 to SpansInRowsList.Count-1 do
    begin
      if (SpansInRowsList[i] <> nil) then
      begin
        InRowSpanList := TList(SpansInRowsList[i]);
        SpanAreaHeight := RowHeights[i + FDataRowsOffset] - FDataDayNumAreaHeight;
        MaxSpanLevel := 0;
        ACellRect := CellRectAbs(0, i + FDataRowsOffset);
        OffsetRect(ACellRect, 0, -VertAxis.FixedBoundary + VertAxis.RolStartVisPos);

        for sp := 0 to InRowSpanList.Count-1 do
        begin
          ASpanItem := TTimeSpanDisplayItemEhCrack(InRowSpanList[sp]);
          if (ASpanItem.InCellFromCol > MaxSpanLevel) then
            MaxSpanLevel := ASpanItem.InCellFromCol;
        end;

        CalcedSpanHeight := FDefaultLineHeight;
        if (TimeSpanParams.MinHeight > 0) and (MaxSpanLevel > 0) then
        begin
          CalcedSpanHeight := SpanAreaHeight div (MaxSpanLevel + 1);
          if (CalcedSpanHeight > FDefaultLineHeight) then
            CalcedSpanHeight := FDefaultLineHeight
          else if (CalcedSpanHeight < TimeSpanParams.MinHeight) then
            CalcedSpanHeight := TimeSpanParams.MinHeight;
        end;

        for sp := 0 to InRowSpanList.Count-1 do
        begin
          ASpanItem := TTimeSpanDisplayItemEhCrack(InRowSpanList[sp]);
          ASpanRect := ASpanItem.BoundRect;
          ASpanRect.Top :=  FDataDayNumAreaHeight +
                            ACellRect.Top +
                            ASpanItem.InCellFromCol * CalcedSpanHeight;

          ASpanRect.Bottom := ASpanRect.Top + CalcedSpanHeight;

          if ASpanRect.Bottom > ACellRect.Bottom then
          begin
            ASpanItem.BoundRect := EmptyRect;
          end else
          begin
            if ResourcesCount > 0 then
              OffsetRect(ASpanRect, 0, FResourcesView[Index].GridOffset);
            ASpanItem.BoundRect := ASpanRect;
          end;
        end;
      end;
    end;
  end;

begin
  SpansInRowsList := TObjectList.Create(False);
  SpansInRowsList.Count := ColCount - FDataColsOffset - 1;
  AStartCellPos := Point(HorzAxis.FixedBoundary, VertAxis.FixedBoundary);
  ACellStartPos := AStartCellPos;
  GetViewPeriod(AStartViewDate, AEndViewDate);
  for ADCol := 0 to ColCount - FDataColsOffset - 1 do
  begin
    ACellStartPos.Y := AStartCellPos.Y;
    for ADRow := 0 to FDataRowsFor1Res - 1 do
    begin
      if (CellIsDateRelevant(ADCol + FDataColsOffset, ADRow + FDataRowsOffset)) then
      begin
        GetRelevantColsForRow(ADRow, AStartDataCol, ADataColCount);
        InRowStartDate := CellToDateTime(AStartDataCol + FDataColsOffset, ADRow + FDataRowsOffset);
        InRowBoundDate := IncMonth(InRowStartDate, 1);
        for i := 0 to SpanItemsCount-1 do
        begin
          SpanItem := TTimeSpanDisplayItemEhCrack(SortedSpan[i]);
          if SpanItem.PlanItem.Resource <> AResource then Continue;

          ACellDate := CellToDateTime(ADCol + FDataColsOffset, ADRow + FDataRowsOffset);
          if (ACellDate <= SpanItem.StartTime) and
             (ACellDate + 1 > SpanItem.StartTime) then
          begin
            if SpanItem.PlanItem.StartTime < ACellDate then
            begin
              LeftIndent := 0;
              if (SpanItem.PlanItem.StartTime < StartDate) and (SpanItem.StartTime = StartDate) then
                SpanItem.FDrawBackOutInfo := True;
            end else
            begin
              LeftIndent := 5;
              SpanItem.FAllowedInteractiveChanges := SpanItem.FAllowedInteractiveChanges + [sichSpanLeftSizingEh];
            end;
            ASpanRect.Left := ACellStartPos.X + LeftIndent;
            ASpanRect.Top :=  FDataDayNumAreaHeight + ACellStartPos.Y +
              SpanItem.InCellFromCol * FDefaultLineHeight;
            ASpanWidth := CalcSpanWidth(ADCol + FDataColsOffset, SpanItem.FStopGridRolPos - SpanItem.FStartGridRollPos);
            ASpanRect.Right := ASpanRect.Left + ASpanWidth - LeftIndent;
            if SpanItem.PlanItem.EndTime < InRowBoundDate then
            begin
              ASpanRect.Right := ASpanRect.Right - 5;
              SpanItem.FAllowedInteractiveChanges := SpanItem.FAllowedInteractiveChanges + [sichSpanRightSizingEh];
            end else
            begin
              if (SpanItem.PlanItem.EndTime > AEndViewDate) and (SpanItem.EndTime = AEndViewDate) then
                SpanItem.FDrawForwardOutInfo := True;
            end;
            ASpanRect.Bottom := ASpanRect.Top + FDefaultLineHeight;

            
            begin
              OffsetRect(ASpanRect, -HorzAxis.FixedBoundary, -VertAxis.FixedBoundary);
              if ResourcesCount > 0 then
                OffsetRect(ASpanRect, 0, FResourcesView[Index].GridOffset);
              SpanItem.BoundRect := ASpanRect;
              AddSpanInSpansInRowsList(ADRow, SpanItem);
            end;
          end;
        end;
      end;
      ACellStartPos.Y := ACellStartPos.Y + RowHeights[ADRow + FDataRowsOffset];
    end;
    ACellStartPos.X := ACellStartPos.X + ColWidths[ADCol + FDataColsOffset];
  end;

  AdjustSpansHeightInRows;
  ReleaseSpansInRowsList;
end;

procedure TPlannerHorzYearViewEh.SetDisplayPosesSpanItems;
var
  i: Integer;
begin
  SetResOffsets;
  if ResourcesCount > 0 then
  begin
    for i := 0 to PlannerDataSource.Resources.Count-1 do
      SetDisplayPosesSpanItemsForResource(PlannerDataSource.Resources[i], i);
    if FShowUnassignedResource then
      SetDisplayPosesSpanItemsForResource(nil, PlannerDataSource.Resources.Count);
  end else
    SetDisplayPosesSpanItemsForResource(nil, -1);
end;

procedure TPlannerHorzYearViewEh.SetGroupPosesSpanItems(Resource: TPlannerResourceEh);
var
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEhCrack;
  CurStack: TObjectListEh;
  CurList: TObjectListEh;
  CurColbarCount: Integer;
  FullEmpty: Boolean;

  procedure CheckPushOutStack(ABoundPos: Integer);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEhCrack;
  begin
    for i := 0 to CurStack.Count-1 do
    begin
      StackSpanItem := TTimeSpanDisplayItemEhCrack(CurStack[i]);
      if (StackSpanItem <> nil) and (StackSpanItem.FStopGridRolPos <= ABoundPos) then
      begin
        CurList.Add(CurStack[i]);
        CurStack[i] := nil;
      end;
    end;

    FullEmpty := True;
    for i := 0 to CurStack.Count-1 do
      if CurStack[i] <> nil then
      begin
        FullEmpty := False;
        Break;
      end;

    if FullEmpty then
    begin
      CurColbarCount := 1;
      CurList.Clear;
      CurStack.Clear;
    end;
  end;

  procedure PushInStack(ASpanItem: TTimeSpanDisplayItemEhCrack);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
    PlaceFound: Boolean;
  begin
    PlaceFound := False;
    if CurStack.Count > 0 then
    begin
      for i := 0 to CurStack.Count-1 do
      begin
        StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
        if StackSpanItem = nil then
        begin
          ASpanItem.FInCellCols := CurColbarCount;
          ASpanItem.FInCellFromCol := i;
          ASpanItem.FInCellToCol := i;
          CurStack[i] := ASpanItem;
          PlaceFound := True;
          Break;
        end;
      end;
    end;
    if not PlaceFound then
    begin
      if CurStack.Count > 0 then
      begin
        CurColbarCount := CurColbarCount + 1;
        for i := 0 to CurStack.Count-1 do
          TTimeSpanDisplayItemEhCrack(CurStack[i]).FInCellCols := CurColbarCount;
        for i := 0 to CurList.Count-1 do
          TTimeSpanDisplayItemEhCrack(CurList[i]).FInCellCols := CurColbarCount;
      end;
      ASpanItem.FInCellCols := CurColbarCount;
      ASpanItem.FInCellFromCol := CurColbarCount-1;
      ASpanItem.FInCellToCol := CurColbarCount-1;
      CurStack.Add(ASpanItem);
    end;
  end;

begin
  CurStack := TObjectListEh.Create;
  CurList := TObjectListEh.Create;
  CurColbarCount := 1;

  for i := 0 to SpanItemsCount-1 do
  begin
    SpanItem := TTimeSpanDisplayItemEhCrack(SortedSpan[i]);
    if SpanItem.PlanItem.Resource = Resource then
    begin
      CheckPushOutStack(SpanItem.FStartGridRollPos);
      PushInStack(SpanItem);
    end;
  end;
  CurStack.Free;
  CurList.Free;
end;

procedure TPlannerHorzYearViewEh.SetResOffsets;
var
  i: Integer;
begin
  for i := 0 to Length(FResourcesView)-1 do
    if i * FBarsPerRes < VertAxis.RolCelCount then
    begin
      if i < ResourcesCount
        then FResourcesView[i].Resource := PlannerDataSource.Resources[i]
        else FResourcesView[i].Resource := nil;
      FResourcesView[i].GridOffset := VertAxis.RolLocCelPosArr[i * FBarsPerRes];
      FResourcesView[i].GridStartAxisBar := i * FBarsPerRes;
    end;
end;

procedure TPlannerHorzYearViewEh.CalcPosByPeriod(AStartTime, AEndTime: TDateTime;
  var AStartGridPos, AStopGridPos: Integer);
begin
  AStartGridPos := TimeToGridLineRolPos(AStartTime);
  AStopGridPos := TimeToGridLineRolPos(AEndTime);
  if DateOf(AEndTime) <> AEndTime then
    Inc(AStopGridPos);
end;

procedure TPlannerHorzYearViewEh.SetTimeSpanParams(
  const Value: TPlannerControlTimeSpanParamsEh);
begin
  FTimeSpanParams.Assign(Value);
end;

procedure TPlannerHorzYearViewEh.TimeSpanParamsChagned;
begin
  BuildGridData;
end;

function TPlannerHorzYearViewEh.TimeToGridLineRolPos(ADateTime: TDateTime): Integer;
begin
  Result := DaysBetween(StartDate, ADateTime);
end;

procedure TPlannerHorzYearViewEh.InitSpanItem(
  ASpanItem: TTimeSpanDisplayItemEh);
var
  ASpanItemCrack: TTimeSpanDisplayItemEhCrack;
begin
  ASpanItemCrack := TTimeSpanDisplayItemEhCrack(ASpanItem);
  CalcPosByPeriod(
    ASpanItemCrack.StartTime, ASpanItem.EndTime,
    ASpanItemCrack.FStartGridRollPos, ASpanItemCrack.FStopGridRolPos);
  ASpanItemCrack.FGridColNum := 0;
  ASpanItemCrack.FAllowedInteractiveChanges := [sichSpanMovingEh];
  ASpanItemCrack.FTimeOrientation := toHorizontalEh;
end;

procedure TPlannerHorzYearViewEh.SortPlanItems;
var
  i: Integer;
begin
  if FSortedSpans = nil then Exit;

  FSortedSpans.Clear;
  for i := 0 to SpanItemsCount-1 do
    FSortedSpans.Add(SpanItems[i]);

  FSortedSpans.Sort(CompareSpanItemFuncBySpan);
end;

function TPlannerHorzYearViewEh.GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh(FSortedSpans[Index]);
end;

procedure TPlannerHorzYearViewEh.ReadDivByMonthPlanItem(StartDate, BoundDate: TDateTime;
  APlanItem: TPlannerDataItemEh);
var
  SpanItem: TTimeSpanDisplayItemEhCrack;
begin
  SpanItem := TTimeSpanDisplayItemEhCrack(AddSpanItem(APlanItem));
  SpanItem.FPlanItem := APlanItem;
  SpanItem.FHorzLocating := brrlGridRolAreaEh;
  SpanItem.FVertLocating := brrlGridRolAreaEh;
  if APlanItem.StartTime < StartDate then
    SpanItem.StartTime := DateOf(StartDate)
  else
    SpanItem.StartTime := DateOf(APlanItem.StartTime);
  if APlanItem.EndTime > BoundDate then
    SpanItem.EndTime :=  DateOf(BoundDate)
  else if DateOf(APlanItem.EndTime) = APlanItem.EndTime then
    SpanItem.EndTime := DateOf(APlanItem.EndTime)
  else
    SpanItem.EndTime := DateOf(APlanItem.EndTime) + 1;
  InitSpanItem(SpanItem);
end;

procedure TPlannerHorzYearViewEh.ReadPlanItem(APlanItem: TPlannerDataItemEh);
var
  i: Integer;
  StartMonthDate: TDateTime;
  StopMonthDate: TDateTime;
  d, m, y: Word;
begin
  DecodeDate(StartDate, y, m, d);
  StartMonthDate := EncodeDate(y, 1, 1);
  for i := 2 to 13 do
  begin
    StopMonthDate := IncMonth(StartMonthDate);
    if (APlanItem.StartTime < StopMonthDate) and (APlanItem.EndTime > StartMonthDate) then
      ReadDivByMonthPlanItem(StartMonthDate, StopMonthDate, APlanItem);
    StartMonthDate := StopMonthDate;
  end;
end;

procedure TPlannerHorzYearViewEh.InitSpanItemMoving(
  SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint);
var
  ACell: TGridCoord;
  ACellTime: TDateTime;
begin
  ACell := MouseCoord(MousePos.X, MousePos.Y);
  ACellTime := CellToDateTime(ACell.X, ACell.Y);
  FMovingDaysShift := DaysBetween(DateOf(SpanItem.PlanItem.StartTime), DateOf(ACellTime));
end;

procedure TPlannerHorzYearViewEh.UpdateDummySpanItemSize(MousePos: TPoint);
var
  ACell: TGridCoord;
  ANewTime: TDateTime;
  ATimeLen: TDateTime;
  ResViewIdx: Integer;
  AResource: TPlannerResourceEh;
begin
  if FPlannerState = psSpanRightSizingEh then
  begin
    ACell := MouseCoord(MousePos.X, MousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    ANewTime := IncDay(ANewTime);
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;
    if (FDummyPlanItem.EndTime <> ANewTime) and
       (FDummyPlanItem.StartTime < ANewTime) and
       (AResource = FDummyPlanItem.Resource) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.EndTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged;
    end;
  end else if FPlannerState = psSpanLeftSizingEh then
  begin
    ACell := MouseCoord(MousePos.X, MousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;
    if (FDummyPlanItem.StartTime <> ANewTime) and
       (FDummyPlanItem.EndTime > ANewTime) and
       (AResource = FDummyPlanItem.Resource) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged;
    end;
  end else if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    ACell := MouseCoord(MousePos.X, MousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y) - FMovingDaysShift;
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;

    if (FDummyPlanItem.StartTime <> ANewTime) or
       (AResource <> FDummyPlanItem.Resource) then
    begin
      ATimeLen :=  FDummyPlanItem.EndTime - FDummyPlanItem.StartTime;
      ANewTime := DateOf(ANewTime) + TimeOf(FDummyPlanItem.StartTime);

      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime;
      FDummyCheckPlanItem.EndTime := FDummyCheckPlanItem.StartTime + ATimeLen;
      FDummyCheckPlanItem.Resource := AResource;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);

      PlannerDataSourceChanged;
    end;
    ShowMoveHintWindow(FDummyPlanItem, MousePos);
  end;
end;

function TPlannerHorzYearViewEh.GetResourceViewAtCell(ACol, ARow: Integer): Integer;
begin
  if ARow < FDataColsOffset then
    Result := -1
  else if IsInterResourceCell(ACol, ARow) then
    Result := -1
  else
    Result := (ARow-FDataRowsOffset) div FBarsPerRes;
end;

function TPlannerHorzYearViewEh.NewItemParams(var StartTime, EndTime: TDateTime;
  var Resource: TPlannerResourceEh): Boolean;
begin
  if SelectedRange.FromDateTime < SelectedRange.ToDateTime then
  begin
    StartTime := SelectedRange.FromDateTime;
    EndTime := SelectedRange.ToDateTime;
  end else
  begin
    StartTime := CellToDateTime(Col, Row);
    EndTime := StartTime + EncodeTime(0, 30, 0, 0);
  end;
  Resource :=  GetResourceAtCell(Col, Row);
  Result := True;
end;

procedure TPlannerHorzYearViewEh.SetMonthColArea(const Value: TMonthBarAreaEh);
begin
  FMonthColArea.Assign(Value);
end;

function TPlannerHorzYearViewEh.GetDayNameArea: TDayNameVertAreaEh;
begin
  Result := TDayNameVertAreaEh(inherited DayNameArea);
end;

function TPlannerHorzYearViewEh.GetDefaultMonthBarWidth: Integer;
var
  i: Integer;
  w: Integer;
  sw: Integer;
begin
  Result := 10;
  Canvas.Font := MonthColArea.Font;
  sw := Canvas.TextWidth('  ');
  for i := 1 to 12 do
  begin
    w := Canvas.TextWidth(FormatSettings.LongMonthNames[i]);
    if (w > Result) then
      Result := w;
  end;
  Result := Result + sw;
end;

procedure TPlannerHorzYearViewEh.SetDayNameArea(const Value: TDayNameVertAreaEh);
begin
  inherited DayNameArea := Value;
end;

function TPlannerHorzYearViewEh.CreateDayNameArea: TDayNameAreaEh;
begin
  Result := TDayNameVertAreaEh.Create(Self);
end;

function TPlannerHorzYearViewEh.GetDataBarsArea: TYearViewDataBarAreaEh;
begin
  Result := FDataBarArea;
end;

procedure TPlannerHorzYearViewEh.SetDataBarsArea(const Value: TYearViewDataBarAreaEh);
begin
  FDataBarArea.Assign(Value);
end;

procedure TPlannerHorzYearViewEh.CMFontChanged(var Message: TMessage);
begin
  inherited;
  MonthColArea.RefreshDefaultFont;
  DataBarsArea.RefreshDefaultFont;
end;

function TPlannerHorzYearViewEh.CreateResourceCaptionArea: TResourceCaptionAreaEh;
begin
  Result := TResourceVertCaptionAreaEh.Create(Self);
end;

function TPlannerHorzYearViewEh.CreateHoursBarArea: THoursBarAreaEh;
begin
  Result := THoursVertBarAreaEh.Create(Self);
end;

{ TYearViewDataBarAreaEh }

constructor TYearViewDataBarAreaEh.Create(APlannerView: TCustomPlannerViewEh);
begin
  inherited Create(APlannerView);
end;

destructor TYearViewDataBarAreaEh.Destroy;
begin
  inherited Destroy;
end;

procedure TYearViewDataBarAreaEh.AssignFontDefaultProps;
begin
  Font.Assign(DefaultFont);
  Font.Size := Font.Size * 4 div 5;
end;

function TYearViewDataBarAreaEh.DefaultMinCellHeight: Integer;
begin
  Result := Round(40 * PlannerView.ScaleFactor);
end;

function TYearViewDataBarAreaEh.DefaultMinCellWidth: Integer;
begin
  Result := Round(40 * PlannerView.ScaleFactor);
end;

function TYearViewDataBarAreaEh.ActualMinCellHeight: Integer;
begin
  if (MinCellHeight = 0) then
    Result := DefaultMinCellHeight
  else
    Result := MinCellHeight;
end;

function TYearViewDataBarAreaEh.ActualMinCellWidth: Integer;
begin
  if (MinCellWidth = 0) then
    Result := DefaultMinCellWidth
  else
    Result := MinCellWidth;
end;

procedure TYearViewDataBarAreaEh.SetMinCellHeight(const Value: Integer);
begin
  if (FMinCellHeight <> Value) then
  begin
    FMinCellHeight := Value;
    NotifyChanges;
  end;
end;

procedure TYearViewDataBarAreaEh.SetMinCellWidth(const Value: Integer);
begin
  if (FMinCellWidth <> Value) then
  begin
    FMinCellWidth := Value;
    NotifyChanges;
  end;
end;

{ TPlannerControlTimeSpanParamsEh }

constructor TPlannerControlTimeSpanParamsEh.Create(
  APlannerView: TPlannerHorzYearViewEh);
begin
  inherited Create;
  FPlannerView := APlannerView;
end;

destructor TPlannerControlTimeSpanParamsEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPlannerControlTimeSpanParamsEh.SetMinHeight(const Value: Integer);
begin
  if (Value <> FMinHeight) then
  begin
    FMinHeight := Value;
    PlannerView.TimeSpanParamsChagned;
  end;
end;

end.
