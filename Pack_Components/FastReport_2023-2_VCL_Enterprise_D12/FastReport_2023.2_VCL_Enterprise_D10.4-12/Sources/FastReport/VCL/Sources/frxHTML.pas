
{******************************************}
{                                          }
{             FastReport v7.0              }
{           HTML Add-In Object             }
{                                          }
{           Copyright (c) 2020             }
{            by Oleg Adibekov,             }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxHTML;

interface

{$I frx.inc}

{$IFNDEF FPC}
  {$Define UseMetaFile }
{$ENDIF}

uses
  Classes, Graphics,
  frCore, frCoreClasses, frxClass, frxHTMLViewer,
  frxProtocolFactory, frBaseGraphicsTypes;

type

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxHTMLObject = class(TComponent) // fake component
  end;

  TfrxEmbeddedDataType = (edNone, edInternal, edExternal);

  TfrxHtmlView = class(TfrxStretcheable, IfrxDataLinkObject, IfrxCachedView)
  private
    FAllowExpressions: Boolean;
    FExpressionDelimiters: String;
    FGapX: Extended;
    FGapY: Extended;
    FWysiwyg: Boolean;
    FFilePath: String;
    FDataLink: TfrxDataLink;
    FEmbeddedObjects: TfrxEmbeddedDataType;
    FData: WideString;
    FNewCacheType: TfrxCachedGraphicType;
    FIsIndexesRead: Boolean;
    FNeedReload: Boolean;
    FReloadLocked: Boolean;

    function IsExprDelimitersStored: Boolean;
    function UsePrinterCanvas: Boolean;

    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);

    procedure ReadCSSCacheData(Stream: TStream);
    procedure WriteCSSCacheData(Stream: TStream);

    procedure ReadImageCacheData(Stream: TStream);
    procedure WriteImageCacheData(Stream: TStream);

    procedure ReadIndexCacheData(Stream: TStream);
    procedure WriteIndexCacheData(Stream: TStream);

    function GetDefBackground: TColor;
    procedure SetDefBackground(const Value: TColor);
    function GetFontColor: TColor;
    procedure SetFontColor(const Value: TColor);
    function GetFontName: TFontName;
    procedure SetFontName(const Value: TFontName);
    function GetFontSize: Integer;
    procedure SetFontSize(const Value: Integer);
    function GetHotSpotColor: TColor;
    procedure SetHotSpotColor(const Value: TColor);
    function GetPreFontName: TFontName;
    procedure SetPreFontName(const Value: TFontName);
    function GetMarginHeight: Integer;
    procedure SetMarginHeight(const Value: Integer);
    function GetMarginWidth: Integer;
    procedure SetMarginWidth(const Value: Integer);

    procedure Reload;
    function GetFilePath: String;
    procedure SetFilePath(const Value: String);
    procedure ReadFilePath(Reader: TReader);
    procedure WriteFilePath(Writer: TWriter);

    function LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
    function GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
    function IsExpressionLink: Boolean;
    function GetDataLink: TfrxDataLink;
    procedure SetDataLink(const Value: TfrxDataLink);
    function IsDataLinkStored: Boolean;
    procedure SetCachedGraphic(const PictureCache: IfrxPictureCache);
    procedure ReleaseCachedGraphic;
    function IsUpdateRequired(NewCacheType: TfrxCachedGraphicType): Boolean;
    procedure DoDelayLoad;
    procedure GetCachedGraphic(ACacheType: TfrxCachedGraphicType; const PictureCache: IfrxPictureCache);
    procedure SetEmbeddedObjects(const Value: TfrxEmbeddedDataType);
    function IsEmbeddedObjects: Boolean;
    procedure DoOnImageCacheChanged(Sender: TObject);
  protected
    FHtmlViewer: TfrxHtmlViewer;
    FPartStart: Extended;
    FPartHeight: Extended;
    FTempPartStart: Extended;
    FOldText: WideString;
    FOldStart: Extended;
    FOldHeight: Extended;

    function CreateGraphic: TGraphic;
    function CalcPartHeight: Integer;

    procedure DefineProperties(Filer: TFiler); override;

    function IsLoadPicture(const ComplexName: string; out BLOB: WideString): Boolean;
    procedure LoadFromDataField;
    procedure GetExpressionDelimiters(out LeftDlm, RightDlm: WideString);
    procedure Loaded; override;
    function IsPreviewPages: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;

    procedure BeforePrint; override;
    procedure GetData; override;
    procedure AfterPrint; override;
    function CalcHeight: Extended; override; // Calculates and returns the object's height according to the data placed in it.

    class function GetDescription: string; override;

    procedure InitPart; override;
    function DrawPart: Extended; override;
    function HasNextDataPart(aFreeSpace: Extended): Boolean; override;

    property HtmlViewer: TfrxHtmlViewer read FHtmlViewer;
  published
    property AllowExpressions: Boolean read FAllowExpressions write FAllowExpressions default True;
    property BrushStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property DataLink: TfrxDataLink read GetDataLink write SetDataLink stored IsDataLinkStored;
    property ExpressionDelimiters: String read FExpressionDelimiters write FExpressionDelimiters stored IsExprDelimitersStored;
    property FillType;
    property Fill;
    property Frame;
    /// <summary>
    ///   The left indent of the text, in pixels.
    /// </summary>
    property GapX: Extended read FGapX write FGapX;
    /// <summary>
    ///   The top indent of the text, in pixels.
    /// </summary>
    property GapY: Extended read FGapY write FGapY;
    property TagStr;
    property URL;
    /// <summary>
    ///   Determines if the object should use the printer canvas to format the
    ///   text. A printer should be installed and ready.
    /// </summary>
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg default True;
    /// <summary>
    ///   Determines if images and CSS files should be saved in the report.
    /// </summary>
    property EmbeddedObjects: TfrxEmbeddedDataType read FEmbeddedObjects write SetEmbeddedObjects default edNone;

    { HTMLViever properties }
    property DefBackground: TColor read GetDefBackground write SetDefBackground;
    property DefFontColor: TColor read GetFontColor write SetFontColor;
    property DefFontName: TFontName read GetFontName write SetFontName;
    property DefFontSize: Integer read GetFontSize write SetFontSize; // pt
    property DefHotSpotColor: TColor read GetHotSpotColor write SetHotSpotColor;
    property DefPreFontName: TFontName read GetPreFontName write SetPreFontName;
    property MarginHeight: Integer read GetMarginHeight write SetMarginHeight;
    property MarginWidth: Integer read GetMarginWidth write SetMarginWidth;
    property Style;
  end;

