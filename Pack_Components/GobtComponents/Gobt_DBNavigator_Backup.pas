unit Gobt_DBNavigator;

interface

uses Windows, SysUtils, Messages, Classes, DBConsts, Controls, Forms, Dialogs,
      Menus, StdCtrls, ExtCtrls, Db,Math, Vcl.Buttons, Gobt_ButtonAdvanced,
  EXGDIPicture,EXGDIP, Vcl.Graphics;

const
  InitRepeatPause = 400; { pause before repeat timer (ms) }
  RepeatPause     = 100; { pause before hint window displays (ms)}
  SpaceSize       = 5;   { size of space between special buttons }

type
  TNavButton = class;
  TNavDataLink = class;

  TNavGlyph = (ngEnabled, ngDisabled);
  TNavigateBtns = (nbFirst, nbPrior, nbNext, nbLast,
                   nbInsert, nbEdit, nbDelete, nbCancel, nbPost, nbRefresh, nbDisable, nbEnabled);

  TNavLayout = (lyHorizontal, lyVertical);

  TButtonSet = set of TNavigateBtns;

  TNavButtonStyle = set of (nsAllowTimer, nsFocusRect);

  ENavClick = procedure (Sender: TObject; Button: TNavigateBtns) of object;




  { TNSKDBNavigator }
  TGoDBNavigator = class (TCustomPanel)
  private
    FDataLink: TNavDataLink;
    FVisibleButtons: TButtonSet;
    FHints: TStrings;
    FDefHints: TStrings;
    FRegistroDesativado: Boolean;
    ButtonWidth: Integer;
    ButtonHeight: Integer;
    MinBtnSize: TPoint;
    FOnNavClick: ENavClick;
    FBeforeAction: ENavClick;
    FocusedButton: TNavigateBtns;
    FConfirmDelete: Boolean;
    FTransparent: Boolean;
    FNavLaytout : TNavLayout;
    Layouts: TGobtButtonLayout;
    procedure BtnMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClickHandler(Sender: TObject);
    function  GetDataSource: TDataSource;
    function  GetHints: TStrings;
    procedure HintsChanged(Sender: TObject);
    procedure InitButtons;
    procedure InitHints;
    procedure SetDataSource(Value: TDataSource);
    procedure SetHints(Value: TStrings);
    procedure SetSize(var W: Integer; var H: Integer);
    procedure SetVisible(Value: TButtonSet);
    procedure SetTransparent(Value: Boolean);

    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;

    procedure SetGlyphs(Index: TNavigateBtns; Glyph: TGDIPPicture);
    function  GetGlyphs(Index: TNavigateBtns): TGDIPPicture;
    procedure SetGlyphsHot(Index: TNavigateBtns; Glyph: TGDIPPicture);
    function  GetGlyphsHot(Index: TNavigateBtns): TGDIPPicture;
    procedure SetGlyphsDisabled(Index: TNavigateBtns; Glyph: TGDIPPicture);
    function  GetGlyphsDisabled(Index: TNavigateBtns): TGDIPPicture;

    procedure SetCaption(Index: TNavigateBtns; Caption: String);
    function  GetCaption(Index: TNavigateBtns): String;
    procedure SetLayout(Value: TGobtButtonLayout);
  protected
    Buttons: array[TNavigateBtns] of TNavButton;
    procedure DataChanged;
    procedure EditingChanged;
    procedure ActiveChanged;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure CalcMinSize(var W, H: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure BtnClick(Index: TNavigateBtns); virtual;
    procedure Atualizar; virtual;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property VisibleButtons: TButtonSet read FVisibleButtons write SetVisible default [nbFirst, nbPrior, nbNext, nbLast,nbInsert, nbEdit, nbDelete, nbCancel, nbPost, nbRefresh, nbDisable, nbEnabled];
    property NavLayout: TNavLayout read FNavLaytout write FNavLaytout;
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Ctl3D;
    property Hints: TStrings read GetHints write SetHints;
    property RegistroDesativado: Boolean read FRegistroDesativado write FRegistroDesativado;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property BeforeAction: ENavClick read FBeforeAction write FBeforeAction;

    //Normal
    property GlyphFirst: TGDIPPicture index nbFirst read GetGlyphs write SetGlyphs;
    property GlyphPrior: TGDIPPicture index nbPrior read GetGlyphs write SetGlyphs;
    property GlyphNext: TGDIPPicture index nbNext read GetGlyphs write SetGlyphs;
    property GlyphLast: TGDIPPicture index nbLast read GetGlyphs write SetGlyphs;
    property GlyphInsert: TGDIPPicture index nbInsert read GetGlyphs write SetGlyphs;
    property GlyphDelete: TGDIPPicture index nbDelete read GetGlyphs write SetGlyphs;
    property GlyphEdit: TGDIPPicture index nbEdit read GetGlyphs write SetGlyphs;
    property GlyphPost: TGDIPPicture index nbPost read GetGlyphs write SetGlyphs;
    property GlyphCancel: TGDIPPicture index nbCancel read GetGlyphs write SetGlyphs;
    property GlyphRefresh: TGDIPPicture index nbRefresh read GetGlyphs write SetGlyphs;
    property GlyphEnabled: TGDIPPicture index nbEnabled read GetGlyphs write SetGlyphs;
    property GlyphDisable: TGDIPPicture index nbDisable read GetGlyphs write SetGlyphs;
    //Hot
    property GlyphFirstHot: TGDIPPicture index nbFirst read GetGlyphsHot write SetGlyphsHot;
    property GlyphPriorHot: TGDIPPicture index nbPrior read GetGlyphsHot write SetGlyphsHot;
    property GlyphNextHot: TGDIPPicture index nbNext read GetGlyphsHot write SetGlyphsHot;
    property GlyphLastHot: TGDIPPicture index nbLast read GetGlyphsHot write SetGlyphsHot;
    property GlyphInsertHot: TGDIPPicture index nbInsert read GetGlyphsHot write SetGlyphsHot;
    property GlyphDeleteHot: TGDIPPicture index nbDelete read GetGlyphsHot write SetGlyphsHot;
    property GlyphEditHot: TGDIPPicture index nbEdit read GetGlyphsHot write SetGlyphsHot;
    property GlyphPostHot: TGDIPPicture index nbPost read GetGlyphsHot write SetGlyphsHot;
    property GlyphCancelHot: TGDIPPicture index nbCancel read GetGlyphsHot write SetGlyphsHot;
    property GlyphRefreshHot: TGDIPPicture index nbRefresh read GetGlyphsHot write SetGlyphsHot;
    property GlyphEnabledHot: TGDIPPicture index nbEnabled read GetGlyphsHot write SetGlyphsHot;
    property GlyphDisableHot: TGDIPPicture index nbDisable read GetGlyphsHot write SetGlyphsHot;
   //Disabled
    property GlyphFirstDisabled: TGDIPPicture index nbFirst read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphPriorDisabled: TGDIPPicture index nbPrior read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphNextDisabled: TGDIPPicture index nbNext read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphLastDisabled: TGDIPPicture index nbLast read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphInsertDisabled: TGDIPPicture index nbInsert read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphDeleteDisabled: TGDIPPicture index nbDelete read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphEditDisabled: TGDIPPicture index nbEdit read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphPostDisabled: TGDIPPicture index nbPost read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphCancelDisabled: TGDIPPicture index nbCancel read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphRefreshDisabled: TGDIPPicture index nbRefresh read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphEnabledDisabled: TGDIPPicture index nbEnabled read GetGlyphsDisabled write SetGlyphsDisabled;
    property GlyphDisableDisabled: TGDIPPicture index nbDisable read GetGlyphsDisabled write SetGlyphsDisabled;


    property CaptionFirst: String index nbFirst read GetCaption write SetCaption;
    property CaptionPrior: String index nbPrior read GetCaption write SetCaption;
    property CaptionNext: String index nbNext read GetCaption write SetCaption;
    property CaptionLast: String index nbLast read GetCaption write SetCaption;
    property CaptionInsert: String index nbInsert read GetCaption write SetCaption;
    property CaptionDelete: String index nbDelete read GetCaption write SetCaption;
    property CaptionEdit: String index nbEdit read GetCaption write SetCaption;
    property CaptionPost: String index nbPost read GetCaption write SetCaption;
    property CaptionCancel: String index nbCancel read GetCaption write SetCaption;
    property CaptionRefresh: String index nbRefresh read GetCaption write SetCaption;
    property CaptionEnabled: String index nbEnabled read GetCaption write SetCaption;
    property CaptionDisable: String index nbDisable read GetCaption write SetCaption;

    property Layout: TGobtButtonLayout read Layouts write SetLayout default blGlyphLeft;
    property OnClick: ENavClick read FOnNavClick write FOnNavClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  { TdxNavButton }
  TNavButton = class(TGoButtonAdvanced)
  private
    FIndex: TNavigateBtns;
    FNavStyle: TNavButtonStyle;
    FRepeatTimer: TTimer;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    destructor Destroy; override;
    property NavStyle: TNavButtonStyle read FNavStyle write FNavStyle;
    property Index : TNavigateBtns read FIndex write FIndex;
  end;

{ TdxNavDataLink }

  TNavDataLink = class(TDataLink)
  private
    FNavigator: TGoDBNavigator;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANav: TGoDBNavigator);
    destructor Destroy; override;
  end;


