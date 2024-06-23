{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{     TDBLookupGridEh, TPopupDataGridEh components      }
{                                                       }
{      Copyright (c) 2002-2022 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBLookupGridsEh;

interface

uses
  Messages,
  {$IFDEF EH_LIB_17} System.Generics.Collections, System.UITypes, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, DBGridsEh, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, Mask, StdCtrls, DBGridEh, Windows, UxTheme,
  {$ENDIF}
  Variants, Themes, SysUtils, Classes, Controls, Contnrs,
  GridsEh,
  DBAxisGridsEh,
  ToolCtrlsEh,
  DB, Graphics, Forms;

type

  TDBLookupGridEh = class;

{ TLookupGridDataLinkEh }

  TLookupGridDataLinkEh = class(TDataLink)
  private
    FDBLookupGrid: TDBLookupGridEh;
  protected
    procedure ActiveChanged; override;
{$IFDEF CIL}
    procedure FocusControl(const Field: TField); override;
{$ELSE}
    procedure FocusControl(Field: TFieldRef); override;
{$ENDIF}
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create;
  end;

{ TGridColumnSpecCellEh }

  TGridColumnSpecCellEh = class(TPersistent)
  private
    FOwner: TPersistent;
    FFont: TFont;
    FColor: TColor;
    FText: String;
    FImageIndex: Integer;

    function GetColor: TColor;
    function GetFont: TFont;
    function GetText: String;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsTextStored: Boolean;

    procedure FontChanged(Sender: TObject);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetText(const Value: String);

  protected
    FColorAssigned: Boolean;
    FFontAssigned: Boolean;
    FTextAssigned: Boolean;

    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultText: String;
    function GetOwner: TPersistent; override;

  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

  published
    property Text: String read GetText write SetText stored IsTextStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property ImageIndex: Integer read FImageIndex write FImageIndex default -1;
  end;

{ TDBLookupGridColumnEh }

  TDBLookupGridColumnEh = class(TColumnEh)
  private
    FSpecCell: TGridColumnSpecCellEh;
    function GetGrid: TDBLookupGridEh;
    procedure SetSpecCell(const Value: TGridColumnSpecCellEh);

  protected
    procedure SetWidth(const Value: Integer); override;
    procedure SetIndex(Value: Integer); override;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Grid: TDBLookupGridEh read GetGrid;

  published
    property Alignment;
    property AutoFitColWidth;
    property Checkboxes;
    property Color;
    property EndEllipsis;
    property FieldName;
    property Font;
    property ImageList;
  {$IFDEF FPC}
  {$ELSE}
    property ImeMode;
    property ImeName;
  {$ENDIF}
    property KeyList;
    property MaxWidth;
    property MinWidth;
    property NotInKeyListIndex;
    property PickList;
    property PopupMenu;
    property ShowImageAndText;
    property SpecCell: TGridColumnSpecCellEh read FSpecCell write SetSpecCell;
    property Tag;
    property Title;
    property ToolTips;
    property Visible;
    property Width;
    property OnGetCellParams; 
  end;

{ TDBLookupGridColumnDefValuesEh}

  TDBLookupGridColumnDefValuesEh = class(TColumnDefValuesEh)
  published
    property EndEllipsis;
    property Title;
    property ToolTips;
  end;

{ TDBLookupGridEh }

  TDBLookupGridEh = class(TCustomDBGridEh)
  private
    FDataFieldName: string;
    FDataFields: TFieldsArrEh;
    FDataLink: TLookupGridDataLinkEh;
    FHasFocus: Boolean;
    FKeyFieldName: string;
    FKeyFields: TFieldsArrEh;
    FKeyRowVisible: Boolean;
    FKeySelected: Boolean;
    FKeyValue: Variant;
    FListActive: Boolean;
    FListField: TField;
    FListFieldIndex: Integer;
    FListFieldName: string;
    FListFields: TFieldListEh;
    FLockPosition: Boolean;
    FLookupMode: Boolean;
    FLookupSource: TDataSource;
    FMasterFieldNames: string;
    FMasterFields: TFieldsArrEh;
    FMousePos: Integer;
    FOptions: TDBLookupGridEhOptions;
    FPopup: Boolean;
    FRecordCount: Integer;
    FRecordIndex: Integer;
    FRowCount: Integer;
    FSearchText: string;
    FSelectedItem: string;
    FSpecRow: TSpecRowEh;

    function GetAutoFitColWidths: Boolean;
    function GetDataField: TField;
    function GetDataSource: TDataSource;
    function GetKeyFieldName: string;
    function GetListLink: TAxisGridDataLinkEh;
    function GetListSource: TDataSource;
    function GetReadOnly: Boolean;
    function GetShowTitles: Boolean;
    function GetTitleRowHeight: Integer;
    function GetUseMultiTitle: Boolean;

    procedure CheckNotCircular;
    procedure CheckNotLookup;
    procedure DataLinkRecordChanged(Field: TField);
    procedure SelectItemAt(X, Y: Integer);
    procedure SelectSpecRow;
    procedure SetAutoFitColWidths(const Value: Boolean);
    procedure SetDataFieldName(const Value: string);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldName(const Value: string);
    procedure SetListSource(Value: TDataSource);
    procedure SetLookupMode(Value: Boolean);
    procedure SetOptions(const Value: TDBLookupGridEhOptions);
    procedure SetReadOnly(Value: Boolean);
    procedure SetRowCount(Value: Integer);
    procedure SetShowTitles(const Value: Boolean);
    procedure SetSpecRow(const Value: TSpecRowEh);
    procedure SetUseMultiTitle(const Value: Boolean);

    {$IFDEF FPC}
    {$ELSE}
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
    {$ENDIF}
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

  protected
    FHighlightTextParams: TGridHighlightTextParamsEh;
    FInrenalListDataChanging: Integer;
    FInternalHeightSetting: Boolean;
    FInternalWidthSetting: Boolean;
    FLGAutoFitColWidths: Boolean;
    FSpecRowHeight: Integer;

    function CanDrawFocusRowRect: Boolean; override;
    {$IFDEF FPC}
    {$ELSE}
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    {$ENDIF}
    function CellHave3DRect(ACol, ARow: Longint; AState: TGridDrawState): Boolean; override;
    function CreateAxisBarDefValues: TAxisBarDefValuesEh; override;
    function CreateAxisBars: TGridAxisBarsEh; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function ExtendedScrolling: Boolean; override;
    function GetDefaultActualColumnFontColor(Column: TColumnEh; AState: TGridDrawState): TColor; override;
    function GetSubTitleRows: Integer; override;

    function CanModify: Boolean; virtual;
    function CompatibleVarValue(AFieldsArr: TFieldsArrEh; AVlaue: Variant): Boolean; virtual;
    function GetBorderSize: Integer; virtual;
    function GetDataRowHeight: Integer; virtual;
    function GetKeyIndex: Integer;
    function GetSpecRowHeight: Integer; virtual;

    procedure ColWidthsChanged; override;
    procedure CreateWnd; override;
    procedure DataChanged; override;
    procedure DefineFieldMap; override;
    procedure DrawSubTitleCell(ACol, ARow: Longint;  DataCol, DataRow: Integer; CellType: TCellAreaTypeEh; ARect: TRect; AState: TGridDrawState; var Highlighted: Boolean); override;
    procedure GetDataForVertScrollBar(var APosition, AMin, AMax, APageSize: Integer); override;
    procedure GetDatasetFieldList(FieldList: TObjectList); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure LayoutChanged; override;
    procedure LinkActive(Value: Boolean); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetDataSource(Value: TDataSource); reintroduce;
    procedure Scroll(Distance: Integer); override;
    procedure TimerScroll; override;
    procedure UpdateActive; override;
    procedure UpdateRowCount; override;
    procedure VertScrollBarMessage(ScrollCode, Pos: Integer); override;

    procedure BeginInrenalListDataChanging;
    procedure EndInrenalListDataChanging;
    procedure KeyValueChanged; virtual;
    procedure ListLinkDataChanged; virtual;
    procedure ProcessSearchKey(Key: Char); virtual;
    procedure SelectKeyValue(const Value: Variant); virtual;
    procedure SetColResizedControlWidth(NewControlWidth: Integer); virtual;
    procedure SpecRowChanged(Sender: TObject); virtual;
    procedure UpdateColumnsList; virtual;
    procedure UpdateDataFields; virtual;
    procedure UpdateListFields; virtual;
    procedure UpdateSelectedItem(KeyLocated: Boolean); virtual;

    property ParentColor default False;
    property TitleRowHeight: Integer read GetTitleRowHeight;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DataRect: TRect;
    function GetColumnsWidthToFit: Integer;
    function HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string; AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean; override;
    function InrenalListDataChanging: Boolean; virtual;
    function LocateKey: Boolean; virtual;
    function AutoHeight: Boolean; virtual;
    function AdjustHeight(OfferedHeight: Integer): Integer; virtual;
    function CalcAutoHeightForRowCount(NewRowCount: Integer): Integer; virtual;

    procedure HighlightLookupGridCellColor(DataCol, DataRow: Integer; Selected: Boolean; const Value: string; AState: TGridDrawState; var AColor: TColor; AFont: TFont); virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SelectCurrent;

    property AutoFitColWidths: Boolean read GetAutoFitColWidths write SetAutoFitColWidths;
    property Color;
    property DataField: string read FDataFieldName write SetDataFieldName;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Field: TField read GetDataField;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property KeyValue: Variant read FKeyValue write SetKeyValue;
    property ListActive: Boolean read FListActive;
    property ListField: string read FListFieldName write SetListFieldName;
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0;
    property ListFields: TFieldListEh read FListFields;
    property ListLink: TAxisGridDataLinkEh read GetListLink;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property Options: TDBLookupGridEhOptions read FOptions write SetOptions default [dlgColLinesEh];
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property SearchText: string read FSearchText write FSearchText;
    property SelectedItem: String read FSelectedItem;
    property SpecRow: TSpecRowEh read FSpecRow write SetSpecRow;
    property ShowTitles: Boolean read GetShowTitles write SetShowTitles;
    property RowCount: Integer read FRowCount write SetRowCount stored False;
    property UseMultiTitle: Boolean read GetUseMultiTitle write SetUseMultiTitle;

    property OnClick;
    property OnColumnMoved;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF EH_LIB_10}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
{$IFDEF FPC}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDrag;
  end;

{ TPopupInnerDataGridEh }

  TPopupInnerDataGridEh = class(TDBLookupGridEh)
  private
    FOnMouseCloseUp: TCloseUpEventEh;
    FOnUserKeyValueChange: TNotifyEvent;
    FSizeGripResized: Boolean;
    FUserKeyValueChanged: Boolean;
    FKeySelection: Boolean;

    {$IFDEF FPC}
    {$ELSE}
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    {$ENDIF}
    procedure CMSetSizeGripChangePosition(var Message: TMessage); message cm_SetSizeGripChangePosition;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

  protected
    {$IFDEF FPC}
    {$ELSE}
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    {$ENDIF}
    procedure DrawBorder; override;
    procedure KeyValueChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure UpdateBorderWidth;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Focused: Boolean; override;
    function CanFocus: Boolean; override;
    function AutoHeight: Boolean; override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure ResetHighlightSubstr(const Text: String; AllColumns: Boolean);
    procedure SetColResizedControlWidth(NewControlWidth: Integer); override;
  {$IFDEF FPC}
  {$ELSE}
    property Ctl3D;
    property ParentCtl3D;
  {$ENDIF}
    property SizeGripAlwaysShow;
    property SizeGripResized: Boolean read FSizeGripResized write FSizeGripResized;
    property OnDrawColumnCell;
    property OnUserKeyValueChange: TNotifyEvent read FOnUserKeyValueChange write FOnUserKeyValueChange;
    property OnMouseCloseUp: TCloseUpEventEh read FOnMouseCloseUp write FOnMouseCloseUp;
    property VisibleRowCount;
  end;

{ TPopupDataGridBoxEh }

  TPopupDataGridBoxEh = class(TPopupInactiveFormEh)
  private
    FInnerDataGrid: TPopupInnerDataGridEh;
    FMouseWheelInInnerDataGrid: Boolean;
    function GetAutoFitColWidths: Boolean;
    function GetAxisBarOwner: TPersistent;
    function GetDrawMemoText: Boolean;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetListFieldIndex: Integer;
    function GetListFieldName: string;
    function GetListFields: TFieldListEh;
    function GetListLink: TAxisGridDataLinkEh;
    function GetListSource: TDataSource;
    function GetOnColumnMoved: TMovedEvent;
    function GetOnMouseCloseUp: TCloseUpEventEh;
    function GetOnUserKeyValueChange: TNotifyEvent;
    function GetOptions: TDBLookupGridEhOptions;
    function GetReadOnly: Boolean;
    function GetRowCount: Integer;
    function GetSearchText: string;
    function GetSelectedItem: String;
    function GetShowTitles: Boolean;
    function GetSizeGripAlwaysShow: Boolean;
    function GetSizeGripResized: Boolean;
    function GetSpecRow: TSpecRowEh;
    function GetTitleParams: TDBGridTitleParamsEh;
    function GetUseMultiTitle: Boolean;

    procedure SetAutoFitColWidths(AValue: Boolean);
    procedure SetAxisBarOwner(AValue: TPersistent);
    procedure SetDrawMemoText(AValue: Boolean);
    procedure SetKeyFieldName(AValue: string);
    procedure SetKeyValue(AValue: Variant);
    procedure SetListFieldIndex(AValue: Integer);
    procedure SetListFieldName(AValue: string);
    procedure SetListSource(AValue: TDataSource);
    procedure SetOnColumnMoved(AValue: TMovedEvent);
    procedure SetOnMouseCloseUp(AValue: TCloseUpEventEh);
    procedure SetOnUserKeyValueChange(AValue: TNotifyEvent);
    procedure SetOptions(AValue: TDBLookupGridEhOptions);
    procedure SetReadOnly(AValue: Boolean);
    procedure SetRowCount(AValue: Integer);
    procedure SetSearchText(AValue: string);
    procedure SetShowTitles(AValue: Boolean);
    procedure SetSizeGripAlwaysShow(AValue: Boolean);
    procedure SetSizeGripResized(AValue: Boolean);
    procedure SetSpecRow(AValue: TSpecRowEh);
    procedure SetTitleParams(AValue: TDBGridTitleParamsEh);
    procedure SetUseMultiTitle(AValue: Boolean);

    procedure CMMouseWheel(var Message: TMessage); message CM_MOUSEWHEEL;

  protected
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;

  public
    constructor Create(Owner: TComponent); override;

    function CalcAutoHeightForRowCount(ARowCount: Integer): Integer;
    function DataRect: TRect;
    function GetColumnsWidthToFit: Integer;
    function InrenalListDataChanging: Boolean; virtual;
    function LocateKey: Boolean; virtual;

    procedure HandleNeeded;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure StartInitSize;
    procedure StopInitSize;

    procedure ResetHighlightSubstr(const Text: String; AllColumns: Boolean);
    procedure SetColResizedControlWidth(NewControlWidth: Integer); virtual;

    property InnerDataGrid: TPopupInnerDataGridEh read FInnerDataGrid;

    property AutoFitColWidths: Boolean read GetAutoFitColWidths write SetAutoFitColWidths;
    property SpecRow: TSpecRowEh read GetSpecRow write SetSpecRow;
    property RowCount: Integer read GetRowCount write SetRowCount;
    property ShowTitles: Boolean read GetShowTitles write SetShowTitles;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property ListField: string read GetListFieldName write SetListFieldName;
    property ListFieldIndex: Integer read GetListFieldIndex write SetListFieldIndex;
    property ListFields: TFieldListEh read GetListFields;
    property ListLink: TAxisGridDataLinkEh read GetListLink;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property Options: TDBLookupGridEhOptions read GetOptions write SetOptions;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property SearchText: string read GetSearchText write SetSearchText;
    property SelectedItem: String read GetSelectedItem;
    property UseMultiTitle: Boolean read GetUseMultiTitle write SetUseMultiTitle;
    property TitleParams: TDBGridTitleParamsEh read GetTitleParams write SetTitleParams;
    property SizeGripAlwaysShow: Boolean read GetSizeGripAlwaysShow write SetSizeGripAlwaysShow;
    property SizeGripResized: Boolean read GetSizeGripResized write SetSizeGripResized;
    property DrawMemoText: Boolean read GetDrawMemoText write SetDrawMemoText;
    property AxisBarOwner: TPersistent read GetAxisBarOwner write SetAxisBarOwner;

    property OnColumnMoved: TMovedEvent read GetOnColumnMoved write SetOnColumnMoved;
    property OnMouseCloseUp: TCloseUpEventEh read GetOnMouseCloseUp write SetOnMouseCloseUp;
    property OnUserKeyValueChange: TNotifyEvent read GetOnUserKeyValueChange write SetOnUserKeyValueChange;

  end;

{$IFDEF EH_LIB_16}
{ TPopupDataGridEhStyleHook }

  TPopupDataGridEhStyleHook = class(TScrollingStyleHook)
  strict private
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
  end;
{$ENDIF}

implementation

uses
  {$IFDEF FPC}
  {$ELSE}
    DbConsts, VDBConsts,
  {$ENDIF}
  Clipbrd, Types;

const
{$IFDEF EH_LIB_10}
  MemoTypes = [ftMemo, ftWideMemo, ftOraClob];
{$ELSE}
  MemoTypes = [ftMemo, ftOraClob];
{$ENDIF}

{$IFDEF FPC_CROSSP}
{$ELSE}
var
  SearchTickCount: Integer = 0;
{$ENDIF}

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

{ TPopupDataGridBoxEh }

constructor TPopupDataGridBoxEh.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FInnerDataGrid := TPopupInnerDataGridEh.Create(Self);
  FInnerDataGrid.Parent := Self;
  FInnerDataGrid.Align := alClient;
  FInnerDataGrid.ParentColor := True;
  MasterActionsControl := FInnerDataGrid;
end;

procedure TPopupDataGridBoxEh.StartInitSize;
begin
  FInnerDataGrid.Align := alNone;
  FInnerDataGrid.Top := 0;
  FInnerDataGrid.Left := 0;
end;

procedure TPopupDataGridBoxEh.StopInitSize;
begin
  Height := FInnerDataGrid.Height;
  FInnerDataGrid.Align := alClient;
end;

function TPopupDataGridBoxEh.DataRect: TRect;
begin
  Result := InnerDataGrid.DataRect;
end;

function TPopupDataGridBoxEh.GetColumnsWidthToFit: Integer;
begin
  Result := InnerDataGrid.GetColumnsWidthToFit;
end;

function TPopupDataGridBoxEh.InrenalListDataChanging: Boolean;
begin
  Result := InnerDataGrid.InrenalListDataChanging;
end;

function TPopupDataGridBoxEh.LocateKey: Boolean;
begin
  Result := InnerDataGrid.LocateKey;
end;

procedure TPopupDataGridBoxEh.ResetHighlightSubstr(const Text: String; AllColumns: Boolean);
begin
  InnerDataGrid.ResetHighlightSubstr(Text, AllColumns);
end;

function TPopupDataGridBoxEh.GetListFields: TFieldListEh;
begin
  Result := InnerDataGrid.ListFields;
end;

function TPopupDataGridBoxEh.GetListLink: TAxisGridDataLinkEh;
begin
  Result := InnerDataGrid.ListLink;
end;


function TPopupDataGridBoxEh.GetKeyFieldName: string;
begin
  Result := InnerDataGrid.KeyField;
end;

procedure TPopupDataGridBoxEh.SetKeyFieldName(AValue: string);
begin
  InnerDataGrid.KeyField := AValue;
end;

function TPopupDataGridBoxEh.GetKeyValue: Variant;
begin
  Result := InnerDataGrid.KeyValue;
end;

procedure TPopupDataGridBoxEh.SetKeyValue(AValue: Variant);
begin
  InnerDataGrid.KeyValue := AValue;
end;

function TPopupDataGridBoxEh.GetListFieldIndex: Integer;
begin
  Result := InnerDataGrid.ListFieldIndex;
end;

procedure TPopupDataGridBoxEh.SetListFieldIndex(AValue: Integer);
begin
  InnerDataGrid.ListFieldIndex := AValue;
end;

function TPopupDataGridBoxEh.GetListSource: TDataSource;
begin
  Result := InnerDataGrid.ListSource;
end;

function TPopupDataGridBoxEh.GetSelectedItem: String;
begin
  Result := InnerDataGrid.SelectedItem;
end;

procedure TPopupDataGridBoxEh.SetListSource(AValue: TDataSource);
begin
  InnerDataGrid.ListSource := AValue;
end;

function TPopupDataGridBoxEh.GetOptions: TDBLookupGridEhOptions;
begin
  Result := InnerDataGrid.Options;
end;

procedure TPopupDataGridBoxEh.SetOptions(AValue: TDBLookupGridEhOptions);
begin
  InnerDataGrid.Options := AValue;
end;

function TPopupDataGridBoxEh.GetRowCount: Integer;
begin
  Result := InnerDataGrid.RowCount;
end;

procedure TPopupDataGridBoxEh.SetRowCount(AValue: Integer);
begin
  if AValue < 1 then AValue := 1;
  if AValue > 100 then AValue := 100;
  Height := InnerDataGrid.CalcAutoHeightForRowCount(AValue);
end;

function TPopupDataGridBoxEh.GetSearchText: string;
begin
  Result := InnerDataGrid.SearchText;
end;

procedure TPopupDataGridBoxEh.SetSearchText(AValue: string);
begin
  InnerDataGrid.SearchText := AValue;
end;

function TPopupDataGridBoxEh.GetShowTitles: Boolean;
begin
  Result := InnerDataGrid.ShowTitles;
end;

procedure TPopupDataGridBoxEh.SetShowTitles(AValue: Boolean);
begin
  InnerDataGrid.ShowTitles := AValue;
end;

function TPopupDataGridBoxEh.GetSpecRow: TSpecRowEh;
begin
  Result := InnerDataGrid.SpecRow;
end;

procedure TPopupDataGridBoxEh.SetSpecRow(AValue: TSpecRowEh);
begin
  InnerDataGrid.SpecRow := AValue;
end;

function TPopupDataGridBoxEh.GetUseMultiTitle: Boolean;
begin
  Result := InnerDataGrid.UseMultiTitle;
end;

procedure TPopupDataGridBoxEh.HandleNeeded;
begin
  inherited HandleNeeded;
  InnerDataGrid.HandleNeeded;
end;

procedure TPopupDataGridBoxEh.SetUseMultiTitle(AValue: Boolean);
begin
  InnerDataGrid.UseMultiTitle := AValue;
end;

function TPopupDataGridBoxEh.GetListFieldName: string;
begin
  Result := InnerDataGrid.ListField;
end;

procedure TPopupDataGridBoxEh.SetListFieldName(AValue: string);
begin
  InnerDataGrid.ListField := AValue;
end;

function TPopupDataGridBoxEh.GetAutoFitColWidths: Boolean;
begin
  Result := InnerDataGrid.AutoFitColWidths;
end;

procedure TPopupDataGridBoxEh.SetAutoFitColWidths(AValue: Boolean);
begin
  InnerDataGrid.AutoFitColWidths := AValue;
end;

function TPopupDataGridBoxEh.GetDrawMemoText: Boolean;
begin
  Result := InnerDataGrid.DrawMemoText;
end;

procedure TPopupDataGridBoxEh.SetDrawMemoText(AValue: Boolean);
begin
  InnerDataGrid.DrawMemoText := AValue;
end;

function TPopupDataGridBoxEh.GetOnColumnMoved: TMovedEvent;
begin
  Result := InnerDataGrid.OnColumnMoved;
end;

procedure TPopupDataGridBoxEh.SetOnColumnMoved(AValue: TMovedEvent);
begin
  InnerDataGrid.OnColumnMoved := AValue;
end;

function TPopupDataGridBoxEh.GetOnMouseCloseUp: TCloseUpEventEh;
begin
  Result := InnerDataGrid.OnMouseCloseUp;
end;

procedure TPopupDataGridBoxEh.SetOnMouseCloseUp(AValue: TCloseUpEventEh);
begin
  InnerDataGrid.OnMouseCloseUp := AValue;
end;

function TPopupDataGridBoxEh.GetTitleParams: TDBGridTitleParamsEh;
begin
  Result := InnerDataGrid.TitleParams;
end;

procedure TPopupDataGridBoxEh.SetTitleParams(AValue: TDBGridTitleParamsEh);
begin
  InnerDataGrid.TitleParams := AValue;
end;

function TPopupDataGridBoxEh.GetSizeGripAlwaysShow: Boolean;
begin
  Result := InnerDataGrid.SizeGripAlwaysShow;
end;

procedure TPopupDataGridBoxEh.SetSizeGripAlwaysShow(AValue: Boolean);
begin
  InnerDataGrid.SizeGripAlwaysShow := AValue;
end;

function TPopupDataGridBoxEh.GetSizeGripResized: Boolean;
begin
  Result := InnerDataGrid.SizeGripResized;
end;

procedure TPopupDataGridBoxEh.SetSizeGripResized(AValue: Boolean);
begin
  InnerDataGrid.SizeGripResized := AValue;
end;

function TPopupDataGridBoxEh.GetAxisBarOwner: TPersistent;
begin
  Result := InnerDataGrid.FAxisBarOwner;
end;

procedure TPopupDataGridBoxEh.SetAxisBarOwner(AValue: TPersistent);
begin
  InnerDataGrid.FAxisBarOwner := AValue;
end;

function TPopupDataGridBoxEh.GetOnUserKeyValueChange: TNotifyEvent;
begin
  Result := InnerDataGrid.OnUserKeyValueChange;
end;

procedure TPopupDataGridBoxEh.SetOnUserKeyValueChange(AValue: TNotifyEvent);
begin
  InnerDataGrid.OnUserKeyValueChange := AValue;
end;

function TPopupDataGridBoxEh.GetReadOnly: Boolean;
begin
  Result := InnerDataGrid.ReadOnly;
end;

procedure TPopupDataGridBoxEh.SetReadOnly(AValue: Boolean);
begin
  InnerDataGrid.ReadOnly := AValue;
end;

function TPopupDataGridBoxEh.CalcAutoHeightForRowCount(ARowCount: Integer): Integer;
begin
  Result := InnerDataGrid.CalcAutoHeightForRowCount(ARowCount);
end;

procedure TPopupDataGridBoxEh.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if InnerDataGrid <> nil then
    AHeight := InnerDataGrid.AdjustHeight(AHeight);
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TPopupDataGridBoxEh.SetColResizedControlWidth(NewControlWidth: Integer);
var
  fw: Integer;
  newL: Integer;
begin
  if UseRightToLeftAlignment then
  begin
    fw := NewControlWidth + (InnerDataGrid.ClientWidth - (InnerDataGrid.HorzAxis.GridClientStop - InnerDataGrid.HorzAxis.GridClientStart));
    newL := Width - fw;
    SetBounds(Left + newL, Top, fw, Height);
  end else
    Width := NewControlWidth;
end;

procedure TPopupDataGridBoxEh.CMMouseWheel(var Message: TMessage);
begin
  inherited;
  if Message.Result = 0 then
  begin
    if FMouseWheelInInnerDataGrid = True then Exit;
    FMouseWheelInInnerDataGrid := True;
    try
      Message.Result := InnerDataGrid.Perform(CM_MOUSEWHEEL, Message.WParam, Message.LParam);
    finally
      FMouseWheelInInnerDataGrid := False;
    end;
  end;
end;

function TPopupDataGridBoxEh.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result :=  inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if Result = False then
  begin
    Result := InnerDataGrid.DoMouseWheel(Shift, WheelDelta, MousePos);
  end;
end;

{$IFDEF EH_LIB_16}
{ TPopupDataGridEhStyleHook }

procedure TPopupDataGridEhStyleHook.WMPaint(var Message: TMessage);
begin
  inherited;
  PaintScroll;
end;
{$ENDIF}

{ TLookupGridDataLinkEh }

constructor TLookupGridDataLinkEh.Create;
begin
  inherited Create;
end;

procedure TLookupGridDataLinkEh.ActiveChanged;
begin
  if FDBLookupGrid <> nil then FDBLookupGrid.UpdateDataFields;
end;

{$IFDEF CIL}
procedure TLookupGridDataLinkEh.FocusControl(const Field: TField);
begin
  if (Field <> nil) and (Field = FDBLookupGrid.Field) and
    (FDBLookupGrid <> nil) and FDBLookupGrid.CanFocus then
  begin
    FDBLookupGrid.SetFocus;
  end;
end;
{$ELSE}
procedure TLookupGridDataLinkEh.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and (Field^ = FDBLookupGrid.Field) and
    (FDBLookupGrid <> nil) and FDBLookupGrid.CanFocus then
  begin
    Field^ := nil;
    FDBLookupGrid.SetFocus;
  end;
end;
{$ENDIF}

procedure TLookupGridDataLinkEh.LayoutChanged;
begin
  if FDBLookupGrid <> nil then FDBLookupGrid.UpdateDataFields;
end;

procedure TLookupGridDataLinkEh.RecordChanged(Field: TField);
begin
  if FDBLookupGrid <> nil then FDBLookupGrid.DataLinkRecordChanged(Field);
end;

{ TGridColumnSpecCellEh }

constructor TGridColumnSpecCellEh.Create(Owner: TPersistent);
begin
  inherited Create;
  FOwner := Owner;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FImageIndex := -1;
end;

destructor TGridColumnSpecCellEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

function TGridColumnSpecCellEh.DefaultColor: TColor;
begin
  if Assigned(FOwner) and (FOwner is TDBLookupGridColumnEh) and
    Assigned((TDBLookupGridColumnEh(FOwner)).Grid)
  then
    Result := TDBLookupGridColumnEh(FOwner).GetGrid.SpecRow.Color
  else
    Result := FColor;
end;

function TGridColumnSpecCellEh.DefaultFont: TFont;
begin
  if Assigned(FOwner) and (FOwner is TDBLookupGridColumnEh) and
    Assigned(TDBLookupGridColumnEh(FOwner).Grid)
  then
    Result := TDBLookupGridColumnEh(FOwner).GetGrid.SpecRow.Font
  else
    Result := FFont;
end;

function TGridColumnSpecCellEh.DefaultText: String;
begin
  if Assigned(FOwner) and (FOwner is TDBLookupGridColumnEh) and
    Assigned(TDBLookupGridColumnEh(FOwner).Grid)
  then
    Result := TDBLookupGridColumnEh(FOwner).GetGrid.SpecRow.CellText[TDBLookupGridColumnEh(FOwner).Index]
  else
    Result := FText;
end;

function TGridColumnSpecCellEh.GetColor: TColor;
begin
  if not FColorAssigned
    then Result := DefaultColor
    else Result := FColor;
end;

function TGridColumnSpecCellEh.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  {$WARNINGS OFF}
  if not FFontAssigned and (FFont.Handle <> DefaultFont.Handle) then
  {$WARNINGS ON}
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

procedure TGridColumnSpecCellEh.FontChanged(Sender: TObject);
begin
  FFontAssigned := True;
end;

function TGridColumnSpecCellEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TGridColumnSpecCellEh.GetText: String;
begin
  if not FTextAssigned
    then Result := DefaultText
    else Result := FText;
end;

function TGridColumnSpecCellEh.IsColorStored: Boolean;
begin
  Result := FColorAssigned;
end;

function TGridColumnSpecCellEh.IsFontStored: Boolean;
begin
  Result := FFontAssigned;
end;

function TGridColumnSpecCellEh.IsTextStored: Boolean;
begin
  Result := FTextAssigned;
end;

procedure TGridColumnSpecCellEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FColorAssigned := True;
  end;
end;

procedure TGridColumnSpecCellEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TGridColumnSpecCellEh.SetText(const Value: String);
begin
  if FText <> Value then
  begin
    FText := Value;
    FTextAssigned := True;
  end;
end;

procedure TGridColumnSpecCellEh.Assign(Source: TPersistent);
begin
  if Source is TGridColumnSpecCellEh then
  begin
    Text := TGridColumnSpecCellEh(Source).Text;
    Color := TGridColumnSpecCellEh(Source).Color;
    if TGridColumnSpecCellEh(Source).FFontAssigned then
      Font := TGridColumnSpecCellEh(Source).Font;
  end else
    inherited Assign(Source);
end;

{ TDBLookupGridColumnEh }

constructor TDBLookupGridColumnEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSpecCell := TGridColumnSpecCellEh.Create(Self);
end;

destructor TDBLookupGridColumnEh.Destroy;
begin
  FreeAndNil(FSpecCell);
  inherited Destroy;
end;

function TDBLookupGridColumnEh.GetGrid: TDBLookupGridEh;
begin
  Result := TDBLookupGridEh(inherited Grid);
end;

procedure TDBLookupGridColumnEh.SetIndex(Value: Integer);
var
  i: Integer;
  s: String;
  AGrid: TDBLookupGridEh;

  procedure SetSpecCell;
  var
    ss: TStringList;
    i: Integer;
  begin
    ss := TStringList.Create;
    try
      for i := 0 to AGrid.Columns.Count - 1 do
        ss.Add(AGrid.SpecRow.CellText[i]);
      ss.Move(Index, Value);
      s := '';
      for i := 0 to AGrid.Columns.Count - 1 do
        s := s + ss[i] + ';';
      Delete(s, Length(s), 1);
      AGrid.SpecRow.CellsText := s;
    finally
      ss.Free;
    end;
  end;

begin
  AGrid := Self.Grid as TDBLookupGridEh;
  if SeenPassthrough and AGrid.DataLink.Active and (Index <> Value) then
  begin
    AGrid.BeginUpdate;
    try
      if Index = AGrid.ListFieldIndex then
        AGrid.ListFieldIndex := Value
      else
      begin
        if AGrid.ListFieldIndex > Index then
          AGrid.ListFieldIndex := AGrid.ListFieldIndex - 1;
        if AGrid.ListFieldIndex >= Value then
          AGrid.ListFieldIndex := AGrid.ListFieldIndex + 1;
      end;
      SetSpecCell;
      IsStored := True;
      try
        inherited SetIndex(Value);
      finally
        IsStored := False;
      end;
      s := '';
      for i := 0 to AGrid.Columns.Count - 1 do
      begin
        if AGrid.Columns[i].Field <> nil then
          s := s + AGrid.Columns[i].Field.FieldName + ';';
      end;
      Delete(s, Length(s), 1);
      AGrid.ListField := s;
    finally
      AGrid.EndUpdate;
    end;
  end else
  begin
    if AGrid.DataLink.Active and (Index <> Value) then
      SetSpecCell;
    inherited SetIndex(Value);
  end;
end;

procedure TDBLookupGridColumnEh.SetSpecCell(const Value: TGridColumnSpecCellEh);
begin
  FSpecCell.Assign(Value);
end;

procedure TDBLookupGridColumnEh.SetWidth(const Value: Integer);
begin
  if SeenPassthrough then
  begin
    IsStored := True;
    try
      inherited SetWidth(Value);
    finally
      IsStored := False;
    end;
  end else
    inherited SetWidth(Value);
end;

{ TDBLookupGridEh }

constructor TDBLookupGridEh.Create(AOwner: TComponent);
begin
{$IFDEF CIL}
{$ELSE}
  FNoDesigntControler := True;
{$ENDIF}
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; 
  ParentColor := False;
  TabStop := True;
  FLookupSource := TDataSource.Create(Self);
  FDataLink := TLookupGridDataLinkEh.Create;
  FDataLink.FDBLookupGrid := Self;
  FListFields := TFieldListEh.Create;
  FKeyValue := Null;
  FSpecRow := TSpecRowEh.Create(Self);
  FSpecRow.OnChanged := SpecRowChanged;
  inherited Options := [dgColLines, dgRowSelect];
  OptionsEh := OptionsEh + [dghTraceColSizing];
  FOptions := [dlgColLinesEh];
  HorzScrollBar.Tracking := True;
  VertScrollBar.Tracking := True;
  Flat := True;
  ReadOnly := True;
  DrawMemoText := True;
  TabStop := False;
  FLGAutoFitColWidths := False;
  VTitleMargin := 5;
  ReadOnly := False;
  FHighlightTextParams := TGridHighlightTextParamsEh.Create;
end;

destructor TDBLookupGridEh.Destroy;
begin
  FreeAndNil(FSpecRow);
  FreeAndNil(FListFields);
  FDataLink.FDBLookupGrid := nil;
  FreeAndNil(FDataLink);
  FreeAndNil(FHighlightTextParams);
  inherited Destroy;
end;

function TDBLookupGridEh.CanModify: Boolean;
  function MasterFieldsCanModify: Boolean;
  var i: Integer;
  begin
    Result := True;
    for i := 0 to Length(FMasterFields) - 1 do
      if not FMasterFields[i].CanModify then
      begin
        Result := False;
        Exit;
      end;
  end;
begin
  Result := FListActive and not ReadOnly and ((FDataLink.DataSource = nil) or
    (Length(FMasterFields) <> 0) and MasterFieldsCanModify);
end;

procedure TDBLookupGridEh.CheckNotCircular;
begin
  if ListLink.Active and ListLink.DataSet.IsLinkedTo(DataSource) then
  {$IFDEF FPC}
    DatabaseError('SCircularDataLink');
  {$ELSE}
    DatabaseError(SCircularDataLink);
  {$ENDIF}
end;

procedure TDBLookupGridEh.CheckNotLookup;
begin
  {$IFDEF FPC}
  if FLookupMode then DatabaseError('SPropDefByLookup');
  if FDataLink.DataSourceFixed then DatabaseError('SDataSourceFixed');
  {$ELSE}
  if FLookupMode then DatabaseError(SPropDefByLookup);
  if FDataLink.DataSourceFixed then DatabaseError(SDataSourceFixed);
  {$ENDIF}
end;

procedure TDBLookupGridEh.UpdateDataFields;
  function MasterFieldNames: String;
  var i: Integer;
  begin
    Result := '';
    for i := 0 to Length(FMasterFields) - 1 do
      if Result = '' then
        Result := FMasterFields[i].FieldName else
        Result := Result + ';' + FMasterFields[i].FieldName;
  end;
begin
  FMasterFieldNames := '';
  if FDataLink.Active and (FDataFieldName <> '') then
  begin
    CheckNotCircular;
    FDataFields := GetFieldsProperty(FDataLink.DataSet, Self, FDataFieldName);
    if (Length(FDataFields) = 1) and (FDataFields[0].FieldKind = fkLookup)
      then FMasterFields := GetFieldsProperty(FDataLink.DataSet, Self, FDataFields[0].KeyFields)
      else FMasterFields := FDataFields;
    FMasterFieldNames := MasterFieldNames;
  end;
  SetLookupMode((Length(FDataFields) = 1) and (FDataFields[0].FieldKind = fkLookup));
  DataLinkRecordChanged(nil);
end;

procedure TDBLookupGridEh.DataLinkRecordChanged(Field: TField);
  function FieldFound(Value: TField): Boolean;
  var i: Integer;
  begin
    Result := False;
    for i := 0 to Length(FMasterFields) - 1 do
      if FMasterFields[i] = Value then
      begin
        Result := True;
        Exit;
      end;
  end;
begin
  if (Field = nil) or FieldFound(Field) then
    if Length(FMasterFields) > 0
      then SetKeyValue(FDataLink.DataSet.FieldValues[FMasterFieldNames])
      else SetKeyValue(Null);
end;

function TDBLookupGridEh.GetBorderSize: Integer;
{$IFDEF FPC}
{$ELSE}
var
  sbi: TScrollBarInfo;
  SBVisible: Boolean;
  {$ENDIF}
begin
  Result := 0;
  if not HandleAllocated then Exit;
  Result := Height - ClientHeight;

  {$IFDEF FPC}
  {$ELSE}
  sbi.cbSize := sizeof(TScrollBarInfo);
  GetScrollBarInfo(Handle, Longint(OBJID_HSCROLL), sbi);
  if sbi.rgstate[0] and STATE_SYSTEM_INVISIBLE = 0
    then SBVisible := True
    else SBVisible := False;
  if SBVisible then
    Dec(Result, GetSystemMetrics(SM_CYHSCROLL));
  {$ENDIF}
end;

function TDBLookupGridEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBLookupGridEh.SetDataSource(Value: TDataSource);
begin
  inherited DataSource := Value;
end;

function TDBLookupGridEh.GetKeyFieldName: string;
begin
  if FLookupMode then Result := '' else Result := FKeyFieldName;
end;

function TDBLookupGridEh.GetListSource: TDataSource;
begin
  if FLookupMode then Result := nil else Result := ListLink.DataSource;
end;

function TDBLookupGridEh.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

function TDBLookupGridEh.GetDataRowHeight: Integer;
begin
  Result := DefaultRowHeight;
  if dgRowLines in inherited Options then Inc(Result, GridLineWidth);
end;

function TDBLookupGridEh.GetSpecRowHeight: Integer;
begin
  Result := DefaultRowHeight;
  if dgRowLines in inherited Options then
    Inc(Result, GridLineWidth);
end;

procedure TDBLookupGridEh.KeyValueChanged;
var
  KeyLocated: Boolean;
begin
  KeyLocated := False;
  if not SpecRow.Visible then
    SpecRow.Selected := False
  else
  begin
    SpecRow.Selected := VarEquals(FKeyValue, SpecRow.Value);
    if not FLockPosition and not SpecRow.Selected and SpecRow.ShowIfNotInKeyList then
    begin
      KeyLocated := LocateKey;
      if not KeyLocated
        then SpecRow.Selected := True
        else ListLinkDataChanged
    end;
  end;

  BeginInrenalListDataChanging;
  try
  if ListActive and not FLockPosition then
    if not LocateKey and not SpecRow.Selected then
      ListLink.DataSet.First
    else
      ListLinkDataChanged;
  finally
    EndInrenalListDataChanging;
  end;

  if (ListLink.DataSet <> nil) and
     ListLink.DataSet.Active and
     VarEquals(FKeyValue, ListLink.DataSet[FKeyFieldName])
  then
    UpdateSelectedItem(True)
  else
    UpdateSelectedItem(KeyLocated);
end;


procedure TDBLookupGridEh.UpdateSelectedItem(KeyLocated: Boolean);
begin
  if FListField <> nil then
  begin
    if SpecRow.Visible and SpecRow.Selected then
      FSelectedItem := SpecRow.CellText[ListFieldIndex]
    else if KeyLocated and (DrawMemoText = True) and (FListField.DataType in MemoTypes) then
      FSelectedItem := FListField.AsString
    else if KeyLocated then
      FSelectedItem := FListField.DisplayText
    else
      FSelectedItem := '';
  end else
    FSelectedItem := '';
end;

procedure TDBLookupGridEh.UpdateListFields;
var
  DataSet: TDataSet;
  ResultField: TField;
  i: Integer;
begin
  try
    FListActive := False;
    FListField := nil;
    FListFields.Clear;
    if ListLink.Active and (FKeyFieldName <> '') then
    begin
      CheckNotCircular;
      DataSet := ListLink.DataSet;
      FKeyFields := GetFieldsProperty(DataSet, Self, FKeyFieldName);
      try
        DataSet.GetFieldList(FListFields, FListFieldName);
      except
  {$IFDEF FPC}
        DatabaseErrorFmt('SFieldNotFound', [Self.Name, FListFieldName]);
  {$ELSE}
        DatabaseErrorFmt(SFieldNotFound, [Self.Name, FListFieldName]);
  {$ENDIF}
      end;
      if FLookupMode then
      begin
        ResultField := GetFieldProperty(DataSet, Self, FDataFields[0].LookupResultField);
        if FListFields.IndexOf(ResultField) < 0 then
          FListFields.Insert(0, ResultField);
        FListField := ResultField;
      end else
      begin
        if FListFields.Count = 0 then
          for i := 0 to Length(FKeyFields) - 1 do FListFields.Add(FKeyFields[i]);
        if (FListFieldIndex >= 0) and (FListFieldIndex < FListFields.Count) then
          FListField := TField(FListFields[FListFieldIndex]) else
          FListField := TField(FListFields[0]);
      end;
      FListActive := True;
    end;

    if FLookupMode
      then FKeyFieldName := Field.LookupKeyFields
      else FKeyFieldName := KeyField;
    if ListLink.Active and (FKeyFieldName <> '') then
    begin
      DataSet := ListLink.DataSet;
      FKeyFields := GetFieldsProperty(DataSet, Self, FKeyFieldName);
      if FLookupMode then
      begin
        ResultField := GetFieldProperty(DataSet, Self, Field.LookupResultField);
        FListField := ResultField;
      end else
      begin
        if (ListFieldIndex >= 0) and (ListFieldIndex < ListFields.Count)
          then FListField := TField(ListFields[ListFieldIndex])
          else FListField := TField(ListFields[0]);
      end;
    end;

  finally
    if ListActive
      then KeyValueChanged
      else ListLinkDataChanged;
  end;
end;

procedure TDBLookupGridEh.ListLinkDataChanged;
begin
  if ListActive then
  begin
    if ExtendedScrolling then
    begin
      FRecordIndex := ListLink.DataSet.RecNo-1;
      FRecordCount := ListLink.DataSet.RecordCount;
    end else
    begin
      FRecordIndex := ListLink.ActiveRecord;
      FRecordCount := ListLink.RecordCount;
    end;
    FKeySelected := not VarIsNull(KeyValue) or
      not ListLink.DataSet.BOF;
  end else
  begin
    FRecordIndex := 0;
    FRecordCount := 0;
    FKeySelected := False;
  end;
  if HandleAllocated then
  begin
    UpdateScrollBars;
    LayoutChanged;
  end;
end;

function TDBLookupGridEh.LocateKey: Boolean;
var
  KeySave: Variant;
begin
  BeginInrenalListDataChanging;
  try
  Result := False;
  try
    KeySave := FKeyValue;
    if not VarIsNull(FKeyValue) and (ListLink.DataSet <> nil) and
      ListLink.DataSet.Active and CompatibleVarValue(FKeyFields, FKeyValue) and
      ListLink.DataSet.Locate(FKeyFieldName, FKeyValue, []) then
    begin
      Result := True;
      FKeyValue := KeySave;
      if ExtendedScrolling then
        SafeSetTopRow(Row -
          (VertAxis.RolLastFullVisCel - VertAxis.RolStartVisCel + 1) div 2);
    end;
    UpdateSelectedItem(Result);
  except
  end;
  finally
    EndInrenalListDataChanging;
  end;
end;

procedure TDBLookupGridEh.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  NilVar: TDataSource;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (FDataLink <> nil) and (AComponent = DataSource) then
    begin
      NilVar := nil; 
      DataSource := NilVar;
    end;
  end;
end;

procedure TDBLookupGridEh.ProcessSearchKey(Key: Char);
{$IFDEF FPC_CROSSP}
{ Looks like ProcessSearchKey never use}
begin
end;
{$ELSE}
var
  TickCount: Integer;
  S: string;
  CharMsg: TMsg;
begin
  if (FListField <> nil) and (FListField.FieldKind in [fkData, fkInternalCalc, fkCalculated]) and
    (FListField.DataType in [ftString, ftWideString]) then
    case Key of
      #8, #27: SearchText := '';
      #32..High(Char):
        if CanModify then
        begin
          TickCount := GetTickCountEh;
          if TickCount - SearchTickCount > 2000 then SearchText := '';
          SearchTickCount := TickCount;
          if SysLocale.FarEast and IsLeadCharEh(Key) then
            if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
            begin
              if CharMsg.Message = WM_Quit then
              begin
                PostQuitMessageEh(CharMsg.wparam);
                Exit;
              end;
              SearchText := SearchText + Key;
{$IFDEF CIL}
{$ELSE}
              Key := Char(CharMsg.wParam);
{$ENDIF}
            end;
          if Length(SearchText) < 32 then
          begin
            S := SearchText + Key;
            BeginInrenalListDataChanging;
            try
            try
              if ListLink.DataSet.Locate(FListField.FieldName, S,
                [loCaseInsensitive, loPartialKey]) then
              begin
                SelectKeyValue(ListLink.DataSet.FieldValues[FKeyFieldName] {FKeyField.Value});
                SearchText := S;
              end;
            except
              { If you attempt to search for a string larger than what the field
                can hold, and exception will be raised.  Just trap it and
                reset the SearchText back to the old value. }
              SearchText := S;
            end;
            finally
              EndInrenalListDataChanging;
            end;
          end;
        end;
    end;
end;
{$ENDIF} 

procedure TDBLookupGridEh.SelectKeyValue(const Value: Variant);
begin
  if Length(FMasterFields) > 0 then
  begin
    if FDataLink.Edit then
      FDataLink.DataSet.FieldValues[FMasterFieldNames] := Value;
  end else
    SetKeyValue(Value);
  UpdateActive;
  Repaint;
  Click;
end;

procedure TDBLookupGridEh.SetDataFieldName(const Value: string);
begin
  if FDataFieldName <> Value then
  begin
    FDataFieldName := Value;
    UpdateDataFields;
  end;
end;

procedure TDBLookupGridEh.SetKeyFieldName(const Value: string);
begin
  CheckNotLookup;
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    UpdateListFields;
    UpdateColumnsList;
  end;
end;

procedure TDBLookupGridEh.SetKeyValue(const Value: Variant);
begin
  if not VarEquals(FKeyValue, Value) then
  begin
    FKeyValue := Value;
    KeyValueChanged;
  end
end;

procedure TDBLookupGridEh.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    UpdateListFields;
    UpdateColumnsList;
  end;
end;

procedure TDBLookupGridEh.SetListSource(Value: TDataSource);
begin
  CheckNotLookup;
  inherited DataSource := Value;
end;

procedure TDBLookupGridEh.SetLookupMode(Value: Boolean);
begin
  if FLookupMode <> Value then
    if Value then
    begin
      FMasterFields := GetFieldsProperty(FDataFields[0].DataSet, Self, FDataFields[0].KeyFields);
      FLookupSource.DataSet := FDataFields[0].LookupDataSet;
      FKeyFieldName := FDataFields[0].LookupKeyFields;
      FLookupMode := True;
      ListLink.DataSource := FLookupSource;
    end else
    begin
      ListLink.DataSource := nil;
      FLookupMode := False;
      FKeyFieldName := '';
      FLookupSource.DataSet := nil;
      FMasterFields := FDataFields;
    end;
end;

procedure TDBLookupGridEh.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBLookupGridEh.GetDataField: TField;
begin
  if Length(FDataFields) = 0
    then Result := nil
    else Result := FDataFields[0];
end;

procedure TDBLookupGridEh.SetSpecRow(const Value: TSpecRowEh);
begin
  FSpecRow.Assign(Value);
end;

procedure TDBLookupGridEh.SpecRowChanged(Sender: TObject);
begin
  if not (csLoading in ComponentState) then
    Invalidate;
end;

function TDBLookupGridEh.GetListLink: TAxisGridDataLinkEh;
begin
  Result := inherited DataLink;
end;

procedure TDBLookupGridEh.LinkActive(Value: Boolean);
begin
  if csDestroying in ComponentState then Exit;
  UpdateListFields;
  inherited LinkActive(Value);
  UpdateColumnsList;
end;

procedure TDBLookupGridEh.DataChanged;
begin
  inherited DataChanged;
  ListLinkDataChanged;
end;

procedure TDBLookupGridEh.LayoutChanged;
begin
  if AcquireLayoutLock then
  try
    inherited LayoutChanged;
  finally
    EndLayout;
  end;
end;

procedure TDBLookupGridEh.SelectCurrent;
begin
  FLockPosition := True;
  try
    if not VarEquals(ListLink.DataSet.FieldValues[FKeyFieldName], KeyValue) then
      SelectKeyValue(ListLink.DataSet.FieldValues[FKeyFieldName]);
  finally
    FLockPosition := False;
  end;
end;

procedure TDBLookupGridEh.SelectItemAt(X, Y: Integer);
var
  Delta: Integer;
  Cell: TGridCoord;
  ADataBox: TGridRect;
begin
  BeginInrenalListDataChanging;
  try
  if FSpecRow.Visible and (Y > TitleRowHeight) and (Y <= TitleRowHeight + FSpecRowHeight) then
  begin
    SelectSpecRow;
  end else
  begin
    if Y < TitleRowHeight + FSpecRowHeight then Exit; 
    if Y >= ClientHeight then Y := ClientHeight - 1;
    Cell := MouseCoord(X, Y);
    ADataBox := DataBox;
    if (Cell.X >= ADataBox.Left) and (Cell.X <= ADataBox.Right) and
      (Cell.Y >= ADataBox.Top) and (Cell.Y <= ADataBox.Bottom) then
    begin
      Delta := (Cell.Y - TopDataOffset) - FRecordIndex;
      ListLink.DataSet.MoveBy(Delta);
      SelectCurrent;
    end;
  end;
  finally
    EndInrenalListDataChanging;
  end;
end;

procedure TDBLookupGridEh.SelectSpecRow;
begin
  FLockPosition := True;
  try
    if not VarEquals(FSpecRow.Value, KeyValue) then
      SelectKeyValue(FSpecRow.Value);
    SpecRow.Selected := True;
  finally
    FLockPosition := False;
  end;
end;

procedure TDBLookupGridEh.SetShowTitles(const Value: Boolean);
begin
  if ShowTitles <> Value then
  begin
    if Value
      then inherited Options := inherited Options + [dgTitles]
      else inherited Options := inherited Options - [dgTitles];
    Height := RowCount * GetDataRowHeight + GetBorderSize + TitleRowHeight + FSpecRowHeight;
  end;
end;

function TDBLookupGridEh.GetShowTitles: Boolean;
begin
  Result := dgTitles in inherited Options;
end;

function TDBLookupGridEh.HighlightDataCellColor(DataCol, DataRow: Integer; const Value: string;
  AState: TGridDrawState; var AColor: TColor; AFont: TFont): Boolean;
begin
  Result := False;
  if {not VarIsNull(KeyValue) and }
    ListLink.Active and
    VarEquals(ListLink.DataSet.FieldValues[FKeyFieldName], KeyValue)
  then
    Result := (UpdateLock = 0);
  if Result then
    HighlightLookupGridCellColor(DataCol, DataRow, True, Value, AState, AColor, AFont);
end;

procedure TDBLookupGridEh.HighlightLookupGridCellColor(DataCol, DataRow: Integer;
  Selected: Boolean; const Value: string; AState: TGridDrawState;
  var AColor: TColor; AFont: TFont);
var
  HighlightTextColor: TColor;
begin
  if Selected then
  begin

    AState := AState + [gdSelected];
    if IsDrawCellSelectionThemed(DataCol, DataRow, DataCol, DataRow, AState) then
    begin
      if not ThemedSelectionEnabled then
      begin
        AColor := clHighlight;
        AFont.Color := clHighlightText;
      end else
      begin
{$IFDEF EH_LIB_16}
        if not StyleServices.GetElementColor(
          StyleServices.GetElementDetails(tgCellSelected), ecTextColor, HighlightTextColor) or
           (HighlightTextColor = clNone)
        then
          HighlightTextColor := clHighlightText
        else
          HighlightTextColor := clWindowText;
{$ELSE}
        HighlightTextColor := clWindowText;
{$ENDIF}
        AFont.Color := HighlightTextColor;
      end;
    end else
    begin
      AColor := StyleServices.GetSystemColor(clHighlight);
{$IFDEF EH_LIB_16}
      if IsCustomStyleActive
        then AFont.Color := StyleServices.GetStyleFontColor(sfListItemTextSelected)
        else AFont.Color := StyleServices.GetSystemColor(clHighlightText);
{$ELSE}
      AFont.Color := StyleServices.GetSystemColor(clHighlightText);
{$ENDIF}
    end;
  end;
end;

function TDBLookupGridEh.GetDefaultActualColumnFontColor(Column: TColumnEh;
  AState: TGridDrawState): TColor;
begin
  AState := [];
  Result := inherited GetDefaultActualColumnFontColor(Column, AState);
end;

procedure TDBLookupGridEh.UpdateActive;
var
  NewRow: Integer;
  ADataRowCount: Integer;

  function GetKeyRowIndex: Integer;
  var
    FieldValue: Variant;
    ActiveRecord: Integer;
    I: Integer;
  begin
    Result := -1;
    if ExtendedScrolling then
      Result := ListLink.DataSet.RecNo-1
    else
    begin
      ActiveRecord := ListLink.ActiveRecord;
      try
        if not VarIsNull(KeyValue) then
          for I := 0 to FRecordCount - 1 do
          begin
            ListLink.ActiveRecord := I;
            FieldValue := ListLink.DataSet.FieldValues[FKeyFieldName];
            if VarEquals(FieldValue, KeyValue) then
            begin
              Result := I;
              Exit;
            end;
          end;
      finally
        ListLink.ActiveRecord := ActiveRecord;
      end;
    end;
  end;
begin
  if not FInplaceSearchingInProcess then
    StopInplaceSearch;
  FKeyRowVisible := False;
  if ListLink.Active and HandleAllocated and not (csLoading in ComponentState) then
  begin
    NewRow := GetKeyRowIndex;
    ADataRowCount := inherited RowCount - TopDataOffset;
    if (NewRow >= 0) and (NewRow < ADataRowCount) then
    begin
      Inc(NewRow, TopDataOffset);
      if Row <> NewRow then
      begin
        if not (dgAlwaysShowEditor in inherited Options) then HideEditor;
        MoveColRow(Col, NewRow, False, False);
        InvalidateEditor;
      end;
      FKeyRowVisible := True;
    end
  end;
end;

function TDBLookupGridEh.GetKeyIndex: Integer;
var
  FieldValue: Variant;
begin
  if not VarIsNull(KeyValue) then
    for Result := 0 to FRecordCount - 1 do
    begin
      ListLink.ActiveRecord := Result;
      FieldValue := ListLink.DataSet.FieldValues[FKeyFieldName];
      ListLink.ActiveRecord := FRecordIndex;
      if VarEquals(FieldValue, KeyValue) then Exit;
    end;
  Result := -1;
end;

function TDBLookupGridEh.CanDrawFocusRowRect: Boolean;
begin
  Result := FKeyRowVisible;
end;

procedure TDBLookupGridEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  Delta, KeyIndex, MovedBy: Integer;
begin
  BeginInrenalListDataChanging;
  try
  if CanModify then
  begin
    Delta := 0;
    case Key of
      VK_UP: Delta := -1;
      VK_LEFT: if not HorzScrollBar.IsScrollBarShowing then Delta := -1;
      VK_DOWN: Delta := 1;
      VK_RIGHT: if not HorzScrollBar.IsScrollBarShowing then Delta := 1;
      VK_PRIOR: Delta := -VisibleDataRowCount;
      VK_NEXT: Delta := VisibleDataRowCount;
      VK_HOME: Delta := -Maxint;
      VK_END: Delta := Maxint;
    end;
    if Delta <> 0 then
    begin
      SearchText := '';
      if (Delta < 0) and (ListLink.DataSet.Bof or SpecRow.Selected) and SpecRow.Visible then
      begin
        SelectSpecRow;
        ListLink.DataSet.First;
        Exit;
      end else if (Delta > 0) and SpecRow.Selected then
        ListLink.DataSet.First
      else if Delta = -Maxint
        then ListLink.DataSet.First
      else if Delta = Maxint
        then ListLink.DataSet.Last
      else
      begin
        if not ExtendedScrolling then
        begin
          KeyIndex := GetKeyIndex;
          if KeyIndex >= 0 then
            ListLink.DataSet.MoveBy(KeyIndex - FRecordIndex)
          else
          begin
            KeyValueChanged;
            Delta := 0;
          end;
        end;
        MovedBy := ListLink.DataSet.MoveBy(Delta);
        if (MovedBy = 0) and (Delta < 0) and not SpecRow.Selected and SpecRow.Visible then
        begin
          SelectSpecRow;
          Exit;
        end;
      end;
      SelectCurrent;
    end else
      inherited KeyDown(Key, Shift);
  end else
    inherited KeyDown(Key, Shift);
  finally
    EndInrenalListDataChanging;
  end;
end;

procedure TDBLookupGridEh.Scroll(Distance: Integer);
begin
  BeginUpdate;
  inherited Scroll(Distance);
  ListLinkDataChanged;
  EndUpdate;
end;

procedure TDBLookupGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
  ADataBox: TGridRect;
begin
  Cell := MouseCoord(X, Y);
  ADataBox := DataBox;
  if not CellTreeElementMouseDown(X, Y, True) and
    ((Cell.X >= ADataBox.Left) and (Cell.X <= ADataBox.Right) and
    (Cell.Y >= ADataBox.Top) and (Cell.Y <= ADataBox.Bottom)) or
    (SpecRow.Visible and (TopDataOffset - 1 = Cell.Y))
    then
  begin
    if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
    if Button = mbLeft then
    begin
      SearchText := '';
      if not FPopup then
      begin
        SetFocus;
        if not FHasFocus then Exit;
      end;
      if CanModify then
        if ssDouble in Shift then
        begin
          if FRecordIndex = (Y - TitleRowHeight) div GetDataRowHeight then DblClick;
        end else
        begin
          if not MouseCapture then Exit;
          FTracking := True;
          FDataTracking := True;
          if Y > TitleRowHeight then
            SelectItemAt(X, Y);
        end;
    end;
  end else
    inherited MouseDown(Button, Shift, X, Y);
end;

procedure TDBLookupGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FTracking and FDataTracking then
  begin
    SelectItemAt(X, Y);
    FMousePos := Y;
    TimerScroll;
    if Assigned(OnMouseMove) then OnMouseMove(Self, Shift, X, Y);
  end else
    inherited MouseMove(Shift, X, Y);
end;

procedure TDBLookupGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FTracking and FDataTracking then
  begin
    StopTracking;
    if Y > TitleRowHeight then
      SelectItemAt(X, Y);
    if Assigned(OnMouseUp) then OnMouseUp(Self, Button, Shift, X, Y);
  end else
    inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBLookupGridEh.TimerScroll;
var
  Delta, Distance, Interval: Integer;
begin
  BeginInrenalListDataChanging;
  try
  Delta := 0;
  Distance := 0;
  if FMousePos < 0 then
  begin
    Delta := -1;
    Distance := -FMousePos;
  end;
  if FMousePos >= ClientHeight then
  begin
    Delta := 1;
    Distance := FMousePos - ClientHeight + 1;
  end;
  if Delta = 0
    then StopTimer
  else
  begin
    if SpecRow.Visible and (FMousePos < 0) and ListLink.DataSet.Bof then
      SelectSpecRow
    else if ListLink.DataSet.MoveBy(Delta) <> 0 then SelectCurrent;
    Interval := 200 - Distance * 15;
    if Interval < 0 then Interval := 0;
    ResetTimer(Interval);
  end;
  finally
    EndInrenalListDataChanging;
  end;
end;

procedure TDBLookupGridEh.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  BorderSize, TextHeight, SpecRowHeight, Rows, AddLine, NewHeight: Integer;
begin
  if (dghAutoFitRowHeight in OptionsEh) and (ListLink.Active) then
  begin
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  end else
  begin
    BorderSize := GetBorderSize;
    TextHeight := GetDataRowHeight;
    SpecRowHeight := GetSpecRowHeight;
    if Assigned(SpecRow) and SpecRow.Visible
      then FSpecRowHeight := SpecRowHeight
      else FSpecRowHeight := 0;
    Rows := (AHeight - BorderSize - TitleRowHeight - FSpecRowHeight) div TextHeight;
    if Rows < 1 then Rows := 1;
    FRowCount := Rows;
    AddLine := 0;
    if dgRowLines in inherited Options then
       Inc(AddLine, GridLineWidth);
    if AutoHeight
      then NewHeight := Rows * TextHeight + BorderSize + TitleRowHeight + FSpecRowHeight + AddLine
      else NewHeight := AHeight;
    inherited SetBounds(ALeft, ATop, AWidth, NewHeight);
  end
end;

{$IFDEF FPC}
{$ELSE}
function TDBLookupGridEh.CanResize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  if (AutoHeight) then
    NewHeight := AdjustHeight(NewHeight);
end;
{$ENDIF}

function TDBLookupGridEh.AutoHeight: Boolean;
begin
  Result := True;
end;

function TDBLookupGridEh.AdjustHeight(OfferedHeight: Integer): Integer;
var
  BorderSize, TextHeight, SpecRowHeight, Rows, AddLine: Integer;
begin
  if (dghAutoFitRowHeight in OptionsEh) and (ListLink.Active) then
  begin
    Result := OfferedHeight;
  end else
  begin
    BorderSize := GetBorderSize;
    TextHeight := GetDataRowHeight;
    SpecRowHeight := GetSpecRowHeight;
    if Assigned(SpecRow) and SpecRow.Visible
      then FSpecRowHeight := SpecRowHeight
      else FSpecRowHeight := 0;
    Rows := (OfferedHeight - BorderSize - TitleRowHeight - FSpecRowHeight) div TextHeight;
    if Rows < 1 then Rows := 1;
    AddLine := 0;
    if dgRowLines in inherited Options then Inc(AddLine, GridLineWidth);
    Result := Rows * TextHeight + BorderSize + TitleRowHeight + FSpecRowHeight + AddLine;
  end;
end;

function TDBLookupGridEh.CalcAutoHeightForRowCount(NewRowCount: Integer): Integer;
var
  NewHeight, DataHeight: Integer;
  i: Integer;
begin
  if Assigned(SpecRow) and SpecRow.Visible
    then FSpecRowHeight := GetSpecRowHeight
    else FSpecRowHeight := 0;
  NewHeight := 0;
  if dgTitles in inherited Options then NewHeight := RowHeights[0];
  if dgRowLines in inherited Options then Inc(NewHeight, GridLineWidth);
  if (dghAutoFitRowHeight in OptionsEh) and (ListLink.Active) then
  begin
    UpdateAllDataRowHeights;
    DataHeight := 0;
    for i := FixedRowCount to FixedRowCount + NewRowCount - 1 do
    begin
      if (i < inherited RowCount) then
      begin
        DataHeight := DataHeight + RowHeights[i];
      end;
    end;
    Inc(NewHeight, DataHeight);
  end else
  begin
    Inc(NewHeight, DefaultRowHeight * NewRowCount);
    if dgRowLines in inherited Options then Inc(NewHeight, NewRowCount * GridLineWidth);
  end;
  Inc(NewHeight, GetBorderSize);
  Result := NewHeight + FSpecRowHeight;
end;

procedure TDBLookupGridEh.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 100 then Value := 100;
  Height := CalcAutoHeightForRowCount(Value);
end;

function TDBLookupGridEh.GetTitleRowHeight: Integer;
begin
  if ShowTitles
    then Result := RowHeights[0]
    else Result := 0;
end;

procedure TDBLookupGridEh.GetDataForVertScrollBar(var APosition, AMin, AMax,
  APageSize: Integer);
var
  Pos, Max: Integer;
  Page: Cardinal;
begin
  if ExtendedScrolling then
  begin
    inherited GetDataForVertScrollBar(APosition, AMin, AMax, APageSize);
    Exit;
  end;
  if not HandleAllocated then Exit;
  Pos := 0;
  Max := 0;
  Page := 0;
  if not ListLink.Active then
    Max := 2
  else if (ListLink.DataSet <> nil) and ListLink.DataSet.IsSequenced then
  begin
    Page := DataRowCount;
    Max := ListLink.DataSet.RecordCount - 1;
    if ListLink.DataSet.State in [dsInactive, dsBrowse, dsEdit] then
      Pos := ListLink.DataSet.RecNo - ListLink.ActiveRecord - 1;
  end else if FRecordCount = DataRowCount then
  begin
    Max := 4;
    if not ListLink.DataSet.BOF then
      if not ListLink.DataSet.EOF then Pos := 2 else Pos := 4;
  end;
  begin
    APosition := Pos;
    AMin := 0;
    AMax := Max;
    APageSize := Page;
  end;
end;

procedure TDBLookupGridEh.UpdateRowCount;
begin
  if FInternalHeightSetting then Exit;
  FInternalHeightSetting := True;
  try
    inherited UpdateRowCount;
  finally
    FInternalHeightSetting := False;
  end;
  ListLinkDataChanged;
end;

type TColumnEhCracker = class(TColumnEh) end;

procedure TDBLookupGridEh.ColWidthsChanged;
var
  i, w: Integer;
begin
  w := 0;
  inherited ColWidthsChanged;
  if FInternalWidthSetting = True then Exit;
  if HandleAllocated and (FGridState = gsColSizingEh) and AutoFitColWidths then
  begin
    for i := 0 to ColCount - 1 do
    begin
      Inc(w, CellColWidths[i]);
      if dgColLines in inherited Options then Inc(w, GridLineWidth);
    end;
    w := w + (Width - ClientWidth);
    FInternalWidthSetting := True;
    try
      SetColResizedControlWidth(w);
      for i := 0 to Columns.Count - 1 do
        TColumnEhCracker(Columns[i]).FInitWidth := Columns[i].Width;
    finally
      FInternalWidthSetting := False;
    end;
  end;
end;

procedure TDBLookupGridEh.SetColResizedControlWidth(NewControlWidth: Integer);
var
  fw: Integer;
  newL: Integer;
begin
  if UseRightToLeftAlignment then
  begin
    fw := NewControlWidth + (ClientWidth - (HorzAxis.GridClientStop - HorzAxis.GridClientStart));
    newL := Width - fw;
    SetBounds(Left + newL, Top, fw, Height);
  end else
    Width := NewControlWidth;
end;

procedure TDBLookupGridEh.UpdateColumnsList;
var i: Integer;
begin
  if FInternalWidthSetting then Exit;
  FInternalWidthSetting := True;
  try
    if FLGAutoFitColWidths then
      inherited AutoFitColWidths := True;
    for i := 0 to Columns.Count - 1 do
      TColumnEhCracker(Columns[i]).FInitWidth := Columns[i].Width;
    inherited AutoFitColWidths := False;
  finally
    FInternalWidthSetting := False;
  end;
  RowCount := RowCount; 
end;

function TDBLookupGridEh.GetUseMultiTitle: Boolean;
begin
  Result := inherited UseMultiTitle;
end;

procedure TDBLookupGridEh.SetUseMultiTitle(const Value: Boolean);
begin
  inherited UseMultiTitle := Value;
  RowCount := RowCount; 
end;

function TDBLookupGridEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  BeginInrenalListDataChanging;
  try
  Result := True;
  if ListLink.DataSet <> nil then
  begin
    if ExtendedScrolling then
    begin
      if Shift = [] then
        inherited DoMouseWheelDown(Shift, MousePos);
    end else
      ListLink.DataSet.MoveBy(FRecordCount - FRecordIndex);
    Result := True;
  end;
  finally
    EndInrenalListDataChanging;
  end;
end;

function TDBLookupGridEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  BeginInrenalListDataChanging;
  try
  Result := True;
  if ListLink.DataSet <> nil then
  begin
    if ExtendedScrolling then
    begin
      if Shift = [] then
        inherited DoMouseWheelUp(Shift, MousePos);
    end else
      ListLink.DataSet.MoveBy(-FRecordIndex - 1);
    Result := True;
  end;
  finally
    EndInrenalListDataChanging;
  end;
end;

procedure TDBLookupGridEh.CreateWnd;
begin
  inherited CreateWnd;
  RowCount := RowCount; 
end;

procedure TDBLookupGridEh.DrawSubTitleCell(ACol, ARow: Integer;
   DataCol, DataRow: Integer; CellType: TCellAreaTypeEh; ARect: TRect;
   AState: TGridDrawState; var Highlighted: Boolean);
var
  S: String;
  AAlignment: TAlignment;
  DrawColumn: TDBLookupGridColumnEh;
  AColor: TColor;
  AFillRect: Boolean;
  ImageIndex: Integer;
begin
  Dec(ACol, IndicatorOffset);
  DrawColumn := TDBLookupGridColumnEh(Columns[ACol]);
  Canvas.Font := SpecRow.Font;
  Canvas.Font.Color := StyleServices.GetSystemColor(SpecRow.Font.Color);

  S := DrawColumn.SpecCell.Text;
  AAlignment := DrawColumn.Alignment;
  Canvas.Brush.Color := StyleServices.GetSystemColor(DrawColumn.SpecCell.Color);
  AFillRect := True;
  if SpecRow.Selected then
  begin
    AState := AState + [gdSelected];
    AColor := Canvas.Brush.Color;
    HighlightLookupGridCellColor(DataCol, DataRow, True, S, AState, AColor, Canvas.Font);
    Canvas.Brush.Color := AColor;
    if IsDrawCellSelectionThemed(ACol, ARow, DataCol, DataRow, AState) then
    begin
      Canvas.FillRect(ARect);
      DrawCellDataBackground(ACol, ARow, DataCol, DataRow, DrawColumn, ARect, AState, dgRowSelect in inherited Options);
      AFillRect := False;
    end;
  end;

  if (DrawColumn.ImageList <> nil) and (DrawColumn.SpecCell.ImageIndex >= 0) then
  begin
    ImageIndex := DrawColumn.SpecCell.ImageIndex;
    if AFillRect then
      Canvas.FillRect(ARect);
    PaintClippedImage(DrawColumn.ImageList, nil, Canvas, ARect, ImageIndex, 0, taCenter, ARect);
  end else
    WriteCellText(DrawColumn, Canvas, ARect, AFillRect, 2, 1, S, AAlignment, tlTop, False, False, 0, 0, True);

  if SpecRow.Selected then
  begin
    Canvas.Font.Color := StyleServices.GetSystemColor(clWindowText);
    Canvas.Brush.Color := StyleServices.GetSystemColor(clWindow);
    Canvas.DrawFocusRect(BoxRect(FixedColCount, ARow, ColCount-1, ARow));
  end;
end;

function TDBLookupGridEh.ExtendedScrolling: Boolean;
begin
  Result := MemTableSupport;
end;

function TDBLookupGridEh.CellHave3DRect(ACol, ARow: Integer; AState: TGridDrawState): Boolean;
begin
  if SpecRow.Visible and (TopDataOffset - 1 = ARow)
    then Result := False
    else Result := inherited CellHave3DRect(ACol, ARow, AState);
end;

function TDBLookupGridEh.DataRect: TRect;
begin
  Result := BoxRect(IndicatorOffset,
                    iif(SpecRow.Visible, TopDataOffset - 1, TopDataOffset),
                    ColCount - 1,
                    iif(FooterRowCount > 0, inherited RowCount - FooterRowCount - 2, inherited RowCount-1));
end;

procedure TDBLookupGridEh.DefineFieldMap;
var
  I: Integer;
begin
  if Columns.State = csCustomized then
  begin { Build the column/field map from the column attributes }
    DataLink.SparseMap := True;
    for I := 0 to Columns.Count - 1 do
      DataLink.AddMapping(Columns[I].FieldName);
  end else { Build the column/field map from the field list order }
  begin
    DataLink.SparseMap := False;
    for I := 0 to ListFields.Count - 1 do
      Datalink.AddMapping(TField(ListFields[I]).FieldName);
  end;
end;

procedure TDBLookupGridEh.GetDatasetFieldList(FieldList: TObjectList);
var i: Integer;
begin
  for i := 0 to ListFields.Count - 1 do
    FieldList.Add(ListFields[i]);
end;

function TDBLookupGridEh.GetAutoFitColWidths: Boolean;
begin
  Result := FLGAutoFitColWidths;
end;

procedure TDBLookupGridEh.SetAutoFitColWidths(const Value: Boolean);
begin
  if AutoFitColWidths <> Value then
  begin
    FLGAutoFitColWidths := Value;
    HorzScrollBar.Visible := not FLGAutoFitColWidths;
    RowCount := RowCount; 
    UpdateScrollBars;
    UpdateColumnsList;
  end;
end;

function TDBLookupGridEh.GetColumnsWidthToFit: Integer;
var i: Integer;
begin
  Result := 0;
  for i := 0 to Columns.Count - 1 do
  begin
    if Columns[i].Visible then
      if AutoFitColWidths
        then Inc(Result, TColumnEhCracker(Columns[i]).FInitWidth)
        else Inc(Result, Columns[i].Width);
    if dgColLines in inherited Options then Inc(Result, GridLineWidth);
  end;
end;

procedure TDBLookupGridEh.SetOptions(const Value: TDBLookupGridEhOptions);
var
  NewGridOptions, NewNoGridOptions: TDBGridOptions;
  NewGridOptionsEh, NewNoGridOptionsEh: TDBGridEhOptions;
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    NewGridOptions := [];
    NewNoGridOptions := [];
    if dlgColumnResizeEh in FOptions
      then NewGridOptions := NewGridOptions + [dgColumnResize]
      else NewNoGridOptions := NewNoGridOptions + [dgColumnResize];
    if dlgColLinesEh in FOptions
      then NewGridOptions := NewGridOptions + [dgColLines]
      else NewNoGridOptions := NewNoGridOptions + [dgColLines];
    if dlgRowLinesEh in FOptions
      then NewGridOptions := NewGridOptions + [dgRowLines]
      else NewNoGridOptions := NewNoGridOptions + [dgRowLines];

    inherited Options := inherited Options + NewGridOptions - NewNoGridOptions;

    NewGridOptionsEh := [];
    NewNoGridOptionsEh := [];
    if dlgAutoSortMarkingEh in FOptions
      then NewGridOptionsEh := NewGridOptionsEh + [dghAutoSortMarking]
      else NewNoGridOptionsEh := NewNoGridOptionsEh + [dghAutoSortMarking];
    if dlgMultiSortMarkingEh in FOptions
      then NewGridOptionsEh := NewGridOptionsEh + [dghMultiSortMarking]
      else NewNoGridOptionsEh := NewNoGridOptionsEh + [dghMultiSortMarking];
    if dlgAutoFitRowHeightEh in FOptions
      then NewGridOptionsEh := NewGridOptionsEh + [dghAutoFitRowHeight]
      else NewNoGridOptionsEh := NewNoGridOptionsEh + [dghAutoFitRowHeight];

    inherited OptionsEh := inherited OptionsEh + NewGridOptionsEh - NewNoGridOptionsEh;
  end;
end;

function TDBLookupGridEh.CreateAxisBars: TGridAxisBarsEh;
begin
  Result := TDBGridColumnsEh.Create(Self, TDBLookupGridColumnEh);
end;

function TDBLookupGridEh.CreateAxisBarDefValues: TAxisBarDefValuesEh;
begin
  Result := TDBLookupGridColumnDefValuesEh.Create(Self);
end;

{CM messages processing}

{$IFDEF FPC}
{$ELSE}
procedure TDBLookupGridEh.CMRecreateWnd(var Message: TMessage);
begin
  if FInternalWidthSetting
    then Exit
    else Inherited;
end;
{$ENDIF}

{WM messages processing}

procedure TDBLookupGridEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TDBLookupGridEh.WMKillFocus(var Message: TWMKillFocus);
begin
  FHasFocus := False;
  inherited;
  Invalidate;
end;

procedure TDBLookupGridEh.WMSetFocus(var Message: TWMSetFocus);
begin
  SearchText := '';
  FHasFocus := True;
  inherited;
  Invalidate;
end;

procedure TDBLookupGridEh.WMSetCursor(var Msg: TWMSetCursor);
var
  Cell: TGridCoord;
begin
  Cell := MouseCoord(HitTest.X, HitTest.Y);
  if SpecRow.Visible and (TopDataOffset - 1 = Cell.Y) then
    Exit;
  inherited;
end;

procedure TDBLookupGridEh.WMSize(var Message: TWMSize);
begin
  if FInternalWidthSetting then
    inherited
  else
  begin
    FInternalWidthSetting := True;
    if FLGAutoFitColWidths then
      FAutoFitColWidths := True;
    try
      inherited;
    finally
      FInternalWidthSetting := False;
      FAutoFitColWidths := False;
    end;
  end;
end;

procedure TDBLookupGridEh.VertScrollBarMessage(ScrollCode, Pos: Integer);
var
  OldRecNo: Integer;
  OldActiveRec: Integer;
  ds: TDataSet;
begin
  BeginInrenalListDataChanging;
  try
  SearchText := '';
  if not ListLink.Active then
    Exit;
  if ExtendedScrolling then
  begin
    inherited
  end else
  begin
    ds := ListLink.DataSet;
    case ScrollCode of
      SB_LINEUP: ds.MoveBy(-FRecordIndex - 1);
      SB_LINEDOWN: ds.MoveBy(FRecordCount - FRecordIndex);
      SB_PAGEUP: ds.MoveBy(-FRecordIndex - FRecordCount + 1);
      SB_PAGEDOWN: ds.MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
      SB_THUMBPOSITION:
        begin
          case Pos of
            0: ds.First;
            1: ds.MoveBy(-FRecordIndex - FRecordCount + 1);
            2: Exit;
            3: ds.MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
            4: ds.Last;
          end;
        end;
      SB_BOTTOM: ds.Last;
      SB_TOP: ds.First;
      SB_THUMBTRACK:
        if ds.IsSequenced then
        begin
          OldActiveRec := ListLink.ActiveRecord;
          ListLink.ActiveRecord := 0;
          OldRecNo := ds.RecNo - 1;
          if Pos < OldRecNo then
            ds.MoveBy(Pos - OldRecNo)
          else if Pos > OldRecNo then
            ds.MoveBy(Pos - OldRecNo + ListLink.RecordCount - 1)
          else
            ListLink.ActiveRecord := OldActiveRec;
        end;
    end;
  end;
  finally
    EndInrenalListDataChanging;
  end;
end;

function TDBLookupGridEh.CompatibleVarValue(AFieldsArr: TFieldsArrEh; AVlaue: Variant): Boolean;
begin
  Result := True
{  Result := ((Length(AFieldsArr) = 1) and not VarIsArray(AVlaue)) or
            ((Length(AFieldsArr) > 1) and VarIsArray(AVlaue) and
             ( VarArrayHighBound(AVlaue, 1) - VarArrayLowBound(AVlaue, 1) = Length(AFieldsArr)-1 )
            );}
end;

function TDBLookupGridEh.GetSubTitleRows: Integer;
begin
  Result := inherited GetSubTitleRows;
  if (SpecRow <> nil) and SpecRow.Visible then
    Result := Result + 1;
end;

procedure TDBLookupGridEh.CMHintShow(var Message: TCMHintShow);
{$IFDEF CIL}
var
  AHintInfo: THintInfo;
{$ENDIF}
begin
{$IFDEF CIL}
  if Message.OriginalMessage.LParam = 0 then Exit;
  AHintInfo := Message.HintInfo;
  AHintInfo.HintStr := Hint;
  Message.HintInfo := AHintInfo;
{$ELSE}
  Message.HintInfo^.HintStr := Hint;
{$ENDIF}
  inherited;
end;

function TDBLookupGridEh.InrenalListDataChanging;
begin
  Result := (FInrenalListDataChanging > 0);
end;

procedure TDBLookupGridEh.BeginInrenalListDataChanging;
begin
  Inc(FInrenalListDataChanging);
end;

procedure TDBLookupGridEh.EndInrenalListDataChanging;
begin
  Dec(FInrenalListDataChanging);
end;

{ TPopupInnerDataGridEh }

constructor TPopupInnerDataGridEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  FPopup := True;
  ShowHint := True;
  SizeGripAlwaysShow := True;
  {$IFDEF FPC}
  BorderStyle := bsSingle;
  {$ENDIF}
  Constraints.MinWidth := GetSystemMetrics(SM_CXVSCROLL);
  Constraints.MinHeight := GetSystemMetrics(SM_CYVSCROLL);
end;

destructor TPopupInnerDataGridEh.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF FPC}
{$ELSE}
function TPopupInnerDataGridEh.CanResize(var NewWidth, NewHeight: Integer): Boolean;
var
  MinHeight: Integer;
