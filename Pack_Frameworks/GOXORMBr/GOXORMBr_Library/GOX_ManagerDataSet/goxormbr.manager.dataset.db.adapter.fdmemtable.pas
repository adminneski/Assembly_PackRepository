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


unit goxormbr.manager.dataset.db.adapter.fdmemtable;

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
  goxormbr.core.types;

type
  // Captura de eventos específicos do componente TFDMemTable
  TFDMemTableEvents = class(TDataSetEvents)
  private
    FBeforeApplyUpdates: TFDDataSetEvent;
    FAfterApplyUpdates: TFDAfterApplyUpdatesEvent;
  public
    property BeforeApplyUpdates: TFDDataSetEvent read FBeforeApplyUpdates write FBeforeApplyUpdates;
    property AfterApplyUpdates: TFDAfterApplyUpdatesEvent read FAfterApplyUpdates write FAfterApplyUpdates;
  end;

  // Adapter TFDMemTable para controlar o Modelo e o Controle definido por:
  // M - Object Model
  TGOXManagerDatasetAdapterFDMemTable<M: class, constructor> = class(TGOXManagerDatasetAdapter<M>)
  private
    FOrmDataSet: TFDMemTable;
    FMemTableEvents: TFDMemTableEvents;
    function GetIndexFieldNames(AOrderBy: String): String;
    procedure DoBeforeApplyUpdatesInternal(DataSet: TFDDataSet);
    procedure DoAfterApplyUpdatesInternal(DataSet: TFDDataSet; AErrors: Integer);
  protected
    procedure DoBeforeApplyUpdates(DataSet: TDataSet); override;
    procedure DoAfterApplyUpdates(DataSet: TDataSet; AErrors: Integer); override;
    procedure EmptyDataSetChilds; override;
    procedure GetDataSetEvents; override;
    procedure SetDataSetEvents; override;
    procedure ApplyInserter(const MaxErros: Integer); override;
    procedure ApplyUpdater(const MaxErros: Integer); override;
    procedure ApplyDeleter(const MaxErros: Integer); override;
    procedure ApplyInternal(const MaxErros: Integer); override;
  public
    constructor Create(AGOXORMEngine: TGOXDBConnection; ADataSet: TDataSet; APageSize: Integer; AMasterObject: TObject); overload;
    destructor Destroy; override;
    procedure OpenIDInternal(const APK: Variant); override;
    procedure OpenSQLInternal(const ASQL: string); override;
    procedure OpenWhereInternal(const AWhere: string; const AOrderBy: string = ''); override;
    procedure ApplyUpdates(const MaxErros: Integer); override;
    procedure EmptyDataSet; override;
    //
    procedure OpenWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer); override;

  end;

implementation

uses
  goxormbr.core.bind,
  goxormbr.manager.dataset.fields,
  goxormbr.core.rtti.helper,
  goxormbr.core.objects.helper,
  goxormbr.core.consts,
  goxormbr.core.mapping.explorer;

{ TGOXManagerDatasetAdapterFDMemTable<M> }

constructor TGOXManagerDatasetAdapterFDMemTable<M>.Create(AGOXORMEngine: TGOXDBConnection; ADataSet: TDataSet;
  APageSize: Integer; AMasterObject: TObject);
begin
  inherited Create(AGOXORMEngine, ADataSet, APageSize, AMasterObject);
  // Captura o component TFDMemTable da IDE passado como parâmetro
  FOrmDataSet := ADataSet as TFDMemTable;
  FMemTableEvents := TFDMemTableEvents.Create;
  // Captura e guarda os eventos do dataset
  GetDataSetEvents;
  // Seta os eventos do ORM no dataset, para que ele sejam disparados
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

destructor TGOXManagerDatasetAdapterFDMemTable<M>.Destroy;
begin
  FOrmDataSet := nil;
  FMemTableEvents.Free;
  inherited;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.DoBeforeApplyUpdatesInternal(DataSet: TFDDataSet);
begin
  DoBeforeApplyUpdates(DataSet);
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.DoAfterApplyUpdatesInternal(DataSet: TFDDataSet;
  AErrors: Integer);
