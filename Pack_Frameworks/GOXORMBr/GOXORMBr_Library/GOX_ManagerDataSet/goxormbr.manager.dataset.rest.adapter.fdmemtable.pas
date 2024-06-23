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

unit goxormbr.manager.dataset.rest.adapter.fdmemtable;

interface

uses
    DB,
    Rtti,
    Classes,
    SysUtils,
    StrUtils,
    Variants,
    Generics.Collections,
    FireDAC.Stan.Intf,
    FireDAC.Stan.Option,
    FireDAC.Stan.Param,
    FireDAC.Stan.Error,
    FireDAC.DatS,
    FireDAC.Phys.Intf,
    FireDAC.DApt.Intf,
    FireDAC.Stan.Async,
    FireDAC.DApt,
    FireDAC.Comp.DataSet,
    FireDAC.Comp.Client,
    /// orm
    goxormbr.core.criteria,
    goxormbr.manager.dataset.db.adapter,
    goxormbr.manager.dataset.adapter.base,
    goxormbr.manager.dataset.events,
    goxormbr.core.mapping.classes,
    goxormbr.manager.dataset.rest.adapter,
    goxormbr.core.mapping.explorer,
    goxormbr.core.rtti.helper,
    goxormbr.core.types,
    goxormbr.manager.dataset.rest.session;

type
  /// <summary>
  /// Captura de eventos específicos do componente TFDMemTable
  /// </summary>
  TRESTFDMemTableEvents = class(TDataSetEvents)
  private
    FBeforeApplyUpdates: TFDDataSetEvent;
    FAfterApplyUpdates: TFDAfterApplyUpdatesEvent;
  public
    property BeforeApplyUpdates: TFDDataSetEvent read FBeforeApplyUpdates write FBeforeApplyUpdates;
    property AfterApplyUpdates: TFDAfterApplyUpdatesEvent read FAfterApplyUpdates write FAfterApplyUpdates;
  end;

  // Adapter TClientDataSet para controlar o Modelo e o Controle definido por:
  // M - Object Model
  TGOXManagerDatasetAdapterRestFDMemTable<M: class, constructor> = class(TGOXManagerDataSetAdapterRest<M>)
  private
  protected
    FOrmDataSet: TFDMemTable;
    FMemTableEvents: TRESTFDMemTableEvents;
    procedure DoBeforeApplyUpdates(DataSet: TFDDataSet);
    procedure DoAfterApplyUpdates(DataSet: TFDDataSet; AErrors: Integer);

    procedure FilterDataSetChilds;
    //
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
    //
    procedure OpenWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer); override;
    procedure OpenFrom(const ASubResourceName: String); override;
  public
    constructor Create(const AConnection: TGOXRESTConnection; ADataSet: TDataSet; APageSize: Integer; AMasterObject: TObject); override;
    destructor Destroy; override;
  end;

implementation

uses
  goxormbr.core.bind,
  goxormbr.core.objects.helper,
  goxormbr.manager.dataset.fields;

{ TGOXManagerDatasetAdapterRestFDMemTable<M> }

constructor TGOXManagerDatasetAdapterRestFDMemTable<M>.Create(const AConnection: TGOXRESTConnection;  ADataSet: TDataSet; APageSize: Integer; AMasterObject: TObject);
begin
  inherited Create(AConnection, ADataSet, APageSize, AMasterObject);
  /// <summary>
  /// Captura o component TFDMemTable da IDE passado como parâmetro
  /// </summary>
  FOrmDataSet := ADataSet as TFDMemTable;
  FMemTableEvents := TRESTFDMemTableEvents.Create;
  /// <summary>
  /// Captura e guarda os eventos do dataset
  /// </summary>
  GetDataSetEvents;
  /// <summary>
  /// Seta os eventos do ormbr no dataset, para que ele sejam disparados
  /// </summary>
  SetDataSetEvents;
  ///
  if not FOrmDataSet.Active then
  begin
    FOrmDataSet.FetchOptions.RecsMax := 300000;
    FOrmDataSet.ResourceOptions.SilentMode := True;
    FOrmDataSet.UpdateOptions.LockMode := lmNone;
    FOrmDataSet.UpdateOptions.LockPoint := lpDeferred;
    FOrmDataSet.UpdateOptions.FetchGeneratorsPoint := gpImmediate;
    FOrmDataSet.CreateDataSet;
    FOrmDataSet.Open;
    FOrmDataSet.CachedUpdates := False;
    FOrmDataSet.LogChanges := False;
  end;
