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

unit goxormbr.core.rest.request;

interface

uses
  DB,
  Rtti,
  TypInfo,
  Classes,
  Variants,
  SysUtils,
  StrUtils,
  Generics.Collections,
  System.JSON,
  goxormbr.core.json.utils,
  goxormbr.core.types;

type

  TResponse<M: class, constructor> = record
   private
     Status      :Integer;
     StatusType  :String;
     &Message    :String;
     UnitName    :String;
     ClassName   :String;
     FunctionName:String;
     ExceptionMessage:String;
     PackageCount:Integer;
     Data: M;
  end;


  TResponse = Class
  private
    FStatus      :Integer;
    FStatusType  :String;
    FMessage     :String;
    FUnitName    :String;
    FClassName   :String;
    FFunctionName:String;
    FExceptionMessage:String;
    FPackageCount:Integer;
    FData:String;
    FJSONResponse : String;

    //
    FParamsList  : TDictionary<String,String>;
    FResponseResult: String;
  public
    constructor Create;
    destructor Destroy; override;
    function Process(AResponse:String):String;

    //
    function Send(AStatus:Integer = 200):TResponse; overload;
    function Send(AValue:String; AStatus:Integer = 200):TResponse; overload;
    function Send(AValue:TObject; AStatus:Integer = 200):TResponse; overload;
    function Send(APackageCount:Integer; AValue:TObject; AStatus:Integer = 200):TResponse; overload;

    function SendMessage(AMessage:String; AStatus:Integer = 400):TResponse;
    function SendException(AMessage:String; AFunctionName:String; AExcept:Exception; AObject:TObject): TResponse;

    function SendHtml(AValue:String; AStatus:Integer = 200):TResponse; overload;
    //
    function AddParamResponse(AKey:String;AValue:String; AStatus:Integer = 200):TResponse;
    function ToJSONParamsResponse:String;
    //
    procedure ReturnResponse(out AResult:String); overload;
    //
    property Status: Integer read FStatus write FStatus;
    property StatusType: String read FStatusType write FStatusType;
    property &Message: String read FMessage write FMessage;
    property UnitName: String read FUnitName write FUnitName;
    property ClassName: String read FClassName write FClassName;
    property FunctionName: String read FFunctionName write FFunctionName;
    property ExceptionMessage: String read FExceptionMessage write FExceptionMessage;
    property PackageCount: Integer read FPackageCount write FPackageCount;
    property JSONResponse: String read FJSONResponse write FJSONResponse;
    property Data: String read FData write FData;
  end;
  //
  TGOXRESTRequestEngine = Class
  private
    FResponse : TResponse;
  public
    constructor Create;
    destructor Destroy; override;
    //
    function Process<T: class, constructor>(const AJSONRequest: String): T; overload;
    function Process<T: class, constructor>(const AJSONRequest: TJSONValue): T; overload;
    function Response:TResponse;
  End;

implementation

{ TResponse }
function TResponse.AddParamResponse(AKey, AValue: String; AStatus: Integer): TResponse;
var
  LJSONObjStr:String;
  LJSONValue : TJSONValue;
  LJSONObject : TJSONObject;
  LJSONArray: TJSONArray;
begin
  Result := Self;
  FParamsList.Add(AKey,AValue);
end;

function TResponse.Send(AValue: String; AStatus: Integer): TResponse;
var
  LJSONResponse : TJSONObject;
  LJSONValue : TJSONValue;
begin
  Result := Self;
  FStatus := AStatus;
  //
  if AValue.Length > 0 then
    LJSONValue := TJSONObject.ParseJSONValue(AValue)
  else
    LJSONValue := TJSONArray.Create(TJSONNull.Create);
  //
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status',AStatus.ToString);
  LJSONResponse.AddPair('statustype','success');
  LJSONResponse.AddPair('message','Requisição Executada com Sucesso!');
  LJSONResponse.AddPair('packagecount','0');
  LJSONResponse.AddPair('data',LJSONValue);
  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);
end;

constructor TResponse.Create;
begin
  FParamsList := TDictionary<String,String>.Create;
  FStatus := 200;
end;

destructor TResponse.Destroy;
begin
  FParamsList.Clear;
  FreeAndNil(FParamsList);
  inherited;
end;

function TResponse.Send(AValue: TObject; AStatus: Integer): TResponse;
var
  LJSONResponse : TJSONObject;
  LJSONValue : TJSONValue;
