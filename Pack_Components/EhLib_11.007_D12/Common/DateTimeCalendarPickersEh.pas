{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                CalendarPicker Component               }
{                                                       }
{   Copyright (c) 2014-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DateTimeCalendarPickersEh;

interface

uses
  Messages,
  {$IFDEF EH_LIB_17} System.UITypes, System.Generics.Collections, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows, Win32Extra,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, Windows, UxTheme,
  {$ENDIF}
  SysUtils, Classes, Controls, Forms, StdCtrls, TypInfo,
  DateUtils, ExtCtrls, Buttons, ButtonsEh, Dialogs, DynVarsEh,
  Contnrs, Variants, Types, Themes, SpreadGridsEh,
  GridsEh, ToolCtrlsEh, Graphics, DropDownFormEh;

type
  TDateTimeCalendarPickerEh  = class;

  TDateTimePickCalendarButtonStyleEh = (cmpsPriorPeriodEh, cmpsNextPeriodEh);

  TImageTransformStyleEh = (itsTransparentTransformEh, itsLeftToRightTransformEh,
    itsRightToLeftTransformEh, itsZoomInTransformEh, itsZoomOutTransformEh);

  TInteractiveInputMethodEh = (iimKeyboardEh, iimMouseEh);

{ TImageTransformatorEh }

  TImageTransformatorEh  = class(TCustomControlEh)
  private
    FBitmap1: TBitmap;
    FBitmap1Transparency: Integer;
    FBitmap2: TBitmap;
    FBitmap2Transparency: Integer;
    FResultBitmap: TBitmap;
    FTransformStyle: TImageTransformStyleEh;
    FTransformTime: Integer;
    FZoomWinRect: TRect;

    procedure DrawHorizontalTransform(Step, Leng: Integer; LeftToRight: Boolean);
    procedure DrawTransparentTransform(Step, Leng: Integer);
    procedure DrawZoomTransform(Step, Leng: Integer; ZoomIn: Boolean);
  protected
    FOutputDebugString: Boolean;

    procedure Paint; override;
    procedure OutputDebugString(s: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Reset(Control1, Control2: TWinControl);
    procedure AnimatedTransform;

    property Bitmap1: TBitmap read FBitmap1;
    property Bitmap2: TBitmap read FBitmap2;
    property TransformTime: Integer read FTransformTime write FTransformTime;
    property TransformStyle: TImageTransformStyleEh read FTransformStyle write FTransformStyle;
    property ZoomWinRect: TRect read FZoomWinRect write FZoomWinRect;
  end;

{ TDateTimePickCalendarTodayInfoLabelEh }

  TDateTimePickCalendarTodayInfoLabelEh = class(TSpeedButtonEh)
  private
    function GetPickCalendar: TDateTimeCalendarPickerEh;
  protected

    procedure Paint; override;
  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh); reintroduce;

    property PickCalendar: TDateTimeCalendarPickerEh read GetPickCalendar;
  end;

{ TDateTimePickCalendarDateInfoLabelEh }

  TDateTimePickCalendarDateInfoLabelEh = class(TSpeedButtonEh)
  private
    function GetPickCalendar: TDateTimeCalendarPickerEh;
  protected

    procedure Paint; override;
  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh); reintroduce;

    property PickCalendar: TDateTimeCalendarPickerEh read GetPickCalendar;
  end;

{ TDateTimePickCalendarButtonEh }

  TDateTimePickCalendarButtonEh = class(TSpeedButtonEh)
  private
    FStyle: TDateTimePickCalendarButtonStyleEh;
    function GetPickCalendar: TDateTimeCalendarPickerEh;

  protected

    procedure Paint; override;
  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh); reintroduce;

    property Style: TDateTimePickCalendarButtonStyleEh read FStyle write FStyle;
    property PickCalendar: TDateTimeCalendarPickerEh read GetPickCalendar;
  end;

  TCustomCalendarViewPaintBufferEh = class(TPersistent)
  public
    HolidayFontColor: TColor;
    HolidayOutsidePeriodFontColor: TColor;
    HolidaySelectedFontColor: TColor;
    HotTrackCellBrushColor: TColor;
    HotTrackCellFontColor: TColor;
    InsideHorzFrameColor: TColor;
    InsideVertFrameColor: TColor;
    NormalCellBrushColor: TColor;
    NormalCellFontColor: TColor;
    OutsidePeriodCellFontColor: TColor;
    SelectedCellBrushColor: TColor;
    SelectedCellFontColor: TColor;
    TodayCellFrameColor: TColor;
  end;

{ TCustomCalendarViewEh }

  TCustomCalendarViewEh = class(TCustomGridEh)
  private
    FDate: TDateTime;
    FSelectNextViewOnClick: Boolean;
    FPaintBuffer: TCustomCalendarViewPaintBufferEh;

    function GetCalendar: TDateTimeCalendarPickerEh;
    procedure SetDateTime(const Value: TDateTime);

    {$IFDEF FPC}
    {$ELSE}
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    {$ENDIF}
    procedure CMStlyeChange(var Message: TMessage); message CM_STYLECHANGED;
  protected
    FMousePos: TPoint;

    function CanHotTackCell(X, Y: Integer): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function SelectNextView(MoveForward, Animated: Boolean): Boolean; virtual;

    procedure Resize; override;
    procedure CellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure ResizeCells; virtual;
    procedure GetAutoSizeData(var NewWidth, NewHeight: Integer); virtual;
    procedure DateChanged; virtual;
    procedure SetPaintBuffer; virtual;
    procedure SetCellCanvasColors(HotTrack, Selected: Boolean); virtual;
    procedure MoveToNextHorzDateTime(MoveForward: Boolean); virtual;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); virtual;
    procedure UpdateMousePos;
    procedure DateSelectedInLastView; virtual;

    property PaintBuffer: TCustomCalendarViewPaintBufferEh read FPaintBuffer;
  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh); reintroduce;
    destructor Destroy; override;

    function CanFocus: Boolean; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; virtual;
    function GetDateInfoText: String; virtual;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; virtual;
    function ShowTodayInfo: Boolean; virtual;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; virtual;

    property Calendar: TDateTimeCalendarPickerEh read GetCalendar;
    property DateTime: TDateTime read FDate write SetDateTime;
    property SelectNextViewOnClick: Boolean read FSelectNextViewOnClick write FSelectNextViewOnClick;
  end;

{ TDecadesCalendarViewEh }

  TDecadesCalendarViewEh = class(TCustomCalendarViewEh)
  private

    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;

  protected
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MoveToNextHorzDateTime(MoveForward: Boolean); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; override;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;
  end;

{ TYearsCalendarViewEh }

  TYearsCalendarViewEh = class(TCustomCalendarViewEh)
  private
  protected

    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MoveToNextHorzDateTime(MoveForward: Boolean); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;
  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; override;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;
  end;

{ TMonthsCalendarViewEh }

  TMonthsCalendarViewEh = class(TCustomCalendarViewEh)
  private

  protected
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MoveToNextHorzDateTime(MoveForward: Boolean); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; override;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;
  end;

  TDaysCalendarViewDayInfoItem = class(TPersistent)
  private
    FIsHoliday: Boolean;
  public
    property IsHoliday: Boolean read FIsHoliday write FIsHoliday;
  end;

{ TDaysCalendarViewEh }

  TDaysCalendarViewEh = class(TCustomCalendarViewEh)
  private
    FDatesInfoList: TObjectListEh;
    FFirstWeekDayNum: Integer;
    FStartDate: TDateTime;

    {$IFDEF FPC}
    {$ELSE}
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
    {$ENDIF}
    procedure CMStlyeChange(var Message: TMessage); message CM_STYLECHANGED;

  protected
    function AdjustDateToStartForGrid(ADateTime: TDateTime): TDateTime;
    function CreateDateInfoItem: TDaysCalendarViewDayInfoItem; virtual;

    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure GetAutoSizeData(var NewWidth, NewHeight: Integer); override;
    procedure DateChanged; override;
    procedure MoveToNextHorzDateTime(MoveForward: Boolean); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;
    procedure ResizeCells; override;

    procedure DrawDayNumCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure DrawWeekDayNameCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure DrawWeekDayNumCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); virtual;
    procedure UpdateDatesInfo;
    procedure UpdateLocaleInfo;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; override;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;

    property StartDate: TDateTime read FStartDate;
  end;

{ TTimeUnitCalendarViewEh }

  TTimeUnitCalendarViewEh = class(TCustomCalendarViewEh)
  private

  protected
    function SelectNextView(MoveForward, Animated: Boolean): Boolean; override;

    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;
  end;

{ THours24CalendarViewEh }

  THours24CalendarViewEh = class(TTimeUnitCalendarViewEh)
  private

  protected
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;

    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;

    procedure MoveToNextHorzDateTime(MoveForward: Boolean); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; override;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function ShowTodayInfo: Boolean; override;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;
  end;

{ THours12CalendarViewEh }

  THours12CalendarViewEh = class(THours24CalendarViewEh)
  private
    FRow0Drawn: Boolean;
    FRow3Drawn: Boolean;

  protected
    procedure Paint; override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;

    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;
  end;

{ TMinutesCalendarViewEh }

  TMinutesCalendarViewEh = class(TTimeUnitCalendarViewEh)
  private
    function RoundTo5(Value: TDateTime): TDateTime;
  protected

    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure MoveToNextHorzDateTime(MoveForward: Boolean); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;
  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; override;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function ShowTodayInfo: Boolean; override;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;
  end;

{ TSecondsCalendarViewEh }

  TSecondsCalendarViewEh = class(TMinutesCalendarViewEh)
  private
    function RoundTo5(Value: TDateTime): TDateTime;

  protected
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MoveToNextHorzDateTime(MoveForward: Boolean); override;
    procedure MoveToNextVertDateTime(MoveForward: Boolean); override;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function DateInViewRange(ADateTime: TDateTime): Boolean; override;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean; override;
  end;

  TTimeCalendarViewPopupListKindEh = (tclcHoursEh, tclcMinutesEh, tclcSecondsEh);

  TTimeCalendarViewPressedButtonTypeEh = (tcpbtHoursUpEh, tcpbtHoursDownEh,
    tcpbtMinutesUpEh, tcpbtMinutesDownEh, tcpbtSecondsUpEh, tcpbtSecondsDownEh);

  TTimeCalendarViewActiveRegionEh = (tcarHoursEh, tcarMinutesEh, tcarSecondsEh,
    {tcarAmTmEh, } tcarOKButtonEh);

  TTimeCalendarViewRegionAction = (tcraSelectPriorEh, tcraSelectNextEh, tcraClickEh);

  TTimeCalendarViewActiveRegionProc = procedure(Action: TTimeCalendarViewRegionAction) of object;

  TTimeCalendarViewColTypeEh = (tcvctHourEh, tcvctMinuteEh, tcvctSecondEh,
    tcvctAmPmEh, tcvctColonEh, tcvctBlankEh);

{ TTimeCalendarViewEh }

  TTimeCalendarViewEh = class(TCustomCalendarViewEh)
  private
    FActiveRegion: TTimeCalendarViewActiveRegionEh;
    FAmPmPos: TAmPmPosEh;
    FColTypes: array of TTimeCalendarViewColTypeEh;
    FHoursFormat: THoursTimeFormatEh;
    FOkButtonCol: Integer;
    FPopupList: TPopupListboxEh;
    FPopupListKind: TTimeCalendarViewPopupListKindEh;
    FPressedButtonType: TTimeCalendarViewPressedButtonTypeEh;
    FPressedCell: TGridCoord;
    FRegionProcList: TList;
    FTimer: TTimer;
    FVisibleRegions: array of TTimeCalendarViewActiveRegionEh;

    {$IFDEF FPC}
    {$ELSE}
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
    {$ENDIF}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;

    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;

    procedure ClosePopupList(Accept: Boolean);
    procedure PaintRow(ARect: TRect; UpRow: Boolean);
    procedure ResetTimer(Interval: Cardinal);
    procedure SetActiveRegion(const Value: TTimeCalendarViewActiveRegionEh);
    procedure StopTimer;

  protected
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;

    function DoMouseWheelEvent(Shift: TShiftState; MousePos: TPoint; DirectionUp: Boolean): Boolean; virtual;

    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure DateChanged; override;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ResizeCells; override;

    procedure DropDownPopupList(ScreenPos: TPoint; StartNum, CountNum, Step: Integer);
    procedure HoursRegionAction(Action: TTimeCalendarViewRegionAction); virtual;
    procedure MinutesRegionAction(Action: TTimeCalendarViewRegionAction); virtual;
    procedure OKButtonRegionAction(Action: TTimeCalendarViewRegionAction); virtual;
    procedure PopupListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure ResetButtonDownTimer(Cell: TGridCoord; AButtonType: TTimeCalendarViewPressedButtonTypeEh); virtual;
    procedure SecondsRegionAction(Action: TTimeCalendarViewRegionAction); virtual;
    procedure SelectNextRegion(MoveForward: Boolean); virtual;
    procedure TimerEvent(Sender: TObject); virtual;
    procedure UpdateLocaleInfo;

    property ActiveRegion: TTimeCalendarViewActiveRegionEh read FActiveRegion write SetActiveRegion;

  public
    constructor Create(AOwner: TDateTimeCalendarPickerEh);
    destructor Destroy; override;

    function AmPm12: Boolean;
    function GetDateInfoText: String; override;
    function GetNextPeriodDate(ADateTime: TDateTime; MoveForward: Boolean): TDateTime; override;
    function ShowTodayInfo: Boolean; override;

    procedure IncrementHour(N: Integer);
    procedure IncrementMinute(N: Integer);
    procedure IncrementSecond(N: Integer);
    procedure ResetGrid;
    procedure ResetRegion;
  end;

  TDateTimePickCalendarActionEh = (dtpcaDecadesDrilledDownEh, dtpcaYearsDrilledDownEh,
    dtpcaMonthsDrilledDownEh, dtpcaDaysDrilledDownEh, dtpcaHourSelectedFromListEh,
    dtpcaMinuteSelectedFromListEh, dtpcaSecondSelectedFromListEh,
    dtpcaButtonOKClickedEh);

{ TDateTimePickCalendarPaintBufferEh }

  TDateTimePickCalendarPaintBufferEh = class(TPersistent)
  public
    CalendarWeekNoFont: TFont;
    HolidayFontColor: TColor;
    HolidayOutsidePeriodFontColor: TColor;
    HolidaySelectedFontColor: TColor;
    HotTrackCellBrushColor: TColor;
    HotTrackCellFontColor: TColor;
    InsideHorzFrameColor: TColor;
    InsideVertFrameColor: TColor;
    NormalCellBrushColor: TColor;
    NormalCellFontColor: TColor;
    OutsidePeriod: TColor;
    SelectedCellBrushColor: TColor;
    SelectedCellFontColor: TColor;
    TodayCellFrameColor: TColor;

    constructor Create;
    destructor Destroy; override;
  end;

{ TDateTimeCalendarPickerEh }

  TDateTimeCalendarPickerEh  = class(TCustomControlEh)
  private
    FCalendarViewList: TObjectListEh;
    FCurrentCalendarView: TCustomCalendarViewEh;
    FDateInfo: TDateTimePickCalendarDateInfoLabelEh;
    FDateTime: TDateTime;
    FDaysView: TDaysCalendarViewEh;
    FDecadesView: TDecadesCalendarViewEh;
    FHours12View: THours12CalendarViewEh;
    FHours24View: THours24CalendarViewEh;
    FImageTrans: TImageTransformatorEh;
    FInputMethod: TInteractiveInputMethodEh;
    FInternalFontSet: Boolean;
    FMinutesView: TMinutesCalendarViewEh;
    FMonthsView: TMonthsCalendarViewEh;
    FNextPeriodButton: TDateTimePickCalendarButtonEh;
    FPaintBuffer: TDateTimePickCalendarPaintBufferEh;
    FPriorPeriodButton: TDateTimePickCalendarButtonEh;
    FSecondsView: TSecondsCalendarViewEh;
    FTimeUnits: TCalendarDateTimeUnitsEh;
    FTimeView: TTimeCalendarViewEh;
    FTodayInfo: TDateTimePickCalendarTodayInfoLabelEh;
    FYearsView: TYearsCalendarViewEh;
    FOnDateTimeSelected: TNotifyEvent;

    function GetTimeUnits: TCalendarDateTimeUnitsEh;

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;

    procedure WMGetDlgCode(var Msg: TWMNoParams); message WM_GETDLGCODE;
    procedure WMThemeChanged(var Message: TMessage); message WM_THEMECHANGED;

    procedure SetDateTime(Value: TDateTime);
    procedure SetInputMethod(const Value: TInteractiveInputMethodEh);
    procedure SetTimeUnits(const Value: TCalendarDateTimeUnitsEh);

  protected
    FMousePos: TPoint;

    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;

    function CreateDaysViewDayInfoItem: TDaysCalendarViewDayInfoItem; virtual;
    function GetMasterFont: TFont; virtual;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure InternalRefreshFont;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure RefreshFont;
    procedure ResetSize;
    procedure Resize; override;

    procedure AnimatedSetHeight(NewHeight: Integer); virtual;
    procedure CalendarViewChanged; virtual;
    procedure DateInfoMouseDown(Sender: TObject; var AutoRepeat: Boolean; var Handled: Boolean); virtual;
    procedure GetAutoSizeData(var NewWidth, NewHeight: Integer); virtual;
    procedure NextPeriodMouseDown(Sender: TObject; var AutoRepeat: Boolean; var Handled: Boolean); virtual;
    procedure CalendarActionPerformed(Action: TDateTimePickCalendarActionEh); virtual;
    procedure SetPaintBuffer; virtual;
    procedure SelectView(NextCalendarView: TCustomCalendarViewEh; MoveForward: Boolean; Animated: Boolean); virtual;
    procedure MoveToNextPeriod(Animated: Boolean); virtual;
    procedure MoveToPriorPeriod(Animated: Boolean); virtual;
    procedure UpdateMousePos;
    procedure ResetTimeUnits; virtual;
    procedure DateSelectedInLastView; virtual;
    procedure UpdateDaysViewDayInfoItem(DayInfoItem: TDaysCalendarViewDayInfoItem; ADate: TDateTime); virtual;

    property InputMethod: TInteractiveInputMethodEh read FInputMethod write SetInputMethod;
    property MasterFont: TFont read GetMasterFont;
    property PaintBuffer: TDateTimePickCalendarPaintBufferEh read FPaintBuffer;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RecomndedSize(var RecClientWidth, RecClientHeight: Integer);
    procedure ResetStartCalendarView;
    procedure SetDateTimeAnimated(Value: TDateTime);

    property CurrentCalendarView: TCustomCalendarViewEh read FCurrentCalendarView;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property TimeUnits: TCalendarDateTimeUnitsEh read GetTimeUnits write SetTimeUnits;

    property OnDateTimeSelected: TNotifyEvent read FOnDateTimeSelected write FOnDateTimeSelected;
  end;

  TCalendarViewDrawStateEh = set of (cvdsSelectedEh, cvdsHotTrackEh, cvdsPressedEh,
    cvdsNowEh, cvdsHolidayEh);

