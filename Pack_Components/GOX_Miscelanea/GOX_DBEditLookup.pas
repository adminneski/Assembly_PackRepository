unit GOX_DBEditLookup;

interface

uses
  Winapi.Windows,Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons,Vcl.ExtCtrls,Vcl.DBCtrls,Vcl.Menus,
  //Unit de Terceiros
  EXGDIPicture,Gobt_ButtonAdvanced, Gobt_Styles, Data.DB, System.StrUtils;

const
  scAltDown = scAlt + vk_Down;
  scF3 = VK_F3;
type

  TLookupDBText = Class(TDBText)
  private
  public
    constructor Create(AOwner: TComponent); override;
  End;
  TLookupButton = Class(TGoButtonAdvanced)
  private
    FLookupKeyName:String;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LookupKeyName: String read FLookupKeyName;
  End;

  { TBoundPanel }
  TBoundPanelClass = class of TBoundPanel;
  TBoundPanel = class(TCustomPanel)
  private
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CreateWnd; override;
  protected
    FIsPanelModified: Boolean;
    procedure AdjustBounds;
  public
    constructor Create(AOwner: TComponent); override;
    property IsPanelModified: Boolean read FIsPanelModified write FIsPanelModified;
  end;
  TBoundPanelEx = class(TBoundPanel)
  published
   //property Layout default tlCenter;
  end;


  TPanelPosition = (lpAbove, lpBelow, lpLeft, lpRight);
  //
  TGOXDBEditLookup = class(TDBEdit)
  Private
    FLookupPanel: TBoundPanel;
    //
    FLookupButton : TLookupButton;
    FLookupDBText : TLookupDBText;
    //
    FPanelPosition: TPanelPosition;
    FPanelSpacing: Integer;
    //Variaveis para Guardar Eventos Externos para Ser executados apos os internos
    FOnStateChange_External: TNotifyEvent;
    FOnSetText_External: TFieldSetTextEvent;
    FOnExist_External: TNotifyEvent;

    FDataSourceInternal: TDataSource;
    procedure CreateWnd; override;
    procedure UpdatePanelLookupPosition;
    procedure SetPanelPosition(const Value: TPanelPosition);
    procedure SetPanelSpacing(const Value: Integer);
    //Eventos tipo TMessage
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMAllChildrenFlipped(var Message: TMessage); message CM_ALLCHILDRENFLIPPED;
    //Eventos Internos
    procedure OnDataSourceInternalStateChange(Sender: TObject);
    procedure OnSetText_Internal(Sender: TField; const Text: string);
    procedure OnExit_Internal(Sender: TObject);
    //Eventos Propertys
    function getColorPanel: TColor;
    procedure setColorPanel(const Value: TColor);
  Public
  protected
    { protected declarations }
    class function WithLabel: Boolean; virtual;
    class function GetPanelClass: TBoundPanelClass; virtual;
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    FClickKey: TShortCut;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalPanel;
    property PanelPosition: TPanelPosition read FPanelPosition write SetPanelPosition default lpAbove;
    property PanelSpacing: Integer read FPanelSpacing write SetPanelSpacing default 3;
  published
    { published declarations }
    property ClickKey: TShortCut read FClickKey write FClickKey default scAltDown;
    property Lookup: TLookupDBText read FLookupDBText write FLookupDBText;
    property LookupButton: TLookupButton read FLookupButton write FLookupButton;
    property LookupColor: TColor read getColorPanel write setColorPanel;

  end;

  TGOXEditLookup = class(TEdit)
  Private
    FLookupPanel: TBoundPanel;
    //
    FLookupKeyName:String;
    FLookupButton : TLookupButton;
    FLookupDBText : TLookupDBText;
    FPanelPosition: TPanelPosition;
    FPanelSpacing: Integer;
    //
    procedure UpdatePanelLookupPosition;
    //
    procedure SetPanelPosition(const Value: TPanelPosition);
    procedure SetPanelSpacing(const Value: Integer);
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMAllChildrenFlipped(var Message: TMessage); message CM_ALLCHILDRENFLIPPED;
    //
    procedure CreateWnd; override;
    function getColorPanel: TColor;
    procedure setColorPanel(const Value: TColor);
  Public
  protected
    { protected declarations }
    class function WithLabel: Boolean; virtual;
    class function GetPanelClass: TBoundPanelClass; virtual;
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
  public
    FClickKey: TShortCut;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalPanel;
    property PanelPosition: TPanelPosition read FPanelPosition write SetPanelPosition default lpAbove;
    property PanelSpacing: Integer read FPanelSpacing write SetPanelSpacing default 3;
  published
    { published declarations }
    property ClickKey: TShortCut read FClickKey write FClickKey default scAltDown;
    property LookupKeyName: String read FLookupKeyName write FLookupKeyName;
    property LookupButton: TLookupButton read FLookupButton write FLookupButton;
    property LookupDBText: TLookupDBText read FLookupDBText write FLookupDBText;
    property LookupColor: TColor read getColorPanel write setColorPanel;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GOXCode - Miscelanea', [TGOXDBEditLookup,TGOXEditLookup]);
