{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                 TPdfPrinterEh object                  }
{                                                       }
{   Copyright (c) 2021-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PdfPrintersEh;

{$I EhLib.Inc}
{$SCOPEDENUMS ON}

interface

uses
  SysUtils, Classes, Graphics, Controls,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF FPC}
  {$IFDEF FPC_WINDOWS}
    Windows,
  {$ELSE}
  {$ENDIF}
  EhLibLCL, LCLType,
{$ELSE}
  EhLibVCL, Windows,
{$ENDIF}
  Types, Printers, PrntsEh, PdfDocumentsEh;

type
  TPdfPrinterEh = class;

  TPdfCanvasOperationKindEh = (Fill, Stroke, Text);

{ TPdfPrinterCanvasEh }

  TPdfPrinterCanvasEh = class(TBasePrinterCanvas)
  private
    FFont: TFont;
    FPen: TPen;
    FBrush: TBrush;
    FCopyMode: TCopyMode;
    FPhysicalPPI: Integer;
    FLogicalPPIFactor: Integer;
    FLineToPos: TPoint;
    FOrigin: TPoint;
    FScaleXMult: Integer;
    FScaleXDivd: Integer;
    FScaleYMult: Integer;
    FScaleYDivd: Integer;
    FScaleX: Double;
    FScaleY: Double;

    function GetPrinter: TPdfPrinterEh;
    function PointToPdfGrPoint(APoint: TPoint): TPointF;
    function RectToPdfGrRect(const ARect: TRect): TRectF;

    procedure PreparePdfCanvas(CanvasOperation: TPdfCanvasOperationKindEh; UseScale: Boolean);

  protected
    function GetBrush: TBrush; override;
    function GetCopyMode: TCopyMode; override;
    function GetFont: TFont; override;
    function GetPen: TPen; override;
    function GetPixelsPerInchX: Integer; override;
    function GetPixelsPerInchY: Integer; override;
    function GetRotationDegree: Single; override;

    procedure SetBrush(const Value: TBrush); override;
    procedure SetCopyMode(const Value: TCopyMode); override;
    procedure SetFont(const Value: TFont); override;
    procedure SetPen(const Value: TPen); override;
    procedure SetRotationDegree(const Value: Single); override;
    procedure InternalDrawRtfText(RichText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; MeasureLayout: Boolean; out Pages, LastPageBlockHeight: Integer); virtual;

  public
    constructor Create(AVirtualPrinter: TBaseVirtualPrinter);
    destructor Destroy; override;

    function CalcTextSize(const Text: String; InitRectWidth: Integer; WordWrap: Boolean): TSize; override;
    function TextExtent(const Text: string): TSize; override;

    procedure Draw(X, Y: Integer; Graphic: TGraphic); overload; override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte); overload; override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
    procedure FillRect(const ARect: TRect); override;

    procedure GetTextMetrics(out tm: TTextMetric); override;
    procedure Polyline(const Points: array of TPoint); override;
    procedure TextRect(var ARect: TRect; var Text: string; TextFormat: TTextFormat = []); override;
    procedure VerticalTextRect(var ARect: TRect; var Text: string; TextFormat: TTextFormat = []); override;
    procedure LineTo(X, Y: Integer); override;
    procedure MoveTo(X, Y: Integer); override;
    procedure Rectangle(X1, Y1, X2, Y2: Integer); override;

    procedure SetCanvasOrigin(xOrg, yOrg: Integer); override;
    procedure SetCanvasScale(xMult, xDivd, yMult, yDivd: Integer); override;
    procedure DrawRtfText(RichText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; out Pages, LastPageBlockHeight: Integer); override;
    procedure MeasureRtfTextLayout(RichText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; out Pages, LastPageBlockHeight: Integer); override;

    procedure AppendClipRect(AClipRect: TRect); override;
    procedure RestoreClip; override;

    property Printer: TPdfPrinterEh read GetPrinter;
  end;