{ TDateTimeCalendarPickerDrawStyleEh }

  TDateTimeCalendarPickerDrawStyleEh = class
  private
    FHolidayBaseFontColor: TColor;
    FHotTrackCellBrushColor: TColor;
    FHotTrackCellBrushColor1: TColor;
    FHotTrackCellBrushColor2: TColor;

    procedure SetHolidayBaseFontColor(const Value: TColor);

  protected
    function GetHolidayBaseFontColor: TColor; virtual;
    function GetHolidayFontColor: TColor; virtual;
    function GetHolidayOutsidePeriodFontColor: TColor; virtual;
    function GetHolidaySelectedFontColor: TColor; virtual;
    function GetHotTrackCellBrushColor: TColor; virtual;
    function GetHotTrackCellFontColor: TColor; virtual;
    function GetInsideHorzFrameColor: TColor; virtual;
    function GetInsideVertFrameColor: TColor; virtual;
    function GetNormalCellBrushColor: TColor; virtual;
    function GetNormalCellFontColor: TColor; virtual;
    function GetOutsidePeriodCellFontColor: TColor; virtual;
    function GetSelectedCellBrushColor: TColor; virtual;
    function GetSelectedCellFontColor: TColor; virtual;
    function GetTodayCellFrameColor: TColor; virtual;

  public
    constructor Create;

    function CanDrawSelectionByStyle: Boolean; virtual;

    procedure DrawCalendarViewCellBackgraund(CalendarView: TCustomCalendarViewEh; Canvas: TCanvas; ARect: TRect; State: TCalendarViewDrawStateEh); virtual;
    procedure SetCalendarFontData(Calendar: TDateTimeCalendarPickerEh; MasterFont: TFont; CalendarFont: TFont); virtual;
    procedure SetCalendarWeekNoFontData(Calendar: TDateTimeCalendarPickerEh; CalendarFont: TFont; CalendarWeekNoFont: TFont); virtual;

    property HolidayBaseFontColor: TColor read GetHolidayBaseFontColor write SetHolidayBaseFontColor;
    property HolidayFontColor: TColor read GetHolidayFontColor;
    property HolidayOutsidePeriodFontColor: TColor read GetHolidayOutsidePeriodFontColor;
    property HolidaySelectedFontColor: TColor read GetHolidaySelectedFontColor;
    property HotTrackCellBrushColor: TColor read GetHotTrackCellBrushColor;
    property HotTrackCellFontColor: TColor read GetHotTrackCellFontColor;
    property InsideHorzFrameColor: TColor read GetInsideHorzFrameColor;
    property InsideVertFrameColor: TColor read GetInsideVertFrameColor;
    property NormalCellBrushColor: TColor read GetNormalCellBrushColor;
    property NormalCellFontColor: TColor read GetNormalCellFontColor;
    property OutsidePeriodCellFontColor: TColor read GetOutsidePeriodCellFontColor;
    property SelectedCellBrushColor: TColor read GetSelectedCellBrushColor;
    property SelectedCellFontColor: TColor read GetSelectedCellFontColor;
    property TodayCellFrameColor: TColor read GetTodayCellFrameColor;
  end;

{ TPopupDateTimeCalendarPickerEh }

  TPopupDateTimeCalendarPickerEh = class(TDateTimeCalendarPickerEh, IPopupDateTimePickerEh)
  private
    FCloseCallback: TCloseWinCallbackProcEh;

    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    {$IFDEF FPC_CROSSP}
    {$ELSE}
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    {$ENDIF}

  protected
    FOwnerFont: TFont;

    function WantKeyDown(Key: Word; Shift: TShiftState): Boolean;
    function WantFocus: Boolean;

    procedure HidePicker;
    procedure ShowPicker(DateTime: TDateTime; Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
    procedure SetFontOptions(OwnerFont: TFont; FontAutoSelect: Boolean);

  protected
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function GetMasterFont: TFont; override;
    function GetDateTime: TDateTime;

    procedure CalendarActionPerformed(Action: TDateTimePickCalendarActionEh); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DateSelectedInLastView; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure UpdateSize;

    procedure PostCloseUp(Accept: Boolean);

  public
    constructor Create(AOwner: TComponent); override;

    function CanFocus: Boolean; override;

    property Color;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
  end;

{ TPopupDateTimeCalendarFormEh }

  TPopupDateTimeCalendarFormEh = class(TCustomDropDownFormEh, IPopupDateTimePickerEh)
  private
    FCloseCallback: TCloseWinCallbackProcEh;

    function GetDateTime: TDateTime;
    function GetTimeUnits: TCalendarDateTimeUnitsEh;
    procedure SetDateTime(const Value: TDateTime);
    procedure SetTimeUnits(const Value: TCalendarDateTimeUnitsEh);
    procedure DropDownFormCallbackProc(DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams);
  protected
    Calendar: TDateTimeCalendarPickerEh;

    function WantKeyDown(Key: Word; Shift: TShiftState): Boolean;
    function WantFocus: Boolean;

    procedure CreateHandle; override;
    procedure CreateWnd; override;
    procedure InitializeNewForm; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure DateTimeSelected(Sender: TObject);
    procedure HidePicker;
    procedure SetFontOptions(Font: TFont; FontAutoSelect: Boolean);
    procedure ShowPicker(DateTime: TDateTime; Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);

  public
    constructor Create(AOwner: TComponent); override;

    procedure UpdateSize; override;

    property DateTime: TDateTime read GetDateTime write SetDateTime;
    property TimeUnits: TCalendarDateTimeUnitsEh read GetTimeUnits write SetTimeUnits;
  end;

function DateTimeCalendarPickerDrawStyleEh: TDateTimeCalendarPickerDrawStyleEh;
function SetDateTimeCalendarPickerDrawStyleEh(DrawStyle: TDateTimeCalendarPickerDrawStyleEh): TDateTimeCalendarPickerDrawStyleEh;

var
  ImageTransformatorDebugInfoEh: TStrings;

implementation

uses
  DBCtrls, EhLibLangConsts;

var
  DrawBitmap: TBitmap;
  FDateTimePickCalendarDrawStyle: TDateTimeCalendarPickerDrawStyleEh;

procedure InitUnit;
begin
  DrawBitmap := TBitmap.Create;
  SetDateTimeCalendarPickerDrawStyleEh(TDateTimeCalendarPickerDrawStyleEh.Create)
end;

procedure FinalizeUnit;
begin
  FreeAndNil(DrawBitmap);
  FreeAndNil(FDateTimePickCalendarDrawStyle);
end;

function TryIncMonthEh(const DateTime: TDateTime; NumberOfMonths: Integer; out Value: TDateTime): Boolean;
var
  Year, Month, Day: Word;
begin
  DecodeDate(DateTime, Year, Month, Day);
  IncAMonth(Year, Month, Day, NumberOfMonths);
  if (TryEncodeDate(Year, Month, Day, Value)) then
  begin
    ReplaceTime(Value, DateTime);
    Result := True;
  end else
  begin
    Value := DateTime;
    Result := True;
  end;
end;

function TryIncYearEh(const AValue: TDateTime; const ANumberOfYears: Integer; out Value: TDateTime): Boolean;
begin
  Result := TryIncMonthEh(AValue, ANumberOfYears * MonthsPerYear, Value);
end;

function TryIncSecondEh(const AValue: TDateTime; const ANumberOfSeconds: Int64; out Value: TDateTime): Boolean;
begin
  Result := True;
  Value := IncMilliSecond(AValue, ANumberOfSeconds * MSecsPerSec);
  if (Value > MaxDateTime) then
  begin
    Value := MaxDateTime;
    Result := False;
  end
  else if (Value < MinDateTime) then
  begin
    Value := MinDateTime;
    Result := False;
  end;
end;

function TryIncMinuteEh(const AValue: TDateTime; const ANumberOfMinutes: Int64; out Value: TDateTime): Boolean;
begin
  Result := TryIncSecondEh(AValue, ANumberOfMinutes * SecsPerMin, Value);
end;

function TryIncHourEh(const AValue: TDateTime; const ANumberOfHours: Int64; out Value: TDateTime): Boolean;
begin
  Result := TryIncMinuteEh(AValue, ANumberOfHours * MinsPerHour, Value);
end;

function TryIncDayEh(const AValue: TDateTime; const ANumberOfDays: Integer; out Value: TDateTime): Boolean;
begin
  Result := TryIncHourEh(AValue, ANumberOfDays * HoursPerDay, Value);
end;

{ TCustomCalendarViewEh }

constructor TCustomCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
  Options := [goDrawFocusSelectedEh];
  ParentFont := True;
  BorderStyle := bsNone;
  HorzScrollBar.Visible := False;
  VertScrollBar.Visible := False;
  FSelectNextViewOnClick := True;
  FPaintBuffer := TCustomCalendarViewPaintBufferEh.Create;
  FMousePos := Point(-1, -1);
end;

destructor TCustomCalendarViewEh.Destroy;
begin
  FreeAndNil(FPaintBuffer);
  inherited Destroy;
end;

function TCustomCalendarViewEh.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := False;
end;

function TCustomCalendarViewEh.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := False;
end;

procedure TCustomCalendarViewEh.SetPaintBuffer;
begin
  Calendar.SetPaintBuffer;
  FPaintBuffer.NormalCellBrushColor := Calendar.PaintBuffer.NormalCellBrushColor;
  FPaintBuffer.NormalCellFontColor := Calendar.PaintBuffer.NormalCellFontColor;
  FPaintBuffer.HotTrackCellBrushColor := Calendar.PaintBuffer.HotTrackCellBrushColor;
  FPaintBuffer.HotTrackCellFontColor := Calendar.PaintBuffer.HotTrackCellFontColor;
  FPaintBuffer.SelectedCellBrushColor := Calendar.PaintBuffer.SelectedCellBrushColor;
  FPaintBuffer.SelectedCellFontColor := Calendar.PaintBuffer.SelectedCellFontColor;
  FPaintBuffer.TodayCellFrameColor := Calendar.PaintBuffer.TodayCellFrameColor;
  FPaintBuffer.OutsidePeriodCellFontColor := Calendar.PaintBuffer.OutsidePeriod;
  FPaintBuffer.InsideHorzFrameColor := Calendar.PaintBuffer.InsideHorzFrameColor;
  FPaintBuffer.InsideVertFrameColor := Calendar.PaintBuffer.InsideVertFrameColor;
  FPaintBuffer.HolidayFontColor := Calendar.PaintBuffer.HolidayFontColor;
  FPaintBuffer.HolidaySelectedFontColor := Calendar.PaintBuffer.HolidaySelectedFontColor;
  FPaintBuffer.HolidayOutsidePeriodFontColor := Calendar.PaintBuffer.HolidayOutsidePeriodFontColor;
end;

procedure TCustomCalendarViewEh.Paint;
begin
  SetPaintBuffer;
  inherited Paint;
end;

function TCustomCalendarViewEh.GetCalendar: TDateTimeCalendarPickerEh;
begin
  Result := TDateTimeCalendarPickerEh(Owner);
end;

procedure TCustomCalendarViewEh.Resize;
begin
  inherited Resize;
  ResizeCells;
end;

procedure TCustomCalendarViewEh.ResizeCells;
var
  i: Integer;
  cw, rest, fix: Integer;
begin
  if not HandleAllocated then Exit;
  cw := ClientWidth div ColCount;
  rest := ClientWidth mod ColCount;
  for i := 0 to ColCount-1 do
  begin
    if rest > i
      then fix := 1
      else fix := 0;
    ColWidths[i] := cw + fix;
  end;

  cw := ClientHeight div RowCount;
  rest := ClientHeight mod RowCount;
  for i := 0 to RowCount-1 do
  begin
    if rest > i
      then fix := 1
      else fix := 0;
    RowHeights[i] := cw + fix;
  end;
end;

function TCustomCalendarViewEh.SelectNextView(MoveForward, Animated: Boolean): Boolean;
var
  NextCalendarView: TCustomCalendarViewEh;
  CurViewIdx: Integer;
begin
  CurViewIdx := Calendar.FCalendarViewList.IndexOf(Self);
  NextCalendarView := Self;
  if CurViewIdx >= 0 then
  begin
    if MoveForward then
    begin
      if CurViewIdx < Calendar.FCalendarViewList.Count-1 then
        NextCalendarView := TCustomCalendarViewEh(Calendar.FCalendarViewList[CurViewIdx+1]);
    end else
    begin
      if CurViewIdx > 0 then
        NextCalendarView := TCustomCalendarViewEh(Calendar.FCalendarViewList[CurViewIdx-1]);
    end;
  end;
  if NextCalendarView = Self then
    Result := False
  else
  begin
    Calendar.SelectView(NextCalendarView, MoveForward, Animated);
    Result := True;
  end;
end;

procedure TCustomCalendarViewEh.SetCellCanvasColors(HotTrack, Selected: Boolean);
begin
  if Selected then
  begin
    Canvas.Brush.Color := PaintBuffer.SelectedCellBrushColor;
    Canvas.Font.Color := PaintBuffer.SelectedCellFontColor;
  end else
  begin
    if HotTrack then
    begin
      Canvas.Brush.Color := PaintBuffer.HotTrackCellBrushColor;
      Canvas.Font.Color := PaintBuffer.HotTrackCellFontColor;
    end else
    begin
      Canvas.Brush.Color := PaintBuffer.NormalCellBrushColor;
      Canvas.Font.Color := PaintBuffer.NormalCellFontColor;
    end;
  end;
end;

procedure TCustomCalendarViewEh.SetDateTime(const Value: TDateTime);
begin
  if FDate <> Value then
  begin
    FDate := Value;
    DateChanged;
  end;
end;

procedure TCustomCalendarViewEh.GetAutoSizeData(var NewWidth, NewHeight: Integer);
begin

end;

procedure TCustomCalendarViewEh.DateChanged;
begin
  Invalidate;
end;

function TCustomCalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
begin
  Result := True;
end;

procedure TCustomCalendarViewEh.DateSelectedInLastView;
begin
  Calendar.DateSelectedInLastView;
end;

function TCustomCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  Result := ADateTime;
end;

function TCustomCalendarViewEh.CanFocus: Boolean;
begin
  
  Result := False;
end;

function TCustomCalendarViewEh.CanHotTackCell(X, Y: Integer): Boolean;
begin
  Result := True;
end;

function TCustomCalendarViewEh.TryDateFromCell(Cell: TGridCoord;
  var ADateTime: TDateTime): Boolean;
begin
  ADateTime := DateTime;
  Result := False;
end;

function TCustomCalendarViewEh.GetDateInfoText: String;
begin
  Result := 'TCustomCalendarViewEh.GetDateInfoText';
end;

procedure TCustomCalendarViewEh.CellMouseDown(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  NewDateTime: TDateTime;
begin
  inherited CellMouseDown(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if Button = mbLeft then
  begin
    if TryDateFromCell(Cell, NewDateTime) then
      Calendar.DateTime := NewDateTime;
  end;
end;

{$IFDEF FPC}
{$ELSE}
procedure TCustomCalendarViewEh.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;
{$ENDIF}

procedure TCustomCalendarViewEh.CMStlyeChange(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomCalendarViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect:
  TRect; const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if SelectNextViewOnClick then
    if (Button = mbLeft) and
       (Cell.X >= FixedColCount) and
       (Cell.Y >= FixedRowCount) then
    begin
      if not SelectNextView(True, True) then
        DateSelectedInLastView;
    end else if Button = mbRight then
      SelectNextView(False, True);
end;

function TCustomCalendarViewEh.ShowTodayInfo: Boolean;
begin
  Result := True;
end;

procedure TCustomCalendarViewEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  Processed: Boolean;
begin
  case Key of
    VK_UP:
      begin
        MoveToNextVertDateTime(False);
        Key := 0;
      end;
    VK_DOWN:
      begin
        MoveToNextVertDateTime(True);
        Key := 0;
      end;
    VK_LEFT:
      begin
        MoveToNextHorzDateTime(False);
        Key := 0;
      end;
    VK_RIGHT:
      begin
        MoveToNextHorzDateTime(True);
        Key := 0;
      end;
    VK_NEXT:
      begin
        Calendar.MoveToNextPeriod(True);
        Key := 0;
      end;
    VK_PRIOR:
      begin
        Calendar.MoveToPriorPeriod(True);
        Key := 0;
      end;
    VK_RETURN:
      begin
        if ssCtrl in Shift then
        begin
          Processed := SelectNextView(False, True);
          if Processed then
            Key := 0;
        end else
        begin
          Processed := SelectNextView(True, True);
          if not Processed then
          begin
            DateSelectedInLastView;
            Key := 0;
          end;
        end;
      end;
  end;
end;

procedure TCustomCalendarViewEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Calendar.InputMethod := iimMouseEh;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomCalendarViewEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if (FMousePos.X <> X) or (FMousePos.Y <> Y) then
  begin
    FMousePos := Point(X, Y);
    Calendar.InputMethod := iimMouseEh;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomCalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
begin

end;

procedure TCustomCalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
begin

end;

procedure TCustomCalendarViewEh.UpdateMousePos;
begin
  FMousePos := ScreenToClient(Mouse.CursorPos);
end;

{ TDecadesCalendarViewEh }

constructor TDecadesCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
  FixedColCount := 0;
  FixedRowCount := 0;
  ColCount := 4;
  RowCount := 3;
  DateTime := Now();
end;

destructor TDecadesCalendarViewEh.Destroy;
begin

  inherited Destroy;
end;

procedure TDecadesCalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  YearFrom, YearTo: Integer;
  y,m,d: Word;
  s: String;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDate(DateTime, y, m, d);
  YearFrom := y div 100 * 100 - 10 + ARow * 4 * 10 + ACol * 10;
  YearTo := YearFrom + 9;
  Canvas.Font := Font;
  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);
  SetCellCanvasColors(DrawHotTrack, (YearFrom <= y) and (YearTo >= y));
  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  if (YearFrom <= y) and (YearTo >= y) then
    CalViewState := CalViewState + [cvdsSelectedEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);
  if YearFrom div 100 <> y div 100 then
    Canvas.Font.Color := PaintBuffer.OutsidePeriodCellFontColor;

  s := IntToStr(YearFrom) + '-' + sLineBreak + IntToStr(YearTo) + '  ';
  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True)
end;

function TDecadesCalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
var
  YearFrom, YearTo: Integer;
  cy, ay: Word;
begin
  cy := YearOf(DateTime);
  YearFrom := cy div 100 * 100;
  YearTo := YearFrom + 100;
  ay := YearOf(ADateTime);
  if (YearFrom <= ay) and (YearTo > ay)
    then Result := True
    else Result := False;
end;

function TDecadesCalendarViewEh.TryDateFromCell(Cell: TGridCoord; var ADateTime: TDateTime): Boolean;
var
  YearFrom, BaseYearFrom: Integer;
  y,m,d,h,mn,s,ms: Word;
  celly: Integer;
begin
  DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);
  BaseYearFrom := y div 10 * 10;
  YearFrom := y div 100 * 100 - 10 + Cell.Y * 4 * 10 + Cell.X * 10;
  celly := y - BaseYearFrom + YearFrom;
  Result := TryEncodeDateTime(Word(celly), m, d, h, mn, s, ms, ADateTime);
end;

function TDecadesCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    TryIncYearEh(ADateTime, 100, Result)
  else
    TryIncYearEh(ADateTime, -100, Result);
end;

procedure TDecadesCalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, 10))
  else
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, -10));
end;

