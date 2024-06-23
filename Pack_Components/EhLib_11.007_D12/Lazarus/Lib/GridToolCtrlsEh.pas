{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{          Tool Controls for GridsEh component          }
{                                                       }
{   Copyright (c) 2013-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit GridToolCtrlsEh;

interface

uses SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
  Variants,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF FPC}
  {$IFDEF FPC_CROSSP}
  LCLIntf,
  {$ELSE}
  Windows, UxTheme, Win32Int,
  {$ENDIF}
  EhLibLCL, LCLType, LMessages,
{$ELSE}
  EhLibVCL, Windows, 
{$ENDIF}
  ToolCtrlsEh,
  Graphics, DBCtrls, Types, Themes,
  ExtCtrls, Buttons, Menus;

type

{ TControlScrollBarEh }

  TControlScrollBarEh = class(TScrollBar)
  private
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMMButtonDown(var Message: TWMMButtonDown); message WM_MBUTTONDOWN;
    {$IFDEF FPC_CROSSP}
    {$ELSE}
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    {$ENDIF}
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
  public
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

{ TGridScrollBarPanelControlEh }

  TGridScrollBarPanelControlEh = class(TCustomPanel)
  private
    FIgnoreCancelMode: Boolean;
    FScrollBar: TScrollBar;
    FKeepMaxSizeInDefault: Boolean;
    function GetOnScroll: TScrollEvent;
    procedure SetOnScroll(const Value: TScrollEvent);
    procedure SetKeepMaxSizeInDefault(const Value: Boolean);

  protected
    FKind: TScrollBarKind;

    function ScrollBatCode: Integer;
    function ChildControlCanMouseDown(AControl: TControl): Boolean; virtual;

    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Resize; override;
    procedure CreateHandle; override;
    procedure OnScrollEvent(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);

    property IgnoreCancelMode: Boolean read FIgnoreCancelMode write FIgnoreCancelMode;
  public
    constructor Create(AOwner: TComponent; AKind: TScrollBarKind); reintroduce;
    destructor Destroy; override;

    function MaxSizeForExtraPanel: Integer;
    procedure AdjustSize; override;
    procedure Invalidate; override;
    procedure SetParams(APosition, AMin, AMax, APageSize: Integer);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;

    property OnScroll: TScrollEvent read GetOnScroll write SetOnScroll;
    property ScrollBar: TScrollBar read FScrollBar;
    property KeepMaxSizeInDefault: Boolean read FKeepMaxSizeInDefault write SetKeepMaxSizeInDefault;
  end;

  TGripActiveStatusEh = (gasNeverEh, gasAutoEh, gasAlwaysEh);

  { TSizeGripPanelEh }

  TSizeGripPanelEh = class(TCustomPanel)
  private
    FTriangleWindow: Boolean;
    FGripActiveStatus: TGripActiveStatusEh;
    FPosition: TSizeGripPosition;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;

    procedure SetTriangleWindow(const Value: Boolean);
    procedure SetPosition(const Value: TSizeGripPosition);

  protected
    FInitFormSize: TPoint;
    FInitFormPos: TPoint;
    FMouseMousePos: TPoint;

    function CheckInCorner: Boolean;
    function CheckGripActive: Boolean;
    function GetFormSize: TPoint;
    function GetSizableForm: TWinControl;

    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure Resize; override;

    procedure UpdateWindowRegion;

  public
    constructor Create(AOwner: TComponent); override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;

    property TriangleWindow: Boolean read FTriangleWindow write SetTriangleWindow default True;
    property GripActiveStatus: TGripActiveStatusEh read FGripActiveStatus write FGripActiveStatus;
    property Position: TSizeGripPosition read FPosition write SetPosition;
  end;

{ TGridDragWinEh }

  TGridDragWinEh = class(TCustomControl)
  private
    FAlphaBlendValue: Byte;
    FTransparentColorValue: TColor;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure SetLayeredAttribs;

  public
    constructor Create(AOwner: TComponent); override;

    procedure Show;
    procedure MoveToFor(NewPos: TPoint); overload; virtual;
    procedure MoveToFor(NewPos: TPoint; NewWidth, NewHeight: Integer); overload; virtual;
    procedure StartShow(Pos: TPoint; Width, Height: Integer); overload; virtual;
    procedure StartShow(Pos: TPoint; Height: Integer); overload; virtual;
    procedure TemporaryHide;

    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property TransparentColorValue: TColor read FTransparentColorValue write FTransparentColorValue;
  end;

  { TGridDragFormEh }

  TGridDragFormEh = class(TPopupInactiveFormEh)
  private
    function GetAlphaBlendValue: Byte;
    procedure SetAlphaBlendValue(AValue: Byte);
  protected
  public
    constructor Create(AOwner: TComponent); override;

    procedure Show;
    procedure MoveToFor(NewPos: TPoint); overload; virtual;
    procedure MoveToFor(NewPos: TPoint; NewWidth, NewHeight: Integer); overload; virtual;
    procedure StartShow(Pos: TPoint; Width, Height: Integer); overload; virtual;
    procedure StartShow(Pos: TPoint; Height: Integer); overload; virtual;
    procedure TemporaryHide;

    property AlphaBlendValue: Byte read GetAlphaBlendValue write SetAlphaBlendValue;
  end;

{ TGridDragBoxEh }

  TGridDragBoxEh = class(TGridDragWinEh)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TGridMoveLineEh }

  TGridMoveLineEh = class(TGridDragFormEh)
  private
    FLineColor: TColor;
  protected
    FIsVert: Boolean;

    procedure CreateParams(var Params: TCreateParams); override;
    {$IFDEF FPC}
    {$ELSE}
    procedure Paint; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;

    {$IFDEF FPC}
    procedure Paint; override;
    {$ELSE}
    {$ENDIF}
    procedure StartShow(Pos: TPoint; AIsVert: Boolean; Size: Integer; ACaptureControl: TObject); virtual;
    procedure MoveToFor(NewPos: TPoint); override;

    property IsVert: Boolean read FIsVert;
    property LineColor: TColor read FLineColor write FLineColor;
  end;

  function GetDragBoxEh: TGridDragWinEh;
  function GetMoveLineEh: TGridMoveLineEh;

