{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                 Utils to print Data                   }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrintUtilsEh;

interface

{$I EhLib.Inc}

uses
  SysUtils, Classes, Graphics, Controls,
  Types,
{$IFDEF EH_LIB_17} System.UITypes, System.Contnrs, {$ENDIF}
{$IFDEF FPC}
  EhLibLCL,
{$ELSE}
  PrViewEh, EhLibVCL, Windows, Messages, RichEdit,
{$ENDIF}
  DynVarsEh, ComCtrls,
  StdCtrls, ImgList, Forms, DB,
  Printers,
  DBCtrlsEh, PrntsEh, GridsEh, ToolCtrlsEh;

type
  TBaseGridPrintServiceEh = class;

  TPageColontitleLineTypeEh = (pcltNonEh, pcltSingleLineEh, pcltDoubleLineEh);
  TMeasurementSystemEh = (msMetricEh, msUnitedStatesEh);
  TPrintColotSchemaEh = (pcsFullColorEh, pcsAdaptedColorEh, pcsBlackAndWhiteEh);

  TPageColontitleEh = class(TPersistent)
  private
    FCenterText: TRichStringEh;
    FLeftText: TRichStringEh;
    FLineType: TPageColontitleLineTypeEh;
    FRightText: TRichStringEh;

    procedure SetCenterText(const Value: TRichStringEh);
    procedure SetLeftText(const Value: TRichStringEh);
    procedure SetLineType(const Value: TPageColontitleLineTypeEh);
    procedure SetRightText(const Value: TRichStringEh);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

  published
    property LineType: TPageColontitleLineTypeEh read FLineType write SetLineType default pcltNonEh;

    property CenterText: TRichStringEh read FCenterText write SetCenterText;
    property LeftText: TRichStringEh read FLeftText write SetLeftText;
    property RightText: TRichStringEh read FRightText write SetRightText;
  end;

{ TPageMarginsEh }

  TPageMarginsEh = class(TPersistent)
  private
    FBottom: Currency;
    FFooter: Currency;
    FHeader: Currency;
    FLeft: Currency;
    FRight: Currency;
    FTop: Currency;

    function IsBottomStored: Boolean;
    function IsFooterStored: Boolean;
    function IsHeaderStored: Boolean;
    function IsLeftStored: Boolean;
    function IsRightStored: Boolean;
    function IsTopStored: Boolean;
    function GetCurRegionalMetricBottom: Currency;
    function GetCurRegionalMetricFooter: Currency;
    function GetCurRegionalMetricHeader: Currency;
    function GetCurRegionalMetricLeft: Currency;
    function GetCurRegionalMetricRight: Currency;
    function GetCurRegionalMetricTop: Currency;

    procedure SetCurRegionalMetricBottom(const Value: Currency);
    procedure SetCurRegionalMetricFooter(const Value: Currency);
    procedure SetCurRegionalMetricHeader(const Value: Currency);
    procedure SetCurRegionalMetricLeft(const Value: Currency);
    procedure SetCurRegionalMetricRight(const Value: Currency);
    procedure SetCurRegionalMetricTop(const Value: Currency);

  public
    constructor Create;
    destructor Destroy; override;

    property CurRegionalMetricLeft: Currency read GetCurRegionalMetricLeft write SetCurRegionalMetricLeft;
    property CurRegionalMetricRight: Currency read GetCurRegionalMetricRight write SetCurRegionalMetricRight;
    property CurRegionalMetricTop: Currency read GetCurRegionalMetricTop write SetCurRegionalMetricTop;
    property CurRegionalMetricBottom: Currency read GetCurRegionalMetricBottom write SetCurRegionalMetricBottom;

    property CurRegionalMetricHeader: Currency read GetCurRegionalMetricHeader write SetCurRegionalMetricHeader;
    property CurRegionalMetricFooter: Currency read GetCurRegionalMetricFooter write SetCurRegionalMetricFooter;

  published
    property Bottom: Currency read FBottom write FBottom stored IsBottomStored;
    property Left: Currency read FLeft write FLeft stored IsLeftStored;
    property Right: Currency read FRight write FRight stored IsRightStored;
    property Top: Currency read FTop write FTop stored IsTopStored;

    property Header: Currency read FHeader write FHeader stored IsHeaderStored;
    property Footer: Currency read FFooter write FFooter stored IsFooterStored;
  end;

  TScalingModeEh = (smAdjustToScaleEh, smFitToPagesEh);

