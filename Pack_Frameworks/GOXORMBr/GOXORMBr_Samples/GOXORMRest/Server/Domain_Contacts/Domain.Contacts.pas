unit Domain.Contacts;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Rtti,
  Core.Database.Connection,
  GOX.StringManager,
  goxormbr.manager.dataset,
  goxormbr.manager.objectset,
  Repository.Manager.db,
  goxormbr.core.rest.request,
  Core.Server.TokenClaim,
  Dto.contacts_00;

type
  IDomainContacts = interface
  ['{7FF27FEF-9AC6-41A7-9BDE-9E7694DE7519}']
    function Request: IGOXRESTRequestEngine;
    //Reading
    function GET_Find:IDomainContacts; overload;
    function GET_Find(AId:Integer):IDomainContacts; overload;
    function GET_FindWhere(AWhere,AOrderBy: String): IDomainContacts;
    function GET_ReadOnlyDto(ADtoName, AWhere: String; AOrderBy:String=''; AValueSearchFieldAll: String=''; AOpenLastRecords: String='N'): IDomainContacts;
    //Writing
    function POST_Insert(AWritingValue:TDtoCONTACTS_00):IDomainContacts;
    function PUT_Update(AWritingValue:TDtoCONTACTS_00):IDomainContacts;
    function DEL_Delete(const AId: Integer):IDomainContacts;
  end;


  TDomainContacts = class(TInterfacedObject,IDomainContacts)
  private
    FRequest : IGOXRESTRequestEngine;
    FToken   : TKernelServerTokenClaim;
    FDBAConnection : TDatabaseConnection;
    FRepOSet : TRepositoryManagerObjectSet;
    const FNameRef = 'Contatos';
  public
    constructor Create(ARequest:IGOXRESTRequestEngine; ATokenClaim:TKernelServerTokenClaim);
    destructor Destroy; override;
    class function New(ARequest:IGOXRESTRequestEngine; ATokenClaim:TKernelServerTokenClaim): IDomainContacts;
    function Request: IGOXRESTRequestEngine;
    //Reading
    function GET_Find:IDomainContacts; overload;
    function GET_Find(AId:Integer):IDomainContacts; overload;
    function GET_FindWhere(AWhere,AOrderBy: String): IDomainContacts;
    function GET_ReadOnlyDto(ADtoName, AWhere: String; AOrderBy:String=''; AValueSearchFieldAll: String=''; AOpenLastRecords: String='N'): IDomainContacts;
    //Writing
    function POST_Insert(AWritingValue:TDtoCONTACTS_00):IDomainContacts;
    function PUT_Update(AWritingValue:TDtoCONTACTS_00):IDomainContacts;
    function DEL_Delete(const AId: Integer):IDomainContacts;
  end;

implementation

uses
  Core.Logtxt;

{ TDomainContacts }

constructor TDomainContacts.Create(ARequest:IGOXRESTRequestEngine; ATokenClaim:TKernelServerTokenClaim);
begin
  FDBAConnection := TDatabaseConnection.Create;
  FToken   := ATokenClaim;
  FRequest := ARequest;
  FRepOSet := TRepositoryManagerObjectSet.Create(FDBAConnection.GOXDBConnection);
  FRepOSet.AddObjectSet<TDtoCONTACTS_00>;
end;

destructor TDomainContacts.Destroy;
begin
  FreeAndNil(FRepOSet);
  FreeAndNil(FDBAConnection);
  inherited;
end;

function TDomainContacts.GET_Find: IDomainContacts;
var
  LCONTACTList : TObjectList<TDtoCONTACTS_00>;
begin
  Result := Self;
  try
    LCONTACTList := FRepOSet.Find<TDtoCONTACTS_00>;
    if LCONTACTList <> nil then if LCONTACTList.Count = 0 then
    Begin
      FRequest.Response.SendMessage(FNameRef+' - Não Localizado!');
      exit;
    End;
    FRequest.Response.Send(LCONTACTList);
    //
    FreeAndNil(LCONTACTList);
  except on E: Exception do
    FRequest.Response.SendException(FNameRef+' - Error ao Localizar!','GET_Find',E,Self);
  end;
end;

function TDomainContacts.GET_Find(AId: Integer): IDomainContacts;
var
  LCONTACT : TDtoCONTACTS_00;
begin
  Result := Self;
  try
    LCONTACT := FRepOSet.Find<TDtoCONTACTS_00>(AID);
    if LCONTACT = nil then
    Begin
      FRequest.Response.SendMessage(FNameRef+' - Não Localizado!');
      exit;
    End;
    FRequest.Response.Send(LCONTACT);
    FreeAndNil(LCONTACT);
  except on E: Exception do
    FRequest.Response.SendException(FNameRef+' - Error ao Localizar!','GET_Find',E,Self);
  end;
end;

function TDomainContacts.GET_ReadOnlyDto(ADtoName, AWhere, AOrderBy, AValueSearchFieldAll, AOpenLastRecords: String): IDomainContacts;
var
  LCONTACTList : TObjectList<TDtoCONTACTS_00>;
begin
  Result := Self;
  try
    //======= Check by Dto
    if ADtoName = TDtoCONTACTS_00.ClassName then
    begin
      //
      if AOpenLastRecords = 'S' then
