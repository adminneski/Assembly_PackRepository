{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                   DropingDown Forms                   }
{                                                       }
{   Copyright (c) 2013-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit DropDownFormEh;

{$I EhLib.Inc}

interface

uses
  Messages,
  {$IFDEF FPC}
    EhLibLCL, LCLType, LCLIntf, LMessages,
   {$IFDEF FPC_CROSSP}
   {$ELSE}
   Windows, UxTheme, MultiMon,
   {$ENDIF}
  {$ELSE}
    EhLibVCL, Windows, UxTheme, MultiMon,
  {$ENDIF}
  Types, Themes,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolCtrlsEh, ButtonsEh, DynVarsEh, DBCtrls, Buttons, ExtCtrls;

type
  TCustomDropDownFormEh = class;
  TDDFCloseButtonEh = class;
  TDDFSizingBarEh = class;

  TDropLayoutEh = (dlAboveControlEh, dlUnderControlEh);
  TDropDownFormElementEh = (ddfeLeftGripEh, ddfeRightGripEh, ddfeCloseButtonEh, ddfeSizingBarEh);
  TDropDownFormElementsEh = set of TDropDownFormElementEh;

  TInitDropDownFormEventEh = procedure(Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh) of object;
  TPutBackFormParamsEventEh = procedure(Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh) of object;



  { TCustomDropDownFormEh }

  TCustomDropDownFormEh = class(TForm, IDropDownFormEh, IDynParamsInteractableEh)
  private
    FBorderWidth: Integer;
    FCallbackProc: TDropDownFormCallbackProcEh;
    FDropDownMode: Boolean;
    FFormElements: TDropDownFormElementsEh;
    FKeepFormVisible: Boolean;
    FOnInitForm: TInitDropDownFormEventEh;
    FOnReturnParams: TPutBackFormParamsEventEh;
    FReadOnly: Boolean;
    FSizeGrip: TSizeGripEh;
    FSizeGrip2: TSizeGripEh;

    function GetBorderStyle: TFormBorderStyle;
    function GetControlClientRect: TRect;
    function GetReadOnly: Boolean;
    procedure SetDropDownMode(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);

    procedure WMActivate(var msg: TWMActivate); message WM_ACTIVATE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure SetKeepFormVisible(const Value: Boolean);

  protected
    FActivateClosing: Boolean;
    FActivateShowing: Boolean;
    FCloseButton: TDDFCloseButtonEh;
    FDropLayout: TDropLayoutEh;
    FDynParams: TDynVarsEh;
    FMasterFocusControl: TWinControl;
    FMasterForm: TCustomForm;
    FModalMode: Boolean;
    FSizingBar: TDDFSizingBarEh;
    FSysParams: TDropDownFormSysParams;
    FClosing: Boolean;

    function DoHandleStyleMessage(var Message: TMessage): Boolean; {$IFDEF EH_LIB_16} override; {$ENDIF}

{$IFDEF EH_LIB_14}
    procedure GetBorderStyles(var Style, ExStyle, ClassStyle: Cardinal); override;
{$ENDIF}
    procedure AdjustClientRect(var aRect: TRect); override;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure DoHide; override;
    procedure DrawBorder(BorderRect: TRect); virtual;
    procedure GetOutDynParams(var DynParams: TDynVarsEh); virtual;
    procedure InitializeNewForm; {$IFDEF EH_LIB_12} override; {$else} virtual; {$ENDIF}
    procedure Loaded; override;
    procedure Paint; override;
    procedure SetInDynParams(DynParams: TDynVarsEh); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;

    function Execute(RelativePosControl: TControl; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh): Boolean; virtual;
    function ShowModal: Integer; override;

    procedure ExecuteNomodal(RelativePosRect: TRect; DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams; CallbackProc: TDropDownFormCallbackProcEh);
    procedure InitElements; virtual;
    procedure InitForm(Host: TComponent; DynParams: TDynVarsEh); virtual;
    procedure ReturnParams(Host: TComponent; DynParams: TDynVarsEh); virtual;
    procedure Show;
    procedure Close;
    procedure UpdateSize; virtual;

    class function GetGlobalRef: TCustomDropDownFormEh; virtual;

    property BorderWidth: Integer read FBorderWidth write FBorderWidth;
    property CallbackProc: TDropDownFormCallbackProcEh read FCallbackProc;
    property KeepFormVisible: Boolean read FKeepFormVisible write SetKeepFormVisible;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property ControlClientRect: TRect read GetControlClientRect;

  published
    property FormElements: TDropDownFormElementsEh read FFormElements write FFormElements default [ddfeLeftGripEh, ddfeRightGripEh, ddfeCloseButtonEh, ddfeSizingBarEh];

    property BorderStyle: TFormBorderStyle read GetBorderStyle stored False;
    property DropDownMode: Boolean read FDropDownMode write SetDropDownMode;

    property OnInitForm: TInitDropDownFormEventEh read FOnInitForm write FOnInitForm;
    property OnReturnParams: TPutBackFormParamsEventEh read FOnReturnParams write FOnReturnParams;
  end;

  TCustomDropDownFormClassEh = class of TCustomDropDownFormEh;

{ TDDFCloseButtonEh }

  TDDFCloseButtonEh = class(TWinControl)
  private
    FButtonControl: TSpeedButtonEh;
    procedure PaintHandler(Sender: TObject);
    procedure ClickHandler(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TDDFSizingBarEh }

  TDDFSizingBarEh = class(TCustomPanel)
  private
    FHostControl: TWinControl;
    FMouseDownPos: TPoint;
    FSizingArea: Integer;
    {$IFDEF FPC_CROSSP}
    {$ELSE}
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    {$ENDIF}

  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Resize; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property HostControl: TWinControl read FHostControl write FHostControl;
  end;

var
  OpenDropDownFormProc: procedure(DDFCallParam: TDropDownFormCallParamsEh) = nil;

implementation


procedure OpenDropDownForm(DDFCallParam: TDropDownFormCallParamsEh);
begin

end;

procedure RegisterClasses;
begin
  RegisterClass(TCustomDropDownFormEh);
  OpenDropDownFormProc := OpenDropDownForm;
end;

procedure UnregisterClasses;
begin
  UnregisterClass(TCustomDropDownFormEh);
end;

function AdjustDropDownForm(AControl: TControl; HostRect: TRect; Align: TDropDownAlign): TDropLayoutEh;
var
  WorkArea: TRect;
  HostP: TPoint;
  MonInfo: TMonitorInfo;
begin

  Result := dlUnderControlEh;

  MonInfo.cbSize := SizeOf(MonInfo);
{$IFDEF CIL}
  GetMonitorInfo(MonitorFromRect(HostRect, MONITOR_DEFAULTTONEAREST), MonInfo);
{$ELSE}
  GetMonitorInfo(MonitorFromRect(@HostRect, MONITOR_DEFAULTTONEAREST), @MonInfo);
{$ENDIF}

  WorkArea := MonInfo.rcWork;

  {$IFDEF FPC_CROSSP}
  WorkArea := Screen.DesktopRect;
  {$ELSE}
  {$ENDIF}

  HostP := HostRect.TopLeft;

  AControl.Left := HostP.x;
  AControl.Top := HostP.y + (HostRect.Bottom - HostRect.Top) + 1;

  case Align of
    daRight: AControl.Left := AControl.Left - (AControl.Width - (HostRect.Right - HostRect.Left) );
    daCenter: AControl.Left := AControl.Left - ((AControl.Width - (HostRect.Right - HostRect.Left)) div 2);
  end;

  if (AControl.Width > WorkArea.Right - WorkArea.Left) then
    AControl.Width := WorkArea.Right - WorkArea.Left;

  if (AControl.Left + AControl.Width > WorkArea.Right) then
    AControl.Left := WorkArea.Right - AControl.Width;
  if (AControl.Left < WorkArea.Left) then
    AControl.Left := WorkArea.Left;

  if (AControl.Top + AControl.Height > WorkArea.Bottom) then
  begin
    if (HostP.y - WorkArea.Top > WorkArea.Bottom - HostP.y - (HostRect.Bottom - HostRect.Top)) then
    begin
      Result := dlAboveControlEh;
      AControl.Top := HostP.y - AControl.Height;
    end;
  end;

  if (AControl.Top < WorkArea.Top) then
  begin
    AControl.Height := AControl.Height - (WorkArea.Top - AControl.Top);
    AControl.Top := WorkArea.Top;
  end;
  if (AControl.Top + AControl.Height > WorkArea.Bottom) then
  begin
    AControl.Height := WorkArea.Bottom - AControl.Top;
  end;
end;

constructor TCustomDropDownFormEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropDownMode := True;
  inherited BorderStyle := bsNone;
  if (Constraints.MinWidth = 0) then
    Constraints.MinWidth := GetSystemMetrics(SM_CXVSCROLL) * 2;
  if (Constraints.MinHeight = 0) then
    Constraints.MinHeight := GetSystemMetrics(SM_CYVSCROLL) * 2;
  Position := poDesigned;
end;

constructor TCustomDropDownFormEh.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  inherited CreateNew(AOwner);
{$IFNDEF EH_LIB_12}
  InitializeNewForm;
{$ENDIF}
end;

destructor TCustomDropDownFormEh.Destroy;
begin
  FreeAndNil(FCloseButton);
  FreeAndNil(FSizingBar);
  FreeAndNil(FSizeGrip);
  FreeAndNil(FSizeGrip2);
  inherited Destroy;
end;

procedure TCustomDropDownFormEh.InitializeNewForm;
begin
{$IFDEF EH_LIB_12}
  inherited InitializeNewForm;
{$ENDIF}

  FCloseButton := TDDFCloseButtonEh.Create(nil);
  FCloseButton.Parent := Self;
  FCloseButton.Visible := False;

  FSizingBar := TDDFSizingBarEh.Create(nil);
  FSizingBar.Parent := Self;
  FSizingBar.Visible := False;
  FSizingBar.HostControl := Self;

  FSizeGrip := TSizeGripEh.Create(nil);
  FSizeGrip.HostControl := Self;
  FSizeGrip.TriangleWindow := True;
  FSizeGrip.Visible := False;

  FSizeGrip2 := TSizeGripEh.Create(nil);
  FSizeGrip2.HostControl := Self;
  FSizeGrip2.TriangleWindow := True;
  FSizeGrip2.Position := sgpBottomLeft;
  FSizeGrip2.Visible := False;

  FCloseButton.Anchors := [akTop, akRight];
  FFormElements := [ddfeLeftGripEh, ddfeRightGripEh, ddfeCloseButtonEh, ddfeSizingBarEh];
  BorderIcons := [];
  inherited BorderStyle := bsNone;
  FDropDownMode := True;

  {$IFDEF FPC_CROSSP}
  FBorderWidth := 2;
  {$ELSE}
  if CheckWin32Version(10, 0) then
    FBorderWidth := 1
  else if CheckWin32Version(6, 0) then
    FBorderWidth := 3
  else
    FBorderWidth := 2;
  {$ENDIF}

  Constraints.MinWidth := GetSystemMetrics(SM_CXVSCROLL) * 2;
  Constraints.MinHeight := GetSystemMetrics(SM_CYVSCROLL) * 2;
  Position := poDesigned;
  FormStyle := fsStayOnTop;

end;

function TCustomDropDownFormEh.Execute(RelativePosControl: TControl;
  DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh): Boolean;
var
  SelfPos, RelPos: TPoint;
begin
  FModalMode := True;
  FDynParams := DynParams;

  if Visible then
    Visible := False;

  FDropLayout := AdjustDropDownForm(Self, ClientToScreenRect(RelativePosControl), Align);
  SelfPos := Self.ClientToScreen(Point(0,0));
  RelPos := RelativePosControl.ClientToScreen(Point(0,0));
  if SelfPos.Y < RelPos.Y then
  begin
    FSizeGrip.Position := sgpTopRight;
    FSizeGrip2.Position := sgpTopLeft;
  end else
  begin
    FSizeGrip.Position := sgpBottomRight;
    FSizeGrip2.Position := sgpBottomLeft;
  end;

  InitForm(nil, DynParams);

  ModalResult := mrNone;
  Visible := True;

  while Active and (ModalResult = mrNone) do
    Application.HandleMessage;

  Visible := False;
  Result := False;
  if ModalResult = mrOk then
  begin
    Result := True;
    ReturnParams(nil, DynParams);
  end;
end;

procedure TCustomDropDownFormEh.ExecuteNomodal(RelativePosRect: TRect;
  DownStateControl: TControl; Align: TDropDownAlign; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams; CallbackProc: TDropDownFormCallbackProcEh);
begin
  {$IFDEF FPC}
  {$ELSE}
  inherited BorderStyle := bsNone;
  {$ENDIF}
  DropDownMode := True;
  FModalMode := False;
  FDynParams := DynParams;
  FSysParams := SysParams;
  FMasterForm := Screen.ActiveCustomForm;
  FMasterFocusControl := Screen.ActiveControl;

  if Visible then
    Visible := False;

  UpdateSize;
  FDropLayout := AdjustDropDownForm(Self, RelativePosRect, Align);
  if FDropLayout = dlAboveControlEh then
  begin
    FSizeGrip.Position := sgpTopRight;
    FSizeGrip2.Position := sgpTopLeft;
  end else
  begin
    FSizeGrip.Position := sgpBottomRight;
    FSizeGrip2.Position := sgpBottomLeft;
  end;

  InitElements;
  InitForm(nil, DynParams);

  ModalResult := mrNone;

  FActivateShowing := True;
  try
    Visible := True;
  finally
    FActivateShowing := False;
  end;


  FCallbackProc := CallbackProc;
end;

{$IFDEF EH_LIB_14}
procedure TCustomDropDownFormEh.GetBorderStyles(var Style, ExStyle,
  ClassStyle: Cardinal);
begin
  inherited GetBorderStyles(Style, ExStyle, ClassStyle);
end;
{$ENDIF}

procedure TCustomDropDownFormEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  if DropDownMode then
    SetWindowDropShadowStyle(Self, Params, True);
end;

procedure TCustomDropDownFormEh.CreateWnd;
begin
  inherited CreateWnd;
  if not (csDesigning in ComponentState) then
  begin
    FSizeGrip.HandleNeeded;
    FSizeGrip.UpdatePosition;
    FSizeGrip.Visible := ddfeRightGripEh in FormElements;
    FSizeGrip.BringToFront;
    FSizeGrip2.HandleNeeded;
    FSizeGrip2.UpdatePosition;
    FSizeGrip2.Visible := ddfeLeftGripEh in FormElements;
    FSizeGrip2.BringToFront;
  end;
end;

procedure TCustomDropDownFormEh.CreateHandle;
begin
  inherited CreateHandle;
end;

function TCustomDropDownFormEh.DoHandleStyleMessage(
  var Message: TMessage): Boolean;
begin
  if Message.Msg = WM_NCPAINT
    then Result := False
{$IFDEF EH_LIB_16}
    else Result := inherited DoHandleStyleMessage(Message);
{$ELSE}
    else Result := True;
{$ENDIF}
end;

procedure TCustomDropDownFormEh.DoHide;
begin
  inherited DoHide;
end;

procedure TCustomDropDownFormEh.AdjustClientRect(var aRect: TRect);
begin
  inherited AdjustClientRect(aRect);
  InflateRect(aRect, -BorderWidth, -BorderWidth);
  aRect.Top := aRect.Top + BorderWidth;
end;

procedure TCustomDropDownFormEh.Paint;
begin
  inherited Paint;
  DrawBorder(ClientRect);
end;

procedure TCustomDropDownFormEh.DrawBorder(BorderRect: TRect);
{$IFDEF FPC_CROSSP}
var
  ARect: TRect;
begin
  if (BorderWidth = 0) then Exit;
  ARect := ClientRect;
  Canvas.Brush.Color := CheckSysColor(clHighlight);
  Canvas.FrameRect(ARect);
  ARect.Bottom := ARect.Top + BorderWidth * 2;
  Canvas.FillRect(ARect);
end;
{$ELSE}
var
  DC: HDC;
  R, RTop: TRect;
  Details: TThemedElementDetails;
  ABrush: TBrush;
begin
  DC := Canvas.Handle;
  try
    R := ClientRect;

    ExcludeClipRect(DC,
      R.Left+FBorderWidth, R.Top+FBorderWidth, R.Right-FBorderWidth, R.Bottom-FBorderWidth);

    if CustomStyleActive or not ThemesEnabled then
    begin
      ABrush := TBrush.Create;
      ABrush.Color := StyleServices.GetSystemColor(cl3DDkShadow);
      {$WARNINGS OFF}
      FrameRect(DC, R, ABrush.Handle);
      {$WARNINGS ON}
      ABrush.Color := StyleServices.GetSystemColor(cl3DLight);
      InflateRect(R, -1, -1);
      {$WARNINGS OFF}
      Windows.FrameRect(DC, R, ABrush.Handle);
      {$WARNINGS ON}
      InflateRect(R, -1, -1);
      {$WARNINGS OFF}
      Windows.FrameRect(DC, R, ABrush.Handle);
      {$WARNINGS ON}
      ABrush.Free;
    end else
    begin
      RTop := Rect(R.Left, R.Top, R.Right, R.Top + FBorderWidth);
      Details := ThemeServices.GetElementDetails(twSmallCaptionActive);
      ThemeServices.DrawElement(DC, Details, RTop);

      R.Top := R.Top + FBorderWidth;
      Details := ThemeServices.GetElementDetails(twSmallFrameBottomActive);
      ThemeServices.DrawElement(DC, Details, R);
    end;
  finally
  end;
end;
{$ENDIF} 

procedure TCustomDropDownFormEh.WMSize(var Message: TWMSize);
begin
  inherited;
  if DropDownMode then
    Repaint;
end;

procedure TCustomDropDownFormEh.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if (FSizeGrip <> nil) and FSizeGrip.Visible then
  begin
    FSizeGrip.UpdatePosition;
    FSizeGrip.BringToFront;
  end;
  if (FSizeGrip2 <> nil) and FSizeGrip2.Visible then
  begin
    FSizeGrip2.UpdatePosition;
    FSizeGrip2.BringToFront;
  end;
end;

procedure TCustomDropDownFormEh.WMActivate(var msg: TWMActivate);
begin
  inherited;
  if DropDownMode and not (csDesigning in ComponentState) then
  begin
    if not FModalMode and
           (msg.Active = WA_INACTIVE) and
       not FKeepFormVisible and
       not FActivateClosing and
       not FActivateShowing
    then
    begin
      FActivateClosing := True;
      try
        Close;
      finally
        FActivateClosing := False;
      end;
    end;
  end;
end;

procedure TCustomDropDownFormEh.Close;
begin
  if FClosing then Exit;
  FClosing := True;
  try
    inherited Close;
  finally
    if (FMasterFocusControl <> nil) and
       not FActivateClosing and
       FMasterFocusControl.CanFocus
    then
      FMasterFocusControl.SetFocus;

    {$IFDEF CROSSVCL}
    DestroyWnd;
    {$ENDIF}

    FClosing := False;
  end;
end;

procedure TCustomDropDownFormEh.DoClose(var Action: TCloseAction);
var
  ACallbackProc: TDropDownFormCallbackProcEh;
begin
  if not (csDesigning in ComponentState) then
  begin
    if (FSysParams <> nil) and FSysParams.FreeFormOnClose then
      Action := caFree;
    if not FModalMode and Assigned(CallbackProc) then
    begin
      if ModalResult = mrOk then
        ReturnParams(nil, FDynParams);
      ACallbackProc := CallbackProc;
      FCallbackProc := nil;
      ACallbackProc(Self, ModalResult = mrOk, FDynParams, FSysParams);
      FSysParams := nil;
      FDynParams := nil;
      FCallbackProc := nil;
    end;
  end;
  inherited DoClose(Action);
end;

procedure TCustomDropDownFormEh.InitForm(Host: TComponent;
  DynParams: TDynVarsEh);
begin
  if Assigned(OnInitForm) then
    OnInitForm(Self, DynParams);
end;

procedure TCustomDropDownFormEh.ReturnParams(Host: TComponent;
  DynParams: TDynVarsEh);
begin
  if Assigned(OnReturnParams) then
    OnReturnParams(Self, DynParams);
end;

function TCustomDropDownFormEh.GetBorderStyle: TFormBorderStyle;
begin
  Result := inherited BorderStyle;
end;

function TCustomDropDownFormEh.GetControlClientRect: TRect;
begin
  Result := ClientRect;
  AdjustClientRect(Result);
end;

class function TCustomDropDownFormEh.GetGlobalRef: TCustomDropDownFormEh;
begin
  Result := nil;
end;

procedure TCustomDropDownFormEh.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) and (FSizeGrip <> nil) then
  begin
    FSizeGrip.UpdatePosition;
    FSizeGrip.Visible := ddfeRightGripEh in FormElements;
    FSizeGrip.BringToFront;
  end;

  if not (csDesigning in ComponentState) and (FSizeGrip2 <> nil) then
  begin
    FSizeGrip2.UpdatePosition;
    FSizeGrip2.Visible := ddfeLeftGripEh in FormElements;
    FSizeGrip2.BringToFront;
  end;
