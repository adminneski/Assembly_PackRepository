{*******************************************************}
{                                                       }
{                     EhLib 10.2                        }
{                                                       }
{             TMemTableFieldsEditorEh component         }
{                                                       }
{       Copyright (c) 2003-2022 by EhLib Team and       }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

unit MemTableDesignEh;

{$I EhLib.Inc}

interface

uses
  SysUtils,
{$IFDEF CIL} Borland.Vcl.Design.DesignIntf,
             Borland.Vcl.Design.DesignEditors,
             Borland.Vcl.Design.ColnEdit,
             Borland.Vcl.Design.DSDesign,
             Borland.Vcl.Design.DsnDBCst,
             Borland.Vcl.Design.StringsEdit,
             Borland.Vcl.Design.PicEdit,
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
  DBGridsEh,
  EhLibLCL, LCLType,
  PropEdits, ComponentEditors, FieldsEditor,
  {$ELSE}
  EhLibVCL, DBGridEh,
  DSDesign, DsnDBCst, PicEdit, FldLinks,
  StringsEdit, VCLEditors, DesignEditors, DesignIntf, DesignWindows,
  DesignMenus, MTCreateDataDriver,
  Windows, Messages, StdCtrls, ComCtrls,
  {$ENDIF}
{$ENDIF}
  DB, Classes, Graphics, Controls, Forms, Variants,
  Dialogs, Menus, DBCtrls, ExtCtrls, GridsEh,
  MemTableDesignFrameEh,
  Buttons, ActnList, MemTableEh, DBGridEhImpExp,
  DBGridEhGrouping, MemTableDataEh, ToolCtrlsEh, DBGridEhToolCtrls;

type

  {$IFDEF FPC}
  TMemTableFieldsEditorEh = class(TDSFieldsEditorFrm)
  {$ELSE}
  TMemTableFieldsEditorEh = class(TFieldsEditor)
  {$ENDIF}
  private
  {$IFDEF FPC}
    FDataset: TDataset;
    FDataSource: TDataSource;
  {$ELSE}
  {$ENDIF}
    FMemTableEditorFrame: TMemTableDesignFrame;

    function GetMemTableEh: TCustomMemTableEh;
    procedure SetMemTableEh(Value: TCustomMemTableEh);
    procedure InitDfmDataInCode;

  public
    { Public declarations }
  {$IFDEF FPC}
    constructor Create(AOwner: TComponent; ADataset: TDataset;
     ADesigner: TComponentEditorDesigner);
  {$ELSE}
    constructor Create(AOwner: TComponent); override;
  {$ENDIF}

    destructor Destroy; override;

    procedure EditorActivated;

  {$IFDEF FPC}
  {$ELSE}
    function GetEditState: TEditState; override;
    function EditAction(Action: TEditAction): Boolean; override;
  {$ENDIF}

  {$IFDEF FPC}
    property Dataset: TDataset read FDataset;
    property DataSource: TDataSource read FDataSource;
  {$ELSE}
  {$ENDIF}

    property MemTable: TCustomMemTableEh read GetMemTableEh write SetMemTableEh;
    property MemTableEditorFrame: TMemTableDesignFrame read FMemTableEditorFrame;
  end;

  {$IFDEF FPC}
  {$ELSE}
  {$ENDIF}

{ TMemTableEditorEh }

{$IFDEF FPC}
  TMemTableEditorEh = class(TFieldsComponentEditor)
{$ELSE}
  TMemTableEditorEh = class(TComponentEditor{$IFDEF LINUX}, IDesignerThreadAffinity{$ENDIF})
{$ENDIF}
  protected
  {$IFDEF FPC}
    FMenuItem: TMenuItem;
  {$ELSE}
    FMenuItem: IMenuItem;
  {$ENDIF}
    DDRPropName: String;
    FDataDriversList: TStringList;
    {$IFDEF FPC}
    {$ELSE}
    function GetDSDesignerClass: TDSDesignerClass; virtual;
    {$ENDIF}
    procedure HandleCreateDataDriverSubMenu(Sender: TObject);
    procedure HandleAssignDataDriverSubMenu(Sender: TObject);
    procedure CheckComponent(const Value: string);
   public
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
    {$IFDEF FPC}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
    {$ELSE}
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    {$ENDIF}
//{$IFDEF LINUX}
//    procedure Edit; override;
//    {IDesignerThreadAffinity}
//    function GetThreadAffinity: TThreadAffinity;
//{$ENDIF}
  end;

{$IFDEF FPC}
{$ELSE}

