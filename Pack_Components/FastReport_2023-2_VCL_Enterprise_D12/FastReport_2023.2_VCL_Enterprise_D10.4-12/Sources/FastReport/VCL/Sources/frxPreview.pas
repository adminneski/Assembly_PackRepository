
{******************************************}
{                                          }
{             FastReport VCL               }
{             Report preview               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPreview;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Menus, ComCtrls, ImgList, frxCtrls, frxDock,
  ToolWin, frxPreviewPages, frxClass, frxBaseForm, frxSearchForm, frxComCtrls, frCore,
{$IFDEF DELPHI17}
  System.Actions,
{$ENDIF}
{$IFDEF FPC}
  LResources, LCLType, LCLProc, LazUTF8, LCLIntf, LazHelper, frLazGraphicClasses,
{$ENDIF}
{$IFDEF DELPHI6}
  Variants, ActnList,
{$ENDIF}
  frTypes;

const
  WM_UPDATEZOOM = WM_USER + 1;

type
  TfrxPreview = class;
  TfrxPreviewWorkspace = class;
  TfrxPageList = class;

  TfrxPreviewTool = (ptHand, ptZoom); // not implemented, backw compatibility only
  /// <summary>
  ///   This event is generated when the current page is being changed.
  /// </summary>
  TfrxPageChangedEvent = procedure(Sender: TfrxPreview; PageNo: Integer) of object;

  TfrxFindAllTextItem = record
    PageNo: Integer;
    Bounds: TRect;
  end;

  PfrxTrvData = ^TfrxTrvData;
  TfrxTrvData = record
    PageNo: Integer;
    TextBnd: TRect;
  end;

  TfrxFindAllTextCallbackFunc = function (Item: TfrxFindAllTextItem; Text: String; Data: Pointer): Boolean;

  TfrxPreviewTabItem = class(TCollectionItem)
  private
    FName: String;
    FTop: Integer;
    FLeft: Integer;
    FPageNo: Integer;
    FThumbTop: Integer;
    FReport: TfrxReport;
    FPreviewPages: TfrxCustomPreviewPages;
    FDetailPage: String;
    FZoom: Extended;
    FZoomMode: TfrxZoomMode;
    FOutlineItem: Integer;
    FFreeObjects: Boolean;
  public
    property Name: String read FName write FName;
    property Top: Integer read FTop write FTop;
    property Left: Integer read FLeft write FLeft;
    property PageNo: Integer read FPageNo write FPageNo;
    property ThumbTop: Integer read FThumbTop write FThumbTop;
    property Report: TfrxReport read FReport write FReport;
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages write FPreviewPages;
    property DetailPage: String read FDetailPage write FDetailPage;
    property Zoom: Extended read FZoom write FZoom;
    property ZoomMode: TfrxZoomMode read FZoomMode write FZoomMode;
    property OutlineItem: Integer read FOutlineItem write FOutlineItem;
    property FreeObjects: Boolean read FFreeObjects write FFreeObjects;
  end;

  TfrxPreviewTabs = class(TCollection)
  private
//    FOutline: TTreeView;
    FThumbnail: TfrxPreviewWorkspace;
    FWorkspace: TfrxPreviewWorkspace;
    FPreview: TfrxPreview;
    FCurTab: Integer;
    function GetItems(Index: Integer): TfrxPreviewTabItem;
  public
    constructor Create(APreview: TfrxPreview);
    property Items[Index: Integer]: TfrxPreviewTabItem read GetItems; default;
    procedure AddTab(AReport: TfrxReport; aDetailPage: String; const TabName: String; AFreeObjects: Boolean);
    procedure DeleteTab(Index: Integer);
    procedure SetCurrentTab(Index: Integer);
    procedure ClearItems;
  end;

{$IFDEF DELPHI16}
/// <summary>
///   The TfrxPreview component is designed for creation of custom preview
///   windows. To display a report, the link to this component should be
///   assigned to the "TfrxReport.Preview" property.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxPreview = class(TfrxCustomPreview)
  private
    DesignerFSearchFrmVisible: Boolean;
    FAllowF3: Boolean;
    {$IFNDEF FPC}
    FBorderStyle: TBorderStyle;
    {$ENDIF}
    FCancelButton: TButton;
    FSortButton: TfrxToolPanelButton;
    FSortPopUp: TPopupMenu;
    FLocks: Integer;
    FMessageLabel: TLabel;
    FMessagePanel: TPanel;
    FOnPageChanged: TfrxPageChangedEvent;
    FOutline: TfrxTreePanel;
    FSearchFrm: TfrxSearchForm;
    FFindSplitter: TSplitter;
    FOutlineColor: TColor;
    FOutlinePopup: TPopupMenu;
    FPageNo: Integer;
    FSavedPageNo: Integer;
    FRefreshing: Boolean;
    FRunning: Boolean;
    FScrollBars: TScrollStyle;
    FSplitter: TSplitter;
    FThumbnail: TfrxPreviewWorkspace;
    FTick: Cardinal;
    FTool: TfrxPreviewTool;
    FWorkspace: TfrxPreviewWorkspace;
    FZoom: Extended;
    FZoomMode: TfrxZoomMode;
    FTabs: TTabControl;
    FInitialized: Boolean;
    FCalledFromPreview: Boolean;
    FTabItems: TfrxPreviewTabs;
    FTabImgList: TImageList;
    FEachReportInTab: Boolean;
    FOutlineTreeSortType: TfrxTreeSortType;
    FUnion: Boolean;
    FGeneralDialog: Boolean;

    function GetActiveFrameColor: TColor;
    function GetBackColor: TColor;
    function GetFindFmVisible: Boolean;
    procedure TreeViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
    {$IFNDEF FPC}Data: Integer;{$ENDIF} var Compare: Integer);
    procedure OnTrvFindChange(Sender: TObject; Node: TTreeNode);
    procedure OnFindClick(Sender: TObject);
    procedure SetFindFmVisible(Value: Boolean);
    function GetFrameColor: TColor;
    function GetOutlineVisible: Boolean;
    function GetOutlineWidth: Integer;
    function GetOutline: TTreeView;
    function GetPageCount: Integer;
    function GetThumbnailVisible: Boolean;
    function GetOnMouseDown: TMouseEvent;
    procedure AddCloseBtnToImageList;
    procedure EditTemplate;
    procedure ToolOnClick(Sender: TObject);
    procedure CollapseExpand(aExpand: Boolean = False);
    procedure OnCancel(Sender: TObject);
    procedure OnCollapseClick(Sender: TObject);
    procedure FillOutlineTree;
    procedure OnExpandClick(Sender: TObject);
    procedure OnMoveSplitter(Sender: TObject);
    procedure OnOutlineClick(Sender: TObject);
    procedure OnChangeTab(Sender: TObject);
    procedure OnTabMouseUP(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure SetActiveFrameColor(const Value: TColor);
    procedure SetBackColor(const Value: TColor);
    {$IFNDEF FPC}
    procedure SetBorderStyle(Value: TBorderStyle);
    {$ENDIF}
    procedure SetFrameColor(const Value: TColor);
    procedure SetOutlineColor(const Value: TColor);
    procedure SetOutlineWidth(const Value: Integer);
    procedure SetOutlineVisible(const Value: Boolean);
    procedure SetPageNo(Value: Integer);
    procedure SetActivePage(Value: Integer);
    procedure SetThumbnailVisible(const Value: Boolean);
    procedure SetZoom(const Value: Extended);
    procedure SetZoomMode(const Value: TfrxZoomMode);
    procedure SetOnMouseDown(const Value: TMouseEvent);
    procedure CreateSortPopup;
    procedure UpdateOutline;
    procedure UpdateFindPage;
    procedure UpdatePages;
    procedure UpdatePageNumbers;
    procedure WMEraseBackground(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure SetHighlightEditable(const Value: Boolean);
    function GetHighlightEditable: Boolean;
    function GetHideScrolls: Boolean;
    function GetOnScrollMaxChange: TfrxScrollMaxChangeEvent;
    function GetOnScrollPosChange: TfrxScrollPosChangeEvent;
    procedure SetHideScrolls(const Value: Boolean);
    procedure SetOnScrollMaxChange(const Value: TfrxScrollMaxChangeEvent);
    procedure SetOnScrollPosChange(const Value: TfrxScrollPosChangeEvent);
    procedure ClearPageList;
    function GetLocked: Boolean;
    procedure CompositeTabsExport(Filter: TfrxCustomExportFilter);
    procedure CompositePreviewPages(buffPrevPags: TfrxCustomPreviewPages);//union support
    procedure SeparateTabsExport(Filter: TfrxCustomExportFilter);
    procedure SetTabsVisible(b: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    function GetReport: TfrxReport; override;
    function GetPreviewPages: TfrxCustomPreviewPages; override;
    procedure Resize; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoFinishInPlace(Sender: TObject; Refresh, Modified: Boolean); override;
    procedure RemoveTabs(aReport: TfrxReport);
    procedure SetOutlineTreeSortType(const Value: TfrxTreeSortType);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearAllTabs;
    function Init(aReport: TfrxReport; aPrevPages: TfrxCustomPreviewPages): Boolean; override;
    procedure UnInit(aReport: TfrxReport); override;
    function Lock: Boolean; override;
    procedure Unlock(DoUpdate: Boolean = True); override;
    procedure RefreshReport; override;
    procedure InternalOnProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); override;
    procedure InternalOnProgress(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); override;
    procedure InternalOnProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); override;
    /// <summary>
    ///   Adds a blank page to the end of the report.
    /// </summary>
    procedure AddPage;
    /// <summary>
    ///   Deletes the current page.
    /// </summary>
    procedure DeletePage;
    /// <summary>
    ///   Prints a report.
    /// </summary>
    procedure Print;
    /// <summary>
    ///   Loads the current page for editing to the designer.
    /// </summary>
    procedure Edit;
    /// <summary>
    ///   Moves to the first page.
    /// </summary>
    procedure First;
    /// <summary>
    ///   Moves to the next page.
    /// </summary>
    procedure Next;
    /// <summary>
    ///   Moves to the previous page.
    /// </summary>
    procedure Prior;
    /// <summary>
    ///   Moves to the last page.
    /// </summary>
    procedure Last;
    /// <summary>
    ///   Displays the page setting dialogue.
    /// </summary>
    procedure PageSetupDlg;
    /// <summary>
    ///   Displays the page setting dialogue.
    /// </summary>
    procedure PageSetupDialog;
    /// <summary>
    ///   Displays the text searching dialogue.
    /// </summary>
    procedure Find;
    /// <summary>
    ///   Continues searching the text.
    /// </summary>
    procedure FindNext;
    /// <summary>
    ///   Aborts a report constructing.
    /// </summary>
    procedure Cancel;
    /// <summary>
    ///   Clears a report.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Moves to the page PageN and top position Top on the page.
    /// </summary>
    procedure SetPosition(PageN, Top: Integer);
    procedure ShowMessage(const s: String);
    procedure HideMessage;
    /// <summary>
    ///   <para>
    ///     Scrolls the preview window. This method is used for
    ///     Form.OnMouseWheel event handler:
    ///   </para>
    ///   <code lang="Delphi">procedure TForm1.FormMouseWheel(Sender: TObject;
    ///   Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
    ///    var Handled: Boolean);
    ///    begin
    ///      frxPreview1.MouseWheelScroll(WheelDelta);
    ///    end;</code>
    /// </summary>
    procedure MouseWheelScroll(Delta: Integer; Shift: TShiftState; MousePos: TPoint; Horz: Boolean = False);
    /// <summary>
    ///   Return position on the current page.
    /// </summary>
    function GetTopPosition: Integer;
    /// <summary>
    ///   Displays the file loading dialogue.
    /// </summary>
    procedure LoadFromFile; overload;
    /// <summary>
    ///   Loads a file without displaying the dialogue.
    /// </summary>
    procedure LoadFromFile(FileName: String); overload;
    //procedure FindAllText(SearchString: String; IsCaseSensitive: Boolean; Callback : TfrxFindAllTextCallbackFunc; Data : Pointer);
    //procedure FindAllTextItemHighlight(Item : TfrxFindAllTextItem);  not used
    /// <summary>
    ///   Displays the file saving dialogue.
    /// </summary>
    procedure SaveToFile; overload;
    /// <summary>
    ///   Saves a file without displaying the dialogue.
    /// </summary>
    procedure SaveToFile(FileName: String); overload;
    /// <summary>
    ///   Exports the report using the specified export filter.
    /// </summary>
    procedure Export(Filter: TfrxCustomExportFilter;
      ExportsAllTabs: Boolean = False);
    procedure CompositeExport(Filter: TfrxCustomExportFilter);
    function FindText(SearchString: String; FromTop, IsCaseSensitive: Boolean): Boolean;
    function FindTextFound: Boolean;
    procedure FindTextClear;
    procedure AddPreviewTab(AReport: TfrxReport; const TabName: String; const TabCaption: String = ''; FreeObjects: Boolean = True; aDetailPage: String = ''); override;
    procedure AddPreviewTabOrSwitch(AReport: TfrxReport; const TabName: String; const TabCaption: String = ''; FreeObjects: Boolean = True; aDetailPage: String = ''); override;
    procedure RemoveTab(TabIndex: Integer); override;
    function HasTab(const TabName: String): Boolean; overload; override;
    function HasTab(const aReport: TfrxReport): Boolean; overload; override;
    function HasVisibleTabs: Boolean; override;
    procedure PreviewPagesChanged; override;
    procedure SwitchToTab(const TabName: String); overload; override;
    procedure SwitchToTab(const aReport: TfrxReport); overload; override;

    /// <summary>
    ///   Number of pages in a report.
    /// </summary>
    property PageCount: Integer read GetPageCount;
    /// <summary>
    ///   The current page number (starts from 1). To move to a required page,
    ///   assign a value to this property.
    /// </summary>
    property PageNo: Integer read FPageNo write SetPageNo;
    // not implemented, backw compatibility only
    property Tool: TfrxPreviewTool read FTool write FTool;
    /// <summary>
    ///   The scaling factor. "1" conforms 100% scale.
    /// </summary>
    property Zoom: Extended read FZoom write SetZoom;
    /// <summary>
    ///   Zoom mode. The following values are available: <br />zmDefault -
    ///   scale can be set with the help of the "Zoom" property; <br />
    ///   zmWholePage - the whole page fits; <br />zmPageWidth - the page fits
    ///   by width; <br />zmManyPages - two pages fit.
    /// </summary>
    property ZoomMode: TfrxZoomMode read FZoomMode write SetZoomMode;
    /// <summary>
    ///   Flag returns state of window blocking.
    /// </summary>
    property Locked: Boolean read GetLocked;
    /// <summary>
    ///   Reference to Outline Tree window.
    /// </summary>
    property OutlineTree: TTreeView read GetOutline;
    /// <summary>
    ///   Reference to spliter object <br />
    /// </summary>
    property Splitter: TSplitter read FSplitter;
    property TabItems: TfrxPreviewTabs read FTabItems;
    property FindSplitter: TSplitter read FFindSplitter;
    property SearchFrm: TfrxSearchForm read FSearchFrm;
    /// <summary>
    ///   Reference to Thumbnail window object.
    /// </summary>
    property Thumbnail: TfrxPreviewWorkspace read FThumbnail;
    /// <summary>
    ///   Reference to preview Workspace object.
    /// </summary>
    property Workspace: TfrxPreviewWorkspace read FWorkspace;
    property HighlightEditable: Boolean read GetHighlightEditable write SetHighlightEditable;
    property Outline: TfrxTreePanel read FOutline write FOutline;
  published
    property Align;
    /// <summary>
    ///   The color of active page frame.
    /// </summary>
    property ActiveFrameColor: TColor read GetActiveFrameColor write SetActiveFrameColor default $3CC7FF;
    /// <summary>
    ///   The workspace color.
    /// </summary>
    property BackColor: TColor read GetBackColor write SetBackColor default clGray;
    {$IFDEF FPC}
    property BorderStyle;
    {$ELSE}
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    {$ENDIF}
    property BorderWidth;
    property Constraints;
    property EachReportInTab: Boolean read FEachReportInTab write FEachReportInTab default False;
    property Enabled;
    /// <summary>
    ///   The page frame color.
    /// </summary>
    property FrameColor: TColor read GetFrameColor write SetFrameColor default $606060;
    property OutlineColor: TColor read FOutlineColor write SetOutlineColor default clWindow;
    /// <summary>
    ///   Report tree visibility.
    /// </summary>
    property OutlineVisible: Boolean read GetOutlineVisible write SetOutlineVisible;
    property OutlineWidth: Integer read GetOutlineWidth write SetOutlineWidth;
    property PopupMenu;
    /// <summary>
    ///   Thumbnails visibility.
    /// </summary>
    property ThumbnailVisible: Boolean read GetThumbnailVisible write SetThumbnailVisible;
    property FindFmVisible: Boolean read GetFindFmVisible write SetFindFmVisible;
    property Visible;
    property OnClick;
    property OnDblClick;
    /// <summary>
    ///   This event is generated when the current page is being changed.
    /// </summary>
    property OnPageChanged: TfrxPageChangedEvent read FOnPageChanged write FOnPageChanged;
    property OnMouseDown: TMouseEvent read GetOnMouseDown write SetOnMouseDown;
    property Anchors;
    property UseReportHints;
    property OutlineTreeSortType: TfrxTreeSortType read FOutlineTreeSortType write SetOutlineTreeSortType;
    property HideScrolls: Boolean read GetHideScrolls write SetHideScrolls;
    property OnScrollMaxChange: TfrxScrollMaxChangeEvent read GetOnScrollMaxChange write SetOnScrollMaxChange;
    property OnScrollPosChange: TfrxScrollPosChangeEvent read GetOnScrollPosChange write SetOnScrollPosChange;
  end;

  { TfrxPreviewForm }

  TfrxPreviewForm = class(TfrxBaseForm)
    ToolBar: TToolBar;
    OpenB: TToolButton;
    SaveB: TToolButton;
    PrintB: TToolButton;
    FindB: TToolButton;
    PageSettingsB: TToolButton;
    Sep3: TfrxTBPanel;
    SaveAllTabsB: TToolButton;
    ZoomCB: TfrxComboBox;
    Sep1: TToolButton;
    Sep2: TToolButton;
    FirstB: TToolButton;
    PriorB: TToolButton;
    Sep4: TfrxTBPanel;
    PageE: TEdit;
    NextB: TToolButton;
    LastB: TToolButton;
    StatusBar: TStatusBar;
    ZoomMinusB: TToolButton;
    Sep5: TToolButton;
    ZoomPlusB: TToolButton;
    DesignerB: TToolButton;
    frTBPanel1: TfrxTBPanel;
    CancelB: TSpeedButton;
    ExportPopup: TPopupMenu;
    ExportAllTabsPopup: TPopupMenu;
    HiddenMenu: TPopupMenu;
    Showtemplate1: TMenuItem;
    RightMenu: TPopupMenu;
    FullScreenBtn: TToolButton;
    EmailB: TToolButton;
    PdfB: TToolButton;
    OutlineB: TToolButton;
    ThumbB: TToolButton;
    N1: TMenuItem;
    ExpandMI: TMenuItem;
    CollapseMI: TMenuItem;
    OfNL: TLabel;
    HighlightEditableTB: TToolButton;
    PreviewActionList: TActionList;
    CopyCmd: TAction;
    PasteCmd: TAction;
    CopyCmd1: TMenuItem;
    PasteCmd1: TMenuItem;
    StylePan: TfrxTBPanel;
    StyleSheetCB: TfrxComboBox;
    SepStyle: TfrxTBPanel;
    StyleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ZoomMinusBClick(Sender: TObject);
    procedure ZoomCBClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FirstBClick(Sender: TObject);
    procedure PriorBClick(Sender: TObject);
    procedure NextBClick(Sender: TObject);
    procedure LastBClick(Sender: TObject);
    procedure PageEClick(Sender: TObject);
    procedure PrintBClick(Sender: TObject);
    procedure OpenBClick(Sender: TObject);
    procedure SaveBClick(Sender: TObject);
    procedure FindBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DesignerBClick(Sender: TObject);
    procedure NewPageBClick(Sender: TObject);
    procedure DelPageBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageSettingsBClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure DesignerBMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Showtemplate1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FullScreenBtnClick(Sender: TObject);
    procedure PdfBClick(Sender: TObject);
    procedure EmailBClick(Sender: TObject);
    procedure ZoomPlusBClick(Sender: TObject);
    procedure OutlineBClick(Sender: TObject);
    procedure ThumbBClick(Sender: TObject);
    procedure CollapseAllClick(Sender: TObject);
    procedure ExpandAllClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure HighlightEditableTBClick(Sender: TObject);
    procedure CopyCmdExecute(Sender: TObject);
    procedure PasteCmdExecute(Sender: TObject);
    procedure RightMenuPopup(Sender: TObject);
    procedure ZoomCBKeyPress(Sender: TObject; var Key: Char);
    procedure StyleSheetCBChange(Sender: TObject);
  private
    FFilterList: TStringList;
    FFreeOnClose: Boolean;
    FIsClosing: Boolean;
    FPreview: TfrxPreview;
    FOldBS: TFormBorderStyle;
    FOldState: TWindowState;
    FFullScreen: Boolean;
    FPDFExport: TfrxCustomExportFilter;
    FEmailExport: TfrxCustomExportFilter;
    {$IFNDEF FPC}
    FStatusBarOldWindowProc: TWndMethod;
    {$ENDIF}
    procedure CreateExportMenu;
    procedure ExportMIClick(Sender: TObject);
    procedure ExportMIACTClick(Sender: TObject);
    procedure OnPageChanged(Sender: TfrxPreview; PageNo: Integer);
    procedure OnPreviewDblClick(Sender: TObject);
    procedure UpdateControls;
    procedure UpdateZoom;
    procedure WMUpdateZoom(var Message: TMessage); message WM_UPDATEZOOM;
    procedure WMActivateApp(var Msg: TWMActivateApp); message WM_ACTIVATEAPP;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure StatusBarWndProc(var Message: TMessage);
    function GetReport: TfrxReport;
    procedure OnSaveFilterExecute(Sender: TObject);
    procedure UpdateStyles;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init;
    procedure SetMessageText(const Value: String; IsHint: Boolean = False);
    procedure SwitchToFullScreen;
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property IsClosing: Boolean read FIsClosing write FIsClosing;
    property FreeOnClose: Boolean read FFreeOnClose write FFreeOnClose;
    property Preview: TfrxPreview read FPreview;
    property Report: TfrxReport read GetReport;
  end;

  TfrxPreviewWorkspace = class(TfrxScrollWin)
  private
    FActiveFrameColor: TColor;
    FBackColor: TColor;
    FDefaultCursor: TCursor;
    FDisableUpdate: Boolean;
    FDown: Boolean;
    FEMFImage: TMetafile;
    FEMFImagePage: Integer;
    FFrameColor: TColor;
    FIsThumbnail: Boolean;
    FLastFoundPage: Integer;
    FLastPoint: TPoint;
    FLocked: Boolean;
    FOffset: TPoint;
    FTimeOffset: Cardinal;
    FPageList: TfrxPageList;
    FPageNo: Integer;
    FPreview: TfrxPreview;
    FLockVScroll: Boolean;
    //FPreviewPages: TfrxCustomPreviewPages;
    FZoom: Extended;
    FRTLLanguage: Boolean;
    FHighlightEditable: Boolean;
    FSelectRect: TRect;
    FCachedView: TBitmap;
    procedure DrawPages(BorderOnly: Boolean);
    procedure FindText;
    //procedure FindAllText(Callback : TfrxFindAllTextCallbackFunc; Data : Pointer);
    procedure HighlightText;
    procedure SetToPageNo(PageNo: Integer);
    procedure UpdateScrollBars;
    procedure SetLocked(const Value: Boolean);
    function GetPreviewPages: TfrxCustomPreviewPages;
    procedure LockVScroll;
    procedure UnLockVScroll;
  protected
    procedure PrevDblClick(Sender: TObject);
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure OnHScrollChange(Sender: TObject); override;
    procedure Resize; override;
    procedure OnVScrollChange(Sender: TObject); override;
    procedure CallIteractiveEvent(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer; var aEvent: TfrxPreviewIntEventParams);
    procedure SetEditMode(var aEvent: TfrxPreviewIntEventParams);
    function ScaleRect(const aRect: TRect; Scale, aOffsetX, aOffsetY: Extended): TfrxRect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure SetPosition(PageN, Top: Integer);
    function GetTopPosition: Integer;
    { page list }
    procedure AddPage(AWidth, AHeight: Integer);
    procedure ClearPageList;
    procedure CalcPageBounds(ClientWidth: Integer);

    property ActiveFrameColor: TColor read FActiveFrameColor write FActiveFrameColor default $804020;
    property BackColor: TColor read FBackColor write FBackColor default clGray;
    property FrameColor: TColor read FFrameColor write FFrameColor default clBlack;
    property IsThumbnail: Boolean read FIsThumbnail write FIsThumbnail;
    property Locked: Boolean read FLocked write SetLocked;
    property PageNo: Integer read FPageNo write FPageNo;
    property Preview: TfrxPreview read FPreview write FPreview;
    property PreviewPages: TfrxCustomPreviewPages read GetPreviewPages;
    // FPreviewPages
//      write FPreviewPages;
    property Zoom: Extended read FZoom write FZoom;
    property RTLLanguage: Boolean read FRTLLanguage write FRTLLanguage;
    property HighlightEditable: Boolean read FHighlightEditable write FHighlightEditable;
    property OnDblClick;
  end;

  TfrxPageItem = class(TCollectionItem)
  public
    Height: Integer;
    Width: Integer;
    OffsetX: Integer;
    OffsetY: Integer;
  end;

  TfrxPageList = class(TCollection)
  private
    FMaxWidth: Integer;
    function GetItems(Index: Integer): TfrxPageItem;
  public
    constructor Create;
    property Items[Index: Integer]: TfrxPageItem read GetItems; default;
    procedure AddPage(AWidth, AHeight: Integer; Zoom: Extended);
    procedure CalcBounds(ClientWidth: Integer);
    function FindPage(OffsetY: Integer; OffsetX: Integer = 0): Integer;
    function GetPageBounds(Index, ClientWidth: Integer; Scale: Extended; RTL: Boolean): TRect;
    function GetMaxBounds: TPoint;
  end;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}
{$R *.res}

