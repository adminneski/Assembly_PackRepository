{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                 TCompChildrenEditor form              }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ComponentChildrenDesignEditorsEh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, ToolWin, Contnrs,
{$IFDEF EH_LIB_17} System.UITypes, System.Types, {$ENDIF}
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, MemTableDataEh,
  ObjectInspectorEh,
{$IFDEF DESIGNTIME}
  DesignIntf, DesignEditors, VCLEditors, ToolsAPI, DesignWindows,
{$ENDIF}
  DB, MemTableEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
{$IFDEF DESIGNTIME}
  TCompChildrenEditor = class(TDesignWindow)
{$ELSE}
  TCompChildrenEditor = class(TForm)
{$ENDIF}
    ToolBar1: TToolBar;
    tbAdd: TToolButton;
    tlDel: TToolButton;
    ToolButton3: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDOwn: TToolButton;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    MemTableEh1CompName: TStringField;
    MemTableEh1RefComp: TRefObjectField;
    procedure tbAddClick(Sender: TObject);
    procedure tlDelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbMoveUpClick(Sender: TObject);
    procedure tbMoveDOwnClick(Sender: TObject);
  private
    FMasterComponent: TComponent;
    FChilderList: TObjectListEh;
    FInSelection: Boolean;
    FClosing: Boolean;

    procedure SetMasterComponent(const Value: TComponent);
    procedure AddOneChildToList(Child: TComponent);
    procedure CheckUpdateList(Item: TPersistent);

  public
    function SelectNewChildClass: TComponentClass; virtual;
    function CreateChild(ChildClass: TComponentClass): TComponent;

    procedure InitForm;
    procedure UpdateList;
    procedure UpdateChildrenList;
    procedure UpdateCaption;
    procedure CloseEditor;

{$IFDEF DESIGNTIME}
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); override;
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean); override;
{$ENDIF}

    property MasterComponent: TComponent read FMasterComponent write SetMasterComponent;
  end;

{ TCompChildrenDesignServiceEh }

  TCompChildrenDesignServiceEh = class
    class procedure GetChildClasses(ClassList: TClassList); virtual;
    class function CreateChild(MasterComponent: TComponent; ChildClass: TComponentClass): TComponent; virtual;
    class function GetFormCaption(MasterComponent: TComponent): String; virtual;
    class procedure MoveChildUp(MasterComponent: TComponent; ChildComponent: TComponent); virtual;
    class procedure MoveChildDown(MasterComponent: TComponent; ChildComponent: TComponent); virtual;
  end;

  TCompChildrenDesignServiceClassEh = class of TCompChildrenDesignServiceEh;

function ShowComponentChildrenEditor(
{$IFDEF DESIGNTIME}
  ADesigner: IDesigner;
{$ENDIF}
  AMasterComponent: TComponent): TCompChildrenEditor;

procedure RegisterCompChildrenDesignService(ComponentClass: TComponentClass; DesignServiceClass: TCompChildrenDesignServiceClassEh);
procedure UnregisterCompChildrenDesignService(DesignServiceClass: TCompChildrenDesignServiceClassEh);
function GetDesignServiceByClass(ComponentClass: TComponentClass): TCompChildrenDesignServiceClassEh;

implementation

uses ComponentChildrenDesignSelectClassDialogEh, DBConsts;

{$R *.dfm}

type
  TComponentCrack = class(TComponent);

var
  ChildrenEditorsList: TObjectListEh = nil;
  ChildrenDesignServiceList: TObjectListEh = nil;

type

  TChildrenDesignServiceKey = class(TPersistent)
  public
    ComponentClass: TComponentClass;
    DesignServiceClass: TCompChildrenDesignServiceClassEh;
  end;

{$IFDEF DESIGNTIME}

type

  TImpExpListEhEditor = class(TComponentEditor)
    function  GetVerbCount: Integer; override;
    function  GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

function TImpExpListEhEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TImpExpListEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Children editor...';
  end;
end;

procedure TImpExpListEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 :
      ShowComponentChildrenEditor(Designer, Component);
  end;
end;

{$ENDIF}

function ShowComponentChildrenEditor(
{$IFDEF DESIGNTIME}
  ADesigner: IDesigner;
{$ENDIF}
  AMasterComponent: TComponent): TCompChildrenEditor;
var
  I: Integer;
begin
  if ChildrenEditorsList = nil then
    ChildrenEditorsList := TObjectListEh.Create;

  for I := 0 to ChildrenEditorsList.Count-1 do
  begin
    Result := TCompChildrenEditor(ChildrenEditorsList[I]);
{$IFDEF DESIGNTIME}
      if (Result.Designer = ADesigner) and (Result.MasterComponent = AMasterComponent) then
{$ENDIF}
      begin
        Result.Show;
        Result.BringToFront;
        Exit;
      end;
  end;

  Result := TCompChildrenEditor.Create(Application);
  try
{$IFDEF DESIGNTIME}
    Result.Designer := ADesigner;
{$ENDIF}
    Result.MasterComponent := AMasterComponent;
    Result.Show;
  except
    Result.Free;
  end;