{ TBasePrintServiceComponentEh }

  TBasePrintServiceComponentEh = class(TComponent)
  private
    FColorSchema: TPrintColotSchemaEh;
    FFitToPagesTall: Integer;
    FFitToPagesWide: Integer;
    FLogDataPrintRec: TRect;
    FLogPelsXOnControl: Integer;
    FLogPelsXOnPrinter: Integer;
    FLogPelsYOnControl: Integer;
    FLogPelsYOnPrinter: Integer;
    FOrientation: TPrinterOrientation;
    FPageCount: Integer;
    FPageFooter: TPageColontitleEh;
    FPageHeader: TPageColontitleEh;
    FPageMargins: TPageMarginsEh;
    FPenW: Integer;
    FPhysDataPrintRec: TRect;
    FPrintDataScale: Integer;
    FPrinter: TBaseVirtualPrinter;
    FPrnPhysOffSetX: Integer;
    FPrnPhysOffSetY: Integer;
    FScale: Integer;
    FScaleX, FScaleY: Double;
    FScalingMode: TScalingModeEh;
    {$IFDEF FPC}
    {$ELSE}
    FSubstituteRichEdit: TDBRichEditEh;
    {$ENDIF}
    FSubstitutionVars: TDynVarsEh;
    FTextAfterContent: TRichStringEh;
    FTextBeforeContent: TRichStringEh;

    FOnAfterPrint: TNotifyEvent;
    FOnAfterPrintPage: TNotifyEvent;
    FOnBeforePrint: TNotifyEvent;
    FOnBeforePrintPage: TNotifyEvent;
    FOnPrinterSetupDialog: TNotifyEvent;
    FOnAfterPrintPageContent: TNotifyEvent;
    FOnBeforePrintPageContent: TNotifyEvent;

    function GetCanvas: TBasePrinterCanvas;
    {$IFDEF FPC}
    {$ELSE}
    function GetSubstituteRichEdit: TDBRichEditEh;
    {$ENDIF}
    function GetPageHeight: Integer;
    function GetPageWidth: Integer;

    procedure SetPageFooter(const Value: TPageColontitleEh);
    procedure SetPageHeader(const Value: TPageColontitleEh);
    procedure SetPageMargins(const Value: TPageMarginsEh);
    procedure SetTextAfterContent(const Value: TRichStringEh);
    procedure SetTextBeforeContent(const Value: TRichStringEh);


  protected
    MacroValues: array[0..5] of String;

    function GetControlCanvas: TCanvas; virtual;
    function ExtractMacros(s: TRichStringEh): TRichStringEh;
    function SubstituteRichTextVar(RichText: TRichStringEh; const SearchStr, ReplaceStr: String; StartPos, Length: Integer; Options: TSearchTypes; ReplaceAll: Boolean; var FoundPos: Integer): TRichStringEh;
    function SubstituteVars(RichText: TRichStringEh): TRichStringEh;

    procedure InitData; virtual;
    procedure PrintData; virtual;
    procedure PrintPageOutClientData; virtual;
    procedure PreparePageInClientData; virtual;
    procedure PrintPageInClientData; virtual;

    procedure CalcDeviceCaps; virtual;
    procedure SetPrinterSetupDialog; virtual;
    procedure PrintPageHeader; virtual;
    procedure PrintPageFooter; virtual;
    procedure PrintColontitle(Colontitle: TPageColontitleEh; ARect: TRect; Layout: TTextLayout); virtual;
    procedure PrintColontitleLine(Colontitle: TPageColontitleEh; var ARect: TRect; Layout: TTextLayout); virtual;
    procedure InitMacroValues; virtual;
    procedure StartPrint; virtual;
    procedure EndPrint; virtual;
    procedure NewPage; virtual;
    procedure InitPageViewMode; virtual;
    procedure ResetPageViewMode; virtual;

    property ColorSchema: TPrintColotSchemaEh read FColorSchema write FColorSchema default pcsAdaptedColorEh;
    property FitToPagesTall: Integer read FFitToPagesTall write FFitToPagesTall default 1;
    property FitToPagesWide: Integer read FFitToPagesWide write FFitToPagesWide default 1;
    property Orientation: TPrinterOrientation read FOrientation write FOrientation default poPortrait;
    property PageFooter: TPageColontitleEh read FPageFooter write SetPageFooter;
    property PageHeader: TPageColontitleEh read FPageHeader write SetPageHeader;
    property PageMargins: TPageMarginsEh read FPageMargins write SetPageMargins;
    property Scale: Integer read FScale write FScale default 100;
    property ScalingMode: TScalingModeEh read FScalingMode write FScalingMode default smAdjustToScaleEh;
    property TextAfterContent: TRichStringEh read FTextAfterContent write SetTextAfterContent;
    property TextBeforeContent: TRichStringEh read FTextBeforeContent write SetTextBeforeContent;
    {$IFDEF FPC}
    {$ELSE}
    property SubstituteRichEdit: TDBRichEditEh read GetSubstituteRichEdit;
    {$ENDIF}

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {$IFDEF FPC}
    {$ELSE}
    procedure Preview; virtual;
    {$ENDIF}
    procedure Print; virtual;
    procedure PrintTo(VPrinter: TBaseVirtualPrinter); virtual;
    procedure PrintToPdfFile(AFileName: String); virtual;

    property Canvas: TBasePrinterCanvas read GetCanvas;
    property ControlCanvas: TCanvas read GetControlCanvas;
    property SubstitutionVars: TDynVarsEh read FSubstitutionVars;

    property LogDataPrintRec: TRect read FLogDataPrintRec write FLogDataPrintRec;
    property PenW: Integer read FPenW write FPenW;
    property PhysDataPrintRec: TRect read FPhysDataPrintRec write FPhysDataPrintRec;
    property Printer: TBaseVirtualPrinter read FPrinter;
    property PrnPhysOffSetX: Integer read FPrnPhysOffSetX write FPrnPhysOffSetX;
    property PrnPhysOffSetY: Integer read FPrnPhysOffSetY write FPrnPhysOffSetY;
    property ScaleX: Double read FScaleX write FScaleX;
    property ScaleY: Double read FScaleY write FScaleY;
    property PrintDataScale: Integer read FPrintDataScale write FPrintDataScale;
    property LogPelsXOnControl: Integer read FLogPelsXOnControl write FLogPelsXOnControl;
    property LogPelsYOnControl: Integer read FLogPelsYOnControl write FLogPelsYOnControl;
    property LogPelsXOnPrinter: Integer read FLogPelsXOnPrinter write FLogPelsXOnPrinter;
    property LogPelsYOnPrinter: Integer read FLogPelsYOnPrinter write FLogPelsYOnPrinter;
    property PageCount: Integer read FPageCount write FPageCount;
    property PageHeight: Integer read GetPageHeight;
    property PageWidth: Integer read GetPageWidth;

    property OnAfterPrint: TNotifyEvent read FOnAfterPrint write FOnAfterPrint;
    property OnAfterPrintPage: TNotifyEvent read FOnAfterPrintPage write FOnAfterPrintPage;
    property OnAfterPrintPageContent: TNotifyEvent read FOnAfterPrintPageContent write FOnAfterPrintPageContent;

    property OnBeforePrint: TNotifyEvent read FOnBeforePrint write FOnBeforePrint;
    property OnBeforePrintPage: TNotifyEvent read FOnBeforePrintPage write FOnBeforePrintPage;
    property OnBeforePrintPageContent: TNotifyEvent read FOnBeforePrintPageContent write FOnBeforePrintPageContent;
    property OnPrinterSetupDialog: TNotifyEvent read FOnPrinterSetupDialog write FOnPrinterSetupDialog;
  end;

  TPrintPageDataMode = (ppdmPrintDataEh, ppdmLayoutDataEh);

  TPrintServicePrintDataBeforeGridEventEh = procedure(PrintService: TBaseGridPrintServiceEh;
    var BeforeGridHeight, FullHeight: Integer; var Processed: Boolean) of object;
  TPrintServiceCalcLayoutDataBeforeGridEventEh = procedure(PrintService: TBaseGridPrintServiceEh;
    var BeforeGridHeight, FullHeight: Integer; var Processed: Boolean) of object;

  TPrintServicePrintDataAfterGridEventEh = procedure(PrintService: TBaseGridPrintServiceEh;
    var AfterGridHeight, FullHeight: Integer; var Processed: Boolean) of object;
  TPrintServiceCalcLayoutDataAfterGridEventEh = procedure(PrintService: TBaseGridPrintServiceEh;
    var AfterGridHeight, FullHeight: Integer; var Processed: Boolean) of object;

  TBaseGridPrintServiceEh = class(TBasePrintServiceComponentEh)
  private
    FGridLogRect: TRect;

    FOnPrintDataBeforeGrid: TPrintServicePrintDataBeforeGridEventEh;
    FOnCalcLayoutDataBeforeGrid: TPrintServiceCalcLayoutDataBeforeGridEventEh;
    FOnPrintDataAfterGrid: TPrintServicePrintDataAfterGridEventEh;
    FOnCalcLayoutDataAfterGrid: TPrintServiceCalcLayoutDataAfterGridEventEh;

    {$IFDEF FPC}
    {$ELSE}
    function GetBefortAfterRichText: TDBRichEditEh;
    {$ENDIF}

  protected
    ColWidths: TIntegerDynArray;
    FAfterGridFullHeight: Integer;
    FAfterGridOnPageHeight: Integer;
    FBeforeGridFullHeight: Integer;
    FBeforeGridOnPageHeight: Integer;
    {$IFDEF FPC}
    {$ELSE}
    FBefortAfterRichText: TDBRichEditEh;
    {$ENDIF}
    FColsPageCount, FRowsPageCount: Integer;
    FExtraPageCount: Integer;
    FPageDrawenCells: array of TGridCoord;
    FPageFinishCol: Integer;
    FPageFinishRow: Integer;
    FPageStartCol: Integer;
    FPageStartRow: Integer;
    FPrintPageMode: TPrintPageDataMode;
    PageStartCols: TIntegerDynArray;
    PageStartRows: TIntegerDynArray;
    RowHeights: TIntegerDynArray;

    function CheckDrawLine(ACol, ARow: Integer; BorderType: TGridCellBorderTypeEh; var Color: TColor; var Width: Integer): Boolean; virtual;
    function AdjustBackgroundColor(Color: TColor): TColor;
    function AdjustForegroundColor(Color: TColor): TColor;

    procedure DrawAxisLine(LineRect: TRect; BorderType: TGridCellBorderTypeEh; BorderColor: TColor; BorderWidth: Integer; FarFix: Integer); virtual;
    procedure DrawLine(FromPoint, ToPoint: TPoint; BorderWidth: Integer); virtual;
    procedure GetLinePos(LineRect: TRect; BorderType: TGridCellBorderTypeEh; BorderWidth: Integer; var FromPoint, ToPoint: TPoint); virtual;
    procedure PrintBorders(ACol, ARow: Integer; var ARect: TRect; Borders: TGridCellBorderTypesEh); virtual;
    procedure PrintCell(ACol, ARow: Integer; ARect: TRect); virtual;
    procedure PrintCellData(ACol, ARow: Integer; ARect: TRect); virtual;
    procedure PrintLeftTopBorders(ACol, ARow: Integer; ARect: TRect; Borders: TGridCellBorderTypesEh); virtual;
    procedure ResetPrinterCanvas;
    procedure InitPageViewMode; override;

    procedure SetPrinterSetupDialog; override;
    procedure PrinterSetupDialogPreview(Sender: TObject); virtual;
    procedure InitData; override;
    procedure PrintData; override;
    procedure PrintPageOutClientData; override;
    procedure PreparePageInClientData; override;
    procedure PrintPageInClientData; override;
    procedure RecalcBeforeAfterPageData; virtual;

    procedure ScaleToPages(FitToPagesTall, FitToPagesWide: Integer); virtual;
    procedure SetDataScale;

    function LogRectToPhysRect(const ARect: TRect): TRect; virtual;
    function CheckCellAreaDrawn(ACol, ARow: Integer): Boolean; virtual;

    procedure SetColRowSize; virtual;
    procedure PrintGrid; virtual;
    procedure PrintPageCells(FromCol, ToCol, FromRow, ToRow: Integer; const CellsRect: TRect); virtual;
    procedure CalcPageColsRows; virtual;
    procedure PrintDataBeforeGrid; virtual;
    procedure PrintDataAfterGrid; virtual;
    procedure PrintDataRichOutContent(const RichText: TRichStringEh; var BeforeGridHeight, AfterGridHeight, FullHeight: Integer); virtual;

    procedure SetCellDrawn(ACol, ARow: Integer); virtual;

    property GridLogRect: TRect read FGridLogRect write FGridLogRect;
    {$IFDEF FPC}
    {$ELSE}
    property BefortAfterRichText: TDBRichEditEh read GetBefortAfterRichText;
    {$ENDIF}

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DefaultPrintDataBeforeGrid(var BeforeGridHeight, FullHeight: Integer);
    procedure DefaultCalcLayoutDataBeforeGrid(var BeforeGridHeight, FullHeight: Integer);
    procedure DefaultPrintDataAfterGrid(var AfterGridHeight, FullHeight: Integer);
    procedure DefaultCalcLayoutDataAfterGrid(var AfterGridHeight, FullHeight: Integer);

    property OnPrintDataBeforeGrid: TPrintServicePrintDataBeforeGridEventEh read FOnPrintDataBeforeGrid write FOnPrintDataBeforeGrid;
    property OnCalcLayoutDataBeforeGrid: TPrintServiceCalcLayoutDataBeforeGridEventEh read FOnCalcLayoutDataBeforeGrid write FOnCalcLayoutDataBeforeGrid;
    property OnPrintDataAfterGrid: TPrintServicePrintDataAfterGridEventEh read FOnPrintDataAfterGrid write FOnPrintDataAfterGrid;
    property OnCalcLayoutDataAfterGrid: TPrintServiceCalcLayoutDataAfterGridEventEh read FOnCalcLayoutDataAfterGrid write FOnCalcLayoutDataAfterGrid;
  end;

  function GetLocaleMeasurementSystem(Locale: Integer): TMeasurementSystemEh;
  function LocaleMeasureValueToInches(Val: Currency): Currency;
  function InchesValueToLocaleMeasure(Val: Currency): Currency;

  procedure DrawRichTextEh(Canvas: TBasePrinterCanvas; const RichText: String; ARect: TRect);

const
  ColontileMacros: array[0..5] of String = (
    '&[Page]', '&[ShortDate]', '&[Date]', '&[LongDate]', '&[Time]', '&[Pages]');

function PrintTextEh(ACanvas: TBasePrinterCanvas; ARect: TRect; DX, DY: Integer;
  Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean;
  EndEllipsis: Boolean; AClipRect: TRect; CalcRect: Boolean;
  ARightToLeftAlignment, ARightToLeftReading: Boolean): Integer;

procedure PrintTreeElement(Canvas: TBasePrinterCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean; Coloured: Boolean);

procedure PrintPolyPolyLineEh(Canvas: TBasePrinterCanvas; const PointsList: TPointArrayEh;
  const StrokeList: TDWORDArrayEh; VCount: Integer);

function PrintGraphicField(Canvas: TBasePrinterCanvas; Field: TField;
  ARect: TRect; AClipRect: TRect;
  CalcRect: Boolean;
  ScaleX, ScaleY: Double): Integer;

function PrintTextVerticalEh(
                          ACanvas:TBasePrinterCanvas;
                          ARect: TRect;          
                          DX, DY: Integer;       
                          Text: string;    
                          Alignment: TAlignment; 
                          Layout: TTextLayout;   
                          MultyL: Boolean;
                          EndEllipsis: Boolean;   
                          CalcTextExtent: Boolean  
                          ): Integer;

implementation

uses
  {$IFDEF FPC}
  {$ELSE}
  BasePrintGridPageSetupDialogEh,
  {$ENDIF}
  Themes, PdfPrintersEh, Math;

function PrintTextEh(ACanvas: TBasePrinterCanvas; ARect: TRect; DX, DY: Integer;
  Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean;
  EndEllipsis: Boolean; AClipRect: TRect; CalcRect: Boolean;
  ARightToLeftAlignment, ARightToLeftReading: Boolean): Integer;
{$IFDEF WINDOWS}
const
  AlignFlags: array[TAlignment] of TTextFormat =
    ([tfLeft], [tfRight], [tfCenter]);
  RTL: array[Boolean] of TTextFormat = ([], [tfRtlReading]);
var
  rect1: TRect;
  txth: Integer;
  DrawFlag: TTextFormat;
  TextSize: TSize;
  RestoreClipIsNeeded: Boolean;
  BrushStyle: TBrushStyle;