{ TPdfPrinterEh }

  TPdfPrinterEh = class(TBaseVirtualPrinter)
  private
    FFileName: String;
    FDocStarted: Boolean;
    FPdfDocument: TPdfDocumentEh;
    FCurrentPage: TPdfPageEh;
    FTitle: String;
    FPrinters: TStrings;
    FOrientation: TPrinterOrientation;
    function GetPrinterCanvas: TPdfPrinterCanvasEh;

  protected
    procedure SetOrientation(const Value: TPrinterOrientation); override;

    function CreatePrinterCanvas: TBasePrinterCanvas; override;
    function GetOrientation: TPrinterOrientation; override;
    function GetPixelsPerInchX: Integer; override;
    function GetPixelsPerInchY: Integer; override;
    function GetTitle: String; override;
    function GetAborted: Boolean; override;

    function GetPageHeight: Integer; override;
    function GetPageWidth: Integer; override;
    function GetPageNumber: Integer; override;
    function GetFullPageWidth: Integer; override;
    function GetFullPageHeight: Integer; override;
    function GetPrinters: TStrings; override;

    procedure SetTitle(const Value: string); override;

  public
    constructor Create;
    destructor Destroy; override;

    function CreateMeasuringCanvas: TBasePrinterCanvas; override;

    procedure Abort; override;
    procedure BeginDoc(AFileName: String); reintroduce; overload;
    procedure EndDoc; override;

    procedure BeginDoc; overload; override;
    procedure NewPage; override;

    property FileName: String read FFileName write FFileName;
    property CurrentPage: TPdfPageEh read FCurrentPage;
    property Canvas: TPdfPrinterCanvasEh read GetPrinterCanvas;
  end;

function PdfPrinter: TPdfPrinterEh;
function SetPdfPrinter(NewPdfPrinter: TPdfPrinterEh): TPdfPrinterEh;

implementation

uses PdfGraphicsEh, PdfFontsEh, DBCtrlsEh,
  Math, ComCtrls, Forms, StdCtrls;

var
  FPdfPrinter: TPdfPrinterEh = nil;

function PdfPrinter: TPdfPrinterEh;
begin
  if FPdfPrinter = nil then
    FPdfPrinter := TPdfPrinterEh.Create;

  Result := FPdfPrinter;
end;

function SetPdfPrinter(NewPdfPrinter: TPdfPrinterEh): TPdfPrinterEh;
begin
  Result := FPdfPrinter;
  FPdfPrinter := NewPdfPrinter;
end;

procedure FreePdfPrinter;
begin
  FreeAndNil(FPdfPrinter);
end;

{$IFDEF FPC}
{$ELSE}
var
  FBufferedRichEdit: TDBRichEditEh;

function BufferedRichEdit: TDBRichEditEh;
begin
  if (FBufferedRichEdit = nil) then
  begin
    FBufferedRichEdit := TDBRichEditEh.Create(Application);
    FBufferedRichEdit.Visible := False;
    FBufferedRichEdit.ScrollBars := ssBoth;
    FBufferedRichEdit.ParentWindow := Application.Handle;
  end;

  Result := FBufferedRichEdit;
end;
{$ENDIF}

procedure FreeBufferedRichEdit;
begin
// Will be freed by the Application.
//  FreeAndNil(FBufferedRichEdit);
end;

{$IFDEF FPC}
{$ELSE}
type
  TRichTextRenderer = class(TObject)
  private
    procedure InternalRenderBlock(IsMeasureBlock: Boolean);
  public
    RichEdit: TDBRichEditEh;
    Canvas: TBasePrinterCanvas;
    FirstPageBlockTop: Integer;
    NextPagesBlockTop: Integer;
    BlockLeftStart: Integer;
    BlockRight: Integer;
    BlockBottom: Integer;
    FinishPagePos: Integer;
    RenderedInlineFirstChar: Integer;

    Line: Integer;
    CurPageNextVertPos: Integer;
    CurPageStartVertPos: Integer;

    EndOfPageReached: Boolean;
    EndOfTextReached: Boolean;

    procedure InitForFirstPage(ALine: Integer; AStartPagePos: Integer; ARenderedInlineFirstChar: Integer);
    procedure InitForNewPage();
    procedure RenderBlock();
    procedure MeasureBlock();

    constructor Create(ARichEdit: TDBRichEditEh; ACanvas: TBasePrinterCanvas; AFirstPageBlockTop, ANextPagesBlockTop, ABlockBottom, ABlockLeft, ABlockRight: Integer);
  end;

{ TRichTextRenderState }

constructor TRichTextRenderer.Create(ARichEdit: TDBRichEditEh; ACanvas: TBasePrinterCanvas;
  AFirstPageBlockTop, ANextPagesBlockTop, ABlockBottom, ABlockLeft, ABlockRight: Integer);
begin
  RichEdit := ARichEdit;
  Canvas := ACanvas;
  FirstPageBlockTop := AFirstPageBlockTop;
  NextPagesBlockTop := ANextPagesBlockTop;
  BlockBottom := ABlockBottom;
  BlockLeftStart := ABlockLeft;
  BlockRight := ABlockRight;
  InitForFirstPage(0, FirstPageBlockTop, 0);
