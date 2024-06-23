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

unit goxormbr.manager.dataset.db;

interface

uses
  DB,
  SysUtils,
  Variants,
  Generics.Collections,
  {$IFDEF USE_FDMEMTABLE}
    FireDAC.Comp.Client,
    goxormbr.manager.dataset.db.adapter.fdmemtable,
  {$ENDIF}
  {$IFDEF USE_CLIENTDATASET}
    DBClient,
    goxormbr.manager.dataset.db.adapter.clientdataset,
  {$ENDIF}
  goxormbr.manager.dataset.adapter.base,
  goxormbr.core.objects.helper,
  goxormbr.core.types;

type
  TGOXManagerDataSet = class
  private
  protected
    FConnection: TGOXDBConnection;
    FRepository: TDictionary<string, TObject>;
    function Resolver<T: class, constructor>: TGOXManagerDataSetAdapterBase<T>;
    procedure ResolverDataSetType(const ADataSet: TDataSet);
  public
    constructor Create(const AConnection: TGOXDBConnection);
    destructor Destroy; override;

//    procedure NextPacket<T: class, constructor>;
//    function GetAutoNextPacket<T: class, constructor>: Boolean;
//    procedure SetAutoNextPacket<T: class, constructor>(const AValue: Boolean);

    procedure RemoveDataSet<T: class>;
    function AddDataSet<T: class, constructor>(const ADataSet: TDataSet; const APageSize: Integer = -1): TGOXManagerDataSet; overload;
    function AddDataSet<T, M: class, constructor>(const ADataSet: TDataSet): TGOXManagerDataSet; overload;

    function AddLookupField<T, M: class, constructor>(const AFieldName: string;
                                                      const AKeyFields: string;
                                                      const ALookupKeyFields: string;
                                                      const ALookupResultField: string;
                                                      const ADisplayLabel: string = ''): TGOXManagerDataSet;
    procedure Open<T: class, constructor>; overload;
    procedure Open<T: class, constructor>(const APK: Int64); overload;
    procedure Open<T: class, constructor>(const APK: String); overload;
    procedure OpenWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''); overload;
    procedure OpenWhere<T: class, constructor>(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer); overload;



    procedure Close<T: class, constructor>;
    procedure RefreshRecord<T: class, constructor>;
    procedure EmptyDataSet<T: class, constructor>;
    procedure CancelUpdates<T: class, constructor>;
    procedure ApplyUpdates<T: class, constructor>(const MaxErros: Integer);
    procedure Save<T: class, constructor>(AObject: T);
    function Current<T: class, constructor>: T;
    function DataSet<T: class, constructor>: TDataSet;
    function PrepareWhereFieldAll<T: class, constructor>(AValue:String):String;
    // ObjectSet
    function Find<T: class, constructor>: TObjectList<T>; overload;
    function Find<T: class, constructor>(const APK: Variant): T; overload;
    function FindWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''): TObjectList<T>;
    //
    function AutoNextPacket<T: class, constructor>(const AValue: Boolean): TGOXManagerDataSet;

    function InitFieldDefsObjectClass<T: class, constructor>(ADataSet: TDataSet):TGOXManagerDataSet;
  end;

implementation

{ TGOXManagerDataSet }

constructor TGOXManagerDataSet.Create(const AConnection: TGOXDBConnection);
begin
  FConnection := AConnection;
  FRepository := TObjectDictionary<string, TObject>.Create([doOwnsValues]);
end;

destructor TGOXManagerDataSet.Destroy;
begin
  FRepository.Free;
  inherited;
end;

function TGOXManagerDataSet.Current<T>: T;
begin
  Result := Resolver<T>.Current;
end;

function TGOXManagerDataSet.DataSet<T>: TDataSet;
begin
  Result := Resolver<T>.FOrmDataSet;
end;

procedure TGOXManagerDataSet.EmptyDataSet<T>;
begin
  Resolver<T>.EmptyDataSet;
end;

function TGOXManagerDataSet.Find<T>(const APK: Variant): T;
begin
  if TVarData(APK).VType = varInteger then
    Result := Resolver<T>.Find(Integer(APK))
  else
  if TVarData(APK).VType = varString then
    Result := Resolver<T>.Find(VarToStr(APK))
end;

function TGOXManagerDataSet.Find<T>: TObjectList<T>;
var
  LObjectList: TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.Find;
end;

procedure TGOXManagerDataSet.CancelUpdates<T>;
begin
  Resolver<T>.CancelUpdates;
end;

procedure TGOXManagerDataSet.Close<T>;
begin
  Resolver<T>.EmptyDataSet;
end;

function TGOXManagerDataSet.AddDataSet<T, M>(const ADataSet: TDataSet): TGOXManagerDataSet;
var
  LDataSetAdapter: TGOXManagerDataSetAdapterBase<T>;
  LMaster: TGOXManagerDataSetAdapterBase<T>;
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
  LMaster := TGOXManagerDataSetAdapterBase<T>(FRepository.Items[LMasterName]);
  if LMaster = nil then
    Exit;

  // Checagem do tipo do dataset definido para uso
  ResolverDataSetType(ADataSet);
  {$IFDEF USE_FDMEMTABLE}
    LDataSetAdapter := TGOXManagerDatasetAdapterFDMemTable<T>.Create(FConnection, ADataSet, -1, LMaster);
  {$ENDIF}
  {$IFDEF USE_CLIENTDATASET}
    LDataSetAdapter := TGOXManagerDatasetAdapterClientDataSet<T>.Create(FConnection, ADataSet, -1, LMaster);
  {$ENDIF}
  // Adiciona o container ao repositório
  FRepository.Add(LClassName, LDataSetAdapter);
