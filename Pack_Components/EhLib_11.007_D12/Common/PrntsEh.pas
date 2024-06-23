{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                 TVirtualPrinter object                }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrntsEh {$IFDEF CIL} platform{$ENDIF};

{$I EhLib.Inc}

interface

uses
  {$IFDEF FPC}
    OsPrinters, EhLibLCL,
    {$IFDEF FPC_CROSSP}
      LCLIntf, LCLType,
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    Windows, EhLibVCL,
  {$ENDIF}
  Generics.Collections,
  SysUtils, Types, Classes, Graphics, Controls, Printers;

type
  TBaseVirtualPrinter = class;
  TVirtualPrinter = class;

{ TBasePrinterCanvas }

  TBasePrinterCanvas = class(TPersistent)
  private
    FTextFlags: Longint;
    FPrinter: TBaseVirtualPrinter;

  protected
    function GetHandle: HDC; virtual;
    function GetIsHandleSupported: Boolean; virtual;
    function GetCanvasOrientation: TCanvasOrientation; virtual;
    function GetClipRect: TRect; virtual;
    function GetPenPos: TPoint; virtual;
    function GetPixel(X, Y: Integer): TColor; virtual;
    function GetPixelsPerInchX: Integer; virtual;
    function GetPixelsPerInchY: Integer; virtual;
    function GetRotationDegree: Single; virtual;

    procedure SetHandle(const Value: HDC); virtual;
    procedure SetPenPos(const Value: TPoint); virtual;
    procedure SetPixel(X, Y: Integer; const Value: TColor); virtual;
    procedure SetRotationDegree(const Value: Single); virtual;

    function GetBrush: TBrush; virtual;
    function GetCopyMode: TCopyMode; virtual;
    function GetFont: TFont; virtual;
    function GetPen: TPen; virtual;

    procedure SetBrush(const Value: TBrush); virtual;
    procedure SetCopyMode(const Value: TCopyMode); virtual;
    procedure SetFont(const Value: TFont); virtual;
    procedure SetPen(const Value: TPen); virtual;
  public
    constructor Create(AVirtualPrinter: TBaseVirtualPrinter);
    destructor Destroy; override;

    function CalcTextSize(const Text: String; InitRectWidth: Integer; WordWrap: Boolean): TSize; virtual;
    function TextExtent(const Text: string): TSize; virtual;
    function TextHeight(const Text: string): Integer;
    function TextWidth(const Text: string): Integer;

    procedure AngleArc(X, Y: Integer; Radius: Cardinal; StartAngle, SweepAngle: Single); virtual;
    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual;
    procedure ArcTo(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual;
    procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap; const Source: TRect; Color: TColor); virtual;
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); overload; virtual;
    procedure Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte); overload; virtual;
    procedure DrawFocusRect(const Rect: TRect); virtual;
    procedure Ellipse(const Rect: TRect); overload;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); overload; virtual;
    procedure FillRect(const Rect: TRect); virtual;
    procedure FloodFill(X, Y: Integer; Color: TColor; FillStyle: TFillStyle); virtual;
    procedure FrameRect(const Rect: TRect); virtual;
    procedure LineTo(X, Y: Integer); virtual;
    procedure MoveTo(X, Y: Integer); virtual;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual;
    procedure PolyBezier(const Points: array of TPoint); virtual;
    procedure PolyBezierTo(const Points: array of TPoint); virtual;
    procedure Polygon(const Points: array of TPoint); virtual;
    procedure Polyline(const Points: array of TPoint); virtual;
    procedure Rectangle(const Rect: TRect); overload;
    procedure Rectangle(X1, Y1, X2, Y2: Integer); overload; virtual;
    procedure RoundRect(const Rect: TRect; CX, CY: Integer); overload;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); overload; virtual;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); virtual;
    procedure TextOut(X, Y: Integer; const Text: string); virtual;
    procedure TextRect(Rect: TRect; X, Y: Integer; const Text: string); overload; virtual;
    procedure TextRect(var Rect: TRect; var Text: string; ATextFormat: TTextFormat); overload; virtual;
    procedure VerticalTextRect(var Rect: TRect; var Text: string; ATextFormat: TTextFormat); overload; virtual;

    procedure GetTextMetrics(out tm: TTextMetric); virtual;
    procedure SetCanvasOrigin(xOrg, yOrg: Integer); virtual;
    procedure SetCanvasScale(xMult, xDivd, yMult, yDivd: Integer); virtual;
    procedure DrawRtfText(RtfText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; out Pages, LastPageBlockHeight: Integer); virtual;
    procedure MeasureRtfTextLayout(RichText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; out Pages, LastPageBlockHeight: Integer); virtual;

    procedure AppendClipRect(AClipRect: TRect); virtual;
    procedure RestoreClip; virtual;

    property ClipRect: TRect read GetClipRect;
    property CanvasOrientation: TCanvasOrientation read GetCanvasOrientation;
    property PenPos: TPoint read GetPenPos write SetPenPos;
    property Pixels[X, Y: Integer]: TColor read GetPixel write SetPixel;
    property TextFlags: Longint read FTextFlags write FTextFlags;

    property Printer: TBaseVirtualPrinter read FPrinter;
    property Handle: HDC read GetHandle write SetHandle;
    property IsHandleSupported: Boolean read GetIsHandleSupported;

    property Brush: TBrush read GetBrush write SetBrush;
    property CopyMode: TCopyMode read GetCopyMode write SetCopyMode default cmSrcCopy;
    property Font: TFont read GetFont write SetFont;
    property Pen: TPen read GetPen write SetPen;

    property PixelsPerInchX: Integer read GetPixelsPerInchX;
    property PixelsPerInchY: Integer read GetPixelsPerInchY;
    property RotationDegree: Single read GetRotationDegree write SetRotationDegree; //Rotation of Canvas in 1/10ths of a degree.
  end;