begin

  Result := 0;
  if ARightToLeftAlignment then
  begin
    ChangeBiDiModeAlignment(Alignment);
  end;

  if CalcRect = False then
  begin

    if not EqualRect(ARect, AClipRect) then
    begin
      ACanvas.AppendClipRect(AClipRect);
      RestoreClipIsNeeded := True;
    end
    else
    begin
      RestoreClipIsNeeded := False;
    end;

    DrawFlag := [];
    if (MultyL = True) then
      DrawFlag := DrawFlag  + [tfWordBreak];
{$IFDEF EH_LIB_16} //Delphi XE2
    if (EndEllipsis = True) then
      DrawFlag := DrawFlag + [tfWordEllipsis];
{$ENDIF} //EH_LIB_16 //Delphi XE2
    DrawFlag := DrawFlag + [tfExpandTabs, tfNoPrefix] + AlignFlags[Alignment] + RTL[ARightToLeftReading];

    rect1.Left := 0; rect1.Top := 0; rect1.Right := 0; rect1.Bottom := 0;
    rect1 := ARect;

    //lpDTP.cbSize := SizeOf(lpDTP);
    //lpDTP.uiLengthDrawn := Length(Text);
    //lpDTP.iLeftMargin := LeftMarg;
    //lpDTP.iRightMargin := RightMarg;

    InflateRect(rect1, -DX, -DY);

    if (Layout <> tlTop) then
      txth := ACanvas.CalcTextSize(Text, RectWidth(ARect), MultyL).cy
    else
      txth := 0;

    rect1 := ARect;
    InflateRect(rect1, -DX, -DY);

    case Layout of
      tlTop: ;
      tlBottom: rect1.top := rect1.Bottom - txth;
      tlCenter: rect1.top := rect1.top + ((rect1.Bottom - rect1.top) div 2) - (txth div 2);
    end;

    if DX > 0 then
      rect1.Bottom := rect1.Bottom + 1;

    //WindowsDrawTextEx(ACanvas.Handle, Text, rect1, DrawFlag, lpDTP);
    BrushStyle := ACanvas.Brush.Style;
    ACanvas.Brush.Style := bsClear;

    ACanvas.TextRect(rect1, Text, DrawFlag);

    if (RestoreClipIsNeeded) then
      ACanvas.RestoreClip;
    if BrushStyle <> bsClear then
      ACanvas.Brush.Style := BrushStyle;

  end else
  begin
    Inc(ARect.Left, DX); Inc(ARect.Top, DY);
    Dec(ARect.Right, DX); Dec(ARect.Bottom, DY);
    TextSize := ACanvas.CalcTextSize(Text, RectWidth(ARect), MultyL);
    Result := TextSize.cy;
    Inc(Result, DY * 2);
  end;
end;
{$ELSE}
begin
  Result := 0;
end;
{$ENDIF} 

procedure PrintPolyPolyLineEh(Canvas: TBasePrinterCanvas; const PointsList: TPointArrayEh;
  const StrokeList: TDWORDArrayEh; VCount: Integer);
var
  I: Integer;
  Pos: Integer;
  Points: array of TPoint;
  J: Integer;
begin
  Pos := 0;
  for I := 0 to VCount-1 do
  begin
    SetLength(Points, StrokeList[I]);
    for J := 0 to StrokeList[I] - 1 do
      Points[J] := PointsList[Pos + J];

    Canvas.PolyLine(Points);
    Pos := Pos + Integer(StrokeList[i]);
  end;
end;

procedure PrintDotLine(Canvas: TBasePrinterCanvas; FromPoint: TPoint; ALength: Integer;
  Along: Boolean; BackDot: Boolean);
var
  Points: TPointArrayEh;
  StrokeList: TDWORDArrayEh;
  DotWidth, DotCount, I: Integer;
begin
  if Along then
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.X);
      Dec(ALength);
    end;
  end else
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.Y);
      Dec(ALength);
    end;
  end;

  DotWidth := Canvas.Pen.Width;
  DotCount := ALength div (2 * DotWidth);
  if DotCount < 0 then Exit;
  if ALength mod 2 <> 0 then
    Inc(DotCount);
  SetLength(Points, DotCount * 2);
  SetLength(StrokeList, DotCount);
  for I := 0 to DotCount - 1 do
    StrokeList[I] := 2;
  if Along then
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X + 1, FromPoint.Y);
      Inc(FromPoint.X, (2 * DotWidth));
    end
  else
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X, FromPoint.Y + 1);
      Inc(FromPoint.Y, (2 * DotWidth));
    end;

  PrintPolyPolyLineEh(Canvas, Points, StrokeList, DotCount);
end;

procedure PrintTreeElement(Canvas: TBasePrinterCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean; Coloured: Boolean);
var
  ABoxRect: TRect;
  ACenter: TPoint;
  Square: TRect;
  X2, X4, Y2, Y4: Integer;
  OldBrushColor: TColor;
  AFinalRect: TRect;
begin
  ACenter.X := (ARect.Right + ARect.Left) div 2;
  ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
  X2 := Trunc(ScaleX*2);
  X4 := Trunc(ScaleX*4);
  Y2 := Trunc(ScaleY*2);
  Y4 := Trunc(ScaleY*4);
  OldBrushColor := clNone;
  Square := ARect;
  if ARect.Bottom - ARect.Top < ARect.Right - ARect.Left then
  begin
    Square.Left := (ARect.Right + ARect.Left) div 2 - (ARect.Bottom - ARect.Top) div 2;
    Square.Right := Square.Left + (ARect.Bottom - ARect.Top);
  end else
  begin
    Square.Top := (ARect.Bottom + ARect.Top) div 2 - (ARect.Right - ARect.Left) div 2;
    Square.Bottom := Square.Top + (ARect.Bottom - ARect.Top);
  end;

  ABoxRect := Rect(ACenter.X-X4, ACenter.Y-Y4, ACenter.X+X4+1, ACenter.Y+Y4+1);

  if TreeElement in [tehMinusUpDown .. tehPlus] then
  begin
    if Coloured then
    begin
      OldBrushColor := Canvas.Brush.Color;
      Canvas.Brush.Color := StyleServices.GetSystemColor(clWhite);
      Canvas.Pen.Color := StyleServices.GetSystemColor(clBlack);
      Canvas.Pen.Style := psSolid;
    end;
    //if GlyphStyle = tvgsClassicEh then
    begin
      if RightToLeft
        then AFinalRect := Rect(ABoxRect.Left-1, ABoxRect.Top, ABoxRect.Right-1, ABoxRect.Bottom)
        else AFinalRect := Rect(ABoxRect.Left, ABoxRect.Top, ABoxRect.Right, ABoxRect.Bottom);

      Canvas.FillRect(AFinalRect);
      Canvas.Rectangle(AFinalRect);
    end;
    if Coloured then
      Canvas.Pen.Color := StyleServices.GetSystemColor(clWindowText);

    Canvas.MoveTo(ABoxRect.Left + X2, ACenter.Y);
    Canvas.LineTo(ABoxRect.Right - X2, ACenter.Y);

    if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus, tehPlusHLine] then
    begin
      Canvas.MoveTo(ACenter.X, ABoxRect.Top + Y2);
      Canvas.LineTo(ACenter.X, ABoxRect.Bottom - Y2);
    end;

    if Coloured then
      Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
    if not (TreeElement in [tehMinus, tehPlus]) then
      PrintDotLine(Canvas, Point(ABoxRect.Right{ + X1}, ACenter.Y),
       (ARect.Right - ABoxRect.Right), True, False);

    if TreeElement in [tehMinusUpDown, tehMinusUp, tehPlusUpDown, tehPlusUp] then
      PrintDotLine(Canvas, Point(ACenter.X, ARect.Top), (ABoxRect.Top - ARect.Top), False, BackDot);

    if TreeElement in [tehMinusUpDown, tehMinusDown, tehPlusUpDown, tehPlusDown] then
      PrintDotLine(Canvas, Point(ACenter.X, ABoxRect.Bottom{ + Y1}),
        (ARect.Bottom - ABoxRect.Bottom), False, BackDot);

    if Coloured then
      Canvas.Brush.Color := OldBrushColor;
  end else
  begin
    if Coloured then
    begin
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
    end;
    if TreeElement in [tehCrossUpDown, tehVLine] then
      PrintDotLine(Canvas, Point(ACenter.X, ARect.Top),
        (ARect.Bottom - ARect.Top), False, BackDot);
    if TreeElement in [tehCrossUpDown, tehCrossUp, tehCrossDown, tehHLine] then
      PrintDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Right - ACenter.X), True, False);
    if TreeElement in [tehCrossDown] then
      PrintDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Bottom - ACenter.Y), False, BackDot);
    if TreeElement in [tehCrossUp] then
      PrintDotLine(Canvas, Point(ACenter.X, ARect.Top), (ACenter.Y - ARect.Top), False, BackDot);
  end;
end;

function PrintGraphicField(Canvas: TBasePrinterCanvas; Field: TField;
  ARect: TRect; AClipRect: TRect;
  CalcRect: Boolean;
  ScaleX, ScaleY: Double): Integer;
var
  R: TRect;
  DrawPict: TPicture;
  Stretch: Boolean;
  Center: Boolean;
  XRatio, YRatio: Double;
begin
  DrawPict := GetPictureForField(Field);
  try

    Result := DrawPict.Height;
    if DrawPict.Width > RectWidth(ARect) then
      Result := Round(Result / (DrawPict.Width / RectWidth(ARect)));
    Result :=  Trunc(Result * ScaleY);
    if CalcRect then Exit;

    Stretch := (Trunc(DrawPict.Width * ScaleY) > (ARect.Right-Arect.Left))
      or (Trunc(DrawPict.Height * ScaleY) > (ARect.Bottom-Arect.Top));
    Center := True;

    if Stretch then
    begin
      XRatio := Trunc(DrawPict.Width * ScaleY) / (ARect.Right-Arect.Left);
      YRatio := Trunc(DrawPict.Height * ScaleY) / (ARect.Bottom-Arect.Top);
      R := ARect;
      if XRatio > YRatio then
      begin
        R.Bottom := Arect.Top + Round(Trunc(DrawPict.Height * ScaleY) / XRatio);
      end else
      begin
        R.Right := ARect.Left + Round(Trunc(DrawPict.Width * ScaleY) / YRatio);
      end;
    end else
    begin
      R := Rect(ARect.Left,
                Arect.Top,
                ARect.Left + Trunc(DrawPict.Width  * ScaleY),
                Arect.Top + Trunc(DrawPict.Height * ScaleY));
    end;

    if Center then
    begin
      OffsetRect(R,
        (ARect.Right - Arect.Left - (R.Right-R.Left)) div 2,
        (ARect.Bottom - Arect.Top - (R.Bottom-R.Top)) div 2);
    end;

    Canvas.StretchDraw(R, DrawPict.Graphic);
  finally
//    if Pal <> 0 then
//      SelectPalette(Canvas.Handle, Pal, True);
    DrawPict.Free;
  end;
end;

function PrintTextVerticalEh(
                          ACanvas: TBasePrinterCanvas;
                          ARect: TRect;          
                          DX, DY: Integer;       
                          Text: string;    
                          Alignment: TAlignment; 
                          Layout: TTextLayout;   
                          MultyL: Boolean;
                          EndEllipsis: Boolean;   
                          CalcTextExtent: Boolean  
                          ): Integer;
const
  AlignFlags: array[TAlignment] of TTextFormat = ([tfLeft], [tfRight], [tfCenter]);
  VertAlignFlags: array[TTextLayout] of TTextFormat = ([tfTop], [tfVerticalCenter], [tfBottom]);
  //tlTop, tlCenter, tlBottom
  WrdWrp: array[Boolean] of TTextFormat = ([], [tfWordBreak]);
