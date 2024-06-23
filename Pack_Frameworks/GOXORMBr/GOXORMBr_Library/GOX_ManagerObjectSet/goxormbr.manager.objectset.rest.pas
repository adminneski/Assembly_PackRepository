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

unit goxormbr.manager.objectset.rest;

interface

uses
  Data.DB,
  System.JSON,
  System.Rtti,
  System.SysUtils,
  Generics.Collections,
  //GOXORMBr
  goxormbr.manager.objectset.db.adapter.base,
  goxormbr.manager.objectset.rest.adapter,
  goxormbr.core.types,
  goxormbr.core.json.utils;


type
//  TRepository = class
//  private
//    FObjectSet: TObject;
////    FNestedList: TObjectList<TObject>;
//  public
//    constructor Create;
//    destructor Destroy; override;
//    property ObjectSet: TObject read FObjectSet write FObjectSet;
////    property NestedList: TObjectList<TObject> read FNestedList write FNestedList;
//  end;
  // Lista de Container
  TRepositoryList = TObjectDictionary<string, TObject>;

  // TGOXManagerObjectSetRest
  TGOXManagerObjectSetRest = class
  private
  protected
    FConnection: TGOXRESTConnection;
    FRepository: TRepositoryList;
//    FCurrentIndex: Integer;
 //   FSelectedObject: TObject;
 //   FOwnerNestedList: Boolean;
    function Resolver<T: class, constructor>: TGOXManagerObjectSetAdapterRest<T>;// jeison //colocar restapadper rest aqui ao inves do base