{ TBaseVirtualPrinter }

  TBaseVirtualPrinter = class(TObject)
  private
    FPrinterCanvas: TBasePrinterCanvas;

  protected
    function CreatePrinterCanvas: TBasePrinterCanvas; virtual;

    function GetAborted: Boolean; virtual;
    {$IFDEF FPC}
    {$ELSE}
    function GetCapabilities: TPrinterCapabilities; virtual;
    {$ENDIF}
    function GetFonts: TStrings; virtual;
    function GetHandle: HDC; virtual;
    function GetIsHandleSupported: Boolean; virtual;
    function GetCopies: Integer; virtual;
    function GetOrientation: TPrinterOrientation; virtual;
    function GetPageHeight: Integer; virtual;
    function GetPageWidth: Integer; virtual;
    function GetPageNumber: Integer; virtual;
    function GetPrinting: Boolean; virtual;
    function GetTitle: String; virtual;
    function GetFullPageWidth: Integer; virtual;
    function GetFullPageHeight: Integer; virtual;
    function GetPrinterIndex: Integer; virtual;
    function GetPrinters: TStrings; virtual;
    function GetPixelsPerInchX: Integer; virtual;
    function GetPixelsPerInchY: Integer; virtual;

    procedure SetPrinterIndex(const Value: Integer); virtual;
    procedure SetCopies(const Value: Integer); virtual;
    procedure SetOrientation(const Value: TPrinterOrientation); virtual;
    procedure SetTitle(const Value: string); virtual;

  public
    constructor Create;
    destructor Destroy; override;

    function CreateMeasuringCanvas: TBasePrinterCanvas; virtual;

    procedure Abort; virtual;
    procedure BeginDoc; virtual;
    procedure EndDoc; virtual;
    procedure NewPage; virtual;
{$IFDEF CIL}
    procedure GetPrinter(ADevice, ADriver, APort: String; var ADeviceMode: IntPtr); virtual;
    procedure SetPrinter(ADevice, ADriver, APort: String; ADeviceMode: IntPtr); virtual;
{$ELSE}
    procedure GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle); virtual;
    procedure SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle); virtual;
{$ENDIF}

    property Aborted: Boolean read GetAborted;
    property Canvas: TBasePrinterCanvas read FPrinterCanvas;
    {$IFDEF FPC}
    {$ELSE}
    property Capabilities: TPrinterCapabilities read GetCapabilities;
    {$ENDIF}
    property Copies: Integer read GetCopies write SetCopies;
    property Fonts: TStrings read GetFonts;
    property Handle: HDC read GetHandle;
    property IsHandleSupported: Boolean read GetIsHandleSupported;
    property Orientation: TPrinterOrientation read GetOrientation write SetOrientation;
    property PageHeight: Integer read GetPageHeight;
    property PageWidth: Integer read GetPageWidth;
    property PageNumber: Integer read GetPageNumber;
    property PrinterIndex: Integer read GetPrinterIndex write SetPrinterIndex;
    property FullPageWidth: Integer read GetFullPageWidth;
    property FullPageHeight: Integer read GetFullPageHeight;
    property Printing: Boolean read GetPrinting;
    property Printers: TStrings read GetPrinters;
    property Title: String read GetTitle write SetTitle;
    property PixelsPerInchX: Integer read GetPixelsPerInchX;
    property PixelsPerInchY: Integer read GetPixelsPerInchY;
  end;

{ TVirtualPrinterCanvas }

  TVirtualPrinterCanvas = class(TBasePrinterCanvas)
  private
    FRotationDegree: Single;
    FClipList: TList<HRgn>;

    function GetPrinter: TVirtualPrinter;

  protected
    function GetRotationDegree: Single; override;
    function GetHandle: HDC; override;
    function GetIsHandleSupported: Boolean; override;
    function GetCanvasOrientation: TCanvasOrientation; override;
    function GetClipRect: TRect; override;
    function GetPenPos: TPoint; override;
    function GetPixel(X, Y: Integer): TColor; override;
    function GetPixelsPerInchX: Integer; override;
    function GetPixelsPerInchY: Integer; override;

    procedure SetHandle(const Value: HDC); override;
    procedure SetPenPos(const Value: TPoint); override;
    procedure SetPixel(X, Y: Integer; const Value: TColor); override;
    procedure SetRotationDegree(const Value: Single); override;

    function GetBrush: TBrush; override;
    function GetCopyMode: TCopyMode; override;
    function GetFont: TFont; override;
    function GetPen: TPen; override;

    procedure SetBrush(const Value: TBrush); override;
    procedure SetCopyMode(const Value: TCopyMode); override;
    procedure SetFont(const Value: TFont); override;
    procedure SetPen(const Value: TPen); override;

    function GetDeviceCanvas: TCanvas; virtual;

    procedure InternalDrawRtfText(RichText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; NewPageProc: TNotifyEvent; MeasureLayout: Boolean; out Pages, LastPageBlockHeight: Integer); virtual;
    procedure DefaultNewPageProc(Sender: TObject); virtual;

  public
    constructor Create(AVirtualPrinter: TBaseVirtualPrinter);
    destructor Destroy; override;

    function CalcTextSize(const Text: String; InitRectWidth: Integer; WordWrap: Boolean): TSize; override;
    function TextExtent(const Text: string): TSize; override;

    procedure Polyline(const Points: array of TPoint); override;
    procedure GetTextMetrics(out tm: TTextMetric); override;
    procedure TextRect(Rect: TRect; X, Y: Integer; const Text: string); overload; override;
    procedure TextRect(var Rect: TRect; var Text: string; ATextFormat: TTextFormat = []); overload; override;
    procedure VerticalTextRect(var ARect: TRect; var AText: string; ATextFormat: TTextFormat = []); overload; override;

    procedure AngleArc(X, Y: Integer; Radius: Cardinal; StartAngle, SweepAngle: Single); override;
    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure ArcTo(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap; const Source: TRect; Color: TColor); override;
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); overload; override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte); overload; override;
    procedure DrawFocusRect(const Rect: TRect); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure FillRect(const Rect: TRect); override;
    procedure FloodFill(X, Y: Integer; Color: TColor; FillStyle: TFillStyle); override;
    procedure FrameRect(const Rect: TRect); override;
    procedure LineTo(X, Y: Integer); override;
    procedure MoveTo(X, Y: Integer); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure PolyBezier(const Points: array of TPoint); override;
    procedure PolyBezierTo(const Points: array of TPoint); override;
    procedure Polygon(const Points: array of TPoint); override;

    procedure Rectangle(X1, Y1, X2, Y2: Integer); override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
    procedure TextOut(X, Y: Integer; const Text: string); override;

    procedure SetCanvasOrigin(xOrg, yOrg: Integer); override;
    procedure SetCanvasScale(xMult, xDivd, yMult, yDivd: Integer); override;
    procedure DrawRtfText(RichText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; out Pages, LastPageBlockHeight: Integer); override;
    procedure MeasureRtfTextLayout(RichText: String; FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer; out Pages, LastPageBlockHeight: Integer); override;

    procedure AppendClipRect(AClipRect: TRect); override;
    procedure RestoreClip; override;

    property Printer: TVirtualPrinter read GetPrinter;
    property DeviceCanvas: TCanvas read GetDeviceCanvas;
  end;

{ TVirtualPrinter }

  TVirtualPrinter = class(TBaseVirtualPrinter)
  protected
    function CreatePrinterCanvas: TBasePrinterCanvas; override;
    function GetDeviceCanvas: TCanvas; virtual;

    function GetAborted: Boolean; override;
    {$IFDEF FPC}
    {$ELSE}
    function GetCapabilities: TPrinterCapabilities; override;
    {$ENDIF}
    function GetFonts: TStrings; override;
    function GetIsHandleSupported: Boolean; override;
    function GetHandle: HDC; override;
    function GetCopies: Integer; override;
    function GetOrientation: TPrinterOrientation; override;
    function GetPageHeight: Integer; override;
    function GetPageWidth: Integer; override;
    function GetPageNumber: Integer; override;
    function GetPrinting: Boolean; override;
    function GetTitle: String; override;
    function GetFullPageWidth: Integer; override;
    function GetFullPageHeight: Integer; override;
    function GetPrinterIndex: Integer; override;
    function GetPrinters: TStrings; override;
    function GetPixelsPerInchX: Integer; override;
    function GetPixelsPerInchY: Integer; override;

    procedure SetPrinterIndex(const Value: Integer); override;
    procedure SetCopies(const Value: Integer); override;
    procedure SetOrientation(const Value: TPrinterOrientation); override;
    procedure SetTitle(const Value: string); override;


  public
    constructor Create;
    destructor Destroy; override;

    function CreateMeasuringCanvas: TBasePrinterCanvas; override;

    procedure Abort; override;
    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure NewPage; override;
{$IFDEF CIL}
    procedure GetPrinter(ADevice, ADriver, APort: String; var ADeviceMode: IntPtr); override;
    procedure SetPrinter(ADevice, ADriver, APort: String; ADeviceMode: IntPtr); override;
{$ELSE}
    procedure GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle); override;
    procedure SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle); override;
{$ENDIF}

    property DeviceCanvas: TCanvas read GetDeviceCanvas;
  end;

  {$IFDEF FPC}
  {$ELSE}
  TWinPrinter = TPrinter;
  {$ENDIF}