procedure TDecadesCalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, 10*4))
  else
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, -10*4));
end;

function TDecadesCalendarViewEh.GetDateInfoText: String;
var
  YearFrom: Integer;
begin
  YearFrom := YearOf(DateTime) div 100 * 100;
  Result := IntToStr(YearFrom) + '-' + IntToStr(YearFrom + 99);
end;

procedure TDecadesCalendarViewEh.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
end;

procedure TDecadesCalendarViewEh.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
end;

{ TYearsCalendarViewEh }

constructor TYearsCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
  FixedColCount := 0;
  FixedRowCount := 0;
  ColCount := 4;
  RowCount := 3;
  DateTime := Now();
end;

destructor TYearsCalendarViewEh.Destroy;
begin

  inherited Destroy;
end;

procedure TYearsCalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  Year: Integer;
  y,m,d: Word;
  s: String;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDate(DateTime, y, m, d);
  Year := y div 10 * 10 - 1 + ARow * ColCount + ACol;
  Canvas.Font := Font;
  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);
  SetCellCanvasColors(DrawHotTrack, Year = y);

  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  if (Year = y) then
    CalViewState := CalViewState + [cvdsSelectedEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

  if Year div 10 <> y div 10 then
    Canvas.Font.Color := PaintBuffer.OutsidePeriodCellFontColor;
  s := IntToStr(Year);
  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True)
end;

function TYearsCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    TryIncYearEh(ADateTime, 10, Result)
  else
    TryIncYearEh(ADateTime, -10, Result);
end;

function TYearsCalendarViewEh.TryDateFromCell(Cell: TGridCoord;
  var ADateTime: TDateTime): Boolean;
var
  Year: Integer;
  y,m,d,h,mn,s,ms: Word;
begin
  DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);
  Year := y div 10 * 10 - 1 + Cell.Y * ColCount + Cell.X;
  Result := TryEncodeDateTime(Word(Year), m, d, h, mn, s, ms, ADateTime);
end;

function TYearsCalendarViewEh.GetDateInfoText: String;
var
  YearFrom: Integer;
begin
  YearFrom := YearOf(DateTime) div 10 * 10;
  Result := IntToStr(YearFrom) + '-' + IntToStr(YearFrom + 9);
end;

procedure TYearsCalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, 1))
  else
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, -1));
end;

procedure TYearsCalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, 1*4))
  else
    Calendar.SetDateTimeAnimated(IncYear(Calendar.DateTime, -1*4));
end;

function TYearsCalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
var
  YearFrom, YearTo: Integer;
  cy, ay: Word;
begin
  cy := YearOf(DateTime);
  YearFrom := cy div 10 * 10;
  YearTo := YearFrom + 10;
  ay := YearOf(ADateTime);
  if (YearFrom <= ay) and (YearTo > ay)
    then Result := True
    else Result := False;
end;

{ TMonthsCalendarViewEh }

constructor TMonthsCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
  FixedColCount := 0;
  FixedRowCount := 0;
  ColCount := 4;
  RowCount := 3;
  DateTime := Now();
end;

destructor TMonthsCalendarViewEh.Destroy;
begin

  inherited Destroy;
end;

procedure TMonthsCalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  DrawMonth: Integer;
  y,m,d: Word;
  s: String;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDate(DateTime, y, m, d);
  DrawMonth := ARow * ColCount + ACol + 1;
  Canvas.Font := Font;
  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);
  SetCellCanvasColors(DrawHotTrack, DrawMonth = m);

  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  if (DrawMonth = m) then
    CalViewState := CalViewState + [cvdsSelectedEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

  s := FormatSettings.ShortMonthNames[DrawMonth];

  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True)
end;

function TMonthsCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    TryIncYearEh(ADateTime, 1, Result)
  else
    TryIncYearEh(ADateTime, -1, Result);
end;

function TMonthsCalendarViewEh.TryDateFromCell(Cell: TGridCoord;
var ADateTime: TDateTime): Boolean;
var
  Month: Integer;
  y,m,d,h,mn,s,ms: Word;
begin
  DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);
  Month := Cell.Y * ColCount + Cell.X + 1;
  if d > DaysInAMonth(y, Month) then
    d := DaysInAMonth(y, Month);
  ADateTime := EncodeDateTime(y, Month, d, h, mn, s, ms);
  Result := True;
end;

function TMonthsCalendarViewEh.GetDateInfoText: String;
begin
  Result := IntToStr(YearOf(DateTime));
end;

procedure TMonthsCalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncMonth(Calendar.DateTime, 1))
  else
    Calendar.SetDateTimeAnimated(IncMonth(Calendar.DateTime, -1));
end;

procedure TMonthsCalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncMonth(Calendar.DateTime, 1*4))
  else
    Calendar.SetDateTimeAnimated(IncMonth(Calendar.DateTime, -1*4));
end;

function TMonthsCalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
begin
  if YearOf(DateTime) = YearOf(ADateTime)
    then Result := True
    else Result := False;
end;

{ TDaysCalendarViewEh }

constructor TDaysCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
var
  i: Integer;
begin
  inherited Create(AOwner);
  FixedColCount := 1;
  FixedRowCount := 1;
  ColCount := 8;
  RowCount := 7;
  FFirstWeekDayNum := 0;
  UpdateLocaleInfo;
  FDatesInfoList := TObjectListEh.Create;
  for i := 0 to 7 * 6 - 1 do
    FDatesInfoList.Add(CreateDateInfoItem);
  DateTime := Now();
end;

destructor TDaysCalendarViewEh.Destroy;
var
  i: Integer;
begin
  for i := 0 to 7 * 6 - 1 do
  begin
    FreeObjectEh(FDatesInfoList[i]);
    FDatesInfoList[i] := nil;
  end;
  FreeAndNil(FDatesInfoList);
  inherited Destroy;
end;

function TDaysCalendarViewEh.CreateDateInfoItem: TDaysCalendarViewDayInfoItem;
begin
  Result := Calendar.CreateDaysViewDayInfoItem;
end;

procedure TDaysCalendarViewEh.DateChanged;
begin
  inherited DateChanged;
  FStartDate := AdjustDateToStartForGrid(FDate);
  UpdateDatesInfo;
end;

procedure TDaysCalendarViewEh.ResizeCells;
var
  i: Integer;
  cw, rest, fix: Integer;
  ww: Integer;
begin
  if not HandleAllocated then Exit;

  SetPaintBuffer;
  Canvas.Font := Font;
  ww := Canvas.TextWidth('000');
  ColWidths[0] := ww;

  cw := (ClientWidth - ww) div (ColCount - 1);
  rest := (ClientWidth - ww) mod (ColCount - 1);
  for i := 1 to ColCount-1 do
  begin
    if rest > i
      then fix := 1
      else fix := 0;
    ColWidths[i] := cw + fix;
  end;

  cw := ClientHeight div RowCount;
  rest := ClientHeight mod RowCount;
  for i := 0 to RowCount-1 do
  begin
    if rest > i
      then fix := 1
      else fix := 0;
    RowHeights[i] := cw + fix;
  end;
end;

procedure TDaysCalendarViewEh.DrawWeekDayNameCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  DNum: Integer;
  DName: String;
  LineRect: TRect;
  MonDNum: Integer;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := PaintBuffer.NormalCellBrushColor;
  Canvas.Font.Color := PaintBuffer.NormalCellFontColor;
  Canvas.FillRect(ARect);
  if ACol > 0 then
  begin
    Canvas.Pen.Color := PaintBuffer.InsideHorzFrameColor;
    LineRect := ARect;
    LineRect.Bottom := LineRect.Bottom - 1;
    if ACol = FixedColCount then
      LineRect.Left := LineRect.Left + Round(RectWidth(LineRect) * 0.15);
    if ACol = ColCount-1 then
      LineRect.Right := LineRect.Right - Round(RectWidth(LineRect) * 0.15);

    Canvas.Polyline([Point(LineRect.Left, LineRect.Bottom), Point(LineRect.Right, LineRect.Bottom)]);
    ARect.Bottom := ARect.Bottom - 1;

    DNum := (ACol-1) + FFirstWeekDayNum + 2;
    if DNum > 7 then DNum := DNum - 7;
    MonDNum := DNum - 2;
    if MonDNum < 0 then MonDNum := MonDNum + 7;

    DName := FormatSettings.ShortDayNames[DNum];

    if EhLibManager.DateTimeCalendarPickerHighlightHolidays and
       not (TWeekDayEh(MonDNum) in EhLibManager.WeekWorkingDays)
    then
      Canvas.Font.Color := PaintBuffer.HolidayFontColor;

    WriteTextEh(Canvas, ARect, False, 0, 0, DName, taCenter, tlCenter, True, False, 0, 0, False, True);
  end;
end;

procedure TDaysCalendarViewEh.DrawWeekDayNumCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  DrawDate: TDateTime;
  s: String;
  AddDats: Integer;
  LineRect: TRect;
begin
  Canvas.Brush.Color := PaintBuffer.NormalCellBrushColor;
  Canvas.FillRect(ARect);

  Canvas.Pen.Color := PaintBuffer.InsideVertFrameColor;

  LineRect := ARect;
  LineRect.Right := LineRect.Right - 1;
  if ARow = FixedRowCount then
    LineRect.Top := LineRect.Top + Round(RectHeight(LineRect) * 0.25);
  if ARow = RowCount-1 then
    LineRect.Bottom := LineRect.Bottom - Round(RectHeight(LineRect) * 0.25);

  Canvas.Polyline([Point(LineRect.Right, LineRect.Top), Point(LineRect.Right, LineRect.Bottom)]);
  ARect.Right := ARect.Right - 1;

  Canvas.Font := Calendar.PaintBuffer.CalendarWeekNoFont;
  Canvas.Font.Color := PaintBuffer.NormalCellFontColor;

  AddDats := 7 * (ARow-1);
  DrawDate := FStartDate + AddDats;
  if DrawDate <= MaxDateTime then
    s := IntToStr(WeekOfTheYear(DrawDate))
  else
    s := '';

  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True);
end;

procedure TDaysCalendarViewEh.DrawDayNumCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  DrawDate: TDateTime;
  y,m,d: Word;
  s: String;
  AddDats: Integer;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDate(DateTime, y, m, d);

  AddDats := 7 * (ARow-1) + (ACol-1);
  DrawDate := FStartDate + AddDats;
  s := FormatDateTime('D', DrawDate);

  Canvas.Font := Font;
  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);
  SetCellCanvasColors(DrawHotTrack, DateOf(DrawDate) = DateOf(DateTime));

  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  if (DateOf(DrawDate) = DateOf(DateTime)) then
    CalViewState := CalViewState + [cvdsSelectedEh];
  if DateOf(Now) = DateOf(DrawDate) then
    CalViewState := CalViewState + [cvdsNowEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

  if EhLibManager.DateTimeCalendarPickerHighlightHolidays and
     TDaysCalendarViewDayInfoItem(FDatesInfoList[AddDats]).IsHoliday
  then
  begin
    if DateOf(DrawDate) = DateOf(DateTime) then
      Canvas.Font.Color := PaintBuffer.HolidaySelectedFontColor
    else if MonthOf(DateTime) = MonthOf(DrawDate) then
      Canvas.Font.Color := PaintBuffer.HolidayFontColor
    else
      Canvas.Font.Color := PaintBuffer.HolidayOutsidePeriodFontColor;
  end else if MonthOf(DateTime) <> MonthOf(DrawDate) then
    Canvas.Font.Color := PaintBuffer.OutsidePeriodCellFontColor;

  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True);
end;

procedure TDaysCalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
begin
  if ARow = 0 then
    DrawWeekDayNameCell(ACol, ARow, ARect, State)
  else if ACol = 0 then
    DrawWeekDayNumCell(ACol, ARow, ARect, State)
  else
    DrawDayNumCell(ACol, ARow, ARect, State);
end;

procedure TDaysCalendarViewEh.GetAutoSizeData(var NewWidth, NewHeight: Integer);
var
  OneLineHeight, OneColWidth: Integer;
  ShWeekW, MaxShWeekW: Integer;
  i: Integer;
  SpaceW: Integer;
begin
  if not HandleAllocated then Exit;

  Canvas.Font := Font;
  OneLineHeight := Canvas.TextHeight('Wg');
  NewHeight := OneLineHeight * RowCount;

  OneColWidth := Canvas.TextWidth('0000');
  SpaceW := Canvas.TextWidth(' ');

  MaxShWeekW := 0;
  for i := 1 to 7 do
  begin
    ShWeekW := Canvas.TextWidth(FormatSettings.ShortDayNames[i]) + SpaceW*2;
    if ShWeekW > MaxShWeekW then
      MaxShWeekW := ShWeekW;
  end;
  if MaxShWeekW > OneColWidth then
    OneColWidth := MaxShWeekW;

  NewWidth := OneColWidth * ColCount;
end;

function TDaysCalendarViewEh.TryDateFromCell(Cell: TGridCoord;
  var ADateTime: TDateTime): Boolean;
var
  AddDats: Integer;
begin
  Result := False;
  if (Cell.Y > 0) and (Cell.X > 0) then
  begin
    AddDats := 7 * (Cell.Y-1) + (Cell.X-1);
    ADateTime := IncDay(FStartDate, + AddDats) + TimeOf(DateTime);
    if (ADateTime >= MinDateTime) and (ADateTime <= MaxDateTime) then
      Result := True;
  end;
end;

function TDaysCalendarViewEh.GetDateInfoText: String;
begin
  Result := FormatDateTime('MMMM YYYY', DateTime);
end;

function TDaysCalendarViewEh.AdjustDateToStartForGrid(ADateTime: TDateTime): TDateTime;
begin
  Result := StartOfTheWeek(StartOfTheMonth(ADateTime));
  if FFirstWeekDayNum > 0 then
    Result := Result + FFirstWeekDayNum - 7;
end;

function TDaysCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    TryIncMonthEh(ADateTime, 1, Result)
  else
    TryIncMonthEh(ADateTime, -1, Result);
end;

function TDaysCalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
begin
  if StartOfTheMonth(ADateTime) = StartOfTheMonth(DateTime)
    then Result := True
    else Result := False;
end;

{$IFDEF FPC}
{$ELSE}
procedure TDaysCalendarViewEh.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  UpdateLocaleInfo;
  DateChanged;
  Invalidate;
end;
{$ENDIF}

procedure TDaysCalendarViewEh.CMStlyeChange(var Message: TMessage);
begin
  inherited;
  UpdateLocaleInfo;
  DateChanged;
  Invalidate;
end;

procedure TDaysCalendarViewEh.UpdateDatesInfo;
var
  i: Integer;
  ADate: TDateTime;
begin
  for i := 0 to FDatesInfoList.Count-1 do
  begin
    ADate := IncDay(StartDate, i);
    Calendar.UpdateDaysViewDayInfoItem(
      TDaysCalendarViewDayInfoItem(FDatesInfoList[i]),
      ADate);
  end;
end;

procedure TDaysCalendarViewEh.UpdateLocaleInfo;
var
  DOWFlag: Integer;
begin
  DOWFlag := FirstDayOfWeekEh();
  if FFirstWeekDayNum <> DOWFlag then
  begin
    FFirstWeekDayNum := DOWFlag;
    FStartDate := AdjustDateToStartForGrid(FDate);
  end;
  Invalidate;
end;

procedure TDaysCalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncDay(Calendar.DateTime, 1))
  else
    Calendar.SetDateTimeAnimated(IncDay(Calendar.DateTime, -1));
end;

procedure TDaysCalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncWeek(Calendar.DateTime, 1))
  else
    Calendar.SetDateTimeAnimated(IncWeek(Calendar.DateTime, -1));
end;

{ TTimeUnitCalendarViewEh }

constructor TTimeUnitCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
end;

destructor TTimeUnitCalendarViewEh.Destroy;
begin

  inherited Destroy;
end;

procedure TTimeUnitCalendarViewEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        Calendar.SelectView(Calendar.FTimeView, False, True);
        if not (ssCtrl in Shift) then
          Calendar.FTimeView.SelectNextRegion(True);
        Key := 0;
      end;
  end;
  inherited KeyDown(Key, Shift);
end;

function TTimeUnitCalendarViewEh.SelectNextView(MoveForward,
  Animated: Boolean): Boolean;
begin
  if MoveForward then
    Result := False
  else
  begin
    Calendar.SelectView(Calendar.FTimeView, MoveForward, Animated);
    Result := True;
  end;
end;

procedure TTimeUnitCalendarViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
end;

{ THours24CalendarViewEh }

constructor THours24CalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
  FixedColCount := 0;
  FixedRowCount := 0;
  ColCount := 8;
  RowCount := 3;
  DateTime := Now();
  SelectNextViewOnClick := False;
end;

destructor THours24CalendarViewEh.Destroy;
begin
  inherited Destroy;
end;

procedure THours24CalendarViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if Button = mbLeft then
    if cdtuMinuteEh in Calendar.TimeUnits then
    begin
      if not (cdtuSecondEh in Calendar.TimeUnits) then
        Calendar.SelectView(Calendar.FMinutesView, True, True)
      else
        Calendar.SelectView(Calendar.FTimeView, False, True);
    end else if cdtuSecondEh in Calendar.TimeUnits then
    begin
      Calendar.SelectView(Calendar.FTimeView, False, True)
    end else
     Calendar.SelectView(Calendar.FTimeView, False, True)
  else if Button = mbRight then
    Calendar.SelectView(Calendar.FTimeView, False, True);
end;

procedure THours24CalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  DrawHour: Integer;
  y,m,d,h,mn,sec,ms: Word;
  s: String;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDateTime(DateTime, y, m, d, h, mn, sec, ms);
  DrawHour := ARow * ColCount + ACol;
  Canvas.Font := Font;
  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);

  SetCellCanvasColors(DrawHotTrack, DrawHour = h);
  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  if (DrawHour = h) then
    CalViewState := CalViewState + [cvdsSelectedEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

  s := FormatFloat('0', DrawHour);

  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True)
end;

function THours24CalendarViewEh.TryDateFromCell(Cell: TGridCoord;
  var ADateTime: TDateTime): Boolean;
var
  Hour: Integer;
  y,m,d,h,mn,s,ms: Word;
begin
  DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);
  Hour := Cell.Y * ColCount + Cell.X;
  ADateTime := EncodeDateTime(y, m, d, Hour, mn, s, ms);
  Result := True;
end;

function THours24CalendarViewEh.GetDateInfoText: String;
begin
  Result := DateToStr(DateTime);
end;

function THours24CalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    Result := IncDay(ADateTime, 1)
  else
    Result := IncDay(ADateTime, -1);
end;

function THours24CalendarViewEh.ShowTodayInfo: Boolean;
begin
  Result := False;
end;

function THours24CalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
begin
  if DateOf(ADateTime) = DateOf(DateTime)
    then Result := True
    else Result := False;
end;

procedure THours24CalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncHour(Calendar.DateTime, 1))
  else
    Calendar.SetDateTimeAnimated(IncHour(Calendar.DateTime, -1));
end;