//    procedure ListChanged<T: class, constructor>(Sender: TObject; const Item: T; Action: TCollectionNotification);
//    procedure SelectNestedListItem<T: class>;
  public
    constructor Create(const AConnection: TGOXRESTConnection);
    destructor Destroy; override;
    function AddObjectSet<T: class, constructor>(const APageSize: Integer = -1): TGOXManagerObjectSetRest;
    // ObjectSet
    function Find<T: class, constructor>: TObjectList<T>; overload;
    function Find<T: class, constructor>(const APK: Int64): T; overload;
    function Find<T: class, constructor>(const APK: String): T; overload;
    function FindWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''): TObjectList<T>; overload;
    function FindWhere<T: class, constructor>(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<T>; overload;
    function FindFrom<T: class, constructor>(const ASubResourceName: String): TObjectList<T>;
    // Métodos para serem usados com a propriedade OwnerNestedList := False;
    procedure Insert<T: class, constructor>(const AObject: T); overload;
    procedure InsertFrom<T: class, constructor>(const ASubResourceName: String);
    procedure Update<T: class, constructor>(const AObject: T); overload;
    procedure UpdateFrom<T: class, constructor>(const ASubResourceName: String);
    procedure Delete<T: class, constructor>(const AObject: T); overload;
    procedure DeleteFrom<T: class, constructor>(const ASubResourceName: String);
    //
    procedure Modify<T: class, constructor>(const AObject: T); overload;
    procedure New<T: class, constructor>(var AObject: T); overload;
    //
    function AddPathParam<T: class, constructor>(AValue: String):TGOXManagerObjectSetRest;
    function AddQueryParam<T: class, constructor>(AKeyName, AValue: String):TGOXManagerObjectSetRest;
    function AddBodyParam<T: class, constructor>(AValue: String):TGOXManagerObjectSetRest;
    function ResultParams<T: class, constructor>: TParams;
    //
    function ModifiedFields<T: class, constructor>: TDictionary<string, TDictionary<string, string>>;
    function ExistSequence<T: class, constructor>: Boolean;
    function PrepareWhereFieldAll<T: class, constructor>(AValue:String):String;
    function Response<T: class, constructor>: TRESTResponseInfo;
    //
    function ConvertToJSONValue(var AObject: TObject):TJSONValue;
  end;

implementation

{ TGOXManagerObjectSetRest }



function TGOXManagerObjectSetRest.AddPathParam<T>(AValue: String): TGOXManagerObjectSetRest;
begin
  Result := Self;
  Resolver<T>.AddPathParam(AValue);
end;

function TGOXManagerObjectSetRest.AddQueryParam<T>(AKeyName, AValue: String): TGOXManagerObjectSetRest;
begin
  Result := Self;
  Resolver<T>.AddQueryParam(AKeyName, AValue);
end;

function TGOXManagerObjectSetRest.ConvertToJSONValue(var AObject: TObject): TJSONValue;
begin
  Result := TGOXJson.ObjectToJSON(AObject);
end;

constructor TGOXManagerObjectSetRest.Create(const AConnection: TGOXRESTConnection);
begin
  FConnection := AConnection;
  FRepository := TRepositoryList.Create([doOwnsValues]);
//  FCurrentIndex := 0;
//  FOwnerNestedList := False;
end;

procedure TGOXManagerObjectSetRest.Delete<T>(const AObject: T);
begin
  Resolver<T>.Delete(AObject);
end;

procedure TGOXManagerObjectSetRest.DeleteFrom<T>(const ASubResourceName: String);
begin
  Resolver<T>.DeleteFrom(ASubResourceName);
end;

destructor TGOXManagerObjectSetRest.Destroy;
begin
  FRepository.Free;
  inherited;
end;

procedure TGOXManagerObjectSetRest.New<T>(var AObject: T);
begin
  AObject := nil;
  Resolver<T>.New(AObject);
end;

function TGOXManagerObjectSetRest.ExistSequence<T>: Boolean;
begin
  Result := Resolver<T>.ExistSequence;
end;

function TGOXManagerObjectSetRest.Find<T>(const APK: Int64): T;
begin
  Result := Resolver<T>.Find(APK);
//  FCurrentIndex := 0;
end;

function TGOXManagerObjectSetRest.AddBodyParam<T>(AValue: String): TGOXManagerObjectSetRest;
begin
  Result := Self;
  Resolver<T>.AddBodyParam(AValue);
end;

function TGOXManagerObjectSetRest.AddObjectSet<T>(const APageSize: Integer): TGOXManagerObjectSetRest;
var
  LObjectetAdapter: TGOXManagerObjectSetAdapterBase<T>;
  LClassName: String;
//  LRepository: TRepository;
begin
  Result := Self;
  LClassName := TClass(T).ClassName;
  if FRepository.ContainsKey(LClassName) then Exit;
  //
  LObjectetAdapter := TGOXManagerObjectSetAdapterRest<T>.Create(FConnection, APageSize);
  // Adiciona o container ao repositório de containers
//  LRepository := TRepository.Create;
//  LRepository.ObjectSet := LObjectetAdapter;
  FRepository.Add(LClassName, LObjectetAdapter);
end;

function TGOXManagerObjectSetRest.Find<T>: TObjectList<T>;
var
  LObjectList: TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.Find;

//  LObjectList := Resolver<T>.Find;
//  LObjectList.OnNotify := ListChanged<T>;
//  // Lista de objetos
//  FRepository.Items[TClass(T).ClassName].NestedList.Free;
//  FRepository.Items[TClass(T).ClassName].NestedList := TObjectList<TObject>(LObjectList);
//  FCurrentIndex := 0;
end;

function TGOXManagerObjectSetRest.Resolver<T>: TGOXManagerObjectSetAdapterRest<T>;
var
  LClassName: String;
begin
  Result := nil;
  LClassName := TClass(T).ClassName;
  if not FRepository.ContainsKey(LClassName) then
    raise Exception.Create('Use the AddObjectSet<T> method to add the class to manager');
  Result := TGOXManagerObjectSetAdapterRest<T>(FRepository.Items[LClassName]);
end;

function TGOXManagerObjectSetRest.Response<T>: TRESTResponseInfo;
begin
  Result := FConnection.Response;
end;

function TGOXManagerObjectSetRest.ResultParams<T>: TParams;
begin
 Result := Resolver<T>.ResultParams;
end;

//procedure TGOXManagerObjectSetRest.SelectNestedListItem<T>;
//begin
//  FSelectedObject := FRepository.Items[TClass(T).ClassName].NestedList.Items[FCurrentIndex];
//end;

procedure TGOXManagerObjectSetRest.Update<T>(const AObject: T);
begin
  Resolver<T>.Update(AObject);
end;

procedure TGOXManagerObjectSetRest.UpdateFrom<T>(const ASubResourceName: String);
begin
  Resolver<T>.UpdateFrom(ASubResourceName);
end;

function TGOXManagerObjectSetRest.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
var
  LObjectList: TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.FindWhere(AWhere, AOrderBy);

//  LObjectList := Resolver<T>.FindWhere(AWhere, AOrderBy);
//  LObjectList.OnNotify := ListChanged<T>;
//  // Lista de objetos
//  FRepository.Items[TClass(T).ClassName].NestedList.Free;
//  FRepository.Items[TClass(T).ClassName].NestedList := TObjectList<TObject>(LObjectList);
//  FCurrentIndex := 0;
end;

procedure TGOXManagerObjectSetRest.Insert<T>(const AObject: T);
begin
  Resolver<T>.Insert(AObject);
end;

procedure TGOXManagerObjectSetRest.InsertFrom<T>(const ASubResourceName: String);
begin
  Resolver<T>.InsertFrom(ASubResourceName);
end;

//procedure TGOXManagerObjectSetRest.ListChanged<T>(Sender: TObject; const Item: T;
//  Action: TCollectionNotification);
//var
//  LClassName: String;
//begin
//  if Action = cnAdded then // After
//  begin
//    FCurrentIndex := FRepository.Items[TClass(T).ClassName].NestedList.Count -1;
//  end
//  else
//  if Action = cnRemoved then // After
//  begin
//    LClassName := TClass(T).ClassName;
//    if not FRepository.ContainsKey(LClassName) then
//      Exit;
//
//    if FRepository.Items[LClassName].NestedList.Count = 0 then
//      Dec(FCurrentIndex);
//
//    if FRepository.Items[LClassName].NestedList.Count > 1 then
//      Dec(FCurrentIndex);
//  end
//  else
//  if Action = cnExtracted then // After
//  begin
//
//  end;
//end;

function TGOXManagerObjectSetRest.ModifiedFields<T>: TDictionary<string, TDictionary<string, string>>;
begin
  Result := Resolver<T>.ModifiedFields;
end;


procedure TGOXManagerObjectSetRest.Modify<T>(const AObject: T);
begin
  Resolver<T>.Modify(AObject);
end;

function TGOXManagerObjectSetRest.PrepareWhereFieldAll<T>(AValue: String): String;
begin
  Result := Resolver<T>.PrepareWhereFieldAll(AValue);
end;


function TGOXManagerObjectSetRest.FindFrom<T>(const ASubResourceName: String): TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.FindFrom(ASubResourceName);
end;

function TGOXManagerObjectSetRest.Find<T>(const APK: String): T;
begin
  Result := Resolver<T>.Find(APK);
//  FCurrentIndex := 0;
end;

function TGOXManagerObjectSetRest.FindWhere<T>(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer): TObjectList<T>;
var
 LRowsByPage : Integer;
begin
  Result := nil;
  //Se ARowsByPage for igual -1 força buscar todos registros
  if ARowsByPage < 1 then
  LRowsByPage := 99999999 else LRowsByPage := ARowsByPage;

  Result := Resolver<T>.FindWhere(AWhere,AOrderBy,APageNumber,LRowsByPage);
end;

{ TRepository }

//constructor TRepository.Create;
//begin
//
//end;

//destructor TRepository.Destroy;
//begin
//  if Assigned(FObjectSet) then
//    FObjectSet.Free;
//  inherited;
//end;

end.
