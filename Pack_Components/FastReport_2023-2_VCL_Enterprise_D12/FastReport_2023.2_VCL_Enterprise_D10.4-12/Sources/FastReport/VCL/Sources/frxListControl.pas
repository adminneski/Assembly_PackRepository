
{******************************************}
{                                          }
{             FastReport VCL               }
{        ListControl Add-In Object         }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxListControl;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LazHelper,
{$ELSE}
  WideStrings,
{$ENDIF}
  Classes, Types, Graphics, Controls, 
  frCoreClasses, frUnicodeUtils, frxClass, frxGraphicUtils;

const
  DefaultExpressionDelimiters = '[,]';

type
  /// <summary>
  ///   TfrxCustomListControlView is the base class for TfrxListBoxView and
  ///   TfrxComboBoxView
  /// </summary>
  TfrxCustomListControlView = class(TfrxView)
  private
    FAllowExpressions: Boolean;
    FExpressionDelimiters: String;
    FItemIndex: Integer;

    procedure SetItems(const Value: TWideStrings);
    function IsExprDelimitersStored: Boolean;
    function GetItemsText: WideString;
    procedure SetItemsText(const Value: WideString);
  protected
    FItems: TWideStrings;
    FDrawText: TfrxDrawText;
    FLineY: TIntegerDynArray;
    FLineSpacing: Integer;
    procedure SetItemIndex(const Value: Integer); virtual;

    function XCorrected(const X: Extended): Integer;
    function YCorrected(const Y: Extended): Integer;

    procedure DrawTextInit; // Before use
    procedure DrawTextDimensions(ScaleX, ScaleY, OffsetX, OffsetY: Extended);
    function CalcTextRect(OffsetX, OffsetY, ScaleX, ScaleY: Extended): TRect;
    function NoScrollBar(Rect: TRect): TRect; virtual;

    procedure LoadFromDataField;
    procedure GetExpressionDelimiters(out LeftDlm, RightDlm: WideString);
    function IsPreview(EventParams: TfrxInteractiveEventsParams): Boolean;
    function IsLeft(Button: TMouseButton): Boolean;

    procedure FillMemoText(Memo: TfrxCustomMemoView); virtual; abstract;
    /// <summary>
    ///   Determines if the object may contain expressions inside the text.
    ///   Expressions are enclosed in the square brackets (by default). The
    ///   ExpressionDelimiters defines which symbols to use for detecting the
    ///   expression. Default value is True.
    /// </summary>
    property AllowExpressions: Boolean read FAllowExpressions write FAllowExpressions default True;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property ItemsText: WideString read GetItemsText write SetItemsText;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetData; override;

    procedure FillMemo(Memo: TfrxCustomMemoView);

    property Items: TWideStrings read FItems write SetItems;
    /// <summary>
    ///   Set of symbols, designating the expression. Default value is '[,]'.
    ///   The comma divides opening and closing symbols. There is one
    ///   limitation however: the opening and closing symbols cannot be
    ///   similar, so '%,%' will not work. One can set several symbols, for
    ///   example '&lt;%,%&gt;'.
    /// </summary>
    property ExpressionDelimiters: string read FExpressionDelimiters
      write FExpressionDelimiters stored IsExprDelimitersStored;
  end;

  TfrxRightEdge = class
  protected
    FRect: TRect;

    function IsInside(X, Y: Integer): Boolean;
  public
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY: Extended); virtual;
    procedure Init(Rect: TRect);
  end;

implementation

uses
  Variants,
  frxAnaliticGeometry, frxUtils, frxHelpers;

const
  ScrollBarWidth = 20;

{ TfrxCustomListControlView }

function TfrxCustomListControlView.CalcTextRect(OffsetX, OffsetY, ScaleX, ScaleY: Extended): TRect;
const
  Gap = 1;
var
  bx, by, bx1, by1, wx1, wx2, wy1, wy2, gx1, gy1: Integer;