var
  VirtualPrinter: TVirtualPrinter;

function PrintFrameControlEh(Canvas: TBasePrinterCanvas; const ARect: TRect; uType, uState: LongWord): Boolean;

implementation

uses
  Math, ToolCtrlsEh, StdCtrls,
  {$IFDEF FPC}
  {$ELSE}
  RichEdit,
  {$ENDIF}
  DBCtrlsEh, Forms;

function PrintFrameControlEh(Canvas: TBasePrinterCanvas; const ARect: TRect; uType, uState: LongWord): Boolean;
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create();
  Bitmap.Width := RectWidth(ARect);
  Bitmap.Height := RectHeight(ARect);
  Bitmap.PixelFormat := pf24bit;
  Result := DrawFrameControl(Bitmap.Canvas.Handle, Rect(0, 0, Bitmap.Width, Bitmap.Height), uType, uState);

  Canvas.Draw(ARect.Left, ARect.Top, Bitmap);

  Bitmap.Free;
end;

{ TBaseVirtualPrinter }

constructor TBaseVirtualPrinter.Create;
begin
  inherited Create;
  FPrinterCanvas := CreatePrinterCanvas;
end;

destructor TBaseVirtualPrinter.Destroy;
begin
  FreeAndNil(FPrinterCanvas);
  inherited Destroy;
end;

function TBaseVirtualPrinter.CreateMeasuringCanvas: TBasePrinterCanvas;
begin
  raise Exception.Create('Method "CreateMeasuringCanvas" is not implemented');
end;

function TBaseVirtualPrinter.CreatePrinterCanvas: TBasePrinterCanvas;
begin
  raise Exception.Create('Method "CreatePrinterCanvas" is not implemented');
end;

procedure TBaseVirtualPrinter.Abort;
begin
  raise Exception.Create('Method "Abort" is not implemented');
end;

procedure TBaseVirtualPrinter.BeginDoc;
begin
  raise Exception.Create('Method "BeginDoc" is not implemented');
end;

procedure TBaseVirtualPrinter.EndDoc;
begin
  raise Exception.Create('Method "BeginDoc" is not implemented');
end;

procedure TBaseVirtualPrinter.NewPage;
begin
  raise Exception.Create('Method "NewPage" is not implemented');
end;

{$IFDEF CIL}
procedure TBaseVirtualPrinter.GetPrinter(ADevice, ADriver, APort: String; var ADeviceMode: IntPtr);
{$ELSE}
procedure TBaseVirtualPrinter.GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle);
{$ENDIF}
begin
  raise Exception.Create('Method "GetPrinter" is not implemented');
end;

{$IFDEF CIL}
procedure TBaseVirtualPrinter.SetPrinter(ADevice, ADriver, APort: String; ADeviceMode: IntPtr);
{$ELSE}
procedure TBaseVirtualPrinter.SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle);
{$ENDIF}
begin
  raise Exception.Create('Method "SetPrinter" is not implemented');
end;

function TBaseVirtualPrinter.GetFonts: TStrings;
begin
  raise Exception.Create('Method "GetFonts" is not implemented');
end;

function TBaseVirtualPrinter.GetPageWidth: Integer;
begin
  raise Exception.Create('Method "GetPageWidth" is not implemented');
end;

function TBaseVirtualPrinter.GetPageHeight: Integer;
begin
  raise Exception.Create('Method "GetPageHeight" is not implemented');
end;

function TBaseVirtualPrinter.GetFullPageWidth: Integer;
begin
  raise Exception.Create('Method "GetFullPageWidth" is not implemented');
end;

function TBaseVirtualPrinter.GetFullPageHeight: Integer;
begin
  raise Exception.Create('Method "GetFullPageHeight" is not implemented');
end;

function TBaseVirtualPrinter.GetCopies: Integer;
begin
  raise Exception.Create('Method "GetCopies" is not implemented');
end;

function TBaseVirtualPrinter.GetOrientation: TPrinterOrientation;
begin
  raise Exception.Create('Method "GetOrientation" is not implemented');
end;

function TBaseVirtualPrinter.GetPrinting: Boolean;
begin
  raise Exception.Create('Method "GetPrinting" is not implemented');
end;

function TBaseVirtualPrinter.GetPageNumber: Integer;
begin
  raise Exception.Create('Method "GetPageNumber" is not implemented');
end;

function TBaseVirtualPrinter.GetTitle: string;
begin
  raise Exception.Create('Method "GetTitle" is not implemented');
end;

procedure TBaseVirtualPrinter.SetCopies(const Value: Integer);
begin
  raise Exception.Create('Method "SetCopies" is not implemented');
end;

procedure TBaseVirtualPrinter.SetOrientation(const Value: TPrinterOrientation);
begin
  raise Exception.Create('Method "SetOrientation" is not implemented');
end;

procedure TBaseVirtualPrinter.SetTitle(const Value: string);
begin
  raise Exception.Create('Method "SetTitle" is not implemented');
end;

function TBaseVirtualPrinter.GetAborted: Boolean;
begin
  raise Exception.Create('Method "GetAborted" is not implemented');
end;

function TBaseVirtualPrinter.GetHandle: HDC;
begin
  raise Exception.Create('Method "GetHandle" is not implemented');
end;

function TBaseVirtualPrinter.GetIsHandleSupported: Boolean;
begin
  Result := False;
end;

function TBaseVirtualPrinter.GetPrinterIndex: Integer;
begin
  raise Exception.Create('Method "GetPrinterIndex" is not implemented');
end;

function TBaseVirtualPrinter.GetPrinters: TStrings;
begin
  raise Exception.Create('Method "GetPrinters" is not implemented');
end;

procedure TBaseVirtualPrinter.SetPrinterIndex(const Value: Integer);
begin
  raise Exception.Create('Method "SetPrinterIndex" is not implemented');
end;

{$IFDEF FPC}
{$ELSE}
function TBaseVirtualPrinter.GetCapabilities: TPrinterCapabilities;
begin
  raise Exception.Create('Method "GetCapabilities" is not implemented');
end;
{$ENDIF}

function TBaseVirtualPrinter.GetPixelsPerInchX: Integer;
begin
  raise Exception.Create('Method "GetPixelsPerInchX" is not implemented');
