{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{         TCalculatorEh, TPopupCalculatorEh             }
{                                                       }
{      Copyright (c) 2002-2022 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit CalculatorEh;

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
  EhLibVCL, Windows,
  {$ENDIF}
  Variants, StdCtrls, ExtCtrls, Buttons, Math, ClipBrd,
  ToolCtrlsEh, ButtonsEh, DynVarsEh, DropDownFormEh;

const
  DefCalcPrecision = 15;

type
  TCalcStateEh = (csFirstEh, csValidEh, csErrorEh);

{ TCalculatorEh }

  TCalculatorEh = class(TCustomControlEh)
    Panel1: TPanel;
    SpeedButton1: TSpeedButtonEh;
    SpeedButton2: TSpeedButtonEh;
    SpeedButton3: TSpeedButtonEh;
    SpeedButton4: TSpeedButtonEh;
    SpeedButton5: TSpeedButtonEh;
    SpeedButton6: TSpeedButtonEh;
    SpeedButton7: TSpeedButtonEh;
    SpeedButton8: TSpeedButtonEh;
    SpeedButton9: TSpeedButtonEh;
    SpeedButton10: TSpeedButtonEh;
    SpeedButton11: TSpeedButtonEh;
    SpeedButton12: TSpeedButtonEh;
    SpeedButton13: TSpeedButtonEh;
    SpeedButton14: TSpeedButtonEh;
    SpeedButton15: TSpeedButtonEh;
    SpeedButton16: TSpeedButtonEh;
    SpeedButton18: TSpeedButtonEh;
    SpeedButton19: TSpeedButtonEh;
    SpeedButton20: TSpeedButtonEh;
    SpeedButton22: TSpeedButtonEh;
    SpeedButton23: TSpeedButtonEh;
    SpeedButton24: TSpeedButtonEh;
    spEqual: TSpeedButtonEh;
    TextBox: TLabel;
    procedure SpeedButtonClick(Sender: TObject);
  private
    FBorderStyle: TBorderStyle;
    FClientHeight: Integer;
    FClientWidth: Integer;
    FFlat: Boolean;
    FOnProcessKey: TKeyPressEvent;
    FOperand: Extended;
    FOperator: Char;
    FPixelsPerInch: Integer;
    FStatus: TCalcStateEh;
    FTextHeight: Integer;

    function GetDisplayText: String;
    function GetDisplayValue: Extended;
    function GetPixelsPerInch: Integer; {$IFDEF EH_LIB_28} reintroduce; {$ENDIF}

    procedure CheckFirst;
    procedure Clear;
    procedure Error;
    procedure ReadTextHeight(Reader: TReader);
    {$IFDEF FPC}
    procedure SetBorderStyle(const Value: TBorderStyle); reintroduce;
    {$ELSE}
    procedure SetBorderStyle(const Value: TBorderStyle);
    {$ENDIF}
    procedure SetClientHeight(Value: Integer);
    procedure SetClientWidth(Value: Integer);
    procedure SetDisplayText(const Value: String);
    procedure SetDisplayValue(const Value: Extended);
    procedure SetFlat(AValue: Boolean);
    procedure SetOldCreateOrder(const Value: Boolean);
    procedure SetPixelsPerInch(const Value: Integer); {$IFDEF EH_LIB_28} reintroduce; {$ENDIF}
    procedure UpdateEqualButton;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure SetTextHeight(const Value: Integer);

  protected
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetBorderSize: Integer; virtual;
    function GetTextHeight: Integer;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ReadState(Reader: TReader); override;

  public
    constructor Create(AOwner: TComponent); override;

    procedure DoCopy;
    procedure Paste;
    procedure ProcessKey(Key: Char); virtual;
    procedure DefaultProcessKey(Key: Char); virtual;
    {$IFDEF FPC}
    function Ctl3D: Boolean;
    {$ELSE}
    {$ENDIF}
    property DisplayText: String read GetDisplayText write SetDisplayText;
    property DisplayValue: Extended read GetDisplayValue write SetDisplayValue;
    property TextHeight: Integer read FTextHeight write SetTextHeight;
  published
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property ClientHeight write SetClientHeight;
    property ClientWidth write SetClientWidth;
    property Color;
    property Font;
    property OldCreateOrder: Boolean write SetOldCreateOrder;
    property PixelsPerInch: Integer read GetPixelsPerInch write SetPixelsPerInch stored False;
    property Flat: Boolean read FFlat write SetFlat default True;
    property Status: TCalcStateEh read FStatus;

    property OnProcessKey: TKeyPressEvent read FOnProcessKey write FOnProcessKey;
  end;

{ IPopupCalculatorEh }

  IPopupCalculatorEh = interface
    ['{697F81AD-0E0F-4A4A-A016-A713620660DE}']
    function GetEnterCanClose: Boolean;
    function GetFlat: Boolean;
    function GetValue: Variant;
    function WantFocus: Boolean;

    procedure SetFlat(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetTextHeight(const Value: Variant);

    procedure Show(Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
    procedure Hide;

    property Value: Variant read GetValue write SetValue;
    property Flat: Boolean read GetFlat write SetFlat;
    property EnterCanClose: Boolean read GetEnterCanClose;
  end;

{ TPopupCalculatorEh }

  TPopupCalculatorEh = class(TCalculatorEh, IPopupCalculatorEh, IUnknown)
  private
    FBorderWidth: Integer;
    FFlat: Boolean;
    procedure CMCloseUpEh(var Message: TMessage); message CM_CLOSEUPEH;
    {$IFDEF FPC}
    {$ELSE}
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    {$ENDIF}

    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    {$IFDEF FPC_CROSSP}
    {$ELSE}
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    {$ENDIF}

  protected
    {IPopupCalculatorEh}
    function GetEnterCanClose: Boolean;
    function GetFlat: Boolean;
    function GetValue: Variant;

    procedure SetFlat(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetTextHeight(const Value: Variant);

  protected
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function WantFocus: Boolean;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawBorder; virtual;
    procedure UpdateBorderWidth;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

  public
    constructor Create(AOwner: TComponent); override;
    function CanFocus: Boolean; override;
    procedure ProcessKey(Key: Char); override;

    procedure Show(Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh); reintroduce;
    procedure Hide; reintroduce;

    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
    property Flat: Boolean read GetFlat write SetFlat default True;
  end;

{ TPopupCalculatorFormEh }

  TPopupCalculatorFormEh = class(TCustomDropDownFormEh, IPopupCalculatorEh)
  private
    FCloseCallback: TCloseWinCallbackProcEh;

    function GetEnterCanClose: Boolean;
    function GetFlat: Boolean;
    function GetValue: Variant;

    procedure SetFlat(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetTextHeight(const Value: Variant);

    procedure DropDownFormCallbackProc(DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh; SysParams: TDropDownFormSysParams);

  protected
    Calculator: TCalculatorEh;
    CurFontHeight: Integer;

    function WantFocus: Boolean;

    procedure AlignControls(AControl: TControl; var RemainingClientRect: TRect); override;
    procedure CreateWnd; override;
    procedure DrawBorder(BorderRect: TRect); override;
    procedure InitializeNewForm; override;
    procedure ProcessCalcKey(Sender: TObject; var Key: char);

  public
    constructor Create(AOwner: TComponent); override;

    procedure Show(Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh); reintroduce;
    procedure UpdateSize; override;

    property Value: Variant read GetValue write SetValue;
    property Flat: Boolean read GetFlat write SetFlat;
    property EnterCanClose: Boolean read GetEnterCanClose;

    property OnCloseCallback: TCloseWinCallbackProcEh read FCloseCallback write FCloseCallback;
  end;


procedure Register;

implementation

uses Themes, DBCtrls, EhLibLangConsts;

procedure Register;
begin
  Classes.RegisterClass(TSpeedButtonEh);
end;

{$R *.dfm}

const
  TagToCharArray: array[0..23] of Char =
    (#0,
     '7','8','9','/','S','C',
     '4','5','6','*','%','A',
     '1','2','3','-','R',#8,
     '0','I','.','+','='    );

{ TPopupCalculator }

constructor TCalculatorEh.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);

  FPixelsPerInch := Screen.PixelsPerInch;
  InitInheritedComponent(Self, TCustomControl);

  {$IFDEF FPC}
    {$IFDEF FPC_LINUX}
  FTextHeight := 17;
    {$ENDIF}
  ParentFont := True;
  {$ELSE}
  Panel1.ParentBackground := False;
   {$IFDEF EH_LIB_17}
  Panel1.StyleElements := [];
   {$ENDIF}
  {$ENDIF}

  for i := 0 to ComponentCount-1 do
    if Components[i] is TSpeedButtonEh then
    begin
      {$IFDEF FPC}
      TSpeedButtonEh(Components[i]).ParentFont := True;
      {$ELSE}
      {$ENDIF}
      TSpeedButtonEh(Components[i]).Font.Color := clBlue;
    end;

  SpeedButton24.Font.Color := clRed;
  SpeedButton13.Font.Color := clRed;
  SpeedButton14.Font.Color := clRed;
  SpeedButton15.Font.Color := clRed;
  SpeedButton16.Font.Color := clRed;
  spEqual.Font.Color := clRed;
  SpeedButton22.Font.Color := clRed;
  SpeedButton23.Font.Color := clRed;
end;

procedure TCalculatorEh.SetClientHeight(Value: Integer);
begin
  Height := Value;
end;

procedure TCalculatorEh.SetClientWidth(Value: Integer);
begin
  Width := Value;
end;

function TCalculatorEh.GetPixelsPerInch: Integer;
begin
  Result := FPixelsPerInch;
  if Result = 0 then Result := Screen.PixelsPerInch;
end;

procedure TCalculatorEh.SetPixelsPerInch(const Value: Integer);
begin
  if (Value <> GetPixelsPerInch) and ((Value = 0) or (Value >= 36))
    and (not (csLoading in ComponentState) or (FPixelsPerInch <> 0)) then
    FPixelsPerInch := Value;
end;

procedure TCalculatorEh.SetTextHeight(const Value: Integer);
begin
  if (FTextHeight <> Value) then
  begin
    ChangeScale(Value, FTextHeight);
    FTextHeight := Value;
  end;
end;

procedure TCalculatorEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('PixelsPerInch', nil, nil, not IsControl);
  Filer.DefineProperty('TextHeight', ReadTextHeight, nil, not IsControl);
end;

procedure TCalculatorEh.ReadTextHeight(Reader: TReader);
begin
  FTextHeight := Reader.ReadInteger;
end;

procedure TCalculatorEh.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

function TCalculatorEh.GetTextHeight: Integer;
var
  RestoreCanvas: Boolean;
begin
  RestoreCanvas := not HandleAllocated;
  if RestoreCanvas then
    Canvas.Handle := GetDC(0);
  try
    Canvas.Font := Self.Font;
    Result := Canvas.TextHeight('0');
  finally
    if RestoreCanvas then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
end;


procedure TCalculatorEh.ProcessKey(Key: Char);
begin
  Key := UpCase(Key);
  if (Assigned(OnProcessKey)) then
    OnProcessKey(Self, Key);
  if (Key <> #0) then
    DefaultProcessKey(Key);
end;

procedure TCalculatorEh.DefaultProcessKey(Key: Char);
var
  R: Extended;
begin
  if (FStatus = csErrorEh) and (Key <> 'C') then
    Key := #0;
  if (Key = FormatSettings.DecimalSeparator) or CharInSetEh(Key, [ '.', ',']) then
  begin
    CheckFirst;
    if Pos(FormatSettings.DecimalSeparator, DisplayText) = 0 then
      DisplayText := DisplayText + FormatSettings.DecimalSeparator;
    Exit;
  end;
  case Key of
    'R': 
      if FStatus in [csValidEh, csFirstEh] then
      begin
        FStatus := csFirstEh;
        if DisplayValue = 0
          then Error
          else DisplayValue := 1.0 / DisplayValue;
      end;
    'S': 
      if FStatus in [csValidEh, csFirstEh] then
      begin
        FStatus := csFirstEh;
        if DisplayValue < 0
          then Error
          else DisplayValue := Sqrt(DisplayValue);
      end;
    '0'..'9':
      begin
        CheckFirst;
        if DisplayText = '0' then
          DisplayText := '';
        if Pos('E', DisplayText) = 0 then
        begin
          if Length(DisplayText) < Max(2, DefCalcPrecision) + Ord(Boolean(Pos('-', DisplayText))) then
            DisplayText := DisplayText + Key;
        end;
      end;
    #8: 
      begin
        CheckFirst;
        if (Length(DisplayText) = 1) or ((Length(DisplayText) = 2) and (DisplayText[1] = '-')) then
          DisplayText := '0'
        else
          DisplayText := Copy(DisplayText, 1, Length(DisplayText) - 1);
      end;
    'I': 
      DisplayValue := - DisplayValue;
     #13, '%', '*', '+', '-', '/', '=':
      begin
        if FStatus = csValidEh then
        begin
          FStatus := csFirstEh;
          R := DisplayValue;
          if Key = '%' then
            case FOperator of
              '+', '-': R := FOperand * R / 100.0;
              '*', '/': R := R / 100.0;
            end;
          case FOperator of
            '+': DisplayValue := FOperand + R;
            '-': DisplayValue := FOperand - R;
            '*': DisplayValue := FOperand * R;
            '/': if R = 0
                    then Error
                    else DisplayValue := FOperand / R;
          end;
        end;
        FOperator := Key;
        FOperand := DisplayValue;
      end;
    #27, 'C': Clear;
    ^C: DoCopy;
    ^V: Paste;
  end;
  UpdateEqualButton;
end;

procedure TCalculatorEh.CheckFirst;
begin
  if FStatus = csFirstEh then
  begin
    FStatus := csValidEh;
    DisplayText := '0';
  end;
end;

procedure TCalculatorEh.Clear;
begin
  FStatus := csFirstEh;
  DisplayValue := 0.0;
  FOperator := '=';
  FOperand := 0.0;
  UpdateEqualButton;
end;

procedure TCalculatorEh.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  if UseRightToLeftAlignment
    then TextBox.Alignment := taLeftJustify
    else TextBox.Alignment := taRightJustify;
end;

procedure TCalculatorEh.DoCopy;
begin
  Clipboard.AsText := DisplayText;
end;

procedure TCalculatorEh.Error;
begin
  FStatus := csErrorEh;
  DisplayText := EhLibLanguageConsts.CalculatorError;
end;

function TCalculatorEh.GetDisplayValue: Extended;
begin
  if FStatus = csErrorEh
    then Result := 0.0
    else Result := StrToFloat(Trim(DisplayText));
end;

procedure TCalculatorEh.Paste;
begin
  if Clipboard.HasFormat(CF_TEXT) then
    DisplayValue := StrToFloat(Trim(Clipboard.AsText));
end;

function TCalculatorEh.GetDisplayText: String;
begin
  Result := TextBox.Caption;
end;

procedure TCalculatorEh.SetDisplayText(const Value: String);
begin
  TextBox.Caption := Value;
end;

procedure TCalculatorEh.SetDisplayValue(const Value: Extended);
begin
  DisplayText := FloatToStrF(Value, ffGeneral, Max(2, DefCalcPrecision), 0);
end;

procedure TCalculatorEh.SetFlat(AValue: Boolean);
begin
  if FFlat = AValue then Exit;
  FFlat := AValue;
end;

procedure TCalculatorEh.SpeedButtonClick(Sender: TObject);
begin
  ProcessKey(TagToCharArray[NativeInt(TSpeedButton(Sender).Tag)]);
end;

procedure TCalculatorEh.UpdateEqualButton;
begin
  if (FOperand <> 0.0) and (FStatus = csValidEh) and CharInSetEh(FOperator, ['+', '-', '*', '/'])
    then spEqual.Caption := '='
    else spEqual.Caption := 'Ok';
end;

procedure TCalculatorEh.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWndHandle;
  end;
end;

procedure TCalculatorEh.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or BorderStyles[FBorderStyle];
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
  begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

procedure TCalculatorEh.CreateWnd;
begin
  inherited CreateWnd;
  Color := CheckSysColor(clBtnFace);
  Panel1.Color := CheckSysColor(clWindow);
  TextBox.Color := CheckSysColor(clWindow);
  TextBox.Font.Color := CheckSysColor(clWindowText);
{$IFDEF EH_LIB_17}
  TextBox.StyleElements := [];
{$ENDIF}
end;

function TCalculatorEh.GetBorderSize: Integer;
{$IFDEF FPC_CROSSP}
begin
  Result := 4;
end;
{$ELSE}
var
  Params: TCreateParams;
  R: TRect;
begin
  CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top;
end;
{$ENDIF} 

procedure TCalculatorEh.SetOldCreateOrder(const Value: Boolean);
begin
  
end;

procedure TCalculatorEh.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  ProcessKey(Key);
end;

procedure TCalculatorEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_DELETE then
    ProcessKey('C');
end;

function TCalculatorEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  NewWidth := FClientWidth + GetBorderSize;
  NewHeight := FClientHeight + GetBorderSize;
end;

function TCalculatorEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    if FStatus <> csErrorEh then
      DisplayValue := DisplayValue - 1;
    Result := True;
  end;
end;

function TCalculatorEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    if FStatus <> csErrorEh then
      DisplayValue := DisplayValue + 1;
    Result := True;
  end;
end;

{$IFDEF FPC}
function TCalculatorEh.Ctl3D: Boolean;
begin
  Result := True;
end;
{$ELSE}
{$ENDIF}

{ TPopupCalculatorEh }

constructor TPopupCalculatorEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; 
  {$IFDEF FPC}
  {$ELSE}
  Ctl3D := True;
  ParentCtl3D := False;
  Panel1.ParentBackground := False;
   {$IFDEF EH_LIB_17}
  Panel1.StyleElements := [];
   {$ENDIF}
  {$ENDIF}
  TabStop := False;
  FFlat := True;
  {$IFDEF FPC}
  BorderStyle := bsSingle;
  {$ENDIF}

  Visible := False;
{$IFDEF FPC_CROSSP}
{$ELSE}
  ParentWindow := GetDesktopWindow;
{$ENDIF}
  if (AOwner is TWinControl) and TWinControl(AOwner).HandleAllocated then
    HandleNeeded;
end;

{CM messages processing}

procedure TPopupCalculatorEh.CMCloseUpEh(var Message: TMessage);
var
  ComboEdit: IComboEditEh;
begin
  if Supports(Owner, IComboEditEh, ComboEdit) then
    ComboEdit.CloseUp(False);
end;

{$IFDEF FPC}
{$ELSE}
procedure TPopupCalculatorEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWndHandle;
end;
{$ENDIF}

procedure TPopupCalculatorEh.CMWantSpecialKey( var Message: TCMWantSpecialKey);
var
  ComboEdit: IComboEditEh;
begin
  if not Supports(Owner, IComboEditEh, ComboEdit) then
    Exit;
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) then
  begin
    ComboEdit.CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

{WM messages processing}
procedure TPopupCalculatorEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
end;

procedure TPopupCalculatorEh.WMNCCalcSize(var Message: TWMNCCalcSize);
{$IFDEF CIL}
var
  r: TNCCalcSizeParams;
begin
  inherited;
  r := Message.CalcSize_Params;
  InflateRect(r.rgrc0, -FBorderWidth, -FBorderWidth);
  Message.CalcSize_Params := r;
end;
{$ELSE}
begin
  inherited;
  InflateRect(Message.CalcSize_Params^.rgrc[0], -FBorderWidth, -FBorderWidth);
end;
{$ENDIF}

{$IFDEF FPC_CROSSP}
{$ELSE}
procedure TPopupCalculatorEh.WMMouseActivate(var Message: TWMMouseActivate);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TPopupCalculatorEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;
{$ENDIF}

procedure TPopupCalculatorEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if not Ctl3D then
    Params.Style := Params.Style or WS_BORDER;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;

  {$IFDEF FPC_CROSSP}
  Params.Style := Params.Style and not WS_CHILD or WS_POPUP;
  {$ELSE}
  Params.WindowClass.Style := CS_SAVEBITS;
  if CheckWin32Version(5, 1) then
    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
  {$ENDIF}
end;

procedure TPopupCalculatorEh.DrawBorder;
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  DC: HDC;
  R: TRect;
begin
  if Ctl3D = True then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      FrameRect(DC, R, GetSysColorBrush(COLOR_3DDKSHADOW));
      InflateRect(R, -1, -1);
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;
{$ENDIF}

procedure TPopupCalculatorEh.UpdateBorderWidth;
begin
  if Ctl3D
    then FBorderWidth := 2
    else FBorderWidth := 0;
end;

function TPopupCalculatorEh.CanFocus: Boolean;
begin
  Result := False;
end;

function TPopupCalculatorEh.GetValue: Variant;
begin
  if FStatus = csErrorEh then
  begin
{$IFDEF CIL}
    Result := VarFromException(EDivByZero.Create);
{$ELSE}
    TVarData(Result).VType := varError;
    TVarData(Result).VInteger := -1;
{$ENDIF}
  end else
    Result := DisplayValue;
end;

procedure TPopupCalculatorEh.SetValue(const Value: Variant);
begin
  Clear;
  DisplayValue := Value;
end;

procedure TPopupCalculatorEh.ProcessKey(Key: Char);
var
  ComboEdit: IComboEditEh;
begin
  if CharInSetEh(Key, ['=', #13]) and (spEqual.Caption = 'Ok') then
  begin
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(True)
  end else
    inherited ProcessKey(Key);
end;

procedure TPopupCalculatorEh.Show(Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

procedure TPopupCalculatorEh.Hide;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

procedure TPopupCalculatorEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  ComboEdit: IComboEditEh;
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_ESCAPE then
  begin
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(False);
    Key := 0;
  end;
end;

function TPopupCalculatorEh.GetFlat: Boolean;
begin
  Result := FFlat;
end;

procedure TPopupCalculatorEh.SetFlat(const Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
  end;
end;

procedure TPopupCalculatorEh.SetTextHeight(const Value: Variant);
var
  CurFontHeight: Integer;
begin
  CurFontHeight := GetFontHeight(Font);
  ChangeScale(Value, CurFontHeight);
end;

function TPopupCalculatorEh.GetEnterCanClose: Boolean;
begin
  Result := (spEqual.Caption = 'Ok');
end;

function TPopupCalculatorEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  if Result then
  begin
    Inc(NewWidth, FBorderWidth*2);
    Inc(NewHeight, FBorderWidth*2);
  end;
end;

function TPopupCalculatorEh.WantFocus: Boolean;
begin
  Result := False;
end;

{ TPopupCalculatorFormEh }

constructor TPopupCalculatorFormEh.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
end;

procedure TPopupCalculatorFormEh.InitializeNewForm;
begin
  inherited InitializeNewForm;

  FormElements := [];
  BorderWidth := 2;
  KeyPreview := True;
  FormStyle := fsStayOnTop;

  Calculator := TCalculatorEh.Create(Self);
  Calculator.Left := 0;
  Calculator.Top := 0;
  Calculator.Parent := Self;
  Calculator.DisplayValue := 0;
  Calculator.OnProcessKey := ProcessCalcKey;

  ActiveControl := Calculator;
  CurFontHeight := GetFontHeight(Font);
end;

procedure TPopupCalculatorFormEh.ProcessCalcKey(Sender: TObject; var Key: char);
begin
  if CharInSetEh(Key, ['=', #13]) and (EnterCanClose) then
  begin
    ModalResult := mrOk;
    Close;
  end else if (Key = #27) then
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

function TPopupCalculatorFormEh.GetEnterCanClose: Boolean;
begin
  Result := (Calculator.spEqual.Caption = 'Ok');;
end;

function TPopupCalculatorFormEh.GetFlat: Boolean;
begin
  Result := Calculator.Flat
end;

procedure TPopupCalculatorFormEh.SetFlat(const Value: Boolean);
begin
  Calculator.Flat := Value;
end;

procedure TPopupCalculatorFormEh.SetTextHeight(const Value: Variant);
begin
  if Value <> Calculator.TextHeight then
  begin
    Calculator.TextHeight := Value;
    UpdateSize;
  end;
end;

function TPopupCalculatorFormEh.GetValue: Variant;
begin
  if Calculator.Status = csErrorEh then
  begin
{$IFDEF CIL}
    Result := VarFromException(EDivByZero.Create);
{$ELSE}
    TVarData(Result).VType := varError;
    TVarData(Result).VInteger := -1;
{$ENDIF}
  end else
    Result := Calculator.DisplayValue;
end;

procedure TPopupCalculatorFormEh.SetValue(const Value: Variant);
begin
  Calculator.Clear;
  Calculator.DisplayValue := Value;
end;

procedure TPopupCalculatorFormEh.AlignControls(AControl: TControl;
  var RemainingClientRect: TRect);
begin
  inherited AlignControls(AControl, RemainingClientRect);
  UpdateSize;
end;

procedure TPopupCalculatorFormEh.CreateWnd;
begin
  inherited CreateWnd;
end;

procedure TPopupCalculatorFormEh.DrawBorder(BorderRect: TRect);
var
  R: TRect;
{$IFDEF EH_LIB_16}
  Details: TThemedElementDetails;
{$ENDIF}
begin
  R := ClientRect;
  OffsetRect(R, -R.Left, -R.Top);
  Canvas.Pen.Color := CheckSysColor(COLOR_3DDKSHADOW);
  Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 0, 0);

  InflateRect(R, -1, -1);
{$IFDEF EH_LIB_16}
  if CustomStyleActive then
  begin
    Details := StyleServices.GetElementDetails(twWindowRoot);
    StyleServices.DrawEdge(Canvas.Handle, Details, R, [eeRaisedInner], [efRect]);
  end else
{$ENDIF}
    DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
end;

procedure TPopupCalculatorFormEh.UpdateSize;
begin
  inherited UpdateSize;
  Calculator.HandleNeeded;
  Width := Calculator.Width + BorderWidth * 2;
  Height := Calculator.Height + BorderWidth * 2;
  Calculator.Top := BorderWidth;
  Calculator.Left := BorderWidth;
end;

procedure TPopupCalculatorFormEh.Show(Pos: TPoint; CloseCallback: TCloseWinCallbackProcEh);
var
  ForRect: TRect;
  DDParams: TDynVarsEh;
  SysParams: TEditControlDropDownFormSysParams;
begin
  FCloseCallback := CloseCallback;

  DDParams := TDynVarsEh.Create(Self);
  SysParams := TEditControlDropDownFormSysParams.Create;

  ForRect.TopLeft := Pos;
  ForRect.BottomRight := ForRect.TopLeft;

  ExecuteNomodal(ForRect, nil, daLeft, DDParams, SysParams, DropDownFormCallbackProc);
end;

procedure TPopupCalculatorFormEh.DropDownFormCallbackProc(
  DropDownForm: TCustomForm; Accept: Boolean; DynParams: TDynVarsEh;
  SysParams: TDropDownFormSysParams);
begin
  DynParams.Free;
  SysParams.Free;

  FCloseCallback(Self, Accept);
end;

function TPopupCalculatorFormEh.WantFocus: Boolean;
begin
  Result := True;
end;

end.
