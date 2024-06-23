{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{           FilterDropDownFormsEh component             }
{                                                       }
{     Copyright (c) 2014-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit FilterDropDownFormsEh;

interface

uses
  Messages,
  {$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, DBGridsEh, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, DBGridEh, Windows, UxTheme,
  {$ENDIF}
  Themes, Types, Clipbrd,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DropDownFormEh, Dialogs, DynVarsEh, ToolCtrlsEh, DBCtrlsEh, GridsEh,
  StdCtrls, ExtCtrls,
  DBGridEhGrouping,
  StrUtils, Buttons;

type
  TFilterDropDownForm = class;

{ TMenuButtonEh }

  TMenuButtonEh = class(TCustomControl)
  private
    FActionItem: TCustomListboxItemEh;
    {$IFDEF FPC_CROSSP}
    {$ELSE}
    {$ENDIF} 
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    FMouseInControl: Boolean;
    procedure Paint; override;
  public
    FCaptionMargin: Integer;
    FDropDownForm: TFilterDropDownForm;

    function IsLine: Boolean;
    property ActionItem: TCustomListboxItemEh read FActionItem write FActionItem;
  end;

  TFilterDropDownFormListboxEh = class(TCustomListboxEh)
  public
    property DefaultRowHeight;
  end;

{ TFilterDropDownForm }

  TFilterDropDownForm = class(TCustomDropDownFormEh)
    Panel1: TPanel;
    bOk: TButton;
    bCancel: TButton;
    procedure bOkClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure CustomDropDownFormEhInitForm(Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
    procedure CustomDropDownFormEhCreate(Sender: TObject);
    procedure CustomDropDownFormEhDestroy(Sender: TObject);
    procedure CustomDropDownFormEhKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    FBaseList: TStringList;
    FEnterNotClearData: Boolean;
    FFilterList: TFilterDropDownFormListboxEh;
    FInFilterListBox: Boolean;
    FInternalSearchEditChanging: Boolean;
    FListRefCheckingState: array of Integer;
    FListValuesCheckingState: TBooleanDynArray;
    FPopupListboxDownIndex: Integer;
    FPopupListboxDragHoverIndex: Integer;
    FSearchEdit: TDBEditEh;
    FSelectAllState: TCheckBoxState;

    procedure SearchEditChanged(Sender: TObject);
    procedure RefilterList; virtual;
    procedure UpdateFilterFromValuesCheckingState(ss: TStrings);
    procedure UpdateSelectAllState;

  protected
    FMenuItemHeight: Integer;
    FLeftMargin: Integer;

    procedure DrawBorder(BorderRect: TRect); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure SearchEditButtonClick(Sender: TObject; var Handled: Boolean); virtual;
    procedure FilterListKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure SearchEditUserChanged; virtual;
    procedure SelectAllClicked(NewState: Boolean); virtual;
    procedure DataItemsStateUserChanged; virtual;
  public
    function CheckSelectedValues: Boolean; virtual;

    procedure InitOpening; virtual;
    procedure InitDataForBaseList; virtual;
    procedure ClearAllSelected; virtual;
    procedure SelectFilteredStateForRows(IsSelected: Boolean); virtual;

    procedure RealignControls; virtual;

    property SearchEdit: TDBEditEh read FSearchEdit;
    property FilterList: TFilterDropDownFormListboxEh read FFilterList;

    property BaseList: TStringList read FBaseList;
    property ListValuesCheckingState: TBooleanDynArray read FListValuesCheckingState;

  end;

{ TDDFormFilterPopupListboxItemEh }

  TDDFormFilterPopupListboxItemEh = class(TCustomListboxItemEh)
  protected
    function FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
  end;

{ TDDFormListboxItemEhData }

  TDDFormListboxItemEhSelectAll = class(TDDFormFilterPopupListboxItemEh)
  protected
    function CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    procedure DrawItem(Sender: TCustomListboxEh; ItemIndex: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure KeyPress(Sender: TCustomListboxEh; ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean); override;
  public
    function IsDataItem: Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

{ TDDFormListboxItemEhData }

  TDDFormListboxItemEhData = class(TDDFormFilterPopupListboxItemEh)
  protected
    function CanFocus(Sender: TCustomListboxEh; ItemIndex: Integer): Boolean; override;
    function GetDisplayText(Sender: TCustomListboxEh; ItemIndex: Integer): String; override;

    procedure DrawItem(Sender: TCustomListboxEh; ItemIndex: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
    procedure MouseUp(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure KeyPress(Sender: TCustomListboxEh; ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean); override;
  public
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

var
  FilterDropDownForm: TFilterDropDownForm;

  ListboxItemEhData: TDDFormListboxItemEhData;
  ListboxItemEhSelectAll: TDDFormListboxItemEhSelectAll;

  GetFilterDropDownFormProc: function : TFilterDropDownForm = nil;

function GetDefaultFilterDropDownForm: TFilterDropDownForm;

implementation

uses DBGridEhToolCtrls, EhLibLangConsts, Menus;

{$R *.dfm}

type
  TCustomListboxEhCrack = class(TFilterDropDownFormListboxEh);

function GetDefaultFilterDropDownForm: TFilterDropDownForm;
begin
  if FilterDropDownForm = nil then
    FilterDropDownForm := TFilterDropDownForm.Create(Application);
  Result := FilterDropDownForm;
end;

procedure TFilterDropDownForm.bCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TFilterDropDownForm.bOkClick(Sender: TObject);
begin
  if CheckSelectedValues then
    Close
  else
    ModalResult := mrCancel;
end;

function TFilterDropDownForm.CheckSelectedValues: Boolean;
begin
  Result := True;
end;

procedure TFilterDropDownForm.CustomDropDownFormEhCreate(Sender: TObject);
var
  EditButton: TEditButtonEh;
begin

  FMenuItemHeight := GetSystemMetrics(SM_CYMENU) + 2;
  FLeftMargin := FMenuItemHeight;

  FSearchEdit := TDBEditEh.Create(Self);
  FSearchEdit.Parent := Self;
  FSearchEdit.Top := 0;
  FSearchEdit.Left := FLeftMargin;
  FSearchEdit.Width := ClientWidth - 5 - FSearchEdit.Left;
  FSearchEdit.Anchors := [akLeft, akTop, akRight];
  FSearchEdit.OnChange := SearchEditChanged;
  FSearchEdit.Flat := True;

  EditButton := FSearchEdit.EditButtons.Add;
  EditButton.Style := ebsGlyphEh;
  if ThemesEnabled then
    EditButton.Images.NormalImages := DBGridEhRes.IMList10
  else
    EditButton.Images.NormalImages := DBGridEhRes.IMList10Bmp;
  EditButton.Images.NormalIndex := 10;
  EditButton.Images.HotIndex := 10;
  EditButton.Images.PressedIndex := 10;
  EditButton.Images.DisabledIndex := 10;
  EditButton.OnClick := SearchEditButtonClick;
  EditButton.Enabled := False;

  FFilterList := TFilterDropDownFormListboxEh.Create(Self);
  FFilterList.Parent := Self;
  FFilterList.SizeGripAlwaysShow := False;
  FFilterList.Top := FSearchEdit.Top + FSearchEdit.Height + 5;
  FFilterList.Left := FLeftMargin;
  FFilterList.Width := ClientWidth - 5 - FSearchEdit.Left;
  FFilterList.Height := Panel1.Top - FFilterList.Top;
  FFilterList.UseItemObjects := True;
  TCustomListboxEhCrack(FFilterList).SelectionDrawParams.SelectionStyle := gsdsClassicEh;

  FFilterList.Anchors := [akLeft, akTop, akRight,akBottom];
  TCustomListboxEhCrack(FFilterList).OnKeyPress := FilterListKeyPress;

  bOk.Caption := EhLibLanguageConsts.OKButtonEh;
  bCancel.Caption := EhLibLanguageConsts.CancelButtonEh;

  FBaseList := TStringList.Create;
end;

procedure TFilterDropDownForm.RealignControls;
var
  FLTop: Integer;
begin

  if UseRightToLeftAlignment then
  begin
    if akRight in  bOk.Anchors then
      Panel1.FlipChildren(True);
    bOk.Anchors := [akLeft, akTop];
    bCancel.Anchors := [akLeft, akTop];

    FSearchEdit.SetBounds(
      5, 5,
      ClientWidth - FLeftMargin - 5, FSearchEdit.Height);

    FLTop := FSearchEdit.Top + FSearchEdit.Height + 5;
    FFilterList.SetBounds(
      5, FLTop,
      ClientWidth - FLeftMargin - FSearchEdit.Left, Panel1.Top - FLTop);
  end else
  begin
    if akLeft in  bOk.Anchors then
      Panel1.FlipChildren(True);
    bOk.Anchors := [akRight, akTop];
    bCancel.Anchors := [akRight, akTop];

    FSearchEdit.SetBounds(
      FLeftMargin, 5,
      ClientWidth - 5 - FSearchEdit.Left, FSearchEdit.Height);

    FLTop := FSearchEdit.Top + FSearchEdit.Height + 5;
    FFilterList.SetBounds(
      FLeftMargin, FLTop,
      ClientWidth - 5 - FSearchEdit.Left, Panel1.Top - FLTop);
  end;
end;

procedure TFilterDropDownForm.CustomDropDownFormEhDestroy(Sender: TObject);
begin
  FreeAndNil(FBaseList);
end;

procedure TFilterDropDownForm.CustomDropDownFormEhInitForm(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  FFilterList.ItemHeight := FFilterList.GetTextHeight + 1;

  RefilterList;
  FPopupListboxDownIndex := -1;
  UpdateSelectAllState;

  RealignControls;
  InitOpening;
end;

procedure TFilterDropDownForm.CustomDropDownFormEhKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (Shift = []) then
    bCancelClick(Sender);
end;

procedure TFilterDropDownForm.DrawBorder(BorderRect: TRect);
var
{$IFDEF VistaThemesSuppored}
  Details: TThemedElementDetails;
  AMenuStyle: TThemedMenu;
{$ELSE}
  FaceBrush: HBRUSH;
{$ENDIF}
  R: TRect;
begin
  R := BorderRect;

  ExcludeClipRect(Canvas.Handle, R.Left+BorderWidth, R.Top+BorderWidth, R.Right-BorderWidth, R.Bottom-BorderWidth);

{$IFDEF VistaThemesSuppored}
  if ThemesEnabled then
  begin
    AMenuStyle := tmPopupBorders;
    Details := ThemeServices.GetElementDetails(AMenuStyle);
    ThemeServices.DrawElement(Canvas.Handle, Details, R);
  end else
{$ELSE}
  begin
    DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_RECT or BF_FLAT);
    FaceBrush := GetSysColorBrush(COLOR_MENU);
    InflateRect(R, -1, -1);
    FrameRect(Canvas.Handle, R, FaceBrush);
    InflateRect(R, -1, -1);
    FrameRect(Canvas.Handle, R, FaceBrush);
  end;
{$ENDIF}
end;

procedure TFilterDropDownForm.FilterListKeyPress(Sender: TObject;
  var Key: Char);
var
  ItemIndex: Integer;
  Item: TCustomListboxItemEh;
begin
  if Key = ' ' then
  begin
    ItemIndex := TCustomListboxEh(Sender).ItemIndex;
    if (ItemIndex >= 0) and
       (TCustomListboxEh(Sender).Items.Objects[ItemIndex] is TCustomListboxItemEh)
    then
    begin
      FEnterNotClearData := True;
      Item := TCustomListboxItemEh(TCustomListboxEh(Sender).Items.Objects[ItemIndex]);
      Item.Execute(TCustomListboxEh(Sender), ItemIndex, Point(-1,-1), GetShiftState);
    end;
    Key := #0;
  end;
end;

procedure TFilterDropDownForm.InitOpening;
begin
  ActiveControl := FFilterList;
  FInternalSearchEditChanging := True;
  try
    SearchEdit.Clear;
  finally
    FInternalSearchEditChanging := False;
  end;
end;

procedure TFilterDropDownForm.KeyDown(var Key: Word; Shift: TShiftState);
var
  ClipBoardStr: String;
begin
  inherited KeyDown(Key, Shift);
  if (ActiveControl <> SearchEdit) and
     (ssCtrl in Shift) and
     (Key = Word('V')) then //Paste
  begin
    if ClipBoard.HasFormat(CF_TEXT) then
    ClipBoardStr := RemoveLineBreaksFromText(ClipBoard.AsText);
    SearchEdit.Text := ClipBoardStr;
  end;
end;

procedure TFilterDropDownForm.InitDataForBaseList;
var
  i: Integer;
begin
  BaseList.BeginUpdate;
  try
    for i := 0 to BaseList.Count - 1 do
      if BaseList.Objects[i] = nil then
        BaseList.Objects[i] := ListboxItemEhData;
  finally
    BaseList.EndUpdate;
  end;

  SetLength(FListValuesCheckingState, BaseList.Count);
  for i := 0 to Length(ListValuesCheckingState)-1 do
    ListValuesCheckingState[i] := False;

  SetLength(FListRefCheckingState, BaseList.Count+1);
end;

procedure TFilterDropDownForm.RefilterList;
var
  AList: TStrings;
  i,k: Integer;
  CharMsg: TMsg;
begin
  AList := FFilterList.Items;
  AList.BeginUpdate;
  AList.Clear;
  k := 0;
  SetLength(FListRefCheckingState, FBaseList.Count+1);

  AList.AddObject(EhLibLanguageConsts.STFilterListItem_SelectAll, ListboxItemEhSelectAll);
  FListRefCheckingState[k] := -1;
  Inc(k);

  try
    for i := 0 to FBaseList.Count-1 do
    begin
      if PeekMessage(CharMsg, FSearchEdit.Handle, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
      begin

        Break;
      end;
      if (FSearchEdit.Text = '') or AnsiContainsText(FBaseList[i], FSearchEdit.Text) then
      begin
        AList.AddObject(FBaseList[i], ListboxItemEhData);
        FListRefCheckingState[k] := i;
        Inc(k);
      end;
    end;
  finally
    AList.EndUpdate;
  end;

  SetLength(FListRefCheckingState, k);
end;

procedure TFilterDropDownForm.SearchEditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  SearchEdit.Clear;
end;

procedure TFilterDropDownForm.SearchEditChanged(Sender: TObject);
begin
  RefilterList;
  UpdateSelectAllState;
  SearchEdit.EditButtons[0].Enabled := (SearchEdit.Text <> '');

  if not FInternalSearchEditChanging then
  begin
    SearchEditUserChanged;
  end;
end;

procedure TFilterDropDownForm.SearchEditUserChanged;
begin

end;

procedure TFilterDropDownForm.UpdateFilterFromValuesCheckingState(ss: TStrings);
begin
  UpdateSelectAllState;
end;

procedure TFilterDropDownForm.UpdateSelectAllState;
var
  i: Integer;
  Items: TStrings;
  AllCount, CheckedCount: Integer;
begin
  Items := FilterList.Items;
  AllCount := 0;
  CheckedCount := 0;
  for i := 0 to Items.Count-1 do
  begin
    if (Items.Objects[i] is TDDFormListboxItemEhData) then
    begin
      Inc(AllCount);
      if FListValuesCheckingState[FListRefCheckingState[i]] = True then
        Inc(CheckedCount);
    end;
  end;
  if CheckedCount = 0 then
    FSelectAllState := cbUnchecked
  else if CheckedCount = AllCount then
    FSelectAllState := cbChecked
  else
    FSelectAllState := cbGrayed;
end;

procedure TFilterDropDownForm.ClearAllSelected;
var
  I: Integer;
begin
  for I := 0 to Length(FListValuesCheckingState) - 1 do
  begin
    FListValuesCheckingState[I] := False;
  end;
end;

procedure TFilterDropDownForm.SelectAllClicked(NewState: Boolean);
begin
  SelectFilteredStateForRows(NewState);
end;

procedure TFilterDropDownForm.SelectFilteredStateForRows(IsSelected: Boolean);
var
  I: Integer;
begin
  for I := 0 to Length(FListRefCheckingState)-1 do
  begin
    if FListRefCheckingState[i] >= 0 then
    begin
      FListValuesCheckingState[FListRefCheckingState[i]] := IsSelected;
    end;
  end;
end;

procedure TFilterDropDownForm.DataItemsStateUserChanged;
begin
end;

{ TMenuButtonEh }

procedure TMenuButtonEh.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if {$IFDEF EH_LIB_16} StyleServices.Enabled and {$ENDIF}
     not FMouseInControl and
     not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
    Repaint;
  end;
end;

procedure TMenuButtonEh.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if {$IFDEF EH_LIB_16} StyleServices.Enabled and {$ENDIF}
     FMouseInControl then
  begin
    FMouseInControl := False;
    Repaint;
  end;
end;

function TMenuButtonEh.IsLine: Boolean;
begin
  Result := Caption = cLineCaption;
end;

procedure TMenuButtonEh.Paint;
var
  AAcitve: Boolean;
{$IFDEF EH_LIB_16}
  Details: TThemedElementDetails;
  AMenuStyle: TThemedMenu;
{$ENDIF}
  PaintRect: TRect;
  S: String;
  TextRect: TRect;
  Alignment: TAlignment;
begin
  PaintRect := ClientRect;
  Canvas.Font.Color := CheckSysColor(Font.Color);
  if ThemesEnabled then
{$IFDEF EH_LIB_16}
    StyleServices.DrawParentBackground(Handle, Canvas.Handle, nil, True)
{$ELSE}
    ThemeServices.DrawParentBackground(0, Canvas.Handle, nil, True)
{$ENDIF}
  else
    PerformEraseBackground(Self, Canvas.Handle);

  if IsLine then
  begin
{$IFDEF EH_LIB_16}
    AMenuStyle := tmPopupSeparator;
    Details := ThemeServices.GetElementDetails(AMenuStyle);
    ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
{$ELSE}
    Canvas.Pen.Color := CheckSysColor(clBtnShadow);
    Canvas.Polyline([Point(PaintRect.Left, (PaintRect.Top + PaintRect.Bottom) div 2),
                      Point(PaintRect.Right, (PaintRect.Top + PaintRect.Bottom) div 2)]);
{$ENDIF}
  end else
  begin
    AAcitve := FMouseInControl;
    if AAcitve or Focused then
    begin
{$IFDEF EH_LIB_16}
      if ThemesEnabled then
      begin
        AMenuStyle := tmPopupCheckBackgroundNormal;
        Details := ThemeServices.GetElementDetails(AMenuStyle);
        ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect)
      end else
{$ENDIF}
      begin
        Canvas.Brush.Color := CheckSysColor(clHighlight);
        Canvas.Font.Color := CheckSysColor(clHighlightText);
        Canvas.FillRect(PaintRect);
      end;
    end;

    S := Caption;
    TextRect := PaintRect;
    if Parent.UseRightToLeftAlignment then
    begin
      TextRect.Right := TextRect.Right - FCaptionMargin;
      Alignment := taRightJustify;
    end else
    begin
      TextRect.Left := TextRect.Left + FCaptionMargin;
      Alignment := taLeftJustify;
    end;

    WriteTextEh(Canvas, TextRect, False, 0, 0, S, Alignment, tlCenter, False, False, 0, 0, False, True);

  end;
end;

{ TDDFormFilterPopupListboxItemEh }

function TDDFormFilterPopupListboxItemEh.FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
begin
  Result := TFilterDropDownForm(Listbox.Owner);
end;

{ TDDFormListboxItemEhData }

procedure TDDFormListboxItemEhData.DrawItem(Sender: TCustomListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TGridDrawState);
var
  CBRect: TRect;
  MouseIndex: Integer;
  IsDown: Integer;
  CBState: TCheckBoxState;
  IsActive: Boolean;
  DownIndex, DragHoverIndex: Integer;
  SMFillRect: TRect;
  sText, DrawText: String;
  ofv: Integer;
begin
  MouseIndex := Sender.ItemAtPos(Sender.ScreenToClient(SafeGetMouseCursorPos), True);
  IsDown := 0;
  if FilterForm(Sender).FPopupListboxDownIndex >= 0 then
  begin
    DownIndex := FilterForm(Sender).FPopupListboxDownIndex;
    DragHoverIndex := FilterForm(Sender).FPopupListboxDragHoverIndex;
    if (DragHoverIndex >= DownIndex) and (DragHoverIndex >= ItemIndex) and (DownIndex <= ItemIndex) then
      IsDown := -1
    else if (DragHoverIndex <= DownIndex) and (DragHoverIndex <= ItemIndex) and (DownIndex >= ItemIndex) then
      IsDown := -1;
  end;

  if FilterForm(Sender).FListValuesCheckingState[FilterForm(Sender).FListRefCheckingState[ItemIndex]] = True
    then CBState := cbChecked
    else CBState := cbUnchecked;
  IsActive := (MouseIndex >= 0) and (MouseIndex = ItemIndex) and (Mouse.Capture = 0);
  CBRect := Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth, ARect.Bottom);

  if IsDown = -1 then
  begin
    State := State + [gdSelected];
    Sender.Canvas.Brush.Color := CheckSysColor(clHighlight);
    Sender.Canvas.Font.Color := CheckSysColor(clHighlightText);
  end else
    Sender.Canvas.Brush.Color := CheckSysColor(Sender.Color);

  SMFillRect := ARect;
  SMFillRect.Right := SMFillRect.Left + DefaultCheckBoxWidth + 2;
  Sender.Canvas.FillRect(SMFillRect);

  if Sender.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Sender.Canvas.Handle, CBRect);
    SwapInt(CBRect.Left, CBRect.Right);
    TCustomListboxEhCrack(Sender).ChangeGridOrientation(Sender.Canvas, False);
  end;

  PaintButtonControlEh(Sender.Canvas, CBRect, Sender.Canvas.Brush.Color,
    bcsCheckboxEh, IsDown, True, IsActive, True, CBState);

  if Sender.UseRightToLeftAlignment then
  begin
    TCustomListboxEhCrack(Sender).ChangeGridOrientation(Sender.Canvas, True);
  end;

  ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;

  DrawText := Sender.Items[ItemIndex];
  if DrawText = '' then
    DrawText := EhLibLanguageConsts.STFilterListItem_Empties;

  Sender.DefaultDrawItem(ItemIndex, ARect, State);

  sText := FilterForm(Sender).FSearchEdit.Text;
  if sText <> '' then
  begin
    DrawHighlightedSubTextEh(Sender.Canvas, ARect, 2, 0, DrawText,
      taLeftJustify, tlTop, False, False, 0, 0, False, sText, True, False, False,
      RGBToColorEh(255,255,150), 0, clYellow, ofv);
  end;
end;

function TDDFormListboxItemEhData.CanFocus(Sender: TCustomListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TDDFormListboxItemEhData.MouseDown(Sender: TCustomListboxEh; ItemIndex: Integer;
  InItemPos: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  if Button = mbLeft then
  begin
    FilterForm(Sender).FPopupListboxDownIndex := ItemIndex;
    FilterForm(Sender).FPopupListboxDragHoverIndex := ItemIndex;
    Sender.InvalidateIndex(ItemIndex);
  end;
end;

procedure TDDFormListboxItemEhData.MouseMove(Sender: TCustomListboxEh; ItemIndex: Integer;
  InItemPos: TPoint; Shift: TShiftState);
begin
  if (FilterForm(Sender).FPopupListboxDownIndex >= 0) and
     (FilterForm(Sender).FPopupListboxDragHoverIndex <> ItemIndex) then
  begin
    Sender.InvalidateIndex(FilterForm(Sender).FPopupListboxDownIndex);
    FilterForm(Sender).FPopupListboxDragHoverIndex := ItemIndex;
    Sender.Invalidate;
  end;
end;

procedure TDDFormListboxItemEhData.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
var
  MousePos: TPoint;
  Index: Integer;
  FormIdx, ToIdx: Integer;
  CheckState: Boolean;
  i: Integer;
  AFilterForm: TFilterDropDownForm;
  DownIndex: Integer;
begin
  AFilterForm := FilterForm(Sender);
  if AFilterForm.FPopupListboxDownIndex = ItemIndex then
  begin
    AFilterForm.FEnterNotClearData := True;
    Execute(Sender, ItemIndex, InItemPos, Shift);
    MousePos := Sender.ScreenToClient(SafeGetMouseCursorPos);
    Index := Sender.ItemAtPos(MousePos, True);
    if Index < Sender.Items.Count then
      Sender.ItemIndex := Index;
  end
  else if (AFilterForm.FPopupListboxDownIndex >= 0) and
              (AFilterForm.FPopupListboxDragHoverIndex >= 0) then
  begin
    DownIndex := AFilterForm.FPopupListboxDownIndex;
    if DownIndex = 0 then
      DownIndex := 1;
    CheckState := not AFilterForm.FListValuesCheckingState
      [AFilterForm.FListRefCheckingState[DownIndex]];
    if AFilterForm.FPopupListboxDragHoverIndex > DownIndex then
    begin
      FormIdx := DownIndex;
      ToIdx := AFilterForm.FPopupListboxDragHoverIndex;
    end else
    begin
      FormIdx := AFilterForm.FPopupListboxDragHoverIndex;
      ToIdx := DownIndex;
    end;
    for i := FormIdx to ToIdx do
      AFilterForm.FListValuesCheckingState[AFilterForm.FListRefCheckingState[i]] := CheckState;
    AFilterForm.UpdateFilterFromValuesCheckingState(Sender.Items);
    AFilterForm.DataItemsStateUserChanged;
    Sender.Invalidate;
  end;
  AFilterForm.FPopupListboxDownIndex := -1;
  Sender.Invalidate;
end;

procedure TDDFormListboxItemEhData.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  i: Integer;
  AFilterForm: TFilterDropDownForm;
begin
  AFilterForm := FilterForm(Sender);
  AFilterForm.FInFilterListBox := True;
  try
    if not AFilterForm.FEnterNotClearData then
    begin
      for i := 0 to Length(AFilterForm.FListValuesCheckingState)-1 do
      begin
        AFilterForm.FListValuesCheckingState[i] := False;
      end;
    end;
    AFilterForm.FListValuesCheckingState[AFilterForm.FListRefCheckingState[ItemIndex]] :=
      not AFilterForm.FListValuesCheckingState[AFilterForm.FListRefCheckingState[ItemIndex]];
    AFilterForm.UpdateFilterFromValuesCheckingState(Sender.Items);
    AFilterForm.DataItemsStateUserChanged;
  finally
    AFilterForm.FInFilterListBox := False;
  end;
  Sender.Invalidate;
end;

function TDDFormListboxItemEhData.GetDisplayText(Sender: TCustomListboxEh;
  ItemIndex: Integer): String;
begin
  if Sender.Items[ItemIndex] = '' then
    Result := EhLibLanguageConsts.STFilterListItem_Empties
  else
    Result := inherited GetDisplayText(Sender, ItemIndex);
end;

procedure TDDFormListboxItemEhData.KeyPress(Sender: TCustomListboxEh;
  ItemIndex: Integer; var Key: Char; Shift: TShiftState; var IsCloseListbox: Boolean);
begin

end;

{ TDDFormListboxItemEhSelectAll }

function TDDFormListboxItemEhSelectAll.CanFocus(Sender: TCustomListboxEh;
  ItemIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TDDFormListboxItemEhSelectAll.DrawItem(Sender: TCustomListboxEh;
  ItemIndex: Integer; ARect: TRect; State: TGridDrawState);
var
  CBRect: TRect;
  MouseIndex: Integer;
  IsDown{, OldRigth}: Integer;
  CBState: TCheckBoxState;
  IsActive: Boolean;
  DownIndex, DragHoverIndex: Integer;
  SMFillRect: TRect;
begin
  MouseIndex := Sender.ItemAtPos(Sender.ScreenToClient(SafeGetMouseCursorPos), True);
  IsDown := 0;
  if FilterForm(Sender).FPopupListboxDownIndex >= 0 then
  begin
    DownIndex := FilterForm(Sender).FPopupListboxDownIndex;
    DragHoverIndex := FilterForm(Sender).FPopupListboxDragHoverIndex;
    if (DragHoverIndex >= DownIndex) and (DragHoverIndex >= ItemIndex) and (DownIndex <= ItemIndex) then
      IsDown := -1
    else if (DragHoverIndex <= DownIndex) and (DragHoverIndex <= ItemIndex) and (DownIndex >= ItemIndex) then
      IsDown := -1;
  end;

  CBState := FilterForm(Sender).FSelectAllState;
  IsActive := (MouseIndex >= 0) and (MouseIndex = ItemIndex) and (Mouse.Capture = 0);
  CBRect := Rect(ARect.Left, ARect.Top, ARect.Left + DefaultCheckBoxWidth, ARect.Bottom);

  if IsDown = -1 then
  begin
    State := State + [gdSelected];
    Sender.Canvas.Brush.Color := CheckSysColor(clHighlight);
    Sender.Canvas.Font.Color := CheckSysColor(clHighlightText);
  end else
    Sender.Canvas.Brush.Color := CheckSysColor(Sender.Color);

  SMFillRect := ARect;
  SMFillRect.Right := SMFillRect.Left + DefaultCheckBoxWidth + 2;
  Sender.Canvas.FillRect(SMFillRect);

  if Sender.UseRightToLeftAlignment then
  begin
    WindowsLPtoDP(Sender.Canvas.Handle, CBRect);
    SwapInt(CBRect.Left, CBRect.Right);
    TCustomListboxEhCrack(Sender).ChangeGridOrientation(Sender.Canvas, False);
  end;

  PaintButtonControlEh(Sender.Canvas, CBRect, Sender.Canvas.Brush.Color,
    bcsCheckboxEh, IsDown, True, IsActive, True, CBState);

  if Sender.UseRightToLeftAlignment then
  begin
    TCustomListboxEhCrack(Sender).ChangeGridOrientation(Sender.Canvas, True);
  end;

  ARect.Left := ARect.Left + DefaultCheckBoxWidth + 2;
  Sender.DefaultDrawItem(ItemIndex, ARect, State);
end;

procedure TDDFormListboxItemEhSelectAll.KeyPress(Sender: TCustomListboxEh;
  ItemIndex: Integer; var Key: Char; Shift: TShiftState;
  var IsCloseListbox: Boolean);
begin
  inherited;
end;

procedure TDDFormListboxItemEhSelectAll.MouseDown(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
begin
  if Button = mbLeft then
  begin
    FilterForm(Sender).FPopupListboxDownIndex := ItemIndex;
    FilterForm(Sender).FPopupListboxDragHoverIndex := ItemIndex;
    Sender.InvalidateIndex(ItemIndex);
  end;
end;

procedure TDDFormListboxItemEhSelectAll.MouseMove(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
end;

procedure TDDFormListboxItemEhSelectAll.MouseUp(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Button: TMouseButton;
  Shift: TShiftState);
var
  MousePos: TPoint;
  Index: Integer;
  AFilterForm: TFilterDropDownForm;
begin
  AFilterForm := FilterForm(Sender);
  if AFilterForm.FPopupListboxDownIndex = ItemIndex then
  begin
    AFilterForm.FEnterNotClearData := True;
    Execute(Sender, ItemIndex, InItemPos, Shift);
    MousePos := Sender.ScreenToClient(SafeGetMouseCursorPos);
    Index := Sender.ItemAtPos(MousePos, True);
    if Index < Sender.Items.Count then Sender.ItemIndex := Index;
  end;
  AFilterForm.FPopupListboxDownIndex := -1;
  Sender.Invalidate;
end;

procedure TDDFormListboxItemEhSelectAll.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  NewState: Boolean;
  Form: TFilterDropDownForm;
begin
  Form := FilterForm(Sender);
  if Form.FSelectAllState = cbUnchecked then
  begin
    NewState := True;
    Form.FSelectAllState := cbChecked;
  end else
  begin
    NewState := False;
    Form.FSelectAllState := cbUnchecked;
  end;

  Form.SelectAllClicked(NewState);
  Sender.Invalidate;
end;

function TDDFormListboxItemEhSelectAll.IsDataItem: Boolean;
begin
  Result := False;
end;

initialization
  ListboxItemEhData := TDDFormListboxItemEhData.Create;
  ListboxItemEhSelectAll := TDDFormListboxItemEhSelectAll.Create;

  GetFilterDropDownFormProc := @GetDefaultFilterDropDownForm;

finalization
  FreeAndNil(ListboxItemEhData);
  FreeAndNil(ListboxItemEhSelectAll);
end.
