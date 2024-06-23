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


unit goxormbr.manager.dataset.db.adapter.clientdataset;

interface

uses
  DB,
  Rtti,
  Classes,
  SysUtils,
  StrUtils,
  DBClient,
  Variants,
  Generics.Collections,
  ///GOXORMBr
  goxormbr.core.criteria,
  goxormbr.manager.dataset.db.adapter,
  goxormbr.manager.dataset.adapter.base,
  goxormbr.manager.dataset.events,
  goxormbr.core.mapping.classes,
  goxormbr.core.types;

type
  // Captura de eventos específicos do componente TClientDataSet
  TClientDataSetEvents = class(TDataSetEvents)
  private
    FBeforeApplyUpdates: TRemoteEvent;
    FAfterApplyUpdates: TRemoteEvent;
  public
    property BeforeApplyUpdates: TRemoteEvent read FBeforeApplyUpdates write FBeforeApplyUpdates;
    property AfterApplyUpdates: TRemoteEvent read FAfterApplyUpdates write FAfterApplyUpdates;
  end;

  // Adapter TClientDataSet para controlar o Modelo e o Controle definido por:
  // M - Object Model
  TGOXManagerDatasetAdapterClientDataSet<M: class, constructor> = class(TGOXManagerDatasetAdapter<M>)
  private
    FOrmDataSet: TClientDataSet;
    FClientDataSetEvents: TClientDataSetEvents;
    function GetIndexFieldNames(AOrderBy: String): String;
  protected
    procedure DoBeforeApplyUpdates(Sender: TObject; var OwnerData: OleVariant); override;
    procedure DoAfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant); override;
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
  end;

implementation

uses
  goxormbr.core.bind,
  goxormbr.manager.dataset.fields,
  goxormbr.core.rtti.helper,
  goxormbr.core.objects.helper,
  goxormbr.core.consts,
  goxormbr.core.mapping.explorer;


{ TGOXManagerDatasetAdapterClientDataSet<M> }

constructor TGOXManagerDatasetAdapterClientDataSet<M>.Create(AGOXORMEngine: TGOXDBConnection; ADataSet: TDataSet; APageSize: Integer; AMasterObject: TObject);
begin
  inherited Create(AGOXORMEngine, ADataSet, APageSize, AMasterObject);
  // Captura o component TClientDataset da IDE passado como parâmetro
  FOrmDataSet := ADataSet as TClientDataSet;
  FClientDataSetEvents := TClientDataSetEvents.Create;
  // Captura e guarda os eventos do dataset
  GetDataSetEvents;
  // Seta os eventos do ORM no dataset, para que ele sejam disparados
  SetDataSetEvents;
  //
  if not FOrmDataSet.Active then
  begin
     FOrmDataSet.CreateDataSet;
     FOrmDataSet.LogChanges := False;
  end;
end;

destructor TGOXManagerDatasetAdapterClientDataSet<M>.Destroy;
begin
  FOrmDataSet := nil;
  FClientDataSetEvents.Free;
  inherited;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.DoAfterApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
  if Assigned(FClientDataSetEvents.AfterApplyUpdates) then
    FClientDataSetEvents.AfterApplyUpdates(Sender, OwnerData);
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.DoBeforeApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
  if Assigned(FClientDataSetEvents.BeforeApplyUpdates) then
    FClientDataSetEvents.BeforeApplyUpdates(Sender, OwnerData);
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.EmptyDataSet;
begin
  inherited;
  FOrmDataSet.EmptyDataSet;
  // Lista os registros das tabelas filhas relacionadas
  EmptyDataSetChilds;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.EmptyDataSetChilds;
var
  LChild: TPair<string, TGOXManagerDataSetAdapterBase<M>>;
  LDataSet: TClientDataSet;
begin
  inherited;
  if FMasterObject.Count = 0 then
    Exit;

  for LChild in FMasterObject do
  begin
    LDataSet := TGOXManagerDatasetAdapterClientDataSet<M>(LChild.Value).FOrmDataSet;
    if LDataSet.Active then
      LDataSet.EmptyDataSet;
  end;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.GetDataSetEvents;
begin
  inherited;
  if Assigned(FOrmDataSet.BeforeApplyUpdates) then
    FClientDataSetEvents.BeforeApplyUpdates := FOrmDataSet.BeforeApplyUpdates;
  if Assigned(FOrmDataSet.AfterApplyUpdates)  then
    FClientDataSetEvents.AfterApplyUpdates  := FOrmDataSet.AfterApplyUpdates;
end;

function TGOXManagerDatasetAdapterClientDataSet<M>.GetIndexFieldNames(AOrderBy: String): String;
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
    LOrderBy := StringReplace(UpperCase(LOrderBy), ' ASC' , '', [rfReplaceAll]);
    LOrderBy := StringReplace(UpperCase(LOrderBy), ' DESC', '', [rfReplaceAll]);
    LOrderBy := StringReplace(UpperCase(LOrderBy), ',', ';', [rfReplaceAll]);
    Result := LOrderBy;
  end;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.OpenIDInternal(const APK: Variant);
var
  LIsConnected: Boolean;
begin
  FOrmDataSet.DisableControls;
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
    FOrmDataSet.EnableControls;
    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.OpenSQLInternal(const ASQL: string);
var
  LIsConnected: Boolean;
begin
  FOrmDataSet.DisableControls;
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
    FOrmDataSet.EnableControls;
    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.OpenWhereInternal(const AWhere, AOrderBy: string);
var
  LIsConnected: Boolean;
begin
  FOrmDataSet.DisableControls;
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
    FOrmDataSet.EnableControls;
    if not LIsConnected then
      FGOXORMEngine.Disconnect;
  end;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.ApplyInternal(const MaxErros: Integer);
var
  LDetail: TGOXManagerDataSetAdapterBase<M>;
  LRecnoBook: TBookmark;
  LOwnerData: OleVariant;
begin
  LRecnoBook := FOrmDataSet.Bookmark;
  FOrmDataSet.DisableControls;
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
      LDetail.DoBeforeApplyUpdates(LDetail.FOrmDataSet, LOwnerData);
      LDetail.ApplyInternal(MaxErros);
      // After Apply
      LDetail.DoAfterApplyUpdates(LDetail.FOrmDataSet, LOwnerData);
    end;
  finally
    FOrmDataSet.GotoBookmark(LRecnoBook);
    FOrmDataSet.FreeBookmark(LRecnoBook);
    FOrmDataSet.EnableControls;
    EnableDataSetEvents;
  end;
end;

procedure TGOXManagerDatasetAdapterClientDataSet<M>.ApplyDeleter(const MaxErros: Integer);
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

procedure TGOXManagerDatasetAdapterClientDataSet<M>.ApplyInserter(const MaxErros: Integer);
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

procedure TGOXManagerDatasetAdapterClientDataSet<M>.ApplyUpdater(const MaxErros: Integer);
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
      /// Edit
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

procedure TGOXManagerDatasetAdapterClientDataSet<M>.ApplyUpdates(const MaxErros: Integer);
var
  LOwnerData: OleVariant;
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
    DoBeforeApplyUpdates(FOrmDataSet, LOwnerData);
    try
      ApplyInternal(MaxErros);
      // After Apply
      DoAfterApplyUpdates(FOrmDataSet, LOwnerData);
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

procedure TGOXManagerDatasetAdapterClientDataSet<M>.SetDataSetEvents;
begin
  inherited;
  FOrmDataSet.BeforeApplyUpdates := DoBeforeApplyUpdates;
  FOrmDataSet.AfterApplyUpdates  := DoAfterApplyUpdates;
end;

end.
