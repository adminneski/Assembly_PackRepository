{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{            SearchPanel for Grids and lists            }
{                                                       }
{   Copyright (c) 2016-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit SearchPanelsEh;

interface

uses
  {$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  {$IFDEF FPC}
  EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows, UxTheme,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, SqlTimSt, Windows, UxTheme,
  {$ENDIF}
  Messages, Forms, SysUtils, Classes, Controls,
  Variants, Types, Themes,
  DBCtrlsEh, ToolCtrlsEh, ButtonsEh,
  Graphics, DBCtrls, ExtCtrls, Db, Buttons, ImgList, Menus;

type
  TSearchPanelRes = class(TDataModule)
    IMList10: TImageList;
    IMList10D: TImageList;
    IMList12_D: TImageList;
    IMList12: TImageList;
    IMList10Bmp: TImageList;
    IMList10DBmp: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetIMList10: TImageList;
    function GetIMList10Disabled: TImageList;
  end;

  TSearchPanelControlEh = class;

  TDBGridEhNavigatorFindBtn = (gnfbSearchInfoBoxEh, gnfbCancelSearchFilterEh, gnfbFindNextEh, gnfbFindPrevEh, gnfbOptionsEh);
  TDBGridEhNavigatorFindBtns = set of TDBGridEhNavigatorFindBtn;

  TSearchPanelLocationEh = (splGridTopEh, splHorzScrollBarExtraPanelEh, splExternal, splCellInplaceEh);

{ TNavFindButtonEh }

  TNavFindButtonEh = class(TCustomSpeedButtonEh)
  private
    FIndex: TDBGridEhNavigatorFindBtn;
    FOnPostMouseDown: TMouseEvent;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    procedure DrawInfoText;
  public
    property Index: TDBGridEhNavigatorFindBtn read FIndex write FIndex;
    property OnPostMouseDown: TMouseEvent read FOnPostMouseDown write FOnPostMouseDown;
  end;

  { TDBGridSearchPanelTextEditEh }

  TSearchPanelTextEditEh = class(TDBComboBoxEh)
  private
    
    FInternalChanging: Boolean;
    FIsEmptyState: Boolean;
    FMiniHeight: Boolean;
    FOnUpdateModified: TNotifyEvent;
    FTextAppliedAsFilter: Boolean;
    FMRUEditButton: TEditButtonEh;

    function GetSearchPanelControl: TSearchPanelControlEh;

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;

    procedure SetIsEmptyState(const Value: Boolean);

    {$IFDEF FPC_CROSSP}
    {$ELSE}
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    {$ENDIF}
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure SetTextAppliedAsFilter(const Value: Boolean);

  protected
    function CalcAutoHeight: Integer;
    function GetBorderColor: TColor; virtual;

    procedure CalcEditRect(var ARect: TRect); override;
    procedure Change; override;
    procedure CheckAddTextToList;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure DoChangeAction; virtual;
    procedure DrawNonClientBorder; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SpecInternalSetText(const AText: String);
    procedure UpdateModified;
    procedure EditButtonDownDefaultAction(EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh; TopButton: Boolean; var AutoRepeat: Boolean; var Handled: Boolean); override;

    procedure WndProc(var Message: TMessage); override;

    procedure MRUListActiveChanged(Sender: TObject); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ApplySearchFilter;
    procedure ClearSearchFilter;
    procedure CancelSearchEditorMode;
    procedure CancelFilter;
    procedure CheckAddTextToMRUList; virtual;

    
    property IsEmptyState: Boolean read FIsEmptyState write SetIsEmptyState;
    property SearchPanelControl: TSearchPanelControlEh read GetSearchPanelControl;
    property MiniHeight: Boolean read FMiniHeight write FMiniHeight;
    property OnUpdateModified: TNotifyEvent read FOnUpdateModified write FOnUpdateModified;
    property TextAppliedAsFilter: Boolean read FTextAppliedAsFilter write SetTextAppliedAsFilter;
  end;

{ TSearchPanelControlEh }

  TSearchPanelControlEh = class(TCustomControl)
  private
    ButtonWidth: Integer;
    FFindEditor: TSearchPanelTextEditEh;
    FLocation: TSearchPanelLocationEh;
    MinBtnSize: TPoint;
    FTestMenuItem: TMenuItemEh;

    procedure SetLocation(const Value: TSearchPanelLocationEh);
    {$IFDEF FPC_CROSSP}
    {$ELSE}
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    {$ENDIF}
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    function GetFindButtons(FindBtn: TDBGridEhNavigatorFindBtn): TNavFindButtonEh;

  protected
    FFindButtons: array[TDBGridEhNavigatorFindBtn] of TNavFindButtonEh;

    function CalcSearchInfoBoxWidth: Integer; virtual;
    function CancelSearchFilterEnable: Boolean; virtual;
    function CreateSearchPanelTextEdit: TSearchPanelTextEditEh; virtual;
    function GetMasterControlSearchEditMode: Boolean; virtual;
    function GetSearchInfoBoxText: String; virtual;
    function IsOptionsButtonVisible: Boolean; virtual;
    function MasterControlFilterEnabled: Boolean; virtual;

    procedure AcquireMasterControlFocus; virtual;
    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure BuildOptionsPopupMenu(var PopupMenu: TPopupMenu); virtual;
    procedure ClickHandler(Sender: TObject); virtual;
    procedure CreateWnd; override;
    procedure DrawNonClientBorder; virtual;
    procedure FindBtnClick(Index: TDBGridEhNavigatorFindBtn); virtual;
    procedure FindEditorKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure FindEditorKeyPress(var Key: Char); virtual;
    procedure FindEditorKeyUp(var Key: Word; Shift: TShiftState); virtual;
    procedure FindEditorUpdateModified(Sender: TObject);
    procedure FindEditorUserChanged; virtual;
    procedure FindNext;
    procedure FindPrev;
    procedure MasterControlApplySearchFilter; virtual;
    procedure MasterControlCancelSearchEditorMode; virtual;
    procedure MasterControlFindNext; virtual;
    procedure MasterControlFindPrev; virtual;
    procedure MasterControlProcessFindEditorKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure MasterControlProcessFindEditorKeyPress(var Key: Char); virtual;
    procedure MasterControlProcessFindEditorKeyUp(var Key: Word; Shift: TShiftState); virtual;
    procedure MasterControlRestartFind; virtual;
    procedure OptionsButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure Paint; override;
    procedure Resize; override;
    procedure RestartFind;
    procedure SetGetMasterControlSearchEditMode(Value: Boolean); virtual;
    procedure SetSize(var W: Integer; var H: Integer);

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcAutoHeight: Integer;
    function CalcAutoWidthForHeight(ANewHeight: Integer): Integer;
    function CanPerformSearchActionInMasterControl: Boolean; virtual;
    function GetSearchingText: String;
    function GetFindEditorBorderColor: TColor; virtual;
    function GetBorderColor: TColor; virtual;
    function IsSearchingState: Boolean;
    function FilterOnTyping: Boolean; virtual;
    function FilterEnabled: Boolean; virtual;

    procedure CancelSearchEditorMode; virtual;
    procedure ClearSearchFilter; virtual;
    procedure ApplySearchFilter; virtual;
    procedure GetPaintColors(var FromColor, ToColor, HighlightColor: TColor); virtual;

    procedure InitItems;
    procedure ResetVisibleControls;
    procedure RealignControls; virtual;
    procedure UpdateLanguageVars; virtual;

    property FindButtons[FindBtn: TDBGridEhNavigatorFindBtn]: TNavFindButtonEh read GetFindButtons;
    property FindEditor: TSearchPanelTextEditEh read FFindEditor;
    property Location: TSearchPanelLocationEh read FLocation write SetLocation default splGridTopEh;
    property MasterControlSearchEditMode: Boolean read GetMasterControlSearchEditMode write SetGetMasterControlSearchEditMode;
  end;

var
  SearchPanelRes: TSearchPanelRes;

implementation

uses Math, Dialogs, StdCtrls,
{$IFDEF FPC}
  DBGridsEh,
{$ELSE}
  DBGridEh, VDBConsts,
{$ENDIF}
  DBGridEhImpExp, DBGridEhToolCtrls,
  EhLibLangConsts, Clipbrd, EhLibImageReses;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

type
  TWinControlCrack = class(TWinControl);

var
  SearchPanelOptionsPopupMenu: TPopupMenuEh;

procedure InitRes;
begin
  SearchPanelRes := TSearchPanelRes.CreateNew(nil, -1);
  InitInheritedComponent(SearchPanelRes, TDataModule);
end;

procedure FinRes;
var
  i: Integer;
begin
  FreeAndNil(SearchPanelRes);

  if SearchPanelOptionsPopupMenu <> nil then
  begin
    for i := SearchPanelOptionsPopupMenu.Items.Count-1 downto 0 do
      SearchPanelOptionsPopupMenu.Items.Delete(i);
    FreeAndNil(SearchPanelOptionsPopupMenu);
  end;
end;

{ TSearchPanelRes }

function TSearchPanelRes.GetIMList10: TImageList;
begin
  {$IFDEF FPC_CROSSP}
  Result := IMList10Bmp;
  {$ELSE}
  if ThemesEnabled
    then Result := IMList10
    else Result := IMList10Bmp;
  {$ENDIF}
end;

function TSearchPanelRes.GetIMList10Disabled: TImageList;
begin
  {$IFDEF FPC_CROSSP}
  Result := IMList10DBmp;
  {$ELSE}
  if ThemesEnabled
    then Result := IMList10D
    else Result := IMList10DBmp;
  {$ENDIF}
end;

{ TNavFindButtonEh }

procedure TNavFindButtonEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Assigned(FOnPostMouseDown) then
    FOnPostMouseDown(Self, Button, Shift, X, Y);
end;

procedure TNavFindButtonEh.Paint;
begin
  if FIndex = gnfbSearchInfoBoxEh
    then DrawInfoText
    else inherited Paint;
end;

procedure TNavFindButtonEh.DrawInfoText;
var
  s: String;
begin
  Canvas.Font.Color := clGrayText;
  s := TSearchPanelControlEh(Owner).GetSearchInfoBoxText;
  WriteTextEh(Canvas, ClientRect, False, 0, 0, s, taCenter, tlCenter,
    False, False, 0, 0, UseRightToLeftAlignment, False);
end;

{ TDBGridSearchPanelTextEditEh }

constructor TSearchPanelTextEditEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TStringList(Items).Duplicates := dupIgnore;
  TStringList(Items).Sorted := True;
  TextAppliedAsFilter := False;
  CaseInsensitiveTextSearch := False;
  FMRUEditButton := EditButtons.Add();
  FMRUEditButton.Visible := False;
  FMRUEditButton.Style := ebsAltDropDownEh;
  FMRUEditButton.DrawBackTime := edbtWhenHotEh;
  MRUList.OnActiveChanged := MRUListActiveChanged;
end;

destructor TSearchPanelTextEditEh.Destroy;
begin
  inherited Destroy;
end;

procedure TSearchPanelTextEditEh.DoChangeAction;
begin
  SearchPanelControl.FindEditorUserChanged;
  if not (SearchPanelControl.FilterEnabled and
          SearchPanelControl.FilterOnTyping) then
  begin
    TextAppliedAsFilter := False;
  end;
  UpdateModified;
end;

procedure TSearchPanelTextEditEh.Change;
begin
  inherited Change;
  if FInternalChanging then Exit;
  DoChangeAction;
end;

procedure TSearchPanelTextEditEh.CMMouseEnter(var Message: TMessage);
begin
  Color := StyleServices.GetSystemColor(clWindow);
  inherited;
end;

procedure TSearchPanelTextEditEh.CMMouseLeave(var Message: TMessage);
begin
  if not Focused then
    Color := ApproximateColor(
      StyleServices.GetSystemColor(TWinControlCrack(Parent).Color),
      StyleServices.GetSystemColor(clWindow), 256 div 3 * 2);
  inherited;
end;

procedure TSearchPanelTextEditEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF FPC}
  Params.Style := Params.Style or WS_BORDER;
  Params.ExStyle := Params.ExStyle and not WS_EX_CLIENTEDGE;
  {$ELSE}
  {$ENDIF}
end;

procedure TSearchPanelTextEditEh.CreateWnd;
begin
  inherited CreateWnd;
  Color := ApproximateColor(StyleServices.GetSystemColor(TWinControlCrack(Parent).Color),
    StyleServices.GetSystemColor(clWindow), 256 div 3 * 2);
end;

procedure TSearchPanelTextEditEh.DoEnter;
begin
  Color := StyleServices.GetSystemColor(clWindow);
  Font.Color := StyleServices.GetSystemColor(clWindowText);
  if IsEmptyState then
    SpecInternalSetText('');
  inherited DoEnter;
end;

procedure TSearchPanelTextEditEh.DoExit;
begin
  Color := ApproximateColor(TWinControlCrack(Parent).Color, clWindow, 256 div 3 * 2);
  if Text = ''
    then IsEmptyState := True
    else IsEmptyState := False;
  inherited DoExit;
end;

function TSearchPanelTextEditEh.GetBorderColor: TColor;
begin
  Result := SearchPanelControl.GetFindEditorBorderColor;
end;

procedure TSearchPanelTextEditEh.DrawNonClientBorder;
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  DC, OldDC: HDC;
  R, R1: TRect;
begin
  if True {Flat and (BorderStyle = bsSingle) and (Ctl3D = True} then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);

      begin
        R1 := R;
        OldDC := Canvas.Handle;
        Canvas.Handle := DC;
        Canvas.Brush.Color := GetBorderColor;
        Canvas.FrameRect(R1);
        Canvas.Handle := OldDC;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;
{$ENDIF} 

procedure TSearchPanelTextEditEh.EditButtonDownDefaultAction(
  EditButton: TEditButtonEh; EditButtonControl: TEditButtonControlEh;
  TopButton: Boolean; var AutoRepeat, Handled: Boolean);
begin
  if (not MRUList.DroppedDown) then
    MRUList.DropDown
  else
    MRUList.CloseUp(False);
end;

procedure TSearchPanelTextEditEh.SetIsEmptyState(const Value: Boolean);
begin
  FIsEmptyState := Value;
  if FIsEmptyState then
  begin
  end;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
procedure TSearchPanelTextEditEh.WMNCPaint(var Message: TWMNCPaint);
begin
  DrawNonClientBorder;
end;
{$ENDIF} 

procedure TSearchPanelTextEditEh.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
end;

procedure TSearchPanelTextEditEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
end;

procedure TSearchPanelTextEditEh.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if CanFocus then
    SearchPanelControl.MasterControlSearchEditMode := True;
  inherited;
end;

procedure TSearchPanelTextEditEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TSearchPanelTextEditEh.KeyPress(var Key: Char);
begin
  SearchPanelControl.FindEditorKeyPress(Key);

  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TSearchPanelTextEditEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SearchPanelControl.FindEditorKeyDown(Key, Shift);
  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TSearchPanelTextEditEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  SearchPanelControl.FindEditorKeyUp(Key, Shift);
  if Key <> 0 then
    inherited KeyUp(Key, Shift);
end;

procedure TSearchPanelTextEditEh.SpecInternalSetText(const AText: String);
begin
  FInternalChanging := True;
  try
    Text := AText;
    Modified := False;
    UpdateModified;
  finally
    FInternalChanging := False;
  end;
end;

procedure TSearchPanelTextEditEh.CalcEditRect(var ARect: TRect);
begin
  inherited CalcEditRect(ARect);
  Inc(ARect.Left, 2);
  Dec(ARect.Right, 2);
  if not MiniHeight then
  begin
    Inc(ARect.Top);
    Dec(ARect.Bottom);
  end;
end;

procedure TSearchPanelTextEditEh.CancelSearchEditorMode;
begin
  SearchPanelControl.CancelSearchEditorMode;
end;

procedure TSearchPanelTextEditEh.CancelFilter;
begin
  SpecInternalSetText('');
  Modified := False;
  TextAppliedAsFilter := True;
  UpdateModified;
end;

procedure TSearchPanelTextEditEh.ApplySearchFilter;
begin
  SearchPanelControl.ApplySearchFilter;
end;

procedure TSearchPanelTextEditEh.ClearSearchFilter;
begin
  SearchPanelControl.ClearSearchFilter;
end;

procedure TSearchPanelTextEditEh.UpdateModified;
begin
  if Assigned(OnUpdateModified) then
    OnUpdateModified(Self);
end;

function TSearchPanelTextEditEh.CalcAutoHeight: Integer;
var
  I: Integer;
begin
  I := GetFontTextHeight(Canvas, Font, False);
  I := I + 2; 
  I := I + 1; 
  {$IFDEF FPC}
  I := I + 1; 
  {$ELSE}
  {$ENDIF}
  if not MiniHeight then
    I := I + 2; 

  Result := I;
end;

procedure TSearchPanelTextEditEh.CheckAddTextToList;
begin
end;

procedure TSearchPanelTextEditEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_TAB) then
    Message.Result := 1;
end;

procedure TSearchPanelTextEditEh.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  case Message.Msg of
    WM_CHAR:
{$IFDEF CIL}
{$ELSE}
{$ENDIF}
      begin
      end;
  end;
end;

function TSearchPanelTextEditEh.GetSearchPanelControl: TSearchPanelControlEh;
begin
  Result := TSearchPanelControlEh(Owner);
end;

procedure TSearchPanelTextEditEh.SetTextAppliedAsFilter(const Value: Boolean);
begin
  FTextAppliedAsFilter := Value;
end;

procedure TSearchPanelTextEditEh.CheckAddTextToMRUList;
begin
  if MRUList.AutoAdd and
     MRUList.Active and
     Focused
  then
    MRUList.Add(Text);
end;

procedure TSearchPanelTextEditEh.MRUListActiveChanged(Sender: TObject);
begin
  FMRUEditButton.Visible := MRUList.Active;
end;

{ TSearchPanelControlEh }

constructor TSearchPanelControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  InitItems;
  DoubleBuffered := True;
  Caption := '';
end;

destructor TSearchPanelControlEh.Destroy;
begin
  inherited Destroy;
end;

procedure TSearchPanelControlEh.BtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AcquireMasterControlFocus;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end;
  if Sender = FFindButtons[gnfbOptionsEh] then
  begin
    OptionsButtonMouseDown(Sender, Button, Shift, X, Y);
  end;
end;

procedure TSearchPanelControlEh.OptionsButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DropdownMenu: TPopupMenu;
  P: TPoint;
begin
  if Button <> mbLeft then Exit;
  BuildOptionsPopupMenu(DropdownMenu);
  if (DropdownMenu <> nil) and (DropdownMenu.Items.Count > 0) then
  begin
    TControl(Sender).Invalidate;
    P := TControl(Sender).ClientToScreen(Point(0, TControl(Sender).Height));
    if UseRightToLeftAlignment then
      P.X := P.X + TControl(Sender).Width;
    DropdownMenu.Popup(p.X, p.y);
    KillMouseUp(TControl(Sender));
    TControl(Sender).Perform(WM_LBUTTONUP, 0, 0);
  end;
end;

procedure TSearchPanelControlEh.BuildOptionsPopupMenu(var PopupMenu: TPopupMenu);
var
  i: Integer;
begin
  if SearchPanelOptionsPopupMenu = nil then
    SearchPanelOptionsPopupMenu := TPopupMenuEh.Create(Screen);

  {$IFDEF FPC}
  {$ELSE}
  SearchPanelOptionsPopupMenu.AutoHotkeys := maManual;
  {$ENDIF}

  for i := SearchPanelOptionsPopupMenu.Items.Count-1 downto 0 do
    SearchPanelOptionsPopupMenu.Items.Delete(i);
  PopupMenu := SearchPanelOptionsPopupMenu;
  if FTestMenuItem = nil then
    FTestMenuItem := TMenuItemEh.Create(Self);

  FTestMenuItem.Caption := 'Test';
  FTestMenuItem.OnClick := nil; 
  FTestMenuItem.Enabled := True;
  PopupMenu.Items.Add(FTestMenuItem);
end;

procedure TSearchPanelControlEh.AcquireMasterControlFocus;
begin
  raise Exception.Create('Method TSearchPanelControlEh.AcquireMasterControlFocus is not implemented.');
end;

function TSearchPanelControlEh.CalcAutoHeight: Integer;
begin
  Result := FindEditor.CalcAutoHeight + 6 + 1;
end;

function TSearchPanelControlEh.CalcAutoWidthForHeight(ANewHeight: Integer): Integer;
begin
  Result := 120 + ANewHeight + ANewHeight + ANewHeight + ANewHeight;
end;

procedure TSearchPanelControlEh.ClickHandler(Sender: TObject);
begin
  if Sender is TNavFindButtonEh then
    FindBtnClick(TNavFindButtonEh(Sender).Index);
end;

procedure TSearchPanelControlEh.CreateWnd;
begin
  inherited CreateWnd;
end;

procedure TSearchPanelControlEh.DrawNonClientBorder;
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  DC, OldDC: HDC;
  R, R1: TRect;
begin
  if not CustomStyleActive {Flat and (BorderStyle = bsSingle) and (Ctl3D = True} then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      begin
        R1 := R;
        OldDC := Canvas.Handle;
        Canvas.Handle := DC;
        Canvas.Brush.Color := $00C5DEE2;
        Canvas.FrameRect(R1);
        Canvas.Handle := OldDC;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;
{$ENDIF} 

procedure TSearchPanelControlEh.FindBtnClick(Index: TDBGridEhNavigatorFindBtn);
begin
  if CanPerformSearchActionInMasterControl then
  begin
    if MasterControlSearchEditMode = False then
      MasterControlSearchEditMode := True;
    case Index of
      gnfbCancelSearchFilterEh:
        if not FFindEditor.TextAppliedAsFilter
          then FFindEditor.ApplySearchFilter
          else FFindEditor.CancelSearchEditorMode;
      gnfbFindNextEh:
        FindNext;
      gnfbFindPrevEh:
        FindPrev;
      gnfbOptionsEh: ;
    end;
  end;
end;

function TSearchPanelControlEh.CanPerformSearchActionInMasterControl: Boolean;
begin
  raise Exception.Create('Method TSearchPanelControlEh.AcquireMasterControlFocus is not implemented.');
  {$IFDEF FPC}
  Result := False;
  {$ENDIF}
end;

procedure TSearchPanelControlEh.SetGetMasterControlSearchEditMode(Value: Boolean);
begin
  raise Exception.Create('Method TSearchPanelControlEh.SetGetMasterControlSearchEditMode is not implemented.');
end;

function TSearchPanelControlEh.GetMasterControlSearchEditMode: Boolean;
begin
  raise Exception.Create('Method TSearchPanelControlEh.GetMasterControlSearchEditMode is not implemented.');
  {$IFDEF FPC}
  Result := False;
  {$ENDIF}
end;

procedure TSearchPanelControlEh.FindEditorUpdateModified(Sender: TObject);
begin
  if Parent = nil then Exit;
  if not FFindEditor.TextAppliedAsFilter then
  begin
    FFindButtons[gnfbCancelSearchFilterEh].ResourceImageItem := EhLibImageResources.SearchPanelFilterImageItem;
    FFindButtons[gnfbCancelSearchFilterEh].Enabled := True;
    FFindButtons[gnfbCancelSearchFilterEh].Hint := EhLibLanguageConsts.SearchPanelApplyFilterEh;
  end else
  begin
    FFindButtons[gnfbCancelSearchFilterEh].ResourceImageItem := EhLibImageResources.SearchPanelCancelSearchImageItem;
    FFindButtons[gnfbCancelSearchFilterEh].Enabled := CancelSearchFilterEnable;
    {$IFDEF FPC}
    {$ELSE}
    FFindEditor.ClearUndo;
    {$ENDIF}
    FFindButtons[gnfbCancelSearchFilterEh].Hint := EhLibLanguageConsts.SearchPanelCancelFilterEh;
  end;

  FFindButtons[gnfbFindNextEh].Visible := True;
  FFindButtons[gnfbFindNextEh].Enabled := (FindEditor.Text <> '');
  FFindButtons[gnfbFindPrevEh].Visible := True;
  FFindButtons[gnfbFindPrevEh].Enabled := (FindEditor.Text <> '');
end;

function TSearchPanelControlEh.CancelSearchFilterEnable: Boolean;
begin
  raise Exception.Create('Method TSearchPanelControlEh.CancelSearchFilterEnable is not implemented.');
  {$IFDEF FPC}
  Result := False;
  {$ENDIF}
end;

procedure TSearchPanelControlEh.FindNext;
begin
  MasterControlFindNext;
  FFindEditor.Modified := False;
  {$IFDEF FPC}
  {$ELSE}
  FFindEditor.ClearUndo;
  {$ENDIF}
end;

procedure TSearchPanelControlEh.MasterControlFindNext;
begin
  raise Exception.Create('Method TSearchPanelControlEh.MasterControlFindNext is not implemented.');
end;

procedure TSearchPanelControlEh.FindPrev;
begin
  MasterControlFindPrev;
  FFindEditor.Modified := False;
  {$IFDEF FPC}
  {$ELSE}
  FFindEditor.ClearUndo;
  {$ENDIF}
end;

procedure TSearchPanelControlEh.MasterControlFindPrev;
begin
  raise Exception.Create('Method TSearchPanelControlEh.MasterControlFindPrev is not implemented.');
end;

procedure TSearchPanelControlEh.RestartFind;
begin
  MasterControlRestartFind;
end;

procedure TSearchPanelControlEh.MasterControlRestartFind;
begin
end;

function TSearchPanelControlEh.GetSearchingText: String;
begin
  Result := FFindEditor.Text;
end;

function TSearchPanelControlEh.CreateSearchPanelTextEdit: TSearchPanelTextEditEh;
begin
  Result := TSearchPanelTextEditEh.Create(Self);
end;

procedure TSearchPanelControlEh.InitItems;
var
  FI: TDBGridEhNavigatorFindBtn;
  FindBtn: TNavFindButtonEh;
  X: Integer;
  NavigatorFindImageItems: array[TDBGridEhNavigatorFindBtn] of TResourceImageItemEh;
begin
  MinBtnSize := Point(10, 10);
  X := 0;

  FFindEditor := CreateSearchPanelTextEdit;
  FFindEditor.Flat := True;
  FFindEditor.SetBounds(X, 1, 100, MinBtnSize.Y-1);
  {$IFDEF FPC}
  {$ELSE}
  FFindEditor.BevelEdges := [beLeft, beTop, beRight, beBottom];
  FFindEditor.BevelInner := bvNone;
  FFindEditor.BevelKind := bkFlat;
  FFindEditor.BorderStyle := bsNone;
  FFindEditor.Ctl3D := True;
  {$ENDIF}
  FFindEditor.TabStop := False;
  FFindEditor.Parent := Self;
  FFindEditor.AutoSize := False;
  FFindEditor.IsEmptyState := True;
  FFindEditor.OnUpdateModified := FindEditorUpdateModified;
  FFindEditor.EditButton.Visible := False;

  X := X + 85;

  NavigatorFindImageItems[gnfbSearchInfoBoxEh] := nil;
  NavigatorFindImageItems[gnfbCancelSearchFilterEh] := EhLibImageResources.SearchPanelFilterImageItem;
  NavigatorFindImageItems[gnfbFindNextEh] := EhLibImageResources.SearchPanelFindNextImageItem;
  NavigatorFindImageItems[gnfbFindPrevEh] := EhLibImageResources.SearchPanelFindPriorImageItem;
  NavigatorFindImageItems[gnfbOptionsEh] := EhLibImageResources.SearchPanelMenuImageItem;

  for FI := Low(FFindButtons) to High(FFindButtons) do
  begin
    FindBtn := TNavFindButtonEh.Create(Self);
    FindBtn.Flat := True;
    FindBtn.Index := FI;
    FindBtn.ResourceImageItem := NavigatorFindImageItems[FI];

    FindBtn.Enabled := True;
    FindBtn.SetBounds(X, 0, MinBtnSize.X, MinBtnSize.Y);
    FindBtn.Enabled := False;
    FindBtn.Enabled := True; 
    FindBtn.OnClick := ClickHandler;
    FindBtn.OnPostMouseDown := BtnMouseDown;
    FindBtn.Parent := Self;
    FFindButtons[FI] := FindBtn;
    X := X + MinBtnSize.X;
  end;

  UpdateLanguageVars;
end;

function TSearchPanelControlEh.IsSearchingState: Boolean;
begin
  if FFindEditor.Focused and (FFindEditor.Text <> '')
    then Result := True
    else Result := False;
end;

procedure TSearchPanelControlEh.Paint;
var
  ARect, FillRect: TRect;
  FromColor, ToColor: TColor;
  HighlightColor: TColor;
begin
  GetPaintColors(FromColor, ToColor, HighlightColor);
  ARect := GetClientRect;
  if Location = splGridTopEh then
    Dec(ARect.Bottom);
  FillRect := ARect;
  if not ThemesEnabled then
    FromColor := ToColor;
  FillGradientEh(Canvas, FillRect, FromColor, ToColor);

  if Location = splGridTopEh then
  begin
    Canvas.Pen.Color := GetBorderColor;
    Canvas.Polyline([Point(ARect.Left, ARect.Bottom),
                     Point(ARect.Right-1, ARect.Bottom),
                     Point(ARect.Right-1, ARect.Top-1)
                     ]);
  end;
end;

procedure TSearchPanelControlEh.MasterControlProcessFindEditorKeyDown(
  var Key: Word; Shift: TShiftState);
begin
  raise Exception.Create('Method TSearchPanelControlEh.MasterControlProcessFindEditorKeyDown is not implemented.');
end;

procedure TSearchPanelControlEh.MasterControlProcessFindEditorKeyUp(
  var Key: Word; Shift: TShiftState);
begin

end;

procedure TSearchPanelControlEh.MasterControlProcessFindEditorKeyPress(var Key: Char);
begin
  raise Exception.Create('Method TSearchPanelControlEh.ProcessMasterControlSearchPanelFindEditorKeyPress is not implemented.');
end;

function TSearchPanelControlEh.GetFindEditorBorderColor: TColor;
begin
  Result := cl3DDkShadow;
end;

function TSearchPanelControlEh.GetBorderColor: TColor;
begin
  Result := cl3DDkShadow;
end;

procedure TSearchPanelControlEh.GetPaintColors(var FromColor, ToColor, HighlightColor: TColor);
begin
  raise Exception.Create('Method TSearchPanelControlEh.GetPaintColors is not implemented.');
end;

procedure TSearchPanelControlEh.RealignControls;
var
  NewW, NewH: Integer;
begin
  if not HandleAllocated then Exit;
  NewW := Width;
  NewH := Height;
  SetSize(NewW, NewH);
end;

procedure TSearchPanelControlEh.ResetVisibleControls;
var
  W, H: Integer;
begin
  if FFindButtons[gnfbCancelSearchFilterEh].Visible <> MasterControlFilterEnabled then
  begin
    FFindButtons[gnfbCancelSearchFilterEh].Visible := MasterControlFilterEnabled;
    W := Width;
    H := Height;
    SetSize(W, H);
  end;

  FFindButtons[gnfbOptionsEh].Visible := IsOptionsButtonVisible;
  FFindButtons[gnfbCancelSearchFilterEh].Hint := EhLibLanguageConsts.SearchPanelApplyFilterEh;
  FFindButtons[gnfbFindNextEh].Hint := EhLibLanguageConsts.SearchPanelFindNextEh;
  FFindButtons[gnfbFindPrevEh].Hint := EhLibLanguageConsts.SearchPanelFindPrevEh;
  FFindButtons[gnfbOptionsEh].Hint := EhLibLanguageConsts.SearchPanelOptionsEh;

  RealignControls;
end;

procedure TSearchPanelControlEh.MasterControlApplySearchFilter;
begin
  raise Exception.Create('Method TSearchPanelControlEh.MasterControlApplySearchFilter is not implemented.');
end;

procedure TSearchPanelControlEh.MasterControlCancelSearchEditorMode;
begin
  raise Exception.Create('Method TSearchPanelControlEh.MasterControlCancelSearchEditorMode is not implemented.');
end;

function TSearchPanelControlEh.MasterControlFilterEnabled: Boolean;
begin
  Result := False;
end;

procedure TSearchPanelControlEh.SetLocation(const Value: TSearchPanelLocationEh);
begin
  if FLocation <> Value then
  begin
    FLocation := Value;
    FindEditor.MiniHeight := (FLocation = splHorzScrollBarExtraPanelEh);
  end;
end;

procedure TSearchPanelControlEh.Resize;
begin
  inherited Resize;
  RealignControls;
end;

procedure TSearchPanelControlEh.SetSize(var W, H: Integer);
var
  X: Integer;
  FI: TDBGridEhNavigatorFindBtn;
  EditorHeight, EditorTop: Integer;
  EditorBound: TRect;
  ThisButtonWidth: Integer;
  SearchInfoBoxWidth: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if not HandleAllocated then Exit;

  ButtonWidth := H-1;

  X := ClientWidth-3;
  if UseRightToLeftAlignment then
    X := 3;

  SearchInfoBoxWidth := CalcSearchInfoBoxWidth;

  for FI := High(FFindButtons) downto Low(FFindButtons) do
  begin
    if FFindButtons[FI].Visible then
    begin
      if FI = gnfbSearchInfoBoxEh
        then ThisButtonWidth := SearchInfoBoxWidth
        else ThisButtonWidth := ButtonWidth;
      if UseRightToLeftAlignment then
        Inc(X, ThisButtonWidth);
      FFindButtons[FI].SetBounds(X-ThisButtonWidth, 0, ThisButtonWidth, ButtonWidth);
      if not UseRightToLeftAlignment then
        Dec(X, ThisButtonWidth);
    end else
      FFindButtons[FI].SetBounds(0, 0, 0, 0);
  end;

  if Location = splGridTopEh then
  begin
    EditorHeight := H-7;
    EditorTop := 3;
  end else
  begin
    EditorHeight := FFindEditor.CalcAutoHeight;
    if EditorHeight < H then
      EditorTop := (EditorHeight + H) div 2 - EditorHeight
    else
      EditorTop := 0;
  end;

  if UseRightToLeftAlignment then
  begin
    if Location = splGridTopEh then
      EditorBound := Rect(X+1, 3, ClientWidth-X-5, H-7)
    else
      EditorBound := Rect(X, EditorTop, ClientWidth-X-4, EditorHeight);
  end else
  begin
    if Location = splGridTopEh then
      EditorBound := Rect(3, EditorTop, X-4, EditorHeight)
    else
    begin
      if CustomStyleActive then
        Inc(EditorHeight);
      EditorBound := Rect(3, EditorTop, X-4, EditorHeight);
    end;
  end;

  if EditorBound.Right < 0 then EditorBound.Right := 0;
  if EditorBound.Bottom < 0 then EditorBound.Bottom := 0;

  FFindEditor.SetBounds(EditorBound.Left, EditorBound.Top, EditorBound.Right, EditorBound.Bottom);
end;

function TSearchPanelControlEh.CalcSearchInfoBoxWidth: Integer;
begin
  Result := 0;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
procedure TSearchPanelControlEh.WMNCPaint(var Message: TWMNCPaint);
begin
end;
{$ENDIF}

procedure TSearchPanelControlEh.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := ClientWidth;
  H := ClientHeight;
  SetSize(W, H);
end;

function TSearchPanelControlEh.FilterOnTyping: Boolean;
begin
  raise Exception.Create('Method TSearchPanelControlEh.FilterOnTyping is not implemented ');
  {$IFDEF FPC}
  Result := False;
  {$ENDIF}
end;

function TSearchPanelControlEh.FilterEnabled: Boolean;
begin
  raise Exception.Create('Method TSearchPanelControlEh.FilterEnabled is not implemented ');
  {$IFDEF FPC}
  Result := False;
  {$ENDIF}
end;

procedure TSearchPanelControlEh.ClearSearchFilter;
begin

end;

procedure TSearchPanelControlEh.ApplySearchFilter;
begin
  MasterControlApplySearchFilter;
  FindEditor.Modified := False;
  FindEditor.TextAppliedAsFilter := True;
  FindEditor.UpdateModified;
  FindEditor.CheckAddTextToMRUList;
end;

procedure TSearchPanelControlEh.FindEditorUserChanged;
begin

end;

function TSearchPanelControlEh.IsOptionsButtonVisible: Boolean;
begin
  Result := False;
end;

procedure TSearchPanelControlEh.FindEditorKeyPress(var Key: Char);
begin
  MasterControlProcessFindEditorKeyPress(Key);
  if (Key = #27) and not FindEditor.ListVisible then
  begin
  end else if (Key = #13) and not FindEditor.ListVisible then
  begin
  end;
end;

procedure TSearchPanelControlEh.FindEditorKeyDown(var Key: Word; Shift: TShiftState);
begin
  MasterControlProcessFindEditorKeyDown(Key, Shift);
  if (Shift = []) and (Key = VK_DOWN) then
  begin
    FindNext;
    Key := 0;
  end else if (Shift = []) and (Key = VK_UP) then
  begin
    FindPrev;
    Key := 0;
  end else if (Shift = []) and (Key = VK_TAB) then
  begin
    MasterControlSearchEditMode := False;
    Key := 0;
  end else if (Shift = []) and (Key = VK_RETURN) then
  begin
    if FindEditor.Text = '' then
      CancelSearchEditorMode
    else if MasterControlFilterEnabled then
      ApplySearchFilter
    else
    begin
      if GetKeyState(VK_SHIFT) < 0
        then FindPrev
        else FindNext;
    end;
    Key := 0;
  end else if (Shift = []) and (Key = VK_ESCAPE) then
  begin
    CancelSearchEditorMode;
    Key := 0;
  end;
end;

procedure TSearchPanelControlEh.FindEditorKeyUp(var Key: Word; Shift: TShiftState);
begin
  MasterControlProcessFindEditorKeyUp(Key, Shift);
end;

procedure TSearchPanelControlEh.CancelSearchEditorMode;
begin
  FindEditor.SpecInternalSetText('');
  MasterControlCancelSearchEditorMode;
  FindEditor.Modified := False;
  FindEditor.TextAppliedAsFilter := False;
  FindEditor.UpdateModified;
end;

function TSearchPanelControlEh.GetSearchInfoBoxText: String;
begin
  Result := '';
end;

procedure TSearchPanelControlEh.UpdateLanguageVars;
begin
  ResetVisibleControls;
  FFindEditor.EmptyDataInfo.Text := EhLibLanguageConsts.SearchPanelEditorPromptText;
end;

function TSearchPanelControlEh.GetFindButtons(FindBtn: TDBGridEhNavigatorFindBtn): TNavFindButtonEh;
begin
  Result := FFindButtons[FindBtn];
end;

initialization
  InitRes;
finalization
  FinRes;
end.