var
  TextFormat: TTextFormat;
begin
  Result := 0;

  if (CalcTextExtent) then
  begin
    Result := ACanvas.TextExtent(Text).cx;
    Exit;
  end;

  TextFormat := [];
  TextFormat := TextFormat + AlignFlags[Alignment];
  TextFormat := TextFormat + VertAlignFlags[Layout];
  TextFormat := TextFormat + WrdWrp[MultyL];

  ACanvas.VerticalTextRect(ARect, Text, TextFormat);
end;

{$IFDEF FPC}
{$ELSE}
var
  ServiceRichText: TDBRichEditEh;
{$ENDIF}

procedure InitUnit;
begin
end;

procedure FinalizeUnit;
begin
  {$IFDEF FPC}
  {$ELSE}
  ServiceRichText.Free;
  {$ENDIF}
end;

procedure CreateServiceRichText;
{$IFDEF FPC}
begin
end;
{$ELSE}
var
  ExStyle: DWord;
begin
  if ServiceRichText = nil then
  begin
    ServiceRichText := TDBRichEditEh.Create(nil);
    ServiceRichText.Visible := False;
    ServiceRichText.ParentWindow := Application.Handle;

    ExStyle := GetWindowLong(ServiceRichText.Handle, GWL_EXSTYLE);
    ExStyle := ExStyle or WS_EX_TRANSPARENT;
    SetWindowLong(ServiceRichText.Handle, GWL_EXSTYLE, ExStyle);
  end;
end;
{$ENDIF}

procedure DrawRichTextEh(Canvas: TBasePrinterCanvas; const RichText: String; ARect: TRect);
{$IFDEF FPC}
begin
end;
{$ELSE}
var
  RangeMode: Integer;
  Range: TFormatRange;
  LogX, LogY: Integer;
  w, h: Integer;
begin
  // TODO: PdfPrinter
  if not Canvas.IsHandleSupported then Exit;

  CreateServiceRichText;
  ServiceRichText.RtfText := RichText;

  SendMessage(ServiceRichText.Handle, EM_FORMATRANGE, 0, 0); 

  w := (ARect.Right - ARect.Left);
  h := (ARect.Bottom - ARect.Top);

  LogX := GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
  LogY := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);

  FillChar(Range, SizeOf(TFormatRange), 0);
  Range.hdc := Canvas.Handle;
  Range.hdcTarget := Canvas.Handle;
  Range.rc := Rect(0, 0, w * 1440 div LogX, h * 1440 div LogY);
  OffSetRect(Range.rc, ARect.Left * 1440 div LogX, ARect.Top * 1440 div LogY);
  Range.rcPage := Range.rc;
  Range.chrg.cpMin := 0;
  Range.chrg.cpMax := -1;
  RangeMode := 1;
  SendStructMessage(ServiceRichText.Handle, EM_FORMATRANGE, RangeMode, Range);
  SendMessage(ServiceRichText.Handle, EM_FORMATRANGE, 0, 0); 
end;
{$ENDIF}

function ResetRichtextAlignment(const RichText: String; Alignment: TAlignment): String;
{$IFDEF FPC}
begin
  Result := '';
end;
{$ELSE}
begin
  CreateServiceRichText;
  ServiceRichText.RtfText := RichText;
  ServiceRichText.SelectAll;
  ServiceRichText.Paragraph.Alignment := Alignment;
  Result := ServiceRichText.RtfText;
  ServiceRichText.Clear;
end;
{$ENDIF}

function StringReplaceMacros(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags; MacroChar: Char): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := NlsUpperCase(S);
    Patt := NlsUpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    if (Offset = 1) or (SearchStr[Offset - 1] <> MacroChar)
      then Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern
      else Result := Result + Copy(NewStr, 1, Offset - 1) + OldPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function LocaleMeasureValueToInches(Val: Currency): Currency;
begin
  if GetLocaleMeasurementSystem(0) = msUnitedStatesEh
    then Result := Val
    else Result := Val / 2.54;
end;

function InchesValueToLocaleMeasure(Val: Currency): Currency;
begin
  if GetLocaleMeasurementSystem(0) = msUnitedStatesEh
    then Result := Val
    else Result := Val * 2.54;
end;

function GetLocaleMeasurementSystem(Locale: Integer): TMeasurementSystemEh;
{$IFDEF FPC}
begin
  Result := msMetricEh;
end;
{$ELSE}
{$IFDEF MSWINDOWS}
var
  c: Char;
begin
{$WARN SYMBOL_PLATFORM OFF}
  if Locale <> 0
    then c := GetLocaleChar(Locale, LOCALE_IMEASURE, '0')
    else c := GetLocaleChar(SysLocale.DefaultLCID, LOCALE_IMEASURE, '0');
  if c = '0'
    then Result := msMetricEh
    else Result := msUnitedStatesEh;
{$WARN SYMBOL_PLATFORM ON}
end;
{$ELSE}
begin
{ TODO : Make an implementation for NO MSWINDOWS. }
  Result := msMetricEh;
end;
{$ENDIF}
{$ENDIF}

{ TPageColontitleEh }

procedure TPageColontitleEh.Assign(Source: TPersistent);
begin
  if Source is TPageColontitleEh then
  begin
    LineType := TPageColontitleEh(Source).LineType;

    LeftText := TPageColontitleEh(Source).LeftText;
    CenterText := TPageColontitleEh(Source).CenterText;
    RightText := TPageColontitleEh(Source).RightText;
  end
  else inherited Assign(Source);
end;

constructor TPageColontitleEh.Create;
begin
  inherited Create;
  FCenterText := '';
  FLeftText := '';
  FRightText := '';
end;

destructor TPageColontitleEh.Destroy;
begin
  inherited Destroy;
end;


procedure TPageColontitleEh.SetLineType(const Value: TPageColontitleLineTypeEh);
begin
  if FLineType <> Value then
  begin
    FLineType := Value;
  end;
end;

procedure TPageColontitleEh.SetCenterText(const Value: TRichStringEh);
begin
  if FCenterText <> Value then
  begin
    FCenterText := Value;
    if FCenterText <> '' then
      FCenterText := ResetRichtextAlignment(FCenterText, taCenter);
  end;
end;

procedure TPageColontitleEh.SetLeftText(const Value: TRichStringEh);
begin
  if FLeftText <> Value then
  begin
    FLeftText := Value;
    if FLeftText <> '' then
      FLeftText := ResetRichtextAlignment(FLeftText, taLeftJustify);
  end;
end;

procedure TPageColontitleEh.SetRightText(const Value: TRichStringEh);
begin
  if FRightText <> Value then
  begin
    FRightText := Value;
    if FRightText <> '' then
      FRightText := ResetRichtextAlignment(FRightText, taRightJustify);
  end;
end;

{ TPageMarginsEh }

constructor TPageMarginsEh.Create;
begin
  inherited Create;

  FTop := 0.75;
  FBottom := 0.75;
  FRight := 0.7;
  FLeft := 0.7;

  FHeader := 0.3;
  FFooter := 0.3;
end;

destructor TPageMarginsEh.Destroy;
begin
  inherited Destroy;
end;

function TPageMarginsEh.GetCurRegionalMetricBottom: Currency;
begin
  Result := InchesValueToLocaleMeasure(Bottom);
end;

procedure TPageMarginsEh.SetCurRegionalMetricBottom(const Value: Currency);
begin
  Bottom := LocaleMeasureValueToInches(Value);
end;

function TPageMarginsEh.GetCurRegionalMetricTop: Currency;
begin
  Result := InchesValueToLocaleMeasure(Top);
end;

procedure TPageMarginsEh.SetCurRegionalMetricTop(const Value: Currency);
begin
  Top := LocaleMeasureValueToInches(Value);
end;

function TPageMarginsEh.GetCurRegionalMetricLeft: Currency;
begin
  Result := InchesValueToLocaleMeasure(Left);
end;

procedure TPageMarginsEh.SetCurRegionalMetricLeft(const Value: Currency);
begin
  Left := LocaleMeasureValueToInches(Value);
end;

function TPageMarginsEh.GetCurRegionalMetricRight: Currency;
begin
  Result := InchesValueToLocaleMeasure(Right);
end;

procedure TPageMarginsEh.SetCurRegionalMetricRight(const Value: Currency);
begin
  Right := LocaleMeasureValueToInches(Value);
end;

function TPageMarginsEh.GetCurRegionalMetricFooter: Currency;
begin
  Result := InchesValueToLocaleMeasure(Footer);
end;

procedure TPageMarginsEh.SetCurRegionalMetricFooter(const Value: Currency);
begin
  Footer := LocaleMeasureValueToInches(Value);
end;

function TPageMarginsEh.GetCurRegionalMetricHeader: Currency;
begin
  Result := InchesValueToLocaleMeasure(Header);
end;

procedure TPageMarginsEh.SetCurRegionalMetricHeader(const Value: Currency);
begin
  Header := LocaleMeasureValueToInches(Value);
end;

function TPageMarginsEh.IsTopStored: Boolean;
begin
  Result := FTop <> 0.75;
end;

function TPageMarginsEh.IsBottomStored: Boolean;
begin
  Result := FBottom <> 0.75;
end;

function TPageMarginsEh.IsLeftStored: Boolean;
begin
  Result := FLeft <> 0.7;
end;

function TPageMarginsEh.IsRightStored: Boolean;
begin
  Result := FRight <> 0.7;
end;

function TPageMarginsEh.IsFooterStored: Boolean;
begin
  Result := FFooter <> 0.3;
end;

function TPageMarginsEh.IsHeaderStored: Boolean;
begin
  Result := FHeader <> 0.3;
end;

{ TBasePrintControlComponent }

constructor TBasePrintServiceComponentEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPageMargins := TPageMarginsEh.Create;
  FPageHeader := TPageColontitleEh.Create;
  FPageFooter := TPageColontitleEh.Create;

  FScale := 100;
  FFitToPagesWide := 1;
  FFitToPagesTall := 1;
  FScalingMode := smAdjustToScaleEh;
  FOrientation := poPortrait;
  FSubstitutionVars := TDynVarsEh.Create(Self);
end;

destructor TBasePrintServiceComponentEh.Destroy;
begin
  FreeAndNil(FPageMargins);
  FreeAndNil(FPageHeader);
  FreeAndNil(FPageFooter);
  FreeAndNil(FSubstitutionVars);
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(FSubstituteRichEdit);
  {$ENDIF}
  inherited Destroy;
end;

procedure TBasePrintServiceComponentEh.SetPageFooter(const Value: TPageColontitleEh);
begin
  FPageFooter.Assign(Value);
end;

procedure TBasePrintServiceComponentEh.SetPageHeader(const Value: TPageColontitleEh);
begin
  FPageHeader.Assign(Value);
end;