{ TDataSourceEditor }

  TDataSourceEditor = class(TComponentEditor)
  protected
    FMenuItem: IMenuItem;
    DDRPropName: String;
    FDataSetList: TStringList;
    procedure HandleCreateDataSetSubMenu(Sender: TObject);
    procedure HandleAssignDataSetSubMenu(Sender: TObject);
    procedure CheckComponent(const Value: string);
   public
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

{ TDataSetDriverEhEditor }

  TDataSetDriverEhEditor = class(TComponentEditor)
    FMenuItem: IMenuItem;
    DDRPropName: String;
    FDataSetList: TStringList;
    procedure HandleCreateDataSetSubMenu(Sender: TObject);
    procedure HandleAssignDataSetSubMenu(Sender: TObject);
    procedure CheckComponent(const Value: string);
  public
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

{ TSQLDataDriverEhEditor }

  TSQLDataDriverEhEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TServerTypePropertyEditor }

  TServerTypePropertyEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{ TMemTableFieldLinkProperty }

  TMemTableFieldLinkProperty = class(TFieldLinkProperty)
  private
    FMemTable: TMemTableEh;
  protected
    function GetIndexFieldNames: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    procedure Edit; override;
  end;

  TSQLCommandProperty  = class(TClassProperty)
  public
    FCommandTextProp: IProperty;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetCommandTextProp(const Prop: IProperty);
  end;

 TDataDriverEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;


var
  MemTableFieldsEditor: TMemTableFieldsEditorEh;
{$ENDIF}

{$IFDEF FPC}
procedure ShowFieldsEditorEh(Designer: TComponentEditorDesigner; MemTable: TCustomMemTableEh;
  MemTableEditor: TMemTableEditorEh);
function CreateFieldsEditorEh(Designer: TComponentEditorDesigner; MemTable: TCustomMemTableEh;
  MemTableEditor: TMemTableEditorEh; var Shared: Boolean): TMemTableFieldsEditorEh;
{$ELSE}
procedure ShowFieldsEditorEh(Designer: IDesigner; MemTable: TCustomMemTableEh;
  DesignerClass: TDSDesignerClass);
function CreateFieldsEditorEh(Designer: IDesigner; MemTable: TCustomMemTableEh;
  DesignerClass: TDSDesignerClass; var Shared: Boolean): TMemTableFieldsEditorEh;
{$ENDIF}

procedure Register;

implementation

uses Clipbrd,
  MemTableEditEh, DataDriverEh, TypInfo, EhLibDesignAbout, DBAxisGridsEh,
{$IFDEF CIL}
  Borland.Vcl.Design.FldLinks,
{$ELSE}
  {$IFDEF FPC}
  {$ELSE}
  SQLDriverEditEh, ToolsAPI,
  EhLibDesignEditFavouriteComponents,
  {$ENDIF}
{$ENDIF}
  EhLibReg;

{$IFDEF FPC}
{$ELSE}
type
  TCustomDBGridEhCrack = class(TCustomDBGridEh);
{$ENDIF}

//{$IFDEF FPC}
//{$ELSE}
//{$R *.dfm}
//{$ENDIF}

procedure Register;
begin
  RegisterComponents('EhLib Components', [TMemTableEh]);
  RegisterComponents('EhLib Components', [TDataSetDriverEh, TSQLDataDriverEh]);
  RegisterComponents('EhLib Components', [TSQLConnectionProviderEh]);

  RegisterClasses([TMTStringFieldEh]);
  RegisterClasses([TRefObjectField]);

  RegisterComponentEditor(TCustomMemTableEh, TMemTableEditorEh);

{$IFDEF FPC}
{$ELSE}
  RegisterFields([TMTStringFieldEh]);
  RegisterFields([TRefObjectField]);

  RegisterComponentEditor(TDataSource, TDataSourceEditor);
  RegisterComponentEditor(TSQLDataDriverEh, TSQLDataDriverEhEditor);
  RegisterComponentEditor(TDataSetDriverEh, TDataSetDriverEhEditor);


  RegisterPropertyEditor(TypeInfo(string), TCustomMemTableEh, 'MasterFields', TMemTableFieldLinkProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomMemTableEh, 'DetailFields', TMemTableFieldLinkProperty);
  RegisterPropertyEditor(TypeInfo(TSQLCommandEh), TSQLDataDriverEh, '', TSQLCommandProperty);
  RegisterPropertyEditor(TypeInfo(string), TConnectionProviderEh, 'ServerType', TServerTypePropertyEditor);

  RegisterSelectionEditor(TDataDriverEh, TDataDriverEhSelectionEditor);
  RegisterSelectionEditor(TMemTableEh, TDataDriverEhSelectionEditor);
{$ENDIF}