end;

procedure TRichTextRenderer.InitForFirstPage(ALine, AStartPagePos,
  ARenderedInlineFirstChar: Integer);
begin
  Line := ALine;
  RenderedInlineFirstChar := ARenderedInlineFirstChar;
  CurPageNextVertPos := AStartPagePos;
  CurPageStartVertPos := AStartPagePos;
end;

procedure TRichTextRenderer.InitForNewPage();
begin
  EndOfPageReached := False;
  EndOfTextReached := False;
  CurPageNextVertPos := NextPagesBlockTop;
  CurPageStartVertPos := NextPagesBlockTop;
end;

procedure TRichTextRenderer.MeasureBlock;
begin
  InternalRenderBlock(True);
end;

procedure TRichTextRenderer.RenderBlock;
begin
  InternalRenderBlock(False);
end;

procedure TRichTextRenderer.InternalRenderBlock(IsMeasureBlock: Boolean);
var
  I: Integer;
  SelStart: Integer;
  SelAttr: TTextAttributes;
  Paragraph: TParaAttributes;
  FntStyle: TFontStyles;
  Text: String;
  ATextRect: TRect;
  TextFormat: TTextFormat;
  ATextHeight: Integer;
begin
  SelStart := 0;
  TextFormat := [];
  for I := 0 to Line - 1 do
  begin
    SelStart := SelStart + Length(RichEdit.Lines[I]) + 1;
  end;

  Text := RichEdit.Lines[Line];
  RichEdit.SelStart := SelStart;

  SelAttr := RichEdit.SelAttributes;
  Paragraph := RichEdit.Paragraph;

  if (Paragraph.Alignment = TAlignment.taLeftJustify) then
    TextFormat := [tfLeft]
  else if (Paragraph.Alignment = TAlignment.taRightJustify) then
    TextFormat := [tfRight]
  else if (Paragraph.Alignment = TAlignment.taCenter) then
    TextFormat := [tfCenter];
  TextFormat := TextFormat + [tfWordBreak];

  Canvas.Font.Name := SelAttr.Name;
  Canvas.Font.Color := SelAttr.Color;
  Canvas.Font.Size := SelAttr.Size;

  FntStyle := [];
  if fsBold in SelAttr.Style then
    FntStyle := FntStyle + [TFontStyle.fsBold];
  if fsItalic in SelAttr.Style then
    FntStyle := FntStyle + [TFontStyle.fsItalic];
  if fsUnderline in SelAttr.Style then
    FntStyle := FntStyle + [TFontStyle.fsUnderline];
  if fsStrikeout in SelAttr.Style then
    FntStyle := FntStyle + [TFontStyle.fsStrikeOut];

  Canvas.Font.Style := FntStyle;

  ATextRect := Rect(BlockLeftStart,
                    CurPageNextVertPos,
                    BlockRight,
                    CurPageNextVertPos);

  Canvas.TextRect(ATextRect, Text, TextFormat + [tfCalcRect]);
  ATextHeight := RectHeight(ATextRect);

  if (CurPageNextVertPos + ATextHeight > BlockBottom) then
  begin
    EndOfPageReached := True;
    Exit;
  end;

  ATextRect := Rect(BlockLeftStart,
                    CurPageNextVertPos,
                    BlockRight,
                    BlockBottom);

  if not IsMeasureBlock then
    Canvas.TextRect(ATextRect, Text, TextFormat);

  CurPageNextVertPos := CurPageNextVertPos + ATextHeight;

  Line := Line + 1;
  if Line >= RichEdit.Lines.Count then
    EndOfTextReached := True;
end;
{$ENDIF}

{ TMeasuringPdfPrinterCanvas }

type
  TMeasuringPdfPrinterCanvas = class(TPdfPrinterCanvasEh)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;
  end;

constructor TMeasuringPdfPrinterCanvas.Create;
begin
  inherited Create(TPdfPrinterEh.Create);

  Printer.BeginDoc('');
end;

destructor TMeasuringPdfPrinterCanvas.Destroy;
begin
  Printer.EndDoc;
  Printer.Free;
  inherited Destroy;
end;

{ TPdfPrinterEh }

constructor TPdfPrinterEh.Create;
begin
  inherited Create;
  FPrinters := TStringList.Create;
  FPrinters.Add('Pdf Printer');
end;

destructor TPdfPrinterEh.Destroy;
begin
  FreeAndNil(FPrinters);
  inherited Destroy;
