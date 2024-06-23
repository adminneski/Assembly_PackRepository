{******************************************************************************}
{                                  GOXORMBr                                     }
{                                                                              }
{  Um ORM simples que simplifica a persistência de dados, oferecendo           }
{  funcionalidades para mapear tabelas de banco de dados como objetos          }
{  relacionais, facilitando a manipulação e a gestão de dados.                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo no repositório abaixo         }
{  https://github.com/jeicksongobeti/goxormbr                                   }
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

unit goxormbr.manager.objectset.db.adapter.base;

interface

uses
  Rtti,
  TypInfo, {Delphi 2010}
  Variants,
  SysUtils,
  Generics.Collections,
  goxormbr.core.session.abstract,
  goxormbr.manager.objectset.db.adapter.base.abstract,
  goxormbr.core.consts,
  goxormbr.core.rtti.helper,
  goxormbr.core.types.blob,
  goxormbr.core.objects.helper,
  goxormbr.core.mapping.classes,
  goxormbr.core.types.mapping,
  goxormbr.core.types,
  goxormbr.core.mapping.explorer;

type
  // M - Object M
  TGOXManagerObjectSetAdapterBase<M: class, constructor> = class(TGOXManagerObjectSetAdapterBaseAbstract<M>)
  private
    procedure AddObjectState(const ASourceObject: TObject);
    procedure UpdateInternal(const AObject: TObject);
  protected
    function GenerateKey(const AObject: TObject): string;
    procedure CascadeActionsExecute(const AObject: TObject; const ACascadeAction: TCascadeAction);
    procedure OneToOneCascadeActionsExecute(const AObject: TObject; const AAssociation: TAssociationMapping; const ACascadeAction: TCascadeAction);
    procedure OneToManyCascadeActionsExecute(const AObject: TObject; const AAssociation: TAssociationMapping; const ACascadeAction: TCascadeAction);
    procedure SetAutoIncValueChilds(const AObject: TObject; const AColumn: TColumnMapping);
    procedure SetAutoIncValueOneToOne(const AObject: TObject; const AAssociation: TAssociationMapping; const AProperty: TRttiProperty);
    procedure SetAutoIncValueOneToMany(const AObject: TObject; const AAssociation: TAssociationMapping; const AProperty: TRttiProperty);
  public
    constructor Create;
    destructor Destroy; override;
    procedure New(var AObject: M); override;
    procedure Modify(const AObject: M); override;
    function ExistSequence: Boolean; override;
    function ModifiedFields: TDictionary<string, TDictionary<string, string>>; override;
    function PrepareWhereFieldAll(AValue:String):String;
  end;

implementation

{ TGOXManagerObjectSetAdapterBase<M> }

constructor TGOXManagerObjectSetAdapterBase<M>.Create;
begin
  FObjectState := TObjectDictionary<string, TObject>.Create([doOwnsValues]);
end;

destructor TGOXManagerObjectSetAdapterBase<M>.Destroy;
begin
  FObjectState.Clear;
  FreeAndNil(FObjectState);
  inherited;
end;

procedure TGOXManagerObjectSetAdapterBase<M>.AddObjectState(const ASourceObject: TObject);
var
  LRttiType: TRttiType;
  LProperty: TRttiProperty;
  LObjectList: TObjectList<TObject>;
  LStateObject: TObject;
  LObjectItem: TObject;
  LKey: string;
begin
  if not ASourceObject.GetType(LRttiType) then
    Exit;
  // Cria novo objeto para guarda-lo na lista com o estado atual do ASourceObject.
  LStateObject := ASourceObject.ClassType.Create;
  // Gera uma chave de identificação unica para cada item da lista
  LKey := GenerateKey(ASourceObject);
  // Guarda o novo objeto na lista, identificado pela chave
  FObjectState.Add(LKey, LStateObject);
  try
    for LProperty in LRttiType.GetProperties do
    begin
      if not LProperty.IsWritable then
        Continue;
      if LProperty.IsNotCascade then
        Continue;
      if LProperty.PropertyType.TypeKind in cPROPERTYTYPES_2 then
        Continue;
      case LProperty.PropertyType.TypeKind of
        tkRecord:
          begin
            if LProperty.IsNullable then
              LProperty.SetValueNullable(LStateObject,
                                         LProperty.PropertyType.Handle,
                                         LProperty.GetNullableValue(ASourceObject).AsType<Variant>)
            else
            if LProperty.IsBlob then
              LProperty.SetValueNullable(LStateObject,
                                         LProperty.PropertyType.Handle,
                                         LProperty.GetNullableValue(ASourceObject).AsType<TBlob>.ToBytes)
          end;
        tkClass:
          begin
            if LProperty.IsList then
            begin
              LObjectList := TObjectList<TObject>(LProperty.GetValue(ASourceObject).AsObject);
              for LObjectItem in LObjectList do
              begin
                if LObjectItem <> nil then
                  AddObjectState(LObjectItem);
              end;
            end
            else
              AddObjectState(LProperty.GetValue(ASourceObject).AsObject);
          end;
      else
        begin
          LProperty.SetValue(LStateObject, LProperty.GetValue(ASourceObject));
        end;
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create('procedure AddObjectState()' + sLineBreak + E.Message);
  end;
end;

procedure TGOXManagerObjectSetAdapterBase<M>.CascadeActionsExecute(const AObject: TObject;
  const ACascadeAction: TCascadeAction);
var
  LAssociation: TAssociationMapping;
  LAssociations: TAssociationMappingList;
begin
  LAssociations := TMappingExplorer
                     .GetMappingAssociation(AObject.ClassType);
  if LAssociations = nil then
    Exit;
  for LAssociation in LAssociations do
  begin
    if not (ACascadeAction in LAssociation.CascadeActions) then
      Continue;

    if LAssociation.Multiplicity in [OneToOne, ManyToOne] then
      OneToOneCascadeActionsExecute(AObject, LAssociation, ACascadeAction)
    else
    if LAssociation.Multiplicity in [OneToMany, ManyToMany] then
      OneToManyCascadeActionsExecute(AObject, LAssociation, ACascadeAction);
  end;
end;

function TGOXManagerObjectSetAdapterBase<M>.ExistSequence: Boolean;
begin
  Result := FSession.ExistSequence;
end;

function TGOXManagerObjectSetAdapterBase<M>.GenerateKey(const AObject: TObject): string;
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
  LKey: string;
begin
  LKey := AObject.ClassName;
  LPrimaryKey := TMappingExplorer
                   .GetMappingPrimaryKeyColumns(AObject.ClassType);
  if LPrimaryKey = nil then
    raise Exception.Create(cMESSAGEPKNOTFOUND);

  for LColumn in LPrimaryKey.Columns do
    LKey := LKey + '-' + VarToStr(LColumn.ColumnProperty.GetNullableValue(AObject).AsVariant);
  Result := LKey;
end;

function TGOXManagerObjectSetAdapterBase<M>.ModifiedFields: TDictionary<string, TDictionary<string, string>>;
begin
  Result := FSession.ModifiedFields;
end;

procedure TGOXManagerObjectSetAdapterBase<M>.Modify(const AObject: M);
begin
  FObjectState.Clear;
  AddObjectState(AObject);
end;

procedure TGOXManagerObjectSetAdapterBase<M>.New(var AObject: M);
begin
  inherited;
  AObject := M.Create;
  AObject.SetDefaultValue;
end;

procedure TGOXManagerObjectSetAdapterBase<M>.OneToManyCascadeActionsExecute(
  const AObject: TObject;
  const AAssociation: TAssociationMapping;
  const ACascadeAction: TCascadeAction);
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
  LValue: TValue;
  LObjectList: TObjectList<TObject>;
  LObject: TObject;
  LObjectKey: TObject;
  LFor: Integer;
  LKey: string;
begin
  LValue := AAssociation.PropertyRtti.GetNullableValue(AObject);
  if not LValue.IsObject then
    Exit;
  LObjectList := TObjectList<TObject>(LValue.AsObject);
  for LFor := 0 to LObjectList.Count -1 do
  begin
    LObject := LObjectList.Items[LFor];
    if ACascadeAction = CascadeInsert then // Insert
    begin
      FSession.Insert(LObject);
      // Popula as propriedades de relacionamento com os valores do master
      LPrimaryKey := TMappingExplorer
                       .GetMappingPrimaryKeyColumns(AObject.ClassType);
      if LPrimaryKey = nil then
        raise Exception.Create(cMESSAGEPKNOTFOUND);

      for LColumn in LPrimaryKey.Columns do
        SetAutoIncValueChilds(LObject, LColumn);
    end
    else
    if ACascadeAction = CascadeDelete then // Delete
      FSession.Delete(LObject)
    else
    if ACascadeAction = CascadeUpdate then // Update
    begin
      LKey := GenerateKey(LObject);
      if FObjectState.TryGetValue(LKey, LObjectKey) then
      begin
        FSession.ModifyFieldsCompare(LKey, LObjectKey, LObject);
        UpdateInternal(LObject);
        FObjectState.Remove(LKey);
        FObjectState.TrimExcess;
      end
      else
        FSession.Insert(LObject);
    end;
    // Executa comando em cascade de cada objeto da lista
    CascadeActionsExecute(LObject, ACascadeAction);
  end;
end;

procedure TGOXManagerObjectSetAdapterBase<M>.OneToOneCascadeActionsExecute(
  const AObject: TObject; const AAssociation: TAssociationMapping;
  const ACascadeAction: TCascadeAction);
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
  LValue: TValue;
  LObject: TObject;
  LObjectKey: TObject;
  LKey: string;
begin
  LValue := AAssociation.PropertyRtti.GetNullableValue(AObject);
  if not LValue.IsObject then
    Exit;
  LObject := LValue.AsObject;
  if LObject = nil then
    Exit;
  if ACascadeAction = CascadeInsert then // Insert
  begin
    FSession.Insert(LObject);
    // Popula as propriedades de relacionamento com os valores do master
    LPrimaryKey := TMappingExplorer
                     .GetMappingPrimaryKeyColumns(AObject.ClassType);
    if LPrimaryKey = nil then
      raise Exception.Create(cMESSAGEPKNOTFOUND);

    for LColumn in LPrimaryKey.Columns do
      SetAutoIncValueChilds(LObject, LColumn);
  end
  else
  if ACascadeAction = CascadeDelete then // Delete
    FSession.Delete(LObject)
  else
  if ACascadeAction = CascadeUpdate then // Update
  begin
    LKey := GenerateKey(LObject);
    if FObjectState.TryGetValue(LKey, LObjectKey) then
    begin
      FSession.ModifyFieldsCompare(LKey, LObjectKey, LObject);
      UpdateInternal(LObject);
      FObjectState.Remove(LKey);
      FObjectState.TrimExcess;
    end
    else
      FSession.Insert(LObject);
  end;
  // Executa comando em cascade de cada objeto da lista
  CascadeActionsExecute(LObject, ACascadeAction);
end;

function TGOXManagerObjectSetAdapterBase<M>.PrepareWhereFieldAll(AValue: String): String;
begin
  Result := FSession.PrepareWhereFieldAll(AValue);
end;

procedure TGOXManagerObjectSetAdapterBase<M>.SetAutoIncValueChilds(const AObject: TObject; const AColumn: TColumnMapping);
var
  LAssociation: TAssociationMapping;
  LAssociations: TAssociationMappingList;
begin
  // Association
  LAssociations := TMappingExplorer.GetMappingAssociation(AObject.ClassType);
  if LAssociations = nil then
    Exit;
  for LAssociation in LAssociations do
  begin
    if not (CascadeAutoInc in LAssociation.CascadeActions) then
      Continue;
    if LAssociation.Multiplicity in [OneToOne, ManyToOne] then
      SetAutoIncValueOneToOne(AObject, LAssociation, AColumn.ColumnProperty)
    else
    if LAssociation.Multiplicity in [OneToMany, ManyToMany] then
      SetAutoIncValueOneToMany(AObject, LAssociation, AColumn.ColumnProperty);
  end;
end;

procedure TGOXManagerObjectSetAdapterBase<M>.SetAutoIncValueOneToMany(const AObject: TObject;
  const AAssociation: TAssociationMapping; const AProperty: TRttiProperty);
var
  LType: TRttiType;
  LProperty: TRttiProperty;
  LValue: TValue;
  LObjectList: TObjectList<TObject>;
  LObject: TObject;
  LFor: Integer;
  LIndex: Integer;
begin
  LValue := AAssociation.PropertyRtti.GetNullableValue(AObject);
  if not LValue.IsObject then
    Exit;
  LObjectList := TObjectList<TObject>(LValue.AsObject);
  for LFor := 0 to LObjectList.Count -1 do
  begin
    LObject := LObjectList.Items[LFor];
    if not LObject.GetType(LType) then
      Continue;
    LIndex := AAssociation.ColumnsName.IndexOf(AProperty.Name);
    if LIndex = -1 then
      Continue;
    LProperty := LType.GetProperty(AAssociation.ColumnsNameRef.Items[LIndex]);
    if LProperty <> nil then
      LProperty.SetValue(LObject, AProperty.GetValue(AObject));
  end;
end;

procedure TGOXManagerObjectSetAdapterBase<M>.SetAutoIncValueOneToOne(const AObject: TObject;
  const AAssociation: TAssociationMapping; const AProperty: TRttiProperty);
var
  LType: TRttiType;
  LProperty: TRttiProperty;
  LValue: TValue;
  LObject: TObject;
  LIndex: Integer;
begin
  LValue := AAssociation.PropertyRtti.GetNullableValue(AObject);
  if not LValue.IsObject then
    Exit;
  LObject := LValue.AsObject;
  if not LObject.GetType(LType) then
    Exit;
  LIndex := AAssociation.ColumnsName.IndexOf(AProperty.Name);
  if LIndex = -1 then
    Exit;
  LProperty := LType.GetProperty(AAssociation.ColumnsNameRef.Items[LIndex]);
  if LProperty <> nil then
    LProperty.SetValue(LObject, AProperty.GetValue(AObject));
end;

procedure TGOXManagerObjectSetAdapterBase<M>.UpdateInternal(const AObject: TObject);
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
  LKey: string;
begin
  LKey := AObject.ClassName;
  LPrimaryKey := TMappingExplorer
                   .GetMappingPrimaryKeyColumns(AObject.ClassType);
  if LPrimaryKey = nil then
    raise Exception.Create(cMESSAGEPKNOTFOUND);

  for LColumn in LPrimaryKey.Columns do
    LKey := LKey + '-' + VarToStr(LColumn.ColumnProperty.GetNullableValue(AObject).AsVariant);
  ///
  if not FSession.ModifiedFields.ContainsKey(LKey) then
    Exit;
  if FSession.ModifiedFields.Items[LKey].Count = 0 then
    Exit;
  FSession.Update(AObject, LKey);
end;

end.
