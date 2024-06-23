unit Core.Server.RESTConnection;

interface

uses
  {$IFDEF MSWINDOWS}
  Vcl.Controls,
  Vcl.Forms,
  {$ENDIF MSWINDOWS}
  IdURI,
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.JSON,
  System.Net.HttpClient,
  Data.DB,
  REST.Json,
  Tools.Collections.Methods,
  goxormbr.engine.connection,
  goxormbr.core.types,
  Core.Server.Params,
  Vcl.Dialogs;

type
  TRESTConnection = class
    private
    { Private declarations }
    //AUTHENTICATOR
    FAUTHENTICATOR_URLBase:String;
    FAUTHENTICATOR_URLBaseContingency :String;
    FAUTHENTICATOR_RESTClient: TGOXRESTConnectionEngine;
    //
    FAUTHENTICATOR_TokenAuthorization : String;
    FAUTHENTICATOR_IsAuthenticated:Boolean;
    FAUTHENTICATOR_IsOnlineServer: Boolean;
    FAUTHENTICATOR_IsServerContingency: Boolean;
    //EXPRESS
    FEXPRESS_URLBase:String;
    FEXPRESS_URLBaseContingency :String;
    //
    FEXPRESS_RESTClient: TGOXRESTConnectionEngine;
    FEXPRESS_TokenAuthorization : String;
    FEXPRESS_IsAuthenticated:Boolean;
    FEXPRESS_IsOnlineServer: Boolean;
    FEXPRESS_IsServerContingency: Boolean;
    //
    //DEFAULTDATA
    FDEFAULTDATA_URLBase:String;
    FDEFAULTDATA_URLBaseContingency :String;
    //
    FDEFAULTDATA_RESTClient: TGOXRESTConnectionEngine;
    FDEFAULTDATA_TokenAuthorization : String;
    FDEFAULTDATA_IsAuthenticated:Boolean;
    FDEFAULTDATA_IsOnlineServer: Boolean;
    FDEFAULTDATA_IsServerContingency: Boolean;
    //
    //Requisitar Status do Servidor
    function AUTHENTICATOR_RequestStatusOK:Boolean;
    function EXPRESS_RequestStatusOK:Boolean;
//    function DEFAULTDATA_RequestStatusOK:Boolean;
    //
    class var fInstance : TRESTConnection;
    constructor CreatePrivate;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    class function Get: TRESTConnection;
    function DEFAULTDATA_RequestStatusOK:Boolean;
    //
    //AUTHENTICATOR
    function AUTHENTICATOR_URLBase:String;
    function AUTHENTICATOR_RESTClient: TGOXRESTConnectionEngine;
    //
    function AUTHENTICATOR_TokenBodyAuthenticate(ABodyAuth: String):Boolean;
    function AUTHENTICATOR_TokenAuthorization: String;
    function AUTHENTICATOR_IsAuthenticated:Boolean;
    function AUTHENTICATOR_IsOnlineServer:Boolean;
    function AUTHENTICATOR_IsServerContingency:Boolean;
    //EXPRESS
    function EXPRESS_URLBase:String;
    function EXPRESS_RESTClient: TGOXRESTConnectionEngine;
    //
    function EXPRESS_TokenBodyAuthenticate(ABodyAuth: String):Boolean;
    function EXPRESS_TokenAuthorization: String;
    function EXPRESS_IsAuthenticated:Boolean;
    function EXPRESS_IsOnlineServer:Boolean;
    function EXPRESS_IsServerContingency:Boolean;
    //DEFAULTDATA
    function DEFAULTDATA_URLBase:String;
    function DEFAULTDATA_RESTClient: TGOXRESTConnectionEngine;
    //
    function DEFAULTDATA_TokenBodyAuthenticate(ABodyAuth: String):Boolean;
    function DEFAULTDATA_TokenAuthorization: String;
    function DEFAULTDATA_IsAuthenticated:Boolean;
    function DEFAULTDATA_IsOnlineServer:Boolean;
    function DEFAULTDATA_IsServerContingency:Boolean;
  end;

implementation

//uses
//  Kernel.Server.Paths;

{ TKernelConnection }

