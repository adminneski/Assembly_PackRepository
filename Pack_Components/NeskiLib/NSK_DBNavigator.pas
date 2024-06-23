unit NSK_DBNavigator;

interface

uses Windows, SysUtils, Messages, Classes, DBConsts, Controls, Forms, Dialogs,
      Menus, StdCtrls, ExtCtrls, Db, PngBitBtn,pngimage,Buttons,Math;

const
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}
  SpaceSize       = 5;   { size of space between special buttons }

type
  TdxNavButton = class;
  TdxNavDataLink = class;

  TNavGlyph = (ngEnabled, ngDisabled);
  TNavigateBtns = (nbFirst, nbPrior, nbNext, nbLast,
                   nbInsert, nbEdit, nbDelete, nbCancel, nbPost, nbRefresh, nbDisable, nbEnabled);
  TButtonSet = set of TNavigateBtns;
  TNavButtonStyle = set of (nsAllowTimer, nsFocusRect);

//  TBtns = array[TNavigateBtns] of TdxNavButton;

  ENavClick = procedure (Sender: TObject; Button: TNavigateBtns) of object;

{ TAXDBNavigator }

  TNSKDBNavigator = class (TCustomPanel)
  private
    FDataLink: TdxNavDataLink;
    FVisibleButtons: TButtonSet;
    FHints: TStrings;
    FDefHints: TStrings;
    FRegistroDesativado: Boolean;
    ButtonWidth: Integer;
    MinBtnSize: TPoint;
    FOnNavClick: ENavClick;
    FBeforeAction: ENavClick;
    FocusedButton: TNavigateBtns;
    FConfirmDelete: Boolean;
    Layouts: TButtonLayout;
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
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure SetGlyphs(Index: TNavigateBtns; Glyph: TPngImage);
    function  GetGlyphs(Index: TNavigateBtns): TPngImage;
    procedure SetCaption(Index: TNavigateBtns; Caption: String);
    function  GetCaption(Index: TNavigateBtns): String;
    procedure SetLayout(Value: TButtonLayout);
  protected
    Buttons: array[TNavigateBtns] of TdxNavButton;
    procedure DataChanged;
    procedure EditingChanged;
    procedure ActiveChanged;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
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
    property VisibleButtons: TButtonSet read FVisibleButtons write SetVisible
      default [nbFirst, nbPrior, nbNext, nbLast, nbInsert,
        nbEdit, nbDelete, nbCancel, nbPost, nbRefresh, nbDisable];
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
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property BeforeAction: ENavClick read FBeforeAction write FBeforeAction;

    property GlyphFirst: TPngImage index nbFirst read GetGlyphs write SetGlyphs;
    property GlyphPrior: TPngImage index nbPrior read GetGlyphs write SetGlyphs;
    property GlyphNext: TPngImage index nbNext read GetGlyphs write SetGlyphs;
    property GlyphLast: TPngImage index nbLast read GetGlyphs write SetGlyphs;
    property GlyphInsert: TPngImage index nbInsert read GetGlyphs write SetGlyphs;
    property GlyphDelete: TPngImage index nbDelete read GetGlyphs write SetGlyphs;
    property GlyphEdit: TPngImage index nbEdit read GetGlyphs write SetGlyphs;
    property GlyphPost: TPngImage index nbPost read GetGlyphs write SetGlyphs;
    property GlyphCancel: TPngImage index nbCancel read GetGlyphs write SetGlyphs;
    property GlyphRefresh: TPngImage index nbRefresh read GetGlyphs write SetGlyphs;
    property GlyphEnabled: TPngImage index nbEnabled read GetGlyphs write SetGlyphs;
    property GlyphDisable: TPngImage index nbDisable read GetGlyphs write SetGlyphs;

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

    property Layout: TButtonLayout read Layouts write SetLayout default blGlyphLeft;
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
  TdxNavButton = class(TPngBitBtn)
  private
    FIndex: TNavigateBtns;
    FNavStyle: TNavButtonStyle;
    FRepeatTimer: TTimer;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    destructor Destroy; override;
    property NavStyle: TNavButtonStyle read FNavStyle write FNavStyle;
    property Index : TNavigateBtns read FIndex write FIndex;
  end;