end;

procedure RegisterCompChildrenDesignService(ComponentClass: TComponentClass; DesignServiceClass: TCompChildrenDesignServiceClassEh);
var
  ADesignServiceKey: TChildrenDesignServiceKey;
begin
  ADesignServiceKey := TChildrenDesignServiceKey.Create;
  ADesignServiceKey.ComponentClass := ComponentClass;
  ADesignServiceKey.DesignServiceClass := DesignServiceClass;

  if ChildrenDesignServiceList = nil then
    ChildrenDesignServiceList := TObjectListEh.Create;

  ChildrenDesignServiceList.Add(ADesignServiceKey);
end;

procedure UnregisterCompChildrenDesignService(DesignServiceClass: TCompChildrenDesignServiceClassEh);
var
  i: Integer;
  ServiceKey: TChildrenDesignServiceKey;
begin
  for i := 0 to ChildrenDesignServiceList.Count-1 do
  begin
    if TChildrenDesignServiceKey(ChildrenDesignServiceList[i]).DesignServiceClass = DesignServiceClass then
    begin
      ServiceKey := TChildrenDesignServiceKey(ChildrenDesignServiceList[i]);
      ChildrenDesignServiceList[i] := nil;
      ServiceKey.Free;
    end;
  end;
end;

function GetDesignServiceByClass(ComponentClass: TComponentClass): TCompChildrenDesignServiceClassEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ChildrenDesignServiceList.Count-1 do
  begin
    if TChildrenDesignServiceKey(ChildrenDesignServiceList[i]).ComponentClass = ComponentClass then
    begin
      Result := TChildrenDesignServiceKey(ChildrenDesignServiceList[i]).DesignServiceClass;
      Exit;
    end;
  end;
end;

{ TCompChildrenEditor }

procedure TCompChildrenEditor.DataSource1DataChange(Sender: TObject;
  Field: TField);
{$IFDEF DESIGNTIME}
var
  Child: TComponent;
{$ENDIF}
begin
  if FInSelection then Exit;

  FInSelection := True;
  try
  if not MemTableEh1.IsEmpty then
  begin
{$IFDEF DESIGNTIME}
    Child := TComponent(MemTableEh1RefComp.Value);
    Designer.SelectComponent(Child);
{$ENDIF}
  end;
  finally
    FInSelection := False;
  end;
end;

procedure TCompChildrenEditor.FormCreate(Sender: TObject);
begin
  FChilderList := TObjectListEh.Create;
  ChildrenEditorsList.Add(Self);
end;

procedure TCompChildrenEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCompChildrenEditor.FormDestroy(Sender: TObject);
begin
  if ChildrenEditorsList <> nil then
    ChildrenEditorsList.Remove(Self);
  FreeAndNil(FChilderList);
end;

procedure TCompChildrenEditor.InitForm;
begin
  if FClosing then Exit;
  MemTableEh1.Open;
  UpdateList;
  UpdateCaption;
end;

procedure TCompChildrenEditor.CloseEditor;
begin
  FClosing := True;
  MasterComponent := nil;
  Close;
end;

{$IFDEF DESIGNTIME}
procedure TCompChildrenEditor.ItemDeleted(const ADesigner: IDesigner;
  Item: TPersistent);
begin
  if (Item = nil) or FClosing then Exit;
  inherited ItemDeleted(ADesigner, Item);
  if Item = MasterComponent then
  begin
    FMasterComponent := nil;  
    Close;
  end else
    CheckUpdateList(Item);
end;