end;

function TPdfPrinterEh.CreateMeasuringCanvas: TBasePrinterCanvas;
begin
  Result := TMeasuringPdfPrinterCanvas.Create()
end;

function TPdfPrinterEh.CreatePrinterCanvas: TBasePrinterCanvas;
begin
  Result := TPdfPrinterCanvasEh.Create(Self);
end;

procedure TPdfPrinterEh.BeginDoc(AFileName: String);
begin
  {$IFDEF FPC_LINUX}
  raise Exception.Create('TPdfPrinterEh is not supported in FPC.LINUX');
  {$ELSE}
  {$ENDIF}
  FileName := AFileName;
  FPdfDocument := TPdfDocumentEh.Create;
  NewPage;
end;

function TPdfPrinterEh.GetPrinterCanvas: TPdfPrinterCanvasEh;
begin
  Result := TPdfPrinterCanvasEh(inherited Canvas);
end;

function TPdfPrinterEh.GetPrinters: TStrings;
begin
  Result := FPrinters;
end;

procedure TPdfPrinterEh.BeginDoc;
begin
  if (FDocStarted) then
    raise Exception.Create('TPdfPrinterEh.BeginDoc: The document already started');
  FDocStarted := True;
end;

procedure TPdfPrinterEh.EndDoc;
begin
  if (FDocStarted) then
  begin
    FDocStarted := False;
  end
  else
  begin
    if (FileName <> '') then
      FPdfDocument.SaveToFile(FileName);
    FreeAndNil(FPdfDocument);
  end;
end;

procedure TPdfPrinterEh.Abort;
begin
  inherited Abort;
end;

procedure TPdfPrinterEh.NewPage;
var
  PageSize: TSizeF;
begin
  FCurrentPage := FPdfDocument.AddPage;

  if (Orientation = poPortrait) then
  begin
    PageSize.cx := 595;
    PageSize.cy := 842;
  end else
  begin
    PageSize.cx := 842;
    PageSize.cy := 595;
  end;
  FCurrentPage.Size := PageSize;
end;

function TPdfPrinterEh.GetPixelsPerInchX: Integer;
begin
  Result := Canvas.PixelsPerInchX;
end;

function TPdfPrinterEh.GetPixelsPerInchY: Integer;
begin
  Result := Canvas.PixelsPerInchY;
end;

function TPdfPrinterEh.GetTitle: String;
begin
  Result := FTitle;
end;

procedure TPdfPrinterEh.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

function TPdfPrinterEh.GetPageNumber: Integer;
begin
  Result := 1;
end;

function TPdfPrinterEh.GetPageWidth: Integer;
begin
  Result := Round(CurrentPage.Size.Width * Canvas.FLogicalPPIFactor);
end;

function TPdfPrinterEh.GetFullPageWidth: Integer;
begin
  Result := GetPageWidth;
end;

function TPdfPrinterEh.GetPageHeight: Integer;
begin
  Result := Round(CurrentPage.Size.Height * Canvas.FLogicalPPIFactor);
end;

function TPdfPrinterEh.GetAborted: Boolean;
begin
  Result := False;
end;

function TPdfPrinterEh.GetFullPageHeight: Integer;
begin
  Result := GetPageHeight;
end;

function TPdfPrinterEh.GetOrientation: TPrinterOrientation;
begin
  Result := FOrientation;
end;

procedure TPdfPrinterEh.SetOrientation(const Value: TPrinterOrientation);
begin
  FOrientation := Value;
end;

{ TPdfPrinterCanvasEh }

constructor TPdfPrinterCanvasEh.Create(AVirtualPrinter: TBaseVirtualPrinter);
begin
  inherited Create(AVirtualPrinter);

  FFont := TFont.Create;
  FPen := TPen.Create;
  FBrush := TBrush.Create;

  FPhysicalPPI := 72;
  FLogicalPPIFactor := 20;
  FOrigin := CreatePoint(0, 0);
  FScaleX := 1;
  FScaleY := 1;
end;

destructor TPdfPrinterCanvasEh.Destroy;
begin
  FFont.Free;
  FPen.Free;
  FBrush.Free;

  inherited Destroy;
end;

procedure TPdfPrinterCanvasEh.PreparePdfCanvas(CanvasOperation: TPdfCanvasOperationKindEh; UseScale: Boolean);
var
  XGrp: TPdgGraphicsEh;
  XFontStyle: TPdgFontStylesEh;
  AScale: Double;
