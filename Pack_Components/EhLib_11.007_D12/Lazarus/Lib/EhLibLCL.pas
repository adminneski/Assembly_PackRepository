{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{            Specific routines for VCL.Win32            }
{                                                       }
{    Copyright (c) 2004-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit EhLibLCL;

interface

uses
  Forms, SysUtils, DB, TypInfo, Controls, Messages,
  Generics.Defaults, Generics.Collections, Classes,
  {$IFDEF FPC}
    {$IFDEF FPC_LINUX}
      Gtk2Int, Gtk2Def, Gdk2,
    {$ENDIF}
    {$IFDEF FPC_WINDOWS}
      Windows, Win32WSForms, WSLCLClasses, Win32Int, Win32WSStdCtrls,
      Win32WSControls, Win32Proc, UxTheme, Win32Extra,
    {$ENDIF}
    {$IFDEF FPC_MACOS}
      MacOSAll, CocoaAll,
    {$ENDIF}
    LCLIntf, LCLType, WSStdCtrls, StdCtrls, LCLProc, LazUTF8, LMessages,
    XMLWrite, XMLRead, xmlutils, DOM,
  {$ELSE}
    RTLConsts, Windows, StdCtrls, UxTheme,
  {$ENDIF}
  ImgList, Graphics, Themes, Variants, Contnrs, StrUtils, Math, Types;

{$I EhlibVerInfo.Inc}
{$I EhLibEditionInfo.Inc}

type
  {$IFNDEF EH_LIB_16} //XE2
  IntPtr = NativeInt;
  {$ENDIF}

//{$IFDEF EH_LIB_9}
//  IntPtr = Integer;
//{$ELSE}
//  IntPtr = NativeInt;
//{$ENDIF}

{$IFDEF TBookMarkAsTBytes}
  TUniBookmarkEh = TBookmark;
{$ELSE}

  {$IFDEF EH_LIB_11}
  {$ELSE}
  TBytes = array of Byte;
  {$ENDIF}

  {$WARNINGS OFF}
  TUniBookmarkEh = TBookmarkStr;
  {$WARNINGS ON}
{$ENDIF}

{$IFNDEF EH_LIB_12}
  TRecordBuffer = PChar;
{$ENDIF}

{$IFNDEF EH_LIB_17}
  TValueBuffer = Pointer;
{$ENDIF}

  TPointArrayEh = array of TPoint;
  TDWORDArrayEh = array of DWORD;
  TVariantDynArray = array of Variant;
  TRectDynArray = array of TRect;
{$IFDEF EH_LIB_9}
{$ELSE}
  TStringDynArray  = array of String;
{$ENDIF}

{$IFDEF EH_LIB_16}
  TDataEventInfoTypeEh = NativeInt;
{$ELSE}
  {$IFDEF FPC}
  TDataEventInfoTypeEh = Ptrint;
  {$ELSE}
  TDataEventInfoTypeEh = Integer;
  {$ENDIF}
{$ENDIF}

{$IFNDEF EH_LIB_16}
  {$IFDEF WINDOWS}
  TLocaleID = LCID;
  {$ELSE}
  TLocaleID = LongWord;
  {$ENDIF}
{$ENDIF}

type

{$IFNDEF EH_LIB_16} //Delphi XE2
  TSizeF = record
    cx: Single;
    cy: Single;
  public
    property Width: Single read cx write cx;
    property Height: Single read cy write cy;
  end;

{$IFDEF FPC}
{$ELSE}
  TPointF = record
    x: Single;
    y: Single;
  end;

  TRectF = record
  case Integer of
    0: (Left, Top, Right, Bottom: Single);
    1: (TopLeft, BottomRight: TPointF);
  end;
{$ENDIF}

{$ENDIF} //EH_LIB_16 //Delphi XE2

{$IFNDEF EH_LIB_13} //Delphi 2010
  TArray<T> = array of T;
{$ENDIF} //EH_LIB_13 //Delphi 2010

{$IFDEF NEXTGEN}

  TFieldListEh = class(TList<TField>);

  TObjectListEh = class(TObjectList)
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;

    procedure Sort(Compare: TListSortCompare);
  end;

{$ELSE} // {NEXTGEN}

  TFieldListEh = class(TList);

  TObjectListEh = class(TObjectList)
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;

    procedure Sort(Compare: TListSortCompare);
  end;

{$ENDIF} // {ELSE NEXTGEN}

{$IFDEF FPC}
  TSortedListEh<T> = class(TSortedList<T>)
  end;
{$ELSE}
  TSortedListEh<T> = class(TList<T>)
  private
    FDuplicates: TDuplicates;

  public
    function Add(const Value: T): Integer;
    procedure Insert(Index: Integer; const Value: T);

    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
  end;
{$ENDIF}

const
{$IFDEF TBookMarkAsTBytes}
  NilBookmarkEh = nil;
{$ELSE}
  NilBookmarkEh = '';
{$ENDIF}

  LAYOUT_RTL_EH = $00000001;

{$IFDEF FPC_CROSSP}
  {$IFDEF WINDOWS}
  
  MA_NOACTIVATE = 3;
  {$ELSE}
  
  WM_CLEAR = LM_CLEAR;
  WM_RBUTTONDBLCLK = LM_RBUTTONDBLCLK;
  WM_MBUTTONDBLCLK = LM_MBUTTONDBLCLK;
  WM_RBUTTONDOWN = LM_RBUTTONDOWN;
  WM_MBUTTONDOWN = LM_MBUTTONDOWN;
  WM_LBUTTONUP = LM_LBUTTONUP;
  WM_RBUTTONUP = LM_RBUTTONUP;
  WM_MBUTTONUP = LM_MBUTTONUP;
  
  WM_CONTEXTMENU = LM_CONTEXTMENU;

  WM_NCMOUSEMOVE = LM_NCMOUSEMOVE; 
  WM_NCCALCSIZE = LM_NCCALCSIZE; 
  WM_WINDOWPOSCHANGING = LM_WINDOWPOSCHANGING; 
  WM_MOUSEACTIVATE = 33; 
  MA_NOACTIVATE = 3; 
  WM_SETTINGCHANGE = 26; 
  {$ENDIF}
  WM_THEMECHANGED = CM_BASE + 81;  
  
{$ELSE}
 
 
{$ENDIF}

{$IFDEF FPC_CROSSP}
  {$IFDEF FPC_WINDOWS}
type
  TWMChar = TLMChar;
  TWMRButtonDblClk = TLMRButtonDblClk;
  TWMMButtonDblClk = TLMMButtonDblClk;
  TWMRButtonDown = TLMRButtonDown;
  TWMMButtonDown = TLMMButtonDown;
  TWMRButtonUp = TLMRButtonUp;
  TWMMButtonUp = TLMMButtonUp;
  TWMLButtonDblClk = TLMLButtonDblClk;
  TWMLButtonDown = TLMLButtonDown;
  TWMLButtonUp = TLMLButtonUp;
  TWMMouseMove = TLMMouseMove;
  TWMKeyDown    = TWMKey;
  PWindowPos = Windows.PWindowPos;
  {$ELSE} //LINUX
type
  TWMRButtonDblClk = TLMRButtonDblClk;
  TWMMButtonDblClk = TLMMButtonDblClk;
  TWMRButtonDown = TLMRButtonDown;
  TWMMButtonDown = TLMMButtonDown;
  TWMRButtonUp = TLMRButtonUp;
  TWMMButtonUp = TLMMButtonUp;
  TWMNCCalcSize = TLMNCCalcSize;
  TWMWindowPosChanging = TLMWindowPosChanging;
  

  TPanose = record
    bFamilyType: Byte;
    bSerifStyle: Byte;
    bWeight: Byte;
    bProportion: Byte;
    bContrast: Byte;
    bStrokeVariation: Byte;
    bArmStyle: Byte;
    bLetterform: Byte;
    bMidline: Byte;
    bXHeight: Byte;
  end;

  TOutlineTextmetric = record
  private
    //function GetFaceName: LPWSTR;
    //function GetFamilyName: LPWSTR;
    //function GetFullName: LPWSTR;
    //function GetStyleName: LPWSTR;
  public
    otmSize: UINT;
    otmTextMetrics: TTextMetric;
    otmFiller: Byte;
    otmPanoseNumber: TPanose;
    otmfsSelection: UINT;
    otmfsType: UINT;
    otmsCharSlopeRise: Integer;
    otmsCharSlopeRun: Integer;
    otmItalicAngle: Integer;
    otmEMSquare: UINT;
    otmAscent: Integer;
    otmDescent: Integer;
    otmLineGap: UINT;
    otmsCapEmHeight: UINT;
    otmsXHeight: UINT;
    otmrcFontBox: TRect;
    otmMacAscent: Integer;
    otmMacDescent: Integer;
    otmMacLineGap: UINT;
    otmusMinimumPPEM: UINT;
    otmptSubscriptSize: TPoint;
    otmptSubscriptOffset: TPoint;
    otmptSuperscriptSize: TPoint;
    otmptSuperscriptOffset: TPoint;
    otmsStrikeoutSize: UINT;
    otmsStrikeoutPosition: Integer;
    otmsUnderscoreSize: Integer;
    otmsUnderscorePosition: Integer;
    //otmpFamilyName: LPSTR; // Offset from the beginning of the structure
    //otmpFaceName: LPSTR;   // Offset from the beginning of the structure
    //otmpStyleName: LPSTR;  // Offset from the beginning of the structure
    //otmpFullName: LPSTR;   // Offset from the beginning of the structure
    //property FaceName: LPWSTR read GetFaceName;
    //property FamilyName: LPWSTR read GetFamilyName;
    //property FullName: LPWSTR read GetFullName;
    //property StyleName: LPWSTR read GetStyleName;
  end;
  {$ENDIF}
{$ELSE}
{$ENDIF}

{$IFDEF FPC}
const
  STextTrue: String = 'True';
  STextFalse: String = 'False';
  FilerSignature: array[1..4] of Char = 'TPF0';

type
  TCustomData = Pointer;

  TTextFormats = (tfBottom, tfCalcRect, tfCenter, tfEditControl, tfEndEllipsis,
    tfPathEllipsis, tfExpandTabs, tfExternalLeading, tfLeft, tfModifyString,
    tfNoClip, tfNoPrefix, tfRight, tfRtlReading, tfSingleLine, tfTop,
    tfVerticalCenter, tfWordBreak, tfHidePrefix, tfNoFullWidthCharBreak,
    tfPrefixOnly, tfTabStop, tfWordEllipsis, tfComposited);
  TTextFormat = set of TTextFormats;

  __TObject = class(TObject);
  __Int = PtrInt;
  IXMLNode = interface;

  TStreamOriginalFormat = (sofUnknown, sofBinary, sofText);

  TDropDownAlign = (daLeft, daRight, daCenter);

  TSearchType = (stWholeWord, stMatchCase);
  TSearchTypes = set of TSearchType;

{ TWinControlEh }

  TWinControlEh = class(TWinControl)
  protected
    procedure RecreateWndHandle;
  end;

{ TCustomControlEh }

  TCustomControlEh = class(TCustomControl)
  private
    FScaleFactor: Single;
  protected
    procedure RecreateWndHandle;

    procedure ChangeScale(M, D: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;

    function GetSystemMetrics(nIndex: Integer): Integer;
    function ScaleValue(const Value: Integer): Integer;
    function IsCustomStyleActive: Boolean; virtual;

    property ScaleFactor: Single read FScaleFactor;

  end;

  TXMLDocOption = (doNodeAutoCreate, doNodeAutoIndent, doAttrNull,
    doAutoPrefix, doNamespaceDecl, doAutoSave);
  TXMLDocOptions = set of TXMLDocOption;

  IRefObject = interface
    ['{D1E0064F-497C-4BC6-A72B-690394EB64FB}']
    function GetObject: TObject;
  end;

  IXMLNodeList = interface
    ['{395950C1-7E5D-11D4-83DA-00C04F60B2DD}']
    function GetCount: Integer;
    function Add(const Node: IXMLNode): Integer;
    function FindNode(NodeName: String): IXMLNode;
    function Delete(const Name: String): Integer;
    procedure Insert(Index: Integer; const Node: IXMLNode);
    function GetNode(const IndexOrName: OleVariant): IXMLNode;
  { Property Accessors }
    property Count: Integer read GetCount;
    property Nodes[const IndexOrName: OleVariant]: IXMLNode read GetNode; default;
  end;

  IXMLNode = interface
    ['{395950C0-7E5D-11D4-83DA-00C04F60B2DD}']
    function GetAttribute(const AttrName: String): OleVariant;
    procedure SetAttribute(const AttrName: String; const Value: OleVariant);
    function GetChildNodes: IXMLNodeList;
    function GetText: String;
    procedure SetText(const Value: String);
    function AddChild(const TagName: String; Index: Integer = -1): IXMLNode; overload;
    function AddChild(const TagName, NamespaceURI: String; GenPrefix: Boolean = False; Index: Integer = -1): IXMLNode; overload;
    function GetParentNode: IXMLNode;
    function  GetNodeName: String;
    function  GetNodeValue: String;
    procedure SetNodeValue(const AValue: String);
    procedure DeclareNamespace(const Prefix, URI: String);
  { Properties }
    property Attributes[const AttrName: String]: OleVariant read GetAttribute write SetAttribute;
    property ChildNodes: IXMLNodeList read GetChildNodes;
    property Text: String read GetText write SetText;
    property NodeName: String read GetNodeName;
    property NodeValue: String read GetNodeValue write SetNodeValue;
  end;

  IXMLDocument = interface(IInterface)
    ['{395950C3-7E5D-11D4-83DA-00C04F60B2DD}']
    function GetOptions: TXMLDocOptions;
    procedure SetOptions(const Value: TXMLDocOptions);
    function GetEncoding: String;
    procedure SetEncoding(const Value: String);
    function GetStandAlone: String;
    procedure SetStandAlone(const Value: String);
    procedure SaveToFile(const AFileName: String);
    procedure SaveToStream(const Stream: TStream);
    function AddChild(const TagName: String): IXMLNode; overload;
    function AddChild(const TagName, NamespaceURI: String): IXMLNode; overload;
    function CreateElement(const TagOrData, NamespaceURI: String): IXMLNode;
    function GetDocumentElement: IXMLNode;
    function GetChildNodes: IXMLNodeList;

    { Properties }
    property ChildNodes: IXMLNodeList read GetChildNodes;
    property Options: TXMLDocOptions read GetOptions write SetOptions;
    property Encoding: String read GetEncoding write SetEncoding;
    property StandAlone: String read GetStandAlone write SetStandAlone;
    property DocumentElement: IXMLNode read GetDocumentElement;
  end;

{ TXMLNodeListEh }

  TXMLNodeListEh = class(TInterfacedObject, IXMLNodeList)
  private
    FDOMElement: TDOMElement;

    function GetCount: Integer;
    function Add(const Node: IXMLNode): Integer;
    function FindNode(NodeName: String): IXMLNode;
    function Delete(const Name: String): Integer;
    procedure Insert(Index: Integer; const Node: IXMLNode);
    function GetNode(const IndexOrName: OleVariant): IXMLNode;

  public
    constructor Create(ADOMElement: TDOMElement);
    destructor Destroy; override;

  end;

{ TXMLNodeEh }

  TXMLNodeEh = class(TInterfacedObject, IXMLNode, IRefObject)
  private
    FDOMElement: TDOMElement;

    function AddChild(const TagName: String; Index: Integer = -1): IXMLNode;  overload;
    function AddChild(const TagName, NamespaceURI: String; GenPrefix: Boolean = False; Index: Integer = -1): IXMLNode;  overload;
    function GetParentNode: IXMLNode;
    function GetAttribute(const AttrName: String): OleVariant;
    function GetChildNodes: IXMLNodeList;
    function GetText: String;
    function  GetNodeName: String;
    function  GetNodeValue: String;
    procedure DeclareNamespace(const Prefix, URI: String);
    procedure SetNodeValue(const AValue: String);

    procedure SetAttribute(const AttrName: String; const Value: OleVariant);
    procedure SetText(const Value: String);

    function GetObject: TObject;

  public
    constructor Create(ADOMElement: TDOMElement);
    destructor Destroy; override;

  end;

{ TXMLDocumentEh }

  TXMLDocumentEh = class(TInterfacedObject, IXMLDocument)
  private
    FXMLDoc: TXMLDocument;

    function GetOptions: TXMLDocOptions;
    function GetEncoding: String;
    function GetStandAlone: String;
    function GetChildNodes: IXMLNodeList;
    function AddChild(const TagName: String): IXMLNode; overload;
    function AddChild(const TagName, NamespaceURI: String): IXMLNode; overload;
    function CreateElement(const TagOrData, NamespaceURI: String): IXMLNode;
    function GetDocumentElement: IXMLNode;

    procedure SetOptions(const Value: TXMLDocOptions);
    procedure SetEncoding(const Value: String);
    procedure SetStandAlone(const Value: String);
    procedure SaveToFile(const AFileName: String);
    procedure SaveToStream(const Stream: TStream);

  public
    constructor Create; overload;
    constructor Create(AXMLDoc: TXMLDocument); overload;
    destructor Destroy; override;
  end;

function NewXMLDocument(Version: DOMString = '1.0'): IXMLDocument;

function DrawTextBiDiModeFlags(Control: TControl; Flags: Longint): Longint;
procedure PerformEraseBackground(Control: TControl; DC: HDC);

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): Boolean;

function DBUseRightToLeftAlignment(AControl: TControl; AField: TField): Boolean;
function OkToChangeFieldAlignment(AField: TField; Alignment: TAlignment): Boolean;

function VarTypeToDataType(VarType: Integer): TFieldType;
function TestStreamFormat(Stream: TStream): TStreamOriginalFormat;
function GetFieldProperty(DataSet: TDataSet; Control: TComponent; const FieldName: string): TField;

{$ELSE} //FPC
type

{$IFDEF EH_LIB_12} //RAD Studio 2009
{$ELSE}
{ TBitmapEh32bit }

  TBitmapEh32bit = class(TBitmap)
  public
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
  end;
{$ENDIF}

{$IFDEF NEXTGEN}
{$ELSE}
 __TObject = class(TObject);
 __Int = Integer;
{$ENDIF}

{$IFNDEF EH_LIB_12}
  Int32 = Integer;
{$ENDIF}

{ TWinControlEh }

  TWinControlEh = class(TWinControl)
  private
  protected
  {$IFDEF FPC}
    function Ctl3D;
  {$ELSE}
  {$ENDIF}
    procedure RecreateWndHandle;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TCustomControlEh }

  TCustomControlEh = class(TCustomControl)
  protected
  {$IFDEF EH_LIB_26} //10.3
  {$ELSE}
    FScaleFactor: Single;
  {$ENDIF}

    procedure RecreateWndHandle;
    procedure ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF}); override;
  public
    constructor Create(AOwner: TComponent); override;

  {$IFDEF EH_LIB_26} //10.3
  {$ELSE}
    function GetSystemMetrics(nIndex: Integer): Integer;
    property ScaleFactor: Single read FScaleFactor;
  {$ENDIF}

  {$IFDEF EH_LIB_27} //10.4
  {$ELSE}
    function ScaleValue(const Value: Integer): Integer;
    function IsCustomStyleActive: Boolean; virtual;
  {$ENDIF}
  end;

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; flags: UINT): Boolean;