procedure TBasePrintServiceComponentEh.SetPageMargins(const Value: TPageMarginsEh);
begin
  FPageMargins.Assign(Value);
end;

procedure TBasePrintServiceComponentEh.SetTextAfterContent(const Value: TRichStringEh);
begin
  FTextAfterContent := Value;
end;

procedure TBasePrintServiceComponentEh.SetTextBeforeContent(const Value: TRichStringEh);
begin
  FTextBeforeContent := Value;
end;

function TBasePrintServiceComponentEh.GetCanvas: TBasePrinterCanvas;
begin
  Result := FPrinter.Canvas;
end;

function TBasePrintServiceComponentEh.GetControlCanvas: TCanvas;
begin
  Result := nil;
end;

{$IFDEF FPC}
{$ELSE}
function TBasePrintServiceComponentEh.GetSubstituteRichEdit: TDBRichEditEh;
var
  ExStyle: DWord;
begin
  if FSubstituteRichEdit = nil then
  begin
    FSubstituteRichEdit := TDBRichEditEh.Create(nil);
    FSubstituteRichEdit.Visible := False;
    FSubstituteRichEdit.ParentWindow := Application.Handle;

    ExStyle := GetWindowLong(FSubstituteRichEdit.Handle, GWL_EXSTYLE);
    ExStyle := ExStyle or WS_EX_TRANSPARENT;
    SetWindowLong(FSubstituteRichEdit.Handle, GWL_EXSTYLE, ExStyle);
  end;
  Result := FSubstituteRichEdit;
end;
{$ENDIF}

{$IFDEF FPC}
{$ELSE}
procedure TBasePrintServiceComponentEh.Preview;
begin
  SetPrinterSetupDialog;
  PrintTo(PrinterPreview);
end;
{$ENDIF}

procedure TBasePrintServiceComponentEh.Print;
begin
  PrintTo(VirtualPrinter);
end;

procedure TBasePrintServiceComponentEh.CalcDeviceCaps;
var
  Diver: Double;
  APrnHorsRes, APrnVertRes: Integer;
begin
  fPrnPhysOffSetX := (FPrinter.FullPageWidth - FPrinter.PageWidth) div 2;
  fPrnPhysOffSetY := (FPrinter.FullPageHeight - FPrinter.PageHeight) div 2;

  APrnHorsRes := FPrinter.PageWidth;
  APrnVertRes := FPrinter.PageHeight;

  {$IFDEF FPC}
  LogPelsXOnControl := ControlCanvas.Font.PixelsPerInch;
  LogPelsYOnControl := ControlCanvas.Font.PixelsPerInch;
  {$ELSE}
  LogPelsXOnControl := GetDeviceCaps(ControlCanvas.Handle, LOGPIXELSX);
  LogPelsYOnControl := GetDeviceCaps(ControlCanvas.Handle, LOGPIXELSY);
  {$ENDIF}

  if FPrinter.Printers.Count > 0 then
  begin
    LogPelsXOnPrinter := FPrinter.PixelsPerInchX;
    LogPelsYOnPrinter := FPrinter.PixelsPerInchY;
  end else
  begin
    {$IFDEF FPC}
    LogPelsXOnPrinter := 600;
    LogPelsYOnPrinter := 600;
    {$ELSE}
    LogPelsXOnPrinter := DefaultPrinterPixelsPerInchX;
    LogPelsYOnPrinter := DefaultPrinterPixelsPerInchY;
    {$ENDIF}
  end;

  if (LogPelsXOnControl > LogPelsXOnPrinter) then
    FScaleX := (LogPelsXOnControl / LogPelsXOnPrinter)
  else
    FScaleX := (LogPelsXOnPrinter / LogPelsXOnControl);

  if (LogPelsYOnControl > LogPelsYOnPrinter) then
    FScaleY := (LogPelsYOnControl / LogPelsYOnPrinter)
  else
    FScaleY := (LogPelsYOnPrinter / LogPelsYOnControl);

  Diver := 1;

  FPhysDataPrintRec.Left := Round(LogPelsXOnPrinter * PageMargins.Left / Diver) - fPrnPhysOffSetX;
  FPhysDataPrintRec.Top := Round(LogPelsYOnPrinter * PageMargins.Top / Diver) - fPrnPhysOffSetY;
  FPhysDataPrintRec.Right := APrnHorsRes - Round(LogPelsXOnPrinter * PageMargins.Right / Diver) + fPrnPhysOffSetX;
  FPhysDataPrintRec.Bottom := APrnVertRes - Round(LogPelsYOnPrinter * PageMargins.Bottom / Diver) + fPrnPhysOffSetY;

  FPenW := Trunc((LogPelsXOnPrinter + LogPelsYOnPrinter) / (72 * 2)); 
end;

procedure TBasePrintServiceComponentEh.InitData;
begin
  CalcDeviceCaps;
end;

procedure TBasePrintServiceComponentEh.InitMacroValues;
begin
  MacroValues[1] := DateToStr(Now);
  MacroValues[2] := DateToStr(Now);
  MacroValues[3] := FormatDateTime(FormatSettings.LongDateFormat, Now);
  MacroValues[4] := TimeToStr(Now);
  MacroValues[5] := IntToStr(PageCount);
end;

procedure TBasePrintServiceComponentEh.PrintData;
begin
end;

function TBasePrintServiceComponentEh.ExtractMacros(s: TRichStringEh): TRichStringEh;
var
  i: Integer;
  p: Integer;
begin
  Result := s;
  if Result = '' then Exit;
  MacroValues[0] := IntToStr(Printer.PageNumber);
  for i := 0 to High(ColontileMacros) do
    Result := SubstituteRichTextVar(Result, ColontileMacros[i],
      MacroValues[i], 0, -1, [], True, p);
end;

function TBasePrintServiceComponentEh.SubstituteVars(RichText: TRichStringEh): TRichStringEh;
var
  i: Integer;
  p: Integer;
begin
  Result := RichText;
  if Result = '' then Exit;
  for i := 0 to SubstitutionVars.Count-1 do
    Result := SubstituteRichTextVar(Result, SubstitutionVars.Items[i].Name,
      SubstitutionVars.Items[i].AsString , 0, -1, [], True, p);
end;

function TBasePrintServiceComponentEh.SubstituteRichTextVar(RichText: TRichStringEh;
  const SearchStr, ReplaceStr: String; StartPos, Length: Integer;
  Options: TSearchTypes; ReplaceAll: Boolean; var FoundPos: Integer): TRichStringEh;
begin
{$IFDEF FPC}
  Result := '';
{$ELSE}
  SubstituteRichEdit.RtfText := RichText;
  while True do
  begin
    FoundPos := SubstituteRichEdit.FindText(SearchStr, StartPos, Length, Options);
    if FoundPos <> -1 then
    begin
      SubstituteRichEdit.SelStart := FoundPos;
{$IFDEF CIL}
      SubstituteRichEdit.SelLength := Borland.Delphi.System.Length(SearchStr);
{$ELSE}
      SubstituteRichEdit.SelLength := System.Length(SearchStr);
{$ENDIF}
      SubstituteRichEdit.SelText := ReplaceStr;
    end;
    if not ReplaceAll or (FoundPos = -1) then
      Break;
  end;
  Result := SubstituteRichEdit.RtfText;
{$ENDIF}
end;

procedure TBasePrintServiceComponentEh.PrintColontitleLine(
  Colontitle: TPageColontitleEh; var ARect: TRect; Layout: TTextLayout);
var
  OldPenWidth: Integer;
begin
  OldPenWidth := Canvas.Pen.Width;
  if (Colontitle.LineType <> pcltNonEh) then
    Canvas.Pen.Width := LogPelsYOnPrinter div 144;

  if (Colontitle.LineType = pcltDoubleLineEh) then
  begin
    if Layout = tlTop then
    begin
      ARect.Bottom := ARect.Bottom - Trunc(LogPelsYOnPrinter / 20);
      Canvas.MoveTo(ARect.Left, ARect.Bottom);
      Canvas.LineTo(ARect.Right, ARect.Bottom);
      ARect.Bottom := ARect.Bottom - Trunc(LogPelsYOnPrinter / 30);
      Canvas.MoveTo(ARect.Left, ARect.Bottom);
      Canvas.LineTo(ARect.Right, ARect.Bottom);
    end else
    begin
      ARect.Top := ARect.Top + Trunc(LogPelsYOnPrinter / 20);
      Canvas.MoveTo(ARect.Left, ARect.Top);
      Canvas.LineTo(ARect.Right, ARect.Top);
      ARect.Top := ARect.Top + Trunc(LogPelsYOnPrinter / 30);
      Canvas.MoveTo(ARect.Left, ARect.Top);
      Canvas.LineTo(ARect.Right, ARect.Top);
    end;
  end else if (Colontitle.LineType = pcltSingleLineEh) then
  begin
    if Layout = tlTop then
    begin
      ARect.Bottom := ARect.Bottom - Trunc(LogPelsYOnPrinter / 20);
      Canvas.MoveTo(ARect.Left, ARect.Bottom);
      Canvas.LineTo(ARect.Right, ARect.Bottom);
    end else
    begin
      ARect.Top := ARect.Top + Trunc(LogPelsYOnPrinter / 20);
      Canvas.MoveTo(ARect.Left, ARect.Top);
      Canvas.LineTo(ARect.Right, ARect.Top);
    end;
  end;
  Canvas.Pen.Width := OldPenWidth;
end;

procedure TBasePrintServiceComponentEh.PrintColontitle(
  Colontitle: TPageColontitleEh; ARect: TRect; Layout: TTextLayout);
var
  s: TRichStringEh;
begin
  PrintColontitleLine(Colontitle, ARect, Layout);

  s := ExtractMacros(Colontitle.LeftText);
  DrawRichTextEh(Canvas, s, ARect);

  s := ExtractMacros(Colontitle.RightText);
  DrawRichTextEh(Canvas, s, ARect);

  s := ExtractMacros(Colontitle.CenterText);
  DrawRichTextEh(Canvas, s, ARect);
end;

procedure TBasePrintServiceComponentEh.PrintPageHeader;
var
  HeaderRect: TRect;
  Diver: Integer;
begin
  Diver := 1;
  HeaderRect.Left := FPhysDataPrintRec.Left;
  HeaderRect.Right := FPhysDataPrintRec.Right;
  HeaderRect.Top := Round(LogPelsYOnPrinter * PageMargins.Header / Diver) - fPrnPhysOffSetY;
  HeaderRect.Bottom := FPhysDataPrintRec.Top;
  PrintColontitle(PageHeader, HeaderRect, tlTop);
end;

procedure TBasePrintServiceComponentEh.PrintPageFooter;
var
  FooterRect: TRect;
  Diver: Integer;
begin
  Diver := 1;
  FooterRect.Left := FPhysDataPrintRec.Left;
  FooterRect.Right := FPhysDataPrintRec.Right;
  FooterRect.Top := FPhysDataPrintRec.Bottom;
  FooterRect.Bottom := Printer.FullPageHeight -
    Round(LogPelsYOnPrinter * PageMargins.Footer / Diver) -
    fPrnPhysOffSetY;
  PrintColontitle(PageFooter, FooterRect, tlBottom);