begin
  if (UseScale)
    then AScale := FScaleY
    else AScale := 1;

  XGrp := Printer.CurrentPage.Graphics;
  XGrp.Font.Name := Font.Name;
  XGrp.Font.Size := GetFontSize(Font) * AScale;

  XFontStyle := [];
  if (TFontStyle.fsBold in Font.Style) then
    XFontStyle := XFontStyle + [TPdgFontStyleEh.Bold];
  if (TFontStyle.fsItalic in Font.Style) then
    XFontStyle := XFontStyle + [TPdgFontStyleEh.Italic];
  if (TFontStyle.fsUnderline in Font.Style) then
    XFontStyle := XFontStyle + [TPdgFontStyleEh.Underline];
  if (TFontStyle.fsStrikeOut  in Font.Style) then
    XFontStyle := XFontStyle + [TPdgFontStyleEh.Strikeout];

  XGrp.Font.Style := XFontStyle;

  XGrp.Stroke.Width := Pen.Width / FLogicalPPIFactor * AScale;
  XGrp.Stroke.Color := Pen.Color;

  if CanvasOperation = TPdfCanvasOperationKindEh.Fill then
  begin
    XGrp.Brush.Color := Brush.Color;
  end
  else if CanvasOperation = TPdfCanvasOperationKindEh.Text then
  begin
    XGrp.Brush.Color := Font.Color;
  end;
end;

function TPdfPrinterCanvasEh.GetBrush: TBrush;
begin
  Result := FBrush;
end;

function TPdfPrinterCanvasEh.GetCopyMode: TCopyMode;
begin
  Result := FCopyMode;
end;

function TPdfPrinterCanvasEh.GetFont: TFont;
begin
  Result := FFont;
end;

function TPdfPrinterCanvasEh.GetPen: TPen;
begin
  Result := FPen;
end;

function TPdfPrinterCanvasEh.GetPrinter: TPdfPrinterEh;
begin
  Result := TPdfPrinterEh(inherited Printer);
end;

procedure TPdfPrinterCanvasEh.SetBrush(const Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TPdfPrinterCanvasEh.SetCopyMode(const Value: TCopyMode);
begin
  FCopyMode := Value;
end;

procedure TPdfPrinterCanvasEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TPdfPrinterCanvasEh.SetPen(const Value: TPen);
begin
  FPen.Assign(Value);
end;

function TPdfPrinterCanvasEh.PointToPdfGrPoint(APoint: TPoint): TPointF;
begin
  Result.X := (APoint.X + FOrigin.X) / FLogicalPPIFactor * FScaleX;
  Result.Y := (APoint.Y + FOrigin.Y) / FLogicalPPIFactor * FScaleY;
end;

function TPdfPrinterCanvasEh.RectToPdfGrRect(const ARect: TRect): TRectF;
begin
  Result.Left := (ARect.Left + FOrigin.X) / FLogicalPPIFactor * FScaleX;
  Result.Top := (ARect.Top + FOrigin.Y) / FLogicalPPIFactor * FScaleY;
  Result.Right := (ARect.Right + FOrigin.X) / FLogicalPPIFactor * FScaleX;
  Result.Bottom := (ARect.Bottom + FOrigin.Y) / FLogicalPPIFactor * FScaleY;
end;

procedure TPdfPrinterCanvasEh.Rectangle(X1, Y1, X2, Y2: Integer);
begin
  if (Brush.Style = bsSolid) then
    FillRect(Rect(X1, Y1, X2, Y2));

  Polyline([Point(X1, Y1), Point(X2, Y1), Point(X2, Y2), Point(X1, Y2), Point(X1, Y1)]);
end;

procedure TPdfPrinterCanvasEh.Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte);
begin
  Draw(X, Y, Graphic);
end;

procedure TPdfPrinterCanvasEh.StretchDraw(const Rect: TRect; Graphic: TGraphic);
var
  XGrp: TPdgGraphicsEh;
  RectF: TRectF;
begin
  XGrp := Printer.CurrentPage.Graphics;
  RectF := RectToPdfGrRect(Rect);

  XGrp.DrawGraphic(Graphic, RectF);
end;

procedure TPdfPrinterCanvasEh.Draw(X, Y: Integer; Graphic: TGraphic);
var
  XGrp: TPdgGraphicsEh;
  RectF: TRectF;
  GrRect: TRect;
begin
  XGrp := Printer.CurrentPage.Graphics;
  GrRect := Rect(X, Y, X + Graphic.Width, Y + Graphic.Height);
  RectF := RectToPdfGrRect(GrRect);

  XGrp.DrawGraphic(Graphic, RectF);
