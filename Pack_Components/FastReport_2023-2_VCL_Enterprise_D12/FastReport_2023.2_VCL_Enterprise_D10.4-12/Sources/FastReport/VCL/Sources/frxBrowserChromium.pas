{******************************************}
{                                          }
{             FastReport VCL               }
{           Module for using               }
{     TChromiumWindow as a browser         }
{              (CEF4Delphi)                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{                                          }
{******************************************}
unit frxBrowserChromium;

// ************************************************************************
// ***************************** CEF4Delphi *******************************
// ************************************************************************
//
// CEF4Delphi is based on DCEF3 which uses CEF to embed a chromium-based
// browser in Delphi applications.
//
// The original license of DCEF3 still applies to CEF4Delphi.
//
// For more information about CEF4Delphi visit :
//         https://www.briskbard.com/index.php?lang=en&pageid=cef
//
//        Copyright © 2021 Salvador Diaz Fau. All rights reserved.
//
// ************************************************************************
// ************ vvvv Original license and comments below vvvv *************
// ************************************************************************
(*
 *                       Delphi Chromium Embedded 3
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 * Web site   : http://www.progdigy.com
 * Repository : http://code.google.com/p/delphichromiumembedded/
 * Group      : http://groups.google.com/group/delphichromiumembedded
 *
 * Fast Reports, Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 *)
interface

{$I frx.inc}
{$I cef.inc}

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  {$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  frxBrowser, frTypes,
  uCEFChromium, uCEFWindowParent, uCEFChromiumWindow, uCEFTypes, uCEFInterfaces,
  uCEFWinControl, uCEFSentinel;

type

  TfrxBrowserChromium = class(TChromiumWindow,IfrxWebBrowser)
    private
      FURL: String;
      FNavigateHistory: TStringList;
      FOnTestURL: TTestURLEvent;
      FOnDocumentComplet: TNotifyEvent;
      FOnNavComplete: TNavComplete;
      FTimer: TTimer;
      procedure FTimerOnTimer(Sender: TObject);
      function GetNavigateHistory : TStringList; stdcall;
      function GetOnDocumentComplet : TNotifyEvent; stdcall;
      function GetOnTestURL : TTestURLEvent; stdcall;
      function GetURL : String; stdcall;
      function GetDocument: IDispatch; stdcall;
      procedure SetNavigateHistory(const Value: TStringList); stdcall;
      procedure SetOnDocumentComplet(const Value: TNotifyEvent); stdcall;
      procedure SetOnTestURL(const Value: TTestURLEvent); stdcall;
      procedure SetURL(const Value: String); stdcall;
      procedure SetOnNavComplete(const Value: TNavComplete); stdcall;
      procedure BrowserConfiguration; stdcall;
      procedure CloseQuery(var CanClose: Boolean); stdcall;
      procedure ChromiumWindowAfterCreated(Sender: TObject);
      procedure ChromiumWindowClose(Sender: TObject);
      procedure ChromiumWindowBeforeClose(Sender: TObject);
      // You have to handle this two messages to call NotifyMoveOrResizeStarted or some page elements will be misaligned.
      procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
      procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
      // You also have to handle these two messages to set GlobalCEFApp.OsmodalLoop
      procedure WMEnterMenuLoop(var aMessage: TMessage); message WM_ENTERMENULOOP;
      procedure WMExitMenuLoop(var aMessage: TMessage); message WM_EXITMENULOOP;
      procedure ChromiumOnLoadEnd (Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
      procedure ChromiumOnLoadError(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: TCefErrorCode; const errorText, failedUrl: ustring);
    protected
      // Variables to control when can we destroy the form safely
      FCanClose : boolean;  // Set to True in TChromium.OnBeforeClose
      FClosing  : boolean;  // Set to True in the CloseQuery event.
      procedure NavigateURL(aURL : String); stdcall;
      procedure Chromium_OnBeforePopup(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue; var noJavascriptAccess: Boolean; var Result: Boolean);
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
  end;

implementation

uses
  uCEFApplication;

{ TfrxBrowserChromium }

procedure TfrxBrowserChromium.Chromium_OnBeforePopup(      Sender             : TObject;
                                        const browser            : ICefBrowser;
                                        const frame              : ICefFrame;
                                        const targetUrl          : ustring;
                                        const targetFrameName    : ustring;
                                              targetDisposition  : TCefWindowOpenDisposition;
                                              userGesture        : Boolean;
                                        const popupFeatures      : TCefPopupFeatures;
                                        var   windowInfo         : TCefWindowInfo;
                                        var   client             : ICefClient;
                                        var   settings           : TCefBrowserSettings;
                                        var   extra_info         : ICefDictionaryValue;
                                        var   noJavascriptAccess : Boolean;
                                        var   Result             : Boolean);
begin
  // Blocks all popup windows and new tabs
  Result := (targetDisposition in [WOD_NEW_FOREGROUND_TAB, WOD_NEW_BACKGROUND_TAB, WOD_NEW_POPUP, WOD_NEW_WINDOW]);
end;

procedure TfrxBrowserChromium.CloseQuery(var CanClose: Boolean);
begin
  FCanClose := True;
  CanClose := FCanClose;

  if not(FClosing) then
    begin
      FClosing := True;
      Visible  := False;
      Self.CloseBrowser(True);
    end;
end;

constructor TfrxBrowserChromium.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTimer := TTimer.Create(AOwner);
  FTimer.OnTimer := FTimerOnTimer;
  FTimer.Interval := 300;
  Self.OnAfterCreated := ChromiumWindowAfterCreated;
  Self.OnClose := ChromiumWindowClose;
  Self.OnBeforeClose := ChromiumWindowBeforeClose;
end;

destructor TfrxBrowserChromium.Destroy;
begin
  FreeAndNil(FTimer);
  inherited;
end;

function TfrxBrowserChromium.GetDocument: IDispatch;
begin
  { TODO :  }
  Result := nil;
end;

function TfrxBrowserChromium.GetNavigateHistory: TStringList;
begin
  Result := FNavigateHistory;
end;

function TfrxBrowserChromium.GetOnDocumentComplet: TNotifyEvent;
begin
  Result := FOnDocumentComplet;
end;

function TfrxBrowserChromium.GetOnTestURL: TTestURLEvent;
begin
  Result := FOnTestURL;
end;

function TfrxBrowserChromium.GetURL: String;
begin
  Result := FURL;
end;

procedure TfrxBrowserChromium.NavigateURL(aURL: String);
begin
  Self.LoadURL(aURL);
end;

procedure TfrxBrowserChromium.SetNavigateHistory(const Value: TStringList);
begin
  FNavigateHistory:= Value;
end;

procedure TfrxBrowserChromium.SetOnDocumentComplet(const Value: TNotifyEvent);
begin
  FOnDocumentComplet:= Value;
end;

procedure TfrxBrowserChromium.SetOnNavComplete(const Value: TNavComplete);
begin
  FOnNavComplete:= Value;
end;

procedure TfrxBrowserChromium.SetOnTestURL(const Value: TTestURLEvent);
begin
  FOnTestURL:= Value;
end;

procedure TfrxBrowserChromium.SetURL(const Value: String);
begin
  FURL := Value;
end;

procedure TfrxBrowserChromium.BrowserConfiguration;
begin
  Self.ChromiumBrowser.OnLoadEnd := ChromiumOnLoadEnd;
  Self.ChromiumBrowser.OnLoadError := ChromiumOnLoadError;
  FCanClose := False;
  FClosing  := False;
 // Blocks all popup windows and new tabs
  Self.ChromiumBrowser.OnBeforePopup := Chromium_OnBeforePopup;

  // You *MUST* call CreateBrowser to create and initialize the browser.
  // This will trigger the AfterCreated event when the browser is fully
  // initialized and ready to receive commands.

  // GlobalCEFApp.GlobalContextInitialized has to be TRUE before creating any browser
  // If it's not initialized yet, we use a simple timer to create the browser later.
  if not(Self.CreateBrowser) then FTimer.Enabled := True;
end;

procedure TfrxBrowserChromium.ChromiumOnLoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
begin
    FNavigateHistory.Add(frame.Url);
    FOnNavComplete(frame.Url);
end;

procedure TfrxBrowserChromium.ChromiumOnLoadError(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; errorCode: TCefErrorCode;
  const errorText, failedUrl: ustring);
begin
  FNavigateHistory.Add(failedUrl + '&ReturnCode|' + VarToStr(errorCode));
end;

procedure TfrxBrowserChromium.ChromiumWindowAfterCreated(Sender: TObject);
begin
  Self.LoadURL(FURL);
end;

procedure TfrxBrowserChromium.ChromiumWindowClose(Sender: TObject);
begin
  // DestroyChildWindow will destroy the child window created by CEF at the top of the Z order.
  if not(Self.DestroyChildWindow) then
    begin
      FCanClose := True;
      PostMessage(Handle, WM_CLOSE, 0, 0);
    end;
end;

procedure TfrxBrowserChromium.ChromiumWindowBeforeClose(Sender: TObject);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TfrxBrowserChromium.FTimerOnTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  if not(Self.CreateBrowser) and not(Self.Initialized) then
    FTimer.Enabled := True
  else
    Self.LoadURL(FURL);
end;

procedure TfrxBrowserChromium.WMMove(var aMessage : TWMMove);
begin
  inherited;
  if (Self <> nil) then Self.NotifyMoveOrResizeStarted;
end;

procedure TfrxBrowserChromium.WMMoving(var aMessage : TMessage);
begin
  inherited;
  if (Self <> nil) then Self.NotifyMoveOrResizeStarted;
end;

procedure TfrxBrowserChromium.WMEnterMenuLoop(var aMessage: TMessage);
begin
  inherited;
  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := True;
end;

procedure TfrxBrowserChromium.WMExitMenuLoop(var aMessage: TMessage);
begin
  inherited;
  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := False;
end;

initialization
  frxBrowserGlobal :=  TfrxBrowserChromium;
end.