end;

procedure TBasePrintServiceComponentEh.PrintPageOutClientData;
begin
  PrintPageHeader;
  PrintPageFooter;
end;

procedure TBasePrintServiceComponentEh.PreparePageInClientData;
begin
end;

procedure TBasePrintServiceComponentEh.PrintPageInClientData;
begin

end;

procedure TBasePrintServiceComponentEh.PrintTo(VPrinter: TBaseVirtualPrinter);
begin
  FPrinter := VPrinter;
  VPrinter.Orientation := Orientation;

  StartPrint;

  InitData;
  PrintData;

  EndPrint;
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(FSubstituteRichEdit);
  {$ENDIF}
end;

procedure TBasePrintServiceComponentEh.PrintToPdfFile(AFileName: String);
var
  PdfPrinter: TPdfPrinterEh;
begin
  PdfPrinter := TPdfPrinterEh.Create;
  PdfPrinter.BeginDoc(AFileName);
  PrintTo(PdfPrinter);
  PdfPrinter.EndDoc;
  PdfPrinter.Free;
end;

procedure TBasePrintServiceComponentEh.StartPrint;
begin
  Printer.BeginDoc;
  if Assigned(OnBeforePrint) then
    OnBeforePrint(Self);
  if Assigned(OnBeforePrintPage) then
    OnBeforePrintPage(Self);
end;

procedure TBasePrintServiceComponentEh.NewPage;
begin
  if Assigned(OnAfterPrintPageContent) then
    OnAfterPrintPageContent(Self);
  ResetPageViewMode;
  if Assigned(OnAfterPrintPage) then
    OnAfterPrintPage(Self);

  Printer.NewPage;

  if Assigned(OnBeforePrintPage) then
    OnBeforePrintPage(Self);
end;

procedure TBasePrintServiceComponentEh.EndPrint;
begin
  if Assigned(OnAfterPrintPageContent) then
    OnAfterPrintPageContent(Self);
  ResetPageViewMode;
  if Assigned(OnAfterPrintPage) then
    OnAfterPrintPage(Self);
  if Assigned(OnAfterPrint) then
    OnAfterPrint(Self);
  Printer.EndDoc;
end;

procedure TBasePrintServiceComponentEh.SetPrinterSetupDialog;
begin
end;

procedure TBasePrintServiceComponentEh.InitPageViewMode;
var
  pw, ph: Integer;
  AScale: Integer;
begin
// TODO: PdfPrinter

//  SetMapMode(Canvas.Handle, mm_Anisotropic);
//  SetViewportOrgEx(Canvas.Handle, PhysDataPrintRec.Left, PhysDataPrintRec.Top, nil);
  Canvas.SetCanvasOrigin(PhysDataPrintRec.Left, PhysDataPrintRec.Top);
  pw := PhysDataPrintRec.Right - PhysDataPrintRec.Left;
  ph := PhysDataPrintRec.Bottom - PhysDataPrintRec.Top;
  LogDataPrintRec := Rect(0, 0, pw, ph);

  if PrintDataScale <> 100 then
  begin
    AScale := PrintDataScale;
    if AScale = 0 then
      raise Exception.Create('procedure TBasePrintGridComponent.InitPageData - PrintParams.Scale can not be zero');

    Canvas.SetCanvasScale(pw * AScale, pw * 100, ph * AScale, ph * 100);
    FLogDataPrintRec.Right := Round(pw * 100 / AScale);
    FLogDataPrintRec.Bottom := Round(ph * 100 / AScale);
  end;
end;

procedure TBasePrintServiceComponentEh.ResetPageViewMode;
begin
  Canvas.SetCanvasOrigin(0, 0);
  Canvas.SetCanvasScale(1, 1, 1, 1);
end;

function TBasePrintServiceComponentEh.GetPageHeight: Integer;
begin
  Result := Printer.PageHeight;
end;

function TBasePrintServiceComponentEh.GetPageWidth: Integer;
begin
  Result := Printer.PageWidth;
end;

{ TBaseGridPrintServiceEh }

constructor TBaseGridPrintServiceEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TBaseGridPrintServiceEh.Destroy;
begin
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(FBefortAfterRichText);
  {$ENDIF}
  inherited Destroy;
end;

procedure TBaseGridPrintServiceEh.InitData;
begin
  inherited InitData;

  FBeforeGridOnPageHeight := 0;
  FAfterGridOnPageHeight := 0;
  FBeforeGridFullHeight := 0;
  FAfterGridFullHeight := 0;

  FExtraPageCount := 0;
  FPrintPageMode := ppdmLayoutDataEh;

  SetColRowSize;
  SetDataScale;
  ResetPrinterCanvas;
  CalcPageColsRows;

  FPrintPageMode := ppdmPrintDataEh;
  InitMacroValues;
end;

procedure TBaseGridPrintServiceEh.SetDataScale;
begin
  if (ScalingMode = smAdjustToScaleEh) and (Scale <> 100) then
    PrintDataScale := Scale
  else if ScalingMode = smFitToPagesEh then
    ScaleToPages(FitToPagesTall, FitToPagesWide)
  else
    PrintDataScale := 100;
end;

function TBaseGridPrintServiceEh.LogRectToPhysRect(const ARect: TRect): TRect;
var
  pw, ph: Integer;
begin
  pw := ARect.Right - ARect.Left;
  ph := ARect.Bottom - ARect.Top;

  Result := ARect;
  OffsetRect(Result, PhysDataPrintRec.Left, PhysDataPrintRec.Top);
  Result.Right := Result.Left + Round(pw * Scale / 100);
  Result.Bottom := Result.Top + Round(ph * Scale / 100);
end;

procedure TBaseGridPrintServiceEh.PrintData;
begin
  FExtraPageCount := 0;
  PrintGrid;
end;

procedure TBaseGridPrintServiceEh.PrintPageOutClientData;
begin
  inherited PrintPageOutClientData;
end;

procedure TBaseGridPrintServiceEh.PreparePageInClientData;
begin
  InitPageViewMode;
  if Assigned(OnBeforePrintPageContent) then
    OnBeforePrintPageContent(Self);
end;

procedure TBaseGridPrintServiceEh.PrintGrid;
var
  i, j: Integer;
begin
  PrintPageOutClientData;
  PreparePageInClientData;
  PrintDataBeforeGrid;

  for j := 0 to Length(PageStartRows)-1 do
  begin
    for i := 0 to Length(PageStartCols)-1 do
    begin
      if (i <> 0) or (j <> 0) then
      begin
        NewPage;
        PrintPageOutClientData;
        PreparePageInClientData;
        FBeforeGridOnPageHeight := 0;
      end;

      FPageStartCol := PageStartCols[i];
      if i < Length(PageStartCols)-1
        then FPageFinishCol := PageStartCols[i+1]-1
        else FPageFinishCol := Length(ColWidths)-1;

      FPageStartRow := PageStartRows[j];
      if j < Length(PageStartRows)-1
        then FPageFinishRow := PageStartRows[j+1]-1
        else FPageFinishRow := Length(RowHeights)-1;

      PrintPageInClientData;
    end;
  end;

  PrintDataAfterGrid;
end;

procedure TBaseGridPrintServiceEh.ScaleToPages(FitToPagesTall, FitToPagesWide: Integer);
var
  FullPagesTall, FullGridTall: Int64;
  FullPagesWide, FullGridWide: Int64;
  OnePageTall, OneScaledPageTall: Integer;
  OnePageWide, OneScaledPageWide: Integer;
  i: Integer;
  ScaleForTall, ScaleForWide: Integer;
  CurExtand, CurPages: Integer;
begin
  RecalcBeforeAfterPageData;

  FullPagesTall := 0;
  OnePageTall := PhysDataPrintRec.Bottom - PhysDataPrintRec.Top;
  for i := 0 to FitToPagesTall-1 do
    FullPagesTall := FullPagesTall + OnePageTall;

  FullGridTall := 0;
  for i := 0 to Length(RowHeights)-1 do
    FullGridTall := FullGridTall + RowHeights[i];
  FullGridTall := FullGridTall + FBeforeGridFullHeight + FAfterGridFullHeight;

  ScaleForTall := Trunc(FullPagesTall / FullGridTall * 100);
  if ScaleForTall > 100 then ScaleForTall := 100;

  OneScaledPageTall := Trunc(OnePageTall * 100 / ScaleForTall);

  while True do
  begin
    CurExtand := 0;
    CurPages := 1;
    for i := 0 to Length(RowHeights)-1 do
    begin
      CurExtand := CurExtand + RowHeights[i];
      if CurExtand > OneScaledPageTall then
      begin
        CurPages := CurPages + 1;
        CurExtand := RowHeights[i];
      end;
    end;
    if CurPages > FitToPagesTall then
    begin
      ScaleForTall := ScaleForTall - 1;
      if ScaleForTall < 0 then
      begin
        ScaleForTall := 1;
        Break;
      end;
      OneScaledPageTall := Trunc(OnePageTall * 100 / ScaleForTall);
    end else
      Break;
  end;

  FullPagesWide := 0;
  OnePageWide := PhysDataPrintRec.Right - PhysDataPrintRec.Left;
  for i := 0 to FitToPagesWide-1 do
    FullPagesWide := FullPagesWide + OnePageWide;

  FullGridWide := 0;
  for i := 0 to Length(ColWidths)-1 do
    FullGridWide := FullGridWide + ColWidths[i];

  ScaleForWide := Trunc(FullPagesWide / FullGridWide * 100);
  if ScaleForWide > 100 then ScaleForWide := 100;

  OneScaledPageWide := Trunc(OnePageWide * 100 / ScaleForWide);

  while True do
  begin
    CurExtand := 0;
    CurPages := 1;
    for i := 0 to Length(ColWidths)-1 do
    begin
      CurExtand := CurExtand + ColWidths[i];
      if CurExtand > OneScaledPageWide then
      begin
        CurPages := CurPages + 1;
        CurExtand := ColWidths[i];
      end;
    end;
    if CurPages > FitToPagesWide then
    begin
      ScaleForWide := ScaleForWide - 1;
      if ScaleForWide < 0 then
      begin
        ScaleForWide := 1;
        Break;
      end;
      OneScaledPageWide := Trunc(OnePageWide * 100 / ScaleForWide);
    end else
      Break;
  end;

  if ScaleForWide < ScaleForTall
    then PrintDataScale := ScaleForWide
    else PrintDataScale := ScaleForTall;
end;

procedure TBaseGridPrintServiceEh.PrintPageInClientData;
var
  i, j: Integer;
  ACellRect: TRect;
// TODO:
//  Rgn: HRgn;
  {CellsRect, }CellsPhysRect: TRect;