implementation

uses
  Types, Variants, SysUtils, Forms,
  frUnicodeUtils, frHashUtils,
{$IFNDEF FPC}
  Windows, WideStrings,
{$ELSE}
  LCLType, LCLIntf, LCLProc, LazHelper,
{$ENDIF}
  frxHTMLRTTI,
{$IFNDEF NO_EDITORS}
  frxHTMLEditor,
  frxHTMLViewInPlaceEditor,
{$ENDIF}
  frxUtils, frxDsgnIntf, frxRes, frxPrinter, frxHelpers, frxNetUtils,
  frPictureGraphics, Math;

const
  MaxBlankLineColors = 3;
  BreakQuantity = 2;

type
  TGraphicHeader = record
    Count: Word;
    HType: Word;
    Size: Longint;
  end;

  TColorLine = class
  private
    FUsedColors: array of TColor;
    FCount: Integer;
  public
    constructor Create(AMaxColors: Integer);
    procedure Init;
    procedure AddColor(AColor: TColor);
    function IsFull: Boolean;

    property Count: Integer read FCount;
  end;

  TBGR = record
    B, G, R: byte;
  end;
  TBGRScanLine = array[0..0] of TBGR;
  PBGRScanLine = ^TBGRScanLine;

  TColorLines = class
  private
    FColorCount: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FCurrentLine: Integer;
    FColorLine: TColorLine;
    FBlankLineCount: array of Integer;
    FFoundEdge: array of Integer;
  public
    constructor Create(const AColorCount, AWidth, AHeight: Integer);
    destructor Destroy; override;
    procedure AddLine(ScanLine: PBGRScanLine);
    function GetFirstFound: Integer;
    function CalcEdge: Integer;
  end;

{ Utility routines }

const
  Unknown = -1;

{ TfrxHtmlView }

