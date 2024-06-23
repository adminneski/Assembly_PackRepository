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

{$INCLUDE ..\goxorm.inc}

unit goxormbr.manager.objectset.rest.session;

interface

uses
  DB,
  Rtti,
  TypInfo,
  Classes,
  Variants,
  SysUtils,
  StrUtils,
  System.IOUtils,
  Generics.Collections,
  REST.Json,
  {$IFDEF DELPHI15_UP}
  JSON,
  {$ELSE}
  DBXJSON,
  {$ENDIF}
  ///GOXORMBr
  goxormbr.core.mapping.explorer,
  goxormbr.core.mapping.attributes,
  goxormbr.core.mapping.classes,
  goxormbr.manager.objectset.db.adapter.base,
  goxormbr.core.session.abstract,
  goxormbr.manager.objectset.rest.adapter,
  goxormbr.core.objects.utils,
  goxormbr.core.rest.request,
  goxormbr.core.types,
  goxormbr.core.json.utils;

type
  /// <summary>
  ///   M - Sessão RESTFull
  /// </summary>
  TSessionObjectSetRest<M: class, constructor> = class(TSessionAbstract<M>)
  private
  protected
    FOwner: TGOXManagerObjectSetAdapterRest<M>;
    FConnection: TGOXRESTConnection;
    FResource: String;
    FSubResource: String;
//    FServerUse: Boolean;
    function ParseOperator(AParams: String): string;
  public
    constructor Create(const AConnection: TGOXRESTConnection;   const AOwner: TGOXManagerObjectSetAdapterRest<M>; const APageSize: Integer = -1); overload;
    destructor Destroy; override;
    //
    function Find: TObjectList<M>; overload; override;
    function Find(const APK: Int64): M; overload; override;
    function Find(const APK: String): M; overload; override;
    function FindWhere(const AWhere: string; const AOrderBy: string = ''): TObjectList<M>;overload; override;
    function FindWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<M>; overload; override;
    function FindFrom(const ASubResourceName: String): TObjectList<M>; override;
    //
    procedure Insert(const AObject: M); overload; override;
    procedure InsertFrom(const ASubResourceName: String); override;
    procedure Update(const AObjectList: TObjectList<M>); overload; override;
    procedure UpdateFrom(const ASubResourceName: String); override;
    procedure Delete(const APK: Int64); overload; override;
    procedure Delete(const AObject: M); overload; override;
    procedure DeleteFrom(const ASubResourceName: String); override;

//    procedure Delete(const AObject: M); overload; override;
    //
    procedure RefreshRecord(const AColumns: TParams); override;
    function ExistSequence: Boolean; override;
    function Request: TGOXRESTRequestEngine;
  end;

implementation

uses
  goxormbr.core.objects.helper,
  goxormbr.core.consts;

{ TSessionObjectSetRest<M> }

constructor TSessionObjectSetRest<M>.Create(const AConnection: TGOXRESTConnection;
  const AOwner: TGOXManagerObjectSetAdapterRest<M>; const APageSize: Integer = -1);
var
  LObject: TObject;
  LTable: TCustomAttribute;
  LResource: TCustomAttribute;
  LSubResource: TCustomAttribute;
  LNotServerUse: TCustomAttribute;
begin
  inherited Create(APageSize);
  FOwner := AOwner;
  FConnection := AConnection;
  FPageSize := APageSize;
  FPageNext := 0;
  FFindWhereUsed := False;
  FFindWhereRefreshUsed := False;
  FResource := '';
  FSubResource := '';
//  FServerUse := False;

  /// <summary>
  ///   Pega o nome do recurso e subresource definidos na classe
  /// </summary>
  LObject := TObject(M.Create);
  try
    /// <summary>
    ///   Nome do Recurso
    /// </summary>
    LResource := LObject.GetResource;
    if LResource <> nil then
      FResource := Resource(LResource).Name;

    /// <summary>
    ///   Nome do SubRecurso
    /// </summary>
    LSubResource := LObject.GetSubResource;
    if LSubResource <> nil then
      FSubResource := Resource(LSubResource).Name;
  finally
    LObject.Free;
  end;
end;

destructor TSessionObjectSetRest<M>.Destroy;
begin
  inherited;
end;

function TSessionObjectSetRest<M>.ExistSequence: Boolean;
var
  LSequence: TSequenceMapping;
begin
  Result := False;
  LSequence := TMappingExplorer
                   .GetMappingSequence(TClass(M));
  if LSequence <> nil then
    Result := True;
