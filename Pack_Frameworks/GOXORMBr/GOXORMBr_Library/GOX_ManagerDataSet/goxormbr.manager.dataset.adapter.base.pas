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


unit goxormbr.manager.dataset.adapter.base;

interface

uses
  DB,
  Rtti,
  TypInfo, {Delphi 2010}
  Classes,
  SysUtils,
  StrUtils,
  Variants,
  Generics.Collections,
  /// orm
  goxormbr.manager.dataset.events,
  goxormbr.manager.dataset.adapter.base.abstract,
  goxormbr.core.session.abstract,
  goxormbr.core.mapping.classes, goxormbr.core.types;

type
  // M - Object M
  TGOXManagerDataSetAdapterBase<M: class, constructor> = class(TGOXManagerDatasetAdapterBaseAbstract<M>)
  private
    // Objeto para captura dos eventos do dataset passado pela interface
    FOrmDataSetEvents: TDataSet;
    // Controle de paginação vindo do banco de dados
    FPageSize: Integer;
    //
    procedure ExecuteOneToOne(AObject: M; AProperty: TRttiProperty; ADatasetBase: TGOXManagerDataSetAdapterBase<M>);
    procedure ExecuteOneToMany(AObject: M; AProperty: TRttiProperty; ADatasetBase: TGOXManagerDataSetAdapterBase<M>; ARttiType: TRttiType);
    procedure GetMasterValues;
    //
    function FindEvents(AEventName: string): Boolean;
    function GetAutoNextPacket: Boolean;
    procedure SetAutoNextPacket(const Value: Boolean);
    procedure ValideFieldEvents(const AFieldEvents: TFieldEventsMappingList);
  protected
    // Classe para controle de evento interno com os eventos da interface do dataset
    FDataSetEvents: TDataSetEvents;
    // Usado em relacionamento mestre-detalhe, guarda qual objeto pai
    FOwnerMasterObject: TObject;
    // Uso interno para fazer mapeamento do registro dataset
    FCurrentInternal: M;
    FMasterObject: TDictionary<string, TGOXManagerDataSetAdapterBase<M>>;
    FLookupsField: TList<TGOXManagerDataSetAdapterBase<M>>;
    FInternalIndex: Integer;
    FAutoNextPacket: Boolean;
    FCheckedFieldEvents: Boolean;
    procedure DoBeforeApplyUpdates(DataSet: TDataSet); overload; virtual; abstract;
    procedure DoAfterApplyUpdates(DataSet: TDataSet; AErrors: Integer); overload; virtual; abstract;

    procedure DoBeforeApplyUpdates(Sender: TObject; var OwnerData: OleVariant); overload; virtual;
    procedure DoAfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant); overload; virtual;

    procedure DoBeforeScroll(DataSet: TDataSet); virtual;
    procedure DoAfterScroll(DataSet: TDataSet); virtual;
    procedure DoBeforeOpen(DataSet: TDataSet); virtual;
    procedure DoAfterOpen(DataSet: TDataSet); virtual;
    procedure DoBeforeClose(DataSet: TDataSet); virtual;
    procedure DoAfterClose(DataSet: TDataSet); virtual;
    procedure DoBeforeDelete(DataSet: TDataSet); virtual;
    procedure DoAfterDelete(DataSet: TDataSet); virtual;
    procedure DoBeforeInsert(DataSet: TDataSet); virtual;
    procedure DoAfterInsert(DataSet: TDataSet); virtual;
    procedure DoBeforeEdit(DataSet: TDataSet); virtual;
    procedure DoAfterEdit(DataSet: TDataSet); virtual;
    procedure DoBeforePost(DataSet: TDataSet); virtual;
    procedure DoAfterPost(DataSet: TDataSet); virtual;
    procedure DoBeforeCancel(DataSet: TDataSet); virtual;
    procedure DoAfterCancel(DataSet: TDataSet); virtual;
    procedure DoNewRecord(DataSet: TDataSet); virtual;
    procedure OpenDataSetChilds; virtual; abstract;
    procedure EmptyDataSetChilds; virtual; abstract;
    procedure GetDataSetEvents; virtual;
    procedure SetDataSetEvents; virtual;
    procedure DisableDataSetEvents; virtual;
    procedure EnableDataSetEvents; virtual;

    procedure ApplyInserter(const MaxErros: Integer); virtual; abstract;
    procedure ApplyUpdater(const MaxErros: Integer); virtual; abstract;
    procedure ApplyDeleter(const MaxErros: Integer); virtual; abstract;
    procedure ApplyInternal(const MaxErros: Integer); virtual; abstract;

    procedure Insert; virtual;
    procedure Append; virtual;
    procedure Post; virtual;
    procedure Edit; virtual;
    procedure Delete; virtual;
    procedure Close; virtual;
    procedure Cancel; virtual;
    procedure SetAutoIncValueChilds; virtual;
    procedure SetMasterObject(const AValue: TObject);
    procedure FillMastersClass(const ADatasetBase: TGOXManagerDataSetAdapterBase<M>; AObject: M);
    function IsAssociationUpdateCascade(ADataSetChild: TGOXManagerDataSetAdapterBase<M>; AColumnsNameRef: string): Boolean; virtual;
    procedure OpenIDInternal(const APK: Variant); overload; virtual; abstract;

  public
    constructor Create(ADataSet: TDataSet; APageSize: Integer;  AMasterObject: TObject); overload; override;
    destructor Destroy; override;
    procedure OpenSQLInternal(const ASQL: string); virtual; abstract;
    procedure OpenWhereInternal(const AWhere: string; const AOrderBy: string = ''); virtual; abstract;
    procedure RefreshRecordInternal(const AObject: TObject); virtual;
    procedure RefreshRecord; virtual;
    procedure NextPacket; overload; virtual; abstract;
    procedure Save(AObject: M); virtual;
    procedure ApplyDataIncludedLast(AObject: M); virtual;
    procedure EmptyDataSet; virtual; abstract;
    procedure CancelUpdates; virtual;
    procedure ApplyUpdates(const MaxErros: Integer); virtual; abstract;
    procedure AddLookupField(const AFieldName: string;
                             const AKeyFields: string;
                             const ALookupDataSet: TObject;
                             const ALookupKeyFields: string;
                             const ALookupResultField: string;
                             const ADisplayLabel: string = '');

    // ObjectSet
    function Find: TObjectList<M>; overload; virtual;
    function Find(const APK: Int64): M; overload; virtual;
    function Find(const APK: String): M; overload; virtual;
    function FindWhere(const AWhere: string; const AOrderBy: string = ''): TObjectList<M>; overload; virtual;
    function FindWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<M>; overload; virtual;

    function FindFrom(const ASubResourceName: String): TObjectList<M>; virtual;
    //
    function Current: M;
    function PrepareWhereFieldAll(AValue:String):String;

    function InitFieldDefsObjectClass(ADataSet: TDataSet):TGOXManagerDataSetAdapterBase<M>; virtual;
    //Somente Usado no Rest
    function ResultParams: TParams; virtual; abstract;
    function AddPathParam(AValue: String):TGOXManagerDataSetAdapterBase<M>; virtual; abstract;
    function AddQueryParam(AKeyName, AValue: String):TGOXManagerDataSetAdapterBase<M>; virtual; abstract;
    function AddBodyParam(AValue: String):TGOXManagerDataSetAdapterBase<M>; virtual; abstract;


    // Property
    property AutoNextPacket: Boolean read GetAutoNextPacket write SetAutoNextPacket;
  end;

