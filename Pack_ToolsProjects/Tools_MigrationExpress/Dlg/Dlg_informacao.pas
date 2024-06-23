unit Dlg_informacao;

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
  Vcl.StdCtrls;

type
  TfrmInformacao = class(TForm)
    lblInstrucao: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInformacao: TfrmInformacao;

implementation

{$R *.dfm}

procedure TfrmInformacao.FormCreate(Sender: TObject);
begin
  lblInstrucao.Caption := ' Aplicação para realização da migração de dados do banco de dados Neski ERP para o Neski Express, sendo necessario '+
                    'ter um banco de dados zerado do Express atachado na instância do mesmo. ' + #13#13 +
                    ' Para realização da migração as empresas que serão migradas deverão estar cadastradas no novo Cadastro de Clientes da Neski, ' +
                    'caso não esteja pedir para o financeiro da Neski cadastrar as empresas, pois o sistema verifica neste cadastro para trazer ' +
                    'os novos codigos de "Filiais"(Empresa) que são gerados aos cadastrar para subistituir os antigos codigos de filiais. ' + #13#13 +
                    ' Após, realizar a conexão com os dois bancos para realização de todos os processos, Click no primeiro icone azul na esquerda '+
                    'depois ir clicando em próximo até finalizar o processo.' + #13#13 +
                    ' O ultimo botão a esqueda não faz parte do processo de migração, o mesmo tem a funcionalidade de abrir o aplicativo '+
                    'de Backup caso necessario.'+ #13#13 +
                    ' Ao termino de todo o processo executar o NUD do Express para a criação de todas as Constraints, ForeignKey, PrimaryKey. ';
end;

end.