end;

destructor TGOXManagerDatasetAdapterRestFDMemTable<M>.Destroy;
begin
  FOrmDataSet := nil;
  FMemTableEvents.Free;
  inherited;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.DoAfterApplyUpdates(DataSet: TFDDataSet; AErrors: Integer);
begin
  if Assigned(FMemTableEvents.AfterApplyUpdates) then
    FMemTableEvents.AfterApplyUpdates(DataSet, AErrors);
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.DoBeforeApplyUpdates(DataSet: TFDDataSet);
begin
  if Assigned(FMemTableEvents.BeforeApplyUpdates) then
    FMemTableEvents.BeforeApplyUpdates(DataSet);
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.EmptyDataSet;
begin
  inherited;
  FOrmDataSet.EmptyDataSet;
  /// <summary> Lista os registros das tabelas filhas relacionadas </summary>
  EmptyDataSetChilds;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.EmptyDataSetChilds;
var
  LChild: TPair<string, TGOXManagerDataSetAdapterBase<M>>;
  LDataSet: TFDMemTable;
begin
  inherited;
  if FMasterObject.Count > 0 then
  begin
    for LChild in FMasterObject do
    begin
      LDataSet := TGOXManagerDatasetAdapterRestFDMemTable<M>(LChild.Value).FOrmDataSet;
      if LDataSet.Active then
        LDataSet.EmptyDataSet;
    end;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.FilterDataSetChilds;
var
  LRttiType: TRttiType;
  LAssociations: TAssociationMappingList;
  LAssociation: TAssociationMapping;
  LChild: TGOXManagerDataSetAdapterBase<M>;
  LFor: Integer;
  LIndexFields: string;
  LFields: string;
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

    LIndexFields := '';
    LFields := '';
    TFDMemTable(LChild.FOrmDataSet).MasterSource := FOrmDataSource;
    for LFor := 0 to LAssociation.ColumnsName.Count -1 do
    begin
      LIndexFields := LIndexFields + LAssociation.ColumnsNameRef[LFor];
      LFields := LFields + LAssociation.ColumnsName[LFor];
      if LAssociation.ColumnsName.Count -1 > LFor then
      begin
        LIndexFields := LIndexFields + '; ';
        LFields := LFields + '; ';
      end;
    end;
    TFDMemTable(LChild.FOrmDataSet).IndexFieldNames := LIndexFields;
    TFDMemTable(LChild.FOrmDataSet).MasterFields := LFields;
    /// <summary>
    /// Filtra os registros filhos associados ao LChild caso ele seja
    /// master de outros objetos.
    /// </summary>
    if LChild.FMasterObject.Count > 0 then
      TGOXManagerDatasetAdapterRestFDMemTable<M>(LChild).FilterDataSetChilds;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.GetDataSetEvents;
begin
  inherited;
  if Assigned(FOrmDataSet.BeforeApplyUpdates) then
    FMemTableEvents.BeforeApplyUpdates := FOrmDataSet.BeforeApplyUpdates;
  if Assigned(FOrmDataSet.AfterApplyUpdates)  then
    FMemTableEvents.AfterApplyUpdates  := FOrmDataSet.AfterApplyUpdates;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.OpenWhere(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer);
var
  LObjectList: TObjectList<M>;