end;

function GetLoadFromFileName: String;
var
  od: TOpenDialog;
begin
  Result := '';
  od := TOpenDialog.Create(nil);
  try
    od.Title := 'Open File';
    od.DefaultExt := 'dfm';
    od.Filter := 'Delphi Form files (*.dfm)|*.dfm';
    if od.Execute then
      Result := od.FileName;
  finally
    od.Free;
  end;
end;

function LoadFromFile(ADataSet: TCustomMemTableEh): Boolean;
var
  FileName: string;
begin
  FileName := GetLoadFromFileName;
  Result := FileName <> '';
  if Result then
    ADataSet.LoadFromFile(FileName);
end;

procedure SaveToFile(ADataSet: TCustomMemTableEh);
var
  sd: TOpenDialog;
begin
  sd := TSaveDialog.Create(nil);
  try
    sd.Options := sd.Options + [ofOverwritePrompt];
    sd.DefaultExt := 'dfm';
    sd.Filter := 'Delphi Form files (*.dfm)|*.dfm';
    if sd.Execute then
      ADataSet.SaveToFile(sd.FileName);
  finally
    sd.Free;
  end;
end;

{$IFDEF FPC}
{$ELSE}
{ TMTDesigner }

type

  TMTDesigner = class(TDSDesigner)
  public
    function SupportsAggregates: Boolean; override;
    function SupportsInternalCalc: Boolean; override;
    procedure BeginUpdateFieldDefs; override;
  end;

{ TMTDesigner }

function TMTDesigner.SupportsAggregates: Boolean;
begin
  Result := True;
end;

function TMTDesigner.SupportsInternalCalc: Boolean;
begin
  Result := True;
end;

procedure TMTDesigner.BeginUpdateFieldDefs;
begin
  if FieldsEditor.Dataset.Active then
    ShowMessage('Close DataSet before adding new fields');
end;
{$ENDIF}

{ TMemTableEditorEh }

destructor TMemTableEditorEh.Destroy;
begin
  FreeAndNil(FDataDriversList);
  inherited Destroy;
end;

procedure TMemTableEditorEh.CheckComponent(const Value: string);
var
  AComponent: TComponent;
begin
  {$IFDEF FPC}
  AComponent := Designer.PropertyEditorHook.GetComponent(Value);
  {$ELSE}
  AComponent := Designer.GetComponent(Value);
  {$ENDIF}
  if (AComponent.Owner <> Component.Owner) then
    FDataDriversList.AddObject(Concat(AComponent.Owner.Name, '.', AComponent.Name), AComponent)
  else
    if AnsiCompareText(AComponent.Name, Component.Name) <> 0 then
      FDataDriversList.AddObject(AComponent.Name, AComponent);
end;

{$IFDEF FPC}
{$ELSE}
function TMemTableEditorEh.GetDSDesignerClass: TDSDesignerClass;
begin
  Result := TMTDesigner;
end;
{$ENDIF}

procedure TMemTableEditorEh.ExecuteVerb(Index: Integer);
var
  mt: TCustomMemTableEh;
begin
  mt := TCustomMemTableEh(Component);
  case Index of
    0:
      {$IFDEF FPC}
      ShowFieldsEditorEh(Designer, mt, Self);
      {$ELSE}
      ShowFieldsEditorEh(Designer, mt, GetDSDesignerClass);
      {$ENDIF}

    1:
      begin
        mt.FetchParams;
        Designer.Modified;
      end;

    2:
      if EditMemTable(mt, Designer) then
        Designer.Modified;

    7:
      if LoadFromFile(mt) then
      begin
        mt.Open;
        Designer.Modified;
      end;

    8:
      SaveToFile(mt);

    10:
      ShowAboutForm;
  else
    if mt.Active then
      case Index of
        5:
          begin
            mt.DestroyTable;
            mt.FieldDefs.Clear;
            Designer.Modified;
          end;
      end
    else if ( (mt.FieldCount > 0) or
              (mt.FieldDefs.Count > 0)
            ) and
              not mt.Active
    then
      case Index of
        6:
          begin
            mt.CreateDataSet;
            Designer.Modified;
          end;
      end;
  end;
end;

function TMemTableEditorEh.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Fields Editor...';
    1: Result := 'Fetch Params';
    2: Result := 'Assign Local Data...';
    3: Result := 'Create DataDriver as';
    4: Result := 'Assign DataDriver by';
    5: Result := 'Clear Data';
    6: Result := 'Create DataSet Struct';
    7: Result := 'Load from file...';
    8: Result := 'Save to file...';

    9: Result := '-';
    10: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TMemTableEditorEh.GetVerbCount: Integer;