implementation

uses GridsEh, Dialogs, Clipbrd;

type
  TCustomGridCrack = class(TCustomGridEh);

{ TGridDragFormEh }

constructor TGridDragFormEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TGridDragFormEh.GetAlphaBlendValue: Byte;
begin
  Result := inherited AlphaBlendValue;
end;

procedure TGridDragFormEh.SetAlphaBlendValue(AValue: Byte);
begin
  inherited AlphaBlendValue := AValue;
  if (AValue < 255) then
    AlphaBlend := True;
end;

procedure TGridDragFormEh.Show;
begin
  inherited Show;
end;

procedure TGridDragFormEh.MoveToFor(NewPos: TPoint);
begin
  SetBounds(NewPos.X, NewPos.Y, Width, Height);
end;

procedure TGridDragFormEh.MoveToFor(NewPos: TPoint; NewWidth, NewHeight: Integer);
begin
  SetBounds(NewPos.X, NewPos.Y, NewWidth, NewHeight);
end;

procedure TGridDragFormEh.StartShow(Pos: TPoint; Width, Height: Integer);
begin
  SetBounds(Pos.X, Pos.Y, Width, Height);
  Show;
end;

procedure TGridDragFormEh.StartShow(Pos: TPoint; Height: Integer);
begin
  SetBounds(Pos.X, Pos.Y, Width, Height);
  Show;
end;

procedure TGridDragFormEh.TemporaryHide;
begin

end;

{ TGridScrollBarPanelControlEh }

function TGridScrollBarPanelControlEh.ChildControlCanMouseDown(
  AControl: TControl): Boolean;