begin
  wx1 := Round((Frame.Width * ScaleX - 1) / 2);
  wx2 := Round(Frame.Width * ScaleX / 2);
  wy1 := Round((Frame.Width * ScaleY - 1) / 2);
  wy2 := Round(Frame.Width * ScaleY / 2);

  bx := Round(AbsLeft * ScaleX + OffsetX);
  by := Round(AbsTop * ScaleY + OffsetY);
  // bx1 := FX1;
  // by1 := FY1;
  if Frame.DropShadow then
  begin
    bx1 := bx + Round((Width - Frame.ShadowWidth) * ScaleX);
    by1 := by + Round((Height - Frame.ShadowWidth) * ScaleY);
  end
  else
  begin
    bx1 := bx + Round(Width * ScaleX);
    by1 := by + Round(Height * ScaleY);
  end;

  if ftLeft in Frame.Typ then
    Inc(bx, wx1);
  if ftRight in Frame.Typ then
    Dec(bx1, wx2);
  if ftTop in Frame.Typ then
    Inc(by, wy1);
  if ftBottom in Frame.Typ then
    Dec(by1, wy2);
  gx1 := Round(Gap * ScaleX);
  gy1 := Round(Gap * ScaleY);

  Result := Rect(bx + gx1, by + gy1, bx1 - gx1 + 1, by1 - gy1 + 1);
end;

constructor TfrxCustomListControlView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TfrWideStrings.Create;
  FItemIndex := Unknown;
  FAllowExpressions := True;
  FExpressionDelimiters := DefaultExpressionDelimiters;
  ParentFont := True;
  FLineSpacing := 2;

  Editable := [ferAllowInPreview];
end;

