unit Ap2EditButtonLookup;

interface

uses
  Winapi.Windows,Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons,Vcl.ExtCtrls,Vcl.DBCtrls,Vcl.Menus,
  //Unit de Terceiros
  EXGDIPicture,Gobt_ButtonAdvanced;
const
  DefEditBtnHeight= 26;
  DefEditBtnWidth = 470;

  scAltDown = scAlt + vk_Down;
  scF3 = VK_F3;

type
  //Primeiro vamos criar uma classe do tipo que será visto como sub-propriedade
  {TAp2DbText}
  TAp2DbText = class(TDBText)
  private
  public
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
  published
  end;

  TAp2Splitter = class (TSplitter)
  private
  public
    procedure Assign(Source: TPersistent); override;
  published
  end;

  {TAp2GoButtonAdvanced}
  TAp2GoButtonAdvanced = class(TGoButtonAdvanced)
  private
    FAutoHeightButton: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property AutoHeightButton: Boolean read FAutoHeightButton write FAutoHeightButton default True;
  end;


  {TPanel}
  TAp2Panel = class(TPanel)
  private
  public
    procedure Assign(Source: TPersistent); override;
  published
  end;

  {TAp2EditButtonLookup}
  TAp2EditButtonLookup = class(TEdit)
  private
    FClickKey        : TShortCut;
    FPanelButton     : TPanel;
    FEditorEnabled   : Boolean;

    FGoButtonAdvanced: TAp2GoButtonAdvanced;
    FSplitter        : TAP2Splitter;
    FPanelContainer  : TAp2Panel;
    FDBText          : TAp2DbText;

//    FOnDbEditChange  : TNotifyEvent;
    FOnBtnClick      : TNotifyEvent;

    function  GetMinHeight: Integer;
    procedure SetEditRect;
    procedure WMSize (var Message: TWMSize    ); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit (var Message: TCMExit    ); message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste   ); message WM_PASTE;
    procedure WMCut  (var Message: TWMCut     ); message WM_CUT;

  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure aClick (Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property    Button: TAP2GoButtonAdvanced read FGoButtonAdvanced;
  published
    { Published declarations }
    //== > sub-propriedades dos componentes declarados como class < ==
    property AP2DBText         : TAp2DbText read FDBText write FDBText;
    property Ap2PanelContainer : TAp2Panel read FPanelContainer write FPanelContainer;
    property Ap2GoButtonAdvanced    : TAp2GoButtonAdvanced read FGoButtonAdvanced write FGoButtonAdvanced;
    property Ap2Splitter       : TAp2Splitter read FSplitter write FSplitter;
    //==> //Fim Sub-Propriedades \\ < ==
    property ClickKey: TShortCut read FClickKey write FClickKey default scF3;
    property AutoSelect;
    property AutoSize;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;

    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
//    property OnChange : TNotifyEvent  read  FOnDbEditChange write FOnDbEditChange;
    property OnClick;
    property OnBtnClick : TNotifyEvent read FOnBtnClick write FOnBtnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
//  RegisterComponents('AP2 Tools', [TAp2EditButton]);
end;


destructor TAp2EditButtonLookup.Destroy;
begin
  // Destruindo componentes criados no create.
  if FDBText <> nil then
    FreeAndNil(FDBText);
  if FSplitter <> nil then
    FreeAndNil(FSplitter);
  if FGoButtonAdvanced <> nil then
    FreeAndNil(FGoButtonAdvanced);
  if FPanelContainer <> nil then
    FreeAndNil(FPanelContainer);

  inherited Destroy;
end;


(*
{Arredondar cantos}
procedure DrawControl(Control: TWinControl) ;
var
   R: TRect;
   Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 10, 10) ;
    Perform(EM_GETRECT, 0, lParam(@r)) ;
    InflateRect(r, - 4, - 4) ;
    Perform(EM_SETRECTNP, 0, lParam(@r)) ;
    SetWindowRgn(Handle, rgn, True) ;
    Invalidate;
  end;
end;
*)

{ TEditBtn }
procedure TAp2EditButtonLookup.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (FClickKey = ShortCut(Key, Shift)) and (Enabled = true) then
  begin
    FGoButtonAdvanced.Click;
  end;
end;