uses
  {$IFNDEF FPC}Printers,{$ENDIF} frxPrinter, frxSearchDialog, frxUtils, frxRes, frxDsgnIntf,
  frDPIAwareInt,
  frxPreviewPageSettings, frxDMPClass, frxInPlaceEditors, frxIOTransportIntf, frxIOTransportDialog, frxPlatformServices;

const
  frxDefaultCancelBWidth = 68;
  frxDefaultToolBtnGap = 7;
{$IFNDEF FPC}
type
  THackControl = class(TWinControl);
{$ENDIF}

{ search given string in a metafile }

type
  PfrxFindAllTextData = ^TfrxFindAllTextData;
  TfrxFindAllTextData = record
    Callback: TfrxFindAllTextCallbackFunc;
    Data: Pointer;
    PageNo: Integer;
  end;

  TfrxTreeActions = (taSortData, taUnsorted = 33, taAscending = 31, taDescending = 32, taCollapse = 13, taExpand = 14);

var
  TextToFind: String;
  TextFound: Boolean;
  TextBounds: TRect;
  RecordNo: Integer;
  LastFoundRecord: Integer;
  CaseSensitive: Boolean;
  FindAll: Boolean;
  SearchFB: Boolean;
  PPIScale: Extended;

function ClipText(const s: String; FSStart, FSLeng: Integer): String;
const
  pad = 10;
var
  SLen :Integer;
begin
  SLen := frxLength(s);
  if FSStart + FSLeng + pad > SLen then
    FSLeng := SLen
  else
    FSLeng := FSLeng + pad;
  if FSStart < pad then
  begin
    FSLeng := FSLeng + FSStart;
    FSStart := 1;
  end
  else
  begin
    FSStart := FSStart - pad;
    FSLeng := FSLeng + pad;
  end;
  Result := frxCopy(s, FSStart, FSLeng);
end;

{$IFDEF FPC}
// we are using lmf implementation
procedure FindInLmf(Wrk: TfrxPreviewWorkSpace; ALmf: TlmfImage);
var
  s: String;
  i: integer;
  AText: TlmfText;
  // ACount: integer;
  // SFound: String;
  STextToFind: String;
  P: PfrxTrvData;
  tr: TTreeNode;
  PosFind, n:Integer;
begin
  {$IFDEF FPC}
  // ACount := ALmf.list.ComponentCount;
  // DebugLn('ALmf count ', dbgs(ACount),' find me ',TextToFind);
  {$ENDIF}
  if not CaseSensitive then
    STextToFind := frxUpperCase(TextToFind)
  else
    STextToFind := TextToFind;
  for i := 0 to ALmf.List.ComponentCount - 1 do
  begin
    {$IFDEF FPCUSELMFFOREMF}
    // writeln('ALmf class ',ALmf.list.Components[i].ClassName);
    {$ENDIF}
    if ALmf.List.Components[i] is TlmfText then
    begin
      AText := TlmfText(ALmf.List.Components[i]);
      s := AText.Text;
      if CaseSensitive then
        PosFind := frxPos(STextToFind, s)
      else
        PosFind := frxPos(frxUpperCase(STextToFind), frxUpperCase(s));
      TextFound := (PosFind <> 0);
      if FindAll then
      begin
        if TextFound then
        begin
          New(P);
          P^.TextBnd := AText.StrBounds;
          n := Wrk.FLastFoundPage;
          P^.PageNo := n;
          tr := Wrk.Preview.FSearchFrm.TrvFind.Items.FindNodeWithText(frxGet(202) + ' ' + IntToStr(n + 1));
          if not Assigned(tr) then
            tr := Wrk.Preview.FSearchFrm.TrvFind.Items.Add(nil, frxGet(202) + ' ' + IntToStr(n + 1));
          Wrk.Preview.FSearchFrm.TrvFind.Items.AddChildObject(tr, ClipText(s, PosFind, frxLength(STextToFind)), P);
        end;
      end
      else
      begin
        if TextFound and (RecordNo > LastFoundRecord) then
        begin
          TextBounds := Atext.StrBounds;
          LastFoundRecord := RecordNo;
          Inc(RecordNo);
          Break;
        end
        else
          TextFound := False;
      end;
      Inc(RecordNo);
    end;
  end;
end;
{$ELSE}
function EnumEMFRecordsProc(DC: HDC; HandleTable: PHandleTable;
  EMFRecord: PEnhMetaRecord; nObj: Integer; OptData: Pointer): Bool; stdcall;
var
  Typ: Byte;
  s: String;
  t: TEMRExtTextOut;
  Found: Boolean;
  P: PfrxTrvData;
  tr: TTreeNode;
  PosFind, n: Integer;
  twp: TfrxPreviewWorkspace;

  function FindNodeWithText(const NodeText: string): TTreeNode;
  begin
    Result := twp.Preview.FSearchFrm.trvFind.Items.GetFirstNode;
    while True do
    begin
      if not Assigned(Result) then
        break;
      if not (Result.Text <> NodeText) then
        break;
      Result := Result.GetNext;
    end;
  end;

begin
  Result := True;
  Typ := EMFRecord^.iType;
  if Typ in [83, 84] then
  begin
    t := PEMRExtTextOut(EMFRecord)^;
    s := WideCharLenToString(PWideChar(PAnsiChar(EMFRecord) + t.EMRText.offString),
      t.EMRText.nChars);
    if CaseSensitive then
      PosFind := Pos(TextToFind, s) else
      PosFind := Pos(AnsiUpperCase(TextToFind), AnsiUpperCase(s));
    Found := (PosFind <> 0);
    if Found and (RecordNo > LastFoundRecord) then
    begin
      if FindAll then
      begin
        New(P);
        twp := TfrxPreviewWorkspace(OptData);
        n := twp.FLastFoundPage;
        P^.TextBnd := t.rclBounds;
        P^.PageNo := n;
        tr := FindNodeWithText(frxGet(202) + ' ' + IntToStr(n + 1));
        if not Assigned(tr) then
          tr := twp.Preview.FSearchFrm.trvFind.Items.Add(nil, frxGet(202) + ' ' + IntToStr(n + 1));
        twp.Preview.FSearchFrm.trvFind.Items.AddChildObject(tr, ClipText(s, PosFind, frxLength(TextToFind)), P);
      end
      else
      begin
        TextFound := True;
        TextBounds := t.rclBounds;
        LastFoundRecord := RecordNo;
        Result := False;
      end;
    end;
  end;
  Inc(RecordNo);
end;
{$ENDIF}
(*
{$IFDEF FPC}
procedure FindAllInLmf(Wrk: TfrxPreviewWorkspace; ALmf: TlmfImage; ARect: TRect; Data : TfrxFindAllTextData);
var
  s: String;
  i: integer;
  AText: TlmfText;
  STextToFind: String;
  Item: TfrxFindAllTextItem;
  P: PfrxTrvData;
  tr: TTreeNode;
  n:Integer;
begin
  Item.PageNo := Data.PageNo;

  if not CaseSensitive then
    STextToFind := frxUpperCase(TextToFind)
  else
    STextToFind := TextToFind;
  for i := 0 to ALmf.List.ComponentCount - 1 do
  begin
    if ALmf.List.Components[i] is TlmfText then
    begin
      AText := TlmfText(ALmf.List.Components[i]);
      s := AText.Text;
      if not CaseSensitive then
        s := frxUpperCase(s);

      if (frxPos(STextToFind, s) <> 0) then
      begin
        Item.Bounds := AText.StrBounds;
        New(P);
        P^.TextBnd := AText.StrBounds;
        n := Wrk.FLastFoundPage ;
        P^.PageNo := n;
        tr := Wrk.Preview.FSearchFrm.TrvFind.Items.FindNodeWithText(frxGet(153) + ' ' + IntToStr(n + 1));
        if not Assigned(tr) then
           tr := Wrk.Preview.FSearchFrm.TrvFind.Items.Add(nil, frxGet(153) + ' ' + IntToStr(n + 1));
        Wrk.Preview.FSearchFrm.TrvFind.Items.AddChildObject(tr, s, P);
      end;
    end;
  end;
end;
{$ELSE}
function EnumAllEMFRecordsProc(DC: HDC; HandleTable: PHandleTable;
  EMFRecord: PEnhMetaRecord; nObj: Integer; OptData: Pointer): Bool; stdcall;
var
  Typ: Byte;
  s: String;
  t: TEMRExtTextOut;
  Found: Boolean;
  Data: PfrxFindAllTextData;
  Item: TfrxFindAllTextItem;
begin
  Data := PfrxFindAllTextData(OptData);

  Item.PageNo:=Data^.PageNo;

  Result := True;
  Typ := EMFRecord^.iType;
  if Typ in [83, 84] then
  begin
    t := PEMRExtTextOut(EMFRecord)^;
    s := WideCharLenToString(PWideChar(PAnsiChar(EMFRecord) + t.EMRText.offString),
      t.EMRText.nChars);
    if CaseSensitive then
      Found := Pos(TextToFind, s) <> 0 else
      Found := Pos(AnsiUpperCase(TextToFind), AnsiUpperCase(s)) <> 0;
    if Found then
    begin
      Item.Bounds := t.rclBounds;
      Result:=Data^.Callback(Item, s, Data^.Data);
    end;
  end;
end;
{$ENDIF}
*)


{ TfrxPageList }

constructor TfrxPageList.Create;
begin
  inherited Create(TfrxPageItem);
end;

function TfrxPageList.GetItems(Index: Integer): TfrxPageItem;
begin
  Result := TfrxPageItem(inherited Items[Index]);
end;

procedure TfrxPageList.AddPage(AWidth, AHeight: Integer; Zoom: Extended);
begin
  with TfrxPageItem(Add) do
  begin
    Width := Round(AWidth * Zoom);
    Height := Round(AHeight * Zoom);
  end;
end;

procedure TfrxPageList.CalcBounds(ClientWidth: Integer);
var
  i, j, CurX, CurY, MaxY, offs: Integer;
  Item: TfrxPageItem;
begin
  FMaxWidth := 0;
  CurY := 10;
  i := 0;
  while i < Count do
  begin
    j := i;
    CurX := 0;
    MaxY := 0;
    { find series of pages that will fit in the clientwidth }
    { also calculate max height of series }
    while j < Count do
    begin
      Item := Items[j];
      { check the width, allow at least one iteration }
      if (CurX > 0) and (CurX + Item.Width > ClientWidth) then break;
      Item.OffsetX := CurX;
      Item.OffsetY := CurY;
      Inc(CurX, Item.Width + 10);
      if Item.Height > MaxY then
        MaxY := Item.Height;
      Inc(j);
    end;

    if CurX > FMaxWidth then
      FMaxWidth := CurX;

    { center series horizontally }
    offs := (ClientWidth - CurX + 10) div 2;
    if offs < 0 then
      offs := 0;
    Inc(offs, 10);
    while (i < j) do
    begin
      Inc(Items[i].OffsetX, offs);
      Inc(i);
    end;

    Inc(CurY, MaxY + 10);
  end;
end;

procedure TfrxPreview.CollapseExpand(aExpand: Boolean = False);
var
  i: Integer;
  TreeView: TTreeView;
begin
  TreeView := FOutline.TreeView;
  if TreeView.Items.Count = 0 then Exit;
  TreeView.Items.BeginUpdate;
  try
    for i := 0 to TreeView.Items.Count - 1 do
      TreeView.Items[i].Expanded := aExpand;
  finally
    TreeView.Items.EndUpdate;
  end;
end;

procedure TfrxPreview.ToolOnClick;
var
  BtnID: TfrxTreeActions;
  SenderBtn: TfrxToolPanelButton;
  NewSortType: TfrxTreeSortType;
  pt: TPoint;
begin
  if Sender is TMenuItem then
  begin
    BtnID := TfrxTreeActions(TMenuItem(Sender).Tag);
    NewSortType := dtsUnsorted;
    case BtnID of
      taUnsorted: NewSortType := dtsUnsorted;
      taAscending: NewSortType := dtsAscending;
      taDescending: NewSortType := dtsDescending;
    end;
    if FOutlineTreeSortType <> NewSortType then
      OutlineTreeSortType := NewSortType;
    Exit;
  end;

  if not Sender.InheritsFrom(TfrxToolPanelButton) then Exit;
  SenderBtn := TfrxToolPanelButton(Sender);
  BtnID := TfrxTreeActions(TComponent(Sender).Tag);
  pt := SenderBtn.ClientToScreen(Point(0, SenderBtn.Height));
  case BtnID of
    taSortData: FSortPopUp.Popup(pt.X, pt.Y);
    taCollapse: CollapseExpand;
    taExpand: CollapseExpand(True);
  end;
end;