constructor TRESTConnection.Create;
begin
  raise Exception.Create('Para Obter uma Instância de '+Self.ClassName+', use Get');
end;

constructor TRESTConnection.CreatePrivate;
Var
  LPath : String;
  LIniFileName: String;
begin
  FAUTHENTICATOR_RESTClient := TGOXRESTConnectionEngine.Create(AUTHENTICATOR_URLBase);
  FEXPRESS_RESTClient       := TGOXRESTConnectionEngine.Create(EXPRESS_URLBase);
  FDEFAULTDATA_RESTClient   := TGOXRESTConnectionEngine.Create(DEFAULTDATA_URLBase);
  //
  FAUTHENTICATOR_IsOnlineServer      := true;
  FEXPRESS_IsOnlineServer            := true;
  FDEFAULTDATA_IsOnlineServer        := true;
  FAUTHENTICATOR_IsServerContingency := false;
  FEXPRESS_IsServerContingency       := false;

end;

function TRESTConnection.DEFAULTDATA_IsAuthenticated: Boolean;
begin
  Result := FDEFAULTDATA_IsAuthenticated;
end;

function TRESTConnection.DEFAULTDATA_IsOnlineServer: Boolean;
begin
  try
    //Somente Consulta se Estiver OnLine
    if FDEFAULTDATA_IsOnlineServer then
    begin
      if DEFAULTDATA_RequestStatusOK then
      begin
        if not FDEFAULTDATA_IsServerContingency  then
        begin
          FDEFAULTDATA_IsOnlineServer := true;
          FDEFAULTDATA_IsServerContingency := false;
        end
        else
        begin
          FDEFAULTDATA_IsOnlineServer := true;
          FDEFAULTDATA_IsServerContingency := true;
        end;
      end
      else
      begin
        //Passando pela 3ºVez sai fora como Off-Line
        if FDEFAULTDATA_IsServerContingency then
        begin
          FDEFAULTDATA_IsOnlineServer := false;
          exit;
        end;
        //Configura Contigência
        FDEFAULTDATA_IsServerContingency := true;
        FDEFAULTDATA_URLBase := FDEFAULTDATA_URLBaseContingency;
        FDEFAULTDATA_RESTClient.URLBase := FDEFAULTDATA_URLBaseContingency;
        //
        //Chama Mesma Função Novamente;
        DEFAULTDATA_IsOnlineServer;
      end;
    end;
  finally
    Result := FDEFAULTDATA_IsOnlineServer;
  end;
end;

function TRESTConnection.DEFAULTDATA_IsServerContingency: Boolean;
begin
  Result := FDEFAULTDATA_IsServerContingency;
end;

function TRESTConnection.DEFAULTDATA_RequestStatusOK: Boolean;
var
  LHTTP : TGOXHttpClient;
  LResponse: String;
  LJSONObject : TJSONValue;
  {$IFDEF MSWINDOWS}
  SavCursor: TCursor;
  {$ENDIF MSWINDOWS}
begin
  try
    try
      Result := false;
      {$IFDEF MSWINDOWS}
      SavCursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      {$ENDIF MSWINDOWS}
      //Verifica Status Servidor
      LHTTP := TGOXHttpClient.Create;
      LHTTP.URLBase(DEFAULTDATA_URLBase);
      LHTTP.AddHeader('Accept','application/json');
      LHTTP.AddHeader('Content-Type','application/json');
      LResponse := LHTTP.GET('/server/status');
      //
      LJSONObject := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
      if UpperCase(LJSONObject.GetValue<String>('status')) = UpperCase('online') then
        Result := true else Result := false;
    except on E: Exception do
      begin
        Result := false;
        ShowMessage('TRESTConnection: '+E.Message);
      end;
    end;
  finally
    FreeAndNil(LJSONObject);
    FreeAndNil(LHTTP);
    {$IFDEF MSWINDOWS}
    Screen.Cursor := SavCursor;
    {$ENDIF MSWINDOWS}
  end;
end;

