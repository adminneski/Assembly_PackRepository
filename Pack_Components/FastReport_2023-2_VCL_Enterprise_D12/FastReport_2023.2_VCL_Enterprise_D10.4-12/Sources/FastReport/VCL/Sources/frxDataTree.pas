
{******************************************}
{                                          }
{             FastReport VCL               }
{          Data Tree tool window           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxDataTree;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, frxClass, fs_xml, ComCtrls, frxBaseForm, frxComCtrls, Menus, frxDock
{$IFDEF UseTabset}
, Tabs
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF}
{$IFDEF DELPHI16}
, System.Types
{$ENDIF};


type
  TfrxDataTreeActions = (dtaNode = 0, dtaDataEdit = 53, dtaVariablesEdit = 52, dtaSortData = 60, dtaUnsorted = 127, dtaAscending = 125, dtaDescending = 126, dtaCollapse = 117, dtaExpand = 118, dtadtfInsCaption = 123, dtaInsField = 124);
  TfrxDataTreeFlag = (dtfInsField, dtfInsCaption);

  TfrxDataTreeFlags = set of TfrxDataTreeFlag;

  TfrxDataTreeForm = class(TfrxDockForm)
    FunctionsPn: TPanel;
    Splitter1: TSplitter;
    HintPanel: TScrollBox;
    FunctionDescL: TLabel;
    FunctionNameL: TLabel;
    NoDataPn: TScrollBox;
    NoDataL: TLabel;
    procedure FormResize(Sender: TObject);
    procedure DataTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FunctionsTreeChange(Sender: TObject; Node: TTreeNode);
    procedure DataTreeDblClick(Sender: TObject);
    procedure ClassesTreeExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure ClassesTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure SortCBClick(Sender: TObject);
  private
    { Private declarations }
    FXML: TfsXMLDocument;
    FImages: TImageList;
    FReport: TfrxReport;
    FUpdating: Boolean;
    FFirstTime: Boolean;
    FMultiSelectAllowed: Boolean;
{$IFDEF UseTabset}
    FTabs: TTabSet;
{$ELSE}
    FTabs: TTabControl;
{$ENDIF}
    FDataTree: TfrxTreeView;
    FClassesTree: TfrxTreeView;
    FDataPanel: TfrxTreePanel;
    FClassesPanel: TfrxTreePanel;
    FVariablesPanel: TfrxTreePanel;
    FVariablesTree: TfrxTreeView;
    FFunctionsPanel: TfrxTreePanel;
    FFunctionsTree: TfrxTreeView;
    FDataTreeFlags: TfrxDataTreeFlags;
    FDataTreeSortType: TfrxTreeSortType;
    FSortPopUp: TPopupMenu;
    FSortButton: TfrxToolPanelButton;
    FVariablesButton: TfrxToolPanelButton;
    FActionBtnList: array[TfrxDataTreeFlag] of TfrxToolPanelButton;
    FUpdateLocked: Boolean;
    procedure FillClassesTree;
    procedure FillDataTree;
    procedure FillFunctionsTree;
    procedure FillVariablesTree;
    procedure CollapseExpand(aExpand: Boolean = False);
    procedure TabsChange(Sender: TObject);
    function GetCollapsedNodes: String;
    procedure ToolOnClick(Sender: TObject);
    function FilterCompare(Sender: TObject; Node: TTreeNode; const aFilter: string): Boolean;
    procedure CreateSortPopup;
    procedure CreatefrxTreePanel(var TreePanel: TfrxTreePanel; var aTreeView: TfrxTreeView);
    procedure CreateDataTreeView;
    procedure CreateClassesTreeView;
    procedure CreateVariablesTreeView;
    procedure CreateFunctionsTreeView;
    function GetClassesTree: TTreeView;
    function GetDataTree: TTreeView;
    function GetFunctionsTree: TTreeView;
    function GetVariablesTree: TTreeView;
    procedure SetDataTreeFlags(const Value: TfrxDataTreeFlags);
    procedure SetDataTreeSortType(const Value: TfrxTreeSortType);
    procedure SetReport(const Value: TfrxReport);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetColor_(AColor: TColor);
    procedure SetControlsParent(AParent: TWinControl);
    procedure SetLastPosition(p: TPoint);
    procedure ShowTab(Index: Integer);
    procedure UpdateItems;
    procedure UpdateSelection;
    procedure UpdateSize;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    procedure CheclMultiSelection;
    procedure DisableUpdate;
    procedure EnableUpdate;
    function GetActivePage: Integer;
    function GetFieldName(SelectionIndex: Integer = -1): String;
    function GetDataSet(SelectionIndex: Integer): TfrxDataSet;
    function ActiveDS: String;
    function GetLastPosition: TPoint;
    function IsDataField: Boolean;
    function GetSelectionCount: Integer;
    function IsDataTree(aSource: TObject): Boolean;
    procedure LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    property DataTreeFlags: TfrxDataTreeFlags read FDataTreeFlags write SetDataTreeFlags;
    property DataTreeSortType: TfrxTreeSortType read FDataTreeSortType write SetDataTreeSortType;
    property Report: TfrxReport read FReport write SetReport;
    property MultiSelectAllowed: Boolean read FMultiSelectAllowed write FMultiSelectAllowed;
    { back compat }
    property ClassesTree: TTreeView read GetClassesTree;
    property DataTree: TTreeView read GetDataTree;
    property FunctionsTree: TTreeView read GetFunctionsTree;
    property VariablesTree: TTreeView read GetVariablesTree;
  end;


implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses fs_iinterpreter, fs_itools, frxRes, IniFiles;

var
  CollapsedNodes: String;

{$IFNDEF FPC}
type
  THackWinControl = class(TWinControl);
{$ENDIF}


procedure SetImageIndex(Node: TTreeNode; Index: Integer);
begin
  Node.ImageIndex := Index;
  Node.StateIndex := Index;
  Node.SelectedIndex := Index;
end;


{ TfrxDataTreeForm }

constructor TfrxDataTreeForm.Create(AOwner: TComponent);
begin
  FDataPanel := nil;
  FVariablesPanel := nil;
  FClassesPanel := nil;
  inherited;
  CreateDataTreeView;
  CreateSortPopup;
  CreateClassesTreeView;
  CreateVariablesTreeView;
  CreateFunctionsTreeView;
  NoDataPn.Parent := FDataTree;
  FMultiSelectAllowed := False;
{$IFDEF UseTabset}
  FDataTree.BevelKind := bkNone;
  FDataTree.BorderStyle := bsNone;
  FVariablesTree.BevelKind := bkNone;
  FFunctionsTree.BevelKind := bkNone;
  FClassesTree.BevelKind := bkNone;
  FFunctionsPanel.BevelKind := bkNone;
{$ELSE}
  FDataTree.BorderStyle := bsNone;
  FVariablesTree.BorderStyle := bsNone;
  FFunctionsTree.BorderStyle := bsNone;
  FClassesTree.BorderStyle := bsNone;
  FFunctionsPanel.BorderStyle := bsNone;
{$ENDIF}
  FXML := TfsXMLDocument.Create;
  FFirstTime := True;
{$IFDEF UseTabset}
  FTabs := TTabSet.Create(Self);
  FTabs.ShrinkToFit := True;
  FTabs.Style := tsSoftTabs;
  FTabs.TabPosition := tpTop;
{$ELSE}
  FTabs := TTabControl.Create(Self);
{$ENDIF}
  FTabs.Parent := Self;
  FTabs.Font.Size := 8;
  FTabs.SendToBack;

  Caption := frxGet(2100);
  FTabs.Tabs.AddObject(frxGet(2101), FDataPanel);
  FTabs.Tabs.AddObject(frxGet(2102), FVariablesPanel);
  FTabs.Tabs.AddObject(frxGet(2103), FunctionsPn);
  FTabs.Tabs.AddObject(frxGet(2106), FClassesPanel);
  FTabs.TabIndex := 0;
{$IFDEF UseTabset}
  FTabs.OnClick := TabsChange;
{$ELSE}
  FTabs.OnChange := TabsChange;
{$ENDIF}
  FDataTreeFlags := [dtfInsField];
end;

procedure TfrxDataTreeForm.CreateClassesTreeView;
begin
  CreatefrxTreePanel(FClassesPanel, FClassesTree);
  FClassesPanel.Visible := False;
  FClassesPanel.ToolPanel.AddButton(ord(dtaCollapse), frxGet(601), ord(dtaCollapse), fbsButton);
  FClassesPanel.ToolPanel.AddButton(ord(dtaExpand), frxGet(600), ord(dtaExpand), fbsButton);
  FClassesTree := FClassesPanel.TreeView;
  FClassesTree.TabOrder := 0;
  FClassesTree.OnFilterCompare := FilterCompare;
  FClassesTree.ExpandLevel := 0;
  FClassesTree.OnCustomDrawItem := ClassesTreeCustomDrawItem;
  FClassesTree.OnDblClick := DataTreeDblClick;
  FClassesTree.OnExpanding := ClassesTreeExpanding;
end;

procedure TfrxDataTreeForm.CreateDataTreeView;
begin
  CreatefrxTreePanel(FDataPanel, FDataTree);
  FDataPanel.ToolPanel.AddButton(ord(dtaDataEdit), frxGet(3100), ord(dtaDataEdit), fbsButton);
  FSortButton := FDataPanel.ToolPanel.AddButton(ord(dtaUnsorted), frxGet(4117), ord(dtaSortData), fbsDropDownButton);
  FDataPanel.ToolPanel.AddCustomButton(fbkSeparator);
  FDataPanel.ToolPanel.AddButton(ord(dtaCollapse), frxGet(601), ord(dtaCollapse), fbsButton);
  FDataPanel.ToolPanel.AddButton(ord(dtaExpand), frxGet(600), ord(dtaExpand), fbsButton);

  FDataPanel.ToolPanel.AddCustomButton(fbkSeparator);
  FActionBtnList[dtfInsField] := TfrxToolPanelButton(FDataPanel.ToolPanel.AddButton(ord(dtaInsField), frxGet(2104), ord(dtaInsField), fbsCheckButton, 0));
  FActionBtnList[dtfInsCaption] := FDataPanel.ToolPanel.AddButton(ord(dtadtfInsCaption), frxGet(2105), ord(dtadtfInsCaption), fbsCheckButton, 0);
  FDataTree.OnCustomDrawItem := DataTreeCustomDrawItem;
  FDataTree.OnDblClick := DataTreeDblClick;
end;