function TfrxPageList.FindPage(OffsetY: Integer; OffsetX: Integer = 0): Integer;
var
  i, i0, i1, c, add: Integer;
  Item: TfrxPageItem;
begin
  i0 := 0;
  i1 := Count - 1;

  while i0 <= i1 do
  begin
    i := (i0 + i1) div 2;
    if OffsetX <> 0 then
      add := 0 else
      add := Round(Items[i].Height / 5);
    if Items[i].OffsetY <= OffsetY + add then
      c := -1 else
      c := 1;

    if c < 0 then
      i0 := i + 1 else
      i1 := i - 1;
  end;

  { find exact page }
  if OffsetX <> 0 then
  begin
    for i := i1 - 20 to i1 + 20 do
    begin
      if (i < 0) or (i >= Count) then continue;
      Item := Items[i];
      if PtInRect(Rect(Item.OffsetX, Item.OffsetY,
        Item.OffsetX + Item.Width, Item.OffsetY + Item.Height),
        Point(OffsetX, OffsetY)) then
      begin
        i1 := i;
        break;
      end;
    end;
  end;

  Result := i1;
end;

function TfrxPageList.GetPageBounds(Index, ClientWidth: Integer;
  Scale: Extended; RTL: Boolean): TRect;
var
  ColumnOffs: Integer;
  Item: TfrxPageItem;
begin
  if (Index >= Count) or (Index < 0) then
  begin
    if 794 * Scale > ClientWidth then
      ColumnOffs := 10 else
      ColumnOffs := Round((ClientWidth - 794 * Scale) / 2);
    Result.Left := ColumnOffs;
    Result.Top := Round(10 * Scale);
    Result.Right := Result.Left + Round(794 * Scale);
    Result.Bottom := Result.Top + Round(1123 * Scale);
  end
  else
  begin
    Item := Items[Index];
    if RTL then
      Result.Left := ClientWidth - Item.Width - Item.OffsetX
    else
      Result.Left := Item.OffsetX;
    Result.Top := Item.OffsetY;
    Result.Right := Result.Left + Item.Width;
    Result.Bottom := Result.Top + Item.Height;
  end;
end;

function TfrxPageList.GetMaxBounds: TPoint;
begin
  if Count = 0 then
    Result := Point(0, 0)
  else
  begin
    Result.X := FMaxWidth;
    Result.Y := Items[Count - 1].OffsetY + Items[Count - 1].Height;
  end;
end;


{ TfrxPreviewWorkspace }

constructor TfrxPreviewWorkspace.Create(AOwner: TComponent);
begin
  inherited;
  FPageList := TfrxPageList.Create;
  OnDblClick := PrevDblClick;

  FBackColor := clGray;
  FFrameColor := $606060;
  FActiveFrameColor := $3CC7FF;
  FZoom := 1;
  FDefaultCursor := crHand;

  LargeChange := 300;
  SmallChange := 8;
  FSelectRect := Rect(0, 0, 0, 0);

  FLockVScroll := False;
end;

destructor TfrxPreviewWorkspace.Destroy;
begin
  if FEMFImage <> nil then
    FEMFImage.Free;
  FPageList.Free;
  if Assigned(FCachedView) then
    FreeAndNil(FCachedView);
  inherited;
end;

function TfrxPreviewWorkspace.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;
var
  EventParams: TfrxPreviewIntEventParams;
begin
  inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  Result := True;
  if PreviewPages = nil then Exit;
  if not FIsThumbnail then
  begin
    EventParams.MouseEventType := meMouseWheel;
    EventParams.WheelDelta := WheelDelta;
    EventParams.MousePos := MousePos;
    EventParams.RetResult := False;
    SetEditMode(EventParams);
    CallIteractiveEvent(mbLeft, Shift, 0, 0, EventParams);
    Result := EventParams.RetResult;
  end;
  {$IFDEF Linux}
  FPreview.MouseWheelScroll(WheelDelta, Shift, MousePos);
  {$ENDIF}
end;

procedure TfrxPreviewWorkspace.OnHScrollChange(Sender: TObject);
var
  pp: Integer;
  r: TRect;
begin
  pp := FOffset.X - HorzPosition;
  FOffset.X := HorzPosition;
  r := Rect(0, 0, ClientWidth, ClientHeight);
  ScrollWindowEx(Handle, pp, 0, @r, @r, 0, nil, SW_ERASE + SW_INVALIDATE);
end;

procedure TfrxPreviewWorkspace.OnVScrollChange(Sender: TObject);
var
  pp: Integer;
  r: TRect;
begin
  pp := FOffset.Y - VertPosition;
  FOffset.Y := VertPosition;
  r := Rect(0, 0, ClientWidth, ClientHeight);
  ScrollWindowEx(Handle, 0, pp, @r, @r, 0, nil, SW_ERASE + SW_INVALIDATE);

  if (FLockVScroll) then
    exit;

  if not FIsThumbnail then
  begin
    FDisableUpdate := True;
    if Preview.FSavedPageNo <> -1 then
      Preview.PageNo := Preview.FSavedPageNo
    else
      Preview.PageNo := FPageList.FindPage(FOffset.Y) + 1;
    FDisableUpdate := False;
  end;
end;

procedure TfrxPreviewWorkspace.DrawPages(BorderOnly: Boolean);
var
  i, n: Integer;
  PageBounds: TRect;
  h: HRGN;

  function PageVisible: Boolean;
  begin
    if (PageBounds.Top > ClientHeight) or (PageBounds.Bottom < 0) then
      Result := False
    else
      Result := RectVisible(Canvas.Handle, PageBounds);
  end;

  procedure DrawPage(Index: Integer);
  var
    i: Integer;
    TxtBounds: TRect;
    {$IFDEF LCLCarbon}
    SavedPenColor: TColor;
    {$ENDIF}
  begin
    with Canvas, PageBounds do
    begin
      Pen.Color := FrameColor;
      Pen.Width := 1;
      Pen.Mode := pmCopy;
      Pen.Style := psSolid;
      Brush.Color := clWhite;
      Brush.Style := bsSolid;
      Dec(Bottom);
      Rectangle(Left, Top, Right, Bottom);
    end;

    PreviewPages.DrawPage(Index, Canvas, Zoom, Zoom, PageBounds.Left, PageBounds.Top, FHighlightEditable);

    if FIsThumbnail then
      with Canvas do
      begin
        Font.Name := 'Arial';
        Font.Size := 8;
        Font.Style := [];
        Font.Color := clWhite;
        Brush.Style := bsSolid;
        Brush.Color := BackColor;
        TextOut(PageBounds.Left + 1, PageBounds.Top + 1, ' ' + IntToStr(Index + 1) + ' ');
      end;

    { highlight text found }
    TxtBounds := Rect(Round(TextBounds.Left * Zoom),
      Round(TextBounds.Top * Zoom),
      Round(TextBounds.Right * Zoom),
      Round(TextBounds.Bottom * Zoom));
    if TextFound and (Index = FLastFoundPage) then
      with Canvas, TxtBounds do
      begin
        Pen.Width := 1;
        Pen.Style := psSolid;
        {$IFDEF LCLCarbon}
        // no raster ops under carbon, so we'll draw an rect around text
        SavedPenColor := Pen.Color;
        Pen.Width := 2;
        Pen.Mode := pmCopy;
        Pen.Color := clHighLight;
        Rectangle(PageBounds.Left + Left - 1, PageBounds.Top + Top - 1, PageBounds.Left + Right + 1,
          PageBounds.Top + Bottom + 1);
        Pen.Color := SavedPenColor;
        Pen.Width := 1;
        {$ELSE}
        Pen.Mode := pmXor;
        Pen.Color := clWhite;
        for i := 0 to Bottom - Top do
        begin
          MoveTo(PageBounds.Left + Left - 1, PageBounds.Top + Top + i);
          LineTo(PageBounds.Left + Right + 1, PageBounds.Top + Top + i);
        end;
        {$ENDIF}
        Pen.Mode := pmCopy;
      end;
  end;

begin
  if not Visible then Exit;

  if Locked or (FPageList.Count = 0) then
  begin
    if Assigned(FCachedView) and (FPageList.Count > 0) then
      Canvas.Draw(0, 0, FCachedView)
    else
    begin
      Canvas.Brush.Color := BackColor;
      Canvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
    end;
    Exit;
  end;

  if PreviewPages = nil then Exit;

  h := CreateRectRgn(0, 0, ClientWidth, ClientHeight);
  GetClipRgn(Canvas.Handle, h);

  { index of first visible page }
  n := FPageList.FindPage(FOffset.Y);

  { exclude page areas to prevent flickering }
  for i := n - 60 to n + 340 do
  begin
    if i < 0 then continue;
    if i >= FPageList.Count then break;

    PageBounds := FPageList.GetPageBounds(i, ClientWidth, Zoom, FRTLLanguage);
    OffsetRect(PageBounds, -FOffset.X, -FOffset.Y);
    if PageVisible then
      with PageBounds do
        ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
  end;

  { now draw background on the non-clipped area}
  with Canvas do
  begin
    Brush.Color := BackColor;
    Brush.Style := bsSolid;
    FillRect(Rect(0, 0, ClientWidth, ClientHeight));
  end;

  { restore clipregion }
  SelectClipRgn(Canvas.Handle, h);

  { draw border around the active page }
  PageBounds := FPageList.GetPageBounds(PageNo - 1, ClientWidth, Zoom, FRTLLanguage);
  OffsetRect(PageBounds, -FOffset.X, -FOffset.Y);
  with Canvas, PageBounds do
  begin
    Pen.Color := ActiveFrameColor;
    Pen.Width := 2;
    Pen.Mode := pmCopy;
    Pen.Style := psSolid;
    Polyline([Point(Left - 1, Top - 1),
              Point(Right + 1, Top - 1),
              Point(Right + 1, Bottom + 1),
              Point(Left - 1, Bottom + 1),
              Point(Left - 1, Top - 2)]);
  end;
  if not BorderOnly then
  begin
    { draw visible pages }
    for i := n - 60 to n + 340 do
    begin
      if i < 0 then continue;
      if i >= FPageList.Count then break;

      PageBounds := FPageList.GetPageBounds(i, ClientWidth, Zoom, FRTLLanguage);
      OffsetRect(PageBounds, -FOffset.X, -FOffset.Y);
      Inc(PageBounds.Bottom);
      if PageVisible then
        DrawPage(i);
    end;
  end;

  DeleteObject(h);
end;

procedure TfrxPreviewWorkspace.Paint;
begin
  DrawPages(False);
//TODO
  if Assigned(PreviewPages) and (pbSelection in PreviewPages.Report.PreviewOptions.Buttons)
    and FDown and (FSelectRect.Bottom - FSelectRect.Top <> 0) and (FSelectRect.Right - FSelectRect.Left <> 0) then
  begin
    with Canvas do
    begin
      Pen.Mode := pmXor;
      Pen.Color := clSilver;
      Pen.Width := 1;
      Pen.Style := psDot;
      Brush.Style := bsClear;
      with FSelectRect do
        Rectangle(Left, Top, Right, Bottom);
      Pen.Mode := pmCopy;
      Brush.Style := bsSolid;
    end;
  end;
end;

procedure TfrxPreviewWorkspace.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  EventParams: TfrxPreviewIntEventParams;
begin
  EventParams.RetResult := False;
  if Assigned(OnMouseDown) then
    OnMouseDown(Self, Button, Shift, X, Y);
  if (FPageList.Count = 0) or Locked then Exit;

  if not FIsThumbnail and (Button <> mbRight) then
  begin
    EventParams.MouseEventType := meMouseDown;
    CallIteractiveEvent(Button, Shift, X, Y, EventParams);
  end;

  if (Button = mbLeft) and not (EventParams.RetResult) then
  begin
    FDown := True;
    FLastPoint.X := X;
    FLastPoint.Y := Y;
//TODO
    if ssShift in Shift then
      FSelectRect := Rect(X, Y, X, Y);
  end;
end;

procedure TfrxPreviewWorkspace.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  EventParams: TfrxPreviewIntEventParams;
begin
  if (FPageList.Count = 0) or Locked or FIsThumbnail then Exit;

  if FDown then
  begin
//TODO
    if ssShift in Shift then
    begin
      FSelectRect.Right := X;
      FSelectRect.Bottom := Y;
      Invalidate;
    end
    else
    begin
      HorzPosition := HorzPosition - (X - FLastPoint.X);
      VertPosition := VertPosition - (Y - FLastPoint.Y);
    end;
    FLastPoint.X := X;
    FLastPoint.Y := Y;
  end
  else
  begin
    EventParams.MouseEventType := meMouseMove;
    CallIteractiveEvent(mbLeft, Shift, X, Y, EventParams);
    Cursor := EventParams.Cursor;
  end;
end;

procedure TfrxPreviewWorkspace.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  PageNo: Integer;
  PageBounds: TRect;
  XOffSet: Integer;
  EventParams: TfrxPreviewIntEventParams;
  SelRect: TfrxRect;
  rPage: TfrxReportPage;
  OffsetX, OffsetY: Extended;
begin
  if not FIsThumbnail and Assigned(Preview.OnClick) then
    Preview.OnClick(Preview);
  if (FPageList.Count = 0) or Locked then Exit;
  FDown := False;
  if FRTLLanguage then
    XOffSet := ClientWidth - (FOffset.X + X)
  else
    XOffSet := FOffset.X + X;

  PageNo := FPageList.FindPage(FOffset.Y + Y, XOffSet);
  FDisableUpdate := True;
  Preview.PageNo := PageNo + 1;
  FDisableUpdate := False;

  if not FIsThumbnail and (Button <> mbRight) then
  begin
    EventParams.MouseEventType := meMouseUp;
    EventParams.Cursor := FDefaultCursor;
    SetEditMode(EventParams);
    if FHighlightEditable then
      Shift := Shift + [ssAlt];
    PageBounds := FPageList.GetPageBounds(PageNo, ClientWidth, Zoom, FRTLLanguage);

    if (FSelectRect.Right - FSelectRect.Left <> 0) and
      (FSelectRect.Bottom - FSelectRect.Top <> 0) and (pbSelection in PreviewPages.Report.PreviewOptions.Buttons) then
    begin
      rPage := PreviewPages.Page[PageNo];
      OffsetX := PageBounds.Left - FOffset.X;
      OffsetY := PageBounds.Top - FOffset.Y;
      if rPage.MirrorMargins and (PageNo mod 2 = 1) then
        OffsetX := OffsetX + rPage.RightMargin * fr01cm * Zoom else
        OffsetX := OffsetX + rPage.LeftMargin * fr01cm * Zoom;
        OffsetY := OffsetY + rPage.TopMargin * fr01cm * Zoom;
      SelRect := ScaleRect(FSelectRect, Zoom, OffsetX, OffsetY);
      rPage.GetContainedComponents(SelRect,
        TfrxView, FPreview.FSelectionList);
      FSelectRect := Rect(0, 0, 0, 0);
      Invalidate;
    end;

      PreviewPages.ObjectOver(PageNo, X, Y, Button, Shift, Zoom,
      PageBounds.Left - FOffset.X, PageBounds.Top - FOffset.Y, EventParams);
    if (GetTickCount - FTimeOffset <= GetDoubleClickTime) then
    begin
      FTimeOffset := 0;
      EventParams.MouseEventType := meDbClick;
      PreviewPages.ObjectOver(PageNo, X, Y, Button, Shift, Zoom,
      PageBounds.Left - FOffset.X, PageBounds.Top - FOffset.Y, EventParams);
    end
    else
    begin
      EventParams.MouseEventType := meClick;
      FTimeOffset := GetTickCount;
      PreviewPages.ObjectOver(PageNo, X, Y, Button, Shift, Zoom,
      PageBounds.Left - FOffset.X, PageBounds.Top - FOffset.Y, EventParams);
    end;
  end;
end;

procedure TfrxPreviewWorkspace.FindText;
var
  EMFCanvas: TMetafileCanvas;

begin
  TextFound := False;
  Preview.FSearchFrm.CleartrvFind();
  if FindAll then
    FLastFoundPage := 0;
  while FLastFoundPage < FPageList.Count do
  begin
    if (FEMFImage = nil) or (FEMFImagePage <> FLastFoundPage) then
    begin
      if FEMFImage <> nil then
        FEMFImage.Free;
      FEMFImage := TMetafile.Create;
      EMFCanvas := TMetafileCanvas.Create(FEMFImage, 0);
      {$IFDEF FPC}
      EMFCanvas.FCreateOnlyText := True;
      {$ENDIF}
      PreviewPages.DrawPage(FLastFoundPage, EMFCanvas, 1, 1, 0, 0);
      EMFCanvas.Free;
    end;

    FEMFImagePage := FLastFoundPage;
    RecordNo := 0;
    {$IFDEF FPC}
    FindInLmf(Self, FEMFImage);
    {$ELSE}
    EnumEnhMetafile(0, FEMFImage.Handle, @EnumEMFRecordsProc, Self, Rect(0, 0, 0, 0));
    {$ENDIF}
    if not FindAll and TextFound then
    begin
      HighlightText;
      Preview.FAllowF3 := True;
      Break;
    end;
    Inc(FLastFoundPage);
    LastFoundRecord := -1;
  end;
  if not FindAll and not TextFound then
  begin
    ShowMessage(frxResources.Get('clStrNotFound'));
    Preview.FAllowF3 := False;
  end;
end;
(*
procedure TfrxPreviewWorkspace.FindAllText(Callback: TfrxFindAllTextCallbackFunc; Data: Pointer);
var
  EMFCanvas: TMetafileCanvas;
  CallbackData : TfrxFindAllTextData;
begin
  CallbackData.Callback := Callback;
  CallbackData.Data := Data;
  Preview.FSearchFrm.CleartrvFind();
  FLastFoundPage := 0;
  while FLastFoundPage < FPageList.Count do
  begin
    if (FEMFImage = nil) or (FEMFImagePage <> FLastFoundPage) then
    begin
      if FEMFImage <> nil then
        FEMFImage.Free;
      FEMFImage := TMetafile.Create;
      EMFCanvas := TMetafileCanvas.Create(FEMFImage, 0);
      {$IFDEF FPC}
      EMFCanvas.FCreateOnlyText := True;
      {$ENDIF}
      PreviewPages.DrawPage(FLastFoundPage, EMFCanvas, 1, 1, 0, 0);
      EMFCanvas.Free;
    end;

    FEMFImagePage := FLastFoundPage;
    RecordNo := 0;
    CallbackData.PageNo := FLastFoundPage;

    {$IFDEF FPC}
    FindAllInLmf(Self, FEMFImage, Rect(0, 0, 0, 0), CallbackData);
    {$ELSE}
    EnumEnhMetafile(0, FEMFImage.Handle, @EnumAllEMFRecordsProc, @CallbackData, Rect(0, 0, 0, 0));
    {$ENDIF}

    Inc(FLastFoundPage);
  end;
end;
*)
procedure TfrxPreviewWorkspace.HighlightText;
var
  PageBounds, TxtBounds: TRect;
begin
  PageBounds := FPageList.GetPageBounds(FLastFoundPage, ClientWidth, Zoom, FRTLLanguage);
  TxtBounds := Rect(Round(TextBounds.Left * Zoom),
    Round(TextBounds.Top * Zoom),
    Round(TextBounds.Right * Zoom),
    Round(TextBounds.Bottom * Zoom));

  if (PageBounds.Top + TxtBounds.Top < FOffset.Y) or
    (PageBounds.Top + TxtBounds.Bottom > FOffset.Y + ClientHeight) then
    VertPosition := PageBounds.Top + TxtBounds.Bottom - ClientHeight + 20;
  if (PageBounds.Left + TxtBounds.Left < FOffset.X) or
    (PageBounds.Left + TxtBounds.Right > FOffset.X + ClientWidth) then
    HorzPosition := PageBounds.Left + TxtBounds.Right - ClientWidth + 20;
  Repaint;
