
{******************************************}
{                                          }
{             FastReport VCL               }
{         ListBox Add-In Object            }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxListBox;

interface

{$I frx.inc}

uses
  {$IFNDEF Linux}
    Windows,
  {$ELSE}
    LCLType, LCLIntf, LCLProc,
  {$ENDIF}
  Classes, Graphics, Types, Controls,
  frxClass, frxListControl;

type
  TScrollBoxMousePlace = (cpAbove, cpCenter, cpBelow);

  TfrxVerticalScrollBar = class(TfrxRightEdge)
  private
    FContentHeight: Extended;
    FControlHeight: Extended;
    FContentLineCount: Integer;
    FTopLineIndex: Integer;
    FDownTopLineIndex: Integer;
    FMouseCaptured: Boolean;
    FDownPlace: TScrollBoxMousePlace;
    FDownY: Integer;
    FCurrentY: Integer;
    FScrollBoxTop: Extended;
    FScrollBoxBottom: Extended;
    FScrollBoxStep: Extended;
    FMaxTopLineIndex: Integer;
    FWheelStepNumber: Integer;
    FInitialized: Boolean;

    procedure SetTopLineIndex(const Value: Integer);
  protected
    function CalcPlace(Y: Integer): TScrollBoxMousePlace;
    procedure SquareLineTo(Canvas: TCanvas; X, Y: Integer);
    function MixColor(C1, C2: TColor): TColor;
  public
    procedure Init(AContentHeight, AControlHeight: Extended; Rect: TRect; AContentLineCount: Integer);
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY: Extended); override;
    function IsVisible: Boolean;

    function DoMouseDown(X, Y: Integer): Boolean;
    procedure DoMouseUp;
    procedure DoMouseMove(X, Y: Integer);
    function DoMouseWheel(WheelDelta: Integer): Boolean;

    property MouseCaptured: Boolean read FMouseCaptured;
    property TopLineIndex: Integer read FTopLineIndex write SetTopLineIndex;
    property Initialized: Boolean read FInitialized;
  end;

{$IFDEF DELPHI16}
  /// <summary>
  ///   The TfrxListBoxObject allows the use of the TfrxListBoxView component in
  ///   your report. TfrxListControlObject is an empty component. It is used to
  ///   add the frxListBox.pas file to the "uses" list.
  /// </summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxListBoxObject = class(TComponent)  // fake component
  end;

  /// <summary>
  ///   TfrxListBoxView displays a collection of items in a scrollable list.
  ///   Use TfrxListBoxView to display a scrollable list of items that users can
  ///   select, add, or delete.
  /// </summary>
  TfrxListBoxView = class(TfrxCustomListControlView)
  private
    function GetTopLineIndex: Integer;
  protected
    FContentHeight: Extended;
    FMouseCaptured: Boolean;
    FScrollBar: TfrxVerticalScrollBar;

    function IsChangeItemIndex(const Y: Integer): Boolean;
    function IsScrollBarAllowed: Boolean;
    function NoScrollBar(Rect: TRect): TRect; override;
    procedure DrawText;
    procedure SetDrawParams(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
    procedure FillMemoText(Memo: TfrxCustomMemoView); override;

    function DoMouseDown(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams): Boolean; override;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var EventParams: TfrxInteractiveEventsParams): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: string; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;

    property TopLineIndex: Integer read GetTopLineIndex;
  published
    property AllowExpressions;
    property BrushStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property Editable default [ferAllowInPreview];
    property ExpressionDelimiters;
    property Font;
    property Frame;
    property FillType;
    property Fill;
    property ItemIndex; // hidden
    property Items;
    property ItemsText; // hidden
    property ParentFont;
    property Style;
    property TagStr;
  end;

implementation

uses
  Math,
  {$IfDef DELPHI16}System.UITypes,{$EndIf}
  frUtils,
  frxListBoxRTTI, frxDsgnIntf, frxCustomEditors, frxListControlEditor, frxRes,
  frxHelpers, frxAnaliticGeometry, frxUtils;

