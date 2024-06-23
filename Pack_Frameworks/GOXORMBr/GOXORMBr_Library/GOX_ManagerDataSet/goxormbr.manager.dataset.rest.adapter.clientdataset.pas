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

unit goxormbr.manager.dataset.rest.adapter.clientdataset;

interface

uses
  Classes,
  SysUtils,
  DB,
  Rtti,
  DBClient,
  Variants,
  Generics.Collections,
  /// ORMBr
  goxormbr.core.types,
  goxormbr.core.criteria,
  goxormbr.manager.dataset.adapter.base,
  goxormbr.manager.dataset.rest.adapter,
  goxormbr.manager.dataset.events,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.explorer,
  goxormbr.core.types.mapping,
  goxormbr.core.rtti.helper,
  goxormbr.core.mapping.exceptions,
  goxormbr.core.mapping.attributes;

type
  /// <summary>
  /// Captura de eventos específicos do componente TClientDataSet
  /// </summary>
  TRESTClientDataSetEvents = class(TDataSetEvents)
  private
    FBeforeApplyUpdates: TRemoteEvent;
    FAfterApplyUpdates: TRemoteEvent;
  public
    property BeforeApplyUpdates: TRemoteEvent read FBeforeApplyUpdates write FBeforeApplyUpdates;
    property AfterApplyUpdates: TRemoteEvent read FAfterApplyUpdates write FAfterApplyUpdates;
  end;

  // Adapter TClientDataSet para controlar o Modelo e o Controle definido por:
  // M - Object Model
  TGOXManagerDatasetAdapterRestClientDataSet<M: class, constructor> = class(TGOXManagerDataSetAdapterRest<M>)
  private
    FOrmDataSet: TClientDataSet;
    FClientDataSetEvents: TRESTClientDataSetEvents;
    procedure DoBeforeApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
    procedure DoAfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
    procedure FilterDataSetChilds;
  protected
    procedure PopularDataSetOneToOne(const AObject: TObject;const AAssociation: TAssociationMapping); override;
    procedure EmptyDataSetChilds; override;
    procedure GetDataSetEvents; override;
    procedure SetDataSetEvents; override;
    procedure OpenIDInternal(const APK: Variant); override;
    procedure OpenSQLInternal(const ASQL: string); override;
    procedure OpenWhereInternal(const AWhere: string; const AOrderBy: string = ''); override;
    procedure ApplyInternal(const MaxErros: Integer); override;
    procedure ApplyUpdates(const MaxErros: Integer); override;
    procedure EmptyDataSet; override;
  public
    constructor Create(const AConnection: TGOXRESTConnection; ADataSet: TDataSet; APageSize: Integer; AMasterObject: TObject); overload; override;
    destructor Destroy; override;
  end;

implementation

uses
  goxormbr.core.bind,
  goxormbr.core.objects.helper,
  goxormbr.manager.dataset.fields;

{ TGOXManagerDatasetAdapterRestClientDataSet<M> }


constructor TGOXManagerDatasetAdapterRestClientDataSet<M>.Create(const AConnection: TGOXRESTConnection;ADataSet: TDataSet; APageSize: Integer; AMasterObject: TObject);
begin
  inherited Create(Aconnection, ADataSet, APageSize, AMasterObject);
  /// <summary>
  /// Captura o component TClientDataset da IDE passado como parâmetro
  /// </summary>
  FOrmDataSet := ADataSet as TClientDataSet;
  FClientDataSetEvents := TRESTClientDataSetEvents.Create;
  /// <summary>
  /// Captura e guarda os eventos do dataset
  /// </summary>
  GetDataSetEvents;
  /// <summary>
  /// Seta os eventos do ORM no dataset, para que ele sejam disparados
  /// </summary>
  SetDataSetEvents;
  ///
  if not FOrmDataSet.Active then
  begin
     FOrmDataSet.CreateDataSet;
     FOrmDataSet.LogChanges := False;
  end;
end;

destructor TGOXManagerDatasetAdapterRestClientDataSet<M>.Destroy;
begin
  FOrmDataSet := nil;
  FClientDataSetEvents.Free;
  inherited;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.DoAfterApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
  if Assigned(FClientDataSetEvents.AfterApplyUpdates) then
    FClientDataSetEvents.AfterApplyUpdates(Sender, OwnerData);
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.DoBeforeApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
  if Assigned(FClientDataSetEvents.BeforeApplyUpdates) then
    FClientDataSetEvents.BeforeApplyUpdates(Sender, OwnerData);
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.EmptyDataSet;
begin
  inherited;
  FOrmDataSet.EmptyDataSet;
  /// <summary>
  /// Lista os registros das tabelas filhas relacionadas
  /// </summary>
  EmptyDataSetChilds;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.EmptyDataSetChilds;
