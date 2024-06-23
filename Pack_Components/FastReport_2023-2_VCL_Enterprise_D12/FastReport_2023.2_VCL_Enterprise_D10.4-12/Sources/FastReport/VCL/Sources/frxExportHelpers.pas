
{******************************************}
{                                          }
{             FastReport VCL               }
{         Helper classes for Exports       }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxExportHelpers;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Classes, Graphics, Controls,
  frxClass, frxExportBaseDialog,
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  Variants,      //for Outline
  frxCrypto,    // for hashing pictures and CSS styles
  frxStorage,   // for TCachedStream
  frPictureGraphics, frxVectorCanvas, frxUtils, frxAnaliticGeometry, frxTrueTypeCollection, math,
{$IFDEF FPC}LazHelper, {$ENDIF}
  frxTrueTypeFont, frxPlatformServices, frCSSStyle, frBaseGraphicsTypes;

const
  DefaultPrec = 3;

type
   { For Outline }
  TfrxCustomOutlineNode = class
  public
    Number: Integer;
    Dest: Integer; // Index to a page referred to by this outline node
    Top: Integer; // Position on the referred to page
    CountTree: Integer; // Number of all descendant nodes
    Count: Integer; // Number of all first-level descendants
    Title: string;

    First: TfrxCustomOutlineNode; // The first first-level descendant
    Last: TfrxCustomOutlineNode; // The last first-level descendant
    Next: TfrxCustomOutlineNode; // The next neighbouring node
    Prev: TfrxCustomOutlineNode; // The previous neighbouring node
    Parent: TfrxCustomOutlineNode; // The parent node of this node

    constructor Create;
    destructor Destroy; override;
  end;

  { For PDF }

  TfrxPDFOutlineNode = class(TfrxCustomOutlineNode);

  { For HTML }

  TfrxHTMLExportGetNavTemplate = procedure(const ReportName: String;
    Multipage: Boolean; PicsInSameFolder: Boolean; Prefix: String;
    TotalPages: Integer; var Template: String) of object;

  TfrxHTMLExportGetMainTemplate = procedure(const Title: String;
    const FrameFolder: String;
    Multipage: Boolean; Navigator: Boolean; var Template: String) of object;

  TfrxHTMLExportGetToolbarTemplate = procedure(CurrentPage: Integer; TotalPages: Integer;  Multipage: Boolean; Naviagtor: Boolean; var Template: String) of object;

  TfrxHTMLOutlineNode = class(TfrxCustomOutlineNode);

  { Represents a CSS style }

  { Represents a CSS (Cascading Style Sheet) with a list of CSS styles }

  { Saves pictures and ensures that there will not be identical copies saved }

  TfrxPictureInfo = record
    Extension: string;
    Mimetype: string;
  end;

  { Generalised picture }

  TfrxPictureFormat = (pfPNG, pfEMF, pfBMP, pfJPG, pfBMP32);

  TfrxPicture = class
  private
    FFormat: TfrxPictureFormat;
    FGraphic: TGraphic;
    FVectorGraphic: TGraphic;
    FGHelper: TfrxCustomGraphicFormatClass;
    FGVectorHelper: TfrxCustomGraphicFormatClass;
    FCanvasHelper: TfrxGraphicCanvasHelper;
    FPixelFormat: TPixelFormat;
    FIsAlpha: Boolean;
    function GetCanvas: TCanvas; // for TJPEGImage that doesn't provide a canvas
  public
    constructor Create(Format: TfrxPictureFormat; Width, Height: Integer; Transparent: Boolean; IsVectorSource: Boolean; IsAlpha: Boolean);
    destructor Destroy; override;

    function Release(Scale: Extended = 1.0): TGraphic;
    procedure SetTransparentColor(TransparentColor: TColor);
    procedure FillColor(Color: TColor; clNoneReplacement: TColor = clWhite);

    property Canvas: TCanvas read GetCanvas;
  end;

  TfrxExportHandler = function(Obj: TfrxView): Boolean of object;

  TTextFragment = class
  private
    FFormatted: boolean;
    FText: string;
  public
    constructor Create(AFormatted: boolean);
    procedure Add(const s: string); overload;
    procedure Add(const Fmt: string; const Args: array of const); overload;

    property Text: string read FText;
  end;

  TAnsiMemoryStream = class(TMemoryStream)
  private
    procedure PutsRaw(const s: AnsiString);
    procedure PutsA(const s: AnsiString);
  protected
    FFormatted: Boolean;
  public
    constructor Create(AFormatted: boolean = False);
    procedure Puts(const s: string); overload;
    procedure Puts(const Fmt: string; const Args: array of const); overload;

    function AsAnsiString: AnsiString;
  end;

  TExportHTMLDivSVGParent = class (TfrxBaseDialogExportFilter)
  private
    FServer: Boolean;
    FMultiPage: Boolean;
    FFormatted: Boolean;
    FPicFormat: TfrxPictureFormat;
    FUnifiedPictures: Boolean;
    FNavigation: Boolean;
    FEmbeddedPictures: Boolean;
    FEmbeddedCSS: Boolean;
    FOutline: Boolean;
    FWorkDir: string;
    FPrefix: string;
    procedure SetPicFormat(Fmt: TfrxPictureFormat);
    procedure SetMultiPage(const Value: Boolean);
    function SavePicInPath(Pic: TGraphic; Filter: TfrxCustomIOTransport; PNum: Integer): String;
  protected
    FFilterStream: TStream;
    FCurrentPage: Integer; // 1-based index of the current report page
    FCSS: TfrxCSSList; // stylesheet for all pages
    FHandlers: array of TfrxExportHandler;
    FCurrentFile: TStream;

    function EnableCalculateHash: Boolean; override;

    procedure AttachHandler(Handler: TfrxExportHandler);
    procedure RunExportsChain(Obj: TfrxView); virtual;
    function GetCSSFileName: string;
    function GetCSSFilePath: string;
    procedure SaveCSS(const FileName: string);
    procedure CreateCSS; virtual; abstract;
    function IsCanSavePicture(Pic: TGraphic): Boolean;
    function GetPicPath(Pic: TGraphic; PNum: Integer): String;
    function SavePicture(Pic: TGraphic; PNum: Integer = -1): String;
    procedure FreeStream;

    { Writes a string to the current file }
    procedure PutsRaw(const s: AnsiString);
    procedure PutsA(const s: AnsiString);
    procedure Puts(const s: string); overload;
    procedure Puts(const Fmt: string; const Args: array of const); overload;

    { Registers a CSS style in the internal CSS table and returns a selector
      that can be used in the "class" attribute of tags. }
    function LockStyle(Style: TfrxCSSStyle): string;

    function ExportViaVector(Obj: TfrxView): AnsiString;
    procedure Vector_ExtTextOut(Obj: TfrxView; AMS: TAnsiMemoryStream;
      Vector: TVector_ExtTextOut; const Shift: TPoint);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExportObject(Obj: TfrxComponent); override;
    function Start: Boolean; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;

    property Server: Boolean read FServer write FServer;
  published
    property OverwritePrompt;
    property OpenAfterExport;
    { Exports each report page to a separate page }
    property MultiPage: Boolean read FMultiPage write SetMultiPage;
    { Makes HTML sources formatted (and sligtly bigger) }
    property Formatted: Boolean read FFormatted write FFormatted;
    { Format for pictures representing report objects that are not saved natively,
      like RichText objects. }
    property PictureFormat: TfrxPictureFormat read FPicFormat write SetPicFormat;
    { Converts all pictures to PictureFormat: if there's a BMP picture in a report
      and PictureFormat is PNG, then this BMP will be saved as a PNG. }
    property UnifiedPictures: Boolean read FUnifiedPictures write FUnifiedPictures;
    { Creates navigation controls for Multipage mode }
    property Navigation: Boolean read FNavigation write FNavigation;
    { Embeds pictures }
    property EmbeddedPictures: Boolean read FEmbeddedPictures write FEmbeddedPictures;

    { Embeds CSS stylesheet }
    property EmbeddedCSS: Boolean read FEmbeddedCSS write FEmbeddedCSS;
    { Embeds HTML Outline }
    property Outline: Boolean read FOutline write FOutline;
  end;

  TRotation2D = class
  private
    FCenter: TfrxPoint;
    FMatrix: String;
  protected
    Sinus, Cosinus: Extended;
    C1, C2: Extended;

  public
    procedure Init(Radian: Extended; Center: TfrxPoint; Precision: Integer = DefaultPrec);

    function Turn2Str(DP: TfrxPoint): string;
    function Turn(DP: TfrxPoint): TfrxPoint;

    property Matrix: String read FMatrix;
  end;

  SCRIPT_CACHE = Pointer;
  PScriptCache = ^SCRIPT_CACHE;

  SCRIPT_ANALYSIS = record
    fFlags: Word;
    s: Word
  end;
  PScriptAnalysis = ^SCRIPT_ANALYSIS;

  TfrxPDFRun = class
  public
    analysis: SCRIPT_ANALYSIS;
    text: WideString;
    constructor Create(t: WideString; a: SCRIPT_ANALYSIS);
  end;

  TRemapedString = record
    Data: WideString;
    Width: Integer;
    SpacesCount: Integer;
    IsValidCharWidth: Boolean;
    CharWidth: TIntegerDinArray;
    IsHasLigatures: Boolean;
    IsSpace: array of Boolean;
  end;

  TfrxExportFont = class
  private
    FUSCache: PScriptCache;
    FForceAnsi: Boolean;
    FSameCharacterWidth: Boolean;

    function GetGlyphs(hdc: HDC; run: TfrxPDFRun; glyphs: PWord; widths: PInteger; maxGlyphs: integer; rtl: boolean; IsIndexes: Boolean = false): Integer;
    function Itemize(s: WideString; rtl: boolean; maxItems: Integer): TList;
    function Layout(runs: TList; rtl: boolean): TList;
    function GetGlyphIndices(hdc: HDC; text: WideString; glyphs: PWord; widths: PInteger; rtl: boolean; IsIndexes: Boolean = false): integer;
  protected
    GlobalTempBitmap: TBitmap;
    TrueTypeTables: TrueTypeCollection;
    ttf:  TrueTypeFont;
    PackFont: Boolean;
    PDFdpi_divider: double;
    FDpiFX: double;
    FIsLigatureless: Boolean;

    procedure GetFontFile;
    function RemapString(str: WideString; rtl: Boolean; IsIndexes: Boolean = false): TRemapedString;
  public
    SourceFont: TFont;
    Widths: TList;
    UsedAlphabet: TList;
    UsedAlphabetUnicode: TList;
    TextMetric: {$IFDEF FPC}{$IFDEF Linux}OUTLINETEXTMETRIC{$ELSE}LPOUTLINETEXTMETRICA{$ENDIF}{$ELSE}^OUTLINETEXTMETRICA{$ENDIF};
    {$IFDEF Linux}
    FontData:  TMemoryStream;
    function GetFontDataSize(): Longint; Virtual; Abstract;
    property FontDataSize: Longint read GetFontDataSize;
    {$ELSE}
    FontData: PAnsiChar;
    FontDataSize: Longint;
    {$ENDIF}
    constructor Create(Font: TFont);
    destructor Destroy; override;
    function SoftRemapString(str: WideString; rtl: Boolean; IsIndexes: Boolean = false): TRemapedString;

    property ForceAnsi: Boolean write FForceAnsi;
    property SameCharacterWidth: Boolean write FSameCharacterWidth;
  end;

  TOnProcessHyperLink = function(HL: TfrxHyperlink; ParentDetailURL: String): String;