implementation

uses
  goxormbr.core.bind,
  goxormbr.manager.dataset.fields,
  goxormbr.core.consts,
  goxormbr.core.objects.helper,
  goxormbr.core.objects.utils,
  goxormbr.core.rtti.helper,
  goxormbr.core.mapping.explorer,
  goxormbr.core.mapping.attributes,
  goxormbr.core.types.mapping;

{ TGOXManagerDataSetAdapterBase<M> }

constructor TGOXManagerDataSetAdapterBase<M>.Create(ADataSet: TDataSet; APageSize: Integer; AMasterObject: TObject);
begin
  FOrmDataSet := ADataSet;
  FPageSize := APageSize;
  FOrmDataSetEvents := TDataSet.Create(nil);
  FMasterObject := TDictionary<string, TGOXManagerDataSetAdapterBase<M>>.Create;
  FLookupsField := TList<TGOXManagerDataSetAdapterBase<M>>.Create;
  FCurrentInternal := M.Create;
  TBind.Instance.SetInternalInitFieldDefsObjectClass(ADataSet, FCurrentInternal);
  TBind.Instance.SetDataDictionary(ADataSet, FCurrentInternal);
  FDataSetEvents := TDataSetEvents.Create;
  FAutoNextPacket := True;
  // Variável que identifica o campo que guarda o estado do registro.
  FInternalIndex := 0;
  FCheckedFieldEvents := False;
  if AMasterObject <> nil then
    SetMasterObject(AMasterObject);
  inherited Create(ADataSet, APageSize, AMasterObject);
end;

destructor TGOXManagerDataSetAdapterBase<M>.Destroy;
begin
  FOrmDataSet := nil;
  FOwnerMasterObject := nil;
  FDataSetEvents.Free;
  FOrmDataSetEvents.Free;
  FCurrentInternal.Free;
  FMasterObject.Clear;
  FMasterObject.Free;
  FLookupsField.Clear;
  FLookupsField.Free;
  inherited;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Save(AObject: M);
begin
  // Aualiza o DataSet com os dados a variável interna
  FOrmDataSet.Edit;
  if FOrmDataSet.State in [dsInsert,dsEdit] then
  TBind.Instance.SetPropertyToField(AObject, FOrmDataSet);
  FOrmDataSet.Post;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Cancel;