end;

function AdjustedAlignment(RightToLeftAlignment: Boolean; Alignment: TAlignment): TAlignment;
begin
  Result := Alignment;
  if RightToLeftAlignment then
    case Result of
      taLeftJustify: Result := taRightJustify;
      taRightJustify: Result := taLeftJustify;
    end;
end;


{ TGOXDBEditLookup }

procedure TGOXDBEditLookup.CMAllChildrenFlipped(var Message: TMessage);
begin
  inherited;
  if PanelPosition = lpLeft then
    PanelPosition := lpRight
  else if PanelPosition = lpRight then
    PanelPosition := lpLeft
  else
    UpdatePanelLookupPosition;
end;

procedure TGOXDBEditLookup.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if FLookupPanel <> nil then
    FLookupPanel.BiDiMode := BiDiMode;
end;

procedure TGOXDBEditLookup.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  if FLookupPanel <> nil then
    FLookupPanel.Enabled := Enabled;
end;

procedure TGOXDBEditLookup.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if FLookupPanel <> nil then
    FLookupPanel.Visible := Visible;
end;

constructor TGOXDBEditLookup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.FClickKey := scF3;
  FPanelPosition := lpAbove;
  FPanelSpacing := 1;
  Width := 85;
  SetupInternalPanel;
end;

procedure TGOXDBEditLookup.CreateWnd;
begin
  inherited CreateWnd;
  if Self.Field <> nil then
  begin
    //Guarda Evento Externo
    FOnSetText_External := Self.Field.OnSetText;
    FOnExist_External   := Self.OnExit;
    //Link Event SetText
    Self.Field.OnSetText := OnSetText_Internal;
    Self.OnExit := OnExit_Internal;
  end;
  //
  FLookupButton.FLookupKeyName := Self.Name;
  //
  if Self.DataSource <> nil then
  begin
    FOnStateChange_External := Self.DataSource.OnStateChange;
    FDataSourceInternal := Self.DataSource;
    FDataSourceInternal.OnStateChange := OnDataSourceInternalStateChange;
    //
    if FDataSourceInternal.DataSet <> nil then
    begin
      if FDataSourceInternal.DataSet.State in [dsInsert,dsEdit] then
       FLookupButton.Enabled := true else FLookupButton.Enabled := false;
    end;
  end;
  //
  //Monta Texto Lookup quando não existe registro
  if Self.Field <> nil then
  begin
    if FLookupDBText.Field.AsString.Length = 0 then
    begin
      FLookupDBText.Visible := false;
      FLookupPanel.Alignment := taLeftJustify;
      FLookupPanel.Font.Color := clMaroon;
      FLookupPanel.Font.Style := [TFontStyle.fsBold];
      FLookupPanel.Caption := DupeString(' ',Round(FLookupButton.Width/4)+3)+' Registro [ '+Self.Text+' ] Não Localizado.';
    end
    else
    begin
      FLookupPanel.Caption := '';
      FLookupDBText.Visible := True;
    end;
  end;
