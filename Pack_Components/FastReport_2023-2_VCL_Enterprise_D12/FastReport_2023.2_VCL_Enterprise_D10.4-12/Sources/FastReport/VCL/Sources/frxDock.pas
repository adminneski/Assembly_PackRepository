
{******************************************}
{                                          }
{             FastReport VCL               }
{              Tool controls               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxDock;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages, {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, Buttons, frDPIAwareInt, frxDPIAwareBaseControls, IniFiles,
  frxBaseForm
{$IFDEF FPC}
  , LazarusPackageIntf, LazHelper, types
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxTBPanel = class(TPanel)
  protected
    procedure SetParent(AParent:TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxDockSite = class(TfrxDPIAwarePanel)
  private
    FPanelSize: Integer;
    FSavedSize: Integer;
    FSplitter: TControl;
    FTopParentWin: TWinControl;
  protected
    procedure VisibleChanging; override;
    procedure DoPPIChanged(aNewPPI: Integer); override;
    {$IFNDEF FPC}
    function CreateDockManager: IDockManager; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    procedure DockDrop(Source: TDragDockObject; X, Y: Integer); override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    function DoUnDock(NewTarget: TWinControl; Client: TControl
      {$IFDEF FPC}; KeepDockSiteSize: Boolean = true{$ENDIF}): Boolean; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ReloadDockedControl(const AControlName: string;
      var AControl: TControl); override;
    procedure UpdateAlign;
    property SavedSize: Integer read FSavedSize write FSavedSize;
    property TopParentWin: TWinControl read FTopParentWin write FTopParentWin;
  end;

{$IFNDEF FPC}
  TBlueForm = class(TForm)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  TfrxDragDockObject = class {$IFDEF VER130}(TDragDockObject){$ELSE}(TDragDockObjectEx){$ENDIF}
  private
    BlueForm: TBlueForm;
  protected
    procedure DrawDragDockImage; override;
    procedure EraseDragDockImage; override;
  public
    constructor Create(AControl: TControl); override;
    destructor Destroy; override;
  end;

  TfrxDockForm = class(TfrxBaseForm)
  protected
    procedure DoStartDock(var DragObject: TDragObject); override;
  end;

  TfrxDockToolBar = class(TToolBar)
  protected
    procedure DoStartDock(var DragObject: TDragObject); override;
  end;

const
  ColorFill = $ECDECE;
  ColorClose = $606060;

type

  TfrxDockTree = class(TDockTree, IfrxDPIAwareControl)
  private
    FFont:HFont;
    FFontV:HFont;
    FCurrentPPI: Integer;
    HeadSize, ClosePadding, CaptionPadding, CloseWidth, TextHeight, TextHide: Integer;
    FRectClose: TRect;
    procedure DrawCaption(Canvas: TCanvas; ARect: TRect; Control: TControl);
    procedure DrawRect(Canvas:TCanvas; R:TRect);
    procedure DrawClose(Canvas:TCanvas; R:TRect);
    procedure DoPPIChanged(aNewPPI: Integer);
    procedure FreeFont;
  protected
    procedure PaintDockFrame(Canvas: TCanvas; Control: TControl; const ARect: TRect); override;
    procedure AdjustDockRect(Control: TControl; var ARect: TRect); override;
    procedure CreateCaptionFont(var Font,FontV:HFont);
    {$IFDEF DELPHI9}
    function ZoneCaptionHitTest(const Zone: TDockZone; const MousePos: TPoint; var HTFlag: Integer): Boolean; override;
    {$ELSE}
    function HitTest(const MousePos: TPoint; out HTFlag: Integer): TControl; override;
    {$ENDIF}
  public
    constructor Create(DockSite: TWinControl); override;
    destructor Destroy; override;
  end;

{$ELSE}
  TfrxDockForm = TfrxBaseForm;
  TfrxDockToolBar = class(TToolBar)
  end;
{$ENDIF}


procedure frxSaveToolbarPosition(Ini: TCustomIniFile; t: TToolBar; FormPPIScale: Single);
procedure frxRestoreToolbarPosition(Ini: TCustomIniFile; t: TToolBar; CurrentFormPPI: Integer);
procedure frxSaveDock(Ini: TCustomIniFile; d: TfrxDockSite; FormPPIScale: Single);
procedure frxRestoreDock(Ini: TCustomIniFile; d: TfrxDockSite);
procedure frxSaveFormPosition(Ini: TCustomIniFile; f: TForm; FormPPIScale: Single);
procedure frxRestoreFormPosition(Ini: TCustomIniFile; f: TForm; FormPPIScale: Single);


{$IFDEF FPC}
//procedure Register;
{$ENDIF}

implementation


uses frxClass, frxUtils;

type
  TWC = class (TWinControl)
  end;

const
  rsForm      = 'Form5';
  rsToolBar   = 'ToolBar5';
  rsDock      = 'Dock5';
  rsWidth     = 'Width';
  rsHeight    = 'Height';
  rsTop       = 'Top';
  rsLeft      = 'Left';
  rsFloat     = 'Float';
  rsVisible   = 'Visible';
  rsMaximized = 'Maximized';
  rsData      = 'Data';
  rsSize      = 'Size';


procedure frxSaveToolbarPosition(Ini: TCustomIniFile; t: TToolBar; FormPPIScale: Single);
var
  X, Y: integer;
  Name: String;
begin
  Name := rsToolbar + '.' + t.Name;
  Ini.WriteBool(Name, rsFloat, t.Floating);
  Ini.WriteBool(Name, rsVisible, t.Visible);
  if t.Floating then
  begin
    X := t.Parent.Left;
    Y := t.Parent.Top;
  end
  else
  begin
    X := t.Left;
    Y := t.Top;
  end;
  Ini.WriteInteger(Name, rsLeft, Round(X / FormPPIScale));
  Ini.WriteInteger(Name, rsTop, Round(Y / FormPPIScale));
  Ini.WriteInteger(Name, rsWidth, Round(t.Width / FormPPIScale));
  Ini.WriteInteger(Name, rsHeight, Round(t.Height / FormPPIScale));
  if t.Parent is TControlBar then
    Ini.WriteString(Name, rsDock, t.Parent.Name);
end;

procedure frxRestoreToolbarPosition(Ini: TCustomIniFile; t: TToolBar; CurrentFormPPI: Integer);
var
  DN: string;
  NewDock: TControlBar;
  Name: String;
  X, Y, DX, DY: Integer;
begin
  Name := rsToolbar + '.';
  if CurrentFormPPI > frx_DefaultPPI then
    Name := Name + IntToStr(CurrentFormPPI) + '.';
  Name := Name + t.Name;
  X := Ini.ReadInteger(Name, rsLeft, t.Left);
  Y := Ini.ReadInteger(Name, rsTop, t.Top);
  DX := Ini.ReadInteger(Name, rsWidth, t.Width);
  DY := Ini.ReadInteger(Name, rsHeight, t.Height);
  t.Visible := False;
  if Ini.ReadBool(Name, rsFloat, False) then
    t.ManualFloat(Rect(X, Y, X + DX, Y + DY))
  else
  begin
    DN := Ini.ReadString(Name, rsDock, t.Parent.Name);
    if (t.Owner <> nil) then
    begin
      NewDock := t.Owner.FindComponent(DN) as TControlBar;
      if (NewDock <> nil) and (NewDock <> t.Parent) then
        t.ManualDock(NewDock);
    end;
    t.SetBounds(X, Y, DX, DY);
  end;
  t.Visible := Ini.ReadBool(Name, rsVisible, True);
end;

procedure frxSaveDock(Ini: TCustomIniFile; d: TfrxDockSite; FormPPIScale: Single);
var
  s: TMemoryStream;
begin
  s := TMemoryStream.Create;
  d.DockManager.SaveToStream(s);
{$IFDEF DELPHI9}
  Ini.WriteString(rsDock + '.' + d.Name, rsData + '2005', String(frxStreamToString(s)));
{$ELSE}
  Ini.WriteString(rsDock + '.' + d.Name, rsData, frxStreamToString(s));
{$ENDIF}
  Ini.WriteInteger(rsDock + '.' + d.Name, rsWidth, Round(d.Width / FormPPIScale));
  Ini.WriteInteger(rsDock + '.' + d.Name, rsHeight, Round(d.Height / FormPPIScale));
  Ini.WriteInteger(rsDock + '.' + d.Name, rsSize, d.SavedSize);
  s.Free;
end;

procedure frxRestoreDock(Ini: TCustomIniFile; d: TfrxDockSite);
var
  s: TStream;
  sd: String;
  function ReadAnsScale(pName: String; aValue: Integer): Integer;
  begin
    Result := Round(aValue / (d.CurrentPPI / frx_DefaultPPI));
    Result := Ini.ReadInteger(rsDock + '.' + d.Name, pName, Result);
    if Screen.PixelsPerInch >= d.CurrentPPI then
      Result := Round(Result * (Screen.PixelsPerInch / frx_DefaultPPI));
  end;

begin
  s := TMemoryStream.Create;
  try
  {$IFDEF DELPHI9}
    sd := Ini.ReadString(rsDock + '.' + d.Name, rsData + '2005', '');
  {$ELSE}
    sd := Ini.ReadString(rsDock + '.' + d.Name, rsData, '');
  {$ENDIF}
    frxStringToStream(sd, s);
    s.Position := 0;
    if s.Size > 0 then
      d.DockManager.LoadFromStream(s);
    d.AutoSize := False;
    d.Width := ReadAnsScale(rsWidth, d.Width);
    d.Height := ReadAnsScale(rsHeight, d.Height);
    d.SavedSize := Ini.ReadInteger(rsDock + '.' + d.Name, rsSize, 100);
    d.AutoSize := True;
  finally
    s.Free;
  end;
end;

procedure frxSaveFormPosition(Ini: TCustomIniFile; f: TForm; FormPPIScale: Single);
var
  Name: String;
  w, h: Integer;
begin
  Name := rsForm + '.' + f.ClassName;
  Ini.WriteInteger(Name, rsLeft, f.Left);
  Ini.WriteInteger(Name, rsTop, f.Top);
  w := Round(f.Width / FormPPIScale);
  h := Round(f.Height / FormPPIScale);
  Ini.WriteBool(Name, rsMaximized, f.WindowState = wsMaximized);
  Ini.WriteBool(Name, rsVisible, f.Visible);
  if f.HostDockSite <> nil then
    Ini.WriteString(Name, rsDock, f.HostDockSite.Name)
  else
    Ini.WriteString(Name, rsDock, '');
  Ini.WriteInteger(Name, rsWidth, w);
  Ini.WriteInteger(Name, rsHeight, h);
end;

procedure frxRestoreFormPosition(Ini: TCustomIniFile; f: TForm; FormPPIScale: Single);
var
  Name: String;
  Dock: String;
  cDock: TWinControl;
begin
  Name := rsForm + '.' + f.ClassName;
  if f.FormStyle <> fsMDIChild then
  begin
    if Ini.ReadBool(Name, rsMaximized, False) then
      f.WindowState := wsMaximized
    else
    begin
      f.SetBounds(Ini.ReadInteger(Name, rsLeft, f.Left),
                  Ini.ReadInteger(Name, rsTop, f.Top),
                  f.Width,
                  f.Height);
      f.SetBounds(f.Left,
                  f.Top,
                  Round(Ini.ReadInteger(Name, rsWidth, f.Width) * FormPPIScale),
                  Round(Ini.ReadInteger(Name, rsHeight, f.Height)  * FormPPIScale));
    end;
  end;
  Dock := Ini.ReadString(Name, rsDock, '');
  cDock := frxFindComponent(f.Owner, Dock) as TWinControl;
  if cDock <> nil then
    f.ManualDock(cDock);
  if not (f is TfrxCustomDesigner) then
    f.Visible := Ini.ReadBool(Name, rsVisible, True);
end;


{ TfrxTBPanel }

function GetAlign(al: TAlign): TAlign;
begin
  if al in [alLeft, alRight] then
    Result := alTop else
    Result := alLeft;
end;

constructor TfrxTBPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFNDEF FPC}
  Align := alLeft;
{$ENDIF}
  Width := 8;
  Height := 8;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  ControlStyle := ControlStyle{$IFDEF DELPHI11} - [csParentBackground]{$ENDIF} + [csOpaque];
end;

procedure TfrxTBPanel.SetParent(AParent:TWinControl);
begin
  inherited;
{$IFNDEF FPC}
  if not (csDestroying in ComponentState) and (AParent <> nil) and (Parent is TPanel) then
    Align := GetAlign(AParent.Parent.Align);
{$ENDIF}
end;

procedure TfrxTBPanel.Paint;
begin
{$IFDEF FPC}
  inherited Paint;
{$ELSE}
{$IFDEF DELPHI10}
   inherited;
{$ELSE}
  with Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(Rect(0, 0, Width, Height));
    if csDesigning in ComponentState then
    begin
      Brush.Style := bsClear;
      Pen.Style := psDot;
      Pen.Color := clBtnShadow;
      Rectangle(0, 0, Width - 1, Height - 1);
    end;
  end;
{$ENDIF}
{$ENDIF}
end;


{ TfrxDockSite }

type
  THackControl = class(TControl);

  TDockSplitter = class(TGraphicControl)
  private
    FDockSite: TfrxDockSite;
    FDown: Boolean;
    FCurrentPPI: Integer;
    FRubberCountX: Integer;
    FRubberCountY: Integer;
    FRubberGapX: Integer;
    FRubberGapY: Integer;
    procedure DrawRubber(X, Y: Integer; Horizontal: Boolean);
  protected
    procedure SetParent(AParent: TWinControl); override;
    function GetRubberGaps: TSize;
    function GetRubberSize: TSize;
  public
    constructor Create(AOwner: TComponent); override;
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    property CurrentPPI: Integer read FCurrentPPI write FCurrentPPI;
  end;


{ TDockSplitter }

constructor TDockSplitter.Create(AOwner: TComponent);
begin
  inherited;
  FDockSite := TfrxDockSite(AOwner);
  FCurrentPPI := Screen.PixelsPerInch;
  FRubberCountX := 1;
  FRubberCountY := 6;
  FRubberGapX := 3;
  FRubberGapY := 3;
end;

procedure TDockSplitter.DrawRubber(X, Y: Integer; Horizontal: Boolean);
var
  dx, dy, i, j: Integer;
  nScale: Single;
  Gaps: TSize;
begin
  Gaps := GetRubberGaps;
  if Horizontal then
    Inc(X, Gaps.cy)
  else
    Inc(Y, Gaps.cy);
  nScale := CurrentPPI / frx_DefaultPPI;
  for j := 0 to FRubberCountX - 1 do
  begin
    dx := X;
    dy := Y;
    for i := 0 to FRubberCountY - 1 do
    begin
      if nScale = 1 then
      begin
        Canvas.Pixels[dx, dy] := clWhite;
        Canvas.Pixels[dx + 1, dy] := clGray;
        Canvas.Pixels[dx, dy + 1] := clGray;
        Canvas.Pixels[dx + 1, dy + 1] := clGray;
      end
      else
      begin
        Canvas.Pen.Style := psClear;
        Canvas.Brush.Color := clGray;
        Canvas.FillRect(Rect(dx, dy, dx + Round(nScale * 2), dy + Round(nScale * 2)));
        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(Rect(dx, dy, dx + Round(nScale), dy + Round(nScale)));
      end;

      if Horizontal then
        Inc(dx, Round(nScale * 2 + Gaps.cy))
      else
        Inc(dy, Round(nScale * 2 + Gaps.cy));
    end;
    if Horizontal then
      Inc(Y, Round(nScale * 2 + Gaps.cx))
    else
      Inc(X, Round(nScale * 2 + Gaps.cx));
  end;
end;

function TDockSplitter.GetRubberGaps: TSize;
begin
  Result.cx := FRubberGapX;
  Result.cy := FRubberGapY;
end;

function TDockSplitter.GetRubberSize: TSize;
var
  nScale: Single;
  Gaps: TSize;
begin
  Gaps := GetRubberGaps;
  nScale := CurrentPPI / frx_DefaultPPI * 2;
  Result.cx := Round((Gaps.cx + nScale) * FRubberCountX) - Gaps.cx;
  Result.cy := Round((Gaps.cy + nScale) * FRubberCountY) + Gaps.cy + Round(CurrentPPI / frx_DefaultPPI);
end;

procedure TDockSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FDown := True;

  if Cursor = crHandPoint then
    with FDockSite do
    begin
      if Align in [alLeft, alRight] then
      begin
        if Width = 0 then
        begin
          AutoSize := False;
          Width := SavedSize;
          if Align = alLeft then
            Self.Left := Left + Width
          else
            Self.Left := Left - Self.Width;
          AutoSize := True;
        end
        else
        begin
          AutoSize := False;
          SavedSize := Width;
          Width := 0;
        end;
      end
      else
      begin
        if Height = 0 then
        begin
          AutoSize := False;
          Height := SavedSize;
          if Align = alTop then
            Self.Top := Top + Height
          else
            Self.Top := Top - Self.Height;
          AutoSize := True;
        end
        else
        begin
          AutoSize := False;
          SavedSize := Height;
          Height := 0;
        end;
      end;
      FDown := False;
    end;
end;

procedure TDockSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  mid: Integer;
  {$IFDEF FPC}
  i: Integer;
  {$ENDIF}
begin
  inherited;

  if Align in [alLeft, alRight] then
  begin
    mid := Height div 2;
    if (Y > mid - 20) and (Y < mid + 20) then
      Cursor := crHandPoint
    else
      Cursor := crHSplit;
  end
  else
  begin
    mid := Width div 2;
    if (X > mid - 20) and (X < mid + 20) then
      Cursor := crHandPoint
    else
      Cursor := crVSplit;
  end;

  if FDown then
    with FDockSite do
    begin
      {$IFDEF FPC}
      {$warning hardcoded logic}
      for i := 0 to FDockSite.ControlCount - 1 do
      begin
       if FDockSite.Controls[i] is TCustomForm then
        begin
          if FDockSite.Controls[i].ClassName = 'TfrxReportTreeForm' then
            FDockSite.Controls[i].Align := alTop
          else
            FDockSite.Controls[i].Align := alClient;
        end;
      end;
      {$ENDIF}

      AutoSize := False;
      case Align of
        alLeft:
          Width := Width + X;
        alRight:
          Width := Width - X;
        alTop:
          Height := Height + Y;
        alBottom:
          Height := Height - Y;
      end;
      {$IFNDEF FPC}
      AutoSize := True;
      {$ENDIF}
    end;
end;

procedure TDockSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FDown := False;
end;

procedure TDockSplitter.Paint;
var
  mid, x, x1, y, y1: Integer;
  lScale: Single;
  sz: TSize;
begin
  inherited;
  sz := GetRubberSize;
  with Canvas do
  begin
    if Align in [alLeft, alRight] then
      mid := Self.Height div 2
    else
      mid := Self.Width div 2;
    lScale := CurrentPPI / frx_DefaultPPI;
    y := mid - sz.cy div 2;
    x1 := Round(6 * lScale);
    y1 := mid + sz.cy div 2;
    x := Round(2 * lScale);
    Brush.Color := clScrollBar;// //$C0D0D0;
    if Align in [alLeft, alRight] then
    begin
      FillRect(Rect(0, y, x1, y1));
      DrawRubber(x, y, False);
    end
    else
    begin
      FillRect(Rect(y, 0, y1, x1));
      DrawRubber(y, x, True);
    end;
  end;
end;


procedure TDockSplitter.SetParent(AParent: TWinControl);
begin
  inherited;
  if AParent is TfrxDPIAwarePanel then
    FCurrentPPI := TfrxDPIAwarePanel(AParent).CurrentPPI
  else
    FCurrentPPI := Screen.PixelsPerInch;
end;

{ TfrxDockSite }

constructor TfrxDockSite.Create(AOwner: TComponent);
begin
  inherited;
  if csDesigning in ComponentState then
    DockSite := True;
  Align := alLeft;
  Caption := ' ';
  AutoSize := True;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Width := 10;
  Height := 10;

  FSplitter := TDockSplitter.Create(Self);
  FSplitter.Visible := False;
end;

procedure TfrxDockSite.SetParent(AParent: TWinControl);
begin
  inherited;
  if Parent <> nil then
    FSplitter.Parent := Parent;
end;

procedure TfrxDockSite.UpdateAlign;
begin
  case Align of
    alLeft:
      begin
        FSplitter.Width := Round(6 * CurrentPPI / frx_DefaultPPI);
        FSplitter.Left := Left + Width + 6;
      end;
    alRight:
      begin
        FSplitter.Width := Round(6 * CurrentPPI / frx_DefaultPPI);
        FSplitter.Left := Left - 6;
      end;
    alTop:
      begin
        FSplitter.Height := Round(6 * CurrentPPI / frx_DefaultPPI);
        FSplitter.Top := Top + Height + 6;
      end;
    alBottom:
      begin
        FSplitter.Height := Round(6 * CurrentPPI / frx_DefaultPPI);
        FSplitter.Top := Top - 6;
      end;
  end;
end;

procedure TfrxDockSite.VisibleChanging;
begin
  inherited;
  FSplitter.Visible := not Visible;
end;

procedure TfrxDockSite.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if {$IFDEF FPC}HandleAllocated and {$ENDIF} (FSplitter <> nil) then
    if Align <> FSplitter.Align then
    begin
      UpdateAlign;
      FSplitter.Align := Align;
    end;
end;

procedure TfrxDockSite.DockDrop(Source: TDragDockObject; X, Y: Integer);
begin
 {attach dock only to owner, need for MDI designer}
  if (TopParentWin <> nil) and (Source.Control.Owner <> nil) and (Source.Control.Owner.Name <> TopParentWin.Name) then
    exit;
  inherited;
  if Align in [alLeft, alRight] then
  begin
    if Width < FPanelSize then
      Source.Control.Width := FPanelSize;
  end
  else
  begin
    if Height < FPanelSize then
      Source.Control.Height := FPanelSize;
  end;
  FSplitter.Show;
end;

procedure TfrxDockSite.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  {attach dock only to owner, need for MDI designer}
  if (TopParentWin <> nil) and (Source.Control.Owner <> nil) and (Source.Control.Owner.Name <> TopParentWin.Name) then
    exit;
  inherited;
  if Align in [alLeft, alRight] then
    FPanelSize := Source.Control.Width
  else
    FPanelSize := Source.Control.Height;
end;

procedure TfrxDockSite.DoPPIChanged(aNewPPI: Integer);
var
  DPIControl: IfrxDPIAwareControl;
begin
  inherited;
  if Assigned(FSplitter) then
    TDockSplitter(FSplitter).CurrentPPI := aNewPPI;
  if Assigned(DockManager) and Supports(DockManager, IfrxDPIAwareControl, DPIControl) then
    DPIControl.DoPPIChanged(aNewPPI);
end;

{$IFNDEF FPC}
function TfrxDockSite.CreateDockManager: IDockManager;
begin
  if (DockManager = nil) and DockSite and UseDockManager then
  begin
    //case DockTreeKind of
      Result := TfrxDockTree.Create(Self);
  end else
    Result := DockManager;
  DoubleBuffered := DoubleBuffered or (Result <> nil);
end;
{$ENDIF}

function TfrxDockSite.DoUnDock(NewTarget: TWinControl; Client: TControl
  {$IFDEF FPC}; KeepDockSiteSize: Boolean = true{$ENDIF}): Boolean;
begin
  Result := False;
  if (NewTarget <> nil) and (NewTarget.Owner <> Self.Owner) then
    exit;
  Result := inherited DoUnDock(NewTarget, Client);
  if DockClientCount <= 1 then
    FSplitter.Hide;
end;

procedure TfrxDockSite.ReloadDockedControl(const AControlName: string;
  var AControl: TControl);
var
  I: Integer;
  Com: TComponent;
begin
  {search dock window in designer component list, need for MDI or multi-window designer}
  if (AControlName <> '') and (FTopParentWin.ComponentCount > 0) then
    for I := 0 to FTopParentWin.ComponentCount - 1 do
    begin
      Com := FTopParentWin.Components[I];
      if Pos(AControlName, Com.Name) > 0 then
      begin
        AControl := Com as TControl;
        exit;
      end;
    end;
    AControl := FindGlobalComponent(AControlName) as TControl;
end;

{$IFNDEF FPC}
{ TBlueForm }

procedure TBlueForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

{ TfrxDragDockObject }

constructor TfrxDragDockObject.Create(AControl: TControl);
begin
  inherited;
  BlueForm := TBlueForm.CreateNew(nil);
  BlueForm.Visible := False;
  BlueForm.Color := clHighlight;
  BlueForm.AlphaBlend := True;
  BlueForm.AlphaBlendValue := 140;
  BlueForm.BorderIcons := [];
  BlueForm.BorderStyle := bsNone;
  BlueForm.FormStyle := fsStayOnTop;
  BlueForm.BoundsRect := Rect(0, 0, 0, 0);
end;

procedure TfrxDragDockObject.DrawDragDockImage;
var
  DockRect: TRect;
const
  Padd = 10;
begin
  BlueForm.Visible := True;
  DockRect := TDragDockObject(Self).DockRect;
  if (DockRect.Right - DockRect.Left <= 0) then
  begin
    DockRect.Left := DockRect.Left - Padd;
    DockRect.Right := DockRect.Right + Padd;
  end;
  if (DockRect.Bottom - DockRect.Top <= 0) then
  begin
    DockRect.Top := DockRect.Top - Padd;
    DockRect.Bottom := DockRect.Bottom + Padd;
  end;
  BlueForm.BoundsRect := DockRect;
end;

procedure TfrxDragDockObject.EraseDragDockImage;
begin
end;

destructor TfrxDragDockObject.Destroy;
begin
  inherited;
  BlueForm.Free;
end;

{ TfrxDockForm }

procedure TfrxDockForm.DoStartDock(var DragObject: TDragObject);
begin
  inherited;
  if DragObject = nil then
  begin
    DragObject := TDragDockObject(TfrxDragDockObject.Create(TControl(Self)));
  end;
end;

{ TfrxDockToolBar }

procedure TfrxDockToolBar.DoStartDock(var DragObject: TDragObject);
begin
  inherited;
  if DragObject = nil then
  begin
    DragObject := TDragDockObject(TfrxDragDockObject.Create(TControl(Self)));
  end;
end;

{ TfrxDockTree }

destructor TfrxDockTree.Destroy;
begin
  inherited;
  FreeFont;
end;

procedure TfrxDockTree.DoPPIChanged(aNewPPI: Integer);
var
  Scale: Double;
begin
  if FCurrentPPI = aNewPPI then Exit;
  FreeFont;
  Scale := aNewPPI / frx_DefaultPPI;
  HeadSize := Round(20 * Scale);
  ClosePadding := Round(6 * Scale);
  CaptionPadding := Round(4 * Scale);
  CloseWidth := Round(2 * Scale);
  TextHeight := Round(-13 * Scale);
  TextHide := Round(10 * Scale);
  FCurrentPPI := aNewPPI;
end;

constructor TfrxDockTree.Create(DockSite: TWinControl);
begin
  inherited;
  DoPPIChanged(Screen.PixelsPerInch);
end;

procedure TfrxDockTree.CreateCaptionFont(var Font,FontV:HFont);
var
  FontInfo: tagLOGFONTW;
  NonClientMetrics: tagNONCLIENTMETRICSW;
begin
  if Font = 0 then
  begin
    fillchar(NonClientMetrics, SizeOf(NonClientMetrics), 0);
    NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
    if SystemParametersInfoW(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
      FontInfo := NonClientMetrics.lfStatusFont;
    FontInfo.lfHeight := TextHeight;
    FontInfo.lfWeight := FW_NORMAL;
    Font := CreateFontIndirectW(FontInfo);
    FontInfo.lfEscapement := 900;
    FontV := CreateFontIndirectW(FontInfo);
  end;
end;

{$IFDEF DELPHI9}
function TfrxDockTree.ZoneCaptionHitTest(const Zone: TDockZone; const MousePos: TPoint; var HTFlag: Integer): Boolean;
var
  ZoneTop, ZoneLeft: Integer;
begin
  Result := False;
  ZoneTop := Zone.Top;
  ZoneLeft := Zone.Left;
  if not (DockSite.Align in [alTop, alBottom]) then
  begin
    if (MousePos.Y >= ZoneTop) and (MousePos.Y <= ZoneTop + HeadSize) and
      (MousePos.X >= ZoneLeft) and (MousePos.X <= ZoneLeft + Zone.Width) then
    begin
      Result := True;
      with Zone.ChildControl do
        if PtInRect(FRectClose, MousePos) then
          HTFlag := HTCLOSE
        else
          HTFlag := HTCAPTION;
    end;
  end
  else
  begin
    if (MousePos.X >= ZoneLeft) and (MousePos.X <= ZoneLeft + HeadSize) and
      (MousePos.Y >= ZoneTop) and (MousePos.Y <= ZoneTop + Zone.Height) then
    begin
      Result := True;
      if PtInRect(FRectClose, MousePos) then
        HTFlag := HTCLOSE
      else
        HTFlag := HTCAPTION;
    end;
  end;
end;
{$ELSE}
function TfrxDockTree.HitTest(const MousePos: TPoint; out HTFlag: Integer): TControl;
begin
  Result := inherited HitTest(MousePos, HTFlag);
  if not (DockSite.Align in [alTop, alBottom]) then
    if PtInRect(FRectClose, MousePos) then
      HTFlag := HTCLOSE;
end;
{$ENDIF}

procedure TfrxDockTree.AdjustDockRect(Control: TControl; var ARect: TRect);
begin
  if not (DockSite.Align in [alTop, alBottom]) then
    Inc(ARect.Top, HeadSize)
  else
    Inc(ARect.Left, HeadSize)
end;

procedure TfrxDockTree.DrawCaption(Canvas:TCanvas; ARect:TRect; Control:TControl);
var
  Cap: String;
  OldFont: HFont;
  DC: HDC;
  R: TRect;
begin
  if (Control is TWinControl) then
  begin
    Cap := TWC(Control).Text;
    if (Cap <> '') and (Abs(ARect.Right - ARect.Left) > TextHide) and (Abs(ARect.Bottom - ARect.top) > TextHide) then
    begin
      if fFont = 0 then
        CreateCaptionFont(FFont, FFontV);
      if fFont <> 0 then
      begin
        Canvas.Lock;
        try
          DC := Canvas.Handle;
          SetBkMode(DC, TRANSPARENT);
          if (DockSite.Align in [alTop, alBottom]) then
          begin
            OldFont := SelectObject(DC, FFontV);
            try
              R := Rect(ARect.Left, ARect.Bottom, ARect.Left + Abs(ARect.Bottom-ARect.Top), ARect.Top);
              Windows.DrawText(DC, PChar(Cap), Length(Cap), R, DT_END_ELLIPSIS or DT_SINGLELINE or DT_NOCLIP);
            finally
              SelectObject(DC, OldFont);
            end;
          end else
          begin
            OldFont := SelectObject(DC, fFont);
            try
              Windows.DrawText(DC, PChar(Cap), Length(Cap), ARect, DT_END_ELLIPSIS or DT_SINGLELINE);
            finally
              SelectObject(DC, OldFont);
            end;
          end;
        finally
          Canvas.Unlock;
        end;
      end;
    end;
  end;
end;

procedure TfrxDockTree.DrawRect(Canvas:TCanvas; R:TRect);
begin
  if ((R.Right - R.Left) > 0) and ((R.Bottom - R.top) > 0) then
  begin
    Canvas.Brush.Color := ColorFill;
    Canvas.FillRect(R);
  end;
end;

procedure TfrxDockTree.FreeFont;
begin
  if FFont <> 0 then DeleteObject(fFont);
  if FFontV <> 0 then DeleteObject(fFontV);
  FFont := 0;
  FFontV := FFont;
end;

procedure TfrxDockTree.DrawClose(Canvas:TCanvas; R:TRect);
begin
  Canvas.Pen.Color := ColorClose;
  Canvas.Pen.Width := CloseWidth;
  if ((R.Right - R.Left) mod 2) = 1 then
    R.Right := R.Right - 1;
  if ((R.Bottom - R.Top) mod 2) = 1 then
    R.Bottom := R.Bottom - 1;
  FRectClose := R;
  Canvas.MoveTo(R.Left, R.Top);
  Canvas.LineTo(R.right, R.Bottom);
  Canvas.MoveTo(R.Left, R.Bottom);
  Canvas.LineTo(R.Right, R.Top);
end;

procedure TfrxDockTree.PaintDockFrame(Canvas: TCanvas; Control: TControl; const ARect: TRect);
var
  CloseRect: TRect;
begin
  //case DockTreeKind of
  if (DockSite.Align in [alTop, alBottom]) then
  begin
    DrawRect(Canvas, Rect(ARect.Left, ARect.Top, ARect.Left + HeadSize, ARect.Bottom));
    CloseRect := Rect(ARect.Left + ClosePadding, ARect.Top + ClosePadding,
      ARect.Left + HeadSize - ClosePadding, ARect.Top + HeadSize - ClosePadding);
    DrawClose(Canvas, CloseRect);
    DrawCaption(Canvas, Rect(ARect.Left, ARect.Top + CaptionPadding + (CloseRect.Right - CloseRect.Left) * 2,
      ARect.Left + HeadSize, ARect.Bottom - CaptionPadding), Control);
  end else
  begin
    DrawRect(Canvas, Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Top + HeadSize));
    CloseRect := Rect(ARect.Right - HeadSize + ClosePadding, ARect.Top + ClosePadding,
      ARect.Right - ClosePadding, ARect.Top + HeadSize - ClosePadding);
    DrawClose(Canvas, CloseRect);
    DrawCaption(Canvas, Rect(ARect.Left + CaptionPadding, ARect.Top,
      ARect.Right - (CloseRect.Right - CloseRect.Left) * 2, ARect.Top + HeadSize), Control);
  end;
end;

{$ENDIF}

{$IFDEF FPC}
{procedure RegisterUnitfrxDock;
begin
  RegisterComponents('Fast Report 6',[TfrxTBPanel, TfrxDockSite
   ]);
end;

procedure Register;
begin
  RegisterUnit('frxDock',@RegisterUnitfrxDock);
end;}
{$ENDIF}

end.
