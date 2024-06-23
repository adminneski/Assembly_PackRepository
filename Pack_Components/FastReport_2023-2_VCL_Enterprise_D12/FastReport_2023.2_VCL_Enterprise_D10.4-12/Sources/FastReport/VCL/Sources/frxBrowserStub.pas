{******************************************}
{                                          }
{             FastReport VCL               }
{       stub to process default browser    }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{                                          }
{******************************************}
unit frxBrowserStub;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxBrowser,
  ExtCtrls, StdCtrls, Math, frxLoopBackAutorize;
type

  TfrxBrowserStub = class(TPanel, IfrxWebBrowser)
  {$IfDef DELPHI16}
    procedure WebBrowserNavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
  {$Else}
    procedure WebBrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  {$EndIf}
  private
    FURL: String;
    FTimer: TTimer;
    FOnDocumentComplet: TNotifyEvent;
    FOnNavComplete: TNavComplete;
    FListener: TfrxLoopBackListener;
    FErrorsList: TStringList;
    FForm: TForm;
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
  protected
    procedure NavigateURL(aURL : String); stdcall;
    procedure DoTimer(Sender: TObject);
    procedure DoClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TfrxBrowserWeb }

procedure TfrxBrowserStub.BrowserConfiguration;
begin
  { TODO :  }
end;

procedure TfrxBrowserStub.CloseQuery(var CanClose: Boolean);
begin
  FErrorsList.Text := FListener.Errors;
end;

procedure TfrxBrowserStub.SetRedirectURL(const Value: String);
begin
  FListener.LocationURL := AnsiString(Value);
end;

procedure TfrxBrowserStub.SetListenerPort(const Value: Integer);
begin
  FListener.Port := Value;
end;

constructor TfrxBrowserStub.Create(AOwner: TComponent);
var
  btn: TButton;
begin
  inherited Create(AOwner);
  FErrorsList := TStringList.Create;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 1000;
  FTimer.OnTimer := DoTimer;
  if AOwner is TForm then
  begin
    FForm := TForm(AOwner);
    FForm.BorderStyle := bsNone;
    FForm.SetBounds(0, 0, 200, 100);
    FForm.Position := poOwnerFormCenter;
  end;
  FListener := TfrxLoopBackListener.Create;
  Caption := 'Loading';
  Alignment := taCenter;
  btn := TButton.Create(Self);
  btn.Parent := Self;
  btn.SetBounds(50, 60, 100, 30);
  btn.ModalResult := mrCancel;
  btn.Caption := 'Cancel';
  btn.Visible := True;
  btn.OnClick := DoClick;
end;


destructor TfrxBrowserStub.Destroy;
begin
  FreeAndNil(FListener);
  FreeAndNil(FTimer);
  FreeAndNil(FErrorsList);
  inherited;
end;

procedure TfrxBrowserStub.NavigateURL(aURL: String);
begin
  FURL := aURL;
  FListener.URL := aURL;
  FTimer.Enabled := True;
end;

procedure TfrxBrowserStub.DoClick(Sender: TObject);
begin
  FListener.Stop;
  if Assigned(FForm) then
    FForm.ModalResult := mrCancel;
end;

procedure TfrxBrowserStub.DoTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  FListener.WaitFor;
  if Assigned(FOnNavComplete) then
    FOnNavComplete(FListener.Answer);
  if (Parent is TForm) and (TForm(Parent).ModalResult = mrNone) then
    TForm(Parent).ModalResult := mrCancel;
end;

{$IfDef DELPHI16}
procedure TfrxBrowserStub.WebBrowserNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
{$Else}
procedure TfrxBrowserStub.WebBrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
{$EndIf}
begin

end;


function TfrxBrowserStub.GetDocument: IDispatch;
begin
  if Assigned(FOnDocumentComplet) then
    FOnDocumentComplet(Self);
  Result := nil;
end;

function TfrxBrowserStub.GetNavigateHistory : TStringList;
begin
  Result := FErrorsList;
end;

function TfrxBrowserStub.GetOnDocumentComplet : TNotifyEvent;
begin
  Result := FOnDocumentComplet;
end;

function TfrxBrowserStub.GetOnTestURL : TTestURLEvent;
begin
  Result := FListener.OnTestURL;
end;

function TfrxBrowserStub.GetURL : String;
begin
  Result := FURL;
end;

procedure TfrxBrowserStub.SetNavigateHistory(const Value: TStringList);
begin
  FErrorsList.Assign(Value);
end;

procedure TfrxBrowserStub.SetOnDocumentComplet(const Value: TNotifyEvent);
begin
  FOnDocumentComplet := Value;
end;

procedure TfrxBrowserStub.SetOnNavComplete(const Value: TNavComplete);
begin
  FOnNavComplete := Value;
end;

procedure TfrxBrowserStub.SetOnTestURL(const Value: TTestURLEvent);
begin
  FListener.OnTestURL := Value;
end;

procedure TfrxBrowserStub.SetURL(const Value: String);
begin
  FURL := Value;
end;

initialization
  frxBrowserGlobal :=  TfrxBrowserStub;

end.
