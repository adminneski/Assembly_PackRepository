{******************************************}
{                                          }
{             FastReport VCL               }
{           Module for using               }
{       TEdgeBrowser as a browser          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{                                          }
{******************************************}
unit frxBrowserEdge;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxBrowser,
  Math,
  Vcl.Edge,WebView2;
type

  TfrxBrowserEdge = class(TEdgeBrowser,IfrxWebBrowser)
  private
    FURL: String;
    FNavigateHistory: TStringList;
    FOnTestURL: TTestURLEvent;
    FOnDocumentComplet: TNotifyEvent;
    FOnNavComplete: TNavComplete;
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
    procedure EdgeBrowserNavigationCompleted(Sender: TCustomEdgeBrowser; IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
    protected
      procedure   NavigateURL(aURL : String); stdcall;
    public
      constructor Create(AOwner: TComponent); override;
  end;
implementation

{ TfrxBrowserEdge }

procedure TfrxBrowserEdge.BrowserConfiguration;
begin
{ TODO :  }
end;

procedure TfrxBrowserEdge.CloseQuery(var CanClose: Boolean);
begin
{ TODO :  }
end;

constructor TfrxBrowserEdge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.OnNavigationCompleted := EdgeBrowserNavigationCompleted;
end;

procedure TfrxBrowserEdge.NavigateURL(aURL : String);
begin
  Self.Navigate(aURL);
end;

procedure TfrxBrowserEdge.EdgeBrowserNavigationCompleted(
  Sender: TCustomEdgeBrowser; IsSuccess: Boolean;
  WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
  FNavigateHistory.Add(Self.LocationURL);
  if Assigned(FOnTestURL) and FOnTestURL(Self.LocationURL) then
    FOnNavComplete(Self.LocationURL);
  if not IsSuccess then
    FNavigateHistory.Add(Self.LocationURL + '&ReturnCode|' + VarToStr(WebErrorStatus));
  FOnNavComplete(Self.LocationURL);
end;

function TfrxBrowserEdge.GetDocument: IDispatch;
begin
  { TODO :  }
  Result := nil;
end;

function TfrxBrowserEdge.GetNavigateHistory : TStringList;
begin
  Result := FNavigateHistory;
end;

function TfrxBrowserEdge.GetOnDocumentComplet : TNotifyEvent;
begin
  Result := FOnDocumentComplet;
end;

function TfrxBrowserEdge.GetOnTestURL : TTestURLEvent;
begin
  Result := FOnTestURL;
end;

function TfrxBrowserEdge.GetURL : String;
begin
  Result := FURL;
end;

procedure TfrxBrowserEdge.SetNavigateHistory(const Value: TStringList);
begin
  FNavigateHistory := Value;
end;

procedure TfrxBrowserEdge.SetOnDocumentComplet(const Value: TNotifyEvent);
begin
  FOnDocumentComplet := Value;
end;

procedure TfrxBrowserEdge.SetOnNavComplete(const Value: TNavComplete);
begin
  FOnNavComplete := Value;
end;

procedure TfrxBrowserEdge.SetOnTestURL(const Value: TTestURLEvent);
begin
  FOnTestURL := Value;
end;

procedure TfrxBrowserEdge.SetURL(const Value: String);
begin
  FURL := Value;
end;

initialization
  frxBrowserGlobal :=  TfrxBrowserEdge;

end.
