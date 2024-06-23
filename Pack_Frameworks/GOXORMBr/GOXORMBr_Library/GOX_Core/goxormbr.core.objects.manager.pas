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

unit goxormbr.core.objects.manager;

interface

uses
  DB,
  Rtti,
  Classes,
  SysUtils,
  Variants,
  Generics.Collections,
  ///goxormbr
  goxormbr.core.command.factory,
  goxormbr.core.objects.manager.abstract,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.explorer,
  goxormbr.core.mapping.attributes,
  goxormbr.core.types, System.Math, System.StrUtils;

type
  TObjectManager<M: class, constructor> = class sealed(TObjectManagerAbstract<M>)
  private
    FOwner: TObject;
    FObjectInternal: M;
  protected
    FGOXORMEngine: TGOXDBConnection;
    // Controle de paginação vindo do banco de dados
    FPageSize: Integer;
    // Fábrica de comandos a serem executados
    FDMLCommandFactory: TDMLCommandFactoryAbstract;

    procedure FillAssociation(const AObject: M); override;

    function FindSQLInternal(const ASQL: String): TObjectList<M>; override;
    procedure ExecuteOneToOne(AObject: TObject; AProperty: TRttiProperty; AAssociation: TAssociationMapping); override;
    procedure ExecuteOneToMany(AObject: TObject; AProperty: TRttiProperty; AAssociation: TAssociationMapping); override;
  public
    constructor Create(const AOwner: TObject; const AGOXORMEngine: TGOXDBConnection; const APageSize: Integer); override;
    destructor Destroy; override;
    // Procedures
    procedure InsertInternal(const AObject: M); override;
    procedure UpdateInternal(const AObject: TObject; const AModifiedFields: TDictionary<string, string>); override;
    procedure DeleteInternal(const AObject: M); override;

    function SelectByPackage(const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):TObjectList<M>; override;
    function GetPackagePageCount(const AWhere: String; const ARowsByPage:Integer):Integer; override;

    // Functions
    function GetDMLCommand: string; override;
    function ExistSequence: Boolean; override;
    // DataSet
    function SelectInternalWhere(const AWhere: string; const AOrderBy: string): string; override;
    function SelectInternalAll: TGOXDBQuery; override;
    function SelectInternalID(const APK: Variant): TGOXDBQuery; override;
    function SelectInternal(const ASQL: String): TGOXDBQuery; override;
    function SelectInternalAssociation(const AObject: TObject): String; override;
    function SelectInternalByPackage(const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):TGOXDBQuery; override;
    // ObjectSet
    function Find: TObjectList<M>; overload; override;
    function Find(const APK: Variant): M; overload; override;
    function FindWhere(const AWhere: string;  const AOrderBy: string): TObjectList<M>; override;
  end;

implementation

uses
  goxormbr.core.bind,
  goxormbr.core.session.abstract,
  goxormbr.core.objects.helper,
  goxormbr.core.rtti.helper;

{ TObjectManager<M> }

constructor TObjectManager<M>.Create(const AOwner: TObject; const AGOXORMEngine: TGOXDBConnection; const APageSize: Integer);
begin
  inherited Create(AOwner,AGOXORMEngine,APageSize);
  FOwner := AOwner;
  FPageSize := APageSize;
  if not (AOwner is TSessionAbstract<M>) then
    raise Exception
            .Create('O Object Manager não deve ser instânciada diretamente, use as classes TSessionObject<M> ou TSessionDataSet<M>');
  FGOXORMEngine := AGOXORMEngine;

  FObjectInternal := M.Create;

  // ROTINA NÃO FINALIZADA DEU MUITO PROBLEMA, QUEM SABE UM DIA VOLTO A OLHAR
  // Mapeamento dos campos Lazy Load
