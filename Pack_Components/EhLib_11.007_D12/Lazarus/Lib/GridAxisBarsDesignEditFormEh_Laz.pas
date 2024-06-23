{*******************************************************}
{                                                       }
{                     EhLib 10.2                        }
{                                                       }
{         TGridAxisBarsDesignEditForm component         }
{           The module is only used in Lazarus          }
{                                                       }
{       Copyright (c) 2021-2022 by EhLib Team and       }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

unit GridAxisBarsDesignEditFormEh_Laz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, typinfo, db,
  Controls, Dialogs, LCLProc, Forms, ComCtrls, StdCtrls, ActnList, LCLType,
  DBAxisGridsEh,
  IDEImagesIntf, ObjInspStrConsts, PropEdits, PropEditUtils;

type
  TGridAxisBarsDesignEditForm = class(TForm)
    actAdd: TAction;
    actDel: TAction;
    actAddFields: TAction;
    actDeleteAll: TAction;
    actFetchLabels: TAction;
    actMoveUp: TAction;
    actMoveDown: TAction;
    ActionList1: TActionList;
    CollectionListBox: TListBox;
    DividerToolButton1: TToolButton;
    DividerToolButton2: TToolButton;
    DividerToolButton3: TToolButton;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    DeleteButton: TToolButton;
    DividerToolButton: TToolButton;
    MoveUpButton: TToolButton;
    MoveDownButton: TToolButton;
    btAddFlds: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure actAddExecute(Sender: TObject);
    procedure actAddFieldsExecute(Sender: TObject);
    procedure actDeleteAllExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actFetchLabelsExecute(Sender: TObject);
    procedure actMoveDownExecute(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure CollectionListBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCollection: TCollection;
    FOwnerComponent: TPersistent;
    FOwnerPersistent: TPersistent;
    FPropertyName: String;

    function GetDataSet: TDataSet;

    procedure FillCollectionListBox;
    procedure SelectInObjectInspector(ForceUpdate: Boolean);
    procedure UnSelectInObjectInspector(ForceUpdate: Boolean);
    procedure UpdDesignHook(aSelection: TPersistentSelectionList);

  protected

    procedure UpdateCaption;
    procedure UpdateButtons;
    procedure PersistentAdded({%H-}APersistent: TPersistent; {%H-}Select: boolean);
    procedure ComponentRenamed(AComponent: TComponent);
    procedure PersistentDeleting(APersistent: TPersistent);
    procedure RefreshPropertyValues;
  public
    procedure SetCollection(NewCollection: TCollection; NewOwnerPersistent: TPersistent; const NewPropName: String);
    procedure Modified;
  end;

procedure EditDBGridColumns(AComponent: TComponent; ACollection: TCollection;
  APropertyName: String);

implementation

{$R GridAxisBarsDesignEditFormEh_Laz.lfm}

const
  DBGridColumnsForm:  TGridAxisBarsDesignEditForm = nil;

procedure EditDBGridColumns(AComponent: TComponent; ACollection: TCollection;
  APropertyName: String);
begin
  if DBGridColumnsForm = nil then
    DBGridColumnsForm := TGridAxisBarsDesignEditForm.Create(Application);
  DBGridColumnsForm.SetCollection(ACollection, AComponent, APropertyName);
  DBGridColumnsForm.EnsureVisible;
end;

type
  TPersistentAccess = class(TPersistent);

procedure TGridAxisBarsDesignEditForm.FormCreate(Sender: TObject);
begin
  ToolBar1.Images := IDEImages.Images_16;
  actAdd.Caption := oiColEditAdd;
  actAddFields.Caption := dceAddFields;
  actAddFields.ImageIndex := IDEImages.LoadImage('laz_add');
  actFetchLabels.Caption := dceFetchLabels;
  actFetchLabels.ImageIndex := IDEImages.LoadImage('laz_add');
  actDel.Caption := oiColEditDelete;
  actMoveUp.Caption := oiColEditUp;
  actMoveDown.Caption := oiColEditDown;
  actAdd.ImageIndex := IDEImages.LoadImage('laz_add');
  actDel.ImageIndex := IDEImages.LoadImage('laz_delete');
  actDeleteAll.Caption := dceDeleteAll;
  actDeleteAll.ImageIndex := IDEImages.LoadImage('laz_delete');
  actMoveUp.ImageIndex := IDEImages.LoadImage('arrow_up');
  actMoveDown.ImageIndex := IDEImages.LoadImage('arrow_down');
  actMoveUp.ShortCut := scCtrl or VK_UP;
  actMoveDown.ShortCut := scCtrl or VK_DOWN;

  actAdd.Hint := oiColEditAdd;
  actDel.Hint := oiColEditDelete;
  actMoveUp.Hint := oiColEditUp;
  actMoveDown.Hint := oiColEditDown;
end;

procedure TGridAxisBarsDesignEditForm.FormDestroy(Sender: TObject);
begin
  if GlobalDesignHook <> nil then
    GlobalDesignHook.RemoveAllHandlersForObject(Self);
end;

procedure TGridAxisBarsDesignEditForm.CollectionListBoxClick(Sender: TObject);
begin
  // Do not use OnSelectionChange because it fires on changing ItemIndex by code
  // (OnClick does not)
  UpdateButtons;
  UpdateCaption;
  SelectInObjectInspector(False);
end;

procedure TGridAxisBarsDesignEditForm.actAddExecute(Sender: TObject);
begin
  if FCollection = nil then Exit;
  FCollection.Add;

  FillCollectionListBox;
  if CollectionListBox.Items.Count > 0 then
    CollectionListBox.ItemIndex := CollectionListBox.Items.Count - 1;
  SelectInObjectInspector(True);
  UpdateButtons;
  UpdateCaption;
  Modified;
end;

procedure TGridAxisBarsDesignEditForm.actAddFieldsExecute(Sender: TObject);
var
  DataSet: TDataSet;
  Item: TAxisBarEh;
  i: Integer;
begin
  if FCollection=nil then Exit;
  if not (FCollection is TGridAxisBarsEh) then Exit;
  DataSet := GetDataSet;
  if DataSet = nil then Exit;

  if FCollection.Count>0 then
    if (MessageDlg(dceColumnEditor, dceOkToDelete, mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      Exit;

  try
    FCollection.Clear;
    for i := 0 to DataSet.Fields.Count-1 do
    begin
      Item := FCollection.Add as TAxisBarEh;
      Item.Field := DataSet.Fields[i];
      //Item.Title.Caption := DataSet.Fields[i].DisplayLabel;
    end;
  finally
    RefreshPropertyValues;
    UpdateButtons;
    UpdateCaption;
    Modified;
  end;
end;

procedure TGridAxisBarsDesignEditForm.actDeleteAllExecute(Sender: TObject);
begin
  if FCollection = nil then
    Exit;

  if (MessageDlg(dceColumnEditor, dceOkToDelete, mtConfirmation,
                 [mbYes, mbNo], 0) = mrYes) then
  begin
    try
      UnSelectInObjectInspector(True);
      FCollection.Clear;
    finally
      RefreshPropertyValues;
      UpdateButtons;
      UpdateCaption;
      Modified;
    end;
  end;
end;

procedure TGridAxisBarsDesignEditForm.actDelExecute(Sender: TObject);
var
  I : Integer;
begin
  if FCollection = nil then
     Exit;
  I := CollectionListBox.ItemIndex;
  if (I < 0) or (I >= FCollection.Count) then
     Exit;
  if MessageDlg(oisConfirmDelete,
                Format(oisDeleteItem, [FCollection.Items[I].DisplayName]),
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes
  then
    Exit;

  CollectionListBox.ItemIndex := -1;
  // unselect all items in OI (collections can act strange on delete)
  UnSelectInObjectInspector(True);
  // now delete
  FCollection.Items[I].Free;
  // update listbox after whatever happened
  FillCollectionListBox;
  // set new ItemIndex
  if I >= CollectionListBox.Items.Count then
    I := CollectionListBox.Items.Count-1;
  if I >= 0 then
  begin
    CollectionListBox.ItemIndex := I;
    SelectInObjectInspector(False);
  end;
  Modified;
  UpdateButtons;
  UpdateCaption;
end;

procedure TGridAxisBarsDesignEditForm.actFetchLabelsExecute(Sender: TObject);
var
  Column: TAxisBarEh;
  DataSet: TDataSet;
  Field: TField;
  i: Integer;
begin
  DataSet := GetDataSet;
  if DataSet = nil then Exit;

  if MessageDlg(dceColumnEditor, dceWillReplaceContinue, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
     Exit;

  for i := 0 to FCollection.Count-1 do
  begin
    Column := FCollection.Items[i] as TAxisBarEh;
    Field:= DataSet.FindField(Column.FieldName);
    if Field <> nil then
      Column.Title.Caption := Field.DisplayLabel;
  end;
end;

procedure TGridAxisBarsDesignEditForm.actMoveDownExecute(Sender: TObject);
var
  I: Integer;
begin
  if FCollection = nil then Exit;

  I := CollectionListBox.ItemIndex;
  if I >= FCollection.Count - 1 then Exit;

  FCollection.Items[I].Index := I + 1;
  CollectionListBox.ItemIndex := I + 1;

  FillCollectionListBox;
  SelectInObjectInspector(True);
  Modified;
end;

procedure TGridAxisBarsDesignEditForm.actMoveUpExecute(Sender: TObject);
var
  I: Integer;
begin
  if FCollection = nil then Exit;

  I := CollectionListBox.ItemIndex;
  if I < 0 then Exit;

  FCollection.Items[I].Index := I - 1;
  CollectionListBox.ItemIndex := I - 1;

  FillCollectionListBox;
  SelectInObjectInspector(True);
  Modified;
end;

procedure TGridAxisBarsDesignEditForm.UpdateCaption;
var
  NewCaption: String;
begin
  //I think to match Delphi this should be formatted like
  //"Editing ComponentName.PropertyName[Index]"
  if FOwnerPersistent is TComponent then
    NewCaption := TComponent(FOwnerPersistent).Name
  else
    if FOwnerPersistent <> nil then
      NewCaption := FOwnerPersistent.GetNamePath
    else
      NewCaption := '';

  if NewCaption <> '' then NewCaption := NewCaption + '.';
  NewCaption := oiColEditEditing + ' ' + NewCaption + FPropertyName;

  if CollectionListBox.ItemIndex > -1 then
    NewCaption := NewCaption + '[' + IntToStr(CollectionListBox.ItemIndex) + ']';
  Caption := NewCaption;
end;

procedure TGridAxisBarsDesignEditForm.UpdateButtons;
var
  I: Integer;
begin
  I := CollectionListBox.ItemIndex;
  actAdd.Enabled := FCollection <> nil;
  actFetchLabels.Enabled:=actAdd.Enabled and (CollectionListBox.Items.Count > 0);
  actDel.Enabled := I > -1;
  actMoveUp.Enabled := I > 0;
  actMoveDown.Enabled := (I >= 0) and (I < CollectionListBox.Items.Count - 1);
  DividerToolButton1.Visible := (FCollection is TGridAxisBarsEh);
  btAddFlds.Visible := DividerToolButton1.Visible;
  actAddFields.Enabled := DividerToolButton1.Visible;
end;

procedure TGridAxisBarsDesignEditForm.PersistentAdded(APersistent: TPersistent; Select: boolean);
begin
  FillCollectionListBox;
end;

procedure TGridAxisBarsDesignEditForm.ComponentRenamed(AComponent: TComponent);
begin
  if AComponent = FOwnerPersistent then
    UpdateCaption;
end;

procedure TGridAxisBarsDesignEditForm.PersistentDeleting(APersistent: TPersistent);
begin
  DebugLn(['TGridAxisBarsDesignEditForm.PersistentDeleting: APersistent=', APersistent,
           ', FOwnerPersistent=', FOwnerPersistent, ', FOwnerComponent=', FOwnerComponent]);
  SetCollection(nil, nil, '');
  Hide;
  UpdateButtons;
  UpdateCaption;
end;

procedure TGridAxisBarsDesignEditForm.RefreshPropertyValues;
begin
  FillCollectionListBox;
end;

procedure TGridAxisBarsDesignEditForm.FillCollectionListBox;
var
  ItemIndex: Integer;
  i: Integer;
begin
  CollectionListBox.Items.BeginUpdate;
  try
    ItemIndex := CollectionListBox.ItemIndex;
    CollectionListBox.Clear;
    if (FCollection <> nil) and
       (TGridAxisBarsEh(FCollection).State = csCustomized) then
    begin
      for i := 0 to FCollection.Count - 1 do
      begin
        CollectionListBox.Items.Add(Format('%d - %s', [i, FCollection.Items[i].DisplayName]));
      end;
    end;
    if ItemIndex < CollectionListBox.Count then
      CollectionListBox.ItemIndex := ItemIndex  // OnClick not fires
    else
      CollectionListBox.ItemIndex := -1;
  finally
    CollectionListBox.Items.EndUpdate;
    UpdateButtons;
    UpdateCaption;
  end;
end;

function TGridAxisBarsDesignEditForm.GetDataSet: TDataSet;
begin
  if (FOwnerPersistent as TCustomDBAxisGridEh).DataSource = nil then
     Exit(nil);
  Result := TCustomDBAxisGridEh(FOwnerPersistent).DataSource.DataSet;
end;

procedure TGridAxisBarsDesignEditForm.SelectInObjectInspector(ForceUpdate: Boolean);
var
  I: Integer;
  NewSelection: TPersistentSelectionList;
begin
  Assert(Assigned(FCollection), 'SelectInObjectInspector: FCollection=Nil.');

  NewSelection := TPersistentSelectionList.Create;
  NewSelection.ForceUpdate := ForceUpdate;
  try
    for I := 0 to CollectionListBox.Items.Count - 1 do
    begin
      if CollectionListBox.Selected[I] then
        NewSelection.Add(FCollection.Items[I]);
    end;
    UpdDesignHook(NewSelection);
  finally
    NewSelection.Free;
  end;
end;

procedure TGridAxisBarsDesignEditForm.UnSelectInObjectInspector(ForceUpdate: Boolean);
var
  EmptySelection: TPersistentSelectionList;
begin
  EmptySelection := TPersistentSelectionList.Create;
  EmptySelection.ForceUpdate := ForceUpdate;
  try
    UpdDesignHook(EmptySelection);
  finally
    EmptySelection.Free;
  end;
end;

procedure TGridAxisBarsDesignEditForm.UpdDesignHook(aSelection: TPersistentSelectionList);
begin
  if GlobalDesignHook = nil then Exit;
  GlobalDesignHook.SetSelection(aSelection);
  GlobalDesignHook.LookupRoot := GetLookupRootForComponent(FOwnerPersistent);
end;

procedure TGridAxisBarsDesignEditForm.SetCollection(NewCollection: TCollection;
  NewOwnerPersistent: TPersistent; const NewPropName: String);
begin
  if (FCollection = NewCollection) and
     (FOwnerPersistent = NewOwnerPersistent) and
     (FPropertyName = NewPropName)
  then
    Exit;

  FCollection := NewCollection;
  FOwnerPersistent := NewOwnerPersistent;
  FPropertyName := NewPropName;

  FOwnerComponent := NewOwnerPersistent;
  while FOwnerComponent <> nil do
  begin
    if FOwnerComponent is TComponent then
      Break;
    FOwnerComponent := TPersistentAccess(FOwnerComponent).GetOwner;
  end;

  if GlobalDesignHook <> nil then
  begin
    GlobalDesignHook.RemoveAllHandlersForObject(Self);
    if FOwnerPersistent <> nil then
    begin
      GlobalDesignHook.AddHandlerPersistentAdded(@PersistentAdded);
      GlobalDesignHook.AddHandlerComponentRenamed(@ComponentRenamed);
      GlobalDesignHook.AddHandlerPersistentDeleting(@PersistentDeleting);
      GlobalDesignHook.AddHandlerRefreshPropertyValues(@RefreshPropertyValues);
    end;
  end;

  FillCollectionListBox;
  UpdateCaption;
end;

procedure TGridAxisBarsDesignEditForm.Modified;
begin
  if GlobalDesignHook <> nil then
    GlobalDesignHook.Modified(Self);
end;

end.

