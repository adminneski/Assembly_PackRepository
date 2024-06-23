{******************************************************************************}
{                                                                              }
{       WiRL: RESTful Library for Delphi                                       }
{                                                                              }
{       Copyright (c) 2015-2018 WiRL Team                                      }
{                                                                              }
{       https://github.com/delphi-blocks/WiRL                                  }
{                                                                              }
{******************************************************************************}
unit Api.Contacts;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Rtti,
  //
  WiRL.Core.JSON,
  WiRL.Core.Application,
  WiRL.Core.Registry,
  WiRL.Core.Attributes,
  WiRL.http.Accept.MediaType,
  WiRL.http.URL,
  WiRL.Core.MessageBody.Default,
  WiRL.http.Request,
  WiRL.http.Response,
  WiRL.Core.Auth.Context,
  WiRL.Core.Auth.Resource,
  WiRL.Core.GarbageCollector,
  //
  Core.Logtxt,
  Dto.CONTACTS_00,
  Domain.Contacts,
  Core.Server.TokenClaim,
  goxormbr.core.json.utils,
  goxormbr.core.rest.request;

type
  [Path('contacts')]
  TResourceContacts = class
  private
    [Context] URL: TWiRLURL;
    [Context] Auth: TWiRLAuthContext;
    [Context] TokenClaim: TKernelServerTokenClaim;
    const FNameRef = 'Contatos';
  public
    constructor Create;
    destructor Destroy; override;
    [GET]
    [Produces(TMediaType.APPLICATION_JSON)]
    function GET_Find: String; overload;

    [GET, Path('/find/{AId}')]
    [Produces(TMediaType.APPLICATION_JSON)]
    function GET_Find([PathParam] AId: Integer): String; overload;

    [GET, Path('/where/{AWhere}/{AOrderBy}')]
    [Produces(TMediaType.APPLICATION_JSON)]
    function GET_FindWhere([QueryParam('where')] AWhere: String;
                           [QueryParam('orderby')] AOrderBy:String = ''): String;
    [POST]
    [Produces(TMediaType.APPLICATION_JSON)]
    function POST_Insert([BodyParam] AJSONValue: String): String;

    [PUT]
    [Produces(TMediaType.APPLICATION_JSON)]
    function PUT_Update([BodyParam] AJSONValue: String): String;

    [DELETE, Path('/{AId}')]
    [Produces(TMediaType.APPLICATION_JSON)]
    function DEL_Delete([PathParam] AId: Integer): String;
    //
    {--- Default Resources Additional  -------------------------------------}
    [GET, Path('/readonlydto')]
    [Produces(TMediaType.APPLICATION_JSON)]
    function GET_ReadOnlyDto([QueryParam('dtoname')] ADtoName: String;
                             [QueryParam('where')] AWhere: String = '';
                             [QueryParam('orderby')] AOrderBy:String = '';
                             [QueryParam('valuesearchfieldall')] AValueSearchFieldAll: String = '';
                             [QueryParam('openlastrecords')] AOpenLastRecords: String = 'N'
                             ): String;
    {--- Other Resources ---------------------------------------------------}
    [GET, Path('/from')]
    [Produces(TMediaType.APPLICATION_JSON)]
    function GET_FindFrom: String;
  end;

implementation

{ TResourceContacts }
function TResourceContacts.GET_Find: String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts
    .GET_Find
     .Request
      .Response
       .ReturnResponse(Result);
  except on E: Exception do
     LRequest
      .Response
       .SendException(FNameRef+' - Error ao Pesquiar!','GET_Find',E,Self)
        .ReturnResponse(Result);
  end;
end;

destructor TResourceContacts.Destroy;
begin
  TLogTxt.Get.AddLog('Destruindo API: '+Self.ClassName);
  inherited;
end;

function TResourceContacts.GET_Find(AId: Integer): String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts
    .GET_Find(AId)
     .Request
      .Response
       .ReturnResponse(Result);
  except on E: Exception do
     LRequest
      .Response
       .SendException(FNameRef+' - Error ao Incluir!','POST_Insert',E,Self)
        .ReturnResponse(Result);
  end;
end;

function TResourceContacts.GET_FindFrom: String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts
    .GET_Find
     .Request
      .Response
       .ReturnResponse(Result);
  except on E: Exception do
     LRequest
      .Response
       .SendException(FNameRef+' - Error ao Pesquiar!','GET_Find',E,Self)
        .ReturnResponse(Result);
  end;
end;

function TResourceContacts.GET_ReadOnlyDto(ADtoName, AWhere, AOrderBy, AValueSearchFieldAll,
 AOpenLastRecords: String): String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts.GET_ReadOnlyDto(ADtoName,AWhere,AOrderBy,AValueSearchFieldAll,AOpenLastRecords);
    //
    LRequest.Response.ReturnResponse(Result);
  except on E: Exception do
    LRequest.Response
     .SendException(FNameRef+' - Error ao Localizar!','GET_ReadOnlyDto',e,Self)
      .ReturnResponse(Result);
  end;
end;

function TResourceContacts.GET_FindWhere(AWhere, AOrderBy: String): String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts.GET_FindWhere(AWhere,AOrderBy);
    //
    LRequest.Response.ReturnResponse(Result);
  except on E: Exception do
    LRequest.Response
     .SendException(FNameRef+' - Error ao Localizar!','GET_FindWhere',e,Self)
      .ReturnResponse(Result);
  end;
end;

function TResourceContacts.POST_Insert(AJSONValue: String): String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts.POST_Insert(TGOXJson.JSONStringToObject<TDtoCONTACTS_00>(AJSONValue));
    //
    LRequest.Response.ReturnResponse(Result);
  except on E: Exception do
    LRequest.Response
     .SendException(FNameRef+' - Error ao Incluir!','POST_Insert',E,Self)
      .ReturnResponse(Result);
  end;
end;

function TResourceContacts.PUT_Update(AJSONValue: String): String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts.PUT_Update(TGOXJson.JSONStringToObject<TDtoCONTACTS_00>(AJSONValue));
    //
    LRequest.Response.ReturnResponse(Result);
  except on E: Exception do
    LRequest.Response
     .SendException(FNameRef+' - Error ao Alterar!','PUT_Update',e,Self)
      .ReturnResponse(Result);
  end;
end;

constructor TResourceContacts.Create;
begin
  TLogTxt.Get.AddLog('Criando API : '+Self.ClassName);
end;

function TResourceContacts.DEL_Delete(AId: Integer): String;
Var
  LRequest : IGOXRESTRequestEngine;
  LDomainContacts : IDomainContacts;
begin
  try
    LRequest := TGOXRESTRequestEngine.New;
    LDomainContacts := TDomainContacts.New(LRequest,TokenClaim);
    LDomainContacts.DEL_Delete(AId);
    //
    LRequest.Response.ReturnResponse(Result);
  except on E: Exception do
    LRequest.Response
     .SendException(FNameRef+' - Error ao Excluir!','DEL_Delete',e,Self)
      .ReturnResponse(Result);
  end;
end;


initialization
  TWiRLResourceRegistry.Instance.RegisterResource<TResourceContacts>;

end.