//  TMappingExplorer.GetMappingLazy(TObject(FObjectInternal).ClassType);

    // Fabrica de comandos SQL
  try
    FDMLCommandFactory := TDMLCommandFactory.Create(FObjectInternal,
                                                    AGOXORMEngine,
                                                    AGOXORMEngine.DriverType);
  except on E: Exception do
    raise Exception.Create('ObjectManager<M>.Create :'+E.Message);
  end;
end;

destructor TObjectManager<M>.Destroy;
begin
  FreeAndNil(FObjectInternal);
  FreeAndNil(FDMLCommandFactory);
  inherited;
end;

procedure TObjectManager<M>.DeleteInternal(const AObject: M);
begin
  FDMLCommandFactory.GeneratorDelete(AObject);
end;

function TObjectManager<M>.SelectInternalAll: TGOXDBQuery;
begin
  Result := FDMLCommandFactory.GeneratorSelectAll(M, FPageSize);
end;

function TObjectManager<M>.SelectInternalAssociation(
  const AObject: TObject): String;
var
  LAssociationList: TAssociationMappingList;
  LAssociation: TAssociationMapping;
begin
  // Result deve sempre iniciar vazio
  Result := '';
  LAssociationList := TMappingExplorer.GetMappingAssociation(AObject.ClassType);
  if LAssociationList = nil then
    Exit;
  for LAssociation in LAssociationList do
  begin
     if LAssociation.ClassNameRef <> FObjectInternal.ClassName then
       Continue;
     if LAssociation.Lazy then
       Continue;
     if LAssociation.Multiplicity in [OneToOne, ManyToOne] then
        Result := FDMLCommandFactory
                    .GeneratorSelectAssociation(AObject,
                                                FObjectInternal.ClassType,
                                                LAssociation)
     else
     if LAssociation.Multiplicity in [OneToMany, ManyToMany] then
        Result := FDMLCommandFactory
                    .GeneratorSelectAssociation(AObject,
                                                FObjectInternal.ClassType,
                                                LAssociation)
  end;
end;

function TObjectManager<M>.SelectInternalID(const APK: Variant): TGOXDBQuery;
begin
  Result := FDMLCommandFactory.GeneratorSelectID(M, APK);
end;

function TObjectManager<M>.SelectInternalWhere(const AWhere: string;
  const AOrderBy: string): string;
begin
  Result := FDMLCommandFactory.GeneratorSelectWhere(M, AWhere, AOrderBy, FPageSize);
end;

procedure TObjectManager<M>.FillAssociation(const AObject: M);
var
  LAssociationList: TAssociationMappingList;
  LAssociation: TAssociationMapping;
begin
//  // Se o driver selecionado for do tipo de banco NoSQL,
//  // o atributo Association deve ser ignorado.
//  if FGOXORMEngine.GetDriverName = dnMongoDB then
//    Exit;

  if Assigned(AObject) then
  begin
    LAssociationList := TMappingExplorer.GetMappingAssociation(AObject.ClassType);
    if LAssociationList = nil then
      Exit;
    for LAssociation in LAssociationList do
    begin
       if LAssociation.Lazy then
         Continue;
       if LAssociation.Multiplicity in [OneToOne, ManyToOne] then
          ExecuteOneToOne(AObject, LAssociation.PropertyRtti, LAssociation)
       else
       if LAssociation.Multiplicity in [OneToMany, ManyToMany] then
          ExecuteOneToMany(AObject, LAssociation.PropertyRtti, LAssociation);
    end;
  end;
end;

procedure TObjectManager<M>.ExecuteOneToOne(AObject: TObject;
  AProperty: TRttiProperty; AAssociation: TAssociationMapping);
var
  LResultSet: TGOXDBQuery;
  LObjectValue: TObject;