begin
  Result := Self;
  FStatus := AStatus;

  if not Assigned(AValue) then
    raise Exception.Create('Error Response Object Nil');
  //
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status',AStatus.ToString);
  LJSONResponse.AddPair('statustype','success');
  LJSONResponse.AddPair('message','Requisição Executada com Sucesso!');
  LJSONResponse.AddPair('packagecount','0');
  LJSONResponse.AddPair('data',TGOXJson.ObjectToJSON(AValue));
  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);
end;

function TResponse.Send(AStatus: Integer): TResponse;
var
  LJSONResponse : TJSONObject;
begin
  Result := Self;
  //
  FStatus := AStatus;
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status',AStatus.ToString);
  LJSONResponse.AddPair('statustype','success');
  LJSONResponse.AddPair('message','Requisição Executada com Sucesso!');
  LJSONResponse.AddPair('packagecount','0');
  LJSONResponse.AddPair('data','{}');

  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);
end;

function TResponse.Process(AResponse: String): String;
var
  LJSONResponse: TJSONObject;
  LJSONPair    : TJSONPair;
  LJSONPairWiRL: TJSONPair;
  LJSONPairPackage : TJSONPair;
begin
  try
    //Zera Variaveis
    FStatus           := 0;
    FStatusType       := '';
    FMessage          := '';
    FUnitName         := '';
    FClassName        := '';
    FFunctionName     := '';
    FExceptionMessage := '';
    FPackageCount     := 0;
    FData             := '';
    //
    LJSONResponse := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
    if LJSONResponse <> nil then
    begin
      FJSONResponse := LJSONResponse.ToJSON;
      //
      LJSONPair :=  (LJSONResponse as TJSONObject).Get('statustype');
      if LJSONPair <> nil then
      begin
        if (LJSONResponse as TJSONObject).GetValue('statustype').Value.ToUpper = 'SUCCESS' then
        Begin
          FStatus           := StrToIntDef((LJSONResponse as TJSONObject).GetValue('status').Value,-1);
          FStatusType       := (LJSONResponse as TJSONObject).GetValue('statustype').Value;
          FMessage          := (LJSONResponse as TJSONObject).GetValue('message').Value;

          // Checagem necessaria para realizar a busca de licenca do ERP que esta em produção, pois o servidor
          // do GESTOR não tem o esquema de package ainda - 10/11/2022.
          LJSONPairPackage :=  (LJSONResponse as TJSONObject).Get('packagecount');
          if LJSONPairPackage <> nil then
            FPackageCount     := StrToIntDef((LJSONResponse as TJSONObject).GetValue('packagecount').Value,0);

          FData             := (LJSONResponse as TJSONObject).GetValue('data').ToJSON;
          Result := FData;
          Exit;
        End
        else
        if (LJSONResponse as TJSONObject).GetValue('statustype').Value.ToUpper = 'WARNING' then
        Begin
          FStatus           := StrToIntDef((LJSONResponse as TJSONObject).GetValue('status').Value,-1);
          FStatusType       := (LJSONResponse as TJSONObject).GetValue('statustype').Value;
          FMessage          := (LJSONResponse as TJSONObject).GetValue('message').Value;
          Result := '{}';
          Exit;
        End
        else
        if (LJSONResponse as TJSONObject).GetValue('statustype').Value.ToUpper = 'EXCEPTION' then
        Begin
          FStatus           := StrToIntDef((LJSONResponse as TJSONObject).GetValue('status').Value,-1);
          FStatusType       := (LJSONResponse as TJSONObject).GetValue('statustype').Value;
          FMessage          := (LJSONResponse as TJSONObject).GetValue('message').Value;
          FUnitName         := (LJSONResponse as TJSONObject).GetValue('unitname').Value;
          FClassName        := (LJSONResponse as TJSONObject).GetValue('classname').Value;
          FFunctionName     := (LJSONResponse as TJSONObject).GetValue('functionname').Value;
          FExceptionMessage := (LJSONResponse as TJSONObject).GetValue('exceptionmessage').Value;
          Result := '{}';
          raise Exception.Create(AResponse);
          Exit;
        End;
      end
      else
      begin
        LJSONPairWiRL := (LJSONResponse as TJSONObject).Get('exception');
        if LJSONPairWiRL <> nil then
        begin
          // Tratar Respose Default do WiRL
          FStatus           := StrToIntDef((LJSONResponse as TJSONObject).GetValue('status').Value,-1);
          FMessage          := (LJSONResponse as TJSONObject).GetValue('message').Value;
          Result := '{}';
          raise Exception.Create(AResponse);
          exit
        end
        else
        begin
          Result := AResponse;
          exit;
        end;
      end;
  end;
  finally
    if LJSONResponse <> nil then
     FreeAndNil(LJSONResponse);
  end;