procedure TCompChildrenEditor.DesignerClosed(const ADesigner: IDesigner;
  AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

{$ENDIF}

procedure TCompChildrenEditor.AddOneChildToList(Child: TComponent);
begin
  FChilderList.Add(Child);
end;

procedure TCompChildrenEditor.UpdateCaption;
var
  DesignService: TCompChildrenDesignServiceClassEh;
begin
  DesignService := GetDesignServiceByClass(TComponentClass(MasterComponent.ClassType));
  Caption := DesignService.GetFormCaption(MasterComponent);
end;

procedure TCompChildrenEditor.UpdateChildrenList;
begin
  FChilderList.Clear;
  if MasterComponent <> nil then
    TComponentCrack(MasterComponent).GetChildren(AddOneChildToList, MasterComponent.Owner);
end;

procedure TCompChildrenEditor.CheckUpdateList(Item: TPersistent);
var
  i: Integer;
  Rec: TMemoryRecordEh;
  Comp: TComponent;
  RefObj: TObject;
  RefCompVal: Variant;
begin
  for i := 0 to MemTableEh1.RecordsView.MemTableData.RecordsList.Count-1 do
  begin
    Rec := MemTableEh1.RecordsView.MemTableData.RecordsList.Rec[i];
    RefCompVal := Rec.DataValues['RefComp', dvvValueEh];
    RefObj := VariantToRefObject(RefCompVal);
    Comp := RefObj as TComponent;
    if Comp = Item then
    begin
      UpdateList;
      Exit;
    end;
  end;
end;

procedure TCompChildrenEditor.UpdateList;
var
  i: Integer;
  ChildItem: TComponent;
begin
  if FInSelection then Exit;

  FInSelection := True;
  try
    UpdateChildrenList;
    ChildItem := TComponent(MemTableEh1RefComp.Value);
    MemTableEh1.DisableControls;
    try
      MemTableEh1.EmptyTable;
      for i := 0 to FChilderList.Count-1 do
      begin
        MemTableEh1.Append;
        MemTableEh1CompName.AsString := TComponent(FChilderList[i]).Name + ': ' + TComponent(FChilderList[i]).ClassName;
        MemTableEh1RefComp.Value := FChilderList[i];
        MemTableEh1.Post;
      end;
      
      MemTableEh1.Locate('RefComp', RefObjectToVariant(ChildItem), []);
    finally
      MemTableEh1.EnableControls;
    end;
  finally
    FInSelection := False;
  end;
end;

procedure TCompChildrenEditor.SetMasterComponent(const Value: TComponent);
begin
  FMasterComponent := Value;
  InitForm;
end;

function TCompChildrenEditor.SelectNewChildClass: TComponentClass;
begin
  Result := nil;
end;

function TCompChildrenEditor.CreateChild(ChildClass: TComponentClass): TComponent;
var
  DesignService: TCompChildrenDesignServiceClassEh;
begin
  DesignService := GetDesignServiceByClass(TComponentClass(MasterComponent.ClassType));
  Result := DesignService.CreateChild(MasterComponent, ChildClass);
end;

procedure TCompChildrenEditor.tbAddClick(Sender: TObject);
var
  ChildClass: TComponentClass;
begin
  ChildClass := SelectComponentChildEhClass(TComponentClass(MasterComponent.ClassType));
  if ChildClass <> nil then
  begin
    CreateChild(ChildClass);
    UpdateList;
  end;
end;

procedure TCompChildrenEditor.tbMoveDOwnClick(Sender: TObject);
var
  DesignService: TCompChildrenDesignServiceClassEh;
begin
  DesignService := GetDesignServiceByClass(TComponentClass(MasterComponent.ClassType));
  DesignService.MoveChildDown(MasterComponent, TComponent(MemTableEh1RefComp.Value));
  UpdateList;
end;

procedure TCompChildrenEditor.tbMoveUpClick(Sender: TObject);
var
  DesignService: TCompChildrenDesignServiceClassEh;
begin
  DesignService := GetDesignServiceByClass(TComponentClass(MasterComponent.ClassType));
  DesignService.MoveChildUp(MasterComponent, TComponent(MemTableEh1RefComp.Value));
  UpdateList;
end;

procedure TCompChildrenEditor.tlDelClick(Sender: TObject);
var
  Msg: String;
  Child: TComponent;
begin
  Msg := SDeleteRecordQuestion;
  if not MemTableEh1.IsEmpty then
  begin
    Child := TComponent(MemTableEh1RefComp.Value);
    if MessageDlg('Do you want to Delete ' + Child.Name, mtConfirmation, mbOKCancel, 0) <> mrCancel then
    begin
      MemTableEh1.Prior;
      Child.Free;
    end;
  end;
end;

{ TCompChildrenDesignServiceEh }

class function TCompChildrenDesignServiceEh.CreateChild(MasterComponent: TComponent;
  ChildClass: TComponentClass): TComponent;
begin
  Result := nil;
end;

class procedure TCompChildrenDesignServiceEh.GetChildClasses(ClassList: TClassList);
begin

end;

class function TCompChildrenDesignServiceEh.GetFormCaption(
  MasterComponent: TComponent): String;
begin
  Result := MasterComponent.Name + '.Childer Editor';
end;

class procedure TCompChildrenDesignServiceEh.MoveChildDown(MasterComponent,
  ChildComponent: TComponent);
begin

end;

class procedure TCompChildrenDesignServiceEh.MoveChildUp(MasterComponent,
  ChildComponent: TComponent);
begin

end;

initialization
finalization
  FreeAndNil(ChildrenEditorsList);
  FreeAndNil(ChildrenDesignServiceList);
end.