procedure TfrxHtmlView.AfterPrint;
begin
  if not IsDataField then
    FHtmlViewer.Text := FOldText;
  FPartStart := FOldStart;
  FPartHeight := FOldHeight;
  TfrxDataLink.RestoreState(FDataLink);
  inherited AfterPrint;
end;

procedure TfrxHtmlView.BeforePrint;
begin
  inherited BeforePrint;

  if not IsDataField then
    FOldText := FHtmlViewer.Text;
  FOldStart := FPartStart;
  FOldHeight := FPartHeight;
  TfrxDataLink.SaveState(FDataLink);
end;

function TfrxHtmlView.CalcHeight: Extended;
begin
  Result := FHtmlViewer.FullDisplaySize(Round(Width - 2 * GapX)).cy - FPartStart;
end;

function TfrxHtmlView.CalcPartHeight: Integer;
var
  GraphicWidth, GraphicHeight, GraphicStart: Integer;
  Bitmap: Graphics.TBitmap;
  y : Integer;
  ColorLines: TColorLines;
  BGRScanLine: PBGRScanLine;
  MaxPossibleHeight, ResidualHeight: Integer;
begin
  GraphicWidth := Round(Width - 2 * GapX);
  GraphicStart := Round(FPartStart);

  MaxPossibleHeight := Round(Height - 2 * GapY);
  //ResidualHeight := FHtmlViewer.PartDisplaySize(GraphicWidth, MaxPossibleHeight + GraphicStart).cy - Round(FPartStart);
  ResidualHeight := FHtmlViewer.FullDisplaySize(GraphicWidth).cy - Round(FPartStart);

  if ResidualHeight <= MaxPossibleHeight then
    Result := ResidualHeight
  else
  begin
    GraphicHeight := MaxPossibleHeight;
    Bitmap := FHtmlViewer.MakeBitmap(GraphicStart, GraphicWidth, GraphicWidth, GraphicHeight);
    ColorLines := TColorLines.Create(MaxBlankLineColors, GraphicWidth, GraphicHeight);
    try
      for y := GraphicHeight - 1 downto 0 do
      begin
        BGRScanLine := Bitmap.ScanLine[y];
        ColorLines.AddLine(BGRScanLine);
        if ColorLines.GetFirstFound <> Unknown then
          Break;
      end;
      Result := ColorLines.CalcEdge;
    finally
      Bitmap.Free;
      ColorLines.Free;
    end;
  end;

end;

constructor TfrxHtmlView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHtmlViewer := TfrxHtmlViewer.Create;
  FHtmlViewer.OnImageCacheChanged := DoOnImageCacheChanged;
  FHtmlViewer.InitCache;
  FReloadLocked := True;
  try
    DefBackground := clWhite;
    DefFontColor := clBtnText;
    DefFontName := 'Serif';
    DefFontSize := 12;
    DefHotSpotColor := clBlue;
    DefPreFontName := 'Monospace';
    MarginHeight := 5;
    MarginWidth := 10;
  finally
    FReloadLocked := False;
  end;

  FAllowExpressions := True;
  FExpressionDelimiters := '[,]';
  FGapX := 2;
  FGapY := 1;
  FWysiwyg := True;
  FNewCacheType := cgNone;
end;

function TfrxHtmlView.CreateGraphic: TGraphic;
{$IFDEF UseMetaFile}
var
  HtmlMetafile: TMetafile;

  function ClipMetafile(ClipWidth, ClipHeight: Integer; Metafile: TMetafile): TMetafile;
  begin
    Result := TMetafile.Create;
    Result.Width := ClipWidth;
    Result.Height := ClipHeight;
    with TMetafileCanvas.Create(Result, 0) do
      try
        IntersectClipRect(Handle, 0, 0, ClipWidth, ClipHeight);
        Lock;
        Draw(0, 0, Metafile);
      finally
        SelectClipRgn(Handle, 0);
        UnLock;
        Free;
      end;
  end;
{$ENDIF}
var
  GraphicWidth, GraphicHeight, GraphicStart: Integer;
begin
  GraphicWidth := Round(Width - 2 * GapX);
  GraphicStart := Round(FPartStart);

  if FPartHeight > 0 then
    GraphicHeight := Round(Min(Height - 2 * GapY, FPartHeight))
  else
    GraphicHeight := Round(Height - 2 * GapY);
  GraphicHeight := Max(GraphicHeight, 0);

