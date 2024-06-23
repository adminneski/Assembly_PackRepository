{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                     Tool controls                     }
{                                                       }
{      Copyright (c) 2001-2022 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ToolCtrlsEh;

interface

uses
  Contnrs, ActnList, GraphUtil, Variants, Types, Themes, Messages,
  {$IFDEF EH_LIB_17} System.Generics.Collections, System.UITypes, UIConsts, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, Calendar, LCLIntf, WSLCLClasses,

    {$IFDEF FPC_CROSSP}
    {$ELSE}
      CommCtrl, Win32Extra, UxTheme,
    {$ENDIF}

    {$IFDEF FPC_WINDOWS}
      Windows, Win32WSForms, Win32Int, Win32WSControls,
    {$ELSE}
    {$ENDIF}

  {$ELSE}
    EhLibVCL, Mask, ComCtrls, CommCtrl, Windows, UxTheme,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DateUtils, FmtBcd,
  Db, DBCtrls, Buttons, ButtonsEh, ExtCtrls, Menus,
  Imglist, StrUtils, DynVarsEh, EhLibImageReses;

const
  CM_IGNOREEDITDOWN = WM_USER + 102;
  {$IFDEF EH_LIB_16}
  {$ELSE}
  CM_STYLECHANGED   = CM_BASE + 81;
  {$ENDIF}
  NullDateEh = -693594;

  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}

var
  EhLibRegKey: String = 'EhLib';

type

  TLocateTextOptionEh = (ltoCaseInsensitiveEh, ltoAllFieldsEh, ltoMatchFormatEh,
    ltoIgnoteCurrentPosEh, ltoStopOnEscapeEh, ltoInsideSelectionEh, ltoRestartAfterLastHitEh,
    ltoWholeWordsEh, ltoStopKeyMessageEh);
  TLocateTextOptionsEh = set of TLocateTextOptionEh;
  TLocateTextDirectionEh = (ltdUpEh, ltdDownEh, ltdAllEh);
  TLocateTextMatchingEh = (ltmAnyPartEh, ltmWholeEh, ltmFromBegingEh);
  TLocateTextTreeFindRangeEh = (lttInAllNodesEh, lttInExpandedNodesEh,
    lttInCurrentLevelEh, lttInCurrentNodeEh);
  TSortOrderEh =  (soAscEh, soDescEh);

  TImagePlacementEh = (ipTopLeftEh, ipTopCenterEh, ipTopRightEh,
                       ipCenterLeftEh, ipCenterCenterEh, ipCenterRightEh,
                       ipBottomLeftEh, ipBottomCenterEh, ipBottomRightEh,
                       ipFillEh, ipReduceFitEh, ipFitEh, ipStretchEh, ipTileEh);

  TListNotificationEh = (ListItemAddedEh, ListItemDeletedEh, ListItemChangedEh, ListChangedEh);
  TTextOrientationEh = (tohHorizontal, tohVertical);
  TStateBooleanEh = (sbTrueEh, sbFalseEh, stUndefinedEh);
  TEquilateralTriangleDirectionEh = (etdUpEh, etdDownEh, etdLeftEh, etdRightEh);

  TCalendarDateTimeUnitEh = (cdtuYearEh, cdtuMonthEh, cdtuDayEh, cdtuHourEh,
    cdtuMinuteEh, cdtuSecondEh, cdtuAmPmEh);
  TCalendarDateTimeUnitsEh = set of TCalendarDateTimeUnitEh;

  TWeekDayEh = (wwdMondayEh, wwdTuesdayEh, wwdWednesdayEh, wwdThursdayEh,
    wwdFridayEh, wwdSaturdayEh, wwdSundayEh);
  TWeekDaysEh = set of TWeekDayEh;

  THoursTimeFormatEh = (htfAmPm12hEh, htf24hEh);
  TAmPmPosEh = (appAmPmSuffixEh, appAmPmPrefixEh);

  TEditButtonImagesEh = class;
  TEditButtonEh = class;
  TEditButtonControlEh = class;

  TCloseWinCallbackProcEh = procedure(Control: TWinControl; Accept: Boolean) of object;

  IMemTableDataFieldValueListEh = interface
    ['{28F8194C-5FF3-42C4-87A6-8B3E06210FA6}']
    function GetValues: TStrings;
    procedure SetFilter(const Filter: String);
  end;

  IComboEditEh = interface
    ['{B64255B5-386A-4524-8BC7-7F49DDB410F4}']
    procedure CloseUp(Accept: Boolean);
  end;

  ICalcFieldEh = interface
    ['{E564FFA8-A1D5-4A02-B64F-9E47F5C8F2DF}']
    function CanModifyWithoutEditMode: Boolean;
  end;

  ISideOwnedComponentEh = interface
    ['{C08052DC-C187-4BD3-B818-F26E7D245600}']
    function IsSideParentedBy(AComponent: TComponent): Boolean;
    procedure SetSideParent(AComponent: TComponent);
  end;

  ISideOwnerEh = interface
    ['{36EE47C7-5E1D-4FA6-91FF-1489151FB90B}']
    function IsSideParentableForProperty(const PropertyName: String): Boolean;
    function CanSideOwnClass(ComponentClass: TComponentClass): Boolean;
  end;

  ISimpleChangeNotificationEh = interface
    ['{0880C65D-FAF5-4AEF-AE6B-4C62141DC320}']
    procedure Change(Sender: TObject);
  end;

  IDefaultItemsCollectionEh = interface
    ['{382EF9DE-34D2-4E23-82C8-5DC51B8E1CCE}']
    function CanAddDefaultItems: Boolean;
    procedure AddAllItems(DeleteExisting: Boolean);
  end;

  IPopupDateTimePickerEh = interface
    ['{07821174-A309-4F9E-8F10-AA3F5818F167}']
    function GetDateTime: TDateTime;
    function GetTimeUnits: TCalendarDateTimeUnitsEh;
    function WantKeyDown(Key: Word; Shift: TShiftState): Boolean;
    function WantFocus: Boolean;
    procedure HidePicker;
    procedure SetTimeUnits(const Value: TCalendarDateTimeUnitsEh);
    procedure SetFontOptions(Font: TFont; FontAutoSelect: Boolean);
    procedure ShowPicker(DateTime: TDateTime; Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
    procedure UpdateSize;
  end;

{ TStringsEh }

  TStringsEh = class(TStrings)
  public
    function Replace(const SearchStr, ReplaceStr: string; StartPos, Length: Integer; Options: TSearchTypes; ReplaceAll: Boolean): Integer; virtual;
  end;
//{$ENDIF}

{ TDropDownFormSysParams }

  TDropDownFormSysParams = class(TPersistent)
  private
    FFreeFormOnClose: Boolean;
  public
    property FreeFormOnClose: Boolean read FFreeFormOnClose write FFreeFormOnClose;
  end;

{ TEditControlDropDownFormSysParams }

  TEditControlDropDownFormSysParams = class(TDropDownFormSysParams)
  public
    FEditControl: TControl;
    FEditButton: TEditButtonEh;
    FEditButtonObj: TObject;
  end;

  TDropDownFormCallbackProcEh = procedure(DropDownForm: TCustomForm;
    Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams) of object;

  TSetVarValueProcEh = procedure(const VarValue: Variant) of object;
  TGetVarValueProcEh = procedure(var VarValue: Variant) of object;
  TCheckDataIsReadOnlyEventEh = procedure(var ReadOnly: Boolean) of object;

  TGetDropDownFormEventEh = procedure(var DropDownForm: TCustomForm;
    var FreeFormOnClose: Boolean) of object;

  IDropDownFormEh = interface
    ['{A665F4AE-003C-465E-95E9-B1061E9EAEF4}']
    function Execute(RelativePosControl: TControl; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh): Boolean;
    function GetReadOnly: Boolean;
    procedure ExecuteNomodal(RelativePosResc: TRect; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams; CallbackProc: TDropDownFormCallbackProcEh);
    procedure Close;
    procedure SetReadOnly(const Value: Boolean);

    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
  end;

  TDropDownPassParamsEh = (pspByFieldNamesEh, pspFieldValueEh, pspRecordValuesEh,
    pspCustomValuesEh);

  TRichStringEh = String;
  TFieldsArrEh = array of TField;
  TVariantArrayEh = array of Variant;

  TAggrFunctionEh = (agfSumEh, agfCountEh, agfAvg, agfMin, agfMax);
  TAggrFunctionsEh = set of TAggrFunctionEh;
  TAggrResultArr = array [TAggrFunctionEh] of Variant;

  TRectangleEdgeEh = (reLeftEh, reTopEh, reRightEh, reBottomEh);
  TRectangleEdgesEh = set of TRectangleEdgeEh;

{ Standard events }

  TButtonClickEventEh = procedure(Sender: TObject; var Handled: Boolean) of object;
  TCloseUpEventEh = procedure(Sender: TObject; Accept: Boolean) of object;
  TAcceptEventEh = procedure(Sender: TObject; var Accept: Boolean) of object;
  TNotInListEventEh = procedure(Sender: TObject; NewText: String;
    var RecheckInList: Boolean) of object;
  TUpdateDataEventEh = procedure(Sender: TObject; var Handled: Boolean) of object;
  TGetFieldDataEventEh = procedure(Sender: TObject; var Value: Variant; var Handled: Boolean) of object;
  TListSortExchangeItemsEh = procedure(List: Pointer; ItemIndex1, ItemIndex2: Integer);
  TListSortCompareItemsEh = function(List: Pointer; ItemIndex1, ItemIndex2: Integer): Integer;

  TExternalSortDataItemEh = record
    Desc: Boolean;
    DataType: TFieldType;
  end;

  TExternalSortDataArrEh = array of  TExternalSortDataItemEh;

{ TOrderByItemEh }

  TOrderByItemEh = class(TObject)
  public
    FieldIndex: Integer;
    MTFieldIndex: Integer;
    Desc: Boolean;
    CaseIns: Boolean;
    ExtObjIndex: Integer;
    DataType: TFieldType;
  end;

{ TOrderByList }

  TOrderByList = class(TObjectListEh)
  protected
    function GetItem(Index: Integer): TOrderByItemEh;
    procedure SetItem(Index: Integer; const Value: TOrderByItemEh);
    procedure AssignFieldIndex(OrderItem: TOrderByItemEh; const FieldIndex: Integer); virtual;
    function FindFieldIndex(const FieldName: String): Integer; virtual;
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;
    function GetToken(const Exp: String; var FromIndex: Integer): String;
    procedure ParseOrderByStr(const OrderByStr: String);
    procedure ClearFreeItems;
    property Items[Index: Integer]: TOrderByItemEh read GetItem write SetItem; default;
  end;

{ TBMListEh }

  TBMListEh = class;

  TBMListSortCompare = function(List: TBMListEh; DataSet: TDataSet; Index1, Index2: Integer): Integer;

  TBMListEh = class(TObject)
  private
    FCache: TUniBookmarkEh;
    FCacheFind: Boolean;
    FCacheIndex: Integer;
    FLinkActive: Boolean;
    FUpdateCount: Integer;
    function GetCount: Integer;
    function GetCurrentRowSelected: Boolean;
    function GetItem(Index: Integer): TUniBookmarkEh;
    procedure QuickSort(DataSet: TDataSet; L, R: Integer; SCompare: TBMListSortCompare);
    procedure SetItem(Index: Integer; Item: TUniBookmarkEh);

  protected
{$IFDEF TBookMarkAsTBytes}
    FList: array of TBookmark;
{$ELSE}
    FList: TStringList;
{$ENDIF}
    function Compare(const Item1, Item2: TUniBookmarkEh): Integer;
    function CurrentRow: TUniBookmarkEh;
    function GetDataSet: TDataSet; virtual;
    function IsLinkActive: Boolean; virtual;

    procedure AppendItem(Item: TUniBookmarkEh); virtual;
    procedure CustomSort(DataSet: TDataSet; Compare: TBMListSortCompare); virtual;
    procedure InsertItem(Index: Integer; Item: TUniBookmarkEh); virtual;
    procedure Invalidate; virtual;
    procedure LinkActive(Value: Boolean);
    procedure ListChanged(); virtual;
    procedure ListChangedEventHandler(Sender: TObject);
    procedure RaiseBMListError(const S: string); virtual;
    procedure Resort; virtual;
    procedure SetCurrentRowSelected(Value: Boolean); virtual;
    procedure UpdateState; virtual;

  public
    constructor Create;
    destructor Destroy; override;

    function DeleteBookmark(Item: TUniBookmarkEh): Boolean; virtual;
    function Find(const Item: TUniBookmarkEh; var Index: Integer): Boolean;
    function IndexOf(const Item: TUniBookmarkEh): Integer;
    function Refresh(DeleteInvalid: Boolean): Boolean;
    function Updating: Boolean;

    procedure AppendBookmark(Item: TUniBookmarkEh); virtual;
    procedure Clear; virtual;
    procedure Delete;
    procedure DeleteItem(Index: Integer); virtual;
    procedure SelectAll; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;

    property Count: Integer read GetCount;
    property CurrentRowSelected: Boolean read GetCurrentRowSelected write SetCurrentRowSelected;
    property DataSet: TDataSet read GetDataSet;
    property Items[Index: Integer]: TUniBookmarkEh read GetItem write SetItem; default;
  end;

  IMemTableEh = interface
    ['{A8C3C87A-E556-4BDB-B8A7-5B33497D1624}']
    function FetchRecords(Count: Integer): Integer;
    function GetInstantReadCurRowNum: Integer;
    function GetTreeNodeExpanded(RowNum: Integer): Boolean; overload;
    function GetTreeNodeExpanded: Boolean; overload;
    function GetTreeNodeHasChields: Boolean;
    function GetTreeNodeLevel: Integer;
    function GetPrevVisibleTreeNodeLevel: Integer;
    function GetNextVisibleTreeNodeLevel: Integer;
    function GetRecObject: TObject;
    function InstantReadIndexOfBookmark(Bookmark: TUniBookmarkEh): Integer;
    function InstantReadRowCount: Integer;
    function InstantReadViewRow: Integer;
    function IsInOperatorSupported: Boolean;
    function MemTableIsTreeList: Boolean;
    function ApplyExtraFilter(const FilterStr: String; FilterProc: TFilterRecordEvent): TObject;
    function ResetExtraFilter(FilterObject: TObject; const FilterStr: String; FilterProc: TFilterRecordEvent): Boolean;
    function RevokeExtraFilter(FilterObject: TObject): Boolean;
    function ParentHasNextSibling(ParenLevel: Integer): Boolean;
    function ParentHasPriorSibling(ParenLevel: Integer): Boolean;
    function SetToRec(Rec: TObject): Boolean;
    function SetTreeNodeExpanded(RowNum: Integer; Value: Boolean): Integer;
    function GetFieldValueList(const FieldName: String): IMemTableDataFieldValueListEh;
    function MoveRecords(BookmarkList: TBMListEh; ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    function GetLikeWildcardForOneCharacter: String;
    function GetLikeWildcardForSeveralCharacters: String;
    function BookmarkInVisibleView({$IFDEF CIL}const{$ENDIF} Bookmark: TUniBookmarkEh): Boolean;

    procedure GetAggregatedValuesForRange(FromBM, ToBM: TUniBookmarkEh; const FieldName: String; var FieldNaeResultArr: TAggrResultArr; AggrFuncs: TAggrFunctionsEh);
    procedure MTDisableControls;
    procedure MTEnableControls(ForceUpdateState: Boolean);
    procedure InstantReadEnter(RowNum: Integer);
    procedure InstantReadLeave;
    procedure RegisterEventReceiver(AComponent: TPersistent);
    procedure UnregisterEventReceiver(AComponent: TPersistent);
    procedure FilterAbort;

    property InstantReadCurRowNum: Integer read GetInstantReadCurRowNum;
  end;

  TMTViewEventTypeEh = (mtRowInsertedEh, mtRowChangedEh, mtRowDeletedEh,
    mtRowMovedEh, mtViewDataChangedEh);

  IMTEventReceiverEh = interface
    ['{60C6C1A2-A817-4043-885A-BDDC750587BD}']
    procedure MTViewDataEvent(RowNum: Integer;
      Event: TMTViewEventTypeEh; OldRowNum: Integer);
  end;

{ TDropDownFormCallParamsEh }

  TEditControlShowDropDownFormEventEh = procedure(EditControl: TControl;
    Button: TEditButtonEh; var DropDownForm: TCustomForm;
    DynParams: TDynVarsEh) of object;

  TEditControlCloseDropDownFormEventEh = procedure(EditControl: TControl;
    Button: TEditButtonEh; Accept: Boolean; DropDownForm: TCustomForm;
    DynParams: TDynVarsEh) of object;

  TDropDownFormCallParamsEh = class(TPersistent)
  private
    FAlign: TDropDownAlign;
    FAssignBackFieldNames: String;
    FDropDownForm: TCustomForm;
    FDropDownFormClassName: String;
    FFormHeight: Integer;
    FFormWidth: Integer;
    FOldFormHeight: Integer;
    FOldFormWidth: Integer;
    FPassFieldNames: String;
    FPassParams: TDropDownPassParamsEh;
    FSaveFormSize: Boolean;

    FOnChanged: TNotifyEvent;
    FOnCheckDataIsReadOnly: TCheckDataIsReadOnlyEventEh;

    procedure SetDropDownForm(const Value: TCustomForm);
    procedure SetDropDownFormClassName(const Value: String);

  protected
    FDataLink: TDataLink;
    FEditButton: TEditButtonEh;
    FEditButtonControl: TEditButtonControlEh;
    FEditControl: TWinControl;
    FEditControlScreenRect: TRect;
    FField: TField;

    FOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh;
    FOnGetActualDropDownFormProc: TGetDropDownFormEventEh;
    FOnGetVarValueProc: TGetVarValueProcEh;
    FOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh;
    FOnSetVarValueProc: TSetVarValueProcEh;

    function GetEditControl: TWinControl; virtual;
    function GetEditButton: TEditButtonEh; virtual;
    function GetEditButtonControl: TEditButtonControlEh; virtual;
    function GetActualDropDownForm(var FreeFormOnClose: Boolean): TCustomForm; virtual;
    function GetOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh; virtual;
    function GetOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh; virtual;
    function GetOnSetVarValueProc: TSetVarValueProcEh; virtual;
    function GetOnGetVarValueProc: TGetVarValueProcEh; virtual;

    function GetDataLink: TDataLink; virtual;
    function GetField: TField; virtual;
    function GetControlValue: Variant; virtual;
    function GetControlReadOnly: Boolean; virtual;
    function GetEditControlScreenRect: TRect; virtual;
    function CreateSysParams: TDropDownFormSysParams; virtual;

    procedure AfterCloseDropDownForm(Accept: Boolean; DropDownForm: TCustomForm; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams); virtual;
    procedure BeforeOpenDropDownForm(DropDownForm: TCustomForm; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams); virtual;
    procedure Changed; virtual;
    procedure DropDownFormCallbackProc(DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams); virtual;
    procedure FillPassParams(DynParams: TDynVarsEh); virtual;
    procedure GetDataFromPassParams(DynParams: TDynVarsEh); virtual;
    procedure InitDropDownForm(var DropDownForm: TCustomForm; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams); virtual;
    procedure InitSysParams(SysParams: TDropDownFormSysParams); virtual;
    procedure SetControlValue(const Value: Variant); virtual;

    property OnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh read GetOnCloseDropDownFormProc;
    property OnGetVarValue: TGetVarValueProcEh read GetOnGetVarValueProc;
    property OnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh read GetOnOpenDropDownFormProc;
    property OnSetVarValue: TSetVarValueProcEh read GetOnSetVarValueProc;

  public
    constructor Create;

    procedure CheckShowDropDownForm(var Handled: Boolean); virtual;

    property OldFormWidth: Integer read FOldFormWidth write FOldFormWidth;
    property OldFormHeight: Integer read FOldFormHeight write FOldFormHeight;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnCheckDataIsReadOnly: TCheckDataIsReadOnlyEventEh read FOnCheckDataIsReadOnly write FOnCheckDataIsReadOnly;

  published
    property Align: TDropDownAlign read FAlign write FAlign default daCenter;
    property AssignBackFieldNames: String read FAssignBackFieldNames write FAssignBackFieldNames;
    property DropDownForm: TCustomForm read FDropDownForm write SetDropDownForm;
    property DropDownFormClassName: String read FDropDownFormClassName write SetDropDownFormClassName;
    property FormHeight: Integer read FFormHeight write FFormHeight default -1;
    property FormWidth: Integer read FFormWidth write FFormWidth default -1;
    property PassFieldNames: String read FPassFieldNames write FPassFieldNames;
    property PassParams: TDropDownPassParamsEh read FPassParams write FPassParams default pspFieldValueEh;
    property SaveFormSize: Boolean read FSaveFormSize write FSaveFormSize default True;
  end;

{ TEditButtonControlEh }

  TEditButtonStyleEh = (ebsDropDownEh, ebsEllipsisEh, ebsGlyphEh, ebsUpDownEh,
    ebsPlusEh, ebsMinusEh, ebsAltDropDownEh, ebsAltUpDownEh);
  TEditButtonDrawBackTimeEh = (edbtAlwaysEh, edbtNeverEh, edbtWhenHotEh);

  TEditButtonDownEventEh = procedure(Sender: TObject; TopButton: Boolean;
    var AutoRepeat: Boolean; var Handled: Boolean) of object;

  TEditButtonControlEh = class(TSpeedButtonEh)
  private
    FActive: Boolean;
    FAlwaysDown: Boolean;
    FButtonNum: Integer;
    FNoDoClick: Boolean;
    FOnDown: TEditButtonDownEventEh;
    FStyle: TEditButtonStyleEh;
    FTimer: TTimer;
    FOnPaint: TNotifyEvent;
    FInternalEditButtonImages: TButtonImagesEh;
    FDrawBackTime: TEditButtonDrawBackTimeEh;
    FMouseInControl: Boolean;
    FAdvancedPaint: Boolean;

    function GetTimer: TTimer;
    procedure ResetTimer(Interval: Cardinal);
    procedure SetActive(const Value: Boolean);
    procedure SetAlwaysDown(const Value: Boolean);
    procedure SetStyle(const Value: TEditButtonStyleEh);
    procedure TimerEvent(Sender: TObject);
    procedure UpdateDownButtonNum(X, Y: Integer);
    procedure SetDrawBackTime(const Value: TEditButtonDrawBackTimeEh);

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    function GetButtonImages: TButtonImagesEh; override;
    function DrawActiveState: Boolean; virtual;

    procedure DrawButtonText(Canvas: TCanvas; const Caption: string; TextBounds: TRect; State: TButtonStateEh; BiDiFlags: Longint);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    property Timer: TTimer read GetTimer;
  public
    FExternalEditButtonImages: TEditButtonImagesEh;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  {$IFDEF EH_LIB_26} 
  {$ELSE}
    function GetSystemMetrics(nIndex: Integer): Integer;
  {$ENDIF}

    procedure Click; override;
    procedure DrawImages(ARect: TRect); virtual;
    procedure DefaultPaint; override;
    procedure EditButtonDown(ButtonNum: Integer; var AutoRepeat: Boolean); virtual;
    procedure SetState(NewState: TButtonStateEh; IsActive: Boolean; ButtonNum: Integer);
    procedure SetWidthNoNotify(AWidth: Integer);

    property Canvas;
    property MouseInControl: Boolean read FMouseInControl;
    property Active: Boolean read FActive write SetActive;
    property AdvancedPaint: Boolean read FAdvancedPaint write FAdvancedPaint;
    property AlwaysDown: Boolean read FAlwaysDown write SetAlwaysDown;
    property Style: TEditButtonStyleEh read FStyle write SetStyle default ebsDropDownEh;
    property ButtonImages: TButtonImagesEh read GetButtonImages;
    property DrawBackTime: TEditButtonDrawBackTimeEh read FDrawBackTime write SetDrawBackTime;

    property OnDown: TEditButtonDownEventEh read FOnDown write FOnDown;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

  TCreateEditButtonControlEvent = procedure(var EditButtonControl: TEditButtonControlEh) of object;

  TEditButtonControlLineRec = record
    ButtonLine: TShape;
    EditButtonControl: TEditButtonControlEh;
    EditButton: TEditButtonEh;
  end;

  TEditButtonControlList = array of TEditButtonControlLineRec;

{ TEditButtonActionLinkEh }

  TEditButtonActionLinkEh = class(TActionLink)
  protected
    FClient: TEditButtonEh;
    procedure AssignClient(AClient: TObject); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
    {$IFDEF FPC}
  public
    {$ENDIF}
    function IsEnabledLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
  end;

  TEditButtonActionLinkEhClass = class of TEditButtonActionLinkEh;

{ TEditButtonImagesEh }

  TEditButtonImagesEh = class(TButtonImagesEh)
  protected
    FOwner: TEditButtonEh;

    function GetOwner: TPersistent; override;

    procedure ImagesStateChanged; override;
    procedure RefComponentChanged(RefComponent: TComponent); override;

  public
    constructor Create(Owner: TEditButtonEh);
    destructor Destroy; override;

  published
    property NormalImages;
    property HotImages;
    property PressedImages;
    property DisabledImages;

    property NormalIndex;
    property HotIndex;
    property PressedIndex;
    property DisabledIndex;
  end;

  TRefComponentNotifyEventEh = procedure(Sender: TObject; RefComponent: TComponent) of object;

{ TEditButtonEh }

  TEditButtonEh = class(TCollectionItem, IUnknown)
  private
    FActionLink: TEditButtonActionLinkEh;
    FDefaultAction: Boolean;
    FDefaultActionStored: Boolean;
    FDrawBackTime: TEditButtonDrawBackTimeEh;
    FDrawBackTimeStored: Boolean;
    FDropDownFormParams: TDropDownFormCallParamsEh;
    FDropdownMenu: TPopupMenu;
    FEditControl: TWinControl;
    FEnabled: Boolean;
    FGlyph: TBitmap;
    FHint: String;
    FImages: TEditButtonImagesEh;
    FNumGlyphs: Integer;
    FOnButtonClick: TButtonClickEventEh;
    FOnButtonDown: TEditButtonDownEventEh;
    FOnChanged: TNotifyEvent;
    FOnRefComponentChanged: TRefComponentNotifyEventEh;
    FShortCut: TShortCut;
    FStyle: TEditButtonStyleEh;
    FVisible: Boolean;
    FWidth: Integer;

    function GetAction: TBasicAction;
    function GetDefaultAction: Boolean;
    function GetDrawBackTime: TEditButtonDrawBackTimeEh;
    function GetGlyph: TBitmap;
    function IsDefaultActionStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    function IsShortCutStored: Boolean;
    function IsVisibleStored: Boolean;

    procedure DoActionChange(Sender: TObject);
    procedure SetAction(const Value: TBasicAction);
    procedure SetDefaultAction(const Value: Boolean);
    procedure SetDrawBackTime(const Value: TEditButtonDrawBackTimeEh);
    procedure SetDrawBackTimeStored(const Value: Boolean);
    procedure SetDropDownFormParams(const Value: TDropDownFormCallParamsEh);
    procedure SetDropdownMenu(const Value: TPopupMenu);
    procedure SetEnabled(const Value: Boolean);
    procedure SetGlyph(const Value: TBitmap);
    procedure SetHint(const Value: String);
    procedure SetImages(const Value: TEditButtonImagesEh);
    procedure SetNumGlyphs(Value: Integer);
    procedure SetOnButtonClick(const Value: TButtonClickEventEh);
    procedure SetOnButtonDown(const Value: TEditButtonDownEventEh);
    procedure SetStyle(const Value: TEditButtonStyleEh);
    procedure SetWidth(const Value: Integer);

  protected
    { IInterface }
    {$IFDEF FPC}
      function QueryInterface(constref IID: TGUID; out Obj): HResult; virtual; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
      function _AddRef: Integer; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
      function _Release: Integer; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
    {$ELSE}
      function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
    {$ENDIF}

  protected
    FParentDefinedDefaultAction: Boolean;

    function CreateDropDownFormParams: TDropDownFormCallParamsEh; virtual;
    function CreateEditButtonControl: TEditButtonControlEh; virtual;
    function DefaultDrawBackTime: TEditButtonDrawBackTimeEh; virtual;
    function GetVisible: Boolean; virtual;
    function IsDrawBackTimeStored: Boolean; virtual;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    procedure Changed; overload;
    procedure RefComponentChanged(RefComponent: TComponent);
    procedure SetVisible(const Value: Boolean); virtual;

    property ActionLink: TEditButtonActionLinkEh read FActionLink write FActionLink;
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(EditControl: TWinControl); reintroduce; overload; virtual;
    destructor Destroy; override;

    function GetActionLinkClass: TEditButtonActionLinkEhClass; virtual;

    procedure Assign(Source: TPersistent); override;
    procedure Click(Sender: TObject; var Handled: Boolean); virtual;
    procedure InitiateAction; virtual;

    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnRefComponentChanged: TRefComponentNotifyEventEh read FOnRefComponentChanged write FOnRefComponentChanged;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property DefaultAction: Boolean read GetDefaultAction write SetDefaultAction stored IsDefaultActionStored;
    property DropdownMenu: TPopupMenu read FDropdownMenu write SetDropdownMenu;
    property DropDownFormParams: TDropDownFormCallParamsEh read FDropDownFormParams write SetDropDownFormParams;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored default True;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Hint: String read FHint write SetHint stored IsHintStored;
    property Images: TEditButtonImagesEh read FImages write SetImages;
    property NumGlyphs: Integer read FNumGlyphs write SetNumGlyphs default 1;
    property ShortCut: TShortCut read FShortCut write FShortCut stored IsShortCutStored default scNone;
    property Style: TEditButtonStyleEh read FStyle write SetStyle default ebsDropDownEh;
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored default False;
    property Width: Integer read FWidth write SetWidth default 0;
    property DrawBackTime: TEditButtonDrawBackTimeEh read GetDrawBackTime write SetDrawBackTime stored IsDrawBackTimeStored;
    property DrawBackTimeStored: Boolean read IsDrawBackTimeStored write SetDrawBackTimeStored stored False;

    property OnClick: TButtonClickEventEh read FOnButtonClick write SetOnButtonClick;
    property OnDown: TEditButtonDownEventEh read FOnButtonDown write SetOnButtonDown;
  end;

  TEditButtonEhClass = class of TEditButtonEh;

{ TDropDownEditButtonEh }

  TDropDownEditButtonEh = class(TEditButtonEh)
  public
    constructor Create(Collection: TCollection); override;
    constructor Create(EditControl: TWinControl); override;
  published
    property ShortCut default 32808; 
  end;

{ TVisibleEditButtonEh }

  TVisibleEditButtonEh = class(TEditButtonEh)
  public
    constructor Create(Collection: TCollection); override;
    constructor Create(EditControl: TWinControl); override;
  published
    property ShortCut default 32808; 
    property Visible default True;
  end;

  IEditButtonsOwnerEh = interface
    ['{752673AE-5902-47A7-9BA0-0157FFFB85C6}']
    function DefaultEditButtonDrawBackTime: TEditButtonDrawBackTimeEh;
  end;

{ TEditButtonsEh }

  TEditButtonsEh = class(TCollection)
  private
    FOnChanged: TNotifyEvent;
    FOnRefComponentChanged: TRefComponentNotifyEventEh;
    function GetEditButton(Index: Integer): TEditButtonEh;
    procedure SetEditButton(Index: Integer; Value: TEditButtonEh);
  protected
    FOwner: TPersistent;
    function GetOwner: TPersistent; override;
    function DefaultDrawBackTime: TEditButtonDrawBackTimeEh; virtual;

    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner: TPersistent; EditButtonClass: TEditButtonEhClass);
    function Add: TEditButtonEh;
    property Items[Index: Integer]: TEditButtonEh read GetEditButton write SetEditButton; default;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnRefComponentChanged: TRefComponentNotifyEventEh read FOnRefComponentChanged write FOnRefComponentChanged;
  end;

{ TSpecRowEh }

  TSpecRowEh = class(TPersistent)
  private
    FCellsStrings: TStrings;
    FCellsText: String;
    FColor: TColor;
    FFont: TFont;
    FOnChanged: TNotifyEvent;
    FOwner: TPersistent;
    FSelected: Boolean;
    FShortCut: TShortCut;
    FShowIfNotInKeyList: Boolean;
    FUpdateCount: Integer;
    FValue: Variant;
    FVisible: Boolean;

    function GetCellText(Index: Integer): String;
    function GetColor: TColor;
    function GetFont: TFont;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsValueStored: Boolean;

    procedure FontChanged(Sender: TObject);
    procedure SetCellsText(const Value: String);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetShowIfNotInKeyList(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetVisible(const Value: Boolean);

  protected
    FColorAssigned: Boolean;
    FFontAssigned: Boolean;
    function GetOwner: TPersistent; override;
    procedure Changed;

  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;

    function DefaultColor: TColor; virtual;
    function DefaultFont: TFont; virtual;
    function LocateKey(KeyValue: Variant): Boolean;

    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;

    property CellText[Index: Integer]: String read GetCellText;
    property Selected: Boolean read FSelected write FSelected;
    property Owner: TPersistent read FOwner;
    property UpdateCount: Integer read FUpdateCount;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;

  published
    property CellsText: String read FCellsText write SetCellsText;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property ShortCut: TShortCut read FShortCut write FShortCut default 32814; 
    property ShowIfNotInKeyList: Boolean read FShowIfNotInKeyList write SetShowIfNotInKeyList default True;
    property Value: Variant read FValue write SetValue stored IsValueStored;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

{ TSizeGripEh }

  TSizeGripPosition = (sgpTopLeft, sgpTopRight, sgpBottomRight, sgpBottomLeft);
  TSizeGripChangePosition = (sgcpToLeft, sgcpToRight, sgcpToTop, sgcpToBottom);

  TSizeGripEh = class(TCustomControlEh)
  private
    FInitScreenMousePos: TPoint;
    FInternalMove: Boolean;
    FOldMouseMovePos: TPoint;
    FParentRect: TRect;
    FParentResized: TNotifyEvent;
    FPosition: TSizeGripPosition;
    FTriangleWindow: Boolean;
    FHostControl: TWinControl;

    function GetHostControl: TWinControl;
    function GetVisible: Boolean;

    procedure SetPosition(const Value: TSizeGripPosition);
    procedure SetTriangleWindow(const Value: Boolean);
    procedure SetHostControl(const Value: TWinControl);

    {$IFDEF FPC}
    procedure SetVisible(const Value: Boolean); reintroduce;
    {$ELSE}
    procedure SetVisible(const Value: Boolean);
    {$ENDIF}

  protected
    procedure CreateHandle; override;
    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure ParentResized; dynamic;

  public
    constructor Create(AOwner: TComponent); override;
    procedure ChangePosition(NewPosition: TSizeGripChangePosition);
    procedure UpdatePosition;
    procedure UpdateWindowRegion;

    property HostControl: TWinControl read GetHostControl write SetHostControl;
    property Position: TSizeGripPosition read FPosition write SetPosition default sgpBottomRight;
    property TriangleWindow: Boolean read FTriangleWindow write SetTriangleWindow default True;
    property Visible: Boolean read GetVisible write SetVisible;

    property OnParentResized: TNotifyEvent read FParentResized write FParentResized;
  end;

{ TPictureEh }

  TPictureEh = class(TPicture)
  public
    constructor Create;
    destructor Destroy; override;
    function GetDestRect(const SrcRect: TRect; Placement: TImagePlacementEh): TRect; virtual;
    procedure PaintTo(Canvas: TCanvas; const DestRect: TRect; Placement: TImagePlacementEh; const ShiftPoint: TPoint; const ClipRect: TRect); virtual;
  end;

{ TCacheAlphaBitmapEh }

  TCacheAlphaBitmapEh = class(TBitmap)
  private
    FCapture: Boolean;
  public
    procedure DrawHorzLine(p: TPoint; LineWidth: Integer; AColor: TColor);
    procedure Capture;
    procedure Release;
  end;

  function GetCacheAlphaBitmap(Width, Height: Integer): TCacheAlphaBitmapEh;
  function CacheAlphaBitmapInUse: Boolean;

const
  cm_SetSizeGripChangePosition = WM_USER + 100;

{ TPopupMonthCalendarEh }

const
  CM_CLOSEUPEH = WM_USER + 101;

type

{$IFDEF FPC_CROSSP}
{$ELSE}

{$IFDEF FPC}
  TPopupMonthCalendarEh = class(TCalendar, IPopupDateTimePickerEh)
{$ELSE}
  TPopupMonthCalendarEh = class(TMonthCalendar, IPopupDateTimePickerEh)
{$ENDIF}
  private
    FBorderWidth: Integer;
    FTime: TDateTime;
    procedure CMCloseUpEh(var Message: TMessage); message CM_CLOSEUPEH;
    {$IFDEF FPC}
    {$ELSE}
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    {$ENDIF}
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    {$IFDEF FPC_LINUX}
    procedure WMNCCalcSize(var Message: TLMNCCalcSize); message LM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TMessage); message LM_NCPAINT;
    {$ELSE}
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    {$ENDIF}
    function GetDate: TDateTime;
    procedure SetDate(const Value: TDateTime);
  protected
    function GetDateTime: TDateTime;
    function GetTimeUnits: TCalendarDateTimeUnitsEh;
    function WantKeyDown(Key: Word; Shift: TShiftState): Boolean;
    function WantFocus: Boolean;
    procedure HidePicker;
    procedure SetTimeUnits(const Value: TCalendarDateTimeUnitsEh);
    procedure ShowPicker(DateTime: TDateTime; Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
    procedure SetFontOptions(Font: TFont; FontAutoSelect: Boolean);

  protected
    FDownViewType: Integer;

    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    {$IFDEF FPC}
    {$ELSE}
    function MsgSetDateTime(Value: TSystemTime): Boolean; override;
    {$ENDIF}

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawBorder; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure PostCloseUp(Accept: Boolean);
    procedure UpdateBorderWidth;
  public
    constructor Create(AOwner: TComponent); override;

    procedure UpdateSize;

    property Date: TDateTime read GetDate write SetDate;
    property Color;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
  end;

{$ENDIF} 

  TListGetImageIndexEventEh = procedure(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer) of object;

{ TMRUList }
type
  TMRUListEh = class;

  TMRUListSourceKindEh = (lskMRUListItemsEh, lskDataSetFieldValuesEh);

  TFilterMRUItemEventEh = procedure (Sender: TObject; var Accept: Boolean) of object;
  TSetDropDownEventEh = procedure (Sender: TObject) of object;
  TSetCloseUpEventEh = procedure (Sender: TObject; Accept: Boolean) of object;
  TMRUListFillAutogenItemsEventEh = procedure (Sender: TMRUListEh; AutogenItems: TStrings) of object;

  TMRUListEh = class(TPersistent)
  private
    FActive: Boolean;
    FAutoAdd: Boolean;
    FAutogenItems: TStrings;
    FCancelIfKeyInQueue: Boolean;
    FCaseSensitive: Boolean;
    FItems: TStrings;
    FLimit: Integer;
    FListSourceKind: TMRUListSourceKindEh;
    FOwner: TPersistent;
    FRows: Integer;
    FWidth: Integer;

    FOnActiveChanged: TNotifyEvent;
    FOnFillAutogenItems: TMRUListFillAutogenItemsEventEh;
    FOnFilterItem: TFilterMRUItemEventEh;
    FOnSetCloseUpEvent: TSetCloseUpEventEh;
    FOnSetDropDown: TSetDropDownEventEh;

    function GetActiveItems: TStrings;
    procedure SetActive(const Value: Boolean);
    procedure SetItems(const Value: TStrings);
    procedure SetLimit(const Value: Integer);
    procedure SetRows(const Value: Integer);
    function GetItems: TStrings;

  protected
    FDroppedDown: Boolean;
    procedure UpdateLimit;

  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;

    function FilterItemsTo(FilteredItems: TStrings; const MaskText: String): Boolean;

    procedure Add(const s: String);
    procedure Assign(Source: TPersistent); override;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DropDown; virtual;
    procedure PrepareActiveItems; virtual;

    property DroppedDown: Boolean read FDroppedDown write FDroppedDown;
    property Width: Integer read FWidth write FWidth;
    property ActiveItems: TStrings read GetActiveItems;
    property CancelIfKeyInQueue: Boolean read FCancelIfKeyInQueue write FCancelIfKeyInQueue default True;

    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnSetCloseUp: TSetCloseUpEventEh read FOnSetCloseUpEvent write FOnSetCloseUpEvent;
    property OnSetDropDown: TSetDropDownEventEh read FOnSetDropDown write FOnSetDropDown;
    property OnFilterItem: TFilterMRUItemEventEh read FOnFilterItem write FOnFilterItem;
    property OnFillAutogenItems: TMRUListFillAutogenItemsEventEh read FOnFillAutogenItems write FOnFillAutogenItems;

  published
    property Active: Boolean read FActive write SetActive default False;
    property AutoAdd: Boolean read FAutoAdd write FAutoAdd default True;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive default False;
    property Items: TStrings read GetItems write SetItems;
    property Limit: Integer read FLimit write SetLimit default 100;
    property ListSourceKind: TMRUListSourceKindEh read FListSourceKind write FListSourceKind default lskMRUListItemsEh;
    property Rows: Integer read FRows write SetRows default 7;
  end;

  TStringListEh = class(TStringList)
  end;

{ TDataLinkEh }

{$IFDEF CIL}
  TDataEventEh = procedure (Event: TDataEvent; Info: TObject) of object;
{$ELSE}
  TDataEventEh = procedure (Event: TDataEvent; Info: Longint) of object;
{$ENDIF}

  TDataLinkEh = class(TDataLink)
  private
    FOnDataEvent: TDataEventEh;
  protected
    procedure DataEvent(Event: TDataEvent; Info: TDataEventInfoTypeEh); override;
  public
    property OnDataEvent: TDataEventEh read FOnDataEvent write FOnDataEvent;
  end;

{ TDatasetFieldValueListEh }

  TDatasetFieldValueListEh = class(TInterfacedObject, IMemTableDataFieldValueListEh)
  private
    FDataLink: TDataLinkEh;
    FDataObsoleted: Boolean;
    FDataSource: TDataSource;
    FFieldName: String;
    FValues: TStringList;

    function GetDataSet: TDataSet;
    function GetDataSource: TDataSource;
    function GetValues: TStrings;
    function GetCaseSensitive: Boolean;

    procedure SetDataSet(const Value: TDataSet);
    procedure SetCaseSensitive(const Value: Boolean);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetFieldName(const Value: String);
  protected
    procedure RefreshValues;
{$IFDEF CIL}
    procedure DataSetEvent(Event: TDataEvent; Info: TObject); virtual;
{$ELSE}
    procedure DataSetEvent(Event: TDataEvent; Info: Integer); virtual;
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetFilter(const Filter: String);

    property CaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
    property FieldName: String read FFieldName write SetFieldName;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property Values: TStrings read GetValues;
  end;

{ TDesignControlerEh }

  TDesignControlerEh = class(TInterfacedObject)
  public
    function IsDesignHitTest(Control: TPersistent; X, Y: Integer; AShift: TShiftState): Boolean; virtual; abstract;
    function ControlIsObjInspSelected(Control: TPersistent): Boolean; virtual; abstract;
    function GetObjInspSelectedControl(BaseControl: TPersistent): TPersistent; virtual; abstract;
    function GetDesignInfoItemClass: TCollectionItemClass; virtual; abstract;
    function GetSelectComponentCornerImage: TBitmap; virtual; abstract;

    procedure DesignMouseDown(Control: TPersistent; X, Y: Integer; AShift: TShiftState); virtual; abstract;
    procedure DrawDesignSelectedBorder(Canvas: TCanvas; ARect: TRect); virtual; abstract;
    procedure RegisterChangeSelectedNotification(Control: TPersistent); virtual; abstract;
    procedure UnregisterChangeSelectedNotification(Control: TPersistent); virtual; abstract;
    procedure KeyProperyModified(Control: TControl); virtual; abstract;
    procedure SelectComponent(Component: TComponent; Instance: TPersistent); virtual; abstract;
  end;

  TLocateTextEventEh = function (Sender: TObject;
    const FieldName: string; const Text: String; Options: TLocateTextOptionsEh;
    Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
    TreeFindRange: TLocateTextTreeFindRangeEh): Boolean of object;

  TDrawButtonControlStyleEh = (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh,
    bcsCheckboxEh, bcsPlusEh, bcsMinusEh, bcsAltDropDownEh, bcsAltUpDownEh);
  TTreeElementEh = (tehMinusUpDown, tehMinusUp, tehMinusDown, tehMinusHLine, tehMinus,
                   tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlusHLine, tehPlus,
                   tehCrossUpDown, tehCrossUp, tehCrossDown,
                   tehVLine, tehHLine);


procedure PaintButtonControlEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Style: TDrawButtonControlStyleEh; DownButton: Integer;
  Flat, Active, Enabled: Boolean; State: TCheckBoxState; Scale: Double = 1;
  DrawButtonBackground: Boolean = True);
procedure DrawCheckBoxEh(DC: HDC; R: TRect; AState: TCheckBoxState;
  AEnabled, AFlat, ADown, AActive: Boolean);

procedure DrawUserButtonBackground(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Enabled, Active, Flat, Pressed: Boolean);

function GetDefaultFlatButtonWidth: Integer;

function ClientToScreenRect(Control: TControl): TRect;

var
  FlatButtonWidth: Integer;

type

  TTreeViewGlyphStyleEh = (tvgsDefaultEh, tvgsClassicEh, tvgsThemedEh, tvgsExplorerThemedEh);

  TLSAutoFilterTypeEh = (lsftBeginsWithEh, lsftContainsEh);

function IsFieldTypeNumeric(FieldType: TFieldType): Boolean;
function VarIsNumericType(const Value: Variant): Boolean;

function IsFieldTypeString(FieldType: TFieldType): Boolean;

procedure GetFieldsProperty(List: TObjectList; DataSet: TDataSet;
  Control: TComponent; const FieldNames: String); overload;

function GetFieldsProperty(DataSet: TDataSet; Control: TComponent;
  const FieldNames: String): TFieldsArrEh; overload;

procedure DataSetSetFieldValues(DataSet: TDataSet; const Fields: String; Value: Variant);
procedure DataSetGetFieldValues(DataSet: TDataSet; FKeyFields: TFieldsArrEh; out Value: Variant);

function VarEquals(const V1, V2: Variant): Boolean;
function VarToStrEh(const V: Variant): String;
function AnyVarToStrEh(const V: Variant): String;
function StrictVarToStrEh(const V: Variant): String;
function TruncDateTimeToSeconds(dt: TDateTime): TDateTime;
procedure ReplaceTime(var DateTime: TDateTime; const NewTime: TDateTime);

function DBVarCompareValue(const A, B: Variant): TVariantRelationship;
function StringListSysSortCompare(List: TStringList; Index1, Index2: Integer): Integer;

var UseButtonsBitmapCache: Boolean = False;

procedure ClearButtonsBitmapCache;

procedure DrawImage(Canvas: TCanvas; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean); overload;
procedure DrawImage(DC: HDC; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean); overload;

procedure DrawTreeElement(Canvas: TCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean; Coloured: Boolean; GlyphStyle: TTreeViewGlyphStyleEh);

function AlignDropDownWindowRect(MasterAbsRect: TRect; DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
function AlignDropDownWindow(MasterWin, DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;

function GetShiftState: TShiftState;

var
  DefaultCheckBoxWidth, DefaultCheckBoxHeight: Integer;
  DefaultFlatCheckBoxWidth, DefaultFlatCheckBoxHeight: Integer;

function AdjustCheckBoxRect(ClientRect: TRect; Alignment: TAlignment;
  Layout: TTextLayout{; Flat: Boolean}): TRect;

function IsDoubleClickMessage(OldPos, NewPos: TPoint; Interval: Longint): Boolean;
function DefaultEditButtonHeight(EditButtonWidth: Integer; Flat: Boolean): Integer;

function KillMouseUp(Control: TControl): Boolean; overload;
function KillMouseUp(Control: TControl; Area: TRect): Boolean; overload;
function IsMouseButtonPressedEh(Button: TMouseButton): Boolean;

procedure FillGradientEh(Canvas: TCanvas; ARect: Trect; FromColor, ToColor: TColor); overload;
procedure FillGradientEh(Canvas: TCanvas; TopLeft: TPoint; Points: array of TPoint; FromColor, ToColor: TColor); overload;
function ThemesEnabled: Boolean;
function ThemedSelectionEnabled: Boolean;
function CustomStyleActive: Boolean;
function IsThemePartDefinedEh(Details: TThemedElementDetails): Boolean;

procedure BroadcastPerformMessageFor(Owner: TComponent; ForClass: TControlClass;
  Msg: Cardinal; WParam: WPARAM; LParam: LPARAM);
procedure CheckPostApplicationMessage(Msg: Cardinal; WParam: WPARAM; LParam: LPARAM);

{$IFNDEF EH_LIB_8}
{$ENDIF}

type

{ Paradox graphic BLOB header }

  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

  TPictureClass = class of TPicture;

{ TGraphicProviderEh }

  TGraphicProviderEh = class(TPersistent)
  public
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; virtual;
  end;

{ TBMPGraphicProviderEh }

  TBMPGraphicProviderEh = class(TGraphicProviderEh)
  public
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; override;
  end;

{ TIconGraphicProviderEh }

  TIconGraphicProviderEh = class(TGraphicProviderEh)
  public
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; override;
  end;

  TGraphicProviderEhClass = class of TGraphicProviderEh;

procedure RegisterGraphicProviderEh(GraphicProviderClass: TGraphicProviderEhClass);
function GetImageClassForStreamEh(Start: Pointer): TGraphicClass;
function GetGraphicProvidersCount: Integer;
function GetPictureForField(Field: TField): TPicture;
procedure AssignPictureFromImageField(Field: TField; Picture: TPicture);

function FieldValueToDispayValue(const AValue: Variant; Field: TField; const ADisplayFormat: String): String;

function SelectClipRectangleEh(Canvas: TCanvas; const ClipRect: TRect): HRgn;
procedure RestoreClipRectangleEh(Canvas: TCanvas; RecHandle: HRgn);

function ApproachToColorEh(FromColor, ToColor: TColor; Percent: Integer): TColor;
function ColorToGray(AColor: TColor): TColor;
function GetColorLuminance(AColor: TColor): Integer;
function ChangeColorLuminance(AColor: TColor; ALuminance: Integer): TColor;
function ChangeColorSaturation(AColor: TColor; ASaturation: Integer): TColor;
function CheckSysColor(ASysColor: TColor): TColor;

{$IFDEF CIL}
{$ELSE}
{ DrawProgressBarEh }

type
  TProgressBarTextTypeEh = (pbttAsValue, pbttAsPercent);
  TProgressBarFrameFigureTypeEh = (pbfftRectangle, pbfftRoundRect);
  TProgressBarFrameSizeTypeEh = (pbfstFull, pbfstVal);


  TProgressBarParamsEh = record
    ShowText: Boolean;
    TextType: TProgressBarTextTypeEh;
    TextDecimalPlaces: Byte;
    TextAlignment : TAlignment;
    FrameFigureType: TProgressBarFrameFigureTypeEh;
    FrameSizeType: TProgressBarFrameSizeTypeEh;
    Indent: Byte;
    FontName: String;
    FontColor: TColor;
    FontSize: Integer;
    FontStyle: TFontStyles;
  end;

  PProgressBarParamsEh = ^TProgressBarParamsEh;

procedure DrawProgressBarEh(const CurrentValue, MinValue, MaxValue: Double;
  Canvas: TCanvas; const Rect: TRect; Color, FrameColor, BackgroundColor: TColor;
  const PBParPtr: PProgressBarParamsEh = nil);
{$ENDIF}

function GetAllStrEntry(S, SubStr: String; var StartPoses: TIntegerDynArray; CaseInsensitive, WholeWord, StartOfString: Boolean): Boolean;

procedure DrawHighlightedSubTextEh(C: TCanvas;AR: TRect;X, Y: Integer; const T: string;
  A: TAlignment;La: TTextLayout;ML: Boolean;EE: Boolean;L, R: Integer;rlr: Boolean;
  const S: String; CI, WW, SOS: Boolean; HC: TColor; Pos: Integer; PosC: TColor; var ofv: Integer);

function CheckRightToLeftFirstCharEh(const S: String; RightToLeftIfUncertain: Boolean): Boolean;

type
  TWrappedOneLineInfoEh = record
    st: Longint; //Start Line pos in Text
    le: Longint; //Line Length of Chars
    pwi: Longint; //Line Width in Pixels
    phi: Longint; //Line Height in Pixels
  end;

  TWrappedLinesInfoEh = array of TWrappedOneLineInfoEh;

function MeasureTextInLinesEh(C: TCanvas; W: Integer; const T: string; ML: Boolean; var Size: TSize; FLMarg: Integer): TWrappedLinesInfoEh;

procedure MeasureTextEh(C: TCanvas; W: Integer; const T: string; ML: Boolean; var Size: TSize);

type

{ THintWindowEh }

  THintWindowEh = class(THintWindow)
  protected
    procedure Paint; override;

  public
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); override;
  public
{$IFDEF CIL}
{$ELSE}
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
{$ENDIF}
  end;

{ TPopupMenuEh }

  TPopupMenuEh = class(TPopupMenu)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(X, Y: Integer); override;
  end;

  {$IFDEF FPC}
  {$ELSE}
{ TPopupMenuWinEh }

  TPopupMenuWinEh = class(TObject)
  protected
    FMenuHandle: HMENU;
    FPopupWindowHandle: HWND;
    FOrgPopupWindowProc: Pointer;
    FHookedPopupWindowProc: Pointer;
    FSelectedItemID: UINT;
    procedure PopupWindowProc(var Msg: TMessage);

   public
    destructor Destroy; override;
  end;

{ TPopupMenuEh }

  TPopupListEh = class(TPopupList)
  protected
    FGetPopupWindowHandle: Boolean;
    FPopupMenuWins: TObjectListEh;
    FAddingMenuHandle: HMENU;

    function AddMenuPopup(MenuPopup: HMENU): TPopupMenuWinEh;
    function FindHackedMenuHandle(MenuPopup: HMENU): TPopupMenuWinEh;

    procedure DeleteWin(WindowHandle: HWND);
    procedure MenuSelectID(ItemID: UINT; var CanClose: Boolean);
    procedure MenuSelectPos(MenuHandle: HMENU; ItemPos: UINT; var CanClose: Boolean);
    procedure WndProc(var Message: TMessage); override;

  public
    constructor Create;
    destructor Destroy; override;
  end;
  {$ENDIF}

{ TMenuItemEh }

  TMenuItemEh = class(TMenuItem)
  private
    FCloseMenuOnClick: Boolean;
    FActualMenuItem: TMenuItem;
  published
  public
    constructor Create(AOwner: TComponent; ActualMenuItem: TMenuItem); reintroduce; overload;
    constructor Create(AOwner: TComponent); overload; override;
    procedure Click; override;

    property CloseMenuOnClick: Boolean read FCloseMenuOnClick write FCloseMenuOnClick default True;
  end;

var
  {$IFDEF FPC}
  {$ELSE}
  PopupListEh: TPopupListEh;
  FSysHook: HHook;
  {$ENDIF}
  ExplorerTreeviewTheme: THandle;
  EhLibDebugChecks: Boolean;

type

{ TEhLibManager }

  TEhLibManager = class(TPersistent)
  private
    FAltDecimalSeparator: Char;
    FDateTimeCalendarPickerHighlightHolidays: Boolean;
    FPopupDateTimePickerClass: TWinControlClass;
    FPopupCalculatorClass: TWinControlClass;
    FWeekWorkingDays: TWeekDaysEh;
    FDateTimeCalendarPickerShowTimeSelectionPage: Boolean;
    FUseAlphaFormatInAlphaBlend: Boolean;

    procedure SetDateTimeCalendarPickerHighlightHolidays(const Value: Boolean);
    procedure SetWeekWorkingDays(const Value: TWeekDaysEh);

  public
    constructor Create;

    property PopupDateTimePickerClass: TWinControlClass read FPopupDateTimePickerClass write FPopupDateTimePickerClass;
    property PopupCalculatorClass: TWinControlClass read FPopupCalculatorClass write FPopupCalculatorClass;
    property DateTimeCalendarPickerHighlightHolidays: Boolean read FDateTimeCalendarPickerHighlightHolidays write SetDateTimeCalendarPickerHighlightHolidays;
    property DateTimeCalendarPickerShowTimeSelectionPage: Boolean read FDateTimeCalendarPickerShowTimeSelectionPage write FDateTimeCalendarPickerShowTimeSelectionPage;
    property WeekWorkingDays: TWeekDaysEh read FWeekWorkingDays write SetWeekWorkingDays;
    property AltDecimalSeparator: Char read FAltDecimalSeparator write FAltDecimalSeparator;
    property UseAlphaFormatInAlphaBlend: Boolean read FUseAlphaFormatInAlphaBlend write FUseAlphaFormatInAlphaBlend;
  end;

function SetEhLibManager(NewEhLibManager: TEhLibManager): TEhLibManager;
function EhLibManager: TEhLibManager;

{ TWorkingTimeCalendarEh }

type

  TDayTypeEh = (dtWorkdayEh, dtFreedayEh, dtPublicHolidayEh);

  TTimeRangeEh = record
    StartTime: TDateTime;
    FinishTime: TDateTime;
  end;

  TTimeRangesEh = array of TTimeRangeEh;

  TWorkingTimeCalendarEh = class(TComponent)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsWorkday(ADate: TDateTime): Boolean; virtual;
    procedure GetWorkingTime(ADate: TDateTime; var ATimeRanges: TTimeRangesEh); virtual;
  end;

  function GlobalWorkingTimeCalendar: TWorkingTimeCalendarEh;
  function RegisterGlobalWorkingTimeCalendar(NewWorkingTimeCalendar: TWorkingTimeCalendarEh): TWorkingTimeCalendarEh;
  function DateToWeekDayEh(ADate: TDateTime): TWeekDayEh;

{ TPopupInactiveFormEh }

type
  {$IFDEF FPC}
  TPopupInactiveFormEh = class(THintWindow)
  {$ELSE}
  TPopupInactiveFormEh = class(TForm)
  {$ENDIF}
  private
    FDropShadow: Boolean;
    FMasterActionsControl: TWinControl;
    FMasterFocusControl: TWinControl;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMActivate(var Message : TWMActivate); message WM_ACTIVATE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;

    function GetBorderWidth: Integer;
    function GetVisible: Boolean;
    procedure SetVisible(AValue: Boolean); reintroduce;
  protected
    {$IFDEF FPC}
    class procedure WSRegisterClass; override;
    {$ELSE}
    procedure Paint; override;
    {$ENDIF}
    procedure WndProc(var Message : TMessage); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure AdjustClientRect(var Rect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CanFocus: Boolean; override;
    {$IFDEF FPC}
    procedure Paint; override;
    {$ELSE}
    {$ENDIF}
    procedure Show; reintroduce;
    property BorderWidth: Integer read GetBorderWidth;
    property Visible: Boolean read GetVisible write SetVisible;
    property DropShadow: Boolean read FDropShadow write FDropShadow;
    property MasterFocusControl: TWinControl read FMasterFocusControl write FMasterFocusControl;
    property MasterActionsControl: TWinControl read FMasterActionsControl write FMasterActionsControl;
  end;

{$IFDEF EH_LIB_10} //{ Borland Developer Studio 2006 }
{$ELSE}

  TMarginSize = 0..MaxInt;

{ TMargins }

  TMargins = class(TPersistent)
  private
    FLeft: TMarginSize;
    FTop: TMarginSize;
    FRight: TMarginSize;
    FBottom: TMarginSize;
    FOnChange: TNotifyEvent;

    procedure SetMargin(Index: Integer; Value: TMarginSize);
  protected
    procedure Change; virtual;

  public
    constructor Create(Control: TControl); virtual;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  published
    property Left: TMarginSize index 0 read FLeft write SetMargin default 3;
    property Top: TMarginSize index 1 read FTop write SetMargin default 3;
    property Right: TMarginSize index 2 read FRight write SetMargin default 3;
    property Bottom: TMarginSize index 3 read FBottom write SetMargin default 3;
  end;

{ TPadding }

  TPadding = class(TMargins)
  protected
  public
    constructor Create(Control: TControl); override;
  published
    property Left default 0;
    property Top default 0;
    property Right default 0;
    property Bottom default 0;
  end;
{$ENDIF} //ELSE EH_LIB_10

  TSortMarkerEh = (smNoneEh, smDownEh, smUpEh);

  TSortMarkerStyleEh = (smstDefaultEh, smstClassicEh, smst3DFrameEh, smstFrameEh, smstSolidEh
    , smstThemeDefinedEh);

  TRCRRec = record
    Result: Integer;
    RectRgn: HRGN;
  end;

{ TSortMarkerPainterEh }

  TSortMarkerPainterEh = class(TPersistent)
  public
    function GetSorMarkerSize(Canvas: TCanvas; SMStyle: TSortMarkerStyleEh): TSize; virtual;
    procedure Draw(Canvas: TCanvas;  SMStyle: TSortMarkerStyleEh; Direction: TSortMarkerEh; ARect: TRect; FrameBrightColor, FrameDarkColor, FillColor: TColor); virtual;
  end;


{ TTreeSignPainterDrawArgsEh }

  TTreeSignPainterDrawArgsEh = class
    BaseControl: TWinControl;
    Canvas: TCanvas;
    Rect: TRect;
    TreeElement: TTreeElementEh;
    BackDot: Boolean;
    ScaleX: Double;
    ScaleY: Double;
    RightToLeft: Boolean;
    Coloured: Boolean;
    GlyphStyle: TTreeViewGlyphStyleEh;
  end;

{ TTreeSignPainterAreaWidthArgsEh }

  TTreeSignPainterAreaWidthArgsEh = class
    BaseControl: TWinControl;
    AreaHeight: Integer;
    ScaleFactor: Double;
    AreaWidth: Integer;
  end;

{ TTreeSignPainterEh }

  TTreeSignPainterEh = class(TPersistent)
  private
    FAreaWidthArgs: TTreeSignPainterAreaWidthArgsEh;
  public
    constructor Create;
    destructor Destroy; override;

    function GetTreeSignAreaWidth(BaseControl: TWinControl; AreaHeight: Integer; ScaleFactor: Double): Integer;

    procedure TreeSignAreaWidthNeeded(Args: TTreeSignPainterAreaWidthArgsEh); virtual;
    procedure Draw(DrawArgs: TTreeSignPainterDrawArgsEh); virtual;
  end;

{ TEhLibDrawStyleEh }

  TEhLibDrawStyleEh = class(TPersistent)
  private
    FSortmarkerPainter: TSortmarkerPainterEh;
    FTreeSignPainter: TTreeSignPainterEh;

    function GetSortmarkerPainter: TSortmarkerPainterEh;
    procedure SetSortmarkerPainter(const Value: TSortmarkerPainterEh);
    function GetTreeSignPainter: TTreeSignPainterEh;
    procedure SetTreeSignPainter(const Value: TTreeSignPainterEh);
  public
    constructor Create;
    destructor Destroy; override;

    property SortmarkerPainter: TSortmarkerPainterEh read GetSortmarkerPainter write SetSortmarkerPainter;
    property TreeSignPainter: TTreeSignPainterEh read GetTreeSignPainter write SetTreeSignPainter;
  end;

  function SetEhLibDrawStyle(AEhLibDrawStyle: TEhLibDrawStyleEh): TEhLibDrawStyleEh;
  function EhLibDrawStyle: TEhLibDrawStyleEh;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);

procedure WriteTextEh(ACanvas: TCanvas;      
                      ARect: TRect;          
                      FillRect:Boolean;      
                      DX, DY: Integer;       
                      Text: string;          
                      Alignment: TAlignment; 
                      Layout: TTextLayout;   
                      MultyL: Boolean;       
                      EndEllipsis: Boolean;  
                      LeftMarg,              
                      RightMarg: Integer;    
                      RightToLeftReading: Boolean;
                      ForceSingleLine: Boolean 
                      );

function WriteTextVerticalEh(ACanvas: TCanvas;
                          ARect: TRect;          
                          FillRect:Boolean;      
                          DX, DY: Integer;       
                          const Text: string;    
                          Alignment: TAlignment; 
                          Layout: TTextLayout;   
                          MultyL: Boolean;
                          EndEllipsis:Boolean;   
                          CalcTextExtent:Boolean  
                          ):Integer;

function WriteRotatedTextEh(ACanvas: TCanvas;
                          ARect: TRect;
                          FillRect: Boolean;
                          DX, DY: Integer;
                          const Text: string;
                          Alignment: TAlignment;
                          Layout: TTextLayout;
                          Orientation: Integer;
                          EndEllipsis: Boolean;
                          CalcTextExtent: Boolean
                          ): Integer;

function WriteOneUnderOtherCharsTextEh(ACanvas: TCanvas;
                          ARect: TRect;
                          FillRect: Boolean;
                          DX, DY: Integer;
                          const Text: String;
                          Alignment: TAlignment;
                          Layout: TTextLayout;
                          CalcTextExtent: Boolean
                          ):Integer;

function ApproximateColor(FromColor, ToColor: TColor; Quota: Double): TColor;
function MightierColor(Color1, Color2: TColor): TColor;

procedure DrawClipped(imList: TCustomImageList; Bitmap: TGraphic;
  ACanvas: TCanvas; ARect: TRect; Index,
  ALeftMarg, ATopMarg: Integer; Align: TAlignment; const ClipRect: TRect;
  Scale: Double = 1;
  Enabled: Boolean = True);

procedure DrawEquilateralTriangle(ACanvas: TCanvas; ARect: TRect; Direction: TEquilateralTriangleDirectionEh; TopGradientColor, BottomGradientColor: TColor);

function iif(Condition: Boolean; V1, V2: Integer): Integer;
function PointInRect(const Rect: TRect; const P: TPoint): Boolean;
function RectIntersected(const Rect1, Rect2: TRect): Boolean; overload;
function StringsLocate(const StrList: TStrings; const Str: String; const Options: TLocateOptions): Integer;
function FieldsCanModify(Fields: TFieldListEh): Boolean; overload;
function FieldsCanModify(Fields: TFieldsArrEh): Boolean; overload;
function SysFloatToStr(Value: Extended): String;
function SysVarToStr(const Value: Variant): String;
function SysStrToVar(const Value: String; VarType: Word): Variant;
function StringSearch(const SubStr, S: string; CaseInsensitive: Boolean; WholeWord: Boolean; Offset: Integer = 1): Integer;

procedure SwapInt(var a, b: Integer);
procedure SwapForRTLClient(var a, b: Integer; ClientWidth: Integer); overload;
procedure SwapForRTLClient(var ARect: TRect; ClientWidth: Integer); overload;
procedure ShiftForRTLClient(var a: Integer;  ClientWidth: Integer);

procedure ArrayInsertRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);
procedure ArrayDeleteRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);

procedure ParseDateTimeFormatForTimeUnits(Format: string; out TimeUnits: TCalendarDateTimeUnitsEh);
procedure GetHoursTimeFormat({LCid: TLocaleID; }var HoursFormat: THoursTimeFormatEh; var AmPmPos: TAmPmPosEh);

procedure AbstractQuickSort(List: Pointer; L, R: Integer; SCompare: TListSortCompareItemsEh; SExchange: TListSortExchangeItemsEh);
function ApproximatePoint(SourcePoint, DistantPoint: TPoint; Factor: Double): TPoint;

function FormatMaskTextEh(const EditMask: String; const Value: String): String;
function ChangeRightToLeftSizeGripPosition(SizeGripPosition: TSizeGripPosition): TSizeGripPosition;

var
  WordDelimitersEh: String =
    ' .;,:(){}"''/\<>!?[]-+*='#$09#$91#$92#$93#$94#$A0#$D0#$84;

implementation

uses
  {$IFDEF FPC}
  DBConst,
  {$ELSE}
  DBConsts,
  {$ENDIF}
  DBCtrlsEh,
  DropDownFormEh,
  DateTimeCalendarPickersEh,
  CalculatorEh,
  DBUtilsEh,
  {$IFDEF WINDOWS}
  ShellApi,
  MultiMon,
  {$ELSE}
  {$ENDIF}
  {$IFDEF EH_LIB_12} RTLConsts, {$ENDIF}
  Math, MaskUtils;

{$IFDEF eval}
{$ELSE}
procedure InitSpecEdition;
begin
end;
{$ENDIF}

type
  TWinControlCracker = class(TWinControl) end;
  TControlCracker = class(TControl) end;

var
  DrawBitmap: TBitmap;
  AlphaBitmap: TCacheAlphaBitmapEh;
  UserCount: Integer;

procedure SetCanvasZoomAndRotation(ACanvas: TCanvas; Zoom: Double; Angle: Double; CenterpointX, CenterpointY: Double);
{$IFDEF WINDOWS}
var
  {$IFDEF FPC}
  XForm: TXFORM;
  {$ELSE}
  XForm: tagXFORM;
  {$ENDIF}
  Winkel: Double;
begin
  Winkel := DegToRad(Angle);
  SetGraphicsMode(ACanvas.Handle, GM_ADVANCED);
  SetMapMode(ACanvas.Handle, MM_ANISOTROPIC);
  xForm.eM11 := Zoom * Cos(Winkel);
  xForm.eM12 := Zoom * Sin(Winkel);
  xForm.eM21 := Zoom * (-Sin(Winkel));
  xForm.eM22 := Zoom * Cos(Winkel);
  xForm.eDx := CenterpointX;
  xForm.eDy := CenterpointY;
  SetWorldTransform(ACanvas.Handle, xForm);
end;
{$ELSE}
begin
end;
{$ENDIF}

procedure ResetCanvas(ACanvas: TCanvas);
{$IFDEF WINDOWS}
var
  {$IFDEF FPC}
  XForm: TXFORM;
  {$ELSE}
  XForm: tagXFORM;
  {$ENDIF}
begin
  XForm.eM11 := 1;
  XForm.eM12 := 0;
  XForm.eM21 := 0;
  XForm.eM22 := 1;
  XForm.eDx := 0;
  XForm.eDy := 0;
  SetWorldTransform(ACanvas.Handle, XForm);
  SetGraphicsMode(ACanvas.Handle, GM_COMPATIBLE);
end;
{$ELSE}
begin
end;
{$ENDIF}

function FormatMaskTextEh(const EditMask: String; const Value: String): String;
begin
  {$IFDEF FPC}
  Result := FormatMaskText(EditMask, Value);
  {$ELSE}
  if MaskGetMaskSave(EditMask) then
    Result := PadInputLiterals(EditMask, Value, MaskGetMaskBlank(EditMask))
  else
    Result := MaskDoFormatText(EditMask, Value, MaskGetMaskBlank(EditMask));
  {$ENDIF}
end;

function ChangeRightToLeftSizeGripPosition(SizeGripPosition: TSizeGripPosition): TSizeGripPosition;
const MirroredPosition: array[TSizeGripPosition] of TSizeGripPosition =
  //  sgpTopLeft, sgpTopRight, sgpBottomRight, sgpBottomLeft
     (sgpTopRight, sgpTopLeft, sgpBottomLeft, sgpBottomRight);
begin
  Result := MirroredPosition[SizeGripPosition];
end;

function ApproximatePoint(SourcePoint, DistantPoint: TPoint; Factor: Double): TPoint;
begin
  Result.X := SourcePoint.X + Trunc((DistantPoint.X - SourcePoint.X) * Factor);
  Result.Y := SourcePoint.Y + Trunc((DistantPoint.Y - SourcePoint.Y) * Factor);
end;

procedure AbstractQuickSort(List: Pointer; L, R: Integer;
  SCompare: TListSortCompareItemsEh; SExchange: TListSortExchangeItemsEh);
var
  I, J, P: Integer;
begin
  if R < L then Exit;
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(List, I, P) < 0 do Inc(I);
      while SCompare(List, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        if I <> J then
          SExchange(List, I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then AbstractQuickSort(List, L, J, SCompare, SExchange);
    L := I;
  until I >= R;
end;

function StringSearch(const SubStr, S: string; CaseInsensitive: Boolean;
  WholeWord: Boolean; Offset: Integer = 1): Integer;
var
  S1, SubStr1: String;
  NewOffset, HalfResult: Integer;
  BefC, AfC: Char;
  S1Len, SubStr1Len: Integer;
  BefDelOk, AfDelOk: Boolean;

  function FindChar(C: Char; S: String): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to Length(S) do
      if S[i] = C then
      begin
        Result := i;
        Break;
      end;
  end;

begin
  if CaseInsensitive then
  begin
    S1 := NlsUpperCase(S);
    SubStr1 := NlsUpperCase(SubStr);
  end else
  begin
    S1 := S;
    SubStr1 := SubStr;
  end;

  if WholeWord = False then
    Result := PosEx(SubStr1, S1, Offset)
  else
  begin
    S1Len := Length(S1);
    SubStr1Len := Length(SubStr1);
    NewOffset := Offset;
    while True do
    begin
      HalfResult := PosEx(SubStr1, S1, NewOffset);
      if HalfResult = 0 then
      begin
        Result := 0;
        Exit;
      end;
      if HalfResult = 1
        then BefC := #0
        else BefC := S1[HalfResult-1];
      if HalfResult + SubStr1Len - 1 = S1Len
        then AfC := #0
        else AfC := S1[HalfResult + SubStr1Len];
      if (BefC = #0) or (FindChar(BefC, WordDelimitersEh) > 0)
        then BefDelOk := True
        else BefDelOk := False;
      if (AfC = #0) or (FindChar(AfC, WordDelimitersEh) > 0)
        then AfDelOk := True
        else AfDelOk := False;
      if BefDelOk and AfDelOk then
      begin
        Result := HalfResult;
        Exit;
      end else if AfC = #0 then
      begin
        Result := 0;
        Exit;
      end;
      NewOffset := NewOffset + SubStr1Len;
    end;
  end;
end;

function SysFloatToStr(Value: Extended): String;
var
  ASep: Char;
begin
  ASep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  try
    Result := FloatToStr(Value);
  finally
    FormatSettings.DecimalSeparator := ASep;
  end;
end;

function SysVarToStr(const Value: Variant): String;
var
  OldDecimalSeparator: Char;
  OldDateSeparator: Char;
  OldShortDateFormat: String;
  OldTimeSeparator: Char;
  OldShortTimeFormat: String;
begin
  OldDecimalSeparator := FormatSettings.DecimalSeparator;
  OldDateSeparator := FormatSettings.DateSeparator;
  OldShortDateFormat := FormatSettings.ShortDateFormat;
  OldTimeSeparator := FormatSettings.TimeSeparator;
  OldShortTimeFormat := FormatSettings.ShortTimeFormat;

  FormatSettings.DecimalSeparator := '.';
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'YYYY/MM/DD';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortTimeFormat := 'HH:NN:SS';
  try
    if VarType(Value) = varCurrency then
      Result := CurrToStr(Value)
    else if VarType(Value) = varDate then
      Result := DateTimeToStr(Value)
    else
      Result := VarToStr(Value);
  finally
    FormatSettings.DecimalSeparator := OldDecimalSeparator;
    FormatSettings.DateSeparator := OldDateSeparator;
    FormatSettings.ShortDateFormat := OldShortDateFormat;
    FormatSettings.TimeSeparator := OldTimeSeparator;
    FormatSettings.ShortTimeFormat := OldShortTimeFormat;
  end;
end;

function SysStrToVar(const Value: String; VarType: Word): Variant;
var
  OldDecimalSeparator: Char;
  OldDateSeparator: Char;
  OldShortDateFormat: String;
  OldTimeSeparator: Char;
  OldShortTimeFormat: String;
begin
  Result := Null;
  OldDecimalSeparator := FormatSettings.DecimalSeparator;
  OldDateSeparator := FormatSettings.DateSeparator;
  OldShortDateFormat := FormatSettings.ShortDateFormat;
  OldTimeSeparator := FormatSettings.TimeSeparator;
  OldShortTimeFormat := FormatSettings.ShortTimeFormat;

  FormatSettings.DecimalSeparator := '.';
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'YYYY/MM/DD';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortTimeFormat := 'HH:NN:SS';
  try
    VarCast(Result, Value, VarType);
  finally
    FormatSettings.DecimalSeparator := OldDecimalSeparator;
    FormatSettings.DateSeparator := OldDateSeparator;
    FormatSettings.ShortDateFormat := OldShortDateFormat;
    FormatSettings.TimeSeparator := OldTimeSeparator;
    FormatSettings.ShortTimeFormat := OldShortTimeFormat;
  end;
end;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then FreeAndNil(DrawBitmap);
  FreeAndNil(AlphaBitmap);
end;

procedure ArrayInsertRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);
var
  I: Integer;
begin
  if Amount < 0 then raise Exception.Create('ArrayInsertRange: (Amount < 0)');
  if StartIndex > Length(Extents) then raise Exception.Create('ArrayInsertRange: StartIndex > Length(Extents)');

  if Length(Extents) = StartIndex then
    SetLength(Extents, Length(Extents)+Amount)
  else
  begin
    SetLength(Extents, Length(Extents)+Amount);
    for I := Length(Extents)- Amount - 1 downto StartIndex do
      Extents[I+Amount] := Extents[I];
  end;
end;

procedure ArrayDeleteRange(var Extents: TVariantArrayEh; StartIndex, Amount: Longint);
var
  I: Integer;
begin
  if Amount < 0 then raise Exception.Create('ArrayDeleteRange: (Amount < 0)');
  if StartIndex + Amount > Length(Extents) then raise Exception.Create('ArrayDeleteRange: StartIndex + Amount > Length(Extents)');

  if StartIndex + Amount < Length(Extents) then
    for I := StartIndex to Length(Extents) - Amount - 1 do
      Extents[I] := Extents[I+Amount];

  SetLength(Extents, Length(Extents)-Amount);
end;

procedure ParseDateTimeFormatForTimeUnits(Format: string; out TimeUnits: TCalendarDateTimeUnitsEh);
var
  i: Integer;
  c: Char;
  BetweenQuotes: Boolean;
  QuotesChar: Char;
  s: String;
begin
  TimeUnits := [];
  BetweenQuotes := False;
  Format := NlsUpperCase(Format);
  i := 1;
  QuotesChar := #0;
  while i <= Length(Format) do
  begin
    c := Format[i];
    if ((c = '''') or (c = '"')) then
    begin
      if not BetweenQuotes then
      begin
        BetweenQuotes := True;
        QuotesChar := c;
      end else if c = QuotesChar then
        BetweenQuotes := False;
    end else if not BetweenQuotes then
    begin
      case c of
        'Y':
          TimeUnits := TimeUnits + [cdtuYearEh];
        'M':
          TimeUnits := TimeUnits + [cdtuMonthEh];
        'D':
          TimeUnits := TimeUnits + [cdtuDayEh];
        'H':
          TimeUnits := TimeUnits + [cdtuHourEh];
        'N':
          TimeUnits := TimeUnits + [cdtuMinuteEh];
        'S':
          TimeUnits := TimeUnits + [cdtuSecondEh];
        'A':
          begin
            s := Copy(Format, i, 5);
            if s = 'AM/PM' then
            begin
              TimeUnits := TimeUnits + [cdtuAmPmEh];
              i := i + 5;
              Continue;
            end;
            s := Copy(Format, i, 3);
            if s = 'A/P' then
            begin
              TimeUnits := TimeUnits + [cdtuAmPmEh];
              i := i + 3;
              Continue;
            end;
            s := Copy(Format, i, 4);
            if s = 'AMPM' then
            begin
              TimeUnits := TimeUnits + [cdtuAmPmEh];
              i := i + 4;
              Continue;
            end;
          end;
      end;
    end;
    i := i + 1;
  end;
end;

procedure GetHoursTimeFormat({LCid: TLocaleID; }var HoursFormat: THoursTimeFormatEh;
  var AmPmPos: TAmPmPosEh);
{$IFDEF FPC_CROSSP}
begin
  HoursFormat := htfAmPm12hEh;
  AmPmPos := appAmPmSuffixEh;
end;
{$ELSE}
  {$IFDEF FPC}
const
LOCALE_ITIMEMARKPOSN = $00001005; 
  {$ELSE}
  {$ENDIF}
var
  DOWFlag: Integer;
  A: array[0..1] of char;
begin
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_ITIME, A, SizeOf(A));
  DOWFlag := Ord(A[0]) - Ord('0');
  if DOWFlag = 0 then
    HoursFormat := htfAmPm12hEh
  else
    HoursFormat := htf24hEh;

  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_ITIMEMARKPOSN, A, SizeOf(A));
  DOWFlag := Ord(A[0]) - Ord('0');
  if DOWFlag = 0 then
    AmPmPos := appAmPmSuffixEh
  else
    AmPmPos := appAmPmPrefixEh;
end;
{$ENDIF}

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  B, R: TRect;
  Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin { Use ExtTextOut for solid colors }
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    WindowsExtTextOut(ACanvas.Handle, Left, ARect.Top + DY, ETO_OPAQUE or
      ETO_CLIPPED, ARect, Text, Length(Text));
  end else
  begin { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      DrawBitmap.Width := Max(DrawBitmap.Width, ARect.Right - ARect.Left);
      DrawBitmap.Height := Max(DrawBitmap.Height, ARect.Bottom - ARect.Top);
      R := Rect(DX, DY, ARect.Right - ARect.Left - 1, ARect.Bottom - ARect.Top - 1);
      B := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      DrawBitmap.Canvas.Font := ACanvas.Font;
      DrawBitmap.Canvas.Font.Color := ACanvas.Font.Color;
      DrawBitmap.Canvas.Brush := ACanvas.Brush;
      DrawBitmap.Canvas.Brush.Style := bsSolid;
      DrawBitmap.Canvas.FillRect(B);
      SetBkMode(DrawBitmap.Canvas.Handle, TRANSPARENT);
      DrawTextEh(DrawBitmap.Canvas.Handle, Text, Length(Text), R, AlignFlags[Alignment]);
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;
{$ENDIF}

function MinimizeText(const Text: string; Canvas: TCanvas; MaxWidth: Integer): string;
var
  I: Integer;
begin
  Result := Text;
  I := 1;
  while (I <= Length(Text)) and (Canvas.TextWidth(Result) > MaxWidth) do
  begin
    Inc(I);
    Result := Copy(Text, 1, Max(0, Length(Text) - I)) + '...';
  end;
end;

function GetTextWidth(Canvas: TCanvas; const Text: String): Integer;
var
  ARect: TRect;
  uFormat: Integer;
begin
  uFormat := DT_CALCRECT or DT_LEFT or DT_NOPREFIX;
  ARect := Rect(0, 0, 1, 0);
  DrawTextEh(Canvas.Handle, Text, Length(Text), ARect, uFormat);
  Result := ARect.Right - ARect.Left;
end;

procedure WriteTextEh(ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer;
  Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean;
  EndEllipsis: Boolean; LeftMarg, RightMarg: Integer; RightToLeftReading: Boolean;
  ForceSingleLine: Boolean);
{$IFDEF FPC_CROSSP}
const
  VertAlignments: array[TTextLayout] of TVerticalAlignment =
    (taAlignTop, taVerticalCenter, taAlignBottom);
var
  Options: TDrawTextOptionsEh;
begin
  if (FillRect) then
    ACanvas.FillRect(ARect);

  Options.HorzAlignment := Alignment;
  Options.VertAlignment := VertAlignments[Layout];
  if (MultyL = True) then
    Options.WrapStyle := twsWordWrapEh
  else if (ForceSingleLine = True) then
    Options.WrapStyle := twsSingleLineEh
  else
    Options.WrapStyle := twsNoWrapEh;
  Options.FillBack := False;
  if (RightToLeftReading)
    then Options.BiDiMode := bdRightToLeftReadingOnly
    else Options.BiDiMode := bdLeftToRight;
  Options.EndEllipsis := EndEllipsis;

  if Alignment = taLeftJustify then
    ARect.Left := ARect.Left + DX
  else if Alignment = taRightJustify then
    ARect.Right := ARect.Right - DX;

  ARect.Top := ARect.Top + DY;

  DrawTextEh(ACanvas, Text, ARect, EmptyRect, Options);
end;
{$ELSE}
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
  RTL: array[Boolean] of Integer = (0, DT_RTLREADING);
var
  txth, DrawFlag, Left, TextWidth, TextHeight, Top: Integer;
  lpDTP: TDrawTextParams;
  B: TRect;
  I: TColorRef;
  BrushStyle: TBrushStyle;
  BrushColor: TColor;

  function CanvasHaveWorldTransform(ACanvas: TCanvas): Boolean;
  var
    {$IFDEF FPC}
    XForm: TXFORM;
    {$ELSE}
    XForm: tagXFORM;
    {$ENDIF}
  begin
    GetWorldTransform(ACanvas.Handle, XForm);
    if (XForm.eM11 = 1) and
       (XForm.eM12 = 0) and
       (XForm.eM21 = 0) and
       (XForm.eM22 = 1) and
       (XForm.eDx = 0) and
       (XForm.eDy = 0)
     then
       Result := False
     else
       Result := True;
  end;

  function RestrictClipRegionAlignment(Canvas: TCanvas; Rect: TRect): TRCRRec;
  var
    RectRgn: HRGN;
  begin
    {if UseRightToLeftAlignment then
    begin
      Rect.Left := ClientWidth - Rect.Left;
      Rect.Right := ClientWidth - Rect.Right;
    end;}
    Result.RectRgn := CreateRectRgn(0, 0, 0, 0);
    Result.Result := GetClipRgn(Canvas.Handle, Result.RectRgn);
    RectRgn := CreateRectRgn(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    ExtSelectClipRgn(Canvas.Handle, RectRgn, RGN_AND);
    DeleteObject(RectRgn);
  end;

  procedure RestoreClipRegion(Canvas: TCanvas; RCR: TRCRRec);
  begin
    if RCR.Result = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, RCR.RectRgn);
    DeleteObject(RCR.RectRgn);
  end;

  procedure DrawTextOnCanvas(ACanvas: TCanvas);
  var
    rect1, rect2: TRect;
    RCR: TRCRRec;
    HaveClip: Boolean;
  begin
    HaveClip := False;
    DrawFlag := 0;
    if (MultyL = True) then
      DrawFlag := DrawFlag or DT_WORDBREAK
    else if ForceSingleLine then
      DrawFlag := DrawFlag or DT_SINGLELINE;
    if (EndEllipsis = True) then DrawFlag := DrawFlag or DT_END_ELLIPSIS;
    DrawFlag := DrawFlag or AlignFlags[Alignment] or RTL[RightToLeftReading];

    rect1 := B; {}

    lpDTP.cbSize := SizeOf(lpDTP);
    lpDTP.uiLengthDrawn := Length(Text);
    lpDTP.iLeftMargin := LeftMarg;
    lpDTP.iRightMargin := RightMarg;

    if Alignment = taLeftJustify then
      rect1.Left := rect1.Left + DX;
    if Alignment = taCenter then
      rect1.Right := rect1.Right - DX;
    rect2 := rect1;

    if (Layout <> tlTop) {and (MultyL = True)} then
      txth := WindowsDrawTextEx(ACanvas.Handle, Text,
        rect1, DrawFlag or DT_CALCRECT, lpDTP) 
    else
      txth := 0;

    rect1 := rect2;

    case Layout of
      tlTop: rect1.top := rect1.top + DY;
      tlBottom: rect1.top := rect1.Bottom - txth - DY;
      tlCenter: rect1.top := (rect1.Bottom + rect1.top - txth) div 2;
    end;

    case Alignment of
      taLeftJustify: ;
      taRightJustify: lpDTP.iRightMargin := lpDTP.iLeftMargin + DX;
      taCenter: ;
    end;

    if (rect1.Top < rect2.Top) and
       not CanvasHaveWorldTransform(ACanvas) then
    begin
      RCR := RestrictClipRegionAlignment(ACanvas, rect2);
      HaveClip := True;
    end;


    WindowsDrawTextEx(ACanvas.Handle, Text, rect1, DrawFlag, lpDTP);

    if HaveClip then
      RestoreClipRegion(ACanvas, RCR);
 end;

begin

  I := ColorToRGB(ACanvas.Brush.Color);
  if (GetNearestColor(ACanvas.Handle, I) = I) then
  begin { Use ExtTextOut for solid colors and single-line text}
    if MultyL or (LeftMarg <> 0) or (RightMarg <> 0) or
       EndEllipsis or (Length(Text) > 32768) or not ForceSingleLine then
    begin
      B := ARect;
      BrushStyle := ACanvas.Brush.Style;
      BrushColor := ACanvas.Brush.Color;
      if FillRect
        then ACanvas.FillRect(B)
        else ACanvas.Brush.Style := bsClear;
      DrawTextOnCanvas(ACanvas);
      if not FillRect then
      begin
        ACanvas.Brush.Style := BrushStyle;
        ACanvas.Brush.Color := BrushColor;
      end;
    end else
    begin
      if EndEllipsis then Text := MinimizeText(Text, ACanvas, ARect.Right - ARect.Left - DX);
      if (Alignment <> taLeftJustify) and (ACanvas.Font.Style * [fsBold, fsItalic] <> []) then
      begin
        TextWidth := GetTextWidth(ACanvas, Text)
      end else
        TextWidth := ACanvas.TextWidth(Text);

      case Alignment of
        taLeftJustify:
          Left := ARect.Left + DX;
        taRightJustify:
          Left := ARect.Right - TextWidth - 1 - DX;
      else { taCenter }
        if (ARect.Right > ARect.Left) then
          Left := ARect.Left + (ARect.Right - ARect.Left) shr 1 - (TextWidth shr 1)
        else
          Left := 0;
      end;

      Top := ARect.Top;
      if Layout <> tlTop then
      begin
        TextHeight := ACanvas.TextHeight(Text);
        if ARect.Bottom - ARect.Top - DY > TextHeight then
        case Layout of
          tlCenter: Top := (ARect.Bottom + ARect.Top - TextHeight) div 2  - DY;
          tlBottom: Top := ARect.Bottom - TextHeight - DY*2;
        end;
      end;

      BrushColor := ACanvas.Brush.Color;
      BrushStyle := ACanvas.Brush.Style;
      if not FillRect then
        ACanvas.Brush.Style := bsClear
      {$IFDEF FPC}
      else
        ACanvas.FillRect(ARect)
      {$ENDIF}
      ;

      if RightToLeftReading then
        ACanvas.TextFlags := ACanvas.TextFlags or ETO_RTLREADING;

      ACanvas.TextRect(ARect, Left, Top + DY, Text);
      if not FillRect then
      begin
        ACanvas.Brush.Style := BrushStyle;
        ACanvas.Brush.Color := BrushColor;
      end;
    end;
  end
  else begin
    DrawBitmap.Canvas.Lock;
    try
      DrawBitmap.Width := Max(DrawBitmap.Width, ARect.Right - ARect.Left);
      DrawBitmap.Height := Max(DrawBitmap.Height, ARect.Bottom - ARect.Top);
      B := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      DrawBitmap.Canvas.Font := ACanvas.Font;
      DrawBitmap.Canvas.Font.Color := ACanvas.Font.Color;
      DrawBitmap.Canvas.Brush := ACanvas.Brush;
      DrawBitmap.Canvas.Brush.Style := bsSolid;

      SetBkMode(DrawBitmap.Canvas.Handle, TRANSPARENT);

      {if (FillRect = True) then } DrawBitmap.Canvas.FillRect(B);

      DrawTextOnCanvas(DrawBitmap.Canvas);

      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;
{$ENDIF}

function CreateRotatedFont(Font: TFont; Orientation: Integer): HFont;
var
  lf: TLogFont;
begin
  lf.lfEscapement := Orientation;
  lf.lfOrientation := Orientation;

  {$IFDEF FPC}
  if Font.Height <> 0
    then lf.lfHeight := Font.Height
    else lf.lfHeight := -(GetFontSize(Font) * Font.PixelsPerInch) div 72;
  {$ELSE}
  lf.lfHeight := Font.Height;
  {$ENDIF}
  lf.lfWidth := 0; { have font mapper choose }
  if fsBold in Font.Style
    then lf.lfWeight := FW_BOLD
    else lf.lfWeight := FW_NORMAL;
  lf.lfItalic := Byte(fsItalic in Font.Style);
  lf.lfUnderline := Byte(fsUnderline in Font.Style);
  lf.lfStrikeOut := Byte(fsStrikeOut in Font.Style);
  lf.lfCharSet := Byte(Font.Charset);
{$IFDEF CIL}
  if NlsCompareText(Font.Name, 'Default') = 0 
    then lf.lfFaceName := DefFontData.Name
    else lf.lfFaceName := Font.Name;
{$ELSE}
{$IFDEF EH_LIB_12}
  if NlsCompareText(Font.Name, 'Default') = 0 
    then StrPLCopy(lf.lfFaceName, String(DefFontData.Name), Length(DefFontData.Name))
    else StrPLCopy(lf.lfFaceName, String(Font.Name), Length(Font.Name));
{$ELSE}
  if CompareText(Font.Name, 'Default') = 0 
    then StrPCopy(lf.lfFaceName, DefFontData.Name)
    else StrPCopy(lf.lfFaceName, Font.Name);
{$ENDIF}
{$ENDIF}
  lf.lfQuality := DEFAULT_QUALITY;
  { Everything else as default }
  lf.lfOutPrecision := OUT_TT_ONLY_PRECIS; 
  lf.lfClipPrecision := CLIP_DEFAULT_PRECIS;
  case Font.Pitch of
    fpVariable: lf.lfPitchAndFamily := VARIABLE_PITCH;
    fpFixed: lf.lfPitchAndFamily := FIXED_PITCH;
  else
    lf.lfPitchAndFamily := DEFAULT_PITCH;
  end;

  Result := CreateFontIndirect(lf);
end;

function WriteTextVerticalEh(ACanvas:TCanvas;
                          ARect: TRect;          
                          FillRect:Boolean;      
                          DX, DY: Integer;       
                          const Text: string;    
                          Alignment: TAlignment; 
                          Layout: TTextLayout;   
                          MultyL: Boolean;
                          EndEllipsis: Boolean;   
                          CalcTextExtent: Boolean  
                          ): Integer;
{$IFDEF FPC_CROSSP}
var
  BaseLayout: TTextLayout;
begin
  BaseLayout := Layout;
  case Alignment of
    taLeftJustify: Layout := tlBottom;
    taRightJustify: Layout := tlTop;
    taCenter: Layout := tlCenter;
  end;
  case BaseLayout of
    tlTop: Alignment := taRightJustify;
    tlCenter: Alignment := taCenter;
    tlBottom: Alignment := taLeftJustify;
  end;
  SwapInt(DX, DY);
  Result := WriteRotatedTextEh(ACanvas, ARect, FillRect, DX, DY, Text, Alignment, Layout, 90, EndEllipsis, CalcTextExtent);
end;
{$ELSE}

  procedure ResetCanvas(ACanvas: TCanvas);
  var
    {$IFDEF FPC}
    XForm: TXFORM;
    {$ELSE}
    XForm: tagXFORM;
    {$ENDIF}
  begin
    XForm.eM11 := 1;
    XForm.eM12 := 0;
    XForm.eM21 := 0;
    XForm.eM22 := 1;
    XForm.eDx := 0;
    XForm.eDy := 0;
    SetWorldTransform(ACanvas.Handle, XForm);
    SetGraphicsMode(ACanvas.Handle, GM_COMPATIBLE);
  end;

  procedure RotateCanvas(ACanvas: TCanvas);
  var
    {$IFDEF FPC}
    XFormSrc: TXFORM;
    XForm: TXFORM;
    {$ELSE}
    XFormSrc: tagXFORM;
    XForm: tagXFORM;
    {$ENDIF}
    C: Single;
    S: Single;
    Rads: Single;
  begin
    GetWorldTransform(ACanvas.Handle, XFormSrc);

    Rads := Math.DegToRad(-90);
    C := Cos(Rads);
    S := Sin(Rads);
    XForm.eM11 := C;
    XForm.eM12 := S;
    XForm.eM21 := -S;
    XForm.eM22 := C;
    XForm.eDx := 0;
    XForm.eDy := 0;

    if (XFormSrc.eM11 <> 1) or
       (XFormSrc.eM12 <> 0) or
       (XFormSrc.eM21 <> 0) or
       (XFormSrc.eM22 <> 1)
    then
    begin
      ModifyWorldTransform(ACanvas.Handle, XForm, MWT_LEFTMULTIPLY);
    end else
    begin
      SetGraphicsMode(ACanvas.Handle, GM_ADVANCED);
      SetWorldTransform(ACanvas.Handle, XForm);
    end;

  end;

var
  ARectWidth: Integer;
  ARectHeight: Integer;
  NewRect: TRect;
  SaveIdx: Integer;
begin
  Result := 0;

  SaveIdx := SaveDC(ACanvas.Handle);
  try
    RotateCanvas(ACanvas);

    ARectWidth := RectWidth(ARect);
    ARectHeight := RectHeight(ARect);
    NewRect.Left := - ARect.Top - ARectHeight;
    NewRect.Right := NewRect.Left + ARectHeight;
    NewRect.Top := ARect.Left;
    NewRect.Bottom := NewRect.Top + ARectWidth;

    WriteTextEh(ACanvas, NewRect, FillRect, DX, DY, Text,
      Alignment, Layout, MultyL, EndEllipsis, 0, 0, False, False);

  finally
    RestoreDC(ACanvas.Handle, SaveIdx);
  end;
end;
{$ENDIF}

function WriteRotatedTextEh(ACanvas:TCanvas;
                          ARect: TRect;          
                          FillRect:Boolean;      
                          DX, DY: Integer;       
                          const Text: string;    
                          Alignment: TAlignment; 
                          Layout: TTextLayout;   
                          Orientation: Integer;
                          EndEllipsis: Boolean;   
                          CalcTextExtent: Boolean   
                          ):Integer;
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  B, R: TRect;
  Left, Top, TextWidth: Integer;
  I: TColorRef;
  tm: TTextMetric;
  Overhang: Integer;
  BrushStyle: TBrushStyle;
  {$IFDEF FPC}
  OldClipRect: TRect;
  OldClipping: Boolean;
  {$ELSE}
  OldFont: TFont;
  otm: TOutlineTextMetric;
  {$ENDIF}
  BmpCnvs: TCanvas;
begin
  I := ColorToRGB(ACanvas.Brush.Color);

  {$WARNINGS OFF}

  {$IFDEF FPC}
  ACanvas.Font.Orientation := Orientation * 10;
  {$ELSE}
  SwapInt(ARect.Top, ARect.Bottom);
  OldFont := TFont.Create;
  OldFont.Assign(ACanvas.Font);
  ACanvas.Font.Handle := CreateRotatedFont(ACanvas.Font, Orientation * 10);
  {$ENDIF}

  {$WARNINGS ON}
  try
    GetTextMetrics(ACanvas.Handle, tm);
    Overhang := tm.tmOverhang;
    {$IFDEF FPC}
    {$ELSE}
    if (tm.tmPitchAndFamily and TMPF_TRUETYPE <> 0) and
      (ACanvas.Font.Style * [fsItalic] <> []) then
    begin
      otm.otmSize := SizeOf(otm);
      WindowsGetOutlineTextMetrics(ACanvas.Handle, otm.otmSize, otm);
      Overhang := (tm.tmHeight - tm.tmInternalLeading) * otm.otmsCharSlopeRun div otm.otmsCharSlopeRise;
    end;
    {$ENDIF}

    TextWidth := ACanvas.TextWidth(Text);
    Result := TextWidth + Overhang;
    if CalcTextExtent then Exit;

    if (not FillRect) or (GetNearestColor(ACanvas.Handle, I) = I) then
    begin { Use ExtTextOut for solid colors }
      case Alignment of
        taLeftJustify:
          Left := ARect.Left + DX;
        taRightJustify:
          Left := ARect.Right - ACanvas.TextHeight(Text);
      else { taCenter }
        Left := ARect.Left + (ARect.Right - ARect.Left) div 2
          - ((ACanvas.TextHeight(Text) + tm.tmOverhang) div 2);
      end;
      case Layout of
        tlTop: Top := ARect.Top + TextWidth + Overhang;
        tlBottom: Top := ARect.Bottom - DY;
      else
        Top := ARect.Top - (ARect.Top - ARect.Bottom) div 2
          + ((TextWidth + Overhang) div 2);
      end;
      BrushStyle := ACanvas.Brush.Style;
      if not FillRect then
        ACanvas.Brush.Style := bsClear;

      {$IFDEF FPC}
      OldClipRect := ACanvas.ClipRect;
      OldClipping := ACanvas.Clipping;
      ACanvas.ClipRect := ARect;
      ACanvas.Clipping := True;
      ACanvas.TextOut(Left, Top, Text);
      ACanvas.ClipRect := OldClipRect;
      ACanvas.Clipping := OldClipping;
      {$ELSE}
      ACanvas.TextRect(ARect, Left, Top, Text);
      {$ENDIF}

      if not FillRect then
        ACanvas.Brush.Style := BrushStyle;
    end else
    begin { Use FillRect and Drawtext for dithered colors }
      DrawBitmap.Canvas.Lock;
      try
        DrawBitmap.Width := Max(DrawBitmap.Width, ARect.Right - ARect.Left);
        DrawBitmap.Height := Max(DrawBitmap.Height, ARect.Top - ARect.Bottom);
        R := Rect(DX, ARect.Top - ARect.Bottom - 1, ARect.Right - ARect.Left - 1, DY);
        B := Rect(0, 0, ARect.Right - ARect.Left, ARect.Top - ARect.Bottom);
        BmpCnvs := DrawBitmap.Canvas;
        BmpCnvs.Font := ACanvas.Font;
        BmpCnvs.Font.Color := ACanvas.Font.Color;
        BmpCnvs.Brush := ACanvas.Brush;
        BmpCnvs.Brush.Style := bsSolid;
        BmpCnvs.FillRect(B);
        SetBkMode(BmpCnvs.Handle, TRANSPARENT);
        DrawTextEh(BmpCnvs.Handle, Text, Length(Text), R, AlignFlags[Alignment]);
        ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
      finally
        DrawBitmap.Canvas.Unlock;
      end;
    end;
  finally
    {$IFDEF FPC}
    ACanvas.Font.Orientation := 0;
    {$ELSE}
    ACanvas.Font.Assign(OldFont);
    OldFont.Free;
    {$ENDIF}
  end;
end;

function WriteOneUnderOtherCharsTextEh(ACanvas: TCanvas; ARect: TRect;
  FillRect: Boolean; DX, DY: Integer; const Text: String; Alignment: TAlignment;
  Layout: TTextLayout; CalcTextExtent: Boolean): Integer;
{$IFDEF FPC_CROSSP}
begin
  raise Exception.Create('WriteOneUnderOtherCharsTextEh is not implemented');
  Result := -1;
end;
{$ELSE}
var
  tm: Windows.TTextMetric;
  i: Integer;
  s: String;
  CharRect: TRect;
  RecHandle: HRgn;
begin
  if FillRect then
    ACanvas.FillRect(ARect);
  ACanvas.Brush.Style := bsClear;

  GetTextMetrics(ACanvas.Handle, tm);

  if CalcTextExtent then
  begin
    Result := (tm.tmHeight + tm.tmExternalLeading) * Length(Text);
    Exit;
  end else
    Result := -1;

  CharRect := ARect;
  if Alignment = taLeftJustify then
    CharRect.Left := CharRect.Left + DX
  else if Alignment = taRightJustify then
    CharRect.Left := CharRect.Right - tm.tmMaxCharWidth - DX
  else
    CharRect.Left := (CharRect.Right + CharRect.Left - tm.tmMaxCharWidth) div 2;

  if Layout = tlTop then
    CharRect.Top := CharRect.Top + DY
  else if Layout = tlBottom then
    CharRect.Top := CharRect.Bottom - (tm.tmHeight + tm.tmExternalLeading) * Length(Text) - DY
  else
    CharRect.Top := (CharRect.Top + CharRect.Bottom - (tm.tmHeight + tm.tmExternalLeading) * Length(Text)) div 2;

  CharRect.Right := CharRect.Left + tm.tmMaxCharWidth;

  RecHandle := SelectClipRectangleEh(ACanvas, ARect);
  for i := 1 to Length(Text) do
  begin
    s := Text[i];
    WriteTextEh(ACanvas, CharRect, False, 0, 0, s, taCenter, tlCenter, False, False, 0, 0, False, True);
    OffsetRect(CharRect, 0, (tm.tmHeight + tm.tmExternalLeading));
  end;
  RestoreClipRectangleEh(ACanvas, RecHandle);
end;
{$ENDIF}

procedure DrawClipped(imList: TCustomImageList; Bitmap: TGraphic;
  ACanvas: TCanvas; ARect: TRect; Index, ALeftMarg, ATopMarg: Integer;
  Align: TAlignment; const ClipRect: TRect; Scale: Double = 1;
  Enabled: Boolean = True);
var
  CheckedRect, AUnionRect: TRect;
  OldRectRgn, RectRgn: HRGN;
  r, x, y: Integer;
  bmWidth, bmHeight: Integer;
  AStretchBitmap: TBitmap;
  StretchRect: TRect;
begin
  if (imList = nil) and (Bitmap = nil) then
    Exit;
  AStretchBitmap := nil;
  StretchRect := Rect(0, 0, 0, 0);
  if not IntersectRect(CheckedRect,  ARect, ClipRect) then Exit;

  begin
    if Assigned(imList) then
    begin
      bmWidth := imList.Width;
      bmHeight := imList.Height;
    end else
    begin
      bmWidth := Bitmap.Width;
      bmHeight := Bitmap.Height;
    end;
  end;

  if Scale <> 1 then
  begin
    SetCanvasZoomAndRotation(ACanvas, Scale, 0, 0, 0);
    bmWidth := Round(bmWidth * Scale);
    bmHeight := Round(bmHeight * Scale);
  end;

  case Align of
    taLeftJustify: x := ARect.Left + ALeftMarg;
    taRightJustify: x := ARect.Right - bmWidth + ALeftMarg;
  else
    x := (ARect.Right + ARect.Left - bmWidth) div 2 + ALeftMarg;
  end;
  y := (ARect.Bottom + ARect.Top - bmHeight) div 2 + ATopMarg;

  if Scale <> 1 then
  begin
    x := Round(x / Scale);
    y := Round(y / Scale);
  end;

  CheckedRect := Rect(X, Y, X + bmWidth, Y + bmHeight);
  UnionRect(AUnionRect, CheckedRect, ARect);

  if EqualRect(AUnionRect, ARect) then 
  begin
    if AStretchBitmap <> nil then
      ACanvas.StretchDraw(StretchRect, AStretchBitmap)
    else  if Assigned(imList) then
      imList.Draw(ACanvas, X, Y, Index, Enabled)
    else
      ACanvas.Draw(X, Y, Bitmap);
  end else
  begin 
    OldRectRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(ACanvas.Handle, OldRectRgn);
    RectRgn := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    
    ExtSelectClipRgn(ACanvas.Handle, RectRgn, RGN_AND);
    DeleteObject(RectRgn);

    if AStretchBitmap <> nil then
      ACanvas.StretchDraw(StretchRect, AStretchBitmap)
    else  if Assigned(imList) then
      imList.Draw(ACanvas, X, Y, Index, Enabled)
    else
      ACanvas.Draw(X, Y, Bitmap);

    if r = 0
      then SelectClipRgn(ACanvas.Handle, 0)
      else SelectClipRgn(ACanvas.Handle, OldRectRgn);
    DeleteObject(OldRectRgn);
  end;

  if Scale <> 1 then
    ResetCanvas(ACanvas);

  FreeAndNil(AStretchBitmap);
end;

procedure DrawEquilateralTriangle(ACanvas: TCanvas; ARect: TRect;
  Direction: TEquilateralTriangleDirectionEh;
  TopGradientColor, BottomGradientColor: TColor);
var
  Width, Height: Integer;
  i: Integer;
  BF: Integer;
begin
  Width := RectWidth(ARect);
  Height := RectHeight(ARect);

  if Direction in [etdUpEh, etdDownEh] then
  begin
  end else //etdLeftEh, etdRightEh
  begin
    if Height mod 2 = 0 then raise Exception.Create('ARect height is inconsistent');
    if Width <> Height div 2 + 1 then raise Exception.Create('ARect width is inconsistent');

    if Direction = etdRightEh then
    begin
      BF := 1;
    end else
    begin
      BF := -1;
      ARect.Left := ARect.Right;
    end;

    for i := 0 to Width-1 do
    begin
      ACanvas.Pen.Color := TopGradientColor;
      ACanvas.Polyline([Point(ARect.Left+i*BF, ARect.Top+i),
                        Point(ARect.Left+i*BF, ARect.Bottom-i)]);
    end;
  end;
end;

function Max(A, B: Longint): Longint;
begin
  if A > B
    then Result := A
    else Result := B;
end;

function Min(A, B: Longint): Longint;
begin
  if A < B
    then Result := A
    else Result := B;
end;

function ApproximateColor(FromColor, ToColor: TColor; Quota: Double): TColor;
var
  r, g, b: Integer;
  r1, g1, b1: Integer;
  rgb, rgb1: Int32;
begin
  rgb := ColorToRGB(CheckSysColor(FromColor));
  r := (rgb shr 16) and $FF;
  g := (rgb shr 8) and $FF;
  b := rgb and $FF;

  rgb1 := ColorToRGB(CheckSysColor(ToColor));
  r1 := (rgb1 shr 16) and $FF;
  g1 := (rgb1 shr 8) and $FF;
  b1 := rgb1 and $FF;

  r := Max(0, Min(255, r + Trunc((r1 - r) / 255 * Quota)));
  g := Max(0, Min(255, g + Trunc((g1 - g) / 255 * Quota)));
  b := Max(0, Min(255, b + Trunc((b1 - b) / 255* Quota)));
  Result := TColor((r shl 16) or (g shl 8) or b);
end;

function MightierColor(Color1, Color2: TColor): TColor;
begin
  if GetColorLuminance(Color1) > GetColorLuminance(Color2)
    then Result := Color2
    else Result := Color1;
end;

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

function PointInRect(const Rect: TRect; const P: TPoint): Boolean;
begin
  Result := (P.X >= Rect.Left) and (P.X < Rect.Right) and
            (P.Y >= Rect.Top)  and (P.Y < Rect.Bottom);
end;

function RectIntersected(const Rect1, Rect2: TRect): Boolean;
begin
  Result := (Rect1.Left <= Rect2.Right) and
            (Rect1.Right >= Rect2.Left) and
            (Rect1.Top <= Rect2.Bottom) and
            (Rect1.Bottom >= Rect2.Top);
end;

procedure SwapInt(var a, b: Integer);
var c: Integer;
begin
  c := a;
  a := b;
  b := c;
end;

procedure SwapForRTLClient(var a, b: Integer; ClientWidth: Integer);
var
  OldA: Integer;
begin
  OldA := a;
  a := ClientWidth - b;
  b := ClientWidth - OldA;
end;

procedure SwapForRTLClient(var ARect: TRect; ClientWidth: Integer);
begin
  SwapForRTLClient(ARect.Left, ARect.Right, ClientWidth);
end;

procedure ShiftForRTLClient(var a: Integer;  ClientWidth: Integer);
begin
  a := ClientWidth - a;
end;

function StringsLocate(const StrList: TStrings; const Str: String; const Options: TLocateOptions): Integer;

  function Compare(const S1, S2: String): Integer;
  begin
    if loCaseInsensitive in Options
      then Result := RoughStringCompareProcEh(S1, S2) //AnsiCompareText
      else Result := CompareStr(S1, S2);
  end;

var
  i, len, Str_len: Integer;
  S: String;
begin
  Result := -1;
  Str_len := Length(Str);
  for i := 0 to StrList.Count - 1 do
  begin
    len := Length(StrList[i]);

    if len < Str_len then
      Continue;

    if loPartialKey in Options then 
      S := Copy(StrList.Strings[i], 1, Str_len)
    else
    begin
      if len <> Str_len then
        Continue;
      S := StrList.Strings[i];
    end;

    if Compare(S, Str) = 0 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function FieldsCanModify(Fields: TFieldListEh): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Fields.Count - 1 do
    if not TField(Fields[i]).CanModify then
    begin
      Result := False;
      Exit;
    end;
end;

function FieldsCanModify(Fields: TFieldsArrEh): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Length(Fields) - 1 do
    if not TField(Fields[i]).CanModify then
    begin
      Result := False;
      Exit;
    end;
end;

function GetAllStrEntry(S, SubStr: String; var StartPoses: TIntegerDynArray;
  CaseInsensitive, WholeWord, StartOfString: Boolean): Boolean;
var
  Pos: Integer;
begin
  Pos := 1;
  SetLength(StartPoses, 0);
  if CaseInsensitive  then
  begin
    S := NlsUpperCase(S);
    SubStr := NlsUpperCase(SubStr);
  end;
  Result := False;
  while True do
  begin
    if CaseInsensitive
      then Pos := RoughStringSearchProcEh(SubStr, S, False, WholeWord, Pos)
      else Pos := StringSearch(SubStr, S, False, WholeWord, Pos);
    if Pos = 0 then
    begin
      Result := Result or False;
      Exit;
    end;
    SetLength(StartPoses, Length(StartPoses)+1);
    StartPoses[Length(StartPoses)-1] := Pos-1;

    if StartOfString then
    begin
      if Pos = 1
        then Result := True
        else Result := False;
      Exit;
    end;

    Inc(Pos);
    Result := True;
  end;
end;

function ColorToGray(AColor: TColor): TColor;
var
  Lum: Integer;
  r, g, b, rgb: Integer;
begin
  rgb := ColorToRGB(AColor);
  r := (rgb shr 16) and $FF;
  g := (rgb shr 8) and $FF;
  b := rgb and $FF;
  Lum := (r * 77 + g * 150 + b * 29) shr 8; 
  Result := Lum * $00010101;
end;

function GetColorLuminance(AColor: TColor): Integer;
var
  r, g, b, rgb: Integer;
begin
  rgb := ColorToRGB(AColor);
  r := (rgb shr 16) and $FF;
  g := (rgb shr 8) and $FF;
  b := rgb and $FF;
  Result := (r * 77 + g * 150 + b * 29) shr 8; 
end;

function ChangeColorSaturation(AColor: TColor; ASaturation: Integer): TColor;
{$IFDEF EH_LIB_17}
var
  H, S, L: Single;
begin
  RGBtoHSL(ColorToRGB(AColor), H, S, L);
  Result := MakeColor(HSLtoRGB(H, ASaturation / 256, L), 0);
end;
{$ELSE}
var
  H, S, L: Word;
begin
  ColorRGBToHLS(ColorToRGB(AColor), H, L, S);
  Result := ColorHLSToRGB(H, L, ASaturation);
end;
{$ENDIF}

function ChangeColorLuminance(AColor: TColor; ALuminance: Integer): TColor;
{$IFDEF EH_LIB_17}
var
  H, S, L: Single;
begin
  RGBtoHSL(ColorToRGB(AColor), H, S, L);
  Result := MakeColor(HSLtoRGB(H, S, ALuminance / 256), 0);
end;
{$ELSE}
var
  H, S, L: Word;
begin
  ColorRGBToHLS(ColorToRGB(AColor), H, L, S);
  Result := ColorHLSToRGB(H, ALuminance, S);
end;
{$ENDIF}

function CheckSysColor(ASysColor: TColor): TColor;
begin
  Result := StyleServices.GetSystemColor(ASysColor);
end;

function CheckRightToLeftFirstCharEh(const S: String; RightToLeftIfUncertain: Boolean): Boolean;
{$IFDEF NEXTGEN}
begin
  Result := False;
end;
{$ELSE}
{$IFDEF EH_LIB_12}
var
  MapLocale: LCID;
  arr: array of Integer;
{$ENDIF}
begin
  Result := False;
  if S = '' then Exit;

  {$IFDEF EH_LIB_12}
  if CheckWin32Version(5, 1) then
    MapLocale := LOCALE_INVARIANT
  else
    MapLocale := LOCALE_SYSTEM_DEFAULT;

  SetLength(arr, 1);
  arr[0] := 0;
  GetStringTypeEx(MapLocale, CT_CTYPE2, PWideChar(S), 1, arr[0]);

  if arr[0] in [C2_RIGHTTOLEFT, C2_ARABICNUMBER] then
    Result := True
  else if arr[0] = C2_LEFTTORIGHT then
    Result := False
  else
    Result := RightToLeftIfUncertain;
  {$ENDIF}
end;
{$ENDIF} 


type
  dptr = record
    X, Y: Integer;
    StrStart: Longint;
    StrLength: Longint;
    gtdu: Integer;
    liw: Integer;
    lis: Integer;
  end;

function geli(s: String; p0, W: Integer; var WidthPxl: Integer;
  cex: TIntegerDynArray; ML: Boolean; BrFstWrd: Boolean): Integer;

  function cexSu(c: TIntegerDynArray; p, cnt: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := p to p + cnt - 1 do
    begin
      Result := Result + c[i];
    end;
  end;

var
  i, cw, ls0, wpxl: Integer;
  sLen: Integer;
  ni: Integer;
  nlw: Integer;
begin
  cw := 0;
  ls0 := -1;
  wpxl := 0;
  sLen := Length(s);
  i := p0;
  ni := i + 1;
  while (ni <= sLen) do
  begin
    if S[ni] = ' ' then
    begin
      ls0 := ni;
      wpxl := cw + cexSu(cex, i, ni - i);
    end;
    Inc(cw, cexSu(cex, i, ni - i));
    if ML and ((S[ni] = #13) or (S[ni] = #10)) then
    begin
      if (ni < sLen-1) and (S[ni] = #13) and (S[ni+1] = #10)
        then nlw := 2
        else nlw := 1;

      Result := i;
      if (cw < W) or (i = p0) then
        Result := Result + nlw;

      WidthPxl := cw;
      Exit;
    end
    else if (cw > W) and
            ((ls0 > -1) or BrFstWrd) then
    begin
      if ML then
      begin
        if ls0 = -1 then
        begin
          Result := p0;
          WidthPxl := 0;
        end else
        begin
          Result := ls0{ + 1};
          WidthPxl := wpxl;
        end;
      end else
      begin
        Result := ni;
        WidthPxl := cw;
      end;
      Exit;
    end;
    i := ni;
    ni := StringNextCharPos(S, ni);
  end;
  Result := sLen;
  WidthPxl := cw;
end;

function CalcWrapForCharWidths(W: Integer; const Str: string; ML: Boolean; var Size: TSize;
  Cex: TIntegerDynArray; LnHgt: Integer; FLMarg: Integer): TWrappedLinesInfoEh; overload;
var
  nlp, olp, Line, wpxl: Integer;
  lsa: TWrappedLinesInfoEh;
  LineW: Integer;
  BrFstWrd: Boolean;
begin
  olp := 0;
  Line := 0;
  Size.cx := 0;
  if FLMarg > 0
    then BrFstWrd := True
    else BrFstWrd := False;

  while True do
  begin
    if (Line = 0)
      then LineW := W - FLMarg
      else LineW := W;

    nlp := geli(Str, olp, LineW, wpxl, cex, ML, BrFstWrd);
    SetLength(lsa, Line+1);
    lsa[Line].st := olp;
    lsa[Line].le := nlp - olp{ + 1};
    lsa[Line].pwi := wpxl;
    lsa[Line].phi := LnHgt;
    if wpxl > Size.cx then
      Size.cx := wpxl;
    Inc(Line);
    if nlp >= Length(Str) then
      Break;
    olp := nlp;
    if not ML then Break;
    BrFstWrd := False;
  end;

  Size.cy := Length(lsa) * LnHgt;
  Result := lsa;
end;

function CalcWrap(C: TCanvas; W: Integer; const T: string; ML: Boolean; var Size: TSize; FLMarg: Integer): TWrappedLinesInfoEh; overload;
var
  cex: TIntegerDynArray;
  cex0: TIntegerDynArray;
  tLen, sLen: Integer;
  StringSize: TSize;
  i, j: Integer;
  nj, k: Integer;
begin
  tLen := Length(T);
  sLen := StrLength(T);
  cex := nil;
  cex0 := nil;

  if (tLen = 0) then
  begin
    Size.cx := 0;
    Size.cy := 0;
    Result := nil;
    Exit;
  end;

  cex0 := GetTextExtentPointEh(C, T, StringSize);

  for i := sLen-1 downto 1 do
    cex0[i] := cex0[i] - cex0[i-1];

  SetLength(cex, tLen);
  j := 0;
  for i := 0 to sLen-1 do
  begin
    nj := StringNextCharPos(T, j+1) - 1;
    for k := j to nj - 2 do
      cex[k] := 0;
    cex[nj - 1] := cex0[i];
    j := nj;
  end;

  Result := CalcWrapForCharWidths(W, T, ML, Size, Cex, StringSize.cy, FLMarg);
end;


procedure MeasureTextEh(C: TCanvas; W: Integer; const T: string; ML: Boolean; var Size: TSize);
begin
  CalcWrap(C, W, T, ML, Size, 0);
end;

function MeasureTextInLinesEh(C: TCanvas; W: Integer; const T: string; ML: Boolean; var Size: TSize; FLMarg: Integer): TWrappedLinesInfoEh;
begin
  Result := CalcWrap(C, W, T, ML, Size, FLMarg);
end;

procedure DrawHighlightedSubTextEh(C: TCanvas; AR: TRect; X, Y: Integer;
  const T: string; A: TAlignment; La:TTextLayout; ML:Boolean; EE: Boolean;
  L, R: Integer; rlr: Boolean; const S: String; CI, WW, SOS: Boolean; HC: TColor; Pos: Integer;
  PosC: TColor; var ofv: Integer);

var
  SP: TIntegerDynArray;
  cex: TIntegerDynArray;
  cex0: TIntegerDynArray;
  i, nlp, olp, Line, wpxl, sw: Integer;
  lsa: array of TWrappedOneLineInfoEh;
  da: array of dptr;
  ddr: TRect;
  gtdu: Integer;
  ufdu: Integer;
  RectWidth: Integer;
  StringSize: TSize;
  OldBColor, OldFColor: TColor;
  RTLS: Boolean;
  flh, TopExtra: Integer;
  sb: String;
  tLen, sLen: Integer;
  nj, j, k: Integer;

  function tw(Sp, L: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := Sp to Sp+L-1 do
      Inc(Result, cex[i]);
  end;

  procedure mdarff(Pos: Integer);
  var
    Len: Integer;
    im: Integer;
    dapos: Integer;
  begin
    Len := Length(S);

    for im := 0 to Length(lsa)-1 do
    begin
      if (lsa[im].st <= Pos) and (lsa[im].st + lsa[im].le > Pos) then
      begin
        SetLength(da, Length(da)+1);
        dapos := Length(da)-1;
        da[dapos].X := tw(lsa[im].st, Pos-lsa[im].st);
        da[dapos].Y := StringSize.cy * im;
        da[dapos].StrStart := Pos;
        da[dapos].StrLength := Len;
        da[dapos].gtdu := gtdu;
        da[dapos].liw := lsa[im].pwi;
        if A = taLeftJustify then
          da[dapos].lis := X
        else if A = taRightJustify then
          da[dapos].lis := AR.Right - AR.Left - lsa[im].pwi - X - 1
        else if A = taCenter then
          da[dapos].lis := (AR.Right - AR.Left - lsa[im].pwi) div 2;
      end else
       ofv := ofv + 1;
    end;
  end;

  function IsRTLS: Boolean;
{$IFDEF NEXTGEN}
  begin
    Result := False;
  end;
{$ELSE}
  {$IFDEF EH_LIB_12}
  var
    MapLocale: LCID;
    arr: array of Integer;
  {$ENDIF}
  begin
    Result := False;
    if T = '' then Exit;

  {$IFDEF EH_LIB_12}
    if CheckWin32Version(5, 1) then
      MapLocale := LOCALE_INVARIANT
    else
      MapLocale := LOCALE_SYSTEM_DEFAULT;

    SetLength(arr, 1);
    arr[0] := 0;
    GetStringTypeEx(MapLocale, CT_CTYPE2, PWideChar(T), 1, arr[0]);

    if arr[0] in [C2_RIGHTTOLEFT, C2_ARABICNUMBER] then
      Result := True;
  {$ENDIF}
  end;
{$ENDIF} 
begin
  ofv := 0;
  SP := nil;
  cex0 := nil;
  if not GetAllStrEntry(T, S, SP, CI, WW, SOS) then
    Exit;

  tLen := Length(T);
  sLen := StrLength(T);

  RTLS := IsRTLS;
  ufdu := DT_CALCRECT or DT_LEFT or DT_NOPREFIX;
  ddr := Rect(0, 0, 1, 0);
  DrawTextEh(C.Handle, T, Length(T), ddr, ufdu);
  gtdu := ddr.Right - ddr.Left;

  if La <> tlTop then
  begin
    ddr := Rect(0, 0, AR.Right - AR.Left, 0);
    ufdu := DT_CALCRECT or DT_LEFT or DT_NOPREFIX;
    if ML then
      ufdu := ufdu or DT_WORDBREAK;
    DrawTextEh(C.Handle, T, Length(T), ddr, ufdu);
    flh := ddr.Bottom - ddr.Top;
    TopExtra := ((AR.Bottom - AR.Top) div 2) - (flh div 2);
  end else
    TopExtra := Y;

  RectWidth := AR.Right - AR.Left - X;

  cex0 := GetTextExtentPointEh(C, T, StringSize);

  for i := sLen-1 downto 1 do
    cex0[i] := cex0[i] - cex0[i-1];

  SetLength(cex, tLen);
  j := 0;
  for i := 0 to sLen-1 do
  begin
    nj := StringNextCharPos(T, j+1) - 1;
    for k := j to nj - 2 do
      cex[k] := 0;
    cex[nj - 1] := cex0[i];
    j := nj;
  end;

  olp := 0;
  Line := 0;
  while True do
  begin
    nlp := geli(T, olp, RectWidth, wpxl, cex, ML, False);
    SetLength(lsa, Line+1);
    lsa[Line].st := olp;
    lsa[Line].le := nlp - olp{ + 1};
    lsa[Line].pwi := wpxl;
    Inc(Line);
    if nlp >= Length(T)-1 then
      Break;
    olp := nlp{+1};
    if not ML then Break;
  end;

  for i := 0 to Length(SP)-1 do
    mdarff(SP[i]);

  OldBColor := C.Brush.Color;
  OldFColor := C.Font.Color;
  C.Brush.Color := HC;
  C.Font.Color := clWindowText;
  for i := 0 to Length(da)-1 do
  begin
    
    ddr := Rect(da[i].X + AR.Left + da[i].lis, da[i].Y + AR.Top + TopExtra, 0, 0);
    sw := tw(da[i].StrStart, da[i].StrLength);
    ddr.Right := ddr.Left + sw;

    ddr.Bottom := ddr.Top + StringSize.cy;

    if RTLS then
    begin
      ddr.Left := AR.Left + da[i].lis + da[i].liw - da[i].X - sw;
      ddr.Right := ddr.Left + sw;
    end;

    
    
    
    sb := Copy(T, da[i].StrStart+1, da[i].StrLength);
    DrawTextEh(C, sb, ddr, True);
    if (ddr.Left > AR.Right) or (ddr.Top > AR.Bottom) then
      ofv := ofv + 1;
  end;

  C.Brush.Color := OldBColor;
  C.Font.Color := OldFColor;
end;

function FieldValueToDispayValue(const AValue: Variant; Field: TField; const ADisplayFormat: String): String;
var
  FmtStr: string;
  Format: TFloatFormat;
  Digits: Integer;
  inf: TIntegerField;
  bcf: TBCDField;
  fbcf: TFMTBCDField;
  ff: TFloatField;
begin
  if VarIsEmpty(AValue) or VarIsNull(AValue) then
  begin
    Result := '';
    Exit;
  end;
  case Field.DataType of
    ftSmallint, ftInteger, ftAutoInc, ftWord:
      if ADisplayFormat <> '' then
        Result := FormatFloat(ADisplayFormat, AValue)
      else
      begin
        inf := (Field as TIntegerField);
        FmtStr := inf.DisplayFormat;
        if FmtStr = ''
          then Result := IntToStr(Integer(AValue))
          else Result := FormatFloat(FmtStr, AValue);
      end;
    ftBCD:
      if ADisplayFormat <> '' then
        Result := FormatFloat(ADisplayFormat, AValue)
      else
      begin
        bcf := (Field as TBCDField);
        FmtStr := bcf.DisplayFormat;
        if FmtStr = '' then
        begin
          if bcf.Currency then
          begin
            Format := ffCurrency;
            Digits := FormatSettings.CurrencyDecimals
          end
          else
          begin
            Format := ffGeneral;
            Digits := 0;
          end;
          Result := CurrToStrF(AValue, Format, Digits);
        end else
          Result := FormatCurr(FmtStr, AValue);
      end;
    ftFMTBcd:
      if ADisplayFormat <> '' then
        Result := FormatFloat(ADisplayFormat, AValue)
      else
      begin
        fbcf := (Field as TFMTBCDField);
        FmtStr := fbcf.DisplayFormat;
        if FmtStr = '' then
        begin
          if fbcf.Currency then
          begin
            Format := ffCurrency;
            Digits := FormatSettings.CurrencyDecimals
          end
          else
          begin
            Format := ffGeneral;
            Digits := 0;
          end;
          Result := CurrToStrF(AValue, Format, Digits);
        end else
          Result := FormatCurr(FmtStr, AValue);
      end;
    ftFloat, ftCurrency:
      if ADisplayFormat <> '' then
        Result := FormatFloat(ADisplayFormat, AValue)
      else
      begin
        ff := (Field as TFloatField);
        FmtStr := ff.DisplayFormat;
        if FmtStr = '' then
        begin
          if ff.Currency then
          begin
            Format := ffCurrency;
            Digits := FormatSettings.CurrencyDecimals
          end
          else begin
            Format := ffGeneral;
            Digits := 0;
          end;
          Result := FloatToStrF(Double(AValue), Format, ff.Precision, Digits);
        end else
          Result := FormatFloat(FmtStr, AValue);
      end;
    ftDate, ftTime, ftDateTime:
      begin
        if ADisplayFormat <> '' then
          FmtStr := ADisplayFormat
        else
          case Field.DataType of
            ftDate: FmtStr := FormatSettings.ShortDateFormat;
            ftTime: FmtStr := FormatSettings.LongTimeFormat;
          end;
        DateTimeToString(Result, FmtStr, TDateTime(AValue));
      end;
  else
    Result := VarToStr(AValue);
  end;
end;

procedure BroadcastPerformMessageFor(Owner: TComponent; ForClass: TControlClass;
  Msg: Cardinal; WParam: WPARAM; LParam: LPARAM);
var
  i: Integer;
begin
  for i := 0 to Owner.ComponentCount-1 do
  begin
    if Owner.Components[i] is ForClass then
    begin
      TControl(Owner.Components[i]).Perform(Msg, WParam, LParam);
    end;
    BroadcastPerformMessageFor(Owner.Components[i], ForClass, Msg, WParam, LParam);
  end;
end;

procedure CheckPostApplicationMessage(Msg: Cardinal; WParam: WPARAM; LParam: LPARAM);
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  CharMsg: Windows.TMsg;
begin
  if not PeekMessage(CharMsg, 0, Msg, Msg, PM_NOREMOVE) then
    {$IFDEF FPC}
    PostMessage(Win32WidgetSet.AppHandle, Msg, WParam, LParam);
    {$ELSE}
    PostMessage(Application.Handle, Msg, WParam, LParam);
    {$ENDIF}
end;
{$ENDIF} 

function IsDoubleClickMessage(OldPos, NewPos: TPoint; Interval: Longint): Boolean;
begin
  Result := (Interval <= Longint(GetDoubleClickTime)) and
            (Abs(OldPos.X - NewPos.X) <= GetSystemMetrics(SM_CXDOUBLECLK)) and
            (Abs(OldPos.Y - NewPos.Y) <= GetSystemMetrics(SM_CYDOUBLECLK));
end;

procedure GetCheckSize;
var
  b: TBitmap;
{$IFDEF FPC_CROSSP}

{$ELSE}
  {$IFDEF MSWINDOWS}
  ElementDetails: TThemedElementDetails;
  Size: TSize;
  DC: HDC;
  {$ELSE}
  {$ENDIF} // ELSE MSWINDOWS

{$ENDIF} 
begin
  b := TBitmap.Create;
  try
{$IFDEF FPC_CROSSP}
    DefaultCheckBoxWidth := GetSystemMetrics(SM_CXMENUCHECK);
    DefaultCheckBoxHeight := GetSystemMetrics(SM_CYMENUCHECK);
    DefaultFlatCheckBoxWidth := DefaultCheckBoxWidth - 1;
    DefaultFlatCheckBoxHeight := DefaultCheckBoxHeight - 1;
{$ELSE}

  {$IFDEF MSWINDOWS}
    if ThemeServices.ThemesEnabled then
    begin
      DC := CreateCompatibleDC(0);
      try
        ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxCheckedNormal);
        StyleServices.GetElementSize(DC, ElementDetails, esActual, Size);
        DefaultCheckBoxWidth := Size.cx;
        DefaultCheckBoxHeight := Size.cy;
    finally
      DeleteDC(DC);
    end;
  end else
    begin
      b.Handle := LoadBitmapEh(0, OBM_CHECKBOXES);
      DefaultCheckBoxWidth := b.Width div 4;
      DefaultCheckBoxHeight := b.Height div 3;
    end;
    DefaultFlatCheckBoxWidth := DefaultCheckBoxWidth - 1;
    DefaultFlatCheckBoxHeight := DefaultCheckBoxHeight - 1;
  {$ELSE}
    DefaultCheckBoxWidth := GetSystemMetrics(SM_CXMENUCHECK);
    DefaultCheckBoxHeight := GetSystemMetrics(SM_CYMENUCHECK);
    DefaultFlatCheckBoxWidth := DefaultCheckBoxWidth - 1;
    DefaultFlatCheckBoxHeight := DefaultCheckBoxHeight - 1;
  {$ENDIF} // ELSE MSWINDOWS

{$ENDIF} 
  finally
    b.Free;
  end;

end;

function AdjustCheckBoxRect(ClientRect: TRect; Alignment: TAlignment;
  Layout: TTextLayout{; Flat: Boolean}): TRect;
var
  CheckWidth, CheckHeight: Integer;
begin

  if (ClientRect.Right - ClientRect.Left) > DefaultCheckBoxWidth
    then CheckWidth := DefaultCheckBoxWidth
    else CheckWidth := ClientRect.Right - ClientRect.Left;

  if (ClientRect.Bottom - ClientRect.Top) > DefaultCheckBoxHeight
    then CheckHeight := DefaultCheckBoxHeight
    else CheckHeight := ClientRect.Bottom - ClientRect.Top;


  Result := ClientRect;

  if (ClientRect.Right - ClientRect.Left) > DefaultCheckBoxWidth then
    case Alignment of
      taRightJustify: Result.Left := Result.Right - CheckWidth;
      taCenter: Result.Left := Result.Left + (ClientRect.Right - ClientRect.Left) shr 1 - CheckWidth shr 1;
    end;
  Result.Right := Result.Left + CheckWidth;

  if (ClientRect.Bottom - ClientRect.Top) > DefaultCheckBoxHeight then
    case Layout of
      tlBottom: Result.Top := Result.Bottom - CheckWidth;
      tlCenter: Result.Top := Result.Top + (ClientRect.Bottom - ClientRect.Top) shr 1 - CheckHeight shr 1;
    end;
  Result.Bottom := Result.Top + CheckHeight;
end;

procedure DrawCheckBoxEh(DC: HDC; R: TRect; AState: TCheckBoxState; AEnabled, AFlat,
  ADown, AActive: Boolean);
var
  DrawState, OldRgn: Integer;
  DrRt: TRect;
  Rgn, SaveRgn: HRgn;
  ElementDetails: TThemedElementDetails;
  Detail: TThemedButton;
begin
  SaveRgn := 0;
  OldRgn := 0;
  DrRt := R;
  if (DrRt.Right - DrRt.Left) > (DrRt.Bottom - DrRt.Top) then
  begin
    DrRt.Left := DrRt.Left + ((DrRt.Right - DrRt.Left) - (DrRt.Bottom - DrRt.Top)) div 2;
    DrRt.Right := DrRt.Left + (DrRt.Bottom - DrRt.Top);
  end else if (DrRt.Right - DrRt.Left) < (DrRt.Bottom - DrRt.Top) then
  begin
    DrRt.Top := DrRt.Top + ((DrRt.Bottom - DrRt.Top) - (DrRt.Right - DrRt.Left)) div 2;
    DrRt.Bottom := DrRt.Top + (DrRt.Right - DrRt.Left);
  end;

  case AState of
    cbChecked:
      DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
    cbUnchecked:
      DrawState := DFCS_BUTTONCHECK;
  else 
    DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
  end;

  if not AEnabled then
    DrawState := DrawState or DFCS_INACTIVE;
  if ADown then
    DrawState := DrawState or DFCS_PUSHED;
  if AFlat then
  begin
      { Remember current clipping region }
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    OldRgn := GetClipRgn(DC, SaveRgn);
      { Clip 3d-style checkbox to prevent flicker }
    if ThemesEnabled then
      Rgn := CreateRectRgn(DrRt.Left + 2, DrRt.Top + 2, DrRt.Right - 2, DrRt.Bottom - 2)
    else
      Rgn := CreateRectRgn(DrRt.Left + 1, DrRt.Top + 1, DrRt.Right - 1, DrRt.Bottom - 1);
    
    ExtSelectClipRgn(DC, Rgn, RGN_AND);
    DeleteObject(Rgn);
  end;
  if AFlat and not ThemesEnabled then InflateRect(DrRt, 1, 1);

  if ThemeServices.ThemesEnabled then
  begin
    case AState of
      cbChecked:
        if AEnabled then
          if ADown then Detail := tbCheckBoxCheckedPressed
          else if AActive then Detail := tbCheckBoxCheckedHot
          else Detail := tbCheckBoxCheckedNormal
        else Detail := tbCheckBoxCheckedDisabled;
      cbUnchecked:
        if AEnabled then
          if ADown then Detail := tbCheckBoxUncheckedPressed
          else if AActive then Detail := tbCheckBoxUncheckedHot
          else Detail := tbCheckBoxUncheckedNormal
        else Detail := tbCheckBoxUncheckedDisabled;
      else 
        if AEnabled then
          if ADown then Detail := tbCheckBoxMixedPressed
          else if AActive then Detail := tbCheckBoxMixedHot
          else Detail := tbCheckBoxMixedNormal
        else Detail := tbCheckBoxMixedDisabled;
    end;
    ElementDetails := ThemeServices.GetElementDetails(Detail);
    ThemeServices.DrawElement(DC, ElementDetails, R);
  end
  else
    DrawFrameControl(DC, DrRt, DFC_BUTTON, DrawState);

  if AFlat then
  begin
      
    if OldRgn = 0 then
      SelectClipRgn(DC, 0)
    else
      SelectClipRgn(DC, SaveRgn);
    DeleteObject(SaveRgn);
      { Draw flat rectangle in-place of clipped 3d checkbox above }
    if ThemesEnabled then
    begin
      InflateRect(DrRt, -1, -1);
      FrameRect(DC, DrRt, GetSysColorBrush(COLOR_BTNSHADOW));
    end else
    begin
      InflateRect(DrRt, -1, -1);
      if AActive
        then FrameRect(DC, DrRt, GetSysColorBrush(COLOR_BTNFACE))
        else FrameRect(DC, DrRt, GetSysColorBrush(COLOR_BTNSHADOW));
    end;

  end;
end;

const
  DownFlags: array[Boolean] of Integer = (0, DFCS_PUSHED {? or DFCS_FLAT});
  FlatFlags: array[Boolean] of Integer = (0, DFCS_FLAT);
  EnabledFlags: array[Boolean] of Integer = (DFCS_INACTIVE, 0);
  IsDownFlags: array[Boolean] of Integer = (DFCS_SCROLLUP, DFCS_SCROLLDOWN);
  PressedFlags: array[Boolean] of Integer = (EDGE_RAISED, EDGE_SUNKEN);

procedure PaintEditButtonBackgroundEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Enabled, Active, Flat, Pressed: Boolean);
var
  Rgn, SaveRgn: HRgn;
  r: Integer;
  IsClipRgn: Boolean;
  DRect: TRect;
  ElRect: TRect;
  Details: TThemedElementDetails;
begin
  if ThemeServices.ThemesEnabled then
  begin
{$IFDEF EH_LIB_16} //XE2
    Details := ThemeServices.GetElementDetails(tcReadOnlyNormal);

    if not IsThemePartDefinedEh(Details) then
    begin
      if (Flat) then
        Details := ThemeServices.GetElementDetails(ttbButtonHot)
      else
        Details := ThemeServices.GetElementDetails(tbPushButtonNormal);
    end;
{$ELSE}
    if (Flat) then
      Details := ThemeServices.GetElementDetails(ttbButtonHot)
    else
      Details := ThemeServices.GetElementDetails(tbPushButtonNormal);
{$ENDIF}

    if not Enabled then
      Details.State := 4 //Disabled
    else if Pressed then
      Details.State := 3 //Pressed
    else if Active then
      Details.State := 2; //Hot

    if ParentColor <> clNone then
      Canvas.Brush.Color := ParentColor;

    if ThemeServices.HasTransparentParts(Details) then
      Canvas.FillRect(ARect);

    ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
  end else
  begin
    DRect := ARect;
    WindowsLPtoDP(Canvas.Handle, DRect);

    IsClipRgn := Flat and Active and not ThemeServices.ThemesEnabled;
    r := 0; SaveRgn := 0;
    if IsClipRgn then
    begin
      SaveRgn := CreateRectRgn(0, 0, 0, 0);
      r := GetClipRgn(Canvas.Handle, SaveRgn);
      Rgn := CreateRectRgn(DRect.Left + 1, DRect.Top + 1, DRect.Right - 1, DRect.Bottom - 1);
      SelectClipRgn(Canvas.Handle, Rgn);
      DeleteObject(Rgn);
    end;

    if Flat and not ThemeServices.ThemesEnabled then
      if not Active {and not (Style=bcsUpDownEh)}
        then InflateRect(ARect, 2, 2)
        else InflateRect(ARect, 1, 1);

    ElRect := ARect;

    //Draw
    Canvas.Brush.Color := clBtnFace;
    if Flat then
    begin
      Canvas.FillRect(ElRect);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
    end;

    if Flat then
      if not Active
        then InflateRect(ARect, -2, -2)
        else InflateRect(ARect, -1, -1);

    if IsClipRgn then
    begin
      if r = 0
        then SelectClipRgn(Canvas.Handle, 0)
        else SelectClipRgn(Canvas.Handle, SaveRgn);
      DeleteObject(SaveRgn);
      if Pressed
        then DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
        else DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT)
    end;
  end;
end;

procedure DrawUserButtonBackground(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Enabled, Active, Flat, Pressed: Boolean);
begin
  PaintEditButtonBackgroundEh(Canvas, ARect, ParentColor, Enabled, Active, Flat, Pressed);
end;

procedure DrawEllipsisButton(Canvas: TCanvas; ARect: TRect;
  Enabled, Active, Flat, Pressed: Boolean; DrawButtonBackground: Boolean);
var
  InterP, PWid, W, H: Integer;
  ElRect: TRect;
  FromColor, ToColor: TColor;
  Points: array of TPoint;
  i: Integer;
begin
  ElRect := ARect;

  if DrawButtonBackground then
  begin
    PaintEditButtonBackgroundEh(Canvas, ARect, clNone, Enabled, Active, Flat, Pressed);
  end;

  InterP := 2;
  PWid := 2;
  W := ElRect.Right - ElRect.Left;
  if W < 12 then InterP := 1;
  if W < 8 then PWid := 1;
  W := ElRect.Left + W div 2 - PWid div 2 + Ord(Pressed);
  H := ElRect.Top + (ElRect.Bottom - ElRect.Top) div 2 - PWid div 2 + Ord(Pressed);

  if not Enabled then
  begin
    Inc(W); Inc(H);

    Canvas.Brush.Color := clBtnHighlight;
    Canvas.FillRect(Rect(W, H, W+PWid, H+PWid));
    Canvas.FillRect(Rect(W - InterP - PWid, H, W - InterP - PWid + PWid, H+PWid));
    Canvas.FillRect(Rect(W + InterP + PWid, H, W + InterP + PWid + PWid, H+PWid));

    Dec(W); Dec(H);
    Canvas.Brush.Color := clBtnShadow;
  end else
    
    Canvas.Brush.Color := clBtnText;

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    SetLength(Points, PWid*2);
    for i := 0 to PWid-1 do
    begin
      Points[i*2] := Point(0,i);
      Points[i*2+1] := Point(PWid,i);
    end;
    FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
    FillGradientEh(Canvas, Point(W - InterP - PWid, H), Points, FromColor, ToColor);
    FillGradientEh(Canvas, Point(W + InterP + PWid, H), Points, FromColor, ToColor);
  end else
  begin
    Canvas.FillRect(Rect(W, H, W+PWid, H+PWid));
    Canvas.FillRect(Rect(W - InterP - PWid, H, W - InterP - PWid + PWid, H+PWid));
    Canvas.FillRect(Rect(W + InterP + PWid, H, W + InterP + PWid + PWid, H+PWid));
  end;
end;

procedure DrawPlusMinusButton(Canvas: TCanvas; ARect: TRect;
  Enabled, Active, Flat, Pressed, Plus: Boolean; DrawButtonBackground: Boolean);
var
  PWid, PHet, W, H, PlusInd, MinWH: Integer;
  ElRect: TRect;
  FromColor, ToColor: TColor;
  Points: array of TPoint;
  i,iv: Integer;
begin
  ElRect := ARect;

  if DrawButtonBackground then
  begin
    PaintEditButtonBackgroundEh(Canvas, ARect, clNone, Enabled, Active, Flat, Pressed);
  end else
  begin
    if not ThemeServices.ThemesEnabled and Flat then
      InflateRect(ElRect, -1, -1)
    else
      InflateRect(ElRect, -2, -2);
  end;

  MinWH := ElRect.Right - ElRect.Left;
  if ElRect.Bottom - ElRect.Top < MinWH then
    MinWH := ElRect.Bottom - ElRect.Top;
  PWid := MinWH * 4 div 7;
  if PWid = 0 then PWid := 1;
  PHet := PWid div 3;
  if PHet = 0 then PHet := 1;
  if Flat then Dec(PWid);
  if PWid mod 2 <> MinWH mod 2 then Inc(PWid);
  if Plus and (PWid mod 2 <> PHet mod 2) then
    if (MinWH < 12) then Inc(PWid) else Dec(PWid);
  PlusInd := PWid div 2 - PHet div 2;

  W := ElRect.Left + (ElRect.Right - ElRect.Left - PWid) div 2;
  Inc(W, Ord(Pressed));
  H := ElRect.Top + (ElRect.Bottom - ElRect.Top - PHet) div 2 + Ord(Pressed);

  if not Enabled then
  begin
    Inc(W); Inc(H);

    Canvas.Brush.Color := clBtnHighlight;
    Canvas.FillRect(Rect(W, H, W+PWid, H+PHet));
    if Plus then
      Canvas.FillRect(Rect(W + PlusInd, H - PlusInd, W + PlusInd + PHet, H - PlusInd + PWid));

    Dec(W); Dec(H);
    Canvas.Brush.Color := clBtnShadow;
  end else
    Canvas.Brush.Color := clBtnText;

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    if Plus
      then SetLength(Points, PHet*2+PlusInd*2+PlusInd*2)
      else SetLength(Points, PHet*2);
    iv := -1;
    if Plus then
      for i := 0 to PHet-1 do
      begin
        Points[i*2] := Point(PlusInd, i);
        Points[i*2+1] := Point(PlusInd+PHet, i);
        iv := i;
      end;
    for i := iv+1 to iv+PHet do
    begin
      Points[i*2] := Point(0,i);
      Points[i*2+1] := Point(PWid, i);
      iv := i;
    end;
    if Plus then
      for i := iv+1 to iv+PHet do
      begin
        Points[i*2] := Point(PlusInd,i);
        Points[i*2+1] := Point(PlusInd+PHet, i);
      end;
    if Plus then
      FillGradientEh(Canvas, Point(W, H-PlusInd), Points, FromColor, ToColor)
    else
      FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
  end else
  begin
    Canvas.FillRect(Rect(W, H, W+PWid, H+PHet));
    if Plus then
      Canvas.FillRect(Rect(W + PlusInd, H - PlusInd, W + PlusInd + PHet, H - PlusInd + PWid));
  end;
end;

procedure DrawOneCustomButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Active, Flat, Pressed: Boolean; DownDirection: Boolean;
  DrawButtonBackground: Boolean);
var
  PWid, W, H: Integer;
  AWidth, AHeight, ASize: Integer;
  ElRect: TRect;
  FromColor, ToColor, TmpColor: TColor;
  Points: array of TPoint;
  i: Integer;
begin
  if (Style = bcsAltUpDownEh) and ThemesEnabled then
    if DownDirection
      then Dec(ARect.Top)
      else Inc(ARect.Bottom);
  ElRect := ARect;

  if DrawButtonBackground then
  begin
    if ThemeServices.ThemesEnabled then
    begin
      PaintEditButtonBackgroundEh(Canvas, ARect, clNone, Enabled, Active, Flat, Pressed);
      InflateRect(ElRect, -2, -2);
    end else
    begin
      Canvas.Brush.Color := clBtnFace;
      if Flat then
      begin
        Canvas.FillRect(ElRect);
        InflateRect(ElRect, -1, -1)
      end else
      begin
        DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
        InflateRect(ElRect, -2, -2);
      end;
    end;
  end;

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    if not DownDirection then
    begin
      TmpColor := FromColor;
      FromColor := ToColor;
      ToColor := TmpColor;
    end;
  end else
  begin
    if Enabled then
    begin
      FromColor := clWindowText;
      ToColor := clWindowText;
    end else
    begin
      FromColor := clGrayText;
      ToColor := clGrayText;
    end
  end;

  begin
    AWidth := ARect.Right-ARect.Left;
    AHeight := ARect.Bottom-ARect.Top;
    if AHeight < AWidth
      then ASize := AHeight
      else ASize := AWidth;
    if ASize >= 19 then
      PWid := 9
    else if ASize >= 16 then
      PWid := 7
    else if ASize >= 12 then
      PWid := 5
    else if not ThemesEnabled then
      PWid := 3
    else
      PWid := 5;

    SetLength(Points, (PWid div 2 + 1)*2);
    for i := 0 to PWid div 2 do
      if DownDirection then
      begin
        Points[i*2] := Point(i,i);
        Points[i*2+1] := Point(PWid-i,i);
      end else
      begin
        Points[i*2] := Point(PWid div 2 - i, i);
        Points[i*2+1] := Point(PWid div 2 + i + 1, i);
      end;
    W := (ARect.Right + ARect.Left - PWid) div 2;
    H := (ARect.Top + ARect.Bottom - (PWid div 2 + 1)) div 2;
  end;
  if Pressed then
  begin
    Inc(W); Inc(H);
  end;
  FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
end;

procedure DrawCustomButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Active, Flat, Pressed, DownDirection: Boolean;
  DrawButtonBackground: Boolean);
var
  ButtonRect1, ButtonRect2: TRect;
begin
  if Style = bcsAltDropDownEh then
    DrawOneCustomButton(Canvas, Style, ARect, Enabled, Active, Flat,
      Pressed, True, DrawButtonBackground)
  else if Style = bcsAltUpDownEh then
  begin
    ButtonRect1 := ARect;
    ButtonRect1.Bottom := (ARect.Bottom + ARect.Top) div 2;
    if ThemesEnabled then
      Inc(ButtonRect1.Bottom);
    DrawOneCustomButton(Canvas, Style, ButtonRect1, Enabled, Active, Flat,
      Pressed and not DownDirection, False, DrawButtonBackground);
    ButtonRect2 := ARect;
    ButtonRect2.Top := (ARect.Bottom + ARect.Top) div 2 + 1;
    if ThemesEnabled then
      Dec(ButtonRect2.Top);
    DrawOneCustomButton(Canvas, Style, ButtonRect2, Enabled, Active, Flat,
      Pressed and DownDirection, True, DrawButtonBackground);
  end;
end;

procedure DrawDropDownButton(Canvas: TCanvas; ARect: TRect;
  Enabled, Flat, Active, Down: Boolean; DrawButtonBackground: Boolean);
var
  Flags: Integer;
  Details: TThemedElementDetails;
begin

  if DrawButtonBackground then
  begin
    if ThemeServices.ThemesEnabled then
    begin
      if not Enabled then
        Details := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
      else
        if Down then
          Details := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
        else
          if Active
            then Details := ThemeServices.GetElementDetails(tcDropDownButtonHot)
            else Details := ThemeServices.GetElementDetails(tcDropDownButtonNormal);

      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);

    end else
    begin
      Flags := DownFlags[Down] or FlatFlags[Flat] or EnabledFlags[Enabled];
      DrawFrameControl(Canvas.Handle, ARect, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
    end;
  end else
    Canvas.FillRect(ARect);
end;

procedure DrawUpDownButton(Canvas: TCanvas; ARect: TRect;
  Enabled, Flat, Active, Down, DownDirection: Boolean; DrawButtonBackground: Boolean);
var
  Flags: Integer;
  Details: TThemedElementDetails;
begin
  if DrawButtonBackground then
  begin
    if ThemeServices.ThemesEnabled then
    begin
      if DownDirection then
        if not Enabled then
          Details := ThemeServices.GetElementDetails(tsDownDisabled)
        else
          if Down then
            Details := ThemeServices.GetElementDetails(tsDownPressed)
          else
            if Active
              then Details := ThemeServices.GetElementDetails(tsDownHot)
              else Details := ThemeServices.GetElementDetails(tsDownNormal)
      else
        if not Enabled then
          Details := ThemeServices.GetElementDetails(tsUpDisabled)
        else
          if Down then
            Details := ThemeServices.GetElementDetails(tsUpPressed)
          else
            if Active
              then Details := ThemeServices.GetElementDetails(tsUpHot)
              else Details := ThemeServices.GetElementDetails(tsUpNormal);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
    end else
    begin
      Flags := DownFlags[Down] or FlatFlags[Flat] or EnabledFlags[Enabled];
      DrawFrameControl(Canvas.Handle, ARect, DFC_SCROLL, Flags or IsDownFlags[DownDirection]);
    end;
  end else
    Canvas.FillRect(ARect);
end;

procedure DrawOneButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Flat, Active, Down, DownDirection: Boolean;
  DrawButtonBackground: Boolean);
var
  Rgn, SaveRgn: HRgn;
  r: Integer;
  IsClipRgn: Boolean;
  DRect: TRect;
  DwBack: Boolean;
begin
  DwBack := DrawButtonBackground;
  DRect := ARect;
  WindowsLPtoDP(Canvas.Handle, DRect);

  IsClipRgn := Flat and Active and not ThemeServices.ThemesEnabled;
  r := 0; SaveRgn := 0;
  if IsClipRgn then
  begin
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(Canvas.Handle, SaveRgn);
    Rgn := CreateRectRgn(DRect.Left + 1, DRect.Top + 1, DRect.Right - 1, DRect.Bottom - 1);
    SelectClipRgn(Canvas.Handle, Rgn);
    DeleteObject(Rgn);
  end;

  if Flat and not ThemeServices.ThemesEnabled then
    if not Active {and not (Style=bcsUpDownEh)}
      then InflateRect(ARect, 2, 2)
      else InflateRect(ARect, 1, 1);
  case Style of
    bcsDropDownEh: DrawDropDownButton(Canvas, ARect, Enabled, Flat, Active, Down, DwBack);
    bcsEllipsisEh: DrawEllipsisButton(Canvas, ARect, Enabled, Active, Flat, Down, DwBack);
    bcsUpDownEh: DrawUpDownButton(Canvas, ARect, Enabled, Flat, Active, Down, DownDirection, DwBack);
    bcsMinusEh, bcsPlusEh: DrawPlusMinusButton(Canvas, ARect, Enabled, Active, Flat, Down, bcsPlusEh = Style, DwBack);
    bcsAltDropDownEh: DrawCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Down, False, DwBack);
    bcsAltUpDownEh: DrawOneCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Down, DownDirection, DwBack);
  end;
  if Flat then
    if not Active {and not (Style=bcsUpDownEh)}
      then InflateRect(ARect, -2, -2)
      else InflateRect(ARect, -1, -1);

  if IsClipRgn then
  begin
    if r = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, SaveRgn);
    DeleteObject(SaveRgn);
    if DwBack then
    begin
      if Down
        then DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
        else DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT);
     end;
  end;
end;

type

  TButtonBitmapInfoEh = record
    Size: TPoint;
    BitmapType: TDrawButtonControlStyleEh;
    Flat: Boolean;
    Pressed: Boolean;
    Active: Boolean;
    Enabled: Boolean;
    DownDirect: Boolean;
    CheckState: TCheckBoxState;
    DrawBack: Boolean;
  end;

  function CompareButtonBitmapInfo(Info1, Info2: TButtonBitmapInfoEh): Boolean;
  begin
    Result :=
          (Info1.Size.X = Info2.Size.X)
      and (Info1.Size.Y = Info2.Size.Y)
      and (Info1.BitmapType = Info2.BitmapType)
      and (Info1.Flat = Info2.Flat)
      and (Info1.Pressed = Info2.Pressed)
      and (Info1.Active = Info2.Active)
      and (Info1.Enabled = Info2.Enabled)
      and (Info1.DownDirect = Info2.DownDirect)
      and (Info1.CheckState = Info2.CheckState)
      and (Info1.DrawBack = Info2.DrawBack);
  end;

type

  { TButtonsBitmapCache }

  TButtonBitmapInfoBitmapEh = class(TObject)
  public
    BitmapInfo: TButtonBitmapInfoEh;
    Bitmap: TBitmap;
  end;

  TButtonsBitmapCache = class(TObjectList)
  private
    function Get(Index: Integer): TButtonBitmapInfoBitmapEh;
  public
    constructor Create; overload;
    procedure Clear; override;
    function GetButtonBitmap(ButtonBitmapInfo: TButtonBitmapInfoEh): TBitmap;
    property Items[Index: Integer]: TButtonBitmapInfoBitmapEh read Get {write Put}; default;
  end;

var ButtonsBitmapCache: TButtonsBitmapCache;

procedure ClearButtonsBitmapCache;
begin
  if ButtonsBitmapCache <> nil then
    ButtonsBitmapCache.Clear;
end;

function RectSize(ARect: TRect): TSize;
begin
  Result.cx := ARect.Right - ARect.Left;
  Result.cy := ARect.Bottom - ARect.Top;
end;

procedure PaintButtonControlEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Style: TDrawButtonControlStyleEh; DownButton: Integer;
  Flat, Active, Enabled: Boolean; State: TCheckBoxState; Scale: Double = 1;
  DrawButtonBackground: Boolean = True);
var
  Rgn, SaveRgn: HRgn;
  HalfRect, DRect: TRect;
  ASize: TSize;
  r: Integer;
  Brush: HBRUSH;
  IsClipRgn: Boolean;
  BitmapInfo: TButtonBitmapInfoEh;
  Bitmap: TBitmap;
  DrBack: Boolean;
begin
  DrBack := DrawButtonBackground;
  SaveRgn := 0; r := 0;
  BitmapInfo.BitmapType := Style;
  BitmapInfo.Flat := Flat;

  if Style = bcsCheckboxEh then
  begin
    ASize := RectSize(ARect);
    if ASize.cx < ASize.cy then
    begin
      ARect.Top := ARect.Top + (ASize.cy - ASize.cx) div 2;
      ARect.Bottom := ARect.Bottom - (ASize.cy - ASize.cx) div 2 - (ASize.cy - ASize.cx) mod 2;
    end else if ASize.cx > ASize.cy then
    begin
      ARect.Left := ARect.Left + (ASize.cx - ASize.cy) div 2;
      ARect.Right := ARect.Right - (ASize.cx - ASize.cy) div 2 - (ASize.cx - ASize.cy) mod 2;
    end;

    if Flat and not ThemesEnabled then InflateRect(ARect, -1, -1);
    if UseButtonsBitmapCache then
    begin
      BitmapInfo.Size := Point(ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      BitmapInfo.CheckState := State;
      BitmapInfo.Pressed := DownButton <> 0;
      BitmapInfo.Active := Active;
      BitmapInfo.Enabled := Enabled;
      BitmapInfo.DrawBack := DrawButtonBackground;
      Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);

      StretchBlt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left,
        ARect.Bottom - ARect.Top, Bitmap.Canvas.Handle, 0, 0,
        Bitmap.Width, Bitmap.Height, cmSrcCopy);
    end else
      DrawCheckBoxEh(Canvas.Handle, ARect, State, Enabled, Flat, DownButton <> 0, Active);

    if Flat then
    begin
      if not ThemesEnabled then
        InflateRect(ARect, 1, 1);
      if Active and not ThemesEnabled then
        DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
      else
      begin
        Brush := CreateSolidBrush(ColorToRGB(ParentColor));
        FrameRect(Canvas.Handle, ARect, Brush);
        DeleteObject(Brush);
      end;
    end;
  end else
  begin
    BitmapInfo.Active := Active;
    BitmapInfo.Enabled := Enabled;
    BitmapInfo.DrawBack := DrawButtonBackground;

    IsClipRgn := Flat and not Active and not ThemeServices.ThemesEnabled;
    if IsClipRgn then
    begin
      DRect := ARect;
      WindowsLPtoDP(Canvas.Handle, DRect);
      InflateRect(ARect, -1, -1);
      if not UseButtonsBitmapCache then
      begin
        SaveRgn := CreateRectRgn(0, 0, 0, 0);
        r := GetClipRgn(Canvas.Handle, SaveRgn);
         Rgn := CreateRectRgn(DRect.Left + 1, DRect.Top + 1, DRect.Right - 1, DRect.Bottom - 1);
        SelectClipRgn(Canvas.Handle, Rgn);
        DeleteObject(Rgn);
      end;
    end;

    if Style in [bcsUpDownEh, bcsAltUpDownEh] then
    begin
      if IsClipRgn then InflateRect(ARect, 1, 1);
      HalfRect := ARect;
      HalfRect.Bottom := HalfRect.Top + (HalfRect.Bottom - HalfRect.Top) div 2;
      if IsClipRgn then InflateRect(HalfRect, -1, -1);
      if UseButtonsBitmapCache then
      begin
        BitmapInfo.Size := Point(HalfRect.Right - HalfRect.Left, HalfRect.Bottom - HalfRect.Top);
        BitmapInfo.Pressed := DownButton = 1;
        BitmapInfo.DownDirect := False;
        Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
        StretchBlt(Canvas.Handle, HalfRect.Left, HalfRect.Top, HalfRect.Right - HalfRect.Left,
          HalfRect.Bottom - HalfRect.Top, Bitmap.Canvas.Handle, 0, 0,
          Bitmap.Width, Bitmap.Height, cmSrcCopy);
      end else
        DrawOneButton(Canvas, Style, HalfRect, Enabled, Flat, Active, DownButton = 1, False, DrBack);
      if IsClipRgn then InflateRect(HalfRect, 1, 1);
      HalfRect.Bottom := ARect.Bottom;
      HalfRect.Top := HalfRect.Bottom - (HalfRect.Bottom - HalfRect.Top) div 2;
      if IsClipRgn then InflateRect(HalfRect, -1, -1);
      if UseButtonsBitmapCache then
      begin
        BitmapInfo.Size := Point(HalfRect.Right - HalfRect.Left, HalfRect.Bottom - HalfRect.Top);
        BitmapInfo.Pressed := DownButton = 2;
        BitmapInfo.DownDirect := True;
        Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
        StretchBlt(Canvas.Handle, HalfRect.Left, HalfRect.Top, HalfRect.Right - HalfRect.Left,
          HalfRect.Bottom - HalfRect.Top, Bitmap.Canvas.Handle, 0, 0,
          Bitmap.Width, Bitmap.Height, cmSrcCopy);
      end else
        DrawOneButton(Canvas, Style, HalfRect, Enabled, Flat, Active, DownButton = 2, True, DrBack);
      if IsClipRgn
        then InflateRect(ARect, -1, -1);
      if (ParentColor <> clNone) and
         (((ARect.Bottom - ARect.Top) mod 2 = 1) or (IsClipRgn)) then
      begin
        HalfRect := ARect;
        HalfRect.Top := (HalfRect.Bottom + HalfRect.Top) div 2;
        HalfRect.Bottom := HalfRect.Top;
        if (ARect.Bottom - ARect.Top) mod 2 = 1 then Inc(HalfRect.Bottom);
        if IsClipRgn then InflateRect(HalfRect, 0, 1);
        Brush := CreateSolidBrush(ColorToRGB(ParentColor));
        FillRect(Canvas.Handle, HalfRect, Brush);
        DeleteObject(Brush);
      end;
    end else if UseButtonsBitmapCache then
    begin
      BitmapInfo.Size := Point(ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      BitmapInfo.Pressed := DownButton <> 0;
      Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
      StretchBlt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left,
        ARect.Bottom - ARect.Top, Bitmap.Canvas.Handle, 0, 0,
        Bitmap.Width, Bitmap.Height, cmSrcCopy);
    end else
      DrawOneButton(Canvas, Style, ARect, Enabled, Flat, Active, DownButton <> 0, True, DrBack);

    if IsClipRgn then
    begin
      InflateRect(ARect, 1, 1);
      if not UseButtonsBitmapCache then
      begin
        if r = 0
          then SelectClipRgn(Canvas.Handle, 0)
          else SelectClipRgn(Canvas.Handle, SaveRgn);
        DeleteObject(SaveRgn);
      end;
      if (ParentColor <> clNone) then
      begin
        Brush := CreateSolidBrush(ColorToRGB(ParentColor));
        FrameRect(Canvas.Handle, ARect, Brush);
        DeleteObject(Brush);
      end;
    end;
  end;
end;

function GetDefaultFlatButtonWidth: Integer;
{$IFDEF FPC_CROSSP}
var
  VertScrollWidth: Integer;
begin
  VertScrollWidth := GetSystemMetrics(SM_CXVSCROLL) + 1;
  Result := Round(VertScrollWidth / 3 * 2);
  if (Result < 12) then
    Result := 12;
end;
{$ELSE}
var
  VertScrollWidth: Integer;
begin
  VertScrollWidth := GetSystemMetrics(SM_CXVSCROLL) + 1;
  Result := Round(VertScrollWidth / 3 * 2);
end;
//  {$ENDIF} 
{$ENDIF} 

function ClientToScreenRect(Control: TControl): TRect;
begin
  Result.TopLeft := Control.ClientToScreen(Point(0,0));
  Result.Bottom := Result.Top + Control.Height;
  Result.Right := Result.Left + Control.Width;
end;

function DefaultEditButtonHeight(EditButtonWidth: Integer; Flat: Boolean): Integer;
begin
  if Flat
    then Result := Round(EditButtonWidth * 4 / 3)
    else Result := EditButtonWidth;
end;

function VarEquals(const V1, V2: Variant): Boolean;
var
  i: Integer;
begin
  Result := not (VarIsArray(V1) xor VarIsArray(V2));
  if not Result then Exit;
  Result := False;
  try
    if VarIsArray(V1) and VarIsArray(V2) and
      (VarArrayDimCount(V1) = VarArrayDimCount(V2)) and
      (VarArrayLowBound(V1, 1) = VarArrayLowBound(V2, 1)) and
      (VarArrayHighBound(V1, 1) = VarArrayHighBound(V2, 1))
      then
      for i := VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do
      begin
        Result := V1[i] = V2[i];
        if not Result then Exit;
      end
    else
      begin
        Result := not (VarIsEmpty(V1) xor VarIsEmpty(V2));
        if not Result
          then Exit
          else Result := (V1 = V2);
      end;
  except
    Result := False;
  end;
end;

function DBVarCompareOneValue(const A, B: Variant): TVariantRelationship;
begin
  if VarIsNull(A) and VarIsNull(B) then
    Result := vrEqual
  else if VarIsNull(A) then
    Result := vrLessThan
  else if VarIsNull(B) then
    Result := vrGreaterThan
  else Result := VarCompareValue(A, B);
end;

function DBVarCompareValue(const A, B: Variant): TVariantRelationship;
var
  i: Integer;
  IsComparable: Boolean;
begin
  Result := vrNotEqual;
  IsComparable := not (VarIsArray(A) xor VarIsArray(B));
  if not IsComparable then Exit;
  if VarIsArray(A) and VarIsArray(B) and
    (VarArrayDimCount(A) = VarArrayDimCount(B)) and
    (VarArrayLowBound(A, 1) = VarArrayLowBound(B, 1)) and
    (VarArrayHighBound(A, 1) = VarArrayHighBound(B, 1))
    then
    for i := VarArrayLowBound(A, 1) to VarArrayHighBound(A, 1) do
    begin
      Result := DBVarCompareOneValue(A[i], B[i]);
      if Result <> vrEqual then Exit;
    end
  else
    Result := DBVarCompareOneValue(A, B);
end;

function StringListSysSortCompare(List: TStringList; Index1, Index2: Integer): Integer;
var
  s1, s2: String;
begin
  s1 := List[Index1];
  s2 := List[Index2];
  Result := CompareStr(s1, s2);
end;

function VarToStrEh(const V: Variant): String;
begin
  if VarType(V) =  varDate then
    Result := DateTimeToStr(V)
  else
    Result := VarToStr(V);
end;

function AnyVarToStrEh(const V: Variant): String;
var
  i: Integer;
begin
  Result := '';
  if VarIsArray(V) then
  begin
    for i := VarArrayLowBound(V, 1) to VarArrayHighBound(V, 1) do
    begin
      if Result = ''
        then Result := '['+AnyVarToStrEh(V[i])
        else Result := Result + ', ' + AnyVarToStrEh(V[i])
    end;
    Result := Result + ']';
  end else
    Result := VarToStr(V);
end;

function StrictVarToStrEh(const V: Variant): String;
var
  Hour, Min, Sec, MSec: Word;
begin
  if VarType(V) = varDate then
  begin
    DecodeTime(V, Hour, Min, Sec, MSec);
    if MSec <> 0 then
      Result := FormatDateTime(FormatSettings.ShortDateFormat + ' ' +
                     FormatSettings.LongTimeFormat +
                     FormatSettings.DecimalSeparator +
                     'zzz', V)
    else
     Result := VarToStr(V);
  end else
    Result := VarToStr(V);
end;

function TruncDateTimeToSeconds(dt: TDateTime): TDateTime;
var
  AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word;
begin
  DecodeDateTime(dt, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
  Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, 0);
end;

procedure ReplaceTime(var DateTime: TDateTime; const NewTime: TDateTime);
begin
  DateTime := Trunc(DateTime);
  if DateTime >= 0 then
    DateTime := DateTime + Abs(Frac(NewTime))
  else
    DateTime := DateTime - Abs(Frac(NewTime));
end;

function GetRGBColor(Value: TColor): DWORD;
begin
  Result := ColorToRGB(Value);
  case Result of
    clNone: Result := CLR_NONE;
    clDefault: Result := CLR_DEFAULT;
  end;
end;

procedure DrawImage(Canvas: TCanvas; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean); overload;
var
  CheckedRect, AUnionRect: TRect;
  OldRectRgn, RectRgn: HRGN;
  r, x, y: Integer;
  DC: HDC;

  procedure DrawIm;
  {$IFDEF FPC}
  const
    DrawSelStyle: array[Boolean] of TDrawingStyle = (dsNormal, dsSelected);
  begin
    Images.Draw(Canvas, x, y, ImageIndex, DrawSelStyle[Selected], itImage, True);
  end;
  {$ELSE}
  const
    ImageTypes: array[TImageType] of Longint = (0, ILD_MASK);
    ImageSelTypes: array[Boolean] of Longint = (0, ILD_SELECTED);
  var
    ABlendColor: TColor;
  begin
    if Images.HandleAllocated then
    begin
      if Selected
        then ABlendColor := clHighlight
        else ABlendColor := Images.BlendColor;

      {$WARNINGS OFF}
      ImageList_DrawEx(Images.Handle, ImageIndex, DC, x, y, 0, 0,
        GetRGBColor(Images.BkColor), GetRGBColor(ABlendColor),
        ImageTypes[Images.ImageType] or ImageSelTypes[Selected]
        );
      {$WARNINGS ON}
    end;
  end;
  {$ENDIF}

begin
  DC := Canvas.Handle;
  x := (ARect.Right + ARect.Left - Images.Width) div 2;
  y := (ARect.Bottom + ARect.Top - Images.Height) div 2;
  CheckedRect := Rect(X, Y, X + Images.Width, Y + Images.Height);
  UnionRect(AUnionRect, CheckedRect, ARect);
  if EqualRect(AUnionRect, ARect) then 
    DrawIm
  else
  begin 
    OldRectRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(DC, OldRectRgn);
    RectRgn := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    SelectClipRgn(DC, RectRgn);
    DeleteObject(RectRgn);

    DrawIm;

    if r = 0
      then SelectClipRgn(DC, 0)
      else SelectClipRgn(DC, OldRectRgn);
    DeleteObject(OldRectRgn);
  end;
end;

procedure DrawImage(DC: HDC; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean);
{$IFDEF FPC}
begin
end;
{$ELSE}
var
  CheckedRect, AUnionRect: TRect;
  OldRectRgn, RectRgn: HRGN;
  r, x, y: Integer;

  procedure DrawIm;
  const
    ImageTypes: array[TImageType] of Longint = (0, ILD_MASK);
    ImageSelTypes: array[Boolean] of Longint = (0, ILD_SELECTED);
  var
    ABlendColor: TColor;
  begin
    if Images.HandleAllocated then
    begin
      if Selected
        then ABlendColor := clHighlight
        else ABlendColor := Images.BlendColor;

      {$WARNINGS OFF}
      ImageList_DrawEx(Images.Handle, ImageIndex, DC, x, y, 0, 0,
        GetRGBColor(Images.BkColor), GetRGBColor(ABlendColor),
        ImageTypes[Images.ImageType] or ImageSelTypes[Selected]
        );
      {$WARNINGS ON}
    end;
  end;
begin
  x := (ARect.Right + ARect.Left - Images.Width) div 2;
  y := (ARect.Bottom + ARect.Top - Images.Height) div 2;
  CheckedRect := Rect(X, Y, X + Images.Width, Y + Images.Height);
  UnionRect(AUnionRect, CheckedRect, ARect);
  if EqualRect(AUnionRect, ARect) then 
    DrawIm
  else
  begin 
    OldRectRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(DC, OldRectRgn);
    RectRgn := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    SelectClipRgn(DC, RectRgn);
    DeleteObject(RectRgn);

    DrawIm;

    if r = 0
      then SelectClipRgn(DC, 0)
      else SelectClipRgn(DC, OldRectRgn);
    DeleteObject(OldRectRgn);
  end;
end;
{$ENDIF} 

function AlignDropDownWindowRect(MasterAbsRect: TRect; DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
var
  P: TPoint;
  Y: Integer;
  WorkArea: TRect;
  MonInfo: TMonitorInfo;
begin
  DropDownWin.HandleNeeded;
  P := MasterAbsRect.TopLeft;
  Y := P.Y + (MasterAbsRect.Bottom - MasterAbsRect.Top);

  MonInfo.cbSize := SizeOf(MonInfo);
{$IFDEF CIL}
  GetMonitorInfo(MonitorFromRect(MasterAbsRect, MONITOR_DEFAULTTONEAREST), MonInfo);
{$ELSE}
  GetMonitorInfo(MonitorFromRect(@MasterAbsRect, MONITOR_DEFAULTTONEAREST), @MonInfo);
{$ENDIF}
  WorkArea := MonInfo.rcWork;

  {$IFDEF FPC_CROSSP}
  WorkArea := Screen.DesktopRect;
  {$ELSE}
  {$ENDIF}

  if ((Y + DropDownWin.Height > WorkArea.Bottom) and (P.Y - DropDownWin.Height >= WorkArea.Top)) or
    ((P.Y - DropDownWin.Height < WorkArea.Top) and (WorkArea.Bottom - Y < P.Y - WorkArea.Top))
    then
  begin
    if P.Y - DropDownWin.Height < WorkArea.Top then
      DropDownWin.Height := P.Y - WorkArea.Top;
    Y := P.Y - DropDownWin.Height;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToTop), 0);
  end else
  begin
    if Y + DropDownWin.Height > WorkArea.Bottom then
      DropDownWin.Height := WorkArea.Bottom - Y;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToBottom), 0);
  end;

  case Align of
    daRight: Dec(P.X, DropDownWin.Width - (MasterAbsRect.Right - MasterAbsRect.Left));
    daCenter: Dec(P.X, (DropDownWin.Width - (MasterAbsRect.Right - MasterAbsRect.Left)) div 2);
  end;

  if (DropDownWin.Width > WorkArea.Right - WorkArea.Left) then
    DropDownWin.Width := WorkArea.Right - WorkArea.Left;
  if (P.X + DropDownWin.Width > WorkArea.Right) then
  begin
    P.X := WorkArea.Right - DropDownWin.Width;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToLeft), 0);
  end
  else if P.X < WorkArea.Left then
  begin
    P.X := WorkArea.Left;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToRight), 0);
  end else if Align = daRight then
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToLeft), 0)
  else
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToRight), 0);

  Result := Point(P.X, Y);
end;

function AlignDropDownWindow(MasterWin, DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
var
  MasterAbsRect: TRect;
begin
  MasterAbsRect.TopLeft := MasterWin.Parent.ClientToScreen(Point(MasterWin.Left, MasterWin.Top));
  MasterAbsRect.Bottom := MasterAbsRect.Top + MasterWin.Height;
  MasterAbsRect.Right := MasterAbsRect.Left + MasterWin.Width;
  Result := AlignDropDownWindowRect(MasterAbsRect, DropDownWin, Align);
end;

procedure DrawDotLine(Canvas: TCanvas; FromPoint: TPoint; ALength: Integer;
  Along: Boolean; BackDot: Boolean);
var
  Points: TPointArrayEh;
  StrokeList: TDWORDArrayEh;
  DotWidth, DotCount, I: Integer;
begin
  if Along then
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.X);
      Dec(ALength);
    end;
  end else
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.Y);
      Dec(ALength);
    end;
  end;

  DotWidth := Canvas.Pen.Width;
  DotCount := ALength div (2 * DotWidth);
  if DotCount < 0 then Exit;
  if ALength mod 2 <> 0 then
    Inc(DotCount);
  SetLength(Points, DotCount * 2);
  SetLength(StrokeList, DotCount);
  for I := 0 to DotCount - 1 do
    StrokeList[I] := 2;
  if Along then
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X + 1, FromPoint.Y);
      Inc(FromPoint.X, (2 * DotWidth));
    end
  else
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X, FromPoint.Y + 1);
      Inc(FromPoint.Y, (2 * DotWidth));
    end;

  PolyPolyLineEh(Canvas, Points, StrokeList, DotCount);
end;

procedure DrawTreeElement(Canvas: TCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean; Coloured: Boolean; GlyphStyle: TTreeViewGlyphStyleEh);
var
  ABoxRect: TRect;
//  OldBoxRect: TRect;
  ACenter: TPoint;
  Square: TRect;
  X2, X4, Y2, Y4: Integer;
  Details: TThemedElementDetails;
  TreeviewPlus: TThemedTreeview;
  OldBrushColor: TColor;
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  DX: Integer;
  PBoundRect: PRECT;
  Size: TSize;
  {$ENDIF} 
begin
  ACenter.X := (ARect.Right + ARect.Left) div 2;
  ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
  X2 := Trunc(ScaleX*2);
  X4 := Trunc(ScaleX*4);
  Y2 := Trunc(ScaleY*2);
  Y4 := Trunc(ScaleY*4);
  OldBrushColor := clNone;
  Square := ARect;
  if ARect.Bottom - ARect.Top < ARect.Right - ARect.Left then
  begin
    Square.Left := (ARect.Right + ARect.Left) div 2 - (ARect.Bottom - ARect.Top) div 2;
    Square.Right := Square.Left + (ARect.Bottom - ARect.Top);
  end else
  begin
    Square.Top := (ARect.Bottom + ARect.Top) div 2 - (ARect.Right - ARect.Left) div 2;
    Square.Bottom := Square.Top + (ARect.Bottom - ARect.Top);
  end;

  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if Square.Bottom - Square.Top <= 15 then
  begin
    DX := 17 - (Square.Bottom - Square.Top);
    InflateRect(Square, DX, DX);
    PBoundRect := @ARect;
  end else
    PBoundRect := nil;
  {$ENDIF} 

  ABoxRect := Rect(ACenter.X-X4, ACenter.Y-Y4, ACenter.X+X4+1, ACenter.Y+Y4+1);
  if TreeElement in [tehMinusUpDown .. tehPlus] then
  begin
    if Coloured then
    begin
      OldBrushColor := Canvas.Brush.Color;
      Canvas.Brush.Color := StyleServices.GetSystemColor(clWindow);
      Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
      Canvas.Pen.Style := psSolid;
    end;
    if GlyphStyle = tvgsClassicEh then
      if RightToLeft
        then Canvas.Rectangle(ABoxRect.Left-1, ABoxRect.Top, ABoxRect.Right-1, ABoxRect.Bottom)
        else Canvas.Rectangle(ABoxRect.Left, ABoxRect.Top, ABoxRect.Right, ABoxRect.Bottom);
    if Coloured then
      Canvas.Pen.Color := StyleServices.GetSystemColor(clWindowText);
    if (GlyphStyle in [tvgsThemedEh, tvgsExplorerThemedEh]) and ThemeServices.ThemesEnabled then
    begin
{$IFDEF EH_LIB_16}
{        if TStyleManager.IsCustomStyleActive then
      begin
        LStyle := StyleServices;
        if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus]
          then CatBut := tcbCategoryGlyphClosed
          else CatBut := tcbCategoryGlyphOpened;
        Details := LStyle.GetElementDetails(CatBut);
        LStyle.DrawElement(Canvas.Handle, Details, ABoxRect);
      end else}
{$ENDIF}
      begin
        if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlusHLine, tehPlus]
          then TreeviewPlus := ttGlyphClosed
          else TreeviewPlus := ttGlyphOpened;
        Details := ThemeServices.GetElementDetails(TreeviewPlus);
        if GlyphStyle = tvgsExplorerThemedEh then
        begin
          {$IFDEF FPC_CROSSP}
          {$ELSE}
          GetThemePartSize(ExplorerTreeviewTheme, Canvas.Handle,
            Details.Part, Details.State, nil, TS_TRUE, Size);
          Square := Rect(0,0,Size.cx,Size.cy);
          Square := CenteredRect(ARect, Square);
          DrawThemeBackground(ExplorerTreeviewTheme, Canvas.Handle,
            Details.Part, Details.State, Square, PBoundRect);
          {$ENDIF} 
        end else
        begin
        {$IFDEF FPC}
          ThemeServices.DrawElement(Canvas.Handle, Details, Square);
        {$ELSE}
          ThemeServices.DrawElement(Canvas.Handle, Details, ABoxRect);
        {$ENDIF}
        end;
      end;
    end else
    begin
      Canvas.MoveTo(ABoxRect.Left + X2, ACenter.Y);
      Canvas.LineTo(ABoxRect.Right - X2, ACenter.Y);

      if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus, tehPlusHLine] then
      begin
        Canvas.MoveTo(ACenter.X, ABoxRect.Top + Y2);
        Canvas.LineTo(ACenter.X, ABoxRect.Bottom - Y2);
      end;
    end;

    if Coloured then
      Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
    if not (TreeElement in [tehMinus, tehPlus]) then
      DrawDotLine(Canvas, Point(ABoxRect.Right{ + X1}, ACenter.Y),
       (ARect.Right - ABoxRect.Right), True, False);

    if TreeElement in [tehMinusUpDown, tehMinusUp, tehPlusUpDown, tehPlusUp] then
      DrawDotLine(Canvas, Point(ACenter.X, ARect.Top), (ABoxRect.Top - ARect.Top), False, BackDot);

    if TreeElement in [tehMinusUpDown, tehMinusDown, tehPlusUpDown, tehPlusDown] then
      DrawDotLine(Canvas, Point(ACenter.X, ABoxRect.Bottom{ + Y1}),
        (ARect.Bottom - ABoxRect.Bottom), False, BackDot);

    if Coloured then
      Canvas.Brush.Color := OldBrushColor;
  end else
  begin
    if Coloured then
    begin
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
    end;
    if TreeElement in [tehCrossUpDown, tehVLine] then
      DrawDotLine(Canvas, Point(ACenter.X, ARect.Top),
        (ARect.Bottom - ARect.Top), False, BackDot);
    if TreeElement in [tehCrossUpDown, tehCrossUp, tehCrossDown, tehHLine] then
      DrawDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Right - ACenter.X), True, False);
    if TreeElement in [tehCrossDown] then
      DrawDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Bottom - ACenter.Y), False, BackDot);
    if TreeElement in [tehCrossUp] then
      DrawDotLine(Canvas, Point(ACenter.X, ARect.Top), (ACenter.Y - ARect.Top), False, BackDot);
  end;
end;

{ TButtonsBitmapCache }

function TButtonsBitmapCache.GetButtonBitmap(ButtonBitmapInfo: TButtonBitmapInfoEh): TBitmap;
var
  i: Integer;
  BitmapInfoBitmap: TButtonBitmapInfoBitmapEh;
begin
  if ButtonBitmapInfo.Size.X < 0 then ButtonBitmapInfo.Size.X := 0;
  if ButtonBitmapInfo.Size.Y < 0 then ButtonBitmapInfo.Size.Y := 0;
  for i := 0 to Count - 1 do
    if CompareButtonBitmapInfo(ButtonBitmapInfo, Items[i].BitmapInfo) then
    begin
      Result := Items[i].Bitmap;
      Exit;
    end;
  BitmapInfoBitmap := TButtonBitmapInfoBitmapEh.Create;
  Add(BitmapInfoBitmap);
  BitmapInfoBitmap.BitmapInfo := ButtonBitmapInfo;
  BitmapInfoBitmap.Bitmap := TBitmap.Create;
  BitmapInfoBitmap.Bitmap.Width := ButtonBitmapInfo.Size.X;
  BitmapInfoBitmap.Bitmap.Height := ButtonBitmapInfo.Size.Y;

  case ButtonBitmapInfo.BitmapType of
    bcsCheckboxEh:
      DrawCheckBoxEh(BitmapInfoBitmap.Bitmap.Canvas.Handle,
        Rect(0, 0, ButtonBitmapInfo.Size.X, ButtonBitmapInfo.Size.Y),
        ButtonBitmapInfo.CheckState,
        ButtonBitmapInfo.Enabled,
        ButtonBitmapInfo.Flat,
        ButtonBitmapInfo.Pressed,
        ButtonBitmapInfo.Active
        );
    bcsEllipsisEh, bcsUpDownEh, bcsDropDownEh, bcsPlusEh, bcsMinusEh,
    bcsAltDropDownEh, bcsAltUpDownEh:
      DrawOneButton(BitmapInfoBitmap.Bitmap.Canvas, ButtonBitmapInfo.BitmapType,
        Rect(0, 0, ButtonBitmapInfo.Size.X, ButtonBitmapInfo.Size.Y),
        ButtonBitmapInfo.Enabled, ButtonBitmapInfo.Flat,
        ButtonBitmapInfo.Active, ButtonBitmapInfo.Pressed,
        ButtonBitmapInfo.DownDirect, ButtonBitmapInfo.DrawBack);
  end;
  Result := BitmapInfoBitmap.Bitmap;
end;

function TButtonsBitmapCache.Get(Index: Integer): TButtonBitmapInfoBitmapEh;
begin
  Result := TButtonBitmapInfoBitmapEh(inherited Items[Index]);
end;

procedure TButtonsBitmapCache.Clear;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    FreeObjectEh(Items[i].Bitmap);
    FreeObjectEh(Items[i]);
  end;
  inherited Clear;
end;

constructor TButtonsBitmapCache.Create;
begin
  inherited Create;
  OwnsObjects := False;
end;

{ TEditButtonControlEh }

constructor TEditButtonControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInternalEditButtonImages := TButtonImagesEh.Create;
  ParentColor := True;
  FAdvancedPaint := True;
end;

destructor TEditButtonControlEh.Destroy;
begin
  FreeAndNil(FInternalEditButtonImages);
  inherited Destroy;
end;

procedure TEditButtonControlEh.EditButtonDown(ButtonNum: Integer; var AutoRepeat: Boolean);
var
  Handled: Boolean;
begin
  if Assigned(FOnDown) {and (FButtonNum > 0)} then
    FOnDown(Self, ButtonNum = 1, AutoRepeat, Handled);
end;

procedure TEditButtonControlEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var AutoRepeat: Boolean;
begin
  if Style in [ebsUpDownEh, ebsAltUpDownEh]
    then AutoRepeat := True
    else AutoRepeat := False;
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) then
  begin
    UpdateDownButtonNum(X, Y);
    begin
      EditButtonDown(FButtonNum, AutoRepeat);
      if AutoRepeat then ResetTimer(InitRepeatPause);
    end;
  end;
end;

procedure TEditButtonControlEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture and (FStyle in [ebsUpDownEh, ebsAltUpDownEh]) and (FState = bsPressedEh) then
  begin
    if ((FButtonNum = 2) and (Y < (Height div 2))) or
      ((FButtonNum = 1) and (Y > (Height - Height div 2))) then
    begin
      FState := bsNormalEh;
      Invalidate;
    end;
  end;
end;

procedure TEditButtonControlEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (FStyle in [ebsUpDownEh, ebsAltUpDownEh]) and (State <> bsPressedEh) then
    FNoDoClick := True;
  try
    inherited MouseUp(Button, Shift, X, Y);
  finally
    FNoDoClick := False;
  end;
  UpdateDownButtonNum(X, Y);
  if (FTimer <> nil) and FTimer.Enabled then
    FTimer.Enabled := False;
end;

procedure TEditButtonControlEh.UpdateDownButtonNum(X, Y: Integer);
var OldButtonNum: Integer;
begin
  OldButtonNum := FButtonNum;
  if State in [bsPressedEh] then
    if FStyle in [ebsUpDownEh, ebsAltUpDownEh] then
    begin
      if Y < (Height div 2) then
        FButtonNum := 1
      else if Y > (Height - Height div 2) then
        FButtonNum := 2
      else
        FButtonNum := 0;
    end
    else FButtonNum := 1
  else
    FButtonNum := 0;
  if FButtonNum <> OldButtonNum then
    Invalidate;
end;

function TEditButtonControlEh.DrawActiveState: Boolean;
begin
  if ThemesEnabled
    then Result := MouseInControl
    else Result := FActive;
end;

procedure TEditButtonControlEh.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TButtonStateEh; BiDiFlags: LongInt);
var
  TextSize: TPoint;
  TextRect: TRect;
begin
  TextRect := TextBounds;
  DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextRect,
    DT_CALCRECT or BiDiFlags);
  TextSize := Point(TextRect.Right - TextRect.Left, TextRect.Bottom - TextRect.Top);
  TextBounds.Top := (TextBounds.Top + TextBounds.Bottom - TextSize.Y + 1) div 2;
  TextBounds.Bottom := TextBounds.Top + TextSize.Y;
  Canvas.Brush.Style := bsClear;
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
  {$ENDIF}
  Canvas.Font := Self.Font;
  if State = bsDisabledEh then
  begin
    OffsetRect(TextBounds, 1, 1);
    Canvas.Font.Color := StyleServices.GetSystemColor(clBtnHighlight);
    DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextBounds,
      DT_CENTER or DT_VCENTER or BiDiFlags);
    OffsetRect(TextBounds, -1, -1);
    Canvas.Font.Color := StyleServices.GetSystemColor(clBtnShadow);
    DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextBounds,
      DT_CENTER or DT_VCENTER or BiDiFlags);
  end else
    DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextBounds,
      DT_CENTER or DT_VCENTER or BiDiFlags);
end;

{$IFDEF FPC}
{$ELSE}
type
  TSpeedButtonCrack = class(TGraphicControl)
  protected
    FGroupIndex: Integer;
    FGlyph: TObject;
    FDown: Boolean;
    FDragging: Boolean;
    FAllowAllUp: Boolean;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FTransparent: Boolean;
    FMargin: Integer;
    FFlat: Boolean;
    FMouseInControl: Boolean;
  end;
{$ENDIF}

procedure TEditButtonControlEh.Paint;
begin
  if Assigned(OnPaint)
    then OnPaint(Self)
    else DefaultPaint;
end;

procedure TEditButtonControlEh.DefaultPaint;
const
  StyleFlags: array[TEditButtonStyleEh] of TDrawButtonControlStyleEh =
  (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh, bcsUpDownEh, bcsPlusEh, bcsMinusEh,
   bcsAltDropDownEh, bcsAltUpDownEh);
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var Rgn, SaveRgn: HRgn;
  r: Integer;
  BRect: TRect;
  IsClipRgn: Boolean;
  AButtonNum: Integer;
  AActive: Boolean;
  Offset: TPoint;
  Details: TThemedElementDetails;
  DrawBtBack: Boolean;
begin
  AButtonNum := FButtonNum;
  AActive := DrawActiveState;
  IsClipRgn := False;
  SaveRgn := 0;
  r := 0;
  DrawBtBack := (DrawBackTime = edbtAlwaysEh) or
                ((DrawBackTime = edbtWhenHotEh) and
                 ((MouseInControl = True) or (State in [bsPressedEh]))
                );
  if not DrawBtBack and(Style = ebsGlyphEh) and not Glyph.Empty then
    DrawBtBack := True;
  if not (FState in [bsPressedEh]) then
    AButtonNum := 0;

  if not (Style = ebsGlyphEh) then
  begin
    Canvas.Brush.Color := StyleServices.GetSystemColor(Color);
    Canvas.FillRect(Rect(0, 0, Width, Height));
    PaintButtonControlEh(Canvas, Rect(0, 0, Width, Height),
      clWindow,
      StyleFlags[Style], AButtonNum,
      Flat, AActive, Enabled, cbUnchecked, 1, DrawBtBack);
  end else
  begin
    if not ThemeServices.ThemesEnabled then
    begin
      IsClipRgn := Flat;
      BRect := BoundsRect;
      r := 0;
      SaveRgn := 0;
      if IsClipRgn then
      begin
        SaveRgn := CreateRectRgn(0, 0, 0, 0);
        r := GetClipRgn(Canvas.Handle, SaveRgn);
        Rgn := CreateRectRgn(BRect.Left + 1, BRect.Top + 1, BRect.Right - 1, BRect.Bottom - 1);
        SelectClipRgn(Canvas.Handle, Rgn);
        DeleteObject(Rgn);
      end;
    end;

//    if not DrawBtBack or
//       (ThemeServices.ThemesEnabled and
//        Flat and
//        not AActive and
//        Enabled and
//        not Down and
//        Glyph.Empty and
//        AdvancedPaint) then
    begin
      PerformEraseBackground(Self, Canvas.Handle);
      if DrawBtBack then
      begin
        PaintEditButtonBackgroundEh(Canvas, ClientRect,
          clNone, Enabled, AActive, Flat, AButtonNum > 0);
      end;

      if (ButtonImages <> nil) and
         (ButtonImages.NormalImages <> nil) then
      begin
        DrawImages(Rect(0, 0, Width, Height));
      end
      else if Glyph <> nil then
      begin
         Offset := Point(0, 0);
         Details := ThemeServices.GetElementDetails(tbPushButtonNormal);
         PaintForeground(ClientRect, Offset, Details);
      end
      else if Caption <> '' then
      begin
        {$IFDEF FPC}
        DrawButtonText(Canvas, Caption, ClientRect, FState, DrawTextBiDiModeFlags(Self, 0));
        {$ELSE}
        DrawButtonText(Canvas, Caption, ClientRect, FState, DrawTextBiDiModeFlags(0));
        {$ENDIF}
      end;
    end;

    if not ThemeServices.ThemesEnabled then
    begin
      if IsClipRgn then
      begin
        if r = 0 then
          SelectClipRgn(Canvas.Handle, 0)
        else
          SelectClipRgn(Canvas.Handle, SaveRgn);
        DeleteObject(SaveRgn);
        OffsetRect(BRect, -Left, -Top);
        if AActive then
          DrawEdge(Canvas.Handle, BRect, DownStyles[FState in [bsPressedEh]], BF_RECT)
        else
        begin
{$IFDEF CIL}
          Canvas.Brush.Color := Color;
{$ELSE}
          Canvas.Brush.Color := TWinControlCracker(Parent).Color;
{$ENDIF}
          Canvas.FrameRect(BRect);
        end;
      end;
    end;

  end;
end;

procedure TEditButtonControlEh.SetState(NewState: TButtonStateEh; IsActive: Boolean; ButtonNum: Integer);
begin
  if (FState <> NewState) or (IsActive <> FActive) or (ButtonNum <> FButtonNum) then
  begin
    FActive := IsActive;
    FState := NewState;
    FButtonNum := ButtonNum;
    Repaint;
  end;
end;

procedure TEditButtonControlEh.SetStyle(const Value: TEditButtonStyleEh);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TEditButtonControlEh.SetWidthNoNotify(AWidth: Integer);
begin
  inherited Width := AWidth;
end;

procedure TEditButtonControlEh.SetActive(const Value: Boolean);
begin
  if Active <> Value then
  begin
    FActive := Value;
    Invalidate;
  end;
end;

procedure TEditButtonControlEh.Click;
begin
  if not FNoDoClick then
  begin
    inherited Click;
  end;
end;

function TEditButtonControlEh.GetTimer: TTimer;
begin
  if FTimer = nil then
  begin
    FTimer := TTimer.Create(Self);
    FTimer.Enabled := False;
    FTimer.OnTimer := TimerEvent;
  end;
  Result := FTimer;
end;

procedure TEditButtonControlEh.ResetTimer(Interval: Cardinal);
begin
  if Timer.Enabled = False then
  begin
    Timer.Interval := Interval;
    Timer.Enabled := True;
  end
  else if Interval <> Timer.Interval then
  begin
    Timer.Enabled := False;
    Timer.Interval := Interval;
    Timer.Enabled := True;
  end;
end;

procedure TEditButtonControlEh.TimerEvent(Sender: TObject);
var
  AutoRepeat: Boolean;
begin
  if Style in [ebsUpDownEh, ebsAltUpDownEh]
    then AutoRepeat := True
    else AutoRepeat := False;
  if not (State = bsPressedEh) then Exit;
  if Timer.Interval = Cardinal(InitRepeatPause) then
    ResetTimer(RepeatPause);
  if State = bsPressedEh then
    EditButtonDown(FButtonNum, AutoRepeat);
  if not AutoRepeat then Timer.Enabled := False;
end;

procedure TEditButtonControlEh.SetAlwaysDown(const Value: Boolean);
begin
  if FAlwaysDown <> Value then
  begin
    FAlwaysDown := Value;
    if Value then
    begin
      FButtonNum := 1;
    end else
    begin
      FButtonNum := 0;
    end;
  end;
end;

procedure TEditButtonControlEh.SetDrawBackTime(
  const Value: TEditButtonDrawBackTimeEh);
begin
  if FDrawBackTime <> Value then
  begin
    FDrawBackTime := Value;
    Invalidate;
  end;
end;

procedure TEditButtonControlEh.DrawImages(ARect: TRect);
var
  ADrawImages: TCustomImageList;
  AImageIndex: Integer;
  ADrawRect: TRect;
begin
  ADrawImages := ButtonImages.GetStateImages(State);
  AImageIndex := ButtonImages.GetStateIndex(State);
  if (ADrawImages <> nil) and (AImageIndex >= 0) then
  begin
    ADrawRect := Rect(0, 0, ADrawImages.Width, ADrawImages.Height);
    ADrawRect := CenteredRect(ARect, ADrawRect);
    if FButtonNum > 0 then
      OffsetRect(ADrawRect, 1, 1);
    ADrawImages.Draw(Canvas, ADrawRect.Left, ADrawRect.Top, AImageIndex, Enabled);
  end;
end;

{$IFDEF EH_LIB_26} //10.3
{$ELSE}
function TEditButtonControlEh.GetSystemMetrics(nIndex: Integer): Integer;
begin
  {$IFDEF FPC}
  Result := LCLIntf.GetSystemMetrics(nIndex);
  {$ELSE}
  Result := Windows.GetSystemMetrics(nIndex);
  {$ENDIF}
end;
{$ENDIF}

function TEditButtonControlEh.GetButtonImages: TButtonImagesEh;
begin
  if FExternalEditButtonImages <> nil then
    Result := FExternalEditButtonImages
  else
    Result := FInternalEditButtonImages;
end;

procedure TEditButtonControlEh.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseInControl := True;
  Invalidate;
end;

procedure TEditButtonControlEh.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseInControl := False;
  Invalidate;
end;

{ TEditButtonEh }

constructor TEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(nil);
  FEditControl := EditControl;
  FEnabled := True;
  FGlyph := TBitmap.Create;
  FGlyph.Transparent := True;
  FShortCut := scNone; 
  FNumGlyphs := 1;
  FImages := TEditButtonImagesEh.Create(Self);
  FDropDownFormParams := CreateDropDownFormParams;
  FDrawBackTime := edbtAlwaysEh;
end;

constructor TEditButtonEh.Create(Collection: TCollection);
begin
  if Assigned(Collection) then Collection.BeginUpdate;
  try
    inherited Create(Collection);
    FEditControl := nil;
    FEnabled := True;
    FGlyph := TBitmap.Create;
    FGlyph.Transparent := True;
    FShortCut := scNone; 
    FNumGlyphs := 1;
    FImages := TEditButtonImagesEh.Create(Self);
    FDropDownFormParams := CreateDropDownFormParams;
    FDrawBackTime := edbtAlwaysEh;
  finally
    if Assigned(Collection) then Collection.EndUpdate;
  end;
end;

destructor TEditButtonEh.Destroy;
begin
  FreeAndNil(FActionLink);
  FreeAndNil(FGlyph);
  FreeAndNil(FImages);
  FreeAndNil(FDropDownFormParams);
  inherited Destroy;
end;

procedure TEditButtonEh.Assign(Source: TPersistent);
begin
  if Source is TEditButtonEh then
  begin
    Action :=  TEditButtonEh(Source).Action;
    DropdownMenu := TEditButtonEh(Source).DropdownMenu;
    Enabled :=  TEditButtonEh(Source).Enabled;
    Glyph := TEditButtonEh(Source).Glyph;
    Hint := TEditButtonEh(Source).Hint;
    NumGlyphs := TEditButtonEh(Source).NumGlyphs;
    ShortCut := TEditButtonEh(Source).ShortCut;
    Style := TEditButtonEh(Source).Style;
    Visible := TEditButtonEh(Source).Visible;
    Width := TEditButtonEh(Source).Width;
    OnClick := TEditButtonEh(Source).OnClick;
    OnDown := TEditButtonEh(Source).OnDown;
    Images := TEditButtonEh(Source).Images;
  end else
    inherited Assign(Source);
end;

function TEditButtonEh.GetGlyph: TBitmap;
begin
  Result := FGlyph;
end;

procedure TEditButtonEh.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Changed;
end;

procedure TEditButtonEh.SetNumGlyphs(Value: Integer);
begin
  if Value <= 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetOnButtonClick(const Value: TButtonClickEventEh);
begin
  if @FOnButtonClick <> @Value then
  begin
    FOnButtonClick := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetOnButtonDown(const Value: TEditButtonDownEventEh);
begin
  if @FOnButtonDown <> @Value then
  begin
    FOnButtonDown := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetStyle(const Value: TEditButtonStyleEh);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

function TEditButtonEh.GetVisible: Boolean;
begin
  Result := FVisible;
end;

procedure TEditButtonEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

function TEditButtonEh.CreateEditButtonControl: TEditButtonControlEh;
begin
  Result := TEditButtonControlEh.Create(FEditControl);
  Result.ControlStyle := Result.ControlStyle + [csReplicatable];
  Result.Width := 10;
  Result.Height := 17;
  Result.Visible := True;
  Result.Transparent := False;
  Result.Parent := FEditControl;
end;

procedure TEditButtonEh.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self)
  else if Assigned(Collection) then
    Changed(False)
end;

procedure TEditButtonEh.RefComponentChanged(RefComponent: TComponent);
begin
  if Assigned(FOnRefComponentChanged) then
    FOnRefComponentChanged(Self, RefComponent)
  else if Assigned(Collection) and Assigned(TEditButtonsEh(Collection).FOnRefComponentChanged) then
    TEditButtonsEh(Collection).OnRefComponentChanged(Self, RefComponent);
end;

procedure TEditButtonEh.SetHint(const Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.Click(Sender: TObject; var Handled: Boolean);
begin
  if Assigned(OnClick) then
    OnClick(Sender, Handled)
  else if (ActionLink <> nil) then
  begin
    if (FEditControl <> nil) then
      ActionLink.Execute(FEditControl)
    else if Collection.Owner is TComponent then
      ActionLink.Execute(Collection.Owner as TComponent)
    else
      ActionLink.Execute(nil);
    Handled := True;
  end;
end;

procedure TEditButtonEh.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if FActionLink = nil then
      FActionLink := GetActionLinkClass.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
  end;
end;

function TEditButtonEh.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action else
    Result := nil
end;

function TEditButtonEh.GetActionLinkClass: TEditButtonActionLinkEhClass;
begin
  Result := TEditButtonActionLinkEh;
end;

procedure TEditButtonEh.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

procedure TEditButtonEh.ActionChange(Sender: TObject; CheckDefaults: Boolean);
var
  ca: TCustomAction;
begin
  if Sender is TCustomAction then
  begin
    ca := TCustomAction(Sender);
    if not CheckDefaults or (Self.Enabled = True) then
      Self.Enabled := ca.Enabled;
    if not CheckDefaults or (Self.Hint = '') then
      Self.Hint := ca.Hint;
    if not CheckDefaults or (Self.ShortCut = scNone) then
      Self.ShortCut := ca.ShortCut;
    if not CheckDefaults or (Self.Visible = True) then
      Self.Visible := ca.Visible;
  end;
end;

procedure TEditButtonEh.InitiateAction;
begin
  if FActionLink <> nil then FActionLink.Update;
end;

function TEditButtonEh.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TEditButtonEh.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TEditButtonEh.IsShortCutStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsShortCutLinked;
end;

function TEditButtonEh.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

procedure TEditButtonEh.SetImages(const Value: TEditButtonImagesEh);
begin
  FImages.Assign(Value);
end;

procedure TEditButtonEh.SetDropDownFormParams(const Value: TDropDownFormCallParamsEh);
begin
  FDropDownFormParams.Assign(Value);
end;

procedure TEditButtonEh.SetDropdownMenu(const Value: TPopupMenu);
begin
  if FDropdownMenu <> Value then
  begin
    FDropdownMenu := Value;
    Changed;
  end;
end;

function TEditButtonEh.GetDefaultAction: Boolean;
begin
  if FDefaultActionStored
    then Result := FDefaultAction
    else Result := FParentDefinedDefaultAction;
end;

procedure TEditButtonEh.SetDefaultAction(const Value: Boolean);
begin
  FDefaultAction := Value;
  FDefaultActionStored := True;
end;

function TEditButtonEh.IsDefaultActionStored: Boolean;
begin
  Result := FDefaultActionStored;
end;

function TEditButtonEh.GetDrawBackTime: TEditButtonDrawBackTimeEh;
begin
  if IsDrawBackTimeStored
    then Result := FDrawBackTime
    else Result := DefaultDrawBackTime;
end;

procedure TEditButtonEh.SetDrawBackTime(const Value: TEditButtonDrawBackTimeEh);
begin
  if IsDrawBackTimeStored and (Value = FDrawBackTime) then Exit;
  FDrawBackTime := Value;
  FDrawBackTimeStored := True;
  Changed;
end;

function TEditButtonEh.IsDrawBackTimeStored: Boolean;
begin
  Result := FDrawBackTimeStored;
end;

function TEditButtonEh.DefaultDrawBackTime: TEditButtonDrawBackTimeEh;
begin
  if Collection <> nil
    then Result := TEditButtonsEh(Collection).DefaultDrawBackTime
    else Result := edbtAlwaysEh;
end;

procedure TEditButtonEh.SetDrawBackTimeStored(const Value: Boolean);
begin
  if (Value = True) and (IsDrawBackTimeStored = False) then
  begin
    FDrawBackTimeStored := True;
    FDrawBackTime := DefaultDrawBackTime;
    Changed;
  end else if (Value = False) and (IsDrawBackTimeStored = True) then
  begin
    FDrawBackTimeStored := False;
    Changed;
  end;
end;

{$IFDEF FPC}
function TEditButtonEh.QueryInterface(constref IID: TGUID; out Obj): HResult;
{$ELSE}
function TEditButtonEh.QueryInterface(const IID: TGUID; out Obj): HResult;
{$ENDIF}
begin
  if GetInterface(IID, Obj)
    then Result := 0
    else Result := E_NOINTERFACE;
end;

function TEditButtonEh._AddRef: Integer;
begin
  Result := -1;
end;

function TEditButtonEh._Release: Integer;
begin
  Result := -1;
end;

function TEditButtonEh.CreateDropDownFormParams: TDropDownFormCallParamsEh;
begin
  Result := TDropDownFormCallParamsEh.Create;
end;

{ TEditButtonsEh }

function TEditButtonsEh.Add: TEditButtonEh;
begin
  Result := TEditButtonEh(inherited Add);
end;

constructor TEditButtonsEh.Create(Owner: TPersistent; EditButtonClass: TEditButtonEhClass);
begin
  inherited Create(EditButtonClass);
  FOwner := Owner;
end;

function TEditButtonsEh.GetEditButton(Index: Integer): TEditButtonEh;
begin
  Result := TEditButtonEh(inherited Items[Index]);
end;

function TEditButtonsEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TEditButtonsEh.SetEditButton(Index: Integer; Value: TEditButtonEh);
begin
  inherited Items[Index] := Value;
end;

procedure TEditButtonsEh.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Assigned(FOnChanged) then FOnChanged(Item);
end;

function TEditButtonsEh.DefaultDrawBackTime: TEditButtonDrawBackTimeEh;
var
  EditButtonsOwner: IEditButtonsOwnerEh;
begin
  if Supports(Owner, IEditButtonsOwnerEh, EditButtonsOwner)
    then Result := EditButtonsOwner.DefaultEditButtonDrawBackTime
    else Result := edbtAlwaysEh;
end;

{ TDropDownEditButtonEh }

constructor TDropDownEditButtonEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); 
end;

constructor TDropDownEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(EditControl);
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); 
end;

{ TVisibleEditButtonEh }

constructor TVisibleEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(EditControl);
  Visible := True;
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); 
end;

constructor TVisibleEditButtonEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Visible := True;
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); 
end;

{ TSpecRowEh }

constructor TSpecRowEh.Create(Owner: TPersistent);
begin
  inherited Create;
  FOwner := Owner;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FCellsStrings := TStringList.Create;
  FValue := Null;
  FShowIfNotInKeyList := True;
  FShortCut := Menus.ShortCut(VK_DELETE, [ssAlt]); 
end;

destructor TSpecRowEh.Destroy;
begin
  FreeAndNil(FCellsStrings);
  FreeAndNil(FFont);
  inherited Destroy;
end;

function TSpecRowEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TSpecRowEh.Changed;
begin
  if (FUpdateCount = 0) and Assigned(FOnChanged) then
    OnChanged(Self);
end;

procedure SetCellsStrings(Strings: TStrings; const Value: String);
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
const
  Delimiter = ';';
  QuoteChar = '"';
{$IFDEF CIL}
var
  P, P1, L: Integer;
  S: string;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    P := 1;
    L := Length(Value);
    while (P <= L) and (Value[P] in [#1..' ']) do
      Inc(P);
    while P <= L do
    begin
      if Value[P] = QuoteChar then
        S := DequotedStr(Value, QuoteChar, P)
      else
      begin
        P1 := P;
        while (P <= L) and (Value[P] > ' ') and (Value[P] <> Delimiter) do
          Inc(P);
        S := Copy(Value, P1, P - P1);
      end;
      Strings.Add(S);
      while (P <= L) and (Value[P] in [#1..' ']) do
        Inc(P);
      if (P <= L) and (Value[P] = Delimiter) then
      begin
        P1 := P;
        Inc(P1);
        if P1 > L then
          Strings.Add('');
        repeat
          Inc(P);
        until (P > L) or (not (Value[P] in [#1..' ']));
      end;
    end;
  finally
    Strings.EndUpdate;
  end;
end;

{$ELSE}
var
  P, P1: PChar;
  S: string;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    P := PChar(Value);
    while CharInSetEh(P^, [#1..' ']) do P := CharNext(P);
    while P^ <> #0 do
    begin
      if P^ = QuoteChar then
        S := AnsiExtractQuotedStr(P, QuoteChar)
      else
      begin
        P1 := P;
        while (P^ >= ' ') and (P^ <> Delimiter) do P := CharNext(P);
        SetString(S, P1, P - P1);
      end;
      Strings.Add(S);
      while CharInSetEh(P^, [#1..#31]) do P := CharNext(P);
      if P^ = Delimiter then
        repeat
          P := CharNext(P);
        until not CharInSetEh(P^, [#1..#31]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;
{$ENDIF}
{$ENDIF} 

procedure TSpecRowEh.SetCellsText(const Value: String);
begin
  if FCellsText <> Value then
  begin
    FCellsText := Value;
    SetCellsStrings(FCellsStrings, Value);
    Changed;
  end;
end;

procedure TSpecRowEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FColorAssigned := True;
    Changed;
  end;
end;

procedure TSpecRowEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TSpecRowEh.SetValue(const Value: Variant);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.FontChanged(Sender: TObject);
begin
  Changed;
  FFontAssigned := True;
end;

procedure TSpecRowEh.SetShowIfNotInKeyList(const Value: Boolean);
begin
  if FShowIfNotInKeyList <> Value then
  begin
    FShowIfNotInKeyList := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.Assign(Source: TPersistent);
begin
  if Source is TSpecRowEh then
  begin
    BeginUpdate;
    try
      CellsText := TSpecRowEh(Source).CellsText;
      Color := TSpecRowEh(Source).Color;
      if TSpecRowEh(Source).FFontAssigned then
        Font := TSpecRowEh(Source).Font;
      ShortCut := TSpecRowEh(Source).ShortCut;
      ShowIfNotInKeyList := TSpecRowEh(Source).ShowIfNotInKeyList;
      Value := TSpecRowEh(Source).Value;
      Visible := TSpecRowEh(Source).Visible;
    finally
      EndUpdate;
    end;
  end else
    inherited Assign(Source);
end;

function TSpecRowEh.GetFont: TFont;
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

function TSpecRowEh.GetColor: TColor;
begin
  if not FColorAssigned
    then Result := DefaultColor
    else Result := FColor;
end;

function TSpecRowEh.DefaultFont: TFont;
begin
  if Assigned(FOwner) and (FOwner is TControl)
{$IFDEF CIL}
    then Result := IControl(FOwner).GetFont
{$ELSE}
    then Result := TControlCracker(FOwner).Font
{$ENDIF}
    else Result := FFont;
end;

function TSpecRowEh.DefaultColor: TColor;
begin
  if Assigned(FOwner) and (FOwner is TCustomControl)
{$IFDEF CIL}
    then Result := TCustomControl(FOwner).Color
{$ELSE}
    then Result := TControlCracker(FOwner).Color
{$ENDIF}
    else Result := FColor;
end;

function TSpecRowEh.GetCellText(Index: Integer): String;
begin
  if (Index < 0) or (Index >= FCellsStrings.Count)
    then Result := ''
    else Result := FCellsStrings[Index];
end;

function TSpecRowEh.IsValueStored: Boolean;
begin
  Result := not VarEquals(FValue, Null);
end;

function TSpecRowEh.IsFontStored: Boolean;
begin
  Result := FFontAssigned;
end;

function TSpecRowEh.IsColorStored: Boolean;
begin
  Result := FColorAssigned;
end;

function TSpecRowEh.LocateKey(KeyValue: Variant): Boolean;
begin
  Result := Visible and VarEquals(Value, KeyValue);
end;

procedure TSpecRowEh.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TSpecRowEh.EndUpdate;
begin
  Dec(FUpdateCount);
  Changed;
end;

procedure GetFieldsProperty(List: TObjectList; DataSet: TDataSet;
  Control: TComponent; const FieldNames: String);
var
  Pos: Integer;
  Field: TField;
  FieldName: String;
begin
  Pos := 1;
  while Pos <= Length(FieldNames) do
  begin
    FieldName := ExtractFieldName(FieldNames, Pos);
    Field := DataSet.FindField(FieldName);
    if Field = nil then
      DatabaseErrorFmt(SFieldNotFound, [FieldName], Control);
    if Assigned(List) then List.Add(Field);
  end;
end;

function GetFieldsProperty(DataSet: TDataSet; Control: TComponent;
  const FieldNames: String): TFieldsArrEh;
var
  FieldList: TObjectListEh;
  i: Integer;
begin
  FieldList := TObjectListEh.Create;
  try
    GetFieldsProperty(FieldList, DataSet, Control, FieldNames);
    Result := nil;
    SetLength(Result, FieldList.Count);
    for i := 0 to FieldList.Count - 1 do
      Result[i] := TField(FieldList[i]);
  finally
    FieldList.Free;
  end;
end;

procedure DataSetSetFieldValues(DataSet: TDataSet; const Fields: String; Value: Variant);
var
  FieldList: TFieldListEh;
  i: Integer;
begin
  if VarEquals(Value, Null) then
  begin
    FieldList := TFieldListEh.Create;
    try
      Dataset.GetFieldList(FieldList, Fields);
      for i := 0 to FieldList.Count - 1 do
        TField(FieldList[i]).Clear;
    finally
      FieldList.Free;
    end;
  end else
    DataSet.FieldValues[Fields] := Value;
end;

procedure DataSetGetFieldValues(DataSet: TDataSet; FKeyFields: TFieldsArrEh; out Value: Variant);
var
  i: Integer;
begin
  if Length(FKeyFields) > 1 then
  begin
    Value := VarArrayCreate([0, Length(FKeyFields) - 1], varVariant);
    for i := 0 to Length(FKeyFields) - 1 do
      Value[i] := FKeyFields[i].Value;
  end else
    Value := FKeyFields[0].Value;
end;

{ TSizeGripEh }

constructor TSizeGripEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csParentBackground, csCaptureMouse];
  Width := GetSystemMetrics(SM_CXVSCROLL);
  Height := GetSystemMetrics(SM_CYVSCROLL);
  Color := clBtnFace;
  Cursor := crSizeNWSE;
  FTriangleWindow := True;
  FPosition := sgpBottomRight;
end;

procedure TSizeGripEh.CreateHandle;
begin
  if HostControl <> nil then
    ParentWindow := HostControl.Handle;
  inherited CreateHandle;
end;

procedure TSizeGripEh.CreateWnd;
begin
  inherited CreateWnd;
  UpdateWindowRegion;
end;

procedure TSizeGripEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FInitScreenMousePos := ClientToScreen(Point(X, Y));
  FParentRect.Right := HostControl.Width;
  FParentRect.Bottom := HostControl.Height;
  FParentRect.Left := HostControl.ClientWidth;
  FParentRect.Top := HostControl.ClientHeight;
end;

procedure TSizeGripEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewMousePos, ParentWidthHeight: TPoint;
  OldPos, NewClientAmount, OutDelta: Integer;
  WorkArea: TRect;
  MonInfo: TMonitorInfo;
  MasterAbsRect: TRect;
begin
  inherited MouseMove(Shift, X, Y);

  if (ssLeft in Shift) and MouseCapture and not FInternalMove then
  begin
    NewMousePos := ClientToScreen(Point(X, Y));
    ParentWidthHeight.x := HostControl.ClientWidth;
    ParentWidthHeight.y := HostControl.ClientHeight;

    if (FOldMouseMovePos.x = NewMousePos.x) and
      (FOldMouseMovePos.y = NewMousePos.y) then
      Exit;

    MasterAbsRect.TopLeft := HostControl.ClientToScreen(Point(0, 0));
    MasterAbsRect.Bottom := MasterAbsRect.Top + HostControl.Height;
    MasterAbsRect.Right := MasterAbsRect.Left + HostControl.Width;
    MonInfo.cbSize := SizeOf(MonInfo);
{$IFDEF CIL}
    GetMonitorInfo(MonitorFromRect(MasterAbsRect, MONITOR_DEFAULTTONEAREST), MonInfo);
{$ELSE}
    GetMonitorInfo(MonitorFromRect(@MasterAbsRect, MONITOR_DEFAULTTONEAREST), @MonInfo);
{$ENDIF}
    WorkArea := MonInfo.rcWork;

    if Position in [sgpBottomRight, sgpTopRight] then
    begin
      NewClientAmount := FParentRect.Left + NewMousePos.x - FInitScreenMousePos.x;
      OutDelta := HostControl.Width + NewClientAmount - HostControl.ClientWidth;
      OutDelta := HostControl.ClientToScreen(Point(OutDelta, 0)).x - WorkArea.Right;
      if OutDelta <= 0
        then HostControl.ClientWidth := NewClientAmount
        else HostControl.ClientWidth := NewClientAmount - OutDelta
    end else
    begin
      OldPos := HostControl.Width;

      NewClientAmount := FParentRect.Right + FInitScreenMousePos.x - NewMousePos.x;
      OutDelta := NewClientAmount - HostControl.Width;
      OutDelta := HostControl.ClientToScreen(Point(0, 0)).x - WorkArea.Left - OutDelta;
      if OutDelta >= 0
        then HostControl.Width := NewClientAmount
        else HostControl.Width := NewClientAmount + OutDelta;
      HostControl.Left := HostControl.Left + OldPos - HostControl.Width;
    end;

    if Position in [sgpBottomRight, sgpBottomLeft] then
    begin
      NewClientAmount := FParentRect.Top + NewMousePos.y - FInitScreenMousePos.y;
      OutDelta := HostControl.Height + NewClientAmount - HostControl.ClientHeight;
      OutDelta := HostControl.ClientToScreen(Point(0, OutDelta)).y - WorkArea.Bottom;
      if OutDelta <= 0
        then HostControl.ClientHeight := NewClientAmount
        else HostControl.ClientHeight := NewClientAmount - OutDelta;
    end else
    begin
      OldPos := HostControl.Height;
      NewClientAmount := FParentRect.Bottom + FInitScreenMousePos.y - NewMousePos.y;
      OutDelta := NewClientAmount - HostControl.Height;
      OutDelta := HostControl.ClientToScreen(Point(0, 0)).y - WorkArea.Top - OutDelta;
      if OutDelta >= 0
        then HostControl.Height := NewClientAmount
        else HostControl.Height := NewClientAmount + OutDelta;
      HostControl.Top := HostControl.Top + OldPos - HostControl.Height;
    end;

    FOldMouseMovePos := NewMousePos;
    if (ParentWidthHeight.x <> HostControl.ClientWidth) or
      (ParentWidthHeight.y <> HostControl.ClientHeight) then
      ParentResized;
    UpdatePosition;
  end;
end;

procedure TSizeGripEh.Paint;
{$IFDEF EH_LIB_16}
const  PositionElementDetailsArr: array [TSizeGripPosition] of TThemedScrollBar =
  (tsSizeBoxTopLeftAlign, tsSizeBoxTopRightAlign, tsSizeBoxRightAlign, tsSizeBoxLeftAlign);
{$ENDIF}
var
  i, xi, yi: Integer;
  XArray: array of Integer;
  YArray: array of Integer;
  xIdx, yIdx: Integer;
  BtnHighlightColor, BtnShadowColor, BtnFaceColor: TColor;
{$IFDEF EH_LIB_16}
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
{$ENDIF}
{$IFDEF EH_LIB_16}
  ElementDetails: TThemedElementDetails;
{$ENDIF}
begin

{$IFDEF EH_LIB_16}
  if ThemeServices.ThemesEnabled and not CustomStyleActive then
  begin
    ElementDetails := ThemeServices.GetElementDetails(PositionElementDetailsArr[Position]);
    ThemeServices.DrawElement(Canvas.Handle, ElementDetails, Rect(0,0,Width,Height));
    Exit;
  end;
{$ENDIF}

  i := 1;
  SetLength(XArray, 2);
  SetLength(YArray, 2);
  if Position = sgpBottomRight then
  begin
    xi := 1; yi := 1;
    xIdx := 0; yIdx := 1;
    XArray[0] := 0; YArray[0] := Width;
    XArray[1] := Width; YArray[1] := 0;
  end else if Position = sgpBottomLeft then
  begin
    xi := -1; yi := 1;
    xIdx := 1; yIdx := 0;
    XArray[0] := 0; YArray[0] := 1;
    XArray[1] := Width - 1; YArray[1] := Width;
  end else if Position = sgpTopLeft then
  begin
    xi := -1; yi := -1;
    xIdx := 0; yIdx := 1;
    XArray[0] := Width - 1; YArray[0] := -1;
    XArray[1] := -1; YArray[1] := Width - 1;
  end else 
  begin
    xi := 1; yi := -1;
    xIdx := 1; yIdx := 0;
    XArray[0] := Width; YArray[0] := Width - 1;
    XArray[1] := 0; YArray[1] := -1;
  end;

  BtnHighlightColor := clBtnHighlight;
  BtnShadowColor := clBtnShadow;
  BtnFaceColor := clBtnFace;
{$IFDEF EH_LIB_16}
  if TStyleManager.IsCustomStyleActive then
  begin
    LStyle := StyleServices;
    if LStyle.Enabled then
    begin
      LDetails := LStyle.GetElementDetails(tpPanelBackground);
      if LStyle.GetElementColor(LDetails, ecFillColor, LColor) and (LColor <> clNone) then
        BtnFaceColor := LColor;
      LDetails := LStyle.GetElementDetails(tpPanelBevel);
      if LStyle.GetElementColor(LDetails, ecEdgeHighLightColor, LColor) and (LColor <> clNone) then
        BtnHighlightColor := LColor;
      if LStyle.GetElementColor(LDetails, ecEdgeShadowColor, LColor) and (LColor <> clNone) then
        BtnShadowColor := LColor;
    end;
  end;
{$ENDIF}

  while i < Width do
  begin
    Canvas.Pen.Color := BtnHighlightColor;
    Canvas.PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
    Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[YIdx], yi);

    Canvas.Pen.Color := BtnShadowColor;
    Canvas.PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
    Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);
    Canvas.PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
    Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);

    Canvas.Pen.Color := BtnFaceColor;
    Canvas.PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
    Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);
  end;
end;

procedure TSizeGripEh.ParentResized;
begin
  if Assigned(FParentResized) then FParentResized(Self);
end;

procedure TSizeGripEh.SetPosition(const Value: TSizeGripPosition);
begin
  if FPosition = Value then Exit;
  FPosition := Value;
  if HandleAllocated then
  begin
    RecreateWndHandle;
    HandleNeeded;
  end;
end;

procedure TSizeGripEh.SetTriangleWindow(const Value: Boolean);
begin
  if FTriangleWindow = Value then Exit;
  FTriangleWindow := Value;
  UpdateWindowRegion;
end;

procedure TSizeGripEh.UpdatePosition;
var
  HostCliRect: TRect;
begin
  if not HandleAllocated then Exit;
  FInternalMove := True;
  HostCliRect := GetAdjustedClientRect(HostControl);
  case Position of
    sgpBottomRight: SetBounds(HostCliRect.Right - Width, HostCliRect.Bottom - Height, Width, Height);
    sgpBottomLeft: SetBounds(HostCliRect.Left, HostCliRect.Bottom - Height, Width, Height);
    sgpTopLeft: SetBounds(HostCliRect.Left, HostCliRect.Top, Width, Height);
    sgpTopRight: SetBounds(HostCliRect.Right - Width, HostCliRect.Top, Width, Height);
  end;
  FInternalMove := False;
end;

procedure TSizeGripEh.ChangePosition(NewPosition: TSizeGripChangePosition);
begin
  if NewPosition = sgcpToLeft then
  begin
    if Position = sgpTopRight then Position := sgpTopLeft
    else if Position = sgpBottomRight then Position := sgpBottomLeft;
  end else if NewPosition = sgcpToRight then
  begin
    if Position = sgpTopLeft then Position := sgpTopRight
    else if Position = sgpBottomLeft then Position := sgpBottomRight
  end else if NewPosition = sgcpToTop then
  begin
    if Position = sgpBottomRight then Position := sgpTopRight
    else if Position = sgpBottomLeft then Position := sgpTopLeft
  end else if NewPosition = sgcpToBottom then
  begin
    if Position = sgpTopRight then Position := sgpBottomRight
    else if Position = sgpTopLeft then Position := sgpBottomLeft
  end
end;

function TSizeGripEh.GetVisible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TSizeGripEh.SetVisible(const Value: Boolean);
begin
  if HandleAllocated then
  begin
    if Value then
      ShowWindow(Handle, SW_SHOW)
    else
      ShowWindow(Handle, SW_HIDE);
  end else
    inherited Visible := Value;
end;

procedure TSizeGripEh.UpdateWindowRegion;
const
  PositionArr: array[TSizeGripPosition] of TCursor = (crSizeNWSE, crSizeNESW, crSizeNWSE, crSizeNESW);
var
  Points: array[0..2] of TPoint;
  Region: HRgn;
begin
  if not HandleAllocated then Exit;
  if TriangleWindow then
  begin
    if Position = sgpBottomRight then
    begin
      Points[0] := Point(0, Height);
      Points[1] := Point(Width, Height);
      Points[2] := Point(Width, 0);
    end else if Position = sgpBottomLeft then
    begin
      Points[0] := Point(Width, Height);
      Points[1] := Point(0, Height);
      Points[2] := Point(0, 0);
    end else if Position = sgpTopLeft then
    begin
      Points[0] := Point(Width - 1, 0);
      Points[1] := Point(0, 0);
      Points[2] := Point(0, Height - 1);
    end else if Position = sgpTopRight then
    begin
      Points[0] := Point(Width, Height - 1);
      Points[1] := Point(Width, 0);
      Points[2] := Point(1, 0);
    end;
    Region := WindowsCreatePolygonRgn(Points, 3, WINDING);
    SetWindowRgn(Handle, Region, True);
    UpdatePosition;
  end else
  begin
    SetWindowRgn(Handle, 0, True);
    UpdatePosition;
  end;
  Cursor := PositionArr[Position];
end;

function TSizeGripEh.GetHostControl: TWinControl;
begin
  if FHostControl <> nil
    then Result := FHostControl
    else Result := Parent;
end;

procedure TSizeGripEh.SetHostControl(const Value: TWinControl);
begin
  FHostControl := Value;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
{ TPopupMonthCalendarEh }

constructor TPopupMonthCalendarEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; 
  AutoSize := True;
  {$IFDEF FPC}
  {$ELSE}
  Ctl3D := True;
  ParentCtl3D := False;
  {$ENDIF}
  Visible := False;
  ParentWindow := GetDesktopWindow;
end;

procedure TPopupMonthCalendarEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF FPC}
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  {$ELSE}
  Params.Style := Params.Style or WS_POPUP;
  if not Ctl3D then Params.Style := Params.Style or WS_BORDER;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW {or WS_EX_TOPMOST};
  {$ENDIF}

  Params.WindowClass.Style := CS_SAVEBITS;
  if CheckWin32Version(5, 1) then
    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
end;

procedure TPopupMonthCalendarEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  ComboEdit: IComboEditEh;
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_RETURN, VK_ESCAPE] then
  begin
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(Key = VK_RETURN);
    Key := 0;
  end;
end;

procedure TPopupMonthCalendarEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ComboEdit: IComboEditEh;
const
    MCM_GETCURRENTVIEW  = MCM_FIRST + 22;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(False);
  FDownViewType := SendMessage(Handle, MCM_GETCURRENTVIEW, 0, 0);
end;

procedure TPopupMonthCalendarEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
{$IFDEF FPC}
  MCHInfo: TDummyStruct16;
{$ELSE}
  MCHInfo: TMCHitTestInfo;
{$ENDIF}
ComboEdit: IComboEditEh;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if not Supports(Owner, IComboEditEh, ComboEdit) then Exit;
  if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then Exit;

{$IFDEF EH_LIB_16}
  if ThemesEnabled
    then MCHInfo.cbSize := SizeOf(TMCHitTestInfo)
    else MCHInfo.cbSize := System.SizeOf(MCHITTESTINFO) - (System.SizeOf(TRect) + System.SizeOf(Integer) * 3);
{$ELSE}
  {$IFDEF FPC}
  MCHInfo.cbSize := SizeOf(TDummyStruct16);
  {$ELSE}
  MCHInfo.cbSize := SizeOf(TMCHitTestInfo);
  {$ENDIF}
{$ENDIF}

  MCHInfo.pt.x := X;
  MCHInfo.pt.y := Y;
  {$IFDEF FPC}
  MonthCal_HitTest(Handle, @MCHInfo);
  {$ELSE}
  MonthCal_HitTest(Handle, MCHInfo);
  {$ENDIF}
  if ((MCHInfo.uHit and MCHT_CALENDARDATE) > 0) and (MCHInfo.uHit <> MCHT_CALENDARDAY) and
    (MCHInfo.uHit <> MCHT_TITLEBTNNEXT) and (MCHInfo.uHit <> MCHT_TITLEBTNPREV) then
  begin
    if FDownViewType = 0 then
      ComboEdit.CloseUp(True);
  end else if (MCHInfo.uHit = 0) then
    ComboEdit.CloseUp(False)
  else if not ((X >= 0) and (Y >= 0) and (X < Width) and (Y < Height)) then
    ComboEdit.CloseUp(False);
end;

procedure TPopupMonthCalendarEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
var
  ComboEdit: IComboEditEh;
begin
  if not Supports(Owner, IComboEditEh, ComboEdit) then Exit;
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) then
  begin
    ComboEdit.CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TPopupMonthCalendarEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
end;

procedure TPopupMonthCalendarEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if (GetParent(Message.FocusedWnd) <> Handle) then
    PostCloseUp(False);
end;

procedure TPopupMonthCalendarEh.PostCloseUp(Accept: Boolean);
begin
  PostMessage(Handle, CM_CLOSEUPEH, WPARAM(Accept), 0);
end;

procedure TPopupMonthCalendarEh.CMCloseUpEh(var Message: TMessage);
var
  ComboEdit: IComboEditEh;
begin
  if Supports(Owner, IComboEditEh, ComboEdit) then
    ComboEdit.CloseUp(False);
end;

function TPopupMonthCalendarEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    {$IFDEF FPC}
    {$ELSE}
    Date := Date + 1;
    {$ENDIF}
    Result := True;
  end;
end;

function TPopupMonthCalendarEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    {$IFDEF FPC}
    {$ELSE}
    Date := Date - 1;
    {$ENDIF}
    Result := True;
  end;
end;

procedure TPopupMonthCalendarEh.WMNCCalcSize(var Message: TWMNCCalcSize);
{$IFDEF CIL}
var
  r: TNCCalcSizeParams;
begin
  inherited;
  r := Message.CalcSize_Params;
  InflateRect(r.rgrc0, -FBorderWidth, -FBorderWidth);
  Message.CalcSize_Params := r;
end;
{$ELSE}
var
  psp: Windows.PNCCalcSizeParams;
begin
  inherited;
  psp := Message.CalcSize_Params;
  InflateRect(psp.rgrc[0], -FBorderWidth, -FBorderWidth);
end;
{$ENDIF}

procedure TPopupMonthCalendarEh.UpdateBorderWidth;
begin
  {$IFDEF FPC}
  FBorderWidth := 2
  {$ELSE}
  if Ctl3D
      then FBorderWidth := 2
      else FBorderWidth := 0;
  {$ENDIF}
end;

procedure TPopupMonthCalendarEh.UpdateSize;
begin
end;

procedure TPopupMonthCalendarEh.DrawBorder;
var
  DC: HDC;
  R: TRect;
begin
  {$IFDEF FPC}
  {$ELSE}
  if Ctl3D = True then
  {$ENDIF}
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
      InflateRect(R, -1, -1);
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TPopupMonthCalendarEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

{$IFDEF FPC}
{$ELSE}
procedure TPopupMonthCalendarEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWnd;
end;
{$ENDIF}

procedure TPopupMonthCalendarEh.CreateWnd;
var
  R: TRect;
begin
  inherited CreateWnd;
  MonthCal_GetMinReqRect(Handle, R);
  Width := R.Right - R.Left + FBorderWidth * 2;
  Height := R.Bottom - R.Top + FBorderWidth * 2;
end;

function TPopupMonthCalendarEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  if Result then
  begin
    Inc(NewWidth, FBorderWidth * 2);
    Inc(NewHeight, FBorderWidth * 2);
  end;
end;

{$IFDEF FPC}
{$ELSE}
function TPopupMonthCalendarEh.MsgSetDateTime(Value: TSystemTime): Boolean;
begin
  inherited MsgSetDateTime(Value);
  Result := True;
end;
{$ENDIF}

function TPopupMonthCalendarEh.GetDate: TDateTime;
var
  ASysDate: TSystemTime;
begin
  if HandleAllocated and
    {$IFDEF FPC}
    MonthCal_GetCurSel(Handle, @ASysDate)
    {$ELSE}
    MonthCal_GetCurSel(Handle, ASysDate)
    {$ENDIF}
  then
  begin
    ASysDate.wHour := 0;
    ASysDate.wMinute := 0;
    ASysDate.wSecond := 0;
    ASysDate.wMilliseconds := 0;
    Result := SystemTimeToDateTime(ASysDate)
  end else
  {$IFDEF FPC}
    Result := inherited DateTime;
  {$ELSE}
    Result := inherited Date;
  {$ENDIF}
  ReplaceTime(Result, FTime);
end;

procedure TPopupMonthCalendarEh.SetDate(const Value: TDateTime);
begin
  {$IFDEF FPC}
  inherited DateTime := Value;
  {$ELSE}
  inherited Date := Value;
  {$ENDIF}
  FTime := Value;
end;

procedure TPopupMonthCalendarEh.SetFontOptions(Font: TFont;
  FontAutoSelect: Boolean);
begin
  if (FontAutoSelect = False) and (Font <> nil) then
  begin
    Self.Font := Font;
  end else
  begin
  end;
end;

procedure TPopupMonthCalendarEh.ShowPicker(DateTime: TDateTime; Pos: TPoint;
  CloseCallback: TCloseWinCallbackProcEh);
begin
  {$IFDEF FPC}
  Self.DateTime := DateTime;
  {$ELSE}
  Self.Date := DateTime;
  {$ENDIF}
  SetBounds(Pos.X, Pos.Y, Width, Height);
  SetWindowPos(Handle, HWND_TOPMOST, Pos.X, Pos.Y, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  Visible := True;
end;

procedure TPopupMonthCalendarEh.HidePicker;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

function TPopupMonthCalendarEh.GetDateTime: TDateTime;
begin
  {$IFDEF FPC}
  Result := Self.DateTime;
  {$ELSE}
  Result := Self.Date;
  {$ENDIF}
end;

function TPopupMonthCalendarEh.WantKeyDown(Key: Word;
  Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TPopupMonthCalendarEh.WantFocus: Boolean;
begin
  Result := False;
end;

function TPopupMonthCalendarEh.GetTimeUnits: TCalendarDateTimeUnitsEh;
begin
  Result := [cdtuYearEh, cdtuMonthEh, cdtuDayEh];
end;

procedure TPopupMonthCalendarEh.SetTimeUnits(
  const Value: TCalendarDateTimeUnitsEh);
begin

end;
{$ENDIF} 

{ TMRUListEh }

constructor TMRUListEh.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FItems := TStringList.Create;
  FAutogenItems := TStringList.Create;
  FLimit := 100;
  FRows := 7;
  FAutoAdd :=  True;
  FCancelIfKeyInQueue := True;
end;

destructor TMRUListEh.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FAutogenItems);
  inherited Destroy;
end;

procedure TMRUListEh.DropDown;
begin
  if Assigned(OnSetDropDown) then
    OnSetDropDown(Self);
end;

procedure TMRUListEh.CloseUp(Accept: Boolean);
begin
  if Assigned(OnSetCloseUp) then
    OnSetCloseUp(Self, Accept);
end;

procedure TMRUListEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if Assigned(FOnActiveChanged) then
      OnActiveChanged(Self);
  end;
end;

function TMRUListEh.GetItems: TStrings;
begin
  Result := FItems;
end;

procedure TMRUListEh.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TMRUListEh.SetLimit(const Value: Integer);
begin
  if FLimit <> Value then
  begin
    FLimit := Value;
    UpdateLimit;
  end;
end;

procedure TMRUListEh.UpdateLimit;
begin
  while Items.Count > FLimit do
    Items.Delete(0);
end;

procedure TMRUListEh.SetRows(const Value: Integer);
begin
  FRows := Value;
end;

procedure TMRUListEh.Assign(Source: TPersistent);
begin
  if Source is TMRUListEh then
  begin
    Active := TMRUListEh(Source).Active;
    Items := TMRUListEh(Source).Items;
    Limit := TMRUListEh(Source).Limit;
    Rows := TMRUListEh(Source).Rows;
    CaseSensitive := TMRUListEh(Source).CaseSensitive;
  end else
    inherited Assign(Source);
end;

procedure TMRUListEh.Add(const s: String);
var
  i: Integer;
begin
  if Trim(s) = '' then Exit;
  for i := 0 to Items.Count-1 do
    if (CaseSensitive and (s = Items[i])) or
       (not CaseSensitive and (AnsiCompareText(s, Items[i]) = 0)) then
    begin
      Items.Move(i, Items.Count-1);
      Exit;
    end;
  Items.Add(s);
  UpdateLimit;
end;

function TMRUListEh.FilterItemsTo(FilteredItems: TStrings; const MaskText: String): Boolean;
var
  i: Integer;
  Accept: Boolean;
  CharMsg: TMsg;
begin
  Result := True;
  FilteredItems.BeginUpdate;
  try
    FilteredItems.Clear;
    for i := 0 to ActiveItems.Count-1 do
    begin
      Accept := False;
      if CaseSensitive
        then Accept := (AnsiCompareStr(Copy(ActiveItems[i], 1, Length(MaskText)), MaskText) = 0)
        else Accept := (AnsiCompareText(Copy(ActiveItems[i], 1, Length(MaskText)), MaskText) = 0);
      if Assigned(OnFilterItem) then
        OnFilterItem(Self, Accept);
      if Accept then
        FilteredItems.Add(ActiveItems[i]);
      if (i mod 100 = 0) and CancelIfKeyInQueue then
        if PeekMessage(CharMsg, 0, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
        begin
          Result := False;
          Exit;
        end;
    end;
  finally
    FilteredItems.EndUpdate;
  end;
end;

function TMRUListEh.GetActiveItems: TStrings;
begin
  if ListSourceKind = lskMRUListItemsEh
    then Result := Items
    else Result := FAutogenItems;
end;

procedure TMRUListEh.PrepareActiveItems;
begin
  if ListSourceKind = lskDataSetFieldValuesEh then
  begin
    if Assigned(OnFillAutogenItems) then
      OnFillAutogenItems(Self, FAutogenItems);
  end;
end;

{ TDataLinkEh }

procedure TDataLinkEh.DataEvent(Event: TDataEvent; Info: TDataEventInfoTypeEh);
begin
  inherited DataEvent(Event, Info);
  if Assigned(OnDataEvent) then
    OnDataEvent(Event, Info);
end;

{ TDatasetFieldValueListEh }

constructor TDatasetFieldValueListEh.Create;
begin
  inherited Create;
  FValues := TStringList.Create;
  FValues.Sorted := True;
  FValues.Duplicates := dupIgnore;
  FDataSource := TDataSource.Create(nil);
  FDataLink := TDataLinkEh.Create;
  FDataLink.OnDataEvent := DataSetEvent;
end;

destructor TDatasetFieldValueListEh.Destroy;
begin
  FreeAndNil(FValues);
  FDataSource.DataSet := nil;
  FreeAndNil(FDataSource);
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

function TDatasetFieldValueListEh.GetValues: TStrings;
begin
  if FDataObsoleted then
    RefreshValues;
  Result := FValues;
end;

procedure TDatasetFieldValueListEh.SetFieldName(const Value: String);
begin
  if FFieldName <> Value then
  begin
    FDataObsoleted := True;
    FFieldName := Value;
  end;
end;

procedure TDatasetFieldValueListEh.SetDataSet(const Value: TDataSet);
begin
  DataSource := nil;
  FDataLink.DataSource := FDataSource;
  if FDataLink.DataSet <> Value then
  begin
    FDataObsoleted := True;
    FDataSource.DataSet := Value;
  end;
end;

function TDatasetFieldValueListEh.GetDataSet: TDataSet;
begin
  Result := FDataSource.DataSet;
end;

procedure TDatasetFieldValueListEh.SetDataSource(const Value: TDataSource);
begin
  if FDataLink.DataSource <> Value then
  begin
    FDataObsoleted := True;
    FDataLink.DataSource := Value;
  end;
end;

function TDatasetFieldValueListEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDatasetFieldValueListEh.RefreshValues;
var
  Field: TField;
  ABookmark: TUniBookmarkEh;
begin
  FValues.Clear;
  if not FDataLink.Active or (FDataLink.DataSet.FindField(FieldName) = nil) then
    Exit;
  Field := FDataLink.DataSet.FindField(FieldName);
  FDataLink.DataSet.DisableControls;
  try
    ABookmark := FDataLink.DataSet.Bookmark;
    FDataLink.DataSet.First;
    while not FDataLink.DataSet.Eof do
    begin
      FValues.Add(Field.AsString);
      FDataLink.DataSet.Next;
    end;
  finally
    FDataLink.DataSet.Bookmark := ABookmark;
    FDataLink.DataSet.EnableControls;
  end;
  FDataObsoleted := False;
end;

{$IFDEF CIL}
procedure TDatasetFieldValueListEh.DataSetEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
procedure TDatasetFieldValueListEh.DataSetEvent(Event: TDataEvent; Info: Integer);
{$ENDIF}
begin
  if Event in [deDataSetChange, dePropertyChange, deFieldListChange] then
    FDataObsoleted := True;
end;

procedure TDatasetFieldValueListEh.SetFilter(const Filter: String);
begin

end;

function TDatasetFieldValueListEh.GetCaseSensitive: Boolean;
begin
  Result := FValues.CaseSensitive;
end;

procedure TDatasetFieldValueListEh.SetCaseSensitive(const Value: Boolean);
begin
  FValues.CaseSensitive := Value;
end;

{ TBMListEh }

constructor TBMListEh.Create;
begin
  inherited Create;
{$IFDEF TBookMarkAsTBytes}
  SetLength(FList, 0);
{$ELSE}
  FList := TStringList.Create;
  FList.OnChange := ListChangedEventHandler;
{$ENDIF}
end;

destructor TBMListEh.Destroy;
begin
  Clear;
  UpdateState;
{$IFDEF EH_LIB_12}
{$ELSE}
  FreeAndNil(FList);
{$ENDIF}
  inherited Destroy;
end;

procedure TBMListEh.Delete;
var
  I: Integer;
begin
  Dataset.DisableControls;
  try
{$IFDEF TBookMarkAsTBytes}
    for I := Length(FList) - 1 downto 0 do
{$ELSE}
    for I := FList.Count - 1 downto 0 do
{$ENDIF}
    begin
      Dataset.Bookmark := FList[I];
      Dataset.Delete;
      DeleteItem(I);
    end;
  finally
    Dataset.EnableControls;
  end;
  UpdateState;
end;

function TBMListEh.IndexOf(const Item: TUniBookmarkEh): Integer;
begin
  if not Find(Item, Result) then
    Result := -1;
end;

function TBMListEh.GetCount: Integer;
begin
{$IFDEF TBookMarkAsTBytes}
  Result := Length(FList);
{$ELSE}
  Result := FList.Count;
{$ENDIF}
end;

function TBMListEh.GetCurrentRowSelected: Boolean;
var
  Index: Integer;
begin
  if Count = 0
    then Result := False
    else Result := Find(CurrentRow, Index);
end;

function TBMListEh.GetItem(Index: Integer): TUniBookmarkEh;
begin
  Result := FList[Index];
end;

procedure TBMListEh.SetItem(Index: Integer; Item: TUniBookmarkEh);
begin
  FList[Index] := Item;
end;

function TBMListEh.Refresh(DeleteInvalid: Boolean): Boolean;
var
  I: Integer;
  BeginUpdated: Boolean;
begin
  Result := False;
  BeginUpdated := False;
  try
    Dataset.CheckBrowseMode;
    if GetCount > 0 then
    begin
{$IFDEF TBookMarkAsTBytes}
{$ELSE}
      FList.BeginUpdate;
{$ENDIF}
      BeginUpdated := True;
    end;
    if DeleteInvalid then
    begin
      for I := GetCount - 1 downto 0 do
        if not DatasetBookmarkValid(Dataset, FList[I]) then
        begin
          Result := True;
          DeleteItem(I);
        end;
    end;
    Resort;
  finally
    UpdateState;
    Dataset.UpdateCursorPos;
    if BeginUpdated then
{$IFDEF TBookMarkAsTBytes}
      if Result then
        ListChanged();
{$ELSE}
      FList.EndUpdate;
{$ENDIF}
    if Result then Invalidate;
  end;
end;

procedure TBMListEh.SelectAll;
var
  bm: TUniBookmarkEh;
begin
  if not FLinkActive then Exit;
  Dataset.DisableControls;
  BeginUpdate;
  try
    bm := Dataset.Bookmark;
    Dataset.First;
    while Dataset.EOF = False do
    begin
      SetCurrentRowSelected(True);
      Dataset.Next;
    end;
    Dataset.Bookmark := bm;
  finally
    Dataset.EnableControls;
    EndUpdate;
  end;
end;

procedure TBMListEh.BeginUpdate;
begin
  FUpdateCount := FUpdateCount + 1;
end;

procedure TBMListEh.EndUpdate;
begin
  FUpdateCount := FUpdateCount - 1;
  if FUpdateCount = 0 then
    ListChanged();
end;

function TBMListEh.Updating: Boolean;
begin
  Result := (FUpdateCount > 0);
end;

procedure TBMListEh.ListChanged();
begin
  FCache := NilBookmarkEh;
  FCacheIndex := -1;
end;

procedure TBMListEh.ListChangedEventHandler(Sender: TObject);
begin
  ListChanged();
end;

procedure TBMListEh.SetCurrentRowSelected(Value: Boolean);
var
  Index: Integer;
  Current: TUniBookmarkEh;
begin
  Current := CurrentRow;
  if Find(Current, Index) = Value then
    Exit;
  if Value
    then InsertItem(Index, Current)
    else DeleteItem(Index);
end;

function TBMListEh.CurrentRow: TUniBookmarkEh;
begin
  {$IFDEF FPC}
  if not FLinkActive then RaiseBMListError(SInactiveDataset);
  {$ELSE}
  if not FLinkActive then RaiseBMListError(sDataSetClosed);
  {$ENDIF}
  Result := Dataset.Bookmark;
end;

function TBMListEh.Compare(const Item1, Item2: TUniBookmarkEh): Integer;
begin
  Result := DataSetCompareBookmarks(Dataset, Item1, Item2);
end;

procedure TBMListEh.Clear;
var
  i: Integer;
begin
{$IFDEF TBookMarkAsTBytes}
  if Length(FList) = 0 then Exit;
{$ELSE}
  if FList.Count = 0 then Exit;
{$ENDIF}
  BeginUpdate;
  try
    for i := Count-1 downto 0 do
      DeleteItem(i);
  finally
    EndUpdate;
  end;

  ListChanged();
  Invalidate;
end;

function CompareBookmarkStr(List: TBMListEh; ADataSet: TDataSet; Index1, Index2: Integer): Integer;
begin
  Result := DataSetCompareBookmarks(ADataSet, List[Index1], List[Index2]);
end;

procedure TBMListEh.Resort;
begin
  CustomSort(DataSet, CompareBookmarkStr);
end;

procedure TBMListEh.CustomSort(DataSet: TDataSet; Compare: TBMListSortCompare);
begin
  if (Count > 1) then
    QuickSort(DataSet, 0, Count - 1, Compare);
end;

procedure TBMListEh.QuickSort(DataSet: TDataSet; L, R: Integer; SCompare: TBMListSortCompare);
var
  I, J, P: Integer;
  T: TUniBookmarkEh;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, DataSet, I, P) < 0 do Inc(I);
      while SCompare(Self, DataSet, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
          T := FList[I];
          FList[I] := FList[J];
          FList[J] := T;
        end;
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(DataSet, L, J, SCompare);
    L := I;
  until I >= R;
end;

function TBMListEh.Find(const Item: TUniBookmarkEh; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if (Compare(Item, FCache) = 0) and (FCacheIndex >= 0) then
  begin
    Index := FCacheIndex;
    Result := FCacheFind;
    Exit;
  end;
  Result := False;
  L := 0;
  H := GetCount - 1;
  if H >= 0 then
  begin
    if Compare(FList[L], Item) > 0 then
      L := 0
    else if Compare(FList[H], Item) < 0 then
      L := H + 1
    else
    begin
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Compare(FList[I], Item);
        if C < 0 then L := I + 1 else
        begin
          H := I - 1;
          if C = 0 then
          begin
            Result := True;
            L := I;
          end;
        end;
      end;
    end;
  end;
  Index := L;
  FCache := Item;
  FCacheIndex := Index;
  FCacheFind := Result;
end;

procedure TBMListEh.RaiseBMListError(const S: string);
begin
  raise Exception.Create(S);
end;

procedure TBMListEh.LinkActive(Value: Boolean);
begin
  Clear;
  UpdateState;
  FLinkActive := Value;
end;

procedure TBMListEh.UpdateState;
begin
end;

procedure TBMListEh.Invalidate;
begin
end;

function TBMListEh.IsLinkActive: Boolean;
begin
  Result := FLinkActive;
end;

function TBMListEh.GetDataSet: TDataSet;
begin
  Result := nil;
end;

procedure TBMListEh.DeleteItem(Index: Integer);
{$IFDEF TBookMarkAsTBytes}
begin
  if (Index < 0) or (Index >= Count) then
  {$IFDEF FPC}
    raise EListError.CreateFmt('SListIndexError', [Index]);
  {$ELSE}
    raise EListError.CreateFmt(SListIndexError, [Index]);
  {$ENDIF}
  FList[Index] := nil;
  if Index < Count-1 then
  begin
    System.Move(FList[Index + 1], FList[Index],
      (Count - Index - 1) * SizeOf(Pointer));
    PPointer(@FList[Count-1])^ := nil;
  end;
  SetLength(FList, Count-1);
  if not Updating then
    ListChanged();
end;
{$ELSE}
begin
  FList.Delete(Index);
end;
{$ENDIF}

procedure TBMListEh.InsertItem(Index: Integer; Item: TUniBookmarkEh);
{$IFDEF TBookMarkAsTBytes}
begin
  if (Index < 0) or (Index > Count) then
  {$IFDEF FPC}
    raise EListError.Create('SListIndexError');
  {$ELSE}
    raise EListError.Create(SListIndexError);
  {$ENDIF}
  SetLength(FList, Count + 1);
  if Index < Count - 1 then
  begin
    Move(FList[Index], FList[Index + 1],
      (Count - Index - 1) * SizeOf(Pointer));
    PPointer(@FList[Index])^ := nil;
  end;
  FList[Index] := Item;
  if not Updating then
    ListChanged();
end;
{$ELSE}
begin
  FList.Insert(Index, Item)
end;
{$ENDIF}

procedure TBMListEh.AppendBookmark(Item: TUniBookmarkEh);
var
  Index: Integer;
begin
  if Find(Item, Index) = True then
    Exit;
  InsertItem(Index, Item);
end;

function TBMListEh.DeleteBookmark(Item: TUniBookmarkEh): Boolean;
var
  Index: Integer;
begin
  if Find(Item, Index) = True then
  begin
    DeleteItem(Index);
    Result := True;
  end else
    Result := False;
end;

procedure TBMListEh.AppendItem(Item: TUniBookmarkEh);
{$IFDEF TBookMarkAsTBytes}
begin
  InsertItem(GetCount, Item);
end;
{$ELSE}
begin
  FList.Add(Item)
end;
{$ENDIF}

{ TEditButtonActionLinkEh }

procedure TEditButtonActionLinkEh.AssignClient(AClient: TObject);
begin
  FClient := AClient as TEditButtonEh;
end;

function TEditButtonActionLinkEh.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TEditButtonActionLinkEh.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TEditButtonActionLinkEh.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = (Action as TCustomAction).ShortCut);
end;

function TEditButtonActionLinkEh.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

procedure TEditButtonActionLinkEh.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TEditButtonActionLinkEh.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TEditButtonActionLinkEh.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.ShortCut := Value;
end;

procedure TEditButtonActionLinkEh.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

function KillMouseUp(Control: TControl; Area: TRect): Boolean;
var
  p: TPoint;
  Msg: TMsg;
  WinControl: TWinControl;
begin
  Result := False;
  if Control is TWinControl
    then WinControl := TWinControl(Control)
    else WinControl := Control.Parent;
  if PeekMessage(Msg, WinControl.Handle, WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, PM_NOREMOVE) then
  begin
    if (Msg.message = WM_LBUTTONDOWN) or (Msg.message = WM_LBUTTONDBLCLK) then
    begin
      P := SmallPointToPointEh(LongintToSmallPoint(Msg.lParam));
      if (WinControl = Control) or
         (WinControl.ControlAtPos(P, True) = Control) then
      begin
        P := Control.ScreenToClient(WinControl.ClientToScreen(P));
        if PtInRect(Control.ClientRect, P) then
        begin
          PeekMessage(Msg, WinControl.Handle, Msg.message, Msg.message, PM_REMOVE);
          Result := True;
        end;
      end;
    end;
  end;
end;

function KillMouseUp(Control: TControl): Boolean;
var
  p: TPoint;
  Msg: TMsg;
  WinControl: TWinControl;
begin
  Result := False;
  if Control is TWinControl
    then WinControl := TWinControl(Control)
    else WinControl := Control.Parent;
  if PeekMessage(Msg, WinControl.Handle, WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, PM_NOREMOVE) then
  begin
    if (Msg.message = WM_LBUTTONDOWN) or (Msg.message = WM_LBUTTONDBLCLK) then
    begin
      P := SmallPointToPointEh(LongintToSmallPoint(Msg.lParam));
      if WinControl.ControlAtPos(P, True) = Control then
      begin
        PeekMessage(Msg, WinControl.Handle, Msg.message, Msg.message, PM_REMOVE);
        Result := True;
      end;
    end;
  end;
end;

function IsMouseButtonPressedEh(Button: TMouseButton): Boolean;
begin
  {$IFDEF MSWINDOWS}
  if (Button = mbLeft) then
    Result := GetAsyncKeyState(VK_LBUTTON) < 0
  else if (Button = mbRight) then
    Result := GetAsyncKeyState(VK_RBUTTON) < 0
  else if (Button = mbMiddle) then
    Result := GetAsyncKeyState(VK_MBUTTON) < 0
  else
    Result := False;
  {$ELSE}
  Result := False;
  {$ENDIF}
end;

procedure StdFillGradientEh(Canvas: TCanvas; ARect: TRect; FromColor, ToColor: TColor);
{$IFDEF MSWINDOWS}
var
  h,i: Integer;
  rgb1, rgb2: Integer;
  a1,a2,a3, b1,b2,b3: Integer;
  r, g, b: Double;
  c1, c2, c3: Double;
begin
  rgb1 := ColorToRGB(FromColor);
  a1 := rgb1 and $FF;
  a2 := (rgb1 shr 8) and $FF;
  a3 := (rgb1 shr 16) and $FF;

  rgb2 := ColorToRGB(ToColor);
  b1 := rgb2 and $FF;
  b2 := (rgb2 shr 8) and $FF;
  b3 := (rgb2 shr 16) and $FF;

  h := ARect.Bottom - ARect.Top - 1;

  if h < 0 then
    Exit;

  if h > 0  then
  begin
    c1 := (a1-b1) / h;
    c2 := (a2-b2) / h;
    c3 := (a3-b3) / h;
  end else
  begin
    c1 := a1;
    c2 := a2;
    c3 := a3;
  end;

  for i := 0 to h do
  begin
    r := a1-c1*i;
    g := a2-c2*i;
    b := a3-c3*i;
    Canvas.Pen.Color := TColor((Max(Min(Round(b), 255),0) shl 16)
                            or (Max(Min(Round(g), 255),0) shl 8)
                            or Max(Min(Round(r), 255),0));
    Canvas.Pen.Width := 1;
    if ARect.Right - ARect.Left <= 1
    then
      Canvas.Polyline([Point(ARect.Left, ARect.Top+i),
                       Point(ARect.Right,ARect.Top+i)])
    else
      Canvas.Rectangle(ARect.Left, ARect.Top+i, ARect.Right, ARect.Top+i+1);
  end;
end;
{$ELSE}
begin
  {$IFDEF FPC_CROSSP}
  Canvas.GradientFill(ARect, FromColor, ToColor, gdVertical);
  {$ELSE}
  FillGradientRect(Canvas.Handle, ARect, ColorToRGB(FromColor), ColorToRGB(ToColor), False);
  {$ENDIF}
end;
{$ENDIF}

procedure FillGradientEh(Canvas: TCanvas; TopLeft: TPoint;
  Points: array of TPoint; FromColor, ToColor: TColor);
var
  h,i,h1: Integer;
  rgb1, rgb2: Integer;
  a1,a2,a3, b1,b2,b3: Integer;
  r, g, b: Double;
{$IFDEF MSWINDOWS}
  LineWidth: Integer;
  sp: TPoint;
{$ENDIF}
begin

  rgb1 := ColorToRGB(FromColor);
  a1 := rgb1 and $FF;
  a2 := (rgb1 shr 8) and $FF;
  a3 := (rgb1 shr 16) and $FF;

  rgb2 := ColorToRGB(ToColor);
  b1 := rgb2 and $FF;
  b2 := (rgb2 shr 8) and $FF;
  b3 := (rgb2 shr 16) and $FF;

  h := Length(Points) div 2 - 1;

  for i := 0 to h do
  begin
    h1 := h;
    if h1 = 0 then h1 := 1;
    r := a1-(a1-b1) / h1 * i;
    g := a2-(a2-b2) / h1 * i;
    b := a3-(a3-b3) / h1 * i;
    Canvas.Pen.Color := TColor((Max(Min(Round(b), 255),0) shl 16)
                            or (Max(Min(Round(g), 255),0) shl 8)
                            or Max(Min(Round(r), 255),0));
{$IFDEF MSWINDOWS}
    if CacheAlphaBitmapInUse then
    begin
      sp := Point(TopLeft.X + Points[i*2].X, TopLeft.Y + Points[i*2].Y);
      LineWidth := TopLeft.X+Points[i*2+1].X - sp.X - 1;
      AlphaBitmap.DrawHorzLine(sp, LineWidth, Canvas.Pen.Color);
    end else
{$ENDIF}
    begin
      Canvas.Polyline(
        [Point(TopLeft.X + Points[i*2].X, TopLeft.Y + Points[i*2].Y),
         Point(TopLeft.X+Points[i*2+1].X, TopLeft.Y + Points[i*2+1].Y)]);
    end;
  end;
end;

function ApproachToColorEh(FromColor, ToColor: TColor; Percent: Integer): TColor;
var
  r, g, b: Double;
  rgb: Longint;
  r_c, g_c, b_c: Double;
  rgb_c: Longint;
begin
  rgb := ColorToRGB(FromColor);
  r := rgb and $FF;
  g := (rgb shr 8) and $FF;
  b := (rgb shr 16) and $FF;

  rgb_c := ColorToRGB(ToColor);
  r_c := rgb_c and $FF;
  g_c := (rgb_c shr 8) and $FF;
  b_c := (rgb_c shr 16) and $FF;

  r := r + (r_c - r) * Percent / 100;
  g := g + (g_c - g) * Percent / 100;
  b := b + (b_c - b) * Percent / 100;

  Result := TColor((Max(Min(Round(b), 255),0) shl 16)
                or (Max(Min(Round(g), 255),0) shl 8)
                or Max(Min(Round(r), 255),0));
end;

function ThemesEnabled: Boolean;
begin
  Result := ThemeServices.ThemesEnabled;
end;

function ThemedSelectionEnabled: Boolean;
begin
  {$IFDEF FPC_CROSSP}
  Result := False;
  {$ELSE}
  Result := ThemesEnabled and CheckWin32Version(6, 0);
  {$ENDIF}
end;

function CustomStyleActive: Boolean;
begin
{$IFDEF EH_LIB_16} //XE2
  Result := TStyleManager.IsCustomStyleActive;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function IsThemePartDefinedEh(Details: TThemedElementDetails): Boolean;
begin
  if CustomStyleActive or
     not ThemesEnabled then
  begin
    Result := False;
    Exit;
  end;

{$IFDEF EH_LIB_16} //XE2
  if not (Details.Element in CWindowsElements) then
    Result := True
  else if (Details.Part = 0) then
    Result := True
  else if IsThemePartDefined(StyleServices.Theme[Details.Element], Details.Part, 0) then
    Result := True
  else
    Result := False;
{$ELSE}
  Result := True
{$ENDIF}
end;

procedure FillGradientEh(Canvas: TCanvas; ARect: TRect; FromColor, ToColor: TColor);
begin
  StdFillGradientEh(Canvas, ARect, FromColor, ToColor);
end;

function GetShiftState: TShiftState;
begin
  Result := [];
  if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
end;

type
 TFieldTypes = set of TFieldType;

const
  ftNumberFieldTypes: TFieldTypes = [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD
  , ftFMTBcd
    {$IFDEF EH_LIB_12}, ftLongWord, ftShortint, ftByte, TFieldType.ftExtended{$ENDIF}
    {$IFDEF EH_LIB_13}, ftSingle{$ENDIF}];

function IsFieldTypeNumeric(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in ftNumberFieldTypes;
end;

function VarIsNumericType(const Value: Variant): Boolean;
var
  AVarType: TVarType;
begin
  AVarType := VarType(Value);
 if (AVarType in [varSmallint, varInteger, varSingle, varDouble, varCurrency,
     varShortInt, varWord, varInt64, varLongWord,
      varByte
      ]) or (AVarType = VarFMTBcd)
  then
    Result := True
  else
    Result := False;
end;

const
  ftStringFieldTypes: TFieldTypes = [
    ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraClob, ftVariant,
    ftGuid
{$IFDEF EH_LIB_10}
    ,ftFixedWideChar, ftWideMemo
{$ENDIF}];

function IsFieldTypeString(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in ftStringFieldTypes;
end;

var
  GraphicProviderClasses: TClassList;

procedure InitGraphicProviders;
begin
  if (GraphicProviderClasses <> nil) then Exit;

  GraphicProviderClasses := TClassList.Create;
  {$IFDEF FPC}
  {$ELSE}
  PopupListEh := TPopupListEh.Create;
  {$ENDIF}
  ExplorerTreeviewTheme := 0;

  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if InitThemeLibrary and UseThemes then
  begin
    ExplorerTreeviewTheme := OpenThemeData(0, 'Explorer::Treeview');
    if ExplorerTreeviewTheme = 0 then
      ExplorerTreeviewTheme := OpenThemeData(0, 'Treeview');
  end;
  {$ENDIF}

  RegisterGraphicProviderEh(TBMPGraphicProviderEh);
end;

procedure ReleaseGraphicProviders;
begin
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(PopupListEh);
  {$ENDIF}
  FreeAndNil(GraphicProviderClasses);

  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if ExplorerTreeviewTheme <> 0 then
  begin
    CloseThemeData(ExplorerTreeviewTheme);
    ExplorerTreeviewTheme := 0;
  end;
  {$ENDIF}
end;

procedure RegisterGraphicProviderEh(GraphicProviderClass: TGraphicProviderEhClass);
begin
{$IFDEF CIL}
{$ELSE}
  InitGraphicProviders;
  if GraphicProviderClasses.IndexOf(GraphicProviderClass) < 0 then
    GraphicProviderClasses.Insert(0, GraphicProviderClass);
{$ENDIF}
end;

function GetImageClassForStreamEh(Start: Pointer): TGraphicClass;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to GraphicProviderClasses.Count-1 do
  begin
    Result := TGraphicProviderEhClass(GraphicProviderClasses[i]).GetImageClassForStream(Start);
    if Result <> nil then
      Exit;
  end;
end;

function GetGraphicProvidersCount: Integer;
begin
  Result := GraphicProviderClasses.Count;
end;

function GetGraphicFromStream(AStream: TStream): TGraphic;
var
  ms: TMemoryStream;
  GraphicClass: TGraphicClass;
  MemPointer: Pointer;
begin
  Result := nil;
  try
    ms := TMemoryStream.Create;
    try
    if GetGraphicProvidersCount > 0 then
    begin
        ms.LoadFromStream(AStream);
        ms.Position := 0;
        MemPointer := ms.Memory;
        GraphicClass := GetImageClassForStreamEh(MemPointer);
        if GraphicClass = nil then
          GraphicClass := TBitmap;
    end else
      GraphicClass := TBitmap;

    Result := GraphicClass.Create;
    try
      Result.LoadFromStream(ms);
    except
      on EInvalidGraphic do ;
    end;

    {$IFDEF FPC}
    {$ELSE}
    if Result is TBitmap then
      (Result as TBitmap).IgnorePalette := True;
    {$ENDIF}

    finally
      FreeAndNil(ms);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function GetGraphicForField(Field: TField): TGraphic;
var
  ms: TMemoryStream;
  BlobField: TBlobField;
  GraphicClass: TGraphicClass;
  MemPointer: Pointer;
  {$IFDEF FPC}
  {$ELSE}
  Header: TGraphicHeader;
  msSize: Longint;
  {$ENDIF}
begin
  Result := nil;
  try
  if Assigned(Field) and Field.IsBlob and (Field is TBlobField) then
  begin
    ms := TMemoryStream.Create;
    try
    if GetGraphicProvidersCount > 0 then
    begin
        BlobField := (Field as TBlobField);
        BlobField.SaveToStream(ms);
        ms.Position := 0;
        MemPointer := ms.Memory;
        {$IFDEF FPC}
        {$ELSE}
        if (Field as TBlobField).GraphicHeader then
        begin
          msSize := ms.Size;
          if msSize >= SizeOf(TGraphicHeader) then
          begin
            ms.Read(Header, SizeOf(Header));
            if (Header.Count <> 1) or (Header.HType <> $0100) or
              (Header.Size <> msSize - SizeOf(Header))
            then
              ms.Position := 0
            else
              MemPointer := Pointer(IntPtr(ms.Memory) + SizeOf(Header));
          end;
        end;
        {$ENDIF}
        GraphicClass := GetImageClassForStreamEh(MemPointer);
        if GraphicClass = nil then
          GraphicClass := TBitmap;

    end else
      GraphicClass := TBitmap;

    Result := GraphicClass.Create;
    try
      Result.LoadFromStream(ms);
    except
      on EInvalidGraphic do ;
    end;

    {$IFDEF FPC}
    {$ELSE}
    if Result is TBitmap then
      (Result as TBitmap).IgnorePalette := True;
    {$ENDIF}

    finally
      FreeAndNil(ms);
    end;
  end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure AssignPictureFromImageField(Field: TField; Picture: TPicture);
var
  PictureGraphic: TGraphic;
begin
  PictureGraphic := GetGraphicForField(Field);
  Picture.Graphic := PictureGraphic;
  PictureGraphic.Free;
end;

function GetPictureForField(Field: TField): TPicture;
begin
  Result := TPicture.Create;
  AssignPictureFromImageField(Field, Result);
end;

{ TGraphicProviderEh }

class function TGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
begin
  Result := nil;
end;

{ TBMPGraphicProviderEh }

class function TBMPGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
var
  BmpCode: Word;
begin
 Result := nil;
 if (Start = nil) then
   Exit;

 Move(Start^, BmpCode, 2);
 if (BmpCode = $4D42) then
   Result := TBitmap;

end;

{ TIconGraphicProviderEh }

class function TIconGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
begin
  Result := nil;
end;

function SelectClipRectangleEh(Canvas: TCanvas; const ClipRect: TRect): HRgn;
var
  Rgn, SaveRgn: HRgn;
  Flag: Integer;
begin
  SaveRgn := CreateRectRgn(0, 0, 0, 0);
  Flag := GetClipRgn(Canvas.Handle, SaveRgn);
  Rgn := CreateRectRgn(ClipRect.Left, ClipRect.Top, ClipRect.Right, ClipRect.Bottom);
  ExtSelectClipRgn(Canvas.Handle, Rgn, RGN_AND);
  DeleteObject(Rgn);
  if Flag = 0 then
  begin
    Result := 0;
    DeleteObject(SaveRgn);
  end else
    Result := SaveRgn;
end;

procedure RestoreClipRectangleEh(Canvas: TCanvas; RecHandle: HRgn);
begin
  if RecHandle = 0 then
    SelectClipRgn(Canvas.Handle, 0)
  else
  begin
    SelectClipRgn(Canvas.Handle, RecHandle);
    DeleteObject(RecHandle);
  end;
end;

{ TEditButtonImagesEh }

constructor TEditButtonImagesEh.Create(Owner: TEditButtonEh);
begin
  inherited Create;
  FOwner := Owner;
end;

destructor TEditButtonImagesEh.Destroy;
begin
  inherited Destroy;
end;

function TEditButtonImagesEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TEditButtonImagesEh.ImagesStateChanged;
begin
  FOwner.Changed;
end;

procedure TEditButtonImagesEh.RefComponentChanged(RefComponent: TComponent);
begin
  FOwner.RefComponentChanged(RefComponent);
end;

{$IFDEF CIL}
{$ELSE}
procedure DrawProgressBarEh(const CurrentValue, MinValue, MaxValue: Double;
  Canvas: TCanvas; const Rect: TRect; Color, FrameColor, BackgroundColor: TColor;
  const PBParPtr: PProgressBarParamsEh = nil);
var
  progressRect : TRect;
  progressPosition : Integer;
  progressWidth : Integer;
  progressText : String;

  textSize : TSize;
  textRect : TRect;

  pbp : TProgressBarParamsEh;
begin

  if Assigned(PBParPtr) then
    pbp := PBParPtr^
  else
  begin
    pbp.ShowText := True;
    pbp.TextType := pbttAsPercent;
    pbp.TextDecimalPlaces := 0;
    pbp.Indent := 1;
    pbp.FrameFigureType := pbfftRectangle;
    pbp.FrameSizeType := pbfstVal;
    pbp.FontName := Canvas.Font.Name;
    pbp.FontColor := Canvas.Font.Color;
    pbp.FontSize := GetFontSize(Canvas.Font);
    pbp.FontStyle := Canvas.Font.Style;
    pbp.TextAlignment := taCenter;
  end;

  if BackgroundColor = clDefault then
    BackgroundColor := Canvas.Brush.Color;
  if BackgroundColor <> clNone then
  begin
    Canvas.Brush.Color := StyleServices.GetSystemColor(BackgroundColor);
    Canvas.FillRect(Rect);
  end;

  progressWidth := Rect.Right - Rect.Left - (pbp.Indent shl 2);

  if CurrentValue > 0 then
    progressPosition := Trunc(CurrentValue / (MaxValue - MinValue) * progressWidth)
  else
    progressPosition := 0;

  if pbp.ShowText then
  begin
    if pbp.TextType = pbttAsValue then
      progressText := FloatToStr(RoundTo(CurrentValue, -pbp.TextDecimalPlaces))
    else
      progressText := FloatToStr(RoundTo(CurrentValue / (MaxValue - MinValue) * 100, -pbp.TextDecimalPlaces)) + '%';
  end
  else
    progressText := '';

  progressRect := Rect;
  Inc(progressRect.Left, pbp.Indent);
  Inc(progressRect.Top, pbp.Indent);
  Dec(progressRect.Bottom, pbp.Indent);

  if CurrentValue >= MaxValue then
    Dec(progressRect.Right, pbp.Indent)
  else
    if progressRect.Left + progressPosition < Rect.Right then
      progressRect.Right := progressRect.Left + progressPosition;

  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := StyleServices.GetSystemColor(FrameColor);
  if pbp.FrameFigureType = pbfftRectangle then
  begin
    if pbp.FrameSizeType = pbfstFull then
    begin
      Canvas.FillRect(progressRect);
      Canvas.Brush.Color := StyleServices.GetSystemColor(FrameColor);
      progressRect.Right := Rect.Right - pbp.Indent;
      Canvas.FrameRect(progressRect);
    end
    else
      Canvas.Rectangle(progressRect);
  end
  else
  begin
    if pbp.FrameSizeType = pbfstFull then
      begin
        Canvas.Pen.Color := Color;
        Canvas.RoundRect(progressRect.Left, progressRect.Top,
          progressRect.Right, progressRect.Bottom, 5, 5);
        Canvas.Pen.Color := StyleServices.GetSystemColor(FrameColor);
        Canvas.Brush.Style := bsClear;
        progressRect.Right := Rect.Right - pbp.Indent;
        Canvas.RoundRect(progressRect.Left, progressRect.Top,
          progressRect.Right, progressRect.Bottom, 5, 5);
      end
    else
      Canvas.RoundRect(progressRect.Left, progressRect.Top,
          progressRect.Right, progressRect.Bottom, 10, 5);
  end;

  if pbp.ShowText and (progressText <> '') then
  begin
    Canvas.Font.Name := pbp.FontName;
    Canvas.Font.Color := pbp.FontColor;
    Canvas.Font.Size := pbp.FontSize;
    Canvas.Font.Style := pbp.FontStyle;
    Canvas.Brush.Style := bsClear;

    textSize := Canvas.TextExtent(progressText);
    textRect := Rect;

    if (PBParPtr = nil) and (textSize.cy >= textRect.Bottom - textRect.Top) and (Color <> FrameColor) then
    begin
      Canvas.Font.Size := GetFontSize(Canvas.Font) - 1;
      textSize := Canvas.TextExtent(progressText);
    end;

    case pbp.TextAlignment of
      taLeftJustify :
        textRect.Left := Rect.Left + pbp.Indent + 3;
      taCenter :
        textRect.Left := Rect.Left + ((Rect.Right - Rect.Left) shr 1) - (textSize.cx shr 1);
      taRightJustify :
        textRect.Left := Rect.Right - textSize.cx - pbp.Indent - 3;
    end;

    textRect.Top := Rect.Top + ((Rect.Bottom - Rect.Top) shr 1) - (textSize.cy shr 1);
    textRect.Right := textRect.Left + textSize.cx;
    textRect.Bottom := textRect.Top + textSize.cy;

    if (textRect.Left < Rect.Left) then
      textRect.Left := Rect.Left + 1;

    Canvas.TextRect(textRect, textRect.Left, textRect.Top, progressText);
  end;
end;
{$ENDIF}

{ TPopupMenuEh }

constructor TPopupMenuEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  {$ELSE}
  PopupListEh.Add(Self);
  {$ENDIF}
end;

destructor TPopupMenuEh.Destroy;
begin
  {$IFDEF FPC}
  {$ELSE}
  if PopupListEh <> nil then
    PopupListEh.Remove(Self);
  {$ENDIF}
  inherited Destroy;
end;

{$IFDEF FPC}
procedure TPopupMenuEh.Popup(X, Y: Integer);
begin
  inherited Popup(X, Y);
end;
{$ELSE}
procedure TPopupMenuEh.Popup(X, Y: Integer);
var
  OldPopupList: TPopupList;
begin
  OldPopupList := PopupList;
  PopupList := PopupListEh;
  inherited Popup(X, Y);
  PopupList := OldPopupList;
end;
{$ENDIF}

{$IFDEF FPC}
{$ELSE}

function HookCBProc(nCode: Integer; wParam: wParam;
  lParam: lParam): LRESULT; stdcall;
var
  i: Integer;
begin
  Result := CallNextHookEx(FSysHook, nCode, wParam, lParam);
  if (PopupListEh = nil) then Exit;
  if nCode = HCBT_DESTROYWND then
  begin
    for i := 0 to PopupListEh.FPopupMenuWins.Count-1 do
      if wParam = Windows.wParam(TPopupMenuWinEh(PopupListEh.FPopupMenuWins[i]).FPopupWindowHandle) then
      begin
        SendMessage(wParam, WM_DESTROY, 0, 0);
      end;
  end;
end;

{ TPopupListEh }

constructor TPopupListEh.Create;
begin
  inherited Create;
  FPopupMenuWins := TObjectListEh.Create;
{$IFDEF EH_LIB_19}
  {$IFDEF MSWINDOWS}
  FSysHook := SetWindowsHookEx(WH_CBT, @HookCBProc, 0, GetCurrentThreadId);
  {$ELSE}
  FSysHook := 0;
  {$ENDIF}
{$ELSE}
  FSysHook := 0;
{$ENDIF}
end;

destructor TPopupListEh.Destroy;
begin
  while Count > 0 do
    Remove(TPopupMenu(Items[Count-1]));
  if FSysHook <> 0 then UnhookWindowsHookEx(FSysHook);
  FreeAndNil(FPopupMenuWins);
  inherited Destroy;
end;

function TPopupListEh.FindHackedMenuHandle(MenuPopup: HMENU): TPopupMenuWinEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FPopupMenuWins.Count-1 do
    if MenuPopup = TPopupMenuWinEh(FPopupMenuWins[i]).FMenuHandle then
    begin
      Result := TPopupMenuWinEh(FPopupMenuWins[i]);
      Exit;
    end;
end;

function TPopupListEh.AddMenuPopup(MenuPopup: HMENU): TPopupMenuWinEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FPopupMenuWins.Count-1 do
    if MenuPopup = TPopupMenuWinEh(FPopupMenuWins[i]).FMenuHandle then
      Exit;
  Result := TPopupMenuWinEh.Create;
  Result.FMenuHandle := MenuPopup;
  FPopupMenuWins.Add(Result);
end;

procedure TPopupListEh.DeleteWin(WindowHandle: HWND);
var
  i: Integer;
  MenuWin: TPopupMenuWinEh;
begin
  for i := 0 to FPopupMenuWins.Count-1 do
  begin
    if WindowHandle = TPopupMenuWinEh(FPopupMenuWins[i]).FPopupWindowHandle then
    begin
      MenuWin := TPopupMenuWinEh(FPopupMenuWins[i]);
      FreeAndNil(MenuWin);
      FPopupMenuWins.Delete(i);
      Exit;
    end;
  end;
end;

procedure TPopupListEh.MenuSelectID(ItemID: UINT; var CanClose: Boolean);
var
  Item: TMenuItem;
  I: Integer;
begin
  CanClose := True;
  Item := nil;
  for I := 0 to Count - 1 do
  begin
    Item := TPopupMenu(Items[I]).FindItem(ItemID, fkCommand);
    if Item <> nil then
      Break;
  end;
  if Assigned(Item) and (Item is TMenuItemEh) and not TMenuItemEh(Item).CloseMenuOnClick then
  begin
    Item.Click;
    CanClose := False;
  end;
end;

procedure TPopupListEh.MenuSelectPos(MenuHandle: HMENU; ItemPos: UINT;  var CanClose: Boolean);
var
  ItemID: UINT;
begin
  ItemID := GetMenuItemID(MenuHandle, ItemPos);
  if ItemID <> $FFFFFFFF then
    MenuSelectID(GetMenuItemID(MenuHandle, ItemPos), CanClose);
end;

procedure TPopupListEh.WndProc(var Message: TMessage);
{$IFDEF MSWINDOWS}
var
  AddedMenuWin: TPopupMenuWinEh;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  case Message.Msg of
    WM_ENTERIDLE:
      if FGetPopupWindowHandle then
      begin
        AddedMenuWin := AddMenuPopup(FAddingMenuHandle);
        FGetPopupWindowHandle := False;

        AddedMenuWin.FPopupWindowHandle := TWMEnterIdle(Message).IdleWnd;

        AddedMenuWin.FHookedPopupWindowProc := classes.MakeObjectInstance(AddedMenuWin.PopupWindowProc);
        AddedMenuWin.FOrgPopupWindowProc := Pointer(GetWindowLong(AddedMenuWin.FPopupWindowHandle, GWL_WNDPROC));
        SetWindowLong(AddedMenuWin.FPopupWindowHandle, GWL_WNDPROC, NativeInt(AddedMenuWin.FHookedPopupWindowProc));
      end;

    WM_INITMENUPOPUP:
      begin
        if FindHackedMenuHandle(TWMInitMenuPopup(Message).MenuPopup) = nil then
        begin
          FAddingMenuHandle := TWMInitMenuPopup(Message).MenuPopup;
          FGetPopupWindowHandle := True;
        end;
      end;
    WM_MENUSELECT:
      begin
        AddedMenuWin := FindHackedMenuHandle(TWMMenuSelect(Message).Menu);
        if AddedMenuWin <> nil then
          AddedMenuWin.FSelectedItemID := TWMMenuSelect(Message).IDItem;
      end;

  end;
{$ENDIF}

  inherited WndProc(Message)
end;

{ TPopupMenuWinEh }

procedure TPopupMenuWinEh.PopupWindowProc(var Msg: TMessage);
{$IFDEF MSWINDOWS}
var
  NormalItem: Boolean;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  NormalItem := True;
  case Msg.Msg of
    $01ED, $01F1:
      begin
        begin
          try
          {$IFDEF FPC}
          {$ELSE}
          PopupListEh.MenuSelectPos(FMenuHandle, UINT(Msg.WParamLo), NormalItem);
          {$ENDIF}
            if not NormalItem then
            begin
              InvalidateRect(FPopupWindowHandle, nil, False);
              Exit;
            end;
          finally
          end;
        end;
      end;

    WM_KEYDOWN:
      if Msg.WParam = VK_RETURN then
      begin
        {$IFDEF FPC}
        {$ELSE}
        PopupListEh.MenuSelectID(FSelectedItemID, NormalItem);
        {$ENDIF}
        if not NormalItem then
        begin
          InvalidateRect(FPopupWindowHandle, nil, False);
          Exit;
        end;
      end;

    WM_DESTROY:
      begin
        if FPopupWindowHandle <> 0 then
        begin
          {$IFDEF FPC}
          SetWindowLong(FPopupWindowHandle, GWL_WNDPROC, {%H-}NativeInt(FOrgPopupWindowProc));
          {$ELSE}
          SetWindowLong(FPopupWindowHandle, GWL_WNDPROC, NativeInt(FOrgPopupWindowProc));
          {$ENDIF}
          classes.FreeObjectInstance(FHookedPopupWindowProc);
          Msg.Result := CallWindowProc(FOrgPopupWindowProc, FPopupWindowHandle,
            Msg.Msg, Msg.WParam, Msg.LParam);
          {$IFDEF FPC}
          {$ELSE}
          PopupListEh.DeleteWin(FPopupWindowHandle);
          {$ENDIF}
          Exit;
        end;
      end;
  end;

  Msg.Result := CallWindowProc(FOrgPopupWindowProc, FPopupWindowHandle,
      Msg.Msg, Msg.WParam, Msg.LParam);
{$ENDIF}
end;

destructor TPopupMenuWinEh.Destroy;
begin
  FHookedPopupWindowProc := nil;
  FPopupWindowHandle := 0;
  inherited Destroy;
end;

{$ENDIF} 

{ TMenuItemEh }

procedure TMenuItemEh.Click;
var
  OldOnClick: TNotifyEvent;
  OldAction: TBasicAction;
begin
  OldOnClick := OnClick;
  OnClick := nil;
  OldAction := Action;
  Action := nil;

  inherited Click;

  if (FActualMenuItem <> nil) then
    FActualMenuItem.Checked := Checked;

  Action := OldAction;
  OnClick := OldOnClick;

  if Assigned(OnClick) and
     (Action <> nil) and
     (@OnClick <> @Action.OnExecute)
  then
    OnClick(Self)
  else if not (csDesigning in ComponentState) and
              (ActionLink <> nil)
  then
    ActionLink.Execute(Self)
  else if Assigned(OnClick) then
    OnClick(Self);
end;

constructor TMenuItemEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCloseMenuOnClick := True;
end;

constructor TMenuItemEh.Create(AOwner: TComponent; ActualMenuItem: TMenuItem);
begin
  inherited Create(AOwner);
  FCloseMenuOnClick := True;
  FActualMenuItem := ActualMenuItem;
end;

{ TDropDownFormCallParamsEh }

constructor TDropDownFormCallParamsEh.Create;
begin
  inherited Create;
  FAlign := daCenter;
  FPassParams := pspFieldValueEh;
  FFormWidth := -1;
  FormHeight := -1;
  FSaveFormSize := True;
end;

procedure TDropDownFormCallParamsEh.FillPassParams(DynParams: TDynVarsEh);
var
  ADataLink: TDataLink;
  AField: TField;
  ADataSet: TDataSet;
  Fields: TFieldListEh;
  i: Integer;
  AFieldName: String;
begin
  ADataLink := GetDataLink;
  AField := GetField;
  if ADataLink <> nil
    then ADataSet := ADataLink.DataSet
    else ADataSet := nil;

  if (PassParams = pspByFieldNamesEh) and (PassFieldNames <> '') and (ADataSet <> nil) then
  begin
    Fields := TFieldListEh.Create;
    try
      ADataSet.GetFieldList(Fields, PassFieldNames);
      for I := 0 to Fields.Count - 1 do
        DynParams.CreateDynVar(TField(Fields[i]).FieldName, TField(Fields[i]).Value)
    finally
      Fields.Free;
    end;
  end else if PassParams = pspFieldValueEh then
  begin
    if AField <> nil
      then AFieldName := AField.FieldName
      else AFieldName := '';
    DynParams.CreateDynVar(AFieldName, GetControlValue);
  end else if PassParams = pspRecordValuesEh then
  begin
    ADataSet := ADataLink.DataSet;
    for i := 0 to ADataSet.Fields.Count-1 do
      DynParams.CreateDynVar(ADataSet.Fields[i].FieldName, ADataSet.Fields[i].Value);
  end;
end;

procedure TDropDownFormCallParamsEh.GetDataFromPassParams(
  DynParams: TDynVarsEh);
var
  ADataSet: TDataSet;
  DataSetWasInEditState: Boolean;
  Fields: TFieldListEh;
  i: Integer;
begin
  if (PassParams in [pspFieldValueEh, pspRecordValuesEh]) or
     (AssignBackFieldNames <> '') then
  begin
    if GetDataLink <> nil
      then ADataSet := GetDataLink.DataSet
      else ADataSet := nil;
    DataSetWasInEditState := False;
    if ADataSet <> nil then
    begin
      DataSetWasInEditState := (ADataSet.State in [dsEdit, dsInsert]);
      if not DataSetWasInEditState then
        ADataSet.Edit;
    end;
    if AssignBackFieldNames <> '' then
    begin
      Fields := TFieldListEh.Create;
      try
        ADataSet.GetFieldList(Fields, AssignBackFieldNames);
        for I := 0 to Fields.Count - 1 do
          TField(Fields[I]).Value := DynParams[TField(Fields[I]).FieldName].Value;
      finally
        Fields.Free;
      end;
    end else
      SetControlValue(DynParams.Items[0].Value);

    if (ADataSet <> nil) and not DataSetWasInEditState then
      ADataSet.Post;
  end;
end;

function TDropDownFormCallParamsEh.GetActualDropDownForm(
  var FreeFormOnClose: Boolean): TCustomForm;
var
  ADropDownFormClass: TCustomDropDownFormClassEh;
begin
  if Assigned(FOnGetActualDropDownFormProc) then
    FOnGetActualDropDownFormProc(Result, FreeFormOnClose)
  else
  begin
    FreeFormOnClose := False;
    Result := nil;
    if DropDownForm <> nil then
      Result := DropDownForm
    else if DropDownFormClassName <> '' then
    begin
      ADropDownFormClass := TCustomDropDownFormClassEh(GetClass(DropDownFormClassName));
      if ADropDownFormClass <> nil then
      begin
        Result := ADropDownFormClass.GetGlobalRef;
        if Result = nil then
        begin
          Result := ADropDownFormClass.Create(GetEditControl);
          if ADropDownFormClass.GetGlobalRef = nil then
            FreeFormOnClose := True;
        end;
      end else
        raise Exception.Create('Class ''' + DropDownFormClassName + ''' is not registered');
    end;
  end;
end;

function TDropDownFormCallParamsEh.GetEditButton: TEditButtonEh;
begin
  Result := FEditButton;
end;

function TDropDownFormCallParamsEh.GetEditButtonControl: TEditButtonControlEh;
begin
  Result := FEditButtonControl;
end;

function TDropDownFormCallParamsEh.GetEditControl: TWinControl;
begin
  Result := FEditControl;
end;

function TDropDownFormCallParamsEh.GetEditControlScreenRect: TRect;
begin
  if FEditControl <> nil then
    Result := ClientToScreenRect(FEditControl)
  else
    Result := FEditControlScreenRect;
end;

function TDropDownFormCallParamsEh.GetOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh;
begin
  Result := FOnCloseDropDownFormProc;
end;

function TDropDownFormCallParamsEh.GetOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh;
begin
  Result := FOnOpenDropDownFormProc;
end;

function TDropDownFormCallParamsEh.GetOnGetVarValueProc: TGetVarValueProcEh;
begin
  Result := FOnGetVarValueProc;
end;

function TDropDownFormCallParamsEh.GetOnSetVarValueProc: TSetVarValueProcEh;
begin
  Result := FOnSetVarValueProc;
end;

function TDropDownFormCallParamsEh.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

function TDropDownFormCallParamsEh.GetField: TField;
begin
  Result := FField;
end;

function TDropDownFormCallParamsEh.GetControlValue: Variant;
var
  AOnGetVarValueProc: TGetVarValueProcEh;
begin
  Result := Null;
  AOnGetVarValueProc := OnGetVarValue;
  if Assigned(AOnGetVarValueProc)
    then AOnGetVarValueProc(Result)
    else Result := Unassigned;
end;

procedure TDropDownFormCallParamsEh.SetControlValue(const Value: Variant);
var
  AOnSetVarValueProc: TSetVarValueProcEh;
begin
  AOnSetVarValueProc := OnSetVarValue;
  if Assigned(AOnSetVarValueProc) then
    AOnSetVarValueProc(Value);
end;

procedure TDropDownFormCallParamsEh.Changed;
begin
  if Assigned(FOnChanged) then
    OnChanged(Self);
end;

procedure TDropDownFormCallParamsEh.SetDropDownForm(const Value: TCustomForm);
begin
  if FDropDownForm <> Value then
  begin
    FDropDownForm := Value;
    Changed;
  end;
end;

procedure TDropDownFormCallParamsEh.SetDropDownFormClassName(const Value: String);
begin
  if FDropDownFormClassName <> Value then
  begin
    FDropDownFormClassName := Value;
    Changed;
  end;
end;

function TDropDownFormCallParamsEh.GetControlReadOnly: Boolean;
var
  AField: TField;
begin
  AField := GetField;
  if (AField <> nil) and AField.ReadOnly
    then Result := True
    else Result := False;
  if Assigned(FOnCheckDataIsReadOnly) then
    FOnCheckDataIsReadOnly(Result);
end;

procedure TDropDownFormCallParamsEh.CheckShowDropDownForm(var Handled: Boolean);
var
  DDParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams;
  IntDropDownForm: IDropDownFormEh;
  ADropDownForm: TCustomForm;
  AFreeFormOnClose: Boolean;
  AEditControl: TWinControl;
begin
  ADropDownForm := nil;
  AEditControl := GetEditControl;

  AFreeFormOnClose := False;
  ADropDownForm := GetActualDropDownForm(AFreeFormOnClose);

  DDParams := TDynVarsEh.Create(AEditControl);
  SysParams := CreateSysParams;

  SysParams.FreeFormOnClose := AFreeFormOnClose;
  InitSysParams(SysParams);

  FillPassParams(DDParams);

  InitDropDownForm(ADropDownForm, DDParams, SysParams);

  if Supports(ADropDownForm, IDropDownFormEh, IntDropDownForm) then
  begin

    if SaveFormSize then
    begin
      OldFormWidth := ADropDownForm.Width;
      if FormWidth > 0 then
      begin
        ADropDownForm.Width := FormWidth;
      end;
      OldFormHeight := ADropDownForm.Height;
      if FormHeight > 0 then
      begin
        ADropDownForm.Height := FormHeight;
      end;
    end;

    BeforeOpenDropDownForm(ADropDownForm, DDParams, SysParams);

    IntDropDownForm.ExecuteNomodal(GetEditControlScreenRect, nil, Align,
      DDParams, SysParams, DropDownFormCallbackProc);
    Handled := True;
  end else
  begin
    DDParams.Free;
    SysParams.Free;
  end;
end;

procedure TDropDownFormCallParamsEh.DropDownFormCallbackProc(
  DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams);
var
  ASysParams: TEditControlDropDownFormSysParams;
  AEditControl: TWinControl;
  AOnCloseDropDownFormProc: TEditControlCloseDropDownFormEventEh;
begin
  AEditControl := GetEditControl;

  ASysParams := TEditControlDropDownFormSysParams(SysParams);

  try
  try

  if Accept then
    GetDataFromPassParams(DynParams);

  DropDownForm.Hide;
  if SaveFormSize then
  begin
    FormWidth := DropDownForm.Width;
    if OldFormWidth > 0 then
      DropDownForm.Width := OldFormWidth;
    FormHeight := DropDownForm.Height;
    if OldFormHeight > 0 then
      DropDownForm.Height := OldFormHeight;
  end;

  if Assigned(OnCloseDropDownFormProc) then
  begin
    AOnCloseDropDownFormProc := OnCloseDropDownFormProc;
    AOnCloseDropDownFormProc(AEditControl, nil, Accept, DropDownForm, DynParams);
  end;

  AfterCloseDropDownForm(Accept, DropDownForm, DynParams, SysParams);

  if AEditControl <> nil then
  begin
    if ASysParams.FEditButton <> nil
      then PostMessage(AEditControl.Handle, WM_USER, WPARAM(AEditControl.Handle), LPARAM(ASysParams.FEditButton))
      else PostMessage(AEditControl.Handle, WM_USER, WPARAM(AEditControl.Handle), LPARAM(AEditControl));
  end;

  finally
    DynParams.Free;
    SysParams.Free;
  end;
  except
    TCustomDropDownFormEh(DropDownForm).KeepFormVisible := True;
    Application.HandleException(AEditControl);
    TCustomDropDownFormEh(DropDownForm).KeepFormVisible := False;
  end;

end;

function TDropDownFormCallParamsEh.CreateSysParams: TDropDownFormSysParams;
begin
  Result := TEditControlDropDownFormSysParams.Create;
end;

procedure TDropDownFormCallParamsEh.InitSysParams(
  SysParams: TDropDownFormSysParams);
var
  ASysParams: TEditControlDropDownFormSysParams;
begin
  if SysParams is TEditControlDropDownFormSysParams then
  begin
    ASysParams := TEditControlDropDownFormSysParams(SysParams);
    ASysParams.FEditControl := GetEditControl;
    ASysParams.FEditButton := GetEditButton;
  end;
end;

procedure TDropDownFormCallParamsEh.InitDropDownForm(var DropDownForm: TCustomForm;
  DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams);
var
  AOnOpenDropDownFormProc: TEditControlShowDropDownFormEventEh;
begin
  if Assigned(OnOpenDropDownFormProc) then
  begin
    AOnOpenDropDownFormProc := OnOpenDropDownFormProc;
    AOnOpenDropDownFormProc(GetEditControl, GetEditButton, DropDownForm, DynParams);
  end;
end;

procedure TDropDownFormCallParamsEh.BeforeOpenDropDownForm(
  DropDownForm: TCustomForm; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams);
var
  IntDropDownForm: IDropDownFormEh;
begin
  if GetEditButtonControl <> nil then
    GetEditButtonControl.AlwaysDown := True;
  if Supports(DropDownForm, IDropDownFormEh, IntDropDownForm) then
    IntDropDownForm.ReadOnly := GetControlReadOnly;
end;

procedure TDropDownFormCallParamsEh.AfterCloseDropDownForm(Accept: Boolean;
  DropDownForm: TCustomForm; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams);
begin

end;

{ TOrderByList }

constructor TOrderByList.Create;
begin
  inherited Create(False);
end;

constructor TOrderByList.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
end;

function TOrderByList.GetToken(const Exp: String; var FromIndex: Integer): String;
var
  Chars: TSysCharSet;
begin
  Result := '';
  if FromIndex > Length(Exp) then Exit;
  while Exp[FromIndex] = ' ' do
  begin
    Inc(FromIndex);
    if FromIndex > Length(Exp) then Exit;
  end;
  if FromIndex > Length(Exp) then Exit;
{$IFDEF EH_LIB_12}
  if CharInSet(Exp[FromIndex], [',', ';']) then
{$ELSE}
  if Exp[FromIndex] in [',', ';'] then
{$ENDIF}
  begin
    Result := Result + Exp[FromIndex];
    Inc(FromIndex);
    Exit;
  end;
  if Exp[FromIndex] = '[' then
  begin
    Chars := [#0, ']'];
    Inc(FromIndex);
  end else
    Chars := [#0, ' ', ',', ';'];
  while not CharInSetEh(Exp[FromIndex], Chars) do
  begin
    Result := Result + Exp[FromIndex];
    Inc(FromIndex);
    if FromIndex > Length(Exp) then Break;
  end;
  if (FromIndex <= Length(Exp)) and (Exp[FromIndex] = ']') then
    Inc(FromIndex);
end;

procedure TOrderByList.AssignFieldIndex(OrderItem: TOrderByItemEh;
  const FieldIndex: Integer);
begin
end;

function TOrderByList.FindFieldIndex(const FieldName: String): Integer;
begin
  Result := -1;
end;

function TOrderByList.GetItem(Index: Integer): TOrderByItemEh;
begin
  Result := TOrderByItemEh(inherited Items[Index]);
end;

procedure TOrderByList.ParseOrderByStr(const OrderByStr: String);
var
  FieldName, Token: String;
  FromIndex: Integer;
  Desc: Boolean;
  OByItem: TOrderByItemEh;
  FieldIndex: Integer;
  OrderByList: TOrderByList;
  i: Integer;
begin
  OrderByList := TOrderByList.Create;
  try
    FromIndex := 1;
    FieldName := GetToken(OrderByStr, FromIndex);
    if FieldName = '' then
    begin
      ClearFreeItems;
      Exit;
    end;
    FieldIndex := FindFieldIndex(FieldName);
    if FieldIndex = -1 then
      raise Exception.Create(' Field - "' + FieldName + '" not found.');
    Desc := False;
    while True do
    begin
      Token := GetToken(OrderByStr, FromIndex);
      if AnsiUpperCase(Token) = 'ASC' then
        Continue
      else if AnsiUpperCase(Token) = 'DESC' then
      begin
        Desc := True;
        Continue
      end else if (Token = ';') or (Token = ',') or (Token = '') then
      
      else
        raise Exception.Create(' Invalid token - "' + Token + '"');

      OByItem := TOrderByItemEh.Create;
      OByItem.MTFieldIndex := -1;
      OByItem.FieldIndex := -1;
      AssignFieldIndex(OByItem, FieldIndex);
      OByItem.Desc := Desc;
      TOrderByList(OrderByList).Add(OByItem);

      FieldName := GetToken(OrderByStr, FromIndex);
      if FieldName = '' then Break;
      FieldIndex := FindFieldIndex(FieldName);
      if FieldIndex = -1 then
        raise Exception.Create(' Field - "' + FieldName + '" not found.');
      Desc := False;
    end;
    ClearFreeItems;
    for i := 0 to OrderByList.Count-1 do
      Add(OrderByList[i]);
  finally
    OrderByList.Free;
  end;
end;

procedure TOrderByList.SetItem(Index: Integer; const Value: TOrderByItemEh);
begin
  inherited Items[Index] := Value;
end;

procedure TOrderByList.ClearFreeItems;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    {$IFDEF AUTOREFCOUNT}
    {$ELSE}
    Items[i].Free;
    {$ENDIF}
    Items[i] := nil;
  end;
  Clear;
end;

{ TPictureEh }

constructor TPictureEh.Create;
begin
  inherited Create;
end;

destructor TPictureEh.Destroy;
begin
  inherited Destroy;
end;

function TPictureEh.GetDestRect(const SrcRect: TRect;
  Placement: TImagePlacementEh): TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
  ActualPlacement: TImagePlacementEh;
begin
  w := Self.Width;
  h := Self.Height;
  Result := SrcRect;
  cw := Result.Right - Result.Left;
  ch := Result.Bottom - Result.Top;
  if Placement = ipReduceFitEh then
    if (cw >= w) and (ch >= h)
      then ActualPlacement := ipCenterCenterEh
      else ActualPlacement := ipFitEh
    else
      ActualPlacement := Placement;

  case ActualPlacement of
    ipStretchEh :
      begin
        w := cw;
        h := ch;
      end;

    ipFillEh :
      begin
        if (w > 0) and (h > 0) then
        begin
          xyaspect := h / w;
          h := ch;
          w := Trunc(ch / xyaspect);
          if w < cw then
          begin
            w := cw;
            h := Trunc(cw * xyaspect);
          end;
        end
        else
        begin
          w := cw;
          h := ch;
        end;
      end;

    ipFitEh :
      begin
        if (w > 0) and (h > 0) then
        begin
          xyaspect := w / h;
          w := cw;
          h := Trunc(cw / xyaspect);
          if h > ch then
          begin
            h := ch;
            w := Trunc(ch * xyaspect);
          end;
        end
        else
        begin
          w := cw;
          h := ch;
        end;
      end;
  end;

  Result.Right := Result.Left + w;
  Result.Bottom := Result.Top + h;

  case ActualPlacement of
    ipTopLeftEh :
      OffsetRect(Result, 0, 0);
    ipTopCenterEh :
      OffsetRect(Result, (cw - w) div 2, 0);
    ipTopRightEh :
      OffsetRect(Result, (cw - w), 0);

    ipCenterLeftEh :
      OffsetRect(Result, 0, (ch - h) div 2);
    ipCenterCenterEh :
      OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
    ipCenterRightEh :
      OffsetRect(Result, (cw - w), (ch - h) div 2);

    ipBottomLeftEh :
      OffsetRect(Result, 0, (ch - h));
    ipBottomCenterEh :
      OffsetRect(Result, (cw - w) div 2, (ch - h));
    ipBottomRightEh :
      OffsetRect(Result, (cw - w), (ch - h));

    ipFillEh :
      begin
        if h = ch then
        begin
          Inc(Result.Left, (cw - w) div 2);
          Inc(Result.Right, (cw - w) div 2);
        end else
        begin
          Inc(Result.Top, (ch - h) div 2);
          Inc(Result.Bottom, (ch - h) div 2);
        end;
      end;

    ipFitEh :
      begin
        if w = cw then
        begin
          Inc(Result.Top, (ch - h) div 2);
          Inc(Result.Bottom, (ch - h) div 2);
        end else
        begin
          Inc(Result.Left, (cw - w) div 2);
          Inc(Result.Right, (cw - w) div 2);
        end;
      end;
  end;
end;

procedure TPictureEh.PaintTo(Canvas: TCanvas; const DestRect: TRect;
  Placement: TImagePlacementEh; const ShiftPoint: TPoint;
  const ClipRect: TRect);
var
  Rect: TRect;
  MLeft : Integer;
begin
  Rect := GetDestRect(DestRect, Placement);

  if (Placement = ipTileEh) and (Self.Width > 0) and (Self.Height > 0) then
  begin
    MLeft := Rect.Left;
    while Rect.Top < DestRect.Bottom do
    begin
      while Rect.Left < DestRect.Right do
      begin
        Canvas.StretchDraw(Rect, Self.Graphic);
        OffsetRect(Rect, Self.Width, 0);
      end;
      Rect.Left := MLeft;
      Rect.Right := Rect.Left + Self.Width;
      OffsetRect(Rect, 0, Self.Height);
    end;
  end
  else
    Canvas.StretchDraw(Rect, Self.Graphic);
end;

{ TCacheAlphaBitmapEh }

function GetCacheAlphaBitmap(Width, Height: Integer): TCacheAlphaBitmapEh;
begin
  if AlphaBitmap = nil then
  begin
    AlphaBitmap := TCacheAlphaBitmapEh.Create;
    AlphaBitmap.PixelFormat := pf32bit;
{$IFDEF EH_LIB_12}
    AlphaBitmap.AlphaFormat := afDefined;
{$ENDIF}
    SetBkMode(AlphaBitmap.Canvas.Handle, TRANSPARENT);
  end;
  if AlphaBitmap.Width < Width then
    AlphaBitmap.Width := Width;
  if AlphaBitmap.Height < Height then
    AlphaBitmap.Height := Height;
  Result := AlphaBitmap;
end;

function CacheAlphaBitmapInUse: Boolean;
begin
  if (AlphaBitmap <> nil) and AlphaBitmap.FCapture
    then Result := True
    else Result := False;
end;


type
  pRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = packed ARRAY [0 .. 65000] OF TRGBQuad;
  pRGBQuad = ^TRGBQuad;

procedure TCacheAlphaBitmapEh.DrawHorzLine(p: TPoint; LineWidth: Integer; AColor: TColor);
var
  sl: pRGBQuadArray;
  sp: pRGBQuad;
  xi : Integer;
  rgbc: COLORREF;
  r,g,b, a: Byte;
  xfr,xto: Integer;
begin
  rgbc := ColorToRGB(AColor);
  r := GetRValue(rgbc);
  g := GetGValue(rgbc);
  b := GetBValue(rgbc);
  a := 255;
  if (p.y < 0) or (p.y >= Height) then Exit;
  if p.x >= Width then Exit;
  xfr := p.x;
  xto := p.x + LineWidth;
  if xfr < 0 then xfr := 0;
  if xto < 0 then xto := 0;
  if xto > Width - 1 then xto := Width - 1;

  {$IFDEF FPC}
  sl := {%H-}Scanline[p.y];
  {$ELSE}
  sl := Scanline[p.y];
  {$ENDIF}
  for xi := xfr to xto do
  begin
    sp := @(sl[xi]);
    sp.rgbRed := (r * a) div 255;
    sp.rgbGreen := (g * a) div 255;
    sp.rgbBlue := (b * a) div 255;
    sp.rgbReserved := a;
  end;
end;

procedure TCacheAlphaBitmapEh.Capture;
begin
  if FCapture then
    raise Exception.Create('CacheAlphaBitmap have captured');
  FCapture := True;
end;

procedure TCacheAlphaBitmapEh.Release;
begin
  FCapture := False;
end;

{ TGridToolTipsWindowEh }

procedure THintWindowEh.Paint;
var
  R: TRect;
begin
  if Color <> Application.HintColor then
  begin
    R := ClientRect;
    Inc(R.Left, 2);
    Inc(R.Top, 2);
    Canvas.Font := Font;
    DrawTextEh(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    {$IFDEF FPC}
      DT_WORDBREAK);
    {$ELSE}
      DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
    {$ENDIF}
  end else
  begin
    Canvas.Font := Font;
    inherited Paint;
  end;
end;

procedure THintWindowEh.ActivateHintData(Rect: TRect;
  const AHint: string; AData: Pointer);
begin
  if (AData <> nil) and
     (TObject(AData) is TFont)
  then
    Font := TFont(AData);
  inherited ActivateHintData(Rect, AHint, AData);
end;

function THintWindowEh.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  if AData <> nil then
    Canvas.Font.Assign(TFont(AData));
  Canvas.Font.Color := clWindowText;

  {$IFDEF FPC}
  Result := inherited CalcHintRect(MaxWidth, AHint, AData);
  {$ELSE}
  Result := Rect(0, 0, MaxWidth, 0);
  DrawText(Canvas.Handle, PChar(AHint), -1, Result, DT_CALCRECT or DT_LEFT or
    {$IFDEF FPC}
    DT_WORDBREAK or DT_NOPREFIX);
    {$ELSE}
    DT_WORDBREAK or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly);
    {$ENDIF}
  Inc(Result.Right, 6);
  Inc(Result.Bottom, 2);
  {$ENDIF}
end;

var
  FEhLibManager: TEhLibManager;

{ TEhLibManager }

constructor TEhLibManager.Create;
begin

  FPopupDateTimePickerClass := TPopupDateTimeCalendarFormEh;

  FPopupCalculatorClass := TPopupCalculatorFormEh;

  FDateTimeCalendarPickerHighlightHolidays := True;
  FWeekWorkingDays := [wwdMondayEh, wwdTuesdayEh, wwdWednesdayEh, wwdThursdayEh, wwdFridayEh];
  AltDecimalSeparator := '.';
  FDateTimeCalendarPickerShowTimeSelectionPage := True;
  FUseAlphaFormatInAlphaBlend := ThemesEnabled;
end;

function SetEhLibManager(NewEhLibManager: TEhLibManager): TEhLibManager;
begin
  Result := FEhLibManager;
  FEhLibManager := NewEhLibManager;
end;

function EhLibManager: TEhLibManager;
begin
  Result := FEhLibManager;
end;

procedure TEhLibManager.SetDateTimeCalendarPickerHighlightHolidays(
  const Value: Boolean);
begin
  if FDateTimeCalendarPickerHighlightHolidays <> Value then
  begin
    FDateTimeCalendarPickerHighlightHolidays := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TEhLibManager.SetWeekWorkingDays(const Value: TWeekDaysEh);
begin
  if FWeekWorkingDays <> Value then
  begin
    FWeekWorkingDays := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

{ TWorkingTimeCalendarEh }

var
  FGlobalWorkingTimeCalendar: TWorkingTimeCalendarEh;

function GlobalWorkingTimeCalendar: TWorkingTimeCalendarEh;
begin
  Result := FGlobalWorkingTimeCalendar;
end;

function RegisterGlobalWorkingTimeCalendar(NewWorkingTimeCalendar: TWorkingTimeCalendarEh): TWorkingTimeCalendarEh;
begin
  Result := FGlobalWorkingTimeCalendar;
  FGlobalWorkingTimeCalendar := NewWorkingTimeCalendar;
end;

function DateToWeekDayEh(ADate: TDateTime): TWeekDayEh;
var
  DayWeekNumUS: Integer;
begin
  DayWeekNumUS := DayOfWeek(ADate);
  if DayWeekNumUS = 1 then DayWeekNumUS := 8;
  DayWeekNumUS := DayWeekNumUS - 1;
  Result := TWeekDayEh(DayWeekNumUS - 1);
end;

constructor TWorkingTimeCalendarEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWorkingTimeCalendarEh.Destroy;
begin
  inherited Destroy;
end;

procedure TWorkingTimeCalendarEh.GetWorkingTime(ADate: TDateTime;
  var ATimeRanges: TTimeRangesEh);
begin
  SetLength(ATimeRanges, 1);
  ATimeRanges[0].StartTime := EncodeTime(8,0,0,0);
  ATimeRanges[0].FinishTime := EncodeTime(17,0,0,0);
end;

function TWorkingTimeCalendarEh.IsWorkday(ADate: TDateTime): Boolean;
var
  WeekDay: TWeekDayEh;
begin
  
  WeekDay := DateToWeekDayEh(ADate);
  Result := WeekDay in EhLibManager.WeekWorkingDays;
end;


{$IFDEF FPC}

{$IFDEF FPC_WINDOWS}
type
  TWin32WSPopupInactiveFormEh = class(TWin32WSHintWindow)
  published
    class function CreateHandle(const AWinControl: TWinControl; const AParams: TCreateParams): HWND; override;
  end;

function PopupInactiveFormEhWindowProc(Window: HWnd; Msg: UInt; WParam: Windows.WParam;
    LParam: Windows.LParam): LResult; stdcall;
begin
  Result := 0;
  case Msg of
    WM_MOUSEACTIVATE:
      begin
        Result := MA_NOACTIVATE;
        Exit;
      end;
  end;
  Result := WindowProc(Window, Msg, WParam, LParam);
end;

class function TWin32WSPopupInactiveFormEh.CreateHandle(const AWinControl: TWinControl;
  const AParams: TCreateParams): HWND;
var
  Params: TCreateWindowExParams;
begin
  PrepareCreateWindow(AWinControl, AParams, Params);
  with Params do
  begin
    pClassName := @ClsName[0];
    SubClassWndProc := @PopupInactiveFormEhWindowProc;
    WindowTitle := StrCaption;
    Flags := WS_POPUP;
    FlagsEx := FlagsEx or WS_EX_TOOLWINDOW;
    Left := LongInt(CW_USEDEFAULT);
    Top := LongInt(CW_USEDEFAULT);
    Width := LongInt(CW_USEDEFAULT);
    Height := LongInt(CW_USEDEFAULT);
  end;
  FinishCreateWindow(AWinControl, Params, False);
  Result := Params.Window;
end;

procedure RegisterPopupInactiveFormEh;
const
  Done: Boolean = False;
begin
  if Done then exit;
  RegisterWSComponent(TPopupInactiveFormEh, TWin32WSPopupInactiveFormEh);
  Done := True;
end;
{$ELSE} 

procedure RegisterPopupInactiveFormEh;
begin
end;
{$ENDIF} 

class procedure TPopupInactiveFormEh.WSRegisterClass;
begin
  inherited WSRegisterClass;
  RegisterPopupInactiveFormEh;
end;
{$ELSE}
{$ENDIF}

{ TPopupInactiveFormEh }

constructor TPopupInactiveFormEh.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  {$IFDEF FPC_CROSSP}
    ControlStyle := ControlStyle + [csNoFocus];
  {$ELSE}
  {$ENDIF}
  BorderStyle := bsNone;
  Position := poDesigned;
  FormStyle := fsStayOnTop;
  DropShadow := True;
  ParentBiDiMode := False;
  ParentBiDiMode := True;
end;

destructor TPopupInactiveFormEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPopupInactiveFormEh.Show;
begin
{$IFDEF FPC_LINUX}
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
{$ELSE}
  SetWindowPos(Handle, HWND_TOP {MOST}, Left, Top, Width, Height,
    SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
{$ENDIF}
  inherited Visible := True;
end;

procedure TPopupInactiveFormEh.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TPopupInactiveFormEh.WMActivate(var Message: TWMActivate);
begin
  inherited;
end;

procedure TPopupInactiveFormEh.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
end;

function TPopupInactiveFormEh.CanFocus: Boolean;
begin
  Result := False;
end;

procedure TPopupInactiveFormEh.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
end;

procedure TPopupInactiveFormEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style := WindowClass.style or CS_VREDRAW or CS_HREDRAW;
    {$IFDEF FPC_CROSSP}
    {$ELSE}
    if DropShadow and CheckWin32Version(5, 1) then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
    Params.ExStyle := Params.ExStyle or WS_EX_NOACTIVATE;
    {$ENDIF}
  end;
end;

procedure TPopupInactiveFormEh.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  InflateRect(Rect, -BorderWidth, -BorderWidth);
end;

function TPopupInactiveFormEh.GetBorderWidth: Integer;
begin
  if (BorderStyle = bsNone)
    then Result := 0
    else Result := 2;
end;

procedure TPopupInactiveFormEh.Paint;
var
  R: TRect;
begin
  if BorderWidth = 0 then Exit;
  R := ClientRect;
  DrawEdge(Canvas.Handle, R, BDR_RAISEDOUTER, BF_RECT);
  InflateRect(R, -1, -1);
  DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
end;

function TPopupInactiveFormEh.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

procedure TPopupInactiveFormEh.SetVisible(AValue: Boolean);
begin
  if (AValue <> Visible) then
  begin
    if (AValue) then
       Show
     else
       Hide;
  end;
end;

procedure TPopupInactiveFormEh.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    {$IFDEF FPC}
    CN_KEYDOWN, CN_SYSKEYDOWN,
    {$ELSE}
    {$ENDIF}
    WM_KEYDOWN, WM_SYSKEYDOWN:
    begin
      if (MasterActionsControl <> nil) then
        SendMessage(MasterActionsControl.Handle, Message.Msg, Message.WParam, Message.LParam);
    end;
  end;

  inherited WndProc(Message);
end;

{$IFDEF EH_LIB_10}
{$ELSE}
constructor TMargins.Create(Control: TControl);
begin
  inherited Create;
end;

procedure TMargins.SetMargin(Index: Integer; Value: TMarginSize);
begin
  case Index of
    0:
      if Value <> FLeft then
      begin
        FLeft := Value;
        Change;
      end;
    1:
      if Value <> FTop then
      begin
        FTop := Value;
        Change;
      end;
    2:
      if Value <> FRight then
      begin
        FRight := Value;
        Change;
      end;
    3:
      if Value <> FBottom then
      begin
        FBottom := Value;
        Change;
      end;
  end;
end;

procedure TMargins.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TPadding.Create(Control: TControl);
begin
  inherited Create(Control);
  FLeft := 0;
  Top := 0;
  Right := 0;
  Bottom := 0;
end;
{$ENDIF}

{ TStringsEh }

function TStringsEh.Replace(const SearchStr, ReplaceStr: string; StartPos,
  Length: Integer; Options: TSearchTypes; ReplaceAll: Boolean): Integer;
begin
  Result := -1;
end;

{ TSortMarkerPainterEh }

function TSortMarkerPainterEh.GetSormarkerSize(Canvas: TCanvas;
  SMStyle: TSortMarkerStyleEh): TSize;
var
{$IFDEF FPC}
{$ELSE}
  thed: TThemedElementDetails;
{$ENDIF}
  ScaleFactor: Double;
begin
  Result.cx := -1;
  Result.cy := -1;
  if SMStyle = smstDefaultEh then
    SMStyle := smstClassicEh;
  {$IFDEF FPC}
  if (SMStyle = smstThemeDefinedEh) then
    SMStyle := smstFrameEh;
  {$ELSE}
  if (SMStyle = smstThemeDefinedEh) and not CheckWin32Version(6, 0) then
    SMStyle := smstFrameEh;
  {$ENDIF} 
  if SMStyle in [smstDefaultEh, smstClassicEh, smstFrameEh]then
  begin
    ScaleFactor := GetCanvasScaleForStandardDpi(Canvas);
    Result.cy := Round(ScaleFactor * 8);
    if Result.cy mod 2 = 1 then Result.cy := Result.cy - 1;
    Result.cx := Result.cy - 1;
  end else if SMStyle = smstSolidEh then
  begin
    ScaleFactor := GetCanvasScaleForStandardDpi(Canvas);
    Result.cx := Round(ScaleFactor * 9);
    if Result.cx mod 2 = 0 then Result.cx := Result.cx - 1;
    Result.cy := Result.cx div 2 + 1;
  end else if SMStyle = smst3DFrameEh then
  begin
    ScaleFactor := GetCanvasScaleForStandardDpi(Canvas);
    Result.cy := Round(ScaleFactor * 8);
    if Result.cy mod 2 = 1 then Result.cy := Result.cy - 1;
    Result.cx := Result.cy;
  end else if SMStyle = smstThemeDefinedEh then
  begin
    {$IFDEF FPC}
    {$ELSE}
    thed := ThemeServices.GetElementDetails(thHeaderSortArrowSortedUp);
    GetThemePartSize(ThemeServices.Theme[thed.Element], Canvas.Handle,
      thed.Part, thed.State, nil, TS_TRUE, Result);
    Dec(Result.cx, 2);
    Inc(Result.cy);
    {$ENDIF}
  end;
end;

procedure TSortMarkerPainterEh.Draw(Canvas: TCanvas;  SMStyle: TSortMarkerStyleEh;
  Direction: TSortMarkerEh; ARect: TRect; FrameBrightColor, FrameDarkColor, FillColor: TColor);
var
  Points: TPointArrayEh;
  thed: TThemedElementDetails;
  OldPenColor: TColor;
  ScaleFactor: Double;
  Height, Width: Integer;
  i: Integer;
begin
  if Direction = smNoneEh then Exit;

  OldPenColor := Canvas.Pen.Color;
  if SMStyle = smstDefaultEh then
    SMStyle := smstClassicEh;
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if (SMStyle = smstThemeDefinedEh) and not CheckWin32Version(6, 0) then
    SMStyle := smstFrameEh;
  {$ENDIF} 

  if SMStyle in [smstDefaultEh, smstClassicEh, smstFrameEh] then
  begin
    if FrameDarkColor = clDefault then
      FrameDarkColor := ApproximateColor(clGray, cl3DDkShadow, 50);
    Canvas.Pen.Color := FrameDarkColor;
    ScaleFactor := GetCanvasScaleForStandardDpi(Canvas);
    Height := Round(ScaleFactor * 8);
    if Height mod 2 = 1 then Height := Height - 1;

    if Direction = smDownEh then
    begin
      SetLength(Points, 2);

      Points[0].X := ARect.Left + 0;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left + Height - 1;
      Points[1].Y := ARect.Top + 0;
      Canvas.Polyline(Points);

      Points[0].X := ARect.Left + 0;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left + Height div 2;
      Points[1].Y := ARect.Top + Height;
      Canvas.Polyline(Points);

      Points[0].X := ARect.Left + Height - 2;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left + Height div 2 - 1;
      Points[1].Y := ARect.Top + Height - 1;
      Canvas.Polyline(Points);
    end else
    begin
      SetLength(Points, 2);

      Points[0].X := ARect.Left + 0;
      Points[0].Y := ARect.Top + Height - 1;
      Points[1].X := ARect.Left + Height - 1;
      Points[1].Y := ARect.Top + Height - 1;
      Canvas.Polyline(Points);

      Points[0].X := ARect.Left + Height div 2 - 1;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left + 0;
      Points[1].Y := ARect.Top + Height - 1;
      Canvas.Polyline(Points);

      Points[0].X := ARect.Left + Height div 2 - 1;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left + Height - 2;
      Points[1].Y := ARect.Top + Height - 1;
      Canvas.Polyline(Points);
    end;
  end else if SMStyle = smst3DFrameEh then
  begin
    ScaleFactor := GetCanvasScaleForStandardDpi(Canvas);
    Width := Round(ScaleFactor * 8);
    if Width mod 2 = 1 then Width := Width - 1;

    if Direction = smDownEh then
    begin
      Canvas.Pen.Color := FrameDarkColor;

      SetLength(Points, 2);

      Points[0].X := ARect.Left + 0;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left + Width;
      Points[1].Y := ARect.Top + 0;
      Canvas.Polyline(Points);

      Points[0].X := ARect.Left + Width div 2 - 1;
      Points[0].Y := ARect.Top + Width - 1;
      Points[1].X := ARect.Left;
      Points[1].Y := ARect.Top;
      Canvas.Polyline(Points);
    end else
    begin
      Canvas.Pen.Color := clWindow;

      SetLength(Points, 2);

      Points[0].X := ARect.Left + 0;
      Points[0].Y := ARect.Top + Width - 1;
      Points[1].X := ARect.Left + Width;
      Points[1].Y := ARect.Top + Width - 1;
      Canvas.Polyline(Points);

      Points[0].X := ARect.Left + Width div 2;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left + Width;
      Points[1].Y := ARect.Top + Width;
      Canvas.Polyline(Points);
    end;

    Canvas.Pen.Color := FrameBrightColor;
    SetLength(Points, 2);
    if Direction = smDownEh then
    begin
      Canvas.Pen.Color := clWindow;
      Points[0].X := ARect.Left + Width div 2;
      Points[0].Y := ARect.Top + Width - 1;
      Points[1].X := ARect.Left + Width - 1;
      Points[1].Y := ARect.Top;
      Canvas.Polyline(Points);
    end else
    begin
      Canvas.Pen.Color := FrameDarkColor;
      Points[0].X := ARect.Left + Width div 2 - 1;
      Points[0].Y := ARect.Top + 0;
      Points[1].X := ARect.Left;
      Points[1].Y := ARect.Top + Width - 1;
      Canvas.Polyline(Points);
    end;
    Canvas.Polyline(Points);
  end else if SMStyle = smstSolidEh then
  begin
    Canvas.Pen.Color := FillColor;
    ScaleFactor := GetCanvasScaleForStandardDpi(Canvas);
    Width := Round(ScaleFactor * 9);
    if Width mod 2 = 0 then Width := Width - 1;

    if Direction = smDownEh then
    begin
      SetLength(Points, Width + 1);
      for i := 0 to Width div 2 do
      begin
        Points[i*2].X := i;
        Points[i*2].Y := i;
        Points[i*2+1].X := Width - i;
        Points[i*2+1].Y := i;
      end;
      FillGradientEh(Canvas, ARect.TopLeft, Points, Canvas.Pen.Color, Canvas.Pen.Color)
     end
     else
     begin
      SetLength(Points, Width + 1);
      for i := 0 to Width div 2 do
      begin
        Points[i*2].X := i;
        Points[i*2].Y := Width div 2 - i;
        Points[i*2+1].X := Width - i;
        Points[i*2+1].Y := Width div 2 - i;
      end;
      FillGradientEh(Canvas, ARect.TopLeft, Points, Canvas.Pen.Color, Canvas.Pen.Color)
     end;
  end else if SMStyle = smstThemeDefinedEh then
  begin
    if Direction = smUpEh
      then thed := ThemeServices.GetElementDetails(thHeaderSortArrowSortedUp)
      else thed := ThemeServices.GetElementDetails(thHeaderSortArrowSortedDown);
    ThemeServices.DrawElement(Canvas.Handle, thed, ARect, nil);
  end;
  Canvas.Pen.Color := OldPenColor;
end;

{ TTreeSignPainterEh }

constructor TTreeSignPainterEh.Create;
begin
  FAreaWidthArgs := TTreeSignPainterAreaWidthArgsEh.Create;
end;

destructor TTreeSignPainterEh.Destroy;
begin
  FreeAndNil(FAreaWidthArgs);
  inherited Destroy;
end;

procedure TTreeSignPainterEh.Draw(DrawArgs: TTreeSignPainterDrawArgsEh);
var
  ABoxRect: TRect;
//  OldBoxRect: TRect;
  ACenter: TPoint;
  Square: TRect;
  X2, X4, Y2, Y4: Integer;
  Details: TThemedElementDetails;
  TreeviewPlus: TThemedTreeview;
  OldBrushColor: TColor;
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  DX: Integer;
  PBoundRect: PRECT;
  Size: TSize;
  {$ENDIF} 
  ARect: TRect;
begin
  ARect := DrawArgs.Rect;
  ACenter.X := (ARect.Right + ARect.Left) div 2;
  ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
  X2 := Trunc(DrawArgs.ScaleX * 2);
  X4 := Trunc(DrawArgs.ScaleX * 4);
  Y2 := Trunc(DrawArgs.ScaleY * 2);
  Y4 := Trunc(DrawArgs.ScaleY * 4);
  OldBrushColor := clNone;
  Square := ARect;
  if ARect.Bottom - ARect.Top < ARect.Right - ARect.Left then
  begin
    Square.Left := (ARect.Right + ARect.Left) div 2 - (ARect.Bottom - ARect.Top) div 2;
    Square.Right := Square.Left + (ARect.Bottom - ARect.Top);
  end else
  begin
    Square.Top := (ARect.Bottom + ARect.Top) div 2 - (ARect.Right - ARect.Left) div 2;
    Square.Bottom := Square.Top + (ARect.Bottom - ARect.Top);
  end;

  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if Square.Bottom - Square.Top <= 15 then
  begin
    DX := 17 - (Square.Bottom - Square.Top);
    InflateRect(Square, DX, DX);
    PBoundRect := @ARect;
  end else
    PBoundRect := nil;
  {$ENDIF} 

  ABoxRect := Rect(ACenter.X-X4, ACenter.Y-Y4, ACenter.X+X4+1, ACenter.Y+Y4+1);
  if DrawArgs.TreeElement in [tehMinusUpDown .. tehPlus] then
  begin
    if DrawArgs.Coloured then
    begin
      OldBrushColor := DrawArgs.Canvas.Brush.Color;
      DrawArgs.Canvas.Brush.Color := StyleServices.GetSystemColor(clWindow);
      DrawArgs.Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
      DrawArgs.Canvas.Pen.Style := psSolid;
    end;

    if DrawArgs.GlyphStyle = tvgsClassicEh then
      if DrawArgs.RightToLeft
        then DrawArgs.Canvas.Rectangle(ABoxRect.Left-1, ABoxRect.Top, ABoxRect.Right-1, ABoxRect.Bottom)
        else DrawArgs.Canvas.Rectangle(ABoxRect.Left, ABoxRect.Top, ABoxRect.Right, ABoxRect.Bottom);

    if DrawArgs.Coloured then
      DrawArgs.Canvas.Pen.Color := StyleServices.GetSystemColor(clWindowText);

    if (DrawArgs.GlyphStyle in [tvgsThemedEh, tvgsExplorerThemedEh]) and
        ThemeServices.ThemesEnabled then
    begin
{$IFDEF EH_LIB_16}
{        if TStyleManager.IsCustomStyleActive then
      begin
        LStyle := StyleServices;
        if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus]
          then CatBut := tcbCategoryGlyphClosed
          else CatBut := tcbCategoryGlyphOpened;
        Details := LStyle.GetElementDetails(CatBut);
        LStyle.DrawElement(Canvas.Handle, Details, ABoxRect);
      end else}
{$ENDIF}
      begin
        if DrawArgs.TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlusHLine, tehPlus]
          then TreeviewPlus := ttGlyphClosed
          else TreeviewPlus := ttGlyphOpened;
        Details := ThemeServices.GetElementDetails(TreeviewPlus);
        if DrawArgs.GlyphStyle = tvgsExplorerThemedEh then
        begin
          {$IFDEF FPC_CROSSP}
          {$ELSE}
          GetThemePartSize(ExplorerTreeviewTheme, DrawArgs.Canvas.Handle,
            Details.Part, Details.State, nil, TS_TRUE, Size);
          Square := Rect(0, 0, Size.cx, Size.cy);
          Square := CenteredRect(ARect, Square);
          DrawThemeBackground(ExplorerTreeviewTheme, DrawArgs.Canvas.Handle,
            Details.Part, Details.State, Square, PBoundRect);
          {$ENDIF} 
        end else
        begin
        {$IFDEF FPC}
          ThemeServices.DrawElement(DrawArgs.Canvas.Handle, Details, Square);
        {$ELSE}
          ThemeServices.DrawElement(DrawArgs.Canvas.Handle, Details, ABoxRect);
        {$ENDIF}
        end;
      end;
    end else
    begin
      DrawArgs.Canvas.MoveTo(ABoxRect.Left + X2, ACenter.Y);
      DrawArgs.Canvas.LineTo(ABoxRect.Right - X2, ACenter.Y);

      if DrawArgs.TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus, tehPlusHLine] then
      begin
        DrawArgs.Canvas.MoveTo(ACenter.X, ABoxRect.Top + Y2);
        DrawArgs.Canvas.LineTo(ACenter.X, ABoxRect.Bottom - Y2);
      end;
    end;

    if DrawArgs.Coloured then
      DrawArgs.Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
    if not (DrawArgs.TreeElement in [tehMinus, tehPlus]) then
      DrawDotLine(DrawArgs.Canvas, Point(ABoxRect.Right{ + X1}, ACenter.Y),
       (ARect.Right - ABoxRect.Right), True, False);

    if DrawArgs.TreeElement in [tehMinusUpDown, tehMinusUp, tehPlusUpDown, tehPlusUp] then
      DrawDotLine(DrawArgs.Canvas,
                  Point(ACenter.X, ARect.Top),
                  (ABoxRect.Top - ARect.Top),
                  False, DrawArgs.BackDot);

    if DrawArgs.TreeElement in [tehMinusUpDown, tehMinusDown, tehPlusUpDown, tehPlusDown] then
      DrawDotLine(DrawArgs.Canvas,
                  Point(ACenter.X, ABoxRect.Bottom{ + Y1}),
                 (ARect.Bottom - ABoxRect.Bottom),
                 False, DrawArgs.BackDot);

    if DrawArgs.Coloured then
      DrawArgs.Canvas.Brush.Color := OldBrushColor;
  end else
  begin
    if DrawArgs.Coloured then
    begin
      DrawArgs.Canvas.Pen.Style := psSolid;
      DrawArgs.Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
    end;
    if DrawArgs.TreeElement in [tehCrossUpDown, tehVLine] then
      DrawDotLine(DrawArgs.Canvas,
                  Point(ACenter.X, ARect.Top),
                  (ARect.Bottom - ARect.Top),
                  False, DrawArgs.BackDot);
    if DrawArgs.TreeElement in [tehCrossUpDown, tehCrossUp, tehCrossDown, tehHLine] then
      DrawDotLine(DrawArgs.Canvas,
                  Point(ACenter.X, ACenter.Y),
                  (ARect.Right - ACenter.X),
                  True, False);
    if DrawArgs.TreeElement in [tehCrossDown] then
      DrawDotLine(DrawArgs.Canvas,
                  Point(ACenter.X, ACenter.Y),
                  (ARect.Bottom - ACenter.Y),
                  False, DrawArgs.BackDot);
    if DrawArgs.TreeElement in [tehCrossUp] then
      DrawDotLine(DrawArgs.Canvas,
                  Point(ACenter.X, ARect.Top),
                  (ACenter.Y - ARect.Top),
                  False, DrawArgs.BackDot);
  end;
end;

function TTreeSignPainterEh.GetTreeSignAreaWidth(BaseControl: TWinControl;
  AreaHeight: Integer; ScaleFactor: Double): Integer;
begin
  FAreaWidthArgs.BaseControl := BaseControl;
  FAreaWidthArgs.AreaHeight := AreaHeight;
  FAreaWidthArgs.ScaleFactor := ScaleFactor;
  TreeSignAreaWidthNeeded(FAreaWidthArgs);
  Result := FAreaWidthArgs.AreaWidth;
end;

procedure TTreeSignPainterEh.TreeSignAreaWidthNeeded(Args: TTreeSignPainterAreaWidthArgsEh);
begin
  Args.AreaWidth := Round(18 * Args.ScaleFactor);
end;

{ TEhLibDrawStyleEh }

constructor TEhLibDrawStyleEh.Create;
begin
  FSortmarkerPainter := TSortMarkerPainterEh.Create;
  FTreeSignPainter := TTreeSignPainterEh.Create;
end;

destructor TEhLibDrawStyleEh.Destroy;
begin
  FreeAndNil(FSortmarkerPainter);
  FreeAndNil(FTreeSignPainter);
  inherited;
end;

function TEhLibDrawStyleEh.GetSortmarkerPainter: TSortmarkerPainterEh;
begin
  Result := FSortmarkerPainter;
end;

procedure TEhLibDrawStyleEh.SetSortmarkerPainter(const Value: TSortmarkerPainterEh);
begin
  if (FSortmarkerPainter <> nil) then
    FSortmarkerPainter.Free;

  FSortmarkerPainter := Value;
end;

function TEhLibDrawStyleEh.GetTreeSignPainter: TTreeSignPainterEh;
begin
  Result := FTreeSignPainter
end;

procedure TEhLibDrawStyleEh.SetTreeSignPainter(const Value: TTreeSignPainterEh);
begin
  if (FTreeSignPainter <> Value) then
  begin
    if FTreeSignPainter <> nil then
      FTreeSignPainter.Free;

    FTreeSignPainter := Value;
  end;
end;

var
  FEhLibDrawStyle: TEhLibDrawStyleEh;

function SetEhLibDrawStyle(AEhLibDrawStyle: TEhLibDrawStyleEh): TEhLibDrawStyleEh;
begin
  Result := FEhLibDrawStyle;
  FEhLibDrawStyle := AEhLibDrawStyle;
end;

function EhLibDrawStyle: TEhLibDrawStyleEh;
begin
  Result := FEhLibDrawStyle;
end;

{ InitUnit/FinalizeUnit }

procedure InitUnit;
begin
  FlatButtonWidth := GetDefaultFlatButtonWidth;
  ButtonsBitmapCache := TButtonsBitmapCache.Create;
  GetCheckSize;
  InitGraphicProviders;
  UsesBitmap;
  RegisterClass(TSizeGripEh);
  SetEhLibManager(TEhLibManager.Create);
  RegisterGlobalWorkingTimeCalendar(TWorkingTimeCalendarEh.Create(nil));
  SetEhLibDrawStyle(TEhLibDrawStyleEh.Create);
end;

procedure FinalizeUnit;
begin
  FreeAndNil(ButtonsBitmapCache);
  ReleaseGraphicProviders;
  ReleaseBitmap;
  FreeAndNil(FEhLibManager);
  FreeAndNil(FGlobalWorkingTimeCalendar);
  FreeAndNil(FEhLibDrawStyle);
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.