end;

function TBaseVirtualPrinter.GetPixelsPerInchY: Integer;
begin
  raise Exception.Create('Method "GetPixelsPerInchY" is not implemented');
end;

{ TMeasuringVirtualPrinterCanvas }

type
  TMeasuringVirtualPrinterCanvas = class(TVirtualPrinterCanvas)
  private
    {$IFDEF FPC}
    {$ELSE}
    FRenderMetafie: TMetafile;
    FRenderCanvas: TMetafileCanvas;
    {$ENDIF}

  protected

    function GetDeviceCanvas: TCanvas; override;
  public
    constructor Create(AVirtualPrinter: TVirtualPrinter);
    destructor Destroy; override;
  end;

constructor TMeasuringVirtualPrinterCanvas.Create(AVirtualPrinter: TVirtualPrinter);
begin
  inherited Create(AVirtualPrinter);
  {$IFDEF FPC}
  {$ELSE}
  FRenderMetafie := TMetafile.Create;
  FRenderCanvas := TMetafileCanvas.Create(FRenderMetafie, AVirtualPrinter.DeviceCanvas.Handle);
  FRenderCanvas.Font.PixelsPerInch := AVirtualPrinter.DeviceCanvas.Font.PixelsPerInch;
  {$ENDIF}
end;

destructor TMeasuringVirtualPrinterCanvas.Destroy;
begin
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(FRenderCanvas);
  FreeAndNil(FRenderMetafie);
  {$ENDIF}
  inherited Destroy;
end;

function TMeasuringVirtualPrinterCanvas.GetDeviceCanvas: TCanvas;
begin
  {$IFDEF FPC}
  Result := nil;
  {$ELSE}
  Result := FRenderCanvas;
  {$ENDIF}
end;

{ TVirtualPrinter }

constructor TVirtualPrinter.Create;
begin
  inherited Create;
end;

destructor TVirtualPrinter.Destroy;
begin
  inherited Destroy;
end;

function TVirtualPrinter.CreateMeasuringCanvas: TBasePrinterCanvas;
begin
  Result := TMeasuringVirtualPrinterCanvas.Create(Self);
end;

procedure TVirtualPrinter.Abort;
begin
  Printer.Abort;
end;

procedure TVirtualPrinter.BeginDoc;
begin
  Printer.BeginDoc;
end;

procedure TVirtualPrinter.EndDoc;
begin
  Printer.EndDoc;
end;

function TVirtualPrinter.GetAborted: Boolean;
begin
  Result := Printer.Aborted;
end;

{$IFDEF FPC}
{$ELSE}
function TVirtualPrinter.GetCapabilities: TPrinterCapabilities;
begin
  Result := Printer.Capabilities;
end;
{$ENDIF}

function TVirtualPrinter.GetCopies: Integer;
begin
  Result := Printer.Copies;
end;

function TVirtualPrinter.GetDeviceCanvas: TCanvas;
begin
  Result := Printer.Canvas;
end;

function TVirtualPrinter.GetFonts: TStrings;
begin
  Result := Printer.Fonts;
end;

function TVirtualPrinter.GetFullPageHeight: Integer;
begin
  {$IFDEF FPC_CROSSP}
  Result := Printer.PageHeight;
  {$ELSE}
  Result := Printer.PageHeight + GetDeviceCaps(TWinPrinter(Printer).Handle, PHYSICALOFFSETY) * 2;
  {$ENDIF} 
end;

function TVirtualPrinter.GetFullPageWidth: Integer;
begin
  {$IFDEF FPC_CROSSP}
  Result := Printer.PageWidth;
  {$ELSE}
  Result := Printer.PageWidth + GetDeviceCaps(TWinPrinter(Printer).Handle, PHYSICALOFFSETX) * 2;
  {$ENDIF}
end;

function TVirtualPrinter.GetHandle: HDC;
begin
  {$IFDEF FPC_CROSSP}
  Result := 0;
  {$ELSE}
  Result := TWinPrinter(Printer).Handle;
  {$ENDIF} 
end;

function TVirtualPrinter.GetIsHandleSupported: Boolean;
begin
  Result := True;
end;

function TVirtualPrinter.GetOrientation: TPrinterOrientation;
begin
  Result := Printer.Orientation;
end;

procedure TVirtualPrinter.NewPage;
begin
  Printer.NewPage;
end;

function TVirtualPrinter.GetPageHeight: Integer;
begin
  Result := Printer.PageHeight;
end;

function TVirtualPrinter.GetPageNumber: Integer;
begin
  Result := Printer.PageNumber;
end;

function TVirtualPrinter.GetPageWidth: Integer;
begin
  Result := Printer.PageWidth;
end;

function TVirtualPrinter.GetPixelsPerInchX: Integer;
{$IFDEF FPC_CROSSP}
begin
  Result := Printer.XDPI;
end;
{$ELSE}
begin
  Result := GetDeviceCaps(TWinPrinter(Printer).Handle, LOGPIXELSX)
end;
{$ENDIF}

function TVirtualPrinter.GetPixelsPerInchY: Integer;
{$IFDEF FPC_CROSSP}
begin
  Result := Printer.YDPI;
end;
{$ELSE}
begin
  Result := GetDeviceCaps(TWinPrinter(Printer).Handle, LOGPIXELSY)
end;
{$ENDIF}

procedure TVirtualPrinter.GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle);
begin
  {$IFDEF FPC}
  raise Exception.Create('GetPrinter is not supported in FPC');
  {$ELSE}
  Printer.GetPrinter(ADevice, ADriver, APort, ADeviceMode);
  {$ENDIF}
end;

function TVirtualPrinter.GetPrinterIndex: Integer;
begin
  Result := Printer.PrinterIndex;
end;

function TVirtualPrinter.GetPrinters: TStrings;
begin
  Result := Printer.Printers;
end;

function TVirtualPrinter.GetPrinting: Boolean;
begin
  Result := Printer.Printing;
end;

function TVirtualPrinter.GetTitle: String;
begin
  Result := Printer.Title;
end;

procedure TVirtualPrinter.SetCopies(const Value: Integer);
begin
  Printer.Copies := Value;
end;

procedure TVirtualPrinter.SetOrientation(const Value: TPrinterOrientation);
begin
  Printer.Orientation := Value;
end;

procedure TVirtualPrinter.SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle);
begin
  {$IFDEF FPC}
  raise Exception.Create('SetPrinter is not supported in FPC');
  {$ELSE}
  Printer.SetPrinter(ADevice, ADriver, APort, ADeviceMode);
  {$ENDIF}
end;

procedure TVirtualPrinter.SetPrinterIndex(const Value: Integer);
begin
  Printer.PrinterIndex := Value;
end;

procedure TVirtualPrinter.SetTitle(const Value: string);
begin
  Printer.Title := Value;
end;

function TVirtualPrinter.CreatePrinterCanvas: TBasePrinterCanvas;
begin
  Result := TVirtualPrinterCanvas.Create(Self);
end;

{ TBasePrinterCanvas }

constructor TBasePrinterCanvas.Create(AVirtualPrinter: TBaseVirtualPrinter);
begin
  FPrinter := AVirtualPrinter;