{$ENDIF} //ELSE FPC

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;
function VarToAnsiStr(const V: Variant): AnsiString;
function IsLeadCharEh(C: Char): Boolean;

procedure FillDWord(var Dest; Count, Value: Integer);

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;

type
  TTextWrapStyleEh = (twsNoWrapEh, twsWordWrapEh, twsSingleLineEh);

{ TDrawTextOptionsEh }

  TDrawTextOptionsEh = record
    HorzAlignment: TAlignment;
    VertAlignment: TVerticalAlignment;
    WrapStyle: TTextWrapStyleEh;
    FillBack: Boolean;
    BiDiMode: TBiDiMode;
    //RightToLeft: Boolean;
    EndEllipsis: Boolean;
    RotationAngle: Single;

    procedure Clear;
  end;

function DrawTextEh(hDC: HDC; const Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer; overload;

procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect; ClipRect: TRect;
  var Options: TDrawTextOptionsEh); overload;
procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect; ClipRect: TRect;
  Alignment: TAlignment; Layout: TTextLayout; WrapStyle: TTextWrapStyleEh; FillBack: Boolean = False); overload;
procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect;
  Alignment: TAlignment; Layout: TTextLayout; WrapStyle: TTextWrapStyleEh; FillBack: Boolean = False); overload;
procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect; FillBack: Boolean = False); overload;

function GetTextExtentPointEh(Canvas: TCanvas; Text: String; out StringSize: TSize): TIntegerDynArray; overload;
//{$IFDEF FPC_WINDOWS}
//function GetTextExtentPointEh(Canvas: TCanvas; Text: WideString; out StringSize: TSize): TIntegerDynArray; overload;
//{$ELSE}
//{$ENDIF}

function StrLength(s: String): Integer; overload;
//function StrLength(s: WideString): Integer; overload;
function StringNextCharPos(S: String; APos: Integer): Integer;

function EditorGetCaretPosEh(Control: TWinControl): Integer;
function GetMessageTimeEh: Longint;
function RGBToColorEh(R, G, B: Byte): TColor;
procedure GetRGB(Col: TColor; var R, G, B: Byte);

procedure SetWindowDropShadowStyle(Control: TWinControl; var Params: TCreateParams; SetState: Boolean);
procedure SetWindowDropDownNoactivateStyle(Control: TWinControl; var Params: TCreateParams; SetState: Boolean);
function GetAdjustedClientRect(Control: TWinControl): TRect;
function GetDesktopWindowEh: HWnd;

{$IFDEF FPC_CROSSP}
function GetNearestColor(hDC: HDC; Color: TColor): TColor;
{$ENDIF}

{$IFDEF WINDOWS}
function WindowsDrawTextEx(DC: HDC; const lpchText: String;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
function WindowsDrawTextEx(DC: HDC; const lpchText: String;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; const Str: String; Count: Longint{; Dx: PInteger}): BOOL;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;
{$ELSE}
{$ENDIF}

function MiddleDotChar: Char;

function SendStructMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
function SendTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; const lParam: string): LRESULT;
function SendGetTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam: string; BufferSize: Integer): LRESULT;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam; fWinIni: UINT): BOOL;
function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;
procedure WinServiceSetFocus(hWnd: HWND);
function  WinServiceIsChild(hWndParent, hWnd: HWND): Boolean;

function WindowsLPtoDP(DC: HDC; var ARect: TRect): BOOL;
function WindowsCreatePolygonRgn(Points: array of TPoint; Count, FillMode: Integer): HRGN;
function GetFontSize(Font: TFont): Integer;
function GetFontHeight(Font: TFont): Integer;
function GetFontTextHeight(Canvas: TCanvas; Font: TFont; IncludeExternalLeading: Boolean = True): Integer;
procedure GetTextMetricsEh(Canvas: TCanvas; out tm: TTextMetric); overload;
procedure GetTextMetricsEh(AFontName: String; AFontSize: Integer; AFontStyle: TFontStyles; out tm: TTextMetric); overload;
procedure PolyPolyLineEh(Canvas: TCanvas; const PointsList: TPointArrayEh; const StrokeList: TDWORDArrayEh; VCount: Integer);

function IsObjectAndIntegerRefSame(AObject: TObject; IntRef: IntPtr): Boolean;
function IntPtrToObject(AIntPtr: IntPtr): TObject;
function ObjectToIntPtr(AObject: TObject): IntPtr;
function IntPtrToString(AIntPtr: IntPtr): String;

procedure VarToMessage(var VarMessage; var Message: TMessage);
function MessageToTMessage(var Message): TMessage;
function MessageToTWMMouse(var Message): TWMMouse;
function MessageToTWMKey(var Message): TWMKey;
function UnwrapMessageEh(var Message): TMessage;
procedure PostQuitMessageEh(nExitCode: Integer);

function SmallPointToInteger(SmallPoint: TSmallPoint): Integer;
function LongintToSmallPoint(Value: Longint): TSmallPoint;

procedure MessageSendGetSel(hWnd: HWND; var SelStart, SelEnd: Integer);
procedure EditControlSetSel(Control: TCustomEdit; SelStart, SelEnd: Integer);

function NlsUpperCase(const S: String): String;
function NlsLowerCase(const S: String): String;
function NlsCompareStr(const S1, S2: String): Integer;
function NlsCompareText(const S1, S2: String): Integer;

{$IFNDEF EH_LIB_9}
function ReplaceStr(const AText, AFromText, AToText: string): string;
{$ENDIF}

{$IFDEF NEXTGEN}
{$ELSE}
function WideStringCompare(const ws1, ws2: WideString; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
function AnsiStringCompare(const s1, s2: String; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
{$ENDIF}

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;

type
  TPropListArray = array of PPropInfo;

function GetPropListAsArray(ATypeInfo: PTypeInfo; TypeKinds: TTypeKinds): TPropListArray;

function HexToBinEh(Text: Pointer; out Buffer: TBytes; CharCount: Integer): Integer; overload;
function HexToBinEh(Text: String; out Buffer: TBytes; CharCount: Integer): Integer; overload;

procedure BinToHexEh(Buffer: TBytes; out Text: String; Count: Integer);

procedure StreamWriteBytes(Stream: TStream; Buffer: TBytes);
procedure StreamReadBytes(Stream: TStream; var Buffer: TBytes; Count: Integer);

{$IFNDEF EH_LIB_12}
function BytesOf(S: String): TBytes; overload;
{$ENDIF}

{$IFNDEF EH_LIB_17}
function BytesOf(const Val: Pointer; const Len: integer): TBytes; overload;
{$ENDIF}

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
function PropInfo_getName(APropInfo: PPropInfo): String;
function PropType_getKind(APropType: PTypeInfo): TTypeKind;

function GetEnumPropValueAsString(Instance: TObject; const PropName: string): String;
procedure SetEnumPropValueAsString(Instance: TObject; const PropName: string; AValue: String);

procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);

function GetUltimateOwner(APersistent: TPersistent): TPersistent;

function EmptyRect: TRect;
function IsRectEmptyEh(const Rect: TRect): Boolean;

function VariantToRefObject(VarValue: Variant): TObject;
function RefObjectToVariant(ARefObject: TObject): Variant;
procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);
function VarTypeName(varValue: Variant): String;
function RemoveLineBreaksFromText(Text: String): String;

type

{ TFilerAccess }

  TFilerAccess = class(TInterfacedObject) 
  private
    FPersistent: TPersistent;
  public
    constructor Create(APersistent: TPersistent);
    procedure DefineProperties(AFiler: TFiler);
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);
    function GetChildOwner: TComponent;
    function GetChildParent: TComponent;
    procedure SetAncestor(Value: Boolean);
    procedure SetChildOrder(Child: TComponent; Order: Integer);
    procedure Updated;
    procedure Updating;
  end;

{ TMemoryStreamEh }

  TMemoryStreamEh = class(TMemoryStream)
  private
    FHalfMemoryDelta: Integer;
  protected
    {$IFDEF FPC}
    function Realloc(var NewCapacity: PtrInt): Pointer; override;
    {$ELSE}
      {$IFDEF EH_LIB_28}
    function Realloc(var NewCapacity: NativeInt): Pointer; override;
      {$ELSE}
    function Realloc(var NewCapacity: System.Longint): Pointer; override;
    {$ENDIF}
    {$ENDIF}
  public
    constructor Create;
    property HalfMemoryDelta: Integer read FHalfMemoryDelta write FHalfMemoryDelta;
  end;

function ExplicitLongwordToLongInt(v: Longword): LongInt;
function WStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;

function SafeGetMouseCursorPos: TPoint;

procedure VarSetNull(var V: Variant); {$IFDEF EH_LIB_8} inline;{$ENDIF}
function VarIsNullEh(const V: Variant): Boolean; {$IFDEF EH_LIB_8} inline;{$ENDIF}

{$IFNDEF EH_LIB_14}
function PointToLParam(P: TPoint): LPARAM;
{$ENDIF}

function StringToLParam(s: String): LPARAM;

{$IFNDEF EH_LIB_16} //Delphi XE2

type

  TElementSize = (esMinimum, esActual, esStretch);

{ TCustomStyleServicesProxyEh }

  TCustomStyleServicesProxyEh = class(TObject)
  public
    function GetSystemColor(Color: TColor): TColor;
    {$IFDEF FPC}
    {$ELSE}
    function GetElementSize(DC: HDC; Details: TThemedElementDetails; ElementSize: TElementSize; out Size: TSize): Boolean;
    {$ENDIF}
  end;

function StyleServices: TCustomStyleServicesProxyEh;

{$ENDIF}

{$IFNDEF EH_LIB_17} //Delphi XE3

type

