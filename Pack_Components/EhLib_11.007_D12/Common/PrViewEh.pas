{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                  TPreviewBox component                }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrViewEh {$IFDEF CIL} platform{$ENDIF};

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, PrntsEh,
{$IFDEF CIL}
  WinUtils,
{$ELSE}
{$ENDIF}
{$IFDEF FPC}
  EhLibLCL,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  Contnrs, ExtCtrls, Printers, Math, GridsEh;

type

  TViewMode = (vm500, vm200, vm150, vm100, vm75, vm50, vm25, vm10, vmPageWidth, vmFullPage);

  TPrinterPreview = class;

{$IFDEF OLDPREVIEWBOX}

{$ELSE}

{ TPreviewBox }

  TPreviewBox = class(TCustomGridEh)
  private
    FPageCount: Integer;
    FViewMode: TViewMode;
    FPageIndex: Integer;
    FPrinter: TPrinterPreview;
    FPrinterSetupOwner: TComponent;
    FOnPrinterSetupDialog: TNotifyEvent;
    FOnPrinterSetupChanged: TNotifyEvent;
    FOnPrinterPreviewChanged: TNotifyEvent;
    FOnOpenPreviewer: TNotifyEvent;
    FLayoutChanging: Integer;

    procedure DrawPage(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState; PageIndex: Integer);
    procedure FillBackground(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
    procedure SetPageIndex(Value: Integer);
    procedure SetPrinter(const Value: TPrinterPreview);
    procedure SetPrinterSetupOwner(const Value: TComponent);
    procedure SetViewMode(const Value: TViewMode);

    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;

  protected
    FScalePercent: Integer;
    FOldMousePos: TPoint;
    FOldRolPos: TPoint;

    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; State: TGridDrawState); override;
    procedure GetPageDispaySize(var PageWidth, PageHeight: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetPageCount(NewPageCount: Integer);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function LayoutChanging: Boolean;

    procedure UpdatePreview;
    procedure PrintDialog;
    procedure PrinterSetupDialog;
    procedure UpdatePageSetup;

    procedure BeginLayout;
    procedure EndLayout;

    property PageCount: Integer read FPageCount;
    property PageIndex: Integer read FPageIndex write SetPageIndex;
    property Printer: TPrinterPreview read FPrinter write SetPrinter;
    property PrinterSetupOwner: TComponent read FPrinterSetupOwner write SetPrinterSetupOwner;
    property ViewMode: TViewMode read FViewMode write SetViewMode;

    property OnPrinterSetupDialog: TNotifyEvent read FOnPrinterSetupDialog { write FOnPrinterSetupDialog};
    property OnPrinterSetupChanged: TNotifyEvent read FOnPrinterSetupChanged { write FOnPrinterSetupChanged};

  published
    property Align;
    property TabOrder;
    property Visible;

    property OnOpenPreviewer: TNotifyEvent read FOnOpenPreviewer write FOnOpenPreviewer;
    property OnPrinterPreviewChanged: TNotifyEvent read FOnPrinterPreviewChanged write FOnPrinterPreviewChanged;
  end;

{$ENDIF}

{ TPrinterPreview }

  TPrinterPreview = class(TVirtualPrinter)
  private
    FAborted: Boolean;
    FMetafileCanvas: TMetafileCanvas;
    FMetafileList: TObjectListEh;
    FPageNumber: Integer;
    FPreviewer: TPreviewBox;
    FPrinter: TPrinter;
    FPrinterSetupOwner: TComponent;
    FPrinting: Boolean;

    FOnPrinterSetupChanged: TNotifyEvent;
    FOnPrinterSetupDialog: TNotifyEvent;

    function GetPropPrinter: TPrinter;
    procedure SetOnPrinterSetupDialog(const Value: TNotifyEvent);
    procedure SetPreviewer(const Value: TPreviewBox);

  protected
    function GetAborted: Boolean; override;
    function GetDeviceCanvas: TCanvas; override;
    function GetCapabilities: TPrinterCapabilities; override;
    function GetFonts: TStrings; override;
    function GetFullPageHeight: Integer; override;
    function GetFullPageWidth: Integer; override;
    function GetHandle: HDC; override;
    function GetCopies: Integer; override;
    function GetOrientation: TPrinterOrientation; override;
    function GetPageHeight: Integer; override;
    function GetPageNumber: Integer; override;
    function GetPageWidth: Integer; override;
    function GetPrinterIndex: Integer; override;
    function GetPrinters: TStrings; override;
    function GetPrinting: Boolean; override;
    function GetTitle: String; override;
    function GetPixelsPerInchX: Integer; override;
    function GetPixelsPerInchY: Integer; override;

    procedure DrawPage(Sender: TObject; Canvas: TCanvas; PageNumber: Integer); overload;
    procedure DrawPage(Sender: TObject; Canvas: TCanvas; PageNumber: Integer; ADrawRect: TRect); overload;
    procedure SetCopies(const Value: Integer); override;
    procedure SetOrientation(const Value: TPrinterOrientation); override;
    procedure SetPrinterIndex(const Value: Integer); override;
    procedure SetTitle(const Value: string); override;
    procedure ShowProgress(Percent: Integer); virtual;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Abort; override;
    procedure BeginDoc; override;
    procedure EndDoc; override;
{$IFDEF CIL}
    procedure GetPrinter(ADevice, ADriver, APort: String; var ADeviceMode: IntPtr); override;
    procedure SetPrinter(ADevice, ADriver, APort: String; ADeviceMode: IntPtr); override;
{$ELSE}
    procedure GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle); override;
    procedure SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle); override;
{$ENDIF}
    procedure NewPage; override;
    procedure OpenPreview;
    procedure Print;

    property Previewer: TPreviewBox read FPreviewer write SetPreviewer;
    property Printer: TPrinter read GetPropPrinter;
    property PrinterSetupOwner: TComponent read FPrinterSetupOwner write FPrinterSetupOwner;
    property PixelsPerInchX: Integer read GetPixelsPerInchX;
    property PixelsPerInchY: Integer read GetPixelsPerInchY;

    property OnPrinterSetupChanged: TNotifyEvent read FOnPrinterSetupChanged write FOnPrinterSetupChanged;
    property OnPrinterSetupDialog: TNotifyEvent read FOnPrinterSetupDialog write SetOnPrinterSetupDialog;
  end;


