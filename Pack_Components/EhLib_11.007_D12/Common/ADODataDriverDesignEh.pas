{*******************************************************}
{                                                       }
{                     EhLib 10.2                        }
{                                                       }
{                 TADODesignDataBaseEh                  }
{                                                       }
{     Copyright (c) 2004-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit ADODataDriverDesignEh;

{$I EHLIB.INC}

interface

{$IFDEF CIL}

{$R ADODataDriverEh.TADODataDriverEh.bmp}

{$ENDIF}

uses Windows, SysUtils, Classes, Controls, DB, Variants, Contnrs,
  EhLibVCL,
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, ADODB, Dialogs,
  SQLDriverEditEh, ADODataDriverEh, ComCtrls, MemTableEh, Forms,
  UpdateSQLEditEh;

type

{ TADODesignDataBaseEh }

  TADODesignDataBaseEh = class(TDesignDataBaseEh)
  private
    FTablesMT: TMemTableEh;
    FColumnsMT: TMemTableEh;
    FConnection: TADOConnection;
    FTreeNodeMan: TCustomDBService;
    FDBServiceClass: TCustomDBServiceClass;
    FSpecParamsServiceClass: TCustomDBServiceClass;
    FApplicationConnection: TADOConnection;
    procedure SetApplicationConnection(const Value: TADOConnection);

  protected
    function GetConnected: Boolean; override;
    procedure SetConnected(const Value: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(IsPublicDataBase: Boolean; AConProvider: TComponent); override;
    destructor Destroy; override;

    function BuildObjectTree(List: TObjectList): Boolean; override;
    function BuildOracleObjectTree(TreeView: TTreeView): Boolean;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function CanBuildTreeDataSet(var StrReasonOfInable: String): Boolean; override;
    function CanFormSpecParamsList(var StrReasonOfInable: String): Boolean; override;
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh; override;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
    function Description: String; override;
    function DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function GetConnection: TADOConnection;
    function GetConProvider: TADOConnectionProviderEh;
    function GetCustomDBService: TCustomDBService; override;
    function GetEngineName: String; override;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; override;
    function GetIADOConProvider: IADOConnectionProviderEh;
    function GetSpecParamsList: String; override;
    function ServerTypeName: String;
    function SupportCustomSQLDataDriver: Boolean; override;

    procedure EditDatabaseParams; override;
    procedure SetServerTypeAsServerSpecOperationsClass(const Value: TServerSpecOperationsEhClass); override;

    property DBServiceClass: TCustomDBServiceClass read FDBServiceClass;
    property ApplicationConnection: TADOConnection read FApplicationConnection write SetApplicationConnection;
  end;

{ TADOAccessEngineEh }

  TADOAccessEngineEh = class(TAccessEngineEh)
    function AccessEngineName: String; override;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh; DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh; override;
  end;

{ TADODesignDataBaseEh }

  TADOUniService = class(TCustomDBService)
  private
    FDesignDB: TDesignDataBaseEh;
    FSpecPraramsService: TCustomDBService;
    FNoAskForSpecPraramsService: Boolean;
  protected
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    destructor Destroy; override;

    class function GetDBServiceName: String; override;
    function GetSpecParamsList: String; override;
    function ShowPopup(Source: TObject; Coord: TPoint; Params: TServicePopupParams): Integer; override;

    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh; DesignUpdateInfo: TDesignUpdateInfoEh); override;
  end;

{ TADODataDriverEditInteractorEh }

  TADODataDriverEditInteractorEh = class(TDataDriverEditInteractorEh)
    class procedure AssignEditDataToCommant(SQLText: String; mtParams: TMemTableEh; Command: TCustomSQLCommandEh); override;
    class procedure AssignCommantToEditData(Command: TCustomSQLCommandEh; SQLText: String; mtParams: TMemTableEh); override;
    class procedure RefreshParams(Command: TCustomSQLCommandEh; SQLEditWin:TSQLDataEditWin); override;
    class procedure DesignDataBaseReassigned(SQLEditWin: TSQLDataEditWin); override;
  end;

{ TADOConnectionProviderDesignSerivceEh }

  TADOConnectionProviderDesignSerivceEh = class(TConnectionProviderDesignSerivceEh)
    function EditDesignData(ConnectionProvider: TConnectionProviderEh): Boolean; override;
    function CreateDesignDataBase(ConnectionProvider: TComponent): TComponent; override;
  end;

procedure UnregisterADOAccessEngines;
procedure RegisterADOAccessEngines;

procedure Register;

implementation

uses
{$IFDEF CIL}
  Borland.Vcl.Design.AdoConEd,
  Borland.Vcl.Design.AdoDBReg,
{$ELSE}
  AdoConEd,
{$ENDIF}
{$IFDEF DESIGNTIME}
	MemTableDesignEh, StorablePropsDesignIntfEh,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignEditors,
{$ELSE}
  DesignIntf,
  DesignEditors,
  DBReg,
  ADOReg,
{$ENDIF}
{$ENDIF}
  FormSelectFromList, DesignConnectionListEh, SelectFromListDialog,
  ADOConnectionProviderDesignEdit, ComObj, EhLibDesignAbout, EhLibReg;

(* how to get explain plan in  MSSQL
1. Use SET SHOWPLAN_TEXT { ON | OFF } or SET SHOWPLAN_ALL { ON | OFF } or analog
i.e. on the example add at the begining of SQL SET SHOWPLAN_ALL ON
at the end SET SHOWPLAN_ALL OFF.
Send to server and as aa result we will get result as we needed.
*)

function GetServerName(IBDatabase: TADOConnection; var ServerName: String): Boolean;
begin
  ServerName := 'MSACCESS';
  Result := True;
end;

function GUISelectADOAccessEngine(SelectDBService: TSelectDBService): Boolean;
var
  f: TfSelectFromList;
begin
  Result := False;
  f := TfSelectFromList.Create(Application);
  f.cbEngine.Items := AccessEngineList;
  f.cbEngine.ItemIndex := f.cbEngine.Items.IndexOf('ADO');
  f.cbEngine.Enabled := False;
  f.cbDBService.Items := GetDBServiceList;
  f.eDataBaseName.Text := SelectDBService.DBName;
  f.DBServiceEngineList := GetDBServiceEngineList;
  if f.ShowModal = mrOk then
  begin
    if f.cbEngine.ItemIndex >= 0
      then SelectDBService.AccessEngine := TAccessEngineEh(AccessEngineList.Objects[f.cbEngine.ItemIndex])
      else SelectDBService.AccessEngine := nil;
    if f.cbDBService.ItemIndex >= 0 then
      SelectDBService.DBServiceClass := TCustomDBServiceClass(f.cbDBService.Items.Objects[f.cbDBService.ItemIndex])
    else
      SelectDBService.DBServiceClass := nil;
    SelectDBService.DBName := f.eDataBaseName.Text;
    Result := True;
  end;
  f.Free;
end;

procedure SetDesignADODataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
var
  i: Integer;
  DesignDataBase: TComponent;
  sdb: TSelectDBService;
  ADODesignDataBase: TADODesignDataBaseEh;
begin
  if DataDriver.DesignDataBase = nil then
  begin
    for i := 0 to GetDesignDataBaseList.Count-1 do
    begin
      if TDesignDataBaseEh(GetDesignDataBaseList[i]).DesignDataBaseConnetionEqual(DataDriver) then
      begin
        DataDriver.DesignDataBase := TComponent(GetDesignDataBaseList[i]);
        Exit;
      end;
    end;


    if GetDesignDataBaseList.Count > 0 then
    begin
      DesignDataBase := SelectDesignConnectionListEh(DesignDataBaseList);
      if (DesignDataBase <> nil) and (DesignDataBase <> DataDriver.DesignDataBase) then
        DataDriver.DesignDataBase := DesignDataBase;
    end else
    begin
      sdb := TSelectDBService.Create;
      sdb.DBName := 'DesingConnection1';
      if GUISelectADOAccessEngine(sdb) and (sdb.AccessEngine <> nil) then
      begin
        if sdb.AccessEngine is TADOAccessEngineEh then
        begin
          ADODesignDataBase := TADODesignDataBaseEh.Create(True, nil);
          ADODesignDataBase.FDBServiceClass := sdb.DBServiceClass;
          ADODesignDataBase.DesignConnectionName := sdb.DBName;
          if (ADODesignDataBase is TADODesignDataBaseEh) and
              (DataDriver is TADODataDriverEh) and
              (TADODataDriverEh(DataDriver).ADOConnection <> nil)
          then
          begin
            ADODesignDataBase.FConnection.ConnectionString :=
              TADODataDriverEh(DataDriver).ADOConnection.ConnectionString;
            ADODesignDataBase.ApplicationConnection := TADODataDriverEh(DataDriver).ADOConnection;
          end;
          ADODesignDataBase.EditDatabaseParams;
          DataDriver.DesignDataBase := ADODesignDataBase;
        end else
          DataDriver.DesignDataBase :=
            sdb.AccessEngine.CreateDesignDataBase(DataDriver, sdb.DBServiceClass, sdb.DBName);
      end;
      sdb.Free;
    end;
  end;
end;

{ TADODesignDataBaseEh }

function TADODesignDataBaseEh.BuildObjectTree(List: TObjectList): Boolean;
var
  NList: TObjectList;
  i: Integer;
begin
  Result := False;
  if Assigned(FDBServiceClass) then
  begin
    if FTreeNodeMan <> nil then
      FTreeNodeMan.Free;
    FTreeNodeMan := FDBServiceClass.Create(Self);
    NList := FTreeNodeMan.CreateRootNodes;
    List.Clear;
    for I := 0 to NList.Count - 1 do
      List.Add(NList[I]);

    NList.Free;
    Result := True;
  end;
end;

function TADODesignDataBaseEh.CanBuildTreeDataSet(var StrReasonOfInable: String): Boolean;
begin
  Result := inherited CanBuildTreeDataSet(StrReasonOfInable);
  if not IsPublicDataBase and (FDBServiceClass = nil) then
  begin
    Result := False;
    StrReasonOfInable := 'Unable to build data tree. ConnectionProvider.ServerType is not assigned.'
  end;
end;

function TADODesignDataBaseEh.CanFormSpecParamsList(var StrReasonOfInable: String): Boolean;
begin
  Result := inherited CanBuildTreeDataSet(StrReasonOfInable);
  if not IsPublicDataBase and (FSpecParamsServiceClass = nil) then
  begin
    Result := False;
    StrReasonOfInable := 'Unable to form list of SpecParams. ConnectionProvider.ServerType is not assigned.'
  end;
end;

function TADODesignDataBaseEh.BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := EditDataDriverUpdateSQL(DataDriver as TCustomSQLDataDriverEh);
end;

constructor TADODesignDataBaseEh.Create(IsPublicDataBase: Boolean; AConProvider: TComponent);
begin
  inherited Create(IsPublicDataBase, AConProvider);
  if AConProvider = nil then
    FConnection := TADOConnection.Create(Application);
  FTablesMT := TMemTableEh.Create(nil);
  FColumnsMT := TMemTableEh.Create(nil);
end;

destructor TADODesignDataBaseEh.Destroy;
begin
  FreeAndNil(FTablesMT);
  FreeAndNil(FColumnsMT);
  FreeAndNil(FTreeNodeMan);
  inherited Destroy;
end;

function TADODesignDataBaseEh.CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := TADODataDriverEh.Create(nil);
  Result.SelectCommand := RTDataDriver.SelectCommand;
  Result.UpdateCommand := RTDataDriver.UpdateCommand;
  Result.InsertCommand := RTDataDriver.InsertCommand;
  Result.DeleteCommand := RTDataDriver.DeleteCommand;
  Result.GetrecCommand := RTDataDriver.GetrecCommand;
  TADODataDriverEh(Result).SpecParams := TADODataDriverEh(RTDataDriver).SpecParams;
  TADODataDriverEh(Result).ADOConnection := FConnection;
  TADODataDriverEh(Result).ConnectionProvider :=  TADODataDriverEh(RTDataDriver).ConnectionProvider;
end;

function TADODesignDataBaseEh.DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
  if DataDriver is TADODataDriverEh then
  begin
    if TADODataDriverEh(DataDriver).ADOConnection <> nil then
      Result := (ApplicationConnection = TADODataDriverEh(DataDriver).ADOConnection)
    else
      Result := (FConnection.ConnectionString = TADODataDriverEh(DataDriver).ConnectionString);
  end;  
end;

function TADODesignDataBaseEh.Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  cmd: TCustomSQLCommandEh;
  q: TADOQuery;
  t: TADOTable;
  sp: TADOStoredProc;
begin
  cmd := Command;
  Result := -1;
  FreeOnEof := True;
  case cmd.CommandType of
    cthSelectQuery, cthUpdateQuery:
      begin
        q := TADOQuery.Create(nil);
        q.Connection := GetConnection;
        q.SQL.Text := Command.FinalCommandText.Text;
        if Command is TADOCommandEh
          then q.Parameters := TADOCommandEh(Command).Parameters
          else q.Parameters.Assign(Command.GetParams);
        if cmd.CommandType = cthSelectQuery then
          q.Open
        else
        begin
          q.ExecSQL;
          Result := q.RowsAffected;
        end;
        Cursor := q;
      end;
    cthTable:
      begin
        t := TADOTable.Create(nil);
        t.Connection := GetConnection;
        t.TableName := Command.FinalCommandText.Text;
        t.Open;
        Cursor := t;
      end;
    cthStoredProc:
      begin
        sp := TADOStoredProc.Create(nil);
        sp.Connection := GetConnection;
        sp.ProcedureName := Command.FinalCommandText.Text;
        if Command is TADOCommandEh
          then sp.Parameters := TADOCommandEh(Command).Parameters
          else sp.Parameters.Assign(Command.GetParams);
        sp.ExecProc;
        Cursor := sp;
      end;
  end;
end;

function TADODesignDataBaseEh.GetConnection: TADOConnection;
begin
  Result := nil;
  if FConnection <> nil then
    Result := FConnection
  else if GetConProvider <> nil then
    if GetConProvider.InlineConnection.UseAtDesignTime then
      Result := GetConProvider.InlineConnection.Connection
    else
      Result := GetConProvider.Connection
  else if GetIADOConProvider <> nil then
    Result := GetIADOConProvider.GetConnection;
end;

function TADODesignDataBaseEh.ServerTypeName: String;
var
  Description: String;
begin
  if GetServerName(GetConnection, Description) then
  begin
    Result := UpperCase(Description);
  end;
end;

function TADODesignDataBaseEh.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Query: TADOQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
  Params: TParams;
begin
  Query := TADOQuery.Create(nil);
  Query.Connection := GetConnection;
  Query.SQL.Text := SQL;
  Params := TParams.Create;
  try
    if High(FParams) > Low(FParams) then
      for i := Low(FParams) to High(FParams) div 2 do
      begin
        dt := VarTypeToDataType(VarType(FParams[i*2+1]));
        if dt = ftUnknown then
          dt := ftString;
        p := Params.CreateParam(dt, FParams[i*2], ptInputOutput);
        p.Value := FParams[i*2+1];
      end;
    Query.Parameters.Assign(Params);
  finally
    Params.Free;
  end;
  try
    Query.Open;
  except
    Query.Free;
    raise;
  end;
  Result := Query;
end;

function TADODesignDataBaseEh.BuildOracleObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

procedure TADODesignDataBaseEh.EditDatabaseParams;
begin
  EditConnectionString(FConnection);
end;

function TADODesignDataBaseEh.GetEngineName: String;
begin
  Result := 'ADO';
end;

function TADODesignDataBaseEh.GetConnected: Boolean;
begin
  Result := (GetConnection <> nil) and GetConnection.Connected;
end;

procedure TADODesignDataBaseEh.SetConnected(const Value: Boolean);
begin
  if GetConnection <> nil then
    GetConnection.Connected := Value;
end;

function TADODesignDataBaseEh.SupportCustomSQLDataDriver: Boolean;
begin
  Result := True;
end;

function TADODesignDataBaseEh.GetFieldList(const TableName: string;
  DataSet: TDataSet): Boolean;
var
  table: TADOTable;
  list: TStrings;
  i: Integer;

  procedure GetDataFieldNames(Dataset: TDataset; ErrorName: string; List: TStrings);
  var
    I: Integer;
  begin
    try
      Dataset.FieldDefs.Update;
      List.BeginUpdate;
      try
        List.Clear;
        for I := 0 to Dataset.FieldDefs.Count - 1 do
          List.Add(Dataset.FieldDefs[I].Name);
      finally
        List.EndUpdate;
      end;
    except
      if ErrorName <> '' then
        MessageDlg(Format('SSQLDataSetOpen', [ErrorName]), mtError, [mbOK], 0);
    end;
  end;

  procedure SetKeyFields;
  var
    SepPos, I, Index: Integer;
    FName, FieldNames: string;
  begin
    table.IndexDefs.Update;
    for I := 0 to table.IndexDefs.Count - 1  do
      if ixPrimary in table.IndexDefs[I].Options then
      begin
        FieldNames := table.IndexDefs[I].Fields + ';';
        while Length(FieldNames) > 0 do
        begin
          SepPos := Pos(';', FieldNames);
          if SepPos < 1 then Break;
          FName := Copy(FieldNames, 1, SepPos - 1);
{$IFDEF CIL}
          Borland.Delphi.System.Delete(FieldNames, 1, SepPos);
{$ELSE}
          System.Delete(FieldNames, 1, SepPos);
{$ENDIF}
          Index := list.IndexOf(FName);
          if Index > -1 then list.Objects[Index] := TObject(1);
        end;
        break;
      end;
  end;

begin
  Result := False;
  table := TADOTable.Create(nil);
  try
  table.Connection := GetConnection;
  if table.Connection = nil then
  begin
    ShowMessage('DataBase is not Connected.');
    Exit;
  end;
  table.TableName := TableName;
  list := TStringList.Create;
  GetDataFieldNames(table, 'Error', list);
  SetKeyFields;
  for i := 0 to list.Count-1 do
  begin
    if list.Objects[i] = TObject(1)
      then DataSet.AppendRecord([list[i], True])
      else DataSet.AppendRecord([list[i], False]);
  end;
  list.Free;
  finally
    table.Free;
  end;  
  Result := True;
end;

function TADODesignDataBaseEh.GetSpecParamsList: String;
var
  FSpecParams: TCustomDBService;
begin
  if FSpecParamsServiceClass <> nil then
  begin
    FSpecParams := FSpecParamsServiceClass.Create(Self);
    Result := FSpecParams.GetSpecParamsList;
    FSpecParams.Free;
  end else if FTreeNodeMan <> nil then
  begin
    Result := FTreeNodeMan.GetSpecParamsList;
  end;
end;

function TADODesignDataBaseEh.GetCustomDBService: TCustomDBService;
begin
  Result := FTreeNodeMan;
end;

procedure TADODesignDataBaseEh.SetApplicationConnection(const Value: TADOConnection);
begin
  if FApplicationConnection <> Value then
  begin
    FApplicationConnection := Value;
    if FApplicationConnection <> nil then
      FApplicationConnection.FreeNotification(Self);
  end;
end;

procedure TADODesignDataBaseEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FApplicationConnection = AComponent)
  then
    FApplicationConnection := nil;