{$IFDEF UseMetaFile}
  HtmlMetafile := FHtmlViewer.MakeMetaFile(GraphicStart, GraphicWidth + 1, GraphicWidth + 1, GraphicHeight + 1);
  try
    Result := ClipMetafile(GraphicWidth, GraphicHeight, HtmlMetafile);
  finally
    HtmlMetafile.Free;
  end;
{$ELSE}
  Result := FHtmlViewer.MakeBitmap(GraphicStart, GraphicWidth, GraphicWidth, GraphicHeight);
{$ENDIF}
end;

procedure TfrxHtmlView.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('CSSCache', ReadCSSCacheData, WriteCSSCacheData, IsEmbeddedObjects and (FHtmlViewer.CSSCache.Count > 0));
  Filer.DefineBinaryProperty('IndexCache', ReadIndexCacheData, WriteIndexCacheData, (FEmbeddedObjects = edExternal) and (FHtmlViewer.SectionList.ImageCache.Count > 0) and IsPreviewPages);
  Filer.DefineBinaryProperty('ImageCache', ReadImageCacheData, WriteImageCacheData, IsEmbeddedObjects and (FHtmlViewer.SectionList.ImageCache.Count > 0) and (not IsPreviewPages or (FEmbeddedObjects = edInternal)));
  Filer.DefineBinaryProperty('HtmlViewer', ReadData, WriteData, True);
  Filer.DefineProperty('FilePath', ReadFilePath, WriteFilePath, GetFilePath <> '');
end;

destructor TfrxHtmlView.Destroy;
begin
  FHtmlViewer.Free;
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

procedure TfrxHtmlView.DoDelayLoad;
begin
  FHtmlViewer.LoadFromString(FData, FFilePath);
  FData := '';// clear after loading
end;

procedure TfrxHtmlView.DoOnImageCacheChanged(Sender: TObject);
begin
  FNewCacheType := cgNone;
end;

procedure TfrxHtmlView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  Graphic: TGraphic;
  ScaledRect: TRect;
  PrinterHandle: TfrHandle;
  aScaleX, aScaleY: Extended;
begin

  if UsePrinterCanvas then
    PrinterHandle := frxPrinters.Printer.Canvas.Handle
  else
    PrinterHandle := GetDC(0);
  try
    GetDisplayScale(PrinterHandle, UsePrinterCanvas, aScaleX, aScaleY);

    BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
    DrawBackground;

    Graphic := CreateGraphic;

    try
      Canvas.Lock;
      try
        ScaledRect := Bounds(FX + Round(GapX * ScaleX), FY + Round(GapY * ScaleY),
          Round(Graphic.Width * ScaleX), Round(Graphic.Height * ScaleY));
        Canvas.StretchDraw(ScaledRect, Graphic);
      finally
        Canvas.Unlock;
      end;
    finally
      Graphic.Free;
    end;
  finally
    if not UsePrinterCanvas then ReleaseDC(0, PrinterHandle);
  end;

  if not FObjAsMetafile then
    DrawFrame;
end;

//Returns the amount of unused space. If view can't fit in the height, this method returns the Height
function TfrxHtmlView.DrawPart: Extended;
begin

  if Round(Height - GapY * 2) <= 0 then // text can't fit
  begin
    Result := Height;
    Exit;
  end;

  FPartStart := FTempPartStart;
  FPartHeight := CalcPartHeight;
  FTempPartStart := FTempPartStart + FPartHeight;

  Result := Height - FPartHeight;
end;

procedure TfrxHtmlView.GetData;
var
  ws, ws1, ws2, dc1, dc2: WideString;
  i, j: integer;
begin
  inherited GetData;

  if IsDataField then
    LoadFromDataField;
  if AllowExpressions then
  begin
    ws := FHtmlViewer.Text;
    GetExpressionDelimiters(dc1, dc2);

    if Pos(dc1, ws) <> 0 then
    begin
      i := 1;
      repeat
        while (i < Length(ws)) and (Copy(ws, i, Length(dc1)) <> dc1) do
          Inc(i);

        ws1 := frxGetBrackedVariableW(ws, dc1, dc2, i, j);
        if i <> j then
        begin
          Delete(ws, i, j - i + 1);

          if not IsLoadPicture(ws1, ws2) then
            ws2 := Report.Calc(ws1);

          Insert(ws2, ws, i);
          Inc(i, Length(ws2));
          j := 0;
        end;
      until i = j;
    end;
    if ws <> FHtmlViewer.Text then
      FHtmlViewer.LoadFromString(ws, FFilePath);
  end;
