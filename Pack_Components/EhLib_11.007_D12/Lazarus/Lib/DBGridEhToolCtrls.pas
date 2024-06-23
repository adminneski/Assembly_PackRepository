{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{          Tool Controls for DBGridEh component         }
{                                                       }
{   Copyright (c) 2011-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhToolCtrls;

interface

uses
  Messages,
  {$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, SqlTimSt, Windows, UxTheme,
  {$ENDIF}
  SysUtils, Classes, Controls, Forms, StdCtrls, Contnrs,
  Variants, Types, Themes,
  GridsEh, GridToolCtrlsEh, DBGridEhGrouping, DBCtrlsEh, ToolCtrlsEh,
  DBAxisGridsEh, SearchPanelsEh, EhLibImageReses, ButtonsEh,
  FmtBcd, Graphics, DBCtrls, ExtCtrls, Db, Buttons, ImgList, Menus;

type
  TDBGridMovePointEh = class;

  TDBGridEhRes = class(TDataModule)
    IMList10: TImageList;
    IMList10D: TImageList;
    IMList12_D: TImageList;
    IMList12: TImageList;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    IMList10Bmp: TImageList;
    IMList10DBmp: TImageList;
    procedure Copy1Click(Sender: TObject);
  private
  public
    function GetIMList10: TImageList;
    function GetIMList10Disabled: TImageList;
  end;

  TDBGridEhNavigatorPanel = class;
  TNavButtonEh = class;
  TNavDataLinkEh = class;
  TNavFindButtonEh = class;
  TDBGridSearchPanelControlEh = class;

  TSelectionInfoPanelDataItemEh = record
    Text: String;
    Start: Integer;
    Finish: Integer;
  end;

  { TDBGridEhScrollBarPanelControl }

  TDBGridEhScrollBarPanelControl = class(TGridScrollBarPanelControlEh)
  private
    FExtraPanel: TDBGridEhNavigatorPanel;
    function GetOnScroll: TScrollEvent;
    procedure SetOnScroll(const Value: TScrollEvent);

  protected
    function ScrollBatCode: Integer;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Resize; override;
    procedure CreateHandle; override;
    procedure OnScrollEvent(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);

  public
    constructor Create(AOwner: TComponent; AKind: TScrollBarKind); reintroduce;
    destructor Destroy; override;

    function MaxSizeForExtraPanel: Integer;

    procedure Invalidate; override;
    procedure GridSelectionChanged;
    procedure DataSetChanged; virtual;
    procedure SetParams(APosition, AMin, AMax, APageSize: Integer);

    property OnScroll: TScrollEvent read GetOnScroll write SetOnScroll;
    property ExtraPanel: TDBGridEhNavigatorPanel read FExtraPanel;
  end;

  TDBGridSearchPanelTextEditEh = class(TSearchPanelTextEditEh)
  end;

{ TDBGridEhNavigatorPanel }

  TGridSBItemEh = (gsbiRecordsInfoEh, gsbiNavigator, {gsbiFindEditorEh, }gsbiSelAggregationInfoEh);
  TGridSBItemsEh = set of TGridSBItemEh;

  TNavigateBtnEh = (nbFirstEh, nbPriorEh, nbNextEh, nbLastEh,
                  nbInsertEh, nbDeleteEh, nbEditEh, nbPostEh, nbCancelEh, nbRefreshEh);
  TNavButtonSetEh = set of TNavigateBtnEh;


  TNavClickEh = procedure (Sender: TObject; Button: TNavigateBtnEh) of object;

  TDBGridEhNavigatorPanel = class (TCustomControl)
  private
    ButtonWidth: Integer;
    FBeforeAction: TNavClickEh;
    FBorderColor: TColor;
    FDataLink: TNavDataLinkEh;
    FDefHints: TStrings;
    FDisabledImages: TCustomImageList;
    FFlat: Boolean;
    FHints: TStrings;
    FImages: TCustomImageList;
    FocusedButton: TNavigateBtnEh;
    FOnNavClick: TNavClickEh;
    FSearchPanelControl: TDBGridSearchPanelControlEh;
    FSelectionInfoPanelText: String;
    FVisibleButtons: TNavButtonSetEh;
    FVisibleItems: TGridSBItemsEh;
    MinBtnSize: TPoint;

    function GetCancelImageItem: TResourceImageItemEh;
    function GetDataSource: TDataSource;
    function GetDeleteImageItem: TResourceImageItemEh;
    function GetEditImageItem: TResourceImageItemEh;
    function GetFirstImageItem: TResourceImageItemEh;
    function GetHints: TStrings;
    function GetInsertImageItem: TResourceImageItemEh;
    function GetLastImageItem: TResourceImageItemEh;
    function GetNextImageItem: TResourceImageItemEh;
    function GetPostImageItem: TResourceImageItemEh;
    function GetPriorImageItem: TResourceImageItemEh;
    function GetRefreshImageItem: TResourceImageItemEh;
    function GetVisible: Boolean;
    procedure SetCancelImageItem(const Value: TResourceImageItemEh);
    procedure SetDeleteImageItem(const Value: TResourceImageItemEh);
    procedure SetEditImageItem(const Value: TResourceImageItemEh);
    procedure SetFirstImageItem(const Value: TResourceImageItemEh);
    procedure SetInsertImageItem(const Value: TResourceImageItemEh);
    procedure SetLastImageItem(const Value: TResourceImageItemEh);
    procedure SetNextImageItem(const Value: TResourceImageItemEh);
    procedure SetPostImageItem(const Value: TResourceImageItemEh);
    procedure SetPriorImageItem(const Value: TResourceImageItemEh);
    procedure SetRefreshImageItem(const Value: TResourceImageItemEh);

    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClickHandler(Sender: TObject; var AutoRepeat: Boolean; var Handled: Boolean);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure HintsChanged(Sender: TObject);
    procedure InitHints;
    procedure InitItems;
    procedure SetBorderColor(const Value: TColor);
    procedure SetDataSource(Value: TDataSource);
    procedure SetDisabledImages(const Value: TCustomImageList);
    procedure SetFlat(Value: Boolean);
    procedure SetHints(Value: TStrings);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetSearchPanelControl(const Value: TDBGridSearchPanelControlEh);
    procedure SetSize(var W: Integer; var H: Integer);
    procedure SetVisible(const Value: Boolean); {$IFDEF FPC} reintroduce; {$ENDIF}
    procedure SetVisibleButtons(Value: TNavButtonSetEh);
    procedure SetVisibleItems(const Value: TGridSBItemsEh);

    {$IFDEF FPC_CROSSP}
    {$ELSE}
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    {$ENDIF}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;

  protected
    FindEditDivider: TNavButtonEh;
    NavButtons: array[TNavigateBtnEh] of TNavButtonEh;
    NavButtonsDivider: TNavButtonEh;
    RecordsInfoPanel: TNavButtonEh;
    SelectionInfoDivider: TNavButtonEh;
    SelectionInfoPanel: TNavButtonEh;
    SelectionInfoPanelDataEh: array of TSelectionInfoPanelDataItemEh;

    function CalcWidthForRecordsInfoPanel: Integer;
    function CalcWidthSelectionInfoPanel: Integer;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;

    procedure ActiveChanged;
    procedure CalcMinSize(var W, H: Integer);
    procedure CreateWnd; override;
    procedure DataChanged;
    procedure DrawNonClientBorder;
    procedure EditingChanged;
    procedure GridSelectionChanged;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure PaintDivider(Sender: TObject);
    procedure PaintRecordsInfo(Sender: TObject);
    procedure ResetVisibleControls;
    procedure Resize; override;
    procedure SelectionInfoPanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CheckConfirmDelete: Boolean;
    function DataSetActive: Boolean;
    function DividerWidth: Integer; virtual;
    function GetSelectionInfoPanelText: String;
    function OptimalWidth: Integer;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure GetGridAggrInfo(var ResultArr: TAggrResultArr);
    procedure NavBtnClick(Index: TNavigateBtnEh); virtual;
    procedure ResetWidth;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property BeforeAction: TNavClickEh read FBeforeAction write FBeforeAction;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property Flat: Boolean read FFlat write SetFlat default False;
    property Hints: TStrings read GetHints write SetHints;
    property Images: TCustomImageList read FImages write SetImages;
    property SearchPanelControl: TDBGridSearchPanelControlEh read FSearchPanelControl write SetSearchPanelControl;
    property VisibleButtons: TNavButtonSetEh read FVisibleButtons write SetVisibleButtons default [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh, nbInsertEh, nbDeleteEh, nbEditEh, nbPostEh, nbCancelEh, nbRefreshEh];
    property VisibleItems: TGridSBItemsEh read FVisibleItems write SetVisibleItems default [gsbiRecordsInfoEh, gsbiNavigator, gsbiSelAggregationInfoEh];
    property Visible: Boolean read GetVisible write SetVisible;

    property FirstImageItem: TResourceImageItemEh read GetFirstImageItem write SetFirstImageItem;
    property PriorImageItem: TResourceImageItemEh read GetPriorImageItem write SetPriorImageItem;
    property NextImageItem: TResourceImageItemEh read GetNextImageItem write SetNextImageItem;
    property LastImageItem: TResourceImageItemEh read GetLastImageItem write SetLastImageItem;
    property InsertImageItem: TResourceImageItemEh read GetInsertImageItem write SetInsertImageItem;
    property DeleteImageItem: TResourceImageItemEh read GetDeleteImageItem write SetDeleteImageItem;
    property EditImageItem: TResourceImageItemEh read GetEditImageItem write SetEditImageItem;
    property PostImageItem: TResourceImageItemEh read GetPostImageItem write SetPostImageItem;
    property CancelImageItem: TResourceImageItemEh read GetCancelImageItem write SetCancelImageItem;
    property RefreshImageItem: TResourceImageItemEh read GetRefreshImageItem write SetRefreshImageItem;
  end;

{ TNavButtonEh }

{$IFDEF FPC}
  TNavButtonStyle = set of (nsAllowTimer, nsFocusRect);
{$ENDIF}

  TNavButtonEh = class(TCustomSpeedButtonEh)
  private
    FDisabledImages: TCustomImageList;
    FImageIndex: Integer;
    FImages: TCustomImageList;
    FIndex: TNavigateBtnEh;
    FNavStyle: TNavButtonStyle;

    procedure SetDisabledImages(const Value: TCustomImageList);
    procedure SetImageIndex(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetNavStyle(const Value: TNavButtonStyle);

  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    {$IFDEF FPC}
    procedure PaintBackground(out PaintRect: TRect; out PressOffset: TPoint; out ThemeDetails: TThemedElementDetails); override;
    {$ELSE}
    procedure PaintBackground(out PaintRect: TRect; out PressOffset: TPoint; out ThemeDetails: TThemedElementDetails); override;
    {$ENDIF}
    procedure PaintForeground(PaintRect: TRect; PressOffset: TPoint; ThemeDetails: TThemedElementDetails); override;

    procedure Click; override;

    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Images: TCustomImageList read FImages write SetImages;
    property Index: TNavigateBtnEh read FIndex write FIndex;
    property NavStyle: TNavButtonStyle read FNavStyle write SetNavStyle;
  end;

  TNavFindButtonEh = class(TNavButtonEh)
  private
    FIndex: TDBGridEhNavigatorFindBtn;
  public
    property Index: TDBGridEhNavigatorFindBtn read FIndex write FIndex;
  end;

{ TNavDataLink }

  TNavDataLinkEh = class(TDataLink)
  private
    FNavigator: TDBGridEhNavigatorPanel;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure EditingChanged; override;
  public
    constructor Create(ANav: TDBGridEhNavigatorPanel);
    destructor Destroy; override;
  end;

{ TDBGridSearchPanelControlEh }

  TDBGridSearchPanelControlEh = class(TSearchPanelControlEh)
  private
    FoundCells: Integer;
    FSearchResultThread: TThread;
    FSearchResultFinished: Boolean;
  protected
    function CalcSearchInfoBoxWidth: Integer; override;
    function CancelSearchFilterEnable: Boolean; override;
    function CreateSearchPanelTextEdit: TSearchPanelTextEditEh; override;
    function GetMasterControlSearchEditMode: Boolean; override;
    function GetSearchInfoBoxText: String; override;
    function IsOptionsButtonVisible: Boolean; override;
    function MasterControlFilterEnabled: Boolean; override;

    procedure AcquireMasterControlFocus; override;
    procedure BuildOptionsPopupMenu(var PopupMenu: TPopupMenu); override;
    procedure MasterControlApplySearchFilter; override;
    procedure MasterControlCancelSearchEditorMode; override;
    procedure MasterControlFindNext; override;
    procedure MasterControlFindPrev; override;
    procedure MasterControlProcessFindEditorKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MasterControlProcessFindEditorKeyPress(var Key: Char); override;
    procedure MasterControlProcessFindEditorKeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MasterControlRestartFind; override;

    procedure MenuSearchScopesClick(Sender: TObject); virtual;
    procedure SearchResultThreadDone(Sender: TObject); virtual;
    procedure SearchResultThreadUpdateHitCount(Sender: TObject); virtual;
    procedure SetGetMasterControlSearchEditMode(Value: Boolean); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CanPerformSearchActionInMasterControl: Boolean; override;
    function FilterEnabled: Boolean; override;
    function FilterOnTyping: Boolean; override;
    function GetBorderColor: TColor; override;
    function GetFindEditorBorderColor: TColor; override;
    function GetHitCountAt(Row, Col: Integer): Integer; virtual;

    procedure ClearSearchFilter; override;
    procedure FindEditorUserChanged; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure UpdateFoundInfo;
    procedure UpdateFoundInfoInThread;
    procedure UpdateFoundInfoNoThread;

    procedure GetPaintColors(var FromColor, ToColor, HighlightColor: TColor); override;

  end;

{ TSearchResultThread }

  TSearchResultThread = class(TThread)
  private
    FColCount: Integer;
    FCurRow: Integer;
    FDoGetHitCountAtResult: Integer;
    FGrid: TComponent;
    FOnUpdateHitCount: TNotifyEvent;
    FRowCount: Integer;

  protected
    procedure Execute; override;

    procedure UpdateHitCount;
    procedure DoUpdateHitCount;

  public
    FoundCells: Integer;

    function GetHitCountAt(Row, Col: Integer): Integer;
    procedure DoGetHitCountAt;

    constructor Create(Grid: TComponent);

    property OnUpdateHitCount: TNotifyEvent read FOnUpdateHitCount write FOnUpdateHitCount;
  end;

{ TDBGridTitleDragWin }

 
  TDBGridTitleDragWin = class(TGridDragFormEh)
  private
    FDrawObject: TObject;

    FMovePoint: TDBGridMovePointEh;
    FMovePointPos: Integer;
    FMovePointSize: Integer;

    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure UpdateMovePointPos;
    procedure PaintSelectedColumnsMarker;
  protected
    procedure ChangeCanvasOrientation(RightToLeftOrientation: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;

    {$IFDEF FPC}
    {$ELSE}
    procedure Paint; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetTitleDragWin: TDBGridTitleDragWin;

    {$IFDEF FPC}
    procedure Paint; override;
    {$ELSE}
    {$ENDIF}
    procedure StartShow(drawObject: TObject; pos: TPoint; width, height, movePointPos, moveSize: Integer);
    procedure SetBounds(x, y, width, height, movePointPos, moveSize: Integer); reintroduce;

    procedure StartShowAnimated(ADrawObject: TObject; ASourceBounds: TRect; APos: TPoint; AWidth, AHeight, AMovePointPos, AMoveSize: Integer);
    procedure HideAnimated(ATargetBounds: TRect);

  end;

{ TDBGridMovePointEh }

  TDBGridMovePointEh = class(TGridMoveLineEh)
  private
    FLineColor: TColor;
    FForePaintColor: TColor;
    FBackPaintColor: TColor;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    {$IFDEF FPC}
    {$ELSE}
    procedure Paint; override;
    {$ENDIF}
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {$IFDEF FPC}
    procedure Paint; override;
    {$ELSE}
    {$ENDIF}

    property BackPaintColor: TColor read FBackPaintColor write FBackPaintColor;
    property ForePaintColor: TColor read FForePaintColor write FForePaintColor;
    property LineColor: TColor read FLineColor write FLineColor;
  end;

var
  DBGridEhRes: TDBGridEhRes;

implementation

{$R *.dfm}

uses Math, Dialogs,
{$IFDEF FPC}
  DBGridsEh,
{$ELSE}
  DBGridEh, VDBConsts,
{$ENDIF}
  DBGridEhImpExp,
  EhLibLangConsts, Clipbrd;


procedure InitRes;
begin
  DBGridEhRes := TDBGridEhRes.CreateNew(nil, -1);
  InitInheritedComponent(DBGridEhRes, TDataModule);
end;

procedure FinRes;
begin
  FreeAndNil(DBGridEhRes);
  FreeAndNil(DBGridEhIndicatorTitlePopupMenu);
end;

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh);
  TDBGridSearchPanelEhCrack = class(TDBGridSearchPanelEh);

{ TDBGridEhRes }

procedure TDBGridEhRes.Copy1Click(Sender: TObject);
begin
  Clipboard.AsText := Copy1.Hint;
end;

function TDBGridEhRes.GetIMList10: TImageList;
begin
  {$IFDEF FPC}
  Result := IMList10Bmp;
  {$ELSE}
  if ThemesEnabled
    then Result := IMList10
    else Result := IMList10Bmp;
  {$ENDIF}
end;

function TDBGridEhRes.GetIMList10Disabled: TImageList;
begin
  {$IFDEF FPC_CROSSP}
  Result := IMList10DBmp;
  {$ELSE}
  if ThemesEnabled
    then Result := IMList10D
    else Result := IMList10DBmp;
  {$ENDIF}
end;


{ TDBGridEhScrollBarPanelControl }

procedure TDBGridEhScrollBarPanelControl.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
end;

procedure TDBGridEhScrollBarPanelControl.Resize;
begin
  inherited Resize;
  if not HandleAllocated then Exit;
  if ExtraPanel.Visible then
  begin
    if UseRightToLeftAlignment then
    begin
      ExtraPanel.ResetWidth;
      ScrollBar.SetBounds(0, ScrollBar.Top, ClientWidth - ExtraPanel.Width, ScrollBar.Height);
      ExtraPanel.SetBounds(ScrollBar.Width, 0, ExtraPanel.Width, Height);
    end else
    begin
      ExtraPanel.SetBounds(0, 0, ExtraPanel.Width, Height);
      ExtraPanel.ResetWidth;
      ScrollBar.SetBounds(ExtraPanel.Width, ScrollBar.Top, ScrollBar.Width - ExtraPanel.Width, ScrollBar.Height);
    end;
  end;
end;

constructor TDBGridEhScrollBarPanelControl.Create(AOwner: TComponent; AKind: TScrollBarKind);
begin
  inherited Create(AOwner, AKind);

  FExtraPanel := TDBGridEhNavigatorPanel.Create(Self);
  FExtraPanel.Parent := Self;
  {$IFDEF FPC}
  {$ELSE}
  FExtraPanel.BevelEdges := [beTop, beRight];
  FExtraPanel.BevelInner := bvNone;
  FExtraPanel.BevelOuter := bvRaised;
  FExtraPanel.BevelKind := bkFlat;
  {$ENDIF}
  FExtraPanel.Visible := (AKind = sbHorizontal);
  FExtraPanel.Flat := True;
  FExtraPanel.Images := DBGridEhRes.GetIMList10;
  FExtraPanel.DisabledImages := DBGridEhRes.GetIMList10Disabled;
  FExtraPanel.ParentColor := True;

  FExtraPanel.DoubleBuffered := True;

  BevelOuter := bvNone;
  BevelInner := bvNone;
end;

procedure TDBGridEhScrollBarPanelControl.CreateHandle;
begin
  inherited CreateHandle;
end;

destructor TDBGridEhScrollBarPanelControl.Destroy;
begin
  inherited Destroy;
end;

function TDBGridEhScrollBarPanelControl.GetOnScroll: TScrollEvent;
begin
  Result := ScrollBar.OnScroll;
end;

procedure TDBGridEhScrollBarPanelControl.GridSelectionChanged;
begin
  if FKind = sbHorizontal then
    ExtraPanel.GridSelectionChanged;
  Resize;
end;

procedure TDBGridEhScrollBarPanelControl.DataSetChanged;
begin
  ExtraPanel.DataChanged;
end;

procedure TDBGridEhScrollBarPanelControl.Invalidate;
var
  i: Integer;
begin
  inherited Invalidate;
  for i := 0 to ControlCount-1 do
    Controls[i].Invalidate;
end;

function TDBGridEhScrollBarPanelControl.MaxSizeForExtraPanel: Integer;
begin
  Result := Width - GetSystemMetrics(SM_CYHSCROLL) * 2;
end;

procedure TDBGridEhScrollBarPanelControl.OnScrollEvent(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  if UseRightToLeftAlignment then
  begin
    ScrollPos := ScrollBar.Max - ScrollPos;
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  end else
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  ScrollPos := ScrollBar.Position;
end;

function TDBGridEhScrollBarPanelControl.ScrollBatCode: Integer;
begin
  if FKind = sbHorizontal
    then Result := SB_HORZ
    else Result := SB_VERT;
end;

procedure TDBGridEhScrollBarPanelControl.SetOnScroll(const Value: TScrollEvent);
begin
  ScrollBar.OnScroll := Value;
end;

procedure TDBGridEhScrollBarPanelControl.SetParams(APosition, AMin, AMax, APageSize: Integer);
begin
  if (AMax <= AMin) or (AMax - AMin < APageSize) then
  begin
    ScrollBar.Enabled := False
  end else
  begin
    ScrollBar.Enabled := True;
    ScrollBar.PageSize := APageSize;
    ScrollBar.SetParams(APosition, AMin, AMax);
    ScrollBar.PageSize := APageSize;
  end;
end;

{ TDBGridEhNavigatorPanel }

constructor TDBGridEhNavigatorPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF EH_LIB_13}
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption, csGestures] + [csOpaque, csNoDesignVisible];
{$ELSE}
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque, csNoDesignVisible];
{$ENDIF}
  if not NewStyleControls then
    ControlStyle := ControlStyle + [csFramed];
  FDataLink := TNavDataLinkEh.Create(Self);
  FVisibleButtons := [nbFirstEh, nbPriorEh, nbNextEh, nbLastEh, nbInsertEh,
    nbDeleteEh, nbEditEh, nbPostEh, nbCancelEh, nbRefreshEh];
  FHints := TStringList.Create;
  TStringList(FHints).OnChange := HintsChanged;
  InitItems;
  InitHints;
  ButtonWidth := 0;
  FocusedButton := nbFirstEh;
  FVisibleItems := [gsbiRecordsInfoEh, gsbiNavigator, gsbiSelAggregationInfoEh];
  AutoSize := True;
end;

destructor TDBGridEhNavigatorPanel.Destroy;
begin
  FDefHints.Free;
  FDataLink.Free;
  FHints.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TDBGridEhNavigatorPanel.InitItems;
var
  I: TNavigateBtnEh;
  Btn: TNavButtonEh;
  X: Integer;
begin
  MinBtnSize := Point(10, 10);
  X := 0;

  RecordsInfoPanel := TNavButtonEh.Create(Self);
  RecordsInfoPanel.Flat := Flat;
  RecordsInfoPanel.Enabled := True;
  RecordsInfoPanel.SetBounds (X, 0, 0, 0);
  RecordsInfoPanel.Parent := Self;
  RecordsInfoPanel.OnPaint := PaintRecordsInfo;
  X := X + 24;

  NavButtonsDivider := TNavButtonEh.Create(Self);
  NavButtonsDivider.Flat := Flat;
  NavButtonsDivider.Enabled := True;
  NavButtonsDivider.SetBounds (X, 0, 0, 0);
  NavButtonsDivider.Parent := Self;
  NavButtonsDivider.OnPaint := PaintDivider;
  X := X + 7;

  for I := Low(NavButtons) to High(NavButtons) do
  begin
    Btn := TNavButtonEh.Create(Self);
    Btn.Flat := Flat;
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, 0, 0);
    Btn.Enabled := False;
    Btn.Enabled := True; 
    Btn.OnDown := ClickHandler;
    Btn.OnMouseDown := BtnMouseDown;
    Btn.Parent := Self;
    NavButtons[I] := Btn;
    X := X + MinBtnSize.X;
  end;
  NavButtons[nbPriorEh].NavStyle := NavButtons[nbPriorEh].NavStyle + [nsAllowTimer];
  NavButtons[nbNextEh].NavStyle  := NavButtons[nbNextEh].NavStyle + [nsAllowTimer];

  FindEditDivider := TNavButtonEh.Create(Self);
  FindEditDivider.Flat := Flat;
  FindEditDivider.Enabled := True;
  FindEditDivider.SetBounds (X, 0, 0, 0);
  FindEditDivider.Parent := Self;
  FindEditDivider.OnPaint := PaintDivider;
  X := X + 7;

  SelectionInfoDivider := TNavButtonEh.Create(Self);
  SelectionInfoDivider.Flat := Flat;
  SelectionInfoDivider.Enabled := True;
  SelectionInfoDivider.SetBounds (X, 0, 0, 0);
  SelectionInfoDivider.Parent := Self;
  SelectionInfoDivider.OnPaint := PaintDivider;
  X := X + 7;

  SelectionInfoPanel := TNavButtonEh.Create(Self);
  SelectionInfoPanel.Flat := Flat;
  SelectionInfoPanel.Enabled := True;
  SelectionInfoPanel.SetBounds (X, 0, 0, 0);
  SelectionInfoPanel.Parent := Self;
  SelectionInfoPanel.OnPaint := PaintRecordsInfo;
  SelectionInfoPanel.OnMouseUp := SelectionInfoPanelMouseUp;

  FirstImageItem := nil;
  PriorImageItem := nil;
  NextImageItem := nil;
  LastImageItem := nil;
  InsertImageItem := nil;
  DeleteImageItem := nil;
  EditImageItem := nil;
  PostImageItem := nil;
  CancelImageItem := nil;
  RefreshImageItem := nil;
end;

procedure TDBGridEhNavigatorPanel.GridSelectionChanged;
var
  OldWidth: Integer;
begin
  if RecordsInfoPanel.Visible and HandleAllocated then
  begin
    OldWidth := RecordsInfoPanel.Width;
    RecordsInfoPanel.Width := CalcWidthForRecordsInfoPanel;
    RecordsInfoPanel.Invalidate;
    if OldWidth <> RecordsInfoPanel.Width then
      TDBGridEhScrollBarPanelControl(Parent).Resize;
  end;

  if (gsbiSelAggregationInfoEh in VisibleItems) and HandleAllocated then
  begin
    FSelectionInfoPanelText := GetSelectionInfoPanelText;
    if FSelectionInfoPanelText <> ''
      then SelectionInfoPanel.Visible := True
      else SelectionInfoPanel.Visible := False;
    SelectionInfoDivider.Visible := SelectionInfoPanel.Visible;

    SelectionInfoPanel.Width := CalcWidthSelectionInfoPanel;
    SelectionInfoPanel.Invalidate;

    ResetWidth;
  end else
  begin
    SelectionInfoPanel.Visible := False;
    SelectionInfoDivider.Visible := SelectionInfoPanel.Visible;
    SelectionInfoPanel.Invalidate;
  end;
end;

procedure TDBGridEhNavigatorPanel.GetGridAggrInfo(var ResultArr: TAggrResultArr);
var
  FromColIdx: Integer;
  ToColIdx: Integer;
  CurColIdx: Integer;
  CurRowIdx: Integer;
  FromRowIdx: Integer;
  ToRowIdx: Integer;
  Field: TField;
  Grid: TCustomDBGridEhCrack;
  NumCount: Integer;
  Bm: TUniBookmarkEh;
  RecIdx: Integer;
  InstantReadEntered: Boolean;

  procedure IninVars;
  begin
    if Grid.Selection.SelectionType = gstRectangle then
    begin
      FromRowIdx := Grid.FIntMemTable.InstantReadIndexOfBookmark(Grid.Selection.Rect.TopRow);
      ToRowIdx := Grid.FIntMemTable.InstantReadIndexOfBookmark(Grid.Selection.Rect.BottomRow);
      FromColIdx := Grid.Selection.Rect.LeftCol;
      ToColIdx := Grid.Selection.Rect.RightCol;
    end else if Grid.Selection.SelectionType = gstColumns then
    begin
      FromRowIdx := 0;
      ToRowIdx := Grid.FIntMemTable.InstantReadRowCount-1;
      FromColIdx := 0;
      ToColIdx := Grid.Selection.Columns.Count-1;
    end else if Grid.Selection.SelectionType = gstAll then
    begin
      FromRowIdx := 0;
      ToRowIdx := Grid.FIntMemTable.InstantReadRowCount-1;
      FromColIdx := 0;
      ToColIdx := Grid.VisibleColumns.Count-1;
    end else if Grid.Selection.SelectionType = gstRecordBookmarks then
    begin
      FromRowIdx := 0;
      ToRowIdx := Grid.Selection.Rows.Count-1;
      FromColIdx := 0;
      ToColIdx := Grid.VisibleColumns.Count-1;
    end;
  end;

  function GetField: TField;
  begin
    if Grid.Selection.SelectionType = gstRectangle then
      Result := Grid.Columns[CurColIdx].Field
    else if Grid.Selection.SelectionType = gstColumns then
      Result := Grid.Selection.Columns[CurColIdx].Field
    else if Grid.Selection.SelectionType = gstAll then
      Result := Grid.VisibleColumns[CurColIdx].Field
    else if Grid.Selection.SelectionType = gstRecordBookmarks then
      Result := Grid.VisibleColumns[CurColIdx].Field
    else
      Result := nil;
  end;

  procedure ResetCol;
  begin
    CurColIdx := FromColIdx;
    Field := GetField;
  end;

  function NextCol: Boolean;
  var
    i: Integer;
  begin
    CurColIdx := CurColIdx + 1;
    if Grid.Selection.SelectionType = gstRectangle then
    begin
      for i := CurColIdx to ToColIdx+1 do
      begin
        if i <= ToColIdx then
          if Grid.Columns[i].Visible then
            Break
          else
            CurColIdx := CurColIdx + 1;
      end;
    end;
    Result := (CurColIdx > ToColIdx);
    if not Result then
      Field := GetField
    else
      Field := nil;
  end;

  function ResetRow: Boolean;
  begin
    Result := False;
    CurRowIdx := FromRowIdx;

    InstantReadEntered := False;
    if Grid.Selection.SelectionType = gstRecordBookmarks then
    begin
      Bm := Grid.Selection.Rows[CurRowIdx];
      RecIdx := Grid.FIntMemTable.InstantReadIndexOfBookmark(Bm);
      if RecIdx >= 0 then
      begin
        Grid.FIntMemTable.InstantReadEnter(RecIdx);
        InstantReadEntered := True;
      end;
    end else
    begin
      Grid.FIntMemTable.InstantReadEnter(CurRowIdx);
      InstantReadEntered := True;
    end;
  end;

  function NextRow: Boolean;
  begin
    if InstantReadEntered then
      Grid.FIntMemTable.InstantReadLeave;
    InstantReadEntered := False;
    CurRowIdx := CurRowIdx + 1;
    Result := (CurRowIdx > ToRowIdx);
    if not Result then
    begin
      if (CurRowIdx < 0) or (CurRowIdx >= Grid.FIntMemTable.InstantReadRowCount) then
      begin
        Result := True;
        Exit;
      end;

      if Grid.Selection.SelectionType = gstRecordBookmarks then
      begin
        Bm := Grid.Selection.Rows[CurRowIdx];
        RecIdx := Grid.FIntMemTable.InstantReadIndexOfBookmark(Bm);
        if RecIdx >= 0 then
        begin
          Grid.FIntMemTable.InstantReadEnter(RecIdx);
          InstantReadEntered := True;
        end;
      end else
      begin
        Grid.FIntMemTable.InstantReadEnter(CurRowIdx);
        InstantReadEntered := True;
      end;
    end;
  end;

  procedure CalcStep;
  var
    v: Variant;
    bcdVar: Variant;
    AVarType: TVarType;
  begin
    if Field = nil
      then v := Null
      else v := Field.Value;
    AVarType := VarType(v);
    if not VarIsNullEh(v) and
       not (((AVarType = varOleStr) or 
             (AVarType = varString)
{$IFDEF EH_LIB_12}
             or (AVarType = varUString) 
{$ENDIF}
            ) and VarEquals(v, '')
           )
    then
      ResultArr[agfCountEh] := ResultArr[agfCountEh] + 1;

    if not VarIsNullEh(v) and VarIsNumericType(v) then
    begin
      {$IFDEF FPC}
      bcdVar := Null;
      VarFmtBCDCreate(bcdVar, VarToBCD(v));
      {$ELSE}
      VarCast(bcdVar, v, VarFMTBcd);
      {$ENDIF}
      NumCount := NumCount + 1;

      if VarIsNullEh(ResultArr[agfSumEh])
        then ResultArr[agfSumEh] := bcdVar
        else ResultArr[agfSumEh] := ResultArr[agfSumEh] + bcdVar;

      if VarIsNullEh(ResultArr[agfMin]) then
        ResultArr[agfMin] := bcdVar
      else if ResultArr[agfMin] > v then
        ResultArr[agfMin] := bcdVar;

      if VarIsNullEh(ResultArr[agfMax]) then
        ResultArr[agfMax] := bcdVar
      else if ResultArr[agfMax] < bcdVar then
        ResultArr[agfMax] := bcdVar;
    end;
  end;

begin
  ResultArr[agfSumEh] := Null;
  ResultArr[agfCountEh] := 0;
  ResultArr[agfAvg] := Null;
  ResultArr[agfMin] := Null;
  ResultArr[agfMax] := Null;
  NumCount := 0;
  
  Grid := TCustomDBGridEhCrack(Parent.Parent);

  IninVars;
  if FromRowIdx < 0 then Exit;

  ResetRow;
  while True do
  begin
    ResetCol;
    while True do
    begin
      CalcStep;
      if NextCol then
        Break;
    end;
    if NextRow then
      Break;
  end;

  if not VarIsNullEh(ResultArr[agfSumEh]) then
    ResultArr[agfAvg] := ResultArr[agfSumEh] / NumCount;
end;

function TDBGridEhNavigatorPanel.GetSelectionInfoPanelText: String;
{$IFDEF FPC}
begin
  Result := '';
end;
{$ELSE}
var
  ResultArr: TAggrResultArr;
  Grid: TCustomDBGridEhCrack;
  PaintControl: TNavButtonEh;

  procedure SetSelectionInfoPanelData(var Item: TSelectionInfoPanelDataItemEh; Text1, Text2: String);
  begin
    Result := Result + Text1;
    Item.Text := Text2;
    Item.Start := PaintControl.Canvas.TextWidth(Result);
    Result := Result + Text2;
    Item.Finish := PaintControl.Canvas.TextWidth(Result);
  end;
  
begin
  SetLength(SelectionInfoPanelDataEh, 0);
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  Result := '';
  if (Grid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle, gstColumns, gstAll]) and
      (Grid.FIntMemTable <> nil) then
  begin
    GetGridAggrInfo(ResultArr);

    PaintControl := RecordsInfoPanel;
    PaintControl.Canvas.Font := Grid.Font;
    PaintControl.Canvas.Font.Size := GetFontSize(PaintControl.Canvas.Font);
    if not VarIsNull(ResultArr[agfSumEh]) then
    begin
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+EhLibLanguageConsts.GridSelectionInfo_Sum+': ', VarToStr(ResultArr[agfSumEh]));
    end;
    if not VarIsNull(ResultArr[agfCountEh]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+EhLibLanguageConsts.GridSelectionInfo_Cnt+': ', VarToStr(ResultArr[agfCountEh]));
    end;
    if not VarIsNull(ResultArr[agfAvg]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+EhLibLanguageConsts.GridSelectionInfo_Evg+': ', VarToStr(ResultArr[agfAvg]));
    end;
    if not VarIsNull(ResultArr[agfMin]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+EhLibLanguageConsts.GridSelectionInfo_Min+': ', VarToStr(ResultArr[agfMin]));
    end;
    if not VarIsNull(ResultArr[agfMax]) then
    begin
      if Result <> '' then Result := Result + '   ';
      SetLength(SelectionInfoPanelDataEh, Length(SelectionInfoPanelDataEh)+1);
      SetSelectionInfoPanelData(SelectionInfoPanelDataEh[Length(SelectionInfoPanelDataEh)-1],
         ' '+EhLibLanguageConsts.GridSelectionInfo_Max+': ', VarToStr(ResultArr[agfMax]));
    end;
    if Result <> '' then Result := Result + ' ';
  end;
