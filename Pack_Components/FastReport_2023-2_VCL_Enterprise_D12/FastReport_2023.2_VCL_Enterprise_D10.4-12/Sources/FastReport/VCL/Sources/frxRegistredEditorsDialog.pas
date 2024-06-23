unit frxRegistredEditorsDialog;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, frxClass, ComCtrls, StdCtrls,
  Grids, ValEdit, TypInfo, Buttons, Menus, frxPopupForm, frxBaseForm,
  ExtCtrls, Types;

type
  TfrxRegEditorsDialog = class(TfrxBaseForm)
    CancelBTN: TButton;
    OkBTN: TButton;
    EditorsVL: TValueListEditor;
    ComponentsLB: TListBox;
    ComboPanel: TPanel;
    ComboBtn: TSpeedButton;
    BackPanel: TPanel;
    procedure FormShow(Sender: TObject);
    procedure ComponentsLBClick(Sender: TObject);
    procedure EditorsVLDrawCell(Sender: TObject; ACol, ARow: Integer;
      aRect: TRect; State: TGridDrawState);
    procedure VisibilityCBDrawItem(Control: TWinControl; Index: Integer;
      aRect: TRect; State: TOwnerDrawState);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditorsVLSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClick(Sender: TObject);
    procedure ComboBtnClick(Sender: TObject);
  private
    FPopupForm: TfrxPopupForm;
    FListBox: TListBox;
    FEditItem: TfrxComponentEditorVisibility;
    FEditRow: Integer;
    FRegItem: TfrxComponentEditorsRegItem;
    procedure FillComponentsList;
    procedure FillEditors;
  public
    procedure UpdateFormPPI(aNewPPI: Integer); override;
  end;


implementation
uses frxUtils
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
{$IFDEF FPC}
, LCLType
{$ENDIF};
{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}


procedure TfrxRegEditorsDialog.Button1Click(Sender: TObject);
begin
  with FListBox do
  begin
{$IFNDEF FPC}
    Ctl3D := False;
{$ENDIF}
    Align := alClient;
    Style := lbOwnerDrawFixed;
    ItemHeight := 16;
//    OnClick := DoLBClick;
    OnDrawItem := VisibilityCBDrawItem;

    FPopupForm.Show;
  end;
end;

procedure TfrxRegEditorsDialog.ComboBtnClick(Sender: TObject);
begin
  FPopupForm.Show;
  ComboPanel.Enabled := False;
end;

procedure TfrxRegEditorsDialog.ComponentsLBClick(Sender: TObject);
begin
  FillEditors;
end;

procedure TfrxRegEditorsDialog.EditorsVLDrawCell(Sender: TObject; ACol,
  ARow: Integer; aRect: TRect; State: TGridDrawState);
var
  p: TPoint;
begin
  if not((ACol = 1) and (gdSelected in State)) then Exit;
  p := Self.ClientToScreen(Point(EditorsVL.Left + aRect.Left, EditorsVL.Top + aRect.Bottom));
  FPopupForm.SetBounds(p.X, p.Y, MulDiv(aRect.Right - aRect.Left, FPopupForm.CurrentFormPPI, CurrentFormPPI), FListBox.ItemHeight * FListBox.Items.Count + 2);
  ComboPanel.Left := EditorsVL.Left + aRect.Right - ComboPanel.Width - 1;
  ComboPanel.Top := EditorsVL.Top + aRect.Top + 3;
  ComboPanel.Visible := True;
end;

procedure TfrxRegEditorsDialog.EditorsVLSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  RegItem: TfrxComponentEditorsRegItem;
  aIndex: Integer;
begin
  aIndex := ComponentsLB.ItemIndex;
  if aIndex < 0 then Exit;
  aIndex := frxRegEditorsClasses.IndexOf(ComponentsLB.Items[aIndex]);
  if aIndex < 0 then Exit;
  RegItem := frxRegEditorsClasses.EditorsClasses[aIndex];
  FEditItem := RegItem.EditorVisibility[ARow - 1];
  FEditRow := ARow;
end;

procedure TfrxRegEditorsDialog.FillComponentsList;
var
  i: Integer;
begin
  ComponentsLB.Items.BeginUpdate;
  ComponentsLB.Items.Clear;
  for i := 0 to frxRegEditorsClasses.Count - 1 do
    ComponentsLB.Items.AddObject(frxRegEditorsClasses.EditorsClasses[i].ComponentClassName, frxRegEditorsClasses.EditorsClasses[i]);
  ComponentsLB.Items.EndUpdate;
end;

function GetSetDescription(Value: Integer): String;
var
  S: TIntegerSet;
  aTypeInfo: PTypeInfo;
  I: Integer;
begin
  Integer(S) := Value;
  aTypeInfo := TypeInfo(TfrxComponentEditorVisibility);
  {$IFDEF FPC}
  aTypeInfo := GetTypeData(aTypeInfo).CompType;
  {$ELSE}
  aTypeInfo := GetTypeData(aTypeInfo).CompType^;
  {$ENDIF}
  Result := '[';
  for i := 0 to 31 do
    if i in S then
    begin
      if Length(Result) <> 1 then
        Result := Result + ',';
      {$IFDEF FPC}
      Result := Result + typinfo.GetEnumName(aTypeInfo, i);
      {$ELSE}
      Result := Result + GetEnumName(aTypeInfo, i);
      {$ENDIF}
    end;
  Result := Result + ']';
