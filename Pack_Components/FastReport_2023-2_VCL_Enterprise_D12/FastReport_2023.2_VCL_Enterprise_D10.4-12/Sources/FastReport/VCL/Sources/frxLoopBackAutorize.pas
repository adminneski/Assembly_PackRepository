
{******************************************}
{                                          }
{             FastReport VCL               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxLoopBackAutorize;

interface

{$I frx.inc}

uses
  SysUtils, Classes, SyncObjs, ScktComp, Windows, frxBrowser, ExtCtrls
{$IFDEF DELPHI12}, AnsiStrings{$ENDIF};

type
  TfrxServerListenerThread = class(TThread)
  protected
    FServer: TServerSocket;
    FPort: Integer;
    FAnswer: String;
    FLocation: AnsiString;
    procedure DoRead(Sender: TObject; Socket: TCustomWinSocket);
  public
    destructor Destroy; override;
    procedure SetPort(const Value: Integer);
    procedure SetLocation(const Value: AnsiString);
    procedure Execute; override;
  end;

  TfrxLoopBackListener = class(TObject)
  private
    FPort: Integer;
    FAnswer: String;
    FErrors: String;
    FURL: String;
    FTimer: TTimer;
    FLocationURL: AnsiString;
    procedure DoTimer(Sender: TObject);
    function GetWaitInterval: Integer;
    procedure SetWaitInterval(const Value: Integer);
  protected
    FServerThread: TfrxServerListenerThread;
    FOnTestURL: TTestURLEvent;
  public
    constructor Create;
    destructor Destroy; override;
    procedure WaitFor;
    procedure Stop;
    property Port: Integer read FPort write FPort;
    property URL: String read FURL write FURL;
    property LocationURL: AnsiString read FLocationURL write FLocationURL;
    property OnTestURL: TTestURLEvent read FOnTestURL write FOnTestURL;
    property Answer: String read FAnswer write FAnswer;
    property Errors: String read FErrors write FErrors;
    property WaitInterval: Integer read GetWaitInterval write SetWaitInterval;
  end;

implementation

uses frxNetUtils, ShellAPI;

{ TfrxLoopBackListener }

constructor TfrxLoopBackListener.Create;
begin
  FTimer :=  TTimer.Create(nil);
  WaitInterval := 180000;
  FTimer.OnTimer := DoTimer;
end;

destructor TfrxLoopBackListener.Destroy;
begin
  FreeAndNil(FTimer);
  inherited;
end;


procedure TfrxLoopBackListener.DoTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  if Assigned(FServerThread) then
    FServerThread.Terminate;
end;

function TfrxLoopBackListener.GetWaitInterval: Integer;
begin
  Result := FTimer.Interval;
end;

procedure TfrxLoopBackListener.SetWaitInterval(const Value: Integer);
begin
  FTimer.Interval := Value;
end;

procedure TfrxLoopBackListener.Stop;
begin
  DoTimer(nil);
end;

procedure TfrxLoopBackListener.WaitFor;
var
  s: String;
begin
  FTimer.Enabled := True;
  FServerThread := TfrxServerListenerThread.Create(True);
  FServerThread.SetPort(FPort);
  FServerThread.SetLocation(FLocationURL);
  if ShellExecute(0, 'open', PChar(@FURL[1]), nil, nil, SW_SHOWNORMAL) <= 32 then Exit;
  FServerThread.Execute;
  if Assigned(OnTestURL) then
    OnTestURL(FServerThread.FAnswer, s);
  FErrors := s;
  FAnswer := FServerThread.FAnswer;
  FreeAndNil(FServerThread);
end;

{ TfrxServerListenerThread }

destructor TfrxServerListenerThread.Destroy;
begin
  if Assigned(FServer) then
    FServer.Close;
  PMessages;
  inherited;
end;

procedure TfrxServerListenerThread.DoRead(Sender: TObject;
  Socket: TCustomWinSocket);
const
  sAnswer: AnsiString = 'HTTP/1.0 200 OK'#13#10'content-type: text/html; charset=UTF-8'#13#10'Content-length: %u'#13#10#13#10;
  ret_HTML: AnsiString = '<html><script type="text/javascript">window.open('''', ''_self'', '''').close();</script><body>Close the window.</body></html>';
var
  s: AnsiString;
  i: Integer;
begin
  s:= Socket.ReceiveText;
  i := Pos(AnsiString('GET'), s);
  if i < 0 then
  begin
    Socket.Close;
    Exit;
  end;
  FAnswer := String(s);
  s := Format(sAnswer, [Length(ret_HTML)]);
  s := s + ret_HTML;
  Socket.SendText(s);
  Terminate;
end;

procedure TfrxServerListenerThread.Execute;
begin
  FServer := TServerSocket.Create(nil);
  FServer.Port := FPort;
  FServer.OnClientRead := DoRead;
  FServer.ServerType := stNonBlocking;
  FServer.Active := True;
  while FServer.Active and not Terminated do PMessages;
  Sleep(100);
  PMessages;
  FServer.Close;
  PMessages;
  FreeAndNil(FServer);
end;

procedure TfrxServerListenerThread.SetLocation(const Value: AnsiString);
begin
  FLocation := Value;
end;

procedure TfrxServerListenerThread.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

end.

