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
{
ANGUS - LoadDocument, don't add physical disk file path to URL, it corrupts referrer
}

{$I frxHTMLCons.inc}

unit frxHTMLViewer;

interface

uses
{$ifdef LCL}
  LclIntf, LclType, LMessages, types, FPimage, frLazHTMLMisc, frLazGraphicClasses,
{$else}
  Windows,
{$endif}
  Messages, Classes, Graphics, Contnrs, SysUtils,
  frxHTMLURLSubs,
  frxHTMLGlobals,
  frxHTMLBuffer,
  frxHTMLImages,
  frxHTMLUn2,
  frxHTMLRead,
  frxHTMLSubs,
  frxHTMLStyleTypes,
  frxHTMLStyleUn,
  frxHTMLCaches
{$IFDEF FPC}
  , LazHelper
{$ENDIF}
;

type
  EhtException = class(Exception);
  EhtLoadError = class(EhtException);
  EExcessiveSizeError = class(EhtException);

  THtmlViewerOption = (
    htOverLinksActive, htNoLinkUnderline, htPrintTableBackground,
    htPrintBackground, htPrintMonochromeBlack, htShowDummyCaret,
    htShowVScroll, htNoWheelMouse, htNoLinkHilite,
    htNoFocusRect, //MK20091107
    htAllowHotSpotDblClick
    );
  THtmlViewerOptions = set of THtmlViewerOption;

  THtmlFileType = ThtDocType;

  THtmlViewerStateBit = (
    vsBGFixed,
    vsDontDraw,
    vsCreating,
    vsProcessing,
    vsLocalImageCache,
    vsHotSpotAction,
    vsMouseScrolling,
    vsLeftButtonDown,
    vsMiddleScrollOn,
    vsHiliting);
  THtmlViewerState = set of THtmlViewerStateBit;

  //TODO -oBG, 16.08.2015: split TfrxHtmlViewer into TfrxHtBase and TfrxHtmlViewer.
  //
  // TfrxHtBase (or a derivate of it) will be the control that TFVBase will create
  // to embed HtmlViewers.
  //
  // The properties of TfrxHtViewerBase will no longer be members to avoid the copy
  // orgies and to simplify implementing more features that are unique to the
  // entire TfrxHtmlViewer or TFrameViewer/TFrameBrowser component. Instead they
  // are gotten by virtual methods.
  //
  // The implementation of these properties will go back to TfrxHtmlViewer and
  // TFrameViewer/TFrameBrowser from where they came.
  //
  // TfrxHtmlViewer implements getters getting the properties from itself.
  // The TfrxHtBase derivate, that TFVBase uses, implements the getters getting the
  // properties from the TFrameViewer/TFrameBrowser component.

  TfrxHtmlViewer = class(TfrxHtmlViewerBase)
  private
    FPaintColor: TColor;
    FPaintBitmap: TBitmap;
    Font: TFont;

    // stuff copied in CreateCopy
    FBase: ThtString;
    FBaseEx: ThtString;
    FBaseTarget: ThtString;
    FOptions: THtmlViewerOptions;

    // events (also copied in CreateCopy)
    FOnLinkDrawn: TLinkDrawnEvent;

    // status info
    FViewerState: THtmlViewerState;

    // document related stuff
    FSectionList: TfrxHtDocument;
    FCurrentFile: ThtString;
    FCurrentFileType: ThtmlFileType;
    FDocument: TBuffer;
    FTitle: ThtString;
    // document related status stuff
    FLinkAttributes: ThtStringList;
    FLinkStart: TPoint;
    FLinkText: UnicodeString;
    FNameList: ThtStringList;
    FScrollWidth: Integer;

    // set in LoadStream and read in doImage to get the image into the document.
    FImageStream: TStream;

    FCSSCache: ThtCSSCache;
    FOnImageCacheChanged: TNotifyEvent;

    function GetDocumentSource: ThtString;
    function GetIDControl(const ID: ThtString): TfrxHtIDObject;
    function GetIDDisplay(const ID: ThtString): ThtDisplayStyle;
    function GetLinkList: TfrxHtLinkList;
    function GetNameList: ThtStringList;
    function GetOurPalette: HPalette;
    function GetViewImages: Boolean;
    procedure BackgroundChange(Sender: TObject);
    procedure DoLogic;
    procedure MatchMediaQuery(Sender: TObject; const MediaQuery: ThtMediaQuery; var MediaMatchesQuery: Boolean);
    procedure Parsed(const Title, Base, BaseTarget: ThtString);
    procedure ParseXHtml;
    procedure ParseHtml;
    procedure ParseText;
    procedure SetBase(Value: ThtString);
    procedure SetIDDisplay(const ID: ThtString; Value: ThtDisplayStyle);
    procedure SetOptions(Value: THtmlViewerOptions);
    procedure SetOurPalette(Value: HPalette);
    procedure SetProcessing(Value: Boolean);
    procedure SetViewerStateBit(Index: THtmlViewerStateBit; Value: Boolean);
    procedure SetViewImages(Value: Boolean);
    function GetDocumentCodePage: Integer;
    procedure SetText(const Value: ThtString);
    procedure LoadFromUrl(const Url: ThtString; DocType: THtmlFileType);
    procedure DoOnImageCacheChanged(Sender: TObject);
//    procedure LoadResource(HInstance: TfrHandle; const ResourceName: ThtString; DocType: THtmlFileType);
  protected
    function IsProcessing: Boolean;
    procedure DoBackground1(ACanvas: TCanvas; ATop, AWidth, AHeight, FullHeight: Integer);
    procedure DoGetImage(Sender: TObject; const SRC: ThtString; var Stream: TStream); virtual;
    procedure HandleMeta(Sender: TObject; const HttpEq, Name, Content: ThtString); virtual;
    procedure HTMLPaint(ACanvas: TCanvas; const ARect: TRect);
    procedure InitLoad; virtual;
    procedure LoadDocument(Document: TBuffer; const DocName: ThtString; DocType: THtmlFileType);
    procedure LoadFile(const FileName: ThtString; ft: ThtmlFileType); virtual;
    procedure LoadString(const Source, Reference: ThtString; ft: ThtmlFileType);
    procedure LoadStream(const URL: ThtString; AStream: TStream; ft: ThtmlFileType);
    procedure SetActiveColor(const Value: TColor); override;