end;

procedure TADODesignDataBaseEh.SetServerTypeAsServerSpecOperationsClass(
  const Value: TServerSpecOperationsEhClass);
begin
  FSpecParamsServiceClass := GetDBServiceByServerSpecOperationsClass(Value);
  FDBServiceClass := TADOUniService;
end;

function TADODesignDataBaseEh.Description: String;
begin
  if GetConnection <> nil then
    Result := GetConnection.ConnectionString;
end;

function TADODesignDataBaseEh.GetConProvider: TADOConnectionProviderEh;
begin
  if FConProvider is TADOConnectionProviderEh
    then Result := TADOConnectionProviderEh(FConProvider)
    else Result := nil;
end;

function TADODesignDataBaseEh.GetIADOConProvider: IADOConnectionProviderEh;
begin
  Supports(FConProvider, IADOConnectionProviderEh, Result);
end;

{ TADOAccessEngineEh }

function TADOAccessEngineEh.AccessEngineName: String;
begin
  Result := 'ADO';
end;

function TADOAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
  DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
var
  ADODesignDataBase: TADODesignDataBaseEh;
begin
  ADODesignDataBase := TADODesignDataBaseEh.Create(True, nil);
  ADODesignDataBase.FDBServiceClass := DBServiceClass;
  ADODesignDataBase.EditDatabaseParams;
  Result := ADODesignDataBase;
