{******************************************}
{                                          }
{             FastReport VCL               }
{           CellularText Object            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxCellularTextObject;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LazHelper,
{$ELSE}
  WideStrings,
{$ENDIF}
  SysUtils, Types, Classes, Graphics, Variants, Controls,
  frCoreClasses, frxClass, frxTableObject, frUnicodeUtils;

type

{$IFDEF DELPHI16}
/// <summary>
///   The TfrxReportCellularTextObject allows use of the CellularText component
///   in a report. TfrxReportCellularTextObject is an empty component. It is
///   used to add CellularText unit to uses clause of an application.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxReportCellularTextObject = class(TComponent)  // fake component
  end;

  /// <summary>
  ///   The CellularText report object class. A report objects of this class
  ///   automatically breaks text to table cell where each symbol of the text
  ///   place in sperate cell. It supports align and text wrapping.
  /// </summary>
  TfrxCellularText = class(TfrxCustomMemoView)
  private
    FCellWidth: Extended;
    FCellHeight: Extended;
    FHorzSpacing: Extended;
    FVertSpacing: Extended;
    function GetCellWidth: Extended;
    function GetCellHeight: Extended;
    procedure SetCellWidth(Value: Extended);
    procedure SetCellHeight(Value: Extended);
    procedure WrapText(sLines: TWideStrings; ColumnCount: Integer);
  protected
    procedure Loaded; override;
    procedure UpdateSize;

    procedure BuildArray(aTable: TfrxTableObject; var aCellHeight: Extended;
      var sLines: TWideStrings; var sText: WideString; var ColColumn: Integer);
    procedure BuildTableFromArray(aTable: TfrxTableObject; aCellHeight: Extended;
      sLines: TWideStrings; sText: WideString; ColColumn: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    function CalcHeight: Extended; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    function DrawPart: Extended; override;
    function ExportInternal(Filter: TfrxCustomExportFilter): Boolean; override;
    class function GetDescription: String; override;
    procedure UpdateBounds; override;
    procedure BuildTable(aTable: TfrxTableObject);
  published
    property AllowExpressions;
    property BrushStyle;
    property Color;
    /// <summary>
    ///   Width of the cell.
    /// </summary>
    property CellWidth: Extended read FCellWidth write SetCellWidth;
    /// <summary>
    ///   Height of the cell.
    /// </summary>
    property CellHeight: Extended read FCellHeight write SetCellHeight;
    /// <summary>
    ///   Horizontal spacing between cells.
    /// </summary>
    property HorzSpacing: Extended read FHorzSpacing write FHorzSpacing;
    /// <summary>
    ///   Vertical spacing between cells.
    /// </summary>
    property VertSpacing: Extended read FVertSpacing write FVertSpacing;
    property DataField;
    property DataSet;
    property DataSetName;
    property DisplayFormat;
    property ExpressionDelimiters;
    property Font;
    property Frame;
    property FillType;
    property Fill;
    property HAlign;
    property HideZeros;
    property Highlight;
    property Memo;
    property ParentFont;
    property RTLReading;
    property SuppressRepeated;
    property Style;
    property UseDefaultCharset;
    property WordWrap;
    property VAlign;
  end;




implementation

uses
{$IFNDEF Linux}
{$IFNDEF NO_EDITORS}
  frxCellularTextInPlaceEditor,
{$ENDIF}
{$ENDIF}
  Math, frxGraphicUtils, frxRes, frxUtils, frxDesgnEditors, frxDsgnIntf,
  frxCellularTextObjectRTTI;


{ TfrxTableCell }

procedure TfrxCellularText.BuildArray(aTable: TfrxTableObject;
  var aCellHeight: Extended; var sLines: TWideStrings; var sText: WideString; var ColColumn: Integer);
var
  aCellWidth: Extended;
begin
  aTable.RowCount := 0;
  aTable.ColumnCount := 0;
  aCellHeight := FCellHeight;
  aCellWidth := FCellWidth;
  if (aCellHeight = 0) or (aCellWidth = 0) then
  begin
    aCellHeight := GetCellHeight;
    aCellWidth := aCellHeight;
  end;

  aTable.DefaultCellHeight := aCellHeight;
  aTable.DefaultCellWidth := aCellWidth;
  aTable.RowCount := Trunc((Height + FVertSpacing) / (aCellHeight + FVertSpacing));
  if FVertSpacing > 0 then
    aTable.RowCount := aTable.RowCount * 2 - 1;
  ColColumn := Trunc((Width + FHorzSpacing) / (aCellWidth + FHorzSpacing));
  sText := Text;
  WrapText(sLines, ColColumn);
  if FHorzSpacing > 0 then
    aTable.ColumnCount := ColColumn * 2 - 1
  else
    aTable.ColumnCount := ColColumn;
end;

procedure TfrxCellularText.BuildTableFromArray(aTable: TfrxTableObject;
  aCellHeight: Extended; sLines: TWideStrings; sText: WideString; ColColumn: Integer);
var
  i, X, Y, ln, Idx: Integer;
  IsGapRow, IsGapCol: Boolean;
  cell: TfrxTableCell;
begin
  Ln := 0;
  i := 0;
  for Y := 0 to aTable.RowCount - 1 do
  begin
    IsGapRow := (Y mod 2 = 1) and (FVertSpacing > 0) and (Y <> aTable.RowCount - 1);
    if IsGapRow then
      aTable.Rows[y].Height := FVertSpacing
    else
    begin
      aTable.Rows[y].Height := aCellHeight;

      if Ln < sLines.Count then
        sText := Trim(sLines[Ln])
      else
        sText := '';
      Inc(Ln);
      case HAlign of
        haLeft:
          i := 0;
        haRight:
          i := ColColumn - Length(sText);
      else
        i := (ColColumn - Length(sText)) div 2;
      end;
    end;
    Idx := 0;
    for X := 0 to aTable.ColumnCount - 1 do
    begin
      cell := aTable.Cells[X, Y];
      IsGapCol := (X mod 2 = 1) and (FHorzSpacing > 0) and (X <> aTable.ColumnCount - 1);
      if IsGapCol then
        aTable.Columns[X].Width := FHorzSpacing;
      if IsGapRow or IsGapCol then
      begin
        cell.Frame.Typ := [];
        Continue;
      end;
      cell.FillType := FillType;
      cell.Fill.Assign(Fill);
      cell.Frame.Assign(Frame);
      cell.Font.Assign(Font);
      cell.VAlign := vaCenter;
      cell.HAlign := haCenter;
      cell.CreateCellTag(Ln, sLines.Count, Length(sText), Idx, i);
      if (Length(sText) > Idx - i) and (Idx - i >= 0) then
        cell.Text := sText[Idx - i + 1];
      Inc(Idx)
    end;
  end;
end;

procedure TfrxCellularText.BuildTable(aTable: TfrxTableObject);
var
  aCellHeight: Extended;
  sLines: TWideStrings;
  sText: WideString;
  ColColumn: Integer;
begin
  sLines := TWideStringList.Create;
  BuildArray(aTable, aCellHeight, sLines, sText, ColColumn);
  BuildTableFromArray(aTable, aCellHeight, sLines, sText, ColColumn);
  sLines.Free;
end;

function TfrxCellularText.CalcHeight: Extended;
var
  aCellHeight, aCellWidth: Extended;
  sLines: TWideStrings;
begin
  aCellHeight := FCellHeight;
  aCellWidth  := FCellWidth;
  if (aCellHeight = 0) or (aCellWidth = 0) then
  begin
    aCellHeight := GetCellHeight;
    aCellWidth := aCellHeight;
  end;
  UpdateSize;
  sLines := TWideStringList.Create;
  try
    WrapText(sLines, Trunc((Width + FHorzSpacing)/ (aCellWidth + FHorzSpacing)));
    Result := sLines.Count * (aCellHeight + FVertSpacing) - FVertSpacing;
  finally
    sLines.Free;
  end;
end;

constructor TfrxCellularText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCellWidth := 0;
  FCellHeight := 0;
  Frame.Typ := [ftLeft, ftRight, ftTop, ftBottom];
end;

procedure TfrxCellularText.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  Table: TfrxTableObject;
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  Table := TfrxTableObject.Create(nil);
  try
    BuildTable(Table);
    DrawBackground;
    Table.Draw(Canvas, ScaleX, ScaleY, OffsetX + AbsLeft * ScaleX, OffsetY + AbsTop * ScaleY);
    DrawFrameEdges;
  finally
    Table.Free;

  end;
end;

function TfrxCellularText.DrawPart: Extended;
begin
  // TODO make it breakable
  Result := Height;
end;

function TfrxCellularText.ExportInternal(
  Filter: TfrxCustomExportFilter): Boolean;
var
  x, y: Integer;
  cell: TfrxTableCell;
  aTable: TfrxTableObject;
begin
  aTable := TfrxTableObject.Create(nil);
  aTable.Top := AbsTop;
  aTable.Left := AbsLeft;
  BuildTable(aTable);
  aTable.UpdateBounds;
  for y := 0 to aTable.RowCount - 1 do
    for x := 0 to aTable.ColumnCount - 1 do
    begin
      cell := aTable.Cells[x, y];
      Filter.ExportObject(cell);
    end;
  Result := True;
  aTable.Free;
end;


function TfrxCellularText.GetCellHeight: Extended;
begin
  Result := FCellHeight;
  if Result <= 1 then
    Result := -Font.Height + 10;
end;

function TfrxCellularText.GetCellWidth: Extended;
begin
  Result := FCellWidth;
  if Result = 0 then
    Result := -Font.Height + 10;
end;

procedure TfrxCellularText.SetCellWidth(Value: Extended);
begin
  FCellWidth := Value;
  UpdateSize;
end;

procedure TfrxCellularText.SetCellHeight(Value: Extended);
begin
  FCellHeight := Value;
  UpdateSize;
end;

class function TfrxCellularText.GetDescription: String;
begin
  Result := frxResources.Get('obCellularText');
end;

procedure TfrxCellularText.Loaded;
begin
  inherited;
  UpdateSize;
end;

procedure TfrxCellularText.UpdateBounds;
begin
  inherited;
  UpdateSize;
end;

procedure TfrxCellularText.UpdateSize;
var
  Value: Extended;
begin
  Value := Width;
  if Value < GetCellWidth then Value := GetCellWidth;
  Width := Round(Value / (GetCellWidth + FHorzSpacing)) * (GetCellWidth + FHorzSpacing) - FHorzSpacing;
  Value := Height;
  if Value < GetCellHeight then Value := GetCellHeight;
  Height := Round(Value / (GetCellHeight + FVertSpacing))*(GetCellHeight + FVertSpacing) - FVertSpacing;
end;

procedure TfrxCellularText.WrapText(sLines: TWideStrings; ColumnCount: Integer);
var
  i, Len, LastPos, LastSpace, LastDelimSize: Integer;
  sText: WideString;
  bNewLine: Boolean;
begin
  i := 1;
  sText := Text;
  Len := Length(sText);
  LastPos := i;
  LastSpace := i;
  while (i <= Len) do
  begin
    LastDelimSize := 0;
    {$IFNDEF Linux}
    bNewLine := (sText[i] = #13);
    {$ELSE}
    bNewLine := (sText[i] = #10);
    {$ENDIF}
    if (sText[i] = ' ') or bNewLine then
    begin
      {$IFNDEF Linux}
      if bNewLine then
      begin
        Inc(i);
        LastDelimSize := 1;
      end;
      {$ENDIF}
      LastSpace := i;
    end;
    if (i - LastPos >= ColumnCount) or (i = Len) or bNewLine then
    begin
      if not WordWrap or (LastSpace = LastPos) then
        LastSpace := i;
      sLines.AddObject(Copy(sText, LastPos, LastSpace - LastPos - LastDelimSize), TObject(LastSpace));
      if (sText[LastSpace] = ' ') then
        Inc(LastSpace);
      LastPos := LastSpace + LastDelimSize;
      LastSpace := LastPos;
    end;
    Inc(i);
  end;
end;

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxCellularText, TControl);
{$ENDIF}
  frxObjects.RegisterObject1(TfrxCellularText, nil, '', '', 0, 82);

finalization
  frxObjects.UnRegister(TfrxCellularText);

end.