{ HTML Outline }
const  outlineCSS =
    '.outlineCSS,   '+
    '.outlineCSS ul,  '+
    '.outlineCSS li { '+
    '  margin: 0;  '+
    '  padding: 0;  '+
    '  line-height: 1; '+
    '  list-style: none; '+
    '}  '+
    '.outlineCSS ul { '+
    '  margin: 0 0 0 .5em; '+
    '}  '+
    '.outlineCSS > li:not(:only-child), '+
    '.outlineCSS li li { '+
    '  position: relative;'+
    '  padding: .2em 0 0 1.2em;'+
    '}  '+
    '.outlineCSS li:not(:last-child) {'+
    '  border-left: 1px solid #ccc; '+
    '}  '+
    '.outlineCSS li li:before,'+
    '.outlineCSS > li:not(:only-child):before {'+
    '  content: ""; '+
    '  position: absolute;  '+
    '  top: 0; '+
    '  left: 0; '+
    '  width: 1.1em; '+
    '  height: .7em;  '+
    '  border-bottom: 1px solid #ccc; '+
    '} '+
    '.outlineCSS li:last-child:before { '+
    '  width: calc(1.1em - 1px); '+
    '  border-left: 1px solid #ccc; '+
    '} '+
    '.outlineCSS .drop { '+
    '  position: absolute; '+
    '  left: -.5em; '+
    '  top: .4em; '+
    '  width: .9em; '+
    '  height: .9em;  '+
    '  line-height: .9em; '+
    '  text-align: center;  '+
    '  background: #fff; '+
    '  font-size: 80%;  '+
    '  cursor: pointer; '+
    '} '+
    '.outlineCSS li:last-child > .drop { '+
    '  margin-left: 1px;  '+
    '} '+
    '.outlineCSS .drop ~ ul { '+
    '  display: none;  '+
    '} '+
    '.outlineCSS .dropM ~ ul { '+
    '  display: block; '+
    '} '+
    '.outlineNode {color : black; text-decoration: none;} '+
    '.blockOutline { position: fixed; height: 95%; '+
    '  width: 200px; overflow-x: scroll; '+
    '  overflow-y: scroll; left: 0%; padding: 0 10px;'+
    '  margin: 0 10px;border:1mm solid orange;margin:5mm; '+
    '  box-shadow:3mm 3mm 3mm gray; '+
    '  -webkit-box-shadow:3mm 3mm 3mm gray;-moz-box-shadow:3mm 3mm 3mm gray; '+
    '  -ms-box-shadow:3mm 3mm 3mm gray;-o-box-shadow:3mm 3mm 3mm gray; '+
    '  border-radius:2mm;-webkit-border-radius:2mm;-moz-border-radius:2mm; '+
    '  -ms-border-radius:2mm;-o-border-radius:2mm;} '+
    '.blockReport {position: relative; left: 250px;} '+
    '.blockTableOutline {'+
    '  display: block; position: fixed;  width: 200px; '+
    '  overflow: scroll; height : 95%;  '+
    '  border-top-color: grey; '+
    '  border-top-style: inset; '+
    '  border-top-width: 2px;'+
    '  border-bottom-color: grey;'+
    '  border-bottom-style: inset;'+
    '  border-bottom-width: 2px;'+
    '  border-right-color: grey;'+
    '  border-right-style: inset;'+
    '  border-right-width: 2px;'+
    '  border-left-color: grey;'+
    '  border-left-style: inset;'+
    '  border-left-width: 2px;'+
    '  padding: 0 10px;'+
    '  margin: 0 5px;'+
    ' } ';

   outlineJS =
   '<script type="text/javascript"> '+
	 '	(function() { '+
	 '	  var ul = document.querySelectorAll(''.outlineCSS > li:not(:only-child) ul, .outlineCSS ul ul''); '+
	 '	  for (var i = 0; i < ul.length; i++) {  '+
	 '		var div = document.createElement(''div'');  '+
	 '		div.className = ''drop''; '+
	 '		div.innerHTML = ''+'';  '+
	 '		ul[i].parentNode.insertBefore(div, ul[i].previousSibling);  '+
	 '		div.onclick = function() {  '+
	 '		  this.innerHTML = (this.innerHTML == ''+'' ? ''-'' : ''+'')  ;'+
	 '		  this.className = (this.className == ''drop'' ? ''drop dropM'' : ''drop'');  '+
	 '		} '+
	 '	  } '+
	 '	})(); '+
   '</script>';

procedure PrepareHTMLOutline(Outline: TfrxCustomOutline;
            Node: TfrxHTMLOutlineNode; ObjNum: Integer);
procedure WriteHTMLOutline(Node: TfrxHTMLOutlineNode; var html :String);
function GetIdOutlineHTML(Top :Extended; Height :Extended;
          var FOutlineTree :TfrxHTMLOutlineNode; PageH : Extended) :String;

{ Utility routines }

function Float2Str(const Value: Extended; const Prec: Integer = DefaultPrec): String;
function frxPoint2Str(DP: TfrxPoint; const Prec: Integer = DefaultPrec): String; overload;
function frxPoint2Str(X, Y: Extended; const Prec: Integer = DefaultPrec): String; overload;

function GetCursor(Cursor: TCursor): string;
function GetColor(Color: TColor): string;
function GetBorderRadius(Curve: Integer): string;
function IsHasSpecialChars(const s: string): Boolean;
function IsHasHTMLTags(const s: string): Boolean;

function StrFindAndReplace(const Source, Dlm: WideString; SFR: array of WideString): WideString;

function SVGPattern(Formatted, XLine, YLine, Turn: boolean; Color: TColor;
                    LineWidth: Extended; Name: string): string;
procedure CalcGlassRect(Orientation: TfrxGlassFillOrientation;
                        AbsTop, AbsLeft: Extended; var x, y, Width, Height: integer);
function SVGLine(Formatted, ZeroBased: boolean; CSS: TfrxCSSList; Line: TfrxLineView): string;
function SVGDasharray(Style: TfrxFrameStyle; LineWidth: Extended): string;
function SVGUniqueID: string;
function SVGEscapeTextAndAttribute(const s: WideString): WideString;
function SVGStartSpace(const s: WideString): WideString;

const
  spStroke = $1;
  spHTML = $2;

function SVGShapePath(Shape: TfrxShapeView; Options: integer = 0): string;

function GraphicToBase64AnsiString(Graphic: TGraphic): AnsiString;

procedure BitmapFill(Bitmap: TBitmap; Color: TColor);

function PiecewiseLinearInterpolation(Rotation: Integer; X, Y: array of Integer): Extended;

function IsInclude(const Options, Param: LongWord): Boolean;
function IsCJK(WS: WideString): Boolean; // Chinese, Japanese, Korean
function IsDevanagari(WS: WideString): Boolean; // Hindustani

function ArraySum(A: TDoubleArray): Double; overload;
function ArraySum(A: TLongWordDinArray): LongWord; overload;
function ArraySum(A: TIntegerDinArray): Integer; overload;

function ArrayAvg(A: TDoubleArray): Double;

procedure AddLigatureless(FontName: String);
procedure DeleteLigatureless(FontName: String);

function ReverseSlash(const S: String): String;
function frxPictureFormatToStr(Format: TfrxPictureFormat): String;
function PictureFormatFromGraphicHelper(GHelper: TfrxCustomGraphicFormatClass): TfrxPictureFormat;
function GetPicInfo(Pic: TGraphic): TfrxPictureInfo;

procedure TernaryRasterOperationNeeds(dwRop: DWORD; out NeedD, NeedP, NeedS: Boolean);

implementation

uses
//frxMapHelpers, // todo : frxMapHelpers,
  SysUtils, Types, StrUtils,
  Contnrs, SyncObjs, frxRes, frxHelpers,
  frUtils,
  frHashUtils;

var
  CriticalSection: TCriticalSection;
  UniqueNumber: LongWord;

const
  MaxStackLen = 5; // DSPDSonoxxn

type
  TTernaryRasterOperation = class
  public
    class function GetReversePolish(dwRop: DWORD): AnsiString;
  end;

type
  SCRIPT_ITEM = record
    iCharPos: Integer;
    a: SCRIPT_ANALYSIS;
  end;
  PScriptItem = ^SCRIPT_ITEM;

  GOFFSET = record
    du:  Longint;
    dv:  Longint;
  end;
  PGOffset = ^GOFFSET;

  SCRIPT_DIGITSUBSTITUTE = record
    NationalDigitLanguage: WORD;
    TraditionalDigitLanguage: WORD;
    DigitSubstitute: DWORD;
    dwReserved: WORD;
  end;
  PSCRIPT_DIGITSUBSTITUTE= ^SCRIPT_DIGITSUBSTITUTE;

{ Ligatureless }

var
  PDFFontLigaturelessList: TStringList;

procedure AddLigatureless(FontName: String);
begin
  PDFFontLigaturelessList.Add(FontName);
end;

procedure DeleteLigatureless(FontName: String);
var
  Index: Integer;
begin
  if PDFFontLigaturelessList.Find(FontName, Index) then
    PDFFontLigaturelessList.Delete(Index);
end;

function IsLigatureless(FontName: String): Boolean;
var
  Index: Integer;
begin
  Result := PDFFontLigaturelessList.Find(FontName, Index);
end;

function PictureFormatFromGraphicHelper(GHelper: TfrxCustomGraphicFormatClass): TfrxPictureFormat;
begin
  Result := pfBMP;
  if GHelper.GetGraphicName = 'PNG' then
    Result := pfPNG
  else if GHelper.GetGraphicName = 'EMF' then
    Result := pfEMF
  else if GHelper.GetGraphicName = 'JPG' then
    Result := pfJPG;
end;

function GetPicInfo(Pic: TGraphic): TfrxPictureInfo;
var
  GHelper: TfrxCustomGraphicFormatClass;
begin
  GHelper := GetGraphicFormats.FindByGraphic(TGraphicClass(Pic.ClassType));
  if Assigned(GHelper) then
  begin
    Result.Extension := GHelper.GetGraphicExt;
  end
  else
  begin
    Result.Extension := '.pic';
    Result.Mimetype := 'image/unknown';
  end;
end;

{$IFNDEF Linux}
function ScriptFreeCache(psc: PScriptCache): HRESULT; stdcall; external 'usp10.dll' name 'ScriptFreeCache';
function ScriptLayout(cRuns: Integer; const pbLevel: PByte;
    piVisualToLogical: PInteger; piLogicalToVisual: PInteger): HRESULT; stdcall; external 'usp10.dll' name  'ScriptLayout';
function ScriptItemize(const pwcInChars: PWideChar; cInChars: Integer;
    cMaxItems: Integer; const psControl: PInteger; const psState: PWord;
    pItems: PScriptItem; pcItems: PInteger): HRESULT; stdcall; external 'usp10.dll' name 'ScriptItemize';
function ScriptPlace(hdc: HDC; psc: PScriptCache; const pwGlyphs: PWord;
    cGlyphs: Integer; const psva: PWord; psa: PScriptAnalysis;
    piAdvance: PInteger; const pGoffset: PGOffset; pABC: PABC): HRESULT; stdcall; external 'usp10.dll' name 'ScriptPlace';
function ScriptShape(hdc: HDC; psc: PScriptCache; const pwcChars: PWideChar;
    cChars: Integer; cMaxGlyphs: Integer; psa: PScriptAnalysis; pwOutGlyphs: PWord;
    pwLogClust: PWord; psva: PWord; pcGlyphs: PInteger): HRESULT; stdcall; external 'usp10.dll' name 'ScriptShape';