implementation




{ TAXDBNavigator }

var
  BtnTypeName: array[TNavigateBtns] of PChar = ('FIRST', 'PRIOR', 'NEXT',
    'LAST', 'INSERT', 'EDIT', 'DELETE', 'CANCEL', 'POST', 'REFRESH','DISABLE','ENABLED');
{  BtnHintId: array[TNavigateBtns] of Pointer = (@SFirstRecord, @SPriorRecord,
    @SNextRecord, @SLastRecord, @SInsertRecord, @SDeleteRecord, @SEditRecord,
    @SPostEdit, @SCancelEdit, @SRefreshRecord);
}
constructor TGoDBNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];

  FDataLink := TNavDataLink.Create(Self);
  FVisibleButtons := [//nbFirst, nbPrior, nbNext, nbLast,
                      nbInsert,nbEdit, nbDelete, nbCancel, nbPost, nbRefresh
                      //,nbDisable,nbEnabled
                       ];

  FHints := TStringList.Create;
  TStringList(FHints).OnChange := HintsChanged;
  //
  BevelOuter := bvNone;
  BevelInner := bvNone;
  FTransparent := false;
  ParentBackground := Transparent;

  Width := 45;
  Height := 650;
  ButtonWidth := 0;
  ButtonHeight := 0;
  FocusedButton := nbFirst;
  FConfirmDelete := False;
  FullRepaint := false;
  FNavLaytout := lyVertical;
  //
  InitButtons;
  //InitHints;



