{
Version   11.9
Copyright (c) 1995-2008 by L. David Baldwin
Copyright (c) 2008-2018 by HtmlViewer Team

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Note that the source modules HTMLGIF1.PAS and DITHERUNIT.PAS
are covered by separate copyright notices located in those modules.
}

{$I frxHTMLCons.inc}

unit frxHTMLUn2;

interface

uses
{$ifdef UseInline}
  Math,
{$endif}
{$ifdef LCL}
  LclIntf, IntfGraphics, FpImage, LclType, LResources, LMessages, frLazHTMLMisc,
{$else}
  Windows,
{$endif}
  SysUtils, Contnrs, Classes, Graphics, ClipBrd, Messages, Variants, Types,
{$ifdef Compiler20_Plus}
  CommCtrl,
{$endif}
  frCore,
  frxHTMLBuffer,
  frGif2,
  frxHTMLGlobals,
  frxHTMLImages,
  frxHTMLStyleTypes,
  frxHTMLSymb;

const
  VersionNo = '11.9';
  MaxHScroll = 100000; {max horizontal display in pixels}
  Tokenleng = 300;
  TopLim = -200; {drawing limits}
  BotLim = 5000;
  FmCtl = WideChar(#2);
  ImgPan = WideChar(#4);
  BrkCh = WideChar(#8);
  htDefFontName = 'Serif';
  htDefPreFontName = 'Monospace';


type
  // BG, 26.12.2011:
  TWidthType = (
    wtNone,
    wtAbsolute,
    wtPercent,
    wtRelative);

  // BG, 26.12.2011:
  TSpecWidth = record
    Value: Integer;
    VType: TWidthType; // treat wtNone like "0*" (Value = 0.0, CType = wtRelative)
  end;

  ThtJustify = (NoJustify, Left, Centered, Right, FullJustify);
  ThtDirection = (diLTR, diRTL, diAuto);
  TRowType = (THead, TBody, TFoot);

//------------------------------------------------------------------------------
// tag attributes
//------------------------------------------------------------------------------

  TfrxHtAttribute = class {holds a tag attribute}
  public
    Which: TAttrSymb; {symbol of attribute such as HrefSy}
    WhichName: ThtString;
    Value: Integer; {numeric value if appropriate}
    DblValue: Double; {numeric value if appropriate}
    Name: ThtString; {ThtString (mixed case), value after '=' sign}
    CodePage: Integer;
    constructor Create(ASym: TAttrSymb; const AValue: Double; const NameStr, ValueStr: ThtString; ACodePage: Integer);
    constructor CreateCopy(ASource: TfrxHtAttribute);
    property AsString: ThtString read Name;
    property AsInteger: Integer read Value;
    property AsDouble: Double read DblValue;
  end;

  TfrxHtAttributeList = class(TObjectList) {a list of tag attributes,(TAttributes)}
  private
    SaveID: ThtString;
    function GetClass: ThtString;
    function GetID: ThtString;
    function GetTitle: ThtString;
    function GetAttribute(Index: TfrListInteger): TfrxHtAttribute; {$ifdef UseInline} inline; {$endif}
  public
    constructor CreateCopy(ASource: TfrxHtAttributeList);
    function Clone: TfrxHtAttributeList; virtual;
    procedure Clear; override;
    function Find(const Name: ThtString; var T: TfrxHtAttribute): Boolean; overload; {$ifdef UseInline} inline; {$endif}
    function Find(Sy: TAttrSymb; var T: TfrxHtAttribute): Boolean; overload; {$ifdef UseInline} inline; {$endif}
    function CreateStringList: ThtStringList;
    property TheClass: ThtString read GetClass;
    property TheID: ThtString read GetID;
    property TheTitle: ThtString read GetTitle;
    property Items[Index: TfrListInteger]: TfrxHtAttribute read GetAttribute; default;
  end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------

  TfrxHtFontObjBaseList = class;

  {holds start and end point of URL text}
  TutText = record //BG, 03.03.2011: changed to record. no need to use a class
    Start: Integer;
    Last: Integer;
  end;

  TfrxHtUrlTarget = class
  public
    URL: ThtString;
    Target: ThtString;
    ID: Integer;
    Attr: ThtString;
    utText: TutText;
    TabIndex: Integer;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(const AnUrl, ATarget: ThtString; L: TfrxHtAttributeList; AStart: Integer); overload;
    procedure Assign(const UT: TfrxHtUrlTarget); overload;
    procedure Clear;
    procedure SetLast(List: TfrxHtFontObjBaseList; ALast: Integer);
    property Start: Integer read utText.Start;
    property Last: Integer read utText.Last;
  end;

  TfrxHtFontObjBase = class {font information}
  public
    UrlTarget: TfrxHtUrlTarget;
  end;

  TfrxHtFontObjBaseList = class(TObjectList)
  private
    function GetBase(Index: TfrListInteger): TfrxHtFontObjBase; {$ifdef UseInline} inline; {$endif}
  public
    property Items[Index: TfrListInteger]: TfrxHtFontObjBase read GetBase; default;
  end;

//------------------------------------------------------------------------------
// indentation manager
//------------------------------------------------------------------------------

  TfrxHtIndentRec = class
  public
    X: Integer;   // left or right indentation relative to LfEdge.
    YT: Integer;  // top Y inclusive coordinate for this record relative to document top.
    YB: Integer;  // bottom Y exclusive coordinate for this record relative to document top.
    ID: TObject;  // block level indicator for this record, 0 for not applicable
  end;

  TfrxHtIndentRecList = class(TObjectList)
  private
    function Get(Index: TfrListInteger): TfrxHtIndentRec; {$ifdef UseInline} inline; {$endif}
  public
    property Items[Index: TfrListInteger]: TfrxHtIndentRec read Get; default;
  end;

  TfrxHtIndentManager = class
  private
    function LeftEdge(Y: Integer): Integer;
    function RightEdge(Y: Integer): Integer;
  public
    LfEdge: Integer;    // left edge of the block content area.
                        // TfrxHtCell.DoLogic calculates with LfEdge = 0.
                        // TfrxHtCell.Draw then may shift the block by setting LfEdge to X.
    Width: Integer;     // width of the block content area.
    ClipWidth: Integer; // clip width ???
    L: TfrxHtIndentRecList;  // list of left side indentations of type IndentRec.
    R: TfrxHtIndentRecList;  // list of right side indentations of type IndentRec.
    CurrentID: TObject; // the current block level (a TfrxHTBlock pointer)
    LTopMin: Integer;
    RTopMin: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function AddLeft(YT, YB, W: Integer): TfrxHtIndentRec;
    function AddRight(YT, YB, W: Integer): TfrxHtIndentRec;
    function AlignLeft(var Y: Integer; W: Integer): Integer;
    function AlignRight(var Y: Integer; W: Integer): Integer;
    function GetNextWiderY(Y: Integer): Integer;
    function ImageBottom: Integer;
    function LeftIndent(Y: Integer): Integer;
    function RightSide(Y: Integer): Integer;
    function SetLeftIndent(XLeft, Y: Integer): Integer;
    function SetRightIndent(XRight, Y: Integer): Integer;
    procedure FreeLeftIndentRec(I: Integer);
    procedure FreeRightIndentRec(I: Integer);
    procedure GetClearY(out CL, CR: Integer);
    procedure Init(Lf, Wd: Integer);
    procedure Reset(Lf: Integer);
    // AdjustY() is called after an inline row has been produced. If floating objects have been moved
    // down before the actual height of the entire row was computed, their Y coordinates aren't too
    // small now. AdjustY() moves them down below given Y + Height.
    procedure AdjustY(FirstLeftIndex, FirstRightIndex, Y, Height: Integer);
  end;

//------------------------------------------------------------------------------
// parser
//------------------------------------------------------------------------------

  {Simplified variant of TokenObj, to temporarily keep a ThtString of unicode
   characters along with their original indices.}

  { TfrxHtCharCollection }

  TfrxHtCharCollection = class
  private
    FChars: ThtString;
    FIndices: array of Integer;
    FCurrentIndex: Integer;
    function GetSize: Integer;
    function GetAsString: ThtString;
    function GetCapacity: Integer;
    procedure SetCapacity(NewCapacity: Integer);
  public
    constructor Create;
    procedure Add(C: ThtChar; Index: Integer); overload;
    procedure Add(const S: ThtString; Index: Integer); overload;
    procedure Clear;
//    procedure Concat(T: TfrxHtCharCollection);

    property AsString: ThtString read GetAsString;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Size: Integer read GetSize;
  end;

  { TokenObj }

  TfrxHtTokenObj = class
  private
    St: UnicodeString;
    StringOK: boolean;
    FCount: Integer;
    function GetCapacity: Integer;
    function GetString: UnicodeString;
    procedure SetCapacity(NewCapacity: Integer);
  public
    C: array of ThtChar;
    I: array of Integer;
    constructor Create;
    procedure AddUnicodeChar(Ch: WideChar; Ind: Integer);
    procedure AddString(S: TfrxHtCharCollection);
    procedure Clear;

    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read FCount;
    property S: UnicodeString read GetString;
  end;

//------------------------------------------------------------------------------
// TfrxHtIDObject is base class for all tag objects.
//------------------------------------------------------------------------------
// If they have an ID, the parser puts them into the HtmlViewer's IDNameList,
// a TfrxHtIDObjectList, where they can be obtained from by ID.
// Their Y coordinates can be retrieved and HtmlViewer can scroll to them.
//
// Most descendants are objects representing an HTML tag, except TfrxHtChPosObj.
//------------------------------------------------------------------------------

  TfrxHtIDObject = class
  private
    function GetId(): ThtString; //>-- DZ
  protected
    FHtmlId: ThtString; //>-- DZ real ID from HTML if any
    FGlobalId: ThtString; //>-- DZ global unique ID

    function GetYPosition: Integer; virtual; abstract;
    function FreeMe: Boolean; virtual; // some objects the TIDObjectsList owns, some others not.
  public
    constructor Create(const AHtmlID: ThtString);

    property YPosition: Integer read GetYPosition;
    property Id: ThtString read GetId; //>-- DZ if FhtmlId then FglobalId will be returned as result
    property HtmlId: ThtString read FHtmlId; //>-- DZ
    property GlobalId: ThtString read FGlobalId; //>-- DZ
  end;

  //BG, 04.03.2011: TIDNameList renamed to TfrxHtIDObjectList and used TObject changed to TfrxHtIDObject.
  TfrxHtIDObjectList = class(ThtStringList)
  private
    function GetObject(Index: Integer): TfrxHtIDObject; reintroduce;
  public
    constructor Create;
    destructor Destroy; override;
    function AddObject(const S: ThtString; AObject: TfrxHtIDObject): Integer; reintroduce;
    procedure Clear; override;
    property Objects[Index: Integer]: TfrxHtIDObject read GetObject; default;
  end;

  ThtColorArray = packed array[0..3] of TColor;
  ThtBorderStyleArray = packed array[0..3] of ThtBorderStyle;

//BG, 11.09.2010: moved to this unit to reduce circular dependencies:

  ThtguResultType = set of (guUrl, guControl, guTitle);

//------------------------------------------------------------------------------
// TfrxHtControlBase is base class for TfrxHtViewerBase and TFrameBase
//------------------------------------------------------------------------------

  TfrxHtControlBase = class(TPersistent);

//------------------------------------------------------------------------------
// TfrxHtViewerBase is base class for THtmlViewer and TFrameViewer
//------------------------------------------------------------------------------

  TGetStreamEvent = procedure(Sender: TObject; const SRC: ThtString; var Stream: TStream) of object;
  TGottenStreamEvent = TGetStreamEvent;
  TIncludeType = procedure(Sender: TObject; const Command: ThtString; Params: ThtStrings; out IncludedDocument: TBuffer) of object;
  TLinkType = procedure(Sender: TObject; const Rel, Rev, Href: ThtString) of object;
  TMetaType = procedure(Sender: TObject; const HttpEq, Name, Content: ThtString) of object;
  TPagePrinted = procedure(Sender: TObject; Canvas: TCanvas; NumPage, W, H: Integer; var StopPrinting: Boolean) of object;
  TParseEvent = procedure(Sender: TObject; var Source: TBuffer) of object;
  TProcessingEvent = procedure(Sender: TObject; ProcessingOn: Boolean) of object;
  TScriptEvent = procedure(Sender: TObject; const Name, ContentType, Src, Script: ThtString) of object;
  TSoundType = procedure(Sender: TObject; const SRC: ThtString; Loop: Integer; Terminate: boolean) of object;
  THTMLViewPrinted = TNotifyEvent;
  THTMLViewPrinting = procedure(Sender: TObject; var StopPrinting: Boolean) of object;
  TLinkDrawnEvent = procedure(Sender: TObject; Page: Integer; const Url, Target: ThtString; ARect: TRect) of object;
  TFileBrowseEvent = procedure(Sender, Obj: TObject; var S: ThtString) of object;
  TGetImageEvent = procedure(Sender: TObject; const SRC: ThtString; var Stream: TStream) of object;
  TGottenImageEvent = TGetImageEvent;

  TfrxHtViewerBase = class(TfrxHtControlBase)
  private
    FBackGround, FHotSpotColor, FVisitedColor, FOverColor: TColor;
    FCharset: TFontCharset;
    FCodePage: TBuffCodePage;
    FFontColor: TColor;
    FFontName, FPreFontName: TFontName;
    FFontSize: Double;
    FHistoryMaxCount, FVisitedMaxCount: Integer;
    FMarginWidth, FMarginHeight: Integer;
    FNoSelect: Boolean;
    FPrintMarginLeft, FPrintMarginRight, FPrintMarginTop, FPrintMarginBottom: Double;
    FPrintMaxHPages: Integer;
    FServerRoot: ThtString;
    //
    function StoreFontName: Boolean;
    function StorePreFontName: Boolean;
  protected
    procedure SetActiveColor(const Value: TColor); virtual;
    procedure SetCharset(const Value: TFontCharset); virtual;
    procedure SetCodePage(const Value: Integer); virtual;
    procedure SetDefBackground(const Value: TColor); virtual;
    procedure SetFontColor(const Value: TColor); virtual;
    procedure SetFontName(const Value: TFontName); virtual;
    procedure SetFontSize(const Value: Double); virtual;
    procedure SetHistoryMaxCount(const Value: Integer); virtual;
    procedure SetHotSpotColor(const Value: TColor); virtual;
    procedure SetMarginHeight(const Value: Integer); virtual;
    procedure SetMarginWidth(const Value: Integer); virtual;
    procedure SetNoSelect(const Value: Boolean); virtual;
    procedure SetPreFontName(const Value: TFontName); virtual;
    procedure SetPrintMarginBottom(const Value: Double); virtual;
    procedure SetPrintMarginLeft(const Value: Double); virtual;
    procedure SetPrintMarginRight(const Value: Double); virtual;
    procedure SetPrintMarginTop(const Value: Double); virtual;
    procedure SetPrintMaxHPages(const Value: Integer); virtual;
    procedure SetServerRoot(const Value: ThtString); virtual;
    procedure SetVisitedColor(const Value: TColor); virtual;
    procedure SetVisitedMaxCount(const Value: Integer); virtual;
  public
    constructor Create; virtual;
    constructor CreateCopy(Source: TfrxHtViewerBase); virtual;
    // Load(Url): Url might be an absolute Url or an absolute PathName or a relative Url/PathName.
    procedure Load(const Url: ThtString); virtual; abstract;
    // HtmlExpandFilename(Filename, CurrentFilename): Try to get the absolute pathname of the given filename in the local filesystem
    function HtmlExpandFilename(const Filename: ThtString; const CurrentFilename: ThtString = ''): ThtString; virtual; abstract;
    // set to determine if child objects should be in "quirks" mode
    property CodePage: Integer read FCodePage write SetCodePage default 0;
    property CharSet: TFontCharset read FCharSet write SetCharset default DEFAULT_CHARSET;
    property DefBackground: TColor read FBackground write SetDefBackground default clBtnFace;
    property DefFontColor: TColor read FFontColor write SetFontColor default clBtnText;
    property DefFontName: TFontName read FFontName write SetFontName stored StoreFontName;
    property DefFontSize: Double read FFontSize write SetFontSize;
    property DefHotSpotColor: TColor read FHotSpotColor write SetHotSpotColor default clBlue;
    property DefOverLinkColor: TColor read FOverColor write SetActiveColor default clBlue;
    property DefPreFontName: TFontName read FPreFontName write SetPreFontName stored StorePreFontName;
    property DefVisitedLinkColor: TColor read FVisitedColor write SetVisitedColor default clPurple;
    property HistoryMaxCount: Integer read FHistoryMaxCount write SetHistoryMaxCount;
    property MarginHeight: Integer read FMarginHeight write SetMarginHeight default 5;
    property MarginWidth: Integer read FMarginWidth write SetMarginWidth default 10;
    property NoSelect: Boolean read FNoSelect write SetNoSelect;
    property PrintMarginBottom: Double read FPrintMarginBottom write SetPrintMarginBottom;
    property PrintMarginLeft: Double read FPrintMarginLeft write SetPrintMarginLeft;
    property PrintMarginRight: Double read FPrintMarginRight write SetPrintMarginRight;
    property PrintMarginTop: Double read FPrintMarginTop write SetPrintMarginTop;
    property PrintMaxHPages: Integer read FPrintMaxHPages write SetPrintMaxHPages default 2;
    property ServerRoot: ThtString read FServerRoot write SetServerRoot;
    property VisitedMaxCount: Integer read FVisitedMaxCount write SetVisitedMaxCount default 50;
  published
  end;

  TTablePartType = (Normal, DoHead, DoBody1, DoBody2, DoBody3, DoFoot);
  TTablePartRec = class
  public
    TablePart: TTablePartType;
    PartStart: Integer;
    PartHeight: Integer;
    FootHeight: Integer;
  end;

  TfrxHtmlViewerBase = class(TfrxHtViewerBase)
  protected
    FWidth: Integer;
    FHeight: Integer;
  public
    TablePartRec: TTablePartRec;

    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
  end;

//------------------------------------------------------------------------------
// string methods
//------------------------------------------------------------------------------

function StrLenW(Str: PWideChar): Cardinal;
function StrPosW(Str, SubStr: PWideChar): PWideChar;
function StrScanW(const Str: PWideChar; Chr: WideChar): PWideChar;
function StrRScanW(const Str: PWideChar; Chr: WideChar): PWideChar;
function WidePos(SubStr, S: UnicodeString): Integer;
function WideSameText1(const S1, S2: UnicodeString): boolean; {$ifdef UseInline} inline; {$endif}
function WideSameStr1(const S1, S2: UnicodeString): boolean;  {$ifdef UseInline} inline; {$endif}

//function WideStringToMultibyte(CodePage: Integer; W: UnicodeString): AnsiString;

function FitText(DC: HDC; S: PWideChar; Max, Width: Integer; out Extent: TSize): Integer;
function GetTextExtent(DC: HDC; P: PWideChar; N: Integer): TSize;
procedure WrapTextW(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; S: UnicodeString);

//------------------------------------------------------------------------------
// misc. methods
//------------------------------------------------------------------------------

// BG, 26.12.2011: new type TSpecWidth
function SpecWidth(Value: Integer; VType: TWidthType): TSpecWidth;
function ToSpecWidth(AsInteger: Integer; AsString: ThtString): TSpecWidth;

//------------------------------------------------------------------------------
// canvas methods
//------------------------------------------------------------------------------

function CalcClipRect(Canvas: TCanvas; const Rect: TRect; Printing: boolean): TRect;
procedure GetClippingRgn(Canvas: TCanvas; const ARect: TRect; Printing: boolean; var Rgn, SaveRgn: HRgn);

procedure FillRectWhite(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; Color: TColor);
procedure DrawBorder(Canvas: TCanvas; ORect, IRect: TRect; const C: ThtColorArray;
  const S: ThtBorderStyleArray; BGround: TColor; Print: boolean);

function DirectionByText(WC: PWideChar; Len: Integer): ThtDirection;

type
  THtBorderPointArray = array[0..3] of TPoint;

implementation

uses
  Forms,  {$ifndef UseInline} Math, {$endif}
  {$ifdef UseVCLStyles}
  Vcl.Themes,
  VCL.Controls,
  {$endif}
  {$ifdef  HasSystemUITypes}
  System.UITypes,
  {$endif}
  {$ifndef FPC_TODO}jpeg, {$endif}
  {$IFDEF UNICODE} PngImage, {$ENDIF}
   frxHTMLStylePars;

function DirectionByText(WC: PWideChar; Len: Integer): ThtDirection;
var
  i: Integer;
  C: Word;

  function Range(w1, w2: Word): Boolean;
  begin
    Result := (C >= w1) and (C <= w2);
  end;
begin
  Result := diLTR;
  for i := 0 to Len - 1 do
  begin
    C := Word(WC[i]);
    if      (C = $200E) // LEFT-TO-RIGHT MARK
         or Range($0041, $005A) or Range($0061, $007A) or Range($00C0, $00D6) or Range($00D8, $00F6) or Range($00F8, $01F1) // Latin
         or Range($0400, $04FF) or Range($0500, $052F) or Range($2DE0, $2DFF) or Range($A640, $A69F) or Range($1C80, $1C8F) // Cyrillic
         or Range($0370, $03FF) or Range($1F00, $1FFF) // Greek and Coptic
         or Range($0530, $058F) or Range($FB00, $FB4F) // Armenian
         or Range($10A0, $10FF) or Range($2D00, $2D2F) or Range($1C90, $1CBF) // Georgian
         or Range($1200, $137F) or Range($1380, $139F) or Range($2D80, $2DDF) or Range($AB00, $AB2F) // Ethiopic
    then
      Break
    else if (C = $200F) // RIGHT-TO-LEFT MARK (RLM)
         or (C = $061C) // ARABIC LETTER MARK (ALM)
         or Range($0590, $05FF) or Range($FB00, $FB4F) // Hebrew
         or Range($0600, $06FF) or Range($0750, $077F) or Range($08A0, $08FF) or Range($0870, $089F) or Range($FB50, $FDFF) or Range($FB50, $FDFF) // Arabic
         or Range($0700, $074F) or Range($0860, $086F) // Syriac
         or Range($0840, $085F) // Mandaic
         or Range($07C0, $07FF) // NKo
         or Range($0800, $083F) // Samaritan
         or Range($0780, $07BF) // Thaana
    then
    begin
      Result := diRTL;
      Break;
    end;
  end;
end;

function StrLenW(Str: PWideChar): Cardinal;
 {$ifdef UseInline} inline; {$endif}
begin
  Result := 0;
  if Str <> nil then
    while Str[Result] <> #0 do
      Inc(Result);
end;

function StrPosW(Str, SubStr: PWideChar): PWideChar;
 {$ifdef UseInline} inline; {$endif}
var
  StrPos    : PWideChar;
  SubstrPos : PWideChar;
begin
  if SubStr^ = #0 then  // Make sure substring not null string
  begin
    Result := nil;
    Exit;
  end;
  Result := Str;
  while Result^ <> #0 do  // Until reach end of string
  begin
    StrPos := Result;
    SubstrPos := SubStr;
    while SubstrPos^ <> #0 do  // Until reach end of substring
    begin
      if StrPos^ <> SubstrPos^ then  // No point in continuing?
        Break;
      StrPos := StrPos + 1;
      SubstrPos := SubstrPos + 1;
    end;
    if SubstrPos^ = #0 then  // Break because reached end of substring?
      Exit;
    Result := Result + 1;
  end;
  Result := nil;
end;

function StrRScanW(const Str: PWideChar; Chr: WideChar): PWideChar;
 {$ifdef UseInline} inline; {$endif}
begin
  Result := StrScanW(Str, #0);
  if Chr = #0 then  // Null-terminating char considered part of string.
    Exit;
  while Result <> Str do
  begin
    Result := Result - 1;
    if Result^ = Chr then
      Exit;
  end;
  Result := nil;
end;

function StrScanW(const Str: PWideChar; Chr: WideChar): PWideChar;
 {$ifdef UseInline} inline; {$endif}
begin
  Result := Str;
  while Result^ <> #0 do
  begin
    if Result^ = Chr then
      Exit;
    Result := Result + 1;
  end;
  if Chr = #0 then
    Exit;  // Null-terminating char considered part of string. See call
           // searching for #0 to find end of string.
  Result := nil;
end;

{----------------FitText}

function FitText(DC: HDC; S: PWideChar; Max, Width: Integer; out Extent: TSize): Integer;
 {$ifdef UseInline} inline; {$endif}
{return count <= Max which fits in Width.  Return X, the extent of chars that fit}
var
  Ints: array of Integer;
begin
  Extent.cx := 0;
  Extent.cy := 0;
  Result := 0;
  if (Width <= 0) or (Max = 0) then
    Exit;

  SetLength(Ints, Max);
  if GetTextExtentExPointW(DC, S, Max, Width, @Result, @Ints[0], Extent) then
    if Result > 0 then
      Extent.cx := Ints[Result - 1]
    else
      Extent.cx := 0;

end;

{----------------WidePos}

function WidePos(SubStr, S: UnicodeString): Integer;
 {$ifdef UseInline} inline; {$endif}
// Unicode equivalent for Pos() function.
var
  P: PWideChar;
begin
  P := StrPosW(PWideChar(S), PWideChar(SubStr));
  if P = nil then
    Result := 0
  else
    Result := P - PWideChar(S) + 1;
end;

function WideSameText1(const S1, S2: UnicodeString): boolean;
 {$ifdef UseInline} inline; {$endif}
begin
  Result := htUpperCase(S1) = htUpperCase(S2);
end;

function WideSameStr1(const S1, S2: UnicodeString): boolean;
 {$ifdef UseInline} inline; {$endif}
begin
  Result := S1 = S2;
end;

//-- BG ---------------------------------------------------------- 06.10.2010 --
function ScaleRect(const Rect: TRect; ScaleX, ScaleY: Double): TRect;
 {$ifdef UseInline} inline; {$endif}
begin
  Result.Left := Round(Rect.Left * ScaleX);
  Result.Right := Round(Rect.Right * ScaleX);
  Result.Top := Round(Rect.Top * ScaleY);
  Result.Bottom := Round(Rect.Bottom * ScaleY);
end;

//-- BG ---------------------------------------------------------- 06.10.2010 --
function CalcClipRect(Canvas: TCanvas; const Rect: TRect; Printing: boolean): TRect;
 {$ifdef UseInline} inline; {$endif}
var
  Point: TPoint;
  SizeV, SizeW: TSize;
begin
  GetWindowOrgEx(Canvas.Handle, Point); {when scrolling or animated Gifs, canvas may not start at X=0, Y=0}
  Result := Rect;
  OffsetRect(Result, -Point.X, -Point.Y);
  if Printing then
  begin
    GetViewportExtEx(Canvas.Handle, SizeV);
    GetWindowExtEx(Canvas.Handle, SizeW);
    Result := ScaleRect(Result, SizeV.cx / SizeW.cx, SizeV.cy / SizeW.cy);
  end;
end;

procedure GetClippingRgn(Canvas: TCanvas; const ARect: TRect; Printing: boolean; var Rgn, SaveRgn: HRgn);
 {$ifdef UseInline} inline; {$endif}
var
  Point: TPoint;
  SizeV, SizeW: TSize;
  HF, VF: double;
  Rslt: Integer;
begin
{find a clipregion to prevent overflow.  First check to see if there is
 already a clip region.  Return the old region, SaveRgn, (or 0) so it can be
 restored later.}
  SaveRgn := CreateRectRgn(0, 0, 1, 1);
  Rslt := GetClipRgn(Canvas.Handle, SaveRgn); {Rslt = 1 for existing region, 0 for none}
  if Rslt = 0 then
  begin
    DeleteObject(SaveRgn);
    SaveRgn := 0;
  end;
{Form the region}
  GetWindowOrgEx(Canvas.Handle, Point); {when scrolling or animated Gifs, canvas may not start at X=0, Y=0}
  with ARect do
    if not Printing then
      Rgn := CreateRectRgn(Left - Point.X, Top - Point.Y, Right - Point.X, Bottom - Point.Y)
    else
    begin
      GetViewportExtEx(Canvas.Handle, SizeV);
      GetWindowExtEx(Canvas.Handle, SizeW);
      HF := (SizeV.cx / SizeW.cx); {Horizontal adjustment factor}
      VF := (SizeV.cy / SizeW.cy); {Vertical adjustment factor}
      Rgn := CreateRectRgn(Round(HF * (Left - Point.X)), Round(VF * (Top - Point.Y)), Round(HF * (Right - Point.X)), Round(VF * (Bottom - Point.Y)));
    end;
  if Rslt = 1 then {if there was a region, use the intersection with this region}
    CombineRgn(Rgn, Rgn, SaveRgn, Rgn_And);
end;

function WideTrim(const S: UnicodeString): UnicodeString;
 {$ifdef UseInline} inline; {$endif}
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do
    Inc(I);
  if I > L then
    Result := ''
  else
  begin
    while S[L] <= ' ' do
      Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

procedure WrapTextW(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; S: UnicodeString);
 {$ifdef UseInline} inline; {$endif}
{Wraps text in a clipping rectangle. Font must be set on entry}
var
  ARect: TRect;
  TAlign: Integer;
begin
  TAlign := SetTextAlign(Canvas.Handle, TA_Top or TA_Left);
  ARect := Rect(X1, Y1, X2, Y2);
  DrawTextW(Canvas.Handle, PWideChar(S), Length(S), ARect, DT_Wordbreak);
  SetTextAlign(Canvas.Handle, TAlign);
end;

function GetTextExtent(DC: HDC; P: PWideChar; N: Integer): TSize;
 {$ifdef UseInline} inline; {$endif}
var
  Dummy: Integer;
begin
  GetTextExtentExPointW(DC, P, N, 0, @Dummy, nil, Result)
end;

procedure FillRectWhite(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; Color: TColor);
 {$ifdef UseInline} inline; {$endif}
var
  OldBrushStyle: TBrushStyle;
  OldBrushColor: TColor;
begin
  with Canvas do
  begin
    OldBrushStyle := Brush.Style; {save style first}
    OldBrushColor := Brush.Color;
    Brush.Color := ThemedColor(Color);
    Brush.Style := bsSolid;
    FillRect(Rect(X1, Y1, X2, Y2));
    Brush.Color := OldBrushColor;
    Brush.Style := OldBrushStyle; {style after color as color changes style}
  end;
end;

{$IFDEF Ver90}

procedure Assert(B: boolean; const S: ThtString);
begin {dummy Assert for Delphi 2}
end;
{$ENDIF}

//-- BG ---------------------------------------------------------- 26.12.2011 --
function SpecWidth(Value: Integer; VType: TWidthType): TSpecWidth;
 {$ifdef UseInline} inline; {$endif}
begin
  Result.Value := Value;
  Result.VType := VType;
end;

//-- BG ---------------------------------------------------------- 26.12.2011 --
function ToSpecWidth(AsInteger: Integer; AsString: ThtString): TSpecWidth;
// Return a TSpecWidth prepared with values given in AsInteger *and* AsString.
// AsString is used to evaluate the type while AsInteger is used to evaluate the value.
// BG, 26.12.2011: Currently percentage is still converted to permille as done before Value became type Integer.
 {$ifdef UseInline} inline; {$endif}
begin
  if Pos('%', AsString) > 0 then
  begin
    Result.Value := Min(100, AsInteger) * 10;
    Result.VType := wtPercent;
  end
  else if Pos('*', AsString) > 0 then // this is not specified for <td>, <th>. Only <col> and <colgroup> support it officially.
  begin
    Result.Value := AsInteger;
    Result.VType := wtRelative;
  end
  else
  begin
    Result.Value := AsInteger;
    Result.VType := wtAbsolute;
  end;
end;

{ TfrxHtAttribute }

constructor TfrxHtAttribute.Create(ASym: TAttrSymb; const AValue: Double; const NameStr, ValueStr: ThtString; ACodePage: Integer);
begin
  inherited Create;
  Which := ASym;
  DblValue := AValue;
  Value := Trunc(AValue);
  WhichName := NameStr;
  Name := ValueStr;
  CodePage := ACodePage;
end;

//-- BG ---------------------------------------------------------- 27.01.2013 --
constructor TfrxHtAttribute.CreateCopy(ASource: TfrxHtAttribute);
begin
  inherited Create;
  Which := ASource.Which;
  WhichName := ASource.WhichName;
  Value := ASource.Value;
  DblValue := ASource.DblValue;
  Name := ASource.Name;
  CodePage := ASource.CodePage;
end;

{----------------TfrxHtAttributeList}

procedure TfrxHtAttributeList.Clear;
begin
  inherited Clear;
  SaveID := '';
end;

//-- BG ---------------------------------------------------------- 21.10.2016 --
function TfrxHtAttributeList.Clone: TfrxHtAttributeList;
begin
  Result := TfrxHtAttributeList.CreateCopy(Self);
end;

//-- BG ---------------------------------------------------------- 27.01.2013 --
constructor TfrxHtAttributeList.CreateCopy(ASource: TfrxHtAttributeList);
var
  I: Integer;
begin
  inherited Create;
  if ASource <> nil then
    for I := 0 to ASource.Count - 1 do
      Add(TfrxHtAttribute.CreateCopy(ASource[I]));
end;

function TfrxHtAttributeList.CreateStringList: ThtStringList;
var
  I: Integer;
begin
  Result := ThtStringList.Create;
  for I := 0 to Count - 1 do
    with Items[I] do
      Result.Add(WhichName + '=' + Name);
end;

function TfrxHtAttributeList.Find(const Name: ThtString; var T: TfrxHtAttribute): Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I].WhichName = Name then
    begin
      Result := True;
      T := Items[I];
      Exit;
    end;
  Result := False;
end;

function TfrxHtAttributeList.Find(Sy: TAttrSymb; var T: TfrxHtAttribute): Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I].Which = Sy then
    begin
      Result := True;
      T := Items[I];
      Exit;
    end;
  Result := False;
end;

function TfrxHtAttributeList.GetAttribute(Index: TfrListInteger): TfrxHtAttribute;
begin
  Result := Get(Index);
end;

function TfrxHtAttributeList.GetClass: ThtString;
var
  T: TfrxHtAttribute;
  S: ThtString;
  I: Integer;
begin
  Result := '';
  T := nil;
  if Find(ClassSy, T) then
  begin
    S := Lowercase(Trim(T.Name));
    I := Pos(' ', S);
    if I <= 0 then {a single class name}
      Result := S
    else
    begin {multiple class names.  Format as "class1.class2.class3"}
      repeat
        Result := Result + '.' + System.Copy(S, 1, I - 1);
        System.Delete(S, 1, I);
        S := Trim(S);
        I := Pos(' ', S);
      until I <= 0;
      Result := Result + '.' + S;
      Result := SortContextualItems(Result); {put in standard multiple order}
      System.Delete(Result, 1, 1); {remove initial '.'}
    end;
  end;
end;

function TfrxHtAttributeList.GetID: ThtString;
var
  T: TfrxHtAttribute;
begin
  Result := SaveID;
  T := nil;
  if (Result = '') and Find(IDSy, T) then
  begin
    Result := Lowercase(T.Name);
    SaveID := Result;
  end;
end;

function TfrxHtAttributeList.GetTitle: ThtString;
var
  T: TfrxHtAttribute;
begin
  T := nil;
  if Find(TitleSy, T) then
    Result := T.Name
  else
    Result := '';
end;

{----------------TfrxHtUrlTarget.Create}

constructor TfrxHtUrlTarget.Create;
begin
  inherited Create;
  //utText := TutText.Create;
  utText.Start := -1;
  utText.Last := -1;
end;

destructor TfrxHtUrlTarget.Destroy;
begin
  //FreeAndNil(utText);
  inherited Destroy;
end;

var
  Sequence: Integer = 10;

procedure TfrxHtUrlTarget.Assign(const AnUrl, ATarget: ThtString; L: TfrxHtAttributeList; AStart: Integer);
var
  SL: ThtStringList;
begin
  Url := AnUrl;
  Target := ATarget;
  ID := Sequence;
  Inc(Sequence);
  utText.Start := AStart;
  SL := L.CreateStringList;
  try
    Attr := SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TfrxHtUrlTarget.Assign(const UT: TfrxHtUrlTarget);
begin
  Url := UT.Url;
  Target := UT.Target;
  ID := UT.ID;
  TabIndex := UT.TabIndex;
  Attr := UT.Attr;
  utText.Start := UT.utText.Start;
  utText.Last := UT.utText.Last;
end;

procedure TfrxHtUrlTarget.Clear;
begin
  Url := '';
  Target := '';
  ID := 0;
  TabIndex := 0;
  Attr := '';
  utText.Start := -1;
  utText.Last := -1;
end;

procedure TfrxHtUrlTarget.SetLast(List: TfrxHtFontObjBaseList; ALast: Integer);
var
  I: Integer;
begin
  utText.Last := ALast;
  if List.Count > 0 then
    for I := List.Count - 1 downto 0 do
      if ID = List[I].UrlTarget.ID then
        List[I].UrlTarget.utText.Last := ALast
      else
        Break;
end;

{ TfrxHtIndentManager }

constructor TfrxHtIndentManager.Create;
begin
  inherited Create;
  R := TfrxHtIndentRecList.Create;
  L := TfrxHtIndentRecList.Create;
end;

destructor TfrxHtIndentManager.Destroy;
begin
  R.Free;
  L.Free;
  inherited Destroy;
end;

//-- BG ---------------------------------------------------------- 05.02.2011 --
function TfrxHtIndentManager.AddLeft(YT, YB, W: Integer): TfrxHtIndentRec;
// For a floating block, update the left edge information.
begin
  Result := TfrxHtIndentRec.Create;
  Result.YT := YT;
  Result.YB := YB;
  Result.X := LeftEdge(YT) + W;
  L.Add(Result);
  LTopMin := YT;
end;

//-- BG ---------------------------------------------------------- 05.02.2011 --
function TfrxHtIndentManager.AddRight(YT, YB, W: Integer): TfrxHtIndentRec;
// For a floating block, update the right edge information.
begin
  Result := TfrxHtIndentRec.Create;
  Result.YT := YT;
  Result.YB := YB;
  Result.X := RightEdge(YT) - W;
  R.Add(Result);
  RTopMin := YT;
end;

//-- BG ---------------------------------------------------------- 12.08.2013 --
procedure TfrxHtIndentManager.AdjustY(FirstLeftIndex, FirstRightIndex, Y, Height: Integer);
var
  I, D: Integer;
  IR: TfrxHtIndentRec;
begin
  D := 0;
  for I := FirstLeftIndex to L.Count - 1 do
  begin
    IR := L[I];
    if IR.YT > Y then
    begin
      if IR.YT < Y + Height then
        D := Y + Height - IR.YT;
      Inc(IR.YT, D);
      Inc(IR.YB, D);
    end;
  end;

  D := 0;
  for I := FirstRightIndex to R.Count - 1 do
  begin
    IR := R[I];
    if IR.YT > Y then
    begin
      if IR.YT < Y + Height then
        D := Y + Height - IR.YT;
      Inc(IR.YT, D);
      Inc(IR.YB, D);
    end;
  end;
end;

{----------------TfrxHtIndentManager.Reset}

//-- BG ---------------------------------------------------------- 23.02.2011 --
procedure TfrxHtIndentManager.Init(Lf, Wd: Integer);
begin
  LfEdge := Lf;
  Width  := Wd;
  R.Clear;
  L.Clear;
  LTopMin := 0;
  RTopMin := 0;
  CurrentID := nil;
end;

procedure TfrxHtIndentManager.Reset(Lf: Integer);
begin
  LfEdge := Lf;
  CurrentID := nil;
end;

const
  BigY = 9999999;

//-- BG ---------------------------------------------------------- 23.02.2011 --
function TfrxHtIndentManager.LeftEdge(Y: Integer): Integer;
// Returns the right most left indentation at Y relative to LfEdge.
// If there are no left indentations at Y, returns 0.
var
  I: Integer;
  IR: TfrxHtIndentRec;
  MinX: Integer;
begin
  Result := -MaxInt;
  MinX := 0;
  for I := 0 to L.Count - 1 do
  begin
    IR := L[I];
    if (Y >= IR.YT) and (Y < IR.YB) and (Result < IR.X) then
      if (IR.ID = nil) or (IR.ID = CurrentID) then
        Result := IR.X;
    if IR.ID = CurrentID then
      MinX := IR.X;
  end;
  if Result = -MaxInt then
    Result := MinX;
end;

//-- BG ---------------------------------------------------------- 23.02.2011 --
function TfrxHtIndentManager.LeftIndent(Y: Integer): Integer;
// Returns the right most left indentation at Y relative to block.
// If there are no left indentations at Y, returns LfEdge.
begin
  Result := LeftEdge(Y) + LfEdge;
end;

//-- BG ---------------------------------------------------------- 23.02.2011 --
function TfrxHtIndentManager.RightEdge(Y: Integer): Integer;
// Returns the left most right indentation at Y relative LfEdge.
// If there are no indentations at Y, returns Width.
var
  I: Integer;
  IR: TfrxHtIndentRec;
  MinX: Integer;
begin
  Result := MaxInt;
  for I := 0 to R.Count - 1 do
  begin
    IR := R[I];
    if (Y >= IR.YT) and (Y < IR.YB) and (Result > IR.X) then
      if (IR.ID = nil) or (IR.ID = CurrentID) then
        Result := IR.X;
  end;
  if Result = MaxInt then
  begin
    //BG, 01.03.2011: Issue 77: Error of the elements
    MinX := 0;
    for I := L.Count - 1 downto 0 do
    begin
      IR := L[I];
      if IR.ID = CurrentID then
      begin
        MinX := IR.X;
        break;
      end;
    end;
    Result := Width + MinX;
  end;
end;

//-- BG ---------------------------------------------------------- 23.02.2011 --
function TfrxHtIndentManager.RightSide(Y: Integer): Integer;
// Returns the left most right indentation at Y relative to block.
// If there are no indentations at Y, returns Width + LfEdge.
begin
  Result := RightEdge(Y) + LfEdge;
end;

function TfrxHtIndentManager.ImageBottom: Integer;
// Returns the bottom of the last floating image.
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to L.Count - 1 do
    with L[I] do
      if (ID = nil) and (YB > Result) then
        Result := YB;
  for I := 0 to R.Count - 1 do
    with R[I] do
      if (ID = nil) and (YB > Result) then
        Result := YB;
end;

procedure TfrxHtIndentManager.GetClearY(out CL, CR: Integer);
{returns the left and right Y values which will clear image margins}
var
  I: Integer;
begin
  CL := -1;
  for I := 0 to L.Count - 1 do
    with L[I] do
      if (ID = nil) and (YB > CL) then
        CL := YB;
  CR := -1;
  for I := 0 to R.Count - 1 do
    with R[I] do
      if (ID = nil) and (YB > CR) then
        CR := YB;
  Inc(CL);
  Inc(CR);
end;

//-- BG ---------------------------------------------------------- 06.02.2011 --
function TfrxHtIndentManager.AlignLeft(var Y: Integer; W: Integer): Integer;
// Find an available area to the left at or below Y with a width of W pixels.
//
// Returns the absolute X position of the found area.
// On return Y may be adjusted to a larger value if at original Y there is not
// enough width W.
var
  I, CL, CR, LX, RX, XL, XR, YY, MinX: Integer;
begin
  Y := Max(Y, LTopMin);
  Result := LeftEdge(Y);
  if Result + W > RightEdge(Y) then
  begin
    // too wide, must find a wider place below:
    YY := Y;
    MinX := 0;

    CL := Y;
    XL := Result; // valium for the compiler
    for I := L.Count - 1 downto 0 do
      with L[I] do
      begin
        if ID = CurrentID then
        begin
          MinX := X;
          break;
        end;
        if (ID = nil) and (YB > Y) and ((YB < CL) or (CL = Y)) then
        begin
          if X = LeftEdge(YB - 1) then
          begin
            // This is the right most left indentation
            LX := LeftEdge(YB);
            RX := RightEdge(YB) - W;
            if YY < YB then
              YY := YB;
            if RX >= LX then
            begin
              CL := YB;
              XL := LX;
            end;
          end;
        end;
      end;

    CR := Y;
    XR := Result; // valium for the compiler
    for I := R.Count - 1 downto 0 do
      with R[I] do
      begin
        if ID = CurrentID then
          break;
        if (ID = nil) and (YB > Y) and ((YB < CR) or (CR = Y)) then
        begin
          if X = RightEdge(YB - 1) then
          begin
            // This is the left most right indentation
            LX := LeftEdge(YB);
            RX := RightEdge(YB) - W;
            if YY < YB then
              YY := YB;
            if RX >= LX then
            begin
              CR := YB;
              XR := LX;
            end;
          end;
        end;
      end;

    if CL = Y then
    begin
      if CR = Y then
      begin
        // no better place found, just append at the end.
        Y := YY;
        Result := MinX;
      end
      else
      begin
        Y := CR;
        Result := XR;
      end
    end
    else if CR = Y then
    begin
      Y := CL;
      Result := XL;
    end
    else if CL < CR then
    begin
      Y := CL;
      Result := XL;
    end
    else
    begin
      Y := CR;
      Result := XR;
    end;
  end;
  Inc(Result, LfEdge);
end;

function TfrxHtIndentManager.AlignRight(var Y: Integer; W: Integer): Integer;
// Find an available area to the right at or below Y with a width of W pixels.
//
// Returns the absolute X position of the found area.
// On return Y may be adjusted to a larger value if at original Y there is not
// enough width W.
var
  I, CL, CR, LX, RX, XL, XR, YY, MaxX: Integer;
begin
  Y := Max(Y, RTopMin);
  Result := RightEdge(Y) - W;
  if Result < LeftEdge(Y) then
  begin
    // too wide, must find a wider place below:
    YY := Y;
    MaxX := Width - W;

    CL := Y;
    XL := Result; // valium for the compiler
    for I := L.Count - 1 downto 0 do
      with L[I] do
      begin
        if ID = CurrentID then
          break;
        if (ID = nil) and (YB > Y) and ((YB < CL) or (CL = Y)) then
        begin
          if X = LeftEdge(YB - 1) then
          begin
            // This is the right most left indentation
            LX := LeftEdge(YB);
            RX := RightEdge(YB) - W;
            if YY < YB then
              YY := YB;
            if RX >= LX then
            begin
              CL := YB;
              XL := RX;
            end;
          end;
        end;
      end;

    CR := Y;
    XR := Result; // valium for the compiler
    for I := R.Count - 1 downto 0 do
      with R[I] do
      begin
        if ID = CurrentID then
        begin
          MaxX := X - W;
          break;
        end;
        if (ID = nil) and (YB > Y) and ((YB < CR) or (CR = Y)) then
        begin
          if X = RightEdge(YB - 1) then
          begin
            // This is the left most right indentation
            LX := LeftEdge(YB);
            RX := RightEdge(YB) - W;
            if YY < YB then
              YY := YB;
            if RX >= LX then
            begin
              CR := YB;
              XR := RX;
            end;
          end;
        end;
      end;

    if CL = Y then
    begin
      if CR = Y then
      begin
        // no better place found, just append at the end.
        Y := YY;
        Result := MaxX;
      end
      else
      begin
        Y := CR;
        Result := XR;
      end
    end
    else if CR = Y then
    begin
      Y := CL;
      Result := XL;
    end
    else if CL < CR then
    begin
      Y := CL;
      Result := XL;
    end
    else
    begin
      Y := CR;
      Result := XR;
    end;
  end;
  Inc(Result, LfEdge);
end;

function TfrxHtIndentManager.GetNextWiderY(Y: Integer): Integer;
{returns the next Y value which offers a wider space or Y if none}
var
  I, CL, CR: Integer;
begin
  CL := Y;
  for I := 0 to L.Count - 1 do
    with L[I] do
      if not Assigned(ID) and (YB > Y) and ((YB < CL) or (CL = Y)) then
        CL := YB;
  CR := Y;
  for I := 0 to R.Count - 1 do
    with R[I] do
      if not Assigned(ID) and (YB > Y) and ((YB < CR) or (CR = Y)) then
        CR := YB;
  if CL = Y then
    Result := CR
  else if CR = Y then
    Result := CL
  else
    Result := Min(CL, CR);
end;

function TfrxHtIndentManager.SetLeftIndent(XLeft, Y: Integer): Integer;
var
  IR: TfrxHtIndentRec;
begin
  IR := TfrxHtIndentRec.Create;
  with IR do
  begin
    YT := Y;
    YB := BigY;
    X := XLeft;
    ID := CurrentID;
  end;
  Result := L.Add(IR);
end;

function TfrxHtIndentManager.SetRightIndent(XRight, Y: Integer): Integer;
var
  IR: TfrxHtIndentRec;
begin
  IR := TfrxHtIndentRec.Create;
  with IR do
  begin
    YT := Y;
    YB := BigY;
    X := XRight;
    ID := CurrentID;
  end;
  Result := R.Add(IR);
end;

procedure TfrxHtIndentManager.FreeLeftIndentRec(I: Integer);
begin
  L.Delete(I);
end;

procedure TfrxHtIndentManager.FreeRightIndentRec(I: Integer);
begin
  R.Delete(I);
end;

function CopyPalette(Source: hPalette): hPalette;
 {$ifdef UseInline} inline; {$endif}
var
  LP: ^TLogPalette;
  NumEntries: Integer;
begin
  Result := 0;
  if ColorBits > 8 then
    Exit;
  GetMem(LP, Sizeof(TLogPalette) + 256 * Sizeof(TPaletteEntry));
  try
    with LP^ do
    begin
      palVersion := $300;
      palNumEntries := 256;
      NumEntries := GetPaletteEntries(Source, 0, 256, palPalEntry);
      if NumEntries > 0 then
      begin
        palNumEntries := NumEntries;
        Result := CreatePalette(LP^);
      end;
    end;
  finally
    FreeMem(LP, Sizeof(TLogPalette) + 256 * Sizeof(TPaletteEntry));
  end;
end;

{----------------TfrxHtCharCollection.GetAsString:}

function TfrxHtCharCollection.GetAsString: ThtString;
begin
  Result := Copy(FChars, 1, FCurrentIndex);
end;

function TfrxHtCharCollection.GetCapacity: Integer;
begin
  Result := Length(FChars);
end;

function TfrxHtCharCollection.GetSize: Integer;
begin
  Result := FCurrentIndex;
end;

constructor TfrxHtCharCollection.Create;
begin
  inherited;
  FCurrentIndex := 0;
  Capacity := TokenLeng;
end;

procedure TfrxHtCharCollection.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity <> Capacity then
  begin
    SetLength(FChars, NewCapacity);
    SetLength(FIndices, NewCapacity + 1);
  end;
end;

procedure TfrxHtCharCollection.Add(C: ThtChar; Index: Integer);
begin
  Inc(FCurrentIndex);
  if Capacity <= FCurrentIndex then
    Capacity := Capacity + 50;
  FIndices[FCurrentIndex] := Index;
  FChars[FCurrentIndex] := C;
end;

procedure TfrxHtCharCollection.Add(const S: ThtString; Index: Integer);
var
  K, L: Integer;
begin
  L := Length(S);
  if L > 0 then
  begin
    K := FCurrentIndex + L;
    if Capacity <= K then
      Capacity := K + 50;
    Move(S[1], FChars[FCurrentIndex + 1], L * SizeOf(ThtChar));
    while FCurrentIndex < K do
    begin
      Inc(FCurrentIndex);
      FIndices[FCurrentIndex] := Index;
    end;
  end;
end;

procedure TfrxHtCharCollection.Clear;
begin
  FCurrentIndex := 0;
  SetLength(FChars, 0);
end;

{ TokenObj }

constructor TfrxHtTokenObj.Create;
begin
  inherited;
  Capacity := TokenLeng;
  FCount := 0;
  St := '';
  StringOK := True;
end;

procedure TfrxHtTokenObj.AddUnicodeChar(Ch: WideChar; Ind: Integer);
{Ch must be Unicode in this method}
begin
  if Capacity <= Count then
    Capacity := Capacity + 50;
  Inc(FCount);
  C[Count] := Ch;
  I[Count] := Ind;
  StringOK := False;
end;

procedure TfrxHtTokenObj.Clear;
begin
  FCount := 0;
  St := '';
  StringOK := True;
end;

procedure TfrxHtTokenObj.AddString(S: TfrxHtCharCollection);
var
  K: Integer;
begin
  K := Count + S.FCurrentIndex;
  if Capacity <= K then
    Capacity := K + 50;
  Move(S.FChars[1],   C[Count + 1], S.FCurrentIndex * Sizeof(ThtChar));
  Move(S.FIndices[1], I[Count + 1], S.FCurrentIndex * Sizeof(Integer));
  FCount := K;
  StringOK := False;
end;

function TfrxHtTokenObj.GetCapacity: Integer;
begin
  Result := Length(C) - 1;
end;

//-- BG ---------------------------------------------------------- 20.01.2011 --
procedure TfrxHtTokenObj.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity <> Capacity then
  begin
    SetLength(C, NewCapacity + 1);
    SetLength(I, NewCapacity + 1);
    if NewCapacity < Count then
    begin
      FCount := NewCapacity;
      if StringOK then
        St := Copy(St, 1, Count);
    end;
  end;
end;

function TfrxHtTokenObj.GetString: UnicodeString;
begin
  if not StringOK then
  begin
    SetLength(St, Count);
    if Count > 0 then
       Move(C[1], St[1], SizeOf(WideChar) * Count);
    StringOK := True;
  end;
  Result := St;
end;

{----------------TfrxHtIDObjectList}

function TfrxHtIDObjectList.AddObject(const S: ThtString; AObject: TfrxHtIDObject): Integer;
var
  I: Integer;
  O: TfrxHtIDObject;
begin
  I := -1;
  if Find(S, I) then
  begin
    try
      O := Objects[I];
      if O.FreeMe then
        O.Free;
    except
    end;
    Delete(I);
  end;
  Result := inherited AddObject(S, AObject);
end;

procedure TfrxHtIDObjectList.Clear;
var
  I: Integer;
  O: TfrxHtIDObject;
begin
  for I := 0 to Count - 1 do
  try
    O := Objects[I];
    if O.FreeMe then
      O.Free;
  except
  end;
  inherited Clear;
end;

constructor TfrxHtIDObjectList.Create;
begin
  inherited Create;
  Sorted := True;
end;

destructor TfrxHtIDObjectList.Destroy;
begin
  Clear;
  inherited
end;

//-- BG ---------------------------------------------------------- 04.03.2011 --
function TfrxHtIDObjectList.GetObject(Index: Integer): TfrxHtIDObject;
begin
  Result := TfrxHtIDObject(inherited GetObject(Index));
end;

// BG, 17.04.2013: Color of DrawOnePolygon() must be a real RGB or palette value. Themed or system colors are not supported!
procedure DrawOnePolygon(Canvas: TCanvas; P: THtBorderPointArray; Color: TColor; Side: byte; Printing: Boolean);
 {$ifdef UseInline} inline; {$endif}
{Here we draw a 4 sided polygon (by filling a region).  This represents one
 side (or part of a side) of a border.
 For single pixel thickness, drawing is done by lines for better printing}
//BG, 22.08.2010: in print preview results are better without the single pixel exception.
{$ifdef BorderSinglePixelException}
type
  SideArray = array[0..3, 1..4] of Integer;
const
  AD: SideArray = ((0, 1, 0, 3),
    (0, 1, 1, 1),
    (2, 0, 2, 1),
    (1, 3, 3, 3));
  AP: SideArray = ((0, 1, 0, 3),
    (0, 1, 2, 1),
    (2, 0, 2, 2),
    (1, 3, 3, 3));
{$endif}
var
  R: HRgn;
{$ifdef BorderSinglePixelException}
  OldWidth: Integer;
  OldStyle: TPenStyle;
  OldColor: TColor;
  Thickness: Integer;
  P1, P2: TPoint;
  I: SideArray;
{$endif}
begin
{$ifdef BorderSinglePixelException}
  if Side in [0, 2] then
    Thickness := Abs(P[2].X - P[1].X)
  else
    Thickness := Abs(P[1].Y - P[2].Y);
  if Thickness = 1 then
  begin
    with Canvas do
    begin
      OldColor := Pen.Color;
      OldStyle := Pen.Style;
      OldWidth := Pen.Width;
      Pen.Color := Color;
      Pen.Style := psSolid;
      Pen.Width := 1;
      if Printing then
        I := AP
      else
        I := AD;
      P1 := Point(P[I[Side, 1]].X, P[I[Side, 2]].Y);
      P2 := Point(P[I[Side, 3]].X, P[I[Side, 4]].Y);
      MoveTo(P1.X, P1.Y);
      LineTo(P2.X, P2.Y);
      Pen.Width := OldWidth;
      Pen.Style := OldStyle;
      Pen.Color := OldColor;
    end;
  end
  else
{$endif}
  begin
    R := CreatePolygonRgn(P, 4, Alternate);
    try
      with Canvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := Color;
        FillRgn(Handle, R, Brush.Handle);
      end;
    finally
      DeleteObject(R);
    end;
  end;
end;

{----------------DrawBorder}
procedure DrawBorder(Canvas: TCanvas; ORect, IRect: TRect; const C: ThtColorArray;
  const S: ThtBorderStyleArray; BGround: TColor; Print: boolean);
 {$ifdef UseInline} inline; {$endif}
{Draw the 4 sides of a border.  The sides may be of different styles or colors.
 The side indices, 0,1,2,3, represent left, top, right, bottom.
 ORect is the outside rectangle of the border, IRect the inside Rectangle.
 BGround is the background color used for the bssDouble style}
var
  PO, PI, PM, P1, P2, Bnd: THtBorderPointArray;
  I: Integer;
  Cl, Color: TColor;
  MRect: TRect;
  lb: TLogBrush;
  Pn, OldPn: HPen;
  W, D: array[0..3] of Integer;
  InPath: boolean;
  PenType, Start: Integer;
  StyleSet: set of ThtBorderStyle;
  OuterRegion, InnerRegion: HRGN;
  Brush: TBrush;

begin
{Limit the borders to somewhat more than the screen size}

  ORect.Bottom := Min(ORect.Bottom, BotLim);
  ORect.Top := Max(ORect.Top, TopLim);
  IRect.Bottom := Min(IRect.Bottom, BotLim);
  IRect.Top := Max(IRect.Top, TopLim);

{Widths are needed for Dashed, Dotted, and Double}
  W[0] := IRect.Left - Orect.Left;
  W[1] := IRect.Top - Orect.Top;
  W[2] := ORect.Right - IRect.Right;
  W[3] := ORect.Bottom - IRect.Bottom;
  if (W[0] = 0) and (W[1] = 0) and (W[2] = 0) and (W[3] = 0) then
    exit;

{Find out what style types are represented in this border}
  StyleSet := [];
  for I := 0 to 3 do
    Include(StyleSet, S[I]);

{find the outside and inside corner points for the border segments}
  with ORect do
  begin
    PO[0] := Point(Left, Bottom);
    PO[1] := TopLeft;
    PO[2] := Point(Right, Top);
    PO[3] := BottomRight;
  end;
  with IRect do
  begin
    PI[0] := Point(Left, Bottom);
    PI[1] := TopLeft;
    PI[2] := Point(Right, Top);
    PI[3] := BottomRight;
  end;

{Points midway between the outer and inner rectangle are needed for
 ridge, groove, dashed, dotted styles}
  if [bssRidge, bssGroove, bssDotted, bssDashed] * StyleSet <> [] then
  begin
    MRect := Rect((ORect.Left + IRect.Left) div 2, (ORect.Top + IRect.Top) div 2,
      (ORect.Right + IRect.Right) div 2, (ORect.Bottom + IRect.Bottom) div 2);
    with MRect do
    begin
      PM[0] := Point(Left, Bottom);
      PM[1] := TopLeft;
      PM[2] := Point(Right, Top);
      PM[3] := BottomRight;
    end;
  end;

{the Double style needs the space between inner and outer rectangles divided
 into three parts}
  if bssDouble in StyleSet then
  begin
    for I := 0 to 3 do
    begin
      D[I] := W[I] div 3;
      if W[I] mod 3 = 2 then
        Inc(D[I]);
    end;

    with ORect do
      MRect := Rect(Left + D[0], Top + D[1], Right - D[2], Bottom - D[3]);

    with MRect do
    begin
      P1[0] := Point(Left, Bottom);
      P1[1] := TopLeft;
      P1[2] := Point(Right, Top);
      P1[3] := BottomRight;
    end;

    with IRect do
      MRect := Rect(Left - D[0], Top - D[1], Right + D[2], Bottom + D[3]);

    with MRect do
    begin
      P2[0] := Point(Left, Bottom);
      P2[1] := TopLeft;
      P2[2] := Point(Right, Top);
      P2[3] := BottomRight;
    end;
  end;

{double, dotted, dashed styles need a background fill}
  if (BGround <> clNone) and ([bssDouble, bssDotted, bssDashed] * StyleSet <> []) then
  begin
    with ORect do
      OuterRegion := CreateRectRgn(Left, Top, Right, Bottom);
    with IRect do
      InnerRegion := CreateRectRgn(Left, Top, Right, Bottom);
    CombineRgn(OuterRegion, OuterRegion, InnerRegion, RGN_DIFF);
    Brush := TBrush.Create;
    try
      Brush.Color := ThemedColor(BGround) or PalRelative;
      Brush.Style := bsSolid;
      FillRgn(Canvas.Handle, OuterRegion, Brush.Handle);
    finally
      Brush.Free;
      DeleteObject(OuterRegion);
      DeleteObject(InnerRegion);
    end;
  end;

  InPath := False;
  Pn := 0;
  OldPn := 0;
  Start := 0;

  try
    for I := 0 to 3 do
    begin
      Color := ThemedColor(C[I]);
      case S[I] of
        bssSolid, bssInset, bssOutset:
        begin
          Bnd[0] := PO[I];
          Bnd[1] := PO[(I + 1) mod 4];
          Bnd[2] := PI[(I + 1) mod 4];
          Bnd[3] := PI[I];
          case S[I] of
            bssInset:
              if I in [0, 1] then
                Color := Darker(Color)
              else
                Color := Lighter(Color);

            bssOutset:
              if I in [2, 3] then
                Color := Darker(Color)
              else
                Color := Lighter(Color);
          end;
          DrawOnePolygon(Canvas, Bnd, Color or PalRelative, I, Print);
        end;

        bssRidge, bssGroove:
        begin {ridge or groove}
          Cl := Color;
          Bnd[0] := PO[I];
          Bnd[1] := PO[(I + 1) mod 4];
          Bnd[2] := PM[(I + 1) mod 4];
          Bnd[3] := PM[I];
          case S[I] of
            bssGroove:
              if I in [0, 1] then
                Color := Darker(Color)
              else
                Color := Lighter(Color);

            bssRidge:
              if I in [2, 3] then
                Color := Darker(Color)
              else
                Color := Lighter(Color);
          end;
          DrawOnePolygon(Canvas, Bnd, Color or PalRelative, I, Print);

          Color := Cl;
          Bnd[0] := PM[I];
          Bnd[1] := PM[(I + 1) mod 4];
          Bnd[2] := PI[(I + 1) mod 4];
          Bnd[3] := PI[I];
          case S[I] of
            bssRidge:
              if I in [0, 1] then
                Color := Darker(Color)
              else
                Color := Lighter(Color);

            bssGroove:
              if (I in [2, 3]) then
                Color := Darker(Color)
              else
                Color := Lighter(Color);
          end;
          DrawOnePolygon(Canvas, Bnd, Color or PalRelative, I, Print);
        end;

        bssDouble:
        begin
          Color := Color or PalRelative;

          Bnd[0] := PO[I];
          Bnd[1] := PO[(I + 1) mod 4];
          Bnd[2] := P1[(I + 1) mod 4];
          Bnd[3] := P1[I];
          DrawOnePolygon(Canvas, Bnd, Color, I, Print);

          Bnd[0] := P2[I];
          Bnd[1] := P2[(I + 1) mod 4];
          Bnd[2] := PI[(I + 1) mod 4];
          Bnd[3] := PI[I];
          DrawOnePolygon(Canvas, Bnd, Color, I, Print);
        end;

        bssDashed, bssDotted:
        begin
          if not InPath then
          begin
            lb.lbStyle := BS_SOLID;
            lb.lbColor := Color or PalRelative;
            lb.lbHatch := 0;
            if S[I] = bssDotted then
              PenType := PS_Dot or ps_EndCap_Round
            else
              PenType := PS_Dash or ps_EndCap_Square;
            Pn := ExtCreatePen(PS_GEOMETRIC or PenType or ps_Join_Miter, W[I], lb, 0, nil);
            OldPn := SelectObject(Canvas.Handle, Pn);
            BeginPath(Canvas.Handle);
            MoveToEx(Canvas.Handle, PM[I].x, PM[I].y, nil);
            Start := I;
            InPath := True;
          end;
          LineTo(Canvas.Handle, PM[(I + 1) mod 4].x, PM[(I + 1) mod 4].y);
          if (I = 3) or (S[I + 1] <> S[I]) or (C[I + 1] <> C[I]) or (W[I + 1] <> W[I]) then
          begin
            if (I = 3) and (Start = 0) then
              CloseFigure(Canvas.Handle); {it's a closed path}
            EndPath(Canvas.Handle);
            StrokePath(Canvas.Handle);
            SelectObject(Canvas.Handle, OldPn);
            DeleteObject(Pn);
            Pn := 0;
            InPath := False;
          end;
        end;
      end;
    end;
  finally
    if Pn <> 0 then
    begin
      SelectObject(Canvas.Handle, OldPn);
      DeleteObject(Pn);
    end;
  end;
end;

{ TfrxHtViewerBase }

//-- BG ---------------------------------------------------------- 24.11.2011 --
constructor TfrxHtViewerBase.Create;
begin
  inherited;
  PrintMarginLeft := 2.0;
  PrintMarginRight := 2.0;
  PrintMarginTop := 2.0;
  PrintMarginBottom := 2.0;
  PrintMaxHPages := 2;
  Charset := DEFAULT_CHARSET;
  MarginHeight := 5;
  MarginWidth := 10;
  DefBackground := clBtnFace;
  DefFontColor := clBtnText;
  DefHotSpotColor := clBlue;
  DefOverLinkColor := clBlue;
  DefVisitedLinkColor := clPurple;
  VisitedMaxCount := 50;
  DefFontSize := 12;
  DefFontName := htDefFontName;
  DefPreFontName := htDefPreFontName;
end;

//-- BG ---------------------------------------------------------- 16.11.2011 --
constructor TfrxHtViewerBase.CreateCopy(Source: TfrxHtViewerBase);
begin
  Create;

  Charset := Source.Charset;
  CodePage := Source.CodePage;
  DefBackGround := Source.DefBackGround;
  DefFontColor := Source.DefFontColor;
  DefFontName := Source.DefFontName;
  DefFontSize := Source.DefFontSize;
  DefHotSpotColor := Source.DefHotSpotColor;
  DefOverLinkColor := Source.DefOverLinkColor;
  DefPreFontName := Source.DefPreFontName;
  DefVisitedLinkColor := Source.DefVisitedLinkColor;
  NoSelect := Source.NoSelect;
  ServerRoot := Source.ServerRoot;

  MarginHeight := Source.MarginHeight;
  MarginWidth := Source.MarginWidth;
  PrintMarginBottom := Source.PrintMarginBottom;
  PrintMarginLeft := Source.PrintMarginLeft;
  PrintMarginRight := Source.PrintMarginRight;
  PrintMarginTop := Source.PrintMarginTop;
  PrintMaxHPages := Source.PrintMaxHPages;
  HistoryMaxCount := Source.HistoryMaxCount;
  VisitedMaxCount := Source.VisitedMaxCount;
end;

procedure TfrxHtViewerBase.SetActiveColor(const Value: TColor);
begin
  FOverColor := Value;
end;

procedure TfrxHtViewerBase.SetCharset(const Value: TFontCharset);
begin
  FCharSet := Value;
end;

procedure TfrxHtViewerBase.SetCodePage(const Value: Integer);
begin
  FCodePage := Value;
end;

procedure TfrxHtViewerBase.SetDefBackground(const Value: TColor);
begin
  FBackground := Value;
end;

procedure TfrxHtViewerBase.SetFontColor(const Value: TColor);
begin
  FFontColor := Value;
end;

procedure TfrxHtViewerBase.SetFontName(const Value: TFontName);
begin
  FFontName := Value;
end;

procedure TfrxHtViewerBase.SetFontSize(const Value: Double);
begin
  FFontSize := Value * 96.0 / Screen.PixelsPerInch;
end;

procedure TfrxHtViewerBase.SetHistoryMaxCount(const Value: Integer);
begin
  FHistoryMaxCount := Value;
end;

procedure TfrxHtViewerBase.SetHotSpotColor(const Value: TColor);
begin
  FHotSpotColor := Value;
end;

procedure TfrxHtViewerBase.SetMarginHeight(const Value: Integer);
begin
  FMarginHeight := Value;
end;

procedure TfrxHtViewerBase.SetMarginWidth(const Value: Integer);
begin
  FMarginWidth := Value;
end;

procedure TfrxHtViewerBase.SetNoSelect(const Value: Boolean);
begin
  FNoSelect := Value;
end;

procedure TfrxHtViewerBase.SetPreFontName(const Value: TFontName);
begin
  FPreFontName := Value;
end;

procedure TfrxHtViewerBase.SetPrintMarginBottom(const Value: Double);
begin
  FPrintMarginBottom := Value;
end;

procedure TfrxHtViewerBase.SetPrintMarginLeft(const Value: Double);
begin
  FPrintMarginLeft := Value;
end;

procedure TfrxHtViewerBase.SetPrintMarginRight(const Value: Double);
begin
  FPrintMarginRight := Value;
end;

procedure TfrxHtViewerBase.SetPrintMarginTop(const Value: Double);
begin
  FPrintMarginTop := Value;
end;

procedure TfrxHtViewerBase.SetPrintMaxHPages(const Value: Integer);
begin
  FPrintMaxHPages := Value;
end;

procedure TfrxHtViewerBase.SetServerRoot(const Value: ThtString);
begin
  FServerRoot := ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TfrxHtViewerBase.SetVisitedColor(const Value: TColor);
begin
  FVisitedColor := Value;
end;

procedure TfrxHtViewerBase.SetVisitedMaxCount(const Value: Integer);
begin
  FVisitedMaxCount := Value;
end;

function TfrxHtViewerBase.StoreFontName: Boolean;
begin
  Result := FFontName <> htDefFontName;
end;

function TfrxHtViewerBase.StorePreFontName: Boolean;
begin
  Result := FPreFontName <> htDefPreFontName;
end;

{ TfrxHtIDObject }

//-- BG ---------------------------------------------------------- 06.03.2011 --
function TfrxHtIDObject.FreeMe: Boolean;
begin
  Result := False;
end;

//>-- DZ 18.09.2011
constructor TfrxHtIDObject.Create(const AHtmlId: ThtString);
begin
  inherited Create;
  FHtmlID:= Trim(AHtmlId);
end;

function TfrxHtIDObject.GetId(): ThtString;
begin
  Result := FHtmlId;
end;
//<-- DZ

{ TfrxHtIndentRecList }

//-- BG ---------------------------------------------------------- 06.10.2016 --
function TfrxHtIndentRecList.Get(Index: TfrListInteger): TfrxHtIndentRec;
begin
  Result := inherited Get(Index);
end;

{ TfrxHtFontObjBaseList }

//-- BG ---------------------------------------------------------- 06.10.2016 --
function TfrxHtFontObjBaseList.GetBase(Index: TfrListInteger): TfrxHtFontObjBase;
begin
  Result := inherited Get(Index);
end;

end.