begin
  Result := 11;
end;

{$IFDEF FPC}
procedure TMemTableEditorEh.PrepareItem(Index: Integer; const AItem: TMenuItem);
//var
  //LMenuItem: TMenuItem;
begin
{$ELSE}
procedure TMemTableEditorEh.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  lst: TStrings;
  i: Integer;
  LMenuItem: IMenuItem;
  S: String;
begin
{$ENDIF}
  inherited PrepareItem(Index, AItem);

  case Index of
    3:
      begin
        {$IFDEF FPC}
        {$ELSE}
        FMenuItem := AItem;
        DDRPropName := 'DataDriver';
        lst := TStringList.Create;
        GetComponentNamesEh(lst, TDataDriverEh, False);
        for i := 0 to lst.Count-1 do
        begin
          LMenuItem := AItem.AddItem(lst[i], 0, False, True, HandleCreateDataDriverSubMenu);
          LMenuItem.Tag := LongInt(lst.Objects[i]);
        end;
        lst.Free;
        FMenuItem := nil;
        {$ENDIF}
      end;

    4:
      begin
        {$IFDEF FPC}
        {$ELSE}
        if FDataDriversList = nil then
          FDataDriversList := TStringList.Create;
        FMenuItem := AItem;
        begin
          DDRPropName := 'DataDriver';

          FDataDriversList.Clear;
          Designer.GetComponentNames(GetTypeData(TDataDriverEh.ClassInfo), CheckComponent);

          for i := 0 to FDataDriversList.Count-1 do
          begin
            S := FDataDriversList[i] + ': ' + FDataDriversList.Objects[i].ClassName;
            if FDataDriversList.Objects[i] = TCustomMemTableEh(Component).DataDriver then
              S := S + ' (assigned)';
            LMenuItem := AItem.AddItem(S, 0, False, True, HandleAssignDataDriverSubMenu);
            LMenuItem.Tag := LongInt(FDataDriversList.Objects[i]);
          end;

        end;
        FMenuItem := nil;
        {$ENDIF}
      end;

    5: 
      begin
        AItem.Visible := TDataSet(Component).Active;
      end;
    6: 
      begin
        AItem.Visible := ((TDataSet(Component).FieldCount > 0) or
             (TDataSet(Component).FieldDefs.Count > 0)) and
            not TDataSet(Component).Active;
      end;
  end;
end;

procedure TMemTableEditorEh.HandleCreateDataDriverSubMenu(Sender: TObject);
{$IFDEF FPC}
begin
end;
{$ELSE}
var
  MenuItem: TMenuItem;
  DataDriverClass: TComponentClass;
  NewComponent: TComponent;
  ABaseComponent: TComponent;
  ADDRPropName: String;
begin
  MenuItem := TMenuItem(Sender);
  DataDriverClass := TComponentClass(MenuItem.Tag);
  ABaseComponent := Component;
  ADDRPropName := DDRPropName;
  NewComponent := Designer.CreateComponent(DataDriverClass, Component.Owner, 0, 0, 0, 0);
  SetObjectProp(ABaseComponent, ADDRPropName, NewComponent);
end;
{$ENDIF}

procedure TMemTableEditorEh.HandleAssignDataDriverSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataDriver: TComponent;
begin
  MenuItem := TMenuItem(Sender);
  DataDriver := TComponent(MenuItem.Tag);
  SetObjectProp(Component, DDRPropName, DataDriver);
  Designer.Modified;
end;

//{$IFDEF LINUX}
//function TMemTableEditorEh.GetThreadAffinity: TThreadAffinity;
//begin
//  Result  := taQT;
//end;
//
//procedure TMemTableEditorEh.Edit;
//begin
//  ShowFieldsEditorEh(Designer, TDataSet(Component), GetDSDesignerClass);
//end;
//{$ENDIF} //LINUX

{ Utility functions }

{$IFDEF FPC}
procedure ShowFieldsEditorEh(Designer: TComponentEditorDesigner; MemTable: TCustomMemTableEh;
  MemTableEditor: TMemTableEditorEh);
var
  FieldsEditor: TDSFieldsEditorFrm;
  vShared: Boolean;
begin
  FieldsEditor := CreateFieldsEditorEh(Designer, MemTable, MemTableEditor, vShared);
  if FieldsEditor <> nil then
    FieldsEditor.Show;
end;
{$ELSE}
procedure ShowFieldsEditorEh(Designer: IDesigner; MemTable: TCustomMemTableEh; DesignerClass: TDSDesignerClass);
var
  FieldsEditor: TFieldsEditor;
  vShared: Boolean;
