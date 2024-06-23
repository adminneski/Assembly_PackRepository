
{******************************************}
{                                          }
{             FastReport VCL               }
{          HTTP connection client          }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxBaseTransportConnection;

{$I frx.inc}
interface

uses
  Windows, SysUtils, Classes;

type
  TfrxHTTPWorkMode = (hwmRead, hwmWrite);
  TfrxHTTPWorkNotifyEvent = procedure (Sender: TObject; AWorkMode: TfrxHTTPWorkMode; AWorkCount: Int64) of object;
  TfrxSocketType = (fstNonBlocking, fstBlocking);
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseTransportConnection = class(TComponent)
  private
    FOnWorkBegin: TfrxHTTPWorkNotifyEvent;
    FOnWorkEnd: TfrxHTTPWorkNotifyEvent;
    FOnWork: TfrxHTTPWorkNotifyEvent;
  protected
    function GetProxyHost: String; virtual;
    function GetProxyLogin: String; virtual;
    function GetProxyPassword: String; virtual;
    function GetProxyPort: Integer; virtual;
    procedure SetProxyHost(const Value: String); virtual;
    procedure SetProxyLogin(const Value: String); virtual;
    procedure SetProxyPassword(const Value: String); virtual;
    procedure SetProxyPort(const Value: Integer); virtual;
    function GetSocketType: TfrxSocketType; virtual;
    procedure SetSocketType(const Value: TfrxSocketType); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Connect; virtual; abstract;
    procedure Disconnect; virtual; abstract;
    procedure SetDefaultParametersWithToken(AToken: String); virtual; abstract;
    property SocketType: TfrxSocketType read GetSocketType write SetSocketType;
    property ProxyHost: String read GetProxyHost write SetProxyHost;
    property ProxyPort: Integer read GetProxyPort write SetProxyPort;
    property ProxyLogin: String  read GetProxyLogin write SetProxyLogin;
    property ProxyPassword: String read GetProxyPassword write SetProxyPassword;
    property OnWork: TfrxHTTPWorkNotifyEvent read FOnWork write FOnWork;
    property OnWorkBegin: TfrxHTTPWorkNotifyEvent read FOnWorkBegin write FOnWorkBegin;
    property OnWorkEnd: TfrxHTTPWorkNotifyEvent read FOnWorkEnd write FOnWorkEnd;
  end;

  TfrxBaseTransportConnectionClass = Class of TfrxBaseTransportConnection;

implementation



{ TfrxBaseTransportConnection }

constructor TfrxBaseTransportConnection.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfrxBaseTransportConnection.Destroy;
begin

  inherited;
end;


function TfrxBaseTransportConnection.GetProxyHost: String;
begin

end;

function TfrxBaseTransportConnection.GetProxyLogin: String;
begin

end;

function TfrxBaseTransportConnection.GetProxyPassword: String;
begin

end;

function TfrxBaseTransportConnection.GetProxyPort: Integer;
begin
  Result := 0;
end;

function TfrxBaseTransportConnection.GetSocketType: TfrxSocketType;
begin
  Result := fstNonBlocking;
end;

procedure TfrxBaseTransportConnection.SetProxyHost(const Value: String);
begin

end;

procedure TfrxBaseTransportConnection.SetProxyLogin(const Value: String);
begin

end;

procedure TfrxBaseTransportConnection.SetProxyPassword(const Value: String);
begin

end;

procedure TfrxBaseTransportConnection.SetProxyPort(const Value: Integer);
begin

end;

procedure TfrxBaseTransportConnection.SetSocketType(
  const Value: TfrxSocketType);
begin

end;

end.
