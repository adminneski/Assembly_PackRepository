unit Dlg_Connection;

interface

uses
  Winapi.Windows
  ,Winapi.Messages
  ,System.SysUtils
  ,System.Variants
  ,System.Classes
  ,Vcl.Graphics
  ,Vcl.Controls
  ,Vcl.Forms
  ,Vcl.Dialogs
  ,Vcl.ExtCtrls
  ,Vcl.StdCtrls
  ,Vcl.Buttons
  ,Gobt_ButtonAdvanced

  // MigrationExpress
  ,Dtm_MigrationExpress;

type
  TFrmConnection = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtInstanciaOrigem: TEdit;
    Label6: TLabel;
    edtSenhaOrigem: TEdit;
    Label15: TLabel;
    cbxDatabaseOrigem: TComboBox;
    Label4: TLabel;
    edtInstanciaDestino: TEdit;
    Label5: TLabel;
    edtSenhaDestino: TEdit;
    Label7: TLabel;
    cbxDatabaseDestino: TComboBox;
    btnConectarOrigem: TGoButtonAdvanced;
    btnConectarDestino: TGoButtonAdvanced;
    Shape2: TShape;

    // Eventos do Formulario
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    // Eventos dos Botoes
    procedure btnConectarDestinoClick(Sender: TObject);
    procedure btnConectarOrigemClick(Sender: TObject);
    // Procedimentos e Funções
    procedure ListarBasesOrigem;
    procedure ListarBasesDestino;

  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmConnection: TFrmConnection;

implementation

{$R *.dfm}

procedure TFrmConnection.btnConectarDestinoClick(Sender: TObject);
begin
  if (Length(cbxDatabaseDestino.Text) = 0) then
  begin
    if cbxDatabaseDestino.Items.Count = 0 then
      ListarBasesDestino;

    cbxDatabaseDestino.DroppedDown := True;
    Exit;
  end;
  try
    if DtmMigrationExpress.ConectarDestino(edtInstanciaDestino.Text, edtSenhaDestino.Text, cbxDatabaseDestino.Text) then
    begin
      btnConectarDestino.Enabled  := False;
      edtInstanciaDestino.Enabled := False;
      edtSenhaDestino.Enabled     := False;
      cbxDatabaseDestino.Enabled  := False;
    end
    else
    begin
      // Aparencia Normal do Botão
      btnConectarDestino.Appearance.BorderColor       := $004444FF;
      btnConectarDestino.Appearance.Color             := $004444FF;
      btnConectarDestino.Appearance.ColorMirror       := $004444FF;
      btnConectarDestino.Appearance.ColorMirrorTo     := $004444FF;
      btnConectarDestino.Appearance.ColorTo           := $004444FF;

      // Aparencia quando esta com mouse em cima do botão
      btnConectarDestino.Appearance.BorderColorHot    := $000000CC;
      btnConectarDestino.Appearance.ColorHot          := $000000CC;
      btnConectarDestino.Appearance.ColorHotTo        := $000000CC;
      btnConectarDestino.Appearance.ColorMirrorHot    := $000000CC;
      btnConectarDestino.Appearance.ColorMirrorHotTo  := $000000CC;
    end;
  except on E: Exception do
    begin
      // Aparencia Normal do Botão
      btnConectarDestino.Appearance.BorderColor   := $004444FF;
      btnConectarDestino.Appearance.Color         := $004444FF;
      btnConectarDestino.Appearance.ColorMirror   := $004444FF;
      btnConectarDestino.Appearance.ColorMirrorTo := $004444FF;
      btnConectarDestino.Appearance.ColorTo       := $004444FF;

      // Aparencia quando esta com mouse em cima do botão
      btnConectarDestino.Appearance.BorderColorHot   := $000000CC;
      btnConectarDestino.Appearance.ColorHot         := $000000CC;
      btnConectarDestino.Appearance.ColorHotTo       := $000000CC;
      btnConectarDestino.Appearance.ColorMirrorHot   := $000000CC;
      btnConectarDestino.Appearance.ColorMirrorHotTo := $000000CC;
    end;
  end;
end;