end;


procedure TfrxRegEditorsDialog.FillEditors;
var
  Index, i: Integer;
 // RegItem: TfrxComponentEditorsRegItem;
  sProp: String;
  aTypeInfo: PTypeInfo;
  ptData: TTypeData;
  b: Boolean;
begin
  Index := ComponentsLB.ItemIndex;
  if Index < 0 then Exit;
  Index := frxRegEditorsClasses.IndexOf(ComponentsLB.Items[Index]);
  if Index < 0 then Exit;
  FListBox.Items.BeginUpdate;
  FListBox.Items.Clear;

  aTypeInfo := TypeInfo(TfrxComponentEditorVisibility);
  ptData := {$IFNDEF FPC}GetTypeData(GetTypeData(aTypeInfo).CompType^)^{$ELSE}
            GetTypeData(GetTypeData(aTypeInfo).CompType)^{$ENDIF};
  for i := ptData.MinValue to ptData.MaxValue do
    {$IFNDEF FPC}FListBox.Items.AddObject(GetEnumName(GetTypeData(aTypeInfo).CompType^, i), TObject(i)){$ELSE}
    FListBox.Items.AddObject(GetEnumName(GetTypeData(aTypeInfo).CompType, i), TObject(i)){$ENDIF};

  FListBox.Items.EndUpdate;

  EditorsVL.Strings.BeginUpdate;
  EditorsVL.Strings.Clear;
  FRegItem := frxRegEditorsClasses.EditorsClasses[Index];
  for i := 0 to FRegItem.Count - 1 do
  begin
    sProp := GetSetDescription(Byte(FRegItem.EditorVisibility[i]));
    //GetSetElementName(TypeInfo(TfrxComponentEditorVisibility), Integer(RegItem.FEditorsVisibility[i]));
    EditorsVL.InsertRow(TfrxInPlaceEditorClass(FRegItem.EditorClass[i]).ClassName, sProp, True);
  end;
  EditorsVL.Strings.EndUpdate;
  EditorsVLSelectCell(nil, 1, 1, b);
end;

procedure TfrxRegEditorsDialog.FormClick(Sender: TObject);
var
  Index: Integer;
begin
//
  Index := FListBox.ItemIndex;
  if index = -1 then Exit;

  if TfrxComponentEditorVisibilityState(FListBox.Items.Objects[Index]) in FEditItem then
    Exclude(FEditItem, TfrxComponentEditorVisibilityState(FListBox.Items.Objects[Index]))
  else
    Include(FEditItem, TfrxComponentEditorVisibilityState(FListBox.Items.Objects[Index]));
  FListBox.Repaint;
end;

procedure TfrxRegEditorsDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 ComboPanel.Enabled := True;
 if FEditRow <= 0 then Exit;
 FRegItem.EditorVisibility[FEditRow - 1] := FEditItem;
 FillEditors;
 EditorsVL.Repaint;
end;

procedure TfrxRegEditorsDialog.FormCreate(Sender: TObject);
begin
  FPopupForm := TfrxPopupForm.Create(Self);
  FListBox := TListBox.Create(FPopupForm);
  with FListBox do
  begin
    Parent := FPopupForm;
{$IFNDEF FPC}
    Ctl3D := False;
{$ENDIF}
    Align := alClient;
    Style := lbOwnerDrawFixed;
    ItemHeight := MulDiv(16, CurrentFormPPI, frx_DefaultPPI);
//    ItemHeight := 16;
//    OnClick := DoLBClick;
    OnDrawItem := VisibilityCBDrawItem;
    OnClick := FormClick;
  end;
  FPopupForm.OnClose := FormClose;
end;

procedure TfrxRegEditorsDialog.FormShow(Sender: TObject);
begin
  FillComponentsList;
  ComponentsLB.ItemIndex := 0;
  FillEditors;
end;

procedure TfrxRegEditorsDialog.UpdateFormPPI(aNewPPI: Integer);
var
  r: TRect;
begin
  inherited;
  r := Rect(0, 0, ComboBtn.Width - 5, ComboBtn.Height - 5);
  ComboBtn.Glyph.Width := r.Right;
  ComboBtn.Glyph.Height := r.Bottom;
  ComboBtn.Glyph.Canvas.Brush.Color := clBtnFace;
  ComboBtn.Glyph.Canvas.FillRect(r);
  frxDrawArrow(ComboBtn.Glyph.Canvas, r, clBlack);
end;

procedure TfrxRegEditorsDialog.VisibilityCBDrawItem(Control: TWinControl;
  Index: Integer; aRect: TRect; State: TOwnerDrawState);
var
  lScale: Single;
  sColor: TColor;
begin
  FListBox.Canvas.FillRect(aRect);
  sColor := FListBox.Canvas.Brush.Color;
  lScale := CurrentFormPPI / frx_DefaultPPI;
  frxDrawCheckBox(FListBox.Canvas, Rect(ARect.Left + 2, ARect.Top + 2, ARect.Left + (ARect.Bottom - ARect.Top - 3), ARect.Bottom - 1), clBlack, clBlack, TfrxComponentEditorVisibilityState(FListBox.Items.Objects[Index]) in FEditItem);
  FListBox.Canvas.Brush.Color := sColor;
  FListBox.Canvas.TextOut(aRect.Left + Round(20 * lScale), aRect.Top + 1, FListBox.Items[Index]);
end;

end.