end;

//procedure TSessionObjectSetRest<M>.Delete(const AObject: M);
//var
//  LPKColumn: TColumnMapping;
//  LPrimaryKey: TPrimaryKeyColumnsMapping;
//  LSubResource: String;
//  LResult: String;
//  LResource: String;
//  LJSONObject: TJSONObject;
//  LPrimaryKeyValue : Int64;
//begin
//  LPrimaryKey := TMappingExplorer
//                   .GetMappingPrimaryKeyColumns(AObject.ClassType);
//  if LPrimaryKey = nil then
//    raise Exception.Create(cMESSAGEPKNOTFOUND);
//  LPKColumn := LPrimaryKey.Columns.Items[0];
//  //
//  //Prepara Resource
//  LResource := FResource;
//  LSubResource := ifThen(Length(FConnection.MethodDELETE) > 0, FConnection.MethodDELETE, FSubResource);
//  //
//  //Executar Request
//  LJSONObject := TGOXJson.ObjectToJSON(AObject) as TJSONObject;
//  LPrimaryKeyValue := StrToIntDef(LJSONObject.GetValue(LPKColumn.ColumnName).Value,-1);
//  FConnection.AddPathParam(LPrimaryKeyValue.ToString);
//  LResult := FConnection.Execute(LResource, LSubResource, rtDELETE);
//  FreeAndNil(LJSONObject);
//end;

procedure TSessionObjectSetRest<M>.Delete(const AObject: M);
var
  LColumn: TColumnMapping;
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LSubResource: String;
  LURI: String;
  LResult: String;
  LResource: String;
begin
  //Prepara Resource
  LResource := FResource;
  LSubResource := '';
  LSubResource := ifThen(Length(FConnection.MethodDELETE) > 0, FConnection.MethodDELETE, FSubResource);
  //
  LPrimaryKey := TMappingExplorer.GetMappingPrimaryKeyColumns(AObject.ClassType);
  if LPrimaryKey = nil then
    raise Exception.Create(cMESSAGEPKNOTFOUND);
  //
  LColumn := LPrimaryKey.Columns.Items[0];
  //Executar Request
  FConnection.AddPathParam(LColumn.ColumnProperty.GetValue(TObject(AObject)).AsInteger.ToString);
  LResult := FConnection.Execute(LResource, LSubResource, rtDELETE);
  //
end;

procedure TSessionObjectSetRest<M>.DeleteFrom(const ASubResourceName: String);
var
  LResource: String;
  LSubResource: String;
  LResult: String;
  LParamsObject: TJSONObject;
  LParamsArray: TJSONArray;
  LValuesObject: TJSONObject;
  LFor: Integer;
  LPar: Integer;
begin
  inherited;
  //Prepara Resource
  LResource := FResource;
  LSubResource := '';
  LSubResource := ASubResourceName;
  //
  //Executar Request
  LResult := FConnection.Execute(LResource, LSubResource, rtDELETE);
  //
  // Gera lista de params com o retorno, se existir o elemento "params" no JSON.
  try
    FResultParams.Clear;
    //Valida se retornou um JSONObjct
    LParamsObject := TGOXJson.JSONStringToJSONObject(LResult);
    if LParamsObject = nil then
      Exit;
    //Valida se exite a chave e valor e array
    LParamsArray := LParamsObject.Values['params'] as TJSONArray;
    if LParamsArray = nil then
      Exit;
    //Se passou nas validações da um Loop Alimentanto o ResultParams com valores retornados
    for LFor := 0 to LParamsArray.Count -1 do
    begin
      LValuesObject := LParamsArray.Items[LFor] as TJSONObject;
      with FResultParams.Add as TParam do
      begin
        for LPar := 0 to LValuesObject.Count -1 do
        begin
          Name := LValuesObject.Pairs[LPar].JsonString.Value;
          DataType := ftString;
          Value := LValuesObject.Pairs[LPar].JsonValue.Value
        end;
      end;
    end;
  finally
    if LParamsObject <> nil then LParamsObject.Free;
  end;
end;

procedure TSessionObjectSetRest<M>.Delete(const APK: Int64);
var
  LSubResource: String;
  LURI: String;
  LResult: String;
  LResource: String;
begin
  //Prepara Resource
  LResource := FResource;
  LSubResource := '';
  LSubResource := ifThen(Length(FConnection.MethodDELETE) > 0, FConnection.MethodDELETE, FSubResource);
  //
  //Executar Request
  FConnection.AddPathParam(APK.ToString);
  LResult := FConnection.Execute(LResource, LSubResource, rtDELETE);
  //