end;

destructor TGOXDBEditLookup.Destroy;
begin
  inherited;
end;

function TGOXDBEditLookup.getColorPanel: TColor;
begin
  Result := FLookupPanel.Color;
end;

class function TGOXDBEditLookup.GetPanelClass: TBoundPanelClass;
begin
  Result := TBoundPanelEx;
end;

procedure TGOXDBEditLookup.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);

  if (FClickKey = ShortCut(Key, Shift)) and (FLookupButton.Enabled = true) then
  begin
    FLookupButton.Click;
    Key := 0;
  end;
end;

procedure TGOXDBEditLookup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FLookupPanel) and (Operation = opRemove) then
    FLookupPanel := nil;
end;

procedure TGOXDBEditLookup.OnDataSourceInternalStateChange(Sender: TObject);
begin
  if FDataSourceInternal.DataSet <> nil then
  begin
    if FDataSourceInternal.DataSet.State in [dsInsert,dsEdit] then
     FLookupButton.Enabled := true else
     FLookupButton.Enabled := false;
  end;
  //
  if Assigned(FOnStateChange_External) then
    FOnStateChange_External(Self);
end;

procedure TGOXDBEditLookup.OnExit_Internal(Sender: TObject);
begin
  //

end;

procedure TGOXDBEditLookup.OnSetText_Internal(Sender: TField; const Text: string);
begin
  Sender.AsString := Text;
  //
  if Sender <> nil then
  begin
    if Text.Length = 0 then Exit;
    try
      FLookupDBText.Visible := false;
      FLookupPanel.Alignment := taLeftJustify;
      FLookupPanel.Font.Color := clWebDarkgreen;
      FLookupPanel.Font.Style := [TFontStyle.fsBold];
      FLookupPanel.Caption :=  DupeString(' ',Round(FLookupButton.Width/4)+3)+'  Aguarde...';
    finally
      //Executa o Evento Linkado externo
      if Assigned(FOnSetText_External) then
        FOnSetText_External(Sender,Text);
      //
      if FLookupDBText.Field.DataSet.RecordCount = 0 then
      begin
        try
          FLookupDBText.Visible := false;
          FLookupPanel.Alignment := taLeftJustify;
          FLookupPanel.Font.Color := clMaroon;
          FLookupPanel.Font.Style := [TFontStyle.fsBold];
          FLookupPanel.Caption := DupeString(' ',Round(FLookupButton.Width/4)+3)+' Registro [ '+Text+' ] Não Localizado.';
          Sender.AsString := '';
          if Self.CanFocus then Self.SetFocus;
          Abort;
        except on E: Exception do
         end;
      end
      else
      begin
        FLookupPanel.Caption := '';
        FLookupDBText.Visible := True;
      end;
    end;
  end;
end;

procedure TGOXDBEditLookup.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if Parent <> nil then
    Parent.DisableAlign;
  try
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
    UpdatePanelLookupPosition;
  finally
    if Parent <> nil then
      Parent.EnableAlign;
  end;

end;

procedure TGOXDBEditLookup.setColorPanel(const Value: TColor);
begin
  FLookupPanel.Color := Value;
end;

procedure TGOXDBEditLookup.SetPanelPosition(const Value: TPanelPosition);
begin
  if FPanelPosition <> Value then
  begin
    FPanelPosition := Value;
    if FLookupPanel <> nil then
      FLookupPanel.AdjustBounds;
  end;
end;