begin

  FGridLogRect.Left := LogDataPrintRec.Left;
  FGridLogRect.Top := LogDataPrintRec.Top;
  if FBeforeGridOnPageHeight > 0 then
    FGridLogRect.Top := FGridLogRect.Top + FBeforeGridOnPageHeight;
  FGridLogRect.Right := FGridLogRect.Left;
  FGridLogRect.Bottom := FGridLogRect.Top;

  for i:= FPageStartCol to FPageFinishCol do
    FGridLogRect.Right := FGridLogRect.Right + ColWidths[i];

  for j := FPageStartRow to FPageFinishRow do
    FGridLogRect.Bottom := FGridLogRect.Bottom + RowHeights[j];

  FAfterGridOnPageHeight := FGridLogRect.Bottom - LogDataPrintRec.Top;

  CellsPhysRect := LogRectToPhysRect(GridLogRect);

  // TODO:
  //Rgn := SelectClipRectangleEh(Canvas, CellsPhysRect);
  try
    PrintPageCells(FPageStartCol, FPageFinishCol, FPageStartRow, FPageFinishRow, FGridLogRect);
  finally
    // TODO:
    //RestoreClipRectangleEh(Canvas, Rgn);
  end;

  ACellRect.Left := GridLogRect.Left;
  ACellRect.Top := GridLogRect.Top;
  ACellRect.Bottom := ACellRect.Top + RowHeights[FPageStartRow];
  for i:= FPageStartCol to FPageFinishCol do
  begin
    ACellRect.Right := ACellRect.Left + ColWidths[i];
    PrintLeftTopBorders(i, FPageStartRow, ACellRect, [cbtTopEh]);
    ACellRect.Left := ACellRect.Right;
  end;

  ACellRect.Left := GridLogRect.Left;
  ACellRect.Top := GridLogRect.Top;
  ACellRect.Right := ACellRect.Left + ColWidths[FPageStartCol];
  for j:= FPageStartRow to FPageFinishRow do
  begin
    ACellRect.Bottom := ACellRect.Top + RowHeights[j];
    PrintLeftTopBorders(FPageStartCol, j, ACellRect, [cbtLeftEh]);
    ACellRect.Top := ACellRect.Bottom;
  end;

end;

procedure TBaseGridPrintServiceEh.PrintPageCells(FromCol, ToCol, FromRow,
  ToRow: Integer; const CellsRect: TRect);
var
  i, j: Integer;
  ACellRect: TRect;
begin
  ACellRect.Left := CellsRect.Left;
  ACellRect.Top := CellsRect.Top;
  for i:= FromCol to ToCol do
  begin
    ACellRect.Right := ACellRect.Left + ColWidths[i];
    for j := FromRow to ToRow do
    begin
      ACellRect.Bottom := ACellRect.Top + RowHeights[j];
      PrintCell(i, j, ACellRect);
      ACellRect.Top := ACellRect.Bottom;
    end;
    ACellRect.Top := CellsRect.Top;
    ACellRect.Left := ACellRect.Right;
  end;
end;