{ TFormatSettingsProxyEh }

  TFormatSettingsProxyEh = class(TObject)
  private
    function GetDecimalSeparator: Char;
    function GetDateSeparator: Char;
    function GetTimeSeparator: Char;
    function GetThousandSeparator: Char;
    function GetShortDateFormat: String;
    function GetLongDateFormat: String;
    function GetLongTimeFormat: String;
    function GetCurrencyDecimals: Byte;
    function GetShortMonthNames(Index: Integer) : String;
    function GetLongMonthNames(Index: Integer) : String;
    function GetShortDayNames(Index: Integer) : String;
    function GetLongDayNames(Index: Integer) : String;
    function GetTwoDigitYearCenturyWindow: Word;
    function GetShortTimeFormat: String;
    function GetTimeAMString: String;
    function GetTimePMString: String;

    procedure SetCurrencyDecimals(Value: Byte);
    procedure SetDateSeparator(Value: Char);
    procedure SetDecimalSeparator(Value: Char);
    procedure SetLongDateFormat(Value: String);
    procedure SetLongDayNames(Index: Integer; Value: String);
    procedure SetLongMonthNames(Index: Integer; Value: String);
    procedure SetLongTimeFormat(Value: String);
    procedure SetShortDateFormat(Value: String);
    procedure SetShortDayNames(Index: Integer; Value: String);
    procedure SetShortMonthNames(Index: Integer; Value: String);
    procedure SetShortTimeFormat(const Value: String);
    procedure SetThousandSeparator(Value: Char);
    procedure SetTimeAMString(const Value: String);
    procedure SetTimePMString(const Value: String);
    procedure SetTimeSeparator(Value: Char);
    procedure SetTwoDigitYearCenturyWindow(Value: Word);
  public
    property DecimalSeparator: Char read GetDecimalSeparator write SetDecimalSeparator;
    property DateSeparator: Char read GetDateSeparator write SetDateSeparator;
    property TimeSeparator: Char read GetTimeSeparator write SetTimeSeparator;
    property CurrencyDecimals: Byte read GetCurrencyDecimals write SetCurrencyDecimals;
    property ThousandSeparator: Char read GetThousandSeparator write SetThousandSeparator;
    property ShortDateFormat: String read GetShortDateFormat write SetShortDateFormat;
    property ShortTimeFormat: String read GetShortTimeFormat write SetShortTimeFormat;
    property LongDateFormat: String read GetLongDateFormat write SetLongDateFormat;
    property LongTimeFormat: String read GetLongTimeFormat write SetLongTimeFormat;

    property ShortMonthNames[Value: Integer] : String read GetShortMonthNames write SetShortMonthNames;
    property LongMonthNames[Value: Integer] : String read GetLongMonthNames write SetLongMonthNames;
    property ShortDayNames[Value: Integer] : String read GetShortDayNames write SetShortDayNames;
    property LongDayNames[Value: Integer] : String read GetLongDayNames write SetLongDayNames;
    property TimeAMString: String read GetTimeAMString write SetTimeAMString;
    property TimePMString: String read GetTimePMString write SetTimePMString;

    property TwoDigitYearCenturyWindow: Word read GetTwoDigitYearCenturyWindow write SetTwoDigitYearCenturyWindow;
  end;

function FormatSettings: TFormatSettingsProxyEh;

{$ENDIF}

function FirstDayOfWeekEh(): Integer; 

{$IFNDEF EH_LIB_12} //CodeGear RAD Studio 2009

type

{$IFDEF FPC}
{$ELSE}
{ TEncoding }

  TEncoding = class
  public
    class function ANSI: TEncoding;
    class function Default: TEncoding;

    function GetBytes(const S: string): TBytes;
    function GetPreamble: TBytes; virtual;
  end;
{$ENDIF}

 { TStreamWriter }

  TStreamWriter = class(TObject)
  private
    FStream: TStream;
  public
    constructor Create(Stream: TStream; Encoding: TEncoding);
    destructor Destroy; override;
    procedure Write(Value: Boolean); overload;
    procedure Write(Value: Char); overload;
    procedure Write(const Value: string); overload;
  end;

{ TStreamReader }

  TStreamReader = class(TObject)
  private
    FStream: TStream;
    function GetEndOfStream: Boolean;
  public
    constructor Create(Stream: TStream; Encoding: TEncoding; DetectBOM: Boolean = False);
    destructor Destroy; override;
    function Peek: Integer;
    function Read: Integer;
    property EndOfStream: Boolean read GetEndOfStream;
  end;

{ TStringBuilder }

  TStringBuilder = class
  private
    FStringStream: TStringStream;
    function GetLength: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function Append(const Value: string): TStringBuilder; overload;
    function Append(const Value: Char; RepeatCount: Integer): TStringBuilder; overload;
    {$IFDEF FPC}
    function ToString: string; reintroduce;
    {$ELSE}
    function ToString: string;
    {$ENDIF}
    procedure Clear;

    property Length: Integer read GetLength;
  end;

{ TBytesStream }

  TBytesStream = class(TMemoryStream)
  private
    FBytes: TBytes;
  protected
    {$IFDEF FPC}
    function Realloc(var NewCapacity: PtrInt): Pointer; override;
    {$ELSE}
    function Realloc(var NewCapacity: System.Longint): Pointer; override;
    {$ENDIF}
  public
    constructor Create(const ABytes: TBytes); overload;
    property Bytes: TBytes read FBytes;
  end;

{$ENDIF} //EH_LIB_12} //CodeGear RAD Studio 2009

function SetLayoutEh(hdc: HDC; dwLayout: DWORD): DWORD;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
function SmallPointToPointEh(const P: TSmallPoint): TPoint;
function GetTickCountEh: Int64;

{$IFNDEF EH_LIB_12} //CodeGear RAD Studio 2009
function RectWidth(const Rect: TRect): Integer;
function RectHeight(const Rect: TRect): Integer;
{$ENDIF}

function RectSize(const Rect: TRect): TSize;
function RectContains(const Rect: TRect; const P: TPoint): Boolean;
function CreateRect(Left, Top, Right, Bottom: Integer): TRect;

function RectF(ALeft, ATop, ARight, ABottom: Single): TRectF;
function RectFWidth(const Rect: TRectF): Single;
function RectFHeight(const Rect: TRectF): Single;
function PointF(x: Single; y: Single): TPointF;

function CreatePoint(x, y: Integer): TPoint;
function CreateSize(cx, cy: Longint): TSize;

{$IFNDEF EH_LIB_13}
function CenteredRect(const SourceRect: TRect; const ACenteredRect: TRect): TRect;
{$ENDIF}

function ChangeRect(const Rect: TRect; ChangeLeft, ChangeTop, ChangeRight, ChangeBottom: Integer): TRect;
procedure MoveRect(var Rect: TRect; Left, Top: Integer); overload;
procedure MoveRect(var Rect: TRect; Pos: TPoint); overload;
function RightToLeftReflectPoint(const BaseRect: TRect; const APoint: TPoint): TPoint;
function RightToLeftReflectRect(const BaseRect: TRect; const ARect: TRect): TRect;

function LoadCursorEh(hInstance: HINST; lpCursorName: PChar): HCURSOR;
function LoadRegisterCursorEh(CursorName: String): TCursor;

procedure OutputDebugStringEh(str: String);
procedure FreeObjectEh(obj: TObject);
procedure DoNothing();
function SysStrToFloat(const S: string): Extended;
function SysFloatToStr(const Val: Extended): string;
function GetCanvasScaleForStandardDpi(Canvas: TCanvas): Double;
procedure FillRectEh(ACanvas: TCanvas; ARect: TRect; AColor: TColor; ATransparencyLevel: Integer);
function ImListImageToBitmap(ImageList: TCustomImageList; ImageIndex: Integer): TBitmap;

implementation

{$IFDEF EH_LIB_27} 
uses
  GraphUtil;
{$ELSE}
{$ENDIF}

var
  BackBitmap: TBitmap;

{$IFDEF FPC}
{$ELSE}
const
  PixelsQuad = MaxInt div SizeOf(TRGBQuad) - 1;
type
  TRGBAArray = Array [0..PixelsQuad - 1] of TRGBQuad;
  PRGBAArray = ^TRGBAArray;
{$ENDIF}

function ImListImageToBitmap(ImageList: TCustomImageList; ImageIndex: Integer): TBitmap;
var
  {$IFDEF ImageListGetBitmap}
  {$ELSE}
  ARGBVal: TRGBQuad;
  pscanLine32, pscanLine32_src: PRGBAArray;
  il, ip: Integer;
  SrcBitmap: TBitmap;
  SrcStartLine: Integer;
  PicsPreLine: Integer;
  StartInLine: Integer;
  TmpBitmap: TBitmap;
  PixelFormat: TPixelFormat;
  {$ENDIF}

  ResultBitmap: TBitmap;
begin
{$IFDEF ImageListGetBitmap}
  if (ImageIndex >= ImageList.Count) then
  begin
    Result := nil;
    Exit;
  end else
  begin
    ResultBitmap := TBitmap.Create();
//    {$IFDEF CROSSVCL}
//    ResultBitmap.SetSize(ImageList.Width, ImageList.Height);
//    ResultBitmap.AlphaFormat := afDefined;
//    ClearRectWithAlpha(ResultBitmap.Canvas.Handle, Rect(0, 0, ResultBitmap.Width, ResultBitmap.Height), 0, 0);
//    {$ENDIF}
    ImageList.GetBitmap(ImageIndex, ResultBitmap);
    Result := ResultBitmap;
  end;
{$ELSE} 

  TmpBitmap := TBitmap.Create;
  TmpBitmap.Handle := ImageList.GetImageBitmap;
  PixelFormat := TmpBitmap.PixelFormat;
  TmpBitmap.Free;

  if (PixelFormat <> pf32bit) then
  begin
    Result := TBitmap.Create();
    ImageList.GetBitmap(ImageIndex, Result);
    Exit;
  end;

{$IFDEF EH_LIB_12} 
  ResultBitmap := TBitmap.Create();
{$ELSE}
  ResultBitmap := TBitmapEh32bit.Create();
{$ENDIF}

  SrcBitmap := TBitmap.Create;
  SrcBitmap.Handle := ImageList.GetImageBitmap;

  ResultBitmap.Width := ImageList.Width;
  ResultBitmap.Height := ImageList.Height;
  ResultBitmap.PixelFormat := pf32bit;

{$IFDEF EH_LIB_12} 
  ResultBitmap.AlphaFormat := afDefined; 
{$ENDIF}

  PicsPreLine := SrcBitmap.Width div ImageList.Width;
  StartInLine := ImageIndex mod PicsPreLine * ImageList.Width;
  SrcStartLine := ImageIndex div PicsPreLine * ImageList.Height;
  for il := 0 to ImageList.Height - 1 do
  begin
    pscanLine32_src := SrcBitmap.ScanLine[il + SrcStartLine];
    pscanLine32 := ResultBitmap.Scanline[il];
    for ip := 0 to ImageList.Width - 1 do
      begin
        ARGBVal.rgbReserved := pscanLine32_src[ip + StartInLine].rgbReserved;
        ARGBVal.rgbBlue := pscanLine32_src[ip + StartInLine].rgbBlue;
        ARGBVal.rgbRed := pscanLine32_src[ip + StartInLine].rgbRed;
        ARGBVal.rgbGreen := pscanLine32_src[ip + StartInLine].rgbGreen;
        pscanLine32[ip] := ARGBVal;
      end;
  end;

  SrcBitmap.Free;

  Result := ResultBitmap;
  
{$ENDIF} 
end;

procedure FillRectEh(ACanvas: TCanvas; ARect: TRect; AColor: TColor; ATransparencyLevel: Integer);
var
  rw, rh: Integer;
  {$IFDEF FPC}
    {$IFDEF FPC_WINDOWS}
  bf: TBlendFunction;
    {$ELSE}
    {$ENDIF}
  {$ELSE}
  bf : BLENDFUNCTION;
  {$ENDIF}
begin

  rw := RectWidth(ARect);
  rh := RectHeight(ARect);

  if (BackBitmap = nil) then
  begin
    BackBitmap := TBitmap.Create;
    BackBitmap.Width := rw;
    BackBitmap.Height := rh;
  end;

  if (BackBitmap.Width < rw) or (BackBitmap.Height < rh) then
  begin
    BackBitmap.Width := rw;
    BackBitmap.Height := rh;
  end;

  BackBitmap.Canvas.Brush.Color := AColor;
  BackBitmap.Canvas.FillRect(Rect(0, 0, rw, rh));

  {$IFDEF FPC}
    {$IFDEF FPC_WINDOWS}
  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  bf.SourceConstantAlpha := ATransparencyLevel; //0 - 255
  bf.AlphaFormat := 0;

  Win32Extra.AlphaBlend(ACanvas.Handle,
    ARect.Left, ARect.Top, rw, rh,
    BackBitmap.Canvas.Handle,
    0, 0, rw, rh,
    bf);
    {$ELSE}
  ACanvas.Brush.Color := AColor;
  ACanvas.FillRect(ARect);
    {$ENDIF}
  {$ELSE}
  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  bf.SourceConstantAlpha := ATransparencyLevel; //0 - 255
  bf.AlphaFormat := 0;

  AlphaBlend(ACanvas.Handle,
    ARect.Left, ARect.Top, rw, rh,
    BackBitmap.Canvas.Handle,
    0, 0, rw, rh,
    bf);
  {$ENDIF}
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

function GetWindowPPIScreen(wnd: HWND): Integer;
{$IFDEF EH_LIB_26}  //XE10.3
var
  LMonitor: TMonitor;
begin
  if CheckWin32Version(6,3) then
  begin
    if wnd > 0 then
      LMonitor := Screen.MonitorFromWindow(wnd)
    else
      LMonitor := Screen.MonitorFromWindow(Application.Handle);
    if LMonitor <> nil then
      Result := LMonitor.PixelsPerInch
    else
      Result := Screen.PixelsPerInch;
  end
  else
    Result := Screen.PixelsPerInch;
end;
{$ELSE}
begin
  Result := Screen.PixelsPerInch;
end;
{$ENDIF}

function GetCanvasScaleForStandardDpi(Canvas: TCanvas): Double;
var
{$IFDEF EH_LIB_26}  //XE10.3
  wnd: HWND;
{$ELSE}
{$ENDIF}
  PixelsPerInch: Integer;
begin
  {$IFDEF EH_LIB_26}  //XE10.3
  wnd := WindowFromDC(Canvas.Handle);
  PixelsPerInch := GetWindowPPIScreen(wnd);
  {$ELSE}
  PixelsPerInch := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  {$ENDIF}
  Result := PixelsPerInch / 96;
end;

function SysStrToFloat(const S: string): Extended;
var
  ASep: Char;
begin
  ASep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  try
    Result := StrToFloat(S);
  finally
    FormatSettings.DecimalSeparator := ASep;
  end;
end;

function SysFloatToStr(const Val: Extended): string;
var
  ASep: Char;
begin
  ASep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  try
    Result := FloatToStr(Val);
  finally
    FormatSettings.DecimalSeparator := ASep;
  end;
end;

procedure DoNothing();
begin
end;

procedure FreeObjectEh(obj: TObject);
begin
{$IFDEF NEXTGEN}
{$ELSE}
  obj.Free;
{$ENDIF}
end;

{$IFDEF MSWINDOWS}
function SetLayout(hdc: HDC; dwLayout: DWORD): DWORD; stdcall;
  external gdi32 name 'SetLayout';
{$ENDIF}