end;

destructor TBasePrinterCanvas.Destroy;
begin

  inherited Destroy;
end;

procedure TBasePrinterCanvas.AngleArc(X, Y: Integer; Radius: Cardinal;
  StartAngle, SweepAngle: Single);
begin
  raise Exception.Create('Method "AngleArc" is not implemented');
end;

procedure TBasePrinterCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  raise Exception.Create('Method "Arc" is not implemented');
end;

procedure TBasePrinterCanvas.ArcTo(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  raise Exception.Create('Method "ArcTo" is not implemented');
end;

procedure TBasePrinterCanvas.BrushCopy(const Dest: TRect; Bitmap: TBitmap;
  const Source: TRect; Color: TColor);
begin
  raise Exception.Create('Method "BrushCopy" is not implemented');
end;

procedure TBasePrinterCanvas.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  raise Exception.Create('Method "Chord" is not implemented');
end;

procedure TBasePrinterCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  raise Exception.Create('Method "Draw" is not implemented');
end;

procedure TBasePrinterCanvas.Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte);
begin
  raise Exception.Create('Method "Draw" is not implemented');
end;

procedure TBasePrinterCanvas.DrawFocusRect(const Rect: TRect);
begin
  raise Exception.Create('Method "DrawFocusRect" is not implemented');
end;

procedure TBasePrinterCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  raise Exception.Create('Method "Ellipse" is not implemented');
end;

procedure TBasePrinterCanvas.Ellipse(const Rect: TRect);
begin
  Ellipse(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
end;

procedure TBasePrinterCanvas.FillRect(const Rect: TRect);
begin
  raise Exception.Create('Method "FillRect" is not implemented');
end;

procedure TBasePrinterCanvas.FloodFill(X, Y: Integer; Color: TColor;
  FillStyle: TFillStyle);
begin
  raise Exception.Create('Method "FloodFill" is not implemented');
end;

procedure TBasePrinterCanvas.FrameRect(const Rect: TRect);
begin
  raise Exception.Create('Method "FrameRect" is not implemented');
end;

function TBasePrinterCanvas.GetCanvasOrientation: TCanvasOrientation;
begin
  raise Exception.Create('Method "GetCanvasOrientation" is not implemented');
end;

function TBasePrinterCanvas.GetClipRect: TRect;
begin
  raise Exception.Create('Method "GetClipRect" is not implemented');
end;

function TBasePrinterCanvas.GetPenPos: TPoint;
begin
  raise Exception.Create('Method "GetPenPos" is not implemented');
end;

function TBasePrinterCanvas.GetPixel(X, Y: Integer): TColor;
begin
  raise Exception.Create('Method "GetPixel" is not implemented');
end;

procedure TBasePrinterCanvas.LineTo(X, Y: Integer);
begin
  raise Exception.Create('Method "LineTo" is not implemented');
end;

procedure TBasePrinterCanvas.MoveTo(X, Y: Integer);
begin
  raise Exception.Create('Method "MoveTo" is not implemented');
end;

procedure TBasePrinterCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  raise Exception.Create('Method "Pie" is not implemented');
end;

procedure TBasePrinterCanvas.PolyBezier(const Points: array of TPoint);
begin
  raise Exception.Create('Method "PolyBezier" is not implemented');
end;

procedure TBasePrinterCanvas.PolyBezierTo(const Points: array of TPoint);
begin
  raise Exception.Create('Method "PolyBezierTo" is not implemented');
end;

procedure TBasePrinterCanvas.Polygon(const Points: array of TPoint);
begin
  raise Exception.Create('Method "Polygon" is not implemented');
end;

procedure TBasePrinterCanvas.Polyline(const Points: array of TPoint);
begin
  raise Exception.Create('Method "Polyline" is not implemented');
end;

procedure TBasePrinterCanvas.Rectangle(X1, Y1, X2, Y2: Integer);
begin
  raise Exception.Create('Method "Rectangle" is not implemented');
end;

procedure TBasePrinterCanvas.Rectangle(const Rect: TRect);
begin
  Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
end;

procedure TBasePrinterCanvas.RoundRect(const Rect: TRect; CX, CY: Integer);
begin
  RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, CX, CY);
end;

procedure TBasePrinterCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  raise Exception.Create('Method "RoundRect" is not implemented');
end;

procedure TBasePrinterCanvas.SetPenPos(const Value: TPoint);
begin
  raise Exception.Create('Method "SetPenPos" is not implemented');
end;

procedure TBasePrinterCanvas.SetPixel(X, Y: Integer; const Value: TColor);
begin
  raise Exception.Create('Method "SetPixel" is not implemented');
end;

procedure TBasePrinterCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
  raise Exception.Create('Method "StretchDraw" is not implemented');
end;

function TBasePrinterCanvas.CalcTextSize(const Text: String;
  InitRectWidth: Integer; WordWrap: Boolean): TSize;
begin
  raise Exception.Create('Method "CalcTextSize" is not implemented');
end;

function TBasePrinterCanvas.TextExtent(const Text: string): TSize;
begin
  raise Exception.Create('Method "TextExtent" is not implemented');
end;

function TBasePrinterCanvas.TextHeight(const Text: string): Integer;
begin
  Result := TextExtent(Text).cY;
end;

function TBasePrinterCanvas.TextWidth(const Text: string): Integer;
begin
  Result := TextExtent(Text).cX;
end;

procedure TBasePrinterCanvas.TextOut(X, Y: Integer; const Text: string);
begin
  raise Exception.Create('Method "TextOut" is not implemented');
end;

procedure TBasePrinterCanvas.VerticalTextRect(var Rect: TRect; var Text: string;
  ATextFormat: TTextFormat);
begin
  raise Exception.Create('Method "VerticalTextRect" is not implemented');
end;

procedure TBasePrinterCanvas.TextRect(Rect: TRect; X, Y: Integer; const Text: string);
begin
  raise Exception.Create('Method "TextRect" is not implemented');
end;

procedure TBasePrinterCanvas.TextRect(var Rect: TRect; var Text: string; ATextFormat: TTextFormat);
begin
  raise Exception.Create('Method "TextRect" is not implemented');
end;

function TBasePrinterCanvas.GetHandle: HDC;
begin
  raise Exception.Create('Method "GetHandle" is not implemented');
end;

procedure TBasePrinterCanvas.SetHandle(const Value: HDC);
begin
  raise Exception.Create('Method "SetHandle" is not implemented');
end;

function TBasePrinterCanvas.GetIsHandleSupported: Boolean;
begin
  Result := False;
end;

function TBasePrinterCanvas.GetBrush: TBrush;
begin
  raise Exception.Create('Method "GetBrush" is not implemented');
end;

function TBasePrinterCanvas.GetCopyMode: TCopyMode;
begin
  raise Exception.Create('Method "GetCopyMode" is not implemented');
end;

function TBasePrinterCanvas.GetFont: TFont;
begin
  raise Exception.Create('Method "GetFont" is not implemented');
end;

function TBasePrinterCanvas.GetPen: TPen;
begin
  raise Exception.Create('Method "GetPen" is not implemented');
end;

