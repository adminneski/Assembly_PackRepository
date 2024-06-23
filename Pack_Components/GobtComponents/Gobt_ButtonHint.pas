unit Gobt_ButtonHint;

{$I GOBTLIB.INC}

interface


uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

const
  TMWM_SpecialInvalidate = WM_USER + 1111;

type

  TGoMemoTransparent = class(TMemo)
  private
    procedure SpecialInvalidate(var Message: TMessage);
      message TMWM_SpecialInvalidate;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMSetText(var Message: TWMSetText); message WM_SETTEXT;
    procedure CNCTLCOLOREDIT(var Message: TWMCTLCOLOREDIT);
      message CN_CTLCOLOREDIT;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;



  TGoButtonHint = class(TImage)
     procedure ImageClick(Sender: TObject);
     procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  protected
    { protected declarations }
    procedure UpdateControlBounds; virtual;
    procedure CreateWnd;  //Criar Componetes que so tem Handle por esse create
  private
    { Private declarations }
    FHintColor : TColor;
    FControl: TControl;

    FHintForm : TForm;
    FHintTexto: TStringList;
    FHintFont : TFont;
    FHintWidth  : Integer;
    FHintHeight : Integer;

    FHintLeft  : Integer;
    FHintTop : Integer;


    FMemo : TGoMemoTransparent;

    function  GetControl: TControl;
    procedure SetControl(Value: TControl);

    procedure SetHintTexto(const Value: TStringList);
    procedure SetHintColor(const Value: TColor);

    procedure SetHintFont(const Value: TFont);

    procedure SetHintWidth(const Value: Integer);
    procedure SetHintHeight(const Value: Integer);

    function GetHintWidth:Integer;
    function GetHintHeight:Integer;



  public
    { Public declarations }
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    //

    //
    procedure ShowHint;
    //
    procedure OnFormCreate(Sender: TObject);
    procedure OnFormShow(Sender: TObject);
    procedure OnFormActivate(Sender: TObject);
    procedure OnFormDeactivate(Sender: TObject);
    procedure OnFormMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);

   published
   { published declarations }
    property Control: TControl read GetControl write SetControl;
    property HintTexto: TStringList read FHintTexto write SetHintTexto;
    property HintColor: TColor read FHintColor write SetHintColor;
    property HintFont: TFont read FHintFont write SetHintFont;
    property HintHeight: Integer read GetHintHeight write SetHintHeight;
    property HintWidth: Integer read GetHintWidth write SetHintWidth;
  end;




implementation

uses
  Winapi.Windows;


{ TTransparentMemo }

procedure TGoMemoTransparent.WMHScroll(var Message: TWMHScroll);
begin
  inherited;
  PostMessage(Handle, TMWM_SpecialInvalidate, 0, 0);
end;

procedure TGoMemoTransparent.WMVScroll(var Message: TWMVScroll);
begin
  SendMessage(Handle, TMWM_SpecialInvalidate, 0, 0);
  inherited;
  PostMessage(Handle, TMWM_SpecialInvalidate, 0, 0);
end;

procedure TGoMemoTransparent.CNCTLCOLOREDIT(var Message: TWMCTLCOLOREDIT);
begin
  with Message do
  begin
    SetBkMode(ChildDC, TRANSPARENT);
    Result := GetStockObject(HOLLOW_BRUSH);
  end;
end;

procedure TGoMemoTransparent.WMSetText(var Message: TWMSetText);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    PostMessage(Handle, TMWM_SpecialInvalidate, 0, 0)
end;

procedure TGoMemoTransparent.SpecialInvalidate(var Message: TMessage);
var
  r: TRect;
begin
  if Parent <> nil then
  begin
    r := ClientRect;
    r.TopLeft := Parent.ScreenToClient(ClientToScreen(r.TopLeft));
    r.BottomRight := Parent.ScreenToClient(ClientToScreen(r.BottomRight));
    InvalidateRect(Parent.Handle, @r, true);
    RedrawWindow(Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE)
  end;
end;

procedure TGoMemoTransparent.WMKeyDown(var Message: TWMKeyDown);
begin
  SendMessage(Handle, TMWM_SpecialInvalidate, 0, 0);
  inherited;
  PostMessage(Handle, TMWM_SpecialInvalidate, 0, 0);
end;

procedure TGoMemoTransparent.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1
end;

constructor TGoMemoTransparent.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csCaptureMouse, csDesignInteractive, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable, csNoStdEvents];
end;

procedure TGoMemoTransparent.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
   ExStyle := ExStyle or WS_EX_TRANSPARENT and not WS_EX_WINDOWEDGE
    and not WS_EX_STATICEDGE and not WS_EX_DLGMODALFRAME and not
    WS_EX_CLIENTEDGE;
  end;
end;