end;

procedure TfrxPreview.SetOutlineTreeSortType(
  const Value: TfrxTreeSortType);
begin
  if FOutlineTreeSortType = Value then Exit;
  FOutlineTreeSortType := Value;
  FillOutlineTree;
end;

procedure TfrxPreviewWorkspace.Resize;
begin
  inherited;
  HorzPage := ClientWidth;
  VertPage := ClientHeight;
end;

procedure TfrxPreviewWorkspace.SetToPageNo(PageNo: Integer);
begin
  if FDisableUpdate then Exit;
  VertPosition :=
    FPageList.GetPageBounds(PageNo - 1, ClientWidth, Zoom, FRTLLanguage).Top - 10;
end;

procedure TfrxPreviewWorkspace.UpdateScrollBars;
var
  MaxSize: TPoint;
begin
  MaxSize := FPageList.GetMaxBounds;
  HorzRange := MaxSize.X + 10;
  VertRange := MaxSize.Y + 10;
end;

function TfrxPreviewWorkspace.ScaleRect(const aRect: TRect;
  Scale, aOffsetX, aOffsetY: Extended): TfrxRect;
begin
  if aRect.Left > aRect.Right then
  begin
    Result.Left := (aRect.Right - aOffsetX)  / Scale;
    Result.Right := (aRect.Left - aOffsetX) / Scale;
  end
  else
  begin
    Result.Left := (aRect.Left - aOffsetX)  / Scale;
    Result.Right := (aRect.Right - aOffsetX) / Scale;
  end;
  if aRect.Top > aRect.Bottom then
  begin
    Result.Top := (aRect.Bottom - aOffsetY) / Scale;
    Result.Bottom := (aRect.Top - aOffsetY) / Scale;
  end
  else
  begin
    Result.Top := (aRect.Top - aOffsetY) / Scale;
    Result.Bottom := (aRect.Bottom - aOffsetY) / Scale;
  end;
end;

procedure TfrxPreviewWorkspace.SetEditMode(
  var aEvent: TfrxPreviewIntEventParams);
begin
  aEvent.EditMode := dtHand;
  if FHighlightEditable then
    aEvent.EditMode := dtEditor;
end;

procedure TfrxPreviewWorkspace.SetLocked(const Value: Boolean);
begin
  if (not Value) and Assigned(FCachedView) then
   FreeAndNil(FCachedView);
  if Value and (FLocked <> Value) then
  begin
    FCachedView := TBitmap.Create;
    FCachedView.Canvas.Lock;
    FCachedView.Width := Width;
    FCachedView.Height := Height;
    PaintTo(FCachedView.Canvas.Handle, 0, 0);
    FCachedView.Canvas.Unlock;
  end;
  FLocked := Value;
end;

procedure TfrxPreviewWorkspace.SetPosition(PageN, Top: Integer);
var
  Pos: Integer;
  Page: TfrxReportPage;
begin
  Page := PreviewPages.Page[PageN - 1];
  if Page = nil then
    exit;
  if Top = 0 then
    Pos := 0
  else
    Pos := Round((Top + Page.TopMargin * fr01cm) * Zoom);

  VertPosition := FPageList.GetPageBounds(PageN - 1, ClientWidth, Zoom, FRTLLanguage).Top - 10 + Pos;
end;

function TfrxPreviewWorkspace.GetPreviewPages: TfrxCustomPreviewPages;
begin
  Result := FPreview.PreviewPages;
end;

procedure TfrxPreviewWorkspace.LockVScroll;
begin
  FLockVScroll := True;
end;

procedure TfrxPreviewWorkspace.UnLockVScroll;
begin
  FLockVScroll := False;
end;

function TfrxPreviewWorkspace.GetTopPosition: Integer;
var
  Page: TfrxReportPage;
begin
  Result := 0;
  Page := PreviewPages.Page[Preview.PageNo - 1];
  if Page <> nil then
    Result := Round((VertPosition - FPageList.GetPageBounds(Preview.PageNo - 1,ClientWidth, Zoom, FRTLLanguage).Top + 10)/ Zoom - Page.TopMargin * fr01cm);
end;

procedure TfrxPreviewWorkspace.AddPage(AWidth, AHeight: Integer);
begin
  FPageList.AddPage(AWidth, AHeight, Zoom);
end;

procedure TfrxPreviewWorkspace.CalcPageBounds(ClientWidth: Integer);
begin
  FPageList.CalcBounds(ClientWidth);
end;

procedure TfrxPreviewWorkspace.CallIteractiveEvent(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer; var aEvent: TfrxPreviewIntEventParams);
var
  PageNo: Integer;
  PageBounds: TRect;
begin
  aEvent.Cursor := FDefaultCursor;
  PageNo := FPageList.FindPage(FOffset.Y + Y, FOffset.X + X);
  PageBounds := FPageList.GetPageBounds(PageNo, ClientWidth, Zoom, FRTLLanguage);
  PreviewPages.ObjectOver(PageNo, X, Y, Button, Shift, Zoom,
  PageBounds.Left - FOffset.X, PageBounds.Top - FOffset.Y, aEvent);
end;

procedure TfrxPreviewWorkspace.ClearPageList;
begin
  FPageList.Clear;
end;


procedure TfrxPreviewWorkspace.PrevDblClick(Sender: TObject);
begin
  if not IsThumbnail and Assigned(FPreview.OnDblClick) then
    FPreview.OnDblClick(Sender);
end;

{ TfrxPreview }

constructor TfrxPreview.Create(AOwner: TComponent);
var
  m: TMenuItem;
begin
  inherited;
  PPIScale := 1;
  FCalledFromPreview := False;
  FInitialized := False;
  FEachReportInTab := False;
  FOutlinePopup := TPopupMenu.Create(Self);
  FOutlinePopup.Images := frxImages.PreviewButtonImages;
  m := TMenuItem.Create(FOutlinePopup);
  CreateSortPopup;
  FOutlinePopup.Items.Add(m);
  m.Caption := frxGet(601);
  m.ImageIndex := 13;
  m.OnClick := OnCollapseClick;
  m := TMenuItem.Create(FOutlinePopup);
  FOutlinePopup.Items.Add(m);
  m.Caption := frxGet(600);
  m.ImageIndex := 14;
  m.OnClick := OnExpandClick;

  FTabImgList := TImageList.Create(Self);
  FTabImgList.Width := 16;
  FTabImgList.Height := 16;
  FTabs := TTabControl.Create(Self);
  with FTabs do
  begin
    Parent := Self;
    Align := alTop;
    Visible := False;
    FTabs.Height := 22;
    FTabs.Images := FTabImgList;
    OnChange := OnChangeTab;
    OnMouseUp := OnTabMouseUP;
    DoubleBuffered := True;
  end;

  FOutline := TfrxTreePanel.Create(Self);
  FOutline.ToolPanel.ParentBackground := False;
  FOutline.ToolPanel.OnBtnClick := ToolOnClick;
  with FOutline do
  begin
    Parent := Self;
    Align := alLeft;
    FOutline.TreeView.HideSelection := False;
{$IFDEF UseTabset}
    BorderStyle := bsNone;
    BevelKind := bkFlat;
{$ELSE}
    BorderStyle := bsSingle;
{$ENDIF}
    TreeView.OnClick := OnOutlineClick;
    PopupMenu := FOutlinePopup;
  end;

  FFindSplitter := TSplitter.Create(Self);
  FFindSplitter.Parent := Self;
  FFindSplitter.Align := alRight;
  FFindSplitter.Visible := False;
  FFindSplitter.OnMoved:= OnMoveSplitter;
  FOutline.ToolPanel.ImageList := frxImages.PreviewButtonImages;
  FSortButton := FOutline.ToolPanel.Addbutton(33, frxGet(4117), ord(taSortData), fbsDropDownButton);
  FOutline.ToolPanel.Addbutton(ord(taCollapse), frxGet(601), ord(taCollapse), fbsButton);
  FOutline.ToolPanel.Addbutton(ord(taExpand), frxGet(600), ord(taExpand), fbsButton);

  if not (csDesigning in ComponentState) then
  begin
    FSearchFrm := TfrxSearchForm.Create(Self);
    SetFindFmVisible(False);
    FSearchFrm.Align := alRight;
    FSearchFrm.Constraints.MinWidth:= 50;
  end;

  FThumbnail := TfrxPreviewWorkspace.Create(Self);
  FThumbnail.Parent := Self;
  FThumbnail.Align := alLeft;
  FThumbnail.Visible := False;
  FThumbnail.Zoom := 0.1;
  FThumbnail.IsThumbnail := True;
  FThumbnail.Preview := Self;

  FSplitter := TSplitter.Create(Self);
  FSplitter.Parent := Self;
  FSplitter.Align := alLeft;
  FSplitter.Width := 4;
  FSplitter.Left := FOutline.Width + 1;
  FSplitter.OnMoved := OnMoveSplitter;

  FWorkspace := TfrxPreviewWorkspace.Create(Self);
  FWorkspace.Parent := Self;
  FWorkspace.Align := alClient;
  FWorkspace.Preview := Self;

  FMessagePanel := TPanel.Create(Self);
  FMessagePanel.Parent := Self;
  FMessagePanel.Visible := False;
  FMessagePanel.SetBounds(0, 0, 0, 0);

  FMessageLabel := TLabel.Create(FMessagePanel);
  FMessageLabel.Parent := FMessagePanel;
  FMessageLabel.AutoSize := False;
  FMessageLabel.Alignment := taCenter;
  FMessageLabel.SetBounds(4, 20, 255, 20);

  FCancelButton := TButton.Create(FMessagePanel);
  FCancelButton.Parent := FMessagePanel;
  FCancelButton.SetBounds(92, 44, 75, 25);
  FCancelButton.Caption := frxResources.Get('clCancel');
  FCancelButton.Visible := False;
  FCancelButton.OnClick := OnCancel;
  {$IFNDEF FPC}
  FBorderStyle := bsSingle;
  {$ENDIF}
  FPageNo := 1;
  FScrollBars := ssBoth;
  FZoom := 1;
  FZoomMode := zmDefault;
  FOutlineColor := clWindow;
  UseReportHints := True;
  { Tabs uses TfrxPreviewWorkspace and should folows after it creates}
  FTabItems := TfrxPreviewTabs.Create(Self);
  FInPlaceditorsList := frxRegEditorsClasses.CreateEditorsInstances(evPreview, FWorkspace);
  Width := 100;
  Height := 100;
  FSavedPageNo := -1;

  FUnion := True;
  FGeneralDialog := True;
end;

destructor TfrxPreview.Destroy;
begin
  ClearAllTabs;
  FreeAndNil(FSortPopUp);
  inherited;
  FreeAndNil(FTabItems);
end;

procedure TfrxPreview.DoFinishInPlace(Sender: TObject; Refresh,
  Modified: Boolean);
var
  ModObjList: TList;
  Params: Variant;
  i: Integer;
begin
  inherited;
  if Report <> nil then
  begin
    //Report.DoNotifyEvent(Sender, TfrxReportComponent(Sender).OnContentChanged, True);
      ModObjList := TList.Create;
      try
        Params := VarArrayOf([frInteger(Sender),
          frInteger(ModObjList), True]);
        Report.DoParamEvent(TfrxReportComponent(Sender).OnContentChanged, Params, True);
        for i := 0 to ModObjList.Count - 1 do
          if TObject(ModObjList[i]) is TfrxView then
            PreviewPages.ModifyObject(TfrxView(ModObjList[i]));
      finally
        ModObjList.Free;
      end;
  end;
  if Refresh then Invalidate;
end;

procedure TfrxPreview.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    {$IFNDEF FPC}
    Style := Style or BorderStyles[FBorderStyle];
    {$ENDIF}
    if {$IFNDEF FPC}Ctl3D and {$ENDIF} NewStyleControls and (BorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

function TfrxPreview.Init(aReport: TfrxReport; aPrevPages: TfrxCustomPreviewPages): Boolean;
var
  TabName: String;
begin
  Result := False;
  if FCalledFromPreview Then Exit;
  if FInitialized then
    if EachReportInTab then
    begin
      AddPreviewTabOrSwitch(aReport, '', '', False);
      Exit;
    end;

  if Parent is TfrxPreviewForm then
    FPreviewForm := TForm(Parent);

  TextFound := False;
  FWorkspace.FLastFoundPage := 0;
  LastFoundRecord := -1;
  FAllowF3 := False;
  if not FInitialized then
  begin
    if aReport.PreviewOptions.ZoomMode = zmDefault then
      FZoom := aReport.PreviewOptions.Zoom
    else
      FZoomMode := aReport.PreviewOptions.ZoomMode;
    if aReport.FileName <> '' then
      TabName := ExtractFileName(aReport.FileName)
    else
      TabName := aReport.ReportOptions.Name;
    AddPreviewTab(aReport, TabName, TabName, False);
  end
  else
  begin
     FTabItems[FTabItems.FCurTab].Report := aReport;
     FTabItems[FTabItems.FCurTab].PreviewPages := aPrevPages;
     SwitchToTab(aReport);
     Result := True;
     Exit;
  end;
  FInitialized := True;
  FWorkspace.DoubleBuffered := True;
  OutlineWidth := Round(aReport.PreviewOptions.OutlineWidth * PPIScale);
  OutlineVisible := aReport.PreviewOptions.OutlineVisible;
  ThumbnailVisible := aReport.PreviewOptions.ThumbnailVisible;
  if UseRightToLeftAlignment then
    begin
      if not(Owner is TfrxPreviewForm) then
        FlipChildren(True);
      aReport.PreviewOptions.RTLPreview := True;                       //
      Workspace.RTLLanguage := True;                                   // Following line switches TTreeView to correct RTL display
      {$IFNDEF FPC}
      SetWindowLong(FOutline.Handle, GWL_EXSTYLE, GetWindowLong(FOutline.Handle, GWL_EXSTYLE) or WS_EX_LAYOUTRTL or WS_EX_NOINHERITLAYOUT);
      {$ENDIF}
    end;
  UpdatePages;
  UpdateOutline;
  First;
  Result := True;
end;

procedure TfrxPreview.WMEraseBackground(var Message: TMessage);
begin
end;

procedure TfrxPreview.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TfrxPreview.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Up then
    FWorkspace.VertPosition := FWorkspace.VertPosition - 8
  else if Key = vk_Down then
    FWorkspace.VertPosition := FWorkspace.VertPosition + 8
  else if Key = vk_Left then
    FWorkspace.HorzPosition := FWorkspace.HorzPosition - 8
  else if Key = vk_Right then
    FWorkspace.HorzPosition := FWorkspace.HorzPosition + 8
  else if Key = vk_Prior then
    if ssCtrl in Shift then
      PageNo := PageNo - 1
    else
      FWorkspace.VertPosition := FWorkspace.VertPosition - 300
  else if Key = vk_Next then
    if ssCtrl in Shift then
      PageNo := PageNo + 1
    else
      FWorkspace.VertPosition := FWorkspace.VertPosition + 300
  else if Key = vk_Home then
    PageNo := 1
  else if Key = vk_End then
    PageNo := PageCount
  else if (Key = vk_F3) and (pbFind in Report.PreviewOptions.Buttons) then
    FindNext
  else if ssCtrl in Shift then
  begin
    if (Key = Ord('P')) and (pbPrint in Report.PreviewOptions.Buttons) then
      Print
    else if (Key = Ord('S')) and (pbSave in Report.PreviewOptions.Buttons) then
      SaveToFile
    else if (Key = Ord('F')) and (pbFind in Report.PreviewOptions.Buttons) then
      Find
    else if (Key = Ord('O')) and (pbLoad in Report.PreviewOptions.Buttons) then
      LoadFromFile
  end;
end;

procedure TfrxPreview.Resize;
begin
  inherited;
  if PreviewPages <> nil then
    UpdatePages;
end;

procedure TfrxPreview.OnMoveSplitter(Sender: TObject);
begin
  UpdatePages;
end;

procedure TfrxPreview.OnCollapseClick(Sender: TObject);
begin
  FOutline.TreeView.FullCollapse;
  FWorkspace.SetFocus;
end;

procedure TfrxPreview.OnExpandClick(Sender: TObject);
begin
  FOutline.TreeView.FullExpand;
  if FOutline.TreeView.Items.Count > 0 then
    FOutline.TreeView.TopItem := FOutline.TreeView.Items[0];
  FWorkspace.SetFocus;
end;

procedure TfrxPreview.SetZoom(const Value: Extended);
begin
  FZoom := Value;
  if FZoom < 0.25 then
    FZoom := 0.25;

  FZoomMode := zmDefault;
  UpdatePages;
end;

procedure TfrxPreview.SetZoomMode(const Value: TfrxZoomMode);
begin
  FZoomMode := Value;
  UpdatePages;
end;

function TfrxPreview.GetOutlineVisible: Boolean;
begin
  Result := FOutline.Visible;
end;

function TfrxPreview.GetOutline: TTreeView;
begin
  Result := FOutline.TreeView;
end;

procedure TfrxPreview.SetOutlineVisible(const Value: Boolean);
var
  NeedChange: Boolean;
begin
  NeedChange := Value <> FOutline.Visible;

  FSplitter.Visible := Value or ThumbnailVisible;
  FOutline.Visible := Value;

  if UseRightToLeftAlignment then
      FOutline.Left := Width;

  if Value then
    FThumbnail.Visible := False;

  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).OutlineB.Down := Value;
  if NeedChange then
    UpdatePages;
end;

function TfrxPreview.GetThumbnailVisible: Boolean;
begin
  Result := FThumbnail.Visible;
end;

procedure TfrxPreview.SetThumbnailVisible(const Value: Boolean);
var
  NeedChange: Boolean;
begin
  NeedChange := Value <> FThumbnail.Visible;

  FSplitter.Visible := Value or OutlineVisible;
  FThumbnail.Visible := Value;

  if UseRightToLeftAlignment then
    FThumbnail.Left := Width;

  if Value then
    FOutline.Visible := False;

  if Value then
  begin
    FThumbnail.HorzPosition := FThumbnail.HorzPosition;
    FThumbnail.VertPosition := FThumbnail.VertPosition;
  end;
  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).ThumbB.Down := Value;
  if NeedChange then
    UpdatePages;
end;

function TfrxPreview.GetOutlineWidth: Integer;
begin
  Result := FOutline.Width;
end;

procedure TfrxPreview.SetOutlineWidth(const Value: Integer);
begin
  FOutline.Width := Value;
  if not (csDesigning in ComponentState) then
  begin
    FThumbnail.Width := Value;
    FSearchFrm.Width := Value;
  end;
end;

procedure TfrxPreview.SetOutlineColor(const Value: TColor);
begin
  FOutlineColor := Value;
  FOutline.Color := Value;
end;

procedure TfrxPreview.SetPageNo(Value: Integer);
begin
  if Value < 1 then
    Value := 1;
  if Value > PageCount then
    Value := PageCount;
  try
    Workspace.LockVScroll;
    SetActivePage(Value);
    FWorkspace.SetToPageNo(FPageNo);
    FThumbnail.SetToPageNo(FPageNo);
    UpdatePageNumbers;
  finally
    Workspace.UnLockVScroll;
  end;
end;

function TfrxPreview.GetHideScrolls: Boolean;
begin
  Result := FWorkspace.HideScrolls;