procedure THours24CalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncHour(Calendar.DateTime, 8))
  else
    Calendar.SetDateTimeAnimated(IncHour(Calendar.DateTime, -8));
end;

{ THours12CalendarViewEh }

constructor THours12CalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
  RowCount := 6;
  ColCount := 6;
end;

destructor THours12CalendarViewEh.Destroy;
begin

  inherited Destroy;
end;

procedure THours12CalendarViewEh.Paint;
begin
  FRow0Drawn := False;
  FRow3Drawn := False;
  inherited Paint;
end;

procedure THours12CalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  subtr: Integer;
  s: String;
  d: Integer;
  DrawHour: Integer;
  h, dh: Word;
  hm: Integer;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
  i: Integer;
  Cell0Rect: TRect;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  if (ARow in [0, 3]) then
  begin
    SetCellCanvasColors(False, False);
    if (ACol = 0) then
    begin
      if (ARow = 0)
        then s := 'AM'
        else s := 'PM';
      for i := 1 to 5 do
        ARect.Right := ARect.Right + ColWidths[i];
      WriteTextEh(Canvas, ARect, True, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True);
      FRow0Drawn := True;
      FRow3Drawn := True;
    end else
    begin
      if (ARow = 0) and FRow0Drawn then
        Exit
      else if (ARow = 3) and FRow3Drawn then
        Exit;
      Cell0Rect := CellRect(0, ARow);
      DrawCell(0, ARow, Cell0Rect, State);
    end;
  end else
  begin
    if ARow > 3 then
    begin
      subtr := 4;
      hm := 12;
    end else
    begin
      subtr := 1;
      hm := 0;
    end;
    h := HourOf(DateTime);
    dh := ((ARow - subtr) * 6 + ACol);
    if dh = 0
      then d := 12
      else d := dh;

    DrawHour := dh + hm;
    Canvas.Font := Font;
    DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);

    SetCellCanvasColors(DrawHotTrack, DrawHour = h);
    CalViewState := [];
    if DrawHotTrack then
      CalViewState := CalViewState + [cvdsHotTrackEh];
    if (DrawHour = h) then
      CalViewState := CalViewState + [cvdsSelectedEh];
    Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

    s := FormatFloat('0', DrawHour);

    s := IntToStr(d);
    WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True)
  end;
end;

procedure THours12CalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
begin
  if MoveForward then
    Calendar.SetDateTimeAnimated(IncHour(Calendar.DateTime, 6))
  else
    Calendar.SetDateTimeAnimated(IncHour(Calendar.DateTime, -6));
end;

function THours12CalendarViewEh.TryDateFromCell(Cell: TGridCoord;
  var ADateTime: TDateTime): Boolean;
var
  y,m,d,h,mn,s,ms: Word;
  subtr: Integer;
  hm: Integer;
  Hour: Integer;
begin
  DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);

  if (Cell.Y in [1,2,4,5]) then
  begin
    if Cell.Y > 3 then
    begin
      subtr := 4;
      hm := 12;
    end else
    begin
      subtr := 1;
      hm := 0;
    end;
    Hour := ((Cell.Y - subtr) * 6 + Cell.X) + hm;
    ADateTime := EncodeDateTime(y, m, d, Hour, mn, s, ms);
    Result := True;
  end else
    Result := False;
end;

procedure THours12CalendarViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  TmpDateTime: TDateTime;
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if (Button = mbLeft) and TryDateFromCell(Cell, TmpDateTime) then
    if cdtuMinuteEh in Calendar.TimeUnits then
      Calendar.SelectView(Calendar.FMinutesView, True, True)
    else if cdtuSecondEh in Calendar.TimeUnits then
      Calendar.SelectView(Calendar.FSecondsView, True, True)
    else
     Calendar.SelectView(Calendar.FTimeView, False, True)
  else if Button = mbRight then
    Calendar.SelectView(Calendar.FTimeView, False, True);
 end;

{ TMinutesCalendarViewEh }

constructor TMinutesCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
  FixedColCount := 0;
  FixedRowCount := 0;
  ColCount := 4;
  RowCount := 3;
  DateTime := Now();
  SelectNextViewOnClick := False;
end;

destructor TMinutesCalendarViewEh.Destroy;
begin
  inherited Destroy;
end;

procedure TMinutesCalendarViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if Button = mbLeft then
    if cdtuSecondEh in Calendar.TimeUnits then
    begin
      Calendar.SelectView(Calendar.FTimeView, False, True);
    end else
     Calendar.SelectView(Calendar.FTimeView, False, True)
  else if Button = mbRight then
    Calendar.SelectView(Calendar.FTimeView, False, True);
end;

procedure TMinutesCalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  DrawMinute: Integer;
  y,m,d,h,mn,sec,ms: Word;
  s: String;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDateTime(DateTime, y, m, d, h, mn, sec, ms);

  DrawMinute := (ARow * ColCount + ACol) * 5;
  Canvas.Font := Font;
  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);

  SetCellCanvasColors(DrawHotTrack, DrawMinute = mn);
  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  if (DrawMinute = mn) then
    CalViewState := CalViewState + [cvdsSelectedEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

  s := FormatFloat('00', DrawMinute);

  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True)
end;

function TMinutesCalendarViewEh.TryDateFromCell(Cell: TGridCoord;
  var ADateTime: TDateTime): Boolean;
var
  Minute: Integer;
  y,m,d,h,mn,s,ms: Word;
begin
  DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);
  Minute := (Cell.Y * ColCount + Cell.X) * 5;
  ADateTime := EncodeDateTime(y, m, d, h, Minute, s, ms);
  Result := True;
end;

function TMinutesCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    Result := IncHour(ADateTime, 1)
  else
    Result := IncHour(ADateTime, -1);
end;

function TMinutesCalendarViewEh.ShowTodayInfo: Boolean;
begin
  Result := False;
end;

function TMinutesCalendarViewEh.GetDateInfoText: String;
begin
  Result := DateToStr(DateTime) + ' ' + FormatDateTime('HH', DateTime) + ':(M)';
end;

function TMinutesCalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
begin
  if (DateOf(ADateTime) = DateOf(DateTime)) and
     (HourOf(ADateTime) = HourOf(DateTime))
    then Result := True
    else Result := False;
end;

procedure TMinutesCalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
var
  NewValue: TDateTime;
begin
  if MoveForward then
    NewValue := IncMinute(Calendar.DateTime, 5)
  else
    NewValue := IncMinute(Calendar.DateTime, -5);
  Calendar.SetDateTimeAnimated(RoundTo5(NewValue));
end;

procedure TMinutesCalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
var
  NewValue: TDateTime;
begin
  if MoveForward then
    NewValue := IncMinute(Calendar.DateTime, 5*4)
  else
    NewValue := IncMinute(Calendar.DateTime, -5*4);
  Calendar.SetDateTimeAnimated(RoundTo5(NewValue));
end;

function TMinutesCalendarViewEh.RoundTo5(Value: TDateTime): TDateTime;
var
  FiveMinUnit: Integer;
begin
  FiveMinUnit := MinuteOf(Value);
  FiveMinUnit := Round(FiveMinUnit / 60 * 12) * 5;
  Result := RecodeMinute(Value, FiveMinUnit);
end;

{ TSecondsCalendarViewEh }

constructor TSecondsCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
end;

destructor TSecondsCalendarViewEh.Destroy;
begin
  inherited Destroy;
end;

procedure TSecondsCalendarViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  Calendar.SelectView(Calendar.FTimeView, False, True);
end;

procedure TSecondsCalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  DrawSec: Integer;
  y,m,d,h,mn,sec,ms: Word;
  s: String;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDateTime(DateTime, y, m, d, h, mn, sec, ms);

  DrawSec := (ARow * ColCount + ACol) * 5;
  Canvas.Font := Font;
  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);

  SetCellCanvasColors(DrawHotTrack, DrawSec = sec);
  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  if (DrawSec = sec) then
    CalViewState := CalViewState + [cvdsSelectedEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

  s := FormatFloat('00', DrawSec);

  WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True)
end;

function TSecondsCalendarViewEh.TryDateFromCell(Cell: TGridCoord;
  var ADateTime: TDateTime): Boolean;
var
  Sec: Integer;
  y,m,d,h,mn,s,ms: Word;
begin
  DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);
  Sec := (Cell.Y * ColCount + Cell.X) * 5;
  ADateTime := EncodeDateTime(y, m, d, h, mn, Sec, ms);
  Result := True;
end;

function TSecondsCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    Result := IncMinute(ADateTime, 1)
  else
    Result := IncMinute(ADateTime, -1);
end;

function TSecondsCalendarViewEh.GetDateInfoText: String;
begin
  Result := DateToStr(DateTime) + ' ' + FormatDateTime('HH:NN', DateTime) + ':(S)';
end;

procedure TSecondsCalendarViewEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
end;

procedure TSecondsCalendarViewEh.MoveToNextHorzDateTime(MoveForward: Boolean);
var
  NewValue: TDateTime;
begin
  if MoveForward then
    NewValue := IncSecond(Calendar.DateTime, 5)
  else
    NewValue := IncSecond(Calendar.DateTime, -5);
  Calendar.SetDateTimeAnimated(RoundTo5(NewValue));
end;

procedure TSecondsCalendarViewEh.MoveToNextVertDateTime(MoveForward: Boolean);
var
  NewValue: TDateTime;
begin
  if MoveForward then
    NewValue := IncSecond(Calendar.DateTime, 5*4)
  else
    NewValue := IncSecond(Calendar.DateTime, -5*4);
  Calendar.SetDateTimeAnimated(RoundTo5(NewValue));
end;

function TSecondsCalendarViewEh.DateInViewRange(ADateTime: TDateTime): Boolean;
begin
  if (DateOf(ADateTime) = DateOf(DateTime)) and
     (HourOf(ADateTime) = HourOf(DateTime)) and
     (MinuteOf(ADateTime) = MinuteOf(DateTime))
    then Result := True
    else Result := False;
end;

function TSecondsCalendarViewEh.RoundTo5(Value: TDateTime): TDateTime;
var
  FiveMinUnit: Integer;
begin
  FiveMinUnit := SecondOf(Value);
  FiveMinUnit := Round(FiveMinUnit / 60 * 12) * 5;
  Result := RecodeSecond(Value, FiveMinUnit);
end;

{ TTimeCalendarViewEh }

constructor TTimeCalendarViewEh.Create(AOwner: TDateTimeCalendarPickerEh);
var
  p: TTimeCalendarViewActiveRegionProc;
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csDoubleClicks];
  GetHoursTimeFormat({SysLocale.DefaultLCID, }FHoursFormat, FAmPmPos);
  ResetGrid;
  FSelectNextViewOnClick := False;

  FPopupList := TPopupListboxEh.Create(Self);
  FPopupList.Visible := False;
  {$IFDEF FPC}
  {$ELSE}
  FPopupList.Ctl3D := False;
  FPopupList.ParentCtl3D := False;
  {$ENDIF}
  {$IFDEF FPC}
  {$ELSE}
  FPopupList.Parent := Self; 
  {$ENDIF}
  FPopupList.SizeGripAlwaysShow := False;
  FPopupList.ItemAlignment := taCenter;
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  if FPopupList.HandleAllocated then
    ShowWindow(FPopupList.Handle, SW_HIDE); 
  {$ENDIF}
  FPopupList.OnMouseUp := PopupListMouseUp;

  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerEvent;

  FRegionProcList := TList.Create;
  p := HoursRegionAction;
  FRegionProcList.Add(Pointer(@p));
  p := MinutesRegionAction;
  FRegionProcList.Add(Pointer(@p));
  p := SecondsRegionAction;
  FRegionProcList.Add(Pointer(@p));
  p := OKButtonRegionAction;
  FRegionProcList.Add(Pointer(@p));
  FActiveRegion := tcarHoursEh;
end;

destructor TTimeCalendarViewEh.Destroy;
begin
  FreeAndNil(FPopupList);
  FreeAndNil(FTimer);
  FreeAndNil(FRegionProcList);
  inherited Destroy;
end;

function TTimeCalendarViewEh.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := DoMouseWheelEvent(Shift, MousePos, True);
end;

function TTimeCalendarViewEh.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := DoMouseWheelEvent(Shift, MousePos, False);
end;

function TTimeCalendarViewEh.DoMouseWheelEvent(Shift: TShiftState;
  MousePos: TPoint; DirectionUp: Boolean): Boolean;
var
  CliMousePos: TPoint;
  Cell: TGridCoord;
  DirectionStep: Integer;
begin
  CliMousePos := ScreenToClient(MousePos);
  Cell := MouseCoord(CliMousePos.X, CliMousePos.Y);
  if DirectionUp
    then DirectionStep := 1
    else DirectionStep := -1;
  if FColTypes[Cell.X] = tcvctHourEh then
    IncrementHour(DirectionStep)
  else if FColTypes[Cell.X] = tcvctMinuteEh then
    IncrementMinute(DirectionStep)
  else if FColTypes[Cell.X] = tcvctSecondEh then
    IncrementSecond(DirectionStep);
  Result := True;
end;

function TTimeCalendarViewEh.GetDateInfoText: String;
begin
  Result := DateToStr(DateTime);
end;

function TTimeCalendarViewEh.GetNextPeriodDate(ADateTime: TDateTime;
  MoveForward: Boolean): TDateTime;
begin
  if MoveForward then
    Result := IncDay(ADateTime, 1)
  else
    Result := IncDay(ADateTime, -1);
end;

procedure TTimeCalendarViewEh.IncrementHour(N: Integer);
var
  hor: Integer;
begin
  hor := HourOf(DateTime);
  if (hor + N > 23) then
    Calendar.DateTime := IncHour(Calendar.DateTime, -hor)
  else if (hor + N < 0) then
    Calendar.DateTime := IncHour(Calendar.DateTime, 24 + N)
  else if (N > 0) then
    Calendar.DateTime := IncHour(Calendar.DateTime, N)
  else if (N < 0)then
    Calendar.DateTime := IncHour(Calendar.DateTime, N);
end;

procedure TTimeCalendarViewEh.IncrementMinute(N: Integer);
var
  min: Integer;
begin
  min := MinuteOf(DateTime);
  if (min + N > 59)then
    Calendar.DateTime := IncMinute(Calendar.DateTime, -min)
  else if (min + N < 0) then
    Calendar.DateTime := IncMinute(Calendar.DateTime, 59)
  else if  (N > 0) then
    Calendar.DateTime := IncMinute(Calendar.DateTime, 1)
  else if (N < 0)then
    Calendar.DateTime := IncMinute(Calendar.DateTime, -1);
end;

procedure TTimeCalendarViewEh.IncrementSecond(N: Integer);
var
  sec: Integer;
begin
  sec := SecondOf(DateTime);
  if (sec + N > 59)then
    Calendar.DateTime := IncSecond(Calendar.DateTime, -sec)
  else if (sec + N < 0) then
    Calendar.DateTime := IncSecond(Calendar.DateTime, 59)
  else if  (N > 0) then
    Calendar.DateTime := IncSecond(Calendar.DateTime, 1)
  else if (N < 0)then
    Calendar.DateTime := IncSecond(Calendar.DateTime, -1);
end;

procedure TTimeCalendarViewEh.SetActiveRegion(
  const Value: TTimeCalendarViewActiveRegionEh);

  function FindCol(Value: TTimeCalendarViewColTypeEh): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 0 to Length(FColTypes)-1 do
      if FColTypes[i] = Value then
      begin
        Result := i;
        Exit;
      end;
  end;

var
  ACol: Integer;
begin
  if FActiveRegion <> Value then
  begin
    FActiveRegion := Value;
    case FActiveRegion of
      tcarHoursEh:
      begin
        ACol := FindCol(tcvctHourEh);
        FocusCell(ACol, 2, True);
      end;
      tcarMinutesEh:
      begin
        ACol := FindCol(tcvctMinuteEh);
        FocusCell(ACol, 2, True);
      end;
      tcarSecondsEh:
      begin
        ACol := FindCol(tcvctSecondEh);
        FocusCell(ACol, 2, True);
      end;
      tcarOKButtonEh:
      begin
        Row := 5;
      end;
    end;
  end;
end;

procedure TTimeCalendarViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  y,m,d,h,mn,sec,ms: Word;
  s: String;
  DrawText: Boolean;
  DrawHotTrack: Boolean;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  DecodeDateTime(DateTime, y, m, d, h, mn, sec, ms);

  DrawHotTrack := (gdHotTrack in State) and (Calendar.InputMethod = iimMouseEh);
  if DrawHotTrack and
     (
       ((FColTypes[ACol] in [tcvctHourEh,tcvctMinuteEh,tcvctSecondEh]) and (ARow in [1,2,3])) or
       ((ACol = FOkButtonCol) and (ARow = 5))
     )
  then
  else
    DrawHotTrack := False;

  s := '';
  DrawText := True;
  if ARow = 2 then
  begin
    case FColTypes[ACol] of
      tcvctHourEh:
        begin
          if AmPm12 then
          begin
            s := FormatDateTime('h AMPM', DateTime);
            if s[2] = ' '
              then s := Copy(s, 1, 1)
              else s := Copy(s, 1, 2);
          end else
            s := FormatFloat('0', h);
          if (Calendar.InputMethod = iimKeyboardEh) and (FActiveRegion = tcarHoursEh) then
            DrawHotTrack := True;
        end;
      tcvctColonEh:
        s := ':';
      tcvctMinuteEh:
        begin
          s := FormatFloat('00', mn);
          if (Calendar.InputMethod = iimKeyboardEh) and (FActiveRegion = tcarMinutesEh) then
            DrawHotTrack := True;
        end;
      tcvctSecondEh:
        begin
          s := FormatFloat('00', sec);
          if (Calendar.InputMethod = iimKeyboardEh) and (FActiveRegion = tcarSecondsEh) then
            DrawHotTrack := True;
        end;
      tcvctAmPmEh:
        begin
          s := FormatDateTime('AMPM', DateTime);
        end;
    end;
  end else if (ACol = FOkButtonCol) and (ARow = 5) then
  begin
    s := 'OK';
    if (Calendar.InputMethod = iimKeyboardEh) and (FActiveRegion = tcarOKButtonEh) then
      DrawHotTrack := True;
  end;

  SetCellCanvasColors(DrawHotTrack, False);
  CalViewState := [];
  if DrawHotTrack then
    CalViewState := CalViewState + [cvdsHotTrackEh];
  Style.DrawCalendarViewCellBackgraund(Self, Canvas, ARect, CalViewState);

  if (ARow = 1) and
     (FColTypes[ACol] in [tcvctHourEh, tcvctMinuteEh, tcvctSecondEh]) then
  begin
    PaintRow(ARect, True);
    DrawText := False;
  end else if (ARow = 3) and
              (FColTypes[ACol] in [tcvctHourEh, tcvctMinuteEh, tcvctSecondEh]) then
  begin
    PaintRow(ARect, False);
    DrawText := False;
  end;

  if DrawText then
    WriteTextEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, True, False, 0, 0, False, True);
end;

procedure TTimeCalendarViewEh.PaintRow(ARect: TRect; UpRow: Boolean);
var
  ArrawRect: TRect;
  BF: Integer;