constructor TGoButtonHint.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  {$R Pictures.res}

  //Propriedades
  FHintFont := TFont.Create;
  FHintTexto := TStringList.Create;
  FHintColor := clInfoBk;
  FControl := Self;



  Self.AutoSize := true;
  Self.Transparent := true;
  Self.Cursor := crHandPoint;
  Self.OnClick := ImageClick;
  //Ler Imagem Padrao
  Self.Picture.Bitmap.LoadFromResourceName(HInstance,'HELP');
  Self.FHintHeight := 300;
  Self.FHintWidth := 450;
  Self.OnMouseDown := ImageMouseDown;


  //Cria Formulario Hint
  FHintForm := TForm.Create(Self);
  FHintForm.Padding.Left := 15;
  FHintForm.Padding.Top := 15;
  FHintForm.Padding.Right := 15;
  FHintForm.Padding.Bottom := 15;
  FHintForm.BorderStyle := bsNone;
  FHintForm.Position := poDesigned;
  FHintForm.AlphaBlend := True;
  FHintForm.AlphaBlendValue := 250;
  FHintForm.AutoSize := true;
  //Eventos
  FHintForm.OnShow := OnFormShow;
  FHintForm.OnActivate := OnFormActivate;
  FHintForm.OnCreate := OnFormCreate;
  FHintForm.OnDeactivate := OnFormDeactivate;
  FHintForm.OnMouseDown := OnFormMouseDown;


  //Label
  FMemo := TGoMemoTransparent.Create(FHintForm);
  FMemo.Parent := FHintForm;
  FMemo.Align := alClient;
  FMemo.ReadOnly := false;
  FMemo.Enabled := false;
  FMemo.BorderStyle := bsNone;
  FMemo.Color := clInfoBk;
  FMemo.ScrollBars := ssNone;


end;


procedure TGoButtonHint.CreateWnd;
begin
  inherited;
end;

destructor TGoButtonHint.Destroy;
begin
  FreeAndNil(FHintForm);
  FreeAndNil(FHintTexto);
  FreeAndNil(FHintFont);

  inherited Destroy;
end;


function TGoButtonHint.GetControl: TControl;
begin
  if FControl <> Result then
  begin
    if (GetOwner <> nil) and (FControl <> nil) then
    begin
      Result :=  FControl;
    end
  end;
end;



function TGoButtonHint.GetHintHeight: Integer;
begin
  if FHintHeight <> Result then
  begin
    if (GetOwner <> nil)then
    begin
      Result :=  FHintHeight;
    end
  end;
end;

function TGoButtonHint.GetHintWidth: Integer;
begin
  if FHintWidth <> Result then
  begin
    if (GetOwner <> nil)then
    begin
      Result :=  FHintWidth;
    end
  end;
end;

procedure TGoButtonHint.OnFormActivate(Sender: TObject);
begin
  //
end;

procedure TGoButtonHint.OnFormCreate(Sender: TObject);
begin
   FHintForm.Height := FHintHeight;
   FHintForm.Width  := FHintWidth;
end;

procedure TGoButtonHint.OnFormDeactivate(Sender: TObject);
begin
  FHintForm.Close;
end;

procedure TGoButtonHint.OnFormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbleft then
  begin
   ReleaseCapture;
   FHintForm.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;


procedure TGoButtonHint.OnFormShow(Sender: TObject);
var
  pt: TPoint;
  Rect : TRect;
begin
   // Controle de Posição
   // if FControl is TWinControl then // Workaround Delphi bug!!!
   //  GetWindowRect(TWinControl(FControl).Handle,Rect)

     GetCursorPos(pt);
     FHintForm.Left := pt.x+14;
     FHintForm.Top  := pt.y+14;

end;

procedure TGoButtonHint.ImageClick(Sender: TObject);
begin
   ShowHint;
end;

procedure TGoButtonHint.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  r := Self.BoundsRect;

  FHintTop  := R.Top;
  FHintLeft := R.Left;

end;

procedure TGoButtonHint.SetHintColor(const Value: TColor);
begin
   FHintColor := Value;
   TWinControl(GetOwner).Invalidate; // Adicione esta linha, que irá redesenhar o componente no formulário
end;

procedure TGoButtonHint.SetControl(Value: TControl);
begin
  if FControl <> Value then
  begin
    FControl := Value;
    if (GetOwner <> nil) and (FControl <> nil) then
    begin
      UpdateControlBounds;
      //
      //TWinControl(GetOwner).Invalidate; // Adicione esta linha, que irá redesenhar o componente no formulário
    end
    else
    begin
      FControl := Self;
    end;

  end;
end;

procedure TGoButtonHint.SetHintFont(const Value: TFont);
begin
   FHintFont.Assign( Value ) ;
end;

procedure TGoButtonHint.SetHintHeight(const Value: Integer);
begin
   FHintHeight := Value;
end;

procedure TGoButtonHint.SetHintWidth(const Value: Integer);
begin
   FHintWidth := Value;
 end;

procedure TGoButtonHint.SetHintTexto(const Value: TStringList);
begin
 if FHintTexto <> Value then
    FHintTexto.Assign(Value);
end;

procedure TGoButtonHint.ShowHint;
begin
   //
   FHintForm.Color := FHintColor;

   //
   FHintFont.Size := 12;
   FHintFont.Name := 'Arial';
   FMemo.Font := FHintFont;

   if Length(Trim(FHintTexto.Text)) > 0  then
   FMemo.Text := FHintTexto.Text
   else
   FMemo.Text := Self.Name;

   //
   FHintForm.Show;

end;

procedure TGoButtonHint.UpdateControlBounds;
var
  Borders: array[0..2] of Integer;
  Rect: TRect;
begin
  if Assigned(FControl) and (GetOwner <> nil) then
  begin
    SetRect(Rect, FControl.Left+FControl.Width+5,(FControl.Top-1),0, 0);
    //
    Self.BoundsRect := Rect;
  end;
end;






end.