procedure TBasePrinterCanvas.SetPen(const Value: TPen);
begin
  raise Exception.Create('Method "SetPen" is not implemented');
end;

procedure TBasePrinterCanvas.SetBrush(const Value: TBrush);
begin
  raise Exception.Create('Method "SetBrush" is not implemented');
end;

procedure TBasePrinterCanvas.SetCopyMode(const Value: TCopyMode);
begin
  raise Exception.Create('Method "SetCopyMode" is not implemented');
end;

procedure TBasePrinterCanvas.SetFont(const Value: TFont);
begin
  raise Exception.Create('Method "SetFont" is not implemented');
end;

procedure TBasePrinterCanvas.GetTextMetrics(out tm: TTextMetric);
begin
  raise Exception.Create('Method "GetTextMetrics" is not implemented');
end;

function TBasePrinterCanvas.GetPixelsPerInchX: Integer;
begin
  raise Exception.Create('Method "GetPixelsPerInchX" is not implemented');
end;

function TBasePrinterCanvas.GetPixelsPerInchY: Integer;
begin
  raise Exception.Create('Method "GetPixelsPerInchY" is not implemented');
end;

procedure TBasePrinterCanvas.SetCanvasOrigin(xOrg, yOrg: Integer);
begin
  raise Exception.Create('Method "SetCanvasOrigin" is not implemented');
end;

procedure TBasePrinterCanvas.SetCanvasScale(xMult, xDivd, yMult, yDivd: Integer);
begin
  raise Exception.Create('Method "SetCanvasScale" is not implemented');
end;

function TBasePrinterCanvas.GetRotationDegree: Single;
begin
  raise Exception.Create('Method "GetRotationDegree" is not implemented');
end;

procedure TBasePrinterCanvas.SetRotationDegree(const Value: Single);
begin
  raise Exception.Create('Method "SetRotationDegree" is not implemented');
end;

procedure TBasePrinterCanvas.DrawRtfText(RtfText: String;
  FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer;
  out Pages, LastPageBlockHeight: Integer);
begin
  raise Exception.Create('Method "DrawRtfText" is not implemented');
end;

procedure TBasePrinterCanvas.MeasureRtfTextLayout(RichText: String;
  FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft,
  BlockRight: Integer; out Pages: Integer; out LastPageBlockHeight: Integer);
begin
  raise Exception.Create('Method "MeasureRtfTextLayout" is not implemented');
end;

procedure TBasePrinterCanvas.AppendClipRect(AClipRect: TRect);
begin
  raise Exception.Create('Method "AppendClipRect" is not implemented');
end;

procedure TBasePrinterCanvas.RestoreClip;
begin
  raise Exception.Create('Method "AppendClipRect" is not implemented');
end;

{ TVirtualPrinterCanvas }

constructor TVirtualPrinterCanvas.Create(AVirtualPrinter: TBaseVirtualPrinter);
begin
  inherited Create(AVirtualPrinter);
  FRotationDegree := 0;
  FClipList := TList<HRgn>.Create;
end;

destructor TVirtualPrinterCanvas.Destroy;
begin
  while FClipList.Count > 0 do
  begin
    RestoreClip;
  end;
  FreeAndNil(FClipList);

  inherited Destroy;
end;

function TVirtualPrinterCanvas.GetPrinter: TVirtualPrinter;
begin
  Result := TVirtualPrinter(inherited Printer);
end;

function TVirtualPrinterCanvas.GetDeviceCanvas: TCanvas;
begin
  Result := Printer.DeviceCanvas;
end;


function TVirtualPrinterCanvas.GetCanvasOrientation: TCanvasOrientation;
begin
  {$IFDEF FPC}
  Result := csLefttoRight;
  {$ELSE}
  Result := DeviceCanvas.CanvasOrientation;
  {$ENDIF}
end;

function TVirtualPrinterCanvas.CalcTextSize(const Text: String;
  InitRectWidth: Integer; WordWrap: Boolean): TSize;
{$IFDEF FPC}
begin
  //TODO for FPC
  Result.cx := 0;
  Result.cy := 0;
end;
{$ELSE}
var
  ARect: TRect;
  AText: String;
  TextFormat: TTextFormat;
begin
  ARect := Rect(0, 0, InitRectWidth, 0);
  AText := Text;
  TextFormat := [tfCalcRect];
  //tfExternalLeading, tfSingleLine, tfHidePrefix, tfNoFullWidthCharBreak
  if WordWrap then
    TextFormat := TextFormat + [tfWordBreak];
  DeviceCanvas.TextRect(ARect, AText, TextFormat);

  Result.cx := RectWidth(ARect);
  Result.cy := RectHeight(ARect);
end;
{$ENDIF}

procedure TVirtualPrinterCanvas.GetTextMetrics(out tm: TTextMetric);
begin
  GetTextMetricsEh(DeviceCanvas, tm);
end;

function TVirtualPrinterCanvas.GetClipRect: TRect;
begin
  Result := DeviceCanvas.ClipRect;
end;

function TVirtualPrinterCanvas.GetHandle: HDC;
begin
  Result := DeviceCanvas.Handle;
end;

function TVirtualPrinterCanvas.GetIsHandleSupported: Boolean;
begin
  Result := True;
end;

function TVirtualPrinterCanvas.GetPenPos: TPoint;
begin
  Result := DeviceCanvas.PenPos;
end;

function TVirtualPrinterCanvas.GetPixel(X, Y: Integer): TColor;
begin
  Result := DeviceCanvas.Pixels[X, Y];
end;

function TVirtualPrinterCanvas.GetPixelsPerInchX: Integer;
begin
  Result := GetDeviceCaps(DeviceCanvas.Handle, LOGPIXELSX);
end;

function TVirtualPrinterCanvas.GetPixelsPerInchY: Integer;
begin
  Result := GetDeviceCaps(DeviceCanvas.Handle, LOGPIXELSY);
end;

procedure TVirtualPrinterCanvas.SetHandle(const Value: HDC);
begin
  DeviceCanvas.Handle := Value;
end;

procedure TVirtualPrinterCanvas.SetPenPos(const Value: TPoint);
begin
  DeviceCanvas.PenPos := Value;
end;

procedure TVirtualPrinterCanvas.SetPixel(X, Y: Integer; const Value: TColor);
begin
  DeviceCanvas.Pixels[X, Y] := Value;
end;

procedure TVirtualPrinterCanvas.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  DeviceCanvas.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure TVirtualPrinterCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  DeviceCanvas.Draw(X, Y, Graphic);
end;

procedure TVirtualPrinterCanvas.Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte);
begin
  {$IFDEF FPC}
  DeviceCanvas.Draw(X, Y, Graphic);
  {$ELSE}
  DeviceCanvas.Draw(X, Y, Graphic, Opacity);
  {$ENDIF}
end;

procedure TVirtualPrinterCanvas.DrawFocusRect(const Rect: TRect);
begin
  DeviceCanvas.DrawFocusRect(Rect);
end;

procedure TVirtualPrinterCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  DeviceCanvas.Ellipse(X1, Y1, X2, Y2);
end;

