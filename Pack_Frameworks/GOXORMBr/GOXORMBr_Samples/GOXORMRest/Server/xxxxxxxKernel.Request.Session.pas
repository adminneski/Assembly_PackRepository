unit xxxxxxxKernel.Request.Session;

interface
uses
  System.Generics.Collections,
  System.Generics.Defaults,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.TypInfo,
  System.JSON,
  System.Math,
  System.Rtti,
  Core.Server.TokenClaim,
  goxormbr.core.json.utils;


type

   IRequestSession = interface
   ['{E06541CC-3A2F-4C80-BB07-068B8896AB6F}']
 //   procedure ReturnResponse(out AResult:TJSONValue); overload;
    procedure ReturnResponse(out AResult:String); overload;
    //
    function Response(AValue:String; AStatus:Integer = 200):IRequestSession; overload;
    function Response(AValue:TObject; AStatus:Integer = 200):IRequestSession; overload;
    function ResponseMessage(AMessage:String; AStatus:Integer = 400):IRequestSession; overload;
    function ResponseException(AMessage:String; AFunctionName:String; AExcept:Exception; AObject:TObject): IRequestSession;
    function ResponseHtml(AValue:String; AStatus:Integer = 200):IRequestSession; overload;

    function AddParamResponse(AKey:String;AValue:String; AStatus:Integer = 200):IRequestSession;
    function ToJSONParamsResponse:String;

   end;

  TRequestSession = class(TInterfacedObject,IRequestSession)
  private
    FTokenClaim :TKernelServerTokenClaim;
    FParamsList  : TDictionary<String,String>;
    FResponseResult: String;
  public
    constructor Create(ATokenClaim:TKernelServerTokenClaim);
    destructor Destroy; override;
    class function New(ATokenClaim:TKernelServerTokenClaim): IRequestSession;
    //
//    procedure ReturnResponse(out AResult:TJSONValue); overload;
    procedure ReturnResponse(out AResult:String); overload;

    function Response(AValue:String; AStatus:Integer = 200):IRequestSession; overload;
    function Response(AValue:TObject; AStatus:Integer = 200):IRequestSession; overload;
    function ResponseMessage(AMessage:String; AStatus:Integer = 400):IRequestSession;
    function ResponseException(AMessage:String; AFunctionName:String; AExcept:Exception; AObject:TObject): IRequestSession;
    function ResponseHtml(AValue:String; AStatus:Integer = 200):IRequestSession; overload;
    //
    function AddParamResponse(AKey:String;AValue:String; AStatus:Integer = 200):IRequestSession;
    function ToJSONParamsResponse:String;

  end;

implementation

uses
  Ormbr.container.objectset, Core.Logtxt;

constructor TRequestSession.Create(ATokenClaim:TKernelServerTokenClaim);
begin
  FTokenClaim := ATokenClaim;
  FParamsList := TDictionary<String,String>.Create;
end;

destructor TRequestSession.Destroy;
begin
  FParamsList.Clear;
  FreeAndNil(FParamsList);
  inherited;
end;

function TRequestSession.Response(AValue: TObject; AStatus: Integer): IRequestSession;
var
  LJSONResponse : TJSONObject;
  LJSONValue : TJSONValue;
begin
  Result := Self;
  if not Assigned(AValue) then
    raise Exception.Create('Error Response Object Nil');
  //
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status',AStatus.ToString);
  LJSONResponse.AddPair('statustype','success');
  LJSONResponse.AddPair('message','Requisição Executada com Sucesso!');
  LJSONResponse.AddPair('data',TGOXJson.ObjectToJSON(AValue));
  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);
end;

function TRequestSession.ResponseException(AMessage: String; AFunctionName:String;
  AExcept: Exception; AObject:TObject): IRequestSession;
var
  LJSONResponse : TJSONObject;
  LMSGException : String;
begin
  Result := Self;
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
  TLogTxt.Get.AddLog(LMSGException);
  //
end;

function TRequestSession.ResponseHtml(AValue: String; AStatus: Integer): IRequestSession;
begin
  Result := Self;
  FResponseResult := AValue;
end;


class function TRequestSession.New(ATokenClaim:TKernelServerTokenClaim): IRequestSession;
begin
  Result := TRequestSession.Create(ATokenClaim)
end;

function TRequestSession.Response(AValue: String; AStatus:Integer): IRequestSession;
var
  LJSONResponse : TJSONObject;
  LJSONValue : TJSONValue;
begin
  Result := Self;
  if AValue.Length > 0 then
    LJSONValue := TJSONObject.ParseJSONValue(AValue)
  else
    LJSONValue := TJSONArray.Create(TJSONNull.Create);
  //
  LJSONResponse := TJSONObject.Create;
  LJSONResponse.AddPair('status',AStatus.ToString);
  LJSONResponse.AddPair('statustype','success');
  LJSONResponse.AddPair('message','Requisição Executada com Sucesso!');
  LJSONResponse.AddPair('data',LJSONValue);
  //
  FResponseResult := LJSONResponse.ToJSON;
  //
  FreeAndNil(LJSONResponse);
end;

function TRequestSession.AddParamResponse(AKey, AValue: String; AStatus:Integer): IRequestSession;
var
  LJSONObjStr:String;
  LJSONValue : TJSONValue;
  LJSONObject : TJSONObject;
  LJSONArray: TJSONArray;
begin
  Result := Self;
  FParamsList.Add(AKey,AValue);
end;

function TRequestSession.ToJSONParamsResponse: String;
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


//procedure TRequestSession.ReturnResponse(out AResult: TJSONValue);
//begin
//  AResult := TGOXJson.ObjectToJSONString(TGOXJson.   )(FResponseResult);
//  FResponseResult  := '';
//end;

function TRequestSession.ResponseMessage(AMessage: String; AStatus:Integer): IRequestSession;
var
  LJSONResponse : TJSONObject;
begin
  Result := Self;
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





procedure TRequestSession.ReturnResponse(out AResult: String);
begin
  AResult := FResponseResult;
  FResponseResult  := '';
end;

end.