begin
  DoAfterApplyUpdates(DataSet, AErrors);
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.DoBeforeApplyUpdates(DataSet: TDataSet);
begin
  if Assigned(FMemTableEvents.BeforeApplyUpdates) then
    FMemTableEvents.BeforeApplyUpdates(TFDDataSet(DataSet));
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.DoAfterApplyUpdates(DataSet: TDataSet; AErrors: Integer);
begin
  if Assigned(FMemTableEvents.AfterApplyUpdates) then
    FMemTableEvents.AfterApplyUpdates(TFDDataSet(DataSet), AErrors);
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.EmptyDataSet;
begin
  inherited;
  FOrmDataSet.EmptyDataSet;
  // Lista os registros das tabelas filhas relacionadas
  EmptyDataSetChilds;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.EmptyDataSetChilds;
var
  LChild: TPair<string, TGOXManagerDataSetAdapterBase<M>>;
  LDataSet: TFDMemTable;
begin
  inherited;
  if FMasterObject.Count = 0 then
    Exit;

  for LChild in FMasterObject do
  begin
    LDataSet := TGOXManagerDatasetAdapterFDMemTable<M>(LChild.Value).FOrmDataSet;
    if LDataSet.Active then
      LDataSet.EmptyDataSet;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.GetDataSetEvents;
begin
  inherited;
  if Assigned(FOrmDataSet.BeforeApplyUpdates) then
    FMemTableEvents.BeforeApplyUpdates := FOrmDataSet.BeforeApplyUpdates;
  if Assigned(FOrmDataSet.AfterApplyUpdates)  then
    FMemTableEvents.AfterApplyUpdates  := FOrmDataSet.AfterApplyUpdates;
end;

function TGOXManagerDatasetAdapterFDMemTable<M>.GetIndexFieldNames(AOrderBy: String): String;
var
  LFields: TOrderByMapping;
  LOrderBy: String;
begin
  Result := '';
  LOrderBy := AOrderBy;
  if LOrderBy = '' then
  begin
    LFields := TMappingExplorer.GetMappingOrderBy(TClass(M));
    if LFields <> nil then
      LOrderBy := LFields.ColumnsName;
  end;
  if LOrderBy <> '' then
  begin
    LOrderBy := StringReplace(UpperCase(LOrderBy), ' ASC' , ':A', [rfReplaceAll]);
    LOrderBy := StringReplace(UpperCase(LOrderBy), ' DESC', ':D', [rfReplaceAll]);
    LOrderBy := StringReplace(UpperCase(LOrderBy), ',', ';', [rfReplaceAll]);
    Result   := LOrderBy;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.ApplyInternal(const MaxErros: Integer);
var
  LDetail: TGOXManagerDataSetAdapterBase<M>;
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
    // Executa o ApplyInternal de toda a hierarquia de dataset filho.
    if FMasterObject.Count = 0 then
      Exit;

    for LDetail in FMasterObject.Values do
    begin
      // Before Apply
      LDetail.DoBeforeApplyUpdates(LDetail.FOrmDataSet);
      LDetail.ApplyInternal(MaxErros);
      // After Apply
      LDetail.DoAfterApplyUpdates(LDetail.FOrmDataSet, MaxErros);
    end;
  finally
    FOrmDataSet.GotoBookmark(LRecnoBook);
    FOrmDataSet.FreeBookmark(LRecnoBook);
    FOrmDataSet.EnableConstraints;
    FOrmDataSet.EnableControls;
    EnableDataSetEvents;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.ApplyDeleter(const MaxErros: Integer);
var
  LFor: Integer;