end;

function TPdfPrinterCanvasEh.TextExtent(const Text: string): TSize;
var
  XGraphics: TPdgGraphicsEh;
  TextSize: TSizeF;
begin
  PreparePdfCanvas(TPdfCanvasOperationKindEh.Text, False);

  XGraphics := Printer.FCurrentPage.Graphics;
  TextSize := XGraphics.TextExtent(Text);
  Result.cx := Round(TextSize.Width * FLogicalPPIFactor);
  Result.cy := Round(TextSize.Height * FLogicalPPIFactor);
end;

function TPdfPrinterCanvasEh.CalcTextSize(const Text: String;
  InitRectWidth: Integer; WordWrap: Boolean): TSize;
var
  XGraphics: TPdgGraphicsEh;
  InitRectWidthF: Double;
  ResultF: TSizeF;
begin
  PreparePdfCanvas(TPdfCanvasOperationKindEh.Text, False);
  XGraphics := Printer.FCurrentPage.Graphics;
  InitRectWidthF := InitRectWidth / FLogicalPPIFactor;
  ResultF := XGraphics.CalcTextSize(Text, InitRectWidthF, WordWrap);
  Result.cx := Round(ResultF.Width * FLogicalPPIFactor);
  Result.cy := Round(ResultF.Height * FLogicalPPIFactor);
end;

procedure TPdfPrinterCanvasEh.TextRect(var ARect: TRect; var Text: string; TextFormat: TTextFormat);
var
  XGraphics: TPdgGraphicsEh;
  RectF: TRectF;
  Alignment: TAlignment;
  VertAlignment: TVerticalAlignment;
  WordWrap: Boolean;
  ATextSize: TSize;
begin
  if tfCalcRect in TextFormat then
  begin
    ATextSize := CalcTextSize(Text, RectWidth(ARect), tfWordBreak in TextFormat);
    if ATextSize.cx > RectWidth(ARect) then
      ARect.Right := ARect.Left + ATextSize.cx;
    if ATextSize.cy > RectHeight(ARect) then
      ARect.Bottom := ARect.Top + ATextSize.cy;
    Exit;
  end;

  PreparePdfCanvas(TPdfCanvasOperationKindEh.Text, True);
  XGraphics := Printer.FCurrentPage.Graphics;

  RectF := RectToPdfGrRect(ARect);

  if tfCenter in TextFormat then
    Alignment := TAlignment.taCenter
  else if tfRight in TextFormat then
    Alignment := TAlignment.taRightJustify
  else
    Alignment := TAlignment.taLeftJustify;


  if tfVerticalCenter in TextFormat then
    VertAlignment := TVerticalAlignment.taVerticalCenter
  else if tfBottom  in TextFormat then
    VertAlignment := TVerticalAlignment.taAlignBottom
  else
    VertAlignment := TVerticalAlignment.taAlignTop;

  WordWrap := tfWordBreak in TextFormat;

  XGraphics.DrawString(Text, RectF, Alignment, VertAlignment, WordWrap);
end;

procedure TPdfPrinterCanvasEh.VerticalTextRect(var ARect: TRect; var Text: string; TextFormat: TTextFormat = []);
var
  XGraphics: TPdgGraphicsEh;
  DrawOptions: TDrawTextOptionsEh;
  RectF: TRectF;
  ATextRectPos: TPoint;
  ATextRectSize: TSize;
  ARotatedTextRect: TRect;
begin
  PreparePdfCanvas(TPdfCanvasOperationKindEh.Text, True);
  XGraphics := Printer.FCurrentPage.Graphics;

  ATextRectPos := ARect.TopLeft;
  ATextRectSize.cx := RectWidth(ARect);
  ATextRectSize.cy := RectHeight(ARect);

  ARotatedTextRect := Rect(
    Printer.PageHeight - ATextRectPos.Y - ATextRectSize.cy,
    Printer.PageHeight + ATextRectPos.X,
    Printer.PageHeight - ATextRectPos.Y - ATextRectSize.cy + ATextRectSize.cy,
    Printer.PageHeight + ATextRectPos.X + ATextRectSize.cx
  );

  RectF := RectToPdfGrRect(ARotatedTextRect);

  DrawOptions.Clear;

  if tfCenter in TextFormat then
    DrawOptions.HorzAlignment := TAlignment.taCenter
  else if tfRight in TextFormat then
    DrawOptions.HorzAlignment := TAlignment.taRightJustify
  else
    DrawOptions.HorzAlignment := TAlignment.taLeftJustify;

  if tfVerticalCenter in TextFormat then
    DrawOptions.VertAlignment := TVerticalAlignment.taVerticalCenter
  else if tfBottom  in TextFormat then
    DrawOptions.VertAlignment := TVerticalAlignment.taAlignBottom
  else
    DrawOptions.VertAlignment := TVerticalAlignment.taAlignTop;

  RotationDegree := 90;
  XGraphics.DrawText(Text, RectF, DrawOptions);
  RotationDegree := 0;