function PrinterPreview: TPrinterPreview;
function SetPrinterPreview(NewPrinterPreview: TPrinterPreview): TPrinterPreview;

const
  DefaultPrinterPhysicalOffSetX: Integer = 130;
  DefaultPrinterPhysicalOffSetY: Integer = 150;
  DefaultPrinterPageWidth: Integer = 4676;
  DefaultPrinterPageHeight: Integer = 6744;
  DefaultPrinterPixelsPerInchX: Integer = 600;
  DefaultPrinterPixelsPerInchY: Integer = 600;
  DefaultPrinterVerticalSizeMM: Integer = 285;
  DefaultPrinterHorizontalSizeMM: Integer = 198;

implementation

{$IFNDEF MSWINDOWS}
  {$R PrViewEh_NextGen.RES}
{$ELSE}
  {$R PrViewEh.RES}
{$ENDIF}

uses PrvFrmEh, Types;

var
  crMagnifier: Integer = 0;
  crHand: Integer = 0;

var
  FPrinterPreview: TPrinterPreview = nil;
{$IFDEF OLDPREVIEWBOX}
  DrawBitmap: TBitmap;
{$ELSE}
{$ENDIF}

function PrintersSetPrinter(NewPrinter: TPrinter): TPrinter;
begin
  Result := SetPrinter(NewPrinter);
end;

function PrintersPrinter: TPrinter;
begin
  Result := Printer;
end;

{$IFDEF OLDPREVIEWBOX}

{$ELSE}

{ TPreviewBox }

constructor TPreviewBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Options := [];
  ControlStyle := ControlStyle + [csClickEvents];
  FPrinter := TPrinterPreview.Create;
  FPrinter.Previewer := Self;
  FViewMode := vm100;
  VertScrollBar.SmoothStep := True;
  VertScrollBar.VisibleMode := sbAlwaysShowEh;
  HorzScrollBar.SmoothStep := True;
  HorzScrollBar.VisibleMode := sbAlwaysShowEh;
end;

destructor TPreviewBox.Destroy;
begin
  FreeAndNil(FPrinter);
  inherited Destroy;