begin
  inherited;
  // Filtar somente os registros excluídos
  if FSession.DeleteList.Count = 0 then
    Exit;

  for LFor := 0 to FSession.DeleteList.Count -1 do
    FSession.Delete(FSession.DeleteList.Items[LFor]);
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.ApplyInserter(const MaxErros: Integer);
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
begin
  inherited;
  // Filtar somente os registros inseridos
  FOrmDataSet.Filter := cInternalField + '=' + IntToStr(Integer(dsInsert));
  FOrmDataSet.Filtered := True;
  if not FOrmDataSet.IsEmpty then
    FOrmDataSet.First;
  try
    while FOrmDataSet.RecordCount > 0 do
    begin
       // Append/Insert
       if TDataSetState(FOrmDataSet.Fields[FInternalIndex].AsInteger) in [dsInsert] then
       begin
         // Ao passar como parametro a propriedade Current, e disparado o metodo
         // que atualiza a var FCurrentInternal, para ser usada abaixo.
         FSession.Insert(Current);
         FOrmDataSet.Edit;
         if FSession.ExistSequence then
         begin
           LPrimaryKey := TMappingExplorer.GetMappingPrimaryKeyColumns(FCurrentInternal.ClassType);
           if LPrimaryKey = nil then
             raise Exception.Create(cMESSAGEPKNOTFOUND);

           for LColumn in LPrimaryKey.Columns do
           begin
             FOrmDataSet.FieldByName(LColumn.ColumnName).Value :=
               LColumn.ColumnProperty
                      .GetNullableValue(TObject(FCurrentInternal)).AsVariant;
           end;
           // Atualiza o valor do AutoInc nas sub tabelas
           SetAutoIncValueChilds;
         end;
         FOrmDataSet.Fields[FInternalIndex].AsInteger := -1;
         FOrmDataSet.Post;
       end;
    end;
  finally
    FOrmDataSet.Filtered := False;
    FOrmDataSet.Filter := '';
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.ApplyUpdater(const MaxErros: Integer);
var
  LProperty: TRttiProperty;
  LObject: TObject;
begin
  inherited;
  // Filtar somente os registros modificados
  FOrmDataSet.Filter := cInternalField + '=' + IntToStr(Integer(dsEdit));
  FOrmDataSet.Filtered := True;
  if not FOrmDataSet.IsEmpty then
    FOrmDataSet.First;
  try
    while FOrmDataSet.RecordCount > 0 do
    begin
      // Edit
      if TDataSetState(FOrmDataSet.Fields[FInternalIndex].AsInteger) in [dsEdit] then
      begin
        if (FSession.ModifiedFields.Items[M.ClassName].Count > 0) then
        begin
          LObject := M.Create;
          try
            TBind.Instance.SetFieldToProperty(FOrmDataSet, LObject);
            FSession.Update(LObject, M.ClassName);
          finally
            LObject.Free;
          end;
        end;
        FOrmDataSet.Edit;
        FOrmDataSet.Fields[FInternalIndex].AsInteger := -1;
        FOrmDataSet.Post;
      end;
    end;
  finally
    FOrmDataSet.Filtered := False;
    FOrmDataSet.Filter := '';
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.ApplyUpdates(const MaxErros: Integer);
var
  LInTransaction: Boolean;
  LIsConnected: Boolean;
begin
  inherited;
  // Controle de transação externa, controlada pelo desenvolvedor
  LInTransaction := FGOXORMEngine.InTransaction;
  LIsConnected := FGOXORMEngine.IsConnected;
  if not LIsConnected then
    FGOXORMEngine.Connect;
  try
    if not LInTransaction then
      FGOXORMEngine.StartTransaction;
    // Before Apply
    DoBeforeApplyUpdates(FOrmDataSet);
    try
      ApplyInternal(MaxErros);
      // After Apply
      DoAfterApplyUpdates(FOrmDataSet, MaxErros);
      if not LInTransaction then
        FGOXORMEngine.Commit;
    except
      if not LInTransaction then
        FGOXORMEngine.Rollback;
      raise;
    end;
  finally
    if FSession.ModifiedFields.ContainsKey(M.ClassName) then
    begin
      FSession.ModifiedFields.Items[M.ClassName].Clear;
      FSession.ModifiedFields.Items[M.ClassName].TrimExcess;
    end;
    FSession.DeleteList.Clear;
    FSession.DeleteList.TrimExcess;

    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.OpenWhere(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer);
var
  LIsConnected: Boolean;
  LOrderBy: String;
  LPosD: Integer;