begin
  FieldsEditor := CreateFieldsEditorEh(Designer, MemTable, DesignerClass, vShared);
  if FieldsEditor <> nil then
    FieldsEditor.Show;
end;
{$ENDIF}

{$IFDEF FPC}
function CreateFieldsEditorEh(Designer: TComponentEditorDesigner; MemTable: TCustomMemTableEh;
  MemTableEditor: TMemTableEditorEh; var Shared: Boolean): TMemTableFieldsEditorEh;
var
  AEditor: TMemTableFieldsEditorEh;
begin
  Shared := True;

  AEditor := TMemTableFieldsEditorEh(FindEditorForm(MemTable));
  if AEditor = nil then
  begin
    AEditor := TMemTableFieldsEditorEh.Create(Application, MemTable, Designer);
    RegisterEditorForm(AEditor, MemTable);
  end;

  if AEditor <> nil then
  begin
    AEditor.ComponentEditor := MemTableEditor;
    AEditor.ShowOnTop;
    AEditor.MemTable := MemTable;
  end;

  Result := AEditor;
end;
{$ELSE}
function CreateFieldsEditorEh(Designer: IDesigner; MemTable: TCustomMemTableEh;
  DesignerClass: TDSDesignerClass; var Shared: Boolean): TMemTableFieldsEditorEh;
begin
  Shared := True;
  if MemTable.Designer <> nil then
  begin
    Result := TMemTableFieldsEditorEh((MemTable.Designer as TDSDesigner).FieldsEditor);
  end
  else
  begin
    Result := TMemTableFieldsEditorEh.Create(Application);
    Result.DSDesignerClass := DesignerClass;
    Result.Designer := Designer;
    Result.MemTable := MemTable;
    Shared := False;
  end;
end;
{$ENDIF}

{$IFDEF FPC}
{$ELSE}

{ TSQLCommandProperty }

procedure TSQLCommandProperty.Edit;
var
  Command: TSQLCommandEh;
  FSQLCommandSel: IDesignerSelections;
begin
  FCommandTextProp := nil;
{$IFDEF CIL}
  Command := TSQLCommandEh(GetObjValue);
{$ELSE}
  Command := TSQLCommandEh(GetOrdValue);
{$ENDIF}
  FSQLCommandSel := CreateSelectionList;
  FSQLCommandSel.Add(Command);
  GetComponentProperties(FSQLCommandSel, [tkClass], Designer, SetCommandTextProp, nil);
  if FCommandTextProp <> nil then
    FCommandTextProp.Edit;
end;

function TSQLCommandProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TSQLCommandProperty.SetCommandTextProp(const Prop: IProperty);
begin
  if Prop.GetName = 'CommandText' then
    FCommandTextProp := Prop;
end;

{ TMemTableFieldLinkProperty }

procedure TMemTableFieldLinkProperty.Edit;
begin
  FMemTable := DataSet as TMemTableEh;
  inherited Edit;
end;

function TMemTableFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := FMemTable.DetailFields;
end;

function TMemTableFieldLinkProperty.GetMasterFields: string;
begin
  Result := FMemTable.MasterFields;
end;

procedure TMemTableFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  FMemTable.DetailFields := Value;
end;

procedure TMemTableFieldLinkProperty.SetMasterFields(const Value: string);
begin
  FMemTable.MasterFields := Value;
end;

{ TDataSourceEditor }

destructor TDataSourceEditor.Destroy;
begin
  FreeAndNil(FDataSetList);
  inherited Destroy;
end;

procedure TDataSourceEditor.CheckComponent(const Value: string);
var
  AComponent: TComponent;
begin
  AComponent := Designer.GetComponent(Value);
  if (AComponent.Owner <> Component.Owner) then
    FDataSetList.AddObject(Concat(AComponent.Owner.Name, '.', AComponent.Name), AComponent)
  else
    if AnsiCompareText(AComponent.Name, Component.Name) <> 0 then
      FDataSetList.AddObject(AComponent.Name, AComponent);
end;

procedure TDataSourceEditor.ExecuteVerb(Index: Integer);
begin
  inherited ExecuteVerb(Index);
end;

function TDataSourceEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Create DataSet as';
    1: Result := 'Assign DataSet by';
  end;
end;

function TDataSourceEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

procedure TDataSourceEditor.HandleCreateDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSetClass: TComponentClass;
  NewComponent: TComponent;
  ABaseComponent: TComponent;
  ADDRPropName: String;
  ADesigner: IDesigner;
  slFavourite, slAll: TStringList;