end;

procedure TfrxPreview.SetHideScrolls(const Value: Boolean);
begin
  FWorkspace.HideScrolls := Value;
end;

function TfrxPreview.GetOnScrollMaxChange: TfrxScrollMaxChangeEvent;
begin
  Result := FWorkspace.OnScrollMaxChange;
end;

procedure TfrxPreview.SetOnScrollMaxChange(const Value: TfrxScrollMaxChangeEvent);
begin
  FWorkspace.OnScrollMaxChange := Value;
end;

function TfrxPreview.GetOnScrollPosChange: TfrxScrollPosChangeEvent;
begin
  Result := FWorkspace.OnScrollPosChange;
end;

procedure TfrxPreview.SetOnScrollPosChange(const Value: TfrxScrollPosChangeEvent);
begin
  FWorkspace.OnScrollPosChange := Value;
end;

function TfrxPreview.GetActiveFrameColor: TColor;
begin
  Result := FWorkspace.ActiveFrameColor;
end;

function TfrxPreview.GetBackColor: TColor;
begin
  Result := FWorkspace.BackColor;
end;

function TfrxPreview.GetFrameColor: TColor;
begin
  Result := FWorkspace.FrameColor;
end;

function TfrxPreview.GetHighlightEditable: Boolean;
begin
  Result := FWorkspace.HighlightEditable;
end;

function TfrxPreview.GetLocked: Boolean;
begin
  Result := (FLocks > 0);
end;

procedure TfrxPreview.CompositeTabsExport(Filter: TfrxCustomExportFilter);
var
  mem: TMemoryStream;
  buffPrevPags: TfrxCustomPreviewPages;
begin
  mem := TMemoryStream.Create;
  TabItems[0].PreviewPages.SaveToStream(mem);
  mem.Position := 0;
  buffPrevPags := Report.PreviewPagesList.Add;
  buffPrevPags.Engine := Self.PreviewPages.Engine;
  buffPrevPags.LoadFromStream(mem);
  mem.Free;

  CompositePreviewPages(buffPrevPags);

  buffPrevPags.Export(Filter);
  Report.PreviewPagesList.Delete(buffPrevPags);
end;

procedure TfrxPreview.CompositePreviewPages(buffPrevPags: TfrxCustomPreviewPages);
var
  PrevPags: TfrxCustomPreviewPages;
  Page: TfrxReportPage;
  a, b, c: Integer;
  glob: Integer;

  procedure LookComponent(Comp: TfrxComponent);
  var
    Hyp: TfrxHyperlink;
    i: Integer;
    index: Integer;

    function findPage(s: String): Integer;
    var
      i: Integer;
      j: Integer;
    begin
      Result := 0;
      for i := 0 to TabItems.Count - 1 do
      begin
        if (TabItems[i].Name = s) then
        begin
          Result := 1;
          for j := 0 to i - 1 do
            Result := Result + TabItems[j].PreviewPages.Count;
          break;
        end;
      end;
    end;

  begin
    for i := 0 to Comp.Objects.Count - 1 do
      LookComponent(Comp.Objects[i]);
    comp.Visible := false;
    if (comp is TfrxView) then
      if (TfrxView(comp).Hyperlink <> nil) then
        begin
          Hyp := TfrxView(comp).Hyperlink;
          case (Hyp.Kind) of
            hkDetailReport, hkDetailPage:
            begin
              Hyp.DetailPage := '';
              Hyp.ReportVariable := '';
              Hyp.Expression := '';
              index := findPage(Hyp.Value);
              if (index > 0) then
              begin
                Hyp.Kind := hkPageNumber;
                Hyp.Value := IntToStr(index);
              end
              else
              begin
                Hyp.Kind := hkURL;
                Hyp.Value := '';
              end;
            end;
            hkPageNumber:
              Hyp.Value := IntToStr(StrToInt(Hyp.Value) + glob);
          end;
        end;
  end;

begin
  glob := 0;
  for a := 0 to TabItems.Count - 1 do
  begin
    if (a > 0) then
      buffPrevPags.AddFromPreviewPages(TabItems[a].PreviewPages);
    PrevPags := TabItems[a].PreviewPages;
    for b := 0 to PrevPags.Count - 1 do
    begin
      Page := buffPrevPags.Page[b + glob];
      for c := 0 to Page.Objects.Count - 1 do
        LookComponent(Page.Objects[c]);
      buffPrevPags.ModifyPage(b + glob, Page)
    end;
    glob := glob + PrevPags.Count;
  end;
end;

procedure TfrxPreview.SeparateTabsExport(Filter: TfrxCustomExportFilter);
var
  i: Integer;
  oldShowDialogOptions: TfrxShowDialogOptions;
begin
  TabItems[0].PreviewPages.Export(Filter);
  if (FGeneralDialog) then
  begin
    oldShowDialogOptions := Filter.ShowDialogOptions;
    Filter.ShowDialogOptions := Filter.ShowDialogOptions - [doShowExportSettings];
  end;
  for i := 1 to TabItems.Count - 1 do
    TabItems[i].PreviewPages.Export(Filter);
  if (FGeneralDialog) then
    Filter.ShowDialogOptions := oldShowDialogOptions;
end;

procedure TfrxPreview.SetTabsVisible(b: Boolean);
begin
  FTabs.Visible := b;
  if (Parent is TfrxPreviewForm) then
    TfrxPreviewForm(Parent).SaveAllTabsB.Visible := b and (pbExport in Report.PreviewOptions.Buttons);
end;

procedure TfrxPreview.SetActiveFrameColor(const Value: TColor);
begin
  FWorkspace.ActiveFrameColor := Value;
end;

procedure TfrxPreview.SetActivePage(Value: Integer);
var
  ActivePageChanged: Boolean;
begin
  ActivePageChanged := FPageNo <> Value;
  FPageNo := Value;
  FWorkspace.PageNo := Value;
  FThumbnail.PageNo := Value;

  if ActivePageChanged then
  begin
    FWorkspace.DrawPages(True);
    FThumbnail.DrawPages(True);
  end;
end;

procedure TfrxPreview.SetBackColor(const Value: TColor);
begin
  FWorkspace.BackColor := Value;
end;

procedure TfrxPreview.SetFrameColor(const Value: TColor);
begin
  FWorkspace.FrameColor := Value;
end;

procedure TfrxPreview.SetHighlightEditable(const Value: Boolean);
begin
  if FWorkspace.HighlightEditable <> Value then
  begin
    FWorkspace.HighlightEditable := Value;
    Repaint;
  end;
end;

function TfrxPreview.GetFindFmVisible: Boolean;
begin
  if not (csDesigning in ComponentState) then
    Result := FSearchFrm.Visible
  else
    Result := DesignerFSearchFrmVisible;
end;

procedure TfrxPreview.SetFindFmVisible(Value: Boolean);
var
  NeedChange: Boolean;
begin
  if (csDesigning in ComponentState) then
  begin
    DesignerFSearchFrmVisible := Value;
    Exit;
  end;
  NeedChange := Value <> FSearchFrm.Visible;

  //FSearchFrm.CleartrvFind();
  if Value then
    TextToFind := '';
  if not (csDesigning in ComponentState) and Value then
    FSearchFrm.Parent := Self;
  if FSearchFrm.trvFind <> nil then
    begin
      FSearchFrm.CleartrvFind();
      FSearchFrm.trvFind.OnChange := OnTrvFindChange;
    end;
  if FSearchFrm.btnFind <> nil then
    FSearchFrm.btnFind.OnClick:= OnFindClick;

  FSearchFrm.Visible := Value;

  FFindSplitter.Visible := Value;
  if not Value then
    TextFound := False;
  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).FindB.Down := Value;
  if NeedChange then
    UpdatePages;
end;

{$IFNDEF FPC}
procedure TfrxPreview.SetBorderStyle(Value: TBorderStyle);
begin
  if BorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;
{$ENDIF}

procedure TfrxPreview.ClearPageList;
begin
  FWorkspace.ClearPageList;
  FThumbnail.ClearPageList;
  UpdateOutline;
  FWorkspace.UpdateScrollBars;
  FThumbnail.UpdateScrollBars;
end;

procedure TfrxPreview.UpdatePageNumbers;
begin
  if Assigned(FOnPageChanged) then
    FOnPageChanged(Self, FPageNo);
end;

function TfrxPreview.GetPageCount: Integer;
begin
  if PreviewPages <> nil then
    Result := PreviewPages.Count
  else
    Result := 0;
end;

function TfrxPreview.GetPreviewPages: TfrxCustomPreviewPages;
begin
  Result := inherited GetPreviewPages;
end;

function TfrxPreview.GetReport: TfrxReport;
begin
  if (FTabItems = nil) or (FTabItems.Count = 0) or (FTabItems.FCurTab < 0) then
    Result := inherited GetReport
  else
    Result := FTabItems[FTabItems.FCurTab].Report;
end;

function TfrxPreview.GetOnMouseDown: TMouseEvent;
begin
  Result := FWorkspace.OnMouseDown;
end;

procedure TfrxPreview.SetOnMouseDown(const Value: TMouseEvent);
begin
  FWorkspace.OnMouseDown := Value;
end;

procedure TfrxPreview.ShowMessage(const s: String);
begin
  FMessagePanel.SetBounds((Width - 260) div 2, (Height - 75) div 3, 260, 75);
  FMessageLabel.Caption := s;
  FMessagePanel.Show;
  FMessagePanel.Update;
end;

procedure TfrxPreview.SwitchToTab(const aReport: TfrxReport);
var
  i: Integer;
begin
  for i := 0 to FTabItems.Count - 1 do
    if (FTabItems[i].Report = aReport) and (FTabItems[i].PreviewPages = aReport.PreviewPages) then
    begin
      if FTabs.TabIndex <> i then
      begin
        FTabs.TabIndex := i;
        OnChangeTab(FTabs);
      end;
      break;
    end;
end;

function TfrxPreview.HasTab(const aReport: TfrxReport): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FTabItems.Count - 1 do
    if (FTabItems[i].Report = aReport) and (FTabItems[i].PreviewPages = aReport.PreviewPages) then
    begin
      Result := True;
      break;
    end;
end;

function TfrxPreview.HasVisibleTabs: Boolean;
begin
  Result := FTabs.Tabs.Count > 1;
end;

procedure TfrxPreview.HideMessage;
begin
  FMessagePanel.Hide;
  FCancelButton.Hide;
end;

procedure TfrxPreview.First;
begin
  PageNo := 1;
end;

procedure TfrxPreview.Next;
begin
  PageNo := PageNo + 1;
end;

procedure TfrxPreview.Prior;
begin
  PageNo := PageNo - 1;
end;

procedure TfrxPreview.Last;
begin
  PageNo := PageCount;
end;

procedure TfrxPreview.PreviewPagesChanged;
begin
//  ClearPageList;
  Repaint;
end;

procedure TfrxPreview.Print;
begin
  if FRunning then Exit;
  try
    PreviewPages.CurPreviewPage := PageNo;
    PreviewPages.Print;
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.SaveToFile;
var
//  SaveDlg: TSaveDialog;
  Filter: TfrxCustomIOTransport;
begin
  if FRunning then Exit;
  if Assigned(frxDefaultIODialogTransportClass) then
    Filter := frxDefaultIODialogTransportClass.CreateNoRegister
  else
    Filter := frxDefaultIOTransportClass.CreateNoRegister;
  Filter.CreatedFrom := fvPreview;
  Filter.DefaultExt := '.fp3';
  Filter.FilterString := frxResources.Get('clFP3files') + ' (*.fp3)|*.fp3';
  try
    PreviewPages.SaveToFilter(Filter, '');
    FWorkspace.Repaint;
  finally
    Filter.Free;
  end;
end;
//  SaveDlg := TSaveDialog.Create(Application);
//  try
////    SaveDlg.Options := SaveDlg.Options + [ofNoChangeDir];
////    SaveDlg.Filter := frxResources.Get('clFP3files') + ' (*.fp3)|*.fp3';
////    if frxCompressorClass <> nil then
////      SaveDlg.Filter := SaveDlg.Filter + '|' + frxResources.Get('clComprPreparedRepFilter');
//    if SaveDlg.Execute then
//    begin
//      FWorkspace.Repaint;
//      Report.ReportOptions.Compressed := SaveDlg.FilterIndex = 2;
//      SaveToFile(ChangeFileExt(SaveDlg.FileName, '.fp3'));
//    end;
//  finally
//    SaveDlg.Free;
//  end;
//end;

procedure TfrxPreview.SaveToFile(FileName: String);
begin
  if FRunning then Exit;
  try
    Lock;
    ShowMessage(frxResources.Get('clSaving'));
    PreviewPages.SaveToFile(FileName);
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.LoadFromFile;
var
  OpenDlg: TOpenDialog;
begin
  if FRunning then Exit;
  OpenDlg := TOpenDialog.Create(nil);
  try
    OpenDlg.Options := [ofHideReadOnly, ofNoChangeDir];
    OpenDlg.Filter := frxResources.Get('clFP3files') + ' (*.fp3)|*.fp3';
    if OpenDlg.Execute then
    begin
      FWorkspace.Repaint;
      LoadFromFile(OpenDlg.FileName);
    end;
  finally
    OpenDlg.Free;
  end;
end;

procedure TfrxPreview.LoadFromFile(FileName: String);
begin
  if FRunning then Exit;
  try
    Lock;
    ShowMessage(frxResources.Get('clLoading'));
    PreviewPages.LoadFromFile(FileName);
  finally
    PageNo := 1;
    UpdateOutline;
    Unlock;
  end;
end;

procedure TfrxPreview.Export(Filter: TfrxCustomExportFilter;
  ExportsAllTabs: Boolean = False);
begin
  if FRunning then Exit;
  try
    PreviewPages.CurPreviewPage := PageNo;
    if Report.DotMatrixReport and (frxDotMatrixExport <> nil) and
      (Filter.ClassName = 'TfrxTextExport') then
      Filter := frxDotMatrixExport;
    if not (ExportsAllTabs) then
      PreviewPages.Export(Filter)
    else
      CompositeExport(Filter);
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.CompositeExport(Filter: TfrxCustomExportFilter);
begin
  if (FUnion) then
    CompositeTabsExport(Filter)
  else
    SeparateTabsExport(Filter);
end;

function TfrxPreview.FindText(SearchString: String; FromTop, IsCaseSensitive: Boolean): Boolean;//trash
begin
  TextToFind := SearchString;
  CaseSensitive := IsCaseSensitive;
  if FromTop or not FAllowF3 then
    FWorkspace.FLastFoundPage := 0
  else
    FWorkspace.FLastFoundPage := PageNo - 1;
  LastFoundRecord := -1;

  FWorkspace.FindText;
  if TextFound then
    UpdateFindPage;
  Result := TextFound;
end;

function TfrxPreview.FindTextFound: Boolean;
begin
  Result := TextFound;
end;

procedure TfrxPreview.FindTextClear;
begin
  LastFoundRecord := -1;
  FWorkspace.FLastFoundPage := 0;
  TextFound := False;
  Invalidate;
end;

{procedure TfrxPreview.FindAllText(SearchString: String;
  IsCaseSensitive: Boolean; Callback: TfrxFindAllTextCallbackFunc; Data: Pointer);
begin
  TextToFind := SearchString;
  CaseSensitive := IsCaseSensitive;

  FWorkspace.FindAllText(Callback, Data);

  FWorkspace.FLastFoundPage := 0;
  LastFoundRecord := -1;
  TextFound := False;
end;

procedure TfrxPreview.FindAllTextItemHighlight(Item: TfrxFindAllTextItem);//not used
begin
  FWorkspace.FLastFoundPage := Item.PageNo;
  TextBounds := Item.Bounds;
  TextFound := True;

  FWorkspace.HighlightText;
end;}

procedure TfrxPreview.PageSetupDialog;
begin
  PageSetupDlg;
end;

procedure TfrxPreview.PageSetupDlg;
var
  APage: TfrxReportPage;

  procedure UpdateReport;
  var
    i: Integer;
  begin
    for i := 0 to Report.PagesCount - 1 do
      if Report.Pages[i] is TfrxReportPage then
        with TfrxReportPage(Report.Pages[i]) do
        begin
          Orientation := APage.Orientation;
          PaperWidth := APage.PaperWidth;
          PaperHeight := APage.PaperHeight;
          PaperSize := APage.PaperSize;

          LeftMargin := APage.LeftMargin;
          RightMargin := APage.RightMargin;
          TopMargin := APage.TopMargin;
          BottomMargin := APage.BottomMargin;
        end;
  end;

begin
  if FRunning then Exit;
  APage := PreviewPages.Page[PageNo - 1];

  if Assigned(APage) then with TfrxPageSettingsForm.Create(Application) do
  begin
    Page := APage;
    Report := Self.Report;
    if ShowModal = mrOk then
    begin
      if NeedRebuild then
      begin
        {$IFNDEF FRVIEWER}
          UpdateReport;
          RefreshReport;
        {$ENDIF}
      end
      else
      begin
        try
          Lock;
          PreviewPages.ModifyPage(PageNo - 1, Page);
        finally
          Unlock;
        end;
      end;
    end;
    Free;
  end;
end;

procedure TfrxPreview.Find;
begin
  {
  with TfrxSearchDialog.Create(Application) do
  begin
    if ShowModal = mrOk then
    begin
      TextToFind := TextE.Text;
      CaseSensitive := CaseCB.Checked;
      if TopCB.Checked then
        FWorkspace.FLastFoundPage := 0
      else
        FWorkspace.FLastFoundPage := PageNo - 1;
      LastFoundRecord := -1;
      FWorkspace.FindText;
    end;
    Free;
  end;
  }
  if not (Self.Parent is TfrxPreviewForm) then
    begin
      FindFmVisible := not FindFmVisible;
      exit;
    end; 

  if not TfrxPreviewForm(Self.Parent).FindB.Down then
     TfrxPreviewForm(Self.Parent).FindB.Down := True
  else
     TfrxPreviewForm(Self.Parent).FindB.Down := False;
  FindFmVisible := TfrxPreviewForm(Self.Parent).FindB.Down;
end;

procedure TfrxPreview.FindNext;
begin
  if FAllowF3 or (not TextFound) then
  begin
    if not TextFound then
      FWorkSpace.FLastFoundPage := 0
    else
      FWorkSpace.FLastFoundPage := PageNo - 1;
    FWorkspace.FindText;
    if TextFound then
      UpdateFindPage;
  end;
end;

procedure TfrxPreview.Edit;
var
  r: TfrxReport;
  p: TfrxReportPage;
  SourcePage: TfrxPage;

  procedure RemoveBands;
  var
    i: Integer;
    l: TList;
    c: TfrxComponent;
  begin
    l := p.AllObjects;

    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if c is TfrxView then
      begin
        TfrxView(c).DataField := '';
        TfrxView(c).DataSet := nil;
        TfrxView(c).Restrictions := [];
      end;

      if (c.Parent <> p) and (c.Parent is TfrxBand) then
      begin
        c.Left := c.AbsLeft;
        c.Top := c.AbsTop;
        c.ParentFont := False;
        c.Parent := p;
        if (c is TfrxView) and (TfrxView(c).Align in [baBottom, baClient]) then
          TfrxView(c).Align := baNone;
      end;
    end;

    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if c is TfrxBand then
        c.Free;
    end;
  end;