end;

destructor TGoDBNavigator.Destroy;
begin
  FDefHints.Free;
  FDataLink.Free;
  FHints.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TGoDBNavigator.InitButtons;
var
  I: TNavigateBtns;
  Btn: TNavButton;
  X: Integer;
  ResName: string;
begin
  MinBtnSize := Point(40, 45);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TNavButton.Create(Self);
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;

    if FNavLaytout = lyVertical then
    Btn.SetBounds (0, X, MinBtnSize.X, MinBtnSize.Y)
    else
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);

    Btn.Name :=  'BtnNav'+BtnTypeName[I];

    case I of
    nbFirst   : Btn.Caption := 'Primeiro';
    nbPrior   : Btn.Caption := 'Anterior';
    nbNext    : Btn.Caption := 'Proximo';
    nbLast    : Btn.Caption := 'Ultimo';
    nbInsert  : Btn.Caption := 'Incluir';
    nbEdit    : Btn.Caption := 'Alterar';
    nbDelete  : Btn.Caption := 'Excluir';
    nbCancel  : Btn.Caption := 'Cancelar';
    nbPost    : Btn.Caption := 'Salvar';
    nbRefresh : Btn.Caption := 'Atualizar';
    nbDisable : Btn.Caption := 'Desativar';
    nbEnabled : Btn.Caption := 'Ativar';
    end;