procedure TVirtualPrinterCanvas.FillRect(const Rect: TRect);
begin
  DeviceCanvas.FillRect(Rect);
end;

procedure TVirtualPrinterCanvas.FloodFill(X, Y: Integer; Color: TColor;
  FillStyle: TFillStyle);
begin
  DeviceCanvas.FloodFill(X, Y, Color, FillStyle);
end;

procedure TVirtualPrinterCanvas.FrameRect(const Rect: TRect);
begin
  DeviceCanvas.FrameRect(Rect);
end;

procedure TVirtualPrinterCanvas.StretchDraw(const Rect: TRect;
  Graphic: TGraphic);
begin
  DeviceCanvas.StretchDraw(Rect, Graphic);
end;

function TVirtualPrinterCanvas.GetBrush: TBrush;
begin
  Result := DeviceCanvas.Brush;
end;

function TVirtualPrinterCanvas.GetCopyMode: TCopyMode;
begin
  Result := DeviceCanvas.CopyMode;
end;

function TVirtualPrinterCanvas.GetFont: TFont;
begin
  Result := DeviceCanvas.Font;
end;

function TVirtualPrinterCanvas.GetPen: TPen;
begin
  Result := DeviceCanvas.Pen;
end;

procedure TVirtualPrinterCanvas.SetPen(const Value: TPen);
begin
  DeviceCanvas.Pen := Value;
end;

procedure TVirtualPrinterCanvas.SetBrush(const Value: TBrush);
begin
  DeviceCanvas.Brush := Value;
end;

procedure TVirtualPrinterCanvas.SetCanvasOrigin(xOrg, yOrg: Integer);
begin
  SetMapMode(DeviceCanvas.Handle, mm_Anisotropic);
  SetViewportOrgEx(DeviceCanvas.Handle, xOrg, yOrg, nil);
end;

procedure TVirtualPrinterCanvas.SetCanvasScale(xMult, xDivd, yMult, yDivd: Integer);
begin
  SetMapMode(DeviceCanvas.Handle, mm_Anisotropic);
  SetViewportExtEx(DeviceCanvas.Handle, xMult, yMult, nil);
  SetWindowExtEx(DeviceCanvas.Handle, xDivd, yDivd, nil);
end;

procedure TVirtualPrinterCanvas.SetCopyMode(const Value: TCopyMode);
begin
  DeviceCanvas.CopyMode := Value;
end;

procedure TVirtualPrinterCanvas.SetFont(const Value: TFont);
begin
  DeviceCanvas.Font := Value;
end;

function TVirtualPrinterCanvas.TextExtent(const Text: string): TSize;
begin
  Result := DeviceCanvas.TextExtent(Text);
end;

procedure TVirtualPrinterCanvas.TextOut(X, Y: Integer; const Text: string);
begin
  DeviceCanvas.TextOut(X, Y, Text);
end;

procedure TVirtualPrinterCanvas.TextRect(var Rect: TRect; var Text: string; ATextFormat: TTextFormat);
begin
  {$IFDEF FPC}
  // TODO: for FPC
  {$ELSE}
  DeviceCanvas.TextRect(Rect, Text, ATextFormat);
  {$ENDIF}
end;

procedure TVirtualPrinterCanvas.VerticalTextRect(var ARect: TRect;
  var AText: string; ATextFormat: TTextFormat);
{$IFDEF FPC}
begin

end;
{$ELSE}
var
  Alignment: TAlignment;
  Layout: TTextLayout;
  WordWrap: Boolean;
  EndEllipsis: Boolean;
begin
  if tfCalcRect in ATextFormat then
    raise Exception.Create('tfCalcRect in TVirtualPrinterCanvas.VerticalTextRect is not supported');

  if tfRight in ATextFormat then
    Alignment := taRightJustify
  else if tfCenter in ATextFormat then
    Alignment := taRightJustify
  else
     Alignment := taLeftJustify;

  if tfVerticalCenter in ATextFormat then
    Layout := tlCenter
  else if tfBottom in ATextFormat then
    Layout := tlBottom
  else
    Layout := tlTop;

  WordWrap := tfWordBreak in ATextFormat;
  EndEllipsis := tfEndEllipsis in ATextFormat;

  WriteTextVerticalEh(DeviceCanvas, ARect, False, 0, 0, AText, Alignment, Layout, WordWrap, EndEllipsis, False);
end;
{$ENDIF}

procedure TVirtualPrinterCanvas.TextRect(Rect: TRect; X, Y: Integer; const Text: string);
begin
  DeviceCanvas.TextRect(Rect, X, Y, Text);
end;

procedure TVirtualPrinterCanvas.AngleArc(X, Y: Integer; Radius: Cardinal;
  StartAngle, SweepAngle: Single);
begin
{$IFDEF EH_LIB_14}
  DeviceCanvas.AngleArc(X, Y, Radius, StartAngle, SweepAngle);
{$ELSE}
{$ENDIF}
end;