begin
  Result := True;
  if NewWidth < GetSystemMetrics(SM_CXVSCROLL)*2 then
    NewWidth := GetSystemMetrics(SM_CXVSCROLL)*2;
  MinHeight := GetBorderSize + GetDataRowHeight;
  if Assigned(SpecRow) and SpecRow.Visible then
   MinHeight := MinHeight + GetSpecRowHeight;
  if NewHeight < MinHeight then
    NewHeight := MinHeight;
end;
{$ENDIF}

procedure TPopupInnerDataGridEh.CMSetSizeGripChangePosition(var Message: TMessage);
var
  NewPosition: TSizeGripChangePosition;
begin
  NewPosition := TSizeGripChangePosition(Message.WParam);
  if NewPosition = sgcpToLeft then
  begin
    if SizeGripPostion = sgpTopRight then
      SizeGripPostion := sgpTopLeft
    else if SizeGripPostion = sgpBottomRight then
      SizeGripPostion := sgpBottomLeft;
  end else if NewPosition = sgcpToRight then
  begin
    if SizeGripPostion = sgpTopLeft then
      SizeGripPostion := sgpTopRight
    else if SizeGripPostion = sgpBottomLeft then
      SizeGripPostion := sgpBottomRight
  end else if NewPosition = sgcpToTop then
  begin
    if SizeGripPostion = sgpBottomRight then
      SizeGripPostion := sgpTopRight
    else if SizeGripPostion = sgpBottomLeft then
      SizeGripPostion := sgpTopLeft
  end else if NewPosition = sgcpToBottom then
  begin
    if SizeGripPostion = sgpTopRight then
      SizeGripPostion := sgpBottomRight
    else if SizeGripPostion = sgpTopLeft then
      SizeGripPostion := sgpBottomLeft
  end
