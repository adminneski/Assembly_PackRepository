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

unit goxormbr.manager.objectset.db;

interface

uses
  Rtti,
  SysUtils,
  Variants,
  Generics.Collections,
  //GOXORM
  goxormbr.core.objects.helper,
  goxormbr.manager.objectset.db.adapter,
  goxormbr.manager.objectset.db.adapter.base,
  goxormbr.core.types;

type
//  TRepository = class
//  private
//    FObjectSet: TObject;
//  public
//    constructor Create;
//    destructor Destroy; override;
//    property ObjectSet: TObject read FObjectSet write FObjectSet;
//  end;
  // Lista de Container
  TRepositoryList = TObjectDictionary<string, TObject>;

  // TManagerObjectSet
  TGOXManagerObjectSet = class
  private
  protected
    FConnection: TGOXDBConnection;
    FRepositoryList: TRepositoryList;
//    FCurrentIndex: Integer;
    function Resolver<T: class, constructor>: TGOXManagerObjectSetAdapterBase<T>;
  public
    constructor Create(const AConnection: TGOXDBConnection);
    destructor Destroy; override;
    function AddObjectSet<T: class, constructor>(const APageSize: Integer = -1): TGOXManagerObjectSet;
    // ObjectSet
    function Find<T: class, constructor>: TObjectList<T>; overload;
    function Find<T: class, constructor>(const APK: Int64): T; overload;
    function Find<T: class, constructor>(const APK: String): T; overload;
    function FindWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''): TObjectList<T>; overload;
    function FindWhere<T: class, constructor>(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<T>; overload;
    // Métodos para serem usados com a propriedade OwnerNestedList := False;
    procedure Insert<T: class, constructor>(const AObject: T); overload;
    procedure Update<T: class, constructor>(const AObject: T); overload;
    procedure Delete<T: class, constructor>(const AObject: T); overload;
    //
    procedure Modify<T: class, constructor>(const AObject: T); overload;
    procedure New<T: class, constructor>(var AObject: T); overload;
    //
    function GetPackagePageCount<T: class, constructor>(const AWhere: String; const ARowsByPage:Integer):Integer;
    function ModifiedFields<T: class, constructor>: TDictionary<string, TDictionary<string, string>>;
    function ExistSequence<T: class, constructor>: Boolean;
    function PrepareWhereFieldAll<T: class, constructor>(AValue:String):String;
    function CreateSQLSelect(ASQLSelect:String):TGOXDBQuery;
  end;

implementation

{ TGOXManagerObjectSet }

constructor TGOXManagerObjectSet.Create(const AConnection: TGOXDBConnection);
begin
  FConnection := AConnection;
  FRepositoryList := TRepositoryList.Create([doOwnsValues]);
//  FCurrentIndex := 0;
end;

procedure TGOXManagerObjectSet.Delete<T>(const AObject: T);
begin
  Resolver<T>.Delete(AObject);
end;

destructor TGOXManagerObjectSet.Destroy;
begin
  FRepositoryList.Clear;
  FreeAndNil(FRepositoryList);
  inherited;
end;

procedure TGOXManagerObjectSet.New<T>(var AObject: T);
begin
  AObject := nil;
  Resolver<T>.New(AObject);
end;

function TGOXManagerObjectSet.ExistSequence<T>: Boolean;
begin
  Result := Resolver<T>.ExistSequence;
end;

function TGOXManagerObjectSet.Find<T>(const APK: Int64): T;
begin
  Result := Resolver<T>.Find(APK);
//  FCurrentIndex := 0;
end;

function TGOXManagerObjectSet.AddObjectSet<T>(const APageSize: Integer): TGOXManagerObjectSet;
var
  LObjectetAdapter: TGOXManagerObjectSetAdapterBase<T>;
  LClassName: String;
//  LRepository: TRepository;
begin
  Result := Self;
  LClassName := TClass(T).ClassName;
  if FRepositoryList.ContainsKey(LClassName) then
    Exit;
  //
  LObjectetAdapter := TGOXManagerObjectSetAdapter<T>.Create(FConnection, APageSize);
  // Adiciona o container ao repositório de containers
//  LRepository := TRepository.Create;
//  LRepository.ObjectSet := LObjectetAdapter;
  FRepositoryList.Add(LClassName, LObjectetAdapter);
end;

function TGOXManagerObjectSet.Find<T>: TObjectList<T>;
var
  LObjectList: TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.Find;
//  FCurrentIndex := 0;
end;

function TGOXManagerObjectSet.Resolver<T>: TGOXManagerObjectSetAdapterBase<T>;
var
  LClassName: String;
begin
  Result := nil;
  LClassName := TClass(T).ClassName;
  if not FRepositoryList.ContainsKey(LClassName) then
    raise Exception.Create('Use the AddAdapter<T> method to add the class to manager');
  Result := TGOXManagerObjectSetAdapterBase<T>(FRepositoryList.Items[LClassName]);
end;

function TGOXManagerObjectSet.CreateSQLSelect(ASQLSelect: String): TGOXDBQuery;
begin
  Result := FConnection.OpenSQL(ASQLSelect);
end;

procedure TGOXManagerObjectSet.Update<T>(const AObject: T);
begin
  Resolver<T>.Update(AObject);
end;

function TGOXManagerObjectSet.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
var
  LObjectList: TObjectList<T>;
begin
  Result := nil;
  Result := Resolver<T>.FindWhere(AWhere, AOrderBy);
//  FCurrentIndex := 0;
end;

procedure TGOXManagerObjectSet.Insert<T>(const AObject: T);
begin
//  Result := FCurrentIndex;
  Resolver<T>.Insert(AObject);
end;

function TGOXManagerObjectSet.ModifiedFields<T>: TDictionary<string, TDictionary<string, string>>;
begin
  Result := Resolver<T>.ModifiedFields;
end;

procedure TGOXManagerObjectSet.Modify<T>(const AObject: T);
begin
  Resolver<T>.Modify(AObject);
end;

function TGOXManagerObjectSet.PrepareWhereFieldAll<T>(AValue: String): String;
begin
  Result := Resolver<T>.PrepareWhereFieldAll(AValue);
end;

function TGOXManagerObjectSet.Find<T>(const APK: String): T;
begin
  Result := Resolver<T>.Find(APK);
//  FCurrentIndex := 0;
end;

function TGOXManagerObjectSet.FindWhere<T>(const AWhere, AOrderBy: String ; const APageNumber, ARowsByPage: Integer): TObjectList<T>;
var
 LObjectList: TObjectList<T>;
 LRowsByPage : Integer;
 LObj : TObject;
 LOrderBy:String;
begin
  Result := nil;
  LOrderBy := AOrderBy;
  if LOrderBy.Length = 0 then
  begin
    LObj := T.Create;
    if LObj.GetPrimaryKey <> nil then
    begin
      if Length(LObj.GetPrimaryKey.Columns[0]) > 0 then
      LOrderBy := LObj.GetPrimaryKey.Columns[0]+' Desc';
    end;
    FreeAndNil(LObj);
  end;
  //Se ARowsByPage for igual -1 força buscar todos registros
  if ARowsByPage < 1 then
  LRowsByPage := 99999999 else LRowsByPage := ARowsByPage;
  //
  Result := Resolver<T>.FindWhere(AWhere, LOrderBy, APageNumber,LRowsByPage);
end;

function TGOXManagerObjectSet.GetPackagePageCount<T>(const AWhere: String; const ARowsByPage: Integer): Integer;
begin
  Result := Resolver<T>.GetPackagePageCount(AWhere,ARowsByPage);
end;

{ TRepository }

//constructor TRepository.Create;
//begin
//
//end;
//
//destructor TRepository.Destroy;
//begin
//  if Assigned(FObjectSet) then
//    FObjectSet.Free;
//  inherited;
//end;

end.