end;

procedure TCustomDropDownFormEh.InitElements;
begin

  if ddfeSizingBarEh in FormElements then
  begin
    FSizingBar.Visible := False;
    FSizingBar.BringToFront;
    if FDropLayout = dlUnderControlEh then
    begin
      FSizingBar.Top := Height + 1;
      FSizingBar.Align := alBottom;
      {$IFDEF FPC}
      {$ELSE}
      FSizingBar.BevelEdges := [beTop];
      {$ENDIF}
    end else
    begin
      FSizingBar.Top := -1;
      FSizingBar.Align := alTop;
      {$IFDEF FPC}
      {$ELSE}
      FSizingBar.BevelEdges := [beBottom];
      {$ENDIF}
    end;
    FSizingBar.Height := GetSystemMetrics(SM_CYVSCROLL) + 3;
    FSizingBar.Visible := True;
  end else
    FSizingBar.Visible := False;

  if ddfeCloseButtonEh in FormElements then
  begin
    FCloseButton.BringToFront;
    FCloseButton.Top := BorderWidth;
    FCloseButton.Left := ClientWidth - FCloseButton.Width - 3;
    FCloseButton.Visible := True;
    if FDropLayout = dlUnderControlEh then
    begin
      if ddfeSizingBarEh in FormElements then
      begin
        if ddfeLeftGripEh in FormElements
          then FCloseButton.Left := 18
          else FCloseButton.Left := 2;
        FCloseButton.Top := ClientHeight - FCloseButton.Height - BorderWidth;
        FCloseButton.Anchors := [akBottom, akLeft];
      end else
      begin
        FCloseButton.Left := ClientWidth - FCloseButton.Width - 3;
        FCloseButton.Anchors := [akTop, akRight];
      end
    end else
    begin
      FCloseButton.Left := ClientWidth - FCloseButton.Width - 18;
      FCloseButton.Top := BorderWidth;
      FCloseButton.Anchors := [akTop, akRight];
    end;
  end else
    FCloseButton.Visible := False;

  FSizeGrip.Visible := ddfeRightGripEh in FormElements;
  FSizeGrip2.Visible := ddfeLeftGripEh in FormElements;