end;

procedure RegisterADOAccessEngines;
var
  Engine: TADOAccessEngineEh;
begin
  RegisterDesignDataBuilderProcEh(TADODataDriverEh, SetDesignADODataBaseProcEh);
  Engine := TADOAccessEngineEh.Create;
  RegisterAccessEngine('ADO', Engine);
  RegisterDBServiceEngine(Engine, TADOUniService);
  RegisterDBServiceEngine(Engine, TMSSQLDBService);
  RegisterDBServiceEngine(Engine, TOracleDBService);
  RegisterDBServiceEngine(Engine, TInterbaseDBService);
  RegisterDBServiceEngine(Engine, TInformixDBService);
  RegisterDBService('ADOUniService', TADOUniService);
  RegisterDataDriverEditInteractorEh(TADODataDriverEditInteractorEh, TADODataDriverEh);
  ADOConnectionProviderDesignService := TADOConnectionProviderDesignSerivceEh.Create;
end;

procedure UnregisterADOAccessEngines;
begin
  UnregisterDesignDataBuilderProcEh(TADODataDriverEh);
  UnregisterAccessEngine('ADO');
  UnregisterDBServiceEngine(TADOUniService);
  UnregisterDBServiceEngine(TMSSQLDBService);
  UnregisterDBServiceEngine(TOracleDBService);
  UnregisterDBServiceEngine(TInterbaseDBService);
  UnregisterDBServiceEngine(TInformixDBService);
  UnregisterDBService('ADOUniService');
  UnregisterDataDriverEditInteractorEh(TADODataDriverEditInteractorEh);
  ADOConnectionProviderDesignService := nil; 