var
  LChild: TPair<string, TGOXManagerDataSetAdapterBase<M>>;
  LDataSet: TClientDataSet;
begin
  inherited;
  if FMasterObject.Count > 0 then
  begin
    for LChild in FMasterObject do
    begin
      LDataSet := TGOXManagerDatasetAdapterRestClientDataSet<M>(LChild.Value).FOrmDataSet;
      if LDataSet.Active then
        LDataSet.EmptyDataSet;
    end;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.FilterDataSetChilds;
var
  LRttiType: TRttiType;
  LAssociations: TAssociationMappingList;
  LAssociation: TAssociationMapping;
  LChild: TGOXManagerDataSetAdapterBase<M>;
  LFor: Integer;
  LFields: string;
  LIndexFields: string;
  LClassName: String;
begin
  if not FOrmDataSet.Active then
    Exit;

  LAssociations := TMappingExplorer.GetMappingAssociation(FCurrentInternal.ClassType);
  if LAssociations = nil then
    Exit;

  for LAssociation in LAssociations do
  begin
    if LAssociation.PropertyRtti.isList then
      LRttiType := LAssociation.PropertyRtti.GetTypeValue(LAssociation.PropertyRtti.PropertyType)
    else
      LRttiType := LAssociation.PropertyRtti.PropertyType;

    LClassName := LRttiType.AsInstance.MetaclassType.ClassName;
    if not FMasterObject.TryGetValue(LClassName, LChild) then
      Continue;

    LFields := '';
    LIndexFields := '';
    TClientDataSet(LChild.FOrmDataSet).MasterSource := FOrmDataSource;
    for LFor := 0 to LAssociation.ColumnsName.Count -1 do
    begin
      LFields := LFields + LAssociation.ColumnsNameRef[LFor];
      LIndexFields := LIndexFields + LAssociation.ColumnsName[LFor];
      if LAssociation.ColumnsName.Count -1 > LFor then
      begin
        LFields := LFields + '; ';
        LIndexFields := LIndexFields + '; ';
      end;
    end;
    TClientDataSet(LChild.FOrmDataSet).IndexFieldNames := LIndexFields;
    TClientDataSet(LChild.FOrmDataSet).MasterFields := LFields;
    /// <summary>
    /// Filtra os registros filhos associados ao LChild caso ele seja
    /// master de outros objetos.
    /// </summary>
    if LChild.FMasterObject.Count > 0 then
      TGOXManagerDatasetAdapterRestClientDataSet<M>(LChild).FilterDataSetChilds;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.GetDataSetEvents;
begin
  inherited;
  if Assigned(FOrmDataSet.BeforeApplyUpdates) then
    FClientDataSetEvents.BeforeApplyUpdates := FOrmDataSet.BeforeApplyUpdates;
  if Assigned(FOrmDataSet.AfterApplyUpdates)  then
    FClientDataSetEvents.AfterApplyUpdates  := FOrmDataSet.AfterApplyUpdates;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.OpenSQLInternal(const ASQL: string);
var
  LObjectList: TObjectList<M>;
begin
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    /// <summary> Limpa os registro do dataset antes de garregar os novos dados </summary>
    EmptyDataSet;
    inherited;
    LObjectList := FSession.Find;
    if LObjectList <> nil then
    begin
      try
        PopularDataSetList(LObjectList);
        /// <summary> Filtra os registros nas sub-tabelas </summary>
        if FOwnerMasterObject = nil then
          FilterDataSetChilds;
      finally
        LObjectList.Clear;
        LObjectList.Free;
      end;
    end;
  finally
    EnableDataSetEvents;
    FOrmDataSet.First;
    FOrmDataSet.EnableControls;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.OpenIDInternal(const APK: Variant);
var
  LObject: M;
