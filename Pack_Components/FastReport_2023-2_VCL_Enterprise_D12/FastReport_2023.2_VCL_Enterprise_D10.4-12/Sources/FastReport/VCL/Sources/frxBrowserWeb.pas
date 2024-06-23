{******************************************}
{                                          }
{             FastReport VCL               }
{           Module for using               }
{       TWebBrowser as a browser           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{                                          }
{******************************************}
unit frxBrowserWeb;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxBrowser,
  OleCtrls,
  frxFPUMask {save Exception mask SHDocVw changes it },
  SHDocVw, Math;
type

  TfrxBrowserWeb = class(TWebBrowser,IfrxWebBrowser)
  {$IfDef DELPHI16}
    procedure WebBrowserNavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
  {$Else}
    procedure WebBrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  {$EndIf}
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
    procedure SetOnNavComplete(const Value: TNavComplete); stdcall;
    procedure SetURL(const Value: String); stdcall;
    procedure BrowserConfiguration; stdcall;
    procedure CloseQuery(var CanClose: Boolean); stdcall;
    procedure SetListenerPort(const Value: Integer); stdcall;
    procedure SetRedirectURL(const Value: String); stdcall;
{$IfDef DELPHI16}
    procedure NavigateError(ASender: TObject; const pDisp: IDispatch; const URL,
      Frame, StatusCode: OleVariant; var Cancel: WordBool);
    procedure DocumentComplet(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
{$Else}
    procedure DocumentComplet(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
{$EndIf}
  protected
    procedure NavigateURL(aURL : String); stdcall;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TfrxBrowserWeb }

procedure TfrxBrowserWeb.BrowserConfiguration;
begin
  { TODO :  }
end;

procedure TfrxBrowserWeb.CloseQuery(var CanClose: Boolean);
begin
  { TODO :  }
end;

constructor TfrxBrowserWeb.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF DELPHI27}
  Self.SelectedEngine := EdgeIfAvailable;
{$ENDIF}
  Self.OnNavigateComplete2 := WebBrowserNavigateComplete2;
  Self.OnDocumentComplete := DocumentComplet;
{$IfDef DELPHI16}
  Self.OnNavigateError := NavigateError;
{$EndIf}
end;

procedure TfrxBrowserWeb.NavigateURL(aURL: String);
begin
  Self.Navigate(aURL);
end;

{$IfDef DELPHI16}
procedure TfrxBrowserWeb.WebBrowserNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
{$Else}
procedure TfrxBrowserWeb.WebBrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
{$EndIf}
begin
  FNavigateHistory.Add(URL);
  FOnNavComplete(URL);
end;

{$IfDef DELPHI16}
procedure TfrxBrowserWeb.DocumentComplet(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
{$Else}
procedure TfrxBrowserWeb.DocumentComplet(ASender: TObject; const pDisp: IDispatch;
  var URL: OleVariant);
{$EndIf}
begin
  if Assigned(FOnDocumentComplet) then
    FOnDocumentComplet(Self);
end;

{$IfDef DELPHI16}
procedure TfrxBrowserWeb.NavigateError(ASender: TObject; const pDisp: IDispatch;
  const URL, Frame, StatusCode: OleVariant; var Cancel: WordBool);
begin
  FNavigateHistory.Add(URL + '&ReturnCode|' + VarToStr(StatusCode));
end;
{$EndIf}

function TfrxBrowserWeb.GetDocument: IDispatch;
begin
  if Assigned(FOnDocumentComplet) then
    FOnDocumentComplet(Self);
  Result := Self.Document;
end;

function TfrxBrowserWeb.GetNavigateHistory : TStringList;
begin
  Result := FNavigateHistory;
end;

function TfrxBrowserWeb.GetOnDocumentComplet : TNotifyEvent;
begin
  Result := FOnDocumentComplet;
end;

function TfrxBrowserWeb.GetOnTestURL : TTestURLEvent;
begin
  Result := FOnTestURL;
end;

function TfrxBrowserWeb.GetURL : String;
begin
  Result := FURL;
end;

procedure TfrxBrowserWeb.SetListenerPort(const Value: Integer);
begin

end;

procedure TfrxBrowserWeb.SetNavigateHistory(const Value: TStringList);
begin
  FNavigateHistory := Value;
end;

procedure TfrxBrowserWeb.SetOnDocumentComplet(const Value: TNotifyEvent);
begin
  FOnDocumentComplet := Value;
end;

procedure TfrxBrowserWeb.SetOnNavComplete(const Value: TNavComplete);
begin
  FOnNavComplete := Value;
end;

procedure TfrxBrowserWeb.SetOnTestURL(const Value: TTestURLEvent);
begin
  FOnTestURL := Value;
end;

procedure TfrxBrowserWeb.SetRedirectURL(const Value: String);
begin
//
end;

procedure TfrxBrowserWeb.SetURL(const Value: String);
begin
  FURL := Value;
end;

initialization
  frxBrowserGlobal :=  TfrxBrowserWeb;
end.