var
  Grid: TCustomGridCrack;
begin
  Grid := TCustomGridCrack(Owner);
  Result := Grid.ChildControlCanMouseDown(AControl);
end;

constructor TGridScrollBarPanelControlEh.Create(AOwner: TComponent; AKind: TScrollBarKind);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption, csAcceptsControls];
  FKind := AKind;

  FScrollBar := TControlScrollBarEh.Create(Self);
  FScrollBar.Parent := Self;
  FScrollBar.Kind := FKind;
  FScrollBar.OnScroll := OnScrollEvent;
  {$IFDEF FPC}
  {$ELSE}
  FScrollBar.Ctl3D := False;
  FScrollBar.ParentCtl3D := False;
  {$ENDIF}
  FScrollBar.TabStop := False;
  FScrollBar.DoubleBuffered := False;
{$IFDEF EH_LIB_12}
  FScrollBar.ParentDoubleBuffered := False;
{$ENDIF}

  BevelOuter := bvNone;
  BevelInner := bvNone;
  FKeepMaxSizeInDefault := True;
  DoubleBuffered := True;
end;

procedure TGridScrollBarPanelControlEh.CreateHandle;
begin
  inherited CreateHandle;
end;

destructor TGridScrollBarPanelControlEh.Destroy;
begin
  inherited Destroy;
end;

function TGridScrollBarPanelControlEh.GetOnScroll: TScrollEvent;
begin
  Result := FScrollBar.OnScroll;
end;

procedure TGridScrollBarPanelControlEh.Invalidate;
var
  i: Integer;
begin
  inherited Invalidate;
  for i := 0 to ControlCount-1 do
    Controls[i].Invalidate;
end;

function TGridScrollBarPanelControlEh.MaxSizeForExtraPanel: Integer;
begin
  Result := Width - GetSystemMetrics(SM_CYHSCROLL) * 2;
end;

procedure TGridScrollBarPanelControlEh.OnScrollEvent(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  Grid: TCustomGridCrack;
begin
  Grid := TCustomGridCrack(Owner);
  if (FKind = sbHorizontal) and UseRightToLeftAlignment then
  begin
    ScrollPos := ScrollBar.Max - ScrollPos;
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  end else
    Grid.ScrollBarMessage(ScrollBatCode, Cardinal(ScrollCode), ScrollPos, True);
  ScrollPos := FScrollBar.Position;
end;

function TGridScrollBarPanelControlEh.ScrollBatCode: Integer;
begin
  if FKind = sbHorizontal
    then Result := SB_HORZ
    else Result := SB_VERT;
end;

procedure TGridScrollBarPanelControlEh.SetKeepMaxSizeInDefault(
  const Value: Boolean);
begin
  if FKeepMaxSizeInDefault <> Value then
  begin
    FKeepMaxSizeInDefault := Value;
    Realign;
  end;
end;

procedure TGridScrollBarPanelControlEh.SetOnScroll(const Value: TScrollEvent);
begin
  FScrollBar.OnScroll := Value;
end;

procedure TGridScrollBarPanelControlEh.SetParams(APosition, AMin, AMax, APageSize: Integer);
begin
  FScrollBar.Enabled := True;
  if FScrollBar.PageSize > AMax then
    FScrollBar.PageSize := 0;
  if AMin > AMax then
    AMax := AMin;
  FScrollBar.SetParams(APosition, AMin, AMax);
  FScrollBar.PageSize := APageSize;
  if (AMax <= AMin) or (AMax - AMin < APageSize) then
  begin
    IgnoreCancelMode := True;
    try
      FScrollBar.Enabled := False;
    finally
      IgnoreCancelMode := False;
    end;
  end;
end;

procedure TGridScrollBarPanelControlEh.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
end;

procedure TGridScrollBarPanelControlEh.Resize;
var
  NewWidth, NewHeight: Integer;
begin
  inherited Resize;
  if not HandleAllocated then Exit;
  if FKind = sbHorizontal then
  begin
    NewWidth := Width;
    NewHeight := TCustomGridCrack(Owner).HorzScrollBar.ActualScrollBarBoxSize;
  end else
  begin
    NewWidth := TCustomGridCrack(Owner).VertScrollBar.ActualScrollBarBoxSize;
    NewHeight := Height;
  end;
  FScrollBar.SetBounds(Width - NewWidth, Height - NewHeight, NewWidth, NewHeight);
end;

procedure TGridScrollBarPanelControlEh.AdjustSize;
begin
  {$IFDEF FPC}
  //
  {$ELSE}
  inherited AdjustSize;
  {$ENDIF}
end;

procedure TGridScrollBarPanelControlEh.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
begin
  if (AWidth < 0) then AWidth := 0;
  if (AHeight < 0) then AHeight := 0;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

{ TSizeGripPanelEh }

const
  PositionArr: array[TSizeGripPosition] of TCursor = (crSizeNWSE, crSizeNESW, crSizeNWSE, crSizeNESW);

constructor TSizeGripPanelEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls];
  Position := sgpBottomRight;
  FMouseMousePos := Point(-1, -1);
  {$IFDEF FPC}
  {$ELSE}
  ParentBackground := False;
  {$ENDIF}
