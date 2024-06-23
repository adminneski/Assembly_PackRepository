
{******************************************}
{                                          }
{             FastReport VCL               }
{        GUI Thread Synchonization         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frThreading;

interface

{$I frVer.inc}
uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
{$IFDEF FPC}
  LResources, LCLType, LMessages,
{$ENDIF}
  SysUtils, Classes;

{$IFNDEF FPC}
const
  WM_FRX_SYNC_THREAD = WM_USER + 250;
  WM_FRX_SYNC_MESSAGE = WM_USER + 251;

type
  { TfrThreadSynchronizer }

  TfrThreadSynchronizer = class
  private
    FIsMain: Boolean;
    FWindowHandle: HWND;
    procedure WndProc(var Message: TMessage);
  public
    constructor Create;
    destructor Destroy; override;
    property WindowHandle: HWND read FWindowHandle;
  end;

  { TfrGuiThread }

  TfrGuiThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  function frGetThreadSynchronizer: TfrThreadSynchronizer;
  function frIsThreadSynchronizerActive: Boolean;
  function frSynchSendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
{$ENDIF}
procedure frThreadSynchronize(Method: TThreadMethod);

var
{$IFNDEF FPC}
  frDisableThreadSynchronizer: Boolean;
{$ENDIF}
  frGUIThreadID: Cardinal;

implementation
{$IFNDEF FPC}
uses
  Forms,
  frCore;

var
  FThreadSynchronizer: TfrThreadSynchronizer;
  FGuiThread: TfrGuiThread;
  FThreadRunEvent: TfrHandle;

type
  PTThreadMethod = ^TThreadMethod;


procedure InitSynchronizer;
begin
  if Assigned(FThreadSynchronizer) and (not FThreadSynchronizer.FIsMain) or
    (Application.Handle <> 0) or not IsLibrary then Exit;

  if (Application.Handle = 0) and (frGUIThreadID <> GetCurrentThreadID) then
  begin
    FreeAndNil(FThreadSynchronizer);
    FGuiThread := TfrGuiThread.Create;
    FThreadRunEvent := CreateEvent(nil, true, false, 'FRX_GUI_THREAD_R');
    FGuiThread.Resume;
    WaitForSingleObject(FThreadRunEvent, 100000);
    CloseHandle(FThreadRunEvent);
  end;
end;

{ TfrThreadSynchronizer }

{$WARNINGS OFF}
constructor TfrThreadSynchronizer.Create;
begin
  FWindowHandle := AllocateHWnd(WndProc);
end;

destructor TfrThreadSynchronizer.Destroy;
begin
  DeallocateHWnd(FWindowHandle);
end;
{$WARNINGS ON}
procedure TfrThreadSynchronizer.WndProc(var Message: TMessage);
var
  lMessage: PMessage;
begin
  if Message.Msg = WM_FRX_SYNC_THREAD then
  begin
    if Message.WParam <> 0 then
      PTThreadMethod(Message.WParam)^();
  end
  else if Message.Msg = WM_FRX_SYNC_MESSAGE then
  begin
    lMessage :=  PMessage(Message.WParam);
    lMessage^.Result := SendMessage(Message.LParam, lMessage^.Msg, lMessage^.WParam, lMessage^.LParam);
  end

  else
    Message.Result := DefWindowProc(FWindowHandle, Message.Msg, Message.wParam, Message.lParam);
end;

function frGetThreadSynchronizer: TfrThreadSynchronizer;
begin
  Result := FThreadSynchronizer;
end;

function frIsThreadSynchronizerActive: Boolean;
begin
  Result := Assigned(FThreadSynchronizer);
end;

function frSynchSendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  lMessage: TMessage;
begin
  lMessage.Msg := Msg;
  lMessage.WParam := wParam;
  lMessage.LParam := lParam;
  lMessage.Result := 0;
  Result := 0;
  if Assigned(FThreadSynchronizer) then
    Result := SendMessage(FThreadSynchronizer.WindowHandle, WM_FRX_SYNC_MESSAGE, NativeInt(@lMessage), NativeInt(hWnd));
end;

procedure frThreadSynchronize(Method: TThreadMethod);
begin
  if frDisableThreadSynchronizer and Assigned(Method) then
  begin
    Method;
    Exit;
  end;
  InitSynchronizer;
  if not Assigned(Method) then Exit;

  if Assigned(FThreadSynchronizer) and (FThreadSynchronizer.WindowHandle <> 0) then
    SendMessage(FThreadSynchronizer.WindowHandle, WM_FRX_SYNC_THREAD, NativeInt(@TMethod(Method)), 0)
  else if (Application.Handle = 0) or (frGUIThreadID = GetCurrentThreadID) then
    Method
  else
    TThread.Synchronize(nil, Method);
end;

{ TTestThread }

constructor TfrGuiThread.Create;
begin
  inherited Create(True);
end;

destructor TfrGuiThread.Destroy;
begin
  Terminate;
  if Assigned(FThreadSynchronizer) then
    SendMessage(FThreadSynchronizer.FWindowHandle, WM_QUIT, 0, 0);
  inherited;
end;

procedure TfrGuiThread.Execute;
var
  Msg: TMsg;
  ThSynch: TfrThreadSynchronizer;
  IsUnicode, IsMsgExists: Boolean;
begin
  ThSynch := TfrThreadSynchronizer.Create;
{$IFDEF DELPHI16}
  InterlockedExchangePointer(Pointer(FThreadSynchronizer), ThSynch);
{$ELSE}
  InterlockedExchange(frInteger(FThreadSynchronizer), frInteger(ThSynch));
{$ENDIF}

{$IFDEF MSWINDOWS}
  InterlockedExchange(Integer(frGUIThreadID), GetCurrentThreadID);
{$ENDIF}
{$IFDEF POSIX}
  InterlockedExchange64(Int64(frxGUIThreadID), GetCurrentThreadID);
{$ENDIF}

  SetEvent(FThreadRunEvent);
  while not Terminated and (ThSynch.FWindowHandle <> 0) do
  begin
    if PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE)  then
    begin
      IsUnicode := (Msg.hwnd = 0) or IsWindowUnicode(Msg.hwnd);
      if IsUnicode then
        IsMsgExists := PeekMessageW(Msg, 0, 0, 0, PM_REMOVE)
      else
        IsMsgExists := PeekMessageA(Msg, 0, 0, 0, PM_REMOVE);

      if IsMsgExists then
      begin
        if Msg.Message = WM_QUIT then
          Break
        else
        begin
          TranslateMessage(Msg);
          if IsUnicode then
            DispatchMessageW(Msg)
          else
            DispatchMessageA(Msg);
        end;
      end
    end
    else if not Terminated then
      WaitMessage;
  end;

{$IFDEF DELPHI16}
  InterlockedExchangePointer(Pointer(FThreadSynchronizer), nil);
{$ELSE}
  InterlockedExchange(frInteger(FThreadSynchronizer), 0);
{$ENDIF}
  FreeAndNil(ThSynch);
end;

initialization
  frGUIThreadID := MainThreadID;
  frDisableThreadSynchronizer := False;
  if IsLibrary then
  begin
    FThreadSynchronizer := TfrThreadSynchronizer.Create;
    FThreadSynchronizer.FIsMain := True;
  end;
  FGuiThread := nil;

finalization
  FreeAndNil(FGuiThread);
  FreeAndNil(FThreadSynchronizer);
{$ELSE}
 procedure frThreadSynchronize(Method: TThreadMethod); inline;
 begin
   Method;
 end;
{$ENDIF}
end.