begin
  SourcePage := PreviewPages.Page[PageNo - 1];
  r := nil;
  if Assigned(SourcePage) then
  try

    if SourcePage is TfrxDMPPage then
      p := TfrxDMPPage.Create(nil) else
      p := TfrxReportPage.Create(nil);
    r := TfrxReport.Create(nil);
    p.AssignAll(SourcePage);
    p.Parent := r;
    RemoveBands;
    if r.DesignPreviewPage then
      try
        Lock;
        PreviewPages.ModifyPage(PageNo - 1, TfrxReportPage(r.Pages[0]));
      finally
        Unlock;
      end;
  except
  end;
  if r <> nil then
    r.Free;
end;

procedure TfrxPreview.EditTemplate;
var
  r: TfrxReport;
  i: Integer;
begin
  r := TfrxReport.Create(nil);
  try
    for i := 0 to TfrxPreviewPages(PreviewPages).SourcePages.Count - 1 do
      r.Objects.Add(TfrxPreviewPages(PreviewPages).SourcePages[i]);
    r.DesignReport;
  finally
    r.Objects.Clear;
    r.Free;
  end;
end;

procedure TfrxPreview.Clear;
var
  PrevPages: TfrxCustomPreviewPages;
begin
  if FRunning then Exit;
  PrevPages := PreviewPages;
  if PrevPages = nil then Exit;

  Lock;
  try
    PrevPages.Clear;
  finally
    Unlock;
  end;

  FWorkspace.ClearPageList;
  FThumbnail.ClearPageList;
  UpdateOutline;
  PageNo := 1;
  with FWorkspace do
  begin
    HorzRange := 0;
    VertRange := 0;
  end;
  if ThumbnailVisible then
  with FThumbnail do
  begin
    HorzRange := 0;
    VertRange := 0;
  end;
end;


procedure TfrxPreview.ClearAllTabs;
begin
  FCalledFromPreview := True;
  if Report <> nil then
  begin
     Report.Preview := nil;
    // assign previewpages from the first tab. Other tabs will be destroyed, so Report.PreviewPages may reference a destroyed object.
    // This will result in AV when the same report will run next time
    if FTabItems.Count >= 1 then
    begin
      //restore for original report value, not for active
      FTabItems[0].Report.PreviewPages := FTabItems[0].PreviewPages;
      FTabItems[0].Report.Preview  := nil;
      //Report.PreviewPages := FTabItems[0].PreviewPages;
    end;

  end;
  FCalledFromPreview := False;
  FTabItems.ClearItems;
end;

procedure TfrxPreview.AddPage;
begin
  if FRunning then Exit;
  PreviewPages.AddEmptyPage(PageNo - 1);
  UpdatePages;
  PageNo := PageNo;
end;

procedure TfrxPreview.DeletePage;
begin
  if FRunning then Exit;
  PreviewPages.DeletePage(PageNo - 1);
  if PageNo >= PageCount then
    PageNo := PageNo - 1;
  UpdatePages;
  UpdatePageNumbers;
end;

function TfrxPreview.Lock: Boolean;
begin
  Result := False;
  Inc(FLocks);
  if FLocks > 1 then Exit;
  FWorkspace.Locked := True;
  FThumbnail.Locked := True;
  Result := True;
end;

procedure TfrxPreview.UnInit(aReport: TfrxReport);
var
  i: Integer;
begin
  if FCalledFromPreview then Exit;
  i := 0;
  FTabs.Tabs.BeginUpdate;
  while i < FTabItems.Count do
  begin
    if FTabItems[i].Report = aReport then
      RemoveTab(i)
    else
      Inc(i);
  end;
   if FTabItems.Count = 0 then
    FInitialized := false;
  FTabs.Tabs.EndUpdate;
end;

procedure TfrxPreview.Unlock(DoUpdate: Boolean);
begin
  if FLocks <= 0 then Exit;
  Dec(FLocks);
  if FLocks > 0 then Exit;
  HideMessage;
  FWorkspace.Locked := False;
  FThumbnail.Locked := False;
  if DoUpdate then
  begin
    UpdatePages;
    FWorkspace.Repaint;
    FThumbnail.Repaint;
  end;

end;

procedure TfrxPreview.SetPosition(PageN, Top: Integer);
begin
  if PageN > PageCount then
    PageN := PageCount;
  if PageN <= 0 then
    PageN := 1;
  FWorkspace.SetPosition(PageN, Top);
end;

function  TfrxPreview.GetTopPosition: Integer;
begin
  Result := FWorkspace.GetTopPosition;
end;

procedure TfrxPreview.RefreshReport;
var
  hpos, vpos, pno: Integer;
  zoom: extended;
  RepPage: TfrxPage;
begin
  if not Assigned(Report) then exit;

  hpos := FWorkspace.HorzPosition;
  vpos := FWorkspace.VertPosition;
  pno := PageNo;
  if Assigned(PreviewPages) then
    PreviewPages.FireMouseLeave;
  Lock;
  FRefreshing := True;
  try
    // detail page
    zoom := FZoom;
    if (FTabItems.Count > 1) and (FTabs.TabIndex > 0) and (FTabItems[FTabs.TabIndex].DetailPage <> '') then
    begin
      FTabItems[FTabs.TabIndex].PreviewPages.Clear;
      Report.Report.PreviewPages := FTabItems[FTabs.TabIndex].PreviewPages;
      Report.Engine.PreviewPages := FTabItems[FTabs.TabIndex].PreviewPages;
      Report.PreviewPages.Engine := Report.Engine;
      RepPage := Report.FindObject(FTabItems[FTabs.TabIndex].DetailPage) as TfrxPage;
      if RepPage <> nil then
        Report.PreparePage(RepPage);
    end
    else
      Report.PrepareReport;
    FZoom := zoom;
    FThumbnail.Locked := False;
    if pno <= PageCount then
      PageNo := pno
    else
      PageNo := PageCount;
    UpdatePages;
    UpdateOutline;
  finally
    Unlock;
    FRefreshing := False;
  end;

  FWorkspace.HorzPosition := hpos;
  if (PageNo = 1) and (FWorkspace.PreviewPages.Page[0].PaperHeight < vpos) then
    FWorkspace.VertPosition := 0
  else
    FWorkspace.VertPosition := vpos;
  FWorkspace.VertPosition := vpos;
  FWorkspace.Locked := False;
  FWorkspace.Repaint;
  FThumbnail.Repaint;
  if pno > PageCount then
    PageNo := PageCount;
end;

procedure TfrxPreview.UpdateFindPage;
begin
  FWorkSpace.FDisableUpdate := True;
  SetPageNo(FWorkSpace.FLastFoundPage + 1);
  FWorkSpace.FDisableUpdate := False;
end;

procedure TfrxPreview.UpdatePages;
var
  PageSize: TPoint;
  i, correct, rect_w, rect_h: Integer;
begin
  if (Locked and (not FRefreshing)) or (PageCount = 0) then Exit;

  { clear find settings }
  FAllowF3 := False;
  FWorkspace.FEMFImagePage := -1;

  { calc zoom if not zmDefault}
  PageSize := PreviewPages.PageSize[PageNo - 1];
  if PageSize.Y = 0 then Exit;
  case FZoomMode of
    zmWholePage:
      begin
        if PageCount > 1 then correct := GetSystemMetrics(SM_CXVSCROLL) else correct := 0;
        rect_w := FWorkspace.Width - correct - 26;
        if rect_w < 1 then rect_w := 1;
        rect_h := FWorkspace.Height - 26;
        if rect_h < 1 then rect_h := 1;
        if PageSize.Y / rect_h < PageSize.X / rect_w then
          FZoom := rect_w / PageSize.X
        else
          FZoom := rect_h / PageSize.Y;
        SetPosition(PageNo, 0);
      end;
    zmPageWidth:
      FZoom := (FWorkspace.Width - GetSystemMetrics(SM_CXVSCROLL) - 26) / PageSize.X
  end;

  FThumbnail.DoubleBuffered := True;
  { fill page list and calc bounds }
  FWorkspace.Zoom := FZoom;
  FThumbnail.Zoom := 0.1 * PPIScale;
  FWorkspace.ClearPageList;
  FThumbnail.ClearPageList;
  for i := 0 to PageCount - 1 do
  begin
    PageSize := PreviewPages.PageSize[i];
    FWorkspace.AddPage(PageSize.X, PageSize.Y);
    if not FRunning then
      FThumbnail.AddPage(PageSize.X, PageSize.Y);
  end;

  FWorkspace.CalcPageBounds(FWorkspace.Width - GetSystemMetrics(SM_CXVSCROLL) - 26);
  if not FRunning then
    FThumbnail.CalcPageBounds(FThumbnail.Width - GetSystemMetrics(SM_CXVSCROLL) - 26);

  FWorkspace.UpdateScrollBars;
  FThumbnail.UpdateScrollBars;
  { avoid positioning errors when resizing }
  FWorkspace.HorzPosition := FWorkspace.HorzPosition;
  FWorkspace.VertPosition := FWorkspace.VertPosition;

  if not FRefreshing then
  begin
    FWorkspace.Repaint;
    FThumbnail.Repaint;
  end;

  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).UpdateZoom;
  FThumbnail.DoubleBuffered := False;
end;

procedure TfrxPreview.UpdateOutline;
var
  Outline: TfrxCustomOutline;
  Pages: TfrxCustomPreviewPages;

  procedure DoUpdate(RootNode: TTreeNode);
  var
    i, n: Integer;
    Node: TTreeNode;
    Page, Top: Integer;
    Text: String;
  begin
    n := Outline.Count;
    for i := 0 to n - 1 do
    begin
      Outline.GetItem(i, Text, Page, Top);
      Node := FOutline.TreeView.Items.AddChild(RootNode, Text);
      Node.ImageIndex := Page + 1;
      Node.StateIndex := Top;

      Outline.LevelDown(i);
      DoUpdate(Node);
      Outline.LevelUp;
    end;
  end;

begin
  Pages := nil;
  if Assigned(Report) then
    Pages := Report.PreviewPages;
  FOutline.TreeView.Items.BeginUpdate;
  FOutline.TreeView.Items.Clear;
  if Assigned(Pages) then
  begin

    Outline := Report.PreviewPages.Outline;
    Outline.LevelRoot;
    DoUpdate(nil);
    if Report.PreviewOptions.OutlineExpand then
      FOutline.TreeView.FullExpand;
    if FOutline.TreeView.Items.Count > 0 then
      FOutline.TreeView.TopItem := FOutline.TreeView.Items[0];
  end;
  FOutline.TreeView.Items.EndUpdate;
end;

procedure TfrxPreview.OnOutlineClick(Sender: TObject);
var
  Node: TTreeNode;
  PageN, Top: Integer;
begin
  Node := FOutline.TreeView.Selected;
  if Node = nil then Exit;

  PageN := Node.ImageIndex;
  Top := Node.StateIndex;

  SetPosition(PageN, Top);
  SetActivePage(PageN);
  SetFocus;
end;


procedure TfrxPreview.OnTrvFindChange(Sender: TObject; Node: TTreeNode);
var
  s: string;
begin
  if Node = nil then
    Exit;
  if Node.Data = nil then
  begin
    s := Node.Text;
    s := Copy(s,Pos(' ', s) + 1, Length(s));
    SetPageNo(StrToInt(s));
    Exit;
  end;
  TextBounds := PfrxTrvData(Node.Data)^.TextBnd;
  TextFound := True;
  WorkSpace.FLastFoundPage := PfrxTrvData(Node.Data)^.PageNo;

  WorkSpace.HighlightText;
  UpdateFindPage;
end;

procedure TfrxPreview.OnFindClick(Sender: TObject);
begin
  if Self.PreviewPages = nil then Exit;

  if (TextToFind = FSearchFrm.edtFind.Text)
    and (CaseSensitive = FSearchFrm.chkCase.Checked)
    and (FindAll = FSearchFrm.chkFindAll.Checked) and FindAll then
      Exit;

  TextToFind := FSearchFrm.edtFind.Text;
  CaseSensitive := FSearchFrm.chkCase.Checked;
  FindAll := FSearchFrm.chkFindAll.Checked;
  SearchFB := FSearchFrm.chkBeg.Checked;
  if FSearchFrm.trvFind.Items.Count > 0 then
    FSearchFrm.CleartrvFind();

  if not FindAll then
  begin
    if SearchFB or not FAllowF3 then
    begin
      FWorkSpace.FLastFoundPage := 0;
      LastFoundRecord := -1;
    end
    else
      FWorkSpace.FLastFoundPage := PageNo - 1;
    Self.SetFocus;
  end;

  if FindAll then
  begin
    LastFoundRecord := -1;
    FAllowF3 := False;
  end;

  FWorkSpace.FindText;
  if FindAll then
    FSearchFrm.trvFind.FullExpand
  else
    if TextFound then
      UpdateFindPage;
end;

procedure TfrxPreview.InternalOnProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if FRefreshing then Exit;

  Clear;
  Report.DrillState.Clear;
  FRunning := True;
  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).UpdateControls;
end;

