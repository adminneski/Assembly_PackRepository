unit Dlg_Finalizado;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmFinalizado = class(TForm)
    pnlConteudo: TPanel;
    lblTitulo:   TLabel;
    lblAtencao:  TLabel;
    lblConteudo: TLabel;
    btnOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinalizado: TfrmFinalizado;

implementation

uses
  Frm_MigrationExpress;

{$R *.dfm}

procedure TfrmFinalizado.btnOKClick(Sender: TObject);
begin
  close;
end;

procedure TfrmFinalizado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmMigrationExpress.btnBuscarEmpresa.Enabled      := False;
  FrmMigrationExpress.btnValidacaoDatabase.Enabled  := False;
  FrmMigrationExpress.btnAbaConversao.Enabled       := False;
  FrmMigrationExpress.btnAbaReparo.Enabled          := False;
end;

procedure TfrmFinalizado.FormCreate(Sender: TObject);
begin
  lblConteudo.Caption := 'Lembre-se de executar o NUD do Express' + #13 +
                         'para a criação de todas as Constraints,'+ #13 +
                                'ForeignKey e PrimaryKey.'
end;

end.