const
  meCompleted = True;
  PlaceShift: array[TScrollBoxMousePlace] of integer = (-1, 0, 1);

type
  TfrxListBoxEditor = class(TfrxViewEditor)
  private
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

{ TfrxListBoxEditor }

function TfrxListBoxEditor.Edit: Boolean;
begin
  with TfrxListControlEditorForm.Create(Designer) do
    try
      ListControlView := TfrxListBoxView(Component);
      Caption := frxGet(3940);
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

function TfrxListBoxEditor.HasEditor: Boolean;
begin
  Result := True;
end;

{ Utilities }

{ TfrxListBoxView }

constructor TfrxListBoxView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FScrollBar := TfrxVerticalScrollBar.Create;
end;

destructor TfrxListBoxView.Destroy;
begin
  FScrollBar.Free;

  inherited;
end;

function TfrxListBoxView.DoMouseDown(X, Y: Integer; Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := IsPreview(EventParams) and IsLeft(Button) and (ferAllowInPreview in Editable);

  if not Result then
    Result := inherited DoMouseDown(X, Y, Button, Shift, EventParams)
  else
    if FScrollBar.DoMouseDown(XCorrected(X), YCorrected(Y)) then
      EventParams.Refresh := True
    else
    begin
      EventParams.Refresh := IsChangeItemIndex(YCorrected(Y));
      EventParams.Modified := EventParams.Refresh;
      FMouseCaptured := True;
    end;
end;

procedure TfrxListBoxView.DoMouseMove(X, Y: Integer; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
begin
  if IsPreview(EventParams) and (ferAllowInPreview in Editable) then
  begin
    if (FMouseCaptured or FScrollBar.MouseCaptured) and not (ssLeft in Shift) then
      DoMouseUp(X, Y, mbLeft, Shift, EventParams);

    if FScrollBar.MouseCaptured then
    begin
      FScrollBar.DoMouseMove(XCorrected(X), YCorrected(Y));
      EventParams.Refresh := True;
    end
    else
    begin
      EventParams.Refresh := FMouseCaptured and IsChangeItemIndex(YCorrected(Y));
      EventParams.Modified := EventParams.Refresh;
    end;
  end
  else
    inherited;
end;

procedure TfrxListBoxView.DoMouseUp(X, Y: Integer; Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
begin
  if IsPreview(EventParams) and IsLeft(Button) and (ferAllowInPreview in Editable) then
  begin
    FScrollBar.DoMouseUp;
    FMouseCaptured := False;
    EventParams.Refresh := True;
  end
  else
    inherited;
end;

function TfrxListBoxView.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  if IsPreview(EventParams)  and (ferAllowInPreview in Editable) then
  begin
    EventParams.Refresh := FScrollBar.DoMouseWheel(WheelDelta);
    Result := meCompleted;
  end
  else
    Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos, EventParams);
end;

procedure TfrxListBoxView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  if IsScrollBarAllowed and not FScrollBar.Initialized then
  begin
    BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
    SetDrawParams(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
    FScrollBar.Init(FContentHeight, Height, Rect(FX, FY, FX1, FY1), Items.Count);
  end;

  inherited Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  if Color = clNone then
    Canvas.Brush.Style := bsClear;
  DrawText;

  if IsScrollBarAllowed then
  begin
    FScrollBar.Init(FContentHeight, Height, Rect(FX, FY, FX1, FY1), Items.Count);
    FScrollBar.Draw(Canvas, ScaleX, ScaleY);
  end;
end;

procedure TfrxListBoxView.DrawText;
begin
  if IsDataField then
    Items.Text := '[' + DataSet.UserName + '."' + DataField + '"]';

  FDrawText := GetDrawTextObject;
  FDrawText.Lock;
  try
    SetDrawParams(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
    FDrawText.DrawText(FCanvas, haLeft, vaTop, ulmNone, ItemIndex - TopLineIndex);
    FLineY := FDrawText.GetLineY;
  finally
    FDrawText.Unlock;
  end;
end;

procedure TfrxListBoxView.FillMemoText(Memo: TfrxCustomMemoView);
var
  i: Integer;
begin
  Memo.Lines.Text := Items.Text;
  for i := 0 to TopLineIndex - 1 do
    Memo.Lines.Delete(0);
end;

class function TfrxListBoxView.GetDescription: String;
begin
  Result := frxResources.Get('obListBox');
end;

function TfrxListBoxView.GetTopLineIndex: Integer;
begin
  Result := FScrollBar.TopLineIndex;
end;

function TfrxListBoxView.IsChangeItemIndex(const Y: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Items.Count - 1 do
    if (Y >= FLineY[i]) and (Y < FLineY[i + 1]) then
    begin
      Result := i + TopLineIndex <> ItemIndex;
      ItemIndex := i + TopLineIndex;
      Break;
    end;
end;

function TfrxListBoxView.IsScrollBarAllowed: Boolean;
var
  IsPreviewing, IsExporting, IsInteractiveForms: Boolean;
begin
  IsExporting := csFrxExporting in frComponentState;
  IsPreviewing := not (IsDesigning or IsExporting);
  IsInteractiveForms := csFrxInteractiveForms in frComponentState;
  Result := (IsExporting and IsInteractiveForms and (ferAllowInExport in Editable)) or
            (IsPreviewing and (ferAllowInPreview in Editable));
end;

function TfrxListBoxView.NoScrollBar(Rect: TRect): TRect;
begin
  if IsScrollBarAllowed and FScrollBar.IsVisible then
    Result := inherited NoScrollBar(Rect)
  else
    Result := Rect;
end;

procedure TfrxListBoxView.SetDrawParams(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  DrawTextInit;
  DrawTextDimensions(ScaleX, ScaleY, OffsetX, OffsetY);

  FDrawText.SetText(Items, False {FFirstParaBreak}); // full content height
  FContentHeight := FDrawText.CalcHeight;
  if TopLineIndex > 0 then
    FDrawText.SetText(Items, False {FFirstParaBreak}, TopLineIndex);
end;

{ TfrxVerticalScrollBar }

function TfrxVerticalScrollBar.CalcPlace(Y: Integer): TScrollBoxMousePlace;
begin
  if      Y < FScrollBoxTop then
    Result := cpAbove
  else if Y > FScrollBoxBottom then
    Result := cpBelow
  else
    Result := cpCenter;
end;

function TfrxVerticalScrollBar.DoMouseDown(X, Y: Integer): Boolean;
begin
  Result := IsVisible and IsInside(X, Y);
  if Result then
  begin
    FMouseCaptured := True;
    FDownY := Y;
    FCurrentY := Y;
    FDownPlace := CalcPlace(Y);
    case FDownPlace of
      cpAbove, cpBelow:
        TopLineIndex := TopLineIndex + PlaceShift[FDownPlace];
      cpCenter:
        FDownTopLineIndex := TopLineIndex;
    end;
  end;
end;

procedure TfrxVerticalScrollBar.DoMouseMove(X, Y: Integer);
begin
  if not IsVisible then
    Exit;

  FCurrentY := Y;
  if MouseCaptured then
    case FDownPlace of
      cpAbove, cpBelow:
        if FDownPlace = CalcPlace(Y) then
          TopLineIndex := TopLineIndex + PlaceShift[FDownPlace];
      cpCenter:
        TopLineIndex := FDownTopLineIndex - Round((FDownY - FCurrentY) / FScrollBoxStep);
    end;
end;

procedure TfrxVerticalScrollBar.DoMouseUp;
begin
  FMouseCaptured := False;
end;

function TfrxVerticalScrollBar.DoMouseWheel(WheelDelta: Integer): Boolean;
begin
  Inc(FWheelStepNumber);
  if FWheelStepNumber mod 3 = 0 then
    TopLineIndex := TopLineIndex - Sign(WheelDelta);
  Result := meCompleted;
end;

procedure TfrxVerticalScrollBar.Draw(Canvas: TCanvas; ScaleX, ScaleY: Extended);
const
  Gap = 2;
var
  Part, ScrollBoxLength, ScrollBoxX: Extended;
  ControlLineCount: Integer;
begin
  inherited Draw(Canvas, ScaleX, ScaleY);

  if not IsVisible then
    Exit;

  Part := FControlHeight / FContentHeight;
  ScrollBoxLength := FControlHeight * Part * ScaleY;
  ControlLineCount := Floor(FContentLineCount * Part);

  FMaxTopLineIndex := FContentLineCount - ControlLineCount;
  FScrollBoxStep := (FControlHeight * ScaleY - ScrollBoxLength) / FMaxTopLineIndex;

  Canvas.Pen.Color := frIfColor(MouseCaptured,
    Canvas.Font.Color,
    MixColor(Canvas.Brush.Color, Canvas.Font.Color));

  Canvas.Pen.Width := Round(FRect.Right - FRect.Left) - 2 * Gap;

  FScrollBoxTop := FRect.Top + frIfReal(MouseCaptured and (FDownPlace = cpCenter),
    FScrollBoxStep * FDownTopLineIndex - (FDownY - FCurrentY),
    FScrollBoxStep * TopLineIndex);

  FScrollBoxTop := frLimit(FScrollBoxTop, FRect.Top, FRect.Bottom - ScrollBoxLength);
  FScrollBoxBottom := FScrollBoxTop + ScrollBoxLength;

  ScrollBoxX := (FRect.Left + FRect.Right) / 2;
  Canvas.MoveTo(Round(ScrollBoxX), Round(FScrollBoxTop + Gap));
  SquareLineTo(Canvas, Round(ScrollBoxX), Round(FScrollBoxBottom - Gap));
end;

procedure TfrxVerticalScrollBar.Init(AContentHeight, AControlHeight: Extended; Rect: TRect; AContentLineCount: Integer);
begin
  inherited Init(Rect);

  FContentHeight := AContentHeight;
  FControlHeight := AControlHeight;
  FContentLineCount := AContentLineCount;
end;

function TfrxVerticalScrollBar.IsVisible: Boolean;
begin
  Result := FContentHeight > FControlHeight;
end;

function TfrxVerticalScrollBar.MixColor(C1, C2: TColor): TColor;
begin
  Result := RGB(
    Round(GetRValue(C1) / 2 + GetRValue(C2) / 2),
    Round(GetGValue(C1) / 2 + GetGValue(C2) / 2),
    Round(GetBValue(C1) / 2 + GetBValue(C2) / 2));
end;

procedure TfrxVerticalScrollBar.SetTopLineIndex(const Value: Integer);
begin
  FTopLineIndex := frLimit(Value, 0, FMaxTopLineIndex);
end;

procedure TfrxVerticalScrollBar.SquareLineTo(Canvas: TCanvas; X, Y: Integer);
var
  LG: TLogBrush;
  PenSt: DWORD;
  hP: HPEN;
  OldPen: HGDIOBJ;
begin
  LG.lbStyle := BS_SOLID;
  LG.lbColor := Canvas.Pen.Color;
  LG.lbHatch := 0;
  PenSt := PS_GEOMETRIC or PS_ENDCAP_FLAT;

  hP := ExtCreatePen(PenSt, Canvas.Pen.Width, LG, 0, nil);
  if hP = 0 then
    Canvas.LineTo(X, Y)
  else
  begin
    OldPen := SelectObject(Canvas.Handle, Hp);
    Canvas.LineTo(X, Y);
    SelectObject(Canvas.Handle, OldPen);
    DeleteObject(hP);
  end;
end;

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxListBoxObject, TControl);
{$ENDIF}

  frxObjects.RegisterObject1(TfrxListBoxView, nil, frxResources.Get('obListBox'), '', 0, 86);
  frxHideProperties(TfrxListBoxView, 'ItemIndex');
  frxHideProperties(TfrxListBoxView, 'ItemsText');

  frxComponentEditors.Register(TfrxListBoxView, TfrxListBoxEditor);

finalization
  frxObjects.UnRegister(TfrxListBoxView);

end.