begin
  ArrawRect := Rect(0,0,7,4);
  ArrawRect := CenteredRect(ARect, ArrawRect);
  Canvas.Pen.Color := StyleServices.GetSystemColor(clWindowText);
  if UpRow then
  begin
    BF := -1;
    ArrawRect.Top := ArrawRect.Bottom;
  end else
  begin
    BF := 1;
  end;

  Canvas.Polyline([Point(ArrawRect.Left, ArrawRect.Top), Point(ArrawRect.Right, ArrawRect.Top)]);
  Canvas.Polyline([Point(ArrawRect.Left+1, ArrawRect.Top+1*BF), Point(ArrawRect.Right-1, ArrawRect.Top+1*BF)]);
  Canvas.Polyline([Point(ArrawRect.Left+2, ArrawRect.Top+2*BF), Point(ArrawRect.Right-2, ArrawRect.Top+2*BF)]);
  Canvas.Polyline([Point(ArrawRect.Left+3, ArrawRect.Top+3*BF), Point(ArrawRect.Right-3, ArrawRect.Top+3*BF)]);
end;

procedure TTimeCalendarViewEh.ResetGrid;
begin
  FixedColCount := 0;
  FixedRowCount := 0;

  RowCount := 6;

  if ([cdtuHourEh, cdtuMinuteEh, cdtuSecondEh] * Calendar.TimeUnits =
      [cdtuHourEh, cdtuMinuteEh, cdtuSecondEh]) then
  begin
    if AmPm12 then
    begin
      ColCount := 9;
      FOkButtonCol := 7;
    end else
    begin
      ColCount := 7;
      FOkButtonCol := 5;
    end;
  end else if ([cdtuHourEh, cdtuMinuteEh, cdtuSecondEh] * Calendar.TimeUnits =
               [cdtuHourEh, cdtuMinuteEh]) then
  begin
    if AmPm12 then
    begin
      ColCount := 6;
      FOkButtonCol := 4;
    end else
    begin
      ColCount := 7;
      FOkButtonCol := 5;
    end;
  end else if ([cdtuHourEh, cdtuMinuteEh, cdtuSecondEh] * Calendar.TimeUnits =
               [cdtuHourEh]) then
  begin
    if AmPm12 then
    begin
      ColCount := 6;
      FOkButtonCol := 4;
    end else
    begin
      ColCount := 7;
      FOkButtonCol := 5;
    end;
  end;

  ResizeCells;
end;

procedure TTimeCalendarViewEh.ResizeCells;
var
  i, HalfCols: Integer;
  cw, cwHalf, rest, fix: Integer;
  ex, exw: Integer;
  ch: Integer;
begin

  if not HandleAllocated then Exit;
  Canvas.Font := Font;

  if ([cdtuHourEh, cdtuMinuteEh, cdtuSecondEh] * Calendar.TimeUnits =
      [cdtuHourEh, cdtuMinuteEh, cdtuSecondEh]) then
  begin
    cwHalf := Canvas.TextWidth('00');
    HalfCols := (ColCount+1) div 2;

    for i := 0 to ColCount-1 do
    begin
      if i mod 2 = 0 then
        ColWidths[i] := cwHalf;
    end;

    cw := (ClientWidth - cwHalf * HalfCols) div (ColCount-HalfCols);
    rest := (ClientWidth - cwHalf * HalfCols) mod (ColCount-HalfCols);

    for i := 0 to ColCount-1 do
    begin
      if i mod 2 = 1 then
      begin
        if rest > i
          then fix := 1
          else fix := 0;
        ColWidths[i] := cw + fix;
      end;
    end;

    SetLength(FColTypes, ColCount);
    FColTypes[0] := tcvctBlankEh;
    FColTypes[1] := tcvctHourEh;
    FColTypes[2] := tcvctColonEh;
    FColTypes[3] := tcvctMinuteEh;
    FColTypes[4] := tcvctColonEh;
    FColTypes[5] := tcvctSecondEh;
    FColTypes[6] := tcvctBlankEh;

    if AmPm12 then
    begin
      exw := Trunc(cwHalf / 3);
      ColWidths[1] := ColWidths[1] + exw;
      ex := Trunc(cwHalf / 3 + cwHalf / 3);
      exw := ex - exw;
      ColWidths[3] := ColWidths[3] + exw;
      exw := cwHalf - ex;
      ColWidths[5] := ColWidths[5] + exw;
      ColWidths[6] := 0;
      FColTypes[7] := tcvctAmPmEh;
      FColTypes[8] := tcvctBlankEh;
    end;

    SetLength(FVisibleRegions, 4);
    FVisibleRegions[0] := tcarHoursEh;
    FVisibleRegions[1] := tcarMinutesEh;
    FVisibleRegions[2] := tcarSecondsEh;
    FVisibleRegions[3] := tcarOKButtonEh;
  end else if ([cdtuHourEh, cdtuMinuteEh, cdtuSecondEh] * Calendar.TimeUnits =
               [cdtuHourEh, cdtuMinuteEh]) then
  begin
    cwHalf := Canvas.TextWidth('00');

    ColWidths[0] := cwHalf;
    ColWidths[ColCount-1] := cwHalf;

    SetLength(FColTypes, ColCount);

    if AmPm12 then
    begin
      ColWidths[2] := cwHalf;

      cw := (ClientWidth - cwHalf * 3) div (ColCount-3);
      rest := (ClientWidth - cwHalf * 3) mod (ColCount-3);

      for i := 0 to ColCount-1 do
      begin
        if (i in [1,3,4]) then
        begin
          if rest > 0 then
          begin
            fix := 1;
            rest := rest - 1;
          end else
            fix := 0;
          ColWidths[i] := cw + fix;
        end;
      end;

      FColTypes[0] := tcvctBlankEh;
      FColTypes[1] := tcvctHourEh;
      FColTypes[2] := tcvctColonEh;
      FColTypes[3] := tcvctMinuteEh;
      FColTypes[4] := tcvctAmPmEh;
      FColTypes[5] := tcvctBlankEh;
    end else
    begin
      ColWidths[3] := cwHalf;

      cw := (ClientWidth - cwHalf * 3) div (ColCount-3);
      rest := (ClientWidth - cwHalf * 3) mod (ColCount-3);

      for i := 0 to ColCount-1 do
      begin
        if (i in [1,2,4,5]) then
        begin
          if rest > 0 then
          begin
            fix := 1;
            rest := rest - 1;
          end else
            fix := 0;
          ColWidths[i] := cw + fix;
        end;
      end;

      FColTypes[0] := tcvctBlankEh;
      FColTypes[1] := tcvctBlankEh;
      FColTypes[2] := tcvctHourEh;
      FColTypes[3] := tcvctColonEh;
      FColTypes[4] := tcvctMinuteEh;
      FColTypes[5] := tcvctBlankEh;
      FColTypes[6] := tcvctBlankEh;
    end;

    SetLength(FVisibleRegions, 3);
    FVisibleRegions[0] := tcarHoursEh;
    FVisibleRegions[1] := tcarMinutesEh;
    FVisibleRegions[2] := tcarOKButtonEh;
  end else if ([cdtuHourEh, cdtuMinuteEh, cdtuSecondEh] * Calendar.TimeUnits =
               [cdtuHourEh]) then
  begin
    cwHalf := Canvas.TextWidth('00');

    ColWidths[0] := cwHalf;
    ColWidths[ColCount-1] := cwHalf;

    SetLength(FColTypes, ColCount);

    if AmPm12 then
    begin
      cw := (ClientWidth - cwHalf * 2) div (ColCount-2);
      rest := (ClientWidth - cwHalf * 2) mod (ColCount-2);

      for i := 0 to ColCount-1 do
      begin
        if (i in [1,2,3,4]) then
        begin
          if rest > 0 then
          begin
            fix := 1;
            rest := rest - 1;
          end else
            fix := 0;
          ColWidths[i] := cw + fix;
        end;
      end;

      SetLength(FColTypes, ColCount);
      FColTypes[0] := tcvctBlankEh;
      FColTypes[1] := tcvctBlankEh;
      FColTypes[2] := tcvctHourEh;
      FColTypes[3] := tcvctAmPmEh;
      FColTypes[4] := tcvctBlankEh;
      FColTypes[5] := tcvctBlankEh;
    end else
    begin
      ColWidths[2] := cwHalf;
      ColWidths[4] := cwHalf;

      cw := (ClientWidth - cwHalf * 4) div (ColCount-4);
      rest := (ClientWidth - cwHalf * 4) mod (ColCount-4);


      for i := 0 to ColCount-1 do
      begin
        if (i in [1,3,5]) then
        begin
          if rest > 0 then
          begin
            fix := 1;
            rest := rest - 1;
          end else
            fix := 0;
          ColWidths[i] := cw + fix;
        end;
      end;

      SetLength(FColTypes, ColCount);
      FColTypes[0] := tcvctBlankEh;
      FColTypes[1] := tcvctBlankEh;
      FColTypes[2] := tcvctBlankEh;
      FColTypes[3] := tcvctHourEh;
      FColTypes[4] := tcvctBlankEh;
      FColTypes[5] := tcvctBlankEh;
      FColTypes[6] := tcvctBlankEh;
    end;

    SetLength(FVisibleRegions, 2);
    FVisibleRegions[0] := tcarHoursEh;
    FVisibleRegions[1] := tcarOKButtonEh;
  end;

  ch := ClientHeight div RowCount;
  cwHalf := ch div 2;

  ch := ClientHeight div RowCount;
  rest := ClientHeight mod RowCount;

  for i := 0 to RowCount-1 do
  begin
      if rest > i
        then fix := 1
        else fix := 0;
      RowHeights[i] := ch + fix;
  end;

  RowHeights[RowCount-2] := RowHeights[RowCount-2] - cwHalf;
  RowHeights[RowCount-1] := RowHeights[RowCount-1] + cwHalf;

end;

procedure TTimeCalendarViewEh.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  ClosePopupList(False);
end;

{$IFDEF FPC}
{$ELSE}
procedure TTimeCalendarViewEh.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  if (Message.Sender <> FPopupList) then
    ClosePopupList(False);
end;

procedure TTimeCalendarViewEh.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  UpdateLocaleInfo;
end;
{$ENDIF}

procedure TTimeCalendarViewEh.WMCancelMode(var Message: TMessage);
begin
  inherited;
  ClosePopupList(False);
end;

procedure TTimeCalendarViewEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if FPopupList.Visible then
    ClosePopupList(False);
end;

procedure TTimeCalendarViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if Button = mbLeft then
  begin
    if (Cell.X = FOkButtonCol) and (Cell.Y = 5) then
      Calendar.CalendarActionPerformed(dtpcaButtonOKClickedEh)
    else if (FColTypes[Cell.X] = tcvctHourEh) and (Cell.Y = 2) then
    begin
      if AmPm12
        then Calendar.SelectView(Calendar.FHours12View, True, True)
        else Calendar.SelectView(Calendar.FHours24View, True, True);
    end else if (FColTypes[Cell.X] = tcvctMinuteEh) and (Cell.Y = 2) then
      Calendar.SelectView(Calendar.FMinutesView, True, True)
    else if (FColTypes[Cell.X] = tcvctSecondEh) and (Cell.Y = 2) then
      Calendar.SelectView(Calendar.FSecondsView, True, True);
  end else if Button = mbRight then
    Calendar.SelectView(Calendar.FDaysView, False, True);
end;