function TRESTConnection.DEFAULTDATA_RESTClient: TGOXRESTConnectionEngine;
begin
  //--------------
  //DEFAULTDATA
  //--------------
  //Carrega pra verificar se existe Parametros
  FDEFAULTDATA_URLBase            :=  TPARAMServer.Get.DEFAULTDATA_URLBase;
  FDEFAULTDATA_URLBaseContingency := TPARAMServer.Get.DEFAULTDATA_URLBaseContingency;
  //
  FDEFAULTDATA_RESTClient.URLBase := FDEFAULTDATA_URLBase;
  FDEFAULTDATA_RESTClient.MethodGETId := 'find';
  FDEFAULTDATA_RESTClient.MethodGETWhere := 'findwhere';
  FDEFAULTDATA_RESTClient.MethodGETWherePackage := 'findwherepackage';
  FDEFAULTDATA_RESTClient.MethodToken := 'token';
  //--------------
  Result := FDEFAULTDATA_RESTClient;
end;

function TRESTConnection.DEFAULTDATA_TokenAuthorization: String;
begin
  Result := FDEFAULTDATA_TokenAuthorization;
end;

function TRESTConnection.DEFAULTDATA_TokenBodyAuthenticate(ABodyAuth: String): Boolean;
var
  LJson: TJSONValue;
  LToken:String;
  LStatus:string;
  LResponse: String;
  LBodyAuthStream: TStringStream;
