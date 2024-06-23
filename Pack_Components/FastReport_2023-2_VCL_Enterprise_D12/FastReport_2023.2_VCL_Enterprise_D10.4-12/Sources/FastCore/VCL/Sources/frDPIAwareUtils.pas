{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frDPIAwareUtils;

interface

{$I frVer.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  SysUtils,
{$IFDEF FPC}
  Types, LazarusPackageIntf,
{$ENDIF}
  Classes, Graphics, Controls,
  frTypes;

const
  FR_DefaultPPI = 96;
  FRX_WM_DPICHANGED = $02E0;
  FRX_WM_DPICHANGED_AFTERPARENT = $02E3;

type
  DPI_AWARENESS_CONTEXT_ = record
    unused_: Integer;
  end;

  FRX_DPI_AWARENESS_CONTEXT = ^DPI_AWARENESS_CONTEXT_;
{$IFNDEF FPC}
  TfrxGetDpiForWindow = function(hwnd: HWND): UINT; stdcall;
  TfrxSetProcessDpiAwarenessContext = function(value: FRX_DPI_AWARENESS_CONTEXT): BOOL; stdcall;
  TfrxSetThreadDpiAwarenessContext = function(value: FRX_DPI_AWARENESS_CONTEXT): BOOL; stdcall;
  TfrxGetThreadDpiAwarenessContext = function(): FRX_DPI_AWARENESS_CONTEXT; stdcall;
{$ENDIF}

const
  FRX_DPI_AWARENESS_CONTEXT_UNAWARE: FRX_DPI_AWARENESS_CONTEXT = FRX_DPI_AWARENESS_CONTEXT(-1);
  FRX_DPI_AWARENESS_CONTEXT_SYSTEM_AWARE: FRX_DPI_AWARENESS_CONTEXT = FRX_DPI_AWARENESS_CONTEXT(-2);
  FRX_DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE: FRX_DPI_AWARENESS_CONTEXT = FRX_DPI_AWARENESS_CONTEXT(-3);
  FRX_DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2: FRX_DPI_AWARENESS_CONTEXT = FRX_DPI_AWARENESS_CONTEXT(-4);
  FRX_DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED: FRX_DPI_AWARENESS_CONTEXT = FRX_DPI_AWARENESS_CONTEXT(-5);

function frxGetDpiForWindow(aHwnd: NativeInt): UINT;
function frxSetProcessDpiAwarenessContext(value: FRX_DPI_AWARENESS_CONTEXT): LongBool;
function frxSetThreadDpiAwarenessContext(value: FRX_DPI_AWARENESS_CONTEXT): LongBool;
function frxGetThreadDpiAwarenessContext: FRX_DPI_AWARENESS_CONTEXT;

function frGetSystemDPI: Integer;

function frApplyPPI(AValue: Integer; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): Integer; overload;
function frApplyPPI(AValue: TSize; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TSize; overload;
function frApplyPPI(AValue: TPoint; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TPoint; overload;
function frApplyPPI(AValue: TRect; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TRect; overload;

function frRevertPPI(AValue: Integer; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): Integer; overload;
function frRevertPPI(AValue: TSize; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TSize; overload;
function frRevertPPI(AValue: TPoint; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TPoint; overload;
function frRevertPPI(AValue: TRect; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TRect; overload;

function frApplyPPIBySystemDPI(AValue: Integer; ANewPPI: Integer): Integer; overload;
function frApplyPPIBySystemDPI(AValue: TSize; ANewPPI: Integer): TSize; overload;
function frApplyPPIBySystemDPI(AValue: TPoint; ANewPPI: Integer): TPoint; overload;
function frApplyPPIBySystemDPI(AValue: TRect; ANewPPI: Integer): TRect; overload;

function frRevertPPIBySystemDPI(AValue: Integer; ANewPPI: Integer): Integer; overload;
function frRevertPPIBySystemDPI(AValue: TSize; ANewPPI: Integer): TSize; overload;
function frRevertPPIBySystemDPI(AValue: TPoint; ANewPPI: Integer): TPoint; overload;
function frRevertPPIBySystemDPI(AValue: TRect; ANewPPI: Integer): TRect; overload;

function frCreateFontForDefaultDPI: TFont; overload;
function frCreateFontForDefaultDPI(ASize: Integer): TFont; overload;
function frGetFontHeight(AFontSize: Integer; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): Integer;
function frGetFontHeightForDefaultDPI(AFontSize: Integer; ADesignDPI: Integer = FR_DefaultPPI): Integer;
procedure frScaleFont(AFont: TFont; M, D: Integer);

implementation

uses
{$IFDEF FPC}
  LCLType, LCLIntf,
{$ENDIF}
  frCore, frUtils,
  Forms;

{$IFNDEF FPC}
var
  FLibHandle: TfrHandle;
  FGetDpiForWindow: TfrxGetDpiForWindow;
  FSetProcessDpiAwarenessContext: TfrxSetProcessDpiAwarenessContext;
  FGetThreadDpiAwarenessContext: TfrxGetThreadDpiAwarenessContext;
  FSetThreadDpiAwarenessContext: TfrxSetThreadDpiAwarenessContext;
{$ENDIF}

function frxGetDpiForWindow(aHwnd: NativeInt): UINT;
begin
{$IFNDEF FPC}
  if Assigned(FGetDpiForWindow) then
    Result := FGetDpiForWindow(aHwnd)
  else
{$ENDIF}
    Result := Screen.PixelsPerInch;
end;

function frxSetProcessDpiAwarenessContext(value: FRX_DPI_AWARENESS_CONTEXT): LongBool;
begin
  Result := False;
{$IFNDEF FPC}
  if Assigned(FSetProcessDpiAwarenessContext) then
    Result := FSetProcessDpiAwarenessContext(value);
{$ENDIF}
end;


function frxSetThreadDpiAwarenessContext(value: FRX_DPI_AWARENESS_CONTEXT): LongBool;
begin
  Result := False;
{$IFNDEF FPC}
  if Assigned(FSetThreadDpiAwarenessContext) then
    Result := FSetThreadDpiAwarenessContext(value);
{$ENDIF}
end;

function frxGetThreadDpiAwarenessContext: FRX_DPI_AWARENESS_CONTEXT;
begin
    Result := FRX_DPI_AWARENESS_CONTEXT_UNAWARE;
{$IFNDEF FPC}
  if Assigned(FGetThreadDpiAwarenessContext) then
    Result := FGetThreadDpiAwarenessContext();
{$ENDIF}
end;

function frGetSystemDPI: Integer;
var
  DC: Integer;
begin
  DC := GetDC(0);
  try
    Result := GetDeviceCaps(DC, LOGPIXELSY);
  finally
    ReleaseDC(0, DC);
  end;
end;

function frApplyPPI(AValue, ANewPPI, ACurrentPPI: Integer): Integer;
begin
  Result := frMulDiv(AValue, ANewPPI, ACurrentPPI);
end;

function frApplyPPI(AValue: TSize; ANewPPI, ACurrentPPI: Integer): TSize;
begin
  Result.cx := frMulDiv(AValue.cx, ANewPPI, ACurrentPPI);
  Result.cy := frMulDiv(AValue.cy, ANewPPI, ACurrentPPI);
end;

function frApplyPPI(AValue: TPoint; ANewPPI, ACurrentPPI: Integer): TPoint;
begin
  Result.X := frMulDiv(AValue.X, ANewPPI, ACurrentPPI);
  Result.Y := frMulDiv(AValue.Y, ANewPPI, ACurrentPPI);
end;

function frApplyPPI(AValue: TRect; ANewPPI, ACurrentPPI: Integer): TRect;
begin
  Result.Left := frMulDiv(AValue.Left, ANewPPI, ACurrentPPI);
  Result.Top := frMulDiv(AValue.Top, ANewPPI, ACurrentPPI);
  Result.Right := frMulDiv(AValue.Right, ANewPPI, ACurrentPPI);
  Result.Bottom := frMulDiv(AValue.Bottom, ANewPPI, ACurrentPPI);
end;

function frRevertPPI(AValue: Integer; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): Integer;
begin
  Result := frMulDiv(AValue, ACurrentPPI, ANewPPI);
end;

function frRevertPPI(AValue: TSize; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TSize;
begin
  Result.cx := frMulDiv(AValue.cx, ACurrentPPI, ANewPPI);
  Result.cy := frMulDiv(AValue.cy, ACurrentPPI, ANewPPI);
end;

function frRevertPPI(AValue: TPoint; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TPoint;
begin
  Result.X := frMulDiv(AValue.X, ACurrentPPI, ANewPPI);
  Result.Y := frMulDiv(AValue.Y, ACurrentPPI, ANewPPI);
end;

function frRevertPPI(AValue: TRect; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): TRect;
begin
  Result.Left := frMulDiv(AValue.Left, ACurrentPPI, ANewPPI);
  Result.Top := frMulDiv(AValue.Top, ACurrentPPI, ANewPPI);
  Result.Right := frMulDiv(AValue.Right, ACurrentPPI, ANewPPI);
  Result.Bottom := frMulDiv(AValue.Bottom, ACurrentPPI, ANewPPI);
end;

function frApplyPPIBySystemDPI(AValue: Integer; ANewPPI: Integer): Integer;
begin
  Result := frApplyPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frApplyPPIBySystemDPI(AValue: TSize; ANewPPI: Integer): TSize;
begin
  Result := frApplyPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frApplyPPIBySystemDPI(AValue: TPoint; ANewPPI: Integer): TPoint;
begin
  Result := frApplyPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frApplyPPIBySystemDPI(AValue: TRect; ANewPPI: Integer): TRect;
begin
  Result := frApplyPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frRevertPPIBySystemDPI(AValue: Integer; ANewPPI: Integer): Integer;
begin
  Result := frRevertPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frRevertPPIBySystemDPI(AValue: TSize; ANewPPI: Integer): TSize;
begin
  Result := frRevertPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frRevertPPIBySystemDPI(AValue: TPoint; ANewPPI: Integer): TPoint;
begin
  Result := frRevertPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frRevertPPIBySystemDPI(AValue: TRect; ANewPPI: Integer): TRect;
begin
  Result := frRevertPPI(AValue, ANewPPI, frGetSystemDPI);
end;

function frCreateFontForDefaultDPI: TFont;
begin
  Result := TFont.Create;
  Result.Height := frGetFontHeightForDefaultDPI(Result.Size);
end;

function frCreateFontForDefaultDPI(ASize: Integer): TFont;
begin
  Result := TFont.Create;
  Result.Height := frGetFontHeightForDefaultDPI(ASize);
end;

function frGetFontHeight(AFontSize: Integer; ANewPPI: Integer; ACurrentPPI: Integer = FR_DefaultPPI): Integer;
begin
  Result := frApplyPPI(frGetFontHeightForDefaultDPI(AFontSize), ANewPPI, ACurrentPPI);
end;

function frGetFontHeightForDefaultDPI(AFontSize: Integer; ADesignDPI: Integer = FR_DefaultPPI): Integer;
begin
  Result := -frMulDiv(AFontSize, ADesignDPI, 72);
end;

procedure frScaleFont(AFont: TFont; M, D: Integer);
begin
{$IFDEF DELPHI22}
  AFont.Height := frMulDiv(AFont.Height, M, D);
{$ELSE}
  AFont.Size := frMulDiv(AFont.Size, M, D);
{$ENDIF}
end;

{$IFNDEF FPC}
initialization
  FLibHandle := LoadLibrary('user32.dll');
  FGetDpiForWindow := nil;
  FSetProcessDpiAwarenessContext := nil;
  if FLibHandle <> 0 then
  begin
    FGetDpiForWindow := TfrxGetDpiForWindow(GetProcAddress(FLibHandle, 'GetDpiForWindow'));
    FSetProcessDpiAwarenessContext := TfrxSetProcessDpiAwarenessContext(GetProcAddress(FLibHandle, 'SetProcessDpiAwarenessContext'));
    FGetThreadDpiAwarenessContext := TfrxGetThreadDpiAwarenessContext(GetProcAddress(FLibHandle, 'GetThreadDpiAwarenessContext'));
    FSetThreadDpiAwarenessContext := TfrxSetThreadDpiAwarenessContext(GetProcAddress(FLibHandle, 'SetThreadDpiAwarenessContext'));
  end;

finalization
  FGetDpiForWindow := nil;
  FSetProcessDpiAwarenessContext := nil;
  FGetThreadDpiAwarenessContext := nil;
  FSetThreadDpiAwarenessContext := nil;
{$ENDIF}

end.
