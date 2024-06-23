{*******************************************************}
{                                                       }
{                     EhLib 10.2                        }
{                                                       }
{                 TBDEDesignDataBaseEh                  }
{                                                       }
{     Copyright (c) 2004-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit BDEDataDriverDesignEh;

{$I EHLIB.INC}

interface

{$IFDEF CIL}
{$R BDEDataDriverEh.TBDEDataDriverEh.bmp}
{$ENDIF}

uses Windows, SysUtils, Classes, Controls, DB,
  EhLibVCL, Variants, Contnrs,
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, DBTables,
  SQLDriverEditEh, BDEDataDriverEh, ComCtrls, MemTableEh, Forms;

type

{ IBDEDesignDataBaseEh }

  IBDEDesignDataBaseEh = interface
  ['{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}']
    function GetDataBase: TDataBase;
  end;

{ TBDEDesignDataBaseEh }

  TBDEDesignDataBaseEh = class(TDesignDataBaseEh, IBDEDesignDataBaseEh)
  private
    FDBEDataBase: TDataBase;
    FTreeNodeMan: TCustomDBService;
    FRuntimeDataBaseName: String;
    FDBService: TCustomDBService;
    FUpdateObjectsList: TStringList;

  protected
    function GetConnected: Boolean; override;
    procedure SetConnected(const Value: Boolean); override;
    procedure DataBaseDisconnected(Sender: TObject);

  public
    constructor Create(IsPublicDataBase: Boolean; AConProvider: TComponent); override;
    destructor Destroy; override;

    function BuildInformixObjectTree2(List: TObjectList): Boolean;
    function BuildInterbaseObjectTree2(List: TObjectList): Boolean;
    function BuildObjectTree(List: TObjectList): Boolean; override;
    function BuildOracleObjectTree(List: TObjectList): Boolean;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh; override;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
    function DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function ExecuteSQL(SQL: String; FParams: TParamsArr): Integer;
    function GetConProvider: TBDEConnectionProviderEh;
    function GetCustomDBService: TCustomDBService; override;
    function GetDataBase: TDataBase;
    function GetEngineName: String; override;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; override;
    function GetIncrementObjectsList: TStrings; override;
    function GetServerTypeName: String; override;
    function GetSpecParamsList: String; override;
    function SupportCustomSQLDataDriver: Boolean; override;

    procedure BuildQueryPlan(PlanTable: TMemTableEh; Command: TCustomSQLCommandEh); override;
    procedure EditDatabaseParams; override;
    procedure ResetDesignInfo; override;

    property RuntimeDataBaseName: String read FRuntimeDataBaseName write FRuntimeDataBaseName;
  end;

{ TBDEDesignDataBaseEh }

  TBDEUniService = class(TCustomDBService)
  private
    ServerService: TCustomDBService;
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    destructor Destroy; override;

    class function GetDBServiceName: String; override;
    function CreateRootNodes: TObjectList; override;
    function CreateNodes(Parent: TSQLTreeNode): TObjectList; override;
    function ShowPopup(Source: TObject; Coord: TPoint; Params: TServicePopupParams): Integer; override;
  end;

{ TBDEConnectionProviderDesignSerivceEh }

  TBDEConnectionProviderDesignSerivceEh = class(TConnectionProviderDesignSerivceEh)
    function EditDesignData(ConnectionProvider: TConnectionProviderEh): Boolean; override;
    function CreateDesignDataBase(ConnectionProvider: TComponent): TComponent; override;
  end;

procedure UnregisterBDEAccessEngines;
procedure RegisterBDEAccessEngines;

{$IFDEF DESIGNTIME}
procedure Register;
{$ENDIF}

implementation

uses BDE, DesignConnectionListEh,
{$IFDEF DESIGNTIME}
	MemTableDesignEh, StrEdit,
{$IFDEF DESIGNTIME}
  {$IFDEF CIL}
    Borland.Vcl.Design.DbEdit,
    Borland.Vcl.Design.FldProp,
  {$ELSE}
    Dbedit,
  {$ENDIF}
{$ENDIF}
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
{$ELSE}
  DesignIntf,
  DesignEditors,
  DBReg,
{$ENDIF}
{$ENDIF}
  Dialogs, UpdateSQLEditEh, EhLibDesignAbout;

type
  TDBDescription = record
    szName          : String;          { Logical name (Or alias) }
    szText          : String;          { Descriptive text }
    szPhyName       : String;          { Physical name/path }
    szDbType        : String;          { Database type }
  end;

{$IFDEF CIL}
{$ELSE}
{$IFDEF EH_LIB_12}
function StrToOem(const AnsiStr: AnsiString): AnsiString;
begin
  SetLength(Result, Length(AnsiStr));
  if Length(Result) > 0 then
    CharToOemA(PAnsiChar(AnsiStr), PAnsiChar(Result));
end;
{$ELSE}
function StrToOem(const AnsiStr: string): string;
begin
  SetLength(Result, Length(AnsiStr));
  if Length(Result) > 0 then
    CharToOem(PChar(AnsiStr), PChar(Result));
end;
{$ENDIF}
{$ENDIF}

function GetDatabaseDesc(DBName: String; var Description: TDBDescription): Boolean;
var
  Desc: DBDesc;
begin
  Result := False;
{$IFDEF CIL}
  if DbiGetDatabaseDesc(DBName, Desc) <> 0 then Exit;
{$ELSE}
{$IFDEF EH_LIB_12}
  if DbiGetDatabaseDesc(PAnsiChar(StrToOem(AnsiString(DBName))), @Desc) <> 0 then Exit;
{$ELSE}
  if DbiGetDatabaseDesc(PChar(StrToOem(DBName)), @Desc) <> 0 then Exit;
{$ENDIF}
{$ENDIF}
  Description.szName := String(Desc.szName);
  Description.szText := String(Desc.szText);
  Description.szPhyName := String(Desc.szPhyName);
  Description.szDbType := String(Desc.szDbType);
  Result := True;
end;

var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'BDEDataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;

function CreateDesignDataBase(DataDriver: TBDEDataDriverEh): TComponent;
var
  DesignDataBase: TBDEDesignDataBaseEh;
  SourceDataBase: TDataBase;
  Description: TDBDescription;

  function IsAlias(DatabaseName: String): Boolean;
  var
    List: TStringList;
  begin
    Result := False;
    List := TStringList.Create;
    try
      Session.GetAliasNames(List);
      if List.IndexOf(DatabaseName) >= 0 then
        Result := True;
    finally
      List.Free;
    end;
  end;

begin
  DesignDataBase :=  TBDEDesignDataBaseEh.Create(True, nil);
  SourceDataBase := Session.FindDatabase(DataDriver.DatabaseName);
  if SourceDataBase <> nil then
  begin
    DesignDataBase.FDBEDataBase.DatabaseName := GetUnicalDataBaseName;
    if (SourceDataBase.AliasName = '') and
      (SourceDataBase.DriverName = '') and
      GetDatabaseDesc(DataDriver.DatabaseName, Description)
    then
      DesignDataBase.FDBEDataBase.AliasName := DataDriver.DatabaseName
    else if SourceDataBase.AliasName <> '' then
      DesignDataBase.FDBEDataBase.AliasName := SourceDataBase.AliasName
    else if SourceDataBase.DriverName <> '' then
      DesignDataBase.FDBEDataBase.DriverName := SourceDataBase.DriverName;
    DesignDataBase.FDBEDataBase.Params := SourceDataBase.Params;
  end else if IsAlias(DataDriver.DatabaseName) then
    DesignDataBase.FDBEDataBase.DatabaseName := DataDriver.DatabaseName
  else if GetDatabaseDesc(DataDriver.DatabaseName, Description) then
    DesignDataBase.FDBEDataBase.DatabaseName := DataDriver.DataBaseName;
  DesignDataBase.RuntimeDataBaseName := DataDriver.DatabaseName;

{$IFDEF DESIGNTIME}
  EditDatabase(DesignDataBase.FDBEDataBase);
{$ENDIF}

  Result := DesignDataBase;
end;

procedure SetDesignDBEDataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
var
  i: Integer;
  DesignDataBase: TComponent;
begin
  if DataDriver.DesignDataBase = nil then
  begin
    for i := 0 to GetDesignDataBaseList.Count-1 do
      if TDesignDataBaseEh(GetDesignDataBaseList[i]).DesignDataBaseConnetionEqual(DataDriver) then
      begin
        DataDriver.DesignDataBase := TComponent(GetDesignDataBaseList[i]);
        Exit;
      end;

    if GetDesignDataBaseList.Count > 0 then
    begin
      DesignDataBase := SelectDesignConnectionListEh(DesignDataBaseList);
      if (DesignDataBase <> nil) and (DesignDataBase <> DataDriver.DesignDataBase) then
        DataDriver.DesignDataBase := DesignDataBase;
    end else
      DataDriver.DesignDataBase := CreateDesignDataBase(TBDEDataDriverEh(DataDriver));
  end;
end;

{ TBDEDesignDataBaseEh }

function TBDEDesignDataBaseEh.BuildObjectTree(List: TObjectList): Boolean;
begin
  if GetServerTypeName = 'INFORMIX' then
    Result := BuildInformixObjectTree2(List)
  else if GetServerTypeName = 'INTRBASE' then
    Result := BuildInterbaseObjectTree2(List)
  else if GetServerTypeName = 'ORACLE' then
    Result := BuildOracleObjectTree(List)
  else
    Result := False;
end;

function TBDEDesignDataBaseEh.BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := EditDataDriverUpdateSQL(DataDriver as TCustomSQLDataDriverEh);
end;

constructor TBDEDesignDataBaseEh.Create(IsPublicDataBase: Boolean; AConProvider: TComponent);
begin
  inherited Create(IsPublicDataBase, AConProvider);

  if AConProvider = nil then
  begin
    FDBEDataBase := TDatabase.Create(Application);
    FDBEDataBase.DatabaseName := GetUnicalDataBaseName;
    FDBEDataBase.AfterDisconnect := DataBaseDisconnected;
  end;
end;

destructor TBDEDesignDataBaseEh.Destroy;
begin
  if not (csDestroying in Application.ComponentState) then
    FreeAndNil(FDBEDataBase);
  FreeAndNil(FTreeNodeMan);
  FreeAndNil(FDBService);
  inherited Destroy;
end;

function TBDEDesignDataBaseEh.CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := TBDEDataDriverEh.Create(nil);
  Result.SelectCommand := RTDataDriver.SelectCommand;
  Result.UpdateCommand := RTDataDriver.UpdateCommand;
  Result.InsertCommand := RTDataDriver.InsertCommand;
  Result.DeleteCommand := RTDataDriver.DeleteCommand;
  Result.GetrecCommand := RTDataDriver.GetrecCommand;
  TBDEDataDriverEh(Result).SpecParams := TBDEDataDriverEh(RTDataDriver).SpecParams;
  TBDEDataDriverEh(Result).DatabaseName := GetDataBase.DatabaseName;
end;

function TBDEDesignDataBaseEh.DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
  if DataDriver is TBDEDataDriverEh then
    Result := (TBDEDataDriverEh(DataDriver).DatabaseName = RuntimeDataBaseName);
end;

function TBDEDesignDataBaseEh.Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  q: TQuery;
  t: TTable;
  sp: TStoredProc;
begin
  Result := -1;
  FreeOnEof := True;
  case Command.CommandType of
    cthSelectQuery, cthUpdateQuery:
      begin
        q := TQuery.Create(nil);
        q.DataBaseName := GetDataBase.DatabaseName;
        q.SQL := Command.FinalCommandText;
        q.Params := Command.GetParams;
        if Command.CommandType = cthSelectQuery then
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
        t := TTable.Create(nil);
        t.DataBaseName := GetDataBase.DatabaseName;
        t.TableName := Command.FinalCommandText.Text;
        t.Open;
        Cursor := t;
      end;
    cthStoredProc:
      begin
        sp := TStoredProc.Create(nil);
        sp.DataBaseName := GetDataBase.DatabaseName;
        sp.StoredProcName := Command.FinalCommandText.Text;
        sp.Params := Command.GetParams;
        sp.ExecProc;
        Cursor := sp;
      end;
  end;
end;

function TBDEDesignDataBaseEh.GetDataBase: TDataBase;
begin
  Result := nil;
  if FDBEDataBase <> nil then
    Result := FDBEDataBase
  else if GetConProvider <> nil then
    Result := GetConProvider.CurrentTimeDatabase;
end;

function TBDEDesignDataBaseEh.GetServerTypeName: String;
var
  Description: TDBDescription;
begin
  if not GetDataBase.Connected then
  try
    GetDataBase.Open;
  except
    Application.HandleException(Self);
  end;
  if GetDatabaseDesc(GetDataBase.DatabaseName, Description) then
  begin
    Result := UpperCase(Description.szDbType);
  end;
end;

function TBDEDesignDataBaseEh.BuildInterbaseObjectTree2(List: TObjectList): Boolean;
var
  NList: TObjectList;
  i: Integer;
begin
  if FTreeNodeMan <> nil then
    FTreeNodeMan.Free;
  FTreeNodeMan := TInterbaseDBService.Create(Self);
  NList := FTreeNodeMan.CreateRootNodes;
  List.Clear;
  for I := 0 to NList.Count - 1 do
    List.Add(NList[I]);

  NList.Free;
  Result := True;
end;

function TBDEDesignDataBaseEh.BuildInformixObjectTree2(List: TObjectList): Boolean;
var
  NList: TObjectList;
  i: Integer;
begin
  if FTreeNodeMan <> nil then
    FTreeNodeMan.Free;
  FTreeNodeMan := TInformixDBService.Create(Self);
  NList := FTreeNodeMan.CreateRootNodes;
  List.Clear;
  for I := 0 to NList.Count - 1 do
    List.Add(NList[I]);

  NList.Free;
  Result := True;
end;

function TBDEDesignDataBaseEh.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Query: TQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
begin
  Query := TQuery.Create(nil);
  Query.DatabaseName := GetDataBase.DatabaseName;
  Query.SQL.Text := SQL;
  if High(FParams) > Low(FParams) then
    for i := Low(FParams) to High(FParams) div 2 do
    begin
      dt := VarTypeToDataType(VarType(FParams[i*2+1]));
      if dt = ftUnknown then
        dt := ftString;
      p := Query.Params.CreateParam(dt, FParams[i*2], ptInputOutput);
      p.Value := FParams[i*2+1];
    end;
  try
    Query.Open;
  except
    Query.Free;
    raise;
  end;
  Result := Query;
end;

function TBDEDesignDataBaseEh.ExecuteSQL(SQL: String;
  FParams: TParamsArr): Integer;
var
  Query: TQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
begin
  Query := TQuery.Create(nil);
  Query.DatabaseName := GetDataBase.DatabaseName;
  Query.SQL.Text := SQL;
  if High(FParams) > Low(FParams) then
    for i := Low(FParams) to High(FParams) div 2 do
    begin
      dt := VarTypeToDataType(VarType(FParams[i*2+1]));
      if dt = ftUnknown then
        dt := ftString;
      p := Query.Params.CreateParam(dt, FParams[i*2], ptInputOutput);
      p.Value := FParams[i*2+1];
    end;
  try
    Query.ExecSQL;
    Result := Query.RowsAffected;
  except
    Query.Free;
    raise;
  end;
end;

function TBDEDesignDataBaseEh.BuildOracleObjectTree(List: TObjectList): Boolean;
var
  NList: TObjectList;
  i: Integer;
begin
  if FTreeNodeMan <> nil then
    FTreeNodeMan.Free;
  FTreeNodeMan := TOracleDBService.Create(Self);
  NList := FTreeNodeMan.CreateRootNodes;
  List.Clear;
  for I := 0 to NList.Count - 1 do
    List.Add(NList[I]);

  NList.Free;
  Result := True;
end;

procedure TBDEDesignDataBaseEh.EditDatabaseParams;
begin
{$IFDEF DESIGNTIME}
  EditDatabase(GetDataBase);
{$ENDIF}
end;

function TBDEDesignDataBaseEh.GetEngineName: String;
begin
  Result := 'BDE';
end;

function TBDEDesignDataBaseEh.GetConnected: Boolean;
begin
  Result := (GetDataBase <> nil) and GetDataBase.Connected;
end;

function TBDEDesignDataBaseEh.GetConProvider: TBDEConnectionProviderEh;
begin
  Result := TBDEConnectionProviderEh(FConProvider);
end;

procedure TBDEDesignDataBaseEh.SetConnected(const Value: Boolean);
begin
  if GetDataBase <> nil then
    GetDataBase.Connected := Value;
end;

type
  TBDEAccessEngineEh = class(TAccessEngineEh)
    function AccessEngineName: String; override;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
      DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh; override;
  end;

function TBDEDesignDataBaseEh.SupportCustomSQLDataDriver: Boolean;
begin
  Result := True;
end;

function TBDEDesignDataBaseEh.GetFieldList(const TableName: string; DataSet: TDataSet): Boolean;
var
  table: TTable;
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
  table := TTable.Create(nil);
  table.DatabaseName := GetDataBase.DatabaseName;
  table.TableName := TableName;
  list := TStringList.Create;
  GetDataFieldNames(table, 'Error', list);
  SetKeyFields;
  for i := 0 to list.Count-1 do
    if list.Objects[i] = TObject(1)
      then DataSet.AppendRecord([list[i], True])
      else DataSet.AppendRecord([list[i], False]);
  list.Free;
  table.Free;
  Result := True;
end;

procedure TBDEDesignDataBaseEh.BuildQueryPlan(PlanTable: TMemTableEh;
  Command: TCustomSQLCommandEh);
var
  DataSet: TDataSet;
begin
  if GetServerTypeName = 'ORACLE' then
  begin
    ExecuteSQL('EXPLAIN PLAN FOR '#13 + Command.FinalCommandText.Text, nil);
    DataSet := CreateReader('select * from PLAN_TABLE order by POSITION', nil);
    PlanTable.TreeList.Active := False;
    PlanTable.LoadFromDataSet(DataSet, -1, lmCopy, False);
    PlanTable.TreeList.KeyFieldName := 'ID';
    PlanTable.TreeList.RefParentFieldName := 'PARENT_ID';
    PlanTable.TreeList.DefaultNodeExpanded := True;
    PlanTable.TreeList.Active := True;
  end;
end;

function TBDEDesignDataBaseEh.GetSpecParamsList: String;
begin
  if GetCustomDBService <> nil then
    Result := GetCustomDBService.GetSpecParamsList;
end;

function TBDEDesignDataBaseEh.GetCustomDBService: TCustomDBService;
begin
  if FDBService = nil then
  begin
    if GetServerTypeName = 'INFORMIX' then
      FDBService := TInformixDBService.Create(Self)
    else if GetServerTypeName = 'INTRBASE' then
      FDBService := TInterbaseDBService.Create(Self)
    else if GetServerTypeName = 'ORACLE' then
      FDBService := TOracleDBService.Create(Self)
    else
      FDBService := nil
  end;
  Result := FDBService;
end;

function TBDEDesignDataBaseEh.GetIncrementObjectsList: TStrings;
begin
  if FUpdateObjectsList = nil then
    FUpdateObjectsList := TStringList.Create;
  if (GetCustomDBService <> nil) and (GetCustomDBService.GetIncrementObjectsList <> nil) then
  begin
    FUpdateObjectsList.Assign(GetCustomDBService.GetIncrementObjectsList);
    Result := FUpdateObjectsList;
  end else
    Result := nil;
end;

procedure TBDEDesignDataBaseEh.DataBaseDisconnected(Sender: TObject);
begin
  FreeAndNil(FDBService);
  FreeAndNil(FTreeNodeMan);
end;

procedure TBDEDesignDataBaseEh.ResetDesignInfo;
begin
  inherited ResetDesignInfo;
  FreeAndNil(FDBService);
  FreeAndNil(FTreeNodeMan);
end;

{ TBDEAccessEngineEh }

function TBDEAccessEngineEh.AccessEngineName: String;
begin
  Result := 'BDE';
end;

function TBDEAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
  DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
begin
  Result := TBDEDesignDataBaseEh.Create(True, nil);
  Result.EditDatabaseParams;
  if DataDriver is TBDEDataDriverEh then
    TBDEDesignDataBaseEh(Result).RuntimeDataBaseName := TBDEDataDriverEh(DataDriver).DatabaseName;
end;

procedure RegisterBDEAccessEngines;
var
  Engine: TBDEAccessEngineEh;
begin
  RegisterDesignDataBuilderProcEh(TBDEDataDriverEh, SetDesignDBEDataBaseProcEh);
  Engine := TBDEAccessEngineEh.Create;
  RegisterAccessEngine('BDE', Engine);
  RegisterDBServiceEngine(Engine, TBDEUniService);
  BDEConnectionProviderDesignService := TBDEConnectionProviderDesignSerivceEh.Create;
end;

procedure UnregisterBDEAccessEngines;
begin
  UnregisterDesignDataBuilderProcEh(TBDEDataDriverEh);
  UnregisterAccessEngine('BDE');
  UnregisterDBServiceEngine(TBDEUniService);
  BDEConnectionProviderDesignService := nil; 
end;

{ TBDEUniService }

constructor TBDEUniService.Create(ADesignDB: TDesignDataBaseEh);
var
  ServiceClass: TCustomDBServiceClass;
begin
  inherited Create(ADesignDB);
  ServiceClass := GetDBServiceByName(ADesignDB.GetServerTypeName);
  if ServiceClass <> nil then
    ServerService := ServiceClass.Create(ADesignDB);
end;

destructor TBDEUniService.Destroy;
begin
  FreeAndNil(ServerService);
  inherited Destroy;
end;

function TBDEUniService.CreateRootNodes: TObjectList;
begin
  Result := nil;
  if ServerService <> nil then
    Result := ServerService.CreateRootNodes;
end;

function TBDEUniService.CreateNodes(Parent: TSQLTreeNode): TObjectList;
begin
  Result := nil;
  if ServerService <> nil then
    Result := ServerService.CreateNodes(Parent);
end;

function TBDEUniService.ShowPopup(Source: TObject; Coord: TPoint;
  Params: TServicePopupParams): Integer;
begin
  Result := -1;
  if ServerService <> nil then
    Result := ServerService.ShowPopup(Source, Coord, Params);
end;

class function TBDEUniService.GetDBServiceName: String;
begin
  Result := 'BDEUniService';
end;

{$IFDEF DESIGNTIME}

{ TDatabaseNameProperty }

type
  TDatabaseNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TDatabaseNameProperty.GetValueList(List: TStrings);
begin
  if GetComponent(0) is TBDEDataDriverEh then
    (GetComponent(0) as TBDEDataDriverEh).DBSession.GetDatabaseNames(List)
end;

{ TAliasNameProperty }

type
  TAliasNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TAliasNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TBDEInlineConnectionEh).DataBase.Session.GetAliasNames(List);
end;

{ TDriverNameProperty }

type
  TDriverNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TDriverNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TBDEInlineConnectionEh).DataBase.Session.GetDriverNames(List);