end;

procedure TPreviewBox.DrawCell(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
begin
  if (ACol = 0) or (ACol = 2) or (ARow = 0) or (ARow = RowCount-1) then
    FillBackground(ACol, ARow, ARect, State)
  else
    DrawPage(ACol, ARow, ARect, State, ARow-1);
end;

procedure TPreviewBox.FillBackground(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState);
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ARect);
end;

procedure TPreviewBox.DrawPage(ACol, ARow: Integer; ARect: TRect;
  State: TGridDrawState; PageIndex: Integer);
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ARect);
  InflateRect(ARect, -8, -8);

  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(ARect);
  if Assigned(Printer) and (PageCount > 0) then
    Printer.DrawPage(Self, Canvas, PageIndex+1, ARect);

  Canvas.Brush.Color := clBlack;
  Canvas.FrameRect(ARect);
end;

procedure TPreviewBox.BeginLayout;
begin
  FLayoutChanging := FLayoutChanging + 1;
end;

procedure TPreviewBox.EndLayout;
begin
  FLayoutChanging := FLayoutChanging - 1;
end;

function TPreviewBox.LayoutChanging: Boolean;
begin
  Result := (FLayoutChanging > 0);
end;

procedure TPreviewBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
  begin
    SetFocus;
    if {not Focused}not IsActiveControl then
    begin
      MouseCapture := False;
      Exit;
    end;
  end;
  FOldMousePos := Point(X, Y);
  FOldRolPos := Point(HorzAxis.RolStartVisPos, VertAxis.RolStartVisPos);
end;

procedure TPreviewBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if (ssLeft in Shift) and
    ((FOldMousePos.x <> X) or (FOldMousePos.y <> Y) or (Cursor = crHand)) and
    MouseCapture
  then
  begin
    if (Cursor <> crHand) then
    begin
      Cursor := crHand;
      Perform(WM_SETCURSOR, Handle, HTCLIENT);
    end;
    SafeScrollDataTo(FOldRolPos.X + (FOldMousePos.X - X), FOldRolPos.Y + (FOldMousePos.Y - Y));
  end;
end;

procedure TPreviewBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Button = mbLeft) and (Cursor = crMagnifier) then
  begin
    if ViewMode = vmFullPage then
      ViewMode := vm150
    else
      ViewMode := vmFullPage;
  end else
    Cursor := crMagnifier;
end;

procedure TPreviewBox.PrintDialog;
var
  Page: Integer;
  OldPrinter: TPrinter;
  CurPrtr: TPrinter;
  pd: TPrintDialog;
begin
  OldPrinter := PrintersSetPrinter(Printer.Printer);
  try
    pd := TPrintDialog.Create(Owner);
    try
      pd.Options := pd.Options + [poPageNums];
      pd.MinPage := 1;
      pd.MaxPage := PageCount;
      pd.FromPage := 1;
      pd.ToPage := PageCount;
      if pd.Execute then
        if Assigned(Printer) then
        begin
          if Printer.FMetafileList.Count = 0 then Exit;
          CurPrtr := PrintersPrinter;
          CurPrtr.BeginDoc;
          for Page := pd.FromPage to pd.ToPage do
          begin
            Printer.DrawPage(Printer, CurPrtr.Canvas, Page);
            if Page < pd.ToPage then CurPrtr.NewPage;
          end;
          CurPrtr.EndDoc;
        end;
    finally
      pd.Free;
    end;
  finally
    PrintersSetPrinter(OldPrinter);
  end;
end;

procedure TPreviewBox.PrinterSetupDialog;
var
  OldPrinter: TPrinter;
  psd: TPrinterSetupDialog;
begin
  OldPrinter := PrintersSetPrinter(Printer.Printer);
  try
    if Assigned(OnPrinterSetupDialog) then
      OnPrinterSetupDialog(Self)
    else
    begin
      psd := TPrinterSetupDialog.Create(Owner);
      try
        if psd.Execute then
        begin
          UpdatePageSetup;
          if Assigned(FOnPrinterSetupChanged)
            then FOnPrinterSetupChanged(Self);
        end;
      finally
        psd.Free;
      end;
    end;
  finally
    PrintersSetPrinter(OldPrinter);
  end;