begin
  FOrmDataSet.Cancel;
end;

procedure TGOXManagerDataSetAdapterBase<M>.CancelUpdates;
begin
  FSession.ModifiedFields.Items[M.ClassName].Clear;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Close;
begin
  FOrmDataSet.Close;
end;

procedure TGOXManagerDataSetAdapterBase<M>.AddLookupField(const AFieldName: string;
                                                          const AKeyFields: string;
                                                          const ALookupDataSet: TObject;
                                                          const ALookupKeyFields: string;
                                                          const ALookupResultField: string;
                                                          const ADisplayLabel: string);
var
  LColumn: TColumnMapping;
  LColumns: TColumnMappingList;
begin
  // Guarda o datasetlookup em uma lista para controle interno
  FLookupsField.Add(TGOXManagerDataSetAdapterBase<M>(ALookupDataSet));
  LColumns := TMappingExplorer.GetMappingColumn(FLookupsField.Last.FCurrentInternal.ClassType);
  if LColumns = nil then
    Exit;

  for LColumn in LColumns do
  begin
    if LColumn.ColumnName <> ALookupResultField then
      Continue;

    DisableDataSetEvents;
    FOrmDataSet.Close;
    try
      TFieldSingleton
        .GetInstance
          .AddLookupField(AFieldName,
                          FOrmDataSet,
                          AKeyFields,
                          FLookupsField.Last.FOrmDataSet,
                          ALookupKeyFields,
                          ALookupResultField,
                          LColumn.FieldType,
                          LColumn.Size,
                          ADisplayLabel);
    finally
      FOrmDataSet.Open;
      EnableDataSetEvents;
    end;
    // Abre a tabela do TLookupField
    FLookupsField.Last.OpenSQLInternal('');
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Append;
begin
  FOrmDataSet.Append;
end;