end;

type

{ TBDEConnectionProviderEhEditor }

  TBDEConnectionProviderEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TBDEConnectionProviderEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditDatabase(TBDEConnectionProviderEh(Component).InlineConnection.DataBase) then
         Designer.Modified;
    2:
      ShowAboutForm;
  end;
end;

function TBDEConnectionProviderEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Design-time Database Editor ...';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TBDEConnectionProviderEhEditor.GetVerbCount: Integer;
begin
  Result := 0;
  if (Component <> nil) and (Component is TBDEConnectionProviderEh) then
    if TBDEConnectionProviderEh(Component).InlineConnection.UseAtDesignTime then
      Inc(Result);
  if Result > 0 then
    Result := 3;
end;

procedure Register;
begin
  RegisterComponents('EhLib Components', [TBDEDataDriverEh]);
  RegisterPropertyEditor(TypeInfo(string), TBDEDataDriverEh, 'DatabaseName', TDatabaseNameProperty);

  RegisterComponents('EhLib Components', [TBDEConnectionProviderEh]);
  RegisterComponentEditor(TBDEConnectionProviderEh, TBDEConnectionProviderEhEditor);

  RegisterPropertyEditor(TypeInfo(TStrings), TBDEInlineConnectionEh, 'Params', TValueListProperty);
  RegisterPropertyEditor(TypeInfo(string), TBDEInlineConnectionEh, 'AliasName', TAliasNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TBDEInlineConnectionEh, 'DriverName', TDriverNameProperty);

  RegisterComponentEditor(TBDEDataDriverEh, TSQLDataDriverEhEditor);
end;

{$ENDIF}

{ TBDEConnectionProviderDesignSerivceEh }

function TBDEConnectionProviderDesignSerivceEh.CreateDesignDataBase(
  ConnectionProvider: TComponent): TComponent;
begin
  Result := TBDEDesignDataBaseEh.Create(False, ConnectionProvider);
end;

function TBDEConnectionProviderDesignSerivceEh.EditDesignData(
  ConnectionProvider: TConnectionProviderEh): Boolean;
begin
  Result := False;
end;

initialization
  RegisterBDEAccessEngines();
finalization
  UnregisterBDEAccessEngines;
end.
