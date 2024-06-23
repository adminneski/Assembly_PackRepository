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


{$INCLUDE    ..\goxorm.inc}

unit goxormbr.manager.dataset.rest;

interface

uses
  DB,
  SysUtils,
  Variants,
  Generics.Collections,
  System.TypInfo,
  NetEncoding,
  {$IFDEF USE_FDMEMTABLE}
    FireDAC.Comp.Client,
    goxormbr.manager.dataset.rest.adapter.fdmemtable,
  {$ENDIF}
  {$IFDEF USE_CLIENTDATASET}
    DBClient,
    goxormbr.manager.dataset.adapter.clientdataset.rest,
  {$ENDIF}
//  goxormbr.manager.dataset.adapter.base,
  goxormbr.manager.dataset.rest.adapter,
  goxormbr.core.json.utils,
  goxormbr.core.types,
  System.JSON;

type

  TRepositoryList = TObjectDictionary<string, TObject>;

  TGOXManagerDataSetRest = class
  private
  protected
    FConnection: TGOXRESTConnection;
    FRepository: TRepositoryList;
//    FResponse : TRESTResponseInfo;

    function Resolver<T: class, constructor>: TGOXManagerDataSetAdapterRest<T>;
    procedure ResolverDataSetType(const ADataSet: TDataSet);
  public
    constructor Create(const AConnection: TGOXRESTConnection);
    destructor Destroy; override;
    //
