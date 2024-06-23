{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{              TPrintPlannerControlEh component         }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrintPlannersEh;

interface

{$I EhLib.Inc}

uses
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  EhLibVCL, Types,
{$IFDEF EH_LIB_17} System.Contnrs, {$ENDIF}
  StdCtrls, ImgList, Forms, DB, Variants,
  PlannersEh, PlannerDataEh, PlannerToolCtrlsEh,
  PrintUtilsEh, PrntsEh, SpreadGridsEh, PrViewEh, GridsEh,  ToolCtrlsEh;

type

  TPlannerControlPrintServiceEh = class(TCustomPlannerControlPrintServiceEh)
  private

    function GetPlannerView: TCustomPlannerViewEh;
    procedure PrintMasterCell(ACol, ARow: Integer; ARect: TRect; ACell: TSpreadGridCellEh);
    procedure PrintMasterForMergedCell(ACol, ARow: Integer; ARect: TRect; ACell: TSpreadGridCellEh);
    procedure PrintCellArea(ACol, ARow: Integer; ARect: TRect; ACell: TSpreadGridCellEh);
    procedure PrintTopLeftCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintDataCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintAlldayDataCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintDateBar(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintDateCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintDayNamesCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintInterResourceCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintResourceCaptionCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintTimeCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
    procedure PrintWeekNoCell(ACol, ARow: Integer; ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);

  protected
    FDrawSpanItemArgs: TDrawSpanItemArgsEh;
    ColStartPoses, RowStartPoses: TIntegerDynArray;

    function CheckDrawLine(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var Color: TColor; var Width: Integer): Boolean; override;
    function GetControlCanvas: TCanvas; override;

    procedure PrintCell(ACol, ARow: Integer; ARect: TRect); override;
    procedure PrintCellData(ACol, ARow: Integer; ARect: TRect); override;
    procedure SetColRowSize; override;
    procedure PrintPageCells(FromCol, ToCol, FromRow, ToRow: Integer; const CellsRect: TRect); override;
    procedure PrintSpanItems(HorzOffset, VertOffset: Integer; const CellsRect: TRect); virtual;

    procedure PrintSpanItem(SpanItem: TTimeSpanDisplayItemEh; DrawRect: TRect); virtual;
    procedure DefaultPrintSpanItem(SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure PrintSpanItemBackgroud(SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure PrintSpanItemContent(SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure PrintSpanItemSurround(SpanItem: TTimeSpanDisplayItemEh; var ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure FrameRect(const Rect: TRect; PenW: Integer); virtual;

    property PlannerView: TCustomPlannerViewEh read GetPlannerView;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure PrintTo(VPrinter: TBaseVirtualPrinter); override;

  published

    property Scale;
    property FitToPagesWide;
    property FitToPagesTall;
    property ScalingMode;
    property Orientation;
    property ColorSchema;
    property PageFooter;
    property PageHeader;
    property PageMargins;
    property TextBeforeContent;
    property TextAfterContent;

    property OnBeforePrint;
    property OnBeforePrintPage;
    property OnBeforePrintPageContent;
    property OnPrintDataBeforeGrid;
    property OnCalcLayoutDataBeforeGrid;

    property OnAfterPrint;
    property OnAfterPrintPage;
    property OnAfterPrintPageContent;
    property OnPrintDataAfterGrid;
    property OnCalcLayoutDataAfterGrid;

    property OnPrinterSetupDialog;
  end;

implementation

type
  TPlannerViewCrack = class(TCustomPlannerViewEh);
  TPlannerViewDrawElementCrack = class(TPlannerViewDrawElementEh);

procedure InitUnit;
begin
end;

procedure FinalyUnit;
begin
end;

{ TPlannerControlPrintServiceImplEh }

constructor TPlannerControlPrintServiceEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDrawSpanItemArgs := TDrawSpanItemArgsEh.Create;
end;

destructor TPlannerControlPrintServiceEh.Destroy;
begin
  FreeAndNil(FDrawSpanItemArgs);
  inherited Destroy;
end;

procedure TPlannerControlPrintServiceEh.FrameRect(const Rect: TRect; PenW: Integer);
begin
  DrawLine(Point(Rect.Left, Rect.Top), Point(Rect.Right, Rect.Top), PenW);
  DrawLine(Point(Rect.Left, Rect.Top), Point(Rect.Left, Rect.Bottom), PenW);
  DrawLine(Point(Rect.Left, Rect.Bottom-PenW), Point(Rect.Right, Rect.Bottom-PenW), PenW);
  DrawLine(Point(Rect.Right-PenW, Rect.Top), Point(Rect.Right-PenW, Rect.Bottom), PenW);
end;

function TPlannerControlPrintServiceEh.GetControlCanvas: TCanvas;
begin
  Result := TPlannerViewCrack(Planner).Canvas;
end;

function TPlannerControlPrintServiceEh.GetPlannerView: TCustomPlannerViewEh;
begin
  Result := Planner.ActivePlannerView;
end;

function TPlannerControlPrintServiceEh.CheckDrawLine(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var Color: TColor;
  var Width: Integer): Boolean;
begin
  Result := True;
  Width := PenW;
end;

procedure TPlannerControlPrintServiceEh.SetColRowSize;
var
  i: Integer;
  APlannerView: TPlannerViewCrack;

  procedure SetPrintAxisPoses(var AxisStartPoses: TIntegerDynArray;
    GridAxis: TGridAxisDataEh);
  var
    i, ri, sp: Integer;
  begin
    SetLength(AxisStartPoses, GridAxis.CelCount+1);
    sp := 0;
    for i := 0 to GridAxis.FixedCelCount-1 do
    begin
      AxisStartPoses[i] := sp;
      sp := sp + Trunc(GridAxis.FixedCelLens[i] * ScaleX);
    end;
    for i := GridAxis.FixedCelCount to GridAxis.CelCount-1 do
    begin
      ri := i - GridAxis.FixedCelCount;
      AxisStartPoses[i] := Trunc(GridAxis.RolLocCelPosArr[ri] * ScaleX) + sp;
    end;
    AxisStartPoses[GridAxis.CelCount] :=
      AxisStartPoses[GridAxis.CelCount-1] +
      Trunc(GridAxis.RolCelLens[GridAxis.RolCelCount-1] * ScaleX);
  end;

begin
  APlannerView := TPlannerViewCrack(Self.PlannerView);

  SetPrintAxisPoses(ColStartPoses, APlannerView.HorzAxis);
  SetPrintAxisPoses(RowStartPoses, APlannerView.VertAxis);

  SetLength(ColWidths, TPlannerViewCrack(APlannerView).ColCount);
  for i := 0 to Length(ColWidths)-1 do
    ColWidths[i] := Round(TPlannerViewCrack(APlannerView).ColWidths[i] * ScaleX);

  SetLength(RowHeights, TPlannerViewCrack(APlannerView).RowCount);
  for i := 0 to Length(RowHeights)-1 do
    RowHeights[i] := Round(TPlannerViewCrack(APlannerView).RowHeights[i] * ScaleY);
end;

procedure TPlannerControlPrintServiceEh.PrintCell(ACol, ARow: Integer; ARect: TRect);
var
  ACell: TSpreadGridCellEh;
begin
  if CheckCellAreaDrawn(ACol, ARow) then Exit;

  ACell := TPlannerViewCrack(PlannerView).SpreadArray[ACol, ARow];

  if ((ACell.MergeColCount > 0) or (ACell.MergeRowCount > 0)) then
  begin
    PrintMasterCell(ACol, ARow, ARect, ACell);
  end else if ((ACell.MasterMergeColOffset > 0) or (ACell.MasterMergeRowOffset > 0)) then
  begin
    PrintMasterForMergedCell(ACol, ARow, ARect, ACell);
  end else
    PrintCellArea(ACol, ARow, ARect, ACell);
end;

procedure TPlannerControlPrintServiceEh.PrintMasterCell(ACol, ARow: Integer;
  ARect: TRect; ACell: TSpreadGridCellEh);
var
  i, j: Integer;
  MasterRect: TRect;
begin
  MasterRect := ARect;
  for i := ACol+1 to ACol + ACell.MergeColCount do
    MasterRect.Right := MasterRect.Right + ColWidths[i];
  for j := ARow+1 to ARow + ACell.MergeRowCount do
    MasterRect.Bottom := MasterRect.Bottom + RowHeights[j];

  for i := ACol to ACol + ACell.MergeColCount do
  begin
    for j := ARow to ARow + ACell.MergeRowCount do
      SetCellDrawn(i, j);
  end;
  PrintCellArea(ACol, ARow, MasterRect, ACell);
end;

procedure TPlannerControlPrintServiceEh.PrintMasterForMergedCell(ACol, ARow: Integer;
  ARect: TRect; ACell: TSpreadGridCellEh);
var
  MasterCell: TSpreadGridCellEh;
  i: Integer;
  MasterCellPos: TGridCoord;
begin
  MasterCellPos := GridCoord(ACol - ACell.MasterMergeColOffset, ARow - ACell.MasterMergeRowOffset);
  MasterCell := TPlannerViewCrack(PlannerView).SpreadArray[MasterCellPos.X, MasterCellPos.Y];
  for i := ACol - 1 downto MasterCellPos.X do
    ARect.Left := ARect.Left - ColWidths[i];
  for i := ARow - 1 downto MasterCellPos.Y do
    ARect.Top := ARect.Top - RowHeights[i];
  ARect.Right := ARect.Left + ColWidths[MasterCellPos.X];
  ARect.Bottom := ARect.Top + RowHeights[MasterCellPos.Y];
  PrintMasterCell(MasterCellPos.X, MasterCellPos.Y, ARect, MasterCell);
end;

procedure TPlannerControlPrintServiceEh.PrintPageCells(FromCol, ToCol, FromRow,
  ToRow: Integer; const CellsRect: TRect);
begin
  inherited PrintPageCells(FromCol, ToCol, FromRow, ToRow, CellsRect);
  PrintSpanItems(ColStartPoses[FromCol], RowStartPoses[FromRow], CellsRect);
end;

procedure TPlannerControlPrintServiceEh.PrintSpanItems(HorzOffset,
  VertOffset: Integer; const CellsRect: TRect);
var
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  SpanDrawRect: TRect;
  TopOff: Integer;
  PlannerView: TPlannerViewCrack;
begin
  PlannerView := TPlannerViewCrack(Self.PlannerView);
  if PlannerView.SpanItemsCount > 0 then
  begin
    for i := 0 to PlannerView.SpanItemsCount-1 do
    begin
      SpanItem := PlannerView.SpanItems[i];
      SpanItem.GetInGridDrawRect(SpanDrawRect);
      SpanDrawRect.Left := Trunc(SpanDrawRect.Left * ScaleX);
      SpanDrawRect.Top := Trunc(SpanDrawRect.Top * ScaleX);
      SpanDrawRect.Right := Trunc(SpanDrawRect.Right * ScaleX);
      SpanDrawRect.Bottom := Trunc(SpanDrawRect.Bottom * ScaleX);
      if SpanItem.VertLocating = brrlWindowClientEh then
      begin
        TopOff := Trunc(PlannerView.VertAxis.GetFixedCelPos(PlannerView.FixedRowCount-1) * Scalex);
        OffsetRect(SpanDrawRect, 0, TopOff);
      end;
      OffsetRect(SpanDrawRect, -HorzOffset, -VertOffset);
      OffsetRect(SpanDrawRect, 0, CellsRect.Top);

      if RectsIntersected(CellsRect, SpanDrawRect) then
        PrintSpanItem(SpanItem, SpanDrawRect);
    end;
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintSpanItem(SpanItem: TTimeSpanDisplayItemEh;
  DrawRect: TRect);
var
  DrawState: TDrawSpanItemDrawStateEh;
  DrawProcessed: Boolean;
begin

  DrawProcessed := False;
  FDrawSpanItemArgs.DrawState := DrawState;
  FDrawSpanItemArgs.Text := SpanItem.PlanItem.Title;
  FDrawSpanItemArgs.Alignment := SpanItem.Alignment;

  if not DrawProcessed then
    DefaultPrintSpanItem(SpanItem, DrawRect, FDrawSpanItemArgs);
end;

procedure TPlannerControlPrintServiceEh.DefaultPrintSpanItem(
  SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
var
  AContentRect: TRect;
begin
  PrintSpanItemBackgroud(SpanItem, ARect, DrawArgs);
  AContentRect := ARect;
  PrintSpanItemSurround(SpanItem, AContentRect, DrawArgs);
  PrintSpanItemContent(SpanItem, AContentRect, DrawArgs);
end;

procedure TPlannerControlPrintServiceEh.PrintSpanItemBackgroud(
  SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
begin
  Canvas.Font := Planner.TimeSpanParams.Font;
  if SpanItem.PlanItem.FillColor <> clDefault then
  begin
    Canvas.Brush.Color := SpanItem.PlanItem.FillColor;
    Canvas.FillRect(ARect);
  end else
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(ARect);
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintSpanItemContent(
  SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
var
  Dx, Dy: Integer;
begin
  Canvas.Brush.Color := clWhite;
  Canvas.Font.Color := clBlack;
  Dx := Trunc(4 * ScaleX);
  Dy := Trunc(3 * ScaleY);
  PrintTextEh(Canvas, ARect, Dx, Dy, DrawArgs.Text,
    DrawArgs.Alignment, tlTop, True, True, ARect, False, False, False);
end;

procedure TPlannerControlPrintServiceEh.PrintSpanItemSurround(
  SpanItem: TTimeSpanDisplayItemEh; var ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
var
  AFrameRect: TRect;
  AFrameColor: TColor;
  CheckLenS: String;
  CheckLen: Integer;
  DrawFullOutInfo: Boolean;
  ImageRect: TRect;
  s: String;
begin

  if SpanItem.PlanItem.FillColor <> clDefault
    then AFrameColor := SpanItem.PlanItem.GetFrameColor
    else AFrameColor := Planner.TimeSpanParams.GetActualBorderColor;

  begin
    Canvas.Brush.Color := AFrameColor;
    AFrameRect := ARect;
    AFrameRect.Right := AFrameRect.Right + 1;
    AFrameRect.Bottom := AFrameRect.Bottom + 1;
    FrameRect(AFrameRect, PenW);
  end;
  Canvas.Brush.Style := bsClear;

  CheckLenS := 'From: DD MMM ' + 'To: DD MMM';
  CheckLen := Round(Canvas.TextWidth(CheckLenS) * 1.2);
  if (ARect.Right - ARect.Left) > CheckLen
    then DrawFullOutInfo := True
    else DrawFullOutInfo := False;

  if SpanItem.DrawBackOutInfo then
  begin
    if SpanItem.TimeOrientation = toHorizontalEh then
    begin
      ImageRect := Rect(ARect.Left, ARect.Top, ARect.Left+16, ARect.Bottom);
      // TODO:
//      DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 0, 0, 0, taCenter, ImageRect);
      if DrawFullOutInfo
        then s := 'From: ' + FormatDateTime('DD MMM', SpanItem.PlanItem.StartTime)
        else s := '';
      ARect.Left := ARect.Left + 12;
      // TODO:
//      WriteTextEh(Canvas, ARect, False, 4, 3, s,
//        taLeftJustify, tlTop, True, True, 0, 0, False, True);
      ARect.Left := ARect.Left + Canvas.TextWidth(s) + 4;
      ARect.Left := ARect.Left + 12;
    end else
    begin
      ImageRect := Rect(ARect.Left, ARect.Top, ARect.Left+16, ARect.Top+16);
      // TODO:
//      DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 2, 0, 0, taCenter, ImageRect);
      ARect.Top := ARect.Top + 12;
    end;
  end;

  if SpanItem.DrawForwardOutInfo then
  begin
    if SpanItem.TimeOrientation = toHorizontalEh then
    begin
      ImageRect := Rect(ARect.Right-16, ARect.Top, ARect.Right, ARect.Bottom);
      // TODO:
//      DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 1, 0, 0, taCenter, ImageRect);
      if DrawFullOutInfo
        then s := 'To: ' + FormatDateTime('DD MMM', SpanItem.PlanItem.EndTime)
        else s := '';
      ARect.Right := ARect.Right - 12;
      // TODO:
//      WriteTextEh(Canvas, ARect, False, 4, 3, s,
//        taRightJustify, tlTop, True, True, 0, 0, False, True);
      ARect.Right := ARect.Right - Canvas.TextWidth(s) - 4;
      ARect.Right := ARect.Right - 12;
    end else
    begin
      ImageRect := Rect(ARect.Left, ARect.Bottom-16, ARect.Left+16, ARect.Bottom);
      // TODO:
//      DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 3, 0, 0, taCenter, ImageRect);
      ARect.Bottom := ARect.Bottom + 12;
    end;
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintCellArea(ACol, ARow: Integer;
  ARect: TRect; ACell: TSpreadGridCellEh);
begin
  PrintBorders(ACol, ARow, ARect, [cbtBottomEh, cbtRightEh]);
  PrintCellData(ACol, ARow, ARect);
end;

procedure TPlannerControlPrintServiceEh.PrintCellData(ACol, ARow: Integer; ARect: TRect);
var
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
  Grid: TPlannerViewCrack;
  State: TGridDrawState;
  ADrawCellArgs: TPlannerViewCellDrawArgsEh;
begin
  Grid := TPlannerViewCrack(PlannerView);
  Grid.GetCellType(ACol, ARow, CellType, ALocalCol, ALocalRow);
  State := [];
  ADrawCellArgs := Grid.GetCellDrawArgs(CellType);
  Grid.GetDrawCellParams(ACol, ARow, ARect, State, CellType, ALocalCol, ALocalRow, ADrawCellArgs);
  ADrawCellArgs.HorzMargin := Trunc(ADrawCellArgs.HorzMargin * ScaleX);
  ADrawCellArgs.VertMargin := Trunc(ADrawCellArgs.VertMargin * ScaleY);

  case CellType of
    pctTopLeftCellEh:
      PrintTopLeftCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctDataCellEh:
      PrintDataCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctAlldayDataCellEh:
      PrintAlldayDataCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctResourceCaptionCellEh:
      PrintResourceCaptionCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctInterResourceSpaceEh:
      PrintInterResourceCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctDayNameCellEh:
      PrintDayNamesCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctDateBarEh:
      PrintDateBar(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctDateCellEh:
      PrintDateCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctTimeCellEh:
      PrintTimeCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
    pctWeekNoCellEh:
      PrintWeekNoCell(ACol, ARow, ARect, ALocalCol, ALocalRow, ADrawCellArgs);
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintTopLeftCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TPlannerControlPrintServiceEh.PrintDataCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := DrawArgs.FontColor;
  Canvas.Brush.Color := clWhite;

  if DrawArgs.Text <> '' then
  begin
    // TODO:
//    WriteTextEh(Canvas, ARect, False, DrawArgs.HorzMargin, DrawArgs.VertMargin,
//      DrawArgs.Text, DrawArgs.Alignment, DrawArgs.Layout, DrawArgs.WordWrap,
//      False, 0, 0, False, True);
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintAlldayDataCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TPlannerControlPrintServiceEh.PrintResourceCaptionCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  s: String;
  Resource: TPlannerResourceEh;
  ResCap: TPlannerViewDrawElementCrack;
begin
  Resource := TPlannerViewCrack(PlannerView).GetResourceAtCell(ACol, ARow);
  ResCap := TPlannerViewDrawElementCrack(TPlannerViewCrack(PlannerView).ResourceCaptionArea);
  Canvas.Font := ResCap.Font;
  if Resource = nil then
  begin
    Canvas.Brush.Color := ResCap.GetActualColor;
    s := 'Unassigned';
  end else
  begin
    if Resource.Color = clDefault
      then Canvas.Brush.Color := TPlannerViewCrack(PlannerView).ResourceCellFillColor
      else Canvas.Brush.Color := Resource.FaceColor;
    s := Resource.Name;
  end;
  // TODO:
//  WriteTextEh(Canvas, ARect, True, 0, 0, s, taCenter, tlCenter, False, False, 0, 0, False, False);
end;

procedure TPlannerControlPrintServiceEh.PrintInterResourceCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TPlannerControlPrintServiceEh.PrintDateBar(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := DrawArgs.FontColor;
  Canvas.Brush.Color := clWhite;

  if DrawArgs.Text <> '' then
  begin
    if DrawArgs.Orientation = tohVertical then
    begin
      // TODO:
//      WriteTextVerticalEh(Canvas, ARect, False, 0, 0, DrawArgs.Text,
//        taCenter, tlCenter, False, False, False)
    end
    else
    begin
      // TODO:
//      WriteTextEh(Canvas, ARect, False, DrawArgs.HorzMargin, DrawArgs.VertMargin,
//        DrawArgs.Text, DrawArgs.Alignment, DrawArgs.Layout, DrawArgs.WordWrap,
//        False, 0, 0, False, True);
    end;
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintDayNamesCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  DName: String;
  DNum: Integer;
  CellDate: TDateTime;
  Resource: TPlannerResourceEh;
  Grid: TPlannerViewCrack;
  NameArea: TPlannerViewDrawElementCrack;
begin
  Grid := TPlannerViewCrack(PlannerView);
  Resource := Grid.GetResourceAtCell(ACol, ARow);
  NameArea := TPlannerViewDrawElementCrack(TPlannerViewCrack(PlannerView).DayNameArea);

  Grid.GetWeekDayNamesParams(ACol, ARow, ALocalCol, ALocalRow, DNum, DName);

  Canvas.Font := NameArea.Font;
  if (Resource <> nil) and (Resource.Color <> clDefault)
    then Canvas.Brush.Color := Resource.FaceColor
    else Canvas.Brush.Color := NameArea.GetActualColor;

  // TODO:
//  WriteTextEh(Canvas, ARect, True, 0, 0, DName, taCenter, tlCenter, False, False, 0, 0, False, False);

  if Grid.DrawMonthDayWithWeekDayName then
  begin
    CellDate := Grid.CellToDateTime(ACol, ARow);
    DName := FormatDateTime('DD', CellDate);
    Canvas.Font.Style := [fsBold];
    // TODO:
//    WriteTextEh(Canvas, ARect, False, 2, 2, DName, taLeftJustify, tlTop, False, False, 0, 0, False, True);
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintDateCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := DrawArgs.FontColor;
  Canvas.Brush.Color := clWhite;

  if DrawArgs.Text <> '' then
  begin
    if DrawArgs.Orientation = tohVertical then
    begin
      // TODO:
//      WriteTextVerticalEh(Canvas, ARect, False, 0, 0, DrawArgs.Text,
//        taCenter, tlCenter, False, False, False)
    end
    else
    begin
      // TODO:
//      WriteTextEh(Canvas, ARect, False, DrawArgs.HorzMargin, DrawArgs.VertMargin,
//        DrawArgs.Text, DrawArgs.Alignment, DrawArgs.Layout, DrawArgs.WordWrap,
//        False, 0, 0, False, True);
    end;
  end;
end;

procedure TPlannerControlPrintServiceEh.PrintTimeCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  SH, SM: String;
  mSize: TSize;
  HourRect, MinRect: TRect;
  Grid: TPlannerViewCrack;
  HoursArea: TPlannerViewDrawElementCrack;
  TimeCellDrawArgs: TPlannerViewTimeCellDrawArgsEh;
begin

  Grid := TPlannerViewCrack(PlannerView);
  HoursArea := TPlannerViewDrawElementCrack(TPlannerViewCrack(PlannerView).HoursBarArea);
  TimeCellDrawArgs := TPlannerViewTimeCellDrawArgsEh(DrawArgs);

  HourRect := ARect;
  HourRect.Right := (HourRect.Right + HourRect.Left) div 2 + 5;
  MinRect := ARect;
  MinRect.Left := HourRect.Right;

  SH := TimeCellDrawArgs.HoursStr;

  SM := TimeCellDrawArgs.MinutesStr;
  Canvas.Brush.Color := HoursArea.GetActualColor;
  Canvas.Font := Grid.Font;
  mSize := Canvas.TextExtent(SM);

  Canvas.Font := HoursArea.Font;

  // TODO:
//  WriteText(Canvas, HourRect, -4, mSize.cy div 2, SH, taRightJustify);

  Canvas.Font.Size := Canvas.Font.Size * 2 div 3;

  // TODO:
//  WriteTextEh(Canvas, MinRect, True, 0, 2, SM,
//    taLeftJustify, tlTop, False, False, 0, 0, False, True);
end;

procedure TPlannerControlPrintServiceEh.PrintWeekNoCell(ACol, ARow: Integer;
  ARect: TRect; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;

  // TODO:
//  WriteTextVerticalEh(Canvas, ARect, False, 0, 0, DrawArgs.Text,
//    taCenter, tlCenter, False, False, False);
end;

procedure TPlannerControlPrintServiceEh.PrintTo(VPrinter: TBaseVirtualPrinter);
begin
  if Planner = nil then
    raise Exception.Create('TPrintPlannerControlEh.Planner property is not assigned');
  inherited PrintTo(VPrinter);
end;

initialization
  InitUnit;
finalization
  FinalyUnit;
end.