begin
  LResultSet := FDMLCommandFactory
                  .GeneratorSelectOneToOne(AObject,
                                           AProperty.PropertyType.AsInstance.MetaclassType,
                                           AAssociation);
  try
    while not LResultSet.Eof do
    begin
      LObjectValue := AProperty.GetNullableValue(AObject).AsObject;
      if LObjectValue = nil then
      begin
        LObjectValue := AProperty.PropertyType.AsInstance.MetaclassType.Create;
        AProperty.SetValue(AObject, TValue.from<TObject>(LObjectValue));
      end;
      // Preenche o objeto com os dados do ResultSet
      TBind.Instance.SetFieldToProperty(LResultSet, LObjectValue);
      // Alimenta registros das associações existentes 1:1 ou 1:N
      FillAssociation(LObjectValue);
      //
      LResultSet.Next;
    end;
  finally
    LResultSet.Close;
    //jeickson
    FreeAndNil(LResultSet);
  end;
end;

procedure TObjectManager<M>.ExecuteOneToMany(AObject: TObject;
  AProperty: TRttiProperty; AAssociation: TAssociationMapping);
var
  LPropertyType: TRttiType;
  LObjectCreate: TObject;
  LObjectList: TObject;
  LResultSet: TGOXDBQuery;
begin
  LPropertyType := AProperty.PropertyType;
  LPropertyType := AProperty.GetTypeValue(LPropertyType);
  LResultSet := FDMLCommandFactory
                  .GeneratorSelectOneToMany(AObject,
                                            LPropertyType.AsInstance.MetaclassType,
                                            AAssociation);
  try
    while not LResultSet.Eof do
    begin
      // Instancia o objeto do tipo definido na lista
      LObjectCreate := LPropertyType.AsInstance.MetaclassType.Create;
      LObjectCreate.MethodCall('Create', []);
      // Popula o objeto com os dados do ResultSet
      TBind.Instance.SetFieldToProperty(LResultSet, LObjectCreate);
      // Alimenta registros das associações existentes 1:1 ou 1:N
      FillAssociation(LObjectCreate);
      // Adiciona o objeto a lista
      LObjectList := AProperty.GetNullableValue(AObject).AsObject;
      if LObjectList <> nil then
        LObjectList.MethodCall('Add', [LObjectCreate]);
      //
      LResultSet.Next;
    end;
  finally
    LResultSet.Close;
    //jeickson
    FreeAndNil(LResultSet);
  end;
end;

function TObjectManager<M>.ExistSequence: Boolean;
begin
  Result := FDMLCommandFactory.ExistSequence;
end;

function TObjectManager<M>.GetDMLCommand: string;
begin
  Result := FDMLCommandFactory.GetDMLCommand;
end;

function TObjectManager<M>.GetPackagePageCount(const AWhere: String; const ARowsByPage: Integer): Integer;
var
 LDBQry: TGOXDBQuery;
 LPackageCount : Integer;
begin
  try
    LDBQry  := FDMLCommandFactory.GeneratorPackagePageCount(M,AWhere,ARowsByPage);
    //Extrair a Quantidade Inteira de Pag. do Packing
    if LDBQry <> nil then
    begin
      try
        if LDBQry.RecordCount > 0 then
        begin
          LPackageCount :=   (LDBQry.FieldByName('PACKAGECOUNT').AsInteger Div ARowsByPage);
          //Se o Resto da Quantidade de Pag. do Packing for > 0, acrescenta mais 1 Pag.
          if LDBQry.FieldByName('PACKAGECOUNT').AsInteger mod ARowsByPage / ARowsByPage > 0 then
            LPackageCount := LPackageCount + 1;

          Result := LPackageCount;
        end;
      finally
        if Assigned(LDBQry) then
          FreeAndNil(LDBQry);
      end;
    end;
  except on E: Exception do
   raise Exception.Create(E.Message);
  end;
end;

function TObjectManager<M>.SelectInternalByPackage(const APageNumber, ARowsByPage: Integer; const AWhere: String; AOrderBy: String): TGOXDBQuery;
begin
  Result := FDMLCommandFactory.GeneratorSelectByPackage(M, APageNumber, ARowsByPage, AWhere, AOrderBy);
end;

function TObjectManager<M>.SelectByPackage(const APageNumber, ARowsByPage: Integer; const AWhere: String; AOrderBy: String): TObjectList<M>;
var
 LResultSet: TGOXDBQuery;
 LObjectList: TObjectList<M>;