end;

procedure TPreviewBox.SetPageCount(NewPageCount: Integer);
begin
  FPageCount := NewPageCount;
  UpdatePreview;
end;

procedure TPreviewBox.SetPageIndex(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > PageCount then Value := PageCount;
  if Value <> FPageIndex then
  begin
    FPageIndex := Value;
    SafeSetTopRow(PageIndex);
    if Assigned(OnPrinterPreviewChanged) then OnPrinterPreviewChanged(Self);
  end;
end;

procedure TPreviewBox.SetPrinter(const Value: TPrinterPreview);
begin
  if FPrinter <> Value then
  begin
    FPrinter := Value;
    UpdatePreview;
  end;
end;

procedure TPreviewBox.SetPrinterSetupOwner(const Value: TComponent);
begin
  FPrinterSetupOwner := Value;
  UpdatePageSetup;
end;

procedure TPreviewBox.SetViewMode(const Value: TViewMode);
begin
  if FViewMode <> Value then
  begin
    FViewMode := Value;
    UpdatePageSetup;
  end;
end;

procedure TPreviewBox.UpdatePageSetup;
var
  PageWidth, PageHeight: Integer;
  i: Integer;
  DataHeight: Integer;
begin
  if LayoutChanging then Exit;
  BeginLayout;
  try
    UpdatePreview;
    GetPageDispaySize(PageWidth, PageHeight);
    ColWidths[0] := 100;
    ColWidths[2] := 100;
    ColWidths[1] := PageWidth;
    if PageWidth >= GridClientWidth then
    begin
      ColWidths[0] := 0;
      ColWidths[2] := 0;
    end else
    begin
      ColWidths[0] := (GridClientWidth - PageWidth) div 2;
      ColWidths[2] := GridClientWidth - (ColWidths[0] + ColWidths[1]);
    end;

    DataHeight := 0;
    for i := 1 to RowCount-2 do
    begin
      RowHeights[i] := PageHeight;
      DataHeight := DataHeight + PageHeight;
    end;

    if DataHeight >= GridClientHeight then
    begin
      RowHeights[0] := 0;
      RowHeights[RowCount-1] := 0;
    end else
    begin
      RowHeights[0] := (GridClientHeight - DataHeight) div 2;
      RowHeights[RowCount-1] := GridClientHeight - (DataHeight + RowHeights[0]);
    end;
  finally
    EndLayout;
  end;
end;

procedure TPreviewBox.GetPageDispaySize(var PageWidth, PageHeight: Integer);
var
  Scaling: Integer;
  AWidth, AHeight: Integer;
begin
  AWidth := Width;
  AHeight := Height;

  case FViewMode of
    vm500: Scaling := 500;
    vm200: Scaling := 200;
    vm150: Scaling := 150;
    vm100: Scaling := 100;
    vm75: Scaling := 75;
    vm50: Scaling := 50;
    vm25: Scaling := 25;
    vm10: Scaling := 10;
    vmPageWidth:
      begin
        Scaling := 1;
        AWidth := Self.Width - 20 - GetSystemMetrics(sm_CXVScroll);
        if Printer.Printers.Count > 0 then
        begin
          AHeight := AWidth * GetDeviceCaps(Printer.Handle, VertSize) div
            GetDeviceCaps(Printer.Handle, HorzSize);
          FScalePercent := AWidth * 100 div (Printer.PageWidth * (Self.Owner as TForm).PixelsPerInch div
            GetDeviceCaps(Printer.Handle, LOGPIXELSX));
        end else
        begin
          AHeight := AWidth * DefaultPrinterVerticalSizeMM div
            DefaultPrinterHorizontalSizeMM;
          FScalePercent := AWidth * 100 div (Printer.PageWidth * (Self.Owner as TForm).PixelsPerInch div
            DefaultPrinterPixelsPerInchX);
        end;
      end;
    vmFullPage:
      begin
        Scaling := 1;
        AHeight := Self.ClientHeight - 16;
        if Printer.Printers.Count > 0 then
          AWidth := AHeight * GetDeviceCaps(Printer.Handle, HorzSize) div
            GetDeviceCaps(Printer.Handle, VertSize)
        else
          AWidth := AHeight * DefaultPrinterHorizontalSizeMM div
            DefaultPrinterVerticalSizeMM;
        if AWidth > Self.ClientWidth - 16 then
        begin
          AWidth := Self.ClientWidth - 16;
          if Printer.Printers.Count > 0 then
            AHeight := AWidth * GetDeviceCaps(Printer.Handle, VertSize) div
              GetDeviceCaps(Printer.Handle, HorzSize)
          else
            AHeight := AWidth * DefaultPrinterVerticalSizeMM div
              DefaultPrinterHorizontalSizeMM;
        end;
        FScalePercent := 100;
      end;
  else Scaling := 1;
  end;
  case FViewMode of
    vm500..vm10:
      begin
        if Printer.Printers.Count > 0 then
        begin
          AWidth := Scaling * Printer.PageWidth * Screen.PixelsPerInch div
            GetDeviceCaps(Printer.Handle, LOGPIXELSX) div 100;
          AHeight := AWidth * GetDeviceCaps(Printer.Handle, VertSize) div
            GetDeviceCaps(Printer.Handle, HorzSize);
        end else
        begin
          AWidth := Scaling * Printer.PageWidth * Screen.PixelsPerInch div
            DefaultPrinterPixelsPerInchX div 100;
          AHeight := AWidth * DefaultPrinterVerticalSizeMM div
            DefaultPrinterHorizontalSizeMM;
        end;
        FScalePercent := Scaling;
      end;
  end;

  PageWidth := AWidth;
  PageHeight := AHeight;
end;

procedure TPreviewBox.UpdatePreview;
begin
  FixedColCount := 0;
  FixedRowCount := 0;
  ColCount := 3;
  RowCount := PageCount + 2;
end;

procedure TPreviewBox.WMCancelMode(var Message: TMessage);
begin
  inherited;
  if Cursor = crHand then
    Cursor := crMagnifier;
end;

procedure TPreviewBox.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdatePageSetup;
end;

{$ENDIF}

{ TPrinterPreview }

constructor TPrinterPreview.Create;
begin
  inherited Create;
  FMetafileList := TObjectListEh.Create;
  FPrinter := TPrinter.Create;
end;

destructor TPrinterPreview.Destroy;
var i: Integer;
begin
  for i := 0 to FMetafileList.Count - 1 do
    FreeObjectEh(FMetafileList[i]);
  FreeAndNil(FMetafileList);
  FreeAndNil(FPrinter);
  inherited Destroy;
end;

procedure TPrinterPreview.Abort;
begin
  FAborted := True;
end;

procedure TPrinterPreview.BeginDoc;
var
  i: Integer;
  FontSize: Integer;
begin
  for i := 0 to FMetafileList.Count - 1 do
    FreeObjectEh(FMetafileList[i]);
  FMetafileList.Clear;

  FMetafileList.Add(TMetaFile.Create());
  if Printer.Printers.Count > 0
    then FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), Printer.Handle {0})
  else FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), 0);
  FontSize := FMetafileCanvas.Font.Size;

  if Printer.Printers.Count > 0 then
  begin
    FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    if FMetafileCanvas.Font.PixelsPerInch > GetDeviceCaps(Printer.Handle, LOGPIXELSY) then
      FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  end
  else
    FMetafileCanvas.Font.PixelsPerInch := DefaultPrinterPixelsPerInchX;

  FMetafileCanvas.Font.Size := FontSize;
  FPageNumber := 1;
  FAborted := False;
  FPrinting := True;
  Previewer.FPageCount := 1;
  Previewer.FPageIndex := 1;
  if Assigned(Previewer.OnPrinterPreviewChanged) then
    Previewer.OnPrinterPreviewChanged(Self);