end;

procedure TPdfPrinterCanvasEh.GetTextMetrics(out tm: TTextMetric);
var
  PdfFont: TPdfType0FontEh;
  OutlineTextmetric: TOutlineTextmetric;
  Factor: Double;
  FontSize: Integer;
begin
  PreparePdfCanvas(TPdfCanvasOperationKindEh.Text, False);
  PdfFont := Printer.FCurrentPage.Graphics.GetCurrentPdfFont;
  OutlineTextmetric := PdfFont.OutlineTextmetric;
  FontSize := GetFontSize(Font);
  Factor := PdfFont.UnitsPerEm / (FontSize * FLogicalPPIFactor);

  tm.tmHeight := Round(OutlineTextmetric.otmTextMetrics.tmHeight / Factor);
  tm.tmAscent := Round(OutlineTextmetric.otmTextMetrics.tmAscent / Factor);
  tm.tmDescent := Round(OutlineTextmetric.otmTextMetrics.tmDescent / Factor);
  tm.tmInternalLeading := Round(OutlineTextmetric.otmTextMetrics.tmInternalLeading / Factor);
  tm.tmExternalLeading := Round(OutlineTextmetric.otmTextMetrics.tmExternalLeading / Factor);
  tm.tmAveCharWidth := Round(OutlineTextmetric.otmTextMetrics.tmAveCharWidth / Factor);
  tm.tmMaxCharWidth := Round(OutlineTextmetric.otmTextMetrics.tmMaxCharWidth / Factor);
  tm.tmWeight := Round(OutlineTextmetric.otmTextMetrics.tmWeight / Factor);
  tm.tmOverhang := Round(OutlineTextmetric.otmTextMetrics.tmOverhang / Factor);
  tm.tmDigitizedAspectX := Round(OutlineTextmetric.otmTextMetrics.tmDigitizedAspectX / Factor);
  tm.tmDigitizedAspectY := Round(OutlineTextmetric.otmTextMetrics.tmDigitizedAspectY / Factor);

  tm.tmFirstChar := OutlineTextmetric.otmTextMetrics.tmFirstChar;
  tm.tmLastChar := OutlineTextmetric.otmTextMetrics.tmLastChar;
  tm.tmDefaultChar := OutlineTextmetric.otmTextMetrics.tmDefaultChar;
  tm.tmBreakChar := OutlineTextmetric.otmTextMetrics.tmBreakChar;
  tm.tmItalic := OutlineTextmetric.otmTextMetrics.tmItalic;
  tm.tmUnderlined := OutlineTextmetric.otmTextMetrics.tmUnderlined;
  tm.tmStruckOut := OutlineTextmetric.otmTextMetrics.tmStruckOut;
  tm.tmPitchAndFamily := OutlineTextmetric.otmTextMetrics.tmPitchAndFamily;
  tm.tmCharSet := OutlineTextmetric.otmTextMetrics.tmCharSet;
end;

procedure TPdfPrinterCanvasEh.MoveTo(X, Y: Integer);
begin
  FLineToPos := Point(X, Y);
end;

procedure TPdfPrinterCanvasEh.LineTo(X, Y: Integer);
begin
  Polyline([FLineToPos, Point(X, Y)]);
end;

procedure TPdfPrinterCanvasEh.Polyline(const Points: array of TPoint);
var
  XGraphics: TPdgGraphicsEh;
  I: Integer;
  StartPos, FinishPos: TPointF;
begin
  if Length(Points) <= 1 then Exit;

  PreparePdfCanvas(TPdfCanvasOperationKindEh.Stroke, True);
  XGraphics := Printer.FCurrentPage.Graphics;

  StartPos := PointToPdfGrPoint(Points[0]);

  for I := 1 to Length(Points)-1 do
  begin
    FinishPos := PointToPdfGrPoint(Points[I]);
    XGraphics.DrawLine(StartPos.X, StartPos.Y, FinishPos.X, FinishPos.Y);
    StartPos := FinishPos;
  end;
end;