begin
  LObjectList := TObjectList<M>.Create;
  LResultSet := SelectInternalByPackage(APageNumber, ARowsByPage, AWhere, AOrderBy);
  try
    while not LResultSet.Eof do
    begin
      LObjectList.Add(M.Create);
      TBind.Instance
           .SetFieldToProperty(LResultSet, TObject(LObjectList.Last));
      // Alimenta registros das associações existentes 1:1 ou 1:N
      FillAssociation(LObjectList.Last);
      //
      LResultSet.Next;
    end;
    Result := LObjectList;
  finally
    LResultSet.Close;
    //jeickson
    FreeAndNil(LResultSet);
  end;

end;

function TObjectManager<M>.SelectInternal(const ASQL: String): TGOXDBQuery;
begin
  Result := FDMLCommandFactory.GeneratorSelect(ASQL, FPageSize);
end;

procedure TObjectManager<M>.UpdateInternal(const AObject: TObject;
  const AModifiedFields: TDictionary<string, string>);
begin
  FDMLCommandFactory.GeneratorUpdate(AObject, AModifiedFields);
end;

procedure TObjectManager<M>.InsertInternal(const AObject: M);
begin
  try
    FDMLCommandFactory.GeneratorInsert(AObject);
  except on E: Exception do
   raise Exception.Create('ManagerGeneratorInsert :'+E.Message);
  end;

end;

function TObjectManager<M>.FindSQLInternal(const ASQL: String): TObjectList<M>;
var
 LResultSet: TGOXDBQuery;
 LObject: M;
begin
  Result := TObjectList<M>.Create;
  if ASQL = '' then
    LResultSet := SelectInternalAll
  else
    LResultSet := SelectInternal(ASQL);
  try
    while not LResultSet.Eof do
    begin
      LObject := M.Create;
      // TObject(LObject) = Para D2010
      TBind.Instance.SetFieldToProperty(LResultSet, TObject(LObject));
      // Alimenta registros das associações existentes 1:1 ou 1:N
      FillAssociation(LObject);
      // Adiciona o Object a lista de retorno
      Result.Add(LObject);
      //
      LResultSet.Next;
    end;
  finally
    LResultSet.Close;
    //jeickson
    FreeAndNil(LResultSet);
  end;
end;

function TObjectManager<M>.Find: TObjectList<M>;
begin
  Result := FindSQLInternal('');
end;

function TObjectManager<M>.Find(const APK: Variant): M;
var
  LAPK :String;
var
 LResultSet: TGOXDBQuery;
begin
  //Força Pesquisa de -111 ser for -1 devido nao gerar where se for -1 e sempre
  //set o mesmo valor pesquisa no objeto se existir
  if TValue.FromVariant(APK).IsType<String> then
    LResultSet := SelectInternalID(IfThen(APK='-1','-111',APK))
  else if TValue.FromVariant(APK).IsType<Integer> then
    LResultSet := SelectInternalID(IfThen(APK=-1,-111,APK))
  else if TValue.FromVariant(APK).IsType<Int64> then
    LResultSet := SelectInternalID(IfThen(APK=-1,-111,APK))
  else
    LResultSet := SelectInternalID(IfThen(APK=-1,-111,APK));
  try
    if LResultSet.RecordCount = 1 then
    begin
      Result := M.Create;
      TBind.Instance
           .SetFieldToProperty(LResultSet, TObject(Result));
      // Alimenta registros das associações existentes 1:1 ou 1:N
      FillAssociation(Result);
    end
    else
      Result := nil;
  finally
    LResultSet.Close;
    //jeickson
    FreeAndNil(LResultSet);
  end;

end;

function TObjectManager<M>.FindWhere(const AWhere: string; const AOrderBy: string): TObjectList<M>;
begin
  Result := FindSQLInternal(SelectInternalWhere(AWhere, AOrderBy));
end;

end.