{ TdxNavDataLink }

  TdxNavDataLink = class(TDataLink)
  private
    FNavigator: TNSKDBNavigator;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANav: TNSKDBNavigator);
    destructor Destroy; override;
  end;


implementation

//{$R NSK_DBNavigator}

{ TAXDBNavigator }

var
  BtnTypeName: array[TNavigateBtns] of PChar = ('FIRST', 'PRIOR', 'NEXT',
    'LAST', 'INSERT', 'EDIT', 'DELETE', 'CANCEL', 'POST', 'REFRESH','DISABLE','ENABLED');
{  BtnHintId: array[TNavigateBtns] of Pointer = (@SFirstRecord, @SPriorRecord,
    @SNextRecord, @SLastRecord, @SInsertRecord, @SDeleteRecord, @SEditRecord,
    @SPostEdit, @SCancelEdit, @SRefreshRecord);
}
constructor TNSKDBNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];

  FDataLink := TdxNavDataLink.Create(Self);
  FVisibleButtons := [nbFirst, nbPrior, nbNext, nbLast, nbInsert,
                      nbEdit, nbDelete, nbCancel, nbPost, nbRefresh, nbDisable,nbEnabled ];

  FHints := TStringList.Create;
  TStringList(FHints).OnChange := HintsChanged;
  //
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Width := 620;
  Height := 35;
  ButtonWidth := 0;
  FocusedButton := nbFirst;
  FConfirmDelete := False;
  FullRepaint := false;
  //
  InitButtons;
  //InitHints;



end;

destructor TNSKDBNavigator.Destroy;
begin
  FDefHints.Free;
  FDataLink.Free;
  FHints.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TNSKDBNavigator.InitButtons;
var
  I: TNavigateBtns;
  Btn: TdxNavButton;
  X: Integer;
  ResName: string;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TdxNavButton.Create (Self);
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
    Btn.Name :=  'BtnNav'+BtnTypeName[I];

    case I of
    nbFirst : Btn.Caption := 'Primeiro';
    nbPrior : Btn.Caption := 'Anterior';
    nbNext : Btn.Caption := 'Proximo';
    nbLast : Btn.Caption := 'Ultimo';
    nbInsert : Btn.Caption := 'Incluir';
    nbEdit : Btn.Caption := 'Alterar';
    nbDelete : Btn.Caption := 'Excluir';
    nbCancel : Btn.Caption := 'Cancelar';
    nbPost : Btn.Caption := 'Salvar';
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
    Btn.Font.Size := 10;
    Btn.Parent := Self;

//    Btn.ShowFocusRect := False;
    Btn.Spacing := 10;


    Buttons[I] := Btn;


    X := X + MinBtnSize.X;
  end;
  Buttons[nbPrior].NavStyle := Buttons[nbPrior].NavStyle + [nsAllowTimer];
  Buttons[nbNext].NavStyle  := Buttons[nbNext].NavStyle + [nsAllowTimer];

end;

procedure TNSKDBNavigator.InitHints;
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

procedure TNSKDBNavigator.HintsChanged(Sender: TObject);
begin
//  InitHints;
end;

procedure TNSKDBNavigator.SetHints(Value: TStrings);
begin
  if Value.Text = FDefHints.Text then
    FHints.Clear else
    FHints.Assign(Value);
end;

function TNSKDBNavigator.GetHints: TStrings;
begin
  if (csDesigning in ComponentState) and not (csWriting in ComponentState) and
     not (csReading in ComponentState) and (FHints.Count = 0) then
    Result := FDefHints else
    Result := FHints;