procedure TGOXDBEditLookup.SetPanelSpacing(const Value: Integer);
begin
  if FPanelSpacing <> Value then
  begin
    FPanelSpacing := Value;
    UpdatePanelLookupPosition;
  end;
end;

procedure TGOXDBEditLookup.SetName(const Value: TComponentName);
var
  LClearText: Boolean;
begin
  if (csDesigning in ComponentState) and
     (FLookupButton <> nil) then
  begin
    FLookupButton.FLookupKeyName := Value;
  end;
  //
  if (csDesigning in ComponentState) and
     (FLookupPanel <> nil) and SameText(FLookupPanel.Caption, Name) then
  begin
    FLookupPanel.Caption := Value;
    FLookupPanel.IsPanelModified := False;
  end;
  LClearText := (csDesigning in ComponentState) and (Text = '');
  inherited SetName(Value);
  if LClearText then
    Text := '';
end;

procedure TGOXDBEditLookup.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FLookupPanel = nil then Exit;
  FLookupPanel.Parent := AParent;
  if not (csDestroying in ComponentState) then
  begin
    FLookupPanel.AdjustBounds;
    FLookupPanel.Visible := Visible;
  end;
end;

procedure TGOXDBEditLookup.SetupInternalPanel;
begin
  FLookupPanel := GetPanelClass.Create(Self);
  FLookupPanel.FreeNotification(Self);
  //
  FLookupButton := TLookupButton.Create(Self);
  FLookupButton.Parent  := FLookupPanel;
  //
  FLookupDBText := TLookupDBText.Create(Self);
  FLookupDBText.Parent  := FLookupPanel;
end;

procedure TGOXDBEditLookup.UpdatePanelLookupPosition;
var
  P: TPoint;
  S: TSize;
  L: Integer;
  LSpacing: Integer;
begin
  if FLookupPanel = nil then Exit;
  //S := TSize.Create(FEditLabel.Width, FEditLabel.Height);
  S := TSize.Create(Width, Height);
  LSpacing := ScaleValue(FPanelSpacing);
//  case LabelPosition of
//    lpAbove:
//      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
////        taLeftJustify:  P := Point(Left, Top - S.Height - LSpacing);
////        taRightJustify: P := Point(Left + Width - S.Width, Top - S.Height - LSpacing);
////        taCenter:       P := Point(Left + (Width - S.Width) div 2,Top - S.Height - LSpacing);
//      end;
//    lpBelow:
//      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
////        taLeftJustify:  P := Point(Left, Top + Height + LSpacing);
////        taRightJustify: P := Point(Left + Width - S.Width,Top + Height + LSpacing);
////        taCenter:       P := Point(Left + (Width - S.Width) div 2,Top + Height + LSpacing);
//      end;
//    lpLeft:
//      begin
//        L := GetSystemMetrics(SM_CYBORDER);
//        if BorderStyle <> bsSingle then
//          L := ScaleValue(L * 4);
//        S.Height := Height;
//        P := Point(Left - S.Width - LSpacing, Top + ((Height - S.Height) div 2) - L);
//      end;
//    lpRight:
//      begin
//        L := GetSystemMetrics(SM_CYBORDER);
//        if BorderStyle <> bsSingle then
//          L := ScaleValue(L * 4);
//        S.Height := Height;
//        P := Point(Left + Width + LSpacing,Top + ((Height - S.Height) div 2) - L);
//      end;
//  end;

  P := Point(Left+Width, Top);
  FLookupPanel.SetBounds(P.x, P.y, FLookupPanel.Width, S.Height);
  if (Parent <> nil) and Parent.HandleAllocated then
    Parent.Invalidate;
  //
end;

class function TGOXDBEditLookup.WithLabel: Boolean;
begin
  Result := True;
end;

{ TBoundPanel }

procedure TBoundPanel.AdjustBounds;
begin
  inherited;
  if (Owner is TGOXDBEditLookup) and AutoSize then
  TGOXDBEditLookup(Owner).UpdatePanelLookupPosition;
