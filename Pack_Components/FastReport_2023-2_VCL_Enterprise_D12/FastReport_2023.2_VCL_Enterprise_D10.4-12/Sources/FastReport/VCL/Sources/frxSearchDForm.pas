unit frxSearchDForm;

{$I frx.inc}

interface

uses
  {$IFNDEF FPC}
  Windows,
  {$ELSE}
  LCLIntf, LCLType, LMessages, LazHelper,
  {$ENDIF}
  {$IFDEF DELPHI16}
  System.UITypes, System.StrUtils,
  {$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Types, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  frCoreClasses, frUnicodeUtils, frxClass, frxBaseForm, frxRes;

type

  { TfrxSearchDForm }

{$IFNDEF FPC}
  TTView = class(TTreeView)
    procedure WM_MouseWheel(var Msg: TWMMouseWheel); message WM_MouseWheel; //TWMMouseWheel
  end;
{$ENDIF}

  TfrxOnFindUpdate = procedure (Sender: TObject; FindNext: Boolean) of object;
  TfrxReplacedValues = (rvNames, rvStrings, rvContent, rvScript);

  { TfrxSearchDesignForm }

  TfrxSearchDesignForm = class(TfrxBaseForm)
    pnlSearch: TPanel;
    edtFind: TEdit;
    lblFind: TLabel;
    btnFind: TButton;
    gbSearch: TGroupBox;
    chkName: TCheckBox;
    chkStrings: TCheckBox;
    chkContent: TCheckBox;
    chkScript: TCheckBox;
    chkReplace: TCheckBox;
    ReplaceText: TEdit;
    chkCase: TCheckBox;
    GroupBox1: TGroupBox;
    FindAllCB: TCheckBox;
    procedure btnFindClick(Sender: TObject);
    procedure edtFindKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure GReplaceEv(Sender: TObject);
    procedure TreeViewCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure OnTrvFindDChange(Sender: TObject; Node: TTreeNode);
    {$IFNDEF FPC}
    procedure OnTrvFindDChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    {$ENDIF}
    procedure ReplaceTextDblClick(Sender: TObject);
    procedure OnDeleteNode(Sender: TObject; Node: TTreeNode);
  private
    FDesigner: TfrxCustomDesigner;
    FOnFindUpdate: TfrxOnFindUpdate;
    FCodePos: Integer;
    FObjectsPos: Integer;
    FRepCount: array [rvNames .. rvScript] of Integer;
    FReplaceAll: Boolean;
    FBreakSearch: Boolean;
    { Private declarations }
  protected
    FFindTreeView: {$IFNDEF FPC}TTView{$ELSE}TTreeView{$ENDIF};
    procedure VisibleChanging; override;
    procedure DoUpdate(EnableNext: Boolean);
    function FindInCode: Boolean;
    function DoFind(AComponent: TfrxComponent): Boolean;
    procedure StartNewSearch;
    procedure FinishSearch;
    function AskReplace(const ReplaceIn: String = ''): Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateResouces; override;
    procedure LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;

    procedure ClearFindTree;
    procedure NormalizeForm;
    procedure Find;
    procedure FindNext;
    procedure Replace;
    property Designer: TfrxCustomDesigner read FDesigner write FDesigner;
    property OnFindUpdate: TfrxOnFindUpdate read FOnFindUpdate write FOnFindUpdate;
  end;

  TfrxBaseNodeData = class
  public
    Enabled: Boolean;
    constructor Create(vEnabled: Boolean); overload;
  end;

  TfrxBaseComponentNodeData = class(TfrxBaseNodeData)
  public
    Component :TfrxComponent;
    constructor Create(vEnabled: Boolean; vComponent: TfrxComponent); overload;
  end;

  TfrxComponentNodeData = class(TfrxBaseComponentNodeData)
  end;

  TfrxPropertyNodeData = class(TfrxBaseComponentNodeData)
  private
    FPropName: String;
  public
    property PropName: String read FPropName write FPropName;
  end;

  TfrxContentNodeData = class(TfrxBaseComponentNodeData)
  end;

  TfrxScriptNodeData = class(TfrxBaseNodeData)
  public
    Line, StartPos, Length: Integer;
    constructor Create(vEnabled: Boolean; vLine, vStartPos, vLength: Integer); overload;
  end;

const
  EventScrollFind = High(SmallInt);

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses
{$IFNDEF FPC}
  WideStrings,
{$ENDIF}
  TypInfo, IniFiles, 
  frxDesgn, frxUtils, frxPlatformServices, frxDsgnIntf;

{$IFNDEF FPC}
procedure TTView.WM_MouseWheel(var Msg: TWMMouseWheel);
begin
  Msg.XPos := EventScrollFind;
  Msg.YPos := EventScrollFind;
  Inherited;
end;
{$ENDIF}

procedure TfrxSearchDesignForm.Find;
var
  i: Integer;
  FPos: Integer;
  TextToFind, TextToReplace: String;
  ScriptHeaderData: TfrxBaseNodeData;
  FirstScript: TTreeNode;
  ScriptData: TfrxScriptNodeData;
  Script: TStrings;
  buf: String;
  LReport: TfrxReport;
  LObjects: TList;
  Replace: Boolean;
  flags: TReplaceFlags;

  function SeaPos(s1, s2: String; iPos: Integer): Integer;
  begin
    if not chkCase.Checked then
    begin
      s1 := frxUpperCase(s1);
      s2 := frxUpperCase(s2);
    end;
    Result := frxPosEx(s1, s2, iPos);
  end;

begin
  if edtFind.Text = '' then Exit;
  LReport := Designer.Report;
  LObjects := LReport.AllObjects;
  TextToFind := edtFind.Text;
  TextToReplace := ReplaceText.Text;
  if not FindAllCB.Checked then
  begin
    FindNext;
    Exit;
  end;
  flags := [rfReplaceAll];
  if not chkCase.Checked then flags := [rfReplaceAll, rfIgnoreCase];
  Replace := chkReplace.Checked;
  StartNewSearch;
  for i := 0 to LObjects.Count - 1 do
    DoFind(TfrxComponent(LObjects[i]));
  if chkScript.Checked then//Script
  begin
    FirstScript := nil;
    Script :=  Designer.Code;
    for i := 0 to Script.Count - 1 do
    begin
      FPos := 1;
      while FPos > 0 do
      begin
        FPos := SeaPos(TextToFind, Script[i], FPos);
        if (FPos > 0) then
        begin
          if (Replace and AskReplace) then
          begin
            buf := Script[i];
            Script[i] := StringReplace(buf, TextToFind, TextToReplace, flags);
            Inc(FRepCount[rvScript]);
            FPos := -1;
          end
          else
          begin
            if (FirstScript = nil) then
            begin
              ScriptHeaderData := TfrxBaseNodeData.Create(False);
              FirstScript := FFindTreeView.Items.AddObject(nil, frxGet(310), ScriptHeaderData);
            end;
            ScriptData := TfrxScriptNodeData.Create(True, i, FPos, Length(TextToFind));
            FFindTreeView.Items.AddChildObject(FirstScript, Format('[%d; %d]: ... %s ...', [i + 1, FPos, Copy(Script[i], Fpos - 15, Length(TextToFind) + 15)]), ScriptData);
          end;
          Inc(FPos);
        end;
      end;
    end;
  end;
  FinishSearch;
  DoUpdate(FFindTreeView.Items.Count > 0);
end;

function TfrxSearchDesignForm.FindInCode: Boolean;
begin
  Result := TfrxDesignerForm(Designer).CodeWindow.Find(edtFind.Text, chkCase.Checked, FCodePos);
  if Result and chkReplace.Checked then
  begin
    TfrxDesignerForm(Designer).CodeWindow.SelText := ReplaceText.Text;
    Designer.Modified := True;
  end;
  if not Result and (FCodePos > 1) and
    (MessageDlg(Format(frxResources.Get('dsTextNotFound'), [edtFind.Text]) + sLineBreak + frxResources.Get('dsContinueSearch'),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      FCodePos := 1;
      Result := FindInCode;
    end;
end;

procedure TfrxSearchDesignForm.FindNext;
var
  SelNode, NextNode: TTreeNode;
  LReport: TfrxReport;
  LObjects: TList;
  bFound: Boolean;
begin
  if edtFind.Text = '' then Exit;
  LReport := Designer.Report;
  LObjects := LReport.AllObjects;

  if (Designer.Page = nil) and not FindAllCB.Checked then
    DoUpdate(FindInCode)
  else if not FindAllCB.Checked then
  begin
    bFound := False;
    while (FObjectsPos < LObjects.Count) and not bFound and not FBreakSearch do
    begin
      bFound := DoFind(TfrxComponent(LObjects[FObjectsPos]));
      Inc(FObjectsPos);
    end;
    if not bFound and (MessageDlg(Format(frxResources.Get('dsTextNotFound'), [edtFind.Text]) + sLineBreak + frxResources.Get('dsContinueSearch'),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      StartNewSearch;
      FindNext;
    end;

    DoUpdate(True);
  end
  else if FindAllCB.Checked and (FFindTreeView.Items.Count > 0) then
  begin
    SelNode := FFindTreeView.Selected;
    if (SelNode = nil) then Exit;
    NextNode := SelNode.GetNext;
    if (NextNode = nil) then
      NextNode := FFindTreeView.Items.GetFirstNode;
{$IFNDEF FPC}
    FFindTreeView.OnChanging := nil;
{$ENDIF}
    FFindTreeView.Selected := NextNode;
{$IFNDEF FPC}
    FFindTreeView.OnChanging := OnTrvFindDChanging;
{$ENDIF}
    OnTrvFindDChange(Self, NextNode);
    FFindTreeView.SetFocus;
  end;
  FBreakSearch := False;
end;

procedure TfrxSearchDesignForm.FinishSearch;
var
  AllRepCount: Integer;
  i: TfrxReplacedValues;

  function BuildReplaceMess: String;
  begin
    Result := frxGet(316) + ':' + sLineBreak;
    if chkName.Checked then
      Result := Result + Format('%s: %d'#13#10, [frxGet(307), FRepCount[rvNames]]);
    if chkStrings.Checked then
      Result := Result + Format('%s: %d'#13#10, [frxGet(308), FRepCount[rvStrings]]);
    if chkContent.Checked then
      Result := Result + Format('%s: %d'#13#10, [frxGet(309), FRepCount[rvContent]]);
    if chkScript.Checked then
      Result := Result + Format('%s: %d'#13#10, [frxGet(310), FRepCount[rvScript]]);
    Result := Result + sLineBreak + frxGet(3) + ': ' + IntToStr(AllRepCount);
  end;

begin
 if chkReplace.Checked then
  begin
    //Enabled := False;
    Designer.Modified := True;
    for i := Low(FRepCount) to High(FRepCount) do
      AllRepCount := AllRepCount + FRepCount[i];
    if (AllRepCount > 0) then
      frxInfoMsg(BuildReplaceMess)
    else
      frxInfoMsg(Format(frxResources.Get('dsTextNotFound'), [edtFind.Text]));
  end
  else
  begin
    FFindTreeView.FullExpand;
    if (FFindTreeView.Items.Count = 0) then
      frxInfoMsg(Format(frxResources.Get('dsTextNotFound'), [edtFind.Text]));
  end;
  FReplaceAll := False;
  FBreakSearch := False;
end;

procedure TfrxSearchDesignForm.OnDeleteNode(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node) and Assigned(Node.Data) then
    TObject(Node.Data).Free;
end;

procedure TfrxSearchDesignForm.OnTrvFindDChange(Sender: TObject; Node: TTreeNode);
var
  NodeData: TfrxBaseNodeData;
  BComponentNode: TfrxBaseComponentNodeData;
  ScriptNode: TfrxScriptNodeData;
  PropName: String;
begin
  if Node = nil then
    Exit;
  if Node.Data = nil then
    Exit;
  NodeData := Node.Data;
  if (NodeData is TfrxBaseComponentNodeData) then
  begin
    BComponentNode := TfrxComponentNodeData(NodeData);
    if NodeData is TfrxPropertyNodeData then
      PropName := TfrxPropertyNodeData(NodeData).PropName
    else
      PropName := '';
    Designer.SetSelection(BComponentNode.Component, PropName, Point(0, 0), Point(0, 0));
  end
  else if (NodeData is TfrxScriptNodeData) then
  begin
    //trvFind.Selected := nil;
    ScriptNode := TfrxScriptNodeData(NodeData);
    Designer.SetSelection(nil, '', Point(ScriptNode.StartPos, ScriptNode.Line + 1), Point(ScriptNode.StartPos + ScriptNode.Length, ScriptNode.Line + 1));
  end
end;

{$IFNDEF FPC}
procedure TfrxSearchDesignForm.OnTrvFindDChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
var
  RightNode: TTreeNode;
begin
  with FFindTreeView.ScreenToClient(Mouse.CursorPos) do
    RightNode := FFindTreeView.GetNodeAt(X, Y);
  AllowChange := RightNode = Node;
end;
{$ENDIF}

procedure TfrxSearchDesignForm.Replace;
begin
  chkReplace.Checked := True;
  Find;
end;

procedure TfrxSearchDesignForm.UpdateResouces;
begin
  inherited;
  lblFind.Caption := frxGet(301);
  gbSearch.Caption := frxGet(314);
  chkName.Caption := frxGet(307);
  chkStrings.Caption := frxGet(308);
  chkContent.Caption := frxGet(309);
  chkScript.Caption := frxGet(310);
  chkCase.Caption := frxGet(305);
  chkReplace.Caption := frxGet(315);
  FindAllCB.Caption := frxGet(312);
  GroupBox1.Caption := frxGet(302);
  btnFind.Caption := frxGet(300);
end;

procedure TfrxSearchDesignForm.VisibleChanging;
begin
  ClearFindTree;
  inherited;
end;

procedure TfrxSearchDesignForm.edtFindKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then btnFind.OnClick(nil);
end;

procedure TfrxSearchDesignForm.FormResize(Sender: TObject);
begin
  FFindTreeView.Height := Self.Height - (pnlSearch.Top + pnlSearch.Height);
  FFindTreeView.Width := pnlSearch.Width - 6;
end;

procedure TfrxSearchDesignForm.FormCreate(Sender: TObject);
begin
  FFindTreeView := {$IFNDEF FPC}TTView.Create(nil){$ELSE}TTreeView.Create(nil){$ENDIF};
  FFindTreeView.OnDeletion := OnDeleteNode;
  with FFindTreeView do
  begin
    Parent := Self;
    ReadOnly := True;
    Left := 2;
    Top := pnlSearch.Height;
    Width := pnlSearch.Width - 6;
    Height := Self.Height - (pnlSearch.Top + pnlSearch.Height);
    OnCustomDrawItem := TreeViewCustomDrawItem;
    Indent := 19;
    TabOrder := 1;
    Visible := True;
{$IFDEF FPC}
    Options := Options - [tvoThemedDraw];
{$ENDIF}
    OnChange := OnTrvFindDChange;
{$IFNDEF FPC}
    OnChanging := OnTrvFindDChanging;
{$ENDIF}
  end;
  rePadding(Self);
end;

destructor TfrxSearchDesignForm.Destroy;
begin
  ClearFindTree;
  FreeAndNil(FFindTreeView);
  inherited;
end;

function TfrxSearchDesignForm.AskReplace(const ReplaceIn: String): Boolean;
var
  i: Integer;
begin
  if not FReplaceAll then
    i := MessageDlg(Format(frxResources.Get('dsReplace'), [edtFind.Text]) + sLineBreak + ReplaceIn,
      mtConfirmation, [mbYes, mbNo, mbCancel, mbAll], 0)
  else
    i := mrAll;
  Result := i in [mrYes, mrAll];
  FBreakSearch :=  i = mrCancel;
  FReplaceAll := i = mrAll;
end;

procedure TfrxSearchDesignForm.btnFindClick(Sender: TObject);
begin
  Find;
end;

function TfrxSearchDesignForm.DoFind(AComponent: TfrxComponent): Boolean;
var
  TextToFind, TextToReplace: String;
  Replace: Boolean;

  function RecursiveAdd(RItem: TfrxComponent; lvl: Integer = 0; PostFix: String = ''; Content: Boolean = False; const PropName: String = ''): TTreeNode;
  var
    tr, rez: TTreeNode;
    NodeData: TfrxBaseNodeData;

    function FindNodeWithText(const NodeText: string): TTreeNode;
    begin
      Result := FFindTreeView.Items.GetFirstNode;
      while True do
      begin
        if not Assigned(Result) then
          break;
        if not (Result.Text <> NodeText) then
          if (TfrxBaseNodeData(Result.Data) is TfrxComponentNodeData) then
            break;
        Result := Result.GetNext;
      end;
    end;

  begin
    Result := nil;
    if not FindAllCB.Checked then Exit;

    if (RItem.Parent <> nil) then
    begin
      if (RItem.Parent is TfrxReport) then
      begin
        RecursiveAdd(RItem.Parent, lvl + 1);
        tr := FindNodeWithText(RItem.Parent.Name);
      end
      else
        tr := nil;
    end
    else
      tr := nil;

    rez := FindNodeWithText(RItem.Name);
    if (rez = nil) then
    begin
      NodeData := TfrxComponentNodeData.Create(lvl = 0, RItem);
      if (tr = nil) then
        rez := FFindTreeView.Items.AddObject(nil, RItem.Name, NodeData)
      else
        rez := FFindTreeView.Items.AddChildObject(tr, RItem.Name, NodeData);
    end
    else
    begin
      NodeData := rez.Data;
      if ((not NodeData.Enabled) and (lvl = 0)) then
        NodeData.Enabled := True;
    end;
    Result := rez;
    rez.Expanded := True;
    if (PostFix <> '') and (lvl = 0) then
    begin
      if Content then
        NodeData := TfrxContentNodeData.Create(True, RItem)
      else
      begin
        NodeData := TfrxPropertyNodeData.Create(True, RItem);
        TfrxPropertyNodeData(NodeData).PropName := PropName;
      end;
      Result := FFindTreeView.Items.AddChildObject(rez, PostFix, NodeData);
      rez.Expanded := True;
    end;
  end;

  function SeaPos(s1, s2: String): Integer;
  begin
    if not chkCase.Checked then
    begin
      s1 := frxUpperCase(s1);
      s2 := frxUpperCase(s2);
    end;
    Result := frxPos(s1, s2);
  end;

  function FindPropInComp(AObject: TPersistent; const PropName: String = ''; OwnerComponent: TfrxComponent = nil): Boolean;
  var
    i, Index: Integer;
    props: PPropList;
    typeData: PTypeData;
    PropVal: String;
    LObject: TObject;
    s, sItem: String;
    flags: TReplaceFlags;
    IsCompName: Boolean;
    AddedNode: TTreeNode;

    function CheckStrings(var str: String): Boolean;
    begin
      Result := False;
      Index := SeaPos(WideString(TextToFind), str);
      if Index > 0 then
      begin
        Result := True;
        AddedNode := RecursiveAdd(OwnerComponent, 0, '... ' + Copy(str, Index - 5, Index + Length(TextToFind) + 5) + ' ...', True, PropName + String(Props^[i]^.Name));
        if not FindAllCB.Checked then
          Designer.SetSelection(OwnerComponent, PropName + String(Props^[i]^.Name), Point(0, 0), Point(0, 0));
        if (Replace and AskReplace) then
        begin
          str := StringReplace(str, TextToFind, TextToReplace, flags);
          if Assigned(AddedNode) then
            AddedNode.Text := PropName + String(Props^[i]^.Name) + ': ... ' + Copy(str, Index - 5, Index + Length(TextToFind) + 5) + ' ...';
          Inc(FRepCount[rvContent]);
        end;
      end;
    end;

  begin
    Result := False;
    if (AObject = nil) or (AObject.ClassInfo = nil) then
      Exit;
    typeData := GetTypeData(AObject.ClassInfo);
    if (typeData = nil) or (typeData^.PropCount = 0) then
      Exit;
    if AObject is TfrxComponent then
      OwnerComponent := TfrxComponent(AObject);
    sItem := '';
    flags := [rfReplaceAll];
    if not chkCase.Checked then flags := [rfReplaceAll, rfIgnoreCase];

    GetMem(props, typeData^.PropCount * SizeOf(Pointer));
    try
      GetPropInfos(AObject.ClassInfo, props);
      for i := 0 to typeData^.PropCount - 1 do
      begin
        if Props^[i]^.PropType^.Kind = tkClass then
        begin
          LObject := GetObjectProp(AObject, Props^[i]);
          if (LObject is TWideStrings) and chkContent.Checked then
          begin
            s := TWideStrings(LObject).Text;
            Result := CheckStrings(s);
            if Replace then
              TWideStrings(LObject).Text := s;
          end
          else if (LObject is TStrings) and chkContent.Checked then
          begin
            s := TStrings(LObject).Text;
            Result := CheckStrings(s);
            if Replace then
              TStrings(LObject).Text := s;
          end
          else if (LObject is TPersistent) and not (LObject is TComponent)  then
            Result := FindPropInComp(TPersistent(LObject), PropName + String(Props^[i]^.Name) + '.', OwnerComponent) or Result;
        end
        else if (Props^[i]^.PropType^.Kind in [tkString, tkLString, tkWString{$IFDEF DEL12ORFPC}, tkUString{$ENDIF}
          {$IFDEF FPC}, tkAString{$ENDIF}]) then
        begin
          // ignore hidden by frxHideProperties
          if frxIsHiddenProperty(AObject.ClassType, String(Props^[i]^.Name)) then Continue;

          IsCompName := (Props^[i]^.Name = 'Name') and (OwnerComponent = AObject);
          if IsCompName and not chkName.Checked then
            continue;
          PropVal := GetStrProp(AObject, Props^[i]);
          Index := SeaPos(TextToFind, PropVal);
          if Index > 0 then
          begin
            Result := True;
            if IsCompName then
              AddedNode := RecursiveAdd(OwnerComponent)
            else
              AddedNode := RecursiveAdd(TfrxComponent(OwnerComponent), 0, PropName + String(Props^[i]^.Name) + ': ' + PropVal, False, PropName + String(Props^[i]^.Name));
            if not FindAllCB.Checked then
              Designer.SetSelection(OwnerComponent, PropName + String(Props^[i]^.Name), Point(0, 0), Point(0, 0));
            if (Replace and AskReplace) then
            begin
              PropVal := StringReplace(PropVal, TextToFind, TextToReplace, flags);
              if Assigned(AddedNode) then
              begin
                if IsCompName then
                  AddedNode.Text := PropVal
                else
                  AddedNode.Text := PropName + String(Props^[i]^.Name) + ': ' + PropVal;
              end;
              SetStrProp(AObject, Props^[i], PropVal);
              if IsCompName then
                Inc(FRepCount[rvNames])
              else
                Inc(FRepCount[rvStrings]);
            end;
          end;
        end;
        if not FindAllCB.Checked and Result and not Replace or FBreakSearch then Exit;
      end;
    finally
      FreeMem(props);
    end;
  end;
begin
  Result := False;
  TextToFind := edtFind.Text;
  TextToReplace := ReplaceText.Text;
  Replace := chkReplace.Checked;
  if chkStrings.Checked or chkName.Checked or chkContent.Checked  then
    Result := Result or FindPropInComp(AComponent);
end;

procedure TfrxSearchDesignForm.DoUpdate(EnableNext: Boolean);
begin
  if Assigned(FOnFindUpdate) then
    FOnFindUpdate(Self, EnableNext);
end;

procedure TfrxSearchDesignForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in Shift then
  begin
//    if Self.Parent is TfrxDesignerForm then
//    begin
//      TfrxDesignerForm(Self.Parent).CopyCmd.ShortCut := 0;
//      TfrxDesignerForm(Self.Parent).PasteCmd.ShortCut := 0;
//    end;
    //if Key = Ord('F') then
    //begin
    //  if Designer is TfrxDesignerForm then
    //  begin
    //    TfrxDesignerForm(Designer).FindB.Down := False;
    //    TfrxDesignerForm(Designer).SearchFormVisible := False;
    //    Hide;
    //    TfrxDesignerForm(Designer).SetFocus;
    //  end;
    //end;
  end;
end;

procedure TfrxSearchDesignForm.FormShow(Sender: TObject);
begin
  edtFind.SetFocus;
  edtFind.SelectAll;
  NormalizeForm;
end;

procedure TfrxSearchDesignForm.GReplaceEv(Sender: TObject);
begin
  NormalizeForm;
end;

procedure TfrxSearchDesignForm.LoadFormPreferences(PreferencesStorage,
  DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  chkName.Checked := Ini.ReadBool(lName, 'SearchName', True);
  chkStrings.Checked := Ini.ReadBool(lName, 'SearchStrings', True);
  chkContent.Checked := Ini.ReadBool(lName, 'SearchContent', True);
  chkScript.Checked := Ini.ReadBool(lName, 'SearchScript', True);
  chkCase.Checked := Ini.ReadBool(lName, 'SearchCase', False);
  FindAllCB.Checked := Ini.ReadBool(lName, 'SearchAll', False);
end;

procedure TfrxSearchDesignForm.TreeViewCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  NodeData: TfrxBaseNodeData;
begin
  NodeData := Node.Data;
  if (NodeData is TfrxComponentNodeData) then
    Sender.Canvas.Font.Style := [fsBold]
  else if (NodeData is TfrxPropertyNodeData) then
    Sender.Canvas.Font.Style := [fsItalic]
  else if (NodeData is TfrxContentNodeData) then
    Sender.Canvas.Font.Style := [fsItalic];
end;

procedure TfrxSearchDesignForm.ClearFindTree;
var
  i: Integer;
  data: TfrxBaseNodeData;
begin
  if not Assigned(FFindTreeView) then Exit;
  for i := 0 to FFindTreeView.Items.Count - 1 do
  begin
    data := FFindTreeView.Items[i].Data;
    if data <> nil then
      data.Free;
    FFindTreeView.Items[i].Data := nil;
  end;
  FFindTreeView.Items.Clear();
end;

constructor TfrxSearchDesignForm.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TfrxSearchDesignForm.NormalizeForm;
begin
  ReplaceText.Enabled := chkReplace.Checked;
  if ReplaceText.Enabled then
    btnFind.Caption := frxGet(313)
  else
    btnFind.Caption := frxGet(300);
end;

procedure TfrxSearchDesignForm.ReplaceTextDblClick(Sender: TObject);
begin
  chkReplace.Checked := True;
end;

procedure TfrxSearchDesignForm.SaveFormPreferences(PreferencesStorage,
  DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  Ini.WriteBool(lName, 'SearchName', chkName.Checked);
  Ini.WriteBool(lName, 'SearchStrings', chkStrings.Checked);
  Ini.WriteBool(lName, 'SearchContent', chkContent.Checked);
  Ini.WriteBool(lName, 'SearchScript', chkScript.Checked);
  Ini.WriteBool(lName, 'SearchCase', chkCase.Checked);
  Ini.WriteBool(lName, 'SearchAll', FindAllCB.Checked);
end;

procedure TfrxSearchDesignForm.StartNewSearch;
var
  i: TfrxReplacedValues;
begin
  FObjectsPos := 0;
  FReplaceAll := False;
  if FFindTreeView.Items.Count > 0 then
    ClearFindTree();
  if chkReplace.Checked then
    for i := Low(FRepCount) to High(FRepCount) do
      FRepCount[i] := 0;
end;

constructor TfrxBaseNodeData.Create(vEnabled: Boolean);
begin
  Enabled := vEnabled;
end;

constructor TfrxBaseComponentNodeData.Create(vEnabled: Boolean; vComponent: TfrxComponent);
begin
  inherited Create(vEnabled);
  Component := vComponent;
end;

constructor TfrxScriptNodeData.Create(vEnabled: Boolean; vLine, vStartPos, vLength: Integer);
begin
  inherited Create(vEnabled);
  Line := vLine;
  StartPos := vStartPos;
  Length := vLength;
end;

end.
