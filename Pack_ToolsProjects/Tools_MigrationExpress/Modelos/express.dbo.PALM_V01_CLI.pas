unit express.dbo.PALM_V01_CLI;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PALM_V01_CLI', '')]
  TDtoPALM_V01_CLI = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_CAIXAPOSTAL: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR: String;
    FPES_CLIENTE: String;
    FPES_FORNECEDOR: String;
    FPES_FABRICANTE: String;
    FPES_VENDEDOR: String;
    FPES_CONTATO: String;
    FPES_TRANSPORTADOR: String;
    FPES_CONVENIO: String;
    FPES_PORTADOR: String;
    FPES_FUNCIONARIO: String;
    FCEP_CODIGO: String;
    FCID_CODIGO: String;
    FTAB_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_TIPOPESSOA: String;
    FPES_BLOQUEADO: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_LIMITECOMPRA: Double;
    FPES_LIMITECREDITO: Double;
    FROT_CODIGO: Integer;
    FPES_PERCENTUALDESCONTO: Double;
    FPES_PERCENTUALAJUDACUSTO: Double;
    FPES_PERCENTUALCOMISSAO: Double;
    FPES_TIPOCOMISSAO: String;
    FPES_VALORSALARIO: Double;
    FPRZ_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FCID_NOME: String;
    FUFS_SIGLA: String;
    FPRZ_DESCRICAO: String;
    FFPG_DESCRICAO: String;
    FPES_EMAIL: String;
    FPES_DATACADASTRO: TDateTime;
    FPES_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_CLI';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO', ftString, 100)]
    [Dictionary('PES_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO: String read FPES_ENDERECO write FPES_ENDERECO;
    const PES_ENDERECO_Name = 'PES_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO: String read FPES_NUMEROENDERECO write FPES_NUMEROENDERECO;
    const PES_NUMEROENDERECO_Name = 'PES_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('PES_CAIXAPOSTAL', ftString, 5)]
    [Dictionary('PES_CAIXAPOSTAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CAIXAPOSTAL: String read FPES_CAIXAPOSTAL write FPES_CAIXAPOSTAL;
    const PES_CAIXAPOSTAL_Name = 'PES_CAIXAPOSTAL';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR: String read FPES_DDD_CELULAR write FPES_DDD_CELULAR;
    const PES_DDD_CELULAR_Name = 'PES_DDD_CELULAR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CLIENTE', ftString, 1)]
    [Dictionary('PES_CLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CLIENTE: String read FPES_CLIENTE write FPES_CLIENTE;
    const PES_CLIENTE_Name = 'PES_CLIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FORNECEDOR', ftString, 1)]
    [Dictionary('PES_FORNECEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FORNECEDOR: String read FPES_FORNECEDOR write FPES_FORNECEDOR;
    const PES_FORNECEDOR_Name = 'PES_FORNECEDOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FABRICANTE', ftString, 1)]
    [Dictionary('PES_FABRICANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FABRICANTE: String read FPES_FABRICANTE write FPES_FABRICANTE;
    const PES_FABRICANTE_Name = 'PES_FABRICANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_VENDEDOR', ftString, 1)]
    [Dictionary('PES_VENDEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_VENDEDOR: String read FPES_VENDEDOR write FPES_VENDEDOR;
    const PES_VENDEDOR_Name = 'PES_VENDEDOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CONTATO', ftString, 1)]
    [Dictionary('PES_CONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CONTATO: String read FPES_CONTATO write FPES_CONTATO;
    const PES_CONTATO_Name = 'PES_CONTATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TRANSPORTADOR', ftString, 1)]
    [Dictionary('PES_TRANSPORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TRANSPORTADOR: String read FPES_TRANSPORTADOR write FPES_TRANSPORTADOR;
    const PES_TRANSPORTADOR_Name = 'PES_TRANSPORTADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CONVENIO', ftString, 1)]
    [Dictionary('PES_CONVENIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CONVENIO: String read FPES_CONVENIO write FPES_CONVENIO;
    const PES_CONVENIO_Name = 'PES_CONVENIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_PORTADOR', ftString, 1)]
    [Dictionary('PES_PORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PORTADOR: String read FPES_PORTADOR write FPES_PORTADOR;
    const PES_PORTADOR_Name = 'PES_PORTADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FUNCIONARIO', ftString, 1)]
    [Dictionary('PES_FUNCIONARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FUNCIONARIO: String read FPES_FUNCIONARIO write FPES_FUNCIONARIO;
    const PES_FUNCIONARIO_Name = 'PES_FUNCIONARIO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_CODIGO', ftString, 7)]
    [Dictionary('CID_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_CODIGO: String read FCID_CODIGO write FCID_CODIGO;
    const CID_CODIGO_Name = 'CID_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO: String read FPES_FANTASIA_OU_APELIDO write FPES_FANTASIA_OU_APELIDO;
    const PES_FANTASIA_OU_APELIDO_Name = 'PES_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_BLOQUEADO', ftString, 1)]
    [Dictionary('PES_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BLOQUEADO: String read FPES_BLOQUEADO write FPES_BLOQUEADO;
    const PES_BLOQUEADO_Name = 'PES_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('PES_LIMITECOMPRA', ftBCD)]
    [Dictionary('PES_LIMITECOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_LIMITECOMPRA: Double read FPES_LIMITECOMPRA write FPES_LIMITECOMPRA;
    const PES_LIMITECOMPRA_Name = 'PES_LIMITECOMPRA';

    [Restrictions([NoValidate])]
    [Column('PES_LIMITECREDITO', ftBCD)]
    [Dictionary('PES_LIMITECREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_LIMITECREDITO: Double read FPES_LIMITECREDITO write FPES_LIMITECREDITO;
    const PES_LIMITECREDITO_Name = 'PES_LIMITECREDITO';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('PES_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALDESCONTO: Double read FPES_PERCENTUALDESCONTO write FPES_PERCENTUALDESCONTO;
    const PES_PERCENTUALDESCONTO_Name = 'PES_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALAJUDACUSTO', ftBCD, 48, 2)]
    [Dictionary('PES_PERCENTUALAJUDACUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALAJUDACUSTO: Double read FPES_PERCENTUALAJUDACUSTO write FPES_PERCENTUALAJUDACUSTO;
    const PES_PERCENTUALAJUDACUSTO_Name = 'PES_PERCENTUALAJUDACUSTO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PES_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALCOMISSAO: Double read FPES_PERCENTUALCOMISSAO write FPES_PERCENTUALCOMISSAO;
    const PES_PERCENTUALCOMISSAO_Name = 'PES_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCOMISSAO', ftString, 1)]
    [Dictionary('PES_TIPOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCOMISSAO: String read FPES_TIPOCOMISSAO write FPES_TIPOCOMISSAO;
    const PES_TIPOCOMISSAO_Name = 'PES_TIPOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_VALORSALARIO', ftBCD, 48, 2)]
    [Dictionary('PES_VALORSALARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_VALORSALARIO: Double read FPES_VALORSALARIO write FPES_VALORSALARIO;
    const PES_VALORSALARIO_Name = 'PES_VALORSALARIO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_NOME', ftString, 100)]
    [Dictionary('CID_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_NOME: String read FCID_NOME write FCID_NOME;
    const CID_NOME_Name = 'CID_NOME';

    [Restrictions([NoValidate])]
    [Column('UFS_SIGLA', ftString, 2)]
    [Dictionary('UFS_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UFS_SIGLA: String read FUFS_SIGLA write FUFS_SIGLA;
    const UFS_SIGLA_Name = 'UFS_SIGLA';

    [Restrictions([NoValidate])]
    [Column('PRZ_DESCRICAO', ftString, 30)]
    [Dictionary('PRZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_DESCRICAO: String read FPRZ_DESCRICAO write FPRZ_DESCRICAO;
    const PRZ_DESCRICAO_Name = 'PRZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATACADASTRO', ftDateTime)]
    [Dictionary('PES_DATACADASTRO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATACADASTRO: TDateTime read FPES_DATACADASTRO write FPES_DATACADASTRO;
    const PES_DATACADASTRO_Name = 'PES_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('PES_OBSERVACAO', ftString, 300)]
    [Dictionary('PES_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_OBSERVACAO: String read FPES_OBSERVACAO write FPES_OBSERVACAO;
    const PES_OBSERVACAO_Name = 'PES_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_CLI)

end.