function ScriptApplyDigitSubstitution(psds: PSCRIPT_DIGITSUBSTITUTE; psc: PCardinal;
    pss: PCardinal): HRESULT; stdcall; external 'usp10.dll' name 'ScriptApplyDigitSubstitution';
{$ENDIF}

{ Utility routines }

function ArrayAvg(A: TDoubleArray): Double;
begin
  Result := 0;
  if Length(A) > 0 then
    Result := ArraySum(A) / Length(A);
end;

function ArraySum(A: TDoubleArray): Double;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(A) do
    Result := Result + A[i];
end;

function ArraySum(A: TIntegerDinArray): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(A) do
    Result := Result + A[i];
end;

function ArraySum(A: TLongWordDinArray): LongWord;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(A) do
    Result := Result + A[i];
end;

function IsInclude(const Options, Param: LongWord): Boolean;
begin
  Result := Options and Param = Param;
end;

function IsDevanagari(WS: WideString): Boolean; // https://jrgraphix.net/r/Unicode/0900-097F
var
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(WS) do
    if (Word(WS[i]) >=  $0900) and (Word(WS[i]) <=  $097F) then
      Exit;

  Result := False;
end;

function IsCJK(WS: WideString): Boolean; // https://stackoverflow.com/questions/1366068/whats-the-complete-range-for-chinese-characters-in-unicode
var
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(WS) do
    if (Word(WS[i]) >=  $4E00) and (Word(WS[i]) <=  $9FFF) or
       (Word(WS[i]) >=  $3400) and (Word(WS[i]) <=  $4DBF) then
      Exit;

  Result := False;
end;

function PiecewiseLinearInterpolation(Rotation: Integer; X, Y: array of Integer): Extended;
var
  Left, Right: Integer;
begin
  if      Rotation <= X[0] then
    Result := Y[0]
  else if Rotation >= X[High(X)] then
    Result := Y[High(X)]
  else
  begin
    for Right := 1 to High(X) do
      if Rotation <= X[Right] then Break;
    Left := Right - 1;
    Result := Y[Left] + (Y[Right] - Y[Left]) * (Rotation - X[Left]) / (X[Right] - X[Left]);
  end;
end;

procedure BitmapFill(Bitmap: TBitmap; Color: TColor);
begin
  Bitmap.Canvas.Brush.Color := Color;
  Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));
end;

function GraphicToBase64AnsiString(Graphic: TGraphic): AnsiString;
var
  MemoryStream: TMemoryStream;
  AnsiStr: AnsiString;
begin
  MemoryStream := TMemoryStream.Create;
  try
    Graphic.SaveToStream(MemoryStream);
    SetLength(AnsiStr, MemoryStream.Size);
    Move(MemoryStream.Memory^, AnsiStr[1], MemoryStream.Size);
    Result := frBase64Encode(AnsiStr);
  finally
    MemoryStream.Free;
  end;
end;

function frxPoint2Str(DP: TfrxPoint; const Prec: Integer = DefaultPrec): String; overload;
begin
  Result := frxPoint2Str(DP.X, DP.Y, Prec);
end;

function frxPoint2Str(X, Y: Extended; const Prec: Integer = DefaultPrec): String; overload;
begin
  Result := Float2Str(X, Prec) + ' ' + Float2Str(Y, Prec);
end;

function Float2Str(const Value: Extended; const Prec: Integer = DefaultPrec): String;
begin
  Result := frFloat2Str(Value, Prec);
  if Pos('.', Result) > 0 then
    while Result[Length(Result)] = '0' do
      Delete(Result, Length(Result), 1);
  if Result[Length(Result)] = '.' then
    Delete(Result, Length(Result), 1);
end;

function SVGStartSpace(const s: WideString): WideString;
begin
  if Length(s) > 0 then
  begin
    Result := frIfStr(s[1] = ' ',
      '&#160;' + Copy(s, 2, Length(s) - 1), s);
    Result := frIfStr(Result[Length(Result)] = ' ',
      Copy(Result, 1, Length(Result) - 1) + '&#160;', Result);
  end
  else
    Result := '';
end;