function SetLayoutEh(hdc: HDC; dwLayout: DWORD): DWORD;
begin
{$IFDEF MSWINDOWS}
  Result := SetLayout(hdc, dwLayout);
{$ELSE}
{ TODO : Make an implementation for MacOS and Linux. }
 
  Result := 0;
{$ENDIF}
end;

procedure OutputDebugStringEh(str: String);
begin
  {$IFDEF MSWINDOWS}
  Windows.OutputDebugString(PChar(str));
  {$ELSE}
  Writeln(str);
  {$ENDIF}
end;

function LoadCursorEh(hInstance: HINST; lpCursorName: PChar): HCURSOR;
begin
  Result := LoadCursor(hInstance, lpCursorName);
  {$IFDEF MSWINDOWS}
  if Result = 0 then
    raise EOutOfResources.Create('Cannot load cursor resource');
  {$ELSE}
  {$ENDIF}
end;

function LoadRegisterCursorEh(CursorName: String): TCursor;
var
  i: TCursor;
  FreeCursor: HCURSOR;
begin
  {$IFDEF FPC}
  FreeCursor := 0;
  {$ELSE}
  FreeCursor := Screen.Cursors[0];
  {$ENDIF}

  for i := 1 to 32767 do
  begin
    if Screen.Cursors[i] = FreeCursor then
    begin
      Screen.Cursors[i] := LoadCursorEh(hInstance, PChar(CursorName));
      Result := i;
      Exit;
    end;
  end;

  
  raise Exception.Create('LoadRegisterCursorEh could not register cursor - "' + CursorName + '"');
end;

function ChangeRect(const Rect: TRect; ChangeLeft, ChangeTop, ChangeRight, ChangeBottom: Integer): TRect;
begin
  Result.Left := Rect.Left + ChangeLeft;
  Result.Top := Rect.Top + ChangeTop;
  Result.Right := Rect.Right + ChangeRight;
  Result.Bottom := Rect.Bottom + ChangeBottom;
end;

procedure MoveRect(var Rect: TRect; Left, Top: Integer);
var
  Width, Height: Integer;
begin
  Width := RectWidth(Rect);
  Height := RectHeight(Rect);
  Rect.Left := Left;
  Rect.Top := Top;
  Rect.Right := Rect.Left + Width;
  Rect.Bottom := Rect.Top + Height;
end;

procedure MoveRect(var Rect: TRect; Pos: TPoint);
begin
  MoveRect(Rect, Pos.X, Pos.Y);
end;

procedure SwapInt(var a, b: Integer);
var
  c: Integer;
begin
  c := a;
  a := b;
  b := c;
end;

function RightToLeftReflectRect(const BaseRect: TRect; const ARect: TRect): TRect;
var
  p: TPoint;
  rw: Integer;
begin
  Result := ARect;
  p := RightToLeftReflectPoint(BaseRect, ARect.TopLeft);
  rw := RectWidth(ARect);
  Result.Right := p.X;
  Result.Left := Result.Right - rw;
end;

function RightToLeftReflectPoint(const BaseRect: TRect; const APoint: TPoint): TPoint;
var
  Centr: Integer;
begin
  Result.Y := APoint.Y;
  Centr := (BaseRect.Right + BaseRect.Left) div 2;
  if APoint.X < Centr then
    Result.X := BaseRect.Right - (APoint.X - BaseRect.Left)
  else
    Result.X := BaseRect.Left + (BaseRect.Right - APoint.X);
end;

{$IFNDEF EH_LIB_12}
function RectWidth(const Rect: TRect): Integer;
begin
  Result := Rect.Right - Rect.Left;
end;

function RectHeight(const Rect: TRect): Integer;
begin
  Result := Rect.Bottom - Rect.Top;
end;

function RectCenter(var R: TRect; const Bounds: TRect): TRect;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, (RectWidth(Bounds) - RectWidth(R)) div 2, (RectHeight(Bounds) - RectHeight(R)) div 2);
  OffsetRect(R, Bounds.Left, Bounds.Top);
  Result := R;
end;
{$ENDIF}

function RectSize(const Rect: TRect): TSize;
begin
  Result.cx := RectWidth(Rect);
  Result.cy := RectHeight(Rect);
end;

function RectContains(const Rect: TRect; const P: TPoint): Boolean;
begin
  Result := PtInRect(Rect, P);
end;

function CreateRect(Left, Top, Right, Bottom: Integer): TRect;
begin
  Result := Rect(Left, Top, Right, Bottom);
end;

function RectF(ALeft, ATop, ARight, ABottom: Single): TRectF;
begin
  Result.Left := ALeft;
  Result.Top := ATop;
  Result.Right := ARight;
  Result.Bottom := ABottom;
end;

function PointF(x: Single; y: Single): TPointF;
begin
  Result.x := x;
  Result.y := y;
end;

function RectFWidth(const Rect: TRectF): Single;
begin
  Result := Rect.Right - Rect.Left;
end;

function RectFHeight(const Rect: TRectF): Single;
begin
  Result := Rect.Bottom - Rect.Top;
end;

function CreatePoint(x, y: Integer): TPoint;
begin
  Result.X := x;
  Result.Y := y;
end;

function CreateSize(cx, cy: Longint): TSize;
begin
  Result.cx := cx;
  Result.cy := cy;
end;

function GetTickCountEh: Int64;
begin
{$IFDEF FPC}
  Result := Int64(GetTickCount64);
{$ELSE}
  {$IFDEF EH_LIB_25} 
  if CheckWin32Version(6, 0)
    //then Result := GetTickCount64  // XE10.2 bug. Can't use inactive GetTickCount64 in WinXP
    then Result := GetTickCount
    else Result := GetTickCount;
  {$ELSE}
  Result := GetTickCount;
  {$ENDIF}
{$ENDIF}
end;

function SmallPointToPointEh(const P: TSmallPoint): TPoint;
begin
  Result.X := P.X;
  Result.Y := P.Y;
end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, UINT(Msg), UINT(Msg), pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessageEh(M.wparam);
end;

function FirstDayOfWeekEh(): Integer; 
{$IFDEF WINDOWS}
var
  A: array[0..1] of char;
begin
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, A, SizeOf(A));
{$IFDEF MSWINDOWS}
  Result := Ord(A[0]) - Ord('0');
{$ELSE}
  { TODO : Make an implementation for NEXTGEN. }
  Result := 0;
{$ENDIF}
end;

{$ELSE} 
begin
  Result := -1;
end;
{$ENDIF} 

{$IFNDEF EH_LIB_17}

{ TFormatSettingsProxyEh }