end;

procedure TBoundPanel.CMTextChanged(var Message: TMessage);
begin
  IsPanelModified := True;
end;

constructor TBoundPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'SubPanelLookup';  { do not localize }
  SetSubComponent(True);
  if Assigned(AOwner) then
  begin
    Caption    := ' ';//AOwner.Name;
    Color      := clSilver;
    BevelInner := bvNone;
    BevelKind  := bkNone;
    BevelOuter := bvNone;
    Width      := 400;
    ParentBackground := false;
  end;
  IsPanelModified := False;
end;

procedure TBoundPanel.CreateWnd;
begin
  inherited;
end;


procedure TBoundPanel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TBoundPanel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

{ TLookupButton }

constructor TLookupButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'LookupButtonSub';  { do not localize }
  SetSubComponent(True);
  if Assigned(AOwner) then
  begin
    Caption    := ' ';//AOwner.Name;
    Align   := alLeft;
    Width   := 50;
    Caption := 'F3';
    Font.Name := 'Arial';
    Font.Size := 12;
    Font.Style := [fsBold];
    Skin := tsOffice2013Gray;
  end;
end;

procedure TLookupButton.CreateWnd;
begin
  inherited;
  Hint :=   TComponent(Self.GetParentComponent).GetParentComponent.Name;
end;

{ TLookupDBText }

constructor TLookupDBText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name := 'LookupDBTextSub';  { do not localize }
  SetSubComponent(True);
  if Assigned(AOwner) then
  begin
    Caption    := ' ';//AOwner.Name;
    Align   := alClient;
    AlignWithMargins := true;
    Font.Name := 'Arial';
    Font.Size := 12;
    Font.Style := [fsBold];
  end;
end;

{ TGOXEditLookup }

procedure TGOXEditLookup.CMAllChildrenFlipped(var Message: TMessage);
begin
  inherited;
  if PanelPosition = lpLeft then
    PanelPosition := lpRight
  else if PanelPosition = lpRight then
    PanelPosition := lpLeft
  else
    UpdatePanelLookupPosition;
end;

procedure TGOXEditLookup.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if FLookupPanel <> nil then
    FLookupPanel.BiDiMode := BiDiMode;
end;

procedure TGOXEditLookup.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  if FLookupPanel <> nil then
    FLookupPanel.Enabled := Enabled;
end;

procedure TGOXEditLookup.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if FLookupPanel <> nil then
    FLookupPanel.Visible := Visible;
end;

constructor TGOXEditLookup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.FClickKey := scF3;
  FPanelPosition := lpAbove;
  FPanelSpacing := 1;
  Width := 85;
  SetupInternalPanel;
end;

procedure TGOXEditLookup.CreateWnd;
begin
  inherited CreateWnd;
  FLookupKeyName := Self.Name;
end;

destructor TGOXEditLookup.Destroy;
begin

  inherited;
end;

function TGOXEditLookup.getColorPanel: TColor;
begin
  Result := FLookupPanel.Color;
end;

class function TGOXEditLookup.GetPanelClass: TBoundPanelClass;
begin
  Result := TBoundPanelEx;
end;

procedure TGOXEditLookup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FLookupPanel) and (Operation = opRemove) then
    FLookupPanel := nil;
end;

procedure TGOXEditLookup.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if Parent <> nil then
    Parent.DisableAlign;
  try
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
    UpdatePanelLookupPosition;
  finally
    if Parent <> nil then
      Parent.EnableAlign;
  end;
end;

procedure TGOXEditLookup.setColorPanel(const Value: TColor);
begin
  FLookupPanel.Color := Value;
end;

procedure TGOXEditLookup.SetName(const Value: TComponentName);
var
  LClearText: Boolean;