function SVGEscapeTextAndAttribute(const s: WideString): WideString;
begin
  Result := StrFindAndReplace(s, ':', ['&:&amp;', '<:&lt;', '>:&gt;', '":&quot;',
    ''':&apos;', #13':', '  : &#160;']);
end;

function SVGUniqueID: string;
begin
  CriticalSection.Enter;
  try
    Result := Format('SVGUID%d', [UniqueNumber]);
    Inc(UniqueNumber);
  finally
    CriticalSection.Leave;
  end;
end;

function SVGDasharray(Style: TfrxFrameStyle; LineWidth: Extended): string;
var
  w1, w2: string;
  Width: Extended;
begin
  Width := frIfReal(Style = fsDouble, LineWidth * 3, LineWidth);
  w1 := IntToStr(Round(1 * Width));
  w2 := IntToStr(Round(2 * Width));
  case Style of
    fsSolid, fsDouble: Result := '';
    fsDash: Result := '18 6';
    fsDot: Result := '3 3';
    fsDashDot: Result := '9 6 3 6';
    fsDashDotDot: Result := '9 3 3 3 3 3';
    fsAltDot: Result := w1 + ' ' + w2;
    fsSquare: Result := w1 + ' ' + w1;
  end;
end;

function SVGLineArrow(x1, y1, x2, y2: Extended; Line: TfrxLineView;
                      ClassName: string): string;
var
  k1, a, b, c, D: Extended;
  xp, yp, x3, y3, x4, y4, wd, ld: Extended;
begin
  wd := Line.ArrowWidth;
  ld := Line.ArrowLength;
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

  Result := Format('<%s points="%s,%s %s,%s %s,%s" class="%s"/>',
    [frIfStr(Line.ArrowSolid, 'polygon', 'polyline'),
     frFloat2Str(x3, 1), frFloat2Str(y3, 1),
     frFloat2Str(x2, 1), frFloat2Str(y2, 1),
     frFloat2Str(x4, 1), frFloat2Str(y4, 1),
     ClassName]);
end;

function SVGLine(Formatted, ZeroBased: boolean; CSS: TfrxCSSList; Line: TfrxLineView): string;

  procedure CalcEnds(First, Size: Extended; out z1, z2: Extended);
  begin
    z1 := frIfReal(ZeroBased, 0.0, First);
    z2 := z1 + Size;
    if ZeroBased and (z2 < 0) then
    begin
      z1 := -z2;
      z2 := 0.0;
    end;
  end;

var
  x1, x2, y1, y2: Extended;
  CSSClassNameBG, CSSClassNameFG: string;
begin
  CalcEnds(Line.AbsLeft, Line.Width, x1, x2);
  CalcEnds(Line.AbsTop, Line.Height, y1, y2);

  if Line.Frame.Style <> fsSolid then
    if Line.Diagonal then
      with TfrxCSSStyle.Create do
      begin
        Style['stroke'] := GetColor(Line.Color);
        Style['stroke-width'] := frFloat2Str(Line.Frame.Width, 2);
        if Line.Frame.Style = fsDouble then
          Style['stroke-linecap'] := 'square';
        CSSClassNameBG := CSS.AddStyle(This);
      end
    else
      if Abs(x1 - x2) > Abs(y1 - y2) then
        y2 := y1
      else
        x2 := x1;

  with TfrxCSSStyle.Create do
  begin
    Style['stroke'] := GetColor(Line.Frame.Color);
    Style['stroke-width'] := frFloat2Str(Line.Frame.Width, 2);
    Style['stroke-dasharray'] := SVGDasharray(Line.Frame.Style, Line.Frame.Width);
    if Line.Frame.Style = fsDouble then
      Style['stroke-linecap'] := 'square';
    if Line.ArrowEnd or Line.ArrowStart then
      if Line.ArrowSolid then Style['fill'] := GetColor(Line.Frame.Color)
      else                    Style['fill'] := 'transparent';
    CSSClassNameFG := CSS.AddStyle(This);
  end;

  with TTextFragment.Create(Formatted) do
  begin
    if (Line.Frame.Style <> fsSolid) and Line.Diagonal then
      Add('<line x1="%s" y1="%s" x2="%s" y2="%s" class="%s"/>',
           [Float2Str(x1), Float2Str(y1), Float2Str(x2), Float2Str(y2), CSSClassNameBG]);

    Add('<line x1="%s" y1="%s" x2="%s" y2="%s" class="%s"/>',
         [Float2Str(x1), Float2Str(y1), Float2Str(x2), Float2Str(y2), CSSClassNameFG]);

    if Line.ArrowStart then
      Add(SVGLineArrow(x2, y2, x1, y1, Line, CSSClassNameFG));

    if Line.ArrowEnd then
      Add(SVGLineArrow(x1, y1, x2, y2, Line, CSSClassNameFG));
    Result := Text;
    Free;
  end;

end;

procedure CalcGlassRect(Orientation: TfrxGlassFillOrientation;
                        AbsTop, AbsLeft: Extended; var x, y, Width, Height: integer);
begin
  case Orientation of
    foHorizontal:
      Height := Round(Height / 2);
    foHorizontalMirror:
      begin
        y := Round(AbsTop + Height / 2);
        Height := Round(AbsTop + Height) - y;
      end;
    foVertical:
      Width :=  Round(Width / 2);
    foVerticalMirror:
      begin
        x := Round(AbsLeft + Width / 2);
        Width :=  Round(AbsLeft + Width) - x;
      end;
  end;
end;

function SVGShapePath(Shape: TfrxShapeView; Options: integer = 0): string;
var
  RadiusValue, StrokeValue, StrokeWidth, sf: string;
  w, h, h2, w2: Extended;
  x1, x2, x3, y1, y2, y3: Extended;
begin
  if Options and spStroke = spStroke then
  begin
    StrokeWidth := frIfStr(Shape.Shape in [skDiagonal1, skDiagonal2],
      frFloat2Str(1.5 * Shape.Frame.Width, 1), frFloat2Str(Shape.Frame.Width, 1));
    StrokeValue := GetColor(Shape.Frame.Color);
    sf := Format('stroke="%s" stroke-width="%s" fill="transparent"',
      [StrokeValue, StrokeWidth]);
  end
  else
    sf := '';

  RadiusValue := GetBorderRadius(Shape.Curve);
  w := Shape.Width - Shape.ShadowSize;  w2 := w / 2;
  h := Shape.Height - Shape.ShadowSize; h2 := h / 2;

  if Options and spHTML = spHTML then
  begin
    x1 := Shape.Frame.Width / 2;
    y1 := Shape.Frame.Width / 2;
  end
  else
  begin
    x1 := Shape.AbsLeft;
    y1 := Shape.AbsTop;
  end;
  x2 := x1 + w2; x3 := x1 + w;
  y2 := y1 + h2; y3 := y1 + h;

  case Shape.Shape of
    skRectangle:
      Result := Format('<rect x="%d" y="%d" width="%d" height="%d" %s/>',
        [Round(x1), Round(y1), Round(w), Round(h), sf]);
    skRoundRectangle:
      Result := Format('<rect x="%d" y="%d" width="%d" height="%d" rx="%s" ry="%s" %s/>',
        [Round(x1), Round(y1), Round(w), Round(h), RadiusValue, RadiusValue, sf]);
    skEllipse:
      Result := Format('<ellipse cx="%d" cy="%d" rx="%d" ry="%d" %s/>',
        [Round(x2), Round(y2), Round(w2), Round(h2), sf]);
    skTriangle:
      Result := Format('<polygon points="%d,%d %d,%d %d,%d" %s/>',
        [Round(x2), Round(y1), Round(x3), Round(y3), Round(x1), Round(y3), sf]);
    skDiamond:
      Result := Format('<polygon points="%d,%d %d,%d %d,%d %d,%d" %s/>',
        [Round(x2), Round(y1), Round(x3), Round(y2), Round(x2), Round(y3), Round(x1), Round(y2), sf]);
    skDiagonal1:
      Result := Format('<line x1="%d" y1="%d" x2="%d" y2="%d" %s/>',
        [Round(x1), Round(y3), Round(x3), Round(y1), sf]);
    skDiagonal2:
      Result := Format('<line x1="%d" y1="%d" x2="%d" y2="%d" %s/>',
        [Round(x1), Round(y1), Round(x3), Round(y3), sf]);
  end;

end;

function SVGPattern(Formatted, XLine, YLine, Turn: boolean; Color: TColor;
                    LineWidth: Extended; Name: string): string;
var
  Size: string;
begin
  Size := frIfStr(Turn, '6', '8');

  with TTextFragment.Create(Formatted) do
  begin
    Add('<defs>');
    Add('<pattern id="%s" width="%s" height="%s" patternUnits="userSpaceOnUse"%s>',
      [Name, Size, Size, frIfStr(Turn, ' patternTransform="rotate(45)"')]);
    if XLine then
      Add('<line x2="%s" stroke="%s" stroke-width="%s" />',
         [Size, GetColor(Color), frFloat2Str(LineWidth, 1)]);
    if YLine then
      Add('<line y2="%s" stroke="%s" stroke-width="%s" />',
         [Size, GetColor(Color), frFloat2Str(LineWidth, 1)]);
    Add('</pattern>');
    Add('</defs>');

    Result := Text;
    Free;
  end;
end;

function StrFindAndReplace(const Source, Dlm: WideString; SFR: array of WideString): WideString;

  function IsSplit(const Source, Dlm: WideString; out UpToDlm, AfterDlm: WideString): boolean;
  var
    p: integer;
  begin
    if Dlm = ':' then
      p := Pos(Dlm, Source)
    else
      p := Pos(Dlm, WideString(LowerCase(Source)));
    Result := p > 0;
    if Result then
    begin
      UpToDlm := Copy(Source, 1, p - 1);
      AfterDlm := Copy(Source, p + Length(Dlm), Length(Source) - (p + Length(Dlm)) + 1);
    end
    else
    begin
      UpToDlm := Source;
      AfterDlm := '';
    end;
  end;

var
  i: integer;
  Find, Replace, UpToDlm, AfterDlm, Rest: WideString;

begin
  Result := Source;

  for i := 0 to High(SFR) do
    if IsSplit(SFR[i], Dlm, Find, Replace) and (Find <> '') then
    begin
      Rest := Result;
      Result := '';

      while IsSplit(Rest, Find, UpToDlm, AfterDlm) do
      begin
        Result := Result + UpToDlm + Replace;
        Rest := AfterDlm;
      end;

      Result := Result + UpToDlm;
    end;

  Rest := Result;
  Result := '';
  for i := 1 to Length(Rest) do
    if Word(Rest[i]) < 32 then
      Result := Result + '&#' + IntToStr(Word(Rest[i])) + ';'
    else
      Result := Result + Rest[i];
end;

function IsHasHTMLTags(const s: string): Boolean;
var
  LeftAngleBracket, RightAngleBracket, i, len: Integer;
  LeftAngleBracketFound : boolean;
  Tag: string;
begin
  Result := False;
  LeftAngleBracket := 0;
  LeftAngleBracketFound := False;
  i := 1;
  len := frxLength(s);
  while not Result and (i <= len) do
    begin
      if frxGetSymbol(s, i) = '<' then
        begin
          LeftAngleBracket := i;
          LeftAngleBracketFound := True;
        end
      else
        if LeftAngleBracketFound and (frxGetSymbol(s, i) = '>') then
          begin
            RightAngleBracket := i;
            Tag := UpperCase(frxCopy(s, LeftAngleBracket + 1, RightAngleBracket - LeftAngleBracket - 1));
            Result := // TfrxHTMLTagsList.ExpandHTMLTags
              (Tag = 'B') or (Tag = 'I') or (Tag = 'U') or
              (Tag = 'SUB') or (Tag = 'SUP') or
              (Tag = 'STRIKE') or (Tag = 'NOWRAP') or (frxPos('FONT COLOR', Tag) = 1);
            if not Result then
              LeftAngleBracketFound := False;
          end;
      inc(i);
    end;
end;

function IsHasSpecialChars(const s: string): Boolean;
var
  i: Integer;
begin
  Result := True;

  for i := 1 to Length(s) do
    case s[i] of
      '<', '>', '&': Exit;
      else if Word(S[i]) < 32 then
        Exit
    end;

  Result := False
end;

function GetBorderRadius(Curve: Integer): string;
begin
  if Curve < 1 then
    Result := GetBorderRadius(2)
  else
    Result := IntToStr(Curve * 4) + 'pt'
end;

function GetColor(Color: TColor): string;
begin
  case Color of
    clAqua:    Result := 'aqua';
    clBlack:   Result := 'black';
    clBlue:    Result := 'blue';
    clFuchsia: Result := 'fuchsia';
    clGray:    Result := 'gray';
    clGreen:   Result := 'green';
    clLime:    Result := 'lime';
    clLtGray:  Result := 'lightgray';
    clMaroon:  Result := 'maroon';
    clNavy:    Result := 'navy';
    clOlive:   Result := 'olive';
    clPurple:  Result := 'purple';
    clRed:     Result := 'red';
    clTeal:    Result := 'teal';
    clWhite:   Result := 'white';
    clYellow:  Result := 'yellow';

    clNone:    Result := 'transparent';
  else
    if Color and $ff000000 <> 0 then
      Result := GetColor(GetSysColor(Color and $ffffff))
    else
      Result := HTMLRGBColor(Color)
  end
end;

function GetCursor(Cursor: TCursor): string;
begin
  Result := '';

  case Cursor of
    crCross:      Result := 'crosshair';
    crArrow:      Result := 'arrow';
    crIBeam:      Result := 'text';
    crHelp:       Result := 'help';
    crUpArrow:    Result := 'n-resize';
    crHourGlass:  Result := 'wait';
    crDrag:       Result := 'move';
    crHandPoint:  Result := 'pointer';
  else            Result := '';
  end;
end;

{ TfrxPicture }

constructor TfrxPicture.Create(Format: TfrxPictureFormat; Width, Height: Integer; Transparent: Boolean; IsVectorSource: Boolean; IsAlpha: Boolean);
begin
  FPixelFormat := pf24bit;
  FIsAlpha := IsAlpha;
  if IsVectorSource and (Transparent or IsAlpha) then
    FGVectorHelper := GetGraphicFormats.FindByName('FREMF');
  FGHelper := GetGraphicFormats.FindByName(frxPictureFormatToStr(Format));

  if Assigned(FGVectorHelper) then
  begin
    FVectorGraphic := FGVectorHelper.CreateNew(Width, Height, FPixelFormat, (FPixelFormat = pf32bit), 100);
    FGraphic := FVectorGraphic;
    FCanvasHelper := FGVectorHelper.CreateCanvasHelper(FGraphic);
  end
  else
  begin
    if (Format = pfPNG) and Transparent or IsAlpha or (Format = pfBMP32) then
      FPixelFormat := pf32bit;
    FGraphic := FGHelper.CreateNew(Width, Height, FPixelFormat, (FPixelFormat = pf32bit), 100);
    FCanvasHelper := FGHelper.CreateCanvasHelper(FGraphic);
  end;
  FFormat := Format;
end;

destructor TfrxPicture.Destroy;
begin
  FreeAndNil(FCanvasHelper);
  FGraphic.Free;
  inherited;
end;

procedure TfrxPicture.SetTransparentColor(TransparentColor: TColor);
begin
  FCanvasHelper.GraphicHelper.SetTransparentColor(FGraphic, TransparentColor);
  FillColor(TransparentColor, TransparentColor)
end;

procedure TfrxPicture.FillColor(Color: TColor; clNoneReplacement: TColor = clWhite);
var
  lCanvas: TCanvas;
  LGHelper: TfrxCustomGraphicFormatClass;
begin
  LGHelper := FGVectorHelper;
  if LGHelper = nil then
    LGHelper := FGHelper;
  if LGHelper.HasAlphaChanel(FGraphic) then Exit;
  lCanvas := Canvas;
  lCanvas.Lock;
  try
    if Color = clNone then
      lCanvas.Brush.Color := clNoneReplacement
    else
      lCanvas.Brush.Color := Color;
    lCanvas.FillRect(lCanvas.ClipRect);
  finally
    lCanvas.Unlock;
  end;
end;

function TfrxPicture.GetCanvas: TCanvas;
begin
  Result := FCanvasHelper.Canvas;
end;

function TfrxPicture.Release(Scale: Extended = 1.0): TGraphic;
begin
  FCanvasHelper.ReleaseCanvas;

  if Assigned(FVectorGraphic) then
  begin
    if (Scale > 1.0) and (FGHelper = TfrxBitmapGraphicFormat) then
      FGraphic := TfrxBitmapGraphicFormat(FGHelper).ConvertFromVector(FVectorGraphic, pf32bit, Scale)
    else
      FGraphic := FGHelper.ConvertFrom(FVectorGraphic, pf32bit);
    FreeAndNil(FVectorGraphic);
  end;
  Result := FGraphic;
end;

{ TfrxCustomOutlineNode }

constructor TfrxCustomOutlineNode.Create;
begin
  inherited;
  Dest := -1;
end;

destructor TfrxCustomOutlineNode.Destroy;
begin
  if Next <> nil then
    Next.Free;

  if First <> nil then
    First.Free;

  inherited;
end;

{ HTML Outline }

procedure PrepareHTMLOutline(Outline: TfrxCustomOutline;
  Node: TfrxHTMLOutlineNode; ObjNum: Integer);
var
  i: Integer;
  p: TfrxHTMLOutlineNode;
  Prev: TfrxHTMLOutlineNode;
  Text: string;
  Page, Top: Integer;
begin
  Prev := nil;
  p := nil;

  for i := 0 to Outline.Count - 1 do
  begin
    Outline.GetItem(i, Text, Page, Top);

    p := TfrxHTMLOutlineNode.Create;
    p.Title := Text;
    p.Dest := Page;
    p.Top := Top;
    p.Prev := Prev;

    Inc(ObjNum);
    p.Number := ObjNum;

    if Prev <> nil then
      Prev.Next := p
    else
      Node.First := p;

    Prev := p;
    p.Parent := Node;
    Outline.LevelDown(i);

    PrepareHTMLOutline(Outline, p, ObjNum);
    Inc(ObjNum, p.CountTree);

    Node.Count := Node.Count + 1;
    Node.CountTree := Node.CountTree + p.CountTree + 1;
    Outline.LevelUp;
  end;

  Node.Last := p;
end;

procedure WriteHTMLOutline(Node: TfrxHTMLOutlineNode; var html: String);
begin
  html := html + '<li>';
  html := html + '<a class = "outlineNode" href="#' + Node.Title + '">' +
    Node.Title + '</a>';
  if Node.First <> nil then
  begin
    html := html + '<ul>';
    WriteHTMLOutline(TfrxHTMLOutlineNode(Node.First), html);
    html := html + '</ul>';
  end;
  html := html + '</li>';
  if Node.Next <> nil then
    WriteHTMLOutline(TfrxHTMLOutlineNode(Node.Next), html);
end;

function GetIdOutlineHTML(Top: Extended; Height: Extended;
  var FOutlineTree: TfrxHTMLOutlineNode; PageH: Extended): String;
begin
  Result := '';
  if (FOutlineTree <> nil) then
    if (Round(Top - Height - PageH) = Round(FOutlineTree.Top)) then
    begin
      Result := ' id="' + VarToStr(FOutlineTree.Title) + '"';
      if FOutlineTree.First <> nil then
        FOutlineTree := TfrxHTMLOutlineNode(FOutlineTree.First)
      else if FOutlineTree.Next <> nil then
        FOutlineTree := TfrxHTMLOutlineNode(FOutlineTree.Next)
      else
      begin
        FOutlineTree := TfrxHTMLOutlineNode(FOutlineTree.Parent);
        FOutlineTree := TfrxHTMLOutlineNode(FOutlineTree.Next);
      end;
    end
end;

{ TTextFragment }

procedure TTextFragment.Add(const s: string);
begin
  FText := FText + frIfStr(FFormatted and (FText <> ''), #13#10) + s;
end;

procedure TTextFragment.Add(const Fmt: string; const Args: array of const);
begin
  Add(Format(Fmt, Args));
end;

constructor TTextFragment.Create(AFormatted: boolean);
begin
  FFormatted := AFormatted;
  FText := '';
end;

{ TExportHTMLDivSVGParent }

function TExportHTMLDivSVGParent.EnableCalculateHash: Boolean;
begin
  Result := True;
end;

procedure TExportHTMLDivSVGParent.AttachHandler(Handler: TfrxExportHandler);
begin
  SetLength(FHandlers, Length(FHandlers) + 1);
  FHandlers[Length(FHandlers) - 1] := Handler;
end;

constructor TExportHTMLDivSVGParent.Create(AOwner: TComponent);
begin
  inherited;

  OpenAfterExport := False;
  MultiPage := False;
  Formatted := False;
  PictureFormat := pfPNG;
  UnifiedPictures := True;
  Navigation := False;
  EmbeddedCSS := True;
  EmbeddedPictures := True;
  FFilterStream := nil;
end;

procedure TExportHTMLDivSVGParent.ExportObject(Obj: TfrxComponent);
begin
  if Obj is TfrxView then
    RunExportsChain(Obj as TfrxView);

  inherited;
end;

function TExportHTMLDivSVGParent.ExportViaVector(Obj: TfrxView): AnsiString;
var
  AMS: TAnsiMemoryStream;
  VC: TVectorCanvas;
  i: Integer;
  ClippedShift: TPoint;
  CLippedMemo: Boolean;
begin
  Result := '';
  AMS := TAnsiMemoryStream.Create(Formatted);
  try
    VC := Obj.GetVectorCanvas;
    try
      CLippedMemo := (Obj is TfrxCustomMemoView) and TfrxCustomMemoView(Obj).Clipped;
      if CLippedMemo then
      begin
        ClippedShift := Point(0, 0);
        with Obj do
          AMS.Puts('<svg x="%s" y="%s" width="%s" height="%s">',
            [Float2Str(AbsLeft), Float2Str(AbsTop), Float2Str(Width), Float2Str(Height)]);
      end
      else
        with Obj do
          ClippedShift := Point(Round(AbsLeft), Round(AbsTop));

      for i := 0 to VC.Count - 1 do
        if isFRExtTextOut(VC[i]) then
          Vector_ExtTextOut(Obj, AMS, TVector_ExtTextOut(VC[i]), ClippedShift);

      if CLippedMemo then
        AMS.Puts('</svg>');
    finally
      VC.Free;
    end;
    Result := AMS.AsAnsiString;
  finally
    AMS.Free;
  end;
end;

procedure TExportHTMLDivSVGParent.FreeStream;
begin
  if Assigned(FFilterStream) then
  begin
    IOTransport.DoFilterProcessStream(FFilterStream, Self);
    FCurrentFile.Free;
    IOTransport.FreeStream(FFilterStream);
    FFilterStream := nil;
  end
end;

function TExportHTMLDivSVGParent.GetCSSFileName: string;
begin
  if Multipage then
    Result := 'styles.css'
  else
    Result := ExtractFileName(FileName) + '.css'
end;

function TExportHTMLDivSVGParent.GetCSSFilePath: string;
begin
  if Multipage then
    Result := FileName + PathDelim + GetCSSFileName
  else
    Result := ExtractFileDir(FileName) + PathDelim + GetCSSFileName
end;

function TExportHTMLDivSVGParent.IsCanSavePicture(Pic: TGraphic): Boolean;
begin
  { If the SVG is written to a specified stream (maybe a TMemoryStream),
    additional files with pictures cannot be created. }
  Result := not (Assigned(Stream) and not EmbeddedPictures or
                 (Pic = nil) or (Pic.Width <= 0) or (Pic.Height <= 0));
end;

function TExportHTMLDivSVGParent.LockStyle(Style: TfrxCSSStyle): string;
begin
  Result := FCSS.AddStyle(Style)
end;

procedure TExportHTMLDivSVGParent.Puts(const s: string);
begin
{$IFDEF DELPHI12}
  PutsA(AnsiString(Utf8Encode(s)));
{$ELSE}
  PutsA(AnsiString(s));
{$ENDIF}
end;

procedure TExportHTMLDivSVGParent.Puts(const Fmt: string; const Args: array of const);
begin
  Puts(Format(Fmt, Args));
end;

procedure TExportHTMLDivSVGParent.PutsA(const s: AnsiString);
begin
  PutsRaw(s);

  if Formatted and (s <> '') then
    PutsRaw(#13#10);
end;

procedure TExportHTMLDivSVGParent.PutsRaw(const s: AnsiString);
begin
  if s <> '' then
    FCurrentFile.Write(s[1], Length(s))
end;

procedure TExportHTMLDivSVGParent.RunExportsChain(Obj: TfrxView);
var
  i: Integer;
begin
  for i := Length(FHandlers) - 1 downto 0 do
    if TfrxExportHandler(FHandlers[i])(Obj) then
      Break;
end;

procedure TExportHTMLDivSVGParent.SaveCSS(const FileName: string);
var
  s, sf: TStream;
begin
  s := nil;
  sf := IOTransport.GetStream(FileName);
  try
    s := TCachedStream.Create(sf, False);
    if not IOTransport.DoFilterProcessStream(sf, Self) then
      FCSS.Save(s, Formatted)
  finally
    s.Free;
    IOTransport.FreeStream(sf);
  end
end;

function TExportHTMLDivSVGParent.SavePicture(Pic: TGraphic; PNum: Integer = -1): String;
begin
  if not EmbeddedPictures then
    Result := SavePicInPath(Pic, IOTransport, PNum)
  else
    Result := Format('data:%s;base64,', [GetPicInfo(Pic).Mimetype]) +
      String(GraphicToBase64AnsiString(Pic));
end;

procedure TExportHTMLDivSVGParent.SetMultiPage(const Value: Boolean);
begin
  FMultiPage := Value;
  Outline := Outline and not FMultiPage;
end;

function TExportHTMLDivSVGParent.SavePicInPath(Pic: TGraphic; Filter: TfrxCustomIOTransport; PNum: Integer): String;
var
  Stream: TMemoryStream;
  s: TStream;
begin
  Stream := TMemoryStream.Create;
  Pic.SaveToStream(Stream);
  try
    Result := GetPicPath(Pic, PNum);
    s := Filter.GetStream(FWorkDir + Result);
    try
      if not Filter.DoFilterProcessStream(s, Pic) then
        Stream.SaveToStream(s);
    finally
      Filter.FreeStream(s);
    end;
  finally
    Stream.Free;
  end;
end;

function TExportHTMLDivSVGParent.GetPicPath(Pic: TGraphic; PNum: Integer): String;
begin
  Result := FPrefix + IntToStr(PNum) + GetPicInfo(Pic).Extension;
end;

procedure TExportHTMLDivSVGParent.SetPicFormat(Fmt: TfrxPictureFormat);
begin
  if Fmt in [{$IFNDEF FPC}pfEMF,{$ENDIF} pfBMP, pfPNG, pfJPG] then
    FPicFormat := Fmt
  else
    raise Exception.Create('Invalid PictureFormat')
end;

function TExportHTMLDivSVGParent.Start: Boolean;

  procedure SetImgPath(const WorkDir: string; Prefix: string = '');
  begin
    if (WorkDir = '') or (WorkDir[Length(WorkDir)] = PathDelim) then
      FWorkDir := WorkDir
    else
      FWorkDir := WorkDir + PathDelim;
    FPrefix := Prefix;
  end;

begin
  Result := False;

  if (FileName = '') and not Assigned(Stream) then
    Exit;
  if ((not FServer) and (MultiPage)) then
  begin
    if FileExists(FileName) and not DeleteFile(FileName) then
      Exit;

    //if not CreateDir(FileName) then
    //  Exit;
    IOTransport.CreateContainer(ExtractFileName(FileName));
  end
  else
  begin
    if Assigned(Stream) then
      FFilterStream := Stream
    else
      FFilterStream := IOTransport.GetStream(FileName);

    try
      FCurrentFile := TCachedStream.Create(FFilterStream, False);
    except
      Exit
    end;
  end;
//  else
//    try
//      IOTransport.GetStream(FileName)
//      FCurrentFile := TCachedStream.Create(
//        TFileStream.Create(FileName, fmCreate),
//        True)
//    except
//      Exit
//    end;
  if not FServer then
  if Multipage then
    SetImgPath(FileName)
  else
    SetImgPath(ExtractFileDir(FileName), ExtractFileName(FileName) + '-');

  CreateCSS;

  FCurrentPage := 0;
  Result := True;
end;

procedure TExportHTMLDivSVGParent.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  inherited;
  Inc(FCurrentPage);
  if not FServer then
  if MultiPage then
  begin
    if not Assigned(FFilterStream) then
    begin
      IOTransport.FileName := Format('%s' + PathDelim + '%d' + DefaultExt, [FileName, FCurrentPage]);
      FFilterStream := IOTransport.GetStream(IOTransport.FileName);
    end;
    try
      FCurrentFile := TCachedStream.Create(FFilterStream, False);
    except
      Exit
    end;
  end;

//    FCurrentFile := TCachedStream.Create(
//      TFileStream.Create(
//        Format('%s\%d' + DefaultExt, [FileName, FCurrentPage]),
//        fmCreate),
//        True);
end;

procedure TExportHTMLDivSVGParent.Vector_ExtTextOut(Obj: TfrxView; AMS: TAnsiMemoryStream; Vector: TVector_ExtTextOut; const Shift: TPoint);
var
  Memo: TfrxCustomMemoView;

  function MeasureTextLength: String;
  begin
    Result := '';
    if Vector.Dx <> nil then
      Result := Format('textLength="%d" lengthAdjust="spacingAndGlyphs"',
        [Vector.TextLength]);
  end;

  function MeasureFontOrientation: String;
  begin
    Result := '';
    if Memo.ReducedAngle <> 0 then
      Result := Format('transform="rotate(%s %d,%d)"',
        [frFloat2Str(-Memo.ReducedAngle, 1), Vector.X + Shift.X, Vector.Y + Shift.Y]);
  end;

  function CSSPaintStyleName: string;
  begin
    with TfrxCSSStyle.Create do
    begin
      Style['fill'] := GetColor(Obj.Font.Color);
      Style['fill-rule'] := 'evenodd';

      Style['text-anchor'] := 'start'; // Any Memo.HAlign
      Style['dominant-baseline'] := 'auto'; // Any Memo.VAlign
      Style['font-family'] := Obj.Font.Name;
      Style['font-size'] := IntToStr(Obj.Font.Size) + 'pt';
      Style['font-weight'] := frIfStr(fsBold in Obj.Font.Style, 'bold');
      Style['font-style'] := frIfStr(fsItalic in Obj.Font.Style, 'italic');
      Style['text-decoration'] := frIfStr(fsStrikeout in Obj.Font.Style, 'line-through');
      Style['text-decoration'] := frIfStr(fsUnderline in Obj.Font.Style, 'underline');

      Result := FCSS.AddStyle(This);
    end;
  end;

begin
  Memo := TfrxCustomMemoView(Obj);

  AMS.Puts('<text class="%s" x="%d" y="%d" %s %s>', [CSSPaintStyleName,
    Vector.X + Shift.X, Vector.Y + Shift.Y + Round(Memo.Font.Size * 1.4),
    MeasureFontOrientation, MeasureTextLength]);
  AMS.Puts(SVGStartSpace(SVGEscapeTextAndAttribute(WideString(Vector.Str))));
  AMS.Puts('</text>');
end;

{ TAnsiMemoryStream }

function TAnsiMemoryStream.AsAnsiString: AnsiString;
begin
  Position := 0;
  SetLength(Result, Size);
  ReadBuffer(Result[1], Size);
end;

constructor TAnsiMemoryStream.Create(AFormatted: boolean = False);
begin
  inherited Create;
  FFormatted := AFormatted;
end;

procedure TAnsiMemoryStream.Puts(const s: string);
begin
{$IFDEF DELPHI12}
  PutsA(AnsiString(Utf8Encode(s)));
{$ELSE}
  PutsA(AnsiString(s));
{$ENDIF}
end;

procedure TAnsiMemoryStream.Puts(const Fmt: string; const Args: array of const);
begin
  Puts(Format(Fmt, Args));
end;

procedure TAnsiMemoryStream.PutsA(const s: AnsiString);
begin
  PutsRaw(s);

  if FFormatted and (s <> '') then
    PutsRaw(#13#10);
end;

procedure TAnsiMemoryStream.PutsRaw(const s: AnsiString);
begin
  if s <> '' then
    Write(s[1], Length(s))
end;

{ TRotation2D }

procedure TRotation2D.Init(Radian: Extended; Center: TfrxPoint; Precision: Integer = DefaultPrec);
begin
  FCenter := Center;

  SinCos(Radian, Sinus, Cosinus);
  with FCenter do
  begin
    C1 := X - X * Cosinus + Y * Sinus;
    C2 := Y - X * Sinus -   Y * Cosinus;
  end;

  FMatrix := Float2Str(Cosinus, 4) +  ' ' + Float2Str(Sinus, 4) + ' ' +
             Float2Str(-Sinus, 4) +   ' ' + Float2Str(Cosinus, 4) + ' ' +
             Float2Str(C1, Precision) +       ' ' + Float2Str(C2, Precision);
end;

function TRotation2D.Turn(DP: TfrxPoint): TfrxPoint;
begin
  with FCenter do
    Result := frxPoint(X + (DP.X - X) * Cosinus + (DP.Y - Y) * Sinus,
                       Y - (DP.X - X) * Sinus +   (DP.Y - Y) * Cosinus);
end;

function TRotation2D.Turn2Str(DP: TfrxPoint): string;
begin
  Result := frxPoint2Str(Turn(DP));
end;

{ TfrxExportFont }

constructor TfrxExportFont.Create(Font: TFont);
var
  dpi: integer;
begin

  SourceFont := TFont.Create;
  dpi := SourceFont.PixelsPerInch;
  SourceFont.Assign(Font);
  FDpiFX := 96 / dpi;
  PDFdpi_divider := 1 / (750 * FDpiFX);
  SourceFont.Size := Round(750 * FDpiFX);
  GlobalTempBitmap := TBitmap.Create;
  Widths := TList.Create;
  UsedAlphabet := TList.Create;
  UsedAlphabetUnicode := TList.Create;
  PackFont := true;
  {$IFDEF Linux}
  FontData := TMemoryStream.Create();
  {$ELSE}
  FontData := nil;
  FontDataSize := 0;
  {$ENDIF}
  TextMetric := nil;
  FUSCache := nil;
  TrueTypeTables := nil;
  FForceAnsi := False;
end;

destructor TfrxExportFont.Destroy;
begin
  GlobalTempBitmap.Free;
  if FontDataSize > 0 then
  begin
    {$IFNDEF Linux}
    FreeMemory(FontData);
    FontDataSize := 0;
    {$ELSE}
    FontData.Free;
    {$ENDIF}
    FontData := nil;
  end;
  if TextMetric <> nil then
  begin
    FreeMemory(TextMetric);
    TextMetric := nil;
  end;

  TrueTypeTables.Free;
  SourceFont.Free;
  Widths.Free;
  UsedAlphabet.Free;
  UsedAlphabetUnicode.Free;
  {$IFNDEF Linux}
  ScriptFreeCache(@FUSCache);
  {$ENDIF}
  inherited;
end;

procedure TfrxExportFont.GetFontFile;
var
  {$IFNDEF Linux}
  CollectionMode:   Cardinal;
  {$ELSE}
  FntData :TFontData;
  {$ENDIF}
begin
{$IFDEF DEBUG_WITH_FASTMM}
{$define FullDebugMode}
  ShowFastMMUsageTracker;
{$ENDIF}

  if ttf <> nil then Exit;

  GlobalTempBitmap.Canvas.Lock;
  try
    GlobalTempBitmap.Canvas.Font.Assign(SourceFont);
    {$IFNDEF Linux}
    CollectionMode := $66637474;
    {$ENDIF}
    if Assigned(FontData) then
      if FontDataSize > 0 then
      begin
        FreeMemory(FontData);
{$IFNDEF Linux}
        FontDataSize := 0;
{$ENDIF}
        FontData := nil;
      end;
    {$IFNDEF Linux}
    FontDataSize := GetFontData(GlobalTempBitmap.Canvas.Handle, CollectionMode, 0, nil, 1);
    //if FontDataSize > 0 then
    begin
      if Cardinal(FontDataSize) = High(Cardinal) then
      begin
         CollectionMode := 0;
         FontDataSize := GetFontData(GlobalTempBitmap.Canvas.Handle, CollectionMode, 0, nil, 1);
      end;
      FontData := GetMemory(FontDataSize);
      if FontData <> nil then
      begin
        GetFontData(GlobalTempBitmap.Canvas.Handle, CollectionMode, 0, FontData, FontDataSize);
        if Self.PackFont then
        begin
          FreeAndNil(Self.TrueTypeTables);
          Self.TrueTypeTables := TrueTypeCollection.Create();
          Self.TrueTypeTables.Initialize( FontData, FontDataSize );
          ttf := Self.TrueTypeTables.LoadFont( Self.SourceFont );
        end;
      end
      else
        FontDataSize := 0;
    end;
    {$ELSE}
    FntData := GetFontData(GlobalTempBitmap.Canvas.Handle);
    if @FntData <> nil then
    begin
        if Self.PackFont then
        begin
          Self.TrueTypeTables := TrueTypeCollection.Create();
          //Self.TrueTypeTables.Initialize( PChar(FntData.Pitch), 123123 ); //?
          ttf := Self.TrueTypeTables.LoadFont( Self.SourceFont );
        end;
    end;
    {$ENDIF}
  finally
    GlobalTempBitmap.Canvas.Unlock;
  end;
end;

function TfrxExportFont.GetGlyphIndices(hdc: HDC; text: WideString; glyphs: PWord; widths: PInteger; rtl, IsIndexes: Boolean): integer;
var
  maxGlyphs: Integer;
  maxItems: Integer;
  runs: TList;
  i, j, len: Integer;
  tempGlyphs, g1, g2: PWord;
  tempWidths, w1, w2: PInteger;
  run: TfrxPDFRun;
  a: SCRIPT_ANALYSIS;
begin
  if text = '' then
    result := 0
  else
  begin
    maxGlyphs := Length(text) * 3;
    maxItems := Length(text) * 2;
    if not IsIndexes then
    begin
      runs := Itemize(text, rtl, maxItems);
      runs := Layout(runs, rtl);
    end
    else
    begin
      runs := TList.Create;
      ZeroMemory(@a, sizeof(SCRIPT_ANALYSIS));
      if rtl then
        a.fFlags := 31
      else
        a.fFlags := 15;
      run := TfrxPDFRun.Create(text, a);
      runs.Add(run);
    end;
    result := 0;
    g2 := glyphs;
    w2 := widths;
    tempGlyphs := GetMemory(SizeOf(Word) * maxGlyphs);
    tempWidths := GetMemory(SizeOf(Integer) * maxGlyphs);
    try
      for i := 0 to runs.Count - 1 do
      begin
        run := TfrxPDFRun(runs[i]);
        len := GetGlyphs(hdc, run, tempGlyphs, tempWidths, maxGlyphs, rtl, IsIndexes);
        g1 := tempGlyphs;
        w1 := tempWidths;
        for j := 1 to len do
        begin
          g2^ := g1^;
          w2^ := w1^;
          Inc(g1);
          Inc(g2);
          Inc(w1);
          Inc(w2);
        end;
        Inc(result, len);
        run.Free;
      end;
    finally
      FreeMemory(tempGlyphs);
      FreeMemory(tempWidths);
    end;
    runs.Free;
  end;
end;

function TfrxExportFont.GetGlyphs(hdc: HDC; run: TfrxPDFRun; glyphs: PWord; widths: PInteger; maxGlyphs: integer; rtl, IsIndexes: Boolean): Integer;
var
  psa: SCRIPT_ANALYSIS;
  pwLogClust: PWord;
  pcGlyphs, i: Integer;
  psva, lpsva, glyphsTmp: PWord;
  pGoffset_, pCurGoffset: PGOffset;
  pABC_: PABC;
  awidths, PrevWidth: PInteger;
begin
  psa := run.analysis;
  pcGlyphs := 0;
  pwLogClust := GetMemory(SizeOf(Word) * maxGlyphs);
  psva := GetMemory(SizeOf(Word) * maxGlyphs);
  {$IFDEF FPC}
  psva^ := 0;
  {$ELSE}
  ZeroMemory(psva, SizeOf(Word) * maxGlyphs);
  {$ENDIF}
  pGoffset_ := GetMemory(SizeOf(GOffset) * maxGlyphs);
  pABC_ := GetMemory(SizeOf({$IFDEF NonWinFPC}_ABC{$ELSE}ABC{$ENDIF}) * maxGlyphs);
  psa := run.analysis;
  try
    {$IFNDEF Linux}
    if not IsIndexes then
      ScriptShape(hdc, @FUSCache, PWideChar(run.text), Length(run.text), maxGlyphs, @psa, glyphs, pwLogClust, psva, @pcGlyphs)
    else
    {$ENDIF}
    begin
      pcGlyphs := Length(run.text);
      glyphsTmp := glyphs;
      for i := 0 to pcGlyphs - 1 do
      begin
        glyphsTmp^ := Word(run.text[i + 1]);
        Inc(glyphsTmp);
      end;
    end;
    {$IFNDEF Linux}
    ScriptPlace(hdc, @FUSCache, glyphs, pcGlyphs, psva, @psa, widths, pGoffset_, pABC_);
    {$ENDIF}
    awidths := widths;
    PrevWidth := awidths;
    pCurGoffset := pGoffset_;
    lpsva := psva;
    { uniscribe already returns correct widths , but i'm not sure about different fonts }
    { so just in case we are trying to correct them }
    { remove after testing }
    for i := 0 to pcGlyphs - 1 do
    begin
      if (pCurGoffset^.du > 0) and (i > 0) or (lpsva^ and 32 = 32) then
      begin
        if PrevWidth^ < pCurGoffset^.du + awidths^ then
          PrevWidth^ := pCurGoffset^.du + awidths^;
        awidths^ := -1;// mark ligature to use later
      end;
      PrevWidth := awidths;
      Inc(awidths);
      Inc(lpsva);
      inc(pCurGoffset);
    end;

  finally
    FreeMemory(pwLogClust);
    FreeMemory(psva);
    FreeMemory(pGoffset_);
    FreeMemory(pABC_);
  end;
  Result := pcGlyphs;
end;

function TfrxExportFont.Itemize(s: WideString; rtl: boolean; maxItems: Integer): TList;
var
  pItems, pItems_: PScriptItem;
  pcItems: Integer;
  control: Integer;
  state: Word;
  i: Integer;
  text: WideString;
  p1, p2: Integer;
  run: TfrxPDFRun;
  a: SCRIPT_ANALYSIS;
begin
  pItems := GetMemory(SizeOf(SCRIPT_ITEM) * maxItems);
  try
    pcItems := 0;
    if rtl then
      state := 1
    else
      state := 0;
    control := 0;
    {$IFNDEF Linux}
    if rtl then
      ScriptApplyDigitSubstitution(nil, @control, @state);
    ScriptItemize(PWideChar(s), Length(s), maxItems, @control, @state, pItems, @pcItems);
    {$ENDIF}
    result := TList.Create;
    pItems_ := pItems;
    for i := 0 to pcItems - 1 do
    begin
      p1 := pItems_^.iCharPos;
      a := pItems_^.a;
      Inc(pItems_);
      p2 := pItems_^.iCharPos;
      text := Copy(s, p1 + 1, p2 - p1);
      run := TfrxPDFRun.Create(text, a);
      result.Add(run);
    end;
  finally
    FreeMemory(pItems);
  end;
end;

function TfrxExportFont.Layout(runs: TList; rtl: boolean): TList;
var
  pbLevel, p1: PByte;
  piVisualToLogical, piVT: PInteger;
  i: Integer;
  run: TfrxPDFRun;
begin
  pbLevel := GetMemory(runs.Count);
  piVT := GetMemory(SizeOf(Integer) * runs.Count);
  try
    p1 := pbLevel;
    for i := 0 to runs.Count - 1 do
    begin
      p1^ := byte(TfrxPDFRun(runs[i]).analysis.s and $1F);
      Inc(p1);
    end;
    {$IFNDEF Linux}
    ScriptLayout(runs.Count, pbLevel, piVT, nil);
    {$ENDIF}
    result := TList.Create;
    piVisualToLogical := piVT;
    for i := 0 to runs.Count - 1 do
    begin
      run := TfrxPDFRun(runs[piVisualToLogical^]);
      result.Add(run);
      Inc(piVisualToLogical);
    end;
  finally
    FreeMemory(pbLevel);
    FreeMemory(piVT);
    runs.Free;
  end;
end;

function TfrxExportFont.RemapString(str: WideString; rtl, IsIndexes: Boolean): TRemapedString;

  function ToWord(WCh: WideChar): Word;
  begin
    Result := Word(WCh);
    if FForceAnsi then
      Result := Result and $FF;
  end;
var
  maxGlyphs, UsedIndex: Integer;
  g, g_: PWord;
  w, w_: PInteger;
  actualLength: Integer;
  i, j: Integer;
  c: Word;
  wc: WideChar;
  {$IFDEF Linux}
  FName: String;
  {$ENDIF}
begin
  Result.Width := 0;
  Result.SpacesCount := 0;
  Result.IsValidCharWidth := True;
  Result.Data := '';

  maxGlyphs := Length(str) * 3;
  g := GetMemory(SizeOf(Word) * maxGlyphs);
  w := GetMemory(SizeOf(Integer) * maxGlyphs);
  GlobalTempBitmap.Canvas.Lock;
  try
    GlobalTempBitmap.Canvas.Font.Assign(SourceFont);
    {$IFDEF Linux}
    FName := SourceFont.Name;
    actualLength := TrueTypeTables.Item[FName].GetGlyphIndices(str, g, w, rtl);
    {$ELSE}
    actualLength := GetGlyphIndices(GlobalTempBitmap.Canvas.Handle, str, g, w, rtl, IsIndexes);
    {$ENDIF}
    Result.IsHasLigatures := actualLength <> Length(str);
    if FIsLigatureless and Result.IsHasLigatures then
      Exit;
    SetLength(Result.CharWidth, actualLength);

    g_ := g;
    w_ := w;
    for i := 0 to  actualLength - 1 do
    begin
      if rtl then
        j := actualLength - i
      else
        j := i + 1;

      Result.CharWidth[j - 1] := w_^;
      Result.IsValidCharWidth := Result.IsValidCharWidth and (w_^ < $ffff);
      c := g_^;
      { skip ligature }
      if w_^ <> -1 then
        Inc(Result.Width, w_^);

      if (c = 667) and (Pos('Arial', SourceFont.Name) = 1) then
        continue; { Arial Unicode $1f charcode }

      UsedIndex := UsedAlphabet.IndexOf(Pointer(c));
      if UsedIndex = -1 then
      begin
        UsedAlphabet.Add(Pointer(c));
        Widths.Add(Pointer(w_^));
        if actualLength = Length(str) then
          UsedAlphabetUnicode.Add(Pointer(ToWord(str[j])))
        else
          UsedAlphabetUnicode.Add(Pointer(TextMetric^.otmTextMetrics.tmDefaultChar));
      end
      else if FSameCharacterWidth then
      begin
        if w_^ <> -1 then
          Dec(Result.Width, w_^);
        Result.CharWidth[j - 1] := Integer(Widths[UsedIndex]);
        if Result.CharWidth[j - 1] <> -1 then
          Inc(Result.Width, Result.CharWidth[j - 1]);
      end;


      wc := WideChar(c);
      Result.Data := Result.Data + wc;
      if wc = #3 then
        Inc(Result.SpacesCount);
      Inc(g_);
      Inc(w_);
    end;

  GetFontFile;
  finally
    FreeMemory(g);
    FreeMemory(w);
    GlobalTempBitmap.Canvas.Unlock;
  end;
end;

function TfrxExportFont.SoftRemapString(str: WideString; rtl, IsIndexes: Boolean): TRemapedString;

  function IsNeedCountWidthSymbolBySymbol: Boolean;
  begin
    Result := ((Pos('Arial', SourceFont.Name) = 1) or FSameCharacterWidth) and
      not IsDevanagari(str);
  end;

const
  SPACE = WideChar($20);
  NO_BREAK_SPACE = WideChar($A0);
  NARROW_NO_BREAK_SPACE = WideChar($202F);
  WORD_JOINER = WideChar($2060);
var
  i, Len: Integer;
  TotalData: WideString;
  TotalCharWidth: TIntegerDinArray;
begin
  Result.Data := '';
  if str = '' then
    Exit;

  Len := Length(str);
  if IsNeedCountWidthSymbolBySymbol then
    for i := 1 to Len do
      RemapString(str[i], rtl, False);
  FIsLigatureless := IsLigatureless(SourceFont.Name);
  Result := RemapString(str, rtl, IsIndexes);

  if FIsLigatureless and Result.IsHasLigatures then
  begin
    SetLength(TotalData, Len);
    SetLength(TotalCharWidth, Len);
    for i := 1 to Len do
    begin
      Result := RemapString(str[i], rtl, IsIndexes);
      TotalData[i] := Result.Data[1];
      TotalCharWidth[i - 1] := Result.CharWidth[0];
    end;
    Result.Width := 0;
    for i := 1 to Len do
      Result.Width := Result.Width + TotalCharWidth[i - 1];
    Result.Data := TotalData;
    Result.CharWidth := TotalCharWidth;

    Result.IsHasLigatures := False;
  end;

  SetLength(Result.IsSpace, Len);
  for i := 1 to Len do
    Result.IsSpace[i - 1] := (str[i] = SPACE)
                          or (str[i] = NO_BREAK_SPACE)
                          or (str[i] = NARROW_NO_BREAK_SPACE)
                          or (str[i] = WORD_JOINER);
end;

{ TfrxPDFRun }

constructor TfrxPDFRun.Create(t: WideString; a: SCRIPT_ANALYSIS);
begin
  text := t;
  analysis := a;
end;

{ For HTML }

function ReverseSlash(const S: String): String;
begin
  Result := StringReplace(S, '\', '/', [rfReplaceAll]);
end;

function frxPictureFormatToStr(Format: TfrxPictureFormat): String;
begin
  Result := 'BMP';
  case Format of
    pfPNG: Result := 'PNG';
    pfEMF: Result := 'FREMF';
    pfBMP: Result := 'BMP';
    pfJPG: Result := 'JPG';
  end;
end;

{ TTernaryRasterOperation }

procedure TernaryRasterOperationNeeds(dwRop: DWORD; out NeedD, NeedP, NeedS: Boolean);
var
  ReversePolish: string;
begin
  ReversePolish := string(TTernaryRasterOperation.GetReversePolish(dwRop));
  NeedD := Pos('D', ReversePolish) > 0;
  NeedP := Pos('P', ReversePolish) > 0;
  NeedS := Pos('S', ReversePolish) > 0;
end;

class function TTernaryRasterOperation.GetReversePolish(dwRop: DWORD): AnsiString;
begin
  Result := '';
  case dwRop of
    $000042: Result := '0';           // BLACKNESS
    $010289: Result := 'DPSoon';
    $020C89: Result := 'DPSona';
    $0300AA: Result := 'PSon';
    $040C88: Result := 'SDPona';
    $0500A9: Result := 'DPon';
    $060865: Result := 'PDSxnon';
    $0702C5: Result := 'PDSaon';
    $080F08: Result := 'SDPnaa';
    $090245: Result := 'PDSxon';
    $0A0329: Result := 'DPna';
    $0B0B2A: Result := 'PSDnaon';
    $0C0324: Result := 'SPna';
    $0D0B25: Result := 'PDSnaon';
    $0E08A5: Result := 'PDSonon';
    $0F0001: Result := 'Pn';
    $100C85: Result := 'PDSona';
    $1100A6: Result := 'DSon';        // NOTSRCERASE
    $120868: Result := 'SDPxnon';
    $1302C8: Result := 'SDPaon';
    $140869: Result := 'DPSxnon';
    $1502C9: Result := 'DPSaon';
    $165CCA: Result := 'PSDPSanaxx';
    $171D54: Result := 'SSPxDSxaxn';
    $180D59: Result := 'SPxPDxa';
    $191CC8: Result := 'SDPSanaxn';
    $1A06C5: Result := 'PDSPaox';
    $1B0768: Result := 'SDPSxaxn';
    $1C06CA: Result := 'PSDPaox';
    $1D0766: Result := 'DSPDxaxn';
    $1E01A5: Result := 'PDSox';
    $1F0385: Result := 'PDSoan';
    $200F09: Result := 'DPSnaa';
    $210248: Result := 'SDPxon';
    $220326: Result := 'DSna';
    $230B24: Result := 'SPDnaon';
    $240D55: Result := 'SPxDSxa';
    $251CC5: Result := 'PDSPanaxn';
    $2606C8: Result := 'SDPSaox';
    $271868: Result := 'SDPSxnox';
    $280369: Result := 'DPSxa';
    $2916CA: Result := 'PSDPSaoxxn';
    $2A0CC9: Result := 'DPSana';
    $2B1D58: Result := 'SSPxPDxaxn';
    $2C0784: Result := 'SPDSoax';
    $2D060A: Result := 'PSDnox';
    $2E064A: Result := 'PSDPxox';
    $2F0E2A: Result := 'PSDnoan';
    $30032A: Result := 'PSna';
    $310B28: Result := 'SDPnaon';
    $320688: Result := 'SDPSoox';
    $330008: Result := 'Sn';          // NOTSRCCOPY
    $3406C4: Result := 'SPDSaox';
    $351864: Result := 'SPDSxnox';
    $3601A8: Result := 'SDPox';
    $370388: Result := 'SDPoan';
    $38078A: Result := 'PSDPoax';
    $390604: Result := 'SPDnox';
    $3A0644: Result := 'SPDSxox';
    $3B0E24: Result := 'SPDnoan';
    $3C004A: Result := 'PSx';
    $3D18A4: Result := 'SPDSonox';
    $3E1B24: Result := 'SPDSnaox';
    $3F00EA: Result := 'PSan';
    $400F0A: Result := 'PSDnaa';
    $410249: Result := 'DPSxon';
    $420D5D: Result := 'SDxPDxa';
    $431CC4: Result := 'SPDSanaxn';
    $440328: Result := 'SDna';        // SRCERASE
    $450B29: Result := 'DPSnaon';
    $4606C6: Result := 'DSPDaox';
    $47076A: Result := 'PSDPxaxn';
    $480368: Result := 'SDPxa';
    $4916C5: Result := 'PDSPDaoxxn';
    $4A0789: Result := 'DPSDoax';
    $4B0605: Result := 'PDSnox';
    $4C0CC8: Result := 'SDPana';
    $4D1954: Result := 'SSPxDSxoxn';
    $4E0645: Result := 'PDSPxox';
    $4F0E25: Result := 'PDSnoan';
    $500325: Result := 'PDna';
    $510B26: Result := 'DSPnaon';
    $5206C9: Result := 'DPSDaox';
    $530764: Result := 'SPDSxaxn';
    $5408A9: Result := 'DPSonon';
    $550009: Result := 'Dn';          // DSTINVERT
    $5601A9: Result := 'DPSox';
    $570389: Result := 'DPSoan';
    $580785: Result := 'PDSPoax';
    $590609: Result := 'DPSnox';
    $5A0049: Result := 'DPx';         // PATINVERT
    $5B18A9: Result := 'DPSDonox';
    $5C0649: Result := 'DPSDxox';
    $5D0E29: Result := 'DPSnoan';
    $5E1B29: Result := 'DPSDnaox';
    $5F00E9: Result := 'DPan';
    $600365: Result := 'PDSxa';
    $6116C6: Result := 'DSPDSaoxxn';
    $620786: Result := 'DSPDoax';
    $630608: Result := 'SDPnox';
    $640788: Result := 'SDPSoax';
    $650606: Result := 'DSPnox';
    $660046: Result := 'DSx';         // SRCINVERT
    $6718A8: Result := 'SDPSonox';
    $6858A6: Result := 'DSPDSonoxxn';
    $690145: Result := 'PDSxxn';
    $6A01E9: Result := 'DPSax';
    $6B178A: Result := 'PSDPSoaxxn';
    $6C01E8: Result := 'SDPax';
    $6D1785: Result := 'PDSPDoaxxn';
    $6E1E28: Result := 'SDPSnoax';
    $6F0C65: Result := 'PDXnan';
    $700CC5: Result := 'PDSana';
    $711D5C: Result := 'SSDxPDxaxn';
    $720648: Result := 'SDPSxox';
    $730E28: Result := 'SDPnoan';
    $740646: Result := 'DSPDxox';
    $750E26: Result := 'DSPnoan';
    $761B28: Result := 'SDPSnaox';
    $7700E6: Result := 'DSan';
    $7801E5: Result := 'PDSax';
    $791786: Result := 'DSPDSoaxxn';
    $7A1E29: Result := 'DPSDnoax';
    $7B0C68: Result := 'SDPxnan';
    $7C1E24: Result := 'SPDSnoax';
    $7D0C69: Result := 'DPSxnan';
    $7E0955: Result := 'SPxDSxo';
    $7F03C9: Result := 'DPSaan';
    $8003E9: Result := 'DPSaa';
    $810975: Result := 'SPxDSxon';
    $820C49: Result := 'DPSxna';
    $831E04: Result := 'SPDSnoaxn';
    $840C48: Result := 'SDPxna';
    $851E05: Result := 'PDSPnoaxn';
    $8617A6: Result := 'DSPDSoaxx';
    $8701C5: Result := 'PDSaxn';
    $8800C6: Result := 'DSa';         // SRCAND
    $891B08: Result := 'SDPSnaoxn';
    $8A0E06: Result := 'DSPnoa';
    $8B0666: Result := 'DSPDxoxn';
    $8C0E08: Result := 'SDPnoa';
    $8D0668: Result := 'SDPSxoxn';
    $8E1D7C: Result := 'SSDxPDxax';
    $8F0CE5: Result := 'PDSanan';
    $900C45: Result := 'PDSxna';
    $911E08: Result := 'SDPSnoaxn';
    $9217A9: Result := 'DPSDPoaxx';
    $9301C4: Result := 'SPDaxn';
    $9417AA: Result := 'PSDPSoaxx';
    $9501C9: Result := 'DPSaxn';
    $960169: Result := 'DPSxx';
    $97588A: Result := 'PSDPSonoxx';
    $981888: Result := 'SDPSonoxn';
    $990066: Result := 'DSxn';
    $9A0709: Result := 'DPSnax';
    $9B07A8: Result := 'SDPSoaxn';
    $9C0704: Result := 'SPDnax';
    $9D07A6: Result := 'DSPDoaxn';
    $9E16E6: Result := 'DSPDSaoxx';
    $9F0345: Result := 'PDSxan';
    $A000C9: Result := 'DPa';
    $A11B05: Result := 'PDSPnaoxn';
    $A20E09: Result := 'DPSnoa';
    $A30669: Result := 'DPSDxoxn';
    $A41885: Result := 'PDSPonoxn';
    $A50065: Result := 'PDxn';
    $A60706: Result := 'DSPnax';
    $A707A5: Result := 'PDSPoaxn';
    $A803A9: Result := 'DPSoa';
    $A90189: Result := 'DPSoxn';
    $AA0029: Result := 'D';
    $AB0889: Result := 'DPSono';
    $AC0744: Result := 'SPDSxax';
    $AD06E9: Result := 'DPSDaoxn';
    $AE0B06: Result := 'DSPnao';
    $AF0229: Result := 'DPno';
    $B00E05: Result := 'PDSnoa';
    $B10665: Result := 'PDSPxoxn';
    $B21974: Result := 'SSPxDSxox';
    $B30CE8: Result := 'SDPanan';
    $B4070A: Result := 'PSDnax';
    $B507A9: Result := 'DPSDoaxn';
    $B616E9: Result := 'DPSDPaoxx';
    $B70348: Result := 'SDPxan';
    $B8074A: Result := 'PSDPxax';
    $B906E6: Result := 'DSPDaoxn';
    $BA0B09: Result := 'DPSnao';
    $BB0226: Result := 'DSno';        // MERGEPAINT
    $BC1CE4: Result := 'SPDSanax';
    $BD0D7D: Result := 'SDxPDxan';
    $BE0269: Result := 'DPSxo';
    $BF08C9: Result := 'DPSano';
    $C000CA: Result := 'PSa';         // MERGECOPY
    $C11B04: Result := 'SPDSnaoxn';
    $C21884: Result := 'SPDSonoxn';
    $C3006A: Result := 'PSxn';
    $C40E04: Result := 'SPDnoa';
    $C50664: Result := 'SPDSxoxn';
    $C60708: Result := 'SDPnax';
    $C707AA: Result := 'PSDPoaxn';
    $C803A8: Result := 'SDPoa';
    $C90184: Result := 'SPDoxn';
    $CA0749: Result := 'DPSDxax';
    $CB06E4: Result := 'SPDSaoxn';
    $CC0020: Result := 'S';           // SRCCOPY
    $CD0888: Result := 'SDPono';
    $CE0B08: Result := 'SDPnao';
    $CF0224: Result := 'SPno';
    $D00E0A: Result := 'PSDnoa';
    $D1066A: Result := 'PSDPxoxn';
    $D20705: Result := 'PDSnax';
    $D307A4: Result := 'SPDSoaxn';
    $D41D78: Result := 'SSPxPDxax';
    $D50CE9: Result := 'DPSanan';
    $D616EA: Result := 'PSDPSaoxx';
    $D70349: Result := 'DPSxan';
    $D80745: Result := 'PDSPxax';
    $D906E8: Result := 'SDPSaoxn';
    $DA1CE9: Result := 'DPSDanax';
    $DB0D75: Result := 'SPxDSxan';
    $DC0B04: Result := 'SPDnao';
    $DD0228: Result := 'SDno';
    $DE0268: Result := 'SDPxo';
    $DF08C8: Result := 'SDPano';
    $E003A5: Result := 'PDSoa';
    $E10185: Result := 'PDSoxn';
    $E20746: Result := 'DSPDxax';
    $E306EA: Result := 'PSDPaoxn';
    $E40748: Result := 'SDPSxax';
    $E506E5: Result := 'PDSPaoxn';
    $E61CE8: Result := 'SDPSanax';
    $E70D79: Result := 'SPxPDxan';
    $E81D74: Result := 'SSPxDSxax';
    $E95CE6: Result := 'DSPDSanaxxn';
    $EA02E9: Result := 'DPSao';
    $EB0849: Result := 'DPSxno';
    $EC02E8: Result := 'SDPao';
    $ED0848: Result := 'SDPxno';
    $EE0086: Result := 'DSo';         // SRCPAINT
    $EF0A08: Result := 'SDPnoo';
    $F00021: Result := 'P';           // PATCOPY
    $F10885: Result := 'PDSono';
    $F20B05: Result := 'PDSnao';
    $F3022A: Result := 'PSno';
    $F40B0A: Result := 'PSDnao';
    $F50225: Result := 'PDno';
    $F60265: Result := 'PDSxo';
    $F708C5: Result := 'PDSano';
    $F802E5: Result := 'PDSao';
    $F90845: Result := 'PDSxno';
    $FA0089: Result := 'DPo';
    $FB0A09: Result := 'DPSnoo';      // PATPAINT
    $FC008A: Result := 'PSo';
    $FD0A0A: Result := 'PSDnoo';
    $FE02A9: Result := 'DPSoo';
    $FF0062: Result := '1';           // WHITENESS
  end;
end;

initialization
  CriticalSection := TCriticalSection.Create;
  UniqueNumber := 0;

  PDFFontLigaturelessList := TStringList.Create;
  PDFFontLigaturelessList.CaseSensitive := False;
  PDFFontLigaturelessList.Duplicates := dupIgnore;
  PDFFontLigaturelessList.Sorted := True;
  AddLigatureless('Calibri');
  AddLigatureless('Calibri Light');
  AddLigatureless('CADiagram');
  AddLigatureless('Carlito');
  AddLigatureless('EmojiOne Color');
  AddLigatureless('Gabriola');
  AddLigatureless('OpenSymbol');
  AddLigatureless('Segoe Script');
  AddLigatureless('ZWAdobeF');
  AddLigatureless('IBM Plex Sans Condensed');
  AddLigatureless('Gotham Light');
finalization
  CriticalSection.Free;

  PDFFontLigaturelessList.Free;
end.
