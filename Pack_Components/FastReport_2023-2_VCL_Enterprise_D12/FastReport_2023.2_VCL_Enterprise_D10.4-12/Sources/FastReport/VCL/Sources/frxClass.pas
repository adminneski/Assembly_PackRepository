{******************************************}
{                                          }
{             FastReport VCL               }
{             Report classes               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

/// <summary>
///   Main FastReport unit. This unit contains base classes of report objects
///   and report class itself. To use FastReport components this unit should be
///   included in uses clause.
/// </summary>
unit frxClass;

interface

{$I frx.inc}
{$IFNDEF DELPHI16}
(*$HPPEMIT '#pragma link "Gdiplus.lib"'*)
{$ENDIF}

uses
{$IFNDEF FPC}
  Windows, Messages, WideStrings,
{$ELSE}
  LResources, LMessages, LCLType, LCLIntf, LazarusPackageIntf,
  LCLProc, FileUtil, LazHelper, frLazGraphicClasses, StdCtrls,
{$ENDIF}
  SysUtils, Types, Classes, Graphics, Controls, Forms, Dialogs,
  IniFiles, ExtCtrls, Printers, Math, frPictureCache,
  {$IFDEF DELPHI16}System.UITypes,{$ENDIF}
  {$IFNDEF NO_CRITICAL_SECTION} SyncObjs, {$ENDIF}
  frCore, frCoreClasses, frTypes, frXML,
  frBaseGraphicsTypes, frxVariables, frxProgress,
  fs_iinterpreter, frUnicodeUtils, Variants,
  frxVectorCanvas, frxBaseForm, frPictureGraphics, frxProtocolFactory, frGraphicUtils,
  frDPIAwareUtils;

const
  /// <summary>
  ///   Used to convert Pixels to millimeters.
  /// </summary>
  fr01cm: Extended = 3.77953;
  /// <summary>
  ///   Used to convert Pixels to centimeters.
  /// </summary>
  fr1cm: Extended = 37.7953;
  /// <summary>
  ///   Used to convert Pixels to 0.X inches.
  /// </summary>
  fr01in: Extended = 9.6;
  /// <summary>
  ///   Used to convert Pixels to inches.
  /// </summary>
  fr1in: Integer = 96;
  /// <summary>
  ///   Used to convert Pixels to char width(dot-matrix report).
  /// </summary>
  fr1CharX: Extended = 9.6;
  /// <summary>
  ///   Used to convert Pixels to char height(dot-matrix report).
  /// </summary>
  fr1CharY: Integer = 17;
  /// <summary>
  ///   Default transparent color value.
  /// </summary>
  clTransparent: TColor = clNone;
  /// <summary>
  ///   Cursor represents hand sign.
  /// </summary>
  crHand: Integer = 150;
  /// <summary>
  ///   Cursor represents zoom sign.
  /// </summary>
  crZoom: Integer = 151;
  /// <summary>
  ///   Cursor represents format sign.
  /// </summary>
  crFormat: Integer = 152;
  DEF_REG_CONNECTIONS: String = '\Software\Fast Reports\Connections';
  /// <summary>
  ///   Internal message. Sends to window controls during creation to
  ///   synchronize creation of window control with main GDI thread.
  /// </summary>
  WM_CREATEHANDLE = WM_USER + 1;
  /// <summary>
  ///   Internal message. Sends to window controls during destroy to
  ///   synchronize destroying of window control with main GDI thread.
  /// </summary>
  WM_DESTROYHANDLE = WM_USER + 2;
  /// <summary>
  ///   Internal message. Used for synchronization between report component and
  ///   Engine ShiftTree item. Sends when component destroying.
  /// </summary>
  FRX_OWNER_DESTROY_MESSAGE = $D001;
  /// <summary>
  ///   Represents default pixel per inch value.
  /// </summary>
  frx_DefaultPPI = FR_DefaultPPI;

type
  {$IFDEF NONWINFPC}

  { TfrxStringList }

  TfrxStringList = class(TStringList)
  protected
    function DoCompareText(const s1,s2 : string) : PtrInt; override;
  end;

  {$ENDIF}

  TfrxReport = class;
  TfrxPage = class;
  TfrxReportPage = class;
  TfrxDialogPage = class;
  TfrxCustomEngine = class;
  TfrxCustomDesigner = class;
  TfrxCustomPreview = class;
  TfrxCustomPreviewPages = class;
  TfrxComponent = class;
  TfrxReportComponent = class;
  TfrxView = class;
  TfrxCustomStyleItem = class;
  TfrxCustomExportFilter = class;
  TfrxCustomCompressor = class;
  TfrxCustomDatabase = class;
  TfrxFrame = class;
  TfrxDataSet = class;
  TfrxHyperlink = class;
  TfrxInPlaceEditor = class;
  TfrxCustomIOTransport = class;
  TfrxComponentEditorsList = class;
  TfrxComponentEditorsManager = class;
  TfrxPostProcessor = class;
  TfrxObjectProcessing = class;
  TfrxMacrosItem = class;
  TfrxSelectedObjectsList = class;
  TfrxDelayedCommandManager = class;

  TfrxNotifyEvent = type String;
  TfrxCloseQueryEvent = type String;
  TfrxKeyEvent = type String;
  TfrxKeyPressEvent = type String;
  TfrxMouseEvent = type String;
  TfrxMouseEnterViewEvent = type String;
  TfrxMouseLeaveViewEvent = type String;
  TfrxMouseMoveEvent = type String;
  TfrxPreviewClickEvent = type String;
  TfrxRunDialogsEvent = type String;
  TfrxContentChangedEvent = type String;

  TfrxStyleName = type String;

  /// <summary>
  ///   Duplicate name exception class.
  /// </summary>
  EDuplicateName = class(Exception);
  /// <summary>
  ///   Export termination exception class.
  /// </summary>
  EExportTerminated = class(TObject);
  EReportScriptError = class(Exception);

  SYSINT = Integer;

  // TODO
  // remove unnecesary later
  // csContainer is legacy and used only with current crossTab for back compatibility
  // csObjectsContainer new flag which used in default Copy/Paste buffer for containers like Table
  // csContained means that object of this class only can be used inside other View object
  // csAcceptsFrxComponents used when view can accept other components as childs

  /// <summary>
  ///   Represent scrollbar orientation.
  /// </summary>
  TfrxScrollerOrientation = (
    /// <summary>
    ///   Horizontal.
    /// </summary>
    frsHorizontal,
    /// <summary>
    ///   Vertical.
    /// </summary>
    frsVertical);

  TfrxComponentState = set of (csFrxDesigning, csFrxWriting, csFrxSerializeToDict, csFrxSerializeToPreviewPages, csFrxModifyObject, csFrxExporting, csFrxInteractiveForms);

  /// <summary>
  ///   Styles on report component.
  /// </summary>
  TfrxComponentStyle = set of (
    /// <summary>
    ///   Deprecated. used only for cross tabs object. Use csObjectsContainer
    ///   instead.
    /// </summary>
    csContainer,
    /// <summary>
    ///   Report component visible in the report preview(prepared report).
    /// </summary>
    csPreviewVisible,
    /// <summary>
    ///   Use default RTTI serialization when object saves to prepared
    ///   report(Default serialization to prepared report).
    /// </summary>
    csDefaultDiff,
    /// <summary>
    ///   Determinates how to serialize internal non published composite
    ///   objects. When flag is set composite object saves as new XML node.
    /// </summary>
    csHandlesNestedProperties,
    /// <summary>
    ///   Report component can be child of another parent report container.
    /// </summary>
    csContained,
    /// <summary>
    ///   Report component may contain another report component, i.e. can be as
    ///   parent container for others.
    /// </summary>
    csAcceptsFrxComponents,
    /// <summary>
    ///   Report component is a object container. Flag used in default
    ///   Copy/Paste buffer for containers like Table.
    /// </summary>
    csObjectsContainer);
  /// <summary>
  ///   Stretch mode of the text objects.
  /// </summary>
  TfrxStretchMode = (
    /// <summary>
    ///   Stretch the object so all text would fit.
    /// </summary>
    smDontStretch,
    /// <summary>
    ///   Don't stretch the object.
    /// </summary>
    smActualHeight,
    /// <summary>
    ///   Stretch the object to the max height of the parent band.
    /// </summary>
    smMaxHeight,
    /// <summary>
    ///   Stretch the object to the max height of each part of the split band.
    /// </summary>
    smPartMaxHeight);
  /// <summary>
  ///   Shift mode of the object. Behaviour depends on what type of
  ///   TfrxShiftEngine selected in parent container.
  /// </summary>
  TfrxShiftMode = (
    /// <summary>
    ///   Don't shift the object.
    /// </summary>
    smDontShift,
    /// <summary>
    ///   Shift the object if the above objects are stretching(for seLinear
    ///   shifts even if there is no overlying objects). <br />
    /// </summary>
    smAlways,
    /// <summary>
    ///   Shift the object if it is overlapped by the above objects(for
    ///   seLinear consider vertical space between objects).
    /// </summary>
    smWhenOverlapped);
  /// <summary>
  ///   Determine how container shifts its child object.
  /// </summary>
  TfrxShiftEngine = (
    /// <summary>
    ///   Linear shift mechanism used.
    /// </summary>
    seLinear,
    /// <summary>
    ///   Tree shift mechanism used. Default.
    /// </summary>
    seTree,
    /// <summary>
    ///   Shift mechanism disabled. May increase speed.
    /// </summary>
    seDontShift);
  /// <summary>
  ///   Mode of the duplex printing.
  /// </summary>
  TfrxDuplexMode = (dmNone, dmVertical, dmHorizontal, dmSimplex);

  /// <summary>
  ///   The alignment of the object relative to its parent.
  /// </summary>
  TfrxAlign = (
    /// <summary>
    ///   No align.
    /// </summary>
    baNone,
    /// <summary>
    ///   Aligned to left.
    /// </summary>
    baLeft,
    /// <summary>
    ///   Aligned to right. <br />
    /// </summary>
    baRight,
    /// <summary>
    ///   Aligned to center. <br />
    /// </summary>
    baCenter,
    /// <summary>
    ///   Aligned to width of parent container. <br />
    /// </summary>
    baWidth,
    /// <summary>
    ///   Aligned to bottom. <br />
    /// </summary>
    baBottom,
    /// <summary>
    ///   Aligned to parent sizes. <br />
    /// </summary>
    baClient,
    /// <summary>
    ///   Objects ignored(invisible) in align mechanism.
    /// </summary>
    baHidden);

  /// <summary>
  ///   Style of the frame line.
  /// </summary>
  TfrxFrameStyle = (
    /// <summary>
    ///   Solid line.
    /// </summary>
    fsSolid,
    /// <summary>
    ///   Dash style.
    /// </summary>
    fsDash,
    /// <summary>
    ///   Dot style.
    /// </summary>
    fsDot,
    /// <summary>
    ///   Dash dot style.
    /// </summary>
    fsDashDot,
    /// <summary>
    ///   Dash dot dot style.
    /// </summary>
    fsDashDotDot,
    /// <summary>
    ///   Double line style.
    /// </summary>
    fsDouble,
    /// <summary>
    ///   Alternative dots style.
    /// </summary>
    fsAltDot,
    /// <summary>
    ///   Squares instead of dots.
    /// </summary>
    fsSquare);

  /// <summary>
  ///   Type of the frame line.
  /// </summary>
  TfrxFrameType = (
    /// <summary>
    ///   Left frame. <br />
    /// </summary>
    ftLeft,
    /// <summary>
    ///   Right frame. <br />
    /// </summary>
    ftRight,
    /// <summary>
    ///   Top frame. <br />
    /// </summary>
    ftTop,
    /// <summary>
    ///   Bottom frame.
    /// </summary>
    ftBottom);
  /// <summary>
  ///   Type of the frame line.
  /// </summary>
  TfrxFrameTypes = set of TfrxFrameType;

  /// <summary>
  ///   Visibility of object in the result report.
  /// </summary>
  TfrxVisibilityType  = (
    /// <summary>
    ///   Objects visible for preview.
    /// </summary>
    vsPreview,
    /// <summary>
    ///   Objects visible for exports.
    /// </summary>
    vsExport,
    /// <summary>
    ///   Objects visible for printing.
    /// </summary>
    vsPrint);
  /// <summary>
  ///   Visibility of object in the result report.
  /// </summary>
  TfrxVisibilityTypes = set of TfrxVisibilityType;

  /// <summary>
  ///   Reserved for future use.
  /// </summary>
  TfrxPrintOnType  = (ptFirstPage, ptLastPage, ptOddPages, ptEvenPages, ptRepeatedBand);
  TfrxPrintOnTypes = set of TfrxPrintOnType;

  /// <summary>
  ///   Kind of the formatting.
  /// </summary>
  TfrxFormatKind = (
    /// <summary>
    ///   Text format.
    /// </summary>
    fkText,
    /// <summary>
    ///   <para>
    ///     Numeric format.
    ///   </para>
    ///   <para>
    ///     %g - a number with the minimal signs number after decimal point; <br />
    ///     %2.2f - a number with the fixed number of signs after decimal
    ///     point; <br />%2.2n - a number with bits delimiter; <br />%2.2m -
    ///     a monetary format, accepted in the Windows OS, depending on the
    ///     regional settings in the control panel.
    ///   </para>
    /// </summary>
    fkNumeric,
    /// <summary>
    ///   <para>
    ///     Date time format.
    ///   </para>
    ///   <para>
    ///     dd.mm.yyyy - date of the 23.12.2003 type; <br />dd mmm yyyy -
    ///     dateof the 23 Nov. 2003 type; <br />dd mmmm yyyy - date of the 23
    ///     November 2003 type; <br />hh:mm - time of the 23:12 type; <br />
    ///     hh:mm:ss - time of the 23:12:00 type; <br />dd mmmm yyyy, hh:mm
    ///     -time and date of the 23 November 2003, 23:12 type
    ///   </para>
    /// </summary>
    fkDateTime,
    /// <summary>
    ///   Boolean format.
    /// </summary>
    fkBoolean);

  /// <summary>
  ///   The horizontal alignment of the text in the "Text" object.
  /// </summary>
  TfrxHAlign = (haLeft, haRight, haCenter, haBlock);
  /// <summary>
  ///   The vertical alignment of the text in the "Text" object.
  /// </summary>
  TfrxVAlign = (vaTop, vaBottom, vaCenter);

  TfrxSilentMode = (simMessageBoxes, simSilent, simReThrow);
  /// <summary>
  ///   Flags, used to restrict some object operations in the designer.
  /// </summary>
  TfrxRestriction = (rfDontModify, rfDontSize, rfDontMove, rfDontDelete, rfDontEdit, rfDontEditInPreview, rfDontCopy);
  /// <summary>
  ///   Set of flags, which restrict some object operations in the designer.
  /// </summary>
  TfrxRestrictions = set of TfrxRestriction;
    /// <summary>
  ///   Flags, used to allow some edit object operations in the preview and export.
  /// </summary>
  TfrxEditableRight = (ferAllowInPreview, ferAllowInExport);
   /// <summary>
  ///   Set of flags, which used to allow some edit object operations in the preview and export.
  /// </summary>
  TfrxEditableRights = set of TfrxEditableRight;

  /// <summary>
  ///   Kind of shape.
  /// </summary>
  TfrxShapeKind = (
    /// <summary>
    ///   Rectangle.
    /// </summary>
    skRectangle,
    /// <summary>
    ///   Rectangle with round corners.
    /// </summary>
    skRoundRectangle,
    /// <summary>
    ///   Ellipse.
    /// </summary>
    skEllipse,
    /// <summary>
    ///   Triangle.
    /// </summary>
    skTriangle,
    /// <summary>
    ///   Diamond.
    /// </summary>
    skDiamond,
    /// <summary>
    ///   Diagonal line from bottom left to top right.
    /// </summary>
    skDiagonal1,
    /// <summary>
    ///   Diagonal line from top left to bottom right. <br />
    /// </summary>
    skDiagonal2);

  /// <summary>
  ///   Buttons that can be displayed in the preview window.
  /// </summary>
  TfrxPreviewButton = (
    /// <summary>
    ///   Print button.
    /// </summary>
    pbPrint,
    /// <summary>
    ///   Load.
    /// </summary>
    pbLoad,
    /// <summary>
    ///   Save button.
    /// </summary>
    pbSave,
    /// <summary>
    ///   Export button.
    /// </summary>
    pbExport,
    /// <summary>
    ///   Zoom buttons.
    /// </summary>
    pbZoom,
    /// <summary>
    ///   Find.
    /// </summary>
    pbFind,
    /// <summary>
    ///   Outline button.
    /// </summary>
    pbOutline,
    /// <summary>
    ///   Page setup button.
    /// </summary>
    pbPageSetup,
    /// <summary>
    ///   Deprecated. Not used.
    /// </summary>
    pbTools,
    /// <summary>
    ///   Edit button. Calls report designer for preview page.
    /// </summary>
    pbEdit,
    /// <summary>
    ///   Page navigator.
    /// </summary>
    pbNavigator,
    /// <summary>
    ///   Quick export button.
    /// </summary>
    pbExportQuick,
    /// <summary>
    ///   Disables close button.
    /// </summary>
    pbNoClose,
    /// <summary>
    ///   Disables full screen mode.
    /// </summary>
    pbNoFullScreen,
    /// <summary>
    ///   Disables e-mail export button.
    /// </summary>
    pbNoEmail,
    /// <summary>
    ///   Copy in context menu.
    /// </summary>
    pbCopy,
    /// <summary>
    ///   Paste in context menu.
    /// </summary>
    pbPaste,
    /// <summary>
    ///   Enables selection in the report preview (Shift + left mouse button).
    /// </summary>
    pbSelection,
    /// <summary>
    ///   Allows InPlace editor in the report preview. Enables "Highlight
    ///   editable text" button.
    /// </summary>
    pbInplaceEdit);
  /// <summary>
  ///   Set of buttons that can be displayed in the preview window.
  /// </summary>
  TfrxPreviewButtons = set of TfrxPreviewButton;
  /// <summary>
  ///   Zoom mode of the preview window.
  /// </summary>
  TfrxZoomMode = (
    /// <summary>
    ///   Default mode.
    /// </summary>
    zmDefault,
    /// <summary>
    ///   Fit whole page.
    /// </summary>
    zmWholePage,
    /// <summary>
    ///   Fit page by its width.
    /// </summary>
    zmPageWidth,
    /// <summary>
    ///   Fit several pages.
    /// </summary>
    zmManyPages);
  /// <summary>
  ///   Pages to print.
  /// </summary>
  TfrxPrintPages = (
    /// <summary>
    ///   All pages.
    /// </summary>
    ppAll,
    /// <summary>
    ///   Only odd pages.
    /// </summary>
    ppOdd,
    /// <summary>
    ///   Only even pages.
    /// </summary>
    ppEven);
  /// <summary>
  ///   Sets behaviour of TfrxPreviewPages.AddPage method. <br />
  /// </summary>
  TfrxAddPageAction = (
    /// <summary>
    ///   Write over current page if it isn't last page.
    /// </summary>
    apWriteOver,
    /// <summary>
    ///   Always add new page.
    /// </summary>
    apAdd);
  /// <summary>
  ///   The navigation start point.
  /// </summary>
  TfrxRangeBegin = (
    /// <summary>
    ///   From the current record.
    /// </summary>
    rbFirst,
    /// <summary>
    ///   From the beginning of the data.
    /// </summary>
    rbCurrent);
  /// <summary>
  ///   The endpoint of navigation.
  /// </summary>
  TfrxRangeEnd = (
    /// <summary>
    ///   Till the end of the data
    /// </summary>
    reLast,
    /// <summary>
    ///   Till the current record
    /// </summary>
    reCurrent,
    /// <summary>
    ///   By the number of records set in the "RangeEndCount" property.
    /// </summary>
    reCount);
  /// <summary>
  ///   Field type.
  /// </summary>
  TfrxFieldType = (
    /// <summary>
    ///   Numeric.
    /// </summary>
    fftNumeric,
    /// <summary>
    ///   Text.
    /// </summary>
    fftString,
    /// <summary>
    ///   Boolean.
    /// </summary>
    fftBoolean,
    /// <summary>
    ///   Data time.
    /// </summary>
    fftDateTime);
  /// <summary>
  ///   The kind of action in the OnProgressXXX event: run a report, export,
  ///   print.
  /// </summary>
  TfrxProgressType = (
    /// <summary>
    ///   Report preparing state.
    /// </summary>
    ptRunning,
    /// <summary>
    ///   Export state.
    /// </summary>
    ptExporting,
    /// <summary>
    ///   Printing state.
    /// </summary>
    ptPrinting);
  /// <summary>
  ///   The print mode.
  /// </summary>
  TfrxPrintMode = (
    /// <summary>
    ///   Default mode.
    /// </summary>
    pmDefault,
    /// <summary>
    ///   Split large page on several smaller pages.
    /// </summary>
    pmSplit,
    /// <summary>
    ///   Join several small pages on a large page.
    /// </summary>
    pmJoin,
    /// <summary>
    ///   Print a page on a specified paper size (use scaling).
    /// </summary>
    pmScale);
  /// <summary>
  ///   The inherit mode type.
  /// </summary>
  TfrxInheriteMode = (
    /// <summary>
    ///   Shows inherit dialog.
    /// </summary>
    imDefault,
    /// <summary>
    ///   Delete duplicates.
    /// </summary>
    imDelete,
    /// <summary>
    ///   Rename duplicates
    /// </summary>
    imRename);
  /// <summary>
  ///   Controls serialization state (Not used yet).
  /// </summary>
  TfrxSerializeState = (
    /// <summary>
    ///   Object serializes to a report template.
    /// </summary>
    ssTemplate,
    /// <summary>
    ///   Object serializes to a prepared report.
    /// </summary>
    ssPreviewPages);
  /// <summary>
  ///   Type of hyperlinks supported by report objects.
  /// </summary>
  TfrxHyperlinkKind = (
    /// <summary>
    ///   hyper link to HTTP.
    /// </summary>
    hkURL,
    /// <summary>
    ///   Anchor to position inside prepared report.
    /// </summary>
    hkAnchor,
    /// <summary>
    ///   Link to a page number in prepared report.
    /// </summary>
    hkPageNumber,
    /// <summary>
    ///   Link to detail report.
    /// </summary>
    hkDetailReport,
    /// <summary>
    ///   Reference to detail page.
    /// </summary>
    hkDetailPage,
    /// <summary>
    ///   Reserved.
    /// </summary>
    hkCustom,
    /// <summary>
    ///   Disabled.
    /// </summary>
    hkNone);

  /// <summary>
  ///   Fill types of report objects.
  /// </summary>
  TfrxFillType = (
    /// <summary>
    ///   Brush fill.
    /// </summary>
    ftBrush,
    /// <summary>
    ///   Gradient fill.
    /// </summary>
    ftGradient,
    /// <summary>
    ///   Glass fill.
    /// </summary>
    ftGlass);
  /// <summary>
  ///   Gradient fill styles.
  /// </summary>
  TfrxGradientStyle = (
    /// <summary>
    ///   Horizontal gradient.
    /// </summary>
    gsHorizontal,
    /// <summary>
    ///   Vertical gradient.
    /// </summary>
    gsVertical,
    /// <summary>
    ///   Elliptic gradient.
    /// </summary>
    gsElliptic,
    /// <summary>
    ///   Rectangle gradient.
    /// </summary>
    gsRectangle,
    /// <summary>
    ///   Vertical centered gradient.
    /// </summary>
    gsVertCenter,
    /// <summary>
    ///   Horizontal centered gradient.
    /// </summary>
    gsHorizCenter);
  { preview pages events }
  /// <summary>
  ///   Type of mouse interactive events supported by report objects.
  /// </summary>
  TfrxMouseIntEvents = (
    /// <summary>
    ///   Click on object.
    /// </summary>
    meClick,
    /// <summary>
    ///   Double click on object.
    /// </summary>
    meDbClick,
    /// <summary>
    ///   Mouse moved over object.
    /// </summary>
    meMouseMove,
    /// <summary>
    ///   Mouse up.
    /// </summary>
    meMouseUp,
    /// <summary>
    ///   Mouse down.
    /// </summary>
    meMouseDown,
    /// <summary>
    ///   Drag something over on object.
    /// </summary>
    meDragOver,
    /// <summary>
    ///   Drop something on object.
    /// </summary>
    meDragDrop,
    /// <summary>
    ///   Mouse wheel event.
    /// </summary>
    meMouseWheel);
  /// <summary>
  ///   Type of the report designer tools.
  /// </summary>
  TfrxDesignTool = (
    /// <summary>
    ///   Selection.
    /// </summary>
    dtSelect,
    /// <summary>
    ///   Move hand.
    /// </summary>
    dtHand,
    /// <summary>
    ///   Zoom.
    /// </summary>
    dtZoom,
    /// <summary>
    ///   InPlace text editor.
    /// </summary>
    dtText,
    /// <summary>
    ///   Format copy tool.
    /// </summary>
    dtFormat,
    /// <summary>
    ///   Editor.
    /// </summary>
    dtEditor);
  /// <summary>
  ///   Access type of IO filters.
  /// </summary>
  TfrxFilterAccess = (
    /// <summary>
    ///   Read only.
    /// </summary>
    faRead,
    /// <summary>
    ///   Write.
    /// </summary>
    faWrite);

  /// <summary>
  ///   Flags which is controlling duplicated behaviour.
  /// </summary>
  TfrxDuplicateMerge = (
    /// <summary>
    ///   Show all duplicates. Default.
    /// </summary>
    dmShow,
    /// <summary>
    ///   Hide objects with duplicated values.
    /// </summary>
    dmHide,
    /// <summary>
    ///   Clear all duplicated values.
    /// </summary>
    dmClear,
    /// <summary>
    ///   Merge all duplicated objects to one.
    /// </summary>
    dmMerge);

  /// <summary>
  ///   Controls when to process expression calculation(for some TfrxView
  ///   objects).
  /// </summary>
  TfrxProcessAtMode = (
    /// <summary>
    ///   By Default. When engine processes object.
    /// </summary>
    paDefault,
    /// <summary>
    ///   Processes when report finished. <br />
    /// </summary>
    paReportFinished,
    /// <summary>
    ///   Processes when report page finished. <br />
    /// </summary>
    paReportPageFinished,
    /// <summary>
    ///   Processes when page finished. <br />
    /// </summary>
    paPageFinished,
    /// <summary>
    ///   Processes when column finished.
    /// </summary>
    paColumnFinished,
    /// <summary>
    ///   Processes when data finished. <br />
    /// </summary>
    paDataFinished,
    /// <summary>
    ///   Processes when group finished. <br />
    /// </summary>
    paGroupFinished,
    /// <summary>
    ///   Processes by user from script code.
    /// </summary>
    paCustom);
  /// <summary>
  ///   Grid type in the report designer.
  /// </summary>
  TfrxGridType = (gt1pt, gt1cm, gt1in, gtDialog, gtChar, gtNone);
  /// <summary>
  ///   Copy paste format for inPlace editors.
  /// </summary>
  TfrxCopyPasteType = (
    /// <summary>
    ///   Default.
    /// </summary>
    cptDefault,
    /// <summary>
    ///   Text.
    /// </summary>
    cptText,
    /// <summary>
    ///   Image.
    /// </summary>
    cptImage,
    /// <summary>
    ///   Native control format.
    /// </summary>
    cptNative);

  /// <summary>
  ///   Object anchors type.
  /// </summary>
  TfrxAnchorsKind = (
    /// <summary>
    ///   Left.
    /// </summary>
    fraLeft,
    /// <summary>
    ///   Top.
    /// </summary>
    fraTop,
    /// <summary>
    ///   Right.
    /// </summary>
    fraRight,
    /// <summary>
    ///   Bottom.
    /// </summary>
    fraBottom);
  /// <summary>
  ///   Set of object anchors.
  /// </summary>
  TfrxAnchors = set of TfrxAnchorsKind;

  /// <summary>
  ///   Underlines text mode for "Text" object.
  /// </summary>
  TfrxUnderlinesTextMode = (
    /// <summary>
    ///   Disabled.
    /// </summary>
    ulmNone,
    /// <summary>
    ///   Underline whole object.
    /// </summary>
    ulmUnderlinesAll,
    /// <summary>
    ///   Underline only lines with text.
    /// </summary>
    ulmUnderlinesText,
    /// <summary>
    ///   Underline text lines and empty lines.
    /// </summary>
    ulmUnderlinesTextAndEmptyLines);

  /// <summary>
  ///   Mirror mode. Determinate how engine align controls and content base on
  ///   original layout.
  /// </summary>
  TfrxMirrorControlMode = (
    /// <summary>
    ///   Mirror bands positions(page columns) from right to left.
    /// </summary>
    mcmRTLBands,
    /// <summary>
    ///   Mirror objects positions from right to left.
    /// </summary>
    mcmRTLObjects,
    /// <summary>
    ///   Mirror appearance from right to left.
    /// </summary>
    mcmRTLAppearance,
    /// <summary>
    ///   Mirror content of objects from right to left.
    /// </summary>
    mcmRTLContent,
    /// <summary>
    ///   Sets RTLReading flag of "Text" object.
    /// </summary>
    mcmRTLSpecial,
    /// <summary>
    ///   Mirror bands positions from Top to Bottom.
    /// </summary>
    mcmBTTBands,
    /// <summary>
    ///   Mirror objects positions from Top to Bottom.
    /// </summary>
    mcmBTTObjects,
    /// <summary>
    ///   Mirror appearance from Top to Bottom.
    /// </summary>
    mcmBTTAppearance,
    /// <summary>
    ///   Mirror content of objects from Top to Bottom.
    /// </summary>
    mcmBTTContent,
    /// <summary>
    ///   Reserved.
    /// </summary>
    mcmBTTSpecial,
    /// <summary>
    ///   Apply mirror mode setting only for objects which have AllowMirrorMode
    ///   property set to true.
    /// </summary>
    mcmOnlyAllowed);
  /// <summary>
  ///   Set of mirror modes.
  /// </summary>
  TfrxMirrorControlModes = set of TfrxMirrorControlMode;

  /// <summary>
  ///   A set of flags, which inhibit specific operations in the designer.
  /// </summary>
  TfrxDesignerRestriction =
    (
    /// <summary>
    ///   Forbids insertion of objects.
    /// </summary>
    drDontInsertObject,
    /// <summary>
    ///   Forbids deletion of pages.
    /// </summary>
    drDontDeletePage,
    /// <summary>
    ///   Forbids creation of new pages.
    /// </summary>
    drDontCreatePage,
    /// <summary>
    ///   Forbids modifying page's properties.
    /// </summary>
    drDontChangePageOptions,
     /// <summary>
     ///   Forbids creation of a new report.
     /// </summary>
     drDontCreateReport,
    /// <summary>
    ///   Forbids report's loading.
    /// </summary>
    drDontLoadReport,
    /// <summary>
    ///   Forbids report's saving.
    /// </summary>
    drDontSaveReport,
     /// <summary>
     ///   Forbids report's preview.
     /// </summary>
     drDontPreviewReport,
    /// <summary>
    ///   Forbids editing of variables.
    /// </summary>
    drDontEditVariables,
    /// <summary>
    ///   Forbids modifying the report's properties.
    /// </summary>
    drDontChangeReportOptions,
     /// <summary>
     ///   Forbids Report|Data... menu.
     /// </summary>
     drDontEditReportData,
    /// <summary>
    ///   Forbids display of recent file list.
    /// </summary>
    drDontShowRecentFiles,
    /// <summary>
    ///   Forbids changes in report script.
    /// </summary>
    drDontEditReportScript,
    /// <summary>
    ///   Forbids changes in internal DataSets(DataPage).
    /// </summary>
    drDontEditInternalDatasets);

  TfrxShowDialogOption =
    (
    /// <summary>
    ///   Export.ShowExportSettings
    /// </summary>
    doShowExportSettings,
    /// <summary>
    ///   Export.ShowSaveDialog
    /// </summary>
    doShowSaveDialog);

  TfrxShowDialogOptions = set of TfrxShowDialogOption;

  //TODO: make enum rect, it should reduce size
  /// <summary>
  ///   Used to pass parameters from preview workspace to preview pages. Stores
  ///   addition information event.
  /// </summary>
  TfrxPreviewIntEventParams = packed record
    /// <summary>
    ///   Interactive event type.
    /// </summary>
    MouseEventType: TfrxMouseIntEvents;
    /// <summary>
    ///   Reference to Sender (Preview control).
    /// </summary>
    Sender: TObject;
    /// <summary>
    ///   Current cursor. PreviewPages, Editors, or report objects may change
    ///   it.
    /// </summary>
    Cursor: TCursor;
    /// <summary>
    ///   Selected tool. Preview supports only dtHand and dtEditor.
    /// </summary>
    EditMode: TfrxDesignTool;
    // DragDrop
    /// <summary>
    ///   State of Drag and Drop event if it was generated.
    /// </summary>
    State: TDragState;
    /// <summary>
    ///   Return parameter for drag and drop event. If True, drag and drop
    ///   accepts.
    /// </summary>
    Accept: Boolean;
    // Mouse Wheel
    /// <summary>
    ///   Mouse wheel delta for mouse wheel events.
    /// </summary>
    WheelDelta: Integer;
    /// <summary>
    ///   Mouse position for mouse wheel events.
    /// </summary>
    MousePos: TPoint;
    /// <summary>
    ///   Return value. If True, event processed by preview pages, otherwise
    ///   default preview behaviour will execute.
    /// </summary>
    RetResult: Boolean;
  end;

  /// <summary>
  ///   Rect with float values.
  /// </summary>
  TfrxRect = TfrRectF;

  /// <summary>
  ///   float point.
  /// </summary>
  TfrxPoint = TfrPointF;

  /// <summary>
  ///   Used with FRX_OWNER_DESTROY_MESSAGE.
  /// </summary>
  TfrxDispatchMessage = record
    MsgID: Word;
    Sender: TObject;
  end;

  /// <summary>
  ///   Class uses in DragDrop events. It helps to determinate when object
  ///   event was called from another object editor. Check
  ///   TfrxInPlaceBandEditor.DoCustomDragDrop.
  /// </summary>
  TfrxEventObject = class(TObject)
  public
    Sender: TObject;
    Index: NativeInt;
  end;

  /// <summary>
  ///   Type of interactive event sender.
  /// </summary>
  TfrxInteractiveEventSender = (
    /// <summary>
    ///   The report designer.
    /// </summary>
    esDesigner,
    /// <summary>
    ///   The report preview.
    /// </summary>
    esPreview);
  /// <summary>
  ///   Used in InPlace editors. Event fires when the report designer or the
  ///   report preview close InPlace editor.
  /// </summary>
  TfrxOnFinishInPlaceEdit = procedure(Sender: TObject; Refresh, Modified: Boolean) of object;

  { remove unnecessary fields later }
  TfrxInteractiveEventsParams = packed record
    Sender: TObject;
    Refresh, Modified: Boolean;
    FireParentEvent: Boolean;
    EventSender: TfrxInteractiveEventSender;
    OnFinish: TfrxOnFinishInPlaceEdit;
    EditMode: TfrxDesignTool;
    PopupVisible: Boolean;
    EditRestricted: Boolean;
    { lets the object decide what editor to chose, not designer }
    EditorsList: TfrxComponentEditorsList;
    SelectionList: TfrxSelectedObjectsList;
    OffsetX: Extended;
    OffsetY: Extended;
    Scale: Extended;
    DevicePPI: Integer;
    GridAlign: Boolean;
    GridType: TfrxGridType;
    GridX: Extended;
    GridY: Extended;
  end;

  /// <summary>
  ///   This event fires when engine loads report XML file and file contains
  ///   XML item &lt;FrxCustomData&gt;(i.e. store user data inside XML file).
  ///   All child nodes in this item ignores by <br />serializer. XMLItem
  ///   contains all the custom user data. <br />
  /// </summary>
  TfrxGetCustomDataEvent = procedure(XMLItem: TfrXMLItem) of object;
  /// <summary>
  ///   This event fires when serializer saves report template to XML(i.e.
  ///   store user data inside XML file). If event is set, serializer creates
  ///   &lt;FrxCustomData&gt; node and pass it as a parameter. Programmer may
  ///   use this node to create child nodes with custom data.
  /// </summary>
  TfrxSaveCustomDataEvent = procedure(XMLItem: TfrXMLItem) of object;
  /// <summary>
  ///   This event is fired when performing some continues operation (print,
  ///   export, run report). The event handler may display a dialog window with
  ///   progress bar. Progress parameter is the page number which is currently
  ///   being processed.
  /// </summary>
  TfrxProgressEvent = procedure(Sender: TfrxReport;
    ProgressType: TfrxProgressType; Progress: Integer) of object;
  /// <summary>
  ///   This event is fired each time before printing an report's object.
  /// </summary>
  TfrxBeforePrintEvent = procedure(Sender: TfrxReportComponent) of object;
  /// <summary>
  ///   This event is fired when an unknown variable (VarName) is met. An event
  ///   handler must return the value of this variable in the Value parameter.
  /// </summary>
  TfrxGetValueEvent = procedure(const VarName: String; var Value: Variant) of object;
  /// <summary>
  ///   This event is fired when an unknown variable (VarName) is met. An event
  ///   handler must return the value of this variable in the Value parameter.
  ///   New event has a Sender parameter and pass a report objects which calls
  ///   an event.
  /// </summary>
  TfrxNewGetValueEvent = procedure(Sender: TObject; const VarName: String; var Value: Variant) of object;
  /// <summary>
  ///   This event is fired when an unknown variable (VarName) is met and
  ///   IsBlobField event returns True(BLOB type). AssignTo parameter contains
  ///   an object in which data should be <br />loaded (TWideStrings for "Text"
  ///   object). <br />
  /// </summary>
  TfrxGetBlobValueEvent = procedure(Sender: TObject; const FileldName: String; AssignTo: TObject) of object;
  /// <summary>
  ///   An event fires when engine checks type of an assigned field. The result
  ///   tells report engine how to interpret the field with name 'FileldName'.
  ///   Returns True if it's a BLOB field. In this case OnGetBlobValue event
  ///   will fire.
  /// </summary>
  TfrxIsBlobFieldEvent = function(Sender: TObject; const FileldName: String): Boolean of object;
  /// <summary>
  ///   This event is fired when calling a function (MethodName), added with
  ///   the help of the TfrxReport.AddFunction method. The event handler should
  ///   return a value of the function.
  /// </summary>
  TfrxUserFunctionEvent = function(const MethodName: String;
    var Params: Variant): Variant of object;
  /// <summary>
  ///   If the handler of this event is allocated, then the FastReport engine
  ///   is blocked and you thus would have to construct a report manually.
  /// </summary>
  TfrxManualBuildEvent = procedure(Page: TfrxPage) of object;
  /// <summary>
  ///   Manual build of the report objects wich support it
  /// </summary>
  TfrxObjectManualBuildEvent = function(ReportObject: TfrxReportComponent): Boolean of object;
  /// <summary>
  ///   Occurs when report is previewed in the preview window and user click on
  ///   object.
  /// </summary>
  TfrxClickObjectEvent = procedure(Sender: TfrxView;
    Button: TMouseButton; Shift: TShiftState; var Modified: Boolean) of object;
  /// <summary>
  ///   Occurs when report is previewed in the preview window and user moves
  ///   the mouse over the object.
  /// </summary>
  TfrxMouseOverObjectEvent = procedure(Sender: TfrxView) of object;
  /// <summary>
  ///   Occurs when report is previewed in the preview window and mouse pointer
  ///   enters object rect area.
  /// </summary>
  TfrxMouseEnterEvent = procedure(Sender: TfrxView) of object;
  /// <summary>
  ///   Occurs when report is previewed in the preview window and mouse pointer
  ///   leaves object rect area.
  /// </summary>
  TfrxMouseLeaveEvent = procedure(Sender: TfrxView) of object;
  /// <summary>
  ///   This event's handler must return the Eof = True parameter, if the end
  ///   of the data set is reached.
  /// </summary>
  TfrxCheckEOFEvent = procedure(Sender: TObject; var Eof: Boolean) of object;
  /// <summary>
  ///   Occurs when report dialog page is previewed.
  /// </summary>
  TfrxRunDialogEvent = procedure(Page: TfrxDialogPage) of object;
  /// <summary>
  ///   Occurs when user edit connection in the report wizard.
  /// </summary>
  TfrxEditConnectionEvent = function(const ConnString: String): String of object;
  /// <summary>
  ///   Occurs when user set ConnectionNeme property. Internal use.
  /// </summary>
  TfrxSetConnectionEvent = procedure(const ConnString: String) of object;
  /// <summary>
  ///   Occurs when the report engine establish connection to database for
  ///   internal database components.
  /// </summary>
  TfrxBeforeConnectEvent = procedure(Sender: TfrxCustomDatabase; var Connected: Boolean) of object;
  /// <summary>
  ///   Occurs when the report engine close connection to database for internal
  ///   database components.
  /// </summary>
  TfrxAfterDisconnectEvent = procedure(Sender: TfrxCustomDatabase) of object;
  /// <summary>
  ///   Occurs when a report is an inherited report. The event handler must
  ///   load the report template (given by TemplateName parameter) into Report
  ///   object.
  /// </summary>
  TfrxPrintPageEvent = procedure(Page: TfrxReportPage; CopyNo: Integer) of object;
  /// <summary>
  ///   Occurs when a report is an inherited report. The event handler must
  ///   load the report template (given by TemplateName parameter) into Report
  ///   object.
  /// </summary>
  TfrxLoadTemplateEvent = procedure(Report: TfrxReport; const TemplateName: String) of object;
  /// <summary>
  ///   Occurs when a report object loads detail report. The event handler must
  ///   load the report template (given by TemplateName parameter) into Report
  ///   object with using parameters of AHyperlink. <br />
  /// </summary>
  TfrxLoadDetailTemplateEvent = function(Report :TfrxReport; const TemplateName :String; const AHyperlink :TfrxHyperlink): Boolean of object;
  /// <summary>
  ///   The event responsible for the sheet name generation template.
  /// </summary>
  TfrxGenerateSheetName = function(PageName: String; PageNumber: Integer): String of object;

{ Root classes }

  /// <summary>
  ///   List notification event.
  /// </summary>
  TfrxObjectsNotifyEvent = procedure(Ptr: Pointer; Action: TListNotification) of object;

  /// <summary>
  ///   Standard list with Notify event. Used as helper to detect added/deleted
  ///   objects.
  /// </summary>
  TfrxObjectsNotifyList = class(TList)
  private
    FOnNotifyList: TfrxObjectsNotifyEvent;
{$IFDEF DELPHI20}
    FDirection: TDirection;
{$ENDIF}
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    function Get(Index: TfrListInteger): Pointer; virtual;
    procedure Put(Index: TfrListInteger; const Value: Pointer); virtual;
    function GetCount: TfrListInteger; virtual;
  public
    property Count: TfrListInteger read GetCount;
{$IFDEF DELPHI20}
    property SearchDirection: TDirection read FDirection write FDirection;
{$ENDIF}
    /// <summary>
    ///   List notification event.
    /// </summary>
    property OnNotifyList: TfrxObjectsNotifyEvent read FOnNotifyList write FOnNotifyList;
    property Items[Index: TfrListInteger]: Pointer read Get write Put; default;
  end;

  TfrxObjectsNotifyListClass = class of TfrxObjectsNotifyList;

  TfrxDataLinkProcessing = (dpString, dpExpression);
  TfrxDataLinkLoadType = (dltOnGetData, dltOnPreview);
  TfrxDataLinkLoading = set of TfrxDataLinkLoadType;

  { Datalink helper class for fast implementation }
  TfrxDataLink = class(TPersistent)
  private
    FLink: String;
    FTempLink: String;
    FProcessingType: TfrxDataLinkProcessing;
    FLoadingType: TfrxDataLinkLoading;
    procedure SetLink(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Diff(const PropName: String; ADataLink: TfrxDataLink): String;
    class procedure SaveState(ADataLink: TfrxDataLink);
    class procedure RestoreState(ADataLink: TfrxDataLink);
    class function GetLoadType(LoadMethod: TfrxDataLinkLoadMethod): TfrxDataLinkLoadType;
    class function GetLink(ADatalink: TfrxDataLink; LoadMethod: TfrxDataLinkLoadMethod): String;
    class function IsExpressionLink(ADataLink: TfrxDataLink): Boolean;
    class function IsDataLinkStored(ADataLink: TfrxDataLink; ComponentState: TfrxComponentState): Boolean;
  published
    property Link: String read FLink write SetLink;
    property ProcessingType: TfrxDataLinkProcessing read FProcessingType write FProcessingType default dpString;
    property LoadingType: TfrxDataLinkLoading read FLoadingType write FLoadingType default [dltOnGetData];
  end;

  /// <summary>
  ///   TfrxComponent is the basic class for all FastReport components. Objects
  ///   of this type have such parameters as "coordinates", "size", "font",
  ///   "visibility" and lists of subordinate objects. The class also contains
  ///   methods, which allow saving/restoring object's state to/from the
  ///   stream.
  /// </summary>
  TfrxComponent = class(TfrCustomComponent)
  private
    FFont: TFont;
    FObjects: TfrxObjectsNotifyList;
    FAllObjects: TList;
    FSortedObjects: TStringList;
    FLeft: Extended;
    FTop: Extended;
    FWidth: Extended;
    FHeight: Extended;
    FParentFont: Boolean;
    FGroupIndex: Integer;
    FIsLoading: Boolean;
    FIsPrinting: Boolean;
    FMouseInView: Boolean;
    //FIsSelected: Boolean;
    FRestrictions: TfrxRestrictions;
    FEditable: TfrxEditableRights;
    FVisible: Boolean;
    FDescription: String;
    FComponentStyle: TfrxComponentStyle;
    FfrComponentState: TfrxComponentState;
    FAncestorOnlyStream: Boolean;
    FIndexTag: frInteger;
    FAnchors: TfrxAnchors;
    FAnchorsUpdating: Boolean;
    FAllowMirrorMode: Boolean;
    function GetAbsTop: Extended;
    function GetPage: TfrxPage;
    function GetTopParent: TfrxComponent;
    function IsFontStored: Boolean;
    function GetAllObjects: TList;
    function GetSortedObjects: TStringList;
    function GetAbsLeft: Extended;
    function GetIsLoading: Boolean;
    function GetIsAncestor: Boolean;
    function GetIsSelected: Boolean;
    function GetIsDesigning: Boolean;
    procedure SetIsDesigning(const Value: Boolean);
    function GetIsWriting: Boolean;
    procedure SetIsWriting(const Value: Boolean);
  protected
    FSelectList: TList;
    FParent: TfrxComponent;
    FAliasName: String;
    FBaseName: String;
    FAncestor: Boolean;
    FOriginalComponent: TfrxComponent;
    FOriginalRect: TfrxRect;
    FOriginalBand: TfrxComponent;
    FComponentEditors: TfrxComponentEditorsManager;
    FSerializedItem: TfrXMLItem;
    FHighlighted: Boolean;
    class function GetObjectListClass: TfrxObjectsNotifyListClass; virtual;
    function IsTopStored: Boolean; virtual;
    function IsLeftStored: Boolean; virtual;
    function IsWidthStored: Boolean; virtual;
    function IsHeightStored: Boolean; virtual;
    function IsIndexTagStored: Boolean;
    procedure SetAnchors(const Value: TfrxAnchors); virtual;
    procedure SetIsSelected(const Value: Boolean); virtual;
    procedure SetParent(AParent: TfrxComponent); virtual;
    procedure SetLeft(Value: Extended); virtual;
    procedure SetTop(Value: Extended); virtual;
    procedure SetWidth(Value: Extended); virtual;
    procedure SetHeight(Value: Extended); virtual;
    procedure SetName(const AName: TComponentName); override;
    procedure SetFont(Value: TFont); virtual;
    procedure SetParentFont(const Value: Boolean); virtual;
    procedure SetVisible(Value: Boolean); virtual;
    procedure FontChanged(Sender: TObject); virtual;
    function DiffFont(f1, f2: TFont; const Add: String): String;
    function InternalDiff(AComponent: TfrxComponent): String;
    function GetContainerObjects: TList; virtual;
    function GetRestrictions: TfrxRestrictions; virtual;
    function GetReport: TfrxReport; virtual;
    procedure InintComponentInPlaceEditor(var EventParams: TfrxInteractiveEventsParams);
    { override to detect what was added or deleted from Objects list }
    procedure ObjectListNotify(Ptr: Pointer; Action: TListNotification); virtual;
    procedure LockAnchorsUpdate;
    procedure UnlockAnchorsUpdate;
    procedure ThreadSynchronize(Method: TThreadMethod);

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetChildOwner: TComponent; override;

        { interactive object behaviour }
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); virtual;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); virtual;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; virtual;
    procedure DoMouseEnter(aPreviousObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams); virtual;
    procedure DoMouseLeave(aNextObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams); virtual;
    procedure DoMouseClick(Double: Boolean;
      var EventParams: TfrxInteractiveEventsParams); virtual;
    function DoMouseWheel(Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint;
      var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;
    function DoDragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; virtual;
    function DoDragDrop(Source: TObject; X, Y: Integer;
      var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;
    procedure MirrorContent(MirrorModes: TfrxMirrorControlModes); virtual;
    procedure DoMirror(MirrorModes: TfrxMirrorControlModes); virtual;
    procedure UpdateAnchors(DeltaX, Deltay: Extended); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    ///   Constructor uses by the report designer when create new report
    ///   object.
    /// </summary>
    /// <param name="AOwner">
    ///   Component owner.
    /// </param>
    /// <param name="Flags">
    ///   Addition creation parameter depends on component class.
    /// </param>
    constructor DesignCreate(AOwner: TComponent; Flags: Word); virtual;
    destructor Destroy; override;
    /// <summary>
    ///   Get description of the report component. By default returns class
    ///   name.
    /// </summary>
    class function GetDescription: String; virtual;
    /// <summary>
    ///   Align all child objects relative to the container based on mirror
    ///   control modes and child objects Align's.
    /// </summary>
    /// <param name="IgnoreInvisible">
    ///   Ignore objects which's Visible property set to false.
    /// </param>
    /// <param name="MirrorModes">
    ///   Mirror modes of top container.
    /// </param>
    procedure AlignChildren(IgnoreInvisible: Boolean = False; MirrorModes: TfrxMirrorControlModes = []); virtual;
    /// <summary>
    ///   Copies the state of Source object (ignores all child objects).
    /// </summary>
    procedure Assign(Source: TPersistent); override;
    procedure AssignToDict(Source: TfrxComponent);
    /// <summary>
    ///   Copies the state of Source object with all child objects.
    /// </summary>
    procedure AssignAll(Source: TfrxComponent; Streaming: Boolean = False);
    /// <summary>
    ///   Internal use only. Copies the state of Source object with all child
    ///   objects. Also assign all original components (FOriginalComponent)
    ///   used for prepared report object dictionary.
    /// </summary>
    procedure AssignAllWithOriginals(Source: TfrxComponent; Streaming: Boolean = False);
    procedure AssignOriginals(Source: TfrxComponent); virtual;
    /// <summary>
    ///   Deprecated. Used only for cross tab object for saving nested objects
    ///   to source object dictionary.
    /// </summary>
    procedure AddSourceObjects; virtual;
    /// <summary>
    ///   Report engine call this method before start report preparation. Used
    ///   to prepare objects before build.
    /// </summary>
    procedure BeforeStartReport; virtual;
    /// <summary>
    ///   Creates a unique name for an object placed into the report.
    /// </summary>
    procedure Clear; virtual;
    /// <summary>
    ///   Creates a unique name for an object placed into the report.
    /// </summary>
    procedure CreateUniqueName(DefaultReport: TfrxReport = nil);
    /// <summary>
    ///   Loads object contents and all its child objects from the stream.
    /// </summary>
    procedure LoadFromStream(Stream: TStream); virtual;
    /// <summary>
    ///   Saves an object to the stream. The SaveChildren parameter
    ///   defines,whether state of all child objects should also be saved.
    ///   TheSaveDefaultValues parameter defines, whether to save properties
    ///   thathave default values.
    /// </summary>
    procedure SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
      SaveDefaultValues: Boolean = False; Streaming: Boolean = False); virtual;
    /// <summary>
    ///   Sets coordinates and size of an object.
    /// </summary>
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Extended);
    /// <summary>
    ///   The report engine notifies all objects after show band. Used only for
    ///   Chart object with dtBandData type.
    /// </summary>
    procedure OnNotify(Sender: TObject); virtual;
    /// <summary>
    ///   Object receives message when users paste report object in the report
    ///   designer. Old method.
    /// </summary>
    procedure OnPaste; virtual;
    /// <summary>
    ///   Generates serialized object XML string based on comparison of current
    ///   object with AComponent (Diff between two objects). Used to generate
    ///   object dictionary when csDefaultDiff flag is set. <br />
    /// </summary>
    function AllDiff(AComponent: TfrxComponent): String;
    /// <summary>
    ///   Generates serialized object XML string based on comparison of current
    ///   object with AComponent (Diff between two objects). Light version of
    ///   AllDiff function used to generate object dictionary when
    ///   csDefaultDiff flag is NOT set. <br />
    /// </summary>
    function Diff(AComponent: TfrxComponent): String; virtual;
    /// <summary>
    ///   Searches for an object with specified name among the child objects.
    /// </summary>
    function FindObject(const AName: String): TfrxComponent; virtual;
    /// <summary>
    ///   The serializer calls this method when write nested(composite) non
    ///   published object. Used with csHandlesNestedProperties flag to write
    ///   XML representation of an object instead of binary stream(PropData).
    /// </summary>
    procedure WriteNestedProperties(Item: TfrXMLItem; aAcenstor: TPersistent = nil); virtual;
    /// <summary>
    ///   The serializer calls this method when read nested(composite) non
    ///   published object. Used with csHandlesNestedProperties flag to read
    ///   XML representation of an object instead of binary stream(PropData).
    /// </summary>
    function ReadNestedProperty(Item: TfrXMLItem): Boolean; virtual;
    /// <summary>
    ///   Detects if point is inside an object coordinates.
    /// </summary>
    function IsContain(X, Y: Extended): Boolean; overload; virtual;
    /// <summary>
    ///   Returns True if part of object bounds is inside source rectangle.
    /// </summary>
    /// <param name="aRect">
    ///   Source rectangle.
    /// </param>
    function IsContain(X, Y, AScale: Extended): Boolean; overload;
    function IsInRect(const aRect: TfrxRect): Boolean; virtual;
    /// <summary>
    ///   Return client area of object.
    /// </summary>
    function GetClientArea: TfrxRect; virtual;
    /// <summary>
    ///   Returns object used to draw and calculate text bounds. For objects
    ///   with report components it returns object owned by report. otherwise
    ///   global frxDrawText.
    /// </summary>
    function GetDrawTextObject: Pointer;
    /// <summary>
    ///   Method returns topmost report component for prepared report or report
    ///   template (preview pages are not owned by report object and 'Report'
    ///   property returns nil for them). <br />
    /// </summary>
    function GetGlobalReport: TfrxReport;
    /// <summary>
    ///   Returns top-most object which contain point at passed coordinates
    /// </summary>
    /// <param name="X">
    ///   X coordinate.
    /// </param>
    /// <param name="Y">
    ///   Y coordinate.
    /// </param>
    /// <param name="IsCanContain">
    ///   Child Component. If IsCanContain = nil - returns top-most object,
    ///   otherwise IsCanContain &lt;&gt; nil - return top-most object which
    ///   can accept IsCanContain component as child.
    /// </param>
    /// <returns>
    ///   Found component or nil.
    /// </returns>
    function GetContainedComponent(X, Y: Extended; IsCanContain: TfrxComponent = nil): TfrxComponent; virtual;
    /// <summary>
    ///   Returns objects inside rectangle area with class type inherit from
    ///   specified class type.
    /// </summary>
    /// <param name="aRect">
    ///   Rectangle area.
    /// </param>
    /// <param name="InheriteFrom">
    ///   Class of objects which should be selected by function.
    /// </param>
    /// <param name="aComponents">
    ///   Result List of components that suits function parameters.
    /// </param>
    /// <param name="bSelectContainers">
    ///   Include containers into selection result.
    /// </param>
    procedure GetContainedComponents(const aRect: TfrxRect; InheriteFrom: TClass; aComponents: TList; bSelectContainers: Boolean = False); virtual;
    /// <summary>
    ///   Export engine calls this method before process object inside export
    ///   filter. If this method returns true, object processed by itself and
    ///   default method will not call.
    /// </summary>
    function ExportInternal(Filter: TfrxCustomExportFilter): Boolean; virtual;

    { control behaviour for detection childs which it can holds }
    /// <summary>
    ///   Returns true when component can accept component in aControl as
    ///   child.
    /// </summary>
    /// <param name="aControl">
    ///   Component that supposedly should become a child.
    /// </param>
    function IsAcceptControl(aControl: TfrxComponent): Boolean; virtual;
    /// <summary>
    ///   Returns true when component in aParent can be accepted as parent for
    ///   current. <br />
    /// </summary>
    /// <param name="aParent">
    ///   Component that supposedly should become a parent for current.
    /// </param>
    function IsAcceptAsChild(aParent: TfrxComponent): Boolean; virtual;
    { general function just quick check of flag }
    function IsAcceptControls: Boolean; virtual;
    { events trigger }
    /// <summary>
    ///   Generates mouse move event for report object.
    /// </summary>
    /// <param name="X">
    ///   X coordinate.
    /// </param>
    /// <param name="Y">
    ///   Y coordinate. <br />
    /// </param>
    /// <param name="Shift">
    ///   Shift keys state.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    procedure MouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams);
    /// <summary>
    ///   Generates mouse up event for report object.
    /// </summary>
    /// <param name="X">
    ///   X coordinate.
    /// </param>
    /// <param name="Y">
    ///   Y coordinate.
    /// </param>
    /// <param name="Button">
    ///   Mouse button.
    /// </param>
    /// <param name="Shift">
    ///   Shift keys state.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    procedure MouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams);
    /// <summary>
    ///   Generates mouse down event for report object.
    /// </summary>
    /// <param name="X">
    ///   X coordinate.
    /// </param>
    /// <param name="Y">
    ///   Y coordinate.
    /// </param>
    /// <param name="Button">
    ///   Mouse button.
    /// </param>
    /// <param name="Shift">
    ///   Shift keys state.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    function MouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean;
    /// <summary>
    ///   Generates mouse enter event for report object.
    /// </summary>
    /// <param name="aPreviousObject">
    ///   Reference to previous object which was in focus(Can be nil).
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    procedure MouseEnter(aPreviousObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams);
    /// <summary>
    ///   Generates mouse leave event for report object.
    /// </summary>
    /// <param name="X">
    ///   X coordinate.
    /// </param>
    /// <param name="Y">
    ///   Y coordinate.
    /// </param>
    /// <param name="aNextObject">
    ///   Reference to an object which should receive focus(Can be nil).
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    procedure MouseLeave(X, Y: Integer; aNextObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams);
    /// <summary>
    ///   Generates mouse click event for report object.
    /// </summary>
    /// <param name="Double">
    ///   If True, it's a double click event.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    procedure MouseClick(Double: Boolean;
      var EventParams: TfrxInteractiveEventsParams);
    /// <summary>
    ///   Generates mouse wheel event for report object.
    /// </summary>
    /// <param name="Shift">
    ///   Shift keys state.
    /// </param>
    /// <param name="WheelDelta">
    ///   Delta of mouse wheel.
    /// </param>
    /// <param name="MousePos">
    ///   Position of mouse cursor.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    function MouseWheel(Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint;
      var EventParams: TfrxInteractiveEventsParams): Boolean;
    /// <summary>
    ///   Generates drag over event for report object when drag and drop
    ///   initialized.
    /// </summary>
    /// <param name="Source">
    ///   The object being dragged.
    /// </param>
    /// <param name="X">
    ///   X coordinate.
    /// </param>
    /// <param name="Y">
    ///   Y coordinate. <br />
    /// </param>
    /// <param name="State">
    ///   Indicates how the dragged object is moving in relation to the
    ///   control.
    /// </param>
    /// <param name="Accept">
    ///   Returns true when object can accept dragged object.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    function DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean; var EventParams: TfrxInteractiveEventsParams)
      : Boolean;
    /// <summary>
    ///   Generates drag drop event for report object when drag and drop
    ///   initialized.
    /// </summary>
    /// <param name="Source">
    ///   The object being dropped.
    /// </param>
    /// <param name="X">
    ///   X coordinate
    /// </param>
    /// <param name="Y">
    ///   Y coordinate
    /// </param>
    /// <param name="EventParams">
    ///   Structure with additional parameters.
    /// </param>
    function DragDrop(Source: TObject; X, Y: Integer;
      var EventParams: TfrxInteractiveEventsParams): Boolean;

//    procedure FireEvent(Sender: TObject; X, Y: Integer; Button: TMouseButton; Shift: TShiftState; Scale, OffsetX, OffsetY: Extended; var aEventParams: TfrxPreviewIntEventParams);
    /// <summary>
    ///   Used to validate object real bounds.
    /// </summary>
    procedure UpdateBounds; virtual;
    /// <summary>
    ///   Deprecated. Used only for cross tab component. Adds internal child
    ///   objects for cross cells.
    /// </summary>
    /// <param name="Obj">
    ///   Report object.
    /// </param>
    function ContainerAdd(Obj: TfrxComponent): Boolean; virtual;
    /// <summary>
    ///   Looking for data set with filename specified. The result of search
    ///   depends on flag state Tfrxreport Engine options .Use Grobal data set
    ///   list. If the flag is installed in True ,then search is realized in
    ///   Grobal data set list , otherwuise in TfrxReport list . Enabled data
    ///   sets.
    /// </summary>
    /// <param name="DataSet">
    ///   Dataset.
    /// </param>
    /// <param name="DSName">
    ///   Dataset name.
    /// </param>
    function FindDataSet(DataSet: TfrxDataSet; const DSName: String): TfrxDataSet;
    /// <summary>
    ///   Used with TfrxMirrorControlModes when mcmOnlyAllowed set on parent
    ///   container. It marks report object follows TfrxMirrorControlModes
    ///   rules.
    /// </summary>
    property AllowMirrorMode: Boolean read FAllowMirrorMode write FAllowMirrorMode default False;
    /// <summary>
    ///   Anchors relative to parent container (Default left, top).
    /// </summary>
    property Anchors: TfrxAnchors read FAnchors write SetAnchors default [fraLeft, fraTop];
    /// <summary>
    ///   Used when save object to XML. If this property set to true only
    ///   values of ancestor object will be serialized.
    /// </summary>
    property AncestorOnlyStream: Boolean read FAncestorOnlyStream write FAncestorOnlyStream;
    /// <summary>
    ///   The list of child objects.
    /// </summary>
    property Objects: TfrxObjectsNotifyList read FObjects;
    /// <summary>
    ///   The list of all subordinate objects.
    /// </summary>
    property AllObjects: TList read GetAllObjects;
    /// <summary>
    ///   Deprecated. Used to support old cross tab behaviour.
    /// </summary>
    property ContainerObjects: TList read GetContainerObjects;
    /// <summary>
    ///   Link to the parent object.
    /// </summary>
    property Parent: TfrxComponent read FParent write SetParent;
    /// <summary>
    ///   Link to the report page, which the object belongs to.
    /// </summary>
    property Page: TfrxPage read GetPage;
    /// <summary>
    ///   Link to the report, which the object belongs to.
    /// </summary>
    property Report: TfrxReport read GetReport;
    /// <summary>
    ///   Returns topmost parent of the object.
    /// </summary>
    property TopParent: TfrxComponent read GetTopParent;
    /// <summary>
    ///   Returns True when object has an ancestor.
    /// </summary>
    property IsAncestor: Boolean read GetIsAncestor;
    /// <summary>
    ///   The object in designing mode.
    /// </summary>
    property IsDesigning: Boolean read GetIsDesigning write SetIsDesigning;
    /// <summary>
    ///   Object is loading.
    /// </summary>
    property IsLoading: Boolean read GetIsLoading write FIsLoading;
    /// <summary>
    ///   Object is printing.
    /// </summary>
    property IsPrinting: Boolean read FIsPrinting write FIsPrinting;
    /// <summary>
    ///   Object is in serialization state.
    /// </summary>
    property IsWriting: Boolean read GetIsWriting write SetIsWriting;
    /// <summary>
    ///   Object selected in the report designer or report preview.
    /// </summary>
    property IsSelected: Boolean read GetIsSelected write SetIsSelected;
    /// <summary>
    ///   Base name of the report object. Used for generation of unique names.
    /// </summary>
    property BaseName: String read FBaseName;
    property GroupIndex: Integer read FGroupIndex write FGroupIndex default 0;
    /// <summary>
    ///   Report object component styles.
    /// </summary>
    property frComponentStyle: TfrxComponentStyle read FComponentStyle write FComponentStyle;
    property frComponentState: TfrxComponentState read FfrComponentState write FfrComponentState;
    /// <summary>
    ///   Object's X coordinate (relatively to a parent, in pixels).
    /// </summary>
    property Left: Extended read FLeft write SetLeft stored IsLeftStored;
    /// <summary>
    ///   Object's Y coordinate (relatively to a parent, in pixels).
    /// </summary>
    property Top: Extended read FTop write SetTop stored IsTopStored;
    /// <summary>
    ///   Object's width, in pixels.
    /// </summary>
    property Width: Extended read FWidth write SetWidth stored IsWidthStored;
    /// <summary>
    ///   Object's height, in pixels.
    /// </summary>
    property Height: Extended read FHeight write SetHeight stored IsHeightStored;
    /// <summary>
    ///   Object's X absolute coordinate, in pixels.
    /// </summary>
    property AbsLeft: Extended read GetAbsLeft;
    /// <summary>
    ///   Object's Y absolute coordinate, in pixels.
    /// </summary>
    property AbsTop: Extended read GetAbsTop;

    /// <summary>
    ///   Object's description.
    /// </summary>
    property Description: String read FDescription write FDescription;
    /// <summary>
    ///   Allows edit objects in the preview and export(some export filters).
    /// </summary>
    property Editable: TfrxEditableRights read FEditable write FEditable default [];
    /// <summary>
    ///   If "True", then uses the parent object font settings.
    /// </summary>
    property ParentFont: Boolean read FParentFont write SetParentFont default True;
    /// <summary>
    ///   Set of flags, which restrict some object operations.
    /// </summary>
    property Restrictions: TfrxRestrictions read GetRestrictions write FRestrictions default [];
    /// <summary>
    ///   Global visibility of the object in the result report.
    /// </summary>
    property Visible: Boolean read FVisible write SetVisible default True;
    /// <summary>
    ///   Object's font.
    /// </summary>
    property Font: TFont read FFont write SetFont stored IsFontStored;
    /// <summary>
    ///   Not used.
    /// </summary>
    property IndexTag: frInteger read FIndexTag write FIndexTag stored IsIndexTagStored;
  end;

  IfrxAggregateObject = interface
  ['{63ABB456-F4C9-49DA-ADA2-E3ABC7125B15}']
    function GetParentContainer: TfrxComponent;
    function GetDataRowContainer: TfrxComponent;
    function GetDataContainers: TList;
    function GetExpression: String;
    function GetExpressionDelimiters: String;
    function GetInstance: TfrxComponent;
  end;

  /// <summary>
  ///   Objects of this type can be placed into a report. The class contains
  ///   the "Draw" method for object's painting, as well as
  ///   "BeforePrint/GetData/AfterPrint" methods, which are called as soon as a
  ///   report runs.
  /// </summary>
  TfrxReportComponent = class(TfrxComponent)
  private
    FOnAfterData: TfrxNotifyEvent;
    FOnAfterPrint: TfrxNotifyEvent;
    FOnBeforePrint: TfrxNotifyEvent;
    FOnPreviewClick: TfrxPreviewClickEvent;
    FOnPreviewDblClick: TfrxPreviewClickEvent;
    FOnContentChanged: TfrxContentChangedEvent;
    FPrintOn: TfrxPrintOnTypes;
  protected
    /// <summary>
    ///   Draws size boxes around report objects in the report designer.
    /// </summary>
    procedure DrawSizeBox(aCanvas: TCanvas; aScale: Extended; bForceDraw: Boolean = False); virtual;
  public
    { TODO : hide this Stuff !}
    /// <summary>
    ///   Used in new shift mechanism, stores shift tree or list. Internal use
    ///   only.
    /// </summary>
    FShiftObject: TObject;
    /// <summary>
    ///   Used for TfrxSubReport.PrintOnParent. Internal use only.
    /// </summary>
    FOriginalObjectsCount: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    ///   Used from the report designer and preview calls Draw/DrawHighlight. <br />
    /// </summary>
    /// <param name="Canvas">
    ///   Canvas to draw object.
    /// </param>
    /// <param name="ScaleX">
    ///   X Scale factor.
    /// </param>
    /// <param name="ScaleY">
    ///   Y Scale factor. <br />
    /// </param>
    /// <param name="OffsetX">
    ///   X Offset.
    /// </param>
    /// <param name="OffsetY">
    ///   Y Offset.
    /// </param>
    /// <param name="Highlighted">
    ///   Force DrawHighlight call.
    /// </param>
    /// <param name="hlColor">
    ///   Highlight color.
    /// </param>
    procedure InteractiveDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; Highlighted: Boolean = False; hlColor: TColor = clNone);
    { back compat }
    /// <summary>
    ///   The Draw method is called when painting an object. <br />
    /// </summary>
    /// <param name="Canvas">
    ///   Canvas
    /// </param>
    /// <param name="ScaleX">
    ///   Zoom by X-axis.
    /// </param>
    /// <param name="ScaleY">
    ///   Zoom by Y-axis.
    /// </param>
    /// <param name="OffsetX">
    ///   X offset relatively to the edges of the canvas.
    /// </param>
    /// <param name="OffsetY">
    ///   Y offset relatively to the edges of the canvas. <br />
    /// </param>
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
      virtual; abstract;
    /// <summary>
    ///   Reserved. Not implemented.
    /// </summary>
    procedure DrawChilds(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; Highlighted: Boolean; IsDesigning: Boolean);
      virtual;
    /// <summary>
    ///   Reserved. Not implemented.
    /// </summary>
    procedure DrawWithChilds(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; Highlighted: Boolean; IsDesigning: Boolean);
    /// <summary>
    ///   Draws selection highlight.
    /// </summary>
    /// <param name="Canvas">
    ///   Canvas to draw.
    /// </param>
    /// <param name="ScaleX">
    ///   X scale factor.
    /// </param>
    /// <param name="ScaleY">
    ///   Y scale factor. <br />
    /// </param>
    /// <param name="OffsetX">
    ///   X offset.
    /// </param>
    /// <param name="OffsetY">
    ///   X offset.
    /// </param>
    /// <param name="hlColor">
    ///   Highlight color.
    /// </param>
    procedure DrawHighlight(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; hlColor: TColor = clNone); virtual;
    /// <summary>
    ///   The report engine calls this method before prepare object and place
    ///   it to preview pages.
    /// </summary>
    procedure BeforePrint; virtual;
    /// <summary>
    ///   The report engine calls this method to get Data inside object or
    ///   calculate expressions.
    /// </summary>
    procedure GetData; virtual;
    /// <summary>
    ///   The report engine calls this method after object was prepared and
    ///   placed to preview pages.
    /// </summary>
    procedure AfterPrint; virtual;
    /// <summary>
    ///   Returns text of the report object. Used in export filters.
    /// </summary>
    function GetComponentText: String; virtual;
    /// <summary>
    ///   Deprecated. Returns real size of object.
    /// </summary>
    function GetRealBounds: TfrxRect; virtual;
    /// <summary>
    ///   Returns component with part of the data of the current (by default
    ///   returns Self). Used in split mechanism when one object breaks to
    ///   several parts. The component should be prepared by DrawPart method.
    ///   Engine adds this object to preview pages.
    /// </summary>
    function GetSaveToComponent: TfrxReportComponent; virtual;
    /// <summary>
    ///   Returns True when parent container should draw child.
    /// </summary>
    function IsOwnerDraw: Boolean; virtual;
    /// <summary>
    ///   The name of the script routine that will be called after the object
    ///   gets data.
    /// </summary>
    property OnAfterData: TfrxNotifyEvent read FOnAfterData write FOnAfterData;
    /// <summary>
    ///   The name of the script routine that will be called after the object
    ///   is handled.
    /// </summary>
    property OnAfterPrint: TfrxNotifyEvent read FOnAfterPrint write FOnAfterPrint;
    /// <summary>
    ///   The name of the script routine that will be called before the object
    ///   is handled.
    /// </summary>
    property OnBeforePrint: TfrxNotifyEvent read FOnBeforePrint write FOnBeforePrint;
    /// <summary>
    ///   The name of the script routine that will be called if user clicks on
    ///   the object in the preview window.
    /// </summary>
    property OnPreviewClick: TfrxPreviewClickEvent read FOnPreviewClick write FOnPreviewClick;
    /// <summary>
    ///   The name of the script routine that will be called if user double
    ///   clicks on the object in the preview window.
    /// </summary>
    property OnPreviewDblClick: TfrxPreviewClickEvent read FOnPreviewDblClick write FOnPreviewDblClick;
    /// <summary>
    ///   The name of the script routine that will be called if content of
    ///   object was changes(for example text in "Text" object).
    /// </summary>
    property OnContentChanged: TfrxContentChangedEvent read FOnContentChanged write FOnContentChanged;
    // todo
    /// <summary>
    ///   Reserved for future use.
    /// </summary>
    property PrintOn: TfrxPrintOnTypes read FPrintOn write FPrintOn;
  published
    property Description;
    property IndexTag;
  end;

  /// <summary>
  ///   The TfrxDialogComponent class is the basic one for writing non-visual
  ///   components, which can be placed on a dialog form in a report.
  /// </summary>
  TfrxDialogComponent = class(TfrxReportComponent)
  private
    FComponent: TComponent;
    procedure ReadLeft(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure WriteLeft(Writer: TWriter);
    procedure WriteTop(Writer: TWriter);
  protected
    FImageIndex: Integer;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    /// <summary>
    ///   Link to the component itself.
    /// </summary>
    property Component: TComponent read FComponent write FComponent;
  end;

  { TfrxDialogControl }

  /// <summary>
  ///   The "TfrxDialogControl" class is the basic one for writing common
  ///   control, which can be placed on a dialogue form in a report. The class
  ///   contains a large number of general properties and events shared with
  ///   most of the common controls.
  /// </summary>
  TfrxDialogControl = class(TfrxReportComponent)
  private
    FControl: TControl;
    FOnClick: TfrxNotifyEvent;
    FOnDblClick: TfrxNotifyEvent;
    FOnEnter: TfrxNotifyEvent;
    FOnExit: TfrxNotifyEvent;
    FOnKeyDown: TfrxKeyEvent;
    FOnKeyPress: TfrxKeyPressEvent;
    FOnKeyUp: TfrxKeyEvent;
    FOnMouseDown: TfrxMouseEvent;
    FOnMouseMove: TfrxMouseMoveEvent;
    FOnMouseUp: TfrxMouseEvent;
    FOnActivate: TNotifyEvent;
    function GetColor: TColor;
    function GetEnabled: Boolean;
    procedure DoOnClick(Sender: TObject);
    procedure DoOnDblClick(Sender: TObject);
    procedure DoOnEnter(Sender: TObject);
    procedure DoOnExit(Sender: TObject);
    procedure DoOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoOnKeyPress(Sender: TObject; var Key: Char);
    procedure DoOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DoOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoOnMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetEnabled(const Value: Boolean);
    function GetCaption: String;
    procedure SetCaption(const Value: String);
    function GetHint: String;
    procedure SetHint(const Value: String);
    function GetShowHint: Boolean;
    procedure SetShowHint(const Value: Boolean);
    function GetTabStop: Boolean;
    procedure SetTabStop(const Value: Boolean);
    procedure DoDestroyControl;
    procedure DoSetParent;
    procedure DoInitControl;
  protected
    FCurrentPPI: Integer;
    procedure CorrectControlCoordinates; virtual;
    function GetCoordinateOffset: TPoint; virtual;
    function GetScaledControlHeight: Integer;
    function GetScaledControlLeft: Integer;
    function GetScaledControlTop: Integer;
    function GetScaledControlWidth: Integer;
    procedure SetAnchors(const Value: TfrxAnchors); override;
    procedure SetLeft(Value: Extended); override;
    procedure SetTop(Value: Extended); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
    procedure SetParentFont(const Value: Boolean); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure FontChanged(Sender: TObject); override;
    procedure InitControl(AControl: TControl);
    procedure SetName(const AName: TComponentName); override;
    procedure UpdateControlPPI(aNewPPI: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    function IsOwnerDraw: Boolean; override;
    function IsAcceptControls: Boolean; override;
    function IsAcceptAsChild(aParent: TfrxComponent): Boolean; override;
    /// <summary>
    ///   Caption of the control.
    /// </summary>
    property Caption: String read GetCaption write SetCaption;
    /// <summary>
    ///   Color of the control.
    /// </summary>
    property Color: TColor read GetColor write SetColor;
    /// <summary>
    ///   Link to the control itself.
    /// </summary>
    property Control: TControl read FControl write FControl;
    /// <summary>
    ///   Determines if the user can tab to a control.
    /// </summary>
    property TabStop: Boolean read GetTabStop write SetTabStop default True;
    /// <summary>
    ///   The name of the script routine that will be called if user clicks the
    ///   control.
    /// </summary>
    property OnClick: TfrxNotifyEvent read FOnClick write FOnClick;
    /// <summary>
    ///   The name of the script routine that will be called if user double
    ///   clicks the control.
    /// </summary>
    property OnDblClick: TfrxNotifyEvent read FOnDblClick write FOnDblClick;
    /// <summary>
    ///   The name of the script routine that will be called if control gets
    ///   the focus.
    /// </summary>
    property OnEnter: TfrxNotifyEvent read FOnEnter write FOnEnter;
    /// <summary>
    ///   The name of the script routine that will be called if user pressed a
    ///   key.
    /// </summary>
    property OnExit: TfrxNotifyEvent read FOnExit write FOnExit;
    /// <summary>
    ///   The name of the script routine that will be called if user pressed a
    ///   key.
    /// </summary>
    property OnKeyDown: TfrxKeyEvent read FOnKeyDown write FOnKeyDown;
    /// <summary>
    ///   The name of the script routine that will be called if user pressed a
    ///   key.
    /// </summary>
    property OnKeyPress: TfrxKeyPressEvent read FOnKeyPress write FOnKeyPress;
    /// <summary>
    ///   The name of the script routine that will be called if user released a
    ///   key.
    /// </summary>
    property OnKeyUp: TfrxKeyEvent read FOnKeyUp write FOnKeyUp;
    /// <summary>
    ///   The name of the script routine that will be called if user pressed a
    ///   mouse button.
    /// </summary>
    property OnMouseDown: TfrxMouseEvent read FOnMouseDown write FOnMouseDown;
    /// <summary>
    ///   The name of the script routine that will be called if user moved a
    ///   mouse over control.
    /// </summary>
    property OnMouseMove: TfrxMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    /// <summary>
    ///   The name of the script routine that will be called if user released a
    ///   mouse button.
    /// </summary>
    property OnMouseUp: TfrxMouseEvent read FOnMouseUp write FOnMouseUp;
    /// <summary>
    ///   The name of the script routine that will be called if user activate
    ///   control.
    /// </summary>
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
  published
    property Anchors;
    property Left;
    property Top;
    property Width;
    property Height;
    property Font;
    property GroupIndex;
    property ParentFont;
    /// <summary>
    ///   Determines if the control is enabled.
    /// </summary>
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    /// <summary>
    ///   Contains the text string that can appear when the user moves the
    ///   mouse over the control.
    /// </summary>
    property Hint: String read GetHint write SetHint;
    /// <summary>
    ///   Show/hide hint.
    /// </summary>
    property ShowHint: Boolean read GetShowHint write SetShowHint;
    property Visible;
  end;

  /// <summary>
  ///   The TfrxDataSet class is used for navigation of a dataset. It is base
  ///   class for TfrxDBDataSet, TfrxUserDataSet components.
  /// </summary>
  TfrxDataSet = class(TfrxDialogComponent)
  private
    FCloseDataSource: Boolean;
    FEnabled: Boolean;
    FEof: Boolean;
    FOpenDataSource: Boolean;
    FRangeBegin: TfrxRangeBegin;
    FRangeEnd: TfrxRangeEnd;
    FRangeEndCount: Integer;
    FReportRef: TfrxReport;
    FUserName: String;
    FOnCheckEOF: TfrxCheckEOFEvent;
    FOnFirst: TNotifyEvent;
    FOnNext: TNotifyEvent;
    FOnPrior: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    FOnClose: TNotifyEvent;
  protected
    FInitialized: Boolean;
    FRecNo: Integer;
    // TODO const String
    function GetDisplayText(Index: String): WideString; virtual;
    function GetDisplayWidth(Index: String): Integer; virtual;
    function GetFieldType(Index: String): TfrxFieldType; virtual;
    function GetValue(Index: String): Variant; virtual;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetUserName(const Value: String); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Navigation methods }
    /// <summary>
    ///   Initializes DataSet before open.
    /// </summary>
    procedure Initialize; virtual;
    /// <summary>
    ///   Finalizes DataSet after close.
    /// </summary>
    procedure Finalize; virtual;
    /// <summary>
    ///   Opens the dataset.
    /// </summary>
    procedure Open; virtual;
    /// <summary>
    ///   Closes the dataset.
    /// </summary>
    procedure Close; virtual;
    /// <summary>
    ///   Sets the cursor to the first record.
    /// </summary>
    procedure First; virtual;
    /// <summary>
    ///   Moves the cursor to the next record.
    /// </summary>
    procedure Next; virtual;
    /// <summary>
    ///   Moves the cursor to the previous record. This method is used only
    ///   when printing groups.
    /// </summary>
    procedure Prior; virtual;
    /// <summary>
    ///   Function returns True if end of the dataset is reached.
    /// </summary>
    function Eof: Boolean; virtual;

    { Data access }
    /// <summary>
    ///   Returns the number of fields defined in the dataset.
    /// </summary>
    function FieldsCount: Integer; virtual;
    /// <summary>
    ///   Returns True if dataset has field with specified name.
    /// </summary>
    function HasField(const fName: String): Boolean;
    /// <summary>
    ///   Returns True if dataset has BLOB field with specified name.
    /// </summary>
    function IsBlobField(const fName: String): Boolean; virtual;
    /// <summary>
    ///   Returns True if dataset has wide memo BLOB field with specified name.
    /// </summary>
    function IsWideMemoBlobField(const fName: String): Boolean; virtual;
    /// <summary>
    ///   Returns True if dataset has memo BLOB field with specified name.
    /// </summary>
    function IsMemoBlobField(const fName: String): Boolean; virtual;
    /// <summary>
    ///   Returns True if DataSet has master RecordSet.
    /// </summary>
    function IsHasMaster: Boolean; virtual;
    /// <summary>
    ///   Returns records count if DataSet supports it.
    /// </summary>
    function RecordCount: Integer; virtual;
    /// <summary>
    ///   Assigns stream in Obj to BLOB field with fName name.
    /// </summary>
    /// <param name="fName">
    ///   Name of the BLOB field.
    /// </param>
    /// <param name="Obj">
    ///   Object serialized to blob (supports TStream successors). <br />
    /// </param>
    procedure AssignBlobTo(const fName: String; Obj: TObject); virtual;
    /// <summary>
    ///   Returns list of dataset fields.
    /// </summary>
    procedure GetFieldList(List: TStrings); virtual;
    /// <summary>
    ///   Returns the field value as a string.
    /// </summary>
    property DisplayText[Index: String]: WideString read GetDisplayText;
    /// <summary>
    ///   Returns the size of a specified field.
    /// </summary>
    property DisplayWidth[Index: String]: Integer read GetDisplayWidth;
    /// <summary>
    ///   Returns the field type
    /// </summary>
    property FieldType[Index: String]: TfrxFieldType read GetFieldType;
    /// <summary>
    ///   Returns the field value as a variant.
    /// </summary>
    property Value[Index: String]: Variant read GetValue;

    /// <summary>
    ///   Close a data set after report construction is completed.
    /// </summary>
    property CloseDataSource: Boolean read FCloseDataSource write FCloseDataSource;
    { OpenDataSource is kept for backward compatibility only }
    /// <summary>
    ///   Open a data set before report construction is started.
    /// </summary>
    property OpenDataSource: Boolean read FOpenDataSource write FOpenDataSource default True;
    /// <summary>
    ///   A current record number. The first record's number is "0".
    /// </summary>
    property RecNo: Integer read FRecNo;
    /// <summary>
    ///   Reference for the report owner if any.
    /// </summary>
    property ReportRef: TfrxReport read FReportRef write FReportRef;
    /// <summary>
    ///   An event occurs when closing a data set.
    /// </summary>
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    /// <summary>
    ///   An event occurs when opening a data set.
    /// </summary>
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
  published
    /// <summary>
    ///   Defines, if the given component is available from the designer.
    /// </summary>
    property Enabled: Boolean read FEnabled write FEnabled default True;
    /// <summary>
    ///   The navigation start point.
    /// </summary>
    property RangeBegin: TfrxRangeBegin read FRangeBegin write FRangeBegin default rbFirst;
    /// <summary>
    ///   The endpoint of navigation.
    /// </summary>
    property RangeEnd: TfrxRangeEnd read FRangeEnd write FRangeEnd default reLast;
    /// <summary>
    ///   A number of records in the data set, if the "RangeEnd" property =
    ///   reCount.
    /// </summary>
    property RangeEndCount: Integer read FRangeEndCount write FRangeEndCount default 0;
    /// <summary>
    ///   A symbolic name, under which the dataset will be displayed in the
    ///   designer.
    /// </summary>
    property UserName: String read FUserName write SetUserName;
    /// <summary>
    ///   This event's handler must return the Eof = True parameter, if the end
    ///   of the data set is reached.
    /// </summary>
    property OnCheckEOF: TfrxCheckEOFEvent read FOnCheckEOF write FOnCheckEOF;
    /// <summary>
    ///   This event's handler must move the cursor to the beginning of the
    ///   data set.
    /// </summary>
    property OnFirst: TNotifyEvent read FOnFirst write FOnFirst;
    /// <summary>
    ///   This event's handler must move the cursor to the next record.
    /// </summary>
    property OnNext: TNotifyEvent read FOnNext write FOnNext;
    /// <summary>
    ///   This event's handler must move the cursor to the previous record.
    /// </summary>
    property OnPrior: TNotifyEvent read FOnPrior write FOnPrior;
  end;

  TfrxComponentClass = class of TfrxComponent;

  /// <summary>
  ///   Reserved.
  /// </summary>
  TfrxBindableFieldProps = class(TPersistent)
    //
  end;

  { work in progress new aliases }
  {
  TfrxFileld = class(TPersistent)
  private
    FFiledName: String;
    FFieldAlias: String;
//    FBindComponent: TfrxComponentClass;
    FFieldType: TfrxFieldType;
    FFileld: TObject;
    FBindableFieldProps: TfrxBindableFieldProps;
  published
    property FiledName: String read FFiledName write FFiledName;
    property FieldAlias: String read FFieldAlias write FFieldAlias;
//    property BindComponent: TfrxComponentClass read FBindComponent write FBindComponent;
    property FieldType: TfrxFieldType read FFieldType write FFieldType;
    property Fileld: TObject read FFileld write FFileld;
    property BindableProperties: TfrxBindableFieldProps read FBindableFieldProps write FBindableFieldProps;
  end;
  }
  {
  TfrxFieldsStringList = class(TStringList)
  private
    function GetField(Index: Integer): TfrxFileld;
    procedure PutField(Index: Integer; const Value: TfrxFileld);
  public
    property Fields[Index: Integer]: TfrxFileld read GetField write PutField;
  end;
  }

{$IFDEF DELPHI16}
/// <summary>
///   The TfrxUserDataSet component allows constructing reports, which are not
///   connected to DB data, but do receive data from other sources (for
///   example, array, file, etc.). A programmer should only provide navigation
///   in such source (define OnFirst, OnNext, OnPrior, OnCheckEOF events). Data
///   receiving is performed not via this component, but using other ways (for
///   example, via the "TfrxReport.OnGetValue" event). In most cases you can
///   only set the navigation range by setting RangeBegin, RangeEnd,
///   RangeEndCount properties. The current position can be obtained via RecNo
///   property.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxUserDataSet = class(TfrxDataset)
  private
    FFields: TStrings;
    FOnGetValue: TfrxGetValueEvent;
    FOnNewGetValue: TfrxNewGetValueEvent;
    FOnGetBlobValue: TfrxGetBlobValueEvent;
    FOnIsBlobField : TfrxIsBlobFieldEvent;
    procedure SetFields(const Value: TStrings);
  protected
    function GetDisplayText(Index: String): WideString; override;
    function GetValue(Index: String): Variant; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FieldsCount: Integer; override;
    procedure GetFieldList(List: TStrings); override;
    function IsBlobField(const FieldName: String): Boolean; override;
    procedure AssignBlobTo(const FieldName: String; Obj: TObject); override;
  published
    /// <summary>
    ///   List of the fields. These names used in the report designer "Data
    ///   tree".
    /// </summary>
    property Fields: TStrings read FFields write SetFields;
    /// <summary>
    ///   This event is fired when an unknown variable (VarName) is met. An
    ///   eventhandler must return the value of this variable in the Value
    ///   parameter.
    /// </summary>
    property OnGetValue: TfrxGetValueEvent read FOnGetValue write FOnGetValue;
    /// <summary>
    ///   This event is fired when an unknown variable (VarName) is met. An
    ///   event handler must return the value of this variable in the Value
    ///   parameter.New event has a Sender parameter and pass a report objects
    ///   which calls an event.
    /// </summary>
    property OnNewGetValue: TfrxNewGetValueEvent read FOnNewGetValue write FOnNewGetValue;
    /// <summary>
    ///   This event is fired when an unknown variable (VarName) is met and
    ///   IsBlobField event returns True(BLOB type). AssignTo parameter
    ///   contains an object in which data should be loaded (TWideStrings for
    ///   "Text"object).
    /// </summary>
    property OnGetBlobValue: TfrxGetBlobValueEvent read FOnGetBlobValue write FOnGetBlobValue;
    /// <summary>
    ///   An event fires when engine checks type of an assigned field. The
    ///   result tells report engine how to interpret the field with name
    ///   'FileldName'.Returns True if it's a BLOB field. In this case
    ///   OnGetBlobValue event will fire.
    /// </summary>
    property OnIsBlobField: TfrxIsBlobFieldEvent read FOnIsBlobField write FOnIsBlobField;
  end;

  /// <summary>
  ///   The TfrxDBDataSet component is designed for connecting to the DB
  ///   components, which are based on TDataSet, such as "TTable" and "TQuery".
  ///   Such functions as navigation in the data source and referring to fields
  ///   are performed automatically, which means that a programmer does not
  ///   have to worry about it.
  /// </summary>
  TfrxCustomDBDataSet = class(TfrxDataSet)
  private
    FAliases: TStrings;
    FFields: TStringList;
    //TODO
    //FFields: TfrxFieldsStringList;
    //procedure SetFieldAliases(const Value: TfrxFieldsStringList);
    procedure SetFieldAliases(const Value: TStrings);
  protected
    property Fields: TStringList read FFields;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ConvertAlias(const fName: String): String;
    function GetAlias(const fName: String): String;
    function FieldsCount: Integer; override;
  published
    property CloseDataSource;
    //property FieldAliases: TfrxFieldsStringList read FFields write SetFieldAliases;
    /// <summary>
    ///   List of field aliases.
    /// </summary>
    /// <example>
    ///   FieldName1=FieldAlias1 <br />FieldName2=FieldAlias2
    /// </example>
    property FieldAliases: TStrings read FAliases write SetFieldAliases;
    property OpenDataSource;
    property OnClose;
    property OnOpen;
  end;

  TfrxDBComponents = class(TComponent)
  public
    function GetDescription: String; virtual;
  end;

  /// <summary>
  ///   The base class for DB engine components such as TfrxXXXDatabase. Used
  ///   internally in reports.
  /// </summary>
  TfrxCustomDatabase = class(TfrxDialogComponent)
  protected
    procedure BeforeConnect(var Value: Boolean);
    procedure AfterDisconnect;
    procedure SetConnected(Value: Boolean); virtual;
    procedure SetDatabaseName(const Value: String); virtual;
    procedure SetLoginPrompt(Value: Boolean); virtual;
    procedure SetParams(Value: TStrings); virtual;
    function GetConnected: Boolean; virtual;
    function GetDatabaseName: String; virtual;
    function GetLoginPrompt: Boolean; virtual;
    function GetParams: TStrings; virtual;
  public
    /// <summary>
    ///   Converts connection settings to string.
    /// </summary>
    function ToString: WideString{$IFDEF DELPHI12}; reintroduce{$ENDIF}; virtual;
    procedure FromString(const Connection: WideString); virtual;
    /// <summary>
    ///   Sets the login and password required for database connection.
    /// </summary>
    procedure SetLogin(const Login, Password: String); virtual;
    /// <summary>
    ///   Determines whether the connection is active.
    /// </summary>
    property Connected: Boolean read GetConnected write SetConnected default False;
    /// <summary>
    ///   The database name or connection string.
    /// </summary>
    property DatabaseName: String read GetDatabaseName write SetDatabaseName;
    /// <summary>
    ///   Determines whether to show the login dialog when connecting to a
    ///   database. Default value is True.
    /// </summary>
    property LoginPrompt: Boolean read GetLoginPrompt write SetLoginPrompt default True;
    /// <summary>
    ///   Parameters of the connection.
    /// </summary>
    property Params: TStrings read GetParams write SetParams;
  end;

{ Report Objects }

  /// <summary>
  ///   Encapsulate data for fill gaps. Band objects use it as a gap parameter
  ///   for fill object.
  /// </summary>
  TfrxFillGaps = class(TPersistent)
  private
    FTop: Integer;
    FLeft: Integer;
    FBottom: Integer;
    FRight: Integer;
  published
    /// <summary>
    ///   Top gap.
    /// </summary>
    property Top: Integer read FTop write FTop;
    /// <summary>
    ///   Left gap.
    /// </summary>
    property Left: Integer read FLeft write FLeft;
    /// <summary>
    ///   Bottom gap.
    /// </summary>
    property Bottom: Integer read FBottom write FBottom;
    /// <summary>
    ///   Right gap.
    /// </summary>
    property Right: Integer read FRight write FRight;
  end;

  /// <summary>
  ///   Base abstract class for representation of object fills interface. Every
  ///   object fill should inherit from this class.
  /// </summary>
  TfrxCustomFill = class(TPersistent)
  public
//    procedure Assign(Source: TfrxCustomFill); virtual; abstract;
    /// <summary>
    ///   Draw fill on a canvas.
    /// </summary>
    /// <param name="ACanvas">
    ///   Source canvas.
    /// </param>
    /// <param name="X">
    ///   Start X coordinate of draw area.
    /// </param>
    /// <param name="Y">
    ///   Start Y coordinate of draw area.
    /// </param>
    /// <param name="X1">
    ///   End X coordinate of draw area.
    /// </param>
    /// <param name="Y1">
    ///   End Y coordinate of draw area.
    /// </param>
    /// <param name="ScaleX">
    ///   X scale factor.
    /// </param>
    /// <param name="ScaleY">
    ///   Y scale factor.
    /// </param>
    procedure Draw(ACanvas: TCanvas; X, Y, X1, Y1: Integer; ScaleX, ScaleY: Extended); virtual; abstract;
    /// <summary>
    ///   Returns XML string with serialized comparison of stored data between
    ///   two objects( Self and AFill).
    /// </summary>
    function Diff(AFill: TfrxCustomFill; const Add: String): String; virtual; abstract;
  end;

  /// <summary>
  ///   Represents standard brush fill class for all report objects.
  /// </summary>
  TfrxBrushFill = class(TfrxCustomFill)
  private
    FBackColor: TColor;
    FForeColor: TColor;
    FStyle: TBrushStyle;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(ACanvas: TCanvas; X, Y, X1, Y1: Integer; ScaleX, ScaleY: Extended); override;
    function Diff(AFill: TfrxCustomFill; const Add: String): String; override;
  published
    /// <summary>
    ///   Background color.
    /// </summary>
    property BackColor: TColor read FBackColor write FBackColor default clNone;
    /// <summary>
    ///   Fore color for hatch brush.
    /// </summary>
    property ForeColor: TColor read FForeColor write FForeColor default clBlack;
    /// <summary>
    ///   Brush styles.
    /// </summary>
    property Style: TBrushStyle read FStyle write FStyle default bsSolid;
  end;

  /// <summary>
  ///   Represents standard gradient fill class for all report objects.
  /// </summary>
  TfrxGradientFill = class(TfrxCustomFill)
  private
    FStartColor: TColor;
    FEndColor: TColor;
    FGradientStyle: TfrxGradientStyle;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(ACanvas: TCanvas; X, Y, X1, Y1: Integer; ScaleX, ScaleY: Extended); override;
    function Diff(AFill: TfrxCustomFill; const Add: String): String; override;
    function GetColor: TColor;
  published
    /// <summary>
    ///   Begin color of the gradient.
    /// </summary>
    property StartColor: TColor read FStartColor write FStartColor default clWhite;
    /// <summary>
    ///   End color of the gradient.
    /// </summary>
    property EndColor: TColor read FEndColor write FEndColor default clBlack;
    /// <summary>
    ///   Style of the gradient fill.
    /// </summary>
    property GradientStyle: TfrxGradientStyle read FGradientStyle write FGradientStyle;
  end;


  /// <summary>
  ///   Orientation type of glass fill.
  /// </summary>
  TfrxGlassFillOrientation = (
    /// <summary>
    ///   Vertical.
    /// </summary>
    foVertical,
    /// <summary>
    ///   Horizontal.
    /// </summary>
    foHorizontal,
    /// <summary>
    ///   Vertical mirrored.
    /// </summary>
    foVerticalMirror,
    /// <summary>
    ///   Horizontal mirrored.
    /// </summary>
    foHorizontalMirror);

  TfrxGlassFill = class(TfrxCustomFill)
  private
    FColor: TColor;
    FBlend: Extended;
    FHatch: Boolean;
    FOrient: TfrxGlassFillOrientation;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(ACanvas: TCanvas; X, Y, X1, Y1: Integer; ScaleX, ScaleY: Extended); override;
    function Diff(AFill: TfrxCustomFill; const Add: String): String; override;
    function GetColor: TColor;
    function BlendColor: TColor;
    function HatchColor: TColor;
  published
    /// <summary>
    ///   Base color.
    /// </summary>
    property Color: TColor read FColor write FColor default clWhite;
    /// <summary>
    ///   Blend value used in calculation of blend color. Value lays between
    ///   0.0 and 1.0. Highest value means more contrast.
    /// </summary>
    property Blend: Extended read FBlend write FBlend;
    /// <summary>
    ///   Draws hatch lines.
    /// </summary>
    property Hatch: Boolean read FHatch write FHatch default False;
    /// <summary>
    ///   Orientation type of glass fill.
    /// </summary>
    property Orientation: TfrxGlassFillOrientation read FOrient write FOrient default foHorizontal;
  end;


  /// <summary>
  ///   This class encapsulates data for hyperlinks. Some report objects may
  ///   have hyperlink property which can be used to: change location inside a
  ///   report, open HTTP link, open and build detailed report or detailed
  ///   report page.
  /// </summary>
  TfrxHyperlink = class(TPersistent)
  private
    FKind: TfrxHyperlinkKind;
    FDetailReport: String;
    FDetailPage: String;
    FExpression: String;
    FReportVariable: String;
    FValue: String;
    FValuesSeparator: String;
    FTabCaption: String;
    function IsValuesSeparatorStored: Boolean;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Returns XML string with serialized comparison of stored data between
    ///   two objects( Self and ALink).
    /// </summary>
    /// <param name="ALink">
    ///   Base object used to compare properties.
    /// </param>
    /// <param name="Add">
    ///   Additional XML text.
    /// </param>
    function Diff(ALink: TfrxHyperlink; const Add: String): String;
    /// <summary>
    ///   Assigns values of variables declared in ReportVariable property to
    ///   aReport object.
    /// </summary>
    /// <param name="aReport">
    ///   Report object.
    /// </param>
    procedure AssignVariables(aReport: TfrxReport);
    /// <summary>
    ///   Returns True if data for detail reports is not assigned.
    /// </summary>
    function DetailIsEmpty: Boolean;
    /// <summary>
    ///   Returns True if data is not filled and properties have default
    ///   values.
    /// </summary>
    function IsEmpty: Boolean;
  published
    /// <summary>
    ///   Type of hyperlinks supported by report objects.
    /// </summary>
    property Kind: TfrxHyperlinkKind read FKind write FKind default hkURL;
    /// <summary>
    ///   Symbolic link to a detail report.
    /// </summary>
    property DetailReport: String read FDetailReport write FDetailReport;
    /// <summary>
    ///   Symbolic link to a detail page.
    /// </summary>
    property DetailPage: String read FDetailPage write FDetailPage;
    /// <summary>
    ///   Expression for variable declared in ReportVariable property. The
    ///   report Engine calculates it in GetData method. May contain several
    ///   expressions delimited with ValuesSeparator sign(Default ';') like
    ///   &lt;Expr1&gt;;&lt;Expr2&gt;;&lt;Expr3&gt;.
    /// </summary>
    property Expression: String read FExpression write FExpression;
    /// <summary>
    ///   Variable names in destination report which will be used to broadcast
    ///   parameters of one report to another. May contain several variables
    ///   delimited with ValuesSeparator sign(Default ';') like Var1;Var2;Var3.
    ///   <br />
    /// </summary>
    property ReportVariable: String read FReportVariable write FReportVariable;
    /// <summary>
    ///   Caption of the new report tab in the report preview.
    /// </summary>
    property TabCaption: String read FTabCaption write FTabCaption;
    /// <summary>
    ///   Default values for variables declared in ReportVariable property. May
    ///   contain several variables delimited with ValuesSeparator sign(Default
    ///   ';') like Val1;Val2;Val3. <br />
    /// </summary>
    property Value: String read FValue write FValue;
    /// <summary>
    ///   Separator sign. It used in expressions, variables and values as a
    ///   delimiter. Default ';'.
    /// </summary>
    property ValuesSeparator: String read FValuesSeparator write FValuesSeparator stored IsValuesSeparatorStored;
  end;

  /// <summary>
  ///   The TfrxFrameLine class represents the parameters of one line of the
  ///   frame.
  /// </summary>
  TfrxFrameLine = class(TPersistent)
  private
    FFrame: TfrxFrame;
    FColor: TColor;
    FStyle: TfrxFrameStyle;
    FWidth: Extended;
    function IsColorStored: Boolean;
    function IsStyleStored: Boolean;
    function IsWidthStored: Boolean;
  public
    constructor Create(AFrame: TfrxFrame);
    procedure Assign(Source: TPersistent); override;

    /// <summary>
    ///   Returns XML string with serialized comparison of stored data between
    ///   two objects( Self and ALine). <br />
    /// </summary>
    function Diff(ALine: TfrxFrameLine; const LineName: String;
      ColorChanged, StyleChanged, WidthChanged: Boolean): String;
  published
    /// <summary>
    ///   Color of the line.
    /// </summary>
    property Color: TColor read FColor write FColor stored IsColorStored;
    /// <summary>
    ///   Style of the line.
    /// </summary>
    property Style: TfrxFrameStyle read FStyle write FStyle stored IsStyleStored;
    /// <summary>
    ///   Width of the line.
    /// </summary>
    property Width: Extended read FWidth write FWidth stored IsWidthStored;
  end;


  /// <summary>
  ///   The TfrxFrame class represents a frame. Almost all Frx visual objects
  ///   have a frame.
  /// </summary>
  TfrxFrame = class(TPersistent)
  private
    FLeftLine: TfrxFrameLine;
    FTopLine: TfrxFrameLine;
    FRightLine: TfrxFrameLine;
    FBottomLine: TfrxFrameLine;
    FColor: TColor;
    FDropShadow: Boolean;
    FShadowWidth: Extended;
    FShadowColor: TColor;
    FStyle: TfrxFrameStyle;
    FTyp: TfrxFrameTypes;
    FWidth: Extended;
    function IsShadowWidthStored: Boolean;
    function IsTypStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetBottomLine(const Value: TfrxFrameLine);
    procedure SetLeftLine(const Value: TfrxFrameLine);
    procedure SetRightLine(const Value: TfrxFrameLine);
    procedure SetTopLine(const Value: TfrxFrameLine);
    procedure SetColor(const Value: TColor);
    procedure SetStyle(const Value: TfrxFrameStyle);
    procedure SetWidth(const Value: Extended);
  public
    /// <summary>
    ///   Constructor.
    /// </summary>
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Assigns properties from other frame object.
    /// </summary>
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Returns XML string with serialized comparison of stored data between
    ///   two objects( Self and AFrame). <br />
    /// </summary>
    function Diff(AFrame: TfrxFrame): String;
    /// <summary>
    ///   Draws frame on a Canvas.
    /// </summary>
    /// <param name="Canvas">
    ///   Source canvas.
    /// </param>
    /// <param name="FX">
    ///   X start coordinate.
    /// </param>
    /// <param name="FY">
    ///   Y start coordinate.
    /// </param>
    /// <param name="FX1">
    ///   X end coordinate.
    /// </param>
    /// <param name="FY1">
    ///   Y end coordinate. <br />
    /// </param>
    /// <param name="ScaleX">
    ///   X scale factor.
    /// </param>
    /// <param name="ScaleY">
    ///   Y scale factor.
    /// </param>
    procedure Draw(Canvas: TCanvas; FX, FY, FX1, FY1: Integer; ScaleX, ScaleY: Extended);
  published
    /// <summary>
    ///   Color of frame.
    /// </summary>
    property Color: TColor read FColor write SetColor default clBlack;
    /// <summary>
    ///   Determines whether to draw a shadow.
    /// </summary>
    property DropShadow: Boolean read FDropShadow write FDropShadow default False;
    /// <summary>
    ///   Color of shadow.
    /// </summary>
    property ShadowColor: TColor read FShadowColor write FShadowColor default clBlack;
    /// <summary>
    ///   Width of shadow.
    /// </summary>
    property ShadowWidth: Extended read FShadowWidth write FShadowWidth stored IsShadowWidthStored;
    /// <summary>
    ///   Style of frame.
    /// </summary>
    property Style: TfrxFrameStyle read FStyle write SetStyle default fsSolid;
    /// <summary>
    ///   Set of frame lines.
    /// </summary>
    property Typ: TfrxFrameTypes read FTyp write FTyp stored IsTypStored;
    /// <summary>
    ///   Width of frame.
    /// </summary>
    property Width: Extended read FWidth write SetWidth stored IsWidthStored;
    /// <summary>
    ///   Left line of the frame.
    /// </summary>
    property LeftLine: TfrxFrameLine read FLeftLine write SetLeftLine;
    /// <summary>
    ///   Top line of the frame.
    /// </summary>
    property TopLine: TfrxFrameLine read FTopLine write SetTopLine;
    /// <summary>
    ///   Right line of the frame.
    /// </summary>
    property RightLine: TfrxFrameLine read FRightLine write SetRightLine;
    /// <summary>
    ///   Bottom line of the frame.
    /// </summary>
    property BottomLine: TfrxFrameLine read FBottomLine write SetBottomLine;
  end;



//  TfrxWatermark = class(TPersistent)
//  private
//    FVisibility: TfrxVisibilityTypes;
//    FTextFont: TFont;
//    FImage:
//    FImageTransparentColor
//    FShowImageOnTop
//    ShowTextOnTop
//    Text
//    TextFill
//    TextRotation
//
//  Visible
//Font
//Image
//ImageTransparentColor
//ShowImageOnTop
//ShowTextOnTop
//Text
//TextFill
//TextRotation
//  end;

  /// <summary>
  ///   The TfrxView class is the basic one for most components, which can be
  ///   placed on a report design page. An object of this type has parameters
  ///   such as "Frame" and "Color" and also can be connected to the data
  ///   source. Practically all FastReport standard objects are inherited from
  ///   this class.
  /// </summary>
  TfrxView = class(TfrxReportComponent)
  private
    FAlign: TfrxAlign;
    FCursor: TCursor;
    FDataField: String;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FFrame: TfrxFrame;
    FShiftMode: TfrxShiftMode;
    FTagStr: String;
    FTempTag: String;
    FTempHyperlink: String;
    FHint: String;
    FShowHint: Boolean;
    FURL: String;
    FPlainText: Boolean;
    FHyperlink: TfrxHyperlink;
    FFill: TfrxCustomFill;
    FVisibility: TfrxVisibilityTypes;
    FDrawAsMask: Boolean;
    FAllowVectorExport: Boolean;
    {  interactive script events  }
    FOnMouseEnter: TfrxMouseEnterViewEvent;
    FOnMouseLeave: TfrxMouseLeaveViewEvent;
    FOnMouseDown: TfrxMouseEvent;
    FOnMouseMove: TfrxMouseMoveEvent;
    FOnMouseUp: TfrxMouseEvent;
    procedure SetFrame(const Value: TfrxFrame);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
    procedure SetFillType(const Value: TfrxFillType);
    function GetFillType: TfrxFillType;
    procedure SetBrushStyle(const Value: TBrushStyle);
    function GetBrushStyle: TBrushStyle;
    procedure SetColor(const Value: TColor);
    function GetColor: TColor;
    procedure SetHyperLink(const Value: TfrxHyperlink);
    procedure SetFill(const Value: TfrxCustomFill);
    procedure SetURL(const Value: String);
    function GetPrintable: Boolean;
    procedure SetPrintable(Value: Boolean);
    procedure SetProcessing(const Value: TfrxObjectProcessing);
  protected
    FX: Integer;
    FY: Integer;
    FX1: Integer;
    FY1: Integer;
    FDX: Integer;
    FDY: Integer;
    FFrameWidth: Integer;
    FScaleX: Extended;
    FScaleY: Extended;
    FOffsetX: Extended;
    FOffsetY: Extended;
    FCanvas: TCanvas;
    FProcessing: TfrxObjectProcessing;
    FObjAsMetafile: Boolean;
    FDrawFillOnMetaFile: Boolean;
    FVC: TVectorCanvas;
    FStyle: TfrxStyleName;
    procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); virtual;
    procedure DrawBackground; virtual;
    procedure DrawFrame; virtual;
    procedure DrawFrameEdges;
    procedure DrawLine(x, y, x1, y1, w: Integer);
    procedure ExpandVariables(var Expr: String; ARaiseException: Boolean = True);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure GetScreenScale(var aScaleX, aScaleY: Extended);
    procedure SetStyle(const Value: TfrxStyleName); virtual;
    { interactive object behaviour }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    ///   Applies the given style to the object.
    /// </summary>
    /// <param name="Style">
    ///   Style.
    /// </param>
    procedure ApplyStyle(Style: TfrxCustomStyleItem); virtual;
    procedure AssignToStyle(Style: TfrxCustomStyleItem); virtual;
    function Diff(AComponent: TfrxComponent): String; override;
    /// <summary>
    ///   Highlighting a component.
    /// </summary>
    procedure Highlighting(Canvas: TCanvas; AColor: TColor);
    /// <summary>
    ///   Returns True when report object has assigned DataSet and DataField.
    /// </summary>
    function IsDataField: Boolean;
    /// <summary>
    ///   Through this method objects tell the export engine that it allows
    ///   export via meta file output. When function returns False object will
    ///   be exported as picture or via native processing(if supported).
    /// </summary>
    function IsEMFExportable: Boolean; virtual;
    function IsAcceptAsChild(aParent: TfrxComponent): Boolean; override;
    /// <summary>
    ///   Returns vector graphic image derived from TGraphic (Currently
    ///   supports meta file) with object output on it.
    /// </summary>
    /// <param name="DrawFill">
    ///   If True , object draws fill on result vector image.
    /// </param>
    function GetVectorGraphic(DrawFill: Boolean = False): TGraphic; overload; virtual;
    function GetVectorGraphic(DrawFill: Boolean; AScaleX, AScaleY: Double): TGraphic; overload; virtual;
    /// <summary>
    ///   Returns TVectorCanvas used for export engine. <br />
    /// </summary>
    function GetVectorCanvas: TVectorCanvas; virtual;
    procedure DrawHighlight(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; hlColor: TColor = clNone); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    /// <summary>
    ///   Draw object with clip bounds on. Any output behind bounds cuts off.
    ///   By default just calls standard Draw method. Used for some objects.
    /// </summary>
    procedure DrawClipped(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); virtual;
    procedure BeforePrint; override;
    procedure GetData; override;
    /// <summary>
    ///   Deprecated. Used to get scale factor of object content for export
    ///   filters.
    /// </summary>
    procedure GetScaleFactor(var ScaleX: Extended; var ScaleY: Extended); virtual;
    procedure MirrorContent(MirrorModes: TfrxMirrorControlModes); override;

    procedure AfterPrint; override;
    /// <summary>
    ///   Calculates size of dropped shadows.
    /// </summary>
    function ShadowSize: Extended; // In order to not test DropShadow every time

    { post processing interfaces }
    /// <summary>
    ///   This method used by the report engine when adds object to preview
    ///   pages when object has post-processing enabled. It should save
    ///   expression from current object in PostProcessor instance and save
    ///   returned index in current object.
    /// </summary>
    /// <param name="aReport">
    ///   Reference to the report object.
    /// </param>
    /// <param name="PostProcessor">
    ///   Reference to TfrxPostProcessor instance of post processing manager.
    /// </param>
    procedure SaveContentToDictionary(aReport: TfrxReport; PostProcessor: TfrxPostProcessor); virtual;
    /// <summary>
    ///   Method loads data from post-processor item (aItem) to current object
    ///   based on index stored before during SaveContentToDictionary function
    ///   call.
    /// </summary>
    /// <param name="aReport">
    ///   Reference to the report object.
    /// </param>
    /// <param name="aItem">
    ///   TfrxMacrosItem which stores processed data for current object.
    /// </param>
    function LoadContentFromDictionary(aReport: TfrxReport; aItem: TfrxMacrosItem): Boolean; virtual;
    /// <summary>
    ///   The report engine call this method when event specified in
    ///   Processing.ProcessAt occurs. It retrieves saved expression from <br />
    ///   PostProcessor by index saved during SaveContentToDictionary call and
    ///   calculates expression(calls to GetData). The result saves back to
    ///   PostProcessor for future use in LoadContentFromDictionary. <br />
    /// </summary>
    procedure ProcessDictionary(aItem: TfrxMacrosItem; aReport: TfrxReport; PostProcessor: TfrxPostProcessor); virtual;
    /// <summary>
    ///   Return True when post processing for current object is enabled
    ///   (Default ProcessAt &lt;&gt; paDefault). <br />
    /// </summary>
    function IsPostProcessAllowed: Boolean; virtual;
    { end post process interfaces}

    /// <summary>
    ///   Object fill type.
    /// </summary>
    property FillType: TfrxFillType read GetFillType write SetFillType default ftBrush;
    /// <summary>
    ///   Reference to fill instance based on FillType.
    /// </summary>
    property Fill: TfrxCustomFill read FFill write SetFill;
    /// <summary>
    ///   Object's filling style (deprecated check Fill property). <br />
    /// </summary>
    property BrushStyle: TBrushStyle read GetBrushStyle write SetBrushStyle stored False;
    /// <summary>
    ///   Object's filling color (deprecated check Fill property). <br />
    /// </summary>
    property Color: TColor read GetColor write SetColor stored False;
    /// <summary>
    ///   Data field's name, which the object is connected to.
    /// </summary>
    property DataField: String read FDataField write FDataField;
    /// <summary>
    ///   Data source, which the object is connected to.
    /// </summary>
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    /// <summary>
    ///   Name of data source, which the object is connected to. This property
    ///   duplicates the DataSet property.
    /// </summary>
    property DataSetName: String read GetDataSetName write SetDataSetName;
    /// <summary>
    ///   Object's frame.
    /// </summary>
    property Frame: TfrxFrame read FFrame write SetFrame;
    /// <summary>
    ///   Used in export matrix to get a plain text of object.
    /// </summary>
    property PlainText: Boolean read FPlainText write FPlainText;
    /// <summary>
    ///   Object's cursor (in the preview mode).
    /// </summary>
    property Cursor: TCursor read FCursor write FCursor default crDefault;
    /// <summary>
    ///   The field for storing different information. This property can
    ///   contain an expression in square brakets which will be calculated when
    ///   report runs.
    /// </summary>
    property TagStr: String read FTagStr write FTagStr;
    /// <summary>
    ///   Object's URL (Deprecated. Check HyperLink property). Determines what
    ///   action will occur when a user clicks this <br />object in the preview
    ///   window. The property may contain string like: <br />- '@number' -
    ///   jumps to specified page number;/n <br />- '#name' - jumps to
    ///   specified anchor;/n <br />- 'mailto:', 'htpp:', 'ftp:' - execute
    ///   shell command./n/n <br />The property may contain an expression in
    ///   square brakets which will be calculated when report runs.
    /// </summary>
    property URL: String read FURL write SetURL stored False;
    /// <summary>
    ///   Internal use. The export engine uses it to generate transparency mask
    ///   of object.
    /// </summary>
    property DrawAsMask: Boolean read FDrawAsMask write FDrawAsMask;
    /// <summary>
    ///   Defines how the report engine should process all expressions and
    ///   GetData calls for current object. It controls post processing of
    ///   expressions inside objects.
    /// </summary>
    property Processing: TfrxObjectProcessing read FProcessing write SetProcessing;
        /// <summary>
    ///   Name of the object's style. Styles are stored in the
    ///   TfrxReport.Styles.
    /// </summary>
    property Style: TfrxStyleName read FStyle write SetStyle;
  published
    property Anchors;
    property AllowMirrorMode;
    /// <summary>
    ///   Object's aligning relatively to its parent.
    /// </summary>
    property Align: TfrxAlign read FAlign write FAlign default baNone;
    /// <summary>
    ///   This object can be exported through vector graphic processor(meta
    ///   file) if object and export filter supports it.
    /// </summary>
    property AllowVectorExport: Boolean read FAllowVectorExport write FAllowVectorExport;
    /// <summary>
    ///   Defines whether the given object should be printed out (Deprecated
    ///   check Visibility property).
    /// </summary>
    property Printable: Boolean read GetPrintable write SetPrintable stored False default True;
    /// <summary>
    ///   The mode of object's shifting in cases when a stretchable object is
    ///   placed over the given one
    /// </summary>
    property ShiftMode: TfrxShiftMode read FShiftMode write FShiftMode default smAlways;
    property Left;
    property Top;
    property Width;
    property Height;
    property GroupIndex;
    property Editable;
    property Restrictions;
    property Visible;
    property OnAfterData;
    property OnAfterPrint;
    property OnBeforePrint;
    property OnContentChanged;
    /// <summary>
    ///   The name of the script routine that will be called when mouse cursor
    ///   in the report preview enters object area.
    /// </summary>
    property OnMouseEnter: TfrxMouseEnterViewEvent read FOnMouseEnter write FOnMouseEnter;
    /// <summary>
    ///   The name of the script routine that will be called when mouse cursor
    ///   in the report preview leaves object area.
    /// </summary>
    property OnMouseLeave: TfrxMouseLeaveViewEvent read FOnMouseLeave write FOnMouseLeave;
    /// <summary>
    ///   The name of the script routine that will be called when user push
    ///   mouse button in the report preview on current object.
    /// </summary>
    property OnMouseDown: TfrxMouseEvent read FOnMouseDown write FOnMouseDown;
    /// <summary>
    ///   The name of the script routine that will be called when user move
    ///   mouse pointer in the report preview over current object.
    /// </summary>
    property OnMouseMove: TfrxMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    /// <summary>
    ///   The name of the script routine that will be called when user release
    ///   mouse button in the report preview on current object.
    /// </summary>
    property OnMouseUp: TfrxMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnPreviewClick;
    property OnPreviewDblClick;
    /// <summary>
    ///   The report object hyperlink property which can be used to: change
    ///   location inside a report, open HTTP link, open and build detailed
    ///   report or detailed report page.
    /// </summary>
    property Hyperlink: TfrxHyperlink read FHyperlink write SetHyperLink;
    /// <summary>
    ///   The hint, shows when hold mouse pointer at object.
    /// </summary>
    property Hint: String read FHint write FHint;
    /// <summary>
    ///   Show/hide hint.
    /// </summary>
    property ShowHint: Boolean read FShowHint write FShowHint default False;
    /// <summary>
    ///   Visibility of object in the result report.
    /// </summary>
    property Visibility: TfrxVisibilityTypes read FVisibility write FVisibility default [vsPreview, vsExport, vsPrint];
  end;

  /// <summary>
  ///   The TfrxStretcheable class is the basic one for writing components,
  ///   which modify their height depending on the data placed in them. Objects
  ///   of the given class can be not only stretched, but they can also be
  ///   "broken" into pieces in cases when an object does not find room on the
  ///   page. At the same time, the object is displayed piecemeal until all its
  ///   data is displayed.
  /// </summary>
  TfrxStretcheable = class(TfrxView)
  private
    FStretchMode: TfrxStretchMode;
    FCanShrink: Boolean;
  public
    /// <summary>
    ///   Internal use only. Stores object Height during stretch operation.
    /// </summary>
    FSaveHeight: Extended;
    /// <summary>
    ///   Internal use only. Stores original top during shift operation.
    /// </summary>
    FSavedTop: Extended;
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    ///   Calculates and returns the object's height according to the data
    ///   placed in it.
    /// </summary>
    function CalcHeight: Extended; virtual;
    /// <summary>
    ///   Objects part drawing function , if the object is splittable.
    /// </summary>
    function DrawPart: Extended; virtual;
    /// <summary>
    ///   Initialize part of Splittable object.
    /// </summary>
    procedure InitPart; virtual;
    /// <summary>
    ///   Returns True if object has a part to draw on a new page.
    /// </summary>
    /// <param name="aFreeSpace">
    ///   Free space on current page.
    /// </param>
    function HasNextDataPart(aFreeSpace: Extended): Boolean; virtual;
    function GetLastShiftAmount(aFreeSpace: Extended): Extended; virtual;
  published
    /// <summary>
    ///   True if object can shrink height base on its content.
    /// </summary>
    property CanShrink: Boolean read FCanShrink write FCanShrink default False;
    /// <summary>
    ///   Object's stretch mode.
    /// </summary>
    property StretchMode: TfrxStretchMode read FStretchMode write FStretchMode
      default smDontStretch;
  end;

  /// <summary>
  ///   Reserved.
  /// </summary>
  TfrxInteractiveHighlightEvent = (ihNone, ihClick, ihEnter, ieLeave);

  /// <summary>
  ///   The TfrxHighlight class holds the conditional highlight settings. The
  ///   conditional highlight is used in the TfrxMemoView object and allows
  ///   changing the font and color settings depending on some condition.
  /// </summary>
  TfrxHighlight = class(TfrCollectionItem)
  private
    FActive: Boolean;
    FApplyFont: Boolean;
    FApplyFill: Boolean;
    FApplyFrame: Boolean;
    FCondition: String;
    FFont: TFont;
    FFill: TfrxCustomFill;
    FFrame: TfrxFrame;
    FVisible: Boolean;
    FInteractiveType: TfrxInteractiveHighlightEvent;
    procedure SetFont(const Value: TFont);
    procedure SetFill(const Value: TfrxCustomFill);
    procedure SetFillType(const Value: TfrxFillType);
    function GetFillType: TfrxFillType;
    procedure SetColor(const Value: TColor);
    function GetColor: TColor;
    procedure SetFrame(const Value: TfrxFrame);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    /// <summary>
    ///   Copies all properties from other object.
    /// </summary>
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   True if instance should generate unique name before serialization.
    ///   Used in inherit mechanism for unnamed collections.
    /// </summary>
    function IsUniqueNameStored: Boolean; override;
  published
    // backward compatibility
    /// <summary>
    ///   Highlight's font. Determines whether the highlight is active. When active,
    ///   the TfrxMemoView object uses highlight settings.
    /// </summary>
    property Active: Boolean read FActive write FActive stored False default False;
    /// <summary>
    ///   Deprecated. Apply font styles to the object. <br />
    /// </summary>
    property ApplyFont: Boolean read FApplyFont write FApplyFont default True;
    /// <summary>
    ///   Deprecated. Apply Fill to the object. <br />
    /// </summary>
    property ApplyFill: Boolean read FApplyFill write FApplyFill default True;
    /// <summary>
    ///   Deprecated. Apply frame to the object. <br />
    /// </summary>
    property ApplyFrame: Boolean read FApplyFrame write FApplyFrame default False;
    /// <summary>
    ///   Highlight's font.
    /// </summary>
    property Font: TFont read FFont write SetFont;
    // backward compatibility
    /// <summary>
    ///   Highlight's color.
    /// </summary>
    property Color: TColor read GetColor write SetColor stored False default clNone;
    /// <summary>
    ///   Highlight's condition. Contains any valid expression.
    /// </summary>
    property Condition: String read FCondition write FCondition;
    /// <summary>
    ///   Reserved.
    /// </summary>
    property InteractiveType: TfrxInteractiveHighlightEvent read FInteractiveType write FInteractiveType default ihNone;
 	  /// <summary>
 	  ///   Highlight's Fill type.
 	  /// </summary>
 	  property FillType: TfrxFillType read GetFillType write SetFillType;
    /// <summary>
    ///   Highlight's Fill object.
    /// </summary>
    property Fill: TfrxCustomFill read FFill write SetFill;
    /// <summary>
    ///   Highlight's frame object.
    /// </summary>
    property Frame: TfrxFrame read FFrame write SetFrame;
    /// <summary>
    ///   Visibility of Highlight.
    /// </summary>
    property Visible: Boolean read FVisible write FVisible default True;
  end;

  /// <summary>
  ///   Collection of TfrxHighlight. Each object can hold several highlights
  ///   which serves different conditions.
  /// </summary>
  TfrxHighlightCollection = class(TfrCollection)
  private
    function GetItem(Index: Integer): TfrxHighlight;
  public
    constructor Create;
    /// <summary>
    ///   TfrxHighlight items.
    /// </summary>
    property Items[Index: Integer]: TfrxHighlight read GetItem; default;
  end;

  /// <summary>
  ///   The constructor. Do not call it directly because an instance of this
  ///   class is stored in the TfrxCustomMemoView.DisplayFormat.
  /// </summary>
  TfrxFormat = class(TCollectionItem)
  private
    FDecimalSeparator: String;
    FThousandSeparator: String;
    FFormatStr: String;
    FKind: TfrxFormatKind;
  public
    procedure Assign(Source: TPersistent); override;
  published
    /// <summary>
    ///   Decimal separator symbol. This symbol is used when the Kind property
    ///   is set to fkNumeric. If this property is empty, default separator is
    ///   used.
    /// </summary>
    property DecimalSeparator: String read FDecimalSeparator write FDecimalSeparator;
    /// <summary>
    ///   Thousand separator symbol. It is used when numbers formatting (Kind
    ///   property =fk Numeric).
    /// </summary>
    property ThousandSeparator: String read FThousandSeparator write FThousandSeparator;
    /// <summary>
    ///   Formatting string in every case is an argument for the function, with
    ///   the help of which formatting is accomplished. Thus, for numerical
    ///   formatting, such function would be the Delphi's Format function, for
    ///   date/time it is the FormatDateTime function. One can get the possible
    ///   values from the Delphi help system. Below are several values used in
    ///   FastReport: <br />for the numerical formatting: <br />%g - a number
    ///   with the minimal signs number after decimal point; <br />%2.2f - a
    ///   number with the fixed number of signs after decimal point; <br />
    ///   %2.2n - a number with bits delimiter; <br />%2.2m - a monetary
    ///   format, accepted in the Windows OS, depending on the regional
    ///   settings in the control panel. <br />for the date/time format: <br />
    ///   dd.mm.yyyy - date of the 23.12.2003 type; <br />dd mmm yyyy - date of
    ///   the 23 Nov. 2003 type; <br />dd mmmm yyyy - date of the 23 November
    ///   2003 type; <br />hh:mm - time of the 23:12 type; <br />hh:mm:ss -
    ///   time of the 23:12:00 type; <br />dd mmmm yyyy, hh:mm - time and date
    ///   of the 23 November 2003, 23:12 type. <br />As for formatting of the
    ///   boolean type, the formatting string is presented as two values
    ///   separated by comma. The first value corresponds to "False," the
    ///   second one corresponds to "True".
    /// </summary>
    property FormatStr: String read FFormatStr write FFormatStr;
    /// <summary>
    ///   Kind of formatting.
    /// </summary>
    property Kind: TfrxFormatKind read FKind write FKind default fkText;
  end;

  /// <summary>
  ///   Collection of TfrxFormat. An object can hold several <br />formats
  ///   which serves different expressions. <br />
  /// </summary>
  TfrxFormatCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TfrxFormat;
  public
    constructor Create;
    /// <summary>
    ///   Format items array.
    /// </summary>
    property Items[Index: Integer]: TfrxFormat read GetItem; default;
  end;


  // internal Type move to TfrxCustomMemoView
  TfrxCustomMemoViewBehaviourFlag = (mbfAllowExpressions, mbfAllowHTMLTags,
    mbfAutoWidth, mbfClipped, mbfFirstParaBreak, mbfLastParaBreak,
    mbfRTLReading, mbfSuppressRepeated, mbfWordBreak, mbfWordWrap, mbfWysiwyg,
    mbfUseDefaultCharset, mbfHighlightActivated, mbfMacroLoaded,
    mbfClearEmptyLines, mbfHideZeros);
  TfrxCustomMemoViewBehaviourFlags = set of TfrxCustomMemoViewBehaviourFlag;
  /// <summary>
  ///   The TfrxCustomMemoView class is the base class for the "Text", "System
  ///   text" and "Dot-matrix text" objects. This object represents a
  ///   rectangular area with the multiline text inside.
  /// </summary>
  TfrxCustomMemoView = class(TfrxStretcheable, IfrxDataLinkObject)
  private
    FCharSpacing: Extended;
    FFormats: TfrxFormatCollection;
    FExpressionDelimiters: String;
    FFlowTo: TfrxCustomMemoView;
    FGapX: Extended;
    FGapY: Extended;
    FHAlign: TfrxHAlign;
    FHighlights: TfrxHighlightCollection;
    FLineSpacing: Extended;
    FMemo: TWideStrings;
    FParagraphGap: Extended;
    FRotation: Integer;
    FDuplicates: TfrxDuplicateMerge;
    FDataLink: TfrxDataLink;

    FTempMemo: WideString;
    FUnderlinesTextMode: TfrxUnderlinesTextMode;
    FVAlign: TfrxVAlign;
    FValue: Variant;
    FTempFill: TfrxCustomFill;
    FTempFont: TFont;
    FTempFrame: TfrxFrame;
    FTempVisible: Boolean;
    FScaledRect: TRect;
    FMemoBehaviourFlags: TfrxCustomMemoViewBehaviourFlags;
    procedure SetMemo(const Value: TWideStrings);
    procedure SetRotation(Value: Integer);
    procedure SetAnsiText(const Value: AnsiString);
    function AdjustCalcHeight: Extended;
    function AdjustCalcWidth: Extended;
    function GetAnsiText: AnsiString;
    function IsExprDelimitersStored: Boolean;
    function IsLineSpacingStored: Boolean;
    function IsGapXStored: Boolean;
    function IsGapYStored: Boolean;
    function IsHighlightStored: Boolean;
    function IsDisplayFormatStored: Boolean;
    function IsParagraphGapStored: Boolean;
    function GetHighlight: TfrxHighlight;
    function GetDisplayFormat: TfrxFormat;
    procedure SetHighlight(const Value: TfrxHighlight);
    procedure SetDisplayFormat(const Value: TfrxFormat);
    function IsCharSpacingStored: Boolean;
    procedure WriteFormats(Writer: TWriter);
    procedure WriteHighlights(Writer: TWriter);
    procedure ReadFormats(Reader: TReader);
    procedure ReadHighlights(Reader: TReader);
    procedure SavePreHighlightState;
    procedure RestorePreHighlightState;
    function GetUnderlines: Boolean;
    procedure SetUnderlines(const Value: Boolean);
    function GetDataLink: TfrxDataLink;
    function IsDataLinkStored: Boolean;
    procedure SetDataLink(const Value: TfrxDataLink);
    function GetFlagValue(const Index: Integer): Boolean;
    procedure SetFlagValue(const Index: Integer; const Value: Boolean);
    procedure CalculateAutoWidth(ADrawText: TObject);
  protected
    FPartMemo: WideString;
    FLastValue: Variant;
    FTotalPages: Integer;
    FCopyNo: Integer;
    FTextRect: TRect;
    FPrintScale: Extended;
    FMacroIndex: Integer;
    FMacroLine: Integer;
    procedure Loaded; override;
    function CalcAndFormat(const Expr: WideString; Format: TfrxFormat): WideString;
    function CalcTextRect(OffsetX, OffsetY, ScaleX, ScaleY: Extended): TRect;

    procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure SetDrawParams(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
    procedure DrawText;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetText: WideString; virtual;
    function GetValue: Variant; virtual;
    procedure SetText(const Value: WideString); virtual;
    procedure SetPartMemoText(const Value: WideString); virtual;

    function LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
    function GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
    function IsExpressionLink: Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    function Diff(AComponent: TfrxComponent): String; override;
    function DiffText(AComponent: TfrxComponent): String; virtual;
    function HasOutboundContent: Boolean;
    function CalcHeight: Extended; override;
    /// <summary>
    ///   Calculates and returns the object's width, in pixels.
    /// </summary>
    function CalcWidth: Extended; virtual;
    function DrawPart: Extended; override;
    procedure WriteNestedProperties(Item: TfrXMLItem; aAcenstor: TPersistent = nil); override;
    function ReadNestedProperty(Item: TfrXMLItem): Boolean; override;
    /// <summary>
    ///   Apply active highlight for object in prepared report.
    /// </summary>
    procedure ApplyPreviewHighlight;

    procedure SaveContentToDictionary(aReport: TfrxReport; PostProcessor: TfrxPostProcessor); override;
    function LoadContentFromDictionary(aReport: TfrxReport; aItem: TfrxMacrosItem): Boolean; override;
    procedure ProcessDictionary(aItem: TfrxMacrosItem; aReport: TfrxReport; PostProcessor: TfrxPostProcessor); override;
    function IsPostProcessAllowed: Boolean; override;

    { interactive object behaviour }
    procedure DoMouseEnter(aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseLeave(aNextObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams); override;

    procedure MirrorContent(MirrorModes: TfrxMirrorControlModes); override;
    function GetComponentText: String; override;
    /// <summary>
    ///   Formats the value passed in the "Value" parameter and returns the
    ///   result as a string. This method is used format settings stored in the
    ///   DisplayFormat property. If AFormat parameter is set, it is used for
    ///   formatting instead of DisplayFormat property.
    /// </summary>
    function FormatData(const Value: Variant; AFormat: TfrxFormat = nil): WideString;
    // when aParaText is not nil function fills stringlist with paragraph indents in Objects property
    // 1 - begin of paragraph, 2 - end of paragraph, 3 -  both begin and end at one line, 0 - continue of paragraph
    /// <summary>
    ///   Breaks the text so all strings would fit in the object's width, and
    ///   returns the resulting text.
    /// </summary>
    /// <param name="WrapWords">
    ///   Wrap words if possible.
    /// </param>
    /// <param name="aParaText">
    ///   If not nil , holds result of function in TWideStrings with paragraph
    ///   marks.
    /// </param>
    function WrapText(WrapWords: Boolean; aParaText: TWideStrings = nil): WideString;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure BeforePrint; override;
    procedure GetData; override;
    procedure AfterPrint; override;
    procedure InitPart; override;
    /// <summary>
    ///   Apply Highlight to object.
    /// </summary>
    /// <param name="AHighlight">
    ///   Highlight.
    /// </param>
    procedure ApplyHighlight(AHighlight: TfrxHighlight);
    /// <summary>
    ///   Extract macros from the object text and replaces them with values.
    /// </summary>
    procedure ExtractMacros(Dictionary: TfrxPostProcessor = nil);
    /// <summary>
    ///   Deprecated. Reset suppressed values.
    /// </summary>
    procedure ResetSuppress;
    /// <summary>
    ///   Normalize angle to 360 degrees.
    /// </summary>
    function ReducedAngle: Integer; // 0..359
    procedure UpdateBounds; override;
    /// <summary>
    ///   Text of the object.
    /// </summary>
    property Text: WideString read GetText write SetText;
    /// <summary>
    ///   Text of the object in ANSI format based on current Locale settings.
    /// </summary>
    property AnsiText: AnsiString read GetAnsiText write SetAnsiText;
    /// <summary>
    ///   Stores value of Format operation(for single expression or DataSet
    ///   only) with respect of its type.
    /// </summary>
    property Value: Variant read GetValue write FValue;
    // analogue of Memo property
    /// <summary>
    ///   Text lines of the object.
    /// </summary>
    property Lines: TWideStrings read FMemo write SetMemo;

    /// <summary>
    ///   Determines if the object may contain expressions inside the text.
    ///   Expressions are enclosed in the square brackets (by default). The
    ///   ExpressionDelimiters defines which symbols to use for detecting the
    ///   expression. Default value is True.
    /// </summary>
    property AllowExpressions: Boolean index Integer(mbfAllowExpressions) read GetFlagValue write SetFlagValue default True;
    /// <summary>
    ///   Determines if the object may contain HTML-tags inside the text. <br />
    ///   The following tags are supported: <br />&lt;b&gt; - bold; <br />
    ///   &lt;i&gt; - italic; <br />&lt;u&gt; - underline; <br />&lt;sub&gt; -
    ///   bottom index; <br />&lt;sup&gt; - top index; <br />&lt;font color&gt;
    ///   - font color. <br />Default value is False.
    /// </summary>
    property AllowHTMLTags: Boolean index Integer(mbfAllowHTMLTags) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Determines if the text object should handle its width automatically.
    /// </summary>
    property AutoWidth: Boolean index Integer(mbfAutoWidth) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Character spacing, in pixels. Default value is 0.
    /// </summary>
    property CharSpacing: Extended read FCharSpacing write FCharSpacing stored IsCharSpacingStored;
    /// <summary>
    ///   Deletes empty lines which only have line break at the end after object gets data.
    /// </summary>
    property ClearEmptyLines: Boolean index Integer(mbfClearEmptyLines) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Determines whether to clip the text on object's bounds.
    /// </summary>
    property Clipped: Boolean index Integer(mbfClipped) read GetFlagValue write SetFlagValue default True;
    /// <summary>
    ///   Deprecated(Check Formats property). Format settings. Used for
    ///   formatting expression's values <br />or DB fields which object is
    ///   linked to. <br />
    /// </summary>
    property DisplayFormat: TfrxFormat read GetDisplayFormat write SetDisplayFormat stored IsDisplayFormatStored;
    property DataLink: TfrxDataLink read GetDataLink write SetDataLink stored IsDataLinkStored;
    /// <summary>
    ///   Set of symbols, designating the expression. Default value is '[,]'.
    ///   The comma divides opening and closing symbols. There is one
    ///   limitation however: the opening and closing symbols cannot be
    ///   similar, so '%,%' will not work. One can set several symbols, for
    ///   example '&lt;%,%&gt;'.
    /// </summary>
    property ExpressionDelimiters: String read FExpressionDelimiters
      write FExpressionDelimiters stored IsExprDelimitersStored;
    /// <summary>
    ///   Link to the "Text" object that will be used for displaying the
    ///   textthat not fit in this object. The linked object should have the
    ///   samefont settings as the main object. You also should place the
    ///   linkedobject after the main object.
    /// </summary>
    property FlowTo: TfrxCustomMemoView read FFlowTo write FFlowTo;
    /// <summary>
    ///   Gap between text and left and right edges of object, in pixels.
    ///   Default value is 2.
    /// </summary>
    property GapX: Extended read FGapX write FGapX stored IsGapXStored;
    /// <summary>
    ///   Gap between text and top and bottom edges of object, in pixels.
    ///   Default value is 1.
    /// </summary>
    property GapY: Extended read FGapY write FGapY stored IsGapYStored;
    /// <summary>
    ///   The horizontal text alignment.
    /// </summary>
    property HAlign: TfrxHAlign read FHAlign write FHAlign default haLeft;
    /// <summary>
    ///   Determines whether to show the zero values of expressions or DB
    ///   fields. Default value is True.
    /// </summary>
    property HideZeros: Boolean index Integer(mbfHideZeros) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Deprecated(see Highlights property). Conditional highlight settings.
    ///   The hightlight allows <br />changing the appearance of the object
    ///   depending on some condition. <br />
    /// </summary>
    property Highlight: TfrxHighlight read GetHighlight write SetHighlight stored IsHighlightStored;
    /// <summary>
    ///   Spacing between text lines, in pixels. Default value is 2.
    /// </summary>
    property LineSpacing: Extended read FLineSpacing write FLineSpacing stored IsLineSpacingStored;
    /// <summary>
    ///   Text lines of the object.
    /// </summary>
    property Memo: TWideStrings read FMemo write SetMemo;
    /// <summary>
    ///   Paragraph gap, in pixels. Default value is 0.
    /// </summary>
    property ParagraphGap: Extended read FParagraphGap write FParagraphGap stored IsParagraphGapStored;
    /// <summary>
    ///   Determines the text rotation, in degrees. Valid values are 0..360.
    /// </summary>
    property Rotation: Integer read FRotation write SetRotation default 0;
    /// <summary>
    ///   Used to print text right-to-left for far-east languages.
    /// </summary>
    property RTLReading: Boolean index Integer(mbfRTLReading) read GetFlagValue write SetFlagValue default False;
    property Style;
    /// <summary>
    ///   Deprecated(See Duplicates property). Determines if it hides repeated
    ///   values. Default value is False.
    /// </summary>
    property SuppressRepeated: Boolean index Integer(mbfSuppressRepeated) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Determines how to process repeated values. Default value is dmShow.
    /// </summary>
    property Duplicates: TfrxDuplicateMerge read FDuplicates write FDuplicates default dmShow;
    /// <summary>
    ///   Deprecated(See UnderlinesTextMode property). Determines whether to
    ///   show underlines under each text string. Default value is False.
    /// </summary>
    property Underlines: Boolean read GetUnderlines write SetUnderlines default False;
    /// <summary>
    ///   Determines how to show underlines in text object. Default value is
    ///   ulmNone.
    /// </summary>
    property UnderlinesTextMode: TfrxUnderlinesTextMode read FUnderlinesTextMode write FUnderlinesTextMode default ulmNone;
    /// <summary>
    ///   Determines whether to break russian words. Default value is False.
    /// </summary>
    property WordBreak: Boolean index Integer(mbfWordBreak) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Determines whether the text object inserts soft carriage returns so
    ///   text wraps at the right margin. Default value is True.
    /// </summary>
    property WordWrap: Boolean index Integer(mbfWordWrap) read GetFlagValue write SetFlagValue default True;
    /// <summary>
    ///   Determines whether to use printer canvas to arrange the text more
    ///   accurately. If set to False, you cannot use the "width align" mode.
    /// </summary>
    property Wysiwyg: Boolean index Integer(mbfWysiwyg) read GetFlagValue write SetFlagValue default True;
    /// <summary>
    ///   The vertical text alignment.
    /// </summary>
    property VAlign: TfrxVAlign read FVAlign write FVAlign default vaTop;
    /// <summary>
    ///   Use Unicode during export even if Font Charset is selected.
    /// </summary>
    property UseDefaultCharset: Boolean index Integer(mbfUseDefaultCharset) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Collection of Highlights. The object can hold several highlights
    ///   which serves different conditions.
    /// </summary>
    property Highlights: TfrxHighlightCollection read FHighlights;
    /// <summary>
    ///   Collection of Formats. The object can hold several formats for each
    ///   expression inside an object.
    /// </summary>
    property Formats: TfrxFormatCollection read FFormats;
  published
    /// <summary>
    ///   Internal use. Determines first paragraph break if object where split.
    ///   <br />
    /// </summary>
    property FirstParaBreak: Boolean index Integer(mbfFirstParaBreak) read GetFlagValue write SetFlagValue default False;
    /// <summary>
    ///   Internal use. Determines last paragraph break if object where split.
    /// </summary>
    property LastParaBreak: Boolean index Integer(mbfLastParaBreak) read GetFlagValue write SetFlagValue default False;
    property Cursor;
    property TagStr;
    property URL;
  end;

  /// <summary>
  ///   The TfrxMemoView class represents the "Text" object that can show
  ///   multiline text in a rectangular area.
  /// </summary>
  TfrxMemoView = class(TfrxCustomMemoView)
  published
    property AutoWidth;
    property AllowExpressions;
    property AllowHTMLTags;
    property BrushStyle;
    property CharSpacing;
    property ClearEmptyLines;
    property Clipped;
    property Color;
    property DataField;
    property DataSet;
    property DataSetName;
    property DisplayFormat;
    property DataLink;
    property ExpressionDelimiters;
    property FlowTo;
    property Font;
    property Frame;
    property FillType;
    property Fill;
    property GapX;
    property GapY;
    property HAlign;
    property HideZeros;
    property Highlight;
    property LineSpacing;
    property Memo;
    property ParagraphGap;
    property ParentFont;
    property Processing;
    property Rotation;
    property RTLReading;
    property Style;
    property SuppressRepeated;
    property Duplicates;
    property Underlines;
    property UnderlinesTextMode;
    property UseDefaultCharset;
    property WordBreak;
    property WordWrap;
    property Wysiwyg;
    property VAlign;
  end;

  /// <summary>
  ///   The TfrxSysMemoView represents the "System text" object. This object
  ///   can show system variables, aggregate values or text line.
  /// </summary>
  TfrxSysMemoView = class(TfrxCustomMemoView)
  public
    class function GetDescription: String; override;
  published
    property AutoWidth;
    property CharSpacing;
    property Color;
    property DisplayFormat;
    property Font;
    property Frame;
    property FillType;
    property Fill;
    property GapX;
    property GapY;
    property HAlign;
    property HideZeros;
    property Highlight;
    property Memo;
    property ParentFont;
    property Processing;
    property Rotation;
    property RTLReading;
    property Style;
    property SuppressRepeated;
    property Duplicates;
    property VAlign;
    property WordWrap;
  end;

  /// <summary>
  ///   The TfrxCustomLineView class is the base class for "Line" and
  ///   "Dot-matrix line" objects.
  /// </summary>
  TfrxCustomLineView = class(TfrxStretcheable)
  private
    FColor: TColor;
    FDiagonal: Boolean;
    FArrowEnd: Boolean;
    FArrowLength: Integer;
    FArrowSolid: Boolean;
    FArrowStart: Boolean;
    FArrowWidth: Integer;
    procedure DrawArrow(x1, y1, x2, y2: Extended);
    procedure DrawDiagonalLine;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    function Diff(AComponent: TfrxComponent): String; override;
    function GetVectorGraphic(DrawFill: Boolean = False): TGraphic; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    function IsContain(X, Y: Extended): Boolean; override;
    function IsInRect(const aRect: TfrxRect): Boolean; override;
    /// <summary>
    ///   Determines whether to draw an arrow in the end of line.
    /// </summary>
    property ArrowEnd: Boolean read FArrowEnd write FArrowEnd default False;
    /// <summary>
    ///   The length of arrow.
    /// </summary>
    property ArrowLength: Integer read FArrowLength write FArrowLength default 20;
    /// <summary>
    ///   Determines whether to draw a solid arrow.
    /// </summary>
    property ArrowSolid: Boolean read FArrowSolid write FArrowSolid default False;
    /// <summary>
    ///   Determines if an arrow is used at the start and end of the line.
    /// </summary>
    property ArrowStart: Boolean read FArrowStart write FArrowStart default False;
    /// <summary>
    ///   The width of arrow.
    /// </summary>
    property ArrowWidth: Integer read FArrowWidth write FArrowWidth default 5;
    /// <summary>
    ///   Determines if the line is diagonal.
    /// </summary>
    property Diagonal: Boolean read FDiagonal write FDiagonal default False;
  published
    /// <summary>
    ///   Color of the shape.
    /// </summary>
    property Color: TColor read FColor write FColor default clNone;
    property TagStr;
  end;

  /// <summary>
  ///   The TfrxLineView class represents the "Line" object. It can show a
  ///   horizontal, vertical or diagonal line.
  /// </summary>
  TfrxLineView = class(TfrxCustomLineView)
  public
    class function GetDescription: String; override;
  published
    property ArrowEnd;
    property ArrowLength;
    property ArrowSolid;
    property ArrowStart;
    property ArrowWidth;
    property Frame;
    property Diagonal;
  end;

  /// <summary>
  ///   The TfrxPictureView class represents the "Picture" object. It can show
  ///   a picture in the PNG, BMP, JPEG, ICO, WMF, EMF formats.
  /// </summary>
  TfrxPictureView = class(TfrxView, IfrxCachedView, IfrxDataLinkObject)
  private
    FGraphicProps: TfrxGraphicDrawProps;
    FFileLink: String;
    FDataLink: TfrxDataLink;
    FImageIndex: Integer;
    FIsImageIndexStored: Boolean;
    FIsPictureStored: Boolean;
    FPicture: TPicture;
    FPictureChanged: Boolean;
    FTransparentColor: TColor;
    FCached: IfrxCachedGraphic;
    FGFormat: TfrxCustomGraphicFormatClass;
    procedure SetPicture(const Value: TPicture);
    procedure PictureChanged(Sender: TObject);
    function GetPicture: TPicture;
    procedure UpdateGraphicHelper;
    function GetValue(const Index: Integer): Boolean;
    procedure SetValue(const Index: Integer; const Value: Boolean);
    function LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
    function GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
    function IsExpressionLink: Boolean;
    function GetDataLink: TfrxDataLink;
    procedure SetDataLink(const Value: TfrxDataLink);
    function IsDataLinkStored: Boolean;
  protected
    procedure SetCachedGraphic(const PictureCache: IfrxPictureCache);
    procedure GetCachedGraphic(ACacheType: TfrxCachedGraphicType; const PictureCache: IfrxPictureCache);
    procedure ReleaseCachedGraphic;
    function IsUpdateRequired(NewCacheType: TfrxCachedGraphicType): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    function Diff(AComponent: TfrxComponent):String; override;
    procedure AfterPrint; override;
    procedure BeforePrint; override;
    /// <summary>
    ///   Load picture from stream.
    /// </summary>
    function LoadPictureFromStream(s: TStream; ResetStreamPos: Boolean = True): HResult; virtual;
    function IsEMFExportable: Boolean; override;
    function IsEmpty: Boolean;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;

    procedure GetData; override;
    function GetGraphic: TGraphic;
    function GraphicWidth: Integer;
    function GraphicHeight: Integer;
    function GraphicTransparency: Boolean;
    function GraphicIsVector: Boolean;
    function GraphicHasAlpha: Boolean;
    function GraphicHasMaskColor: Boolean;
    function GraphicTransparentColor: TColor;
    function GraphicIsTranslucent: Boolean;

    /// <summary>
    ///   Internal use. Determines if images stored in a picture cache.
    /// </summary>
    property IsImageIndexStored: Boolean read FIsImageIndexStored write FIsImageIndexStored;
    /// <summary>
    ///   Internal use. Determines if images stored in a picture object.
    /// </summary>
    property IsPictureStored: Boolean read FIsPictureStored write FIsPictureStored;
  published
    property Cursor;
    /// <summary>
    ///   Determines whether the picture should handle its size automatically.
    ///   Default value is False.
    /// </summary>
    property AutoSize: Boolean index Integer(fgdAutoSize) read GetValue write SetValue default False;
    /// <summary>
    ///   Determines whether the image should be centered inside the object.
    ///   Default value is False.
    /// </summary>
    property Center: Boolean index Integer(fgdCenter) read GetValue write SetValue default False;
    property DataField;
    property DataSet;
    property DataSetName;
    property DataLink: TfrxDataLink read GetDataLink write SetDataLink stored IsDataLinkStored;
    property Frame;
    property FillType;
    property Fill;
    /// <summary>
    ///   File name or expression which contains a name of the picture file.
    /// </summary>
    property FileLink: String read FFileLink write FFileLink;
    /// <summary>
    ///   Internal use only. Index of image in a picture cache if image stored
    ///   in a picture cache.
    /// </summary>
    property ImageIndex: Integer read FImageIndex write FImageIndex stored FIsImageIndexStored;
    /// <summary>
    ///   Keep the original aspect ratio of the image when stretching the
    ///   object. The Stretched property should also be set.
    /// </summary>
    property KeepAspectRatio: Boolean index Integer(fgdKeepAspectRatio) read GetValue write SetValue default True;
    /// <summary>
    ///   Reference to internal TPicture object that stores the image.
    /// </summary>
    property Picture: TPicture read GetPicture write SetPicture stored FIsPictureStored;
    /// <summary>
    ///   Stretches the picture to fit the object bounds. Default value is
    ///   True.
    /// </summary>
    /// <summary>
    ///   Stretches the picture to fit the object bounds. Default value is
    ///   True.
    /// </summary>
    property Stretched: Boolean index Integer(fgdStretch) read GetValue write SetValue default True;
    property Style;
    property TagStr;
    property URL;
    /// <summary>
    ///   Activates drawing with better smooth.
    /// </summary>
    property HightQuality: Boolean index Integer(fgdHiQuality) read GetValue write SetValue;
    /// <summary>
    ///   Determines if picture has transparent parts or Alpha mask.
    /// </summary>
    property Transparent: Boolean index Integer(fgdTransparent) read GetValue write SetValue;
    /// <summary>
    ///   Color of transparent parts.
    /// </summary>
    property TransparentColor: TColor read FTransparentColor write FTransparentColor;
  end;

  TfrxCustomSignatureGraphicType = (gtNo, gtImported, gtName);
  /// <summary>
  ///   Represents data for a custom digital signature image.
  /// </summary>
  TfrxCustomSignatureData = class(TPersistent)
  private
    FGraphicType: TfrxCustomSignatureGraphicType;
    FNamePicture: TPicture;
    FLogoPicture: TPicture;
    FFRGraphic: TGraphic;

    procedure SetNamePicture(const Value: TPicture);
    procedure SetLogoPicture(const Value: TPicture);
    function GetLogoPicture: TPicture;
  protected
    FShowName: Boolean;
    FShowLocation: Boolean;
    FShowDate: Boolean;
    FShowReason: Boolean;
    FShowDistinguishedName: Boolean;
    FShowProgramVersion: Boolean;
    FShowLogo: Boolean;
    FShowLabels: Boolean;
    FRTL: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property GraphicType: TfrxCustomSignatureGraphicType read FGraphicType write FGraphicType;
    property NamePicture: TPicture read FNamePicture write SetNamePicture;
    property ShowName: Boolean read FShowName write FShowName;
    property ShowLocation: Boolean read FShowLocation write FShowLocation;
    property ShowDate: Boolean read FShowDate write FShowDate;
    property ShowReason: Boolean read FShowReason write FShowReason;
    property ShowDistinguishedName: Boolean read FShowDistinguishedName write FShowDistinguishedName;
    property ShowProgramVersion: Boolean read FShowProgramVersion write FShowProgramVersion;
    property ShowLogo: Boolean read FShowLogo write FShowLogo;
    property ShowLabels: Boolean read FShowLabels write FShowLabels;
    property LogoPicture: TPicture read GetLogoPicture write SetLogoPicture;
    property RTL: Boolean read FRTL write FRTL;
  end;

  TPDFSignatureKind = (skInvisible, skVisible, skEmpty);

  TfrxDigitalSignatureView = class (TfrxPictureView)
  private
    FKind: TPDFSignatureKind;
    FDescription: WideString;
    FCustomizable: Boolean;
    FCustomData: TfrxCustomSignatureData;
    FCustomPicture: TPicture;
  protected
    FCommonName: WideString;
    FDate: WideString;
    FLocation: WideString;
    FReason: WideString;
    FDistinguishedName: WideString;
    FProgramVersion: WideString;
  protected
    FSavedPicture: TPicture;

    procedure CreateCustomPicture;
    function CreateBitmap32: TBitmap;
    function CreateBitmap24: TBitmap;
    function IsGraphicVisible: Boolean;
    function IsTextVisible: Boolean;
    procedure DrawLogo(Canvas: TCanvas);
    procedure DrawNamePicture(Canvas: TCanvas; Rect: TRect);
    procedure DrawNameText(Canvas: TCanvas; Rect: TRect);
    procedure DrawText(Canvas: TCanvas; Rect: TRect);
    procedure OutText(Canvas: TCanvas; Rect: TRect; WS: TWideStrings);
    procedure DrawWithAcpectRatio(Canvas: TCanvas; Rect: TRect; Graphic: TGraphic);
    procedure DrawTextParams(Rect: TRect);
    procedure DrawTextFontSizeAndText(dFontSize: Integer; WS: TWideStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure CustomFirst;
    procedure CustomLast;

    property CommonName: WideString write FCommonName;
    property Date: WideString write FDate;
    property Location: WideString read FLocation write FLocation;
    property Reason: WideString read FReason write FReason;
    property DistinguishedName: WideString write FDistinguishedName;
    property ProgramVersion: WideString write FProgramVersion;
  published
    property Font;
    property Kind: TPDFSignatureKind read FKind write FKind;
    /// <summary>
    ///   Designed to identify the signature in the export dialog if there are
    ///   multiple signatures.
    /// </summary>
    property Description: WideString read FDescription write FDescription;
    /// <summary>
    ///   Allows you to customize the digital signature image by adding a name,
    ///   signing time, location, reason etc.
    /// </summary>
    property Customizable: Boolean read FCustomizable write FCustomizable default False;
    property CustomData: TfrxCustomSignatureData read FCustomData write FCustomData;
  end;

  /// <summary>
  ///   The TfrxShapeView class represents the "Shape" object. It can show one
  ///   of the following shapes: rectangle, ellipse, rounded rectangle,
  ///   triangle, diamond.
  /// </summary>
  TfrxShapeView = class(TfrxView)
  private
    FCurve: Integer;
    FShape: TfrxShapeKind;
    FRotation: Integer;
    procedure SetRotation(vRot: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    function Diff(AComponent: TfrxComponent): String; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;

    class function GetDescription: String; override;
  published
    property Rotation: Integer read FRotation write SetRotation default 0;
    property Color;
    property Cursor;
    /// <summary>
    ///   Curvature of the round rectangle edges.
    /// </summary>
    property Curve: Integer read FCurve write FCurve default 0;
    property FillType;
    property Fill;
    property Frame;
    /// <summary>
    ///   Kind of shape.
    /// </summary>
    property Shape: TfrxShapeKind read FShape write FShape default skRectangle;
    property TagStr;
    property URL;
  end;

  /// <summary>
  ///   The TfrxSubreport class represents the "Subreport" object. Object is
  ///   linked to a report page that stores the objects of subreport. When
  ///   running a report, as soon as the "Subreport" object is encountered, the
  ///   report, allocated to the subreport design page, will be displayed.
  ///   After that, basic report creation will continue.
  /// </summary>
  TfrxSubreport = class(TfrxView)
  private
    FPage: TfrxReportPage;
    FPrintOnParent: Boolean;
    procedure SetPage(const Value: TfrxReportPage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
  published
    /// <summary>
    ///   Reference to a report page that stores the objects of subreport.
    /// </summary>
    property Page: TfrxReportPage read FPage write SetPage;
    /// <summary>
    ///   Determines whether the subreport contents should be printed on a
    ///   parent band (which contains the "subreport" object). Default value is
    ///   False. In this case the subreport's objects are printed as a <br />
    ///   separate bands and do not affect the parent band.
    /// </summary>
    property PrintOnParent: Boolean read FPrintOnParent write FPrintOnParent
      default False;
  end;


{ Bands }
  TfrxChild = class;

  /// <summary>
  ///   The TfrxBand is the base class for all bands. Band allows creation of a
  ///   report area, which has a specific behaviour according to type.
  /// </summary>
  TfrxBand = class(TfrxReportComponent)
  private
    FAllowSplit: Boolean;
    FChild: TfrxChild;
    FKeepChild: Boolean;
    FOnAfterCalcHeight: TfrxNotifyEvent;
    FOutlineText: String;
    FOverflow: Boolean;
    FStartNewPage: Boolean;
    FStretched: Boolean;
    FPrintChildIfInvisible: Boolean;
    FVertical: Boolean;
    FFill: TfrxCustomFill;
    FFillType: TfrxFillType;
    FFillMemo: TfrxMemoView;
    FFillgap: TfrxFillGaps;
    FFrame: TfrxFrame;
    FBandDesignHeader: Extended;
    FShiftEngine: TfrxShiftEngine;
    function GetBandName: String;
    procedure SetChild(Value: TfrxChild);
    procedure SetVertical(const Value: Boolean);
    procedure SetFill(const Value: TfrxCustomFill);
    procedure SetFillType(const Value: TfrxFillType);
    procedure SetFrame(const Value: TfrxFrame);
    procedure SetGaps(const Value: TfrxFillGaps);
  protected
    function GetBandTitleColor: TColor; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetLeft(Value: Extended); override;
    procedure SetTop(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
  public
    /// <summary>
    ///   List of sub bands.
    /// </summary>
    FSubBands: TList;
    FHeader, FFooter, FGroup: TfrxBand;  { h./f./g. bands   }
    /// <summary>
    ///   Used for &lt;Line&gt;.
    /// </summary>
    FLineN: Integer;
    /// <summary>
    ///   Used for &lt;Line#&gt;.
    /// </summary>
    FLineThrough: Integer;
    /// <summary>
    ///   Whether the band should show vertical bands.
    /// </summary>
    FHasVBands: Boolean;
    /// <summary>
    ///   Height of the band after stretch.
    /// </summary>
    FStretchedHeight: Extended;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    ///   Returns band index from frxBands array.
    /// </summary>
    function BandNumber: Integer;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    /// <summary>
    ///   Creates background object which represent band fill and frame.
    /// </summary>
    procedure CreateFillMemo();
    /// <summary>
    ///   Frees background object which represent band fill and frame.
    /// </summary>
    procedure DisposeFillMemo();
    class function GetDescription: String; override;
    function IsContain(X, Y: Extended): Boolean; override;
    function GetContainedComponent(X, Y: Extended; IsCanContain: TfrxComponent = nil): TfrxComponent; override;
    /// <summary>
    ///   Determines whether the band contents may be splitted if band does not
    ///   find a room in the page. Only "Text", "Line" and "RichText" objects
    ///   may be split. Default value is False.
    /// </summary>
    property AllowSplit: Boolean read FAllowSplit write FAllowSplit default False;
    /// <summary>
    ///   Returns name of the band based on its ClassName (It's not similar to
    ///   Name property).
    /// </summary>
    property BandName: String read GetBandName;
    /// <summary>
    ///   Returns band header height if band caption enabled in the report
    ///   designer.
    /// </summary>
    property BandDesignHeader: Extended read FBandDesignHeader write FBandDesignHeader;
    /// <summary>
    ///   Link to a child band that will be shown after this band.
    /// </summary>
    property Child: TfrxChild read FChild write SetChild;
    /// <summary>
    ///   Determines whether to show a child band on the same page as a parent
    ///   band. If child band does not find a room on the page, it will be
    ///   carried to the next page along with its parent band. Default value is
    ///   False.
    /// </summary>
    property KeepChild: Boolean read FKeepChild write FKeepChild default False;
    /// <summary>
    ///   "Report outline" object represents the "Report outline" control
    ///   element in a preview window. This element displays a treelike
    ///   structure of a finished report. When clicking on any tree node, there
    ///   is a jump to the page connected to this node. <br />All bands have
    ///   the "OutlineText" property, into which a line-expression can be put,
    ///   and this in turn helps to automatically create a tree. The expression
    ///   will be calculated when forming a report, and its value will be added
    ///   to the tree when printing the band. Thus, elements' hierarchy in the
    ///   tree is similar to the bands' hierarchy in a report. That means, that
    ///   in the tree there will be main and subordinate elements,
    ///   corresponding to main and subordinate bands in a report (a report
    ///   with two levels of data or with groups can exemplify the point).
    /// </summary>
    property OutlineText: String read FOutlineText write FOutlineText;
    /// <summary>
    ///   Returns True if band was reprinted on a new page (only for "Group
    ///   header" or "Header" bands with ReprintOnNewPage property set to
    ///   True).
    /// </summary>
    property Overflow: Boolean read FOverflow write FOverflow;
    /// <summary>
    ///   Determines whether to show child band if this band is invisible.
    ///   Default value is False.
    /// </summary>
    property PrintChildIfInvisible: Boolean read FPrintChildIfInvisible
      write FPrintChildIfInvisible default False;
    /// <summary>
    ///   Determines whether to form a new output page before printing this
    ///   band. Default value is False.
    /// </summary>
    property StartNewPage: Boolean read FStartNewPage write FStartNewPage default False;
    /// <summary>
    ///   Determines whether the band can stretch depending on size of its
    ///   objects. To use this property, band should contain stretchable
    ///   objects such as "Text", "Picture", "RichText". Default value is
    ///   False.
    /// </summary>
    property Stretched: Boolean read FStretched write FStretched default False;
    { make IContainer Interface and move some base properties set/get to it }
    /// <summary>
    ///   Determine how band shifts its child object.
    /// </summary>
    property ShiftEngine: TfrxShiftEngine read FShiftEngine write FShiftEngine default seTree;
  published
    property AllowMirrorMode;
    /// <summary>
    ///   Band fill type.
    /// </summary>
    property FillType: TfrxFillType read FFillType write SetFillType;
    /// <summary>
    ///   Reference to a band fill object.
    /// </summary>
    property Fill: TfrxCustomFill read FFill write SetFill;
    /// <summary>
    ///   Reference to an object winch stores fill gaps settings.
    /// </summary>
    property FillGap: TfrxFillGaps read FFillGap write SetGaps;
    /// <summary>
    ///   Reference to band Frame.
    /// </summary>
    property Frame: TfrxFrame read FFrame write SetFrame;
    property Font;
    property Height;
    property Left;
    property ParentFont;
    property Restrictions;
    property Top;
    /// <summary>
    ///   Determines if the band is a vertical band.
    /// </summary>
    property Vertical: Boolean read FVertical write SetVertical default False;
    property Visible;
    property Width;
    /// <summary>
    ///   Name of the script procedure that will be called after calculating
    ///   the band's height.
    /// </summary>
    property OnAfterCalcHeight: TfrxNotifyEvent read FOnAfterCalcHeight
      write FOnAfterCalcHeight;
    property OnAfterPrint;
    property OnBeforePrint;
  end;

  TfrxBandClass = class of TfrxBand;

  /// <summary>
  ///   This flags used in a child band to complete data band upto specified
  ///   number of rows (fill the space with an empty rows). If data band has
  ///   less number of rows, the empty row will be printed.
  /// </summary>
  TfrxToNRowsMode = (
    /// <summary>
    ///   It prints rows until reaches N records count.
    /// </summary>
    rmCount,
    /// <summary>
    ///   It adds N rows to current Data band.
    /// </summary>
    rmAddToCount,
    /// <summary>
    ///   It fills page with "Child" band till the end of the page reached.
    /// </summary>
    rmTillPageEnds);

  /// <summary>
  ///   The TfrxDataBand class is the base class for all data-bands. Data-band
  ///   is a band connected to a dataset. Data-band is displayed as many times
  ///   as there are records in the dataset.
  /// </summary>
  TfrxDataBand = class(TfrxBand)
  private
    FColumnGap: Extended;
    FColumnWidth: Extended;
    FColumns: Integer;
    FCurColumn: Integer;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FFilter: String;
    FFooterAfterEach: Boolean;
    FKeepFooter: Boolean;
    FKeepHeader: Boolean;
    FKeepTogether: Boolean;
    FPrintIfDetailEmpty: Boolean;
    FRowCount: Integer;
    FOnMasterDetail: TfrxNotifyEvent;
    FVirtualDataSet: TfrxUserDataSet;
    procedure SetCurColumn(Value: Integer);
    procedure SetRowCount(const Value: Integer);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
    function GetVirtualDataSet: TfrxUserDataSet;
  protected
    function GetBandTitleColor: TColor; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    FMaxY: Extended;                             { used for columns }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
    /// <summary>
    ///   Current column of the band.
    /// </summary>
    property CurColumn: Integer read FCurColumn write SetCurColumn;
    property VirtualDataSet: TfrxUserDataSet read GetVirtualDataSet;
  published
    property AllowSplit;
    property Child;
    /// <summary>
    ///   The "Columns" property, available in all data-bands, allows to set
    ///   number of columns for a particular band and not for the whole page.
    ///   Thus, displaying of data will be not "from the top to the bottom,
    ///   then from the left to the right," but "from left to right, then from
    ///   top to bottom". You also should set ColumnWidth and ColumnGap
    ///   properties.
    /// </summary>
    property Columns: Integer read FColumns write FColumns default 0;
    /// <summary>
    ///   Width of the band's column, in pixels.
    /// </summary>
    property ColumnWidth: Extended read FColumnWidth write FColumnWidth;
    /// <summary>
    ///   Gap between band's columns, in pixels.
    /// </summary>
    property ColumnGap: Extended read FColumnGap write FColumnGap;
    /// <summary>
    ///   Dataset for a band.
    /// </summary>
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    /// <summary>
    ///   Dataset name for a band. This property duplicates the DataSet
    ///   property.
    /// </summary>
    property DataSetName: String read GetDataSetName write SetDataSetName;
    /// <summary>
    ///   Determines whether to show band footer after each record. Default
    ///   value is False. By default the footer is displayed after printing all
    ///   dataset records.
    /// </summary>
    property FooterAfterEach: Boolean read FFooterAfterEach write FFooterAfterEach default False;
    /// <summary>
    ///   An expression used to manage visibility of a band record. if result
    ///   of this expression is True, band will be shown.
    /// </summary>
    property Filter: String read FFilter write FFilter;
    /// <summary>
    ///   Determines whether to show band footer on the same page as the band
    ///   itself. If footer does not find room on the page, it will be carried
    ///   to the next page along with last record of its parent band. Default
    ///   value is False.
    /// </summary>
    property KeepChild;
    /// <summary>
    ///   Determines whether to show band footer on the same page as the band
    ///   itself. If footer does not find room on the page, it will be carried
    ///   to the next page along with last record of its parent band. Default
    ///   value is False.
    /// </summary>
    property KeepFooter: Boolean read FKeepFooter write FKeepFooter default False;
    /// <summary>
    ///   Determines whether to show band header on the same page as the
    ///   banditself. If header does not find room on the page, it will be
    ///   carriedto the next page. Default value is False.
    /// </summary>
    property KeepHeader: Boolean read FKeepHeader write FKeepHeader default False;
    /// <summary>
    ///   Determines whether to print the band together with all its subbands
    ///   on the same page. Default value is False.
    /// </summary>
    property KeepTogether: Boolean read FKeepTogether write FKeepTogether default False;
    property OutlineText;
    property PrintChildIfInvisible;
    /// <summary>
    ///   Determines whether to print the band if all its subbands are empty.
    ///   Default value is False.
    /// </summary>
    property PrintIfDetailEmpty: Boolean read FPrintIfDetailEmpty
      write FPrintIfDetailEmpty default False;
    /// <summary>
    ///   Allows printing the band N times. This property is used if the band
    ///   is NOT connected to the dataset.
    /// </summary>
    property RowCount: Integer read FRowCount write SetRowCount;
    property StartNewPage;
    property Stretched;
    property ShiftEngine;
    /// <summary>
    ///   Name of the script procedure that will be called before the band will
    ///   check if any subbands are empty.
    /// </summary>
    property OnMasterDetail: TfrxNotifyEvent read FOnMasterDetail write FOnMasterDetail;
  end;

  /// <summary>
  ///   The TfrxHeader class represents a "Header" band. This kind of band is a
  ///   header for all data-bands.
  /// </summary>
  TfrxHeader = class(TfrxBand)
  private
    FReprintOnNewPage: Boolean;
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    /// <summary>
    ///   Determines if it is necessary to reprint a header on each new page.
    /// </summary>
    property ReprintOnNewPage: Boolean read FReprintOnNewPage write FReprintOnNewPage default False;
    property StartNewPage;
    property Stretched;
    property ShiftEngine;
  end;

  /// <summary>
  ///   The TfrxFooter class represents a "Footer" band. This kind of band is a
  ///   footer for all data-bands.
  /// </summary>
  TfrxFooter = class(TfrxBand)
  private
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property Stretched;
    property ShiftEngine;
  end;

  /// <summary>
  ///   The TfrxMasterData represents a "Master data" band.
  /// </summary>
  TfrxMasterData = class(TfrxDataBand)
  private
  public
  published
  end;

  /// <summary>
  ///   The TfrxDetailData represents a "Detail data" band.
  /// </summary>
  TfrxDetailData = class(TfrxDataBand)
  private
  public
  published
  end;

  /// <summary>
  ///   The TfrxSubDetailData represents a "Subdetail data" band.
  /// </summary>
  TfrxSubdetailData = class(TfrxDataBand)
  private
  public
  published
  end;

  /// <summary>
  ///   The TfrxDataBand4 represents a "4th data level" band.
  /// </summary>
  TfrxDataBand4 = class(TfrxDataBand)
  private
  public
  published
  end;

  /// <summary>
  ///   The TfrxDataBand5 represents a "5th data level" band.
  /// </summary>
  TfrxDataBand5 = class(TfrxDataBand)
  private
  public
  published
  end;

  /// <summary>
  ///   The TfrxDataBand6 represents a "6th data level" band.
  /// </summary>
  TfrxDataBand6 = class(TfrxDataBand)
  private
  public
  published
  end;

  /// <summary>
  ///   The TfrxPageHeader class represents a "Page header" band. This kind of
  ///   band is displayed at the top of each page.
  /// </summary>
  TfrxPageHeader = class(TfrxBand)
  private
    FPrintOnFirstPage: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Child;
    property PrintChildIfInvisible;
    /// <summary>
    ///   Determines whether to print a band on the first page.
    /// </summary>
    property PrintOnFirstPage: Boolean read FPrintOnFirstPage write FPrintOnFirstPage default True;
    property Stretched;
    property ShiftEngine;
  end;

  /// <summary>
  ///   The TfrxPageFooter class represents a "Page footer" band. This kind of
  ///   band is displayed at the bottom of each page.
  /// </summary>
  TfrxPageFooter = class(TfrxBand)
  private
    FPrintOnFirstPage: Boolean;
    FPrintOnLastPage: Boolean;
    FPrintOnSinglePage: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
  published
    /// <summary>
    ///   Determines whether to print a band on the first page.
    /// </summary>
    property PrintOnFirstPage: Boolean read FPrintOnFirstPage write FPrintOnFirstPage default True;
    /// <summary>
    ///   Determines whether to print a band on the last page.
    /// </summary>
    property PrintOnLastPage: Boolean read FPrintOnLastPage write FPrintOnLastPage default True;
    /// <summary>
    ///   Determines whether to print a band on the page when it last and first
    ///   page (i.e. single page).
    /// </summary>
    property PrintOnSinglePage: Boolean read FPrintOnSinglePage write FPrintOnSinglePage default False;
  end;

  /// <summary>
  ///   The TfrxColumnHeader class represents a "Column header" band. This kind
  ///   of band is displayed at the top of each column.
  /// </summary>
  TfrxColumnHeader = class(TfrxBand)
  private
  public
  published
    property Child;
    property Stretched;
    property ShiftEngine;
  end;

  /// <summary>
  ///   The TfrxColumnFooter class represents a "Column footer" band. This kind
  ///   of band is displayed at the bottom of each column.
  /// </summary>
  TfrxColumnFooter = class(TfrxBand)
  private
  public
  published
  end;

  /// <summary>
  ///   The TfrxGroupHeader class represents a "Group header" band. This kind
  ///   of band is displayed at the top of each group.
  /// </summary>
  TfrxGroupHeader = class(TfrxBand)
  private
    FCondition: String;
    FDrillName: String;               { used instead Tag property in drill down }
    FDrillDown: Boolean;
    FExpandDrillDown: Boolean;
    FShowFooterIfDrillDown: Boolean;
    FShowChildIfDrillDown: Boolean;
    FKeepTogether: Boolean;
    FReprintOnNewPage: Boolean;
    FResetPageNumbers: Boolean;
  public
    /// <summary>
    ///   Used to store previous value of group condition. Internal only.
    /// </summary>
    FLastValue: Variant;
    function Diff(AComponent: TfrxComponent): String; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
  published
    property AllowSplit;
    property Child;
    /// <summary>
    ///   A special condition (DB field value or an expression); the band is
    ///   displayed as soon as the condition's value is changed.
    /// </summary>
    property Condition: String read FCondition write FCondition;
    /// <summary>
    ///   Determines whether a group is drill-down group. It means you can
    ///   click on the header in the preview window and group will expand or
    ///   collapse.
    /// </summary>
    property DrillDown: Boolean read FDrillDown write FDrillDown default False;
    /// <summary>
    ///   Determines whether to expand all groups at first run of report. See
    ///   also DrillDown property.
    /// </summary>
    property ExpandDrillDown: Boolean read FExpandDrillDown write FExpandDrillDown default False;
    property KeepChild;
    /// <summary>
    ///   Determines whether to print a group on the same page. If the whole
    ///   group does not find room on the page, it is transferred to a new
    ///   page. Default value is False.
    /// </summary>
    property KeepTogether: Boolean read FKeepTogether write FKeepTogether default False;
    /// <summary>
    ///   Determines whether is necessary to reprint a header on each new page.
    /// </summary>
    property ReprintOnNewPage: Boolean read FReprintOnNewPage write FReprintOnNewPage default False;
    property OutlineText;
    property PrintChildIfInvisible;
    /// <summary>
    ///   Determines whether to reset the page numbers on when group starts.
    ///   You should also set the StartNewPage property.
    /// </summary>
    property ResetPageNumbers: Boolean read FResetPageNumbers write FResetPageNumbers default False;
    /// <summary>
    ///   Determines whether to show the footer of a collapsed group. See also
    ///   DrillDown property.
    /// </summary>
    property ShowFooterIfDrillDown: Boolean read FShowFooterIfDrillDown
      write FShowFooterIfDrillDown default False;
    /// <summary>
    ///   Determines whether to show the child band of a collapsed group. See
    ///   also DrillDown property.
    /// </summary>
    property ShowChildIfDrillDown: Boolean read FShowChildIfDrillDown
      write FShowChildIfDrillDown default False;
    property StartNewPage;
    property Stretched;
    property ShiftEngine;
    /// <summary>
    ///   The name of a drill down group.
    /// </summary>
    property DrillName: String read FDrillName write FDrillName;
  end;

  /// <summary>
  ///   The TfrxGroupFooter class represents a "Group footer" band. This kind
  ///   of band is displayed at the bottom of each group.
  /// </summary>
  TfrxGroupFooter = class(TfrxBand)
  private
    FHideIfSingleDataRecord: Boolean;
  public
  published
    property AllowSplit;
    property Child;
    /// <summary>
    ///   Determines whether to hide a footer if a group has only one data
    ///   record.
    /// </summary>
    property HideIfSingleDataRecord: Boolean read FHideIfSingleDataRecord
      write FHideIfSingleDataRecord default False;
    property KeepChild;
    property PrintChildIfInvisible;
    property Stretched;
    property ShiftEngine;
  end;

  /// <summary>
  ///   The TfrxReportTitle class represents a "Report title" band. This kind
  ///   of band is displayed at the top of the report.
  /// </summary>
  TfrxReportTitle = class(TfrxBand)
  private
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property StartNewPage;
    property Stretched;
    property ShiftEngine;
  end;

  /// <summary>
  ///   The TfrxReportSummary class represents a "Report summary" band. This
  ///   kind of band is displayed at the end of the report.
  /// </summary>
  TfrxReportSummary = class(TfrxBand)
  private
    FPrintAtBottom: Boolean;
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    /// <summary>
    ///   Determines if summary band should print at bottom of the page.
    /// </summary>
    property PrintAtBottom: Boolean read FPrintAtBottom write FPrintAtBottom default False;
    property StartNewPage;
    property Stretched;
    property ShiftEngine;
  end;

  /// <summary>
  ///   The TfrxChild class represents a "Child" band. This kind of band is
  ///   linked to the parent band via its "Child" property and displayed after
  ///   it.
  /// </summary>
  TfrxChild = class(TfrxBand)
  private
    FToNRows: Integer;
    FToNRowsMode: TfrxToNRowsMode;
  public
  published
    property AllowSplit;
    property Child;
    property KeepChild;
    property PrintChildIfInvisible;
    property StartNewPage;
    property Stretched;
    property ShiftEngine;
    /// <summary>
    ///   Row count used for ToNRowsMode. The value depends on TfrxToNRowsMode
    ///   flag.
    /// </summary>
    property ToNRows: Integer read FToNRows write FToNRows;
    /// <summary>
    ///   This flags used in a child band to complete data band upto specified
    ///   number of rows (fill the space with an empty rows). If data band has
    ///   less number of rows, the empty row will be printed.
    /// </summary>
    property ToNRowsMode: TfrxToNRowsMode read FToNRowsMode write FToNRowsMode;
  end;

  /// <summary>
  ///   The TfrxOverlay class represents an "Overlay" band. This kind of band
  ///   is printed on each page as a bottom layer.
  /// </summary>
  TfrxOverlay = class(TfrxBand)
  private
    FPrintOnTop: Boolean;
  public
  published
    /// <summary>
    ///   Determines whether to print this band on top of other bands.
    /// </summary>
    property PrintOnTop: Boolean read FPrintOnTop write FPrintOnTop default False;
  end;

  TfrxNullBand = class(TfrxBand);


{ Pages }

  /// <summary>
  ///   The TfrxPage class is the base class for report design pages such as
  ///   TfrxReportPage, TfrxDialogPage, TfrxDMPPage.
  /// </summary>
  TfrxPage = class(TfrxComponent)
  private
    FHGuides: TStrings;
    FVGuides: TStrings;
    procedure SetHGuides(const Value: TStrings);
    procedure SetVGuides(const Value: TStrings);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); virtual;
    /// <summary>
    ///   Clears all guide lines. Guide lines are used only in the designer.
    /// </summary>
    procedure ClearGuides;
    function IsSupportsGuidlines: Boolean; virtual;
    destructor Destroy; override;
  published
    property Font;
    property Visible;
    /// <summary>
    ///   Horizontal guide lines. Used only in the designer.
    /// </summary>
    property HGuides: TStrings read FHGuides write SetHGuides;
    /// <summary>
    ///   Vertical guide lines. Used only in the designer.
    /// </summary>
    property VGuides: TStrings read FVGuides write SetVGuides;
  end;

  /// <summary>
  ///   The TfrxReportPage class represents a report design page that may
  ///   contain bands and other objects such as "Text", "Picture", etc.
  /// </summary>
  TfrxReportPage = class(TfrxPage)
  private
    FBackPicture: TfrxPictureView;
    FBin: Integer;
    FBinOtherPages: Integer;
    FBottomMargin: Extended;
    FColumns: Integer;
    FColumnWidth: Extended;
    FColumnPositions: TStrings;
    FDataSet: TfrxDataSet;
    FDuplex: TfrxDuplexMode;
    FEndlessHeight: Boolean;
    FEndlessWidth: Boolean;
    FLargeDesignHeight: Boolean;
    FLeftMargin: Extended;
    FMirrorMargins: Boolean;
    FOrientation: TPrinterOrientation;
    FOutlineText: String;
    FPrintIfEmpty: Boolean;
    FPrintOnPreviousPage: Boolean;
    FResetPageNumbers: Boolean;
    FRightMargin: Extended;
    FSubReport: TfrxSubreport;
    FTitleBeforeHeader: Boolean;
    FTopMargin: Extended;
    FOnAfterPrint: TfrxNotifyEvent;
    FOnBeforePrint: TfrxNotifyEvent;
    FOnManualBuild: TfrxNotifyEvent;
    FDataSetName: String;
    FBackPictureVisible: Boolean;
    FBackPicturePrintable: Boolean;
    FBackPictureStretched: Boolean;
    FPageCount: Integer;
    FShowTitleOnPreviousPage: Boolean;
    FReport: TfrxReport;
    FMirrorMode: TfrxMirrorControlModes;
    procedure SetPageCount(const Value: Integer);
    procedure SetColumns(const Value: Integer);
    procedure SetOrientation(Value: TPrinterOrientation);

    procedure SetColumnPositions(const Value: TStrings);
    procedure SetFrame(const Value: TfrxFrame);
    function GetFrame: TfrxFrame;
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
    function GetBackPicture: TPicture;
    procedure SetBackPicture(const Value: TPicture);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  protected
    FPaperHeight: Extended;
    FPaperSize: Integer;
    FPaperWidth: Extended;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetPaperHeight(const Value: Extended); virtual;
    procedure SetPaperWidth(const Value: Extended); virtual;
    procedure SetPaperSize(const Value: Integer); virtual;
    procedure UpdateDimensions;
  public
    /// <summary>
    ///   List of master bands.
    /// </summary>
    FSubBands: TList;
    /// <summary>
    ///   List of vertical master bands.
    /// </summary>
    FVSubBands: TList;
    constructor Create(AOwner: TComponent); overload; override;
    { C++ Builder doesn't support constructor names , use parameters}
    /// <summary>
    ///   Constructor used in preview pages/
    /// </summary>
    /// <param name="AOwner">
    ///   Owner component.
    /// </param>
    /// <param name="AReport">
    ///   Parent report for this page.
    /// </param>
    constructor CreateInPreview(AOwner: TComponent; AReport: TfrxReport); overload;
    destructor Destroy; override;
    class function GetDescription: String; override;
    /// <summary>
    ///   Search for band of the specified class on the page.
    /// </summary>
    /// <param name="Band">
    ///   Class of the band to search for.
    /// </param>
    function FindBand(Band: TfrxBandClass): TfrxBand;
    /// <summary>
    ///   Returns True, if the report design page is linked to the "Subreport"
    ///   object.
    /// </summary>
    function IsSubReport: Boolean;
    function IsSupportsGuidlines: Boolean; override;
    procedure AlignChildren(IgnoreInvisible: Boolean = False; MirrorModes: TfrxMirrorControlModes = []); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure SetMarginOffset(PageIndex: Integer);
    procedure ClearMarginOffset;
    /// <summary>
    ///   Sets default page size and margins.
    /// </summary>
    procedure SetDefaults; virtual;
    /// <summary>
    ///   Sets the paper size and dimensions.
    /// </summary>
    procedure SetSizeAndDimensions(ASize: Integer; AWidth, AHeight: Extended);
    /// <summary>
    ///   Reference to a Subreport object.
    /// </summary>
    property SubReport: TfrxSubreport read FSubReport;
    /// <summary>
    ///   parent report for current page.
    /// </summary>
    property ParentReport: TfrxReport read FReport;
  published
    { paper }
    /// <summary>
    ///   The paper orientation.
    /// </summary>
    property Orientation: TPrinterOrientation read FOrientation
      write SetOrientation default poPortrait;
    /// <summary>
    ///   The paper width, in millimeters.
    /// </summary>
    property PaperWidth: Extended read FPaperWidth write SetPaperWidth;
    /// <summary>
    ///   The paper height, in millimeters.
    /// </summary>
    property PaperHeight: Extended read FPaperHeight write SetPaperHeight;
    /// <summary>
    ///   The paper size. One of the values DMPAPER_xx, defined in the
    ///   Windows.pas file (for example, DMPAPER_A4). When changing this
    ///   property, other properties (PaperWidth, PaperHeight) changed too. If
    ///   you set the DMPAPER_USER paper size, you should set PaperWidth,
    ///   PaperHeight also.
    /// </summary>
    property PaperSize: Integer read FPaperSize write SetPaperSize;
    { margins }
    /// <summary>
    ///   Left margin, in millimeters.
    /// </summary>
    property LeftMargin: Extended read FLeftMargin write FLeftMargin;
    /// <summary>
    ///   Right margin, in millimeters.
    /// </summary>
    property RightMargin: Extended read FRightMargin write FRightMargin;
    /// <summary>
    ///   Top margin, in millimeters.
    /// </summary>
    property TopMargin: Extended read FTopMargin write FTopMargin;
    /// <summary>
    ///   Bottom margin, in millimeters.
    /// </summary>
    property BottomMargin: Extended read FBottomMargin write FBottomMargin;
    /// <summary>
    ///   Determines whether is necessary to switch left and right margins when
    ///   printing even pages. Default value is False.
    /// </summary>
    property MirrorMargins: Boolean read FMirrorMargins write FMirrorMargins
      default False;
    { columns }
    /// <summary>
    ///   Number of columns on a page. If this value is greather than 1, the
    ///   printing will be performed in several columns. You also should set
    ///   the column width in the ColumnWidth property.
    /// </summary>
    property Columns: Integer read FColumns write SetColumns default 0;
    /// <summary>
    ///   Width of a column, in millimeters.
    /// </summary>
    property ColumnWidth: Extended read FColumnWidth write FColumnWidth;
    /// <summary>
    ///   Column starting positions, in millimeters.
    /// </summary>
    property ColumnPositions: TStrings read FColumnPositions write SetColumnPositions;
    { bins }
    /// <summary>
    ///   Paper tray for the first report page. One of the DMBIN_XXX values,
    ///   defined in the Windows.pas file.
    /// </summary>
    property Bin: Integer read FBin write FBin default DMBIN_AUTO;
    /// <summary>
    ///   Paper tray for report pages, except first page. One of the DMBIN_XXX
    ///   values, defined in the Windows.pas file.
    /// </summary>
    property BinOtherPages: Integer read FBinOtherPages write FBinOtherPages
      default DMBIN_AUTO;
    { other }
    /// <summary>
    ///   The page's background picture. It is printed on each page.
    /// </summary>
    property BackPicture: TPicture read GetBackPicture write SetBackPicture;
    /// <summary>
    ///   If the property is equal to True , then the background page layout
    ///   will be displayed while preview.
    /// </summary>
    property BackPictureVisible: Boolean read FBackPictureVisible write FBackPictureVisible default True;
    /// <summary>
    ///   If the property is equal to True, the background page layout will be
    ///   printed.
    /// </summary>
    property BackPicturePrintable: Boolean read FBackPicturePrintable write FBackPicturePrintable default True;
    /// <summary>
    ///   Stretches background picture to page size.
    /// </summary>
    property BackPictureStretched: Boolean read FBackPictureStretched write FBackPictureStretched default True;
    /// <summary>
    ///   The count of printed pages is similar to RowCout of the TfrxDataBand.
    /// </summary>
    property PageCount: Integer read FPageCount write SetPageCount default 1;
    /// <summary>
    ///   Color of the page.
    /// </summary>
    property Color: TColor read GetColor write SetColor default clNone;
    /// <summary>
    ///   Dataset for the report page. If this property is not empty, the page
    ///   will be printed as many times as there are records in the dataset.
    /// </summary>
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    /// <summary>
    ///   Name of the dataset for the report page. This property duplicates the
    ///   DataSet property.
    /// </summary>
    property DataSetName: String read GetDataSetName write SetDataSetName;
    /// <summary>
    ///   Duplex mode.
    /// </summary>
    property Duplex: TfrxDuplexMode read FDuplex write FDuplex default dmNone;
    /// <summary>
    ///   Frame of the page.
    /// </summary>
    property Frame: TfrxFrame read GetFrame write SetFrame;
    /// <summary>
    ///   If this property is True, the page height will grow depending on
    ///   number of data records on it.
    /// </summary>
    property EndlessHeight: Boolean read FEndlessHeight write FEndlessHeight default False;
    /// <summary>
    ///   If this property is True, the page width will grow depending on
    ///   number of data records on it.
    /// </summary>
    property EndlessWidth: Boolean read FEndlessWidth write FEndlessWidth default False;
    /// <summary>
    ///   If this property is True, the page will have large height in the
    ///   designer. It is useful if you have many bands in the page.
    /// </summary>
    property LargeDesignHeight: Boolean read FLargeDesignHeight
      write FLargeDesignHeight default False;
    /// <summary>
    ///   Set of Mirror modes for current page. Determinate how engine align
    ///   controls and content base on original layout.
    /// </summary>
    property MirrorMode: TfrxMirrorControlModes read FMirrorMode write FMirrorMode;
    /// <summary>
    ///   "Report outline" object represents the "Report outline" control
    ///   element in a preview window. This element displays a treelike
    ///   structure of a finished report. When clicking on any tree node, there
    ///   is a jump to the page connected to this node.
    /// </summary>
    property OutlineText: String read FOutlineText write FOutlineText;
    /// <summary>
    ///   Determines whether to print a page if all its databands are connected
    ///   to empty datasets. Default value is True.
    /// </summary>
    property PrintIfEmpty: Boolean read FPrintIfEmpty write FPrintIfEmpty default True;
    /// <summary>
    ///   Allows to print pages, beginning from blank space of the previous
    ///   page. This option is used when a report template consists of several
    ///   pages or when printing batch (composite) reports.
    /// </summary>
    property PrintOnPreviousPage: Boolean read FPrintOnPreviousPage
      write FPrintOnPreviousPage default False;
    /// <summary>
    ///   Determines whether to print the "Report title" when
    ///   PrintOnPreviousPage set to true and previous page already has "Report
    ///   title" band.
    /// </summary>
    property ShowTitleOnPreviousPage: Boolean read FShowTitleOnPreviousPage
      write FShowTitleOnPreviousPage default True;
    /// <summary>
    ///   If this property is True, the report engine reset logical page number
    ///   when start printing current report template page.
    /// </summary>
    property ResetPageNumbers: Boolean read FResetPageNumbers
      write FResetPageNumbers default False;
    /// <summary>
    ///   Determines whether to print the "Report title" band before "Page
    ///   header" band. Default value is True.
    /// </summary>
    property TitleBeforeHeader: Boolean read FTitleBeforeHeader
      write FTitleBeforeHeader default True;
    /// <summary>
    ///   Name of the script procedure that will be called after printing the
    ///   page.
    /// </summary>
    property OnAfterPrint: TfrxNotifyEvent read FOnAfterPrint write FOnAfterPrint;
    /// <summary>
    ///   Name of the script procedure that will be called before printing the
    ///   page.
    /// </summary>
    property OnBeforePrint: TfrxNotifyEvent read FOnBeforePrint write FOnBeforePrint;
    /// <summary>
    ///   Name of the script procedure that represents an event handler. If the
    ///   handler of this event is allocated, then the FastReport engine is
    ///   blocked and you thus would have to construct a report manually.
    /// </summary>
    property OnManualBuild: TfrxNotifyEvent read FOnManualBuild write FOnManualBuild;
  end;

  { TfrxDialogPage }

  /// <summary>
  ///   The TfrxDialogPage class represents a dialogue form that may contain
  ///   non-visual and visual controls such as "TfrxBDETable", "Button", etc.
  /// </summary>
  TfrxDialogPage = class(TfrxPage)
  private
    FBorderStyle: TFormBorderStyle;
    FCaption: String;
    FColor: TColor;
    FForm: TForm;
    FOnActivate: TfrxNotifyEvent;
    FOnClick: TfrxNotifyEvent;
    FOnDeactivate: TfrxNotifyEvent;
    FOnHide: TfrxNotifyEvent;
    FOnKeyDown: TfrxKeyEvent;
    FOnKeyPress: TfrxKeyPressEvent;
    FOnKeyUp: TfrxKeyEvent;
    FOnResize: TfrxNotifyEvent;
    FOnShow: TfrxNotifyEvent;
    FOnCloseQuery: TfrxCloseQueryEvent;
    FPosition: TPosition;
    FWindowState: TWindowState;
    FClientWidth: Extended;
    FClientHeight: Extended;
    FCurrentPPI: Integer;
    procedure DoInitialize;
    procedure DoOnActivate(Sender: TObject);
    procedure DoOnClick(Sender: TObject);
    procedure DoOnCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoOnDeactivate(Sender: TObject);
    procedure DoOnHide(Sender: TObject);
    procedure DoOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoOnKeyPress(Sender: TObject; var Key: Char);
    procedure DoOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoOnShow(Sender: TObject);
    procedure DoOnResize(Sender: TObject);
    procedure DoModify(Sender: TObject);
    procedure DoOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DoShowModal;
    procedure SetBorderStyle(const Value: TFormBorderStyle);
    procedure SetCaption(const Value: String);
    procedure SetColor(const Value: TColor);
    function GetModalResult: TModalResult;
    procedure SetModalResult(const Value: TModalResult);
    function GetDoubleBuffered: Boolean;
    procedure SetDoubleBuffered(const Value: Boolean);
    function IsClientSizeStored: Boolean;
  protected
    procedure SetLeft(Value: Extended); override;
    procedure SetTop(Value: Extended); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
    procedure SetClientWidth(Value: Extended);
    procedure SetClientHeight(Value: Extended);
    procedure SetScaled(Value: Boolean);
    function GetScaled: Boolean;
    function GetClientWidth: Extended;
    function GetClientHeight: Extended;
    function GetPPIScale: Single;
    procedure FontChanged(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    /// <summary>
    ///   Initialize dialog page.
    /// </summary>
    procedure Initialize;
    function IsContain(X, Y: Extended): Boolean; override;
    /// <summary>
    ///   Show dialog page as Modal form.
    /// </summary>
    function ShowModal: TModalResult;
    /// <summary>
    ///   Dialog page receives this message when user changes PPI of the screen
    ///   or move dialog form to a screen with different PPI.
    /// </summary>
    procedure UpdateDialogPPI(aNewPPI: Integer); virtual;
    /// <summary>
    ///   Used to validate coordinates of some child objects. FreePacal only.
    /// </summary>
    procedure UpdateControlsCoords;
    /// <summary>
    ///   Link to TForm object.
    /// </summary>
    property DialogForm: TForm read FForm;
    /// <summary>
    ///   Modal result of the form.
    /// </summary>
    property ModalResult: TModalResult read GetModalResult write SetModalResult;
    function IsSupportsGuidlines: Boolean; override;
  published
    /// <summary>
    ///   The style of the window.
    /// </summary>
    property BorderStyle: TFormBorderStyle read FBorderStyle write SetBorderStyle default bsSizeable;
    /// <summary>
    ///   The caption of the window.
    /// </summary>
    property Caption: String read FCaption write SetCaption;
    /// <summary>
    ///   The color of the window.
    /// </summary>
    property Color: TColor read FColor write SetColor default clBtnFace;
    /// <summary>
    ///   Enable double buffering for dialog form.
    /// </summary>
    property DoubleBuffered: Boolean read GetDoubleBuffered write SetDoubleBuffered;
    property Height;
    /// <summary>
    ///   Height of client area.
    /// </summary>
    property ClientHeight: Extended read GetClientHeight write SetClientHeight stored IsClientSizeStored;
    property Left;
    /// <summary>
    ///   The initial position of the window.
    /// </summary>
    property Position: TPosition read FPosition write FPosition default poScreenCenter;
    property Top;
    property Width;
    property Scaled: Boolean read GetScaled write SetScaled;
    /// <summary>
    ///   Width of client area.
    /// </summary>
    property ClientWidth: Extended read GetClientWidth write SetClientWidth stored IsClientSizeStored;
    /// <summary>
    ///   Initial state of the window.
    /// </summary>
    property WindowState: TWindowState read FWindowState write FWindowState default wsNormal;
    /// <summary>
    ///   Name of the script procedure that will be called on dialogue form
    ///   activation.
    /// </summary>
    property OnActivate: TfrxNotifyEvent read FOnActivate write FOnActivate;
    /// <summary>
    ///   Name of the script procedure that will be called on click on the
    ///   form.
    /// </summary>
    property OnClick: TfrxNotifyEvent read FOnClick write FOnClick;
    /// <summary>
    ///   Name of the script procedure that will be called on closing the form.
    ///   The event handler should return True to allow closing.
    /// </summary>
    property OnCloseQuery: TfrxCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    /// <summary>
    ///   Name of the script procedure that will be called on deactivating the
    ///   form.
    /// </summary>
    property OnDeactivate: TfrxNotifyEvent read FOnDeactivate write FOnDeactivate;
    /// <summary>
    ///   Name of the script procedure that will be called on hiding the form.
    /// </summary>
    property OnHide: TfrxNotifyEvent read FOnHide write FOnHide;
    /// <summary>
    ///   Name of the script procedure that will be called on pressing a key.
    /// </summary>
    property OnKeyDown: TfrxKeyEvent read FOnKeyDown write FOnKeyDown;
    /// <summary>
    ///   Name of the script procedure that will be called on pressing a key.
    /// </summary>
    property OnKeyPress: TfrxKeyPressEvent read FOnKeyPress write FOnKeyPress;
    /// <summary>
    ///   Name of the script procedure that will be called on releasing a key.
    /// </summary>
    property OnKeyUp: TfrxKeyEvent read FOnKeyUp write FOnKeyUp;
    /// <summary>
    ///   Name of the script procedure that will be called on showing the form.
    /// </summary>
    property OnShow: TfrxNotifyEvent read FOnShow write FOnShow;
    /// <summary>
    ///   Name of the script procedure that will be called on resizing the
    ///   form.
    /// </summary>
    property OnResize: TfrxNotifyEvent read FOnResize write FOnResize;
  end;

  /// <summary>
  ///   The TfrxDataPage represents a datamodule.
  /// </summary>
  TfrxDataPage = class(TfrxPage)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
  published
    property Height;
    property Left;
    property Top;
    property Width;
  end;


{ Report }

  /// <summary>
  ///   The TfrxEngineOptions class represents a set of properties related to
  ///   the FastReport engine. Instance of this class is stored in the
  ///   TfrxReport.EngineOptions.
  /// </summary>
  TfrxEngineOptions = class(TPersistent)
  private
    FConvertNulls: Boolean;
    FDestroyForms: Boolean;
    FDoublePass: Boolean;
    FMaxMemSize: Integer;
    FPrintIfEmpty: Boolean;
    FReportThread: TThread;
    FEnableThreadSafe: Boolean;
    FSilentMode: TfrxSilentMode;
    FTempDir: String;
    FUseFileCache: Boolean;
    FUseGlobalDataSetList: Boolean;
    FIgnoreDevByZero: Boolean;
    FIgnoreExprError: Boolean;
    FZeroPrecisionValue: Extended;

    procedure SetSilentMode(Mode: Boolean);
    function GetSilentMode: Boolean;
  public
    constructor Create;
    /// <summary>
    ///   Copies the contents from another object.
    /// </summary>
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Copies properties responsible for multi-thread behaviour from another
    ///   object.
    /// </summary>
    procedure AssignThreadProps(Source: TPersistent);
    /// <summary>
    ///   Clears all properties and fills them by default values.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Deprecated. Not used.
    /// </summary>
    property ReportThread: TThread read FReportThread write FReportThread;
    /// <summary>
    ///   Determines whether to save the report to the temporary stream before
    ///   run a report and restore it after report is finished. Default is
    ///   True.
    /// </summary>
    property DestroyForms: Boolean read FDestroyForms write FDestroyForms;
    /// <summary>
    ///   Switch TfrxReport component in multi-thread mode. It disables unsafe
    ///   routines like ProcessMessages cycle. <br />
    /// </summary>
    property EnableThreadSafe: Boolean read FEnableThreadSafe write FEnableThreadSafe;
    /// <summary>
    ///   The property determines if its necessary to use the global list of
    ///   DataSet or to use the list of EnabledDataSet collection of TfrxReport
    ///   component. Default-True.
    /// </summary>
    property UseGlobalDataSetList: Boolean read FUseGlobalDataSetList write FUseGlobalDataSetList;
    /// <summary>
    ///   This property contains precision value for zero comparison operation
    ///   in Text objects(used with HideZeros property). The value in Text
    ///   object below precision value interpret as zero. Default is 1E-17.
    /// </summary>
    property ZeroPrecisionValue: Extended read FZeroPrecisionValue write FZeroPrecisionValue;
  published
    /// <summary>
    ///   Converts the "Null" value of the DB field into "0," "False," or empty
    ///   string, depending on the field type. Default value is True.
    /// </summary>
    property ConvertNulls: Boolean read FConvertNulls write FConvertNulls default True;
    /// <summary>
    ///   Makes a report a two-pass one. Default value is False.
    /// </summary>
    property DoublePass: Boolean read FDoublePass write FDoublePass default False;
    /// <summary>
    ///   The maximum size of memory in Mbytes, allocated to the report pages'
    ///   cache. It becomes useful in cases when the "UseFileCache" property is
    ///   equal to "True." If a report begins to occupy more memory during
    ///   construction, caching of the constructed report pages into a
    ///   temporary file is performed. This property is inexact and allows only
    ///   approximate determination of the memory limit. Default value is 10.
    /// </summary>
    property MaxMemSize: Integer read FMaxMemSize write FMaxMemSize default 10;
    /// <summary>
    ///   Defines, whether it is necessary to print a blank report (one which
    ///   contains no data lines). Default value is True.
    /// </summary>
    property PrintIfEmpty: Boolean read FPrintIfEmpty write FPrintIfEmpty default True;
    /// <summary>
    ///   Deprecated(See NewSilentMode). "Silent" mode. When errors occurred
    ///   during loading or <br />running report, no dialog windows will be
    ///   shown. All errors will be <br />contained in the TfrxReport.Errors
    ///   property. This mode is useful for <br />server applications. Default
    ///   value is False. <br />
    /// </summary>
    property SilentMode: Boolean read GetSilentMode write SetSilentMode default False;
    /// <summary>
    ///   Set behaviour of exceptions handling during report execution.
    /// </summary>
    property NewSilentMode: TfrxSilentMode read FSilentMode write FSilentMode default simMessageBoxes;
    /// <summary>
    ///   Specifies a path to the directory for storing temporary files.
    /// </summary>
    property TempDir: String read FTempDir write FTempDir;
    /// <summary>
    ///   Defines, whether it is necessary to use report pages caching into a
    ///   file (see the "MaxMemSize" property). Default value is False.
    /// </summary>
    property UseFileCache: Boolean read FUseFileCache write FUseFileCache default False;
    /// <summary>
    ///   Ignore all "Division by zero" exceptions inside expression
    ///   calculation.
    /// </summary>
    property IgnoreDevByZero: Boolean read FIgnoreDevByZero write FIgnoreDevByZero default False;
    /// <summary>
    ///   Ignore all expression exceptions inside expression calculation.
    /// </summary>
    property IgnoreExprError: Boolean read FIgnoreExprError write FIgnoreExprError default False;
  end;

  /// <summary>
  ///   The TfrxPrintOptions class represents a set of properties, which relate
  ///   to the report printing. Instance of this class is stored in the
  ///   TfrxReport.PrintOptions.
  /// </summary>
  TfrxPrintOptions = class(TPersistent)
  private
    FCopies: Integer;
    FCollate: Boolean;
    FPageNumbers: String;
    FPagesOnSheet: Integer;
    FPrinter: String;
    FPrintMode: TfrxPrintMode;
    FPrintOnSheet: Integer;
    FPrintPages: TfrxPrintPages;
    FReverse: Boolean;
    FShowDialog: Boolean;
    FSwapPageSize: Boolean;
    FPrnOutFileName: String;
    FDuplex: TfrxDuplexMode;
    FSplicingLine: Integer;
  public
    constructor Create;
    /// <summary>
    ///   Copies the contents from another object.
    /// </summary>
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Clears all properties and fills them by default values.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   File name of printed output when prints to a file.
    /// </summary>
    property PrnOutFileName: String read FPrnOutFileName write FPrnOutFileName;
    /// <summary>
    ///   Global duplex settings. Set only after prepare report.
    /// </summary>
    property Duplex: TfrxDuplexMode read FDuplex write FDuplex;// set only after prepare report, need to store global duplex
    /// <summary>
    ///   Size of slicing line used for some Print modes.
    /// </summary>
    property SplicingLine: Integer read FSplicingLine write FSplicingLine default 3;
  published
    /// <summary>
    ///   The number of the printable copies by default. Default value is 1.
    /// </summary>
    property Copies: Integer read FCopies write FCopies default 1;
    /// <summary>
    ///   Whether to collate the copies. Default value is True.
    /// </summary>
    property Collate: Boolean read FCollate write FCollate default True;
    /// <summary>
    ///   Page numbers, which are to be printed. For example, "1,3,5-12,17-".
    /// </summary>
    property PageNumbers: String read FPageNumbers write FPageNumbers;
    /// <summary>
    ///   Printer name.
    /// </summary>
    property Printer: String read FPrinter write FPrinter;
    /// <summary>
    ///   The print mode: default; split large page on several smaller pages;
    ///   join several small pages on a large page; print a page on a specified
    ///   paper size (use scaling).
    /// </summary>
    property PrintMode: TfrxPrintMode read FPrintMode write FPrintMode default pmDefault;
    /// <summary>
    ///   The paper size to print a report on. Used if PrintMode is not
    ///   pmDefault. One of DMBIN_XXX values defined in the Windows.pas.
    /// </summary>
    property PrintOnSheet: Integer read FPrintOnSheet write FPrintOnSheet;
    /// <summary>
    ///   Defines the pages to be printed. The following values are available: <br />
    ///   ppAll - all; <br />ppOdd - odd; <br />ppEven - even. <br />
    /// </summary>
    property PrintPages: TfrxPrintPages read FPrintPages write FPrintPages default ppAll;
    /// <summary>
    ///   Determines whether to print pages in reverse order.
    /// </summary>
    property Reverse: Boolean read FReverse write FReverse default False;
    /// <summary>
    ///   Whether to display a print dialogue. Default value is True.
    /// </summary>
    property ShowDialog: Boolean read FShowDialog write FShowDialog default True;
    /// <summary>
    ///   Not used.
    /// </summary>
    property SwapPageSize: Boolean read FSwapPageSize write FSwapPageSize stored False;// remove it
  end;

  /// <summary>
  ///   The TfrxPreviewOptions class represents a set of properties, relating
  ///   to the report preview. Instance of this class is stored in the
  ///   TfrxReport.PreviewOptions.
  /// </summary>
  TfrxPreviewOptions = class(TPersistent)
  private
    FAllowEdit: Boolean;
    FAllowPreviewEdit: Boolean;
    FButtons: TfrxPreviewButtons;
    FDoubleBuffered: Boolean;
    FMaximized: Boolean;
    FMDIChild: Boolean;
    FModal: Boolean;
    FOutlineExpand: Boolean;
    FOutlineVisible: Boolean;
    FOutlineWidth: Integer;
    FPagesInCache: Integer;
    FShowCaptions: Boolean;
    FThumbnailVisible: Boolean;
    FZoom: Extended;
    FZoomMode: TfrxZoomMode;
    FPictureCacheInFile: Boolean;
    FRTLPreview: Boolean;
  public
    constructor Create;
    /// <summary>
    ///   Copies the contents from another object.
    /// </summary>
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Clears all properties and fills them by default values.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Enables RTL page output in preview.
    /// </summary>
    property RTLPreview: Boolean read FRTLPreview write FRTLPreview;
  published
    /// <summary>
    ///   Enables or disables a finished report editing. Default value is True.
    /// </summary>
    property AllowEdit: Boolean read FAllowEdit write FAllowEdit default True;
    /// <summary>
    ///   Enables InPlace editors in the report preview. Allows user to edit
    ///   prepared report text and other properties without the report
    ///   designer.
    /// </summary>
    property AllowPreviewEdit: Boolean read FAllowPreviewEdit write FAllowPreviewEdit default True;
    /// <summary>
    ///   A set of buttons, which will be available in the preview window. You
    ///   can combine any of these values. Default value is: all buttons.
    /// </summary>
    property Buttons: TfrxPreviewButtons read FButtons write FButtons;
    /// <summary>
    ///   A double-buffer mode for the preview window. If enabled (by default),
    ///   the preview window will not flicker during repainting, but the
    ///   process speed will be reduced.
    /// </summary>
    property DoubleBuffered: Boolean read FDoubleBuffered write FDoubleBuffered default True;
    /// <summary>
    ///   Defines if the preview window is maximized. Default value is True.
    /// </summary>
    property Maximized: Boolean read FMaximized write FMaximized default True;
    /// <summary>
    ///   Defines if the preview window is MDIChild (for MDI interface
    ///   organizing). Default value is False.
    /// </summary>
    property MDIChild: Boolean read FMDIChild write FMDIChild default False;
    /// <summary>
    ///   Defines if the preview window is modal. Default value is True.
    /// </summary>
    property Modal: Boolean read FModal write FModal default True;
    /// <summary>
    ///   Determines whether to expand all outline items.
    /// </summary>
    property OutlineExpand: Boolean read FOutlineExpand write FOutlineExpand default True;
    /// <summary>
    ///   Defines if the panel with the report outline is visible. Default
    ///   value is False.
    /// </summary>
    property OutlineVisible: Boolean read FOutlineVisible write FOutlineVisible default False;
    /// <summary>
    ///   Defines width of the panel with the report outline, in pixels.
    ///   Default value is 120.
    /// </summary>
    property OutlineWidth: Integer read FOutlineWidth write FOutlineWidth default 120;
    /// <summary>
    ///   Determines how many prepared pages are located in memory. Other
    ///   stored as serialized XML and loads by request.
    /// </summary>
    property PagesInCache: Integer read FPagesInCache write FPagesInCache default 50;
    /// <summary>
    ///   Defines if the panel with the report thumbnail is visible. Default
    ///   value is False.
    /// </summary>
    property ThumbnailVisible: Boolean read FThumbnailVisible write FThumbnailVisible default False;
    /// <summary>
    ///   Defines if button captions are displayed. When enabling thisproperty,
    ///   you should limit the number of the displayed buttons in theButtons
    ///   property, since all the buttons will not find room on thescreen.
    /// </summary>
    property ShowCaptions: Boolean read FShowCaptions write FShowCaptions default False;
    /// <summary>
    ///   Default scale of the report in the report preview.
    /// </summary>
    property Zoom: Extended read FZoom write FZoom;
    /// <summary>
    ///   Default zooming mode.
    /// </summary>
    property ZoomMode: TfrxZoomMode read FZoomMode write FZoomMode default zmDefault;
    /// <summary>
    ///   Activates the mode of caching all pictures in the file, saves memory
    ///   while displaying the reports with a large quantity of pictures.
    /// </summary>
    property PictureCacheInFile: Boolean read FPictureCacheInFile write FPictureCacheInFile default False;
  end;

  /// <summary>
  ///   The TfrxReportOptions class represents a set of properties relating to
  ///   the report. Instance of this class is stored in the
  ///   TfrxReport.ReportOptions.
  /// </summary>
  TfrxReportOptions = class(TPersistent)
  private
    FAuthor: String;
    FCompressed: Boolean;
    FConnectionName: String;
    FCreateDate: TDateTime;
    FDescription: TStrings;
    FInitString: String;
    FName: String;
    FLastChange: TDateTime;
    FPassword: String;
    FPicture: TPicture;
    FReport: TfrxReport;
    FVersionBuild: String;
    FVersionMajor: String;
    FVersionMinor: String;
    FVersionRelease: String;
    FPrevPassword: String;
    FHiddenPassword: String;
    FInfo: Boolean;
    procedure SetDescription(const Value: TStrings);
    procedure SetPicture(const Value: TPicture);
    procedure SetConnectionName(const Value: String);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    /// <summary>
    ///   Copies the contents from another object.
    /// </summary>
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Clears all properties and fills them by default values.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   If HiddenPassword is not set, shows password dialog and check
    ///   password inputted by user. Otherwise uses HiddenPassword as a user
    ///   defined password. <br />
    /// </summary>
    function CheckPassword: Boolean;
    /// <summary>
    ///   Stores previous used password.
    /// </summary>
    property PrevPassword: String write FPrevPassword;
    property Info: Boolean read FInfo write FInfo;
    /// <summary>
    ///   Allows to set password which will be used for report in LoadFrom
    ///   method without showing dialog to user.
    /// </summary>
    property HiddenPassword: String read FHiddenPassword write FHiddenPassword;
  published
    /// <summary>
    ///   Report author.
    /// </summary>
    property Author: String read FAuthor write FAuthor;
    /// <summary>
    ///   Determines whether to compress a report file. The gzip compression is
    ///   used. You must put the TfrxGZipCompressor component onto your form.
    /// </summary>
    property Compressed: Boolean read FCompressed write FCompressed default False;
    /// <summary>
    ///   Not used.
    /// </summary>
    property ConnectionName: String read FConnectionName write SetConnectionName;
    /// <summary>
    ///   Report creation date.
    /// </summary>
    property CreateDate: TDateTime read FCreateDate write FCreateDate;
    /// <summary>
    ///   Report description.
    /// </summary>
    property Description: TStrings read FDescription write SetDescription;
    /// <summary>
    ///   Dot-matrix printer init string. Used only in dot-matrix reports.
    /// </summary>
    property InitString: String read FInitString write FInitString;
    /// <summary>
    ///   Report name.
    /// </summary>
    property Name: String read FName write FName;
    /// <summary>
    ///   The date the report was last modified.
    /// </summary>
    property LastChange: TDateTime read FLastChange write FLastChange;
    /// <summary>
    ///   Report password. If this property is not blank, a password is
    ///   required when opening a report.
    /// </summary>
    property Password: String read FPassword write FPassword;
    /// <summary>
    ///   Report picture.
    /// </summary>
    property Picture: TPicture read FPicture write SetPicture;
    /// <summary>
    ///   Properties, which detect the number of a version.
    /// </summary>
    property VersionBuild: String read FVersionBuild write FVersionBuild;
    /// <summary>
    ///   Properties, which detect the number of a version.
    /// </summary>
    property VersionMajor: String read FVersionMajor write FVersionMajor;
    /// <summary>
    ///   Properties, which detect the number of a version.
    /// </summary>
    property VersionMinor: String read FVersionMinor write FVersionMinor;
    /// <summary>
    ///   Properties, which detect the number of a version.
    /// </summary>
    property VersionRelease: String read FVersionRelease write FVersionRelease;
  end;


  /// <summary>
  ///   The TfrxReportOptions class represents an expression cache. The
  ///   instance of this class used in the report object to store most used
  ///   expressions and link them with script items. It significantly increases
  ///   expression calculation (like aggregate functions) in a huge reports
  ///   because syntax parsing of expressions called only once.
  /// </summary>
  TfrxExpressionCache = class(TObject)
  private
    FExpressions: TStringList;
    FMainScript: TfsScript;
    FScript: TfsScript;
    FScriptLanguage: String;
    procedure SetCaseSensitive(const Value: Boolean);
    function GetCaseSensitive: Boolean;
  public
    /// <summary>
    ///   Constructor winch receives default script object.
    /// </summary>
    /// <param name="AScript">
    ///   Default script object.
    /// </param>
    constructor Create(AScript: TfsScript);
    destructor Destroy; override;
    /// <summary>
    ///   Clears expression cache.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Calculates an expression.
    /// </summary>
    /// <param name="Expression">
    ///   Expression to calculate.
    /// </param>
    /// <param name="ErrorMsg">
    ///   Out. Contains error message if error occurred.
    /// </param>
    /// <param name="AScript">
    ///   Script object used to calculate an expression.
    /// </param>
    function Calc(const Expression: String; var ErrorMsg: String;
      AScript: TfsScript): Variant;
    /// <summary>
    ///   If True , then the expression will be catching subject to the letter
    ///   list . It is necessary to use the same text with different letter
    ///   list in expression.
    /// </summary>
    property CaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
  end;

  /// <summary>
  ///   The TfrxDataSetItem class represents a dataset in the report dataset's
  ///   list. Dataset's list is contained in the TfrxReportDataSets class.
  /// </summary>
  TfrxDataSetItem = class(TCollectionItem)
  private
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  published
    /// <summary>
    ///   Reference to the dataset.
    /// </summary>
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    /// <summary>
    ///   Name of the dataset. This property duplicates the DataSet property.
    /// </summary>
    property DataSetName: String read GetDataSetName write SetDataSetName;
  end;

  /// <summary>
  ///   The TfrxReportDataSets class represents the report dataset's list.
  ///   Instance of this class is stored in the TfrxReport.Datasets property.
  /// </summary>
  TfrxReportDataSets = class(TCollection)
  private
    FReport: TfrxReport;
    function GetItem(Index: Integer): TfrxDataSetItem;
  public
    /// <summary>
    ///   Creates the class instance. Do not use this method directly, because
    ///   instance of this class is stored in the TfrxReport.Datasets property.
    /// </summary>
    constructor Create(AReport: TfrxReport);
    /// <summary>
    ///   Initializes dataset list.
    /// </summary>
    procedure Initialize;
    /// <summary>
    ///   Finalize all datasets in the list.
    /// </summary>
    procedure Finalize;
    /// <summary>
    ///   Adds an element to the list.
    /// </summary>
    procedure Add(ds: TfrxDataSet); overload;
    procedure Add(AName: String); overload;
    /// <summary>
    ///   Finds an element in the list.
    /// </summary>
    function Find(ds: TfrxDataSet): TfrxDataSetItem; overload;
    /// <summary>
    ///   Finds an element in the list.
    /// </summary>
    function Find(const Name: String): TfrxDataSetItem; overload;
    /// <summary>
    ///   Delete an element in the list.
    /// </summary>
    procedure Delete(const Name: String); overload;
    /// <summary>
    ///   List of elements.
    /// </summary>
    property Items[Index: Integer]: TfrxDataSetItem read GetItem; default;
  end;

  TfrxStyleSheets = class;

  TfrxNamedCollectionItem = class(TfrCollectionItem)
  private
    FName: String;
    procedure SetName(const Value: String);
  protected
    function GetInheritedName: String; override;
    procedure NameChange(const ANewName: string; const AOldName: string); virtual;
  public
    /// <summary>
    ///   Creates an unique name of style.
    /// </summary>
    procedure CreateUniqueName;
    property Name: String read FName write SetName;
  end;

  TfrxNamedCollection = class(TfrCollection)
  private
    function GetItem(Index: Integer): TfrxNamedCollectionItem;
  protected
    function InternalFind(const Name: String): TfrxNamedCollectionItem;
    property Items[Index: Integer]: TfrxNamedCollectionItem read GetItem; default;
  end;

  /// <summary>
  ///   The TfrxCustomStyleItem represents a base style. Style is an element, which
  ///   possesses a name and properties, and determines design attributes, i.e.
  ///   color, font and frame. The style determines the way a report object
  ///   should be designed. The objects such as TfrxMemoView have the Style
  ///   property, which is a property intended to set the style name. When
  ///   applying a value to this property, the style design attributes are
  ///   copied to the object.
  /// </summary>
  TfrxCustomStyleItem = class(TfrxNamedCollectionItem)
  private
    FFont: TFont;
    FFrame: TfrxFrame;
    FApplyFont: Boolean;
    FApplyFill: Boolean;
    FApplyFrame: Boolean;
    FFill: TfrxCustomFill;
    procedure SetFont(const Value: TFont);
    procedure SetFrame(const Value: TfrxFrame);
    function GetFillType: TfrxFillType;
    procedure SetFill(const Value: TfrxCustomFill);
    procedure SetFillType(const Value: TfrxFillType);
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
    function GetFill: TfrxCustomFill;
    function GetFont: TFont;
    function GetFrame: TfrxFrame;
  protected
    function GetFontRef: TFont; virtual;
    function GetFillRef: TfrxCustomFill; virtual;
    procedure SetFillRef(const Value: TfrxCustomFill); virtual;
    function GetFrameRef: TfrxFrame; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    /// <summary>
    ///   Style name.
    /// </summary>
    property Name;
    /// <summary>
    ///   Deprecated. Background color.
    /// </summary>
    property Color: TColor read GetColor write SetColor stored False;
    /// <summary>
    ///   Font settings.
    /// </summary>
    property Font: TFont read GetFont write SetFont;
    /// <summary>
    ///   Frame settings.
    /// </summary>
    property Frame: TfrxFrame read GetFrame write SetFrame;
    /// <summary>
    ///   Apply font from the style to an object.
    /// </summary>
    property ApplyFont: Boolean read FApplyFont write FApplyFont default True;
    /// <summary>
    ///   Apply fill from the style to an object.
    /// </summary>
    property ApplyFill: Boolean read FApplyFill write FApplyFill default True;
    /// <summary>
    ///   Apply frame from the style to an object.
    /// </summary>
    property ApplyFrame: Boolean read FApplyFrame write FApplyFrame default True;
 	  /// <summary>
 	  ///   Fill type.
 	  /// </summary>
 	  property FillType: TfrxFillType read GetFillType write SetFillType default ftBrush;
    /// <summary>
    ///   Reference to Fill object.
    /// </summary>
    property Fill: TfrxCustomFill read GetFill write SetFill;
  end;

  /// <summary>
  ///   The TfrxStyleItem represents a style. Style is an element, which
  ///   possesses a name and properties, and determines design attributes, i.e.
  ///   color, font and frame. The style determines the way a report object
  ///   should be designed. The objects such as TfrxMemoView have the Style
  ///   property, which is a property intended to set the style name. When
  ///   applying a value to this property, the style design attributes are
  ///   copied to the object.
  /// </summary>
  TfrxStyleItem = class(TfrxCustomStyleItem)
  private
    FStyleSheet: TfrxStyleSheets;
    procedure SetStyleSheet(const Value: TfrxStyleSheets);
    function IsStyleSheetActive: Boolean;
    function GetActiveStyleSheet: String;
    function IsStyleSheetStored: Boolean;
  protected
    function GetFontRef: TFont; override;
    function GetFillRef: TfrxCustomFill; override;
    procedure SetFillRef(const Value: TfrxCustomFill); override;
    function GetFrameRef: TfrxFrame; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure WriteProperties(Writer: TObject; Ancestor: TfrCollection; Owner: TComponent); override;
    procedure ReadProperties(PropName: String; Reader: TObject; Ancestor: TfrCollection); override;
    /// <summary>
    ///   Updates style sheets of an element from a list.
    /// </summary>
    procedure UpdateSheets(AList: TStrings);
  published
    /// <summary>
    ///   Reference to StyleSheet collection object.
    /// </summary>
    property StyleSheet: TfrxStyleSheets read FStyleSheet write SetStyleSheet stored IsStyleSheetStored;
  end;

  TfrxStyleBookMode = (fsbDesigner, fsbPreview);
  TfrxStyleBookModes = set of TfrxStyleBookMode;

  /// <summary>
  ///   The TfrxStyles class represents a set of styles. It comprises methods
  ///   for performing such set operations as reading, saving, adding,
  ///   deleting, as well as searching for a style. The set of styles file has
  ///   FS3 extension by default.
  /// </summary>
  TfrxStyles = class(TfrxNamedCollection)
  private
    FName: String;
    FReport: TfrxReport;
    FStyleSheetNames: TStringList;
    FActiveStyleSheet: String;
    FDefaultStyleLocked: Boolean;
    FStyleBookMode: TfrxStyleBookModes;
    function GetItem(Index: Integer): TfrxStyleItem;
    procedure UpdateSheets(AList: TStrings);
    procedure SetActiveStyleSheet(const Value: String);
    function IsStyleSheetActive: Boolean;
    procedure InternalSynchSheetName(const ANewName: string; const AOldName: string);
    procedure SetStyleBookMode(const Value: TfrxStyleBookModes);
    function GetActiveStyleSheet: String;
  protected
    property UpdateCount;
    procedure LockDefaultStyle;
    procedure UnlockDefaultStyle;
  public
    /// <summary>
    ///   Creates the styles set. One can specify "nil" instead of "AReport,"
    ///   however in this case a user would be unable to use the "Apply"
    ///   method.
    /// </summary>
    constructor Create(AReport: TfrxReport);
    destructor Destroy; override;
    /// <summary>
    ///   Adds a new style.
    /// </summary>
    function Add: TfrxStyleItem;
     /// <summary>
    ///   Adds a new style sheet with generated name.
    /// </summary>
    function AddStyleSheet: String;
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Assigns while style collection with style sheets to a preview pages styles.
    /// </summary>
    procedure AssignAsPreview(Source: TfrxStyles);
    procedure ClearAll;
    procedure EndUpdate; override;
    /// <summary>
    ///   Returns the style with the given name.
    /// </summary>
    function Find(const AName: String): TfrxStyleItem;
    /// <summary>
    ///   Applies a set to a report.
    /// </summary>
    procedure Apply;
    /// <summary>
    ///   Deletes  StyleSheet with given name from a collection
    /// </summary>
    procedure DeleteStyleSheet(const AName: String);
    /// <summary>
    ///   Returns the list of the styles names.
    /// </summary>
    procedure GetList(List: TStrings);
    /// <summary>
    ///   Returns the list of the style sheets names.
    /// </summary>
    procedure GetStyleSheetList(List: TStrings);
    /// <summary>
    ///   Reads a set from a file.
    /// </summary>
    procedure LoadFromFile(const FileName: String);
    /// <summary>
    ///   Reads a set from a stream.
    /// </summary>
    procedure LoadFromStream(Stream: TStream);
    /// <summary>
    ///   Reads a set from a XML item.
    /// </summary>
    procedure LoadFromXMLItem(AItem: TfrXMLItem; AOldXMLFormat: Boolean = True); overload;
    /// <summary>
    ///   Reads a set from a XML item.
    /// </summary>
    procedure LoadFromXMLItem(AItem: TfrXMLItem; AAncestor: TfrxStyles; AOldXMLFormat: Boolean = True); overload;
    /// <summary>
    ///   Saves a set to a file.
    /// </summary>
    procedure SaveToFile(const FileName: String);
    /// <summary>
    ///   Saves a set to a stream.
    /// </summary>
    procedure SaveToStream(Stream: TStream);
    /// <summary>
    ///   Saves a set to a XML item.
    /// </summary>
    procedure SaveToXMLItem(AItem: TfrXMLItem); overload;
    /// <summary>
    ///   Saves a set to a XML item.
    /// </summary>
    procedure SaveToXMLItem(AItem: TfrXMLItem; AAncestor: TfrxStyles); overload;
    /// <summary>
    ///   Renames StyleSheet with a name to a new name.
    /// </summary>
    function RenameStyleSheet(const AName: String; const ANewName: String): Boolean;
    /// <summary>
    ///   Assigns appearance from an objects with assigned styles to style elements
    /// </summary>
    procedure UpdateFromObjects(AList: TList);
    /// <summary>
    ///   Active style sheet in current styles collection
    /// </summary>
    property ActiveStyleSheet: String read GetActiveStyleSheet write SetActiveStyleSheet;
    /// <summary>
    ///   List of styles in the set.
    /// </summary>
    property Items[Index: Integer]: TfrxStyleItem read GetItem; default;
    /// <summary>
    ///   A set's name.
    /// </summary>
    property Name: String read FName write FName;
  published
    property StyleBookMode: TfrxStyleBookModes read FStyleBookMode write SetStyleBookMode default [];
  end;

  TfrxStyleSheetItem = class(TfrxCustomStyleItem)
  protected
    procedure NameChange(const ANewName: string; const AOldName: string); override;
  end;

  TfrxStyleSheets = class(TfrxNamedCollection)
  private
    FName: String;
    FStyles: TfrxStyles;
    FParentStyle: TfrxStyleItem;
    FCachedItem: TfrxStyleSheetItem;
    function GetItem(Index: Integer): TfrxStyleSheetItem;
  public
    /// <summary>
    ///   Creates the styles set. One can specify "nil" instead of "AReport,"
    ///   however in this case a user would be unable to use the "Apply"
    ///   method.
    /// </summary>
    constructor Create(AStyles: TfrxStyles; AParentStyle: TfrxStyleItem);
    /// <summary>
    ///   Adds a new style.
    /// </summary>
    function Add: TfrxStyleSheetItem;
    procedure AddSheet(const AName: String);
    procedure DeleteByName(const AName: String);
    function GetSheetItem(const AName: String): TfrxStyleSheetItem;
    /// <summary>
    ///   Returns the style with the given name.
    /// </summary>
    function Find(const Name: String): TfrxStyleSheetItem;
    procedure UpdateSheets(AList: TStrings);
    /// <summary>
    ///   List of styles in the set.
    /// </summary>
    property Items[Index: Integer]: TfrxStyleSheetItem read GetItem; default;
    /// <summary>
    ///   A set's name.
    /// </summary>
    property Name: String read FName write FName;
  end;

  /// <summary>
  ///   The TfrxStyleSheet class represents a styles' library. It has methods
  ///   for the library reading/saving, as well as adding, deleting, and style
  ///   sets' searching.
  /// </summary>
  TfrxStyleScheme = class(TObject)
  private
    FItems: TList;
    function GetItems(Index: Integer): TfrxStyles;
  public
    /// <summary>
    ///   Constructs a library.
    /// </summary>
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Clears a library.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Deletes a set with certain number.
    /// </summary>
    procedure Delete(Index: Integer);
    /// <summary>
    ///   Returns the list of the names of styles' sets.
    /// </summary>
    procedure GetList(List: TStrings);
    /// <summary>
    ///   Loads a library from a file.
    /// </summary>
    procedure LoadFromFile(const FileName: String);
    /// <summary>
    ///   Loads a library from a stream.
    /// </summary>
    procedure LoadFromStream(Stream: TStream);
    /// <summary>
    ///   Saves a library to a file.
    /// </summary>
    procedure SaveToFile(const FileName: String);
    /// <summary>
    ///   Saves a library to a stream.
    /// </summary>
    procedure SaveToStream(Stream: TStream);
    /// <summary>
    ///   Adds a new set of styles to the library.
    /// </summary>
    function Add: TfrxStyles;
    /// <summary>
    ///   Returns a number of styles' sets in the library.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Returns a set with the set name.
    /// </summary>
    function Find(const Name: String): TfrxStyles;
    /// <summary>
    ///   Returns a set number with the given name.
    /// </summary>
    function IndexOf(const Name: String): Integer;
    /// <summary>
    ///   The list of styles' sets.
    /// </summary>
    property Items[Index: Integer]: TfrxStyles read GetItems; default;
  end;

  /// <summary>
  ///   The TfrxPreviewPagesList class represents list of
  ///   TfrxCustomPreviewPages. Each TfrxReport instance can have several
  ///   TfrxCustomPreviewPages instances. This class used to manage all preview
  ///   pages in the report component.
  /// </summary>
  TfrxPreviewPagesList = class
  private
    FReport: TfrxReport;
    { TODO: Make Named list, can use it latet in server components }
    FList: TList;
    FCurrentIndex: Integer;
    function GetCurrent: TfrxCustomPreviewPages;
    function GetMain: TfrxCustomPreviewPages;
    procedure SetCurrent(const Value: TfrxCustomPreviewPages);
    procedure SetCurrentIndex(Index: Integer);
    procedure SetMain(const Value: TfrxCustomPreviewPages);
    procedure CurPagesChanged;
  public
    /// <summary>
    ///   Constructor.
    /// </summary>
    /// <param name="aReport">
    ///   The report component.
    /// </param>
    constructor Create(aReport: TfrxReport);
    destructor Destroy; override;
    /// <summary>
    ///   Clears and free all preview pages instances instead main.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Returns count of preview pages in collection.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Adds new instance of PreviewPages.
    /// </summary>
    function Add: TfrxCustomPreviewPages;
    /// <summary>
    ///   Adds new instance of PreviewPages and set it active(current).
    /// </summary>
    function AddAsCurrent: TfrxCustomPreviewPages;
    /// <summary>
    ///   Delete instance of TfrxCustomPreviewPages from list.
    /// </summary>
    /// <param name="aPages">
    ///   Reference to instance that should be deleted.
    /// </param>
    procedure Delete(aPages: TfrxCustomPreviewPages); overload;
    /// <summary>
    ///   Delete instance of TfrxCustomPreviewPages from list by index.
    /// </summary>
    /// <param name="Index">
    ///   Index in list to delete.
    /// </param>
    procedure Delete(Index: Integer); overload;
    /// <summary>
    ///   Stores current active preview pages. TfrxReport uses this property
    ///   for any operations with preview pages.
    /// </summary>
    property Current: TfrxCustomPreviewPages read GetCurrent write SetCurrent;
    /// <summary>
    ///   Stores main preview pages. This pages could not be deleted by clear
    ///   method, it frees at destruction.
    /// </summary>
    property Main: TfrxCustomPreviewPages read GetMain write SetMain;
  end;

{$IFDEF DELPHI16}
/// <summary>
///   The TfrxReport component is the main one. One TfrxReport component
///   contains one report. In design-time, double-clicking the component calls
///   the report designer. The component has all necessary properties and
///   methods for report loading and saving, design and viewing.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxReport = class(TfrxComponent)
  private
    FCurObject: String;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FDataSets: TfrxReportDatasets;
    FDesigner: TfrxCustomDesigner;
    FDotMatrixReport: Boolean;
    FDrawText: Pointer;
    FDrillState: TStrings;
    FEnabledDataSets: TfrxReportDataSets;
    FEngine: TfrxCustomEngine;
    FEngineOptions: TfrxEngineOptions;
    FErrors: TStrings;
    FExpressionCache: TfrxExpressionCache;
    FFileName: String;
    FIniFile: String;
    FLoadStream: TStream;
    FLocalValue: TfsCustomVariable;
    FSelfValue: TfsCustomVariable;
    FModified: Boolean;
    FOldStyleProgress: Boolean;
    FParentForm: TForm;
    FParentReport: String;
    FParentReportObject: TfrxReport;
    FPreviewPagesList: TfrxPreviewPagesList;
    FPreview: TfrxCustomPreview;
    FPreviewForm: TForm;
    FPreviewOptions: TfrxPreviewOptions;
    FPrintOptions: TfrxPrintOptions;
    FProgress: TfrxProgress;
    FReloading: Boolean;
    FReportOptions: TfrxReportOptions;
    FScript: TfsScript;
    FSaveParentScript: TfsScript;
    FScriptLanguage: String;
    FScriptText: TStrings;
    FFakeScriptText: TStrings; {fake object}
    FShowProgress: Boolean;
    FStoreInDFM: Boolean;
    FStyles: TfrxStyles;
    FSysVariables: TStrings;
    FTerminated: Boolean;
    FTimer: TTimer;
    FVariables: TfrxVariables;
    FVersion: String;
    FXMLSerializer: TObject;
    FStreamLoaded: Boolean;
    FIsScriptObjectsAdded: Boolean;
    FCommandManager: TfrxDelayedCommandManager;
    FPreparing: Boolean;

    FOnAfterPrint: TfrxBeforePrintEvent;
    FOnAfterPrintReport: TNotifyEvent;
    FOnBeforeConnect: TfrxBeforeConnectEvent;
    FOnAfterDisconnect: TfrxAfterDisconnectEvent;
    FOnBeforePrint: TfrxBeforePrintEvent;
    FOnBeginDoc: TNotifyEvent;
    FOnClickObject: TfrxClickObjectEvent;
    FOnDblClickObject: TfrxClickObjectEvent;
    FOnEditConnection: TfrxEditConnectionEvent;
    FOnEndDoc: TNotifyEvent;
    FOnGetValue: TfrxGetValueEvent;
    FOnNewGetValue: TfrxNewGetValueEvent;
    FOnLoadTemplate: TfrxLoadTemplateEvent;
    FOnLoadDetailTemplate: TfrxLoadDetailTemplateEvent;
    FOnManualBuild: TfrxManualBuildEvent;
    FOnObjectManualBuild: TfrxObjectManualBuildEvent;
    FOnMouseOverObject: TfrxMouseOverObjectEvent;
    FOnPreview: TNotifyEvent;
    FOnPrintPage: TfrxPrintPageEvent;
    FOnPrintReport: TNotifyEvent;
    FOnProgressStart: TfrxProgressEvent;
    FOnProgress: TfrxProgressEvent;
    FOnProgressStop: TfrxProgressEvent;
    FOnRunDialogs: TfrxRunDialogsEvent;
    FOnSetConnection: TfrxSetConnectionEvent;
    FOnStartReport: TfrxNotifyEvent;
    FOnStopReport: TfrxNotifyEvent;
    FOnUserFunction: TfrxUserFunctionEvent;
    FOnClosePreview: TNotifyEvent;
    FOnReportPrint: TfrxNotifyEvent;
    FOnAfterScriptCompile: TNotifyEvent;
    FOnMouseEnter: TfrxMouseEnterEvent;
    FOnMouseLeave: TfrxMouseLeaveEvent;

    FOnGetCustomDataEvent: TfrxGetCustomDataEvent;
    FOnSaveCustomDataEvent: TfrxSaveCustomDataEvent;

    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function DoGetValue(const Expr: String; var Value: Variant): Boolean;
    function GetScriptValue(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function SetScriptValue(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function DoUserFunction(Instance: TObject; ClassType: TClass;
      const MethodName: String; var Params: Variant): Variant;
    function GetDataSetName: String;
    function GetLocalValue: Variant;
    function GetSelfValue: TfrxView;
    function GetPages(Index: Integer): TfrxPage;
    function GetPagesCount: Integer;
    function GetCaseSensitive: Boolean;
    function GetScriptText: TStrings;
    procedure AncestorNotFound(Reader: TReader; const ComponentName: string;
      ComponentClass: TPersistentClass; var Component: TComponent);
    procedure DoClear;
    procedure DoLoadFromStream;
    procedure OnTimer(Sender: TObject);
    procedure ReadDatasets(Reader: TReader);
    procedure ReadStyle(Reader: TReader);
    procedure ReadStyleBookMode(Reader: TReader);
    procedure ReadActiveStyleSheet(Reader: TReader);
    procedure ReadVariables(Reader: TReader);
    procedure SetScriptVar(const vName: String; Obj: TObject);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    procedure SetEngineOptions(const Value: TfrxEngineOptions);
    procedure SetSelfValue(const Value: TfrxView);
    procedure SetLocalValue(const Value: Variant);
    procedure SetParentReport(const Value: String);
    procedure SetPreviewOptions(const Value: TfrxPreviewOptions);
    procedure SetPrintOptions(const Value: TfrxPrintOptions);
    procedure SetReportOptions(const Value: TfrxReportOptions);
    procedure SetScriptText(const Value: TStrings);
    procedure SetStyles(const Value: TfrxStyles);
    procedure SetTerminated(const Value: Boolean);
    procedure SetCaseSensitive(const Value: Boolean);
    procedure WriteDatasets(Writer: TWriter);
    procedure WriteStyle(Writer: TWriter);
    procedure WriteStyleBookMode(Writer: TWriter);
    procedure WriteActiveStyleSheet(Writer: TWriter);
    procedure WriteVariables(Writer: TWriter);
    procedure SetPreview(const Value: TfrxCustomPreview);
    procedure SetVersion(const Value: String);
    procedure SetPreviewPages(const Value: TfrxCustomPreviewPages);
    {$IFDEF FPC}
    function GetLazIniFile:string;
    {$ENDIF}
    procedure UpdateGlobalScritVars;
    procedure SetMainPreviewPages(const Value: TfrxCustomPreviewPages);
    procedure FixUpParentReport;
    function GetMainPreviewPages: TfrxCustomPreviewPages;
    function GetPreviewPages: TfrxCustomPreviewPages;
    procedure RestoreScriptObjectsRef;
    function GetPictureCacheOptions: TfrxPictureCacheOptions;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoGetAncestor(const Name: String; var Ancestor: TPersistent);
    procedure PreviewPagesChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    class function GetDescription: String; override;
    procedure WriteNestedProperties(AItem: TfrXMLItem; AAncestor: TPersistent = nil); override;
    function ReadNestedProperty(AItem: TfrXMLItem): Boolean; override;

    { internal methods }
    /// <summary>
    ///   Calculates the "Expr" expression and returns the result.
    /// </summary>
    function Calc(const Expr: String; AScript: TfsScript = nil): Variant;
    /// <summary>
    ///   Calls designer for set report editing (deletes bands, blocks inlay
    ///   code e.t.c).
    /// </summary>
    function DesignPreviewPage: Boolean;
    /// <summary>
    ///   Returns an alias for the given data set. Dataset should be included
    ///   in the TfrxReport.Datasets.
    /// </summary>
    function GetAlias(DataSet: TfrxDataSet): String;
    /// <summary>
    ///   Returns the data set on its alias name. Dataset should be included in
    ///   the TfrxReport.Datasets.
    /// </summary>
    function GetDataset(const Alias: String): TfrxDataset;
    /// <summary>
    ///   Returns reference to current DrawText object. For thread safe saferty
    ///   each report instance has own DrawText instance.
    /// </summary>
    function GetReportDrawText: Pointer;
    /// <summary>
    ///   Returns the ini-file instance that stores all the designer settings.
    ///   It may be either ini-file or registry, depending on IniFile property
    ///   value.
    /// </summary>
    function GetIniFile: TCustomIniFile;
    /// <summary>
    ///   This function returns path to application executable.
    /// </summary>
    function GetApplicationFolder: String;
    /// <summary>
    ///   Searches for an object by name in the current report template.
    /// </summary>
    /// <param name="AName">
    ///   Object name.
    /// </param>
    function FindObject(const AName: String): TfrxComponent; override;
    /// <summary>
    ///   Prepares script engine for work. It compiles script code, adds report
    ///   objects and user functions to script engine.
    /// </summary>
    /// <param name="ActiveReport">
    ///   Reference to report component(by default nil).
    /// </param>
    function PrepareScript(ActiveReport: TfrxReport = nil): Boolean;
    /// <summary>
    ///   The current loaded template inherits from the specified . The first
    ///   parameter is the name of the parent template, the second one is an
    ///   inheritance mode: derive inheritance dialogue, delete duplicates ,
    ///   rename duplicates .
    /// </summary>
    function InheritFromTemplate(const templName: String; InheriteMode: TfrxInheriteMode = imDefault): Boolean;
    /// <summary>
    ///   Serves IDE report designer.
    /// </summary>
    procedure DesignReport(IDesigner: {$IFDEF FPC}TObject{$ELSE}IUnknown{$ENDIF}; Editor: TObject); overload;
    /// <summary>
    ///   Script Notify event handler.
    /// </summary>
    procedure DoNotifyEvent(Obj: TObject; const EventName: String;
      RunAlways: Boolean = False);
    /// <summary>
    ///   Script parameterized event handler.
    /// </summary>
    procedure DoParamEvent(const EventName: String; var Params: Variant;
      RunAlways: Boolean = False);
    /// <summary>
    ///   Serves AfterPrint event.
    /// </summary>
    procedure DoAfterPrint(c: TfrxReportComponent);
    /// <summary>
    ///   Serves BeforePrint event.
    /// </summary>
    procedure DoBeforePrint(c: TfrxReportComponent);
    /// <summary>
    ///   Serves PreviewClick event.
    /// </summary>
    procedure DoPreviewClick(v: TfrxView; Button: TMouseButton;
      Shift: TShiftState; var Modified: Boolean; var EventParams: TfrxInteractiveEventsParams; DblClick: Boolean = False);
    /// <summary>
    ///   Serves MouseEnter script event.
    /// </summary>
    procedure DoMouseEnter(Sender: TfrxView; aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams); reintroduce;
    /// <summary>
    ///   Serves MouseLeave script event.
    /// </summary>
    procedure DoMouseLeave(Sender: TfrxView; X, Y: Integer; aNextObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams); reintroduce;
    /// <summary>
    ///   Serves MouseUp script event.
    /// </summary>
    procedure DoMouseUp(Sender: TfrxView; X, Y: Integer; Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams); reintroduce;
    /// <summary>
    ///   Retrieves dataset and field name from an expression like
    ///   DSName."field name".
    /// </summary>
    /// <param name="ComplexName">
    ///   Name of dataset and field.
    /// </param>
    /// <param name="Dataset">
    ///   Our dataset reference.
    /// </param>
    /// <param name="Field">
    ///   Our field reference.
    /// </param>
    procedure GetDatasetAndField(const ComplexName: String;
      var Dataset: TfrxDataset; var Field: String);
    /// <summary>
    ///   Returns the list of the data sets available in the report in the
    ///   "List" parameter. The second parameter specifies whether it is
    ///   necessary to return only the data sets, connected with DB data.
    /// </summary>
    procedure GetDataSetList(List: TStrings; OnlyDB: Boolean = False);
    /// <summary>
    ///   Fill list with active datasets.
    /// </summary>
    /// <param name="List">
    ///   Out list.
    /// </param>
    procedure GetActiveDataSetList(List: TStrings);
    /// <summary>
    ///   The report engine calls it when start some work over
    ///   report(preparation, print, export).
    /// </summary>
    procedure InternalOnProgressStart(ProgressType: TfrxProgressType); virtual;
    /// <summary>
    ///   The report engine calls it when some work over report is in
    ///   progress(preparation, print, export).
    /// </summary>
    procedure InternalOnProgress(ProgressType: TfrxProgressType; Progress: Integer); virtual;
    /// <summary>
    ///   The report engine calls it when some work over report is in
    ///   finished(preparation, print, export).
    /// </summary>
    procedure InternalOnProgressStop(ProgressType: TfrxProgressType); virtual;
    /// <summary>
    ///   Returns True when report is preparing or script routine is
    ///   executing(interactive event).
    /// </summary>
    function IsReportActionRunning: Boolean;
    /// <summary>
    ///   Selects a printer specified in PrintOptions.Printer property.
    /// </summary>
    procedure SelectPrinter;
    /// <summary>
    ///   Sets a message to progress bar window if it's active or for status
    ///   bar text in the report preview.
    /// </summary>
    /// <param name="Value">
    ///   Message text.
    /// </param>
    /// <param name="Ishint">
    ///   Set as hint.
    /// </param>
    /// <param name="bHandleMessage">
    ///   Use HandleMessage for main thread GUI synchronization.
    /// </param>
    procedure SetProgressMessage(const Value: String; Ishint: Boolean = False; bHandleMessage: Boolean = True);
    /// <summary>
    ///   This method checks for DataPage in current report and if it's not
    ///   exist, creates one.
    /// </summary>
    procedure CheckDataPage;
    { public methods }
    /// <summary>
    ///   Loads a report from a file with given name. If the second parameter
    ///   is equal to "True," and the file was not found, an exception will be
    ///   generated. It returns "True," if the file is loaded successfully.
    /// </summary>
    /// <param name="FileName">
    ///   Name of the file.
    /// </param>
    /// <param name="ExceptionIfNotFound">
    ///   If true, function generates an exception if file does not exist.
    /// </param>
    function LoadFromFile(const FileName: String;
      ExceptionIfNotFound: Boolean = False): Boolean;
    /// <summary>
    ///   Loads a report from the stream.
    /// </summary>
    /// <param name="Stream">
    ///   Source stream.
    /// </param>
    procedure LoadFromStream(Stream: TStream); override;
    /// <summary>
    ///   Loads a report from using IO transport class to get stream of a
    ///   report.
    /// </summary>
    /// <param name="Filter">
    ///   IO filter transport instance used to get a stream data.
    /// </param>
    /// <param name="FileName">
    ///   Name used if filter doesn't return any name.
    /// </param>
    function LoadFromFilter(Filter: TfrxCustomIOTransport; const FileName: String): Boolean;
    /// <summary>
    ///   Loads or saves report by using IO transport.
    /// </summary>
    /// <param name="Filter">
    ///   IO transport used to get stream for save and load operations.
    /// </param>
    /// <param name="FileName">
    ///   File name used to identify stream if IO filter doesn't have name.
    /// </param>
    /// <param name="fAccess">
    ///   Access type of file operation, read or write.
    /// </param>
    function ProcessIOTransport(Filter: TfrxCustomIOTransport; const FileName: String; fAccess: TfrxFilterAccess): Boolean;
    /// <summary>
    ///   Saves a report from using IO transport class to get stream of a
    ///   report.
    /// </summary>
    /// <param name="Filter">
    ///   IO filter transport instance used to get a stream data.
    /// </param>
    /// <param name="FileName">
    ///   File name used to identify stream if IO filter doesn't have name.
    /// </param>
    function SaveToFilter(Filter: TfrxCustomIOTransport; const FileName: String): Boolean;
    /// <summary>
    ///   Saves a report to a file with given name.
    /// </summary>
    /// <param name="FileName">
    ///   Name of a file.
    /// </param>
    procedure SaveToFile(const FileName: String);
    /// <summary>
    ///   Saves a report to the stream. SaveChildren, SaveDefaultValues,
    ///   UseGetAncestor parameters are not used.
    /// </summary>
    /// <param name="Stream">
    ///   Source stream.
    /// </param>
    /// <param name="SaveChildren">
    ///   Not used.
    /// </param>
    /// <param name="SaveDefaultValues">
    ///   Not used. <br />
    /// </param>
    procedure SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
      SaveDefaultValues: Boolean = False; UseGetAncestor: Boolean = False); override;
    /// <summary>
    ///   Calls the report designer. The designer component must be included
    ///   into your project (to perform this, you can either place the
    ///   "TfrxDesigner" component on the form , or include the "frxDesgn" unit
    ///   into the "Uses" list). The Modal parameter determines whether the
    ///   designer should be modal. The MDIChild parameter allows to make a
    ///   designer window a MDI child window.
    /// </summary>
    /// <param name="Modal">
    ///   Show as modal form.
    /// </param>
    /// <param name="MDIChild">
    ///   Shows as MDI child form.
    /// </param>
    procedure DesignReport(Modal: Boolean = True; MDIChild: Boolean = False); overload; {$IFDEF UNIX}cdecl;{$ELSE}stdcall;{$ENDIF}
    /// <summary>
    ///   Starts a report without a preview window. The parameter assignment is
    ///   the same as in the "ShowReport" method. If a report is constructed
    ///   successfully, this function returns "True."
    /// </summary>
    /// <param name="ClearLastReport">
    ///   If True, clears previous prepared report result.
    /// </param>
    /// <remarks>
    ///   When the report component builds a report and receives another
    ///   PrepareReport or Export command it puts it in deferred commands list
    ///   and run a command only after current action is complete. Used in
    ///   single-threaded application for synchronization with ProcessMessages
    ///   actions.
    /// </remarks>
    function PrepareReport(ClearLastReport: Boolean = True): Boolean;
  	/// <summary>
  	///   Prepares specified report template page in current report.
  	/// </summary>
  	/// <param name="APage">
  	///   A report template page.
  	/// </param>
  	function PreparePage(APage: TfrxPage): Boolean;
    /// <summary>
    ///   Runs all deferred report commands (prepare report, export, print).
    ///   Used in single thread application. When the report component builds a
    ///   report and receives another PrepareReport or Export command it puts
    ///   it in deferred commands list and run a command only after current
    ///   action is complete.
    /// </summary>
    procedure RunDelayedCommands;
    /// <summary>
    ///   This method rebuilds current active preview pages.
    /// </summary>
    procedure RefreshActivePreviewedReport;
    /// <summary>
    ///   Displays the report, which was previously built via the
    ///   "PrepareReport" call.
    /// </summary>
    /// <remarks>
    ///   When the report component builds a report and receives another
    ///   PrepareReport or Export command it puts it in deferred commands list
    ///   and run a command only after current action is complete. Used in
    ///   single-threaded application for synchronization with ProcessMessages
    ///   actions.
    /// </remarks>
    procedure ShowPreparedReport; {$IFDEF UNIX}cdecl;{$ELSE}stdcall;{$ENDIF}
    /// <summary>
    ///   Starts a report and displays a result in the preview window. If the
    ///   "ClearLastReport" parameter is equal to "False," then a report will
    ///   be added to the previously constructed one, otherwise the previously
    ///   constructed report is cleared (by default).
    /// </summary>
    /// <param name="ClearLastReport">
    ///   Clear previous result.
    /// </param>
    /// <remarks>
    ///   When the report component builds a report and receives another
    ///   PrepareReport or Export command it puts it in deferred commands list
    ///   and run a command only after current action is complete. Used in
    ///   single-threaded application for synchronization with ProcessMessages
    ///   actions.
    /// </remarks>
    procedure ShowReport(ClearLastReport: Boolean = True); {$IFDEF UNIX}cdecl;{$ELSE}stdcall;{$ENDIF}
    /// <summary>
    ///   Adds a user function to the list of the functions available in the
    ///   report. See the FastReport developer's manual about this method.
    /// </summary>
    /// <param name="FuncName">
    ///   Function name with parameters ('function MyFunc(s: String):String'). <br />
    /// </param>
    /// <param name="Category">
    ///   Function category.
    /// </param>
    /// <param name="Description">
    ///   Description of function behaviour.
    /// </param>
    procedure AddFunction(const FuncName: String; const Category: String = '';
      const Description: String = '');
    /// <summary>
    ///   Shows designer in specified panel.
    /// </summary>
    /// <param name="Panel">
    ///   Parent panel.
    /// </param>
    procedure DesignReportInPanel(Panel: TWinControl);
    /// <summary>
    ///   Prints a report using printer settings from a PrintOptions property.
    /// </summary>
    /// <remarks>
    ///   When the report component builds a report and receives another
    ///   PrepareReport or Export command it puts it in deferred commands list
    ///   and run a command only after current action is complete. Used in
    ///   single-threaded application for synchronization with ProcessMessages
    ///   actions.
    /// </remarks>
    function Print: Boolean; {$IFDEF UNIX}cdecl;{$ELSE}stdcall;{$ENDIF}
    /// <summary>
    ///   Exports a report using the specified export filter.
    /// </summary>
    /// <param name="Filter">
    ///   Export filter instance.
    /// </param>
    /// <remarks>
    ///   When the report component builds a report and receives another
    ///   PrepareReport or Export command it puts it in deferred commands list
    ///   and run a command only after current action is complete. Used in
    ///   single-threaded application for synchronization with ProcessMessages
    ///   actions.
    /// </remarks>
    function Export(Filter: TfrxCustomExportFilter): Boolean;

    { internals }
    /// <summary>
    ///   Reference to a current processed object by report engine. The engine
    ///   sets it before process report object.
    /// </summary>
    property CurObject: String read FCurObject write FCurObject;
    /// <summary>
    ///   The list with drill down states names. Groups names in this list are
    ///   expanded. To collapse or expand groups remove or add group name to
    ///   the list.
    /// </summary>
    property DrillState: TStrings read FDrillState;
    /// <summary>
    ///   Current value used for &lt;Value&gt; variable inside expressions.
    /// </summary>
    property LocalValue: Variant read GetLocalValue write SetLocalValue;
    /// <summary>
    ///   Current value used for &lt;Self&gt; variable inside expressions.
    /// </summary>
    property SelfValue: TfrxView read GetSelfValue write SetSelfValue;
    /// <summary>
    ///   Current preview from if preview for is open.
    /// </summary>
    property PreviewForm: TForm read FPreviewForm;
    /// <summary>
    ///   Reference to active XML serializer instance.
    /// </summary>
    property XMLSerializer: TObject read FXMLSerializer;
    /// <summary>
    ///   True when report is reloading(When component loads report).
    /// </summary>
    property Reloading: Boolean read FReloading write FReloading;

    { public }
    /// <summary>
    ///   The list of data sets available for the report.
    /// </summary>
    property DataSets: TfrxReportDataSets read FDataSets;
    /// <summary>
    ///   A link to the report designer (actual when the designer is enabled).
    /// </summary>
    property Designer: TfrxCustomDesigner read FDesigner write FDesigner;
    /// <summary>
    ///   The list of enabled data sets available for the report. When
    ///   EngineOptions.UseGlobalDataSetList is True, th report component uses
    ///   this list instead of Global.
    /// </summary>
    property EnabledDataSets: TfrxReportDataSets read FEnabledDataSets;
    /// <summary>
    ///   A link to the report engine. It is useful in cases when it is
    ///   necessary to operate a process of the report construction from a
    ///   code.
    /// </summary>
    property Engine: TfrxCustomEngine read FEngine;
    /// <summary>
    ///   The list of errors, occurring during one or another operation.
    /// </summary>
    property Errors: TStrings read FErrors;
    /// <summary>
    ///   Defines a report file name; it is displayed in the designer. The
    ///   LoadFromFile method fills this property.
    /// </summary>
    property FileName: String read FFileName write FFileName;
    /// <summary>
    ///   This property indicates that report was modified by the report
    ///   designer.
    /// </summary>
    property Modified: Boolean read FModified write FModified;
    /// <summary>
    ///   Reference to main preview pages instance of finished report belongs
    ///   to the report. <br />
    /// </summary>
    property MainPreviewPages: TfrxCustomPreviewPages read GetMainPreviewPages write SetMainPreviewPages;
    /// <summary>
    ///   A link to current pages of a finished report. It is used in all
    ///   operations, which are connected with a finished report (printing,
    ///   saving, export, etc.).
    /// </summary>
    property PreviewPages: TfrxCustomPreviewPages read GetPreviewPages write SetPreviewPages;
    /// <summary>
    ///   List of preview pages generated by current instance of the report.
    ///   This class used to manage all previewpages in the report component.
    /// </summary>
    property PreviewPagesList: TfrxPreviewPagesList read FPreviewPagesList;
    /// <summary>
    ///   The list of report pages. The pages of the "dialogue form" type are
    ///   also included in this list.
    /// </summary>
    property Pages[Index: Integer]: TfrxPage read GetPages;
    /// <summary>
    ///   Number of pages in a report template.
    /// </summary>
    property PagesCount: Integer read GetPagesCount;
    property PictureCacheOptions: TfrxPictureCacheOptions read GetPictureCacheOptions;
    /// <summary>
    ///   The "TfsScript" component, linked to the report. By using this link,
    ///   you can add your variables, classes, functions, which can be used in
    ///   a report script in the future. See more in the FastScript developer's
    ///   manual.
    /// </summary>
    property Script: TfsScript read FScript;
    /// <summary>
    ///   Report style. See more about operating with styles in the FastReport
    ///   programmer's manual.
    /// </summary>
    property Styles: TfrxStyles read FStyles write SetStyles;
    /// <summary>
    ///   Indicates that report was terminated during preparation. Set it to
    ///   true manually will cause exit from the report preparation state. The
    ///   termination is not instant.
    /// </summary>
    property Terminated: Boolean read FTerminated write SetTerminated;
    /// <summary>
    ///   The list of report variables. See more about operating with variables
    ///   in the FastReport programmer's manual.
    /// </summary>
    property Variables: TfrxVariables read FVariables;
    /// <summary>
    ///   If True , then the expression will be catching subject to the letter
    ///   list . It is necessary to use the same text with different letter
    ///   list in expression.
    /// </summary>
    property CaseSensitiveExpressions: Boolean read GetCaseSensitive write SetCaseSensitive;

    /// <summary>
    ///   Occurs when user edit connection in the report wizard.
    /// </summary>
    property OnEditConnection: TfrxEditConnectionEvent read FOnEditConnection write FOnEditConnection;
    /// <summary>
    ///   Occurs when user set ConnectionNeme property. Internal use.
    /// </summary>
    property OnSetConnection: TfrxSetConnectionEvent read FOnSetConnection write FOnSetConnection;
  published
    property Version: String read FVersion write SetVersion;
    /// <summary>
    ///   The name of a base report. Used if you inherit the report from a
    ///   base.
    /// </summary>
    property ParentReport: String read FParentReport write SetParentReport;
    /// <summary>
    ///   Dataset for a report. If this property is set, the report will be
    ///   printed as many times as many records in the dataset.
    /// </summary>
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    /// <summary>
    ///   The same as DataSet property but contains symbolic link to a DataSet.
    /// </summary>
    property DataSetName: String read GetDataSetName write SetDataSetName;
    /// <summary>
    ///   Defines whether the report is dot-matrix. When setting this property
    ///   to True, the report may contain dot-matrix pages (TfrxDMPPage) and
    ///   objects. Don't set this property directly. Use the "File|New..." menu
    ///   item to create dot-matrix reports.
    /// </summary>
    property DotMatrixReport: Boolean read FDotMatrixReport write FDotMatrixReport;
    /// <summary>
    ///   A set of properties related to the FastReport engine.
    /// </summary>
    property EngineOptions: TfrxEngineOptions read FEngineOptions write SetEngineOptions;
    /// <summary>
    ///   A file name or a name of the registry key for storing the FastReport
    ///   environment settings.
    /// </summary>
    property IniFile: String read {$IFNDEF FPC}FIniFile{$ELSE}GetLazIniFile{$ENDIF} write FIniFile;
    /// <summary>
    ///   Shows legacy progress message window. Do not use it.
    /// </summary>
    property OldStyleProgress: Boolean read FOldStyleProgress write FOldStyleProgress default False;
    /// <summary>
    ///   A link to the "TfrxPreview" component, in which the finished report
    ///   should be displayed. If this property is blank, a report is displayed
    ///   in the standard preview window.
    /// </summary>
    property Preview: TfrxCustomPreview read FPreview write SetPreview;
    /// <summary>
    ///   A set of properties, relating to the report preview.
    /// </summary>
    property PreviewOptions: TfrxPreviewOptions read FPreviewOptions write SetPreviewOptions;
    /// <summary>
    ///   A set of properties, which relate to the report printing.
    /// </summary>
    property PrintOptions: TfrxPrintOptions read FPrintOptions write SetPrintOptions;
    /// <summary>
    ///   Defines a set of properties relating to the report.
    /// </summary>
    property ReportOptions: TfrxReportOptions read FReportOptions write SetReportOptions;
    /// <summary>
    ///   Script language used in a report. The following values are valid:
    ///   PascalScript, C++Script, BasicScript, JScript.
    /// </summary>
    property ScriptLanguage: String read FScriptLanguage write FScriptLanguage;
    /// <summary>
    ///   Script text.
    /// </summary>
    property ScriptText: TStrings read GetScriptText write SetScriptText;
    /// <summary>
    ///   Set to True when need progress message to be shown.
    /// </summary>
    property ShowProgress: Boolean read FShowProgress write FShowProgress default True;
    /// <summary>
    ///   Set to False when do not need to save report to DFM.
    /// </summary>
    property StoreInDFM: Boolean read FStoreInDFM write FStoreInDFM default True;

    /// <summary>
    ///   When starting a report. It occurs after handling each object.
    /// </summary>
    property OnAfterPrint: TfrxBeforePrintEvent read FOnAfterPrint write FOnAfterPrint;
    /// <summary>
    ///   Occurs when the report engine establish connection to database
    ///   forinternal database components.
    /// </summary>
    property OnBeforeConnect: TfrxBeforeConnectEvent read FOnBeforeConnect write FOnBeforeConnect;
    /// <summary>
    ///   Occurs when the report engine close connection to database for
    ///   internaldatabase components.
    /// </summary>
    property OnAfterDisconnect: TfrxAfterDisconnectEvent read FOnAfterDisconnect write FOnAfterDisconnect;
    /// <summary>
    ///   When starting a report. It occurs before handling each object.
    /// </summary>
    property OnBeforePrint: TfrxBeforePrintEvent read FOnBeforePrint write FOnBeforePrint;
    /// <summary>
    ///   Occurs when running a report.
    /// </summary>
    property OnBeginDoc: TNotifyEvent read FOnBeginDoc write FOnBeginDoc;
    /// <summary>
    ///   When previewing a report in the preview window. Occurs when clicking
    ///   the object.
    /// </summary>
    property OnClickObject: TfrxClickObjectEvent read FOnClickObject write FOnClickObject;
    /// <summary>
    ///   When previewing a report in the preview window. Occurs when double
    ///   clicking the object.
    /// </summary>
    property OnDblClickObject: TfrxClickObjectEvent read FOnDblClickObject write FOnDblClickObject;
    /// <summary>
    ///   Occurs after finishing a report.
    /// </summary>
    property OnEndDoc: TNotifyEvent read FOnEndDoc write FOnEndDoc;
    /// <summary>
    ///   When starting a report. Occurs when an unknown variable is met. An
    ///   event handler must return the value of this variable.
    /// </summary>
    property OnGetValue: TfrxGetValueEvent read FOnGetValue write FOnGetValue;
    /// <summary>
    ///   When starting a report. Occurs when an unknown variable is met. An
    ///   event handler must return the value of this variable.
    /// </summary>
    property OnNewGetValue: TfrxNewGetValueEvent read FOnNewGetValue write FOnNewGetValue;
    /// <summary>
    ///   When starting a report. If the handler of this event is allocated,
    ///   then the FastReport engine is blocked and you thus would have to
    ///   construct a report manually.
    /// </summary>
    property OnManualBuild: TfrxManualBuildEvent read FOnManualBuild write FOnManualBuild;
    property OnObjectManualBuild: TfrxObjectManualBuildEvent read FOnObjectManualBuild write FOnObjectManualBuild;
    /// <summary>
    ///   When report is previewed in the preview window. Occurs when mouse
    ///   cursor passes over the object.
    /// </summary>
    property OnMouseOverObject: TfrxMouseOverObjectEvent read FOnMouseOverObject
      write FOnMouseOverObject;
    /// <summary>
    ///   Occurs when report is previewed in the preview window and mouse
    ///   pointerenters object rect area.
    /// </summary>
    property OnMouseEnter: TfrxMouseEnterEvent read FOnMouseEnter write FOnMouseEnter;
    /// <summary>
    ///   Occurs when report is previewed in the preview window and mouse
    ///   pointerleaves object rect area.
    /// </summary>
    property OnMouseLeave: TfrxMouseLeaveEvent read FOnMouseLeave write FOnMouseLeave;
    /// <summary>
    ///   Occurs before displaying a preview window.
    /// </summary>
    property OnPreview: TNotifyEvent read FOnPreview write FOnPreview;
    /// <summary>
    ///   Occurs when printing a report page. The CopyNo parameter determines
    ///   which copy is printing now (if user choose to print several copies).
    /// </summary>
    property OnPrintPage: TfrxPrintPageEvent read FOnPrintPage write FOnPrintPage;
    /// <summary>
    ///   Occurs before printing a report.
    /// </summary>
    property OnPrintReport: TNotifyEvent read FOnPrintReport write FOnPrintReport;
    /// <summary>
    ///   Occurs after printing a report.
    /// </summary>
    property OnAfterPrintReport: TNotifyEvent read FOnAfterPrintReport write FOnAfterPrintReport;
    /// <summary>
    ///   This event is fired at start of some continuous operation (print,
    ///   export, run report). The event handler may display a dialog window
    ///   with progress bar. Progress parameter is a page number which is
    ///   currently processed.
    /// </summary>
    property OnProgressStart: TfrxProgressEvent read FOnProgressStart write FOnProgressStart;
    /// <summary>
    ///   This event is fired when performing some continuous operations
    ///   (print, export, run report). The event handler may display a dialog
    ///   window with progress bar. Progress parameter is a page number which
    ///   is currently being processed.
    /// </summary>
    property OnProgress: TfrxProgressEvent read FOnProgress write FOnProgress;
    /// <summary>
    ///   This event is fired at stop of some continuous operation (print,
    ///   export, run report). The event handler may display a dialog window
    ///   with progress bar. Progress parameter is a page number which is
    ///   currently processed.
    /// </summary>
    property OnProgressStop: TfrxProgressEvent read FOnProgressStop write FOnProgressStop;
    /// <summary>
    ///   Name of the script procedure which will be called when report dialog
    ///   page is previewed. <br />
    /// </summary>
    property OnRunDialogs: TfrxRunDialogsEvent read FOnRunDialogs write FOnRunDialogs;
    /// <summary>
    ///   Name of the script procedure which will be called when report starts.
    /// </summary>
    property OnStartReport: TfrxNotifyEvent read FOnStartReport write FOnStartReport;
    /// <summary>
    ///   Name of the script procedure which will be called when report
    ///   finishes.
    /// </summary>
    property OnStopReport: TfrxNotifyEvent read FOnStopReport write FOnStopReport;
    /// <summary>
    ///   Occurs when calling a function, added with the help of the
    ///   "AddFunction" method.
    /// </summary>
    property OnUserFunction: TfrxUserFunctionEvent read FOnUserFunction write FOnUserFunction;
    /// <summary>
    ///   Occurs when a report is an inherited report. The event handler must
    ///   load the report template (given by TemplateName parameter) into
    ///   Report object.
    /// </summary>
    property OnLoadTemplate: TfrxLoadTemplateEvent read FOnLoadTemplate write FOnLoadTemplate;
    /// <summary>
    ///   Occurs when a report object loads detail report. The event handler
    ///   must load the report template (given by TemplateName parameter) into
    ///   Report object with using parameters of AHyperlink.
    /// </summary>
    property OnLoadDetailTemplate: TfrxLoadDetailTemplateEvent read FOnLoadDetailTemplate write FOnLoadDetailTemplate;
    /// <summary>
    ///   Occurs when preview form closed.
    /// </summary>
    property OnClosePreview: TNotifyEvent read FOnClosePreview write FOnClosePreview;
    /// <summary>
    ///   Occurs when papered report being printed.
    /// </summary>
    property OnReportPrint: TfrxNotifyEvent read FOnReportPrint write FOnReportPrint;
    /// <summary>
    ///   Occurs after script compilation and before the report engine stars
    ///   report preparation.
    /// </summary>
    property OnAfterScriptCompile: TNotifyEvent read FOnAfterScriptCompile write FOnAfterScriptCompile;
    /// <summary>
    ///   This event fires when engine loads report XML file and file contains
    ///   XML item &lt;FrxCustomData&gt;(i.e. store user data inside XML
    ///   file).All child nodes in this item ignores by <br />serializer.
    ///   XMLItem contains all the custom user data.
    /// </summary>
    property OnGetCustomData: TfrxGetCustomDataEvent read FOnGetCustomDataEvent write FOnGetCustomDataEvent;
    /// <summary>
    ///   This event fires when serializer saves report template to
    ///   XML(i.e.store user data inside XML file). If event is set, serializer
    ///   creates &lt;FrxCustomData&gt; node and pass it as a parameter.
    ///   Programmer may use this node to create child nodes with custom data.
    /// </summary>
    property OnSaveCustomData: TfrxSaveCustomDataEvent read FOnSaveCustomDataEvent write FOnSaveCustomDataEvent;
  end;

  /// <summary>
  ///   This interface declares deferred command abstraction.
  /// </summary>
  IfrxDelayedCommand = interface ['{3A04A39B-B516-42A5-A597-53F99F0EDB7B}']
    /// <summary>
    ///   Runs command.
    /// </summary>
    procedure Run;
    /// <summary>
    ///   Get symbolic name of current command instance.
    /// </summary>
    function GetName: String;
    /// <summary>
    ///   Get command instance.
    /// </summary>
    function GetInstance: TObject;
  end;

  /// <summary>
  ///   The base abstract class which implements IfrxDelayedCommand interface.
  ///   It used as a base for all report commands. All commands stored in the
  ///   command list in the report component.
  /// </summary>
  TfrxBaseDelayedCommand = class(TPersistent, IfrxDelayedCommand)
  private
    FRefCount: Integer;
  protected
    function _AddRef: Integer; {$IFDEF FPC}{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE} stdcall;{$ENDIF}
    function _Release: Integer; {$IFDEF FPC}{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE} stdcall;{$ENDIF}
  public
    function QueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} IID: TGUID; out Obj): HResult; virtual; {$IFDEF FPC}{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};{$ELSE} stdcall;{$ENDIF}
  public
    procedure AfterConstruction; override;
    procedure Run; virtual; abstract;
    function GetName: String;
    function GetInstance: TObject;
  end;

  /// <summary>
  ///   This class is a base for all prepare report commands.
  /// </summary>
  TfrxBasePrepareReportCommand = class(TfrxBaseDelayedCommand)
  private
    FReport: TfrxReport;
    FClearLast: Boolean;
    FEngineOptions: TfrxEngineOptions;
  public
    /// <summary>
    ///   Command constructor.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="ClearLast">
    ///   Clears previous report. Parameter of PrepareReport method.
    /// </param>
    constructor Create(AReport: TfrxReport; ClearLast: Boolean);
    destructor Destroy; override;
    procedure Run; override;
  end;

  /// <summary>
  ///   This class implements realization of deferred ShowReport command.
  /// </summary>
  TfrxShowReportCommand = class(TfrxBasePrepareReportCommand)
  public
    procedure Run; override;
  end;

  /// <summary>
  ///   This class implements realization of deferred PrepareReport command.
  /// </summary>
  TfrxPrepareReportCommand = class(TfrxBasePrepareReportCommand)
  public
    procedure Run; override;
  end;

  /// <summary>
  ///   This class implements realization of deferred RefreshReport command.
  /// </summary>
  TfrxRefreshReportCommand = class(TfrxBasePrepareReportCommand)
  public
    procedure Run; override;
  end;

  /// <summary>
  ///   This class implements realization of deferred LoadFrom command.
  /// </summary>
  TfrxLoadFromCommand = class(TfrxBaseDelayedCommand)
  private
    FReport: TfrxReport;
    FTransport: TfrxCustomIOTransport;
    FFileName: String;
  public
    /// <summary>
    ///   LoadFrom command constructor.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="Transport">
    ///   Reference to a IO transport used for file operations(command creates
    ///   copy of it in constructor).
    /// </param>
    /// <param name="FileName">
    ///   File name.
    /// </param>
    constructor Create(AReport: TfrxReport; Transport: TfrxCustomIOTransport; const FileName: String);
    destructor Destroy; override;
    procedure Run; override;
  end;

  /// <summary>
  ///   This class implements realization of deferred LoadFromFile command.
  /// </summary>
  TfrxLoadFromFileCommand = class(TfrxBaseDelayedCommand)
  private
    FReport: TfrxReport;
    FFileName: String;
    FExceptionIfNotFound: Boolean;
  public
    /// <summary>
    ///   LoadFromFile command constructor.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="FileName">
    ///   File name.
    /// </param>
    /// <param name="ExceptionIfNotFound">
    ///   Generates exception if file now found. LoadFromFile parameter.
    /// </param>
    constructor Create(AReport: TfrxReport; const FileName: String; ExceptionIfNotFound: Boolean);
    procedure Run; override;
  end;

  /// <summary>
  ///   This class implements realization of deferred LoadFromStream command.
  /// </summary>
  TfrxLoadFromStreamCommand = class(TfrxBaseDelayedCommand)
  private
    FReport: TfrxReport;
    FStream: TMemoryStream;
  public
    /// <summary>
    ///   LoadFromStream command constructor.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="Stream">
    ///   Source stream(Command constructor creates a copy of in in memory).
    /// </param>
    constructor Create(AReport: TfrxReport; Stream: TStream);
    destructor Destroy; override;
    procedure Run; override;
  end;

  /// <summary>
  ///   The TfrxDelayedCommandManager class is used as storage and manager for
  ///   commands which implements <br />IfrxDelayedCommand interface.
  /// </summary>
  TfrxDelayedCommandManager = class
  private
    FCommands: TStringList;
    FIsRunning: Boolean;
  public
    /// <summary>
    ///   Constructor.
    /// </summary>
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Clears all deferred commands in the list.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds new command to the deferred commands list.
    /// </summary>
    /// <param name="Cmd">
    ///   Object which implements <br />IfrxDelayedCommand interface.
    /// </param>
    procedure AddCommand(Cmd: IfrxDelayedCommand);
    /// <summary>
    ///   Run all commands in the list one by one.
    /// </summary>
    procedure RunAll;
    /// <summary>
    ///   The current state of manager. It's True if manager runs some
    ///   commands.
    /// </summary>
    property IsRunning: Boolean read FIsRunning;
  end;

  { Incapsulate second list for Object ispector }
  /// <summary>
  ///   This class implements list of selected report objects in the report
  ///   designer and in the report preview. For the report designer it
  ///   encapsulates second list for the object inspector.
  /// </summary>
  TfrxSelectedObjectsList = class(TList)
  private
    FInspSelectedObjects: TList;
    FUpdated: Boolean;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    /// <summary>
    ///   List constructor.
    /// </summary>
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Clears only object inspector list.
    /// </summary>
    procedure ClearInspectorList;
    /// <summary>
    ///   Reference to the object inspector list. It used by the object
    ///   inspector. In the report designer selected objects and object
    ///   inspector selection may vary.
    /// </summary>
    property InspSelectedObjects: TList read FInspSelectedObjects;
    /// <summary>
    ///   State of the lists. It's updating when it's True.
    /// </summary>
    property Updated: Boolean read FUpdated write FUpdated;
  end;

  /// <summary>
  ///   The TfrxCustomDesigner class is the base class for the report designer.
  /// </summary>
  TfrxCustomDesigner = class(TfrxBaseForm)
  private
    FReport: TfrxReport;
    FIsPreviewDesigner: Boolean;
    FMemoFontName: String;
    FMemoFontSize: Integer;
    FUseObjectFont: Boolean;
    FParentForm: TForm;
  protected
    FModified: Boolean;
    FInspectorLock: Boolean;
    FObjects: TList;
    FPage: TfrxPage;
    FSelectedObjects: TfrxSelectedObjectsList;
    procedure SetModified(const Value: Boolean); virtual;
    procedure SetPage(const Value: TfrxPage); virtual;
    function GetCode: TStrings; virtual; abstract;
    function GetDefaultPreferences: TObject; virtual;
  public
    /// <summary>
    ///   The Report designer constructor.
    /// </summary>
    constructor CreateDesigner(AOwner: TComponent; AReport: TfrxReport;
      APreviewDesigner: Boolean = False);
    destructor Destroy; override;
    procedure DeleteObject(vComp: TfrxComponent); virtual;
    procedure AddPictureToCache(PicView: TfrxPictureView); virtual;
    /// <summary>
    ///   Used to check restriction of the report designer. Returns True when
    ///   restriction flag is set in the report designer.
    /// </summary>
    /// <param name="Op">
    ///   Restriction flag.
    /// </param>
    function CheckOp(Op: TfrxDesignerRestriction): Boolean; virtual;
    procedure ClearLastActiveObject; virtual; abstract;
    /// <summary>
    ///   Method shows an "Insert expression" dialogue. It should return an
    ///   expression string or an empty string if dialogue was canceled.
    /// </summary>
    function InsertExpression(const Expr: String): String; virtual; abstract;
    /// <summary>
    ///   Method shows an "Insert expression" dialogue. It should return an
    ///   expression string in out OutExpr parameter. Method returns True when
    ///   expression was changed.
    /// </summary>
    function IsChangedExpression(const InExpr: String; out OutExpr: String): Boolean; virtual; abstract;
    function GetPreferencesStorage(aDefault: Boolean): TObject; override;
    /// <summary>
    ///   Locks any drawings in the designer window. Use this method when
    ///   making any changes in the currently edited report.
    /// </summary>
    procedure Lock; virtual; abstract;
    /// <summary>
    ///   Reloads all report's pages. Use this method if you add or delete a
    ///   report page. The Index parameter defines which page should be made
    ///   active.
    /// </summary>
    procedure ReloadPages(Index: Integer); virtual; abstract;
    /// <summary>
    ///   Reloads all report contents.
    /// </summary>
    procedure ReloadReport; virtual; abstract;
    /// <summary>
    ///   Reloads all report objects in the report designer.
    /// </summary>
    /// <param name="ResetSelection">
    ///   Reset objects selection in the report designer.
    /// </param>
    procedure ReloadObjects(ResetSelection: Boolean = True); virtual; abstract;
    /// <summary>
    ///   Updates the "Data Tree" tool window.
    /// </summary>
    procedure UpdateDataTree; virtual; abstract;
    /// <summary>
    ///   Updates the report designer workspace.
    /// </summary>
    procedure UpdatePage; virtual; abstract;
    /// <summary>
    ///   Updates object inspector.
    /// </summary>
    procedure UpdateInspector; virtual; abstract;
    /// <summary>
    ///   Locks object inspector updating.
    /// </summary>
    procedure DisableInspectorUpdate; virtual; abstract;
    /// <summary>
    ///   Releases object inspector lock.
    /// </summary>
    procedure EnableInspectorUpdate; virtual; abstract;
    /// <summary>
    ///   This method processes clipboard copy behaviour.
    /// </summary>
    procedure InternalCopy; virtual; abstract;
    /// <summary>
    ///   This method processes clipboard paste behaviour.
    /// </summary>
    procedure InternalPaste; virtual; abstract;
    /// <summary>
    ///   The methods checks if clipboard contains data available to paste in
    ///   selected object. It serves copy/paste methods of InPlace editors.
    /// </summary>
    function InternalIsPasteAvailable: Boolean; virtual; abstract;
    /// <summary>
    ///   Calls DataSets selection dialog.
    /// </summary>
    procedure ReportDataEdit; virtual; abstract;
    /// <summary>
    ///   Calls report variables editor dialog.
    /// </summary>
    procedure ReportEditVariable; virtual; abstract;
    /// <summary>
    ///   Checks if passed object is designer DataTree window. Used for drag
    ///   and drop behaviour.
    /// </summary>
    /// <param name="aObject">
    ///   Reference to an object.
    /// </param>
    function IsDataTree(aObject: TObject): Boolean; virtual; abstract;
    procedure SetSelection(AComponent: TfrxComponent; const PropName: String; SelStart, SelEnd: TPoint); virtual; abstract;
    /// <summary>
    ///   Returns a dataset expression from DataTree selection.
    /// </summary>
    function GetDataSelectedAsExp: String; virtual; abstract;
    /// <summary>
    ///   Returns True if the designer was launched from the preview window.
    /// </summary>
    property IsPreviewDesigner: Boolean read FIsPreviewDesigner;
    /// <summary>
    ///   Determines whether the report was modified.
    /// </summary>
    property Modified: Boolean read FModified write SetModified;
    /// <summary>
    ///   List of objects on the current report page, including the page
    ///   itself.
    /// </summary>
    property Objects: TList read FObjects;
    /// <summary>
    ///   Reference to a report.
    /// </summary>
    property Report: TfrxReport read FReport;
    /// <summary>
    ///   List of currently selected object.
    /// </summary>
    property SelectedObjects: TfrxSelectedObjectsList read FSelectedObjects;
    /// <summary>
    ///   Reference to currently edited report page. May be nil if current page
    ///   is "code editor".
    /// </summary>
    property Page: TfrxPage read FPage write SetPage;
    /// <summary>
    ///   The script of the report.
    /// </summary>
    property Code: TStrings read GetCode;
    /// <summary>
    ///   If True , Memo editor will use font for editor from the report object
    ///   settings.
    /// </summary>
    property UseObjectFont: Boolean read FUseObjectFont write FUseObjectFont;
    /// <summary>
    ///   Default name of the font for memo text editor.
    /// </summary>
    property MemoFontName: String read FMemoFontName write FMemoFontName;
    /// <summary>
    ///   Default size of the font for memo text editor.
    /// </summary>
    property MemoFontSize: Integer read FMemoFontSize write FMemoFontSize;
    /// <summary>
    ///   Parent form for the report designer form.
    /// </summary>
    property ParentForm: TForm read FParentForm write FParentForm;
  end;

  TfrxDesignerClass = class of TfrxCustomDesigner;
  /// <summary>
  ///   Notification of Tree node item. Used to notify about changes of
  ///   item(Add/Remove).
  /// </summary>
  TfrxNodeChanging = procedure(const Name: String; bUseRemoveList: Boolean = False; aObject: TObject = nil) of object;

  /// <summary>
  ///   This class represents tree node which used to emulate tree structure of
  ///   directories and files in IO transports.
  /// </summary>
  TfrxNode = class(TObject)
  private
    FParent: TfrxNode;
    FNodesList: TStringList;
    FData: Variant;
    FObjectData: TObject;
    FName: String;
    FOriginalName: String;
    FOwnObject: Boolean;
    FOnAddItem: TfrxNodeChanging;
    FOnRemoveItem: TfrxNodeChanging;
    FFilterAccess: TfrxFilterAccess;
    FFilesCount: Integer;
    procedure SetName(const Value: String);
    procedure SetObjectData(const Value: TObject);
    function GetNode(Index: Integer): TfrxNode;
    procedure UpdateFilesCount(Count: Integer);
    procedure SetOriginalName(const Value: String);
  public
    /// <summary>
    ///   Default constructor.
    /// </summary>
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Clears current node and destroys all child nodes with data(closes and
    ///   free all opened streams).
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Returns Root tree node.
    /// </summary>
    function GetRoot: TfrxNode;
    /// <summary>
    ///   Adds new child node to current one.
    /// </summary>
    /// <param name="Name">
    ///   Name of the child node.
    /// </param>
    /// <param name="aObject">
    ///   Object reference assigned to node(usually stream).
    /// </param>
    function Add(const Name: String; aObject: TObject = nil): TfrxNode;
    /// <summary>
    ///   Removes node.
    /// </summary>
    /// <param name="aNode">
    ///   Reference to a node.
    /// </param>
    procedure RemoveNode(aNode: TfrxNode);
    /// <summary>
    ///   Searches for node by name.
    /// </summary>
    /// <param name="Name">
    ///   Name of a node to search.
    /// </param>
    /// <param name="SearchInChilds">
    ///   True if need to search in all child nodes.
    /// </param>
    function Find(const Name: String; SearchInChilds: Boolean = False): TfrxNode; overload;
    /// <summary>
    ///   Searches for node by assigned object.
    /// </summary>
    /// <param name="aObject">
    ///   Reference to an object.
    /// </param>
    /// <param name="SearchInChilds">
    ///   True if need to search in all child nodes.
    /// </param>
    function Find(aObject: TObject; SearchInChilds: Boolean = False): TfrxNode; overload;
    /// <summary>
    ///   Returns count of nodes for current level.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Reference to a parent node.
    /// </summary>
    property Parent: TfrxNode read FParent;
    /// <summary>
    ///   Node data.
    /// </summary>
    property Data: Variant read FData write FData;
    /// <summary>
    ///   Node object. Usually stream.
    /// </summary>
    property ObjectData: TObject read FObjectData write SetObjectData;
    /// <summary>
    ///   Name of the current node.
    /// </summary>
    property Name: String read FName write SetName;
    /// <summary>
    ///   List of all child nodes for current level.
    /// </summary>
    property Items[Index: Integer]: TfrxNode read GetNode;
    /// <summary>
    ///   Original name of a node. internal use.
    /// </summary>
    property OriginalName: String read FOriginalName write SetOriginalName;
    /// <summary>
    ///   This event fires when child item added to current.
    /// </summary>
    property OnAddItem: TfrxNodeChanging read FOnAddItem write FOnAddItem;
    /// <summary>
    ///   This event fires when child item removed from current.
    /// </summary>
    property OnRemoveItem: TfrxNodeChanging read FOnRemoveItem write FOnRemoveItem;
    /// <summary>
    ///   Access type of IO filter.
    /// </summary>
    property FilterAccess: TfrxFilterAccess read FFilterAccess write FFilterAccess;
    /// <summary>
    ///   Count of files(ObjectData assigned) in current item.
    /// </summary>
    property FilesCount: Integer read FFilesCount;
  end;

  /// <summary>
  ///   These flags used in IO transports to define visibility of IO transport
  ///   filter. By default each transport filter component registers in global
  ///   list and these flags helps to sort items of the global list.
  /// </summary>
  TfrxFilterVisibleState = (
    /// <summary>
    ///   Filter available from the report designer in "File" -&gt; "Save as"
    ///   and "Open" submenu.
    /// </summary>
    fvDesigner,
    /// <summary>
    ///   Filter available from the report preview in "File" -&gt; "Save as"
    ///   and "Open" submenu. <br />
    /// </summary>
    fvPreview,
    /// <summary>
    ///   Filter available from an export filter dialog.
    /// </summary>
    fvExport,
    /// <summary>
    ///   Filter available from the report designer as a filter option (drop
    ///   down list) in standard Save and Open dialogs.
    /// </summary>
    fvDesignerFileFilter,
    /// <summary>
    ///   Filter available from the report preview as a filter option (drop
    ///   down list) in standard Save and Open dialogs.
    /// </summary>
    fvPreviewFileFilter,
    /// <summary>
    ///   Filter available from an export as a filter option (drop down list)
    ///   in standard Save and Open dialogs.
    /// </summary>
    fvExportFileFilter,
    /// <summary>
    ///   Reserved.
    /// </summary>
    fvOther);
  /// <summary>
  ///   Set of flags used in IO transports to define visibility of IO transport
  ///   filter.
  /// </summary>
  TfrxFilterVisibility = set of TfrxFilterVisibleState;

  /// <summary>
  ///   Supported stream type for current IO transport filter.
  /// </summary>
  TfrxIOTransportStream = (
    /// <summary>
    ///   IO filter supports Read operations.
    /// </summary>
    tsIORead,
    /// <summary>
    ///   IO filter supports Write operations.
    /// </summary>
    tsIOWrite);
  /// <summary>
  ///   Set of flags for supported stream types by IO transport filter.
  /// </summary>
  TfrxIOTransportStreams = set of TfrxIOTransportStream;


  /// <summary>
  ///   The TfrxCustomIOTransport class is the base class for all IO
  ///   (input/output filters). It represents Base adapter interface for file
  ///   or stream IO operations. Transport filters can be used in the report
  ///   designer (save/open operations), report preview (save/open operations)
  ///   and export filters. It possible to create one class of transport filter
  ///   which encapsulates work with some IO protocol(for example save/load
  ///   from cloud) and use this class where it's necessary(Designer, Preview,
  ///   Exports) by setting up Visibility property.
  /// </summary>
  TfrxCustomIOTransport = class(TComponent)
  private
    FReport: TfrxReport;
    FShowDialog: Boolean;
    FOverwritePrompt: Boolean;
    FDefaultPath: String;
    FBasePath: String;
    FFileName: String;
    FDefaultExt: String;
    FExtDescription: String;
    FFilterString: String;
    FFilterAccess: TfrxFilterAccess;
    FTempFilter: TfrxCustomIOTransport;

    FCurNode: TfrxNode;
    function GetTempFilter: TfrxCustomIOTransport;
    procedure SetTempFilter(const Value: TfrxCustomIOTransport);
    procedure SetInternalFilter(const Value: TfrxCustomIOTransport);
    function GetInternalFilter: TfrxCustomIOTransport;
    function GetCurrentContainer: String;
    procedure SetCurrentContainer(const Value: String);
  protected
    FNoRegister: Boolean;
    FVisibility: TfrxFilterVisibility;
    FCreatedFrom: TfrxFilterVisibleState;
    FFreeStream: Boolean;
    FClosedLoadLock: Boolean;
    FInternalFilter: TfrxCustomIOTransport;
    FDirTree: TfrxNode;
    FSupportedStreams: TfrxIOTransportStreams;
    FOriginalCopy: TfrxCustomIOTransport;
    function GetFilterString: String; virtual;
    function GetVisibility: TfrxFilterVisibility; virtual;
    procedure SetVisibility(const Value: TfrxFilterVisibility); virtual;
    function GetNodeFromPath(aPath: String; bCreateNodes: Boolean = False; bLastNodeAsFile: Boolean = False): TfrxNode;
    { override for container functional if needed }
    function AddContainer(Item: TfrxNode): Boolean; virtual;
    function RemoveContainer(Item: TfrxNode): Boolean; virtual;
    function DoCreateStream(var aFullFilePath: String; aFileName: String): TStream; virtual;
    property InternalFilter: TfrxCustomIOTransport read GetInternalFilter write SetInternalFilter;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    ///   This constructor creates component without registration in global
    ///   list so the filter will be hidden for preview or report designer.
    /// </summary>
    constructor CreateNoRegister;
    /// <summary>
    ///   Copy constructor.
    /// </summary>
    /// <param name="CreatedFrom">
    ///   Instance to copy from.
    /// </param>
    /// <returns>
    ///   New copy of filter.
    /// </returns>
    function CreateFilterClone(CreatedFrom: TfrxFilterVisibleState): TfrxCustomIOTransport;
    destructor Destroy; override;
    // basic file structure methods
    /// <summary>
    ///   The method closes all opened streams.
    /// </summary>
    procedure CloseAllStreams;
    /// <summary>
    ///   It copies names of steams in current transport to TStrings passed as
    ///   a parameter.
    /// </summary>
    /// <param name="aStrings">
    ///   List to copy into.
    /// </param>
    /// <param name="OpenedOnly">
    ///   Copy only names of open streams.
    /// </param>
    procedure CopyStreamsNames(aStrings: TStrings; OpenedOnly: Boolean = False);
    /// <summary>
    ///   Loads and opens steams from the list.
    /// </summary>
    /// <param name="aStrings">
    ///   List with steam names.
    /// </param>
    procedure LoadStreamsList(aStrings: TStrings);
    /// <summary>
    ///   Reloads all closed streams and open them again.
    /// </summary>
    procedure LoadClosedStreams;
    { containers / Directories }
    /// <summary>
    ///   Creates a structure node represents a container or directory.
    /// </summary>
    /// <param name="cName">
    ///   Name of a container.
    /// </param>
    /// <param name="bSetCurrent">
    ///   Set this container as current.
    /// </param>
    procedure CreateContainer(const cName: String; bSetCurrent: Boolean = False);
    /// <summary>
    ///   Deletes a structure node represents a container or directory.
    /// </summary>
    procedure DeleteContainer(const cName: String);
    /// <summary>
    ///   Creates a structure node represents a temporary container or
    ///   directory.
    /// </summary>
    procedure CreateTempContainer; virtual;
    /// <summary>
    ///   Destroy a structure node represents a temporary container or
    ///   directory.
    /// </summary>
    procedure FreeTempContainer; virtual;
    { file streams }
    /// <summary>
    ///   Returns stream by name of a node or a file.
    /// </summary>
    /// <param name="aFileName">
    ///   File or node name.
    /// </param>
    function GetStream(aFileName: String = ''): TStream; virtual;
    /// <summary>
    ///   Closes an opened stream by reference or name.
    /// </summary>
    /// <param name="aStream">
    ///   Reference to opened stream.
    /// </param>
    /// <param name="aFileName">
    ///   Stream or file name.
    /// </param>
    procedure FreeStream(aStream: TStream; const aFileName: String = ''); virtual;
    /// <summary>
    ///   This method call before loading from stream is started. Can be used
    ///   to make a preparation of stream data before loading.
    /// </summary>
    function DoFilterProcessStream(aStream: TStream; ProcesssingObject: TObject): Boolean; virtual;
    /// <summary>
    ///   Returns true when physically all stream belongs to one container(zip
    ///   archive).
    /// </summary>
    function AllInOneContainer: Boolean; virtual;
    // filter (un)init
    /// <summary>
    ///   This method can be called to open filter. It uses to make preparation
    ///   like set connection or show user dialogs. It returns true when
    ///   initialization was processed.
    /// </summary>
    function OpenFilter: Boolean; virtual;
    /// <summary>
    ///   This method can be called to close a filter. It uses to make
    ///   finalization like close connection and streams.
    /// </summary>
    procedure CloseFilter; virtual;
    /// <summary>
    ///   Initialization of transport filter based on export filter
    ///   settings(like file name and file extension).
    /// </summary>
    /// <param name="ExportFilter">
    ///   Instance of an export filter.
    /// </param>
    procedure InitFromExport(ExportFilter: TfrxCustomExportFilter);
    /// <summary>
    ///   This method assigns properties of other transport filter to current.
    /// </summary>
    procedure AssignFilter(Source: TfrxCustomIOTransport); virtual;
    /// <summary>
    ///   This method assigns shared properties(like tokens) of other transport
    ///   filter to current.
    /// </summary>
    procedure AssignSharedProperties(Source: TfrxCustomIOTransport); virtual;
    procedure AssignOriginalSharedProperties;
    /// <summary>
    ///   Returns nearest file node in current container.
    /// </summary>
    function GetFileNode: TfrxNode;
    class function GetDescription: String; virtual;
    /// <summary>
    ///   Root node of the filter.
    /// </summary>
    property RootNode: TfrxNode read FDirTree;
    /// <summary>
    ///   Name of the current container.
    /// </summary>
    property CurrentContainer: String read GetCurrentContainer write SetCurrentContainer;
    /// <summary>
    ///   This flag shows where the current instance of the filter was created
    ///   from.
    /// </summary>
    property CreatedFrom: TfrxFilterVisibleState read FCreatedFrom write FCreatedFrom;
    /// <summary>
    ///   Returns reference to transport filter instance for temporary
    ///   operations.
    /// </summary>
    property TempFilter: TfrxCustomIOTransport read GetTempFilter write SetTempFilter;
    /// <summary>
    ///   Access type of IO filter.
    /// </summary>
    property FilterAccess: TfrxFilterAccess read FFilterAccess write FFilterAccess;
    /// <summary>
    ///   Description of filter instance.
    /// </summary>
    property FilterString: String read GetFilterString write FFilterString;
    /// <summary>
    ///   Reference to a report component.
    /// </summary>
    property Report: TfrxReport read FReport write FReport;
    /// <summary>
    ///   Whether to display a print dialogue. Default value is True.
    /// </summary>
    property ShowDialog: Boolean read FShowDialog write FShowDialog;
    property OverwritePrompt: Boolean read FOverwritePrompt write FOverwritePrompt;
    /// <summary>
    ///   Default path used in transport filter.
    /// </summary>
    property DefaultPath: String read FDefaultPath write FDefaultPath;
    /// <summary>
    ///   File name for current filter.
    /// </summary>
    property FileName: String read FFileName write FFileName;
    /// <summary>
    ///   Base path used in transport filter.
    /// </summary>
    property BasePath: String read FBasePath write FBasePath;
    /// <summary>
    ///   Default extension used in transport filter.
    /// </summary>
    property DefaultExt: String read FDefaultExt write FDefaultExt;
    /// <summary>
    ///   Description for default extension used in transport filter.
    /// </summary>
    property ExtDescription: String read FExtDescription write FExtDescription;
    /// <summary>
    ///   These flags used in IO transports to define visibility of IO
    ///   transport filter. By default each transport filter component
    ///   registers in global list and these flags helps to sort items of the
    ///   global list.
    /// </summary>
    property Visibility: TfrxFilterVisibility read GetVisibility write SetVisibility;
    /// <summary>
    ///   Supported stream type for current IO transport filter.
    /// </summary>
    property SupportedStreams: TfrxIOTransportStreams read FSupportedStreams write FSupportedStreams;
  end;

  /// <summary>
  ///   The class is the base IO transport filter class for all file
  ///   operations. IO filters which work directly with files use this class as
  ///   ancestor.
  /// </summary>
  TfrxIOTransportFile = class(TfrxCustomIOTransport)
  private
    FTempFolderCreated: Boolean;
  protected
    procedure SetVisibility(const Value: TfrxFilterVisibility); override;
    function AddContainer(Item: TfrxNode): Boolean; override;
    procedure DeleteFiles;
  public
    constructor Create(AOwner: TComponent); override;
    function OpenFilter: Boolean; override;
    function DoCreateStream(var aFullFilePath: String; aFileName: String): TStream; override;
    procedure CloseFilter; override; // Empty
    class function GetDescription: String; override;
    procedure CreateTempContainer; override;
    procedure FreeTempContainer; override;
  end;

  /// <summary>
  ///   The class represents compressed file transport filter.
  /// </summary>
  TfrxSaveToCompressedFilter = class(TfrxIOTransportFile)
  private
    FIsFR3File: Boolean;
    procedure SetIsFR3File(const Value: Boolean);
  protected
    function GetFilterString: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    function OpenFilter: Boolean; override;
    class function GetDescription: String; override;
    /// <summary>
    ///   True when it's an report template file.
    /// </summary>
    property IsFR3File: Boolean read FIsFR3File write SetIsFR3File;
  end;

  /// <summary>
  ///   The TfrxCustomExportFilter is the base class for all export filters.
  /// </summary>
  TfrxCustomExportFilter = class(TComponent)
  private
    FCurPage: Boolean;
    FExportNotPrintable: Boolean;
    FName: String;
    FNoRegister: Boolean;
    FPageNumbers: String;
    FReport: TfrxReport;
    FShowDialogOptions: TfrxShowDialogOptions;
    FStream: TStream;
    FUseFileCache: Boolean;
    FDefaultPath: String;
    FSlaveExport: Boolean;
    FShowProgress: Boolean;
    FDefaultExt: String;
    FFilterDesc: String;
    FSuppressPageHeadersFooters: Boolean;
    FTitle: String;
    FOverwritePrompt: Boolean;
    FFIles: TStrings;
    FOnBeforeExport: TNotifyEvent;
    FOnBeginExport: TNotifyEvent;
    FOnGenerateSheetName: TfrxGenerateSheetName;
    FCreationTime: TDateTime;
    FDataOnly: Boolean;
    FIOTransport: TfrxCustomIOTransport;
    FOpenAfterExport: Boolean;
    FCalculatePictureHash: Boolean;
    function GetDefaultIOTransport: TfrxCustomIOTransport;
    procedure SetDefaultIOTransport(const Value: TfrxCustomIOTransport);
    procedure SetFileName(const Value: String);
    procedure SetShowDialog(b: Boolean);
    function GetShowDialog: Boolean;
  protected
    FDefaultIOTransport: TfrxCustomIOTransport;
    FTerminated: Boolean;
    FfrxPictureHashMap: TfrxPictureHashMap;
    procedure Finish; virtual;
    procedure AfterFinish; virtual;
    procedure BeforeStart; virtual;
    function Start: Boolean; virtual;
    function EnableCalculateHash: Boolean; virtual;

    /// <summary>
    ///   The event responsible for the sheet name generation template.
    /// </summary>
    property OnGenerateSheetName: TfrxGenerateSheetName read FOnGenerateSheetName write FOnGenerateSheetName;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    ///   This constructor creates component without registration in global
    ///   list so the filter will be hidden for preview. Thread safe
    ///   constructor.
    /// </summary>
    constructor CreateNoRegister;
    destructor Destroy; override;
    /// <summary>
    ///   Method is called after finishing the export no matter if it was canceled or compleated.
    ///   It's used to clear intarnal resorces.
    /// </summary>
    procedure ClearResources; virtual;
    /// <summary>
    ///   Description of the export filter. This value is displayed in the
    ///   preview window.
    /// </summary>
    class function GetDescription: String; virtual;
    /// <summary>
    ///   Method should show the export settings dialog and return mrOk value
    ///   if dialog was accepted. This method is not called if ShowDialog
    ///   property is False.
    /// </summary>
    function ShowModal: TModalResult; virtual;
    /// <summary>
    ///   Method is called before export starts. To continue export, this
    ///   method should return True.
    /// </summary>
    function DoStart: Boolean;
    /// <summary>
    ///   Method created default instance of transport filter for current class
    ///   of export filter.
    /// </summary>
    function CreateDefaultIOTransport: TfrxCustomIOTransport; virtual;
    /// <summary>
    ///   Method is called when exporting the object. Bands are exported too.
    /// </summary>
    procedure ExportObject(Obj: TfrxComponent); virtual; abstract;
    /// <summary>
    ///   Method is called after finishing the export.
    /// </summary>
    procedure DoFinish;
    /// <summary>
    ///   Method is called after finishing a page. Page is the reference to a
    ///   page, Index is the page index in the prepared report.
    /// </summary>
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); virtual;
    /// <summary>
    ///   Method is called before exporting a page. Page is the reference to a
    ///   page, Index is the page index in the prepared report.
    /// </summary>
    procedure StartPage(Page: TfrxReportPage; Index: Integer); virtual;
    /// <summary>
    ///   Begin clip operation.
    /// </summary>
    /// <param name="Obj">
    ///   Rect of this object use as a clip rect.
    /// </param>
    procedure BeginClip(Obj: TfrxView); virtual;
    /// <exception cref="">
    ///   Stop clip operation.
    /// </exception>
    procedure EndClip; virtual;
    /// <summary>
    ///   Returns True when filter export can process internal objects in other
    ///   objects.
    /// </summary>
    function IsProcessInternal: Boolean; virtual;
    property CalculatePictureHash: Boolean read FCalculatePictureHash write FCalculatePictureHash default True;
    /// <summary>
    ///   Default transport filter used for file operations in current export
    ///   filter.
    /// </summary>
    property DefaultIOTransport: TfrxCustomIOTransport read GetDefaultIOTransport write SetDefaultIOTransport;
    /// <summary>
    ///   If this property is True, only current page will be exported(in case
    ///   the export was called from the preview window).
    /// </summary>
    property CurPage: Boolean read FCurPage write FCurPage;
    /// <summary>
    ///   List of page numbers to export, for example '1-3,5,12'. If this
    ///   property is empty (by default), all pages will be exported.
    /// </summary>
    property PageNumbers: String read FPageNumbers write FPageNumbers;
    /// <summary>
    ///   Reference to a report.
    /// </summary>
    property Report: TfrxReport read FReport write FReport;
    /// <summary>
    ///   Reference to a stream used to save export filter result.
    /// </summary>
    property Stream: TStream read FStream write FStream;
    /// <summary>
    ///   Internal use.
    /// </summary>
    property SlaveExport: Boolean read FSlaveExport write FSlaveExport;
    /// <summary>
    ///   Default extension of export filter result.
    /// </summary>
    property DefaultExt: String read FDefaultExt write FDefaultExt;
    /// <summary>
    ///   Default description of export filter.
    /// </summary>
    property FilterDesc: String read FFilterDesc write FFilterDesc;
    /// <summary>
    ///   Suppress page Headers and page Footers during export.
    /// </summary>
    property SuppressPageHeadersFooters: Boolean read FSuppressPageHeadersFooters
      write FSuppressPageHeadersFooters;
    /// <summary>
    ///   Title of export filter.
    /// </summary>
    property ExportTitle: String read FTitle write FTitle;
    /// <summary>
    ///   List of files generated by export filter.
    /// </summary>
    property Files: TStrings read FFiles write FFiles;
    /// <summary>
    ///   If True, document will be opened by default viewer.
    /// </summary>
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport;
    /// <summary>
    ///   If True, filter requests cancellation.
    /// </summary>
    property Terminated: Boolean read FTerminated write FTerminated;
    /// <summary>
    ///   Support for ShowDialog
    /// </summary>
    property ShowDialogOptions: TfrxShowDialogOptions read FShowDialogOptions write FShowDialogOptions default [doShowExportSettings, doShowSaveDialog];
  published
    property IOTransport: TfrxCustomIOTransport read FIOTransport write FIOTransport;
    /// <summary>
    ///   Determines if export settings dialogue is shown. Default value is
    ///   True.
    /// </summary>
    property ShowDialog: Boolean read GetShowDialog write SetShowDialog default True;
    /// <summary>
    ///   Default file name for export result.
    /// </summary>
    property FileName: String read FName write SetFileName;
    /// <summary>
    ///   If True, the report engine exports all objects with Printable flag
    ///   set to False.
    /// </summary>
    property ExportNotPrintable: Boolean read FExportNotPrintable write FExportNotPrintable default False;
    /// <summary>
    ///   Use a file cache for temporary operations.
    /// </summary>
    property UseFileCache: Boolean read FUseFileCache write FUseFileCache;
    /// <summary>
    ///   Default path of export result.
    /// </summary>
    property DefaultPath: String read FDefaultPath write FDefaultPath;
    /// <summary>
    ///   Shows dialog with export progress.
    /// </summary>
    property ShowProgress: Boolean read FShowProgress write FShowProgress;
    property OverwritePrompt: Boolean read FOverwritePrompt write FOverwritePrompt;
    /// <summary>
    ///   Creation time of the document.
    /// </summary>
    property CreationTime: TDateTime read FCreationTime write FCreationTime;
    /// <summary>
    ///   If True, the export engine exports only data bands objects.
    /// </summary>
    property DataOnly: Boolean read FDataOnly write FDataOnly;
    /// <summary>
    ///   This event fires before export starts.
    /// </summary>
    property OnBeforeExport: TNotifyEvent read FOnBeforeExport write FOnBeforeExport;
    /// <summary>
    ///   This event fires when export filter is being exported.
    /// </summary>
    property OnBeginExport: TNotifyEvent read FOnBeginExport write FOnBeginExport;
  end;

  /// <summary>
  ///   The TfrxCustomWizard class is the basic class for any wizards. Wizards
  ///   are called from the designer's menu "File|New...". Wizard should be
  ///   registered via frxWizards.Register method, defined in the frxDsgnIntf
  ///   unit.
  /// </summary>
  TfrxCustomWizard = class(TComponent)
  private
    FDesigner: TfrxCustomDesigner;
    FReport: TfrxReport;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    ///   Returns the wizard description.
    /// </summary>
    class function GetDescription: String; virtual;
    /// <summary>
    ///   Method is called when running the wizard; it must return "True," if
    ///   the wizard finished working successfully and brought any changes to
    ///   the report.
    /// </summary>
    function Execute: Boolean; virtual; abstract;
    /// <summary>
    ///   Reference to the report designer.
    /// </summary>
    property Designer: TfrxCustomDesigner read FDesigner;
    /// <summary>
    ///   Reference to the report.
    /// </summary>
    property Report: TfrxReport read FReport;
  end;

  TfrxWizardClass = class of TfrxCustomWizard;

  TfrxCustomAggregateList = class(TObject)
  public
    procedure Clear; virtual; abstract;
    procedure ClearValues; virtual; abstract;
    procedure AddItems(Page: TfrxReportPage); virtual; abstract;
    procedure AddValue(DataRow: TfrxComponent; VColumn: Integer = 0); virtual; abstract;
    function AddCalculatedValue(DataRow: TfrxComponent; const Value: Variant; VColumn: Integer = 0): Boolean; virtual; abstract;
    function AddAggregatedItem(AObject: IfrxAggregateObject; Container: TfrxComponent; AList: TList = nil): Boolean; virtual; abstract;
    procedure DeleteValue(DataRow: TfrxComponent); virtual; abstract;
    procedure SaveValue(DataRow: TfrxComponent); virtual; abstract;
    procedure RestoreValue(DataRow: TfrxComponent); virtual; abstract;
    procedure EndKeep; virtual; abstract;
    procedure Reset(ParentContainer: TfrxComponent); virtual; abstract;
    procedure StartKeep; virtual; abstract;
    function GetValue(ParentContainer: TfrxComponent; const ComplexName: String;
      VColumn: Integer = 0): Variant; overload; virtual; abstract;
    function GetValue(ParentContainer: TfrxComponent; VColumn: Integer;
      const Name, Expression: String; DataRow: TfrxComponent; Flags: Integer): Variant; overload; virtual; abstract;
  end;

  /// <summary>
  ///   The TfrxCustomEngine class is the base class for report engine.
  ///   Instance of this class is stored in the TfrxReport.Engine property.
  /// </summary>
  TfrxCustomEngine = class(TPersistent)
  private
    FCurColumn: Integer;
    FCurVColumn: Integer;
    FCurLine: Integer;
    FCurLineThrough: Integer;
    FFinalPass: Boolean;
    FNotifyList: TList;
    FPageHeight: Extended;
    FPageWidth: Extended;
    FPreviewPages: TfrxCustomPreviewPages;
    FReport: TfrxReport;
    FRunning: Boolean;
    FStartDate: TDateTime;
    FStartTime: TDateTime;
    FTotalPages: Integer;
    FOnRunDialog: TfrxRunDialogEvent;
    FSecondScriptCall: Boolean;
    FCurTableRow: Integer;
    FCurTableColumn: Integer;
    function GetDoublePass: Boolean;
    procedure SetPreviewPages(const Value: TfrxCustomPreviewPages);
  protected
    FCurX: Extended;
    FCurY: Extended;
    function GetAggregates: TfrxCustomAggregateList; virtual; abstract;
  protected
    function GetPageHeight: Extended; virtual;
  public
    constructor Create(AReport: TfrxReport); virtual;
    destructor Destroy; override;
    /// <summary>
    ///   Called when page printing is finished.
    /// </summary>
    procedure EndPage; virtual; abstract;
    /// <summary>
    ///   Breaks any keep operation currently active.
    /// </summary>
    procedure BreakAllKeep; virtual;
    /// <summary>
    ///   Creates a new column in a multicolumn report. After the last column,
    ///   page break is automatically inserted.
    /// </summary>
    procedure NewColumn; virtual; abstract;
    /// <summary>
    ///   Creates a new page (page break).
    /// </summary>
    procedure NewPage; virtual; abstract;
    /// <summary>
    ///   Builds a shift tree of child objects for current container.
    /// </summary>
    /// <param name="Container">
    ///   Objects container.
    /// </param>
    procedure PrepareShiftTree(Container: TfrxReportComponent); virtual; abstract;
    /// <summary>
    ///   Displays a band with a specified name. After displaying a band, the
    ///   "CurY" position is automatically shifted.
    /// </summary>
    function ShowBand(Band: TfrxBand): TfrxBand; overload; virtual; abstract;
    /// <summary>
    ///   Displays a band with a specified name. After displaying a band, the
    ///   "CurY" position is automatically shifted.
    /// </summary>
    procedure ShowBand(Band: TfrxBandClass); overload; virtual; abstract;
    /// <summary>
    ///   Displays a band with a specified name. After displaying a band, the
    ///   "CurY" position is automatically shifted.
    /// </summary>
    procedure ShowBandByName(const BandName: String);
    /// <summary>
    ///   Performs stretch operation on passed container object.
    /// </summary>
    /// <param name="Band">
    ///   Container object. <br />
    /// </param>
    procedure Stretch(Band: TfrxReportComponent; SkipGetData: Boolean = False); virtual; abstract;
    /// <summary>
    ///   Returns back state of the container after stretch operation.
    /// </summary>
    /// <param name="Band">
    ///   Container object.
    /// </param>
    procedure UnStretch(Band: TfrxReportComponent); virtual; abstract;
    procedure InitializeSplit(Container: TfrxReportComponent; SavedObjects: TList; SplitObject: TList); virtual; abstract;
    function SplitObjects(Container: TfrxReportComponent; SavedObjects: TList; SplitObject: TList; AHeight: Extended): Boolean; virtual; abstract;
    procedure FinalizeSplit(Container: TfrxReportComponent; SavedObjects: TList; SplitObject: TList; SplitHeight: Extended); virtual; abstract;
    /// <summary>
    ///   Stops report preparation.
    /// </summary>
    procedure StopReport;
    function HeaderHeight(AddReprintOnNewPage: Boolean = False): Extended; virtual; abstract;
    /// <summary>
    ///   Returns height of the footers.
    /// </summary>
    function FooterHeight: Extended; virtual; abstract;
    /// <summary>
    ///   Returns height value of white space left on a page, in pixels.
    /// </summary>
    function FreeSpace: Extended; virtual; abstract;
    /// <summary>
    ///   Returns value of aggregate function for an expression.
    /// </summary>
    /// <param name="Name">
    ///   Method name (aggregate name).
    /// </param>
    /// <param name="Expression">
    ///   Expression.
    /// </param>
    /// <param name="Band">
    ///   Band reference.
    /// </param>
    /// <param name="Flags">
    ///   Flag.
    /// </param>
    function GetAggregateValue(const Name, Expression: String;
      DataRow: TfrxComponent;  Flags: Integer): Variant; virtual; abstract;
    /// <summary>
    ///   Processed GetData for passed object. Used with paCustom flag.
    /// </summary>
    procedure ProcessObject(ReportObject: TfrxView); virtual; abstract;
    /// <summary>
    ///   This method runs the report engine.
    /// </summary>
    /// <param name="ARunDialogs">
    ///   If True, Processes report dialog pages.
    /// </param>
    /// <param name="AClearLast">
    ///   Clears last result from prepared pages.
    /// </param>
    /// <param name="APage">
    ///   Reference to a page(if nil, prepares all).
    /// </param>
    function Run(ARunDialogs: Boolean;
      AClearLast: Boolean = False; APage: TfrxPage = nil): Boolean; virtual; abstract;
    property Aggregates: TfrxCustomAggregateList read GetAggregates;
    /// <summary>
    ///   Current line number.
    /// </summary>
    property CurLine: Integer read FCurLine write FCurLine;
    /// <summary>
    ///   Current absolute line number (&lt;Line#&gt;).
    /// </summary>
    property CurLineThrough: Integer read FCurLineThrough write FCurLineThrough;
    /// <summary>
    ///   Current row of the table.
    /// </summary>
    property CurTableRow: Integer read FCurTableRow write FCurTableRow;
    /// <summary>
    ///   Current column of the table.
    /// </summary>
    property CurTableColumn: Integer read FCurTableColumn write FCurTableColumn;
    /// <summary>
    ///   List with objects that receives a notifications from report engine.
    /// </summary>
    property NotifyList: TList read FNotifyList;
    /// <summary>
    ///   Reference to prepared report pages.
    /// </summary>
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages write SetPreviewPages;
    /// <summary>
    ///   Reference to a report component.
    /// </summary>
    property Report: TfrxReport read FReport;
    /// <summary>
    ///   True when dialog pages are running.
    /// </summary>
    property Running: Boolean read FRunning write FRunning;
    /// <summary>
    ///   Occurs when report dialog page is previewed.
    /// </summary>
    property OnRunDialog: TfrxRunDialogEvent read FOnRunDialog write FOnRunDialog;
  published
    /// <summary>
    ///   The number of the current column in a multi-columned report. A value
    ///   can be assigned to this property.
    /// </summary>
    property CurColumn: Integer read FCurColumn write FCurColumn;
    /// <summary>
    ///   The number of the current column in a cross-tab report.
    /// </summary>
    property CurVColumn: Integer read FCurVColumn write FCurVColumn;
    /// <summary>
    ///   The current shift of the coordinates on the X-axis. A value can be
    ///   assigned to this property.
    /// </summary>
    property CurX: Extended read FCurX write FCurX;
    /// <summary>
    ///   The current shift of the coordinates on the Y-axis. A value can be
    ///   assigned to this property.
    /// </summary>
    property CurY: Extended read FCurY write FCurY;
    /// <summary>
    ///   Equal to "True," if the report is a two-pass one. Analogous to
    ///   Report.EngineOptions.DoublePass.
    /// </summary>
    property DoublePass: Boolean read GetDoublePass;
    /// <summary>
    ///   Equal to "True," if the last pass of the two-pass report is
    ///   performed.
    /// </summary>
    property FinalPass: Boolean read FFinalPass write FFinalPass;
    /// <summary>
    ///   Printable region's height, in pixels.
    /// </summary>
    property PageHeight: Extended read GetPageHeight write FPageHeight;
    /// <summary>
    ///   Printable region's width, in pixels.
    /// </summary>
    property PageWidth: Extended read FPageWidth write FPageWidth;
    /// <summary>
    ///   Time of report running. A counterpart of the &lt;Date&gt; system
    ///   variable.
    /// </summary>
    property StartDate: TDateTime read FStartDate write FStartDate;
    /// <summary>
    ///   Time of report running. A counterpart of the &lt;Time&gt; system
    ///   variable.
    /// </summary>
    property StartTime: TDateTime read FStartTime write FStartTime;
    /// <summary>
    ///   A number of output pages in a report. A counterpart of the
    ///   &lt;TotalPages&gt; system variable. The report should be a two-pass
    ///   one, so that this variable can be used.
    /// </summary>
    property TotalPages: Integer read FTotalPages write FTotalPages;
    /// <summary>
    ///   Flag for the determination of repeat call of event (in some cases the
    ///   event can be called repeatedly during grouping), if True then the
    ///   script has already been operated.
    /// </summary>
    property SecondScriptCall: Boolean read FSecondScriptCall write FSecondScriptCall;
  end;

  /// <summary>
  ///   This object represents the "Report tree" control element in a preview
  ///   window. Instance of this class is stored in the
  ///   TfrxReport.PreviewPages.Outline property.
  /// </summary>
  TfrxCustomOutline = class(TPersistent)
  private
    FCurItem: TfrXMLItem;
    FPreviewPages: TfrxCustomPreviewPages;
  protected
    function GetCount: Integer; virtual; abstract;
  public
    constructor Create(APreviewPages: TfrxCustomPreviewPages); virtual;
    /// <summary>
    ///   Adds an element with the "Text" name to the current tree position.
    ///   The current report's page and the Top position on the page are
    ///   associated with the element.
    /// </summary>
    procedure AddItem(const Text: String; Top: Integer); virtual; abstract;
    procedure DeleteItems(From: TfrXMLItem); virtual; abstract;
    procedure LevelDown(Index: Integer); virtual; abstract;
    /// <summary>
    ///   Shifts the current position in the tree to the root level.
    /// </summary>
    procedure LevelRoot; virtual; abstract;
    /// <summary>
    ///   Shifts the current position in the tree on one level up.
    /// </summary>
    procedure LevelUp; virtual; abstract;
    procedure GetItem(Index: Integer; var Text: String;
      var Page, Top: Integer); virtual; abstract;
    procedure ShiftItems(From: TfrXMLItem; NewTop: Integer); virtual; abstract;
    function Engine: TfrxCustomEngine;
    function GetCurPosition: TfrXMLItem; virtual; abstract;
    property Count: Integer read GetCount;
    property CurItem: TfrXMLItem read FCurItem write FCurItem;
    property PreviewPages: TfrxCustomPreviewPages read FPreviewPages;
  end;

  /// <summary>
  ///   This class encapsulate data for object processing engine.
  /// </summary>
  TfrxObjectProcessing = class(TPersistent)
  private
    FProcessAt: TfrxProcessAtMode;
    FGroupLevel: Integer;
  public
    procedure Assign(Source: TPersistent); override;
  published
    /// <summary>
    ///   This property controls when to process expression calculation(for
    ///   some TfrxView objects).
    /// </summary>
    property ProcessAt: TfrxProcessAtMode read FProcessAt write FProcessAt default paDefault;
    /// <summary>
    ///   It represent level of nested group which will be used to calculate
    ///   object data. This property used with paGroupFinished flag. Zero means
    ///   all groups call data calculation for current object. The value above
    ///   zero represents nested group level number.
    /// </summary>
    property GroupLevel: Integer read FGroupLevel write FGroupLevel default 0;
  end;

  /// <summary>
  ///   Internal class used by data processing engine. Stores values for post
  ///   processor.
  /// </summary>
  TfrxMacrosItem = class(TObject)
  private
    FItems: TWideStrings;
    FSupressedValue: Variant;
    FLastIndex: Integer;
    FComponent: TfrxComponent;
    FBaseComponent: TfrxComponent;
    FBandName: String;
    FNeedReset: Boolean;
    FProcessAt: TfrxProcessAtMode;
    FGroupLevel: Integer;
    FDataLevel: Integer;
    FParent: TfrxPostProcessor;
    function GetItem(Index: Integer): WideString;
    procedure SetItem(Index: Integer; const Value: WideString);
  public
    constructor Create;
    destructor Destroy; override;
    function AddObject(const S: WideString; AObject: TObject; bSupressed: Boolean = false): Integer;
    function Count: Integer;
    property Item[Index: Integer]: WideString read GetItem write SetItem;
  end;

  /// <summary>
  ///   This class used as post-process data dictionary. It controls behaviour
  ///   of post-processed objects and stores data and expressions of these
  ///   objects. Used by the report engine for delay expression calculation in
  ///   selected objects.
  /// </summary>
  TfrxPostProcessor = class(TPersistent)
  private
    FMacroses: TStrings;
    FProcessList: TList;
    FBands: TStrings;
    FGroupLevel: Integer;
    FDataLevel: Integer;
    FProcessing: Boolean;
  public
    /// <summary>
    ///   Default constructor.
    /// </summary>
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Clears and destroys all items in dictionary list.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds new View component to the list for delayed calculation. Places
    ///   an item to the list for future calculation.
    /// </summary>
    /// <param name="BandName">
    ///   Name of the parent band.
    /// </param>
    /// <param name="Name">
    ///   Item name(usually component name).
    /// </param>
    /// <param name="Content">
    ///   Content to be stored and calculated later(usually an expression).
    /// </param>
    /// <param name="ProcessMode">
    ///   Controls when to process expression calculation.
    /// </param>
    /// <param name="aComponent">
    ///   Reference to a view component.
    /// </param>
    /// <param name="bSupressed">
    ///   process suppressed values.
    /// </param>
    /// <param name="bEmpty">
    ///   Clear suppressed values.
    /// </param>
    function Add(const BandName: String; const Name: String; const Content: WideString; ProcessMode: TfrxProcessAtMode; aComponent: TfrxComponent; bSupressed: Boolean = false; bEmpty: Boolean = false): Integer;
    /// <summary>
    ///   Enter new group level.
    /// </summary>
    procedure EnterGroup;
    /// <summary>
    ///   Leaves current group level.
    /// </summary>
    procedure LeaveGroup;
    /// <summary>
    ///   Enters new data level.
    /// </summary>
    procedure EnterData;
    /// <summary>
    ///   Leaves new data level.
    /// </summary>
    procedure LeaveData;
    /// <summary>
    ///   Not used
    /// </summary>
    function GetValue(const MacroIndex: Integer; const MacroLine: Integer): WideString;
    /// <summary>
    ///   Returns list of items by name of object.
    /// </summary>
    /// <param name="MacroName">
    ///   Object name.
    /// </param>
    function GetMacroList(const MacroName: String): TWideStrings;
    /// <summary>
    ///   Loads value to component from dictionary.
    /// </summary>
    /// <param name="aComponent">
    ///   Reference to view component.
    /// </param>
    function LoadValue(aComponent: TfrxComponent): Boolean;
    /// <summary>
    ///   Save dictionary to XML node.
    /// </summary>
    procedure SaveToXML(Item: TfrXMLItem);
    /// <summary>
    ///   Load dictionary from XML node.
    /// </summary>
    procedure LoadFromXML(Item: TfrXMLItem);
    /// <summary>
    ///   Resets suppressed values in the list.
    /// </summary>
    procedure ResetSuppressed;
    /// <summary>
    ///   Resets duplicates values in the list.
    /// </summary>
    procedure ResetDuplicates(const BandName: String = '');
    /// <summary>
    ///   Calculates an expression for items in the list. It called by the
    ///   report engine when one of the events occurs. Removes objects from the
    ///   processing list when appropriate event occurs.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="ABand">
    ///   Name of the band container being processed.
    /// </param>
    /// <param name="ProcessMode">
    ///   Mode that should be processed.
    /// </param>
    procedure ProcessExpressions(AReport: TfrxReport; ABand: TfrxBand; ProcessMode: TfrxProcessAtMode);
    /// <summary>
    ///   It calculates an expressions for selected view component.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="aComponent">
    ///   Reference to a view component.
    /// </param>
    procedure ProcessObject(AReport: TfrxReport; aComponent: TfrxComponent);
    /// <summary>
    ///   List of items in the dictionary.
    /// </summary>
    property Macroses: TStrings read FMacroses;
  end;

  /// <summary>
  ///   The TfrxCustomPreviewPages class is the base class for pages of a
  ///   prepared report. Instance of this class is stored in the
  ///   TfrxReport.PreviewPages property.
  /// </summary>
  TfrxCustomPreviewPages = class(TObject)
  private
    FAddPageAction: TfrxAddPageAction; { used in the cross-tab renderer }
    FCurPage: Integer;
    FCurPreviewPage: Integer;
    FFirstPage: Integer;               {  used in the composite reports }
    FOutline: TfrxCustomOutline;
    FReport: TfrxReport;
    FEngine: TfrxCustomEngine;
    FPictureCacheOptions: TfrxPictureCacheOptions;
    FStyles: TfrxStyles;
    function GetStyles: TfrxStyles;
    procedure SetStyles(const Value: TfrxStyles);
  protected
    FCopyNo: Integer;
    FPrintScale: Extended;
    FPostProcessor: TfrxPostProcessor;
    procedure ClearPageCache; virtual; abstract;
    procedure ClearStyles;
    function FindStyle(const AStyleName: string): TfrxStyleItem;
    function GetCount: Integer; virtual; abstract;
    function GetPage(Index: Integer): TfrxReportPage; virtual; abstract;
    function GetPageSize(Index: Integer): TPoint; virtual; abstract;
    function GetPictureCacheOptions: TfrxPictureCacheOptions; virtual;
  public
    /// <summary>
    ///   Default constructor.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to an owner report component.
    /// </param>
    constructor Create(AReport: TfrxReport); virtual;
    destructor Destroy; override;
    /// <summary>
    ///   Clears a prepared report.
    /// </summary>
    procedure Clear; virtual; abstract;
    /// <summary>
    ///   Initializes preview pages.
    /// </summary>
    procedure Initialize; virtual; abstract;

    /// <summary>
    ///   This method adds an object to current preview page.
    /// </summary>
    /// <param name="Obj">
    ///   Reference to report object.
    /// </param>
    procedure AddObject(Obj: TfrxComponent); virtual; abstract;
    /// <summary>
    ///   This method adds new preview page or increases number of current
    ///   preview page by 1 depends on AddPageAction flag.
    /// </summary>
    /// <param name="Page">
    ///   Reference to report page.
    /// </param>
    procedure AddPage(Page: TfrxReportPage); virtual; abstract;
    /// <summary>
    ///   This method adds report template page to preview page objects
    ///   dictionary.
    /// </summary>
    /// <param name="Page">
    ///   Reference to report template page.
    /// </param>
    procedure AddSourcePage(Page: TfrxReportPage); virtual; abstract;
    /// <summary>
    ///   This method adds report template object to preview page objects
    ///   dictionary.
    /// </summary>
    /// <param name="Obj">
    ///   Report object.
    /// </param>
    procedure AddToSourcePage(Obj: TfrxComponent); virtual; abstract;
    /// <summary>
    ///   The report engine call this method when start first pass of double
    ///   pass report.
    /// </summary>
    procedure BeginPass; virtual; abstract;
    /// <summary>
    ///   Clears results of the first pass.
    /// </summary>
    procedure ClearFirstPassPages; virtual; abstract;
    /// <summary>
    ///   Cuts objects from current serialized XML page by given XML node
    ///   position to temporary cut-buffer. <br />
    /// </summary>
    /// <param name="APosition">
    ///   Index of XML node in serialized preview page XML node.
    /// </param>
    procedure CutObjects(APosition: Integer); virtual; abstract;
    /// <summary>
    ///   Deletes serialized XML objects at given XML node position from
    ///   current serialized preview page.
    /// </summary>
    /// <param name="APosition">
    ///   XML node position.
    /// </param>
    procedure DeleteObjects(APosition: Integer); virtual; abstract;
    /// <summary>
    ///   Deletes all preview pages anchors starts at given position.
    /// </summary>
    /// <param name="From">
    ///   Start item position.
    /// </param>
    procedure DeleteAnchors(From: Integer); virtual; abstract;
    /// <summary>
    ///   Called by the report engine when report preparation finished.
    /// </summary>
    procedure Finish; virtual;
    /// <summary>
    ///   Fires mouse leave behaviour for preview pages objects.
    /// </summary>
    procedure FireMouseLeave; virtual;
    /// <summary>
    ///   Updates logical page number variable.
    /// </summary>
    procedure IncLogicalPageNumber; virtual; abstract;
    function IsStylesActive: Boolean;
    /// <summary>
    ///   Resets logical page number variable.
    /// </summary>
    procedure ResetLogicalPageNumber; virtual; abstract;
    /// <summary>
    ///   Pastes cut objects from temporary buffer to current serialized XML
    ///   page at given X, Y position on the preview page.
    /// </summary>
    /// <param name="X">
    ///   X coordinate (column position).
    /// </param>
    /// <param name="Y">
    ///   Y coordinate (band position).
    /// </param>
    procedure PasteObjects(X, Y: Extended); virtual; abstract;
    /// <summary>
    ///   Shifts all preview pages anchors starts at given position by new top
    ///   position.
    /// </summary>
    /// <param name="From">
    ///   Start item position.
    /// </param>
    /// <param name="NewTop">
    ///   New top position.
    /// </param>
    procedure ShiftAnchors(From, NewTop: Integer); virtual; abstract;

    function GetPicture(CacheType: TfrxCachedGraphicType; ImageIndex: Integer): IfrxCachedGraphic; virtual; abstract;
    /// <summary>
    ///   Adds picture object to preview pages picture cache.
    /// </summary>
    procedure AddPicture(Picture: TfrxPictureView); virtual; abstract;
    function AddGraphic(Graphic: TGraphic): Integer; virtual; abstract;
    /// <summary>
    ///   Checks if band exist on current preview page.
    /// </summary>
    /// <param name="Band">
    ///   Reference to Band in a report template.
    /// </param>
    function BandExists(Band: TfrxBand): Boolean; virtual; abstract;
    /// <summary>
    ///   Returns current XML node position in serialized preview page.
    /// </summary>
    function GetCurPosition: Integer; virtual; abstract;
    /// <summary>
    ///   Returns current anchor item position.
    /// </summary>
    function GetAnchorCurPosition: Integer; virtual; abstract;
    /// <summary>
    ///   Returns last Y position on preview page which is not occupied by band
    ///   objects.
    /// </summary>
    /// <param name="ColumnPosition">
    ///   Column X position.
    /// </param>
    function GetLastY(ColumnPosition: Extended = 0): Extended; virtual; abstract;
    /// <summary>
    ///   Returns logical page number for current page.
    /// </summary>
    function GetLogicalPageNo: Integer; virtual; abstract;
    /// <summary>
    ///   Returns logical total pages count.
    /// </summary>
    function GetLogicalTotalPages: Integer; virtual; abstract;
    /// <summary>
    ///   Inserts an empty preview page at given position.
    /// </summary>
    /// <param name="Index">
    ///   Page index.
    /// </param>
    procedure AddEmptyPage(Index: Integer); virtual; abstract;
    /// <summary>
    ///   Deletes preview page at given position.
    /// </summary>
    /// <param name="Index">
    ///   Page index.
    /// </param>
    procedure DeletePage(Index: Integer); virtual; abstract;
    /// <summary>
    ///   This method writes changes of prepared page with all objects to
    ///   serialized XML. Use this method to save all changes made on prepared
    ///   page.
    /// </summary>
    /// <param name="Index">
    ///   Page index in prepared report.
    /// </param>
    /// <param name="Page">
    ///   Reference to modified page object.
    /// </param>
    procedure ModifyPage(Index: Integer; Page: TfrxReportPage); virtual; abstract;
    /// <summary>
    ///   This method writes changes of report object on prepared report page
    ///   to XML node with using objects data dictionary. Use this method to
    ///   save changes made on object of prepared report. This method uses data
    ///   dictionary and works much faster than ModifyPage method.
    /// </summary>
    /// <param name="Component">
    ///   Reference to modified prepared report object.
    /// </param>
    procedure ModifyObject(Component: TfrxComponent); virtual; abstract;
    /// <summary>
    ///   Draws prepared page on Canvas.
    /// </summary>
    /// <param name="Index">
    ///   Index of page to draw.
    /// </param>
    /// <param name="Canvas">
    ///   Destination Canvas.
    /// </param>
    /// <param name="ScaleX">
    ///   Scale X.
    /// </param>
    /// <param name="ScaleY">
    ///   Scale Y.
    /// </param>
    /// <param name="OffsetX">
    ///   X offset.
    /// </param>
    /// <param name="OffsetY">
    ///   Y offset.
    /// </param>
    /// <param name="bHighlightEditable">
    ///   Draws with highlight of editable objects.
    /// </param>
    procedure DrawPage(Index: Integer; Canvas: TCanvas; ScaleX, ScaleY,
      OffsetX, OffsetY: Extended; bHighlightEditable: Boolean = False); virtual; abstract;
    /// <summary>
    ///   This method sends an interactive message to preview page or/and
    ///   objects on that page.
    /// </summary>
    /// <param name="Index">
    ///   Page index of the page.
    /// </param>
    /// <param name="X">
    ///   X coordinate relative to parent preview workspace view(mouse
    ///   coordinates).
    /// </param>
    /// <param name="Y">
    ///   Y coordinate relative to parent preview workspace view(mouse
    ///   coordinates).
    /// </param>
    /// <param name="Button">
    ///   Mouse button.
    /// </param>
    /// <param name="Shift">
    ///   Shift button.
    /// </param>
    /// <param name="Scale">
    ///   Current scale of preview window.
    /// </param>
    /// <param name="OffsetX">
    ///   Horizontal offset (start of draw area based on horizontal scroll).
    /// </param>
    /// <param name="OffsetY">
    ///   Vertical offset (start of draw area based on vertical scroll). <br />
    /// </param>
    /// <param name="EventParams">
    ///   Structure used for additional event parameters (like event type).
    ///   Also stores return value.
    /// </param>
    procedure ObjectOver(Index: Integer; X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; Scale, OffsetX, OffsetY: Extended;
      var EventParams: TfrxPreviewIntEventParams); virtual; abstract;
    /// <summary>
    ///   Creates a composite prepared report through concatenation of preview
    ///   pages in to current preview pages.
    /// </summary>
    /// <param name="Report">
    ///   Source report.
    /// </param>
    procedure AddFrom(Report: TfrxReport); virtual; abstract;
    procedure AddFromPreviewPages(vPreviewPages: TfrxCustomPreviewPages); virtual; abstract;

    /// <summary>
    ///   Loads a prepared report from a stream. The AllowPartialLoading
    ///   parameter allows to load large files partially for saving memory.
    /// </summary>
    procedure LoadFromStream(Stream: TStream;
      AllowPartialLoading: Boolean = False); virtual; abstract;
    /// <summary>
    ///   Saves a prepared report to a stream.
    /// </summary>
    procedure SaveToStream(Stream: TStream); virtual; abstract;
    /// <summary>
    ///   Saves a prepared report by using IO transport class to get stream for
    ///   a prepared pages.
    /// </summary>
    /// <param name="Filter">
    ///   IO transport filter instance.
    /// </param>
    /// <param name="FileName">
    ///   Name of the prepared file.
    /// </param>
    function SaveToFilter(Filter: TfrxCustomIOTransport; const FileName: String): Boolean; virtual; abstract;
    /// <summary>
    ///   Loads a prepared report from a file.
    /// </summary>
    function LoadFromFile(const FileName: String;
      ExceptionIfNotFound: Boolean = False): Boolean; virtual; abstract;
    /// <summary>
    ///   Saves a prepared report to a file.
    /// </summary>
    procedure SaveToFile(const FileName: String); virtual; abstract;
    procedure SetActiveStyleSheet(const AName: String);
    /// <summary>
    ///   Prints a report.
    /// </summary>
    function Print: Boolean; virtual; abstract;
    /// <summary>
    ///   Exports a report.
    /// </summary>
    function Export(Filter: TfrxCustomExportFilter): Boolean; virtual; abstract;

    /// <summary>
    ///   This flag used by AddPage method. apWriteOver - writes over current
    ///   page if it isn't last page (in case it's last page a new page will be
    ///   added). apWriteOver - always adds new page.
    /// </summary>
    property AddPageAction: TfrxAddPageAction read FAddPageAction write FAddPageAction;
    /// <summary>
    ///   Number of pages in the prepared report.
    /// </summary>
    property Count: Integer read GetCount;
    /// <summary>
    ///   Current page number.
    /// </summary>
    property CurPage: Integer read FCurPage write FCurPage;
    /// <summary>
    ///   Current previewed page number.
    /// </summary>
    property CurPreviewPage: Integer read FCurPreviewPage write FCurPreviewPage;
    /// <summary>
    ///   Reference to the report engine object.
    /// </summary>
    property Engine: TfrxCustomEngine read FEngine write FEngine;
    /// <summary>
    ///   First page number in composite report.
    /// </summary>
    property FirstPage: Integer read FFirstPage write FFirstPage;
    /// <summary>
    ///   Link to the "Report outline" class.
    /// </summary>
    property Outline: TfrxCustomOutline read FOutline;
    /// <summary>
    ///   List of pages in the prepared report.
    /// </summary>
    property Page[Index: Integer]: TfrxReportPage read GetPage;
    /// <summary>
    ///   List of page sizes in the prepared report.
    /// </summary>
    property PageSize[Index: Integer]: TPoint read GetPageSize;
    /// <summary>
    ///   Number of printed copy.
    /// </summary>
    property PrintCopyNo: Integer read FCopyNo;
    /// <summary>
    ///   Scale for print output.
    /// </summary>
    property PrintScale: Extended read FPrintScale;
    /// <summary>
    ///   Reference to a report object.
    /// </summary>
    property Report: TfrxReport read FReport;
    property Styles: TfrxStyles read GetStyles write SetStyles;
    /// <summary>
    ///   Post-process data dictionary object.
    /// </summary>
    property PostProcessor: TfrxPostProcessor read FPostProcessor;
    property PictureCacheOptions: TfrxPictureCacheOptions read GetPictureCacheOptions;
  end;

  /// <summary>
  ///   The TfrxCustomPreview class is the base class for TfrxPreview class.
  /// </summary>
  TfrxCustomPreview = class(TCustomControl)
  private
    FUseReportHints: Boolean;
  protected
    FPreviewForm: TForm;
    FInPlaceditorsList: TfrxComponentEditorsList;
    FSelectionList: TfrxSelectedObjectsList;
    function GetReport: TfrxReport; virtual;
    procedure DoFinishInPlace(Sender: TObject; Refresh, Modified: Boolean); virtual;
    function GetPreviewPages: TfrxCustomPreviewPages; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    ///   This method initialize TfrxInteractiveEventsParams structure with
    ///   default values.
    /// </summary>
    procedure SetDefaultEventParams(var EventParams: TfrxInteractiveEventsParams); virtual;
    /// <summary>
    ///   Initializes report preview with giving report and preview pages.
    /// </summary>
    /// <param name="aReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="aPrevPages">
    ///   Reference to preview pages object.
    /// </param>
    function Init(aReport: TfrxReport; aPrevPages: TfrxCustomPreviewPages): Boolean; virtual; abstract;
    /// <summary>
    ///   Uninitializes report preview for passed report component. <br />
    /// </summary>
    /// <param name="aReport">
    ///   Reference to a report component.
    /// </param>
    procedure UnInit(aReport: TfrxReport); virtual; abstract;
    /// <summary>
    ///   Locks report preview for any update and draw operations.
    /// </summary>
    function Lock: Boolean; virtual; abstract;
    /// <summary>
    ///   Unlock report preview.
    /// </summary>
    /// <param name="DoUpdate">
    ///   Refresh after unlock.
    /// </param>
    procedure Unlock(DoUpdate: Boolean = True); virtual; abstract;
    /// <summary>
    ///   Rebuilds a report for current active preview pages.
    /// </summary>
    procedure RefreshReport; virtual; abstract;
    /// <summary>
    ///   Copies content for selected objects to clipboard. This method uses
    ///   InPlace editors to process copy behaviour of the selected objects.
    /// </summary>
    procedure InternalCopy; virtual;
    /// <summary>
    ///   Pastes content to selected objects from clipboard. This method uses
    ///   InPlace editors to process paste behaviour of the selected objects.
    /// </summary>
    procedure InternalPaste; virtual;
    /// <summary>
    ///   This method checks if paste is available for selected objects from
    ///   clipboard. It uses InPlace editors to process copy-paste behaviour of
    ///   the selected objects.
    /// </summary>
    function InternalIsPasteAvailable: Boolean; virtual;
    /// <summary>
    ///   The report engine calls this method when starts some action at
    ///   current report(preparation, export, print).
    /// </summary>
    /// <param name="Sender">
    ///   Sender object.
    /// </param>
    /// <param name="ProgressType">
    ///   Type of progress.
    /// </param>
    /// <param name="Progress">
    ///   Progress value.
    /// </param>
    procedure InternalOnProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); virtual; abstract;
    /// <summary>
    ///   The report engine calls this method to update action progress at
    ///   current report(preparation, export, print).
    /// </summary>
    /// <param name="Sender">
    ///   Sender object.
    /// </param>
    /// <param name="ProgressType">
    ///   Type of progress
    /// </param>
    /// <param name="Progress">
    ///   Progress value.
    /// </param>
    procedure InternalOnProgress(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); virtual; abstract;
    /// <summary>
    ///   The report engine calls this method when stops some action at current
    ///   report(preparation, export, print).
    /// </summary>
    /// <param name="Sender">
    ///   Sender object.
    /// </param>
    /// <param name="ProgressType">
    ///   Type of progress
    /// </param>
    /// <param name="Progress">
    ///   Progress value.
    /// </param>
    procedure InternalOnProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer); virtual; abstract;
    /// <summary>
    ///   Creates a new tab in the preview window linked with passed report
    ///   object.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="TabName">
    ///   Name of the Tab.
    /// </param>
    /// <param name="TabCaption">
    ///   Caption of the Tab.
    /// </param>
    /// <param name="FreeObjects">
    ///   If True, report object which is belong to the Tab object will be
    ///   freed.
    /// </param>
    /// <param name="aDetailPage">
    ///   Name of Detail page.
    /// </param>
    procedure AddPreviewTab(AReport: TfrxReport; const TabName: String; const TabCaption: String = ''; FreeObjects: Boolean = True; aDetailPage: String = ''); virtual; abstract;
    /// <summary>
    ///   Creates or switch to a new tab in the preview window linked with
    ///   passed report object.
    /// </summary>
    /// <param name="AReport">
    ///   Reference to a report component.
    /// </param>
    /// <param name="TabName">
    ///   Name of the Tab.
    /// </param>
    /// <param name="TabCaption">
    ///   Caption of the Tab.
    /// </param>
    /// <param name="FreeObjects">
    ///   Creates a new tab in the preview window linked with passed report
    ///   object.
    /// </param>
    /// <param name="aDetailPage">
    ///   Name of Detail page.
    /// </param>
    procedure AddPreviewTabOrSwitch(AReport: TfrxReport; const TabName: String; const TabCaption: String = ''; FreeObjects: Boolean = True; aDetailPage: String = ''); virtual; abstract;
    /// <summary>
    ///   Closes and removes Tab from report preview.
    /// </summary>
    /// <param name="TabIndex">
    ///   Index of the Tab.
    /// </param>
    procedure RemoveTab(TabIndex: Integer); virtual; abstract;
    /// <summary>
    ///   Checks if preview has Tab with giving name.
    /// </summary>
    /// <param name="TabName">
    ///   Name of the Tab.
    /// </param>
    function HasTab(const TabName: String): Boolean; overload; virtual; abstract;
    /// <summary>
    ///   Checks if preview has Tab with giving report object.
    /// </summary>
    /// <param name="aReport">
    ///   Reference to a report component.
    /// </param>
    function HasTab(const aReport: TfrxReport): Boolean; overload; virtual; abstract;
    /// <summary>
    ///   Returns True when report preview has visible tabs.
    /// </summary>
    function HasVisibleTabs: Boolean; virtual; abstract;
    /// <summary>
    ///   Called when active preview pages was changed.
    /// </summary>
    procedure PreviewPagesChanged; virtual; abstract;
    /// <summary>
    ///   Switches to Tab by giving name.
    /// </summary>
    /// <param name="TabName">
    ///   Name of the Tab.
    /// </param>
    procedure SwitchToTab(const TabName: String); overload; virtual; abstract;
    /// <summary>
    ///   Switches to Tab by giving report.
    /// </summary>
    /// <param name="aReport">
    ///   Reference to a report component.
    /// </param>
    procedure SwitchToTab(const aReport: TfrxReport); overload; virtual; abstract;

    /// <summary>
    ///   Reference to an active preview pages object.
    /// </summary>
    property PreviewPages: TfrxCustomPreviewPages read GetPreviewPages;// write FPreviewPages;
    /// <summary>
    ///   Reference to an active report object.
    /// </summary>
    property Report: TfrxReport read GetReport;// write FReport;
    /// <summary>
    ///   If True, shows hints of the report objects. Default True.
    /// </summary>
    property UseReportHints: Boolean read FUseReportHints write FUseReportHints;
  end;

  TfrxCompressorClass = class of TfrxCustomCompressor;

{$IFDEF DELPHI16}
/// <summary>
///   The TfrxCustomCompressor class is the base class for compressors that
///   allows compression/decompression of the FR3 and FP3 files.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxCustomCompressor = class(TComponent)
  private
    FIsFR3File: Boolean;
    FOldCompressor: TfrxCompressorClass;
    FReport: TfrxReport;
    FStream: TStream;
    FTempFile: String;
    FFilter: TfrxSaveToCompressedFilter;
    procedure SetIsFR3File(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    ///   Method will decompress the data from a Source parameter and save
    ///   resulting data to a stream defined in the Stream property.
    /// </summary>
    function Decompress(Source: TStream): Boolean; virtual; abstract;
    /// <summary>
    ///   Method will compress the data from the Stream property and save
    ///   resulting data to a Dest stream.
    /// </summary>
    procedure Compress(Dest: TStream); virtual; abstract;
    procedure CreateStream;
    /// <summary>
    ///   Determines if there is compressed data is the FR3 file. FR3 file can
    ///   be compressed using maximum compression.
    /// </summary>
    property IsFR3File: Boolean read FIsFR3File write SetIsFR3File;
    /// <summary>
    ///   Reference to a report.
    /// </summary>
    property Report: TfrxReport read FReport write FReport;
    /// <summary>
    ///   Stream used by compressing/decompressing operations.
    /// </summary>
    property Stream: TStream read FStream write FStream;
  end;

  TfrxCrypterClass = class of TfrxCustomCrypter;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxCustomCrypter = class(TComponent)
  private
    FStream: TStream;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Decrypt(Source: TStream; const Key: AnsiString): Boolean; virtual; abstract;
    procedure Crypt(Dest: TStream; const Key: AnsiString); virtual; abstract;
    procedure CreateStream;
    property Stream: TStream read FStream write FStream;
  end;

  TfrxLoadEvent = function(Sender: TfrxReport; Stream: TStream): Boolean of object;
  TfrxGetScriptValueEvent = function(var Params: Variant): Variant of object;

  TfrxFR2Events = class(TObject)
  private
    FOnGetValue: TfrxGetValueEvent;
    FOnPrepareScript: TNotifyEvent;
    FOnLoad: TfrxLoadEvent;
    FOnGetScriptValue: TfrxGetScriptValueEvent;
    FFilter: String;
  public
    property OnGetValue: TfrxGetValueEvent read FOnGetValue write FOnGetValue;
    property OnPrepareScript: TNotifyEvent read FOnPrepareScript write FOnPrepareScript;
    property OnLoad: TfrxLoadEvent read FOnLoad write FOnLoad;
    property OnGetScriptValue: TfrxGetScriptValueEvent read FOnGetScriptValue write FOnGetScriptValue;
    property Filter: String read FFilter write FFilter;
  end;

  /// <summary>
  ///   This class represents global list of datasets. Every ancestor of
  ///   TfrxDataSet registers in this list during construction and removes when
  ///   destroy.
  /// </summary>
  TfrxGlobalDataSetList = class(TList)
{$IFNDEF NO_CRITICAL_SECTION}
    FCriticalSection: TCriticalSection;
{$ENDIF}
  public
    /// <summary>
    ///   Default constructor.
    /// </summary>
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Enters in critical section.
    /// </summary>
    procedure Lock;
    /// <summary>
    ///   Leaves critical section.
    /// </summary>
    procedure Unlock;
  end;

  { InPlace editors and custom draw for designer and preview }
  { remove unused properties }
  /// <summary>
  ///   The base class for InPlace editors. With InPlace editors programmers
  ///   may extend functionality of the report designer and the report preview.
  ///   This class handles mouse events, drag and drop, clipboard and custom
  ///   draw. It can be used to create custom in place editor for the report
  ///   designer, override copy/paste behaviour for selected object and draws
  ///   custom editors.
  /// </summary>
  TfrxInPlaceEditor = class(TObject)
  protected
    FComponent: TfrxComponent;
    FParentComponent: TComponent;
    FOwner: TWinControl;
    FOnFinishInPlace: TfrxOnFinishInPlaceEdit;
    FClassRef: TfrxComponentClass;
    FOffsetX: Extended;
    FOffsetY: Extended;
    FScale: Extended;
    FLocked: Boolean;
    FDevicePPI: Integer;
    { used to call other editors }
    FEditors: TfrxComponentEditorsList;
    FComponents: TfrxSelectedObjectsList;
    FClipboardObject: TPersistent;
    procedure SetComponent(const Value: TfrxComponent);
  public
    /// <summary>
    ///   Default constructor.
    /// </summary>
    /// <param name="aClassRef">
    ///   Class reference of report component used in the editor.
    /// </param>
    /// <param name="aOwner">
    ///   Widow control which owns editor(designer or preview).
    /// </param>
    constructor Create(aClassRef: TfrxComponentClass; aOwner: TWinControl); virtual;
    destructor Destroy; override;
    /// <summary>
    ///   Returns active work area of the editor.
    /// </summary>
    function GetActiveRect: TRect; virtual;
    /// <summary>
    ///   Not used.
    /// </summary>
    function HasInPlaceEditor: Boolean; virtual;
    /// <summary>
    ///   Not used.
    /// </summary>
    function HasCustomEditor: Boolean; virtual;
    /// <summary>
    ///   Draws object editor over object canvas.
    /// </summary>
    /// <param name="aCanvas">
    ///   Destination Canvas.
    /// </param>
    /// <param name="aRect">
    ///   Draw area.
    /// </param>
    procedure DrawCustomEditor(aCanvas: TCanvas; aRect: TRect); virtual;
    /// <summary>
    ///   Sets parameters used by the report preview or the report designer.
    /// </summary>
    /// <param name="aOffsetX">
    ///   X offset of work area.
    /// </param>
    /// <param name="aOffsetY">
    ///   Y offset of work area. <br />
    /// </param>
    /// <param name="aScale">
    ///   Scale of work area. <br />
    /// </param>
    procedure SetOffset(aOffsetX, aOffsetY, aScale: Extended);
    /// <summary>
    ///   Not used.
    /// </summary>
    function FillData: Boolean; virtual;
    procedure EditInPlace(aParent: TComponent; aRect: TRect); virtual;
    /// <summary>
    ///   This method should close in place editor and apply changes to edited
    ///   object.
    /// </summary>
    function EditInPlaceDone: Boolean; virtual;
    /// <summary>
    ///   Calls OnFinishInPlace event handler.
    /// </summary>
    procedure DoFinishInPlace(Sender: TObject; Refresh, Modified: Boolean); virtual;
    /// <summary>
    ///   The report engine calls it when DragOver operation is active over the
    ///   object with class that InPlace editor serves.
    /// </summary>
    /// <param name="Source">
    ///   Source object.
    /// </param>
    /// <param name="X">
    ///   Current mouse x coordinate.
    /// </param>
    /// <param name="Y">
    ///   Current mouse y coordinate. <br />
    /// </param>
    /// <param name="State">
    ///   State of drag and drop operation.
    /// </param>
    /// <param name="Accept">
    ///   Should return true when editor accepts drag and drop for current
    ///   object.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    function DoCustomDragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean; var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;
    /// <summary>
    ///   The report engine calls it when DragOver operation is active over the
    ///   object with class that InPlace editor serves.
    /// </summary>
    /// <param name="Source">
    ///   Source object.
    /// </param>
    /// <param name="X">
    ///   Current mouse x coordinate.
    /// </param>
    /// <param name="Y">
    ///   Current mouse y coordinate.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    function DoCustomDragDrop(Source: TObject; X, Y: Integer; var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;

    /// <summary>
    ///   The report engine calls it when DragOver operation is active over the
    ///   object with class that InPlace editor serves.
    /// </summary>
    /// <param name="X">
    ///   Current mouse x coordinate.
    /// </param>
    /// <param name="Y">
    ///   Current mouse y coordinate.
    /// </param>
    /// <param name="Shift">
    ///   Shift buttons states.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    function DoMouseMove(X, Y: Integer; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;
    /// <summary>
    ///   The report engine calls it when DragOver operation is active over the
    ///   object with class InPlace editor serves.
    /// </summary>
    /// <param name="X">
    ///   Current mouse x coordinate.
    /// </param>
    /// <param name="Y">
    ///   Current mouse y coordinate.
    /// </param>
    /// <param name="Button">
    ///   Mouse button.
    /// </param>
    /// <param name="Shift">
    ///   Shift buttons states.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    function DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;
    /// <summary>
    ///   The report engine calls it when DragOver operation is active over the
    ///   object with class that InPlace editor serves.
    /// </summary>
    /// <param name="X">
    ///   Current mouse x coordinate.
    /// </param>
    /// <param name="Y">
    ///   Current mouse y coordinate.
    /// </param>
    /// <param name="Button">
    ///   Mouse button.
    /// </param>
    /// <param name="Shift">
    ///   Shift buttons states.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;
    /// <summary>
    ///   The report engine calls it when DragOver operation is active over the
    ///   object with class that InPlace editor serves.
    /// </summary>
    /// <param name="Shift">
    ///   Shift buttons states.
    /// </param>
    /// <param name="WheelDelta">
    ///   Mouse wheel delta.
    /// </param>
    /// <param name="MousePos">
    ///   Cursor position when event were fired.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    function DoMouseWheel(Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var EventParams: TfrxInteractiveEventsParams): Boolean; virtual;

    /// <summary>
    ///   Initialize UI of in place editor when mouse cursor enters area which
    ///   inPlace editor serves.
    /// </summary>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    procedure InitializeUI(var EventParams: TfrxInteractiveEventsParams); virtual;
    /// <summary>
    ///   Finalize UI of in place editor when mouse cursor leaves area which
    ///   inPlace editor serves.
    /// </summary>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    procedure FinalizeUI(var EventParams: TfrxInteractiveEventsParams); virtual;

    /// <summary>
    ///   This method serves copy behaviour for the group of objects. The
    ///   object selection passed in EventParams.SelectionList parameter.
    /// </summary>
    /// <param name="CopyFrom">
    ///   Reference to an object used to copy from.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    /// <param name="Buffer">
    ///   Temporary buffer for copy.
    /// </param>
    /// <param name="CopyAs">
    ///   This flag determines kind of object data.
    /// </param>
    procedure CopyGoupContent(CopyFrom: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; CopyAs: TfrxCopyPasteType = cptDefault); virtual;
    /// <param name="PasteTo">
    ///   Reference to an object used to paste data.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    /// <param name="Buffer">
    ///   Temporary buffer for copy.
    /// </param>
    /// <param name="PasteAs">
    ///   This flag determines kind of object data.
    /// </param>
    procedure PasteGoupContent(PasteTo: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; PasteAs: TfrxCopyPasteType = cptDefault); virtual;

    /// <param name="CopyFrom">
    ///   Reference to an object used to copy from.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    /// <param name="Buffer">
    ///   Temporary buffer for copy.
    /// </param>
    /// <param name="CopyAs">
    ///   This flag determines kind of object data.
    /// </param>
    procedure CopyContent(CopyFrom: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; CopyAs: TfrxCopyPasteType = cptDefault); virtual;
    /// <param name="PasteTo">
    ///   Reference to an object used to paste data.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    /// <param name="Buffer">
    ///   Temporary buffer for copy.
    /// </param>
    /// <param name="PasteAs">
    ///   This flag determines kind of object data.
    /// </param>
    procedure PasteContent(PasteTo: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; PasteAs: TfrxCopyPasteType = cptDefault); virtual;
    /// <param name="PasteTo">
    ///   Reference to an object used to paste data.
    /// </param>
    /// <param name="EventParams">
    ///   Structure with parameters of interactive events.
    /// </param>
    /// <param name="PasteAs">
    ///   This flag determines kind of object data.
    /// </param>
    function IsPasteAvailable(PasteTo: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; PasteAs: TfrxCopyPasteType = cptDefault): Boolean; virtual;
    /// <summary>
    ///   Returns default content type supported by InPlcae editor.
    /// </summary>
    function DefaultContentType: TfrxCopyPasteType; virtual;

    /// <summary>
    ///   Reference to edited component.
    /// </summary>
    property Component: TfrxComponent read FComponent write SetComponent;
    /// <summary>
    ///   Reference to a parent component.
    /// </summary>
    property ParentComponent: TComponent read FParentComponent write FParentComponent;
    /// <summary>
    ///   An event used in InPlace editors. Event fires when the report
    ///   designer or the report preview close InPlace editor.
    /// </summary>
    property OnFinishInPlace: TfrxOnFinishInPlaceEdit read FOnFinishInPlace write FOnFinishInPlace;
    /// <summary>
    ///   Editor is locked.
    /// </summary>
    property Locked: Boolean read FLocked;
    /// <summary>
    ///   Child editors for current editor class.
    /// </summary>
    property Editors: TfrxComponentEditorsList read FEditors write FEditors;
    /// <summary>
    ///   Reference to a clipboard object.
    /// </summary>
    property ClipboardObject: TPersistent read FClipboardObject write FClipboardObject;
  end;

  /// <summary>
  ///   Visibility of InPlace editors.
  /// </summary>
  TfrxComponentEditorVisibilityState = (
    /// <summary>
    ///   Visible only in the report preview.
    /// </summary>
    evPreview,
    /// <summary>
    ///   Visible only in the report designer.
    /// </summary>
    evDesigner);
  TfrxComponentEditorVisibility = set of TfrxComponentEditorVisibilityState;

  TfrxInPlaceEditorClass = class of TfrxInPlaceEditor;

  TfrxCustomIOTransportClass = class of TfrxCustomIOTransport;

  /// <summary>
  ///   This class represents registration item of InPlace editor in editors
  ///   list.
  /// </summary>
  TfrxComponentEditorsRegItem = class(TObject)
  private
    FEditorsClasses: TList;
    FEditorsVisibility: TList;
    FComponentClass: TfrxComponentClass;
    function GetEditorClass(Index: Integer): TfrxInPlaceEditorClass;
    procedure SetEditorClass(Index: Integer;
      const Value: TfrxInPlaceEditorClass);
    function GetComponentClassName: String;
    function GetEditorVisibility(Index: Integer): TfrxComponentEditorVisibility;
    procedure SetEditorVisibility(Index: Integer;
      const Value: TfrxComponentEditorVisibility);
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    procedure RemoveEditor(AClass: TfrxInPlaceEditorClass);
    property EditorClass[Index: Integer]: TfrxInPlaceEditorClass read GetEditorClass write SetEditorClass;
    property EditorVisibility[Index: Integer]: TfrxComponentEditorVisibility read GetEditorVisibility write SetEditorVisibility;
    property ComponentClassName: String read GetComponentClassName;
  end;

  TfrxRectArray = array of TRect;
  PfrxRectArray = ^TfrxRectArray;

  /// <summary>
  ///   This class controls group of InPlace editors registered for specified
  ///   object type. Methods description are the same as for TfrxInPlaceEditor
  ///   class.
  /// </summary>
  TfrxComponentEditorsManager = class(TObject)
  private
    FOffsetX: Extended;
    FOffsetY: Extended;
    FScale: Extended;
    FEditorsGlasses: TList;
    FComponentClass: TfrxComponentClass;
    function GetComponent: TfrxComponent;
    procedure SetComponent(const Value: TfrxComponent);
  public
    function EditorsActiveRects(aComponent: TfrxComponent): TfrxRectArray;
    procedure DrawCustomEditor(aCanvas: TCanvas; aRect: TRect);
    function DoCustomDragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean; var EventParams: TfrxInteractiveEventsParams): Boolean;
    function DoCustomDragDrop(Source: TObject; X, Y: Integer; var EventParams: TfrxInteractiveEventsParams): Boolean;
    procedure SetOffset(aOffsetX, aOffsetY, aScale: Extended);
    function DoMouseMove(X, Y: Integer; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
    function DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
    function DoMouseWheel(Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var EventParams: TfrxInteractiveEventsParams): Boolean;

    procedure InitializeUI(var EventParams: TfrxInteractiveEventsParams);
    procedure FinalizeUI(var EventParams: TfrxInteractiveEventsParams);

    procedure CopyContent(CopyFrom: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; CopyAs: TfrxCopyPasteType = cptDefault);
    procedure PasteContent(PasteTo: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; PasteAs: TfrxCopyPasteType = cptDefault);
    function IsPasteAvailable(PasteTo: TfrxComponent; var EventParams: TfrxInteractiveEventsParams; PasteAs: TfrxCopyPasteType = cptDefault): Boolean;
    function IsContain(ObjectRect: TRect; X, Y: Extended): Boolean;
    procedure SetClipboardObject(const aObject: TPersistent);
    constructor Create;
    destructor Destroy; override;
    property Component: TfrxComponent read GetComponent write SetComponent;
  end;

  /// <summary>
  ///   This class used to store component InPlace editors for current instance
  ///   of TfrxComponent.
  /// </summary>
  TfrxComponentEditorsList = class(TStringList)
  private
    FEditorsInstances: TList;
    function GetEditors(Index: Integer): TfrxComponentEditorsManager;
    procedure PutEditors(Index: Integer;
      const Value: TfrxComponentEditorsManager);
  public
    constructor Create; overload;
    destructor Destroy; override;
    procedure CreateInstanceFromItem(aItem: TfrxComponentEditorsRegItem; aOwner: TWinControl; aVisibility: TfrxComponentEditorVisibilityState);
    property Editors[Index: Integer]: TfrxComponentEditorsManager read GetEditors write PutEditors;
  end;

  /// <summary>
  ///   This class represents collection of registered component InPlace
  ///   editors for each type of components.
  /// </summary>
  TfrxComponentEditorsClasses = class(TObject)
  private
    FList: TStringList;
    function GetEditors(Index: Integer): TfrxComponentEditorsRegItem;
    procedure PutEditors(Index: Integer;
      const Value: TfrxComponentEditorsRegItem);
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///   Creates new instances of InPlace editors specified in the collection.
    /// </summary>
    /// <param name="aVisibility">
    ///   Visibility of an InPlcae editor.
    /// </param>
    /// <param name="aOwner">
    ///   Owner of editors controls.
    /// </param>
    function CreateEditorsInstances(aVisibility: TfrxComponentEditorVisibilityState; aOwner: TWinControl): TfrxComponentEditorsList;
    /// <summary>
    ///   Count of items.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Returns item index by it's name.
    /// </summary>
    /// <param name="s">
    ///   Item name.
    /// </param>
    function IndexOf(const s: String): Integer;
    /// <summary>
    ///   Registers new inPlcae editor class for specified component class.
    /// </summary>
    /// <param name="ComponentClass">
    ///   Class of a component.
    /// </param>
    /// <param name="ComponentEditors">
    ///   An open array of InPlace editor classes.
    /// </param>
    /// <param name="EditorsVisibility">
    ///   An open array of visibility for each InPlace editor specified in
    ///   ComponentEditors <br />parameter.
    /// </param>
    procedure Register(ComponentClass: TfrxComponentClass; ComponentEditors: array of TfrxInPlaceEditorClass; EditorsVisibility: array of TfrxComponentEditorVisibility);
    /// <summary>
    ///   Removes all registered editors for specified component class.
    /// </summary>
    /// <param name="ComponentClass">
    ///   Class of a component.
    /// </param>
    procedure UnRegister(ComponentClass: TfrxComponentClass); overload;
    procedure UnRegister(ComponentClass: TfrxComponentClass; EditroClass: TfrxInPlaceEditorClass); overload;
    /// <summary>
    ///   Removes all registered editors for specified editor class.
    /// </summary>
    /// <param name="EditroClass">
    ///   lass of an editor.
    /// </param>
    procedure UnRegisterEditor(EditroClass: TfrxInPlaceEditorClass);
    /// <summary>
    ///   Saves settings of editors visibility to Ini file.
    /// </summary>
    /// <param name="IniFile">
    ///   Reference to ini file. <br />
    /// </param>
    procedure SaveToIni(IniFile: TCustomIniFile);
    /// <summary>
    ///   Loads settings of editors visibility from Ini file.
    /// </summary>
    /// <param name="IniFile">
    ///   Reference to ini file.
    /// </param>
    procedure LoadFromIni(IniFile: TCustomIniFile);
    /// <summary>
    ///   List of registered items.
    /// </summary>
    property EditorsClasses[Index: Integer]: TfrxComponentEditorsRegItem read GetEditors write PutEditors;
  end;

  TfrxExtPropList = class(TObject)
    FPropInfos: TStringList;
  private
    function GetGetMethod(Index: Integer): Pointer;
    function GetName(Index: Integer): String;
    function GetSetMethod(Index: Integer): Pointer;
    function GetTypInfo(Index: Integer): Pointer;
    procedure SetGetMethod(Index: Integer; const Value: Pointer);
    procedure SetName(Index: Integer; const Value: String);
    procedure SetSetMethod(Index: Integer; const Value: Pointer);
    procedure SetTypInfo(Index: Integer; const Value: Pointer);
    procedure ClearPropInfo;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddProperty(aName: ShortString; pTypInf, StaticGetMethod, StaticSetMethod: Pointer);
    function Count: Integer;
    property TypInfo[Index: Integer]: Pointer read GetTypInfo write SetTypInfo;
    property Name[Index: Integer]: String read GetName write SetName;
    property GetMethod[Index: Integer]: Pointer read GetGetMethod write SetGetMethod;
    property SetMethod[Index: Integer]: Pointer read GetSetMethod write SetSetMethod;
  end;

  TfrxStringClassName = type String;

  IInspectedProperties = interface
  ['{BDBE0326-DA24-4FB8-ADA0-2F740AB6C199}']
    function GetProperies: TfrxExtPropList;
  end;

  IStringClassNameContainer = interface
  ['{97FFA69C-C491-458E-98A7-EFDCFFE05465}']
    function GetSupportedClasses: TList;
  end;

  TfrxCustomObjectPreset = class(TPersistent)
  public
    constructor Create; virtual;
    function GetData(aReport: TfrxReport): String; virtual; abstract;
    procedure ApplySettings(aComponent: TfrxComponent); virtual; abstract;
    procedure SaveComponentState(aComponent: TfrxComponent); virtual; abstract;
    procedure RestoreComponentState(aComponent: TfrxComponent); virtual; abstract;
    procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect); virtual;
    procedure EndDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect); virtual;
  end;
  TfrxCustomObjectPresetClass = class of TfrxCustomObjectPreset;

/// <summary>
///   Function returns a global form that may be useful for some add-in
///   controls.
/// </summary>
function frxParentForm: TForm;
/// <summary>
///   This function searches for a DataSet on specified owner.
/// </summary>
function frxFindDataSet(DataSet: TfrxDataSet; const Name: String;
  Owner: TComponent): TfrxDataSet;
procedure frxGetDataSetList(List: TStrings);
function frxCreateFill(const Value: TfrxFillType): TfrxCustomFill;
function frxGetFillType(const Value: TfrxCustomFill): TfrxFillType;
function frxRegEditorsClasses: TfrxComponentEditorsClasses;
procedure frxUnregisterEditorsClass(ComponentClass: TfrxComponentClass; EditroClass: TfrxInPlaceEditorClass);
function frxGetInPlaceEditor(aList: TfrxComponentEditorsList; aComponent: TfrxComponent): TfrxComponentEditorsManager;
procedure rePadding(MForm: TComponent);

var
  frxDefaultIOTransportClass: TfrxCustomIOTransportClass = nil;
  frxDefaultIODialogTransportClass: TfrxCustomIOTransportClass = nil;
  frxDefaultTempFilterClass: TfrxCustomIOTransportClass = nil;
  frxDesignerClass: TfrxDesignerClass;
  frxDotMatrixExport: TfrxCustomExportFilter;
  frxCompressorClass: TfrxCompressorClass;
  frxCrypterClass: TfrxCrypterClass;
  frxCharset: Integer = DEFAULT_CHARSET;
  frxFR2Events: TfrxFR2Events;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS: TCriticalSection;
{$ENDIF}
  /// <summary>
  ///   The global variables list available to all reports.
  /// </summary>
  frxGlobalVariables: TfrxVariables;

const  
  BND_COUNT = 18;
  frxBands: array[0..BND_COUNT - 1] of TfrxComponentClass =
    (TfrxReportTitle, TfrxReportSummary, TfrxPageHeader, TfrxPageFooter,
     TfrxHeader, TfrxFooter, TfrxMasterData, TfrxDetailData, TfrxSubdetailData,
     TfrxDataBand4, TfrxDataBand5, TfrxDataBand6, TfrxGroupHeader, TfrxGroupFooter,
     TfrxChild, TfrxColumnHeader, TfrxColumnFooter, TfrxOverlay);

{$IFDEF FPC}
//  procedure Register;
{$ENDIF}

implementation

{$R *.res}

uses
  {$IFDEF Linux}
  InterfaceBase,
  {$ENDIF}
  {$IFNDEF FPC}Registry,{$ENDIF}
  frxEngine, frxPreviewPages, frxPreview, frxPrinter, frxUtils, frxFileUtils,
  frxPassw, frxGraphicUtils, frxDialogForm, frxXMLSerializer,
  {$IFNDEF FPC}frxAggregate, {$ENDIF} frThreading,
  frxRes, frxDsgnIntf, frxIOTransportIntf, frxClassRTTI, frxInheritError, TypInfo,
  {$IFNDEF FS_SKIP_LANG_REG}fs_ipascal, fs_icpp, fs_ibasic, fs_ijs,{$ENDIF} fs_iclassesrtti,
  fs_igraphicsrtti, fs_iformsrtti, fs_idialogsrtti, fs_iinirtti, frxDMPClass,
  SysConst, StrUtils, frxNetUtils, frUtils, frHashUtils{ TODO: remove};

var
  FParentForm: TForm;
  DatasetList: TfrxGlobalDataSetList;
  RegEditorsClasses: TfrxComponentEditorsClasses;

const
  DefFontName = {$IFNDEF LCLGTK2}'Arial'{$ELSE}'FreeSans'{$ENDIF};
  DefFontNameBand = 'Tahoma';
  DefFontSize = 10;

type
  TByteSet = set of 0..7;
  PByteSet = ^TByteSet;

  THackControl = class(TControl);
  THackWinControl = class(TWinControl);
  THackPersistent = class(TPersistent);
  THackThread = class(TThread);

  TParentForm = class(TForm)
  private
    procedure DoCreateWnd;
    procedure DoDestroyWnd;
    procedure DoCreateHandle;
{$IFNDEF FPC}
    procedure DoDestroyWindowHandle;
{$ENDIF}
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure CreateHandle; override;
{$IFNDEF FPC}
    procedure DestroyWindowHandle; override;
{$ENDIF}
    procedure WndProc(var Message: TMessage); override;
  end;

type
  TCreateWideStrings = record
    WS: TWideStrings;
  end;

function CreateWideStrings(s: WideString): TCreateWideStrings;
begin
  Result.WS := {$IFDEF Delphi10} TfrWideStrings.Create;
               {$ELSE}           TWideStrings.Create;
               {$ENDIF}
  Result.WS.Text := s;
end;

{ TfrxStringList }
{$IFDEF NONWINFPC}
function TfrxStringList.DoCompareText(const s1, s2: string): PtrInt;
begin
  if s1 > s2 then
  Result := 1
else if s1 < s2 then
  Result := -1
else
  Result := 0;
end;
{$ENDIF}

procedure TParentForm.CreateHandle;
begin
  frThreadSynchronize(DoCreateHandle);
end;

procedure TParentForm.CreateWnd;
begin
  frThreadSynchronize(DoCreateWnd);
end;

{$IFNDEF FPC}
procedure TParentForm.DestroyWindowHandle;
begin
  frThreadSynchronize(DoDestroyWindowHandle);
end;
{$ENDIF}

procedure TParentForm.DestroyWnd;
begin
  frThreadSynchronize(DoDestroyWnd);
end;

procedure TParentForm.DoCreateHandle;
begin
  inherited CreateHandle;
end;

procedure TParentForm.DoCreateWnd;
begin
  inherited CreateWnd;
end;

{$IFNDEF FPC}
procedure TParentForm.DoDestroyWindowHandle;
begin
  inherited DestroyWindowHandle;
end;
{$ENDIF}

procedure TParentForm.DoDestroyWnd;
begin
  inherited DestroyWnd;
end;

procedure TParentForm.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_CREATEHANDLE:
      TWinControl(Message.WParam).HandleNeeded;
    WM_DESTROYHANDLE:
      THackWinControl(Message.WParam).DestroyHandle;
  else
    inherited;
  end;
end;

{ TODO: remove. Move it to resources it's not a place for graphic resources  }
function GetFRGraphic: TGraphic;
const
  FR: AnsiString = ''
  + 'iVBORw0KGgoAAAANSUhEUgAAAfQAAAH0CAYAAADL1t+KAAAACXBIWXMAAAsTAAALEwEAmpwYAAAa+klEQVR4nO3dvWtcWb7v4e8Mg3BkHBlTgkZU0BgKjCtpHDWODh0ZR5eOho4OE86fcrnRhM1E5kamI3Mi05HppIShQDgohEGFUWQUGSU+QW2N31Qltepl7b3280DhwdOWfzDT+mjtvfbaf/n48WMAgG77a+kBAID1CToAVEDQAaACgg4AFRB'
  + '0AKiAoANABQQdACog6ABQAUEHgAoIOgBUQNABoAKCDgAVEHQAqICgA0AFBB0AKiDoAFABQQeACgg6AFRA0AGgAoIOABUQdACogKADQAUEHQAqIOgAUAFBB4AKCDoAVEDQAaACgg4AFfhb6QG6ZLA/OCg9A7BVH+Yn83elh4Cb+MvHjx9Lz9A6TbjvNZ87Sb4rOhCwa2dJ3jWf4/nJ/LjsOHA1QU8y2B/cSnK/+Rwk2Ss6ENA250mOkhyKO23V66'
  + 'AP9gf3kjxK8qD0LEBnvE3yUthpm14GfbA/uJPkaVxKB27uTZLn85P5h9KDQNKzoDeX1h8n+aHwKEAdTpM8m5/M35ceBHoT9Oby+tMkd0vPAlTlPMn/tVKntF48h97sWv8lYg5s3l4W31+gqOqDPtgfPEzy99i5DmzP3cH+4HHpIei3qoPeXGZ/UnoOoBceNRtuoYhqg95sgPul9BxAb+xl8RgsFFFt0JP8HJfZgd16WHoA+qvKoDf3zT1jDuza3'
  + 'mB/cL/0EPRTdUH/7FlzgBIEnSKqC3oWl7xulx4C6K2D0gPQTzUG3aYUoKTbzZVC2Kmqgt7cu7I6B0q7V3oA+qeqoMe9K6AdBJ2dE3SAzXPJnZ2rJujNqXCeOwfawIlx7Fw1QY+dpUB7CDo7V1PQ3bMCoLdqCrqfiAHorZqCboUOQG/VFHQb4gDorZqCDgC9VUXQB/uDg9IzAEBJVQQdAPpO0AGgAoIOABUQdACogKADQAUEHQAqIOgAUAFBB4AK'
  + 'CDoAVEDQAaACgg4AFRB0AKiAoANs3ofSA9A/gg6wee9KD0D/CDoAVEDQATbPCp2dE3SAzXMPnZ0TdIDNs0Jn5wQdYLPO5ydzK3R2TtABNsvqnCIEHWCzjksPQD8JOsBmHZUegH4SdIDNOZufzF1ypwhBB9gcq3OKEXSAzXlVegD6S9ABNuP1/GT+vvQQ9JegA6zvPMmL0kPQb4IOsL5nDpOhNEEHWM9v85P5cekh4G+lBwDoqPMsVubHpQeBRNA'
  + 'BbuKPJC9dZqdNBB3gek6THCY5FHLaSNABvnWW5H0WL1p5l+TYI2m0naDTB2f57Btz2VFouXdW33SVoFOri8ujx87WBvpA0KnN6yzucR6XHgRglwSdWpwmeSHkQF8JOjX4fX4yf1l6CICSBJ2u+21+Mj8sPQRAaY5+pcvEHKAh6HTV72IO8Img00Wn7pkDfEnQ6SLvnQb4iqDTNW89mgbwLUGna16VHgCgjQSdLjmbn8yPSg8B0EaCTpeIOcASgk'
  + '6XHJceAKCtnBRHl2z8rWnT8fBOkjtJbiW51/z2++YDu/BhNJl5IyBrE3S64nx+Mt9IZJuIP05yP8neJr4mrGM6Hl78x7Msfpj8kMUPsBe/vh9NZn7IZCVBpys2soKZjoePk/y4ia8FW3C7+STJ95//F0303+bTFaTjJO9Gk9mHHc5Hiwk6vTEdD58meVB6DljDd80naX4wnY6HZ2ninuTY5fv+EnS64nidPzwdD+9HzKnT7Sz+v/0gSabj4XkW/'
  + '74cZRF4l+p7QtDpi59KDwA7spfF5frvk/+s4I+SHI0ms+OCc7Flgk71mtX57Sv/QajT7SQ/JPmhWb1fxN25DpURdPrgoPQA0BJ7aS7PN3E/THLovnsdBJ0+OCg9ALTQXj6t3E+zeE/CkV3z3SXo9MHd0gNAy91N8iTJT9Px8CjJS5vpukfQAbjw+SX5t1mE/bjsSFyXoANwme+S/P3icvxoMjssPRCreTkLAKvcTfJkOh7+czoePiw9DMsJOgDX'
  + 'cTuLsP9jOh4elB6Gbwk6AH/G3Swuxf8yHQ/vXflPszOCDsBNfJfkv6fj4dPpeHir9DAIOgDreZDkn9Px8FHpQfpO0AFY116S/3IZvixBB2BTLi7DPy48Ry8JOgCb9mOzG95qfYcEHYBtuJvkF/fWd0fQAdiWi3vrP9sJv32CDsC2fZ/EJfgtE3QAduF2FhvmHB+7JYIOwC49mY6HT0sPUSNBB2DXHjS74N1X3yBBB6CEi13w7qtviKADUIqob5C'
  + 'gA1DSXhZRPyg9SNcJOgCl7WXxSlY74Ncg6AC0xRNRvzlBB6BNRP2GBB2AthH1GxB0ANpI1P8kQQegrZ54pO36BB2ANvOc+jUJOgBtdvGc+p3Sg7SdoAPQdntJvFP9CoIOQBfcTeItbSsIOgBd8f10PPyp9BBtJegAdMkPHme7nKAD0DU/2fn+LUEHoGv2kjy1Se5Lgk5XvC89ANAqd5O4n/4ZQacrBB342oPpeHi/9BBtIegAdNlTh84sCDoAXb'
  + 'YXz6cnEXT64az0AMBWfTcdDx+VHqI0QacP3H+H+j3u+6V3QacPjksPAGzdXnq+613Q6YOj0gMAO/F9n3e9CzrVG01m75K8LT0HsBM/9fXAGUGnL54lOS09BLB1t5P0coOcoNMVB+v84dFk9mE0mf0ryW9J3sTOd6jZj33cIPe30gPANW3kEtpoMjtMcriJr9V2zWXHrr3A4k7zudd8bpcdhw57nOR56SF2SdDpiq6FqbjRZPYhHd/h36yyDprP/'
  + 'Sx2MsN1PJiOh4ejyey49CC7Iuh0haD30Ggye5/FFZXDJGl2MD9M8n3JueiMx0l+LTzDzriHTlfsDfYHvbsnxpdGk9nRaDJ7luT/JXldeh5a77vpeHhQeohdEXS65KD0ALTDaDJ7P5rMnif5d2xwZLXHpQfYFUGnS3p7YASXa+6P/itW6yzXm1W6oNMlB4P9QS8PjGC55pHE5xF1lntceoBdEHS6ZC9W6Swh6qzQi1W6oNM1j0sPQHs1UX9Teg5a'
  + 'qfrT4wSdrrk92B88LD0ErfY8yXnpIWid72s/PU7Q6aKfPMLGMs2BOi9Kz0ErPS49wDYJOl20l+RnG+RYpjni1+NsfO1+zW9iE3S66m6Sfwz2BwelB6G1XpYegNbZy+KkwSoJOl12O8nfB/uDp4P9gaNh+UKzSncvna9VuznOWe7U4EGSB4P9wWkWLyM5TvJ+fjJ/V3IoWuEwyQ+lh6BVbk/Hw3ujyay67w+CTk3uNp8fkmSwP7j4/belBuJSH5J'
  + 'cfDM9zuKHr/db+ruOIuh861EqfLWqoNMH35UegG9cvC3txyQZ7A/Os4j7UZKj+cn8wyb+ktFkdjwdDzfxpahLlQdUuYcOtMFeFpF/kuSfzb6ITe1GdoWGr+01r+KtiqADbbOXxb6Ifw72B5v4pnu8ga9Bfarb7S7oQFvtJfk/GzgZcFv35+m272t7Jl3QgbZ7suZjiYLOMlVddhd0oAuervFnq3s8iY05KD3AJgk60AV3b3o/vTnbHS5jhQ5QwD'
  + 'rffJ0Yx2X2anpPuqADXbFO0F12Z5lqVumCDnTFntfmsgUHpQfYFEEHukTQ2bS7tTy+JuhAlwg623BQeoBNEHSgSwSdbTgoPcAmCDoAfXdQeoBNEHQA+q6K++iCDgDJOscLt4KgA0AFl90FHQCs0AGgCoIOABW4XXqAdQk6ACTp+otaBB0AFjp9cJGgA8CCoANABQ5KD7AOQQeACgg6ACx8V3qAdQg6AFRA0AGgMR0PO3vAjKADwCedfeuaoAPAJ'
  + '4IOABVwyR0AKEfQAaACgg4An3T2+FdBB4BPBB0AKEfQAaACgg4AFRB0AKiAoANABQQdACog6ABQAUEHgAoIOgBUQNABoAKCDgCfHJce4KYEHQAqIOgAUAFBB4BPPpQe4KYEHQA+eVd6gJsSdACogKADwCdW6ADQdaPJzD10AOi4s9IDrEPQAWDhfekB1iHoALDQ2fvniaADwIXO3j9PBB0ALhyXHmAdgg4AC+6hA0DHnY8mM0EHgI7r9Ia4RNAB'
  + 'IBF0AKjCcekB1iXoAGCFDgCdd9b1DXGJoANA51fniaAD3VLFN15a57j0AJsg6ECXdPpoTlrrqPQAmyDoAPRZFffPE0EHuqWKb7y0ynHpATZF0IHOmJ/MBZ1Nq+JyeyLoQHe8LT0A9RlNZoIOsGPr7HC/s7EpqMmb0gNskqADXXG4xp+9vbEpqEk1q/NE0IFuOJufzG+0Qp+Oh1bnLCPoADv2Yo0/K+hc5s1oMqvqXANBB9ruzfxkvs5K6t7GJqE'
  + 'mVa3OE0EH2u00yfM1v4YVOl87H01m6+zJaKW/lR4AYIk3SZ7PT+brXha1Qudr1a3OE0EH2ucsycv5yXxTK6jvNvR1qMer0gNsg6ADbXCaxRGcR/OT+fGmvuh0PLQ652uno8msyrf2CTp9cxpv7Crh+JLfe5fkwyYDfomDLX5tuqnK1Xki6NTrPIuIHGcRjncbuBdL99wvPQCtcp5K758ngk593iQ5XPMxJyowHQ9vxf1zvvSqtmfPPyfo1OJ1Fh'
  + 'upvI2LC1bnfK26R9U+J+h03XmSZ1u+D0s3PS49AK3yejSZVf0Dv6DTZadJfnVvnK9Nx8ODeCELX3pZeoBtc1IcXSXmrPJT6QFolepX54mg003nEXOWmI6Hj5PcLTwG7fKy9AC7IOh00TMx5zLNQTI/lp6DVunF6jwRdLrntQ1wXKaJ+S+l56B1XpYeYFdsiqNrXpYegPZpNsH9nGSv8Ci0y+99WZ0ngk63vPGcOZ9rDo95nOSHwqPQPuep+JjXy'
  + 'wg6XVL1oRBcXxPyR83HqpzLvKj5VLjLCDpdclx6AMppIn6QxQlw9yPkLHc6msx6twAQdLri7aZ3tk/HwztJ7mzwS77v0/26bWruiSeLgN9Jci8eReP6npceoARBpys28v7iJhSPsgjFxld40/Fw01+yrd5u+OvdiZPd2Iw/an3f+VUEna5Ye+U7HQ9/is1Tm+ItZrTRWXr8JIzn0OmKtX7ibk4PE3Oo2/O+bYT7nKBTveZeudPDoG5/jCaz49JD'
  + 'lCTodMU6P3V7LzbUrdeX2i8IOp0wP5mvc8ld0KFuz/p8qf2CoNMJg/3BrTX+uA1cUK/f+7qr/WuCTlfcKz0A0DpvR5PZy9JDtIWgA9BFZ0melR6iTQQdgC5y3/wrgg5A1/zmvvm3BB2ALvmjjy9euQ5BB6ArXo8msxelh2grQQegC06TiPkKgg5A250m+dUmuNUEHYA2O48d7dci6AC01XkWK/O1X5/cB4IOQBtdxNzjadck6AC0jZjfgKAD0CZ'
  + 'ifkN/Kz0AADTOstgAJ+Y3IOgAtIFH09bkkjsApYn5BlihA1DS69Fk9rz0EDUQdABK+X00mb0sPUQtBB2AXTtP8nw0mR2VHqQmgg7ALp1mEXM72TdM0AHYlddJXtj8th2CDsC2nWcR8sPSg9RM0AHYJpfYd0TQAdgWu9h3SNAB2DSr8gIEHYBNsiovRNAB2IS3WazK35cepK8EHYB1nGWxg90hMYUJOgA3cZ7kVZJXnitvB0EH4M96neSly+vtIu'
  + 'gAXJeQt5igA3AVIe8AQQdgGSHvEEEH4HPnSQ6z2Owm5B0i6AAki8fPXiY5smu9mwQdoN9eJzkcTWbHpQdhPYIO0D+nWVxWP7Qar4egA/TDWZKjuDdeLUEHqNdpkuMsVuLefFY5QQeoy9ssVuJHVuL9Iuj0wVmS26WHgC16nUXEj90T7y9Bpw/eRdCp12+jyeyw9BCU99fSA8AOeK0jtXoj5lwQdKrXfMM7Lz0HbMGr0gPQHoJOXzwvPQDANgk6v'
  + 'TCazI6S/FZ6Dtiw+6UHoD0End5oLr3/O4vHeqAGD6fj4a3SQ9AOdrnTK8151b9Ox8N7SQ6az60k95LsFRsMbmYvyeMkLwrPQQsIOr3UnJr1Lh3YVDQdD+9kcWn1YZK7hcehfX6Yjofv7HZH0KHlmtO+XiV5NR0PD7JYkX1XciZa58l0PIyo95t76NAho8nseDSZ/Zrk/8ejeHzpyXQ8fFh6CMoRdOigZtf+v7J4+QZcEPUeE3ToqOZS/K8Rdb4k'
  + '6j0l6NBhzYs4fs3i5Rxw4cl0PHxUegh2S9Ch40aT2YfRZPY8os6X/ms6Hj4tPQS7I+hQCVHnEg9EvT8EHSoi6lxC1HtC0KEyos4lRL0HBB0qJOpcQtQrJ+hQKVHnEqJeMUGHiok6lxD1Sgk6VE7UucSD6Xj4s1ev1kXQoQdEnUt8n+QXUa+HoEN/vIhjYvnS3Yh6NQQdeuKzY2JFnc+JeiUEHXpE1FlC1Csg6NAzos4Sot5xgg49JOosIeodJuj'
  + 'QU6LOEqLeUYIOPSbqLHE3yT+m4+G90oNwfYIOPSfqLHE7i5W6qHeEoAOizjJ7EfXOEHQgiaizlKh3hKAD/yHqLCHqHSDowBdEnSVEveUEHfiGqLOEqLeYoAOXEnWWEPWWEnRgKVFnib0k/z0dDx+WHoRPBB1YSdRZ4Ymot4egA1cSdVYQ9ZYQdOBamqg/T3JeehZaR9RbQNCBaxtNZu+yWKmLOl8T9cIEHfhTRJ0VRL0gQQf+NFFnBVEvRNCBGx'
  + 'F1VhD1AgQduDFRZ4Un0/Hwaekh+kTQgbWIOis8EPXdEXRgbaLOCqK+I4IObISos4Ko74CgAxsj6qwg6lsm6MBGiToriPoWCTqwcaLOCqK+JYIObIWos8KD6Xj4dDoe3io9SE0EHdgaUWeFB0l+EfXNEXRgq0SdFe5G1DdG0IGtE3VWEPUNEXRgJz6LOnxN1DdA0IGdaaL+W+k5aCVRX5OgAzs1mswOI+pcTtTXIOjAzok6K4j6DQk6UISos8JF1'
  + 'O+VHqRLBB0oRtRZQdT/pFqC/qH0AMDNiDor7EXUr62KoM9P5u9KzwDcnKizgqhfUxVBB7pP1FlB1K+hpqA7gQo6TtRZQdSvUFPQXXaHCog6K4j6CjUFHaiEqLOCqC9RU9CPSw/AVrkC0zOizgoXUX9YepA2qSnoVGx+MvdoYg+JOivsJXki6p/UFPTj0gMAmyfqXEHUGzUF/X3pAdgaTzD0nKhzBVFPRUGfn8zfxzf+Wrl/jqhzld5HvZqgN3zj'
  + 'h4o1Uf+f0nPQWr2Oem1BPy49AFtxXHoA2mM0mb1K8rr0HLRWb6Mu6HSB/RF8YTSZPY+os1wvo15V0Ocn8+O4j14jt1L4hqhzhSfT8fBp6SF2qaqgN45LD8BmeZsey4g6V3jQp6jXGPTD0gOwUW9LD0C7iTpX6E3Uqwv6/GR+FJfda3JUegDaT9S5Qi+iXl3QG69KD8DGCDrXIupcofqo1xx0q/Tue9scGATXIupcoeqoVxn05kUeVundZz8Ef5q'
  + 'oc4Vqo15l0BuvkpyVHoIbO52fzAWdGxF1rvBgOh4+nY6Ht0oPsknVBr1ZpT8vPQc39qL0AHSbqHOFB1m8U72aqFcb9OQ/B814mUP3/NH8bwdrEXWucDcVRb3qoCdJc9nWv9Dd8XZ+Mrc6Z2NEnStUE/Xqg54k85P583hDUxe8TfKs9BDUR9S5QhVR/8vHjx9Lz7Azg/3BQZKfk+wVHoVv/WFlzrY1u5sflJ6D1jpN8utoMvtQepCb6FXQk2SwP7'
  + 'iV5HGSHwqPwsJpkhfumbMros4VOhv13gX9wmB/cCfJoyQPY8Vewtskhx5No4TpePhzku9Lz0FrdTLqvQ365wb7g/tJ7ic5SHK77DRVe5vFUa5HToCjpOZe6S9Z3DuFy7wdTWa/lh7izxD0rzSX5O9lEfd89muSfLfreTro4u1o75vPuyTvvQKVthF1ruH30WT2svQQ1yXoQG+JOtfw79Fkdlx6iOvoxWNrAJdp7pH+msU9U7hMZ859F3Sg10SdK'
  + '9yejoePSg9xHYIO9J6oc4XHXTh0RtABIuqstJfFk1CtJugADVFnhcelB7iKoAN8RtRZ4vZ0PLxXeohVBB3gK6LOEg9LD7CKoANcQtS5xEHpAVYRdIAlRJ2v3G3zbndBB1hB1PlKa++jCzrAFUSdzxyUHmAZQQe4BlGn7QQd4JpEnVihA9Ths6ifFR4FviDoAH9SE/VnSc5LzwIXBB3gBkaT2bssVuqiTisIOsANiXovfSg9wDKCDrAGUe+dd6UH'
  + 'WEbQAdYk6r1ihQ5QM1HvDSt0gNqJev1Gk9lx6RmWEXSADRL1qr0pPcAqgg6wYaJeraPSA6wi6ABbIOrVOY+gA/STqFflVXNCYGsJOsAWiXoVzpO8Kj3EVQQdYMtEvfNetn11ngg6wE6Ieme9HU1mrV+dJ4IOsDOi3jnnSZ6XHuK6BB1gh0S9M86T/DqazN6XHuS6BB1gx5qoPys9B0tdxLy1x7xeRtABCmiOEP2t9Bx8o5MxT5K/fPz4sfQMAL0'
  + '1HQ8fJnlSeg6SJKdZxLz1O9ovI+gAhYl6K7weTWad2QB3GUEHaAFRL+p/uvJo2iqCDtASor5z50lejCazw9KDbIKgA7SIqO9MZze/LSPoAC0j6lvX6c1vywg6QAuJ+ta8zuIye1UxTwQdoLVEfeP+GE1mL0oPsS2CDtBior4xv9Wy+W0ZQQdoOVFfS3Wb35YRdIAOEPUbOU3yrEsvWFmHoAN0hKj/KW+ziHl1m9+WEXSADhH1a+n8Ma43IegAHS'
  + 'PqK1W/+W0ZQQfoIFH/xnmS56PJ7Kj0IKUIOkBHTcfDx0l+LDxGG5xlcb+8+p3sqwg6QIdNx8OnSR6UnqOgKo9xvQlBB+i4Hke9l5vflhF0gAr0MOq/jyazl6WHaBNBB6hET6Je1TvMN0nQASpSedR7c4zrTQg6QGUqjbrNb1cQdIAKVRb1N1k8Yy7mKwg6QKUqiXrV7zDfJEEHqFjHo97bY1xvQtABKtfBqNv8dgOCDtADHYr6aRb3y8X8T/pr6'
  + 'QEA2IkXWcSyzd7GyvzGrNABeqTFK3XHuK5J0AF6poVRt/ltAwQdoIea96n/lGSv4BhnWRzj2tt3mG+SoAP01HQ8vJfkaZK7O/6rz5K8tCrfLEEH6LnpePgoyeNsf7V+muSVkG+HoAOQ6Xh4K8mj5rPJsJ8nOcoi5Havb5GgA/AfTdjvN5/vb/hlzpIcJzlyf3x3BB2ASzVxv5fkoPn11pJ/9EOSdxef0WT2ficD8gVBB4AKOCkOACog6ABQAUEH'
  + 'gAoIOgBUQNABoAKCDgAVEHQAqICgA0AFBB0AKiDoAFABQQeACgg6AFRA0AGgAoIOABUQdACogKADQAUEHQAqIOgAUAFBB4AKCDoAVOB/AcvfQklDY3lLAAAAAElFTkSuQmCC';
var
  Stream: TStream;
  AnsiSt: AnsiString;
  GHelper: TfrxCustomGraphicFormatClass;
begin
  Result := nil;
  Stream := TMemoryStream.Create;
  try
    AnsiSt := frBase64Decode(AnsiString(FR));
    Stream.Write(AnsiSt[1], Length(AnsiSt));
    Stream.Position := 0;
    GHelper := GetGraphicFormats.FindByFormat(Stream, []);
    if GHelper <> nil then
      Result := GHelper.CreateFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function Round8(e: Extended): Extended;
begin
  Result := Round(e * 100000000) / 100000000;
end;

function frxParentForm: TForm;
begin
  if FParentForm = nil then
  begin
    FParentForm := TParentForm.CreateNew(nil{$IFDEF FPC}, 1{$ENDIF});
    if not IsLibrary then // Access denied AV inside multithreaded (COM) environment
      FParentForm.HandleNeeded;
  end;
  Result := FParentForm;
end;

function frxFindDataSet(DataSet: TfrxDataSet; const Name: String;
  Owner: TComponent): TfrxDataSet;
var
  i: Integer;
  ds: TfrxDataSet;
begin
  Result := DataSet;
  if Name = '' then
  begin
    Result := nil;
    Exit;
  end;
  if Owner = nil then Exit;
  DatasetList.Lock;
  for i := 0 to DatasetList.Count - 1 do
  begin
    ds := DatasetList[i];
    if AnsiCompareText(ds.UserName, Name) = 0 then
      if not ((Owner is TfrxReport) and (ds.Owner is TfrxReport) and
        (ds.Owner <> Owner)) then
      begin
        Result := DatasetList[i];
        break;
      end;
  end;
  DatasetList.Unlock;
end;

procedure frxGetDataSetList(List: TStrings);
var
  i: Integer;
  ds: TfrxDataSet;
begin
  DatasetList.Lock;
  List.Clear;
  for i := 0 to DatasetList.Count - 1 do
  begin
    ds := DatasetList[i];
    if (ds <> nil) and (ds.UserName <> '') and ds.Enabled then
      List.AddObject(ds.UserName, ds);
  end;
  DatasetList.Unlock;
end;

procedure EmptyParentForm;
begin
  while FParentForm.ControlCount > 0 do
    FParentForm.Controls[0].Parent := nil;
end;

function ShiftToByte(Value: TShiftState): Byte;
begin
  Result := Byte(PByteSet(@Value)^);
end;

function frxCreateFill(const Value: TfrxFillType): TfrxCustomFill;
begin
  Result := nil;
  if Value = ftBrush then
    Result := TfrxBrushFill.Create
  else if Value = ftGradient then
    Result := TfrxGradientFill.Create
  else if Value = ftGlass then
    Result := TfrxGlassFill.Create;
end;

function frxGetFillType(const Value: TfrxCustomFill): TfrxFillType;
begin
  Result := ftBrush;
  if Value is TfrxGradientFill then
    Result := ftGradient
  else if Value is TfrxGlassFill then
    Result := ftGlass;
end;


{ TfrxDataset }

constructor TfrxDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FOpenDataSource := True;
  FRangeBegin := rbFirst;
  FRangeEnd := reLast;
  DatasetList.Lock;
  DatasetList.Add(Self);
  DatasetList.Unlock;
end;

destructor TfrxDataSet.Destroy;
begin
  DatasetList.Lock;
  DatasetList.Remove(Self);
  inherited;
  DatasetList.Unlock;
end;

procedure TfrxDataSet.SetName(const NewName: TComponentName);
begin
  inherited;
  if NewName <> '' then
    if (FUserName = '') or (FUserName = Name) then
      UserName := NewName
end;

procedure TfrxDataSet.SetUserName(const Value: String);
begin
  if Trim(Value) = '' then
    raise Exception.Create(frxResources.Get('prInvProp'));
  FUserName := Value;
end;

procedure TfrxDataSet.Initialize;
begin
end;

procedure TfrxDataSet.Finalize;
begin
end;

procedure TfrxDataSet.Close;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TfrxDataSet.Open;
begin
  if Assigned(FOnOpen) then FOnOpen(Self);
end;

procedure TfrxDataSet.First;
begin
  FRecNo := 0;
  FEof := False;
  if Assigned(FOnFirst) then
    FOnFirst(Self);
end;

procedure TfrxDataSet.Next;
begin
  FEof := False;
  Inc(FRecNo);
  if not ((FRangeEnd = reCount) and (FRecNo >= FRangeEndCount)) then
  begin
    if Assigned(FOnNext) then
      FOnNext(Self);
  end
  else
  begin
    FRecNo := FRangeEndCount - 1;
    FEof := True;
  end;
end;

procedure TfrxDataSet.Prior;
begin
  Dec(FRecNo);
  if Assigned(FOnPrior) then
    FOnPrior(Self);
end;

function TfrxDataSet.Eof: Boolean;
begin
  Result := False;
  if FRangeEnd = reCount then
    if (FRecNo >= FRangeEndCount) or FEof then
      Result := True;
  if Assigned(FOnCheckEOF) then
    FOnCheckEOF(Self, Result);
end;

function TfrxDataSet.GetDisplayText(Index: String): WideString;
begin
  Result := '';
end;

function TfrxDataSet.GetDisplayWidth(Index: String): Integer;
begin
  Result := 10;
end;

procedure TfrxDataSet.GetFieldList(List: TStrings);
begin
  List.Clear;
end;

function TfrxDataSet.GetValue(Index: String): Variant;
begin
  Result := Null;
end;

function TfrxDataSet.HasField(const fName: String): Boolean;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    GetFieldList(sl);
  finally
    Result := sl.IndexOf(fName) <> -1;
    sl.Free;
  end;
end;

procedure TfrxDataSet.AssignBlobTo(const fName: String; Obj: TObject);
begin
// empty method
end;

function TfrxDataSet.IsBlobField(const fName: String): Boolean;
begin
  Result := False;
end;

function TfrxDataSet.IsHasMaster: Boolean;
begin
  Result := False;
end;

function TfrxDataSet.IsWideMemoBlobField(const fName: String): Boolean;
begin
  Result := False;
end;

function TfrxDataSet.IsMemoBlobField(const fName: String): Boolean;
begin
  Result := False;
end;

function TfrxDataSet.FieldsCount: Integer;
begin
  Result := 0;
end;

function TfrxDataSet.GetFieldType(Index: String): TfrxFieldType;
begin
  Result := fftNumeric;
end;

function TfrxDataSet.RecordCount: Integer;
begin
  if (RangeBegin = rbFirst) and (RangeEnd = reCount) then
    Result := RangeEndCount
  else
    Result := 0;
end;

{ TfrxUserDataSet }

procedure TfrxUserDataSet.AssignBlobTo(const FieldName: String; Obj: TObject);
begin
  if Assigned(FOnGetBlobValue) then
    FOnGetBlobValue(Self, FieldName, Obj);
end;

constructor TfrxUserDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FFields := TStringList.Create;
end;

destructor TfrxUserDataSet.Destroy;
begin
  FFields.Free;
  inherited;
end;

procedure TfrxUserDataSet.SetFields(const Value: TStrings);
begin
  FFields.Assign(Value);
end;

procedure TfrxUserDataSet.GetFieldList(List: TStrings);
begin
  List.Assign(FFields);
end;

function TfrxUserDataSet.FieldsCount: Integer;
begin
  Result := FFields.Count;
end;

function TfrxUserDataSet.GetDisplayText(Index: String): WideString;
var
  v: Variant;
begin
  Result := '';
  if Assigned(FOnGetValue) then
  begin
    v := Null;
    FOnGetValue(Index, v);
    Result := VarToWideStr(v);
  end;

  if Assigned(FOnNewGetValue) then
  begin
    v := Null;
    FOnNewGetValue(Self, Index, v);
    Result := VarToWideStr(v);
  end;
end;

function TfrxUserDataSet.GetValue(Index: String): Variant;
begin
  Result := Null;
  if Assigned(FOnGetValue) then
    FOnGetValue(Index, Result);
  if Assigned(FOnNewGetValue) then
    FOnNewGetValue(Self, Index, Result);
end;

function TfrxUserDataSet.IsBlobField(const FieldName: String): Boolean;
begin
  Result := False;
  if Assigned(FOnIsBlobField) then
    Result := FOnIsBlobField(Self, FieldName);
end;

{ TfrxCustomDBDataSet }

constructor TfrxCustomDBDataset.Create(AOwner: TComponent);
begin
  FFields := TStringList.Create;
  FFields.Sorted := True;
  FFields.Duplicates := dupIgnore;
  FAliases := TStringList.Create;
  inherited;
end;

destructor TfrxCustomDBDataset.Destroy;
begin
  FFields.Free;
  FAliases.Free;
  inherited;
end;

procedure TfrxCustomDBDataset.SetFieldAliases(const Value: TStrings);
begin
  FAliases.Assign(Value);
end;

function TfrxCustomDBDataset.ConvertAlias(const fName: String): String;
var
  i: Integer;
  s: String;
begin
  Result := fName;
  for i := 0 to FAliases.Count - 1 do
  begin
    s := FAliases[i];
    if AnsiCompareText(Copy(s, Pos('=', s) + 1, MaxInt), fName) = 0 then
    begin
      Result := FAliases.Names[i];
      break;
    end;
  end;

end;

function TfrxCustomDBDataset.GetAlias(const fName: String): String;
var
  i: Integer;
begin
  Result := fName;
  for i := 0 to FAliases.Count - 1 do
    if AnsiCompareText(FAliases.Names[i], fName) = 0 then
    begin
      Result := FAliases[i];
      Result := Copy(Result, Pos('=', Result) + 1, MaxInt);
      break;
    end;
end;

function TfrxCustomDBDataset.FieldsCount: Integer;
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
    GetFieldList(sl);
  finally
    Result := sl.Count;
    sl.Free;
  end;
end;

{ TfrxDBComponents }

function TfrxDBComponents.GetDescription: String;
begin
  Result := '';
end;

{ TfrxCustomDatabase }

procedure TfrxCustomDatabase.BeforeConnect(var Value: Boolean);
begin
  if (Report <> nil) and Assigned(Report.OnBeforeConnect) then
    Report.OnBeforeConnect(Self, Value);
end;

procedure TfrxCustomDatabase.AfterDisconnect;
begin
  if (Report <> nil) and Assigned(Report.OnAfterDisconnect) then
    Report.OnAfterDisconnect(Self);
end;

function TfrxCustomDatabase.GetConnected: Boolean;
begin
  Result := False;
end;

function TfrxCustomDatabase.GetDatabaseName: String;
begin
  Result := '';
end;

function TfrxCustomDatabase.GetLoginPrompt: Boolean;
begin
  Result := False;
end;

function TfrxCustomDatabase.GetParams: TStrings;
begin
  Result := nil;
end;

procedure TfrxCustomDatabase.SetConnected(Value: Boolean);
begin
// empty
end;

procedure TfrxCustomDatabase.SetDatabaseName(const Value: String);
begin
// empty
end;

procedure TfrxCustomDatabase.FromString(const Connection: WideString);
begin
// empty
end;

function TfrxCustomDatabase.ToString: WideString;
begin
// empty
  Result := '';
end;


procedure TfrxCustomDatabase.SetLogin(const Login, Password: String);
begin
// empty
end;

procedure TfrxCustomDatabase.SetLoginPrompt(Value: Boolean);
begin
// empty
end;

procedure TfrxCustomDatabase.SetParams(Value: TStrings);
begin
// empty
end;


{ TfrxComponent }

constructor TfrxComponent.Create(AOwner: TComponent);
begin
  if AOwner is TfrxComponent then
      inherited Create(TfrxComponent(AOwner).Report)
  else
    inherited Create(AOwner);
  FAncestorOnlyStream := False;
  FComponentStyle := [csPreviewVisible];
  FBaseName := ClassName;
  Delete(FBaseName, Pos('Tfrx', FBaseName), 4);
  Delete(FBaseName, Pos('View', FBaseName), 4);
  FObjects := TfrxObjectsNotifyList(GetObjectListClass.NewInstance);
  FObjects.Create;
{$IFNDEF FPC}
{$IFDEF DELPHI20}
  FObjects.SearchDirection := FromBeginning;
{$ENDIF}
{$ENDIF}
  FObjects.OnNotifyList := ObjectListNotify;
  FAllObjects := TList.Create;

  FFont := TFont.Create;
  with FFont do
  begin
    PixelsPerInch := frx_DefaultPPI;
    Name := DefFontName;
    Size := DefFontSize;
    Color := clBlack;
    Charset := frxCharset;
    OnChange := FontChanged;
  end;

  FVisible := True;
  ParentFont := True;
  if AOwner is TfrxComponent then
    SetParent(TfrxComponent(AOwner));
  FComponentEditors := nil;
  FSortedObjects := nil;
  FAnchors := [fraLeft, fraTop];
end;

constructor TfrxComponent.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  IsDesigning := True;
  Create(AOwner);
end;

destructor TfrxComponent.Destroy;
begin
  if Assigned(FComponentEditors) then
    FComponentEditors.Component := nil;
  FComponentEditors := nil;
  if Assigned(FSortedObjects) then
    FSortedObjects.Clear;
  SetParent(nil);
  Clear;
  FreeAndNil(FFont);
  FObjects.Free;
  FAllObjects.Free;
  FreeAndNil(FSortedObjects);
  if IsSelected then
    IsSelected := False;
  inherited;
end;

procedure TfrxComponent.Assign(Source: TPersistent);
var
  s: TMemoryStream;
begin
  if Source is TfrxComponent then
  begin
    s := TMemoryStream.Create;
    try
      TfrxComponent(Source).SaveToStream(s, False, True);
      s.Position := 0;
      LoadFromStream(s);
    finally
      s.Free;
    end;
  end;
end;

procedure TfrxComponent.AssignAll(Source: TfrxComponent; Streaming: Boolean = False);
var
  s: TMemoryStream;
begin
  s := TMemoryStream.Create;
  try
    Source.SaveToStream(s, True, True, Streaming);
    s.Position := 0;
    LoadFromStream(s);
  finally
    s.Free;
  end;
end;

procedure TfrxComponent.AssignAllWithOriginals(Source: TfrxComponent;
  Streaming: Boolean);

  procedure EnumObjects(ASource: TfrxComponent; ADest: TfrxComponent);
  var
    i: Integer;
  begin
    ADest.FAliasName := ASource.FAliasName;
    ADest.FOriginalComponent := ASource.FOriginalComponent;
    for i := 0 to ASource.Objects.Count - 1 do
      EnumObjects(ASource.Objects[i], ADest.Objects[i]);
  end;
begin
  AssignAll(Source, Streaming);
  EnumObjects(Source, Self);
end;

procedure TfrxComponent.AssignOriginals(Source: TfrxComponent);
begin
  FAliasName := Source.FAliasName;
  FOriginalComponent := Source.FOriginalComponent;
end;

procedure TfrxComponent.AssignToDict(Source: TfrxComponent);
begin
  Include(Source.FfrComponentState, csFrxSerializeToDict);
  try
    Assign(Source);
  finally
    Exclude(Source.FfrComponentState, csFrxSerializeToDict);
  end;
end;

procedure TfrxComponent.LoadFromStream(Stream: TStream);
var
  Reader: TfrxXMLSerializer;
  aReport: TfrxReport;
begin
  if not FAncestorOnlyStream then
    Clear;
  aReport := Report;
  Reader := TfrxXMLSerializer.Create(Stream);
  Reader.HandleNestedProperties := True;
  //Reader.IgnoreName := True;
  if aReport <> nil then
  begin
    aReport.FXMLSerializer := Reader;
    Reader.OnGetCustomDataEvent := aReport.OnGetCustomData;
  end;

  try
    Reader.Owner := aReport;
    if (aReport <> nil) and aReport.EngineOptions.EnableThreadSafe then
    begin
{$IFNDEF NO_CRITICAL_SECTION}
      frxCS.Enter;
{$ENDIF}
      try
        Reader.ReadRootComponent(Self, nil);
      finally
{$IFNDEF NO_CRITICAL_SECTION}
        frxCS.Leave;
{$ENDIF}
      end;
    end
    else
      Reader.ReadRootComponent(Self, nil);

    if aReport <> nil then
      aReport.Errors.AddStrings(Reader.Errors);

  finally
    Reader.Free;
    if aReport <> nil then
      aReport.FXMLSerializer := nil;
  end;
end;

procedure TfrxComponent.LockAnchorsUpdate;
begin
  FAnchorsUpdating := True;
end;

procedure TfrxComponent.MirrorContent(MirrorModes: TfrxMirrorControlModes);
begin
end;

procedure TfrxComponent.MouseClick(Double: Boolean;
  var EventParams: TfrxInteractiveEventsParams);
begin
  if (EventParams.EventSender = esPreview) and (not(ferAllowInPreview in Editable) or (EventParams.EditRestricted)) then
    Exit;
  InintComponentInPlaceEditor(EventParams);
  DoMouseClick(Double, EventParams);
end;

function TfrxComponent.MouseDown(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  EventProcessed: Boolean;
begin
  EventProcessed := False;
  if not((EventParams.EventSender = esPreview) and
    (not(ferAllowInPreview in Editable) or (EventParams.EditRestricted))) then
  begin
    InintComponentInPlaceEditor(EventParams);
    if Assigned(FComponentEditors) then
      EventProcessed := FComponentEditors.DoMouseDown(X, Y, Button, Shift,
        EventParams);
    if not EventProcessed then
    begin
        EventProcessed := DoMouseDown(X, Y, Button, Shift, EventParams);
        if (EventParams.FireParentEvent) and (Parent <> nil) and Parent.IsContain(X, Y, EventParams.Scale) then
        begin
          EventProcessed := Parent.MouseDown(X, Y, Button, Shift, EventParams);
          EventParams.FireParentEvent := False;
        end;
    end;
  end;
  Result := EventProcessed;
end;

procedure TfrxComponent.MouseEnter(aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
begin
  FMouseInView := True;
  if (Parent <> nil) and not (Parent.FMouseInView) then
    Parent.MouseEnter(aPreviousObject, EventParams);

  if (EventParams.EventSender = esPreview) and (not(ferAllowInPreview in Editable) or (EventParams.EditRestricted)) then
    Exit;
  InintComponentInPlaceEditor(EventParams);
  DoMouseEnter(aPreviousObject, EventParams);
  if Assigned(FComponentEditors) then
    FComponentEditors.InitializeUI(EventParams);
end;

procedure TfrxComponent.MouseLeave(X, Y: Integer; aNextObject: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams);
begin
  FMouseInView := False;
  if (Parent <> nil) and (Parent.FMouseInView) and not Parent.IsContain(X, Y, EventParams.Scale) then
    Parent.MouseLeave(X, Y, aNextObject, EventParams);
  if (EventParams.EventSender = esPreview) and (not(ferAllowInPreview in Editable) or (EventParams.EditRestricted)) then
    Exit;
  InintComponentInPlaceEditor(EventParams);
  DoMouseLeave(aNextObject, EventParams);
  if Assigned(FComponentEditors) then
    FComponentEditors.FinalizeUI(EventParams);
end;

procedure TfrxComponent.MouseMove(X, Y: Integer;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  EventProcessed: Boolean;
begin
  EventProcessed := False;
  if (EventParams.EventSender = esPreview) and (not(ferAllowInPreview in Editable) or (EventParams.EditRestricted)) then
    Exit;
  InintComponentInPlaceEditor(EventParams);
  if Assigned(FComponentEditors) then
    EventProcessed := FComponentEditors.DoMouseMove(X, Y, Shift, EventParams);
  if not EventProcessed then
  begin
    DoMouseMove(X, Y, Shift, EventParams);
    if (EventParams.FireParentEvent) and (Parent <> nil) and Parent.IsContain(X, Y, EventParams.Scale) then
    begin
      Parent.MouseMove(X, Y, Shift, EventParams);
      EventParams.FireParentEvent := False;
    end;
  end;
end;

procedure TfrxComponent.MouseUp(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
var
  EventProcessed: Boolean;
begin
  EventProcessed := False;
  if (EventParams.EventSender = esPreview) and (not(ferAllowInPreview in Editable) or (EventParams.EditRestricted)) then
    Exit;
  InintComponentInPlaceEditor(EventParams);
  if Assigned(FComponentEditors) then
    EventProcessed := FComponentEditors.DoMouseUp(X, Y, Button, Shift, EventParams);
  if not EventProcessed then
  begin
    DoMouseUp(X, Y, Button, Shift, EventParams);
    if (EventParams.FireParentEvent) and (Parent <> nil) and Parent.IsContain(X, Y, EventParams.Scale) then
    begin
      Parent.MouseUp(X, Y, Button, Shift, EventParams);
      EventParams.FireParentEvent := False;
    end;
  end;
end;

function TfrxComponent.MouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  EventProcessed: Boolean;
begin
  EventProcessed := False;
  if not((EventParams.EventSender = esPreview) and (not(ferAllowInPreview in Editable) or (EventParams.EditRestricted))) then
  begin

    InintComponentInPlaceEditor(EventParams);
    if Assigned(FComponentEditors) then
      EventProcessed := FComponentEditors.DoMouseWheel(Shift, WheelDelta, MousePos, EventParams);
    if not EventProcessed then
    begin
        EventProcessed := DoMouseWheel(Shift, WheelDelta, MousePos, EventParams);
        if (EventParams.FireParentEvent) and (Parent <> nil) and Parent.IsContain(MousePos.X, MousePos.Y, EventParams.Scale) then
        begin
          EventProcessed := Parent.MouseWheel(Shift, WheelDelta, MousePos, EventParams);
          EventParams.FireParentEvent := False;
       end;
    end;
  end;
  Result := EventProcessed;
end;

procedure TfrxComponent.SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
  SaveDefaultValues: Boolean = False; Streaming: Boolean = False);
var
  Writer: TfrxXMLSerializer;
begin
  Writer := TfrxXMLSerializer.Create(Stream);
  Writer.HandleNestedProperties := True;
  Writer.SaveAncestorOnly := FAncestorOnlyStream;
  try
    Writer.Owner := Report;
    Writer.SerializeDefaultValues := SaveDefaultValues;
    // remove it after join new serialization
    // serialized from VBand
    Writer.IgnoreName := Assigned(FOriginalComponent) and (csObjectsContainer in frComponentStyle);
    if (Self is TfrxReport) or FAncestorOnlyStream then
    begin
      if not FAncestorOnlyStream then
        Writer.OnSaveCustomDataEvent := Report.OnSaveCustomData;
      if not Streaming then
        Writer.OnGetAncestor := Report.DoGetAncestor;
    end;
    Writer.WriteRootComponent(Self, SaveChildren, nil);
  finally
    Writer.Free;
  end;
end;

procedure TfrxComponent.Clear;
var
  i: Integer;
  c: TfrxComponent;
begin
  if Assigned(FSortedObjects) then
    FSortedObjects.Clear;
{$IFNDEF FPC}
{$IFDEF DELPHI20}
  FObjects.SearchDirection := FromEnd;
{$ENDIF}
{$ENDIF}
  //FObjects.OnNotifyList := nil;
  i := 0;
  while FObjects.Count > i do
  begin
    c := FObjects[FObjects.Count - i - 1];
    if (csAncestor in c.ComponentState) then
    begin
      c.Clear;
      Inc(i);
    end
    else
      c.Free;
  end;
//  FObjects.OnNotifyList := ObjectListNotify;
{$IFNDEF FPC}
{$IFDEF DELPHI20}
  FObjects.SearchDirection := FromBeginning;
{$ENDIF}
{$ENDIF}
end;

procedure TfrxComponent.SetParent(AParent: TfrxComponent);
{$IFDEF FPC}
var
  i: Integer;
{$ENDIF}
begin
  if FParent <> AParent then
  begin
    if FParent <> nil then
      {$IFDEF FPC}
        for i := 0 to FParent.Objects.Count - 1 do
          if FParent.Objects[i] = Self then
          begin
            FParent.Objects.Delete(i);
            break;
          end;
      {$ELSE}
      {$IFDEF DELPHI20}
      FParent.FObjects.RemoveItem(Self, FObjects.SearchDirection);
      {$ELSE}
      FParent.FObjects.Remove(Self);
      {$ENDIF}
      {$ENDIF}
    if AParent <> nil then
      AParent.FObjects.Add(Self);
  end;

  FParent := AParent;
  if FParent <> nil then
    SetParentFont(FParentFont);
end;

procedure TfrxComponent.SetAnchors(const Value: TfrxAnchors);
begin
  FAnchors := Value;
end;

procedure TfrxComponent.SetBounds(ALeft, ATop, AWidth, AHeight: Extended);
begin
  Left := ALeft;
  Top := ATop;
  Width := AWidth;
  Height := AHeight;
end;

function TfrxComponent.GetPage: TfrxPage;
var
  p: TfrxComponent;
begin
  if Self is TfrxPage then
  begin
    Result := TfrxPage(Self);
    Exit;
  end;

  Result := nil;
  p := Parent;
  while p <> nil do
  begin
    if p is TfrxPage then
    begin
      Result := TfrxPage(p);
      Exit;
    end;
    p := p.Parent;
  end;
end;

function TfrxComponent.GetReport: TfrxReport;
begin
  Result := nil;
  if Self is TfrxReport then
    Result := TfrxReport(Self)
  else if Assigned(Parent) then
    Result := Parent.Report;
end;

function TfrxComponent.GetRestrictions: TfrxRestrictions;
begin
  Result := FRestrictions;
end;

function TfrxComponent.GetSortedObjects: TStringList;
var
  aTopParent: TfrxComponent;

  procedure EnumObjects(c: TfrxComponent);
  var
    i: Integer;
  begin
    if c.Name <> '' then
      FSortedObjects.AddObject(c.Name, c);
    for i := 0 to c.FObjects.Count - 1 do
      EnumObjects(c.FObjects[i]);
  end;

begin
  // Top most TfrxComponent stores sorted list (usually Page or Report)
  aTopParent := GetTopParent;
  if Assigned(aTopParent) then
  begin
    Result := aTopParent.GetSortedObjects;
    Exit;
  end;
  if not Assigned(FSortedObjects) and not(csDestroying in ComponentState) then
  begin
    FSortedObjects := TStringList.Create;
    FSortedObjects.Duplicates := dupIgnore;
    FSortedObjects.Sorted := True;
    EnumObjects(Self);
  end;
  Result := FSortedObjects;
end;

function TfrxComponent.GetTopParent: TfrxComponent;
var
  p: TfrxComponent;
begin
  Result := nil;
  p := Parent;
  while (p <> nil) and (p is TfrxComponent) do
  begin
    Result := p;
    p := p.Parent;
  end;
end;

function TfrxComponent.GetIsLoading: Boolean;
begin
  Result := FIsLoading or (csLoading in ComponentState);
end;

function TfrxComponent.GetIsSelected: Boolean;
begin
  Result := (FSelectList <> nil);
end;

function TfrxComponent.GetIsWriting: Boolean;
begin
  Result := csFrxWriting in FfrComponentState;
end;

class function TfrxComponent.GetObjectListClass: TfrxObjectsNotifyListClass;
begin
  Result := TfrxObjectsNotifyList;
end;

function TfrxComponent.GetAbsTop: Extended;
begin
  if (Parent <> nil) and not (Parent is TfrxDialogPage) then
    Result := Parent.AbsTop + Top else
    Result := Top;
end;

function TfrxComponent.GetAbsLeft: Extended;
begin
  if (Parent <> nil) and not (Parent is TfrxDialogPage) then
    Result := Parent.AbsLeft + Left else
    Result := Left;
end;

procedure TfrxComponent.SetLeft(Value: Extended);
begin
  if not IsDesigning or not (rfDontMove in FRestrictions) then
    FLeft := Value;
end;

procedure TfrxComponent.SetTop(Value: Extended);
begin
  if not IsDesigning or not (rfDontMove in FRestrictions) then
    FTop := Value;
end;

procedure TfrxComponent.SetWidth(Value: Extended);
begin
  if not IsDesigning or not (rfDontSize in FRestrictions) then
  begin
    if (Objects.Count > 0) and not SameValue(Value, FWidth, 0.01) then
      UpdateAnchors(Value - FWidth, 0);
    FWidth := Value;
  end;
end;

procedure TfrxComponent.ThreadSynchronize(Method: TThreadMethod);
var
  lReport: TfrxReport;
  lPage: TfrxPage;
begin
  lReport := Report;
  if not Assigned(lReport) then
  begin
    lPage := Page;
    if Assigned(lPage) and (lPage is TfrxReportPage) then
      lReport :=  TfrxReportPage(lPage).ParentReport;
  end;

  if Assigned(lReport) and not lReport.EngineOptions.EnableThreadSafe then
    Method
  else
    frThreadSynchronize(Method);
end;

procedure TfrxComponent.UnlockAnchorsUpdate;
begin
  FAnchorsUpdating := False;
end;

procedure TfrxComponent.UpdateAnchors(DeltaX, Deltay: Extended);
var
  c: TfrxComponent;
  i: Integer;
begin
  if FAnchorsUpdating then Exit;
  //if not((Self is TfrxBand) or (csObjectsContainer in frComponentStyle)) then Exit;
  FAnchorsUpdating := True;
  try
    for i := 0 to Objects.Count - 1 do
    begin
      c := TfrxComponent(Objects[i]);
      if c.FAnchorsUpdating then continue;

      if fraRight in c.Anchors then
        if fraLeft in c.Anchors then
          c.Width := c.Width + DeltaX
        else
          c.Left := c.Left + DeltaX
      else if not(fraLeft in c.Anchors) then
        // emulates delphi's Anchor behaviour
        c.Left := c.Left + Round(DeltaX / 1.18);
      if fraBottom in c.Anchors then
        if fraTop in c.Anchors then
          c.Height := c.Height + Deltay
        else
          c.Top := c.Top + Deltay
      else if not(fraTop in c.Anchors) then
        // emulates delphi's Anchor behaviour
        c.Top := c.Top + Round(Deltay / 1.18);
    end;
  finally
    FAnchorsUpdating := False;
  end
end;

procedure TfrxComponent.UpdateBounds;
begin
//
end;

procedure TfrxComponent.SetHeight(Value: Extended);
begin
  if not IsDesigning or not (rfDontSize in FRestrictions) then
  begin
    if (Objects.Count > 0) and not SameValue(Value, FHeight, 0.01) then
      UpdateAnchors(0, Value - FHeight);
    FHeight := Value;
  end
end;

procedure TfrxComponent.SetIsDesigning(const Value: Boolean);
begin
  if Value then
    Include(FfrComponentState, csFrxDesigning)
  else
    Exclude(FfrComponentState, csFrxDesigning);
end;

procedure TfrxComponent.SetIsSelected(const Value: Boolean);
var
  aReport: TfrxReport;
begin
  if Value then
  begin
    aReport := GetGlobalReport;
    if (aReport <> nil) and (aReport.Designer <> nil) then
      FSelectList := TfrxCustomDesigner(aReport.Designer).FSelectedObjects
    else if (aReport <> nil) and (aReport.Preview <> nil) then
      FSelectList := TfrxCustomPreview(aReport.Preview).FSelectionList;
  end
  else if Assigned(FSelectList) then
  begin
    FSelectList.Remove(Self);
    FSelectList := nil;
  end;
end;

procedure TfrxComponent.SetIsWriting(const Value: Boolean);
begin
  if Value then
    Include(FfrComponentState, csFrxWriting)
  else
    Exclude(FfrComponentState, csFrxWriting);
end;

function TfrxComponent.IsAcceptControl
(aControl: TfrxComponent): Boolean;
begin
  Result := (aControl = nil) or ((aControl <> nil) and IsAcceptControls and
    (aControl <> Self) and aControl.IsAcceptAsChild(Self) and
    not(csContained in aControl.frComponentStyle));
end;

function TfrxComponent.IsAcceptControls: Boolean;
begin
  Result := csAcceptsFrxComponents in frComponentStyle;
end;

function TfrxComponent.IsContain(X, Y, AScale: Extended): Boolean;
begin
  Result := IsContain(X / AScale, Y / AScale)
end;

function TfrxComponent.IsAcceptAsChild(aParent: TfrxComponent): Boolean;
begin
  Result := False;
end;

function TfrxComponent.IsContain(X, Y: Extended): Boolean;
var
  w0, w1, w2, w3: Extended;
begin
  w0 := 0;
  w1 := 0;
  w2 := 0;
  if Width = 0 then
  begin
    w0 := 4;
    w1 := 4
  end
  else if Height = 0 then
    w2 := 4;
  w3 := w2;

  Result := (X >= AbsLeft - w0) and
    (X <= AbsLeft + Width + w1) and
    (Y >= AbsTop - w2) and
    (Y <= AbsTop + Height + w3);

  if Assigned(FComponentEditors) then
    Result := Result or FComponentEditors.IsContain(Rect(Round(AbsLeft), Round(AbsTop), Round(AbsLeft + Width), Round(AbsTop + Height)), X, Y);
end;

function TfrxComponent.IsFontStored: Boolean;
begin
  Result := not FParentFont;
end;

function TfrxComponent.IsHeightStored: Boolean;
begin
  Result := True;
end;

function TfrxComponent.IsIndexTagStored: Boolean;
begin
  Result := IndexTag > 0;
end;

function TfrxComponent.IsInRect(const aRect: TfrxRect): Boolean;
var
  cLeft, cTop, cRight, cBottom, e: Extended;

  function RectInRect: Boolean;
  begin
    with aRect do
      Result := not((cLeft > Right) or (cRight < Left) or
        (cTop > Bottom) or (cBottom < Top));
  end;

begin
  cLeft := AbsLeft;
  cRight := AbsLeft + Width;
  cTop := AbsTop;
  cBottom := AbsTop + Height;

  if cRight < cLeft then
  begin
    e := cRight;
    cRight := cLeft;
    cLeft := e;
  end;
  if cBottom < cTop then
  begin
    e := cBottom;
    cBottom := cTop;
    cTop := e;
  end;
  Result := RectInRect;
end;

function TfrxComponent.IsLeftStored: Boolean;
begin
  Result := True;
end;

function TfrxComponent.IsTopStored: Boolean;
begin
  Result := True;
end;

function TfrxComponent.IsWidthStored: Boolean;
begin
  Result := True;
end;

procedure TfrxComponent.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  FParentFont := False;
end;

procedure TfrxComponent.SetParentFont(const Value: Boolean);
begin
  if Value then
    if Parent <> nil then
      Font := Parent.Font;
  FParentFont := Value;
end;

procedure TfrxComponent.SetVisible(Value: Boolean);
begin
  FVisible := Value;
end;

procedure TfrxComponent.FontChanged(Sender: TObject);
var
  i: Integer;
  c: TfrxComponent;
begin
  FParentFont := False;
  for i := 0 to FObjects.Count - 1 do
  begin
    c := FObjects[i];
    if c.ParentFont then
      c.ParentFont := True;
  end;
end;

function TfrxComponent.GetAllObjects: TList;

  procedure EnumObjects(c: TfrxComponent);
  var
    i: Integer;
  begin
    if c <> Self then
      FAllObjects.Add(c);
    for i := 0 to c.FObjects.Count - 1 do
      EnumObjects(c.FObjects[i]);
  end;

begin
  FAllObjects.Clear;
  EnumObjects(Self);
  Result := FAllObjects;
end;

procedure TfrxComponent.SetName(const AName: TComponentName);
var
  c: TfrxComponent;
  Index: Integer;
  sl: TStringList;
begin
  if CompareText(AName, Name) = 0 then Exit;

  if (AName <> '') and (Report <> nil) then
  begin
    c := nil;//Report.FindObject(AName);
    sl := GetSortedObjects;
    Index := sl.IndexOf(AName);
    if Index <> -1 then
      c := TfrxComponent(sl.Objects[Index]);
    if (c <> nil) and (c <> Self) then
      raise EDuplicateName.Create(frxResources.Get('prDupl'));
    if IsAncestor then
      raise Exception.CreateFmt(frxResources.Get('clCantRen'), [Name]);
    Index := sl.IndexOf(Name);
    if Index <> - 1 then
      sl.Delete(Index);
    sl.AddObject(AName, Self)
  end;
  inherited;
end;

procedure TfrxComponent.CreateUniqueName(DefaultReport: TfrxReport);
var
  i, Index: Integer;
  sl, CurObjSL, AddedNames: TStringList;
begin
  CurObjSL := nil;
  AddedNames := nil;
  if Assigned(DefaultReport) then
  begin
    sl := DefaultReport.GetSortedObjects;
    CurObjSL := GetSortedObjects;
    { used for temporary moved objects }
    AddedNames := TStringList.Create;
    AddedNames.Sorted := True;
  end
  else
    sl := GetSortedObjects;
  try
    { when DefaultReport is not nil we are probably call CreateUniqueName }
    { from editor. Assign all new created objects to tre report list for  }
    { and remove them after.                                              }
    if Assigned(CurObjSL) then
      for i := 0 to CurObjSL.Count - 1 do
        if sl.IndexOf(CurObjSL[i]) < 0 then
        begin
          sl.AddObject(CurObjSL[i], CurObjSL.Objects[i]);
          AddedNames.AddObject(CurObjSL[i], CurObjSL.Objects[i]);
        end;
    i := 1;
    // trick when we have a lot of objects and call CreateUniqueName often
    // Like with big tables
    // we add two fake items, one will be on top and other on bottom of the FBaseName + I obects
    // it sets name index based on object count of this type
    // such trick allows to reduce cycles when creating lots of objects

    if sl.Count > 3 then
    begin
      Index := sl.Add(String(FBaseName) + '0');
      Index := sl.Add(String(FBaseName) + 'A') - Index;
      i := Index - 1;
      while sl.IndexOf(String(FBaseName) + IntToStr(i)) = -1 do
        Dec(i);
    end;

    while sl.IndexOf(String(FBaseName) + IntToStr(i)) <> -1 do
      Inc(i);
    SetName(String(FBaseName) + IntToStr(i));

    { Report is parent for object }
    if (DefaultReport = nil) or (sl = GetSortedObjects) then
      sl.AddObject(String(FBaseName) + IntToStr(i), Self)
    else if Assigned(CurObjSL) then
      CurObjSL.AddObject(String(FBaseName) + IntToStr(i), Self);

  finally
    { can impact performance , but it uses mustly in object editors }
    if Assigned(AddedNames) then
      for i := 0 to AddedNames.Count - 1 do
      begin
        Index := sl.IndexOf(AddedNames[i]);
        if Index > -1 then
          sl.Delete(Index);
      end;
    AddedNames.Free;
  end;
end;

function TfrxComponent.Diff(AComponent: TfrxComponent): String;
begin
  Result := InternalDiff(AComponent);
end;

function TfrxComponent.DiffFont(f1, f2: TFont; const Add: String): String;
var
  fs: Integer;
begin
  Result := '';

  if f1.Name <> f2.Name then
    Result := Result + Add + 'Font.Name="' + frxStrToXML(f1.Name) + '"';
  if f1.Size <> f2.Size then
    Result := Result + Add + 'Font.Size="' + IntToStr(f1.Size) + '"';
  if f1.Color <> f2.Color then
    Result := Result + Add + 'Font.Color="' + IntToStr(f1.Color) + '"';
  if f1.Style <> f2.Style then
  begin
    fs := 0;
    if fsBold in f1.Style then fs := 1;
    if fsItalic in f1.Style then fs := fs or 2;
    if fsUnderline in f1.Style then fs := fs or 4;
    if fsStrikeout in f1.Style then fs := fs or 8;
    Result := Result + Add + 'Font.Style="' + IntToStr(fs) + '"';
  end;
  if f1.Charset <> f2.Charset then
    Result := Result + Add + 'Font.Charset="' + IntToStr(f1.Charset) + '"';
end;

function TfrxComponent.DoDragDrop(Source: TObject; X, Y: Integer;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  // if result = False then parent window should precess event in parent control
  Result := False;
end;

function TfrxComponent.DoDragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
//  DrawHighlights := True;
  // if result = False then parent window should precess event in parent control
  Result := False;
end;

procedure TfrxComponent.DoMirror(MirrorModes: TfrxMirrorControlModes);
begin
  if (mcmOnlyAllowed in MirrorModes) and not (IsSelected or FAllowMirrorMode) then Exit;
  MirrorContent(MirrorModes);

  if Assigned(FParent) then
  begin
    if ((mcmRTLObjects in MirrorModes) and (Objects.Count = 0)) or
       ((mcmRTLBands in MirrorModes) and (Self is TfrxBand)) then
      Left := Left + ((FParent.Width - (Left + Width)) - Left);
    if ((mcmBTTObjects in MirrorModes) and (Objects.Count = 0)) or
      ((mcmBTTBands in MirrorModes) and (Self is TfrxBand)) then
      Top := Top + ((FParent.Height - (Top + Height)) - Top);
  end;
end;

procedure TfrxComponent.DoMouseClick(Double: Boolean;
  var EventParams: TfrxInteractiveEventsParams);
begin

end;

function TfrxComponent.DoMouseDown(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

procedure TfrxComponent.DoMouseEnter(aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
begin
end;

procedure TfrxComponent.DoMouseLeave(aNextObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
begin

end;

procedure TfrxComponent.DoMouseMove(X, Y: Integer;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
begin
//
end;

procedure TfrxComponent.DoMouseUp(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
begin
//
end;

function TfrxComponent.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

function TfrxComponent.DragDrop(Source: TObject; X, Y: Integer;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  EventProcessed: Boolean;
begin
  EventProcessed := False;
  InintComponentInPlaceEditor(EventParams);
  if Assigned(FComponentEditors) then
    EventProcessed := FComponentEditors.DoCustomDragDrop(Source, X, Y, EventParams);
  if not EventProcessed then
    EventProcessed := DoDragDrop(Source, X, Y, EventParams);
  Result := EventProcessed;
end;

function TfrxComponent.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  EventProcessed: Boolean;
begin
  EventProcessed := False;
  InintComponentInPlaceEditor(EventParams);
  if Assigned(FComponentEditors) then
    EventProcessed := FComponentEditors.DoCustomDragOver(Source, X, Y, State, Accept, EventParams);
  if not EventProcessed then
    EventProcessed := DoDragOver(Source, X, Y, State, Accept, EventParams);
  Result := EventProcessed;
end;

function TfrxComponent.ExportInternal(Filter: TfrxCustomExportFilter): Boolean;
begin
  Result := False;
end;

procedure TfrxComponent.InintComponentInPlaceEditor(var EventParams: TfrxInteractiveEventsParams);
begin
  if not Assigned(EventParams.EditorsList) then Exit;
  if not Assigned(FComponentEditors) then
    FComponentEditors := frxGetInPlaceEditor(EventParams.EditorsList, Self);
  if Assigned(FComponentEditors) then
    FComponentEditors.Component := Self;
  { Editor doesn't let to change component }
  { when editor is locked by another component }
  { and reset FComponentEditors to nil again }
  if Assigned(FComponentEditors) then
    FComponentEditors.SetOffset(EventParams.OffsetX, EventParams.OffsetY, EventParams.Scale);
   // FComponentEditors.Editors := EventParams.EditorsList;
end;

function TfrxComponent.InternalDiff(AComponent: TfrxComponent): String;
begin
  Result := '';

  if frxFloatDiff(FLeft, AComponent.FLeft) and IsLeftStored then
    Result := Result + ' l="' + FloatToStr(FLeft) + '"';
  if ((Self is TfrxBand) or frxFloatDiff(FTop, AComponent.FTop)) and IsTopStored then
    Result := Result + ' t="' + FloatToStr(FTop) + '"';
  if not ((Self is TfrxCustomMemoView) and TfrxCustomMemoView(Self).AutoWidth) and IsWidthStored then
    if frxFloatDiff(FWidth, AComponent.FWidth) then
      Result := Result + ' w="' + FloatToStr(FWidth) + '"';
  if frxFloatDiff(FHeight, AComponent.FHeight) and IsHeightStored then
    Result := Result + ' h="' + FloatToStr(FHeight) + '"';
  if FVisible <> AComponent.FVisible then
    Result := Result + ' Visible="' + frxValueToXML(FVisible) + '"';
  if not FParentFont then
    Result := Result + DiffFont(FFont, AComponent.FFont, ' ');
  if FParentFont <> AComponent.FParentFont then
    Result := Result + ' ParentFont="' + frxValueToXML(FParentFont) + '"';
  if Tag <> AComponent.Tag then
    Result := Result + ' Tag="' + IntToStr(Tag) + '"';
  if FVisible <> AComponent.FVisible then
    Result := Result + ' AllowMirrorMode="' + frxValueToXML(FAllowMirrorMode) + '"';
end;

function TfrxComponent.AllDiff(AComponent: TfrxComponent): String;
var
  s: TStringStream;
  Writer: TfrxXMLSerializer;
  i: Integer;
begin
{$IFDEF DELPHI12}
  s := TStringStream.Create('', TEncoding.UTF8);
{$ELSE}
  s := TStringStream.Create('');
{$ENDIF}
  Writer := TfrxXMLSerializer.Create(s);
  Writer.Owner := Report;
  Include(FfrComponentState, csFrxSerializeToPreviewPages);
  if Assigned(AComponent) then
    Include(AComponent.FfrComponentState, csFrxSerializeToPreviewPages);
  try
    Writer.WriteComponent(Self, AComponent);
  finally
    Exclude(FfrComponentState, csFrxSerializeToPreviewPages);
    if Assigned(AComponent) then
      Exclude(AComponent.FfrComponentState, csFrxSerializeToPreviewPages);
    Writer.Free;
  end;

  Result := s.DataString;
  i := Pos(' ', Result);
  if i <> 0 then
  begin
    Delete(Result, 1, i);
    Delete(Result, Length(Result) - 1, 2);
  end
  else
    Result := '';
  if AComponent <> nil then
    Result := Result + ' ' + InternalDiff(AComponent);
  { cross bands and Keep mechanism fix }
  if (Self is TfrxNullBand) then
  begin
    Result := Result + ' l="' + FloatToStr(FLeft) + '"';
    Result := Result + ' t="' + FloatToStr(FTop) + '"';
  end;

  s.Free;
end;

procedure TfrxComponent.AddSourceObjects;
begin
// do nothing
end;

procedure TfrxComponent.AlignChildren(IgnoreInvisible: Boolean; MirrorModes: TfrxMirrorControlModes);
var
  i: Integer;
  c: TfrxComponent;
  sl: TStringList;
  aClientRect: TfrxRect;

  procedure DoAlign(v: TfrxView; n, dir: Integer);
  var
    i: Integer;
    c, c0: TfrxComponent;
  begin
    c0 := nil;
    i := n;
    while (i >= 0) and (i < sl.Count) do
    begin
      c := TfrxComponent(sl.Objects[i]);
      if c <> v then
        if (c.AbsTop < v.AbsTop + v.Height - 1e-4) and
          (v.AbsTop < c.AbsTop + c.Height - 1e-4) then
        begin
          { special case for baWidth }
          if (v.Align = baWidth) and
            (((dir = 1) and (c.Left > v.Left)) or
            ((dir = -1) and (c.Left + c.Width < v.Left + v.Width))) then
          begin
            Dec(i, dir);
            continue;
          end;
          c0 := c;
          break;
        end;
      Dec(i, dir);
    end;

    if (dir = 1) and (v.Align in [baLeft, baWidth]) then
      if c0 = nil then
        v.Left := aClientRect.Left else
        v.Left := c0.Left + c0.Width;

    if v.Align = baRight then
      if c0 = nil then
        v.Left := aClientRect.Right - v.Width else
        v.Left := c0.Left - v.Width;

    if (dir = -1) and (v.Align = baWidth) then
      if c0 = nil then
        v.Width := aClientRect.Right - v.Left else
        v.Width := c0.Left - v.Left;
  end;


  function IsVisibleView(c: TfrxComponent): Boolean;
  begin
    Result := (c is TfrxView) and (TfrxView(c).Align <> baHidden);
    if IgnoreInvisible then
      Result := Result and c.Visible;
  end;

begin
  if FObjects.Count = 0 then Exit;
  sl := {$IFNDEF NONWINFPC}TStringList.Create;{$ELSE}TfrxStringList.Create;{$ENDIF}
  sl.Sorted := True;
  sl.Duplicates := dupAccept;

  for i := 0 to FObjects.Count - 1 do
  begin
    c := FObjects[i];
    if IsVisibleView(c) then
    begin
      c.DoMirror(MirrorModes);
      if c.Left >= 0 then
        sl.AddObject('1' + Format('%9.2f', [c.Left]), c)
      else
        sl.AddObject('0' + Format('%9.2f', [-c.Left]), c);
    end;
  end;

  aClientRect := GetClientArea;
  { process baLeft }

  for i := 0 to sl.Count - 1 do
  begin
    c := TfrxComponent(sl.Objects[i]);
    if IsVisibleView(c) then
      if TfrxView(c).Align in [baLeft, baWidth] then
        DoAlign(TfrxView(c), i, 1);
  end;

  { process baRight }

  for i := sl.Count - 1 downto 0 do
  begin
    c := TfrxComponent(sl.Objects[i]);
    if IsVisibleView(c) then
      if TfrxView(c).Align in [baRight, baWidth] then
        DoAlign(TfrxView(c), i, -1);
  end;

  { process others }

  for i := 0 to FObjects.Count - 1 do
  begin
    c := FObjects[i];
    if IsVisibleView(c) then
    begin
      case TfrxView(c).Align of
        baCenter:
          c.Left := (aClientRect.Right - c.Width) / 2;

        baBottom:
          c.Top := aClientRect.Bottom - c.Height;

        baClient:
          begin
            c.Left := aClientRect.Left;
            c.Top := aClientRect.Top;
            c.Width := aClientRect.Right;
            c.Height := aClientRect.Bottom;
          end;
      end;
      TfrxView(c).AlignChildren(IgnoreInvisible, MirrorModes);
    end;
  end;

  sl.Free;
end;

function TfrxComponent.FindObject(const AName: String): TfrxComponent;
var
  i: Integer;
  l: TList;
begin
  Result := nil;
  l := AllObjects;
  for i := 0 to l.Count - 1 do
    if CompareText(AName, TfrxComponent(l[i]).Name) = 0 then
    begin
      Result := l[i];
      break;
    end;
end;

class function TfrxComponent.GetDescription: String;
begin
  Result := ClassName;
end;

function TfrxComponent.GetDrawTextObject: Pointer;
var
  aReport: TfrxReport;
begin
  aReport := GetGlobalReport;
  if aReport <> nil then
    Result := aReport.FDrawText else
    Result := frxDrawText;
end;

function TfrxComponent.GetGlobalReport: TfrxReport;
var
  p: TfrxComponent;
begin
  Result := Report;
  { preview report }
  if not Assigned(Result) then
  begin
    p := Parent;
    while p <> nil do
    begin
      if p is TfrxReportPage then
      begin
        Result := TfrxReportPage(p).ParentReport;
        Exit;
      end;
      p := p.Parent;
    end;
  end;
end;


function TfrxComponent.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TfrxComponent.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  if (Self is TfrxReport) and not TfrxReport(Self).StoreInDFM then
    Exit;
  for i := 0 to FObjects.Count - 1 do
    Proc(FObjects[i]);
end;

function TfrxComponent.GetClientArea: TfrxRect;
begin
  Result := frxRect(0, 0, Width, Height);
end;

procedure TfrxComponent.BeforeStartReport;
begin
// do nothing
end;

procedure TfrxComponent.ObjectListNotify(Ptr: Pointer;
  Action: TListNotification);
var
  SortedList: TStringList;

  procedure EnumObjects(c: TfrxComponent);
  var
    i: Integer;
  begin
    if (Action = lnAdded) then
      SortedList.AddObject(c.Name, c)
    else
    begin
      i := SortedList.IndexOf(c.Name);
      if i <> -1 then
        SortedList.Delete(i);
    end;
    for i := 0 to c.FObjects.Count - 1 do
      EnumObjects(c.FObjects[i]);
  end;

begin
  if (TfrxComponent(Ptr).Name = '') then
    Exit;

  if (Action = lnDeleted) and (Assigned(Parent) or Assigned(FSortedObjects)) then
  begin
    SortedList := GetSortedObjects;
    if Assigned(SortedList) and (SortedList.Count > 0) then
      EnumObjects(TfrxComponent(Ptr));
  end;
  if (Action = lnAdded) then
  begin
    SortedList := GetSortedObjects;
    if SortedList = nil then Exit;
    EnumObjects(TfrxComponent(Ptr));
    FreeAndNil(TfrxComponent(Ptr).FSortedObjects);
  end;
end;

procedure TfrxComponent.OnNotify(Sender: TObject);
begin
// do nothing
end;

procedure TfrxComponent.OnPaste;
begin
//
end;

function TfrxComponent.GetIsAncestor: Boolean;
begin
  Result := (csAncestor in ComponentState) or FAncestor;
end;

function TfrxComponent.GetIsDesigning: Boolean;
begin
  Result := csFrxDesigning in FfrComponentState;
end;

function TfrxComponent.FindDataSet(DataSet: TfrxDataSet; const DSName: String): TfrxDataSet;
var
  DSItem:TfrxDataSetItem;
  AReport: TfrxReport;
begin
  Result := nil;
  if Self is TfrxReport then
    AReport := TfrxReport(Self)
  else AReport := Report;
  if (AReport <> nil) and not AReport.EngineOptions.UseGlobalDataSetList then
  begin
    DSItem := AReport.EnabledDataSets.Find(DSName);
    if DSItem <> nil then Result := DSItem.FDataSet;
  end
  else
    Result := frxFindDataSet(DataSet, DSName, AReport);
end;

function TfrxComponent.GetContainedComponent(X, Y: Extended;
  IsCanContain: TfrxComponent): TfrxComponent;
var
  i: Integer;
  c: TfrxComponent;
begin
  Result := nil;
  // TODO for components with child need to increase rect for outbound objects
  if IsContain(X, Y) or (Objects.Count > 0) then
  begin
    if (Objects.Count = 0) or IsContain(X, Y) then
      Result := Self;
    for i := Objects.Count -1 downto 0 do
    begin
      if TObject(Objects[i]) is TfrxComponent then
      begin
        c := TfrxComponent(Objects[i]).GetContainedComponent(X, Y, IsCanContain);
        if (c <> nil) and not (c is TfrxNullBand) then
        begin
          Result := c;
          break;
        end;
      end;
    end;
  end;
  if (Result = Self) and ((IsCanContain = Self) or (not IsAcceptControl(IsCanContain))) then
    Result := nil;
end;

procedure TfrxComponent.GetContainedComponents(const aRect: TfrxRect;
  InheriteFrom: TClass; aComponents: TList; bSelectContainers: Boolean);
var
  i: Integer;
begin
  if not Assigned(aComponents) then Exit;
  // TODO for components with child need to increase rect for outbound objects
  if IsInRect(aRect) or (Objects.Count > 0) then
  begin
    if not bSelectContainers then
      bSelectContainers := not (csObjectsContainer in frComponentStyle);
    if (aComponents.IndexOf(Self) = -1) and bSelectContainers and
      ((Objects.Count = 0) or IsInRect(aRect)) and InheritsFrom(InheriteFrom)
    then
      aComponents.Add(Self);
    for i := 0 to Objects.Count -1 do
      if TObject(Objects[i]) is TfrxComponent then
        TfrxComponent(Objects[i]).GetContainedComponents(aRect, InheriteFrom, aComponents);
  end;
end;


function TfrxComponent.GetContainerObjects: TList;
begin
  Result := FObjects;
end;

function TfrxComponent.ContainerAdd(Obj: TfrxComponent): Boolean;
begin
  Result := False;
end;

procedure TfrxComponent.WriteNestedProperties(Item: TfrXMLItem; aAcenstor: TPersistent = nil);
begin
end;

function TfrxComponent.ReadNestedProperty(Item: TfrXMLItem): Boolean;
begin
  Result := False;
end;


{ TfrxReportComponent }

constructor TfrxReportComponent.Create(AOwner: TComponent);
begin
  inherited;
  //FShiftChildren := TList.Create;
  FOriginalObjectsCount := -1;
end;

destructor TfrxReportComponent.Destroy;
var
  msg: TfrxDispatchMessage;
begin
  //FShiftChildren.Free;
  if Assigned(FShiftObject) then
  begin
    msg.MsgID := FRX_OWNER_DESTROY_MESSAGE;
    msg.Sender := Self;
    FShiftObject.DefaultHandler(msg);
    FShiftObject := nil;
  end;
  inherited;
end;

//procedure TfrxReportComponent.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
//  OffsetY: Extended; Highlighted: Boolean);
//begin
//  { support for old Draw interface}
//  FHighlightedCall := True;
//  try
//    Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
//  finally
//    FHighlightedCall := False;
//  end;
//end;
//
//procedure TfrxReportComponent.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
//  OffsetY: Extended);
//begin
//  if not FHighlightedCall then
//    Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY, False);
//end;

procedure TfrxReportComponent.DrawChilds(Canvas: TCanvas; ScaleX, ScaleY,
  OffsetX, OffsetY: Extended; Highlighted: Boolean; IsDesigning: Boolean);
var
  i: Integer;
  c: TfrxReportComponent;
begin
  for i := 0 to Objects.Count - 1 do
    if TObject(Objects[i]) is TfrxReportComponent then
    begin
      c := TfrxReportComponent(Objects[i]);
      c.IsDesigning := IsDesigning;
      if not c.IsOwnerDraw then
        c.InteractiveDraw(Canvas, ScaleX, ScaleY, OffsetX,
          OffsetY, Highlighted);
    end;
end;

procedure TfrxReportComponent.DrawHighlight(Canvas: TCanvas; ScaleX, ScaleY,
  OffsetX, OffsetY: Extended; hlColor: TColor);
begin

end;

procedure TfrxReportComponent.DrawSizeBox(aCanvas: TCanvas; aScale: Extended; bForceDraw: Boolean);
var
  px, py: Extended;

  procedure DrawPoint(x, y: Extended);
  var
    i, w: Integer;
  begin
    if aScale > 1.7 then
      w := 7
    else if aScale < 0.7 then
      w := 3 else
      w := 5;
    for i := 0 to w - 1 do
    begin
      aCanvas.MoveTo(Round(x * aScale) - w div 2, Round(y * aScale) - w div 2 + i);
      aCanvas.LineTo(Round(x * aScale) + w div 2  +1, Round(y * aScale) - w div 2 + i);
    end;
  end;

begin
  if not (Assigned(FSelectList) and IsDesigning) and not bForceDraw then Exit;
  with aCanvas do
  begin
    Pen.Style := psSolid;
    Pen.Width := 1;
    Pen.Mode := pmXor;
    Pen.Color := clWhite;
    px := AbsLeft + Self.Width / 2;
    py := AbsTop + Self.Height / 2;

    DrawPoint(AbsLeft, AbsTop);
    if not(Self is TfrxCustomLineView) then
    begin
      DrawPoint(AbsLeft + Self.Width, AbsTop);
      DrawPoint(AbsLeft, AbsTop + Self.Height);
    end;
    //if (SelectedCount > 1) and (c = GetRightBottomObject) then
    //  Pen.Color := clTeal;
    DrawPoint(AbsLeft + Self.Width, AbsTop + Self.Height);

    Pen.Color := clWhite;
    if (bForceDraw or (FSelectList.Count = 1)) and not(Self is TfrxCustomLineView) then
    begin
      DrawPoint(px, AbsTop);
      DrawPoint(px, AbsTop + Self.Height);
      DrawPoint(AbsLeft, py);
      DrawPoint(AbsLeft + Self.Width, py);
    end;

    Pen.Mode := pmCopy;
  end;
end;

procedure TfrxReportComponent.DrawWithChilds(Canvas: TCanvas; ScaleX, ScaleY,
  OffsetX, OffsetY: Extended; Highlighted, IsDesigning: Boolean);
begin
  InteractiveDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY, Highlighted);
  DrawChilds(Canvas, ScaleX, ScaleY, OffsetX, OffsetY, Highlighted, IsDesigning);
end;

procedure TfrxReportComponent.GetData;
begin
// do nothing
end;

procedure TfrxReportComponent.BeforePrint;
begin
  FOriginalRect := frxRect(Left, Top, Width, Height);
end;

procedure TfrxReportComponent.AfterPrint;
begin
  with FOriginalRect do
    SetBounds(Left, Top, Right, Bottom);
end;

function TfrxReportComponent.GetComponentText: String;
begin
  Result := '';
end;

function TfrxReportComponent.GetRealBounds: TfrxRect;
begin
  Result := frxRect(AbsLeft, AbsTop, AbsLeft + Width, AbsTop + Height);
end;

function TfrxReportComponent.GetSaveToComponent: TfrxReportComponent;
begin
  Result := Self;
end;

procedure TfrxReportComponent.InteractiveDraw(Canvas: TCanvas; ScaleX, ScaleY,
  OffsetX, OffsetY: Extended; Highlighted: Boolean; hlColor: TColor);
begin
  FHighlighted := Highlighted;
  Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  FHighlighted := False;
  //DrawSizeBox(Canvas, ScaleX, False);
  if {(IsDesigning and FHighlighted and IsSelected) or} Highlighted or
    (not IsDesigning and IsSelected) then
    DrawHighlight(Canvas, ScaleX, ScaleY, OffsetX, OffsetY, hlColor);
end;

function TfrxReportComponent.IsOwnerDraw: Boolean;
begin
  Result := False;
end;

{ TfrxDialogComponent }

constructor TfrxDialogComponent.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csPreviewVisible];
  Width := 28;
  Height := 28;
end;

destructor TfrxDialogComponent.Destroy;
begin
  if FComponent <> nil then
    FComponent.Free;
  FComponent := nil;
  inherited;
end;

procedure TfrxDialogComponent.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('pLeft', ReadLeft, WriteLeft, Report <> nil);
  Filer.DefineProperty('pTop', ReadTop, WriteTop, Report <> nil);
end;

procedure TfrxDialogComponent.ReadLeft(Reader: TReader);
begin
  Left := Reader.ReadInteger;
end;

procedure TfrxDialogComponent.ReadTop(Reader: TReader);
begin
  Top := Reader.ReadInteger;
end;

procedure TfrxDialogComponent.WriteLeft(Writer: TWriter);
begin
  Writer.WriteInteger(Round(Left));
end;

procedure TfrxDialogComponent.WriteTop(Writer: TWriter);
begin
  Writer.WriteInteger(Round(Top));
end;

procedure TfrxDialogComponent.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  r: TRect;
  i, w, ImageIndex: Integer;
  Item: TfrxObjectItem;
begin
  Width := 28;
  Height := 28;
  r := Rect(Round(Left * ScaleX), Round(Top * ScaleY), Round((Left + Width) * ScaleX), Round((Top + Height) * ScaleY));
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(r);
  DrawEdge(Canvas.Handle, r, EDGE_RAISED, BF_RECT);

  ImageIndex := -1;
  for i := 0 to frxObjects.Count - 1 do
  begin
    Item := frxObjects[i];
    if Item.ClassRef = ClassType then
    begin
      ImageIndex := Item.ButtonImageIndex;
      break;
    end;
  end;

  if ImageIndex <> -1 then
    frxImages.ObjectImages.Draw(Canvas, Round(r.Left + 6 * ScaleX), Round(r.Top + 6 * ScaleY), ImageIndex);

  Canvas.Font.Name := 'Tahoma';
  Canvas.Font.Size := 8;
  Canvas.Font.Color := clBlack;
  Canvas.Font.Style := [];
  Canvas.Font.Height := Round(Canvas.Font.Height * ScaleX);
  w := Canvas.TextWidth(Name);
  Canvas.Brush.Color := clWindow;
  Canvas.TextOut(r.Left - Round(w - 28 * ScaleX) div 2, Round(r.Bottom + 4 * ScaleY), Name);
end;


{ TfrxDialogControl }

constructor TfrxDialogControl.Create(AOwner: TComponent);
begin
  inherited;
  FBaseName := ClassName;
  Delete(FBaseName, Pos('Tfrx', FBaseName), 4);
  Delete(FBaseName, Pos('Control', FBaseName), 7);
  if AOwner is TfrxDialogControl then
    FCurrentPPI := TfrxDialogControl(AOwner).FCurrentPPI
  else if AOwner is TfrxDialogPage then
    FCurrentPPI := TfrxDialogPage(AOwner).FCurrentPPI
  else
    FCurrentPPI := Screen.PixelsPerInch;
end;

destructor TfrxDialogControl.Destroy;
begin
  inherited;
  ThreadSynchronize(DoDestroyControl);
end;

procedure TfrxDialogControl.InitControl(AControl: TControl);
begin
  FControl := AControl;
  ThreadSynchronize(DoInitControl);
end;

function TfrxDialogControl.IsAcceptAsChild(aParent: TfrxComponent): Boolean;
begin
  Result := ((aParent is TfrxDialogPage) or (aParent is TfrxDialogControl)) and (aParent.Parent <> Self);
end;

function TfrxDialogControl.IsAcceptControls: Boolean;
begin
  Result := csAcceptsControls in FControl.ControlStyle;
end;

function TfrxDialogControl.IsOwnerDraw: Boolean;
begin
  Result := False;
  if Assigned(Parent) and (Parent is TfrxDialogControl) then
    Result := TfrxDialogControl(Parent).IsOwnerDraw;
//  Result := Result or (csAcceptsFrxComponents in frComponentStyle);
end;

procedure TfrxDialogControl.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  Bmp: TBitmap;
  MemDC: HDC;
  OldBitmap: HBITMAP;
begin
  Bmp := TBitmap.Create;
  Bmp.Width := Round(Width * ScaleX);
  Bmp.Height := Round(Height * ScaleX);
  Bmp.Canvas.Brush.Color := clBtnFace;
  Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width + 1, Bmp.Height + 1));

  Canvas.Lock;
  try
    {$IFDEF FPC}
    //some widgetsets like qt and carbon does not like such constructs
    //so we simple draw everyting onto Bmp.Canvas
    if FControl is TWinControl then
{$IFDEF LCLGTK2}
     frxPaintWidget(TWinControl(FControl), Bmp.Canvas)
{$ELSE}
     TWinControl(FControl).PaintTo(Bmp.Canvas.Handle, 0, 0)
{$ENDIF}
    else
    begin
      FControl.Perform(WM_ERASEBKGND, Bmp.Canvas.Handle, MakeLParam(Round(Left), Round(Top)));
      FControl.Perform(WM_PAINT, Bmp.Canvas.Handle, MakeLParam(Round(Left), Round(Top)));
    end;
    {$ELSE}

    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, Bmp.Handle);
    if FControl is TWinControl then
      TWinControl(FControl).PaintTo(MemDC, 0, 0)
    else
    begin
      FControl.Perform(WM_ERASEBKGND, MemDC, 0);
      FControl.Perform(WM_PAINT, MemDC, 0);
    end;
    SelectObject(MemDC, OldBitmap);
    DeleteDC(MemDC);
    {$ENDIF}
  finally
    Canvas.Unlock;
  end;

  Canvas.Draw(Round(AbsLeft * ScaleX), Round(AbsTop * ScaleY), Bmp);
  Bmp.Free;
end;

function TfrxDialogControl.GetCaption: String;
begin
  Result := THackControl(FControl).Caption;
end;

function TfrxDialogControl.GetColor: TColor;
begin
  Result := THackControl(FControl).Color;
end;

function TfrxDialogControl.GetScaledControlHeight: Integer;
begin
  Result := Round(FControl.Height / (FCurrentPPI / frx_DefaultPPI));
end;

function TfrxDialogControl.GetScaledControlLeft: Integer;
begin
  Result := Round(FControl.Left / (FCurrentPPI / frx_DefaultPPI));
end;

function TfrxDialogControl.GetScaledControlTop: Integer;
begin
  Result := Round(FControl.Top / (FCurrentPPI / frx_DefaultPPI));
end;

function TfrxDialogControl.GetScaledControlWidth: Integer;
begin
  Result := Round(FControl.Width / (FCurrentPPI / frx_DefaultPPI));
end;

function TfrxDialogControl.GetEnabled: Boolean;
begin
  Result := FControl.Enabled;
end;

procedure TfrxDialogControl.SetLeft(Value: Extended);
begin
  inherited;
  FControl.Left := Round(Left * FCurrentPPI / frx_DefaultPPI);
  CorrectControlCoordinates;
end;

procedure TfrxDialogControl.SetTop(Value: Extended);
begin
  inherited;
  FControl.Top := Round(Top * FCurrentPPI / frx_DefaultPPI);
  CorrectControlCoordinates;
end;

procedure TfrxDialogControl.SetWidth(Value: Extended);
begin
  inherited;
  FControl.Width := Round(Width * FCurrentPPI / frx_DefaultPPI);
end;

procedure TfrxDialogControl.UpdateControlPPI(aNewPPI: Integer);
var
  i: Integer;
begin
  for i := 0 to Objects.Count - 1 do
    if TObject(Objects[i]) is TfrxDialogControl then
      TfrxDialogControl(Objects[i]).UpdateControlPPI(aNewPPI);

  FCurrentPPI := aNewPPI;
end;

procedure TfrxDialogControl.SetHeight(Value: Extended);
begin
  inherited;
  FControl.Height := Round(Height * FCurrentPPI / frx_DefaultPPI);
end;

procedure TfrxDialogControl.SetVisible(Value: Boolean);
begin
  inherited;
  FControl.Visible := Visible;
end;

procedure TfrxDialogControl.SetAnchors(const Value: TfrxAnchors);

  function frAnchorToControl(const Anchors: TfrxAnchors): TAnchors;
  begin
    Result := [];
    if fraLeft in Anchors then
      Result := [akLeft];
    if fraRight in Anchors then
      Result := Result + [akRight];
    if fraTop in Anchors then
      Result := Result + [akTop];
    if fraBottom in Anchors then
      Result := Result + [akBottom];
  end;
begin
  inherited;
  FControl.Anchors := frAnchorToControl(Anchors);
end;

procedure TfrxDialogControl.SetCaption(const Value: String);
begin
  THackControl(FControl).Caption := Value;
end;

procedure TfrxDialogControl.SetColor(const Value: TColor);
begin
  THackControl(FControl).Color := Value;
end;

procedure TfrxDialogControl.SetEnabled(const Value: Boolean);
begin
  FControl.Enabled := Value;
end;

function TfrxDialogControl.GetHint: String;
begin
  Result := FControl.Hint;
end;

procedure TfrxDialogControl.SetHint(const Value: String);
begin
  FControl.Hint := Value;
end;

function TfrxDialogControl.GetShowHint: Boolean;
begin
  Result := FControl.ShowHint;
end;

procedure TfrxDialogControl.SetShowHint(const Value: Boolean);
begin
  FControl.ShowHint := Value;
end;

function TfrxDialogControl.GetTabStop: Boolean;
begin
  Result := True;
  if FControl is TWinControl then
    Result := THackWinControl(FControl).TabStop;
end;

procedure TfrxDialogControl.SetTabStop(const Value: Boolean);
begin
  if FControl is TWinControl then
    THackWinControl(FControl).TabStop := Value;
end;

procedure TfrxDialogControl.CorrectControlCoordinates;
{$IFDEF FPC}
var
  pt: Tpoint;
{$ENDIF}
begin
{$IFDEF FPC}
  if Parent is TfrxDialogPage then Exit;
  pt := GetCoordinateOffset;
  if pt.x <> 0 then
    FControl.Left := Round(Left * FCurrentPPI / frx_DefaultPPI)- pt.x;
  if pt.y <> 0 then
    FControl.Top := Round(Top * FCurrentPPI / frx_DefaultPPI) - pt.y;
{$ENDIF}
end;

function TfrxDialogControl.GetCoordinateOffset: TPoint;
{$IFDEF FPC}
  var
    ParentF: TfrxComponent;
{$ENDIF}
begin
   Result := Point(0, 0);
{$IFDEF FPC}
   ParentF := Parent;
   while (ParentF <> nil) and not (ParentF is TfrxDialogPage) do
     ParentF := ParentF.Parent;
   if (FControl = nil) or not (ParentF is TfrxDialogPage) then Exit;
   if Assigned(FControl.Parent) and Assigned(FControl.Parent.Parent)
{$IFNDEF LCLGTK2} and FControl.Parent.IsVisible{$ENDIF} then
   begin
     Result := FControl.Parent.ClientToParent(Point(0, 0), FControl.Parent.Parent);
     Result.x := Result.x - FControl.Parent.Left;
     Result.y := Result.y - FControl.Parent.Top;
   end;
{$ENDIF}
end;

procedure TfrxDialogControl.FontChanged(Sender: TObject);
begin
  inherited;
  if FControl <> nil then
    THackControl(FControl).Font.Assign(Font);
end;

procedure TfrxDialogControl.SetParentFont(const Value: Boolean);
begin
  inherited;
  if FControl <> nil then
    THackControl(FControl).ParentFont := Value;
end;

procedure TfrxDialogControl.SetParent(AParent: TfrxComponent);
begin
  inherited;
  ThreadSynchronize(DoSetParent);
end;

procedure TfrxDialogControl.SetName(const AName: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := (csSetCaption in FControl.ControlStyle) and (Name = Caption) and
    not IsLoading;
  inherited SetName(AName);
  if ChangeText then
    Caption := AName;
end;

procedure TfrxDialogControl.DoDestroyControl;
begin
  FreeAndNil(FControl);
end;

procedure TfrxDialogControl.DoInitControl;
begin
  with THackControl(FControl) do
  begin
    OnClick := DoOnClick;
    OnDblClick := DoOnDblClick;
    OnMouseDown := DoOnMouseDown;
    OnMouseMove := DoOnMouseMove;
    OnMouseUp := DoOnMouseUp;
    OnMouseWheel := DoOnMouseWheel;
  end;
  if FControl is TWinControl then
    with THackWinControl(FControl) do
    begin
      OnEnter := DoOnEnter;
      OnExit := DoOnExit;
      OnKeyDown := DoOnKeyDown;
      OnKeyPress := DoOnKeyPress;
      OnKeyUp := DoOnKeyUp;
    end;
  SetParent(Parent);
end;

procedure TfrxDialogControl.DoOnClick(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnClick, True);
end;

procedure TfrxDialogControl.DoOnDblClick(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnDblClick, True);
end;

procedure TfrxDialogControl.DoOnEnter(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnEnter, True);
end;

procedure TfrxDialogControl.DoOnExit(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Self, FOnExit, True);
end;

procedure TfrxDialogControl.DoOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Self), Key, ShiftToByte(Shift)]);
  if (Report <> nil) and (FOnKeyDown <> '') then
  begin
    Report.DoParamEvent(FOnKeyDown, v, True);
    Key := v[1];
  end;
end;

procedure TfrxDialogControl.DoOnKeyPress(Sender: TObject; var Key: Char);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Self), Key]);
  if (Report <> nil) and (FOnKeyPress <> '') then
  begin
    Report.DoParamEvent(FOnKeyPress, v, True);
    if VarToStr(v[1]) <> '' then
      Key := VarToStr(v[1])[1]
    else
      Key := Chr(0);
  end;
end;

procedure TfrxDialogControl.DoOnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Self), Key, ShiftToByte(Shift)]);
  if (Report <> nil) and (FOnKeyUp <> '') then
  begin
    Report.DoParamEvent(FOnKeyUp, v, True);
    Key := v[1];
  end;
end;

procedure TfrxDialogControl.DoOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Self), Button, ShiftToByte(Shift), X, Y]);
  if Report <> nil then
    Report.DoParamEvent(FOnMouseDown, v, True);
end;

procedure TfrxDialogControl.DoOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  v: Variant;
begin
  if (Report <> nil) and (Hint <> '') and ShowHint then
  begin
    Report.SetProgressMessage(GetLongHint(Self.Hint), True);
  end;
  v := VarArrayOf([frInteger(Self), ShiftToByte(Shift), X, Y]);
  if Report <> nil then
    Report.DoParamEvent(FOnMouseMove, v, True);
end;

procedure TfrxDialogControl.DoOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Self), Button, ShiftToByte(Shift), X, Y]);
  if Report <> nil then
    Report.DoParamEvent(FOnMouseUp, v, True);
end;


procedure TfrxDialogControl.DoOnMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TfrxDialogControl.DoSetParent;
begin
  if FControl <> nil then
    if Parent is TfrxDialogControl then
      FControl.Parent := TWinControl(TfrxDialogControl(Parent).Control)
    else if Parent is TfrxDialogPage then
      FControl.Parent := TfrxDialogPage(Parent).DialogForm
    else
{$IFDEF FPC}
     if (Parent = nil) then
        FControl.Parent := nil
    else
{$ENDIF}
      FControl.Parent := frxParentForm;
  if Assigned(Parent) then
    CorrectControlCoordinates;
  if Assigned(FControl) and Assigned(FControl.Parent) and (FControl is TWinControl) then
    TWinControl(FControl).HandleNeeded;
end;

{ TfrxHyperlink }

procedure TfrxHyperlink.AssignVariables(aReport: TfrxReport);
var
  VarIdx, idx: Integer;
  VariablesList, ValuesList: TStringList;
  lVal: Variant;

  procedure SetVar(aVariable: String; aValue: Variant);
  begin
    VarIdx := aReport.Variables.IndexOf(aVariable);
    if VarIdx <> - 1 then
      aReport.Variables.Items[VarIdx].Value := aValue;
  end;

begin
  if Pos(FValuesSeparator, ReportVariable) <> 0 then
  begin
    VariablesList := TStringList.Create;
    ValuesList := TStringList.Create;
    try
      frxParseDilimitedText(VariablesList, ReportVariable, FValuesSeparator[1]);
      frxParseDilimitedText(ValuesList, VarToStr(FValue), FValuesSeparator[1]);
      if ValuesList.Count = 0 then
        lVal := FValue;
      for idx := 0 to VariablesList.Count - 1 do
      begin
        if ValuesList.Count > idx then
          lVal := ValuesList[idx];
        SetVar(VariablesList[idx], lVal);
      end;
    finally
      VariablesList.Free;
      ValuesList.Free;
    end;
  Exit;
  end;
  SetVar(ReportVariable, Value);
end;

constructor TfrxHyperlink.Create;
begin
  FValuesSeparator := ';';
end;

procedure TfrxHyperlink.Assign(Source: TPersistent);
begin
  if Source is TfrxHyperlink then
  begin
    FKind := (Source as TfrxHyperlink).Kind;
    FDetailReport := (Source as TfrxHyperlink).DetailReport;
    FDetailPage := (Source as TfrxHyperlink).DetailPage;
    FReportVariable := (Source as TfrxHyperlink).ReportVariable;
    FExpression := (Source as TfrxHyperlink).Expression;
    FValue := (Source as TfrxHyperlink).Value;
    FValuesSeparator := (Source as TfrxHyperlink).ValuesSeparator;
    FTabCaption := (Source as TfrxHyperlink).FTabCaption;
  end;
end;

function TfrxHyperlink.IsEmpty: Boolean;
begin
  Result := ((Kind in [hkURL, hkAnchor, hkPageNumber]) and (Value = '')) or
    ((Kind = hkDetailPage) and (DetailPage = '')) or
    ((Kind = hkDetailReport) and (DetailReport = '')) or (Kind = hkNone);
end;

function TfrxHyperlink.IsValuesSeparatorStored: Boolean;
begin
  Result := FValuesSeparator <> ';';
end;

function TfrxHyperlink.DetailIsEmpty: Boolean;
begin
  Result := (Kind = hkDetailReport) and (DetailReport = '') or
            (Kind = hkDetailPage) and (DetailPage = '');
end;

function TfrxHyperlink.Diff(ALink: TfrxHyperlink; const Add: String): String;
begin
  Result := '';

  if FKind <> ALink.FKind then
    Result := Result + ' ' + Add + '.Kind="' + frxValueToXML(FKind) + '"';
  if FDetailReport <> ALink.FDetailReport then
    Result := Result + ' ' + Add + '.DetailReport="' + frxStrToXML(FDetailReport) + '"';
  if FDetailPage <> ALink.FDetailPage then
    Result := Result + ' ' + Add + '.DetailPage="' + frxStrToXML(FDetailPage) + '"';
  if FReportVariable <> ALink.FReportVariable then
    Result := Result + ' ' + Add + '.ReportVariable="' +  frxStrToXML(FReportVariable) + '"';
  if FTabCaption <> ALink.FTabCaption then
    Result := Result + ' ' + Add + '.TabCaption="' + frxStrToXML(FTabCaption) + '"';
  if FValue <> ALink.FValue then
    Result := Result + ' ' + Add + '.Value="' + frxStrToXML(FValue) + '"';
  if FValuesSeparator <> ALink.FValuesSeparator then
    Result := Result + ' ' + Add + '.ValuesSeparator="' + frxStrToXML(FValuesSeparator) + '"';
end;


{ TfrxBrushFill }

constructor TfrxBrushFill.Create;
begin
  FBackColor := clNone;
  FForeColor := clBlack;
  FStyle := bsSolid;
end;

procedure TfrxBrushFill.Assign(Source: TPersistent);
begin
  if Source is TfrxBrushFill then
  begin
    FBackColor := TfrxBrushFill(Source).FBackColor;
    FForeColor := TfrxBrushFill(Source).FForeColor;
    FStyle := TfrxBrushFill(Source).FStyle;
  end;
end;

procedure TfrxBrushFill.Draw(ACanvas: TCanvas; X, Y, X1, Y1: Integer; ScaleX,
  ScaleY: Extended);
var
  br, oldbr: HBRUSH;
  OldPStyle: TPenStyle;
begin
  with ACanvas do
  begin
    Brush.Style := Style;
//    FFill.Draw(FCanvas, FX, FY, FX1, FY1, FScaleX, FScaleY);
    if FBackColor <> clNone then
    begin
      Brush.Color := FBackColor;
      Brush.Style := bsSolid;
      FillRect(Rect(X, Y, X1, Y1));
    end;
    if Style <> bsSolid then
    begin
      { Brush.Style := xxx does not work for some printers }
      { Brush.Style := xxx does not work for some printers }
      br := CreateHatchBrush(Integer(Style) - 2, ColorToRGB(FForeColor));
      oldbr := SelectObject(Handle, br);
      frxSetBkMode(ACanvas,TRANSPARENT);
      OldPStyle := Pen.Style;
      Pen.Style := psClear;
      Rectangle(X, Y, X1 + 1, Y1 + 1);
      SelectObject(Handle, oldbr);
      DeleteObject(br);
      Pen.Style := OldPStyle;
    end;
  end;
end;

function TfrxBrushFill.Diff(AFill: TfrxCustomFill; const Add: String): String;
var
  SourceFill: TfrxBrushFill;
begin
  Result := '';
  SourceFill := nil;
  if AFill is TfrxBrushFill then
    SourceFill := AFill as TfrxBrushFill;

  if (SourceFill = nil) or (FBackColor <> SourceFill.FBackColor) then
    Result := Result + ' ' + Add + '.BackColor="' + IntToStr(FBackColor) + '"';
  if (SourceFill = nil) or (FForeColor <> SourceFill.FForeColor) then
    Result := Result + ' ' + Add + '.ForeColor="' + IntToStr(FForeColor) + '"';
  if (SourceFill = nil) or (FStyle <> SourceFill.FStyle) then
    Result := Result + ' ' + Add + '.Style="' + frxValueToXML(FStyle) + '"';
end;


{ TfrxGradientFill }

constructor TfrxGradientFill.Create;
begin
  FStartColor := clWhite;
  FEndColor := clBlack;
  FGradientStyle := gsHorizontal;
end;

procedure TfrxGradientFill.Assign(Source: TPersistent);
begin
  if Source is TfrxGradientFill then
  begin
    FStartColor := TfrxGradientFill(Source).FStartColor;
    FEndColor := TfrxGradientFill(Source).FEndColor;
    FGradientStyle := TfrxGradientFill(Source).FGradientStyle;
  end;
end;

procedure TfrxGradientFill.Draw(ACanvas: TCanvas; X, Y, X1, Y1: Integer; ScaleX,
  ScaleY: Extended);
var
  FromR, FromG, FromB: Integer;
  DiffR, DiffG, DiffB: Integer;
  ox, oy, dx, dy: Integer;

  procedure DoHorizontal(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRect;
    I: Integer;
    R, G, B: Byte;
  begin
    ColorRect.Top := oy;
    ColorRect.Bottom := oy + dy;
    for I := 0 to 255 do
    begin
      ColorRect.Left := MulDiv (I, dx, 256) + ox;
      ColorRect.Right := MulDiv (I + 1, dx, 256) + ox;
      R := fr + MulDiv(I, dr, 255);
      G := fg + MulDiv(I, dg, 255);
      B := fb + MulDiv(I, db, 255);
      ACanvas.Brush.Color := RGB(R, G, B);
      ACanvas.FillRect(ColorRect);
    end;
  end;

  procedure DoVertical(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRect;
    I: Integer;
    R, G, B: Byte;
  begin
    ColorRect.Left := ox;
    ColorRect.Right := ox + dx;
    for I := 0 to 255 do
    begin
      ColorRect.Top := MulDiv (I, dy, 256) + oy;
      ColorRect.Bottom := MulDiv (I + 1, dy, 256) + oy;
      R := fr + MulDiv(I, dr, 255);
      G := fg + MulDiv(I, dg, 255);
      B := fb + MulDiv(I, db, 255);
      ACanvas.Brush.Color := RGB(R, G, B);
      ACanvas.FillRect(ColorRect);
    end;
  end;

  procedure DoElliptic(fr, fg, fb, dr, dg, db: Integer);
  var
    I: Integer;
    R, G, B: Byte;
    Pw, Ph: Double;
    x1, y1, x2, y2: Double;
    rgn: HRGN;
  begin
    rgn := CreateRectRgn(0, 0, MaxInt, MaxInt);
    GetClipRgn(ACanvas.Handle, rgn);
    IntersectClipRect(ACanvas.Handle, ox, oy, ox + dx, oy + dy);
    ACanvas.Pen.Style := psClear;

    x1 := ox - (dx / 4);
    x2 := ox + dx + (dx / 4);
    y1 := oy - (dy / 4);
    y2 := oy + dy + (dy / 4);
    Pw := ((dx / 4) + (dx / 2)) / 155;
    Ph := ((dy / 4) + (dy / 2)) / 155;
    for I := 0 to 155 do
    begin
      x1 := x1 + Pw;
      x2 := X2 - Pw;
      y1 := y1 + Ph;
      y2 := y2 - Ph;
      R := fr + MulDiv(I, dr, 155);
      G := fg + MulDiv(I, dg, 155);
      B := fb + MulDiv(I, db, 155);
      ACanvas.Brush.Color := R or (G shl 8) or (b shl 16);
      ACanvas.Ellipse(Trunc(x1), Trunc(y1), Trunc(x2), Trunc(y2));
    end;

    SelectClipRgn(ACanvas.Handle, rgn);
    DeleteObject(rgn);
  end;

  procedure DoRectangle(fr, fg, fb, dr, dg, db: Integer);
  var
    I: Integer;
    R, G, B: Byte;
    Pw, Ph: Real;
    x1, y1, x2, y2: Double;
  begin
    ACanvas.Pen.Style := psClear;
    ACanvas.Pen.Mode := pmCopy;
    x1 := 0 + ox;
    x2 := ox + dx;
    y1 := 0 + oy;
    y2 := oy + dy;
    Pw := (dx / 2) / 255;
    Ph := (dy / 2) / 255;
    for I := 0 to 255 do
    begin
      x1 := x1 + Pw;
      x2 := X2 - Pw;
      y1 := y1 + Ph;
      y2 := y2 - Ph;
      R := fr + MulDiv(I, dr, 255);
      G := fg + MulDiv(I, dg, 255);
      B := fb + MulDiv(I, db, 255);
      ACanvas.Brush.Color := RGB(R, G, B);
      ACanvas.FillRect(Rect(Trunc(x1), Trunc(y1), Trunc(x2), Trunc(y2)));
    end;
    ACanvas.Pen.Style := psSolid;
  end;

  procedure DoVertCenter(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRect;
    I: Integer;
    R, G, B: Byte;
    Haf: Integer;
  begin
    Haf := dy Div 2;
    ColorRect.Left := 0 + ox;
    ColorRect.Right := ox + dx;
    for I := 0 to Haf do
    begin
      ColorRect.Top := MulDiv(I, Haf, Haf) + oy;
      ColorRect.Bottom := MulDiv(I + 1, Haf, Haf) + oy;
      R := fr + MulDiv(I, dr, Haf);
      G := fg + MulDiv(I, dg, Haf);
      B := fb + MulDiv(I, db, Haf);
      ACanvas.Brush.Color := RGB(R, G, B);
      ACanvas.FillRect(ColorRect);
      ColorRect.Top := dy - (MulDiv (I, Haf, Haf)) + oy;
      ColorRect.Bottom := dy - (MulDiv (I + 1, Haf, Haf)) + oy;
      ACanvas.FillRect(ColorRect);
    end;
  end;

  procedure DoHorizCenter(fr, fg, fb, dr, dg, db: Integer);
  var
    ColorRect: TRect;
    I: Integer;
    R, G, B: Byte;
    Haf: Integer;
  begin
    Haf := dx Div 2;
    ColorRect.Top := 0 + oy;
    ColorRect.Bottom := oy + dy;
    for I := 0 to Haf do
    begin
      ColorRect.Left := MulDiv(I, Haf, Haf) + ox;
      ColorRect.Right := MulDiv(I + 1, Haf, Haf) + ox;
      R := fr + MulDiv(I, dr, Haf);
      G := fg + MulDiv(I, dg, Haf);
      B := fb + MulDiv(I, db, Haf);
      ACanvas.Brush.Color := RGB(R, G, B);
      ACanvas.FillRect(ColorRect);
      ColorRect.Left := dx - (MulDiv (I, Haf, Haf)) + ox;
      ColorRect.Right := dx - (MulDiv (I + 1, Haf, Haf)) + ox;
      ACanvas.FillRect(ColorRect);
    end;
  end;

begin
  ox := X;
  oy := Y;
  dx := X1 - X;
  dy := Y1 - Y;
  FromR := FStartColor and $000000ff;
  FromG := (FStartColor shr 8) and $000000ff;
  FromB := (FStartColor shr 16) and $000000ff;
  DiffR := (FEndColor and $000000ff) - FromR;
  DiffG := ((FEndColor shr 8) and $000000ff) - FromG;
  DiffB := ((FEndColor shr 16) and $000000ff) - FromB;

  case FGradientStyle of
    gsHorizontal:
      DoHorizontal(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsVertical:
      DoVertical(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsElliptic:
      DoElliptic(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsRectangle:
      DoRectangle(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsVertCenter:
      DoVertCenter(FromR, FromG, FromB, DiffR, DiffG, DiffB);
    gsHorizCenter:
      DoHorizCenter(FromR, FromG, FromB, DiffR, DiffG, DiffB);
  end;
end;

function TfrxGradientFill.GetColor: TColor;
var
  R, G, B: Byte;
  FromR, FromG, FromB: Integer;
  DiffR, DiffG, DiffB: Integer;
begin
  FromR := FStartColor and $000000ff;
  FromG := (FStartColor shr 8) and $000000ff;
  FromB := (FStartColor shr 16) and $000000ff;
  DiffR := (FEndColor and $000000ff) - FromR;
  DiffG := ((FEndColor shr 8) and $000000ff) - FromG;
  DiffB := ((FEndColor shr 16) and $000000ff) - FromB;
  R := FromR + MulDiv(127, DiffR, 255);
  G := FromG + MulDiv(127, DiffG, 255);
  B := FromB + MulDiv(127, DiffB, 255);
  {$IFDEF FPC}
  Result := RGBToColor(R, G, B);
  {$ELSE}
  Result := RGB(R, G, B);
  {$ENDIF}
end;

function TfrxGradientFill.Diff(AFill: TfrxCustomFill; const Add: String): String;
var
  SourceFill: TfrxGradientFill;
begin
  Result := '';
  SourceFill := nil;
  if AFill is TfrxGradientFill then
    SourceFill := AFill as TfrxGradientFill;

  if (SourceFill = nil) or (FStartColor <> SourceFill.FStartColor) then
    Result := Result + ' ' + Add + '.StartColor="' + IntToStr(FStartColor) + '"';
  if (SourceFill = nil) or (FEndColor <> SourceFill.FEndColor) then
    Result := Result + ' ' + Add + '.EndColor="' + IntToStr(FEndColor) + '"';
  if (SourceFill = nil) or (FGradientStyle <> SourceFill.FGradientStyle) then
    Result := Result + ' ' + Add + '.GradientStyle="' + frxValueToXML(FGradientStyle) + '"';
end;


{ TfrxGlassFill }

constructor TfrxGlassFill.Create;
begin
  FHatch := False;
  FColor := clGray;
  FBlend := 0.5;
  FOrient := foHorizontal;
end;

procedure TfrxGlassFill.Assign(Source: TPersistent);
begin
  if Source is TfrxGlassFill then
  begin
    FColor := TfrxGlassFill(Source).FColor;
    FBlend := TfrxGlassFill(Source).FBlend;
    FHatch := TfrxGlassFill(Source).FHatch;
    FOrient := TfrxGlassFill(Source).FOrient
  end;
end;

function TfrxGlassFill.BlendColor: TColor;
var
  cR, cG, cB, AColor : Integer;
begin
  AColor := ColorToRGB(FColor);
  cR := (AColor and $000000ff);
  cR := (cR + Round((255 - cR) * FBlend));
  cG := ((AColor shr 8) and $000000ff);
  cG := (cG + Round((255 - cG) * FBlend));
  cB := ((AColor shr 16) and $000000ff);
  cB := (cB + Round((255 - cB) * FBlend));
  if cR > 255 then cR := 255;
  if cG > 255 then cG := 255;
  if cB > 255 then cB := 255;
  Result := ((cB and $000000ff) shl 16) or ((cG and $000000ff) shl 8) or cR;
end;

procedure TfrxGlassFill.Draw(ACanvas: TCanvas; X, Y, X1, Y1: Integer;
  ScaleX, ScaleY: Extended);
var
  OldColor: TColor;
  br, oldbr: HBRUSH;
  OldBStyle: TBrushStyle;
  OldPStyle: TPenStyle;
begin
  with ACanvas do
  begin
    if FColor <> clNone then
    begin
      OldColor := Brush.Color;
      OldBStyle := Brush.Style;
      Brush.Color := FColor;
      Brush.Style := bsSolid;
      FillRect(Rect(X, Y, X1, Y1));
      Brush.Color := BlendColor;
      Brush.Style := bsSolid;
      case FOrient of
        foHorizontal:
          FillRect(Rect(X, Y, X1, Y1 - (Y1 - Y)  div 2));
        foHorizontalMirror:
          FillRect(Rect(X, Y + (Y1 - Y)  div 2, X1, Y1));
        foVerticalMirror:
          FillRect(Rect(X + (X1 - X)  div 2, Y, X1, Y1));
        foVertical:
          FillRect(Rect(X, Y, X1 - (X1 - X) div 2, Y1));
      end;
      Brush.Color := OldColor;
      Brush.Style := OldBStyle;
      if FHatch then
      begin
        br := CreateHatchBrush(HS_BDIAGONAL, HatchColor);
        oldbr := SelectObject(Handle, br);
        frxSetBkMode(ACanvas,TRANSPARENT);
        OldPStyle := Pen.Style;
        Pen.Style := psClear;
        Rectangle(X, Y, X1 + 1, Y1 + 1);
        SelectObject(Handle, oldbr);
        DeleteObject(br);
        Pen.Style := OldPStyle;
      end;
    end;
  end;
end;

function TfrxGlassFill.GetColor: TColor;
begin
  Result := Color;
end;

function TfrxGlassFill.Diff(AFill: TfrxCustomFill; const Add: String): String;
var
  SourceFill: TfrxGlassFill;
begin
  Result := '';
  SourceFill := nil;
  if AFill is TfrxGlassFill then
    SourceFill := AFill as TfrxGlassFill;

  if (SourceFill = nil) or (FColor <> SourceFill.FColor) then
    Result := Result + ' ' + Add + '.Color="' + IntToStr(FColor) + '"';
  if (SourceFill = nil) or (FBlend <> SourceFill.FBlend) then
    Result := Result + ' ' + Add + '.Blend="' + FloatToStr(FBlend) + '"';
  if (SourceFill = nil) or (FHatch <> SourceFill.FHatch) then
    Result := Result + ' ' + Add + '.Hatch="' + frxValueToXML(FHatch) + '"';
  if (SourceFill = nil) or (FOrient <> SourceFill.FOrient) then
    Result := Result + ' ' + Add + '.Orientation="' + frxValueToXML(FOrient) + '"';
end;

function TfrxGlassFill.HatchColor: TColor;
begin
  Result := BlendColor - $060606;
end;

{ TfrxFrameLine }

constructor TfrxFrameLine.Create(AFrame: TfrxFrame);
begin
  FColor := clBlack;
  FStyle := fsSolid;
  FWidth := 1;
  FFrame := AFrame;
end;

procedure TfrxFrameLine.Assign(Source: TPersistent);
begin
  if Source is TfrxFrameLine then
  begin
    FColor := TfrxFrameLine(Source).Color;
    FStyle := TfrxFrameLine(Source).Style;
    FWidth := TfrxFrameLine(Source).Width;
  end;
end;

function TfrxFrameLine.IsColorStored: Boolean;
begin
  Result := FColor <> FFrame.Color;
end;

function TfrxFrameLine.IsStyleStored: Boolean;
begin
  Result := FStyle <> FFrame.Style;
end;

function TfrxFrameLine.IsWidthStored: Boolean;
begin
  Result := FWidth <> FFrame.Width;
end;

function TfrxFrameLine.Diff(ALine: TfrxFrameLine; const LineName: String;
  ColorChanged, StyleChanged, WidthChanged: Boolean): String;
begin
  Result := '';

  if (ColorChanged and IsColorStored) or (not ColorChanged and (FColor <> ALine.Color)) then
    Result := Result + ' ' + LineName + '.Color="' + IntToStr(FColor) + '"';
  if (StyleChanged and IsStyleStored) or (not StyleChanged and (FStyle <> ALine.Style)) then
    Result := Result + ' ' + LineName + '.Style="' + frxValueToXML(FStyle) + '"';
  if (WidthChanged and IsWidthStored) or (not WidthChanged and frxFloatDiff(FWidth, ALine.Width)) then
    Result := Result + ' ' + LineName + '.Width="' + FloatToStr(FWidth) + '"';
end;


{ TfrxFrame }

constructor TfrxFrame.Create;
begin
  FColor := clBlack;
  FShadowColor := clBlack;
  FShadowWidth := 4;
  FStyle := fsSolid;
  FTyp := [];
  FWidth := 1;

  FLeftLine := TfrxFrameLine.Create(Self);
  FTopLine := TfrxFrameLine.Create(Self);
  FRightLine := TfrxFrameLine.Create(Self);
  FBottomLine := TfrxFrameLine.Create(Self);
end;

destructor TfrxFrame.Destroy;
begin
  FLeftLine.Free;
  FTopLine.Free;
  FRightLine.Free;
  FBottomLine.Free;
  inherited;
end;

procedure TfrxFrame.Assign(Source: TPersistent);
begin
  if Source is TfrxFrame then
  begin
    FColor := TfrxFrame(Source).Color;
    FDropShadow := TfrxFrame(Source).DropShadow;
    FShadowColor := TfrxFrame(Source).ShadowColor;
    FShadowWidth := TfrxFrame(Source).ShadowWidth;
    FStyle := TfrxFrame(Source).Style;
    FTyp := TfrxFrame(Source).Typ;
    FWidth := TfrxFrame(Source).Width;

    FLeftLine.Assign(TfrxFrame(Source).LeftLine);
    FTopLine.Assign(TfrxFrame(Source).TopLine);
    FRightLine.Assign(TfrxFrame(Source).RightLine);
    FBottomLine.Assign(TfrxFrame(Source).BottomLine);
  end;
end;

function TfrxFrame.IsShadowWidthStored: Boolean;
begin
  Result := FShadowWidth <> 4;
end;

function TfrxFrame.IsTypStored: Boolean;
begin
  Result := True;//FTyp <> [];
end;

function TfrxFrame.IsWidthStored: Boolean;
begin
  Result := FWidth <> 1;
end;

procedure TfrxFrame.SetBottomLine(const Value: TfrxFrameLine);
begin
  FBottomLine.Assign(Value);
end;

procedure TfrxFrame.SetLeftLine(const Value: TfrxFrameLine);
begin
  FLeftLine.Assign(Value);
end;

procedure TfrxFrame.SetRightLine(const Value: TfrxFrameLine);
begin
  FRightLine.Assign(Value);
end;

procedure TfrxFrame.SetTopLine(const Value: TfrxFrameLine);
begin
  FTopLine.Assign(Value);
end;

procedure TfrxFrame.SetColor(const Value: TColor);
begin
  FColor := Value;
  FLeftLine.Color := Value;
  FTopLine.Color := Value;
  FRightLine.Color := Value;
  FBottomLine.Color := Value;
end;

procedure TfrxFrame.SetStyle(const Value: TfrxFrameStyle);
begin
  FStyle := Value;
  FLeftLine.Style := Value;
  FTopLine.Style := Value;
  FRightLine.Style := Value;
  FBottomLine.Style := Value;
end;

procedure TfrxFrame.SetWidth(const Value: Extended);
begin
  FWidth := Value;
  FLeftLine.Width := Value;
  FTopLine.Width := Value;
  FRightLine.Width := Value;
  FBottomLine.Width := Value;
end;

function TfrxFrame.Diff(AFrame: TfrxFrame): String;
var
  i: Integer;
  ColorChanged, StyleChanged, WidthChanged: Boolean;
begin
  Result := '';

  ColorChanged := FColor <> AFrame.Color;
  if ColorChanged then
    Result := Result + ' Frame.Color="' + IntToStr(FColor) + '"';
  if FDropShadow <> AFrame.DropShadow then
    Result := Result + ' Frame.DropShadow="' + frxValueToXML(FDropShadow) + '"';
  if FShadowColor <> AFrame.ShadowColor then
    Result := Result + ' Frame.ShadowColor="' + IntToStr(FShadowColor) + '"';
  if frxFloatDiff(FShadowWidth, AFrame.ShadowWidth) then
    Result := Result + ' Frame.ShadowWidth="' + FloatToStr(FShadowWidth) + '"';
  StyleChanged := FStyle <> AFrame.Style;
  if StyleChanged then
    Result := Result + ' Frame.Style="' + frxValueToXML(FStyle) + '"';
  if FTyp <> AFrame.Typ then
  begin
    i := 0;
    if ftLeft in FTyp then i := i or 1;
    if ftRight in FTyp then i := i or 2;
    if ftTop in FTyp then i := i or 4;
    if ftBottom in FTyp then i := i or 8;
    Result := Result + ' Frame.Typ="' + IntToStr(i) + '"';
  end;
  WidthChanged := frxFloatDiff(FWidth, AFrame.Width);
  if WidthChanged then
    Result := Result + ' Frame.Width="' + FloatToStr(FWidth) + '"';

  Result := Result + FLeftLine.Diff(AFrame.LeftLine, 'Frame.LeftLine',
    ColorChanged, StyleChanged, WidthChanged);
  Result := Result + FTopLine.Diff(AFrame.TopLine, 'Frame.TopLine',
    ColorChanged, StyleChanged, WidthChanged);
  Result := Result + FRightLine.Diff(AFrame.RightLine, 'Frame.RightLine',
    ColorChanged, StyleChanged, WidthChanged);
  Result := Result + FBottomLine.Diff(AFrame.BottomLine, 'Frame.BottomLine',
    ColorChanged, StyleChanged, WidthChanged);
end;

procedure TfrxFrame.Draw(Canvas: TCanvas; FX, FY, FX1, FY1: Integer; ScaleX, ScaleY: Extended);
var
  d: Integer;

  procedure DrawLine(x, y, x1, y1, w: Integer);
  var
    i, d: Integer;
  begin
    with Canvas do
    begin
      if w = 0 then
        w := 1;
      if w mod 2 = 0 then
        d := 1 else
        d := 0;

      for i := (-w div 2) to (w div 2 - d) do
      begin
        if Abs(x1 - x) > Abs(y1 - y) then
        begin
          MoveTo(x, y + i);
          LineTo(x1, y1 + i);
        end
        else
        begin
          MoveTo(x + i, y);
          LineTo(x1 + i, y1);
        end;
      end;
    end;
  end;

  procedure Line1(x, y, x1, y1: Integer);
  begin
    Canvas.MoveTo(x, y);
    Canvas.LineTo(x1, y1);
  end;

  procedure LineInt(x, y, x1, y1: Integer; Line: TfrxFrameLine;
    Typ: TfrxFrameType; gap1, gap2: Boolean);
  var
    g1, g2, g3, g4, fw: Integer;
    LG: {$IFDEF FPC}TLogBrush{$ELSE}LOGBRUSH{$ENDIF};
    hP: HPEN;
    PenStyle: array[0..1] of DWORD;
    PenSt: Cardinal;
    OldPen: HGDIOBJ;

    {back compatibility for win9x/ME}
    procedure DrawDotLine(x, y, x1, y1, w: Integer; Rounded:Boolean);
    var
      idX, idY, mWidth, mHeight, CpMode: Integer;
      Bcl: TColor;
      TmpBit: TBitmap;
    begin
      if w = 0 then
        w := 1;
      mHeight := y1 - y;
      mWidth := x1 - x;
      if mWidth = 0 then
        mWidth := w;
      if mHeight = 0 then
        mHeight := w;

      TmpBit := TBitmap.Create;
      TmpBit.Width := mWidth;
      TmpBit.Height := mHeight;
      TmpBit.Canvas.Brush.Color := clBlack;
      TmpBit.Canvas.Pen.Color := clBlack;
      Bcl := Canvas.Brush.Color;
      Canvas.Brush.Color := Line.Color;
      idX := 0;

      while (idX <= mWidth) do
      begin
        idY := 0;
        while (idY <= mHeight) do
        begin
          if w > 1 then
            if Rounded then
              TmpBit.Canvas.Ellipse(idX, idY, idX + w, idY + w)
            else
              TmpBit.Canvas.Rectangle(idX, idY, idX + w, idY + w)
          else
            TmpBit.Canvas.Pixels[idX, idY] := clBlack;
          idY := idY + w * 2;
        end;
        idX := idX +  w * 2;
      end;

      CpMode := Canvas.CopyMode;
      Canvas.CopyMode := $B8074A; {this mode copy all black pixels from source to dest with current brush color}
      Canvas.Draw(x - (w div 2), y - (w div 2), TmpBit);
      {restore canvas state}
      Canvas.Brush.Color := Bcl;
      Canvas.CopyMode := CpMode;
      TmpBit.Free;
    end;

  begin
    fw := Round(Line.Width * ScaleX);

    if Line.Style in [fsSolid, fsDouble] then
    begin
      if gap1 then g1 := 0 else g1 := 1;
      if gap2 then g2 := 0 else g2 := 1;

      if Typ in [ftTop, ftBottom] then
      begin
        x := x + (fw * g1 div 2);
        x1 := x1 - (fw * g2 div 2);
      end
      else
      begin
        y := y + (fw * g1 div 2);
        y1 := y1 - (fw * g2 div 2);
      end;
    end;

    if Line.Style = fsSolid then
      begin
        LG.lbStyle := BS_SOLID;
        LG.lbColor := line.Color;
        LG.lbHatch := 0;
        PenSt := PS_GEOMETRIC or PS_ENDCAP_SQUARE;
        hP := ExtCreatePen(PenSt, fw, LG, 0, nil);
        if hP <> 0 then
        begin
          OldPen := SelectObject(Canvas.Handle, Hp);
          Line1(x, y, x1, y1);
          SelectObject(Canvas.Handle, OldPen);
          DeleteObject(hP);
        end
        else Line1(x, y, x1, y1)
      end
    else if Line.Style = fsDouble then
    begin
      if gap1 then
        g1 := fw else
        g1 := 0;
      if gap2 then
        g2 := fw else
        g2 := 0;
      g3 := -g1;
      g4 := -g2;

      if Typ in [ftLeft, ftTop] then
      begin
        g1 := -g1;
        g2 := -g2;
        g3 := -g3;
        g4 := -g4;
      end;

      if x = x1 then
        Line1(x - fw, y + g1, x1 - fw, y1 - g2) else
        Line1(x + g1, y - fw, x1 - g2, y1 - fw);
      Canvas.Pen.Color := Line.Color;
      if x = x1 then
        Line1(x + fw, y + g3, x1 + fw, y1 - g4) else
        Line1(x + g3, y + fw, x1 - g4, y1 + fw);
    end
    {real round dot line / Square dot line}
    else if Line.Style in [fsAltDot, fsSquare] then
    begin
      LG.lbStyle := BS_SOLID;
      LG.lbColor := line.Color;
      LG.lbHatch := 0;
      PenSt := PS_GEOMETRIC or PS_USERSTYLE;
      if fw <= 1 then
      begin
        PenStyle[0] := 1;
        PenStyle[1] := 1;
        PenSt := PenSt or PS_ENDCAP_FLAT;
      end
      else if Line.Style = fsSquare then
      begin
        PenStyle[0] := fw;
        PenStyle[1] := fw;
        PenSt := PenSt or PS_ENDCAP_FLAT;
      end
      else
      begin
        PenStyle[0] := 0;
        PenStyle[1] := fw * 2;
        PenSt := PenSt or PS_ENDCAP_ROUND;
      end;

      hP := ExtCreatePen(PenSt, fw, LG, 2, @PenStyle);
      if hP = 0 then
        DrawDotLine(x, y, x1, y1, fw, Line.Style = fsAltDot)
      else
      begin
        OldPen := SelectObject(Canvas.Handle, Hp);
        Line1(x, y, x1, y1);
        SelectObject(Canvas.Handle, OldPen);
        DeleteObject(hP);
      end;
    end
    else
      DrawLine(x, y, x1, y1, fw);
  end;

  procedure SetPen(ALine: TfrxFrameLine);
  begin
    with Canvas do
    begin
      Pen.Color := ALine.Color;
      if ALine.Style in [fsSolid, fsDouble] then
      begin
        Pen.Style := psSolid;
        Pen.Width := Round(ALine.Width * ScaleX);
      end
      else
      begin
        Pen.Style := TPenStyle(ALine.Style);
        Pen.Width := 1;
      end;
    end;
  end;

begin
  if DropShadow then
    with Canvas do
    begin
      Pen.Style := psSolid;
      Pen.Color := ShadowColor;
      d := Round(ShadowWidth * ScaleX);
      DrawLine(FX1 + d div 2, FY + d, FX1 + d div 2, FY1, d);
      d := Round(ShadowWidth * ScaleY);
      DrawLine(FX + d, FY1 + d div 2, FX1 + d, FY1 + d div 2, d);
    end;

  if (Typ <> []) and (Color <> clNone) and (Width <> 0) then
    with Canvas do
    begin
      Brush.Style := bsSolid;
      if Style <> fsSolid then
        Brush.Style := bsClear;
      if ftLeft in Typ then
      begin
        SetPen(LeftLine);
        if (Pen.Width = 2) and (Style <> fsSolid) then
          d := 1 else
          d := 0;
        LineInt(FX, FY - d, FX, FY1, LeftLine, ftLeft, ftTop in Typ, ftBottom in Typ);
      end;
      if ftRight in Typ then
      begin
        SetPen(RightLine);
        LineInt(FX1, FY, FX1, FY1, RightLine, ftRight, ftTop in Typ, ftBottom in Typ);
      end;
      if ftTop in Typ then
      begin
        SetPen(TopLine);
        LineInt(FX, FY, FX1, FY, TopLine, ftTop, ftLeft in Typ, ftRight in Typ);
      end;
      if ftBottom in Typ then
      begin
        SetPen(BottomLine);
        if (Pen.Width = 1) and (Style <> fsSolid) then
          d := 1 else
          d := 0;
        LineInt(FX, FY1, FX1 + d, FY1, BottomLine, ftBottom, ftLeft in Typ, ftRight in Typ);
      end;
    end;
end;


{ TfrxView }

constructor TfrxView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frComponentStyle := frComponentStyle + [csDefaultDiff];
  FAlign := baNone;
  FAllowVectorExport := True;
  FFrame := TfrxFrame.Create;
  FFill := TfrxBrushFill.Create;
  FHyperlink := TfrxHyperlink.Create;
  FProcessing := TfrxObjectProcessing.Create;
  FShiftMode := smAlways;
  FPlainText := False;
  FVisibility := [vsPreview, vsExport, vsPrint];
  FDrawAsMask := False;
  FObjAsMetafile := False;
  FDrawFillOnMetaFile := False;
  FScaleX := 1;
  FScaleY := 1;
  FVC := nil;
end;

destructor TfrxView.Destroy;
begin
  FFrame.Free;
  FHyperlink.Free;
  FFill.Free;
  FreeAndNil(FProcessing);
  inherited;
end;

procedure TfrxView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDataSet) then
    FDataSet := nil;
end;

procedure TfrxView.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxView.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxView.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

procedure TfrxView.SetFrame(const Value: TfrxFrame);
begin
  FFrame.Assign(Value);
end;

procedure TfrxView.SetHyperLink(const Value: TfrxHyperlink);
begin
  FHyperlink.Assign(Value);
end;

procedure TfrxView.BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  FCanvas := Canvas;
  FScaleX := ScaleX;
  FScaleY := ScaleY;
  FOffsetX := OffsetX;
  FOffsetY := OffsetY;
  FX := Round(AbsLeft * ScaleX + OffsetX);
  FY := Round(AbsTop * ScaleY + OffsetY);
  FX1 := Round((AbsLeft + Width) * ScaleX + OffsetX);
  FY1 := Round((AbsTop + Height) * ScaleY + OffsetY);

  if Frame.DropShadow then
  begin
    FX1 := FX1 - Round(Frame.ShadowWidth * ScaleX);
    FY1 := FY1 - Round(Frame.ShadowWidth * ScaleY);
  end;

  FDX := FX1 - FX;
  FDY := FY1 - FY;
  FFrameWidth := Round(Frame.Width * ScaleX);
end;

procedure TfrxView.DrawBackground;
var
  dX, dY, dX1, dY1, wx1, wx2, wy1, wy2: Integer;
begin
  if FObjAsMetafile and not FDrawFillOnMetaFile then Exit;
  dX := FX;
  dY := FY;
  dX1 := FX1;
  dY1 := FY1;

  wx1 := Round((Frame.Width * FScaleX) / 2);
  wx2 := Round(Frame.Width * FScaleX / 2) + Round(Frame.Width * FScaleX) mod 2;
  wy1 := Round((Frame.Width * FScaleY) / 2);
  wy2 := Round(Frame.Width * FScaleY / 2) + Round(Frame.Width * FScaleY) mod 2;
  if ftLeft in Frame.Typ then
    Dec(dX, wx1);
  if ftRight in Frame.Typ then
    Inc(dX1, wx2);
  if ftTop in Frame.Typ then
    Dec(dY, wy1);
  if ftBottom in Frame.Typ then
    Inc(dY1, wy2);

  FFill.Draw(FCanvas, dX, dY, dX1, dY1, FScaleX, FScaleY);
end;

procedure TfrxView.DrawLine(x, y, x1, y1, w: Integer);
var
  i, d: Integer;
begin
  with FCanvas do
  begin
    if w = 0 then
      w := 1;
    if w mod 2 = 0 then
      d := 1 else
      d := 0;

    for i := (-w div 2) to (w div 2 - d) do
    begin
      if Abs(x1 - x) > Abs(y1 - y) then
      begin
        MoveTo(x, y + i);
        LineTo(x1, y1 + i);
      end
      else
      begin
        MoveTo(x + i, y);
        LineTo(x1 + i, y1);
      end;
    end;
  end;
end;

procedure TfrxView.DrawFrame;
begin
  if not FObjAsMetafile then
    FFrame.Draw(FCanvas, FX, FY, FX1, FY1, FScaleX, FScaleY);
  if Assigned(FComponentEditors) then
    FComponentEditors.DrawCustomEditor(FCanvas, Rect(FX, FY, FX1, FY1));
end;

procedure TfrxView.DrawFrameEdges;
begin
  if IsDesigning and not (Page is TfrxDataPage) and (Frame.Typ <> [ftLeft, ftRight, ftTop, ftBottom]) then
    with FCanvas do
    begin
      Pen.Style := psSolid;
      Pen.Color := clBlack;
      Pen.Width := 1;
      DrawLine(FX, FY + 3, FX, FY, 1);
      DrawLine(FX, FY, FX + 4, FY, 1);
      DrawLine(FX, FY1 - 3, FX, FY1, 1);
      DrawLine(FX, FY1, FX + 4, FY1, 1);
      DrawLine(FX1 - 3, FY, FX1, FY, 1);
      DrawLine(FX1, FY, FX1, FY + 4, 1);
      DrawLine(FX1 - 3, FY1, FX1, FY1, 1);
      DrawLine(FX1, FY1, FX1, FY1 - 4, 1);
    end;
end;

procedure TfrxView.DrawHighlight(Canvas: TCanvas; ScaleX, ScaleY,
  OffsetX, OffsetY: Extended; hlColor: TColor);
var
  DropRect: TRect;
  s: String;
begin
  DropRect := Rect(FX, FY, FX1, FY1);
  FCanvas.Pen.Color := clRed;
  Canvas.Pen.Style := psDash;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Width := 1;
  if csDesigning in ComponentState then
    Canvas.Rectangle(DropRect.Left, DropRect.Top, DropRect.Right,
      DropRect.Bottom)
  else
    TransparentFillRect(FCanvas.Handle, DropRect.Left + 1, DropRect.Top + 1, DropRect.Right - 1, DropRect.Bottom - 1, clSkyBlue);

  if not IsDesigning then Exit;
  if Height < Width then
    DropRect.Left := DropRect.Right - Round(Height * FScaleY)
  else
    DropRect.Left := DropRect.Right - Round(Width * FScaleX);
  // TODO: drag and drip image
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clGray;
  Canvas.Pen.Style := psDot;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Width := 1;
  // Canvas.FillRect(DropRect);
  Canvas.Rectangle(DropRect.Left, DropRect.Top + 2, DropRect.Right - 2,
    DropRect.Bottom - 2);
  if IndexTag <> 0 then
  begin
    s := IntToStr(IndexTag);
    Canvas.Font.Color := clRed;
    Canvas.TextRect(DropRect, 0, 0, s);
  end;
end;

procedure TfrxView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DrawBackground;
  DrawFrameEdges;
  DrawFrame;
  Inherited;
end;

procedure TfrxView.DrawClipped(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
end;

function TfrxView.Diff(AComponent: TfrxComponent): String;
var
  v: TfrxView;
  vs: Integer;
begin
  Result := inherited Diff(AComponent);
  v := TfrxView(AComponent);

  if FAlign <> v.FAlign then
    Result := Result + ' Align="' + frxValueToXML(FAlign) + '"';
  Result := Result + FFrame.Diff(v.FFrame);
  if Cursor <> v.Cursor then
    Result := Result + ' Cursor="' + frxValueToXML(Cursor) + '"';
  if FVisibility <> v.FVisibility then
  begin
    vs := 0;
    if vsPreview in FVisibility then vs := 1;
    if vsExport in FVisibility then vs := vs or 2;
    if vsPrint in FVisibility then vs := vs or 4;
    Result := Result + ' Visibility="' + IntToStr(vs) + '"';
  end;
  if TagStr <> v.TagStr then
    Result := Result + ' TagStr="' + frxStrToXML(TagStr) + '"';

  if FillType <> v.FillType then
    Result := Result + ' FillType="' + frxValueToXML(FillType) + '"';
  Result := Result + FFill.Diff(v.Fill, 'Fill');
  Result := Result + FHyperlink.Diff(v.Hyperlink, 'Hyperlink');
  if FEditable <> v.Editable then
  begin
    vs := 0;
    if ferAllowInPreview in FEditable then vs := 1;
    if ferAllowInExport in FEditable then vs := vs or 2;
    Result := Result + ' Editable="' + IntToStr(vs) + '"';
  end;
end;

function TfrxView.IsAcceptAsChild(aParent: TfrxComponent): Boolean;
begin
  Result := True;
end;

procedure TfrxView.Highlighting(Canvas: TCanvas; AColor: TColor);
var
  vframe: TfrxFrame;
begin
  vframe := TfrxFrame.Create;
  vframe.Style := fsSolid;
  vframe.Typ := [ftLeft, ftRight, ftTop, ftBottom];
  vframe.Width := 1;
  vframe.Color := AColor + $202020;
  vframe.Draw(FCanvas, FX, FY, FX1, FY1, FScaleX, FScaleY);
  vframe.Free;
  TransparentFillRect(Canvas.Handle, FX, FY, FX1 + 1, FY1 + 1, AColor);
end;

function TfrxView.IsDataField: Boolean;
begin
  Result := (DataSet <> nil) and (Length(DataField) <> 0);
end;

function TfrxView.IsEMFExportable: Boolean;
begin
  Result := {$IFDEF FPC} False;
            {$ELSE}      AllowVectorExport;
            {$ENDIF}
end;

function TfrxView.IsPostProcessAllowed: Boolean;
begin
  Result := Assigned(FProcessing) and (FProcessing.ProcessAt <> paDefault);
end;

function TfrxView.LoadContentFromDictionary(aReport: TfrxReport;
  aItem: TfrxMacrosItem): Boolean;
begin
  Result := False;
end;

procedure TfrxView.MirrorContent(MirrorModes: TfrxMirrorControlModes);

  procedure SwapLines(var Line1: TfrxFrameLine; var Line2: TfrxFrameLine);
  var
    frameColor: TColor;
    frameStyle: TfrxFrameStyle;
    frameWidth: Extended;
  begin
    frameColor := Line1.Color;
    frameStyle := Line1.Style;
    frameWidth := Line1.Width;
    Line1.Color := Line2.Color;
    Line1.Style := Line2.Style;
    Line1.Width := Line2.Width;
    Line2.Color := frameColor;
    Line2.Style := frameStyle;
    Line2.Width := frameWidth;
  end;

  procedure SwapFrameType(var FrameType: TfrxFrameTypes; Type1, Type2: TfrxFrameType);
  begin
    Exclude(FrameType, Type1);
    Include(FrameType, Type2);
  end;

begin
  inherited MirrorContent(MirrorModes);
  if mcmRTLAppearance in MirrorModes then
  begin
    if (ftLeft in FFrame.FTyp) and not (ftRight in FFrame.FTyp) then
      SwapFrameType(FFrame.FTyp, ftLeft, ftRight)
    else if (ftRight in FFrame.FTyp) and not (ftLeft in FFrame.FTyp) then
      SwapFrameType(FFrame.FTyp, ftRight, ftLeft);
    SwapLines(FFrame.FLeftLine, FFrame.FRightLine);
  end;
  if mcmBTTAppearance in MirrorModes then
  begin
    if (ftTop in FFrame.FTyp) and not (ftBottom in FFrame.FTyp) then
      SwapFrameType(FFrame.FTyp, ftTop, ftBottom)
    else if (ftBottom in FFrame.FTyp) and not (ftTop in FFrame.FTyp) then
      SwapFrameType(FFrame.FTyp, ftBottom, ftTop);
    SwapLines(FFrame.FTopLine, FFrame.FBottomLine);
  end;

end;

procedure TfrxView.ProcessDictionary(aItem: TfrxMacrosItem;
  aReport: TfrxReport; PostProcessor: TfrxPostProcessor);
begin

end;

function TfrxView.GetVectorGraphic(DrawFill: Boolean = False): TGraphic;
begin
  Result := GetVectorGraphic(DrawFill, 1, 1);
end;

function TfrxView.GetVectorCanvas: TVectorCanvas;
var
  Bitmap: TBitmap;
  aScaleX, aScaleY: Extended;
begin
  FVC := TVectorCanvas.Create;
  try
    Bitmap := TBitmap.Create;
    Bitmap.PixelFormat := pf24bit;

    GetScreenScale(aScaleX, aScaleY);

    Bitmap.Width := Max(1, Round(Width * aScaleX));
    Bitmap.Height := Max(1, Round(Height * aScaleY));

    try
      Bitmap.Canvas.Lock;
      DrawClipped(Bitmap.Canvas, 1, 1, -AbsLeft, -AbsTop);
    finally
      Bitmap.Canvas.Unlock;
      Bitmap.Free;
    end;
  finally
    Result := FVC;
    FVC := nil;
  end;
end;

function TfrxView.GetVectorGraphic(DrawFill: Boolean; AScaleX, AScaleY: Double): TGraphic;
var
  aCanvas: TCanvas;
  LScaleX, LScaleY: Extended;
  dm, LAddWidth, LAddHeight: Integer;
  LRect: TfrxRect;
begin
  FObjAsMetafile := True;
  {$IFNDEF FPC}
  Result := TfrxMetafile.Create;
  {$ELSE}
  Result := TMetafile.Create;
  {$ENDIF}

  dm := 0;
  { ugly code, need to override in virtual finction }
  if Self is TfrxShapeView then
    dm := 1;
  GetScreenScale(LScaleX, LScaleY);
  try
    LRect := GetRealBounds;
    LAddWidth := Round((LRect.Right - LRect.Left) - Width);
    LAddHeight := Round((LRect.Bottom - LRect.Top) - Height);
  except
    LAddWidth := 0;
    LAddHeight := 0;
  end;
  Result.Width := Round((Width + LAddWidth) * LScaleX * AScaleX) + dm;
  Result.Height := Round((Height + LAddHeight) * LScaleY * AScaleY) + dm;
  TMetafile(Result).Enhanced := True;

  if Result.Height < 1 then Result.Height := 1;
  if Result.Width < 1 then Result.Width := 1;

  aCanvas := TMetafileCanvas.Create(TMetafile(Result), 0);
  try

    FDrawFillOnMetaFile := DrawFill;
    aCanvas.Lock;
    DrawClipped(aCanvas, AScaleX, AScaleY, (-AbsLeft + LAddWidth div 2) * AScaleX, (-AbsTop + LAddHeight div 2) * AScaleY);
  finally
    FObjAsMetafile := False;
    FDrawFillOnMetaFile := False;
    aCanvas.Unlock;
    aCanvas.Free;
  end;
end;

procedure TfrxView.GetScreenScale(var aScaleX, aScaleY: Extended);
var
  PrinterHandle: TfrHandle;
begin
  PrinterHandle := GetDC(0);
  try
    GetDisplayScale(PrinterHandle, False, aScaleX, aScaleY);
    aScaleX := Min(1, aScaleX);
    aScaleY := Min(1, aScaleY);
  finally
    ReleaseDC(0, PrinterHandle);
  end;
end;

procedure TfrxView.ApplyStyle(Style: TfrxCustomStyleItem);
begin
  if Style <> nil then
  begin
    if Style.ApplyFill then
      Fill := Style.Fill;
    if Style.ApplyFont then
      Font := Style.Font;
    if Style.ApplyFrame then
      Frame := Style.Frame;
  end;
end;

procedure TfrxView.AssignToStyle(Style: TfrxCustomStyleItem);
begin
  if Style <> nil then
  begin
    Style.Fill := Fill;
    Style.Font := Font;
    Style.Frame := Frame;
  end;
end;

procedure TfrxView.BeforePrint;
begin
  inherited;
  FTempTag := FTagStr;
  FTempHyperlink := FHyperlink.Value;
  if Report <> nil then
    Report.SelfValue := Self;
end;

procedure TfrxView.ExpandVariables(var Expr: String; ARaiseException: Boolean);
var
  i, j, LErrors: Integer;
  s: String;
  LReport: TfrxReport;
begin
  i := 1;
  LReport := Report;
  repeat
    while i < Length(Expr) do
      if isDBCSLeadByte(Byte(Expr[i])) then  { if DBCS then skip 2 bytes }
        Inc(i, 2)
      else if (Expr[i] <> '[') then
        Inc(i)
      else
        break;
{$IFDEF DELPHI12}
    s := frxGetBrackedVariableW(Expr, '[', ']', i, j);
{$ELSE}
    s := frxGetBrackedVariable(Expr, '[', ']', i, j);
{$ENDIF}
    if i <> j then
    begin
      LErrors := LReport.Errors.Count;
      try
        s := VarToStr(LReport.Calc(s));
      except
        on E: EReportScriptError do
         if ARaiseException then
          raise
         else
         begin
          if LErrors < LReport.Errors.Count then
            LReport.Errors.Delete(LReport.Errors.Count - 1);
          Break;
         end;
      end;
      Delete(Expr, i, j - i + 1);
      Insert(s, Expr, i);
      Inc(i, Length(s));
      j := 0;
    end;
  until i = j;
end;

procedure TfrxView.GetData;
var
//  val: Variant;
  st: TStringList;
  i: Integer;
  s, sLink: String;
  aReport: TfrxReport;
  DataLink: IfrxDataLinkObject;

  function CalcValue(aExp: String): Variant;
  begin
    Result := aReport.Calc(aExp);
    if ((TVarData(Result).VType = varString) or (TVarData(Result).VType = varOleStr)
    {$IFDEF DELPHI12} or (TVarData(Result).VType = varUString){$ENDIF}) and (FHyperlink.Kind <> hkURL) then
      if aReport.ScriptLanguage = 'PascalScript' then
        Result := QuotedStr(Result)
      else
        Result := '"' + StringReplace(Result, '"', '\"', [rfReplaceAll]) + '"';
  end;

begin
  aReport := Report;
  if aReport <> nil then
    aReport.SelfValue := Self;
  if (FTagStr <> '') and (Pos('[', FTagStr) <> 0) then
    ExpandVariables(FTagStr);
  if ShowHint and (FHint <> '') and (Pos('[', FHint) <> 0) then
    ExpandVariables(FHint, False);

  st := TStringList.Create;
  try
    frxParseDilimitedText(st, FHyperlink.Value, FHyperlink.ValuesSeparator[1]);
    if (FHyperlink.Value <> '') and (Pos('[', FHyperlink.Value) <> 0) then
    begin
      if St.Count = 0 then
        ExpandVariables(FHyperlink.FValue)
      else
        for i := 0 to St.Count - 1 do
        begin
          s := st[i];
          ExpandVariables(s);
          if i > 0 then
            FHyperlink.Value := FHyperlink.Value + FHyperlink.ValuesSeparator[1] + s
          else
            FHyperlink.Value := s;
        end;
    end;

    if FHyperlink.Expression <> '' then
    begin
      frxParseDilimitedText(st, FHyperlink.Expression, FHyperlink.ValuesSeparator[1]);
      if St.Count = 0 then
        FHyperlink.Value := CalcValue(FHyperlink.Expression)
      else
        for i := 0 to St.Count - 1 do
        begin
          if i > 0 then
            FHyperlink.Value := FHyperlink.Value + FHyperlink.ValuesSeparator[1] + VarToStr(CalcValue(st[i]))
          else
            FHyperlink.Value :=  VarToStr(CalcValue(st[i]));
        end;
    end;
  finally
    St.Free;
  end;
  if Supports(Self, IfrxDataLinkObject, DataLink) then
  begin
    sLink := DataLink.GetLink(dlmOnGetData);
    if DataLink.IsExpressionLink then
      ExpandVariables(sLink);
    if sLink <> '' then
      frxDataProtocols.LoadToObject(sLink, DataLink);
  end;
end;

procedure TfrxView.AfterPrint;
begin
  inherited;
  FTagStr := FTempTag;
  FHyperlink.Value := FTempHyperlink;
end;

procedure TfrxView.SetFill(const Value: TfrxCustomFill);
begin
  FillType := frxGetFillType(Value);
  FFill.Assign(Value);
end;

procedure TfrxView.SetFillType(const Value: TfrxFillType);
begin
  if FillType = Value then Exit;
  FFill.Free;
  FFill := frxCreateFill(Value);
  if IsDesigning and (Report <> nil) and (Report.Designer <> nil) then
    TfrxCustomDesigner(Report.Designer).UpdateInspector;
end;

function TfrxView.GetFillType: TfrxFillType;
begin
  Result := frxGetFillType(FFill);
end;

procedure TfrxView.SaveContentToDictionary(
  aReport: TfrxReport; PostProcessor: TfrxPostProcessor);
begin

end;

procedure TfrxView.SetBrushStyle(const Value: TBrushStyle);
begin
  if Self.Fill is TfrxBrushFill then
    TfrxBrushFill(Self.Fill).FStyle := Value;
end;

function TfrxView.GetBrushStyle: TBrushStyle;
begin
  if Self.Fill is TfrxBrushFill then
    Result := TfrxBrushFill(Self.Fill).FStyle
  else
    Result := bsClear;
end;

procedure TfrxView.SetColor(const Value: TColor);
begin
  if Self.Fill is TfrxBrushFill then
    TfrxBrushFill(Self.Fill).FBackColor := Value
  else if Self.Fill is TfrxGlassFill then
    TfrxGlassFill(Self.Fill).Color := Value;

end;

function TfrxView.GetColor: TColor;
begin
  if Self.Fill is TfrxBrushFill then
    Result := TfrxBrushFill(Self.Fill).FBackColor
  else if Self.Fill is TfrxGradientFill then
    Result := TfrxGradientFill(Self.Fill).GetColor
  else if Self.Fill is TfrxGlassFill then
    Result := TfrxGlassFill(Self.Fill).GetColor
  else
    Result := clNone;
end;

procedure TfrxView.SetURL(const Value: String);
begin
  if Value <> '' then
  begin
    if Pos('@', Value) = 1 then
    begin
      FHyperlink.Kind := hkPageNumber;
      FHyperlink.Value := Copy(Value, 2, 255);
    end
    else if Pos('#', Value) = 1 then
    begin
      FHyperlink.Kind := hkAnchor;
      FHyperlink.Value := Copy(Value, 2, 255);
    end
    else
    begin
      FHyperlink.Kind := hkURL;
      FHyperlink.Value := Value;
    end;
  end;
end;

function TfrxView.ShadowSize: Extended;
begin
 if Frame.DropShadow then
    Result := Frame.ShadowWidth
  else
    Result := 0.0;
end;

function TfrxView.GetPrintable: Boolean;
begin
  Result := vsPrint in Visibility;
end;

procedure TfrxView.GetScaleFactor(var ScaleX, ScaleY: Extended);
begin
//
end;

procedure TfrxView.SetPrintable(Value: Boolean);
begin
  if Value then
    Visibility := Visibility + [vsPrint]
  else
    Visibility := Visibility - [vsPrint];
end;

procedure TfrxView.SetProcessing(const Value: TfrxObjectProcessing);
begin
  FProcessing.Assign(Value);
end;

procedure TfrxView.SetStyle(const Value: TfrxStyleName);
begin
  FStyle := Value;
  if Report <> nil then
    ApplyStyle(Report.Styles.Find(FStyle));
end;

{ TfrxShapeView }

constructor TfrxShapeView.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csDefaultDiff];
  FRotation := 0;
end;

procedure TfrxShapeView.SetRotation(vRot: Integer);
begin
  if (vRot = 0) or (vRot = 90) or (vRot = 180) or (vRot = 270) then
    FRotation := vRot;
end;

constructor TfrxShapeView.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  FShape := TfrxShapeKind(Flags);
end;

procedure TfrxShapeView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  SaveLeft, SaveTop, SaveWidth, SaveHeight: Extended;
{$IFNDEF FPC}
  rgn: HRGN;
{$ENDIF}

  procedure DrawShape;
  var
    min: Integer;
  begin
    with Canvas do
    case FShape of
      skRectangle:
        Rectangle(FX, FY, FX1 + 1, FY1 + 1);

      skRoundRectangle:
        begin
          if FDY < FDX then min := FDY
          else              min := FDX;

          if FCurve = 0 then
            min := min div 4
          else
            min := Round(FCurve * FScaleX * 10);
          RoundRect(FX, FY, FX1 + 1, FY1 + 1, min, min);
        end;

      skEllipse:
        Ellipse(FX, FY, FX1 + 1, FY1 + 1);

      skTriangle:
        case (FRotation) of
          0: Polygon([Point(FX1, FY1), Point(FX, FY1), Point(FX + FDX div 2, FY), Point(FX1, FY1)]);
          90: Polygon([Point(FX, FY), Point(FX, FY1), Point(FX1, FY + FDY div 2), Point(FX, FY)]);
          180: Polygon([Point(FX, FY), Point(FX1, FY), Point(FX + FDX div 2, FY1), Point(FX, FY)]);
          270: Polygon([Point(FX1, FY1), Point(FX1, FY), Point(FX, FY + FDY div 2), Point(FX1, FY1)]);
        end;

      skDiamond:
        Polygon([Point(FX + FDX div 2, FY), Point(FX1, FY + FDY div 2),
          Point(FX + FDX div 2, FY1), Point(FX, FY + FDY div 2)]);

      skDiagonal1:
        DrawLine(FX, FY1, FX1, FY, FFrameWidth);

      skDiagonal2:
        DrawLine(FX, FY, FX1, FY1, FFrameWidth);
    end;
  end;

  procedure DrawShapeWithFill;
  begin
{$IFNDEF FPC}
    if (FShape in [skDiagonal1, skDiagonal2]) or (FillType = ftBrush) then
    begin
      DrawShape;
      Exit;
    end;
    rgn := CreateRectRgn(0, 0, MaxInt, MaxInt);
    GetClipRgn(Canvas.Handle, rgn);
    BeginPath(Canvas.Handle);
    DrawShape;
    EndPath(Canvas.Handle);
    SelectClipPath(Canvas.Handle, RGN_COPY);
    DrawBackground;
    Canvas.Brush.Style := bsClear;
    SelectClipRgn(Canvas.Handle, rgn);
    DeleteObject(rgn);
    DrawShape;
{$ELSE}
    DrawShape;
{$ENDIF}
  end;

  procedure DoDraw;
  begin
    with Canvas do
    begin
      Pen.Color := Self.Frame.Color;
      Pen.Width := FFrameWidth;
      Brush.Style := bsSolid;
      frxSetBkMode(Canvas, Opaque);

      if BrushStyle = bsSolid then
      begin
        Pen.Style := TPenStyle(Self.Frame.Style);
        if Self.Frame.Color = clNone then
          Pen.Style := psClear;
        if Self.Color <> clNone then
          Brush.Color := Self.Color else
          Brush.Style := bsClear;
        DrawShapeWithFill;
      end
      else
      begin
        Pen.Style := TPenStyle(Self.Frame.Style);
        if Self.Frame.Color = clNone then
          Pen.Style := psClear;
        if Self.Color <> clNone then
        begin
          Brush.Color := Self.Color;
          DrawShapeWithFill;
        end;
        Brush.Style := BrushStyle;
        Brush.Color := Self.Frame.Color;
        DrawShapeWithFill;
      end;
    end;
  end;

begin
  if Frame.Style = fsDouble then
  begin
    Frame.Style := fsSolid;
    SaveLeft := Left;
    SaveTop := Top;
    SaveWidth := Width;
    SaveHeight := Height;
    BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
    DoDraw;
    case FShape of
      skRectangle, skRoundRectangle, skEllipse:
        begin
          Left := Left + 2 * Frame.Width;
          Top := Top + 2 * Frame.Width;
          Width := Width - 4 * Frame.Width;
          Height := Height - 4 * Frame.Width;
        end;

      skTriangle:
        begin
          Left := Left + 4 * Frame.Width;
          Top := Top + 4 * Frame.Width;
          Width := Width - 8 * Frame.Width;
          Height := Height - 8 * Frame.Width;
          case (FRotation) of
            0: Height := Height + 2 * Frame.Width;
            90:
            begin
              Left := Left - 2 * Frame.Width;
              Width := Width + 2 * Frame.Width;
            end;
            180:
            begin
              Top := Top - 2 * Frame.Width;
              Height := Height + 2 * Frame.Width;
            end;
            270: Width := Width + 2 * Frame.Width;
          end;
        end;

      skDiamond:
        begin
          Left := Left + 3 * Frame.Width;
          Top := Top + 3 * Frame.Width;
          Width := Width - 6 * Frame.Width;
          Height := Height - 6 * Frame.Width;
        end;

      skDiagonal1, skDiagonal2:
        begin
          Left := Left + 2 * Frame.Width;
        end;
    end;

    BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
    DoDraw;

    Frame.Style := fsDouble;
    Left := SaveLeft;
    Top := SaveTop;
    Width := SaveWidth;
    Height := SaveHeight;
  end
  else
  begin
    BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
    DoDraw;
  end;
end;

function TfrxShapeView.Diff(AComponent: TfrxComponent): String;
begin
  Result := inherited Diff(AComponent);

  if FShape <> TfrxShapeView(AComponent).FShape then
    Result := Result + ' Shape="' + frxValueToXML(FShape) + '"';
end;

class function TfrxShapeView.GetDescription: String;
begin
  Result := frxResources.Get('obShape');
end;

{ TfrxHighlight }

constructor TfrxHighlight.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFont := TFont.Create;
  with FFont do
  begin
    PixelsPerInch := frx_DefaultPPI;
    Name := DefFontName;
    Size := DefFontSize;
    Color := clRed;
    Charset := frxCharset;
  end;
  FFill := TfrxBrushFill.Create;
  FFrame := TfrxFrame.Create;
  FApplyFont := True;
  FApplyFill := True;
  FVisible := True;
end;

destructor TfrxHighlight.Destroy;
begin
  FFont.Free;
  FFill.Free;
  FFrame.Free;
  inherited;
end;

procedure TfrxHighlight.Assign(Source: TPersistent);
begin
  if Source is TfrxHighlight then
  begin
    ApplyFont := TfrxHighlight(Source).ApplyFont;
    ApplyFill := TfrxHighlight(Source).ApplyFill;
    ApplyFrame := TfrxHighlight(Source).ApplyFrame;
    Font := TfrxHighlight(Source).Font;
    Fill := TfrxHighlight(Source).Fill;
    Frame := TfrxHighlight(Source).Frame;
    Condition := TfrxHighlight(Source).Condition;
    Visible := TfrxHighlight(Source).Visible;
    FInteractiveType := TfrxHighlight(Source).InteractiveType;
  end;
end;

procedure TfrxHighlight.SetFill(const Value: TfrxCustomFill);
begin
  FillType := frxGetFillType(Value);
  FFill.Assign(Value);
end;

procedure TfrxHighlight.SetFillType(const Value: TfrxFillType);
begin
  if FillType = Value then Exit;
  FFill.Free;
  FFill := frxCreateFill(Value);
end;

function TfrxHighlight.GetFillType: TfrxFillType;
begin
  Result := frxGetFillType(FFill);
end;

function TfrxHighlight.IsUniqueNameStored: Boolean;
begin
  Result := True;
end;

procedure TfrxHighlight.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TfrxHighlight.SetColor(const Value: TColor);
begin
  if Fill is TfrxBrushFill then
    TfrxBrushFill(Fill).BackColor := Value;
end;

function TfrxHighlight.GetColor: TColor;
begin
  if Fill is TfrxBrushFill then
    Result := TfrxBrushFill(Fill).BackColor
  else
    Result := clNone;
end;

procedure TfrxHighlight.SetFrame(const Value: TfrxFrame);
begin
  FFrame.Assign(Value);
end;


{ TfrxHighlightCollection }

constructor TfrxHighlightCollection.Create;
begin
  inherited Create(TfrxHighlight);
end;

function TfrxHighlightCollection.GetItem(Index: Integer): TfrxHighlight;
begin
  Result := TfrxHighlight(inherited Items[Index]);
end;


{ TfrxFormat }

procedure TfrxFormat.Assign(Source: TPersistent);
begin
  if Source is TfrxFormat then
  begin
    FDecimalSeparator := TfrxFormat(Source).DecimalSeparator;
    FThousandSeparator := TfrxFormat(Source).ThousandSeparator;
    FFormatStr := TfrxFormat(Source).FormatStr;
    FKind := TfrxFormat(Source).Kind;
  end;
end;


{ TfrxFormatCollection }

constructor TfrxFormatCollection.Create;
begin
  inherited Create(TfrxFormat);
end;

function TfrxFormatCollection.GetItem(Index: Integer): TfrxFormat;
begin
  Result := TfrxFormat(inherited Items[Index]);
end;


{ TfrxStretcheable }

constructor TfrxStretcheable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStretchMode := smDontStretch;
end;

function TfrxStretcheable.CalcHeight: Extended;
begin
  Result := Height;
end;

function TfrxStretcheable.DrawPart: Extended;
begin
  Result := 0;
end;

function TfrxStretcheable.GetLastShiftAmount(aFreeSpace: Extended): Extended;
begin
  Result := 0;
end;

procedure TfrxStretcheable.InitPart;
begin
//
end;

function TfrxStretcheable.HasNextDataPart(aFreeSpace: Extended): Boolean;
begin
  Result := not (Top + FSaveHeight <= aFreeSpace);
end;


{ TfrxCustomMemoView }

constructor TfrxCustomMemoView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frComponentStyle := frComponentStyle - [csDefaultDiff] + [csHandlesNestedProperties];
  FHighlights := TfrxHighlightCollection.Create;
  FFormats := TfrxFormatCollection.Create;
  FMemo := TfrWideStrings.Create;
  FMemoBehaviourFlags := [mbfAllowExpressions, mbfClipped, mbfWordWrap, mbfWysiwyg];
  FExpressionDelimiters := '[,]';
  FGapX := 2;
  FGapY := 1;
  FHAlign := haLeft;
  FVAlign := vaTop;
  FLineSpacing := 2;
  ParentFont := True;
  FLastValue := Null;
  FMacroIndex := -1;
  FMacroLine := -1;
end;

destructor TfrxCustomMemoView.Destroy;
begin
  FHighlights.Free;
  FFormats.Free;
  FMemo.Free;
  FreeAndNil(FDataLink);
  inherited;
end;

class function TfrxCustomMemoView.GetDescription: String;
begin
  Result := frxResources.Get('obText');
end;

procedure TfrxCustomMemoView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FFlowTo) then
    FFlowTo := nil;
end;

procedure TfrxCustomMemoView.ProcessDictionary(aItem: TfrxMacrosItem;
  aReport: TfrxReport; PostProcessor: TfrxPostProcessor);
var
  sName: String;
  s: WideString;
  Index: Integer;
begin
  Index := aItem.Count - 1;
  s := Text;
  sName := aReport.CurObject;
  try
    aReport.CurObject := Name;
    GetData;
    aReport.DoNotifyEvent(Self, Self.OnAfterData);
    aItem.Item[Index] := Text;
  finally
    aReport.CurObject := sName;
    Text := s;
  end;
end;

function TfrxCustomMemoView.LoadContentFromDictionary(aReport: TfrxReport;
  aItem: TfrxMacrosItem): Boolean;
var
  ItemIdx: Integer;
  lComponent: TfrxComponent;
begin
  Result := False;
  if (aItem <> nil) and not (mbfMacroLoaded in FMemoBehaviourFlags) then
    if TryStrToInt(Memo[0], ItemIdx) then
    begin
      Include(FMemoBehaviourFlags, mbfMacroLoaded);
      if (Duplicates = dmClear) and (aItem.FLastIndex = ItemIdx) then
        Text := ''
      else
        Text := aItem.Item[ItemIdx];
      lComponent := aItem.FComponent;

      if (Duplicates in [dmHide, dmMerge, dmClear]) and (aItem.FLastIndex = ItemIdx) then
      begin
        if (lComponent <> nil) and (Duplicates = dmMerge) then
          lComponent.Height := AbsTop - lComponent.AbsTop + Height;
        if (Duplicates <> dmClear) then
          Result := True;//aComponent.Free;

      end;
      if (aItem.FLastIndex <> ItemIdx) then
        aItem.FComponent := Self;

      aItem.FLastIndex := ItemIdx;

    end;
end;

function TfrxCustomMemoView.LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
var
  s: TStringStream;
begin
  Result := True;
  s := TStringStream.Create('');
  try
    s.CopyFrom(Stream, Stream.Size);
    Text := s.DataString;
  except
    Result := False;
  end;
  s.Free;
end;

procedure TfrxCustomMemoView.Loaded;
begin
  inherited Loaded;
  // backward compatibility, to support Highlight.Active
  // moved, cause see in ticket # 294150
//  if Highlight.Active then
//    ApplyHighlight(Highlight);
end;

procedure TfrxCustomMemoView.MirrorContent(
  MirrorModes: TfrxMirrorControlModes);
begin
  inherited MirrorContent(MirrorModes);
  if mcmRTLContent in MirrorModes then
  begin
    if HAlign = haLeft then
      HAlign := haRight
    else if HAlign = haRight then
      HAlign := haLeft;
  end;
  if mcmBTTContent in MirrorModes then
  begin
    if VAlign = vaTop then
      VAlign := vaBottom
    else if VAlign = vaBottom then
      VAlign := vaTop;
  end;
  if mcmRTLSpecial in MirrorModes then
    RTLReading := True;
end;

procedure TfrxCustomMemoView.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Formats', ReadFormats, WriteFormats, Formats.Count > 1);
  Filer.DefineProperty('Highlights', ReadHighlights, WriteHighlights, Highlights.Count > 1);
end;

procedure TfrxCustomMemoView.WriteFormats(Writer: TWriter);
begin
  frxWriteCollection(FFormats, Writer, Self);
end;

procedure TfrxCustomMemoView.WriteHighlights(Writer: TWriter);
begin
  frxWriteCollection(FHighlights, Writer, Self);
end;

procedure TfrxCustomMemoView.ReadFormats(Reader: TReader);
begin
  frxReadCollection(FFormats, Reader, Self);
end;

procedure TfrxCustomMemoView.ReadHighlights(Reader: TReader);
begin
  frxReadCollection(FHighlights, Reader, Self);
end;

function TfrxCustomMemoView.IsExprDelimitersStored: Boolean;
begin
  Result := FExpressionDelimiters <> '[,]';
end;

function TfrxCustomMemoView.IsExpressionLink: Boolean;
begin
  Result := TfrxDataLink.IsExpressionLink(FDataLink);
end;

function TfrxCustomMemoView.IsLineSpacingStored: Boolean;
begin
  Result := FLineSpacing <> 2;
end;

function TfrxCustomMemoView.IsGapXStored: Boolean;
begin
  Result := FGapX <> 2;
end;

function TfrxCustomMemoView.IsGapYStored: Boolean;
begin
  Result := FGapY <> 1;
end;

function TfrxCustomMemoView.IsParagraphGapStored: Boolean;
begin
  Result := FParagraphGap <> 0;
end;

function TfrxCustomMemoView.IsPostProcessAllowed: Boolean;
begin
  Result := inherited IsPostProcessAllowed or (Duplicates <> dmShow);
end;

function TfrxCustomMemoView.IsCharSpacingStored: Boolean;
begin
  Result := FCharSpacing <> 0;
end;

function TfrxCustomMemoView.IsHighlightStored: Boolean;
begin
  Result := (FHighlights.Count = 1) and (Trim(Highlight.Condition) <> '');
end;

function TfrxCustomMemoView.IsDataLinkStored: Boolean;
begin
  Result := TfrxDataLink.IsDataLinkStored(FDataLink, frComponentState);
end;

function TfrxCustomMemoView.IsDisplayFormatStored: Boolean;
begin
  Result := FFormats.Count = 1;
end;

function TfrxCustomMemoView.GetHighlight: TfrxHighlight;
begin
  if FHighlights.Count = 0 then
    FHighlights.Add;
  Result := FHighlights[0];
end;

function TfrxCustomMemoView.GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
begin
  Result := TfrxDataLink.GetLink(FDataLink, LoadMethod);
end;

function TfrxCustomMemoView.GetDisplayFormat: TfrxFormat;
begin
  if FFormats.Count = 0 then
    FFormats.Add;
  Result := FFormats[0];
end;

procedure TfrxCustomMemoView.SetRotation(Value: Integer);
begin
  FRotation := Value mod 360;
end;

function TfrxCustomMemoView.GetUnderlines: Boolean;
begin
  Result := not (FUnderlinesTextMode in [ulmNone]);
end;

function TfrxCustomMemoView.GetFlagValue(const Index: Integer): Boolean;
begin
  Result := TfrxCustomMemoViewBehaviourFlag(Index) in FMemoBehaviourFlags;
end;

function TfrxCustomMemoView.GetValue: Variant;
begin
  Result := FValue;
end;

procedure TfrxCustomMemoView.SetUnderlines(const Value: Boolean);
begin
  if not Value then
    FUnderlinesTextMode := ulmNone
  else
    if FUnderlinesTextMode = ulmNone then
      FUnderlinesTextMode := ulmUnderlinesAll;
end;

procedure TfrxCustomMemoView.UpdateBounds;
var
  LDrawText: TfrxDrawText;
begin
  inherited;
  if AutoWidth then
  begin
    LDrawText := GetDrawTextObject;
    LDrawText.Lock;
    try
      LDrawText.SetFont(FFont);
      LDrawText.SetOptions(WordWrap, AllowHTMLTags, RTLReading, WordBreak,
        Clipped, Wysiwyg, FRotation);
      LDrawText.SetGaps(FParagraphGap, FCharSpacing, FLineSpacing);
      CalculateAutoWidth(LDrawText);
    finally
      LDrawText.Unlock;
    end;
  end;
end;

procedure TfrxCustomMemoView.SetFlagValue(const Index: Integer; const Value: Boolean);
var
  LIndex: TfrxCustomMemoViewBehaviourFlag;
begin
  LIndex := TfrxCustomMemoViewBehaviourFlag(Index);
  if Value then
    Include(FMemoBehaviourFlags, LIndex)
  else
    Exclude(FMemoBehaviourFlags, LIndex);
end;

procedure TfrxCustomMemoView.SetText(const Value: WideString);
begin
 { if (FFont.Charset <> DEFAULT_CHARSET) and (Report <> nil) then
    FMemo.Text := AnsiToUnicode(Value, FFont.Charset)
  else}
  FMemo.Text := Value;
end;

procedure TfrxCustomMemoView.SetAnsiText(const Value: AnsiString);
begin
  FMemo.Text := AnsiToUnicode(Value, FFont.Charset);
end;

function TfrxCustomMemoView.GetText: WideString;
begin
  Result := FMemo.Text;
end;

function TfrxCustomMemoView.GetAnsiText: AnsiString;
begin
  Result := _UnicodeToAnsi(FMemo.Text,FFont.Charset);
end;

procedure TfrxCustomMemoView.SetMemo(const Value: TWideStrings);
begin
  FMemo.Assign(Value);
end;

procedure TfrxCustomMemoView.SetPartMemoText(const Value: WideString);
begin
  FPartMemo := Value;
end;

procedure TfrxCustomMemoView.SetHighlight(const Value: TfrxHighlight);
begin
  Highlight.Assign(Value);
end;

procedure TfrxCustomMemoView.SetDataLink(const Value: TfrxDataLink);
begin
  if not Assigned(FDataLink) then
    GetDataLink;
  FDataLink.Assign(Value);
end;

procedure TfrxCustomMemoView.SetDisplayFormat(const Value: TfrxFormat);
begin
  DisplayFormat.Assign(Value);
end;

function TfrxCustomMemoView.AdjustCalcHeight: Extended;
begin
  Result := GapY * 2;
  if ftTop in Frame.Typ then
    Result := Result + (Frame.Width - 1) / 2;
  if ftBottom in Frame.Typ then
    Result := Result + Frame.Width / 2;
  if Frame.DropShadow then
    Result := Result + Frame.ShadowWidth;
end;

function TfrxCustomMemoView.AdjustCalcWidth: Extended;
begin
  Result := GapX * 2;
  if ftLeft in Frame.Typ then
    Result := Result + (Frame.Width - 1) / 2;
  if ftRight in Frame.Typ then
    Result := Result + Frame.Width / 2;
  if Frame.DropShadow then
    Result := Result + Frame.ShadowWidth;
end;

procedure TfrxCustomMemoView.BeginDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  LDrawText: TfrxDrawText;
begin
  LDrawText := GetDrawTextObject;
  LDrawText.UseDefaultCharset := UseDefaultCharset;
  LDrawText.UseMonoFont := FDrawAsMask;
  LDrawText.SetFont(FFont);
  LDrawText.SetOptions(WordWrap, AllowHTMLTags, RTLReading, WordBreak,
    Clipped, Wysiwyg, FRotation);
  LDrawText.SetGaps(FParagraphGap, FCharSpacing, FLineSpacing);
  CalculateAutoWidth(LDrawText);
  inherited BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  FScaledRect := CalcTextRect(OffsetX, OffsetY, ScaleX, ScaleY);
  FTextRect := CalcTextRect(0, 0, 1, 1);
end;

procedure TfrxCustomMemoView.SetDrawParams(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  FDrawText: TfrxDrawText;
begin
  FDrawText := GetDrawTextObject;
  FDrawText.UseDefaultCharset := UseDefaultCharset;
  FDrawText.UseMonoFont := FDrawAsMask;
  FDrawText.SetFont(FFont);
  FDrawText.SetOptions(WordWrap, AllowHTMLTags, RTLReading, WordBreak,
    Clipped, Wysiwyg, FRotation);
  FDrawText.SetGaps(FParagraphGap, FCharSpacing, FLineSpacing);

  if not IsPrinting then
    FPrintScale := 1;
  if (ScaleX = 1) and (ScaleY = 1) and (OffsetX = 0) and (OffsetY = 0) then
    FDrawText.SetDimensions(ScaleX, ScaleY, FPrintScale, FTextRect, FTextRect)
  else
    FDrawText.SetDimensions(ScaleX, ScaleY, FPrintScale, FTextRect,
      FScaledRect);
  FDrawText.SetText(FMemo, FirstParaBreak);
  FDrawText.SetParaBreaks(FirstParaBreak, LastParaBreak);
end;

procedure TfrxCustomMemoView.DrawText;
var
  FDrawText: TfrxDrawText;
{
  procedure DrawUnderlines;
  var
    dy, h: Extended;
  begin
    with FCanvas do
    begin
      Pen.Color := Self.Frame.Color;
      Pen.Width := FFrameWidth;
      Pen.Style := psSolid;
      Pen.Mode := pmCopy;
    end;

    h := FDrawText.LineHeight * FScaleY;
    dy := FY + h + (GapY - LineSpacing + 1) * FScaleY;
    while dy < FY1 do
    begin
      FCanvas.MoveTo(FX, Round(dy));
      FCanvas.LineTo(FX1, Round(dy));
      dy := dy + h;
    end;
  end;
}
begin
  FDrawText := GetDrawTextObject;
  FDrawText.UseDefaultCharset := UseDefaultCharset;

  if not IsDesigning then
    ExtractMacros
  else if IsDataField then
    FMemo.Text := '[' + DataSet.UserName + '."' + DataField + '"]';

  FDrawText.Lock;
  try
    SetDrawParams(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
    if (FUnderlinesTextMode <> ulmNone) and (FRotation = 0) then
    with FCanvas do
    begin
      Pen.Color := Self.Frame.Color;
      Pen.Width := FFrameWidth;
      Pen.Style := psSolid;
      Pen.Mode := pmCopy;
    end;
    FDrawText.VC := FVC;
    try
      FDrawText.DrawText(FCanvas, HAlign, VAlign, FUnderlinesTextMode);
    finally
      FDrawText.VC := nil;
    end;
  finally
    FDrawText.Unlock;
  end;
end;

procedure TfrxCustomMemoView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  if FVC = nil then
  begin
    DrawBackground;
    DrawFrameEdges;
    DrawFrame;
  end;
  DrawText;
  if Assigned(FComponentEditors) then
    FComponentEditors.DrawCustomEditor(FCanvas, Rect(FX, FY, FX1, FY1));
end;

function TfrxCustomMemoView.CalcHeight: Extended;
var
  FDrawText: TfrxDrawText;
  bVerticalText: Boolean;
begin
  FDrawText := GetDrawTextObject;
  bVerticalText := (FRotation = 90) or (FRotation = 270);
  FDrawText.Lock;
  try
    FDrawText.SetFont(FFont);
    FDrawText.SetOptions(WordWrap, AllowHTMLTags, RTLReading, WordBreak,
      Clipped, Wysiwyg, FRotation);
    FDrawText.SetGaps(FParagraphGap, FCharSpacing, FLineSpacing);

    if AutoWidth or bVerticalText then
      FDrawText.SetDimensions(1, 1, 1, Rect(0, 0, 10000, 10000), Rect(0, 0, 10000, 10000))
    else
    begin
      BeginDraw(nil, 1, 1, 0, 0);
      FDrawText.SetDimensions(1, 1, 1, FTextRect, FTextRect);
    end;

    FDrawText.SetText(FMemo);
    if bVerticalText then
      Result := Round(FDrawText.CalcWidth + AdjustCalcHeight)
    else
      Result := Round(FDrawText.CalcHeight + AdjustCalcHeight);
  finally
    FDrawText.Unlock;
  end;
end;

function TfrxCustomMemoView.CalcTextRect(OffsetX, OffsetY, ScaleX, ScaleY: Extended): TRect;
var
  bx, by, bx1, by1, wx1, wx2, wy1, wy2, gx1, gy1: Integer;
begin
  wx1 := Round((Frame.Width * ScaleX - 1) / 2);
  wx2 := Round(Frame.Width * ScaleX / 2);
  wy1 := Round((Frame.Width * ScaleY - 1) / 2);
  wy2 := Round(Frame.Width * ScaleY / 2);

  bx := Round(AbsLeft * ScaleX + OffsetX);;
  by := Round(AbsTop * ScaleY + OffsetY);
  // bx1 := FX1;
  // by1 := FY1;
  if Frame.DropShadow then
  begin
    bx1 := bx + Round((Width - Frame.ShadowWidth) * ScaleX);
    by1 := by + Round((Height - Frame.ShadowWidth) * ScaleY);
  end
  else
  begin
    bx1 := bx + Round(Width * ScaleX);
    by1 := by + Round(Height * ScaleY);
  end;

  if ftLeft in Frame.Typ then
    Inc(bx, wx1);
  if ftRight in Frame.Typ then
    Dec(bx1, wx2);
  if ftTop in Frame.Typ then
    Inc(by, wy1);
  if ftBottom in Frame.Typ then
    Dec(by1, wy2);
  gx1 := Round(GapX * ScaleX);
  gy1 := Round(GapY * ScaleY);

  Result := Rect(bx + gx1, by + gy1, bx1 - gx1 + 1, by1 - gy1 + 1);
end;

procedure TfrxCustomMemoView.CalculateAutoWidth(ADrawText: TObject);
var
  SaveWidth: Extended;
  LDrawText: TfrxDrawText absolute ADrawText;
begin
  if not IsDesigning then
    if AutoWidth then
    begin
      LDrawText.SetDimensions(1, 1, 1, Rect(0, 0, 10000, 10000), Rect(0, 0, 10000, 10000));
      LDrawText.SetText(FMemo);
      SaveWidth := Width;
      if (FRotation = 90) or (FRotation = 270) then
        Width := LDrawText.CalcHeight + AdjustCalcWidth
      else
        Width := LDrawText.CalcWidth + AdjustCalcWidth;
      if FHAlign = haRight then
        Left := Left + SaveWidth - Width
      else if FHAlign = haCenter then
        Left := Left + (SaveWidth - Width) / 2;
    end;
end;

function TfrxCustomMemoView.HasOutboundContent: Boolean;
var
  FDrawText: TfrxDrawText;
begin
  FDrawText := GetDrawTextObject;

  FDrawText.Lock;
  try
    BeginDraw(nil, 1, 1, 0, 0);
    SetDrawParams(nil, 1, 1, 0, 0);
    Result := ((Self.Width <= FDrawText.CalcWidth) or (Self.Height <= FDrawText.CalcHeight));
  finally
    FDrawText.Unlock;
  end;
end;

function TfrxCustomMemoView.CalcWidth: Extended;
var
  FDrawText: TfrxDrawText;
  bVerticalText: Boolean;
begin
  FDrawText := GetDrawTextObject;
  bVerticalText := (FRotation = 90) or (FRotation = 270);
  FDrawText.Lock;
  try
    FDrawText.SetFont(FFont);
    FDrawText.SetOptions(WordWrap, AllowHTMLTags, RTLReading, WordBreak,
      Clipped, Wysiwyg, FRotation);
    FDrawText.SetGaps(FParagraphGap, FCharSpacing, FLineSpacing);
    if bVerticalText then
    begin
      FTextRect := CalcTextRect(0, 0, 1, 1);
      FDrawText.SetDimensions(1, 1, 1, FTextRect, FTextRect);
    end
    else
      FDrawText.SetDimensions(1, 1, 1, Rect(0, 0, 10000, 10000), Rect(0, 0, 10000, 10000));
    FDrawText.SetText(FMemo);
    if bVerticalText then
      Result := Round(FDrawText.CalcHeight + AdjustCalcWidth)
    else
      Result := Round(FDrawText.CalcWidth + AdjustCalcWidth);
  finally
    FDrawText.Unlock;
  end;
end;

procedure TfrxCustomMemoView.InitPart;
begin
  FPartMemo := Text;
  Exclude(FMemoBehaviourFlags, mbfFirstParaBreak);
  Exclude(FMemoBehaviourFlags, mbfLastParaBreak);
end;

function TfrxCustomMemoView.DrawPart: Extended;
var
  FDrawText: TfrxDrawText;
  ParaBreak: Boolean;
begin
  FDrawText := GetDrawTextObject;

  FDrawText.Lock;
  try
    //FMemo.Text := FPartMemo;
    Text := FPartMemo;
    BeginDraw(nil, 1, 1, 0, 0);
    SetDrawParams(nil, 1, 1, 0, 0);
    SetPartMemoText(FDrawText.GetOutBoundsText(ParaBreak));
//    FPartMemo := FDrawText.GetOutBoundsText(ParaBreak);
    Text := FDrawText.GetInBoundsText;
    LastParaBreak := ParaBreak;

    Result := FDrawText.UnusedSpace;
    if Result = 0 then
      Result := Height
	else
	  Result := Result + GapY * 2;

  finally
    FDrawText.Unlock;
  end;
end;

function TfrxCustomMemoView.Diff(AComponent: TfrxComponent): String;
var
  m: TfrxCustomMemoView;
begin
  Result := inherited Diff(AComponent);
  m := TfrxCustomMemoView(AComponent);

  if AutoWidth <> m.AutoWidth then
    Result := Result + ' AutoWidth="' + frxValueToXML(AutoWidth) + '"';
  if frxFloatDiff(FCharSpacing, m.FCharSpacing) then
    Result := Result + ' CharSpacing="' + FloatToStr(FCharSpacing) + '"';
  if frxFloatDiff(FGapX, m.FGapX) then
    Result := Result + ' GapX="' + FloatToStr(FGapX) + '"';
  if frxFloatDiff(FGapY, m.FGapY) then
    Result := Result + ' GapY="' + FloatToStr(FGapY) + '"';
  if FHAlign <> m.FHAlign then
    Result := Result + ' HAlign="' + frxValueToXML(FHAlign) + '"';
  if frxFloatDiff(FLineSpacing, m.FLineSpacing) then
    Result := Result + ' LineSpacing="' + FloatToStr(FLineSpacing) + '"';
  if UseDefaultCharset <> m.UseDefaultCharset then
    Result := Result + ' UseDefaultCharset="' + frxValueToXML(UseDefaultCharset) + '"';

  Result := Result + DiffText(AComponent);

  if FHint <> '' then
    Result := Result + ' Hint="' + frxStrToXML(FHint) + '"';

  if frxFloatDiff(FParagraphGap, m.FParagraphGap) then
    Result := Result + ' ParagraphGap="' + FloatToStr(FParagraphGap) + '"';
  if FRotation <> m.FRotation then
    Result := Result + ' Rotation="' + IntToStr(FRotation) + '"';
  if RTLReading <> m.RTLReading then
    Result := Result + ' RTLReading="' + frxValueToXML(RTLReading) + '"';
  if FUnderlinesTextMode <> m.FUnderlinesTextMode then
    Result := Result + ' UnderlinesTextMode="' + frxValueToXML(FUnderlinesTextMode) + '"';
  if FVAlign <> m.FVAlign then
    Result := Result + ' VAlign="' + frxValueToXML(FVAlign) + '"';
  if WordWrap <> m.WordWrap then
    Result := Result + ' WordWrap="' + frxValueToXML(WordWrap) + '"';

  { formatting }
  if Formats.Count = 1 then
  begin
    if DisplayFormat.FKind <> m.DisplayFormat.FKind then
      Result := Result + ' DisplayFormat.Kind="' + frxValueToXML(DisplayFormat.FKind) + '"';
    if DisplayFormat.FDecimalSeparator <> m.DisplayFormat.FDecimalSeparator then
      Result := Result + ' DisplayFormat.DecimalSeparator="' + frxStrToXML(DisplayFormat.FDecimalSeparator) + '"';
    if DisplayFormat.FThousandSeparator <> m.DisplayFormat.FThousandSeparator then
      Result := Result + ' DisplayFormat.ThousandSeparator="' + frxStrToXML(DisplayFormat.FThousandSeparator) + '"';
    if DisplayFormat.FFormatStr <> m.DisplayFormat.FFormatStr then
      Result := Result + ' DisplayFormat.FormatStr="' + frxStrToXML(DisplayFormat.FFormatStr) + '"';
  end;

  if FirstParaBreak then
    Result := Result + ' FirstParaBreak="1"';
  if LastParaBreak then
    Result := Result + ' LastParaBreak="1"';

  FirstParaBreak := LastParaBreak;
  LastParaBreak := False;
end;

function TfrxCustomMemoView.DiffText(AComponent: TfrxComponent): String;
var
  s: WideString;
  c: Integer;
begin
  c := FMemo.Count;
  if c = 0 then
    Result := ' u=""'
  else
  begin
    if c = 1 then
{$IFDEF DELPHI12}
      Result := ' u="' + frxStrToXML(FMemo[0]) + '"'
{$ELSE}
{$IFDEF FPC}
      Result := ' u="' + frxStrToXML(FMemo[0]) + '"'
{$ELSE}
      Result := ' u="' + frxStrToXML(Utf8Encode(FMemo[0])) + '"'
{$ENDIF}
{$ENDIF}
    else
    begin
      s := Text;
      {$IFDEF Linux}
      SetLength(s, Length(s) - 1);
      {$ELSE}
      SetLength(s, Length(s) - 2);
      {$ENDIF}
{$IFDEF DELPHI12}
      Result := ' u="' + frxStrToXML(s) + '"';
{$ELSE}
{$IFDEF FPC}
      Result := ' u="' + frxStrToXML(s) + '"';
{$ELSE}
      Result := ' u="' + frxStrToXML(Utf8Encode(s)) + '"';
{$ENDIF}
{$ENDIF}
    end;
  end;
end;

procedure TfrxCustomMemoView.DoMouseEnter(aPreviousObject: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams);
begin
  Inherited DoMouseEnter(APreviousObject, EventParams);
end;

procedure TfrxCustomMemoView.DoMouseLeave(aNextObject: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams);
begin
  Inherited DoMouseLeave(aNextObject, EventParams);
end;


procedure TfrxCustomMemoView.BeforePrint;
begin
  inherited;
  if not IsDataField then
    FTempMemo := FMemo.Text;
  TfrxDataLink.SaveState(FDataLink);
end;

procedure TfrxCustomMemoView.AfterPrint;
begin
  if not IsDataField then
    FMemo.Text := FTempMemo;
  if mbfHighlightActivated in FMemoBehaviourFlags then
    RestorePreHighlightState;
  TfrxDataLink.RestoreState(FDataLink);
  inherited;
end;

procedure TfrxCustomMemoView.SaveContentToDictionary(
  aReport: TfrxReport; PostProcessor: TfrxPostProcessor);
var
  s{, dc1, dc2}: WideString;
  bName: String;
  Index: Integer;
begin
  bName := '';
  if Assigned(Parent) then
    bName := Parent.Name;
  if IsDataField then
  begin
    //dc1 := FExpressionDelimiters;
    //dc2 := Copy(dc1, Pos(',', dc1) + 1, 255);
    //dc1 := Copy(dc1, 1, Pos(',', dc1) - 1);
    if DisplayFormat.Kind = fkText then
      s := VarToStr(Report.Calc({dc1 + }DatasetName + '."' + DataField + '"'{ + dc2}))
    else
      s := FormatData(FValue);
  end
  else
    s := Text;
  if (Length(s) >= 2) and (s[Length(s) - 1] = #13) and (s[Length(s)] = #10) then
    Delete(s, Length(s) - 1, 2);

{$IFDEF UNIX} // delete LineEnding
  if (Length(s) >= 1) and (s[Length(s)] = #10) then
    Delete(s, Length(s), 1);
        {$ENDIF}
  Index := PostProcessor.Add(bName, Name, s, Processing.ProcessAt, Self,
    ((Processing.ProcessAt <> paDefault) or (Duplicates <> dmShow)) and
    (bName <> ''));
  if Index <> -1 then
    Text := IntToStr(Index);
end;

procedure TfrxCustomMemoView.SavePreHighlightState;
begin
  Include(FMemoBehaviourFlags, mbfHighlightActivated);

  FTempFill := frxCreateFill(FillType);
  FTempFill.Assign(FFill);

  FTempFont := TFont.Create;
  FTempFont.Assign(FFont);

  FTempFrame := TfrxFrame.Create;
  FTempFrame.Assign(FFrame);

  FTempVisible := Visible;
end;

procedure TfrxCustomMemoView.RestorePreHighlightState;
begin
  Exclude(FMemoBehaviourFlags, mbfHighlightActivated);

  Fill := FTempFill;
  FTempFill.Free;
  FTempFill := nil;

  FFont.Assign(FTempFont);
  FTempFont.Free;
  FTempFont := nil;

  FFrame.Assign(FTempFrame);
  FTempFrame.Free;
  FTempFrame := nil;

  Visible := FTempVisible;
end;

procedure TfrxCustomMemoView.GetData;
var
  i, j, nFormat: Integer;
  s, s1, s2, dc1, dc2: WideString;
  ThLocale: Cardinal;
  LocCharset: Boolean;
begin
  inherited;
  ThLocale := 0;
  if FFormats.Count = 0 then
    FFormats.Add;

  LocCharset := ((Font.Charset <> DEFAULT_CHARSET) and  not UseDefaultCharset);
  if IsDataField then
  begin
    if DataSet.IsBlobField(DataField) then
    begin
      {$IFNDEF FPC}
      if LocCharset then
      begin
        ThLocale := GetThreadLocale;
        SetThreadLocale(GetLocalByCharSet(Font.Charset));
      end;
      {$ENDIF}
      DataSet.AssignBlobTo(DataField, FMemo);
      {$IFNDEF FPC}
      if LocCharset then
        SetThreadLocale(ThLocale);
      {$ENDIF}
    end
    else
    begin
      FValue := DataSet.Value[DataField];
      if DisplayFormat.Kind = fkText then
      begin
        if LocCharset then
          FMemo.Text := AnsiToUnicode(AnsiString(DataSet.DisplayText[DataField]), Font.Charset) else
          FMemo.Text := DataSet.DisplayText[DataField];
      end
      else FMemo.Text := FormatData(FValue);
      if HideZeros and (not VarIsNull(FValue)) and (TVarData(FValue).VType <> varString) and
      {$IFDEF DELPHI12}(TVarData(FValue).VType <> varUString) and{$ENDIF}
        (TVarData(FValue).VType <> varOleStr) and SameValue(FValue, 0.0, Report.EngineOptions.ZeroPrecisionValue) then
        FMemo.Text := '';
    end;
  end
  else if AllowExpressions then
  begin
    s := FMemo.Text;
    i := 1;
    dc1 := FExpressionDelimiters;
    dc2 := Copy(dc1, Pos(',', dc1) + 1, 255);
    dc1 := Copy(dc1, 1, Pos(',', dc1) - 1);
    nFormat := 0;

    if Pos(dc1, s) <> 0 then
    begin
      repeat
        while (i < Length(s)) and (Copy(s, i, Length(dc1)) <> dc1) do Inc(i);

        s1 := frxGetBrackedVariableW(s, dc1, dc2, i, j);
        if i <> j then
        begin
          Delete(s, i, j - i + 1);
          s2 := CalcAndFormat(s1, FFormats[nFormat]);
          Insert(s2, s, i);
          Inc(i, Length(s2));
          j := 0;
          if nFormat < FFormats.Count - 1 then
            Inc(nFormat);
        end;
      until i = j;

      FMemo.Text := s;
    end;
  end;

  Report.LocalValue := FValue;
  for i := 0 to FHighlights.Count - 1 do
    if (FHighlights[i].Condition <> '') and (Report.Calc(FHighlights[i].Condition) = True) then
    begin
      SavePreHighlightState;
      ApplyHighlight(FHighlights[i]);
      break;
    end;

  if SuppressRepeated then
  begin
    if FLastValue = FMemo.Text then
      FMemo.Text := '' else
      FLastValue := FMemo.Text;
  end;

  if FFlowTo <> nil then
  begin
    InitPart;
    DrawPart;
    FFlowTo.Text := FPartMemo;
    FFlowTo.AllowExpressions := False;
  end;

  if ClearEmptyLines then
  begin
    i := Memo.Count - 1;
    while i >= 0 do
    begin
      if Memo[i] = '' then
        Memo.Delete(i);
      Dec(i);
    end;
  end;
end;

function TfrxCustomMemoView.GetDataLink: TfrxDataLink;
begin
  if not Assigned(FDataLink) then
    FDataLink := TfrxDataLink.Create;
  Result := FDataLink;
end;

procedure TfrxCustomMemoView.ResetSuppress;
begin
  FLastValue := '';
end;

function TfrxCustomMemoView.CalcAndFormat(const Expr: WideString; Format: TfrxFormat): WideString;
var
  i: Integer;
  ExprStr, FormatStr: WideString;
  needFreeFormat: Boolean;
begin
  Result := '';
  needFreeFormat := False;

  i := Pos(WideString(' #'), Expr);
  if i <> 0 then
  begin
    ExprStr := Copy(Expr, 1, i - 1);
    FormatStr := Copy(Expr, i + 2, Length(Expr) - i - 1);
    if Pos(')', FormatStr) = 0 then
    begin
      Format := TfrxFormat.Create(nil);
      needFreeFormat := True;

{$IFDEF DELPHI12}
      if CharInSet(FormatStr[1], [WideChar('N'), WideChar('n')]) then
{$ELSE}
      if FormatStr[1] in [WideChar('N'), WideChar('n')] then
{$ENDIF}
      begin
        Format.Kind := fkNumeric;
        for i := 1 to Length(FormatStr) do
{$IFDEF DELPHI12}
          if CharInSet(FormatStr[i], [WideChar(','), WideChar('.'), WideChar('-')]) then
{$ELSE}
          if FormatStr[i] in [WideChar(','), WideChar('.'), WideChar('-')] then
{$ENDIF}
          begin
            Format.DecimalSeparator := FormatStr[i];
            FormatStr[i] := '.';
          end;
      end
{$IFDEF DELPHI12}
      else if  CharInSet(FormatStr[1], [WideChar('D'), WideChar('T'), WideChar('d'), WideChar('t')]) then
{$ELSE}
      else if FormatStr[1] in [WideChar('D'), WideChar('T'), WideChar('d'), WideChar('t')] then
{$ENDIF}
        Format.Kind := fkDateTime
{$IFDEF DELPHI12}
      else if CharInSet(FormatStr[1], [WideChar('B'), WideChar('b')]) then
{$ELSE}
      else if FormatStr[1] in [WideChar('B'), WideChar('b')] then
{$ENDIF}
        Format.Kind := fkBoolean;

      Format.FormatStr := Copy(FormatStr, 2, 255);
    end
    else
      ExprStr := Expr;
  end
  else
    ExprStr := Expr;

  try
    if CompareText(ExprStr, 'TOTALPAGES#') = 0 then
      FValue := '[TotalPages#]'
    else if CompareText(ExprStr, 'COPYNAME#') = 0 then
      FValue := '[CopyName#]'
    else
    begin
    if (Font.Charset <> DEFAULT_CHARSET) and not UseDefaultCharset then
      FValue := Report.Calc(String(_UnicodeToAnsi(ExprStr, Font.Charset))) else
      FValue := Report.Calc(ExprStr)
    end;
    if HideZeros and (not VarIsNull(FValue)) and (TVarData(FValue).VType <> varString) and
      (TVarData(FValue).VType <> varOleStr){$IFDEF DELPHI12} and (TVarData(FValue).VType <> varUString){$ENDIF}  and SameValue(FValue, 0, Report.EngineOptions.ZeroPrecisionValue) then
      Result := '' else
      Result := FormatData(FValue, Format);
  finally
    if needFreeFormat then
      Format.Free;
  end;
end;

function TfrxCustomMemoView.FormatData(const Value: Variant; AFormat: TfrxFormat = nil): WideString;
var
  i, DecSepPos: Integer;
  LocCharset: Boolean;
begin
  DecSepPos := 0;
  LocCharset := ((Font.Charset <> DEFAULT_CHARSET) and not UseDefaultCharset);
  if AFormat = nil then
    AFormat := DisplayFormat;
  if VarIsNull(Value) then
    Result := ''
  else if AFormat.Kind = fkText then
    if LocCharset then
      Result := AnsiToUnicode(AnsiString(VarToStr(Value)), Font.Charset)
    else Result := VarToWideStr(Value)
  else
  try
    case AFormat.Kind of
      fkNumeric:
        begin
          if (Pos('#', AFormat.FormatStr) <> 0) or (Pos('0', AFormat.FormatStr) = 1) then
            Result := FormatFloat(AFormat.FormatStr, Extended(Value))
          else if (Pos('d', AFormat.FormatStr) <> 0) or (Pos('u', AFormat.FormatStr) <> 0) then
            Result := Format(AFormat.FormatStr, [Integer(Value)])
          else
            Result := Format(AFormat.FormatStr, [Extended(Value)]);
          if (Length(AFormat.DecimalSeparator) = 1) and
{$IFDEF DELPHI16}
                  (FormatSettings.DecimalSeparator <> AFormat.DecimalSeparator[1]) then
            for i := Length(Result) downto 1 do
              if Result[i] = WideChar(FormatSettings.DecimalSeparator) then
{$ELSE}
                  (DecimalSeparator <> AFormat.DecimalSeparator[1]) then
            for i := Length(Result) downto 1 do
              if Result[i] = WideChar(DecimalSeparator) then
{$ENDIF}

              begin
                DecSepPos := i; // save dec seporator pos
                break;
              end;

          if (Length(AFormat.ThousandSeparator) = 1) and
{$IFDEF DELPHI16}
            (FormatSettings.ThousandSeparator <> AFormat.ThousandSeparator[1]) then
            for i := 1 to Length(Result) do
              if Result[i] = WideChar(FormatSettings.ThousandSeparator) then
                Result[i] := WideChar(AFormat.ThousandSeparator[1]);
{$ELSE}
            (ThousandSeparator <> AFormat.ThousandSeparator[1]) then
            for i := 1 to Length(Result) do
              if Result[i] = WideChar(ThousandSeparator) then
                Result[i] := WideChar(AFormat.ThousandSeparator[1]);
{$ENDIF}

          if DecSepPos > 0 then // replace dec seporator
            Result[DecSepPos] := WideChar(AFormat.DecimalSeparator[1]);
        end;

      fkDateTime:
        Result := FormatDateTime(AFormat.FormatStr, Value);

      fkBoolean:
        if Value = True then
           Result := Copy(AFormat.FormatStr, Pos(',', AFormat.FormatStr) + 1, 255) else
           Result := Copy(AFormat.FormatStr, 1, Pos(',', AFormat.FormatStr) - 1);
      else
        Result := VarToWideStr(Value)
    end;
  except
    if LocCharset then
      Result := AnsiToUnicode(AnsiString(VarToStr(Value)), Font.Charset)
    else Result := VarToWideStr(Value)
  end;
end;

function TfrxCustomMemoView.GetComponentText: String;
var
  i: Integer;
begin
  Result := FMemo.Text;
  if AllowExpressions then   { extract TOTALPAGES macro if any }
  begin
    i := Pos('[TOTALPAGES]', UpperCase(Result));
    if i <> 0 then
    begin
      Delete(Result, i, 12);
      Insert(IntToStr(FTotalPages), Result, i);
    end;
  end;
end;

procedure TfrxCustomMemoView.ApplyHighlight(AHighlight: TfrxHighlight);
begin
  if AHighlight <> nil then
  begin
    if AHighlight.ApplyFont then
      Font := AHighlight.Font;
    if AHighlight.ApplyFill then
      Fill := AHighlight.Fill;
    if AHighlight.ApplyFrame then
      Frame := AHighlight.Frame;
    Visible := AHighlight.Visible;
  end;
end;

procedure TfrxCustomMemoView.ApplyPreviewHighlight;
begin
  if Highlight.Active then
    ApplyHighlight(Highlight);
end;

function TfrxCustomMemoView.WrapText(WrapWords: Boolean; aParaText: TWideStrings): WideString;
var
  TempBMP: TBitmap;
  FDrawText: TfrxDrawText;
  i: Integer;
begin
  Result := '';
  TempBMP := TBitmap.Create;
  FDrawText := GetDrawTextObject;

  FDrawText.Lock;
  try
    BeginDraw(nil, 1, 1, 0, 0);
    SetDrawParams(TempBMP.Canvas, 1, 1, 0, 0);
    if WrapWords then
      Result := FDrawText.WrappedText
    else
      Result := FDrawText.DeleteTags(Text);
  finally
    FDrawText.Unlock;
    TempBMP.Free;
    if aParaText <> nil then
    begin
      aParaText.Text := Result;
      if aParaText.Count = FDrawText.Text.Count then
        for i := 0 to FDrawText.Text.Count - 1 do
          aParaText.Objects[i] := FDrawText.Text.Objects[i];
    end;
  end;
end;

procedure TfrxCustomMemoView.ExtractMacros(Dictionary: TfrxPostProcessor = nil);

{$IFNDEF DELPHI12}
function PosExW(const SubStr, S: WideString; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;
{$ENDIF}
var
  s, s1: WideString;
  j, i, slen: Integer;
  bChanged: Boolean;
begin
  if Dictionary <> nil then
    Dictionary.LoadValue(Self);

  if AllowExpressions then
  begin
    s := FMemo.Text;
    bChanged := False;

    i := Pos('[TOTALPAGES#]', UpperCase(s));
    //if i <> 0 then
    while (i > 0) do
    begin
      Delete(s, i, 13);
      Insert(IntToStr(FTotalPages), s, i);
{$IFNDEF DELPHI12}
      i := PosExW('[TOTALPAGES#]', UpperCase(s), i);
{$ELSE}
      i := PosEx('[TOTALPAGES#]', UpperCase(s), i);
{$ENDIF}
     bChanged := True;
    end;

    i := Pos('[COPYNAME#]', UpperCase(s));
    //if i <> 0 then
    while (i > 0) do
    begin
      j := frxGlobalVariables.IndexOf('CopyName' + IntToStr(FCopyNo));
      if j <> -1 then
        s1 := VarToStr(frxGlobalVariables.Items[j].Value)
      else
        s1 := '';
      Delete(s, i, 11);
      Insert(s1, s, i);
      slen := length(s1);
{$IFNDEF DELPHI12}
      i := PosExW('[COPYNAME#]', UpperCase(s), i + slen);
{$ELSE}
      i := PosEx('[COPYNAME#]', UpperCase(s), i + slen);
{$ENDIF}
      bChanged := True;
    end;

    if bChanged then FMemo.Text := s;
  end;
end;

procedure TfrxCustomMemoView.WriteNestedProperties(Item: TfrXMLItem; aAcenstor: TPersistent = nil);
begin
  if Formats.Count > 1 then
    frxWriteCollection(FFormats, 'Formats', Item, Self, nil);
  if Assigned(aAcenstor) then
    aAcenstor := TfrxCustomMemoView(aAcenstor).FHighlights;
  if Highlights.Count > 1 then
    frxWriteCollection(FHighlights, 'Highlights', Item, Self, TfrCollection(aAcenstor));
end;

function TfrxCustomMemoView.ReadNestedProperty(Item: TfrXMLItem): Boolean;
begin
  Result := True;
  if CompareText(Item.Name, 'Formats') = 0 then
    frxReadCollection(FFormats, Item, Self, nil)
  else if CompareText(Item.Name, 'Highlights') = 0 then
    frxReadCollection(FHighlights, Item, Self, nil)
  else
    Result := False;
end;


function TfrxCustomMemoView.ReducedAngle: Integer;
begin
  Result := Rotation mod 360;
  if Result < 0 then
    Result := Result + 360;
end;

{ TfrxSysMemoView }

class function TfrxSysMemoView.GetDescription: String;
begin
  Result := frxResources.Get('obSysText');
end;


{ TfrxCustomLineView }

constructor TfrxCustomLineView.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csDefaultDiff];
  FArrowWidth := 5;
  FArrowLength := 20;
end;

constructor TfrxCustomLineView.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  FDiagonal := Flags <> 0;
  FArrowEnd := Flags in [2, 4];
  FArrowStart := Flags in [3, 4];
end;

function TfrxCustomLineView.Diff(AComponent: TfrxComponent): String;
var
  aLine: TfrxCustomLineView;
begin
  Result := inherited Diff(AComponent);
  aLine := TfrxCustomLineView(AComponent);
  if FDiagonal <> aLine.FDiagonal then
    Result := Result + ' Diagonal="' + frxValueToXML(FDiagonal) + '"';
  if FArrowEnd <> aLine.FArrowEnd then
    Result := Result + ' ArrowEnd="' + frxValueToXML(FArrowEnd) + '"';
  if FArrowLength <> aLine.FArrowLength then
    Result := Result + ' ArrowLength="' + frxValueToXML(FArrowLength) + '"';
  if FArrowSolid <> aLine.FArrowSolid then
    Result := Result + ' ArrowSolid="' + frxValueToXML(FArrowSolid) + '"';
  if FArrowStart <> aLine.FArrowStart then
    Result := Result + ' ArrowStart="' + frxValueToXML(FArrowStart) + '"';
  if FArrowWidth <> aLine.FArrowWidth then
    Result := Result + ' ArrowWidth="' + frxValueToXML(FArrowWidth) + '"';
end;

procedure TfrxCustomLineView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  if not FDiagonal then
  begin
    if Width > Height then
    begin
      Height := 0;
      Frame.Typ := [ftTop];
    end
    else
    begin
      Width := 0;
      Frame.Typ := [ftLeft];
    end;
  end;

  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  if not FDiagonal then
  begin
    DrawFrame;
    if FArrowStart then
      DrawArrow(FX1, FY1, FX, FY);
    if FArrowEnd then
      DrawArrow(FX, FY, FX1, FY1);
  end
  else
    DrawDiagonalLine;
end;

procedure TfrxCustomLineView.DrawArrow(x1, y1, x2, y2: Extended);
var
  k1, a, b, c, D: Double;
  xp, yp, x3, y3, x4, y4, wd, ld: Extended;
begin
  wd := FArrowWidth * FScaleX;
  ld := FArrowLength * FScaleX;
  if abs(x2 - x1) > 8 then
  begin
    k1 := (y2 - y1) / (x2 - x1);
    a := Sqr(k1) + 1;
    b := 2 * (k1 * ((x2 * y1 - x1 * y2) / (x2 - x1) - y2) - x2);
    c := Sqr(x2) + Sqr(y2) - Sqr(ld) + Sqr((x2 * y1 - x1 * y2) / (x2 - x1)) -
      2 * y2 * (x2 * y1 - x1 * y2) / (x2 - x1);
    D := Sqr(b) - 4 * a * c;
    xp := (-b + Sqrt(D)) / (2 * a);
    if (xp > x1) and (xp > x2) or (xp < x1) and (xp < x2) then
      xp := (-b - Sqrt(D)) / (2 * a);
    yp := xp * k1 + (x2 * y1 - x1 * y2) / (x2 - x1);
    if y2 <> y1 then
    begin
      x3 := xp + wd * sin(ArcTan(k1));
      y3 := yp - wd * cos(ArcTan(k1));
      x4 := xp - wd * sin(ArcTan(k1));
      y4 := yp + wd * cos(ArcTan(k1));
    end
    else
    begin
      x3 := xp;
      y3 := yp - wd;
      x4 := xp;
      y4 := yp + wd;
    end;
  end
  else
  begin
    xp := x2;
    yp := y2 - ld;
    if (yp > y1) and (yp > y2) or (yp < y1) and (yp < y2) then
      yp := y2 + ld;
    x3 := xp - wd;
    y3 := yp;
    x4 := xp + wd;
    y4 := yp;
  end;

  if FArrowSolid then
  begin
    FCanvas.Brush.Color := Frame.Color;
    FCanvas.Polygon([Point(Round(x2), Round(y2)),
      Point(Round(x3), Round(y3)), Point(Round(x4), Round(y4)),
      Point(Round(x2), Round(y2))])
  end
  else
  begin
    FCanvas.Pen.Width := Round(FFrame.Width * FScaleX);
    FCanvas.Polyline([Point(Round(x3), Round(y3)),
      Point(Round(x2), Round(y2)), Point(Round(x4), Round(y4))]);
  end;
end;

procedure TfrxCustomLineView.DrawDiagonalLine;
begin
  if (Frame.Color = clNone) or (Frame.Width = 0) then exit;
  with FCanvas do
  begin
    Brush.Style := bsSolid;
    if Color = clNone then
      Brush.Style := bsClear else
      Brush.Color := Color;
    Pen.Color := Self.Frame.Color;
    Pen.Width := 1;
    if Self.Frame.Style <> fsDouble then
      Pen.Style := TPenStyle(Self.Frame.Style) else
      Pen.Style := psSolid;

    DrawLine(FX, FY, FX1, FY1, FFrameWidth);

    if FArrowStart then
      DrawArrow(FX1, FY1, FX, FY);
    if FArrowEnd then
      DrawArrow(FX, FY, FX1, FY1);
  end;
end;

function TfrxCustomLineView.GetVectorGraphic(DrawFill: Boolean): TGraphic;
var
  OldLeft, OldTop, OldWidth, OldHeight: Extended;
begin
  OldLeft := Left; OldTop := Top; OldWidth := Width; OldHeight := Height;
  if Width < 0 then
  begin
    FLeft := Left + Width;
    FWidth := -Width;
  end;
  if Height < 0 then
  begin
    FTop := Top + Height;
    FHeight := -Height;
  end;

  Result := inherited GetVectorGraphic(DrawFill);

  FLeft := OldLeft; FTop := OldTop; FWidth := OldWidth; FHeight := OldHeight;
end;

function TfrxCustomLineView.IsContain(X, Y: Extended): Boolean;
var
  w0, w1, w2, w3: Extended;
  r: TfrxRect;
  e, k: Extended;
begin
  w0 := 0;
  w1 := 0;
  w2 := 0;
  if Width = 0 then
  begin
    w0 := 4;
    w1 := 4
  end
  else if Height = 0 then
    w2 := 4;
  w3 := w2;

  r.Left := AbsLeft;
  r.Right := AbsLeft + Width;
  r.Top := AbsTop;
  r.Bottom := AbsTop + Height;

  if r.Right < r.Left then
  begin
    e := r.Right;
    r.Right := r.Left;
    r.Left := e;
  end;
  if r.Bottom < r.Top then
  begin
    e := r.Bottom;
    r.Bottom := r.Top;
    r.Top := e;
  end;

  Result := (X >= r.Left - w0) and
    (X <= r.Right + w1) and
    (Y >= r.Top - w2) and
    (Y <= r.Bottom + w3);

  if Diagonal and (Width <> 0) and (Height <> 0) then
  begin
    k := Height / Width;
    if Abs((k * (X - AbsLeft) - (Y - AbsTop)) * cos(ArcTan(k))) < 5 then
      Result := True;
    if (X < r.Left - 5) or (X > r.Right + 5)
      or (Y < r.Top - 5) or
      (Y > r.Bottom + 5) then
      Result := False;
  end;
end;

function TfrxCustomLineView.IsInRect(const aRect: TfrxRect): Boolean;
var
  Sign: Boolean;

  function Dist(X, Y: Extended): Boolean;
  var
    k: Extended;
  begin
    k := Height / Width;
    k := (k * (X - AbsLeft) - (Y - AbsTop)) *
      cos(ArcTan(k));
    Result := k >= 0;
  end;

begin
  Result := False;
  if Diagonal and (Width <> 0) and (Height <> 0) then
    with aRect do
    begin
      Sign := Dist(Left, Top);
      if Dist(Right, Top) <> Sign then
        Result := True;
      if Dist(Left, Bottom) <> Sign then
        Result := True;
      if Dist(Right, Bottom) <> Sign then
        Result := True;

      if Result then
        Result := Inherited IsInRect(aRect);
    end
  else
    Result := Inherited IsInRect(aRect);
end;

{ TfrxLineView }

class function TfrxLineView.GetDescription: String;
begin
  Result := frxResources.Get('obLine');
end;

{ TfrxPictureView }

procedure TfrxPictureView.AfterPrint;
begin
  TfrxDataLink.RestoreState(FDataLink);
  inherited;
end;

procedure TfrxPictureView.BeforePrint;
begin
  inherited;
  TfrxDataLink.SaveState(FDataLink);
end;

constructor TfrxPictureView.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csDefaultDiff];
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FTransparentColor := clWhite;
  FIsPictureStored := True;
  FGraphicProps := [fgdClip, fgdKeepAspectRatio, fgdStretch];
  FDataLink := nil;
end;

destructor TfrxPictureView.Destroy;
begin
  FPicture.Free;
  FreeAndNil(FDataLink);
  ReleaseCachedGraphic;
  inherited;
end;

class function TfrxPictureView.GetDescription: String;
begin
  Result := frxResources.Get('obPicture');
end;

function TfrxPictureView.GetGraphic: TGraphic;
begin
  Result := nil;
  if not IsEmpty then
  begin
    if Assigned(FCached) then
      Result := FCached.GetGraphic(cgThumbnail)
    else
      Result := FPicture.Graphic;
  end;
end;

function TfrxPictureView.GraphicHasAlpha: Boolean;
begin
  Result := False;
  if (FGFormat = nil) then
    UpdateGraphicHelper;
  { back compatibility HightQuality had priority over transparency }
  if Assigned(FGFormat) then
    Result := FGFormat.HasAlphaChanel(GetGraphic) and not (not Transparent and HightQuality);
end;

function TfrxPictureView.GraphicHasMaskColor: Boolean;
begin
  Result := False;
  if (FGFormat = nil) then
    UpdateGraphicHelper;
  if Assigned(FGFormat) then
    Result := FGFormat.HasMaskColor(GetGraphic);
end;

function TfrxPictureView.GraphicHeight: Integer;
var
  G: TGraphic;
begin
  Result := 0;
  G := GetGraphic;
  if Assigned(G) then Result := G.Height;
end;

function TfrxPictureView.GraphicIsTranslucent: Boolean;
begin
  Result := False;
  if (FGFormat = nil) then
    UpdateGraphicHelper;
  if Assigned(FGFormat) then
    Result := FGFormat.IsTranslucent;
end;

function TfrxPictureView.GraphicIsVector: Boolean;
begin
  Result := False;
  if (FGFormat = nil) then
    UpdateGraphicHelper;
  if Assigned(FGFormat) then
    Result := FGFormat.IsVector;
end;

function TfrxPictureView.GraphicTransparency: Boolean;
var
  G: TGraphic;
begin
  Result := Transparent;
  G := GetGraphic;
  if Assigned(G) then Result := Result or G.Transparent or (Assigned(FGFormat) and (FGFormat.HasAlphaChanel(G)));
end;

function TfrxPictureView.GraphicTransparentColor: TColor;
begin
  Result := FTransparentColor;
  if (FGFormat = nil) then
    UpdateGraphicHelper;
  if Assigned(FGFormat) and FGFormat.HasMaskColor(GetGraphic) and (FTransparentColor = clNone) then
    Result := FGFormat.GetTransparentColor(GetGraphic);
end;

function TfrxPictureView.GraphicWidth: Integer;
var
  G: TGraphic;
begin
  Result := 0;
  G := GetGraphic;
  if Assigned(G) then Result := G.Width;
end;

function TfrxPictureView.GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
begin
  Result := TfrxDataLink.GetLink(FDataLink, LoadMethod);
end;

function TfrxPictureView.GetPicture: TPicture;
begin
  Result := FPicture;
  if (FPicture.Graphic = nil) and Assigned(FCached) then
  begin
    try
      FPicture.OnChange := nil;
      FPicture.Graphic := FCached.GetGraphic(cgOriginal);
    finally
      FPicture.OnChange := PictureChanged;
    end;
  end;
end;

function TfrxPictureView.GetValue(const Index: Integer): Boolean;
begin
  Result := TfrxGraphicDrawProp(Index) in FGraphicProps;
end;

procedure TfrxPictureView.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TfrxPictureView.SetValue(const Index: Integer; const Value: Boolean);
var
  LIndex: TfrxGraphicDrawProp;
begin
  LIndex := TfrxGraphicDrawProp(Index);
  if Value then
    Include(FGraphicProps, LIndex)
  else
    Exclude(FGraphicProps, LIndex);
  if (LIndex = fgdAutoSize) and Value and not (FPicture.Graphic = nil) then
  begin
    FWidth := FPicture.Width;
    FHeight := FPicture.Height;
  end;
end;

procedure TfrxPictureView.UpdateGraphicHelper;
var
  GClass: TGraphicClass;
  LGraphic: TGraphic;
begin
  GClass := nil;
  if Assigned(FPicture.Graphic) and not FPicture.Graphic.Empty then
    GClass := TGraphicClass(FPicture.Graphic.ClassType)
  else if Assigned(FCached) then
  begin
    LGraphic := FCached.GetGraphic(cgThumbnail);
    if Assigned(LGraphic) and not LGraphic.Empty then
      GClass := TGraphicClass(LGraphic.ClassType);
  end;

  if GClass = nil then
  begin
    FGFormat := nil;
    Exit;
  end;
  if Assigned(FGFormat) and (FGFormat.GetGraphicClass <> GClass) then
    FGFormat := nil;
  if not Assigned(FGFormat) then
    FGFormat :=  GetGraphicFormats.FindByGraphic(GClass);
end;

procedure TfrxPictureView.GetCachedGraphic(ACacheType: TfrxCachedGraphicType; const PictureCache: IfrxPictureCache);
begin
  if not Assigned(PictureCache) then Exit;
  if PictureCache.IsAutoRefMode then
    FCached := PictureCache.GetCachedBitmap(ACacheType, FImageIndex)
  else
    PictureCache.GetPicture(FPicture, FImageIndex);
end;

procedure TfrxPictureView.SetCachedGraphic(const PictureCache: IfrxPictureCache);
begin
  if FPictureChanged then
  begin
    FImageIndex := PictureCache.AddPicture(FPicture.Graphic);
    FPictureChanged := False;
  end;
end;

procedure TfrxPictureView.SetDataLink(const Value: TfrxDataLink);
begin
  if not Assigned(FDataLink) then
    GetDataLink;
  FDataLink.Assign(Value);
end;

procedure TfrxPictureView.PictureChanged(Sender: TObject);
begin
  SetValue(Integer(fgdAutoSize), AutoSize);
  FPictureChanged := True;
  if Assigned(FCached) then
  begin
    ReleaseCachedGraphic;
    ImageIndex := 0;
  end;
  UpdateGraphicHelper;
end;

procedure TfrxPictureView.ReleaseCachedGraphic;
begin
  FCached := nil;
end;

procedure TfrxPictureView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  lGraphic: TGraphic;
  GProps: TfrxDrawGraphicExt;

  procedure UpdateProps;
  begin
    GProps.TransparentColor := FTransparentColor;
    if IsPrinting then
      GProps.Quality := gqPrint
    else if HightQuality then
      GProps.Quality := gqHiQuality
    else
      GProps.Quality := gqDefault;

    GProps.DrawProps := FGraphicProps;
  end;

begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  with Canvas do
  begin
    if not DrawAsMask then
      DrawBackground;
    if Assigned(FCached) then
      lGraphic := FCached.GetGraphic(cgThumbnail)
    else
      lGraphic := FPicture.Graphic;
    if (lGraphic = nil) or lGraphic.Empty then
    begin
      if IsDesigning then
        frxImages.ObjectImages.Draw(Canvas, FX + 1, FY + 2, 3);
    end
    else
    begin
      UpdateProps;
      UpdateGraphicHelper;
      if Assigned(FGFormat) then
        FGFormat.DrawExt(GProps, Canvas, lGraphic, Rect(FX, FY, FX1, FY1), ScaleX, ScaleY)
      else
        GetGraphicFormats.GetDefault.DrawExt(GProps, Canvas, lGraphic, Rect(FX, FY, FX1, FY1), ScaleX, ScaleY);
//        raise Exception.Create(Format('Unknown graphic format in %s', [Name]));
    end;
    DrawFrame;
    DrawFrameEdges;
//    if IsDesigning and FDrawDragDrop then
//      DrawHighlight(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  end;
end;

function TfrxPictureView.Diff(AComponent: TfrxComponent): String;
begin
  Result := ' ' + inherited Diff(AComponent) + ' ImageIndex="' +
    IntToStr(FImageIndex) + '"';
  if Transparent then
    Result := Result + ' Transparent="' + frxValueToXML(Transparent) + '"';
  if TransparentColor <> clWhite then
    Result := Result + ' TransparentColor="' + intToStr(FTransparentColor) + '"';
end;

type
  TGraphicHeader = record
    Count: Word;
    HType: Word;
    Size: Longint;
  end;

function TfrxPictureView.LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
begin
  Result := LoadPictureFromStream(Stream) = S_OK;
end;

function TfrxPictureView.LoadPictureFromStream(s: TStream; ResetStreamPos: Boolean): Hresult;
var
  pos: Integer;
  Header: TGraphicHeader;
begin
{$IFDEF FPC}
  Result := E_INVALIDARG;
  if ResetStreamPos then
    pos := 0
  else
    pos := s.Position;
  s.Position := pos;
  if s.Size > 0 then
  try
    FPicture.LoadFromStream(S);
  except
    on E:Exception do
    begin
      FPicture.Assign(nil);
      {$IFDEF DEBUGFR4}
      DebugLn('Error in TfrxPictureView.LoadPictureFromStream: '+E.Message);
      {$ENDIF}
    end;
  end
  else
    FPicture.Assign(nil); 

  if FPicture.Graphic = nil then
    Result := E_INVALIDARG
  else
    Result := S_OK;
{$ELSE}
  Result := E_INVALIDARG;
  if ResetStreamPos then
    pos := 0
  else
    pos := s.Position;

  s.Position := pos;

  if s.Size > 0 then
  begin
    // skip Delphi blob-image header
    if s.Size >= SizeOf(TGraphicHeader) then
    begin
      s.Read(Header, SizeOf(Header));
      if (Header.Count <> 1) or (Header.HType <> $0100) or
        (Header.Size <> s.Size - SizeOf(Header)) then
          s.Position := pos;
    end;
    if GetGraphicFormats.LoadFromStream(FPicture, s) then
      Result := S_OK;
  end;

  if Result <> S_OK then
    FPicture.Assign(nil);
{$ENDIF} // fpc
end;

function TfrxPictureView.IsDataLinkStored: Boolean;
begin
  Result := TfrxDataLink.IsDataLinkStored(FDataLink, frComponentState);
end;

function TfrxPictureView.IsEMFExportable: Boolean;
var
  LGraphic: TGraphic;
begin
  LGraphic := FPicture.Graphic;
  if Assigned(FCached) then
    LGraphic := FCached.GetGraphic(cgThumbnail);
  if Assigned(LGraphic) and (FGFormat = nil) then
    UpdateGraphicHelper;
  Result := inherited IsEMFExportable;// or (LGraphic is TMetafile);// remove metafile and use only FGFormat
  if Assigned(FGFormat) then
    Result := Result and FGFormat.IsVector
  else
    Result := False;
end;

function TfrxPictureView.IsEmpty: Boolean;
begin
  Result := (FCached = nil) and ((FPicture.Graphic = nil) or (FPicture.Graphic.Empty));
end;

function TfrxPictureView.IsExpressionLink: Boolean;
begin
  Result := TfrxDataLink.IsExpressionLink(FDataLink);
end;

function TfrxPictureView.IsUpdateRequired(
  NewCacheType: TfrxCachedGraphicType): Boolean;
begin
  Result := Assigned(FCached) and (FCached.GetCacheType <> NewCacheType) or ((FImageIndex > 0) and IsEmpty);
end;

procedure TfrxPictureView.GetData;
var
  m: TMemoryStream;
  s: String;
begin
  inherited;
  if FFileLink <> '' then
  begin
    s := FFileLink;
    if Pos('[', s) <> 0 then
      ExpandVariables(s);
    if FileExists(s) then
      FPicture.LoadFromFile(s)
    else
      FPicture.Assign(nil);
  end
  else if IsDataField and DataSet.IsBlobField(DataField) then
  begin
    m := TMemoryStream.Create;
    try
      DataSet.AssignBlobTo(DataField, m);
      LoadPictureFromStream(m);
    finally
      m.Free;
    end;
  end;
end;

function TfrxPictureView.GetDataLink: TfrxDataLink;
begin
  if not Assigned(FDataLink) then
    FDataLink := TfrxDataLink.Create;
  Result := FDataLink;
end;

{ TfrxBand }

constructor TfrxBand.Create(AOwner: TComponent);
begin
  inherited;
  FSubBands := TList.Create;
  FFill := TfrxBrushFill.Create;
  FFillMemo := nil;
  FFillGap := TfrxFillGaps.Create;
  FBandDesignHeader := 0;
  frComponentStyle := frComponentStyle + [csAcceptsFrxComponents];
  FFrame := TfrxFrame.Create;
  FShiftEngine := seTree;
end;

procedure TfrxBand.CreateFillMemo;
begin
  if ((Self is TfrxNullBand) or
    ((FFillType = ftBrush) and
     (TfrxBrushFill(FFill).BackColor = clNone) and
     (TfrxBrushFill(FFill).ForeColor = clBlack) and
     (TfrxBrushFill(FFill).Style = bsSolid) and
     (FFrame.Typ = []))) then Exit;
  if FFillMemo = nil then
    FFillMemo := TfrxMemoView.Create(Self);
  FFillMemo.Align := baHidden;
  FFillMemo.Parent := Self;
  FFillMemo.FillType := FFillType;
  FFillMemo.Fill.Assign(FFill);
  FFillMemo.Frame.Assign(FFrame);
  FFillMemo.Height := Height - FFillgap.FTop - FFillGap.FBottom;
  FFillMemo.Width := Width - FFillgap.FLeft - FFillGap.FRight;
  FFillMemo.Top := FFillgap.FTop;
  FFillMemo.Left := FFillgap.FLeft;
  Objects.Remove(FFillMemo);
  Objects.Insert(0, FFillMemo);
end;

destructor TfrxBand.Destroy;
begin
  FSubBands.Free;
  FFill.Free;
  FFillGap.Free;
  FFrame.Free;
  inherited;
end;

procedure TfrxBand.DisposeFillMemo;
begin
  if Assigned(FFillMemo) then
    FreeAndNil(FFillMemo);
end;

function TfrxBand.IsContain(X, Y: Extended): Boolean;
var
  w0, w1, w2, w3: Extended;
begin
  w0 := 0;
  w1 := 2;
  w2 := 0;
  if Width = 0 then
  begin
    w0 := 4;
    w1 := 4
  end
  else if Height = 0 then
    w2 := 4;
  w3 := w2;

  if Vertical then
    w0 := BandDesignHeader
  else
    w2 := BandDesignHeader;

  Result := (X >= AbsLeft - w0) and
    (X <= AbsLeft + Width + w1) and
    (Y >= AbsTop - w2) and
    (Y <= AbsTop + Height + w3 + 1);
end;

procedure TfrxBand.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FChild) then
    FChild := nil;
end;

procedure TfrxBand.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  dX, dY, dX1, dY1: Integer;
  x, y: Integer;
  fh, oldfh: HFont;
  bName: String;
begin
  if IsDesigning then
  begin
    dx := Round(AbsLeft * ScaleX + OffsetX);
    dy := Round(AbsTop * ScaleY + OffsetY);
    dX1 := Round((AbsLeft + Width) * ScaleX + OffsetX);
    dY1 := Round((AbsTop + Height) * ScaleY + OffsetY);
    FFill.Draw(Canvas, dx, dy, dX1, dY1, ScaleX, ScaleY);

    with Canvas do
    begin
      if Vertical then
      begin
        Top := 0;
        Pen.Style := psSolid;
        Pen.Color := clGray;
        Pen.Width := 1;
        Brush.Style := bsClear;
        X := Round((Left - BandDesignHeader) * ScaleX);
        Rectangle(X, 0, Round((Left + Self.Width) * ScaleX) + 1,
          Round(Self.Height * ScaleY));

        if BandDesignHeader <> 0 then
        begin
          Brush.Style := bsSolid;
          Brush.Color := GetBandTitleColor;
          FillRect(Rect(X + 1, 1, Round(Left * ScaleX),
            Round(Self.Height * ScaleY)));
        end;

        Font.Name := DefFontNameBand;
        Font.Size := 8;
        Font.Height := Round(Font.Height * ScaleY / (Screen.PixelsPerInch / frx_DefaultPPI));
        Font.Color := clBlack;
        Font.Style := [];
        fh := frxCreateRotatedFont(Font, 90);
        oldfh := SelectObject(Handle, fh);
        Y := TextWidth(Name) + 4;
        TextOut(X + 2, Y, Name);
        SelectObject(Handle, oldfh);
        DeleteObject(fh);
        Font.Style := [fsBold];
        fh := frxCreateRotatedFont(Font, 90);
        oldfh := SelectObject(Handle, fh);
        bName := frxResources.Get(BandName);
        TextOut(X + 2, Y + TextWidth(bName + ': ') + 2, bName + ': ');
        SelectObject(Handle, oldfh);
        DeleteObject(fh);
      end
      else
      begin
        Left := 0;
        if (Page is TfrxReportPage) and (TfrxReportPage(Page).Columns > 1) then
          if BandNumber in [4 .. 16] then
            Self.Width := TfrxReportPage(Page).ColumnWidth * fr01cm;
        Pen.Style := psSolid;
        Pen.Color := clGray;
        Pen.Width := 1;
        Brush.Style := bsClear;
        Y := Round((Top - BandDesignHeader) * ScaleY);
        Rectangle(0, Y, Round(Self.Width * ScaleX) + 1,
          Round((Top + Self.Height) * ScaleY) + 1);

        if BandDesignHeader <> 0 then
        begin
          Brush.Style := bsSolid;
          Brush.Color := GetBandTitleColor;
          FillRect(Rect(1, Y + 1, Round(Self.Width * ScaleX), Round(Top * ScaleY)));
        end;

        Font.Name := DefFontNameBand;
        Font.Size := 8;
        Font.Height := Round(Font.Height * ScaleY / (Screen.PixelsPerInch / frx_DefaultPPI));
        Font.Color := clBlack;
        Font.Style := [fsBold];
        bName := frxResources.Get(BandName);
        TextOut(6, Y + 2, bName);
        Font.Style := [];
        TextOut(PenPos.X, Y + 2, ': ' + Name);
      end
    end;
    if Assigned(FComponentEditors) then
      FComponentEditors.DrawCustomEditor(Canvas, Rect(dx, dy, dx1, dy1));
  end;
end;

function TfrxBand.GetBandName: String;
begin
  Result := ClassName;
  Delete(Result, Pos('Tfrx', Result), 4);
  Delete(Result, Pos('Band', Result), 4);
end;

function TfrxBand.GetBandTitleColor: TColor;
begin
  Result := clBtnFace;
end;

function TfrxBand.GetContainedComponent(X, Y: Extended;
  IsCanContain: TfrxComponent): TfrxComponent;
var
  SaveLeft: Extended;
begin
  Result := nil;
  { emulate vertical band behaviour in the report designer }
  if FVertical and Assigned(Parent) and IsContain(X, Y) then
  begin
    if IsCanContain = Self then
     Exit;
    SaveLeft := Left;
    { dirty hack, hide band for IsContain }
    Left := -10000;
    try
      Result := Parent.GetContainedComponent(X, Y, IsCanContain);
    finally
      Left := SaveLeft;
    end;
    if ((Result is TfrxPage) or (Result is TfrxBand)) and (IsCanContain = nil) then
      Result := Self;
  end
  else
    Result := inherited GetContainedComponent(X, Y, IsCanContain);
  { #509861 compatibility with old behaviour }
  { it should be fixed on Engine level       }
  if (Result = Self) and not IsDesigning then
    Result := nil;
end;

function TfrxBand.BandNumber: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to BND_COUNT - 1 do
    if Self is frxBands[i] then
      Result := i;
end;

class function TfrxBand.GetDescription: String;
begin
  Result := frxResources.Get('obBand');
end;

procedure TfrxBand.SetLeft(Value: Extended);
begin
  if Parent is TfrxDMPPage then
    Value := Round(Value / fr1CharX) * fr1CharX;
  inherited;
end;

procedure TfrxBand.SetTop(Value: Extended);
begin
  if Parent is TfrxDMPPage then
    Value := Round(Value / fr1CharY) * fr1CharY;
  inherited;
end;

procedure TfrxBand.SetVertical(const Value: Boolean);
begin
{$IFDEF RAD_ED}
  FVertical := False;
{$ELSE}
  FVertical := Value;
{$ENDIF}
end;

procedure TfrxBand.SetHeight(Value: Extended);
begin
  if Parent is TfrxDMPPage then
    Value := Round(Value / fr1CharY) * fr1CharY;
  inherited;
end;

procedure TfrxBand.SetChild(Value: TfrxChild);
var
  b: TfrxBand;
begin
  b := Value;
  while b <> nil do
  begin
    b := b.Child;
    if b = Self then
      raise Exception.Create(frxResources.Get('clCirRefNotAllow'));
  end;
  FChild := Value;
end;

procedure TfrxBand.SetFill(const Value: TfrxCustomFill);
begin
  FillType := frxGetFillType(Value);
  FFill.Assign(Value);
end;

procedure TfrxBand.SetFillType(const Value: TfrxFillType);
begin
  if FFillType = Value then Exit;
  FFill.Free;
  if Value = ftBrush then
    FFill := TfrxBrushFill.Create
  else if Value = ftGradient then
    FFill := TfrxGradientFill.Create
  else if Value = ftGlass then
    FFill := TfrxGlassFill.Create;
  FFillType := Value;
  if (Report <> nil) and (Report.Designer <> nil) then
    TfrxCustomDesigner(Report.Designer).UpdateInspector;
end;

procedure TfrxBand.SetFrame(const Value: TfrxFrame);
begin
  FFrame.Assign(Value);
end;

procedure TfrxBand.SetGaps(const Value: TfrxFillGaps);
begin
  FFillGap.Assign(Value);
end;

{ TfrxDataBand }

constructor TfrxDataBand.Create(AOwner: TComponent);
begin
  inherited;
{$IFDEF FPC}
  FDataSet := nil;
  FDataSetName := '';
{$ENDIF}
end;

destructor TfrxDataBand.Destroy;
begin
  FreeAndNil(FVirtualDataSet);
  inherited;
end;

procedure TfrxDataBand.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  s: String;
  i, w, y: Integer;
begin
  inherited;
  if not Vertical then
    with Canvas do
    begin
      Font.Name := DefFontNameBand;
      Font.Size := Round(8 * ScaleY);
      // scale down when primary monitor PPI is greater than 96
      Font.Height := MulDiv(Font.Height, frx_DefaultPPI, Font.PixelsPerInch);
      Font.Color := clBlack;
      Font.Style := [];
      y := Round((Top - BandDesignHeader) * ScaleY);
      if FBandDesignHeader <> 0 then
      begin
        if (DataSet <> nil) and (Report <> nil) then
          s := Report.GetAlias(DataSet)
        else if RowCount <> 0 then
          s := IntToStr(RowCount)
        else
          s := '';
        w := TextWidth(s);
        if ScaleX > 0.7 then
          frxImages.MainButtonImages.Draw(Canvas,
            Round(Self.Width * ScaleX - w - frxImages.MainButtonImages.Width  - 4), Round(Y + 2 * ScaleY), 53);
        if s <> '' then
          TextOut(Round(Self.Width * ScaleX - w - 3), Y + 3, s);
      end;
      if Columns > 1 then
      begin
        Pen.Style := psDot;
        Pen.Color := clBlack;
        Brush.Style := bsClear;
        for i := 1 to Columns do
          Rectangle(Round((i - 1) * (ColumnWidth + ColumnGap) * ScaleX),
            Round(Top * ScaleY),
            Round(((i - 1) * (ColumnWidth + ColumnGap) + ColumnWidth) * ScaleX),
            Round((Top + Self.Height) * ScaleY));
      end;
    end;
end;

class function TfrxDataBand.GetDescription: String;
begin
  Result := frxResources.Get('obDataBand');
end;

function TfrxDataBand.GetVirtualDataSet: TfrxUserDataSet;
begin
  if FVirtualDataSet = nil then
  begin
    FVirtualDataSet := TfrxUserDataSet.Create(nil);
    FVirtualDataSet.RangeEnd := reCount;
  end;
  Result := FVirtualDataSet;
end;

procedure TfrxDataBand.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDataSet) then
    FDataSet := nil;
end;

procedure TfrxDataBand.SetCurColumn(Value: Integer);
begin
  if Value > FColumns then
    Value := 1;
  FCurColumn := Value;
  if FCurColumn = 1 then
    FMaxY := 0;
  FLeft := (FCurColumn - 1) * (FColumnWidth + FColumnGap);
end;

procedure TfrxDataBand.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxDataBand.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxDataBand.GetBandTitleColor: TColor;
begin
  Result := $30A7E0;
  if Vertical then
    Result := $EEBB00;
end;

function TfrxDataBand.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

procedure TfrxDataBand.SetRowCount(const Value: Integer);
begin
  FRowCount := Value;
  if FRowCount > 0 then
    VirtualDataSet.RangeEndCount := Value;
end;

{ TfrxPageHeader }

constructor TfrxPageHeader.Create(AOwner: TComponent);
begin
  inherited;
  FPrintOnFirstPage := True;
end;


{ TfrxPageFooter }

constructor TfrxPageFooter.Create(AOwner: TComponent);
begin
  inherited;
  FPrintOnFirstPage := True;
  FPrintOnLastPage := True;
end;

{ TfrxGroupHeader }

function TfrxGroupHeader.Diff(AComponent: TfrxComponent): String;
begin
  Result := inherited Diff(AComponent);
 if FDrillDown then
  Result := Result + ' DrillName="' + FDrillName + '"';
end;


procedure TfrxGroupHeader.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);

begin
  inherited;
  Canvas.Font.Name := DefFontNameBand;
  Canvas.Font.Size := Round(8 * ScaleY);
  Canvas.Font.Color := clBlack;
  Canvas.Font.Style := [];
  if Condition <> '' then
    if FBandDesignHeader <> 0 then
      Canvas.TextOut(Round(Width * ScaleX - Canvas.TextWidth(Condition) - 3), Round((Top - BandDesignHeader) * ScaleY) + 3, Condition);
end;

{ TfrxSubreport }

constructor TfrxSubreport.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle - [csPreviewVisible];
  FFrame.Typ := [ftLeft, ftRight, ftTop, ftBottom];
  FFont.Name := 'Tahoma';
  FFont.Size := 8;
  Color := clSilver;
end;

destructor TfrxSubreport.Destroy;
begin
  if FPage <> nil then
    FPage.FSubReport := nil;
  inherited;
end;

procedure TfrxSubreport.SetPage(const Value: TfrxReportPage);
begin
  FPage := Value;
  if FPage <> nil then
    FPage.FSubReport := Self;
end;

procedure TfrxSubreport.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  inherited;

  with Canvas do
  begin
    Font.Assign(FFont);
    TextOut(FX + 2, FY + 2, Name);
  end;
end;

class function TfrxSubreport.GetDescription: String;
begin
  Result := frxResources.Get('obSubRep');
end;

{ TfrxDialogPage }

constructor TfrxDialogPage.Create(AOwner: TComponent);
var
  FSaveTag: Integer;
begin
  inherited;
  FSaveTag := Tag;
  if (Report <> nil) and Report.EngineOptions.EnableThreadSafe then
    Tag := 318
  else
    Tag := 0;
  FForm := TfrxDialogForm.Create(Self);
  Tag := FSaveTag;
  FForm.KeyPreview := True;
  Font.Name := 'Tahoma';
  Font.Size := 8;
  BorderStyle := bsSizeable;
  Position := poScreenCenter;
  WindowState := wsNormal;
  Color := clBtnFace;
  FForm.ShowHint := True;
  FClientWidth := 0;
  FClientHeight := 0;
  FCurrentPPI := Screen.PixelsPerInch;
end;

destructor TfrxDialogPage.Destroy;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS.Enter;
{$ENDIF}
  try
    inherited;
    FreeAndNil(FForm);
  finally
{$IFNDEF NO_CRITICAL_SECTION}
    frxCS.Leave;
{$ENDIF}
  end;
end;

destructor TfrxPage.Destroy;
begin
 FHGuides.Free;
 FVGuides.Free;
 inherited;
end;

class function TfrxDialogPage.GetDescription: String;
begin
  Result := frxResources.Get('obDlgPage');
end;

function TfrxDialogPage.GetDoubleBuffered: Boolean;
begin
  Result := FForm.DoubleBuffered;
end;

procedure TfrxDialogPage.SetLeft(Value: Extended);
begin
  inherited;
  FForm.Left := Round(Value * GetPPIScale);
end;

procedure TfrxDialogPage.SetTop(Value: Extended);
begin
  inherited;
  FForm.Top := Round(Value * GetPPIScale);
end;

procedure TfrxDialogPage.SetWidth(Value: Extended);
begin
  inherited;
  if IsLoading and (FClientWidth <> 0) then Exit;
  FForm.Width := Round(Value * GetPPIScale);
end;

procedure TfrxDialogPage.SetHeight(Value: Extended);
begin
  inherited;
  if IsLoading and (FClientHeight <> 0) then Exit;
  FForm.Height := Round(Value * GetPPIScale);
end;

procedure TfrxDialogPage.SetClientWidth(Value: Extended);
begin
  FForm.ClientWidth := Round(Value * GetPPIScale);
  FClientWidth := Value;
  inherited SetWidth(FForm.Width / GetPPIScale);
end;

procedure TfrxDialogPage.SetClientHeight(Value: Extended);
begin
  FForm.ClientHeight := Round(Value * GetPPIScale);
  FClientHeight := Value;
  inherited SetHeight(FForm.Height / GetPPIScale);
end;

procedure TfrxDialogPage.SetScaled(Value: Boolean);
begin
  FForm.Scaled := Value;
end;

function TfrxDialogPage.GetScaled: Boolean;
begin
  Result := FForm.Scaled;
end;

function TfrxDialogPage.GetClientWidth: Extended;
begin
  Result := FForm.ClientWidth / (FCurrentPPI / frx_DefaultPPI);
end;

function TfrxDialogPage.GetClientHeight: Extended;
begin
  Result := FForm.ClientHeight / (FCurrentPPI / frx_DefaultPPI);
end;

procedure TfrxDialogPage.SetBorderStyle(const Value: TFormBorderStyle);
begin
  FBorderStyle := Value;
end;

procedure TfrxDialogPage.SetCaption(const Value: String);
begin
  FCaption := Value;
  FForm.Caption := Value;
end;

procedure TfrxDialogPage.SetColor(const Value: TColor);
begin
  FColor := Value;
  FForm.Color := Value;
end;

procedure TfrxDialogPage.SetDoubleBuffered(const Value: Boolean);
begin
  FForm.DoubleBuffered := Value;
end;

function TfrxDialogPage.IsClientSizeStored: Boolean;
begin
{$IFDEF FPC}
  Result := False;
{$ELSE}
  Result := True;
{$ENDIF}
end;

function TfrxDialogPage.GetModalResult: TModalResult;
begin
  Result := FForm.ModalResult;
end;

function TfrxDialogPage.GetPPIScale: Single;
begin
  Result := FCurrentPPI / frx_DefaultPPI
end;

procedure TfrxDialogPage.SetModalResult(const Value: TModalResult);
begin
  FForm.ModalResult := Value;
end;

procedure TfrxDialogPage.FontChanged(Sender: TObject);
begin
  inherited;
  FForm.Font := Font;
end;

procedure TfrxDialogPage.DoInitialize;
begin
  if FForm.Visible then
    FForm.Hide;
  FForm.Position := FPosition;
  FForm.WindowState := FWindowState;
  FForm.OnActivate := DoOnActivate;
  FForm.OnClick := DoOnClick;
  FForm.OnCloseQuery := DoOnCloseQuery;
  FForm.OnDeactivate := DoOnDeactivate;
  FForm.OnHide := DoOnHide;
  FForm.OnKeyDown := DoOnKeyDown;
  FForm.OnKeyPress := DoOnKeyPress;
  FForm.OnKeyUp := DoOnKeyUp;
  FForm.OnShow := DoOnShow;
  FForm.OnResize := DoOnResize;
  FForm.OnMouseMove := DoOnMouseMove;
end;

procedure TfrxDialogPage.Initialize;
begin
{$IFNDEF FR_COM}
//  if (Report <> nil) and (Report.EngineOptions.ReportThread <> nil) then
//    THackThread(Report.EngineOptions.ReportThread).Synchronize(DoInitialize) else
{$ENDIF}
  ThreadSynchronize(DoInitialize);
end;

function TfrxDialogPage.IsContain(X, Y: Extended): Boolean;
begin
  Result := inherited IsContain(X + AbsLeft, Y + AbsTop);
end;

function TfrxDialogPage.ShowModal: TModalResult;
begin
  ThreadSynchronize(DoShowModal);
  Result := FForm.ModalResult;
end;

function TfrxDialogPage.IsSupportsGuidlines: Boolean;
begin
  Result := True;
end;

procedure TfrxDialogPage.UpdateDialogPPI(aNewPPI: Integer);
var
  i: Integer;
begin
  FCurrentPPI := aNewPPI;
  for i := 0 to Objects.Count - 1 do
    if TObject(Objects[i]) is TfrxDialogControl then
      TfrxDialogControl(Objects[i]).UpdateControlPPI(aNewPPI);
end;

procedure TfrxDialogPage.UpdateControlsCoords;
{$IFDEF FPC}
var
  i: Integer;
{$ENDIF}
begin
{$IFDEF FPC}
  for i := 0 to AllObjects.Count - 1 do
    if TObject(AllObjects[i]) is TfrxDialogControl then
     TfrxDialogControl(AllObjects[i]).CorrectControlCoordinates;
{$ENDIF}
end;

procedure TfrxDialogPage.DoModify(Sender: TObject);
var
  lScale: Single;
begin
  lScale := GetPPIScale;
  FLeft := FForm.Left / lScale;
  FTop := FForm.Top / lScale;
{$IFDEF FPC}
  if Assigned(FForm.Parent) then
  begin
    FWidth := FForm.ClientWidth / lScale;
    FHeight := FForm.ClientHeight / lScale;
    Exit;
  end;
{$ENDIF}
  FWidth := FForm.Width / lScale;
  FHeight := FForm.Height / lScale;
end;

procedure TfrxDialogPage.DoOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (Report <> nil) then
  begin
    Report.SetProgressMessage('', True);
  end;
end;

procedure TfrxDialogPage.DoOnActivate(Sender: TObject);
var
  i: Integer;
begin
  DoModify(nil);
  if Report <> nil then
    Report.DoNotifyEvent(Sender, FOnActivate, True);
  for i := 0 to AllObjects.Count - 1 do
  begin
    if (TObject(AllObjects[i]) is TfrxDialogControl) and
    Assigned(TfrxDialogControl(AllObjects[i]).OnActivate) then
      TfrxDialogControl(AllObjects[i]).OnActivate(Self);
  end;
  UpdateControlsCoords;
end;

procedure TfrxDialogPage.DoOnClick(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Sender, FOnClick, True);
end;

procedure TfrxDialogPage.DoOnCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Sender), CanClose]);
  Report.DoParamEvent(FOnCloseQuery, v, True);
  CanClose := v[1];
end;

procedure TfrxDialogPage.DoOnDeactivate(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Sender, FOnDeactivate, True);
end;

procedure TfrxDialogPage.DoOnHide(Sender: TObject);
begin
  if Report <> nil then
    Report.DoNotifyEvent(Sender, FOnHide, True);
end;

procedure TfrxDialogPage.DoOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Sender), Key, ShiftToByte(Shift)]);
  if Report <> nil then
    Report.DoParamEvent(FOnKeyDown, v, True);
  Key := v[1];
end;

procedure TfrxDialogPage.DoOnKeyPress(Sender: TObject; var Key: Char);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Sender), Key]);
  if Report <> nil then
    Report.DoParamEvent(FOnKeyPress, v, True);
  if VarToStr(v[1]) <> '' then
    Key := VarToStr(v[1])[1]
  else
    Key := Chr(0);
end;

procedure TfrxDialogPage.DoOnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  v: Variant;
begin
  v := VarArrayOf([frInteger(Sender), Key, ShiftToByte(Shift)]);
  if Report <> nil then
    Report.DoParamEvent(FOnKeyUp, v, True);
  Key := v[1];
end;

procedure TfrxDialogPage.DoOnShow(Sender: TObject);
begin
  FForm.Perform(CM_FOCUSCHANGED, 0, frInteger(FForm.ActiveControl));
  Report.DoNotifyEvent(Sender, FOnShow, True);
{$IFDEF FPC}
  SetBounds(Left, Top, Width, Height);
{$ENDIF}
end;

procedure TfrxDialogPage.DoShowModal;
begin
  Initialize;
  FForm.BorderStyle := FBorderStyle;
  FForm.FormStyle := fsNormal;
  try
    TfrxDialogForm(FForm).OnModify := DoModify;
    FForm.ShowModal;
  finally
    FForm.FormStyle := fsStayOnTop;
  end;
end;

procedure TfrxDialogPage.DoOnResize(Sender: TObject);
begin
  Report.DoNotifyEvent(Sender, FOnResize, True);
end;


{ TfrxReportPage }

procedure TfrxReportPage.ClearMarginOffset;
begin
  Left := 0;
  Top := 0;
end;

constructor TfrxReportPage.Create(AOwner: TComponent);
begin
  inherited;
  FBackPicture := TfrxPictureView.Create(nil);
  FBackPicture.Color := clTransparent;
  FBackPicture.KeepAspectRatio := False;
  FColumnPositions := TStringList.Create;
  FOrientation := poPortrait;
  PaperSize := DMPAPER_A4;
  FBin := DMBIN_AUTO;
  FBinOtherPages := DMBIN_AUTO;
  FBaseName := 'Page';
  FSubBands := TList.Create;
  FVSubBands := TList.Create;
  FPrintIfEmpty := True;
  FTitleBeforeHeader := True;
  FBackPictureVisible := True;
  FBackPicturePrintable := True;
  FBackPictureStretched := True;
  FShowTitleOnPreviousPage := True;
  FMirrorMode := [];
  FPageCount := 1;
end;

constructor TfrxReportPage.CreateInPreview(AOwner: TComponent; AReport: TfrxReport);
begin
  Create(AOwner);
  FReport := AReport;
end;

destructor TfrxReportPage.Destroy;
begin
  FColumnPositions.Free;
  FBackPicture.Free;
  FSubBands.Free;
  FVSubBands.Free;
  if FSubReport <> nil then
    FSubReport.FPage := nil;
  inherited;
end;

class function TfrxReportPage.GetDescription: String;
begin
  Result := frxResources.Get('obRepPage');
end;

procedure TfrxReportPage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDataSet) then
    FDataSet := nil;
end;

procedure TfrxReportPage.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxReportPage.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxReportPage.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

procedure TfrxReportPage.SetPaperHeight(const Value: Extended);
begin
  FPaperHeight := Round8(Value);
  FPaperSize := 256;
  UpdateDimensions;
end;

procedure TfrxReportPage.SetPaperWidth(const Value: Extended);
begin
  FPaperWidth := Round8(Value);
  FPaperSize := 256;
  UpdateDimensions;
end;

procedure TfrxReportPage.SetPaperSize(const Value: Integer);
var
  e: Extended;
begin
  FPaperSize := Value;
  if FPaperSize < DMPAPER_USER then
  begin
    if frxGetPaperDimensions(FPaperSize, FPaperWidth, FPaperHeight) then
      if FOrientation = poLandscape then
      begin
        e := FPaperWidth;
        FPaperWidth := FPaperHeight;
        FPaperHeight := e;
      end;
    UpdateDimensions;
  end;
end;

procedure TfrxReportPage.SetSizeAndDimensions(ASize: Integer; AWidth,
  AHeight: Extended);
begin
  FPaperWidth := Round8(AWidth);
  FPaperHeight := Round8(AHeight);
  PaperSize := ASize;
  UpdateDimensions;
end;

procedure TfrxReportPage.SetColumns(const Value: Integer);
begin
  FColumns := Value;
  FColumnPositions.Clear;
  if FColumns <= 0 then exit;

  FColumnWidth := (FPaperWidth - FLeftMargin - FRightMargin) / FColumns;
  while FColumnPositions.Count < FColumns do
    FColumnPositions.Add(FloatToStr(FColumnPositions.Count * FColumnWidth));
end;

procedure TfrxReportPage.SetPageCount(const Value: Integer);
begin
  if Value > 0 then
    FPageCount := Value;
end;

procedure TfrxReportPage.SetOrientation(Value: TPrinterOrientation);
var
  e, m1, m2, m3, m4: Extended;
begin
  if FOrientation <> Value then
  begin
    e := FPaperWidth;
    FPaperWidth := FPaperHeight;
    FPaperHeight := e;

    m1 := FLeftMargin;
    m2 := FRightMargin;
    m3 := FTopMargin;
    m4 := FBottomMargin;

    if Value = poLandscape then
    begin
      FLeftMargin := m3;
      FRightMargin := m4;
      FTopMargin := m2;
      FBottomMargin := m1;
    end
    else
    begin
      FLeftMargin := m4;
      FRightMargin := m3;
      FTopMargin := m1;
      FBottomMargin := m2;
    end;
    UpdateDimensions;
  end;

  FOrientation := Value;
end;

procedure TfrxReportPage.UpdateDimensions;
begin
  Width := Round(FPaperWidth * fr01cm);
  Height := Round(FPaperHeight * fr01cm);
end;

procedure TfrxPage.ClearGuides;
begin
  FHGuides.Clear;
  FVGuides.Clear;
end;

procedure TfrxPage.SetHGuides(const Value: TStrings);
begin
  FHGuides.Assign(Value);
end;

procedure TfrxPage.SetVGuides(const Value: TStrings);
begin
  FVGuides.Assign(Value);
end;

function TfrxReportPage.FindBand(Band: TfrxBandClass): TfrxBand;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FObjects.Count - 1 do
    if TObject(FObjects[i]) is Band then
    begin
      Result := FObjects[i];
      break;
    end;
end;

function TfrxReportPage.IsSubReport: Boolean;
begin
  Result := SubReport <> nil;
end;

procedure TfrxReportPage.SetColumnPositions(const Value: TStrings);
begin
  FColumnPositions.Assign(Value);
end;

function TfrxReportPage.GetFrame: TfrxFrame;
begin
  Result := FBackPicture.Frame;
end;

procedure TfrxReportPage.SetFrame(const Value: TfrxFrame);
begin
  FBackPicture.Frame := Value;
end;

procedure TfrxReportPage.SetMarginOffset(PageIndex: Integer);
begin
  if MirrorMargins and Odd(PageIndex) then
    Left := RightMargin * fr01cm
  else
    Left := LeftMargin * fr01cm;

  Top := TopMargin * fr01cm;
end;

function TfrxReportPage.GetColor: TColor;
begin
  Result := FBackPicture.Color;
end;

procedure TfrxReportPage.SetColor(const Value: TColor);
begin
  FBackPicture.Color := Value;
end;

function TfrxReportPage.GetBackPicture: TPicture;
begin
  Result := FBackPicture.Picture;
end;

function TfrxReportPage.IsSupportsGuidlines: Boolean;
begin
  Result := True;
end;

procedure TfrxReportPage.SetBackPicture(const Value: TPicture);
begin
  FBackPicture.Picture := Value;
end;

procedure TfrxReportPage.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  Inherited;
  if FBackPictureStretched then
    begin
      FBackPicture.Width := (FPaperWidth - FLeftMargin - FRightMargin) * fr01cm;
      FBackPicture.Height := (FPaperHeight - FTopMargin - FBottomMargin) * fr01cm;
    end
  else
    begin
      FBackPicture.Width := FBackPicture.Picture.Width;
      FBackPicture.Height := FBackPicture.Picture.Height;
    end;
  if FBackPictureVisible and (not IsPrinting or FBackPicturePrintable) then
    FBackPicture.Draw(Canvas, ScaleX, ScaleY,
      OffsetX + FLeftMargin * fr01cm * ScaleX,
      OffsetY + FTopMargin * fr01cm * ScaleY);
end;

procedure TfrxReportPage.SetDefaults;
begin
  FLeftMargin := 10;
  FRightMargin := 10;
  FTopMargin := 10;
  FBottomMargin := 10;
  FPaperWidth := frxPrinters.Printer.DefPaperWidth;
  FPaperHeight := frxPrinters.Printer.DefPaperHeight;
  {$IFNDEF Linux}
  FOrientation := frxPrinters.Printer.DefOrientation;
  {$ENDIF}
  PaperSize := frxPrinters.Printer.DefPaper;
  UpdateDimensions;
end;

procedure TfrxReportPage.AlignChildren(IgnoreInvisible: Boolean; MirrorModes: TfrxMirrorControlModes);
var
  i: Integer;
  c: TfrxComponent;
begin
  Width := (FPaperWidth - FLeftMargin - FRightMargin) * fr01cm;
  Height := (FPaperHeight - FTopMargin - FBottomMargin) * fr01cm;
  inherited AlignChildren(IgnoreInvisible, MirrorModes);
  for i := 0 to Objects.Count - 1 do
  begin
    c := Objects[i];
    if c is TfrxBand then
    begin
      if TfrxBand(c).Vertical then
        c.Height := (FPaperHeight - FTopMargin - FBottomMargin) * fr01cm - c.Top
      else
        if (Columns > 1) and not((c is TfrxNullBand) or (c is TfrxReportSummary) or
          (c is TfrxPageHeader) or (c is TfrxPageFooter) or
          (c is TfrxReportTitle) or (c is TfrxOverlay)) then
          c.Width := ColumnWidth * fr01cm
        else
          c.Width := Width - c.Left;

      c.DoMirror(MirrorModes);
      c.AlignChildren(IgnoreInvisible, MirrorModes);
    end;
  end;
  UpdateDimensions;
end;

{ TfrxDataPage }

constructor TfrxDataPage.Create(AOwner: TComponent);
begin
  inherited;
  Width := 1000;
  Height := 1000;
end;

class function TfrxDataPage.GetDescription: String;
begin
  Result := frxResources.Get('obDataPage');
end;


{ TfrxEngineOptions }

constructor TfrxEngineOptions.Create;
begin
  Clear;
  FMaxMemSize := 10;
  FPrintIfEmpty := True;
  FSilentMode := simMessageBoxes;
  FEnableThreadSafe := False;
  FTempDir := '';
  FUseGlobalDataSetList := True;
  FUseFileCache := False;
  FDestroyForms := True;
  FZeroPrecisionValue := 1E-17;
end;

procedure TfrxEngineOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxEngineOptions then
  begin
    FConvertNulls := TfrxEngineOptions(Source).ConvertNulls;
    FDoublePass := TfrxEngineOptions(Source).DoublePass;
    FMaxMemSize := TfrxEngineOptions(Source).MaxMemSize;
    FPrintIfEmpty := TfrxEngineOptions(Source).PrintIfEmpty;
    NewSilentMode := TfrxEngineOptions(Source).NewSilentMode;
    FTempDir := TfrxEngineOptions(Source).TempDir;
    FUseFileCache := TfrxEngineOptions(Source).UseFileCache;
    FIgnoreDevByZero := TfrxEngineOptions(Source).IgnoreDevByZero;
    FIgnoreExprError := TfrxEngineOptions(Source).IgnoreExprError;
    FZeroPrecisionValue := TfrxEngineOptions(Source).ZeroPrecisionValue;
  end;
end;

procedure TfrxEngineOptions.AssignThreadProps(Source: TPersistent);
begin
  if Source is TfrxEngineOptions then
  begin
    NewSilentMode := TfrxEngineOptions(Source).NewSilentMode;
    FUseFileCache := TfrxEngineOptions(Source).UseFileCache;
    FDestroyForms := TfrxEngineOptions(Source).FDestroyForms;
    FEnableThreadSafe := TfrxEngineOptions(Source).FEnableThreadSafe;
    FUseGlobalDataSetList := TfrxEngineOptions(Source).FUseGlobalDataSetList;
  end;
end;

procedure TfrxEngineOptions.Clear;
begin
  FConvertNulls := True;
  FIgnoreDevByZero := False;
  FIgnoreExprError := False;
  FDoublePass := False;
  FZeroPrecisionValue := 1E-17;
end;

procedure TfrxEngineOptions.SetSilentMode(Mode: Boolean);
begin
  if Mode = True then
    FSilentMode := simSilent
  else
    FSilentMode := simMessageBoxes;
end;

function TfrxEngineOptions.GetSilentMode: Boolean;
begin
  if FSilentMode = simSilent then
    Result := True
  else
    Result := False;
end;

{ TfrxPreviewOptions }

constructor TfrxPreviewOptions.Create;
begin
  Clear;
  FAllowEdit := True;
  FButtons := [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind,
    pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection];
  FDoubleBuffered := True;
  FMaximized := True;
  FMDIChild := False;
  FModal := True;
  FPagesInCache := 50;
  FShowCaptions := False;
  FZoom := 1;
  FZoomMode := zmDefault;
  FPictureCacheInFile := False;
  AllowPreviewEdit := True;
end;

procedure TfrxPreviewOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxPreviewOptions then
  begin
    FAllowEdit := TfrxPreviewOptions(Source).AllowEdit;
    FAllowPreviewEdit := TfrxPreviewOptions(Source).AllowPreviewEdit;
    FButtons := TfrxPreviewOptions(Source).Buttons;
    FDoubleBuffered := TfrxPreviewOptions(Source).DoubleBuffered;
    FMaximized := TfrxPreviewOptions(Source).Maximized;
    FMDIChild := TfrxPreviewOptions(Source).MDIChild;
    FModal := TfrxPreviewOptions(Source).Modal;
    FOutlineExpand := TfrxPreviewOptions(Source).OutlineExpand;
    FOutlineVisible := TfrxPreviewOptions(Source).OutlineVisible;
    FOutlineWidth := TfrxPreviewOptions(Source).OutlineWidth;
    FPagesInCache := TfrxPreviewOptions(Source).PagesInCache;
    FShowCaptions := TfrxPreviewOptions(Source).ShowCaptions;
    FThumbnailVisible := TfrxPreviewOptions(Source).ThumbnailVisible;
    FZoom := TfrxPreviewOptions(Source).Zoom;
    FZoomMode := TfrxPreviewOptions(Source).ZoomMode;
    FPictureCacheInFile := TfrxPreviewOptions(Source).PictureCacheInFile;
    FRTLPreview := TfrxPreviewOptions(Source).RTLPreview;
  end;
end;

procedure TfrxPreviewOptions.Clear;
begin
  FOutlineExpand := True;
  FOutlineVisible := False;
  FOutlineWidth := 120;
  FPagesInCache := 50;
  FThumbnailVisible := False;
end;

{ TfrxPrintOptions }

constructor TfrxPrintOptions.Create;
begin
  Clear;
end;

procedure TfrxPrintOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxPrintOptions then
  begin
    FCopies := TfrxPrintOptions(Source).Copies;
    FCollate := TfrxPrintOptions(Source).Collate;
    FPageNumbers := TfrxPrintOptions(Source).PageNumbers;
    FPrinter := TfrxPrintOptions(Source).Printer;
    FPrintMode := TfrxPrintOptions(Source).PrintMode;
    FPrintOnSheet := TfrxPrintOptions(Source).PrintOnSheet;
    FPrintPages := TfrxPrintOptions(Source).PrintPages;
    FReverse := TfrxPrintOptions(Source).Reverse;
    FShowDialog := TfrxPrintOptions(Source).ShowDialog;
    FSplicingLine := TfrxPrintOptions(Source).SplicingLine;
  end;
end;

procedure TfrxPrintOptions.Clear;
begin
  FCopies := 1;
  FCollate := True;
  FPageNumbers := '';
  FPagesOnSheet := 0;
  FPrinter := frxResources.Get('prDefault');
  FPrintMode := pmDefault;
  FPrintOnSheet := 0;
  FPrintPages := ppAll;
  FReverse := False;
  FShowDialog := True;
  FSplicingLine := 3;
  FDuplex := dmNone;
end;

{ TfrxReportOptions }

constructor TfrxReportOptions.Create;
begin
  FDescription := TStringList.Create;
  FPicture := TPicture.Create;
  FCreateDate := Now;
  FLastChange := Now;
  FPrevPassword := '';
  FInfo := False;
end;

destructor TfrxReportOptions.Destroy;
begin
  FDescription.Free;
  FPicture.Free;
  inherited;
end;

procedure TfrxReportOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxReportOptions then
  begin
    FAuthor := TfrxReportOptions(Source).Author;
    FCompressed := TfrxReportOptions(Source).Compressed;
    FConnectionName := TfrxReportOptions(Source).ConnectionName;
    FCreateDate := TfrxReportOptions(Source).CreateDate;
    Description := TfrxReportOptions(Source).Description;
    FInitString := TfrxReportOptions(Source).InitString;
    FLastChange := TfrxReportOptions(Source).LastChange;
    FName := TfrxReportOptions(Source).Name;
    FPassword := TfrxReportOptions(Source).Password;
    Picture := TfrxReportOptions(Source).Picture;
    FVersionBuild := TfrxReportOptions(Source).VersionBuild;
    FVersionMajor := TfrxReportOptions(Source).VersionMajor;
    FVersionMinor := TfrxReportOptions(Source).VersionMinor;
    FVersionRelease := TfrxReportOptions(Source).VersionRelease;
  end;
end;

procedure TfrxReportOptions.Clear;
begin
  if not FInfo then
  begin
    FAuthor := '';
    FCompressed := False;
    FCreateDate := Now;
    FDescription.Clear;
    FLastChange := Now;
    FPicture.Assign(nil);
    FVersionBuild := '';
    FVersionMajor := '';
    FVersionMinor := '';
    FVersionRelease := '';
  end;
  FConnectionName := '';
  FInitString := '';
  FName := '';
  FPassword := '';
  FPrevPassword := '';
end;

procedure TfrxReportOptions.SetDescription(const Value: TStrings);
begin
  FDescription.Assign(Value);
end;

procedure TfrxReportOptions.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

function TfrxReportOptions.CheckPassword: Boolean;
begin
  Result := True;
  if (FPassword <> '') and (FPassword <> FPrevPassword) and (FPassword <> HiddenPassword) then
    with TfrxPasswordForm.Create(Application) do
    begin
      if (ShowModal <> mrOk) or (FPassword <> PasswordE.Text) then
      begin
        Result := False;
        FReport.Errors.Add(frxResources.Get('Invalid password'));
        frxCommonErrorHandler(FReport, frxResources.Get('clErrors') + #13#10 + FReport.Errors.Text);
      end
      else
        FPrevPassword := FPassword;
      Free;
    end;
end;

procedure TfrxReportOptions.SetConnectionName(const Value: String);
{$IFNDEF FPC}
var
  ini: TRegistry;
  conn: String;
{$ENDIF}
begin
  FConnectionName := Value;
  {$IFNDEF FPC}
  if Value <> '' then
    if Assigned(FReport.OnSetConnection) then
    begin
      ini := TRegistry.Create;
      try
        ini.RootKey := HKEY_LOCAL_MACHINE;
        if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS) then
        begin
          conn := ini.ReadString(Value);
          if conn <> '' then FReport.OnSetConnection( conn );
          ini.CloseKey;
        end;
        ini.RootKey := HKEY_CURRENT_USER;
        if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS) then
        begin
          conn := ini.ReadString(Value);
          if conn <> '' then FReport.OnSetConnection(conn);
          ini.CloseKey;
        end;
// Samuray
        ini.RootKey := HKEY_LOCAL_MACHINE;
        if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS+'FIB') then
        begin
          conn := ini.ReadString(Value);
          if conn <> '' then FReport.OnSetConnection( conn );
          ini.CloseKey;
        end;
        ini.RootKey := HKEY_CURRENT_USER;
        if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS+'FIB') then
        begin
          conn := ini.ReadString(Value);
          if conn <> '' then FReport.OnSetConnection(conn);
          ini.CloseKey;
        end;
      finally
        ini.Free;
      end;
    end;
  {$ENDIF}
end;

{ TfrxDataSetItem }

procedure TfrxDataSetItem.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxDataSetItem.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  if FDataSetName = '' then
    FDataSet := nil
  else if TfrxReportDataSets(Collection).FReport <> nil then
    FDataSet := TfrxReportDataSets(Collection).FReport.FindDataSet(FDataSet, FDataSetName);
end;

function TfrxDataSetItem.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;


{ TfrxReportDatasets }

procedure TfrxReportDataSets.Add(AName: String);
begin
  TfrxDatasetItem(inherited Add).DataSetName := AName;
end;

constructor TfrxReportDatasets.Create(AReport: TfrxReport);
begin
  inherited Create(TfrxDatasetItem);
  FReport := AReport;
end;

procedure TfrxReportDataSets.Initialize;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
    begin
      Items[i].DataSet.ReportRef := FReport;
      Items[i].DataSet.Initialize;
    end;
end;

procedure TfrxReportDataSets.Finalize;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
      Items[i].DataSet.Finalize;
end;

procedure TfrxReportDatasets.Add(ds: TfrxDataSet);
begin
  TfrxDatasetItem(inherited Add).DataSet := ds;
end;

function TfrxReportDatasets.GetItem(Index: Integer): TfrxDatasetItem;
begin
  Result := TfrxDatasetItem(inherited Items[Index]);
end;

function TfrxReportDatasets.Find(ds: TfrxDataSet): TfrxDatasetItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Items[i].DataSet = ds then
    begin
      Result := Items[i];
      Exit;
    end;
end;

function TfrxReportDatasets.Find(const Name: String): TfrxDatasetItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
      if (CompareText(Items[i].DataSet.UserName, Name) = 0) or
        (CompareText(Items[i].DataSet.Name, Name) = 0) then
      begin
        Result := Items[i];
        Exit;
      end;
end;

procedure TfrxReportDatasets.Delete(const Name: String);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].DataSet <> nil then
      if CompareText(Items[i].DataSet.UserName, Name) = 0 then
      begin
        Items[i].Free;
        Exit;
      end;
end;

{ TfrxStyleItem }

constructor TfrxCustomStyleItem.Create(Collection: TCollection);
begin
  inherited;
  //FColor := clNone;
  FFont := TFont.Create;
  with FFont do
  begin
    PixelsPerInch := frx_DefaultPPI;
    Name := DefFontName;
    Size := DefFontSize;
    Charset := frxCharset;
  end;
  FFrame := TfrxFrame.Create;
  FFill := TfrxBrushFill.Create;
  ApplyFont := True;
  ApplyFill := True;
  ApplyFrame := True;
end;

destructor TfrxCustomStyleItem.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FFrame);
  FreeAndNil(FFill);
  inherited;
end;

function TfrxCustomStyleItem.GetColor: TColor;
begin
  if Self.Fill is TfrxBrushFill then
    Result := TfrxBrushFill(Self.Fill).FBackColor
  else if Self.Fill is TfrxGradientFill then
    Result := TfrxGradientFill(Self.Fill).GetColor
  else
    Result := clNone;
end;

function TfrxCustomStyleItem.GetFill: TfrxCustomFill;
begin
  Result := GetFillRef;
end;

function TfrxCustomStyleItem.GetFillRef: TfrxCustomFill;
begin
  Result := FFill;
end;

function TfrxCustomStyleItem.GetFillType: TfrxFillType;
begin
  Result := frxGetFillType(GetFillRef);
end;

function TfrxCustomStyleItem.GetFont: TFont;
begin
  Result := GetFontRef;
end;

function TfrxCustomStyleItem.GetFontRef: TFont;
begin
  Result := FFont;
end;

function TfrxCustomStyleItem.GetFrame: TfrxFrame;
begin
  Result := GetFrameRef;
end;

function TfrxCustomStyleItem.GetFrameRef: TfrxFrame;
begin
  Result := FFrame;
end;

procedure TfrxCustomStyleItem.Assign(Source: TPersistent);
var
  LView: TfrxView;
begin
  if Source is TfrxCustomStyleItem then
  begin
    FName := TfrxCustomStyleItem(Source).Name;
    FillType := TfrxCustomStyleItem(Source).FillType;
    FFill.Assign(TfrxCustomStyleItem(Source).FFill);
    FFont.Assign(TfrxCustomStyleItem(Source).Font);
    FFrame.Assign(TfrxCustomStyleItem(Source).Frame);
    FApplyFont := TfrxCustomStyleItem(Source).ApplyFont;
    FApplyFill := TfrxCustomStyleItem(Source).ApplyFill;
    FApplyFrame := TfrxCustomStyleItem(Source).ApplyFrame;
    FIsInherited := TfrxCustomStyleItem(Source).IsInherited;
  end
  else if Source is TfrxView then
  begin
    LView := TfrxView(Source);
    if ApplyFill then
    begin
      FillType := LView.FillType;
      Fill.Assign(LView.Fill);
    end;
    if ApplyFont then
      Font.Assign(LView.Font);
    if ApplyFrame then
      Frame.Assign(LView.Frame);
  end;
end;

procedure TfrxCustomStyleItem.SetColor(const Value: TColor);
begin
  if Self.Fill is TfrxBrushFill then
    TfrxBrushFill(Self.Fill).FBackColor := Value;
end;

procedure TfrxCustomStyleItem.SetFill(const Value: TfrxCustomFill);
begin
  FillType := frxGetFillType(Value);
  GetFillRef.Assign(Value);
end;

procedure TfrxCustomStyleItem.SetFillRef(const Value: TfrxCustomFill);
begin
  FFill.Free;
  FFill := Value;
end;

procedure TfrxCustomStyleItem.SetFillType(const Value: TfrxFillType);
begin
  if FillType = Value then Exit;
  SetFillRef(frxCreateFill(Value));
end;

procedure TfrxCustomStyleItem.SetFont(const Value: TFont);
begin
  GetFontRef.Assign(Value);
end;

procedure TfrxCustomStyleItem.SetFrame(const Value: TfrxFrame);
begin
  GetFrameRef.Assign(Value);
end;

{ TfrxStyleItem }

procedure TfrxStyleItem.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TfrxStyleItem then
    FStyleSheet.Assign(TfrxStyleItem(Source).FStyleSheet);
end;

constructor TfrxStyleItem.Create(Collection: TCollection);
begin
  inherited;
  FStyleSheet := TfrxStyleSheets.Create(TfrxStyles(Collection), Self);
  UpdateSheets(TfrxStyles(Collection).FStyleSheetNames);
end;

procedure TfrxStyleItem.ReadProperties(PropName: String; Reader: TObject;
  Ancestor: TfrCollection);
var
  xi: TfrXMLItem;
begin
  inherited;
  if Reader is TfrXMLItem then
  begin
    xi := TfrXMLItem(Reader);
    //StyleSheet.Clear;
    frxReadCollection(StyleSheet, xi, TfrxStyles(Collection).FReport, Ancestor);
  end;
end;

destructor TfrxStyleItem.Destroy;
begin
  FreeAndNil(FStyleSheet);
  inherited;
end;

function TfrxStyleItem.GetActiveStyleSheet: String;
begin
  Result := TfrxStyles(Collection).ActiveStyleSheet;
end;

function TfrxStyleItem.GetFillRef: TfrxCustomFill;
var
  LSheetItem: TfrxStyleSheetItem;
begin
  Result := nil;
  if IsStyleSheetActive then
  begin
    LSheetItem := FStyleSheet.GetSheetItem(GetActiveStyleSheet);
    if Assigned(LSheetItem) then
      Result := LSheetItem.Fill;
  end;
  if Result = nil then
    Result := inherited GetFillRef;
end;

function TfrxStyleItem.GetFontRef: TFont;
var
  LSheetItem: TfrxStyleSheetItem;
begin
  Result := nil;
  if IsStyleSheetActive then
  begin
    LSheetItem := FStyleSheet.GetSheetItem(GetActiveStyleSheet);
    if Assigned(LSheetItem) then
      Result := LSheetItem.Font;
  end;
  if Result = nil then
    Result := inherited GetFontRef;
end;

function TfrxStyleItem.GetFrameRef: TfrxFrame;
var
  LSheetItem: TfrxStyleSheetItem;
begin
  Result := nil;
  if IsStyleSheetActive then
  begin
    LSheetItem := FStyleSheet.GetSheetItem(GetActiveStyleSheet);
    if Assigned(LSheetItem) then
      Result := LSheetItem.Frame;
  end;
  if Result = nil then
    Result := inherited GetFrameRef;
end;

function TfrxStyleItem.IsStyleSheetActive: Boolean;
begin
  Result := TfrxStyles(Collection).IsStyleSheetActive;
end;

function TfrxStyleItem.IsStyleSheetStored: Boolean;
begin
  Result := (TfrxStyles(Collection).StyleBookMode <> []) and (FStyleSheet.Count > 0);
end;

procedure TfrxStyleItem.WriteProperties(Writer: TObject;
  Ancestor: TfrCollection; Owner: TComponent);
var
  xi: TfrXMLItem;
begin
  inherited;
  if Writer is TfrXMLItem then
  begin
    xi := TfrXMLItem(Writer);
    frxWriteCollection(StyleSheet, 'StyleSheet', xi, TfrxComponent(Owner), Ancestor);
  end;
end;

procedure TfrxStyleItem.SetFillRef(const Value: TfrxCustomFill);
var
  LSheetItem: TfrxStyleSheetItem;
begin
  LSheetItem := nil;
  if IsStyleSheetActive then
    LSheetItem := FStyleSheet.GetSheetItem(GetActiveStyleSheet);
  if Assigned(LSheetItem) then
    LSheetItem.SetFillRef(Value)
  else
    inherited SetFillRef(Value);
end;

procedure TfrxStyleItem.SetStyleSheet(const Value: TfrxStyleSheets);
begin
  FStyleSheet.Assign(Value);
end;

procedure TfrxStyleItem.UpdateSheets(AList: TStrings);
begin
  if TfrxStyles(Collection).UpdateCount <= 0 then
    FStyleSheet.UpdateSheets(AList);
end;

{ TfrxStyles }

procedure TfrxStyles.ClearAll;
begin
  FActiveStyleSheet := '';
  Clear;
  FStyleSheetNames.Clear;
  FStyleSheetNames.Duplicates := dupIgnore;
  FStyleSheetNames.Sorted := True;
  FStyleBookMode := [];
end;

constructor TfrxStyles.Create(AReport: TfrxReport);
begin
  inherited Create(TfrxStyleItem);
  FReport := AReport;
  FStyleSheetNames := TStringList.Create;
end;

procedure TfrxStyles.DeleteStyleSheet(const AName: String);
var
  LIndex: Integer;
begin
  if AName = FActiveStyleSheet then
    ActiveStyleSheet := '';

  for LIndex := 0 to Count - 1 do
    Items[LIndex].FStyleSheet.DeleteByName(AName);

  LIndex := FStyleSheetNames.IndexOf(AName);
  if LIndex >= 0 then
    FStyleSheetNames.Delete(LIndex);
end;

destructor TfrxStyles.Destroy;
begin
  inherited;
  FreeAndNil(FStyleSheetNames);
end;

procedure TfrxStyles.EndUpdate;
begin
  inherited;
  UpdateSheets(FStyleSheetNames);
end;

function TfrxStyles.Add: TfrxStyleItem;
begin
  Result := TfrxStyleItem(inherited Add);
end;

function TfrxStyles.Find(const AName: String): TfrxStyleItem;
begin
  Result := TfrxStyleItem(InternalFind(AName));
end;

function TfrxStyles.GetActiveStyleSheet: String;
begin
  if FDefaultStyleLocked then
    Result := ''
  else
    Result := FActiveStyleSheet;
end;

function TfrxStyles.GetItem(Index: Integer): TfrxStyleItem;
begin
  Result := TfrxStyleItem(inherited Items[Index]);
end;

procedure TfrxStyles.GetList(List: TStrings);
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to Count - 1 do
    List.Add(Items[i].Name);
end;

procedure TfrxStyles.GetStyleSheetList(List: TStrings);
begin
  List.Assign(FStyleSheetNames);
  List.Insert(0, frxGet(3880));
end;

function TfrxStyles.IsStyleSheetActive: Boolean;
begin
  Result := (ActiveStyleSheet <> '');
end;

procedure TfrxStyles.LoadFromXMLItem(AItem: TfrXMLItem; AOldXMLFormat: Boolean);
begin
  LoadFromXMLItem(AItem, nil, AOldXMLFormat)
end;

procedure TfrxStyles.LockDefaultStyle;
begin
  FDefaultStyleLocked := True;
end;

function TfrxStyles.RenameStyleSheet(const AName, ANewName: String): Boolean;
var
  LIndex, I: Integer;
  LItem: TfrxStyleSheetItem;
begin
  Result := False;
  LIndex := FStyleSheetNames.IndexOf(AName);
  if LIndex < 0 then Exit;
  if FStyleSheetNames.IndexOf(ANewName) >= 0 then
    raise EDuplicateName.Create(frxResources.Get('prDupl'));

  for I := 0 to Count - 1 do
  begin
    Items[I].StyleSheet.BeginUpdate;
    try
      LItem := Items[I].StyleSheet.Find(AName);
      if Assigned(LItem) then
      begin
        LItem.Name := ANewName;
        Result := True;
      end;
    finally
      Items[I].StyleSheet.EndUpdate;
    end;
  end;
  if Result and (FActiveStyleSheet = AName) then
    FActiveStyleSheet := ANewName;
end;

procedure TfrxStyles.SaveToXMLItem(AItem: TfrXMLItem);
begin
  SaveToXMLItem(AItem, nil);
end;

procedure TfrxStyles.SetActiveStyleSheet(const Value: String);
begin
  if FStyleBookMode = [] then Exit;
  if (Value = '') or (FStyleSheetNames.IndexOf(Value) >= 0) then
    FActiveStyleSheet := Value;
end;

procedure TfrxStyles.SetStyleBookMode(const Value: TfrxStyleBookModes);
begin
  if Value = [] then
    ActiveStyleSheet := '';
  FStyleBookMode := Value;
end;

procedure TfrxStyles.UnlockDefaultStyle;
begin
  FDefaultStyleLocked := False
end;

procedure TfrxStyles.UpdateFromObjects(AList: TList);
var
  i: Integer;
  LView: TfrxView;
  LStyle: TfrxStyleItem;
begin
  for i := 0 to AList.Count - 1 do
    if TObject(AList[i]) is TfrxView then
    begin
      LView := TfrxView(AList[i]);
      LStyle := nil;
      if (LView.Style <> '') then
        LStyle := Find(LView.Style);
      if Assigned(LStyle) then
        LStyle.Assign(LView);
    end;
  Apply;
end;

procedure TfrxStyles.UpdateSheets(AList: TStrings);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    TfrxStyleItem(Items[i]).UpdateSheets(AList);
end;

procedure TfrxStyles.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyles.LoadFromStream(Stream: TStream);
var
  x: TfrXMLDocument;
begin
  Clear;
  x := TfrXMLDocument.Create;
  try
    x.LoadFromStream(Stream);
    if CompareText(x.Root.Name, 'style') = 0 then
      LoadFromXMLItem(x.Root, x.OldVersion);
  finally
    x.Free;
  end;
end;

procedure TfrxStyles.LoadFromXMLItem(AItem: TfrXMLItem; AAncestor: TfrxStyles;
  AOldXMLFormat: Boolean);
begin
  Clear;
  Name := AItem.Prop['Name'];
  frxReadCollection(Self, AItem, FReport, AAncestor);
  StyleBookMode := TfrxStyleBookModes(Byte(AItem.PropAsInt['StyleBookMode']));
  ActiveStyleSheet := AItem.Prop['ActiveStyleSheet'];
  Apply;
end;

procedure TfrxStyles.SaveToFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyles.SaveToStream(Stream: TStream);
var
  x: TfrXMLDocument;
begin
  x := TfrXMLDocument.Create;
  x.AutoIndent := True;
  try
    x.Root.Name := 'style';
    SaveToXMLItem(x.Root);
    x.SaveToStream(Stream);
  finally
    x.Free;
  end;
end;

procedure TfrxStyles.SaveToXMLItem(AItem: TfrXMLItem; AAncestor: TfrxStyles);
begin
  LockDefaultStyle;
  if Assigned(AAncestor) then
    AAncestor.LockDefaultStyle;
  try
    frxWriteCollection(Self, 'style', AItem, FReport, AAncestor, False);
  finally
    if Assigned(AAncestor) then
      AAncestor.UnlockDefaultStyle;
    UnlockDefaultStyle;
  end;
  if Name <> '' then
    AItem.Prop['Name'] := Name;
  if StyleBookMode <> [] then
    AItem.PropAsInt['StyleBookMode'] := Byte(StyleBookMode);
  if ActiveStyleSheet <> '' then
    AItem.Prop['ActiveStyleSheet'] := ActiveStyleSheet;
end;

procedure TfrxStyles.InternalSynchSheetName(const ANewName: string; const AOldName: string);
var
  LIndex: Integer;
begin
  LIndex := FStyleSheetNames.IndexOf(AOldName);
  if LIndex < 0 then
    FStyleSheetNames.Add(ANewName)
  else
  begin
    FStyleSheetNames.Delete(LIndex);
    FStyleSheetNames.Add(ANewName);
  end;
end;

function TfrxStyles.AddStyleSheet: String;
var
  i: Integer;
begin
  i := 1;
  while FStyleSheetNames.IndexOf('StyleSheet' + IntToStr(i)) >= 0 do
    Inc(i);
  Result := 'StyleSheet' + IntToStr(i);
  FStyleSheetNames.Add(Result);
  UpdateSheets(FStyleSheetNames);
end;

procedure TfrxStyles.Apply;
var
  i: Integer;
  LLIst: TList;
begin
  if FReport <> nil then
  begin
    LLIst := FReport.AllObjects;
    for i := 0 to LLIst.Count - 1 do
      if (TObject(LLIst[i]) is TfrxView) and (TfrxView(LLIst[i]).Style <> '') then
        if Find(TfrxView(LLIst[i]).Style) = nil then
          TfrxView(LLIst[i]).Style := ''
        else
          TfrxView(LLIst[i]).Style := TfrxView(LLIst[i]).Style;
  end;
end;

procedure TfrxStyles.Assign(Source: TPersistent);
var
  LStyles: TfrxStyles;
begin
  if Source is TfrxStyles then
    LStyles := TfrxStyles(Source)
  else
    LStyles := nil;
  LockDefaultStyle;
  if Assigned(LStyles) then
    LStyles.LockDefaultStyle;
  try
    if Assigned(LStyles) then
    begin
      FStyleSheetNames.Assign(LStyles.FStyleSheetNames);
      FActiveStyleSheet := LStyles.FActiveStyleSheet;
      FStyleBookMode := LStyles.FStyleBookMode;
    end;
    inherited;
  finally
    UnlockDefaultStyle;
    if Assigned(LStyles) then
      LStyles.UnlockDefaultStyle;
  end;
end;

procedure TfrxStyles.AssignAsPreview(Source: TfrxStyles);
begin
  if fsbPreview in Source.StyleBookMode then
    Assign(Source);
end;

{ TfrxStyleSheet }

constructor TfrxStyleScheme.Create;
begin
  FItems := TList.Create;
end;

destructor TfrxStyleScheme.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

procedure TfrxStyleScheme.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

procedure TfrxStyleScheme.Delete(Index: Integer);
begin
  Items[Index].Free;
  FItems.Delete(Index);
end;

function TfrxStyleScheme.Add: TfrxStyles;
begin
  Result := TfrxStyles.Create(nil);
  FItems.Add(Result);
end;

function TfrxStyleScheme.Count: Integer;
begin
  Result := FItems.Count;
end;

function TfrxStyleScheme.GetItems(Index: Integer): TfrxStyles;
begin
  Result := FItems[Index];
end;

function TfrxStyleScheme.Find(const Name: String): TfrxStyles;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, Name) = 0 then
    begin
      Result := Items[i];
      break;
    end;
end;

function TfrxStyleScheme.IndexOf(const Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, Name) = 0 then
    begin
      Result := i;
      break;
    end;
end;

procedure TfrxStyleScheme.GetList(List: TStrings);
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to Count - 1 do
    List.Add(Items[i].Name);
end;

procedure TfrxStyleScheme.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyleScheme.LoadFromStream(Stream: TStream);
var
  x: TfrXMLDocument;
  i: Integer;
begin
  Clear;
  x := TfrXMLDocument.Create;
  try
    x.LoadFromStream(Stream);
{$IFDEF DELPHI12}
//    if AnsiStrIComp(PAnsiChar(x.Root.Name), PAnsiChar(AnsiString('stylesheet'))) = 0 then
    if CompareText(x.Root.Name, 'stylesheet') = 0 then
{$ELSE}
    if CompareText(x.Root.Name, 'stylesheet') = 0 then
{$ENDIF}
      for i := 0 to x.Root.Count - 1 do
{$IFDEF DELPHI12}
//        if AnsiStrIComp(PAnsiChar(x.Root[i].Name), PAnsiChar(AnsiString('style'))) = 0 then
        if CompareText(x.Root[i].Name, 'style') = 0 then
{$ELSE}
        if CompareText(x.Root[i].Name, 'style') = 0 then
{$ENDIF}
          Add.LoadFromXMLItem(x.Root[i], x.OldVersion);
  finally
    x.Free;
  end;
end;

procedure TfrxStyleScheme.SaveToFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxStyleScheme.SaveToStream(Stream: TStream);
var
  x: TfrXMLDocument;
  i: Integer;
begin
  x := TfrXMLDocument.Create;
  x.AutoIndent := True;
  try
    x.Root.Name := 'stylesheet';
    for i := 0 to Count - 1 do
      Items[i].SaveToXMLItem(x.Root.Add);

    x.SaveToStream(Stream);
  finally
    x.Free;
  end;
end;


{ TfrxReport }

constructor TfrxReport.Create(AOwner: TComponent);
begin
  inherited;
  FVersion := FR_VERSION;
  FDatasets := TfrxReportDatasets.Create(Self);
  FVariables := TfrxVariables.Create;
  FSaveParentScript := nil;
  FScript := TfsScript.Create(nil);
  FScript.ExtendedCharset := True;
  FScript.AddRTTI;

  FTimer := TTimer.Create(nil);
  FTimer.Interval := 50;
  FTimer.Enabled := False;
  FTimer.OnTimer := OnTimer;

  FEngineOptions := TfrxEngineOptions.Create;
  FPreviewOptions := TfrxPreviewOptions.Create;
  FPrintOptions := TfrxPrintOptions.Create;
  FReportOptions := TfrxReportOptions.Create(Self);
  FReportOptions.FReport := Self;

  FIniFile := '\Software\Fast Reports';
{$IFDEF FPC}
{$IFDEF UNIX}
  FIniFile := 'tmp/fr6.ini';
{$ENDIF}
{$ENDIF}
  FScriptText := TStringList.Create;
  FFakeScriptText := TStringList.Create;
  FExpressionCache := TfrxExpressionCache.Create(FScript);
  FErrors := TStringList.Create;
  TStringList(FErrors).Sorted := True;
  TStringList(FErrors).Duplicates := dupIgnore;
  FStyles := TfrxStyles.Create(Self);
  FSysVariables := TStringList.Create;
  FEnabledDataSets := TfrxReportDataSets.Create(Self);
  FShowProgress := True;
  FStoreInDFM := True;
  frComponentStyle := frComponentStyle + [csHandlesNestedProperties];

  FEngine := TfrxEngine.Create(Self);
  FPreviewPagesList := TfrxPreviewPagesList.Create(Self);
  FEngine.PreviewPages := PreviewPages;
  FDrawText := TfrxDrawText.Create;
  FDrillState := TStringList.Create;
  TStringList(FDrillState).Sorted := True;
  FCommandManager := TfrxDelayedCommandManager.Create;
  Clear;
end;

destructor TfrxReport.Destroy;
begin
  if Assigned(FDesigner) then
    FDesigner.FReport := nil;
  inherited;
  if (FPreviewForm <> nil) and not TfrxPreviewForm(FPreviewForm).IsClosing then
    FPreviewForm.Close;
  if Preview <> nil then
    Preview.UnInit(Self);
  Preview := nil;
  if FParentReportObject <> nil then
    FParentReportObject.Free;
  FreeAndNil(FPreviewPagesList);
  FDatasets.Free;
  FEngineOptions.Free;
  FPreviewOptions.Free;
  FPrintOptions.Free;
  FReportOptions.Free;
  FExpressionCache.Free;
  FScript.Free;
  FScriptText.Free;
  FFakeScriptText.Free;
  FVariables.Free;
  FEngine.Free;
  FErrors.Free;
  FStyles.Free;
  FSysVariables.Free;
  FEnabledDataSets.Free;
  FTimer.Free;
  TObject(FDrawText).Free;
  FDrillState.Free;
  if FParentForm <> nil then
  begin
    FParentForm.Free;
    FParentForm := nil;
  end;
  FreeAndNil(FCommandManager);
end;

class function TfrxReport.GetDescription: String;
begin
  Result := frxResources.Get('obReport');
end;

procedure TfrxReport.DoClear;
begin
  inherited Clear;
  FIsScriptObjectsAdded := False;
  FDataSets.Clear;
  FVariables.Clear;
  FEngineOptions.Clear;
  FPreviewOptions.Clear;
  FPrintOptions.Clear;
  FReportOptions.Clear;
  FStyles.ClearAll;
  FDataSet := nil;
  FDataSetName := '';
  FDotMatrixReport := False;
  ParentReport := '';

  FScriptLanguage := 'PascalScript';
  with FScriptText do
  begin
    Clear;
    Add('begin');
    Add('');
    Add('end.');
  end;

  with FSysVariables do
  begin
    Clear;
    Add('Date');
    Add('Time');
    Add('Page');
    Add('Page#');
    Add('TotalPages');
    Add('TotalPages#');
    Add('Line');
    Add('Line#');
    Add('CopyName#');
    Add('TableRow');
    Add('TableColumn');
  end;

  FOnRunDialogs := '';
  FOnStartReport := '';
  FOnStopReport := '';
end;

procedure TfrxReport.Clear;
begin
  DoClear;
end;

procedure TfrxReport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent is TfrxDataSet then
    begin
      if FDataSets.Find(TfrxDataSet(AComponent)) <> nil then
        FDataSets.Find(TfrxDataSet(AComponent)).Free;
      if FDataset = AComponent then
        FDataset := nil;
      if Designer <> nil then
        Designer.UpdateDataTree;
    end
//    else if AComponent is TfrxPreviewForm then
//      FPreviewForm := nil
    else if AComponent is TfrxCustomPreview then
      if FPreview = AComponent then
        FPreview := nil;
end;

procedure TfrxReport.AncestorNotFound(Reader: TReader; const ComponentName: string;
  ComponentClass: TPersistentClass; var Component: TComponent);
begin
  Component := FindObject(ComponentName);
end;

procedure TfrxReport.DefineProperties(Filer: TFiler);
begin
  inherited;
  if (csWriting in ComponentState) and not FStoreInDFM then Exit;

  Filer.DefineProperty('Datasets', ReadDatasets, WriteDatasets, True);
  Filer.DefineProperty('Variables', ReadVariables, WriteVariables, True);
  Filer.DefineProperty('Style', ReadStyle, WriteStyle, True);
  Filer.DefineProperty('Style.StyleBookMode', ReadStyleBookMode, WriteStyleBookMode, FStyles.StyleBookMode <> []);
  Filer.DefineProperty('Style.ActiveStyleSheet', ReadActiveStyleSheet, WriteActiveStyleSheet, FStyles.ActiveStyleSheet <> '');
  if Filer is TReader then
    TReader(Filer).OnAncestorNotFound := AncestorNotFound;
end;

procedure TfrxReport.WriteNestedProperties(AItem: TfrXMLItem; AAncestor: TPersistent = nil);
var
  LAcVars: TfrxVariables;
  LAcStyles: TfrxStyles;
  LItem: TfrXMLItem;
begin
  LAcStyles := nil;
  LAcVars := nil;
  if (FParentReportObject <> nil) and Assigned(AAncestor) then
  begin
    LAcStyles := FParentReportObject.Styles;
    LAcVars := FParentReportObject.Variables;
  end;

  if Datasets.Count > 0 then
    frxWriteCollection(Datasets, 'Datasets', AItem, Self, nil);
  if Variables.Count > 0 then
    frxWriteCollection(Variables, 'Variables', AItem, Self, LAcVars);
  if Styles.Count > 0 then
  begin
    LItem := AItem.Add;
    LItem.Name := 'Styles';
    Styles.SaveToXMLItem(LItem, LAcStyles);
  end;
end;

function TfrxReport.ReadNestedProperty(AItem: TfrXMLItem): Boolean;
var
  LAcVars: TfrxVariables;
  LAcStyles: TfrxStyles;
begin
  Result := True;
  LAcStyles := nil;
  LAcVars := nil;
  if FParentReportObject <> nil then
  begin
    LAcStyles := FParentReportObject.Styles;
    LAcVars := FParentReportObject.Variables;
  end;
  if CompareText(AItem.Name, 'Datasets') = 0 then
  begin
    if FParentReportObject <> nil then
    // datasets are not inheritable
      Datasets.Clear;
    frxReadCollection(Datasets, AItem, Self, nil)
  end
  else if CompareText(AItem.Name, 'Variables') = 0 then
    frxReadCollection(Variables, AItem, Self, LAcVars)
  else if CompareText(AItem.Name, 'Styles') = 0 then
    Styles.LoadFromXMLItem(AItem, LAcStyles)
  else
    Result := False;
end;

procedure TfrxReport.ReadActiveStyleSheet(Reader: TReader);
begin
  FStyles.ActiveStyleSheet := Reader.ReadString;
end;

procedure TfrxReport.ReadDatasets(Reader: TReader);
begin
  frxReadCollection(FDatasets, Reader, Self);
end;

procedure TfrxReport.ReadStyle(Reader: TReader);
begin
  frxReadCollection(FStyles, Reader, Self);
end;

procedure TfrxReport.ReadStyleBookMode(Reader: TReader);
begin
  FStyles.StyleBookMode := TfrxStyleBookModes(Byte(Reader.ReadInteger));
end;

procedure TfrxReport.ReadVariables(Reader: TReader);
begin
  frxReadCollection(FVariables, Reader, Self);
end;

procedure TfrxReport.RefreshActivePreviewedReport;
begin
  if IsReportActionRunning then
    FCommandManager.AddCommand(TfrxRefreshReportCommand.Create(Self, True))
  else if Assigned(Preview) then
    Preview.RefreshReport;
end;

procedure TfrxReport.RestoreScriptObjectsRef;

  procedure FixRefs(aReport: TfrxReport);
  var
    List: TList;
    i: Integer;
    c: TfrxComponent;
    v: TfsCustomVariable;
  begin
    if Assigned(aReport.FParentReportObject) then
      FixRefs(aReport.FParentReportObject);
    List := aReport.AllObjects;
    for i := 0 to List.Count - 1 do
    begin
      c := TfrxComponent(List[i]);
      if not c.IsAncestor then
      begin
        v := aReport.Script.Find(c.Name);
        if Assigned(v) then
          v.Value := frInteger(c);
      end;
  end;
  end;

begin
  FixRefs(Self);
end;

procedure TfrxReport.RunDelayedCommands;
begin
  FCommandManager.RunAll;
end;

procedure TfrxReport.WriteActiveStyleSheet(Writer: TWriter);
begin
  Writer.WriteString(FStyles.ActiveStyleSheet);
end;

procedure TfrxReport.WriteDatasets(Writer: TWriter);
begin
  frxWriteCollection(FDatasets, Writer, Self);
end;

procedure TfrxReport.WriteStyle(Writer: TWriter);
begin
  frxWriteCollection(FStyles, Writer, Self);
end;

procedure TfrxReport.WriteStyleBookMode(Writer: TWriter);
begin
  Writer.WriteInteger(Byte(FStyles.StyleBookMode));
end;

procedure TfrxReport.WriteVariables(Writer: TWriter);
begin
  frxWriteCollection(FVariables, Writer, Self);
end;

function TfrxReport.GetPages(Index: Integer): TfrxPage;
begin
  Result := TfrxPage(Objects[Index]);
end;

function TfrxReport.GetPagesCount: Integer;
begin
  Result := Objects.Count;
end;

function TfrxReport.GetPictureCacheOptions: TfrxPictureCacheOptions;
begin
  Result := PreviewPages.PictureCacheOptions;
end;

function TfrxReport.GetPreviewPages: TfrxCustomPreviewPages;
begin
  Result := FPreviewPagesList.GetCurrent;
end;

function TfrxReport.GetReportDrawText: Pointer;
begin
  Result := FDrawText;
end;

procedure TfrxReport.SetScriptText(const Value: TStrings);
begin
  FScriptText.Assign(Value);
end;

procedure TfrxReport.SetEngineOptions(const Value: TfrxEngineOptions);
begin
  FEngineOptions.Assign(Value);
end;

procedure TfrxReport.SetParentReport(const Value: String);
var
  i: Integer;
  list: TList;
  c: TfrxComponent;
  fName, SaveFileName, SaveParentName, OriginalName: String;
  SaveXMLSerializer: TObject;
  SaveParentReport: TfrxReport;
  IsReportLoading: Boolean;
begin
  FParentReport := Value;
  OriginalName := '';
  if FParentReportObject <> nil then
  begin
    FParentReportObject.Free;
    FParentReportObject := nil;
    FScript.Parent := FSaveParentScript;
  end;
  if Value = '' then
  begin
    list := AllObjects;
    for i := 0 to list.Count - 1 do
    begin
      c := list[i];
      c.FAncestor := False;
    end;

    FAncestor := False;
    Exit;
  end;
  SaveFileName := FFileName;
  SaveXMLSerializer := FXMLSerializer;
  if Assigned(FOnLoadTemplate) then
    FOnLoadTemplate(Self, Value)
  else
  begin
    fName := Value;
    { check relative path, exclude network path }
    if (Length(fName) > 1) and (fName[2] <> ':')
{$IFDEF FPC}
      and not ((fName[1] = PathDelim) and (fName[2] = PathDelim)) then
{$ELSE}
      and not ((fName[1] = '\') and (fName[2] = '\')) then
{$ENDIF}
      begin
        fName := ExtractFilePath(SaveFileName) + Value;
        { build an absolute path from absolute + releative }
        if Length(fName) >= MAX_PATH then
        begin
          OriginalName := fName;
          fName := frxExpandRelativePath(fName);
          { still too long try short path }
          if Length(fName) >= MAX_PATH then
            fName := ExtractShortPathName(fName);
          //fName := ExtractShortPathName(ExtractFilePath(SaveFileName)) + Value;
        end;
        if not FileExists(fName) then
          fName := GetApplicationFolder + Value;
      end;
    IsReportLoading := IsLoading;
    try
      LoadFromFile(fName);
    finally
      { restore logn path }
      if OriginalName <> '' then
        FFileName := OriginalName;
      IsLoading := IsReportLoading;
    end;
  end;

  SaveParentReport := TfrxReport.Create(nil);
  SaveParentReport.EngineOptions.AssignThreadProps(Self.EngineOptions);
  SaveParentReport.FileName := FFileName;
  if Assigned(FOnLoadTemplate) then
    SaveParentReport.OnLoadTemplate := FOnLoadTemplate;
  if Assigned(Script.OnGetUnit) then
    SaveParentReport.Script.OnGetUnit:= Script.OnGetUnit;

  { avoid save of ParentReport property and recursive load }
  { we need parent report objects to compare with }
  SaveParentName := FParentReport;
  try
    FParentReport := '';
    SaveParentReport.AssignAll(Self, True);
  finally
    FParentReport :=  SaveParentName;
  end;

  if FParentReportObject <> nil then
  begin
    FScript.Parent := FSaveParentScript;
    SaveParentReport.FParentReportObject := FParentReportObject;
  end;
  FParentReportObject := SaveParentReport;
  FFileName := SaveFileName;

  for i := 0 to FParentReportObject.Objects.Count - 1 do
    if TObject(FParentReportObject.Objects[i]) is TfrxReportPage then
      TfrxReportPage(FParentReportObject.Objects[i]).PaperSize := 256;
  { set ancestor flag for parent objects }
  for i := 0 to FVariables.Count - 1 do
    FVariables.Items[i].IsInherited := True;
  for i := 0 to FStyles.Count - 1 do
    FStyles.Items[i].IsInherited := True;

  list := AllObjects;
  for i := 0 to list.Count - 1 do
  begin
    c := list[i];
    c.FAncestor := True;
  end;

  FAncestor := True;
  FParentReport := Value;
  FXMLSerializer := SaveXMLSerializer;
end;

function TfrxReport.InheritFromTemplate(const templName: String; InheriteMode: TfrxInheriteMode = imDefault): Boolean;
var
  tempReport: TfrxReport;
  Ref: TObject;
  i, Index: Integer;
  DS: TfrxDataSet;
  lItem: TfrxFixupItem;
  l, FixupList: TList;
  c: TfrxComponent;
  found, DeleteDuplicates: Boolean;
  saveScript, OpenQuote, CloseQuote: String;
  fn1, fn2: String;
  DSi: TfrxDataSetItem;
  rVar: TfrxVariable;
  rStyle, rStyle2: TfrxCustomStyleItem;

  procedure FixNames(OldName, NewName: String);
  var
    i: Integer;
  begin
    for i := 0 to FixupList.Count - 1 do
      with TfrxFixupItem(FixupList[i]) do
      begin
        if Value = OldName then Value := NewName;
      end;
  end;

  procedure EnumObjects(ToParent, FromParent: TfrxComponent);
  var
    xs: TfrxXMLSerializer;
    s, OldName: String;
    i: Integer;
    cFrom, cTo, tObj: TfrxComponent;
    cFromSubPage, cToSubPage: TfrxReportPage;
  begin
    xs := TfrxXMLSerializer.Create(nil);
    xs.HandleNestedProperties := (ToParent is TfrxReport);
    { don't serialize ParentReport property! }
    xs.SerializeDefaultValues := not (ToParent is TfrxReport);
    if FromParent.Owner is TfrxComponent then
      xs.Owner := TfrxComponent(FromParent.Owner);
    s := xs.ObjToXML(FromParent);
    if ToParent.Owner is TfrxComponent then
      xs.Owner := TfrxComponent(ToParent.Owner);
    xs.XMLToObj(s, ToParent);
    xs.CopyFixupList(FixupList);
    xs.Free;
    i := 0;
    while (i < FromParent.Objects.Count) do
    begin
      cFrom := FromParent.Objects[i];
//      cTo := ToParent.Report.FindObject(cFrom.Name);
      cTo := Self.FindObject(cFrom.Name);
      inc(i);

      if (cTo <> nil) and not (cTo is TfrxPage) then
      begin
        { skip duplicate object }
        if DeleteDuplicates then continue;
        { set empty name for duplicate object, rename later }
        OldName := cFrom.Name;
        cFrom.Name := '';
        cTo := nil;
      end;

      if cTo = nil then
      begin
        cTo := TfrxComponent(cFrom.NewInstance);
        cTo.Create(ToParent);
        if cFrom.Name = '' then
        begin
          cTo.CreateUniqueName;
          tObj := tempReport.FindObject(cTo.Name);
          if tObj <> nil then
          begin
            tObj.Name := '';
            cFrom.Name := cTo.Name;
            tObj.CreateUniqueName;
          end
          else cFrom.Name := cTo.Name;
          FixNames(OldName, cTo.Name);
          if cFrom is TfrxDataSet then
          begin
            TfrxDataSet(cFrom).UserName := cFrom.Name;
            Self.DataSets.Add(TfrxDataSet(cTo));
          end;
        end
        else
          cTo.Name := cFrom.Name;

        if cFrom is TfrxSubreport then
        begin
          cFromSubPage := TfrxSubreport(cFrom).Page;
          TfrxSubreport(cTo).Page := TfrxReportPage.Create(Self);
          cToSubPage := TfrxSubreport(cTo).Page;
          cToSubPage.Assign(cFromSubPage);
          cToSubPage.CreateUniqueName;
          EnumObjects(cToSubPage, cFromSubPage);
          tempReport.Objects.Remove(cFromSubPage);
        end
      end;
      EnumObjects(cTo, cFrom);
    end;
  end;

begin
  Result := True;
{$IFDEF FPC}
  if (Length(FileName) > 1) and ((FileName[1] = '.') or (FileName[1] = PathDelim)) then
{$ELSE}
  if (Length(FileName) > 1) and ((FileName[1] = '.') or (FileName[1] = '\')) then
{$ENDIF}
    fn1 := ExpandFileName(FileName)
  else
    fn1 := FileName;

{$IFDEF FPC}
  if (Length(templName) > 1) and ((templName[1] = '.') or (templName[1] = PathDelim)) then
{$ELSE}
  if (Length(templName) > 1) and ((templName[1] = '.') or (templName[1] = '\')) then
{$ENDIF}
    fn2 := ExpandFileName(templName)
  else
    fn2 := templName;

  if fn1 = fn2 then
  begin
    Result := False;
    Exit;
  end;

  tempReport := TfrxReport.Create(nil);
  FixupList := TList.Create;
  tempReport.AssignAll(Self);
  { load the template }
  ParentReport := ExtractRelativePath(ExtractFilePath(FileName), templName);
  { find duplicate objects }
  found := False;
  l := tempReport.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if not (c is TfrxPage) and (FindObject(c.Name) <> nil) then
    begin
      found := True;
      break;
    end;
  end;

  deleteDuplicates := False;
  if (found) and (InheriteMode = imDefault) then
  begin
    with TfrxInheritErrorForm.Create(nil) do
    begin
      Result := ShowModal = mrOk;
      if Result then
        deleteDuplicates := DeleteRB.Checked;
      Free;
    end;
  end
  else
    deleteDuplicates := (InheriteMode = imDelete);

  if Result then
  begin
    saveScript := ScriptText.Text;
    EnumObjects(Self, tempReport);

    //load DataSets, Styles and Variables, rename if need
    for i := 0 to tempReport.DataSets.Count - 1 do
    begin
      DSi := DataSets.Find(tempReport.DataSets[i].DataSetName);
      if DSi = nil then
      begin
        DS := Self.FindDataSet(nil, tempReport.DataSets[i].DataSetName);
        if DS <> nil then
          DataSets.Add(DS);
      end;
    end;

    for i := 0 to tempReport.Variables.Count - 1 do
    begin
      rVar := tempReport.Variables.Items[i];
      Index := Variables.IndexOf(rVar.Name);

      if Index <> -1 then
        if not deleteDuplicates then
          rVar.Name := rVar.Name + '_renamed'
        else
          rVar := nil;
      if rVar <> nil then
        Variables.Add.Assign(rVar);
    end;

    for i := 0 to tempReport.Styles.Count - 1 do
    begin
      rStyle := tempReport.Styles[i];
      rStyle2 := Styles.Find(rStyle.Name);
      if rStyle2 <> nil then
        if not deleteDuplicates then
          rStyle.Name := rStyle.Name + '_renamed'
        else
          rStyle := nil;
      if rStyle <> nil then
        Styles.Add.Assign(rStyle);
    end;

    if (Script.SyntaxType = 'C++Script') or (Script.SyntaxType = 'JScript') then
    begin
      OpenQuote := '/*';
      CloseQuote := '*/';
    end
    else if (Script.SyntaxType = 'BasicScript') then
    begin
      OpenQuote := '/\';
      CloseQuote := '/\';
    end
    else if (Script.SyntaxType = 'PascalScript') then
    begin
      OpenQuote := '{';
      CloseQuote := '}';
    end;

    ScriptText.Add(OpenQuote);
    ScriptText.Add('**********Script from parent report**********');
    ScriptText.Text := ScriptText.Text + saveScript;
    ScriptText.Add(CloseQuote);

    { fixup datasets }
    for i := 0 to Self.DataSets.Count - 1 do
//      if DataSets[i].DataSet = nil then
      begin
        DS := Self.FindDataSet(nil, DataSets[i].DataSetName);
        DataSets[i].DataSet := DS;
      end;

    { fixup properties}
    while FixupList.Count > 0 do
    begin
      lItem := TfrxFixupItem(FixupList[0]);
      Ref := Self.FindObject(lItem.Value);
      if Ref = nil then
        Ref := frxFindComponent(Self, lItem.Value);
      if Ref <> nil then
        SetOrdProp(lItem.Obj, lItem.PropInfo, frInteger(Ref));
      lItem.Free;
      FixupList.Delete(0);
    end;
  end
  else
    AssignAll(tempReport);

  FixupList.Free;
  tempReport.Free;
end;

procedure TfrxReport.SetPreviewOptions(const Value: TfrxPreviewOptions);
begin
  FPreviewOptions.Assign(Value);
end;

procedure TfrxReport.SetPrintOptions(const Value: TfrxPrintOptions);
begin
  FPrintOptions.Assign(Value);
end;

procedure TfrxReport.SetReportOptions(const Value: TfrxReportOptions);
begin
  FReportOptions.Assign(Value);
end;

procedure TfrxReport.SetStyles(const Value: TfrxStyles);
begin
  if Value <> nil then
  begin
    FStyles.Assign(Value);
    FStyles.Apply;
  end
  else
    FStyles.ClearAll;
end;

procedure TfrxReport.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxReport.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := FindDataSet(FDataSet, FDataSetName);
end;

function TfrxReport.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

function TfrxReport.Calc(const Expr: String; AScript: TfsScript = nil): Variant;
{$IFDEF FPC}
const
  SZeroDivide = 'Division by zero.';
  {$warning HARDCODED CONST SZeroDivide}
{$ENDIF}

var
  ErrorMsg: String;
  CalledFromScript: Boolean;
begin
  CalledFromScript := False;
  if frInteger(AScript) = 1 then
  begin
    AScript := FScript;
    CalledFromScript := True;
  end;
  if AScript = nil then
    AScript := FScript;
  if not DoGetValue(Expr, Result) then
  begin
    Result := FExpressionCache.Calc(Expr, ErrorMsg, AScript);
    if (ErrorMsg <> '') and
     not ((ErrorMsg = SZeroDivide) and FEngineOptions.IgnoreDevByZero) then
      if FEngineOptions.IgnoreExprError then
        Result := Expr
      else
      begin
        if not CalledFromScript then
        begin
          if FCurObject <> '' then
            ErrorMsg := FCurObject + ': ' + ErrorMsg;
          FErrors.Add(ErrorMsg);
        end
        else ErrorMsg := frxResources.Get('clErrorInExp') + ErrorMsg;
      raise EReportScriptError.Create(ErrorMsg);
    end;
  end;
end;

function TfrxReport.GetAlias(DataSet: TfrxDataSet): String;
var
  ds: TfrxDataSetItem;
begin
  if DataSet = nil then
  begin
    Result := '';
    Exit;
  end;

  ds := DataSets.Find(DataSet);
  if ds <> nil then
    Result := ds.DataSet.UserName else
    Result := frxResources.Get('clDSNotIncl');
end;

function TfrxReport.GetDataset(const Alias: String): TfrxDataset;
var
  ds: TfrxDataSetItem;
begin
  ds := DataSets.Find(Alias);
  if ds <> nil then
    Result := ds.DataSet else
    Result := nil;
end;

procedure TfrxReport.GetDatasetAndField(const ComplexName: String;
  var DataSet: TfrxDataSet; var Field: String);
var
  i: Integer;
  s: String;
begin
  DataSet := nil;
  Field := '';

  { ComplexName has format: dataset name."field name"
    Spaces are allowed in both parts of the complex name }
  i := Pos('."', ComplexName);
  if i <> 0 then
  begin
    s := Copy(ComplexName, 1, i - 1); { dataset name }
    DataSet := GetDataSet(s);
    Field := Copy(ComplexName, i + 2, Length(ComplexName) - i - 2);
  end;
end;

procedure TfrxReport.GetDataSetList(List: TStrings; OnlyDB: Boolean = False);
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to DataSets.Count - 1 do
    if Datasets[i].DataSet <> nil then
      if not OnlyDB or not (DataSets[i].DataSet is TfrxUserDataSet) then
        List.AddObject(DataSets[i].DataSet.UserName, DataSets[i].DataSet);
end;

procedure TfrxReport.GetActiveDataSetList(List: TStrings);
var
  i: Integer;
  ds: TfrxDataSet;
begin
  if EngineOptions.FUseGlobalDataSetList then
    frxGetDataSetList(List)
  else
  begin
    List.Clear;
    for i := 0 to EnabledDataSets.Count - 1 do
    begin
      ds := EnabledDataSets[i].DataSet;
      if ds <> nil then
        List.AddObject(ds.UserName, ds);
    end;
  end;
end;

procedure TfrxReport.DoLoadFromStream;
var
  SaveLeftTop: Longint;
  Loaded: Boolean;
begin
  SaveLeftTop := DesignInfo;
  Loaded := False;

  if Assigned(frxFR2Events.OnLoad) then
    Loaded := frxFR2Events.OnLoad(Self, FLoadStream);

  if not Loaded then
    inherited LoadFromStream(FLoadStream);

  DesignInfo := SaveLeftTop;
end;

procedure TfrxReport.CheckDataPage;
var
  i, x: Integer;
  l: TList;
  hasDataPage, hasDataObjects: Boolean;
  p: TfrxDataPage;
  c: TfrxComponent;
begin
  { check if report has datapage and datacomponents }
  hasDataPage := False;
  hasDataObjects := False;
  l := AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c is TfrxDataPage then
      hasDataPage := True;
    if c is TfrxDialogComponent then
      hasDataObjects := True;
  end;

  if not hasDataPage then
  begin
    { create the datapage }
    p := TfrxDataPage.Create(Self);
    if FindObject('Data') = nil then
      p.Name := 'Data'
    else
      p.CreateUniqueName;

    { make it the first page }
    Objects.Delete(Objects.Count - 1);
    Objects.Insert(0, p);

    { move existing datacomponents to this page }
    if hasDataObjects then
    begin
      x := 60;
      for i := 0 to l.Count - 1 do
      begin
        c := l[i];
        if c is TfrxDialogComponent then
        begin
          c.Parent := p;
          c.Left := x;
          c.Top := 20;
          Inc(x, 64);
        end;
      end;
    end;
  end;
end;

procedure TfrxReport.LoadFromStream(Stream: TStream);
var
  Compressor: TfrxCustomCompressor;
  Crypter: TfrxCustomCrypter;
  SaveEngineOptions: TfrxEngineOptions;
  SavePreviewOptions: TfrxPreviewOptions;
  SaveConvertNulls: Boolean;
  SaveIgnoreDevByZero: Boolean;
  SaveIgnoreExprError: Boolean;
  SaveDoublePass, SavePrintIfEmpty: Boolean;
  SaveOutlineVisible, SaveOutlineExpand: Boolean;
  SaveOutlineWidth, SavePagesInCache: Integer;
  SaveIni: String;
  SavePreview: TfrxCustomPreview;
  SaveOldStyleProgress, SaveShowProgress, SaveStoreInDFM: Boolean;
  Crypted, SaveThumbnailVisible: Boolean;

  function DecodePwd(const s: String): String;
  var
    i: Integer;
  begin
    Result := '';
    for i := 1 to Length(s) do
      Result := Result + Chr(Ord(s[i]) + 10);
  end;
  { normally we are expect that there is no Global forms with DataSets         }
  { in multi-thread application, but just in case we fix DS link after TReader }
  procedure CheckMThreadDS;
  var
    List: TList;
    i: Integer;
    DSItem: TfrxDatasetItem;
  begin
    if not EngineOptions.UseGlobalDataSetList then
    begin
      List := TList.Create;
      try
        for i := 0 to DataSets.Count - 1 do
          if (DataSets.Items[i].DataSet <> nil) then
          begin
            DSItem := EnabledDataSets.Find(DataSets.Items[i].DataSetName);
            if Assigned(DSItem) then
              List.Add(DSItem.DataSet)
            { internal DS or DS witout owner }
            else if (DataSets.Items[i].DataSet.Owner = nil) or
              (DataSets.Items[i].DataSet.Owner is TfrxComponent) then
              List.Add(DataSets.Items[i].DataSet);
          end;
        DataSets.Clear;
        for i := 0 to List.Count - 1 do
          DataSets.Add(TfrxDataSet(List[i]));
      finally
        List.Free;
      end;
    end;
  end;

begin
  if IsReportActionRunning then
  begin
    FCommandManager.AddCommand(TfrxLoadFromStreamCommand.Create(Self, Stream));
    Exit;
  end;
  FErrors.Clear;

  Compressor := nil;
  if frxCompressorClass <> nil then
  begin
    Compressor := TfrxCustomCompressor(frxCompressorClass.NewInstance);
    Compressor.Create(nil);
    Compressor.Report := Self;
    Compressor.IsFR3File := True;
    try
      Compressor.CreateStream;
      if Compressor.Decompress(Stream) then
        Stream := Compressor.Stream;
    except
      Compressor.Free;
      FErrors.Add(frxResources.Get('clDecompressError'));
      frxCommonErrorHandler(Self, frxResources.Get('clErrors') + #13#10 + FErrors.Text);
      Exit;
    end;
  end;

  ReportOptions.Password := ReportOptions.HiddenPassword;
  Crypter := nil;
  Crypted := False;
  if frxCrypterClass <> nil then
  begin
    Crypter := TfrxCustomCrypter(frxCrypterClass.NewInstance);
    Crypter.Create(nil);
    try
      Crypter.CreateStream;
{$IFDEF DELPHI12}
      Crypted := Crypter.Decrypt(Stream, AnsiString(ReportOptions.Password));
{$ELSE}
      Crypted := Crypter.Decrypt(Stream, ReportOptions.Password);
{$ENDIF}
      if Crypted then
        Stream := Crypter.Stream;
    except
      Crypter.Free;
      FErrors.Add(frxResources.Get('clDecryptError'));
      frxCommonErrorHandler(Self, frxResources.Get('clErrors') + #13#10 + FErrors.Text);
      Exit;
    end;
  end;

  SaveEngineOptions := TfrxEngineOptions.Create;
  FEngineOptions.PrintIfEmpty := True;
  SaveEngineOptions.Assign(FEngineOptions);
  SavePreviewOptions := TfrxPreviewOptions.Create;
  SavePreviewOptions.Assign(FPreviewOptions);
  SaveIni := FIniFile;
  SavePreview := FPreview;
  SaveOldStyleProgress := FOldStyleProgress;
  SaveShowProgress := FShowProgress;
  SaveStoreInDFM := FStoreInDFM;
  FStreamLoaded := True;
  try
    FLoadStream := Stream;
    try
      DoLoadFromStream;
    except
      on E: Exception do
      begin
        FStreamLoaded := False;
        if (E is TfrInvalidXMLException) and Crypted then
          FErrors.Add('Invalid password')
       else
         FErrors.Add(E.Message)
      end;
    end;
  finally
    if Compressor <> nil then
      Compressor.Free;
    if Crypter <> nil then
      Crypter.Free;

    CheckDataPage;
    CheckMThreadDS;
    SaveConvertNulls := FEngineOptions.ConvertNulls;
    SaveIgnoreDevByZero := FEngineOptions.IgnoreDevByZero;
    SaveIgnoreExprError := FEngineOptions.IgnoreExprError;
    SaveDoublePass := FEngineOptions.DoublePass;
    SavePrintIfEmpty := FEngineOptions.PrintIfEmpty;
    FEngineOptions.Assign(SaveEngineOptions);
    FEngineOptions.ConvertNulls := SaveConvertNulls;
    FEngineOptions.IgnoreDevByZero := SaveIgnoreDevByZero;
    FEngineOptions.IgnoreExprError := SaveIgnoreExprError;
    FEngineOptions.DoublePass := SaveDoublePass;
    FEngineOptions.PrintIfEmpty := SavePrintIfEmpty;
    SaveEngineOptions.Free;

    SaveOutlineVisible := FPreviewOptions.OutlineVisible;
    SaveOutlineWidth := FPreviewOptions.OutlineWidth;
    SaveOutlineExpand := FPreviewOptions.OutlineExpand;
    SavePagesInCache := FPreviewOptions.PagesInCache;
    SaveThumbnailVisible := FPreviewOptions.ThumbnailVisible;
    FPreviewOptions.Assign(SavePreviewOptions);
    FPreviewOptions.OutlineVisible := SaveOutlineVisible;
    FPreviewOptions.OutlineWidth := SaveOutlineWidth;
    FPreviewOptions.OutlineExpand := SaveOutlineExpand;
    FPreviewOptions.PagesInCache := SavePagesInCache;
    FPreviewOptions.ThumbnailVisible := SaveThumbnailVisible;
    SavePreviewOptions.Free;
    FIniFile := SaveIni;
    FPreview := SavePreview;
    FOldStyleProgress := SaveOldStyleProgress;
    FShowProgress := SaveShowProgress;
    FStoreInDFM := SaveStoreInDFM;
    if not Crypted then
      ReportOptions.Password := DecodePwd(ReportOptions.Password);

    if ReportOptions.Info or ((not FReloading) and
       (not FEngineOptions.EnableThreadSafe) and
       (not Crypted and not FReportOptions.CheckPassword)) then

      Clear
    else if (FErrors.Count > 0) then
      frxCommonErrorHandler(Self, frxResources.Get('clErrors') + #13#10 + FErrors.Text);
  end;
end;

procedure TfrxReport.SaveToStream(Stream: TStream; SaveChildren: Boolean = True;
  SaveDefaultValues: Boolean = False; UseGetAncestor: Boolean = False);
var
  Compressor: TfrxCustomCompressor;
  Crypter: TfrxCustomCrypter;
  StreamTo: TStream;
  SavePwd: String;
  SavePreview: TfrxCustomPreview;

  function EncodePwd(const s: String): String;
  var
    i: Integer;
  begin
    Result := '';
    for i := 1 to Length(s) do
      Result := Result + Chr(Ord(s[i]) - 10);
  end;

begin
  StreamTo := Stream;

  Compressor := nil;
  if FReportOptions.Compressed and (frxCompressorClass <> nil) then
  begin
    Compressor := TfrxCustomCompressor(frxCompressorClass.NewInstance);
    Compressor.Create(nil);
    Compressor.Report := Self;
    Compressor.IsFR3File := True;
    Compressor.CreateStream;
    StreamTo := Compressor.Stream;
  end;

  Crypter := nil;
  if (FReportOptions.Password <> '') and (frxCrypterClass <> nil) then
  begin
    Crypter := TfrxCustomCrypter(frxCrypterClass.NewInstance);
    Crypter.Create(nil);
    Crypter.CreateStream;
    StreamTo := Crypter.Stream;
  end;

  SavePwd := ReportOptions.Password;
  ReportOptions.PrevPassword := SavePwd;
  if Crypter = nil then
    ReportOptions.Password := EncodePwd(SavePwd);
  SavePreview := FPreview;
  FPreview := nil;

  try
    inherited SaveToStream(StreamTo, SaveChildren, SaveDefaultValues, UseGetAncestor);
  finally
    FPreview := SavePreview;
    ReportOptions.Password := SavePwd;
    { crypt }
    if Crypter <> nil then
    begin
      try
        if Compressor <> nil then
{$IFDEF DELPHI12}
          Crypter.Crypt(Compressor.Stream, UTF8Encode(ReportOptions.Password))
{$ELSE}
          Crypter.Crypt(Compressor.Stream, ReportOptions.Password)
{$ENDIF}
        else
{$IFDEF DELPHI12}
          Crypter.Crypt(Stream, UTF8Encode(ReportOptions.Password));
{$ELSE}
          Crypter.Crypt(Stream, ReportOptions.Password);
{$ENDIF}
      finally
        Crypter.Free;
      end;
    end;
    { compress }
    if Compressor <> nil then
    begin
      try
        Compressor.Compress(Stream);
      finally
        Compressor.Free;
      end;
    end;
  end;
end;

function TfrxReport.LoadFromFile(const FileName: String;
  ExceptionIfNotFound: Boolean = False): Boolean;
var
  f: TfrxIOTransportFile;
  bIsFileNameRef: Boolean;
begin
  if IsReportActionRunning then
  begin
    FCommandManager.AddCommand(TfrxLoadFromFileCommand.Create(Self, FileName, ExceptionIfNotFound));
    Result := False;
    Exit;
  end;
  { protection from users who tring to shoot his leg }
  { and use Report.LoadFromFile(Report.FileName) construction #553109 }
  bIsFileNameRef := (@FileName[1] = @FFileName[1]);
  Clear;
  if not bIsFileNameRef then
    FFileName := '';
  Result := FileExists(FileName);
  if Result or ExceptionIfNotFound then
  begin
    f := TfrxIOTransportFile.CreateNoRegister;
    try
      if not bIsFileNameRef then
        FFileName := FileName;
      //f.FileName := FileName;
      ProcessIOTransport(f, FileName, faRead);
    finally
      f.Free;
    end;
  end;
end;

function TfrxReport.LoadFromFilter(Filter: TfrxCustomIOTransport;
  const FileName: String): Boolean;
begin
  if IsReportActionRunning then
  begin
    FCommandManager.AddCommand(TfrxLoadFromCommand.Create(Self, Filter, FileName));
    Result := False;
  end
  else
    Result := ProcessIOTransport(Filter, FileName, faRead);
end;

procedure TfrxReport.SaveToFile(const FileName: String);
var
  f: TfrxIOTransportFile;
begin
  //fix up ParentReport property
  if (Length(FParentReport) > 1) and (FParentReport[2] = ':') then
    FParentReport := ExtractRelativePath(ExtractFilePath(FileName), FParentReport);
  f := TfrxIOTransportFile.CreateNoRegister;
  f.BasePath := ExtractFilePath(FileName);
  try
    ProcessIOTransport(f, FileName, faWrite);
  finally
    f.Free;
  end;
end;

function TfrxReport.SaveToFilter(Filter: TfrxCustomIOTransport; const FileName: String): Boolean;
begin
  Result := ProcessIOTransport(Filter, FileName, faWrite);
end;

function TfrxReport.GetIniFile: TCustomIniFile;
begin
  {$IFNDEF FPC}
  if Pos('\Software\', FIniFile) = 1 then
    Result := TRegistryIniFile.Create(FIniFile)
  else
  {$ENDIF}
    Result := TIniFile.Create(FIniFile);
end;

function TfrxReport.GetApplicationFolder: String;
begin
  if csDesigning in ComponentState then
{$IFDEF FPC}
    Result := GetCurrentDir + PathDelim
{$ELSE}
    Result := GetCurrentDir + '\'
{$ENDIF}
  else
    Result := ExtractFilePath(Application.ExeName);
end;

procedure TfrxReport.SelectPrinter;
begin
  if frxPrinters.IndexOf(FPrintOptions.Printer) <> -1 then
    frxPrinters.PrinterIndex := frxPrinters.IndexOf(FPrintOptions.Printer);
end;

procedure TfrxReport.DoNotifyEvent(Obj: TObject; const EventName: String;
  RunAlways: Boolean = False);
begin
{$IFNDEF FR_VER_BASIC}
  if FEngine.Running or RunAlways then
    if EventName <> '' then
      FScript.CallFunction(EventName, VarArrayOf([frInteger(Obj)]), True);
{$ENDIF}
end;

procedure TfrxReport.DoParamEvent(const EventName: String; var Params: Variant;
  RunAlways: Boolean = False);
begin
{$IFNDEF FR_VER_BASIC}
  if FEngine.Running or RunAlways then
    if EventName <> '' then
      FScript.CallFunction1(EventName, Params, True);
{$ENDIF}
end;

procedure TfrxReport.DoBeforePrint(c: TfrxReportComponent);
begin
  if Assigned(FOnBeforePrint) then
    FOnBeforePrint(c);
  DoNotifyEvent(c, c.OnBeforePrint);
end;

procedure TfrxReport.DoAfterPrint(c: TfrxReportComponent);
begin
  if Assigned(FOnAfterPrint) then
    FOnAfterPrint(c);
  DoNotifyEvent(c, c.OnAfterPrint);
end;

procedure TfrxReport.DoPreviewClick(v: TfrxView; Button: TMouseButton;
  Shift: TShiftState; var Modified: Boolean; var EventParams: TfrxInteractiveEventsParams; DblClick: Boolean);
var
  arr: Variant;
begin
  v.MouseClick(DblClick, EventParams);
  arr := VarArrayOf([frInteger(v), Button, ShiftToByte(Shift), Modified]);
  if DblClick then
    DoParamEvent(v.OnPreviewDblClick, arr, True)
  else
    DoParamEvent(v.OnPreviewClick, arr, True);
  Modified := arr[3];
  if DblClick then
  begin
    if Assigned(FOnDblClickObject) then
      FOnDblClickObject(v, Button, Shift, Modified)
  end
  else
  begin
    if Assigned(FOnClickObject) then
      FOnClickObject(v, Button, Shift, Modified);
  end;
end;

procedure TfrxReport.DoGetAncestor(const Name: String; var Ancestor: TPersistent);
begin
  if FParentReportObject <> nil then
  begin
    if Name = Self.Name then
      Ancestor := FParentReportObject
    else
      Ancestor := FParentReportObject.FindObject(Name);
  end;
end;

function TfrxReport.DoGetValue(const Expr: String; var Value: Variant): Boolean;
var
  i: Integer;
  ds: TfrxDataSet;
  fld: String;
  val: Variant;
  v: TfsCustomVariable;
begin
  Result := False;
  Value := Null;

  if Assigned(frxFR2Events.OnGetValue) then
  begin
    TVarData(val).VType := varEmpty;
    frxFR2Events.OnGetValue(Expr, val);
    if TVarData(val).VType <> varEmpty then
    begin
      Value := val;
      Result := True;
      Exit;
    end;
  end;

  { maybe it's a dataset/field? }
  GetDataSetAndField(Expr, ds, fld);
  if (ds <> nil) and (fld <> '') then
  begin
    Value := ds.Value[fld];
    if FEngineOptions.ConvertNulls and (Value = Null) then
      case ds.FieldType[fld] of
        fftNumeric, fftDateTime:
          Value := 0;
        fftString:
          Value := '';
        fftBoolean:
          Value := False;
      end;
    Result := True;
    Exit;
  end;

  { searching in the sys variables }
  i := FSysVariables.IndexOf(Expr);
  if i <> -1 then
  begin
    case i of
      0: Value := FEngine.StartDate;  { Date }
      1: Value := FEngine.StartTime;  { Time }
      2: Value := PreviewPages.GetLogicalPageNo; { Page }
      3: Value := PreviewPages.CurPage + 1;  { Page# }
      4: Value := PreviewPages.GetLogicalTotalPages;  { TotalPages }
      5: Value := FEngine.TotalPages;  { TotalPages# }
      6: Value := FEngine.CurLine;  { Line }
      7: Value := FEngine.CurLineThrough; { Line# }
      8: Value := frxGlobalVariables['CopyName0'];
      9: Value := FEngine.CurTableRow;
      10: Value := FEngine.CurTableColumn;
    end;
    Result := True;
    Exit;
  end;

  { value supplied by OnGetValue event }
  TVarData(val).VType := varEmpty;
  if Assigned(FOnGetValue) then
    FOnGetValue(Expr, val);
  if Assigned(FOnNewGetValue) then
    FOnNewGetValue(Self, Expr, val);
  if TVarData(val).VType <> varEmpty then
  begin
    Value := val;
    Result := True;
    Exit;
  end;

  { searching in the variables }
  i := FVariables.IndexOf(Expr);
  if i <> -1 then
  begin
    val := FVariables.Items[i].Value;
    if (TVarData(val).VType = varString) or (TVarData(val).VType = varOleStr){$IFDEF DELPHI12} or (TVarData(val).VType = varUString){$ENDIF} then
    begin
      if Pos(#13#10, val) <> 0 then
        Value := val
      else
        Value := Calc(val);
    end
    else
      Value := val;
    Result := True;
    Exit;
  end;

  { searching in the global variables }
  i := frxGlobalVariables.IndexOf(Expr);
  if i <> -1 then
  begin
    Value := frxGlobalVariables.Items[i].Value;
    Result := True;
    Exit;
  end;

  if not Assigned(frxFR2Events.OnGetScriptValue) then
  begin
    { searching in the script }
    v := FScript.FindLocal(Expr);
    if (v <> nil) and
      not ((v is TfsProcVariable) or (v is TfsMethodHelper)) then
    begin
      Value := v.Value;
      Result := True;
      Exit;
    end;
  end;
end;

function TfrxReport.GetScriptValue(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
var
  i: Integer;
  s: String;
begin
  if not DoGetValue(Params[0], Result) then
  begin
    { checking aggregate functions }
    s := VarToStr(Params[0]);
    i := Pos('(', s);
    if i <> 0 then
    begin
      s := UpperCase(Trim(Copy(s, 1, i - 1)));
      if (s = 'SUM') or (s = 'MIN') or (s = 'MAX') or
         (s = 'AVG') or (s = 'COUNT') then
      begin
        Result := Calc(Params[0]);
        Exit;
      end;
    end;

    if Assigned(frxFR2Events.OnGetScriptValue) then
      Result := frxFR2Events.OnGetScriptValue(Params)
    else
	  if FEngineOptions.IgnoreExprError then
	    Result := Params[0]
	  else
        FErrors.Add(frxResources.Get('clUnknownVar') + ' ' + VarToStr(Params[0]));
  end;
end;

function TfrxReport.SetScriptValue(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
begin
  FVariables[Params[0]] := Params[1];
end;

procedure TfrxReport.SetScriptVar(const vName: String; Obj: TObject);
var
  v: TfsCustomVariable;
begin
  v := FScript.Find(vName);
  if Assigned(v) then
    v.Value := frInteger(Obj)
  else
    FScript.AddObject(vName, Obj);
end;

function TfrxReport.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
var
  p1, p2, p3: Variant;
  AggObj: IfrxAggregateObject;
begin
  if MethodName = 'IIF' then
  begin
    p1 := Params[0];
    p2 := Params[1];
    p3 := Params[2];
    try
      if Calc(p1, FScript.ProgRunning) = True then
        Result := Calc(p2, FScript.ProgRunning) else
        Result := Calc(p3, FScript.ProgRunning);
    except
    end;
  end
  else
  begin
    { do not use ProgName for Aggregates }
    if FScript.ProgName <> '' then
      FScript.ProgName := '';
    if (MethodName = 'SUM') or (MethodName = 'AVG') or (MethodName = 'MIN') or
      (MethodName = 'MAX') then
    begin
      { special case , currently only for Table cells }
      if Supports(SelfValue, IfrxAggregateObject, AggObj) and (VarToStr(Params[1]) = '') then
      begin
        p1 := '';
        p3 := 0;
        p2 := Calc(Params[0], FScript.ProgRunning);
      end
      else
      begin
        p1 := Params[0];
        p2 := Params[1];
        if Trim(VarToStr(p2)) = '' then
          p2 := 0
        else
          p2 := Calc(p2, FScript.ProgRunning);
        p3 := Params[2];
        if Trim(VarToStr(p3)) = '' then
          p3 := 0
        else
          p3 := Calc(p3, FScript.ProgRunning);
      end;
      Result := FEngine.GetAggregateValue(MethodName, p1, TfrxComponent(frInteger(p2)), p3);
    end
    else if MethodName = 'COUNT' then
    begin
      p1 := Params[0];
      if Trim(VarToStr(p1)) = '' then
        p1 := 0
      else
        p1 := Calc(p1, FScript.ProgRunning);
      p2 := Params[1];
      if Trim(VarToStr(p2)) = '' then
        p2 := 0
      else
        p2 := Calc(p2, FScript.ProgRunning);
      Result := FEngine.GetAggregateValue(MethodName, '', TfrxComponent(frInteger(p1)), p2);
    end;
  end;
end;

function TfrxReport.DoUserFunction(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
begin
  if Assigned(FOnUserFunction) then
    Result := FOnUserFunction(MethodName, Params);
end;

function TfrxReport.PrepareScript(ActiveReport: TfrxReport): Boolean;
var
  i: Integer;
  l, l2: TList;
  c, c2: TfrxComponent;
  IsAncenstor: Boolean;
  SaveScript: TfsScript;
  v: TfsMethodHelper;

  function FindParentObj(sName: String): TfrxComponent;
  var
    i: Integer;
  begin
    Result := nil;
    if ActiveReport = Self then Exit;
    l2 := ActiveReport.AllObjects;
    for i := 0 to l2.Count - 1 do
    begin
      c2 := l2[i];
      if c2.Name = sName then
      begin
        Result := c2;
        break;
      end;
    end;
  end;

begin
  IsAncenstor := (FParentReportObject <> nil);

  if IsAncenstor then
  begin
    if (FSaveParentScript = nil) and (FScript.Parent <> FParentReportObject.FScript) then
      FSaveParentScript := FScript.Parent;
  end
  else if FSaveParentScript = nil then
    FSaveParentScript := FScript.Parent;
  if (FSaveParentScript <> nil) and (FParentReportObject <> nil) then
    FParentReportObject.FSaveParentScript := FSaveParentScript;
  if ActiveReport = nil then
    ActiveReport := Self;
  if IsAncenstor then
  begin
    // copy user functions
    for i := 0 to FScript.Count - 1 do
      if FScript.Items[i] is TfsMethodHelper then
        if FScript.Items[i].AddedBy = TObject(2) then
        begin
          FParentReportObject.Script.AddedBy := TObject(2);
          v := TfsMethodHelper(FScript.Items[i]);
          FParentReportObject.Script.AddMethod(v.Syntax, DoUserFunction,  v.Category,  v.Description);
          FParentReportObject.Script.AddedBy :=  nil;
        end;
    Result := FParentReportObject.PrepareScript(ActiveReport);
    if not Result then
    begin
      FErrors.Add(Format(frxResources.Get('clScrError'),
        ['Parent report: ' + FParentReport + ' Line: ' + FParentReportObject.FScript.ErrorPos, FParentReportObject.FScript.ErrorMsg]));
      Exit;
    end;
  end;

  FExpressionCache.Clear;
  FExpressionCache.FScriptLanguage := FScriptLanguage;
  FEngine.NotifyList.Clear;

  FScript.ClearItems(ActiveReport);
  FScript.AddedBy := ActiveReport;
  FScript.MainProg := True;
  if IsAncenstor then
    FScript.Parent := FParentReportObject.FScript
  else
    FScript.Parent := FSaveParentScript;

  try
    l := AllObjects;

    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      c2 := FindParentObj(c.Name);
      if c2 = nil then c2 := c;

      c2.IsDesigning := False;
      { need for cross InitMemos in Inherite report }
      SaveScript := ActiveReport.FScript;
      ActiveReport.FScript := FScript;
      c2.BeforeStartReport;
      ActiveReport.FScript := SaveScript;
      if c2 is TfrxPictureView then
        TfrxPictureView(c2).FPictureChanged := True;
      if not c.IsAncestor then
        FScript.AddObject(c2.Name, c2);
    end;

    FScript.AddObject('Report', ActiveReport);
    FScript.AddObject('PreviewPages', ActiveReport.PreviewPages);
    FScript.AddObject('Engine', ActiveReport.FEngine);
    FScript.AddObject('Outline', ActiveReport.PreviewPages.Outline);
    FScript.AddVariable('Value', 'Variant', Null);
    FScript.AddVariable('Self', 'TfrxView', Null);
    FScript.AddMethod('function Get(Name: String): Variant', ActiveReport.GetScriptValue);
    FScript.AddMethod('procedure Set(Name: String; Value: Variant)', ActiveReport.SetScriptValue);
    FScript.AddMethod('macrofunction IIF(Expr: Boolean; TrueValue, FalseValue: Variant): Variant',
      ActiveReport.CallMethod);
    FScript.AddMethod('macrofunction SUM(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      ActiveReport.CallMethod);
    FScript.AddMethod('macrofunction AVG(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      ActiveReport.CallMethod);
    FScript.AddMethod('macrofunction MIN(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      ActiveReport.CallMethod);
    FScript.AddMethod('macrofunction MAX(Expr: Variant; Band: Variant = 0; Flags: Integer = 0): Variant',
      ActiveReport.CallMethod);
    FScript.AddMethod('macrofunction COUNT(Band: Variant = 0; Flags: Integer = 0): Variant',
      ActiveReport.CallMethod);

    if Assigned(frxFR2Events.OnPrepareScript) then
      frxFR2Events.OnPrepareScript(ActiveReport);
    FLocalValue := FScript.Find('Value');
    FSelfValue := FScript.Find('Self');
    FScript.Lines := FScriptText;
    FScript.SyntaxType := FScriptLanguage;
  {$IFNDEF FR_VER_BASIC}
    Result := FScript.Compile;
    if not Result then
      FErrors.Add(Format(frxResources.Get('clScrError'),
        [FScript.ErrorPos, FScript.ErrorMsg]));
  {$ELSE}
    Result := True;
  {$ENDIF}
    FIsScriptObjectsAdded := Result;
  finally
    FScript.AddedBy := nil;
    //FSaveParentScript := nil;
  end;
end;

procedure TfrxReport.PreviewPagesChanged;
begin
  if Assigned(FPreview) then
    FPreview.PreviewPagesChanged;
end;

function TfrxReport.PrepareReport(ClearLastReport: Boolean = True): Boolean;
var
  TempStream: TStream;
  ErrorsText: String;
  ErrorMessage: String;
  SavePwd: String;
  SaveSplisLine: Integer;
  TmpFile: String;
  EngineRun: Boolean;
  SaveDuplex: TfrxDuplexMode;

  function CheckDatasets: Boolean;
  var
    i: Integer;
  begin
    for i := 0 to FDataSets.Count - 1 do
      if FDatasets[i].DataSet = nil then
        FErrors.Add(Format(frxResources.Get('clDSNotExist'), [FDatasets[i].DataSetName]));
    Result := FErrors.Count = 0;
  end;

begin
  if IsReportActionRunning then
  begin
    FCommandManager.AddCommand(TfrxPrepareReportCommand.Create(Self, ClearLastReport));
    Result := False;
    Exit;
  end;
  FPreparing := True;
  try
    if ClearLastReport then
      PreviewPages.Clear;

    if FPreview <> nil then
      FPreview.Init(Self, PreviewPages);
    SaveSplisLine := 0;
    FErrors.Clear;
    FTerminated := False;
    Result := False;
    EngineRun := False;

    if CheckDatasets then
    begin
      TempStream := nil;
      SavePwd := ReportOptions.Password;

      { save the report state }
      if FEngineOptions.DestroyForms then
      begin
        if EngineOptions.UseFileCache then
        begin
          TmpFile := frxCreateTempFile(EngineOptions.TempDir);
          TempStream := TFileStream.Create(TmpFile, fmCreate);
        end
        else
          TempStream := TMemoryStream.Create;

        ReportOptions.Password := '';
        SaveSplisLine := PrintOptions.SplicingLine;
        SaveToStream(TempStream);
      end;

      try
        if Assigned(FOnBeginDoc) then
          FOnBeginDoc(Self);
        if PrepareScript then
        begin
{$IFNDEF FR_VER_BASIC}
          if Assigned(FOnAfterScriptCompile) then
            FOnAfterScriptCompile(Self);
          if FScript.Statement.Count > 0 then
            FScript.Execute;
{$ENDIF}
          if not Terminated then
            EngineRun := FEngine.Run(True);
          if EngineRun then
          begin
            if Assigned(FOnEndDoc) then
              FOnEndDoc(Self);
            Result := True
          end
          else if FPreviewForm <> nil then
            FPreviewForm.Close;
        end;
      except
        on e: Exception do
{$IFNDEF FR_VER_BASIC}
          if FScript.ErrorPos <> '' then
            FErrors.Add(e.Message + ' ' + FScript.ErrorPos)
          else
{$ENDIF}
            FErrors.Add(e.Message);
      end;

      if Assigned(TempStream) then
      begin
        ErrorsText := FErrors.Text;
        TempStream.Position := 0;
        FReloading := True;
        SaveDuplex := PrintOptions.Duplex;
        try
          // if FEngineOptions.ReportThread = nil then
          FPreparing := False;
          LoadFromStream(TempStream);
        finally
          FReloading := False;
          FPreparing := True;
          ReportOptions.Password := SavePwd;
          PrintOptions.SplicingLine := SaveSplisLine;
          PrintOptions.Duplex := SaveDuplex;
          RestoreScriptObjectsRef;
        end;
        TempStream.Free;
        if EngineOptions.UseFileCache then
          SysUtils.DeleteFile(TmpFile);
        FErrors.Text := ErrorsText;
      end;
    end;
    if FErrors.Text <> '' then
    begin
      Result := False;
      ErrorMessage := frxResources.Get('clErrors') + #13#10 + FErrors.Text;
      frxCommonErrorHandler(Self, ErrorMessage);
    end;
  finally
    FPreparing := False;
  end;
  RunDelayedCommands;
end;

procedure TfrxReport.ShowPreparedReport; {$IFDEF UNIX}cdecl;{$ELSE}stdcall;{$ENDIF}
var
  WndExStyles: Integer;
begin
  FPreviewForm := nil;
  if FPreview <> nil then
    FPreview.Init(Self, PreviewPages)
  else
  begin
    FPreviewForm := TfrxPreviewForm.Create(Designer);
    with TfrxPreviewForm(FPreviewForm) do
    begin
      Self.Preview := Preview;
      Init;
      if Assigned(FOnPreview) then
        FOnPreview(Self);
      if PreviewOptions.Maximized then
        Position := poDesigned;
      if FPreviewOptions.Modal then
      begin
        ShowModal;
        Free;
        FPreviewForm := nil;
      end
      else
      begin
        if not FPreviewOptions.MDIChild then
        begin
          WndExStyles := GetWindowLong(Handle, GWL_EXSTYLE);
          SetWindowLong(Handle, GWL_EXSTYLE, WndExStyles or WS_EX_APPWINDOW);
        end;
        FreeOnClose := True;
        Show;
      end;
    end;
  end;
end;

procedure TfrxReport.ShowReport(ClearLastReport: Boolean = True); {$IFDEF UNIX}cdecl;{$ELSE}stdcall;{$ENDIF}
begin
  { protection from people whow like to click ESC/ENTER and rebuil reports less than a second }
  //if Engine.Running then
  //  Exit;
  if IsReportActionRunning then
  begin
    FCommandManager.AddCommand(TfrxShowReportCommand.Create(Self, ClearLastReport));
    Exit;
  end;

  if FOldStyleProgress and Assigned(Script.ProgRunning) then
    raise Exception.Create('Rebuild itself from the script is not allowed!');
  if ClearLastReport then
    PreviewPages.Clear;

  if FOldStyleProgress then
  begin
    if PrepareReport(False) then
      ShowPreparedReport;
  end
  else
  begin
    FTimer.Enabled := True;
    ShowPreparedReport;
  end;
end;

procedure TfrxReport.UpdateGlobalScritVars;
begin
  SetScriptVar('Report', Self);
  SetScriptVar('PreviewPages', PreviewPages);
  SetScriptVar('Engine', Engine);
  SetScriptVar('Outline', PreviewPages.Outline);
end;

procedure TfrxReport.OnTimer(Sender: TObject);
begin
  if Assigned(Script.ProgRunning) then
    Exit;
  FTimer.Enabled := False;
  PrepareReport(False);
end;

{$HINTS OFF}

{$UNDEF FR_RUN_DESIGNER}

{$IFDEF FR_LITE}
  {$DEFINE FR_RUN_DESIGNER}
{$ENDIF}

{$IFNDEF ACADEMIC_ED}
{$IFNDEF FR_VER_BASIC}
  {$DEFINE FR_RUN_DESIGNER}
{$ENDIF}
{$ELSE}
{$IFDEF FPC}
  {$DEFINE FR_RUN_DESIGNER}
{$ENDIF}
{$ENDIF}

procedure TfrxReport.DesignReport(Modal: Boolean = True; MDIChild: Boolean = False); {$IFDEF UNIX}cdecl;{$ELSE}stdcall;{$ENDIF}
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
  WndExStyles: Integer;
begin
{$IFDEF FR_RUN_DESIGNER}
  if FDesigner <> nil then Exit;
  if frxDesignerClass <> nil then
  begin
    FScript.ClearItems(Self);
    l := AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if c is TfrxCustomDBDataset then
      begin
        c.IsDesigning := True;
        c.BeforeStartReport;
      end;
    end;

    FModified := False;
    FDesigner := TfrxCustomDesigner(frxDesignerClass.NewInstance);
    FDesigner.CreateDesigner(nil, Self);

    if MDIChild then
      FDesigner.FormStyle := fsMDIChild;
    PostMessage(FDesigner.Handle, WM_USER + 1, 0, 0);
    if Modal then
    begin
      FDesigner.ShowModal;
      FDesigner.Free;
      Application.ProcessMessages;
      FDesigner := nil;
    end
    else
    begin
      {if window not modal show it in taskbar}
      WndExStyles := GetWindowLong(FDesigner.Handle, GWL_EXSTYLE);
      SetWindowLong(FDesigner.Handle, GWL_EXSTYLE, WndExStyles or WS_EX_APPWINDOW);
      FDesigner.Show;
    end;
  end;
{$ENDIF}
end;
{$HINTS ON}

procedure TfrxReport.DesignReportInPanel(Panel: TWinControl);
{$IFDEF FR_RUN_DESIGNER}
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
  cp: TWinControl;
{$ENDIF}
begin
{$IFDEF FR_RUN_DESIGNER}
  if FDesigner <> nil then Exit;
  if frxDesignerClass <> nil then
  begin
    FScript.ClearItems(Self);
    l := AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := l[i];
      if c is TfrxCustomDBDataset then
        c.BeforeStartReport;
    end;

    FModified := False;
    FDesigner := TfrxCustomDesigner(frxDesignerClass.NewInstance);
    FDesigner.CreateDesigner(nil, Self);
    cp := Panel.Parent;
    while cp <> nil do
    begin
      if cp is TForm then
        FDesigner.ParentForm := TForm(cp);
      cp := cp.Parent;
    end;
    PostMessage(FDesigner.Handle, WM_USER + 1, 0, 0);
    FDesigner.HostControls(Panel);
  end;
{$ENDIF}
end;


procedure TfrxReport.DesignReport(IDesigner: {$IFDEF FPC}TObject{$ELSE}IUnknown{$ENDIF}; Editor: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
begin
  if FDesigner <> nil then
  begin
    FDesigner.Activate;
    Exit;
  end;
  if (IDesigner = nil) or (Editor.ClassName <> 'TfrxReportEditor') then Exit;

  l := AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if c is TfrxCustomDBDataset then
      c.BeforeStartReport;
  end;

  FDesigner := TfrxCustomDesigner(frxDesignerClass.NewInstance);
  FDesigner.CreateDesigner(nil, Self);
  FDesigner.ShowModal;
end;

{$HINTS OFF}
function TfrxReport.DesignPreviewPage: Boolean;
begin
  Result := False;
{$IFNDEF FR_VER_BASIC}
{$IFNDEF ACADEMIC_ED}
  if FDesigner <> nil then Exit;
  if frxDesignerClass <> nil then
  begin
    FDesigner := TfrxCustomDesigner(frxDesignerClass.NewInstance);
    FDesigner.CreateDesigner(nil, Self, True);
    FDesigner.ShowModal;
    Result := FModified;
  end;
{$ENDIF}
{$ENDIF}
end;
{$HINTS ON}

function TfrxReport.Export(Filter: TfrxCustomExportFilter): Boolean;
begin
  Result := PreviewPages.Export(Filter);
end;

function TfrxReport.FindObject(const AName: String): TfrxComponent;
  { we are using this code for DS on datamodules which created in threads }
  { when UseGlobalDataSetList is off                                      }
  function GetDSName: String;
  var
    i, pos: Integer;
  begin
    pos := 1;
    for i := Length(AName) downto 1 do
      if AName[i] = '.' then
      begin
        pos := i + 1;
        break;
      end;
    Result := Copy(AName, pos, Length(AName) - pos + 1);
  end;

begin
  Result := Inherited FindObject(AName);
  if (Result = nil) and IsLoading and not EngineOptions.UseGlobalDataSetList and
    (EnabledDataSets.Count > 0) then
    Result := FindDataSet(nil, GetDSName);
end;

procedure TfrxReport.FixUpParentReport;
begin
  { fix only when ParentReport contains path relative from current template }
  { in other cases (absolute or releative to App) leave it as is }
  if Assigned(FParentReportObject) and  (Length(ParentReport) > 2)
    and (ParentReport[2] <> ':') and (ParentReport[1] <> '\')
    and (ParentReport[2] <> '\') and not FileExists(GetApplicationFolder + ParentReport)
    and (FFileName <> '') and not Assigned(OnLoadTemplate) then
    FParentReport := ExtractRelativePath(ExtractFilePath(FFileName), frxExpandRelativePath(FParentReportObject.FileName));
end;

function TfrxReport.Print: Boolean;
begin
  Result := PreviewPages.Print;
end;

function TfrxReport.ProcessIOTransport(Filter: TfrxCustomIOTransport;
  const FileName: String; fAccess: TfrxFilterAccess): Boolean;
var
  FilterStream: TStream;
begin
  Result := False;
  if Filter = nil then Exit;
  Filter.FilterAccess := fAccess;
  if (FileName = '') and (Filter.FileName = '') then
    Filter.FileName := ExtractFileName(Report.FileName);
  Filter.Report := Self;
  Result := Filter.OpenFilter;
  try
    if Result then
    begin
      FilterStream := Filter.GetStream(FileName);
      if FilterStream <> nil then
      begin

        if Filter.FileName <> '' then
          FFileName := Filter.FileName;
            //fix up ParentReport property
        //if (Length(FParentReport) > 1) and (FParentReport[2] = ':') then
        if fAccess = faWrite then
          FixUpParentReport;
        if not Filter.DoFilterProcessStream(FilterStream, Self) then
        try
          if fAccess = faRead then
            LoadFromStream(FilterStream)
          else
            SaveToStream(FilterStream);
        finally
          if fAccess = faRead then
            Result := Result and FStreamLoaded;
        end;
        Filter.FreeStream(FilterStream);
      end;
    end;
  finally
    Filter.CloseFilter;
    Filter.Report := nil;
  end;
end;

procedure TfrxReport.AddFunction(const FuncName: String;
  const Category: String = ''; const Description: String = '');
begin
  // need to assign function to parent script
  FScript.AddedBy := TObject(2);
  FScript.AddMethod(FuncName, DoUserFunction, Category, Description);
  FScript.AddedBy := nil;
end;

function TfrxReport.GetLocalValue: Variant;
begin
  Result := FLocalValue.Value;
end;

function TfrxReport.GetMainPreviewPages: TfrxCustomPreviewPages;
begin
  Result := FPreviewPagesList.GetMain;
end;

function TfrxReport.GetSelfValue: TfrxView;
begin
  Result := TfrxView(frInteger(FSelfValue.Value));
end;

procedure TfrxReport.SetLocalValue(const Value: Variant);
begin
  FLocalValue.Value := Value;
end;

procedure TfrxReport.SetMainPreviewPages(const Value: TfrxCustomPreviewPages);
begin
  FPreviewPagesList.Main := Value;
end;

procedure TfrxReport.SetSelfValue(const Value: TfrxView);
begin
  FSelfValue.Value := frInteger(Value);
end;

procedure TfrxReport.SetTerminated(const Value: Boolean);
begin
  FTerminated := Value;
  if Value then
    FScript.Terminate;
end;

procedure TfrxReport.SetPreview(const Value: TfrxCustomPreview);
begin
  if (FPreview <> nil) {and (Value = nil)} then
  begin
    FPreview.UnInit(Self);
    //FPreview.FReport := nil;
    //FPreview.FPreviewPages := nil;
    FPreviewForm := nil;
  end;

  FPreview := Value;

  if FPreview <> nil then
  begin
    FPreview.Init(Self, PreviewPages);
    //FPreview.FReport := Self;
    //FPreview.FPreviewPages := PreviewPages;
    FPreviewForm := FPreview.FPreviewForm;
  end;
end;

function TfrxReport.GetCaseSensitive: Boolean;
begin
{$IFDEF DELPHI6}
  Result := FExpressionCache.CaseSensitive;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TfrxReport.GetScriptText: TStrings;
begin
  if (csWriting in ComponentState) and not FStoreInDFM then
    Result := FFakeScriptText
   else Result := FScriptText;
end;

procedure TfrxReport.SetCaseSensitive(const Value: Boolean);
begin
{$IFDEF DELPHI6}
  FExpressionCache.CaseSensitive := Value;
{$ENDIF}
end;

procedure TfrxReport.InternalOnProgressStart(ProgressType: TfrxProgressType);
begin
  if Assigned(FOnProgressStart) then
    FOnProgressStart(Self, ProgressType, 0);

  if (FEngineOptions.EnableThreadSafe) then Exit; //(FEngineOptions.ReportThread <> nil) or

  if OldStyleProgress or (ProgressType <> ptRunning) then
  begin
    if FShowProgress then
    begin
      if FProgress <> nil then
        FProgress.Free;
      FProgress := TfrxProgress.Create(nil);
      FProgress.Execute(0, '', True, False);
    end;
  end;

  if (FPreview <> nil) and (ProgressType = ptRunning) then
    FPreview.InternalOnProgressStart(Self, ProgressType, 0);
  if not EngineOptions.EnableThreadSafe then
    Application.ProcessMessages;
end;

procedure TfrxReport.InternalOnProgress(ProgressType: TfrxProgressType;
  Progress: Integer);
begin
  if Assigned(FOnProgress) then
    FOnProgress(Self, ProgressType, Progress);

  if FEngineOptions.EnableThreadSafe then Exit;
//  if FEngineOptions.ReportThread <> nil then Exit;

  if OldStyleProgress or (ProgressType <> ptRunning) then
  begin
    if FShowProgress then
    begin
      case ProgressType of
        ptRunning:
          if not Engine.FinalPass then
            FProgress.Message := Format(frxResources.Get('prRunningFirst'), [Progress])
          else
            FProgress.Message := Format(frxResources.Get('prRunning'), [Progress]);
        ptPrinting:
          FProgress.Message := Format(frxResources.Get('prPrinting'), [Progress]);
        ptExporting:
          FProgress.Message := Format(frxResources.Get('prExporting'), [Progress]);
      end;
      if FProgress.Terminated then
        Terminated := True;
    end;
  end;

  if (FPreview <> nil) and (ProgressType = ptRunning) then
    FPreview.InternalOnProgress(Self, ProgressType, Progress - 1);
  if not EngineOptions.EnableThreadSafe then
    Application.ProcessMessages;
end;

procedure TfrxReport.InternalOnProgressStop(ProgressType: TfrxProgressType);
begin
  if Assigned(FOnProgressStop) then
    FOnProgressStop(Self, ProgressType, 0);

  if FEngineOptions.EnableThreadSafe then Exit;
//  if FEngineOptions.ReportThread <> nil then Exit;

  if OldStyleProgress or (ProgressType <> ptRunning) then
  begin
    if FShowProgress then
    begin
      FProgress.Free;
      FProgress := nil;
    end;
  end;

  if (FPreview <> nil) and (ProgressType = ptRunning) then
    FPreview.InternalOnProgressStop(Self, ProgressType, 0);
  if not EngineOptions.EnableThreadSafe then
    Application.ProcessMessages;
end;

function TfrxReport.IsReportActionRunning: Boolean;
begin
  Result := FEngine.Running or Assigned(Script.ProgRunning) or FPreparing;
end;

procedure TfrxReport.SetProgressMessage(const Value: String; IsHint: Boolean; bHandleMessage: Boolean);
begin
{$IFNDEF FR_COM}
  if FEngineOptions.EnableThreadSafe then Exit;
//  if FEngineOptions.ReportThread <> nil then Exit;
{$ENDIF}
  if OldStyleProgress and Engine.Running then
  begin
    if FShowProgress then
      FProgress.Message := Value
  end;

  if FPreviewForm <> nil then
    TfrxPreviewForm(FPreviewForm).SetMessageText(Value, IsHint);
  if not EngineOptions.EnableThreadSafe and bHandleMessage then
    Application.ProcessMessages;
end;

procedure TfrxReport.SetVersion(const Value: String);
begin
  FVersion := FR_VERSION;
end;

function TfrxReport.PreparePage(APage: TfrxPage): Boolean;
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
  v: TfsCustomVariable;
begin
//  PrepareScript();
  Report.Errors.Clear;
  FEngine.NotifyList.Clear;
  { it's nessesary to reset information of images for detail page }
  FPreparing := True;
  try
    l := AllObjects;
    for i := 0 to l.Count - 1 do
    begin
      c := TfrxComponent(l[i]);
      if TObject(l[i]) is TfrxPictureView then
        TfrxPictureView(l[i]).FPictureChanged := True;
      c.BeforeStartReport;
      if not FIsScriptObjectsAdded and not c.IsAncestor then
      begin
        v := FScript.Find(c.Name);
        if Assigned(v) then
          v.Value := frInteger(c)
        else
          FScript.AddObject(c.Name, c);
      end;
    end;
    if not FIsScriptObjectsAdded then
      UpdateGlobalScritVars;
    Result := FEngine.Run(False, False, APage);
  finally
    FPreparing := False;
  end;
  RunDelayedCommands;
end;

procedure TfrxReport.SetPreviewPages(const Value: TfrxCustomPreviewPages);
begin
  FPreviewPagesList.Current := Value;
end;

{$IFDEF FPC}
function TfrxReport.GetLazIniFile: string;
var
  bw,bl:Boolean;
begin
  bw := Pos('\', FIniFile) > 0;
  bl := Pos('/', FIniFile) > 0;
  if not bw and not bl then
    Result := FIniFile
  else
  {$IFDEF LCLGTK2}
    if bw then
      Result := 'tmp/fr6.ini'
    else
      Result := FIniFile;
  {$ELSE}
     if bl then
       Result := '\Software\Fast Reports'
     else
       Result := FIniFile;
  {$ENDIF}
end;
{$ENDIF}

procedure TfrxReport.DoMouseEnter(Sender: TfrxView; aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
var
  v: Variant;
begin
  Sender.MouseEnter(aPreviousObject, EventParams);
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Sender);
  if (Sender.OnMouseEnter <> '') then
  begin
    v := VarArrayOf([frInteger(Sender), EventParams.Refresh]);
    Report.DoParamEvent(Sender.OnMouseEnter, v, True);
    EventParams.Refresh := v[1];
  end;
end;

procedure TfrxReport.DoMouseLeave(Sender: TfrxView; X, Y: Integer; aNextObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
var
  v: Variant;
begin
  Sender.MouseLeave(X, Y, aNextObject, EventParams);
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Sender);
  if (Sender.OnMouseLeave <> '') then
  begin
    v := VarArrayOf([frInteger(Sender), EventParams.Refresh]);
    Report.DoParamEvent(Sender.OnMouseLeave, v, True);
    EventParams.Refresh := v[1];
  end;
end;

procedure TfrxReport.DoMouseUp(Sender: TfrxView; X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams);
var
  arr: Variant;
begin
  Sender.MouseUp(X, Y, Button, Shift, EventParams);
  if (Sender.OnMouseUp <> '') then
  begin
    arr := VarArrayOf([frInteger(Sender), X, Y, Button, ShiftToByte(Shift),
      Modified]);
    DoParamEvent(Sender.OnMouseUp, arr, True);
    EventParams.Refresh := arr[1];
  end;
end;


{ TfrxCustomDesigner }

procedure TfrxCustomDesigner.AddPictureToCache(PicView: TfrxPictureView);
begin

end;

function TfrxCustomDesigner.CheckOp(Op: TfrxDesignerRestriction): Boolean;
begin
  Result := True;
end;

constructor TfrxCustomDesigner.CreateDesigner(AOwner: TComponent;
  AReport: TfrxReport; APreviewDesigner: Boolean);
begin
  inherited Create(AOwner);
  FReport := AReport;
  FIsPreviewDesigner := APreviewDesigner;
  FObjects := TList.Create;
  FSelectedObjects := TfrxSelectedObjectsList.Create;
  FInspectorLock := False;
end;

destructor TfrxCustomDesigner.Destroy;
begin
  FObjects.Free;
  FSelectedObjects.Free;
  inherited;
end;

procedure TfrxCustomDesigner.DeleteObject(vComp: TfrxComponent);
begin
  FSelectedObjects.Remove(vComp);
  FObjects.Remove(vComp);
  FreeAndNil(vComp);
end;

function TfrxCustomDesigner.GetDefaultPreferences: TObject;
begin
  Result := nil;
end;

function TfrxCustomDesigner.GetPreferencesStorage(aDefault: Boolean): TObject;
begin
  if Assigned(FReport) then
    if aDefault then
      Result := GetDefaultPreferences
    else
      Result := FReport.GetIniFile
  else
    Result := inherited GetPreferencesStorage(aDefault);
end;

procedure TfrxCustomDesigner.SetModified(const Value: Boolean);
begin
  FModified := Value;
  if Value then
    FReport.Modified := True;
end;

procedure TfrxCustomDesigner.SetPage(const Value: TfrxPage);
begin
  FPage := Value;
end;


{ TfrxCustomEngine }

procedure TfrxCustomEngine.BreakAllKeep;
begin
// do nothing
end;

constructor TfrxCustomEngine.Create(AReport: TfrxReport);
begin
  FReport := AReport;
  FNotifyList := TList.Create;
end;

destructor TfrxCustomEngine.Destroy;
begin
  FNotifyList.Free;
  inherited;
end;

function TfrxCustomEngine.GetDoublePass: Boolean;
begin
  Result := FReport.EngineOptions.DoublePass;
end;

procedure TfrxCustomEngine.SetPreviewPages(const Value: TfrxCustomPreviewPages);
begin
  FPreviewPages := Value;
  if Assigned(FPreviewPages) then
    FPreviewPages.FEngine := Self;
end;

procedure TfrxCustomEngine.ShowBandByName(const BandName: String);
begin
  ShowBand(TfrxBand(Report.FindObject(BandName)));
end;

procedure TfrxCustomEngine.StopReport;
begin
  Report.Terminated := True;
end;

function TfrxCustomEngine.GetPageHeight: Extended;
begin
  Result := FPageHeight;
end;

{ TfrxCustomOutline }

constructor TfrxCustomOutline.Create(APreviewPages: TfrxCustomPreviewPages);
begin
  FPreviewPages := APreviewPages;
end;

function TfrxCustomOutline.Engine: TfrxCustomEngine;
begin
  Result := FPreviewPages.Engine;
end;

{ TfrxCustomPreviewPages }

procedure TfrxCustomPreviewPages.ClearStyles;
begin
  if Assigned(FStyles) then
    FStyles.ClearAll;
end;

constructor TfrxCustomPreviewPages.Create(AReport: TfrxReport);
begin
  FReport := AReport;
  FOutline := TfrxOutline.Create(Self);
  FPostProcessor := TfrxPostProcessor.Create;
  FPictureCacheOptions := nil;
end;

destructor TfrxCustomPreviewPages.Destroy;
begin
  FOutline.Free;
  FreeAndNil(FPictureCacheOptions);
  FreeAndNil(FPostProcessor);
  FreeAndNil(FStyles);
  inherited;
end;

function TfrxCustomPreviewPages.FindStyle(
  const AStyleName: string): TfrxStyleItem;
begin
  Result := nil;
  if Assigned(FStyles) then
    Result := FStyles.Find(AStyleName);
end;

procedure TfrxCustomPreviewPages.Finish;
begin
  if fsbPreview in  Report.Styles.StyleBookMode then
    Styles := Report.Styles;
end;

procedure TfrxCustomPreviewPages.FireMouseLeave;
begin
//
end;

function TfrxCustomPreviewPages.GetPictureCacheOptions: TfrxPictureCacheOptions;
begin
  { stub }
  if not Assigned(FPictureCacheOptions) then
    FPictureCacheOptions := TfrxPictureCacheOptions.Create;
  Result := FPictureCacheOptions;
end;

function TfrxCustomPreviewPages.GetStyles: TfrxStyles;
begin
  if FStyles = nil then
    FStyles := TfrxStyles.Create(Report);
  Result := FStyles;
end;

function TfrxCustomPreviewPages.IsStylesActive: Boolean;
begin
  Result := Assigned(FStyles) and (FStyles.Count > 0);
end;

procedure TfrxCustomPreviewPages.SetActiveStyleSheet(const AName: String);
begin
  if Styles.ActiveStyleSheet <> AName then
  begin
    Styles.ActiveStyleSheet := AName;
    ClearPageCache;
  end;
end;

procedure TfrxCustomPreviewPages.SetStyles(const Value: TfrxStyles);
begin
  Styles.AssignAsPreview(Value);
end;

{ TfrxExpressionCache }

constructor TfrxExpressionCache.Create(AScript: TfsScript);
begin
  FExpressions := TStringList.Create;
  FExpressions.Sorted := True;
  FScript := TfsScript.Create(nil);
  FScript.ExtendedCharset := True;
  FMainScript := AScript;
{$IFDEF DELPHI6}
  FExpressions.CaseSensitive := True;
{$ENDIF}
end;

destructor TfrxExpressionCache.Destroy;
begin
  FExpressions.Free;
  FScript.Free;
  inherited;
end;

procedure TfrxExpressionCache.Clear;
begin
  FExpressions.Clear;
  FScript.Clear;
end;

function TfrxExpressionCache.Calc(const Expression: String;
  var ErrorMsg: String; AScript: TfsScript): Variant;
var
  i: Integer;
  v: TfsProcVariable;
  Compiled, IsProcCall: Boolean;
begin
  ErrorMsg := '';
  FScript.Parent := AScript;
  IsProcCall := Assigned(FMainScript.ProgRunning) and (FMainScript.ProgName <> '');
  if IsProcCall then
    i := FExpressions.IndexOf(FMainScript.ProgName + '.' + Expression)
  else
    i := FExpressions.IndexOf(Expression);
  if i = -1 then
  begin
    i := FExpressions.Count;
    FScript.SyntaxType := FScriptLanguage;
    if CompareText(FScriptLanguage, 'PascalScript') = 0 then
      FScript.Lines.Text := 'function fr3f' + IntToStr(i) + ': Variant; begin ' +
        'Result := ' + Expression + ' end; begin end.'
    else if CompareText(FScriptLanguage, 'C++Script') = 0 then
      FScript.Lines.Text := 'Variant fr3f' + IntToStr(i) + '() { ' +
        'return ' + Expression + '; } {}'
    else if CompareText(FScriptLanguage, 'BasicScript') = 0 then
      FScript.Lines.Text := 'function fr3f' + IntToStr(i) + #13#10 +
        'return ' + Expression + #13#10 + 'end function'
    else if CompareText(FScriptLanguage, 'JScript') = 0 then
      FScript.Lines.Text := 'function fr3f' + IntToStr(i) + '() { ' +
        'return ' + Expression + '; }';

    Compiled := FScript.Compile;
    v := TfsProcVariable(FScript.Find('fr3f' + IntToStr(i)));

    if not Compiled then
    begin
      if v <> nil then
      begin
        v.Free;
        FScript.Remove(v);
      end;
      ErrorMsg := frxResources.Get('clExprError') + ' ''' + Expression + ''': ' +
        FScript.ErrorMsg;
      Result := Null;
      Exit;
    end;
    if IsProcCall then
      FExpressions.AddObject(FMainScript.ProgName + '.' + Expression, v)
    else
      FExpressions.AddObject(Expression, v);
  end
  else
    v := TfsProcVariable(FExpressions.Objects[i]);
  // in case of problem with expressions calculation , check issue #4135
//  FMainScript.MainProg := False;
  FScript.MainProg := True;
  try
    try
      Result := v.Value;
    except
      on e: Exception do
        ErrorMsg := e.Message;
    end;
  finally
//    FMainScript.MainProg := True;
    FScript.MainProg := False;
  end;
end;

function TfrxExpressionCache.GetCaseSensitive: Boolean;
begin
{$IFDEF DELPHI6}
  Result := FExpressions.CaseSensitive;
{$ELSE}
  Result := False;
{$ENDIF}
end;

procedure TfrxExpressionCache.SetCaseSensitive(const Value: Boolean);
begin
{$IFDEF DELPHI6}
  FExpressions.CaseSensitive := Value;
{$ENDIF}
end;

{ TfrxCustomIOTransport }

function TfrxCustomIOTransport.AddContainer(Item: TfrxNode): Boolean;
begin
  Result := True;
end;

function TfrxCustomIOTransport.AllInOneContainer: Boolean;
begin
  Result := False;
end;

procedure TfrxCustomIOTransport.AssignFilter(Source: TfrxCustomIOTransport);
begin
  FReport := Source.Report;
  FShowDialog := Source.ShowDialog;
  FOverwritePrompt := Source.OverwritePrompt;
  FDefaultPath := Source.DefaultPath;
  FFileName := Source.FileName;
  FDefaultExt := Source.DefaultExt;
  FExtDescription := Source.ExtDescription;
end;

procedure TfrxCustomIOTransport.AssignOriginalSharedProperties;
begin
  AssignSharedProperties(FOriginalCopy);
end;

procedure TfrxCustomIOTransport.AssignSharedProperties(
  Source: TfrxCustomIOTransport);
begin
//
end;

procedure TfrxCustomIOTransport.CloseFilter;
begin
  if Assigned(FInternalFilter) then
  begin
    InternalFilter.FreeTempContainer;
    FreeAndNil(FInternalFilter);
  end;
  if Assigned(FTempFilter) then
  begin
    FTempFilter.FreeTempContainer;
    FreeAndNil(FTempFilter);
  end;
  FDirTree.Clear;
end;

procedure TfrxCustomIOTransport.CopyStreamsNames(aStrings: TStrings; OpenedOnly: Boolean);
  procedure AddItem(aNode: TfrxNode);
  var
    i: integer;
  begin
    for I := 0 to aNode.Count - 1 do
    begin
      if aNode.Items[i].FOriginalName <> '' then
        aStrings.AddObject(aNode.Items[i].FOriginalName, aNode.Items[i].FObjectData);
      AddItem(aNode.Items[i]);
    end;
  end;
begin
  AddItem(FDirTree);
end;

procedure TfrxCustomIOTransport.CloseAllStreams;
  procedure FreeData(aNode: TfrxNode);
  var
    i: integer;
  begin
    for I := 0 to aNode.Count - 1 do
    begin
      if Assigned(aNode.Items[i].FObjectData) then
        FreeAndNil(aNode.Items[i].FObjectData);
      FreeData(aNode.Items[i]);
    end;
  end;
begin
  if FFreeStream then
    FreeData(FDirTree);
end;

constructor TfrxCustomIOTransport.Create(AOwner: TComponent);
begin
  Inherited;
  FFreeStream := True;
  FClosedLoadLock := False;
  FCreatedFrom := fvOther;
  Visibility := [fvDesigner, fvPreview, fvExport];
  FSupportedStreams := [tsIORead, tsIOWrite];
  if not FNoRegister then
    frxIOTransports.Register(Self);
  FTempFilter := nil;
  FFilterAccess := faRead;
  FDirTree := TfrxNode.Create;
  FDirTree.Name := '';
  FCurNode := FDirTree;
  FInternalFilter := nil;
end;

procedure TfrxCustomIOTransport.CreateContainer(const cName: String; bSetCurrent: Boolean);
var
  cItem, CurNode: TfrxNode;
  sName, fPath: String;
  i: Integer;
begin
  sName := '';
  if cName <> '' then
  begin
//  if sName[Length(sName)] = PathDelim then
//    Delete(sName, Length(sName), 1);
    for i := Length(cName) downto 1 do
      if cName[i] = PathDelim then
      begin
        sName := Copy(cName, i + 1, Length(cName));
        break;
      end;

  if sName = '' then
    sName := cName
  else
  begin
  fPath := cName;
  Delete(fPath, Length(fPath) - Length(sName), Length(sName) + 1);
  end;
//  if sName[1] = PathDelim then
//    Delete(sName, 1, 1);
  end;
  CurNode := GetNodeFromPath(fPath, False);
  if CurNode = nil then Exit;

  if cName = '' then
    cItem := FDirTree
  else
    cItem := CurNode.Add(sName);
  if not AddContainer(cItem) then
    if cItem <> FDirTree then
      cItem.Free
    else if bSetCurrent then
      CurrentContainer := cItem.Name;
end;

function TfrxCustomIOTransport.CreateFilterClone(CreatedFrom: TfrxFilterVisibleState): TfrxCustomIOTransport;
begin
  Result := TfrxCustomIOTransport(NewInstance);
  Result.CreateNoRegister;
  Result.FCreatedFrom := CreatedFrom;
  Result.AssignFilter(Self);
  Result.FOriginalCopy := Self;
  Result.AssignSharedProperties(Self);
end;

constructor TfrxCustomIOTransport.CreateNoRegister;
begin
  FNoRegister := True;
  Create(nil)
end;

procedure TfrxCustomIOTransport.CreateTempContainer;
begin

end;

procedure TfrxCustomIOTransport.DeleteContainer(const cName: String);
var
  cItem: TfrxNode;
begin
  cItem := FCurNode.Find(cName);
  if (cItem <> nil) and (RemoveContainer(cItem)) then
    cItem.Free;
end;

destructor TfrxCustomIOTransport.Destroy;
begin
  if not FNoRegister then
    frxIOTransports.Unregister(Self);
  CloseAllStreams;
  FreeAndNil(FDirTree);
  inherited;
end;

function TfrxCustomIOTransport.DoCreateStream(var aFullFilePath: String; aFileName: String): TStream;
begin
  Result := nil;
end;

function TfrxCustomIOTransport.DoFilterProcessStream(aStream: TStream; ProcesssingObject: TObject): Boolean;
begin
  Result := False;
end;

procedure TfrxCustomIOTransport.FreeStream(aStream: TStream; const aFileName: String);
var
  aNode: TfrxNode;
begin
  aNode := FDirTree.Find(aStream, True);
  if Assigned(aNode) and Assigned(aNode.FObjectData) then
  begin
    aNode.ObjectData.Free;
    aNode.ObjectData := nil;
    if Assigned(FInternalFilter) then
    begin
      aNode := FInternalFilter.FDirTree.Find(aStream, True);
      if Assigned(aNode) then
        aNode.ObjectData := nil;
    end;
  end;
end;

procedure TfrxCustomIOTransport.FreeTempContainer;
begin

end;

function TfrxCustomIOTransport.GetVisibility: TfrxFilterVisibility;
begin
  Result := FVisibility;
end;

procedure TfrxCustomIOTransport.InitFromExport(
  ExportFilter: TfrxCustomExportFilter);
begin
  DefaultPath := ExportFilter.DefaultPath;
  DefaultExt := ExportFilter.DefaultExt;
  FileName := ExportFilter.FileName;
  Report := ExportFilter.Report;
  FilterString := ExportFilter.FilterDesc;
  FOverwritePrompt := ExportFilter.OverwritePrompt;
  FBasePath := ExtractFilePath(ExportFilter.FileName);
  if (DefaultPath <> '') and (FBasePath = '') then
     FBasePath := DefaultPath;
  FFilterAccess := faWrite;
end;

procedure TfrxCustomIOTransport.LoadClosedStreams;
  procedure LoadData(aNode: TfrxNode);
  var
    i: integer;
    lNode: TfrxNode;
  begin
    for I := 0 to aNode.Count - 1 do
    begin
      lNode := aNode.Items[i];
      if (lNode.FOriginalName <> '') and not Assigned(lNode.FObjectData) then
      lNode.FObjectData := DoCreateStream(lNode.FOriginalName, lNode.Name);
      LoadData(lNode);
    end;
  end;

begin
  LoadData(FDirTree);
end;

procedure TfrxCustomIOTransport.LoadStreamsList(aStrings: TStrings);
var
  i: Integer;
begin
  for i := 0 to aStrings.Count - 1 do
    aStrings.Objects[i] := GetStream(aStrings[i]);
end;

function TfrxCustomIOTransport.GetCurrentContainer: String;
begin
  Result := FCurNode.Name;
end;

class function TfrxCustomIOTransport.GetDescription: String;
begin
  Result := '';
end;

function TfrxCustomIOTransport.GetFileNode: TfrxNode;
var
  bFound: Boolean;

  function DoGetFile(aItem: TfrxNode): TfrxNode;
  var
    lItem: tfrxNode;
    i: Integer;
  begin
    Result := nil;
    for i := 0 to aItem.Count - 1 do
    begin
      lItem := aItem.Items[i];
      if lItem.OriginalName <> '' then
      begin
        bFound := True;
        Result := lItem;
      end
      else
        Result := DoGetFile(lItem);
      if bFound then Exit;
    end;
  end;
begin
  Result := nil;
  if FDirTree.FilesCount = 0 then Exit;
  bFound := False;
  if Assigned(FInternalFilter) then
    Result := FInternalFilter.GetFileNode
  else
    Result := DoGetFile(FDirTree)
end;

function TfrxCustomIOTransport.GetFilterString: String;
begin
  Result := FFilterString;
end;

function TfrxCustomIOTransport.GetInternalFilter: TfrxCustomIOTransport;
begin
  Result := FInternalFilter;
  if Assigned(FInternalFilter) then Exit;
  FInternalFilter := TfrxCustomIOTransport(frxDefaultTempFilterClass.NewInstance);
  FInternalFilter.CreateNoRegister;
  FInternalFilter.FilterAccess := FilterAccess;
  Result := FInternalFilter;
end;

function TfrxCustomIOTransport.GetNodeFromPath(aPath: String; bCreateNodes: Boolean; bLastNodeAsFile: Boolean): TfrxNode;
var
  i, NodeNameStart, NameEnd: Integer;
  CurNode, NextNode: TfrxNode;
  NodeName: String;
begin
  Result := nil;
  if aPath = '' then
  begin
    Result := FDirTree;
    Exit;
  end;

  i := PosEx(FBasePath, aPath, 1);
  if i <> 0 then
    aPath := Copy(aPath, Length(FBasePath) + 1, Length(aPath));
  if Assigned(FInternalFilter) then
    FInternalFilter.GetNodeFromPath(aPath, bCreateNodes, bLastNodeAsFile);

  if aPath[1] <> PathDelim then
    aPath := PathDelim + aPath;
  if (aPath[Length(aPath)] <> PathDelim) and not bLastNodeAsFile then
    aPath := aPath + PathDelim;
  CurNode := FDirTree;
  NodeNameStart := 2;
  for i := 2 to Length(aPath) do
  begin
    if (aPath[i] = PathDelim) or (Length(aPath) = i) then
    begin
      NameEnd := i - NodeNameStart;
      if (Length(aPath) = i) then Inc(NameEnd);
      NodeName := Copy(aPath, NodeNameStart, NameEnd);
      NodeNameStart := i + 1;
      NextNode := CurNode.Find(NodeName);
      if NextNode = nil then
        if not bCreateNodes then
         Exit
        else
        begin
          NextNode := CurNode.Add(NodeName);
          if (Length(aPath) <> i) or not bLastNodeAsFile then
            AddContainer(NextNode);
        end;
      CurNode := NextNode;
    end;
  end;
  Result := CurNode;
end;

function TfrxCustomIOTransport.GetStream(aFileName: String): TStream;
var
  aNode: TfrxNode;
  fName: String;
begin

  fName := ExtractFileName(aFileName);
  if (aFileName = '') {and (FilterAccess = faRead)} then
    aFileName := FileName;
  aNode := GetNodeFromPath(aFileName, True, True);
  if (aNode = nil) then
    raise Exception.CreateFmt('Unable to parse path : "%s" to Nodes', [aFileName]);
  if (aNode.FObjectData is TStream) and ((aNode.FilterAccess = FFilterAccess) or not FFreeStream) then
    Result := TStream(aNode.FObjectData)
  else
  begin
    if (aNode.FObjectData is TStream) then
      FreeAndNil(aNode.FObjectData);
    Result := DoCreateStream(aFileName, fName);
    if aNode = FDirTree then
      aNode := aNode.Add(aFileName);
    aNode.OriginalName := aFileName;
    aNode.ObjectData := Result;
    aNode.FilterAccess := FFilterAccess;
  end;
end;

function TfrxCustomIOTransport.GetTempFilter: TfrxCustomIOTransport;
begin
  Result := FTempFilter;
  if Assigned(FTempFilter) then Exit;
  FTempFilter := TfrxCustomIOTransport(frxDefaultTempFilterClass.NewInstance);
  FTempFilter.CreateNoRegister;
  FTempFilter.FilterAccess := FilterAccess;
  FTempFilter.CreateTempContainer;
  Result := FTempFilter;
end;

function TfrxCustomIOTransport.OpenFilter: Boolean;
begin
  Result := True;
end;

function TfrxCustomIOTransport.RemoveContainer(Item: TfrxNode): Boolean;
begin
  Result := True;
end;

procedure TfrxCustomIOTransport.SetCurrentContainer(const Value: String);
var
  cItem, CurNode: TfrxNode;
  i, LastDelim: Integer;
  NodeName: String;
begin
  if Length(Value) = 0 then
  begin
    FCurNode := FDirTree;
    Exit;
  end;
  CurNode := FCurNode;
  NodeName := '';
  LastDelim := 1;
  for i := 1 to Length(Value) do
  begin
    if (Value[i] = PathDelim) or (Length(Value) = i) then
    begin
      NodeName := Copy(Value, LastDelim, i - LastDelim);
      if NodeName = '' then CurNode := FDirTree
      else CurNode := CurNode.Find(NodeName);
      if CurNode = nil then Exit;
    end;
  end;
  cItem := FCurNode.Find(Value);
  if cItem <> nil then
    FCurNode := cItem;
end;

procedure TfrxCustomIOTransport.SetInternalFilter(
  const Value: TfrxCustomIOTransport);
begin
  if Assigned(FInternalFilter) then
    FreeAndNil(FInternalFilter);
  FInternalFilter := Value;
end;

procedure TfrxCustomIOTransport.SetTempFilter(const Value: TfrxCustomIOTransport);
begin
  if Value = nil then Exit;
  if Assigned(FTempFilter) then
  begin
    FTempFilter.FreeTempContainer;
    FreeAndNil(FTempFilter);
  end;
  FTempFilter := Value;
end;

procedure TfrxCustomIOTransport.SetVisibility(const Value: TfrxFilterVisibility);
begin
  FVisibility := Value;
end;

{ TfrxIOTransportFile }

function TfrxIOTransportFile.AddContainer(Item: TfrxNode): Boolean;
var
  aPath: String;
begin
  Result := True;
  aPath := '';
  while Item <> nil do
  begin
    if Item.Name <> '' then
      aPath := Item.Name + PathDelim + aPath;
    Item := Item.Parent;
  end;
  if (Length(FBasePath) > 0) and (FBasePath[Length(FBasePath)] <> PathDelim) then
    aPath := PathDelim + aPath;
  if (FilterAccess = faWrite) and not DirectoryExists(FBasePath + aPath) then
    MkDir(FBasePath + aPath);
end;

procedure TfrxIOTransportFile.CloseFilter;
begin
  inherited;
end;

constructor TfrxIOTransportFile.Create(AOwner: TComponent);
begin
  inherited;
  FTempFolderCreated := False;
end;

procedure TfrxIOTransportFile.CreateTempContainer;
begin
  if FTempFolderCreated then Exit;
  FBasePath := frGetTempFile;
  SysUtils.DeleteFile(FBasePath);
  CreateContainer('');
  FTempFolderCreated := True;
end;

procedure TfrxIOTransportFile.DeleteFiles;

  procedure fDelete(aNode: TfrxNode);
  var
    i: integer;
    lNode: TfrxNode;
  begin
    for I := 0 to aNode.Count - 1 do
    begin
      lNode := aNode.Items[i];
      if (lNode.FOriginalName <> '') then
        SysUtils.DeleteFile(lNode.FOriginalName)
      else
        fDelete(lNode);
    end;
  end;
begin
  fDelete(FDirTree);
end;

function TfrxIOTransportFile.DoCreateStream(var aFullFilePath: String; aFileName: String): TStream;
begin
  if FFilterAccess = faWrite then
    Result := TFileStream.Create(aFullFilePath, fmCreate)
  else
    Result := TFileStream.Create(aFullFilePath, fmOpenRead or fmShareDenyWrite);
end;

procedure TfrxIOTransportFile.FreeTempContainer;
begin
  if not FTempFolderCreated then Exit;
  CloseAllStreams;
  DeleteFiles;
  DeleteFolder(FBasePath);
  FTempFolderCreated := False;
end;

class function TfrxIOTransportFile.GetDescription: String;
begin
  Result := frxGet(163);
end;

function TfrxIOTransportFile.OpenFilter: Boolean;
begin
  Result := True;
end;

procedure TfrxIOTransportFile.SetVisibility(const Value: TfrxFilterVisibility);
begin
//  inherited;
  FVisibility := [];
end;

{ TfrxCustomExportFilter }

procedure TfrxCustomExportFilter.AfterFinish;
begin
//
end;

procedure TfrxCustomExportFilter.BeforeStart;
begin
  if SlaveExport and (FileName = '') then
  begin
    if Report.FileName <> '' then
      FileName := ChangeFileExt(frGetTemporaryFolder + ExtractFileName(Report.FileName), DefaultExt)
    else
      FileName := ChangeFileExt(frGetTempFile, DefaultExt);
    IOTransport.BasePath := ExtractFilePath(FileName);
  end;
  if (FileName <> '') and (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
  begin
    if DefaultPath[Length(DefaultPath)] = PathDelim then
      FileName := DefaultPath + FileName
    else
      FileName := DefaultPath + PathDelim + FileName;
  end;
end;

procedure TfrxCustomExportFilter.BeginClip(Obj: TfrxView);
begin

end;

procedure TfrxCustomExportFilter.ClearResources;
begin
//
end;

constructor TfrxCustomExportFilter.Create(AOwner: TComponent);
begin
  inherited;
  if not FNoRegister then
    frxExportFilters.Register(Self);
  ShowDialog := True;
  FUseFileCache := True;
  FDefaultPath := '';
  FShowProgress := True;
  FSlaveExport := False;
  FOverwritePrompt := False;
  FFiles := nil;
  FDefaultIOTransport := nil;
  FTerminated := False;
  FCalculatePictureHash := True;
end;

function TfrxCustomExportFilter.CreateDefaultIOTransport: TfrxCustomIOTransport;
begin
  if (doShowSaveDialog in FShowDialogOptions) and Assigned(frxDefaultIODialogTransportClass) and not (SlaveExport or Assigned(Stream)) then
    FDefaultIOTransport := TfrxCustomIOTransport(frxDefaultIODialogTransportClass.NewInstance)
  else
    FDefaultIOTransport := TfrxCustomIOTransport(frxDefaultIOTransportClass.NewInstance);
  FDefaultIOTransport.CreateNoRegister;
  Result := FDefaultIOTransport;
end;

constructor TfrxCustomExportFilter.CreateNoRegister;
begin
  FNoRegister := True;
  Create(nil);
end;

destructor TfrxCustomExportFilter.Destroy;
begin
  if not FNoRegister then
    frxExportFilters.Unregister(Self);
  if FFiles <> nil then
    FFiles.Free;
  if FDefaultIOTransport <> nil then
    FreeAndNil(FDefaultIOTransport);
  inherited;
end;

procedure TfrxCustomExportFilter.DoFinish;
begin
  FreeAndNil(FfrxPictureHashMap);
  Finish;
  AfterFinish;
end;

function TfrxCustomExportFilter.DoStart: Boolean;
begin
  if EnableCalculateHash then
    FfrxPictureHashMap := TfrxPictureHashMap.Create(FCalculatePictureHash);
  BeforeStart;
  Result := Start;
end;

procedure TfrxCustomExportFilter.EndClip;
begin

end;

function TfrxCustomExportFilter.GetDefaultIOTransport: TfrxCustomIOTransport;
begin
  if FDefaultIOTransport = nil then
    FDefaultIOTransport := CreateDefaultIOTransport;
  Result := FDefaultIOTransport;
end;

class function TfrxCustomExportFilter.GetDescription: String;
begin
  Result := '';
end;

function TfrxCustomExportFilter.IsProcessInternal: Boolean;
begin
  Result := True;
end;

procedure TfrxCustomExportFilter.Finish;
begin
//
end;

procedure TfrxCustomExportFilter.FinishPage(Page: TfrxReportPage;
  Index: Integer);
begin
//
end;

procedure TfrxCustomExportFilter.SetDefaultIOTransport(
  const Value: TfrxCustomIOTransport);
begin
  if FDefaultIOTransport <> nil then
    FDefaultIOTransport.Free;
  FDefaultIOTransport := Value;
end;

procedure TfrxCustomExportFilter.SetFileName(const Value: String);
begin
  FName := Value;
  if Assigned(FIOTransport) then
  begin
    FIOTransport.BasePath := ExtractFilePath(FName);
    FIOTransport.FileName := FName;
  end;
end;

procedure TfrxCustomExportFilter.SetShowDialog(b: Boolean);
begin
  if (b) then
    FShowDialogOptions := [doShowExportSettings, doShowSaveDialog]
  else
    FShowDialogOptions := [];
end;

function TfrxCustomExportFilter.GetShowDialog: Boolean;
begin
  Result := (FShowDialogOptions = [doShowExportSettings, doShowSaveDialog]);
end;

function TfrxCustomExportFilter.ShowModal: TModalResult;
begin
  Result := mrOk;
end;

function TfrxCustomExportFilter.Start: Boolean;
begin
  Result := True;
end;

function TfrxCustomExportFilter.EnableCalculateHash: Boolean;
begin
  Result := False;
end;

procedure TfrxCustomExportFilter.StartPage(Page: TfrxReportPage;
  Index: Integer);
begin
//
end;


{ TfrxCustomWizard }

constructor TfrxCustomWizard.Create(AOwner: TComponent);
begin
  inherited;
  FDesigner := TfrxCustomDesigner(AOwner);
  FReport := FDesigner.Report;
end;

class function TfrxCustomWizard.GetDescription: String;
begin
  Result := '';
end;


{ TfrxCustomCompressor }

constructor TfrxCustomCompressor.Create(AOwner: TComponent);
begin
  inherited;
  FOldCompressor := frxCompressorClass;
  frxCompressorClass := TfrxCompressorClass(ClassType);
  if Assigned(AOwner) then
    FFilter := TfrxSaveToCompressedFilter.Create(nil)
  else
    FFilter := TfrxSaveToCompressedFilter.CreateNoRegister;
end;

destructor TfrxCustomCompressor.Destroy;
begin
  if Assigned(FFilter) then
    FreeAndNil(FFilter);
  frxCompressorClass := FOldCompressor;
  if FStream <> nil then
    FStream.Free;
  if FTempFile <> '' then
    SysUtils.DeleteFile(FTempFile);
  inherited;
end;

procedure TfrxCustomCompressor.SetIsFR3File(const Value: Boolean);
begin
  FIsFR3File := Value;
  FFilter.IsFR3File := FIsFR3File;
end;

procedure TfrxCustomCompressor.CreateStream;
begin
  if FIsFR3File or not FReport.EngineOptions.UseFileCache then
    FStream := TMemoryStream.Create
  else
  begin
    FTempFile := frxCreateTempFile(FReport.EngineOptions.TempDir);
    FStream := TFileStream.Create(FTempFile, fmCreate);
  end;
end;

{ TfrxCustomCrypter }

constructor TfrxCustomCrypter.Create(AOwner: TComponent);
begin
  inherited;
  frxCrypterClass := TfrxCrypterClass(ClassType);
end;

destructor TfrxCustomCrypter.Destroy;
begin
  if FStream <> nil then
    FStream.Free;
  inherited;
end;

procedure TfrxCustomCrypter.CreateStream;
begin
  FStream := TMemoryStream.Create;
end;


{ TfrxGlobalDataSetList }

constructor TfrxGlobalDataSetList.Create;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  FCriticalSection := TCriticalSection.Create;
{$ENDIF}
  inherited;
end;

destructor TfrxGlobalDataSetList.Destroy;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  FCriticalSection.Free;
  FCriticalSection := nil;
{$ENDIF}
  inherited;
end;

procedure TfrxGlobalDataSetList.Lock;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  if FCriticalSection <> nil then
    FCriticalSection.Enter;
{$ENDIF}
end;

procedure TfrxGlobalDataSetList.Unlock;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  if FCriticalSection <> nil then
    FCriticalSection.Leave;
{$ENDIF}
end;



{$IFDEF FPC}
//procedure RegisterUnitfrxClass;
//begin
//  RegisterComponents('Fast Report 6',[TfrxReport, TfrxUserDataSet]);
//end;

//procedure Register;
//begin
//  RegisterUnit('frxClass',@RegisterUnitfrxClass);
//end;
{$ENDIF}


{ TfrxInPlaceEditor }

procedure TfrxInPlaceEditor.CopyContent(CopyFrom: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; CopyAs: TfrxCopyPasteType);
begin

end;

constructor TfrxInPlaceEditor.Create(aClassRef: TfrxComponentClass; aOwner: TWinControl);
begin
  FOwner := aOwner;
  FClassRef := aClassRef;
  FOffsetX := 0;
  FOffsetY := 0;
  FScale := 0;
  FComponent := nil;
  FLocked := False;
  FComponents := nil;
  FClipboardObject := nil;
  FDevicePPI := Screen.PixelsPerInch;
end;

destructor TfrxInPlaceEditor.Destroy;
begin
  if Assigned(FComponent) then
    Component := nil;
  inherited;
end;

procedure TfrxInPlaceEditor.CopyGoupContent(CopyFrom: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; CopyAs: TfrxCopyPasteType);
begin
  CopyContent(CopyFrom, EventParams, nil, CopyAs);
end;

function TfrxInPlaceEditor.DoCustomDragDrop(Source: TObject; X,
  Y: Integer; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

function TfrxInPlaceEditor.DoCustomDragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

procedure TfrxInPlaceEditor.DoFinishInPlace(Sender: TObject; Refresh, Modified: Boolean);
begin
  if Assigned(OnFinishInPlace) then
  begin
    OnFinishInPlace(Component, Refresh, Modified);
    OnFinishInPlace := nil;
  end;
end;

function TfrxInPlaceEditor.DoMouseDown(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

function TfrxInPlaceEditor.DoMouseMove(X, Y: Integer;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

function TfrxInPlaceEditor.DoMouseUp(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

function TfrxInPlaceEditor.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
end;

procedure TfrxInPlaceEditor.PasteGoupContent(PasteTo: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; PasteAs: TfrxCopyPasteType);
begin
 PasteContent(PasteTo, EventParams, Buffer, PasteAs);
end;

procedure TfrxInPlaceEditor.DrawCustomEditor(aCanvas: TCanvas; aRect: TRect);
begin
// empty
end;

procedure TfrxInPlaceEditor.EditInPlace(aParent: TComponent; aRect: TRect);
begin
// empty
end;

function TfrxInPlaceEditor.EditInPlaceDone: Boolean;
begin
// empty
  Result := False;
end;

function TfrxInPlaceEditor.FillData: Boolean;
begin
// empty
  Result := False;
end;

procedure TfrxInPlaceEditor.FinalizeUI(var EventParams: TfrxInteractiveEventsParams);
begin

end;

function TfrxInPlaceEditor.GetActiveRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
end;

function TfrxInPlaceEditor.HasCustomEditor: Boolean;
begin
// empty
  Result := False;
end;

function TfrxInPlaceEditor.HasInPlaceEditor: Boolean;
begin
// empty
  Result := False;
end;

procedure TfrxInPlaceEditor.InitializeUI(var EventParams: TfrxInteractiveEventsParams);
begin
  FDevicePPI := EventParams.DevicePPI;
end;

function TfrxInPlaceEditor.IsPasteAvailable(PasteTo: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; PasteAs: TfrxCopyPasteType): Boolean;
begin
  Result := False;
end;

function TfrxInPlaceEditor.DefaultContentType: TfrxCopyPasteType;
begin
  Result := cptDefault;
end;

procedure TfrxInPlaceEditor.PasteContent(PasteTo: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; PasteAs: TfrxCopyPasteType);
begin

end;

procedure TfrxInPlaceEditor.SetComponent(const Value: TfrxComponent);
begin
  if (Value = FComponent)then Exit;
  if ((Value <> nil) and FLocked) then
  begin
    Value.FComponentEditors := nil;
    Exit;
  end;
  if Assigned(FComponent) then
  begin
    EditInPlaceDone;
    FComponent.FComponentEditors := nil;
  end;
  FComponent := Value;
  if Value <> nil then
    Value.FComponentEditors := frxGetInPlaceEditor(FEditors, Value);
end;

procedure TfrxInPlaceEditor.SetOffset(aOffsetX, aOffsetY, aScale: Extended);
begin
  FOffsetX := aOffsetX;
  FOffsetY := aOffsetY;
  FScale := aScale;
end;

function frxRegEditorsClasses: TfrxComponentEditorsClasses;
begin
  if RegEditorsClasses = nil then
    RegEditorsClasses := TfrxComponentEditorsClasses.Create;
  Result := RegEditorsClasses;
end;

procedure frxUnregisterEditorsClass(ComponentClass: TfrxComponentClass; EditroClass: TfrxInPlaceEditorClass);
begin
  if RegEditorsClasses = nil then Exit;
  RegEditorsClasses.UnRegister(ComponentClass, EditroClass);
end;


function frxGetInPlaceEditor(aList: TfrxComponentEditorsList; aComponent: TfrxComponent): TfrxComponentEditorsManager;
var
  i: Integer;
begin
  Result := nil;
  i := aList.IndexOf(aComponent.ClassName);
  if (i <> -1) and (aList.Editors[i].FEditorsGlasses.Count > 0) then
    Result := aList.Editors[i];
end;


procedure rePadding(MForm: TComponent);
{$IFDEF FPC}
var
  i: Integer;
{$ENDIF}
begin
{$IFDEF FPC}
  with (MForm) do
    for i := 0 to ComponentCount-1 do
      if (Components[i].HasParent) and (Components[i].GetParentComponent is TGroupBox) and not (Components[i] is TButton) then
        TControl(Components[i]).Top := TControl(Components[i]).Top - 15;
{$ENDIF}
end;

{ TfrxCustomPreview }

constructor TfrxCustomPreview.Create(AOwner: TComponent);
begin
  inherited;
  FInPlaceditorsList := nil;
  FSelectionList := TfrxSelectedObjectsList.Create;
end;

destructor TfrxCustomPreview.Destroy;
begin
  if Assigned(FInPlaceditorsList) then
    FreeAndNil(FInPlaceditorsList);
  FreeAndNil(FSelectionList);
  inherited;
end;

procedure TfrxCustomPreview.DoFinishInPlace(Sender: TObject; Refresh,
  Modified: Boolean);
begin
  if Modified then
    PreviewPages.ModifyObject(TfrxComponent(Sender));
end;

function TfrxCustomPreview.GetPreviewPages: TfrxCustomPreviewPages;
var
  lReport: TfrxReport;
begin
  Result := nil;
  lReport := Report;
  if Assigned(lReport) then
    Result := lReport.PreviewPagesList.Current;
end;

function TfrxCustomPreview.GetReport: TfrxReport;
begin
  Result := nil;
end;

procedure TfrxCustomPreview.SetDefaultEventParams(
  var EventParams: TfrxInteractiveEventsParams);
begin
  EventParams.EventSender := esPreview;
  EventParams.Refresh := False;
  EventParams.PopupVisible := False;
  EventParams.EditorsList := FInPlaceditorsList;
  EventParams.OnFinish := DoFinishInPlace;
  EventParams.OffsetX := 0;
  EventParams.OffsetY := 0;
  EventParams.Scale := 1;
  EventParams.Sender := Self;
  EventParams.FireParentEvent := False;
  EventParams.Modified := False;
  EventParams.GridAlign := False;
  EventParams.GridType := gtNone;
  EventParams.GridX := 0;
  EventParams.GridY := 0;
  EventParams.DevicePPI := frxGetDpiForWindow(Handle);
  EventParams.SelectionList := FSelectionList;
  if Assigned(Report) then
    EventParams.EditRestricted := not Report.PreviewOptions.AllowPreviewEdit
  else
    EventParams.EditRestricted := False;
end;

procedure TfrxCustomPreview.InternalCopy;
var
  EditorsManager: TfrxComponentEditorsManager;
  EventParams: TfrxInteractiveEventsParams;
begin

  if (FSelectionList.Count = 0) or not(pbCopy in Report.PreviewOptions.Buttons) then Exit;
  EditorsManager := frxGetInPlaceEditor(FInPlaceditorsList, TfrxComponent(FSelectionList[0]));
  if Assigned(EditorsManager) then
  begin
    SetDefaultEventParams(EventParams);
    EditorsManager.CopyContent(TfrxComponent(FSelectionList[0]), EventParams, nil, cptDefault);
  end;
end;

procedure TfrxCustomPreview.InternalPaste;
var
  EditorsManager: TfrxComponentEditorsManager;
  EventParams: TfrxInteractiveEventsParams;
begin
  if (FSelectionList.Count = 0) or not(pbPaste in Report.PreviewOptions.Buttons) then Exit;
  EditorsManager := frxGetInPlaceEditor(FInPlaceditorsList, TfrxComponent(FSelectionList[0]));
  if Assigned(EditorsManager) then
  begin
    SetDefaultEventParams(EventParams);
    EditorsManager.PasteContent(TfrxComponent(FSelectionList[0]), EventParams, nil);
  end;
  if EventParams.Refresh then Invalidate;
end;

function TfrxCustomPreview.InternalIsPasteAvailable: Boolean;
var
  EditorsManager: TfrxComponentEditorsManager;
  EventParams: TfrxInteractiveEventsParams;
begin
  Result := False;
  if (FSelectionList.Count = 0) or not(pbPaste in Report.PreviewOptions.Buttons) then
    Exit;
  EditorsManager := frxGetInPlaceEditor(FInPlaceditorsList, TfrxComponent(FSelectionList[0]));
  if Assigned(EditorsManager) then
  begin
    SetDefaultEventParams(EventParams);
    Result := EditorsManager.IsPasteAvailable(TfrxComponent(FSelectionList[0]), EventParams);
  end;
end;

{ TfrxFieldsStringList }
{
function TfrxFieldsStringList.GetField(Index: Integer): TfrxFileld;
begin
  Result := GetObject(Index) as TfrxFileld;
end;

procedure TfrxFieldsStringList.PutField(Index: Integer;
  const Value: TfrxFileld);
begin
  PutObject(Index, Value);
end;
}
{ TfrxSelectedObjectsList }

procedure TfrxSelectedObjectsList.ClearInspectorList;
begin
  FInspSelectedObjects.Clear;
end;

constructor TfrxSelectedObjectsList.Create;
begin
  inherited;
  FInspSelectedObjects := TList.Create;
end;

destructor TfrxSelectedObjectsList.Destroy;
begin
  inherited;
  FreeAndNil(FInspSelectedObjects);
end;

procedure TfrxSelectedObjectsList.Notify(Ptr: Pointer;
  Action: TListNotification);
begin
  { sync lists }
  if Action = lnAdded then
  begin
    // designer works only with TfrxComponent
    if not (TObject(Ptr) is TfrxComponent) then
      Remove(Ptr);
    //object inspector can edit any TPresistent acenstor
    if  TObject(Ptr) is TPersistent then
      FInspSelectedObjects.Add(Ptr);
    if (TObject(Ptr) is TfrxComponent) and not TfrxComponent(Ptr).IsSelected then
    begin
      { back compat , for objects with Parent = nil like CrossTab cells }
      if TfrxComponent(Ptr).Report = nil then
        TfrxComponent(Ptr).FSelectList := Self
      else
        TfrxComponent(Ptr).IsSelected := True;
    end;
    FUpdated := True;
  end;
  if Action = lnDeleted then
  begin
    if TObject(Ptr) is TfrxComponent then
      TfrxComponent(Ptr).IsSelected := False;
    if Count = 0 then
      FInspSelectedObjects.Clear
    else
      FInspSelectedObjects.Remove(Ptr);
    FUpdated := True;
  end;
end;

{ TfrxObjectsNotifyList }

function TfrxObjectsNotifyList.Get(Index: TfrListInteger): Pointer;
begin
  Result := inherited Get(Index);
end;

function TfrxObjectsNotifyList.GetCount: TfrListInteger;
begin
  Result := Inherited Count;
end;

procedure TfrxObjectsNotifyList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  If Assigned(FOnNotifyList) then
    FOnNotifyList(Ptr, Action);
end;

procedure TfrxObjectsNotifyList.Put(Index: TfrListInteger; const Value: Pointer);
begin
  inherited Put(Index, Value);
end;

{ TfrxPage }

constructor TfrxPage.Create(AOwner: TComponent);
begin
  inherited;
  frComponentStyle := frComponentStyle + [csAcceptsFrxComponents];
  FHGuides := TStringList.Create;
  FVGuides := TStringList.Create;
end;


procedure TfrxPage.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  if Assigned(FComponentEditors) then
    FComponentEditors.DrawCustomEditor(Canvas, Rect(Round(OffsetX * ScaleX), Round(OffsetY * ScaleY), Round((Width + OffsetX) * ScaleX), Round((Height + OffsetY) * ScaleY)));
end;

function TfrxPage.IsSupportsGuidlines: Boolean;
begin
  Result := False;
end;

{ TfrxSaveToCompressedFilter }

constructor TfrxSaveToCompressedFilter.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FilterString := GetDescription;
  FVisibility := [fvDesignerFileFilter, fvPreviewFileFilter];
  FDefaultExt := '.fp3';
end;

class function TfrxSaveToCompressedFilter.GetDescription: String;
begin
  Result := frxResources.Get('dsComprRepFilter')
end;

function TfrxSaveToCompressedFilter.GetFilterString: String;
begin
  if FCreatedFrom <> fvPreview then
    FilterString := frxResources.Get('dsComprRepFilter')
  else
    FilterString := frxResources.Get('clComprPreparedRepFilter');
  FDefaultExt := Copy(FFilterString, Pos('|', FFilterString) + 2, Length(FFilterString));
  Result := Inherited GetFilterString;
end;

function TfrxSaveToCompressedFilter.OpenFilter: Boolean;
begin
  Report.ReportOptions.Compressed := True;
  Result := True;
end;

procedure TfrxSaveToCompressedFilter.SetIsFR3File(const Value: Boolean);
begin
  FIsFR3File := Value;
  if IsFR3File then
    FilterString := frxResources.Get('dsComprRepFilter')
  else
    FilterString := frxResources.Get('clComprPreparedRepFilter');
end;

{ TfrxNode }

function TfrxNode.Add(const Name: String; aObject: TObject): TfrxNode;
var
  aRoot: TfrxNode;
begin
  Result := TfrxNode.Create;
  Result.Name := Name;
  Result.FParent := Self;
  Result.FObjectData := aObject;
  FNodesList.AddObject(Name, Result);

  if aObject <> nil then
    UpdateFilesCount(1);

  aRoot := GetRoot;
  if (aRoot <> nil) and Assigned(aRoot.FOnAddItem) then
    aRoot.OnAddItem(Name, False, aObject);
end;

procedure TfrxNode.Clear;
var
  i: Integer;
begin
  for i := 0 to FNodesList.Count - 1 do
  begin
    // don't call RemoveNode for childs
    TfrxNode(FNodesList.Objects[i]).FParent := nil;
    TfrxNode(FNodesList.Objects[i]).Free;
  end;
  if Assigned(FObjectData) and FOwnObject then
    FreeAndNil(FObjectData);
  FNodesList.Clear;
  FName := '';
end;

function TfrxNode.Count: Integer;
begin
  Result := FNodesList.Count;
end;

constructor TfrxNode.Create;
begin
  FNodesList := TStringList.Create;
  FNodesList.Sorted := True;
  FParent := nil;
  FOwnObject := True;
  FFilterAccess := faWrite;
  FFilesCount := 0;
end;

destructor TfrxNode.Destroy;
begin
  FParent := nil;
  if FParent <> nil then
    FParent.RemoveNode(Self);
  Clear;
  FreeAndNil(FNodesList);
  inherited;
end;

function TfrxNode.Find(aObject: TObject; SearchInChilds: Boolean): TfrxNode;
var
  i: Integer;
  aNode: TfrxNode;
begin
  Result := nil;
  for i := 0 to FNodesList.Count - 1 do
  begin
    aNode := TfrxNode(FNodesList.Objects[i]);
    if aNode.ObjectData = aObject then
      Result := aNode;
    if SearchInChilds and (Result = nil) then
      Result := TfrxNode(FNodesList.Objects[i]).Find(aObject, SearchInChilds);
    if Result <> nil then
      Exit;
  end;
end;

function TfrxNode.Find(const Name: String; SearchInChilds: Boolean): TfrxNode;
var
  Index, i: Integer;
begin
  Result := nil;
  Index := FNodesList.IndexOf(Name);
  if Index <> -1 then
    Result := TfrxNode(FNodesList.Objects[Index]);
  if (Result = nil) and SearchInChilds then
    for i := 0 to FNodesList.Count - 1 do
    begin
      Result := TfrxNode(FNodesList.Objects[i]).Find(Name, SearchInChilds);
      if Result <> nil then
        break;
    end;
end;

function TfrxNode.GetNode(Index: Integer): TfrxNode;
begin
  Result := TfrxNode(FNodesList.Objects[Index]);
end;

function TfrxNode.GetRoot: TfrxNode;
begin
  Result := Self;
  while (Result.Parent <> nil) do
    Result := Result.Parent;
end;

procedure TfrxNode.RemoveNode(aNode: TfrxNode);
var
  Index: Integer;
  p: TfrxNode;
begin
  p := Self.Parent;

  Index := FNodesList.IndexOfObject(aNode);
  if Index <> -1 then
  begin
    FNodesList.Delete(Index);
    while (p <> nil) do
    begin
      Dec(p.FFilesCount, aNode.FFilesCount);
      p := p.Parent;
    end;
  end;
end;

procedure TfrxNode.SetName(const Value: String);
var
  aRoot: TfrxNode;
begin
  if FName = Value then Exit;

  aRoot := GetRoot;
  if (aRoot <> nil) and Assigned(aRoot.FOnAddItem) and Assigned(aRoot.FOnRemoveItem) then
  begin
    aRoot.OnRemoveItem(FName);
    aRoot.OnAddItem(Value, False, FObjectData);
  end;
  FName := Value;
end;

procedure TfrxNode.SetObjectData(const Value: TObject);
var
  aRoot: TfrxNode;
begin
  if FObjectData = Value then Exit;

  aRoot := GetRoot;
  if (aRoot <> nil) and Assigned(aRoot.FOnAddItem) and Assigned(aRoot.FOnRemoveItem) then
    if Value = nil then
      aRoot.OnRemoveItem(FName, True)
    else if FObjectData = nil then
    begin
      aRoot.OnAddItem(FName, True, Value);
      UpdateFilesCount(1);
    end
    else
      aRoot.OnAddItem(FName, False, Value);
  FObjectData := Value;
end;

procedure TfrxNode.SetOriginalName(const Value: String);
begin
  if (FOriginalName = '') and (Value <> '') then
    UpdateFilesCount(1);
  FOriginalName := Value;
end;

procedure TfrxNode.UpdateFilesCount(Count: Integer);
var
  pNode: TfrxNode;
begin
  pNode := Self;

  while (pNode <> nil) do
  begin
    Inc(pNode.FFilesCount, Count);
    pNode := pNode.Parent;
  end;

end;

{ TfrxComponentEditorsManager }

procedure TfrxComponentEditorsManager.CopyContent(CopyFrom: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; CopyAs: TfrxCopyPasteType);
var
  i: Integer;
begin
  // when EventParams.SelectionList assigned call method to process group of objects
  for i := 0 to FEditorsGlasses.Count - 1 do
    if Assigned(EventParams.SelectionList) and (EventParams.SelectionList.Count > 1) then
      TfrxInPlaceEditor(FEditorsGlasses[i]).CopyGoupContent(CopyFrom, EventParams, Buffer, CopyAs)
    else
    begin
      if Assigned(CopyFrom) and ((not(ferAllowInPreview in CopyFrom.Editable) and
        (EventParams.EventSender = esPreview) and (rfDontEditInPreview in CopyFrom.Restrictions){just for back compat }) or
        (EventParams.EditRestricted)) then Exit;
      if CopyAs = cptDefault then
        CopyAs := TfrxInPlaceEditor(FEditorsGlasses[i]).DefaultContentType;
      TfrxInPlaceEditor(FEditorsGlasses[i]).CopyContent(CopyFrom, EventParams, Buffer, CopyAs);
    end;
end;

constructor TfrxComponentEditorsManager.Create;
begin
  FEditorsGlasses := TList.Create;
end;

destructor TfrxComponentEditorsManager.Destroy;
begin
  Component := nil;
  FreeAndNil(FEditorsGlasses);
end;

function TfrxComponentEditorsManager.DoCustomDragDrop(Source: TObject; X,
  Y: Integer; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    Result := TfrxInPlaceEditor(FEditorsGlasses[i]).DoCustomDragDrop(Source, X, Y, EventParams);
    if Result then break;
  end;
end;

function TfrxComponentEditorsManager.DoCustomDragOver(Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    Result := TfrxInPlaceEditor(FEditorsGlasses[i]).DoCustomDragOver(Source, X, Y, State, Accept, EventParams);
    if Result then break;
  end;
end;

function TfrxComponentEditorsManager.DoMouseDown(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    Result := TfrxInPlaceEditor(FEditorsGlasses[i]).DoMouseDown(X, Y, Button, Shift, EventParams);
    if Result then break;
  end;
end;

function TfrxComponentEditorsManager.DoMouseMove(X, Y: Integer;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    Result := TfrxInPlaceEditor(FEditorsGlasses[i]).DoMouseMove(X, Y, Shift, EventParams);
    if Result then break;
  end;
end;

function TfrxComponentEditorsManager.DoMouseUp(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    Result := TfrxInPlaceEditor(FEditorsGlasses[i]).DoMouseUp(X, Y, Button, Shift, EventParams);
    if Result then break;
  end;
end;

function TfrxComponentEditorsManager.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    Result := TfrxInPlaceEditor(FEditorsGlasses[i]).DoMouseWheel(Shift, WheelDelta, MousePos, EventParams);
    if Result then break;
  end;
end;

procedure TfrxComponentEditorsManager.DrawCustomEditor(aCanvas: TCanvas;
  aRect: TRect);
var
  i: Integer;
begin
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    TfrxInPlaceEditor(FEditorsGlasses[i]).DrawCustomEditor(aCanvas, aRect);
  //  if Result then break;
  end;
end;

function TfrxComponentEditorsManager.EditorsActiveRects(
  aComponent: TfrxComponent): TfrxRectArray;
var
  i: Integer;
begin
  SetLength(Result, FEditorsGlasses.Count);
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    Result[i] := TfrxInPlaceEditor(FEditorsGlasses[i]).GetActiveRect;
    Result[i].Top := Round(aComponent.AbsTop) + Result[i].Top;
    Result[i].Left := Round(aComponent.AbsLeft) + Result[i].Left;
    Result[i].Right := Round(aComponent.AbsLeft) + Result[i].Right;
    Result[i].Bottom := Round(aComponent.AbsTop) + Result[i].Bottom;
  end;
end;

procedure TfrxComponentEditorsManager.FinalizeUI(var EventParams: TfrxInteractiveEventsParams);
var
  i: Integer;
begin
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    TfrxInPlaceEditor(FEditorsGlasses[i]).FinalizeUI(EventParams);
    //TfrxInPlaceEditor(FEditorsGlasses[i]).FComponents := nil;
  //  if Result then break;
  end;
end;

function TfrxComponentEditorsManager.GetComponent: TfrxComponent;
begin
  Result := nil;
  if FEditorsGlasses.Count > 0 then
    Result := TfrxInPlaceEditor(FEditorsGlasses[0]).Component;
end;

procedure TfrxComponentEditorsManager.InitializeUI(var EventParams: TfrxInteractiveEventsParams);
var
  i: Integer;
begin
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).SetOffset(FOffsetX, FOffsetY, FScale);
    TfrxInPlaceEditor(FEditorsGlasses[i]).InitializeUI(EventParams);
    TfrxInPlaceEditor(FEditorsGlasses[i]).FComponents := EventParams.SelectionList;
  //  if Result then break;
  end;
end;

function TfrxComponentEditorsManager.IsContain(ObjectRect: TRect; X, Y: Extended): Boolean;
var
  i: Integer;
  r: TRect;
  w, h : Integer;
begin
  Result := False;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    r := TfrxInPlaceEditor(FEditorsGlasses[i]).GetActiveRect;
    w := r.Right - r.Left;
    h := r.Bottom - r.Top;
    if (w = 0) or (h = 0) then continue;
    r.Left := ObjectRect.Left + r.Left;
    r.Top := ObjectRect.Top + r.Top;
    r.Right := r.Left + w;
    r.Bottom := r.Top + h;
    Result := (X >= r.Left) and
    (X <= r.Right) and
    (Y >= r.Top) and
    (Y <= r.Bottom);
    if Result then
    begin
      break;
      //w := r.Right - r.Left;
    end;
  end;
end;

function TfrxComponentEditorsManager.IsPasteAvailable(PasteTo: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; PasteAs: TfrxCopyPasteType): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Assigned(PasteTo) and (not(ferAllowInPreview in PasteTo.Editable) and
    (EventParams.EventSender = esPreview) or (EventParams.EditRestricted)) then Exit;
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    Result := TfrxInPlaceEditor(FEditorsGlasses[i]).IsPasteAvailable(PasteTo, EventParams, PasteAs);
    if Result then break;
  end;
end;

procedure TfrxComponentEditorsManager.PasteContent(PasteTo: TfrxComponent;
  var EventParams: TfrxInteractiveEventsParams; Buffer: TStream; PasteAs: TfrxCopyPasteType);
var
  i: Integer;
begin
  for i := 0 to FEditorsGlasses.Count - 1 do
    if Assigned(EventParams.SelectionList) and (EventParams.SelectionList.Count > 1) then
      TfrxInPlaceEditor(FEditorsGlasses[i]).PasteGoupContent(PasteTo, EventParams, Buffer, PasteAs)
    else
    begin
      if Assigned(PasteTo) and (not(ferAllowInPreview in PasteTo.Editable) and (EventParams.EventSender = esPreview) or (EventParams.EditRestricted)) then Exit;
      TfrxInPlaceEditor(FEditorsGlasses[i]).PasteContent(PasteTo, EventParams, Buffer, PasteAs);
    end;
end;

procedure TfrxComponentEditorsManager.SetClipboardObject(const aObject: TPersistent);
var
  i: Integer;
begin
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).FClipboardObject := aObject;
  //  if Result then break;
  end;
end;

procedure TfrxComponentEditorsManager.SetComponent(const Value: TfrxComponent);
var
  i: Integer;
begin
  for i := 0 to FEditorsGlasses.Count - 1 do
  begin
    TfrxInPlaceEditor(FEditorsGlasses[i]).Component := Value;
  //  if Result then break;
  end;
end;

procedure TfrxComponentEditorsManager.SetOffset(aOffsetX, aOffsetY,
  aScale: Extended);
begin
  FOffsetX := aOffsetX;
  FOffsetY := aOffsetY;
  FScale := aScale;
end;

{ TfrxComponentEditorsList }

constructor TfrxComponentEditorsList.Create;
begin
  FEditorsInstances := TList.Create;
end;

procedure TfrxComponentEditorsList.CreateInstanceFromItem(
  aItem: TfrxComponentEditorsRegItem; aOwner: TWinControl; aVisibility: TfrxComponentEditorVisibilityState);
var
  lItem: TfrxComponentEditorsManager;
  i, Index: Integer;
  aClass: TfrxComponentClass;
  aObject: TfrxInPlaceEditor;
begin
  if aItem = nil then Exit;
  lItem := TfrxComponentEditorsManager.Create;
  lItem.FComponentClass := aItem.FComponentClass;
  for i := 0 to aItem.FEditorsClasses.Count - 1 do
  begin
    if not(aVisibility in TfrxComponentEditorVisibility(Byte(aItem.FEditorsVisibility[i]))) then continue;
    aClass := TfrxComponentClass(aItem.FEditorsClasses[i]);
    Index := FEditorsInstances.IndexOf(aClass);
    if Index = -1 then
    begin
      aObject := TfrxInPlaceEditor(aClass.NewInstance);
      aObject.Create(aClass, aOwner);
      FEditorsInstances.Add(aObject);
      aObject.FEditors := Self;
    end
    else
      aObject := TfrxInPlaceEditor(FEditorsInstances[Index]);
    lItem.FEditorsGlasses.Add(aObject);
  end;
  AddObject(lItem.FComponentClass.ClassName, lItem);
end;

destructor TfrxComponentEditorsList.Destroy;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    TObject(Objects[i]).Free;
  for i := 0 to FEditorsInstances.Count - 1 do
    TObject(FEditorsInstances[i]).Free;
  FreeAndNil(FEditorsInstances);
  inherited;
end;

function TfrxComponentEditorsList.GetEditors(
  Index: Integer): TfrxComponentEditorsManager;
begin
  Result := TfrxComponentEditorsManager(Objects[Index]);
end;

procedure TfrxComponentEditorsList.PutEditors(Index: Integer;
  const Value: TfrxComponentEditorsManager);
begin
  Objects[Index] := Value;
end;

{ TfrxComponentEditorsClasses }

function TfrxComponentEditorsClasses.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TfrxComponentEditorsClasses.Create;
begin
  FList := TStringList.Create;
end;

function TfrxComponentEditorsClasses.CreateEditorsInstances(
  aVisibility: TfrxComponentEditorVisibilityState; aOwner: TWinControl): TfrxComponentEditorsList;
var
  i: Integer;
begin
  Result := TfrxComponentEditorsList.Create;
  for i := 0 to Count - 1 do
    Result.CreateInstanceFromItem(EditorsClasses[i], aOwner, aVisibility);
end;

destructor TfrxComponentEditorsClasses.Destroy;
var
  I: Integer;
begin
  for i := 0 to Count - 1 do
    TObject(FList.Objects[i]).Free;
  FreeAndNil(FList);
  inherited;
end;

function TfrxComponentEditorsClasses.GetEditors(
  Index: Integer): TfrxComponentEditorsRegItem;
begin
  Result := TfrxComponentEditorsRegItem(FList.Objects[Index]);
end;

function TfrxComponentEditorsClasses.IndexOf(const s: String): Integer;
begin
  Result := FList.IndexOf(s);
end;

procedure TfrxComponentEditorsClasses.LoadFromIni(IniFile: TCustomIniFile);
var
  i, j: Integer;
  sName: String;
  aList: TList;
begin
  for i := 0 to Count - 1 do
  begin
    sName := EditorsClasses[i].FComponentClass.ClassName;
    aList := EditorsClasses[i].FEditorsClasses;
    for j := 0 to aList.Count - 1 do
      EditorsClasses[i].FEditorsVisibility[j] := TObject(IniFile.ReadInteger(sName, TfrxInPlaceEditorClass(aList[j]).ClassName, frInteger(EditorsClasses[i].FEditorsVisibility[j])));    end;
end;

procedure TfrxComponentEditorsClasses.PutEditors(Index: Integer;
  const Value: TfrxComponentEditorsRegItem);
begin
  FList.Objects[Index] := Value;
end;

procedure TfrxComponentEditorsClasses.Register(ComponentClass
  : TfrxComponentClass; ComponentEditors: array of TfrxInPlaceEditorClass;
  EditorsVisibility: array of TfrxComponentEditorVisibility);
var
  Item: TfrxComponentEditorsRegItem;
  i, vCount: Integer;
  defVisibility: TfrxComponentEditorVisibility;
begin
  defVisibility := [evPreview, evDesigner];
  if High(ComponentEditors) - Low(ComponentEditors) < 0 then Exit;

  i := FList.Indexof(ComponentClass.ClassName);

  if i = -1 then
  begin
    Item := TfrxComponentEditorsRegItem.Create;
    Item.FComponentClass := ComponentClass;
    FList.AddObject(ComponentClass.ClassName, Item);
  end
  else
    Item := TfrxComponentEditorsRegItem(FList.Objects[i]);
  vCount := High(EditorsVisibility);
  for i := Low(ComponentEditors) to High(ComponentEditors) do
  begin
    Item.FEditorsClasses.Add(ComponentEditors[i]);
    if vCount >= i then
      Item.FEditorsVisibility.Add(Pointer(Byte(EditorsVisibility[i])))
    else
      Item.FEditorsVisibility.Add(Pointer(Byte(defVisibility)));
  end;
end;

procedure TfrxComponentEditorsClasses.SaveToIni(IniFile: TCustomIniFile);
var
  i, j: Integer;
  sName: String;
  aList: TList;
begin
  for i := 0 to Count - 1 do
  begin
    sName := EditorsClasses[i].FComponentClass.ClassName;
    aList := EditorsClasses[i].FEditorsClasses;
    for j := 0 to aList.Count - 1 do
      IniFile.WriteInteger(sName, TfrxInPlaceEditorClass(aList[j]).ClassName, frInteger(EditorsClasses[i].FEditorsVisibility[j]));
  end;
end;

procedure TfrxComponentEditorsClasses.UnRegister(
  ComponentClass: TfrxComponentClass);
var
  Index: Integer;
begin
  Index := FList.IndexOf(ComponentClass.ClassName);
  if Index = -1 then Exit;
  EditorsClasses[Index].Free;
  FList.Delete(Index);
end;

procedure TfrxComponentEditorsClasses.UnRegister(ComponentClass: TfrxComponentClass;
  EditroClass: TfrxInPlaceEditorClass);
var
  Index: Integer;
begin
  Index := FList.IndexOf(ComponentClass.ClassName);
  if Index = -1 then Exit;
  EditorsClasses[Index].RemoveEditor(EditroClass);
  if EditorsClasses[Index].Count = 0 then
  begin
    EditorsClasses[Index].Free;
    FList.Delete(Index);
  end;
end;

procedure TfrxComponentEditorsClasses.UnRegisterEditor(
  EditroClass: TfrxInPlaceEditorClass);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    EditorsClasses[i].RemoveEditor(EditroClass);
end;

{ TfrxComponentEditorsRegItem }

function TfrxComponentEditorsRegItem.Count: Integer;
begin
  Result := FEditorsClasses.Count;
end;

constructor TfrxComponentEditorsRegItem.Create;
begin
  FEditorsClasses := TList.Create;
  FEditorsVisibility := TList.Create;
end;

destructor TfrxComponentEditorsRegItem.Destroy;
begin
  FreeAndNil(FEditorsClasses);
  FreeAndNil(FEditorsVisibility);
end;

function TfrxComponentEditorsRegItem.GetComponentClassName: String;
begin
  Result := FComponentClass.ClassName;
end;

function TfrxComponentEditorsRegItem.GetEditorClass(
  Index: Integer): TfrxInPlaceEditorClass;
begin
  Result := TfrxInPlaceEditorClass(FEditorsClasses[Index]);
end;

function TfrxComponentEditorsRegItem.GetEditorVisibility(
  Index: Integer): TfrxComponentEditorVisibility;
begin
  Result := TfrxComponentEditorVisibility(Byte(FEditorsVisibility[Index]));
end;

procedure TfrxComponentEditorsRegItem.RemoveEditor(AClass: TfrxInPlaceEditorClass);
var
  i: Integer;
begin
  i := FEditorsClasses.IndexOf(AClass);
  if i < 0 then Exit;
  FEditorsClasses.Delete(i);
  FEditorsVisibility.Delete(i);
end;

procedure TfrxComponentEditorsRegItem.SetEditorClass(Index: Integer;
  const Value: TfrxInPlaceEditorClass);
begin
  FEditorsClasses[Index] := Value;
end;


procedure TfrxComponentEditorsRegItem.SetEditorVisibility(Index: Integer;
  const Value: TfrxComponentEditorVisibility);
begin
  FEditorsVisibility[Index] := TObject(Byte(Value));
end;

{ TfrxPostProcessor }

function TfrxPostProcessor.Add(const BandName: String; const Name: String; const Content: WideString; ProcessMode: TfrxProcessAtMode; aComponent: TfrxComponent; bSupressed: Boolean; bEmpty: Boolean): Integer;
var
  MacroItem: TfrxMacrosItem;
  Index, i: Integer;
begin
//  if Band is TfrxGroupHeader then
//    Inc(FGroupLevel);

  Index := FMacroses.IndexOf(Name);
  if Index = - 1 then
  begin
    MacroItem := TfrxMacrosItem.Create;
    MacroItem.FProcessAt := ProcessMode;
    MacroItem.FBaseComponent := aComponent;
    MacroItem.FGroupLevel := FGroupLevel;
    MacroItem.FDataLevel := FDataLevel;
    FMacroses.AddObject(Name, MacroItem);
    MacroItem.FParent := Self;
  end
  else
    MacroItem := TfrxMacrosItem(FMacroses.Objects[Index]);

  if (BandName <> '') and (MacroItem.FBandName = '') then
    MacroItem.FBandName := BandName;

  Index := MacroItem.FItems.Count;
  i := 0;
  if MacroItem.FProcessAt = paDefault then
    i := 1;

  Result := MacroItem.AddObject(Content, TObject(i), bSupressed);
  if (Index < MacroItem.FItems.Count) and bEmpty then
    MacroItem.FItems[MacroItem.FItems.Count - 1] := '';


//  FProcessList.Remove(MacroItem);
  if FProcessList.Count > 0 then
    if FProcessList[FProcessList.Count - 1] = MacroItem then Exit;
  if (MacroItem.FProcessAt <> paDefault) and (Index < MacroItem.FItems.Count) then
    FProcessList.Add(MacroItem);
end;

//procedure TfrxPostProcessor.AddFromComponent(aComponent: TfrxComponent);
//var
//  Index: Integer;
//  m: TfrxCustomMemoView;
//  b: TfrxBand;
//  s: WideString;
//begin
//  if (aComponent is TfrxCustomMemoView) then
//  begin
//    b := aComponent.Parent as TfrxBand;
//    m := TfrxCustomMemoView(aComponent);
//    s := m.Text;
//            if (Length(s) >= 2) and
//          (s[Length(s) - 1] = #13) and (s[Length(s)] = #10) then
//            Delete(s, Length(s) - 1, 2);
//
//        {$IFDEF UNIX} // delete LineEnding
//        if (Length(s) >= 1) and
//          (s[Length(s)] = #10) then
//            Delete(s, Length(s), 1);
//        {$ENDIF}
//
//
//
//
//    Index := Add(b, m.Name, s, m.Processing.ProcessAt, aComponent, ((m.Processing.ProcessAt <> paDefault) or (m.Duplicates <> dmShow)) and Assigned(b));
//    if Index <> -1 then
//      m.Text := IntToStr(Index);
//  end;
//end;

procedure TfrxPostProcessor.Clear;
var
  i: Integer;
begin
  for i := 0 to FMacroses.Count - 1 do
    FMacroses.Objects[i].Free;
  FMacroses.Clear;
  FProcessList.Clear;
  FGroupLevel := 0;
  FDataLevel := 0;
end;

constructor TfrxPostProcessor.Create;
begin
  FMacroses := TStringList.Create;
  TStringList(FMacroses).Sorted := True;
  FBands := TStringList.Create;
  TStringList(FBands).Sorted := True;
  FProcessList := TList.Create;
end;

destructor TfrxPostProcessor.Destroy;
begin
  Clear;
  FreeAndNil(FBands);
  FreeAndNil(FMacroses);
  FreeAndNil(FProcessList);
  inherited;
end;

procedure TfrxPostProcessor.EnterData;
begin
  Inc(FDataLevel);
end;

procedure TfrxPostProcessor.EnterGroup;
begin
  Inc(FGroupLevel);
end;

function TfrxPostProcessor.GetMacroList(
  const MacroName: String): TWideStrings;
var
  Index: Integer;
begin
  Result := nil;
  Index := FMacroses.IndexOf(MacroName);
  if Index <> -1 then
    Result := TfrxMacrosItem(FMacroses.Objects[Index]).FItems;
end;

function TfrxPostProcessor.GetValue(const MacroIndex,
  MacroLine: Integer): WideString;
begin

end;

procedure TfrxPostProcessor.LeaveData;
begin
  Dec(FDataLevel);
  if FDataLevel < 0 then
    FDataLevel := 0;
end;

procedure TfrxPostProcessor.LeaveGroup;
begin
  Dec(FGroupLevel);
  if FGroupLevel < 0 then
    FGroupLevel := 0;
end;

procedure TfrxPostProcessor.LoadFromXML(Item: TfrXMLItem);
var
  i, j: Integer;
  MacroItem: TfrxMacrosItem;
begin
  if Item = nil then Exit;
  for i := 0 to Item.Count - 1 do
  begin
    MacroItem := TfrxMacrosItem.Create;
    FMacroses.AddObject(Item[i].Name, MacroItem);
    for j := 0 to Item[i].Count - 1 do
{$IFDEF DELPHI12}
      MacroItem.FItems.AddObject(frxXMLToStr(Item[i].Items[j].Prop['cnt']), TObject(1));
{$ELSE}
      MacroItem.FItems.AddObject(frxXMLToStr(UTF8Decode(Item[i].Items[j].Prop['cnt'])), TObject(1));
{$ENDIF}
  end;
  Item.Clear;
end;

function TfrxPostProcessor.LoadValue(aComponent: TfrxComponent): Boolean;
var
  Index: Integer;
begin
  Result := False;
  if aComponent.Name = '' then Exit;
  Index := FMacroses.IndexOf(aComponent.Name);
  if (Index <> -1) and (aComponent is TfrxView) then
    Result := TfrxView(aComponent).LoadContentFromDictionary(nil, TfrxMacrosItem(FMacroses.Objects[Index]));
  if Result then aComponent.Free;
end;

procedure TfrxPostProcessor.ProcessExpressions(aReport: TfrxReport;
  ABand: TfrxBand; ProcessMode: TfrxProcessAtMode);
var
  i, gl: Integer;
  Item: TfrxMacrosItem;
  bCheckLevel: Boolean;
begin
  i := 0;
  FProcessing := True;
  while (i < FProcessList.Count) do
  begin
    Item := TfrxMacrosItem(FProcessList[i]);
    gl := TfrxView(Item.FBaseComponent).Processing.GroupLevel;
    { processes groups and data levels separately }
    case ProcessMode of
      paGroupFinished:
        bCheckLevel := ((gl = FGroupLevel) or ((gl = 0) and (Item.FGroupLevel = FGroupLevel)));
      paDataFinished:
        bCheckLevel := (Item.FDataLevel = FDataLevel);
      else
        bCheckLevel := True;
    end;
    if (Item.FProcessAt <> paDefault) and (ProcessMode = Item.FProcessAt) and bCheckLevel then
    begin
      //Index := Item.FItems.Count - 1;
      TfrxView(Item.FBaseComponent).ProcessDictionary(Item, aReport, Self);
      FProcessList.Remove(Item);
      Dec(i);
    end;
    Inc(i);
  end;
  if ProcessMode = paGroupFinished then
    LeaveGroup;
  FProcessing := False;
end;

procedure TfrxPostProcessor.ProcessObject(AReport: TfrxReport; aComponent: TfrxComponent);
var
  i: Integer;
  Item: TfrxMacrosItem;
begin
  i := 0;
  while (i < FProcessList.Count) do
  begin
    Item := TfrxMacrosItem(FProcessList[i]);
    if (Item.FProcessAt <> paDefault) and (Item.FBaseComponent = aComponent) then
    begin
      FProcessing := True;
      try
        TfrxView(Item.FBaseComponent).ProcessDictionary(Item, aReport, Self);
      finally
        FProcessing := False;
      end;
      FProcessList.Remove(Item);
      Break;
    end;
    Inc(i);
  end;
end;

procedure TfrxPostProcessor.ResetDuplicates(const BandName: String);
var
  I: Integer;
begin
  for I := 0 to FMacroses.Count -1 do
    if (TfrxMacrosItem(FMacroses.Objects[I]).FBandName = BandName) or (BandName = '') then
      TfrxMacrosItem(FMacroses.Objects[I]).FNeedReset := True;
end;

procedure TfrxPostProcessor.ResetSuppressed;
var
  I: Integer;
begin
  for I := 0 to FMacroses.Count -1 do
  begin
    TfrxMacrosItem(FMacroses.Objects[I]).FLastIndex := -1;
    TfrxMacrosItem(FMacroses.Objects[I]).FComponent := nil;
  end;
end;

procedure TfrxPostProcessor.SaveToXML(Item: TfrXMLItem);
var
  i, j: Integer;
  MacroItem: TfrxMacrosItem;
  lItem: TfrXMLItem;
begin
  for i := 0 to FMacroses.Count - 1 do
  begin
    MacroItem := TfrxMacrosItem(FMacroses.Objects[i]);
    lItem := Item.Add;
    lItem.Name := FMacroses[i];
    for j := 0 to MacroItem.FItems.Count - 1 do
      with lItem.Add do
      begin
        Name := 'i';
{$IFDEF DELPHI12}
        Text := ' cnt="' + frxStrToXML(MacroItem.FItems[j]) + '"';
{$ELSE}
        Text := ' cnt="' + frxStrToXML(UTF8Encode(MacroItem.FItems[j])) + '"';
{$ENDIF}
      end;
  end;
end;

{ TfrxMacrosItem }

function TfrxMacrosItem.AddObject(const S: WideString; AObject: TObject;
  bSupressed: Boolean): Integer;
begin
  if bSupressed and (FItems.Count >= 1) and not FNeedReset then
    if s = FItems[FItems.Count - 1] then
    begin
      Result := FItems.Count - 1;
      Exit;
    end;
//  Result := FItems.Count - 1;

  Result := FItems.AddObject(S, AObject);
  FNeedReset := False;
end;

function TfrxMacrosItem.Count: Integer;
begin
  Result := FItems.Count;
end;

constructor TfrxMacrosItem.Create;
begin
  FItems := TfrWideStrings.Create;
  FSupressedValue := NULL;
  FLastIndex := -1;
  FComponent := nil;
  FNeedReset := False;
  FProcessAt := paDefault;
  FGroupLevel := 0;
  FDataLevel := 0;
end;

destructor TfrxMacrosItem.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TfrxMacrosItem.GetItem(Index: Integer): WideString;
begin
  if (Integer(FItems.Objects[Index]) = 0) and not FParent.FProcessing then
    Result := ''
  else
    Result := FItems[Index];
end;

procedure TfrxMacrosItem.SetItem(Index: Integer; const Value: WideString);
begin
  FItems[Index] := Value;
  if Assigned(FParent) and FParent.FProcessing then
    FItems.Objects[Index] := TObject(1);
end;

{ TfrxObjectProcessing }

procedure TfrxObjectProcessing.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TfrxObjectProcessing then
  begin
    ProcessAt := TfrxObjectProcessing(Source).FProcessAt;
    GroupLevel := TfrxObjectProcessing(Source).FGroupLevel;
  end;
end;


constructor TfrxDigitalSignatureView.Create(AOwner: TComponent);
begin
  inherited;

  FCustomizable := False;
  FCustomData := TfrxCustomSignatureData.Create;
  FCustomPicture := TPicture.Create;
  FSavedPicture := TPicture.Create;
end;

function TfrxDigitalSignatureView.CreateBitmap24: TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf24bit;
  Result.Width := Round(Width);
  Result.Height := Round(Height);
end;

function TfrxDigitalSignatureView.CreateBitmap32: TBitmap;
var
  PQuad: PRGBQuad;
  w, h: Integer;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf32bit;
  Result.Width := Round(Width);
  Result.Height := Round(Height);
  Result.Transparent := True;
  for h := 0 to Result.Height - 1 do
  begin
    PQuad := Result.ScanLine[h];
    for w := 0 to Result.Width - 1 do
    begin
      PQuad^.rgbReserved := 0;
      Inc(PQuad);
    end;
  end;
end;

procedure TfrxDigitalSignatureView.CreateCustomPicture;
var
  CustomBitmap: TBitmap;
  FullRect, NameRect, TextRect: TRect;
  Horizontal: Boolean;
begin
  CustomBitmap := nil;
  try
    if FCustomData.ShowLogo or IsGraphicVisible or IsTextVisible then // Show FCustomPicture
    begin
      CustomBitmap := CreateBitmap32;
      Horizontal := CustomBitmap.Width >= CustomBitmap.Height;

      if FCustomData.ShowLogo then
        DrawLogo(CustomBitmap.Canvas);

      FullRect := Bounds(0, 0, CustomBitmap.Width, CustomBitmap.Height);
      NameRect := FullRect;
      TextRect := FullRect;

      if      IsGraphicVisible and IsTextVisible then
        if Horizontal then
        begin
          NameRect := Bounds(0, 0, CustomBitmap.Width div 2, CustomBitmap.Height);
          TextRect := Rect(NameRect.Right, FullRect.Top, FullRect.Right, FullRect.Bottom);
        end
        else // Vertical
        begin
          NameRect := Bounds(0, 0, CustomBitmap.Width, CustomBitmap.Height div 2);
          TextRect := Rect(FullRect.Left, NameRect.Bottom, FullRect.Right, FullRect.Bottom);
        end;

      if IsGraphicVisible then
        case FCustomData.GraphicType of
          gtImported: DrawNamePicture(CustomBitmap.Canvas, NameRect);
          gtName: DrawNameText(CustomBitmap.Canvas, NameRect);
        end;

      if IsTextVisible then
        DrawText(CustomBitmap.Canvas, TextRect);

    end;
    FCustomPicture.Graphic := CustomBitmap;
  finally
    CustomBitmap.Free;
  end;
end;

procedure TfrxDigitalSignatureView.CustomFirst;
begin
  if Customizable then
  begin
    CreateCustomPicture;
    FSavedPicture.Assign(FPicture);
    Picture := FCustomPicture;
    UpdateGraphicHelper;
  end;
end;

procedure TfrxDigitalSignatureView.CustomLast;
begin
  if Customizable then
  begin
    Picture := FSavedPicture;
    UpdateGraphicHelper;
  end;
end;

destructor TfrxDigitalSignatureView.Destroy;
begin
  FCustomData.Free;
  FCustomPicture.Free;
  FSavedPicture.Free;

  inherited;
end;

procedure TfrxDigitalSignatureView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  if not IsDesigning and (Kind = skInvisible) then
    Exit;

  CustomFirst;
  try
    inherited Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  finally
    CustomLast;
  end;
end;

procedure TfrxDigitalSignatureView.DrawLogo(Canvas: TCanvas);
begin
  DrawWithAcpectRatio(Canvas, Canvas.ClipRect, FCustomData.LogoPicture.Graphic);
end;

procedure TfrxDigitalSignatureView.DrawNamePicture(Canvas: TCanvas; Rect: TRect);
begin
  if FCustomData.NamePicture.Graphic <> nil then
    DrawWithAcpectRatio(Canvas, Rect, FCustomData.NamePicture.Graphic);
end;

procedure TfrxDigitalSignatureView.DrawNameText(Canvas: TCanvas; Rect: TRect);
  function GetText: WideString;
  begin
    Result := frIfStr(FCommonName = '', frxResources.Get('csCommonName'), FCommonName);
  end;
begin
  with CreateWideStrings(GetText) do
    try
      OutText(Canvas, Rect, WS);
    finally
      WS.Free;
    end;
end;

procedure TfrxDigitalSignatureView.DrawText(Canvas: TCanvas; Rect: TRect);
  function GetText: WideString;
    procedure AddLine(IsShow: Boolean; FieldText: WideString;
      LabelText, FieldPlaceholder: string; Addition: string = '');
    begin
      if IsShow then
        Result := Result + frIfStr(Result <> '', #13#10) +
          frIfStr(FCustomData.ShowLabels, frxResources.Get(LabelText)) +
          frIfStr(FieldText = '', frxResources.Get(FieldPlaceholder), FieldText) +
          Addition;
    end;
  var
    DateStr, DateFormat: string;
    {$IFNDEF Linux}
    FormatSettings: TFormatSettings;
    {$ENDIF}
  begin
    Result := '';

    AddLine(FCustomData.ShowName, FCommonName, 'csDigitallySigned', 'csCommonName');

    AddLine(FCustomData.ShowDistinguishedName, FDistinguishedName, 'csDN', 'csDistinguishedName');

    AddLine(FCustomData.ShowReason, FReason, 'csReason', 'csReasonText');

    AddLine(FCustomData.ShowLocation, FLocation, 'csLocation', 'csLocationText');
    // move DateFormat to function
    // for unic use SysUtils.GetEnvironmentVariable('LANG')
    {$IFDEF Linux}
    DateFormat := 'dd/MM/yyyy h:mm:ss';
    {$ELSE}
    GetLocaleFormatSettings($800, FormatSettings);
    DateFormat := FormatSettings.ShortDateFormat + ' ' + FormatSettings.LongTimeFormat;
    {$ENDIF}
    DateTimeToString(DateStr, DateFormat, Now);
    AddLine(FCustomData.ShowDate, FDate, 'csDate', DateStr);

    AddLine(FCustomData.ShowProgramVersion, '', FProgramVersion, 'csVersion', FR_VERSION);
  end;

begin
  with CreateWideStrings(GetText) do
    try
      OutText(Canvas, Rect, WS);
    finally
      WS.Free;
    end;
end;

procedure TfrxDigitalSignatureView.DrawTextFontSizeAndText(dFontSize: Integer; WS: TWideStrings);
var
  DrawText: TfrxDrawText;
begin
  DrawText := GetDrawTextObject;
  Font.Size := Font.Size + dFontSize;
  DrawText.SetFont(Font);
  DrawText.SetText(WS);
end;

procedure TfrxDigitalSignatureView.DrawTextParams(Rect: TRect);
var
  DrawText: TfrxDrawText;
begin
  DrawText := GetDrawTextObject;
  DrawText.SetOptions(True{WordWrap}, False{HTMLTags}, FCustomData.RTL,
    False{WordBreak}, False{Clipped}, True{Wysiwyg}, 0{Rotation});
  DrawText.SetGaps(0{ParagraphGap}, 0{CharSpacing}, 2{LineSpacing});
  DrawText.SetDimensions(1, 1, 1, Rect, Rect);
end;

procedure TfrxDigitalSignatureView.DrawWithAcpectRatio(Canvas: TCanvas; Rect: TRect; Graphic: TGraphic);
var
  Scale: Extended;
  Size, Offset: TPoint;
  DrawWidth, DrawHeight: integer;
begin
  DrawWidth := Rect.Right - Rect.Left;
  DrawHeight := Rect.Bottom - Rect.Top;

  Scale := Min(DrawWidth / Graphic.Width, DrawHeight / Graphic.Height);

  Size := Point(Round(Graphic.Width * Scale), Round(Graphic.Height * Scale));

  Offset := Point((DrawWidth - Size.X) div 2, (DrawHeight - Size.Y) div 2);

  Canvas.Lock;
  try
    Canvas.StretchDraw(Bounds(Offset.X, Offset.Y, Size.X, Size.Y), Graphic);
  finally
    Canvas.Unlock;
  end;
end;

function TfrxDigitalSignatureView.IsGraphicVisible: Boolean;
begin
  Result := FCustomData.GraphicType <> gtNo;
end;

function TfrxDigitalSignatureView.IsTextVisible: Boolean;
begin
  Result := FCustomData.ShowName or FCustomData.ShowLocation or
    FCustomData.ShowDate or FCustomData.ShowReason or
    FCustomData.ShowDistinguishedName or FCustomData.ShowProgramVersion;
end;

procedure TfrxDigitalSignatureView.OutText(Canvas: TCanvas; Rect: TRect; WS: TWideStrings);
var
  DrawText: TfrxDrawText;
  Step, H: Integer;
  HAlign: TfrxHAlign;
begin
  DrawText := GetDrawTextObject;
  DrawText.Lock;
  try
    DrawTextParams(Rect);
    Font.Size := 1;

    Step := 8;
    H := Rect.Bottom - Rect.Top;
    while Step > 1 do
    begin
      repeat
        DrawTextFontSizeAndText(+Step, WS);
      until (DrawText.CalcHeight > H) or DrawText.ForcedWordBreak;
      DrawTextFontSizeAndText(-Step, WS);
      Step := Step div 2;
    end;
    if FCustomData.RTL then
      HAlign := haRight
    else
      HAlign := haLeft;
    DrawText.DrawText(Canvas, HAlign, vaCenter);
  finally
    DrawText.Unlock;
  end;
end;

{ TfrxCustomObjectPreset }

procedure TfrxCustomObjectPreset.BeginDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect);
begin

end;

constructor TfrxCustomObjectPreset.Create;
begin

end;

procedure TfrxCustomObjectPreset.EndDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect);
begin

end;

{ TfrxExtPropList }

procedure TfrxExtPropList.AddProperty(aName: ShortString; pTypInf, StaticGetMethod,
  StaticSetMethod: Pointer);
var
  pInfo: PPropInfo;
begin
  GetMem(pInfo, SizeOf(TPropInfo));
  FillMemory(pInfo, SizeOf(TPropInfo), 0);
  pInfo.Name := aName;
{$IFDEF FPC}
 {$IFDEF ver3_1}
  {$DEFINE ver3_1+}
 {$ENDIF}
 {$IFDEF ver3_2}
  {$DEFINE ver3_1+}
 {$ENDIF}
 {$IFDEF ver3_3}
  {$DEFINE ver3_1+}
 {$ENDIF}
 {$IFDEF ver3_4}
  {$DEFINE ver3_1+}
 {$ENDIF}

 {$IFDEF ver3_1+}
  GetMem(pInfo.PropTypeRef, SizeOf(pInfo.PropTypeRef));
  pInfo.PropTypeRef^ := PTypeInfo(pTypInf);
 {$ELSE}
  pInfo.PropType := pTypInf;
 {$ENDIF}
  pInfo.PropProcs := 1;
{$ELSE}
  GetMem(pInfo.PropType, SizeOf(PPropInfo));
  pInfo.PropType^ := pTypInf;
{$ENDIF}
  pInfo.GetProc := StaticGetMethod;
  pInfo.SetProc := StaticSetMethod;
  FPropInfos.AddObject(String(aName), TObject(pInfo));
end;

procedure TfrxExtPropList.ClearPropInfo;
var
  pInfo: PPropInfo;
  i: Integer;
begin
  for i := 0 to FPropInfos.Count - 1 do
  begin
    pInfo := PPropInfo(FPropInfos.Objects[i]);
{$IFNDEF FPC}
    FreeMem(pInfo.PropType);
{$ELSE}
    FreeMem(pInfo.PropTypeRef);
{$ENDIF}
    FreeMem(pInfo);
  end;
end;

function TfrxExtPropList.Count: Integer;
begin
  Result := FPropInfos.Count;
end;

constructor TfrxExtPropList.Create;
begin
  FPropInfos := TStringList.Create;
end;

destructor TfrxExtPropList.Destroy;
begin
  ClearPropInfo;
  FreeAndNil(FPropInfos);
  inherited;
end;

function TfrxExtPropList.GetGetMethod(Index: Integer): Pointer;
begin
  Result := PPropInfo(FPropInfos.Objects[Index]).GetProc;
end;

function TfrxExtPropList.GetName(Index: Integer): String;
begin
  Result := FPropInfos[Index];
end;

function TfrxExtPropList.GetSetMethod(Index: Integer): Pointer;
begin
  Result := PPropInfo(FPropInfos.Objects[Index]).SetProc;
end;

function TfrxExtPropList.GetTypInfo(Index: Integer): Pointer;
begin
  Result := Pointer(FPropInfos.Objects[Index]);
end;

procedure TfrxExtPropList.SetGetMethod(Index: Integer; const Value: Pointer);
begin
  PPropInfo(FPropInfos.Objects[Index]).GetProc := Value;
end;

procedure TfrxExtPropList.SetName(Index: Integer; const Value: String);
begin
  FPropInfos[Index] := Value;
end;

procedure TfrxExtPropList.SetSetMethod(Index: Integer; const Value: Pointer);
begin
  PPropInfo(FPropInfos.Objects[Index]).SetProc := Value;
end;

procedure TfrxExtPropList.SetTypInfo(Index: Integer; const Value: Pointer);
begin
  FPropInfos.Objects[Index] := TObject(Value);
end;

{ TfrxPreviewPagesList }

function TfrxPreviewPagesList.Add: TfrxCustomPreviewPages;
begin
  Result := TfrxPreviewPages.Create(FReport);
  FList.Add(Result);
end;

function TfrxPreviewPagesList.AddAsCurrent: TfrxCustomPreviewPages;
begin
  Result := Add;
  SetCurrentIndex(FList.Count - 1);
end;

procedure TfrxPreviewPagesList.Clear;
var
  i: Integer;
  SaveFirst: Pointer;
begin
  SaveFirst := FList[0];
  for i := 1 to FList.Count - 1 do
    TObject(FList[i]).Free;
  FList.Clear;
  FList.Add(SaveFirst);
  SetCurrentIndex(0);
end;

function TfrxPreviewPagesList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TfrxPreviewPagesList.Create(aReport: TfrxReport);
begin
  FReport := aReport;
  FList := TList.Create;
  Add;
  FCurrentIndex := 0;
end;

procedure TfrxPreviewPagesList.CurPagesChanged;
begin
  if Assigned(FReport) then
    FReport.PreviewPagesChanged;
end;

procedure TfrxPreviewPagesList.Delete(aPages: TfrxCustomPreviewPages);
var
  CurPages: TfrxCustomPreviewPages;
begin
  { main pages can not be deleted }
  if FList.Count = 1 then Exit;
  aPages.Free;
  CurPages := GetCurrent;
  FList.Remove(aPages);
  if aPages = CurPages then
    SetCurrentIndex(FList.Count - 1)
  else
    FCurrentIndex := FList.Count - 1;
end;

procedure TfrxPreviewPagesList.Delete(Index: Integer);
begin
  { main pages can not be deleted }
  if FList.Count = 1 then Exit;
  TObject(FList[Index]).Free;
  FList.Delete(Index);
  if Index = FCurrentIndex then
    SetCurrentIndex(FList.Count - 1)
  else
    FCurrentIndex := FList.Count - 1;
end;

destructor TfrxPreviewPagesList.Destroy;
begin
  Clear;
  TObject(FList[0]).Free;
  FreeAndNil(FList);
  inherited;
end;

function TfrxPreviewPagesList.GetCurrent: TfrxCustomPreviewPages;
begin
  Result := TfrxCustomPreviewPages(FList[FCurrentIndex]);
end;

function TfrxPreviewPagesList.GetMain: TfrxCustomPreviewPages;
begin
  Result := nil;
  if FList.Count = 0 then Exit;
  Result := TfrxCustomPreviewPages(FList[0]);
end;

procedure TfrxPreviewPagesList.SetCurrent(const Value: TfrxCustomPreviewPages);
var
  i: Integer;
begin
  if GetCurrent = Value then Exit;
  i := FList.IndexOf(Value);
  if i < 0 then
    i := FList.Add(Value);
  SetCurrentIndex(i);
end;

procedure TfrxPreviewPagesList.SetCurrentIndex(Index: Integer);
begin
  { called from destructor }
  if FReport.PreviewPagesList = nil then exit;
  FCurrentIndex := Index;
  FReport.Engine.PreviewPages := Current;
  FReport.UpdateGlobalScritVars;
  CurPagesChanged;
end;

procedure TfrxPreviewPagesList.SetMain(const Value: TfrxCustomPreviewPages);
var
  i: Integer;
  CurrentPages: TfrxCustomPreviewPages;
begin
  i := FList.IndexOf(Value);
  CurrentPages := GetCurrent;
  if i <> -1 then
    FList.Move(i, 0)
  else
    FList.Insert(0, Value);
  { correct cur index without update }
  FCurrentIndex := FList.IndexOf(CurrentPages);
end;

{ TfrxShowReportCommand }

procedure TfrxShowReportCommand.Run;
begin
  inherited;
  FReport.ShowReport(FClearLast);
end;

{ TfrxDelayedCommandManager }

procedure TfrxDelayedCommandManager.AddCommand(Cmd: IfrxDelayedCommand);
var
  Name: String;
  i: Integer;
  PrevCmd: IfrxDelayedCommand;
begin
  if FIsRunning then
    Exit;
  Name := Cmd.GetName;
  i := FCommands.IndexOf(Name);
  if i > -1 then
  begin
    PrevCmd := IfrxDelayedCommand(Pointer(FCommands.Objects[i]));
    FCommands.Delete(i);
    PrevCmd._Release();
  end;
  Cmd._AddRef;
  FCommands.AddObject(Cmd.GetName, TObject(Pointer(Cmd)));
end;

procedure TfrxDelayedCommandManager.Clear;
var
  Cmd: IfrxDelayedCommand;
  i: Integer;
begin
  for i := 0 to FCommands.Count - 1 do
  begin
    Cmd := IfrxDelayedCommand(Pointer(FCommands.Objects[i]));
    Cmd._Release;
  end;
  FCommands.Clear;
end;

constructor TfrxDelayedCommandManager.Create;
begin
  FCommands := TStringList.Create;
  FCommands.Sorted := True;
end;

destructor TfrxDelayedCommandManager.Destroy;
begin
  Clear;
  FreeAndNil(FCommands);
  inherited;
end;

procedure TfrxDelayedCommandManager.RunAll;
var
  Cmd: IfrxDelayedCommand;
begin
  if FIsRunning then Exit;
  FIsRunning := True;
  try
    while FCommands.Count > 0 do
    begin
      Cmd := IfrxDelayedCommand(Pointer(FCommands.Objects[0]));
      FCommands.Delete(0);
      Cmd.Run;
      Cmd._Release;
    end;
  finally
    FIsRunning := False;
  end;
end;

{ TfrxBaseDelayedCommand }

procedure TfrxBaseDelayedCommand.AfterConstruction;
begin
  FRefCount := 0;
end;

function TfrxBaseDelayedCommand.GetInstance: TObject;
begin
  Result := Self;
end;

function TfrxBaseDelayedCommand.GetName: String;
begin
  Result := ClassName;
end;

function TfrxBaseDelayedCommand.QueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} IID: TGUID;
  out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

function TfrxBaseDelayedCommand._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TfrxBaseDelayedCommand._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if FRefCount <= 0 then
    Free;
end;

{ TfrxLoadFromStreamCommand }

constructor TfrxLoadFromStreamCommand.Create(AReport: TfrxReport;
  Stream: TStream);
begin
  FStream := TMemoryStream.Create;
  FStream.CopyFrom(Stream, Stream.Size - Stream.Position);
  FReport := AReport;
  FStream.Position := 0;
end;

destructor TfrxLoadFromStreamCommand.Destroy;
begin
  FreeAndNil(FStream);
  inherited;
end;

procedure TfrxLoadFromStreamCommand.Run;
begin
  FReport.LoadFromStream(FStream);
end;

{ TfrxPrepareReportCommand }

procedure TfrxPrepareReportCommand.Run;
begin
  inherited;
  FReport.PrepareReport(FClearLast);
end;

{ TfrxLoadFromCommand }

constructor TfrxLoadFromCommand.Create(AReport: TfrxReport;
  Transport: TfrxCustomIOTransport; const FileName: String);
begin
  FTransport := TfrxCustomIOTransport(Transport.NewInstance);
  FTransport.CreateNoRegister;
  FTransport.AssignFilter(Transport);
  FTransport.AssignSharedProperties(Transport);
  FReport := aReport;
  FFileName := FileName;
end;

destructor TfrxLoadFromCommand.Destroy;
begin
  FreeAndNil(FTransport);
  inherited;
end;

procedure TfrxLoadFromCommand.Run;
begin
  FReport.LoadFromFilter(FTransport, FFileName);
end;

{ TfrxLoadFromFileCommand }

constructor TfrxLoadFromFileCommand.Create(AReport: TfrxReport;
  const FileName: String; ExceptionIfNotFound: Boolean);
begin
  FReport := aReport;
  FFileName := FileName;
  FExceptionIfNotFound := ExceptionIfNotFound;
end;

procedure TfrxLoadFromFileCommand.Run;
begin
  FReport.LoadFromFile(FFileName, FExceptionIfNotFound);
end;

{ TfrxBasePrepareReportCommand }

constructor TfrxBasePrepareReportCommand.Create(AReport: TfrxReport;
  ClearLast: Boolean);
begin
  FReport := aReport;
  FClearLast := ClearLast;
  FEngineOptions := TfrxEngineOptions.Create;
  FEngineOptions.Assign(FReport.EngineOptions);
  FEngineOptions.AssignThreadProps(FReport.EngineOptions);
end;

destructor TfrxBasePrepareReportCommand.Destroy;
begin
  FreeAndNil(FEngineOptions);
  inherited;
end;

procedure TfrxBasePrepareReportCommand.Run;
begin
  FReport.EngineOptions.Assign(FEngineOptions);
  FReport.EngineOptions.AssignThreadProps(FEngineOptions);
end;

{ TfrxRefreshReportCommand }

procedure TfrxRefreshReportCommand.Run;
begin
  inherited;
  FReport.RefreshActivePreviewedReport;
end;

{ TfrxDataLink }

procedure TfrxDataLink.Assign(Source: TPersistent);
begin
  if Source is TfrxDataLink then
  begin
    Link := TfrxDataLink(Source).Link;
    ProcessingType := TfrxDataLink(Source).ProcessingType;
    LoadingType := TfrxDataLink(Source).LoadingType;
  end;
end;

constructor TfrxDataLink.Create;
begin
 FLoadingType := [dltOnGetData];
 FProcessingType := dpString;
end;

destructor TfrxDataLink.Destroy;
begin

  inherited;
end;

function TfrxDataLink.Diff(const PropName: String; ADataLink: TfrxDataLink): String;
begin
  Result := '';
  if (dltOnPreview in FLoadingType) and (ADataLink.Link <> Link) then
    Result := Result + ' ' + PropName + '.Link="' + frxStrToXML(Link) + '"' + ' ' + PropName + '.LoadingType="' + IntToStr(Byte(LoadingType)) + '"';
end;

class function TfrxDataLink.GetLink(ADataLink: TfrxDataLink; LoadMethod: TfrxDataLinkLoadMethod): String;
begin
  if Assigned(ADataLink) and (((GetLoadType(LoadMethod) in ADataLink.LoadingType)) or (LoadMethod = dlmGetLink)) then
    Result := ADataLink.Link
  else
    Result := '';
end;

class function TfrxDataLink.GetLoadType(
  LoadMethod: TfrxDataLinkLoadMethod): TfrxDataLinkLoadType;
begin
  case LoadMethod of
    dlmOnGetData: Result := dltOnGetData;
  else
    Result := dltOnPreview;
  end;
end;

class function TfrxDataLink.IsDataLinkStored(ADataLink: TfrxDataLink;
  ComponentState: TfrxComponentState): Boolean;
begin
  Result := Assigned(ADataLink) and (ADataLink.Link <> '') and ((dltOnPreview in ADataLink.LoadingType) or not (csFrxSerializeToDict in ComponentState));
end;

class function TfrxDataLink.IsExpressionLink(ADataLink: TfrxDataLink): Boolean;
begin
  if Assigned(ADataLink) then
    Result := ADataLink.ProcessingType = dpExpression
  else
    Result := False;
end;

class procedure TfrxDataLink.RestoreState(ADataLink: TfrxDataLink);
begin
  if (ADataLink = nil) or (ADataLink.FProcessingType <> dpExpression) then Exit;
  ADataLink.FLink := ADataLink.FTempLink;
  ADataLink.FTempLink := '';
end;

class procedure TfrxDataLink.SaveState(ADataLink: TfrxDataLink);
begin
  if (ADataLink = nil) or (ADataLink.FProcessingType <> dpExpression) then Exit;
  ADataLink.FTempLink := ADataLink.FLink;
end;

procedure TfrxDataLink.SetLink(const Value: String);
begin
  if Value = FLink then Exit;
  FLink := Value;
  //FLastLink := FLink;
end;

{ TfrxStyleScheme }

function TfrxStyleSheets.Add: TfrxStyleSheetItem;
begin
  Result := TfrxStyleSheetItem(inherited Add);
  Result.Assign(FParentStyle);
end;

procedure TfrxStyleSheets.AddSheet(const AName: String);
var
  LSheetItem: TfrxStyleSheetItem;
begin
  LSheetItem := Add;
  LSheetItem.Name := AName;
end;

constructor TfrxStyleSheets.Create(AStyles: TfrxStyles; AParentStyle: TfrxStyleItem);
begin
  inherited Create(TfrxStyleSheetItem);
  FStyles := AStyles;
  FParentStyle := AParentStyle;
end;

procedure TfrxStyleSheets.DeleteByName(const AName: String);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, AName) = 0 then
    begin
      Delete(i);
      break;
    end;
end;

function TfrxStyleSheets.Find(const Name: String): TfrxStyleSheetItem;
begin
  Result := TfrxStyleSheetItem(InternalFind(Name));
end;

function TfrxStyleSheets.GetItem(Index: Integer): TfrxStyleSheetItem;
begin
  Result := TfrxStyleSheetItem(inherited GetItem(Index));
end;

function TfrxStyleSheets.GetSheetItem(const AName: String): TfrxStyleSheetItem;
begin
  if not(Assigned(FCachedItem) and (FCachedItem.Name = AName)) then
    FCachedItem := Find(AName);
  Result := FCachedItem
end;

procedure TfrxStyleSheets.UpdateSheets(AList: TStrings);
var
  I, LIndex: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    LIndex := AList.IndexOf(Items[I].Name);
    if LIndex < 0 then
      AList.Add(Items[I].Name);
  end;
  for I := 0 to AList.Count - 1 do
  begin
    if Find(AList[i]) = nil then
      AddSheet(AList[i]);
  end;
end;

{ TfrxNamedCollectionItem }

procedure TfrxNamedCollectionItem.CreateUniqueName;
var
  i: Integer;
begin
  i := 1;
  while TfrxNamedCollection(Collection).InternalFind('Style' + IntToStr(i)) <> nil do
    Inc(i);
  Name := 'Style' + IntToStr(i);
end;

function TfrxNamedCollectionItem.GetInheritedName: String;
begin
  if FName <> '' then
    Result := FName
  else
    Result := inherited GetInheritedName;
end;

procedure TfrxNamedCollectionItem.NameChange(const ANewName: string; const AOldName: string);
begin

end;

procedure TfrxNamedCollectionItem.SetName(const Value: String);
var
  Item: TfrxNamedCollectionItem;
begin
  Item := TfrxNamedCollection(Collection).InternalFind(Value);
  if Assigned(Item) and (Item  <> Self) then
    raise Exception.Create(frxResources.Get('clDupName'));

  if Value <> FName then
  begin
    NameChange(Value, FName);
    FName := Value;
  end;
end;


{ TfrxNamedCollection }

function TfrxNamedCollection.GetItem(Index: Integer): TfrxNamedCollectionItem;
begin
  Result := TfrxNamedCollectionItem(inherited GetItem(Index));
end;

function TfrxNamedCollection.InternalFind(
  const Name: String): TfrxNamedCollectionItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, Name) = 0 then
    begin
      Result := Items[i];
      break;
    end;
end;

{ TfrxStyleSchemeItem }

procedure TfrxStyleSheetItem.NameChange(const ANewName: string; const AOldName: string);
begin
  inherited;
  TfrxStyleSheets(Collection).FStyles.InternalSynchSheetName(ANewName, AOldName);
end;

{ TfrxCustomSignatureData }

constructor TfrxCustomSignatureData.Create;
begin
  FGraphicType := gtName;
  FNamePicture := TPicture.Create;

  FShowName := True;
  FShowLocation := True;
  FShowDate := True;
  FShowReason := True;
  FShowDistinguishedName := True;
  FShowProgramVersion := True;
  FShowLogo := True;
  FShowLabels := True;

  FRTL := False;
  FLogoPicture := TPicture.Create;
  FFRGraphic := GetFRGraphic;
end;

destructor TfrxCustomSignatureData.Destroy;
begin
  FNamePicture.Free;
  FLogoPicture.Free;
  FFRGraphic.Free;
  inherited;
end;

function TfrxCustomSignatureData.GetLogoPicture: TPicture;
begin
  if FLogoPicture.Graphic = nil then
    FLogoPicture.Graphic := FFRGraphic;
  Result := FLogoPicture;
end;

procedure TfrxCustomSignatureData.SetLogoPicture(const Value: TPicture);
begin
  FLogoPicture.Assign(Value);
end;

procedure TfrxCustomSignatureData.SetNamePicture(const Value: TPicture);
begin
  FNamePicture.Assign(Value);
end;

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxComponent, TControl);
  GroupDescendentsWith(TfrxDBComponents, TControl);
  GroupDescendentsWith(TfrxCustomCrypter, TControl);
  GroupDescendentsWith(TfrxCustomCompressor, TControl);
  GroupDescendentsWith(TfrxCustomExportFilter, TControl);
  GroupDescendentsWith(TfrxFrame, TControl);
  GroupDescendentsWith(TfrxHighlight, TControl);
  GroupDescendentsWith(TfrxStyleItem, TControl);

{$ENDIF}
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS := TCriticalSection.Create;
{$ENDIF}
  if frxDefaultIOTransportClass = nil then
    frxDefaultIOTransportClass := TfrxIOTransportFile;
  frxDefaultTempFilterClass := TfrxIOTransportFile;
  DatasetList := TfrxGlobalDataSetList.Create;
  frxGlobalVariables := TfrxVariables.Create;
  { create parent form for OLE and RICH controls in the main thread }
  {$IFNDEF FPC}
  frxParentForm;
  {$ENDIF}
  {$IFDEF Linux}
  if Widgetset <> nil then
  {$ENDIF}
  begin
  Screen.Cursors[crHand] := LoadCursor(hInstance, 'frxHAND');
  Screen.Cursors[crZoom] := LoadCursor(hInstance, 'frxZOOM');
  Screen.Cursors[crFormat] := LoadCursor(hInstance, 'frxFORMAT');
  end;
  RegisterClasses([
    TfrxChild, TfrxColumnFooter, TfrxColumnHeader, TfrxCustomMemoView, TfrxMasterData,
    TfrxDetailData, TfrxSubDetailData, TfrxDataBand4, TfrxDataBand5, TfrxDataBand6,
    TfrxDialogPage, TfrxFooter, TfrxFrame, TfrxGroupFooter, TfrxGroupHeader,
    TfrxHeader, TfrxHighlight, TfrxLineView, TfrxMemoView, TfrxOverlay, TfrxPageFooter,
    TfrxPageHeader, TfrxPictureView, TfrxReport, TfrxReportPage, TfrxReportSummary,
    TfrxReportTitle, TfrxShapeView, TfrxSubreport, TfrxSysMemoView, TfrxStyleItem,
    TfrxNullBand, TfrxCustomLineView, TfrxDataPage, TfrxDigitalSignatureView]);

  frxFR2Events := TfrxFR2Events.Create;

finalization
{$IFNDEF NO_CRITICAL_SECTION}
  frxCS.Free;
{$ENDIF}
  frxGlobalVariables.Free;
  DatasetList.Free;
  if FParentForm <> nil then
  begin
    EmptyParentForm;
    FParentForm.Free;
  end;
  FParentForm := nil;
  frxFR2Events.Free;
  FreeAndNil(RegEditorsClasses);
end.