procedure TTimeCalendarViewEh.CellMouseDown(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseDown(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if Button = mbLeft then
  begin
    if (FColTypes[Cell.X] = tcvctHourEh) and (Cell.Y in [1,3]) then
    begin
      if (Cell.Y = 1) then
      begin
        IncrementHour(1);
        ResetButtonDownTimer(Cell, tcpbtHoursUpEh);
        FActiveRegion := tcarHoursEh;
      end else
      begin
        IncrementHour(-1);
        ResetButtonDownTimer(Cell, tcpbtHoursDownEh);
        FActiveRegion := tcarHoursEh;
      end;
    end else if (FColTypes[Cell.X] = tcvctMinuteEh) and (Cell.Y in [1,3]) then
    begin
      if (Cell.Y = 1) then
      begin
        IncrementMinute(1);
        ResetButtonDownTimer(Cell, tcpbtMinutesUpEh);
        FActiveRegion := tcarMinutesEh;
      end else
      begin
        IncrementMinute(-1);
        ResetButtonDownTimer(Cell, tcpbtMinutesDownEh);
        FActiveRegion := tcarMinutesEh;
      end;
    end else if (FColTypes[Cell.X] = tcvctSecondEh) and (Cell.Y in [1,3]) then
    begin
      if (Cell.Y = 1) then
      begin
        IncrementSecond(1);
        ResetButtonDownTimer(Cell, tcpbtSecondsUpEh);
        FActiveRegion := tcarSecondsEh;
      end else
      begin
        IncrementSecond(-1);
        ResetButtonDownTimer(Cell, tcpbtSecondsDownEh);
        FActiveRegion := tcarSecondsEh;
      end;
    end;
  end;
end;

procedure TTimeCalendarViewEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  ClosePopupList(False);
end;

procedure TTimeCalendarViewEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TTimeCalendarViewEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  StopTimer;
end;

procedure TTimeCalendarViewEh.DropDownPopupList(ScreenPos: TPoint; StartNum, CountNum, Step: Integer);
var
  lw: Integer;
  i: Integer;
begin
  Canvas.Font := Font;
  lw := Canvas.TextWidth('00000000');

  FPopupList.Items.BeginUpdate;
  FPopupList.Items.Clear;
  for i := StartNum to StartNum + CountNum - 1 do
    FPopupList.Items.Add(FormatFloat('00', i*Step));
  FPopupList.Items.EndUpdate;

  FPopupList.Font := Font;
  FPopupList.ItemHeight := Canvas.TextHeight('Wg');
  FPopupList.RowCount := CountNum;
  FPopupList.SetBounds(ScreenPos.X, ScreenPos.Y, lw, FPopupList.Height);
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  SetWindowPos(FPopupList.Handle, HWND_TOP {MOST}, ScreenPos.X, ScreenPos.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  {$ENDIF}
  FPopupList.Visible := True; 
end;

procedure TTimeCalendarViewEh.ClosePopupList(Accept: Boolean);
var
  selv: Integer;
  y,m,d,h,mn,s,ms: Word;
begin
  if not FPopupList.Visible then Exit;

  SetWindowPos(FPopupList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  FPopupList.Visible := False;
  if Accept then
  begin
    selv := StrToInt(FPopupList.Items[FPopupList.ItemIndex]);
    DecodeDateTime(DateTime, y, m, d, h, mn, s, ms);
    if FPopupListKind = tclcHoursEh then
    begin
      Calendar.DateTime := EncodeDateTime(y, m, d, selv, mn, s, ms);
      Calendar.CalendarActionPerformed(dtpcaHourSelectedFromListEh);
    end else if FPopupListKind = tclcMinutesEh then
    begin
      Calendar.DateTime := EncodeDateTime(y, m, d, h, selv, s, ms);
      Calendar.CalendarActionPerformed(dtpcaMinuteSelectedFromListEh);
    end else if FPopupListKind = tclcSecondsEh then
    begin
      Calendar.DateTime := EncodeDateTime(y, m, d, h, mn, selv, ms);
      Calendar.CalendarActionPerformed(dtpcaSecondSelectedFromListEh);
    end;
  end;
end;

procedure TTimeCalendarViewEh.PopupListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ClosePopupList(True);
end;

procedure TTimeCalendarViewEh.ResetButtonDownTimer(Cell: TGridCoord;
  AButtonType: TTimeCalendarViewPressedButtonTypeEh);
begin
  FPressedButtonType := AButtonType;
  FPressedCell := Cell;
  ResetTimer(InitRepeatPause);
end;

procedure TTimeCalendarViewEh.TimerEvent(Sender: TObject);
begin
  if FTimer.Interval = Cardinal(InitRepeatPause) then
    ResetTimer(RepeatPause);
  if (FHotTrackCell.X = FPressedCell.X) and
     (FHotTrackCell.Y = FPressedCell.Y)
  then
  begin
    case FPressedButtonType of
      tcpbtHoursUpEh: IncrementHour(1);
      tcpbtHoursDownEh: IncrementHour(-1);
      tcpbtMinutesUpEh: IncrementMinute(1);
      tcpbtMinutesDownEh: IncrementMinute(-1);
      tcpbtSecondsUpEh: IncrementSecond(1);
      tcpbtSecondsDownEh: IncrementSecond(-1);
    end;
  end;
end;

procedure TTimeCalendarViewEh.ResetTimer(Interval: Cardinal);
begin
  if FTimer.Enabled = False then
  begin
    FTimer.Interval := Interval;
    FTimer.Enabled := True;
  end
  else if Interval <> FTimer.Interval then
  begin
    FTimer.Enabled := False;
    FTimer.Interval := Interval;
    FTimer.Enabled := True;
  end;
end;

procedure TTimeCalendarViewEh.StopTimer;
begin
  FTimer.Enabled := False;
end;

procedure TTimeCalendarViewEh.DateChanged;
begin
  inherited DateChanged;
  ClosePopupList(False);
end;

function TTimeCalendarViewEh.ShowTodayInfo: Boolean;
begin
  Result := False;
end;

procedure TTimeCalendarViewEh.HoursRegionAction(
  Action: TTimeCalendarViewRegionAction);
begin
  case Action of
    tcraSelectPriorEh:
      begin
        IncrementHour(-1);
      end;
    tcraSelectNextEh:
      begin
        IncrementHour(1);
      end;
    tcraClickEh:
      if AmPm12
        then Calendar.SelectView(Calendar.FHours12View, True, True)
        else Calendar.SelectView(Calendar.FHours24View, True, True);
  end;
end;

procedure TTimeCalendarViewEh.MinutesRegionAction(
  Action: TTimeCalendarViewRegionAction);
begin
  case Action of
    tcraSelectPriorEh:
      begin
        IncrementMinute(-1);
      end;
    tcraSelectNextEh:
      begin
        IncrementMinute(1);
      end;
    tcraClickEh:
      Calendar.SelectView(Calendar.FMinutesView, True, True);
  end;
end;

procedure TTimeCalendarViewEh.SecondsRegionAction(
  Action: TTimeCalendarViewRegionAction);
begin
  case Action of
    tcraSelectPriorEh:
      begin
        IncrementSecond(-1);
      end;
    tcraSelectNextEh:
      begin
        IncrementSecond(1);
      end;
    tcraClickEh:
      Calendar.SelectView(Calendar.FSecondsView, True, True);
  end;
end;

procedure TTimeCalendarViewEh.OKButtonRegionAction(
  Action: TTimeCalendarViewRegionAction);
begin
  if Action = tcraClickEh then
    Calendar.CalendarActionPerformed(dtpcaButtonOKClickedEh);
end;

procedure TTimeCalendarViewEh.SelectNextRegion(MoveForward: Boolean);
var
  CurRegionNum: Integer;

  function IndexOf(ARegion: TTimeCalendarViewActiveRegionEh): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to Length(FVisibleRegions)-1 do
      if FVisibleRegions[i] = ARegion then
      begin
        Result := i;
        Exit;
      end;
  end;

begin
  if MoveForward then
  begin
    CurRegionNum := IndexOf(FActiveRegion);
    if CurRegionNum = Length(FVisibleRegions)-1
      then FActiveRegion := FVisibleRegions[0]
      else FActiveRegion := FVisibleRegions[CurRegionNum+1];
  end else
  begin
    CurRegionNum := IndexOf(FActiveRegion);
    if CurRegionNum = 0
      then FActiveRegion := FVisibleRegions[Length(FVisibleRegions)-1]
      else FActiveRegion := FVisibleRegions[CurRegionNum-1];
  end;
  Invalidate;
end;

procedure TTimeCalendarViewEh.KeyDown(var Key: Word; Shift: TShiftState);

  procedure CallRegionActionMethod(MethodCode: Pointer; Action: TTimeCalendarViewRegionAction);
  var
    p: TTimeCalendarViewActiveRegionProc;
    Method: TMethod;
  begin
    Method.Code := FRegionProcList[Ord(FActiveRegion)];
    Method.Data := Self;
    p := TTimeCalendarViewActiveRegionProc(Method);
    p(Action);
  end;

begin
  case Key of
    VK_UP:
      begin
        CallRegionActionMethod(FRegionProcList[Ord(FActiveRegion)], tcraSelectNextEh);
        Key := 0;
      end;
    VK_DOWN:
      begin
        CallRegionActionMethod(FRegionProcList[Ord(FActiveRegion)], tcraSelectPriorEh);
        Key := 0;
      end;
    VK_LEFT:
      begin
        SelectNextRegion(False);
        Key := 0;
      end;
    VK_RIGHT:
      begin
        SelectNextRegion(True);
        Key := 0;
      end;
    VK_RETURN:
      begin
        if ssCtrl in Shift then
          SelectNextView(False, True)
        else
          CallRegionActionMethod(FRegionProcList[Ord(FActiveRegion)], tcraClickEh);
        Key := 0;
      end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TTimeCalendarViewEh.ResetRegion;
begin
  FActiveRegion := tcarHoursEh;
  Invalidate;
end;

procedure TTimeCalendarViewEh.UpdateLocaleInfo;
var
  AHoursFormat: THoursTimeFormatEh;
  AAmPmPos: TAmPmPosEh;
begin
  GetHoursTimeFormat({SysLocale.DefaultLCID, }AHoursFormat, AAmPmPos);
  if (AHoursFormat <> FHoursFormat) or
     (AAmPmPos <> FAmPmPos)
  then
  begin
    FHoursFormat := AHoursFormat;
    FAmPmPos := AAmPmPos;
    ResetGrid;
  end;
end;

function TTimeCalendarViewEh.AmPm12: Boolean;
begin
  Result := (FHoursFormat = htfAmPm12hEh);
end;

{ TDateTimeCalendarPickerEh }

constructor TDateTimeCalendarPickerEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];

  DoubleBuffered := True;
  TabStop := True;

  FPriorPeriodButton := TDateTimePickCalendarButtonEh.Create(Self);
  FPriorPeriodButton.Parent := Self;
  FPriorPeriodButton.Style := cmpsPriorPeriodEh;
  FPriorPeriodButton.OnDown := NextPeriodMouseDown;

  FNextPeriodButton := TDateTimePickCalendarButtonEh.Create(Self);
  FNextPeriodButton.Parent := Self;
  FNextPeriodButton.Style := cmpsNextPeriodEh;
  FNextPeriodButton.OnDown := NextPeriodMouseDown;

  FDateInfo := TDateTimePickCalendarDateInfoLabelEh.Create(Self);
  FDateInfo.Parent := Self;
  FDateInfo.OnDown := DateInfoMouseDown;

  FTodayInfo := TDateTimePickCalendarTodayInfoLabelEh.Create(Self);
  FTodayInfo.Parent := Self;
  FTodayInfo.OnDown := DateInfoMouseDown;

  FCalendarViewList := TObjectListEh.Create;

  FDecadesView := TDecadesCalendarViewEh.Create(Self);
  FDecadesView.Parent := Self;
  FDecadesView.Visible := False;
  FCalendarViewList.Add(FDecadesView);

  FYearsView := TYearsCalendarViewEh.Create(Self);
  FYearsView.Parent := Self;
  FYearsView.Visible := False;
  FCalendarViewList.Add(FYearsView);

  FMonthsView := TMonthsCalendarViewEh.Create(Self);
  FMonthsView.Parent := Self;
  FMonthsView.Visible := False;
  FCalendarViewList.Add(FMonthsView);

  FDaysView := TDaysCalendarViewEh.Create(Self);
  FDaysView.Parent := Self;
  FDaysView.Visible := False;
  FCalendarViewList.Add(FDaysView);

  FHours24View := THours24CalendarViewEh.Create(Self);
  FHours24View.Parent := Self;
  FHours24View.Visible := False;

  FHours12View := THours12CalendarViewEh.Create(Self);
  FHours12View.Parent := Self;
  FHours12View.Visible := False;

  FMinutesView := TMinutesCalendarViewEh.Create(Self);
  FMinutesView.Parent := Self;
  FMinutesView.Visible := False;

  FSecondsView := TSecondsCalendarViewEh.Create(Self);
  FSecondsView.Parent := Self;
  FSecondsView.Visible := False;

  FTimeView := TTimeCalendarViewEh.Create(Self);
  FTimeView.Parent := Self;
  FTimeView.Visible := False;
  FCalendarViewList.Add(FTimeView);

  FCurrentCalendarView := FDaysView;
  FCurrentCalendarView.Visible := True;

  FImageTrans := TImageTransformatorEh.Create(Self);
  FImageTrans.Parent := Self;
  FImageTrans.Visible := False;

  FPaintBuffer := TDateTimePickCalendarPaintBufferEh.Create;

  FTimeUnits := [cdtuYearEh, cdtuMonthEh, cdtuDayEh];
  ResetTimeUnits;
  FInternalFontSet := True;
  try
    RefreshFont;
  finally
    FInternalFontSet := False;
  end;
end;

destructor TDateTimeCalendarPickerEh.Destroy;
begin
  FreeAndNil(FDecadesView);
  FreeAndNil(FYearsView);
  FreeAndNil(FMonthsView);
  FreeAndNil(FDaysView);
  FreeAndNil(FHours24View);
  FreeAndNil(FHours12View);
  FreeAndNil(FMinutesView);
  FreeAndNil(FSecondsView);
  FreeAndNil(FTimeView);
  FreeAndNil(FCalendarViewList);
  FreeAndNil(FDateInfo);
  FreeAndNil(FTodayInfo);
  FreeAndNil(FImageTrans);
  FreeAndNil(FPaintBuffer);
  inherited Destroy;
end;

function TDateTimeCalendarPickerEh.CreateDaysViewDayInfoItem: TDaysCalendarViewDayInfoItem;
begin
  Result := TDaysCalendarViewDayInfoItem.Create;
end;

procedure TDateTimeCalendarPickerEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  Params.Style := Params.Style or WS_CLIPCHILDREN or WS_BORDER;
end;

procedure TDateTimeCalendarPickerEh.CreateWnd;
begin
  inherited CreateWnd;
  ResetSize;
end;

procedure TDateTimeCalendarPickerEh.ResetSize;
var
  NewWidth, NewHeight: Integer;
begin
  GetAutoSizeData(NewWidth, NewHeight);
  SetBounds(Left, Top, NewWidth, NewHeight);
end;

procedure TDateTimeCalendarPickerEh.RecomndedSize(var RecClientWidth,
  RecClientHeight: Integer);
begin

end;

procedure TDateTimeCalendarPickerEh.SelectView(NextCalendarView: TCustomCalendarViewEh;
  MoveForward: Boolean; Animated: Boolean);
var
  NewWidth, NewHeight: Integer;
begin
  if FCurrentCalendarView <> NextCalendarView then
  begin
    if Animated then
    begin
      NextCalendarView.DateTime := DateTime;
      FImageTrans.Reset(FCurrentCalendarView, NextCalendarView);
      FImageTrans.TransformTime := 300;
      if MoveForward then
      begin
        FImageTrans.TransformStyle := itsZoomInTransformEh;
        FImageTrans.ZoomWinRect := FCurrentCalendarView.CellRect(FCurrentCalendarView.Col, FCurrentCalendarView.Row);
      end;
      FImageTrans.BringToFront;
      FImageTrans.Visible := True;
    end;

    FCurrentCalendarView.Visible := False;
    FCurrentCalendarView := NextCalendarView;
    FCurrentCalendarView.Visible := True;
    FCurrentCalendarView.DateTime := DateTime;
    FCurrentCalendarView.UpdateMousePos;
    CalendarViewChanged;
    Repaint;
    if Animated then
    begin
      if not MoveForward then
      begin
        FImageTrans.TransformStyle := itsZoomOutTransformEh;
        FImageTrans.ZoomWinRect := FCurrentCalendarView.CellRect(FCurrentCalendarView.Col, FCurrentCalendarView.Row);
      end;
      FImageTrans.AnimatedTransform;
      FImageTrans.Visible := False;
    end;

    GetAutoSizeData(NewWidth, NewHeight);
    AnimatedSetHeight(NewHeight);
  end;
end;

procedure TDateTimeCalendarPickerEh.CalendarActionPerformed(Action: TDateTimePickCalendarActionEh);
begin
  if (Action = dtpcaButtonOKClickedEh) then
    DateSelectedInLastView;
end;

procedure TDateTimeCalendarPickerEh.CalendarViewChanged;
begin
  FTodayInfo.Visible := FCurrentCalendarView.ShowTodayInfo;
  Invalidate;
end;

procedure TDateTimeCalendarPickerEh.CMParentFontChanged(var Message: TMessage);
begin
  FInternalFontSet := True;
  try
    inherited;
  finally
    FInternalFontSet := False;
  end;
end;

procedure TDateTimeCalendarPickerEh.CMFontChanged(var Message: TMessage);
begin
  InternalRefreshFont;
  inherited;
end;

procedure TDateTimeCalendarPickerEh.InternalRefreshFont;
var
  FontOnChange: TNotifyEvent;
begin
  if FInternalFontSet then
  begin
    FontOnChange := Font.OnChange;
    try
      Font.OnChange := nil;
      DateTimeCalendarPickerDrawStyleEh.SetCalendarFontData(Self, MasterFont, Font);
    finally
      Font.OnChange := FontOnChange;
    end;
  end;
end;

procedure TDateTimeCalendarPickerEh.RefreshFont;
begin
  FInternalFontSet := True;
  try
    InternalRefreshFont;
  finally
    FInternalFontSet := False;
  end;
  Perform(CM_FONTCHANGED, 0, 0);
end;

procedure TDateTimeCalendarPickerEh.WMGetDlgCode(var Msg: TWMNoParams);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TDateTimeCalendarPickerEh.WMThemeChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TDateTimeCalendarPickerEh.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  {$IFDEF FPC}
  {$ELSE}
  if FCurrentCalendarView <> nil then
    FCurrentCalendarView.Perform(CM_CANCELMODE, 0, Windows.LPARAM(Self));
  {$ENDIF}
end;

procedure TDateTimeCalendarPickerEh.AnimatedSetHeight(NewHeight: Integer);
var
  i: Integer;
begin
  i := Height;
  if NewHeight > Height then
    while True do
    begin
      Height := i;
      Repaint;
      i := i + 2;
      if i >= NewHeight then
      begin
        Height := NewHeight;
        Break;
      end;
    end
  else
    while True do
    begin
      Height := i;
      Repaint;
      i := i - 2;
      if i <= NewHeight then
      begin
        Height := NewHeight;
        Break;
      end;
    end
end;

procedure TDateTimeCalendarPickerEh.GetAutoSizeData(var NewWidth, NewHeight: Integer);
var
  TopBound, LowBound: Integer;
begin
  NewWidth := Width;
  NewHeight := Height;
  if not HandleAllocated then Exit;
  Canvas.Font := Font;
  TopBound := Canvas.TextHeight('Wg') * 2;
  LowBound := Round(Canvas.TextHeight('Wg') * 1.5);
  NewWidth := Width;
  NewHeight := Height - TopBound - LowBound;
  if HandleAllocated then
    FDaysView.HandleNeeded;
  FDaysView.GetAutoSizeData(NewWidth, NewHeight);
  NewHeight := NewHeight + TopBound + LowBound + 2;
end;

procedure TDateTimeCalendarPickerEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  InputMethod := iimKeyboardEh;
  FCurrentCalendarView.KeyDown(Key, Shift);
end;

procedure TDateTimeCalendarPickerEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  InputMethod := iimMouseEh;
  inherited MouseDown(Button, Shift, X, Y);
  {$IFDEF FPC}
  {$ELSE}
  if FCurrentCalendarView <> nil then
    FCurrentCalendarView.Perform(CM_CANCELMODE, 0, Windows.LPARAM(Self));
  {$ENDIF}
end;

procedure TDateTimeCalendarPickerEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if (FMousePos.X <> X) or (FMousePos.Y <> Y) then
  begin
    FMousePos := Point(X, Y);
    InputMethod := iimMouseEh;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TDateTimeCalendarPickerEh.Resize;
var
  TopBound, LowBound: Integer;
  OneNhalfLineH: Integer;
  ButtonTop, ButtonLeft: Integer;
  ButtonWidth: Integer;
  lvBrd, gridW, gridH: Integer;
begin
  if not HandleAllocated then Exit;

  Canvas.Font := Font;
  TopBound := Canvas.TextHeight('Wg') * 2;
  LowBound := Round(Canvas.TextHeight('Wg') * 1.5);
  lvBrd := Round(Canvas.TextWidth('0') div 2);
  gridW := ClientWidth - lvBrd * 2;
  gridH := ClientHeight - TopBound - LowBound;
  FDecadesView.SetBounds(lvBrd, TopBound, gridW, gridH);
  FYearsView.SetBounds(lvBrd, TopBound, gridW, gridH);
  FMonthsView.SetBounds(lvBrd, TopBound, gridW, gridH);
  FDaysView.SetBounds(lvBrd, TopBound, gridW, gridH);
  FHours24View.SetBounds(lvBrd, TopBound, gridW, gridH);
  FHours12View.SetBounds(lvBrd, TopBound, gridW, gridH);
  FMinutesView.SetBounds(lvBrd, TopBound, gridW, gridH);
  FSecondsView.SetBounds(lvBrd, TopBound, gridW, gridH);
  FTimeView.SetBounds(lvBrd, TopBound, gridW, gridH);
  FImageTrans.SetBounds(lvBrd, TopBound, gridW, gridH);

  OneNhalfLineH := Round(Canvas.TextHeight('Wg') * 1.5);
  ButtonWidth := Canvas.TextWidth('000');

  ButtonTop := (TopBound - OneNhalfLineH) div 2;
  ButtonLeft := 5;
  FPriorPeriodButton.SetBounds(ButtonLeft, ButtonTop, ButtonWidth, OneNhalfLineH);
  FNextPeriodButton.SetBounds(ClientWidth - ButtonLeft - ButtonWidth, ButtonTop,
                              ButtonWidth, OneNhalfLineH);
  FDateInfo.SetBounds(ButtonLeft + ButtonWidth,
                      ButtonTop,
                      ClientWidth - (ButtonLeft + ButtonWidth) * 2,
                      OneNhalfLineH);

  FTodayInfo.SetBounds(ButtonLeft + ButtonWidth,
                      ClientHeight - LowBound,
                      ClientWidth - (ButtonLeft + ButtonWidth) * 2,
                      OneNhalfLineH - 5);
end;

procedure TDateTimeCalendarPickerEh.SetPaintBuffer;
begin
  FPaintBuffer.NormalCellBrushColor := DateTimeCalendarPickerDrawStyleEh.NormalCellBrushColor;
  FPaintBuffer.NormalCellFontColor := DateTimeCalendarPickerDrawStyleEh.NormalCellFontColor;
  FPaintBuffer.HotTrackCellFontColor := DateTimeCalendarPickerDrawStyleEh.HotTrackCellFontColor;
  FPaintBuffer.SelectedCellBrushColor := DateTimeCalendarPickerDrawStyleEh.SelectedCellBrushColor;
  FPaintBuffer.SelectedCellFontColor := DateTimeCalendarPickerDrawStyleEh.SelectedCellFontColor;
  FPaintBuffer.OutsidePeriod := DateTimeCalendarPickerDrawStyleEh.OutsidePeriodCellFontColor;
  FPaintBuffer.HotTrackCellBrushColor := DateTimeCalendarPickerDrawStyleEh.HotTrackCellBrushColor;

  FPaintBuffer.TodayCellFrameColor := DateTimeCalendarPickerDrawStyleEh.TodayCellFrameColor;
  FPaintBuffer.InsideHorzFrameColor := DateTimeCalendarPickerDrawStyleEh.InsideHorzFrameColor;
  FPaintBuffer.InsideVertFrameColor := DateTimeCalendarPickerDrawStyleEh.InsideVertFrameColor;
  FPaintBuffer.HolidayFontColor := DateTimeCalendarPickerDrawStyleEh.HolidayFontColor;
  FPaintBuffer.HolidaySelectedFontColor := DateTimeCalendarPickerDrawStyleEh.HolidaySelectedFontColor;
  FPaintBuffer.HolidayOutsidePeriodFontColor := DateTimeCalendarPickerDrawStyleEh.HolidayOutsidePeriodFontColor;

  DateTimeCalendarPickerDrawStyleEh.SetCalendarWeekNoFontData(Self, Font, FPaintBuffer.CalendarWeekNoFont);
end;

procedure TDateTimeCalendarPickerEh.UpdateDaysViewDayInfoItem(
  DayInfoItem: TDaysCalendarViewDayInfoItem; ADate: TDateTime);
begin
  DayInfoItem.IsHoliday := not GlobalWorkingTimeCalendar.IsWorkday(ADate);
end;

procedure TDateTimeCalendarPickerEh.UpdateMousePos;
begin
  FMousePos := ScreenToClient(Mouse.CursorPos);
end;

procedure TDateTimeCalendarPickerEh.Paint;
begin
  SetPaintBuffer;
  Canvas.Brush.Color := StyleServices.GetSystemColor(clWindow);
  Canvas.FillRect(ClientRect);
end;

function TDateTimeCalendarPickerEh.GetMasterFont: TFont;
begin
  Result := Font;
end;


procedure TDateTimeCalendarPickerEh.DateInfoMouseDown(Sender: TObject;
  var AutoRepeat: Boolean; var Handled: Boolean);
begin
  if Sender = FDateInfo then
    FCurrentCalendarView.SelectNextView(False, True)
  else if Sender = FTodayInfo  then
  begin
    if (FCurrentCalendarView <> FDaysView) and
       (FCalendarViewList.IndexOf(FDaysView) >= 0)
    then
    begin
      SelectView(FDaysView, False, False);
      DateTime := DateOf(Today) + TimeOf(DateTime);
    end else if DateOf(DateTime) = DateOf(Today) then
    begin
      CalendarActionPerformed(dtpcaButtonOKClickedEh)
    end else
    begin
      DateTime := DateOf(Today) + TimeOf(DateTime);
    end;
  end;
end;

procedure TDateTimeCalendarPickerEh.DateSelectedInLastView;
begin
  if Assigned(FOnDateTimeSelected) then
    FOnDateTimeSelected(Self);
end;

procedure TDateTimeCalendarPickerEh.MoveToNextPeriod(Animated: Boolean);
begin
  if Animated then
    SetDateTimeAnimated(FCurrentCalendarView.GetNextPeriodDate(DateTime, True))
  else
    DateTime := FCurrentCalendarView.GetNextPeriodDate(DateTime, True);
end;

procedure TDateTimeCalendarPickerEh.MoveToPriorPeriod(Animated: Boolean);
begin
  if Animated then
    SetDateTimeAnimated(FCurrentCalendarView.GetNextPeriodDate(DateTime, False))
  else
    DateTime := FCurrentCalendarView.GetNextPeriodDate(DateTime, False);
end;

procedure TDateTimeCalendarPickerEh.SetDateTimeAnimated(Value: TDateTime);
var
  cv: TCustomCalendarViewEh;
begin
  if FDateTime <> Value then
  begin
    cv := FCurrentCalendarView;
    if cv <> nil then
    begin
      if cv.DateInViewRange(Value) then
        DateTime := Value
      else begin
        if Value > cv.DateTime then
          FImageTrans.TransformStyle := itsRightToLeftTransformEh
        else
          FImageTrans.TransformStyle := itsLeftToRightTransformEh;
        FImageTrans.Reset(FCurrentCalendarView, FCurrentCalendarView);
        DateTime := Value;
        FCurrentCalendarView.PaintTo(FImageTrans.FBitmap2.Canvas, 0, 0);
        FImageTrans.TransformTime := 250;
        FImageTrans.BringToFront;
        FImageTrans.Visible := True;
        FImageTrans.AnimatedTransform;
        FImageTrans.Visible := False;
        Invalidate;
      end;
    end;
  end;
end;

procedure TDateTimeCalendarPickerEh.NextPeriodMouseDown(Sender: TObject;
  var AutoRepeat: Boolean; var Handled: Boolean);
begin
  if Sender = FNextPeriodButton then
    MoveToNextPeriod(True)
  else
    MoveToPriorPeriod(True);
  AutoRepeat := True;
end;

procedure TDateTimeCalendarPickerEh.SetDateTime(Value: TDateTime);
begin
  if FDateTime <> Value then
  begin
    FDateTime := Value;
    if FCurrentCalendarView <> nil then
      FCurrentCalendarView.DateTime := Value;
    Invalidate;
    if HandleAllocated then
      FDateInfo.Repaint;
  end;
end;

procedure TDateTimeCalendarPickerEh.ResetStartCalendarView;
var
  OldCurrentCalendarView: TCustomCalendarViewEh;
begin
  OldCurrentCalendarView := FCurrentCalendarView;
  if FCalendarViewList.IndexOf(FDaysView) >= 0 then
    FCurrentCalendarView := FDaysView
  else if FCalendarViewList.IndexOf(FMonthsView) >= 0 then
    FCurrentCalendarView := FMonthsView
  else if FCalendarViewList.IndexOf(FYearsView) >= 0 then
    FCurrentCalendarView := FYearsView
  else if FCalendarViewList.IndexOf(FDecadesView) >= 0 then
    FCurrentCalendarView := FDecadesView
  else if FCalendarViewList.IndexOf(FTimeView) >= 0 then
    FCurrentCalendarView := FTimeView
  else if FCalendarViewList.IndexOf(FHours24View) >= 0 then
    FCurrentCalendarView := FHours24View
  else if FCalendarViewList.IndexOf(FHours12View) >= 0 then
    FCurrentCalendarView := FHours12View
  else if FCalendarViewList.IndexOf(FMinutesView) >= 0 then
    FCurrentCalendarView := FMinutesView
  else if FCalendarViewList.IndexOf(FSecondsView) >= 0 then
    FCurrentCalendarView := FSecondsView;

  if OldCurrentCalendarView <> FCurrentCalendarView then
  begin
    OldCurrentCalendarView.Visible := False;
    FCurrentCalendarView.Visible := True;
    FCurrentCalendarView.DateTime := DateTime;
    CalendarViewChanged;
  end;
end;

function TDateTimeCalendarPickerEh.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    {$IFDEF FPC}
    {$ELSE}
    if ssCtrl in Shift then
      FCurrentCalendarView.SelectNextView(False, True)
    else
    begin
      if WheelAccumulator <> 0
        then MoveToNextPeriod(False)
        else MoveToNextPeriod(True);
    end;
    {$ENDIF}
    Result := True;
  end;
end;

function TDateTimeCalendarPickerEh.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    {$IFDEF FPC}
    {$ELSE}
    if ssCtrl in Shift then
      FCurrentCalendarView.SelectNextView(True, True)
    else
    begin
      if WheelAccumulator <> 0
        then MoveToPriorPeriod(False)
        else MoveToPriorPeriod(True);
    end;
    {$ENDIF}
    Result := True;
  end;
end;

procedure TDateTimeCalendarPickerEh.SetInputMethod(
  const Value: TInteractiveInputMethodEh);
begin
  if FInputMethod <> Value then
  begin
    FInputMethod := Value;
    Invalidate;
  end;
end;

{ TDateTimePickCalendarButtonEh }

constructor TDateTimePickCalendarButtonEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);

end;

procedure TDateTimePickCalendarButtonEh.Paint;
var
  ArrawRect: TRect;
  CliRect: TRect;
  BF: Integer;
  SrawStyle: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  SrawStyle := DateTimeCalendarPickerDrawStyleEh;
  PickCalendar.SetPaintBuffer;
  CliRect := Rect(0, 0, Width, Height);

  if MouseInControl then
  begin
    Canvas.Brush.Color := PickCalendar.PaintBuffer.HotTrackCellBrushColor;
    CalViewState := [cvdsHotTrackEh];
    SrawStyle.DrawCalendarViewCellBackgraund(nil, Canvas, CliRect, CalViewState);
  end else
  begin
    Canvas.Brush.Color := PickCalendar.PaintBuffer.NormalCellBrushColor;
    Canvas.FillRect(CliRect);
  end;

  ArrawRect := Rect(0,0,4,7);
  ArrawRect := CenteredRect(CliRect, ArrawRect);
  Canvas.Pen.Color := StyleServices.GetSystemColor(clWindowText);
  if Style = cmpsNextPeriodEh then
  begin
    BF := 1
  end else
  begin
    BF := -1;
    ArrawRect.Left := ArrawRect.Right;
  end;

  Canvas.Polyline([Point(ArrawRect.Left, ArrawRect.Top), Point(ArrawRect.Left, ArrawRect.Bottom)]);
  Canvas.Polyline([Point(ArrawRect.Left+1*BF, ArrawRect.Top+1), Point(ArrawRect.Left+1*BF, ArrawRect.Bottom-1)]);
  Canvas.Polyline([Point(ArrawRect.Left+2*BF, ArrawRect.Top+2), Point(ArrawRect.Left+2*BF, ArrawRect.Bottom-2)]);
  Canvas.Polyline([Point(ArrawRect.Left+3*BF, ArrawRect.Top+3), Point(ArrawRect.Left+3*BF, ArrawRect.Bottom-3)]);
end;

function TDateTimePickCalendarButtonEh.GetPickCalendar: TDateTimeCalendarPickerEh;
begin
  Result := TDateTimeCalendarPickerEh(Owner);
end;

function TDateTimeCalendarPickerEh.GetTimeUnits: TCalendarDateTimeUnitsEh;
begin
  Result := FTimeUnits;
end;

procedure TDateTimeCalendarPickerEh.SetTimeUnits(
  const Value: TCalendarDateTimeUnitsEh);
begin
  if Value <> FTimeUnits then
  begin
    FTimeUnits := Value;
    ResetTimeUnits;
    ResetStartCalendarView;
  end;
end;

procedure TDateTimeCalendarPickerEh.ResetTimeUnits;
begin
  FCalendarViewList.Clear;
  if cdtuYearEh in TimeUnits then
  begin
    FCalendarViewList.Add(FDecadesView);
    FCalendarViewList.Add(FYearsView);
  end;
  if cdtuMonthEh in TimeUnits then
    FCalendarViewList.Add(FMonthsView);
  if cdtuDayEh in TimeUnits then
    FCalendarViewList.Add(FDaysView);
  if ([cdtuHourEh, cdtuMinuteEh, cdtuSecondEh] * TimeUnits <> []) and
     EhLibManager.DateTimeCalendarPickerShowTimeSelectionPage
  then
    FCalendarViewList.Add(FTimeView);
  FTimeView.ResetGrid;

  if ([cdtuYearEh, cdtuMonthEh, cdtuDayEh] * TimeUnits <> []) then
  begin
    FPriorPeriodButton.Visible := True;
    FNextPeriodButton.Visible := True;
    FDateInfo.Visible := True;
  end else
  begin
    FPriorPeriodButton.Visible := False;
    FNextPeriodButton.Visible := False;
    FDateInfo.Visible := False;
  end;
end;

{ TDateTimePickCalendarDateInfoLabelEh }

constructor TDateTimePickCalendarDateInfoLabelEh.Create(AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
end;

function TDateTimePickCalendarDateInfoLabelEh.GetPickCalendar: TDateTimeCalendarPickerEh;
begin
  Result := TDateTimeCalendarPickerEh(Owner);
end;

procedure TDateTimePickCalendarDateInfoLabelEh.Paint;
var
  CliRect: TRect;
  s: String;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  Style := DateTimeCalendarPickerDrawStyleEh;
  PickCalendar.SetPaintBuffer;
  CliRect := Rect(0, 0, Width, Height);

  if MouseInControl then
  begin
    Canvas.Brush.Color := PickCalendar.PaintBuffer.HotTrackCellBrushColor;
    CalViewState := [cvdsHotTrackEh];
    Style.DrawCalendarViewCellBackgraund(nil, Canvas, CliRect, CalViewState);
  end else
  begin
    Canvas.Brush.Color := PickCalendar.PaintBuffer.NormalCellBrushColor;
    Canvas.FillRect(CliRect);
  end;

  Canvas.Font := Font;
  Canvas.Font.Color := StyleServices.GetSystemColor(Canvas.Font.Color);

  s := PickCalendar.FCurrentCalendarView.GetDateInfoText;
  WriteTextEh(Canvas, CliRect, False, 0, 0, s, taCenter, tlCenter, False, False, 0, 0, False, True)
end;

{ TDateTimePickCalendarTodayInfoLabelEh }

constructor TDateTimePickCalendarTodayInfoLabelEh.Create(
  AOwner: TDateTimeCalendarPickerEh);
begin
  inherited Create(AOwner);
end;

function TDateTimePickCalendarTodayInfoLabelEh.GetPickCalendar: TDateTimeCalendarPickerEh;
begin
  Result := TDateTimeCalendarPickerEh(Owner);
end;

procedure TDateTimePickCalendarTodayInfoLabelEh.Paint;
var
  CliRect: TRect;
  s: String;
  CellRect: TRect;
  sw: Integer;
  Style: TDateTimeCalendarPickerDrawStyleEh;
  CalViewState: TCalendarViewDrawStateEh;
begin
  s := '';
  Style := DateTimeCalendarPickerDrawStyleEh;
  PickCalendar.SetPaintBuffer;
  CliRect := Rect(0, 0, Width, Height);
  if MouseInControl then
  begin
    Canvas.Brush.Color := PickCalendar.PaintBuffer.HotTrackCellBrushColor;
    CalViewState := [cvdsHotTrackEh];
    Canvas.FillRect(CliRect);
  end else
  begin
    CalViewState := [];
    Canvas.Brush.Color := PickCalendar.PaintBuffer.NormalCellBrushColor;
    Canvas.FillRect(CliRect);
  end;

  Canvas.Font := Font;
  Canvas.Font.Color := StyleServices.GetSystemColor(Canvas.Font.Color);
  s := s + EhLibLanguageConsts.TodayEh + ': ' + DateToStr(Today) + ' ';

  WriteTextEh(Canvas, CliRect, False, 0, 0, s, taRightJustify, tlCenter, False, False, 0, 0, False, True);
  sw := Canvas.TextWidth(s);

  CellRect := PickCalendar.FDaysView.CellRect(1,1);
  OffsetRect(CellRect, -CellRect.Left, -CellRect.Top);
  CellRect.Bottom := CellRect.Bottom - 1;
  OffsetRect(CellRect,
    Width - sw - 5 - RectWidth(CellRect),
    (Height - RectHeight(CellRect)) div 2 + 1);

  CalViewState := CalViewState + [cvdsNowEh];
  Style.DrawCalendarViewCellBackgraund(nil, Canvas, CellRect, CalViewState);
end;

{ TPopupDateTimeCalendarPickerEh }

constructor TPopupDateTimeCalendarPickerEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  ControlStyle := ControlStyle + [csReplicatable]; 
  Visible := False;
  ParentWindow := GetDesktopWindow;
  AutoSize := True;
  {$ENDIF}
end;

procedure TPopupDateTimeCalendarPickerEh.CalendarActionPerformed(
  Action: TDateTimePickCalendarActionEh);
begin
  if (Action in [{dtpcaSecondSelectedFromListEh, }dtpcaButtonOKClickedEh]) and
     Assigned(FCloseCallback)
  then
  begin
    FCloseCallback(Self, True);
    FOwnerFont := nil;
  end;
end;

function TPopupDateTimeCalendarPickerEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  if HandleAllocated then
  begin
    GetAutoSizeData(NewWidth, NewHeight);
    Result := True;
  end else
    Result := False;
end;

function TPopupDateTimeCalendarPickerEh.CanFocus: Boolean;
begin
  Result := False;
end;

procedure TPopupDateTimeCalendarPickerEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  {$IFDEF FPC}
  Params.Style := Params.Style or WS_POPUP;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  {$ELSE}
  Params.Style := Params.Style or WS_POPUP;
  if not Ctl3D then Params.Style := Params.Style or WS_BORDER;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW {or WS_EX_TOPMOST};
  {$ENDIF}

  {$IFDEF FPC_CROSSP}
  {$ELSE}
  Params.WindowClass.Style := CS_SAVEBITS;
  if CheckWin32Version(5, 1) then
    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
  {$ENDIF}
end;

procedure TPopupDateTimeCalendarPickerEh.CreateWnd;
begin
  inherited CreateWnd;
end;

procedure TPopupDateTimeCalendarPickerEh.DateSelectedInLastView;
begin
  CalendarActionPerformed(dtpcaButtonOKClickedEh);
end;

procedure TPopupDateTimeCalendarPickerEh.SetFontOptions(OwnerFont: TFont;
  FontAutoSelect: Boolean);
begin
  FOwnerFont := OwnerFont;
  RefreshFont();
  ResetSize;
end;

procedure TPopupDateTimeCalendarPickerEh.ShowPicker(DateTime: TDateTime;
  Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
begin
  FCloseCallback := CloseCallback;
  Self.DateTime := DateTime;
  ResetStartCalendarView;
  SetBounds(Pos.X, Pos.Y, Width, Height);
  SetWindowPos(Handle, HWND_TOPMOST, Pos.X, Pos.Y, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  Visible := True;
end;

procedure TPopupDateTimeCalendarPickerEh.UpdateSize;
begin
end;

procedure TPopupDateTimeCalendarPickerEh.HidePicker;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

procedure TPopupDateTimeCalendarPickerEh.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
procedure TPopupDateTimeCalendarPickerEh.WMMouseActivate(var Message: TWMMouseActivate);
begin
  Message.Result := MA_NOACTIVATE;
end;
{$ENDIF}

function TPopupDateTimeCalendarPickerEh.GetDateTime: TDateTime;
begin
  Result := Self.DateTime
end;

procedure TPopupDateTimeCalendarPickerEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TPopupDateTimeCalendarPickerEh.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TPopupDateTimeCalendarPickerEh.PostCloseUp(Accept: Boolean);
begin

end;

function TPopupDateTimeCalendarPickerEh.WantKeyDown(Key: Word;
  Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TPopupDateTimeCalendarPickerEh.WantFocus: Boolean;
begin
  Result := False;
end;

procedure TPopupDateTimeCalendarPickerEh.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_RETURN, VK_ESCAPE] then
  begin
    if Assigned(FCloseCallback) then
      FCloseCallback(Self, Key = VK_RETURN);
    Key := 0;
  end;
end;

function TPopupDateTimeCalendarPickerEh.GetMasterFont: TFont;
begin
  if FOwnerFont <> nil
    then Result := FOwnerFont
    else Result := Font;
end;

{ TImageTransformatorEh }

constructor TImageTransformatorEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitmap1 := TBitmap.Create;
  FBitmap2 := TBitmap.Create;
  FResultBitmap := TBitmap.Create;
  Reset(nil, nil);
  FTransformTime := 1000;
end;

destructor TImageTransformatorEh.Destroy;
begin
  FreeAndNil(FBitmap1);
  FreeAndNil(FBitmap2);
  FreeAndNil(FResultBitmap);
  inherited;
end;

procedure TImageTransformatorEh.Paint;
begin
  Canvas.Draw(0,0, FResultBitmap);
end;

procedure TImageTransformatorEh.DrawHorizontalTransform(Step, Leng: Integer;
  LeftToRight: Boolean);
var
  HorzPos: Integer;
begin

  HorzPos := Round(Step * Width / Leng);

  FResultBitmap.Canvas.Brush.Color := StyleServices.GetSystemColor(clWindow);
  FResultBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));

  if LeftToRight then
  begin
    FResultBitmap.Canvas.Draw(HorzPos,0, FBitmap1);
    FResultBitmap.Canvas.Draw(HorzPos-Width,0, FBitmap2);
  end else
  begin
    FResultBitmap.Canvas.Draw(-HorzPos,0, FBitmap1);
    FResultBitmap.Canvas.Draw(Width-HorzPos,0, FBitmap2);
  end;

  Repaint;
end;

procedure TImageTransformatorEh.DrawTransparentTransform(Step, Leng: Integer);
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  Transp: Integer;
  bf : BLENDFUNCTION;
begin
  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  bf.AlphaFormat := 0;

  Transp := Round(Step * 255 / Leng);
  FResultBitmap.Canvas.Brush.Color := StyleServices.GetSystemColor(clWindow);
  FResultBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));

  bf.SourceConstantAlpha := 255 - Transp;
  AlphaBlend(FResultBitmap.Canvas.Handle, 0, 0, Width, Height,
                     FBitmap1.Canvas.Handle, 0, 0, Width, Height, bf);

  bf.SourceConstantAlpha := Transp;
  AlphaBlend(FResultBitmap.Canvas.Handle, 0, 0, Width, Height,
                     FBitmap2.Canvas.Handle, 0, 0, Width, Height, bf);

  Repaint;
end;
{$ENDIF} 

procedure TImageTransformatorEh.DrawZoomTransform(Step, Leng: Integer; ZoomIn: Boolean);
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  a, b, a1, b1: Double;
  StepZoomWinRect1, StepZoomWinRect2: TRect;
  Transp: Integer;
  bf : BLENDFUNCTION;
  wRel, hRel: Double;
  Bmp1, Bmp2: TBitmap;
begin
  Transp := Round(Step * 255 / Leng);
  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  bf.AlphaFormat := 0;

  FResultBitmap.Canvas.Brush.Color := StyleServices.GetSystemColor(clWindow);
  FResultBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));

  if not ZoomIn then
  begin
    Step := Leng - Step;
    Bmp1 := FBitmap2;
    Bmp2 := FBitmap1;
    Transp := 255 - Transp;
  end else
  begin
    Bmp1 := FBitmap1;
    Bmp2 := FBitmap2;
  end;

  wRel := Width / RectWidth(ZoomWinRect);
  hRel := Height / RectHeight(ZoomWinRect);
  StepZoomWinRect1 := Rect(0, 0, Width, Height);

  a := (Height - ZoomWinRect.Bottom) * hRel;
  b := (Width - ZoomWinRect.Right) * wRel;
  a1 := Step * a / Leng;
  b1 := Step * b / Leng;
  StepZoomWinRect1.Bottom := Round(StepZoomWinRect1.Bottom + a1);
  StepZoomWinRect1.Right := Round(StepZoomWinRect1.Right + b1);

  a := ZoomWinRect.Top * hRel;
  b := ZoomWinRect.Left * wRel;
  a1 := Step * a / Leng;
  b1 := Step * b / Leng;
  StepZoomWinRect1.Top := Round(-a1);
  StepZoomWinRect1.Left := Round(-b1);

  bf.SourceConstantAlpha := 255 - Transp;
  AlphaBlend(FResultBitmap.Canvas.Handle,
             StepZoomWinRect1.Left, StepZoomWinRect1.Top, RectWidth(StepZoomWinRect1), RectHeight(StepZoomWinRect1),
             Bmp1.Canvas.Handle,
             0, 0, Width, Height,
             bf);

  StepZoomWinRect2 := ZoomWinRect;

  a := Height - ZoomWinRect.Bottom;
  b := Width - ZoomWinRect.Right;
  a1 := Step * a / Leng;
  b1 := Step * b / Leng;
  StepZoomWinRect2.Bottom := Round(StepZoomWinRect2.Bottom + a1);
  StepZoomWinRect2.Right := Round(StepZoomWinRect2.Right + b1);

  a := ZoomWinRect.Top;
  b := ZoomWinRect.Left;
  a1 := Step * a / Leng;
  b1 := Step * b / Leng;
  StepZoomWinRect2.Top := Round(StepZoomWinRect2.Top - a1);
  StepZoomWinRect2.Left := Round(StepZoomWinRect2.Left - b1);

  bf.SourceConstantAlpha := Transp;

  AlphaBlend(FResultBitmap.Canvas.Handle,
             StepZoomWinRect2.Left, StepZoomWinRect2.Top, RectWidth(StepZoomWinRect2), RectHeight(StepZoomWinRect2),
             Bmp2.Canvas.Handle,
             0, 0, Width, Height,
             bf);

  Repaint;