end;
{$ENDIF} 

procedure TDBGridEhNavigatorPanel.InitHints;
var
  I: Integer;
  J: TNavigateBtnEh;
  BtnHintId: array[TNavigateBtnEh] of String;
begin
  BtnHintId[nbFirstEh] := EhLibLanguageConsts.FirstRecordEh;
  BtnHintId[nbPriorEh] := EhLibLanguageConsts.PriorRecordEh;
  BtnHintId[nbNextEh] := EhLibLanguageConsts.NextRecordEh;
  BtnHintId[nbLastEh] := EhLibLanguageConsts.LastRecordEh;
  BtnHintId[nbInsertEh] := EhLibLanguageConsts.InsertRecordEh;
  BtnHintId[nbDeleteEh] := EhLibLanguageConsts.DeleteRecordEh;
  BtnHintId[nbEditEh] := EhLibLanguageConsts.EditRecordEh;
  BtnHintId[nbPostEh] := EhLibLanguageConsts.PostEditEh;
  BtnHintId[nbCancelEh] := EhLibLanguageConsts.CancelEditEh;
  BtnHintId[nbRefreshEh] := EhLibLanguageConsts.RefreshRecordEh;

  if not Assigned(FDefHints) then
    FDefHints := TStringList.Create;
  FDefHints.Clear;
  for J := Low(NavButtons) to High(NavButtons) do
    FDefHints.Add(BtnHintId[J]);
  for J := Low(NavButtons) to High(NavButtons) do
    NavButtons[J].Hint := FDefHints[Ord(J)];
  J := Low(NavButtons);
  for I := 0 to (FHints.Count - 1) do
  begin
    if FHints.Strings[I] <> '' then NavButtons[J].Hint := FHints.Strings[I];
    if J = High(NavButtons) then Exit;
    Inc(J);
  end;