//  FmtStr(ResName, 'dbnav_%s', [BtnTypeName[I]]);
//  Btn.PngImage.LoadFromResourceName(HInstance, ResName);
//  Btn.PngImage.LoadFromResourceID(HInstance, 0);

    Btn.TabStop := false;
    Btn.OnClick := ClickHandler;
    Btn.OnMouseDown := BtnMouseDown;
    Btn.Font.Name := 'Arial';
    Btn.Font.Color := clWhite;
    Btn.Font.Size := 8;
    Btn.Parent := Self;
    Btn.Transparent := Transparent;
//    Btn.ShowFocusRect := False;
    Btn.Spacing := 10;
    Buttons[I] := Btn;
    X := X + MinBtnSize.X;
  end;
  Buttons[nbPrior].NavStyle := Buttons[nbPrior].NavStyle + [nsAllowTimer];
  Buttons[nbNext].NavStyle  := Buttons[nbNext].NavStyle + [nsAllowTimer];

end;

procedure TGoDBNavigator.InitHints;
var
  I: Integer;
  J: TNavigateBtns;
begin
  if not Assigned(FDefHints) then
  begin
    FDefHints := TStringList.Create;
//    for J := Low(Buttons) to High(Buttons) do
//      FDefHints.Add(LoadResString(BtnHintId[J]));
  end;
  for J := Low(Buttons) to High(Buttons) do
    Buttons[J].Hint := FDefHints[Ord(J)];
  J := Low(Buttons);
  for I := 0 to (FHints.Count - 1) do
  begin
    if FHints.Strings[I] <> '' then Buttons[J].Hint := FHints.Strings[I];
    if J = High(Buttons) then Exit;
    Inc(J);
  end;
end;

procedure TGoDBNavigator.HintsChanged(Sender: TObject);
begin
//  InitHints;
end;

procedure TGoDBNavigator.SetHints(Value: TStrings);
begin
  if Value.Text = FDefHints.Text then
    FHints.Clear else
    FHints.Assign(Value);
end;

function TGoDBNavigator.GetHints: TStrings;
begin
  if (csDesigning in ComponentState) and not (csWriting in ComponentState) and
     not (csReading in ComponentState) and (FHints.Count = 0) then
    Result := FDefHints else
    Result := FHints;
end;

procedure TGoDBNavigator.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TGoDBNavigator.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TGoDBNavigator.SetVisible(Value: TButtonSet);
var
  I: TNavigateBtns;
  W, H: Integer;
begin
  W := Width;
  H := Height;
  FVisibleButtons := Value;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Buttons[I].Visible := I in FVisibleButtons;
  end;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  Invalidate;
end;

procedure TGoDBNavigator.CalcMinSize(var W, H: Integer);
var
  Count: Integer;
  I: TNavigateBtns;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[nbFirst] = nil then Exit;

  Count := 0;
  for I := Low(Buttons) to High(Buttons) do
    if Buttons[I].Visible then
      Inc(Count);
  if Count = 0 then Inc(Count);

  if FNavLaytout = lyHorizontal then
  begin
     W := Max(W, Count * MinBtnSize.X);
     H := Max(H, MinBtnSize.Y);
     if Align = alNone then W := (W div Count) * Count;
  end;

  if FNavLaytout = lyVertical then
  begin
     W := Max(W, MinBtnSize.X);
     H := Max(H, Count * MinBtnSize.Y);
     if Align = alNone then H := (H div Count) * Count;
  end;