end;

procedure TPrinterPreview.NewPage;
var
  FontSize: Integer;
begin
  FMetafileList.Add(TMetaFile.Create());
  FMetafileCanvas.Free;
  if FMetafileList.Count = 2 then
    Previewer.UpdatePageSetup;
  if Printer.Printers.Count > 0 then
    FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), Printer.Handle {0})
  else
    FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), 0);
  FontSize := FMetafileCanvas.Font.Size;
  if Printer.Printers.Count > 0 then
  begin
    FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    if FMetafileCanvas.Font.PixelsPerInch > GetDeviceCaps(Printer.Handle, LOGPIXELSY) then
      FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  end
  else
    FMetafileCanvas.Font.PixelsPerInch := DefaultPrinterPixelsPerInchX;
  FMetafileCanvas.Font.Size := FontSize;
  Inc(FPageNumber);
  Previewer.FPageCount := FMetafileList.Count - 1;
  OpenPreview;
  if Assigned(Previewer.OnPrinterPreviewChanged) then
    Previewer.OnPrinterPreviewChanged(Self);
end;

procedure TPrinterPreview.EndDoc;
begin
  FreeAndNil(FMetafileCanvas);
  Previewer.FPageCount := FMetafileList.Count;
  if FMetafileList.Count = 1 then
    Previewer.UpdatePageSetup;
  FPageNumber := -1;
  FPrinting := False;
  Previewer.FOnPrinterSetupDialog := OnPrinterSetupDialog;
  OnPrinterSetupDialog := nil;
  Previewer.FOnPrinterSetupChanged := OnPrinterSetupChanged;
  OnPrinterSetupChanged := nil;
  Previewer.PrinterSetupOwner := PrinterSetupOwner;
  PrinterSetupOwner := nil;
  OpenPreview;
  if Assigned(Previewer.OnPrinterPreviewChanged) then
    Previewer.OnPrinterPreviewChanged(Self);
