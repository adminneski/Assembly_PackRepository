
{******************************************}
{                                          }
{             FastReport VCL               }
{      Custom TDataSet-based classes       }
{        for enduser DB components         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxCustomDB;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows,{$ENDIF} Classes, SysUtils, DB, frxClass, frxDBSet, DBCtrls
{$IFDEF DELPHI6}
, Variants
{$ENDIF}
{$IFNDEF WITHOUTQBUILDER}
, fqbClass
{$ENDIF}
{$IFDEF FR_COM}
, FastReport_TLB
{$ENDIF};


type
  /// <summary>
  ///   The TfrxCustomDataset class is the base class for DB engine components
  ///   such as TfrxBDETable, based on TDataSet.
  /// </summary>
  TfrxCustomDataset = class(TfrxDBDataSet)
  private
    FDBConnected: Boolean;
    FDataSource: TDataSource;
    FMaster: TfrxDBDataSet;
    FMasterFields: String;
    procedure SetActive(Value: Boolean);
    procedure SetFilter(const Value: String);
    procedure SetFiltered(Value: Boolean);
    function GetActive: Boolean;
    function GetFields: TFields;
    function GetFilter: String;
    function GetFiltered: Boolean;
    procedure InternalSetMaster(const Value: TfrxDBDataSet);
    procedure InternalSetMasterFields(const Value: String);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure SetUserName(const Value: String); override;
    procedure SetMaster(const Value: TDataSource); virtual;
    procedure SetMasterFields(const Value: String); virtual;
    property DataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OnPaste; override;
    /// <summary>
    ///   Determines whether the dataset is connected to a Database component.
    /// </summary>
    property DBConnected: Boolean read FDBConnected write FDBConnected;
    /// <summary>
    ///   Reference to internal TDataSet.Fields.
    /// </summary>
    property Fields: TFields read GetFields;
    /// <summary>
    ///   List of linked fields (used for master-detail relationship). List has
    ///   a form: DetailField=MasterField;...
    /// </summary>
    property MasterFields: String read FMasterFields write InternalSetMasterFields;
    /// <summary>
    ///   Determines whether the dataset is active.
    /// </summary>
    property Active: Boolean read GetActive write SetActive default False;
  published
    /// <summary>
    ///   The expression used for filtering records in a dataset. It is
    ///   equivalent to TDataSet.Filter.
    /// </summary>
    property Filter: String read GetFilter write SetFilter;
    /// <summary>
    ///   Determines whether to filter dataset records. It is equivalent to
    ///   TDataSet.Filtered.
    /// </summary>
    property Filtered: Boolean read GetFiltered write SetFiltered default False;
    /// <summary>
    ///   Reference to master dataset (used for master-detail relationships).
    ///   You also should set up the MasterFields property.
    /// </summary>
    property Master: TfrxDBDataset read FMaster write InternalSetMaster;
  end;

  /// <summary>
  ///   The TfrxCustomTable is a base class for table components of a DB
  ///   engine.
  /// </summary>
  TfrxCustomTable = class(TfrxCustomDataset)
  protected
    function GetIndexFieldNames: String; virtual;
    function GetIndexName: String; virtual;
    function GetTableName: String; virtual;
    procedure SetIndexFieldNames(const Value: String); virtual;
    procedure SetIndexName(const Value: String); virtual;
    procedure SetTableName(const Value: String); virtual;
    property DataSet;
  published
    property MasterFields;
    /// <summary>
    ///   The table name.
    /// </summary>
    property TableName: String read GetTableName write SetTableName;
    /// <summary>
    ///   The index name, used for sorting data records.
    /// </summary>
    property IndexName: String read GetIndexName write SetIndexName;
    /// <summary>
    ///   Use IndexFieldNames as an alternative method of specifying the index
    ///   to use for a table. In IndexFieldNames, specify the name of each
    ///   column to use as an index for a table. Ordering of column names is
    ///   significant. Separate names with semicolon.
    /// </summary>
    property IndexFieldNames: String read GetIndexFieldNames write SetIndexFieldNames;
  end;

{$IFDEF FR_COM}
  TfrxParamItem = class(TCollectionItem, IUnknown, IfrxParamItem)
  private
    FRefCount: Integer;
{$ELSE}
  /// <summary>
  ///   The TfrxParamItem represents one query parameter.
  /// </summary>
  TfrxParamItem = class(TCollectionItem)
  private
{$ENDIF}
    FDataType: TFieldType;
    FExpression: String;
    FName: String;
    FValue: Variant;
{$IFDEF FR_COM}
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IfrxParamItem }
    function Get_Name(out Value: WideString): HResult; stdcall;
    function Set_Name(const Value: WideString): HResult; stdcall;
    function Get_Value(out Value: OleVariant): HResult; stdcall;
    function Set_Value(Value: OleVariant): HResult; stdcall;
    function Get_Expression(out Value: WideString): HResult; stdcall;
    function Set_Expression(const Value: WideString): HResult; stdcall;
    function Get_FieldType(out Value: frxFieldType): HResult; stdcall;
    function Set_FieldType(Value: frxFieldType): HResult; stdcall;
{$ENDIF}
  public
    procedure Assign(Source: TPersistent); override;
    /// <summary>
    ///   Value of the parameter. This property is used if Expression property
    ///   is empty.
    /// </summary>
    property Value: Variant read FValue write FValue;
  published
    /// <summary>
    ///   Name of parameter. Don't change this property directly, because the
    ///   list of parameters rebuilds automatically when changing SQL query.
    /// </summary>
    property Name: String read FName write FName;
    /// <summary>
    ///   Type of the parameter.
    /// </summary>
    property DataType: TFieldType read FDataType write FDataType;
    /// <summary>
    ///   Value of the parameter - expression that will be calculated when
    ///   opening a query.
    /// </summary>
    property Expression: String read FExpression write FExpression;
  end;

  /// <summary>
  ///   The TfrxParams represents a list of query parameters.
  /// </summary>
  TfrxParams = class(TCollection)
  private
    FIgnoreDuplicates: Boolean;
    function GetParam(Index: Integer): TfrxParamItem;
  public
    constructor Create;
    /// <summary>
    ///   Adds a parameter. Don't use this method directly, because the list of
    ///   parameters rebuilds automatically when changing SQL query.
    /// </summary>
    function Add: TfrxParamItem;
    /// <summary>
    ///   Finds a parameter with specified name.
    /// </summary>
    function Find(const Name: String): TfrxParamItem;
    /// <summary>
    ///   Returns index of a parameter with specified name, or -1 if such
    ///   parameter not exists.
    /// </summary>
    function IndexOf(const Name: String): Integer;
    procedure UpdateParams(const SQL: String);
    /// <summary>
    ///   List of parameters.
    /// </summary>
    property Items[Index: Integer]: TfrxParamItem read GetParam; default;
    /// <summary>
    ///   If a property set to True, then parameters with similar names are
    ///   ignored.
    /// </summary>
    property IgnoreDuplicates: Boolean read FIgnoreDuplicates write FIgnoreDuplicates;
  end;