procedure TFrmConnection.btnConectarOrigemClick(Sender: TObject);
begin
  if (Length(cbxDatabaseOrigem.Text) = 0) then
  begin
    if cbxDatabaseOrigem.Items.Count = 0 then
      ListarBasesOrigem;

    cbxDatabaseOrigem.DroppedDown := True;
    Exit;
  end;
  try
    if DtmMigrationExpress.ConectarOrigem(edtInstanciaOrigem.Text, edtSenhaOrigem.Text, cbxDatabaseOrigem.Text) then
    begin
      btnConectarOrigem.Enabled  := False;
      edtInstanciaOrigem.Enabled := False;
      edtSenhaOrigem.Enabled     := False;
      cbxDatabaseOrigem.Enabled  := False;
    end
    else
    begin
      // Aparencia Normal do Botão
      btnConectarOrigem.Appearance.BorderColor   := $004444FF;
      btnConectarOrigem.Appearance.Color         := $004444FF;
      btnConectarOrigem.Appearance.ColorMirror   := $004444FF;
      btnConectarOrigem.Appearance.ColorMirrorTo := $004444FF;
      btnConectarOrigem.Appearance.ColorTo       := $004444FF;

      // Aparencia quando esta com mouse em cima do botão
      btnConectarOrigem.Appearance.BorderColorHot   := $000000CC;
      btnConectarOrigem.Appearance.ColorHot         := $000000CC;
      btnConectarOrigem.Appearance.ColorHotTo       := $000000CC;
      btnConectarOrigem.Appearance.ColorMirrorHot   := $000000CC;
      btnConectarOrigem.Appearance.ColorMirrorHotTo := $000000CC;
    end;
  except on E: Exception do
    begin
      // Aparencia Normal do Botão
      btnConectarOrigem.Appearance.BorderColor   := $004444FF;
      btnConectarOrigem.Appearance.Color         := $004444FF;
      btnConectarOrigem.Appearance.ColorMirror   := $004444FF;
      btnConectarOrigem.Appearance.ColorMirrorTo := $004444FF;
      btnConectarOrigem.Appearance.ColorTo       := $004444FF;

      // Aparencia quando esta com mouse em cima do botão
      btnConectarOrigem.Appearance.BorderColorHot   := $000000CC;
      btnConectarOrigem.Appearance.ColorHot         := $000000CC;
      btnConectarOrigem.Appearance.ColorHotTo       := $000000CC;
      btnConectarOrigem.Appearance.ColorMirrorHot   := $000000CC;
      btnConectarOrigem.Appearance.ColorMirrorHotTo := $000000CC;
    end;
  end;
end;

procedure TFrmConnection.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  CanClose := not ((btnConectarOrigem.Enabled) or (btnConectarDestino.Enabled));
  if not ((btnConectarOrigem.Enabled) or (btnConectarDestino.Enabled)) then
    ModalResult := mrOk;
end;

procedure TFrmConnection.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssAlt]) and (Chr(Key)='1') then
    begin
      cbxDatabaseOrigem.SetFocus;
      btnConectarOrigemClick(Sender)
    end
  else if (Shift = [ssAlt]) and (Chr(Key)='2') then
    begin
      cbxDatabaseDestino.SetFocus;
      btnConectarDestinoClick(Sender)
    end
  else if Key = VK_ESCAPE then
    begin
      Close;
    end;
end;

procedure TFrmConnection.ListarBasesDestino;
var
  i : Integer;
  s : TStringList;
begin
  DtmMigrationExpress.ConectarDestino(edtInstanciaDestino.Text, edtSenhaDestino.Text, cbxDatabaseDestino.Text);
  if DtmMigrationExpress.ConnectionDestino.Connected then
  begin
    try
      i := 0;
      cbxDatabaseOrigem.Items.Clear;
      s := TStringList.Create;
      DtmMigrationExpress.ConnectionDestino.GetCatalogNames('', s);
      for i := 0 to Pred(s.Count) do
      begin
        if (s[i] <> 'master') and (s[i] <> 'msdb') and (s[i] <> 'tempdb') and (s[i] <> cbxDatabaseOrigem.Text) then
          cbxDatabaseDestino.Items.Add(s[i]);
      end;
    finally
      FreeAndNil(s);
    end;
  end
  else
  begin
    Application.MessageBox('Favor Conectar a Instancia ''\NESKI''.','Atenção',MB_OK+MB_ICONEXCLAMATION);
  end;
end;

procedure TFrmConnection.ListarBasesOrigem;
var
  i : Integer;
  s : TStringList;
begin
  DtmMigrationExpress.ConectarOrigem(edtInstanciaOrigem.Text, edtSenhaOrigem.Text, cbxDatabaseOrigem.Text);
  if DtmMigrationExpress.ConnectionOrigem.Connected then
  begin
    try
      cbxDatabaseOrigem.Items.Clear;
      s := TStringList.Create;
      DtmMigrationExpress.ConnectionOrigem.GetCatalogNames('', s);
      for i := 0 to Pred(s.Count) do
      begin
        if (s[i] <> 'master') and (s[i] <> 'msdb') and (s[i] <> 'tempdb') and (s[i] <> cbxDatabaseDestino.Text) then
          cbxDatabaseOrigem.Items.Add(s[i]);
      end;
    finally
      FreeAndNil(s);
    end;
  end
  else
  begin
    Application.MessageBox('Favor Conectar a Instancia ''\NESKI''.','Atenção',MB_OK+MB_ICONEXCLAMATION);
  end;
end;

end.
