{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{              TPrintPivotGridEh component              }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrintPivotGridsEh;

interface

{$I EhLib.Inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  EhLibVCL, Types,
{$IFDEF EH_LIB_17} System.Contnrs, {$ENDIF}
  StdCtrls, ImgList, Forms, DB, Variants,
  PivotGridsEh, PrintUtilsEh, PrntsEh, PrViewEh, GridsEh, ToolCtrlsEh;

type

{ TPivotGridPrintServiceEh }

  TPivotGridPrintServiceEh = class(TCustomPivotGridPrintServiceEh)
  private

  protected
    function CheckDrawLine(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var Color: TColor; var Width: Integer): Boolean; override;
    function GetControlCanvas: TCanvas; override;

    procedure PrintCellData(ACol, ARow: Integer; ARect: TRect); override;
    procedure SetColRowSize; override;

    procedure DrawFieldNameCell(ACol, ARow: Integer; ARect: TRect; PivotCel: TPivotCellEh); virtual;
    procedure DrawDataCell(ACol, ARow: Integer; ARect: TRect; PivotCel: TPivotCellEh); virtual;
    procedure DrawAxisValueCell(ACol, ARow: Integer; ARect: TRect; PivotCel: TPivotCellEh); virtual;
    procedure DrawAxisValueCellData(ACol, ARow: Integer; ARect: TRect; PivotCel: TPivotCellEh; ShowGroupingSign, ShowValue: Boolean); virtual;

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

  end;

implementation

uses EhLibLangConsts;

type
  TGridCrack = class(TCustomPivotGridEh);

var
  FDrawCellParams: TPivotCellDrawParamsEh;

procedure InitUnit;
begin
  FDrawCellParams := TPivotCellDrawParamsEh.Create;
end;

procedure FinalyUnit;
begin
  FreeAndNil(FDrawCellParams);
end;

{ TPivotGridPrintServiceEh }

constructor TPivotGridPrintServiceEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TPivotGridPrintServiceEh.Destroy;
begin
  inherited Destroy;
end;

function TPivotGridPrintServiceEh.GetControlCanvas: TCanvas;
begin
  Result := TGridCrack(Grid).Canvas;
end;

function TPivotGridPrintServiceEh.CheckDrawLine(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var Color: TColor;
  var Width: Integer): Boolean;
var
  IsExtend: Boolean;
begin
  TGridCrack(Grid).CheckDrawCellBorder(ACol, ARow, BorderType, Result, Color, IsExtend);
  Width := PenW;
end;

procedure TPivotGridPrintServiceEh.SetColRowSize;
var
  i: Integer;
  Grid: TGridCrack;
begin
  Grid := TGridCrack(Self.Grid);
  SetLength(ColWidths, Grid.FullColCount);
  for i := 0 to Length(ColWidths)-1 do
    ColWidths[i] := Round(Grid.ColWidths[i] * ScaleX);

  SetLength(RowHeights, Grid.FullRowCount);
  for i := 0 to Length(RowHeights)-1 do
    RowHeights[i] := Round(Grid.RowHeights[i] * ScaleY);
end;

procedure TPivotGridPrintServiceEh.PrintCellData(ACol, ARow: Integer; ARect: TRect);
var
  PivotCel: TPivotCellEh;
  Grid: TGridCrack;
begin
  Grid := TGridCrack(Self.Grid);
  Canvas.Font := Grid.Font;

  if (ACol < Grid.FVisPivotColCount) and (ARow < Grid.FVisPivotRowCount) then
  begin
    PivotCel := Grid.VisPivotGridArray[ACol, ARow];
    if PivotCel.CelType in [sctFieldNameForRowEh, sctFieldNameForColEh] then
      DrawFieldNameCell(ACol, ARow, ARect, PivotCel)
    else if PivotCel.CelType in [sctDataEh, sctHorzAggregateData, sctVertAggregateData] then
      DrawDataCell(ACol, ARow, ARect, PivotCel)
    else if PivotCel.CelType in [sctAxisValueEh, sctValuesColCaptionEh] then
      DrawAxisValueCell(ACol, ARow, ARect, PivotCel)
    else
    begin
    end;
  end else
  begin
  end;

end;

procedure TPivotGridPrintServiceEh.DrawAxisValueCell(ACol, ARow: Integer;
  ARect: TRect; PivotCel: TPivotCellEh);
var
  ShowValue: Boolean;
  ShowGroupingSign: Boolean;
  Grid: TGridCrack;

  function NextRowCellIsLevelSum(): Boolean;
  var
    NextCel: TPivotCellEh;
  begin
    if ARow < Grid.FullRowCount-1 then
    begin
      NextCel := Grid.VisPivotGridArray[ACol, ARow+1];
      Result := NextCel.VertAggrLevelCol = NextCel.VertAggrLevelRow;
    end else
      Result := False;
  end;

begin
  if CheckCellAreaDrawn(ACol, ARow) then Exit;
  Grid := TGridCrack(Self.Grid);

  if (PivotCel.VertAggrLevelRow > 0) and (PivotCel.VertAggrLevelRow >= PivotCel.VertAggrLevelCol)
   or
     (PivotCel.HorzAggrLevelCol > 0) and (PivotCel.HorzAggrLevelCol >= PivotCel.HorzAggrLevelRow)
  then
    Canvas.Font := TGridCrack(Grid).GridCellParams.AxisAggregateFont
  else
    Canvas.Font := TGridCrack(Grid).GridCellParams.AxisFont;

  if 
     (PivotCel.MasterRow >= 0) and
     (PivotCel.DrawDownLine = False) and
     (ARect.Top <= TGridCrack(Grid).VertAxis.FixedBoundary)
  then
  begin
    if NextRowCellIsLevelSum() then
    begin
      ShowGroupingSign := True;
      ShowValue := True;
    end else
      Exit;
  end else
  begin
    ShowGroupingSign := PivotCel.ShowGroupingSign;
    ShowValue := PivotCel.ShowValue;
  end;

  DrawAxisValueCellData(ACol, ARow, ARect, PivotCel, ShowGroupingSign, ShowValue);
end;

procedure TPivotGridPrintServiceEh.DrawAxisValueCellData(ACol, ARow: Integer;
  ARect: TRect; PivotCel: TPivotCellEh; ShowGroupingSign, ShowValue: Boolean);
var
  s: String;
  TreeSignRect: TRect;
  TreeElement: TTreeElementEh;
  Al: TAlignment;
  Grid: TGridCrack;
begin
  Grid := TGridCrack(Self.Grid);
  Al := taLeftJustify;

  if not Grid.DataSourceIsEmpty and
     Grid.GrandTotalRowVisible and
    (PivotCel.VertAggrLevelRow = Grid.ActualRowFlds.Count) and
    (PivotCel.VertAggrLevelCol = Grid.ActualRowFlds.Count-1)
  then
    s := EhLibLanguageConsts.GrandTotalEh
  else if not Grid.DataSourceIsEmpty and
          Grid.FShowGrandTotalCols and
          (ACol = Grid.FullColCount-1 * Grid.ActualValueFields.Count) and
          (ARow = Grid.ActualColFlds.Count)
  then
    s := EhLibLanguageConsts.GrandTotalEh
  else
  begin
    if ShowValue = True
      then s := VarToStr(PivotCel.Value)
      else s := '';

    if PivotCel.ShowValue and
      (PivotCel.PivotField <> nil) and
      (PivotCel.VertAggrLevelRow < Grid.ActualRowFlds.Count) and
      (PivotCel.HorzAggrLevelCol < Grid.ActualColFlds.Count)
    then
      s := PivotCel.PivotField.ValueAsDispayText(PivotCel.Value);

    if ((PivotCel.VertAggrLevelRow > 0) or (PivotCel.HorzAggrLevelCol > 0)) and (s <> '') then
      s := s + ' ' + EhLibLanguageConsts.TotalEh;
  end;

  if ShowGroupingSign then
  begin
    TreeSignRect := ARect;
    TreeSignRect.Right := TreeSignRect.Left + Trunc(18 * ScaleX);
    TreeElement := tehMinus;
    if PivotCel.RowsTreeNode <> nil then
    begin
      if PivotCel.RowsTreeNode.Expanded
        then TreeElement := tehMinus
        else TreeElement := tehPlus;
    end else if PivotCel.ColsTreeNode <> nil then
    begin
      if PivotCel.ColsTreeNode.Expanded
        then TreeElement := tehMinus
        else TreeElement := tehPlus;
    end;
    Canvas.Pen.Color := Grid.GridLineColors.GetDarkColor;
    Canvas.Brush.Color := Grid.GridCellParams.ActualAxisColor;
    PrintTreeElement(Canvas, TreeSignRect, TreeElement, False, ScaleX, ScaleY, False, False);
    ARect.Left := TreeSignRect.Right;
  end;

  if ShowValue then
  begin
    PrintTextEh(Canvas, ARect, PenW, PenW, s, Al, tlTop, False, False, ARect, False, False, False);
  end;
end;

procedure TPivotGridPrintServiceEh.DrawDataCell(ACol, ARow: Integer; ARect: TRect;
  PivotCel: TPivotCellEh);
var
  s: String;
  Al: TAlignment;
  IsCellFilled: Boolean;
  ACellRect: TRect;
  AState: TGridDrawState;
  Grid: TGridCrack;
begin
  Grid := TGridCrack(Self.Grid);
  Al := taRightJustify;

  Canvas.Brush.Color := Grid.GridCellParams.ActualDataColor;
  Canvas.Font := Grid.GridCellParams.DataFont;
  IsCellFilled := True;

  FDrawCellParams.InitFont(Canvas.Font);
  Grid.FillDrawCellParams(FDrawCellParams, ACol, ARow, ARect, AState, PivotCel);

  s := FDrawCellParams.DisplayValue;
  Canvas.Font := FDrawCellParams.Font;

  ACellRect := ARect;

  if (not IsCellFilled) then
    Canvas.FillRect(ARect);

  PrintTextEh(Canvas, ARect, PenW, PenW, s, Al, tlTop, False, False, ARect, False, False, False);
end;


procedure TPivotGridPrintServiceEh.DrawFieldNameCell(ACol, ARow: Integer; ARect: TRect;
  PivotCel: TPivotCellEh);
var
  s: String;
  Al: TAlignment;
  Grid: TGridCrack;
begin
  Grid := TGridCrack(Self.Grid);
  Canvas.Font := Grid.GridCellParams.FieldNameFont;

  if PivotCel.ShowValue = True then
    s := VarToStr(PivotCel.Value)
  else
    s := '';

  Al := taLeftJustify;
  if PivotCel.ShowValue then
  begin
    PrintTextEh(Canvas, ARect, PenW, PenW, s, Al, tlTop, False, False, ARect, False, False, False);
  end;
end;

procedure TPivotGridPrintServiceEh.PrintTo(VPrinter: TBaseVirtualPrinter);
begin
  if Grid = nil then
    raise Exception.Create('TPrintDBVertGridEh.Grid property is not assigned');
  inherited PrintTo(VPrinter);
end;

initialization
  InitUnit;
finalization
  FinalyUnit;
end.