//      LCONTACTList  := FRepOSet.FindLast(50,true)
      else if AValueSearchFieldAll.Length > 0 then
//       LCONTACTList := FRepOSet.SearchFieldAll(AValueSearchFieldAll,AWhere,AOrderBy)
      else if AValueSearchFieldAll.Length = 0 then
       LCONTACTList :=  FRepOSet.FindWhere<TDtoCONTACTS_00>(AWhere,AOrderBy);
      //
      if LCONTACTList <> nil then if LCONTACTList.Count = 0 then
      begin
        FRequest.Response.SendMessage(FNameRef+' - Não Localizado!');
        Exit;
      end;
      FRequest.Response.Send(LCONTACTList);

      FreeAndNil(LCONTACTList);
    end;
  except on E: Exception do
    FRequest.Response.SendException(FNameRef+' - Error ao Localizar!','GET_ReadOnlyDto',E,Self);
  end;
end;

function TDomainContacts.GET_FindWhere(AWhere, AOrderBy: String): IDomainContacts;
var
  LCONTACTList : TObjectList<TDtoCONTACTS_00>;
begin
  Result := Self;
  try
    LCONTACTList := FRepOSet.FindWhere<TDtoCONTACTS_00>(AWhere,AOrderBy);
    if LCONTACTList <> nil then if LCONTACTList.Count = 0 then
    Begin
      FRequest.Response.SendMessage(FNameRef+' - Não Localizado!');
      exit;
    End;
    FRequest.Response.Send(LCONTACTList);

    FreeAndNil(LCONTACTList);
  except on E: Exception do
    FRequest.Response.SendException(FNameRef+' - Error ao Localizar!','GET_FindWhere',E,Self);
  end;
end;

class function TDomainContacts.New(ARequest:IGOXRESTRequestEngine; ATokenClaim:TKernelServerTokenClaim): IDomainContacts;
begin
  Result := TDomainContacts.Create(ARequest,ATokenClaim);
end;

function TDomainContacts.POST_Insert(AWritingValue: TDtoCONTACTS_00): IDomainContacts;
var
  LCONTACT00 : TDtoCONTACTS_00;
begin
  Result := Self;
  try
    LCONTACT00 := FRepOSet.Find<TDtoCONTACTS_00>(AWritingValue.CONTACT_CODIGO);
    //
    if LCONTACT00 <> nil then
    begin
      FRequest.Response.SendMessage(FNameRef+' ['+LCONTACT00.CONTACT_CODIGO.ToString+'] - Já Cadastrado!');
      Exit;
    end;
    //
    LCONTACT00 := AWritingValue;
    //
    LCONTACT00.CONTACT_BIRTHDATE := Now;
    LCONTACT00.CONTACT_AGE := 1955;
    //
    FRepOSet.Insert<TDtoCONTACTS_00>(LCONTACT00);
    //
    FRequest.Response.AddParamResponse('CONTACT_CODIGO',LCONTACT00.CONTACT_CODIGO.ToString);
    FRequest.Response.Send(FRequest.Response.ToJSONParamsResponse);
    //
    FreeAndNil(LCONTACT00);
  except on E: Exception do
    Begin
      TLogTxt.Get.AddLog('ERROR DOMAIN. - '+E.Message);
    //  FResponse.ResponseException(FNameRef+' - Error ao Incluir!','POST_Insert!',E,Self);
    End;
  end;
end;

function TDomainContacts.PUT_Update(AWritingValue: TDtoCONTACTS_00): IDomainContacts;
var
  LCONTACT00 : TDtoCONTACTS_00;
begin
  Result := Self;
  try
    LCONTACT00 := FRepOSet.Find<TDtoCONTACTS_00>(AWritingValue.CONTACT_CODIGO);
    if LCONTACT00 = nil then
    begin
      FRequest.Response.SendMessage(FNameRef+' - Não Localizado!');
      exit;
    end;
    //Guarda o Estado do Objeto Pesquisado da Base de Dados.
    FRepOSet.Modify<TDtoCONTACTS_00>(LCONTACT00);
    //
    LCONTACT00.CONTACT_BIRTHDATE := Now;
    //
    FRepOSet.Update<TDtoCONTACTS_00>(LCONTACT00);
    //
    FRequest.Response.Send(LCONTACT00);
    //
    FreeAndNil(LCONTACT00);
  except on E: Exception do
    FRequest.Response.SendException(FNameRef+' - Error ao Alterar!','PUT_Update!',E,Self);
  end;
end;

function TDomainContacts.Request: IGOXRESTRequestEngine;
begin
  Result := FRequest;
end;

function TDomainContacts.DEL_Delete(const AId: Integer): IDomainContacts;
var
  LCONTACT00 : TDtoCONTACTS_00;
begin
  Result := Self;
  try
    LCONTACT00 := FRepOSet.Find<TDtoCONTACTS_00>(AId);
    if LCONTACT00 = nil then
    begin
      FRequest.Response.SendMessage(FNameRef+' - Não Localizado!');
      exit;
    end;
    FRepOSet.Delete<TDtoCONTACTS_00>(LCONTACT00);
    //
    FreeAndNil(LCONTACT00);
  except on E: Exception do
    FRequest.Response.SendException(FNameRef+' - Error ao Excluir!','DEL_Delete!',E,Self);
  end;

end;

initialization
finalization

end.