end;

{ TADOUniService }

constructor TADOUniService.Create(ADesignDB: TDesignDataBaseEh);
var
  tlt: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);
  FDesignDB := ADesignDB;

  AddSQLClass('ServerItems', 'ServerItems');
  AddSQLClass('Tables', 'Tables');
  AddSQLClass('Views', 'Views');
  AddSQLClass('Synonyms', 'Synonyms');
  AddSQLClass('SystemTables', 'SystemTables');
  AddSQLClass('TableColumns', 'TableColumns');
  AddSQLClass('Procedures', 'Procedures');
  AddSQLClass('ProcedureParameters', 'ProcedureParameters');

  tlt := TSQLTreeNodeTemplate.Create(Self, 'ADO Server');
  tlt.NodesSQLClassName :=  'ServerItems';
  tlt.MasterTemplateName := '';
  tlt.NodesMemTableName :=  'ServerItems';
  tlt.ObjIdFieldName :=     'OBJ_NAME';
  tlt.InTreeTextFieldName :='OBJ_NAME';
  tlt.HasNodes :=           True;
  tlt.NodesFilter :=        '';

  tlt := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  tlt.NodesSQLClassName :=  'Tables';
  tlt.MasterTemplateName := 'Tables';
  tlt.NodesMemTableName :=  'TableObjects';
  tlt.ObjIdFieldName :=     'TABLE_NAME';
  tlt.InTreeTextFieldName :='TABLE_NAME';
  tlt.HasNodes :=           True;
  tlt.NodesFilter :=        '';
  tlt.ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
  '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
  '"TABLE_SCHEMA", "Table Schema", 100 ';
  tlt.OnNodeDragDrop := tlt.TableEditorDrop;

  tlt := TSQLTreeNodeTemplate.Create(Self, 'Views');
  tlt.NodesSQLClassName :=  'Views';
  tlt.MasterTemplateName := 'Views';
  tlt.NodesMemTableName :=  'ViewObjects';
  tlt.ObjIdFieldName :=     'TABLE_NAME';
  tlt.InTreeTextFieldName :='TABLE_NAME';
  tlt.HasNodes :=           True;
  tlt.NodesFilter :=        '';
  tlt.ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
  '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
  '"TABLE_SCHEMA", "Table Schema", 100 ';
  tlt.OnNodeDragDrop := tlt.TableEditorDrop;

  tlt := TSQLTreeNodeTemplate.Create(Self, 'Synonyms');
  tlt.NodesSQLClassName :=  'Synonyms';
  tlt.MasterTemplateName := 'Synonyms';
  tlt.NodesMemTableName :=  'SynonymObjects';
  tlt.ObjIdFieldName :=     'TABLE_NAME';
  tlt.InTreeTextFieldName :='TABLE_NAME';
  tlt.HasNodes :=           True;
  tlt.NodesFilter :=        '';
  tlt.ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
  tlt.OnNodeDragDrop := tlt.TableEditorDrop;

  tlt := TSQLTreeNodeTemplate.Create(Self, 'SystemTables');
  tlt.NodesSQLClassName :=  'SystemTables';
  tlt.MasterTemplateName := 'SystemTables';
  tlt.NodesMemTableName :=  'SystemTableObjects';
  tlt.ObjIdFieldName :=     'TABLE_NAME';
  tlt.InTreeTextFieldName :='TABLE_NAME';
  tlt.HasNodes :=           True;
  tlt.NodesFilter :=        '';
  tlt.ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
  tlt.OnNodeDragDrop := tlt.TableEditorDrop;

  tlt := TSQLTreeNodeTemplate.Create(Self, 'TableColumns');
  tlt.NodesSQLClassName :=  'TableColumns';
  tlt.MasterTemplateName := '';
  tlt.NodesMemTableName :=  'TableColumns';
  tlt.ObjIdFieldName :=     'ID';
  tlt.InTreeTextFieldName :='COLUMN_NAME';
  tlt.HasNodes :=           False;
  tlt.NodesFilter :=        '[TABLE_NAME] = ''%[TABLE_NAME]''';
  tlt.ColumnAttributesStr :='"COLUMN_NAME", "Column name", "100", '+
    '"DATA_TYPE",  "Type", "50", '+
    '"IS_NULLABLE", "Can Null", "20", ' +
    '"COLUMN_DEFAULT", "Def. Value", "50" ';
  tlt.OnNodeDragDrop := tlt.TableEditorDrop;

  tlt := TSQLTreeNodeTemplate.Create(Self, 'Procedures');
  tlt.NodesSQLClassName :=  'Procedures';
  tlt.MasterTemplateName := 'Procedures';
  tlt.NodesMemTableName :=  'ProceduresObjects';
  tlt.ObjIdFieldName :=     'PROCEDURE_NAME';
  tlt.InTreeTextFieldName :='PROCEDURE_NAME';
  tlt.HasNodes :=           True;
  tlt.NodesFilter :=        '';
  tlt.ColumnAttributesStr := '"PROCEDURE_NAME", "Name", "100", ' +
    '"DESCRIPTION", "Description", 100, ' +
    '"PROCEDURE_TYPE", "Type", 30, ' +
    '"PROCEDURE_CATALOG", "Catalog", 100, ' +
    '"PROCEDURE_SCHEMA", "Schema", 100, ' +
    '"PROCEDURE_DEFINITION", "Definition", 100 ';

  tlt := TSQLTreeNodeTemplate.Create(Self, 'ProcedureParameters');
  tlt.NodesSQLClassName :=  'ProcedureParameters';
  tlt.MasterTemplateName := '';
  tlt.NodesMemTableName :=  'ProcedureParameters';
  tlt.ObjIdFieldName :=     'ID';
  tlt.InTreeTextFieldName :='PARAMETER_NAME';
  tlt.HasNodes :=           False;
  tlt.NodesFilter :=        '[PROCEDURE_NAME] = ''%[PROCEDURE_NAME]''';
  tlt.ColumnAttributesStr :='"PARAMETER_NAME", "Param name", "100", '+
    '"DATA_TYPE",  "Type", "50", '+
    '"IS_RESULT", "Is Result", "20"';

