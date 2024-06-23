unit express.dbo.PALM_V01_VND;

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
  [Table('PALM_V01_VND', '')]
  TDtoPALM_V01_VND = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_CAIXAPOSTAL: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_1: String;
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
    FCID_IBGE: String;
    FTAB_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_TIPOPESSOA: String;
    FPES_DESATIVADO: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_LIMITECOMPRA: Double;
    FPES_LIMITECREDITO: Double;
    FROT_CODIGO: Integer;
    FPES_PERCENTUALDESCTOPERMITIDO: Double;
    FPES_PERCENTUALAJUDACUSTO: Double;
    FPES_PERCENTUALCOMISSAO: Double;
    FPES_TIPOCOMISSAO: String;
    FPES_VALORSALARIO: Double;
    FPRZ_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPRZ_DESCRICAO: String;
    FFPG_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_VND';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO', ftString, 100)]
    [Dictionary('PES_ENDERECO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_ENDERECO: String read FPES_ENDERECO write FPES_ENDERECO;
    const PES_ENDERECO_Name = 'PES_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO: String read FPES_NUMEROENDERECO write FPES_NUMEROENDERECO;
    const PES_NUMEROENDERECO_Name = 'PES_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('PES_CAIXAPOSTAL', ftString, 5)]
    [Dictionary('PES_CAIXAPOSTAL', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CAIXAPOSTAL: String read FPES_CAIXAPOSTAL write FPES_CAIXAPOSTAL;
    const PES_CAIXAPOSTAL_Name = 'PES_CAIXAPOSTAL';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CLIENTE', ftString, 1)]
    [Dictionary('PES_CLIENTE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CLIENTE: String read FPES_CLIENTE write FPES_CLIENTE;
    const PES_CLIENTE_Name = 'PES_CLIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FORNECEDOR', ftString, 1)]
    [Dictionary('PES_FORNECEDOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FORNECEDOR: String read FPES_FORNECEDOR write FPES_FORNECEDOR;
    const PES_FORNECEDOR_Name = 'PES_FORNECEDOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FABRICANTE', ftString, 1)]
    [Dictionary('PES_FABRICANTE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FABRICANTE: String read FPES_FABRICANTE write FPES_FABRICANTE;
    const PES_FABRICANTE_Name = 'PES_FABRICANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_VENDEDOR', ftString, 1)]
    [Dictionary('PES_VENDEDOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_VENDEDOR: String read FPES_VENDEDOR write FPES_VENDEDOR;
    const PES_VENDEDOR_Name = 'PES_VENDEDOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CONTATO', ftString, 1)]
    [Dictionary('PES_CONTATO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CONTATO: String read FPES_CONTATO write FPES_CONTATO;
    const PES_CONTATO_Name = 'PES_CONTATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TRANSPORTADOR', ftString, 1)]
    [Dictionary('PES_TRANSPORTADOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_TRANSPORTADOR: String read FPES_TRANSPORTADOR write FPES_TRANSPORTADOR;
    const PES_TRANSPORTADOR_Name = 'PES_TRANSPORTADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CONVENIO', ftString, 1)]
    [Dictionary('PES_CONVENIO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CONVENIO: String read FPES_CONVENIO write FPES_CONVENIO;
    const PES_CONVENIO_Name = 'PES_CONVENIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_PORTADOR', ftString, 1)]
    [Dictionary('PES_PORTADOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_PORTADOR: String read FPES_PORTADOR write FPES_PORTADOR;
    const PES_PORTADOR_Name = 'PES_PORTADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FUNCIONARIO', ftString, 1)]
    [Dictionary('PES_FUNCIONARIO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FUNCIONARIO: String read FPES_FUNCIONARIO write FPES_FUNCIONARIO;
    const PES_FUNCIONARIO_Name = 'PES_FUNCIONARIO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO: String read FPES_FANTASIA_OU_APELIDO write FPES_FANTASIA_OU_APELIDO;
    const PES_FANTASIA_OU_APELIDO_Name = 'PES_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DESATIVADO', ftString, 1)]
    [Dictionary('PES_DESATIVADO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_DESATIVADO: String read FPES_DESATIVADO write FPES_DESATIVADO;
    const PES_DESATIVADO_Name = 'PES_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('PES_LIMITECOMPRA', ftBCD)]
    [Dictionary('PES_LIMITECOMPRA', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property PES_LIMITECOMPRA: Double read FPES_LIMITECOMPRA write FPES_LIMITECOMPRA;
    const PES_LIMITECOMPRA_Name = 'PES_LIMITECOMPRA';

    [Restrictions([NoValidate])]
    [Column('PES_LIMITECREDITO', ftBCD)]
    [Dictionary('PES_LIMITECREDITO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property PES_LIMITECREDITO: Double read FPES_LIMITECREDITO write FPES_LIMITECREDITO;
    const PES_LIMITECREDITO_Name = 'PES_LIMITECREDITO';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALDESCTOPERMITIDO', ftBCD, 48, 2)]
    [Dictionary('PES_PERCENTUALDESCTOPERMITIDO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property PES_PERCENTUALDESCTOPERMITIDO: Double read FPES_PERCENTUALDESCTOPERMITIDO write FPES_PERCENTUALDESCTOPERMITIDO;
    const PES_PERCENTUALDESCTOPERMITIDO_Name = 'PES_PERCENTUALDESCTOPERMITIDO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALAJUDACUSTO', ftBCD)]
    [Dictionary('PES_PERCENTUALAJUDACUSTO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property PES_PERCENTUALAJUDACUSTO: Double read FPES_PERCENTUALAJUDACUSTO write FPES_PERCENTUALAJUDACUSTO;
    const PES_PERCENTUALAJUDACUSTO_Name = 'PES_PERCENTUALAJUDACUSTO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PES_PERCENTUALCOMISSAO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property PES_PERCENTUALCOMISSAO: Double read FPES_PERCENTUALCOMISSAO write FPES_PERCENTUALCOMISSAO;
    const PES_PERCENTUALCOMISSAO_Name = 'PES_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCOMISSAO', ftString, 1)]
    [Dictionary('PES_TIPOCOMISSAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_TIPOCOMISSAO: String read FPES_TIPOCOMISSAO write FPES_TIPOCOMISSAO;
    const PES_TIPOCOMISSAO_Name = 'PES_TIPOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_VALORSALARIO', ftBCD)]
    [Dictionary('PES_VALORSALARIO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property PES_VALORSALARIO: Double read FPES_VALORSALARIO write FPES_VALORSALARIO;
    const PES_VALORSALARIO_Name = 'PES_VALORSALARIO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('PRZ_DESCRICAO', ftString, 30)]
    [Dictionary('PRZ_DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PRZ_DESCRICAO: String read FPRZ_DESCRICAO write FPRZ_DESCRICAO;
    const PRZ_DESCRICAO_Name = 'PRZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_VND)

end.