procedure TfrxDataTreeForm.CreatefrxTreePanel(var TreePanel: TfrxTreePanel; var aTreeView: TfrxTreeView);
begin
  TreePanel := TfrxTreePanel.Create(Self);
  TreePanel.Parent := Self;
  TreePanel.BorderStyle := bsNone;
  TreePanel.BorderWidth := 0;
{$IFNDEF FPC}
  TreePanel.BevelKind := bkFlat;
  TreePanel.BevelWidth := 1;
  TreePanel.ToolPanel.BevelKind := bkNone;
{$ENDIF}
  TreePanel.AutoSize := False;
  TreePanel.ToolPanel.AutoSize := False;
  TreePanel.ToolPanel.BorderStyle := bsNone;
  TreePanel.ToolPanel.ImageList := frxImages.MainButtonImages;
  TreePanel.FilterActiveImageIndex := 121;
  TreePanel.FilterUnactiveImageIndex := 122;
  TreePanel.ToolPanel.OnBtnClick := ToolOnClick;
  TreePanel.TreeView.DrawExpandButton := True;
  TreePanel.FilterColor := clWindow;

  aTreeView := TreePanel.TreeView;
  aTreeView.Align := alClient;
  aTreeView.TabOrder := 2;
  aTreeView.BorderStyle := bsNone;
  aTreeView.DragMode := dmAutomatic;
  aTreeView.ShowRoot := False;
  aTreeView.ReadOnly := True;
  aTreeView.HideSelection := False;
{$IFNDEF FPC}
  aTreeView.BevelKind := bkNone;
{$ENDIF}
end;

procedure TfrxDataTreeForm.CreateFunctionsTreeView;
begin
  CreatefrxTreePanel(FFunctionsPanel, FFunctionsTree);
  FFunctionsPanel.Parent := FunctionsPn;
  FFunctionsPanel.Align := alClient;
  FFunctionsTree.OnChange := FunctionsTreeChange;
  FFunctionsTree.OnCustomDrawItem := DataTreeCustomDrawItem;
  FFunctionsTree.OnDblClick := DataTreeDblClick;
  FFunctionsTree.TabOrder := 1;
  FFunctionsPanel.ToolPanel.AddButton(ord(dtaCollapse), frxGet(601), ord(dtaCollapse), fbsButton);
  FFunctionsPanel.ToolPanel.AddButton(ord(dtaExpand), frxGet(600), ord(dtaExpand), fbsButton);
  FFunctionsTree := FFunctionsPanel.TreeView;
{$IFDEF UseTabset}
  FunctionsPn.BevelKind := bkFlat;
  FunctionsPn.BevelWidth := 1;
{$ENDIF}
end;

procedure TfrxDataTreeForm.CreateSortPopup;
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
  FSortPopUp := TPopupMenu.Create(nil);
  FSortPopUp.Images := frxImages.MainButtonImages;
  CreateItem(frxGet(4330), ord(dtaUnsorted));
  CreateItem(frxGet(4328), ord(dtaAscending));
  CreateItem(frxGet(4329), ord(dtaDescending));
end;

procedure TfrxDataTreeForm.CreateVariablesTreeView;
begin
  CreatefrxTreePanel(FVariablesPanel, FVariablesTree);
  FVariablesTree.OnCustomDrawItem := DataTreeCustomDrawItem;
  FVariablesTree.OnDblClick := DataTreeDblClick;
  FVariablesPanel.Visible := False;
  FVariablesButton := FVariablesPanel.ToolPanel.AddButton(ord(dtaVariablesEdit), frxGet(2425), ord(dtaVariablesEdit), fbsButton);
  FVariablesPanel.ToolPanel.AddButton(ord(dtaCollapse), frxGet(601), ord(dtaCollapse), fbsButton);
  FVariablesPanel.ToolPanel.AddButton(ord(dtaExpand), frxGet(600), ord(dtaExpand), fbsButton);
  FVariablesTree := FVariablesPanel.TreeView;
  FVariablesPanel.ToolVisible := False;
end;

destructor TfrxDataTreeForm.Destroy;
begin
  if Owner is TfrxCustomDesigner then
    CollapsedNodes := GetCollapsedNodes;
  FUpdating := True;
  FXML.Free;
  FreeAndNil(FSortPopUp);
  inherited;
end;

procedure TfrxDataTreeForm.DisableUpdate;
begin
  FUpdateLocked := True;
end;

procedure TfrxDataTreeForm.EnableUpdate;
begin
  FUpdateLocked := False;
end;

function TfrxDataTreeForm.ActiveDS: String;
var
  Node: TTreeNode;
begin
  Result := '';
  if FTabs.TabIndex = 0 then   // data
  begin
    Node := FDataTree.Selected;
    if (Node <> nil) and (Node.Count <> 0) and (Node.Data <> nil) and (TfrxDataSet(Node.Data).UserName = Node.Text) then
      Result := FReport.GetAlias(TfrxDataSet(Node.Data));
  end;

end;

procedure TfrxDataTreeForm.FillDataTree;
var
  ds: TfrxDataSet;
  DatasetsList, FieldsList: TStrings;
  i, j, ind, nDSCount, nFCount, nInc: Integer;
  Root, Node1, Node2: TTreeNode;
  s, Collapsed: String;
