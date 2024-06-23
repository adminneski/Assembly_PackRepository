{******************************************************************************}
{                                  GOXORMBr                                    }
{                                                                              }
{  Um ORM simples que simplifica a persistência de dados, oferecendo           }
{  funcionalidades para mapear tabelas de banco de dados como objetos          }
{  relacionais, facilitando a manipulação e a gestão de dados.                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo no repositório abaixo         }
{  https://github.com/jeicksongobeti/goxormbr                                  }
{                                                                              }
{******************************************************************************}
{                   Copyright (c) 2016, Isaque Pinheiro                        }
{                            All rights reserved.                              }
{                                                                              }
{                   Copyright (c) 2020, Jeickson Gobeti                        }
{                          All Modifications Reserved.                         }
{                                                                              }
{                    GNU Lesser General Public License                         }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{       Jeickson Gobeti - jeickson.gobeti@gmail.com - www.goxcode.com.br       }
{                                                                              }
{******************************************************************************}

unit goxormbr.engine.restconnection.wirl;

interface

uses
  DB,
  SysUtils,
  StrUtils,
  Classes,
  System.JSON,
 //WiRL
  WiRL.Client.CustomResource,
  WiRL.Client.Resource,
  WiRL.Client.Application,
  WiRL.http.Client,
  WiRL.http.Client.Indy,
  WiRL.http.Request,
  WiRL.http.Response,
  WiRL.http.Accept.MediaType,
  WiRL.Core.MessageBody.Default,
  WiRL.Core.Classes,
  WiRL.Core.Utils,
  //GOXORM
  goxormbr.core.types,
  goxormbr.core.rest.request, IdURI, IdUriUtils, WiRL.Core.JSON, goxormbr.core.json.utils;

type

  ERESTConnectionError = class(Exception)
  public
    constructor Create(const AURL, AResource, ASubResource, AMethodType, AMessage: String; const AStatusCode: Integer); overload;
  end;

  TGOXRESTConnectionWiRL = class(TGOXRESTConnection)
  private
    FRESTClient: TWiRLClient;
    FRESTClientApp: TWiRLClientApplication;
    FRESTClientResource: TWiRLClientResource;
    FURLBase: String;
    //
    function GetErrorCommand: TErrorCommandEvent; override;
    procedure SetErrorCommand(const Value: TErrorCommandEvent); override;
    procedure SetURLBase(const Value: String);
  protected
    procedure SetProxyParamsClient;
  public
    constructor Create(const AURLBase:String = '');
    destructor Destroy; override;
    procedure SetToken(AToken:String);
    //
    procedure AddPathParam(const AValue: String); override;
    procedure AddQueryParam(const AKeyName:String; const AValue: String); override;
    procedure AddBodyParam(AValue: String); override;
     //
    function Execute(const AResource, ASubResource: String; const ARequestMethod: TRESTRequestMethodType; const AParams: String = ''): String; override;

    function GET(const AResource: String): String;
    function POST(const AResource: String; ARequestEntity:String): String;
    function PUT(const AResource: String; ARequestEntity:String): String;
    //
    property URLBase: String   read FURLBase write SetURLBase;
  end;

implementation

{ TGOXRESTConnectionWiRL }

constructor TGOXRESTConnectionWiRL.Create(const AURLBase:String);
var
  LURI : TIdURI;
begin
  FURLBase := AURLBase;
  FProxyParams := TRestProxyInfo.Create;
  FAuthenticator := TRESTAuthenticator.Create;
  FResponseInfo := TRESTResponseInfo.Create;
  //
  FPathParams := TParams.Create(nil);
  FBodyParams := TParams.Create(nil);
  FQueryParams := TParams.Create(nil);
  //WiRL
  FRESTClient := TWiRLClient.Create(nil);
  FRESTClient.ClientVendor := 'TIdHttp (Indy)';
  //
  FRESTClientApp := TWiRLClientApplication.Create(nil);
  FRESTClientApp.Client := FRESTClient;
  FRESTClientApp.DefaultMediaType := TMediaType.APPLICATION_JSON;
  //
  FRESTClientResource := TWiRLClientResource.Create(nil);
  FRESTClientResource.Application := FRESTClientApp;
  //
  //Correção de acentuçao
  FRESTClientResource.Headers.ContentType := TMediaType.APPLICATION_JSON+TMediaType.WITH_CHARSET_UTF8;
  //
  //Tratar URLBase
  if AURLBase.Length > 0 then
  begin
    LURI := TIdURI.Create(FURLBase);
    var RevString     :=  Copy(ReverseString(LURI.GetFullURI),Pos('/',ReverseString(LURI.GetFullURI))+1,Length(ReverseString(LURI.GetFullURI)));
    var AnsiRevString :=  AnsiReverseString(RevString);
    FRESTClient.WiRLEngineURL := AnsiRevString ;
    FRESTClientApp.AppName := LURI.Document;
    //
    FProtocol := LURI.Protocol;
    FHost := LURI.Host;
    FPort := LURI.Port;
    LURI.Free;
  end;
end;

destructor TGOXRESTConnectionWiRL.Destroy;
begin
  FProxyParams.Free;
  FAuthenticator.Free;
  FResponseInfo.Free;
  //
  FPathParams.Clear;
  FPathParams.Free;
  FBodyParams.Clear;
  FBodyParams.Free;
  FQueryParams.Clear;
  FQueryParams.Free;
  //
  FRESTClientResource.Free;
  FRESTClientApp.Free;
  FRESTClient.Free;
  inherited;
end;

function TGOXRESTConnectionWiRL.Execute(const AResource, ASubResource: String; const ARequestMethod: TRESTRequestMethodType; const AParams: String): String;
var
  LRequest : TGOXRESTRequestEngine;
  LFor: Integer;
  LResource : String;
  LValueParams:String;
begin
  try
    Result := '';
    LRequest := TGOXRESTRequestEngine.Create;
    //
    //Define dados do proxy
    SetProxyParamsClient;

    //Full Resource
    LResource := IfThen(ASubResource.Length > 0,AResource+'/'+ASubResource,AResource);
    //
    if FAuthenticator.Token.Length > 0 then
      FRESTClientResource.Headers.Authorization :=  FAuthenticator.Token;
    //DoBeforeCommand;
    //
    case ARequestMethod of
      // POST
      TRESTRequestMethodType.rtPOST:
        begin
          FRequestMethod := 'POST';
          if FBodyParams.Count > 0 then
            LValueParams := FBodyParams.ParamValues['body'] else LValueParams := AParams;
          //
//          if (LValueParams.Length = 0) then
//            raise Exception.Create('Não foi passado o parâmetro com os dados do insert!');
          //
          FRESTClientResource.Resource := LResource;
          FResponseString := FRESTClientResource.Post<String,String>(LValueParams);
          Result := FResponseString;
        end;

      // PUT
      TRESTRequestMethodType.rtPUT:
        begin
          FRequestMethod := 'PUT';
          if FBodyParams.Count > 0 then
            LValueParams := FBodyParams.ParamValues['body'] else LValueParams := AParams;
          //
//          if (LValueParams.Length = 0) then
//            raise Exception.Create('Não foi passado o parâmetro com os dados do update!');
          //
          // Query Params - {Query Param Add por Jeickson no PUT}
          for LFor := 0 to FQueryParams.Count -1 do
            FRESTClientResource.QueryParams.Add(FQueryParams.Items[LFor].AsString);
          //
          FRESTClientResource.Resource := LResource;
          FResponseString := FRESTClientResource.Put<String,String>(LValueParams);
          Result := FResponseString;
        end;

      //GET
      TRESTRequestMethodType.rtGET:
        begin
          FRequestMethod := 'GET';
          //Path Params
          for LFor := 0 to FPathParams.Count -1 do
            LResource := LResource +'/'+FPathParams.Items[LFor].AsString;
          //Query Params
          for LFor := 0 to FQueryParams.Count -1 do
            FRESTClientResource.QueryParams.Add(FQueryParams.Items[LFor].AsString);
          //
          FRESTClientResource.Resource := LResource;
          FResponseString := FRESTClientResource.Get<string>;
          Result := FResponseString;
        end;

      //DELETE
      TRESTRequestMethodType.rtDELETE:
        begin
          FRequestMethod := 'DELETE';
          //PathParams
          for LFor := 0 to FPathParams.Count -1 do
            LResource := LResource +'/'+FPathParams.Items[LFor].AsString;
          //Query Params
          for LFor := 0 to FQueryParams.Count -1 do
            FRESTClientResource.QueryParams.Add(FQueryParams.Items[LFor].AsString);
          //
          FRESTClientResource.Resource := LResource;
          FResponseString := FRESTClientResource.Delete<String>;
          Result := FResponseString;
        end;
      //PATCH
      TRESTRequestMethodType.rtPATCH: ;
    end;
    //DoAfterCommand
    //
    //Tratar Response
    FResponseInfo.Status           := 0;
    FResponseInfo.StatusType       := '';
    FResponseInfo.Message          := '';
    FResponseInfo.UnitName         := '';
    FResponseInfo.ClassName        := '';
    FResponseInfo.FunctionName     := '';
    FResponseInfo.ExceptionMessage := '';
    FResponseInfo.PackageCount     := 0;
    FResponseInfo.JSONResponse     := '';
    FResponseInfo.Data             := '';
    //Processa Resposta
    Result := LRequest.Response.Process(FResponseString);
    //Carrega classe response
    FResponseInfo.Status           := LRequest.Response.Status;
    FResponseInfo.StatusType       := LRequest.Response.StatusType;
    FResponseInfo.Message          := LRequest.Response.Message;
    FResponseInfo.UnitName         := LRequest.Response.UnitName;
    FResponseInfo.ClassName        := LRequest.Response.ClassName;
    FResponseInfo.FunctionName     := LRequest.Response.FunctionName;
    FResponseInfo.ExceptionMessage := LRequest.Response.ExceptionMessage;
    FResponseInfo.PackageCount     := LRequest.Response.PackageCount;
    //Tratamento formatar Json
    var JSONValue : TJSONValue;
    JSONValue := TJSONObject.ParseJSONValue(LRequest.Response.JSONResponse);
    FResponseInfo.JSONResponse  := TGOXJson.Print(JSONValue,true);
    FreeAndNil(JSONValue);
    //
    FResponseInfo.Data             := LRequest.Response.Data;
  finally
    FRESTClientResource.QueryParams.Clear;
    FRESTClientResource.PathParams.Clear;
    LResource := '';
    FResponseString := '';
    FPathParams.Clear;
    FQueryParams.Clear;
    FBodyParams.Clear;
    FreeAndNil(LRequest);
  end;
end;

procedure TGOXRESTConnectionWiRL.AddBodyParam(AValue: String);
begin
  with FBodyParams.Add as TParam do
  begin
    Name := 'body';
    DataType := ftString;
    ParamType := ptInput;
    Value := AValue;
  end;
end;

procedure TGOXRESTConnectionWiRL.AddPathParam(const AValue: String);
begin
  with FPathParams.Add as TParam do
  begin
    Name := 'param_' + IntToStr(FPathParams.Count -1);
    DataType := ftString;
    ParamType := ptInput;
    Value := AValue;
  end;
end;

procedure TGOXRESTConnectionWiRL.AddQueryParam(const AKeyName, AValue: String);
begin
  with FQueryParams.Add as TParam do
  begin
    Name := 'param_' + IntToStr(FQueryParams.Count -1);
    DataType := ftString;
    ParamType := ptInput;
    Value := AKeyName+'='+AValue;
  end;
end;

function TGOXRESTConnectionWiRL.GET(const AResource: String): String;
var
  LRequest : TGOXRESTRequestEngine;
  LFor: Integer;
  LResource : String;
  LValueParams:String;
begin
  try
    Result := '';
    LRequest := TGOXRESTRequestEngine.Create;
    //Define dados do proxy
    SetProxyParamsClient;
    //
    //Define Autorização Token
    FRESTClientResource.Headers.Authorization :=  FAuthenticator.Token;
    //
    FRequestMethod := 'GET';
    //Path Params
    if FPathParams.Count > 0 then
    begin
      for LFor := 0 to FPathParams.Count -1 do
       LResource := LResource +'/'+FPathParams.Items[LFor].AsString;
    end
    else if FQueryParams.Count > 0 then
    begin
      //Query Params
      for LFor := 0 to FQueryParams.Count -1 do
        FRESTClientResource.QueryParams.Add(FQueryParams.Items[LFor].AsString);
    end;
    FRESTClientResource.Resource := LResource;
    FResponseString := FRESTClientResource.Get<String>;
  finally
     Result := FResponseString;
  end;
end;

function TGOXRESTConnectionWiRL.GetErrorCommand: TErrorCommandEvent;
begin
  Result := FErrorCommand;
end;

function TGOXRESTConnectionWiRL.POST(const AResource: String; ARequestEntity:String): String;
var
  LRequest : TGOXRESTRequestEngine;
  LFor: Integer;
  LResource : String;
  LValueParams:String;
begin
  try
    Result := '';
    LRequest := TGOXRESTRequestEngine.Create;
    //Define dados do proxy
    SetProxyParamsClient;
    //
    //Correção de acentuçao
    FRESTClientResource.Headers.Authorization :=  FAuthenticator.Token;
    //Define Autorização Token
//    FRESTClientResource.Headers.Authorization := TBearerAuth.Create(FAuthenticator.Token);
    //
    FRequestMethod := 'POST';
    //Path Params
    if FPathParams.Count > 0 then
    begin
      for LFor := 0 to FPathParams.Count -1 do
       LResource := LResource +'/'+FPathParams.Items[LFor].AsString;
    end
    else if FQueryParams.Count > 0 then
    begin
      //Query Params
      for LFor := 0 to FQueryParams.Count -1 do
        FRESTClientResource.QueryParams.Add(FQueryParams.Items[LFor].AsString);
    end;
    //
    FRESTClientResource.Resource := LResource;
    FResponseString := FRESTClientResource.Post<String,String>(ARequestEntity);
  finally
     Result := FResponseString;
  end;

end;

function TGOXRESTConnectionWiRL.PUT(const AResource: String; ARequestEntity: String): String;
var
  LRequest : TGOXRESTRequestEngine;
  LFor: Integer;
  LResource : String;
  LValueParams:String;
begin
  try
    Result := '';
    LRequest := TGOXRESTRequestEngine.Create;
    //Define dados do proxy
    SetProxyParamsClient;
    //
    //Correção de acentuçao
    FRESTClientResource.Headers.Authorization :=  FAuthenticator.Token;
    //Define Autorização Token
//    FRESTClientResource.Headers.Authorization := TBearerAuth.Create(FAuthenticator.Token);
    //
    FRequestMethod := 'PUT';
    //Path Params
    if FPathParams.Count > 0 then
    begin
      for LFor := 0 to FPathParams.Count -1 do
       LResource := LResource +'/'+FPathParams.Items[LFor].AsString;
    end
    else if FQueryParams.Count > 0 then
    begin
      //Query Params
      for LFor := 0 to FQueryParams.Count -1 do
        FRESTClientResource.QueryParams.Add(FQueryParams.Items[LFor].AsString);
    end;
    //
    FRESTClientResource.Resource := LResource;
    FResponseString := FRESTClientResource.Put<String,String>(ARequestEntity);
  finally
     Result := FResponseString;
  end;
end;

procedure TGOXRESTConnectionWiRL.SetErrorCommand(const Value: TErrorCommandEvent);
begin
  FErrorCommand := Value;
end;

procedure TGOXRESTConnectionWiRL.SetProxyParamsClient;
begin
  FRESTClient.ProxyParams.ProxyServer         := FProxyParams.ProxyServer;
  FRESTClient.ProxyParams.ProxyPort           := FProxyParams.ProxyPort;
  FRESTClient.ProxyParams.ProxyUsername       := FProxyParams.ProxyUsername;
  FRESTClient.ProxyParams.ProxyPassword       := FProxyParams.ProxyPassword;
end;

procedure TGOXRESTConnectionWiRL.SetToken(AToken: String);
begin
  //Define Autorização Token
  FAuthenticator.Token := AToken;
end;

procedure TGOXRESTConnectionWiRL.SetURLBase(const Value: String);
var
  LURI : TIdURI;
begin
  FURLBase := Value;
  //
  //Tratar URLBase
  if FURLBase.Length > 0 then
  begin
    LURI := TIdURI.Create(FURLBase);
    var RevString     :=  Copy(ReverseString(LURI.GetFullURI),Pos('/',ReverseString(LURI.GetFullURI))+1,Length(ReverseString(LURI.GetFullURI)));
    var AnsiRevString :=  AnsiReverseString(RevString);
    FRESTClient.WiRLEngineURL := AnsiRevString ;
    FRESTClientApp.AppName := LURI.Document;
    //
    FProtocol := LURI.Protocol;
    FHost := LURI.Host;
    FPort := LURI.Port;
    LURI.Free;
  end;
end;

{ ERESTConnectionError }

constructor ERESTConnectionError.Create(const AURL, AResource, ASubResource, AMethodType, AMessage: String; const AStatusCode: Integer);
var
  LMessage: String;
begin
  LMessage := 'URL : '         + AURL         + sLineBreak +
              'Resource : '    + AResource    + sLineBreak +
              'SubResource : ' + ASubResource + sLineBreak +
              'Method : '      + AMethodType  + sLineBreak +
              'Message : '     + AMessage     + sLineBreak +
              'Status Code : ' + IntToStr(AStatusCode);
  inherited Create(LMessage);
end;

end.