procedure TPdfPrinterCanvasEh.FillRect(const ARect: TRect);
var
  XGraphics: TPdgGraphicsEh;
  RectF: TRectF;
begin
  PreparePdfCanvas(TPdfCanvasOperationKindEh.Fill, True);
  XGraphics := Printer.FCurrentPage.Graphics;
  RectF := RectToPdfGrRect(ARect);

  XGraphics.FillRect(RectF);
end;

function TPdfPrinterCanvasEh.GetPixelsPerInchX: Integer;
begin
  Result := FPhysicalPPI * FLogicalPPIFactor; // 20 * 72 = 1440
end;

function TPdfPrinterCanvasEh.GetPixelsPerInchY: Integer;
begin
  Result := FPhysicalPPI * FLogicalPPIFactor; // 20 * 72 = 1440
end;

procedure TPdfPrinterCanvasEh.SetCanvasOrigin(xOrg, yOrg: Integer);
begin
  FOrigin := Point(xOrg, yOrg);
end;

procedure TPdfPrinterCanvasEh.SetCanvasScale(xMult, xDivd, yMult, yDivd: Integer);
begin
  FScaleXMult := xMult;
  FScaleXDivd := xDivd;
  FScaleYMult := yMult;
  FScaleYDivd := yDivd;

  FScaleX := FScaleXMult / FScaleXDivd;
  FScaleY := FScaleYMult / FScaleYDivd;
end;

function TPdfPrinterCanvasEh.GetRotationDegree: Single;
var
  XGraphics: TPdgGraphicsEh;
begin
  XGraphics := Printer.FCurrentPage.Graphics;
  Result := XGraphics.RotationDegree;
end;

procedure TPdfPrinterCanvasEh.SetRotationDegree(const Value: Single);
var
  XGraphics: TPdgGraphicsEh;
begin
  XGraphics := Printer.FCurrentPage.Graphics;
  XGraphics.RotationDegree := Value;
end;

procedure TPdfPrinterCanvasEh.AppendClipRect(AClipRect: TRect);
var
  XGraphics: TPdgGraphicsEh;
  RectF: TRectF;
begin
  XGraphics := Printer.FCurrentPage.Graphics;
  RectF := RectToPdfGrRect(AClipRect);
  XGraphics.IntersectClipRect(RectF);
end;

procedure TPdfPrinterCanvasEh.RestoreClip;
var
  XGraphics: TPdgGraphicsEh;
begin
  XGraphics := Printer.FCurrentPage.Graphics;
  XGraphics.RestoreClip;
end;

procedure TPdfPrinterCanvasEh.DrawRtfText(RichText: String; FirstPageBlockTop,
  NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer;
  out Pages, LastPageBlockHeight: Integer);
begin
  InternalDrawRtfText(RichText,
    FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight,
    False, Pages, LastPageBlockHeight);
end;

procedure TPdfPrinterCanvasEh.MeasureRtfTextLayout(RichText: String;
  FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft,
  BlockRight: Integer; out Pages, LastPageBlockHeight: Integer);
begin
  InternalDrawRtfText(RichText,
    FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight,
    True, Pages, LastPageBlockHeight);
end;

procedure TPdfPrinterCanvasEh.InternalDrawRtfText(RichText: String;
  FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft,
  BlockRight: Integer; MeasureLayout: Boolean;
  out Pages, LastPageBlockHeight: Integer);
{$IFDEF FPC}
begin
  Pages := 0;
  LastPageBlockHeight := 0;
end;
{$ELSE}
var
  Renderer: TRichTextRenderer;
begin
  Pages := 0;
  LastPageBlockHeight := 0;

  if RichText = '' then Exit;

  BufferedRichEdit.RtfText := RichText;

  Renderer := TRichTextRenderer.Create(BufferedRichEdit, Self,
    FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight);

  while not Renderer.EndOfTextReached do
  begin
    if MeasureLayout
      then Renderer.MeasureBlock()
      else Renderer.RenderBlock();

    if (Renderer.EndOfPageReached) then
    begin
      Renderer.InitForNewPage;
      if MeasureLayout
        then DoNothing
        else PdfPrinter.NewPage;
    end;

    LastPageBlockHeight := Renderer.CurPageNextVertPos - Renderer.CurPageStartVertPos;
    Inc(Pages);
  end;

  Renderer.Free;
  BufferedRichEdit.RtfText := '';
end;
{$ENDIF}


initialization
finalization
  FreePdfPrinter;
  FreeBufferedRichEdit;
end.