end;

function TSessionObjectSetRest<M>.FindWhere(const AWhere, AOrderBy: string): TObjectList<M>;
var
  LSubResource: String;
  LJSON: string;
  LURI: String;
begin
  FFindWhereUsed := True;
  FFetchingRecords := False;
  FWhere := AWhere;
  FOrderBy := AOrderBy;
  //Prepara Resource
  LSubResource := '';
  LSubResource := ifThen(Length(FConnection.MethodGETWhere) > 0, FConnection.MethodGETWhere, FSubResource);
  //
  //Gabiara para ERP pegar Licença
  if AOrderBy = 'PATHPARAMS' then
  Begin
   //Executar Request
   FConnection.AddPathParam(FWhere);
   FConnection.AddPathParam(QuotedStr('PES_CNPJ_CPF'));
  End
  else
  begin
    //Executar Request
    FConnection.AddQueryParam('where',FWhere);
    if Length(FOrderBy) > 0 then
      FConnection.AddQueryParam('orderby',FOrderBy);
  end;
  //
  LJSON := FConnection.Execute(FResource, LSubResource, rtGET);
  //
  // Caso o JSON retornado não seja um array, é tranformado em um.
  if LJSON.Length = 0 then LJSON := '[]' else
  if LJSON = '{}' then LJSON := '[]' else
  if Copy(LJSON,1,1) = '{' then LJSON := '[' + LJSON + ']';
  //
  //   Transforma o JSON recebido populando em uma lista de objetos
  if LJSON = '[]' then
   Result := nil // TGOXJson.JSONToObject<TObjectList<M>>(TJSONNull.Create)
  else
   Result := TGOXJson.JSONStringToObjectList<M>(LJSON);
end;

function TSessionObjectSetRest<M>.Find(const APK: Int64): M;
begin
  /// <summary>
  ///   Transforma o JSON recebido populando o objeto
  /// </summary>
  FFindWhereUsed := False;
  FFetchingRecords := False;
  Result := Find(IntToStr(APK));
end;

function TSessionObjectSetRest<M>.Find(const APK: string): M;
var
  LResource: String;
  LSubResource: String;
  LJSON: String;
  LURI: String;
begin
  FFindWhereUsed := False;
  FFetchingRecords := False;
  //Prepara Resource
  LResource := FResource;
  LSubResource := FConnection.MethodGETId;
  //
  //Executar Request
  FConnection.AddPathParam(APK);
  LJSON := FConnection.Execute(LResource, LSubResource, rtGET);
  //
  //Se for Lista Vazia Converte para Objeto Vazio.
  if (LJSON = '[]')or(LJSON = '[null]') then LJSON := '{}';
  //
  //Transforma o JSON recebido populando o objeto
  if (LJSON = '{}') then
    Result :=  nil //TGOXJson.JSONToValue<M>(TJSONNull.Create)
  else
    Result := TGOXJson.JSONStringToObject<M>(LJSON);
end;

function TSessionObjectSetRest<M>.FindWhere(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer): TObjectList<M>;
var
  Info: PTypeInfo;
  LDtoName :String;
  //
  LSubResource: String;
  LJSON: string;
  LURI: String;
  LWhereFieldAll:String;
begin
  try //Pega nome da class
    Info := System.TypeInfo(M);
    if Info <> nil then LDtoName := Info^.Name;
  finally
    Info := nil;
  end;
  //
  FFindWhereUsed := True;
  FFetchingRecords := False;
  FWhere := AWhere;
  FOrderBy := AOrderBy;
  //Prepara Resource
  LSubResource := '';
  LSubResource := ifThen(Length(FConnection.MethodGETWherePackage) > 0, FConnection.MethodGETWherePackage, FSubResource);
  //
  //Executar Request
  FConnection.AddQueryParam('dtoname',LDtoName);
  FConnection.AddQueryParam('pagenumber',APageNumber.ToString);
  FConnection.AddQueryParam('rowsbypage',ARowsByPage.ToString);
  FConnection.AddQueryParam('where', AWhere);
  FConnection.AddQueryParam('orderby',AOrderBy);
  //
  LJSON := FConnection.Execute(FResource, LSubResource, rtGET);
  //
  // Caso o JSON retornado não seja um array, é tranformado em um.
  if LJSON.Length = 0 then LJSON := '[]' else
  if LJSON = '{}' then LJSON := '[]' else
  if Copy(LJSON,1,1) = '{' then LJSON := '[' + LJSON + ']';
  //
  //Transforma o JSON recebido populando em uma lista de objetos
  if LJSON = '[]' then
   Result := nil //TGOXJson.JSONToObject<TObjectList<M>>(TJSONNull.Create)
  else
  Result := TGOXJson.JSONStringToObjectList<M>(LJSON);