end;

{ TDDFCloseButtonEh }

constructor TDDFCloseButtonEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtonControl := TSpeedButtonEh.Create(Self);
  FButtonControl.Parent := Self;
  FButtonControl.Align := alClient;
  FButtonControl.OnPaint := PaintHandler;
  FButtonControl.OnClick := ClickHandler;
  if not ThemeServices.ThemesEnabled then
  begin
    Width := GetSystemMetrics(SM_CYSMSIZE);
    Height := GetSystemMetrics(SM_CYSMSIZE);
  end else
  begin
    Width := 17;
    Height := 16;
  end;
end;

destructor TDDFCloseButtonEh.Destroy;
begin
  FreeAndNil(FButtonControl);
  inherited Destroy;
end;

procedure TDDFCloseButtonEh.ClickHandler(Sender: TObject);
var
  AForm: TCustomForm;
begin
  AForm := GetParentForm(Self);
  if AForm <> nil then
    AForm.Close;
end;

procedure TDDFCloseButtonEh.PaintHandler(Sender: TObject);
var
  Details: TThemedElementDetails;
  ARect, AFaceRect: TRect;
  bw: Integer;
  AState: Integer;
begin
  ARect := Rect(0, 0, Width, Height);
  if not ThemeServices.ThemesEnabled then
  begin
    bw := GetSystemMetrics(SM_CYSMSIZE);

    if FButtonControl.State = bsPressedEh then
      AState := DFCS_CHECKED
    else if FButtonControl.MouseInControl then
      AState := DFCS_HOT
    else
      AState := 0;

    AFaceRect := CenteredRect(ARect, Rect(0,0,bw,bw));
    DrawFrameControl(FButtonControl.Canvas.Handle, AFaceRect,
      DFC_CAPTION, DFCS_CAPTIONCLOSE or DFCS_FLAT or AState);
  end else
  begin
    if CustomStyleActive then
    begin
      if FButtonControl.State = bsPressedEh then
        Details := ThemeServices.GetElementDetails(twSmallCloseButtonPushed)
      else if FButtonControl.MouseInControl then
        Details := ThemeServices.GetElementDetails(twSmallCloseButtonHot)
      else
        Details := ThemeServices.GetElementDetails(twSmallCloseButtonNormal);
    end else
    begin
      if FButtonControl.State = bsPressedEh then
        Details := ThemeServices.GetElementDetails(tttClosePressed)
      else if FButtonControl.MouseInControl then
        Details := ThemeServices.GetElementDetails(tttCloseHot)
      else
        Details := ThemeServices.GetElementDetails(tttCloseNormal);
    end;
    ThemeServices.DrawElement(FButtonControl.Canvas.Handle, Details, ARect);
  end;