end;

procedure TPopupInnerDataGridEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FUserKeyValueChanged := True;
  try
    inherited KeyDown(Key, Shift);
  finally
    FUserKeyValueChanged := False;
  end;
end;

procedure TPopupInnerDataGridEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
end;

procedure TPopupInnerDataGridEh.KeyValueChanged;
begin
  inherited KeyValueChanged;
  if Assigned(OnUserKeyValueChange) and FUserKeyValueChanged then
    OnUserKeyValueChange(Self);
end;

procedure TPopupInnerDataGridEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FUserKeyValueChanged := True;
  FKeySelection := True;
  try
    inherited MouseDown(Button, Shift, X, Y);
    if CellTreeElementMouseDown(X, Y, True) then
      FKeySelection := False;
  finally
    FUserKeyValueChanged := False;
  end;
end;

procedure TPopupInnerDataGridEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FUserKeyValueChanged := True;
  try
    inherited MouseMove(Shift, X, Y);
    if ([ssLeft, ssRight, ssMiddle] * Shift = []) and not ReadOnly then
      SelectItemAt(X, Y);
  finally
    FUserKeyValueChanged := False;
  end;
end;

procedure TPopupInnerDataGridEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
  ADataBox: TGridRect;
  AGridState: TGridStateEh;
begin
  try
    AGridState := FGridState;
    inherited MouseUp(Button, Shift, X, Y);
    if not (AGridState = gsNormalEh) or not FKeySelection then Exit;
    if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then
      OnMouseCloseUp(Self, False)
    else
    begin
      Cell := MouseCoord(X, Y);
      ADataBox := DataBox;
      if ((Cell.X >= ADataBox.Left) and (Cell.X <= ADataBox.Right) and
        (Cell.Y >= ADataBox.Top) and (Cell.Y <= ADataBox.Bottom)) or
        (SpecRow.Visible and (TopDataOffset - 1 = Cell.Y)) then
        OnMouseCloseUp(Self, True)
    end
  finally
  end;