{
  TSQLTreeNodeTemplate.Create(
    Self,
    'Views',
    'Views', 

    'Views', 
    'ViewsObjects', 
    [], 
    'TABLE_NAME', 
    'TABLE_NAME', 
    True,
    '',
    'TABLE_NAME',
    '"TABLE_NAME", "View name", "200" '
    );

}
end;

destructor TADOUniService.Destroy;
begin
  FreeAndNil(FSpecPraramsService);
  inherited Destroy;
end;

function TADOUniService.ShowPopup(Source: TObject; Coord: TPoint;
  Params: TServicePopupParams): Integer;
begin
  Result := -1;
end;

function TADOUniService.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Connection: TADOConnection;
  ADOReader: TADODataSet;
  Reader: TMemTableEh;
  DataField: TMTDataFieldEh;

  procedure CreateAdditionalFields(DataStruct: TMTDataStructEh);
  begin
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'TEMPLATE_NAME';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'NODES_SQLCLASS_NAME';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'LOCAL_FILTER';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTNumericDataFieldEh);
    DataField.FieldName := 'Image_Index';
  end;
begin
  Connection := TADODesignDataBaseEh(FDesignDB).GetConnection;
  Reader := nil;
  ADOReader := TADODataSet.Create(nil);
  try
    if SQL = 'ServerItems' then
    begin
      Reader := TMemTableEh.Create(nil);
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'OBJ_NAME';
      DataField.Size := 20;
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Tables';
      Reader['TEMPLATE_NAME'] := 'Tables';
      Reader['NODES_SQLCLASS_NAME'] := 'TableObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 0;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Views';
      Reader['TEMPLATE_NAME'] := 'Views';
      Reader['NODES_SQLCLASS_NAME'] := 'ViewsObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Synonyms';
      Reader['TEMPLATE_NAME'] := 'Synonyms';
      Reader['NODES_SQLCLASS_NAME'] := 'SynonymObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'SystemTables';
      Reader['TEMPLATE_NAME'] := 'SystemTables';
      Reader['NODES_SQLCLASS_NAME'] := 'SystemTablesObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Procedures';
      Reader['TEMPLATE_NAME'] := 'Procedures';
      Reader['NODES_SQLCLASS_NAME'] := 'Procedures';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 3;
      Reader.Post;

    end else if SQL = 'Tables' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('TABLE')]), EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Views' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('VIEW')]), EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Synonyms' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('SYNONYM')]), EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'SystemTables' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('SYSTEM TABLE')]), EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'TableColumns' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siColumns, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'ID';
      DataField.Size := 100;
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ViewColumnsProps';
        Reader['NODES_SQLCLASS_NAME'] := 'NODES_SQLCLASS_NAME';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 4;
        Reader['ID'] := Reader['COLUMN_NAME'] + '.' + Reader['TABLE_NAME'];
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Procedures' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siProcedures, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ProcedureParameters';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'ProcedureParameters' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siProcedureParameters, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'ID';
      DataField.Size := 100;
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ViewProceduresColumnsProps';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 4;
        Reader['ID'] := Reader['PARAMETER_NAME'] + '.' + Reader['PROCEDURE_NAME'];
        Reader.Post;
        Reader.Next;
      end;
     end;
  finally
    ADOReader.Free;
  end;
  Result := Reader;