procedure TAp2EditButtonLookup.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  case  Tag of //SÓ TESTES
    0:Params.Style  := Params.Style or      ES_AUTOHSCROLL or WS_CLIPCHILDREN;
    1:Params.Style  := Params.Style or      ES_AUTOVSCROLL or WS_CLIPCHILDREN;
    2:Params.Style  := Params.Style or      ES_WANTRETURN  or WS_CLIPCHILDREN;
    3:Params.Style  := Params.Style and not WS_BORDER;
    4:Params.Style  := Params.Style or      ES_MULTILINE         or WS_CLIPCHILDREN;
    5:Params.Style  := Params.Style or      ES_AWAYMODE_REQUIRED or WS_CLIPCHILDREN;
    6:Params.Style  := Params.Style or      ES_CENTER            or WS_CLIPCHILDREN;
    7:Params.Style  := Params.Style or      ES_CONTINUOUS        or WS_CLIPCHILDREN; {JOGA PRA CIMA O COMPONENTE}
    8:Params.Style  := Params.Style or      ES_DISPLAY_REQUIRED  or WS_CLIPCHILDREN;
    9:Params.Style  := Params.Style or      ES_LEFT              or WS_CLIPCHILDREN;
    10:Params.Style := Params.Style or      ES_LOWERCASE         or WS_CLIPCHILDREN;
    11:Params.Style := Params.Style or      ES_NOHIDESEL         or WS_CLIPCHILDREN;
    12:Params.Style := Params.Style or      ES_NUMBER            or WS_CLIPCHILDREN;
  end;
end;

procedure TAp2EditButtonLookup.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TAp2EditButtonLookup.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right  := ClientWidth - FGoButtonAdvanced.Width - 2;
  Loc.Top    := 0;
  Loc.Left   := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
end;

function TAp2EditButtonLookup.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 2;
end;