end;

function TPrinterPreview.GetAborted: Boolean;
begin
  Result := FAborted;
end;


function TPrinterPreview.GetDeviceCanvas: TCanvas;
begin
  Result := FMetafileCanvas;
end;

function TPrinterPreview.GetFonts: TStrings;
begin
  Result := Printer.Fonts;
end;

function TPrinterPreview.GetCopies: Integer;
begin
  Result := Printer.Copies;
end;

function TPrinterPreview.GetOrientation: TPrinterOrientation;
begin
  Result := Printer.Orientation;
end;

function TPrinterPreview.GetPageHeight: Integer;
begin
  if Printer.Printers.Count > 0
    then Result := Printer.PageHeight
    else Result := DefaultPrinterPageHeight;
end;

function TPrinterPreview.GetPageNumber: Integer;
begin
  Result := FPageNumber;
end;

function TPrinterPreview.GetPageWidth: Integer;
begin
  if Printer.Printers.Count > 0
    then Result := Printer.PageWidth
    else Result := DefaultPrinterPageWidth;
end;

function TPrinterPreview.GetPrinting: Boolean;
begin
  Result := FPrinting;
end;

function TPrinterPreview.GetTitle: String;
begin
  Result := Printer.Title;
end;

procedure TPrinterPreview.DrawPage(Sender: TObject;
  Canvas: TCanvas; PageNumber: Integer);
begin
  Canvas.Draw(0, 0, TMetafile(FMetafileList[PageNumber - 1]));
end;

procedure TPrinterPreview.DrawPage(Sender: TObject;
  Canvas: TCanvas; PageNumber: Integer; ADrawRect: TRect);
begin
  if PageNumber-1 < FMetafileList.Count then
    Canvas.StretchDraw(ADrawRect, TMetafile(FMetafileList[PageNumber - 1]));
end;

procedure TPrinterPreview.SetCopies(const Value: Integer);
begin
  Printer.Copies := Value;
end;

procedure TPrinterPreview.SetOnPrinterSetupDialog(const Value: TNotifyEvent);
begin
  FOnPrinterSetupDialog := Value;
end;

procedure TPrinterPreview.SetOrientation(const Value: TPrinterOrientation);
begin
  Printer.Orientation := Value;
end;

procedure TPrinterPreview.SetTitle(const Value: string);
begin
  Printer.Title := Value;
end;

procedure TPrinterPreview.ShowProgress(Percent: Integer);
begin
end;

function TPrinterPreview.GetPropPrinter: TPrinter;
begin
  Result := FPrinter;
end;

function TPrinterPreview.GetFullPageHeight: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := Printer.PageHeight + GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY) * 2
  else
    Result := DefaultPrinterPageHeight + DefaultPrinterPhysicalOffSetY * 2;
end;

function TPrinterPreview.GetFullPageWidth: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := Printer.PageWidth + GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX) * 2
  else
    Result := DefaultPrinterPageWidth + DefaultPrinterPhysicalOffSetX * 2;