//    procedure SetCharset(const Value: TFontCharset); override;
    procedure SetDefBackground(const Value: TColor); override;
    procedure SetHotSpotColor(const Value: TColor); override;
    procedure SetPreFontName(const Value: TFontName); override;
    procedure SetVisitedColor(const Value: TColor); override;
    property ScrollWidth: Integer read FScrollWidth;
  public
    constructor Create; override;
    constructor CreateCopy(Source: TfrxHtViewerBase); override;
    destructor Destroy; override;
    function Find(const S: UnicodeString; MatchCase: Boolean): Boolean;
    function FindDisplayPos(SourcePos: Integer; Prev: Boolean): Integer;
    function FindEx(const S: UnicodeString; MatchCase, Reverse: Boolean): Boolean;
    function FindSourcePos(DisplayPos: Integer): Integer;
    function FullDisplaySize(FormatWidth: Integer): TSize;
    function PartDisplaySize(FormatWidth, FormatHeight: Integer): TSize;
    function GetCharAtPos(Pos: Integer; var Ch: WideChar; var Font: TFont): Boolean;
    function HtmlExpandFilename(const Filename: ThtString; const CurrentFilename: ThtString = ''): ThtString; override;
    function MakeBitmap(YTop, FormatWidth, Width, Height: Integer): TBitmap;
    function MakeMetaFile(YTop, FormatWidth, Width, Height: Integer): TMetaFile;
    function PositionTo(Dest: ThtString): Boolean;
    procedure Clear; virtual;
    procedure Draw(Canvas: TCanvas; YTop, FormatWidth, Width, Height: Integer);

    procedure htStreamRequest(var Url: ThtString; var Stream: TStream; out PathOfUrl: ThtString);
    procedure htStreamRequested(const Url: ThtString; Stream: TStream);

    procedure Load(const Url: ThtString); override;
    //
    procedure LoadFromDocument(Document: TBuffer; const Reference: ThtString; DocType: THtmlFileType = HtmlType);
    procedure LoadFromFile(const FileName: ThtString; DocType: THtmlFileType = HtmlType);
    procedure LoadFromStream(const AStream: TStream; const Reference: ThtString = ''; DocType: THtmlFileType = HtmlType);
    procedure LoadFromString(const S: ThtString; const Reference: ThtString = ''; DocType: THtmlFileType = HtmlType);
//    procedure LoadFromResource(HInstance: TfrHandle; const ResourceName: ThtString; DocType: THtmlFileType = HtmlType);
    //
    procedure InitCache;
    procedure Reload;
    procedure SetImageCache(ImageCache: TfrxHtImageCache);
    procedure ToggleIDExpand(const URL: ThtString; var Handled: Boolean);
    property Base: ThtString read FBase write SetBase;
    property BaseTarget: ThtString read FBaseTarget;
    property CurrentFile: ThtString read FCurrentFile write FCurrentFile;
    property DocumentCodePage: Integer read GetDocumentCodePage;
    property DocumentTitle: ThtString read FTitle write FTitle;
    property IDControl[const ID: ThtString]: TfrxHtIDObject read GetIDControl;
    property IDDisplay[const ID: ThtString]: ThtDisplayStyle read GetIDDisplay write SetIDDisplay;
    property LinkAttributes: ThtStringList read FLinkAttributes;
    property LinkList: TfrxHtLinkList read GetLinkList;
    property LinkStart: TPoint read FLinkStart;
    property LinkText: UnicodeString read FLinkText write FLinkText;
    property NameList: ThtStringList read GetNameList;
    property OnLinkDrawn: TLinkDrawnEvent read FOnLinkDrawn write FOnLinkDrawn;
    property Palette: HPalette read GetOurPalette write SetOurPalette;
    property SectionList: TfrxHtDocument read FSectionList;
    property ViewerState: THtmlViewerState read FViewerState;
    property CharSet default DEFAULT_CHARSET;
    property HtOptions: THtmlViewerOptions read FOptions write SetOptions default [htPrintTableBackground, htPrintMonochromeBlack];
    property Text: ThtString read GetDocumentSource write SetText;
    property ViewImages: Boolean read GetViewImages write SetViewImages default True;
    property CSSCache: ThtCSSCache read FCSSCache;
    property OnImageCacheChanged: TNotifyEvent read FOnImageCacheChanged write FOnImageCacheChanged;
  end;

function GetFileType(const S: ThtString): THtmlFileType;

var
  FileTypes: ThtStringList;

function GetFileMask : ThtString;

implementation

uses
{$ifdef Compiler24_Plus}
  System.Types,
  System.UITypes,
  Vcl.Themes,
  Vcl.Controls,
{$endif}
  Math, Clipbrd, Forms,
  frGif2;

type
  ThtPositionObj = class(TObject)
  public
    Pos: Integer;
    FileType: ThtmlFileType;
  end;

  TFileTypeRec = record
    FileExt: ThtString;
    FileType: THtmlFileType;
  end;
  PFileTypeRec = ^TFileTypeRec;

const
  MaxBitmapVerticalHeight = High(SmallInt);

//-- BG ---------------------------------------------------------- 12.05.2013 --
procedure InitFileTypes;
const
  FileTypeDefinitions: array [1..23] of TFileTypeRec = (
    (FileExt: '.htm';   FileType: HTMLType),
    (FileExt: '.html';  FileType: HTMLType),

    (FileExt: '.css';   FileType: HTMLType),
    (FileExt: '.php';   FileType: HTMLType),
    (FileExt: '.asp';   FileType: HTMLType),
    (FileExt: '.shtml'; FileType: HTMLType),

    (FileExt: '.xhtml'; FileType: XHtmlType),
    (FileExt: '.xht';   FileType: XHtmlType),

    (FileExt: '.gif';   FileType: ImgType),
    (FileExt: '.jpg';   FileType: ImgType),
    (FileExt: '.jpeg';  FileType: ImgType),
    (FileExt: '.jpe';   FileType: ImgType),
    (FileExt: '.jfif';  FileType: ImgType),

    (FileExt: '.png';   FileType: ImgType),
    (FileExt: '.bmp';   FileType: ImgType),
    (FileExt: '.rle';   FileType: ImgType),
    (FileExt: '.dib';   FileType: ImgType),
    (FileExt: '.ico';   FileType: ImgType),

    (FileExt: '.emf';   FileType: ImgType),
    (FileExt: '.wmf';   FileType: ImgType),
    (FileExt: '.tiff';  FileType: ImgType),
    (FileExt: '.tif';   FileType: ImgType),

    (FileExt: '.txt';   FileType: TextType)
  );
var
  I: Integer;
  P: PFileTypeRec;
begin
  // Put the Attributes into a sorted StringList for faster access.
  if FileTypes = nil then
  begin
    FileTypes := ThtStringList.Create;
    FileTypes.CaseSensitive := True;
    for I := low(FileTypeDefinitions) to high(FileTypeDefinitions) do
    begin
      P := @FileTypeDefinitions[I];
      FileTypes.AddObject(P.FileExt, Pointer(P));
    end;
    FileTypes.Sort;
  end;