end;

function TfrxHtmlView.GetDataLink: TfrxDataLink;
begin
  if not Assigned(FDataLink) then
    FDataLink := TfrxDataLink.Create;
  Result := FDataLink;
end;

function TfrxHtmlView.GetDefBackground: TColor;
begin
  Result := FHtmlViewer.DefBackground;
end;

class function TfrxHtmlView.GetDescription: String;
begin
  Result := frxResources.Get('obHTML');
end;

procedure TfrxHtmlView.GetExpressionDelimiters(out LeftDlm, RightDlm: WideString);
var
  ws: WideString;
  p: Integer;
begin
  ws := FExpressionDelimiters;
  p := Pos(',', ws);
  LeftDlm := Copy(ws, 1, p - 1);
  RightDlm := Copy(ws, p + 1, MaxInt);
end;

function TfrxHtmlView.GetFilePath: String;
begin
  Result := FHtmlViewer.CurrentFile;
end;

function TfrxHtmlView.GetFontColor: TColor;
begin
  Result := FHtmlViewer.DefFontColor;
end;

function TfrxHtmlView.GetFontName: TFontName;
begin
  Result := FHtmlViewer.DefFontName;
end;

function TfrxHtmlView.GetFontSize: Integer;
begin
  Result := Round(FHtmlViewer.DefFontSize * Screen.PixelsPerInch / 96.0);
end;

function TfrxHtmlView.GetHotSpotColor: TColor;
begin
  Result := FHtmlViewer.DefHotSpotColor;
end;

function TfrxHtmlView.GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
begin
  Result := TfrxDataLink.GetLink(FDataLink, LoadMethod);
end;

function TfrxHtmlView.GetMarginHeight: Integer;
begin
  Result := FHtmlViewer.MarginHeight;
end;

function TfrxHtmlView.GetMarginWidth: Integer;
begin
  Result := FHtmlViewer.MarginWidth;
end;

function TfrxHtmlView.GetPreFontName: TFontName;
begin
  Result := FHtmlViewer.DefPreFontName;
end;

function TfrxHtmlView.HasNextDataPart(aFreeSpace: Extended): Boolean;
begin
  Result := inherited HasNextDataPart(aFreeSpace);
end;

procedure TfrxHtmlView.InitPart;
begin
  FTempPartStart := FPartStart;
  FPartHeight := 0;
end;

function TfrxHtmlView.IsDataLinkStored: Boolean;
begin
  Result := TfrxDataLink.IsDataLinkStored(FDataLink, frComponentState);
end;

function TfrxHtmlView.IsEmbeddedObjects: Boolean;
begin
  Result := FEmbeddedObjects in [edInternal, edExternal];
end;

function TfrxHtmlView.IsExprDelimitersStored: Boolean;
begin
  Result := FExpressionDelimiters <> '[,]';
end;

function TfrxHtmlView.IsExpressionLink: Boolean;
begin
  Result := TfrxDataLink.IsExpressionLink(FDataLink);
end;

function TfrxHtmlView.IsLoadPicture(const ComplexName: string; out BLOB: WideString): Boolean;
var
  DataSet: TfrxDataSet;
  FieldName: string;
  Header: TGraphicHeader;
  MemoryStream: TMemoryStream;
  aSt: AnsiString;
  GHelper: TfrxCustomGraphicFormatClass;