end;

{ TDDFSizingBarEh }

constructor TDDFSizingBarEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csCaptureMouse];
  BevelOuter := bvNone;
  {$IFDEF FPC}
  {$ELSE}
  BevelEdges := [beTop];
  BevelKind := bkTile;
  {$ENDIF}
end;

destructor TDDFSizingBarEh.Destroy;
begin
  inherited Destroy;
end;

procedure TDDFSizingBarEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FMouseDownPos := Point(-1,-1);
  if Align = alBottom then
  begin
    if Y > Height - FSizingArea then
      FMouseDownPos := Point(X, Y);
  end else
  begin
    if Y < FSizingArea then
      FMouseDownPos := Point(X, Y);
  end;
end;

procedure TDDFSizingBarEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Delta: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (ssLeft in Shift) and MouseCapture and (FMouseDownPos.X <> -1) and (FMouseDownPos.Y <> -1) then
    if Align = alBottom then
      HostControl.Height := HostControl.Height + (Y - FMouseDownPos.Y)
    else
    begin
      Delta := FMouseDownPos.Y - Y;
      HostControl.SetBounds(HostControl.Left, HostControl.Top - Delta, HostControl.Width, HostControl.Height + Delta);
    end;
end;

procedure TDDFSizingBarEh.Resize;
begin
  inherited Resize;
  if Height * 2 < 20
    then FSizingArea := Height div 2
    else FSizingArea := 10;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