end;

class function TADOUniService.GetDBServiceName: String;
begin
  Result := 'ADOUniService';
end;

function TADOUniService.GetSpecParamsList: String;
var
  s: TStringList;
  i: Integer;
  FSpecParams: TCustomDBService;
begin
  if (FDesignDB is TADODesignDataBaseEh) and (TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass <> nil) then
  begin
    FSpecParams := TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass.Create(FDesignDB);
    Result := FSpecParams.GetSpecParamsList;
    FSpecParams.Free;
  end else if (FSpecPraramsService = nil) and not FNoAskForSpecPraramsService then
  begin
    s := TStringList.Create;
    for i := 0 to GetDBServiceList.Count-1 do
      s.Add(GetDBServiceList[i]);
    i := SelectFromList(s);
    if i <> -1 then
      FSpecPraramsService := GetDBServiceByName(s[i]).Create(FDesignDB);
    s.Free;
  end;
  if FSpecPraramsService <> nil then
    Result := FSpecPraramsService.GetSpecParamsList;
end;

procedure TADOUniService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
var
  s: TStringList;
  i: Integer;
  FSpecParams: TCustomDBService;
begin
  if (FDesignDB is TADODesignDataBaseEh) and (TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass <> nil) then
  begin
    FSpecParams := TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass.Create(FDesignDB);
    FSpecParams.GenGetSpecParams(DesignUpdateParams, DesignUpdateInfo);
    FSpecParams.Free;
  end else if (FSpecPraramsService = nil) and not FNoAskForSpecPraramsService then
  begin
    s := TStringList.Create;
    for i := 0 to GetDBServiceList.Count-1 do
      s.Add(GetDBServiceList[i]);
    i := SelectFromList(s);
    if i <> -1 then
      FSpecPraramsService := GetDBServiceByName(s[i]).Create(FDesignDB);
    s.Free;
  end;
  if FSpecPraramsService <> nil then
    FSpecPraramsService.GenGetSpecParams(DesignUpdateParams, DesignUpdateInfo);