begin
  FOrmDataSet.DisableControls;
  FOrmDataSet.DisableConstraints;
  DisableDataSetEvents;
  LIsConnected := FGOXORMEngine.IsConnected;
  if not LIsConnected then
    FGOXORMEngine.Connect;
  try
    try
      // Limpa os registro do dataset antes de garregar os novos dados
      EmptyDataSet;
      inherited;
      FSession.OpenWhere(AWhere,AOrderBy,APageNumber,ARowsByPage);
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    EnableDataSetEvents;
    // Define a order no dataset
    FOrmDataSet.IndexFieldNames := GetIndexFieldNames(AOrderBy);
    // Erro interno do FireDAC se no método First se o dataset estiver vazio
    if not FOrmDataSet.IsEmpty then
      FOrmDataSet.First;
    FOrmDataSet.EnableConstraints;
    FOrmDataSet.EnableControls;
    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.OpenIDInternal(const APK: Variant);
var
  LIsConnected: Boolean;
begin
  FOrmDataSet.DisableControls;
  FOrmDataSet.DisableConstraints;
  DisableDataSetEvents;
  LIsConnected := FGOXORMEngine.IsConnected;
  if not LIsConnected then
    FGOXORMEngine.Connect;
  try
    try
      // Limpa os registro do dataset antes de garregar os novos dados
      EmptyDataSet;
      inherited;
      FSession.OpenID(APK);
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    EnableDataSetEvents;
    // Define a order no dataset
    FOrmDataSet.IndexFieldNames := GetIndexFieldNames('');
    // Erro interno do FireDAC se no método First se o dataset estiver vazio
    if not FOrmDataSet.IsEmpty then
      FOrmDataSet.First;
    FOrmDataSet.EnableConstraints;
    FOrmDataSet.EnableControls;
    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.OpenSQLInternal(const ASQL: string);
var
  LIsConnected: Boolean;
begin
  FOrmDataSet.DisableControls;
  FOrmDataSet.DisableConstraints;
  DisableDataSetEvents;
  LIsConnected := FGOXORMEngine.IsConnected;
  if not LIsConnected then
    FGOXORMEngine.Connect;
  try
    try
      // Limpa os registro do dataset antes de garregar os novos dados
      EmptyDataSet;
      inherited;
      FSession.OpenSQL(ASQL);
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    EnableDataSetEvents;
    // Define a order no dataset
    FOrmDataSet.IndexFieldNames := GetIndexFieldNames('');
    // Erro interno do FireDAC se no método First se o dataset estiver vazio
    if not FOrmDataSet.IsEmpty then
      FOrmDataSet.First;
    FOrmDataSet.EnableConstraints;
    FOrmDataSet.EnableControls;
    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.OpenWhereInternal(const AWhere, AOrderBy: string);
var
  LIsConnected: Boolean;
  LOrderBy: String;
  LPosD: Integer;
begin
  FOrmDataSet.DisableControls;
  FOrmDataSet.DisableConstraints;
  DisableDataSetEvents;
  LIsConnected := FGOXORMEngine.IsConnected;
  if not LIsConnected then
    FGOXORMEngine.Connect;
  try
    try
      // Limpa os registro do dataset antes de garregar os novos dados
      EmptyDataSet;
      inherited;
      FSession.OpenWhere(AWhere, AOrderBy);
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    EnableDataSetEvents;
    // Define a order no dataset
    FOrmDataSet.IndexFieldNames := GetIndexFieldNames(AOrderBy);
    // Erro interno do FireDAC se no método First se o dataset estiver vazio
    if not FOrmDataSet.IsEmpty then
      FOrmDataSet.First;
    FOrmDataSet.EnableConstraints;
    FOrmDataSet.EnableControls;
    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterFDMemTable<M>.SetDataSetEvents;
begin
  inherited;
  FOrmDataSet.BeforeApplyUpdates := DoBeforeApplyUpdatesInternal;
  FOrmDataSet.AfterApplyUpdates  := DoAfterApplyUpdatesInternal;
end;

end.