procedure TGOXManagerDataSetAdapterBase<M>.ApplyDataIncludedLast(AObject: M);
begin
  if FOrmDataSet.State in [dsInsert] then
  TBind.Instance.SetPropertyToField(AObject, FOrmDataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.EnableDataSetEvents;
var
  LClassType: TRttiType;
  LProperty: TRttiProperty;
  LPropInfo: PPropInfo;
  LMethod: TMethod;
  LMethodNil: TMethod;
begin
  LClassType := TRttiSingleton.GetInstance.GetRttiType(FOrmDataSet.ClassType);
  for LProperty in LClassType.GetProperties do
  begin
    if LProperty.PropertyType.TypeKind <> tkMethod then
      Continue;
    if not FindEvents(LProperty.Name) then
      Continue;
    LPropInfo := GetPropInfo(FOrmDataSet, LProperty.Name);
    if LPropInfo = nil then
      Continue;
    LMethod := GetMethodProp(FOrmDataSetEvents, LPropInfo);
    if not Assigned(LMethod.Code) then
      Continue;
    LMethodNil.Code := nil;
    SetMethodProp(FOrmDataSet, LPropInfo, LMethod);
    SetMethodProp(FOrmDataSetEvents, LPropInfo, LMethodNil);
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.FillMastersClass(
  const ADatasetBase: TGOXManagerDataSetAdapterBase<M>; AObject: M);
var
  LRttiType: TRttiType;
  LProperty: TRttiProperty;
  LAssociation: Association;
begin
  LRttiType := TRttiSingleton.GetInstance.GetRttiType(AObject.ClassType);
  for LProperty in LRttiType.GetProperties do
  begin
    for LAssociation in LProperty.GetAssociation do
    begin
      if LAssociation = nil then
        Continue;
      if LAssociation.Multiplicity in [OneToOne, ManyToOne] then
        ExecuteOneToOne(AObject, LProperty, ADatasetBase)
      else
      if LAssociation.Multiplicity in [OneToMany, ManyToMany] then
        ExecuteOneToMany(AObject, LProperty, ADatasetBase, LRttiType);
    end;
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.ExecuteOneToOne(AObject: M;
  AProperty: TRttiProperty; ADatasetBase: TGOXManagerDataSetAdapterBase<M>);
var
  LBookMark: TBookmark;
  LValue: TValue;
  LObject: TObject;
  LDataSetChild: TGOXManagerDataSetAdapterBase<M>;
begin
  if ADatasetBase.FCurrentInternal.ClassType <>
     AProperty.PropertyType.AsInstance.MetaclassType then
    Exit;
  LValue := AProperty.GetNullableValue(TObject(AObject));
  if not LValue.IsObject then
    Exit;
  LObject := LValue.AsObject;
  LBookMark := ADatasetBase.FOrmDataSet.Bookmark;
  ADatasetBase.FOrmDataSet.First;
  ADatasetBase.FOrmDataSet.BlockReadSize := MaxInt;
  try
    while not ADatasetBase.FOrmDataSet.Eof do
    begin
      // Popula o objeto M e o adiciona na lista e objetos com o registro do DataSet.
      TBind.Instance.SetFieldToProperty(ADatasetBase.FOrmDataSet, LObject);
      // Próximo registro
      ADatasetBase.FOrmDataSet.Next;
    end;
  finally
    ADatasetBase.FOrmDataSet.GotoBookmark(LBookMark);
    ADatasetBase.FOrmDataSet.FreeBookmark(LBookMark);
    ADatasetBase.FOrmDataSet.BlockReadSize := 0;
  end;
  // Populando em hierarquia de vários níveis
  for LDataSetChild in ADatasetBase.FMasterObject.Values do
    LDataSetChild.FillMastersClass(LDataSetChild, LObject);
end;

procedure TGOXManagerDataSetAdapterBase<M>.ExecuteOneToMany(AObject: M;
  AProperty: TRttiProperty; ADatasetBase: TGOXManagerDataSetAdapterBase<M>;
  ARttiType: TRttiType);
var
  LBookMark: TBookmark;
  LPropertyType: TRttiType;
  LObjectType: TObject;
  LObjectList: TObject;
  LDataSetChild: TGOXManagerDataSetAdapterBase<M>;
  LDataSet: TDataSet;
begin
  LPropertyType := AProperty.PropertyType;
  LPropertyType := AProperty.GetTypeValue(LPropertyType);
  if not LPropertyType.IsInstance then
    raise Exception
            .Create('Not in instance ' + LPropertyType.Parent.ClassName + ' - '
                                       + LPropertyType.Name);
  //
  if ADatasetBase.FCurrentInternal.ClassType <>
     LPropertyType.AsInstance.MetaclassType then
    Exit;
  LDataSet := ADatasetBase.FOrmDataSet;
  LBookMark := LDataSet.Bookmark;
  LDataSet.First;
  LDataSet.BlockReadSize := MaxInt;
  try
    while not LDataSet.Eof do
    begin
      LObjectType := LPropertyType.AsInstance.MetaclassType.Create;
      LObjectType.MethodCall('Create', []);
      // Popula o objeto M e o adiciona na lista e objetos com o registro do DataSet.
      TBind.Instance.SetFieldToProperty(LDataSet, LObjectType);

      LObjectList := AProperty.GetNullableValue(TObject(AObject)).AsObject;
      LObjectList.MethodCall('Add', [LObjectType]);
      // Populando em hierarquia de vários níveis
      for LDataSetChild in ADatasetBase.FMasterObject.Values do
        LDataSetChild.FillMastersClass(LDataSetChild, LObjectType);

      // Próximo registro
      LDataSet.Next;
    end;
  finally
    LDataSet.BlockReadSize := 0;
    LDataSet.GotoBookmark(LBookMark);
    LDataSet.FreeBookmark(LBookMark);
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.DisableDataSetEvents;
var
  LClassType: TRttiType;
  LProperty: TRttiProperty;
  LPropInfo: PPropInfo;
  LMethod: TMethod;
  LMethodNil: TMethod;
begin
  LClassType := TRttiSingleton.GetInstance.GetRttiType(FOrmDataSet.ClassType);
  for LProperty in LClassType.GetProperties do
  begin
    if LProperty.PropertyType.TypeKind <> tkMethod then
      Continue;
    if not FindEvents(LProperty.Name) then
      Continue;
    LPropInfo := GetPropInfo(FOrmDataSet, LProperty.Name);
    if LPropInfo = nil then
      Continue;
    LMethod := GetMethodProp(FOrmDataSet, LPropInfo);
    if not Assigned(LMethod.Code) then
      Continue;
    LMethodNil.Code := nil;
    SetMethodProp(FOrmDataSet, LPropInfo, LMethodNil);
    SetMethodProp(FOrmDataSetEvents, LPropInfo, LMethod);
  end;
end;

function TGOXManagerDataSetAdapterBase<M>.Find: TObjectList<M>;
begin
  Result := FSession.Find;
end;

function TGOXManagerDataSetAdapterBase<M>.Find(const APK: Int64): M;
begin
  Result := FSession.Find(APK);
end;

function TGOXManagerDataSetAdapterBase<M>.FindEvents(AEventName: string): Boolean;
begin
  Result := MatchStr(AEventName, ['AfterCancel'   ,'AfterClose'   ,'AfterDelete' ,
                                  'AfterEdit'     ,'AfterInsert'  ,'AfterOpen'   ,
                                  'AfterPost'     ,'AfterRefresh' ,'AfterScroll' ,
                                  'BeforeCancel'  ,'BeforeClose'  ,'BeforeDelete',
                                  'BeforeEdit'    ,'BeforeInsert' ,'BeforeOpen'  ,
                                  'BeforePost'    ,'BeforeRefresh','BeforeScroll',
                                  'OnCalcFields'  ,'OnDeleteError','OnEditError' ,
                                  'OnFilterRecord','OnNewRecord'  ,'OnPostError']);
end;

function TGOXManagerDataSetAdapterBase<M>.FindFrom(const ASubResourceName: String): TObjectList<M>;
begin
  Result := FSession.FindFrom(ASubResourceName);
end;

function TGOXManagerDataSetAdapterBase<M>.FindWhere(const AWhere, AOrderBy: string): TObjectList<M>;
begin
  Result := FSession.FindWhere(AWhere, AOrderBy);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterClose(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterClose) then
    FDataSetEvents.AfterClose(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterDelete(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterDelete) then
    FDataSetEvents.AfterDelete(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterEdit(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterEdit) then
    FDataSetEvents.AfterEdit(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterInsert(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterInsert) then
    FDataSetEvents.AfterInsert(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterOpen(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterOpen) then
    FDataSetEvents.AfterOpen(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterPost(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterPost) then
    FDataSetEvents.AfterPost(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterScroll(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterScroll) then
    FDataSetEvents.AfterScroll(DataSet);
  if FPageSize = -1 then
    Exit;
  if not (FOrmDataSet.State in [dsBrowse]) then
    Exit;
  if not FOrmDataSet.Eof then
    Exit;
  if FOrmDataSet.IsEmpty then
    Exit;
  if not FAutoNextPacket then
    Exit;
  // Controle de paginação de registros retornados do banco de dados
  NextPacket;
end;

function TGOXManagerDataSetAdapterBase<M>.InitFieldDefsObjectClass(ADataSet: TDataSet): TGOXManagerDataSetAdapterBase<M>;
var
  LCurrentObjInternal : M;
begin
  Result := Self;
  try
    LCurrentObjInternal := M.Create;
    TBind.Instance.SetInternalInitFieldDefsObjectClass(ADataSet, LCurrentObjInternal);
  finally
    FreeAndNil(LCurrentObjInternal);
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Insert;
begin
  FOrmDataSet.Insert;
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
begin
  //Abstract
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeCancel(DataSet: TDataSet);
var
  LChild: TGOXManagerDataSetAdapterBase<M>;
  LLookup: TGOXManagerDataSetAdapterBase<M>;
begin
  if Assigned(FDataSetEvents.BeforeCancel) then
    FDataSetEvents.BeforeCancel(DataSet);

  // Executa comando Cancel em cascata
  if not Assigned(FMasterObject) then
    Exit;

  if FMasterObject.Count = 0 then
    Exit;

  for LChild in FMasterObject.Values do
  begin
    if not (LChild.FOrmDataSet.State in [dsInsert, dsEdit]) then
      Continue;

    LChild.Cancel;
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
begin
  //Abstract
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoAfterCancel(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.AfterCancel) then
    FDataSetEvents.AfterCancel(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeClose(DataSet: TDataSet);
var
  LChild: TGOXManagerDataSetAdapterBase<M>;
  LLookup: TGOXManagerDataSetAdapterBase<M>;
begin
  if Assigned(FDataSetEvents.BeforeClose) then
    FDataSetEvents.BeforeClose(DataSet);
  // Executa o comando Close em cascata
  if Assigned(FLookupsField) then
    if FLookupsField.Count > 0 then
      for LChild in FLookupsField do
        LChild.Close;

  if Assigned(FMasterObject) then
    if FMasterObject.Count > 0 then
      for LChild in FMasterObject.Values do
        LChild.Close;
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeDelete(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.BeforeDelete) then
    FDataSetEvents.BeforeDelete(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeEdit(DataSet: TDataSet);
var
  LFieldEvents: TFieldEventsMappingList;
begin
  if Assigned(FDataSetEvents.BeforeEdit) then
    FDataSetEvents.BeforeEdit(DataSet);

  // Checa o Attributo "FieldEvents" nos TFields somente uma vez
  if FCheckedFieldEvents then
    Exit;

  // ForeingnKey da Child
  LFieldEvents := TMappingExplorer.GetMappingFieldEvents(FCurrentInternal.ClassType);
  if LFieldEvents = nil then
    Exit;

  ValideFieldEvents(LFieldEvents);
  FCheckedFieldEvents := True;
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeInsert(DataSet: TDataSet);
var
  LFieldEvents: TFieldEventsMappingList;
begin
  if Assigned(FDataSetEvents.BeforeInsert) then
    FDataSetEvents.BeforeInsert(DataSet);
  // Checa o Attributo "FieldEvents()" nos TFields somente uma vez
  if FCheckedFieldEvents then
    Exit;
  // ForeingnKey da Child
  LFieldEvents := TMappingExplorer.GetMappingFieldEvents(FCurrentInternal.ClassType);
  if LFieldEvents = nil then
    Exit;
  ValideFieldEvents(LFieldEvents);
  FCheckedFieldEvents := True;
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeOpen(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.BeforeOpen) then
    FDataSetEvents.BeforeOpen(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforePost(DataSet: TDataSet);
var
  LDataSetChild: TGOXManagerDataSetAdapterBase<M>;
  LField: TField;
begin
  // Muda o Status do registro, para identificação do GOXORM dos registros que
  // sofreram alterações.
  LField := FOrmDataSet.Fields[FInternalIndex];
  case FOrmDataSet.State of
    dsInsert:
      begin
        LField.AsInteger := Integer(FOrmDataSet.State);
      end;
    dsEdit:
      begin
        if LField.AsInteger = -1 then
          LField.AsInteger := Integer(FOrmDataSet.State);
      end;
  end;
  // Dispara o evento do componente
  if Assigned(FDataSetEvents.BeforePost) then
    FDataSetEvents.BeforePost(DataSet);

  // Aplica o Post() em todas as sub-tabelas relacionadas caso estejam em
  // modo Insert ou Edit.
  if not FOrmDataSet.Active then
    Exit;

  // Tratamento dos datasets filhos.
  for LDataSetChild in FMasterObject.Values do
  begin
    if LDataSetChild.FOrmDataSet = nil then
      Continue;
    if not LDataSetChild.FOrmDataSet.Active then
      Continue;
    if not (LDataSetChild.FOrmDataSet.State in [dsInsert, dsEdit]) then
      Continue;
    LDataSetChild.FOrmDataSet.Post;
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoBeforeScroll(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.BeforeScroll) then
    FDataSetEvents.BeforeScroll(DataSet);
end;

procedure TGOXManagerDataSetAdapterBase<M>.DoNewRecord(DataSet: TDataSet);
begin
  if Assigned(FDataSetEvents.OnNewRecord) then
    FDataSetEvents.OnNewRecord(DataSet);
  // Busca valor da tabela master, caso aqui seja uma tabela detalhe.
  if FMasterObject.Count > 0 then
    GetMasterValues;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Delete;
begin
  FOrmDataSet.Delete;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Edit;
begin
  FOrmDataSet.Edit;
end;

procedure TGOXManagerDataSetAdapterBase<M>.GetDataSetEvents;
begin
  // Scroll Events
  if Assigned(FOrmDataSet.BeforeScroll) then
    FDataSetEvents.BeforeScroll := FOrmDataSet.BeforeScroll;
  if Assigned(FOrmDataSet.AfterScroll) then
    FDataSetEvents.AfterScroll := FOrmDataSet.AfterScroll;
  // Open Events
  if Assigned(FOrmDataSet.BeforeOpen) then
    FDataSetEvents.BeforeOpen := FOrmDataSet.BeforeOpen;
  if Assigned(FOrmDataSet.AfterOpen) then
    FDataSetEvents.AfterOpen := FOrmDataSet.AfterOpen;
  // Close Events
  if Assigned(FOrmDataSet.BeforeClose) then
    FDataSetEvents.BeforeClose := FOrmDataSet.BeforeClose;
  if Assigned(FOrmDataSet.AfterClose) then
    FDataSetEvents.AfterClose := FOrmDataSet.AfterClose;
  // Delete Events
  if Assigned(FOrmDataSet.BeforeDelete) then
    FDataSetEvents.BeforeDelete := FOrmDataSet.BeforeDelete;
  if Assigned(FOrmDataSet.AfterDelete) then
    FDataSetEvents.AfterDelete := FOrmDataSet.AfterDelete;
  // Post Events
  if Assigned(FOrmDataSet.BeforePost) then
    FDataSetEvents.BeforePost := FOrmDataSet.BeforePost;
  if Assigned(FOrmDataSet.AfterPost) then
    FDataSetEvents.AfterPost := FOrmDataSet.AfterPost;
  // Cancel Events
  if Assigned(FOrmDataSet.BeforeCancel) then
    FDataSetEvents.BeforeCancel := FOrmDataSet.BeforeCancel;
  if Assigned(FOrmDataSet.AfterCancel) then
    FDataSetEvents.AfterCancel := FOrmDataSet.AfterCancel;
  // Insert Events
  if Assigned(FOrmDataSet.BeforeInsert) then
    FDataSetEvents.BeforeInsert := FOrmDataSet.BeforeInsert;
  if Assigned(FOrmDataSet.AfterInsert) then
    FDataSetEvents.AfterInsert := FOrmDataSet.AfterInsert;
  // Edit Events
  if Assigned(FOrmDataSet.BeforeEdit) then
    FDataSetEvents.BeforeEdit := FOrmDataSet.BeforeEdit;
  if Assigned(FOrmDataSet.AfterEdit) then
    FDataSetEvents.AfterEdit := FOrmDataSet.AfterEdit;
  // NewRecord Events
  if Assigned(FOrmDataSet.OnNewRecord) then
    FDataSetEvents.OnNewRecord := FOrmDataSet.OnNewRecord
end;

function TGOXManagerDataSetAdapterBase<M>.IsAssociationUpdateCascade(
  ADataSetChild: TGOXManagerDataSetAdapterBase<M>; AColumnsNameRef: string): Boolean;
var
  LForeignKey: TForeignKeyMapping;
  LForeignKeys: TForeignKeyMappingList;
begin
  Result := False;
  // ForeingnKey da Child
  LForeignKeys := TMappingExplorer.GetMappingForeignKey(ADataSetChild.FCurrentInternal.ClassType);
  if LForeignKeys = nil then
    Exit;
  for LForeignKey in LForeignKeys do
  begin
    if not LForeignKey.FromColumns.Contains(AColumnsNameRef) then
      Continue;

    if LForeignKey.RuleUpdate = Cascade then
      Exit(True);
  end;
end;

function TGOXManagerDataSetAdapterBase<M>.GetAutoNextPacket: Boolean;
begin
  Result := FAutoNextPacket;
end;

function TGOXManagerDataSetAdapterBase<M>.Current: M;
var
  LDataSetChild: TGOXManagerDataSetAdapterBase<M>;
begin
  if not FOrmDataSet.Active then
    Exit(FCurrentInternal);

  if FOrmDataSet.RecordCount = 0 then
    Exit(FCurrentInternal);

  TBind.Instance
       .SetFieldToProperty(FOrmDataSet, TObject(FCurrentInternal));

  for LDataSetChild in FMasterObject.Values do
    LDataSetChild.FillMastersClass(LDataSetChild, FCurrentInternal);

  Result := FCurrentInternal;
end;

procedure TGOXManagerDataSetAdapterBase<M>.Post;
begin
  FOrmDataSet.Post;
end;

function TGOXManagerDataSetAdapterBase<M>.PrepareWhereFieldAll(AValue: String): String;
begin
  Result := FSession.PrepareWhereFieldAll(AValue);
end;

procedure TGOXManagerDataSetAdapterBase<M>.RefreshRecord;
var
  LPrimaryKey: TPrimaryKeyMapping;
  LParams: TParams;
  lFor: Integer;
begin
  inherited;
  if FOrmDataSet.RecordCount = 0 then
    Exit;
  LPrimaryKey := TMappingExplorer.GetMappingPrimaryKey(FCurrentInternal.ClassType);
  if LPrimaryKey = nil then
    Exit;
  FOrmDataSet.DisableControls;
  DisableDataSetEvents;
  LParams := TParams.Create(nil);
  try
    for LFor := 0 to LPrimaryKey.Columns.Count -1 do
    begin
      with LParams.Add as TParam do
      begin
        Name := LPrimaryKey.Columns.Items[LFor];
        ParamType := ptInput;
        DataType := FOrmDataSet.FieldByName(LPrimaryKey.Columns.Items[LFor]).DataType;
        Value := FOrmDataSet.FieldByName(LPrimaryKey.Columns.Items[LFor]).Value;
      end;
    end;
    if LParams.Count > 0 then
      FSession.RefreshRecord(LParams);
  finally
    LParams.Clear;
    LParams.Free;
    FOrmDataSet.EnableControls;
    EnableDataSetEvents;
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.RefreshRecordInternal(const AObject: TObject);
begin

end;

procedure TGOXManagerDataSetAdapterBase<M>.SetAutoIncValueChilds;
var
  LAssociation: TAssociationMapping;
  LAssociations: TAssociationMappingList;
  LDataSetChild: TGOXManagerDataSetAdapterBase<M>;
  LFor: Integer;
begin
  // Association
  LAssociations := TMappingExplorer.GetMappingAssociation(FCurrentInternal.ClassType);
  if LAssociations = nil then
    Exit;
  for LAssociation in LAssociations do
  begin
    if not (CascadeAutoInc in LAssociation.CascadeActions) then
      Continue;
    LDataSetChild := FMasterObject.Items[LAssociation.ClassNameRef];
    if LDataSetChild <> nil then
    begin
      for LFor := 0 to LAssociation.ColumnsName.Count -1 do
      begin
        if LDataSetChild.FOrmDataSet
                        .FindField(LAssociation.ColumnsNameRef[LFor]) = nil then
          Continue;
        LDataSetChild.FOrmDataSet.DisableControls;
        LDataSetChild.FOrmDataSet.First;
        try
          while not LDataSetChild.FOrmDataSet.Eof do
          begin
            LDataSetChild.FOrmDataSet.Edit;
            LDataSetChild.FOrmDataSet
                         .FieldByName(LAssociation.ColumnsNameRef[LFor]).Value
              := FOrmDataSet.FieldByName(LAssociation.ColumnsName[LFor]).Value;
            LDataSetChild.FOrmDataSet.Post;
            LDataSetChild.FOrmDataSet.Next;
          end;
        finally
          LDataSetChild.FOrmDataSet.First;
          LDataSetChild.FOrmDataSet.EnableControls;
        end;
      end;
    end;
    // Populando em hierarquia de vários níveis
    if LDataSetChild.FMasterObject.Count > 0 then
      LDataSetChild.SetAutoIncValueChilds;
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.SetAutoNextPacket(const Value: Boolean);
begin
  FAutoNextPacket := Value;
end;

procedure TGOXManagerDataSetAdapterBase<M>.SetDataSetEvents;
begin
  FOrmDataSet.BeforeScroll := DoBeforeScroll;
  FOrmDataSet.AfterScroll  := DoAfterScroll;
  FOrmDataSet.BeforeClose  := DoBeforeClose;
  FOrmDataSet.BeforeOpen   := DoBeforeOpen;
  FOrmDataSet.AfterOpen    := DoAfterOpen;
  FOrmDataSet.AfterClose   := DoAfterClose;
  FOrmDataSet.BeforeDelete := DoBeforeDelete;
  FOrmDataSet.AfterDelete  := DoAfterDelete;
  FOrmDataSet.BeforeInsert := DoBeforeInsert;
  FOrmDataSet.AfterInsert  := DoAfterInsert;
  FOrmDataSet.BeforeEdit   := DoBeforeEdit;
  FOrmDataSet.AfterEdit    := DoAfterEdit;
  FOrmDataSet.BeforePost   := DoBeforePost;
  FOrmDataSet.AfterPost    := DoAfterPost;
  FOrmDataSet.OnNewRecord  := DoNewRecord;
end;

procedure TGOXManagerDataSetAdapterBase<M>.GetMasterValues;
var
  LAssociation: TAssociationMapping;
  LAssociations: TAssociationMappingList;
  LDataSetMaster: TGOXManagerDataSetAdapterBase<M>;
  LField: TField;
  LFor: Integer;
begin
  if not Assigned(FOwnerMasterObject) then
    Exit;
  LDataSetMaster := TGOXManagerDataSetAdapterBase<M>(FOwnerMasterObject);
  LAssociations := TMappingExplorer.GetMappingAssociation(LDataSetMaster.FCurrentInternal.ClassType);
  if LAssociations = nil then
    Exit;
  for LAssociation in LAssociations do
  begin
    if not (CascadeAutoInc in LAssociation.CascadeActions) then
      Continue;
    for LFor := 0 to LAssociation.ColumnsName.Count -1 do
    begin
      LField := LDataSetMaster
                  .FOrmDataSet.FindField(LAssociation.ColumnsName.Items[LFor]);
      if LField = nil then
        Continue;
      FOrmDataSet
        .FieldByName(LAssociation.ColumnsNameRef.Items[LFor]).Value := LField.Value;
    end;
  end;
end;

procedure TGOXManagerDataSetAdapterBase<M>.SetMasterObject(const AValue: TObject);
var
  LOwnerObject: TGOXManagerDataSetAdapterBase<M>;
begin
  if FOwnerMasterObject = AValue then
    Exit;
  if FOwnerMasterObject <> nil then
  begin
    LOwnerObject := TGOXManagerDataSetAdapterBase<M>(FOwnerMasterObject);
    if LOwnerObject.FMasterObject.ContainsKey(FCurrentInternal.ClassName) then
    begin
      LOwnerObject.FMasterObject.Remove(FCurrentInternal.ClassName);
      LOwnerObject.FMasterObject.TrimExcess;
    end;
  end;
  if AValue <> nil then
    TGOXManagerDataSetAdapterBase<M>(AValue).FMasterObject.Add(FCurrentInternal.ClassName, Self);

  FOwnerMasterObject := AValue;
end;

procedure TGOXManagerDataSetAdapterBase<M>.ValideFieldEvents(const AFieldEvents: TFieldEventsMappingList);
var
  LFor: Integer;
  LField: TField;
begin
  for LFor := 0 to AFieldEvents.Count -1 do
  begin
    LField := FOrmDataSet.FindField(AFieldEvents.Items[LFor].FieldName);
    if LField = nil then
      Continue;

    if onSetText in AFieldEvents.Items[LFor].Events then
      if not Assigned(LField.OnSetText) then
        raise Exception.CreateFmt(cFIELDEVENTS, ['OnSetText()', LField.FieldName]);

    if onGetText in AFieldEvents.Items[LFor].Events then
      if not Assigned(LField.OnGetText) then
        raise Exception.CreateFmt(cFIELDEVENTS, ['OnGetText()', LField.FieldName]);

    if onChange in AFieldEvents.Items[LFor].Events then
      if not Assigned(LField.OnChange) then
        raise Exception.CreateFmt(cFIELDEVENTS, ['OnChange()', LField.FieldName]);

    if onValidate in AFieldEvents.Items[LFor].Events then
      if not Assigned(LField.OnValidate) then
        raise Exception.CreateFmt(cFIELDEVENTS, ['OnValidate()', LField.FieldName]);
  end;
end;

function TGOXManagerDataSetAdapterBase<M>.Find(const APK: String): M;
begin
  Result := FSession.Find(APK);
end;

function TGOXManagerDataSetAdapterBase<M>.FindWhere(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer): TObjectList<M>;
begin
  Result := FSession.FindWhere(AWhere,AOrderBy, APageNumber,ARowsByPage);
end;

end.