end;

function TPrinterPreview.GetHandle: HDC;
begin
  Result := Printer.Handle;
end;

function TPrinterPreview.GetPixelsPerInchX: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := GetDeviceCaps(Printer.Handle, LOGPIXELSX)
  else
    Result := DefaultPrinterPixelsPerInchX;
end;

function TPrinterPreview.GetPixelsPerInchY: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := GetDeviceCaps(Printer.Handle, LOGPIXELSY)
  else
    Result := DefaultPrinterPixelsPerInchY;
end;

{$IFDEF CIL}
procedure TPrinterPreview.GetPrinter(ADevice, ADriver, APort: String; var ADeviceMode: IntPtr);
{$ELSE}
procedure TPrinterPreview.GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle);
{$ENDIF}
begin
  Printer.GetPrinter(ADevice, ADriver, APort, ADeviceMode);
end;

{$IFDEF CIL}
procedure TPrinterPreview.SetPrinter(ADevice, ADriver, APort: String; ADeviceMode: IntPtr);
{$ELSE}
procedure TPrinterPreview.SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle);
{$ENDIF}
begin
  Printer.SetPrinter(ADevice, ADriver, APort, ADeviceMode);
end;

function TPrinterPreview.GetCapabilities: TPrinterCapabilities;
begin
  Result := Printer.Capabilities;
end;

function TPrinterPreview.GetPrinterIndex: Integer;
begin
  Result := Printer.PrinterIndex;
end;

function TPrinterPreview.GetPrinters: TStrings;
begin
  Result := Printer.Printers;
end;

procedure TPrinterPreview.SetPrinterIndex(const Value: Integer);
begin
  Printer.PrinterIndex := Value;
end;

procedure TPrinterPreview.OpenPreview;
begin
  if Assigned(Previewer.OnOpenPreviewer) then
    Previewer.OnOpenPreviewer(Self);
end;

procedure TPrinterPreview.Print;
var
  Page: Integer;
  OldPrinter: TPrinter;
begin
  if FMetafileList.Count = 0 then Exit;
  OldPrinter := PrintersSetPrinter(Printer);
  try
    PrintersPrinter.BeginDoc;
    for Page := 0 to FMetafileList.Count - 1 do
    begin
      DrawPage(Self, PrintersPrinter.Canvas, Page + 1);
      if Page < FMetafileList.Count - 1 then
        PrintersPrinter.NewPage;
    end;
    PrintersPrinter.EndDoc;
  finally
    PrintersSetPrinter(OldPrinter);
  end;
end;

function PrinterPreview: TPrinterPreview;
begin
  if FPrinterPreview = nil then
  begin
    PreviewFormEh := TPreviewFormEh.Create(Application);
    FPrinterPreview := PreviewFormEh.PreviewEh1.Printer;
  end;
  Result := FPrinterPreview;
end;

function SetPrinterPreview(NewPrinterPreview: TPrinterPreview): TPrinterPreview;
begin
  Result := FPrinterPreview;
  FPrinterPreview := NewPrinterPreview;
end;

procedure TPrinterPreview.SetPreviewer(const Value: TPreviewBox);
begin
  FPreviewer := Value;
end;

function DefineCursor(const Identifier: String): TCursor;
{$IFDEF MSWINDOWS}
var
  Handle: HCursor;
begin
{$IFDEF CIL}
  Handle := LoadCursorEh(hInstance, Identifier);
{$ELSE}
  Handle := LoadCursorEh(hInstance, PChar(Identifier));
{$ENDIF}
  if Handle = 0 then raise EOutOfResources.Create('Cannot load cursor resource');
  for Result := 1 to High(TCursor) do
    if Screen.Cursors[Result] = Screen.Cursors[crArrow] then
    begin
      Screen.Cursors[Result] := Handle;
      Exit;
    end;
  raise EOutOfResources.Create('Too many user-defined cursors');
end;
{$ELSE}
begin
  { TODO : Make an implementation for NEXTGEN. }
  Result := crDefault;
end;
{$ENDIF}

initialization
  crMagnifier := DefineCursor('MAGNIFIEREH');
  crHand := DefineCursor('HANDEH');
end.