end;

procedure TResponse.ReturnResponse(out AResult: String);
begin
  AResult := FResponseResult;
  FResponseResult  := '';
end;

function TResponse.Send(APackageCount: Integer; AValue: TObject; AStatus: Integer): TResponse;
var
  LJSONResponse : TJSONObject;
  LJSONValue : TJSONValue;
begin
  Result := Self;
  FStatus := AStatus;
  //
  if not Assigned(AValue) then
    raise Exception.Create('Error Response Object Nil');
  //
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status',AStatus.ToString);
  LJSONResponse.AddPair('statustype','success');
  LJSONResponse.AddPair('message','Requisição Executada com Sucesso!');
  LJSONResponse.AddPair('packagecount',APackageCount.ToString);
  LJSONResponse.AddPair('data',TGOXJson.ObjectToJSON(AValue));
  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);

end;

function TResponse.SendException(AMessage, AFunctionName: String; AExcept: Exception; AObject: TObject): TResponse;
var
  LJSONResponse : TJSONObject;
  LMSGException : String;
begin
  Result := Self;
  //
  FStatus := 500;
  //
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status','500');
  LJSONResponse.AddPair('statustype','exception');
  LJSONResponse.AddPair('message',AMessage);
  LJSONResponse.AddPair('unitname',IfThen(AObject <> nil,AObject.UnitName,''));
  LJSONResponse.AddPair('classname',IfThen(AObject <> nil,AObject.ClassName,''));
  LJSONResponse.AddPair('functionname',AFunctionName);
  LJSONResponse.AddPair('exceptionmessage',AExcept.Message);
  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);  //  UTF8ToUnicodeString(
  //
  //
  //Cria Log para arquivo de Log
  LMSGException := 'Error:'+#13+
                   DupeString(' ',24)+'Message:'+AMessage+#13+
                   DupeString(' ',24)+'Unit: '+IfThen(AObject <> nil,AObject.UnitName,'')+'   Class: '+IfThen(AObject <> nil,AObject.ClassName,'')+#13+
                   DupeString(' ',24)+'Function:'+AFunctionName+#13+
                   DupeString(' ',24)+'Exception: '+AExcept.Message;
end;

function TResponse.SendHtml(AValue: String; AStatus: Integer): TResponse;
begin
  Result := Self;
  FStatus := AStatus;
  FResponseResult := AValue;
end;

function TResponse.SendMessage(AMessage: String; AStatus: Integer): TResponse;
var
  LJSONResponse : TJSONObject;
begin
  Result := Self;
  //
  FStatus := AStatus;
  //
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status',AStatus.ToString);
  LJSONResponse.AddPair('statustype','warning');
  LJSONResponse.AddPair('message',AMessage);
  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);
end;

function TResponse.ToJSONParamsResponse: String;
var
  LJSONObjStr:String;
  LJSONValue : TJSONValue;
  LJSONObject : TJSONObject;
  LJSONArray: TJSONArray;
  LKEY :String;
begin
  //Prepara Json de Resposta Padrao Params ORMBR
  LJSONArray := TJSONArray.Create;
  for LKEY in FParamsList.Keys do
  begin
    LJSONObjStr := '{"'+LKEY+'":"'+FParamsList.Items[LKEY]+'"}';
    LJSONValue := TJSONObject.ParseJSONValue(LJSONObjStr);
    LJSONArray.AddElement(LJSONValue);
  end;
  LJSONObject := TJSONObject.Create;
  LJSONObject.AddPair('params',LJSONArray);
  //
  //Chama Funcao Response
  Result := LJSONObject.ToJSON;
  //
  FreeAndNil(LJSONObject);
  FParamsList.Clear;
end;

{ TGOXRESTRequestEngine }

constructor TGOXRESTRequestEngine.Create;
begin
   FResponse := TResponse.Create;
end;

destructor TGOXRESTRequestEngine.Destroy;
begin
  FreeAndNil(FResponse);
  inherited;
end;

function TGOXRESTRequestEngine.Process<T>(const AJSONRequest: TJSONValue): T;
begin
  Result := TGOXJson.JSONToObject<T>(AJSONRequest);
end;

function TGOXRESTRequestEngine.Process<T>(const AJSONRequest: String): T;
begin
  Result := TGOXJson.JSONStringToObject<T>(AJSONRequest);
end;

function TGOXRESTRequestEngine.Response: TResponse;
begin
  Result := FResponse;
end;

end.
