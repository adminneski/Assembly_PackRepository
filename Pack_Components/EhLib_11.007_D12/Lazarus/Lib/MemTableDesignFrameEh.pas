{*******************************************************}
{                                                       }
{                     EhLib 10.2                        }
{                                                       }
{             TMemTableDesignFrame component            }
{                                                       }
{       Copyright (c) 2021-2022 by EhLib Team and       }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

unit MemTableDesignFrameEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, DBCtrls,
  Buttons, ExtCtrls, StdCtrls, ComCtrls, DB,

  {$IFDEF FPC}
  DBGridsEh,
  EhLibLCL, LCLType,
  PropEdits, ComponentEditors, FieldsEditor,
  {$ELSE}
  EhLibVCL, DBGridEh,
  DSDesign, DsnDBCst, PicEdit, FldLinks,
  StringsEdit, VCLEditors, DesignEditors, DesignIntf, DesignWindows,
  DesignMenus, MTCreateDataDriver,
  Windows, Messages,
  {$ENDIF}
  MemTableEh, DBGridEhImpExp,
  MemTableDataEh, DBAxisGridsEh, Menus, ActnList,
  GridsEh;

type
  TMemTableDesignFrame = class(TFrame)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet4: TTabSheet;
    gridStructure: TDBGridEh;
    Panel2: TPanel;
    sbCancel: TSpeedButton;
    sbApply: TSpeedButton;
    DBNavigator1: TDBNavigator;
    cbPersistentStructure: TCheckBox;
    TabSheet2: TTabSheet;
    DBGridEh1: TDBGridEh;
    TabSheet3: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    ActionList1: TActionList;
    actFetchParams: TAction;
    actAssignLocalData: TAction;
    actLoadFromMyBaseTable: TAction;
    actCreateDataSet: TAction;
    actSaveToMyBaseXmlTable: TAction;
    actSaveToMyBaseXmlUTF8Table: TAction;
    actSaveToBinaryMyBaseTable: TAction;
    actClearData: TAction;
    actCreateDataDriver: TAction;
    actLoadDataSet: TAction;
    actSaveDataSet: TAction;
    GridMenu: TPopupMenu;
    GridCut: TMenuItem;
    GridCopy: TMenuItem;
    GridPaste: TMenuItem;
    GridDelete: TMenuItem;
    GridSelectAll: TMenuItem;
    dsStructure: TDataSource;
    mtStructure: TMemTableEh;
    mtStructureFName: TStringField;
    mtStructureFType: TStringField;
    mtStructureRefDataField: TRefObjectField;
    procedure actFetchParamsExecute(Sender: TObject);
    procedure actAssignLocalDataExecute(Sender: TObject);
    procedure actLoadFromMyBaseTableExecute(Sender: TObject);
    procedure actCreateDataSetExecute(Sender: TObject);
    procedure actSaveToMyBaseXmlTableExecute(Sender: TObject);
    procedure actSaveToMyBaseXmlUTF8TableExecute(Sender: TObject);
    procedure actSaveToBinaryMyBaseTableExecute(Sender: TObject);
    procedure actClearDataExecute(Sender: TObject);
    procedure actCreateDataSetUpdate(Sender: TObject);
    procedure actLoadDataSetExecute(Sender: TObject);
    procedure actSaveDataSetExecute(Sender: TObject);
    procedure SelectTable(Sender: TObject);
    procedure GridCutClick(Sender: TObject);
    procedure GridCopyClick(Sender: TObject);
    procedure GridPasteClick(Sender: TObject);
    procedure GridDeleteClick(Sender: TObject);
    procedure GridSelectAllClick(Sender: TObject);
    procedure DBGridEh1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure actCreateDataDriverExecute(Sender: TObject);
    procedure dsStructureDataChange(Sender: TObject; Field: TField);
    procedure sbCancelClick(Sender: TObject);
    procedure sbApplyClick(Sender: TObject);
    procedure DBGridEh2Columns0UpdateData(Sender: TObject; var AText: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure mtStructureAfterPost(DataSet: TDataSet);
    procedure mtStructureBeforeDelete(DataSet: TDataSet);
    procedure mtStructureBeforePost(DataSet: TDataSet);
    procedure gridStructureEnter(Sender: TObject);
    procedure gridStructureExit(Sender: TObject);
    procedure cbPersistentStructureClick(Sender: TObject);
    procedure mtStructureNewRecord(DataSet: TDataSet);

  private
    FMTNotificator: TRecordsListNotificatorEh;
    ChStruct: TMTDataStructEh;
    FChStructChanged: Boolean;

    {$IFDEF FPC}
    function GetDesigner: TComponentEditorDesigner;
    function GetFieldsEditor: TDSFieldsEditorFrm;
    {$ELSE}
    function GetDesigner: IDesigner;
    function GetFieldsEditor: TFieldsEditor;
    {$ENDIF}

    function GetDataset: TDataset;
    function GetFieldListBox: TListBox;
    function GetActiveControl: TControl;
    function GetMemTableEh: TCustomMemTableEh;

    procedure Activated;
    procedure SetMemTableEh(Value: TCustomMemTableEh);
    procedure ChStructChanged(Sender: TObject);
    procedure SetDataset(Value: TDataset);
    procedure MTStructChanged(AMemTableData: TMemTableDataEh);
    procedure UpdateStructButtons;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateStructureList;
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure UpdateColumnProps;

    {$IFDEF FPC}
    property Designer: TComponentEditorDesigner read GetDesigner;
    property FieldsEditor: TDSFieldsEditorFrm read GetFieldsEditor;
    {$ELSE}
    property Designer: IDesigner read GetDesigner;
    property FieldsEditor: TFieldsEditor read GetFieldsEditor;
    {$ENDIF}

    property Dataset: TDataset read GetDataset write SetDataset;
    property MemTable: TCustomMemTableEh read GetMemTableEh write SetMemTableEh;

    property FieldListBox: TListBox read GetFieldListBox;
    property ActiveControl: TControl read GetActiveControl;

    property MTNotificator: TRecordsListNotificatorEh read FMTNotificator;

  end;

implementation

uses
  MemTableEditEh, Clipbrd, MemTableDesignEh;

{$R *.dfm}

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

{ TMemTableDesignFrame }

constructor TMemTableDesignFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  SpeedButton1.Align := alTop;
  SpeedButton2.Align := alTop;
  SpeedButton3.Align := alTop;
  SpeedButton4.Align := alTop;
  SpeedButton5.Align := alTop;
  SpeedButton6.Align := alTop;
  SpeedButton7.Align := alTop;
  SpeedButton8.Align := alTop;
  SpeedButton9.Align := alTop;
  SpeedButton10.Align := alTop;
  SpeedButton11.Align := alTop;
  DBGridEh1.DrawGraphicData := True;
  DBGridEh1.DrawMemoText := True;

  FMTNotificator := TRecordsListNotificatorEh.Create(Self);
  FMTNotificator.OnStructChanged :=  MTStructChanged;

end;

destructor TMemTableDesignFrame.Destroy;
begin
  FreeAndNil(ChStruct);
  inherited Destroy;
end;

function TMemTableDesignFrame.GetDataset: TDataset;
begin
  Result := (FieldsEditor as TMemTableFieldsEditorEh).DataSet;
end;

{$IFDEF FPC}
function TMemTableDesignFrame.GetDesigner: TComponentEditorDesigner;
{$ELSE}
function TMemTableDesignFrame.GetDesigner: IDesigner;
{$ENDIF}
begin
  Result := FieldsEditor.Designer;
end;

{$IFDEF FPC}
function TMemTableDesignFrame.GetFieldsEditor: TDSFieldsEditorFrm;
begin
  Result := Owner as TDSFieldsEditorFrm;
end;
{$ELSE}
function TMemTableDesignFrame.GetFieldsEditor: TFieldsEditor;
begin
  Result := Owner as TFieldsEditor;
end;
{$ENDIF}

function TMemTableDesignFrame.GetFieldListBox: TListBox;
begin
  {$IFDEF FPC}
  Result := FieldsEditor.FieldsListBox;
  {$ELSE}
  Result := FieldsEditor.FieldListBox;
  {$ENDIF}
end;

function TMemTableDesignFrame.GetActiveControl: TControl;
begin
  Result := FieldsEditor.ActiveControl;
end;

procedure TMemTableDesignFrame.Activated;
begin
  (FieldsEditor as TMemTableFieldsEditorEh).EditorActivated;
end;

procedure TMemTableDesignFrame.UpdateStructureList;
var
  i: Integer;
begin
  FreeAndNil(ChStruct);
  FChStructChanged := False;
  ChStruct := MemTable.RecordsView.MemTableData.DataStruct.GetCopy;
  ChStruct.OnStructChanged := ChStructChanged;
  dsStructure.OnDataChange := nil;
  mtStructure.AfterPost := nil;
  mtStructure.EmptyTable;
  for i := 0 to ChStruct.Count-1 do
  begin
    mtStructure.AppendRecord([ChStruct[i].FieldName, ChStruct[i].ClassName]);
    mtStructure.Edit;
    mtStructureRefDataField.Value := ChStruct[i];
    mtStructure.Post;
  end;
  mtStructure.First;
  dsStructure.OnDataChange := dsStructureDataChange;
  mtStructure.AfterPost := mtStructureAfterPost;
  sbCancel.Enabled := FChStructChanged;
  sbApply.Enabled := FChStructChanged;
  cbPersistentStructure.Checked := (mtoPersistentStructEh in MemTable.Options);
end;

procedure TMemTableDesignFrame.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  UpdateColumnProps;
end;

procedure TMemTableDesignFrame.UpdateColumnProps;
var
  i: Integer;
begin
  for i := 0 to DBGridEh1.Columns.Count-1 do
  begin
    if (DBGridEh1.Columns[i].Field <> nil) and
       (DBGridEh1.Columns[i].Field.DataType in [ftMemo, ftGraphic, ftFmtMemo{$IFDEF EH_LIB_10}, ftWideMemo {$ENDIF}]) then
      DBGridEh1.Columns[i].ButtonStyle := cbsEllipsis;
  end;
end;

function TMemTableDesignFrame.GetMemTableEh: TCustomMemTableEh;
begin
  Result := TCustomMemTableEh(DataSet);
end;

procedure TMemTableDesignFrame.SetMemTableEh(Value: TCustomMemTableEh);
begin
  DataSet := Value;
  MTNotificator.DataObject := Value.RecordsView.MemTableData;
  UpdateStructureList;
end;

procedure TMemTableDesignFrame.SetDataset(Value: TDataset);
begin
end;

procedure TMemTableDesignFrame.ChStructChanged(Sender: TObject);
begin
  FChStructChanged := True;
  UpdateStructButtons;
end;

procedure TMemTableDesignFrame.MTStructChanged(AMemTableData: TMemTableDataEh);
begin
  UpdateStructureList;
end;

procedure TMemTableDesignFrame.UpdateStructButtons;
begin
  sbCancel.Enabled := FChStructChanged;
  sbApply.Enabled := FChStructChanged;
end;

// Events

procedure TMemTableDesignFrame.actFetchParamsExecute(Sender: TObject);
begin
  TCustomMemTableEh(Dataset).FetchParams;
  Designer.Modified;
end;

procedure TMemTableDesignFrame.actAssignLocalDataExecute(
  Sender: TObject);
begin
  if EditMemTable(TCustomMemTableEh(Dataset), Designer)
    then Designer.Modified;
end;

procedure TMemTableDesignFrame.actLoadFromMyBaseTableExecute(
  Sender: TObject);
begin
end;

procedure TMemTableDesignFrame.actCreateDataSetExecute(
  Sender: TObject);
begin
  TCustomMemTableEh(Dataset).CreateDataSet;
  Designer.Modified;
end;

procedure TMemTableDesignFrame.actSaveToMyBaseXmlTableExecute(Sender: TObject);
begin
end;

procedure TMemTableDesignFrame.actSaveToMyBaseXmlUTF8TableExecute(
  Sender: TObject);
begin
end;

procedure TMemTableDesignFrame.actSaveToBinaryMyBaseTableExecute(
  Sender: TObject);
begin
end;

procedure TMemTableDesignFrame.actClearDataExecute(Sender: TObject);
begin
  TCustomMemTableEh(Dataset).DestroyTable;
  TCustomMemTableEh(Dataset).FieldDefs.Clear;
  Designer.Modified;
end;

procedure TMemTableDesignFrame.actCreateDataSetUpdate(
  Sender: TObject);
begin
  actCreateDataSet.Enabled := ((Dataset.FieldCount > 0) or
                               (Dataset.FieldDefs.Count > 0)) and
                              not Dataset.Active;
  actSaveToMyBaseXmlTable.Enabled := Dataset.Active;
  actSaveToMyBaseXmlTable.Visible := False;
  actSaveToMyBaseXmlUTF8Table.Enabled := Dataset.Active;
  actSaveToMyBaseXmlUTF8Table.Visible := False;
  actSaveToBinaryMyBaseTable.Enabled := Dataset.Active;
  actSaveToBinaryMyBaseTable.Visible := False;
  actLoadFromMyBaseTable.Visible := False;
  actClearData.Enabled := Dataset.Active;
end;

procedure TMemTableDesignFrame.actLoadDataSetExecute(Sender: TObject);
begin
  if LoadFromFile(TCustomMemTableEh(Dataset)) then
  begin
    TCustomMemTableEh(Dataset).Open;
    Designer.Modified;
  end;
end;

procedure TMemTableDesignFrame.actSaveDataSetExecute(Sender: TObject);
begin
  SaveToFile(TCustomMemTableEh(Dataset));
end;

procedure TMemTableDesignFrame.SelectTable(Sender: TObject);
var
  I: Integer;
begin
  FieldListBox.ItemIndex := 0;
  for I := 0 to FieldListBox.Items.Count - 1 do
    if FieldListBox.Selected[I] then
      FieldListBox.Selected[I] := False;
  Activated;
  case PageControl1.ActivePageIndex of
    0: FieldListBox.SetFocus;
    1: gridStructure.SetFocus;
  end;
end;

procedure TMemTableDesignFrame.GridCutClick(Sender: TObject);
begin
  DBGridEh_DoCutAction(DBGridEh1,False);
end;

procedure TMemTableDesignFrame.GridCopyClick(Sender: TObject);
begin
  DBGridEh_DoCopyAction(DBGridEh1,False);
end;

procedure TMemTableDesignFrame.GridPasteClick(Sender: TObject);
begin
  DBGridEh_DoPasteAction(DBGridEh1,False);
end;

procedure TMemTableDesignFrame.GridDeleteClick(Sender: TObject);
begin
  DBGridEh_DoDeleteAction(DBGridEh1,False);
end;

procedure TMemTableDesignFrame.GridSelectAllClick(Sender: TObject);
begin
  DBGridEh1.Selection.SelectAll;
end;

procedure TMemTableDesignFrame.DBGridEh1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Pos: TPoint;
begin
  if not ((DBGridEh1.InplaceEditor <> nil) and
          (DBGridEh1.InplaceEditor.Visible)) then
  begin
    GridCut.Enabled := (DBGridEh1.Selection.SelectionType <> gstNon);
    GridCopy.Enabled := (DBGridEh1.Selection.SelectionType <> gstNon);
    GridPaste.Enabled := Clipboard.HasFormat(CF_VCLDBIF) or
                         Clipboard.HasFormat(CF_TEXT);
    GridDelete.Enabled := (DBGridEh1.Selection.SelectionType <> gstNon);
    GridSelectAll.Enabled := (DBGridEh1.Selection.SelectionType <> gstAll);
    Pos := DBGridEh1.ClientToScreen(MousePos);
    GridMenu.Popup(Pos.X,Pos.Y);
  end;
end;

procedure TMemTableDesignFrame.actCreateDataDriverExecute(
  Sender: TObject);
begin
  {$IFDEF FPC}
  //EditMTCreateDataDriver(TCustomMemTableEh(Dataset), Designer);
  {$ELSE}
  EditMTCreateDataDriver(TCustomMemTableEh(Dataset), Designer);
  {$ENDIF}
end;

procedure TMemTableDesignFrame.dsStructureDataChange(Sender: TObject;
  Field: TField);
{$IFDEF FPC}
var
  SelList: TPersistentSelectionList;
begin
  if (mtStructure.FieldByName('FName').AsString <> '') then
  begin
    SelList := TPersistentSelectionList.Create;
    if mtStructureRefDataField.Value <> nil then
      SelList.Add(TPersistent(mtStructureRefDataField.Value));
    Designer.PropertyEditorHook.SetSelection(SelList);
    SelList.Free;
  end else if ActiveControl = gridStructure then
    Designer.PropertyEditorHook.SetSelection(nil);
    //Designer.PropertyEditorHook.NoSelection;
end;
{$ELSE}
var
  ComponentList: IDesignerSelections;
begin
  if (mtStructure.FieldByName('FName').AsString <> '') then
  begin
    ComponentList := TDesignerSelections.Create;
    if mtStructureRefDataField.Value <> nil then
      ComponentList.Add(TPersistent(mtStructureRefDataField.Value));
    Designer.SetSelections(ComponentList);
  end else if ActiveControl = gridStructure then
    Designer.NoSelection;
end;
{$ENDIF}

procedure TMemTableDesignFrame.sbCancelClick(Sender: TObject);
begin
  UpdateStructureList;
end;

procedure TMemTableDesignFrame.sbApplyClick(Sender: TObject);
begin
  MemTable.RecordsView.MemTableData.DataStruct.Assign(ChStruct);
end;

procedure TMemTableDesignFrame.DBGridEh2Columns0UpdateData(
  Sender: TObject; var AText: String; var Value: Variant; var UseText,
  Handled: Boolean);
var
  Col: TColumnEh;
begin
  Col := TColumnEh(Sender);
  Col.Field.AsString := AText;
  Col.Field.DataSet.Post;
  Handled := True;
end;

procedure TMemTableDesignFrame.mtStructureAfterPost(DataSet: TDataSet);
var
  NewField: TMTDataFieldEh;
begin
  if mtStructureRefDataField.Value = nil then
  begin
    if (mtStructureFName.AsString <> '') and (mtStructureFType.AsString <> '') then
    begin
      NewField := ChStruct.CreateField(TMTDataFieldClassEh(FindClass(mtStructureFType.AsString)));
      NewField.FieldName := mtStructureFName.AsString;
      NewField.Index := mtStructure.RecNo - 1;
      mtStructure.Edit;
      mtStructureRefDataField.Value := NewField;
      mtStructure.AfterPost := nil;
      mtStructure.Post;
      mtStructure.AfterPost := mtStructureAfterPost;
    end;
  end else
  begin
  end;
end;

procedure TMemTableDesignFrame.mtStructureBeforeDelete(DataSet: TDataSet);
var
  OldField: TMTDataFieldEh;
begin
  OldField := ChStruct.FindField(mtStructureFName.AsString);
  if OldField <> nil then
  begin
    ChStruct.RemoveField(OldField);
    OldField.Free;
  end;
end;

procedure TMemTableDesignFrame.mtStructureNewRecord(DataSet: TDataSet);
begin
  DataSet['FType'] := 'TMTStringDataFieldEh'
end;

procedure TMemTableDesignFrame.gridStructureEnter(Sender: TObject);
begin
  dsStructureDataChange(nil, nil);
end;

procedure TMemTableDesignFrame.gridStructureExit(Sender: TObject);
begin
  inherited;
  {$IFDEF FPC}
  {$ELSE}
  Designer.SelectComponent(Dataset);
  {$ENDIF}
end;

procedure TMemTableDesignFrame.cbPersistentStructureClick(Sender: TObject);
begin
  if cbPersistentStructure.Checked
    then MemTable.Options := MemTable.Options + [mtoPersistentStructEh]
    else MemTable.Options := MemTable.Options - [mtoPersistentStructEh];
  Designer.Modified;
end;

procedure TMemTableDesignFrame.mtStructureBeforePost(DataSet: TDataSet);
var
  NewFieldClass: TMTDataFieldClassEh;
  NewField: TMTDataFieldEh;
begin
  if mtStructureRefDataField.Value <> nil then
  begin
    if TMTDataFieldEh(mtStructureRefDataField.Value).FieldName <> mtStructureFName.AsString then
      TMTDataFieldEh(mtStructureRefDataField.Value).FieldName := mtStructureFName.AsString;
    if TMTDataFieldEh(mtStructureRefDataField.Value).ClassName <> mtStructureFType.AsString then
    begin
      NewFieldClass := TMTDataFieldClassEh(FindClass(mtStructureFType.AsString));
      NewField := ChStruct.ChangeFieldType(mtStructureFName.AsString, NewFieldClass);
      mtStructureRefDataField.Value := NewField;
    end;
  end;
end;

end.