end;

procedure TDBGridEhNavigatorPanel.HintsChanged(Sender: TObject);
begin
  InitHints;
end;

procedure TDBGridEhNavigatorPanel.SetFlat(Value: Boolean);
var
  I: TNavigateBtnEh;
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    for I := Low(NavButtons) to High(NavButtons) do
      NavButtons[I].Flat := Value;
  end;
end;

procedure TDBGridEhNavigatorPanel.SetHints(Value: TStrings);
begin
  if Value.Text = FDefHints.Text then
    FHints.Clear else
    FHints.Assign(Value);
end;

function TDBGridEhNavigatorPanel.GetHints: TStrings;
begin
  if (csDesigning in ComponentState) and not (csWriting in ComponentState) and
     not (csReading in ComponentState) and (FHints.Count = 0) then
    Result := FDefHints else
    Result := FHints;
end;

procedure TDBGridEhNavigatorPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TDBGridEhNavigatorPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBGridEhNavigatorPanel.CalcMinSize(var W, H: Integer);
var
  Count: Integer;
  I: TNavigateBtnEh;
begin
  if (csLoading in ComponentState) then Exit;
  if NavButtons[nbFirstEh] = nil then Exit;

  Count := 0;
  for I := Low(NavButtons) to High(NavButtons) do
    if NavButtons[I].Visible then
      Inc(Count);
  if Count = 0 then Inc(Count);

  W := Max(W, Count * MinBtnSize.X);
  H := Max(H, MinBtnSize.Y);

  if Align = alNone then W := (W div Count) * Count;