end;
{$ENDIF} 

procedure TImageTransformatorEh.OutputDebugString(s: String);
begin
  if FOutputDebugString = True then
    OutputDebugStringEh(s);
end;

procedure TImageTransformatorEh.AnimatedTransform;
var
  t, ft: Longword;
  i: Integer;
  Step: Integer;
  RenDur: Integer;
  StepSize: Integer;
begin
  t := GetTickCountEh;
  i := 1;
  Step := 1;

  OutputDebugString('');
  OutputDebugString('--');
  OutputDebugString('Start Time: ' + IntToStr(t));

  while i < TransformTime do
  begin

    if TransformStyle = itsTransparentTransformEh  then
      DrawTransparentTransform(i, TransformTime)
    else if TransformStyle = itsLeftToRightTransformEh then
      DrawHorizontalTransform(i, TransformTime, True)
    else if TransformStyle = itsRightToLeftTransformEh  then
      DrawHorizontalTransform(i, TransformTime, False)
    else if TransformStyle = itsZoomInTransformEh  then
      DrawZoomTransform(i, TransformTime, True)
    else if TransformStyle = itsZoomOutTransformEh then
      DrawZoomTransform(i, TransformTime, False);

    RenDur := GetTickCountEh - t;
    i := RenDur;
    if RenDur > 0
      then StepSize := Round(RenDur / Step)
      else StepSize := 1;
    if StepSize = 0 then
      StepSize := 1;
    i := i + StepSize + RenDur - i - StepSize;

    Inc(Step);

    OutputDebugString('Step: ' + IntToStr(Step) + '  Duration: (' + IntToStr(RenDur) + ')');
  end;

  ft := GetTickCountEh;
  OutputDebugString('Finish Time: ' + IntToStr(ft));
  OutputDebugString('Transformation Duration: (' + IntToStr(ft - t) + ')');
  OutputDebugString('--');
