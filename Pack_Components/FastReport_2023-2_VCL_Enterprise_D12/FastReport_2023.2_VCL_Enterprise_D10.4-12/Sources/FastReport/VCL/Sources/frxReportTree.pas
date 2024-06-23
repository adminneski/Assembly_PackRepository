
{******************************************}
{                                          }
{             FastReport VCL               }
{               Report Tree                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxReportTree;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, frxClass, frxBaseForm, Types, frxComCtrls, frxDock
  {$IFDEF FPC}
  , LCLType
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
  TfrxReportTreeForm = class(TfrxDockForm)
    procedure FormShow(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure TreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FTreePanel: TfrxTreePanel;
    FTree: TfrxTreeView;
    FComponents: TList;
    FDesigner: TfrxCustomDesigner;
    FNodes: TList;
    FReport: TfrxReport;
    FUpdating: Boolean;
    FOnSelectionChanged: TNotifyEvent;
    FSelectedNodeList: TList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure SetColor_(Value: TColor);
    procedure UpdateItems;
    procedure UpdateSelection;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged
      write FOnSelectionChanged;
  end;


implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxRes, frxDesgn, frxDsgnIntf{$IFDEF FPC}, ExtCtrls{$ENDIF}, IniFiles;

type
  THackWinControl = class(TWinControl);


{ TfrxReportTreeForm }

constructor TfrxReportTreeForm.Create(AOwner: TComponent);
begin
  inherited;
  FComponents := TList.Create;
  FNodes := TList.Create;
  FTreePanel := TfrxTreePanel.Create(Self);
  FTreePanel.Parent := Self;
  FTreePanel.Align := alClient;
  FTreePanel.BorderStyle := bsNone;
  FTreePanel.BorderWidth := 0;
{$IFNDEF FPC}
  FTreePanel.BevelKind := bkFlat;
  FTreePanel.BevelWidth := 1;
  FTreePanel.ToolPanel.BevelKind := bkNone;
{$ENDIF}
  FTreePanel.AutoSize := False;
  FTreePanel.ToolPanel.AutoSize := False;
  FTreePanel.ToolPanel.BorderStyle := bsNone;
  FTreePanel.ToolPanel.ImageList := frxImages.MainButtonImages;
  FTreePanel.FilterActiveImageIndex := 121;
  FTreePanel.FilterUnactiveImageIndex := 122;
  FTreePanel.TreeView.DrawExpandButton := True;
  FTreePanel.FilterAlign := fraWidth;
  FTreePanel.ToolPanelAlign := ftaBottom;
  FTreePanel.ToolVisible := False;

  FTree := FTreePanel.TreeView;
  FTree.Align := alClient;
  FTree.TabOrder := 0;
  FTree.BorderStyle := bsNone;
  FTree.DragMode := dmAutomatic;
  FTree.ShowRoot := False;
  FTree.ReadOnly := True;
  FTree.HideSelection := False;
  FTree.MultiSelect := True;
  FTree.MultiSelectStyle := [msControlSelect, msVisibleOnly];
  FTree.OnChange := TreeChange;
  FTree.OnDragDrop := TreeDragDrop;
  FTree.OnDragOver := TreeDragOver;
  FTree.OnKeyDown := TreeKeyDown;
  FTree.OnMouseDown := TreeMouseDown;
{$IFDEF UseTabset}
{$IFNDEF FPC}
  FTree.BevelKind := bkNone;
{$ENDIF}
{$ELSE}
  FTree.BorderStyle := bsSingle;
{$ENDIF}
  FSelectedNodeList := TList.Create;
end;

destructor TfrxReportTreeForm.Destroy;
begin
  FComponents.Free;
  FNodes.Free;
  FSelectedNodeList.Free;
  inherited;
end;

procedure TfrxReportTreeForm.FormShow(Sender: TObject);
begin
  UpdateItems;
end;

procedure TfrxReportTreeForm.LoadFormPreferences(PreferencesStorage,
  DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  FTreePanel.ToolVisible := Ini.ReadBool(GetFormSectionName, 'ToolVisible', FTreePanel.ToolVisible);
end;

procedure TfrxReportTreeForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  FTree.Images := frxImages.ObjectImages;
  FTreePanel.ToolImageList := frxImages.MainButtonImages;
end;

procedure TfrxReportTreeForm.UpdateItems;

  procedure SetImageIndex(Node: TTreeNode; Index: Integer);
  begin
    Node.ImageIndex := Index;
    Node.StateIndex := Index;
    Node.SelectedIndex := Index;
  end;

  procedure EnumItems(c: TfrxComponent; RootNode: TTreeNode);
  var
    i: Integer;
    Node: TTreeNode;
    Item: TfrxObjectItem;
  begin
    if (c is TfrxDataPage) and (frxDesignerComp <> nil) and
      (drDontEditInternalDatasets in frxDesignerComp.Restrictions) then
        Exit;
    Node := FTree.Items.AddChild(RootNode, c.Name);
    FComponents.Add(c);
    FNodes.Add(Node);
    Node.Data := c;
    if c is TfrxReport then
    begin
      Node.Text := 'Report';
      SetImageIndex(Node, 34);
    end
    else if c is TfrxReportPage then
      SetImageIndex(Node, 35)
    else if c is TfrxDialogPage then
      SetImageIndex(Node, 36)
    else if c is TfrxDataPage then
      SetImageIndex(Node, 37)
    else if c is TfrxBand then
      SetImageIndex(Node, 40)
    else
    begin
      for i := 0 to frxObjects.Count - 1 do
      begin
        Item := frxObjects[i];
        if Item.ClassRef = c.ClassType then
        begin
          SetImageIndex(Node, Item.ButtonImageIndex);
          break;
        end;
      end;
    end;

    if c is TfrxDataPage then
    begin
      for i := 0 to c.Objects.Count - 1 do
        if TObject(c.Objects[i]) is TfrxDialogComponent then
          EnumItems(TfrxComponent(c.Objects[i]), Node)
    end
    else
      for i := 0 to c.Objects.Count - 1 do
        EnumItems(TfrxComponent(c.Objects[i]), Node);
  end;

begin
  FTree.Items.BeginUpdate;
  FTree.Items.Clear;
  FComponents.Clear;
  FNodes.Clear;
  EnumItems(FReport, nil);
  FTree.FullExpand;
  UpdateSelection;
  FTree.Items.EndUpdate;
  FTree.UpdateFilter;
end;

procedure TfrxReportTreeForm.TreeChange(Sender: TObject; Node: TTreeNode);
var
  i: Integer;
begin
  {$IFDEF LCLGTK2}
  if Assigned(FReport.Designer) then
  if TfrxDesignerForm(FReport.Designer).LockSelectionChanged then
  begin
    TfrxDesignerForm(FReport.Designer).LockSelectionChanged := False;
    Exit;
  end;
  {$ENDIF}
  if FUpdating then Exit;
  FDesigner.SelectedObjects.Clear;
  FSelectedNodeList.Clear;
  if (FTree.Selected <> nil) and (FTree.Selected.Data <> nil) then
  begin
  if FTree.SelectionCount <= 1 then
  begin
    FDesigner.SelectedObjects.Add(FTree.Selected.Data);
    FSelectedNodeList.Add(FTree.Selected);
  end
  else
  begin
    for i := 0 to FTree.SelectionCount - 1 do
    begin
      FDesigner.SelectedObjects.Add(FTree.Selections[i].Data);
      FSelectedNodeList.Add(FTree.Selections[i]);
    end;
  end;
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;
end;

procedure TfrxReportTreeForm.TreeDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node, SelectedNode: TTreeNode;
  i: Integer;
  c: TfrxReportComponent;
  Modified: Boolean;
begin
  Modified := False;
  if Source = FTree then
  begin
    Node := FTree.GetNodeAt(X, Y);
    if Node <> nil then
    begin
      if (TObject(Node.Data) is TfrxBand) or (TObject(Node.Data) is TfrxReportPage) then
      begin
        FTree.Items.BeginUpdate;
        for i := 0 to FSelectedNodeList.Count - 1 do
        begin
            SelectedNode := TTreeNode(FSelectedNodeList[i]);
            if (TObject(SelectedNode.Data) is TfrxBand) and (SelectedNode <> Node) then
            begin
              while SelectedNode.Count <> 0 do
                if (TObject(SelectedNode.{$IFDEF FPC}Items{$ELSE}Item{$ENDIF}[0].Data) is TfrxReportComponent) and not (TObject(SelectedNode.{$IFDEF FPC}Items{$ELSE}Item{$ENDIF}[0].Data) is TfrxDialogComponent) then
                begin
                  TfrxReportComponent(SelectedNode.{$IFDEF FPC}Items{$ELSE}Item{$ENDIF}[0].Data).Parent := TfrxReportComponent(Node.Data);
                  SelectedNode.{$IFDEF FPC}Items{$ELSE}Item{$ENDIF}[0].MoveTo(Node, naAddChild);
                  Modified := True;
                end;
            end
            else if (TObject(SelectedNode.Data) is TfrxReportComponent) then
            begin
              c := TObject(SelectedNode.Data) as TfrxReportComponent;
              if (c <> nil) and not (c is TfrxDialogComponent) and not(csContained in c.frComponentStyle) then
              begin
                SelectedNode.MoveTo(Node, naAddChild);
                if c <> Node.Data then
                  c.Parent := TfrxReportComponent(Node.Data);
                Modified := True;
              end;
            end;
        end;
        FTree.Items.EndUpdate;
        // for any case, to avoid TreeChange call
        FUpdating := True;
{$IFDEF FPC}
//ApplyStoredSelection
{$ELSE}
        FTree.Select(FSelectedNodeList);
{$ENDIF}
        FUpdating := False;
        if Assigned(FOnSelectionChanged) then
          FOnSelectionChanged(Self);
        if Modified then
          TfrxDesignerForm(FDesigner).Modified := True;
      end;
    end;
  end;
end;

procedure TfrxReportTreeForm.TreeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Node: TTreeNode;
begin
 Node := FTree.GetNodeAt(X, Y);
 if Node <> nil then
   Accept := (TObject(Node.Data) is TfrxBand) or (TObject(Node.Data) is TfrxReportPage);
end;

procedure TfrxReportTreeForm.SaveFormPreferences(PreferencesStorage,
  DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  Ini.WriteBool(GetFormSectionName, 'ToolVisible', FTreePanel.ToolVisible);
end;

procedure TfrxReportTreeForm.SetColor_(Value: TColor);
begin
  FTree.Color := Value;
  FTreePanel.FilterColor := Value;
  UpdateItems;
end;

procedure TfrxReportTreeForm.FormCreate(Sender: TObject);
begin
  FDesigner := TfrxCustomDesigner(Owner);
  FReport := FDesigner.Report;

  Caption := frxGet(2200);

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

{$IFDEF FPC}
type
  THackCustomTreeView = class(TCustomTreeView)
  public
    property ChangeTimer: TTimer read FChangeTimer write FChangeTimer;
  end;
{$ENDIF}

procedure TfrxReportTreeForm.UpdateSelection;
var
  c: TComponent;
  i, idx: Integer;
  SelList: {$IFDEF FPC}Classes.{$ENDIF}TList;
begin
  if FDesigner.SelectedObjects.Count = 0 then
    Exit;

  FUpdating := True;
  FTree.Items.BeginUpdate;
  SelList := {$IFDEF FPC}Classes.{$ENDIF}TList.Create;
  try
    //Tree.ClearSelection();
    for idx := 0 to FDesigner.SelectedObjects.Count - 1 do
    begin
      c := TComponent(FDesigner.SelectedObjects[idx]);
      i := FComponents.IndexOf(c);
      if i <> -1 then
        SelList.Add(FNodes[i]);
{$IFDEF FPC}
// OLD code - remove
//      if i <> -1 then
//      begin
        //SelList.Add(FNodes[i]);
//        if idx = 0 then
//          TTreeNode(FNodes[i]).Selected := True
//        else
//          TTreeNode(FNodes[i]).Selected := True;

 //       Tree.TopItem := TTreeNode(FNodes[i]);
 //     end;
{$ENDIF}
    end;
//{$IFNDEF FPC}
    FTree.Select(SelList);
    if SelList.Count > 0 then
      FTree.TopItem := TTreeNode(SelList[SelList.Count - 1]);
//{$ENDIF}
  finally
    FTree.Items.EndUpdate;
   {$IFDEF FPC}
    THackCustomTreeView(FTree).ChangeTimer.Enabled := False;
   {$ENDIF}
    FUpdating := False;
    SelList.Free;
  end;
end;

procedure TfrxReportTreeForm.TreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    THackWinControl(TfrxDesignerForm(FDesigner).Workspace).KeyDown(Key, Shift);
  end;
end;

procedure TfrxReportTreeForm.TreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
  i: Integer;
begin
  if (PopupMenu = nil) or not (ssRight in Shift) then Exit;
  for i := 0 to FTree.SelectionCount - 1 do
    if FTree.Selections[i].Text = 'Report' then
      Exit;
  p := ClientToScreen(Point(X, Y));
  PopupMenu.Popup(p.X, p.Y);
end;

end.