end;

function TSessionObjectSetRest<M>.FindFrom(const ASubResourceName: String): TObjectList<M>;
var
  LResource: String;
  LSubResource: String;
  LJSON: string;
  LURI: String;
  LResult: String;
  LParamsObject: TJSONObject;
  LParamsArray: TJSONArray;
  LValuesObject: TJSONObject;
  LFor: Integer;
  LPar: Integer;
begin
  //Prepara Resource
  LResource := FResource;
  LSubResource := '';
  LSubResource := ASubResourceName;
  //
  //Executar Request
  LJSON := FConnection.Execute(LResource, LSubResource, rtGET);
  //
  //Valida se o Retorno não e do tipo ParamsResponse
  if UpperCase(Copy(LJSON,1,9)) <> UpperCase('{"params"') then
  begin
    // Caso o JSON retornado não seja um array, é tranformado em um.
    if LJSON.Length = 0 then LJSON := '[]' else
    if LJSON = '{}' then LJSON := '[]' else
    if Copy(LJSON,1,1) = '{' then LJSON := '[' + LJSON + ']';
    // Transforma o JSON recebido populando uma lista de objetos
    Result := TGOXJson.JSONStringToObjectList<M>(LJSON);
  end
  else
  begin
    // Gera lista de params com o retorno, se existir o elemento "params" no JSON.
    try
      FResultParams.Clear;
      //Valida se retornou um JSONObjct
      LParamsObject := TGOXJson.JSONStringToJSONObject(LResult);
      if LParamsObject = nil then
        Exit;
      //Valida se exite a chave e valor e array
      LParamsArray := LParamsObject.Values['params'] as TJSONArray;
      if LParamsArray = nil then
        Exit;
      //Se passou nas validações da um Loop Alimentanto o ResultParams com valores retornados
      for LFor := 0 to LParamsArray.Count -1 do
      begin
        LValuesObject := LParamsArray.Items[LFor] as TJSONObject;
        with FResultParams.Add as TParam do
        begin
          for LPar := 0 to LValuesObject.Count -1 do
          begin
            Name := LValuesObject.Pairs[LPar].JsonString.Value;
            DataType := ftString;
            Value := LValuesObject.Pairs[LPar].JsonValue.Value
          end;
        end;
      end;
    finally
      if LParamsObject <> nil then LParamsObject.Free;
      //Retorna um Array Vazio
      Result := TGOXJson.JSONStringToObjectList<M>('[]');
    end;
  end;
end;

function TSessionObjectSetRest<M>.Find: TObjectList<M>;
var
  LJSON: string;
  LSubResource: String;
begin
  //Prepara Resource
  LSubResource := '';
  LSubResource := ifThen(Length(FConnection.MethodGET) > 0, FConnection.MethodGET, FSubResource);
  //
  //Executar Request
  LJSON := FConnection.Execute(FResource, LSubResource, rtGET);
  //
  // Caso o JSON retornado não seja um array, é tranformado em um.
  if LJSON.Length = 0 then LJSON := '[]' else
  if LJSON = '{}' then LJSON := '[]' else
  if Copy(LJSON,1,1) = '{' then LJSON := '[' + LJSON + ']';
  //
  // Transforma o JSON recebido populando uma lista de objetos
  Result := TGOXJson.JSONStringToObjectList<M>(LJSON);
end;

procedure TSessionObjectSetRest<M>.Insert(const AObject: M);
var
  LJSON: String;
  LSubResource: String;
  LURI: String;
  LResult: String;
  LParamsObject: TJSONObject;
  LParamsArray: TJSONArray;
  LValuesObject: TJSONObject;
  LFor: Integer;
  LPar: Integer;
