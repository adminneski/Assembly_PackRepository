unit frxSaveFilterBrowser;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, Math, Registry, frxBrowser, frxBrowserStub {frxBrowserWeb};
const
        // Quelle: https://msdn.microsoft.com/library/ee330730.aspx,
        // Stand: 2015-03-10
        IE11_default   = 11000;
        IE11_Quirks    = 11001;
        IE10_force     = 10001;
        IE10_default   = 10000;
        IE9_Quirks     = 9999;
        IE9_default    = 9000;
        /// <summary>
        /// Webpages containing standards-based
        /// !DOCTYPE directives are displayed in IE7
        /// Standards mode. Default value for
        /// applications hosting the WebBrowser Control.
        /// </summary>
        IE7_embedded   = 7000;
  function GetExeName(): String;
  procedure SetBrowserEmulationDWORD(const value: DWORD);
type

  TBrowserForm = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    WebBrowserWinControl: TWinControl;
    WebBrowser: IfrxWebBrowser;
    function GetNavigateHistory : TStringList;
    function GetOnDocumentComplet : TNotifyEvent;
    function GetOnTestURL : TTestURLEvent;
    function GetURL : String;
    procedure SetNavigateHistory(const Value: TStringList);
    procedure SetOnDocumentComplet(const Value: TNotifyEvent);
    procedure SetOnTestURL(const Value: TTestURLEvent);
    procedure SetURL(const Value: String);

    procedure NavComplete(const aURL: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetListenerPort(const Value: Integer);
    procedure SetRedirect(const Value: String);
    property URL: String read GetURL write SetURL;
    property NavigateHistory: TStringList read GetNavigateHistory write SetNavigateHistory;
    property OnTestURL: TTestURLEvent read GetOnTestURL write SetOnTestURL;
    property OnDocumentComplet: TNotifyEvent read GetOnDocumentComplet write SetOnDocumentComplet;
    property GetWebBrowser: IfrxWebBrowser read WebBrowser  write WebBrowser;
    function GetDocument: IDispatch;
  end;

implementation

{$R *.dfm}

uses
  frxMapHelpers;

function GetExeName(): String;
begin
    Result := ExtractFileName(ParamStr(0));
end;

procedure SetBrowserEmulationDWORD(const Value: DWORD);
const RegistryPath = 'Software\Microsoft\Internet Explorer\Main\'
                      +'FeatureControl\FEATURE_BROWSER_EMULATION';
var
    Registry:  TRegistry;
    ExeName:   String;
begin
    ExeName := GetExeName();
    Registry := TRegistry.Create(KEY_SET_VALUE);
    try
       Registry.RootKey := HKEY_CURRENT_USER;
       Win32Check(Registry.OpenKey(RegistryPath, True));
       Registry.WriteInteger(ExeName, Value)
    finally
       Registry.Free;
    end;
end;

constructor TBrowserForm.Create(AOwner: TComponent);
begin
  inherited;
  if Assigned(frxBrowserGlobal) then
  begin
    WebBrowserWinControl := TWinControl(frxBrowserGlobal.NewInstance);
    WebBrowserWinControl.Create(Self);
    WebBrowserWinControl.Parent := Self;
    WebBrowserWinControl.Align := alClient;
  end;
  if not Supports(WebBrowserWinControl, IfrxWebBrowser, WebBrowser) then
    raise Exception.Create('Can not find browser');
  WebBrowser.GetDocument;
  WebBrowser.SetOnNavComplete(NavComplete);
end;

destructor TBrowserForm.Destroy;
begin
  inherited;
end;

procedure TBrowserForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  WebBrowser.CloseQuery(CanClose);
end;

procedure TBrowserForm.FormCreate(Sender: TObject);
begin
  Translate(Self);
  Self.Caption := Self.Caption + ' (' +  Copy(frxBrowserGlobal.ClassName,12,Length(frxBrowserGlobal.ClassName)) + ')';
{$IFNDEF DELPHI27}
  if frxBrowserGlobal.ClassName = 'TfrxBrowserWeb' then
    SetBrowserEmulationDWORD(IE11_default);
{$ENDIF}
end;

procedure TBrowserForm.FormShow(Sender: TObject);
begin
  WebBrowser.BrowserConfiguration;
  WebBrowser.NavigateURL(URL);
end;

function TBrowserForm.GetDocument: IDispatch;
begin
  if WebBrowser <>nil then
    Result := WebBrowser.GetDocument;
end;

function TBrowserForm.GetNavigateHistory : TStringList;
begin
  Result := WebBrowser.GetNavigateHistory;
end;

function TBrowserForm.GetOnDocumentComplet : TNotifyEvent;
begin
  Result := WebBrowser.GetOnDocumentComplet;
end;

function TBrowserForm.GetOnTestURL : TTestURLEvent;
begin
  Result := WebBrowser.GetOnTestURL;
end;

function TBrowserForm.GetURL : String;
begin
  Result := WebBrowser.GetURL;
end;

procedure TBrowserForm.SetListenerPort(const Value: Integer);
begin
  WebBrowser.SetListenerPort(Value);
end;

procedure TBrowserForm.SetNavigateHistory(const Value: TStringList);
begin
  WebBrowser.SetNavigateHistory(Value);
end;

procedure TBrowserForm.SetOnDocumentComplet(const Value: TNotifyEvent);
begin
  WebBrowser.SetOnDocumentComplet(Value);
end;

procedure TBrowserForm.SetOnTestURL(const Value: TTestURLEvent);
begin
  WebBrowser.SetOnTestURL(Value);
end;

procedure TBrowserForm.SetRedirect(const Value: String);
begin
  WebBrowser.SetRedirectURL(Value);
end;

procedure TBrowserForm.SetURL(const Value: String);
begin
  WebBrowser.SetURL(Value);
end;

procedure TBrowserForm.NavComplete(const aURL: OleVariant);
var
  FOnTestURL : TTestURLEvent;
  s: String;
begin
  FOnTestURL := OnTestURL;
  if Assigned(OnTestURL) and FOnTestURL(aURL, s) then
    ModalResult := mrOK;
end;

end.