begin
  case DataTreeSortType of
    dtsUnsorted: FSortButton.ImageIndex := Ord(dtaUnsorted);
    dtsAscending: FSortButton.ImageIndex := Ord(dtaAscending);
    dtsDescending: FSortButton.ImageIndex := Ord(dtaDescending);
  end;
  DatasetsList := TStringList.Create;
  FieldsList := TStringList.Create;
  TStringList(FieldsList).Sorted := (FDataTreeSortType <> dtsUnsorted);
  TStringList(DatasetsList).Sorted := (FDataTreeSortType <> dtsUnsorted);

  FReport.GetDataSetList(DatasetsList);

  try
    if FFirstTime then
      Collapsed := CollapsedNodes
    else
      Collapsed := GetCollapsedNodes;

    FDataTree.Items.BeginUpdate;
    FDataTree.Items.Clear;
    if DatasetsList.Count = 0 then
    begin
      NoDataL.Caption := frxResources.Get('dtNoData') + #13#10#13#10 +
        frxResources.Get('dtNoData1');
      NoDataPn.Visible := True;
    end
    else
    begin
      NoDataPn.Visible := False;
      s := frxResources.Get('dtData');
      Root := FDataTree.Items.AddChild(nil, s);
      SetImageIndex(Root, 53);
      i := 0;
      nDSCount := DatasetsList.Count - 1;
      nInc := 1;
      if FDataTreeSortType = dtsDescending then
      begin
        i := DatasetsList.Count - 1;
        nDSCount := 0;
        nInc := -1;
      end;
      while i * nInc <= nDSCount do
      begin
        if DatasetsList.Objects[i] is TfrxDataset then
          ds := TfrxDataSet(DatasetsList.Objects[i])
        else ds := nil;
        if ds = nil then
        begin
          Inc(i, nInc);
          continue;
        end;
        try
          ds.GetFieldList(FieldsList);
        except
        end;
        j := 0;
        nFCount := FieldsList.Count - 1;
        if FDataTreeSortType = dtsDescending then
        begin
          j := FieldsList.Count - 1;
          nFCount := 0;
        end;
        Node1 := FDataTree.Items.AddChild(Root, FReport.GetAlias(ds));
        Node1.Data := ds;
        SetImageIndex(Node1, 72);

        while j * nInc <= nFCount do
        begin
          Node2 := FDataTree.Items.AddChild(Node1, FieldsList[j]);
          Node2.Data := ds;
          ind := 54;
          case ds.FieldType[FieldsList[j]] of
            fftNumeric: ind := 104;
            fftString: ind := 102;
            fftBoolean: ind := 107;
            fftDateTime: ind := 106;
          end;
          SetImageIndex(Node2, ind);
          Inc(j, nInc);
        end;
        Inc(i, nInc);
      end;
      FDataTree.Items[0].Expanded := True;
      for i := 0 to FDataTree.Items[0].Count - 1 do
      begin
        s := FDataTree.Items[0][i].Text;
        if Pos(s + ',', Collapsed) = 0 then
          FDataTree.Items[0][i].Expanded := True;
      end;
    end;
  finally
    FDataTree.Items.EndUpdate;
    DatasetsList.Free;
    FieldsList.Free;
  end;
end;

procedure TfrxDataTreeForm.FillVariablesTree;
var
  CategoriesList, VariablesList: TStrings;
  i: Integer;
  Root, Node: TTreeNode;

  procedure AddVariables(Node: TTreeNode);
  var
    i: Integer;
    Node1: TTreeNode;
  begin
    for i := 0 to VariablesList.Count - 1 do
    begin
      Node1 := FVariablesTree.Items.AddChild(Node, VariablesList[i]);
      SetImageIndex(Node1, 80);
    end;
  end;

  procedure AddSystemVariables;
  var
    SysNode: TTreeNode;

    procedure AddNode(const s: String);
    var
      Node: TTreeNode;
    begin
      Node := FVariablesTree.Items.AddChild(SysNode, s);
      SetImageIndex(Node, 80);
    end;

  begin
    SysNode := FVariablesTree.Items.AddChild(Root, frxResources.Get('dtSysVar'));
    SetImageIndex(SysNode, 66);

    AddNode('Date');
    AddNode('Time');
    AddNode('Page');
    AddNode('Page#');
    AddNode('TotalPages');
    AddNode('TotalPages#');
    AddNode('Line');
    AddNode('Line#');
    AddNode('CopyName#');
    AddNode('TableRow');
    AddNode('TableColumn');
  end;

begin
  CategoriesList := TStringList.Create;
  VariablesList := TStringList.Create;
  FReport.Variables.GetCategoriesList(CategoriesList);

  FVariablesTree.Items.BeginUpdate;
  FVariablesTree.Items.Clear;
  Root := FVariablesTree.Items.AddChild(nil, frxResources.Get('dtVar'));
  SetImageIndex(Root, 66);

  for i := 0 to CategoriesList.Count - 1 do
  begin
    FReport.Variables.GetVariablesList(CategoriesList[i], VariablesList);
    Node := FVariablesTree.Items.AddChild(Root, CategoriesList[i]);
    SetImageIndex(Node, 66);
    AddVariables(Node);
  end;

  if CategoriesList.Count = 0 then
  begin
    FReport.Variables.GetVariablesList('', VariablesList);
    AddVariables(Root);
  end;

  AddSystemVariables;

  FVariablesTree.FullExpand;
  FVariablesTree.TopItem := Root;
  FVariablesTree.Items.EndUpdate;
  CategoriesList.Free;
  VariablesList.Free;
end;