begin
  //Prepara Resource
  LSubResource := '';
  LSubResource := ifThen(Length(FConnection.MethodPOST) > 0, FConnection.MethodPOST, FSubResource);
  //
  //Executar Request
  LJSON := TGOXJson.ObjectToJSONString(AObject);
  LResult := FConnection.Execute(FResource, LSubResource, rtPOST, LJSON);
  //
  // Gera lista de params com o retorno, se existir o elemento "params" no JSON.
  try
    FResultParams.Clear;
    //Valida se retornou um JSONObjct
    LParamsObject := TGOXJson.JSONStringToJSONObject(LResult);
    if LParamsObject = nil then
      Exit;
    //Valida se exite a chave e valor e array
    LParamsArray := LParamsObject.Values['params'] as TJSONArray;
    if LParamsArray = nil then
      Exit;
    //Se passou nas validações da um Loop Alimentanto o ResultParams com valores retornados
    for LFor := 0 to LParamsArray.Count -1 do
    begin
      LValuesObject := LParamsArray.Items[LFor] as TJSONObject;
      with FResultParams.Add as TParam do
      begin
        for LPar := 0 to LValuesObject.Count -1 do
        begin
          Name := LValuesObject.Pairs[LPar].JsonString.Value;
          DataType := ftString;
          Value := LValuesObject.Pairs[LPar].JsonValue.Value
        end;
      end;
    end;
  finally
    if LParamsObject <> nil then LParamsObject.Free;
  end;
end;

procedure TSessionObjectSetRest<M>.InsertFrom(const ASubResourceName: String);
var
  LResource: String;
  LSubResource: String;
  LResult: String;
  LParamsObject: TJSONObject;
  LParamsArray: TJSONArray;
  LValuesObject: TJSONObject;
  LFor: Integer;
  LPar: Integer;
begin
  inherited;
  //Prepara Resource
  LResource := FResource;
  LSubResource := '';
  LSubResource := ASubResourceName;
  //
  //Executar Request
  LResult := FConnection.Execute(LResource, LSubResource, rtPOST);
  //
  // Gera lista de params com o retorno, se existir o elemento "params" no JSON.
  try
    FResultParams.Clear;
    //Valida se retornou um JSONObjct
    LParamsObject := TGOXJson.JSONStringToJSONObject(LResult);
    if LParamsObject = nil then
      Exit;
    //Valida se exite a chave e valor e array
    LParamsArray := LParamsObject.Values['params'] as TJSONArray;
    if LParamsArray = nil then
      Exit;
    //Se passou nas validações da um Loop Alimentanto o ResultParams com valores retornados
    for LFor := 0 to LParamsArray.Count -1 do
    begin
      LValuesObject := LParamsArray.Items[LFor] as TJSONObject;
      with FResultParams.Add as TParam do
      begin
        for LPar := 0 to LValuesObject.Count -1 do
        begin
          Name := LValuesObject.Pairs[LPar].JsonString.Value;
          DataType := ftString;
          Value := LValuesObject.Pairs[LPar].JsonValue.Value
        end;
      end;
    end;
  finally
    if LParamsObject <> nil then LParamsObject.Free;
  end;
end;

procedure TSessionObjectSetRest<M>.Update(const AObjectList: TObjectList<M>);
var
  LJSON: String;
  LSubResource: String;
  LURI: String;
  LResult: String;
  LResource: String;
  //
  LParamsObject: TJSONObject;
  LParamsArray: TJSONArray;
  LValuesObject: TJSONObject;
  LFor: Integer;
  LPar: Integer;
begin
  LJSON := '';
  //Prepara Resource
  LResource := FResource;
  LSubResource := '';
  LSubResource := ifThen(Length(FConnection.MethodPUT) > 0, FConnection.MethodPUT, FSubResource);
  for var LForX := 0 to AObjectList.Count -1 do
  begin
    //Executar Request
    LJSON := TGOXJson.ObjectToJSONString(AObjectList.Items[LFor]);
    LResult := FConnection.Execute(LResource, LSubResource, rtPUT, LJSON);
    //
    // Gera lista de params com o retorno, se existir o elemento "params" no JSON.
    try
      FResultParams.Clear;
      //Valida se retornou um JSONObjct
      LParamsObject := TGOXJson.JSONStringToJSONObject(LResult);
      if LParamsObject = nil then
        Exit;
      //Valida se exite a chave e valor e array
      LParamsArray := LParamsObject.Values['params'] as TJSONArray;
      if LParamsArray = nil then
        Exit;
      //Se passou nas validações da um Loop Alimentanto o ResultParams com valores retornados
      for LFor := 0 to LParamsArray.Count -1 do
      begin
        LValuesObject := LParamsArray.Items[LFor] as TJSONObject;
        with FResultParams.Add as TParam do
        begin
          for LPar := 0 to LValuesObject.Count -1 do
          begin
            Name := LValuesObject.Pairs[LPar].JsonString.Value;
            DataType := ftString;
            Value := LValuesObject.Pairs[LPar].JsonValue.Value
          end;
        end;
      end;
    finally
      if LParamsObject <> nil then LParamsObject.Free;
    end;
  end;
