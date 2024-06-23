
{******************************************}
{                                          }
{             FastReport VCL               }
{         ComboBox Add-In Object           }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxComboBox;

interface

{$I frx.inc}

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  Classes, Controls, Graphics, Types,
  frUnicodeUtils, frxClass, frxListControl, frxRes;

type
{$IFDEF DELPHI16}
  /// <summary>
  ///   The TfrxComboBoxObject allows the use of the TfrxComboBoxView component
  ///   in your report. TfrxComboBoxObject is an empty component. It is used to
  ///   add the frxComboBox.pas file to the "uses" list.
  /// </summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxComboBoxObject = class(TComponent)  // fake component
  end;

  /// <summary>
  ///   TfrxComboBoxView combines an edit box with a scrollable list.
  ///   A TfrxComboBoxView component is an edit box with a scrollable drop-down
  ///   list attached to it. Users can select an item from the list or type
  ///   directly into the edit box.
  /// </summary>
  TfrxComboBoxView = class(TfrxCustomListControlView)
  private
    FDropDownCount: Integer;
    procedure SetDropDownCount(const Value: Integer);
  protected
    FContentHeight: Extended;
    FText: WideString;
    FNeedReDraw: Boolean;

    procedure SetItemIndex(const Value: Integer); override;

    procedure DrawText;
    procedure SetDrawParams(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
    procedure FillMemoText(Memo: TfrxCustomMemoView); override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: string; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;

    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure PreviewCoordinates(var X, Y: Integer);

    property ContentHeight: Extended read FContentHeight;
    property NeedReDraw: Boolean read FNeedReDraw write FNeedReDraw;
  published
    property AllowExpressions;
    property BrushStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount;
    property Editable default [ferAllowInPreview];
    property ExpressionDelimiters;
    property Font;
    property Frame;
    property FillType;
    property Fill;
    property ItemIndex; // hidden
    property Items;
    property ItemsText; // hidden
    property Style;
    property TagStr;
    property Text: WideString read FText write FText;
    property ParentFont;
  end;

implementation

uses
  Math, frxAnaliticGeometry, frxDsgnIntf, frxCustomEditors, frxListControlEditor,
  frxComboBoxRTTI, frxUtils, frxComboBoxInPlaceEditor;

const
  MinDropDownCount = 2;

type
  TfrxComboBoxEditor = class(TfrxViewEditor)
  private
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

{ TfrxComboBoxView }

constructor TfrxComboBoxView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDropDownCount := 6;
end;

procedure TfrxComboBoxView.DoMouseMove(X, Y: Integer; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
begin
  if NeedReDraw and IsPreview(EventParams) and (Shift = []) then
  begin
    Draw(FCanvas, EventParams.Scale, EventParams.Scale, EventParams.OffsetX, EventParams.OffsetY);
    NeedRedraw := False;
  end;
end;

procedure TfrxComboBoxView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  inherited Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DrawText;

  if Assigned(FComponentEditors) then
    FComponentEditors.DrawCustomEditor(FCanvas, Rect(FX, FY, FX1, FY1));
end;

procedure TfrxComboBoxView.DrawText;
begin
  if IsDataField then
    Items.Text := '[' + DataSet.UserName + '."' + DataField + '"]';

  FDrawText := GetDrawTextObject;
  FDrawText.Lock;
  try
    SetDrawParams(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
    FDrawText.DrawText(FCanvas, haLeft, vaTop, ulmNone);
  finally
    FDrawText.Unlock;
  end;
end;

procedure TfrxComboBoxView.FillMemoText(Memo: TfrxCustomMemoView);
begin
  Memo.Lines.Text := Text;
end;

class function TfrxComboBoxView.GetDescription: String;
begin
  Result := frxResources.Get('obComboBox');
end;

procedure TfrxComboBoxView.PreviewCoordinates(var X, Y: Integer);
begin
  X := XCorrected(X);
  Y := YCorrected(Y);
end;

procedure TfrxComboBoxView.SetDrawParams(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  ws: WideString;
begin
  DrawTextInit;
  DrawTextDimensions(ScaleX, ScaleY, OffsetX, OffsetY);

  ws := Items.Text;
  try
    Items.Text := Text;
    if Items.Text = '' then
      Items.Text := #$D#$A;
    FDrawText.SetText(Items, False {FFirstParaBreak});
    FContentHeight := FDrawText.CalcHeight;
  finally
    Items.Text := ws;
  end;
end;

procedure TfrxComboBoxView.SetDropDownCount(const Value: Integer);
begin
  FDropDownCount := Max(MinDropDownCount, Value);
end;

procedure TfrxComboBoxView.SetItemIndex(const Value: Integer);
begin
  inherited SetItemIndex(Value);

  if IsInside(Value, 0, FItems.Count - 1) then
    Text := FItems[ItemIndex];
end;

{ TfrxComboBoxEditor }

function TfrxComboBoxEditor.Edit: Boolean;
begin
  with TfrxListControlEditorForm.Create(Designer) do
    try
      ListControlView := TfrxComboBoxView(Component);
      Caption := frxGet(3941);
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

function TfrxComboBoxEditor.HasEditor: Boolean;
begin
  Result := True;
end;

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxComboBoxObject, TControl);
{$ENDIF}

  frxObjects.RegisterObject1(TfrxComboBoxView, nil, frxResources.Get('obComboBox'), '', 0, 87);
  frxHideProperties(TfrxComboBoxView, 'ItemIndex');
  frxHideProperties(TfrxComboBoxView, 'ItemsText');

  frxComponentEditors.Register(TfrxComboBoxView, TfrxComboBoxEditor);

finalization
  frxObjects.UnRegister(TfrxComboBoxView);

end.