end;

function TDBGridEhNavigatorPanel.OptimalWidth: Integer;
var
  I: TNavigateBtnEh;
  SPanW, SPanH: Integer;
begin
  Result := 0;
  if not HandleAllocated then Exit;

  if RecordsInfoPanel.Visible then
    Inc(Result, RecordsInfoPanel.Width);
  if NavButtonsDivider.Visible then
    Inc(Result, NavButtonsDivider.Width);

  for I := Low(NavButtons) to High(NavButtons) do
    if NavButtons[I].Visible then
      Inc(Result, ClientHeight);

  if SelectionInfoPanel.Visible then
  begin
    Inc(Result, SelectionInfoDivider.Width);
    Inc(Result, SelectionInfoPanel.Width);
  end;

  if (FSearchPanelControl <> nil) and FSearchPanelControl.Visible then
  begin
    SPanW := FSearchPanelControl.CalcAutoWidthForHeight(ClientHeight);
    SPanH := FSearchPanelControl.Height;
    FSearchPanelControl.SetSize(SPanW, SPanH);
    Inc(Result, SPanW);
  end;

  Result := Result + (Width - ClientWidth);
end;

procedure TDBGridEhNavigatorPanel.ResetWidth;
var
  NewWidth: Integer;
begin
  NewWidth := OptimalWidth;
  if Parent is TDBGridEhScrollBarPanelControl  then
  begin
    if NewWidth > TDBGridEhScrollBarPanelControl(Parent).MaxSizeForExtraPanel then
      NewWidth := TDBGridEhScrollBarPanelControl(Parent).MaxSizeForExtraPanel;
  end;
  if NewWidth < 0 then NewWidth := 0;
  Width := NewWidth;
end;

procedure TDBGridEhNavigatorPanel.SetSearchPanelControl(const Value: TDBGridSearchPanelControlEh);
begin
  if FSearchPanelControl <> Value then
  begin
    if FSearchPanelControl <> nil then
      FSearchPanelControl.Parent := nil;
    FSearchPanelControl := Value;
    if FSearchPanelControl <> nil then
      FSearchPanelControl.Parent := Self;
  end;
end;

procedure TDBGridEhNavigatorPanel.Resize;
var
  NewWidth, NewHeight: Integer;
begin
  if not HandleAllocated then Exit;
  NewWidth := Width-1;
  NewHeight := Height-1;
  SetSize(NewWidth, NewHeight);
end;

procedure TDBGridEhNavigatorPanel.SetSize(var W: Integer; var H: Integer);
var
  I: TNavigateBtnEh;
  Space{, Temp, Remain}: Integer;
  X: Integer;

  procedure SetNavButton(NavB: TNavButtonEh);
  begin
    if NavB.Visible then
    begin
      Space := 0;
      if UseRightToLeftAlignment then
        Dec(X, ButtonWidth + Space);
      NavB.SetBounds(X, 0, ButtonWidth + Space, H);
      if not UseRightToLeftAlignment then
        Inc(X, ButtonWidth + Space);
    end
    else
      NavB.SetBounds(Width + 1, 0, ButtonWidth, Height);
  end;

begin
  if (csLoading in ComponentState) then Exit;
  if NavButtons[nbFirstEh] = nil then Exit;

  ButtonWidth := H;

  if UseRightToLeftAlignment
    then X := ClientWidth
    else X := 0;

  if RecordsInfoPanel.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, RecordsInfoPanel.Width);
    RecordsInfoPanel.SetBounds(X, 0, RecordsInfoPanel.Width, H);
    if not UseRightToLeftAlignment then
      Inc(X, RecordsInfoPanel.Width);
  end else
    RecordsInfoPanel.SetBounds(0, 0, 0, 0);

  if NavButtonsDivider.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, DividerWidth);
    NavButtonsDivider.SetBounds(X, 0, DividerWidth, H);
    if not UseRightToLeftAlignment then
      Inc(X, NavButtonsDivider.Width);
  end else
    NavButtonsDivider.SetBounds(0, 0, 0, 0);

  if UseRightToLeftAlignment then
    for I := nbLastEh downto nbFirstEh do
      SetNavButton(NavButtons[I])
  else
    for I := nbFirstEh to nbLastEh do
      SetNavButton(NavButtons[I]);

  for I := nbInsertEh to High(NavButtons) do
    SetNavButton(NavButtons[I]);

  if (FSearchPanelControl <> nil) then
    if FSearchPanelControl.Visible then
    begin
      if UseRightToLeftAlignment then
        Dec(X, FSearchPanelControl.CalcAutoWidthForHeight(H));
      FSearchPanelControl.SetBounds(X, 0, FSearchPanelControl.CalcAutoWidthForHeight(H), H);
      if not UseRightToLeftAlignment then
        Inc(X, FSearchPanelControl.Width);
    end else
      FSearchPanelControl.SetBounds(0, 0, 0, 0);

  if SelectionInfoDivider.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, SelectionInfoDivider.Width);
    SelectionInfoDivider.SetBounds(X, 0, SelectionInfoDivider.Width, H);
    if not UseRightToLeftAlignment then
      Inc(X, SelectionInfoDivider.Width);
  end else
    SelectionInfoDivider.SetBounds(0, 0, 0, 0);

  if SelectionInfoDivider.Visible then
  begin
    if UseRightToLeftAlignment then
      Dec(X, SelectionInfoPanel.Width);
    SelectionInfoPanel.SetBounds(X, 0, SelectionInfoPanel.Width, H);
    if not UseRightToLeftAlignment then
      Inc(X, SelectionInfoPanel.Width);
  end else
    SelectionInfoPanel.SetBounds(0, 0, 0, 0);

  if UseRightToLeftAlignment
    then W := ClientWidth - X
    else W := X;
end;

procedure TDBGridEhNavigatorPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;

  inherited SetBounds(ALeft, ATop, W, H);
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
procedure TDBGridEhNavigatorPanel.WMNCPaint(var Message: TWMNCPaint);
begin
  DrawNonClientBorder;
end;
{$ENDIF}

procedure TDBGridEhNavigatorPanel.WMSettingChange(var Message: TMessage);
begin
  inherited;
  InitHints;
end;

procedure TDBGridEhNavigatorPanel.WMSize(var Message: TWMSize);
begin
  inherited;
end;

procedure TDBGridEhNavigatorPanel.WMSetFocus(var Message: TWMSetFocus);
begin
  NavButtons[FocusedButton].Invalidate;
end;

procedure TDBGridEhNavigatorPanel.WMKillFocus(var Message: TWMKillFocus);
begin
  NavButtons[FocusedButton].Invalidate;
end;

procedure TDBGridEhNavigatorPanel.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TDBGridEhNavigatorPanel.ClickHandler(Sender: TObject;
    var AutoRepeat: Boolean; var Handled: Boolean);
begin
  NavBtnClick(TNavButtonEh(Sender).Index);
end;

procedure TDBGridEhNavigatorPanel.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TNavigateBtnEh;
  Grid: TCustomDBGridEhCrack;