procedure TfrxPreview.InternalOnProgress(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
var
  PageSize: TPoint;
begin
  if FRefreshing then
  begin
    UpdatePageNumbers;
    Exit;
  end;

  if Report.Engine.FinalPass then
  begin
    PageSize := Report.PreviewPages.PageSize[Progress];
    if Progress < 50 then
    begin
      FWorkspace.AddPage(PageSize.X, PageSize.Y);
      FWorkspace.CalcPageBounds(FWorkspace.Width - GetSystemMetrics(SM_CXVSCROLL) - 26);
    end;
  end;

  if Progress = 0 then
  begin
    PageNo := 1;
    if Report.Engine.FinalPass then
      UpdatePages;
    if Owner is TfrxPreviewForm then
      TfrxPreviewForm(Owner).CancelB.Caption := frxResources.Get('clCancel');
    FTick := GetTickCount;
  end
  else if Progress = 1 then
  begin
    FTick := GetTickCount - FTick;
    if FTick < 5 then
      FTick := 50
    else if FTick < 10 then
      FTick := 20
    else
      FTick := 5;
    PageNo := 1;
    if Report.Engine.FinalPass then
      UpdatePages;
  end
  else if Progress mod Integer(FTick) = 0 then
  begin
    UpdatePageNumbers;
    if Report.Engine.FinalPass then
      FWorkspace.UpdateScrollBars;
  end;

  Application.ProcessMessages;
end;

procedure TfrxPreview.InternalOnProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if FRefreshing then Exit;

  FRunning := False;
  UpdatePageNumbers;
  FWorkspace.UpdateScrollBars;
  FThumbnail.UpdateScrollBars;
  UpdatePages;
  UpdateOutline;
  if Owner is TfrxPreviewForm then
  begin
    TfrxPreviewForm(Owner).CancelB.Caption := frxResources.Get('clClose');
    TfrxPreviewForm(Owner).StatusBar.Panels[1].Text := '';
    TfrxPreviewForm(Owner).UpdateControls;
  end;
end;

procedure TfrxPreview.OnCancel(Sender: TObject);
begin
  Report.Terminated := True;
end;

procedure TfrxPreview.Cancel;
begin
  if FRunning then
    OnCancel(Self);
end;

procedure TfrxPreview.MouseWheelScroll(Delta: Integer; Shift: TShiftState; MousePos: TPoint; Horz: Boolean = False);
begin
  {$IFNDEF Linux}
  if FWorkspace.DoMouseWheel(Shift, Delta, MousePos) then Exit;
  {$ENDIF}
  if Delta <> 0 then
    if ssCtrl in Shift then
    begin
      FZoom := FZoom + Round(Delta / Abs(Delta)) / 10;
      if FZoom < 0.3 then
        FZoom := 0.3;
      SetZoom(FZoom);
    end
    else
    begin
      with FWorkspace do
      begin
        if Horz then
          HorzPosition := HorzPosition + Round(-Delta / Abs(Delta)) * 20
        else
          VertPosition := VertPosition + Round(-Delta / Abs(Delta)) * 20;
      end;
    end;
end;

procedure TfrxPreview.AddCloseBtnToImageList;
var
  b: TBitmap;
begin
  if FTabs.Tabs.Count < FTabImgList.Count then
    Exit;

  b := TBitmap.Create;
  b.Canvas.Lock;
  b.Width := 16;
  b.Height := 16;
  b.Canvas.Brush.Color := clOlive;
  b.Canvas.FillRect(Rect(0, 0, 16, 16));
  frxImages.PreviewButtonImages.Draw(b.Canvas, 0, 0, 17);
  FTabImgList.AddMasked(b, b.TransparentColor);
  b.Canvas.Unlock;
  b.Free;
end;

procedure TfrxPreview.AddPreviewTab(AReport: TfrxReport; const TabName: String; const TabCaption: String; FreeObjects: Boolean; aDetailPage: String);
{$IFDEF FPC}
var
  c: TCustomTabControl;
{$ENDIF}
begin
  AddCloseBtnToImageList;
  Lock;
  try
    if TabCaption = '' then
      FTabs.Tabs.AddObject(TabName, AReport)
    else
      FTabs.Tabs.AddObject(TabCaption, AReport);
    FTabItems.AddTab(AReport, aDetailPage, TabName, FreeObjects);
    SetTabsVisible(FTabs.Tabs.Count > 1);
    FTabs.TabIndex := FTabs.Tabs.Count - 1;
    OnChangeTab(nil);
{$IFDEF FPC}
    if FTabs.Tabs is TTabControlNoteBookStrings then
    begin
       c := TTabControlNoteBookStrings(FTabs.Tabs).NoteBook;
       c.Images := FTabImgList;
       c.Page[c.PageCount - 1].ImageIndex := 0;
    end;
{$ENDIF}
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.AddPreviewTabOrSwitch(AReport: TfrxReport;
  const TabName: String; const TabCaption: String; FreeObjects: Boolean;
  aDetailPage: String);
begin
  if HasTab(AReport) then
    SwitchToTab(AReport)
  else
  begin
    if TabName = '' then
    begin
      if AReport.FileName <> '' then
        AddPreviewTab(AReport, ExtractFileName(AReport.FileName), TabCaption, FreeObjects, aDetailPage)
      else
        AddPreviewTab(AReport, AReport.ReportOptions.Name, TabCaption, FreeObjects, aDetailPage);
    end
    else
      AddPreviewTab(AReport, TabName, TabCaption, FreeObjects, aDetailPage);
  end;
end;

function TfrxPreview.HasTab(const TabName: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FTabItems.Count - 1 do
    if FTabItems[i].Name = TabName then
    begin
      Result := True;
      break;
    end;
end;

procedure TfrxPreview.SwitchToTab(const TabName: String);
var
  i: Integer;
begin
  for i := 0 to FTabItems.Count - 1 do
    if FTabItems[i].Name = TabName then
    begin
      FTabs.TabIndex := i;
      OnChangeTab(FTabs);
      break;
    end;
end;

procedure TfrxPreview.OnChangeTab(Sender: TObject);
begin
  if Assigned(PreviewPages) then
    PreviewPages.FireMouseLeave;
  if FTabs.TabIndex = -1 then
    Exit;
  Lock;
  try
    FTabItems.SetCurrentTab(FTabs.TabIndex);
    if (Sender <> nil) and (Sender is TfrxPreview) then
      OnPageChanged(TfrxPreview(Sender), 1);
    if (Owner is TfrxPreviewForm) and TfrxPreviewForm(Owner).FindB.Down then
    begin
      TfrxPreviewForm(Owner).FindB.Down := false;
      TfrxPreviewForm(Owner).FindB.Click;
    end;
  finally
    Unlock;
  end;
end;

procedure TfrxPreview.OnTabMouseUP(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Rect: TRect;
{$IFDEF FPC}
  c: TCustomTabControl;
  OffSet: Integer;
{$ENDIF}
begin
  // don't delete the first tab
  if FTabs.TabIndex < 1 then
    Exit;
  Rect := FTabs.TabRect(FTabs.TabIndex);
{$IFDEF FPC}
  if FTabs.Tabs is TTabControlNoteBookStrings then
  begin
     c := TTabControlNoteBookStrings(FTabs.Tabs).NoteBook;
     OffSet := c.TabRect(0).Left;
     Rect := c.TabRect(FTabs.TabIndex);
     Rect.Left := Rect.Left - OffSet;
  end;
  if (X >= Rect.Left + 8) and (X <= Rect.Left + 18) and (Abs(Y) >= 6) and (Abs(Y) <= 18) and (Button = mbLeft) then
{$ELSE}
  if (X >= Rect.Left + 8) and (X <= Rect.Left + 18) and (Y >= 6) and (Y <= 18) and (Button = mbLeft) then
{$ENDIF}
    RemoveTab(FTabs.TabIndex);
end;

procedure TfrxPreview.RemoveTab(TabIndex: Integer);
begin
  if TabIndex = 0 then
     FTabs.TabIndex := TabIndex + 1
  else
    FTabs.TabIndex := TabIndex - 1;
  Lock;
  try
    FTabs.Tabs.Delete(TabIndex);
    FTabItems.DeleteTab(TabIndex);
    if FTabs.TabIndex > -1 then
    begin
      FCalledFromPreview := True;
      FTabItems[FTabs.TabIndex].Report.Preview := Self;
      FCalledFromPreview := False;
      { need in case when all tabs closed except main }
      FTabItems.FCurTab := FTabs.TabIndex;
      FTabItems.SetCurrentTab(FTabs.TabIndex);
    end;
  finally
    Unlock;
  end;

  SetTabsVisible(FTabs.Tabs.Count > 1);
  if FTabItems.Count = 0 then
  begin
    ClearPageList;
    FInitialized := false;
    Repaint;
  end;
end;


procedure TfrxPreview.RemoveTabs(aReport: TfrxReport);
var
  i: Integer;
begin
  i := 1;
  while i < FTabItems.Count do
  begin
    if FTabItems[i].Report = aReport then
      RemoveTab(i)
    else
      Inc(i);
  end;
end;

{ TfrxPreviewForm }

procedure TfrxPreviewForm.FormCreate(Sender: TObject);
begin
{$IFNDEF FPC}
  FStatusBarOldWindowProc := StatusBar.WindowProc;
  StatusBar.WindowProc := StatusBarWndProc;
{$ENDIF}
  FPreview := TfrxPreview.Create(Self);
  FPreview.Parent := Self;
  FPreview.Align := alClient;
  FPreview.BorderStyle := bsNone;
  {$IFNDEF FPC}
  FPreview.BevelKind := bkNone;
  {$ENDIF}
  FPreview.OnPageChanged := OnPageChanged;
  FPreview.OnDblClick := OnPreviewDblClick;
  ZoomCB.OnKeyPress := ZoomCBKeyPress;
  ActiveControl := FPreview;
  SetWindowLong(PageE.Handle, GWL_STYLE, GetWindowLong(PageE.Handle, GWL_STYLE)
    {$IFNDEF FPC}or ES_NUMBER{$ENDIF});
{$IFDEF DELPHI10}
  frTBPanel1.ParentBackground := False;
  Sep3.ParentBackground := False;
  Sep4.ParentBackground := False;
{$ENDIF}

{$IFDEF DELPHI24}
  ToolBar.StyleElements := [seFont, seBorder];
{$ENDIF}
  FFullScreen := False;
  FPDFExport := nil;
  FEmailExport := nil;
end;

procedure TfrxPreview.CreateSortPopup;
var
  m: TMenuItem;

  procedure CreateItem(sName: String; ImgIdx: Integer);
  begin
    m := TMenuItem.Create(FSortPopUp);
    FSortPopUp.Items.Add(m);
    m.RadioItem := True;
    m.Caption := sName;
    m.ImageIndex := ImgIdx;
    m.Tag := ImgIdx;
    m.OnClick := ToolOnClick;
  end;
begin
  FSortPopUp := TPopupMenu.Create(nil);
  FSortPopUp.Images := frxImages.PreviewButtonImages;
  CreateItem(frxGet(4330), ord(taUnsorted));
  CreateItem(frxGet(4328), ord(taAscending));
  CreateItem(frxGet(4329), ord(taDescending));
end;

procedure TfrxPreview.TreeViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
    {$IFNDEF FPC}Data: Integer;{$ENDIF} var Compare: Integer);
  begin
    if Node1.Text < Node2.Text then Compare := 1;
    if Node1.Text = Node2.Text then Compare := 0;
    if Node1.Text > Node2.Text then Compare := -1;
  end;

procedure TfrxPreview.FillOutlineTree;
begin
  case OutlineTreeSortType of
    dtsUnsorted: FSortButton.ImageIndex := Ord(taUnsorted);
    dtsAscending: FSortButton.ImageIndex := Ord(taAscending);
    dtsDescending: FSortButton.ImageIndex := Ord(taDescending);
  end;
  if FOutlineTreeSortType = dtsAscending then
  begin
    FOutline.TreeView.OnCompare := nil;
    FOutline.TreeView.AlphaSort;
  end
  else
  if FOutlineTreeSortType = dtsDescending then
  begin
    FOutline.TreeView.OnCompare := TreeViewCompare;
    FOutline.TreeView.AlphaSort;
  end
  else
  begin
    FOutline.TreeView.Items.Clear;
    UpdateOutline;
  end;
end;

procedure TfrxPreviewForm.Init;
begin
  FIsClosing := False;
  FillItemsList(FFilterList, fvPreview);

  FPreview.Init(Report, Report.PreviewPages);
  with Report.PreviewOptions do
  begin
    {$IFDEF FR_LITE}
      DesignerB.Enabled := False;
    {$ELSE}
      DesignerB.Enabled := AllowEdit;
    {$ENDIF}
    PrintB.Visible := pbPrint in Buttons;
    OpenB.Visible := pbLoad in Buttons;
    SaveB.Visible := (pbSave in Buttons) or (pbExport in Buttons);
    FindB.Visible := pbFind in Buttons;
    HighlightEditableTB.Visible :=  (pbInplaceEdit in Buttons) and AllowPreviewEdit;
    PdfB.Visible := False;
    EmailB.Visible := False;

    ZoomPlusB.Visible := pbZoom in Buttons;
    ZoomMinusB.Visible := pbZoom in Buttons;
    Sep3.Visible := pbZoom in Buttons;
    FullScreenBtn.Visible := (pbZoom in Buttons) and not (pbNoFullScreen in Buttons);
    if not (pbZoom in Buttons) then
      Sep1.Visible := False;

    OutlineB.Visible := pbOutline in Buttons;
    ThumbB.Visible := pbOutline in Buttons;
    PageSettingsB.Visible := pbPageSetup in Buttons;
    DesignerB.Visible := pbEdit in Buttons;
    if not (PageSettingsB.Visible or DesignerB.Visible) then
      Sep2.Visible := False;

    FirstB.Visible := pbNavigator in Buttons;
    PriorB.Visible := pbNavigator in Buttons;
    NextB.Visible := pbNavigator in Buttons;
    LastB.Visible := pbNavigator in Buttons;
    Sep4.Visible := pbNavigator in Buttons;
    if not (pbNavigator in Buttons) then
      Sep5.Visible := False;

    CancelB.Visible := not (pbNoClose in Buttons);

    if Maximized then
    {$IFDEF UNIX}
      BoundsRect := Screen.DesktopRect;
    {$ELSE}
      WindowState := wsMaximized;
    {$ENDIF}
    if MDIChild then
      FormStyle := fsMDIChild;
    if ZoomMode = zmDefault then
      FPreview.Zoom := Zoom
    else
      FPreview.ZoomMode := ZoomMode;

    Toolbar.ShowCaptions := ShowCaptions;
  end;

  ZoomCB.Items.BeginUpdate;
  ZoomCB.Items.Clear;
  ZoomCB.Items.Add('25%');
  ZoomCB.Items.Add('50%');
  ZoomCB.Items.Add('75%');
  ZoomCB.Items.Add('100%');
  ZoomCB.Items.Add('150%');
  ZoomCB.Items.Add('200%');
  ZoomCB.Items.Add(frxResources.Get('zmPageWidth'));
  ZoomCB.Items.Add(frxResources.Get('zmWholePage'));
  ZoomCB.Items.EndUpdate;

  if Report.ReportOptions.Name <> '' then
    Caption := Report.ReportOptions.Name
  else
    Caption := frxGet(100);
  CreateExportMenu;
  if UseRightToLeftAlignment then
    FlipChildren(True);

  UpdateControls;
  PopupMenu := RightMenu;
  UpdateStyles;
end;

procedure TfrxPreviewForm.UpdateControls;

  function HasDrillDown: Boolean;
  var
    l: TList;
    i: Integer;
    c: TfrxComponent;
  begin
    Result := False;
    l := Report.AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      begin
        Result := True;
        break;
      end;
    end;
  end;

  procedure EnableControls(cAr: array of TObject; Enabled: Boolean);
  var
    i: Integer;
  begin
    for i := 0 to High(cAr) do
    begin
      if cAr[i] is TMenuItem then
        TMenuItem(cAr[i]).Visible := Enabled
      else if cAr[i] is TToolButton then
      begin
        TToolButton(cAr[i]).Enabled := Enabled;
        TToolButton(cAr[i]).Down := False;
        {$IFDEF FPC}
        {$warning casting TMenuItem from Tag produces crash on 64bit}
        {$ELSE}
        if TToolButton(cAr[i]).Tag <> 0 then
          TMenuItem(TToolButton(cAr[i]).Tag).Enabled := Enabled;
        {$ENDIF}
      end;
    end;
  end;

begin
  StyleSheetCB.Enabled := not FPreview.FRunning;
  UpdateStyles;
  EnableControls([PrintB, OpenB, SaveB, PdfB, EmailB, FindB, PageSettingsB],
    (not FPreview.FRunning) and (FPreview.PageCount > 0));
  EnableControls([OpenB], (not FPreview.FRunning));
  EnableControls([DesignerB],
    not FPreview.FRunning and Report.PreviewOptions.AllowEdit);
  EnableControls([ExpandMI, CollapseMI, N1],
    not FPreview.FRunning and HasDrillDown);
end;

procedure TfrxPreviewForm.UpdateFormPPI(aNewPPI: Integer);
{$IFDEF FPC}
var
  ofs: Integer;
{$ENDIF}
begin
  inherited;
  Toolbar.Images := frxImages.PreviewButtonImages;
  RightMenu.Images := ToolBar.Images;
  PPIScale := aNewPPI / frx_DefaultPPI;
{$IFNDEF FPC}
  ZoomCB.Resize;
  Toolbar.ButtonHeight := Toolbar.Images.Height + Round(frxDefaultToolBtnGap * PPIScale);
  Toolbar.ButtonWidth := Toolbar.Images.Width + Round(frxDefaultToolBtnGap * PPIScale);
  //Sep3.AutoSize := True;
  Sep3.Width := ZoomCB.Width + 6;
  //Sep4.AutoSize := True;
  Sep4.Width := MulDiv(Sep4.Width, aNewPPI, CurrentFormPPI);
  CancelB.Width := Round(frxDefaultCancelBWidth * aNewPPI / frx_DefaultPPI);
  PageE.Top := (Sep4.Height - PageE.Height) div 2;
  OfNL.Top := PageE.Top;
  ZoomCB.Top := (Sep4.Height - ZoomCB.Height) div 2
{$ELSE}
  Toolbar.ButtonWidth := Toolbar.Images.Width + frxDefaultToolBtnGap;
  Toolbar.ButtonHeight := Toolbar.Images.Height + frxDefaultToolBtnGap;
  Toolbar.Height := Toolbar.ButtonHeight;
  ZoomCB.Width := MulDiv(56, aNewPPI, frx_DefaultPPI);
  Sep3.Width := ZoomCB.Width + 6;
  CancelB.Width := Round(frxDefaultCancelBWidth * aNewPPI / frx_DefaultPPI);
 {$IFDEF Linux}
  ofs := 15;
 {$ELSE}
  ofs := 5;
 {$ENDIF}
  Sep3.Width := Sep3.Width + Round(ofs * aNewPPI / frx_DefaultPPI);
  ZoomCB.Width := ZoomCB.Width + Round(ofs * aNewPPI / frx_DefaultPPI);
 {$IFDEF Linux}
  OfNL.Top := OfNL.Top + Round(aNewPPI / frx_DefaultPPI);
 {$ENDIF}
{$ENDIF}
end;

procedure TfrxPreviewForm.UpdateResouces;
begin
  inherited;
  //Caption := frxGet(100);
  PrintB.Caption := frxGet(101);
  PrintB.Hint := frxGet(102);
  OpenB.Caption := frxGet(103);
  OpenB.Hint := frxGet(104);
  SaveB.Caption := frxGet(105);
  SaveB.Hint := frxGet(106);
  SaveAllTabsB.Caption := frxGet(320);
  SaveAllTabsB.Hint := frxGet(321);
  FindB.Caption := frxGet(109);
  FindB.Hint := frxGet(110);
  ZoomCB.Hint := frxGet(119);
  PageSettingsB.Caption := frxGet(120);
  PageSettingsB.Hint := frxGet(121);
  DesignerB.Caption := frxGet(132);
  DesignerB.Hint := frxGet(133);
  {$IFDEF FR_LITE}
    DesignerB.Hint := DesignerB.Hint + #13#10 + 'This feature is not available in FreeReport';
  {$ENDIF}
  FirstB.Caption := frxGet(134);
  FirstB.Hint := frxGet(135);
  PriorB.Caption := frxGet(136);
  PriorB.Hint := frxGet(137);
  NextB.Caption := frxGet(138);
  NextB.Hint := frxGet(139);
  LastB.Caption := frxGet(140);
  LastB.Hint := frxGet(141);
  CancelB.Caption := frxResources.Get('clClose');
  PageE.Hint := frxGet(142);
  FullScreenBtn.Hint := frxGet(150);
  FullScreenBtn.Caption := frxGet(149);
  PdfB.Hint := frxGet(151);
  PdfB.Caption := frxGet(154);
  EmailB.Hint := frxGet(152);
  EmailB.Caption := frxGet(153);
  ZoomPlusB.Caption := frxGet(124);
  ZoomPlusB.Hint := frxGet(125);
  ZoomMinusB.Caption := frxGet(126);
  ZoomMinusB.Hint := frxGet(127);
  OutlineB.Caption := frxGet(128);
  OutlineB.Hint := frxGet(129);
  ThumbB.Caption := frxGet(130);
  ThumbB.Hint := frxGet(131);
  HighlightEditableTB.Caption := frxGet(702);
  HighlightEditableTB.Hint := frxGet(701);
  // TODO: do not update controlls directly
  // remove it later
  if ZoomCB.Items.Count > 6 then
  begin
    ZoomCB.Items[6] := frxResources.Get('zmPageWidth');
    ZoomCB.Items[7] := frxResources.Get('zmWholePage');
  end;
  // TODO Localize export menu
  ExpandMI.Caption := frxGet(600);
  CollapseMI.Caption := frxGet(601);
  CopyCmd.Caption := frxGet(160);
  PasteCmd.Caption := frxGet(161);
  StyleLabel.Caption := frxGet(164);
end;

procedure TfrxPreviewForm.UpdateStyles;
var
  LIndex: Integer;
begin
  StylePan.Visible := Report.PreviewPages.IsStylesActive;
  if not Report.PreviewPages.IsStylesActive then Exit;
  Report.PreviewPages.Styles.GetStyleSheetList(StyleSheetCB.Items);
  StylePan.Visible := StyleSheetCB.Items.Count > 1;
  LIndex := StyleSheetCB.Items.IndexOf(Report.PreviewPages.Styles.ActiveStyleSheet);
  if LIndex < 0 then LIndex := 0;
  StyleSheetCB.ItemIndex := LIndex;
end;

procedure TfrxPreviewForm.PrintBClick(Sender: TObject);
begin
  FPreview.Print;
  Enabled := True;
end;

procedure TfrxPreviewForm.OpenBClick(Sender: TObject);
begin
  FPreview.LoadFromFile;
  if Report.ReportOptions.Name <> '' then
    Caption := Report.ReportOptions.Name
  else
    Caption := frxGet(100);
{$IFDEF FRVIEWER}
  UpdateControls;
{$ELSE}
  UpdateStyles;
{$ENDIF}
end;

procedure TfrxPreviewForm.SaveBClick(Sender: TObject);
begin
  FPreview.SaveToFile;
end;

procedure TfrxPreviewForm.FindBClick(Sender: TObject);
begin
  //FPreview.Find;
  FPreview.FindFmVisible := FindB.Down;
  if (not FPreview.FindFmVisible) then
    FPreview.SetFocus;
end;

procedure TfrxPreviewForm.ZoomPlusBClick(Sender: TObject);
begin
  FPreview.Zoom := FPreview.Zoom + 0.25;
  ZoomCBClick(nil);
end;

procedure TfrxPreviewForm.ZoomMinusBClick(Sender: TObject);
begin
  FPreview.Zoom := FPreview.Zoom - 0.25;
  ZoomCBClick(nil);
end;

function TfrxPreviewForm.GetReport: TfrxReport;
begin
  Result := Preview.Report;
end;

procedure TfrxPreviewForm.HighlightEditableTBClick(Sender: TObject);
begin
//  HighlightEditableTB.Down := not HighlightEditableTB.Down;
  FPreview.HighlightEditable := HighlightEditableTB.Down;
end;

procedure TfrxPreviewForm.UpdateZoom;
begin
  ZoomCB.Text := IntToStr(Round(FPreview.Zoom * 100)) + '%';
end;

procedure TfrxPreviewForm.ZoomCBClick(Sender: TObject);
var
  s: String;
begin
  FPreview.SetFocus;
  Preview.FSavedPageNo := Preview.PageNo;
  if ZoomCB.ItemIndex = 6 then
    FPreview.ZoomMode := zmPageWidth
  else if ZoomCB.ItemIndex = 7 then
    FPreview.ZoomMode := zmWholePage
  else
  begin
    s := ZoomCB.Text;

    if Pos('%', s) <> 0 then
      s[Pos('%', s)] := ' ';
    while Pos(' ', s) <> 0 do
      Delete(s, Pos(' ', s), 1);

    if s <> '' then
      FPreview.Zoom := frxStrToFloat(s) / 100;
  end;

  PostMessage(Handle, WM_UPDATEZOOM, 0, 0);
  Preview.PageNo := Preview.FSavedPageNo;
  Preview.FSavedPageNo := -1;
end;

procedure TfrxPreviewForm.ZoomCBKeyPress(Sender: TObject; var Key: Char);
begin
  {$IFDEF DELPHI12}
  if not CharInSet(Key, ['0', '1'..'9', #8]) then
  {$ELSE}
  if not (Key in ['0', '1'..'9', #8]) then
  {$ENDIF}
    Key := #0;
end;

procedure TfrxPreviewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    CancelBClick(Self);
  if Key = VK_F11 then
    SwitchToFullScreen;
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxPreviewForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if ActiveControl = ZoomCB then
      ZoomCBClick(nil);
    if ActiveControl = PageE then
      PageEClick(nil);
  end;
end;

procedure TfrxPreviewForm.WMUpdateZoom(var Message: TMessage);
begin
  UpdateZoom;
end;

procedure TfrxPreviewForm.PageSettingsBClick(Sender: TObject);
begin
  FPreview.PageSetupDlg;
end;

procedure TfrxPreviewForm.OnPageChanged(Sender: TfrxPreview; PageNo: Integer);
var
  FirstPass: Boolean;
begin
  FirstPass := False;
  if FPreview.PreviewPages <> nil then
    FirstPass := not FPreview.PreviewPages.Engine.FinalPass;

  if FirstPass and FPreview.FRunning then
    StatusBar.Panels[0].Text := frxResources.Get('clFirstPass') + ' ' +
      IntToStr(FPreview.PageCount)
  else
  begin
    StatusBar.Panels[0].Text := Format(frxResources.Get('clPageOf'),
      [PageNo, FPreview.PageCount]);
    OfNL.Caption := Format(frxResources.Get('clOf'), [FPreview.PageCount]);
    Sep4.Width := OfNL.Left + OfNL.Width + 4;
  end;
  PageE.Text := IntToStr(PageNo);
end;

procedure TfrxPreviewForm.PageEClick(Sender: TObject);
begin
  FPreview.PageNo := StrToIntDef(PageE.Text, FPreview.PageNo);
  FPreview.SetFocus;
end;

procedure TfrxPreviewForm.FirstBClick(Sender: TObject);
begin
  FPreview.First;
end;

procedure TfrxPreviewForm.PriorBClick(Sender: TObject);
begin
  FPreview.Prior;
end;

procedure TfrxPreviewForm.NextBClick(Sender: TObject);
begin
  FPreview.Next;
end;

procedure TfrxPreviewForm.LastBClick(Sender: TObject);
begin
  FPreview.Last;
end;

procedure TfrxPreviewForm.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
 {$IFNDEF FPC}
  if (MousePos.X <> EventScrollFind) and (MousePos.Y <> EventScrollFind) then
 {$ENDIF}
  FPreview.MouseWheelScroll(WheelDelta, Shift, MousePos, False);
end;

procedure TfrxPreviewForm.DesignerBClick(Sender: TObject);
begin
  FPreview.Edit;
end;

procedure TfrxPreviewForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not FPreview.FRunning;
end;

procedure TfrxPreviewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FFreeOnClose then
    Action := caFree;
  FIsClosing := True;
  if (Report <> nil) and (Assigned(Report.OnClosePreview)) then
    Report.OnClosePreview(Self);
  if FFilterList <> nil then
    FreeAndNil(FFilterList);
end;

procedure TfrxPreviewForm.NewPageBClick(Sender: TObject);
begin
  FPreview.AddPage;
end;

procedure TfrxPreviewForm.DelPageBClick(Sender: TObject);
begin
  FPreview.DeletePage;
end;

procedure TfrxPreviewForm.CancelBClick(Sender: TObject);
begin
  if FPreview.FRunning then
    FPreview.Cancel else
    Close;
end;

procedure TfrxPreviewForm.ExportMIClick(Sender: TObject);
begin
  FPreview.Export(TfrxCustomExportFilter(frxExportFilters[TMenuItem(Sender).Tag].Filter));
  Enabled := True;
end;

procedure TfrxPreviewForm.ExportMIACTClick(Sender: TObject);
begin
  FPreview.Export(TfrxCustomExportFilter(frxExportFilters[TMenuItem(Sender).Tag].Filter), True);
  Enabled := True;
end;

procedure TfrxPreviewForm.DesignerBMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
  pt := DesignerB.ClientToScreen(Point(0, 0));
  if Button = mbRight then
    HiddenMenu.Popup(pt.X, pt.Y);
end;

destructor TfrxPreviewForm.Destroy;
begin
  if not (csDesigning in ComponentState) then
    Preview.FSearchFrm.CleartrvFind();
  FreeAndNil(FFilterList);
  inherited;
end;

procedure TfrxPreviewForm.Showtemplate1Click(Sender: TObject);
begin
  FPreview.EditTemplate;
end;

procedure TfrxPreviewForm.SetMessageText(const Value: String; IsHint: Boolean);
begin
  { call ProcessMessages only when text was changed }
  { calling too often cause messages delay with interactive events }
  if IsHint then
  begin
    if not ((Value = '') and (StatusBar.Panels[2].Text = '')) and (StatusBar.Panels[2].Text <> Value) then
    begin
      StatusBar.Panels[2].Text := Value;
      StatusBar.Repaint;
    end;
  end
  else if (StatusBar.Panels[1].Text <> Value) then
  begin
    StatusBar.Panels[1].Text := Value;
    StatusBar.Repaint;
  end;
end;

procedure TfrxPreviewForm.SwitchToFullScreen;
begin
  if not FFullScreen then
  begin
    StatusBar.Visible := False;
    ToolBar.Visible := False;
    FOldBS := BorderStyle;
    FOldState := WindowState;
    BorderStyle := bsNone;
    WindowState := {$IFDEF FPC}wsFullScreen {$ELSE}wsMaximized{$ENDIF};
    FFullScreen := True;
  end
  else
  begin
    WindowState := FOldState;
    BorderStyle := FOldBS;
    FFullScreen := False;
    StatusBar.Visible := True;
    ToolBar.Visible := True;
  end;
end;

procedure TfrxPreviewForm.FullScreenBtnClick(Sender: TObject);
begin
  SwitchToFullScreen;
end;

procedure TfrxPreviewForm.PdfBClick(Sender: TObject);
begin
  if Assigned(FPDFExport) then
    FPreview.Export(FPDFExport);
end;

procedure TfrxPreviewForm.EmailBClick(Sender: TObject);
begin
  if Assigned(FEmailExport) then
    FPreview.Export(FEmailExport);
end;

procedure TfrxPreviewForm.WMActivateApp(var Msg: TWMActivateApp);
begin
  {$IFDEF FPC}
  {$note FIXME TfrxPreviewForm.WMActivateApp}
  //if IsIconic(Application.MainForm.Handle) then
  begin
    // ShowWindow(Application.MainForm.Handle, SW_RESTORE);
    // SetActiveWindow(Handle);
  end;
  {$ELSE}
  if IsIconic(Application.Handle) then
  begin
    ShowWindow(Application.Handle, SW_RESTORE);
    SetActiveWindow(Handle);
  end;
  {$ENDIF}
  inherited;
end;

procedure TfrxPreviewForm.WMSysCommand(var Msg: TWMSysCommand);
begin
  {$IFNDEF FPC}
  if Msg.CmdType = SC_MINIMIZE then
    if not Report.PreviewOptions.MDIChild and Report.PreviewOptions.Modal  then
      ShowWindow(Application.Handle, SW_MINIMIZE)
    else
      inherited
  else
  {$ENDIF}
    inherited;
end;

procedure TfrxPreviewForm.StatusBarWndProc(var Message: TMessage);
begin
  {$IFNDEF FPC}
  if Message.Msg = WM_SYSCOLORCHANGE then
    DefWindowProc(StatusBar.Handle,Message.Msg,Message.WParam,Message.LParam)
  else
    FStatusBarOldWindowProc(Message);
  {$ENDIF}
end;

procedure TfrxPreviewForm.StyleSheetCBChange(Sender: TObject);
begin
  if StyleSheetCB.ItemIndex < 0 then Exit;
  if StyleSheetCB.ItemIndex = 0 then
    Report.PreviewPages.SetActiveStyleSheet('')
  else
    Report.PreviewPages.SetActiveStyleSheet(StyleSheetCB.Items[StyleSheetCB.ItemIndex]);
  Preview.Invalidate;
end;

procedure TfrxPreviewForm.OutlineBClick(Sender: TObject);
begin
  FPreview.OutlineVisible := OutlineB.Down;
end;

procedure TfrxPreviewForm.ThumbBClick(Sender: TObject);
begin
  FPreview.ThumbnailVisible := ThumbB.Down;
end;

procedure TfrxPreviewForm.OnPreviewDblClick(Sender: TObject);
begin
  if FFullScreen then
    SwitchToFullScreen;
end;

procedure TfrxPreviewForm.OnSaveFilterExecute(Sender: TObject);
var
  Filter: TfrxCustomIOTransport;
begin
  Filter := TfrxCustomIOTransport(FFilterList.Objects[TComponent(Sender).Tag]).CreateFilterClone(fvPreview);
  try
    Filter.FilterString := frxResources.Get('clFP3files') + ' (*.fp3)|*.fp3';
    Filter.DefaultExt := '.fp3';
    Preview.PreviewPages.SaveToFilter(Filter,'');
  finally
    TfrxCustomIOTransport(FFilterList.Objects[TComponent(Sender).Tag]).AssignSharedProperties(Filter);
    Filter.Free;
  end;
end;

procedure TfrxPreviewForm.CollapseAllClick(Sender: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
  bNeedRefresh: Boolean;
begin
  bNeedRefresh := False;
  FPreview.Lock;
  try
    l := Report.AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      begin
        TfrxGroupHeader(c).ExpandDrillDown := False;
        bNeedRefresh := True;
      end;
    end;
    if bNeedRefresh then
    begin
      Report.DrillState.Clear;
      Preview.RefreshReport;
      Preview.SetPosition(0,0);
    end;
  finally
    FPreview.Unlock(bNeedRefresh);
  end;
end;

procedure TfrxPreviewForm.ExpandAllClick(Sender: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
  bNeedRefresh: Boolean;
begin
  FPreview.Lock;
  bNeedRefresh := False;
  try
    l := Report.AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      begin
        TfrxGroupHeader(c).ExpandDrillDown := True;
        bNeedRefresh := True;
      end;
    end;
    if bNeedRefresh then
    begin
      Report.DrillState.Clear;
      Preview.RefreshReport;
    end;
  finally
    FPreview.Unlock(bNeedRefresh);
  end;
end;

procedure TfrxPreviewForm.FormResize(Sender: TObject);
const
  RightOffset: Integer = 20;
var
  Sz: Integer;
begin
  if (ClientHeight = 0) or (ClientWidth = 0) then
    begin
      ClientHeight := 583;
      ClientWidth := 803;
    end;
  Sz := Round((Self.ClientWidth  -   StatusBar.Panels[0].Width)/2);
  StatusBar.Panels[1].Width := Sz;
  StatusBar.Panels[2].Width := Sz;
  SepStyle.Width := ToolBar.Width - StylePan.Width - SepStyle.Left - RightOffset;
{$IFDEF FPC}
  StylePan.Left := SepStyle.Left + SepStyle.Width  + 2;
{$ENDIF}
end;

{ TfrxPreviewTabs }

constructor TfrxPreviewTabs.Create(APreview: TfrxPreview);
begin
  FPreview := APreview;
  FWorkspace := APreview.FWorkspace;
  FThumbnail := APreview.FThumbnail;
  FCurTab := 0;
  inherited Create(TfrxPreviewTabItem);
end;

procedure TfrxPreviewTabs.AddTab(AReport: TfrxReport;  aDetailPage: String; const TabName: String; AFreeObjects: Boolean);
begin
  with TfrxPreviewTabItem(Add) do
  begin
    Name := TabName;
    Top := 0;
    Left := 0;
    ThumbTop := 0;
    OutlineItem := 0;
    if FPreview.ZoomMode = zmDefault then
      Zoom := FPreview.Zoom
    else
      ZoomMode := FPreview.ZoomMode;
    Report := AReport;
    PreviewPages := AReport.PreviewPages;
    PageNo := 1;
    FreeObjects := AFreeObjects;
    if (aDetailPage <> '') and (FCurTab > -1) then
      FreeObjects := Items[FCurTab].FreeObjects;
    DetailPage := aDetailPage;
  end;
end;

procedure TfrxPreviewTabs.DeleteTab(Index: Integer);
begin
  // do not free the tab's report if:
  // - in the first tab
  // - the tab's report is used in other tabs
  // - do not remove tab if FreeObjects is not set,  need when few report components connected to one preview
  FPreview.FCalledFromPreview := True;
  Items[Index].Report.Preview := nil;
  if Items[Index].FreeObjects and (Items[Index].Report.PreviewPagesList.Count = 1) then
  begin
    Items[Index].Report.Free;
    Items[Index].Report := nil;
  end
  else
    Items[Index].Report.PreviewPagesList.Delete(Items[Index].PreviewPages);
  FPreview.FCalledFromPreview := False;
  Delete(Index);
  FCurTab := Index - 1;
end;

procedure TfrxPreviewTabs.ClearItems;
begin
  // delete tabs except the first. It should be handled by the user.
  while Count > 1 do
    DeleteTab(1);
  FCurTab := 0;
end;

function TfrxPreviewTabs.GetItems(Index: Integer): TfrxPreviewTabItem;
begin
  Result := TfrxPreviewTabItem(inherited Items[Index]);
end;

procedure TfrxPreviewTabs.SetCurrentTab(Index: Integer);
begin
  if (Count = 0) or (Index >= Count) then Exit;

  if (FCurTab <> Index) and (FCurTab >= 0) then
    with Items[FCurTab] do
    begin
      if FPreview.ZoomMode = zmDefault then
        Zoom := FPreview.Zoom
      else
        ZoomMode := FPreview.ZoomMode;
      Left :=  FWorkspace.HorzPosition;
      Top := FWorkspace.VertPosition;
      PageNo := FPreview.FPageNo;
    end;
  FCurTab := Index;
  with Items[Index] do
  begin
     Report.PreviewPages := PreviewPages;
     FPreview.FCalledFromPreview := True;
     Report.Preview := FPreview;
     FPreview.FCalledFromPreview := False;
     FPreview.FPageNo := PageNo;
     if (PageNo = 0) and (PreviewPages.Count > 0) then
     begin
       FPreview.FPageNo := 1;
       FPreview.FWorkspace.FPageNo := 1;
     end;
     if ZoomMode = zmDefault then
       FPreview.Zoom := Zoom
     else
       FPreview.ZoomMode := ZoomMode;
     FPreview.FWorkspace.UpdateScrollBars;
     if Top > FWorkspace.VertRange - FWorkspace.VertPage then
        FWorkspace.VertRange := Top + FWorkspace.VertPage;
     FWorkspace.VertPosition := Top;
     FPreview.UpdateOutline;
  end;
end;

procedure TfrxPreviewForm.CopyCmdExecute(Sender: TObject);
begin
 FPreview.InternalCopy;
end;

constructor TfrxPreviewForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFilterList := TStringList.Create;
end;

procedure TfrxPreviewForm.CreateExportMenu;
var
  i, k: Integer;
  m, mi: TMenuItem;

  procedure CopyItems(mItems, mItemsTo: TMenuItem);
  var
    j: Integer;
    e: TMenuItem;
  begin
    if Assigned(mItems) then
      for j := 0 to mItems.Count - 1 do
      begin
        e := TMenuItem.Create(mItemsTo);
        e.Caption := mItems[j].Caption;
        e.Tag := mItems[j].Tag;
        e.OnClick := mItems[j].OnClick;
        mItemsTo.Add(e);
        CopyItems(mItems[j], e);
      end;
  end;

  procedure AddDelim;
  begin
    m := TMenuItem.Create(ExportPopup);
    ExportPopup.Items.Add(m);
    m.Caption := '-';
  end;

begin
  ExportPopup.Items.Clear;
  if pbSave in Report.PreviewOptions.Buttons then
  begin
    m := TMenuItem.Create(ExportPopup);
    ExportPopup.Items.Add(m);
    m.Caption := frxResources.Get('clFP3files') + '...';
    m.OnClick := SaveBClick;

    if FFilterList.Count > 1 then
      for i := 0 to FFilterList.Count - 1 do
      begin
        m.OnClick := nil;
        mi := TMenuItem.Create(m);
        mi.Caption := TfrxCustomIOTransport(FFilterList.Objects[i])
          .GetDescription;
        mi.Tag := i;
        mi.OnClick := OnSaveFilterExecute;
        m.Add(mi);
      end;

    if pbExport in Report.PreviewOptions.Buttons then
      AddDelim;
  end;

  for i := 0 to frxExportFilters.Count - 1 do
  begin
    if frxExportFilters[i].Filter = frxDotMatrixExport then
      continue;
    if pbExport in Report.PreviewOptions.Buttons then
      if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName <> 'TfrxMailExport' then
      begin
        m := TMenuItem.Create(ExportPopup);
        ExportPopup.Items.Add(m);
        m.Caption := TfrxCustomExportFilter(frxExportFilters[i].Filter).GetDescription + '...';
        m.Tag := i;
        m.OnClick := ExportMIClick;
      end;
    if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxPDFExport' then
    begin
      FPDFExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
      PdfB.Visible := pbExportQuick in Report.PreviewOptions.Buttons;
    end;
    if not (pbNoEmail in Report.PreviewOptions.Buttons) then
    begin
      if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxMailExport' then
      begin
        FEmailExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
        EmailB.Visible := pbExportQuick in Report.PreviewOptions.Buttons;
      end;
    end
    else EmailB.Visible := False;
  end;
  RightMenu.Images := ToolBar.Images;

  if (pbExport in Report.PreviewOptions.Buttons) then
  begin
    CopyItems(ExportPopup.Items, ExportAllTabsPopup.Items);
    if (pbSave in Report.PreviewOptions.Buttons) then
      for i := 0 to 1 do
        ExportAllTabsPopup.Items.Delete(0);
    for i := 0 to ExportAllTabsPopup.Items.Count - 1 do
      ExportAllTabsPopup.Items[i].OnClick := ExportMIACTClick;
  end;

  k := 0;

  for i := 0 to ToolBar.ButtonCount - 1 do
  begin
    if (ToolBar.Buttons[i].Style <> tbsCheck) and
       (ToolBar.Buttons[i].Visible) and
       (ToolBar.Buttons[i].Hint <> '') then
    begin
      if TObject(ToolBar.Buttons[i].Tag) is TMenuItem then
        m := TMenuItem(ToolBar.Buttons[i].Tag)
      else
      begin
        m := TMenuItem.Create(RightMenu);
        RightMenu.Items.Add(m);
      end;
      ToolBar.Buttons[i].Tag := frInteger(m);
      m.Caption := ToolBar.Buttons[i].Hint;
      m.OnClick := ToolBar.Buttons[i].OnClick;
      m.ImageIndex := ToolBar.Buttons[i].ImageIndex;
      if Assigned(ToolBar.Buttons[i].DropdownMenu) then
      begin
        m.Clear;
        CopyItems(ToolBar.Buttons[i].DropdownMenu.Items, m);
      end;
    end;
    if ToolBar.Buttons[i].Style = tbsSeparator then
    begin
      if k = 1 then
        break;
      m := TMenuItem.Create(RightMenu);
      RightMenu.Items.Add(m);
      m.Caption := '-';
      Inc(k);
    end;
  end;
end;

procedure TfrxPreviewForm.PasteCmdExecute(Sender: TObject);
begin
  if FPreview.InternalIsPasteAvailable then
    FPreview.InternalPaste;
end;

procedure TfrxPreviewForm.RightMenuPopup(Sender: TObject);
begin
  CopyCmd.Visible := (pbCopy in Report.PreviewOptions.Buttons) and Report.PreviewOptions.AllowPreviewEdit;
  PasteCmd.Visible := (pbPaste in Report.PreviewOptions.Buttons) and Report.PreviewOptions.AllowPreviewEdit;
  CopyCmd.Enabled := Assigned(FPreview.FSelectionList) and (FPreview.FSelectionList.Count > 0);
  PasteCmd.Enabled := CopyCmd.Enabled and FPreview.InternalIsPasteAvailable;
  CopyCmd.ShortCut := ShortCut(Ord('C'), [ssCtrl]);
  PasteCmd.ShortCut := ShortCut(Ord('V'), [ssCtrl]);
end;

end.
