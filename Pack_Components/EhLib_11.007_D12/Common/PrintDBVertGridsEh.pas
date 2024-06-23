{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{              TPrintDBVertGridEh component             }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrintDBVertGridsEh;

interface

{$I EhLib.Inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  EhLibVCL, Types,
{$IFDEF EH_LIB_17} System.Contnrs, System.UITypes, {$ENDIF}
  StdCtrls, ImgList, Forms, DB,
  DBVertGridsEh, PrintUtilsEh, PrntsEh, PrViewEh, GridsEh,
  ToolCtrlsEh, DBAxisGridsEh;

type

{ TDBVertGridPrintServiceEh }

  TDBVertGridPrintServiceEh = class(TCustomDBVertGridPrintServiceEh)
  private
  protected
    FDrawParams: TAxisColCellParamsEh;

    function CheckDrawLine(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var Color: TColor; var Width: Integer): Boolean; override;
    function GetControlCanvas: TCanvas; override;

    procedure PrintCellData(ACol, ARow: Integer; ARect: TRect); override;
    procedure SetColRowSize; override;

    procedure DrawDataCell(ACol, ARow, AreaCol, AreaRow: Integer; ARect: TRect; FieldRow: TFieldRowEh); virtual;
    procedure DrawLabelCell(ACol, ARow, AreaCol, AreaRow: Integer; ARect: TRect; FieldRow: TFieldRowEh); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure PrintTo(VPrinter: TBaseVirtualPrinter); override;
  end;

implementation

type
  TGridCrack = class(TCustomDBVertGridEh);
  TAxisColCellParamsEhCrack = class(TAxisColCellParamsEh);

{ TPrintDBGridEh }

constructor TDBVertGridPrintServiceEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDrawParams := TAxisColCellParamsEh.Create;
end;

destructor TDBVertGridPrintServiceEh.Destroy;
begin
  FreeAndNil(FDrawParams);
  inherited Destroy;
end;

function TDBVertGridPrintServiceEh.GetControlCanvas: TCanvas;
begin
  Result := TGridCrack(Grid).Canvas;
end;

function TDBVertGridPrintServiceEh.CheckDrawLine(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var Color: TColor;
  var Width: Integer): Boolean;
var
  IsExtend: Boolean;
begin
  TGridCrack(Grid).CheckDrawCellBorder(ACol, ARow, BorderType, Result, Color, IsExtend);
  Width := PenW;
end;

procedure TDBVertGridPrintServiceEh.SetColRowSize;
var
  i: Integer;
begin
  SetLength(ColWidths, TGridCrack(Grid).ColCount);
  for i := 0 to Length(ColWidths)-1 do
    ColWidths[i] := Round(TGridCrack(Grid).ColWidths[i] * ScaleX);

  SetLength(RowHeights, TGridCrack(Grid).RowCount);
  for i := 0 to Length(RowHeights)-1 do
    RowHeights[i] := Round(TGridCrack(Grid).RowHeights[i] * ScaleY);
end;

procedure TDBVertGridPrintServiceEh.PrintCellData(ACol, ARow: Integer; ARect: TRect);
var
  AreaCol, AreaRow: Integer;
  FieldRow: TFieldRowEh;
  ANode: TDBVertGridCategoryTreeNodeEh;
  TreeSignRect: TRect;
  i: Integer;
  DefaultRowHeight: Integer;
  FullRect: TRect;
  TextRect: TRect;
  TreeElement: TTreeElementEh;
  //ExpGlyph: TTreeViewGlyphStyleEh;
begin
  AreaCol := ACol;
  AreaRow := ARow;

  if Grid.RowCategories.Active then
  begin
    ANode := Grid.RowCategories.CurrentCategoryTree.FlatItem[AreaRow];
    DefaultRowHeight := Trunc(TGridCrack(Grid).DefaultRowHeight * ScaleX);
    if ANode.RowType = vgctFieldRowEh then
    begin
      FieldRow := ANode.FieldRow;
      if ACol = 0 then
      begin
        TreeSignRect := ARect;
        TreeSignRect.Right := ARect.Left;
        TreeSignRect.Left := TreeSignRect.Right - DefaultRowHeight;

        Canvas.Brush.Color := clWhite;
        for i := 0 to ANode.Level - 2 do
        begin
          OffsetRect(TreeSignRect, DefaultRowHeight, 0);
          if ANode = ANode.Parent[ANode.Parent.ItemsCount-1] then
          begin
            Canvas.Pen.Color := Grid.LabelColParams.GetHorzLineColor;
            DrawAxisLine(TreeSignRect, cbtBottomEh, Canvas.Pen.Color, PenW, 0);
            Dec(TreeSignRect.Bottom, PenW);
          end;
        end;

        Inc(ARect.Left, DefaultRowHeight * (ANode.Level - 1));
        begin
          Canvas.Pen.Color := Grid.LabelColParams.GetHorzLineColor;
          if dgvhRowLines in Grid.Options then
          begin
            DrawAxisLine(ARect, cbtBottomEh, Canvas.Pen.Color, PenW, 0);
            Dec(ARect.Bottom, PenW);
          end;
          DrawAxisLine(ARect, cbtLeftEh, Canvas.Pen.Color, PenW, PenW);
          Inc(ARect.Left, PenW);
        end;
        DrawLabelCell(ACol, ARow, AreaCol, AreaRow, ARect, FieldRow);

      end else
      begin
        Dec(AreaCol);
        DrawDataCell(ACol, ARow, AreaCol, AreaRow, ARect, FieldRow);
      end;

    end else if ANode.RowType = vgctCategoryRowEh then
    begin

      FullRect := ARect;
      if ACol = 0 then
      begin
        FullRect.Right := ARect.Right + Trunc(ColWidths[1] * ScaleX);
        if (dgvhColLines in Grid.Options) and not Grid.GridLineParams.DataVertLines then
          FullRect.Right := FullRect.Right + TGridCrack(Grid).VertLineWidth;
      end else
        FullRect.Left := ARect.Left - Trunc(ColWidths[1] * ScaleX) - TGridCrack(Grid).VertLineWidth;

      TextRect := FullRect;
      Canvas.Font := Grid.RowCategories.Font;
      Canvas.Font.Color := clBlack;
      Canvas.Brush.Color := clWhite;

      TreeSignRect := FullRect;
      TreeSignRect.Right := FullRect.Left;
      TreeSignRect.Left := TreeSignRect.Right - DefaultRowHeight;

      for i := 0 to ANode.Level - 1 do
      begin
        OffsetRect(TreeSignRect, DefaultRowHeight, 0);
        if (ANode.Expanded = False) or (ANode.Count = 0)
          then Canvas.Pen.Color := Grid.LabelColParams.GetHorzLineColor
          else Canvas.Pen.Color := Canvas.Brush.Color;

        Canvas.Polyline([Point(TreeSignRect.Left, TreeSignRect.Bottom-1),
                         Point(TreeSignRect.Right, TreeSignRect.Bottom-1)]);
        Dec(TreeSignRect.Bottom, 1);

        Canvas.FillRect(TreeSignRect);
        if ANode.Expanded
          then TreeElement := tehMinus
          else TreeElement := tehPlus;
        if ANode.HasChildren then
        begin
          Canvas.Pen.Color := clWindowText;
//          ExpGlyph := Grid.RowCategories.ExpandingGlyphStyle;
//          if ExpGlyph = tvgsDefaultEh then
//            ExpGlyph := tvgsThemedEh;

          PrintTreeElement(Canvas, TreeSignRect, TreeElement, False, ScaleX, ScaleY,
            Grid.UseRightToLeftAlignment, True);
        end;
      end;

      Inc(FullRect.Left, DefaultRowHeight * (ANode.Level));
      begin
        Canvas.Pen.Color := Grid.LabelColParams.GetHorzLineColor;
        Canvas.Polyline([Point(FullRect.Left, FullRect.Bottom-1),
                         Point(FullRect.Right, FullRect.Bottom-1)]);
        Dec(FullRect.Bottom);
      end;

      TreeSignRect := TextRect;
      TreeSignRect.Right := TreeSignRect.Left;
      TreeSignRect.Left := TreeSignRect.Left - DefaultRowHeight;

      PrintTextEh(Canvas, FullRect, 2, 1,
        ANode.CategoryDisplayText, taLeftJustify, tlCenter, False,
        False, FullRect, False, False, False);
    end;

  end else
  begin
    FieldRow := TGridCrack(Grid).Rows[ARow];
    if ACol < TGridCrack(Grid).DataColOffset then
      DrawLabelCell(ACol, ARow, AreaCol, AreaRow, ARect, FieldRow)
    else
    begin
      Dec(AreaCol, TGridCrack(Grid).DataColOffset);
      DrawDataCell(ACol, ARow, AreaCol, AreaRow, ARect, FieldRow);
    end;
  end;
end;

procedure TDBVertGridPrintServiceEh.PrintTo(VPrinter: TBaseVirtualPrinter);
begin
  if Grid = nil then
    raise Exception.Create('TPrintDBVertGridEh.Grid property is not assigned');
  inherited PrintTo(VPrinter);
end;

procedure TDBVertGridPrintServiceEh.DrawLabelCell(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect; FieldRow: TFieldRowEh);
var
  VFrameOffs: Integer;
  HFrameOffs: Integer;
  Grid: TGridCrack;
begin
  Grid := TGridCrack(Self.Grid);
  HFrameOffs := 3 * PenW;
  if Grid.Flat
    then VFrameOffs := 1 * PenW
    else VFrameOffs := 2 * PenW;

  FieldRow := TFieldRowEh(FieldRow);
  Canvas.Font := FieldRow.RowLabel.Font;

  PrintTextEh(Canvas, ARect, HFrameOffs, VFrameOffs,
    FieldRow.RowLabel.Caption, FieldRow.RowLabel.Alignment, tlCenter,
    Grid.RowsDefValues.RowLabel.WordWrap,
    FieldRow.RowLabel.EndEllipsis, ARect,
    False, False, False);
end;

procedure TDBVertGridPrintServiceEh.DrawDataCell(ACol, ARow: Longint;
  AreaCol, AreaRow: Longint; ARect: TRect;
  FieldRow: TFieldRowEh);
var
  VFrameOffs: Integer;
  HFrameOffs: Integer;
  Grid: TGridCrack;
  ARect1: TRect;
  IsWordWrap: Boolean;
begin
  Grid := TGridCrack(Self.Grid);
  HFrameOffs := 3 * PenW;
  if Grid.Flat
    then VFrameOffs := 1 * PenW
    else VFrameOffs := 2 * PenW;


  FieldRow.FillColCellParams(FDrawParams);
  Grid.GetCellParams(FieldRow, FDrawParams.Font, TAxisColCellParamsEhCrack(FDrawParams).FBackground, FDrawParams.State);
  FieldRow.GetColCellParams(False, FDrawParams);

  Canvas.Font := FDrawParams.Font;
  Canvas.Brush.Color := FDrawParams.Background;

  ARect1 := ARect;
  if (FieldRow.ImageList <> nil) and FieldRow.ShowImageAndText then
  begin
    ARect1.Right := ARect1.Left + Trunc((FieldRow.ImageList.Width + 4) * ScaleX);
    Canvas.Brush.Color := FieldRow.Color;
    if Canvas.Brush.Color <> clWhite then
      Canvas.FillRect(ARect);
    // TODO:
//    DrawClipped(FieldRow.ImageList, nil, Canvas, ARect1,
//      FDrawParams.ImageIndex, 0, 0, taCenter, ARect1, ScaleX);
    Canvas.Brush.Color := FDrawParams.Background;
    ARect1.Left := ARect1.Right + PenW;
    ARect1.Right := ARect.Right;
  end;

  if FieldRow.GetBarType in [ctCommon..ctKeyPickList] then
  begin
    IsWordWrap := FieldRow.WordWrap and FieldRow.CurLineWordWrap(ARect.Bottom-ARect.Top);
    PrintTextEh(Canvas, ARect1,
      HFrameOffs, VFrameOffs, FDrawParams.Text, FDrawParams.Alignment, FieldRow.Layout,
      IsWordWrap, FieldRow.EndEllipsis, ARect1, False, False, False);

  end else if FieldRow.GetBarType = ctKeyImageList then
  begin
    if Canvas.Brush.Color <> clWhite then
      Canvas.FillRect(ARect1);
    // TODO:
//    DrawClipped(FieldRow.ImageList, nil, Canvas, ARect1,
//      FDrawParams.ImageIndex, 0, 0, taCenter, ARect1, ScaleX);
  end else if FieldRow.GetBarType = ctCheckboxes then
  begin
    if Canvas.Brush.Color <> clWhite then
      Canvas.FillRect(ARect);
    ARect1.Left := ARect.Left + iif(ARect.Right - ARect.Left < DefaultCheckBoxWidth, 0,
      (ARect.Right - ARect.Left) shr 1 - DefaultCheckBoxWidth shr 1);
    ARect1.Right := iif(ARect.Right - ARect.Left < DefaultCheckBoxWidth, ARect.Right,
      ARect1.Left + DefaultCheckBoxWidth);
    ARect1.Top := ARect.Top + iif(ARect.Bottom - ARect.Top < DefaultCheckBoxHeight, 0,
      (ARect.Bottom - ARect.Top) shr 1 - DefaultCheckBoxHeight shr 1);
    ARect1.Bottom := iif(ARect.Bottom - ARect.Top < DefaultCheckBoxHeight, ARect.Bottom,
      ARect1.Top + DefaultCheckBoxHeight);
    DrawCheckBoxEh(Canvas.Handle, ARect, FDrawParams.CheckboxState, True,
      Grid.Flat, False, False);
  end else if FieldRow.GetBarType = ctGraphicData then
  begin
    if (Canvas.Brush.Color <> clWhite) then
      Canvas.FillRect(ARect);
    PrintGraphicField(Canvas, FieldRow.Field, ARect, ARect, False, ScaleX, ScaleX);
  end;
end;

end.