destructor TfrxCustomListControlView.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TfrxCustomListControlView.DrawTextDimensions(ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  ScaledRect: TRect;
  TextRect: TRect;
begin
  ScaledRect := CalcTextRect(OffsetX, OffsetY, ScaleX, ScaleY);
  TextRect := CalcTextRect(0, 0, 1, 1);

  FDrawText.SetDimensions(ScaleX, ScaleY, 1 {FPrintScale},
    NoScrollBar(TextRect), NoScrollBar(ScaledRect));
end;

procedure TfrxCustomListControlView.DrawTextInit;
begin
  FDrawText := GetDrawTextObject;
  FDrawText.UseDefaultCharset := False;
  FDrawText.UseMonoFont := DrawAsMask;
  FDrawText.SetFont(Font);
//  FLineSpacing := Round(0.3175 * Abs(Font.Height) - 0.1288); // Suitable for Acrobat + (Arial, Tahoma, Times, Verdana)
  FDrawText.SetOptions(
    False {FWordWrap}, False {FAllowHTMLTags}, False {FRTLReading},
    False {FWordBreak}, True {FClipped}, True {FWysiwyg}, 0 {FRotation});
  FDrawText.SetGaps(0 {FParagraphGap}, 0 {FCharSpacing}, FLineSpacing);
  FDrawText.SetParaBreaks(False {FFirstParaBreak}, False{FLastParaBreak});
end;

procedure TfrxCustomListControlView.FillMemo(Memo: TfrxCustomMemoView);
begin
  Memo.Align := Align;
  Memo.AllowExpressions := AllowExpressions;
  Memo.AllowHTMLTags := False;
  Memo.AllowMirrorMode := AllowMirrorMode;
  Memo.AllowVectorExport := AllowVectorExport;
  Memo.AncestorOnlyStream := AncestorOnlyStream;
  Memo.Anchors := Anchors;
  Memo.AutoWidth := False;

  Memo.BrushStyle := BrushStyle;

  Memo.Clipped := True;
  Memo.Color := Color;

  Memo.DataField := DataField;
  Memo.DataSet := DataSet;
  Memo.DataSetName := DataSetName;

  Memo.Editable := Editable;
  Memo.ExpressionDelimiters := ExpressionDelimiters;

  Memo.Fill := Fill; // Memo.FillType installed here
  Memo.Font := Font;
  Memo.Frame := Frame;

  Memo.GapX := 2;
  Memo.GapY := 0;

  Memo.HAlign := haLeft;
  Memo.Height := Height;
  Memo.Hyperlink := Hyperlink;

  Memo.Left := Left;

  Memo.LineSpacing := FLineSpacing;

  Memo.Parent := Parent;
  Memo.ParentFont := False;

  Memo.Rotation := 0;
  Memo.RTLReading := False;

  Memo.StretchMode := smDontStretch;

  Memo.Top := Top;

  Memo.Underlines := False;

  Memo.URL := URL;
  Memo.UseDefaultCharset := True;

  Memo.VAlign := vaTop;
  Memo.Visibility := Visibility;
  Memo.Visible := Visible;

  Memo.Width := Width;
  Memo.WordBreak := False;
  Memo.WordWrap := False;

  FillMemoText(Memo);
end;

procedure TfrxCustomListControlView.GetData;
var
  ws, ws1, ws2, dc1, dc2: WideString;
  i, j: integer;
begin
  inherited GetData;

  if IsDataField then
    LoadFromDataField
  else if AllowExpressions then
  begin
    ws := ItemsText;
    GetExpressionDelimiters(dc1, dc2);

    if Pos(dc1, ws) <> 0 then
    begin
      i := 1;
      repeat
        while (i < Length(ws)) and (Copy(ws, i, Length(dc1)) <> dc1) do
          Inc(i);

        ws1 := frxGetBrackedVariableW(ws, dc1, dc2, i, j);
        if i <> j then
        begin
          Delete(ws, i, j - i + 1);

          ws2 := Report.Calc(ws1);

          Insert(ws2, ws, i);
          Inc(i, Length(ws2));
          j := 0;
        end;
      until i = j;
    end;
    ItemsText := ws;
  end;
end;

procedure TfrxCustomListControlView.GetExpressionDelimiters(out LeftDlm, RightDlm: WideString);
var
  ws: WideString;
  p: Integer;
begin
  ws := FExpressionDelimiters;
  p := Pos(',', ws);
  LeftDlm := Copy(ws, 1, p - 1);
  RightDlm := Copy(ws, p + 1, MaxInt);
end;

function TfrxCustomListControlView.GetItemsText: WideString;
begin
  Result := FItems.Text;
end;

function TfrxCustomListControlView.IsExprDelimitersStored: Boolean;
begin
  Result := FExpressionDelimiters <> DefaultExpressionDelimiters;
end;

function TfrxCustomListControlView.IsLeft(Button: TMouseButton): Boolean;
begin
  Result := Button = mbLeft;
end;

function TfrxCustomListControlView.IsPreview(EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := EventParams.EventSender = esPreview;
end;

procedure TfrxCustomListControlView.LoadFromDataField;
begin
  if DataSet.IsBlobField(DataField) then
    DataSet.AssignBlobTo(DataField, FItems)
  else
    FItems.Add(VarToStr(DataSet.Value[DataField]));
end;

function TfrxCustomListControlView.NoScrollBar(Rect: TRect): TRect;
begin
  Result := Rect;
  Result.Right := Result.Right - Round(ScrollBarWidth * FScaleY);
end;

procedure TfrxCustomListControlView.SetItemIndex(const Value: Integer);
begin
  if      FItems.Count = 0 then
    FItemIndex := Unknown
  else if IsInside(Value, 0, FItems.Count - 1) then
    FItemIndex := Value;
end;

procedure TfrxCustomListControlView.SetItems(const Value: TWideStrings);
begin
  FItems.Assign(Value);
end;

procedure TfrxCustomListControlView.SetItemsText(const Value: WideString);
begin
  FItems.Text := Value;
end;

function TfrxCustomListControlView.XCorrected(const X: Extended): Integer;
begin
  Result := Round(X + FOffsetX);
end;

function TfrxCustomListControlView.YCorrected(const Y: Extended): Integer;
begin
  Result := Round(Y + FOffsetY);
end;

{ TfrxRightEdge }

procedure TfrxRightEdge.Draw(Canvas: TCanvas; ScaleX, ScaleY: Extended);
begin
  FRect.Left := FRect.Right - Round(ScrollBarWidth * ScaleX);
end;

procedure TfrxRightEdge.Init(Rect: TRect);
begin
  FRect := Rect;
end;

function TfrxRightEdge.IsInside(X, Y: Integer): Boolean;
begin
  Result := PtInRect(FRect, Point(X, Y));
end;

end.