procedure TAp2EditButtonLookup.aClick (Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else IF Assigned(FOnBtnClick) then
    FOnBtnClick(Self);

end;


procedure TAp2EditButtonLookup.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TAp2EditButtonLookup.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TAp2EditButtonLookup.CMExit(var Message: TCMExit);
begin
  //FGoButtonAdvanced.Visible:=False;FGoButtonAdvanced.Transparent := True;
  inherited;

end;

procedure TAp2EditButtonLookup.CMEnter(var Message: TCMGotFocus);
begin
//  FGoButtonAdvanced.Visible:=True; FGoButtonAdvanced.Transparent := False;
  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;

{ TAP2DBText } // na Procedure Assign colocamos o seguinte código.
procedure TAP2DBText.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

procedure TAp2DbText.AssignTo(Dest: TPersistent);
begin
  inherited Assign(Dest);
end;

{ TAp2GoButtonAdvanced }
procedure TAp2GoButtonAdvanced.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

{ TAp2Panel }
procedure TAp2Panel.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

procedure TAp2EditButtonLookup.WMSize(var Message: TWMSize);
var
  WidthCurrentSelf,
  WidthCurrentContainer,
  MinWidth, MinHeight: Integer;
begin
  inherited;
  MinHeight := 26;
  MinWidth  := 250;

  if Height < MinHeight then {text edit bug: if size to less than minheight, then edit ctrl does not display the text }
  begin
    Height := MinHeight;
    Exit;
  end;
  if Width < MinWidth then {text edit bug: if size to less than minWidgth, then edit ctrl does not display the text }
  begin
    Width := MinWidth;
    Exit;
  end;

  if FPanelContainer <> nil then
  begin
    if (Width -  FPanelContainer.Width) <= 50 then
    begin
      if Width <= 250 then
      begin
        FPanelContainer.Width := Width - 50;
      end
      else if Width < DefEditBtnWidth  then
      begin
        Width := DefEditBtnWidth;
        FPanelContainer.Width := DefEditBtnWidth - 100;
      end;
    end;
    if (FPanelContainer.Width) <= (Trunc((Width/2)+100) ) then
    begin
      FPanelContainer.Width := Trunc((Width/2)+100);
    end;
  end;

  if FPanelButton <> nil then
  begin
    FPanelButton.Height:=Height-1;
  end;

  if FGoButtonAdvanced <> nil then
  begin
    if (FGoButtonAdvanced.FAutoHeightButton) then
    begin
      FGoButtonAdvanced.Width  := FPanelButton.Width-1;
      FGoButtonAdvanced.Height := FPanelButton.Height-1;
    end;
  end;

end;

constructor TAp2EditButtonLookup.Create(AOwner: TComponent);
begin//Aqui Criamos os componentes associados a este novo componente.
  inherited Create(AOwner);
  Height:= DefEditBtnHeight;
  Width := DefEditBtnWidth;

  FClickKey        := scF3;
  ParentBackground := false;
  Color            := clWindow;
  Font.Name        := 'Arial';
  Font.Size        := 12;

  {TAp2Panel}
  FPanelContainer           := TAp2Panel.Create(Self); //Vai receber o Panel do Button
  FPanelContainer.Name      := 'Ap2PanelContainer'+Self.Name;
  FPanelContainer.Parent    := Self;
  FPanelContainer.Align     := alRight;
  FPanelContainer.Visible   := True;
  FPanelContainer.Caption   := '';
  FPanelContainer.BevelOuter:= bvNone;
  FPanelContainer.Height    := DefEditBtnHeight;
  FPanelContainer.width     := 330;
  {para gravar as propriedades do subcomponente no DFM/XFM}
  FPanelContainer.SetSubComponent( True );
  with FPanelContainer do
    ControlStyle := ControlStyle + [csReplicatable];

  FSplitter := TAp2Splitter.Create(Self);
  FSplitter.Name    := 'Splitter'+Self.Name;
  FSplitter.Parent  := Self;
  FSplitter.AutoSnap:= False;
  FSplitter.Visible := True;
  FSplitter.Align   := alRight;
  FSplitter.Width   := 1;
  FSplitter.Left    := 0;
  {para gravar as propriedades do subcomponente no DFM/XFM}
  FSplitter.SetSubComponent( True );
  with FSplitter do ControlStyle := ControlStyle + [csReplicatable];

  {TAp2DBText}
  FDBText            := TAp2DBText.Create(Self);
  FDBText.Name       := 'Ap2DbText'+Self.Name;
  FDBText.Parent     := FPanelContainer;
  FDBText.Color      := clSilver;
  FDBText.Transparent:= False;
  FDBText.AutoSize   := True;
  FDBText.ParentColor:= False;
  FDBText.Align      := alClient;
  FDBText.Alignment  := taLeftJustify;
  FDBText.Height     := DefEditBtnHeight;
  {para gravar as propriedades do subcomponente no DFM/XFM}
  FDBText.SetSubComponent( True );
  with FDBText do
    ControlStyle := ControlStyle + [csReplicatable];

  {FPanelButton}
  FPanelButton           := TPanel.Create(FPanelContainer); //Onde vai ficar o Button
  FPanelButton.Name      := 'Ap2PanelButton'+Self.Name;
  FPanelButton.Parent    := FPanelContainer;
  FPanelButton.Visible   := True;
  FPanelButton.Align     := alLeft;
  FPanelButton.BevelOuter:= bvNone;
  FPanelButton.Caption   := '';
  FPanelButton.Width     := 46;
  FPanelButton.Height    := 23;//DefEditBtnHeight;
  with FPanelButton do
    ControlStyle := ControlStyle + [csReplicatable];

  {TAP2GoButtonAdvanced}
  FGoButtonAdvanced            := TAP2GoButtonAdvanced.Create(Self);
  FGoButtonAdvanced.Name       := 'Ap2GoButtonAdvanced'+Self.Name;
  FGoButtonAdvanced.Caption    := 'F3';
  FGoButtonAdvanced.Font.Style := [fsbold];
  FGoButtonAdvanced.Parent     := FPanelButton;
  FGoButtonAdvanced.Left       := Self.Left;   FGoButtonAdvanced.Top := Self.Top;
  FGoButtonAdvanced.Visible    := True;
  FGoButtonAdvanced.Cursor     := crArrow;
  FGoButtonAdvanced.Width      := 45;
  FGoButtonAdvanced.Height     := 22;
  FGoButtonAdvanced.Transparent:= True;
  FGoButtonAdvanced.AutoHeightButton := True;
  with FGoButtonAdvanced do
    ControlStyle := ControlStyle + [csReplicatable];
  {para gravar as propriedades do subcomponente no DFM/XFM}
  FGoButtonAdvanced.SetSubComponent( True );


  TAp2EditButtonLookup(FGoButtonAdvanced).OnClick := aClick;
//  TAp2EditButton(Self).OnKeyDown := DBEditButtonOnKeyDown;
  ControlStyle   := ControlStyle - [csSetCaption];
  FEditorEnabled := True;
end;

{ TAP2Splitter }
procedure TAP2Splitter.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

end.