end;

//-- JPM --------------------------------------------------------- 26.05.2013 --
function GetFileMask : ThtString;
var i : Integer;
begin
  //HTML
  Result := 'HTML Files|';
  for i := 0 to FileTypes.Count -1 do
  begin
    if (PFileTypeRec(FileTypes.Objects[i]).FileType = HTMLType) or
     (PFileTypeRec(FileTypes.Objects[i]).FileType = XHTMLType) then
    begin
      Result := Result + '*' + FileTypes[i] + ';';
    end;

  end;
  Delete(Result,Length(Result),1);
  //Image
  Result := Result + '|Image Files|';
  for I := 0 to FileTypes.Count -1 do
  begin
    if (PFileTypeRec(FileTypes.Objects[i]).FileType = ImgType) then
    begin
      Result := Result + '*' + FileTypes[i] + ';';
    end;

  end;
  Delete(Result,Length(Result),1);
  //Text File
  Result := Result + '|Text Files|';
  for I := 0 to FileTypes.Count -1 do
  begin
    if (PFileTypeRec(FileTypes.Objects[i]).FileType = TextType) then
    begin
      Result := Result + '*' + FileTypes[i] + ';';
    end;
  end;
  Delete(Result,Length(Result),1);
  //All Files
  Result := Result + '|Any Files|*.*';
end;

//-- BG ---------------------------------------------------------- 23.09.2010 --
function GetFileType(const S: ThtString): THtmlFileType;
var
  Ext: ThtString;
  I: Integer;
begin
  Ext := LowerCase(ExtractFileExt(S));
  I := -1;
  if FileTypes.Find(Ext, I) then
    Result := PFileTypeRec(FileTypes.Objects[i]).FileType
  else
    Result := OtherType;
end;

constructor TfrxHtmlViewer.Create;
begin
  inherited Create;
  Include(FViewerState, vsCreating);
  FHeight := 150;
  FWidth := 150;

  FPaintBitmap := TBitmap.Create;
  FPaintBitmap.HandleType := bmDIB;
  FPaintBitmap.PixelFormat := pf24Bit;
  FPaintBitmap.Width := FWidth;
  FPaintBitmap.Height := FHeight;

  FSectionList := TfrxHtDocument.Create(Self);
  FSectionList.OnBackgroundChange := BackgroundChange;
  FSectionList.ShowImages := True;
  FSectionList.GetImage := DoGetImage;
  FNameList := FSectionList.IDNameList;

  SetOptions([htPrintTableBackground, htPrintMonochromeBlack]);

  FLinkAttributes := ThtStringList.Create;

  FCSSCache := ThtCSSCache.Create;

  Exclude(FViewerState, vsCreating);
end;

//-- BG ---------------------------------------------------------- 23.11.2011 --
constructor TfrxHtmlViewer.CreateCopy(Source: TfrxHtViewerBase);
var
  Viewer: TfrxHtmlViewer absolute Source;
begin
  inherited CreateCopy(Viewer);

  if Source is TfrxHtmlViewer then
  begin
    FBase := Viewer.FBase;
    FBaseEx := Viewer.FBaseEx;
    FBaseTarget := Viewer.FBaseTarget;
    HtOptions := Viewer.HtOptions;

    OnLinkDrawn := Viewer.OnLinkDrawn;
  end;
end;

destructor TfrxHtmlViewer.Destroy;
begin
  Exclude(FViewerState, vsMiddleScrollOn);
  if vsLocalImageCache in FViewerState then
  begin
    FSectionList.Clear;
    FSectionList.ImageCache.Free;
  end;
  FSectionList.Free;
  FLinkAttributes.Free;
  FDocument.Free;
  FPaintBitmap.Free;
  FCSSCache.Free;
  inherited Destroy;
end;

procedure TfrxHtmlViewer.Parsed(const Title, Base, BaseTarget: ThtString);
begin
  FTitle := Title;
  if Base <> '' then
    FBase := Base
  else
    FBase := FBaseEx;
  FBaseTarget := BaseTarget;
  try
    Include(FViewerState, vsDontDraw);
    {Load the background bitmap if any and if ViewImages set}
    FSectionList.GetBackgroundImage;
    DoLogic;
  finally
    Exclude(FViewerState, vsDontDraw);
  end;
end;

//-- JPM --------------------------------------------------------- 25.05.2013 --
procedure TfrxHtmlViewer.ParseXHtml;
var
  Parser: TfrxHtmlParser;
begin
  Parser := TfrxHtmlParser.Create(FDocument);
  try
    Parser.IsXHTML := True;
    Parser.ParseHtml(FSectionList, nil, nil, HandleMeta, nil, MatchMediaQuery);
    Parsed(Parser.Title, Parser.Base, Parser.BaseTarget);
  finally
    Parser.Free;
  end;
end;

function TfrxHtmlViewer.PartDisplaySize(FormatWidth, FormatHeight: Integer): TSize;
var
  Curs: Integer;
  CopyList: TfrxHtDocument;
begin
  Result.cx := 0; {error return}
  Result.cy := 0;
  if FormatWidth > 0 then
  begin
    CopyList := TfrxHtDocument.CreateCopy(FSectionList);
    try
      Curs := 0;
      Result.cy := CopyList.DoLogic(FPaintBitmap.Canvas, 0, FormatWidth, FormatHeight, 0, Result.cx, Curs, FormatHeight) - MarginHeight;
    finally
      CopyList.Free;
    end;
  end;
end;

//-- BG ---------------------------------------------------------- 13.03.2011 --
procedure TfrxHtmlViewer.ParseHtml;
var
  Parser: TfrxHtmlParser;
begin
  Parser := TfrxHtmlParser.Create(FDocument);
  try
    Parser.ParseHtml(FSectionList, nil, nil, HandleMeta, nil, MatchMediaQuery);
    Parsed(Parser.Title, Parser.Base, Parser.BaseTarget);
  finally
    Parser.Free;
  end;
end;

//-- BG ---------------------------------------------------------- 13.03.2011 --
procedure TfrxHtmlViewer.ParseText;
var
  Parser: TfrxHtmlParser;
begin
  Parser := TfrxHtmlParser.Create(FDocument);
  try
    Parser.ParseText(FSectionList);
    Parsed(Parser.Title, Parser.Base, Parser.BaseTarget);
  finally
    Parser.Free;
  end;
end;

procedure TfrxHtmlViewer.LoadFile(const FileName: ThtString; ft: ThtmlFileType);
var
  Dest, Name: ThtString;
  Stream: TStream;
{$ifdef FPC}
  ShortName: ThtString;
{$endif}

