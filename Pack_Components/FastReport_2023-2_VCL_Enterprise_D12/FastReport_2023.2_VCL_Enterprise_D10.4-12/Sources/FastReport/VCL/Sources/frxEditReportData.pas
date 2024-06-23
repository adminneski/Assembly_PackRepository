
{******************************************}
{                                          }
{             FastReport VCL               }
{         Report datasets selector         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditReportData;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, frxClass, CheckLst, frxBaseForm, frxComCtrls, Menus, ExtCtrls
  {$IFDEF FPC}
  , LCLType
  {$ENDIF}
{$IFDEF Delphi6}
, Variants
{$ENDIF}
{$IFDEF Delphi16}
, System.Types
{$ENDIF}
;



type
  TfrxDataSetsActions = ( dsaSortSelectedData = 59, dsaSortData = 60,
    dsaUnsorted = 127, dsaAscending = 125, dsaDescending = 126,
    dsaUnselected = 113, dsaAll = 128, dsaSelected = 129);

  TfrxDataSetsSortType = (dssUnsorted, dssAscending, dssDescending);
  TfrxDataSetsSortSelectedType = (dsssAll, dsssSelected, dsssUnselected);

  TfrxDataSetItemState = (disUnchecked, disChecked, disMissing);

  TfrxDataSetListItem = class(TCollectionItem)
  private
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FState: TfrxDataSetItemState;
  public
    property DataSet: TfrxDataSet read FDataSet write FDataSet;
    property DataSetName: String read FDataSetName write FDataSetName;
    property State: TfrxDataSetItemState read FState write FState;
  end;

  TfrxEditorDataSetsList = class(TCollection)
  private
    function GetItem(Index: Integer): TfrxDataSetListItem;
  public
    constructor Create;
    procedure Add(const Name: String; ADataSet: TfrxDataSet; AState: TfrxDataSetItemState);
    property Items[Index: Integer]: TfrxDataSetListItem read GetItem; default;
  end;

  TfrxReportDataForm = class(TfrxBaseForm)
    OKB: TButton;
    CancelB: TButton;
    DatasetsLB: TCheckListBox;
    SelAllCB: TCheckBox;
    DSPanel: TPanel;
    FooterPanel: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DatasetsLBClickCheck(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SelAllCBClick(Sender: TObject);
  private
    FStandalone: Boolean;
    FToolWithFilterPanel: TfrxToolWithFilterPanel;
    FSortButton: TfrxToolPanelButton;
    FSortSelectedButton: TfrxToolPanelButton;
    FDataSetsSortType: TfrxDataSetsSortType;
    FDataSetsSortSelectedType: TfrxDataSetsSortSelectedType;
    FSortPopUp: TPopupMenu;
    FSortSelectedPopUp: TPopupMenu;
    FFilter: String;
    FDataSetsList: TfrxEditorDataSetsList;
    procedure BuildConnectionList;
    procedure BuildDatasetList;
    procedure UpdateDataSetLB;
    procedure UpdateCBState;
    procedure UpdateSelectedDS;
    procedure ToolOnClick(Sender: TObject);
    procedure CreatefrxToolWithFilterPanel(var ToolWithFilterPanel: TfrxToolWithFilterPanel);
    procedure CreateSortPopup;
    procedure CreateSortSelectedPopup;
    procedure EditChange(Sender: TObject);
    procedure UpdateControls;
  public
    Report: TfrxReport;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateResouces; override;
  end;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxDesgn, frxRes
  {$IFNDEF FPC} , frxUtils ,IniFiles , Registry{$ENDIF};

var
  PrevWidth: Integer = 0;
  PrevHeight: Integer = 0;

procedure TfrxReportDataForm.FormCreate(Sender: TObject);
begin
  FStandalone := (frxDesignerComp <> nil) and frxDesignerComp.Standalone;
  if UseRightToLeftAlignment then
    FlipChildren(True);
  FFilter := '';
  CreatefrxToolWithFilterPanel(FToolWithFilterPanel);
  FSortButton := FToolWithFilterPanel.ToolPanel.AddButton(ord(dsaUnsorted), frxGet(4117), ord(dsaSortData), fbsDropDownButton);
  FSortSelectedButton := FToolWithFilterPanel.ToolPanel.AddButton(ord(dsaAll), frxGet(3104), ord(dsaSortSelectedData), fbsDropDownButton);
  FToolWithFilterPanel.ToolPanel.AddCustomButton(fbkSeparator);
 {$IFNDEF FPC}
  FToolWithFilterPanel.BevelKind := bkNone;
 {$ENDIF}
  CreateSortPopup;
  CreateSortSelectedPopup;
end;

procedure TfrxReportDataForm.UpdateSelectedDS;
var
  i: Integer;
begin
  if FStandalone then
    Report.ReportOptions.ConnectionName := '';
  Report.DataSets.Clear;
  for i := 0 to FDataSetsList.Count - 1 do
    if FDataSetsList[i].State = disChecked then
    begin
      if FStandalone then
        Report.ReportOptions.ConnectionName := FDataSetsList[i].DataSetName
      else
        if FDataSetsList[i].DataSet = nil then
          Report.DataSets.Add(FDataSetsList[i].DataSetName)
        else if Report.DataSets.Find(TfrxDataSet(FDataSetsList[i].DataSet)) = nil then
          Report.DataSets.Add(TfrxDataSet(FDataSetsList[i].DataSet))
    end
end;

procedure TfrxReportDataForm.FormShow(Sender: TObject);
begin
  if PrevWidth <> 0 then
  begin
    Width := PrevWidth;
    Height := PrevHeight;
  end;

  if FStandalone then
    BuildConnectionList
  else
    BuildDatasetList;
  UpdateDataSetLB;
  UpdateCBState;
end;

procedure TfrxReportDataForm.UpdateResouces;
begin
  inherited;
  if FStandalone then
    Caption := frxGet(5800)
  else
    Caption := frxGet(2800);
  OKB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  SelAllCB.Caption := frxGet(2414);
end;

procedure TfrxReportDataForm.FormHide(Sender: TObject);
begin
  PrevWidth := Width;
  PrevHeight := Height;
  if ModalResult <> mrOk then Exit;

  UpdateSelectedDS;
end;

procedure TfrxReportDataForm.BuildConnectionList;
{$IFNDEF FPC}
var
  i: Integer;
  ini: TRegistry;
  sl: TStringList;
  s2: TStringList;
  LState: TfrxDataSetItemState;
{$ENDIF}
begin
  {$IFNDEF FPC}
  ini := TRegistry.Create;
  try
    sl := TStringList.Create;
    s2 := TStringList.Create;
    try
      ini.RootKey := HKEY_LOCAL_MACHINE;
      if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS)  then
      begin
        ini.GetValueNames(sl);
        ini.CloseKey;
      end;

      ini.RootKey := HKEY_CURRENT_USER;
      if ini.OpenKeyReadOnly(DEF_REG_CONNECTIONS)  then
      begin
        ini.GetValueNames(s2);
        ini.CloseKey;
      end;

      sl.AddStrings(s2);

      for i := 0 to sl.Count - 1 do
      begin
        LState := disUnchecked;
        if CompareText(sl[i], Report.ReportOptions.ConnectionName) = 0 then
          LState := disChecked;
        FDataSetsList.Add(sl[i], nil, LState);
      end;
    finally
      sl.Free;
      s2.Free;
    end;
  finally
    ini.Free;
  end;
  {$ENDIF}
end;

procedure TfrxReportDataForm.BuildDatasetList;
var
  i: Integer;
  ds: TfrxDataSet;
  LFilter: String;
  LState: TfrxDataSetItemState;
  LDSList: TStringList;
begin
  LFilter := AnsiUpperCase(FFilter);

  if Report.EnabledDataSets.Count > 0 then
  begin
    for i := 0 to Report.EnabledDataSets.Count - 1 do
    begin
      ds := Report.EnabledDataSets[i].DataSet;
      LState := disMissing;
      if ds <> nil then
        LState := disChecked;
      FDataSetsList.Add(Report.EnabledDataSets[i].DataSetName, ds, LState);
    end;
  end
  else
  begin
    LDSList := TStringList.Create;
    try
      Report.GetActiveDataSetList(LDSList);
      for i := 0 to LDSList.Count - 1 do
      begin
        LState := disUnchecked;
        ds := TfrxDataSet(LDSList.Objects[i]);
        if Report.DataSets.Find(ds) <> nil then
          LState := disChecked;
        if LDSList.Objects[i] = nil then
          LState := disMissing;
        FDataSetsList.Add(LDSList[i], ds, LState);
      end;
      for i := 0 to Report.DataSets.Count - 1 do
        if Report.DataSets[i].DataSet = nil then
          FDataSetsList.Add(Report.DataSets[i].DataSetName, nil, disMissing);
    finally
      LDSList.Free;
    end;
  end;
end;

procedure TfrxReportDataForm.DatasetsLBClickCheck(Sender: TObject);
var
  i: Integer;
begin
  if FStandalone then
    for i := 0 to DatasetsLB.Items.Count - 1 do
      if i <> DatasetsLB.ItemIndex then
        DatasetsLB.Checked[i] := False;
  UpdateCBState;
end;

destructor TfrxReportDataForm.Destroy;
begin
  FreeAndNil(FDataSetsList);
  inherited;
end;

procedure TfrxReportDataForm.EditChange(Sender: TObject);
begin
  FFilter := FToolWithFilterPanel.FilterEdit.EditControl.Text;
  UpdateDataSetLB;
end;

procedure TfrxReportDataForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxReportDataForm.SelAllCBClick(Sender: TObject);
var
  i: Integer;
begin
  if SelAllCB.State = cbGrayed then Exit;
  for i := 0 to DatasetsLB.Items.Count - 1 do
    DatasetsLB.Checked[i] := SelAllCB.Checked;
  UpdateCBState;
  UpdateControls;
end;

procedure TfrxReportDataForm.UpdateCBState;
var
  i: Integer;
  cbs: TCheckBoxState;
  LDSListItem: TfrxDataSetListItem;
begin
  cbs := cbUnchecked;
  for i := 0 to DatasetsLB.Items.Count - 1 do
  begin
    LDSListItem := TfrxDataSetListItem(DatasetsLB.Items.Objects[i]);
    if Assigned(LDSListItem) and DatasetsLB.Checked[i] then
      LDSListItem.State := disChecked
    else
      LDSListItem.State := disUnchecked;
  end;
  for i := 0 to DatasetsLB.Items.Count - 1 do
  begin;
    if (i = 0) and DatasetsLB.Checked[i] then
      cbs := cbChecked;
    if (i > 0) and (not DatasetsLB.Checked[i] and (cbs = cbChecked)) or
      (DatasetsLB.Checked[i] and (cbs = cbUnchecked)) then
    begin
      cbs := cbGrayed;
      break;
    end;
  end;
  SelAllCB.State := cbs;
  UpdateControls;
end;

procedure TfrxReportDataForm.UpdateControls;
begin
  case FDataSetsSortType of
    dssUnsorted: FSortButton.ImageIndex := Ord(dsaUnsorted);
    dssAscending: FSortButton.ImageIndex := Ord(dsaAscending);
    dssDescending: FSortButton.ImageIndex := Ord(dsaDescending);
  end;

  case FDataSetsSortSelectedType of
    dsssAll:
      begin
        FSortSelectedButton.ImageIndex := Ord(dsaAll);
        FSortSelectedButton.Hint := frxGet(3104);
      end;
    dsssSelected:
      begin
        FSortSelectedButton.ImageIndex := Ord(dsaSelected);
        FSortSelectedButton.Hint := frxGet(3105);
      end;
    dsssUnselected:
      begin
        FSortSelectedButton.ImageIndex := Ord(dsaUnselected);
        FSortSelectedButton.Hint := frxGet(3106);
      end;
  end;
end;

procedure TfrxReportDataForm.UpdateDataSetLB;
var
  i, nInc, nDSCount: Integer;
  ds: TfrxDataSet;
  dsList: TStringList;
  LFilter: String;
  LCheckState: TfrxDataSetItemState;
  LDSListItem: TfrxDataSetListItem;

  procedure AddCBItem(const ADSName: String);
  var
    LIndex: Integer;
    LSInfo: String;
  begin
    LIndex := -1;
    LSInfo := '';
    if not((FDataSetsSortSelectedType = dsssAll) or
      ((LCheckState = disChecked) and (FDataSetsSortSelectedType = dsssSelected))
      or ((LCheckState = disUnchecked) and (FDataSetsSortSelectedType = dsssUnselected))) then
      Exit;
    if LDSListItem.DataSet = nil then
      LSInfo :=  '('+ frxResources.Get('dtNoData') + ')';
    if LFilter <> '' then
    begin
      if Pos(LFilter, AnsiUpperCase(ADSName)) > 0 then
        LIndex := DataSetsLB.Items.AddObject(ADSName + LSInfo, LDSListItem);
    end
    else
      LIndex := DataSetsLB.Items.AddObject(ADSName + LSInfo, LDSListItem);
    if LIndex >= 0 then
      DataSetsLB.Checked[LIndex] := LDSListItem.State = disChecked;
  end;

begin
  LFilter := AnsiUpperCase(FFilter);
  dsList := TStringList.Create;
  try
    dsList.Sorted := FDataSetsSortType <> dssUnsorted;
    for i := 0 to FDataSetsList.Count - 1 do
      dsList.AddObject(FDataSetsList[i].DataSetName, FDataSetsList[i]);
    i := 0;
    nDSCount := dsList.Count - 1;
    nInc := 1;

    if FDataSetsSortType = dssDescending then
    begin
      i := dsList.Count - 1;
      nDSCount := 0;
      nInc := -1;
    end;

    DataSetsLB.Items.BeginUpdate;
    try
      DataSetsLB.Items.Clear;
      while i * nInc <= nDSCount do
      begin
        LDSListItem := TfrxDataSetListItem(dsList.Objects[i]);
        ds := LDSListItem.DataSet;
        LCheckState := LDSListItem.State;
        if (csDesigning in Report.ComponentState) and
          ((ds.Owner is TForm) or (ds.Owner is TDataModule){$IFDEF Delphi5} or (ds.Owner is TFrame){$ENDIF}) then
            AddCBItem(ds.UserName + '  (' + ds.Owner.Name + '.' + ds.Name + ')')
        else
        begin
          if ds = nil then
            AddCBItem(LDSListItem.DataSetName)
          else if not (ds.Owner is TfrxReport) or (ds.Owner = Report) then
            AddCBItem(ds.UserName);
        end;
        Inc(i, nInc);
      end;
    finally
      DataSetsLB.Items.EndUpdate;
    end;
  finally
    dsList.Free;
  end;
end;

procedure TfrxReportDataForm.ToolOnClick(Sender: TObject);
var
  BtnID: TfrxDataSetsActions;
  SenderBtn: TfrxToolPanelButton;
  NewSortType: TfrxDataSetsSortType;
  NewSortSelectedType: TfrxDataSetsSortSelectedType;
  pt: TPoint;
begin
  if Sender is TMenuItem then
  begin
    BtnID := TfrxDataSetsActions(TMenuItem(Sender).Tag);
    NewSortType := dssUnsorted;
    NewSortSelectedType := dsssAll;
    case BtnID of
      dsaUnsorted: NewSortType := dssUnsorted;
      dsaAscending: NewSortType := dssAscending;
      dsaDescending: NewSortType := dssDescending;
      dsaAll: NewSortSelectedType := dsssAll;
      dsaSelected: NewSortSelectedType := dsssSelected;
      dsaUnselected: NewSortSelectedType := dsssUnselected;
    end;

    if (FDataSetsSortType <> NewSortType) and ((BtnID = dsaUnsorted) or (BtnID = dsaAscending)
      or (BtnID = dsaDescending)) then
      FDataSetsSortType := NewSortType;

    if (FDataSetsSortSelectedType <> NewSortSelectedType) and ((BtnID = dsaAll)
      or (BtnID = dsaSelected) or (BtnID = dsaUnselected)) then
      FDataSetsSortSelectedType := NewSortSelectedType;
    UpdateDataSetLB;
  end;

  if not Sender.InheritsFrom(TfrxToolPanelButton) then Exit;
  SenderBtn := TfrxToolPanelButton(Sender);
  BtnID := TfrxDataSetsActions(TComponent(Sender).Tag);
  pt := SenderBtn.ClientToScreen(Point(0, SenderBtn.Height));
  case BtnID of
    dsaSortData: FSortPopUp.Popup(pt.X, pt.Y);
    dsaSortSelectedData : FSortSelectedPopUp.Popup(pt.X, pt.Y);
  end;
end;

constructor TfrxReportDataForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataSetsList := TfrxEditorDataSetsList.Create;
end;

procedure TfrxReportDataForm.CreatefrxToolWithFilterPanel(var ToolWithFilterPanel: TfrxToolWithFilterPanel);
begin
  ToolWithFilterPanel := TfrxToolWithFilterPanel.Create(Self);
  ToolWithFilterPanel.Parent := Self;
  ToolWithFilterPanel.BorderStyle := bsNone;
  ToolWithFilterPanel.BorderWidth := 0;
{$IFNDEF FPC}
  ToolWithFilterPanel.BevelKind := bkFlat;
  ToolWithFilterPanel.BevelWidth := 1;
  ToolWithFilterPanel.ToolPanel.BevelKind := bkNone;
{$ENDIF}
  ToolWithFilterPanel.AutoSize := False;
  ToolWithFilterPanel.ToolPanel.AutoSize := False;
  ToolWithFilterPanel.ToolPanel.BorderStyle := bsNone;
  ToolWithFilterPanel.ToolPanel.ImageList := frxImages.MainButtonImages;
  ToolWithFilterPanel.FilterActiveImageIndex := 121;
  ToolWithFilterPanel.FilterUnactiveImageIndex := 122;
  ToolWithFilterPanel.ToolPanel.OnBtnClick := ToolOnClick;
  ToolWithFilterPanel.FilterColor := clWindow;
  ToolWithFilterPanel.Align := alTop;
  ToolWithFilterPanel.Height := 30;
  ToolWithFilterPanel.OnFilterChanged := EditChange;
end;

procedure TfrxReportDataForm.CreateSortPopup;
var
  m: TMenuItem;
  procedure CreateItem(sName: String; ImgIdx: Integer);
  begin
      m := TMenuItem.Create(FSortPopUp);
      FSortPopUp.Items.Add(m);
      m.RadioItem := True;
      m.Caption := sName;
      m.ImageIndex := ImgIdx;
      m.Tag := ImgIdx;
      m.OnClick := ToolOnClick;
  end;
begin
  FSortPopUp := TPopupMenu.Create(Self);
  FSortPopUp.Alignment := paLeft;
  FSortPopUp.Images := frxImages.MainButtonImages;
  CreateItem(frxGet(4330), ord(dsaUnsorted));
  CreateItem(frxGet(4328), ord(dsaAscending));
  CreateItem(frxGet(4329), ord(dsaDescending));
end;

procedure TfrxReportDataForm.CreateSortSelectedPopup;
var
  m: TMenuItem;
  procedure CreateItem(sName: String; ImgIdx: Integer);
  begin
      m := TMenuItem.Create(FSortSelectedPopUp);
      FSortSelectedPopUp.Items.Add(m);
      m.RadioItem := True;
      m.Caption := sName;
      m.ImageIndex := ImgIdx;
      m.Tag := ImgIdx;
      m.OnClick := ToolOnClick;
  end;
begin
  FSortSelectedPopUp := TPopupMenu.Create(Self);
  FSortSelectedPopUp.Alignment := paLeft;
  FSortSelectedPopUp.Images := frxImages.MainButtonImages;
  CreateItem(frxGet(3104), ord(dsaAll));
  CreateItem(frxGet(3105), ord(dsaSelected));
  CreateItem(frxGet(3106), ord(dsaUnselected));
end;

{ TfrxEditorDataSetsList }

procedure TfrxEditorDataSetsList.Add(const Name: String; ADataSet: TfrxDataSet; AState: TfrxDataSetItemState);
var
  LDataSetListItem: TfrxDataSetListItem;
begin
  LDataSetListItem := TfrxDataSetListItem(inherited Add);
  LDataSetListItem.DataSetName := Name;
  LDataSetListItem.DataSet := ADataSet;
  LDataSetListItem.State := AState;
end;

constructor TfrxEditorDataSetsList.Create;
begin
  inherited Create(TfrxDataSetListItem);
end;

function TfrxEditorDataSetsList.GetItem(Index: Integer): TfrxDataSetListItem;
begin
  Result := TfrxDataSetListItem(inherited GetItem(Index));
end;

end.
