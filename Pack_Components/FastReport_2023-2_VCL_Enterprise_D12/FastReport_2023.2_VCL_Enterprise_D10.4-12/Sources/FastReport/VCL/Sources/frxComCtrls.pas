unit frxComCtrls;
{$I frx.inc}
interface

uses
  {$IFNDEF NONWINFPC}Windows, CommCtrl,{$ENDIF}
  {$IFDEF FPC}LCLType, LMessages, LCLIntf, LazHelper, LazarusPackageIntf,{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics,
  Controls, ComCtrls, frxDPIAwareBaseControls, frxUtils, frxCtrls, ImgList,
  frDPIAwareUtils, frDPIAwareInt, frTypes;

type
  TfrxFilterAlign = (fraLeft, fraRight, fraWidth);
  TfrxToolAlign = (ftaTop, ftaBottom);
  TfrxTreeSortType = (dtsUnsorted, dtsAscending, dtsDescending);

  TfrxDataNode = class(TObject)
  private
    FParent: TfrxDataNode;
    FFirstChild: TfrxDataNode;
    FRSibling: TfrxDataNode;
    FLSibling: TfrxDataNode;
    FData: TObject;
    FImageIndex: Integer;
    FSelectedIndex: Integer;
    FOriginalNode: TTreeNode;
    FText: String;
  public
    destructor Destroy; override;
    procedure Clear;
  end;

  TfrxTreeNodeClass = class of TfrxTreeNode;

  TfrxTreeNode = class(TTreeNode)
  private
    FDataNode: TfrxDataNode;
    FNeedFixUp: Boolean;
  public
    constructor CreateWithData(AOwner: TTreeNodes; aDataNode: TfrxDataNode); overload;
    destructor Destroy; override;
    procedure MoveTo(Destination: TTreeNode; Mode: TNodeAttachMode); override;
  end;

  TfrxTreeNodes = class(TTreeNodes)
  protected
     procedure DefineProperties(Filer: TFiler); override;
  public
     procedure Assign(Source: TPersistent); override;
  end;

  TfrxTVFilterCompareEvent = function(Sender: TObject; Node: TTreeNode; const aFilter: string): Boolean of object;

  TfrxTreeView = class(TTreeView, IfrxDPIAwareControl)
  private
    FIsUpdating: Boolean;
    FOnEditedNew: TTVEditedEvent;
    FRootNode: TfrxDataNode;
    FLastFilter: String;
    FOnFilterCompare: TfrxTVFilterCompareEvent;
    FOnExpandButtonClick: TNotifyEvent;
    FExpandLevel: Integer;
    FDrawExpandButton: Boolean;
    FExpandButtonState: Boolean;
    FExpandButtonActive: Boolean;
    FExpandButtonWidth: Integer;
    FExpandButtonAlign: TfrxToolAlign;
    FExpandButtonRect: TRect;
    FCurrentPPI: Integer;
    procedure SetDrawExpandButton(const Value: Boolean);
    procedure SetExpandButtonState(const Value: Boolean);
    procedure InvalidateExpandButton(HideButton: Boolean = False);
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
{$IFDEF FPC}
    procedure WMMouseWheel(var Message: TLMMouseEvent); message LM_MOUSEWHEEL;
{$ELSE}
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
{$ENDIF}
    procedure WMDpiChanged(var Message: TMessage); message FRX_WM_DPICHANGED_AFTERPARENT;
    procedure SetExpandButtonAlign(const Value: TfrxToolAlign);
    procedure UpdateExpandButton;
    procedure DrawArrow;
  protected
    function CreateNode: TTreeNode; override;
    function CreateNodes: TTreeNodes; override;
    function CanChange(Node: TTreeNode): Boolean; override;
    function CanCollapse(Node: TTreeNode): Boolean; override;
    procedure Change(Node: TTreeNode); override;
    procedure Delete(Node: TTreeNode); override;
    procedure Added(Node: TTreeNode); override;
    procedure DoEdit(Sender: TObject; Node: TTreeNode; var S: string);
    procedure DoPPIChanged(aNewPPI: Integer); virtual;
    procedure DestroyWnd; override;
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean; override;
    function CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean; override;
    function CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage; var PaintImages: Boolean): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetFilter;
    procedure Filter(const aFilter: string);
    procedure UpdateFilter;
    property ExpandLevel: Integer read FExpandLevel write FExpandLevel;
    property DrawExpandButton: Boolean read FDrawExpandButton write SetDrawExpandButton;
    property ExpandButtonState: Boolean read FExpandButtonState write SetExpandButtonState;
    property ExpandButtonAlign: TfrxToolAlign read FExpandButtonAlign write SetExpandButtonAlign;
  published
    property OnEdited: TTVEditedEvent read FOnEditedNew write FOnEditedNew;
    property OnFilterCompare: TfrxTVFilterCompareEvent read FOnFilterCompare write FOnFilterCompare;
    property OnExpandButtonClick: TNotifyEvent read FOnExpandButtonClick write FOnExpandButtonClick;
  end;

  TfrxToolPanel = class;

  TfrxToolButttonStyle = (fbsButton, fbsCheckButton, fbsRadioButton, fbsDropDownButton);
  TfrxToolButttonKind = (fbkButton, fbkSeparator);

  TfrxToolPanelCustomButton = class(TGraphicControl)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TfrxToolPanelSeparator = class(TfrxToolPanelCustomButton)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TfrxToolPanelButton }

  TfrxToolPanelButton = class(TfrxToolPanelCustomButton)
  private
    FIsActive: Boolean;
    FIsDown: Boolean;
    FImageIndex: Integer;
    FButtonStyle: TfrxToolButttonStyle;
    FGroup: Integer;
    function GetParentPanel: TfrxToolPanel;
    procedure SetButtonStyle(const Value: TfrxToolButttonStyle);
    procedure SetIsDown(const Value: Boolean);
  protected
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  protected
    procedure Paint; override;
    function GetArrowWidth: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    //function IsDown: Boolean;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
{$IFDEF FPC}
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: integer; KeepBase: boolean); override;
{$ENDIF}
    property ButtonStyle: TfrxToolButttonStyle read FButtonStyle write SetButtonStyle;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property IsDown: Boolean read FIsDown write SetIsDown;
  end;

  TfrxToolPanel = class(TfrxDPIAwarePanel)
  private
    FButtons: TList;
    FImageList: TCustomImageList;
    FOnBtnClick: TNotifyEvent;
    procedure SetImageList(const Value: TCustomImageList);
    procedure ResetRadioGroup(GroupIndex: Integer);
  protected
    function CalcButtonsWidth: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddButton(ImageIndex: Integer; HintText: String = ''; Tag: NativeInt = -1; ButtonStyle: TfrxToolButttonStyle = fbsButton; Group: Integer = -1): TfrxToolPanelButton;
    function AddCustomButton(aKind: TfrxToolButttonKind): TfrxToolPanelCustomButton;
    procedure SetBounds(aLeft, aTop, aWidth, aHeight: integer); override;
{$IFDEF FPC}
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: integer; KeepBase: boolean); override;
{$ENDIF}
    function GetArrowWidth: Integer;
    procedure Paint; override;
    procedure RealignButtons;
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property OnBtnClick: TNotifyEvent read FOnBtnClick write FOnBtnClick;
  end;

  TfrxToolWithFilterPanel = class(TfrxDPIAwarePanel)
  private
    FToolPanel: TfrxToolPanel;
    FPanel: TfrxDPIAwarePanel;
    FFilter: TfrxFilterEdit;
    FFileterMinWidth: Integer;
    FFileterMaxWidth: Integer;
    FFilterActiveImageIndex: Integer;
    FFilterUnactiveImageIndex: Integer;
    FFilterAlign: TfrxFilterAlign;
    FToolPanelAlign: TfrxToolAlign;
    procedure SetFilterVisible(const Value: Boolean);
    function GetFilterVisible: Boolean;
    function GetToolVisible: Boolean;
    procedure SetToolVisible(const Value: Boolean);
    function GetImageList: TCustomImageList;
    procedure SetImageList(const Value: TCustomImageList);
    procedure SetFilterActiveImageIndex(const Value: Integer);
    procedure SetFilterUnactiveImageIndex(const Value: Integer);
    procedure SetFileterMaxWidth(const Value: Integer);
    procedure SetFileterMinWidth(const Value: Integer);
    procedure ExpandButtonClick(Sender: TObject); virtual;
    procedure SetFilterAlign(const Value: TfrxFilterAlign);
    procedure SetToolPanelAlign(const Value: TfrxToolAlign); virtual;
    procedure SetFilterColor(const Value: TColor);
    function GetFilterColor: TColor;
    procedure SetOnFilterChanged(const Value: TNotifyEvent);
  protected
    procedure UpdateSize; virtual;
    function CalcButtonsWidth: Integer;
    procedure Resize; override;
{$IFDEF FPC}
    procedure DoOnResize; override;
{$ENDIF}
    procedure SetParent(AParent: TWinControl); override;
    procedure DoPPIChanged(aNewPPI: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property FilterColor: TColor read GetFilterColor write SetFilterColor;
    property FilterEdit: TfrxFilterEdit read FFilter;
    property OnFilterChanged: TNotifyEvent write SetOnFilterChanged;
    property FilterVisible: Boolean read GetFilterVisible write SetFilterVisible;
    property FilterActiveImageIndex: Integer read FFilterActiveImageIndex write SetFilterActiveImageIndex;
    property FilterUnactiveImageIndex: Integer read FFilterUnactiveImageIndex write SetFilterUnactiveImageIndex;
    property FileterMinWidth: Integer read FFileterMinWidth write SetFileterMinWidth;
    property FileterMaxWidth: Integer read FFileterMaxWidth write SetFileterMaxWidth;
    property FilterAlign: TfrxFilterAlign read FFilterAlign write SetFilterAlign;
    property ToolPanel: TfrxToolPanel read FToolPanel;
    property ToolVisible: Boolean read GetToolVisible write SetToolVisible;
    property ToolImageList: TCustomImageList read GetImageList write SetImageList;
    property ToolPanelAlign: TfrxToolAlign read FToolPanelAlign write SetToolPanelAlign;
  end;

  { TfrxTreePanel }

  TfrxTreePanel = class(TfrxToolWithFilterPanel)
  private
    FTreeView: TfrxTreeView;
    procedure ExpandButtonClick(Sender: TObject); override;
    procedure SetToolPanelAlign(const Value: TfrxToolAlign); override;
  protected
    procedure UpdateSize; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure EditChange(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TreeView: TfrxTreeView read FTreeView;
  end;


implementation
uses Forms;
{ TfrxTreeNode }

constructor TfrxTreeNode.CreateWithData(AOwner: TTreeNodes; aDataNode: TfrxDataNode);
begin
  inherited Create(AOwner);
  FDataNode := aDataNode;
end;

destructor TfrxTreeNode.Destroy;
begin
  if assigned(FDataNode) then
    FDataNode.FOriginalNode := nil;
  if Assigned(Owner.Owner) and not TfrxTreeView(Owner.Owner).FIsUpdating then
    FDataNode.Free;
  inherited;
end;

procedure TfrxTreeNode.MoveTo(Destination: TTreeNode; Mode: TNodeAttachMode);
var
  dNode: TfrxDataNode;
begin
  if Assigned(FDataNode) then
  begin
    if Assigned(FDataNode.FLSibling) then
      FDataNode.FLSibling.FRSibling := FDataNode.FRSibling;
    if Assigned(FDataNode.FRSibling) then
      FDataNode.FRSibling.FLSibling := FDataNode.FLSibling;
    if Assigned(FDataNode.FParent) and (FDataNode.FParent.FFirstChild = FDataNode) then
      FDataNode.FParent.FFirstChild := FDataNode.FRSibling;
  end;
  inherited;
  if Assigned(FDataNode) and (Destination is TfrxTreeNode) and Assigned(TfrxTreeNode(Destination).FDataNode) then
  begin
    dNode := TfrxTreeNode(Destination).FDataNode;
    if (Destination <> nil) and not (Mode in [naAddChild, naAddChildFirst]) then
      dNode := dNode.FParent;
    if Mode = naInsert then
    begin
      Destination := Destination.GetPrevSibling;
      if Destination = nil then
        Mode := naAddFirst
      else
        dNode := TfrxTreeNode(Destination).FDataNode;
    end;

    if Mode in [naAddFirst, naAddChildFirst] then
    begin
      while (dNode.FLSibling <> nil) do
        dNode := dNode.FLSibling;
      dNode.FLSibling := FDataNode;
      FDataNode.FRSibling := dNode;
      FDataNode.FParent := dNode.FParent;
      If Assigned(dNode.FParent) then
        dNode.FParent.FFirstChild := FDataNode;
    end
    else if Mode in [naAdd, naAddChild, naInsert] then
    begin
      if Mode = naInsert then
        FDataNode.FRSibling := dNode.FRSibling
      else
      begin
        while (dNode.FRSibling <> nil) do
          dNode := dNode.FRSibling;
        FDataNode.FRSibling := nil;
      end;
      dNode.FRSibling := FDataNode;
      FDataNode.FLSibling := dNode;
      FDataNode.FParent := dNode.FParent;
    end;
  end;
end;

{ TfrxTreeView }

procedure TfrxTreeView.Added(Node: TTreeNode);
var
  dNode, dNodeSibl, ParentNode: TfrxDataNode;
  lNode: TTreeNode;
begin
  inherited;
  if not FIsUpdating and (Node is TfrxTreeNode) and (TfrxTreeNode(Node).FDataNode = nil) then
  begin
    TfrxTreeNode(Node).FDataNode := TfrxDataNode.Create;

    dNode := TfrxTreeNode(Node).FDataNode;
    dNode.FOriginalNode := Node;
    if Assigned(Node.Parent)then
      ParentNode := TfrxTreeNode(Node.Parent).FDataNode
    else
      ParentNode := FRootNode;

    dNode.FParent := ParentNode;
    dNode.FText := Node.Text;
    dNode.FData := Node.Data;
    { fixup after restoring from stream }
    if TfrxTreeNode(Node).FNeedFixUp then
    begin
      TfrxTreeNode(Node).FNeedFixUp := False;
      lNode := TfrxTreeNode(Node.getFirstChild);
      if Assigned(lNode) and Assigned(TfrxTreeNode(lNode).FDataNode) then
      begin
        dNode.FFirstChild := TfrxTreeNode(lNode).FDataNode;
        TfrxTreeNode(lNode).FDataNode.FParent := dNode;
      end;
    end;

    lNode := TfrxTreeNode(Node.getPrevSibling);
    if lNode = nil then
    begin
      dNode.FLSibling := nil;
      if Assigned(ParentNode) then
        ParentNode.FFirstChild := dNode
      else if Assigned(Node.Parent) then
        TfrxTreeNode(Node.Parent).FNeedFixUp := True;
    end
    else
    begin
      dNodeSibl := TfrxTreeNode(lNode).FDataNode;
      dNode.FLSibling := dNodeSibl;
      dNodeSibl.FRSibling := dNode;
    end;
    Node :=  Node.getNextSibling;
    if Assigned(Node) then
    begin
      dNodeSibl := TfrxTreeNode(Node).FDataNode;
      dNodeSibl.FLSibling := dNode;
      dNode.FRSibling := dNodeSibl;
    end;
  end;
end;

function TfrxTreeView.CanChange(Node: TTreeNode): Boolean;
begin
  if FIsUpdating then
    Result := True
  else
    Result := inherited CanChange(Node);
end;

function TfrxTreeView.CanCollapse(Node: TTreeNode): Boolean;
begin
  Result := inherited CanCollapse(Node);
  if Result then
    InvalidateExpandButton(True);
end;

procedure TfrxTreeView.Change(Node: TTreeNode);
begin
  if FIsUpdating then
    Select(Selected, KeyDataToShiftState(0) + [ssLeft])
  else
    inherited;
end;

constructor TfrxTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FRootNode := TfrxDataNode.Create;
  FExpandLevel := -1;
  FCurrentPPI := Screen.PixelsPerInch;
  FExpandButtonWidth := MulDiv(16, FCurrentPPI, 96);
end;

function TfrxTreeView.CreateNode: TTreeNode;
var
  LClass: TTreeNodeClass;
begin
  LClass := TfrxTreeNode;
  if Assigned(OnCreateNodeClass) then
    OnCreateNodeClass(Self, LClass);
  Result := LClass.Create(Items);
end;

function TfrxTreeView.CreateNodes: TTreeNodes;
begin
  Result := TfrxTreeNodes.Create(Self);
end;

function TfrxTreeView.CustomDraw(const ARect: TRect;
  Stage: TCustomDrawStage): Boolean;
begin
  Result := inherited CustomDraw(ARect, Stage);
  if (Stage = cdPostPaint) and FDrawExpandButton then
    DrawArrow;
end;

function TfrxTreeView.CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages: Boolean): Boolean;
begin
  Result := inherited CustomDrawItem(Node, State, Stage, PaintImages);
  if (Stage = cdPostPaint) and FDrawExpandButton then
    DrawArrow;
end;

procedure TfrxTreeView.Delete(Node: TTreeNode);
begin
//  if not FIsUpdating and (Node is TfrxTreeNode) and Assigned(TfrxTreeNode(Node).FDataNode) then
//    FreeAndNil(TfrxTreeNode(Node).FDataNode);
  inherited;
end;

destructor TfrxTreeView.Destroy;
begin
  FIsUpdating := True;
  FRootNode.Clear;
  FreeAndNil(FRootNode);
  inherited;
end;

procedure TfrxTreeView.DestroyWnd;
begin
  if Owner is TfrxTreeView then
    TfrxTreeView(Owner).ResetFilter;
  inherited;
  FRootNode.Clear;
end;

procedure TfrxTreeView.DoEdit(Sender: TObject; Node: TTreeNode; var S: string);
begin
  if (Node is TfrxTreeNode) then
    TfrxTreeNode(Node).FDataNode.FText := Node.Text;
  if Assigned(FOnEditedNew) then
    FOnEditedNew(Self, Node, S);
end;

procedure TfrxTreeView.DoPPIChanged(aNewPPI: Integer);
begin
  if aNewPPI = FCurrentPPI then Exit;
  FExpandButtonWidth := MulDiv(16, aNewPPI, 96);
  UpdateExpandButton;
  FCurrentPPI := aNewPPI;
end;

procedure TfrxTreeView.DrawArrow;
var
  BtnCl: TColor;
begin
  Canvas.Brush.Color := clWindow;
  Canvas.Pen.Width := 1;
  if FExpandButtonActive then
    BtnCl := clWindowText
  else
    BtnCl := clActiveBorder;
  frxDrawArrows(Canvas, FExpandButtonRect, BtnCl, FExpandButtonState, FExpandButtonState and (FExpandButtonAlign = ftaTop));
end;

procedure TfrxTreeView.Filter(const aFilter: string);
var
  lFilter: String;
  Method: TNodeAttachMode;
  aList: TList;
  { TODO : Expand up to Lvl }
  { not implimented yet }
  procedure ExpandUpTo(Lvl: Integer);
  var
    aItem: TTreeNode;
  begin
    aItem := Items.GetFirstNode;
    if Assigned(aItem) then
      aItem.Expanded := True;
  end;

  function RestoreParentNode(lnode: TfrxDataNode): TfrxTreeNode;
  begin
    Result := TfrxTreeNode(lnode.FOriginalNode);
    if Assigned(lnode.FOriginalNode) then Exit;
    if (lnode.FParent <> nil) and (lnode.FParent <> FRootNode)  then
      Result := RestoreParentNode(lnode.FParent);
    if (Result = nil) and (lnode.FParent = FRootNode) then
       Method := naAdd
    else
      Method := naAddChild;
    Result := TfrxTreeNode(Items.AddNode(TfrxTreeNode.CreateWithData(Items, lnode), Result, lnode.FText, nil, Method));
    Result.FDataNode := lnode;
    Result.Data := lnode.FData;
    Result.ImageIndex := lnode.FImageIndex;
    Result.SelectedIndex := lnode.FSelectedIndex;
    Result.FDataNode.FOriginalNode := Result;
  end;

  procedure DoCheckNodes(aRootNode: TfrxDataNode);
  var
    nNext: TfrxDataNode;
    lNode: TTreeNode;
    bFound: Boolean;
  begin
    nNext := aRootNode.FFirstChild;
    while Assigned(nNext) do
    begin
      DoCheckNodes(nNext);
      bFound := False;
      if Assigned(FOnFilterCompare) then
        bFound := FOnFilterCompare(Self, nNext.FOriginalNode, aFilter);
      if not bFound then
        bFound := (Pos(lFilter, AnsiUpperCase(nNext.FText)) > 0);
      if bFound or (lFilter = '') then
      begin
        if nNext.FOriginalNode = nil then
          RestoreParentNode(nNext);
      end
      else
      begin
        if (nNext.FOriginalNode <> nil) and not(nNext.FOriginalNode.HasChildren) then
        begin
          lNode := nNext.FOriginalNode;
          TfrxTreeNode(nNext.FOriginalNode).FDataNode := nil;
          nNext.FText := nNext.FOriginalNode.Text;
          nNext.FData := nNext.FOriginalNode.Data;
          nNext.FImageIndex := nNext.FOriginalNode.ImageIndex;
          nNext.FSelectedIndex := nNext.FOriginalNode.SelectedIndex;
          nNext.FOriginalNode := nil;
          Items.Delete(lNode);
        end;
      end;
      nNext := nNext.FRSibling;
    end;
  end;
{$IFDEF FPC}
  procedure GetSelections(aList: TList);
  var
    I: Integer;
  begin
    aList.Clear;
    for I := 0 to Self.SelectionCount - 1 do
      aList.Add(Self.Selections[I]);
  end;
{$ENDIF}
begin
  if FIsUpdating then Exit;
  lFilter := AnsiUpperCase(aFilter);
  Items.BeginUpdate;
  FIsUpdating := True;
  aList := TList.Create;
  try
    DoCheckNodes(FRootNode);
    GetSelections(aList);
  finally
    Items.EndUpdate;
    try
      Selected := nil;
      FIsUpdating := False;
      FLastFilter := aFilter;
      if ExpandLevel < 0 then
        FullExpand
      else
        ExpandUpTo(FExpandLevel);
      Select(aList);
    finally
      aList.Free;
    end;
  end;
end;

procedure TfrxTreeView.InvalidateExpandButton(HideButton: Boolean);
var
  bSaveState: Boolean;
begin
  if not HandleAllocated then Exit;
  bSaveState := FDrawExpandButton;
  try
    if HideButton then FDrawExpandButton := False;
    InvalidateRect(Handle, @FExpandButtonRect, not (csOpaque in ControlStyle));
  finally
    FDrawExpandButton := bSaveState;
  end;
end;

function TfrxTreeView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  Result := inherited IsCustomDrawn(Target, Stage) or FDrawExpandButton;
end;

procedure TfrxTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if FExpandButtonActive then
  begin
    ExpandButtonState := not ExpandButtonState;
    if Assigned(FOnExpandButtonClick) then
      FOnExpandButtonClick(Self);
  end;
end;

procedure TfrxTreeView.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  IsActive: Boolean;
begin
  inherited;
  IsActive := (X >= FExpandButtonRect.Left) and (X <= FExpandButtonRect.Right) and (Y >= FExpandButtonRect.Top) and (Y <= FExpandButtonRect.Bottom);
  if FExpandButtonActive <> IsActive then
    InvalidateExpandButton;
  FExpandButtonActive := IsActive;
end;

procedure TfrxTreeView.ResetFilter;
begin
  if FLastFilter <> '' then Filter('');
  FLastFilter := '';
end;

procedure TfrxTreeView.Resize;
begin
  InvalidateExpandButton(True);
  UpdateExpandButton;
  inherited;
  InvalidateExpandButton;
end;

procedure TfrxTreeView.SetDrawExpandButton(const Value: Boolean);
begin
  FDrawExpandButton := Value;
  InvalidateExpandButton;
end;

procedure TfrxTreeView.SetExpandButtonAlign(const Value: TfrxToolAlign);
begin
  FExpandButtonAlign := Value;
  InvalidateExpandButton;
end;

procedure TfrxTreeView.SetExpandButtonState(const Value: Boolean);
begin
  FExpandButtonState := Value;
  InvalidateExpandButton;
end;

procedure TfrxTreeView.UpdateExpandButton;
var
  w, h: Integer;
begin
  w := ClientWidth;
  h := ClientHeight;
  case FExpandButtonAlign of
    ftaTop: FExpandButtonRect := Rect(w - (FExpandButtonWidth + 4), 2, w - 4, FExpandButtonWidth + 2);
    ftaBottom: FExpandButtonRect := Rect(w - (FExpandButtonWidth + 4), h - 2 - FExpandButtonWidth, w - 4, h - 2);
  end;
end;

procedure TfrxTreeView.UpdateFilter;
begin
  if FLastFilter <> '' then
    Filter(FLastFilter);
end;

procedure TfrxTreeView.WMDpiChanged(var Message: TMessage);
var
  NewPPI: Integer;
begin
  Inherited;
  NewPPI := frxGetDpiForWindow(Handle);
  DoPPIChanged(NewPPI);
end;

procedure TfrxTreeView.WMHScroll(var Message: TWMHScroll);
begin
  InvalidateExpandButton(True);
  inherited;
end;

{$IFDEF FPC}
procedure TfrxTreeView.WMMouseWheel(var Message: TLMMouseEvent);
{$ELSE}
procedure TfrxTreeView.WMMouseWheel(var Message: TWMMouseWheel);
{$ENDIF}
begin
  InvalidateExpandButton(True);
  inherited;
end;

procedure TfrxTreeView.WMVScroll(var Message: TWMVScroll);
begin
  InvalidateExpandButton(True);
  inherited;
end;

{ TfrxDataNode }

procedure TfrxDataNode.Clear;
  procedure FreeNode(aNode: TfrxDataNode);
  var
    nNext: TfrxDataNode;
  begin
    nNext := aNode.FFirstChild;
    while nNext <> nil do
    begin
      aNode := nNext;
      FreeNode(nNext);
      nNext := nNext.FRSibling;
      aNode.Free;
    end;
  end;
begin
  FreeNode(Self);
end;

destructor TfrxDataNode.Destroy;
begin
  if (FFirstChild <> nil) then Clear;
  if Assigned(FOriginalNode) then TfrxTreeNode(FOriginalNode).FDataNode := nil;
  if (FLSibling = nil) then
  begin
    if Assigned(FParent) then
    begin
      FParent.FFirstChild := FRSibling;
      if Assigned(FRSibling) then
        FRSibling.FParent := FParent;
    end;
  end
  else
    FLSibling.FRSibling := FRSibling;
  if Assigned(FRSibling) then
    FRSibling.FLSibling := FLSibling;
  inherited;
end;

{ TfrxToolWithFilterPanel }

function TfrxToolWithFilterPanel.CalcButtonsWidth: Integer;
begin
  Result := FToolPanel.CalcButtonsWidth;
end;

constructor TfrxToolWithFilterPanel.Create(AOwner: TComponent);
begin
  FToolPanel := TfrxToolPanel.Create(Self);
  FPanel := TfrxDPIAwarePanel.Create(FToolPanel);
  FFilter := TfrxFilterEdit.Create(FPanel);
  inherited;
  FPanel.BorderStyle := bsNone;
  FPanel.BevelInner := bvNone;
  FPanel.BevelOuter := bvNone;
  FilterAlign := fraRight;
  FFileterMinWidth := 40;
  FFileterMaxWidth := 200;
  FFilter.EditControl.Font.Size := 8;
  FToolPanel.Height := 24;
  FPanel.BorderWidth := 2;
  FPanel.Align := alRight;
  FFilterActiveImageIndex := -1;
  FFilterUnactiveImageIndex := -1;
end;

destructor TfrxToolWithFilterPanel.Destroy;
begin
  FToolPanel := nil;
  FFilter := nil;
  FPanel := nil;
  inherited;
end;

procedure TfrxToolWithFilterPanel.DoPPIChanged(aNewPPI: Integer);
begin
  inherited;
  FFileterMinWidth := MulDiv(FFileterMinWidth, aNewPPI, CurrentPPI);
  FFileterMaxWidth := MulDiv(FFileterMaxWidth, aNewPPI, CurrentPPI);
end;

procedure TfrxToolWithFilterPanel.ExpandButtonClick(Sender: TObject);
begin
  FToolPanel.Visible := True;
end;

function TfrxToolWithFilterPanel.GetFilterColor: TColor;
begin
  Result := FFilter.FilterColor;
end;

function TfrxToolWithFilterPanel.GetFilterVisible: Boolean;
begin
  Result := FPanel.Visible and FFilter.Visible;
end;

function TfrxToolWithFilterPanel.GetImageList: TCustomImageList;
begin
  Result := nil;
  if Assigned(FToolPanel) then
    Result := FToolPanel.ImageList;
end;

function TfrxToolWithFilterPanel.GetToolVisible: Boolean;
begin
  Result := False;
  if Assigned(FToolPanel) then
    Result := FToolPanel.Visible;
end;

procedure TfrxToolWithFilterPanel.Resize;
begin
  inherited Resize;
{$IFNDEF FPC}
  UpdateSize;
{$ENDIF}
end;

{$IFDEF FPC}
procedure TfrxToolWithFilterPanel.DoOnResize;
begin
  inherited DoOnResize;
  UpdateSize;
end;
{$ENDIF}

procedure TfrxToolWithFilterPanel.SetFileterMaxWidth(const Value: Integer);
begin
  FFileterMaxWidth := Value;
  UpdateSize;
end;

procedure TfrxToolWithFilterPanel.SetFileterMinWidth(const Value: Integer);
begin
  FFileterMinWidth := Value;
  UpdateSize;
end;

procedure TfrxToolWithFilterPanel.SetFilterActiveImageIndex(const Value: Integer);
begin
  FFilterActiveImageIndex := Value;
  FFilter.BitmapActive.Height := 0;
  FFilter.BitmapActive.Width := 0;
  if Assigned(FToolPanel.ImageList) then
    frxDrawIcon(FToolPanel.ImageList, FFilter.BitmapActive, FFilterActiveImageIndex, FFilter.FilterColor);
end;

procedure TfrxToolWithFilterPanel.SetFilterAlign(const Value: TfrxFilterAlign);
begin
  FFilterAlign := Value;
  case Value of
    fraLeft, fraWidth: FPanel.Align := alLeft;
    fraRight: FPanel.Align := alRight;
  end;
end;

procedure TfrxToolWithFilterPanel.SetFilterColor(const Value: TColor);
begin
  FilterEdit.FilterColor := Value;
  SetFilterActiveImageIndex(FilterActiveImageIndex);
  SetFilterUnactiveImageIndex(FilterUnactiveImageIndex);
end;

procedure TfrxToolWithFilterPanel.SetFilterUnactiveImageIndex(const Value: Integer);
begin
  FFilterUnactiveImageIndex := Value;
  FFilter.BitmapUnactive.Height := 0;
  FFilter.BitmapUnactive.Width := 0;

  if Assigned(FToolPanel.ImageList) then
    frxDrawIcon(FToolPanel.ImageList, FFilter.BitmapUnactive, FFilterUnactiveImageIndex, FFilter.FilterColor);
end;

procedure TfrxToolWithFilterPanel.SetFilterVisible(const Value: Boolean);
begin
  FPanel.Visible := Value;
  FFilter.Visible := Value;
end;

procedure TfrxToolWithFilterPanel.SetImageList(const Value: TCustomImageList);
begin
  FToolPanel.ImageList := Value;
  SetFilterActiveImageIndex(FFilterActiveImageIndex);
  SetFilterUnactiveImageIndex(FFilterUnactiveImageIndex);
end;

procedure TfrxToolWithFilterPanel.SetOnFilterChanged(const Value: TNotifyEvent);
begin
  FFilter.OnFilterChanged := Value;
end;

procedure TfrxToolWithFilterPanel.SetParent(AParent: TWinControl);
begin
  if AParent = nil then
  begin
    if Assigned(FToolPanel) then
      FToolPanel.Parent := nil;
    if Assigned(FFilter) then
      FFilter.Parent := nil;
  end;
  inherited;
  if AParent <> nil then
  begin
    FToolPanel.Parent := Self;
    SetToolPanelAlign(FToolPanelAlign);
    FPanel.Parent := FToolPanel;
    FFilter.Parent := FPanel;
  end;

end;

procedure TfrxToolWithFilterPanel.SetToolPanelAlign(const Value: TfrxToolAlign);
begin
  FToolPanelAlign := Value;
  case Value of
    ftaTop: FToolPanel.Align := alTop;
    ftaBottom: FToolPanel.Align := alBottom;
  end;
end;

procedure TfrxToolWithFilterPanel.SetToolVisible(const Value: Boolean);
begin
  FToolPanel.Visible := Value;
end;

procedure TfrxToolWithFilterPanel.UpdateSize;
var
  lWidth: Integer;
begin
  if not Assigned(FToolPanel) and not ToolVisible then Exit;
  FPanel.Parent := nil;
  FToolPanel.Width := Width;
  lWidth := Width - CalcButtonsWidth - FToolPanel.Height div 3;
  if FFilterAlign = fraWidth  then
    FPanel.Width := Width - FToolPanel.Height div 3
  else if lWidth > FFileterMaxWidth then
    FPanel.Width := FFileterMaxWidth
  else if lWidth < FFileterMinWidth then
    FPanel.Visible := False
  else
    FPanel.Width := lWidth;
  if lWidth > FFileterMinWidth then
    FPanel.Visible := True;
  FFilter.Align := alRight;
  FFilter.SetBounds(2, 0, FPanel.Width - 4, FPanel.Height);
  FPanel.Parent := FToolPanel;
end;

{ TfrxToolPanelButton }

procedure TfrxToolPanelButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FIsActive := True;
  Invalidate;
end;

procedure TfrxToolPanelButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FIsActive := False;
  Invalidate;
end;

constructor TfrxToolPanelButton.Create(AOwner: TComponent);
begin
  inherited;
  FGroup := -1;
  FButtonStyle := fbsButton;
  FImageIndex := -1;
end;

function TfrxToolPanelButton.GetArrowWidth: Integer;
var
  pPanel: TfrxToolPanel;
begin
  Result := 0;
  pPanel := GetParentPanel;
  if Assigned(pPanel) then
    Result := pPanel.GetArrowWidth;
end;

function TfrxToolPanelButton.GetParentPanel: TfrxToolPanel;
begin
  Result := nil;
  if Parent is TfrxToolPanel then
    Result := TfrxToolPanel(Parent);
end;

{function TfrxToolPanelButton.IsDown: Boolean;
begin
  Result := FIsDown;
end;}

procedure TfrxToolPanelButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Panel: TfrxToolPanel;
begin
  inherited;
  Panel := GetParentPanel;
  if (FButtonStyle = fbsRadioButton) and Assigned(Panel) then
    Panel.ResetRadioGroup(FGroup);
  if (FButtonStyle = fbsCheckButton) then
    FIsDown := not FIsDown
  else
    FIsDown := True;
  Invalidate;
end;

procedure TfrxToolPanelButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Panel: TfrxToolPanel;
begin
  inherited;
  Panel := GetParentPanel;
  if (FButtonStyle <> fbsCheckButton) and (FButtonStyle <> fbsRadioButton) then
    FIsDown := False;
  if Assigned(Panel) and Assigned(Panel.FOnBtnClick) then
    Panel.FOnBtnClick(Self);
  Invalidate;
end;

procedure TfrxToolPanelButton.Paint;
var
  R: TRect;
  pPanel: TfrxToolPanel;
begin
  inherited;
  pPanel := GetParentPanel;
  R := GetClientRect;
  if Assigned(pPanel) then
  begin
    Canvas.Brush.Color := pPanel.Color;
    if pPanel.ParentBackground then
      Canvas.Brush.Color := clNone
    else
      Canvas.FillRect(R);
  end
  else
  begin
    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(R);
  end;
  InflateRect(R, -2, -2);
  if FIsDown then
  begin
    Canvas.Brush.Color := frxBlend(clWindow, clHighlight, 355);
    Canvas.FillRect(R);
  end
  else if FIsActive then
  begin
    Canvas.Brush.Color :=  frxBlend(clWindow, clHighlight, 555);
    Canvas.FillRect(R);
  end;

  if FIsActive then
  begin
    Canvas.Brush.Color :=  clHighlight;
    Canvas.FrameRect(R);
  end
  else
  begin

  end;
  if (FImageIndex > -1) and Assigned(pPanel) and Assigned(pPanel.FImageList) then
    pPanel.FImageList.Draw(Canvas, 4, 4, FImageIndex, Enabled);

  if FButtonStyle = fbsDropDownButton then
  begin
    R.Left := R.Right - GetArrowWidth;
    frxDrawArrow(Canvas, R, clBtnText);
  end;
end;

procedure TfrxToolPanelButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  tp: TfrxToolPanel;
begin
  tp := GetParentPanel;
  if Assigned(tp) and Assigned(tp.ImageList) then
  begin
    AWidth := tp.ImageList.Height + 8;
    AHeight := AWidth;
  end;
  if (FButtonStyle = fbsDropDownButton) and (AWidth <= AHeight) then AWidth := AWidth + 16;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

{$IFDEF FPC}
procedure TfrxToolPanelButton.ChangeBounds(ALeft, ATop, AWidth,
  AHeight: integer; KeepBase: boolean);
var
  tp: TfrxToolPanel;
begin
  tp := GetParentPanel;
  if Assigned(tp) and Assigned(tp.ImageList) then
  begin
    AWidth := tp.ImageList.Height + 8;
    AHeight := AWidth;
  end;
  if (FButtonStyle = fbsDropDownButton) and (AWidth <= AHeight) then AWidth := AWidth + 16;
  inherited ChangeBounds(ALeft, ATop, AWidth, AHeight, KeepBase);
end;
{$ENDIF}

procedure TfrxToolPanelButton.SetButtonStyle(const Value: TfrxToolButttonStyle);
begin
  FButtonStyle := Value;
  if FButtonStyle = fbsDropDownButton then Width := Width + 16;
end;

procedure TfrxToolPanelButton.SetIsDown(const Value: Boolean);
begin
  FIsDown := Value;
  Invalidate;
end;

{ TfrxToolPanel }

function TfrxToolPanel.AddButton(ImageIndex: Integer; HintText: String = ''; Tag: NativeInt = -1; ButtonStyle: TfrxToolButttonStyle = fbsButton; Group: Integer = -1): TfrxToolPanelButton;
begin
  Result := AddCustomButton(fbkButton) as TfrxToolPanelButton;
  Result.Tag := Tag;
  Result.FImageIndex := ImageIndex;
  Result.ButtonStyle := ButtonStyle;
  Result.FGroup := Group;
  Result.Hint := HintText;
  if HintText <> '' then
    Result.ShowHint := True;
end;

function TfrxToolPanel.AddCustomButton(
  aKind: TfrxToolButttonKind): TfrxToolPanelCustomButton;
begin
  case akind of
    fbkButton: Result := TfrxToolPanelButton.Create(Self);
    fbkSeparator: Result := TfrxToolPanelSeparator.Create(Self);
    else
      Result := TfrxToolPanelSeparator.Create(Self);
  end;
  Result.Parent := Self;
  FButtons.Add(Result);
end;

procedure TfrxToolPanel.SetBounds(aLeft, aTop, aWidth, aHeight: integer);
begin
  if FImageList <> nil then
    aHeight := FImageList.Height + 8;
  inherited SetBounds(aLeft, aTop, aWidth, aHeight);
end;

{$IFDEF FPC}
procedure TfrxToolPanel.ChangeBounds(ALeft, ATop, AWidth, AHeight: integer;
  KeepBase: boolean);
begin
  if FImageList <> nil then
    aHeight := FImageList.Height + 8;
  inherited ChangeBounds(ALeft, ATop, AWidth, AHeight, KeepBase);
  RealignButtons;
end;
{$ENDIF}

constructor TfrxToolPanel.Create(AOwner: TComponent);
begin
  inherited;
  FButtons := TList.Create;
  BorderStyle := bsNone;
  BevelInner := bvNone;
  BevelOuter := bvNone;
end;

destructor TfrxToolPanel.Destroy;
begin
  FreeAndNil(FButtons);
  inherited;
end;

function TfrxToolPanel.GetArrowWidth: Integer;
begin
  Result := Height div 2;
end;

procedure TfrxToolPanel.Paint;
begin
  inherited;
end;
procedure TfrxToolPanel.RealignButtons;
var
  i: Integer;
  btn: TfrxToolPanelCustomButton;
begin
  if FImageList = nil then Exit;
  if FButtons.Count > 0 then
     TfrxToolPanelCustomButton(FButtons[0]).Left := 0;
  for i := 0 to FButtons.Count - 1 do
  begin
    btn := TfrxToolPanelCustomButton(FButtons[i]);
    if i > 0 then
       btn.Left := TfrxToolPanelCustomButton(FButtons[i - 1]).Left + TfrxToolPanelCustomButton(FButtons[i - 1]).Width;
    btn.Width := FImageList.Height;
    btn.Height := FImageList.Height;
  end;
end;

procedure TfrxToolPanel.ResetRadioGroup(GroupIndex: Integer);
var
  i: Integer;
begin
  if GroupIndex = -1 then Exit;
  { we arent expecting that this component will be used somwhere outside FR }
  { so just cycle all the buttons }
  for i := 0 to FButtons.Count - 1 do
    if (TObject(FButtons[i]) is TfrxToolPanelButton) and (TfrxToolPanelButton(FButtons[i]).FGroup = GroupIndex) then
      if TfrxToolPanelButton(FButtons[i]).FIsDown then
      begin
        TfrxToolPanelButton(FButtons[i]).FIsDown := False;
        TfrxToolPanelButton(FButtons[i]).Invalidate;
      end;
end;

function TfrxToolPanel.CalcButtonsWidth: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FButtons.Count - 1 do
    Inc(Result, TfrxToolPanelCustomButton(FButtons[i]).Width);
end;

procedure TfrxToolPanel.SetImageList(const Value: TCustomImageList);
var
  i: Integer;
  b: TfrxToolPanelCustomButton;
begin
  FImageList := Value;
  Height := FImageList.Height + 8;
  for i := 0 to FButtons.Count - 1 do
  begin
    b := TfrxToolPanelCustomButton(FButtons[i]);
    b.SetBounds(b.Left, b.Top, Height, Height);
  end;
end;

{ TfrxToolPanelCustomButton }

constructor TfrxToolPanelCustomButton.Create(AOwner: TComponent);
begin
  inherited;
{$IFDEF FPC}
  if AOwner is TfrxToolPanel then
     Left := TfrxToolPanel(AOwner).CalcButtonsWidth + 1
  else
{$ENDIF}
    Align := alLeft;
  if AOwner is TControl then
  begin
    Width := TControl(AOwner).Height;
    Height := TControl(AOwner).Height;
  end;
end;

{ TfrxTreeNodes }

procedure TfrxTreeNodes.Assign(Source: TPersistent);
begin
  if Owner is TfrxTreeView then
    TfrxTreeView(Owner).ResetFilter;
  inherited;
end;

procedure TfrxTreeNodes.DefineProperties(Filer: TFiler);
begin
  if Owner is TfrxTreeView then
    TfrxTreeView(Owner).ResetFilter;
  inherited;
end;

{ TfrxToolPanelSeparator }

constructor TfrxToolPanelSeparator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TControl then
    Width := TControl(AOwner).Height div 3;
end;

procedure TfrxToolPanelSeparator.Paint;
var
  x: Integer;
begin
  inherited;
  x := Width div 2;
  Canvas.Pen.Color := clBtnShadow;
  Canvas.MoveTo(x - 1, 2);
  Canvas.LineTo(x - 1, Height - 2);
  Canvas.Pen.Color := clBtnHighlight;
  Canvas.MoveTo(x, 2);
  Canvas.LineTo(x, Height - 2);
end;

{ TfrxTreePanel }

constructor TfrxTreePanel.Create(AOwner: TComponent);
begin
  inherited;
  FFilter.OnFilterChanged := EditChange;
  FTreeView := TfrxTreeView.Create(Self);
  FTreeView.OnExpandButtonClick := ExpandButtonClick;
  FTreeView.BorderWidth := 0;
  FTreeView.BorderStyle := bsNone;
end;

destructor TfrxTreePanel.Destroy;
begin
  FTreeView := nil;
  inherited;
end;

procedure TfrxTreePanel.EditChange(Sender: TObject);
begin
  FTreeView.Filter(FFilter.EditControl.Text);
end;

procedure TfrxTreePanel.ExpandButtonClick(Sender: TObject);
begin
  FToolPanel.Visible := FTreeView.ExpandButtonState;
end;

procedure TfrxTreePanel.SetParent(AParent: TWinControl);
begin
  if AParent = nil then
  begin
    if Assigned(FToolPanel) then
      FToolPanel.Parent := nil;
    if Assigned(FTreeView) then
      FTreeView.Parent := nil;
    if Assigned(FFilter) then
      FFilter.Parent := nil;
  end;
  inherited;
  if AParent <> nil then
  begin
    FToolPanel.Parent := Self;
    SetToolPanelAlign(FToolPanelAlign);
    FTreeView.Parent := Self;
    FTreeView.Align := alClient;
    FPanel.Parent := FToolPanel;
    FFilter.Parent := FPanel;
  end;
end;

procedure TfrxTreePanel.SetToolPanelAlign(const Value: TfrxToolAlign);
begin
  FToolPanelAlign := Value;
  FTreeView.ExpandButtonAlign := Value;
  case Value of
    ftaTop: FToolPanel.Align := alTop;
    ftaBottom: FToolPanel.Align := alBottom;
  end;
end;

procedure TfrxTreePanel.UpdateSize;
begin
  inherited;
  FTreeView.FExpandButtonState := FToolPanel.Visible;
end;

end.