begin
  IOResult; {eat up any pending errors}
  SplitDest(FileName, Name, Dest);
  if Name <> '' then
    Name := ExpandFileName(Name);
  //FCurrentFile := Name; //BG, 03.04.2011: issue 83: Failure to set FCurrentFile
  if not FileExists(Name) then
  begin
{$ifdef FPC}
    //BG, 24.04.2014: workaround for non ansi file names:
    ShortName := ExtractShortPathName(UTF8Decode(Name));
    if FileExists(ShortName) then
      Name := ShortName
    else
{$endif}
      raise EhtLoadError.CreateFmt('Can''t locate file ''%s''.', [Name])
      ;
  end;

  Stream := TFileStream.Create( htStringToString(Name), fmOpenRead or fmShareDenyWrite);
  try
    LoadStream(Name + Dest, Stream, ft);
  finally
    Stream.Free;
  end;
end;

procedure TfrxHtmlViewer.LoadFromFile(const FileName: ThtString; DocType: ThtmlFileType);
begin
  if IsProcessing then
    Exit;
  if Filename <> '' then
    try
      LoadFile(FileName, DocType);
    except
      raise;
    end;
end;

//-- BG ---------------------------------------------------------- 27.12.2010 --
procedure TfrxHtmlViewer.LoadFromDocument(Document: TBuffer; const Reference: ThtString; DocType: THtmlFileType);
begin
  LoadDocument(Document, Reference, DocType);
end;

{----------------TfrxHtmlViewer.LoadFromString}
procedure TfrxHtmlViewer.LoadFromString(const S: ThtString; const Reference: ThtString; DocType: THtmlFileType);
begin
  LoadString(S, Reference, DocType);
end;

{----------------TfrxHtmlViewer.LoadString}

//-- BG ---------------------------------------------------------- 24.11.2011 --
procedure TfrxHtmlViewer.Load(const Url: ThtString);
begin
  inherited;
  LoadFromUrl(Url, HTMLType);
end;

//-- BG ---------------------------------------------------------- 11.03.2019 --
procedure TfrxHtmlViewer.LoadFromUrl(const Url: ThtString; DocType: THtmlFileType);
var
  Scheme, Specific{, ResType}: ThtString;
begin
  SplitScheme(Url, Scheme, Specific);
//  if Scheme = 'res' then
//  begin
//    Specific := HTMLToRes(Url, ResType);
//    LoadFromResource(HInstance, Specific, DocType);
//  end
//  else
    LoadFromFile(Url, DocType);
end;

//-- BG ---------------------------------------------------------- 01.01.2012 --
procedure TfrxHtmlViewer.LoadDocument(Document: TBuffer; const DocName: ThtString; DocType: THtmlFileType);
var
  Dest, Name: ThtString;
begin
  if IsProcessing then
    Exit;
  SplitDest(DocName, Name, Dest);
  case DocType of
    ImgType:
      raise EhtException.Create('LoadDocument with DocType = ''ImgType'' not supported.');
  else
    if Document = nil then
      raise EhtException.Create('LoadDocument requires document to load. Parameter ''Document'' must not be nil.');
  end;

  SetProcessing(True);
  try
    Include(FViewerState, vsDontDraw);
    try
      try
        // terminate old document
        InitLoad;

        // one should not offer same document twice, but ...
        if FDocument <> Document then
          FreeAndNil(FDocument);

        // load new document
        FDocument := Document;
//        FCurrentFile := ExpandFileName(Name);
        FCurrentFile := Name; // ANGUS don't add physical disk file path to URL, it corrupts referrer
        FCurrentFileType := DocType;

        case DocType of
          HTMLType:
            ParseHtml;
          XHtmlType:
            ParseXHtml;
        else
          ParseText;
        end;
      finally
        if Assigned(SectionList.ImageCache) then
          SectionList.ImageCache.ClearUnused;
      end;
    finally
      Exclude(FViewerState, vsDontDraw);
    end;
  finally
    SetProcessing(False);
  end;
end;

{----------------TfrxHtmlViewer.LoadString}

procedure TfrxHtmlViewer.LoadString(const Source, Reference: ThtString; ft: ThtmlFileType);
begin
  if IsProcessing then
    Exit;
  LoadDocument(TBuffer.Create(Source, Reference), Reference, ft);
end;

{----------------TfrxHtmlViewer.LoadFromStream}

procedure TfrxHtmlViewer.LoadFromStream(const AStream: TStream; const Reference: ThtString; DocType: ThtmlFileType);
begin
  LoadStream(Reference, AStream, DocType);
end;

//-- BG ---------------------------------------------------------- 10.03.2019 --
//procedure TfrxHtmlViewer.LoadResource(HInstance: TfrHandle; const ResourceName: ThtString; DocType: THtmlFileType);
//var
//  Stream: TResourceStream;
//  Scheme, Name: ThtString;
//begin
//  SplitScheme(ResourceName, Scheme, Name);
//  if Scheme = '' then
//    Scheme := 'res:///';
//
//  Stream := ThtResourceConnection.CreateResourceStream(HInstance, Name, DocType);
//  if Stream <> nil then
//  begin
//    try
//      LoadStream(Scheme + Name, Stream, DocType);
//    finally
//      Stream.Free;
//    end;
//  end
//  else
//    raise EhtLoadError.CreateFmt('Can''t locate resource ''%s''.', [ResourceName]);
//end;

//-- BG ---------------------------------------------------------- 10.03.2019 --
//procedure TfrxHtmlViewer.LoadFromResource(HInstance: TfrHandle; const ResourceName: ThtString; DocType: THtmlFileType);
//begin
//  if IsProcessing then
//    Exit;
//  if ResourceName <> '' then
//  begin
//    try
//      LoadResource(HInstance, ResourceName, DocType);
//    except
//      raise;
//    end;
//  end;
//end;

//-- BG ---------------------------------------------------------- 23.03.2012 --
procedure TfrxHtmlViewer.DoGetImage(Sender: TObject; const SRC: ThtString; var Stream: TStream);
begin
  if FImageStream <> nil then
  	Stream := FImageStream
end;

{----------------TfrxHtmlViewer.LoadStream}

procedure TfrxHtmlViewer.LoadStream(const URL: ThtString; AStream: TStream; ft: ThtmlFileType);
begin
  if IsProcessing or not Assigned(AStream) then
    Exit;
  AStream.Position := 0;
  if ft in [HTMLType, XHtmlType, TextType] then
    LoadDocument(TBuffer.Create(AStream, URL), URL, ft)
  else
    try
      FImageStream := AStream;
      LoadDocument(TBuffer.Create('<img src="' + URL + '">'), URL, HTMLType)
    finally
      FImageStream := nil;
    end;