begin
  try
    FDEFAULTDATA_IsAuthenticated := false;
    FDEFAULTDATA_TokenAuthorization := '';
    try
      //Requisição...
      ITools.Http.URLBase := DEFAULTDATA_URLBase;
      ITools.Http.Headers.Clear;
      ITools.Http.Headers.Add('Accept=application/json');
      ITools.Http.Headers.Add('Content-Type=application/json');
      //
      LBodyAuthStream := TStringStream.Create(ABodyAuth);
      //
      LResponse := ITools.Http.DoRequestAsString('POST','bodyauth',LBodyAuthStream);
      //
      LJson := TJSONObject.ParseJSONValue(LResponse);
      if LJson.TryGetValue<string>('access_token',LToken) then
      begin
        if LToken.Length > 0 then
        begin
          FDEFAULTDATA_TokenAuthorization := LToken;
          FDEFAULTDATA_RESTClient.Authenticator.Token := LToken;
          FDEFAULTDATA_IsAuthenticated := True;
          //
          var LBodyAuth := TJSONObject.ParseJSONValue(ABodyAuth) as TJSONObject;
          var LTokenRequestCrypt :=  LBodyAuth.GetValue<String>('token_request');
          var LAuth :=   TJSONObject.ParseJSONValue(ITools.Encoder.Decryption(LTokenRequestCrypt)) as TJSONObject;
          FDEFAULTDATA_RESTClient.Authenticator.Username := LAuth.GetValue<String>('auth_account_user');
          FDEFAULTDATA_RESTClient.Authenticator.Password := LAuth.GetValue<String>('auth_account_password');
          FreeAndNil(LAuth);
          FreeAndNil(LBodyAuth);
        end;
      end
      else
      begin
        if LJson.TryGetValue<string>('status',LStatus) then
        begin
          case StrToInt(LStatus) of
           401 :  ShowMessage('Credenciais inválidas! '+#13+TJson.Format(LJson));
           else ShowMessage(LJson.GetValue<string>('message')+#13+TJson.Format(LJson));
          end
        end;
        FDEFAULTDATA_IsAuthenticated := false;
      end;
    except on E: Exception do
      begin
        FDEFAULTDATA_IsAuthenticated := false;
        FDEFAULTDATA_TokenAuthorization := '';
        ShowMessage('TSERVERConnection: '+E.Message);
      end;
    end;
  finally
     FreeAndNil(LJson);
     FreeAndNil(LBodyAuthStream);
  end;
  Result := FDEFAULTDATA_IsAuthenticated;
end;

function TRESTConnection.DEFAULTDATA_URLBase: String;
begin
  Result := TPARAMServer.Get.DEFAULTDATA_URLBase;
end;

destructor TRESTConnection.Destroy;
begin
  FreeAndNil(FAUTHENTICATOR_RESTClient);
  FreeAndNil(FEXPRESS_RESTClient);
  FreeAndNil(FDEFAULTDATA_RESTClient);
  inherited;
end;

function TRESTConnection.EXPRESS_TokenAuthorization: String;
begin
  Result := FEXPRESS_TokenAuthorization;
end;

function TRESTConnection.AUTHENTICATOR_TokenAuthorization: String;
begin
  Result := FAUTHENTICATOR_TokenAuthorization;
end;

function TRESTConnection.AUTHENTICATOR_TokenBodyAuthenticate(ABodyAuth: String): Boolean;
var
  LJson: TJSONValue;
  LToken:String;
  LStatus:string;
  LResponse: String;
  LBodyAuthStream: TStringStream;
begin
  try
    FAUTHENTICATOR_IsAuthenticated := false;
    FAUTHENTICATOR_TokenAuthorization := '';
    try
      //Requisição...
      ITools.Http.URLBase := AUTHENTICATOR_URLBase;
      ITools.Http.Headers.Clear;
      ITools.Http.Headers.Add('Accept=application/json');
      ITools.Http.Headers.Add('Content-Type=application/json');
      LBodyAuthStream := TStringStream.Create(ABodyAuth);
      //
      LResponse := ITools.Http.DoRequestAsString('POST','bodyauth',LBodyAuthStream);
      //
      LJson := TJSONObject.ParseJSONValue(LResponse);
      if LJson.TryGetValue<string>('access_token',LToken) then
      begin
        if LToken.Length > 0 then
        begin
          FAUTHENTICATOR_TokenAuthorization := LToken;
          FAUTHENTICATOR_RESTClient.Authenticator.Token := LToken;
          FAUTHENTICATOR_IsAuthenticated := True;
          //
          var LBodyAuth := TJSONObject.ParseJSONValue(ABodyAuth) as TJSONObject;
          var LTokenRequestCrypt :=  LBodyAuth.GetValue<String>('token_request');
          var LAuth :=   TJSONObject.ParseJSONValue(ITools.Encoder.Decryption(LTokenRequestCrypt)) as TJSONObject;
          FAUTHENTICATOR_RESTClient.Authenticator.Username := LAuth.GetValue<String>('auth_account_user');
          FAUTHENTICATOR_RESTClient.Authenticator.Password := LAuth.GetValue<String>('auth_account_password');
          FreeAndNil(LAuth);
          FreeAndNil(LBodyAuth);
        end;
      end
      else
      begin
        if LJson.TryGetValue<string>('status',LStatus) then
        begin
          case StrToInt(LStatus) of
           401 :  ShowMessage('Credenciais inválidas! '+#13+TJson.Format(LJson));
           else ShowMessage(LJson.GetValue<string>('message')+#13+TJson.Format(LJson));
          end
        end;
        FAUTHENTICATOR_IsAuthenticated := false;
      end;
    except on E: Exception do
      begin
        FAUTHENTICATOR_IsAuthenticated := false;
        FAUTHENTICATOR_TokenAuthorization := '';
        ShowMessage('TSERVERConnection: '+E.Message);
      end;
    end;
  finally
     FreeAndNil(LJson);
     FreeAndNil(LBodyAuthStream);
  end;
  Result := FAUTHENTICATOR_IsAuthenticated;
end;

function TRESTConnection.EXPRESS_URLBase: String;
begin
  Result := TPARAMServer.Get.EXPRESS_URLBase;
end;

function TRESTConnection.AUTHENTICATOR_URLBase: String;
begin
  Result := TPARAMServer.Get.AUTHENTICATOR_URLBase;
end;

class function TRESTConnection.Get: TRESTConnection;
begin
  if not Assigned(FInstance) then
    FInstance := TRESTConnection.CreatePrivate;
  Result := FInstance;
end;

function TRESTConnection.EXPRESS_TokenBodyAuthenticate(ABodyAuth: String): Boolean;
var
  LJson: TJSONValue;
  LToken:String;
  LStatus:string;
  LResponse: String;
  LBodyAuthStream: TStringStream;
begin
  try
    FEXPRESS_IsAuthenticated := false;
    FEXPRESS_TokenAuthorization := '';
    try
      //Requisição...
      ITools.Http.URLBase := EXPRESS_URLBase;
      ITools.Http.Headers.Clear;
      ITools.Http.Headers.Add('Accept=application/json');
      ITools.Http.Headers.Add('Content-Type=application/json');
      //
      LBodyAuthStream := TStringStream.Create(ABodyAuth);
      //
      LResponse := ITools.Http.DoRequestAsString('POST','bodyauth',LBodyAuthStream);
      //
      LJson := TJSONObject.ParseJSONValue(LResponse);
      if LJson.TryGetValue<string>('access_token',LToken) then
      begin
        if LToken.Length > 0 then
        begin
          FEXPRESS_TokenAuthorization := LToken;
          FEXPRESS_RESTClient.Authenticator.Token := LToken;
          FEXPRESS_IsAuthenticated := True;
          //
          var LBodyAuth := TJSONObject.ParseJSONValue(ABodyAuth) as TJSONObject;
          var LTokenRequestCrypt :=  LBodyAuth.GetValue<String>('token_request');
          var LAuth :=   TJSONObject.ParseJSONValue(ITools.Encoder.Decryption(LTokenRequestCrypt)) as TJSONObject;
          FEXPRESS_RESTClient.Authenticator.Username := LAuth.GetValue<String>('auth_account_user');
          FEXPRESS_RESTClient.Authenticator.Password := LAuth.GetValue<String>('auth_account_password');
          FreeAndNil(LAuth);
          FreeAndNil(LBodyAuth);
        end;
      end
      else
      begin
        if LJson.TryGetValue<string>('status',LStatus) then
        begin
          case StrToInt(LStatus) of
           401 :  ShowMessage('Credenciais inválidas! '+#13+TJson.Format(LJson));
           else ShowMessage(LJson.GetValue<string>('message')+#13+TJson.Format(LJson));
          end
        end;
        FEXPRESS_IsAuthenticated := false;
      end;
    except on E: Exception do
      begin
        FEXPRESS_IsAuthenticated := false;
        FEXPRESS_TokenAuthorization := '';
        ShowMessage('TSERVERConnection: '+E.Message);
      end;
    end;
  finally
     FreeAndNil(LJson);
     FreeAndNil(LBodyAuthStream);
  end;
  Result := FEXPRESS_IsAuthenticated;
end;

function TRESTConnection.EXPRESS_IsAuthenticated: Boolean;
begin
  Result := FEXPRESS_IsAuthenticated;
end;

function TRESTConnection.EXPRESS_IsOnlineServer: Boolean;
begin
  try
    //Somente Consulta se Estiver OnLine
    if FEXPRESS_IsOnlineServer then
    begin
      if EXPRESS_RequestStatusOK then
      begin
        if not FEXPRESS_IsServerContingency  then
        begin
          FEXPRESS_IsOnlineServer := true;
          FEXPRESS_IsServerContingency := false;
        end
        else
        begin
          FEXPRESS_IsOnlineServer := true;
          FEXPRESS_IsServerContingency := true;
        end;
      end
      else
      begin
        //Passando pela 3ºVez sai fora como Off-Line
        if FEXPRESS_IsServerContingency then
        begin
          FEXPRESS_IsOnlineServer := false;
          exit;
        end;
        //Configura Contigência
        FEXPRESS_IsServerContingency := true;
        FEXPRESS_URLBase := FEXPRESS_URLBaseContingency;
        FEXPRESS_RESTClient.URLBase := FEXPRESS_URLBaseContingency;
        //
        //Chama Mesma Função Novamente;
        EXPRESS_IsOnlineServer;
      end;
    end;
  finally
    Result := FEXPRESS_IsOnlineServer;
  end;
end;

function TRESTConnection.EXPRESS_IsServerContingency: Boolean;
begin
  Result := FEXPRESS_IsServerContingency;
end;

function TRESTConnection.EXPRESS_RequestStatusOK: Boolean;
var
  LResponse: String;
  {$IFDEF MSWINDOWS}
  SavCursor: TCursor;
  {$ENDIF MSWINDOWS}
begin
//  try
//    try
//      {$IFDEF MSWINDOWS}
//      SavCursor := Screen.Cursor;
//      Screen.Cursor := crHourGlass;
//      {$ENDIF MSWINDOWS}
//      //Verifica Status Servidor
//      ITools.Http.URLBase := EXPRESS_URLBase;
//      ITools.Http.Headers.Clear;
//      ITools.Http.Headers.Add('Accept=application/json');
//      ITools.Http.Headers.Add('Content-Type=application/json');
//      ITools.Http.DoRequest('GET','server/status',LResponse);
//      //
//      if LowerCase(LResponse) = LowerCase('online') then
//        Result := true else Result := false;
//    except on E: Exception do
//      begin
//        Result := false;
//        TLogTxt.Get.AddLog('TRESTConnection: '+E.Message);
//      end;
//    end;
//  finally
//    {$IFDEF MSWINDOWS}
//    Screen.Cursor := SavCursor;
//    {$ENDIF MSWINDOWS}
//  end;
end;

function TRESTConnection.EXPRESS_RESTClient: TGOXRESTConnectionEngine;
begin
  //--------------
  //EXPRESS
  //--------------
  //Carrega pra verificar se existe Parametros
  FEXPRESS_URLBase            := TPARAMServer.Get.EXPRESS_URLBase;
  FEXPRESS_URLBaseContingency := TPARAMServer.Get.EXPRESS_URLBaseContingency;
  //
  // AUTHENTICATOR
//  var URI_EXPRESS := TIdURI.Create(FAUTHENTICATOR_URLBase);
//  If UpperCase(URI_EXPRESS.Protocol) = 'HTTP' then
//  FEXPRESS_RESTClient.Protocol := Http else FAUTHENTICATOR_RESTClient.Protocol := Https;
    FEXPRESS_RESTClient.URLBase := FEXPRESS_URLBase;
//  FEXPRESS_RESTClient.RESTContext:= Copy(URI_EXPRESS.Path,2,URI_EXPRESS.Path.Length-2);
//  FEXPRESS_RESTClient.APIContext := Copy(URI_EXPRESS.Document,1,URI_EXPRESS.Document.Length);
//  FEXPRESS_RESTClient.Port :=  StrToIntDef(URI_EXPRESS.Port,-9999);
  FEXPRESS_RESTClient.MethodGETId := 'find';
  FEXPRESS_RESTClient.MethodGETWhere := 'findwhere';
  FEXPRESS_RESTClient.MethodGETWherePackage := 'findwherepackage';
  FEXPRESS_RESTClient.MethodToken := 'token';
  //FEXPRESS_RESTClient.AfterCommand := OnAUTHENTICATOR_RESTClientWiRLAfterCommand;
//  URI_EXPRESS.Free;
  //--------------
  Result := FEXPRESS_RESTClient;
end;

function TRESTConnection.AUTHENTICATOR_IsAuthenticated: Boolean;
begin
  Result := FAUTHENTICATOR_IsAuthenticated;
end;

function TRESTConnection.AUTHENTICATOR_IsOnlineServer: Boolean;
begin
   Result := true;
   exit;
  try
    //Somente Consulta se Estiver OnLine
    if FAUTHENTICATOR_IsOnlineServer then
    begin
      if AUTHENTICATOR_RequestStatusOK then
      begin
        if not FAUTHENTICATOR_IsServerContingency  then
        begin
          FAUTHENTICATOR_IsOnlineServer := true;
          FAUTHENTICATOR_IsServerContingency := false;
        end
        else
        begin
          FAUTHENTICATOR_IsOnlineServer := true;
          FAUTHENTICATOR_IsServerContingency := true;
        end;
      end
      else
      begin
        //Passando pela 3ºVez sai fora como Off-Line
        if FAUTHENTICATOR_IsServerContingency then
        begin
          FAUTHENTICATOR_IsOnlineServer := false;
          exit;
        end;
        //Configura Contigência
        FAUTHENTICATOR_IsServerContingency := true;
        FAUTHENTICATOR_URLBase := FAUTHENTICATOR_URLBaseContingency;
        FAUTHENTICATOR_RESTClient.URLBase := FAUTHENTICATOR_URLBaseContingency;
        //
        //Chama Mesma Função Novamente;
        AUTHENTICATOR_IsOnlineServer;
      end;
    end;
  finally
    Result := FAUTHENTICATOR_IsOnlineServer;
  end;
end;

function TRESTConnection.AUTHENTICATOR_IsServerContingency: Boolean;
begin
  Result := FAUTHENTICATOR_IsServerContingency;
end;

function TRESTConnection.AUTHENTICATOR_RequestStatusOK:Boolean;
var
  LResponse: String;
  {$IFDEF MSWINDOWS}
  SavCursor: TCursor;
  {$ENDIF MSWINDOWS}
begin
//  try
//    try
//      {$IFDEF MSWINDOWS}
//      SavCursor := Screen.Cursor;
//      Screen.Cursor := crHourGlass;
//      {$ENDIF MSWINDOWS}
//      //Verifica Status Servidor
//      LResponse := FAUTHENTICATOR_RESTClient
//                   .WiRLClientApp
//                    .Resource(AUTHENTICATOR_URLBase+'/server/status')
//                     .Accept('application/json')
//                      .ContentType('application/json')
//                       .Get<String>;
//
////      ITools.Http.URLBase := AUTHENTICATOR_URLBase;
////      ITools.Http.Headers.Clear;
////      ITools.Http.Headers.Add('Accept=application/json');
////      ITools.Http.Headers.Add('Content-Type=application/json');
////      ITools.Http.DoRequest('GET','server/status',LResponse);
//      //
//      if LowerCase(LResponse) = LowerCase('online') then
//        Result := true else Result := false;
//    except on E: Exception do
//      begin
//        Result := false;
//        TLogTxt.Get.AddLog('TRESTConnection: '+E.Message);
//      end;
//    end;
//  finally
//    {$IFDEF MSWINDOWS}
//    Screen.Cursor := SavCursor;
//    {$ENDIF MSWINDOWS}
//  end;
end;

function TRESTConnection.AUTHENTICATOR_RESTClient: TGOXRESTConnectionEngine;
begin
  //Carrega pra verificar se existe Parametros
  FAUTHENTICATOR_URLBase            := TPARAMServer.Get.AUTHENTICATOR_URLBase;
  FAUTHENTICATOR_URLBaseContingency := TPARAMServer.Get.AUTHENTICATOR_URLBaseContingency;
  //
  // AUTHENTICATOR
//  var URI_AUTHENTICATOR := TIdURI.Create(FAUTHENTICATOR_URLBase);
//  If UpperCase(URI_AUTHENTICATOR.Protocol) = 'HTTP' then
//  FAUTHENTICATOR_RESTClient.Protocol := Http else FAUTHENTICATOR_RESTClient.Protocol := Https;
  FAUTHENTICATOR_RESTClient.URLBase := FAUTHENTICATOR_URLBase;
//  FAUTHENTICATOR_RESTClient.RESTContext:= Copy(URI_AUTHENTICATOR.Path,2,URI_AUTHENTICATOR.Path.Length-2);
//  FAUTHENTICATOR_RESTClient.APIContext := Copy(URI_AUTHENTICATOR.Document,1,URI_AUTHENTICATOR.Document.Length);
//  FAUTHENTICATOR_RESTClient.Port :=  StrToIntDef(URI_AUTHENTICATOR.Port,-9999);
  FAUTHENTICATOR_RESTClient.MethodGETId := 'find';
  FAUTHENTICATOR_RESTClient.MethodGETWhere := 'findwhere';
  FAUTHENTICATOR_RESTClient.MethodGETWherePackage := 'findwherepackage';
  FAUTHENTICATOR_RESTClient.MethodToken := 'token';
  //FAUTHENTICATOR_RESTClient.AfterCommand := OnAUTHENTICATOR_RESTClientWiRLAfterCommand;
//  URI_AUTHENTICATOR.Free;
  //--------------
  Result := FAUTHENTICATOR_RESTClient;
end;



initialization
finalization
   if Assigned(TRESTConnection.FInstance) then
    FreeAndNil(TRESTConnection.FInstance);
end.
