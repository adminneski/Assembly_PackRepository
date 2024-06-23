{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                     Planner Component                 }
{                                                       }
{   Copyright (c) 2014-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PlannersEh;

interface

uses
  SysUtils, Messages, Controls, Forms, StdCtrls, TypInfo,
  DateUtils, ExtCtrls, Buttons, Dialogs, ImgList, GraphUtil,
  Contnrs, Variants, Types, Themes, Menus,
{$IFDEF EH_LIB_17}
  System.Generics.Collections,
  System.Generics.Defaults,
  System.UITypes,
{$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, PrintUtilsEh, Windows, UxTheme,
  {$ENDIF}
  Classes, PlannerDataEh, SpreadGridsEh,
  GridsEh, ToolCtrlsEh, ButtonsEh, Graphics;

type
  TCustomPlannerViewEh = class;
  TTimeSpanDisplayItemEh = class;
  TPlannerControlEh = class;
  TPlannerAxisTimelineViewEh = class;
  TPlannerDrawStyleEh = class;

  TDrawSpanItemDrawStateEh = set of (sidsSelectedEh, sidsFocusedEh);
  TPlannerControlButtonKindEh = (pcbkPriorPeriodEh, pcbkNextPeriodEh);

  TPlannerBarTimeIntervalEh = (pbti5MinEh, pbti6MinEh, pbti10MinEh, pbti15MinEh,
    pbti30MinEh, pbti60MinEh);

  TContextPopupEvent = procedure(Sender: TObject; MousePos: TPoint; var Handled: Boolean) of object;

  TPlannerSpanItemContextPopupEh = procedure(PlannerControl: TPlannerControlEh;
    PlannerView: TCustomPlannerViewEh; SpanItem: TTimeSpanDisplayItemEh;
    PlannerViewMousePos: TPoint; var Handled: Boolean) of object;

  IPlannerControlChangeReceiverEh = interface
    ['{532A2D57-0ADB-49A3-8D8F-A300CA7C8D5B}']
    procedure Change(Sender: TObject);
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime);
  end;

{ TDrawSpanItemArgsEh }

  TDrawSpanItemArgsEh = class(TPersistent)
  private
    FAlignment: TAlignment;
    FAltFillColor: TColor;
    FDrawState: TDrawSpanItemDrawStateEh;
    FFillColor: TColor;
    FFrameColor: TColor;
    FText: String;
    FFont: TFont;
    procedure SetFont(const Value: TFont);

  public
    constructor Create();
    destructor Destroy; override;

  published
    property Alignment: TAlignment read FAlignment write FAlignment;
    property AltFillColor: TColor read FAltFillColor write FAltFillColor;
    property DrawState: TDrawSpanItemDrawStateEh read FDrawState write FDrawState;
    property FillColor: TColor read FFillColor write FFillColor;
    property FrameColor: TColor read FFrameColor write FFrameColor;
    property Text: String read FText write FText;
    property Font: TFont read FFont write SetFont;

  end;

  TDrawSpanItemEventEh = procedure (PlannerControl: TPlannerControlEh;
    PlannerView: TCustomPlannerViewEh; SpanItem: TTimeSpanDisplayItemEh;
    Rect: TRect; DrawArgs: TDrawSpanItemArgsEh; var Processed: Boolean) of object;

  TTimeSpanBoundRectRelPosEh = (brrlWindowClientEh, brrlGridRolAreaEh);

  TPlannerResourceViewEh = record
    Resource: TPlannerResourceEh;
    GridOffset: Integer;
    GridStartAxisBar: Integer;
  end;

  TSpanInteractiveChange = (sichSpanLeftSizingEh, sichSpanRightSizingEh,
    sichSpanTopSizingEh, sichSpanButtomSizingEh, sichSpanMovingEh);
  TSpanInteractiveChanges = set of TSpanInteractiveChange;

  TTimeOrientationEh = (toHorizontalEh, toVerticalEh);
  TPropFillStyleEh = (fsDefaultEh, fsSolidEh, fsVerticalGradientEh, fsHorizontalGradientEh);

{ TDrawElementParamsEh }

  TDrawElementParamsEh = class(TPersistent)
  private
    FAltColor: TColor;
    FBorderColor: TColor;
    FColor: TColor;
    FFillStyle: TPropFillStyleEh;
    FFont: TFont;
    FFontStored: Boolean;
    FHue: TColor;

    function IsFontStored: Boolean;

    procedure SetAltColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetFillStyle(const Value: TPropFillStyleEh);
    procedure SetFont(const Value: TFont);
    procedure SetFontStored(const Value: Boolean);
    procedure SetHue(const Value: TColor);

  protected
    function DefaultFont: TFont; virtual;

    procedure NotifyChanges; virtual;
    procedure FontChanged(Sender: TObject);
    procedure RefreshDefaultFont;
    procedure AssignFontDefaultProps; virtual;

    function GetDefaultColor: TColor; virtual;
    function GetDefaultAltColor: TColor; virtual;
    function GetDefaultFillStyle: TPropFillStyleEh; virtual;
    function GetDefaultBorderColor: TColor; virtual;
    function GetDefaultHue: TColor; virtual;

    property AltColor: TColor read FAltColor write SetAltColor default clDefault;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clDefault;
    property Color: TColor read FColor write SetColor default clDefault;
    property FillStyle: TPropFillStyleEh read FFillStyle write SetFillStyle default fsDefaultEh;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property FontStored: Boolean read FFontStored write SetFontStored default False;
    property Hue: TColor read FHue write SetHue default clDefault;

  public
    constructor Create;
    destructor Destroy; override;

    function GetActualAltColor: TColor; virtual;
    function GetActualBorderColor: TColor; virtual;
    function GetActualColor: TColor; virtual;
    function GetActualFillStyle: TPropFillStyleEh; virtual;
    function GetActualHue: TColor; virtual;
  end;

{ TDataBarsAreaEh }

  TDataBarsAreaEh = class(TPersistent)
  private
    FBarSize: Integer;
    FColor: TColor;
    FPlannerView: TCustomPlannerViewEh;

    procedure SetColor(const Value: TColor);
    procedure SetBarSize(const Value: Integer);

  protected
    function DefaultBarSize: Integer; virtual;
    function DefaultColor: TColor; virtual;
    function GetActualBarSize: Integer; virtual;
    function GetActualColor: TColor; virtual;

    procedure NotifyChanges; virtual;

    property BarSize: Integer read FBarSize write SetBarSize default 0;
    property Color: TColor read FColor write SetColor default clDefault;
    property PlannerView: TCustomPlannerViewEh read FPlannerView;

  public
    constructor Create(APlannerView: TCustomPlannerViewEh);
    destructor Destroy; override;
  end;

{ TDataBarsVertAreaEh }

  TDataBarsVertAreaEh = class(TDataBarsAreaEh)
  private
    function GetRowHeight: Integer;
    procedure SetRowHeight(const Value: Integer);

  protected
    function GetActualRowHeight: Integer; virtual;

  published
    property Color;
    property RowHeight: Integer read GetRowHeight write SetRowHeight default 0;
  end;

{ TDataBarsHorzAreaEh }

  TDataBarsHorzAreaEh = class(TDataBarsAreaEh)
  private
    function GetColWidth: Integer;
    procedure SetColWidth(const Value: Integer);

  protected
    function GetActualColWidth: Integer; virtual;

  published
    property Color;
    property ColWidth: Integer read GetColWidth write SetColWidth default 0;
  end;

{ TPlannerViewDrawElementEh }

  TPlannerViewDrawElementEh = class(TPersistent)
  private
    FColor: TColor;
    FFont: TFont;
    FFontStored: Boolean;
    FPlannerView: TCustomPlannerViewEh;
    FSize: Integer;
    FVisible: Boolean;
    FVisibleStored: Boolean;

    function GetVisible: Boolean;
    function IsFontStored: Boolean;

    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetFontStored(const Value: Boolean);
    procedure SetSize(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetVisibleStored(const Value: Boolean);

  protected
    function DefaultColor: TColor; virtual;
    function DefaultFont: TFont; virtual;
    function DefaultSize: Integer; virtual;
    function DefaultVisible: Boolean; virtual;
    function IsVisibleStored: Boolean; virtual;

    procedure AssignFontDefaultProps; virtual;
    procedure FontChanged(Sender: TObject); virtual;
    procedure NotifyChanges; virtual;

    property PlannerView: TCustomPlannerViewEh read FPlannerView;

    property Color: TColor read FColor write SetColor default clDefault;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property FontStored: Boolean read FFontStored write SetFontStored default False;
    property Size: Integer read FSize write SetSize default 0;
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored;
    property VisibleStored: Boolean read IsVisibleStored write SetVisibleStored stored False;

  public
    function GetActualColor: TColor; virtual;
    function GetActualSize: Integer; virtual;

    procedure RefreshDefaultFont; virtual;

    constructor Create(APlannerView: TCustomPlannerViewEh);
    destructor Destroy; override;
  end;

{ THoursBarAreaEh }

  THoursBarAreaEh = class(TPlannerViewDrawElementEh)
  protected
    function DefaultColor: TColor; override;
    function DefaultFont: TFont; override;
    function DefaultSize: Integer; override;
    function DefaultVisible: Boolean; override;

    procedure AssignFontDefaultProps; override;
  end;

{ THoursVertBarAreaEh }

  THoursVertBarAreaEh = class(THoursBarAreaEh)
  private
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);

  published
    property Color;
    property Font;
    property FontStored;
    property Visible;
    property VisibleStored;
    property Width: Integer read GetWidth write SetWidth default 0;
  end;

{ THoursHorzBarAreaEh }

  THoursHorzBarAreaEh = class(THoursBarAreaEh)
  private
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);

  published
    property Color;
    property Font;
    property FontStored;
    property Height: Integer read GetHeight write SetHeight default 0;
    property Visible;
    property VisibleStored;
  end;

{ TWeekBarAreaEh }

  TWeekBarAreaEh = class(THoursVertBarAreaEh)
  protected
    procedure AssignFontDefaultProps; override;
  end;

{ TDayNameAreaEh }

  TDayNameAreaEh = class(TPlannerViewDrawElementEh)
  protected
    function DefaultColor: TColor; override;
    function DefaultFont: TFont; override;
    function DefaultSize: Integer; override;
    function DefaultVisible: Boolean; override;
  end;

{ TDayNameVertAreaEh }

  TDayNameVertAreaEh = class(TDayNameAreaEh)
  private
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
  public
    function GetActualHeight: Integer; virtual;
  published
    property Color;
    property Font;
    property FontStored;
    property Height: Integer read GetHeight write SetHeight default 0;
    property Visible;
    property VisibleStored;
  end;

{ TDayNameHorzAreaEh }

  TDayNameHorzAreaEh = class(TDayNameAreaEh)
  private
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);

  public
    function GetActualWidth: Integer; virtual;

  published
    property Color;
    property Font;
    property FontStored;
    property Visible;
    property VisibleStored;
    property Width: Integer read GetWidth write SetWidth default 0;
  end;

{ TResourceCaptionAreaEh }

  TResourceCaptionAreaEh = class(TPlannerViewDrawElementEh)
  private
    FEnhancedChanges: Boolean;
    function GetVisible: Boolean;

    procedure SetVisible(const Value: Boolean);

  protected
    function DefaultFont: TFont; override;
    function DefaultVisible: Boolean; override;
    function DefaultColor: TColor; override;
    function DefaultSize: Integer; override;

    procedure NotifyChanges; override;

  public
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored;
  end;

{ TResourceVertCaptionAreaEh }

  TResourceVertCaptionAreaEh = class(TResourceCaptionAreaEh)
  private
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);

  published
    property Color;
    property Font;
    property FontStored;
    property Height: Integer read GetHeight write SetHeight default 0;
    property Visible;
    property VisibleStored;
  end;

{ TResourceHorzCaptionAreaEh }

  TResourceHorzCaptionAreaEh = class(TResourceCaptionAreaEh)
  private
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);

  published
    property Color;
    property Font;
    property FontStored;
    property Visible;
    property VisibleStored;
    property Width: Integer read GetWidth write SetWidth default 0;
  end;

{ TDatesBarAreaEh }

  TDatesBarAreaEh = class(TPlannerViewDrawElementEh)
  private
    function GetPlannerView: TPlannerAxisTimelineViewEh;

  protected
    function DefaultVisible: Boolean; override;
    function DefaultSize: Integer; override;

    property PlannerView: TPlannerAxisTimelineViewEh read GetPlannerView;
  end;

{ TDatesColAreaEh }

  TDatesColAreaEh = class(TDatesBarAreaEh)
  private
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);

  published
    property Color;
    property Font;
    property FontStored;
    property Visible;
    property VisibleStored;
    property Width: Integer read GetWidth write SetWidth default 0;
  end;

{ TDatesRowAreaEh }

  TDatesRowAreaEh = class(TDatesBarAreaEh)
  private
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);

  published
    property Color;
    property Font;
    property FontStored;
    property Height: Integer read GetHeight write SetHeight default 0;
    property Visible;
    property VisibleStored;
  end;

{ TInGridControlEh }

  TInGridControlEh = class(TPersistent)
  private
    FBoundRect: TRect;
    FGrid: TCustomPlannerViewEh;
    FVisible: Boolean;

  protected
    FHorzLocating: TTimeSpanBoundRectRelPosEh;
    FVertLocating: TTimeSpanBoundRectRelPosEh;

    procedure DblClick; virtual;

  public
    constructor Create(AGrid: TCustomPlannerViewEh);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure GetInGridDrawRect(var ARect: TRect);

    property BoundRect: TRect read FBoundRect write FBoundRect;
    property HorzLocating: TTimeSpanBoundRectRelPosEh read FHorzLocating;
    property PlannerView: TCustomPlannerViewEh read FGrid;
    property VertLocating: TTimeSpanBoundRectRelPosEh read FVertLocating;
    property Visible: Boolean read FVisible write FVisible;
  end;

{ TTimeSpanDisplayItemEh }

  TTimeSpanDisplayItemEh = class(TInGridControlEh)
  private
    FEndTime: TDateTime;
    FInCellFromRow: Integer;
    FInCellRows: Integer;
    FStartTime: TDateTime;

  protected
    FAlignment: TAlignment;
    FAllowedInteractiveChanges: TSpanInteractiveChanges;
    FDrawBackOutInfo: Boolean;
    FDrawForwardOutInfo: Boolean;
    FStartGridRollPos: Integer;
    FStopGridRolPos: Integer;
    FTimeOrientation: TTimeOrientationEh;
    FInCellCols: Integer;
    FInCellFromCol: Integer;
    FInCellToCol: Integer;
    FInCellToRow: Integer;
    FGridColNum: Integer;
    FPlanItem: TPlannerDataItemEh;

  public
    constructor Create(AGrid: TCustomPlannerViewEh; APlanItem: TPlannerDataItemEh); reintroduce;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure DblClick; override;

    property Alignment: TAlignment read FAlignment write FAlignment;
    property AllowedInteractiveChanges: TSpanInteractiveChanges read FAllowedInteractiveChanges;
    property DrawBackOutInfo: Boolean read FDrawBackOutInfo;
    property DrawForwardOutInfo: Boolean read FDrawForwardOutInfo;
    property EndTime: TDateTime read FEndTime write FEndTime;
    property GridColNum: Integer read FGridColNum;
    property InCellCols: Integer read FInCellCols;
    property InCellFromCol: Integer read FInCellFromCol;
    property InCellFromRow: Integer read FInCellFromRow;
    property InCellRows: Integer read FInCellRows;
    property InCellToCol: Integer read FInCellToCol;
    property InCellToRow: Integer read FInCellToRow;
    property PlanItem: TPlannerDataItemEh read FPlanItem;
    property StartGridRollPos: Integer read FStartGridRollPos;
    property StartTime: TDateTime read FStartTime write FStartTime;
    property StopGridRolPosl: Integer read FStopGridRolPos;
    property TimeOrientation: TTimeOrientationEh read FTimeOrientation;
  end;

{ TDummyTimeSpanDisplayItemEh }

  TDummyTimeSpanDisplayItemEh = class(TTimeSpanDisplayItemEh)
  private
    FStartTime: TDateTime;
    FEndTime: TDateTime;
    procedure SetEndTime(const Value: TDateTime);
    procedure SetStartTime(const Value: TDateTime);

  public
    procedure Assign(Source: TPersistent); override;

    property EndTime: TDateTime read FEndTime write SetEndTime;
    property StartTime: TDateTime read FStartTime write SetStartTime;
  end;

  TPlannerGridControlTypeEh = (pgctNextEventEh, pgctPriorEventEh);

{ TPlannerInGridControlEh }

  TPlannerInGridControlEh = class(TCustomControl)
  private
    FGrid: TCustomPlannerViewEh;
    FControlType: TPlannerGridControlTypeEh;
    FClickEnabled: Boolean;

  protected
    procedure Paint; override;

  public

    constructor Create(AGrid: TCustomPlannerViewEh); reintroduce;
    destructor Destroy; override;

    procedure Click; override;
    procedure Realign;

    property ControlType: TPlannerGridControlTypeEh read FControlType;
    property ClickEnabled: Boolean read FClickEnabled write FClickEnabled;
  end;

  TMoveHintWindow = class(THintWindow)
  private
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  end;

{ TPlannerGridLineParamsEh }

  TPlannerGridLineParamsEh = class(TGridLineColorsEh)
  private
    FPaleColor: TColor;
    procedure SetPaleColor(const Value: TColor);
    function GetPlannerView: TCustomPlannerViewEh;
  protected
    property PlannerView: TCustomPlannerViewEh read GetPlannerView;
  public
    constructor Create(AGrid: TCustomGridEh);

    function DefaultPaleColor: TColor; virtual;
    function GetBrightColor: TColor; override;
    function GetDarkColor: TColor; override;
    function GetPaleColor: TColor; virtual;

  published
    property BrightColor;
    property DarkColor;
    property PaleColor: TColor read FPaleColor write SetPaleColor default clDefault;
  end;

{ TPlannerViewCellDrawArgsEh }

  TPlannerViewCellDrawArgsEh = class(TObject)
  public
    Alignment: TAlignment;
    BackColor: TColor;
    FontColor: TColor;
    FontName: String;
    FontSize: Integer;
    FontStyle: TFontStyles;
    HighlightToday: Boolean;
    HorzMargin: Integer;
    Layout: TTextLayout;
    Orientation: TTextOrientationEh;
    Resource: TPlannerResourceEh;
    Text: String;
    TodayDate: TStateBooleanEh;
    Value: Variant;
    VertMargin: Integer;
    WordWrap: Boolean;
    WorkTime: TStateBooleanEh;

    destructor Destroy; override;
  end;

{ TPlannerViewTimeCellDrawArgsEh }

  TPlannerViewTimeCellDrawArgsEh = class(TPlannerViewCellDrawArgsEh)
  public
    DrawTimeLine: Boolean;
    DrawTimeRect: TRect;
    HoursFontSize: Integer;
    HoursStr: String;
    MinutesFontSize: Integer;
    MinutesStr: String;
    Time: TTime;
  end;

{ TPlannerViewDayNamesCellDrawArgsEh }

  TPlannerViewDayNamesCellDrawArgsEh = class(TPlannerViewCellDrawArgsEh)
  public
    DrawMonthDay: Boolean;
    DrawTopToDayLine: Boolean;
    MonthDay: String;
    MonthDayFontStyle: TFontStyles;
  end;

  TPlannerViewSpanHintParamsEh = class(TObject)
  public
    CursorRect: TRect;
    HideTimeout: Integer;
    HintColor: TColor;
    HintFont: TFont;
    HintMaxWidth: Integer;
    HintPos: TPoint;
    HintStr: string;
    ReshowTimeout: Integer;
  end;

{ TPlannerViewSelectedRangeEh }

  TPlannerViewSelectedRangeEh = class(TObject)
  private
    FFromDateTime: TDateTime;
    FToDateTime: TDateTime;
    FResource: TPlannerResourceEh;
  public
    property FromDateTime: TDateTime read FFromDateTime;
    property ToDateTime: TDateTime read FToDateTime;
    property Resource: TPlannerResourceEh read FResource;
  end;

  TPlannerDateRangeModeEh = (pdrmDayEh, pdrmWeekEh, pdrmMonthEh,
    pdrmEventsListEh, pdrmVertTimeBandEh, pdrmHorzTimeBandEh);

  TDayNameFormatEh = (dnfLongFormatEh, dnfShortFormatEh, dnfNonEh);
  TRectangleSideEh = (rsLeftEh, rsRightEh, rsTopEh, rsBottomEh);
  TPlannerStateEh = (psNormalEh, psSpanLeftSizingEh, psSpanRightSizingEh,
    psSpanTopSizingEh, psSpanButtomSizingEh, psSpanMovingEh, psSpanTestMovingEh,
    psCellsRangeSelectionEh);
  TTimeUnitEh = (tuMSecEh, tuSecEh, tiMinEh, tuHourEh, tuDayEh, tuWeekEh, tuMonth, tuYear);
  TPlannerCoveragePeriodTypeEh = (pcpDayEh, pcpWeekEh, pcpMonthEh, pcpYearEh);
  TPlannerViewCellTypeEh = (pctTopLeftCellEh, pctDataCellEh, pctAlldayDataCellEh,
    pctResourceCaptionCellEh, pctInterResourceSpaceEh, pctDayNameCellEh,
    pctDateBarEh, pctDateCellEh, pctTimeCellEh, pctWeekNoCellEh,
    pctTopGridLineCellEh, pctMonthNameCellEh);

  TPlannerViewDrawCellEventEh = procedure (PlannerView: TCustomPlannerViewEh;
    ACol, ARow: Integer; ARect: TRect; State: TGridDrawState;
    CellType: TPlannerViewCellTypeEh; ALocalCol, ALocalRow: Integer;
    ADrawCellArgs: TPlannerViewCellDrawArgsEh; var Processed: Boolean) of object;

  TPlannerViewSpanItemHintShowEventEh = procedure(PlannerControl: TPlannerControlEh;
    PlannerView: TCustomPlannerViewEh; CursorPos: TPoint; SpanRect: TRect;
    InSpanCursorPos: TPoint; SpanItem: TTimeSpanDisplayItemEh;
    Params: TPlannerViewSpanHintParamsEh; var Processed: Boolean) of object;

  TPlannerViewReadDataItemEventEh = procedure(PlannerControl: TPlannerControlEh;
    PlannerView: TCustomPlannerViewEh; DataItem: TPlannerDataItemEh; var ReadDataItem: Boolean) of object;

  TPlannerGridOptionEh = (pgoAddEventOnDoubleClickEh);
  TPlannerGridOptionsEh = set of TPlannerGridOptionEh;

{ TCustomPlannerViewEh }

  TCustomPlannerViewEh = class(TCustomSpreadGridEh)
  private
    FActiveMode: Boolean;
    FAmPmPos: TAmPmPosEh;
    FCurrentTime: TDateTime;
    FDataBarsArea: TDataBarsAreaEh;
    FDayNameArea: TDayNameAreaEh;
    FFirstGridDayNum: Integer;
    FHintFont: TFont;
    FHoursBarArea: THoursBarAreaEh;
    FHoursFormat: THoursTimeFormatEh;
    FInvalidateTime: TTimer;
    FMouseDoubleClickProcessed: Boolean;
    FOptions: TPlannerGridOptionsEh;
    FRangeMode: TPlannerDateRangeModeEh;
    FResourceCaptionArea: TResourceCaptionAreaEh;
    FResourceCellFillColor: TColor;
    FSelectedPlanItem: TPlannerDataItemEh;
    FSpanItems: TObjectListEh;
    FSelectedRange: TPlannerViewSelectedRangeEh;

    FOnDrawCell: TPlannerViewDrawCellEventEh;
    FOnReadPlannerDataItem: TPlannerViewReadDataItemEventEh;
    FOnSelectionChanged: TNotifyEvent;
    FOnSpanItemHintShow: TPlannerViewSpanItemHintShowEventEh;

    function CheckStartSpanMove(MousePos: TPoint): Boolean;
    function GetGridIndex: Integer;
    function GetGridLineParams: TPlannerGridLineParamsEh;
    function GetPlannerDataSource: TPlannerDataSourceEh;
    function GetSpanItems(Index: Integer): TTimeSpanDisplayItemEh;
    function GetSpanItemsCount: Integer;

    procedure DrawSpanItem(SpanItem: TTimeSpanDisplayItemEh; DrawRect: TRect);
    procedure RecreateDummyData;
    procedure SetActiveMode(const Value: Boolean);
    procedure SetCurrentTime(const Value: TDateTime);
    procedure SetDataBarsArea(const Value: TDataBarsAreaEh);
    procedure SetDayNameArea(const Value: TDayNameAreaEh);
    procedure SetGridIndex(const Value: Integer);
    procedure SetGridLineParams(const Value: TPlannerGridLineParamsEh);
    procedure SetHoursBarArea(const Value: THoursBarAreaEh);
    procedure SetOptions(const Value: TPlannerGridOptionsEh);
    procedure SetRangeMode(const Value: TPlannerDateRangeModeEh);
    procedure SetResourceCaptionArea(const Value: TResourceCaptionAreaEh);
    procedure SetSelectedSpanItem(const Value: TPlannerDataItemEh);
    procedure SetStartDate(const Value: TDateTime);
    procedure StartSpanMove(SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint);

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    {$IFDEF FPC}
    {$ELSE}
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
    {$ENDIF}

    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;

  protected
    FBarsPerRes: Integer;
    FDataColsOffset: Integer;
    FDataRowsOffset: Integer;
    FDayNameBarPos: Integer;
    FDayNameFormat: TDayNameFormatEh;
    FDefaultTimeSpanBoxHeight: Integer;
    FDrawCellArgs: TPlannerViewCellDrawArgsEh;
    FDrawTimeCellArgs: TPlannerViewTimeCellDrawArgsEh;
    FDayNamesCellArgs: TPlannerViewDayNamesCellDrawArgsEh;
    FDrawSpanItemArgs: TDrawSpanItemArgsEh;
    FDummyCheckPlanItem: TPlannerDataItemEh;
    FDummyPlanItem: TPlannerDataItemEh;
    FDummyPlanItemFor: TPlannerDataItemEh;
    FFirstWeekDayNum: Integer;
    FGridControls: TObjectListEh;
    FHoursBarIndex: Integer;
    FIgnorePlannerDataSourceChanged: Boolean;
    FMouseDownPos: TPoint;
    FMoveHintWindow: THintWindow;
    FPlannerState: TPlannerStateEh;
    FResourceAxisPos: Integer;
    FResourcesView: array of TPlannerResourceViewEh;
    FSelectedFocusedCellColor: TColor;
    FSelectedUnfocusedCellColor: TColor;
    FShowUnassignedResource: Boolean;
    FSlideDirection: TGridScrollDirection;
    FSpanFrameColor: TColor;
    FSpanMoveSlidingSpeed: Integer;
    FSpanMoveSlidingTimer: TTimer;
    FStartDate: TDateTime;
    FTopGridLineIndex: Integer;
    FTopLeftSpanShift: TSize;
    FRangeSelecting: Boolean;

    function CreateGridLineColors: TGridLineColorsEh; override;

    function AddSpanItem(APlanItem: TPlannerDataItemEh): TTimeSpanDisplayItemEh; virtual;
    function AdjustDate(const Value: TDateTime): TDateTime; virtual;
    function AmPm12: Boolean; virtual;
    function CanSpanMoveSliding(MousePos: TPoint; var ASpeed: Integer; var ASlideDirection: TGridScrollDirection): Boolean;
    function CellToDateTime(ACol, ARow: Integer): TDateTime; virtual;
    function CheckHitSpanItem(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): TTimeSpanDisplayItemEh; virtual;
    function CheckPlanItemForRead(APlanItem: TPlannerDataItemEh): Boolean; virtual;
    function CheckSpanItemSizing(MousePos: TPoint; out SpanItem: TTimeSpanDisplayItemEh; var Side: TRectangleSideEh): Boolean; virtual;
    function ClientToGridRolPos(Pos: TPoint): TPoint; virtual;
    function CreateDataBarsArea: TDataBarsAreaEh; virtual;
    function CreateDayNameArea: TDayNameAreaEh; virtual;
    function CreateHoursBarArea: THoursBarAreaEh; virtual;
    function CreateResourceCaptionArea: TResourceCaptionAreaEh; virtual;
    function DefaultHoursBarSize: Integer; virtual;
    function DrawLongDayNames: Boolean; virtual;
    function DrawMonthDayWithWeekDayName: Boolean; virtual;
    function EventNavBoxBorderColor: TColor; virtual;
    function EventNavBoxColor: TColor; virtual;
    function EventNavBoxFont: TFont; virtual;
    function GetCellDrawArgs(CellType: TPlannerViewCellTypeEh): TPlannerViewCellDrawArgsEh; virtual;
    function GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh; virtual;
    function GetDataBarsAreaDefaultBarSize: Integer; virtual;
    function GetDataCellTimeLength: TDateTime; virtual;
    function GetDayNameAreaDefaultColor: TColor; virtual;
    function GetDayNameAreaDefaultFont: TFont; virtual;
    function GetDayNameAreaDefaultSize: Integer; virtual;
    function GetNextEventAfter(ADateTime: TDateTime): Variant; virtual;
    function GetNextEventBefore(ADateTime: TDateTime): Variant; virtual;
    function GetPlannerControl: TPlannerControlEh;
    function GetResourceAtCell(ACol, ARow: Integer): TPlannerResourceEh; virtual;
    function GetResourceCaptionAreaDefaultSize: Integer; virtual;
    function GetResourceNonworkingTimeBackColor(Resource: TPlannerResourceEh; BackColor, FontColor: TColor): TColor; virtual;
    function GetResourceViewAtCell(ACol, ARow: Integer): Integer; virtual;
    function GridCoordToDataCoord(const AGridCoord: TGridCoord): TGridCoord;
    function InteractiveChangeAllowed: Boolean; virtual;
    function IsDayNameAreaNeedVisible: Boolean; virtual;
    function IsDrawCurrentTimeLineForCell(CellType: TPlannerViewCellTypeEh): Boolean; virtual;
    function IsResourceCaptionNeedVisible: Boolean; virtual;
    function IsWorkingDay(const Value: TDateTime): Boolean; virtual;
    function IsWorkingTime(const Value: TDateTime): Boolean; virtual;
    function NewItemParams(var StartTime, EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean; virtual;
    function PlannerStartOfTheWeek(const AValue: TDateTime): TDateTime; virtual;
    function ResourcesCount: Integer; virtual;
    function ShowTopGridLine: Boolean; virtual;
    function SpanItemByPlanItem(APlanItem: TPlannerDataItemEh): TTimeSpanDisplayItemEh; virtual;
    function TopGridLineCount: Integer; virtual;

    procedure CancelMode; override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CreateWnd; override;
    procedure CurrentCellMoved(OldCurrent: TGridCoord); override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure ReadState(Reader: TReader); override;
    procedure Resize; override;
    procedure SetCellCanvasParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure SetPaintColors; override;
    procedure SetParent(AParent: TWinControl); override;

    procedure BuildGridData; virtual;
    procedure CalcRectForInCellCols(SpanItem: TTimeSpanDisplayItemEh; var DrawRect: TRect); virtual;
    procedure CalcRectForInCellRows(SpanItem: TTimeSpanDisplayItemEh; var DrawRect: TRect); virtual;
    procedure CellsRangeToTimeRange(Cell1, Cell2: TGridCoord; out TimeFrom, TimeTo: TDateTime; out Resource1, Resource2: TPlannerResourceEh); virtual;
    procedure CheckSetDummyPlanItem(Item, NewItem: TPlannerDataItemEh); virtual;
    procedure ClearGridCells;
    procedure ClearSpanItems; virtual;
    procedure CreateGridControls; virtual;
    procedure DeleteGridControls; virtual;
    procedure EnsureDataForPeriod(AStartDate, AEndDate: TDateTime); virtual;
    procedure GetCellType(ACol, ARow: Integer; var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer); virtual;
    procedure GetCurrentTimeLineRect(var CurTLRect: TRect); virtual;
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime); virtual;
    procedure GetWeekDayNamesParams(ACol, ARow, ALocalCol, ALocalRow: Integer; var WeekDayNum: Integer; var WeekDayName: String); virtual;
    procedure GotoNextEventInTheFuture; virtual;
    procedure GotoPriorEventInThePast; virtual;
    procedure GridLayoutChanged; virtual;
    procedure GroupSpanItems; virtual;
    procedure HideMoveHintWindow; virtual;
    procedure InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh); virtual;
    procedure InitSpanItemMoving(SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint); virtual;
    procedure MakeSpanItems; virtual;
    procedure NotifyPlanItemChanged(Item, OldItem: TPlannerDataItemEh); virtual;
    procedure PaintSpanItems; virtual;
    procedure PlannerDataSourceChanged;
    procedure PlannerStateChanged(AOldState: TPlannerStateEh); virtual;
    procedure ProcessedSpanItems;
    procedure RangeModeChanged; virtual;
    procedure ReadPlanItem(APlanItem: TPlannerDataItemEh); virtual;
    procedure RealignGridControl(AGridControl: TPlannerInGridControlEh); virtual;
    procedure RealignGridControls; virtual;
    procedure ResetAllData;
    procedure ResetSelectedRange; virtual;
    procedure ResetDayNameFormat(LongDayFacor, ShortDayFacor: Double); virtual;
    procedure ResetGridControlsState; virtual;
    procedure ResetLoadedTimeRange;
    procedure ResetResviewArray; virtual;
    procedure SelectionChanged; reintroduce; virtual;
    procedure SetDisplayPosesSpanItems; virtual;
    procedure SetGroupPosesSpanItems(Resource: TPlannerResourceEh); virtual;
    procedure SetPlannerState(ANewState: TPlannerStateEh); virtual;
    procedure SetSelectionRange(Cell1, Cell2: TGridCoord); virtual;
    procedure ShowMoveHintWindow(APlanItem: TPlannerDataItemEh; MousePos: TPoint); virtual;
    procedure SlidingTimerEvent(Sender: TObject); virtual;
    procedure SortPlanItems; virtual;
    procedure StartDateChanged; virtual;
    procedure StartSpanMoveSliding(ASpeed: Integer; ASlideDirection: TGridScrollDirection); virtual;
    procedure StopPlannerState(Accept: Boolean; X, Y: Integer);
    procedure StopSpanMoveSliding; virtual;
    procedure TimerEvent(Sender: TObject); virtual;
    procedure UpdateDefaultTimeSpanBoxHeight; virtual;
    procedure UpdateDummySpanItemSize(MousePos: TPoint); virtual;
    procedure UpdateLocaleInfo;
    procedure UpdateSelectedPlanItem; virtual;

    property HoursBarArea: THoursBarAreaEh read FHoursBarArea write SetHoursBarArea;
    property ResourceCaptionArea: TResourceCaptionAreaEh read FResourceCaptionArea write SetResourceCaptionArea;
    property DayNameArea: TDayNameAreaEh read FDayNameArea write SetDayNameArea;
    property DataBarsArea: TDataBarsAreaEh read FDataBarsArea write SetDataBarsArea;
    property RangeMode: TPlannerDateRangeModeEh read FRangeMode write SetRangeMode default pdrmDayEh;
    property ResourceCellFillColor: TColor read FResourceCellFillColor;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DeletePrompt: Boolean;
    function NextDate: TDateTime; virtual;
    function PriorDate: TDateTime; virtual;
    function AppendPeriod(ATime: TDateTime; Periods: Integer): TDateTime; virtual;
    function GetPeriodCaption: String; virtual;

    procedure CoveragePeriod(var AFromTime, AToTime: TDateTime); virtual;
    procedure DefaultDrawPlannerViewCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; CellType: TPlannerViewCellTypeEh; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DefaultDrawSpanItem(SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure DefaultFillSpanItemHintShowParams(CursorPos: TPoint; SpanRect: TRect; InSpanCursorPos: TPoint; SpanItem: TTimeSpanDisplayItemEh; Params: TPlannerViewSpanHintParamsEh); virtual;

    procedure DrawAlldayDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawDateBar(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawDateCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawDayNamesCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawDayNamesCellBack(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawDayNamesCellFore(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawMonthNameCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawInterResourceCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawResourceCaptionCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawSpanItemBackgroud(SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure DrawSpanItemContent(SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure DrawSpanItemSurround(SpanItem: TTimeSpanDisplayItemEh; var ARect: TRect; DrawArgs: TDrawSpanItemArgsEh); virtual;
    procedure DrawTimeCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawTopLeftCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawWeekNoCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawCurTimeLineRect(ATimeLineRect: TRect; const ClipRect: TRect); virtual;

    procedure GetAlldayDataCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetDataCellDrawParams(ACol, ARow: Integer; ARect: TRect; var State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetDateBarDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetDateCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetDayNamesCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetDrawCellParams(ACol, ARow: Integer; ARect: TRect; var State: TGridDrawState; CellType: TPlannerViewCellTypeEh; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetInterResourceCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetResourceCaptionCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetTimeCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetTopLeftCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetWeekNoCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure GetMonthNameCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure NextPeriod; virtual;
    procedure PriorPeriod; virtual;

    property Col;
    property Row;
    property Canvas;
    property PopupMenu;

    property ActiveMode: Boolean read FActiveMode write SetActiveMode;
    property CoveragePeriodType: TPlannerCoveragePeriodTypeEh read GetCoveragePeriodType;
    property CurrentTime: TDateTime read FCurrentTime write SetCurrentTime;
    property GridLineParams: TPlannerGridLineParamsEh read GetGridLineParams write SetGridLineParams;
    property Options: TPlannerGridOptionsEh read FOptions write SetOptions default [pgoAddEventOnDoubleClickEh];
    property PlannerControl: TPlannerControlEh read GetPlannerControl;
    property PlannerDataSource: TPlannerDataSourceEh read GetPlannerDataSource;
    property RangeSelecting: Boolean read FRangeSelecting;
    property SelectedRange: TPlannerViewSelectedRangeEh read FSelectedRange;
    property SelectedPlanItem: TPlannerDataItemEh read FSelectedPlanItem write SetSelectedSpanItem;
    property SpanItems[Index: Integer]: TTimeSpanDisplayItemEh read GetSpanItems;
    property SpanItemsCount: Integer read GetSpanItemsCount;
    property StartDate: TDateTime read FStartDate write SetStartDate;
    property ViewIndex: Integer read GetGridIndex write SetGridIndex stored False;

    property OnDrawCell: TPlannerViewDrawCellEventEh read FOnDrawCell write FOnDrawCell;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnSpanItemHintShow: TPlannerViewSpanItemHintShowEventEh read FOnSpanItemHintShow write FOnSpanItemHintShow;
    property OnReadPlannerDataItem: TPlannerViewReadDataItemEventEh read FOnReadPlannerDataItem write FOnReadPlannerDataItem;

    property OnContextPopup;
    property OnMouseDown;
{$IFDEF EH_LIB_11}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
{$IFDEF FPC}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
  end;

  TCustomPlannerGridClassEh = class of TCustomPlannerViewEh;

{ TPlannerWeekViewEh }

  TPlannerWeekViewEh = class(TCustomPlannerViewEh)
  private
    FBarTimeInterval: TPlannerBarTimeIntervalEh;
    FGridStartWorkingTime: TTime;
    FGridWorkingTimeLength: TDateTime;
    FMinDayColWidth: Integer;
    FShowWorkingTimeOnly: Boolean;

    function GetAllDayListCount: Integer;
    function GetAllDayListItem(Index: Integer): TTimeSpanDisplayItemEh;
    function GetColsStartTime(ADayCol: Integer): TDateTime;
    function GetDataBarsArea: TDataBarsVertAreaEh;
    function GetDayNameArea: TDayNameVertAreaEh;
    function GetHoursColArea: THoursVertBarAreaEh;
    function GetInDayListCount: Integer;
    function GetInDayListItem(Index: Integer): TTimeSpanDisplayItemEh;
    function GetResourceCaptionArea: TResourceVertCaptionAreaEh;

    procedure SetBarTimeInterval(const Value: TPlannerBarTimeIntervalEh);
    procedure SetDataBarsArea(const Value: TDataBarsVertAreaEh);
    procedure SetDayNameArea(const Value: TDayNameVertAreaEh);
    procedure SetGridShowHours;
    procedure SetHoursColArea(const Value: THoursVertBarAreaEh);
    procedure SetMinDayColWidth(const Value: Integer);
    procedure SetResourceCaptionArea(const Value: TResourceVertCaptionAreaEh);
    procedure SetShowWorkingTimeOnly(const Value: Boolean);

  protected
    FAllDayLinesCount: Integer;
    FAllDayList: TObjectListEh;
    FAllDayRowIndex: Integer;
    FBarsPerHour: Integer;
    FBarTimeLength: TTime;
    FColDaysLength: Integer;
    FDayCols: Integer;
    FInDayList: TObjectListEh;
    FInterResourceCols: Integer;
    FRolRowCount: Integer;
    FRowMinutesLength: Integer;

    function AdjustDate(const Value: TDateTime): TDateTime; override;
    function CellToDateTime(ACol, ARow: Integer): TDateTime; override;
    function CheckHitSpanItem(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): TTimeSpanDisplayItemEh; override;
    function CreateDayNameArea: TDayNameAreaEh; override;
    function CreateHoursBarArea: THoursBarAreaEh; override;
    function CreateResourceCaptionArea: TResourceCaptionAreaEh; override;
    function DefaultHoursBarSize: Integer; override;
    function DrawLongDayNames: Boolean; override;
    function DrawMonthDayWithWeekDayName: Boolean; override;
    function GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh; override;
    function GetDataCellTimeLength: TDateTime; override;
    function GetResourceAtCell(ACol, ARow: Integer): TPlannerResourceEh; override;
    function GetResourceViewAtCell(ACol, ARow: Integer): Integer; override;
    function IsDayNameAreaNeedVisible: Boolean; override;
    function NewItemParams(var StartTime, EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean; override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;

    function GetGridOffsetForResource(Resource: TPlannerResourceEh): Integer; virtual;
    function IsInterResourceCell(ACol, ARow: Integer): Boolean; virtual;
    function IsPlanItemHitAllGridArea(APlanItem: TPlannerDataItemEh): Boolean; virtual;
    function TimeToGridRolPos(AColStartTime, ATime: TDateTime): Integer;

    procedure BuildGridData; override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF}); override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure ClearSpanItems; override;
    procedure GetCellType(ACol, ARow: Integer; var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer); override;
    procedure GetCurrentTimeLineRect(var CurTLRect: TRect); override;
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime); override;
    procedure InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh); override;
    procedure PaintSpanItems; override;
    procedure Resize; override;
    procedure SetDisplayPosesSpanItems; override;
    procedure SetGroupPosesSpanItems(Resource: TPlannerResourceEh); override;
    procedure SortPlanItems; override;
    procedure StartDateChanged; override;
    procedure UpdateDummySpanItemSize(MousePos: TPoint); override;

    procedure BuildDaysGridMode; virtual;
    procedure CalcPosByPeriod(AColStartTime, AStartTime, AEndTime: TDateTime; var AStartGridPos, AStopGridPos: Integer); virtual;
    procedure CalcRolRows; virtual;
    procedure DayNamesCellClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); virtual;
    procedure DrawAllDaySpanItems; virtual;
    procedure DrawInDaySpanItems; virtual;
    procedure FillSpecDaysList; virtual;
    procedure SetResOffsets; virtual;

    property ColsStartTime[ADayCol: Integer]: TDateTime read GetColsStartTime;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AppendPeriod(ATime: TDateTime; Periods: Integer): TDateTime; override;
    function GetPeriodCaption: String; override;
    function NextDate: TDateTime; override;
    function PriorDate: TDateTime; override;

    procedure GetDayNamesCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawDayNamesCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawDayNamesCellBack(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

    property AllDayList[Index: Integer]: TTimeSpanDisplayItemEh read GetAllDayListItem;
    property AllDayListCount: Integer read GetAllDayListCount;
    property InDayList[Index: Integer]: TTimeSpanDisplayItemEh read GetInDayListItem;
    property InDayListCount: Integer read GetInDayListCount;
    property MinDayColWidth: Integer read FMinDayColWidth write SetMinDayColWidth;
    property ShowWorkingTimeOnly: Boolean read FShowWorkingTimeOnly write SetShowWorkingTimeOnly default False;

  published
    property BarTimeInterval: TPlannerBarTimeIntervalEh read FBarTimeInterval write SetBarTimeInterval default pbti30MinEh;
    property DataBarsArea: TDataBarsVertAreaEh read GetDataBarsArea write SetDataBarsArea;
    property DayNameArea: TDayNameVertAreaEh read GetDayNameArea write SetDayNameArea;
    property GridLineParams;
    property HoursColArea: THoursVertBarAreaEh read GetHoursColArea write SetHoursColArea;
    property PopupMenu;
    property ResourceCaptionArea: TResourceVertCaptionAreaEh read GetResourceCaptionArea write SetResourceCaptionArea;

    property OnContextPopup;
    property OnDblClick;
    property OnDrawCell;
    property OnReadPlannerDataItem;
    property OnSelectionChanged;
    property OnSpanItemHintShow;
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
  end;

{ TPlannerDayViewEh }

  TPlannerDayViewEh = class(TPlannerWeekViewEh)
  protected
    function GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh; override;
    function IsDayNameAreaNeedVisible: Boolean; override;

    procedure StartDateChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TPlannerMonthViewEh }

  TPlannerMonthViewEh = class(TCustomPlannerViewEh)
  private
    FSortedSpans: TObjectListEh;
    FWeekColArea: TWeekBarAreaEh;

    function GetDataBarsArea: TDataBarsVertAreaEh;
    function GetDayNameArea: TDayNameVertAreaEh;
    function GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;

    procedure SetDataBarsArea(const Value: TDataBarsVertAreaEh);
    procedure SetDayNameArea(const Value: TDayNameVertAreaEh);
    procedure SetMinDayColWidth(const Value: Integer);
    procedure SetWeekColArea(const Value: TWeekBarAreaEh);

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

  protected
    FDataColsFor1Res: Integer;
    FDataDayNumAreaHeight: Integer;
    FDefaultLineHeight: Integer;
    FMinDayColWidth: Integer;
    FMovingDaysShift: Integer;
    FShowWeekNoCaption: Boolean;
    FWeekColIndex: Integer;

    function AdjustDate(const Value: TDateTime): TDateTime; override;
    function CellToDateTime(ACol, ARow: Integer): TDateTime; override;
    function CreateDayNameArea: TDayNameAreaEh; override;
    function CreateHoursBarArea: THoursBarAreaEh; override;
    function CreateResourceCaptionArea: TResourceCaptionAreaEh; override;
    function DefaultHoursBarSize: Integer; override;
    function DrawMonthDayWithWeekDayName: Boolean; override;
    function GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh; override;
    function GetDataCellTimeLength: TDateTime; override;
    function GetResourceAtCell(ACol, ARow: Integer): TPlannerResourceEh; override;
    function GetResourceViewAtCell(ACol, ARow: Integer): Integer; override;
    function IsDayNameAreaNeedVisible: Boolean; override;
    function NewItemParams(var StartTime, EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean; override;

    function CalcShowKeekNoCaption(RowHeight: Integer): Boolean; virtual;
    function IsInterResourceCell(ACol, ARow: Integer): Boolean; virtual;
    function TimeToGridLineRolPos(ADateTime: TDateTime): Integer; virtual;
    function WeekNoColWidth: Integer; virtual;

    procedure BuildGridData; override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF}); override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure ClearSpanItems; override;
    procedure GetCellType(ACol, ARow: Integer; var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer); override;
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime); override;
    procedure InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh); override;
    procedure InitSpanItemMoving(SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint); override;
    procedure ReadPlanItem(APlanItem: TPlannerDataItemEh); override;
    procedure Resize; override;
    procedure SetDisplayPosesSpanItems; override;
    procedure SetGroupPosesSpanItems(Resource: TPlannerResourceEh); override;
    procedure SortPlanItems; override;
    procedure UpdateDummySpanItemSize(MousePos: TPoint); override;

    procedure BuildMonthGridMode; virtual;
    procedure CalcPosByPeriod(AStartTime, AEndTime: TDateTime; var AStartGridPos, AStopGridPos: Integer); virtual;
    procedure DrawMonthViewDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure ReadDivByWeekPlanItem(StartDate, BoundDate: TDateTime; APlanItem: TPlannerDataItemEh);
    procedure SetDisplayPosesSpanItemsForResource(AResource: TPlannerResourceEh; Index: Integer); virtual;
    procedure SetResOffsets; virtual;
    procedure WeekNoCellClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); virtual;

    property SortedSpan[Index: Integer]: TTimeSpanDisplayItemEh read GetSortedSpan;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AppendPeriod(ATime: TDateTime; Periods: Integer): TDateTime; override;
    function GetPeriodCaption: String; override;
    function NextDate: TDateTime; override;
    function PriorDate: TDateTime; override;

    procedure DrawDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawWeekNoCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure GetDataCellDrawParams(ACol, ARow: Integer; ARect: TRect; var State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure GetWeekNoCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

    property MinDayColWidth: Integer read FMinDayColWidth write SetMinDayColWidth;

  published
    property DataBarsArea: TDataBarsVertAreaEh read GetDataBarsArea write SetDataBarsArea;
    property DayNameArea: TDayNameVertAreaEh read GetDayNameArea write SetDayNameArea;
    property PopupMenu;
    property ResourceCaptionArea;
    property WeekColArea: TWeekBarAreaEh read FWeekColArea write SetWeekColArea;

    property OnContextPopup;
    property OnDblClick;
    property OnDrawCell;
    property OnReadPlannerDataItem;
    property OnSelectionChanged;
    property OnSpanItemHintShow;
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
  end;

  TTimePlanRangeKind = (rkDayByHoursEh, rkWeekByHoursEh, rkWeekByDaysEh, rkMonthByDaysEh);
  TDayslineRangeEh = (dlrWeekEh, dlrMonthEh);
  THourslineRangeEh = (hlrDayEh, hlrWeekEh);

  TAxisTimeBandOreintationEh = (atboVerticalEh, atboHorizonalEh);

{ TAxisTimeBandPlannerViewEh }

  TPlannerAxisTimelineViewEh = class(TCustomPlannerViewEh)
  private
    FBandOreintation: TAxisTimeBandOreintationEh;
    FDatesBarArea: TDatesBarAreaEh;
    FRandeKind: TTimePlanRangeKind;

    function GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;

    procedure SetBandOreintation(const Value: TAxisTimeBandOreintationEh);
    procedure SetDatesBarArea(const Value: TDatesBarAreaEh);
    procedure SetRandeKind(const Value: TTimePlanRangeKind);

  protected
    FBarsInBand: Integer;
    FCellsInBand: Integer;
    FMasterGroupLineColor: TColor;
    FMovingDaysShift: Integer;
    FMovingTimeShift: TDateTime;
    FResourceAxis: TGridAxisDataEh;
    FRolLenInSecs: Integer;
    FSortedSpans: TObjectListEh;
    FTimeAxis: TGridAxisDataEh;

    function AdjustDate(const Value: TDateTime): TDateTime; override;
    function FullRedrawOnScroll: Boolean; override;
    function GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh; override;
    function GetDataBarsAreaDefaultBarSize: Integer; override;
    function GetDataCellTimeLength: TDateTime; override;
    function GetResourceAtCell(ACol, ARow: Integer): TPlannerResourceEh; override;
    function IsDayNameAreaNeedVisible: Boolean; override;
    function NewItemParams(var StartTime, EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean; override;

    function CreateDatesBarArea: TDatesBarAreaEh; virtual;
    function DateTimeToGridRolPos(ADateTime: TDateTime): Integer; virtual;
    function GetDefaultDatesBarSize: Integer; virtual;
    function GetDefaultDatesBarVisible: Boolean; virtual;
    function GetGridOffsetForResource(Resource: TPlannerResourceEh): Integer; virtual;
    function IsInterResourceCell(ACol, ARow: Integer): Boolean; virtual;

    procedure BuildGridData; override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure ClearSpanItems; override;
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime); override;
    procedure InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh); override;
    procedure PlannerStateChanged(AOldState: TPlannerStateEh); override;
    procedure Paint; override;
    procedure RangeModeChanged; override;
    procedure ReadPlanItem(APlanItem: TPlannerDataItemEh); override;
    procedure Resize; override;
    procedure SetGroupPosesSpanItems(Resource: TPlannerResourceEh); override;
    procedure SortPlanItems; override;
    procedure StartDateChanged; override;

    procedure BuildDaysGridData; virtual;
    procedure BuildHoursGridData; virtual;
    procedure CalcLayouts; virtual;
    procedure CalcPosByPeriod(AStartTime, AEndTime: TDateTime; var AStartGridPos, AStopGridPos: Integer); virtual;
    procedure SetResOffsets; virtual;

    property BandOreintation: TAxisTimeBandOreintationEh read FBandOreintation write SetBandOreintation;
    property DatesBarArea: TDatesBarAreaEh read FDatesBarArea write SetDatesBarArea;
    property RangeKind: TTimePlanRangeKind read FRandeKind write SetRandeKind;
    property SortedSpan[Index: Integer]: TTimeSpanDisplayItemEh read GetSortedSpan;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AppendPeriod(ATime: TDateTime; Periods: Integer): TDateTime; override;
    function GetPeriodCaption: String; override;
    function NextDate: TDateTime; override;
    function PriorDate: TDateTime; override;

    procedure CoveragePeriod(var AFromTime, AToTime: TDateTime); override;
  end;


{ TPlannerVertTimelineViewEh }

  TPlannerVertTimelineViewEh = class(TPlannerAxisTimelineViewEh)
  private
    FMinDataColWidth: Integer;

    function GetDataBarsArea: TDataBarsVertAreaEh;
    function GetDatesColArea: TDatesColAreaEh;
    function GetDayNameArea: TDayNameVertAreaEh;
    function GetHoursColArea: THoursVertBarAreaEh;
    function GetResourceCaptionArea: TResourceVertCaptionAreaEh;
    function GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;

    procedure SetDataBarsArea(const Value: TDataBarsVertAreaEh);
    procedure SetDatesColArea(const Value: TDatesColAreaEh);
    procedure SetDayNameArea(const Value: TDayNameVertAreaEh);
    procedure SetHoursColArea(const Value: THoursVertBarAreaEh);
    procedure SetMinDataColWidth(const Value: Integer);
    procedure SetResourceCaptionArea(const Value: TResourceVertCaptionAreaEh);

  protected
    FDayGroupCol: Integer;
    FDayGroupRows: Integer;
    FDaySplitModeCol: Integer;

    function CellToDateTime(ACol, ARow: Integer): TDateTime; override;
    function CreateDatesBarArea: TDatesBarAreaEh; override;
    function CreateDayNameArea: TDayNameAreaEh; override;
    function CreateHoursBarArea: THoursBarAreaEh; override;
    function CreateResourceCaptionArea: TResourceCaptionAreaEh; override;
    function DefaultHoursBarSize: Integer; override;
    function GetDayNameAreaDefaultSize: Integer; override;
    function GetResourceCaptionAreaDefaultSize: Integer; override;
    function GetResourceViewAtCell(ACol, ARow: Integer): Integer; override;
    function IsInterResourceCell(ACol, ARow: Integer): Boolean; override;

    procedure BuildHoursGridData; override;
    procedure CalcLayouts; override;
    procedure CalcPosByPeriod(AStartTime, AEndTime: TDateTime; var AStartGridPos, AStopGridPos: Integer); override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure GetCellType(ACol, ARow: Integer; var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer); override;
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime); override;
    procedure InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh); override;
    procedure InitSpanItemMoving(SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetDisplayPosesSpanItems; override;
    procedure SetGroupPosesSpanItems(Resource: TPlannerResourceEh); override;
    procedure SetResOffsets; override;
    procedure UpdateDummySpanItemSize(MousePos: TPoint); override;

    procedure DrawDaySplitModeDateCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ADataRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawTimeGroupCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure SetGroupPosesSpanItemsForDayStep(Resource: TPlannerResourceEh); virtual;

    property SortedSpan[Index: Integer]: TTimeSpanDisplayItemEh read GetSortedSpan;
    property HoursColArea: THoursVertBarAreaEh read GetHoursColArea write SetHoursColArea;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DrawDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawDateBar(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawDateCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawTimeCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure GetDateBarDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

    property DataBarsArea: TDataBarsVertAreaEh read GetDataBarsArea write SetDataBarsArea;
    property DatesColArea: TDatesColAreaEh read GetDatesColArea write SetDatesColArea;
    property DayNameArea: TDayNameVertAreaEh read GetDayNameArea write SetDayNameArea;
    property MinDataColWidth: Integer read FMinDataColWidth write SetMinDataColWidth default -1;
    property ResourceCaptionArea: TResourceVertCaptionAreaEh read GetResourceCaptionArea write SetResourceCaptionArea;
  end;

{ TPlannerVertDayslineViewEh }

  TPlannerVertDayslineViewEh = class(TPlannerVertTimelineViewEh)
  private
    function GetTimeRange: TDayslineRangeEh;
    procedure SetTimeRange(const Value: TDayslineRangeEh);

  protected
    function GetDefaultDatesBarSize: Integer; override;
    function GetDefaultDatesBarVisible: Boolean; override;
    function IsWorkingTime(const Value: TDateTime): Boolean; override;

    procedure BuildDaysGridData; override;
    procedure DrawDaySplitModeDateCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ADataRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetDateCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

  published
    property DataBarsArea;
    property DatesColArea;
    property PopupMenu;
    property ResourceCaptionArea;
    property TimeRange: TDayslineRangeEh read GetTimeRange write SetTimeRange default dlrWeekEh;

    property OnContextPopup;
    property OnDblClick;
    property OnDrawCell;
    property OnReadPlannerDataItem;
    property OnSelectionChanged;
    property OnSpanItemHintShow;
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
  end;

{ TPlannerVertHourslineViewEh }

  TPlannerVertHourslineViewEh = class(TPlannerVertTimelineViewEh)
  private
    function GetTimeRange: THourslineRangeEh;
    procedure SetTimeRange(const Value: THourslineRangeEh);

  protected
    procedure GetCurrentTimeLineRect(var CurTLRect: TRect); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property DataBarsArea;
    property DatesColArea;
    property HoursColArea;
    property PopupMenu;
    property ResourceCaptionArea;
    property TimeRange: THourslineRangeEh read GetTimeRange write SetTimeRange default hlrDayEh;

    property OnContextPopup;
    property OnDblClick;
    property OnDrawCell;
    property OnReadPlannerDataItem;
    property OnSelectionChanged;
    property OnSpanItemHintShow;
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
  end;

{ TPlannerHorzTimelineViewEh }

  TPlannerHorzTimelineViewEh = class(TPlannerAxisTimelineViewEh)
  private
    FMinDataRowHeight: Integer;
    FResourceColWidth: Integer;
    FShowDateRow: Boolean;

    function GetDataBarsArea: TDataBarsHorzAreaEh;
    function GetDatesRowArea: TDatesRowAreaEh;
    function GetDayNameArea: TDayNameHorzAreaEh;
    function GetHoursColArea: THoursHorzBarAreaEh;
    function GetResourceCaptionArea: TResourceHorzCaptionAreaEh;

    procedure SetDataBarsArea(const Value: TDataBarsHorzAreaEh);
    procedure SetDatesRowArea(const Value: TDatesRowAreaEh);
    procedure SetDayNameArea(const Value: TDayNameHorzAreaEh);
    procedure SetHoursColArea(const Value: THoursHorzBarAreaEh);
    procedure SetMinDataRowHeight(const Value: Integer);
    procedure SetResourceCaptionArea(const Value: TResourceHorzCaptionAreaEh);
    procedure SetResourceColWidth(const Value: Integer);
    procedure SetShowDateRow(const Value: Boolean);

  protected
    FDataStartCol: Integer;
    FDayGroupCols: Integer;
    FDayGroupRow: Integer;
    FDaySplitModeRow: Integer;

    function CellToDateTime(ACol, ARow: Integer): TDateTime; override;
    function CreateDataBarsArea: TDataBarsAreaEh; override;
    function CreateDatesBarArea: TDatesBarAreaEh; override;
    function CreateDayNameArea: TDayNameAreaEh; override;
    function CreateHoursBarArea: THoursBarAreaEh; override;
    function CreateResourceCaptionArea: TResourceCaptionAreaEh; override;
    function DefaultHoursBarSize: Integer; override;
    function GetResourceCaptionAreaDefaultSize: Integer; override;
    function GetResourceViewAtCell(ACol, ARow: Integer): Integer; override;
    function IsInterResourceCell(ACol, ARow: Integer): Boolean; override;

    function CalTimeRowHeight: Integer; virtual;

    procedure BuildHoursGridData; override;
    procedure CalcLayouts; override;
    procedure CalcRectForInCellRows(SpanItem: TTimeSpanDisplayItemEh; var DrawRect: TRect); override;
    procedure CheckDrawCellBorder(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean; var BorderColor: TColor; var IsExtent: Boolean); override;
    procedure GetCellType(ACol, ARow: Integer; var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer); override;
    procedure InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh); override;
    procedure InitSpanItemMoving(SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetDisplayPosesSpanItems; override;
    procedure SetResOffsets; override;
    procedure UpdateDummySpanItemSize(MousePos: TPoint); override;

    procedure DrawDaySplitModeDateCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ADataCol: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawTimeGroupCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;

    property HoursRowArea: THoursHorzBarAreaEh read GetHoursColArea write SetHoursColArea;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DrawDataCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawDateBar(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawDateCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure DrawTimeCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;
    procedure GetDateBarDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

    property DataBarsArea: TDataBarsHorzAreaEh read GetDataBarsArea write SetDataBarsArea;
    property DatesRowArea: TDatesRowAreaEh read GetDatesRowArea write SetDatesRowArea;
    property DayNameArea: TDayNameHorzAreaEh read GetDayNameArea write SetDayNameArea ;
    property MinDataRowHeight: Integer read FMinDataRowHeight write SetMinDataRowHeight default -1;
    property ResourceCaptionArea: TResourceHorzCaptionAreaEh read GetResourceCaptionArea write SetResourceCaptionArea;
    property ResourceColWidth: Integer read FResourceColWidth write SetResourceColWidth;
    property ShowDateRow: Boolean read FShowDateRow write SetShowDateRow default True;

  end;

{ TPlannerHorzDayslineViewEh }

  TPlannerHorzDayslineViewEh = class(TPlannerHorzTimelineViewEh)
  private
    function GetTimeRange: TDayslineRangeEh;
    procedure SetTimeRange(const Value: TDayslineRangeEh);

  protected
    function IsWorkingTime(const Value: TDateTime): Boolean; override;

    procedure BuildDaysGridData; override;
    procedure DrawDaySplitModeDateCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ADataRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetDateCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh); override;

  published
    property DataBarsArea;
    property DatesRowArea;
    property PopupMenu;
    property ResourceCaptionArea;
    property TimeRange: TDayslineRangeEh read GetTimeRange write SetTimeRange default dlrWeekEh;

    property OnContextPopup;
    property OnDblClick;
    property OnDrawCell;
    property OnSelectionChanged;
    property OnSpanItemHintShow;
    property OnReadPlannerDataItem;
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
  end;

{ TPlannerHorzHourslineViewEh }

  TPlannerHorzHourslineViewEh = class(TPlannerHorzTimelineViewEh)
  private
    function GetTimeRange: THourslineRangeEh;
    procedure SetTimeRange(const Value: THourslineRangeEh);

  protected
    procedure GetCurrentTimeLineRect(var CurTLRect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property DataBarsArea;
    property DatesRowArea;
    property HoursRowArea;
    property PopupMenu;
    property ResourceCaptionArea;
    property TimeRange: THourslineRangeEh read GetTimeRange write SetTimeRange default hlrDayEh;

    property OnContextPopup;
    property OnDblClick;
    property OnDrawCell;
    property OnReadPlannerDataItem;
    property OnSelectionChanged;
    property OnSpanItemHintShow;
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
  end;

{ TPlannerControlTimeSpanParamsEh }

  TPlannerControlTimeSpanParamsEh = class(TDrawElementParamsEh)
  private
    FDefaultAltColor: TColor;
    FDefaultBorderColor: TColor;
    FDefaultColor: TColor;
    FPlanner: TPlannerControlEh;
    FPopupMenu: TPopupMenu;
    FDblClickOpenEventEditor: Boolean;
    procedure SetPopupMenu(const Value: TPopupMenu);

  protected
    function DefaultFont: TFont; override;
    function GetDefaultAltColor: TColor; override;
    function GetDefaultBorderColor: TColor; override;
    function GetDefaultColor: TColor; override;
    function GetDefaultFillStyle: TPropFillStyleEh; override;
    function GetDefaultHue: TColor; override;

    procedure NotifyChanges; override;
    procedure ResetDefaultProps;
  public
    constructor Create(APlanner: TPlannerControlEh);
    destructor Destroy; override;

    property Planner: TPlannerControlEh read FPlanner;

  published
    property AltColor;
    property BorderColor;
    property Color;
    property FillStyle;
    property Font;
    property FontStored;
    property Hue;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property DblClickOpenEventEditor: Boolean read FDblClickOpenEventEditor write FDblClickOpenEventEditor default True;
  end;

{ TEventNavBoxParamsEh }

  TEventNavBoxParamsEh = class(TDrawElementParamsEh)
  private
    FPlanner: TPlannerControlEh;
    FVisible: Boolean;
    procedure SetVisible(const Value: Boolean);

  protected
    function DefaultFont: TFont; override;
    function GetDefaultColor: TColor; override;
    function GetDefaultBorderColor: TColor; override;

    procedure NotifyChanges; override;
  public
    constructor Create(APlanner: TPlannerControlEh);
    destructor Destroy; override;
    property Planner: TPlannerControlEh read FPlanner;

  published
    property BorderColor;
    property Color;
    property Font;
    property FontStored;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

{ TPlannerToolBoxEh }

  TPlannerToolBoxEh = class(TCustomPanel)
  private
    FNextPeriodButton: TSpeedButtonEh;
    FPriorPeriodButton: TSpeedButtonEh;
    FPeriodInfo: TLabel;
  {$IFDEF EH_LIB_26} 
  {$ELSE}
    FScaleFactor: Single;
  {$ENDIF}

    function GetPlannerControl: TPlannerControlEh;

  protected
    procedure PriorPeriodClick(Sender: TObject);
    procedure NextPeriodClick(Sender: TObject);
    procedure ButtonPaint(Sender: TObject);

    procedure ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF}); override;
    procedure Resize(); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdatePeriodInfo;

  {$IFDEF EH_LIB_26} 
  {$ELSE}
    property ScaleFactor: Single read FScaleFactor;
  {$ENDIF}

    property PlannerControl: TPlannerControlEh read GetPlannerControl;
    property NextPriodButton: TSpeedButtonEh read FNextPeriodButton;
    property PeriodInfo: TLabel read FPeriodInfo;
    property PriorPriodButton: TSpeedButtonEh read FPriorPeriodButton;
  end;

{$IFDEF FPC}
{$ELSE}

{ TCustomPlannerControlPrintServiceEh }

  TCustomPlannerControlPrintServiceEh = class(TBaseGridPrintServiceEh)
  private
    FPlanner: TPlannerControlEh;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Planner: TPlannerControlEh read FPlanner write FPlanner;

    property ColorSchema;
    property FitToPagesTall;
    property FitToPagesWide;
    property Orientation;
    property PageFooter;
    property PageHeader;
    property PageMargins;
    property Scale;
    property ScalingMode;
    property TextAfterContent;
    property TextBeforeContent;

    property OnBeforePrint;
    property OnBeforePrintPage;
    property OnBeforePrintPageContent;
    property OnPrintDataBeforeGrid;
    property OnCalcLayoutDataBeforeGrid;

    property OnAfterPrint;
    property OnAfterPrintPage;
    property OnAfterPrintPageContent;
    property OnPrintDataAfterGrid;
    property OnCalcLayoutDataAfterGrid;

    property OnPrinterSetupDialog;
  end;
{$ENDIF}

{ TPlannerControlEh }

  TPlanItemChangeModeEh = (picmModifyEh, picmInsertEh);

  TPlannerViewOptionEh = (pvoUseGlobalWorkingTimeCalendarEh,
    pvoPlannerToolBoxEh, pvoAutoloadPlanItemsEh, pvoHighlightTodayEh,
    pvoRangeSelectEh);
  TPlannerViewOptionsEh = set of TPlannerViewOptionEh;

  TActivePlannerViewChangedEventEh = procedure(PlannerControl: TPlannerControlEh;
    OldActivePlannerGrid: TCustomPlannerViewEh) of object;

  TShowPlanItemDialogEventEh = procedure(PlannerControl: TPlannerControlEh;
    PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh;
    ChangeMode: TPlanItemChangeModeEh) of object;

  TTimeItemChangingEventEh = procedure (PlannerControl: TPlannerControlEh;
    PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh;
    NewValuesItem: TPlannerDataItemEh; var ChangesAllowed: Boolean; var ErrorText: String) of object;

  TTimeItemChangedEventEh = procedure (PlannerControl: TPlannerControlEh;
    PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh;
    OldValuesItem: TPlannerDataItemEh) of object;

  TPlannerAllowedOperationEh = (paoAppendPlanItemEh, paoChangePlanItemEh, paoDeletePlanItemEh);
  TPlannerAllowedOperationsEh = set of TPlannerAllowedOperationEh;

  TPlannerControlEh = class(TCustomPanel, ISimpleChangeNotificationEh)
  private
    FActivePlannerGrid: TCustomPlannerViewEh;
    FAllowedOperations: TPlannerAllowedOperationsEh;
    FCurrentTime: TDateTime;
    FEventNavBoxParams: TEventNavBoxParamsEh;
    FIgnorePlannerDataSourceChanged: Boolean;
    FNotificationConsumers: TInterfaceList;
    FOnActivePlannerViewChanged: TActivePlannerViewChangedEventEh;
    FOnCheckPlannerItemInteractiveChanging: TTimeItemChangingEventEh;
    FOnDrawSpanItem: TDrawSpanItemEventEh;
    FOnPlannerSpanItemContextPopup: TPlannerSpanItemContextPopupEh;
    FOnShowPlanItemDialog: TShowPlanItemDialogEventEh;
    FOnSpanItemHintShow: TPlannerViewSpanItemHintShowEventEh;
    FOnTimeItemInteractiveChanged: TTimeItemChangedEventEh;
    FOptions: TPlannerViewOptionsEh;
    FPlannerDataSource: TPlannerDataSourceEh;
    FPlannerGrids: TObjectListEh;
    FTimeSpanParams: TPlannerControlTimeSpanParamsEh;
    FTopPanel: TPlannerToolBoxEh;
    FViewMode: TPlannerDateRangeModeEh;
    FWorkingTimeEnd: TTime;
    FWorkingTimeStart: TTime;
    FDrawStyle: TPlannerDrawStyleEh;

    {$IFDEF FPC}
    {$ELSE}
    FPrintService: TCustomPlannerControlPrintServiceEh;
    {$ENDIF}

    function GetActivePlannerGrid: TCustomPlannerViewEh;
    function GetActivePlannerGridIndex: Integer;
    function GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
    function getCurrentTime: TDateTime; //C++ conflict with GetCurrentTime
    function GetPlannerGrid(Index: Integer): TCustomPlannerViewEh;
    function GetPlannerGridCount: Integer;
    function GetStartDate: TDateTime;
    function GetPlannerDataSource: TPlannerDataSourceEh;

    procedure SetActivePlannerGrid(const Value: TCustomPlannerViewEh);
    procedure SetActivePlannerGridIndex(const Value: Integer);
    procedure SetAllowedOperations(const Value: TPlannerAllowedOperationsEh);
    procedure SetCurrentTime(const Value: TDateTime);
    procedure SetDrawStyle(const Value: TPlannerDrawStyleEh);
    procedure SetEventNavBoxParams(const Value: TEventNavBoxParamsEh);
    procedure SetOnDrawSpanItem(const Value: TDrawSpanItemEventEh);
    procedure SetOptions(const Value: TPlannerViewOptionsEh);
    procedure SetPlannerDataSource(const Value: TPlannerDataSourceEh);
    procedure SetStartDate(const Value: TDateTime);
    procedure SetTimeSpanParams(const Value: TPlannerControlTimeSpanParamsEh);
    procedure SetViewMode(const Value: TPlannerDateRangeModeEh);
    procedure SetWorkingTimeEnd(const Value: TTime);
    procedure SetWorkingTimeStart(const Value: TTime);
    procedure ViewModeChanged;

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

  protected
    function GetDefaultEventNavBoxBorderColor: TColor; virtual;
    function GetDefaultEventNavBoxColor: TColor; virtual;
    function CreatePlannerItem: TPlannerDataItemEh; virtual;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;

    procedure ActivePlannerViewChanged(OldActivePlannerGrid: TCustomPlannerViewEh); virtual;
    procedure ChangeActivePlannerGrid(const APlannerGrid: TCustomPlannerViewEh); virtual;
    procedure DoTimeSpanContextPopup(MousePos: TPoint; PlannerView: TCustomPlannerViewEh; SpanItem: TTimeSpanDisplayItemEh);
    procedure EnsureDataForPeriod(AStartDate, AEndDate: TDateTime); virtual;
    procedure GetViewPeriod(var AStartDate, AEndDate: TDateTime); virtual;
    procedure GridCurrentTimeChanged(ANewCurrentTime: TDateTime); virtual;
    procedure LayoutChanged;
    procedure NavBoxParamsChanges; virtual;
    procedure NotifyConsumersPlannerDataChanged; virtual;
    procedure PlannerDataSourceChange(Sender: TObject);
    procedure PlannerDataSourceChanged; virtual;
    procedure PlannerDataSourcePropertyChanged; virtual;
    procedure StartDateChanged; virtual;

  protected
    procedure ISimpleChangeNotificationEh.Change = PlannerDataSourceChange;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CheckPlannerItemChangeOperation(PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh; Operation: TPlannerAllowedOperationEh): Boolean; virtual;
    function CheckPlannerItemInteractiveChanging(PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh; NewValuesItem: TPlannerDataItemEh; var ErrorText: String): Boolean; virtual;
    function CreatePlannerGrid(PlannerGridClass: TCustomPlannerGridClassEh; AOwner: TComponent): TCustomPlannerViewEh; virtual;
    function CurWorkingTimeCalendar: TWorkingTimeCalendarEh; virtual;
    function GetPeriodCaption: String;
    function GetActualDrawStyle: TPlannerDrawStyleEh; virtual;
    function NewItemParams(var StartTime, EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean;
    function NextDate: TDateTime;
    function PriorDate: TDateTime;

    procedure CoveragePeriod(var AFromTime, AToTime: TDateTime); virtual;
    procedure DefaultDrawSpanItem(PlannerView: TCustomPlannerViewEh; SpanItem: TTimeSpanDisplayItemEh; Rect: TRect; State: TDrawSpanItemDrawStateEh); virtual;
    procedure DefaultFillSpanItemHintShowParams(PlannerView: TCustomPlannerViewEh; CursorPos: TPoint; SpanRect: TRect; InSpanCursorPos: TPoint; SpanItem: TTimeSpanDisplayItemEh; Params: TPlannerViewSpanHintParamsEh); virtual;
    procedure EnsureDataForViewPeriod; virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure NextPeriod;
    procedure PlannerItemInteractiveChanged(PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh; OldValuesItem: TPlannerDataItemEh); virtual;
    procedure PriorPeriod;
    procedure RegisterChanges(Value: IPlannerControlChangeReceiverEh);
    procedure RemovePlannerGrid(APlannerGrid: TCustomPlannerViewEh);
    procedure ResetAutoLoadProcess;
    procedure ShowDefaultPlanItemDialog(PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh; ChangeMode: TPlanItemChangeModeEh); virtual;
    procedure ShowModifyPlanItemDialog(PlanItem: TPlannerDataItemEh); virtual;
    procedure ShowNewPlanItemDialog; virtual;
    procedure StopAutoLoad;
    procedure UnRegisterChanges(Value: IPlannerControlChangeReceiverEh);

    property ActivePlannerGridIndex: Integer read GetActivePlannerGridIndex write SetActivePlannerGridIndex;
    property CoveragePeriodType: TPlannerCoveragePeriodTypeEh read GetCoveragePeriodType;
    property CurrentTime: TDateTime read getCurrentTime write SetCurrentTime;
    property PlannerView[Index: Integer]: TCustomPlannerViewEh read GetPlannerGrid;
    property PlannerViewCount: Integer read GetPlannerGridCount;
    property StartDate: TDateTime read GetStartDate write SetStartDate;
    property ViewMode: TPlannerDateRangeModeEh read FViewMode write SetViewMode default pdrmDayEh;
    property WorkingTimeEnd: TTime read FWorkingTimeEnd write SetWorkingTimeEnd;
    property WorkingTimeStart: TTime read FWorkingTimeStart write SetWorkingTimeStart;
    property DrawStyle: TPlannerDrawStyleEh read FDrawStyle write SetDrawStyle;

  published
    property ActivePlannerView: TCustomPlannerViewEh read GetActivePlannerGrid write SetActivePlannerGrid;
    property AllowedOperations: TPlannerAllowedOperationsEh read FAllowedOperations write SetAllowedOperations default [paoAppendPlanItemEh, paoChangePlanItemEh, paoDeletePlanItemEh];
    property EventNavBoxParams: TEventNavBoxParamsEh read FEventNavBoxParams write SetEventNavBoxParams;
    property Options: TPlannerViewOptionsEh read FOptions write SetOptions default [pvoUseGlobalWorkingTimeCalendarEh, pvoPlannerToolBoxEh, pvoHighlightTodayEh];
    property PlannerDataSource: TPlannerDataSourceEh read GetPlannerDataSource write SetPlannerDataSource;
    property TimeSpanParams: TPlannerControlTimeSpanParamsEh read FTimeSpanParams write SetTimeSpanParams;

    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    {$IFDEF FPC}
    {$ELSE}
    property ImeMode;
    property ImeName;
    {$ENDIF}
    property ParentBiDiMode;
    {$IFDEF FPC}
    {$ELSE}
    property ParentCtl3D;
    property PrintService: TCustomPlannerControlPrintServiceEh read FPrintService;
    {$ENDIF}
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
{$IFDEF EH_LIB_13}
    property Touch;
{$ENDIF}
    property Visible;

    property OnActivePlannerViewChanged: TActivePlannerViewChangedEventEh read FOnActivePlannerViewChanged write FOnActivePlannerViewChanged;
    property OnCheckPlannerItemInteractiveChanging: TTimeItemChangingEventEh read FOnCheckPlannerItemInteractiveChanging write FOnCheckPlannerItemInteractiveChanging;
    property OnDrawSpanItem: TDrawSpanItemEventEh read FOnDrawSpanItem write SetOnDrawSpanItem;
    property OnPlannerItemInteractiveChanged: TTimeItemChangedEventEh read FOnTimeItemInteractiveChanged write FOnTimeItemInteractiveChanged;
    property OnPlannerSpanItemContextPopup: TPlannerSpanItemContextPopupEh read FOnPlannerSpanItemContextPopup write FOnPlannerSpanItemContextPopup;
    property OnShowPlanItemDialog: TShowPlanItemDialogEventEh read FOnShowPlanItemDialog write FOnShowPlanItemDialog;
    property OnSpanItemHintShow: TPlannerViewSpanItemHintShowEventEh read FOnSpanItemHintShow write FOnSpanItemHintShow;

    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
{$IFDEF EH_LIB_13}
    property OnGesture;
{$ENDIF}
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
    property OnStartDock;
    property OnStartDrag;
  end;

{ TPlannerDrawStyleEh }

  TPlannerDrawStyleEh = class
  private
    FNonworkingTimeBackColor: TColor;
    FTodayFrameColor: TColor;
    FCachedResourceCellFillColor1: TColor;
    FCachedResourceCellFillColor2: TColor;
    FCachedResourceCellFillColor: TColor;
    FCachedSelectedFocusedCellColor: TColor;
    FSelectedUnfocusedCellColor: TColor;

    function GetNonworkingTimeBackColor: TColor;

    procedure SetTodayFrameColor(const Value: TColor);
    procedure SetNonworkingTimeBackColor(const Value: TColor);

  protected
    function GetTodayFrameColor: TColor; virtual;
    function GetDarkLineColor: TColor; virtual;
    function GetBrightLineColor: TColor; virtual;
    function GetEventNavBoxBorderColor: TColor; virtual;
    function GetEventNavBoxFillColor: TColor; virtual;
    function GetResourceCellFillColor: TColor; virtual;
    function GetDayNameAreaFillColor: TColor; virtual;
    function GetSelectedFocusedCellColor: TColor; virtual;
    function GetSelectedUnfocusedCellColor: TColor; virtual;

  public
    constructor Create;

    function AdjustNonworkingTimeBackColor(PlannerControl:TPlannerControlEh; BaseColor, BackColor, FontColor: TColor): TColor; virtual;
    function GetActlTodayFrameColor: TColor; virtual;
    function GetDayNameAreaFont(PlannerView: TCustomPlannerViewEh; const BaseFont: TFont): TFont; virtual;

    procedure DrawNavigateButtonSign(PlannerToolBox: TPlannerToolBoxEh; Canvas: TCanvas; ARect: TRect; State: TButtonStateEh; ButtonKind: TPlannerControlButtonKindEh; IsHot: Boolean; RightToLeftAlignment: Boolean; ScaleFactor: Double); virtual;
    procedure DrawAlldayDataCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawTopLeftCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawResourceCaptionCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawDataCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawInterResourceCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawTimeCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewTimeCellDrawArgsEh); virtual;
    procedure DrawDayNamesCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh); virtual;
    procedure DrawDayNamesCellBack(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh); virtual;
    procedure DrawDayNamesCellFore(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh); virtual;

    procedure DrawMonthViewDataCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawMonthViewWeekNoCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawYearViewMonthNameCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;

    procedure DrawWeekViewDayNamesCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh); virtual;
    procedure DrawWeekViewDayNamesCellBack(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh); virtual;
    procedure DrawWeekViewDayNamesCellFore(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh); virtual;

    procedure DrawVertTimelineViewTimeGroupCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawVertTimelineViewTimeDayCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawVertDayslineViewDateCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;

    procedure DrawHorzTimelineViewTimeGroupCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;
    procedure DrawHorzDayslineViewDateCell(PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh); virtual;

    property NonworkingTimeBackColor: TColor read GetNonworkingTimeBackColor write SetNonworkingTimeBackColor;
    property TodayFrameColor: TColor read GetTodayFrameColor write SetTodayFrameColor;
    property DarkLineColor: TColor read GetDarkLineColor;
    property BrightLineColor: TColor read GetBrightLineColor;
    property EventNavBoxBorderColor: TColor read GetEventNavBoxBorderColor;
    property EventNavBoxFillColor: TColor read GetEventNavBoxFillColor;
    property ResourceCellFillColor: TColor read GetResourceCellFillColor;
    property DayNameAreaFillColor: TColor read GetDayNameAreaFillColor;
    property SelectedFocusedCellColor: TColor read GetSelectedFocusedCellColor;
    property SelectedUnfocusedCellColor: TColor read GetSelectedUnfocusedCellColor;
  end;

function NormalizeDateTime(ADateTime: TDateTime): TDateTime;

procedure FillRectStyle(Canvas: TCanvas; ARect: TRect; AColor, AltColor: TColor; Style: TPropFillStyleEh);
function ChangeRelativeColorLuminance(AColor: TColor; Percent: Integer): TColor;
function RectsIntersected(const Rect1, Rect2: TRect): Boolean;
function CompareSpanItemFuncBySpan(Item1, Item2: Pointer): Integer;

function PlannerDrawStyleEh: TPlannerDrawStyleEh;
function SetPlannerDrawStyleEh(DrawStyle: TPlannerDrawStyleEh): TPlannerDrawStyleEh;

implementation

uses
{$IFDEF EH_LIB_17}
  UIConsts,
{$ENDIF}
{$IFDEF FPC}
{$ELSE}
  PrintPlannersEh,
{$ENDIF}
  EhLibLangConsts,
  PlannerItemDialog,
  PlannerToolCtrlsEh;

const
  BarsPerHourIntervalArr: array[TPlannerBarTimeIntervalEh] of Integer =
    (12, 10, 6, 4, 2, 1);

var
  FPlannerDrawStyle: TPlannerDrawStyleEh;

procedure InitUnit;
begin
  SetPlannerDrawStyleEh(TPlannerDrawStyleEh.Create)
end;

procedure FinalizeUnit;
begin
  FreeAndNil(FPlannerDrawStyle);
end;

function PlannerDrawStyleEh: TPlannerDrawStyleEh;
begin
  Result := FPlannerDrawStyle;
end;

function SetPlannerDrawStyleEh(DrawStyle: TPlannerDrawStyleEh): TPlannerDrawStyleEh;
begin
  Result := FPlannerDrawStyle;
  FPlannerDrawStyle := DrawStyle;
end;

function RectsIntersected(const Rect1, Rect2: TRect): Boolean;
begin
  Result := (Rect1.Left <= Rect2.Right) and
            (Rect1.Right >= Rect2.Left) and
            (Rect1.Top <= Rect2.Bottom) and
            (Rect1.Bottom >= Rect2.Top);
end;

function SysFormatDateEh(const ASysFormat: String; ADate: TDateTime): String;
{$IFDEF FPC_CROSSP}
begin
  Result := '';
end;
{$ELSE}
{$IFDEF MSWINDOWS}
var
  SysTime: SystemTime;
  Buffer: array[Byte] of Char;
begin
  DateTimeToSystemTime(ADate, SysTime);
  if  GetDateFormat(LOCALE_USER_DEFAULT, DATE_USE_ALT_CALENDAR,
    @SysTime, PChar(ASysFormat), Buffer, SizeOf(Buffer)) <> 0
  then
    Result := Buffer
  else
    Result := '';
end;
{$ELSE}
begin
  Result := '';
end;
{$ENDIF}
{$ENDIF} 

function DateRangeToStr(AStartDate, AEndDate: TDateTime): String;
var
  s1, s2: String;
  ALastDate: TDateTime;
begin
  if DateOf(AEndDate) - DateOf(AStartDate) <= 1 then
  begin
    Result := SysFormatDateEh('d MMMM yyyy', AStartDate);
    if Result = '' then
      Result := FormatDateTime('D MMMM YYYY', AStartDate)
  end else if StartOfTheMonth(AStartDate) = StartOfTheMonth(AEndDate) then
  begin
    if DateOf(AEndDate) = AEndDate
      then ALastDate := AEndDate - 1
      else ALastDate := AEndDate;

    s1 := SysFormatDateEh('d', AStartDate) + ' - ';
    s2 := SysFormatDateEh('d MMMM yyyy', ALastDate);
    if s2 = '' then
    begin
      s1 := FormatDateTime('D', AStartDate) + ' - ';
      s2 := FormatDateTime('D MMMM YYYY', ALastDate);
    end;
    Result := s1 + s2;
  end else if (StartOfTheMonth(AStartDate) = AStartDate) and
              (IncMonth(AStartDate) = AEndDate)
  then
  begin
    Result := FormatDateTime('mmmm', AStartDate + 7) + ' ' +
              FormatDateTime('yyyy', AStartDate + 7);
  end else if StartOfTheYear(AStartDate) = StartOfTheYear(AEndDate) then
  begin
    if DateOf(AEndDate) = AEndDate
      then ALastDate := AEndDate - 1
      else ALastDate := AEndDate;
    s1 := SysFormatDateEh('d MMMM', AStartDate) + ' - ';
    s2 := SysFormatDateEh('d MMMM yyyy', ALastDate);
    if s2 = '' then
    begin
      s1 := FormatDateTime('D MMMM', AStartDate) + ' - ';
      s2 := FormatDateTime('D MMMM YYYY', ALastDate);
    end;
    Result := s1 + s2;
  end else
  begin
    if DateOf(AEndDate) = AEndDate
      then ALastDate := AEndDate - 1
      else ALastDate := AEndDate;

    s1 := SysFormatDateEh('d MMMM yyyy', AStartDate) + ' - ';
    s2 := SysFormatDateEh('d MMMM yyyy', ALastDate);
    if s2 = '' then
    begin
      s1 := FormatDateTime('D MMMM YYYY', AStartDate) + ' - ';
      s2 := FormatDateTime('D MMMM YYYY', ALastDate);
    end;
    Result := s1 + s2;
  end;
end;

procedure FillRectStyle(Canvas: TCanvas; ARect: TRect; AColor, AltColor: TColor;
  Style: TPropFillStyleEh);
begin
  if Style = fsSolidEh then
  begin
    Canvas.Brush.Color := AColor;
    Canvas.FillRect(ARect);
  end else if Style = fsVerticalGradientEh then
  begin
    FillGradientEh(Canvas, ARect, AColor, AltColor);
  end;
end;

function NormalizeDateTime(ADateTime: TDateTime): TDateTime;
var
  y, m, d, ho, mi, sec, msec: Word;
begin
  DecodeDateTime(ADateTime, y, m, d, ho, mi, sec, msec);
  Result := EncodeDateTime(y, m, d, ho, mi, sec, msec);
end;

function ChangeRelativeColorLuminance(AColor: TColor; Percent: Integer): TColor;
{$IFDEF EH_LIB_17}
var
  H, S, L, NL: Single;
begin
  RGBtoHSL(ColorToRGB(AColor), H, S, L);
  if Percent > 0
    then NL := L + (1-L) / 100 * Percent
    else NL := L + L / 100 * Percent;
  Result := MakeColor(HSLtoRGB(H, S, NL), 0);
end;
{$ELSE}
var
  H, S, L, NL: Word;
begin
  ColorRGBToHLS(ColorToRGB(AColor), H, L, S);
  if Percent < 0
    then NL := L - Trunc(Percent / 100 * L)
    else NL := L + Trunc(Percent / 100 * (240 - L));
  Result := ColorHLSToRGB(H, NL, S);
end;
{$ENDIF}

{ TCustomPlannerViewEh }

constructor TCustomPlannerViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Options := [
    goFixedVertLineEh, goFixedHorzLineEh, goVertLineEh, goHorzLineEh,
    goDrawFocusSelectedEh];
  FRangeMode := pdrmDayEh;
  FFirstWeekDayNum := 2;
  UpdateLocaleInfo;
  FFirstGridDayNum := FFirstWeekDayNum;
  FBarsPerRes := 1;
  FSpanItems := TObjectListEh.Create;
  FHoursBarArea := CreateHoursBarArea;
  FResourceCaptionArea := CreateResourceCaptionArea;
  FDayNameArea :=  CreateDayNameArea;
  FDataBarsArea := CreateDataBarsArea;
  BorderStyle := bsNone;
  FDataRowsOffset := 0;
  FDataColsOffset := 0;
  FGridControls := TObjectListEh.Create;
  CreateGridControls;
  HorzScrollBar.SmoothStep := True;
  ActiveMode := False;
  ShowHint := True;
  FMoveHintWindow := TMoveHintWindow.Create(Self);
  FOptions := [pgoAddEventOnDoubleClickEh];
  FSpanMoveSlidingTimer := TTimer.Create(Self);
  FSpanMoveSlidingTimer.Enabled := False;
  FSpanMoveSlidingTimer.OnTimer := SlidingTimerEvent;
  FSpanMoveSlidingTimer.Interval := 1;
  Align := alClient;
  FDrawSpanItemArgs := TDrawSpanItemArgsEh.Create;
  FDrawCellArgs := TPlannerViewCellDrawArgsEh.Create;
  FDrawTimeCellArgs := TPlannerViewTimeCellDrawArgsEh.Create;
  FDayNamesCellArgs := TPlannerViewDayNamesCellDrawArgsEh.Create;
  FInvalidateTime := TTimer.Create(nil);
  FInvalidateTime.Enabled := False;
  FInvalidateTime.OnTimer := TimerEvent;
  FInvalidateTime.Interval := 1000 * 60; 
  Visible := False;
  FSelectedRange := TPlannerViewSelectedRangeEh.Create;
end;

destructor TCustomPlannerViewEh.Destroy;
begin
  Destroying;
  if PlannerControl <> nil then
    PlannerControl.RemovePlannerGrid(Self);
  ClearSpanItems;
  ClearGridCells;
  FreeAndNil(FSpanItems);
  FreeAndNil(FDummyPlanItem);
  FreeAndNil(FDummyCheckPlanItem);
  DeleteGridControls;
  FreeAndNil(FGridControls);
  FreeAndNil(FMoveHintWindow);
  FreeAndNil(FSpanMoveSlidingTimer);
  FreeAndNil(FHoursBarArea);
  FreeAndNil(FResourceCaptionArea);
  FreeAndNil(FDayNameArea);
  FreeAndNil(FDataBarsArea);
  FreeAndNil(FDrawSpanItemArgs);
  FreeAndNil(FDrawCellArgs);
  FreeAndNil(FDrawTimeCellArgs);
  FreeAndNil(FDayNamesCellArgs);
  FreeAndNil(FHintFont);
  FreeAndNil(FInvalidateTime);
  FreeAndNil(FSelectedRange);
  inherited Destroy;
end;

procedure TCustomPlannerViewEh.CreateGridControls;
var
  GridControl: TPlannerInGridControlEh;
begin
  GridControl := TPlannerInGridControlEh.Create(Self);
  GridControl.FControlType := pgctNextEventEh;
  GridControl.Parent := Self;
  FGridControls.Add(GridControl);

  GridControl := TPlannerInGridControlEh.Create(Self);
  GridControl.FControlType := pgctPriorEventEh;
  GridControl.Parent := Self;
  FGridControls.Add(GridControl);
end;

function TCustomPlannerViewEh.CreateGridLineColors: TGridLineColorsEh;
begin
  Result := TPlannerGridLineParamsEh.Create(Self);
end;

function TCustomPlannerViewEh.GetGridLineParams: TPlannerGridLineParamsEh;
begin
  Result := TPlannerGridLineParamsEh(GridLineColors);
end;

procedure TCustomPlannerViewEh.SetGridLineParams(
  const Value: TPlannerGridLineParamsEh);
begin
  GridLineColors := Value;
end;

function TCustomPlannerViewEh.DefaultHoursBarSize: Integer;
begin
  Result := -1;
end;

function TCustomPlannerViewEh.GetDataBarsAreaDefaultBarSize: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := Font;
    Result := Trunc(Canvas.TextHeight('Wg') * 1.5);
  end else
    Result := 16;
end;

function TCustomPlannerViewEh.GetDayNameAreaDefaultColor: TColor;
begin
  Result := PlannerControl.GetActualDrawStyle.DayNameAreaFillColor;
end;

function TCustomPlannerViewEh.GetDayNameAreaDefaultSize: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := DayNameArea.Font;
    Result := Trunc(Canvas.TextHeight('Wg') * 1.5);
  end else
    Result := 16;
end;

function TCustomPlannerViewEh.GetDayNameAreaDefaultFont: TFont;
begin
  if PlannerControl <> nil
    then Result := PlannerControl.GetActualDrawStyle.GetDayNameAreaFont(Self, Font)
    else Result := Font;
end;

procedure TCustomPlannerViewEh.DeleteGridControls;
var
  i: Integer;
begin
  for i := 0 to FGridControls.Count-1 do
  begin
    FreeObjectEh(FGridControls[i]);
    FGridControls[i] := nil;
  end;
end;

procedure TCustomPlannerViewEh.GridLayoutChanged;
begin
  if not (csLoading in ComponentState) and ActiveMode then
  begin
    HoursBarArea.RefreshDefaultFont;
    ResourceCaptionArea.RefreshDefaultFont;
    DayNameArea.RefreshDefaultFont;
    BuildGridData;
  end;
end;

procedure TCustomPlannerViewEh.BuildGridData;
begin
  Invalidate;
  {$IFDEF FPC}
  {$ELSE}
  NotifyControls(CM_INVALIDATE);
  {$ENDIF}
  if ShowTopGridLine
    then FTopGridLineIndex := 0
    else FTopGridLineIndex := -1;
end;

procedure TCustomPlannerViewEh.ClearGridCells;
var
  i, j: Integer;
begin
  for i := 0 to ColCount-1 do
    for j := 0 to RowCount-1 do
      SpreadArray[i,j].Clear;
end;


procedure TCustomPlannerViewEh.SetCellCanvasParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
begin
  if (SelectedPlanItem <> nil) and
     (ACol >= FixedColCount-FrozenColCount) and
     (ARow >= FixedRowCount-FrozenRowCount) then
  begin
    Canvas.Font.Color := CheckSysColor(Font.Color);
    Canvas.Brush.Color := CheckSysColor(Color);
  end else
  begin
    inherited SetCellCanvasParams(ACol, ARow, ARect, State);
    if gdCurrent in State then
    begin
      Canvas.Font.Color := CheckSysColor(clWindowText);
      if gdFocused in State then
        Canvas.Brush.Color := FSelectedFocusedCellColor
      else
        Canvas.Brush.Color := FSelectedUnfocusedCellColor;
    end else if gdSelected in State then
    begin
      Canvas.Font.Color := CheckSysColor(clWindowText);
      if HasFocus then
        Canvas.Brush.Color := FSelectedFocusedCellColor
      else
        Canvas.Brush.Color := FSelectedUnfocusedCellColor;
    end;
  end;
end;

procedure TCustomPlannerViewEh.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
var
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
  Processed: Boolean;
  ADrawCellArgs: TPlannerViewCellDrawArgsEh;
begin
  GetCellType(ACol, ARow, CellType, ALocalCol, ALocalRow);

  ADrawCellArgs := GetCellDrawArgs(CellType);
  GetDrawCellParams(ACol, ARow, ARect, State, CellType, ALocalCol, ALocalRow, ADrawCellArgs);

  Processed := False;
  if Assigned(OnDrawCell) then
    OnDrawCell(Self, ACol, ARow, ARect, State, CellType, ALocalCol, ALocalRow, ADrawCellArgs, Processed);
  if not Processed then
    DefaultDrawPlannerViewCell(ACol, ARow, ARect, State, CellType, ALocalCol, ALocalRow, ADrawCellArgs);
end;

procedure TCustomPlannerViewEh.GetCellType(ACol, ARow: Integer;
  var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer);
begin
end;

procedure TCustomPlannerViewEh.DefaultDrawPlannerViewCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  case CellType of
    pctTopLeftCellEh:
      DrawTopLeftCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDataCellEh:
      DrawDataCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctAlldayDataCellEh:
      DrawAlldayDataCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctResourceCaptionCellEh:
      DrawResourceCaptionCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctInterResourceSpaceEh:
      DrawInterResourceCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDayNameCellEh:
      DrawDayNamesCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDateBarEh:
      DrawDateBar(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDateCellEh:
      DrawDateCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctTimeCellEh:
      DrawTimeCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctWeekNoCellEh:
      DrawWeekNoCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctMonthNameCellEh:
      DrawMonthNameCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
  end;
end;

procedure TCustomPlannerViewEh.GetWeekDayNamesParams(ACol, ARow: Integer;
  ALocalCol, ALocalRow: Integer; var WeekDayNum: Integer; var WeekDayName: String);
begin
  if RangeMode = pdrmMonthEh then
  begin
    WeekDayNum := (ACol-FDataColsOffset) mod FBarsPerRes + 1;
  end else
  begin
    WeekDayNum := (ACol-1) mod FBarsPerRes + 1;
  end;

  WeekDayNum := WeekDayNum + FFirstGridDayNum - 1;
  if WeekDayNum > 7 then WeekDayNum := WeekDayNum - 7;

  if FDayNameFormat = dnfLongFormatEh then
    WeekDayName := FormatSettings.LongDayNames[WeekDayNum]
  else if FDayNameFormat = dnfShortFormatEh then
    WeekDayName := FormatSettings.ShortDayNames[WeekDayNum]
  else
    WeekDayName := '';
end;

function TCustomPlannerViewEh.DrawLongDayNames: Boolean;
begin
  Result := True;
end;

function TCustomPlannerViewEh.DrawMonthDayWithWeekDayName: Boolean;
begin
  Result := True;
end;

procedure TCustomPlannerViewEh.DrawDateBar(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.DrawDateCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.DrawWeekNoCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.DrawMonthNameCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.DrawAlldayDataCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawAlldayDataCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TCustomPlannerViewEh.DrawTopLeftCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawTopLeftCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TCustomPlannerViewEh.GetResourceCaptionCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawArgs.Resource := GetResourceAtCell(ACol, ARow);
  DrawArgs.FontColor := ResourceCaptionArea.Font.Color;
  DrawArgs.FontName := ResourceCaptionArea.Font.Name;
  DrawArgs.FontSize := ResourceCaptionArea.Font.Size;
  DrawArgs.FontStyle := ResourceCaptionArea.Font.Style;

  if DrawArgs.Resource = nil then
  begin
    DrawArgs.BackColor := CheckSysColor(ResourceCaptionArea.GetActualColor);
    DrawArgs.Text := EhLibLanguageConsts.PlannerResourceUnassignedEh; 
  end else
  begin
    if DrawArgs.Resource.Color = clDefault
      then DrawArgs.BackColor := PlannerControl.GetActualDrawStyle.GetResourceCellFillColor
      else DrawArgs.BackColor := DrawArgs.Resource.FaceColor;
    DrawArgs.Text := DrawArgs.Resource.Name;
  end;
end;

procedure TCustomPlannerViewEh.DrawResourceCaptionCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawResourceCaptionCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TCustomPlannerViewEh.DrawDayNamesCellBack(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawDayNamesCellBack(Self, Canvas, ARect,
    State, TPlannerViewDayNamesCellDrawArgsEh(DrawArgs));
end;

procedure TCustomPlannerViewEh.DrawDayNamesCellFore(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawDayNamesCellFore(Self, Canvas, ARect,
    State, TPlannerViewDayNamesCellDrawArgsEh(DrawArgs));
end;

procedure TCustomPlannerViewEh.GetDayNamesCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  DayNamesDrawArgs: TPlannerViewDayNamesCellDrawArgsEh;
  CellDate: TDateTime;
  DName: String;
  DNum: Integer;
begin
  DName := '';
  DrawArgs.Resource := GetResourceAtCell(ACol, ARow);

  if (DrawArgs.Resource <> nil) and
     (DrawArgs.Resource.Color <> clDefault)
    then DrawArgs.BackColor := CheckSysColor(DrawArgs.Resource.FaceColor)
    else DrawArgs.BackColor := CheckSysColor(DayNameArea.GetActualColor);

  DayNamesDrawArgs := TPlannerViewDayNamesCellDrawArgsEh(DrawArgs);

  GetWeekDayNamesParams(ACol, ARow, ALocalCol, ALocalRow, DNum, DName);

  DayNamesDrawArgs.Value := DNum;
  DayNamesDrawArgs.Text := DName;
  DayNamesDrawArgs.DrawMonthDay := DrawMonthDayWithWeekDayName;
  CellDate := CellToDateTime(ACol, ARow);
  DayNamesDrawArgs.MonthDay := FormatDateTime('DD', CellDate);
  DayNamesDrawArgs.MonthDayFontStyle := [fsBold];
  DayNamesDrawArgs.HighlightToday := pvoHighlightTodayEh in PlannerControl.Options;

  DrawArgs.FontColor := DayNameArea.Font.Color;
  DrawArgs.FontName := DayNameArea.Font.Name;
  DrawArgs.FontSize := DayNameArea.Font.Size;
  DrawArgs.FontStyle := DayNameArea.Font.Style;
  DrawArgs.BackColor := DayNameArea.GetActualColor;
end;

procedure TCustomPlannerViewEh.DrawDayNamesCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawDayNamesCell(Self, Canvas, ARect, State,
    TPlannerViewDayNamesCellDrawArgsEh(DrawArgs));
end;

procedure TCustomPlannerViewEh.GetInterResourceCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawArgs.BackColor := Color;
end;

procedure TCustomPlannerViewEh.DrawInterResourceCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawInterResourceCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TCustomPlannerViewEh.DrawDataCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawDataCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TCustomPlannerViewEh.DrawCurTimeLineRect(ATimeLineRect: TRect;
  const ClipRect: TRect);
var
  LineItemRect: TRect;
begin
  Canvas.Brush.Color := ApproachToColorEh(PlannerDrawStyleEh.GetActlTodayFrameColor, Canvas.Brush.Color, 66);

  if RectWidth(ATimeLineRect) > RectHeight(ATimeLineRect) then
  begin
    if ATimeLineRect.Left < ClipRect.Left then
      ATimeLineRect.Left := ClipRect.Left;
    if ATimeLineRect.Right > ClipRect.Right then
      ATimeLineRect.Right := ClipRect.Right;

    LineItemRect := ATimeLineRect;
    LineItemRect.Bottom := LineItemRect.Top + 1;
    Canvas.FillRect(LineItemRect);

    LineItemRect := ATimeLineRect;
    LineItemRect.Top := LineItemRect.Bottom - 1;
    Canvas.FillRect(LineItemRect);

    Canvas.Brush.Color := PlannerDrawStyleEh.GetActlTodayFrameColor;
    LineItemRect := ATimeLineRect;
    LineItemRect.Bottom := LineItemRect.Bottom - 1;
    LineItemRect.Top := LineItemRect.Top + 1;
    Canvas.FillRect(LineItemRect);
  end else
  begin
    if ATimeLineRect.Top < ClipRect.Top then
      ATimeLineRect.Top := ClipRect.Top;
    if ATimeLineRect.Bottom > ClipRect.Bottom then
      ATimeLineRect.Bottom := ClipRect.Bottom;

    LineItemRect := ATimeLineRect;
    LineItemRect.Right := LineItemRect.Left + 1;
    Canvas.FillRect(LineItemRect);

    LineItemRect := ATimeLineRect;
    LineItemRect.Left := LineItemRect.Right - 1;
    Canvas.FillRect(LineItemRect);

    Canvas.Brush.Color := PlannerDrawStyleEh.GetActlTodayFrameColor;
    LineItemRect := ATimeLineRect;
    LineItemRect.Right := LineItemRect.Right - 1;
    LineItemRect.Left := LineItemRect.Left + 1;
    Canvas.FillRect(LineItemRect);
  end;
end;

procedure TCustomPlannerViewEh.GetTimeCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  SprCell: TSpreadGridCellEh;
  SH, SM: String;
  CurTimeLineRect: TRect;
  ATime: TTime;
  h, m, s, ms: Word;
  TimeCellDrawArgs: TPlannerViewTimeCellDrawArgsEh;
begin

  SprCell := SpreadArray[ACol, ARow];

  ATime := VarToDateTime(SprCell.Value);
  DecodeTime(ATime, h, m, s, ms);
  if AmPm12 then
  begin
    SH := Copy(FormatDateTime('h am/pm', ATime), 1, 2);
    if h = 0 then
      SM := NlsLowerCase(Copy(FormatSettings.TimeAMString, 1, 2))
    else if h = 12 then
      SM := NlsLowerCase(Copy(FormatSettings.TimePMString, 1, 2))
    else
      SM := '00';
  end else
  begin
    SH := FormatFloat('0', h);
    SM := '00';
  end;

  TimeCellDrawArgs := TPlannerViewTimeCellDrawArgsEh(DrawArgs);
  TimeCellDrawArgs.Time := VarToDateTime(SprCell.Value);
  TimeCellDrawArgs.HoursStr := SH;
  TimeCellDrawArgs.MinutesStr := SM;

  if (pvoHighlightTodayEh in PlannerControl.Options) and
     IsDrawCurrentTimeLineForCell(pctTimeCellEh) then
  begin
    GetCurrentTimeLineRect(CurTimeLineRect);
    TimeCellDrawArgs.DrawTimeLine := True;
    TimeCellDrawArgs.DrawTimeRect := CurTimeLineRect;
  end;

  TimeCellDrawArgs.BackColor := HoursBarArea.GetActualColor;
  TimeCellDrawArgs.FontColor := HoursBarArea.Font.Color;
  TimeCellDrawArgs.FontName := HoursBarArea.Font.Name;
  TimeCellDrawArgs.FontSize := HoursBarArea.Font.Size;
  TimeCellDrawArgs.FontStyle := HoursBarArea.Font.Style;
  TimeCellDrawArgs.HoursFontSize := HoursBarArea.Font.Size;
  TimeCellDrawArgs.MinutesFontSize := HoursBarArea.Font.Size * 2 div 3;
end;

procedure TCustomPlannerViewEh.DrawTimeCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawTimeCell(Self, Canvas, ARect, State,
    TPlannerViewTimeCellDrawArgsEh(DrawArgs));
end;

function TCustomPlannerViewEh.GetCellDrawArgs(CellType: TPlannerViewCellTypeEh): TPlannerViewCellDrawArgsEh;
begin
  case CellType of
    pctTopLeftCellEh:
      Result := FDrawCellArgs;
    pctDataCellEh:
      Result := FDrawCellArgs;
    pctAlldayDataCellEh:
      Result := FDrawCellArgs;
    pctResourceCaptionCellEh:
      Result := FDrawCellArgs;
    pctInterResourceSpaceEh:
      Result := FDrawCellArgs;
    pctDayNameCellEh:
      Result := FDayNamesCellArgs;
    pctDateBarEh:
      Result := FDrawCellArgs;
    pctDateCellEh:
      Result := FDrawCellArgs;
    pctTimeCellEh:
      Result := FDrawTimeCellArgs;
    pctWeekNoCellEh:
      Result := FDrawCellArgs;
    pctMonthNameCellEh:
      Result := FDrawCellArgs;
    else
      Result := FDrawCellArgs;
  end;
end;

procedure TCustomPlannerViewEh.GetDrawCellParams(ACol, ARow: Integer;
  ARect: TRect; var State: TGridDrawState; CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  CellDate: TDateTime;
begin
  DrawArgs.Value := Cell[ACol, ARow].Value;
  DrawArgs.Text := '';
  DrawArgs.Alignment := taLeftJustify;
  DrawArgs.Layout := tlTop;
  DrawArgs.WordWrap := False;
  DrawArgs.Orientation := tohHorizontal;
  DrawArgs.HorzMargin := 0;
  DrawArgs.VertMargin := 0;
  DrawArgs.FontColor := CheckSysColor(Font.Color);
  DrawArgs.FontName := Font.Name;
  DrawArgs.FontSize := Font.Size;
  DrawArgs.FontStyle := Font.Style;
  DrawArgs.BackColor := Color;
  DrawArgs.WorkTime := stUndefinedEh;
  DrawArgs.Resource := nil;
  DrawArgs.HighlightToday := pvoHighlightTodayEh in PlannerControl.Options;

  CellDate := CellToDateTime(ACol, ARow);
  if DateOf(CellDate) = DateOf(Today)
    then DrawArgs.TodayDate := sbTrueEh
    else DrawArgs.TodayDate := sbFalseEh;

  case CellType of
    pctTopLeftCellEh:
      GetTopLeftCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDataCellEh:
      GetDataCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctAlldayDataCellEh:
      GetAlldayDataCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctResourceCaptionCellEh:
      GetResourceCaptionCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctInterResourceSpaceEh:
      GetInterResourceCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDayNameCellEh:
      GetDayNamesCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDateBarEh:
      GetDateBarDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctDateCellEh:
      GetDateCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctTimeCellEh:
      GetTimeCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctWeekNoCellEh:
      GetWeekNoCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
    pctMonthNameCellEh:
      GetMonthNameCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
  end;
end;

procedure TCustomPlannerViewEh.GetAlldayDataCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawArgs.BackColor := Color;
end;

procedure TCustomPlannerViewEh.GetDataCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; var State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  DrawCellDate: TDateTime;
begin
  DrawCellDate := CellToDateTime(ACol, ARow);
  DrawArgs.Resource := GetResourceAtCell(ACol, ARow);

  if IsWorkingTime(DrawCellDate) and IsWorkingDay(DrawCellDate)
    then DrawArgs.WorkTime := sbTrueEh
    else DrawArgs.WorkTime := sbFalseEh;

  if (SelectedRange.FromDateTime < SelectedRange.ToDateTime) then
  begin
    if (SelectedRange.FromDateTime <= DrawCellDate) and
       (DrawCellDate < SelectedRange.ToDateTime) and
       (DrawArgs.Resource = SelectedRange.Resource)
    then
      State := State + [gdSelected];
  end;

end;

procedure TCustomPlannerViewEh.GetDateBarDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.GetDateCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.GetTopLeftCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawArgs.BackColor := PlannerControl.Color;
end;

procedure TCustomPlannerViewEh.GetWeekNoCellDrawParams(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.GetMonthNameCellDrawParams(ACol, ARow: Integer; ARect:
  TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
end;

procedure TCustomPlannerViewEh.EnsureDataForPeriod(AStartDate,
  AEndDate: TDateTime);
begin
  if PlannerDataSource <> nil then
  begin
    FIgnorePlannerDataSourceChanged := True;
    try
      PlannerDataSource.EnsureDataForPeriod(AStartDate, AEndDate);
    finally
      FIgnorePlannerDataSourceChanged := False;
    end;
  end;
end;

function TCustomPlannerViewEh.EventNavBoxBorderColor: TColor;
begin
  if PlannerControl <> nil
    then Result := PlannerControl.EventNavBoxParams.GetActualBorderColor
    else Result := ChangeColorLuminance(FResourceCellFillColor, 150);
end;

function TCustomPlannerViewEh.EventNavBoxColor: TColor;
begin
  if PlannerControl <> nil
    then Result := PlannerControl.EventNavBoxParams.GetActualColor
    else Result := FResourceCellFillColor;
end;

function TCustomPlannerViewEh.EventNavBoxFont: TFont;
begin
  if PlannerControl <> nil
    then Result := PlannerControl.EventNavBoxParams.Font
    else Result := Font;
end;


procedure TCustomPlannerViewEh.RangeModeChanged;
begin
  GridLayoutChanged;
end;

procedure TCustomPlannerViewEh.Resize;
begin
  inherited Resize;
  if HandleAllocated and not (csLoading in ComponentState) then
  begin
    RangeModeChanged;
    RealignGridControls;
  end;
end;

function TCustomPlannerViewEh.ResourcesCount: Integer;
begin
  if PlannerDataSource <> nil
    then Result := PlannerDataSource.Resources.Count
    else Result := 0;
end;

procedure TCustomPlannerViewEh.SetRangeMode(
  const Value: TPlannerDateRangeModeEh);
begin
  if FRangeMode <> Value then
  begin
    FRangeMode := Value;
    RangeModeChanged;
  end;
end;

procedure TCustomPlannerViewEh.SetResourceCaptionArea(
  const Value: TResourceCaptionAreaEh);
begin
  FResourceCaptionArea.Assign(Value);
end;

function TCustomPlannerViewEh.AdjustDate(const Value: TDateTime): TDateTime;
begin
  Result := DateOf(Value);
end;

procedure TCustomPlannerViewEh.SetSelectedSpanItem(
  const Value: TPlannerDataItemEh);
begin
  if FSelectedPlanItem <> Value then
  begin
    FSelectedPlanItem := Value;
    InvalidateGrid;
    SelectionChanged;
  end;
end;

procedure TCustomPlannerViewEh.SetStartDate(const Value: TDateTime);
var
  AdjustedDate: TDateTime;
begin
  AdjustedDate := AdjustDate(Value);
  if FStartDate <> AdjustedDate then
  begin
    FStartDate := AdjustedDate;
    ResetLoadedTimeRange;
    StartDateChanged;
  end;
end;

procedure TCustomPlannerViewEh.SetCurrentTime(const Value: TDateTime);
begin
  if FCurrentTime <> Value then
  begin
    FCurrentTime := Value;
    PlannerControl.GridCurrentTimeChanged(FCurrentTime);
    StartDate := Value;
  end;
end;

procedure TCustomPlannerViewEh.SelectionChanged;
begin
  if Assigned(OnSelectionChanged) then
    OnSelectionChanged(Self);
end;

procedure TCustomPlannerViewEh.SetActiveMode(const Value: Boolean);
begin
  if FActiveMode <> Value then
  begin
    FActiveMode := Value;
    if Value then
      PlannerDataSourceChanged;
  end;
end;

procedure TCustomPlannerViewEh.GetViewPeriod(var AStartDate, AEndDate: TDateTime);
begin
  AStartDate := FStartDate;
  AEndDate := FStartDate + 1;
end;

procedure TCustomPlannerViewEh.GotoNextEventInTheFuture;
var
  ANextTime: Variant;
  AStartDate, AEndDate: TDateTime;
begin
  GetViewPeriod(AStartDate, AEndDate);
  ANextTime := GetNextEventAfter(AEndDate);
  if not VarIsNull(ANextTime) then
    CurrentTime := ANextTime;
end;

function TCustomPlannerViewEh.GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
begin
  Result := pcpDayEh;
end;

function TCustomPlannerViewEh.GetNextEventAfter(ADateTime: TDateTime): Variant;
var
  i: Integer;
  PlanItem: TPlannerDataItemEh;
begin
  Result := Null;

  if Assigned(PlannerDataSource) then
  begin
    for i := 0 to PlannerDataSource.Count - 1 do
    begin
      PlanItem := PlannerDataSource[i];
      if (PlanItem.StartTime > ADateTime) then 
      begin
        Result := PlanItem.StartTime;
        Break;
      end;
    end;
  end;
end;

procedure TCustomPlannerViewEh.GotoPriorEventInThePast;
var
  ANextTime: Variant;
  AStartDate, AEndDate: TDateTime;
begin
  GetViewPeriod(AStartDate, AEndDate);
  ANextTime := GetNextEventBefore(AStartDate);
  if not VarIsNull(ANextTime) then
    CurrentTime := ANextTime;
end;

function TCustomPlannerViewEh.GetNextEventBefore(ADateTime: TDateTime): Variant;
var
  i: Integer;
  PlanItem: TPlannerDataItemEh;
begin
  Result := Null;

  if Assigned(PlannerDataSource) then
  begin
    for i := PlannerDataSource.Count - 1 downto 0 do
    begin
      PlanItem := PlannerDataSource[i];
      if (PlanItem.StartTime < ADateTime) then 
      begin
        Result := PlanItem.StartTime;
        Break;
      end;
    end;
  end;
end;

procedure TCustomPlannerViewEh.RealignGridControl(AGridControl: TPlannerInGridControlEh);
var
  w1, w2, h: Integer;
  ARect: TRect;
  LeftBound: Integer;
begin
  if not HandleAllocated {or not AGridControl.HandleAllocated} then Exit;

  if (not AGridControl.Visible) then
  begin
    AGridControl.BoundsRect := Rect(0, 0, 0, 0);
    Exit;
  end;

  Canvas.Font := EventNavBoxFont;
  h := Canvas.TextHeight(EhLibLanguageConsts.PlannerNextEventEh);
  w1 := Canvas.TextWidth(EhLibLanguageConsts.PlannerNextEventEh);
  w2 := Canvas.TextWidth(EhLibLanguageConsts.PlannerPriorEventEh);
  if w2 > w1 then w1 := w2;
  h := h * 2;
  w1 := Round(w1 * 1.5);
  ARect := Rect(0, 0, h, w1);
  ARect := CenteredRect(Rect(0, VertAxis.FixedBoundary, ARect.Right - ARect.Left, VertAxis.ContraStart), ARect);
  if HorzAxis.FixedBoundary > 0
    then LeftBound := HorzAxis.FixedBoundary-1
    else LeftBound := 0;
  if AGridControl.ControlType = pgctNextEventEh then
    OffsetRect(ARect, HorzAxis.ContraStart - (ARect.Right - ARect.Left), 0)
  else
    OffsetRect(ARect, LeftBound, 0);
  if UseRightToLeftAlignment then
    ARect := RightToLeftReflectRect(ClientRect, ARect);
  AGridControl.BoundsRect := ARect;
end;

procedure TCustomPlannerViewEh.RealignGridControls;
var
  i: Integer;
begin
  for i := 0 to FGridControls.Count-1 do
    TPlannerInGridControlEh(FGridControls[i]).Realign;
end;

procedure TCustomPlannerViewEh.ResetGridControlsState;
var
  i: Integer;
  GridCtrl: TPlannerInGridControlEh;
  AStartDate, AEndDate: TDateTime;
begin
  GetViewPeriod(AStartDate, AEndDate);
  for i := 0 to FGridControls.Count-1 do
  begin
    GridCtrl := TPlannerInGridControlEh(FGridControls[i]);
    GridCtrl.Visible := (FSpanItems.Count = 0) and PlannerControl.EventNavBoxParams.Visible;
    if GridCtrl.ControlType = pgctNextEventEh then
      GridCtrl.ClickEnabled := not VarIsNull(GetNextEventAfter(AEndDate))
    else
      GridCtrl.ClickEnabled := not VarIsNull(GetNextEventBefore(AStartDate));
  end;
end;

function TCustomPlannerViewEh.IsResourceCaptionNeedVisible: Boolean;
begin
  Result := (PlannerDataSource <> nil) and (PlannerDataSource.Resources.Count > 0);
end;

function TCustomPlannerViewEh.IsDayNameAreaNeedVisible: Boolean;
begin
  Result := False;
end;

function TCustomPlannerViewEh.IsWorkingDay(const Value: TDateTime): Boolean;
var
  WeekDay: TWeekDayEh;
begin
  if (PlannerControl.CurWorkingTimeCalendar <> nil) then
    Result := PlannerControl.CurWorkingTimeCalendar.IsWorkday(Value)
  else
  begin
    WeekDay := DateToWeekDayEh(Value);
    Result := WeekDay in EhLibManager.WeekWorkingDays;
  end;
end;

function TCustomPlannerViewEh.IsWorkingTime(const Value: TDateTime): Boolean;
var
  y, m, d, ho, mi, sec, msec: Word;
  StartWorkTime, StopWorkTime: TDateTime;
begin
  DecodeDateTime(Value, y, m, d, ho, mi, sec, msec);
  StartWorkTime := DateOf(Value) + TimeOf(PlannerControl.WorkingTimeStart);
  StopWorkTime := DateOf(Value) + TimeOf(PlannerControl.WorkingTimeEnd);
  Result := (Value >= StartWorkTime) and (Value < StopWorkTime);
end;

function TCustomPlannerViewEh.DeletePrompt: Boolean;
{$IFDEF FPC_CROSSP}
begin
  Result := False;
end;
{$ELSE}
var
  Msg: string;
  Handle: THandle;
begin
  Handle := GetFocus;
  Msg := EhLibLanguageConsts.PlannerDeletePlanItemEh; 
  Result := {not (dgConfirmDelete in Options) or}
    (MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel);
  if GetFocus <> Handle then
    Windows.SetFocus(Handle);
end;
{$ENDIF} 

procedure TCustomPlannerViewEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_ESCAPE) and (FPlannerState <> psNormalEh) then
  begin
    CancelMode;
    StopPlannerState(False, -1, -1);
  end;

  if (Key = VK_DELETE) and (FSelectedPlanItem <> nil) then
    if PlannerControl.CheckPlannerItemChangeOperation(Self, FSelectedPlanItem, paoDeletePlanItemEh) and
       DeletePrompt
    then
      PlannerControl.PlannerDataSource.DeleteItem(FSelectedPlanItem);

  if (Key = VK_F2) and (FPlannerState = psNormalEh) and (FSelectedPlanItem <> nil) then
  begin
    StartSpanMove(SpanItemByPlanItem(FSelectedPlanItem), ScreenToClient(Mouse.CursorPos));
    SetPlannerState(psSpanTestMovingEh);
  end;
end;

procedure TCustomPlannerViewEh.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
var
  HitSpanItem: TTimeSpanDisplayItemEh;
begin
  HitSpanItem := CheckHitSpanItem(mbRight, [], MousePos.X, MousePos.Y);
  if HitSpanItem <> nil then
  begin
    PlannerControl.DoTimeSpanContextPopup(MousePos, Self, HitSpanItem);
    Handled := True;
  end else
    inherited DoContextPopup(MousePos, Handled);
end;

procedure TCustomPlannerViewEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SideStates: array[TRectangleSideEh] of TPlannerStateEh =
    (psSpanLeftSizingEh, psSpanRightSizingEh, psSpanTopSizingEh, psSpanButtomSizingEh);
var
  HitSpanItem: TTimeSpanDisplayItemEh;
  SpanItem: TTimeSpanDisplayItemEh;
  Side: TRectangleSideEh;
  CellHit: TGridCoord;
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
begin
  FMouseDoubleClickProcessed := False;
  FMouseDownPos := Point(X, Y);
  HitSpanItem := CheckHitSpanItem(Button, Shift, X, Y);
  CellHit := MouseCoord(X, Y);

  if (CellHit.X >= 0) and (CellHit.Y >= 0) then
  begin
    GetCellType(CellHit.X, CellHit.Y, CellType, ALocalCol, ALocalRow);
  end else
  begin
    CellType := pctTopLeftCellEh;
    ALocalCol := -1;
    ALocalRow := -1;
  end;

  if HitSpanItem <> nil then
  begin
    if not CanFocus then Exit;
    SetFocus;
    SelectedPlanItem := HitSpanItem.PlanItem;
    if (Button = mbLeft) and (ssDouble in Shift) then
    begin
      HitSpanItem.DblClick;
      FMouseDoubleClickProcessed := True;
      DblClick;
    end;
  end else
  begin
    SelectedPlanItem := nil;
    inherited MouseDown(Button, Shift, X, Y);
  end;

  if (Button = mbLeft) and not (ssDouble in Shift) then
  begin
    if CheckSpanItemSizing(Point(X, Y), SpanItem, Side) then
    begin
      SetPlannerState(SideStates[Side]);
      FDummyPlanItem.Assign(SpanItem.PlanItem);
      FDummyPlanItemFor := SpanItem.PlanItem;
      MouseCapture := True;
    end else if (HitSpanItem = nil) and
                (pvoRangeSelectEh in PlannerControl.Options) and
                (ALocalCol >= 0) and
                (ALocalRow >= 0) and
                (CellType = pctDataCellEh) then
    begin
      SetPlannerState(psCellsRangeSelectionEh);
      MouseCapture := True;
    end;
  end;
end;

procedure TCustomPlannerViewEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ASpeed: Integer;
  ASlideDirection: TGridScrollDirection;

  CellHit: TGridCoord;
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (FPlannerState = psNormalEh) and CheckStartSpanMove(Point(X, Y)) then
    SetPlannerState(psSpanMovingEh);
  if FPlannerState in
      [psSpanLeftSizingEh, psSpanRightSizingEh, psSpanButtomSizingEh,
       psSpanTopSizingEh, psSpanMovingEh, psSpanTestMovingEh]
  then
    UpdateDummySpanItemSize(Point(X, Y));


  if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    if CanSpanMoveSliding(Point(X, Y), ASpeed, ASlideDirection) then
      StartSpanMoveSliding(ASpeed, ASlideDirection)
    else
      StopSpanMoveSliding;
    UpdateDummySpanItemSize(Point(X, Y));
  end;

  if FPlannerState = psCellsRangeSelectionEh then
  begin
    CellHit := MouseCoord(X, Y);
    if (CellHit.X >= 0) and (CellHit.Y >= 0) then
    begin
      GetCellType(CellHit.X, CellHit.Y, CellType, ALocalCol, ALocalRow);
      if (ALocalCol >= 0) and
         (ALocalRow >= 0) and
         (CellType = pctDataCellEh) then
      begin
        SetSelectionRange(GridCoord(Col, Row), CellHit);
      end;
    end;
  end;
end;

procedure TCustomPlannerViewEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FPlannerState in [psSpanLeftSizingEh, psSpanRightSizingEh,
      psSpanTopSizingEh, psSpanButtomSizingEh, psSpanMovingEh,
      psCellsRangeSelectionEh]
  then
    StopPlannerState(True, X, Y);
end;

procedure TCustomPlannerViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if (Button = mbLeft) and
     (ssDouble in Shift) and
     (pgoAddEventOnDoubleClickEh in Options) and
     (Cell.X >= FDataColsOffset) and
     (Cell.Y >= FDataRowsOffset) and
     (SelectedPlanItem = nil) and
     (FMouseDoubleClickProcessed = False) and
     (PlannerDataSource <> nil) and
     PlannerControl.CheckPlannerItemChangeOperation(Self, nil, paoAppendPlanItemEh)
  then
    PlannerControl.ShowNewPlanItemDialog;
end;

function TCustomPlannerViewEh.CheckStartSpanMove(MousePos: TPoint): Boolean;
var
  HitSpanItem: TTimeSpanDisplayItemEh;
begin
  Result := False;
  if MouseCapture and
   ( (Abs(FMouseDownPos.X - MousePos.X) > 5) or (Abs(FMouseDownPos.Y - MousePos.Y) > 5)) then
  begin
    HitSpanItem := CheckHitSpanItem(mbLeft, [], FMouseDownPos.X, FMouseDownPos.Y);
    if (HitSpanItem <> nil) and
       (sichSpanMovingEh in HitSpanItem.AllowedInteractiveChanges) then
    begin
      StartSpanMove(HitSpanItem, FMouseDownPos);
      Result := True;
    end;
  end;
end;

procedure TCustomPlannerViewEh.InitSpanItemMoving(SpanItem: TTimeSpanDisplayItemEh;
  MousePos: TPoint);
begin

end;

procedure TCustomPlannerViewEh.StartSpanMove(SpanItem: TTimeSpanDisplayItemEh;
  MousePos: TPoint);
begin
  if (SpanItem <> nil) and
     (sichSpanMovingEh in SpanItem.AllowedInteractiveChanges) then
  begin
    FTopLeftSpanShift.cx := -5;
    FTopLeftSpanShift.cy := -5;
    InitSpanItemMoving(SpanItem, MousePos);
    FDummyPlanItem.Assign(SpanItem.PlanItem);
    FDummyPlanItemFor := SpanItem.PlanItem;
  end;
end;

procedure TCustomPlannerViewEh.StopPlannerState(Accept: Boolean; X, Y: Integer);
var
  DataChanged: Boolean;
begin
  if FPlannerState <> psNormalEh then
  begin
    if (FDummyPlanItemFor <> nil) and (FDummyPlanItem <> nil) then
    begin
      DataChanged :=
        (FDummyPlanItemFor.StartTime <> FDummyPlanItem.StartTime) or
        (FDummyPlanItemFor.EndTime <> FDummyPlanItem.EndTime) or
        (FDummyPlanItemFor.Resource <> FDummyPlanItem.Resource) or
        (FDummyPlanItemFor.AllDay <> FDummyPlanItem.AllDay);
      if Accept and DataChanged then
      begin
        FDummyCheckPlanItem.Assign(FDummyPlanItemFor);
        FDummyPlanItemFor.BeginEdit;
        FDummyPlanItemFor.StartTime := FDummyPlanItem.StartTime;
        FDummyPlanItemFor.EndTime := FDummyPlanItem.EndTime;
        FDummyPlanItemFor.Resource := FDummyPlanItem.Resource;
        FDummyPlanItemFor.AllDay := FDummyPlanItem.AllDay;
        FDummyPlanItemFor.EndEdit(True);
        NotifyPlanItemChanged(FDummyPlanItemFor, FDummyCheckPlanItem);
      end;
    end;
    SetPlannerState(psNormalEh);
    FDummyPlanItemFor := nil;
    MouseCapture := False;
    PlannerDataSourceChanged;
    StopSpanMoveSliding;
  end;
end;

procedure TCustomPlannerViewEh.CancelMode;
begin
  inherited CancelMode;
  if FPlannerState in [psSpanLeftSizingEh, psSpanRightSizingEh,
      psSpanTopSizingEh, psSpanButtomSizingEh, psSpanMovingEh,
      psCellsRangeSelectionEh]
  then
    StopPlannerState(False, -1, -1);
end;

procedure TCustomPlannerViewEh.StartDateChanged;
begin
  if PlannerControl <> nil then
    PlannerControl.StartDateChanged;
end;

function TCustomPlannerViewEh.CheckSpanItemSizing(MousePos: TPoint;
  out SpanItem: TTimeSpanDisplayItemEh; var Side: TRectangleSideEh): Boolean;
var
  Pos: TPoint;
  i: Integer;
  CurSpanItem: TTimeSpanDisplayItemEh;
  SpanDrawRect: TRect;
begin
  Result := False;

  Pos := Point(MousePos.X, MousePos.Y);

  for i := 0 to FSpanItems.Count-1 do
  begin
    CurSpanItem := SpanItems[i];
    CurSpanItem.GetInGridDrawRect(SpanDrawRect);
    if UseRightToLeftAlignment then
      SpanDrawRect := RightToLeftReflectRect(ClientRect, SpanDrawRect);
    if PtInRect(SpanDrawRect, Pos) and
       not CurSpanItem.PlanItem.ReadOnly then
    begin
      if (SpanDrawRect.Top + 5 >= Pos.Y) and
         (sichSpanTopSizingEh in CurSpanItem.AllowedInteractiveChanges) then
      begin
        Side := rsTopEh;
        SpanItem := CurSpanItem;
        Result := True;
      end else if (SpanDrawRect.Bottom - 5 <= Pos.Y) and
                  (sichSpanButtomSizingEh in CurSpanItem.AllowedInteractiveChanges) then
      begin
        Side := rsBottomEh;
        SpanItem := CurSpanItem;
        Result := True;
      end else if (SpanDrawRect.Left + 8 >= Pos.X) and
                  (sichSpanLeftSizingEh in CurSpanItem.AllowedInteractiveChanges) then
      begin
        Side := rsLeftEh;
        if UseRightToLeftAlignment then
          Side := rsRightEh;
        SpanItem := CurSpanItem;
        Result := True;
      end else if (SpanDrawRect.Right - 8 <= Pos.X) and
                  (sichSpanRightSizingEh in CurSpanItem.AllowedInteractiveChanges) then
      begin
        Side := rsRightEh;
        if UseRightToLeftAlignment then
          Side := rsLeftEh;
        SpanItem := CurSpanItem;
        Result := True;
      end;
      Break;
    end;
  end;
end;

function TCustomPlannerViewEh.CheckHitSpanItem(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer): TTimeSpanDisplayItemEh;
var
  Pos: TPoint;
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
  SpanDrawRect: TRect;
  RollCliBounds: TRect;
begin
  Result := nil;
  RollCliBounds := Rect(HorzAxis.FixedBoundary, VertAxis.FixedBoundary, HorzAxis.ContraStart, VertAxis.ContraStart);
  if UseRightToLeftAlignment then
    RollCliBounds := RightToLeftReflectRect(ClientRect, RollCliBounds);
  if (X >= RollCliBounds.Left) and (X < RollCliBounds.Right) and
     (Y >= RollCliBounds.Top) and (Y < RollCliBounds.Bottom) then
  begin
    Pos := Point(X, Y);
    for i := 0 to FSpanItems.Count-1 do
    begin
      SpanItem := SpanItems[i];
      SpanItem.GetInGridDrawRect(SpanDrawRect);
      if UseRightToLeftAlignment then
        SpanDrawRect := RightToLeftReflectRect(ClientRect, SpanDrawRect);
      if PtInRect(SpanDrawRect, Pos) then
      begin
        Result := SpanItem;
        Break;
      end;
    end;
  end;
end;

function TCustomPlannerViewEh.ClientToGridRolPos(Pos: TPoint): TPoint;
begin
  Result := Point(Pos.X + HorzAxis.RolStartVisPos, Pos.Y + VertAxis.RolStartVisPos);
end;

function TCustomPlannerViewEh.NewItemParams(var StartTime,
  EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean;
begin
  StartTime := 0;
  EndTime := 0;
  Resource := nil;
  Result := True;
end;

function TCustomPlannerViewEh.GridCoordToDataCoord(const AGridCoord: TGridCoord): TGridCoord;
begin
  Result.X := AGridCoord.X - FDataColsOffset;
  Result.Y := AGridCoord.Y - FDataRowsOffset;
end;

function TCustomPlannerViewEh.CellToDateTime(ACol, ARow: Integer): TDateTime;
begin
  Result := 0;
end;

procedure TCustomPlannerViewEh.DrawSpanItem(SpanItem: TTimeSpanDisplayItemEh;
  DrawRect: TRect);
var
  DrawState: TDrawSpanItemDrawStateEh;
  DrawProcessed: Boolean;
begin

  DrawState := [];
  if (SpanItem.PlanItem = SelectedPlanItem) and not (FPlannerState in [psSpanMovingEh, psSpanTestMovingEh]) then
    DrawState := DrawState + [sidsSelectedEh]
  else if (FPlannerState in [psSpanMovingEh, psSpanTestMovingEh]) and (SpanItem.PlanItem = FDummyPlanItem) then
    DrawState := DrawState + [sidsSelectedEh];

  if Focused then
    DrawState := DrawState + [sidsFocusedEh];


  DrawProcessed := False;
  FDrawSpanItemArgs.DrawState := DrawState;
  FDrawSpanItemArgs.Text := SpanItem.PlanItem.Title;
  FDrawSpanItemArgs.Alignment := SpanItem.FAlignment;
  FDrawSpanItemArgs.Font := GetPlannerControl.TimeSpanParams.Font;

  if SpanItem.PlanItem.FillColor <> clDefault then
  begin
    FDrawSpanItemArgs.FillColor := SpanItem.PlanItem.FillColor;
    FDrawSpanItemArgs.AltFillColor := ChangeRelativeColorLuminance(FDrawSpanItemArgs.FillColor, 20);
  end else
  begin
    FDrawSpanItemArgs.FillColor := GetPlannerControl.TimeSpanParams.GetActualColor;
    FDrawSpanItemArgs.AltFillColor := GetPlannerControl.TimeSpanParams.GetActualAltColor;
  end;

  if SpanItem.PlanItem.FillColor <> clDefault
    then FDrawSpanItemArgs.FrameColor := SpanItem.PlanItem.GetFrameColor
    else FDrawSpanItemArgs.FrameColor := GetPlannerControl.TimeSpanParams.GetActualBorderColor;

  if (PlannerControl <> nil) and Assigned(PlannerControl.OnDrawSpanItem) then
    PlannerControl.OnDrawSpanItem(PlannerControl, Self, SpanItem, DrawRect, FDrawSpanItemArgs, DrawProcessed);

  if not DrawProcessed then
    DefaultDrawSpanItem(SpanItem, DrawRect, FDrawSpanItemArgs);
end;

procedure TCustomPlannerViewEh.DefaultDrawSpanItem(
  SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
var
  AContentRect: TRect;
begin
  DrawSpanItemBackgroud(SpanItem, ARect, DrawArgs);
  AContentRect := ARect;
  DrawSpanItemSurround(SpanItem, AContentRect, DrawArgs);
  DrawSpanItemContent(SpanItem, AContentRect, DrawArgs);
end;

procedure TCustomPlannerViewEh.DrawSpanItemBackgroud(
  SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
begin
  Canvas.Font := DrawArgs.Font;
  FillGradientEh(Canvas, ARect, DrawArgs.FillColor, DrawArgs.AltFillColor);
end;

procedure TCustomPlannerViewEh.DrawSpanItemSurround(
  SpanItem: TTimeSpanDisplayItemEh; var ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
var
  FrameRect: TRect;
  AFrameColor: TColor;
  CheckLenS: String;
  CheckLen: Integer;
  DrawFullOutInfo: Boolean;
  ImageRect: TRect;
  s: String;
begin

  AFrameColor := DrawArgs.FrameColor;

  if sidsSelectedEh in DrawArgs.DrawState then
  begin
    FrameRect := ARect;
    if Focused then
      Canvas.Brush.Color := ApproximateColor(
        CheckSysColor(clHighlight),
        CheckSysColor(Font.Color), 255 div 2)
    else
    begin
      if SpanItem.PlanItem.FillColor <> clDefault
        then Canvas.Brush.Color := SpanItem.PlanItem.GetFrameColor
        else Canvas.Brush.Color := AFrameColor;
    end;
    Canvas.FrameRect(FrameRect);
    InflateRect(FrameRect, -1, -1);
    Canvas.FrameRect(FrameRect);
  end else
  begin
    Canvas.Brush.Color := AFrameColor;
    Canvas.FrameRect(ARect);
  end;
  Canvas.Brush.Style := bsClear;

  CheckLenS := EhLibLanguageConsts.PlannerPeriodFromEh+': DD MMM ' + EhLibLanguageConsts.PlannerPeriodToEh+': DD MMM';
  CheckLen := Round(Canvas.TextWidth(CheckLenS) * 1.2);
  if (ARect.Right - ARect.Left) > CheckLen
    then DrawFullOutInfo := True
    else DrawFullOutInfo := False;

  if SpanItem.FDrawBackOutInfo then
  begin
    if SpanItem.TimeOrientation = toHorizontalEh then
    begin

      if UseRightToLeftAlignment then
      begin
        ImageRect := Rect(ARect.Right-16, ARect.Top, ARect.Right, ARect.Bottom);
        DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 1, 0, 0, taCenter, ImageRect);
      end
      else
      begin
        ImageRect := Rect(ARect.Left, ARect.Top, ARect.Left+16, ARect.Bottom);
        DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 0, 0, 0, taCenter, ImageRect);
      end;

      if DrawFullOutInfo
        then s := EhLibLanguageConsts.PlannerPeriodFromEh+': ' + FormatDateTime('DD MMM', SpanItem.PlanItem.StartTime)
        else s := '';

      if UseRightToLeftAlignment then
      begin
        ARect.Right := ARect.Right - 12;
        WriteTextEh(Canvas, ARect, False, 4, 3, s,
          taRightJustify, tlTop, True, True, 0, 0, False, True);
        ARect.Right := ARect.Right - Canvas.TextWidth(s) - 4;
        ARect.Right := ARect.Right - 12;
      end
      else
      begin
        ARect.Left := ARect.Left + 12;
        WriteTextEh(Canvas, ARect, False, 4, 3, s,
          taLeftJustify, tlTop, True, True, 0, 0, False, True);
        ARect.Left := ARect.Left + Canvas.TextWidth(s) + 4;
        ARect.Left := ARect.Left + 12;
      end;

    end else
    begin
      ImageRect := Rect(ARect.Left, ARect.Top, ARect.Left+16, ARect.Top+16);
      DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 2, 0, 0, taCenter, ImageRect);
      ARect.Top := ARect.Top + 12;
    end;
  end;

  if SpanItem.FDrawForwardOutInfo then
  begin
    if SpanItem.TimeOrientation = toHorizontalEh then
    begin
      if UseRightToLeftAlignment then
      begin
        ImageRect := Rect(ARect.Left, ARect.Top, ARect.Left+16, ARect.Bottom);
        DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 0, 0, 0, taCenter, ImageRect);
      end
      else
      begin
        ImageRect := Rect(ARect.Right-16, ARect.Top, ARect.Right, ARect.Bottom);
        DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 1, 0, 0, taCenter, ImageRect);
      end;

      if DrawFullOutInfo
        then s := EhLibLanguageConsts.PlannerPeriodToEh+': ' + FormatDateTime('DD MMM', SpanItem.PlanItem.EndTime)
        else s := '';

      if UseRightToLeftAlignment then
      begin
        ARect.Left := ARect.Left + 12;
        WriteTextEh(Canvas, ARect, False, 4, 3, s,
          taLeftJustify, tlTop, True, True, 0, 0, False, True);
        ARect.Left := ARect.Left + Canvas.TextWidth(s) + 4;
        ARect.Left := ARect.Left + 12;
      end
      else
      begin
        ARect.Right := ARect.Right - 12;
        WriteTextEh(Canvas, ARect, False, 4, 3, s,
          taRightJustify, tlTop, True, True, 0, 0, False, True);
        ARect.Right := ARect.Right - Canvas.TextWidth(s) - 4;
        ARect.Right := ARect.Right - 12;
      end;
    end else
    begin
      ImageRect := Rect(ARect.Left, ARect.Bottom-16, ARect.Left+16, ARect.Bottom);
      DrawClipped(PlannerDataMod.PlannerImList, nil, Canvas, ImageRect, 3, 0, 0, taCenter, ImageRect);
      ARect.Bottom := ARect.Bottom + 12;
    end;
  end;
end;

procedure TCustomPlannerViewEh.DrawSpanItemContent(
  SpanItem: TTimeSpanDisplayItemEh; const ARect: TRect;
  DrawArgs: TDrawSpanItemArgsEh);
var
  TextHeight: Integer;
  RectDataHeight: Integer;
  DY: Integer;
  AnAlignment: TAlignment;
begin
  TextHeight := GetFontTextHeight(Canvas, Canvas.Font);
  RectDataHeight := RectHeight(ARect) - 2;

  if (TextHeight - RectDataHeight < 6) then
  begin
    DY := (TextHeight - RectDataHeight) div 2;
    if DY < 1 then
      DY := 1;
  end else
  begin
    DY := 3;
  end;

  AnAlignment := DrawArgs.Alignment;
  if UseRightToLeftAlignment then
  begin
    if DrawArgs.Alignment = taLeftJustify then
      AnAlignment := taRightJustify
    else if DrawArgs.Alignment = taRightJustify then
      AnAlignment := taLeftJustify;
  end;

  WriteTextEh(Canvas, ARect, False, 4, DY, DrawArgs.Text,
    AnAlignment, tlTop, True, True, 0, 0, UseRightToLeftAlignment, True);
end;

procedure TCustomPlannerViewEh.SetPaintColors;
begin
  inherited SetPaintColors;
  FResourceCellFillColor := ApproximateColor(
    CheckSysColor(clBtnFace),
    CheckSysColor(clWindow), 128);
  FSelectedFocusedCellColor :=  ApproximateColor(
    CheckSysColor(clHighlight),
    CheckSysColor(clBtnFace), 200);
  FSelectedUnfocusedCellColor :=  ApproximateColor(
    CheckSysColor(clBtnShadow),
    CheckSysColor(clBtnFace), 200);
  FSpanFrameColor := ChangeColorLuminance(CheckSysColor(clSkyBlue), 85);
end;

procedure TCustomPlannerViewEh.Paint;
begin
  inherited Paint;
  PaintSpanItems;
end;

procedure TCustomPlannerViewEh.PaintSpanItems;
var
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  SpanDrawRect: TRect;
  RestRgn: HRgn;
  RestRect: TRect;
  GridClientRect: TRect;
begin
  GridClientRect := ClientRect;
  if SpanItemsCount > 0 then
  begin
    RestRect := Rect(HorzAxis.FixedBoundary, VertAxis.FixedBoundary, HorzAxis.ContraStart, VertAxis.ContraStart);
    if UseRightToLeftAlignment then
      RestRect := RightToLeftReflectRect(ClientRect, RestRect);
    RestRgn := SelectClipRectangleEh(Canvas, RestRect);
    try
    for i := 0 to SpanItemsCount-1 do
    begin
      SpanItem := SpanItems[i];
      SpanItem.GetInGridDrawRect(SpanDrawRect);
      if RectsIntersected(GridClientRect, SpanDrawRect) and
         (SpanDrawRect.Right > SpanDrawRect.Left) and
         (SpanDrawRect.Bottom > SpanDrawRect.Top)
      then
      begin
        if UseRightToLeftAlignment then
          SpanDrawRect := RightToLeftReflectRect(ClientRect, SpanDrawRect);
        DrawSpanItem(SpanItem, SpanDrawRect);
      end;
    end;
    finally
      RestoreClipRectangleEh(Canvas, RestRgn);
    end;
  end;
end;

function TCustomPlannerViewEh.NextDate: TDateTime;
begin
  Result := 0;
end;

procedure TCustomPlannerViewEh.NextPeriod;
begin
  CurrentTime := AppendPeriod(CurrentTime, 1);
end;

procedure TCustomPlannerViewEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

procedure TCustomPlannerViewEh.PriorPeriod;
begin
  CurrentTime := AppendPeriod(CurrentTime, -1);
end;

function TCustomPlannerViewEh.PriorDate: TDateTime;
begin
  Result := 0;
end;

function TCustomPlannerViewEh.AppendPeriod(ATime: TDateTime;
  Periods: Integer): TDateTime;
begin
  {$IFDEF FPC}
  Result := 0;
  {$ELSE}
  {$ENDIF}
  raise Exception.Create('AppendPeriod is not implemented');
end;

procedure TCustomPlannerViewEh.CalcRectForInCellCols(SpanItem: TTimeSpanDisplayItemEh;
  var DrawRect: TRect);
var
  RectWidth: Integer;
  SecWidth: Integer;
  OldDrawRect: TRect;
begin
  RectWidth := DrawRect.Right - DrawRect.Left;

  if SpanItem.InCellCols > 0 then
  begin
    SecWidth := RectWidth div SpanItem.InCellCols;
    OldDrawRect := DrawRect;
    DrawRect.Left := OldDrawRect.Left + SecWidth * SpanItem.InCellFromCol;
    DrawRect.Right := OldDrawRect.Left + SecWidth * (SpanItem.InCellToCol + 1) + 1;
  end;
end;

procedure TCustomPlannerViewEh.CalcRectForInCellRows(SpanItem: TTimeSpanDisplayItemEh;
  var DrawRect: TRect);
var
  RectHeight: Integer;
  SecHeight: Integer;
  OldDrawRect: TRect;
begin
  RectHeight := DrawRect.Bottom - DrawRect.Top;

  if SpanItem.InCellRows > 0 then
  begin
    SecHeight := RectHeight div SpanItem.InCellRows;
    OldDrawRect := DrawRect;
    DrawRect.Top := OldDrawRect.Top + SecHeight * SpanItem.InCellFromRow;
    DrawRect.Bottom := OldDrawRect.Top + SecHeight * (SpanItem.InCellToRow + 1) + 1;
  end;
end;

procedure TCustomPlannerViewEh.InitSpanItem(ASpanItem: TTimeSpanDisplayItemEh);
begin

end;

procedure TCustomPlannerViewEh.ReadPlanItem(APlanItem: TPlannerDataItemEh);
var
  SpanItem: TTimeSpanDisplayItemEh;
begin
  SpanItem := AddSpanItem(APlanItem);
  SpanItem.FHorzLocating := brrlGridRolAreaEh;
  SpanItem.FVertLocating := brrlGridRolAreaEh;
  SpanItem.FAllowedInteractiveChanges := [];
  InitSpanItem(SpanItem);
end;

procedure TCustomPlannerViewEh.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

procedure TCustomPlannerViewEh.ClearSpanItems;
var
  i: Integer;
begin
  for i := 0 to FSpanItems.Count-1 do
    FreeObjectEh(FSpanItems[i]);
  FSpanItems.Clear;
end;

procedure TCustomPlannerViewEh.SetGroupPosesSpanItems(Resource: TPlannerResourceEh);
begin

end;

procedure TCustomPlannerViewEh.SetOptions(const Value: TPlannerGridOptionsEh);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
  end;
end;

function TCustomPlannerViewEh.CreateDataBarsArea: TDataBarsAreaEh;
begin
  Result := TDataBarsVertAreaEh.Create(Self);
end;

function TCustomPlannerViewEh.CreateDayNameArea: TDayNameAreaEh;
begin
  {$IFDEF FPC}
  Result := nil;
  {$ELSE}
  {$ENDIF}
  raise Exception.Create('TCustomPlannerViewEh.CreateDayNameArea must be defined');
end;

procedure TCustomPlannerViewEh.SetDayNameArea(const Value: TDayNameAreaEh);
begin
  FDayNameArea.Assign(Value);
end;

procedure TCustomPlannerViewEh.SetDisplayPosesSpanItems;
begin

end;

procedure TCustomPlannerViewEh.ResetDayNameFormat(LongDayFacor, ShortDayFacor: Double);
var
  ColWidth: Integer;
  i: Integer;
  Dname: String;
  AWidth, AMaxWidth: Integer;
begin
  if not HandleAllocated then Exit;
  ColWidth := ColWidths[FDataColsOffset];
  FDayNameFormat := dnfNonEh;
  Canvas.Font := Font;
  AMaxWidth := 0;
  for i := 1 to 7 do
  begin
    DName := FormatSettings.LongDayNames[i];
    AWidth := Canvas.TextWidth(DName);
    if AWidth > AMaxWidth then
      AMaxWidth := AWidth;
  end;
  if AMaxWidth * LongDayFacor < ColWidth then
    FDayNameFormat := dnfLongFormatEh;

  if FDayNameFormat <> dnfLongFormatEh then
  begin
    AMaxWidth := 0;
    for i := 1 to 7 do
    begin
      DName := FormatSettings.ShortDayNames[i];
      AWidth := Canvas.TextWidth(DName);
      if AWidth > AMaxWidth then
        AMaxWidth := AWidth;
    end;
    if AMaxWidth * ShortDayFacor < ColWidth then
      FDayNameFormat := dnfShortFormatEh;
  end;
end;

function TCustomPlannerViewEh.CheckPlanItemForRead(APlanItem: TPlannerDataItemEh): Boolean;
var
  AStartDate, AEndDate: TDateTime;
begin
  GetViewPeriod(AStartDate, AEndDate);

  if ((APlanItem.EndTime > AStartDate) and (APlanItem.StartTime < AEndDate)) or
     ((APlanItem.StartTime > AStartDate) and (APlanItem.StartTime < AEndDate)) or
     ((APlanItem.EndTime > AStartDate) and (APlanItem.EndTime < AEndDate))
  then
    Result := True
  else
    Result := False;
end;

procedure TCustomPlannerViewEh.ResetLoadedTimeRange;
begin
  if (csLoading in ComponentState) or not ActiveMode then Exit;
  MakeSpanItems;
  ProcessedSpanItems;
end;

procedure TCustomPlannerViewEh.ResetResviewArray;
var
  i: Integer;
begin
  if (PlannerDataSource <> nil) then
  begin
    if FShowUnassignedResource
      then SetLength(FResourcesView, PlannerDataSource.Resources.Count+1)
      else SetLength(FResourcesView, PlannerDataSource.Resources.Count);
  end else
  begin
    if FShowUnassignedResource
      then SetLength(FResourcesView, 1)
      else SetLength(FResourcesView, 0);
  end;

  for i := 0 to Length(FResourcesView)-1 do
  begin
    if (PlannerDataSource <> nil) and (i < PlannerDataSource.Resources.Count)
      then FResourcesView[i].Resource := PlannerDataSource.Resources[i]
      else FResourcesView[i].Resource := nil;
  end;
end;

procedure TCustomPlannerViewEh.ResetSelectedRange;
var
  SelTime: TDateTime;
begin
  SelTime := CellToDateTime(Col, Row);
  SelectedRange.FFromDateTime := NormalizeDateTime(SelTime);
  SelectedRange.FToDateTime := NormalizeDateTime(SelTime);
  SelectedRange.FResource := nil;
  InvalidateGrid;
end;

function TCustomPlannerViewEh.GetDataCellTimeLength: TDateTime;
begin
  Result := 0;
end;

procedure TCustomPlannerViewEh.CellsRangeToTimeRange(Cell1, Cell2: TGridCoord;
  out TimeFrom, TimeTo: TDateTime; out Resource1, Resource2: TPlannerResourceEh);
var
  Time1, Time2, TimeTmp: TDateTime;
begin
  Time1 := CellToDateTime(Cell1.X, Cell1.Y);
  Time2 := CellToDateTime(Cell2.X, Cell2.Y);
  Resource1 := GetResourceAtCell(Cell1.X, Cell1.Y);
  Resource2 := GetResourceAtCell(Cell2.X, Cell2.Y);
  if Time1 > Time2 then
  begin
    TimeTmp := Time1;
    Time1 := Time2;
    Time2 := TimeTmp;
  end;
  Time2 := Time2 + GetDataCellTimeLength;
  TimeFrom := Time1;
  TimeTo := Time2;
end;

procedure TCustomPlannerViewEh.SetSelectionRange(Cell1, Cell2: TGridCoord);
var
  TimeFrom, TimeTo: TDateTime;
  Resource1, Resource2: TPlannerResourceEh;
begin
  CellsRangeToTimeRange(Cell1, Cell2, TimeFrom, TimeTo, Resource1, Resource2);
  if (Resource1 = Resource2) and
     ((SelectedRange.FromDateTime <> TimeFrom) or (SelectedRange.ToDateTime <> TimeTo)) then
  begin
    SelectedRange.FFromDateTime := NormalizeDateTime(TimeFrom);
    SelectedRange.FToDateTime := NormalizeDateTime(TimeTo);
    SelectedRange.FResource := Resource1;
    InvalidateGrid;
  end;
end;

procedure TCustomPlannerViewEh.MakeSpanItems;
var
  AStartDate, AEndDate: TDateTime;
  i: Integer;
  PlanItem: TPlannerDataItemEh;
  ReadDataItem: Boolean;
begin
  GetViewPeriod(AStartDate, AEndDate);

  ClearSpanItems;
  FShowUnassignedResource := False;

  if Assigned(PlannerDataSource) then
  begin
    EnsureDataForPeriod(AStartDate, AEndDate);
    for i := 0 to PlannerDataSource.Count - 1 do
    begin
      PlanItem := PlannerDataSource[i];

      if CheckPlanItemForRead(PlanItem) then
      begin
        if PlanItem <> FDummyPlanItemFor then
        begin
          ReadDataItem := True;
          if Assigned(OnReadPlannerDataItem) then
            OnReadPlannerDataItem(PlannerControl, Self, PlanItem, ReadDataItem);
          if ReadDataItem then
            ReadPlanItem(PlanItem);
        end;
      end;

      if PlanItem.Resource = nil then
        FShowUnassignedResource := True;
    end;
    if FDummyPlanItemFor <> nil then
      ReadPlanItem(FDummyPlanItem);
  end;

  if (ResourceCaptionArea.Visible = True) and (IsResourceCaptionNeedVisible = False) then
    FShowUnassignedResource := True;
end;

procedure TCustomPlannerViewEh.ProcessedSpanItems;
var
  i: Integer;
begin
  SortPlanItems;

  if (PlannerDataSource <> nil) and (PlannerDataSource.Resources.Count > 0) then
    for i := 0 to Length(FResourcesView)-1 do
      SetGroupPosesSpanItems(FResourcesView[i].Resource)
  else
    SetGroupPosesSpanItems(nil);

  SetDisplayPosesSpanItems;
  ResetGridControlsState;
  Invalidate;
end;

function CompareSpanItemFuncByPlan(Item1, Item2: Pointer): Integer;
var
  SpanItem1, SpanItem2: TTimeSpanDisplayItemEh;
begin
  SpanItem1 := TTimeSpanDisplayItemEh(Item1);
  SpanItem2 := TTimeSpanDisplayItemEh(Item2);
  if SpanItem1.PlanItem.StartTime < SpanItem2.PlanItem.StartTime then
    Result := -1
  else if SpanItem1.PlanItem.StartTime > SpanItem2.PlanItem.StartTime then
    Result := 1
  else if SpanItem1.PlanItem.EndTime < SpanItem2.PlanItem.EndTime then
    Result := -1
  else if SpanItem1.PlanItem.EndTime > SpanItem2.PlanItem.EndTime then
    Result := 1
  else
    Result := 0;
end;

function CompareSpanItemFuncBySpan(Item1, Item2: Pointer): Integer;
var
  SpanItem1, SpanItem2: TTimeSpanDisplayItemEh;
begin
  SpanItem1 := TTimeSpanDisplayItemEh(Item1);
  SpanItem2 := TTimeSpanDisplayItemEh(Item2);
  if DateOf(SpanItem1.StartTime) < DateOf(SpanItem2.StartTime) then
    Result := -1
  else if DateOf(SpanItem1.StartTime) > DateOf(SpanItem2.StartTime) then
    Result := 1
  else if DateOf(SpanItem1.EndTime) > DateOf(SpanItem2.EndTime) then
    Result := -1
  else if DateOf(SpanItem1.EndTime) < DateOf(SpanItem2.EndTime) then
    Result := 1
  else if SpanItem1.PlanItem.StartTime < SpanItem2.PlanItem.StartTime then
    Result := -1
  else if SpanItem1.PlanItem.StartTime > SpanItem2.PlanItem.StartTime then
    Result := 1
  else if SpanItem1.PlanItem.EndTime < SpanItem2.PlanItem.EndTime then
    Result := -1
  else if SpanItem1.PlanItem.EndTime > SpanItem2.PlanItem.EndTime then
    Result := 1
  else
    Result := 0;
end;

procedure TCustomPlannerViewEh.SortPlanItems;
begin
end;

function TCustomPlannerViewEh.SpanItemByPlanItem(
  APlanItem: TPlannerDataItemEh): TTimeSpanDisplayItemEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to SpanItemsCount-1 do
  begin
    if SpanItems[i].PlanItem = APlanItem then
    begin
      Result := SpanItems[i];
      Exit;
    end;
  end;
end;

procedure TCustomPlannerViewEh.GroupSpanItems;
var
  i: Integer;
begin
  SortPlanItems;

  if ResourcesCount > 0 then
    for i := 0 to Length(FResourcesView)-1 do
      SetGroupPosesSpanItems(FResourcesView[i].Resource)
  else
    SetGroupPosesSpanItems(nil);
end;

procedure TCustomPlannerViewEh.ResetAllData;
begin
  MakeSpanItems;
  ResetResviewArray;
  GroupSpanItems;

  GridLayoutChanged;

  SetDisplayPosesSpanItems;
  UpdateSelectedPlanItem;
  ResetGridControlsState;
  Invalidate;
end;

procedure TCustomPlannerViewEh.RecreateDummyData;
begin
  FreeAndNil(FDummyPlanItem);
  FreeAndNil(FDummyCheckPlanItem);
  if PlannerDataSource <> nil then
  begin
    FDummyPlanItem := PlannerDataSource.CreateTmpPlannerItem;
    FDummyCheckPlanItem := PlannerDataSource.CreateTmpPlannerItem;
  end;
end;

procedure TCustomPlannerViewEh.PlannerDataSourceChanged;
begin
  ClearSpanItems;
  if csDestroying in ComponentState then Exit;
  if csLoading in ComponentState then Exit;
  if  FIgnorePlannerDataSourceChanged then Exit;
  ResetAllData;
end;

function TCustomPlannerViewEh.TopGridLineCount: Integer;
begin
  Result := FTopGridLineIndex + 1;
end;

procedure TCustomPlannerViewEh.UpdateDefaultTimeSpanBoxHeight;
begin
  FDefaultTimeSpanBoxHeight := 0;
  if not HandleAllocated then Exit;
  Canvas.Font := Font;
  FDefaultTimeSpanBoxHeight := Canvas.TextHeight('Wg') + 3 + 3;
end;

procedure TCustomPlannerViewEh.DefaultFillSpanItemHintShowParams(CursorPos: TPoint;
  SpanRect: TRect; InSpanCursorPos: TPoint; SpanItem: TTimeSpanDisplayItemEh;
  Params: TPlannerViewSpanHintParamsEh);
begin
  Params.HintStr :=
    FormatDateTime('H:MM', SpanItem.PlanItem.StartTime) + ' - ' +
    FormatDateTime('H:MM', SpanItem.PlanItem.EndTime) + ' ' +
    SpanItem.PlanItem.Title;

  if SpanItem.PlanItem.Body <> '' then
    Params.HintStr := Params.HintStr + sLineBreak + SpanItem.PlanItem.Body;
end;


procedure TCustomPlannerViewEh.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  FInvalidateTime.Enabled := Visible;
end;

procedure TCustomPlannerViewEh.CMFontChanged(var Message: TMessage);
begin
  inherited;
  GridLayoutChanged;
end;

procedure TCustomPlannerViewEh.CMHintShow(var Message: TCMHintShow);
var
  HitSpanItem: TTimeSpanDisplayItemEh;
  ARect: TRect;
  Processed: Boolean;
  Params: TPlannerViewSpanHintParamsEh;

  procedure AssignPlannerViewHintParams(var hp:  THintInfo;
    pvhp: TPlannerViewSpanHintParamsEh);
  begin
    pvhp.HintPos := ScreenToClient(hp.HintPos);
    pvhp.HintMaxWidth := hp.HintMaxWidth;
    pvhp.HintColor := hp.HintColor;
    pvhp.ReshowTimeout := hp.ReshowTimeout;
    pvhp.HideTimeout := hp.HideTimeout;
    pvhp.HintStr := '';
    pvhp.CursorRect := ARect;
    if FHintFont = nil then
      FHintFont := TFont.Create;
    pvhp.HintFont := FHintFont;
    pvhp.HintFont.Assign(Screen.HintFont);
  end;

  procedure AssignHintParams(pvhp: TPlannerViewSpanHintParamsEh;
    var hp:  THintInfo);
  begin
    hp.CursorRect := pvhp.CursorRect;
    hp.HintPos := ClientToScreen(pvhp.HintPos);
    hp.HintMaxWidth := pvhp.HintMaxWidth;
    hp.HintColor := pvhp.HintColor;
    hp.ReshowTimeout := pvhp.ReshowTimeout;
    hp.HideTimeout := pvhp.HideTimeout;
    hp.HintStr := pvhp.HintStr;
    hp.HintWindowClass := THintWindowEh;
    hp.HintData := pvhp.HintFont;
  end;

begin
  inherited;
  ARect := Rect(0,0,0,0);
  if (FPlannerState <> psNormalEh) then Exit;

  HitSpanItem := CheckHitSpanItem(mbLeft, [], HitTest.X, HitTest.Y);
  if HitSpanItem <> nil then
  begin
    Params := TPlannerViewSpanHintParamsEh.Create;
    try
      AssignPlannerViewHintParams(PHintInfo(Message.HintInfo)^, Params);

      if (PlannerControl <> nil) and Assigned(PlannerControl.OnSpanItemHintShow) then
        PlannerControl.OnSpanItemHintShow(PlannerControl, Self, HitTest, ARect, HitTest, HitSpanItem, Params, Processed);

      if Assigned(OnSpanItemHintShow) then
        OnSpanItemHintShow(PlannerControl, Self, HitTest, ARect, HitTest, HitSpanItem, Params, Processed);

      if not Processed then
        DefaultFillSpanItemHintShowParams(HitTest, ARect, HitTest, HitSpanItem, Params);

      AssignHintParams(Params, PHintInfo(Message.HintInfo)^);
    finally
      FreeAndNil(Params);
    end;
  end;
end;

{$IFDEF FPC}
{$ELSE}
procedure TCustomPlannerViewEh.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  if Showing then
    UpdateLocaleInfo;
  Invalidate;
end;
{$ENDIF}

procedure TCustomPlannerViewEh.CoveragePeriod(var AFromTime,
  AToTime: TDateTime);
begin
  AFromTime := StartDate;
  case CoveragePeriodType of
    pcpDayEh: AToTime := StartDate + 1;
    pcpWeekEh: AToTime := IncWeek(StartDate);
    pcpMonthEh: AToTime := IncWeek(StartDate, 6);
    pcpYearEh: AToTime := IncMonth(StartDate, 12);
  end;
end;


procedure TCustomPlannerViewEh.WMSetCursor(var Msg: TWMSetCursor);
{$IFDEF FPC_CROSSP }
begin
  inherited;
end;
{$ELSE}
var
  SpanItem: TTimeSpanDisplayItemEh;
  Side: TRectangleSideEh;
  Cur: HCURSOR;
begin
  Cur := 0;
  if CheckSpanItemSizing(HitTest, SpanItem, Side) then
  begin
    if Side in [rsLeftEh, rsRightEh] then
      Cur := Screen.Cursors[crSizeWE]
    else
      Cur := Screen.Cursors[crSizeNS];
  end;
  if Cur <> 0 then
  begin
     Windows.SetCursor(Cur);
{$IFDEF FPC}
     Msg.Result := 1;
{$ENDIF}
  end else
    inherited;
end;
{$ENDIF} 

function TCustomPlannerViewEh.GetPlannerControl: TPlannerControlEh;
begin
  Result := TPlannerControlEh(Parent);
end;

function TCustomPlannerViewEh.GetResourceAtCell(ACol,
  ARow: Integer): TPlannerResourceEh;
begin
  Result := nil;
end;

function TCustomPlannerViewEh.GetResourceCaptionAreaDefaultSize: Integer;
var
  h: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := ResourceCaptionArea.Font;
    h := Canvas.TextHeight('Wg') + 4;
    if h > DefaultRowHeight
      then Result := h
      else  Result := DefaultRowHeight;
  end else
    Result := DefaultRowHeight;
end;

function TCustomPlannerViewEh.GetResourceViewAtCell(ACol, ARow: Integer): Integer;
begin
  Result := -1;
end;

function TCustomPlannerViewEh.GetResourceNonworkingTimeBackColor(
  Resource: TPlannerResourceEh; BackColor, FontColor: TColor): TColor;
var
  NonworkingBaseColor: TColor;
begin
  if PlannerDrawStyleEh.NonworkingTimeBackColor = clDefault then
  begin
    if Resource = nil then
      NonworkingBaseColor := CheckSysColor(ResourceCaptionArea.GetActualColor)
    else if Resource.Color = clDefault then
      NonworkingBaseColor := FResourceCellFillColor
    else
      NonworkingBaseColor := Resource.FaceColor;
  end else
    NonworkingBaseColor := PlannerDrawStyleEh.NonworkingTimeBackColor;

  Result := PlannerDrawStyleEh.AdjustNonworkingTimeBackColor(
    PlannerControl, NonworkingBaseColor, BackColor, FontColor);
end;

procedure TCustomPlannerViewEh.UpdateDummySpanItemSize(MousePos: TPoint);
begin
end;

procedure TCustomPlannerViewEh.ShowMoveHintWindow(APlanItem: TPlannerDataItemEh; MousePos: TPoint);
var
  ARect: TRect;
  APos: TPoint;
  S: String;
begin
  if APlanItem.InsideDayRange then
    S := FormatDateTime('H:NN', APlanItem.StartTime) + ' - ' +
         FormatDateTime('H:NN', APlanItem.EndTime)
  else
    S := FormatDateTime('DD.MMM H:NN', APlanItem.StartTime) + ' - ' +
         FormatDateTime('DD.MMM H:NN', APlanItem.EndTime);

  APos := ClientToScreen(MousePos);
  APos.X := APos.X + GetSystemMetrics(SM_CXCURSOR);
  APos.Y := APos.Y + GetSystemMetrics(SM_CYCURSOR);

  ARect := FMoveHintWindow.CalcHintRect(Screen.Width, S, nil);
  OffsetRect(ARect, APos.X, APos.Y);

  FMoveHintWindow.ActivateHint(ARect, S);
end;

function TCustomPlannerViewEh.ShowTopGridLine: Boolean;
begin
  Result := True;
end;

procedure TCustomPlannerViewEh.HideMoveHintWindow;
begin
  if FMoveHintWindow.HandleAllocated and IsWindowVisible(FMoveHintWindow.Handle) then
  begin
    ShowWindow(FMoveHintWindow.Handle, SW_HIDE);
    FMoveHintWindow.Visible := False;
  end;
end;

function TCustomPlannerViewEh.GetPeriodCaption: String;
begin
  Result := '';
end;

function TCustomPlannerViewEh.InteractiveChangeAllowed: Boolean;
begin
  Result := True;
end;

procedure TCustomPlannerViewEh.SetParent(AParent: TWinControl);
begin
  if (AParent <> nil) and not (AParent is TPlannerControlEh) then
    raise Exception.Create('TCustomPlannerGridEh.SetParent: Parent must be of TPlannerControlEh type  ');

  if (Parent <> nil) {and not (csDestroying in Parent.ComponentState)} then
  begin
    ClearSpanItems;
    TPlannerControlEh(Parent).FPlannerGrids.Remove(Self);
  end;
  inherited SetParent(AParent);
  if AParent <> nil then
    TPlannerControlEh(AParent).FPlannerGrids.Add(Self);
  if not (csLoading in ComponentState) then
    RecreateDummyData;
end;

procedure TCustomPlannerViewEh.SetPlannerState(ANewState: TPlannerStateEh);
var
  OldPlannerState: TPlannerStateEh;
begin
  if FPlannerState <> ANewState then
  begin
    OldPlannerState := FPlannerState;
    FPlannerState := ANewState;
    PlannerStateChanged(OldPlannerState);
  end;
end;

procedure TCustomPlannerViewEh.PlannerStateChanged(AOldState: TPlannerStateEh);
begin
  HideMoveHintWindow;
end;

function TCustomPlannerViewEh.GetSpanItems(
  Index: Integer): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh(FSpanItems[Index]);
end;

function TCustomPlannerViewEh.GetSpanItemsCount: Integer;
begin
  Result := FSpanItems.Count;
end;

function TCustomPlannerViewEh.AddSpanItem(APlanItem: TPlannerDataItemEh): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh.Create(Self, APlanItem);
  FSpanItems.Add(Result);
end;

procedure TCustomPlannerViewEh.StartSpanMoveSliding(ASpeed: Integer;
  ASlideDirection: TGridScrollDirection);
begin
  FSpanMoveSlidingSpeed := ASpeed;
  FSlideDirection := ASlideDirection;
  if not FSpanMoveSlidingTimer.Enabled then
  begin
    FSpanMoveSlidingTimer.Enabled := True;
    SlidingTimerEvent(nil);
  end;
end;

procedure TCustomPlannerViewEh.SlidingTimerEvent(Sender: TObject);
begin
  if FSlideDirection = sdUp then
    SafeScrollData(0, -FSpanMoveSlidingSpeed)
  else if FSlideDirection = sdDown then
    SafeScrollData(0, FSpanMoveSlidingSpeed)
  else if FSlideDirection = sdLeft then
    SafeScrollData(-FSpanMoveSlidingSpeed, 0)
  else if FSlideDirection = sdRight then
    SafeScrollData(FSpanMoveSlidingSpeed, 0);
  UpdateDummySpanItemSize(ScreenToClient(Mouse.CursorPos));
end;

procedure TCustomPlannerViewEh.StopSpanMoveSliding;
begin
  FSpanMoveSlidingTimer.Enabled := False;
end;

function TCustomPlannerViewEh.CanSpanMoveSliding(MousePos: TPoint;
  var ASpeed: Integer; var ASlideDirection: TGridScrollDirection): Boolean;
var
  SlidingExtent: Integer;
  VertRolExtend, HorzRolExtend: Integer;
begin
  Result := False;
  if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    SlidingExtent := DefaultRowHeight * 2;
    VertRolExtend := VertAxis.FixedBoundary + VertAxis.RolLen - VertAxis.RolStartVisPos;
    HorzRolExtend := HorzAxis.FixedBoundary + HorzAxis.RolLen - HorzAxis.RolStartVisPos;
    if (MousePos.Y > VertAxis.FixedBoundary) and
       (MousePos.Y < VertAxis.FixedBoundary + SlidingExtent) and
       (VertAxis.RolStartVisPos > 0) then
    begin
      ASpeed := ((VertAxis.FixedBoundary + SlidingExtent) - MousePos.Y) div 2;
      ASlideDirection := sdUp;
      Result := True;
    end
    else if (MousePos.Y > VertAxis.ContraStart - SlidingExtent) and
            (MousePos.Y < VertAxis.ContraStart) and
            (VertRolExtend > VertAxis.ContraStart) then
    begin
      ASpeed := (MousePos.Y - (VertAxis.ContraStart - SlidingExtent)) div 2;
      ASlideDirection := sdDown;
      Result := True;
    end else if (MousePos.X > HorzAxis.FixedBoundary) and
                (MousePos.X < HorzAxis.FixedBoundary + SlidingExtent) and
                (HorzAxis.RolStartVisPos > 0) then
    begin
      ASpeed := ((HorzAxis.FixedBoundary + SlidingExtent) - MousePos.X) div 2;
      ASlideDirection := sdLeft;
      Result := True;
    end
    else if (MousePos.X > HorzAxis.ContraStart - SlidingExtent) and
            (MousePos.X < HorzAxis.ContraStart) and
            (HorzRolExtend > HorzAxis.ContraStart) then
    begin
      ASpeed := (MousePos.X - (HorzAxis.ContraStart - SlidingExtent)) div 2;
      ASlideDirection := sdRight;
      Result := True;
    end;
  end;
end;

function TCustomPlannerViewEh.GetGridIndex: Integer;
begin
  if PlannerControl <> nil
    then Result := PlannerControl.FPlannerGrids.IndexOf(Self)
    else Result := -1;
end;

procedure TCustomPlannerViewEh.SetGridIndex(const Value: Integer);
var
  I, MaxGridIndex: Integer;
begin
  if PlannerControl <> nil then
  begin
    MaxGridIndex := PlannerControl.PlannerViewCount - 1;
    if Value > MaxGridIndex then
      raise EListError.Create('SGridIndexError');
    I := PlannerControl.FPlannerGrids.IndexOf(Self);
    PlannerControl.FPlannerGrids.Move(I, Value);
  end;
end;

function TCustomPlannerViewEh.CreateHoursBarArea: THoursBarAreaEh;
begin
  {$IFDEF FPC}
  Result := nil;
  {$ELSE}
  {$ENDIF}
  raise Exception.Create('TCustomPlannerViewEh.CreateHoursBarArea must be defined');
end;

function TCustomPlannerViewEh.CreateResourceCaptionArea: TResourceCaptionAreaEh;
begin
  Result := nil;
end;

procedure TCustomPlannerViewEh.CreateWnd;
begin
  inherited CreateWnd;
  ResetLoadedTimeRange;
  GridLayoutChanged;
end;

procedure TCustomPlannerViewEh.CurrentCellMoved(OldCurrent: TGridCoord);
begin
  inherited CurrentCellMoved(OldCurrent);
  ResetSelectedRange;
  SelectionChanged;
end;

procedure TCustomPlannerViewEh.SetHoursBarArea(const Value: THoursBarAreaEh);
begin
  FHoursBarArea.Assign(Value);
end;

procedure TCustomPlannerViewEh.SetDataBarsArea(const Value: TDataBarsAreaEh);
begin
  FDataBarsArea.Assign(Value);
end;

procedure TCustomPlannerViewEh.CheckSetDummyPlanItem(Item,
  NewItem: TPlannerDataItemEh);
var
  ErrorText: String;
begin
  ErrorText := '';
  if PlannerControl.CheckPlannerItemInteractiveChanging(Self, Item, NewItem, ErrorText) then
    FDummyPlanItem.Assign(NewItem);
end;

procedure TCustomPlannerViewEh.NotifyPlanItemChanged(Item,
  OldItem: TPlannerDataItemEh);
begin
  PlannerControl.PlannerItemInteractiveChanged(Self, Item, OldItem);
end;

procedure TCustomPlannerViewEh.UpdateSelectedPlanItem;
var
  i: Integer;
  SelFound: Boolean;
begin
  SelFound := False;
  for i := 0 to SpanItemsCount-1 do
  begin
    if SpanItems[i].PlanItem = SelectedPlanItem then
    begin
      SelFound := True;
      Break;
    end;
  end;
  if SelFound = False then
    SelectedPlanItem := nil;
end;

function TCustomPlannerViewEh.GetPlannerDataSource: TPlannerDataSourceEh;
begin
  if PlannerControl <> nil
    then Result := PlannerControl.PlannerDataSource
    else Result := nil;
end;

function TCustomPlannerViewEh.IsDrawCurrentTimeLineForCell(
  CellType: TPlannerViewCellTypeEh): Boolean;
begin
  if CellType in [pctDateCellEh, pctTimeCellEh]
    then Result := True
    else Result := False;
end;

procedure TCustomPlannerViewEh.GetCurrentTimeLineRect(var CurTLRect: TRect);
begin
  CurTLRect := EmptyRect;
end;

procedure TCustomPlannerViewEh.TimerEvent(Sender: TObject);
begin
  if Visible then
    Invalidate;
end;

procedure TCustomPlannerViewEh.Loaded;
begin
  inherited Loaded;
end;

procedure TCustomPlannerViewEh.UpdateLocaleInfo;
var
  DOWFlag: Integer;
begin
  GetHoursTimeFormat(FHoursFormat, FAmPmPos);

  DOWFlag := FirstDayOfWeekEh();
  if FFirstWeekDayNum <> DOWFlag then
  begin
    FFirstWeekDayNum := DOWFlag;

    FFirstWeekDayNum := FFirstWeekDayNum + 2;
    if FFirstWeekDayNum >= 7 then FFirstWeekDayNum := FFirstWeekDayNum - 7;

    SetStartDate(StartDate);
  end;
  GridLayoutChanged;
  Invalidate;
end;

function TCustomPlannerViewEh.AmPm12: Boolean;
begin
  Result := (FHoursFormat = htfAmPm12hEh);
end;

function TCustomPlannerViewEh.PlannerStartOfTheWeek(const AValue: TDateTime): TDateTime;
var
  AWeekDayUS: Integer;
begin
  if (FFirstWeekDayNum = 1) and (DayOfWeek(AValue) = 1) then 
    Result := DateOf(AValue)
  else
  begin
    Result := DateOf(AValue);
    AWeekDayUS := DayOfWeek(AValue - (FFirstWeekDayNum - 1));
    Result := Result - (AWeekDayUS - 1);
  end;
end;


{ TTimeSpanDisplayItemEh }

procedure TTimeSpanDisplayItemEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TTimeSpanDisplayItemEh then
  begin
    FPlanItem := TTimeSpanDisplayItemEh(Source).PlanItem;
    FStartGridRollPos := TTimeSpanDisplayItemEh(Source).StartGridRollPos;
    FStopGridRolPos := TTimeSpanDisplayItemEh(Source).StopGridRolPosl;

    FInCellCols := TTimeSpanDisplayItemEh(Source).InCellCols;
    FInCellFromCol := TTimeSpanDisplayItemEh(Source).InCellFromCol;
    FInCellToCol := TTimeSpanDisplayItemEh(Source).InCellToCol;
    FGridColNum := TTimeSpanDisplayItemEh(Source).GridColNum;

  end;
end;

constructor TTimeSpanDisplayItemEh.Create(AGrid: TCustomPlannerViewEh;
  APlanItem: TPlannerDataItemEh);
begin
  inherited Create(AGrid);
  FPlanItem := APlanItem;
  FAlignment := taLeftJustify;
end;

procedure TTimeSpanDisplayItemEh.DblClick;
begin
  if (PlannerView.PlannerControl.TimeSpanParams.DblClickOpenEventEditor) then
    PlannerView.PlannerControl.ShowModifyPlanItemDialog(PlanItem);
end;

destructor TTimeSpanDisplayItemEh.Destroy;
begin
  inherited Destroy;
end;

{ TDummyTimeSpanDisplayItemEh }

procedure TDummyTimeSpanDisplayItemEh.Assign(Source: TPersistent);
begin
  if Source is TTimeSpanDisplayItemEh then
  begin
    FPlanItem := TTimeSpanDisplayItemEh(Source).PlanItem;
    FStartTime := TTimeSpanDisplayItemEh(Source).PlanItem.StartTime;
    FEndTime := TTimeSpanDisplayItemEh(Source).PlanItem.EndTime;

    FStartGridRollPos := TTimeSpanDisplayItemEh(Source).StartGridRollPos;
    FStopGridRolPos := TTimeSpanDisplayItemEh(Source).StopGridRolPosl;

    FInCellCols := TTimeSpanDisplayItemEh(Source).InCellCols;
    FInCellFromCol := TTimeSpanDisplayItemEh(Source).InCellFromCol;
    FInCellToCol := TTimeSpanDisplayItemEh(Source).InCellToCol;
    FGridColNum := TTimeSpanDisplayItemEh(Source).GridColNum;

    FBoundRect := TTimeSpanDisplayItemEh(Source).BoundRect;
    FHorzLocating := TTimeSpanDisplayItemEh(Source).HorzLocating;
    FVertLocating := TTimeSpanDisplayItemEh(Source).VertLocating;
  end;
end;

procedure TDummyTimeSpanDisplayItemEh.SetEndTime(const Value: TDateTime);
begin
  FEndTime := Value;
end;

procedure TDummyTimeSpanDisplayItemEh.SetStartTime(const Value: TDateTime);
begin
  FStartTime := Value;
end;

{ TPlannerControlEh }

constructor TPlannerControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := [csCaptureMouse, csClickEvents, csSetCaption, csOpaque,
    csDoubleClicks, csReplicatable {$IFDEF EH_LIB_17}, csPannable, csGestures {$ENDIF}];

  {$IFDEF FPC}
  {$ELSE}
  BevelKind := bkFlat;
  BevelOuter := bvNone;
  {$ENDIF}
  FOptions := [pvoUseGlobalWorkingTimeCalendarEh, pvoPlannerToolBoxEh, pvoHighlightTodayEh];
  FAllowedOperations := [paoAppendPlanItemEh, paoChangePlanItemEh, paoDeletePlanItemEh];
  FNotificationConsumers := TInterfaceList.Create;

  FTopPanel := TPlannerToolBoxEh.Create(Self);
  FTopPanel.Parent := Self;
  FTopPanel.Align := alTop;
  FTopPanel.BevelOuter := bvNone;
  {$IFDEF FPC}
  {$ELSE}
  FTopPanel.BevelKind := bkFlat;
  FTopPanel.BevelEdges := []; 
  {$ENDIF}

  FPlannerGrids := TObjectListEh.Create;
  FTimeSpanParams := TPlannerControlTimeSpanParamsEh.Create(Self);
  FEventNavBoxParams := TEventNavBoxParamsEh.Create(Self);

  CurrentTime := Today;
  ViewModeChanged;

  {$IFDEF FPC}
  {$ELSE}
  FPrintService := TPlannerControlPrintServiceEh.Create(Self);
  FPrintService.Planner := Self;
  FPrintService.Name := 'PrintService';
  FPrintService.SetSubComponent(True);
  {$ENDIF}
  FWorkingTimeStart := TTime(EncodeTime(8, 0, 0, 0));
  FWorkingTimeEnd := TTime(EncodeTime(17, 0, 0, 0));
end;

destructor TPlannerControlEh.Destroy;
begin
  Destroying;
  PlannerDataSource := nil;

  while FPlannerGrids.Count > 0 do
  begin
    FPlannerGrids[FPlannerGrids.Count-1].Free;
  end;
  FreeAndNil(FPlannerGrids);

  FreeAndNil(FNotificationConsumers);
  FreeAndNil(FTopPanel);
  FreeAndNil(FTimeSpanParams);
  FreeAndNil(FEventNavBoxParams);
  {$IFDEF FPC}
  {$ELSE}
  
  {$ENDIF}

  inherited Destroy;
end;

procedure TPlannerControlEh.DoTimeSpanContextPopup(MousePos: TPoint;
  PlannerView: TCustomPlannerViewEh; SpanItem: TTimeSpanDisplayItemEh);
var
  ScreenPos: TPoint;
  Handled: Boolean;
begin
  if TimeSpanParams.PopupMenu <> nil then
  begin
    ScreenPos := PlannerView.ClientToScreen(MousePos);
    Handled := False;
    if Assigned(OnPlannerSpanItemContextPopup) then
      OnPlannerSpanItemContextPopup(Self, PlannerView, SpanItem, MousePos, Handled);
    if not Handled then
      TimeSpanParams.PopupMenu.Popup(ScreenPos.X, ScreenPos.Y);
  end;
end;

procedure TPlannerControlEh.DefaultDrawSpanItem(
  PlannerView: TCustomPlannerViewEh; SpanItem: TTimeSpanDisplayItemEh;
  Rect: TRect; State: TDrawSpanItemDrawStateEh);
begin

end;

function TPlannerControlEh.CurWorkingTimeCalendar: TWorkingTimeCalendarEh;
begin
  if pvoUseGlobalWorkingTimeCalendarEh in Options
    then Result := GlobalWorkingTimeCalendar
    else Result := nil;
end;

function TPlannerControlEh.GetStartDate: TDateTime;
begin
  Result := ActivePlannerView.StartDate;
end;

procedure TPlannerControlEh.SetStartDate(const Value: TDateTime);
begin
  if ActivePlannerView <> nil then
    ActivePlannerView.StartDate := Value;
  FTopPanel.UpdatePeriodInfo;
end;

function TPlannerControlEh.GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
begin
  if ActivePlannerView <> nil
    then Result := ActivePlannerView.CoveragePeriodType
    else Result := pcpDayEh;
end;

function TPlannerControlEh.getCurrentTime: TDateTime;
begin
  Result := FCurrentTime;
end;

function TPlannerControlEh.GetDefaultEventNavBoxBorderColor: TColor;
begin
  Result := GetActualDrawStyle.EventNavBoxBorderColor;
end;

function TPlannerControlEh.GetDefaultEventNavBoxColor: TColor;
begin
  Result := GetActualDrawStyle.EventNavBoxFillColor;
end;

procedure TPlannerControlEh.SetCurrentTime(const Value: TDateTime);
begin
  if FCurrentTime <> Value then
  begin
    if ActivePlannerView <> nil
      then ActivePlannerView.CurrentTime := Value
      else GridCurrentTimeChanged(Value);
    EnsureDataForViewPeriod;
  end;
end;

procedure TPlannerControlEh.SetEventNavBoxParams(
  const Value: TEventNavBoxParamsEh);
begin
  FEventNavBoxParams.Assign(Value);
end;

procedure TPlannerControlEh.PlannerDataSourceChange(Sender: TObject);
begin
  PlannerDataSourceChanged;
end;

procedure TPlannerControlEh.PlannerDataSourceChanged;
begin
  if FIgnorePlannerDataSourceChanged then Exit;
  FIgnorePlannerDataSourceChanged := True;
  try
    EnsureDataForViewPeriod;
  finally
    FIgnorePlannerDataSourceChanged := False;
  end;
  if ActivePlannerView <> nil then
    ActivePlannerView.PlannerDataSourceChanged;
  NotifyConsumersPlannerDataChanged;
end;

procedure TPlannerControlEh.EnsureDataForViewPeriod;
var
  AStartDate, AEndDate: TDateTime;
begin
  GetViewPeriod(AStartDate, AEndDate);
  EnsureDataForPeriod(AStartDate, AEndDate);
end;

procedure TPlannerControlEh.GetViewPeriod(var AStartDate, AEndDate: TDateTime);
var
  NewStartDate, NewEndDate: TDateTime;
  i: Integer;
begin
  if ActivePlannerView <> nil then
    ActivePlannerView.GetViewPeriod(AStartDate, AEndDate);
  if FNotificationConsumers <> nil then
  begin
    for i := 0 to FNotificationConsumers.Count - 1 do
    begin
      (FNotificationConsumers[I] as IPlannerControlChangeReceiverEh).GetViewPeriod(NewStartDate, NewEndDate);
      if (NewStartDate <> 0) or (NewEndDate <> 0) then
      begin
        if NewStartDate < AStartDate then
          AStartDate := NewStartDate;
        if NewEndDate > AEndDate then
          AEndDate := NewEndDate;
      end;
    end;
  end;
end;

procedure TPlannerControlEh.EnsureDataForPeriod(AStartDate, AEndDate: TDateTime);
begin
  if PlannerDataSource <> nil then
    PlannerDataSource.EnsureDataForPeriod(AStartDate, AEndDate);
end;

procedure TPlannerControlEh.GridCurrentTimeChanged(ANewCurrentTime: TDateTime);
begin
  FCurrentTime := ANewCurrentTime;
  FTopPanel.UpdatePeriodInfo;
end;

procedure TPlannerControlEh.SetOnDrawSpanItem(const Value: TDrawSpanItemEventEh);
begin
  FOnDrawSpanItem := Value;
  if ActivePlannerView <> nil then
    ActivePlannerView.Invalidate;
end;

procedure TPlannerControlEh.SetOptions(const Value: TPlannerViewOptionsEh);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if pvoPlannerToolBoxEh in FOptions
      then FTopPanel.Visible := True
      else FTopPanel.Visible := False;
    Invalidate;
    if ActivePlannerView <> nil then
      ActivePlannerView.Invalidate;
  end;
end;

function TPlannerControlEh.GetPlannerDataSource: TPlannerDataSourceEh;
begin
  Result := FPlannerDataSource;
end;

procedure TPlannerControlEh.SetPlannerDataSource(const Value: TPlannerDataSourceEh);
begin
  if FPlannerDataSource <> Value then
  begin
    if Assigned(FPlannerDataSource) then
      FPlannerDataSource.UnRegisterChanges(Self);
    FPlannerDataSource := Value;
    if Assigned(FPlannerDataSource) then
    begin
      FPlannerDataSource.RegisterChanges(Self);
      FPlannerDataSource.FreeNotification(Self);
    end;
    if FPlannerDataSource <> nil then
      FPlannerDataSource.FreeNotification(Self);
    PlannerDataSourcePropertyChanged;
  end;
end;

procedure TPlannerControlEh.PlannerDataSourcePropertyChanged;
var
  i: Integer;
begin
  PlannerDataSourceChanged;
  if not (csLoading in ComponentState) then
    for i := 0 to PlannerViewCount-1 do
      PlannerView[i].RecreateDummyData;
end;

procedure TPlannerControlEh.SetTimeSpanParams(
  const Value: TPlannerControlTimeSpanParamsEh);
begin
  FTimeSpanParams.Assign(Value);
end;

procedure TPlannerControlEh.NavBoxParamsChanges;
begin
  if ActivePlannerView <> nil then
  begin
    ActivePlannerView.GridLayoutChanged;
    ActivePlannerView.ResetGridControlsState;
    ActivePlannerView.RealignGridControls;
  end;
end;

function TPlannerControlEh.NewItemParams(var StartTime,
  EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean;
begin
  Result := ActivePlannerView.NewItemParams(StartTime, EndTime, Resource);
end;

function TPlannerControlEh.NextDate: TDateTime;
begin
  Result := ActivePlannerView.NextDate;
end;

function TPlannerControlEh.PriorDate: TDateTime;
begin
  Result := ActivePlannerView.PriorDate;
end;

procedure TPlannerControlEh.NextPeriod;
begin
  if ActivePlannerView <> nil then
    ActivePlannerView.NextPeriod;
end;

procedure TPlannerControlEh.PriorPeriod;
begin
  if ActivePlannerView <> nil then
    ActivePlannerView.PriorPeriod;
end;

procedure TPlannerControlEh.SetViewMode(const Value: TPlannerDateRangeModeEh);
begin
  if FViewMode <> Value then
  begin
    FViewMode := Value;
    ViewModeChanged;
  end;
end;

procedure TPlannerControlEh.ShowDefaultPlanItemDialog(
  PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh;
  ChangeMode: TPlanItemChangeModeEh);
begin
  if ChangeMode = picmModifyEh then
    EditPlanItem(Self, Item)
  else
    EditNewItem(Self);
end;

procedure TPlannerControlEh.ShowModifyPlanItemDialog(PlanItem: TPlannerDataItemEh);
begin
  if Assigned(OnShowPlanItemDialog) then
    OnShowPlanItemDialog(Self, ActivePlannerView, PlanItem, picmModifyEh)
  else
    ShowDefaultPlanItemDialog(ActivePlannerView, PlanItem, picmModifyEh);
end;

procedure TPlannerControlEh.ShowNewPlanItemDialog;
begin
  if Assigned(OnShowPlanItemDialog) then
    OnShowPlanItemDialog(Self, ActivePlannerView, nil, picmInsertEh)
  else
    ShowDefaultPlanItemDialog(ActivePlannerView, nil, picmInsertEh);
end;

procedure TPlannerControlEh.ResetAutoLoadProcess;
begin

end;

procedure TPlannerControlEh.StopAutoLoad;
begin

end;

procedure TPlannerControlEh.StartDateChanged;
begin
  FTopPanel.UpdatePeriodInfo;
  NotifyConsumersPlannerDataChanged;
end;

procedure TPlannerControlEh.RegisterChanges(Value: IPlannerControlChangeReceiverEh);
begin
  if FNotificationConsumers.IndexOf(Value) < 0 then
    FNotificationConsumers.Add(Value);
end;

procedure TPlannerControlEh.UnRegisterChanges(Value: IPlannerControlChangeReceiverEh);
begin
  if FNotificationConsumers <> nil then
    FNotificationConsumers.Remove(Value);
end;

procedure TPlannerControlEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = PlannerDataSource then
    begin
      PlannerDataSource := nil;
    end;
  end;
end;

procedure TPlannerControlEh.NotifyConsumersPlannerDataChanged;
var
  i: Integer;
begin
  if FNotificationConsumers <> nil then
    for I := 0 to FNotificationConsumers.Count - 1 do
      (FNotificationConsumers[I] as IPlannerControlChangeReceiverEh).Change(Self);
end;

procedure TPlannerControlEh.ViewModeChanged;
begin
end;

function TPlannerControlEh.GetPeriodCaption: String;
begin
  if FActivePlannerGrid <> nil
    then Result := FActivePlannerGrid.GetPeriodCaption
    else Result := '';
end;

function TPlannerControlEh.CreatePlannerGrid(
  PlannerGridClass: TCustomPlannerGridClassEh;
  AOwner: TComponent): TCustomPlannerViewEh;
begin
  Result := PlannerGridClass.Create(AOwner);
  Result.Parent := Self;
  Result.Align := alClient;
  Result.Visible := False;
  if ActivePlannerView = nil then
    ActivePlannerView := Result;
end;

function TPlannerControlEh.CreatePlannerItem: TPlannerDataItemEh;
begin
  Result := PlannerDataSource.CreatePlannerItem;
end;

procedure TPlannerControlEh.CreateWnd;
begin
  inherited CreateWnd;
  TimeSpanParams.ResetDefaultProps;
end;

procedure TPlannerControlEh.RemovePlannerGrid(APlannerGrid: TCustomPlannerViewEh);
var
  RemoveIndex: Integer;
begin
  RemoveIndex := FPlannerGrids.Remove(APlannerGrid);
  if APlannerGrid = ActivePlannerView then
  begin
    if (PlannerViewCount > 0) and not (csDestroying in ComponentState) then
      ActivePlannerView := PlannerView[0]
    else
      ActivePlannerView := nil;
  end;
  if RemoveIndex >= 0 then
  begin
    APlannerGrid.Parent := nil;
  end;
end;

function TPlannerControlEh.GetPlannerGrid(Index: Integer): TCustomPlannerViewEh;
begin
  Result := TCustomPlannerViewEh(FPlannerGrids[Index]);
end;

function TPlannerControlEh.GetPlannerGridCount: Integer;
begin
  Result := FPlannerGrids.Count;
end;

function TPlannerControlEh.GetActivePlannerGrid: TCustomPlannerViewEh;
begin
  Result := FActivePlannerGrid;
end;

procedure TPlannerControlEh.SetActivePlannerGrid(const Value: TCustomPlannerViewEh);
begin
  if (Value <> nil) and (Value.PlannerControl <> Self) then
    raise Exception.Create('PlannerGrid "' + Value.Name + '" is not belong to PlannerView');
  try
    ChangeActivePlannerGrid(Value);
  finally
  end;
end;

procedure TPlannerControlEh.ActivePlannerViewChanged(
  OldActivePlannerGrid: TCustomPlannerViewEh);
begin
  if not (csDestroying in ComponentState) then
    if Assigned(OnActivePlannerViewChanged) then
      OnActivePlannerViewChanged(Self, OldActivePlannerGrid);
end;

procedure TPlannerControlEh.ChangeActivePlannerGrid(
  const APlannerGrid: TCustomPlannerViewEh);
var
  OldActivePlannerGrid: TCustomPlannerViewEh;
begin
  if FActivePlannerGrid <> APlannerGrid then
  begin
    OldActivePlannerGrid := FActivePlannerGrid;
    if FActivePlannerGrid <> nil then
    begin
      FActivePlannerGrid.Visible := False;
      FActivePlannerGrid.ActiveMode := False;
    end;

    FActivePlannerGrid := APlannerGrid;

    if FActivePlannerGrid <> nil then
    begin
      FActivePlannerGrid.CurrentTime := CurrentTime;
      FActivePlannerGrid.ActiveMode := True;
      FActivePlannerGrid.Visible := True;
      FActivePlannerGrid.BringToFront;
    end;

    StartDateChanged;
    ActivePlannerViewChanged(OldActivePlannerGrid);
  end;
end;

function TPlannerControlEh.GetActivePlannerGridIndex: Integer;
begin
  if ActivePlannerView <> nil
    then Result := ActivePlannerView.ViewIndex
    else Result := -1;
end;

procedure TPlannerControlEh.SetActivePlannerGridIndex(const Value: Integer);
begin
  ActivePlannerView := PlannerView[Value];
end;

procedure TPlannerControlEh.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to PlannerViewCount - 1 do
    Proc(PlannerView[i]);
end;

procedure TPlannerControlEh.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TCustomPlannerViewEh(Child).ViewIndex := Order;
end;

procedure TPlannerControlEh.LayoutChanged;
begin
  if ActivePlannerView <> nil then
    ActivePlannerView.GridLayoutChanged;
end;

procedure TPlannerControlEh.Loaded;
var
  i: Integer;
begin
  inherited Loaded;
  if (ActivePlannerView = nil) and (PlannerViewCount > 0) then
    ActivePlannerView := PlannerView[0];

  for i := 0 to PlannerViewCount-1 do
    PlannerView[i].RecreateDummyData;
end;

procedure TPlannerControlEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  Params.ExStyle := Params.ExStyle or WS_EX_CONTROLPARENT;
end;

procedure TPlannerControlEh.CMFontChanged(var Message: TMessage);
begin
  inherited;
  TimeSpanParams.RefreshDefaultFont;
end;

procedure TPlannerControlEh.CoveragePeriod(var AFromTime, AToTime: TDateTime);
begin
  if ActivePlannerView <> nil then
    ActivePlannerView.CoveragePeriod(AFromTime, AToTime)
  else
  begin
    AFromTime := 0;
    AToTime := 0;
  end;
end;

function TPlannerControlEh.CheckPlannerItemInteractiveChanging(
  PlannerView: TCustomPlannerViewEh; Item, NewValuesItem: TPlannerDataItemEh;
  var ErrorText: String): Boolean;
begin
  Result := CheckPlannerItemChangeOperation(PlannerView, Item, paoChangePlanItemEh);
  if not Result then Exit;

  if Assigned(OnCheckPlannerItemInteractiveChanging) then
    OnCheckPlannerItemInteractiveChanging(Self, PlannerView, Item, NewValuesItem,
      Result, ErrorText);
end;

procedure TPlannerControlEh.PlannerItemInteractiveChanged(
  PlannerView: TCustomPlannerViewEh; Item, OldValuesItem: TPlannerDataItemEh);
begin
  if Assigned(OnPlannerItemInteractiveChanged) then
    OnPlannerItemInteractiveChanged(Self, PlannerView, Item, OldValuesItem);
end;

function TPlannerControlEh.CheckPlannerItemChangeOperation(
  PlannerView: TCustomPlannerViewEh; Item: TPlannerDataItemEh;
  Operation: TPlannerAllowedOperationEh): Boolean;
begin
  case Operation of
    paoAppendPlanItemEh:
      Result := (paoAppendPlanItemEh in AllowedOperations);
    paoChangePlanItemEh:
      Result := (paoChangePlanItemEh in AllowedOperations) and not Item.ReadOnly;
    paoDeletePlanItemEh:
      Result := (paoDeletePlanItemEh in AllowedOperations) and not Item.ReadOnly;
  else
    Result := True;
  end;
end;

procedure TPlannerControlEh.DefaultFillSpanItemHintShowParams(
  PlannerView: TCustomPlannerViewEh; CursorPos: TPoint;
  SpanRect: TRect; InSpanCursorPos: TPoint; SpanItem: TTimeSpanDisplayItemEh;
  Params: TPlannerViewSpanHintParamsEh);
begin
  PlannerView.DefaultFillSpanItemHintShowParams(CursorPos, SpanRect,
    InSpanCursorPos, SpanItem, Params);
end;

procedure TPlannerControlEh.SetWorkingTimeEnd(const Value: TTime);
begin
  if FWorkingTimeEnd <> Value then
  begin
    FWorkingTimeEnd := Value;
    PlannerDataSourceChanged;
  end;
end;

procedure TPlannerControlEh.SetWorkingTimeStart(const Value: TTime);
begin
  if FWorkingTimeStart <> Value then
  begin
    FWorkingTimeStart := Value;
    PlannerDataSourceChanged;
  end;
end;

procedure TPlannerControlEh.SetAllowedOperations(const Value: TPlannerAllowedOperationsEh);
begin
  FAllowedOperations := Value;
end;

procedure TPlannerControlEh.SetDrawStyle(const Value: TPlannerDrawStyleEh);
begin
  if Value <> FDrawStyle then
  begin
    FDrawStyle := Value;
    PlannerDataSourceChanged;
  end;
end;

function TPlannerControlEh.GetActualDrawStyle: TPlannerDrawStyleEh;
begin
  if DrawStyle <> nil
    then Result := DrawStyle
    else Result := PlannerDrawStyleEh;
end;

{ TPlannerToolBoxEh }

constructor TPlannerToolBoxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csAcceptsControls];

  FPriorPeriodButton := TSpeedButtonEh.Create(Self);
  FPriorPeriodButton.Parent := Self;
  FPriorPeriodButton.Top := 9;
  FPriorPeriodButton.Left := 10;
  FPriorPeriodButton.Flat := True;
  //FPriorPeriodButton.Style := ebsGlyphEh;
  FPriorPeriodButton.OnClick := PriorPeriodClick;
  FPriorPeriodButton.OnPaint := ButtonPaint;

  FNextPeriodButton := TSpeedButtonEh.Create(Self);
  FNextPeriodButton.Parent := Self;
  FNextPeriodButton.Top := 9;
  FNextPeriodButton.Left := 35;
  FNextPeriodButton.Flat := True;
  //FNextPeriodButton.Style := ebsGlyphEh;
  FNextPeriodButton.OnClick := NextPeriodClick;
  FNextPeriodButton.OnPaint := ButtonPaint;

  FPeriodInfo := TLabel.Create(Self);
  FPeriodInfo.Parent := Self;
  FPeriodInfo.Top := 9;
  FPeriodInfo.Left := 70;
  FPeriodInfo.Font.Size := 12;
  FPeriodInfo.Caption := FormatDateTime(FormatSettings.LongDateFormat, Date);
  DoubleBuffered := True;
end;

destructor TPlannerToolBoxEh.Destroy;
begin
  inherited Destroy;
end;

function TPlannerToolBoxEh.GetPlannerControl: TPlannerControlEh;
begin
  Result := TPlannerControlEh(Owner);
end;

procedure TPlannerToolBoxEh.ButtonPaint(Sender: TObject);
var
  AButton: TSpeedButtonEh;
  ButtonKind: TPlannerControlButtonKindEh;
  ADrawRect: TRect;
begin
  AButton := TSpeedButtonEh(Sender);
  ADrawRect := AButton.ClientRect;

  if AButton = FPriorPeriodButton
    then ButtonKind := pcbkPriorPeriodEh
    else ButtonKind := pcbkNextPeriodEh;

  
  begin
    if AButton.State in [bsPressedEh, bsHotEh] then
    begin
      AButton.Canvas.Brush.Color := ApproximateColor(
        CheckSysColor(clHighlight),
        CheckSysColor(clBtnFace), 200);
      AButton.Canvas.FillRect(Rect(0,0,Width,Height));
    end;

    PlannerControl.GetActualDrawStyle.DrawNavigateButtonSign(Self, AButton.Canvas,
      ADrawRect, AButton.State, ButtonKind, False, UseRightToLeftAlignment,
      ScaleFactor);
  end;
end;

procedure TPlannerToolBoxEh.NextPeriodClick(Sender: TObject);
begin
  TPlannerControlEh(Owner).NextPeriod;
end;

procedure TPlannerToolBoxEh.PriorPeriodClick(Sender: TObject);
begin
  TPlannerControlEh(Owner).PriorPeriod;
end;

procedure TPlannerToolBoxEh.UpdatePeriodInfo;
begin
  if HandleAllocated then
  begin
    FPeriodInfo.Caption := TPlannerControlEh(Owner).GetPeriodCaption;
    FPriorPeriodButton.Width := Round(24 * ScaleFactor);
    FPriorPeriodButton.Height := FPriorPeriodButton.Width;
    FNextPeriodButton.Width := Round(24 * ScaleFactor);
    FNextPeriodButton.Height := FNextPeriodButton.Width;
    if UseRightToLeftAlignment then
    begin
      FPriorPeriodButton.Left := ClientWidth - FPriorPeriodButton.Width - Round(10 * ScaleFactor);
      FNextPeriodButton.Left := FPriorPeriodButton.Left - FNextPeriodButton.Width;
      FPeriodInfo.Left := FNextPeriodButton.Left - FPeriodInfo.Width;
    end else
    begin
      FPriorPeriodButton.Top := (Height - FPriorPeriodButton.Height) div 2;
      FPriorPeriodButton.Left := Round(10 * ScaleFactor); 
      FNextPeriodButton.Top := FPriorPeriodButton.Top;
      FNextPeriodButton.Left := FPriorPeriodButton.Left + FPriorPeriodButton.Width; 
      FPeriodInfo.Left := FNextPeriodButton.Left + FNextPeriodButton.Width + Round(10 * ScaleFactor);
    end;
  end;
end;

procedure TPlannerToolBoxEh.Resize();
begin
  UpdatePeriodInfo;
  inherited Resize();
end;

procedure TPlannerToolBoxEh.ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF});
begin
  inherited ChangeScale(M, D{$IFDEF EH_LIB_24}, isDpiChange{$ENDIF});
  if M <> D then
  begin
  {$IFNDEF EH_LIB_26} 
    FScaleFactor := FScaleFactor * M / D;
  {$ENDIF}
    FPeriodInfo.Font.Height := MulDiv(Font.Height, 3, 2);
    UpdatePeriodInfo;
  end;
end;

{ TPlannerWeekViewEh }

constructor TPlannerWeekViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColDaysLength := 1;
  FDayCols := 7;
  HorzScrollBar.VisibleMode := sbNeverShowEh;
  FDataRowsOffset := 1;
  FDataColsOffset := 1;
  FAllDayRowIndex := -1;
  FInDayList :=  TObjectListEh.Create;
  FAllDayList := TObjectListEh.Create;
  FMinDayColWidth := 50;
  FBarTimeInterval := pbti30MinEh;
  FBarsPerHour := BarsPerHourIntervalArr[FBarTimeInterval];
  FBarTimeLength := EncodeTime(1, 0, 0, 0) / FBarsPerHour;
  FRowMinutesLength := 60 div FBarsPerHour;

  SetGridShowHours;
end;

destructor TPlannerWeekViewEh.Destroy;
begin
  Destroying;
  FreeAndNil(FInDayList);
  FreeAndNil(FAllDayList);
  inherited Destroy;
end;

procedure TPlannerWeekViewEh.BuildGridData;
begin
  inherited BuildGridData;
  SetGridShowHours;
  if Length(FResourcesView) > 1
    then FInterResourceCols := 1
    else FInterResourceCols := 0;
  UpdateDefaultTimeSpanBoxHeight;
  BuildDaysGridMode;
  if HandleAllocated then
    ResetDayNameFormat(2, 3);
  RealignGridControls;
end;

procedure TPlannerWeekViewEh.BuildDaysGridMode;
var
  i: Integer;
  ColGroups: Integer;
  ARowCount: Integer;
  ir: Integer;
  AnAllDayLinesCount: Integer;
  AStartHour: Integer;
  AFixedRowCount: Integer;
  AHoursBarWidth: Integer;
  ColWidth, FitGap: Integer;
  DataColsWidth: Integer;
  AHoursColCount: Integer;
  aTime: TTime;
begin

  if FAllDayList = nil then Exit;

  ClearGridCells;
  FAllDayLinesCount := FAllDayList.Count;

  CalcRolRows;

  AFixedRowCount := TopGridLineCount;

  if ResourceCaptionArea.Visible then
  begin
    ColGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;

    FResourceAxisPos := AFixedRowCount;
    AFixedRowCount := AFixedRowCount + 2;
    ARowCount := FRolRowCount + AFixedRowCount;
    FAllDayRowIndex := AFixedRowCount-1;
  end else
  begin
    ColGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;
    AFixedRowCount := AFixedRowCount + 1;
    ARowCount := FRolRowCount + AFixedRowCount;
    FResourceAxisPos := -1;
    FAllDayRowIndex := AFixedRowCount-1;
  end;


  if DayNameArea.Visible then
  begin
    FDayNameBarPos := AFixedRowCount-1;
    Inc(ARowCount);
    Inc(AFixedRowCount);
    Inc(FAllDayRowIndex);
  end else
    FDayNameBarPos := -1;


  if HoursColArea.Visible then
  begin
    FixedColCount := 1;
    FDataColsOffset := 1;
    FHoursBarIndex := 0;
    AHoursColCount := 1;
  end else
  begin
    FixedColCount := 0;
    FDataColsOffset := 0;
    FHoursBarIndex := -1;
    AHoursColCount := 0;
  end;
  FixedRowCount := AFixedRowCount;
  FDataRowsOffset := AFixedRowCount;

  ColCount := FDayCols * ColGroups + AHoursColCount + (ColGroups-1);
  RowCount := ARowCount;
  SetGridSize(FullColCount, FullRowCount);
  if ColGroups = 1
    then FBarsPerRes := FDayCols
    else FBarsPerRes := FDayCols + 1;

  if FHoursBarIndex >= 0 then
  begin
    ColWidths[FHoursBarIndex] := HoursColArea.GetActualSize;
    AHoursBarWidth := HoursColArea.GetActualSize;
  end else
    AHoursBarWidth := 0;


  DataColsWidth := (GridClientWidth - AHoursBarWidth - (ColGroups-1)*3);
  ColWidth := DataColsWidth div (ColGroups * FDayCols);
  if ColWidth < MinDayColWidth then
  begin
    ColWidth := MinDayColWidth;
    HorzScrollBar.VisibleMode := sbAutoShowEh;
    FitGap := 0;
  end else
  begin
    HorzScrollBar.VisibleMode := sbNeverShowEh;
    FitGap := DataColsWidth mod (ColGroups * FDayCols);
  end;

  for i := FixedColCount to ColCount-1 do
  begin
    if IsInterResourceCell(i, 0) then
    begin
      ColWidths[i] := 3;
    end else
    begin
      if FitGap > 0
        then ColWidths[i] := ColWidth + 1
        else ColWidths[i] := ColWidth;
      Dec(FitGap);
    end;
  end;


  if HandleAllocated then
  begin
    DefaultRowHeight := DataBarsArea.GetActualRowHeight;
    for i := 0 to RowCount-1 do
      if i <> FAllDayRowIndex then
        RowHeights[i] := DefaultRowHeight;

    if TopGridLineCount > 0 then
      RowHeights[FTopGridLineIndex] := 1;

    if FResourceAxisPos >= 0 then
      RowHeights[FResourceAxisPos] := ResourceCaptionArea.GetActualSize;

    if FDayNameBarPos >= 0 then
      RowHeights[FDayNameBarPos] := DayNameArea.GetActualSize;
  end;


  if HoursColArea.Visible then
  begin
    Cell[0,0].Value := Date;

    AStartHour := Round(FGridStartWorkingTime / EncodeTime(1,0,0,0));

    for i := 0 to (FRolRowCount-1) div FBarsPerHour do
    begin
      ir := FixedRowCount+i*FBarsPerHour;
      MergeCells(0,ir, 0,FBarsPerHour-1);
      aTime := EncodeTime(i+AStartHour,0,0,0);
      Cell[0,ir].Value := aTime;
    end;
  end;

  if FAllDayLinesCount > 1
    then AnAllDayLinesCount := FAllDayLinesCount
    else AnAllDayLinesCount := 1;


  if (FResourceAxisPos >= 0) and (FBarsPerRes > 1) then
  begin
    for i := 0 to ColGroups-1 do
    begin
      ir := FixedColCount + FBarsPerRes * i;
      MergeCells(ir,FResourceAxisPos, FBarsPerRes-1-FInterResourceCols,0);
   end;
  end;


  RowHeights[FAllDayRowIndex] :=
    AnAllDayLinesCount * FDefaultTimeSpanBoxHeight + (FDefaultTimeSpanBoxHeight * 2 div 3);
end;

function TPlannerWeekViewEh.AdjustDate(const Value: TDateTime): TDateTime;
begin
  if FDayCols = 1
    then Result := DateOf(Value)
    else Result := PlannerStartOfTheWeek(Value);
end;

procedure TPlannerWeekViewEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
var
  DataCell: TGridCoord;
  DataRow: Integer;
  Resource: TPlannerResourceEh;
  ResNo: Integer;
  CellDate: TDateTime;
  CellDateCp1: TDateTime;
  TodayTopFrameCell: Integer;
begin
  inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);

  Resource := nil;
  DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));
  CellDate := CellToDateTime(ACol, ARow);
  if (ACol < ColCount-1) and
     not IsInterResourceCell(ACol+1, ARow)
  then
    CellDateCp1 := CellToDateTime(ACol+1, ARow)
  else
    CellDateCp1 := CellDate;

  if ( (ACol-FDataColsOffset >= 0) or
       ((ACol-FDataColsOffset = -1 ) and (BorderType = cbtRightEh))
     ) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0) then
  begin
    if IsInterResourceCell(ACol, ARow) then
    begin
      if BorderType in [cbtTopEh, cbtBottomEh]  then
        IsDraw := False;
      Resource := PlannerDataSource.Resources[(ACol-FDataColsOffset) div FBarsPerRes];
    end else
    begin
      ResNo := (ACol-FDataColsOffset) div FBarsPerRes;
      if (ResNo >= 0) and (ResNo < PlannerDataSource.Resources.Count) then
        Resource := PlannerDataSource.Resources[ResNo];
    end;
    if (Resource <> nil) and (Resource.DarkLineColor <> clDefault) then
        BorderColor := Resource.DarkLineColor;
  end
  else if (BorderType = cbtBottomEh) and
          (ACol < FixedColCount) and
          (ARow < FixedRowCount-1)
  then
  begin
    IsDraw := False;
  end;

  if IsDraw and (DataCell.X >= 0) and (DataCell.Y >= 0) then
  begin
    DataRow := DataCell.Y; 
    if (BorderType in [cbtTopEh, cbtBottomEh]) and ((DataRow+1) mod FBarsPerHour <> 0) then
      if (Resource <> nil) and (Resource.BrightLineColor <> clDefault)
        then BorderColor := Resource.BrightLineColor
        else BorderColor := GridLineParams.GetPaleColor;
  end;

  if (pvoHighlightTodayEh in PlannerControl.Options) then
  begin
    if (FDayCols > 1) and
       (PlannerDataSource <> nil) and
       (PlannerDataSource.Resources.Count > 0)
    then
      TodayTopFrameCell := 1
    else
      TodayTopFrameCell := 0;

    if ( ( (BorderType in [cbtBottomEh]) and
           (ARow = RowCount-1) and
           (ACol >= FixedColCount))
         or
         ( (BorderType in [cbtBottomEh]) and
           (TodayTopFrameCell = 0) and
           (ARow = TodayTopFrameCell) and
           (ACol >= FixedColCount)
         )
         or
         ((BorderType in [cbtLeftEh, cbtRightEh]) and (ARow > TodayTopFrameCell))
       ) and
       (DateOf(CellDate) = DateOf(Today)) and
       not IsInterResourceCell(ACol, ARow)
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end else if (BorderType = cbtRightEh) and
                (DataCell.X >= 0) and
                (ACol < ColCount-1) and
                (DateOf(CellDateCp1) = DateOf(Today)) and
                (ARow > TodayTopFrameCell)
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end;
  end;
end;

procedure TPlannerWeekViewEh.GetDayNamesCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  inherited GetDayNamesCellDrawParams(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);

  if DrawArgs.HighlightToday and
     (DrawArgs.TodayDate = sbTrueEh) and
     (FDayCols > 1) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0)
  then
    TPlannerViewDayNamesCellDrawArgsEh(DrawArgs).DrawTopToDayLine := True
  else
    TPlannerViewDayNamesCellDrawArgsEh(DrawArgs).DrawTopToDayLine := False;
end;

procedure TPlannerWeekViewEh.DrawDayNamesCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawWeekViewDayNamesCell(Self, Canvas, ARect,
    State, TPlannerViewDayNamesCellDrawArgsEh(DrawArgs));
end;

procedure TPlannerWeekViewEh.DrawDayNamesCellBack(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawWeekViewDayNamesCellBack(Self, Canvas, ARect,
    State, TPlannerViewDayNamesCellDrawArgsEh(DrawArgs));
end;

function TPlannerWeekViewEh.CheckHitSpanItem(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer): TTimeSpanDisplayItemEh;
var
  Pos: TPoint;
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
  SpanDrawRect: TRect;
  ACellRect: TRect;
  RollCliBounds: TRect;
begin
  Result := nil;
  RollCliBounds := Rect(HorzAxis.FixedBoundary, VertAxis.FixedBoundary, HorzAxis.ContraStart, VertAxis.ContraStart);
  if UseRightToLeftAlignment then
    RollCliBounds := RightToLeftReflectRect(ClientRect, RollCliBounds);
  if (X >= RollCliBounds.Left) and (X < RollCliBounds.Right) and
     (Y >= RollCliBounds.Top) and (Y < RollCliBounds.Bottom) then
  begin
    Pos := Point(X, Y);
    for i := 0 to InDayListCount-1 do
    begin
      SpanItem := InDayList[i];
      SpanItem.GetInGridDrawRect(SpanDrawRect);
      if UseRightToLeftAlignment then
        SpanDrawRect := RightToLeftReflectRect(ClientRect, SpanDrawRect);
      if PtInRect(SpanDrawRect, Pos) then
      begin
        Result := SpanItem;
        Break;
      end;
    end;
  end
  else if (X >= RollCliBounds.Left) and (X < RollCliBounds.Right) and
          (Y >= RowHeights[0]) and (Y < VertAxis.FixedBoundary) then
  begin
    ACellRect := CellRect(0, FAllDayRowIndex);
    Pos := Point(X, Y - ACellRect.Top);
    for i := 0 to AllDayListCount-1 do
    begin
      SpanItem := AllDayList[i];
      SpanItem.GetInGridDrawRect(SpanDrawRect);
      if UseRightToLeftAlignment then
        SpanDrawRect := RightToLeftReflectRect(ClientRect, SpanDrawRect);
      if PtInRect(SpanDrawRect, Pos) then
      begin
        Result := SpanItem;
        Break;
      end;
    end;
  end;
end;

procedure TPlannerWeekViewEh.ClearSpanItems;
begin
  inherited ClearSpanItems;
  if FInDayList <> nil then
  begin
    FInDayList.Clear;
    FAllDayList.Clear;
  end;
end;

procedure TPlannerWeekViewEh.GetCellType(ACol, ARow: Integer;
  var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer);
begin
  if (ACol = FHoursBarIndex) and (ARow < FixedRowCount) then
  begin
    CellType := pctTopLeftCellEh;
    ALocalCol := ACol;
    ALocalRow := ARow;
  end else if ACol = FHoursBarIndex then
  begin
    CellType := pctTimeCellEh;
    ALocalCol := ACol;
    ALocalRow := ARow - FixedRowCount;
  end else if (ACol > FHoursBarIndex) and (ARow = FResourceAxisPos) then
  begin
    if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctResourceCaptionCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ACol > FHoursBarIndex) and (ARow = FDayNameBarPos) then
  begin
    if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctDayNameCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else
  begin
    if ARow = FAllDayRowIndex then
    begin
      CellType := pctAlldayDataCellEh;
      ALocalRow := 0;
    end else
    begin
      CellType := pctDataCellEh;
      ALocalRow := ARow - FixedRowCount;
    end;
    ALocalCol := ACol - FixedColCount;
  end;
end;

function TPlannerWeekViewEh.DrawLongDayNames: Boolean;
begin
  if FDayCols = 1
    then Result := True
    else Result := False;
end;

function TPlannerWeekViewEh.DrawMonthDayWithWeekDayName: Boolean;
begin
  if FDayCols = 1
    then Result := False
    else Result := True;
end;

procedure TPlannerWeekViewEh.GetViewPeriod(var AStartDate, AEndDate: TDateTime);
begin
  AStartDate := StartDate;
  AEndDate := AStartDate + FDayCols;
end;

function TPlannerWeekViewEh.NewItemParams(var StartTime,
  EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean;
begin
  if SelectedRange.FromDateTime < SelectedRange.ToDateTime then
  begin
    StartTime := SelectedRange.FromDateTime;
    EndTime := SelectedRange.ToDateTime;
  end else
  begin
    StartTime := CellToDateTime(Col, Row);
    EndTime := StartTime + FBarTimeLength;
  end;
  Resource :=  GetResourceAtCell(Col, Row);
  Result := True;
end;

function TPlannerWeekViewEh.NextDate: TDateTime;
begin
  Result := StartDate + FDayCols;
end;

function TPlannerWeekViewEh.PriorDate: TDateTime;
begin
  Result := StartDate - FDayCols;
end;

function TPlannerWeekViewEh.AppendPeriod(ATime: TDateTime; Periods: Integer): TDateTime;
begin
  Result := ATime + FDayCols * Periods;
end;

procedure TPlannerWeekViewEh.Resize;
begin
  inherited Resize;
  if HandleAllocated and ActiveMode then
    SetDisplayPosesSpanItems;
end;

function TPlannerWeekViewEh.SelectCell(ACol, ARow: Integer): Boolean;
begin
  if IsInterResourceCell(ACol, ARow) then
    Result := False
  else
    Result := inherited SelectCell(ACol, ARow);
end;

procedure TPlannerWeekViewEh.SetDisplayPosesSpanItems;
var
  ASpanRect: TRect;
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  ACol: Integer;
  StartX: Integer;
  ResourceOffset: Integer;
  ADate: TDateTime;
  AEndCol: Integer;
  d: Integer;
  ARightRect: TRect;
begin
  if not ActiveMode then Exit;

  SetResOffsets;

  StartX := 0;
  for ACol := FDataColsOffset to ColCount-1 do
  begin

    for i := 0 to FInDayList.Count-1 do
    begin
      SpanItem := TTimeSpanDisplayItemEh(FInDayList[i]);
      if SpanItem.GridColNum = ACol - FDataColsOffset then
      begin
        ASpanRect.Left := StartX + 10;
        ASpanRect.Right := ASpanRect.Left + ColWidths[ACol] - 20;
        ASpanRect.Top := SpanItem.StartGridRollPos;
        if ASpanRect.Top < 0 then
          ASpanRect.Top := 0;
        ASpanRect.Bottom := SpanItem.StopGridRolPosl;
        if ASpanRect.Bottom > VertAxis.RolLen then
          ASpanRect.Bottom := VertAxis.RolLen;


        ResourceOffset := GetGridOffsetForResource(SpanItem.PlanItem.Resource);
        OffsetRect(ASpanRect, ResourceOffset, 0);

        CalcRectForInCellCols(SpanItem, ASpanRect);

        SpanItem.FBoundRect := ASpanRect;
      end;
    end;

    StartX := StartX + ColWidths[ACol];
  end;


  if Length(FResourcesView) > 1
    then AEndCol := FBarsPerRes-2
    else AEndCol := FBarsPerRes-1;

  for i := 0 to AllDayListCount-1 do
  begin
    SpanItem := TTimeSpanDisplayItemEh(AllDayList[i]);
    ResourceOffset := GetGridOffsetForResource(SpanItem.PlanItem.Resource);
    ADate := StartDate;
    StartX := HorzAxis.FixedBoundary;
    for d := 0 to AEndCol do
    begin
      if (d = 0) and (SpanItem.PlanItem.StartTime < ADate) then
      begin
        SpanItem.FBoundRect.Left := StartX;
        SpanItem.FDrawBackOutInfo := True;
      end else if (SpanItem.PlanItem.StartTime >= ADate) and (SpanItem.PlanItem.StartTime < ADate + 1) then
      begin
        SpanItem.FBoundRect.Left := StartX + 8;
      end;

      if (SpanItem.PlanItem.EndTime >= ADate) and (SpanItem.PlanItem.EndTime < ADate + 1) then
      begin
        SpanItem.FBoundRect.Right := StartX + ColWidths[d + FDataColsOffset] - 8;
        SpanItem.FBoundRect.Top := FDefaultTimeSpanBoxHeight * SpanItem.FInCellFromCol;
        SpanItem.FBoundRect.Bottom := SpanItem.FBoundRect.Top + FDefaultTimeSpanBoxHeight;
        OffsetRect(SpanItem.FBoundRect, ResourceOffset, 0);
        Break;
      end;

      ADate := ADate + 1;
      StartX := StartX + ColWidths[d + FDataColsOffset];
    end;
  end;

  ADate := StartDate + AEndCol + 1;
  ARightRect := CellRect(AEndCol + FDataColsOffset, 0, False, False);
  for i := 0 to AllDayListCount-1 do
  begin
    SpanItem := TTimeSpanDisplayItemEh(AllDayList[i]);
    ResourceOffset := GetGridOffsetForResource(SpanItem.PlanItem.Resource);
    if (SpanItem.PlanItem.EndTime >= ADate) then
    begin
      SpanItem.FBoundRect.Right := ARightRect.Right;
      SpanItem.FDrawForwardOutInfo := True;
      SpanItem.FBoundRect.Top := FDefaultTimeSpanBoxHeight * SpanItem.FInCellFromCol;
      SpanItem.FBoundRect.Bottom := SpanItem.FBoundRect.Top + FDefaultTimeSpanBoxHeight;
      OffsetRect(SpanItem.FBoundRect, ResourceOffset, 0);
    end;
  end;

end;

function GetSpanEndTime(SpanItem: TTimeSpanDisplayItemEh): TDateTime;
begin
  Result := SpanItem.EndTime;
end;

function GetPlanEndTime(SpanItem: TTimeSpanDisplayItemEh): TDateTime;
begin
  Result := SpanItem.PlanItem.EndTime;
end;

procedure TPlannerWeekViewEh.SetGroupPosesSpanItems(Resource: TPlannerResourceEh);
var
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
  CurStack: TObjectListEh;
  CurList: TObjectListEh;
  CurColbarCount: Integer;
  FullEmpty: Boolean;

type
  TGetEndTime = function (SpanItem: TTimeSpanDisplayItemEh): TDateTime;

  procedure CheckPushOutStack(ATime: TDateTime; AGetEndTimeProg: TGetEndTime);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
  begin
    for i := 0 to CurStack.Count-1 do
    begin
      StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
      if (StackSpanItem <> nil) and (AGetEndTimeProg(StackSpanItem) <= ATime) then
      begin
        CurList.Add(CurStack[i]);
        CurStack[i] := nil;
      end;
    end;

    FullEmpty := True;
    for i := 0 to CurStack.Count-1 do
      if CurStack[i] <> nil then
      begin
        FullEmpty := False;
        Break;
      end;

    if FullEmpty then
    begin
      CurColbarCount := 1;
      CurList.Clear;
      CurStack.Clear;
    end;
  end;

  procedure PushInStack(ASpanItem: TTimeSpanDisplayItemEh);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
    PlaceFound: Boolean;
  begin
    PlaceFound := False;
    if CurStack.Count > 0 then
    begin
      for i := 0 to CurStack.Count-1 do
      begin
        StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
        if StackSpanItem = nil then
        begin
          ASpanItem.FInCellCols := CurColbarCount;
          ASpanItem.FInCellFromCol := i;
          ASpanItem.FInCellToCol := i;
          CurStack[i] := ASpanItem;
          PlaceFound := True;
          Break;
        end;
      end;
    end;
    if not PlaceFound then
    begin
      if CurStack.Count > 0 then
      begin
        CurColbarCount := CurColbarCount + 1;
        for i := 0 to CurStack.Count-1 do
          TTimeSpanDisplayItemEh(CurStack[i]).FInCellCols := CurColbarCount;
        for i := 0 to CurList.Count-1 do
          TTimeSpanDisplayItemEh(CurList[i]).FInCellCols := CurColbarCount;
      end;
      ASpanItem.FInCellCols := CurColbarCount;
      ASpanItem.FInCellFromCol := CurColbarCount-1;
      ASpanItem.FInCellToCol := CurColbarCount-1;
      CurStack.Add(ASpanItem);
    end;
  end;

begin
  CurStack := TObjectListEh.Create;
  CurList := TObjectListEh.Create;
  CurColbarCount := 1;

  for i := 0 to FInDayList.Count-1 do
  begin
    SpanItem := InDayList[i];
    if SpanItem.PlanItem.Resource = Resource then
    begin
      CheckPushOutStack(SpanItem.PlanItem.StartTime, @GetPlanEndTime);
      PushInStack(SpanItem);
    end;
  end;


  CurStack.Clear;
  CurList.Clear;
  CurColbarCount := 1;

  for i := 0 to FAllDayList.Count-1 do
  begin
    SpanItem := AllDayList[i];
    if SpanItem.PlanItem.Resource = Resource then
    begin
      CheckPushOutStack(SpanItem.StartTime, @GetSpanEndTime);
      PushInStack(SpanItem);
    end;
  end;

  CurStack.Free;
  CurList.Free;
end;

procedure TPlannerWeekViewEh.SetMinDayColWidth(const Value: Integer);
begin
  if FMinDayColWidth <> Value then
  begin
    FMinDayColWidth := Value;
    GridLayoutChanged;
  end;
end;

procedure TPlannerWeekViewEh.SetResOffsets;
var
  i: Integer;
begin
  for i := 0 to Length(FResourcesView)-1 do
    if i*FBarsPerRes < HorzAxis.RolCelCount then
    begin
      if i < ResourcesCount
        then FResourcesView[i].Resource := PlannerDataSource.Resources[i]
        else FResourcesView[i].Resource := nil;
      FResourcesView[i].GridOffset := HorzAxis.RolLocCelPosArr[i*FBarsPerRes];
      FResourcesView[i].GridStartAxisBar := i*FBarsPerRes;
    end;
end;

function TPlannerWeekViewEh.GetGridOffsetForResource(Resource: TPlannerResourceEh): Integer;
var
  i: Integer;
begin
  Result := 0;
  if PlannerDataSource <> nil then
  begin
    for i := 0 to Length(FResourcesView)-1 do
      if    ((i < PlannerDataSource.Resources.Count) and (PlannerDataSource.Resources[i] = Resource))
         or ((i = Length(FResourcesView)-1) and (Resource = nil)) then
      begin
        Result := FResourcesView[i].GridOffset;
        Break;
      end;
  end;
end;

procedure TPlannerWeekViewEh.SortPlanItems;
begin
  FillSpecDaysList;

  FInDayList.Sort(CompareSpanItemFuncByPlan);
  FAllDayList.Sort(CompareSpanItemFuncByPlan);
end;

function TPlannerWeekViewEh.IsPlanItemHitAllGridArea(APlanItem: TPlannerDataItemEh): Boolean;
var
  CheckDay: TDateTime;
begin
  Result := not APlanItem.InsideDay;
  if not Result then
  begin
    CheckDay := DateOf(APlanItem.EndTime);
    if APlanItem.EndTime < CheckDay + FGridStartWorkingTime then
    begin
      Result := True;
      Exit;
    end;
    CheckDay := DateOf(APlanItem.StartTime);
    if APlanItem.StartTime >= CheckDay + FGridStartWorkingTime + FGridWorkingTimeLength then
      Result := True;
  end;
end;

procedure TPlannerWeekViewEh.FillSpecDaysList;
var
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
begin
  FInDayList.Clear;
  FAllDayList.Clear;

  for i := 0 to SpanItemsCount-1 do
  begin
    SpanItem := SpanItems[i];
    if not IsPlanItemHitAllGridArea(SpanItem.PlanItem) then
    begin
      FInDayList.Add(SpanItem);
      SpanItem.FAllowedInteractiveChanges :=
        [sichSpanTopSizingEh, sichSpanButtomSizingEh, sichSpanMovingEh];
      SpanItem.FTimeOrientation := toVerticalEh;
    end else
    begin
      FAllDayList.Add(SpanItem);
      SpanItem.FHorzLocating := brrlWindowClientEh;
      SpanItem.FVertLocating := brrlWindowClientEh;
      SpanItem.FAllowedInteractiveChanges :=
        [sichSpanLeftSizingEh, sichSpanRightSizingEh, sichSpanMovingEh];
      SpanItem.FTimeOrientation := toHorizontalEh;
      SpanItem.FAlignment := taCenter;
      SpanItem.StartTime := DateOf(SpanItem.PlanItem.StartTime);
      SpanItem.EndTime := DateOf(SpanItem.PlanItem.EndTime);
      if SpanItem.EndTime <> SpanItem.PlanItem.EndTime then
        SpanItem.EndTime := IncDay(SpanItem.EndTime);
    end;
  end;
end;

function TPlannerWeekViewEh.GetAllDayListItem(Index: Integer): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh(FAllDayList[Index]);
end;

function TPlannerWeekViewEh.GetInDayListItem(Index: Integer): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh(FInDayList[Index]);
end;

function TPlannerWeekViewEh.GetAllDayListCount: Integer;
begin
  Result := FAllDayList.Count;
end;

function TPlannerWeekViewEh.GetInDayListCount: Integer;
begin
  Result := FInDayList.Count;
end;

procedure TPlannerWeekViewEh.StartDateChanged;
begin
  inherited StartDateChanged;
  GridLayoutChanged;
end;

procedure TPlannerWeekViewEh.CalcPosByPeriod(AColStartTime, AStartTime, AEndTime: TDateTime;
  var AStartGridPos, AStopGridPos: Integer);
begin
  AStartGridPos := TimeToGridRolPos(AColStartTime, AStartTime);
  AStopGridPos := TimeToGridRolPos(AColStartTime, AEndTime);
end;

procedure TPlannerWeekViewEh.InitSpanItem(
  ASpanItem: TTimeSpanDisplayItemEh);
var
  i: Integer;
  StartTime: TDateTime;
begin
  for i := 0 to FDayCols-1 do
  begin
    StartTime := ColsStartTime[i];
    if (ASpanItem.PlanItem.StartTime >= StartTime) and
      (ASpanItem.PlanItem.StartTime < StartTime + 1) then
    begin
      CalcPosByPeriod(StartTime, ASpanItem.PlanItem.StartTime, ASpanItem.PlanItem.EndTime,
        ASpanItem.FStartGridRollPos, ASpanItem.FStopGridRolPos);
      ASpanItem.FGridColNum := i;
    end;
  end;
end;

procedure TPlannerWeekViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if (Cell.X >= FDataColsOffset) and (Cell.Y = FDayNameBarPos) then
    DayNamesCellClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
end;

procedure TPlannerWeekViewEh.PaintSpanItems;
begin
  DrawInDaySpanItems;
  DrawAllDaySpanItems;
end;

procedure TPlannerWeekViewEh.DrawInDaySpanItems;
var
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  SpanDrawRect: TRect;
  RestRgn: HRgn;
  RestRect: TRect;
  GridClientRect: TRect;
begin
  GridClientRect := ClientRect;
  if InDayListCount > 0 then
  begin
    RestRect := Rect(HorzAxis.FixedBoundary, VertAxis.FixedBoundary, HorzAxis.ContraStart, VertAxis.ContraStart);
    if UseRightToLeftAlignment then
      RestRect := RightToLeftReflectRect(ClientRect, RestRect);
    RestRgn := SelectClipRectangleEh(Canvas, RestRect);
    try
      for i := 0 to InDayListCount-1 do
      begin
        SpanItem := InDayList[i];
        SpanDrawRect := SpanItem.BoundRect;
        OffsetRect(SpanDrawRect,
          HorzAxis.FixedBoundary-HorzAxis.RolStartVisPos,
          VertAxis.FixedBoundary-VertAxis.RolStartVisPos);
        if RectsIntersected(GridClientRect, SpanDrawRect) then
        begin
          if UseRightToLeftAlignment then
            SpanDrawRect := RightToLeftReflectRect(ClientRect, SpanDrawRect);
          DrawSpanItem(SpanItem, SpanDrawRect);
        end;
      end;
    finally
      RestoreClipRectangleEh(Canvas, RestRgn);
    end;
  end;
end;

procedure TPlannerWeekViewEh.DrawAllDaySpanItems;
var
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  SpanDrawRect: TRect;
  AllDayRow: Integer;
  GridClientRect: TRect;
  RestRgn: HRgn;
  RestRect: TRect;
begin
  GridClientRect := ClientRect;
  if AllDayListCount > 0 then
  begin
    RestRect := Rect(HorzAxis.FixedBoundary, 0, HorzAxis.ContraStart, VertAxis.FixedBoundary);
    if UseRightToLeftAlignment then
      RestRect := RightToLeftReflectRect(ClientRect, RestRect);
    RestRgn := SelectClipRectangleEh(Canvas, RestRect);
    for i := 0 to AllDayListCount-1 do
    begin
      SpanItem := AllDayList[i];
      SpanDrawRect := SpanItem.BoundRect;
      if FDayNameBarPos >= 0
        then AllDayRow := FDayNameBarPos + 1
        else AllDayRow := FResourceAxisPos + 1;


      OffsetRect(SpanDrawRect, -HorzAxis.RolStartVisPos, VertAxis.GetFixedCelPos(AllDayRow));
      if RectsIntersected(GridClientRect, SpanDrawRect) then
      begin
        if UseRightToLeftAlignment then
          SpanDrawRect := RightToLeftReflectRect(ClientRect, SpanDrawRect);
        DrawSpanItem(SpanItem, SpanDrawRect);
      end;
    end;
    RestoreClipRectangleEh(Canvas, RestRgn);
  end;
end;

procedure TPlannerWeekViewEh.DayNamesCellClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  DayNoDate: TDateTime;
begin
  DayNoDate := StartDate + (Cell.X-1) mod FBarsPerRes;
  if DateOf(DayNoDate) <> DateOf(CurrentTime) then
    CurrentTime := DayNoDate;

  PlannerControl.ViewMode := pdrmDayEh;
end;

function TPlannerWeekViewEh.CellToDateTime(ACol, ARow: Integer): TDateTime;
var
  DataCell: TGridCoord;
begin
  DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));

  Result := StartDate;
  if DataCell.X >= 0 then
    Result := NormalizeDateTime(IncDay(Result, DataCell.X mod FBarsPerRes * FColDaysLength ));
  if DataCell.Y >= 0 then
    Result := NormalizeDateTime(IncMinute(Result, DataCell.Y * FRowMinutesLength) + FGridStartWorkingTime);
end;

function TPlannerWeekViewEh.GetDataCellTimeLength: TDateTime;
begin
  Result := FBarTimeLength;
end;

function TPlannerWeekViewEh.TimeToGridRolPos(AColStartTime, ATime: TDateTime): Integer;
var
  StartWorkingTimeGridLen: Integer;
begin
  if ATime < AColStartTime then
    Result := 0
  else if ATime >= AColStartTime + 1 then
    Result := VertAxis.RolLen
  else
    Result := Round(TimeOf(ATime) / FBarTimeLength * DefaultRowHeight);
  StartWorkingTimeGridLen := Round(FGridStartWorkingTime / FBarTimeLength) * DefaultRowHeight;
  Result := Result - StartWorkingTimeGridLen;
end;

procedure TPlannerWeekViewEh.UpdateDummySpanItemSize(MousePos: TPoint);
var
  FixedMousePos: TPoint;
  ACell: TGridCoord;
  ANewTime: TDateTime;
  ATimeLen: TDateTime;
  ResViewIdx: Integer;
  AResource: TPlannerResourceEh;
  OldInAllDays, NewInAllDays: Boolean;
  NewEndTime: TDateTime;
begin
  FixedMousePos := MousePos;
  if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    FixedMousePos.X := FixedMousePos.X + FTopLeftSpanShift.cx;
    FixedMousePos.Y := FixedMousePos.Y + FTopLeftSpanShift.cy;
  end;
  if FPlannerState = psSpanButtomSizingEh then
  begin
    ACell := CalcCoordFromPoint(FixedMousePos.X, FixedMousePos.Y+DefaultRowHeight div 2);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    if (FDummyPlanItem.StartTime < ANewTime) and (FDummyPlanItem.EndTime <> ANewTime) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.EndTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged();
    end;
  end else if FPlannerState = psSpanTopSizingEh then
  begin
    ACell := CalcCoordFromPoint(FixedMousePos.X, FixedMousePos.Y+DefaultRowHeight div 2);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    if (FDummyPlanItem.EndTime > ANewTime) and (FDummyPlanItem.StartTime <> ANewTime) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged();
    end;
  end else if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    ACell := CalcCoordFromPoint(FixedMousePos.X, FixedMousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;

    if ACell.Y < FixedRowCount
      then NewInAllDays := True
      else NewInAllDays := False;
    if IsPlanItemHitAllGridArea(FDummyPlanItem)
      then OldInAllDays := True
      else OldInAllDays := False;
    if (NewInAllDays = OldInAllDays) and (NewInAllDays = False) then
    begin
      if (FDummyPlanItem.StartTime <> ANewTime) or
         (AResource <> FDummyPlanItem.Resource) then
      begin
        ATimeLen :=  FDummyPlanItem.EndTime - FDummyPlanItem.StartTime;
        FDummyCheckPlanItem.Assign(FDummyPlanItem);
        FDummyCheckPlanItem.StartTime := ANewTime;
        FDummyCheckPlanItem.EndTime := FDummyCheckPlanItem.StartTime + ATimeLen;
        FDummyCheckPlanItem.Resource := AResource;
        CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);

        PlannerDataSourceChanged;
      end;
    end else if (NewInAllDays = OldInAllDays) and (NewInAllDays = True) then
    begin
      if (FDummyPlanItem.StartTime <> ANewTime) or
         (AResource <> FDummyPlanItem.Resource) then
      begin
        ATimeLen :=  FDummyPlanItem.EndTime - FDummyPlanItem.StartTime;
        FDummyCheckPlanItem.StartTime := ANewTime;
        FDummyCheckPlanItem.EndTime := FDummyCheckPlanItem.StartTime + ATimeLen;
        FDummyCheckPlanItem.Resource := AResource;
        CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
        PlannerDataSourceChanged;
      end;
    end else if (NewInAllDays = True) and (OldInAllDays = False) then
    begin
      if IsPlanItemHitAllGridArea(FDummyPlanItemFor) then
      begin
        FDummyCheckPlanItem.StartTime := FDummyPlanItemFor.StartTime;
        FDummyCheckPlanItem.EndTime := FDummyPlanItemFor.EndTime;
        FDummyCheckPlanItem.Resource := AResource;
        CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
        PlannerDataSourceChanged;
      end else
      begin
        FDummyCheckPlanItem.StartTime := FDummyPlanItemFor.StartTime;
        FDummyCheckPlanItem.EndTime := FDummyPlanItemFor.EndTime;
        FDummyCheckPlanItem.Resource := AResource;
        FDummyCheckPlanItem.AllDay := True;
        CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
        PlannerDataSourceChanged;
      end;
    end else if (NewInAllDays = False) and (OldInAllDays = True) then
    begin
      if IsPlanItemHitAllGridArea(FDummyPlanItemFor) then
      begin
        FDummyCheckPlanItem.StartTime := ANewTime;
        NewEndTime := IncHour(FDummyPlanItem.StartTime, 1);
        if NewEndTime < FDummyCheckPlanItem.StartTime then
          NewEndTime := IncHour(FDummyCheckPlanItem.StartTime, 1);
        FDummyCheckPlanItem.EndTime := NewEndTime;
        FDummyCheckPlanItem.AllDay := False;
        FDummyCheckPlanItem.Resource := AResource;
        CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
        PlannerDataSourceChanged;
      end else
      begin
        ATimeLen :=  FDummyPlanItem.EndTime - FDummyPlanItem.StartTime;
        FDummyCheckPlanItem.StartTime := ANewTime;
        FDummyCheckPlanItem.EndTime := FDummyCheckPlanItem.StartTime + ATimeLen;
        FDummyCheckPlanItem.Resource := AResource;
        FDummyCheckPlanItem.AllDay := False;
        CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
        PlannerDataSourceChanged;
      end;
    end;
    ShowMoveHintWindow(FDummyPlanItem, MousePos);
  end;
end;

function TPlannerWeekViewEh.GetColsStartTime(ADayCol: Integer): TDateTime;
begin
  Result := StartDate + ADayCol;
end;

function TPlannerWeekViewEh.GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
begin
  Result := pcpWeekEh;
end;

function TPlannerWeekViewEh.GetPeriodCaption: String;
var
  StartDate, EndDate: TDateTime;
begin
  GetViewPeriod(StartDate, EndDate);
  Result := DateRangeToStr(StartDate, EndDate);
end;

procedure TPlannerWeekViewEh.SetGridShowHours;
var
  h, m, s, ms: Word;
begin
  if ShowWorkingTimeOnly then
  begin
    DecodeTime(PlannerControl.WorkingTimeStart, h, m, s, ms);
    FGridStartWorkingTime := EncodeTime(h, 0, 0, 0);

    if PlannerControl.WorkingTimeEnd > 0 then
    begin
      DecodeTime(PlannerControl.WorkingTimeEnd, h, m, s, ms);
      FGridWorkingTimeLength := EncodeTime(h, 0, 0, 0) - FGridStartWorkingTime;
    end else
      FGridWorkingTimeLength := IncDay(0, 1) - FGridStartWorkingTime;
  end else
  begin
    FGridStartWorkingTime := EncodeTime(0, 0, 0, 0);
    FGridWorkingTimeLength := IncDay(0, 1);
  end;
end;

function TPlannerWeekViewEh.GetResourceAtCell(ACol,
  ARow: Integer): TPlannerResourceEh;
begin
  if (ACol-FDataColsOffset >= 0) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0) and
     ((ACol-FDataColsOffset) div FBarsPerRes < PlannerDataSource.Resources.Count)
  then
    Result := PlannerDataSource.Resources[(ACol-FDataColsOffset) div FBarsPerRes]
  else
    Result := nil;
end;

function TPlannerWeekViewEh.GetResourceViewAtCell(ACol, ARow: Integer): Integer;
begin
  if ACol < FDataColsOffset then
    Result := -1
  else if IsInterResourceCell(ACol, ARow) then
    Result := -1
  else
    Result := (ACol-FDataColsOffset) div FBarsPerRes;
end;

function TPlannerWeekViewEh.IsDayNameAreaNeedVisible: Boolean;
begin
  Result := True;
end;

function TPlannerWeekViewEh.IsInterResourceCell(ACol,
  ARow: Integer): Boolean;
begin
  if (ACol-FDataColsOffset >= 0) and
     (Length(FResourcesView) > 1)
  then
    Result := (ACol-FDataColsOffset) mod FBarsPerRes = FBarsPerRes - 1
  else
    Result := False;
end;

procedure TPlannerWeekViewEh.SetShowWorkingTimeOnly(const Value: Boolean);
begin
  if FShowWorkingTimeOnly <> Value then
  begin
    FShowWorkingTimeOnly := Value;
    PlannerDataSourceChanged;
  end;
end;

procedure TPlannerWeekViewEh.CalcRolRows;
begin
  FRolRowCount := Round(FGridWorkingTimeLength / FBarTimeLength);
end;

function TPlannerWeekViewEh.DefaultHoursBarSize: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := HoursBarArea.Font;
    Result := Canvas.TextWidth('11111');
  end else
    Result := 45;
end;

function TPlannerWeekViewEh.CreateHoursBarArea: THoursBarAreaEh;
begin
  Result := THoursVertBarAreaEh.Create(Self);
end;

function TPlannerWeekViewEh.GetHoursColArea: THoursVertBarAreaEh;
begin
  Result := THoursVertBarAreaEh(inherited HoursBarArea);
end;

procedure TPlannerWeekViewEh.SetHoursColArea(const Value: THoursVertBarAreaEh);
begin
  inherited HoursBarArea := Value;
end;

function TPlannerWeekViewEh.CreateDayNameArea: TDayNameAreaEh;
begin
  Result := TDayNameVertAreaEh.Create(Self);
end;

function TPlannerWeekViewEh.GetDayNameArea: TDayNameVertAreaEh;
begin
  Result := TDayNameVertAreaEh(inherited DayNameArea);
end;

procedure TPlannerWeekViewEh.SetDayNameArea(const Value: TDayNameVertAreaEh);
begin
  inherited DayNameArea := Value;
end;

function TPlannerWeekViewEh.GetDataBarsArea: TDataBarsVertAreaEh;
begin
  Result := TDataBarsVertAreaEh(inherited DataBarsArea);
end;

procedure TPlannerWeekViewEh.SetBarTimeInterval(
  const Value: TPlannerBarTimeIntervalEh);
begin
  if FBarTimeInterval <> Value then
  begin
    FBarTimeInterval := Value;
    FBarsPerHour := BarsPerHourIntervalArr[FBarTimeInterval];
    FBarTimeLength := EncodeTime(1, 0, 0, 0) / FBarsPerHour;
    FRowMinutesLength := 60 div FBarsPerHour;
    PlannerDataSourceChanged;
  end;
end;

procedure TPlannerWeekViewEh.SetDataBarsArea(const Value: TDataBarsVertAreaEh);
begin
  inherited DataBarsArea := Value;
end;

function TPlannerWeekViewEh.GetResourceCaptionArea: TResourceVertCaptionAreaEh;
begin
  Result := TResourceVertCaptionAreaEh(inherited ResourceCaptionArea);
end;

procedure TPlannerWeekViewEh.SetResourceCaptionArea(
  const Value: TResourceVertCaptionAreaEh);
begin
  inherited ResourceCaptionArea :=  Value;
end;

function TPlannerWeekViewEh.CreateResourceCaptionArea: TResourceCaptionAreaEh;
begin
  Result := TResourceVertCaptionAreaEh.Create(Self);
end;

procedure TPlannerWeekViewEh.GetCurrentTimeLineRect(var CurTLRect: TRect);
var
  SecOfDay: LongWord;
  InRolPos: Int64;
  ScreenPos: Integer;
begin
  if (Today >= DateOf(StartDate)) and (Today < DateOf(StartDate+FDayCols)) then
  begin
    SecOfDay := SecondOfTheDay(Now);
    InRolPos := Round(VertAxis.RolLen * SecOfDay / (24 * 60 * 60));
    ScreenPos := InRolPos - VertAxis.RolStartVisPos + VertAxis.FixedBoundary;
    CurTLRect := Rect(0, ScreenPos-1, HorzAxis.FixedBoundary, ScreenPos+2);
  end else
    CurTLRect := EmptyRect;
end;

procedure TPlannerWeekViewEh.ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF});
begin
  inherited ChangeScale(M, D{$IFDEF EH_LIB_24}, isDpiChange{$ENDIF});

  if M <> D then
  begin
    MinDayColWidth := MulDiv(FMinDayColWidth, M, D);
  end;
end;

{ TPlannerDayViewEh }

constructor TPlannerDayViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDayCols := 1;
  HorzScrollBar.VisibleMode := sbNeverShowEh;
end;

destructor TPlannerDayViewEh.Destroy;
begin
  inherited Destroy;
end;

function TPlannerDayViewEh.GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
begin
  Result := pcpDayEh;
end;

function TPlannerDayViewEh.IsDayNameAreaNeedVisible: Boolean;
begin
  Result := not IsResourceCaptionNeedVisible;
end;

procedure TPlannerDayViewEh.StartDateChanged;
begin
  inherited StartDateChanged;
  FFirstGridDayNum := DayOfWeek(StartDate);
end;

{ TPlannerMonthViewEh }

constructor TPlannerMonthViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataColsOffset := 1;
  FDataRowsOffset := 1;
  HorzScrollBar.VisibleMode := sbNeverShowEh;
  VertScrollBar.VisibleMode := sbNeverShowEh;
  FMinDayColWidth := 50;
  FDataColsFor1Res := 7;
  FSortedSpans := TObjectListEh.Create;
  FWeekColArea := TWeekBarAreaEh.Create(Self);
end;

destructor TPlannerMonthViewEh.Destroy;
begin
  FreeAndNil(FSortedSpans);
  FreeAndNil(FWeekColArea);
  inherited Destroy;
end;

procedure TPlannerMonthViewEh.ClearSpanItems;
begin
  inherited ClearSpanItems;
  if FSortedSpans <> nil then
  begin
    FSortedSpans.Clear;
  end;
end;

procedure TPlannerMonthViewEh.BuildGridData;
begin
  inherited BuildGridData;
  BuildMonthGridMode;
  RealignGridControls;
end;

procedure TPlannerMonthViewEh.BuildMonthGridMode;
var
  ColWidth, FitGap: Integer;
  RowHeight: Integer;
  i: Integer;
  Groups: Integer;
  ColGroups: Integer;
  ic: Integer;
  ARecNoColWidth: Integer;
  ADataColCount: Integer;
  AFixedRowCount: Integer;
begin
  ClearGridCells;
  FHoursBarIndex := -1;
  if FWeekColArea = nil then Exit;

  AFixedRowCount := TopGridLineCount;

  if ResourceCaptionArea.Visible then
  begin
    if (PlannerDataSource <> nil)
      then ColGroups := PlannerDataSource.Resources.Count
      else ColGroups := 0;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;
    Groups := ColGroups;
    FResourceAxisPos := AFixedRowCount;
    FDataRowsOffset := AFixedRowCount + 1;
  end else
  begin
    if (PlannerDataSource <> nil)
      then ColGroups := PlannerDataSource.Resources.Count
      else ColGroups := 0;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;
    Groups := ColGroups;
    FResourceAxisPos := -1;
    FDataRowsOffset := AFixedRowCount;
  end;

  if DayNameArea.Visible then
  begin
    Inc(FDataRowsOffset);
    FDayNameBarPos := FDataRowsOffset-1;
  end else
    FDayNameBarPos := -1;

  if WeekColArea.Visible then
  begin
    FixedColCount := 1;
    FDataColsOffset := 1;
    FWeekColIndex := 0;
  end else
  begin
    FixedColCount := 0;
    FDataColsOffset := 0;
    FWeekColIndex := -1;
  end;

  FixedRowCount := FDataRowsOffset;

  ADataColCount := 7 * ColGroups + (ColGroups-1);
  ColCount := ADataColCount + FDataColsOffset;
  RowCount := FixedRowCount + 6;

  SetGridSize(ColCount, RowCount);
  if HandleAllocated then
  begin
    if TopGridLineCount > 0 then
      RowHeights[FTopGridLineIndex] := 1;

    if FResourceAxisPos >= 0 then
      RowHeights[FResourceAxisPos] := ResourceCaptionArea.GetActualSize;

    if FDayNameBarPos >= 0 then
      RowHeights[FDayNameBarPos] := DayNameArea.GetActualSize;
  end;

  if FWeekColIndex >= 0 then
  begin
    ARecNoColWidth := WeekColArea.GetActualSize;
    ColWidths[FWeekColIndex] := ARecNoColWidth;
    FShowWeekNoCaption := CalcShowKeekNoCaption((GridClientHeight - VertAxis.FixedBoundary) div 6);
  end else
  begin
    ARecNoColWidth := 0;
  end;

  if Groups > 0
    then FBarsPerRes := 8
    else FBarsPerRes := 7;

  ColWidth := (GridClientWidth - ARecNoColWidth - (ColGroups-1)*3) div (ADataColCount-(ColGroups-1));
  if ColWidth < MinDayColWidth then
  begin
    ColWidth := MinDayColWidth;
    HorzScrollBar.VisibleMode := sbAutoShowEh;
    FitGap := 0;
  end else
  begin
    HorzScrollBar.VisibleMode := sbNeverShowEh;
    FitGap := (GridClientWidth - ARecNoColWidth - (ColGroups-1)*3) mod (ADataColCount-(ColGroups-1));
  end;

  for i := FDataColsOffset to ColCount-1 do
  begin
    if IsInterResourceCell(i, 0) then
    begin
      ColWidths[i] := 3;
    end else
    begin
      if FitGap > 0
        then ColWidths[i] := ColWidth + 1
        else ColWidths[i] := ColWidth;
      Dec(FitGap);
    end;
  end;

  RowHeight := (GridClientHeight - VertAxis.FixedBoundary) div 6;
  FitGap := (GridClientHeight - VertAxis.FixedBoundary) mod 6;
  for i := FixedRowCount to RowCount-1 do
  begin
    if FitGap > 0
      then RowHeights[i] := RowHeight + 1
      else RowHeights[i] := RowHeight;
    Dec(FitGap);
  end;

  while DayOfWeek(FStartDate) <> FFirstWeekDayNum do
    FStartDate := FStartDate - 1;

  if FixedColCount >= 0 then
    MergeCells(0, 0, FixedColCount-1, FixedRowCount-1);

  if FResourceAxisPos >= 0 then
  begin
    for i := 0 to ColGroups-1 do
    begin
      ic := FBarsPerRes * i;
      MergeCells(ic+FDataColsOffset, FResourceAxisPos, FBarsPerRes-2, 0);
    end;
  end;

end;

function TPlannerMonthViewEh.AdjustDate(const Value: TDateTime): TDateTime;
var
  y, m, d: Word;
begin
  DecodeDate(Value, y, m, d);
  Result := PlannerStartOfTheWeek(EncodeDate(y, m, 1));
end;

procedure TPlannerMonthViewEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if (Cell.X < FDataColsOffset) and (Cell.Y >= FDataRowsOffset) then
    WeekNoCellClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
end;

procedure TPlannerMonthViewEh.WeekNoCellClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
end;

function TPlannerMonthViewEh.CellToDateTime(ACol, ARow: Integer): TDateTime;
var
  DataCell: TGridCoord;
begin
  DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));
  Result := StartDate + DataCell.Y * (FDataColsFor1Res) + DataCell.X mod FBarsPerRes;
end;

procedure TPlannerMonthViewEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
var
  DataCell: TGridCoord;
  DataRow: Integer;
  Resource: TPlannerResourceEh;
  CellDate: TDateTime;
  CellDateNextRight: TDateTime;
  CellDateNextDown: TDateTime;
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
begin
  inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);

  Resource := nil;
  DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));

  GetCellType(ACol, ARow, CellType, ALocalCol, ALocalRow);

  CellDate := CellToDateTime(ACol, ARow);
  if (ACol < ColCount-1) and
     not IsInterResourceCell(ACol+1, ARow)
  then
    CellDateNextRight := CellToDateTime(ACol+1, ARow)
  else
    CellDateNextRight := CellDate;
  if (ARow < RowCount-1) and
     not IsInterResourceCell(ACol, ARow+1)
  then
    CellDateNextDown := CellToDateTime(ACol, ARow+1)
  else
    CellDateNextDown := CellDate;

  if ((ACol-FDataColsOffset >= 0) or ((ACol-FDataColsOffset = -1 ) and (BorderType = cbtRightEh))) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0) then
  begin
    Resource := GetResourceAtCell(ACol, ARow);
    if IsInterResourceCell(ACol, ARow) then
    begin
      if BorderType in [cbtTopEh, cbtBottomEh]  then
        IsDraw := False;
    end;
    if (Resource <> nil) and (Resource.DarkLineColor <> clDefault) then
        BorderColor := Resource.DarkLineColor;
  end;

  if IsDraw and (DataCell.X >= 0) and (DataCell.Y >= FixedRowCount) then
  begin
    DataRow := DataCell.Y - FixedRowCount;
    if (BorderType in [cbtTopEh, cbtBottomEh]) and (DataRow mod 2 = 1) then
      if (Resource <> nil) and (Resource.BrightLineColor <> clDefault)
        then BorderColor := Resource.BrightLineColor
        else BorderColor := ApproximateColor(BorderColor, Color, 255 div 2);
  end;

  if (pvoHighlightTodayEh in PlannerControl.Options) then
  begin
    if (CellType = pctDataCellEh) and
       (BorderType in [cbtBottomEh, cbtRightEh]) and
       (DateOf(CellDate) = DateOf(Today))
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end
    else if (BorderType = cbtRightEh) and
            (DateOf(CellDateNextRight) = DateOf(Today))
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end
    else if (BorderType = cbtBottomEh) and
            (DateOf(CellDateNextDown) = DateOf(Today))
    then
    begin
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
    end;
  end;
end;

procedure TPlannerMonthViewEh.GetCellType(ACol, ARow: Integer;
  var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer);
begin
  if ACol < FDataColsOffset then
  begin
    if ARow < FDataRowsOffset then
    begin
      CellType := pctTopLeftCellEh;
      ALocalCol := ACol;
      ALocalRow := ARow;
    end else
    begin
      CellType := pctWeekNoCellEh;
      ALocalCol := ACol;
      ALocalRow := ARow-FixedRowCount;
    end;
  end else if ARow = FResourceAxisPos then
  begin
    if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctResourceCaptionCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if ARow = FDayNameBarPos then
  begin
    if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctDayNameCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if ARow = FTopGridLineIndex then
  begin
    if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctTopGridLineCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else begin
    if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctDataCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end;
end;

procedure TPlannerMonthViewEh.DrawMonthViewDataCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawMonthViewDataCell(Self, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerMonthViewEh.DrawDataCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawMonthViewDataCell(ACol, ARow, ARect, State, DrawArgs);
end;

procedure TPlannerMonthViewEh.DrawWeekNoCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawMonthViewWeekNoCell(Self, Canvas, ARect, State, DrawArgs);
end;

function TPlannerMonthViewEh.DrawMonthDayWithWeekDayName: Boolean;
begin
  Result := False;
end;

procedure TPlannerMonthViewEh.GetWeekNoCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  WeekNoDate: TDateTime;
  s: String;
begin
  if ARow >= FDataRowsOffset then
  begin
    DrawArgs.FontName := WeekColArea.Font.Name;
    DrawArgs.FontColor := WeekColArea.Font.Color;
    DrawArgs.FontSize := WeekColArea.Font.Size;
    DrawArgs.FontStyle := WeekColArea.Font.Style;
    DrawArgs.BackColor := WeekColArea.GetActualColor;

    WeekNoDate := StartDate + 7 * (ARow-FDataRowsOffset);
    s := '';
    if FShowWeekNoCaption then
      s := EhLibLanguageConsts.PlannerWeekTextEh + ' ';
    s := s + IntToStr(WeekOfTheYear(WeekNoDate));
    DrawArgs.Value := WeekNoDate;
    DrawArgs.Text := s;
  end;
end;

procedure TPlannerMonthViewEh.GetDataCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; var State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  s: String;
  AddDats: Integer;
  InResCol: Integer;
  CellDate: TDateTime;

  function CheckDrawMon: Boolean;
  var
    AYear, AMonth, ADay: Word;
  begin
    Result := False;
    DecodeDate(FStartDate + AddDats, AYear, AMonth, ADay);
    if  (ACol = 0) and (ARow = 1) then
      Result := True
    else if ADay = 1 then
      Result := True;
  end;

begin
  InResCol := (ACol-FDataColsOffset) mod FBarsPerRes;
  AddDats := 7 * (ARow-FDataRowsOffset) + InResCol;
  if CheckDrawMon then
    s := FormatDateTime('D MMM', FStartDate + AddDats)
  else
    s := FormatDateTime('D', FStartDate + AddDats);

  DrawArgs.BackColor := CheckSysColor(Color);
  DrawArgs.FontName := WeekColArea.Font.Name;
  DrawArgs.FontColor := WeekColArea.Font.Color;
  DrawArgs.FontSize := WeekColArea.Font.Size;
  DrawArgs.FontStyle := WeekColArea.Font.Style;

  if FStartDate + AddDats = Date then
    Canvas.Font.Style := [fsBold];

  CellDate :=  CellToDateTime(ACol, ARow);
  DrawArgs.Resource := GetResourceAtCell(ACol, ARow);

  if (SelectedRange.FromDateTime < SelectedRange.ToDateTime) then
  begin
    if (SelectedRange.FromDateTime <= CellDate) and
       (CellDate < SelectedRange.ToDateTime) and
       (DrawArgs.Resource = SelectedRange.Resource)
    then
      State := State + [gdSelected];
  end;

  if (gdCurrent in State) or (gdSelected in State) then
  begin
    SetCellCanvasParams(ACol, ARow, ARect, State);
    DrawArgs.BackColor := Canvas.Brush.Color;
    DrawArgs.FontColor := Canvas.Font.Color;
  end else
  begin
    if IsWorkingDay(CellToDateTime(ACol, ARow)) then
      DrawArgs.BackColor := CheckSysColor(Color)
    else
    begin
      DrawArgs.Resource := GetResourceAtCell(ACol, ARow);
      DrawArgs.BackColor := GetResourceNonworkingTimeBackColor(DrawArgs.Resource, DrawArgs.BackColor, DrawArgs.FontColor);
   end;
  end;

  DrawArgs.Value := FStartDate + AddDats;
  DrawArgs.Text := s;
  DrawArgs.HorzMargin := 5;
  DrawArgs.VertMargin := 5;
  DrawArgs.Alignment := taRightJustify;
  DrawArgs.Layout := tlTop;
  DrawArgs.WordWrap := False;
end;


function TPlannerMonthViewEh.GetDataCellTimeLength: TDateTime;
begin
  Result := IncDay(0, 1);
end;

procedure TPlannerMonthViewEh.GetViewPeriod(var AStartDate,
  AEndDate: TDateTime);
begin
  AStartDate := StartDate;
  AEndDate := AStartDate + 6 * 7;
end;

function TPlannerMonthViewEh.IsDayNameAreaNeedVisible: Boolean;
begin
  Result := True;
end;

function TPlannerMonthViewEh.IsInterResourceCell(ACol, ARow: Integer): Boolean;
begin
  if (ACol-FDataColsOffset >= 0) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0)
  then
    Result := (ACol-FDataColsOffset) mod FBarsPerRes = FBarsPerRes - 1
  else
    Result := False;
end;

function TPlannerMonthViewEh.NextDate: TDateTime;
var
  y,m,d: Word;
begin
  Result := IncMonth(StartDate + 7, 1);
  DecodeDate(Result, y,m,d);
  Result := EncodeDate(y,m,1);
end;

function TPlannerMonthViewEh.PriorDate: TDateTime;
var
  y,m,d: Word;
begin
  Result := IncMonth(StartDate + 7, -1);
  DecodeDate(Result, y,m,d);
  Result := EncodeDate(y,m,1);
end;

function TPlannerMonthViewEh.AppendPeriod(ATime: TDateTime;
  Periods: Integer): TDateTime;
begin
  Result := IncMonth(ATime, Periods);
end;

procedure TPlannerMonthViewEh.SetDisplayPosesSpanItemsForResource(AResource: TPlannerResourceEh; Index: Integer);
var
  ADCol, ADRow: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  ASpanRect: TRect;
  ACellDate: TDateTime;
  AStartCellPos, ACellStartPos: TPoint;
  ASpanWidth: Integer;
  InRowStartDate: TDateTime;
  InRowBoundDate: TDateTime;
  LeftIndent: Integer;
  AStartViewDate, AEndViewDate: TDateTime;
  ASpanBound: Integer;

  function CalcSpanWidth(AStartCol, ALenght: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i:= AStartCol to AStartCol+ALenght-1 do
      Result := Result + ColWidths[i];
  end;

begin
  AStartCellPos := Point(HorzAxis.FixedBoundary, VertAxis.FixedBoundary);
  ACellStartPos := AStartCellPos;
  GetViewPeriod(AStartViewDate, AEndViewDate);
  for ADCol := 0 to FDataColsFor1Res - 1 do
  begin
    ACellStartPos.Y := AStartCellPos.Y;
    for ADRow := 0 to RowCount - FDataRowsOffset - 1 do
    begin
      InRowStartDate := CellToDateTime(FDataColsOffset, ADRow + FDataRowsOffset);
      InRowBoundDate := IncDay(InRowStartDate, FDataColsFor1Res);
      for i := 0 to SpanItemsCount-1 do
      begin
        SpanItem := SortedSpan[i];
        if SpanItem.PlanItem.Resource <> AResource then Continue;

        ACellDate := CellToDateTime(ADCol + FDataColsOffset, ADRow + FDataRowsOffset);
        if (ACellDate <= SpanItem.StartTime) and
           (ACellDate + 1 > SpanItem.StartTime) then
        begin
          if SpanItem.PlanItem.StartTime < ACellDate then
          begin
            LeftIndent := 0;
            if (SpanItem.PlanItem.StartTime < StartDate) and (SpanItem.StartTime = StartDate) then
              SpanItem.FDrawBackOutInfo := True;
          end else
          begin
            LeftIndent := 5;
            SpanItem.FAllowedInteractiveChanges := SpanItem.FAllowedInteractiveChanges + [sichSpanLeftSizingEh];
          end;
          ASpanRect.Left := ACellStartPos.X + LeftIndent;
          ASpanRect.Top :=  FDataDayNumAreaHeight + ACellStartPos.Y +
            SpanItem.InCellFromCol * FDefaultLineHeight;
          ASpanWidth := CalcSpanWidth(ADCol + FDataColsOffset, SpanItem.FStopGridRolPos - SpanItem.FStartGridRollPos);
          ASpanRect.Right := ASpanRect.Left + ASpanWidth - LeftIndent;
          if SpanItem.PlanItem.EndTime < InRowBoundDate then
          begin
            ASpanRect.Right := ASpanRect.Right - 5;
            SpanItem.FAllowedInteractiveChanges := SpanItem.FAllowedInteractiveChanges + [sichSpanRightSizingEh];
          end else
          begin
            if (SpanItem.PlanItem.EndTime > AEndViewDate) and (SpanItem.EndTime = AEndViewDate) then
              SpanItem.FDrawForwardOutInfo := True;
          end;
          ASpanRect.Bottom := ASpanRect.Top + FDefaultLineHeight;

          ASpanBound := ACellStartPos.Y + RowHeights[ADRow + FDataRowsOffset];
          if ASpanRect.Bottom > ASpanBound then
            SpanItem.FBoundRect := EmptyRect
          else
          begin
            OffsetRect(ASpanRect, -HorzAxis.FixedBoundary, -VertAxis.FixedBoundary);
            if ResourcesCount > 0 then
              OffsetRect(ASpanRect, FResourcesView[Index].GridOffset, 0);
            SpanItem.FBoundRect := ASpanRect;
          end;
        end;
      end;
      ACellStartPos.Y := ACellStartPos.Y + RowHeights[ADRow + FDataRowsOffset];
    end;
    ACellStartPos.X := ACellStartPos.X + ColWidths[ADCol + FDataColsOffset];
  end;
end;

procedure TPlannerMonthViewEh.SetDisplayPosesSpanItems;
var
  i: Integer;
begin
  SetResOffsets;
  if ResourcesCount > 0 then
  begin
    for i := 0 to PlannerDataSource.Resources.Count-1 do
      SetDisplayPosesSpanItemsForResource(PlannerDataSource.Resources[i], i);
    if FShowUnassignedResource then
      SetDisplayPosesSpanItemsForResource(nil, PlannerDataSource.Resources.Count);
  end else
    SetDisplayPosesSpanItemsForResource(nil, -1);
end;

procedure TPlannerMonthViewEh.SetGroupPosesSpanItems(Resource: TPlannerResourceEh);
var
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
  CurStack: TObjectListEh;
  CurList: TObjectListEh;
  CurColbarCount: Integer;
  FullEmpty: Boolean;

  procedure CheckPushOutStack(ABoundPos: Integer);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
  begin
    for i := 0 to CurStack.Count-1 do
    begin
      StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
      if (StackSpanItem <> nil) and (StackSpanItem.FStopGridRolPos <= ABoundPos) then
      begin
        CurList.Add(CurStack[i]);
        CurStack[i] := nil;
      end;
    end;

    FullEmpty := True;
    for i := 0 to CurStack.Count-1 do
      if CurStack[i] <> nil then
      begin
        FullEmpty := False;
        Break;
      end;

    if FullEmpty then
    begin
      CurColbarCount := 1;
      CurList.Clear;
      CurStack.Clear;
    end;
  end;

  procedure PushInStack(ASpanItem: TTimeSpanDisplayItemEh);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
    PlaceFound: Boolean;
  begin
    PlaceFound := False;
    if CurStack.Count > 0 then
    begin
      for i := 0 to CurStack.Count-1 do
      begin
        StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
        if StackSpanItem = nil then
        begin
          ASpanItem.FInCellCols := CurColbarCount;
          ASpanItem.FInCellFromCol := i;
          ASpanItem.FInCellToCol := i;
          CurStack[i] := ASpanItem;
          PlaceFound := True;
          Break;
        end;
      end;
    end;
    if not PlaceFound then
    begin
      if CurStack.Count > 0 then
      begin
        CurColbarCount := CurColbarCount + 1;
        for i := 0 to CurStack.Count-1 do
          TTimeSpanDisplayItemEh(CurStack[i]).FInCellCols := CurColbarCount;
        for i := 0 to CurList.Count-1 do
          TTimeSpanDisplayItemEh(CurList[i]).FInCellCols := CurColbarCount;
      end;
      ASpanItem.FInCellCols := CurColbarCount;
      ASpanItem.FInCellFromCol := CurColbarCount-1;
      ASpanItem.FInCellToCol := CurColbarCount-1;
      CurStack.Add(ASpanItem);
    end;
  end;

begin
  CurStack := TObjectListEh.Create;
  CurList := TObjectListEh.Create;
  CurColbarCount := 1;

  for i := 0 to SpanItemsCount-1 do
  begin
    SpanItem := SortedSpan[i];
    if SpanItem.PlanItem.Resource = Resource then
    begin
      CheckPushOutStack(SpanItem.FStartGridRollPos);
      PushInStack(SpanItem);
    end;
  end;
  CurStack.Free;
  CurList.Free;
end;

procedure TPlannerMonthViewEh.SetMinDayColWidth(const Value: Integer);
begin
  if FMinDayColWidth <> Value then
  begin
    FMinDayColWidth := Value;
    GridLayoutChanged;
  end;
end;

procedure TPlannerMonthViewEh.SetResOffsets;
var
  i: Integer;
begin
  for i := 0 to Length(FResourcesView)-1 do
    if i*FBarsPerRes < HorzAxis.RolCelCount then
    begin
      if i < ResourcesCount
        then FResourcesView[i].Resource := PlannerDataSource.Resources[i]
        else FResourcesView[i].Resource := nil;
      FResourcesView[i].GridOffset := HorzAxis.RolLocCelPosArr[i*FBarsPerRes];
      FResourcesView[i].GridStartAxisBar := i*FBarsPerRes;
    end;
end;

function TPlannerMonthViewEh.WeekNoColWidth: Integer;
begin
  Result := 0;
  if not HandleAllocated then Exit;
  Canvas.Font := WeekColArea.Font;
  Result := Canvas.TextHeight('Wg');
  Result := Result + 10;
end;

function TPlannerMonthViewEh.DefaultHoursBarSize: Integer;
begin
  Result := WeekNoColWidth;
end;

function TPlannerMonthViewEh.CalcShowKeekNoCaption(RowHeight: Integer): Boolean;
var
  MaxTextHeight: Integer;
begin
  Result := False;
  if not HandleAllocated then Exit;
  Canvas.Font := Font;
  Canvas.Font.Style := [fsBold];
  MaxTextHeight := Canvas.TextWidth('  WEEK 00  ');
  Result := MaxTextHeight < RowHeight;
end;

procedure TPlannerMonthViewEh.Resize;
begin
  inherited Resize;
  if HandleAllocated and ActiveMode then
  begin
    Canvas.Font := Font;
    FDataDayNumAreaHeight := Canvas.TextHeight('Wg') + 5;

    Canvas.Font := GetPlannerControl.TimeSpanParams.Font;
    FDefaultLineHeight := Canvas.TextHeight('Wg') + 3;

    SetDisplayPosesSpanItems;
  end;
  ResetDayNameFormat(2, 0);
end;

function TPlannerMonthViewEh.GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
begin
  Result := pcpMonthEh;
end;

function TPlannerMonthViewEh.GetPeriodCaption: String;
begin
  Result :=
    FormatDateTime('mmmm', StartDate + 7) + ' ' +
    FormatDateTime('yyyy', StartDate + 7);
end;

function TPlannerMonthViewEh.GetResourceAtCell(ACol,
  ARow: Integer): TPlannerResourceEh;
var
  ResIdx: Integer;
begin
  if (ACol-FDataColsOffset >= 0) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0)
  then
  begin
    ResIdx := (ACol-FDataColsOffset) div FBarsPerRes;
    if ResIdx < PlannerDataSource.Resources.Count then
      Result := PlannerDataSource.Resources[(ACol-FDataColsOffset) div FBarsPerRes]
    else
      Result := nil;
  end else
    Result := nil;
end;

procedure TPlannerMonthViewEh.CalcPosByPeriod(AStartTime, AEndTime: TDateTime;
  var AStartGridPos, AStopGridPos: Integer);
begin
  AStartGridPos := TimeToGridLineRolPos(AStartTime);
  AStopGridPos := TimeToGridLineRolPos(AEndTime);
  if DateOf(AEndTime) <> AEndTime then
    Inc(AStopGridPos);
end;

function TPlannerMonthViewEh.TimeToGridLineRolPos(ADateTime: TDateTime): Integer;
begin
  Result := DaysBetween(StartDate, ADateTime);
end;

procedure TPlannerMonthViewEh.InitSpanItem(
  ASpanItem: TTimeSpanDisplayItemEh);
begin
  CalcPosByPeriod(
    ASpanItem.StartTime, ASpanItem.EndTime,
    ASpanItem.FStartGridRollPos, ASpanItem.FStopGridRolPos);
  ASpanItem.FGridColNum := 0;
  ASpanItem.FAllowedInteractiveChanges := [sichSpanMovingEh];
  ASpanItem.FTimeOrientation := toHorizontalEh;
end;

procedure TPlannerMonthViewEh.SortPlanItems;
var
  i: Integer;
begin
  if FSortedSpans = nil then Exit;

  FSortedSpans.Clear;
  for i := 0 to SpanItemsCount-1 do
    FSortedSpans.Add(SpanItems[i]);

  FSortedSpans.Sort(CompareSpanItemFuncBySpan);
end;

function TPlannerMonthViewEh.GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh(FSortedSpans[Index]);
end;

procedure TPlannerMonthViewEh.ReadDivByWeekPlanItem(StartDate, BoundDate: TDateTime;
  APlanItem: TPlannerDataItemEh);
var
  SpanItem: TTimeSpanDisplayItemEh;
begin
  SpanItem := AddSpanItem(APlanItem);
  SpanItem.FPlanItem := APlanItem;
  SpanItem.FHorzLocating := brrlGridRolAreaEh;
  SpanItem.FVertLocating := brrlGridRolAreaEh;
  if APlanItem.StartTime < StartDate then
    SpanItem.StartTime := DateOf(StartDate)
  else
    SpanItem.StartTime := DateOf(APlanItem.StartTime);
  if APlanItem.EndTime > BoundDate then
    SpanItem.EndTime :=  DateOf(BoundDate)
  else if DateOf(APlanItem.EndTime) = APlanItem.EndTime then
    SpanItem.EndTime := DateOf(APlanItem.EndTime)
  else
    SpanItem.EndTime := DateOf(APlanItem.EndTime) + 1;
  InitSpanItem(SpanItem);
end;

procedure TPlannerMonthViewEh.ReadPlanItem(APlanItem: TPlannerDataItemEh);
var
  i: Integer;
  WeekBoundDate: TDateTime;
begin
  for i := 0 to 5 do
  begin
    WeekBoundDate := StartDate + i*7 + 7;
    if (APlanItem.StartTime < WeekBoundDate) and (APlanItem.EndTime > WeekBoundDate - 7) then
      ReadDivByWeekPlanItem(WeekBoundDate - 7, WeekBoundDate, APlanItem);
  end;
end;

procedure TPlannerMonthViewEh.InitSpanItemMoving(
  SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint);
var
  ACell: TGridCoord;
  ACellTime: TDateTime;
begin
  ACell := MouseCoord(MousePos.X, MousePos.Y);
  ACellTime := CellToDateTime(ACell.X, ACell.Y);
  FMovingDaysShift := DaysBetween(DateOf(SpanItem.PlanItem.StartTime), DateOf(ACellTime));
end;

procedure TPlannerMonthViewEh.UpdateDummySpanItemSize(MousePos: TPoint);
var
  ACell: TGridCoord;
  ANewTime: TDateTime;
  ATimeLen: TDateTime;
  ResViewIdx: Integer;
  AResource: TPlannerResourceEh;
begin
  if FPlannerState = psSpanRightSizingEh then
  begin
    ACell := MouseCoord(MousePos.X, MousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    ANewTime := IncDay(ANewTime);
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;
    if (FDummyPlanItem.EndTime <> ANewTime) and
       (FDummyPlanItem.StartTime < ANewTime) and
       (AResource = FDummyPlanItem.Resource) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.EndTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged;
    end;
  end else if FPlannerState = psSpanLeftSizingEh then
  begin
    ACell := MouseCoord(MousePos.X, MousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;
    if (FDummyPlanItem.StartTime <> ANewTime) and
       (FDummyPlanItem.EndTime > ANewTime) and
       (AResource = FDummyPlanItem.Resource) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged;
    end;
  end else if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    ACell := MouseCoord(MousePos.X, MousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y) - FMovingDaysShift;
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;

    if (FDummyPlanItem.StartTime <> ANewTime) or
       (AResource <> FDummyPlanItem.Resource) then
    begin
      ATimeLen :=  FDummyPlanItem.EndTime - FDummyPlanItem.StartTime;
      ANewTime := DateOf(ANewTime) + TimeOf(FDummyPlanItem.StartTime);

      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime;
      FDummyCheckPlanItem.EndTime := FDummyCheckPlanItem.StartTime + ATimeLen;
      FDummyCheckPlanItem.Resource := AResource;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);

      PlannerDataSourceChanged;
    end;
    ShowMoveHintWindow(FDummyPlanItem, MousePos);
  end;
end;

function TPlannerMonthViewEh.GetResourceViewAtCell(ACol, ARow: Integer): Integer;
begin
  if ACol < FDataColsOffset then
    Result := -1
  else if IsInterResourceCell(ACol, ARow) then
    Result := -1
  else
    Result := (ACol-FDataColsOffset) div FBarsPerRes;
end;

function TPlannerMonthViewEh.NewItemParams(var StartTime, EndTime: TDateTime;
  var Resource: TPlannerResourceEh): Boolean;
begin
  if SelectedRange.FromDateTime < SelectedRange.ToDateTime then
  begin
    StartTime := SelectedRange.FromDateTime;
    EndTime := SelectedRange.ToDateTime;
  end else
  begin
    StartTime := CellToDateTime(Col, Row);
    EndTime := StartTime + EncodeTime(0, 30, 0, 0);
  end;
  Resource :=  GetResourceAtCell(Col, Row);
  Result := True;
end;

procedure TPlannerMonthViewEh.SetWeekColArea(const Value: TWeekBarAreaEh);
begin
  FWeekColArea.Assign(Value);
end;

function TPlannerMonthViewEh.GetDayNameArea: TDayNameVertAreaEh;
begin
  Result := TDayNameVertAreaEh(inherited DayNameArea);
end;

procedure TPlannerMonthViewEh.SetDayNameArea(const Value: TDayNameVertAreaEh);
begin
  inherited DayNameArea := Value;
end;

function TPlannerMonthViewEh.CreateDayNameArea: TDayNameAreaEh;
begin
  Result := TDayNameVertAreaEh.Create(Self);
end;

function TPlannerMonthViewEh.GetDataBarsArea: TDataBarsVertAreaEh;
begin
  Result := TDataBarsVertAreaEh(inherited DataBarsArea);
end;

procedure TPlannerMonthViewEh.SetDataBarsArea(const Value: TDataBarsVertAreaEh);
begin
  inherited DataBarsArea := Value;
end;

procedure TPlannerMonthViewEh.CMFontChanged(var Message: TMessage);
begin
  inherited;
  WeekColArea.RefreshDefaultFont;
end;

function TPlannerMonthViewEh.CreateResourceCaptionArea: TResourceCaptionAreaEh;
begin
  Result := TResourceVertCaptionAreaEh.Create(Self);
end;

function TPlannerMonthViewEh.CreateHoursBarArea: THoursBarAreaEh;
begin
  Result := THoursVertBarAreaEh.Create(Self);
end;

procedure TPlannerMonthViewEh.ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF});
begin
  inherited ChangeScale(M, D{$IFDEF EH_LIB_24}, isDpiChange{$ENDIF});

  if M <> D then
  begin
    MinDayColWidth := MulDiv(FMinDayColWidth, M, D);
  end;
end;

{ TAxisTimeBandPlannerViewEh }

constructor TPlannerAxisTimelineViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSortedSpans := TObjectListEh.Create;
  FDatesBarArea := CreateDatesBarArea;
  FBandOreintation := atboVerticalEh;
  FTimeAxis := VertAxis;
  FResourceAxis := HorzAxis;
  FRolLenInSecs := 1;
end;

destructor TPlannerAxisTimelineViewEh.Destroy;
begin
  FreeAndNil(FSortedSpans);
  FreeAndNil(FDatesBarArea);
  inherited Destroy;
end;

procedure TPlannerAxisTimelineViewEh.ClearSpanItems;
begin
  inherited ClearSpanItems;
  if FSortedSpans <> nil then
  begin
    FSortedSpans.Clear;
  end;
end;

procedure TPlannerAxisTimelineViewEh.SetRandeKind(const Value: TTimePlanRangeKind);
var
  AdjustedDate: TDateTime;
begin
  if FRandeKind <> Value then
  begin
    FRandeKind := Value;

    AdjustedDate := AdjustDate(CurrentTime);
    FStartDate := AdjustedDate;
    CalcLayouts;
    GridLayoutChanged;
    ResetLoadedTimeRange;
    StartDateChanged;
  end;
end;

procedure TPlannerAxisTimelineViewEh.SetBandOreintation(
  const Value: TAxisTimeBandOreintationEh);
begin
  if FBandOreintation <> Value then
  begin
    FBandOreintation := Value;
    if FBandOreintation = atboVerticalEh then
    begin
      FTimeAxis := VertAxis;
      FResourceAxis := HorzAxis;
    end else
    begin
      FTimeAxis := HorzAxis;
      FResourceAxis := VertAxis;
    end;

    CalcLayouts;
    GridLayoutChanged;
    ResetLoadedTimeRange;
    StartDateChanged;
  end;
end;

function TPlannerAxisTimelineViewEh.CreateDatesBarArea: TDatesBarAreaEh;
begin
 Result := nil;
end;

procedure TPlannerAxisTimelineViewEh.SetDatesBarArea(const Value: TDatesBarAreaEh);
begin
  FDatesBarArea.Assign(Value);
end;

procedure TPlannerAxisTimelineViewEh.CalcLayouts;
begin
  FBarsInBand := -1;

  case RangeKind of
    rkDayByHoursEh:
      begin
        FBarsInBand := 24;
        FCellsInBand := FBarsInBand * 2;
        FRolLenInSecs := SecondsBetween(StartDate, AppendPeriod(StartDate, 1));
        FDataColsOffset := 1;
        FDataRowsOffset := 2;
      end;
    rkWeekByHoursEh:
      begin
        FBarsInBand := 24 * 7;
        FCellsInBand := FBarsInBand * 2;
        FRolLenInSecs := SecondsBetween(StartDate, AppendPeriod(StartDate, 1));
        FDataColsOffset := 1;
        FDataRowsOffset := 2;
      end;
    rkWeekByDaysEh:
      begin
        FBarsInBand := 7;
        FCellsInBand := FBarsInBand;
        FRolLenInSecs := SecondsBetween(StartDate, AppendPeriod(StartDate, 1));
        FDataColsOffset := 1;
        FDataRowsOffset := 1;
      end;
    rkMonthByDaysEh:
      begin
        FBarsInBand := DaysInMonth(StartDate);
        FCellsInBand := FBarsInBand;
        FRolLenInSecs := SecondsBetween(StartDate, AppendPeriod(StartDate, 1));
        FDataColsOffset := 1;
        FDataRowsOffset := 1;
      end;
  end;
end;

function TPlannerAxisTimelineViewEh.NextDate: TDateTime;
begin
  Result := AppendPeriod(StartDate, 1);
end;

procedure TPlannerAxisTimelineViewEh.PlannerStateChanged(AOldState: TPlannerStateEh);
begin
  inherited PlannerStateChanged(AOldState);
  StopSpanMoveSliding;
end;

function TPlannerAxisTimelineViewEh.PriorDate: TDateTime;
begin
  Result := AppendPeriod(StartDate, -1);
end;

function TPlannerAxisTimelineViewEh.AppendPeriod(ATime: TDateTime;
  Periods: Integer): TDateTime;
begin
  case RangeKind of
    rkDayByHoursEh:
      Result := IncDay(ATime, Periods);
    rkWeekByHoursEh:
      Result := IncWeek(ATime, Periods);
    rkWeekByDaysEh:
      Result := IncWeek(ATime, Periods);
    rkMonthByDaysEh:
      Result := IncMonth(ATime, Periods);
  else
    raise Exception.Create('RangeKind is not supported (' +
      GetEnumName(TypeInfo(TTimePlanRangeKind), Ord(RangeKind)) + ')');
  end;
end;

function TPlannerAxisTimelineViewEh.GetPeriodCaption: String;
var
  StartDate, EndDate: TDateTime;
begin
  GetViewPeriod(StartDate, EndDate);
  Result := DateRangeToStr(StartDate, EndDate);
end;

function TPlannerAxisTimelineViewEh.GetResourceAtCell(ACol,
  ARow: Integer): TPlannerResourceEh;
var
  ResViewIdx: Integer;
begin
  ResViewIdx := GetResourceViewAtCell(ACol, ARow);
  if (ResViewIdx >= 0) and (PlannerDataSource <> nil) and (ResViewIdx < PlannerDataSource.Resources.Count) then
    Result := PlannerDataSource.Resources[ResViewIdx]
  else
    Result := nil;
end;

procedure TPlannerAxisTimelineViewEh.Resize;
begin
  inherited Resize;
  if HandleAllocated then
    SetDisplayPosesSpanItems;
end;

function TPlannerAxisTimelineViewEh.AdjustDate(
  const Value: TDateTime): TDateTime;
begin
  case RangeKind of
    rkDayByHoursEh:
      Result := DateOf(Value);
    rkWeekByHoursEh:
      Result := PlannerStartOfTheWeek(Value);
    rkWeekByDaysEh:
      Result := PlannerStartOfTheWeek(Value);
    rkMonthByDaysEh:
      Result := StartOfTheMonth(Value);
  else
    raise Exception.Create('RangeKind in not supported (' +
      GetEnumName(TypeInfo(TTimePlanRangeKind), Ord(RangeKind)) + ')');
  end;
end;

function TPlannerAxisTimelineViewEh.FullRedrawOnScroll: Boolean;
begin
  Result := True;
end;

procedure TPlannerAxisTimelineViewEh.BuildDaysGridData;
begin

end;

procedure TPlannerAxisTimelineViewEh.BuildHoursGridData;
begin

end;

function TPlannerAxisTimelineViewEh.DateTimeToGridRolPos(ADateTime: TDateTime): Integer;
begin
  case RangeKind of
    rkDayByHoursEh:
      Result := Round(Integer(FTimeAxis.RolLen) * SecondSpan(StartDate, ADateTime) / FRolLenInSecs);
    rkWeekByHoursEh:
      Result := Round(Integer(FTimeAxis.RolLen) * SecondSpan(StartDate, ADateTime) / FRolLenInSecs);
    rkWeekByDaysEh:
      Result := Round(Integer(FTimeAxis.RolLen) * SecondSpan(StartDate, ADateTime) / FRolLenInSecs);
    rkMonthByDaysEh:
      Result := Round(Integer(FTimeAxis.RolLen) * SecondSpan(StartDate, ADateTime) / FRolLenInSecs);
  else
    Result := 0;
  end;
end;

procedure TPlannerAxisTimelineViewEh.SetResOffsets;
begin

end;

procedure TPlannerAxisTimelineViewEh.BuildGridData;
begin
  inherited BuildGridData;
  CalcLayouts;
  if FBarsInBand <= 0 then Exit;
  ClearGridCells;
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
    BuildHoursGridData
  else
    BuildDaysGridData;
  RealignGridControls;
end;

procedure TPlannerAxisTimelineViewEh.CalcPosByPeriod(AStartTime, AEndTime: TDateTime;
  var AStartGridPos, AStopGridPos: Integer);
begin
  if AStartTime < StartDate then
    AStartTime := StartDate;
  if AEndTime > NextDate then
    AEndTime := NextDate;

  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    AStartGridPos := DateTimeToGridRolPos(AStartTime);
    AStopGridPos := DateTimeToGridRolPos(AEndTime);
  end else
  begin
    AStartGridPos := DateTimeToGridRolPos(DateOf(AStartTime));
    AStopGridPos := DateTimeToGridRolPos(DateOf(AEndTime+1));
  end;
end;

procedure TPlannerAxisTimelineViewEh.InitSpanItem(
  ASpanItem: TTimeSpanDisplayItemEh);
begin
  CalcPosByPeriod(
    ASpanItem.PlanItem.StartTime, ASpanItem.PlanItem.EndTime,
    ASpanItem.FStartGridRollPos, ASpanItem.FStopGridRolPos);
  ASpanItem.FGridColNum := 0;
end;

procedure TPlannerAxisTimelineViewEh.ReadPlanItem(APlanItem: TPlannerDataItemEh);
begin
  inherited ReadPlanItem(APlanItem);
end;

procedure TPlannerAxisTimelineViewEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
begin
  inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);
end;

function TPlannerAxisTimelineViewEh.GetDataBarsAreaDefaultBarSize: Integer;
begin
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
    Result := inherited GetDataBarsAreaDefaultBarSize
  else
  begin
    if HandleAllocated then
    begin
      Canvas.Font := Font;
      Result := Trunc(Canvas.TextHeight('Wg') * 10);
    end else
      Result := 16;
  end;
end;

function TPlannerAxisTimelineViewEh.GetDataCellTimeLength: TDateTime;
begin
  if (RangeKind in [rkDayByHoursEh, rkWeekByHoursEh]) then
    Result := IncHour(0, 1)
  else if (RangeKind in [rkWeekByDaysEh, rkMonthByDaysEh]) then
    Result := IncDay(0, 1)
  else
    Result := inherited GetDataCellTimeLength;
end;

function TPlannerAxisTimelineViewEh.GetDefaultDatesBarSize: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := DatesBarArea.Font;
    Result := Trunc(Canvas.TextHeight('Wg') * 1.5);
  end else
    Result := 10;
end;

function TPlannerAxisTimelineViewEh.GetDefaultDatesBarVisible: Boolean;
begin
  Result := True;
end;

function TPlannerAxisTimelineViewEh.GetGridOffsetForResource(
  Resource: TPlannerResourceEh): Integer;
var
  i: Integer;
begin
  Result := 0;
  if PlannerDataSource <> nil then
  begin
    if Resource <> nil then
    begin
      for i := 0 to PlannerDataSource.Resources.Count-1 do
        if PlannerDataSource.Resources[i] = Resource then
        begin
          Result := FResourcesView[i].GridOffset;
          Break;
        end
    end else if FShowUnassignedResource then
      Result := FResourcesView[Length(FResourcesView)-1].GridOffset;
  end;
end;

function TPlannerAxisTimelineViewEh.GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh(FSortedSpans[Index]);
end;

procedure TPlannerAxisTimelineViewEh.GetViewPeriod(var AStartDate,
  AEndDate: TDateTime);
begin
  AStartDate := StartDate;
  AEndDate := AppendPeriod(StartDate, 1);
end;

function TPlannerAxisTimelineViewEh.IsDayNameAreaNeedVisible: Boolean;
begin
  Result := False; 
end;

function TPlannerAxisTimelineViewEh.IsInterResourceCell(ACol,
  ARow: Integer): Boolean;
begin
  Result := False;
end;

procedure TPlannerAxisTimelineViewEh.RangeModeChanged;
begin
  inherited RangeModeChanged;
  HorzScrollBar.SmoothStep := True;
end;

procedure TPlannerAxisTimelineViewEh.SetGroupPosesSpanItems(
  Resource: TPlannerResourceEh);
var
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
  CurStack: TObjectListEh;
  CurList: TObjectListEh;
  CurColbarCount: Integer;
  FullEmpty: Boolean;

  procedure CheckPushOutStack(ABoundPos: Integer);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
  begin
    for i := 0 to CurStack.Count-1 do
    begin
      StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
      if (StackSpanItem <> nil) and (StackSpanItem.FStopGridRolPos <= ABoundPos) then
      begin
        CurList.Add(CurStack[i]);
        CurStack[i] := nil;
      end;
    end;

    FullEmpty := True;
    for i := 0 to CurStack.Count-1 do
      if CurStack[i] <> nil then
      begin
        FullEmpty := False;
        Break;
      end;

    if FullEmpty then
    begin
      CurColbarCount := 1;
      CurList.Clear;
      CurStack.Clear;
    end;
  end;

  procedure PushInStack(ASpanItem: TTimeSpanDisplayItemEh);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
    PlaceFound: Boolean;
  begin
    PlaceFound := False;
    if CurStack.Count > 0 then
    begin
      for i := 0 to CurStack.Count-1 do
      begin
        StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
        if StackSpanItem = nil then
        begin
          if BandOreintation = atboVerticalEh then
          begin
            ASpanItem.FInCellCols := CurColbarCount;
            ASpanItem.FInCellFromCol := i;
            ASpanItem.FInCellToCol := i;
          end else
          begin
            ASpanItem.FInCellRows := CurColbarCount;
            ASpanItem.FInCellFromRow := i;
            ASpanItem.FInCellToRow := i;
          end;
          CurStack[i] := ASpanItem;
          PlaceFound := True;
          Break;
        end;
      end;
    end;
    if not PlaceFound then
    begin
      if CurStack.Count > 0 then
      begin
        CurColbarCount := CurColbarCount + 1;
        for i := 0 to CurStack.Count-1 do
          if BandOreintation = atboVerticalEh then
            TTimeSpanDisplayItemEh(CurStack[i]).FInCellCols := CurColbarCount
          else
            TTimeSpanDisplayItemEh(CurStack[i]).FInCellRows := CurColbarCount;
        for i := 0 to CurList.Count-1 do
          if BandOreintation = atboVerticalEh then
            TTimeSpanDisplayItemEh(CurList[i]).FInCellCols := CurColbarCount
          else
            TTimeSpanDisplayItemEh(CurList[i]).FInCellRows := CurColbarCount;
      end;
      if BandOreintation = atboVerticalEh then
      begin
        ASpanItem.FInCellCols := CurColbarCount;
        ASpanItem.FInCellFromCol := CurColbarCount-1;
        ASpanItem.FInCellToCol := CurColbarCount-1;
      end else
      begin
        ASpanItem.FInCellRows := CurColbarCount;
        ASpanItem.FInCellFromRow := CurColbarCount-1;
        ASpanItem.FInCellToRow := CurColbarCount-1;
      end;
      CurStack.Add(ASpanItem);
    end;
  end;

begin
  CurStack := TObjectListEh.Create;
  CurList := TObjectListEh.Create;
  CurColbarCount := 1;

  for i := 0 to SpanItemsCount-1 do
  begin
    SpanItem := SortedSpan[i];
    if SpanItem.PlanItem.Resource = Resource then
    begin
      CheckPushOutStack(SpanItem.FStartGridRollPos);
      PushInStack(SpanItem);
    end;
  end;
  CurStack.Free;
  CurList.Free;
end;

procedure TPlannerAxisTimelineViewEh.SortPlanItems;
var
  i: Integer;
begin
  if FSortedSpans = nil then Exit;

  FSortedSpans.Clear;
  for i := 0 to SpanItemsCount-1 do
    FSortedSpans.Add(SpanItems[i]);

  FSortedSpans.Sort(CompareSpanItemFuncByPlan);
end;

procedure TPlannerAxisTimelineViewEh.StartDateChanged;
begin
  if RangeKind in [rkMonthByDaysEh] then
    GridLayoutChanged;
  inherited StartDateChanged;
end;

function TPlannerAxisTimelineViewEh.NewItemParams(var StartTime,
  EndTime: TDateTime; var Resource: TPlannerResourceEh): Boolean;
begin
  if SelectedRange.FromDateTime < SelectedRange.ToDateTime then
  begin
    StartTime := SelectedRange.FromDateTime;
    EndTime := SelectedRange.ToDateTime;
  end else
  begin
    StartTime := CellToDateTime(Col, Row);
    EndTime := StartTime + EncodeTime(0, 30, 0, 0);
  end;
  Resource :=  GetResourceAtCell(Col, Row);
  Result := True;
end;

function TPlannerAxisTimelineViewEh.GetCoveragePeriodType: TPlannerCoveragePeriodTypeEh;
begin
  case RangeKind of
    rkDayByHoursEh: Result := pcpDayEh;
    rkWeekByHoursEh: Result := pcpWeekEh;
    rkWeekByDaysEh: Result := pcpWeekEh;
    rkMonthByDaysEh: Result := pcpMonthEh;
  else
    Result := pcpDayEh;
  end;
end;

procedure TPlannerAxisTimelineViewEh.CoveragePeriod(var AFromTime,
  AToTime: TDateTime);
begin
  AFromTime := StartDate;
  case CoveragePeriodType of
    pcpDayEh: AToTime := StartDate + 1;
    pcpWeekEh: AToTime := IncWeek(StartDate);
    pcpMonthEh: AToTime := IncMonth(StartDate, 1);
  end;
end;

procedure TPlannerAxisTimelineViewEh.Paint;
begin
  FMasterGroupLineColor :=  ChangeRelativeColorLuminance(GridLineColors.GetDarkColor, -10);
  inherited Paint;
end;

{ TPlannerVertTimelineViewEh }

constructor TPlannerVertTimelineViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMinDataColWidth := -1;
end;

destructor TPlannerVertTimelineViewEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPlannerVertTimelineViewEh.GetCellType(ACol, ARow: Integer;
  var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer);
begin
  if (ARow >= FixedRowCount) and (ACol = FDayGroupCol) then
  begin
    CellType := pctDateBarEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ARow >= FixedRowCount) and (ACol = FHoursBarIndex) then
  begin
    CellType := pctTimeCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ARow >= FixedRowCount) and (ACol = FDaySplitModeCol) then
  begin
    CellType := pctDateCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ARow = FDayNameBarPos) and (ACol >= FixedColCount) then
  begin
    CellType := pctDayNameCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ARow = 0) and (ACol < FixedRowCount) then
  begin
    CellType := pctTopLeftCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ARow = FResourceAxisPos) and (ACol >= FixedColCount) then
  begin
     if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctResourceCaptionCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else
  begin
    CellType := pctDataCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end;
end;

procedure TPlannerVertTimelineViewEh.DrawDataCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  NextCellDateTime, CellDateTime: TDateTime;
begin

  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    CellDateTime := CellToDateTime(ACol, ARow);
    if ARow < RowCount-1
      then NextCellDateTime := CellToDateTime(ACol, ARow+1)
      else NextCellDateTime := CellDateTime;

    if DateOf(CellDateTime) <> DateOf(NextCellDateTime) then
    begin

      Canvas.Pen.Color := FMasterGroupLineColor;
      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today-1)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Left, ARect.Bottom-1), Point(ARect.Right, ARect.Bottom-1)]);

      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Left, ARect.Bottom-2), Point(ARect.Right, ARect.Bottom-2)]);

      ARect.Bottom := ARect.Bottom - 2;
    end;
  end;

  inherited DrawDataCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
end;

procedure TPlannerVertTimelineViewEh.DrawDateBar(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawTimeGroupCell(ACol, ARow, ARect, State, DrawArgs);
end;

procedure TPlannerVertTimelineViewEh.DrawDateCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawDaySplitModeDateCell(ACol, ARow, ARect, State, ARow-FixedRowCount, DrawArgs);
end;

procedure TPlannerVertTimelineViewEh.DrawTimeCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  NextCellDateTime, CellDateTime: TDateTime;
begin
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    CellDateTime := CellToDateTime(ACol, ARow);
    if ARow < RowCount-2
      then NextCellDateTime := CellToDateTime(ACol, ARow+2)
      else NextCellDateTime := CellDateTime;

    if DateOf(CellDateTime) <> DateOf(NextCellDateTime) then
    begin

      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today-1)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Left, ARect.Bottom-1), Point(ARect.Right, ARect.Bottom-1)]);

      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Left, ARect.Bottom-2), Point(ARect.Right, ARect.Bottom-2)]);

      ARect.Bottom := ARect.Bottom - 2;
    end;

    inherited DrawTimeCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
  end else
  begin
    PlannerControl.GetActualDrawStyle.DrawVertTimelineViewTimeDayCell(
      Self, Canvas, ARect, State, DrawArgs);
  end;
end;

procedure TPlannerVertTimelineViewEh.DrawTimeGroupCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Pen.Color := CheckSysColor(FMasterGroupLineColor);

  if (pvoHighlightTodayEh in PlannerControl.Options) and
     (DateOf(CellToDateTime(ACol, ARow)) = Today-1)
  then
    Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
  else
    Canvas.Pen.Color := FMasterGroupLineColor;
  DrawPolyline(Canvas, [Point(ARect.Left, ARect.Bottom-1), Point(ARect.Right, ARect.Bottom-1)]);

  if (pvoHighlightTodayEh in PlannerControl.Options) and
     (DateOf(CellToDateTime(ACol, ARow)) = Today)
  then
    Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
  else
    Canvas.Pen.Color := FMasterGroupLineColor;
  DrawPolyline(Canvas, [Point(ARect.Left, ARect.Bottom-2), Point(ARect.Right, ARect.Bottom-2)]);

  ARect.Bottom := ARect.Bottom - 2;

  PlannerControl.GetActualDrawStyle.DrawVertTimelineViewTimeGroupCell(
    Self, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerVertTimelineViewEh.GetDateBarDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  DrawDate: TDateTime;
begin
  DrawDate := CellToDateTime(ACol, ARow);
  DrawArgs.Text := FormatDateTime(FormatSettings.LongDateFormat, DrawDate) + ' ';
  DrawArgs.Value := DrawDate;

  DrawArgs.FontName := DatesBarArea.Font.Name;
  DrawArgs.FontColor := DatesBarArea.Font.Color;
  DrawArgs.FontSize := DatesBarArea.Font.Size;
  DrawArgs.FontStyle := DatesBarArea.Font.Style;
  DrawArgs.BackColor := DatesBarArea.GetActualColor;
  DrawArgs.Alignment := taCenter;
  DrawArgs.Layout := tlCenter;
  DrawArgs.Orientation := tohVertical;
end;

procedure TPlannerVertTimelineViewEh.DrawDaySplitModeDateCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ADataRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin

end;

procedure TPlannerVertTimelineViewEh.CalcLayouts;
begin
  inherited CalcLayouts;
  FDayGroupRows := -1;

  case RangeKind of
    rkDayByHoursEh:
      begin
        FDayGroupRows := 24 * 2;
      end;
    rkWeekByHoursEh:
      begin
        FDayGroupRows := 24 * 2;
      end;
    rkWeekByDaysEh:
      begin
        FDayGroupRows := 1;
      end;
    rkMonthByDaysEh:
      begin
        FDayGroupRows := 1;
      end;
  end;
end;

procedure TPlannerVertTimelineViewEh.CalcPosByPeriod(AStartTime,
  AEndTime: TDateTime; var AStartGridPos, AStopGridPos: Integer);
begin
  if AStartTime < StartDate then
    AStartTime := StartDate;
  if AEndTime > NextDate then
    AEndTime := NextDate;

  AStartGridPos := DateTimeToGridRolPos(AStartTime);
  AStopGridPos := DateTimeToGridRolPos(AEndTime);
end;

procedure TPlannerVertTimelineViewEh.InitSpanItem(
  ASpanItem: TTimeSpanDisplayItemEh);
var
  AStartTime, AEndTime: TDateTime;
begin
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    CalcPosByPeriod(
      ASpanItem.PlanItem.StartTime, ASpanItem.PlanItem.EndTime,
      ASpanItem.FStartGridRollPos, ASpanItem.FStopGridRolPos);
  end else
  begin
    AStartTime := DateOf(ASpanItem.PlanItem.StartTime);
    AEndTime := DateOf(ASpanItem.PlanItem.EndTime);
    if AEndTime <> DayOf(ASpanItem.PlanItem.EndTime) then
      AEndTime := IncDay(AEndTime);
    CalcPosByPeriod(AStartTime, AEndTime,
      ASpanItem.FStartGridRollPos, ASpanItem.FStopGridRolPos);
    ASpanItem.StartTime := AStartTime;
    ASpanItem.EndTime := AEndTime;
  end;
  ASpanItem.FGridColNum := 0;
  ASpanItem.FAllowedInteractiveChanges :=
    [sichSpanMovingEh, sichSpanTopSizingEh, sichSpanButtomSizingEh];
  ASpanItem.FTimeOrientation := toVerticalEh;
end;

procedure TPlannerVertTimelineViewEh.SetGroupPosesSpanItems(Resource: TPlannerResourceEh);
begin
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
    inherited SetGroupPosesSpanItems(Resource)
  else
    SetGroupPosesSpanItemsForDayStep(Resource);
end;

procedure TPlannerVertTimelineViewEh.SetGroupPosesSpanItemsForDayStep(
  Resource: TPlannerResourceEh);
var
  i: Integer;
  SpanItem: TTimeSpanDisplayItemEh;
  CurStack: TObjectListEh;
  CurList: TObjectListEh;
  CurColbarCount: Integer;
  FullEmpty: Boolean;
  InDayPos: Integer;
  InDayList: TObjectListEh;

  procedure ClearInDay();
  var
    i: Integer;
    InDaySpanItem: TTimeSpanDisplayItemEh;
  begin
    for i := 0 to InDayList.Count-1 do
    begin
      InDaySpanItem := TTimeSpanDisplayItemEh(InDayList[i]);
      InDaySpanItem.FInCellRows := InDayList.Count;
      InDaySpanItem.FInCellFromRow := i;
      InDaySpanItem.FInCellToRow := i;
    end;
    InDayList.Clear;
  end;

  procedure AddInDay(ASpanItem: TTimeSpanDisplayItemEh);
  var
    InStackDayItem: TTimeSpanDisplayItemEh;
  begin
    InStackDayItem := TTimeSpanDisplayItemEh(CurStack[InDayPos]);
    ASpanItem.FInCellCols := InStackDayItem.InCellCols;
    ASpanItem.FInCellFromCol := InDayPos;
    ASpanItem.FInCellToCol := InDayPos;
    InDayList.Add(ASpanItem);
  end;

  procedure CheckPushOutStack(ABoundPos: Integer);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
  begin
    for i := 0 to CurStack.Count-1 do
    begin
      StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
      if (StackSpanItem <> nil) and (StackSpanItem.FStopGridRolPos <= ABoundPos) then
      begin
        CurList.Add(CurStack[i]);
        CurStack[i] := nil;
        if i = InDayPos then
        begin
          ClearInDay();
          InDayPos := -1;
        end;
      end;
    end;

    FullEmpty := True;
    for i := 0 to CurStack.Count-1 do
      if CurStack[i] <> nil then
      begin
        FullEmpty := False;
        Break;
      end;

    if FullEmpty then
    begin
      CurColbarCount := 1;
      CurList.Clear;
      CurStack.Clear;
    end;
  end;

  procedure PushInStack(ASpanItem: TTimeSpanDisplayItemEh);
  var
    i: Integer;
    StackSpanItem: TTimeSpanDisplayItemEh;
    PlaceFound: Boolean;
  begin
    PlaceFound := False;
    if CurStack.Count > 0 then
    begin
      if ASpanItem.PlanItem.InsideDayRange and (InDayPos >= 0) then
      begin
        AddInDay(ASpanItem);
        PlaceFound := True;
      end else
      begin
        for i := 0 to CurStack.Count-1 do
        begin
          StackSpanItem := TTimeSpanDisplayItemEh(CurStack[i]);
          if StackSpanItem = nil then
          begin
            if BandOreintation = atboVerticalEh then
            begin
              ASpanItem.FInCellCols := CurColbarCount;
              ASpanItem.FInCellFromCol := i;
              ASpanItem.FInCellToCol := i;
            end else
            begin
              ASpanItem.FInCellRows := CurColbarCount;
              ASpanItem.FInCellFromRow := i;
              ASpanItem.FInCellToRow := i;
            end;
            CurStack[i] := ASpanItem;
            PlaceFound := True;
            if ASpanItem.PlanItem.InsideDayRange then
            begin
              InDayPos := i;
              InDayList.Add(ASpanItem);
            end;
            Break;
          end;
        end;
      end;
    end;
    if not PlaceFound then
    begin
      if CurStack.Count > 0 then
      begin
        CurColbarCount := CurColbarCount + 1;
        for i := 0 to CurStack.Count-1 do
          if BandOreintation = atboVerticalEh then
            TTimeSpanDisplayItemEh(CurStack[i]).FInCellCols := CurColbarCount
          else
            TTimeSpanDisplayItemEh(CurStack[i]).FInCellRows := CurColbarCount;
        for i := 0 to CurList.Count-1 do
          if BandOreintation = atboVerticalEh then
            TTimeSpanDisplayItemEh(CurList[i]).FInCellCols := CurColbarCount
          else
            TTimeSpanDisplayItemEh(CurList[i]).FInCellRows := CurColbarCount;
        if InDayPos >= 0 then
          for i := 0 to InDayList.Count-1 do
            TTimeSpanDisplayItemEh(InDayList[i]).FInCellCols := CurColbarCount
      end;
      if BandOreintation = atboVerticalEh then
      begin
        ASpanItem.FInCellCols := CurColbarCount;
        ASpanItem.FInCellFromCol := CurColbarCount-1;
        ASpanItem.FInCellToCol := CurColbarCount-1;
      end else
      begin
        ASpanItem.FInCellRows := CurColbarCount;
        ASpanItem.FInCellFromRow := CurColbarCount-1;
        ASpanItem.FInCellToRow := CurColbarCount-1;
      end;
      CurStack.Add(ASpanItem);
      if ASpanItem.PlanItem.InsideDayRange then
      begin
        InDayPos := CurStack.Count-1;
        InDayList.Add(ASpanItem);
      end;
    end;
  end;

begin
  CurStack := TObjectListEh.Create;
  CurList := TObjectListEh.Create;
  InDayList := TObjectListEh.Create;
  CurColbarCount := 1;
  InDayPos := -1;

  for i := 0 to SpanItemsCount-1 do
  begin
    SpanItem := SortedSpan[i];
    if SpanItem.PlanItem.Resource = Resource then
    begin
      CheckPushOutStack(SpanItem.FStartGridRollPos);
      PushInStack(SpanItem);
    end;
  end;
  ClearInDay();
  CurStack.Free;
  CurList.Free;
  InDayList.Free;
end;

procedure TPlannerVertTimelineViewEh.SetResOffsets;
var
  i: Integer;
begin
  for i := 0 to Length(FResourcesView)-1 do
    if i*FBarsPerRes < HorzAxis.RolCelCount then
    begin
      if (PlannerDataSource <> nil) and (i < PlannerDataSource.Resources.Count)
        then FResourcesView[i].Resource := PlannerDataSource.Resources[i]
        else FResourcesView[i].Resource := nil;
      FResourcesView[i].GridOffset := HorzAxis.RolLocCelPosArr[i*FBarsPerRes];
      FResourcesView[i].GridStartAxisBar := i*FBarsPerRes;
    end;
end;

procedure TPlannerVertTimelineViewEh.SetDisplayPosesSpanItems;
var
  ASpanRect: TRect;
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  StartX: Integer;
  ResourceOffset: Integer;
  AStartViewDate, AEndViewDate: TDateTime;
begin
  SetResOffsets;
  StartX := 0;
  GetViewPeriod(AStartViewDate, AEndViewDate);

  for i := 0 to SpanItemsCount-1 do
  begin
    SpanItem := SpanItems[i];
    begin
      ASpanRect.Left := StartX + 10;
      ASpanRect.Right := ASpanRect.Left + ColWidths[FDataColsOffset] - 20;
      ASpanRect.Top := SpanItem.StartGridRollPos;
      ASpanRect.Bottom := SpanItem.StopGridRolPosl;
      ResourceOffset := GetGridOffsetForResource(SpanItem.PlanItem.Resource);
      OffsetRect(ASpanRect, ResourceOffset, 0);

      CalcRectForInCellCols(SpanItem, ASpanRect);
      CalcRectForInCellRows(SpanItem, ASpanRect);

      SpanItem.FBoundRect := ASpanRect;

      if (SpanItem.PlanItem.StartTime < AStartViewDate) then
        SpanItem.FDrawBackOutInfo := True;
      if (SpanItem.PlanItem.EndTime > AEndViewDate) then
        SpanItem.FDrawForwardOutInfo := True;
    end;
  end;

end;

function TPlannerVertTimelineViewEh.CellToDateTime(ACol, ARow: Integer): TDateTime;
begin
  case RangeKind of
    rkDayByHoursEh:
      Result := IncMinute(StartDate, 30 * (ARow - FixedRowCount));
    rkWeekByHoursEh:
      Result := IncMinute(StartDate, 30 * (ARow - FixedRowCount));
    rkWeekByDaysEh:
      Result := IncDay(StartDate, (ARow - FixedRowCount));
    rkMonthByDaysEh:
      Result := IncDay(StartDate, (ARow - FixedRowCount));
  else
    Result := 0;
  end;
end;

procedure TPlannerVertTimelineViewEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
var
  DataCell: TGridCoord;
  DataRow: Integer;
  NextCellDateTime, CellDateTime: TDateTime;
  NextCellOffset: Integer;
  Resource: TPlannerResourceEh;
  ResNo: Integer;
  CellDate: TDateTime;
  NextCellDate: TDateTime;
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
begin
  inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);

  GetCellType(ACol, ARow, CellType, ALocalCol, ALocalRow);

  CellDate := DateOf(CellToDateTime(ACol, ARow));

  NextCellDate := CellDate;
  if not IsInterResourceCell(ACol, ARow) then
  begin
    if (ARow < RowCount-1) then 
      NextCellDate := DateOf(CellToDateTime(ACol, ARow+1))
    else if (ARow = RowCount-1) then   
      NextCellDate := DateOf(CellDate+1);
  end;

  if ((ACol-FDataColsOffset >= 0) or ((ACol-FDataColsOffset = -1 ) and (BorderType = cbtRightEh))) and
     (PlannerDataSource <> nil) and
     (PlannerDataSource.Resources.Count > 0) then
  begin
    Resource := nil;
    if IsInterResourceCell(ACol, ARow) then
    begin
      if BorderType in [cbtTopEh, cbtBottomEh]  then
        IsDraw := False;
      Resource := PlannerDataSource.Resources[(ACol-FDataColsOffset) div FBarsPerRes];
    end else
    begin
      ResNo := (ACol-FDataColsOffset) div FBarsPerRes;
      if (ResNo >= 0) and (ResNo < PlannerDataSource.Resources.Count) then
        Resource := PlannerDataSource.Resources[ResNo];
    end;
    if (Resource <> nil) and (Resource.DarkLineColor <> clDefault) then
        BorderColor := Resource.DarkLineColor;
  end;

  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));

    CellDateTime := CellToDateTime(ACol, ARow);
    if (ACol = 1)
      then NextCellOffset := 2
      else NextCellOffset := 1;

    if ARow < RowCount-NextCellOffset
      then NextCellDateTime := CellToDateTime(ACol, ARow+NextCellOffset)
      else NextCellDateTime := CellDateTime;

    if ARow >= FixedRowCount then
    begin
      if (BorderType = cbtBottomEh) and
         ( (ACol = FDayGroupCol) or
           ( (DateOf(CellDateTime) <> DateOf(NextCellDateTime)) )
         )
      then
        IsDraw := False
      else if IsDraw and (DataCell.X >= 0) and (DataCell.Y >= FixedRowCount) then
      begin
        DataRow := DataCell.Y - FixedRowCount;
        if (BorderType in [cbtTopEh, cbtBottomEh]) and (DataRow mod 2 = 0) then
          BorderColor := ApproximateColor(BorderColor, Color, 255 div 2);
      end;
    end;
  end;

  if (pvoHighlightTodayEh in PlannerControl.Options) then
  begin
    if (CellType = pctDataCellEh) and
       (BorderType = cbtRightEh) and
       (CellDate = DateOf(Today))
    then
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor
    else if (BorderType = cbtBottomEh) and
            (CellDate = DateOf(Today)) and
            (CellDate <> NextCellDate)
    then
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor
    else if (BorderType = cbtBottomEh) and
            (NextCellDate = DateOf(Today)) and
            (CellDate <> NextCellDate)
    then
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
  end;
end;

procedure TPlannerVertTimelineViewEh.BuildHoursGridData;
var
  i, g, ir: Integer;
  ColGroups: Integer;
  ARowCount: Integer;
  AFixedRowCount, AFixedColCount: Integer;
  AHoursBarWidth, ADayGroupColWidth: Integer;
  ColWidth, FitGap: Integer;
  DataColsWidth: Integer;
  ATimeGroups: Integer;
  InGroupStartRow: Integer;
  BarsInGroup: Integer;
begin

  ClearGridCells;


  AFixedRowCount := TopGridLineCount;

  if ResourceCaptionArea.Visible then
  begin
    ColGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;

    FResourceAxisPos := AFixedRowCount;
    AFixedRowCount := AFixedRowCount + 1;
    ARowCount := FCellsInBand + AFixedRowCount;
  end else
  begin
    ColGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;
    ARowCount := FCellsInBand + AFixedRowCount;
    FResourceAxisPos := -1;
  end;

  if DayNameArea.Visible then
  begin
    FDayNameBarPos := AFixedRowCount;
    Inc(ARowCount);
    Inc(AFixedRowCount);
  end else
    FDayNameBarPos := -1;


  if DatesBarArea.Visible then
  begin
    AFixedColCount := 1;
    FDataColsOffset := 1;
    FDayGroupCol := 0;
  end else
  begin
    AFixedColCount := 0;
    FDataColsOffset := 0;
    FDayGroupCol := -1;
  end;

  if HoursBarArea.Visible then
  begin
    FHoursBarIndex := AFixedColCount;
    Inc(AFixedColCount);
    Inc(FDataColsOffset);
  end else
  begin
    FHoursBarIndex := -1;
  end;

  FixedRowCount := AFixedRowCount;
  FixedColCount := AFixedColCount;
  FDataRowsOffset := AFixedRowCount;
  FDaySplitModeCol := -1;

  ColCount := AFixedColCount + ColGroups + (ColGroups-1);
  RowCount := ARowCount;
  SetGridSize(FullColCount, FullRowCount);
  if ColGroups = 1
    then FBarsPerRes := 1
    else FBarsPerRes := 2;


  if FHoursBarIndex >= 0 then
  begin
    ColWidths[FHoursBarIndex] := HoursBarArea.GetActualSize;
    AHoursBarWidth := HoursBarArea.GetActualSize;
  end else
    AHoursBarWidth := 0;


  if FDayGroupCol >= 0 then
  begin
    ColWidths[FDayGroupCol] := DatesBarArea.GetActualSize;
    ADayGroupColWidth := DatesBarArea.GetActualSize;
  end else
    ADayGroupColWidth := 0;


  DataColsWidth := (GridClientWidth - AHoursBarWidth - ADayGroupColWidth - (ColGroups-1)*3);
  ColWidth := DataColsWidth div ColGroups;
  if ColWidth < MinDataColWidth then
  begin
    ColWidth := MinDataColWidth;
    HorzScrollBar.VisibleMode := sbAutoShowEh;
    FitGap := 0;
  end else
  begin
    HorzScrollBar.VisibleMode := sbNeverShowEh;
    FitGap := DataColsWidth mod ColGroups;
  end;

  for i := FixedColCount to ColCount-1 do
  begin
    if IsInterResourceCell(i, 0) then
    begin
      ColWidths[i] := 3;
    end else
    begin
      if FitGap > 0
        then ColWidths[i] := ColWidth + 1
        else ColWidths[i] := ColWidth;
      Dec(FitGap);
    end;
  end;


  if HandleAllocated then
  begin
    DefaultRowHeight := DataBarsArea.GetActualRowHeight;
    for i := 0 to RowCount-1 do
      RowHeights[i] := DefaultRowHeight;

    if TopGridLineCount > 0 then
      RowHeights[FTopGridLineIndex] := 1;

    if FResourceAxisPos >= 0 then
      RowHeights[FResourceAxisPos] := ResourceCaptionArea.GetActualSize;

    if FDayNameBarPos >= 0 then
      RowHeights[FDayNameBarPos] := DayNameArea.GetActualSize;
  end;


  MergeCells(0,0, FixedColCount-1,FixedRowCount-1);

  ATimeGroups := FCellsInBand div FDayGroupRows;
  for g := 0 to ATimeGroups - 1 do
  begin
    InGroupStartRow := g * FDayGroupRows + FixedRowCount;
    BarsInGroup := FDayGroupRows div 2;
    if FDayGroupCol >= 0 then
      MergeCells(FDayGroupCol, InGroupStartRow, 0, FDayGroupRows-1);

    if FHoursBarIndex >= 0 then
      for i := 0 to BarsInGroup - 1 do
      begin
        ir := InGroupStartRow + i*2;
        MergeCells(FHoursBarIndex, ir, 0, 2-1);
        Cell[FHoursBarIndex, ir].Value := EncodeTime(i,0,0,0);
      end;
  end;
end;

function TPlannerVertTimelineViewEh.GetSortedSpan(Index: Integer): TTimeSpanDisplayItemEh;
begin
  Result := TTimeSpanDisplayItemEh(FSortedSpans[Index]);
end;

procedure TPlannerVertTimelineViewEh.GetViewPeriod(var AStartDate,
  AEndDate: TDateTime);
begin
  AStartDate := StartDate;
  AEndDate := AppendPeriod(StartDate, 1);
end;

function TPlannerVertTimelineViewEh.IsInterResourceCell(ACol,
  ARow: Integer): Boolean;
begin
  if (ACol-FDataColsOffset >= 0) and
     (Length(FResourcesView) > 1)
  then
    Result := (ACol-FDataColsOffset) mod FBarsPerRes = FBarsPerRes - 1
  else
    Result := False;
end;

procedure TPlannerVertTimelineViewEh.SetMinDataColWidth(const Value: Integer);
begin
  FMinDataColWidth := Value;
end;

procedure TPlannerVertTimelineViewEh.InitSpanItemMoving(
  SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint);
var
  ACell: TGridCoord;
  ACellTime: TDateTime;
begin
  ACell := MouseCoord(MousePos.X, MousePos.Y);
  ACellTime := CellToDateTime(ACell.X, ACell.Y);
  FMovingDaysShift := DaysBetween(DateOf(SpanItem.PlanItem.StartTime), DateOf(ACellTime));
  FMovingTimeShift := ACellTime - SpanItem.PlanItem.StartTime;
end;

procedure TPlannerVertTimelineViewEh.UpdateDummySpanItemSize(MousePos: TPoint);
var
  FixedMousePos: TPoint;
  ACell: TGridCoord;
  ANewTime: TDateTime;
  ATimeLen: TDateTime;
  ResViewIdx: Integer;
  AResource: TPlannerResourceEh;
begin
  FixedMousePos := MousePos;
  if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    FixedMousePos.X := FixedMousePos.X + FTopLeftSpanShift.cx;
    FixedMousePos.Y := FixedMousePos.Y + FTopLeftSpanShift.cy;
  end;
  if FPlannerState = psSpanButtomSizingEh then
  begin
    ACell := CalcCoordFromPoint(FixedMousePos.X, FixedMousePos.Y+DefaultRowHeight div 2);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    if (FDummyPlanItem.StartTime < ANewTime) and (FDummyPlanItem.EndTime <> ANewTime) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.EndTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged();
    end;
  end else if FPlannerState = psSpanTopSizingEh then
  begin
    ACell := MouseCoord(FixedMousePos.X, FixedMousePos.Y+DefaultRowHeight div 2);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    if (FDummyPlanItem.EndTime > ANewTime) and (FDummyPlanItem.StartTime <> ANewTime) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged();
    end;
  end else if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    ACell := CalcCoordFromPoint(FixedMousePos.X, FixedMousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;

    if (FDummyPlanItem.StartTime <> ANewTime) or
       (AResource <> FDummyPlanItem.Resource) then
    begin
      ATimeLen :=  FDummyPlanItem.EndTime - FDummyPlanItem.StartTime;

      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime - FMovingTimeShift;
      FDummyCheckPlanItem.EndTime := FDummyCheckPlanItem.StartTime + ATimeLen;
      FDummyCheckPlanItem.Resource := AResource;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);

      PlannerDataSourceChanged;
    end;
    ShowMoveHintWindow(FDummyPlanItem, MousePos);
  end;
end;

function TPlannerVertTimelineViewEh.GetResourceViewAtCell(ACol,
  ARow: Integer): Integer;
begin
  if ACol < FDataColsOffset then
    Result := -1
  else if IsInterResourceCell(ACol, ARow) then
    Result := -1
  else
    Result := (ACol-FDataColsOffset) div FBarsPerRes;
end;

procedure TPlannerVertTimelineViewEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

function TPlannerVertTimelineViewEh.DefaultHoursBarSize: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := HoursBarArea.Font;
    Result := Canvas.TextWidth('11111');
  end else
    Result := 45;
end;

function TPlannerVertTimelineViewEh.GetDayNameAreaDefaultSize: Integer;
var
  h: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := DayNameArea.Font;
    h := Canvas.TextHeight('Wg') + 4;
    if (h > DefaultRowHeight) or (RangeKind in [rkWeekByDaysEh, rkMonthByDaysEh])
      then Result := h
      else Result := DefaultRowHeight;
  end else
    Result := DefaultRowHeight;
end;

function TPlannerVertTimelineViewEh.GetResourceCaptionAreaDefaultSize: Integer;
var
  h: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := ResourceCaptionArea.Font;
    h := Canvas.TextHeight('Wg') + 4;
    if (h > DefaultRowHeight) or (RangeKind in [rkWeekByDaysEh, rkMonthByDaysEh])
      then Result := h
      else Result := DefaultRowHeight;
  end else
    Result := DefaultRowHeight;
end;

function TPlannerVertTimelineViewEh.CreateDayNameArea: TDayNameAreaEh;
begin
  Result := TDayNameVertAreaEh.Create(Self);
end;

function TPlannerVertTimelineViewEh.GetDayNameArea: TDayNameVertAreaEh;
begin
  Result := TDayNameVertAreaEh(inherited DayNameArea);
end;

procedure TPlannerVertTimelineViewEh.SetDayNameArea(const Value: TDayNameVertAreaEh);
begin
  inherited DayNameArea := Value;
end;

function TPlannerVertTimelineViewEh.GetDataBarsArea: TDataBarsVertAreaEh;
begin
  Result := TDataBarsVertAreaEh(inherited DataBarsArea);
end;

procedure TPlannerVertTimelineViewEh.SetDataBarsArea(
  const Value: TDataBarsVertAreaEh);
begin
  inherited DataBarsArea := Value;
end;

function TPlannerVertTimelineViewEh.GetDatesColArea: TDatesColAreaEh;
begin
  Result := TDatesColAreaEh(DatesBarArea);
end;

procedure TPlannerVertTimelineViewEh.SetDatesColArea(const Value: TDatesColAreaEh);
begin
  DatesBarArea := Value;
end;

function TPlannerVertTimelineViewEh.CreateResourceCaptionArea: TResourceCaptionAreaEh;
begin
  Result := TResourceVertCaptionAreaEh.Create(Self);
end;

function TPlannerVertTimelineViewEh.GetResourceCaptionArea: TResourceVertCaptionAreaEh;
begin
  Result := TResourceVertCaptionAreaEh(inherited ResourceCaptionArea);
end;

procedure TPlannerVertTimelineViewEh.SetResourceCaptionArea(const Value: TResourceVertCaptionAreaEh);
begin
  inherited SetResourceCaptionArea(Value);
end;

function TPlannerVertTimelineViewEh.CreateHoursBarArea: THoursBarAreaEh;
begin
  Result := THoursVertBarAreaEh.Create(Self);
end;

function TPlannerVertTimelineViewEh.GetHoursColArea: THoursVertBarAreaEh;
begin
  Result := THoursVertBarAreaEh(inherited HoursBarArea);
end;

procedure TPlannerVertTimelineViewEh.SetHoursColArea(
  const Value: THoursVertBarAreaEh);
begin
  inherited HoursBarArea := Value;
end;

function TPlannerVertTimelineViewEh.CreateDatesBarArea: TDatesBarAreaEh;
begin
  Result := TDatesColAreaEh.Create(Self);
end;

{ TPlannerVertDayslineViewEh }

constructor TPlannerVertDayslineViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TimeRange := dlrWeekEh;
end;

destructor TPlannerVertDayslineViewEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPlannerVertDayslineViewEh.DrawDaySplitModeDateCell(ACol,
  ARow: Integer; ARect: TRect; State: TGridDrawState; ADataRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawVertDayslineViewDateCell(
    Self, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerVertDayslineViewEh.GetDateCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  CellDateTime: TDateTime;
  wn: String;
begin
  CellDateTime := CellToDateTime(ACol, ARow);

  DrawArgs.FontColor := DatesBarArea.Font.Color;
  DrawArgs.FontName := DatesBarArea.Font.Name;
  DrawArgs.FontSize := DatesBarArea.Font.Size;
  DrawArgs.FontStyle := DatesBarArea.Font.Style;
  DrawArgs.BackColor := DatesBarArea.GetActualColor;

  wn := FormatSettings.ShortDayNames[DayOfWeek(CellDateTime)];
  DrawArgs.Text := wn + ', ' + FormatDateTime('D', CellDateTime);
  DrawArgs.Value := CellDateTime;
  DrawArgs.HorzMargin := Canvas.TextWidth('0') div 2;
  DrawArgs.VertMargin := 2;
  DrawArgs.Alignment := taLeftJustify;
  DrawArgs.Layout := tlTop;
end;

function TPlannerVertDayslineViewEh.GetDefaultDatesBarSize: Integer;
begin
  Result := 45;
end;

function TPlannerVertDayslineViewEh.GetDefaultDatesBarVisible: Boolean;
begin
  Result := True;
end;

function TPlannerVertDayslineViewEh.GetTimeRange: TDayslineRangeEh;
begin
  case RangeKind of
    rkWeekByDaysEh: Result := dlrWeekEh;
    rkMonthByDaysEh: Result := dlrMonthEh;
  else
    raise Exception.Create('TPlannerVertDayslineViewEh.RangeKind is inavlide');
  end;
end;

procedure TPlannerVertDayslineViewEh.SetTimeRange(const Value: TDayslineRangeEh);
const
  RangeDays: array [TDayslineRangeEh] of TTimePlanRangeKind = (rkWeekByDaysEh, rkMonthByDaysEh);
begin
  RangeKind := RangeDays[Value];
end;

procedure TPlannerVertDayslineViewEh.BuildDaysGridData;
var
  i: Integer;
  ColGroups: Integer;
  ARowCount: Integer;
  AFixedRowCount, AFixedColCount: Integer;
  ColWidth: Integer;
  FitGap: Integer;
  ADayGroupColWidth: Integer;
  DataColsWidth: Integer;
begin


  AFixedRowCount := TopGridLineCount;

  if ResourceCaptionArea.Visible then
  begin
    ColGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;

    FResourceAxisPos := AFixedRowCount;
    AFixedRowCount := AFixedRowCount + 1;
    ARowCount := FCellsInBand + AFixedRowCount;
  end else
  begin
    ColGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(ColGroups);
    if ColGroups = 0 then
      ColGroups := 1;

    ARowCount := FCellsInBand + AFixedRowCount;
    FResourceAxisPos := -1;
  end;

  if DayNameArea.Visible then
  begin
    FDayNameBarPos := AFixedRowCount;
    Inc(ARowCount);
    Inc(AFixedRowCount);
  end else
    FDayNameBarPos := -1;


  if DatesBarArea.Visible then
  begin
    AFixedColCount := 1;
    FDataColsOffset := 1;
    FDaySplitModeCol := 0;
  end else
  begin
    AFixedColCount := 0;
    FDataColsOffset := 0;
    FDaySplitModeCol := -1;
  end;

  FHoursBarIndex := -1;
  FDayGroupCol := -1;

  FixedRowCount := AFixedRowCount;
  FixedColCount := AFixedColCount;
  FDataRowsOffset := AFixedRowCount;

  ColCount := AFixedColCount + ColGroups + (ColGroups-1);
  RowCount := ARowCount;
  SetGridSize(FullColCount, FullRowCount);
  if ColGroups = 1
    then FBarsPerRes := 1
    else FBarsPerRes := 2;


  if FDaySplitModeCol >= 0 then
  begin
    ColWidths[FDaySplitModeCol] := DatesBarArea.GetActualSize;
    ADayGroupColWidth := DatesBarArea.GetActualSize;
  end else
    ADayGroupColWidth := 0;


  DataColsWidth := (GridClientWidth - ADayGroupColWidth - (ColGroups-1)*3);
  ColWidth := DataColsWidth div ColGroups;
  if ColWidth < MinDataColWidth then
  begin
    ColWidth := MinDataColWidth;
    HorzScrollBar.VisibleMode := sbAutoShowEh;
    FitGap := 0;
  end else
  begin
    HorzScrollBar.VisibleMode := sbNeverShowEh;
    FitGap := DataColsWidth mod ColGroups;
  end;

  for i := FixedColCount to ColCount-1 do
  begin
    if IsInterResourceCell(i, 0) then
    begin
      ColWidths[i] := 3;
    end else
    begin
      if FitGap > 0
        then ColWidths[i] := ColWidth + 1
        else ColWidths[i] := ColWidth;
      Dec(FitGap);
    end;
  end;


  if HandleAllocated then
  begin
    DefaultRowHeight := DataBarsArea.GetActualRowHeight;
    for i := 0 to RowCount-1 do
      RowHeights[i] := DefaultRowHeight;

    if TopGridLineCount > 0 then
      RowHeights[FTopGridLineIndex] := 1;

    if FResourceAxisPos >= 0 then
      RowHeights[FResourceAxisPos] := ResourceCaptionArea.GetActualSize;

    if FDayNameBarPos >= 0 then
      RowHeights[FDayNameBarPos] := DayNameArea.GetActualSize;
  end;

  MergeCells(0,0, FixedColCount-1,FixedRowCount-1);

end;

function TPlannerVertDayslineViewEh.IsWorkingTime(const Value: TDateTime): Boolean;
begin
  Result := True;
end;

{ TPlannerHorzBandViewEh }

constructor TPlannerHorzTimelineViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FResourceColWidth := 100;
  BandOreintation := atboHorizonalEh;
  RangeKind := rkWeekByHoursEh;
  FShowDateRow := True;
end;

destructor TPlannerHorzTimelineViewEh.Destroy;
begin
  inherited Destroy;
end;

function TPlannerHorzTimelineViewEh.CellToDateTime(ACol, ARow: Integer): TDateTime;
begin
  case RangeKind of
    rkDayByHoursEh:
      Result := IncMinute(StartDate, 30 * (ACol - FixedColCount));
    rkWeekByHoursEh:
      Result := IncMinute(StartDate, 30 * (ACol - FixedColCount));
    rkWeekByDaysEh:
      Result := IncDay(StartDate, (ACol - FixedColCount));
    rkMonthByDaysEh:
      Result := IncDay(StartDate, (ACol - FixedColCount));
  else
    Result := 0;
  end;
end;

procedure TPlannerHorzTimelineViewEh.CheckDrawCellBorder(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var IsDraw: Boolean;
  var BorderColor: TColor; var IsExtent: Boolean);
var
  DataCell: TGridCoord;
  DataCol: Integer;
  NextCellDateTime, CellDateTime: TDateTime;
  NextCellOffset: Integer;
  Resource: TPlannerResourceEh;
  ResIndex: Integer;
  CellDate: TDateTime;
  NextCellDate: TDateTime;
  CellType: TPlannerViewCellTypeEh;
  ALocalCol, ALocalRow: Integer;
begin
  inherited CheckDrawCellBorder(ACol, ARow, BorderType, IsDraw, BorderColor, IsExtent);

  GetCellType(ACol, ARow, CellType, ALocalCol, ALocalRow);

  CellDate := DateOf(CellToDateTime(ACol, ARow));

  if (ACol < ColCount-1) and not IsInterResourceCell(ACol+1, ARow)
    then NextCellDate := DateOf(CellToDateTime(ACol+1, ARow))
    else NextCellDate := CellDate;

  if ((ARow-FDataRowsOffset >= 0) or ((ARow-FDataRowsOffset = -1 ) and (BorderType = cbtBottomEh))) and
     (ResourcesCount > 0) then
  begin
    Resource := nil;
    if IsInterResourceCell(ACol, ARow) then
    begin
      if BorderType in [cbtLeftEh, cbtRightEh]  then
        IsDraw := False;
      if (ARow-FDataRowsOffset) div FBarsPerRes < PlannerDataSource.Resources.Count then
        Resource := PlannerDataSource.Resources[(ARow-FDataRowsOffset) div FBarsPerRes];
    end else
    begin
      ResIndex := (ARow-FDataRowsOffset) div FBarsPerRes;
      if (ResIndex >= 0) and (ResIndex < PlannerDataSource.Resources.Count) then
        Resource := PlannerDataSource.Resources[ResIndex];
    end;
    if (Resource <> nil) and (Resource.DarkLineColor <> clDefault) then
        BorderColor := Resource.DarkLineColor;
  end;

  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    DataCell := GridCoordToDataCoord(GridCoord(ACol, ARow));

    CellDateTime := CellToDateTime(ACol, ARow);
    if (ACol = 1)
      then NextCellOffset := 2
      else NextCellOffset := 1;

    if ACol < ColCount-NextCellOffset
      then NextCellDateTime := CellToDateTime(ACol+NextCellOffset, ARow)
      else NextCellDateTime := CellDateTime;

    if ACol >= FixedColCount then
    begin
      if (BorderType = cbtRightEh) and
         ( (ARow = FDayGroupRow) or
           ( (DateOf(CellDateTime) <> DateOf(NextCellDateTime)) )
         )
      then
        IsDraw := False
      else if IsDraw and (DataCell.X >= 0) and (DataCell.Y >= 0) then
      begin
        DataCol := DataCell.X;
        if (BorderType in [cbtLeftEh, cbtRightEh]) and (DataCol mod 2 = 0) then
          BorderColor := ApproximateColor(BorderColor, Color, 255 div 2);
      end;
    end;
  end;

  if (pvoHighlightTodayEh in PlannerControl.Options) then
  begin
    if (CellType = pctDataCellEh) and
       (BorderType = cbtBottomEh) and
       (CellDate = DateOf(Today))
    then
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor
    else if (BorderType = cbtRightEh) and
            (CellDate = DateOf(Today)) and
            (CellDate <> NextCellDate)
    then
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor
    else if (BorderType = cbtRightEh) and
            (NextCellDate = DateOf(Today)) and
            (CellDate <> NextCellDate)
    then
      BorderColor := PlannerDrawStyleEh.GetActlTodayFrameColor;
  end;
end;

procedure TPlannerHorzTimelineViewEh.BuildHoursGridData;
var
  i, g, ir: Integer;
  RowGroups: Integer;
  AColCount: Integer;
  AFixedRowCount, AFixedColCount: Integer;
  AHoursBarHeight, ADayGroupRowHeight: Integer;
  RowHeight, FitGap: Integer;
  DataRowsHeight: Integer;
  ATimeGroups: Integer;
  InGroupStartCol: Integer;
  BarsInGroup: Integer;
begin

  ClearGridCells;


  if ResourceCaptionArea.Visible then
  begin
    RowGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(RowGroups);
    if RowGroups = 0  then
      RowGroups := 1;
    AColCount := FCellsInBand + 1;
    AFixedColCount := 1;
    FResourceAxisPos := 0;
  end else
  begin
    RowGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(RowGroups);
    if RowGroups = 0  then
      RowGroups := 1;
    AColCount := FCellsInBand;
    AFixedColCount := 0;
    FResourceAxisPos := -1;
  end;

  if DayNameArea.Visible then
  begin
    FDayNameBarPos := AFixedColCount;
    Inc(AColCount);
    Inc(AFixedColCount);
  end else
    FDayNameBarPos := -1;


  AFixedRowCount := TopGridLineCount;

  if DatesBarArea.Visible then
  begin
    FDayGroupRow := AFixedRowCount;
    AFixedRowCount := AFixedRowCount + 1;
    FDataRowsOffset := AFixedRowCount;
  end else
  begin
    FDataRowsOffset := AFixedRowCount;
    FDayGroupRow := -1;
  end;

  if HoursBarArea.Visible then
  begin
    FHoursBarIndex := AFixedRowCount;
    Inc(AFixedRowCount);
    Inc(FDataRowsOffset);
  end else
  begin
    FHoursBarIndex := -1;
  end;

  FixedRowCount := AFixedRowCount;
  FixedColCount := AFixedColCount;
  FDataColsOffset := AFixedColCount;
  FDaySplitModeRow := -1;

  RowCount := AFixedRowCount + RowGroups + (RowGroups-1);
  ColCount := AColCount;
  SetGridSize(FullColCount, FullRowCount);
  if RowGroups = 1
    then FBarsPerRes := 1
    else FBarsPerRes := 2;

  if TopGridLineCount > 0 then
    RowHeights[FTopGridLineIndex] := 1;


  if FHoursBarIndex >= 0 then
  begin
    RowHeights[FHoursBarIndex] := HoursBarArea.GetActualSize;
    AHoursBarHeight := HoursBarArea.GetActualSize;
  end else
    AHoursBarHeight := 0;


  if FDayGroupRow >= 0 then
  begin
    RowHeights[FDayGroupRow] := DatesBarArea.GetActualSize;
    ADayGroupRowHeight := DatesBarArea.GetActualSize;
  end else
    ADayGroupRowHeight := 0;


  DataRowsHeight := (GridClientHeight - AHoursBarHeight - ADayGroupRowHeight - (RowGroups-1)*3);
  RowHeight := DataRowsHeight div RowGroups;
  if RowHeight < MinDataRowHeight then
  begin
    RowHeight := MinDataRowHeight;
    VertScrollBar.VisibleMode := sbAutoShowEh;
    FitGap := 0;
  end else
  begin
    VertScrollBar.VisibleMode := sbNeverShowEh;
    FitGap := DataRowsHeight mod RowGroups;
  end;

  for i := FixedRowCount to RowCount-1 do
  begin
    if IsInterResourceCell(0, i) then
    begin
      RowHeights[i] := 3;
    end else
    begin
      if FitGap > 0
        then RowHeights[i] := RowHeight + 1
        else RowHeights[i] := RowHeight;
      Dec(FitGap);
    end;
  end;

  if HandleAllocated then
  begin
    Canvas.Font := Font;
    DefaultColWidth := DataBarsArea.GetActualColWidth;
    for i := FixedColCount to ColCount-1 do
      ColWidths[i] := DefaultColWidth;

    if FResourceAxisPos >= 0 then
      ColWidths[FResourceAxisPos] := ResourceCaptionArea.GetActualSize;

    if FDayNameBarPos >= 0 then
      ColWidths[FDayNameBarPos] := DayNameArea.GetActualSize;
  end;

  MergeCells(0,0, FixedColCount-1,FixedRowCount-1);

  ATimeGroups := FCellsInBand div FDayGroupCols;
  for g := 0 to ATimeGroups - 1 do
  begin
    InGroupStartCol := g * FDayGroupCols + FixedColCount;
    BarsInGroup := FDayGroupCols div 2;
    if FDayGroupRow >= 0 then
      MergeCells(InGroupStartCol, FDayGroupRow, FDayGroupCols-1, 0);

    if FHoursBarIndex >= 0 then
      for i := 0 to BarsInGroup - 1 do
      begin
        ir := InGroupStartCol + i*2;
        MergeCells(ir, FHoursBarIndex, 2-1, 0);
        Cell[ir, FHoursBarIndex].Value := EncodeTime(i,0,0,0);
      end;
  end;

end;

procedure TPlannerHorzTimelineViewEh.CalcLayouts;
begin
  inherited CalcLayouts;
  FDayGroupCols := -1;

  case RangeKind of
    rkDayByHoursEh:
      begin
        FDayGroupCols := 24 * 2;
      end;
    rkWeekByHoursEh:
      begin
        FDayGroupCols := 24 * 2;
      end;
    rkWeekByDaysEh:
      begin
        FDayGroupCols := 1;
      end;
    rkMonthByDaysEh:
      begin
        FDayGroupCols := 1;
      end;
  end;
end;

procedure TPlannerHorzTimelineViewEh.GetCellType(ACol, ARow: Integer;
  var CellType: TPlannerViewCellTypeEh; var ALocalCol, ALocalRow: Integer);
begin
  if (ACol >= FixedColCount) and (ARow = FDayGroupRow) then
  begin
    CellType := pctDateBarEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ACol >= FixedColCount) and (ARow = FHoursBarIndex) then
  begin
    CellType := pctTimeCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ACol >= FixedColCount) and (ARow = FDaySplitModeRow) then
  begin
    CellType := pctDateCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ACol = FDayNameBarPos) and (ARow >= FixedRowCount) then
  begin
    CellType := pctDayNameCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ACol = 0) and (ARow < FixedRowCount) then
  begin
    CellType := pctTopLeftCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else if (ACol = FResourceAxisPos) and (ARow >= FixedRowCount) then
  begin
     if IsInterResourceCell(ACol, ARow)
      then CellType := pctInterResourceSpaceEh
      else CellType := pctResourceCaptionCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end else
  begin
    CellType := pctDataCellEh;
    ALocalCol := 0;
    ALocalRow := 0;
  end;
end;

procedure TPlannerHorzTimelineViewEh.DrawDataCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  NextCellDateTime, CellDateTime: TDateTime;
begin
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    CellDateTime := CellToDateTime(ACol, ARow);
    if ACol < ColCount-1
      then NextCellDateTime := CellToDateTime(ACol+1, ARow)
      else NextCellDateTime := CellDateTime;

    if DateOf(CellDateTime) <> DateOf(NextCellDateTime) then
    begin

      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today-1)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Right-1, ARect.Top), Point(ARect.Right-1, ARect.Bottom)]);

      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Right-2, ARect.Top), Point(ARect.Right-2, ARect.Bottom)]);

      ARect.Right := ARect.Right - 2;
    end;
  end;
  inherited DrawDataCell(ACol, ARow, ARect, State, 0, 0, DrawArgs);
end;

procedure TPlannerHorzTimelineViewEh.DrawDaySplitModeDateCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ADataCol: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin

end;

procedure TPlannerHorzTimelineViewEh.DrawTimeCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  NextCellDateTime, CellDateTime: TDateTime;
begin
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    CellDateTime := CellToDateTime(ACol, ARow);
    if ACol < ColCount-2
      then NextCellDateTime := CellToDateTime(ACol+2, ARow)
      else NextCellDateTime := CellDateTime;

    if DateOf(CellDateTime) <> DateOf(NextCellDateTime) then
    begin
      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today-1)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Right-1, ARect.Top), Point(ARect.Right-1, ARect.Bottom)]);

      if (pvoHighlightTodayEh in PlannerControl.Options) and
         (DateOf(CellToDateTime(ACol, ARow)) = Today)
      then
        Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
      else
        Canvas.Pen.Color := FMasterGroupLineColor;
      DrawPolyline(Canvas, [Point(ARect.Right-2, ARect.Top), Point(ARect.Right-2, ARect.Bottom)]);

      ARect.Right := ARect.Right - 2;
    end;

    inherited DrawTimeCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
  end else
  begin
    inherited DrawTimeCell(ACol, ARow, ARect, State, ALocalCol, ALocalRow, DrawArgs);
  end;
end;

procedure TPlannerHorzTimelineViewEh.DrawDateBar(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawTimeGroupCell(ACol, ARow, ARect, State, DrawArgs);
end;

procedure TPlannerHorzTimelineViewEh.DrawDateCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  DrawDaySplitModeDateCell(ACol, ARow, ARect, State, ACol-FixedColCount, DrawArgs);
end;

procedure TPlannerHorzTimelineViewEh.DrawTimeGroupCell(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin

  if (pvoHighlightTodayEh in PlannerControl.Options) and
     (DateOf(CellToDateTime(ACol, ARow)) = Today-1)
  then
    Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
  else
    Canvas.Pen.Color := FMasterGroupLineColor;
  DrawPolyline(Canvas, [Point(ARect.Right-1, ARect.Top), Point(ARect.Right-1, ARect.Bottom)]);

  if (pvoHighlightTodayEh in PlannerControl.Options) and
     (DateOf(CellToDateTime(ACol, ARow)) = Today)
  then
    Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor
  else
    Canvas.Pen.Color := FMasterGroupLineColor;
  DrawPolyline(Canvas, [Point(ARect.Right-2, ARect.Top), Point(ARect.Right-2, ARect.Bottom)]);

  ARect.Right := ARect.Right - 2;

  PlannerControl.GetActualDrawStyle.DrawHorzTimelineViewTimeGroupCell(
    Self, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerHorzTimelineViewEh.GetDateBarDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  DrawDate: TDateTime;
begin
  DrawDate := CellToDateTime(ACol, ARow);
  DrawArgs.Text := FormatDateTime(FormatSettings.LongDateFormat, DrawDate) + ' ';
  DrawArgs.Value := DrawDate;

  DrawArgs.FontName := DatesBarArea.Font.Name;
  DrawArgs.FontColor := DatesBarArea.Font.Color;
  DrawArgs.FontSize := DatesBarArea.Font.Size;
  DrawArgs.FontStyle := DatesBarArea.Font.Style;
  DrawArgs.BackColor := DatesBarArea.GetActualColor;
  DrawArgs.Alignment := taCenter;
  DrawArgs.Layout := tlCenter;
  DrawArgs.Orientation := tohHorizontal;
end;

function TPlannerHorzTimelineViewEh.GetResourceCaptionAreaDefaultSize: Integer;
var
  h: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := ResourceCaptionArea.Font;
    h := Trunc(Canvas.TextWidth('WWWWWWWWWW'));
    if h > DefaultColWidth
      then Result := h
      else Result := DefaultColWidth;
  end else
    Result := DefaultColWidth;
end;

function TPlannerHorzTimelineViewEh.GetResourceViewAtCell(ACol, ARow: Integer): Integer;
begin
  if ARow < FDataRowsOffset then
    Result := -1
  else if IsInterResourceCell(ACol, ARow) then
    Result := -1
  else
    Result := (ARow-FDataRowsOffset) div FBarsPerRes;
end;

function TPlannerHorzTimelineViewEh.IsInterResourceCell(ACol,
  ARow: Integer): Boolean;
begin
  if (ARow-FDataRowsOffset >= 0) and
     (Length(FResourcesView) > 1)
  then
    Result := (ARow-FDataRowsOffset) mod FBarsPerRes = FBarsPerRes - 1
  else
    Result := False;
end;

procedure TPlannerHorzTimelineViewEh.SetDisplayPosesSpanItems;
var
  ASpanRect: TRect;
  SpanItem: TTimeSpanDisplayItemEh;
  i: Integer;
  StartY: Integer;
  ResourceOffset: Integer;
  AStartViewDate, AEndViewDate: TDateTime;
begin
  SetResOffsets;
  StartY := 0;
  GetViewPeriod(AStartViewDate, AEndViewDate);

  for i := 0 to SpanItemsCount-1 do
  begin
    SpanItem := SpanItems[i];
    begin
      ASpanRect.Left := SpanItem.StartGridRollPos;
      ASpanRect.Right := SpanItem.StopGridRolPosl;

      ASpanRect.Top := StartY + 10;
      ASpanRect.Bottom := ASpanRect.Top + RowHeights[FDataRowsOffset] - 20;

      ResourceOffset := GetGridOffsetForResource(SpanItem.PlanItem.Resource);
      OffsetRect(ASpanRect, 0, ResourceOffset);

      CalcRectForInCellRows(SpanItem, ASpanRect);

      SpanItem.FBoundRect := ASpanRect;

      if (SpanItem.PlanItem.StartTime < AStartViewDate) then
        SpanItem.FDrawBackOutInfo := True;
      if (SpanItem.PlanItem.EndTime > AEndViewDate) then
        SpanItem.FDrawForwardOutInfo := True;
    end;
  end;
end;

procedure TPlannerHorzTimelineViewEh.SetMinDataRowHeight(const Value: Integer);
begin
  if FMinDataRowHeight <> Value then
  begin
    FMinDataRowHeight := Value;
    GridLayoutChanged;
  end;
end;

procedure TPlannerHorzTimelineViewEh.CalcRectForInCellRows(
  SpanItem: TTimeSpanDisplayItemEh; var DrawRect: TRect);
var
  RectHeight: Integer;
  SecHeight: Integer;
  OldDrawRect: TRect;
begin
  RectHeight := DrawRect.Bottom - DrawRect.Top;
  if SpanItem.InCellRows > 0 then
  begin
    SecHeight := RectHeight div SpanItem.InCellRows;
    OldDrawRect := DrawRect;
    DrawRect.Top := OldDrawRect.Top + SecHeight * SpanItem.InCellFromRow;
    DrawRect.Bottom := OldDrawRect.Top + SecHeight * (SpanItem.InCellToRow + 1);
  end;
end;

procedure TPlannerHorzTimelineViewEh.SetResOffsets;
var
  i: Integer;
begin
  for i := 0 to Length(FResourcesView)-1 do
    if i*FBarsPerRes < VertAxis.RolCelCount then
    begin
      FResourcesView[i].GridOffset := VertAxis.RolLocCelPosArr[i*FBarsPerRes];
      FResourcesView[i].GridStartAxisBar := i*FBarsPerRes;
    end;
end;

procedure TPlannerHorzTimelineViewEh.SetResourceColWidth(const Value: Integer);
begin
  if FResourceColWidth <> Value then
  begin
    FResourceColWidth := Value;
    GridLayoutChanged;
  end;
end;

function TPlannerHorzTimelineViewEh.CalTimeRowHeight: Integer;
var
  hSize, mSize: TSize;
begin
  Result := 12;
  if not HandleAllocated then Exit;
  if RangeKind in [rkDayByHoursEh, rkWeekByHoursEh] then
  begin
    Canvas.Font := Font;
    mSize := Canvas.TextExtent('00');
    Canvas.Font.Size := Font.Size * 3 div 2;
    hSize := Canvas.TextExtent('00');
    Result := hSize.cx + mSize.cx div 2 + mSize.cx;
    Canvas.Font := Font;
  end else
  begin
    Canvas.Font := Font;
    mSize := Canvas.TextExtent('00');
    Canvas.Font.Size := Font.Size * 3 div 2;
    hSize := Canvas.TextExtent('00');
    Result := hSize.cx + mSize.cx div 2;
    Canvas.Font := Font;
  end;
end;

procedure TPlannerHorzTimelineViewEh.InitSpanItem(
  ASpanItem: TTimeSpanDisplayItemEh);
begin
  inherited InitSpanItem(ASpanItem);
  ASpanItem.FAllowedInteractiveChanges :=
    [sichSpanMovingEh, sichSpanLeftSizingEh, sichSpanRightSizingEh];
  ASpanItem.FTimeOrientation := toHorizontalEh;
end;

procedure TPlannerHorzTimelineViewEh.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TPlannerHorzTimelineViewEh.InitSpanItemMoving(
  SpanItem: TTimeSpanDisplayItemEh; MousePos: TPoint);
var
  ACell: TGridCoord;
  ACellTime: TDateTime;
begin
  ACell := MouseCoord(MousePos.X, MousePos.Y);
  ACellTime := CellToDateTime(ACell.X, ACell.Y);
  FMovingDaysShift := DaysBetween(DateOf(SpanItem.PlanItem.StartTime), DateOf(ACellTime));
  FMovingTimeShift := ACellTime - SpanItem.PlanItem.StartTime;
end;

procedure TPlannerHorzTimelineViewEh.UpdateDummySpanItemSize(MousePos: TPoint);
var
  FixedMousePos: TPoint;
  ACell: TGridCoord;
  ANewTime: TDateTime;
  ATimeLen: TDateTime;
  ResViewIdx: Integer;
  AResource: TPlannerResourceEh;
begin
  FixedMousePos := MousePos;
  if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    FixedMousePos.X := FixedMousePos.X + FTopLeftSpanShift.cx;
    FixedMousePos.Y := FixedMousePos.Y + FTopLeftSpanShift.cy;
  end;
  if FPlannerState = psSpanRightSizingEh then
  begin
    ACell := CalcCoordFromPoint(FixedMousePos.X + DefaultColWidth div 2, FixedMousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    if (FDummyPlanItem.StartTime < ANewTime) and (FDummyPlanItem.EndTime <> ANewTime) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.EndTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged();
    end;
  end else if FPlannerState = psSpanLeftSizingEh then
  begin
    ACell := MouseCoord(FixedMousePos.X + DefaultColWidth  div 2, FixedMousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    if (FDummyPlanItem.EndTime > ANewTime) and (FDummyPlanItem.StartTime <> ANewTime) then
    begin
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged();
    end;
  end else if FPlannerState in [psSpanMovingEh, psSpanTestMovingEh] then
  begin
    ACell := CalcCoordFromPoint(FixedMousePos.X, FixedMousePos.Y);
    ANewTime := CellToDateTime(ACell.X, ACell.Y);
    ResViewIdx := GetResourceViewAtCell(ACell.X, ACell.Y);
    if ResViewIdx >= 0
      then AResource := FResourcesView[ResViewIdx].Resource
      else AResource := FDummyPlanItem.Resource;

    if (FDummyPlanItem.StartTime <> ANewTime) or
       (AResource <> FDummyPlanItem.Resource) then
    begin
      ATimeLen :=  FDummyPlanItem.EndTime - FDummyPlanItem.StartTime;
      FDummyCheckPlanItem.Assign(FDummyPlanItem);
      FDummyCheckPlanItem.StartTime := ANewTime - FMovingTimeShift;
      FDummyCheckPlanItem.EndTime := FDummyCheckPlanItem.StartTime + ATimeLen;
      FDummyCheckPlanItem.Resource := AResource;
      CheckSetDummyPlanItem(FDummyPlanItemFor, FDummyCheckPlanItem);
      PlannerDataSourceChanged;
    end;
    ShowMoveHintWindow(FDummyPlanItem, MousePos);
  end;
end;

procedure TPlannerHorzTimelineViewEh.SetShowDateRow(const Value: Boolean);
begin
  if FShowDateRow <> Value then
  begin
    FShowDateRow := Value;
    PlannerDataSourceChanged;
  end;
end;

function TPlannerHorzTimelineViewEh.DefaultHoursBarSize: Integer;
begin
  if HandleAllocated then
  begin
    Canvas.Font := HoursBarArea.Font;
    Result := Canvas.TextHeight('Wg') * 2;
  end else
    Result := 45;
end;

function TPlannerHorzTimelineViewEh.CreateDayNameArea: TDayNameAreaEh;
begin
  Result := TDayNameHorzAreaEh.Create(Self);
end;

function TPlannerHorzTimelineViewEh.GetDayNameArea: TDayNameHorzAreaEh;
begin
  Result := TDayNameHorzAreaEh(inherited DayNameArea);
end;

procedure TPlannerHorzTimelineViewEh.SetDayNameArea(const Value: TDayNameHorzAreaEh);
begin
  inherited DayNameArea := Value;
end;

function TPlannerHorzTimelineViewEh.CreateDataBarsArea: TDataBarsAreaEh;
begin
  Result := TDataBarsHorzAreaEh.Create(Self);
end;

function TPlannerHorzTimelineViewEh.GetDataBarsArea: TDataBarsHorzAreaEh;
begin
  Result := TDataBarsHorzAreaEh(inherited DataBarsArea);
end;

procedure TPlannerHorzTimelineViewEh.SetDataBarsArea(
  const Value: TDataBarsHorzAreaEh);
begin
  inherited DataBarsArea := Value;
end;

function TPlannerHorzTimelineViewEh.CreateResourceCaptionArea: TResourceCaptionAreaEh;
begin
  Result := TResourceHorzCaptionAreaEh.Create(Self);
end;

function TPlannerHorzTimelineViewEh.GetResourceCaptionArea: TResourceHorzCaptionAreaEh;
begin
  Result := TResourceHorzCaptionAreaEh(inherited ResourceCaptionArea);
end;

procedure TPlannerHorzTimelineViewEh.SetResourceCaptionArea(const Value: TResourceHorzCaptionAreaEh);
begin
  inherited SetResourceCaptionArea(Value);
end;

function TPlannerHorzTimelineViewEh.CreateHoursBarArea: THoursBarAreaEh;
begin
  Result := THoursHorzBarAreaEh.Create(Self);
end;

function TPlannerHorzTimelineViewEh.GetHoursColArea: THoursHorzBarAreaEh;
begin
  Result := THoursHorzBarAreaEh(inherited HoursBarArea);
end;

procedure TPlannerHorzTimelineViewEh.SetHoursColArea(const Value: THoursHorzBarAreaEh);
begin
  inherited HoursBarArea := Value;
end;

function TPlannerHorzTimelineViewEh.GetDatesRowArea: TDatesRowAreaEh;
begin
  Result := TDatesRowAreaEh(DatesBarArea);
end;

procedure TPlannerHorzTimelineViewEh.SetDatesRowArea(
  const Value: TDatesRowAreaEh);
begin
  DatesBarArea := Value;
end;

function TPlannerHorzTimelineViewEh.CreateDatesBarArea: TDatesBarAreaEh;
begin
  Result := TDatesRowAreaEh.Create(Self);
end;

{ TPlannerHorzDayslineViewEh }

constructor TPlannerHorzDayslineViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TimeRange := dlrWeekEh;
end;

destructor TPlannerHorzDayslineViewEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPlannerHorzDayslineViewEh.BuildDaysGridData;
var
  i: Integer;
  RowGroups: Integer;
  AColCount: Integer;
  AFixedRowCount, AFixedColCount: Integer;
  RowHeight: Integer;
  FitGap: Integer;
  ADayGroupRowHeight: Integer;
  DataRowsHeight: Integer;
begin

  AFixedRowCount := TopGridLineCount;

  if ResourceCaptionArea.Visible then
  begin
    RowGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(RowGroups);
    if RowGroups = 0  then
      RowGroups := 1;

    AColCount := FCellsInBand + 1;
    AFixedColCount := 1;
    FResourceAxisPos := 0;
  end else
  begin
    RowGroups := ResourcesCount;
    if FShowUnassignedResource then
      Inc(RowGroups);
    if RowGroups = 0  then
      RowGroups := 1;

    AColCount := FCellsInBand;
    AFixedColCount := 0;
    FResourceAxisPos := -1;
  end;

  if DayNameArea.Visible then
  begin
    FDayNameBarPos := AFixedColCount;
    Inc(AColCount);
    Inc(AFixedColCount);
  end else
    FDayNameBarPos := -1;

  if DatesBarArea.Visible then
  begin
    FDaySplitModeRow := AFixedRowCount;
    AFixedRowCount := AFixedRowCount + 1;
    FDataRowsOffset := AFixedRowCount;
  end else
  begin
    FDataRowsOffset := AFixedRowCount;
    FDaySplitModeRow := -1;
  end;

  FHoursBarIndex := -1;
  FDayGroupRow := -1;

  FixedRowCount := AFixedRowCount;
  FixedColCount := AFixedColCount;
  FDataColsOffset := AFixedColCount;

  ColCount := AColCount;
  RowCount := AFixedRowCount + RowGroups + (RowGroups-1);
  SetGridSize(FullColCount, FullRowCount);
  if RowGroups = 1
    then FBarsPerRes := 1
    else FBarsPerRes := 2;

  if TopGridLineCount > 0 then
    RowHeights[FTopGridLineIndex] := 1;


  if FDaySplitModeRow >= 0 then
  begin
    RowHeights[FDaySplitModeRow] := DatesBarArea.GetActualSize;
    ADayGroupRowHeight := DatesBarArea.GetActualSize;
  end else
    ADayGroupRowHeight := 0;

  DataRowsHeight := (GridClientHeight - ADayGroupRowHeight - (RowGroups-1)*3);
  RowHeight := DataRowsHeight div RowGroups;
  if RowHeight < MinDataRowHeight then
  begin
    RowHeight := MinDataRowHeight;
    VertScrollBar.VisibleMode := sbAutoShowEh;
    FitGap := 0;
  end else
  begin
    VertScrollBar.VisibleMode := sbNeverShowEh;
    FitGap := DataRowsHeight mod RowGroups;
  end;

  for i := FixedRowCount to RowCount-1 do
  begin
    if IsInterResourceCell(0, i) then
    begin
      RowHeights[i] := 3;
    end else
    begin
      if FitGap > 0
        then RowHeights[i] := RowHeight + 1
        else RowHeights[i] := RowHeight;
      Dec(FitGap);
    end;
  end;

  if HandleAllocated then
  begin
    Canvas.Font := Font;
    DefaultColWidth := DataBarsArea.GetActualColWidth;
    for i := 0 to ColCount-1 do
      ColWidths[i] := DefaultColWidth;

    if FResourceAxisPos >= 0 then
      ColWidths[FResourceAxisPos] := ResourceCaptionArea.GetActualSize;

    if FDayNameBarPos >= 0 then
      ColWidths[FDayNameBarPos] := DayNameArea.GetActualSize;
  end;

  MergeCells(0,0, FixedColCount-1,FixedRowCount-1);

end;

procedure TPlannerHorzDayslineViewEh.DrawDaySplitModeDateCell(ACol,
  ARow: Integer; ARect: TRect; State: TGridDrawState; ADataRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  PlannerControl.GetActualDrawStyle.DrawHorzDayslineViewDateCell(
    Self, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerHorzDayslineViewEh.GetDateCellDrawParams(ACol, ARow: Integer;
  ARect: TRect; State: TGridDrawState; ALocalCol, ALocalRow: Integer;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  CellDateTime: TDateTime;
  wn: String;
begin
  CellDateTime := CellToDateTime(ACol, ARow);

  DrawArgs.FontColor := DatesBarArea.Font.Color;
  DrawArgs.FontName := DatesBarArea.Font.Name;
  DrawArgs.FontSize := DatesBarArea.Font.Size;
  DrawArgs.FontStyle := DatesBarArea.Font.Style;
  DrawArgs.BackColor := DatesBarArea.GetActualColor;

  wn := FormatSettings.ShortDayNames[DayOfWeek(CellDateTime)];
  DrawArgs.Text := wn + ', ' + FormatDateTime('D', CellDateTime);
  DrawArgs.Value := CellDateTime;
  DrawArgs.HorzMargin := Canvas.TextWidth('0') div 2;
  DrawArgs.VertMargin := 2;
  DrawArgs.Alignment := taLeftJustify;
  DrawArgs.Layout := tlTop;
end;

function TPlannerHorzDayslineViewEh.GetTimeRange: TDayslineRangeEh;
begin
  case RangeKind of
    rkWeekByDaysEh: Result := dlrWeekEh;
    rkMonthByDaysEh: Result := dlrMonthEh;
  else
    raise Exception.Create('TPlannerVertDayslineViewEh.RangeKind is inavlide');
  end;
end;

procedure TPlannerHorzDayslineViewEh.SetTimeRange(
  const Value: TDayslineRangeEh);
const
  RangeDays: array [TDayslineRangeEh] of TTimePlanRangeKind = (rkWeekByDaysEh, rkMonthByDaysEh);
begin
  RangeKind := RangeDays[Value];
end;

function TPlannerHorzDayslineViewEh.IsWorkingTime(const Value: TDateTime): Boolean;
begin
  Result := True;
end;

{ TPlannerGridLineParamsEh }

constructor TPlannerGridLineParamsEh.Create(AGrid: TCustomGridEh);
begin
  inherited Create(AGrid);
  FPaleColor := clDefault;
end;

function TPlannerGridLineParamsEh.DefaultPaleColor: TColor;
begin
  Result := ApproximateColor(GetBrightColor,
    CheckSysColor(PlannerView.Color), 255 div 2);
end;

function TPlannerGridLineParamsEh.GetBrightColor: TColor;
begin
  if BrightColor = clDefault then
  begin
    Result := PlannerView.PlannerControl.GetActualDrawStyle.BrightLineColor;
    if Result = clDefault then
      Result := inherited GetBrightColor;
  end else
    Result := inherited GetBrightColor;
end;

function TPlannerGridLineParamsEh.GetDarkColor: TColor;
begin
  if DarkColor = clDefault then
  begin
    Result := PlannerView.PlannerControl.GetActualDrawStyle.DarkLineColor;
    if Result = clDefault then
      Result := inherited GetDarkColor;
  end else
    Result := inherited GetDarkColor;
end;

function TPlannerGridLineParamsEh.GetPaleColor: TColor;
begin
  if PaleColor <> clDefault
    then Result := PaleColor
    else Result := DefaultPaleColor;
end;

function TPlannerGridLineParamsEh.GetPlannerView: TCustomPlannerViewEh;
begin
  Result := TCustomPlannerViewEh(Grid);
end;

procedure TPlannerGridLineParamsEh.SetPaleColor(const Value: TColor);
begin
  if PaleColor <> Value then
  begin
    FPaleColor := Value;
    Grid.Invalidate;
  end;
end;

{ TPlannerInGridControlEh }

constructor TPlannerInGridControlEh.Create(AGrid: TCustomPlannerViewEh);
begin
  inherited Create(AGrid);
  FGrid := AGrid;
  DoubleBuffered := True;
end;

destructor TPlannerInGridControlEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPlannerInGridControlEh.Click;
begin
  if ControlType = pgctNextEventEh then
    FGrid.GotoNextEventInTheFuture
  else
    FGrid.GotoPriorEventInThePast;
end;

procedure TPlannerInGridControlEh.Paint;
var
  AText: String;
begin
  Canvas.Brush.Color := FGrid.EventNavBoxColor;
  Canvas.FillRect(Rect(0,0,Width,Height));
  Canvas.Brush.Color := FGrid.EventNavBoxBorderColor;
  Canvas.FrameRect(Rect(0,0,Width,Height));
  if ControlType = pgctNextEventEh
    then AText := EhLibLanguageConsts.PlannerNextEventEh
    else AText := EhLibLanguageConsts.PlannerPriorEventEh;

  Canvas.Font := FGrid.EventNavBoxFont;
  Canvas.Font.Color := CheckSysColor(FGrid.EventNavBoxFont.Color);
  if not ClickEnabled then
    Canvas.Font.Color := CheckSysColor(clGrayText);

  WriteTextVerticalEh(Canvas, Rect(0,0,Width,Height), False, 0, 0, AText,
    taCenter, tlCenter, False, False, False);
end;

procedure TPlannerInGridControlEh.Realign;
begin
  FGrid.RealignGridControl(Self);
end;

{ TInGridControlEh }

constructor TInGridControlEh.Create(AGrid: TCustomPlannerViewEh);
begin
  inherited Create;
  FGrid := AGrid;
end;

destructor TInGridControlEh.Destroy;
begin

  inherited Destroy;
end;

procedure TInGridControlEh.Assign(Source: TPersistent);
begin
  if Source is TInGridControlEh then
  begin
    FHorzLocating := TInGridControlEh(Source).HorzLocating;
    FVertLocating := TInGridControlEh(Source).VertLocating;
    FBoundRect := TInGridControlEh(Source).BoundRect;
  end;
end;

procedure TInGridControlEh.DblClick;
begin

end;

procedure TInGridControlEh.GetInGridDrawRect(var ARect: TRect);
begin
  ARect := BoundRect;
  if HorzLocating = brrlGridRolAreaEh then
    OffsetRect(ARect, PlannerView.HorzAxis.FixedBoundary - PlannerView.HorzAxis.RolStartVisPos, 0);
  if VertLocating = brrlGridRolAreaEh then
    OffsetRect(ARect, 0, PlannerView.VertAxis.FixedBoundary - PlannerView.VertAxis.RolStartVisPos);
end;

{ TMoveHintWindow }

procedure TMoveHintWindow.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

{ TTimeSpanParamsEh }

constructor TDrawElementParamsEh.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;

  FColor := clDefault;
  FFontStored := False;
  FAltColor := clDefault;
  FFillStyle := fsDefaultEh;
  FBorderColor := clDefault;
  FHue := clDefault;
end;

destructor TDrawElementParamsEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TDrawElementParamsEh.NotifyChanges;
begin
end;

procedure TDrawElementParamsEh.SetAltColor(const Value: TColor);
begin
  if FAltColor <> Value then
  begin
    FAltColor := Value;
    NotifyChanges;
  end;
end;

procedure TDrawElementParamsEh.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    NotifyChanges;
  end;
end;

procedure TDrawElementParamsEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    NotifyChanges;
  end;
end;

procedure TDrawElementParamsEh.SetHue(const Value: TColor);
begin
  if FHue <> Value then
  begin
    FHue := Value;
    NotifyChanges;
  end;
end;

procedure TDrawElementParamsEh.SetFillStyle(const Value: TPropFillStyleEh);
begin
  if FFillStyle <> Value then
  begin
    FFillStyle := Value;
    NotifyChanges;
  end;
end;

function TDrawElementParamsEh.DefaultFont: TFont;
begin
  Result := nil;
end;

procedure TDrawElementParamsEh.FontChanged(Sender: TObject);
begin
  NotifyChanges;
  FFontStored := True;
end;

function TDrawElementParamsEh.GetActualColor: TColor;
begin
  if Color <> clDefault
    then Result := Color
    else Result := GetDefaultColor;
end;

function TDrawElementParamsEh.GetActualAltColor: TColor;
begin
  if AltColor <> clDefault
    then Result := AltColor
    else Result := GetDefaultAltColor;
end;

function TDrawElementParamsEh.GetActualBorderColor: TColor;
begin
  if BorderColor <> clDefault
    then Result := BorderColor
    else Result := GetDefaultBorderColor;
end;

function TDrawElementParamsEh.GetActualFillStyle: TPropFillStyleEh;
begin
  Result := FillStyle;
end;

function TDrawElementParamsEh.GetActualHue: TColor;
begin
  if Hue <> clDefault
    then Result := Hue
    else Result := CheckSysColor(clSkyBlue);
end;

function TDrawElementParamsEh.GetDefaultAltColor: TColor;
begin
  Result := Color;
end;

function TDrawElementParamsEh.GetDefaultBorderColor: TColor;
begin
  Result := clNone;
end;

function TDrawElementParamsEh.GetDefaultColor: TColor;
begin
  Result := clNone;
end;

function TDrawElementParamsEh.GetDefaultFillStyle: TPropFillStyleEh;
begin
  Result := fsSolidEh;
end;

function TDrawElementParamsEh.GetDefaultHue: TColor;
begin
  Result := clNone;
end;

procedure TDrawElementParamsEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TDrawElementParamsEh.SetFontStored(const Value: Boolean);
begin
  if FFontStored <> Value then
  begin
    FFontStored := Value;
    RefreshDefaultFont;
  end;
end;

function TDrawElementParamsEh.IsFontStored: Boolean;
begin
  Result := FontStored;
end;

procedure TDrawElementParamsEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if FontStored then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    AssignFontDefaultProps;
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TDrawElementParamsEh.AssignFontDefaultProps;
begin
  FFont.Assign(DefaultFont);
end;

{ TPlannerControlTimeSpanParamsEh }

constructor TPlannerControlTimeSpanParamsEh.Create(APlanner: TPlannerControlEh);
begin
  FPlanner := APlanner;
  inherited Create;
  FDefaultColor := clNone;
  FDefaultAltColor := clNone;
  FDefaultBorderColor := clNone;
  FDblClickOpenEventEditor := True;
end;

destructor TPlannerControlTimeSpanParamsEh.Destroy;
begin
  inherited Destroy;
end;

function TPlannerControlTimeSpanParamsEh.GetDefaultAltColor: TColor;
begin
  Result := FDefaultAltColor;
end;

function TPlannerControlTimeSpanParamsEh.GetDefaultBorderColor: TColor;
begin
  Result := FDefaultBorderColor;
end;

function TPlannerControlTimeSpanParamsEh.GetDefaultColor: TColor;
begin
  Result := FDefaultColor;
end;

function TPlannerControlTimeSpanParamsEh.GetDefaultFillStyle: TPropFillStyleEh;
begin
  Result := fsVerticalGradientEh;
end;

function TPlannerControlTimeSpanParamsEh.GetDefaultHue: TColor;
begin
  Result := CheckSysColor(clSkyBlue);
end;

function TPlannerControlTimeSpanParamsEh.DefaultFont: TFont;
begin
  Result := Planner.Font;
end;

procedure TPlannerControlTimeSpanParamsEh.NotifyChanges;
begin
  Planner.LayoutChanged;
  ResetDefaultProps;
end;

procedure TPlannerControlTimeSpanParamsEh.ResetDefaultProps;
var
  DefHue: TColor;
begin
  DefHue := ChangeColorLuminance(GetActualHue, 206);
  FDefaultColor := ChangeRelativeColorLuminance(DefHue, 20);
  FDefaultAltColor := DefHue;
  FDefaultBorderColor := ChangeColorLuminance(GetActualHue, 76);
end;

procedure TPlannerControlTimeSpanParamsEh.SetPopupMenu(const Value: TPopupMenu);
begin
  FPopupMenu := Value;
end;

{ TEventNavBoxParamsEh }

constructor TEventNavBoxParamsEh.Create(APlanner: TPlannerControlEh);
begin
  inherited Create;
  FPlanner := APlanner;
  FVisible := True;
end;

destructor TEventNavBoxParamsEh.Destroy;
begin
  inherited Destroy;
end;

function TEventNavBoxParamsEh.GetDefaultBorderColor: TColor;
begin
  Result := Planner.GetDefaultEventNavBoxBorderColor;
end;

function TEventNavBoxParamsEh.GetDefaultColor: TColor;
begin
  Result := Planner.GetDefaultEventNavBoxColor;
end;

function TEventNavBoxParamsEh.DefaultFont: TFont;
begin
  Result := Planner.Font;
end;

procedure TEventNavBoxParamsEh.NotifyChanges;
begin
  Planner.NavBoxParamsChanges;
end;

procedure TEventNavBoxParamsEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    NotifyChanges;
  end;
end;

{ THoursBarAreaEh }


function THoursBarAreaEh.DefaultFont: TFont;
begin
  Result := PlannerView.Font;
end;

function THoursBarAreaEh.DefaultColor: TColor;
begin
  Result := ApproachToColorEh(CheckSysColor(PlannerView.Color),
                              CheckSysColor(clBtnFace),
                              15);
end;

procedure THoursBarAreaEh.AssignFontDefaultProps;
begin
  FFont.Assign(DefaultFont);
  FFont.Size := FFont.Size * 3 div 2;
end;

function THoursBarAreaEh.DefaultVisible: Boolean;
begin
  Result := True;
end;

function THoursBarAreaEh.DefaultSize: Integer;
begin
  Result := PlannerView.DefaultHoursBarSize;
end;

{ THoursVertBarAreaEh }

function THoursVertBarAreaEh.GetWidth: Integer;
begin
  Result := Size;
end;

procedure THoursVertBarAreaEh.SetWidth(const Value: Integer);
begin
  Size := Value;
end;

{ THoursHorzBarAreaEh }

function THoursHorzBarAreaEh.GetHeight: Integer;
begin
  Result := Size;
end;

procedure THoursHorzBarAreaEh.SetHeight(const Value: Integer);
begin
  Size := Value;
end;

{ TDayNameAreaEh }

function TDayNameAreaEh.DefaultFont: TFont;
begin
  Result := PlannerView.GetDayNameAreaDefaultFont;
end;

function TDayNameAreaEh.DefaultSize: Integer;
begin
  Result := PlannerView.GetDayNameAreaDefaultSize;
end;

function TDayNameAreaEh.DefaultColor: TColor;
begin
  Result := PlannerView.GetDayNameAreaDefaultColor;
end;

function TDayNameAreaEh.DefaultVisible: Boolean;
begin
  Result := PlannerView.IsDayNameAreaNeedVisible;
end;

{ TResourceCaptionAreaEh }

function TResourceCaptionAreaEh.DefaultSize: Integer;
begin
  Result := PlannerView.GetResourceCaptionAreaDefaultSize;
end;

function TResourceCaptionAreaEh.DefaultFont: TFont;
begin
  Result := PlannerView.Font;
end;

function TResourceCaptionAreaEh.DefaultVisible: Boolean;
begin
  Result := PlannerView.IsResourceCaptionNeedVisible;
end;

function TResourceCaptionAreaEh.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

procedure TResourceCaptionAreaEh.SetVisible(const Value: Boolean);
begin
  FEnhancedChanges := True;
  try
    inherited Visible := Value;
  finally
    FEnhancedChanges := False;
  end;
end;

procedure TResourceCaptionAreaEh.NotifyChanges;
begin
  if FEnhancedChanges and not (csLoading in PlannerView.ComponentState) then
    PlannerView.ResetLoadedTimeRange;
  inherited NotifyChanges;
end;

function TResourceCaptionAreaEh.DefaultColor: TColor;
begin
  Result := PlannerView.FixedColor;
end;

{ TResourceVertCaptionAreaEh }

function TResourceVertCaptionAreaEh.GetHeight: Integer;
begin
  Result := Size;
end;

procedure TResourceVertCaptionAreaEh.SetHeight(const Value: Integer);
begin
  Size := Value;
end;

{ TResourceHorzCaptionAreaEh }

function TResourceHorzCaptionAreaEh.GetWidth: Integer;
begin
  Result := Size;
end;

procedure TResourceHorzCaptionAreaEh.SetWidth(const Value: Integer);
begin
  Size := Value;
end;

{ TWeekBarAreaEh }

procedure TWeekBarAreaEh.AssignFontDefaultProps;
begin
  FFont.Assign(DefaultFont);
end;

{ TPlannerViewDrawElementEh }

constructor TPlannerViewDrawElementEh.Create(APlannerView: TCustomPlannerViewEh);
begin
  inherited Create;

  FPlannerView := APlannerView;

  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;

  FColor := clDefault;
  FFontStored := False;
  FSize := 0;
  FVisible := True;
  FVisibleStored := False;
end;

destructor TPlannerViewDrawElementEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;


function TPlannerViewDrawElementEh.DefaultFont: TFont;
begin
  Result := PlannerView.Font;
end;

procedure TPlannerViewDrawElementEh.FontChanged(Sender: TObject);
begin
  NotifyChanges;
  FFontStored := True;
end;

function TPlannerViewDrawElementEh.IsFontStored: Boolean;
begin
  Result := FontStored;
end;

procedure TPlannerViewDrawElementEh.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if FontStored then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    AssignFontDefaultProps;
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TPlannerViewDrawElementEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TPlannerViewDrawElementEh.SetFontStored(const Value: Boolean);
begin
  if FFontStored <> Value then
  begin
    FFontStored := Value;
    RefreshDefaultFont;
  end;
end;

procedure TPlannerViewDrawElementEh.AssignFontDefaultProps;
begin
  FFont.Assign(DefaultFont);
end;


function TPlannerViewDrawElementEh.GetVisible: Boolean;
begin
  if VisibleStored
    then Result := FVisible
    else Result := DefaultVisible;
end;

function TPlannerViewDrawElementEh.IsVisibleStored: Boolean;
begin
  Result := FVisibleStored;
end;

procedure TPlannerViewDrawElementEh.SetVisible(const Value: Boolean);
begin
  if VisibleStored and (Value = FVisible) then Exit;
  VisibleStored := True;
  FVisible := Value;
  NotifyChanges;
end;

procedure TPlannerViewDrawElementEh.SetVisibleStored(const Value: Boolean);
var
  OldVisible: Boolean;
begin
  OldVisible := Visible;
  if (Value = True) and (IsVisibleStored = False) then
  begin
    FVisibleStored := True;
    FVisible := DefaultVisible;
  end else if (Value = False) and (IsVisibleStored = True) then
  begin
    FVisibleStored := False;
    FVisible := DefaultVisible;
  end;
  if OldVisible <> Visible then
    NotifyChanges;
end;

function TPlannerViewDrawElementEh.DefaultVisible: Boolean;
begin
  {$IFDEF FPC}
  Result := False;
  {$ELSE}
  {$ENDIF}
  raise Exception.Create('TPlannerViewDrawElementEh.DefaultVisible');
end;


procedure TPlannerViewDrawElementEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    NotifyChanges;
  end;
end;

function TPlannerViewDrawElementEh.GetActualColor: TColor;
begin
  if Color <> clDefault
    then Result := Color
    else Result := DefaultColor;
end;

function TPlannerViewDrawElementEh.DefaultColor: TColor;
begin
  Result := PlannerView.Color;
end;

procedure TPlannerViewDrawElementEh.SetSize(const Value: Integer);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    NotifyChanges;
  end;
end;

function TPlannerViewDrawElementEh.GetActualSize: Integer;
begin
  if Size <> 0
    then Result := Size
    else Result := DefaultSize;
end;

function TPlannerViewDrawElementEh.DefaultSize: Integer;
begin
  {$IFDEF FPC}
  Result := 0;
  {$ELSE}
  {$ENDIF}
  raise Exception.Create('TPlannerViewDrawElementEh.DefaultSize');
end;

procedure TPlannerViewDrawElementEh.NotifyChanges;
begin
  PlannerView.GridLayoutChanged;
  PlannerView.Invalidate;
end;

{ TDatesBarAreaEh }

function TDatesBarAreaEh.DefaultSize: Integer;
begin
  Result := PlannerView.GetDefaultDatesBarSize;
end;

function TDatesBarAreaEh.DefaultVisible: Boolean;
begin
  Result := PlannerView.GetDefaultDatesBarVisible;
end;

function TDatesBarAreaEh.GetPlannerView: TPlannerAxisTimelineViewEh;
begin
  Result := TPlannerAxisTimelineViewEh(inherited PlannerView);
end;

{ TDatesColAreaEh }

function TDatesColAreaEh.GetWidth: Integer;
begin
  Result := Size;
end;

procedure TDatesColAreaEh.SetWidth(const Value: Integer);
begin
  Size := Value;
end;

{ TDatesRowAreaEh }

function TDatesRowAreaEh.GetHeight: Integer;
begin
  Result := Size;
end;

procedure TDatesRowAreaEh.SetHeight(const Value: Integer);
begin
  Size := Value;
end;

{ TDayNameVertAreaEh }

function TDayNameVertAreaEh.GetActualHeight: Integer;
begin
  Result := GetActualSize;
end;

function TDayNameVertAreaEh.GetHeight: Integer;
begin
  Result := Size;
end;

procedure TDayNameVertAreaEh.SetHeight(const Value: Integer);
begin
  Size := Value;
end;

{ TDayNameHorzAreaEh }

function TDayNameHorzAreaEh.GetActualWidth: Integer;
begin
  Result := GetActualSize;
end;

function TDayNameHorzAreaEh.GetWidth: Integer;
begin
  Result := Size;
end;

procedure TDayNameHorzAreaEh.SetWidth(const Value: Integer);
begin
  Size := Value;
end;

{ TDataBarsAreaEh }

constructor TDataBarsAreaEh.Create(APlannerView: TCustomPlannerViewEh);
begin
  inherited Create;

  FPlannerView := APlannerView;
  FColor := clDefault;
  FBarSize := 0;
end;

destructor TDataBarsAreaEh.Destroy;
begin
  inherited Destroy;
end;

function TDataBarsAreaEh.DefaultColor: TColor;
begin
  Result := PlannerView.Color;
end;

function TDataBarsAreaEh.DefaultBarSize: Integer;
begin
  Result := PlannerView.GetDataBarsAreaDefaultBarSize;
end;

function TDataBarsAreaEh.GetActualColor: TColor;
begin
  if Color <> clDefault
    then Result := Color
    else Result := DefaultColor;
end;

function TDataBarsAreaEh.GetActualBarSize: Integer;
begin
  if BarSize <> 0
    then Result := BarSize
    else Result := DefaultBarSize;
end;

procedure TDataBarsAreaEh.NotifyChanges;
begin
  PlannerView.GridLayoutChanged;
  PlannerView.Invalidate;
end;

procedure TDataBarsAreaEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    NotifyChanges;
  end;
end;

procedure TDataBarsAreaEh.SetBarSize(const Value: Integer);
begin
  if FBarSize <> Value then
  begin
    FBarSize := Value;
    NotifyChanges;
  end;
end;

{ TDataBarsVertAreaEh }

function TDataBarsVertAreaEh.GetActualRowHeight: Integer;
begin
  Result := GetActualBarSize;
end;

function TDataBarsVertAreaEh.GetRowHeight: Integer;
begin
  Result := BarSize;
end;

procedure TDataBarsVertAreaEh.SetRowHeight(const Value: Integer);
begin
  BarSize := Value;
end;

{ TDataBarsHorzAreaEh }

function TDataBarsHorzAreaEh.GetActualColWidth: Integer;
begin
  Result := GetActualBarSize;
end;

function TDataBarsHorzAreaEh.GetColWidth: Integer;
begin
  Result := BarSize;
end;

procedure TDataBarsHorzAreaEh.SetColWidth(const Value: Integer);
begin
  BarSize := Value;
end;

{ TPlannerVertHourslineViewEh }

constructor TPlannerVertHourslineViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TimeRange := hlrDayEh;
end;

destructor TPlannerVertHourslineViewEh.Destroy;
begin
  inherited Destroy;
end;

function TPlannerVertHourslineViewEh.GetTimeRange: THourslineRangeEh;
begin
  case RangeKind of
    rkDayByHoursEh: Result := hlrDayEh;
    rkWeekByHoursEh: Result := hlrWeekEh;
  else
    raise Exception.Create('TPlannerVertHourslineViewEh.RangeKind is inavlide');
  end
end;

procedure TPlannerVertHourslineViewEh.SetTimeRange(const Value: THourslineRangeEh);
const
  RangeDays: array [THourslineRangeEh] of TTimePlanRangeKind = (rkDayByHoursEh, rkWeekByHoursEh);
begin
  RangeKind := RangeDays[Value];
end;

procedure TPlannerVertHourslineViewEh.GetCurrentTimeLineRect(var CurTLRect: TRect);
var
  SecOfDay: LongWord;
  InRolPos: Int64;
  ScreenPos: Integer;
  DaysLen: LongWord;
  FullDaySecsToNow: LongWord;
begin
  case RangeKind of
    rkDayByHoursEh:
      DaysLen := 1;
    rkWeekByHoursEh:
      DaysLen := 7;
    rkWeekByDaysEh:
      DaysLen := 7;
    rkMonthByDaysEh:
      DaysLen := DaysInMonth(StartDate);
  else
    DaysLen := 0;
  end;

  if (DaysLen > 0) and
     (Today >= DateOf(StartDate)) and
     (Today < DateOf(StartDate+DaysLen)) then
  begin
    FullDaySecsToNow := DaysBetween(Today, StartDate) * (24 * 60 * 60);
    SecOfDay := SecondOfTheDay(Now) + FullDaySecsToNow;
    InRolPos := Round(VertAxis.RolLen * SecOfDay / (24 * 60 * 60 * DaysLen));
    ScreenPos := InRolPos - VertAxis.RolStartVisPos + VertAxis.FixedBoundary;
    CurTLRect := Rect(0, ScreenPos-1, HorzAxis.FixedBoundary, ScreenPos+2);
  end else
    CurTLRect := EmptyRect;
end;

{ TPlannerHorzHourslineViewEh }

constructor TPlannerHorzHourslineViewEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TimeRange := hlrDayEh;
end;

destructor TPlannerHorzHourslineViewEh.Destroy;
begin
  inherited Destroy;
end;

function TPlannerHorzHourslineViewEh.GetTimeRange: THourslineRangeEh;
begin
  case RangeKind of
    rkDayByHoursEh: Result := hlrDayEh;
    rkWeekByHoursEh: Result := hlrWeekEh;
  else
    raise Exception.Create('TPlannerVertHourslineViewEh.RangeKind is inavlide');
  end
end;

procedure TPlannerHorzHourslineViewEh.SetTimeRange(
  const Value: THourslineRangeEh);
const
  RangeDays: array [THourslineRangeEh] of TTimePlanRangeKind = (rkDayByHoursEh, rkWeekByHoursEh);
begin
  RangeKind := RangeDays[Value];
end;

procedure TPlannerHorzHourslineViewEh.GetCurrentTimeLineRect(var CurTLRect: TRect);
var
  SecOfDay: LongWord;
  InRolPos: Int64;
  ScreenPos: Integer;
  DaysLen: LongWord;
  FullDaySecsToNow: LongWord;
begin
  case RangeKind of
    rkDayByHoursEh:
      DaysLen := 1;
    rkWeekByHoursEh:
      DaysLen := 7;
    rkWeekByDaysEh:
      DaysLen := 7;
    rkMonthByDaysEh:
      DaysLen := DaysInMonth(StartDate);
  else
    DaysLen := 0;
  end;

  if (DaysLen > 0) and
     (Today >= DateOf(StartDate)) and
     (Today < DateOf(StartDate+DaysLen)) then
  begin
    FullDaySecsToNow := DaysBetween(Today, StartDate) * (24 * 60 * 60);
    SecOfDay := SecondOfTheDay(Now) + FullDaySecsToNow;
    InRolPos := Round(HorzAxis.RolLen * SecOfDay / (24 * 60 * 60 * DaysLen));
    ScreenPos := InRolPos - HorzAxis.RolStartVisPos + HorzAxis.FixedBoundary;
    CurTLRect := Rect(ScreenPos-1, 0, ScreenPos+2, VertAxis.FixedBoundary);
  end else
    CurTLRect := EmptyRect;
end;

{$IFDEF FPC}
{$ELSE}

{ TCustomPlannerControlPrintServiceEh }

constructor TCustomPlannerControlPrintServiceEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomPlannerControlPrintServiceEh.Destroy;
begin
  inherited Destroy;
end;
{$ENDIF}

{ TPlannerDrawStyleEh }

function TPlannerDrawStyleEh.AdjustNonworkingTimeBackColor(
  PlannerControl: TPlannerControlEh; BaseColor, BackColor,
  FontColor: TColor): TColor;
begin
  Result := ApproximateColor(CheckSysColor(BaseColor),
             CheckSysColor(BackColor), 128);
end;

constructor TPlannerDrawStyleEh.Create;
begin
  inherited Create;
  FTodayFrameColor := clDefault;
  FNonworkingTimeBackColor := clDefault;
  FCachedResourceCellFillColor1 := clNone;
  FCachedResourceCellFillColor2 := clNone;
end;

function TPlannerDrawStyleEh.GetActlTodayFrameColor: TColor;
begin
  if TodayFrameColor = clDefault
    then Result := RGB(235, 137, 0)
    else Result := TodayFrameColor;
end;

function TPlannerDrawStyleEh.GetTodayFrameColor: TColor;
begin
  Result := FTodayFrameColor;
end;

procedure TPlannerDrawStyleEh.SetTodayFrameColor(const Value: TColor);
begin
  if Value <> FTodayFrameColor then
  begin
    FTodayFrameColor := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TPlannerDrawStyleEh.SetNonworkingTimeBackColor(const Value: TColor);
begin
  if Value <> FNonworkingTimeBackColor then
  begin
    FTodayFrameColor := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

function TPlannerDrawStyleEh.GetNonworkingTimeBackColor: TColor;
begin
  Result := FNonworkingTimeBackColor;
end;

function TPlannerDrawStyleEh.GetDarkLineColor: TColor;
{$IFDEF EH_LIB_16}
const
  CFixedStates: array[Boolean] of TThemedGrid =
    (tgGradientFixedCellNormal, tgFixedCellNormal);
   
{$ENDIF}
{$IFDEF FPC}
{$ELSE}
var
  LColorRef: TColorRef;
{$ENDIF}
{$IFDEF EH_LIB_16}
  LStyle: TCustomStyleServices;
{$ENDIF}
begin
  {$IFDEF EH_LIB_16}
  if CustomStyleActive then
  begin
    LStyle := StyleServices;
    LStyle.GetElementColor(LStyle.GetElementDetails(CFixedStates[False]), ecBorderColor, Result);
  end else
  {$ENDIF}
  {$IFDEF FPC}
  {$ELSE}
  if ThemesEnabled and (Win32MajorVersion >= 6) then
  begin
    GetThemeColor(ThemeServices.Theme[teHeader], HP_HEADERITEM, HIS_NORMAL,
      TMT_EDGEFILLCOLOR, LColorRef);
    Result := LColorRef;
  end else
  {$ENDIF}
    Result := clDefault;
end;

function TPlannerDrawStyleEh.GetBrightLineColor: TColor;
begin
  Result := GetDarkLineColor;
end;

function TPlannerDrawStyleEh.GetEventNavBoxBorderColor: TColor;
begin
  Result := ChangeColorLuminance(ResourceCellFillColor, 150);
end;

function TPlannerDrawStyleEh.GetEventNavBoxFillColor: TColor;
begin
  Result := ResourceCellFillColor;
end;

function TPlannerDrawStyleEh.GetResourceCellFillColor: TColor;
begin
  if (FCachedResourceCellFillColor1 <> CheckSysColor(clBtnFace)) or
     (FCachedResourceCellFillColor2 <> CheckSysColor(clWindow))
  then
  begin
    FCachedResourceCellFillColor1 := CheckSysColor(clBtnFace);
    FCachedResourceCellFillColor2 := CheckSysColor(clWindow);
    FCachedResourceCellFillColor := ApproximateColor(
      FCachedResourceCellFillColor1, FCachedResourceCellFillColor2, 128);
  end;
  Result := FCachedResourceCellFillColor;
end;

function TPlannerDrawStyleEh.GetSelectedFocusedCellColor: TColor;
begin
  FCachedSelectedFocusedCellColor := ApproximateColor(
    CheckSysColor(clHighlight),
    CheckSysColor(clBtnFace), 200);
  Result := FCachedSelectedFocusedCellColor;
end;

function TPlannerDrawStyleEh.GetSelectedUnfocusedCellColor: TColor;
begin
  FSelectedUnfocusedCellColor :=  ApproximateColor(
    CheckSysColor(clBtnShadow),
    CheckSysColor(clBtnFace), 200);
  Result := FSelectedUnfocusedCellColor;
end;

function TPlannerDrawStyleEh.GetDayNameAreaFillColor: TColor;
begin
  Result := ResourceCellFillColor;
end;

function TPlannerDrawStyleEh.GetDayNameAreaFont(PlannerView: TCustomPlannerViewEh;
  const BaseFont: TFont): TFont;
begin
  Result := BaseFont;
end;

procedure TPlannerDrawStyleEh.DrawAlldayDataCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);
  Canvas.FillRect(ARect);
end;

procedure TPlannerDrawStyleEh.DrawInterResourceCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);
  Canvas.FillRect(ARect);
end;

procedure TPlannerDrawStyleEh.DrawTopLeftCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState;
  DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);
  Canvas.FillRect(ARect);
end;

procedure TPlannerDrawStyleEh.DrawWeekViewDayNamesCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh);
begin
  DrawWeekViewDayNamesCellBack(PlannerView, Canvas, ARect, State, DrawArgs);
  DrawWeekViewDayNamesCellFore(PlannerView, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerDrawStyleEh.DrawWeekViewDayNamesCellBack(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh);
var
  IncK: Integer;
begin
  DrawDayNamesCellBack(PlannerView, Canvas, ARect, State, DrawArgs);

  if (DrawArgs.TodayDate = sbTrueEh) and DrawArgs.HighlightToday then
  begin
    IncK := 0;
    if DrawArgs.DrawTopToDayLine then
    begin
      Canvas.Pen.Color := GetActlTodayFrameColor;
      Canvas.Polyline([ARect.TopLeft, Point(ARect.Right, ARect.Top)]);
      IncK := 1;
    end;

    Canvas.Brush.Color := ApproximateColor(Canvas.Brush.Color,
      PlannerDrawStyleEh.GetActlTodayFrameColor, 128);
    Canvas.FillRect(Rect(ARect.Left, ARect.Top+IncK, ARect.Right, ARect.Top+IncK+3));
  end;
end;

procedure TPlannerDrawStyleEh.DrawWeekViewDayNamesCellFore(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState;
  DrawArgs: TPlannerViewDayNamesCellDrawArgsEh);
begin
  DrawDayNamesCellFore(PlannerView, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerDrawStyleEh.DrawResourceCaptionCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  s: String;
  WordWrap: Boolean;
begin
  Canvas.Font.Color := CheckSysColor(DrawArgs.FontColor);
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);
  s := DrawArgs.Text;
  WordWrap := DrawArgs.WordWrap;

  PlannerView.WriteCellText(Canvas, ARect, True, 0, 0, s, taCenter, tlCenter,
    WordWrap, False, 0, 0, False);
end;

procedure TPlannerDrawStyleEh.DrawDataCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState;
  DrawArgs: TPlannerViewCellDrawArgsEh);
var
  AFillRect: TRect;
  Highlighted: Boolean;
begin

  if gdFixed in State then
  begin
    AFillRect := ARect;
    Canvas.Brush.Color := CheckSysColor(PlannerView.Color);
    Canvas.FillRect(AFillRect);
  end else
  begin
    Highlighted := False;

    if gdCurrent in State then
    begin
      Highlighted := True;
      Canvas.Font.Color := CheckSysColor(PlannerView.Font.Color);
      if gdFocused in State then
        Canvas.Brush.Color := SelectedFocusedCellColor
      else
        Canvas.Brush.Color := SelectedUnfocusedCellColor;
    end else if (gdSelected in State) then
    begin
      Highlighted := True;
      if PlannerView.HasFocus then
        Canvas.Brush.Color := SelectedFocusedCellColor
      else
        Canvas.Brush.Color := SelectedUnfocusedCellColor;
    end;


    if not Highlighted then
    begin
      if DrawArgs.WorkTime = sbTrueEh then
        Canvas.Brush.Color := CheckSysColor(PlannerView.Color)
      else
      begin
        Canvas.Brush.Color := PlannerView.GetResourceNonworkingTimeBackColor(
          DrawArgs.Resource, DrawArgs.BackColor, DrawArgs.FontColor);
      end;
    end;

    AFillRect := ARect;
    Canvas.FillRect(AFillRect);

  end;
end;

procedure TPlannerDrawStyleEh.DrawDayNamesCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh);
begin
  DrawDayNamesCellBack(PlannerView, Canvas, ARect, State, DrawArgs);
  DrawDayNamesCellFore(PlannerView, Canvas, ARect, State, DrawArgs);
end;

procedure TPlannerDrawStyleEh.DrawDayNamesCellBack(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh);
begin
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);
  Canvas.FillRect(ARect);
end;

procedure TPlannerDrawStyleEh.DrawDayNamesCellFore(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewDayNamesCellDrawArgsEh);
begin
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);
  Canvas.Font.Color := CheckSysColor(DrawArgs.FontColor);
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;

  PlannerView.WriteCellText(Canvas, ARect, False, 0, 0, DrawArgs.Text , taCenter, tlCenter, False, False, 0, 0, False);

  if DrawArgs.DrawMonthDay then
  begin
    Canvas.Font.Style := DrawArgs.MonthDayFontStyle;
    PlannerView.WriteCellText(Canvas, ARect, False, 2, 2, DrawArgs.MonthDay, taLeftJustify, tlTop, False, False, 0, 0, True);
  end;
end;

procedure TPlannerDrawStyleEh.DrawTimeCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState;
  DrawArgs: TPlannerViewTimeCellDrawArgsEh);
var
  SH, SM: String;
  HourRect, MinRect: TRect;
  CurTimeLineRect: TRect;
  MinRectHeight: Integer;
  HourRectHeight: Integer;
  HourLayout: TTextLayout;
begin

  HourRect := ARect;
  HourRect.Right := (HourRect.Right + HourRect.Left) div 2 + 5;
  MinRect := ARect;
  MinRect.Left := HourRect.Right;

  Canvas.Brush.Color := DrawArgs.BackColor;
  Canvas.Font.Color := DrawArgs.FontColor;
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;

  Canvas.FillRect(ARect);

  if DrawArgs.DrawTimeLine then
  begin
    PlannerView.GetCurrentTimeLineRect(CurTimeLineRect);
    DrawArgs.DrawTimeRect := CurTimeLineRect;
    if RectIntersected(DrawArgs.DrawTimeRect, ARect) then
      PlannerView.DrawCurTimeLineRect(CurTimeLineRect, ARect);
  end;

  SH := DrawArgs.HoursStr;
  SM := DrawArgs.MinutesStr;

  Canvas.Font.Size := DrawArgs.MinutesFontSize;
  Canvas.Font.Color := CheckSysColor(Canvas.Font.Color);
  WriteTextEh(Canvas, MinRect, False, 0, 2, SM,
    taLeftJustify, tlTop, False, False, 0, 0, False, True);

  MinRectHeight := Canvas.TextHeight('Wg');

  Canvas.Font.Size := DrawArgs.HoursFontSize;
  Canvas.Font.Color := CheckSysColor(Canvas.Font.Color);
  HourRectHeight := Canvas.TextHeight('Wg');

  if HourRectHeight + MinRectHeight < RectHeight(ARect) then
  begin
    HourRect.Top := ARect.Top + MinRectHeight;
    HourLayout := tlTop;
  end else
    HourLayout := tlCenter;

  WriteTextEh(Canvas, HourRect, False, 0, 0, SH,
    taRightJustify, HourLayout, False, False, 0, 0, False, True);

end;

procedure TPlannerDrawStyleEh.DrawMonthViewDataCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := DrawArgs.FontColor;
  Canvas.Brush.Color := DrawArgs.BackColor;

  Canvas.FillRect(ARect);

  if DrawArgs.TodayDate = sbTrueEh then
  begin
    Canvas.Brush.Color := ApproximateColor(Canvas.Brush.Color,
      PlannerDrawStyleEh.GetActlTodayFrameColor, 128);
    Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Top+3));
  end;

  WriteTextEh(Canvas, ARect, False, DrawArgs.HorzMargin, DrawArgs.VertMargin,
    DrawArgs.Text, DrawArgs.Alignment, DrawArgs.Layout, DrawArgs.WordWrap,
    False, 0, 0, False, True);
end;

procedure TPlannerDrawStyleEh.DrawMonthViewWeekNoCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  begin
    Canvas.Font.Name := DrawArgs.FontName;
    Canvas.Font.Size := DrawArgs.FontSize;
    Canvas.Font.Style := DrawArgs.FontStyle;
    Canvas.Brush.Color := DrawArgs.BackColor;
    WriteTextVerticalEh(Canvas, ARect, True, 0, 0, DrawArgs.Text,
      taCenter, tlCenter, False, False, False);
  end;
end;

procedure TPlannerDrawStyleEh.DrawYearViewMonthNameCell(PlannerView: TCustomPlannerViewEh;
  Canvas: TCanvas; ARect: TRect; State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  begin
    Canvas.Font.Name := DrawArgs.FontName;
    Canvas.Font.Size := DrawArgs.FontSize;
    Canvas.Font.Style := DrawArgs.FontStyle;
    Canvas.Brush.Color := DrawArgs.BackColor;
    WriteTextEh(Canvas, ARect, True, DrawArgs.HorzMargin, DrawArgs.VertMargin,
      DrawArgs.Text, DrawArgs.Alignment, DrawArgs.Layout, DrawArgs.WordWrap,
      False, 0, 0, False, True);
  end;
end;

procedure TPlannerDrawStyleEh.DrawVertTimelineViewTimeDayCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  s: String;
  w: Integer;
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := DrawArgs.FontColor;
  Canvas.Brush.Color := DrawArgs.BackColor;

  s := DrawArgs.Text;
  w := Canvas.TextWidth('0') div 2;
  WriteTextEh(Canvas, ARect, True, w, 2, s,
    taLeftJustify, tlTop, False, False, 0, 0, False, True);
end;

procedure TPlannerDrawStyleEh.DrawVertTimelineViewTimeGroupCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  s: String;
begin
  s := DrawArgs.Text;

  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := CheckSysColor(DrawArgs.FontColor);
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);

  Canvas.FillRect(ARect);

  if DrawArgs.HighlightToday and (DrawArgs.TodayDate = sbTrueEh) then
  begin
    Canvas.Pen.Color := GetActlTodayFrameColor;
    Canvas.Polyline([ARect.TopLeft, Point(ARect.Left, ARect.Bottom)]);

    Canvas.Brush.Color := ApproximateColor(Canvas.Brush.Color,
      PlannerDrawStyleEh.GetActlTodayFrameColor, 128);
    Canvas.FillRect(Rect(ARect.Left+1, ARect.Top, ARect.Left+3, ARect.Bottom));
  end;

  if ARect.Top < PlannerView.VertAxis.FixedBoundary then
    ARect.Top := PlannerView.VertAxis.FixedBoundary;
  if ARect.Bottom > PlannerView.VertAxis.ContraStart then
    ARect.Bottom := PlannerView.VertAxis.ContraStart;

  WriteTextVerticalEh(Canvas, ARect, False, 0, 0, s, taCenter, tlCenter, False, False, False);
end;

procedure TPlannerDrawStyleEh.DrawVertDayslineViewDateCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := CheckSysColor(DrawArgs.FontColor);
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);

  Canvas.FillRect(ARect);

  if DrawArgs.HighlightToday and (DrawArgs.TodayDate = sbTrueEh) then
  begin
    Canvas.Pen.Color := PlannerDrawStyleEh.GetActlTodayFrameColor;
    Canvas.Polyline([ARect.TopLeft, Point(ARect.Left, ARect.Bottom)]);

    Canvas.Brush.Color := ApproximateColor(Canvas.Brush.Color,
      PlannerDrawStyleEh.GetActlTodayFrameColor, 128);
    Canvas.FillRect(Rect(ARect.Left+1, ARect.Top, ARect.Left+4, ARect.Bottom));
  end;

  WriteTextEh(Canvas, ARect, False, DrawArgs.HorzMargin, DrawArgs.VertMargin,
    DrawArgs.Text, DrawArgs.Alignment, DrawArgs.Layout, False, False, 0, 0,
    False, True);
end;

procedure TPlannerDrawStyleEh.DrawHorzTimelineViewTimeGroupCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
var
  s: String;
begin
  s := DrawArgs.Text;

  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := CheckSysColor(DrawArgs.FontColor);
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);

  Canvas.FillRect(ARect);

  if DrawArgs.HighlightToday and (DrawArgs.TodayDate = sbTrueEh) then
  begin
    Canvas.Brush.Color := ApproximateColor(Canvas.Brush.Color, GetActlTodayFrameColor, 128);
    Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Top+2));
  end;

  if ARect.Left < PlannerView.HorzAxis.FixedBoundary then
    ARect.Left := PlannerView.HorzAxis.FixedBoundary;
  if ARect.Right > PlannerView.HorzAxis.ContraStart then
    ARect.Right := PlannerView.HorzAxis.ContraStart;

  WriteTextEh(Canvas, ARect, False, 0, 2, s, taCenter, tlTop, False, False, 0, 0, False, True);
end;

procedure TPlannerDrawStyleEh.DrawHorzDayslineViewDateCell(
  PlannerView: TCustomPlannerViewEh; Canvas: TCanvas; ARect: TRect;
  State: TGridDrawState; DrawArgs: TPlannerViewCellDrawArgsEh);
begin
  Canvas.Font.Name := DrawArgs.FontName;
  Canvas.Font.Size := DrawArgs.FontSize;
  Canvas.Font.Style := DrawArgs.FontStyle;
  Canvas.Font.Color := CheckSysColor(DrawArgs.FontColor);
  Canvas.Brush.Color := CheckSysColor(DrawArgs.BackColor);

  Canvas.FillRect(ARect);

  if DrawArgs.HighlightToday and (DrawArgs.TodayDate = sbTrueEh) then
  begin
    Canvas.Brush.Color := ApproximateColor(Canvas.Brush.Color, GetActlTodayFrameColor, 128);
    Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Top+3));
  end;

  WriteTextEh(Canvas, ARect, False, DrawArgs.HorzMargin, DrawArgs.VertMargin,
    DrawArgs.Text, DrawArgs.Alignment, DrawArgs.Layout, False, False, 0, 0,
    False, True);
end;


procedure TPlannerDrawStyleEh.DrawNavigateButtonSign(
  PlannerToolBox: TPlannerToolBoxEh; Canvas: TCanvas; ARect: TRect; State: TButtonStateEh;
  ButtonKind: TPlannerControlButtonKindEh; IsHot: Boolean;
  RightToLeftAlignment: Boolean; ScaleFactor: Double);
var
  TriDir: TEquilateralTriangleDirectionEh;
  SignHeight, SignWidth: Integer;
  ArrawRect: TRect;
  BaseColor: TColor;
{$IFDEF EH_LIB_16}
  LStyle: TCustomStyleServices;
{$ENDIF}
begin
  {$IFDEF EH_LIB_16}
  if CustomStyleActive then
  begin
    LStyle := StyleServices;
    LStyle.GetElementColor(LStyle.GetElementDetails(ttlTextLabelNormal), ecTextColor, BaseColor);
  end
  else
  {$ENDIF}
  begin
    BaseColor := CheckSysColor(cl3DDkShadow);
  end;

  SignHeight := Trunc(9 * ScaleFactor);
  if (SignHeight mod 2) = 0 then SignHeight := SignHeight - 1;
  SignWidth := SignHeight div 2 + 1;

  ArrawRect := Rect(0,0,SignWidth,SignHeight);
  ArrawRect := CenteredRect(ARect, ArrawRect);

  if ButtonKind = pcbkPriorPeriodEh
    then TriDir := etdLeftEh
    else TriDir := etdRightEh;

  DrawEquilateralTriangle(Canvas, ArrawRect, TriDir, BaseColor, BaseColor);
end;

{ TPlannerViewCellDrawArgsEh }

destructor TPlannerViewCellDrawArgsEh.Destroy;
begin
  inherited Destroy;
end;

{ TDrawSpanItemArgsEh }

constructor TDrawSpanItemArgsEh.Create;
begin
  FFont := TFont.Create;
end;

destructor TDrawSpanItemArgsEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TDrawSpanItemArgsEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.