begin
  Report.GetDatasetAndField(ComplexName, DataSet, FieldName);
  Result := (DataSet <> nil) and (FieldName <> '') and DataSet.IsBlobField(FieldName)
            {$IFNDEF FPC} and not (DataSet.IsWideMemoBlobField(FieldName) or DataSet.IsMemoBlobField(FieldName)) {$ENDIF} ;

  if Result then
  begin
    MemoryStream := TMemoryStream.Create;
    try
      DataSet.AssignBlobTo(FieldName, MemoryStream);

      if MemoryStream.Size >= SizeOf(TGraphicHeader) then // skip Delphi blob-image header
      begin
        MemoryStream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> MemoryStream.Size - SizeOf(Header)) then
        MemoryStream.Position := 0;
      end;
      GHelper := GetGraphicFormats.FindByFormat(MemoryStream);

      {$IFDEF FPC}
      if (GHelper = nil) then
      begin
        Result := False;
        Exit;
      end;
      {$ENDIF}

      SetLength(aSt, MemoryStream.Size - MemoryStream.Position);
      MemoryStream.ReadBuffer(aSt[1], Length(aSt));
      aSt := frBase64Encode(aSt);
      if Assigned(GHelper) then
        BLOB := 'data:' + GHelper.GetGraphicMime + ';base64,'  + Widestring(aSt)
      else
        BLOB := Widestring(aSt);
    finally
      MemoryStream.Free;
    end;
  end;
end;

function TfrxHtmlView.IsPreviewPages: Boolean;
begin
  Result := ((csFrxSerializeToDict in frComponentState) or (csFrxSerializeToPreviewPages in frComponentState))
    and not (csFrxModifyObject in frComponentState);
end;

function TfrxHtmlView.IsUpdateRequired(
  NewCacheType: TfrxCachedGraphicType): Boolean;
begin
  Result := (FNewCacheType <> NewCacheType) and (FEmbeddedObjects = edExternal);
  FNewCacheType := NewCacheType;
//  Result := FHtmlViewer.SectionList.ImageCache.IsNeedExternalCacheUpdate(NewCacheType);
  if Result and (FData = '') then
    FData := FHtmlViewer.Text;
end;

function TfrxHtmlView.LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
var
  s: TStringStream;
  sLink: String;
begin
  Result := True;
  sLink := '';
  s := TStringStream.Create('');
  try
    s.CopyFrom(Stream, Stream.Size);
    if NewLink  <> '' then
      sLink := NewLink
    else if Assigned(FDataLink) then
      sLink := FDataLink.Link;
    FHtmlViewer.LoadFromStream(s, sLink);
  except
    Result := False;
  end;
  s.Free;
end;

procedure TfrxHtmlView.Loaded;
begin
  inherited;
  if not FIsIndexesRead then
    DoDelayLoad;
  FIsIndexesRead := False;
  if FNeedReload then
    Reload;
end;

procedure TfrxHtmlView.LoadFromDataField;
var
  AWideStrings: TWideStrings;
begin
  AWideStrings := TfrWideStrings.Create;
  try
    if DataSet.IsBlobField(DataField) then
      DataSet.AssignBlobTo(DataField, AWideStrings)
    else
      AWideStrings.Add(VarToStr(DataSet.Value[DataField]));
    FHtmlViewer.LoadFromString(AWideStrings.Text);
  finally
    AWideStrings.Free;
  end;
end;

procedure TfrxHtmlView.ReadCSSCacheData(Stream: TStream);
begin
  if IsEmbeddedObjects then
    HtmlViewer.CSSCache.ReadFromStream(Stream);
end;

procedure TfrxHtmlView.ReadData(Stream: TStream);

  function BytesInStream: integer;

    function IsTest(NumBytes: Integer): Boolean;
    const
      MaxCardinal = 4294967295;
    var
      Pos: Int64;
      nChars: Cardinal;
    begin
      Pos := Stream.Position;
      Stream.Position := Stream.Position + 2 * NumBytes; // FPartStart + FPartHeight
      Stream.ReadBuffer(nChars, SizeOf(nChars)); // ReadWideStringFromStream
      Result := MaxCardinal div SizeOf(WideChar) > nChars;
      Result := Result and (Stream.Size = Stream.Position + nChars * SizeOf(WideChar));
      Stream.Position := Pos;
    end;

  begin
    if IsTest(8) then
      Result :=  8
    else if IsTest(10) then
      Result := 10
    else
      Result := 16;
  end;

var
  StreamBytes: Integer;