procedure TDDFSizingBarEh.WMSetCursor(var Msg: TWMSetCursor);
var
  P: TPoint;
begin
  P := Point(LoWord(GetMessagePos), HiWord(GetMessagePos));
  P := ScreenToClient(P);

  if Msg.HitTest = HTCLIENT then
    if Align = alBottom then
    begin
      if P.Y > Height - FSizingArea then
      begin
        Windows.SetCursor(Screen.Cursors[crSizeNS]);
        Msg.Result := 1;
      end else
        inherited;
    end else
    begin
      if P.Y < FSizingArea then
      begin
        Windows.SetCursor(Screen.Cursors[crSizeNS]);
        Msg.Result := 1;
      end else
        inherited;
    end
  else
    inherited;
end;
{$ENDIF} 

function TCustomDropDownFormEh.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TCustomDropDownFormEh.SetDropDownMode(const Value: Boolean);
begin
  if FDropDownMode <> Value then
  begin
    FDropDownMode := Value;
    {$IFDEF FPC}
    RecreateWnd(Self);
    {$ELSE}
    RecreateWnd;
    {$ENDIF}
  end;
end;

procedure TCustomDropDownFormEh.SetInDynParams(DynParams: TDynVarsEh);
begin
  FDynParams := DynParams;
end;

procedure TCustomDropDownFormEh.GetOutDynParams(var DynParams: TDynVarsEh);
begin
  DynParams := FDynParams;
end;

procedure TCustomDropDownFormEh.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TCustomDropDownFormEh.Show;
begin
  DropDownMode := False;
  inherited Show;
end;

function TCustomDropDownFormEh.ShowModal: Integer;
begin
  DropDownMode := False;
  inherited BorderStyle := bsDialog;
  Position := poScreenCenter;
  BorderIcons := [biSystemMenu, biMinimize, biMaximize];
  InitForm(nil, FDynParams);
  Result := inherited ShowModal;
  if Result = mrOk then
    ReturnParams(nil, FDynParams);
end;

procedure TCustomDropDownFormEh.UpdateSize;
begin

end;

procedure TCustomDropDownFormEh.SetKeepFormVisible(const Value: Boolean);
begin
  FKeepFormVisible := Value;
end;

initialization
  RegisterClasses;
finalization
  UnregisterClasses;
end.