end;

procedure TNSKDBNavigator.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TNSKDBNavigator.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TNSKDBNavigator.SetVisible(Value: TButtonSet);
var
  I: TNavigateBtns;
  W, H: Integer;
begin
  W := Width;
  H := Height;
  FVisibleButtons := Value;
  for I := Low(Buttons) to High(Buttons) do
    Buttons[I].Visible := I in FVisibleButtons;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  Invalidate;
end;

procedure TNSKDBNavigator.CalcMinSize(var W, H: Integer);
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

  W := Max(W, Count * MinBtnSize.X);
  H := Max(H, MinBtnSize.Y);

  if Align = alNone then W := (W div Count) * Count;
end;

procedure TNSKDBNavigator.SetSize(var W: Integer; var H: Integer);
var
  Count: Integer;
  I: TNavigateBtns;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
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

procedure TNSKDBNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  if not HandleAllocated then SetSize(W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TNSKDBNavigator.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := Width;
  H := Height;
  SetSize(W, H);
end;

procedure TNSKDBNavigator.WMWindowPosChanging(var Message: TWMWindowPosChanging);
begin
  inherited;
  if (SWP_NOSIZE and Message.WindowPos.Flags) = 0 then
    CalcMinSize(Message.WindowPos.cx, Message.WindowPos.cy);
end;

procedure TNSKDBNavigator.ClickHandler(Sender: TObject);
begin
  BtnClick (TdxNavButton (Sender).Index);
end;

procedure TNSKDBNavigator.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TNavigateBtns;
begin
  OldFocus := FocusedButton;
  FocusedButton := TdxNavButton (Sender).Index;
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

procedure TNSKDBNavigator.Atualizar;
begin
   EditingChanged;
end;

procedure TNSKDBNavigator.BtnClick(Index: TNavigateBtns);
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

procedure TNSKDBNavigator.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TNSKDBNavigator.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TNSKDBNavigator.KeyDown(var Key: Word; Shift: TShiftState);
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

procedure TNSKDBNavigator.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TNSKDBNavigator.DataChanged;
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

procedure TNSKDBNavigator.EditingChanged;
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

procedure TNSKDBNavigator.ActiveChanged;
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

procedure TNSKDBNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

procedure TNSKDBNavigator.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if not (csLoading in ComponentState) then
    ActiveChanged;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TNSKDBNavigator.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TNSKDBNavigator.Loaded;
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

procedure TNSKDBNavigator.SetGlyphs(Index: TNavigateBtns; Glyph: TPngImage);
begin
  Buttons[Index].PngImage.Assign(Glyph);
end;

function TNSKDBNavigator.GetGlyphs(Index: TNavigateBtns): TPngImage;
begin
  Result := Buttons[Index].PngImage;

end;

procedure TNSKDBNavigator.SetCaption(Index: TNavigateBtns; Caption: String);
begin
  Buttons[Index].Caption := Caption;
end;

function TNSKDBNavigator.GetCaption(Index: TNavigateBtns): String;
begin
  Result := Buttons[Index].Caption;
end;

procedure TNSKDBNavigator.SetLayout(Value: TButtonLayout);
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

{TdxNavButton}

destructor TdxNavButton.Destroy;
begin
  if FRepeatTimer <> nil then
    FRepeatTimer.Free;
  inherited Destroy;
end;

procedure TdxNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
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

procedure TdxNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState;X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil then
     FRepeatTimer.Enabled  := False;
end;



procedure TdxNavButton.TimerExpired(Sender: TObject);
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

{ TdxNavDataLink }

constructor TdxNavDataLink.Create(ANav: TNSKDBNavigator);
begin
  inherited Create;
  FNavigator := ANav;
  VisualControl := true;

end;

destructor TdxNavDataLink.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TdxNavDataLink.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;

procedure TdxNavDataLink.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TdxNavDataLink.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

end.