function TFormatSettingsProxyEh.GetTwoDigitYearCenturyWindow: Word;
begin
{$IFDEF EH_LIB_17}
    Result := System.SysUtils.FormatSettings.TwoDigitYearCenturyWindow;
{$ELSE}
    Result := SysUtils.TwoDigitYearCenturyWindow;
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetTwoDigitYearCenturyWindow(Value: Word);
begin
{$IFDEF EH_LIB_17}
    System.SysUtils.FormatSettings.TwoDigitYearCenturyWindow := Value;
{$ELSE}
    SysUtils.TwoDigitYearCenturyWindow := Value;
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetShortMonthNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ShortMonthNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ShortMonthNames[Index];
  {$ELSE}
  Result := SysUtils.ShortMonthNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetShortMonthNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
    System.SysUtils.FormatSettings.ShortMonthNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ShortMonthNames[Index] := Value;
  {$ELSE}
  SysUtils.ShortMonthNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetLongMonthNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
    Result := System.SysUtils.FormatSettings.LongMonthNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongMonthNames[Index];
  {$ELSE}
  Result := SysUtils.LongMonthNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetLongMonthNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.LongMonthNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongMonthNames[Index] := Value;
  {$ELSE}
  SysUtils.LongMonthNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetShortDayNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ShortDayNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ShortDayNames[Index];
  {$ELSE}
  Result := SysUtils.ShortDayNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetShortDayNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.ShortDayNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ShortDayNames[Index] := Value;
  {$ELSE}
  SysUtils.ShortDayNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetlongDayNames(Index : Integer) : String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.longDayNames[Index];
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongDayNames[Index];
  {$ELSE}
  Result := SysUtils.LongDayNames[Index];
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetlongDayNames(Index: Integer; Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.longDayNames[Index] := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongDayNames[Index] := Value;
  {$ELSE}
  SysUtils.LongDayNames[Index] := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetDecimalSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.DecimalSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.DecimalSeparator;
  {$ELSE}
  Result := SysUtils.DecimalSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetDecimalSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.DecimalSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.DecimalSeparator := Value;
  {$ELSE}
  SysUtils.DecimalSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetDateSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.DateSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.DateSeparator;
  {$ELSE}
  Result := SysUtils.DateSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetDateSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.DateSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.DateSeparator := Value;
  {$ELSE}
  SysUtils.DateSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetTimeSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.TimeSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.TimeSeparator;
  {$ELSE}
  Result := SysUtils.TimeSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetTimeSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.TimeSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.TimeSeparator := Value;
  {$ELSE}
  SysUtils.TimeSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetThousandSeparator: Char;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ThousandSeparator;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ThousandSeparator;
  {$ELSE}
  Result := SysUtils.ThousandSeparator;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetThousandSeparator(Value: Char);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.ThousandSeparator := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ThousandSeparator := Value;
  {$ELSE}
  SysUtils.ThousandSeparator := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetShortDateFormat: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ShortDateFormat;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ShortDateFormat;
  {$ELSE}
  Result := SysUtils.ShortDateFormat;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetShortDateFormat(Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.ShortDateFormat := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ShortDateFormat := Value;
  {$ELSE}
  SysUtils.ShortDateFormat := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetLongDateFormat: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.LongDateFormat;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongDateFormat;
  {$ELSE}
  Result := SysUtils.LongDateFormat;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetLongDateFormat(Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.LongDateFormat := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongDateFormat := Value;
  {$ELSE}
  SysUtils.LongDateFormat := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetLongTimeFormat: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.LongTimeFormat;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.LongTimeFormat;
  {$ELSE}
  Result := SysUtils.LongTimeFormat;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetLongTimeFormat(Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.LongTimeFormat := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.LongTimeFormat := Value;
  {$ELSE}
  SysUtils.LongTimeFormat := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetCurrencyDecimals: Byte;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.CurrencyDecimals;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.CurrencyDecimals;
  {$ELSE}
  Result := SysUtils.CurrencyDecimals;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetCurrencyDecimals(Value: Byte);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.CurrencyDecimals:= Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.CurrencyDecimals := Value;
  {$ELSE}
  SysUtils.CurrencyDecimals := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetShortTimeFormat: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.ShortTimeFormat;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.ShortTimeFormat;
  {$ELSE}
  Result := SysUtils.ShortTimeFormat;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetShortTimeFormat(const Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.ShortTimeFormat := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.ShortTimeFormat := Value;
  {$ELSE}
  SysUtils.ShortTimeFormat := Value;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetTimeAMString: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.TimeAMString;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.TimeAMString;
  {$ELSE}
  Result := SysUtils.TimeAMString;
  {$ENDIF}
{$ENDIF}
end;

function TFormatSettingsProxyEh.GetTimePMString: String;
begin
{$IFDEF EH_LIB_17}
  Result := System.SysUtils.FormatSettings.TimePMString;
{$ELSE}
  {$IFDEF FPC}
  Result := DefaultFormatSettings.TimePMString;
  {$ELSE}
  Result := SysUtils.TimePMString;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetTimeAMString(const Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.TimeAMString := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.TimeAMString := Value;
  {$ELSE}
  SysUtils.TimeAMString := Value;
  {$ENDIF}
{$ENDIF}
end;

procedure TFormatSettingsProxyEh.SetTimePMString(const Value: String);
begin
{$IFDEF EH_LIB_17}
  System.SysUtils.FormatSettings.TimePMString := Value;
{$ELSE}
  {$IFDEF FPC}
  DefaultFormatSettings.TimePMString := Value;
  {$ELSE}
  SysUtils.TimePMString := Value;
  {$ENDIF}
{$ENDIF}
end;

{ FormatSettingsEh }

var
  FFormatSettings: TFormatSettingsProxyEh;

function FormatSettings: TFormatSettingsProxyEh;
begin
  if FFormatSettings = nil then
    FFormatSettings := TFormatSettingsProxyEh.Create;
  Result := FFormatSettings;
end;

{$ENDIF}

{ Functions }

{$IFNDEF EH_LIB_16}

var
  FStyleServices: TCustomStyleServicesProxyEh;

function StyleServices: TCustomStyleServicesProxyEh;
begin
  if FStyleServices = nil then
    FStyleServices := TCustomStyleServicesProxyEh.Create;
  Result := FStyleServices;
end;

{$ENDIF}

{$IFNDEF EH_LIB_13}
function CenteredRect(const SourceRect: TRect; const ACenteredRect: TRect): TRect;
var
  Width, Height: Integer;
  X, Y: Integer;
begin
  Width := ACenteredRect.Right - ACenteredRect.Left;
  Height := ACenteredRect.Bottom - ACenteredRect.Top;
  X := (SourceRect.Right + SourceRect.Left) div 2;
  Y := (SourceRect.Top + SourceRect.Bottom) div 2;
  Result := Rect(X - Width div 2, Y - Height div 2, X + (Width + 1) div 2, Y + (Height + 1) div 2);
end;
{$ENDIF}

{$IFNDEF EH_LIB_14}
function PointToLParam(P: TPoint): LPARAM;
begin
  Result := LPARAM((P.X and $0000ffff) or (P.Y shl 16));
end;
{$ENDIF}

function StringToLParam(s: String): LPARAM;
begin
{$IFDEF FPC}
  Result := {%H-}LPARAM(PWideChar(UTF8ToUTF16(s)));
{$ELSE}
  Result := LPARAM(PChar(s));
{$ENDIF}
end;

function VarIsNullEh(const V: Variant): Boolean;
begin
  Result := TVarData(V).VType = varNull;
end;

procedure VarSetNull(var V: Variant);
const
  varDeepData = $BFE8;
begin
  if (TVarData(V).VType and varDeepData) = 0 then
    TVarData(V).VType := varNull
  else
  begin
    VarClear(V);
    TVarData(V).VType := varNull;
  end;
end;

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;
begin
{$IFDEF EH_LIB_12}
  Result := CharInSet(C, CharSet);
{$ELSE}
  Result := C in CharSet;
{$ENDIF}
end;

function IsLeadCharEh(C: Char): Boolean;
begin
{$IFDEF NEXTGEN}
  Result := IsLeadChar(C);
{$ELSE}
  Result := CharInSetEh(C, LeadBytes);
{$ENDIF}
end;

function VarToAnsiStr(const V: Variant): AnsiString;
begin
  if not VarIsNull(V)
    then Result := AnsiString(V)
    else Result := AnsiString('');
end;

{$IFDEF FPC}
function WideStringCompare(const ws1, ws2: WideString; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
begin
  Result := -1;
end;

function AnsiStringCompare(const s1, s2: String; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
begin
  Result := -1;
end;
{$ELSE} //FPC

function WideStringCompare(const ws1, ws2: WideString; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
  {$IFDEF MSWINDOWS}
var
  dwCmpFlags: LongWord;
  cchCount: Integer;
begin
  if CaseInsensitive
    then dwCmpFlags := NORM_IGNORECASE
    else dwCmpFlags := 0;

  if CharCount = 0
    then cchCount := -1
    else cchCount := CharCount;

  Result := CompareStringW(LOCALE_USER_DEFAULT, dwCmpFlags, PWideChar(ws1),
      cchCount, PWideChar(ws2), cchCount) - 2;
end;
  {$ELSE}
begin
  Result := String.Compare(ws1, 0, ws2, 0, CharCount, CaseInsensitive);
end;
  {$ENDIF} 

function AnsiStringCompare(const s1, s2: String; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
  {$IFDEF MSWINDOWS}
var
  dwCmpFlags: LongWord;
  cchCount: Integer;
begin
  if CaseInsensitive
    then dwCmpFlags := NORM_IGNORECASE
    else dwCmpFlags := 0;

  if CharCount = 0
    then cchCount := -1
    else cchCount := CharCount;

  Result := CompareString(LOCALE_USER_DEFAULT, dwCmpFlags, PChar(s1),
      cchCount, PChar(s2), cchCount) - 2;
end;
   {$ELSE}
begin
  Result := String.Compare(s1, 0, s2, 0, CharCount, CaseInsensitive);
end;
  {$ENDIF} //ELSE MSWINDOWS
{$ENDIF} //ELSE FPC

function IsObjectAndIntegerRefSame(AObject: TObject; IntRef: IntPtr): Boolean;
begin
  Result := (IntPtr(AObject) = IntRef);
end;

function IntPtrToObject(AIntPtr: IntPtr): TObject;
begin
  Result := TObject(AIntPtr);
end;

function ObjectToIntPtr(AObject: TObject): IntPtr;
begin
  Result := IntPtr(AObject);
end;

function IntPtrToString(AIntPtr: IntPtr): String;
begin
{$WARNINGS OFF}
{$HINTS OFF}
  Result := String(PChar(AIntPtr));
{$HINTS ON}
{$WARNINGS ON}
end;

procedure FillDWord(var Dest; Count, Value: Integer); register;
{$IFDEF FPC}
var
  I: Integer;
  P: PInteger;
begin
  P := PInteger(@Dest);
  for I := 0 to Count - 1 do
    P[I] := Value;
end;
{$ELSE}
{$IFDEF EH_LIB_16}
{$POINTERMATH ON}
var
  I: Integer;
  P: PInteger;
begin
  P := PInteger(@Dest);
  for I := 0 to Count - 1 do
    P[I] := Value;
end;
{$POINTERMATH OFF}
{$ELSE}
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;
{$ENDIF}
{$ENDIF}

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
begin
  Result := DataSet.CompareBookmarks(TBookmark(Bookmark1), TBookmark(Bookmark2));
end;

function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;
begin
  Result := (Bookmark <> NilBookmarkEh) and DataSet.BookmarkValid(TBookmark(Bookmark));
end;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;
var PropValue: TDataSource;
begin
  Result := nil;
  PropValue := nil;
  if (APropInfo <> nil) then
  begin
    if APropInfo^.PropType^.Kind = tkClass then
    try
      PropValue := (GetObjectProp(FDataSet, APropInfo) as TDataSource);
    except 
    end;
  end;
  if (PropValue <> nil)
    then Result := PropValue.DataSet;
end;

type
  TWinControlCrack = class(TWinControl);

function GetAdjustedClientRect(Control: TWinControl): TRect;
begin
  if (Control.HandleAllocated) then
    Result := Control.ClientRect
  else
    Result := Rect(0, 0, Control.Width, Control.Height);

  TWinControlCrack(Control).AdjustClientRect(Result);
end;

var
  ScreenCanvas: TCanvas;

function GetScreenCanvas: TCanvas;
begin
  if (ScreenCanvas = nil) then
  begin
    ScreenCanvas := TCanvas.Create;
    ScreenCanvas.Handle := GetDC(0);
  end;
  Result := ScreenCanvas;
end;

procedure FreeScreenCanvas;
begin
  if (ScreenCanvas <> nil) then
  begin
    ReleaseDC(0, ScreenCanvas.Handle);
    ScreenCanvas.Handle := 0;
  end;
  FreeAndNil(ScreenCanvas);
end;

const
  LayoutToVertAlignment: array [TTextLayout] of TVerticalAlignment = (taAlignTop, taVerticalCenter, taAlignBottom);
                               //tlTop, tlCenter, tlBottom

procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect; ClipRect: TRect;
  Alignment: TAlignment; Layout: TTextLayout; WrapStyle: TTextWrapStyleEh; FillBack: Boolean = False); overload;
var
  Options: TDrawTextOptionsEh;
begin
  Options.HorzAlignment := Alignment;
  Options.VertAlignment := LayoutToVertAlignment[Layout];
  Options.WrapStyle := WrapStyle;
  Options.FillBack := FillBack;
  Options.BiDiMode := Application.BiDiMode;
  Options.EndEllipsis := False;

  DrawTextEh(Canvas, Text, ARect, ClipRect, Options);
end;

procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect;
  Alignment: TAlignment; Layout: TTextLayout; WrapStyle: TTextWrapStyleEh; FillBack: Boolean = False); overload;
var
  Options: TDrawTextOptionsEh;
begin
  Options.HorzAlignment := Alignment;
  Options.VertAlignment := LayoutToVertAlignment[Layout];
  Options.WrapStyle := WrapStyle;
  Options.FillBack := FillBack;
  //Options.RightToLeft := False;
  Options.BiDiMode := Application.BiDiMode;
  Options.EndEllipsis := False;

  DrawTextEh(Canvas, Text, ARect, EmptyRect, Options);
end;

procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect; FillBack: Boolean = False); overload;
var
  Options: TDrawTextOptionsEh;
begin
  Options.HorzAlignment := taLeftJustify;
  Options.VertAlignment := TVerticalAlignment.taAlignTop;
  Options.WrapStyle := twsNoWrapEh;
  Options.FillBack := FillBack;
  Options.BiDiMode := Application.BiDiMode;
  Options.EndEllipsis := False;

  DrawTextEh(Canvas, Text, ARect, EmptyRect, Options);
end;

function GetTextExtentPointEh(Canvas: TCanvas; Text: String; out StringSize: TSize): TIntegerDynArray;
var
  MaxChars: Integer;
begin
  Result := nil;
  StringSize.cx := 0;
  StringSize.cy := 0;
  SetLength(Result, Length(Text));
  GetTextExtentExPoint(Canvas.Handle, PChar(Text), Length(Text),
   10000, 
   @MaxChars, @Result[0], StringSize);
end;

function StrLength(s: String): Integer;
begin
{$IFDEF FPC}
  Result := UTF8Length(s);
{$ELSE}
  Result := Length(s);
{$ENDIF}
end;

function StringNextCharPos(S: String; APos: Integer): Integer;
begin
  Result := APos;
  {$IFDEF FPC}
  Result := Result + UTF8CodepointSize(@S[APos]);
  {$ELSE}
  Result := Result + 1;
  {$ENDIF}
end;

{ TDrawTextOptionsEh }

procedure TDrawTextOptionsEh.Clear;
begin
  HorzAlignment := TAlignment.taLeftJustify;
  VertAlignment := TVerticalAlignment.taAlignTop;
  WrapStyle := twsNoWrapEh;
  BiDiMode := bdLeftToRight;
  EndEllipsis := False;
  RotationAngle := 0;
end;

procedure GetRGB(Col: TColor; var R, G, B: Byte);
begin
{$IFDEF EH_LIB_27} 
  GraphUtil.GetRGB(Col, R, G, B);
{$ELSE}
  Col := ColorToRGB(Col);
  R := GetRValue(Col);
  G := GetGValue(Col);
  B := GetBValue(Col);
{$ENDIF}
end;

{$IFDEF WINDOWS}

procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect; ClipRect: TRect;
  var Options: TDrawTextOptionsEh);
const
  AlignFlags: array[TAlignment] of UINT =
  (DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
  RTL: array[Boolean] of UINT = (0, DT_RTLREADING);
var
  DrawFlag: UINT;
  TextRect: TRect;
  txth: Integer;
  {$IFDEF FPC}
  RestRgn: HRgn;
  DrawRect: TRect;
  {$ELSE}
  {$ENDIF}
  OldBrushStyle: TBrushStyle;
begin

  {$IFDEF FPC}
  DrawRect := ARect;
  {$ELSE}
  {$ENDIF}
  DrawFlag := 0;

  if Options.WrapStyle = twsWordWrapEh then
    DrawFlag := DrawFlag or DT_WORDBREAK
  else if Options.WrapStyle = twsSingleLineEh then
    DrawFlag := DrawFlag or DT_SINGLELINE;

  if (Options.EndEllipsis = True) then
    DrawFlag := DrawFlag or DT_END_ELLIPSIS;

  DrawFlag := DrawFlag or
              AlignFlags[Options.HorzAlignment] or
              RTL[(Options.BiDiMode <> bdLeftToRight)];

//  if not Options.Opaque then
//    Canvas.Brush.Style := bsClear;
  OldBrushStyle := Canvas.Brush.Style;
  if Options.FillBack
    then Canvas.Brush.Style := bsSolid
    else Canvas.Brush.Style := bsClear;

  TextRect := ARect;

  if Options.VertAlignment <> taAlignTop then
  begin
    txth := WindowsDrawTextEx(Canvas.Handle, Text, ARect, DrawFlag or DT_CALCRECT);
    case Options.VertAlignment of
      taAlignBottom: TextRect.Top := TextRect.Bottom - txth;
      taVerticalCenter: TextRect.Top := (TextRect.Bottom + TextRect.Top - txth) div 2;
    end;
  end;

  {$IFDEF FPC}
  RestRgn := SelectClipRectangleEh(Canvas, DrawRect);
  WindowsDrawTextEx(Canvas.Handle, Text, TextRect, DrawFlag);
  RestoreClipRectangleEh(Canvas, RestRgn);
  {$ELSE}
  WindowsDrawTextEx(Canvas.Handle, Text, TextRect, DrawFlag);
  {$ENDIF}

  if (OldBrushStyle <> Canvas.Brush.Style) then
    Canvas.Brush.Style := OldBrushStyle;
end;

function RGBToColorEh(R, G, B: Byte): TColor;
begin
  Result := RGB(R, G, B);
end;

function GetMessageTimeEh: Longint;
begin
  Result := Windows.GetMessageTime;
end;

function EditorGetCaretPosEh(Control: TWinControl): Integer;
var
  P: TPoint;
  IntPos: Integer;
begin
  P := Point(0, 0);
  Windows.GetCaretPos(P);
  IntPos := SendMessage(Control.Handle, EM_CHARFROMPOS, 0, MakeLong(P.X, P.Y));
  Result := TSmallPoint(IntPos).x;
end;

function DrawTextEh(hDC: HDC; const Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
{$IFDEF FPC}
var
  w: WideString;
{$ELSE}
{$ENDIF}
begin
{$IFDEF FPC}
  w := LazUTF8.UTF8ToUTF16(Text);
  Result := Windows.DrawTextW(hDC, PWideChar(w), Length(w), lpRect, uFormat);
{$ELSE}
  Result := DrawText(hDC, PChar(Text), nCount, lpRect, uFormat);
{$ENDIF}
end;

function WindowsDrawTextEx(DC: HDC; const lpchText: String;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer;
var
{$IFDEF FPC}
  w: WideString;
{$ELSE}
{$ENDIF}
  cchText: Integer;
begin
{$IFDEF FPC}
  w := LazUTF8.UTF8ToUTF16(lpchText);
  cchText := Length(w);
  Result := Windows.DrawTextExW(DC, PWideChar(w), cchText, p4, dwDTFormat, @DTParams);
{$ELSE}
  cchText := Length(lpchText);
  Result := DrawTextEx(DC, PChar(lpchText), cchText, p4, dwDTFormat, @DTParams);
{$ENDIF}
end;

function WindowsDrawTextEx(DC: HDC; const lpchText: String;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;
var
{$IFDEF FPC}
  w: WideString;
{$ELSE}
{$ENDIF}
  cchText: Integer;
begin
{$IFDEF FPC}
  w := LazUTF8.UTF8ToUTF16(lpchText);
  cchText := Length(w);
  Result := Windows.DrawTextExW(DC, PWideChar(w), cchText, p4, dwDTFormat, nil);
{$ELSE}
  cchText := Length(lpchText);
  Result := DrawTextEx(DC, PChar(lpchText), cchText, p4, dwDTFormat, nil);
{$ENDIF}
end;

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; const Str: String; Count: Longint{; Dx: PInteger}): BOOL;
begin
  Result := ExtTextOut(DC, X, Y, Options,
    @Rect, PChar(Str), Count, nil);
end;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;
begin
  Result := GetOutlineTextMetrics(DC, p2, @OTMetricStructs);
end;

function GetNearestColor(hDC: HDC; Color: TColor): TColor;
begin
  Result := Windows.GetNearestColor(hDC, Color);
end;

procedure SetWindowDropShadowStyle(Control: TWinControl; var Params: TCreateParams; SetState: Boolean);
begin
  if CheckWin32Version(5, 1) and SetState then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW
  else
    Params.WindowClass.Style := Params.WindowClass.Style and not CS_DROPSHADOW;
end;

procedure SetWindowDropDownNoactivateStyle(Control: TWinControl; var Params: TCreateParams; SetState: Boolean);
begin
  if SetState then
    Params.ExStyle := Params.ExStyle or WS_EX_NOACTIVATE
  else
    Params.WindowClass.Style := Params.WindowClass.Style and not WS_EX_NOACTIVATE;
end;

function GetDesktopWindowEh: HWND;
begin
  Result := GetDesktopWindow;
end;

{$ELSE}

procedure DrawTextEh(Canvas: TCanvas; Text: String; ARect: TRect; ClipRect: TRect;
  var Options: TDrawTextOptionsEh);
const
  VertAlignmentToLayout: array [TVerticalAlignment] of TTextLayout = (tlTop, tlBottom, tlCenter);
var
  TextStyle: TTextStyle;
begin
  TextStyle.Alignment := Options.HorzAlignment;
  TextStyle.Layout := VertAlignmentToLayout[Options.VertAlignment];
  TextStyle.SingleLine := Options.WrapStyle = twsSingleLineEh;
  TextStyle.Clipping := True;
  TextStyle.ExpandTabs := False;
  TextStyle.ShowPrefix := False;
  TextStyle.Wordbreak := Options.WrapStyle = twsWordWrapEh;
  TextStyle.Opaque := Options.FillBack;
  TextStyle.SystemFont := False;
  if (Options.BiDiMode = bdLeftToRight)
    then TextStyle.RightToLeft := False
    else TextStyle.RightToLeft := True;
  TextStyle.EndEllipsis := Options.EndEllipsis;

  Canvas.TextRect(ARect, ARect.Left, ARect.Top, Text, TextStyle);
end;

function EditorGetCaretPosEh(Control: TWinControl): Integer;
begin
  Result := -1;
  if Control.HandleAllocated then
    Result := TWSCustomEditClass(Control.WidgetSetClass).GetCaretPos(Control as TCustomEdit).X;
end;

function GetMessageTimeEh: Longint;
begin
  Result := 0;
end;

function RGBToColorEh(R, G, B: Byte): TColor;
begin
  Result := RGBToColor(R, G, B);
end;

function GetNearestColor(hDC: HDC; Color: TColor): TColor;
begin
  Result := Color;
end;

function DrawTextEh(hDC: HDC; const Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
begin
  Result := DrawText(hDC, PChar(Text), nCount, lpRect, uFormat);
end;


procedure SetWindowDropShadowStyle(Control: TWinControl; var Params: TCreateParams; SetState: Boolean);
begin
end;

procedure SetWindowDropDownNoactivateStyle(Control: TWinControl; var Params: TCreateParams; SetState: Boolean);
begin
end;

function GetDesktopWindowEh: HWND;
begin
  {$IFDEF FPC_MACOS}
  Result := 0;
  {$ENDIF}
  {$IFDEF FPC_LINUX}
  Result := HWND(gdk_screen_get_root_window(gdk_screen_get_default));
  {$ENDIF}
end;

procedure RegisterPopupInactiveFormEh;
begin
end;

{$ENDIF} 

function MiddleDotChar: Char;
begin
  {$IFDEF FPC}
  Result := '.';
  {$ELSE}
  Result := Char($B7);
  {$ENDIF}
end;

function SendStructMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
begin
  Result := SendMessage(hWnd, Msg, wParam, NativeInt(@lParam));
end;

function SendTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; const lParam: string): LRESULT;
begin
  Result := SendMessage(hWnd, Msg, wParam, NativeInt(PChar(lParam)));
end;

function SendGetTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam: String; BufferSize: Integer): LRESULT;
var
  Text: array[0..4095] of Char;
begin
  Word((@Text)^) := SizeOf(Text);
//  {$HINTS OFF}
  Result := SendMessage(hWnd, HWND, wParam, NativeInt(@Text));
//  {$HINTS ON}
  System.SetString(lParam, Text, Result);
end;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam; fWinIni: UINT): BOOL;
begin
  Result := SystemParametersInfo(uiAction, uiParam, @pvParam, fWinIni);
end;

function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
begin
  Result := InvalidateRect(hWnd, @Rect, bErase);
end;

function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
begin
  {$IFDEF FPC}
  Result := False;
  {$ELSE}
  Result := ValidateRect(hWnd, @Rect);
  {$ENDIF}
end;

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; flags: UINT): Boolean;
begin
  Result := ScrollWindowEx(hWnd, dx, dy, @prcScroll, @prcClip,
    hrgnUpdate, nil, flags);
end;

function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;
begin
  Result := ScrollWindow(hWnd, dx, dy, @prcScroll, @prcClip);
end;

procedure WinServiceSetFocus(hWnd: HWND);
begin
  {$IFDEF FPC_CROSSP}
  LCLIntf.SetFocus(hWnd);
  {$ELSE}
  Windows.SetFocus(hWnd);
  {$ENDIF}
end;

function  WinServiceIsChild(hWndParent, hWnd: HWND): Boolean;
{$IFDEF FPC_CROSSP}
var
  pWnd: hWnd;
begin
  pWnd := hWnd;
  Result := False;
  while True do
  begin
    pWnd := GetParent(pWnd);
    if (pWnd = 0) then Exit;
    if (pWnd = hWndParent) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;
{$ELSE}
begin
  Result := Windows.IsChild(hWndParent, hWnd);
end;
{$ENDIF}

procedure VarToMessage(var VarMessage; var Message: TMessage);
begin
  Message := TMessage(VarMessage);
end;

function MessageToTMessage(var Message): TMessage;
begin
  Result := TMessage(Message);
end;

function MessageToTWMMouse(var Message): TWMMouse;
begin
  Result := TWMMouse(Message);
end;

function MessageToTWMKey(var Message): TWMKey;
begin
  Result := TWMKey(Message);
end;

function UnwrapMessageEh(var Message): TMessage;
begin
  Result := TMessage(Message);
end;

function SmallPointToInteger(SmallPoint: TSmallPoint): Integer;
begin
  Result := Integer(SmallPoint);
end;

function LongintToSmallPoint(Value: Longint): TSmallPoint;
begin
  Result := TSmallPoint(Value);
end;

function WindowsLPtoDP(DC: HDC; var ARect: TRect): BOOL;
begin
  Result := LPtoDP(DC, ARect, 2);
end;

function WindowsCreatePolygonRgn(Points: array of TPoint; Count, FillMode: Integer): HRGN;
begin
  Result := CreatePolygonRgn(Points, Count, FillMode);
end;

function GetFontSize(Font: TFont): Integer;
{$IFDEF FPC}
var
  FDat: TFontData;
begin
  if (Font.Size <> 0) then
  begin
    Result := Font.Size;
  end else
  begin
    FDat := GetFontData(Font.Handle);
    Result := Round(FDat.Height * 72 / Font.PixelsPerInch);
    if (Result < 0) then
       Result := -Result;
  end;
end;
{$ELSE}
begin
  Result := Font.Size;
end;
{$ENDIF}

function GetFontHeight(Font: TFont): Integer;
{$IFDEF FPC}
begin
  Result := Abs(GetFontData(Font.Reference.Handle).Height);
end;
{$ELSE}
begin
  Result := -Font.Height;
end;
{$ENDIF}

function GetFontTextHeight(Canvas: TCanvas; Font: TFont; IncludeExternalLeading: Boolean = True): Integer;
var
  ACanvas: TCanvas;
  tm: TTextMetric;
begin
  if (Canvas = nil) or (not Canvas.HandleAllocated) then
  begin
    ACanvas := GetScreenCanvas;
  end else
  begin
    ACanvas := Canvas;
  end;

  ACanvas.Font := Font;
  GetTextMetrics(ACanvas.Handle, tm);
  Result := tm.tmHeight;
  if (IncludeExternalLeading) then
     Result := Result + tm.tmExternalLeading;
end;

procedure GetTextMetricsEh(Canvas: TCanvas; out tm: TTextMetric);
var
  ACanvas: TCanvas;
begin
  if (Canvas = nil) or (not Canvas.HandleAllocated) then
  begin
    ACanvas := GetScreenCanvas;
    ACanvas.Font := Canvas.Font;
  end else
  begin
    ACanvas := Canvas;
  end;

  GetTextMetrics(ACanvas.Handle, {%H-}tm);
end;

procedure GetTextMetricsEh(AFontName: String; AFontSize: Integer;
  AFontStyle: TFontStyles; out tm: TTextMetric);
var
  ACanvas: TCanvas;
begin
  ACanvas := GetScreenCanvas;
  ACanvas.Font.Name := AFontName;
  ACanvas.Font.Size := AFontSize;
  ACanvas.Font.Style := AFontStyle;

  GetTextMetrics(ACanvas.Handle, {%H-}tm);
end;

procedure PolyPolyLineEh(Canvas: TCanvas; const PointsList: TPointArrayEh; const StrokeList: TDWORDArrayEh; VCount: Integer);
{$IFDEF FPC_CROSSP}
var
  i: Integer;
  pos: Integer;
begin
  pos := 0;
  for i := 0 to VCount-1 do
  begin
    Canvas.PolyLine(PointsList, pos, StrokeList[i]);
    pos := pos + Integer(StrokeList[i]);
  end;
end;
{$ELSE}
begin
  PolyPolyLine(Canvas.Handle, Pointer(PointsList)^, Pointer(StrokeList)^, VCount);
end;
{$ENDIF}

procedure MessageSendGetSel(hWnd: HWND; var SelStart, SelEnd: Integer);
{$IFDEF WINDOWS}
begin
  {$HINTS OFF}
  SendMessage(hWnd, EM_GETSEL, WPARAM(@SelStart), LPARAM(@SelEnd));
  {$HINTS ON}
end;
{$ELSE} //WINDOWS
begin
  SelStart := 0;
  SelEnd := 0;
end;
{$ENDIF} //ELSE WINDOWS

procedure EditControlSetSel(Control: TCustomEdit; SelStart, SelEnd: Integer);
{$IFDEF WINDOWS}
begin
  SendMessage(Control.Handle, EM_SETSEL, WPARAM(SelStart), LPARAM(SelEnd));
end;
{$ELSE}
begin
  if (SelStart > SelEnd) then
    SwapInt(SelStart, SelEnd);
  Control.SelStart := SelStart;
  Control.SelLength := SelEnd - SelStart;
end;
{$ENDIF}

procedure PostQuitMessageEh(nExitCode: Integer);
{$IFDEF WINDOWS}
begin
  PostQuitMessage(nExitCode);
end;
{$ELSE}
begin
  PostMessage(Application.MainFormHandle, WM_QUIT, nExitCode, 0);
end;
{$ENDIF}

function NlsUpperCase(const S: String): String;
begin
  Result := AnsiUpperCase(S);
end;

function NlsLowerCase(const S: String): String;
begin
  Result := AnsiLowerCase(S);
end;

function NlsCompareStr(const S1, S2: String): Integer;
begin
  Result := AnsiCompareStr(S1, S2);
end;

function NlsCompareText(const S1, S2: String): Integer;
begin
  Result := AnsiCompareText(S1, S2);
end;

{$IFNDEF EH_LIB_9}
function ReplaceStr(const AText, AFromText, AToText: string): string;
begin
  Result := AnsiReplaceStr(AText, AFromText, AToText);
end;
{$ENDIF}

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
begin
{$IFDEF NEXTGEN}
{ TODO : Make an implementation for MacOS and Linux. LoadBitmap(OBM_CHECK)}
 
  Bmp.LoadFromResourceName(Instance, ResName);
{$ELSE}
  Bmp.LoadFromResourceName(Instance, ResName);
{$ENDIF}
end;

function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;
begin
{$IFDEF NEXTGEN}
  Result := LoadBitmap(hInstance, PChar(lpBitmapID));
{$ELSE}
  {$HINTS OFF}
  {$WARNINGS OFF}
  Result := LoadBitmap(hInstance, PChar(lpBitmapID));
  {$WARNINGS ON}
  {$HINTS ON}
{$ENDIF}
end;

function GetPropListAsArray(ATypeInfo: PTypeInfo; TypeKinds: TTypeKinds): TPropListArray;
var
  PropCount: Integer;
begin
  PropCount := GetPropList(ATypeInfo, tkProperties, nil);
  Result := nil;
  SetLength(Result, PropCount);
  GetPropList(ATypeInfo, tkProperties, PPropList(Result));
end;

function HexToBinEh(Text: Pointer; out Buffer: TBytes; CharCount: Integer): Integer;
begin
  SetLength(Buffer, 0);
  SetLength(Buffer, CharCount div 2);
{$IFDEF EH_LIB_22}
  Result := HexToBin(TBytes(Text), 0, TBytes(Buffer), 0, CharCount div 2);
{$ELSE}
  Result := HexToBin(PAnsiChar(Text), PAnsiChar(Buffer), CharCount div 2);
{$ENDIF}
end;

function HexToBinEh(Text: String; out Buffer: TBytes; CharCount: Integer): Integer; overload;
{$IFDEF NEXTGEN}
begin
  SetLength(Buffer, Count);
  Result := HexToBin(PWideChar(Text), 0, Buffer, 0, Count);
end;
{$ELSE}
var
  AnsString: AnsiString;
begin
  AnsString := AnsiString(Text);
  Result := HexToBinEh(Pointer(AnsString), Buffer, CharCount);
end;
{$ENDIF}

procedure BinToHexEh(Buffer: TBytes; out Text: String; Count: Integer);
{$IFDEF EH_LIB_22}
var
  aData, aBuff: TBytes;
begin
    SetLength(aBuff, Count * 2);
    BinToHex(aData, 0, aBuff, 0, Count);
    Text := StringOf(aBuff);
end;
{$ELSE}
var
  AnsiText: AnsiString;
begin
  System.SetString(AnsiText, nil, Count*2);
  BinToHex(PAnsiChar(Buffer), PAnsiChar(AnsiText), Count);
  Text := String(AnsiText);
end;
{$ENDIF}

procedure StreamWriteBytes(Stream: TStream; Buffer: TBytes);
begin
  Stream.Write(Pointer(Buffer)^, Length(Buffer));
end;

procedure StreamReadBytes(Stream: TStream; var Buffer: TBytes; Count: Integer);
var
  bs: AnsiString;
  i: Integer;
begin
  SetLength(Buffer, Count);
  System.SetString(bs, nil, Count);
  Stream.Read(Pointer(bs)^, Count);
  for i := 0 to Length(bs)-1 do
    Buffer[i] := Byte(bs[i+1]);
end;

{$IFNDEF EH_LIB_13}
function BytesOf(S: String): TBytes; overload;
var
  i: Integer;
begin
  Result := nil;
  SetLength(Result, Length(S));
  for i := 0 to Length(S)-1 do
    Result[i] := Byte(AnsiChar(S[i+1]));
end;
{$ENDIF}

{$IFNDEF EH_LIB_17}
function BytesOf(const Val: Pointer; const Len: integer): TBytes; overload;
begin
  Result := nil;
  SetLength(Result, Len);
  System.Move(PByte(Val)^, Result[0], Len);
end;
{$ENDIF}

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
begin
  {$IFDEF FPC}
  Result := APropInfo^.PropType;
  {$ELSE}
  Result := APropInfo^.PropType^;
  {$ENDIF}
end;

function PropInfo_getName(APropInfo: PPropInfo): String;
begin
{$IFDEF NEXTGEN}
  Result := GetPropName(APropInfo);
{$ELSE}
  Result := String(APropInfo^.Name);
{$ENDIF}
end;

function PropType_getKind(APropType: PTypeInfo): TTypeKind;
begin
  Result := APropType^.Kind;
end;

function GetEnumPropValueAsString(Instance: TObject; const PropName: string): String;
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  Value: Longint;
begin
  PropInfo := GetPropInfo(Instance, PropName);
  Value := GetOrdProp(Instance, PropInfo);
  PropType := PropInfo_getPropType(PropInfo);
  Result := GetEnumName(PropType, Value);
end;

procedure SetEnumPropValueAsString(Instance: TObject; const PropName: string; AValue: String);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  Value: Integer;
begin
  PropInfo := GetPropInfo(Instance, PropName);
  PropType := PropInfo_getPropType(PropInfo);
  Value := GetEnumValue(PropType, AValue);
  SetOrdProp(Instance, PropInfo, Value);
end;


procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);
begin
  VarArrayRedim(A, HighBound);
end;

function EmptyRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
end;

function IsRectEmptyEh(const Rect: TRect): Boolean;
begin
  Result := (Rect.Right <= Rect.Left) or (Rect.Bottom <= Rect.Top);
end;

type
  TPersistentCracker = class(TPersistent);
  TComponentCracker = class(TComponent);

function GetUltimateOwner(APersistent: TPersistent): TPersistent;
begin
  Result := TPersistentCracker(APersistent).GetOwner;
end;

{ TFilerAccess }

constructor TFilerAccess.Create(APersistent: TPersistent);
begin
  inherited Create;
  FPersistent := APersistent;
end;

procedure TFilerAccess.DefineProperties(AFiler: TFiler);
begin
  TPersistentCracker(FPersistent).DefineProperties(AFiler);
end;

function TFilerAccess.GetChildOwner: TComponent;
begin
  Result := TComponentCracker(FPersistent).GetChildOwner;
end;

function TFilerAccess.GetChildParent: TComponent;
begin
  Result := TComponentCracker(FPersistent).GetChildParent;
end;

procedure TFilerAccess.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  TComponentCracker(FPersistent).GetChildren(Proc, Root);
end;

procedure TFilerAccess.SetAncestor(Value: Boolean);
begin
  TComponentCracker(FPersistent).SetAncestor(Value);
end;

procedure TFilerAccess.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TComponentCracker(FPersistent).SetChildOrder(Child, Order);
end;

procedure TFilerAccess.Updated;
begin
  TComponentCracker(FPersistent).Updated;
end;

procedure TFilerAccess.Updating;
begin
  TComponentCracker(FPersistent).Updating;
end;

{ TMemoryStream }

constructor TMemoryStreamEh.Create;
begin
  inherited Create;
  HalfMemoryDelta := $1000;
end;

{$IFDEF FPC}
function TMemoryStreamEh.Realloc(var NewCapacity: PtrInt): Pointer;
begin
  Result := inherited Realloc(NewCapacity);
end;
{$ELSE}
  {$IFDEF EH_LIB_28}
function TMemoryStreamEh.Realloc(var NewCapacity: NativeInt): Pointer;
  {$ELSE}
function TMemoryStreamEh.Realloc(var NewCapacity: System.Longint): Pointer;
  {$ENDIF}
var
  MemoryDelta: Integer;
begin
  MemoryDelta := HalfMemoryDelta * 2;
  if (NewCapacity > 0) and (NewCapacity <> Size) then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Memory;
  if NewCapacity <> Capacity then
  begin
    if NewCapacity = 0 then
    begin
  {$IFDEF MSWINDOWS}
      GlobalFreePtr(Memory);
  {$ELSE}
      FreeMem(Memory);
  {$ENDIF}
      Result := nil;
    end else
    begin
  {$IFDEF MSWINDOWS}
{$WARNINGS OFF}
      if Capacity = 0 then
        Result := GlobalAllocPtr(HeapAllocFlags, NewCapacity)
      else
        Result := GlobalReallocPtr(Memory, NewCapacity, HeapAllocFlags);
{$WARNINGS ON}
  {$ELSE}
      if Capacity = 0 then
        GetMem(Result, NewCapacity)
      else
        ReallocMem(Result, NewCapacity);
  {$ENDIF}
      if Result = nil then raise EStreamError.CreateRes(@SMemoryStreamError);
    end;
  end;
end;
{$ENDIF}

procedure DataVarCast(var Dest: Variant; const Source: Variant; AVarType: Integer);
begin
  if VarIsNull(Source) then
    Dest := Null
  else if AVarType = varVariant then
    Dest := Source
  else
    VarCast(Dest, Source, AVarType);
end;

type
  IObjectRefInterface = interface
    ['{8FF448B0-EF45-454A-91EA-15648D848A63}']
    function GetObject: TObject;
  end;

  TInterfacedObjectWrapper = class(TInterfacedObject, IObjectRefInterface)
  private
    FRefObject: TObject;
    function GetObject: TObject;
  public
    constructor Create(ARefObject: TObject);

    property RefObject: TObject read FRefObject;
  end;

constructor TInterfacedObjectWrapper.Create(ARefObject: TObject);
begin
  FRefObject := ARefObject;
end;

function TInterfacedObjectWrapper.GetObject: TObject;
begin
  Result := FRefObject;
end;

function VariantToRefObject(VarValue: Variant): TObject;
var
  itfc: IInterface;
begin
  itfc := IInterface(VarValue);
  Result := (itfc as IObjectRefInterface).GetObject;
end;

function RefObjectToVariant(ARefObject: TObject): Variant;
var
  io: TInterfacedObject;
begin
  io := TInterfacedObjectWrapper.Create(ARefObject);
  Result := io as IInterface;
end;

function VarTypeName(varValue: Variant): String;
var
  basicType  : Integer;
begin
  basicType := VarType(varValue) and VarTypeMask;

  case basicType of
    varEmpty     : Result := 'varEmpty';
    varNull      : Result := 'varNull';
    varSmallInt  : Result := 'varSmallInt';
    varInteger   : Result := 'varInteger';
    varSingle    : Result := 'varSingle';
    varDouble    : Result := 'varDouble';
    varCurrency  : Result := 'varCurrency';
    varDate      : Result := 'varDate';
    varOleStr    : Result := 'varOleStr';
    varDispatch  : Result := 'varDispatch';
    varError     : Result := 'varError';
    varBoolean   : Result := 'varBoolean';
    varVariant   : Result := 'varVariant';
    varUnknown   : Result := 'varUnknown';
    varByte      : Result := 'varByte';
    varWord      : Result := 'varWord';
    varLongWord  : Result := 'varLongWord';
    varInt64     : Result := 'varInt64';
    varStrArg    : Result := 'varStrArg';
    varString    : Result := 'varString';
    varAny       : Result := 'varAny';
    varTypeMask  : Result := 'varTypeMask';
    else
      Result := '(Unknown type)';
  end;
end;

function RemoveLineBreaksFromText(Text: String): String;
var
  i, k: Integer;
begin
  k := 0;
  for i := Length(Text) downto 1 do
  begin
    if (Text[i] = #13) or (Text[i] = #10) then
      k := i
    else
      Break;
  end;
  if k > 0 then
    Result := Copy(Text, 1, k-1)
  else
    Result := Text;

  Result := StringReplace(Result, #13#10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10#13, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #13, ' ', [rfReplaceAll]);
end;

procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);
begin
  DataVarCast(Dest, Source, varVariant);
end;

function WStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;
var
  Src : PWideChar;
begin
  Result := Dest;
  Src := Source;
  while (Src^ <> #$00) do
  begin
    Dest^ := Src^;
    Inc(Src);
    Inc(Dest);
  end;
  Dest^ := #$00;
end;

{$IFOPT R+}
  {$DEFINE RANGEON}
  {$R-}
{$ELSE}
  {$UNDEF RANGEON}
{$ENDIF}
function ExplicitLongwordToLongInt(v: Longword): LongInt;
begin
  Result := LongInt(v);
end;
{$IFDEF RANGEON}
  {$R+}
  {$UNDEF RANGEON}
{$ENDIF}

function VarToWideStr(const V: Variant): WideString;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := '';
end;

function SafeGetMouseCursorPos: TPoint;
begin
  {$IFDEF FPC_LINUX}
  Result := Point(0, 0);
  {$ELSE}
  if not GetCursorPos(Result) then
    Result := Point(0, 0);
  {$ENDIF}
end;

{$IFNDEF EH_LIB_16}

{ TCustomStyleServicesProxyEh }

function TCustomStyleServicesProxyEh.GetSystemColor(Color: TColor): TColor;
begin
  Result := Color;
end;

{$IFDEF FPC}
{$ELSE}
function TCustomStyleServicesProxyEh.GetElementSize(DC: HDC; Details: TThemedElementDetails;
  ElementSize: TElementSize; out Size: TSize): Boolean;
const
  CSizes: array[TElementSize] of TThemeSize = (TS_MIN, TS_TRUE, TS_DRAW);
begin
  Result := GetThemePartSize(ThemeServices.Theme[Details.Element], DC,
    Details.Part, Details.State,
    nil, CSizes[ElementSize], Size) = S_OK;
end;
{$ENDIF}

{$ENDIF}

{$IFNDEF EH_LIB_12}

procedure StreamWriteAnsiString(Stream: TStream; S: AnsiString);
begin
  Stream.Write(PAnsiChar(S)^, Length(S));
end;

constructor TStreamWriter.Create(Stream: TStream; Encoding: TEncoding);
begin
  inherited Create;
  FStream := Stream;
end;

destructor TStreamWriter.Destroy;
begin
  inherited Destroy;
end;

procedure TStreamWriter.Write(Value: Boolean);
begin
  StreamWriteAnsiString(FStream, BoolToStr(Value, True));
end;

procedure TStreamWriter.Write(Value: Char);
begin
  StreamWriteAnsiString(FStream, String(Value));
end;

procedure TStreamWriter.Write(const Value: string);
begin
  StreamWriteAnsiString(FStream, Value);
end;

{ TStreamReader }

constructor TStreamReader.Create(Stream: TStream; Encoding: TEncoding;
  DetectBOM: Boolean = False);
begin
  inherited Create;
  FStream := Stream;
end;

destructor TStreamReader.Destroy;
begin
  inherited Destroy;
end;

function TStreamReader.Read: Integer;
var
  c: Char;
begin
  Result := -1;
  c := #0;
  if EndOfStream then Exit;
  FStream.Read(c, 1);
  Result := Integer(c);
end;

function TStreamReader.GetEndOfStream: Boolean;
begin
  Result := (FStream.Size = FStream.Position);
end;

function TStreamReader.Peek: Integer;
begin
  Result := -1;
  if EndOfStream then Exit;
  Result := Read;
  FStream.Position := FStream.Position - 1;
end;

{$IFDEF FPC}
{$ELSE}
{ TEncoding }

var
  FANSIEncoding: TEncoding;

class function TEncoding.ANSI: TEncoding;
begin
  if (FANSIEncoding = nil) then
    FANSIEncoding := TEncoding.Create;
  Result := FANSIEncoding;
end;

class function TEncoding.Default: TEncoding;
begin
  Result := ANSI;
end;

function TEncoding.GetBytes(const S: string): TBytes;
begin
  Result := nil;
  SetLength(Result, Length(S));
  System.Move(PByte(S)^, Result[0], Length(S));
end;

function TEncoding.GetPreamble: TBytes;
begin
  Result := nil;
  SetLength(Result, 0);
end;
{$ENDIF}

{ TStringBuilder }

constructor TStringBuilder.Create;
begin
  FStringStream := TStringStream.Create('');
  inherited Create;
end;

destructor TStringBuilder.Destroy;
begin
  FreeAndNil(FStringStream);
  inherited Destroy;
end;

function TStringBuilder.Append(const Value: string): TStringBuilder;
begin
  FStringStream.WriteString(Value);
  Result := Self;
end;

function TStringBuilder.Append(const Value: Char; RepeatCount: Integer): TStringBuilder;
begin
  Result := Append(System.StringOfChar(Value, RepeatCount));
end;

function TStringBuilder.ToString: string;
begin
  Result := FStringStream.DataString;
end;

function TStringBuilder.GetLength: Integer;
begin
  Result := FStringStream.Size;
end;

procedure TStringBuilder.Clear;
begin
  FStringStream.Free;
  FStringStream := TStringStream.Create('');
end;

{ TBytesStream }

const
  MemoryDelta = $2000; { Must be a power of 2 }

constructor TBytesStream.Create(const ABytes: TBytes);
begin
  inherited Create;
  FBytes := ABytes;
  SetPointer(Pointer(FBytes), Length(FBytes));
  Capacity := Size;
end;

{$IFDEF FPC}
function TBytesStream.Realloc(var NewCapacity: PtrInt): Pointer;
{$ELSE}
function TBytesStream.Realloc(var NewCapacity: System.Longint): Pointer;
{$ENDIF}
begin
  if (NewCapacity > 0) and (NewCapacity <> Size) then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Pointer(FBytes);
  if NewCapacity <> Capacity then
  begin
    SetLength(FBytes, NewCapacity);
    Result := Pointer(FBytes);
    if NewCapacity = 0 then
      Exit;
    {$IFDEF FPC}
    if Result = nil then raise EStreamError.Create('MemoryStreamError');
    {$ELSE}
    if Result = nil then raise EStreamError.CreateRes(@SMemoryStreamError);
    {$ENDIF}
  end;
end;

{$ENDIF} //EH_LIB_12} //CodeGear RAD Studio 2009

{$IFDEF FPC} //FPC

{ TXMLDocumentEh }

constructor TXMLDocumentEh.Create;
begin
  FXMLDoc := TXMLDocument.Create;
end;

constructor TXMLDocumentEh.Create(AXMLDoc: TXMLDocument);
begin
  FXMLDoc := AXMLDoc;
end;

destructor TXMLDocumentEh.Destroy;
begin
  FreeAndNil(FXMLDoc);
  inherited Destroy;
end;

function TXMLDocumentEh.GetOptions: TXMLDocOptions;
begin
  Result := [];
end;

procedure TXMLDocumentEh.SetOptions(const Value: TXMLDocOptions);
begin

end;

function TXMLDocumentEh.GetEncoding: String;
begin
  Result := String(FXMLDoc.XMLEncoding);
end;

procedure TXMLDocumentEh.SetEncoding(const Value: String);
begin
  FXMLDoc.SetHeaderData(xmlVersion10, DOMString(Value));
end;

function TXMLDocumentEh.GetStandAlone: String;
begin
  if (FXMLDoc.XMLStandalone) then
    Result := 'yes'
  else
    Result := 'no';
end;

procedure TXMLDocumentEh.SetStandAlone(const Value: String);
begin
  if (SameText(Value,'yes')) then
    FXMLDoc.XMLStandalone := True
  else
    FXMLDoc.XMLStandalone := False;
end;

procedure TXMLDocumentEh.SaveToFile(const AFileName: String);
begin
  WriteXMLFile(FXMLDoc, AFileName);
end;

procedure TXMLDocumentEh.SaveToStream(const Stream: TStream);
begin
  WriteXMLFile(FXMLDoc, Stream);
end;

function TXMLDocumentEh.AddChild(const TagName: String): IXMLNode;
var
  de: TDOMElement;
begin
  de := FXMLDoc.CreateElement(DOMString(TagName));
  FXMLDoc.AppendChild(de);
  Result := TXMLNodeEh.Create(de);
end;

function TXMLDocumentEh.AddChild(const TagName, NamespaceURI: String): IXMLNode;
begin
  Result := AddChild(TagName);
end;

function TXMLDocumentEh.CreateElement(const TagOrData, NamespaceURI: String): IXMLNode;
var
  de: TDOMElement;
begin
  de := FXMLDoc.CreateElement(DOMString(TagOrData));
  Result := TXMLNodeEh.Create(de);
end;

function TXMLDocumentEh.GetDocumentElement: IXMLNode;
begin
  Result := TXMLNodeEh.Create(FXMLDoc.DocumentElement);
end;

function TXMLDocumentEh.GetChildNodes: IXMLNodeList;
begin
  Result := TXMLNodeListEh.Create(FXMLDoc.DocumentElement);
end;

{ TXMLNodeEh }

constructor TXMLNodeEh.Create(ADOMElement: TDOMElement);
begin
  FDOMElement := ADOMElement;
end;

destructor TXMLNodeEh.Destroy;
begin
  inherited Destroy;
end;

function TXMLNodeEh.AddChild(const TagName: String; Index: Integer): IXMLNode;
var
  de: TDOMElement;
begin
  de := FDOMElement.OwnerDocument.CreateElement(DOMString(TagName));
  FDOMElement.AppendChild(de);
  Result := TXMLNodeEh.Create(de);
end;

function TXMLNodeEh.AddChild(const TagName, NamespaceURI: String;
  GenPrefix: Boolean; Index: Integer): IXMLNode;
begin
  Result := AddChild(TagName, Index);
end;

function TXMLNodeEh.GetParentNode: IXMLNode;
begin
  Result := TXMLNodeEh.Create(TDOMElement(FDOMElement.ParentNode));
end;

procedure TXMLNodeEh.SetAttribute(const AttrName: String; const Value: OleVariant);
begin
  FDOMElement.AttribStrings[DOMString(AttrName)] := DOMString(VarToStr(Value));
end;

function TXMLNodeEh.GetAttribute(const AttrName: String): OleVariant;
begin
  Result := FDOMElement.AttribStrings[DOMString(AttrName)];
end;

function TXMLNodeEh.GetChildNodes: IXMLNodeList;
begin
  Result := TXMLNodeListEh.Create(FDOMElement);
end;

function TXMLNodeEh.GetText: String;
begin
  Result := String(FDOMElement.TextContent);
end;

procedure TXMLNodeEh.SetText(const Value: String);
begin
  FDOMElement.TextContent := DOMString(Value);
end;

function TXMLNodeEh.GetObject: TObject;
begin
  Result := Self;
end;

function TXMLNodeEh.GetNodeName: String;
begin
  Result := String(FDOMElement.TagName);
end;

function  TXMLNodeEh.GetNodeValue: String;
begin
  Result := GetText;
end;

procedure TXMLNodeEh.SetNodeValue(const AValue: String);
begin
  SetText(AValue);
end;

procedure TXMLNodeEh.DeclareNamespace(const Prefix, URI: String);
begin
  SetAttribute('xmlns', URI);
end;

{ TXMLNodeListEh }

constructor TXMLNodeListEh.Create(ADOMElement: TDOMElement);
begin
  FDOMElement := ADOMElement;
end;

destructor TXMLNodeListEh.Destroy;
begin
  inherited Destroy;
end;

function TXMLNodeListEh.GetCount: Integer;
begin
  Result := FDOMElement.ChildNodes.Count;
end;

function TXMLNodeListEh.Add(const Node: IXMLNode): Integer;
var
  RefObj: IRefObject;
  Obj: TObject;
  SysNode: TXMLNodeEh;
begin
  RefObj := Node as IRefObject;
  Obj := RefObj.GetObject();
  SysNode := Obj as TXMLNodeEh;
  FDOMElement.AppendChild(SysNode.FDOMElement);
  Result := -1;
end;

function TXMLNodeListEh.FindNode(NodeName: String): IXMLNode;
var
  de: TDOMElement;
begin
  de := FDOMElement.FindNode(DOMString(NodeName)) as TDOMElement;
  if (de <> nil) then
    Result := TXMLNodeEh.Create(de)
  else
    Result := nil;
end;

function TXMLNodeListEh.Delete(const Name: String): Integer;
var
  de: TDOMElement;
begin
  de := FDOMElement.FindNode(DOMString(Name)) as TDOMElement;
  FDOMElement.RemoveChild(de);
  Result := -1;
end;

procedure TXMLNodeListEh.Insert(Index: Integer; const Node: IXMLNode);
var
  RefObj: IRefObject;
  Obj: TObject;
  SysNode: TXMLNodeEh;
  PosNode: TDOMNode;
begin
  RefObj := Node as IRefObject;
  Obj := RefObj.GetObject();
  SysNode := Obj as TXMLNodeEh;

  PosNode := FDOMElement.ChildNodes[Index];
  FDOMElement.InsertBefore(SysNode.FDOMElement, PosNode);
end;

function TXMLNodeListEh.GetNode(const IndexOrName: OleVariant): IXMLNode;
var
  idx: Integer;
  de: TDOMElement;
begin
  if (VarIsNumeric(IndexOrName)) then
  begin
    idx := Integer(IndexOrName);
    de := FDOMElement.ChildNodes[idx] as TDOMElement;
    Result := TXMLNodeEh.Create(de);
  end else
  begin
    Result := FindNode(String(IndexOrName));
  end;
end;

{ NewXMLDocument }

function NewXMLDocument(Version: DOMString = '1.0'): IXMLDocument;
begin
  Result := TXMLDocumentEh.Create;
end;

function TestStreamFormat(Stream: TStream): TStreamOriginalFormat;
var
  Pos: Int64;
  Signature: Integer;
begin
  Pos := Stream.Position;
  Signature := 0;
  Stream.Read(Signature, sizeof(Signature));
  Stream.Position := Pos;
  if (Byte(Signature) = $FF) or (Signature = Integer(FilerSignature)) then
    Result := sofBinary
  else if Char(Signature) in ['o','O','i','I',' ',#13,#11,#9] then
    Result := sofText
  else if (Signature and $00FFFFFF) = $00BFBBEF then
    Result := sofText
  else
    Result := sofUnknown;
end;

function VarTypeToDataType(VarType: Integer): TFieldType;
begin
  case VarType of
    varSmallint: Result := ftSmallInt;
    varShortInt: Result := ftSmallInt;
    varByte: Result := ftSmallInt;
    varWord: Result := ftWord;
    varInteger: Result := ftInteger;
    varCurrency: Result := ftBCD;
    varLongWord: Result := ftWord;
    varSingle: Result := ftFloat;
    varDouble: Result := ftFloat;
    varDate: Result := ftDateTime;
    varBoolean: Result := ftBoolean;
    varString: Result := ftString;
    varUString, varOleStr: Result := ftWideString;
    varInt64: Result := ftLargeInt;
  else
    if ((VarType and varArray) = varArray) and ((VarType and varTypeMask) = varByte) then
      Result := ftBlob
    else
      Result := ftUnknown;
  end;
end;

function DBUseRightToLeftAlignment(AControl: TControl; AField: TField): Boolean;
var
  AAlignment: TAlignment;
begin
  Result := False;
  if Assigned(AField) then
    AAlignment := AField.Alignment
  else
    AAlignment := taLeftJustify;
  Result := (SysLocale.MiddleEast) and (AControl.BiDiMode = bdRightToLeft) and
    (OkToChangeFieldAlignment(AField, AAlignment));
end;

function OkToChangeFieldAlignment(AField: TField; Alignment: TAlignment): Boolean;
begin
  Result := True;
end;

procedure PerformEraseBackground(Control: TControl; DC: HDC);
var
  LastOrigin: TPoint;
begin
  LastOrigin := Point(0, 0);
  GetWindowOrgEx(DC, LastOrigin);
  SetWindowOrgEx(DC, LastOrigin.X + Control.Left, LastOrigin.Y + Control.Top, nil);
  Control.Parent.Perform(WM_ERASEBKGND, WParam(DC), LParam(DC));
  SetWindowOrgEx(DC, LastOrigin.X, LastOrigin.Y, nil);
end;

function DrawTextBiDiModeFlags(Control: TControl; Flags: Longint): Longint;
begin
  Result := Flags;
  { do not change center alignment }
  if Control.UseRightToLeftAlignment then
    if Result and DT_RIGHT = DT_RIGHT then
      Result := Result and not DT_RIGHT { removing DT_RIGHT, makes it DT_LEFT }
    else if not (Result and DT_CENTER = DT_CENTER) then
      Result := Result or DT_RIGHT;
  {$IFDEF FPC}
  {$ELSE}
  Result := Result or Control.DrawTextBiDiModeFlagsReadingOnly;
  {$ENDIF}
end;

function GetFieldProperty(DataSet: TDataSet; Control: TComponent;
  const FieldName: string): TField;
begin
  Result := DataSet.FindField(FieldName);
  if Result = nil then
    DatabaseErrorFmt('SFieldNotFound', [FieldName], Control);
end;

{ TWinControlEh }

procedure TWinControlEh.RecreateWndHandle;
begin
  RecreateWnd(Self);
end;

{ TCustomControlEh }

constructor TCustomControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScaleFactor := 1;
end;

procedure TCustomControlEh.RecreateWndHandle;
begin
  RecreateWnd(Self);
end;

procedure TCustomControlEh.ChangeScale(M, D: Integer);
begin
  if M <> D then
  begin
    FScaleFactor := FScaleFactor * M / D;
  end;
  inherited ChangeScale(M, D);
end;

function TCustomControlEh.ScaleValue(const Value: Integer): Integer;
begin
  Result := MulDiv(Value, Round(FScaleFactor * 100), 100);
end;

function TCustomControlEh.GetSystemMetrics(nIndex: Integer): Integer;
begin
  Result := LCLIntf.GetSystemMetrics(nIndex);
end;

function TCustomControlEh.IsCustomStyleActive: Boolean;
begin
  {$IFDEF EH_LIB_16} // Delphi XE2
    Result := TStyleManager.IsCustomStyleActive;
  {$ELSE}
    Result := False;
  {$ENDIF}
end;

{$ELSE} // ELSE FPC

{$IFDEF EH_LIB_12} //RAD Studio 2009
{$ELSE}
procedure TBitmapEh32bit.Draw(ACanvas: TCanvas; const Rect: TRect);
var
  BF: TBlendFunction;
begin
//  if SupportsPartialTransparency then
  begin
    //We have a 32 bit bitmap with alpha, render with AlphaBlend
    BF.BlendOp := AC_SRC_OVER;
    BF.BlendFlags := 0;
    BF.SourceConstantAlpha := 255;
    BF.AlphaFormat := AC_SRC_ALPHA;

    Windows.AlphaBlend(ACanvas.Handle,
       Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
       Canvas.Handle, 0, 0, Width, Height, BF);
  end;
end;
{$ENDIF}

{ TWinControlEh }

constructor TWinControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TWinControlEh.RecreateWndHandle;
begin
  RecreateWnd;
end;

{$IFDEF FPC}
procedure TWinControlEh.Ctrl3D;
begin
  Return := True;
end;
{$ELSE}
{$ENDIF}

{ TCustomControlEh }

constructor TCustomControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScaleFactor := 1;
end;

procedure TCustomControlEh.RecreateWndHandle;
begin
  RecreateWnd;
end;

procedure TCustomControlEh.ChangeScale(M, D: Integer {$IFDEF EH_LIB_24}; isDpiChange: Boolean {$ENDIF});
begin
  if M <> D then
  begin
  {$IFNDEF EH_LIB_26} 
    FScaleFactor := FScaleFactor * M / D;
  {$ENDIF}
  end;
  inherited ChangeScale(M, D {$IFDEF EH_LIB_24}, isDpiChange{$ENDIF});
end;

{$IFDEF EH_LIB_26} 
{$ELSE}
function TCustomControlEh.GetSystemMetrics(nIndex: Integer): Integer;
begin
  Result := Windows.GetSystemMetrics(nIndex);
end;
{$ENDIF}

{$IFDEF EH_LIB_27} 
{$ELSE}
function TCustomControlEh.ScaleValue(const Value: Integer): Integer;
begin
  Result := MulDiv(Value, Round(FScaleFactor * 100), 100);
end;

function TCustomControlEh.IsCustomStyleActive: Boolean;
begin
{$IFDEF EH_LIB_16} // Delphi XE2
  Result := TStyleManager.IsCustomStyleActive;
{$ELSE}
  Result := False;
{$ENDIF}
end;

{$ENDIF}

{$IFDEF NEXTGEN}
type
  TRefMethodComparer = class(TInterfacedObject, IComparer<TObject>)
    FCompare: TListSortCompare;

    constructor Create(ACompare: TListSortCompare);
    function Compare(const Left, Right: TObject): Integer;
  end;

constructor TRefMethodComparer.Create(ACompare: TListSortCompare);
begin
  FCompare := ACompare;
end;

function TRefMethodComparer.Compare(const Left, Right: TObject): Integer;
begin
  Result := FCompare(Left, Right);
end;
{$ENDIF}

{$ENDIF} 

{ initialization/finalization }
procedure InitUnit;
begin
  NewStyleControls := True; 
end;

procedure FinalUnit;
begin
  {$IFNDEF EH_LIB_16}
    FreeAndNil(FStyleServices);
  {$ENDIF}

  {$IFNDEF EH_LIB_17}
    FreeAndNil(FFormatSettings);
  {$ENDIF}

  FreeScreenCanvas;
  FreeAndNil(BackBitmap);
end;

{ TObjectListEh }

constructor TObjectListEh.Create;
begin
  inherited Create(False);
end;

constructor TObjectListEh.Create(AOwnsObjects: Boolean);
begin
  inherited Create(AOwnsObjects);
end;

procedure TObjectListEh.Sort(Compare: TListSortCompare);
begin
  inherited Sort(Compare);
end;

{ TSortedListEh<T> }

{$IFDEF FPC}
{$ELSE}
function TSortedListEh<T>.Add(const Value: T): Integer;
var
  SearchFound: Boolean;
begin
  SearchFound := BinarySearch(Value, Result);

  if SearchFound then
  begin
    case FDuplicates of
      dupAccept: inherited Insert(Result, Value);
      dupIgnore: Exit;
      dupError: EListError.CreateResFmt(@SDuplicateItem, [Result]);
    end;
  end
  else
  begin
    inherited Insert(Result, Value);
  end;
end;

procedure TSortedListEh<T>.Insert(Index: Integer; const Value: T);
begin
  raise EListError.Create('TSortedListEh<T>.Insert is not supported');
end;
{$ENDIF} //ELSE FPC

initialization
  InitUnit;
finalization
  FinalUnit;
end.