{$IFDEF FR_COM}
  TfrxCustomQuery = class(TfrxCustomDataset, IfrxCustomQuery)
{$ELSE}
  /// <summary>
  ///   The TfrxCustomQuery class is the base class for query components of the
  ///   DB engine.
  /// </summary>
  TfrxCustomQuery = class(TfrxCustomDataset)
{$ENDIF}
  private
    FParams: TfrxParams;
    FSaveOnBeforeOpen: TDataSetNotifyEvent;
    FSaveOnChange: TNotifyEvent;
    FSQLSchema: String;
    procedure ReadData(Reader: TReader);
    procedure SetParams(Value: TfrxParams);
    procedure WriteData(Writer: TWriter);
    function GetIgnoreDupParams: Boolean;
    procedure SetIgnoreDupParams(const Value: Boolean);
  protected
    FSaveOnBeforeRefresh: TDataSetNotifyEvent;
    procedure DefineProperties(Filer: TFiler); override;
    procedure OnBeforeOpen(DataSet: TDataSet); virtual;
    procedure OnBeforeRefresh(DataSet: TDataSet); virtual;
    procedure OnChangeSQL(Sender: TObject); virtual;
    procedure SetSQL(Value: TStrings); virtual;
    function GetSQL: TStrings; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateParams; virtual;
    /// <summary>
    ///   Finds a parameter with specified name.
    /// </summary>
    function ParamByName(const Value: String): TfrxParamItem;
{$IFNDEF WITHOUTQBUILDER}
    function QBEngine: TfqbEngine; virtual;
{$ENDIF}
{$IFDEF FR_COM}
    function Get_SQL(out Value: WideString): HResult; stdcall;
    function Set_SQL(const Value: WideString): HResult; stdcall;
    function Get_SQLSchema(out Value: WideString): HResult; stdcall;
    function Set_SQLSchema(const Value: WideString): HResult; stdcall;
{$ENDIF}
  published
    /// <summary>
    ///   If a property set to True, then parameters with similar names are
    ///   ignored.
    /// </summary>
    property IgnoreDupParams: Boolean read GetIgnoreDupParams write SetIgnoreDupParams;
    /// <summary>
    ///   List of query parameters. List of parameters rebuilds automatically
    ///   when changing SQL query.
    /// </summary>
    property Params: TfrxParams read FParams write SetParams;
    /// <summary>
    ///   Text of SQL query.
    /// </summary>
    property SQL: TStrings read GetSQL write SetSQL;
    /// <summary>
    ///   The SQL schema used in the FastQueryBuilder.
    /// </summary>
    property SQLSchema: String read FSQLSchema write FSQLSchema;
  end;

  /// <summary>
  ///   The TfrxDBLookupComboBox control represents TDBLookupComboBox control
  ///   adapter.
  /// </summary>
  TfrxDBLookupComboBox = class(TfrxDialogControl)
  private
    FDataSet: TfrxDBDataSet;
    FDataSetName: String;
    FDataSource: TDataSource;
    FDBLookupComboBox: TDBLookupComboBox;
    FAutoOpenDataSet: Boolean;

    function GetDataSetName: String;
    function GetKeyField: String;
    function GetKeyValue: Variant;
    function GetListField: String;
    function GetText: String;
    procedure SetDataSet(const Value: TfrxDBDataSet);
    procedure SetDataSetName(const Value: String);
    procedure SetKeyField(Value: String);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListField(Value: String);
    procedure UpdateDataSet;
    procedure OnOpenDS(Sender: TObject);
    function GetDropDownWidth: Integer;
    procedure SetDropDownWidth(const Value: Integer);
    function GetDropDownRows: Integer;
    procedure SetDropDownRows(const Value: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    /// <summary>
    ///   Reference to internal TDBLookupComboBox object.
    /// </summary>
    property DBLookupComboBox: TDBLookupComboBox read FDBLookupComboBox;
    /// <summary>
    ///   Value of key field that was selected in the control.
    /// </summary>
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    /// <summary>
    ///   Value of list field that was selected in the control.
    /// </summary>
    property Text: String read GetText;
  published
    /// <summary>
    ///   If a property is set to True , then during execution FastReport will
    ///   try to open the attached data source.
    /// </summary>
    property AutoOpenDataSet: Boolean read FAutoOpenDataSet write FAutoOpenDataSet default False;
    /// <summary>
    ///   Dataset which the control is connected to.
    /// </summary>
    property DataSet: TfrxDBDataset read FDataSet write SetDataSet;
    /// <summary>
    ///   Name of dataset, which the control is connected to. This property
    ///   duplicates the DataSet property.
    /// </summary>
    property DataSetName: String read GetDataSetName write SetDataSetName;
    /// <summary>
    ///   Name of DB field that will be shown in the control.
    /// </summary>
    property ListField: String read GetListField write SetListField;
    /// <summary>
    ///   Name of DB field that will represent the key field.
    /// </summary>
    property KeyField: String read GetKeyField write SetKeyField;
    property DropDownWidth: Integer read GetDropDownWidth write SetDropDownWidth;
    property DropDownRows: Integer read GetDropDownRows write SetDropDownRows;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;


procedure frxParamsToTParams(Query: TfrxCustomQuery; Params: TParams);


implementation

uses
{$IFNDEF NO_EDITORS}
  frxCustomDBEditor,
{$ENDIF}
  frxCustomDBRTTI, frxDsgnIntf, frxUtils, frxRes;


{ TfrxParamItem }

procedure TfrxParamItem.Assign(Source: TPersistent);
begin
  if Source is TfrxParamItem then
  begin
    FName := TfrxParamItem(Source).Name;
    FDataType := TfrxParamItem(Source).DataType;
    FExpression := TfrxParamItem(Source).Expression;
    FValue := TfrxParamItem(Source).Value;
  end;
end;

{$IFDEF FR_COM}
function TfrxParamItem.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TfrxParamItem._AddRef: Integer; stdcall;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TfrxParamItem._Release: Integer; stdcall;
begin
  Result := InterlockedDecrement(FRefCount);
//  if Result = 0 then Destroy;
end;

function TfrxParamItem.Get_Name(out Value: WideString): HResult; stdcall;
begin
  Value := Name;
  Result := S_OK;
end;

function TfrxParamItem.Set_Name(const Value: WideString): HResult; stdcall;
begin
  Name := Value;
  Result := S_OK;
end;

function TfrxParamItem.Get_Value(out Value: OleVariant): HResult; stdcall;
begin
  Value := Self.Value;
  Result := S_OK;
end;

function TfrxParamItem.Set_Value(Value: OleVariant): HResult; stdcall;
begin
  Self.Value := Value;
  Result := S_OK;
end;

function TfrxParamItem.Get_Expression(out Value: WideString): HResult; stdcall;
begin
  Value := Expression;
  Result := S_OK;
end;

function TfrxParamItem.Set_Expression(const Value: WideString): HResult; stdcall;
begin
  Expression := Value;
  Result := S_OK;
end;

function TfrxParamItem.Get_FieldType(out Value: frxFieldType): HResult; stdcall;
begin
  Value := OleVariant(DataType);
  Result := S_OK;
end;

function TfrxParamItem.Set_FieldType(Value: frxFieldType): HResult; stdcall;
begin
  DataType := TFieldType(Value);
  Result := S_OK;
end;
{$ENDIF}

{ TfrxParams }

constructor TfrxParams.Create;
begin
  inherited Create(TfrxParamItem);
  FIgnoreDuplicates := False;
end;

function TfrxParams.Add: TfrxParamItem;
begin
  Result := TfrxParamItem(inherited Add);
end;

function TfrxParams.GetParam(Index: Integer): TfrxParamItem;
begin
  Result := TfrxParamItem(inherited Items[Index]);
end;

function TfrxParams.Find(const Name: String): TfrxParamItem;
var
  i: Integer;
begin
  i := IndexOf(Name);
  if i <> -1 then
    Result := Items[i] else
    Result := nil;
end;

function TfrxParams.IndexOf(const Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if CompareText(Items[i].Name, Name) = 0 then
    begin
      Result := i;
      break;
    end;
end;

procedure TfrxParams.UpdateParams(const SQL: String);
var
  i, j: Integer;
  QParams: TParams;
  NewParams: TfrxParams;
begin
  { parse query params }
  QParams := TParams.Create;
  QParams.ParseSQL(SQL, True);

  { create new TfrxParams object and copy all params to it }
  NewParams := TfrxParams.Create;
  for i := 0 to QParams.Count - 1 do
    if not ((NewParams.IndexOf(QParams[i].Name) <> -1) and FIgnoreDuplicates)  then
      with NewParams.Add do
      begin
        Name := QParams[i].Name;
        j := IndexOf(Name);
        if j <> -1 then
        begin
          DataType := Items[j].DataType;
          Value := Items[j].Value;
          Expression := Items[j].Expression;
        end;
      end;
  Assign(NewParams);
  QParams.Free;
  NewParams.Free;
end;

{ TfrxCustomDataset }

constructor TfrxCustomDataset.Create(AOwner: TComponent);
begin
  Component := Dataset;
  inherited;
  CloseDataSource := True;
  FDataSource := TDataSource.Create(nil);
  SetMaster(FDataSource);
end;

destructor TfrxCustomDataset.Destroy;
begin
  FDataSource.Free;
  inherited;
end;

procedure TfrxCustomDataset.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = FMaster then
      Master := nil
end;

procedure TfrxCustomDataset.SetParent(AParent: TfrxComponent);
begin
  inherited;
  if (AParent <> nil) and (Report <> nil) then
  begin
    if IsDesigning and (Report.DataSets.Find(Self) = nil) then
    begin
      Report.DataSets.Add(Self);
      if Report.Designer <> nil then
        Report.Designer.UpdateDataTree;
    end;
  end;
end;

procedure TfrxCustomDataset.SetUserName(const Value: String);
begin
  inherited;
  if (Report <> nil) and (Report.Designer <> nil) then
    Report.Designer.UpdateDataTree;
end;

procedure TfrxCustomDataset.OnPaste;
var
  i: Integer;
  sl: TStringList;
begin
  if Report = nil then Exit;
  
  if Report.DataSets.Find(Self) = nil then
    Report.DataSets.Add(Self);

  sl := TStringList.Create;

  Report.GetDatasetList(sl);
  for i := 0 to sl.Count - 1 do
    if (sl.Objects[i] <> Self) and (CompareText(sl[i], UserName) = 0) then
    begin
      if Name <> '' then
        UserName := Name;
      break;
    end;
  sl.Free;

  Report.Designer.UpdateDataTree;
end;

procedure TfrxCustomDataset.SetActive(Value: Boolean);
begin
  Dataset.Active := Value;
end;

procedure TfrxCustomDataset.SetFilter(const Value: String);
begin
  Dataset.Filter := Value;
end;

function TfrxCustomDataset.GetActive: Boolean;
begin
  Result := Dataset.Active;
end;

function TfrxCustomDataset.GetFields: TFields;
begin
  Result := Dataset.Fields;
end;

function TfrxCustomDataset.GetFilter: String;
begin
  Result := Dataset.Filter;
end;

function TfrxCustomDataset.GetFiltered: Boolean;
begin
  Result := Dataset.Filtered;
end;

procedure TfrxCustomDataset.SetFiltered(Value: Boolean);
begin
  Dataset.Filtered := Value;
end;

procedure TfrxCustomDataset.InternalSetMaster(const Value: TfrxDBDataSet);
begin
  FMaster := Value;
  if FMaster <> nil then
    FDataSource.DataSet := FMaster.GetDataSet
  else
    FDataSource.DataSet := nil;
end;

procedure TfrxCustomDataset.InternalSetMasterFields(const Value: String);
var
  sl: TStringList;
  s: String;
  i: Integer;

  function ConvertAlias(const s: String): String;
  begin
    if FMaster <> nil then
      Result := FMaster.ConvertAlias(s)
    else
      Result := s;
  end;

begin
  FMasterFields := Value;

  sl := TStringList.Create;
  frxSetCommaText(Value, sl);
  s := '';
  for i := 0 to sl.Count - 1 do
    s := s + ConvertAlias(sl.Values[sl.Names[i]]) + ';';
  s := Copy(s, 1, Length(s) - 1);

  SetMasterFields(s);

  s := '';
  for i := 0 to sl.Count - 1 do
    s := s + ConvertAlias(sl.Names[i]) + ';';
  s := Copy(s, 1, Length(s) - 1);

  if Self is TfrxCustomTable then
    TfrxCustomTable(Self).SetIndexFieldNames(s);

  sl.Free;
end;

procedure TfrxCustomDataset.SetMaster(const Value: TDataSource);
begin
// do nothing
end;

procedure TfrxCustomDataset.SetMasterFields(const Value: String);
begin
// do nothing
end;


{ TfrxCustomTable }

function TfrxCustomTable.GetIndexFieldNames: String;
begin
  Result := '';
end;

function TfrxCustomTable.GetIndexName: String;
begin
  Result := '';
end;

function TfrxCustomTable.GetTableName: String;
begin
  Result := '';
end;

procedure TfrxCustomTable.SetIndexFieldNames(const Value: String);
begin
// do nothing
end;

procedure TfrxCustomTable.SetIndexName(const Value: String);
begin
// do nothing
end;

procedure TfrxCustomTable.SetTableName(const Value: String);
begin
// do nothing
end;


{ TfrxCustomQuery }

constructor TfrxCustomQuery.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TfrxParams.Create;
  if DataSet <> nil then
  begin
    FSaveOnBeforeOpen := DataSet.BeforeOpen;
    DataSet.BeforeOpen := OnBeforeOpen;
  end;
  if SQL <> nil then
  begin
    FSaveOnChange := TStringList(SQL).OnChange;
    TStringList(SQL).OnChange := OnChangeSQL;
  end;
end;

destructor TfrxCustomQuery.Destroy;
begin
  FParams.Free;
  inherited;
end;

procedure TfrxCustomQuery.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Parameters', ReadData, WriteData, True);
end;

procedure TfrxCustomQuery.ReadData(Reader: TReader);
begin
  frxReadCollection(FParams, Reader, Self);
  UpdateParams;
end;

procedure TfrxCustomQuery.WriteData(Writer: TWriter);
begin
  frxWriteCollection(FParams, Writer, Self);
end;

procedure TfrxCustomQuery.OnBeforeOpen(DataSet: TDataSet);
begin
  UpdateParams;
  if Assigned(FSaveOnBeforeOpen) then
    FSaveOnBeforeOpen(DataSet);
end;

procedure TfrxCustomQuery.OnBeforeRefresh(DataSet: TDataSet);
begin
  UpdateParams;
  if Assigned(FSaveOnBeforeRefresh) then
    FSaveOnBeforeRefresh(DataSet);
end;

procedure TfrxCustomQuery.OnChangeSQL(Sender: TObject);
begin
  if Assigned(FSaveOnChange) then
    FSaveOnChange(Sender);
  FParams.UpdateParams(SQL.Text);
end;

procedure TfrxCustomQuery.SetParams(Value: TfrxParams);
begin
  FParams.Assign(Value);
end;

function TfrxCustomQuery.ParamByName(const Value: String): TfrxParamItem;
begin
  Result := FParams.Find(Value);
  if Result = nil then
    raise Exception.Create('Parameter "' + Value + '" not found'); 
end;

procedure TfrxCustomQuery.SetSQL(Value: TStrings);
begin
//
end;

function TfrxCustomQuery.GetSQL: TStrings;
begin
  Result := nil;
end;

procedure TfrxCustomQuery.UpdateParams;
begin
//
end;

{$IFNDEF WITHOUTQBUILDER}
function TfrxCustomQuery.QBEngine: TfqbEngine;
begin
  Result := nil;
end;
{$ENDIF}

{$IFDEF FR_COM}
//{$IFNDEF WITHOUTQBUILDER}
function TfrxCustomQuery.Get_SQL(out Value: WideString): HResult; stdcall;
begin
  Value := SQL.GetText;
  Result := S_OK;
end;

function TfrxCustomQuery.Set_SQL(const Value: WideString): HResult; stdcall;
begin
  SQL.SetText( PChar(Value) );
  Result := S_OK;
end;

function TfrxCustomQuery.Get_SQLSchema(out Value: WideString): HResult; stdcall;
begin
  Value := SQLSchema;
  Result := S_OK;
end;

function TfrxCustomQuery.Set_SQLSchema(const Value: WideString): HResult; stdcall;
begin
  SQLSchema := Value;
  Result := S_OK;
end;
//{$ENDIF}
{$ENDIF}

{ frxParamsToTParams }

procedure frxParamsToTParams(Query: TfrxCustomQuery; Params: TParams);
var
  i: Integer;
  Item: TfrxParamItem;
begin
  for i := 0 to Params.Count - 1 do
    if Query.Params.IndexOf(Params[i].Name) <> -1 then
    begin
      Item := Query.Params[Query.Params.IndexOf(Params[i].Name)];
      Params[i].Clear;
      Params[i].DataType := Item.DataType;
      { Bound should be True in design mode }
      if not (Query.IsLoading or Query.IsDesigning) then
        Params[i].Bound := False
      else
      begin
        if Item.Expression <> '' then
          Params[i].Value := 0;
        Params[i].Bound := True;
      end;

      if Trim(Item.Expression) <> '' then
        if not (Query.IsLoading or Query.IsDesigning) then
          if Query.Report <> nil then
          begin
            Query.Report.CurObject := Query.Name;
            Item.Value := Query.Report.Calc(Item.Expression);
          end;
      if not VarIsEmpty(Item.Value) then
      begin
        Params[i].Bound := True;
        if Params[i].DataType in [ftDate, ftTime, ftDateTime] then
          Params[i].Value := Item.Value
        else
          Params[i].Text := VarToStr(Item.Value);
      end;

    end;
end;

function TfrxCustomQuery.GetIgnoreDupParams: Boolean;
begin
  Result := FParams.FIgnoreDuplicates;
end;

procedure TfrxCustomQuery.SetIgnoreDupParams(const Value: Boolean);
begin
  FParams.FIgnoreDuplicates := Value;
  FParams.UpdateParams(SQL.Text);
end;

{ TfrxDBLookupComboBox }

constructor TfrxDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FDBLookupComboBox := TDBLookupComboBox.Create(nil);
  InitControl(FDBLookupComboBox);
  Width := 145;
  Height := 21;
  FDataSource := TDataSource.Create(nil);
  FDBLookupComboBox.ListSource := FDataSource;
end;

destructor TfrxDBLookupComboBox.Destroy;
begin
  FDataSource.Free;
  inherited;
end;

class function TfrxDBLookupComboBox.GetDescription: String;
begin
  Result := frxResources.Get('obDBLookup');
end;

function TfrxDBLookupComboBox.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

function TfrxDBLookupComboBox.GetKeyField: String;
begin
  Result := FDBLookupComboBox.KeyField;
  if FDataSet <> nil then
    Result := FDataSet.GetAlias(Result);
end;

function TfrxDBLookupComboBox.GetKeyValue: Variant;
begin
  Result := FDBLookupComboBox.KeyValue;
end;

function TfrxDBLookupComboBox.GetListField: String;
begin
  Result := FDBLookupComboBox.ListField;
  FDataSet := TfrxDBDataSet(Report.GetDataset(FDataSetName));
  if FDataSet <> nil then
    Result := FDataSet.GetAlias(Result);
end;

function TfrxDBLookupComboBox.GetText: String;
begin
  Result := FDBLookupComboBox.Text;
end;

procedure TfrxDBLookupComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDataSet) then
    FDataSet := nil;
end;

procedure TfrxDBLookupComboBox.SetDataSet(const Value: TfrxDBDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
  UpdateDataSet;
end;

procedure TfrxDBLookupComboBox.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  FDataSet := TfrxDBDataSet(FindDataSet(FDataSet, FDataSetName));
  UpdateDataSet;
end;

procedure TfrxDBLookupComboBox.SetKeyField(Value: String);
begin
  if FDataSet <> nil then
    Value := FDataSet.ConvertAlias(Value);
  FDBLookupComboBox.KeyField := Value;
end;

procedure TfrxDBLookupComboBox.SetKeyValue(const Value: Variant);
begin
  FDBLookupComboBox.KeyValue := Value;
end;

procedure TfrxDBLookupComboBox.SetListField(Value: String);
begin
  if FDataSet <> nil then
    Value := FDataSet.ConvertAlias(Value);
  FDBLookupComboBox.ListField := Value;
end;

procedure TfrxDBLookupComboBox.UpdateDataSet;
begin
  if FDataSet <> nil then
    FDataSource.DataSet := FDataSet.GetDataSet else
    FDataSource.DataSet := nil;
end;

procedure TfrxDBLookupComboBox.BeforeStartReport;
begin
  SetListField(FDBLookupComboBox.ListField);
  SetKeyField(FDBLookupComboBox.KeyField);
  Self.OnActivate := OnOpenDS;
end;


procedure TfrxDBLookupComboBox.OnOpenDS(Sender: TObject);
begin
  UpdateDataSet;
  if (FDataSet <> nil) and (FAutoOpenDataSet) then
    FDataSet.Open;
end;

function TfrxDBLookupComboBox.GetDropDownWidth: Integer;
begin
  {$IFDEF FPC}
  {$warning LCL does not have DBLookupComboBox.DrowDownWidth svn r33860}
  Result := 0;
  {$ELSE}
  Result := FDBLookupComboBox.DropDownWidth;
  {$ENDIF}
end;

procedure TfrxDBLookupComboBox.SetDropDownWidth(const Value: Integer);
begin
  {$IFDEF FPC}
  {$warning LCL does not have DBLookupComboBox.DrowDownWidth svn r33860}
  {$ELSE}
  FDBLookupComboBox.DropDownWidth := Value;
  {$ENDIF}
end;

function TfrxDBLookupComboBox.GetDropDownRows: Integer;
begin
  {$IFDEF FPC}
  {$warning LCL does not have DBLookupComboBox.DrowDownRows svn r33860}
  Result := 0;
  {$ELSE}
  Result := FDBLookupComboBox.DropDownRows;
  {$ENDIF}
end;

procedure TfrxDBLookupComboBox.SetDropDownRows(const Value: Integer);
begin
  {$IFDEF FPC}
  {$warning LCL does not have DBLookupComboBox.DrowDownRows svn r33860}
  {$ELSE}
  FDBLookupComboBox.DropDownRows := Value;
  {$ENDIF}
end;

initialization
  frxObjects.RegisterObject1(TfrxDBLookupComboBox, nil, '', '', 0, 41);

finalization
  frxObjects.UnRegister(TfrxDBLookupComboBox);


end.