begin
//  FOrmDataSet.BeginBatch;
  FOrmDataSet.DisableConstraints;
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    /// <summary> Limpa os registro do dataset antes de garregar os novos dados </summary>
    EmptyDataSet;
    inherited;
    LObjectList := FSession.FindWhere(AWhere, AOrderBy, APageNumber, ARowsByPage);
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
    FOrmDataSet.EnableConstraints;
//    FOrmDataSet.EndBatch;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.OpenFrom(const ASubResourceName: String);
var
  LObjectList: TObjectList<M>;
begin
//  FOrmDataSet.BeginBatch;
  FOrmDataSet.DisableConstraints;
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    /// <summary> Limpa os registro do dataset antes de garregar os novos dados </summary>
    EmptyDataSet;
    inherited;
    LObjectList := FSession.FindFrom(ASubResourceName);
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
    FOrmDataSet.EnableConstraints;
//    FOrmDataSet.EndBatch;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.OpenIDInternal(const APK: Variant);
var
  LObject: M;
begin
//  FOrmDataSet.BeginBatch;
  FOrmDataSet.DisableConstraints;
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    /// <summary> Limpa os registro do dataset antes de garregar os novos dados </summary>
    EmptyDataSet;
    inherited;
    LObject := FSession.Find(VarToStr(APK));
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
    FOrmDataSet.EnableConstraints;
//    FOrmDataSet.EndBatch;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.OpenSQLInternal(const ASQL: string);
var
  LObjectList: TObjectList<M>;
begin
//  FOrmDataSet.BeginBatch;
  FOrmDataSet.DisableConstraints;
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  try
    // Limpa registro do dataset antes de buscar os novos
    EmptyDataSet;
    inherited;
    LObjectList := FSession.Find;
    if LObjectList <> nil then
    begin
      try
        PopularDataSetList(LObjectList);
        // Filtra os registros nas sub-tabelas
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
    FOrmDataSet.EnableConstraints;
//    FOrmDataSet.EndBatch;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.OpenWhereInternal(const AWhere, AOrderBy: string);
var
  LObjectList: TObjectList<M>;
begin
//  FOrmDataSet.BeginBatch;
  FOrmDataSet.DisableConstraints;
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
    FOrmDataSet.EnableConstraints;
//    FOrmDataSet.EndBatch;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.PopularDataSetOneToOne(
  const AObject: TObject; const AAssociation: TAssociationMapping);
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
  TFDMemTable(LChild.FOrmDataSet).MasterSource := nil;
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
    TFDMemTable(LChild.FOrmDataSet).MasterSource := FOrmDataSource;
    LChild.FOrmDataSet.First;
    LChild.FOrmDataSet.EnableControls;
    LChild.EnableDataSetEvents;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.ApplyInternal(const MaxErros: Integer);
var
  LRecnoBook: TBookmark;
begin
  LRecnoBook := FOrmDataSet.GetBookmark;
  FOrmDataSet.DisableControls;
  FOrmDataSet.DisableConstraints;
  DisableDataSetEvents;
  try
    ApplyInserter(MaxErros);
    ApplyUpdater(MaxErros);
    ApplyDeleter(MaxErros);
  finally
    FOrmDataSet.GotoBookmark(LRecnoBook);
    FOrmDataSet.FreeBookmark(LRecnoBook);
    FOrmDataSet.EnableConstraints;
    FOrmDataSet.EnableControls;
    EnableDataSetEvents;
  end;
end;

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.ApplyUpdates(const MaxErros: Integer);
begin
  inherited;
  try
    DoBeforeApplyUpdates(FOrmDataSet);
    ApplyInternal(MaxErros);
    DoAfterApplyUpdates(FOrmDataSet, MaxErros);
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

procedure TGOXManagerDatasetAdapterRestFDMemTable<M>.SetDataSetEvents;
begin
  inherited;
  FOrmDataSet.BeforeApplyUpdates := DoBeforeApplyUpdates;
  FOrmDataSet.AfterApplyUpdates  := DoAfterApplyUpdates;
end;

end.