begin
  if (csDesigning in ComponentState) and
     (FLookupButton <> nil) then
  begin
    FLookupButton.FLookupKeyName := Value;
  end;
  if (csDesigning in ComponentState) and
     (FLookupPanel <> nil) and SameText(FLookupPanel.Caption, Name) then
  begin
    FLookupPanel.Caption := Value;
    FLookupPanel.IsPanelModified := False;
  end;
  LClearText := (csDesigning in ComponentState) and (Text = '');
  inherited SetName(Value);
  if LClearText then
    Text := '';
end;

procedure TGOXEditLookup.SetPanelPosition(const Value: TPanelPosition);
begin
  if FPanelPosition <> Value then
  begin
    FPanelPosition := Value;
    if FLookupPanel <> nil then
      FLookupPanel.AdjustBounds;
  end;
end;

procedure TGOXEditLookup.SetPanelSpacing(const Value: Integer);
begin
  if FPanelSpacing <> Value then
  begin
    FPanelSpacing := Value;
    UpdatePanelLookupPosition;
  end;
end;

procedure TGOXEditLookup.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FLookupPanel = nil then Exit;
  FLookupPanel.Parent := AParent;
  if not (csDestroying in ComponentState) then
  begin
    FLookupPanel.AdjustBounds;
    FLookupPanel.Visible := Visible;
  end;
end;

procedure TGOXEditLookup.SetupInternalPanel;
begin
  FLookupPanel := GetPanelClass.Create(Self);
  FLookupPanel.FreeNotification(Self);
  //
  FLookupButton := TLookupButton.Create(Self);
  FLookupButton.Parent  := FLookupPanel;
  //
  FLookupDBText := TLookupDBText.Create(Self);
  FLookupDBText.Parent  := FLookupPanel;
end;

procedure TGOXEditLookup.UpdatePanelLookupPosition;
var
  P: TPoint;
  S: TSize;
  L: Integer;
  LSpacing: Integer;
begin
  if FLookupPanel = nil then Exit;
  //S := TSize.Create(FEditLabel.Width, FEditLabel.Height);
  S := TSize.Create(Width, Height);
  LSpacing := ScaleValue(FPanelSpacing);
//  case LabelPosition of
//    lpAbove:
//      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
////        taLeftJustify:  P := Point(Left, Top - S.Height - LSpacing);
////        taRightJustify: P := Point(Left + Width - S.Width, Top - S.Height - LSpacing);
////        taCenter:       P := Point(Left + (Width - S.Width) div 2,Top - S.Height - LSpacing);
//      end;
//    lpBelow:
//      case AdjustedAlignment(UseRightToLeftAlignment, Alignment) of
////        taLeftJustify:  P := Point(Left, Top + Height + LSpacing);
////        taRightJustify: P := Point(Left + Width - S.Width,Top + Height + LSpacing);
////        taCenter:       P := Point(Left + (Width - S.Width) div 2,Top + Height + LSpacing);
//      end;
//    lpLeft:
//      begin
//        L := GetSystemMetrics(SM_CYBORDER);
//        if BorderStyle <> bsSingle then
//          L := ScaleValue(L * 4);
//        S.Height := Height;
//        P := Point(Left - S.Width - LSpacing, Top + ((Height - S.Height) div 2) - L);
//      end;
//    lpRight:
//      begin
//        L := GetSystemMetrics(SM_CYBORDER);
//        if BorderStyle <> bsSingle then
//          L := ScaleValue(L * 4);
//        S.Height := Height;
//        P := Point(Left + Width + LSpacing,Top + ((Height - S.Height) div 2) - L);
//      end;
//  end;

  P := Point(Left+Width, Top);
  FLookupPanel.SetBounds(P.x, P.y, FLookupPanel.Width, S.Height);
  if (Parent <> nil) and Parent.HandleAllocated then
    Parent.Invalidate;
  //
end;

class function TGOXEditLookup.WithLabel: Boolean;
begin
  Result := True;
end;

end.