end;


{----------------TfrxHtmlViewer.DoLogic}

procedure TfrxHtmlViewer.DoLogic;

  procedure SectionListDoLogic(Width, Height: Integer);
  var
    Curs: Integer;
  begin
    Curs := 0;
    FScrollWidth := 0;
    FSectionList.DoLogic(FPaintBitmap.Canvas, 0, Width, Height, 0, FScrollWidth, Curs);
  end;

var
  WasDontDraw: Boolean;
begin
  WasDontDraw := vsDontDraw in FViewerState;
  Include(FViewerState, vsDontDraw);
  try
    {there is no vertical scrollbar}
    SectionListDoLogic(FWidth, FHeight);

  finally
    if not WasDontDraw then
      Exclude(FViewerState, vsDontDraw);
  end;
end;

//-- BG ---------------------------------------------------------- 09.08.2011 --
function TfrxHtmlViewer.IsProcessing: Boolean;
begin
  Result := vsProcessing in FViewerState;
//  if Result then
//    assert(False, 'Viewer processing. Data may get lost!');
end;

{----------------TfrxHtmlViewer.GetCharAtPos}

function TfrxHtmlViewer.GetCharAtPos(Pos: Integer; var Ch: WideChar; var Font: TFont): Boolean;
var
  Obj: TfrxHtSectionBase;
  FO: TfrxHtFontObj;
begin
  Result := FSectionList.GetChAtPos(Pos, Ch, Obj);
  if Result and (Obj is TfrxHtSection) then
    with TfrxHtSection(Obj) do
    begin
      FO := Fonts.GetFontObjAt(Pos - StartCurs);
      if FO = nil then Font := nil
      else Font := FO.TheFont; 
    end;
end;

function TfrxHtmlViewer.PositionTo(Dest: ThtString): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Dest = '' then
    Exit;
  if Dest[1] = '#' then
    System.Delete(Dest, 1, 1);
  I := FNameList.IndexOf(UpperCase(Dest));
  if I > -1 then
  begin
    Result := True;
  end;
end;

//-- BG ---------------------------------------------------------- 23.11.2010 --
procedure TfrxHtmlViewer.SetViewerStateBit(Index: THtmlViewerStateBit; Value: Boolean);
begin
  if Value then
    Include(FViewerState, Index)
  else
    Exclude(FViewerState, Index);
end;

procedure TfrxHtmlViewer.SetViewImages(Value: Boolean);
begin
  if IsProcessing then
    Exit;
  if Value <> FSectionList.ShowImages then
  begin
    try
      SetProcessing(True);
      FSectionList.ShowImages := Value;
      if FSectionList.Count > 0 then
      begin
        FSectionList.GetBackgroundImage; {load any background bitmap}
        DoLogic;
      end;
    finally
      SetProcessing(False);
    end;
  end;
end;

procedure TfrxHtmlViewer.SetBase(Value: ThtString);
begin
  FBase := Value;
  FBaseEx := Value;
end;

function TfrxHtmlViewer.GetViewImages: Boolean;
begin
  Result := FSectionList.ShowImages;
end;

procedure TfrxHtmlViewer.SetDefBackground(const Value: TColor);
begin
  if IsProcessing then
    Exit;
  inherited;
  if FSectionList <> nil then
    FSectionList.Background := Value;
  FPaintColor := Value;
end;

//-- BG ---------------------------------------------------------- 19.07.2017 --
procedure TfrxHtmlViewer.SetText(const Value: ThtString);
begin
  LoadFromString(Value);
end;

function TfrxHtmlViewer.HTMLExpandFilename(const Filename, CurrentFilename: ThtString): ThtString;
var
  FileScheme: ThtString;
  FileSpecific: ThtString;
  CurrFile: ThtString;
  CurrScheme: ThtString;
  CurrSpecific: ThtString;