end;

procedure TGoDBNavigator.SetSize(var W: Integer; var H: Integer);
var
  Count: Integer;
  I: TNavigateBtns;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if FNavLaytout = lyHorizontal then
  Begin
      if (csLoading in ComponentState) then Exit;
      if Buttons[nbFirst] = nil then Exit;

      CalcMinSize(W, H);

      Count := 0;
      for I := Low(Buttons) to High(Buttons) do
        if Buttons[I].Visible then
          Inc(Count);
      if Count = 0 then Inc(Count);

      ButtonWidth := W div Count;
      Temp := Count * ButtonWidth;
      if Align = alNone then W := Temp;

      X := 0;
      Remain := W - Temp;
      Temp := Count div 2;
      for I := Low(Buttons) to High(Buttons) do
      begin
        if Buttons[I].Visible then
        begin
          Space := 0;
          if Remain <> 0 then
          begin
            Dec(Temp, Remain);
            if Temp < 0 then
            begin
              Inc(Temp, Count);
              Space := 1;
            end;
          end;
          Buttons[I].SetBounds(X, 0, ButtonWidth + Space, Height);
          Inc(X, ButtonWidth + Space);
        end
        else
          Buttons[I].SetBounds (Width + 1, 0, ButtonWidth, Height);
      end;
  end;
  //
  if FNavLaytout = lyVertical then
  Begin
      if (csLoading in ComponentState) then Exit;
      if Buttons[nbFirst] = nil then Exit;

      CalcMinSize(W, H);

      Count := 0;
      for I := Low(Buttons) to High(Buttons) do
        if Buttons[I].Visible then
          Inc(Count);
      if Count = 0 then Inc(Count);

      ButtonHeight := H div Count;
      Temp := Count * ButtonHeight;
      if Align = alNone then H := Temp;

      X := 0;
      Remain := H - Temp;
      Temp := Count div 2;
      for I := Low(Buttons) to High(Buttons) do
      begin
        if Buttons[I].Visible then
        begin
          Space := 0;
          if Remain <> 0 then
          begin
            Dec(Temp, Remain);
            if Temp < 0 then
            begin
              Inc(Temp, Count);
              Space := 1;
            end;
          end;
          Buttons[I].SetBounds(0, X, Width , ButtonHeight + Space);
          Inc(X, ButtonHeight + Space);
        end
        else
          Buttons[I].SetBounds(0, Height + 1, Width, ButtonHeight);
      end;
  End;
end;

procedure TGoDBNavigator.SetTransparent(Value: Boolean);
var
  I: TNavigateBtns;
begin
  FTransparent := Value;
  ParentBackground := FTransparent;
  for I := Low(Buttons) to High(Buttons) do
    Buttons[I].Transparent := FTransparent;
  Invalidate;
end;