begin
  MenuItem := TMenuItem(Sender);
  if MenuItem.Caption = 'Change Favorite DataSets...' then
  begin
    slFavourite := TStringList.Create;
    slAll := TStringList.Create;

    GetComponentNamesEh(slAll, TDataSet, False);

    GetFavouriteComponentList(TDataSet, slFavourite, False);
    if SelectFavouriteComponentList(slFavourite, slAll) then
      SetFavouriteComponentList(TDataSet, slFavourite);

    slFavourite.Free;
    slAll.Free;
  end else
  begin
    DataSetClass := TComponentClass(MenuItem.Tag);
    ABaseComponent := Component;
    ADDRPropName := DDRPropName;
    ADesigner := Designer;
    NewComponent := Designer.CreateComponent(DataSetClass, Component.Owner, 0, 0, 0, 0);
    SetObjectProp(ABaseComponent, ADDRPropName, NewComponent);
    ADesigner.Modified;
  end;
end;

procedure TDataSourceEditor.HandleAssignDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSet: TComponent;
begin
  MenuItem := TMenuItem(Sender);
  DataSet := TComponent(MenuItem.Tag);
  SetObjectProp(Component, DDRPropName, DataSet);
  Designer.Modified;
end;

procedure TDataSourceEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  lst: TStringList;
  i: Integer;
  LMenuItem: IMenuItem;
  S: String;
  FullLst: TStringList;
begin
  inherited PrepareItem(Index, AItem);

  case Index of
    0:
      begin
        FMenuItem := AItem;
        if FMenuItem = nil then Exit;

        begin
          DDRPropName := 'DataSet';
          lst := TStringList.Create;
          GetFavouriteComponentList(TDataSet, lst, True);

          FullLst := TStringList.Create;
          GetComponentNamesEh(FullLst, TDataSet, False, Component, 'DataSet');

          for i := lst.Count-1 downto 0 do
          begin
            if FullLst.IndexOf(lst[i]) < 0 then
            begin
              lst.Delete(i);
            end;
          end;

          if lst.Count = 0 then
            lst.AddObject('TMemTableEh', TObject(TMemTableEh))
          else
          begin
            i := lst.IndexOf('TMemTableEh');
            if i >= 0 then
            begin
              if (i > 0) and (lst[i-1] = '-') then
                lst.Move(i-1, 0);
              lst.Move(i, 0);
            end;
          end;

          for i := 0 to lst.Count-1 do
          begin
            LMenuItem := AItem.AddItem(lst[i], 0, False, True, HandleCreateDataSetSubMenu);
            LMenuItem.Tag := LongInt(lst.Objects[i]);
          end;
          lst.Free;
          FullLst.Free;

          LMenuItem := AItem.AddItem('-', 0, False, True, HandleCreateDataSetSubMenu);

          LMenuItem := AItem.AddItem('Change Favorite DataSets...', 0, False, True, HandleCreateDataSetSubMenu);
          LMenuItem.Tag := LongInt(TDataSet);

        end;
        FMenuItem := nil;
      end;

    1:
      begin
        if FDataSetList = nil then
          FDataSetList := TStringList.Create;
        FMenuItem := AItem;
        begin
          DDRPropName := 'DataSet';

          FDataSetList.Clear;
          Designer.GetComponentNames(GetTypeData(TDataSet.ClassInfo), CheckComponent);

          for i := 0 to FDataSetList.Count-1 do
          begin
            S := FDataSetList[i] + ': ' + FDataSetList.Objects[i].ClassName;
            if FDataSetList.Objects[i] = TDataSource(Component).DataSet then
              S := S + ' (assigned)';
            LMenuItem := AItem.AddItem(S, 0, False, True, HandleAssignDataSetSubMenu);
            LMenuItem.Tag := LongInt(FDataSetList.Objects[i]);
          end;

        end;
        FMenuItem := nil;
      end;
  end;
end;

{ TSQLDataDriverEhEditor }

procedure TSQLDataDriverEhEditor.ExecuteVerb(Index: Integer);
begin
  EditSQLDataDriverEh(Component as TCustomSQLDataDriverEh, Designer);
end;

function TSQLDataDriverEhEditor.GetVerb(Index: Integer): string;
begin
  Result := 'UpdateSQL Editor...';
end;

function TSQLDataDriverEhEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TDataDriverEhSelectionEditor }

procedure TDataDriverEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('MemTableDataEh');
{$IFDEF EH_LIB_16}
   Proc('Data.DB');
{$ELSE}
   Proc('Db');
{$ENDIF}
end;

{$ENDIF}

{ TMemTableFieldsEditorEh }