begin
  StreamBytes := BytesInStream;

  if StreamBytes = SizeOf(Extended) then
  begin
    Stream.ReadBuffer(FPartStart, SizeOf(FPartStart));
    Stream.ReadBuffer(FPartHeight, SizeOf(FPartHeight));
  end
  else if StreamBytes = 8 then
  begin
    FPartStart := ReadExtended8(Stream);
    FPartHeight := ReadExtended8(Stream);
  end
  else if StreamBytes = 10 then
  begin
    FPartStart := ReadExtended10(Stream);
    FPartHeight := ReadExtended10(Stream);
  end
  else if StreamBytes = 16 then
  begin
    FPartStart := ReadExtended16(Stream);
    FPartHeight := ReadExtended16(Stream);
  end;
  FData := ReadWideStringFromStream(Stream);
end;

procedure TfrxHtmlView.ReadFilePath(Reader: TReader);
begin
  SetFilePath(Reader.ReadString);
end;

procedure TfrxHtmlView.ReadImageCacheData(Stream: TStream);
begin
  if IsEmbeddedObjects then
    HtmlViewer.SectionList.ImageCache.ReadFromStream(Stream);
end;

procedure TfrxHtmlView.ReadIndexCacheData(Stream: TStream);
begin
  if FEmbeddedObjects = edExternal then
  begin
    HtmlViewer.SectionList.ImageCache.ReadIndexesFromStream(Stream);
    FIsIndexesRead := True;
  end;
end;

procedure TfrxHtmlView.ReleaseCachedGraphic;
begin
  FHtmlViewer.SectionList.ImageCache.Clear;
end;

procedure TfrxHtmlView.Reload;
var
  ws: WideString;
begin
  if FReloadLocked then Exit;
  if (FData <> '') or (csReading in ComponentState) or (IsLoading) then
  begin
    FNeedReload := True;
    Exit;
  end;
  ws := FHtmlViewer.Text;
  FHtmlViewer.LoadFromString(ws, FFilePath);
  FNeedReload := False;
end;

procedure TfrxHtmlView.GetCachedGraphic(ACacheType: TfrxCachedGraphicType; const PictureCache: IfrxPictureCache);
begin
  if FEmbeddedObjects = edExternal then
  begin
    FHtmlViewer.SectionList.ImageCache.FillFromPictureCache(PictureCache, ACacheType);
    DoDelayLoad;
  end;
end;

procedure TfrxHtmlView.SetCachedGraphic(const PictureCache: IfrxPictureCache);
begin
  if FEmbeddedObjects = edExternal then
    FHtmlViewer.SectionList.ImageCache.FillPictureCache(PictureCache);
end;

procedure TfrxHtmlView.SetDataLink(const Value: TfrxDataLink);
begin
  if not Assigned(FDataLink) then
    GetDataLink;
  FDataLink.Assign(Value);
end;

procedure TfrxHtmlView.SetDefBackground(const Value: TColor);
begin
  FHtmlViewer.DefBackground := Value;
  Reload;
end;

procedure TfrxHtmlView.SetEmbeddedObjects(const Value: TfrxEmbeddedDataType);
begin
  if (FEmbeddedObjects = edExternal) and (Value <> edExternal) then
  begin
    FHtmlViewer.SectionList.ImageCache.Clear;
    Reload;
  end;
  FEmbeddedObjects := Value;
end;

procedure TfrxHtmlView.SetFilePath(const Value: String);
begin
  FFilePath := Value;
  FHtmlViewer.CurrentFile := Value;
  Reload;
end;

procedure TfrxHtmlView.SetFontColor(const Value: TColor);
begin
  FHtmlViewer.DefFontColor := Value;
  Reload;
end;

procedure TfrxHtmlView.SetFontName(const Value: TFontName);
begin
  FHtmlViewer.DefFontName := Value;
  Reload;
end;

procedure TfrxHtmlView.SetFontSize(const Value: Integer);
begin
  FHtmlViewer.DefFontSize := Value;
  Reload;
end;

procedure TfrxHtmlView.SetHotSpotColor(const Value: TColor);
begin
  FHtmlViewer.DefHotSpotColor := Value;
  Reload;
end;

procedure TfrxHtmlView.SetMarginHeight(const Value: Integer);
begin
  FHtmlViewer.MarginHeight := Value;
  Reload;
end;

procedure TfrxHtmlView.SetMarginWidth(const Value: Integer);
begin
  FHtmlViewer.MarginWidth := Value;
  Reload;
end;

procedure TfrxHtmlView.SetPreFontName(const Value: TFontName);
begin
  FHtmlViewer.DefPreFontName := Value;
  Reload;
end;