//    function AddPathParam(AValue: String):TGOXManagerDataSetRest;
//    function AddQueryParam(AKeyName, AValue: String):TGOXManagerDataSetRest;
//    function AddBodyParam(AValue: String):TGOXManagerDataSetRest;

    procedure RemoveDataSet<T: class>;
    function AddDataSet<T: class, constructor>(const ADataSet: TDataSet; const APageSize: Integer = -1): TGOXManagerDataSetRest; overload;
    function AddDataSet<T, M: class, constructor>(const ADataSet: TDataSet): TGOXManagerDataSetRest; overload;
    function AddLookupField<T, M: class, constructor>(const AFieldName: string;
                                                      const AKeyFields: string;
                                                      const ALookupKeyFields: string;
                                                      const ALookupResultField: string;
                                                      const ADisplayLabel: string = ''): TGOXManagerDataSetRest;
    procedure Open<T: class, constructor>; overload;
    procedure Open<T: class, constructor>(const APK: Int64); overload;
    procedure Open<T: class, constructor>(const APK: String); overload;
    procedure OpenWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''); overload;
    procedure OpenWhere<T: class, constructor>(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer); overload;
    procedure OpenFrom<T: class, constructor>(const ASubResourceName: String);
    //
    procedure Close<T: class, constructor>;
    procedure RefreshRecord<T: class, constructor>;
    procedure EmptyDataSet<T: class, constructor>;
    procedure CancelUpdates<T: class, constructor>;
    procedure ApplyUpdates<T: class, constructor>(const MaxErros: Integer);
    //
    // ObjectSet
    function Find<T: class, constructor>: TObjectList<T>; overload;
    function Find<T: class, constructor>(const APK: Variant): T; overload;
    function FindWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''): TObjectList<T>; overload;
    function FindWhere<T: class, constructor>(const AWhere: String; AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<T>; overload;
    function FindFrom<T: class, constructor>(const ASubResourceName: String): TObjectList<T>;
    //
    procedure Save<T: class, constructor>(AObject: T);
    procedure ApplyDataIncludedLast<T: class, constructor>(AObject: T);
    function Current<T: class, constructor>: T;
    function CurrentToJSONValue<T: class, constructor>: TJSONValue;

    function DataSet<T: class, constructor>: TDataSet;
    //
    function AddPathParam<T: class, constructor>(AValue: String):TGOXManagerDataSetRest;
    function AddQueryParam<T: class, constructor>(AKeyName, AValue: String):TGOXManagerDataSetRest;
    function AddBodyParam<T: class, constructor>(AValue: String):TGOXManagerDataSetRest;
    //
    function Response<T: class, constructor>: TRESTResponseInfo;
    function ResultParams<T: class, constructor>: TParams;

    function PrepareWhereFieldAll<T: class, constructor>(AValue:String):String;
//    function AutoNextPacket<T: class, constructor>(const AValue: Boolean): TGOXManagerDataSetRest;

    function InitFieldDefsObjectClass<T: class, constructor>(ADataSet: TDataSet):TGOXManagerDataSetRest;
   end;

implementation

{ TGOXManagerDataSetRest }

constructor TGOXManagerDataSetRest.Create(const AConnection: TGOXRESTConnection);
begin
  FConnection := AConnection;
  FRepository := TRepositoryList.Create([doOwnsValues]);
//  FResponse := TRESTResponseInfo.Create;
end;

destructor TGOXManagerDataSetRest.Destroy;
var
  LClassName: String;
begin
  FreeAndNil(FRepository);
  inherited;
end;

function TGOXManagerDataSetRest.Current<T>: T;
begin
  Result := Resolver<T>.Current;
end;

function TGOXManagerDataSetRest.CurrentToJSONValue<T>: TJSONValue;
begin
  Result := TGOXJson.ObjectToJSON(Resolver<T>.Current);
end;

function TGOXManagerDataSetRest.DataSet<T>: TDataSet;
begin
  Result := Resolver<T>.FOrmDataSet;
end;

procedure TGOXManagerDataSetRest.EmptyDataSet<T>;
begin
  Resolver<T>.EmptyDataSet;
end;

function TGOXManagerDataSetRest.Find<T>(const APK: Variant): T;
begin
  if TVarData(APK).VType = varInteger then
    Result := Resolver<T>.Find(Integer(APK))
  else
  if TVarData(APK).VType = varString then
    Result := Resolver<T>.Find(VarToStr(APK))
end;

function TGOXManagerDataSetRest.FindWhere<T>(const AWhere: String; AOrderBy: String; const APageNumber, ARowsByPage: Integer): TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.FindWhere(AWhere, AOrderBy, APageNumber,ARowsByPage);
end;

function TGOXManagerDataSetRest.InitFieldDefsObjectClass<T>(ADataSet: TDataSet): TGOXManagerDataSetRest;
begin
  Result := Self;
  Resolver<T>.InitFieldDefsObjectClass(ADataSet);
end;

function TGOXManagerDataSetRest.FindFrom<T>(const ASubResourceName: String): TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.FindFrom(ASubResourceName);
end;

function TGOXManagerDataSetRest.Find<T>: TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.Find;
end;

procedure TGOXManagerDataSetRest.CancelUpdates<T>;
begin
  Resolver<T>.CancelUpdates;
end;

procedure TGOXManagerDataSetRest.Close<T>;
begin
  Resolver<T>.EmptyDataSet;
end;

function TGOXManagerDataSetRest.AddBodyParam<T>(AValue: String): TGOXManagerDataSetRest;
begin
  Result := Self;
  Resolver<T>.AddBodyParam(AValue);
end;

function TGOXManagerDataSetRest.AddDataSet<T, M>(const ADataSet: TDataSet): TGOXManagerDataSetRest;
var
  LDataSetAdapter: TGOXManagerDataSetAdapterRest<T>;
  LMaster: TGOXManagerDataSetAdapterRest<T>;
  LClassName: String;
  LMasterName: String;
begin
  Result := Self;
  LClassName := TClass(T).ClassName;
  LMasterName := TClass(M).ClassName;
  if FRepository.ContainsKey(LClassName) then
    Exit;
  if not FRepository.ContainsKey(LMasterName) then
    Exit;
  LMaster := TGOXManagerDataSetAdapterRest<T>(FRepository.Items[LMasterName]);
  if LMaster = nil then
    Exit;

  // Checagem do tipo do dataset definido para uso
  ResolverDataSetType(ADataSet);
  {$IFDEF USE_FDMEMTABLE}
    LDataSetAdapter := TGOXManagerDatasetAdapterRestFDMemTable<T>.Create(FConnection, ADataSet, -1, LMaster);
  {$ENDIF}
  {$IFDEF USE_CLIENTDATASET}
    LDataSetAdapter := TGOXManagerDatasetAdapterRestClientDataset<T>.Create(FConnection, ADataSet, -1, LMaster);
  {$ENDIF}
  // Adiciona o container ao repositório
  FRepository.AddOrSetValue(LClassName, LDataSetAdapter);
end;

function TGOXManagerDataSetRest.AddDataSet<T>(const ADataSet: TDataSet; const APageSize: Integer): TGOXManagerDataSetRest;
var
  LDataSetAdapter: TGOXManagerDataSetAdapterRest<T>;
  LClassName: String;
begin
  Result := Self;
  LClassName := TClass(T).ClassName;
  if FRepository.ContainsKey(LClassName) then
    Exit;

  // Checagem do tipo do dataset definido para uso
  ResolverDataSetType(ADataSet);
  {$IFDEF USE_FDMEMTABLE}
    LDataSetAdapter := TGOXManagerDatasetAdapterRestFDMemTable<T>.Create(FConnection, ADataSet, APageSize, nil);
  {$ENDIF}
  {$IFDEF USE_CLIENTDATASET}
    LDataSetAdapter := TGOXManagerDatasetAdapterRestClientDataset<T>.Create(FConnection, ADataSet, APageSize, nil);
  {$ENDIF}
  // Adiciona o container ao repositório
  FRepository.AddOrSetValue(LClassName, LDataSetAdapter);
end;

function TGOXManagerDataSetRest.AddLookupField<T, M>(const AFieldName, AKeyFields: string;  const ALookupKeyFields, ALookupResultField, ADisplayLabel: string): TGOXManagerDataSetRest;
var
  LObject: TGOXManagerDataSetAdapterRest<M>;
begin
  Result := Self;
  LObject := Resolver<M>;
  if LObject = nil then
    Exit;
  Resolver<T>.AddLookupField(AFieldName,
                             AKeyFields,
                             LObject,
                             ALookupKeyFields,
                             ALookupResultField,
                             ADisplayLabel);
end;

function TGOXManagerDataSetRest.AddPathParam<T>(AValue: String): TGOXManagerDataSetRest;
begin
  Result := Self;
  Resolver<T>.AddPathParam(AValue);
end;

function TGOXManagerDataSetRest.AddQueryParam<T>(AKeyName, AValue: String): TGOXManagerDataSetRest;
begin
  Result := Self;
  Resolver<T>.AddQueryParam(AKeyName,AValue);
end;

procedure TGOXManagerDataSetRest.ApplyDataIncludedLast<T>(AObject: T);
begin
  Resolver<T>.ApplyDataIncludedLast(AObject);
end;

procedure TGOXManagerDataSetRest.ApplyUpdates<T>(const MaxErros: Integer);
begin
  Resolver<T>.ApplyUpdates(MaxErros);
end;

//function TGOXManagerDataSetRest.AutoNextPacket<T>(const AValue: Boolean): TGOXManagerDataSetRest;
//begin
//  Resolver<T>.AutoNextPacket := AValue;
//end;

procedure TGOXManagerDataSetRest.Open<T>(const APK: String);
begin
  Resolver<T>.OpenIDInternal(APK);
end;

procedure TGOXManagerDataSetRest.OpenWhere<T>(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer);
var
 LRowsByPage : Integer;
begin
  //Se ARowsByPage for igual -1 força buscar todos registros
  if ARowsByPage < 1 then
  LRowsByPage := 99999999 else LRowsByPage := ARowsByPage;

  Resolver<T>.OpenWhere(AWhere, AOrderBy, APageNumber,LRowsByPage);
end;

procedure TGOXManagerDataSetRest.OpenFrom<T>(const ASubResourceName: String);
begin
  Resolver<T>.OpenFrom(ASubResourceName);
end;

procedure TGOXManagerDataSetRest.OpenWhere<T>(const AWhere,
  AOrderBy: string);
begin
  Resolver<T>.OpenWhereInternal(AWhere, AOrderBy);
end;

function TGOXManagerDataSetRest.PrepareWhereFieldAll<T>(AValue: String): String;
begin
 Result := Resolver<T>.PrepareWhereFieldAll(AValue);
end;

procedure TGOXManagerDataSetRest.Open<T>(const APK: Int64);
begin
  Resolver<T>.OpenIDInternal(APK);
end;

procedure TGOXManagerDataSetRest.Open<T>;
begin
  Resolver<T>.OpenSQLInternal('');
end;

procedure TGOXManagerDataSetRest.RefreshRecord<T>;
begin
  Resolver<T>.RefreshRecord;
end;

procedure TGOXManagerDataSetRest.RemoveDataSet<T>;
var
  LClassName: String;
begin
  LClassName := TClass(T).ClassName;
  if not FRepository.ContainsKey(LClassName) then
    Exit;

  FRepository.Remove(LClassName);
  FRepository.TrimExcess;
end;

function TGOXManagerDataSetRest.Resolver<T>: TGOXManagerDataSetAdapterRest<T>;
var
  LClassName: String;
begin
  Result := nil;
  LClassName := TClass(T).ClassName;
  if FRepository.ContainsKey(LClassName) then
  // Result := TGOXManagerDataSetAdapterBase<T>(FRepository.Items[LClassName]);
    Result := TGOXManagerDataSetAdapterRest<T>(FRepository.Items[LClassName]);

end;

procedure TGOXManagerDataSetRest.ResolverDataSetType(const ADataSet: TDataSet);
begin
  {$IFDEF USE_FDMEMTABLE}
    if not (ADataSet is TFDMemTable) then
      raise Exception.Create('Is not TFDMemTable type');
  {$ENDIF}
  {$IFDEF USE_CLIENTDATASET}
    if not (ADataSet is TClientDataSet) then
      raise Exception.Create('Is not TClientDataSet type');
  {$ENDIF}
//  {$IFNDEF USE_MEMDATASET}
//    raise Exception.Create('Enable the directive "USE_FDMEMTABLE" or "USE_CLIENTDATASET" in file goxorm.inc');
//  {$ENDIF}
end;

function TGOXManagerDataSetRest.Response<T>: TRESTResponseInfo;
begin
  Result := FConnection.Response;
end;

function TGOXManagerDataSetRest.ResultParams<T>: TParams;
begin
  Result := Resolver<T>.ResultParams;
end;

procedure TGOXManagerDataSetRest.Save<T>(AObject: T);
begin
  Resolver<T>.Save(AObject);
end;

function TGOXManagerDataSetRest.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.FindWhere(AWhere, AOrderBy);
end;

end.