end;

procedure TPopupInnerDataGridEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  inherited;
end;

procedure TPopupInnerDataGridEh.WMSize(var Message: TWMSize);
begin
  inherited;
  FSizeGripResized := True;
  Repaint;
end;

procedure TPopupInnerDataGridEh.DrawBorder;
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  DC: HDC;
  R: TRect;
begin
  if Ctl3D = True and not CustomStyleActive then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;
{$ENDIF} 

function TPopupInnerDataGridEh.Focused: Boolean;
begin
  Result := True;
end;

function TPopupInnerDataGridEh.CanFocus: Boolean;
begin
  Result := False;
end;

{$IFDEF FPC}
{$ELSE}
procedure TPopupInnerDataGridEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWndHandle;
end;
{$ENDIF}

procedure TPopupInnerDataGridEh.UpdateBorderWidth;
begin
  if Ctl3D and not CustomStyleActive
    then FBorderWidth := 1
    else FBorderWidth := 0;
end;

procedure TPopupInnerDataGridEh.ResetHighlightSubstr(const Text: String; AllColumns: Boolean);
begin
  RemoveHighlightSubstr(FHighlightTextParams);
  FHighlightTextParams.ColumnsList.Clear;
  if Text <> '' then
  begin
    FHighlightTextParams.CaseInsensitivity := True;
    FHighlightTextParams.Text := Text;
    FHighlightTextParams.Color := RGBToColorEh(255,255,150);
    if (AllColumns)
      then FHighlightTextParams.ColumnsList := VisibleColumns
      else FHighlightTextParams.ColumnsList.Add(FindFieldColumn(FListField.FieldName));
    AddHighlightSubstr(FHighlightTextParams);
  end;
end;

procedure TPopupInnerDataGridEh.SetColResizedControlWidth(NewControlWidth: Integer);
begin
  TPopupDataGridBoxEh(Owner).SetColResizedControlWidth(NewControlWidth);
end;

function TPopupInnerDataGridEh.AutoHeight: Boolean;
begin
  Result := False;
end;

initialization
{$IFDEF EH_LIB_16}
  TCustomStyleEngine.RegisterStyleHook(TDBLookupGridEh, TPopupDataGridEhStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TPopupInnerDataGridEh, TPopupDataGridEhStyleHook);
{$ENDIF}
finalization
{$IFDEF EH_LIB_22}
  TCustomStyleEngine.UnRegisterStyleHook(TDBLookupGridEh, TPopupDataGridEhStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TPopupInnerDataGridEh, TPopupDataGridEhStyleHook);
{$ENDIF}
end.