function TfrxDataTreeForm.FilterCompare(Sender: TObject; Node: TTreeNode;
  const aFilter: string): Boolean;
var
  i: Integer;
  xi: TfsXMLItem;
  s: String;
begin
  Result := False;
  if Assigned(Node) and (Node.Text = 'more...') and Assigned(Node.Parent) and (Node.Parent.Data <> nil) then
  begin
    s := UpperCase(aFilter);
    xi := TfsXMLItem(Node.Parent.Data);
    for i := 0 to xi.Count - 1 do
    begin
      if (Pos(s, UpperCase(xi[i].Prop['text'])) > 0) then
      begin
        Result := True;
        Exit;
      end;      
    end;
  end;    
end;

procedure TfrxDataTreeForm.FillFunctionsTree;

  procedure AddFunctions(xi: TfsXMLItem; Root: TTreeNode);
  var
    i: Integer;
    Node: TTreeNode;
    s: String;
  begin
    s := xi.Prop['text'];
    if xi.Count = 0 then
      s := Copy(s, Pos(' ', s) + 1, 255) else  { function }
      s := frxResources.Get(s);                { category }

    if CompareText(s, 'hidden') = 0 then Exit;
    Node := FFunctionsTree.Items.AddChild(Root, s);
    if xi.Count = 0 then
      Node.Data := xi;
    if Root = nil then
      Node.Text := frxResources.Get('dtFunc');
    if xi.Count = 0 then
      SetImageIndex(Node, 52) else
      SetImageIndex(Node, 66);

    for i := 0 to xi.Count - 1 do
      AddFunctions(xi[i], Node);
  end;

begin
  FUpdating := True;

  FFunctionsTree.Items.BeginUpdate;
  FFunctionsTree.Items.Clear;
  AddFunctions(FXML.Root.FindItem('Functions'), nil);

  FFunctionsTree.FullExpand;
  FFunctionsTree.TopItem := FFunctionsTree.Items[0];
  FFunctionsTree.Items.EndUpdate;
  FUpdating := False;
end;

procedure TfrxDataTreeForm.FillClassesTree;

  procedure AddClasses(xi: TfsXMLItem; Root: TTreeNode);
  var
    i: Integer;
    Node: TTreeNode;
    s: String;
  begin
    s := xi.Prop['text'];

    Node := FClassesTree.Items.AddChild(Root, s);
    Node.Data := xi;
    if Root = nil then
    begin
      Node.Text := frxResources.Get('2106');
      SetImageIndex(Node, 66);
    end
    else
      SetImageIndex(Node, 78);

    if Root = nil then
    begin
      for i := 0 to xi.Count - 1 do
        AddClasses(xi[i], Node);
    end
    else
      FClassesTree.Items.AddChild(Node, 'more...');  // do not localize
  end;

begin
  FUpdating := True;

  FClassesTree.Items.BeginUpdate;
  FClassesTree.Items.Clear;
  AddClasses(FXML.Root.FindItem('Classes'), nil);

  FClassesTree.TopItem := FClassesTree.Items[0];
  FClassesTree.TopItem.Expand(False);
  FClassesTree.Items.EndUpdate;
  FUpdating := False;
end;

function TfrxDataTreeForm.GetClassesTree: TTreeView;
begin
  Result := FClassesTree;
end;

function TfrxDataTreeForm.GetCollapsedNodes: String;
var
  i: Integer;
  s: String;
begin
  Result := '';
  if FDataTree.Items.Count > 0 then
    for i := 0 to FDataTree.Items[0].Count - 1 do
    begin
      s := FDataTree.Items[0][i].Text;
      if not FDataTree.Items[0][i].Expanded then
        Result := Result + s + ',';
    end;
end;

function TfrxDataTreeForm.GetDataSet(SelectionIndex: Integer): TfrxDataSet;
begin
  Result := nil;
  if FTabs.TabIndex = 0 then   // data
    if (Integer(FDataTree.SelectionCount) > SelectionIndex) and (SelectionIndex >= 0) then
      Result := TfrxDataSet(FDataTree.Selections[SelectionIndex].Data)
    else
      Result := TfrxDataSet(FDataTree.Selected.Data)
end;

function TfrxDataTreeForm.GetDataTree: TTreeView;
begin
  Result := FDataTree;
end;

function TfrxDataTreeForm.GetFieldName(SelectionIndex: Integer = -1): String;
var
  i, n: Integer;
  s: String;
  Node: TTreeNode;
begin
  Result := '';
  if FTabs.TabIndex = 0 then   // data
  begin
    if (Integer(FDataTree.SelectionCount) > SelectionIndex) and (SelectionIndex >= 0) then
      Node := FDataTree.Selections[SelectionIndex]
    else
      Node := FDataTree.Selected;
    if (Node <> nil) and (Node.Count = 0) and (Node.Data <> nil) then
      Result := '<' + FReport.GetAlias(TfrxDataSet(Node.Data)) +
        '."' + Node.Text + '"' + '>';
  end
  else if FTabs.TabIndex = 1 then  // variables
  begin
    Node := FVariablesTree.Selected;
    if (Node <> nil) and (Node.Count = 0) then
      if Node.Data <> nil then
        Result := Node.Text else
        Result := '<' + Node.Text + '>';
  end
  else if FTabs.TabIndex = 2 then  // functions
  begin
    if (FFunctionsTree.Selected <> nil) and (FFunctionsTree.Selected.Count = 0) then
    begin
      s := FFunctionsTree.Selected.Text;
      if Pos('(', s) <> 0 then
        n := 1 else
        n := 0;
      for i := 1 to Length(s) do
{$IFDEF DELPHI12}
        if CharInSet(s[i], [',', ';']) then
{$ELSE}
        if s[i] in [',', ';'] then
{$ENDIF}
          Inc(n);

      if n = 0 then
        s := Copy(s, 1, Pos(':', s) - 1)
      else
      begin
        s := Copy(s, 1, Pos('(', s));
        for i := 1 to n - 1 do
          s := s + ',';
        s := s + ')';
      end;
      Result := s;
    end;
  end;