begin
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    /// <summary> Limpa os registro do dataset antes de garregar os novos dados </summary>
    EmptyDataSet;
    inherited;
    FSession.Find(VarToStr(APK));
    if LObject <> nil then
    begin
      try
        PopularDataSet(LObject);
        /// <summary> Filtra os registros nas sub-tabelas </summary>
        if FOwnerMasterObject = nil then
          FilterDataSetChilds;
      finally
        LObject.Free;
      end;
    end;
  finally
    EnableDataSetEvents;
    FOrmDataSet.First;
    FOrmDataSet.EnableControls;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.OpenWhereInternal(const AWhere, AOrderBy: string);
var
  LObjectList: TObjectList<M>;
begin
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    /// <summary> Limpa os registro do dataset antes de garregar os novos dados </summary>
    EmptyDataSet;
    inherited;
    LObjectList := FSession.FindWhere(AWhere, AOrderBy);
    if LObjectList <> nil then
    begin
      try
        PopularDataSetList(LObjectList);
        /// <summary> Filtra os registros nas sub-tabelas </summary>
        if FOwnerMasterObject = nil then
          FilterDataSetChilds;
      finally
        LObjectList.Clear;
        LObjectList.Free;
      end;
    end;
  finally
    EnableDataSetEvents;
    FOrmDataSet.First;
    FOrmDataSet.EnableControls;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.PopularDataSetOneToOne(const AObject: TObject; const AAssociation: TAssociationMapping);
var
  LRttiType: TRttiType;
  LChild: TGOXManagerDataSetAdapterBase<M>;
  LField: string;
  LKeyFields: string;
  LKeyValues: string;
begin
  inherited;
  if not FMasterObject.TryGetValue(AObject.ClassName, LChild) then
    Exit;

  LChild.FOrmDataSet.DisableControls;
  LChild.DisableDataSetEvents;
  TClientDataSet(LChild.FOrmDataSet).MasterSource := nil;
  try
    AObject.GetType(LRttiType);
    LKeyFields := '';
    LKeyValues := '';
    for LField in AAssociation.ColumnsNameRef do
    begin
      LKeyFields := LKeyFields + LField + ', ';
      LKeyValues := LKeyValues + VarToStrDef(LRttiType.GetProperty(LField).GetNullableValue(AObject).AsVariant,'') + ', ';
    end;
    LKeyFields := Copy(LKeyFields, 1, Length(LKeyFields) -2);
    LKeyValues := Copy(LKeyValues, 1, Length(LKeyValues) -2);
    // Evitar duplicidade de registro em memória
    if not LChild.FOrmDataSet.Locate(LKeyFields, LKeyValues, [loCaseInsensitive]) then
    begin
      LChild.FOrmDataSet.Append;
      TBind.Instance.SetPropertyToField(AObject, LChild.FOrmDataSet);
      LChild.FOrmDataSet.Post;
    end;
  finally
    TClientDataSet(LChild.FOrmDataSet).MasterSource := FOrmDataSource;
    LChild.FOrmDataSet.First;
    LChild.FOrmDataSet.EnableControls;
    LChild.EnableDataSetEvents;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.ApplyInternal(const MaxErros: Integer);
var
  LRecnoBook: TBookmark;
  LProperty: TRttiProperty;
begin
  LRecnoBook := FOrmDataSet.Bookmark;
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    ApplyInserter(MaxErros);
    ApplyUpdater(MaxErros);
    ApplyDeleter(MaxErros);
  finally
    FOrmDataSet.GotoBookmark(LRecnoBook);
    FOrmDataSet.FreeBookmark(LRecnoBook);
    FOrmDataSet.EnableControls;
    EnableDataSetEvents;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.ApplyUpdates(const MaxErros: Integer);
var
  LOwnerData: OleVariant;
begin
  inherited;
  try
    DoBeforeApplyUpdates(FOrmDataSet, LOwnerData);
    ApplyInternal(MaxErros);
    DoAfterApplyUpdates(FOrmDataSet, LOwnerData);
  finally
    if FSession.ModifiedFields.ContainsKey(M.ClassName) then
    begin
      FSession.ModifiedFields.Items[M.ClassName].Clear;
      FSession.ModifiedFields.Items[M.ClassName].TrimExcess;
    end;
    FSession.DeleteList.Clear;
    FSession.DeleteList.TrimExcess;
  end;
end;

procedure TGOXManagerDatasetAdapterRestClientDataSet<M>.SetDataSetEvents;
begin
  inherited;
  FOrmDataSet.BeforeApplyUpdates := DoBeforeApplyUpdates;
  FOrmDataSet.AfterApplyUpdates  := DoAfterApplyUpdates;
end;

end.
