unit GOX.WiRL.Http.Server.Indy;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  IdBaseComponent,
  IdComponent,
  IdServerIOHandler,
  IdSSL,
  IdSSLOpenSSL,
  IdHTTPServer,
  IdContext,
  IdCustomHTTPServer,
  WiRL.http.Response,
  //
//  Core.Server.Params,
  //
  System.IniFiles;


type
  TGOXHTTPServerIndy = class
    private
    { Private declarations }
    FSSLHandler  : TIdServerIOHandlerSSLOpenSSL;
    FHTTPServer  :  TIdHTTPServer;
    //
    FUseSSL      : String;
    FCertFile    : String;
    FKeyFile     : String;
    FRootCertFile: String;
    FCertPassword: String;

    //
    procedure OnIdHTTPServerQuerySSLPort(APort: Word; var VUseSSL: Boolean);
    Function  OnSSLVerifyPeer (Certificate : TIdX509; AOk : Boolean; ADepth, AError : Integer) : Boolean;


    //
    procedure SSLGetPassword(var Password: string);
    //
    const Port_HTTP  = 80;
    const Port_HTTPS = 443;

  public
    { Public declarations }
    constructor Create(AHTTPServer:TIdHTTPServer);
    destructor Destroy; override;

  end;

  TGOXHTTPRequestIndy = class
  private
    { Private declarations }
    FHTTPRequestServer: TIdHTTPRequestInfo;
  public
   { Public declarations }
   constructor Create(AHTTPRequestServer:TIdHTTPRequestInfo);
   destructor Destroy; override;
  end;

  TGOXHTTPResponseIndy = class
  private
    { Private declarations }
    FHTTPResponseServer: TIdHTTPResponseInfo;
  public
   { Public declarations }
   constructor Create(AHTTPResponseServer:TIdHTTPResponseInfo);
   destructor Destroy; override;
  end;




implementation


{ TGOXHTTPServerIndy }

constructor TGOXHTTPServerIndy.Create(AHTTPServer:TIdHTTPServer);
begin
  try
   {
    FUseSSL       := TPARAMServer.Get.PARAMS_Certificate_UseSSL;
    FCertFile     := TPARAMServer.Get.PARAMS_Certificate_File;
    FKeyFile      := TPARAMServer.Get.PARAMS_Certificate_KeyFile;
    FRootCertFile := TPARAMServer.Get.PARAMS_Certificate_RootFile;
  //FCipherList   := '';
    FCertPassword := TPARAMServer.Get.PARAMS_Certificate_Password;
    //
  }
    FHTTPServer := AHTTPServer;
    //
//    FHTTPServer.ParseParams := true;
//    FHTTPServer.MaxConnections := 1000;
//    FHTTPServer.AutoStartSession := True;
//    FHTTPServer.SessionState := True;


    //Link Events
    FHTTPServer.OnQuerySSLPort := OnIdHTTPServerQuerySSLPort;

    //Cria Components SSL que Usa OpenSSL
    if (UpperCase(FUseSSL) = 'S') then
    begin
      FSSLHandler:= TIdServerIOHandlerSSLOpenSSL.Create(nil);
      FSSLHandler.SSLOptions.CertFile := FCertFile;
      FSSLHandler.SSLOptions.KeyFile  := FKeyFile;
      FSSLHandler.SSLOptions.RootCertFile := FRootCertFile;
      FSSLHandler.SSLOptions.Method := sslvSSLv2;
      FSSLHandler.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
      FSSLHandler.SSLOptions.Mode := sslmServer;
      FSSLHandler.SSLOptions.VerifyDepth := 0;
      FSSLHandler.OnVerifyPeer := OnSSLVerifyPeer;
      FSSLHandler.SSLOptions.VerifyMode := [];
      FSSLHandler.OnGetPassword := SSLGetPassword;
      //
      FHTTPServer.IOHandler := FSSLHandler;
//      FHTTPServer.Bindings.Add.Port := Port_HTTPS;
//      FHTTPServer.Bindings.Add.Port := Port_HTTP;
    end;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TGOXHTTPServerIndy.Destroy;
begin
  FreeAndNil(FSSLHandler);
  inherited;
end;


procedure TGOXHTTPServerIndy.SSLGetPassword(var Password: string);
begin
  Password := FCertPassword;
end;

procedure TGOXHTTPServerIndy.OnIdHTTPServerQuerySSLPort(APort: Word; var VUseSSL: Boolean);
begin
 //Marcado por jeickson tem que ficar desmarcado
//  VUseSSL := (UpperCase(TPARAMServer.Get.PARAMS_Certificate_UseSSL) = 'S');

  // VUseSSL:=(APort=443);
end;

function TGOXHTTPServerIndy.OnSSLVerifyPeer(Certificate: TIdX509; AOk: Boolean;
  ADepth, AError: Integer): Boolean;
begin
  If ADepth = 0 Then
   Result := AOk
 Else
   Result := True;
end;

{ TGOXHTTPRequestIndy }

constructor TGOXHTTPRequestIndy.Create(AHTTPRequestServer: TIdHTTPRequestInfo);
begin
  FHTTPRequestServer :=  AHTTPRequestServer;

end;

destructor TGOXHTTPRequestIndy.Destroy;
begin

  inherited;
end;


{ TGOXHTTPResponseIndy }

constructor TGOXHTTPResponseIndy.Create(AHTTPResponseServer: TIdHTTPResponseInfo);
begin
  FHTTPResponseServer :=  AHTTPResponseServer;
  //Add CORS
  FHTTPResponseServer.CustomHeaders.AddValue('Access-Control-Allow-Origin','*');
  FHTTPResponseServer.CustomHeaders.AddValue('Access-Control-Allow-Methods','GET, POST, PATCH, PUT, DELETE, OPTIONS');
  FHTTPResponseServer.CustomHeaders.AddValue('Access-Control-Allow-Headers','Content-Type, Origin, Accept, Authorization, X-CUSTOM-HEADER');
end;

destructor TGOXHTTPResponseIndy.Destroy;
begin

  inherited;
end;


initialization
finalization
end.