end;

procedure TSessionObjectSetRest<M>.UpdateFrom(const ASubResourceName: String);
var
  LResource: String;
  LSubResource: String;

  LResult: String;
  LParamsObject: TJSONObject;
  LParamsArray: TJSONArray;
  LValuesObject: TJSONObject;
  LFor: Integer;
  LPar: Integer;
begin
  inherited;
  //Prepara Resource
  //Prepara Resource
  LResource := FResource;
  LSubResource := '';
  LSubResource := ASubResourceName;
  //
  LResult := FConnection.Execute(LResource, LSubResource, rtPUT);
  //
  // Gera lista de params com o retorno, se existir o elemento "params" no JSON.
  try
    FResultParams.Clear;
    //Valida se retornou um JSONObjct
    LParamsObject := TGOXJson.JSONStringToJSONObject(LResult);
    if LParamsObject = nil then
      Exit;
    //Valida se exite a chave e valor e array
    LParamsArray := LParamsObject.Values['params'] as TJSONArray;
    if LParamsArray = nil then
      Exit;
    //Se passou nas validações da um Loop Alimentanto o ResultParams com valores retornados
    for LFor := 0 to LParamsArray.Count -1 do
    begin
      LValuesObject := LParamsArray.Items[LFor] as TJSONObject;
      with FResultParams.Add as TParam do
      begin
        for LPar := 0 to LValuesObject.Count -1 do
        begin
          Name := LValuesObject.Pairs[LPar].JsonString.Value;
          DataType := ftString;
          Value := LValuesObject.Pairs[LPar].JsonValue.Value
        end;
      end;
    end;
  finally
    if LParamsObject <> nil then LParamsObject.Free;
  end;
end;

procedure TSessionObjectSetRest<M>.RefreshRecord(const AColumns: TParams);
var
  LObjectList: TObjectList<M>;
  LFindWhere: String;
  LWhereOld: String;
  LOrderByOld: String;
  LFor: Integer;
begin
  inherited;
  FFindWhereRefreshUsed := True;
  LWhereOld := FWhere;
  LOrderByOld := FOrderBy;
  try
    LFindWhere := '';
    for LFor := 0 to AColumns.Count -1 do
    begin
      LFindWhere := LFindWhere + AColumns[LFor].Name + '=' + AColumns[LFor].AsString;
      if LFor < AColumns.Count -1 then
        LFindWhere := LFindWhere + ' AND ';
    end;
    LObjectList := FindWhere(LFindWhere, '');
    if LObjectList = nil then
      Exit;
    try
     // FOwner.RefreshRecordInternal(LObjectList.First);
    finally
      LObjectList.Clear;
      LObjectList.Free;
    end;
  finally
    FWhere := LWhereOld;
    FOrderBy := LOrderByOld;
    FFindWhereRefreshUsed := False;
  end;
end;

function TSessionObjectSetRest<M>.Request: TGOXRESTRequestEngine;
begin
//  Result := FConnection.;
end;

function TSessionObjectSetRest<M>.ParseOperator(AParams: String): string;
begin
  Result := AParams;
  Result := StringReplace(Result, ' = ' , ' eq ' , [rfReplaceAll]);
  Result := StringReplace(Result, ' <> ', ' ne ' , [rfReplaceAll]);
  Result := StringReplace(Result, ' > ' , ' gt ' , [rfReplaceAll]);
  Result := StringReplace(Result, ' >= ', ' ge ' , [rfReplaceAll]);
  Result := StringReplace(Result, ' < ' , ' lt ' , [rfReplaceAll]);
  Result := StringReplace(Result, ' <= ', ' le ' , [rfReplaceAll]);
  Result := StringReplace(Result, ' + ' , ' add ', [rfReplaceAll]);
  Result := StringReplace(Result, ' - ' , ' sub ', [rfReplaceAll]);
  Result := StringReplace(Result, ' * ' , ' mul ', [rfReplaceAll]);
  Result := StringReplace(Result, ' / ' , ' div ', [rfReplaceAll]);
end;

end.