end;

function TfrxDataTreeForm.GetFunctionsTree: TTreeView;
begin
  Result := FFunctionsTree;
end;

function TfrxDataTreeForm.IsDataField: Boolean;
begin
  Result := FTabs.TabIndex = 0;
end;

function TfrxDataTreeForm.IsDataTree(aSource: TObject): Boolean;
begin
  Result := (FDataTree = aSource);
end;

procedure TfrxDataTreeForm.LoadFormPreferences(PreferencesStorage,
  DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  FDataPanel.ToolVisible := Ini.ReadBool(lName, 'Data.ToolVisible', FDataPanel.ToolVisible);
  FVariablesPanel.ToolVisible := Ini.ReadBool(lName, 'Variables.ToolVisible', FVariablesPanel.ToolVisible);
  FFunctionsPanel.ToolVisible := Ini.ReadBool(lName, 'Functions.ToolVisible', FFunctionsPanel.ToolVisible);
  FClassesPanel.ToolVisible := Ini.ReadBool(lName, 'Classes.ToolVisible', FClassesPanel.ToolVisible);
  DataTreeFlags := TfrxDataTreeFlags(Byte(Ini.ReadInteger(lName, 'DataTreeFlags', Byte(DataTreeFlags))));
  DataTreeSortType := TfrxTreeSortType(Ini.ReadInteger(lName, 'DataTreeSortType', Byte(DataTreeSortType)));
end;

procedure TfrxDataTreeForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  FImages := frxImages.MainButtonImages;
  FDataTree.Images := FImages;
  FVariablesTree.Images := FImages;
  FFunctionsTree.Images := FImages;
  FClassesTree.Images := FImages;
  FClassesPanel.ToolImageList := FImages;
  FFunctionsPanel.ToolImageList := FImages;
  FVariablesPanel.ToolImageList := FImages;
  FDataPanel.ToolImageList := FImages;
  FTabs.Height := Abs(FTabs.Font.Height) + Round(8 * aNewPPI / frx_DefaultPPI);
  if Assigned(FTabs) then
    UpdateSize;
end;

procedure TfrxDataTreeForm.UpdateItems;
begin
  if FUpdateLocked then Exit;  
  FillDataTree;
  FillVariablesTree;
  FFirstTime := False;
end;

procedure TfrxDataTreeForm.SaveFormPreferences(PreferencesStorage,
  DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  Ini.WriteBool(lName, 'Data.ToolVisible', FDataPanel.ToolVisible);
  Ini.WriteBool(lName, 'Variables.ToolVisible', FVariablesPanel.ToolVisible);
  Ini.WriteBool(lName, 'Functions.ToolVisible', FFunctionsPanel.ToolVisible);
  Ini.WriteBool(lName, 'Classes.ToolVisible', FClassesPanel.ToolVisible);
  Ini.WriteInteger(lName, 'DataTreeFlags', Byte(DataTreeFlags));
  Ini.WriteInteger(lName, 'DataTreeSortType', Byte(DataTreeSortType));
end;

procedure TfrxDataTreeForm.SetColor_(AColor: TColor);
begin
  FDataTree.Color := AColor;
  FDataPanel.FilterColor := AColor;
  FVariablesTree.Color := AColor;
  FVariablesPanel.FilterColor := AColor;
  FFunctionsTree.Color := AColor;
  FFunctionsPanel.FilterColor := AColor;
  HintPanel.Color := AColor;
  FClassesTree.Color := AColor;
  FClassesPanel.FilterColor := AColor;
end;

procedure TfrxDataTreeForm.FormResize(Sender: TObject);
begin
  UpdateSize;
end;

procedure TfrxDataTreeForm.DataTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.Count <> 0 then
    Sender.Canvas.Font.Style := [fsBold];
end;

procedure TfrxDataTreeForm.CheclMultiSelection;
begin
  FDataTree.MultiSelect := FDataPanel.Visible and FMultiSelectAllowed;
end;

procedure TfrxDataTreeForm.ClassesTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.Level = 0 then
    Sender.Canvas.Font.Style := [fsBold];
end;

procedure TfrxDataTreeForm.FunctionsTreeChange(Sender: TObject;
  Node: TTreeNode);
var
  xi: TfsXMLItem;
begin
  if FUpdating then Exit;
  Node := FFunctionsTree.Selected;
  if (Node = nil) or (Node.Data = nil) then
  begin
    FunctionNameL.Caption := '';
    FunctionDescL.Caption := '';
    Exit;
  end
  else
  begin
    xi := TfsXMLItem(Node.Data);
    FunctionNameL.Caption := xi.Prop['text'];
    FunctionDescL.Caption := frxResources.Get(xi.Prop['description']);
    FunctionNameL.AutoSize := True;
  end;
end;

procedure TfrxDataTreeForm.DataTreeDblClick(Sender: TObject);
begin
  if Assigned(OnDblClick) then
    OnDblClick(Sender);
end;

procedure TfrxDataTreeForm.ClassesTreeExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
var
  i: Integer;
  xi: TfsXMLItem;
  s: String;
  n: TTreeNode;
begin
  if (Node.Level = 1) and (Node.Data <> nil) then
  begin
    FUpdating := True;
    FClassesTree.Items.BeginUpdate;

    Node.DeleteChildren;
    xi := TfsXMLItem(Node.Data);
    Node.Data := nil;

    for i := 0 to xi.Count - 1 do
    begin
      s := xi[i].Prop['text'];
      n := FClassesTree.Items.AddChild(Node, s);
      if Pos('property', s) = 1 then
        SetImageIndex(n, 73)
      else if Pos('event', s) = 1 then
        SetImageIndex(n, 79)
      else
        SetImageIndex(n, 74);
    end;

    FClassesTree.Items.EndUpdate;
    FUpdating := False;
    FClassesTree.UpdateFilter;
  end;
end;

procedure TfrxDataTreeForm.CollapseExpand(aExpand: Boolean = False);
var
  i: Integer;
  TreeView: TTreeView;
begin
//  i := FTabs.TabIndex;
//  if (i < 0) or not((FTabs.Tabs.Objects[i] <> nil) and
//    (TObject(FTabs.Tabs.Objects[i]).InheritsFrom(TfrxTreePanel))) then
//    Exit;
  TreeView := FDataTree;
  if (FTabs.TabIndex = 1) then
    TreeView := FVariablesTree
  else if (FTabs.TabIndex = 2) then
    TreeView := FFunctionsTree
  else if (FTabs.TabIndex = 3) then
    TreeView := FClassesTree;
  //TreeView := TfrxTreePanel(FTabs.Tabs.Objects[i]).TreeView;
  if TreeView.Items.Count = 0 then Exit;
  TreeView.Items.BeginUpdate;
  try
    for i := 0 to TreeView.Items[0].Count - 1 do
      TreeView.Items[0][i].Expanded := aExpand;
  finally
    TreeView.Items.EndUpdate;
  end;  
end;

function TfrxDataTreeForm.GetLastPosition: TPoint;
var
  Item: TTreeNode;
begin
  Result.X := FTabs.TabIndex;
  Result.Y := 0;
  Item := nil;
  case Result.X of
    0: Item := FDataTree.TopItem;
    1: Item := FVariablesTree.TopItem;
    2: Item := FFunctionsTree.TopItem;
    3: Item := FClassesTree.TopItem;
  end;
  if Item <> nil then
    Result.Y := Item.AbsoluteIndex;
end;

function TfrxDataTreeForm.GetSelectionCount: Integer;
var
  Atree: TTreeView;
begin
  Result := 0;
  Atree := FDataTree;
  if FTabs.TabIndex = 0 then
  begin
    Result := FDataTree.SelectionCount;
    Exit;
  end
  else if (FTabs.TabIndex = 1) then
    Atree := FVariablesTree
  else if (FTabs.TabIndex = 2) then
    Atree := FFunctionsTree
  else if (FTabs.TabIndex = 3) then
    Atree := FClassesTree;

  if Atree.Selected <> nil then
     Result := 1;
end;

function TfrxDataTreeForm.GetVariablesTree: TTreeView;
begin
  Result := FVariablesTree;
end;

procedure TfrxDataTreeForm.SetLastPosition(p: TPoint);
begin
  ShowTab(p.X);
  case p.X of
    0: if FDataTree.Items.Count > 0 then FDataTree.TopItem := FDataTree.Items[p.Y];
    1: if FVariablesTree.Items.Count > 0 then FVariablesTree.TopItem := FVariablesTree.Items[p.Y];
    2: if FFunctionsTree.Items.Count > 0 then FFunctionsTree.TopItem := FFunctionsTree.Items[p.Y];
    3: if FClassesTree.Items.Count > 0 then FClassesTree.TopItem := FClassesTree.Items[p.Y];
  end;
end;

procedure TfrxDataTreeForm.SetReport(const Value: TfrxReport);
begin
  FReport := Value;
  if Assigned(FVariablesButton) then
    FVariablesButton.Enabled := Assigned(FReport) and Assigned(FReport.Designer) and FReport.Designer.CheckOp(drDontEditVariables);
end;

procedure TfrxDataTreeForm.TabsChange(Sender: TObject);
begin
  ShowTab(FTabs.TabIndex);
end;

procedure TfrxDataTreeForm.ToolOnClick(Sender: TObject);
var
  BtnID: TfrxDataTreeActions;
  SenderBtn: TfrxToolPanelButton;
  NewSortType: TfrxTreeSortType;
  pt: TPoint;
begin
  if Sender is TMenuItem then
  begin
    BtnID := TfrxDataTreeActions(TMenuItem(Sender).Tag);
    NewSortType := dtsUnsorted;
    case BtnID of
      dtaUnsorted: NewSortType := dtsUnsorted;
      dtaAscending: NewSortType := dtsAscending;
      dtaDescending: NewSortType := dtsDescending;
    end;
    if FDataTreeSortType <> NewSortType then
      DataTreeSortType := NewSortType;
    Exit;
  end;

  if not Sender.InheritsFrom(TfrxToolPanelButton) then Exit;
  SenderBtn := TfrxToolPanelButton(Sender);
  BtnID := TfrxDataTreeActions(TComponent(Sender).Tag);
  pt := SenderBtn.ClientToScreen(Point(0, SenderBtn.Height));
  case BtnID of
    dtaDataEdit: if Assigned(Report) and Assigned(Report.Designer) then Report.Designer.ReportDataEdit;
    dtaSortData: FSortPopUp.Popup(pt.X, pt.Y);
    dtaCollapse: CollapseExpand;
    dtaExpand: CollapseExpand(True);
    dtadtfInsCaption: if SenderBtn.IsDown then Include(FDataTreeFlags, dtfInsCaption) else Exclude(FDataTreeFlags, dtfInsCaption);
    dtaInsField: if SenderBtn.IsDown then Include(FDataTreeFlags, dtfInsField) else Exclude(FDataTreeFlags, dtfInsField);
    dtaVariablesEdit: if Assigned(Report) and Assigned(Report.Designer) then Report.Designer.ReportEditVariable;
  end;
end;

procedure TfrxDataTreeForm.ShowTab(Index: Integer);
{$IFNDEF FPC}
var
  i: Integer;
{$ENDIF}
begin
  if (Index < 0) or (Index > FTabs.Tabs.Count - 1) then Exit;
  FTabs.TabIndex := Index;
  {$IFDEF FPC}
  FDataPanel.Visible := Index = 0;
  FVariablesPanel.Visible := Index = 1;
  FunctionsPn.Visible := Index = 2;
  FClassesPanel.Visible := Index = 3;
  {$ELSE}
  for i := 0 to FTabs.Tabs.Count - 1 do
    TControl(FTabs.Tabs.Objects[i]).Visible := i = Index;
  {$ENDIF}
  CheclMultiSelection;
  if FXML.Root.Count = 0 then
  begin
    FReport.Script.AddRTTI;
    GenerateXMLContents(FReport.Script, FXML.Root);
  end;

  if (Index = 2) and (FFunctionsTree.Items.Count = 0) then
    FillFunctionsTree;
  if (Index = 3) and (FClassesTree.Items.Count = 0) then
    FillClassesTree;
end;

procedure TfrxDataTreeForm.SetControlsParent(AParent: TWinControl);
begin
  FTabs.Parent := AParent;
  FDataPanel.Parent := AParent;
  FVariablesPanel.Parent := AParent;
  FunctionsPn.Parent := AParent;
  FClassesPanel.Parent := AParent;
end;

procedure TfrxDataTreeForm.SetDataTreeFlags(const Value: TfrxDataTreeFlags);
begin
  FDataTreeFlags := Value;
  FActionBtnList[dtfInsField].IsDown := (dtfInsField in Value);
  FActionBtnList[dtfInsCaption].IsDown := (dtfInsCaption in Value);
end;

procedure TfrxDataTreeForm.SetDataTreeSortType(
  const Value: TfrxTreeSortType);
begin
  if FDataTreeSortType = Value then Exit;
  FDataTreeSortType := Value;
  FillDataTree;
end;

procedure TfrxDataTreeForm.UpdateSize;
var
  Y: Integer;
begin
  if FTabs = nil then Exit;  
  AutoScroll := False;
  with FTabs.Parent do
  begin
    Y := FTabs.Height;
    FTabs.SetBounds(0, 0, ClientWidth, Y);
{$IFDEF UseTabset}
    Y := FTabs.Height - 1;
{$ELSE}
    Y := FTabs.Height - 2;
{$ENDIF}
    if Assigned(FDataPanel) then
    begin
      FDataPanel.SetBounds(0, Y, ClientWidth, ClientHeight - Y);
      NoDataPn.SetBounds(10, 20, FDataPanel.Width - 20, 140);
    end;
    if Assigned(FVariablesPanel) then
      FVariablesPanel.SetBounds(0, Y, ClientWidth, ClientHeight - Y);
    FunctionsPn.SetBounds(0, Y, ClientWidth, ClientHeight - Y);
    if Assigned(FClassesPanel) then
      FClassesPanel.SetBounds(0, Y, ClientWidth, ClientHeight - Y);
  end;
  //Lazarus bug. Del when fix. issue 241.
{$IFNDEF FPC}
  FunctionNameL.AutoSize := False;
  FunctionNameL.AutoSize := True;
{$ENDIF}
end;

function TfrxDataTreeForm.GetActivePage: Integer;
begin
  Result := FTabs.TabIndex;
end;

procedure TfrxDataTreeForm.UpdateSelection;
var
  i: Integer;
begin
  if GetActivePage = 0 then
  begin
    FDataTree.Selected := nil;
    if Assigned(Report) and Assigned(Report.Designer) and
      Assigned(Report.Designer.SelectedObjects) and
      (Report.Designer.SelectedObjects.Count = 1) and
      (TObject(Report.Designer.SelectedObjects[0]) is TfrxDataset) then
    begin
      for i := 0 to FDataTree.Items.Count - 1 do
        if FDataTree.Items[i].Data = Report.Designer.SelectedObjects[0] then
        begin
          FDataTree.Selected := FDataTree.Items[i];
          break;
        end;
    end;
  end;
end;

procedure TfrxDataTreeForm.SortCBClick(Sender: TObject);
begin
  FillDataTree;
end;

end.