function TfrxHtmlView.UsePrinterCanvas: Boolean;
begin
  Result := frxPrinters.HasPhysicalPrinters and FWysiwyg;
end;

procedure TfrxHtmlView.WriteCSSCacheData(Stream: TStream);
begin
  if IsEmbeddedObjects then
    HtmlViewer.CSSCache.WriteToStream(Stream);
end;

procedure TfrxHtmlView.WriteData(Stream: TStream);
begin
  Stream.WriteBuffer(FPartStart, SizeOf(FPartStart));
  Stream.WriteBuffer(FPartHeight, SizeOf(FPartHeight));
  if FData <> '' then
    WriteWideStringToStream(Stream, FData)
  else
    WriteWideStringToStream(Stream, FHtmlViewer.Text);
end;

procedure TfrxHtmlView.WriteFilePath(Writer: TWriter);
begin
  Writer.WriteString(GetFilePath);
end;

procedure TfrxHtmlView.WriteImageCacheData(Stream: TStream);
begin
  if IsEmbeddedObjects then
    HtmlViewer.SectionList.ImageCache.WriteToStream(Stream);
end;

procedure TfrxHtmlView.WriteIndexCacheData(Stream: TStream);
begin
  if FEmbeddedObjects = edExternal then
    HtmlViewer.SectionList.ImageCache.WriteIndexesToStream(Stream);
end;

{ TColorLine }

procedure TColorLine.AddColor(AColor: TColor);
var
  i: Integer;
begin
  if not IsFull then
  begin
    for i := 0 to FCount - 1 do
      if FUsedColors[i] = AColor then
        Exit;
    FUsedColors[FCount] := AColor;
    FCount := FCount + 1;
  end;
end;

constructor TColorLine.Create(AMaxColors: Integer);
begin
  inherited Create;
  SetLength(FUsedColors, AMaxColors)
end;

procedure TColorLine.Init;
begin
  FCount := 0;
end;

function TColorLine.IsFull: Boolean;
begin
  Result := FCount >= Length(FUsedColors);
end;

{ TColorLines }

procedure TColorLines.AddLine(ScanLine: PBGRScanLine);
var
  x, qColor: Integer;
begin
  FColorLine.Init;
  FCurrentLine := FCurrentLine - 1;

  for x := 0 to FWidth - 1 do
  begin
    with ScanLine^[x] do
      FColorLine.AddColor(RGB(R, G, B));
    if FColorLine.IsFull then
      Break;
  end;

  for qColor := 0 to FColorCount - 1 do
    if FFoundEdge[qColor] = Unknown then
      if FColorLine.Count > qColor + 1 then
        FBlankLineCount[qColor] := 0
      else if FBlankLineCount[qColor] + 1 < BreakQuantity then
        FBlankLineCount[qColor] := FBlankLineCount[qColor] + 1
      else
        FFoundEdge[qColor] := FCurrentLine + FBlankLineCount[qColor] div 2 - 1;
end;

function TColorLines.CalcEdge: Integer;
var
  qColor: Integer;
begin
  for qColor := 0 to FColorCount - 1 do
    if FFoundEdge[qColor] <> Unknown then
    begin
      Result := FFoundEdge[qColor] + BreakQuantity div 2;
      Exit;
    end;
  Result := FHeight;
end;

constructor TColorLines.Create(const AColorCount, AWidth, AHeight: Integer);
var
  i: Integer;
begin
  FColorCount := AColorCount;
  FColorLine := TColorLine.Create(FColorCount + 1);
  SetLength(FBlankLineCount, FColorCount);
  SetLength(FFoundEdge, FColorCount);
  for i := 0 to FColorCount - 1 do
    FFoundEdge[i] := Unknown;

  FWidth := AWidth;
  FHeight := AHeight;
  FCurrentLine := AHeight;
end;

destructor TColorLines.Destroy;
begin
  FColorLine.Free
end;

function TColorLines.GetFirstFound: Integer;
begin
  Result := FFoundEdge[0];
end;

initialization
  frxObjects.RegisterObject1(TfrxHtmlView, nil, frxResources.Get(TfrxHtmlView.GetDescription), '', 0, 84);
  frxHideProperties(TfrxHtmlView, 'FilePath');

finalization

frxObjects.Unregister(TfrxHtmlView);

end.