function TBaseGridPrintServiceEh.CheckCellAreaDrawn(ACol, ARow: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Length(FPageDrawenCells)-1 do
    if (FPageDrawenCells[i].X = ACol) and (FPageDrawenCells[i].Y = ARow) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TBaseGridPrintServiceEh.SetCellDrawn(ACol, ARow: Integer);
var
  NewPos: Integer;
begin
  NewPos := Length(FPageDrawenCells);
  SetLength(FPageDrawenCells, NewPos+1);
  FPageDrawenCells[NewPos].X := ACol;
  FPageDrawenCells[NewPos].Y := ARow;
end;

procedure TBaseGridPrintServiceEh.DrawAxisLine(LineRect: TRect;
  BorderType: TGridCellBorderTypeEh; BorderColor: TColor; BorderWidth,
  FarFix: Integer);
var
  FromPoint, ToPoint: TPoint;
begin
  FPrinter.Canvas.Brush.Color := AdjustForegroundColor(BorderColor);
  GetLinePos(LineRect, BorderType, BorderWidth, FromPoint, ToPoint);
  if FarFix <> 0 then
  begin
    if BorderType in [cbtTopEh, cbtBottomEh] then
      Inc(ToPoint.X, FarFix)
    else
      Inc(ToPoint.Y, FarFix);
  end;

  DrawLine(FromPoint, ToPoint, BorderWidth);
end;

procedure TBaseGridPrintServiceEh.DrawLine(FromPoint, ToPoint: TPoint; BorderWidth: Integer);
begin
  if FromPoint.Y = ToPoint.Y then
    Canvas.FillRect(Rect(FromPoint.X, FromPoint.Y, ToPoint.X, ToPoint.Y+BorderWidth))
  else
    Canvas.FillRect(Rect(FromPoint.X, FromPoint.Y, ToPoint.X+BorderWidth, ToPoint.Y))
end;

procedure TBaseGridPrintServiceEh.GetLinePos(LineRect: TRect;
  BorderType: TGridCellBorderTypeEh; BorderWidth: Integer; var FromPoint,
  ToPoint: TPoint);
begin
  if BorderType = cbtBottomEh then
  begin
    FromPoint := Point(LineRect.Left, LineRect.Bottom-BorderWidth);
    ToPoint := Point(LineRect.Right, LineRect.Bottom-BorderWidth);
  end else if BorderType = cbtRightEh then
  begin
    FromPoint := Point(LineRect.Right-BorderWidth, LineRect.Top);
    ToPoint := Point(LineRect.Right-BorderWidth, LineRect.Bottom);
  end else if BorderType = cbtTopEh then
  begin
    FromPoint := Point(LineRect.Left, LineRect.Top-BorderWidth);
    ToPoint := Point(LineRect.Right, LineRect.Top-BorderWidth);
  end else if BorderType = cbtLeftEh then
  begin
    FromPoint := Point(LineRect.Left-BorderWidth, LineRect.Top);
    ToPoint := Point(LineRect.Left-BorderWidth, LineRect.Bottom);
  end;
end;

procedure TBaseGridPrintServiceEh.PrintBorders(ACol, ARow: Integer;
  var ARect: TRect; Borders: TGridCellBorderTypesEh);
var
  IsVDraw, IsHDraw: Boolean;
  HBorderColor, VBorderColor: TColor;
  HBorderWidth, VBorderWidth: Integer;
  HFarFix, VFarFix: Integer;
begin

  HBorderColor := clNone;
  HBorderWidth := 0;

  if (cbtBottomEh in Borders) and CheckDrawLine(ACol, ARow, cbtBottomEh, HBorderColor, HBorderWidth) then
  begin
    IsHDraw := True;
    HBorderWidth := PenW;
  end else
    IsHDraw := False;

  VBorderColor := clNone;
  VBorderWidth := 0;

  if (cbtRightEh in Borders) and CheckDrawLine(ACol, ARow, cbtRightEh, VBorderColor, VBorderWidth) then
  begin
    IsVDraw := True;
    VBorderWidth := PenW;
  end else
    IsVDraw := False;

  HFarFix := 0;
  VFarFix := 0;
  if IsHDraw and IsVDraw then
  begin
    if HBorderColor <> VBorderColor then
      if GetColorLuminance(HBorderColor) >
         GetColorLuminance(VBorderColor)
      then
        HFarFix := - VBorderWidth
      else
        VFarFix := - HBorderWidth;
  end;

  if IsHDraw then
    DrawAxisLine(ARect, cbtBottomEh, HBorderColor, HBorderWidth, HFarFix);

  if IsVDraw then
    DrawAxisLine(ARect, cbtRightEh, VBorderColor, VBorderWidth, VFarFix);

  if IsHDraw then
    ARect.Bottom := ARect.Bottom - PenW;
  if IsVDraw then
    ARect.Right := ARect.Right - PenW;
end;

function TBaseGridPrintServiceEh.CheckDrawLine(ACol, ARow: Integer;
  BorderType: TGridCellBorderTypeEh; var Color: TColor; var Width: Integer): Boolean;
begin
  Color := clBlack;
  Width := PenW;
  Result := False;
end;

procedure TBaseGridPrintServiceEh.PrintCell(ACol, ARow: Integer; ARect: TRect);
begin
  PrintBorders(ACol, ARow, ARect, [cbtBottomEh, cbtRightEh]);
  PrintCellData(ACol, ARow, ARect);
end;

procedure TBaseGridPrintServiceEh.PrintCellData(ACol, ARow: Integer; ARect: TRect);
begin

end;

procedure TBaseGridPrintServiceEh.PrintLeftTopBorders(ACol, ARow: Integer;
  ARect: TRect; Borders: TGridCellBorderTypesEh);
var
  IsVDraw, IsHDraw: Boolean;
  HBorderColor, VBorderColor: TColor;
  HBorderWidth, VBorderWidth: Integer;
  HFarFix, VFarFix: Integer;
begin

  HBorderColor := clNone;
  HBorderWidth := 0;

  if (cbtTopEh in Borders) and CheckDrawLine(ACol, ARow, cbtTopEh, HBorderColor, HBorderWidth) then
  begin
    IsHDraw := True;
    HBorderWidth := PenW;
  end else
    IsHDraw := False;

  VBorderColor := clNone;
  VBorderWidth := 0;

  if (cbtLeftEh in Borders) and CheckDrawLine(ACol, ARow, cbtLeftEh, VBorderColor, VBorderWidth) then
  begin
    IsVDraw := True;
    VBorderWidth := PenW;
  end else
    IsVDraw := False;

  HFarFix := 0;
  VFarFix := 0;
  if IsHDraw and IsVDraw then
  begin
    if HBorderColor <> VBorderColor then
      if GetColorLuminance(HBorderColor) >
         GetColorLuminance(VBorderColor)
      then
        HFarFix := - VBorderWidth
      else
        VFarFix := - HBorderWidth;
  end;

  if IsHDraw then
    DrawAxisLine(ARect, cbtTopEh, HBorderColor, HBorderWidth, HFarFix);

  if IsVDraw then
    DrawAxisLine(ARect, cbtLeftEh, VBorderColor, VBorderWidth, VFarFix);
end;

procedure TBaseGridPrintServiceEh.ResetPrinterCanvas;
begin
  FPrinter.Canvas.Pen.Width := PenW;
  FPrinter.Canvas.Brush.Color := clWhite;
end;

procedure TBaseGridPrintServiceEh.InitPageViewMode;
begin
  ResetPrinterCanvas;
  SetLength(FPageDrawenCells, 0);
  inherited InitPageViewMode;
end;

function TBaseGridPrintServiceEh.AdjustBackgroundColor(Color: TColor): TColor;
begin
  if ColorSchema = pcsAdaptedColorEh then
    Result := ColorToGray(Color)
  else if ColorSchema = pcsBlackAndWhiteEh then
  begin
    Result := clWhite
  end else
    Result := Color;
end;

function TBaseGridPrintServiceEh.AdjustForegroundColor(Color: TColor): TColor;
begin
  if ColorSchema = pcsAdaptedColorEh then
    Result := ColorToGray(Color)
  else if ColorSchema = pcsBlackAndWhiteEh then
  begin
    Result := clBlack
  end else
    Result := Color;
end;

{$IFDEF FPC}
{$ELSE}
function TBaseGridPrintServiceEh.GetBefortAfterRichText: TDBRichEditEh;
var
  ExStyle: DWord;
begin
  if FBefortAfterRichText = nil then
  begin
    FBefortAfterRichText := TDBRichEditEh.Create(nil);
    FBefortAfterRichText.Visible := False;
    FBefortAfterRichText.ParentWindow := Application.Handle;

    ExStyle := GetWindowLong(FBefortAfterRichText.Handle, GWL_EXSTYLE);
    ExStyle := ExStyle or WS_EX_TRANSPARENT;
    SetWindowLong(FBefortAfterRichText.Handle, GWL_EXSTYLE, ExStyle);
  end;
  Result := FBefortAfterRichText;
end;
{$ENDIF}

procedure TBaseGridPrintServiceEh.RecalcBeforeAfterPageData;
begin
  FBeforeGridOnPageHeight := 0;
  FAfterGridOnPageHeight := 0;
  FBeforeGridFullHeight := 0;
  FAfterGridFullHeight := 0;

  PrintDataBeforeGrid;
  PrintDataAfterGrid;
end;

procedure TBaseGridPrintServiceEh.PrintDataBeforeGrid;
var
  Processed: Boolean;
begin
  Processed := False;
  if FPrintPageMode = ppdmPrintDataEh then
  begin
    if Assigned(OnPrintDataBeforeGrid) then
      OnPrintDataBeforeGrid(Self, FBeforeGridOnPageHeight, FBeforeGridFullHeight, Processed);
    if not Processed then
      DefaultPrintDataBeforeGrid(FBeforeGridOnPageHeight, FBeforeGridFullHeight);
  end else
  begin
    if Assigned(OnCalcLayoutDataBeforeGrid) then
      OnCalcLayoutDataBeforeGrid(Self, FBeforeGridOnPageHeight, FBeforeGridFullHeight, Processed);
    if not Processed then
      DefaultCalcLayoutDataBeforeGrid(FBeforeGridOnPageHeight, FBeforeGridFullHeight);
  end;
end;

procedure TBaseGridPrintServiceEh.DefaultPrintDataBeforeGrid(var BeforeGridHeight,
  FullHeight: Integer);
var
  ResText: TRichStringEh;
begin
  ResText := SubstituteVars(TextBeforeContent);
  PrintDataRichOutContent(ResText,
    BeforeGridHeight, FAfterGridOnPageHeight, FullHeight);
end;

procedure TBaseGridPrintServiceEh.DefaultCalcLayoutDataBeforeGrid(var BeforeGridHeight,
  FullHeight: Integer);
var
  ResText: TRichStringEh;
begin
  ResText := SubstituteVars(TextBeforeContent);
  PrintDataRichOutContent(ResText,
    BeforeGridHeight, FAfterGridOnPageHeight, FullHeight);
end;

procedure TBaseGridPrintServiceEh.PrintDataAfterGrid;
var
  Processed: Boolean;
begin
  Processed := False;
  if FPrintPageMode = ppdmPrintDataEh then
  begin
    if Assigned(OnPrintDataAfterGrid) then
      OnPrintDataAfterGrid(Self, FAfterGridOnPageHeight, FAfterGridFullHeight, Processed);
    if not Processed then
      DefaultPrintDataAfterGrid(FAfterGridOnPageHeight, FAfterGridFullHeight);
  end else
  begin
    if Assigned(OnCalcLayoutDataAfterGrid) then
      OnCalcLayoutDataAfterGrid(Self, FAfterGridOnPageHeight, FAfterGridFullHeight, Processed);
    if not Processed then
      DefaultCalcLayoutDataAfterGrid(FAfterGridOnPageHeight, FAfterGridFullHeight);
  end;
end;

procedure TBaseGridPrintServiceEh.DefaultPrintDataAfterGrid(
  var AfterGridHeight, FullHeight: Integer);
var
  ResText: TRichStringEh;
begin
  ResText := SubstituteVars(TextAfterContent);
  PrintDataRichOutContent(ResText,
    FBeforeGridOnPageHeight, AfterGridHeight, FullHeight);
end;

procedure TBaseGridPrintServiceEh.DefaultCalcLayoutDataAfterGrid(
  var AfterGridHeight, FullHeight: Integer);
var
  ResText: TRichStringEh;
begin
  ResText := SubstituteVars(TextAfterContent);
  PrintDataRichOutContent(ResText,
    FBeforeGridOnPageHeight, AfterGridHeight, FullHeight);
end;

procedure TBaseGridPrintServiceEh.PrintDataRichOutContent(
  const RichText: TRichStringEh; var BeforeGridHeight, AfterGridHeight, FullHeight: Integer);
{$IFDEF FPC}
begin

end;
{$ELSE}
var
  Range: TFormatRange;
  LastChar, MaxLen, LogX, LogY: Integer;
  SaveRect: TRect;
  RangeMode: Integer;
{$IFDEF EH_LIB_12}
  TextLen: TGetTextLengthEx;
{$ENDIF}
  s: String;

  function ScaleRect(ARect: TRect; XMul, YMul, XDiv, YDiv: Integer): TRect;
  begin
    Result.Left := ARect.Left * XMul div XDiv;
    Result.Right := ARect.Right * XMul div XDiv;
    Result.Top := ARect.Top * YMul div YDiv;
    Result.Bottom := ARect.Bottom * YMul div YDiv;
  end;

begin
  if RichText <> '' then
  begin
    s := SysErrorMessage(GetLastError);
    BefortAfterRichText.RtfText := RichText;
    s := SysErrorMessage(GetLastError);

    if FPrintPageMode = ppdmLayoutDataEh
      then RangeMode := 0
      else RangeMode := 1;

    FillChar(Range, SizeOf(TFormatRange), 0);
    begin
      LogX := LogPelsXOnPrinter;
      LogY := LogPelsyOnPrinter;
      LastChar := 0;

{$IFDEF EH_LIB_12}
      TextLen.Flags := GTL_NUMCHARS;
      TextLen.CodePage := 1200;  
      MaxLen := SendMessage(BefortAfterRichText.Handle,
                              EM_GETTEXTLENGTHEX, LPARAM(@TextLen), 0);
{$ELSE}
      MaxLen := BefortAfterRichText.GetTextLen;
{$ENDIF}

      Range.chrg.cpMax := -1;
      SendMessage(BefortAfterRichText.Handle, EM_FORMATRANGE, 0, 0); 
      s := SysErrorMessage(GetLastError);
      try
        repeat
          SaveRect := LogDataPrintRec;
          SaveRect.Top := SaveRect.Top + AfterGridHeight;
          SaveRect := ScaleRect(SaveRect, 1440, 1440, LogX, LogY);
          Range.rc := SaveRect;
          Range.rcPage := Range.rc;
          Range.chrg.cpMin := LastChar;
          Range.hdc := Printer.Canvas.Handle;
{ TODO  : When printer is not installed we get error. }
          Range.hdcTarget := Printer.Canvas.Handle;
          LastChar := SendStructMessage(BefortAfterRichText.Handle, EM_FORMATRANGE, RangeMode, Range);
          s := SysErrorMessage(GetLastError);

          Range.rc := ScaleRect(Range.rc, LogX, LogY, 1440, 1440);
          BeforeGridHeight := Range.rc.Bottom - Range.rc.Top;
          FullHeight := FullHeight + BeforeGridHeight;
          if LastChar = 0 then Break;

          if (LastChar < MaxLen) and (LastChar <> -1) then
          begin
            if FPrintPageMode = ppdmPrintDataEh then
            begin
              NewPage;
              PrintPageOutClientData;
              PreparePageInClientData;
            end;
            AfterGridHeight := 0;
            Inc(FExtraPageCount);
          end;
        until (LastChar >= MaxLen) or (LastChar = -1);
      finally
        SendMessage(BefortAfterRichText.Handle, EM_FORMATRANGE, 0, 0); 
      end;
    end;
  end;
end;
{$ENDIF}

procedure TBaseGridPrintServiceEh.CalcPageColsRows;
var
  PageDataWidth, PageDataHeight, CurPageHeight: Integer;
  CurOnPageWidth, CurOnPageHeight: Integer;
  i, ColsToPage: Integer;
begin
  InitPageViewMode;
  PageDataWidth := LogDataPrintRec.Right - LogDataPrintRec.Left;
  PageDataHeight := LogDataPrintRec.Bottom - LogDataPrintRec.Top;

  SetLength(PageStartCols, Length(ColWidths));
  FColsPageCount := 1;
  PageStartCols[0] := 0;
  CurOnPageWidth := 0;
  ColsToPage := 0;
  for i:= 0 to Length(ColWidths)-1 do
  begin
    Inc(ColsToPage);
    CurOnPageWidth := CurOnPageWidth + ColWidths[i];
    if CurOnPageWidth > PageDataWidth then
    begin
      if ColsToPage = 1 then
      begin
        PageStartCols[FColsPageCount] := i+1;
        CurOnPageWidth := 0;
      end else
      begin
        PageStartCols[FColsPageCount] := i;
        CurOnPageWidth := ColWidths[i];
      end;
      Inc(FColsPageCount);
      ColsToPage := 0;
    end;
  end;

  SetLength(PageStartCols, FColsPageCount);

  PrintDataBeforeGrid;

  SetLength(PageStartRows, Length(RowHeights));
  FRowsPageCount := 1;
  PageStartRows[0] := 0;
  CurOnPageHeight := 0;
  CurPageHeight := PageDataHeight - FBeforeGridOnPageHeight;
  for i:= 0 to Length(RowHeights)-1 do
  begin
    CurOnPageHeight := CurOnPageHeight + RowHeights[i];
    if CurOnPageHeight > CurPageHeight then
    begin
      PageStartRows[FRowsPageCount] := i;
      CurOnPageHeight := 0;
      Inc(FRowsPageCount);
      CurPageHeight := PageDataHeight;
    end;
  end;

  SetLength(PageStartRows, FRowsPageCount);

  PrintDataAfterGrid;

  PageCount := FRowsPageCount * FColsPageCount + FExtraPageCount;
  ResetPageViewMode;
end;


procedure TBaseGridPrintServiceEh.SetColRowSize;
begin

end;

procedure TBaseGridPrintServiceEh.SetPrinterSetupDialog;
begin
  {$IFDEF FPC}
  {$ELSE}
  PrinterPreview.OnPrinterSetupDialog := PrinterSetupDialogPreview;
  PrinterPreview.PrinterSetupOwner := Self;
  {$ENDIF}
end;

procedure TBaseGridPrintServiceEh.PrinterSetupDialogPreview(Sender: TObject);
begin
  {$IFDEF FPC}
  {$ELSE}
  if ShowSpreadGridPageSetupDialog(Self) then
    Preview;
  {$ENDIF}
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