end;

function TSizeGripPanelEh.CheckInCorner: Boolean;
var
  Point1, Point2: TPoint;
  NextParent: TWinControl;
begin
  Result := False;
  if UseRightToLeftAlignment
    then Point1 := ClientToScreen(Point(0, Height))
    else Point1 := ClientToScreen(Point(Width, Height));
  NextParent := GetSizableForm;
  if NextParent <> nil then
  begin
    if (GetWindowLong(NextParent.Handle, GWL_STYLE) and WS_THICKFRAME) <> 0 then
    begin
      if UseRightToLeftAlignment then
        Point2 := NextParent.ClientToScreen(Point(0, NextParent.ClientHeight))
      else
        Point2 := NextParent.ClientToScreen(Point(NextParent.ClientWidth, NextParent.ClientHeight));
      if (Abs(Point2.X - Point1.X) < 4) and (Abs(Point2.Y - Point1.Y) < 4) then
        Result := True;
    end;
  end;
end;

function TSizeGripPanelEh.CheckGripActive: Boolean;
begin
  if GripActiveStatus = gasNeverEh then
    Result := False
  else if GripActiveStatus = gasAutoEh then
    Result := CheckInCorner
  else
    Result := True;
end;

procedure TSizeGripPanelEh.CreateWnd;
begin
  inherited CreateWnd;
  UpdateWindowRegion;
  Invalidate;
end;

procedure TSizeGripPanelEh.Resize;
begin
  inherited Resize;
  if CheckGripActive
    then Cursor := PositionArr[Position]
    else Cursor := crDefault;
end;

function TSizeGripPanelEh.GetSizableForm: TWinControl;
{$IFDEF FPC_CROSSP}
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if (Form <> nil) and (Form.WindowState = wsNormal) then
    Result := Form
  else
    Result := nil;
end;
{$ELSE}
var
  Placement: TWindowPlacement;
begin
  Result := Parent;
  while Result <> nil do
  begin
    if GetParent(Result.Handle) = GetDesktopWindow then
      Break
    else if (GetWindowLong(Result.Handle, GWL_STYLE) and WS_CHILD) = 0 then
      Break
    else if ((GetWindowLong(Result.Handle, GWL_STYLE) and WS_CHILD) = WS_CHILD) and
            ((GetWindowLong(Result.Handle, GWL_EXSTYLE) and WS_EX_MDICHILD) = WS_EX_MDICHILD) then
      Break;
    Result := Result.Parent;
  end;
  if (Result <> nil) and Result.HandleAllocated then
  begin
    Placement.length := SizeOf(TWindowPlacement);
    GetWindowPlacement(Result.Handle, @Placement);
    if (Placement.showCmd = SW_SHOWMINIMIZED) or (Placement.showCmd = SW_SHOWMAXIMIZED) then
      Result := nil;
  end;