begin
  OldFocus := FocusedButton;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  Grid.AcquireFocus;
  FocusedButton := TNavButtonEh(Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end
  else if TabStop and (GetFocus = Handle) and (OldFocus <> FocusedButton) then
  begin
    NavButtons[OldFocus].Invalidate;
    NavButtons[FocusedButton].Invalidate;
  end;
end;

procedure TDBGridEhNavigatorPanel.NavBtnClick(Index: TNavigateBtnEh);
var
  Grid: TCustomDBGridEhCrack;
  DS: TDataSet;
  Processed: Boolean;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if (DataSource <> nil) and (DataSource.State <> dsInactive) then
  begin
    if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
      FBeforeAction(Self, Index);
    Processed := False;
    TCustomDBGridEhCrack(Parent.Parent).NavigatorPanelButtonClick(Index, Processed);
    if not Processed then
    begin
      DS := DataSource.DataSet;
      begin
        case Index of
          nbPriorEh: DS.Prior;
          nbNextEh: DS.Next;
          nbFirstEh: DS.First;
          nbLastEh: DS.Last;
          nbInsertEh:
            if alopInsertEh in Grid.AllowedOperations
              then Grid.DataInsert
              else Grid.DataAppend;
          nbEditEh: DS.Edit;
          nbCancelEh: DS.Cancel;
          nbPostEh: DS.Post;
          nbRefreshEh: DS.Refresh;
          nbDeleteEh:
            if Grid.Selection.SelectionType in [gstRecordBookmarks, gstAll] then
              DBGridEh_DoDeleteAction(Grid, False)
            else if not CheckConfirmDelete or
               {$IFDEF FPC}
                        (MessageDlg('SDeleteRecordQuestion', mtConfirmation, mbOKCancel, 0) <> idCancel)
               {$ELSE}
                        (MessageDlg(SDeleteRecordQuestion, mtConfirmation, mbOKCancel, 0) <> idCancel)
               {$ENDIF}
            then
             DS. Delete;
        end;
      end;
    end;
  end;
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then
    FOnNavClick(Self, Index);
end;

procedure TDBGridEhNavigatorPanel.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TNavigateBtnEh;
  OldFocus: TNavigateBtnEh;
begin
  OldFocus := FocusedButton;
  case Key of
    VK_RIGHT:
      begin
        if OldFocus < High(NavButtons) then
        begin
          NewFocus := OldFocus;
          repeat
            NewFocus := Succ(NewFocus);
          until (NewFocus = High(NavButtons)) or (NavButtons[NewFocus].Visible);
          if NavButtons[NewFocus].Visible then
          begin
            FocusedButton := NewFocus;
            NavButtons[OldFocus].Invalidate;
            NavButtons[NewFocus].Invalidate;
          end;
        end;
      end;
    VK_LEFT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus > Low(NavButtons) then
            NewFocus := Pred(NewFocus);
        until (NewFocus = Low(NavButtons)) or (NavButtons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FocusedButton := NewFocus;
          NavButtons[OldFocus].Invalidate;
          NavButtons[FocusedButton].Invalidate;
        end;
      end;
    VK_SPACE:
      begin
        if NavButtons[FocusedButton].Enabled then
          NavButtons[FocusedButton].Click;
      end;
  end;
end;

procedure TDBGridEhNavigatorPanel.DataChanged;
var
  UpEnable, DnEnable: Boolean;
  Grid: TCustomDBGridEhCrack;
  CanModify: Boolean;
  OnDataRow: Boolean;
begin
  if csDestroying in ComponentState then Exit;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if not Grid.HandleAllocated then Exit;
  UpEnable := Enabled and DataSetActive and not FDataLink.DataSet.BOF;
  DnEnable := Enabled and DataSetActive and not FDataLink.DataSet.EOF;
  CanModify := Enabled and DataSetActive and FDataLink.DataSet.CanModify and not Grid.ReadOnly;
  if Grid.DataGrouping.IsGroupingWorks and
     (Grid.DataGrouping.CurDataNode <> nil)then
  begin
    OnDataRow := (Grid.DataGrouping.CurDataNode.NodeType = dntDataSetRecordEh);
  end else
  begin
    OnDataRow := True;
  end;
  NavButtons[nbFirstEh].Enabled := UpEnable;
  NavButtons[nbPriorEh].Enabled := UpEnable;
  NavButtons[nbNextEh].Enabled := DnEnable;
  NavButtons[nbLastEh].Enabled := DnEnable;
  NavButtons[nbDeleteEh].Enabled := CanModify and
    (alopDeleteEh in Grid.AllowedOperations) and
    not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF) and OnDataRow;
  NavButtons[nbEditEh].Enabled := CanModify and not FDataLink.Editing and
    not FDataLink.Editing and (alopUpdateEh in Grid.AllowedOperations) and OnDataRow;
  NavButtons[nbInsertEh].Enabled := CanModify and
   ( (alopInsertEh in Grid.AllowedOperations) or (alopAppendEh in Grid.AllowedOperations) )
   and OnDataRow;
  if not NavButtons[nbInsertEh].Enabled and (FDataLink.DataSet <> nil) and FDataLink.DataSet.IsEmpty then
    NavButtons[nbEditEh].Enabled := False;

  NavButtons[nbPostEh].Enabled := CanModify and FDataLink.Editing;
  NavButtons[nbCancelEh].Enabled := CanModify and FDataLink.Editing;
  NavButtons[nbRefreshEh].Enabled := True;

  GridSelectionChanged;
end;

function TDBGridEhNavigatorPanel.DataSetActive: Boolean;
begin
  Result := (FDataLink <> nil) and
            FDataLink.Active and
            (FDataLink.DataSet <> nil) and
            FDataLink.DataSet.Active;
end;

procedure TDBGridEhNavigatorPanel.EditingChanged;
begin
  DataChanged;
end;

procedure TDBGridEhNavigatorPanel.ActiveChanged;
var
  I: TNavigateBtnEh;
begin
  if not (Enabled and FDataLink.Active) then
    for I := Low(NavButtons) to High(NavButtons) do
      NavButtons[I].Enabled := False
  else
  begin
    DataChanged;
    EditingChanged;
  end;
end;

procedure TDBGridEhNavigatorPanel.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

procedure TDBGridEhNavigatorPanel.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> Value then
  begin
    FDataLink.DataSource := Value;
    if not (csLoading in ComponentState) then
      ActiveChanged;
    if Value <> nil then Value.FreeNotification(Self);
  end;  
end;

function TDBGridEhNavigatorPanel.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBGridEhNavigatorPanel.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width-1;
  H := Height-1;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  InitHints;
  ActiveChanged;
end;

procedure TDBGridEhNavigatorPanel.SetDisabledImages(const Value: TCustomImageList);
begin
  FDisabledImages := Value;
  ResetVisibleControls;
end;

procedure TDBGridEhNavigatorPanel.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
  ResetVisibleControls;
end;

procedure TDBGridEhNavigatorPanel.DrawNonClientBorder;
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  DC, OldDC: HDC;
  R, R1: TRect;

  procedure DrawPolyline(Points: array of TPoint);
  var
    i: Integer;
  begin
    if UseRightToLeftAlignment then
    begin
      for i := 0 to Length(Points)-1 do
      begin
        Points[i].X := Points[i].X + 1;
      end;
    end;
    Canvas.Polyline(Points);
  end;

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
        Canvas.Pen.Color := StyleServices.GetSystemColor(BorderColor);
        DrawPolyline([Point(R1.Left, R1.Top),
                      Point(R1.Right-1, R1.Top),
                      Point(R1.Right-1, R1.Bottom)]);
        Canvas.Handle := OldDC;
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;
{$ENDIF} 

procedure TDBGridEhNavigatorPanel.SelectionInfoPanelMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i: Integer;
  p: TPoint;
begin
  for i := 0 to Length(SelectionInfoPanelDataEh)-1 do
  begin
    if (X >= SelectionInfoPanelDataEh[i].Start) and (X <= SelectionInfoPanelDataEh[i].Finish) then
    begin
      p := SelectionInfoPanel.ClientToScreen(Point(X, Y));
      DBGridEhRes.PopupMenu1.Items[0].Hint := SelectionInfoPanelDataEh[i].Text;
      DBGridEhRes.PopupMenu1.Popup(p.X, p.y);
      Exit;
    end;
  end;
end;

procedure TDBGridEhNavigatorPanel.CMParentFontChanged(var Message: TMessage);
var
  Grid: TCustomDBGridEhCrack;
begin
  inherited;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid = nil then Exit;
  if SearchPanelControl <> nil then
  begin
    SearchPanelControl.FindEditor.Font.Name := Grid.Font.Name;
    SearchPanelControl.FindEditor.Font.Charset := Grid.Font.Charset;
  end;
end;

procedure TDBGridEhNavigatorPanel.PaintDivider(Sender: TObject);
var
  R: TRect;
begin
  TNavButtonEh(Sender).Canvas.Pen.Color := BorderColor;
  R := Rect(0, 0, TNavButtonEh(Sender).Width, TNavButtonEh(Sender).Height);
  TNavButtonEh(Sender).Canvas.Polyline([Point(R.Left, R.Top), Point(R.Left, R.Bottom)]);
end;

procedure TDBGridEhNavigatorPanel.PaintRecordsInfo(Sender: TObject);
var
  Grid: TCustomDBGridEhCrack;
  PaintControl: TNavButtonEh;
  R: TRect;
  Text: String;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.DataLink.Active then
  begin
    PaintControl := TNavButtonEh(Sender);
    if PaintControl = RecordsInfoPanel then
    begin
      PaintControl.Canvas.Font.Name := Grid.Font.Name;
      PaintControl.Canvas.Font.Size := GetFontSize(Font) - 1;
      PaintControl.Canvas.Font.Color := Grid.FInternalFontColor;
      if Grid.DataLink.Active and Grid.DataLink.DataSet.Active then
        Text := IntToStr(Grid.SumList.RecordCount);
      if Grid.SelectedRows.Count > 0 then
        Text := Text + ' (' + IntToStr(Grid.SelectedRows.Count) + ')';
      R := Rect(0, 0, PaintControl.Width, PaintControl.Height);
      WriteTextEh(PaintControl.Canvas, R, False, 0, 0, Text,
        taCenter, tlCenter, False, False, 1, 1, UseRightToLeftReading, False);
    end else if PaintControl = SelectionInfoPanel then
    begin
      PaintControl.Canvas.Font.Name := Grid.Font.Name;
      PaintControl.Canvas.Font.Size := GetFontSize(Font);
      PaintControl.Canvas.Font.Color := Grid.FInternalFontColor;
      R := Rect(0, 0, PaintControl.Width, PaintControl.Height);
      WriteTextEh(PaintControl.Canvas, R, False, 0, 0, FSelectionInfoPanelText,
        taCenter, tlCenter, False, False, 0, 0, UseRightToLeftReading, False);
    end;
  end;
end;

function TDBGridEhNavigatorPanel.CalcWidthForRecordsInfoPanel: Integer;
var
  Grid: TCustomDBGridEhCrack;
  PaintControl: TNavButtonEh;
  Text: String;
begin
  Result := 0;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.DataLink.Active and Grid.DataLink.DataSet.Active then
  begin
    PaintControl := RecordsInfoPanel;
    PaintControl.Canvas.Font := Grid.Font;
    PaintControl.Canvas.Font.Size := GetFontSize(PaintControl.Canvas.Font) - 1;
    Text := IntToStr(Grid.SumList.RecordCount);
    if Grid.SelectedRows.Count > 0 then
      Text := Text + ' (' + IntToStr(Grid.SelectedRows.Count) + ')';
    Result := PaintControl.Canvas.TextWidth(' ' + Text + ' ');
    if Grid.IndicatorColVisible and (Result < Grid.CalcIndicatorColWidth) then
      Result := Grid.CalcIndicatorColWidth;
  end;
end;

function TDBGridEhNavigatorPanel.CalcWidthSelectionInfoPanel: Integer;
var
  Grid: TCustomDBGridEhCrack;
  PaintControl: TNavButtonEh;
  Text: String;
begin
  Result := 0;
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.DataLink.Active then
  begin
    PaintControl := RecordsInfoPanel;
    PaintControl.Canvas.Font := Grid.Font;
    PaintControl.Canvas.Font.Size := GetFontSize(PaintControl.Canvas.Font);
    Text := FSelectionInfoPanelText;
    Result := PaintControl.Canvas.TextWidth(' ' + Text + ' ');
    if Grid.IndicatorColVisible and (Result < Grid.CalcIndicatorColWidth) then
      Result := Grid.CalcIndicatorColWidth;
  end;
end;

function TDBGridEhNavigatorPanel.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
var
  W, H: Integer;
begin
  W := NewWidth-1;
  H := NewHeight-1;
  SetSize(W, H);
  Result := True;
end;

procedure TDBGridEhNavigatorPanel.CreateWnd;
var
  W, H: Integer;
begin
  inherited CreateWnd;
  GridSelectionChanged;
  W := Width-1;
  H := Height-1;
  SetSize(W, H);
  TDBGridEhScrollBarPanelControl(Owner).Resize;
end;

procedure TDBGridEhNavigatorPanel.Paint;
var
  Grid: TCustomDBGridEhCrack;
  ARect: TRect;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  if Grid.Flat then
  begin
    Grid.SetPaintColors;
    ARect := GetClientRect;
    FillGradientEh(Canvas, ARect, Grid.FInternalColor, Grid.FInternalFixedColor)
  end else
  begin
    inherited Paint;
    if CustomStyleActive then
    begin
      Canvas.Brush.Color := Grid.FInternalColor;
      Canvas.FillRect(GetClientRect);
    end;
  end;
end;

procedure TDBGridEhNavigatorPanel.SetVisibleItems(const Value: TGridSBItemsEh);
var
  Grid: TCustomDBGridEhCrack;
begin
  if FVisibleItems <> Value then
  begin
    FVisibleItems := Value;
    ResetVisibleControls;
    if (Parent <> nil) and (Parent.Parent <> nil) then
    begin
      Grid := TCustomDBGridEhCrack(Parent.Parent);
      Grid.Invalidate;
    end;
  end;
end;

procedure TDBGridEhNavigatorPanel.SetVisibleButtons(Value: TNavButtonSetEh);
begin
  if FVisibleButtons <> Value then
  begin
    FVisibleButtons := Value;
    ResetVisibleControls;
  end;
end;

procedure TDBGridEhNavigatorPanel.ResetVisibleControls;
var
  I: TNavigateBtnEh;
  NeedSeparator, NeedSeparator1: Boolean;
  Btn: TNavButtonEh;
begin
  NeedSeparator1 := False;
  RecordsInfoPanel.Visible := gsbiRecordsInfoEh in VisibleItems;
  NeedSeparator := RecordsInfoPanel.Visible;
  NavButtonsDivider.Visible := False;

  for I := Low(NavButtons) to High(NavButtons) do
  begin
    Btn := NavButtons[I];
    Btn.Visible := (I in FVisibleButtons) and (gsbiNavigator in VisibleItems);
    if Btn.Visible then
      NeedSeparator1 := True;
    if NeedSeparator and Btn.Visible then
      NavButtonsDivider.Visible := True;
  end;

  if NeedSeparator1 then NeedSeparator := True;

  if (SearchPanelControl <> nil) and NeedSeparator
    then FindEditDivider.Visible := True
    else FindEditDivider.Visible := False;

  GridSelectionChanged;

  TDBGridEhScrollBarPanelControl(Owner).Resize;
  Invalidate;
end;

function TDBGridEhNavigatorPanel.DividerWidth: Integer;
begin
  Result := 7;
end;

procedure TDBGridEhNavigatorPanel.SetBorderColor(const Value: TColor);
begin
  if Value <> FBorderColor then
  begin
    FBorderColor := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

function TDBGridEhNavigatorPanel.CheckConfirmDelete: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Parent.Parent);
  Result := dgConfirmDelete in Grid.Options;