begin
  {pass http: and other protocols except for file:///}
  if Length(CurrentFilename) > 0 then
    CurrFile := CurrentFilename
  else
    CurrFile := FCurrentFile;

  SplitScheme(Filename, FileScheme, FileSpecific);
  SplitScheme(CurrFile, CurrScheme, CurrSpecific);

  if (Length(CurrScheme) > 0) and (htCompareStr(CurrScheme, 'file') <> 0) then
  begin
    Result := FileName;
    if Pos('\', Result) > 0 then
      Result := DosToHTML(Result);

    if not IsFullUrl(Result) then
    begin
      if Pos('//', Result) = 1 then
        Result := CurrScheme + ':' + Result
      else
        Result := CombineURL(GetURLBase(CurrFile), Result);
    end;
  end
  else if (Length(FileScheme) > 0) and (htCompareStr(FileScheme, 'file') <> 0) then
    Result := Filename
  else
  begin
    Result := HTMLServerToDos(Filename, ServerRoot);
    if (Length(Result) > 0) and (Result[1] = '\') then
      Result := ExpandFilename(Result)
    else if IsAbsolutePath(Result) then
    else if htCompareText(FBase, 'DosPath') = 0 then {let Dos find the path}
    else if Length(FBase) > 0 then
      Result := CombineDos(HTMLToDos(FBase), Result)
    else if Length(CurrentFilename) > 0 then
      Result := ExpandFilename(ExtractFilePath(HTMLToDos(CurrentFilename)) + Result)
    else
      Result := ExpandFilename(ExtractFilePath(HTMLToDos(FCurrentFile)) + Result);
  end;
end;

procedure TfrxHtmlViewer.SetPreFontName(const Value: TFontName);
begin
  if CompareText(Value, DefPreFontName) <> 0 then
  begin
    inherited;
    if FSectionList <> nil then
      FSectionList.PreFontName := DefPreFontname;
  end;
end;

function TfrxHtmlViewer.GetNameList: ThtStringList;
begin
  Result := FNameList;
end;

function TfrxHtmlViewer.GetLinkList: TfrxHtLinkList;
begin
  Result := FSectionList.LinkList;
end;

procedure TfrxHtmlViewer.SetHotSpotColor(const Value: TColor);
begin
  inherited;
  if FSectionList <> nil then
    FSectionList.HotSpotColor := Value;
end;

procedure TfrxHtmlViewer.SetVisitedColor(const Value: TColor);
begin
  inherited;
  if FSectionList <> nil then
    FSectionList.LinkVisitedColor := Value;
end;

procedure TfrxHtmlViewer.SetActiveColor(const Value: TColor);
begin
  inherited;
  if FSectionList <> nil then
    FSectionList.LinkActiveColor := Value;
end;

//-- BG ---------------------------------------------------------- 26.04.2014 --
function TfrxHtmlViewer.GetDocumentCodePage: Integer;
begin
  if FDocument <> nil then
    Result := FDocument.CodePage
  else
    Result := CodePage;
end;

//-- BG ---------------------------------------------------------- 27.12.2010 --
function TfrxHtmlViewer.GetDocumentSource: ThtString;
var
  Pos: Integer;
begin
  if FDocument <> nil then
  begin
    Pos := FDocument.Position;
    FDocument.Position := FDocument.BomLength;
    Result := FDocument.AsString;
    FDocument.Position := Pos;
  end
  else
    Result := '';
end;

function TfrxHtmlViewer.FullDisplaySize(FormatWidth: Integer): TSize;
var
  Curs: Integer;
  CopyList: TfrxHtDocument;
begin
  Result.cx := 0; {error return}
  Result.cy := 0;
  if FormatWidth > 0 then
  begin
    CopyList := TfrxHtDocument.CreateCopy(FSectionList);
    try
      Curs := 0;
      Result.cy := CopyList.DoLogic(FPaintBitmap.Canvas, 0, FormatWidth, 300, 0, Result.cx, Curs);
    finally
      CopyList.Free;
    end;
  end;
end;

procedure TfrxHtmlViewer.DoBackground1(ACanvas: TCanvas; ATop, AWidth, AHeight, FullHeight: Integer);
var
  ARect: TRect;
  Image: TfrxHtImage;
  PRec: PtPositionRec;
  BW, BH, X, Y, X2, Y2, IW, IH, XOff, YOff: Integer;
  Fixed: Boolean;

begin
  ARect := Rect(0, 0, AWidth, AHeight);
  Image := FSectionList.BackgroundImage;
  if FSectionList.ShowImages and Assigned(Image) then
  begin
    BW := Image.Width;
    BH := Image.Height;
    PRec := FSectionList.BackgroundImagePosition;
    Fixed := PRec.X.Fixed;
    if Fixed then
    begin {fixed background}
      XOff := 0;
      YOff := 0;
      IW := AWidth;
      IH := AHeight;
    end
    else
    begin {scrolling background}
      XOff := 0;
      YOff := ATop;
      IW := AWidth;
      IH := FullHeight;
    end;

  {Calculate where the tiled background images go}
    CalcBackgroundLocationAndTiling(PRec, ARect, XOff, YOff, IW, IH, BW, BH, X, Y, X2, Y2);

    DrawBackground(ACanvas, ARect, X, Y, X2, Y2, Image, BW, BH, FPaintColor);
  end
  else
  begin {no background image, show color only}
    DrawBackground(ACanvas, ARect, 0, 0, 0, 0, nil, 0, 0, FPaintColor);
  end;
end;

//-- BG ---------------------------------------------------------- 20.11.2010 --
// extracted from MakeBitmap() and MakeMetaFile()
procedure TfrxHtmlViewer.Draw(Canvas: TCanvas; YTop, FormatWidth, Width, Height: Integer);
var
  CopyList: TfrxHtDocument;
  Dummy: Integer;
  Curs: Integer;
  DocHeight: Integer;
begin
  CopyList := TfrxHtDocument.CreateCopy(FSectionList);
  try
    Curs := 0;
    DocHeight := CopyList.DoLogic(Canvas, 0, FormatWidth, Height, 300, Dummy, Curs);
    DoBackground1(Canvas, YTop, Width, Height, DocHeight);

    CopyList.SetYOffset(Max(0, YTop));
    CopyList.Draw(Canvas, Rect(0, 0, Width, Height), MaxHScroll, 0, 0, 0, 0);
  finally
    CopyList.Free;
  end;
end;

procedure TfrxHtmlViewer.HTMLPaint(ACanvas: TCanvas; const ARect: TRect);
var
  Image: TfrxHtImage;
  NewBitmap, NewMask: TBitmap;
  PRec: PtPositionRec;
  BW, BH, X, Y, X2, Y2, IW, IH, XOff, YOff: Integer;
  NewImage: TfrxHtImage;
begin
  Image := FSectionList.BackgroundImage;
  if FSectionList.ShowImages and Assigned(Image) then
  begin
    BW := Image.Width;
    BH := Image.Height;
    PRec := FSectionList.BackgroundImagePosition;
    SetViewerStateBit(vsBGFixed, PRec.X.Fixed);
    XOff := 0;
    YOff := 0;
    IW := FWidth;
    IH := FHeight;

  {Calculate where the tiled background images go}
    CalcBackgroundLocationAndTiling(PRec, ARect, XOff, YOff, IW, IH, BW, BH, X, Y, X2, Y2);

    if (BW = 1) or (BH = 1) then
    begin {this is for people who try to tile 1 pixel images}
      NewMask := nil;
      NewBitmap := EnlargeImage(Image.Bitmap, X2 - X, Y2 - Y); // as TBitmap;
      try
        if Assigned(Image.Mask) then
          NewMask := EnlargeImage(Image.Mask, X2 - X, Y2 - Y);

        NewImage := TfrxHtBitmapImage.Create(NewBitmap, NewMask, itrLLCorner);
        NewMask := nil;
        NewBitmap := nil;
        try
          DrawBackground(ACanvas, ARect, X, Y, X2, Y2, NewImage, NewImage.Width, NewImage.Height, ACanvas.Brush.Color);
        finally
          NewImage.Free;
        end;
      finally
        NewMask.Free;
        NewBitmap.Free;
      end;
    end
    else {normal situation}
      DrawBackground(ACanvas, ARect, X, Y, X2, Y2, Image, BW, BH, ACanvas.Brush.Color);
  end
  else
  begin {no background image, show color only}
    Exclude(FViewerState, vsBGFixed);
    DrawBackground(ACanvas, ARect, 0, 0, 0, 0, nil, 0, 0, ACanvas.Brush.Color);
  end;

  FSectionList.Draw(ACanvas, ARect, MaxHScroll, 0, 0, 0, 0);
end;

function TfrxHtmlViewer.MakeBitmap(YTop, FormatWidth, Width, Height: Integer): TBitmap;
begin
  Result := nil;
  if IsProcessing then
    Exit;
  if Height > MaxBitmapVerticalHeight then
    raise EExcessiveSizeError.Create('Vertical Height exceeds ' + IntToStr(MaxBitmapVerticalHeight));
  Result := TBitmap.Create;
  try
    Result.HandleType := bmDIB;
    Result.PixelFormat := pf24Bit;
    Result.Width := Width;
    Result.Height := Height;
    Draw(Result.Canvas, YTop, FormatWidth, Width, Height);
  except
    Result.Free;
    raise;
    //Result := nil;
  end;
end;

function TfrxHtmlViewer.MakeMetaFile(YTop, FormatWidth, Width, Height: Integer): TMetaFile;
var
  Canvas: TMetaFileCanvas;
begin
  Result := nil;
  if IsProcessing or (FSectionList.Count = 0) then
    Exit;
  if Height > MaxBitmapVerticalHeight then
    raise EExcessiveSizeError.Create('Vertical Height exceeds ' + IntToStr(MaxBitmapVerticalHeight));
  Result := TMetaFile.Create;
  Result.Width := Width;
  Result.Height := Height;
  Canvas := TMetaFileCanvas.Create(Result, 0);
  try
    try
      Draw(Canvas, YTop, FormatWidth, Width, Height);
    except
      Result.Free;
      raise;
      //Result := nil;
    end;
  finally
    Canvas.Free;
  end;
end;

//-- BG ---------------------------------------------------------- 24.10.2016 --
procedure TfrxHtmlViewer.MatchMediaQuery(Sender: TObject; const MediaQuery: ThtMediaQuery; var MediaMatchesQuery: Boolean);
// Match MediaQuery against Self, resp. Screen.

  function EvaluateExpression(const Expression: ThtMediaExpression): Boolean;
  var
    LowStr: ThtString;

    function Compared(A, B: Integer): Boolean;
    begin
      case Expression.Oper of
        moLe: Result := A <= B;
        moEq: Result := A  = B;
        moGe: Result := A >= B;
      else
        Result := False;
      end;
    end;

    function ComparedToNumber(Value: Integer; MaxValue: Integer = MaxInt): Boolean;
    var
      Num: Integer;
    begin
      if Expression.Oper = moIs then
        Result := Value > 0
      else
        Result := TryStrToInt(Expression.Expression, Num) and (Num >= 0) and (Num <= MaxValue) and Compared(Value, Num);
    end;

    function ComparedToLength(Value, Base: Integer): Boolean;
    var
      Len: Integer;
    begin
      if Expression.Oper = moIs then
        Result := Value > 0
      else
      begin
        if Font <> nil then
          Len := Abs(Font.Size)
        else
          Len := Round(Abs(DefFontSize));
        Len := LengthConv(Expression.Expression, False, Base, Len, Len div 2, -1);
        Result := (Len >= 0) and Compared(Value, Len);
      end;
    end;

  begin
    case Expression.Feature of
      mfWidth       : Result := ComparedToLength(Self.FWidth  , Self.FWidth   );
      mfHeight      : Result := ComparedToLength(Self.FHeight , Self.FHeight  );
      mfDeviceWidth : Result := ComparedToLength(Screen.Width , Screen.Width );
      mfDeviceHeight: Result := ComparedToLength(Screen.Height, Screen.Height);

      mfOrientation :
      begin
        LowStr := htLowerCase(Expression.Expression);
        if LowStr = 'landscape' then
          Result := Self.FWidth > Self.FHeight
        else if LowStr = 'portrait' then
          Result := Self.FWidth <= Self.FHeight
        else
          Result := False;
      end;

      //TODO -oBG, 24.10.2016: get actual color values from Screen or PaintPanel.Canvas?

      mfMonochrome  , // bits per (gray) pixel
      mfColor       : // minimum bits per red, green, and blue of a pixel
        Result := ComparedToNumber(8 {bits per color});

      mfColorIndex  :
        Result := ComparedToNumber(0 {number of palette entries});

      mfGrid        :
        Result := ComparedToNumber(0 {0 = bitmap, 1 = character grid like tty}, 1);
    else
      Result := False;
    end;
  end;

var
  I: Integer;
  OK: Boolean;
begin
  OK := False;
  if (MediaQuery.MediaType in [mtAll, mtScreen]) xor MediaQuery.Negated then
  begin
    for I := Low(MediaQuery.Expressions) to High(MediaQuery.Expressions) do
    begin
      OK := EvaluateExpression(MediaQuery.Expressions[I]);
      if not OK then
        break;
    end;
  end;
  if OK then
    MediaMatchesQuery := True;
end;

procedure TfrxHtmlViewer.DoOnImageCacheChanged(Sender: TObject);
begin
  if Assigned(FOnImageCacheChanged) then
    FOnImageCacheChanged(Self);
end;

procedure TfrxHtmlViewer.BackgroundChange(Sender: TObject);
begin
  FPaintColor := (Sender as TfrxHtDocument).Background or PalRelative;
end;

function TfrxHtmlViewer.Find(const S: UnicodeString; MatchCase: Boolean): Boolean;
begin
  Result := FindEx(S, MatchCase, False);
end;

function TfrxHtmlViewer.FindEx(const S: UnicodeString; MatchCase, Reverse: Boolean): Boolean;
var
  Curs: Integer;
  S1: UnicodeString;
begin
  Result := False;
  if S = '' then
    Exit;
  with FSectionList do
  begin
    if MatchCase then
      S1 := S
    else
      S1 := htLowerCase(S);
    if Reverse then
      Curs := FindStringR(0, S1, MatchCase)
    else
      Curs := FindString(0, S1, MatchCase);
    if Curs >= 0 then
    begin
      Result := True;
    end;
  end;
end;

{----------------TfrxHtmlViewer.InitLoad}

procedure TfrxHtmlViewer.InitCache;
begin
  if not Assigned(FSectionList.ImageCache) then
  begin
    FSectionList.ImageCache := TfrxHtImageCache.Create;
    FSectionList.ImageCache.Sorted := True;
    FSectionList.ImageCache.OnCacheImageChanged := DoOnImageCacheChanged;
    Include(FViewerState, vsLocalImageCache);
  end;
end;

procedure TfrxHtmlViewer.InitLoad;
begin
  InitCache;
  FSectionList.Clear;
  FSectionList.SetFonts(
    htString(DefFontName), htString(DefPreFontName), DefFontSize, DefFontColor,
    DefHotSpotColor, DefVisitedLinkColor, DefOverLinkColor, DefBackground,
    htOverLinksActive in FOptions, not (htNoLinkUnderline in FOptions),
    CodePage, CharSet, MarginHeight, MarginWidth);
end;

{----------------TfrxHtmlViewer.Clear}

procedure TfrxHtmlViewer.Clear;
{Note: because of Frames do not clear history list here}
begin
  if IsProcessing then
    Exit;
  FSectionList.Clear;
  if vsLocalImageCache in FViewerState then
    FSectionList.ImageCache.Clear;

  FreeAndNil(FDocument);
  FCurrentFile := '';
  FCurrentFileType := HTMLType;

  FSectionList.SetFonts(
    htString(DefFontName), htString(DefPreFontName), DefFontSize, DefFontColor,
    DefHotSpotColor, DefVisitedLinkColor, DefOverLinkColor, DefBackground,
    htOverLinksActive in FOptions, not (htNoLinkUnderline in FOptions),
    CodePage, CharSet, MarginHeight, MarginWidth);
  FBase := '';
  FBaseEx := '';
  FBaseTarget := '';
  FTitle := '';
end;

procedure TfrxHtmlViewer.SetImageCache(ImageCache: TfrxHtImageCache);
begin
  FSectionList.ImageCache := ImageCache;
  FSectionList.ImageCache.OnCacheImageChanged := OnImageCacheChanged;
  Exclude(FViewerState, vsLocalImageCache);
end;

{----------------TfrxHtmlViewer.Reload}

procedure TfrxHtmlViewer.Reload; {reload the last file}
begin
  if FCurrentFile <> '' then
    LoadFromUrl(FCurrentFile, FCurrentFileType);
end;

{----------------TfrxHtmlViewer.GetOurPalette:}

function TfrxHtmlViewer.GetOurPalette: HPalette;
begin
  if ColorBits = 8 then
    Result := CopyPalette(ThePalette)
  else
    Result := 0;
end;

{----------------TfrxHtmlViewer.SetOurPalette}

procedure TfrxHtmlViewer.SetOurPalette(Value: HPalette);
var
  NewPalette: HPalette;
begin
  if (Value <> 0) and (ColorBits = 8) then
  begin
    NewPalette := CopyPalette(Value);
    if NewPalette <> 0 then
    begin
      if ThePalette <> 0 then
        DeleteObject(ThePalette);
      ThePalette := NewPalette;
    end;
  end;
end;

function TfrxHtmlViewer.FindSourcePos(DisplayPos: Integer): Integer;
begin
  Result := FSectionList.FindSourcePos(DisplayPos);
end;

function TfrxHtmlViewer.FindDisplayPos(SourcePos: Integer; Prev: Boolean): Integer;
begin
  Result := FSectionList.FindDocPos(SourcePos, Prev);
end;

{----------------TfrxHtmlViewer.SetProcessing}

procedure TfrxHtmlViewer.SetProcessing(Value: Boolean);
begin
  if (vsProcessing in FViewerState) <> Value then
  begin
    SetViewerStateBit(vsProcessing, Value);
  end;
end;

procedure TfrxHtmlViewer.HandleMeta(Sender: TObject; const HttpEq, Name, Content: ThtString);
begin
end;

procedure TfrxHtmlViewer.SetOptions(Value: ThtmlViewerOptions);
begin
  if Value <> FOptions then
  begin
    FOptions := Value;
    if Assigned(FSectionList) then
      with FSectionList do
      begin
        LinksActive := htOverLinksActive in FOptions;
        PrintTableBackground := (htPrintTableBackground in FOptions) or
          (htPrintBackground in FOptions);
        PrintBackground := htPrintBackground in FOptions;
        PrintMonoBlack := htPrintMonochromeBlack in FOptions;
        ShowDummyCaret := htShowDummyCaret in FOptions;
      end;
  end;
end;

function TfrxHtmlViewer.GetIDControl(const ID: ThtString): TfrxHtIDObject;
var
  I: Integer;
  Obj: TfrxHtIDObject;
begin
  Result := nil;
  I := -1;
  with FSectionList.IDNameList do
    if Find(ID, I) then
    begin
      Obj := Objects[I];
      if Obj is TfrxFrHtImageObj then
        Result := Obj;
    end;
end;

function TfrxHtmlViewer.GetIDDisplay(const ID: ThtString): ThtDisplayStyle;
var
  I: Integer;
  Obj: TfrxHtIDObject;
begin
  Result := pdUnassigned;
  I := -1;
  with FSectionList.IDNameList do
    if Find(ID, I) then
    begin
      Obj := Objects[I];
      if Obj is TfrxHtSectionBase then
        Result := TfrxHtSectionBase(Obj).Display;
    end;
end;

procedure TfrxHtmlViewer.SetIDDisplay(const ID: ThtString; Value: ThtDisplayStyle);
var
  I: Integer;
  Obj: TfrxHtIDObject;
begin
  I := -1;
  with FSectionList.IDNameList do
    if Find(ID, I) then
    begin
      Obj := Objects[I];
      if Obj is TfrxHtSectionBase then
        if TfrxHtSectionBase(Obj).Display <> Value then
        begin
          TfrxHtSectionBase(Obj).Display := Value;
        end;
    end;
end;

//-- BG ---------------------------------------------------------- 07.05.2014 --
procedure TfrxHtmlViewer.ToggleIDExpand(const URL: ThtString; var Handled: Boolean);
var
  I: Integer;
  ID: ThtString;
  pd: ThtDisplayStyle;
begin
  {The following looks for an URL of the form, "IDExpand_XXX".  This is interpreted
   as meaning a block with an ID="XXXPlus" or ID="XXXMinus" attribute should have
   its Display property toggled.
  }
  I :=  Pos('IDEXPAND_', Uppercase(URL));
  if I=1 then
  begin
    ID := Copy(URL, 10, Length(URL)-9);

    pd := IDDisplay[ID+'Plus'];
    IDDisplay[ID+'Plus'] := IDDisplay[ID+'Minus'];
    IDDisplay[ID+'Minus'] := pd;

    Handled := True;
  end;
end;

//-- BG ---------------------------------------------------------- 13.11.2016 --
procedure TfrxHtmlViewer.htStreamRequest(var Url: ThtString; var Stream: TStream; out PathOfUrl: ThtString);
  procedure GetTheFile;
  var
    Scheme, Specific: ThtString;
  begin
    Url := HTMLExpandFilename(Url);
    SplitScheme(Url, Scheme, Specific);
    PathOfUrl := ExtractFilePath(Url);
    if FileExists(Url) then
      Stream := TFileStream.Create( htStringToString(Url), fmOpenRead or fmShareDenyWrite);
  end;
var
  i: Integer;
  OriginalURL: ThtString;
begin
  if FCSSCache.IsFound(Url, i) then // handle the case where the css file is already loaded
    Stream := FCSSCache.GetStream(i)
  else
  begin
    OriginalURL := URL;
    GetTheFile;
    if Stream <> nil then
    begin
      i := FCSSCache.AddStream(OriginalURL, Stream);
      Stream.Free;
      Stream := FCSSCache.GetStream(i)
    end;
  end;
end;

//-- BG ---------------------------------------------------------- 13.11.2016 --
procedure TfrxHtmlViewer.htStreamRequested(const Url: ThtString; Stream: TStream);
begin
end;

initialization
  InitFileTypes;
finalization
  FileTypes.Free;
end.