end;
{$ENDIF}

function TSizeGripPanelEh.GetFormSize: TPoint;
var
  NextParent: TWinControl;
begin
  Result := Point(-1, -1);
  NextParent := GetSizableForm;
  if NextParent <> nil then
    Result := NextParent.ClientToScreen(Point(NextParent.Width, NextParent.Height));
end;

procedure TSizeGripPanelEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  NextParent: TWinControl;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if MouseCapture and CheckGripActive then
  begin
    NextParent := GetSizableForm;
    if NextParent = nil then Exit;

    FInitFormSize := Point(NextParent.Width, NextParent.Height);
    FInitFormPos := Point(NextParent.Left, NextParent.Top);
    FMouseMousePos := ClientToScreen(Point(X,Y));
  end;
end;

procedure TSizeGripPanelEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewMousePos: TPoint;
  NextParent: TWinControl;
  NewLeft, NewTop, NewWidth, NewHeight: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture and not ((FMouseMousePos.X = -1) and (FMouseMousePos.X = -1)) then
  begin
    NewMousePos := ClientToScreen(Point(X,Y));
    if (NewMousePos.X <> FMouseMousePos.X) or (NewMousePos.Y <> FMouseMousePos.Y) then
    begin
      NextParent := GetSizableForm;
      if Position = sgpTopLeft then
      begin
        NewWidth := FInitFormSize.X - (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y - (NewMousePos.Y - FMouseMousePos.Y);
        NewLeft := FInitFormPos.X + FInitFormSize.X - NewWidth;
        NewTop := FInitFormPos.Y + FInitFormSize.Y - NewHeight;
      end else if Position = sgpTopRight then
      begin
        NewWidth := FInitFormSize.X + (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y - (NewMousePos.Y - FMouseMousePos.Y);
        NewLeft := FInitFormPos.X;
        NewTop := FInitFormPos.Y + FInitFormSize.Y - NewHeight;
      end else if Position = sgpBottomRight then
      begin
        NewWidth := FInitFormSize.X + (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y + (NewMousePos.Y - FMouseMousePos.Y);
        NewLeft := FInitFormPos.X;
        NewTop := FInitFormPos.Y;
      end else
      begin 
        NewWidth := FInitFormSize.X - (NewMousePos.X - FMouseMousePos.X);
        NewHeight := FInitFormSize.Y + (NewMousePos.Y - FMouseMousePos.Y);
        NewLeft := FInitFormPos.X + FInitFormSize.X - NewWidth;
        NewTop := FInitFormPos.Y;
      end;

      NextParent.SetBounds(
        NewLeft,
        NewTop,
        NewWidth,
        NewHeight
      );
      NextParent.Repaint;
    end;
  end;
end;

procedure TSizeGripPanelEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FMouseMousePos := Point(-1, -1);
end;

procedure TSizeGripPanelEh.Paint;
{$IFDEF FPC}
const
  DFCS_SCROLLSIZEGRIPRIGHT = $0010;
{$ENDIF}
{$IFDEF EH_LIB_16}
const  PositionElementDetailsArr: array[TSizeGripPosition] of TThemedScrollBar =
  (tsSizeBoxTopLeftAlign, tsSizeBoxTopRightAlign, tsSizeBoxRightAlign, tsSizeBoxLeftAlign);
{$ENDIF}
var
  DrawFlags: Integer;
{$IFDEF EH_LIB_16}
  Details: TThemedElementDetails;
{$ENDIF}
  BM: TBitmap;

  procedure UpendDraw;
  var
    Org: TPoint;
    Ext: TPoint;
  begin
    Org := Point(0, ClientHeight);
    Ext := Point(1,-1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;

  procedure RestoreDraw;
  var
    Org: TPoint;
    Ext: TPoint;
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;

begin
  if CheckGripActive then
  begin
{$IFDEF EH_LIB_16}
    Canvas.Brush.Color := StyleServices.GetSystemColor(clBtnFace);
    Canvas.FillRect(GetClientRect);
    if ThemeServices.ThemesEnabled then
    begin
      Details := ThemeServices.GetElementDetails(PositionElementDetailsArr[Position]);
      ThemeServices.DrawElement(Canvas.Handle, Details, Rect(0,0, Width, Height));
    end else
{$ENDIF}
    begin
      if Position in [sgpTopLeft, sgpBottomLeft]
        then DrawFlags := DFCS_SCROLLSIZEGRIPRIGHT
        else DrawFlags := DFCS_SCROLLSIZEGRIP;
      if Position in [sgpTopLeft, sgpTopRight] then
      begin
        UpendDraw;

        BM := TBitmap.Create;
        BM.Width := ClientWidth;
        BM.Height := ClientHeight;
        BM.Canvas.Brush.Color := Color;
        BM.Canvas.FillRect(BM.Canvas.ClipRect);

        DrawFrameControl(BM.Canvas.Handle, Rect(0,0, Width, Height), DFC_SCROLL, DrawFlags);
        Canvas.Draw(0,0, BM);
        BM.Free;
        RestoreDraw;
       end else
         DrawFrameControl(Canvas.Handle, Rect(0,0, Width, Height), DFC_SCROLL, DrawFlags);
    end
  end else
  begin
    Canvas.Brush.Color := StyleServices.GetSystemColor(clBtnFace);
    Canvas.FillRect(GetClientRect);
  end;
end;

procedure TSizeGripPanelEh.SetTriangleWindow(const Value: Boolean);
begin
  if FTriangleWindow = Value then Exit;
  FTriangleWindow := Value;
  UpdateWindowRegion;
end;

procedure TSizeGripPanelEh.UpdateWindowRegion;
var
  Points: array[0..2] of TPoint;
  Region: HRgn;
begin
  if not HandleAllocated then Exit;
  if TriangleWindow then
  begin
    if Position = sgpBottomRight then
    begin
      Points[0] := Point(0, Height);
      Points[1] := Point(Width, Height);
      Points[2] := Point(Width, 0);
    end else if Position = sgpBottomLeft then
    begin
      Points[0] := Point(Width, Height);
      Points[1] := Point(0, Height);
      Points[2] := Point(0, 0);
    end else if Position = sgpTopLeft then
    begin
      Points[0] := Point(Width - 1, 0);
      Points[1] := Point(0, 0);
      Points[2] := Point(0, Height - 1);
    end else if Position = sgpTopRight then
    begin
      Points[0] := Point(Width, Height - 1);
      Points[1] := Point(Width, 0);
      Points[2] := Point(1, 0);
    end;
    Region := WindowsCreatePolygonRgn(Points, 3, WINDING);
    SetWindowRgn(Handle, Region, True);
  end else
  begin
    SetWindowRgn(Handle, 0, True);
  end;
  if CheckGripActive
    then Cursor := PositionArr[Position]
    else Cursor := crDefault;
end;

procedure TSizeGripPanelEh.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
end;

procedure TSizeGripPanelEh.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if CheckGripActive
    then Cursor := PositionArr[Position]
    else Cursor := crDefault;
end;

procedure TSizeGripPanelEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TSizeGripPanelEh.SetPosition(const Value: TSizeGripPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    UpdateWindowRegion;
  end;
end;

procedure TSizeGripPanelEh.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
begin
  if (AWidth < 0) then AWidth := 0;
  if (AHeight < 0) then AHeight := 0;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

{ TControlScrollBarEh }

procedure TControlScrollBarEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result := 1;
end;

procedure TControlScrollBarEh.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TControlScrollBarEh.WMCancelMode(var Message: TMessage);
begin
  if not TGridScrollBarPanelControlEh(Parent).IgnoreCancelMode then
    inherited;
end;

procedure TControlScrollBarEh.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TGridScrollBarPanelControlEh(Parent).ChildControlCanMouseDown(Self) then
    inherited;
end;

procedure TControlScrollBarEh.WMRButtonDown(var Message: TWMRButtonDown);
begin
  if TGridScrollBarPanelControlEh(Parent).ChildControlCanMouseDown(Self) then
    inherited;
end;

procedure TControlScrollBarEh.WMMButtonDown(var Message: TWMMButtonDown);
begin
  if TGridScrollBarPanelControlEh(Parent).ChildControlCanMouseDown(Self) then
    inherited;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
procedure TControlScrollBarEh.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;
{$ENDIF}

{ TGridDragWinEh }

constructor TGridDragWinEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := cl3DDkShadow;
  FAlphaBlendValue := 200;
  BorderWidth := 0;
  inherited Visible := False;
  {$IFDEF FPC}
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  ParentWindow := Win32WidgetSet.AppHandle;
  {$ENDIF}
  {$ELSE}
  ParentWindow := Application.Handle;
  {$ENDIF}
end;

procedure TGridDragWinEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := WS_POPUP;
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  Params.WindowClass.Style := Params.WindowClass.Style or CS_SAVEBITS;
  {$ENDIF}
  if NewStyleControls then
    Params.ExStyle := WS_EX_TOOLWINDOW;
{$IFDEF FPC}
{$ELSE}
  AddBiDiModeExStyle(Params.ExStyle);
{$ENDIF}

{$IFDEF FPC_CROSSP}
{$ELSE}
  if Assigned(@SetLayeredWindowAttributes) then
    Params.ExStyle := Params.ExStyle or WS_EX_LAYERED;
{$ENDIF}
end;

procedure TGridDragWinEh.CreateWnd;
begin
  inherited CreateWnd;
  SetLayeredAttribs;
end;

procedure TGridDragWinEh.SetLayeredAttribs;
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
const
  cUseAlpha: array [Boolean] of Integer = (0, LWA_ALPHA);
  cUseColorKey: array [Boolean] of Integer = (0, LWA_COLORKEY);
var
  AStyle: Integer;
begin
  if not (csDesigning in ComponentState) and
{$IFNDEF VER140} 
    (Assigned(@SetLayeredWindowAttributes)) and
{$ENDIF}
    HandleAllocated then
  begin
    AStyle := GetWindowLong(Handle, GWL_EXSTYLE);
    if (FAlphaBlendValue <> 255) or (FTransparentColorValue <> clNone) then
    begin
      if (AStyle and WS_EX_LAYERED) = 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, AStyle or WS_EX_LAYERED);
      SetLayeredWindowAttributes(Handle, FTransparentColorValue, FAlphaBlendValue,
        cUseAlpha[FAlphaBlendValue <> 255] or cUseColorKey[FTransparentColorValue <> clNone]);
    end
    else
    begin
      SetWindowLong(Handle, GWL_EXSTYLE, AStyle and not WS_EX_LAYERED);
      RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
    end;
  end;
end;
{$ENDIF}

procedure TGridDragWinEh.MoveToFor(NewPos: TPoint);
begin
  SetBounds(NewPos.X, NewPos.Y, Width, Height);
end;

procedure TGridDragWinEh.MoveToFor(NewPos: TPoint; NewWidth, NewHeight: Integer);
begin
  SetBounds(NewPos.X, NewPos.Y, NewWidth, NewHeight);
end;

procedure TGridDragWinEh.StartShow(Pos: TPoint; Width, Height: Integer);
begin
  SetBounds(Pos.X, Pos.Y, Width, Height);
  inherited Visible := True;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
    SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TGridDragWinEh.StartShow(Pos: TPoint; Height: Integer);
begin
  StartShow(Pos, Width, Height);
end;

procedure TGridDragWinEh.Show;
begin
  raise Exception.Create('Show is not supported. Use StartShow');
end;

procedure TGridDragWinEh.TemporaryHide;
begin
  SetBounds(Left, Top, 0, 0);
end;

procedure TGridDragWinEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
{$IFDEF MSWINDOWS}
  inherited;
{$ELSE}
  Message.Result := 1;
{$ENDIF}
end;

{ TGridDragBoxEh }

constructor TGridDragBoxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TGridDragBoxEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TGridDragBoxEh.Paint;
begin
  Canvas.Brush.Color := clGray;
  Canvas.FillRect(ClientRect);
end;

{ TGridMoveLineEh }

constructor TGridMoveLineEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clWhite;
  Width := 7;
  Height := 7;
  FLineColor := clRed;
  FIsVert := True;

  AlphaBlendValue := 255;
  {$IFDEF FPC}
  {$ELSE}
  TransparentColorValue := clWhite;
  TransparentColor := True;
  {$ENDIF}
  DropShadow := False;
end;

procedure TGridMoveLineEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TGridMoveLineEh.StartShow(Pos: TPoint; AIsVert: Boolean; Size: Integer; ACaptureControl: TObject);
begin
  FIsVert := AIsVert;
  Pos.X := Pos.X - 3;
  Pos.Y := Pos.Y - 4;
  Size := Size + 8;
  if IsVert
    then inherited StartShow(Pos, 7, Size)
    else inherited StartShow(Pos, Size, 7)
end;

procedure TGridMoveLineEh.MoveToFor(NewPos: TPoint);
begin
  NewPos.X := NewPos.X - 3;
  NewPos.Y := NewPos.Y - 4;
  inherited MoveToFor(NewPos);
end;

procedure TGridMoveLineEh.Paint;
var
  b: Integer;
begin
  Canvas.Pen.Color := LineColor;

  if (IsVert) then
  begin
    Canvas.Polyline([Point(0, 0), Point(7, 0)]);
    Canvas.Polyline([Point(1, 1), Point(6, 1)]);
    Canvas.Polyline([Point(2, 2), Point(5, 2)]);
    Canvas.Polyline([Point(3, 3), Point(4, 3)]);

    Canvas.Polyline([Point(3, 4), Point(3, ClientHeight - 4)]);

    b := ClientHeight;
    Canvas.Polyline([Point(3, b-4), Point(4, b-4)]);
    Canvas.Polyline([Point(2, b-3), Point(5, b-3)]);
    Canvas.Polyline([Point(1, b-2), Point(6, b-2)]);
    Canvas.Polyline([Point(0, b-1), Point(7, b-1)]);
  end else
  begin
    Canvas.Polyline([Point(0, 0), Point(0, 7)]);
    Canvas.Polyline([Point(1, 1), Point(1, 6)]);
    Canvas.Polyline([Point(2, 2), Point(2, 5)]);
    Canvas.Polyline([Point(3, 3), Point(3, 4)]);

    Canvas.Polyline([Point(4, 3), Point(ClientWidth - 4, 3)]);

    b := ClientWidth;
    Canvas.Polyline([Point(b-4, 3), Point(b-4, 4)]);
    Canvas.Polyline([Point(b-3, 2), Point(b-3, 5)]);
    Canvas.Polyline([Point(b-2, 1), Point(b-2, 6)]);
    Canvas.Polyline([Point(b-1, 0), Point(b-1, 7)]);
  end;
end;

var
  FDragBox: TGridDragWinEh;
  FMoveLine: TGridMoveLineEh;

function GetDragBoxEh: TGridDragWinEh;
begin
  if FDragBox = nil then
  begin
    FDragBox := TGridDragBoxEh.Create(Application);
    FDragBox.TransparentColorValue := clNone;
  end;
  Result := FDragBox;
end;

function GetMoveLineEh: TGridMoveLineEh;
begin
  if FMoveLine = nil then
  begin
    FMoveLine := TGridMoveLineEh.Create(Application);
  end;
  Result := FMoveLine;
end;

end.