end;

procedure TImageTransformatorEh.Reset(Control1, Control2: TWinControl);
begin
  FBitmap1Transparency := 0;
  FBitmap2Transparency := 255;

  FBitmap1.Width := Width;
  FBitmap1.Height := Height;
  FResultBitmap.Width := Width;
  FResultBitmap.Height := Height;
  if (Control1 <> nil) then
  begin
    Control1.PaintTo(FBitmap1.Canvas, 0, 0);
  end;

  FBitmap2.Width := Width;
  FBitmap2.Height := Height;
  if (Control2 <> nil) then
  begin
    Control2.PaintTo(FBitmap2.Canvas, 0, 0);
    Control2.PaintTo(FResultBitmap.Canvas, 0, 0);
  end;
end;

function DateTimeCalendarPickerDrawStyleEh: TDateTimeCalendarPickerDrawStyleEh;
begin
  Result := FDateTimePickCalendarDrawStyle;
end;

function SetDateTimeCalendarPickerDrawStyleEh(DrawStyle: TDateTimeCalendarPickerDrawStyleEh): TDateTimeCalendarPickerDrawStyleEh;
begin
  Result := FDateTimePickCalendarDrawStyle;
  FDateTimePickCalendarDrawStyle := DrawStyle;
end;

{ TDateTimePickCalendarDrawStyleEh }

constructor TDateTimeCalendarPickerDrawStyleEh.Create;
begin
  inherited Create;
  FHotTrackCellBrushColor1 := clNone;
  FHotTrackCellBrushColor2 := clNone;
  FHolidayBaseFontColor := clDefault;
end;

function TDateTimeCalendarPickerDrawStyleEh.CanDrawSelectionByStyle: Boolean;
begin
  Result := ThemedSelectionEnabled and not CustomStyleActive;
end;

procedure TDateTimeCalendarPickerDrawStyleEh.DrawCalendarViewCellBackgraund(
  CalendarView: TCustomCalendarViewEh; Canvas: TCanvas; ARect: TRect;
  State: TCalendarViewDrawStateEh);
var
{$IFDEF EH_LIB_16}
  Style: TCustomStyleServices;
  mctItem: TThemedMonthCal;
{$ELSE}
  Style: TThemeServices;
{$ENDIF}
  ThemDet: TThemedElementDetails;
  OldBrushColor: TColor;
begin
  if CanDrawSelectionByStyle then
  begin
    Canvas.FillRect(ARect);
{$IFDEF EH_LIB_16}
    Style := StyleServices;
    if State * [cvdsSelectedEh, cvdsHotTrackEh] = [cvdsSelectedEh, cvdsHotTrackEh] then
      mctItem := tmcGridCellBackgroundSelectedHot
    else if cvdsSelectedEh in State then
      mctItem := tmcGridCellBackgroundSelected
    else if cvdsHotTrackEh in State then
      mctItem := tmcGridCellBackgroundHot
    else
      mctItem := tmcBackground;
    ThemDet := Style.GetElementDetails(mctItem);
{$ELSE}
    Style := ThemeServices;

    ThemDet.Element := teListView;
    if State * [cvdsSelectedEh, cvdsHotTrackEh] = [cvdsSelectedEh, cvdsHotTrackEh] then
    begin
      ThemDet.Part := 6;
      ThemDet.State := 12;
    end else if cvdsSelectedEh in State then
    begin
      ThemDet.Part := 6;
      ThemDet.State := 11;
    end else if cvdsHotTrackEh in State then
    begin
      ThemDet.Part := 6;
      ThemDet.State := 10;
    end else
    begin
      ThemDet.Part := 6;
      ThemDet.State := 9;
    end;

{$ENDIF}

    Style.DrawElement(Canvas.Handle, ThemDet, ARect, nil);

    if cvdsNowEh in State then
    begin
{$IFDEF EH_LIB_16}
      ThemDet := Style.GetElementDetails(tmcGridCellBackgroundToday);
{$ELSE}
      ThemDet.Part := 7;
      ThemDet.State := 3;
{$ENDIF}
      Style.DrawElement(Canvas.Handle, ThemDet, ARect, nil);
    end;
  end else
  begin
    Canvas.FillRect(ARect);

    if cvdsNowEh in State then
    begin
      OldBrushColor := Canvas.Brush.Color;
      Canvas.Brush.Color := TodayCellFrameColor;
      Canvas.FrameRect(ARect);
      Canvas.Brush.Color := OldBrushColor;
    end;
  end;
end;

function TDateTimeCalendarPickerDrawStyleEh.GetNormalCellFontColor: TColor;
begin
  Result := StyleServices.GetSystemColor(clWindowText);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetNormalCellBrushColor: TColor;
begin
  Result := StyleServices.GetSystemColor(clWindow);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetHotTrackCellFontColor: TColor;
begin
  Result := StyleServices.GetSystemColor(clWindowText);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetHolidayBaseFontColor: TColor;
begin
  Result := FHolidayBaseFontColor;
end;

procedure TDateTimeCalendarPickerDrawStyleEh.SetHolidayBaseFontColor(
  const Value: TColor);
begin
  if Value <> FHolidayBaseFontColor then
  begin
    FHolidayBaseFontColor := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

function TDateTimeCalendarPickerDrawStyleEh.GetHolidayFontColor: TColor;
var
  WinLum: Integer;
  ActlHolidayBaseFontColor: TColor;
begin
  if HolidayBaseFontColor = clDefault
    then ActlHolidayBaseFontColor := StyleServices.GetSystemColor(clRed)
    else ActlHolidayBaseFontColor := StyleServices.GetSystemColor(HolidayBaseFontColor);


  WinLum := GetColorLuminance(NormalCellFontColor);

  if WinLum < 128
    then Result := ChangeColorLuminance(ActlHolidayBaseFontColor, 100)
    else Result := ChangeColorLuminance(ActlHolidayBaseFontColor, 160);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetHolidaySelectedFontColor: TColor;
var
  WinLum: Integer;
begin
  WinLum := GetColorLuminance(SelectedCellFontColor);

  if WinLum < 100
    then Result := ChangeColorLuminance(StyleServices.GetSystemColor(clRed), 60)
    else Result := ChangeColorLuminance(StyleServices.GetSystemColor(clRed), 180);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetHolidayOutsidePeriodFontColor: TColor;
begin
  Result := ApproachToColorEh(HolidayFontColor, OutsidePeriodCellFontColor, 66);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetHotTrackCellBrushColor: TColor;
var
  AHotTrackCellBrushColor1: TColor;
  AHotTrackCellBrushColor2: TColor;
  WinLum, SelLum, LumDist, MaxLum, LumDistPerc, AprocPerc: Integer;
begin
  if CanDrawSelectionByStyle then
    Result := StyleServices.GetSystemColor(clWindow)
  else
  begin
    AHotTrackCellBrushColor1 := StyleServices.GetSystemColor(clWindow);
    AHotTrackCellBrushColor2 := StyleServices.GetSystemColor(clHighlight);
    if (AHotTrackCellBrushColor1 = FHotTrackCellBrushColor1) and
       (AHotTrackCellBrushColor2 = FHotTrackCellBrushColor2)
    then
    begin
      Result := FHotTrackCellBrushColor;
    end else
    begin
      WinLum := GetColorLuminance(AHotTrackCellBrushColor1);
      SelLum := GetColorLuminance(AHotTrackCellBrushColor2);
      LumDist := Abs(WinLum-SelLum);
      MaxLum := GetColorLuminance(clWhite);
      LumDistPerc := Trunc(LumDist / MaxLum * 100);
      if LumDistPerc < 20 then
        AprocPerc := 50
      else if LumDistPerc < 26 then
        AprocPerc := 40
      else if LumDistPerc < 32 then
        AprocPerc := 30
      else
        AprocPerc := 15;
      if WinLum < 128 then
        AprocPerc := AprocPerc + 10;

      FHotTrackCellBrushColor := ApproachToColorEh(AHotTrackCellBrushColor1, AHotTrackCellBrushColor2, AprocPerc);
      FHotTrackCellBrushColor1 := AHotTrackCellBrushColor1;
      FHotTrackCellBrushColor2 := AHotTrackCellBrushColor2;
      Result := FHotTrackCellBrushColor;
    end;
  end;
end;

function TDateTimeCalendarPickerDrawStyleEh.GetSelectedCellFontColor: TColor;
begin
  if CanDrawSelectionByStyle then
    Result := StyleServices.GetSystemColor(clWindowText)
  else
    Result := StyleServices.GetSystemColor(clHighlightText);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetSelectedCellBrushColor: TColor;
begin
  if CanDrawSelectionByStyle then
    Result := StyleServices.GetSystemColor(clWindow)
  else
    Result := StyleServices.GetSystemColor(clHighlight);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetOutsidePeriodCellFontColor: TColor;
begin
  Result := ApproachToColorEh(StyleServices.GetSystemColor(clWindow),
                              StyleServices.GetSystemColor(clWindowText), 50);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetInsideHorzFrameColor: TColor;
begin
  Result := ApproachToColorEh(StyleServices.GetSystemColor(clWindow),
                              StyleServices.GetSystemColor(clWindowText), 8);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetInsideVertFrameColor: TColor;
begin
  Result := ApproachToColorEh(StyleServices.GetSystemColor(clWindow),
                              StyleServices.GetSystemColor(clWindowText), 8);
end;

function TDateTimeCalendarPickerDrawStyleEh.GetTodayCellFrameColor: TColor;
begin
  Result := ApproachToColorEh(StyleServices.GetSystemColor(clHighlight),
                              StyleServices.GetSystemColor(clWindowText), 66);
end;

procedure TDateTimeCalendarPickerDrawStyleEh.SetCalendarFontData(
  Calendar: TDateTimeCalendarPickerEh; MasterFont, CalendarFont: TFont);
begin
  CalendarFont.Assign(MasterFont);
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  CalendarFont.Name := 'Segoe UI';
  {$ENDIF}
  CalendarFont.Size := Round(GetFontSize(MasterFont) + GetFontSize(MasterFont) * 0.1);
  CalendarFont.Color := DateTimeCalendarPickerDrawStyleEh.NormalCellFontColor;
end;

procedure TDateTimeCalendarPickerDrawStyleEh.SetCalendarWeekNoFontData(
  Calendar: TDateTimeCalendarPickerEh; CalendarFont, CalendarWeekNoFont: TFont);
begin
  CalendarWeekNoFont.Assign(CalendarFont);
  if (CalendarWeekNoFont.Color = 0) then
    CalendarWeekNoFont.Color := StyleServices.GetSystemColor(clWindowText);
  CalendarWeekNoFont.Size := Round(GetFontSize(CalendarWeekNoFont) * 0.8);
  if CalendarWeekNoFont.Size = GetFontSize(CalendarFont) then
    CalendarWeekNoFont.Size := GetFontSize(CalendarWeekNoFont) - 1;
end;

{ TDateTimePickCalendarPaintBufferEh }

constructor TDateTimePickCalendarPaintBufferEh.Create;
begin
  inherited Create;
  CalendarWeekNoFont := TFont.Create;
end;

destructor TDateTimePickCalendarPaintBufferEh.Destroy;
begin
  FreeAndNil(CalendarWeekNoFont);
  inherited Destroy;
end;

{ TPopupDateTimeCalendarFormEh }

constructor TPopupDateTimeCalendarFormEh.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
end;

procedure TPopupDateTimeCalendarFormEh.InitializeNewForm;
begin
  inherited InitializeNewForm;

  FormElements := [];
  BorderWidth := 0;
  KeyPreview := True;
  FormStyle := fsStayOnTop;

  Calendar := TDateTimeCalendarPickerEh.Create(Self);
  Calendar.Left := 0;
  Calendar.Top := 0;
  Calendar.Parent := Self;
  Calendar.DateTime := Now;
  Calendar.TimeUnits := [cdtuYearEh, cdtuMonthEh, cdtuDayEh, cdtuHourEh, cdtuMinuteEh, cdtuSecondEh];
  Calendar.OnDateTimeSelected := DateTimeSelected;
end;

procedure TPopupDateTimeCalendarFormEh.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_ESCAPE) then
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

procedure TPopupDateTimeCalendarFormEh.CreateHandle;
begin
  inherited CreateHandle;
  UpdateSize;
end;

procedure TPopupDateTimeCalendarFormEh.CreateWnd;
begin
  inherited CreateWnd;
end;

procedure TPopupDateTimeCalendarFormEh.DateTimeSelected(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

function TPopupDateTimeCalendarFormEh.GetDateTime: TDateTime;
begin
  Result := Calendar.DateTime;
end;

procedure TPopupDateTimeCalendarFormEh.SetDateTime(const Value: TDateTime);
begin
  Calendar.DateTime := Value;
end;

function TPopupDateTimeCalendarFormEh.GetTimeUnits: TCalendarDateTimeUnitsEh;
begin
  Result := Calendar.TimeUnits;
end;

procedure TPopupDateTimeCalendarFormEh.SetTimeUnits(const Value: TCalendarDateTimeUnitsEh);
begin
  Calendar.TimeUnits := Value;
end;

procedure TPopupDateTimeCalendarFormEh.UpdateSize;
begin
  inherited UpdateSize;
  Calendar.HandleNeeded;
  Width := Calendar.Width;
  Height := Calendar.Height;
end;

procedure TPopupDateTimeCalendarFormEh.SetFontOptions(Font: TFont;
  FontAutoSelect: Boolean);
begin
  Calendar.Font := Font;
  Calendar.RefreshFont;
  Calendar.ResetSize;
end;

procedure TPopupDateTimeCalendarFormEh.HidePicker;
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TPopupDateTimeCalendarFormEh.ShowPicker(DateTime: TDateTime;
  Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
var
  ForRect: TRect;
  DDParams: TDynVarsEh;
  SysParams: TEditControlDropDownFormSysParams;
begin
  Self.DateTime := DateTime;
  FCloseCallback := CloseCallback;

  DDParams := TDynVarsEh.Create(Self);
  SysParams := TEditControlDropDownFormSysParams.Create;

  ForRect.TopLeft := Pos;
  ForRect.BottomRight := ForRect.TopLeft;

  Calendar.ResetStartCalendarView;
  ExecuteNomodal(ForRect, nil, daLeft, DDParams, SysParams, DropDownFormCallbackProc);
end;

function TPopupDateTimeCalendarFormEh.WantKeyDown(Key: Word;
  Shift: TShiftState): Boolean;
begin
  Result := True;
end;

function TPopupDateTimeCalendarFormEh.WantFocus: Boolean;
begin
  Result := True;
end;

procedure TPopupDateTimeCalendarFormEh.DropDownFormCallbackProc(
  DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams);
begin
  DynParams.Free;
  SysParams.Free;

  FCloseCallback(Self, Accept);
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.