procedure TGoDBNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  if not HandleAllocated then SetSize(W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TGoDBNavigator.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := Width;
  H := Height;
  SetSize(W, H);
end;

procedure TGoDBNavigator.WMWindowPosChanging(var Message: TWMWindowPosChanging);
begin
  inherited;
  if (SWP_NOSIZE and Message.WindowPos.Flags) = 0 then
    CalcMinSize(Message.WindowPos.cx, Message.WindowPos.cy);
end;

procedure TGoDBNavigator.ClickHandler(Sender: TObject);
begin
  BtnClick (TNavButton (Sender).Index);
end;

procedure TGoDBNavigator.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TNavigateBtns;
begin
  OldFocus := FocusedButton;
  FocusedButton := TNavButton (Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end
  else if TabStop and (GetFocus = Handle) and (OldFocus <> FocusedButton) then
  begin
    Buttons[OldFocus].Invalidate;
    Buttons[FocusedButton].Invalidate;
  end;
end;

procedure TGoDBNavigator.Atualizar;
begin
   EditingChanged;
end;

procedure TGoDBNavigator.BtnClick(Index: TNavigateBtns);
begin
  if (DataSource <> nil) and (DataSource.State <> dsInactive) then
  begin
    if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
      FBeforeAction(Self, Index);
    with DataSource.DataSet do
    begin
      case Index of
        nbPrior: Prior;
        nbNext: Next;
        nbFirst: First;
        nbLast: Last;
        nbInsert: Insert;
        nbEdit: Edit;
        nbCancel: Cancel;
        nbPost: Post;
        nbRefresh: Refresh;
        nbDelete:
        begin
          if not FConfirmDelete or
            (MessageDlg(SDeleteRecordQuestion, mtConfirmation,
            mbOKCancel, 0) <> idCancel) then Delete;
        end;
        nbDisable:;
        nbEnabled:;
      end;
    end;
  end;
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then
    FOnNavClick(Self, Index);
end;

procedure TGoDBNavigator.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TGoDBNavigator.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TGoDBNavigator.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TNavigateBtns;
  OldFocus: TNavigateBtns;
begin
  OldFocus := FocusedButton;
  case Key of
    VK_RIGHT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus < High(Buttons) then
            NewFocus := Succ(NewFocus);
        until (NewFocus = High(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    VK_LEFT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus > Low(Buttons) then
            NewFocus := Pred(NewFocus);
        until (NewFocus = Low(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    VK_SPACE:
      begin
        if Buttons[FocusedButton].Enabled then
          Buttons[FocusedButton].Click;
      end;
  end;
end;

procedure TGoDBNavigator.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TGoDBNavigator.DataChanged;
var
  UpEnable, DnEnable: Boolean;
begin
  UpEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.BOF;
  DnEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.EOF;
  Buttons[nbFirst].Enabled := UpEnable;
  Buttons[nbPrior].Enabled := UpEnable;
  Buttons[nbNext].Enabled := DnEnable;
  Buttons[nbLast].Enabled := DnEnable;


{ Marcado Por jeickson Devido Nao Esta Desabilitando o Botao de
 Excluir  quando clica no incluir no navigator

 BACKUP
  Buttons[nbDelete].Enabled := Enabled and FDataLink.Active and
//                               FDataLink.DataSet.CanModify and
                               not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);
}



end;

procedure TGoDBNavigator.EditingChanged;
var
  CanModify: Boolean;
begin
  CanModify := Enabled and FDataLink.Active and FDataLink.DataSet.CanModify;

  Buttons[nbInsert].Enabled := CanModify and
                               not FDataLink.Editing;

  Buttons[nbEdit].Enabled := CanModify and
                             not FDataLink.Editing;

  Buttons[nbPost].Enabled := CanModify and FDataLink.Editing;
  Buttons[nbCancel].Enabled := CanModify and FDataLink.Editing;
  Buttons[nbRefresh].Enabled := CanModify;

  if FDataLink.DataSet <> nil then
  begin
    if (FDataLink.DataSet.State = dsBrowse)AND(FDataLink.DataSet.RecordCount > 0) then
    begin
       if RegistroDesativado  then
       begin
         Buttons[nbEnabled].Enabled := true;
         Buttons[nbDisable].Enabled := false;
       end
       else
       begin
         Buttons[nbEnabled].Enabled := false;
         Buttons[nbDisable].Enabled := true;
       end;
    end
    else
    begin
      Buttons[nbEnabled].Enabled := false;
      Buttons[nbDisable].Enabled := false;
    end;
  end;



//if RegistroDesativado  then
//  begin
//     Buttons[nbEnabled].Enabled := CanModify and
//                                   not FDataLink.Editing and
//                                   not RegistroDesativado and
//                                   not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);
//  end
//  else
//  begin
//
//  Buttons[nbDisable].Enabled := CanModify and
//                                not FDataLink.Editing and
//                                not RegistroDesativado and
//                                not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);
//  end;
//



  // Colocado por Jeickson para Acertar o disabilitar e habilitar o
  //Botao na hora de editar .
  Buttons[nbDelete].Enabled := CanModify and not FDataLink.Editing and
                               not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);


end;

procedure TGoDBNavigator.ActiveChanged;
var
  I: TNavigateBtns;
begin
  if not (Enabled and FDataLink.Active) then
    for I := Low(Buttons) to High(Buttons) do
      Buttons[I].Enabled := False
  else
  begin
    DataChanged;
    EditingChanged;
  end;
end;

procedure TGoDBNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

procedure TGoDBNavigator.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if not (csLoading in ComponentState) then
    ActiveChanged;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TGoDBNavigator.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TGoDBNavigator.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
//  InitHints;
  ActiveChanged;
  //
end;

procedure TGoDBNavigator.SetGlyphs(Index: TNavigateBtns; Glyph: TGDIPPicture);
begin
  Buttons[Index].Picture.Assign(Glyph);
end;

procedure TGoDBNavigator.SetGlyphsDisabled(Index: TNavigateBtns;
  Glyph: TGDIPPicture);
begin
  Buttons[Index].DisabledPicture.Assign(Glyph);
end;

procedure TGoDBNavigator.SetGlyphsHot(Index: TNavigateBtns;
  Glyph: TGDIPPicture);
begin
  Buttons[Index].HotPicture.Assign(Glyph);
end;

function TGoDBNavigator.GetGlyphs(Index: TNavigateBtns): TGDIPPicture;
begin
  Result := Buttons[Index].Picture;
end;

function TGoDBNavigator.GetGlyphsDisabled(Index: TNavigateBtns): TGDIPPicture;
begin
  Result := Buttons[Index].DisabledPicture;
end;

function TGoDBNavigator.GetGlyphsHot(Index: TNavigateBtns): TGDIPPicture;
begin
  Result := Buttons[Index].HotPicture;
end;

procedure TGoDBNavigator.SetCaption(Index: TNavigateBtns; Caption: String);
begin
  Buttons[Index].Caption := Caption;
end;

function TGoDBNavigator.GetCaption(Index: TNavigateBtns): String;
begin
  Result := Buttons[Index].Caption;
end;

procedure TGoDBNavigator.SetLayout(Value: TGobtButtonLayout);
var
  I: TNavigateBtns;
begin
  if Layouts <> Value then
  begin
    Layouts := Value;
    for i := Low(Buttons) to High(Buttons) do
      Buttons[I].Layout := Value;
  end;
end;


{TNavButton}

destructor TNavButton.Destroy;
begin
  if FRepeatTimer <> nil then
    FRepeatTimer.Free;
  inherited Destroy;
end;

procedure TNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  if nsAllowTimer in FNavStyle then
  begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);

    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := InitRepeatPause;
    FRepeatTimer.Enabled  := True;
  end;
end;

procedure TNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState;X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil then
     FRepeatTimer.Enabled  := False;
end;



procedure TNavButton.TimerExpired(Sender: TObject);
begin
// FRepeatTimer.Interval := RepeatPause;

// if (FState = bsDown) and MouseCapture then
// begin
//   try
//     Click;
//   except
//     FRepeatTimer.Enabled := False;
//     raise;
//   end;
// end;

end;

{ TNavDataLink }

constructor TNavDataLink.Create(ANav: TGoDBNavigator);
begin
  inherited Create;
  FNavigator := ANav;
  VisualControl := true;

end;

destructor TNavDataLink.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TNavDataLink.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;

procedure TNavDataLink.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TNavDataLink.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

end.
