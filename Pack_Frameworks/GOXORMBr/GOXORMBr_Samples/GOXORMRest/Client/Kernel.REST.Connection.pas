unit Kernel.REST.Connection;

interface

uses
  System.IOUtils,
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.Net.HttpClient,
  Data.DB,
  System.JSON,
  goxormbr.core.types,
  goxormbr.engine.connection;


type
  TRESTConnection = class
    private
    { Private declarations }
    FGOXRESTClient: TGOXRESTConnection;
    FTokenAuthorization : String;
    FURLProtocol:String;
    FURLHost:String;
    FURLPort : String;
    FRESTContext: String;
    FAPIContext: String;
    FIsAuthenticated:Boolean;
    //
    procedure OnRESTClientWiRLAfterCommand(AStatusCode: Integer; var AResponseString: string; ARequestMethod: string);
    //
    class var fInstance : TRESTConnection;
    constructor CreatePrivate;
    //
    const Port_RESTServer = 8080;


  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    class function Get: TRESTConnection;
          function URLBase:String;
          function GOXRESTClient: TGOXRESTConnection;
    end;

implementation


{ TKernelConnection }

constructor TRESTConnection.Create;
begin
  raise Exception.Create('Para Obter uma Instância de '+Self.ClassName+', use Get');
end;

constructor TRESTConnection.CreatePrivate;
begin
  FGOXRESTClient    := TGOXRESTConnectionEngine.Create;
  //
  FURLProtocol  := 'HTTP';
  FURLHost      := 'LOCALHOST';
  FURLPort      := '8080';
  FRESTContext   := 'rest';
  FAPIContext   := 'api';
  //

  FGOXRESTClient.MethodGETId := 'find';
  FGOXRESTClient.MethodGETWhere := 'where';

  FGOXRESTClient.SetHost(FURLHost);
  FGOXRESTClient.SetRESTContext(FRESTContext);
  FGOXRESTClient.SetAPIContext(FAPIContext);
  FGOXRESTClient.SetPort(StrToIntDef(FURLPort,Port_RESTServer));
  FGOXRESTClient.AfterCommand := OnRESTClientWiRLAfterCommand;
end;

destructor TRESTConnection.Destroy;
begin
  FreeAndNil(FGOXRESTClient);
  inherited;
end;


function TRESTConnection.URLBase: String;
begin
  FGOXRESTClient.GetURLBase;
end;

class function TRESTConnection.Get: TRESTConnection;
begin
  if not Assigned(FInstance) then
    FInstance := TRESTConnection.CreatePrivate;
  Result := FInstance;
end;


function TRESTConnection.GOXRESTClient: TGOXRESTConnection;
begin
  Result := FGOXRESTClient;
end;

procedure TRESTConnection.OnRESTClientWiRLAfterCommand(AStatusCode: Integer;
  var AResponseString: string; ARequestMethod: string);
Var
  LJSONException: TJSONObject;
begin
  {$IFDEF MSWINDOWS}
    AResponseString :=  UTF8ToUnicodeString(AResponseString);

    //Verifica se veio Null
    if AResponseString = '[null]' then
    begin
       AResponseString := 'null';
    end
    else
    //Verifica se Houve Warning no Retorno
    if Copy(AResponseString,1,11) = '{"warning":' then
    begin
       AResponseString := '[]';
    end
    else
    //Verifica se Houve Exception no Retorno
    if Copy(AResponseString,1,13) = '{"exception":' then
    begin
      LJSONException := TJSONObject.ParseJSONValue(AResponseString) as TJSONObject;
      try
        if LJSONException <> nil then
        Begin
          raise Exception.Create(LJSONException.ToJSON);
        end;
      finally
        if LJSONException <> nil then
          LJSONException.Free;
      end;
    end;

  {$ENDIF}

  {$IFDEF ANDROID}
     AResponseString :=  UTF8ToUnicodeString(AResponseString);

    //Verifica se veio Null
    if AResponseString = '[null]' then
    begin
       AResponseString := 'null';
    end
    else
    //Verifica se Houve Warning no Retorno
    if Copy(AResponseString,1,11) = '{"warning":' then
    begin
       AResponseString := '[]';
    end
    else
    //Verifica se Houve Exception no Retorno
    if Copy(AResponseString,1,13) = '{"exception":' then
    begin
      AResponseString := '[]';
//      LJSONException := ITools.JSON.JSONStringToJSONObject(AResponseString);
//      try
//        if LJSONException <> nil then
//        Begin
//          raise Exception.Create(LJSONException.ToJSON);
//        end;
//      finally
//        if LJSONException <> nil then  LJSONException.Free;
//      end;
    end;
 {$ENDIF}

end;

initialization
finalization
   if Assigned(TRESTConnection.FInstance) then
    FreeAndNil(TRESTConnection.FInstance);
end.