end;

function TGOXManagerDataSet.AddDataSet<T>(const ADataSet: TDataSet; const APageSize: Integer): TGOXManagerDataSet;
var
  LDataSetAdapter: TGOXManagerDataSetAdapterBase<T>;
  LClassName: String;
begin
  Result := Self;
  LClassName := TClass(T).ClassName;
  if FRepository.ContainsKey(LClassName) then
    Exit;

  // Checagem do tipo do dataset definido para uso
  ResolverDataSetType(ADataSet);
    {$IFDEF USE_FDMEMTABLE}
      LDataSetAdapter := TGOXManagerDatasetAdapterFDMemTable<T>.Create(FConnection, ADataSet, APageSize, nil);
  {$ENDIF}
  {$IFDEF USE_CLIENTDATASET}
      LDataSetAdapter := TGOXManagerDatasetAdapterClientDataSet<T>.Create(FConnection, ADataSet, APageSize, nil);
    {$ENDIF}

  // Adiciona o container ao repositório
  FRepository.Add(LClassName, LDataSetAdapter);
end;

function TGOXManagerDataSet.AddLookupField<T, M>(const AFieldName, AKeyFields: string;  const ALookupKeyFields, ALookupResultField, ADisplayLabel: string): TGOXManagerDataSet;
var
  LObject: TGOXManagerDataSetAdapterBase<M>;
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

procedure TGOXManagerDataSet.ApplyUpdates<T>(const MaxErros: Integer);
begin
  Resolver<T>.ApplyUpdates(MaxErros);
end;

function TGOXManagerDataSet.AutoNextPacket<T>(const AValue: Boolean): TGOXManagerDataSet;
begin
  Resolver<T>.AutoNextPacket := AValue;
end;

procedure TGOXManagerDataSet.Open<T>(const APK: String);
begin
  Resolver<T>.OpenIDInternal(APK);
end;

procedure TGOXManagerDataSet.OpenWhere<T>(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer);
var
 LRowsByPage : Integer;
 LObj : TObject;
 LOrderBy:String;
begin
  LOrderBy := AOrderBy;
  if LOrderBy.Length = 0 then
  begin
    LObj := T.Create;
    if Length(LObj.GetPrimaryKey.Columns[0]) > 0 then
    LOrderBy := LObj.GetPrimaryKey.Columns[0]+' Desc';
    FreeAndNil(LObj);
  end;
  //Se ARowsByPage for igual -1 força buscar todos registros
  if ARowsByPage < 1 then
  LRowsByPage := 99999999 else LRowsByPage := ARowsByPage;
  //
  Resolver<T>.OpenWhere( AWhere, LOrderBy, APageNumber, LRowsByPage);
end;

procedure TGOXManagerDataSet.OpenWhere<T>(const AWhere,
  AOrderBy: string);
begin
  Resolver<T>.OpenWhereInternal(AWhere, AOrderBy);
end;

function TGOXManagerDataSet.PrepareWhereFieldAll<T>(AValue: String): String;
begin
  Resolver<T>.PrepareWhereFieldAll(AValue);
end;

procedure TGOXManagerDataSet.Open<T>(const APK: Int64);
begin
  Resolver<T>.OpenIDInternal(APK);
end;

procedure TGOXManagerDataSet.Open<T>;
begin
  Resolver<T>.OpenSQLInternal('');
end;

procedure TGOXManagerDataSet.RefreshRecord<T>;
begin
  Resolver<T>.RefreshRecord;
end;

procedure TGOXManagerDataSet.RemoveDataSet<T>;
var
  LClassName: String;
begin
  LClassName := TClass(T).ClassName;
  if not FRepository.ContainsKey(LClassName) then
    Exit;

  FRepository.Remove(LClassName);
  FRepository.TrimExcess;
end;

function TGOXManagerDataSet.Resolver<T>: TGOXManagerDataSetAdapterBase<T>;
var
  LClassName: String;
begin
  Result := nil;
  LClassName := TClass(T).ClassName;
  if FRepository.ContainsKey(LClassName) then
    Result := TGOXManagerDataSetAdapterBase<T>(FRepository.Items[LClassName]);
end;

procedure TGOXManagerDataSet.ResolverDataSetType(const ADataSet: TDataSet);
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

procedure TGOXManagerDataSet.Save<T>(AObject: T);
begin
  Resolver<T>.Save(AObject);
end;

function TGOXManagerDataSet.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
var
  LObjectList: TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.FindWhere(AWhere, AOrderBy);
end;

function TGOXManagerDataSet.InitFieldDefsObjectClass<T>(ADataSet: TDataSet): TGOXManagerDataSet;
begin
  Result := Self;
  Resolver<T>.InitFieldDefsObjectClass(ADataSet);
end;

//{$IFNDEF DRIVERRESTFUL}
//procedure TGOXManagerDataSet.NextPacket<T>;
//begin
//  Resolver<T>.NextPacket;
//end;
//
//function TGOXManagerDataSet.GetAutoNextPacket<T>: Boolean;
//begin
//  Result := Resolver<T>.AutoNextPacket;
//end;
//
//procedure TGOXManagerDataSet.SetAutoNextPacket<T>(const AValue: Boolean);
//begin
//  Resolver<T>.AutoNextPacket := AValue;
//end;
//{$ENDIF}

end.