end;

procedure TDBGridEhNavigatorPanel.SetVisible(const Value: Boolean);
begin
  if Visible <> Value then
  begin
    inherited Visible := Value;
    TDBGridEhScrollBarPanelControl(Owner).Resize;
  end;
end;

function TDBGridEhNavigatorPanel.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

//nbFirstEh
function TDBGridEhNavigatorPanel.GetFirstImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbFirstEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetFirstImageItem(const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbFirstEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavFirstImageItem
    else NavButtons[nbFirstEh].ResourceImageItem := Value;
end;

//nbPriorEh
function TDBGridEhNavigatorPanel.GetPriorImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbPriorEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetPriorImageItem(const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbPriorEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavPriorImageItem
    else NavButtons[nbPriorEh].ResourceImageItem := Value;
end;

//nbNextEh
function TDBGridEhNavigatorPanel.GetNextImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbNextEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetNextImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbNextEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavNextImageItem
    else NavButtons[nbNextEh].ResourceImageItem := Value;
end;

//nbLastEh
function TDBGridEhNavigatorPanel.GetLastImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbLastEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetLastImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbLastEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavLastImageItem
    else NavButtons[nbLastEh].ResourceImageItem := Value;
end;

//nbInsertEh
function TDBGridEhNavigatorPanel.GetInsertImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbInsertEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetInsertImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbInsertEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavInsertImageItem
    else NavButtons[nbInsertEh].ResourceImageItem := Value;
end;

//nbDeleteEh
function TDBGridEhNavigatorPanel.GetDeleteImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbDeleteEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetDeleteImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbDeleteEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavDeleteImageItem
    else NavButtons[nbDeleteEh].ResourceImageItem := Value;
end;

//nbEditEh
function TDBGridEhNavigatorPanel.GetEditImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbEditEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetEditImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbEditEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavEditImageItem
    else NavButtons[nbEditEh].ResourceImageItem := Value;
end;

//nbPostEh
function TDBGridEhNavigatorPanel.GetPostImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbPostEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetPostImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbPostEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavPostImageItem
    else NavButtons[nbPostEh].ResourceImageItem := Value;
end;

//nbCancelEh
function TDBGridEhNavigatorPanel.GetCancelImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbCancelEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetCancelImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbCancelEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavCancelImageItem
    else NavButtons[nbCancelEh].ResourceImageItem := Value;
end;

//nbRefreshEh
function TDBGridEhNavigatorPanel.GetRefreshImageItem: TResourceImageItemEh;
begin
  Result := NavButtons[nbRefreshEh].ResourceImageItem;
end;

procedure TDBGridEhNavigatorPanel.SetRefreshImageItem(
  const Value: TResourceImageItemEh);
begin
  if Value = nil
    then NavButtons[nbRefreshEh].ResourceImageItem := EhLibImageResources.GridScrollBarNavRefreshImageItem
    else NavButtons[nbRefreshEh].ResourceImageItem := Value;
end;

{TNavButtonEh}

constructor TNavButtonEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clMenu;
end;

destructor TNavButtonEh.Destroy;
begin
  inherited Destroy;
end;

procedure TNavButtonEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TNavButtonEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
end;

procedure TNavButtonEh.Click;
begin
  inherited Click;
end;

procedure TNavButtonEh.Paint;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(TDBGridEhNavigatorPanel(Owner).Parent.Parent);
  ForegroundScaleFactor := Grid.ScaleFactor;
  inherited Paint;
end;

procedure TNavButtonEh.PaintBackground(out PaintRect: TRect; out PressOffset: TPoint; out ThemeDetails: TThemedElementDetails);
const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var
  DrawFlags: Integer;
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
begin
  Canvas.Font := Self.Font;

  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if FState in [bsPressedEh] then
        Button := tbPushButtonPressed
      else
        if MouseInControl then
          Button := tbPushButtonHot
        else
          Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
          Toolbutton := ttbButtonNormal;
      end;
    end;

    PaintRect := ClientRect;
    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
    end
    else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
    end;

    if Button = tbPushButtonPressed then
    begin
      
      if ToolButton <> ttbToolbarDontCare then
        Canvas.Font.Color := StyleServices.GetSystemColor(clHighlightText);
      PressOffset := Point(1, 0);
    end
    else
      PressOffset := Point(0, 0);

  end else 
  begin
    PaintRect := Rect(0, 0, Width, Height);
    if not Flat then
    begin
      DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
      if FState in [bsPressedEh] then
        DrawFlags := DrawFlags or DFCS_PUSHED;
      DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
    end
    else
    begin
      if (FState in [bsPressedEh]) or
        (MouseInControl and (FState <> bsDisabledEh)) or
        (csDesigning in ComponentState) then
        DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsPressedEh]],
          FillStyles[Transparent] or BF_RECT)
      else if not Transparent then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(PaintRect);
      end;
      InflateRect(PaintRect, -1, -1);
    end;
    if FState in [bsPressedEh] then
    begin
      PressOffset.X := 1;
      PressOffset.Y := 1;
    end
    else
    begin
      PressOffset.X := 0;
      PressOffset.Y := 0;
    end;
  end;

  ThemeDetails := Details;
end;

procedure TNavButtonEh.PaintForeground(PaintRect: TRect; PressOffset: TPoint; ThemeDetails: TThemedElementDetails);
var
  R: TRect;
  DrawImages: TCustomImageList;
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(TDBGridEhNavigatorPanel(Owner).Parent.Parent);

  if Enabled
    then DrawImages := Images
    else DrawImages := DisabledImages;

  if (DrawImages <> nil) then
    DrawClipped(DrawImages, nil, Canvas, PaintRect, ImageIndex,
      PressOffset.X, 0, taCenter, PaintRect, Round(Grid.ScaleFactor))
  else
    inherited PaintForeground(PaintRect, PressOffset, ThemeDetails);

  if (GetFocus = Parent.Handle) and
     (FIndex = TDBGridEhNavigatorPanel(Parent).FocusedButton) then
  begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsPressedEh then
      OffsetRect(R, 1, 1);
    Canvas.Brush.Style := bsSolid;
    Font.Color := clBtnShadow;
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