{$IFDEF FPC}
constructor TMemTableFieldsEditorEh.Create(AOwner: TComponent; ADataset: TDataset;
 ADesigner: TComponentEditorDesigner);
begin
  inherited Create(AOwner, ADataset, ADesigner);
  FDataset := ADataset;
{$ELSE}
constructor TMemTableFieldsEditorEh.Create(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited Create(AOwner);

  if ParentFont then
  begin
    NonClientMetrics.cbSize := sizeof(NonClientMetrics);

{$IFDEF CIL}
{$ELSE}
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
      Font.Name := NonClientMetrics.lfMessageFont.lfFaceName;
{$ENDIF}
  end;

{$ENDIF}

  InitDfmDataInCode;
end;

destructor TMemTableFieldsEditorEh.Destroy;
begin
//  FreeAndNil(ChStruct);
  inherited Destroy;
end;

procedure TMemTableFieldsEditorEh.InitDfmDataInCode;
begin
  Width := 350;
  FMemTableEditorFrame := TMemTableDesignFrame.Create(Self);
  FMemTableEditorFrame.Parent := Self;
  FMemTableEditorFrame.Align := alClient;

  {$IFDEF FPC}
  FDataSource := TDataSource.Create(Self);
  DataSource.DataSet := Dataset;

  FieldsListBox.Parent := MemTableEditorFrame.TabSheet1;
  tbCommands.Parent := MemTableEditorFrame.TabSheet1;
  PopupMenu := nil;
  FieldsListBox.PopupMenu := PopupMenu1;

  {$ELSE}
  AggListBox.Parent := MemTableEditorFrame.TabSheet1;
  FieldListBox.Parent := MemTableEditorFrame.TabSheet1;
  Splitter1.Parent := MemTableEditorFrame.TabSheet1;
  Splitter1.Top := 0;
  DBNavigator.VisibleButtons := [nbFirst..nbRefresh];
  PopupMenu := nil;
  FieldListBox.PopupMenu := LocalMenu;
  Panel1.Parent := MemTableEditorFrame.TabSheet2;
  DataSource.OnDataChange := MemTableEditorFrame.DataSourceDataChange;
  {$ENDIF}
end;

{$IFDEF FPC}
{$ELSE}
function TMemTableFieldsEditorEh.GetEditState: TEditState;
var
  Grid: TCustomDBGridEhCrack;
begin
  if MemTableEditorFrame.PageControl1.ActivePage = MemTableEditorFrame.TabSheet1 then
    Result := inherited GetEditState
  else
  begin
    if ActiveControl is TCustomDBGridEh then
    begin
      Grid := TCustomDBGridEhCrack(ActiveControl);
      Result := [];
      if Clipboard.HasFormat(CF_TEXT) then Result := [esCanPaste];
      if Grid.EditorMode then
{$IFDEF CIL}
{$ELSE}
        Result := GetEditStateFor(Grid.InplaceEditor.EditCoreControl)
{$ENDIF}
      else
        Result := Result + [esCanCopy, esCanSelectAll];
    end;
  end;
end;

function TMemTableFieldsEditorEh.EditAction(Action: TEditAction): Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  if MemTableEditorFrame.PageControl1.ActivePage = MemTableEditorFrame.TabSheet1 then
    Result := inherited EditAction(Action)
  else
  begin
    Result := False;
    if ActiveControl is TCustomDBGridEh then
    begin
      Grid := TCustomDBGridEhCrack(ActiveControl);
      Result := True;
      if Grid.EditorMode then
{$IFDEF CIL}
{$ELSE}
        Result := EditActionFor(Grid.InplaceEditor.EditCoreControl, Action)
{$ENDIF}
      else
        case Action of
          eaCut: DBGridEh_DoCutAction(Grid, False);
          eaCopy: DBGridEh_DoCopyAction(Grid, False);
          eaPaste: DBGridEh_DoPasteAction(Grid, False);
          eaSelectAll: Grid.Selection.SelectAll;
        else
          Result := False;
        end;
    end;
  end;
end;
{$ENDIF}

procedure TMemTableFieldsEditorEh.EditorActivated;
begin
  {$IFDEF FPC}
  {$ELSE}
  Activated;
  {$ENDIF}
end;

function TMemTableFieldsEditorEh.GetMemTableEh: TCustomMemTableEh;
begin
  {$IFDEF FPC}
  Result := TCustomMemTableEh(DataSet);
  {$ELSE}
  Result := TCustomMemTableEh(DataSet);
  {$ENDIF}
end;

procedure TMemTableFieldsEditorEh.SetMemTableEh(Value: TCustomMemTableEh);
begin
  {$IFDEF FPC}
  FDataSet := Value;
  {$ELSE}
  DataSet := Value;
  {$ENDIF}
  MemTableEditorFrame.DBGridEh1.DataSource := DataSource;
  MemTableEditorFrame.MTNotificator.DataObject := Value.RecordsView.MemTableData;
  MemTableEditorFrame.UpdateStructureList;
end;

{$IFDEF FPC}
{$ELSE}
{ TServerTypePropertyEditor }

function TServerTypePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TServerTypePropertyEditor.GetValues(Proc: TGetStrProc);
var
  ConProv: TConnectionProviderEh;
  i: Integer;
begin
  ConProv := GetComponent(0) as TConnectionProviderEh;
  for i := 0 to ConProv.ServerTypesCount-1 do
  begin
    Proc(ConProv.ServerTypes[i]);
  end;
end;

{ TDataSetDriverEhEditor }

procedure TDataSetDriverEhEditor.CheckComponent(const Value: string);
var
  AComponent: TComponent;
begin
  AComponent := Designer.GetComponent(Value);
  if (AComponent.Owner <> Component.Owner) then
    FDataSetList.AddObject(Concat(AComponent.Owner.Name, '.', AComponent.Name), AComponent)
  else
    if AnsiCompareText(AComponent.Name, Component.Name) <> 0 then
      FDataSetList.AddObject(AComponent.Name, AComponent);
end;

destructor TDataSetDriverEhEditor.Destroy;
begin
  FreeAndNil(FDataSetList);
  inherited Destroy;
end;

procedure TDataSetDriverEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: inherited ExecuteVerb(Index);
    1: inherited ExecuteVerb(Index);
    2: ;
    3: ShowAboutForm;
  end;
end;

function TDataSetDriverEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Create ProviderDataSet as';
    1: Result := 'Assign ProviderDataSet by';
    2: Result := '-';
    3: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TDataSetDriverEhEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

procedure TDataSetDriverEhEditor.HandleAssignDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSet: TComponent;
begin
  MenuItem := TMenuItem(Sender);
  DataSet := TComponent(MenuItem.Tag);
  SetObjectProp(Component, DDRPropName, DataSet);
  Designer.Modified;
end;

procedure TDataSetDriverEhEditor.HandleCreateDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSetClass: TComponentClass;
  NewComponent: TComponent;
  ABaseComponent: TComponent;
  ADDRPropName: String;
begin
  MenuItem := TMenuItem(Sender);
  DataSetClass := TComponentClass(MenuItem.Tag);
  ABaseComponent := Component;
  ADDRPropName := DDRPropName;
  NewComponent := Designer.CreateComponent(DataSetClass, Component.Owner, 0, 0, 0, 0);
  SetObjectProp(ABaseComponent, ADDRPropName, NewComponent);
end;

procedure TDataSetDriverEhEditor.PrepareItem(Index: Integer;
  const AItem: IMenuItem);
var
  lst: TStrings;
  i: Integer;
  LMenuItem: IMenuItem;
  S: String;
begin
  inherited PrepareItem(Index, AItem);

  case Index of
    0:
      begin
        FMenuItem := AItem;
        begin
          DDRPropName := 'ProviderDataSet';
          lst := TStringList.Create;
          GetComponentNamesEh(lst, TDataSet, True);
          i := lst.IndexOf('TMemTableEh');
          if i >= 0 then
          begin
            lst.Move(i, 0);
          end;
          for i := 0 to lst.Count-1 do
          begin
            LMenuItem := AItem.AddItem(lst[i], 0, False, True, HandleCreateDataSetSubMenu);
            LMenuItem.Tag := LongInt(lst.Objects[i]);
          end;
          lst.Free;

        end;
        FMenuItem := nil;
      end;

    1:
      begin
        if FDataSetList = nil then
          FDataSetList := TStringList.Create;
        FMenuItem := AItem;
        begin
          DDRPropName := 'ProviderDataSet';

          FDataSetList.Clear;
          Designer.GetComponentNames(GetTypeData(TDataSet.ClassInfo), CheckComponent);

          for i := 0 to FDataSetList.Count-1 do
          begin
            S := FDataSetList[i] + ': ' + FDataSetList.Objects[i].ClassName;
            if FDataSetList.Objects[i] = TDataSetDriverEh(Component).ProviderDataSet then
              S := S + ' (assigned)';
            LMenuItem := AItem.AddItem(S, 0, False, True, HandleAssignDataSetSubMenu);
            LMenuItem.Tag := LongInt(FDataSetList.Objects[i]);
          end;

        end;
        FMenuItem := nil;
      end;
  end;
end;
{$ENDIF}

end.