procedure TVirtualPrinterCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  DeviceCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure TVirtualPrinterCanvas.ArcTo(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
{$IFDEF EH_LIB_14}
  DeviceCanvas.ArcTo(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
{$ELSE}
{$ENDIF}
end;

procedure TVirtualPrinterCanvas.BrushCopy(const Dest: TRect; Bitmap: TBitmap;
  const Source: TRect; Color: TColor);
begin
  DeviceCanvas.BrushCopy(Dest, Bitmap, Source, Color);
end;

procedure TVirtualPrinterCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  DeviceCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure TVirtualPrinterCanvas.PolyBezier(const Points: array of TPoint);
begin
  DeviceCanvas.PolyBezier(Points);
end;

procedure TVirtualPrinterCanvas.PolyBezierTo(const Points: array of TPoint);
begin
  {$IFDEF FPC}
  //TODO: For FPC
  {$ELSE}
  DeviceCanvas.PolyBezierTo(Points);
  {$ENDIF}
end;

procedure TVirtualPrinterCanvas.Polygon(const Points: array of TPoint);
begin
  DeviceCanvas.Polygon(Points);
end;

procedure TVirtualPrinterCanvas.Polyline(const Points: array of TPoint);
begin
  DeviceCanvas.Polyline(Points);
end;

procedure TVirtualPrinterCanvas.Rectangle(X1, Y1, X2, Y2: Integer);
begin
  DeviceCanvas.Rectangle(X1, Y1, X2, Y2);
end;

procedure TVirtualPrinterCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  DeviceCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3);
end;

procedure TVirtualPrinterCanvas.LineTo(X, Y: Integer);
begin
  DeviceCanvas.LineTo(X, Y);
end;

procedure TVirtualPrinterCanvas.MoveTo(X, Y: Integer);
begin
  DeviceCanvas.MoveTo(X, Y);
end;

function TVirtualPrinterCanvas.GetRotationDegree: Single;
begin
  Result := FRotationDegree;
end;

procedure TVirtualPrinterCanvas.SetRotationDegree(const Value: Single);
{$IFDEF FPC}
begin
  //TODO: For FPC
end;
{$ELSE}
var
  {$IFDEF FPC}
  XForm: TXFORM;
  {$ELSE}
  XForm: tagXFORM;
  {$ENDIF}
  C: Single;
  S: Single;
  Rads: Single;
begin
  FRotationDegree := Value;
  Rads := Math.DegToRad(Value {-90});
  C := Cos(Rads);
  S := Sin(Rads);
  XForm.eM11 := C;
  XForm.eM12 := S;
  XForm.eM21 := -S;
  XForm.eM22 := C;
  XForm.eDx := 0;
  XForm.eDy := 0;

  SetGraphicsMode(DeviceCanvas.Handle, GM_ADVANCED);
  SetWorldTransform(DeviceCanvas.Handle, XForm);
end;
{$ENDIF}

procedure TVirtualPrinterCanvas.AppendClipRect(AClipRect: TRect);
var
  Rgn, SaveRgn: HRgn;
  Flag: Integer;
  ClipRgn: HRgn;
begin
  SaveRgn := CreateRectRgn(0, 0, 0, 0);
  Flag := GetClipRgn(DeviceCanvas.Handle, SaveRgn);
  Rgn := CreateRectRgn(AClipRect.Left, AClipRect.Top, AClipRect.Right, AClipRect.Bottom);
  ExtSelectClipRgn(DeviceCanvas.Handle, Rgn, RGN_AND);
  DeleteObject(Rgn);
  if Flag = 0 then
  begin
    ClipRgn := 0;
    DeleteObject(SaveRgn);
  end else
    ClipRgn := SaveRgn;

  FClipList.Add(ClipRgn);
end;

procedure TVirtualPrinterCanvas.RestoreClip;
var
  ClipRgn: HRgn;
begin
  ClipRgn := FClipList[FClipList.Count - 1];
  FClipList.Delete(FClipList.Count - 1);

  if ClipRgn = 0 then
    SelectClipRgn(DeviceCanvas.Handle, 0)
  else
  begin
    SelectClipRgn(DeviceCanvas.Handle, ClipRgn);
    DeleteObject(ClipRgn);
  end;
end;

{$IFDEF FPC}
{$ELSE}
var
  FBufferedRichEdit: TDBRichEditEh;

function BufferedRichEdit: TDBRichEditEh;
begin
  if (FBufferedRichEdit = nil) then
  begin
    FBufferedRichEdit := TDBRichEditEh.Create(nil);

    //FBufferedRichEdit.Visible := False;
    FBufferedRichEdit.SetBounds(0, 0, 0, 0);
    FBufferedRichEdit.Enabled := False;

    FBufferedRichEdit.ScrollBars := ssBoth;
  end;

  Result := FBufferedRichEdit;
end;
{$ENDIF}

procedure FreeBufferedRichEdit;
begin
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(FBufferedRichEdit);
  {$ENDIF}
end;

procedure TVirtualPrinterCanvas.DrawRtfText(RichText: String; FirstPageBlockTop,
  NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight: Integer;
  out Pages, LastPageBlockHeight: Integer);
begin
  InternalDrawRtfText(RichText,
    FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight,
    DefaultNewPageProc, False,
    Pages, LastPageBlockHeight);
end;

procedure TVirtualPrinterCanvas.MeasureRtfTextLayout(RichText: String;
  FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft,
  BlockRight: Integer; out Pages, LastPageBlockHeight: Integer);
begin
  InternalDrawRtfText(RichText,
    FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight,
    DefaultNewPageProc, True,
    Pages, LastPageBlockHeight);
end;

procedure TVirtualPrinterCanvas.DefaultNewPageProc(Sender: TObject);
begin
  Printer.NewPage;
end;

procedure TVirtualPrinterCanvas.InternalDrawRtfText(RichText: String;
  FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft,
  BlockRight: Integer; NewPageProc: TNotifyEvent; MeasureLayout: Boolean;
  out Pages, LastPageBlockHeight: Integer);
{$IFDEF FPC}
begin
  //TODO For FPC
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
  LogDataPrintRec: TRect;

  function ScaleRect(ARect: TRect; XMul, YMul, XDiv, YDiv: Integer): TRect;
  begin
    Result.Left := ARect.Left * XMul div XDiv;
    Result.Right := ARect.Right * XMul div XDiv;
    Result.Top := ARect.Top * YMul div YDiv;
    Result.Bottom := ARect.Bottom * YMul div YDiv;
  end;

begin

  Pages := 0;
  LastPageBlockHeight := 0;

  if RichText <> '' then
  begin
    BufferedRichEdit.ParentWindow := Application.Handle;
    s := SysErrorMessage(GetLastError);
    BufferedRichEdit.RtfText := RichText;
    s := SysErrorMessage(GetLastError);

    if MeasureLayout
      then RangeMode := 0
      else RangeMode := 1;

    FillChar(Range, SizeOf(TFormatRange), 0);
    begin
      LogX := PixelsPerInchX;
      LogY := PixelsPerInchY;
      LastChar := 0;

{$IFDEF EH_LIB_12}
      TextLen.Flags := GTL_NUMCHARS;
      TextLen.CodePage := 1200;  
      MaxLen := SendMessage(BufferedRichEdit.Handle,
                              EM_GETTEXTLENGTHEX, WPARAM(@TextLen), 0);
      s := SysErrorMessage(GetLastError);
{$ELSE}
      MaxLen := BefortAfterRichText.GetTextLen;
{$ENDIF}

      Range.chrg.cpMax := -1;
      SendMessage(BufferedRichEdit.Handle, EM_FORMATRANGE, 0, 0); 
      s := SysErrorMessage(GetLastError);
      LogDataPrintRec := Rect(BlockLeft, FirstPageBlockTop, BlockRight, BlockBottom);
      Pages := 0;
      try
        repeat
          SaveRect := LogDataPrintRec;
          if (Pages >= 1) then
            SaveRect.Top := NextPagesBlockTop;
          SaveRect := ScaleRect(SaveRect, 1440, 1440, LogX, LogY);
          Range.rc := SaveRect;
          Range.rcPage := Range.rc;
          Range.chrg.cpMin := LastChar;
          Range.hdc := Printer.Canvas.Handle;
{ TODO  : When printer is not installed we get error. }
          Range.hdcTarget := Printer.Canvas.Handle;
          LastChar := SendStructMessage(BufferedRichEdit.Handle, EM_FORMATRANGE, RangeMode, Range);
          s := SysErrorMessage(GetLastError);

          Range.rc := ScaleRect(Range.rc, LogX, LogY, 1440, 1440);
          LastPageBlockHeight := Range.rc.Bottom - Range.rc.Top;
          if LastChar = 0 then Break;

          if (LastChar < MaxLen) and (LastChar <> -1) then
          begin
            if not MeasureLayout then
            begin
              NewPageProc(Self);
            end;
          end;
          Inc(Pages);
        until (LastChar >= MaxLen) or (LastChar = -1);
      finally
        SendMessage(BufferedRichEdit.Handle, EM_FORMATRANGE, 0, 0); 
      end;

      BufferedRichEdit.ParentWindow := HWND(0);
    end;
  end;
end;
{$ENDIF}

initialization
  VirtualPrinter := TVirtualPrinter.Create;
finalization
  FreeAndNil(VirtualPrinter);
  FreeBufferedRichEdit;
end.