end;

{$IFDEF DESIGNTIME}
{ TDataDriverEhSelectionEditor }

type
 TADODataDriverEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

procedure TADODataDriverEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
{$IFDEF EH_LIB_16}
   Proc('Data.Win.ADODB');
{$ELSE}
   Proc('ADODB');
{$ENDIF}
end;

type
{ TADOConnectionProviderEhEditor }

  TADOConnectionProviderEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TADOConnectionProviderEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditFormADOConnProvider(TADOConnectionProviderEh(Component)) then
         Designer.Modified;
    2:
      ShowAboutForm;
  end;
end;

function TADOConnectionProviderEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'ConnectionProvider Editor ...';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TADOConnectionProviderEhEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

{$ENDIF}

procedure Register;
begin
{$IFDEF EH_LIB_9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  RegisterComponents('EhLib Components', [TADODataDriverEh]);
{$IFDEF DESIGNTIME}
  RegisterComponentEditor(TADODataDriverEh, TSQLDataDriverEhEditor);
  RegisterPropertyEditor(TypeInfo(WideString), TADODataDriverEh, 'ConnectionString', TConnectionStringProperty);
  RegisterComponentEditor(TADOConnectionProviderEh, TADOConnectionProviderEhEditor);

  RegisterPropertyEditor(TypeInfo(Boolean), TADOInlineConnectionEh, 'UseAtDesignTime', TStoreableBoolProperty);
  UnlistPublishedProperty(TADOInlineConnectionEh, 'UseAtDesignTimeStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TADOInlineConnectionEh, 'UseAtRunTime', TStoreableBoolProperty);
  UnlistPublishedProperty(TADOInlineConnectionEh, 'UseAtRunTimeStored');
  
  RegisterSelectionEditor(TADODataDriverEh, TADODataDriverEhSelectionEditor);
{$ENDIF}
  RegisterComponents('EhLib Components', [TADOConnectionProviderEh]);
  
end;

procedure AssignTableParToADOParams(mtParams: TMemTableEh; Params: TParameters);
var
  i: Integer;
  ParamDataType: TDataType;
begin
  for i := Params.Count-1 downto 0 do
  begin
    if not mtParams.Locate('ParName', Params[i].Name, []) then
      Params.Delete(i);
  end;

  for i := 0 to mtParams.RecordsView.Count-1 do
  begin
    if Params.FindParam(mtParams.RecordsView.Rec[i].DataValues['ParName', dvvValueEh]) = nil then
    begin
      Params.CreateParameter(
         mtParams.RecordsView.Rec[i].DataValues['ParName', dvvValueEh],
         GetDataTypeByName(mtParams.RecordsView.Rec[i].DataValues['ParType', dvvValueEh]),
         pdInput,
         0,
         mtParams.RecordsView.Rec[i].DataValues['ParVarValue', dvvValueEh]);
    end;
  end;

  for i := 0 to Params.Count-1  do
  begin
    mtParams.Locate('ParName', Params[i].Name, []);
    try
      ParamDataType := GetDataTypeByName(mtParams['ParType']);
      if ParamDataType <> ftUnknown then
        Params[i].DataType := GetDataTypeByName(mtParams['ParType']);
    except
      on E: EOleException do
        Application.HandleException(E);
    end;
    Params[i].Value := mtParams['ParVarValue'];
  end;

end;

{ TADODataDriverEditInteractorEh }

class procedure TADODataDriverEditInteractorEh.AssignCommantToEditData(
  Command: TCustomSQLCommandEh; SQLText: String; mtParams: TMemTableEh);
begin
  inherited AssignCommantToEditData(Command, SQLText, mtParams);
end;

class procedure TADODataDriverEditInteractorEh.AssignEditDataToCommant(
  SQLText: String; mtParams: TMemTableEh; Command: TCustomSQLCommandEh);
var
  ParCommand: TADOCommand;
begin
  ParCommand := TADOCommand.Create(nil);
  try
    ParCommand.Parameters.Assign(TADOCommandEh(Command).Parameters);
    Command.CommandText.Text := SQLText;
    AssignTableParToADOParams(mtParams, ParCommand.Parameters);
    TADOCommandEh(Command).Parameters := ParCommand.Parameters;
  finally
    ParCommand.Free;
  end;
end;

class procedure TADODataDriverEditInteractorEh.DesignDataBaseReassigned(
  SQLEditWin: TSQLDataEditWin);
begin
  inherited DesignDataBaseReassigned(SQLEditWin);
  if (SQLEditWin.DesignDataBase = nil) or not (SQLEditWin.DesignDataBase is TADODesignDataBaseEh)
    then TADODataDriverEh(SQLEditWin.DesignDriver).ADOConnection := nil
    else TADODataDriverEh(SQLEditWin.DesignDriver).ADOConnection := TADODesignDataBaseEh(SQLEditWin.DesignDataBase).ApplicationConnection;
end;

class procedure TADODataDriverEditInteractorEh.RefreshParams(
  Command: TCustomSQLCommandEh; SQLEditWin: TSQLDataEditWin);
begin
  SQLEditWin.CheckRequestDesignDataBaseEh;
  if (SQLEditWin.DesignDataBase <> nil) and
    (TADODesignDataBaseEh(SQLEditWin.DesignDataBase).ApplicationConnection <> nil) then
  begin
    TADODataDriverEh(Command.DataDriver).ADOConnection := TADODesignDataBaseEh(SQLEditWin.DesignDataBase).ApplicationConnection;
    inherited RefreshParams(Command, SQLEditWin);
  end;  
end;

{ TADOConnectionProviderDesignSerivceEh }

function TADOConnectionProviderDesignSerivceEh.CreateDesignDataBase(
  ConnectionProvider: TComponent): TComponent;
begin
  Result := TADODesignDataBaseEh.Create(False, ConnectionProvider);
end;

function TADOConnectionProviderDesignSerivceEh.EditDesignData(
  ConnectionProvider: TConnectionProviderEh): Boolean;
begin
  Result := EditFormADOConnProvider(TADOConnectionProviderEh(ConnectionProvider));
end;

initialization
  RegisterADOAccessEngines();
finalization
  UnregisterADOAccessEngines();
end.

