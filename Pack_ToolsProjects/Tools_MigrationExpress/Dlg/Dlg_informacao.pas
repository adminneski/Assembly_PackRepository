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
  lblInstrucao.Caption := ' Aplica��o para realiza��o da migra��o de dados do banco de dados Neski ERP para o Neski Express, sendo necessario '+
                    'ter um banco de dados zerado do Express atachado na inst�ncia do mesmo. ' + #13#13 +
                    ' Para realiza��o da migra��o as empresas que ser�o migradas dever�o estar cadastradas no novo Cadastro de Clientes da Neski, ' +
                    'caso n�o esteja pedir para o financeiro da Neski cadastrar as empresas, pois o sistema verifica neste cadastro para trazer ' +
                    'os novos codigos de "Filiais"(Empresa) que s�o gerados aos cadastrar para subistituir os antigos codigos de filiais. ' + #13#13 +
                    ' Ap�s, realizar a conex�o com os dois bancos para realiza��o de todos os processos, Click no primeiro icone azul na esquerda '+
                    'depois ir clicando em pr�ximo at� finalizar o processo.' + #13#13 +
                    ' O ultimo bot�o a esqueda n�o faz parte do processo de migra��o, o mesmo tem a funcionalidade de abrir o aplicativo '+
                    'de Backup caso necessario.'+ #13#13 +
                    ' Ao termino de todo o processo executar o NUD do Express para a cria��o de todas as Constraints, ForeignKey, PrimaryKey. ';
end;

end.