procedure TNavButtonEh.SetImageIndex(const Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Invalidate;
  end;
end;

procedure TNavButtonEh.SetDisabledImages(const Value: TCustomImageList);
begin
  FDisabledImages := Value;
end;

procedure TNavButtonEh.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TNavButtonEh.SetNavStyle(const Value: TNavButtonStyle);
begin
  if (FNavStyle <> Value) then
  begin
    FNavStyle := Value;
    if nsAllowTimer in FNavStyle
      then AutoRepeat := True
      else AutoRepeat := False;
  end;
end;

{ TNavDataLinkEh }

constructor TNavDataLinkEh.Create(ANav: TDBGridEhNavigatorPanel);
begin
  inherited Create;
  FNavigator := ANav;
  VisualControl := True;
end;

destructor TNavDataLinkEh.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TNavDataLinkEh.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;

procedure TNavDataLinkEh.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TNavDataLinkEh.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

{ TDBGridSearchPanelControlEh }

constructor TDBGridSearchPanelControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSearchResultFinished := True;
  FoundCells := -1;
end;

destructor TDBGridSearchPanelControlEh.Destroy;
begin
  FreeAndNil(FSearchResultThread);
  inherited Destroy;
end;

function TDBGridSearchPanelControlEh.CreateSearchPanelTextEdit: TSearchPanelTextEditEh;
begin
  Result := TDBGridSearchPanelTextEditEh.Create(Self);
end;

procedure TDBGridSearchPanelControlEh.BuildOptionsPopupMenu(
  var PopupMenu: TPopupMenu);
var
  Grid: TCustomDBGridEhCrack;
  i: Integer;
begin
  Grid := TCustomDBGridEhCrack(Owner);

  inherited BuildOptionsPopupMenu(PopupMenu);
  for i := PopupMenu.Items.Count-1 downto 0 do
    PopupMenu.Items.Delete(i);

  Grid.Center.BuildSearchPanelOptionsPopupMenu(Grid, PopupMenu);
end;

procedure TDBGridSearchPanelControlEh.MenuSearchScopesClick(
  Sender: TObject);
begin
end;

function TDBGridSearchPanelControlEh.CancelSearchFilterEnable: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := Grid.SearchPanelMode {or (Grid.FFilterObj <> nil)};
end;

function TDBGridSearchPanelControlEh.GetMasterControlSearchEditMode: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := Grid.SearchPanelMode;
end;

procedure TDBGridSearchPanelControlEh.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TDBGridSearchPanelControlEh.SetGetMasterControlSearchEditMode(Value: Boolean);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.SearchPanelMode := Value;
end;

procedure TDBGridSearchPanelControlEh.FindEditorUserChanged;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  inherited FindEditorUserChanged;
  TDBGridSearchPanelEhCrack(Grid.SearchPanel).InterSetSearchingText(FindEditor.Text);
  if Assigned(Grid.SearchPanel.OnSearchEditChange) then
    Grid.SearchPanel.OnSearchEditChange(Grid, TDBGridSearchPanelTextEditEh(Self.FindEditor));

  if FindEditor.Text = '' then
  begin
    if FilterEnabled and FilterOnTyping then
      ClearSearchFilter;
    UpdateFoundInfo;
  end else
  begin
    FindEditor.Repaint;
    if FilterEnabled and FilterOnTyping then
      ApplySearchFilter;
    Grid.SearchPanel.RestartFind(0);
    UpdateFoundInfo;
  end;
end;

procedure TDBGridSearchPanelControlEh.UpdateFoundInfo;
begin
{$IFDEF FPC_CROSSP}
  UpdateFoundInfoNoThread;
{$ELSE}
  UpdateFoundInfoInThread;
{$ENDIF}
end;

procedure TDBGridSearchPanelControlEh.UpdateFoundInfoNoThread;
var
  Grid: TCustomDBGridEhCrack;
  i, j: Integer;
  HitCount: Integer;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  if Grid.FIntMemTable = nil then Exit;
  if FindEditor.Text = '' then
  begin
    HitCount := -1;
  end else
  begin
    HitCount := 0;
    for i := 0 to Grid.FIntMemTable.InstantReadRowCount-1 do
    begin
      for j := 0 to Grid.VisibleColumns.Count-1 do
      begin
        HitCount := HitCount + GetHitCountAt(i, j);
      end;
    end;
  end;

  FoundCells := HitCount;
  RealignControls;
  Grid.Invalidate;
end;

procedure TDBGridSearchPanelControlEh.UpdateFoundInfoInThread;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  if FSearchResultThread <> nil then
  begin
    FSearchResultThread.Terminate;
    FSearchResultThread.WaitFor;
    FreeAndNil(FSearchResultThread);
  end;
  if FindEditor.Text = '' then
    UpdateFoundInfoNoThread
  else if Grid.FIntMemTable <> nil then
  begin
    FSearchResultFinished := False;
    FSearchResultThread := TSearchResultThread.Create(TCustomDBGridEhCrack(Owner));
    FSearchResultThread.OnTerminate := SearchResultThreadDone;
    TSearchResultThread(FSearchResultThread).OnUpdateHitCount := SearchResultThreadUpdateHitCount;
    {$IFDEF FPC}
    FSearchResultThread.{%H-}Resume;
    {$ELSE}
    FSearchResultThread.Resume;
    {$ENDIF}
  end;
end;

procedure TDBGridSearchPanelControlEh.SearchResultThreadDone(Sender: TObject);
begin
  FoundCells := TSearchResultThread(Sender).FoundCells;
  if FoundCells >= 0 then
  begin
    FSearchResultFinished := True;
    RealignControls;
    FindButtons[gnfbSearchInfoBoxEh].Invalidate;
  end;
end;

procedure TDBGridSearchPanelControlEh.SearchResultThreadUpdateHitCount(Sender: TObject);
begin
  FoundCells := TSearchResultThread(Sender).FoundCells;
  RealignControls;
  FindButtons[gnfbSearchInfoBoxEh].Invalidate;
end;

function TDBGridSearchPanelControlEh.GetHitCountAt(Row, Col: Integer): Integer;
var
  Grid: TCustomDBGridEhCrack;
  Column: TColumnEh;
  HasHit: Boolean;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.FIntMemTable.InstantReadEnter(Row);
  try
    Column := Grid.VisibleColumns[Col];
    HasHit := False;
    Grid.CheckCellHitSearchPanelData(Column, HasHit, Grid.SearchPanel.SearchingText);
    if HasHit
      then Result := 1
      else Result := 0;
  finally
    Grid.FIntMemTable.InstantReadLeave;
  end;
end;

procedure TDBGridSearchPanelControlEh.GetPaintColors(var FromColor, ToColor,
  HighlightColor: TColor);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.SetPaintColors;
  FromColor := Grid.FInternalColor;
  ToColor := Grid.FInternalFixedColor;
  if FindEditor.Focused then
  begin
    HighlightColor := StyleServices.GetSystemColor(clHighlight);
    FromColor := GetNearestColor(Canvas.Handle, LightenColorEh(Grid.FInternalColor, HighlightColor, True));
    ToColor := GetNearestColor(Canvas.Handle, LightenColorEh(Grid.FInternalColor, HighlightColor, True));
  end;
end;

procedure TDBGridSearchPanelControlEh.MasterControlCancelSearchEditorMode;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  TDBGridSearchPanelEhCrack(Grid.SearchPanel).InterSetSearchingText(FindEditor.Text);
  MasterControlSearchEditMode := False;
  ClearSearchFilter;
end;

function TDBGridSearchPanelControlEh.MasterControlFilterEnabled: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := Grid.SearchPanel.FilterEnabled;
end;

procedure TDBGridSearchPanelControlEh.MasterControlFindNext;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.SearchPanel.FindNext;
end;

procedure TDBGridSearchPanelControlEh.MasterControlFindPrev;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.SearchPanel.FindPrev;
end;

procedure TDBGridSearchPanelControlEh.MasterControlRestartFind;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.SearchPanel.RestartFind(0);
end;

procedure TDBGridSearchPanelControlEh.MasterControlProcessFindEditorKeyDown(
  var Key: Word; Shift: TShiftState);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  if Assigned(Grid.SearchPanel.OnSearchEditKeyDown) then
    Grid.SearchPanel.OnSearchEditKeyDown(Grid, TDBGridSearchPanelTextEditEh(FindEditor), Key, Shift);
end;

procedure TDBGridSearchPanelControlEh.MasterControlProcessFindEditorKeyPress(
  var Key: Char);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  if Assigned(Grid.SearchPanel.OnSearchEditKeyPress) then
    Grid.SearchPanel.OnSearchEditKeyPress(Grid, TDBGridSearchPanelTextEditEh(FindEditor), Key);
end;

procedure TDBGridSearchPanelControlEh.MasterControlProcessFindEditorKeyUp(
  var Key: Word; Shift: TShiftState);
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  if Assigned(Grid.SearchPanel.OnSearchEditKeyUp) then
    Grid.SearchPanel.OnSearchEditKeyUp(Grid, TDBGridSearchPanelTextEditEh(FindEditor), Key, Shift);
end;

procedure TDBGridSearchPanelControlEh.MasterControlApplySearchFilter;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.SetSearchFilter(FindEditor.Text);
end;

procedure TDBGridSearchPanelControlEh.ClearSearchFilter;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.ClearSearchFilter;
  UpdateFoundInfo;
end;

function TDBGridSearchPanelControlEh.GetBorderColor: TColor;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := Grid.GridLineParams.GetDarkColor;
end;

function TDBGridSearchPanelControlEh.GetFindEditorBorderColor: TColor;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := Grid.GridLineParams.GetDarkColor;
end;

procedure TDBGridSearchPanelControlEh.AcquireMasterControlFocus;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Grid.AcquireFocus;
end;

function TDBGridSearchPanelControlEh.CanPerformSearchActionInMasterControl: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := (Grid.DataSource <> nil) and (Grid.DataSource.State <> dsInactive);
end;

function TDBGridSearchPanelControlEh.FilterEnabled: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := Grid.SearchPanel.FilterEnabled;
end;

function TDBGridSearchPanelControlEh.FilterOnTyping: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := Grid.SearchPanel.FilterOnTyping;
end;

function TDBGridSearchPanelControlEh.IsOptionsButtonVisible: Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  Grid := TCustomDBGridEhCrack(Owner);
  Result := (Grid.SearchPanel.OptionsPopupMenuItems <> []);
end;

function TDBGridSearchPanelControlEh.CalcSearchInfoBoxWidth: Integer;
begin
  Result := 0;
  if not HandleAllocated then Exit;
  if FoundCells = -1 then
    Result := 0
  else
  begin
    Canvas.Font := Font;
    Result := Canvas.TextWidth({'1 of ' + }IntToStr(FoundCells)) + Canvas.TextWidth('0') * 2;
  end;
end;

function TDBGridSearchPanelControlEh.GetSearchInfoBoxText: String;
var
  resS: String;
begin
  if FSearchResultFinished then
    resS := IntToStr(FoundCells)
  else
    resS := '(' + IntToStr(FoundCells) + ')';

  if FoundCells = -1 then
    Result := ''
  else
    Result := resS;
end;

{ TSearchResultThread }

constructor TSearchResultThread.Create(Grid: TComponent);
var
  AGrid: TCustomDBGridEhCrack;
begin
  inherited Create(True);
  AGrid := TCustomDBGridEhCrack(Grid);
  FColCount := AGrid.VisibleColumns.Count;
  FRowCount := AGrid.FIntMemTable.InstantReadRowCount;
  FGrid := Grid;
  FoundCells := -1;
end;

procedure TSearchResultThread.Execute;
var
  i: Integer;
  HitCount: Integer;
  TickCount: LongWord;
begin
  HitCount := 0;
  TickCount := GetTickCountEh;
  for i := 0 to FRowCount-1 do
  begin
    if (GetTickCountEh - TickCount > 500) then
    begin
      FoundCells := HitCount;
      UpdateHitCount;
      TickCount := GetTickCountEh;
    end;
    HitCount := HitCount + GetHitCountAt(i, -1{j});
    if Terminated then
    begin
      FoundCells := -1;
      Exit;
    end;
  end;
  FoundCells := HitCount;
  ReturnValue := 1;
end;

function TSearchResultThread.GetHitCountAt(Row, Col: Integer): Integer;
begin
  FCurRow := Row;
  FDoGetHitCountAtResult := 0;
  Synchronize(DoGetHitCountAt);
  Result := FDoGetHitCountAtResult;
end;

procedure TSearchResultThread.DoGetHitCountAt;
var
  Grid: TCustomDBGridEhCrack;
  Column: TColumnEh;
  HasHit: Boolean;
  ci: Integer;

  function IsAnyKeyPress: Boolean;
  var
    Msg: TMsg;
  begin
    Result := False;
    if PeekMessage(Msg, GetFocus{AGrid.Handle}, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
      Result := True;
  end;

begin
  Grid := TCustomDBGridEhCrack(FGrid);
  if Grid.FIntMemTable = nil then Exit;
  if Grid.FIntMemTable.InstantReadRowCount <= FCurRow then Exit;
  if IsAnyKeyPress then Terminate;

  Grid.FIntMemTable.InstantReadEnter(FCurRow);
  try
    FDoGetHitCountAtResult := 0;

    for ci := 0 to Grid.VisibleColumns.Count-1 do
    begin
      Column := Grid.VisibleColumns[ci];
      HasHit := False;
      Grid.CheckCellHitSearchPanelData(Column, HasHit, Grid.SearchPanel.SearchingText);
      if HasHit then
        FDoGetHitCountAtResult := FDoGetHitCountAtResult + 1;
    end;
  finally
    Grid.FIntMemTable.InstantReadLeave;
  end;
end;

procedure TSearchResultThread.DoUpdateHitCount;
begin
  if Assigned(OnUpdateHitCount) then
    OnUpdateHitCount(Self);
end;

procedure TSearchResultThread.UpdateHitCount;
begin
  Synchronize(DoUpdateHitCount);
end;

{ TDBGridTitleDragWin }

var
  _titleDragWin: TDBGridTitleDragWin;

constructor TDBGridTitleDragWin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMovePoint := TDBGridMovePointEh.Create(Self);
  FMovePoint.Left := 7;
  FMovePoint.Top := 4;
  FMovePointPos := 5;
  FMovePointSize := 4;

  AlphaBlendValue := 255;

  {$IFDEF FPC}
  {$ELSE}
  TransparentColorValue := clNone;
  {$ENDIF}

  DoubleBuffered := not DBGridEhDebugDraw;
  ControlStyle := ControlStyle - [csOpaque];
  Color := clWindow;
end;

destructor TDBGridTitleDragWin.Destroy;
begin
  FreeAndNil(FMovePoint);
  inherited Destroy;
end;

procedure TDBGridTitleDragWin.Paint;
var
  Column: TColumnEh;
  GroupRect, AFillRect: TRect;
  The3DRect: Boolean;
  ADrawByThemes: Boolean;
  ATitleState: TDBGridDrawTitleCellParamsEh;
  AFrameRect: TRect;
  Grid: TCustomDBGridEhCrack;
begin
  Column := (FDrawObject as TColumnTitleEh).Column;
  Grid := TCustomDBGridEhCrack(Column.Grid);
  The3DRect := dghFixed3D in Grid.OptionsEh;
  ADrawByThemes := ThemesEnabled and (Grid.TitleParams.GetActualFillStyle = cfstThemedEh);

  GroupRect := ClientRect;

  Canvas.Brush.Color := Grid.GridLineParams.GetDarkColor;
  AFrameRect := GroupRect;
  if UseRightToLeftAlignment then
    SwapInt(AFrameRect.Left, AFrameRect.Right);
  Canvas.FrameRect(AFrameRect);
  Canvas.Brush.Color := Color;

  AFillRect := GroupRect;
  InflateRect(AFillRect, -1, -1);

  ATitleState :=  TDBGridDrawTitleCellParamsEh.Create;
  ATitleState.InitParams(Column, nil);
  ATitleState.WordWrap := (Grid.UseMultiTitle = True) or
                          (Grid.TitleHeight <> 0) or
                          (Grid.TitleLines <> 0);
  ATitleState.Orientation := tohHorizontal;
  ATitleState.Draw3DBorder := The3DRect;
  ATitleState.DrawByThemes := ADrawByThemes;
  ATitleState.DrawByThemesOverLines := ATitleState.DrawByThemes and
    (Grid.Style.ThemeTitleFillElement = gtfeSplitButtonEh);
  ATitleState.Color := Column.Title.Color;
  ATitleState.SecondColor := Grid.TitleParams.SecondColor;
  ATitleState.DrawFilterButton := Grid.STFilter.Visible and (Grid.STFilter.Location = stflInTitleFilterEh);
  ATitleState.CellMultiSelected := False;
  ATitleState.SortMarker := Column.Title.SortMarker;
  ATitleState.DrawSortIndex := False;
  ATitleState.Font.Assign(Font);
  ATitleState.VertBorderInFillStyle := False;
  ATitleState.HorzBorderInFillStyle := False;
  ATitleState.Layout := tlCenter;

  if (Grid.UseMultiTitle) then
    ATitleState.Text := Grid.LeafFieldArr[Column.Index].FLeaf.Text
  else
    ATitleState.Text := Column.Title.Caption;

  ATitleState.CellState := [gdFixed];

  if Grid.UseRightToLeftAlignment then ChangeCanvasOrientation(True);
  Grid.DefaultDrawTitleCell(Canvas, AFillRect, ATitleState);
  if Grid.UseRightToLeftAlignment then ChangeCanvasOrientation(False);

  Canvas.Brush.Color := cl3DDkShadow;
  Canvas.FrameRect(Rect(0,0, Width, Height));

  FreeAndNil(ATitleState);

  PaintSelectedColumnsMarker()
end;

procedure TDBGridTitleDragWin.PaintSelectedColumnsMarker();
var
  Column: TColumnEh;
  selCount: Integer;
  s: String;
  size: TSize;
  colsRect: TRect;
  cliRect: TRect;
begin
  Column := (FDrawObject as TColumnTitleEh).Column;
  if Column <> nil then
    selCount := Column.Grid.Selection.Columns.Count
  else
    selCount := 0;

  if (selCount > 0) then
  begin
    cliRect := ClientRect;

    s := IntToStr(selCount);
    Canvas.Font.Size := 6;

    size := Canvas.TextExtent(s);
    size.cx := size.cx + 4;
    size.cy := size.cy + 2;

    colsRect := Rect(0, 0, size.cx, size.cy);

    MoveRect(colsRect, RectWidth(cliRect) - size.cx - 2, 2);

    Canvas.Brush.Color := cl3DDkShadow;
    Canvas.FrameRect(colsRect);

    colsRect.Left := colsRect.Left + 1;
    colsRect.Top := colsRect.Top + 1;
    colsRect.Right := colsRect.Right - 1;
    colsRect.Bottom := colsRect.Bottom - 1;
    Canvas.Brush.Color := clWindow;
    Canvas.FillRect(colsRect);

    WriteTextEh(Canvas, colsRect, False, 0, 0, s, taCenter, tlCenter, False, False, 0, 0, False, False);
  end;
end;

class function TDBGridTitleDragWin.GetTitleDragWin(): TDBGridTitleDragWin;
begin
  if (_titleDragWin = nil) then
  begin
    _titleDragWin := TDBGridTitleDragWin.Create(Application);
  end;

  Result := _titleDragWin;
end;

procedure TDBGridTitleDragWin.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if CheckWin32Version(5, 1) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
  {$ENDIF}
end;

procedure TDBGridTitleDragWin.CMShowingChanged(var Message: TMessage);
var
  ColTitle: TColumnTitleEh;
begin
  inherited;
  UpdateMovePointPos();
  FMovePoint.ForePaintColor := cl3DDkShadow;

  ColTitle := (FDrawObject as TColumnTitleEh);
  if (ColTitle <> nil) then
  begin
    FMovePoint.BackPaintColor := ColTitle.Color;
  end;

  FMovePoint.LineColor := cl3DDkShadow;
end;

procedure TDBGridTitleDragWin.UpdateMovePointPos();
var
  scMovePoint: TPoint;
begin
  scMovePoint := Point(FMovePointPos, Top + Height);
  scMovePoint.X := scMovePoint.X - 3;
  FMovePoint.SetBounds(scMovePoint.X, scMovePoint.Y, FMovePoint.Width, FMovePointSize + 5);
  FMovePoint.Visible := Visible;
end;

procedure TDBGridTitleDragWin.StartShow(drawObject: TObject;
  pos: TPoint; width: Integer; height: Integer; movePointPos: Integer; moveSize: Integer);
begin
  FMovePointPos := movePointPos;
  FMovePointSize := moveSize;
  FDrawObject := drawObject;

  inherited StartShow(pos, width, height);
end;

procedure TDBGridTitleDragWin.StartShowAnimated(ADrawObject: TObject;
  ASourceBounds: TRect;
  APos: TPoint;  AWidth : Integer; AHeight: Integer;
  AMovePointPos: Integer; AMoveSize: Integer);
var
  StartTime: Int64;
  CurTime: Int64;
  FinishTime: Int64;
  StepBounds: TRect;
  Factor: Double;
  ColTitle: TColumnTitleEh;
  Grid: TCustomDBGridEhCrack;
begin
  ColTitle := (ADrawObject as TColumnTitleEh);
  Grid := TCustomDBGridEhCrack(ColTitle.Column.Grid);

  FMovePointPos := AMovePointPos;
  FMovePointSize := AMoveSize;
  FDrawObject := ADrawObject;

  StartTime := GetTickCountEh;
  CurTime := GetTickCountEh;
  FinishTime := StartTime + Grid.Style.TitleStartColumnMovingAnimationTime;

  AlphaBlendValue := 0;
  inherited StartShow(APos, AWidth, AHeight);
  Repaint;
  while CurTime < FinishTime do
  begin
    Factor := (CurTime - StartTime) / (FinishTime - StartTime);
    StepBounds.TopLeft := ApproximatePoint(ASourceBounds.TopLeft, APos, Factor);
    StepBounds.BottomRight := ApproximatePoint(ASourceBounds.BottomRight, Point(APos.X + AWidth, APos.Y + AHeight) , Factor);
    SetBounds(StepBounds.Left, StepBounds.Top, RectWidth(StepBounds), RectHeight(StepBounds), FMovePointPos, FMovePointSize);
    AlphaBlendValue := Trunc(255 * Factor);

    Repaint;

    CurTime := GetTickCountEh;
  end;

  SetBounds(APos.X, APos.Y, AWidth, AHeight, FMovePointPos, FMovePointSize);
  AlphaBlendValue := 255;
  Repaint;
end;

procedure TDBGridTitleDragWin.HideAnimated(ATargetBounds: TRect);
var
  StartTime: LongWord;
  CurTime: LongWord;
  FinishTime: LongWord;
  StepBounds: TRect;
  Factor: Double;
  ASourceBounds: TRect;
  ColTitle: TColumnTitleEh;
  Grid: TCustomDBGridEhCrack;
begin
  ColTitle := (FDrawObject as TColumnTitleEh);
  Grid := TCustomDBGridEhCrack(ColTitle.Column.Grid);

  StartTime := GetTickCountEh;
  CurTime := GetTickCountEh;
  FinishTime := StartTime + Grid.Style.TitleFinishColumnMovingAnimationTime;

  ASourceBounds := BoundsRect;

  AlphaBlendValue := 0;

  while CurTime < FinishTime do
  begin
    Factor := (CurTime - StartTime) / (FinishTime - StartTime);
    StepBounds.TopLeft := ApproximatePoint(ASourceBounds.TopLeft, ATargetBounds.TopLeft, Factor);
    StepBounds.BottomRight := ApproximatePoint(ASourceBounds.BottomRight, ATargetBounds.BottomRight , Factor);
    SetBounds(StepBounds.Left, StepBounds.Top, RectWidth(StepBounds), RectHeight(StepBounds), FMovePointPos, FMovePointSize);
    AlphaBlendValue := Trunc(255 * (1 - Factor));

    Repaint;

    CurTime := GetTickCountEh;
  end;

  Hide();
  AlphaBlendValue := 255;
end;

procedure TDBGridTitleDragWin.SetBounds(x: Integer; y: Integer;
  width: Integer; height: Integer; movePointPos: Integer; moveSize: Integer);
var
  OldLeft, OltTop: Integer;
begin
  OldLeft := Left;
  OltTop := Top;
  FMovePointPos := movePointPos;
  FMovePointSize := moveSize;
  UpdateMovePointPos();

  inherited SetBounds(x, y, width, height);
  if (OldLeft <> Left) or (OltTop <> Top) then
    Invalidate();
end;

procedure TDBGridTitleDragWin.ChangeCanvasOrientation(RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth,0);
    Ext := Point(-1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end
  else
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;
end;

{ TDBGridMovePointEh }

constructor TDBGridMovePointEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AlphaBlendValue := 255;
  {$IFDEF FPC}
  {$ELSE}
  TransparentColorValue := clWhite;
  TransparentColor := True;
  {$ENDIF}
end;

procedure TDBGridMovePointEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if CheckWin32Version(5, 1) then
    Params.WindowClass.Style := Params.WindowClass.Style and not CS_DROPSHADOW;
  {$ENDIF}
end;

destructor TDBGridMovePointEh.Destroy;
begin
  inherited Destroy;
end;

procedure TDBGridMovePointEh.Paint;
begin
  Canvas.Pen.Color := ForePaintColor;

  Canvas.Polyline([Point(0, 0), Point(7, 0)]);
  Canvas.Polyline([Point(1, 1), Point(6, 1)]);
  Canvas.Polyline([Point(2, 2), Point(5, 2)]);
  Canvas.Polyline([Point(3, 3), Point(4, 3)]);

  Canvas.Polyline([Point(3, 4), Point(3, ClientHeight)]);
end;

procedure TDBGridMovePointEh.CreateWnd;
{$IFDEF FPC_CROSSP}
var
  ABitmap: TBitmap;
  {$ELSE}
  {$ENDIF}
begin
  inherited CreateWnd;

  {$IFDEF FPC_CROSSP}
  ABitmap := TBitmap.Create;

  ABitmap.Monochrome := True;
  ABitmap.Width := Width;
  ABitmap.Height := Height;

  ABitmap.Canvas.Brush.Color := clBlack;
  ABitmap.Canvas.FillRect(0, 0, ABitmap.Width, ABitmap.Height);

  ABitmap.Canvas.Pen.Color := clWhite;
  ABitmap.Canvas.Polyline([Point(0, 0), Point(7, 0)]);
  ABitmap.Canvas.Polyline([Point(1, 1), Point(6, 1)]);
  ABitmap.Canvas.Polyline([Point(2, 2), Point(5, 2)]);
  ABitmap.Canvas.Polyline([Point(3, 3), Point(4, 3)]);
  SetShape(ABitmap);

  ABitmap.Free;
  {$ELSE}
  {$ENDIF}
end;

initialization
  InitRes;
finalization
  FinRes;
end.
