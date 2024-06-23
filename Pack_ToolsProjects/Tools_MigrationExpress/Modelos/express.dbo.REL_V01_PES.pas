unit express.dbo.REL_V01_PES;

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
  [Table('REL_V01_PES', '')]
  TDtoREL_V01_PES = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_DATACADASTRO: TDateTime;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_CAIXAPOSTAL: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_TELEFONE_2: String;
    FPES_DDD_TELEFONE_3: String;
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
    FPES_SEXO: String;
    FPES_PARAMETROS: String;
    FPES_LIMITECOMPRA: Double;
    FPES_LIMITECREDITO: Double;
    FROT_CODIGO: Integer;
    FPES_PERCENTUALDESCONTO: Double;
    FPES_PERCENTUALAJUDACUSTO: Double;
    FPES_PERCENTUALCOMISSAO: Double;
    FPES_TIPOCOMISSAO: String;
    FPES_SALARIO: Double;
    FPRZ_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPRZ_DESCRICAO: String;
    FFPG_DESCRICAO: String;
    FVEI_CODIGO: Integer;
    FPES_REGISTROHABILITACAO: String;
    FPES_SITUACAOFUNCIONAL: String;
    FPES_PAI: String;
    FPES_MAE: String;
    FPES_EMAIL: String;
    FPES_EMAILXML: String;
    FCID_IBGECOBRANCA: String;
    FPES_CIDADECOBRANCA: String;
    FPES_UFCOBRANCA: String;
    FCEP_CODIGOCOBRANCA: String;
    FPES_ENDERECOCOBRANCA: String;
    FPES_BAIRROCOBRANCA: String;
    FPES_CAIXAPOSTALCOBRANCA: String;
    FPES_NUMEROENDERECOCOBRANCA: String;
    FPES_HISTORICOSPC: TBlob;
    FPES_OBSERVACAO: String;
    FPES_ESTADOCIVIL: String;
    FPES_NOMECONJUGE: String;
    FPES_ORDEMENTREGA: String;
    FPES_DATANASCIMENTO: TDateTime;
    FPES_IDADE: Double;
    FPES_FUNCAO: String;
    FPES_DATAADMISSAO: TDateTime;
    FPES_TAMANHOUNIFORME: String;
    FPES_DATAENTREGAUNIFORME: TDateTime;
    FPES_ULTIMOEXAME: String;
    FPES_DATAULTIMOEXAME: TDateTime;
    FPES_DATAALTERACAO: TDateTime;
    FSEG_CODIGO: Integer;
    FSEG_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_PES';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATACADASTRO', ftDateTime)]
    [Dictionary('PES_DATACADASTRO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATACADASTRO: TDateTime read FPES_DATACADASTRO write FPES_DATACADASTRO;
    const PES_DATACADASTRO_Name = 'PES_DATACADASTRO';

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
    [Column('PES_PONTOREFERENCIA', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA: String read FPES_PONTOREFERENCIA write FPES_PONTOREFERENCIA;
    const PES_PONTOREFERENCIA_Name = 'PES_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_2: String read FPES_DDD_TELEFONE_2 write FPES_DDD_TELEFONE_2;
    const PES_DDD_TELEFONE_2_Name = 'PES_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_3', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_3: String read FPES_DDD_TELEFONE_3 write FPES_DDD_TELEFONE_3;
    const PES_DDD_TELEFONE_3_Name = 'PES_DDD_TELEFONE_3';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

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
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DESATIVADO', ftString, 1)]
    [Dictionary('PES_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DESATIVADO: String read FPES_DESATIVADO write FPES_DESATIVADO;
    const PES_DESATIVADO_Name = 'PES_DESATIVADO';

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
    [Column('PES_SEXO', ftString, 1)]
    [Dictionary('PES_SEXO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_SEXO: String read FPES_SEXO write FPES_SEXO;
    const PES_SEXO_Name = 'PES_SEXO';

    [Restrictions([NoValidate])]
    [Column('PES_PARAMETROS', ftString, 10)]
    [Dictionary('PES_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PARAMETROS: String read FPES_PARAMETROS write FPES_PARAMETROS;
    const PES_PARAMETROS_Name = 'PES_PARAMETROS';

    [Restrictions([NoValidate])]
    [Column('PES_LIMITECOMPRA', ftBCD)]
    [Dictionary('PES_LIMITECOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_LIMITECOMPRA: Double read FPES_LIMITECOMPRA write FPES_LIMITECOMPRA;
    const PES_LIMITECOMPRA_Name = 'PES_LIMITECOMPRA';

    [Restrictions([NoValidate])]
    [Column('PES_LIMITECREDITO', ftBCD, 48, 2)]
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
    [Column('PES_PERCENTUALAJUDACUSTO', ftBCD)]
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
    [Column('PES_SALARIO', ftBCD)]
    [Dictionary('PES_SALARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_SALARIO: Double read FPES_SALARIO write FPES_SALARIO;
    const PES_SALARIO_Name = 'PES_SALARIO';

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
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

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
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_REGISTROHABILITACAO', ftString, 15)]
    [Dictionary('PES_REGISTROHABILITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_REGISTROHABILITACAO: String read FPES_REGISTROHABILITACAO write FPES_REGISTROHABILITACAO;
    const PES_REGISTROHABILITACAO_Name = 'PES_REGISTROHABILITACAO';

    [Restrictions([NoValidate])]
    [Column('PES_SITUACAOFUNCIONAL', ftString, 1)]
    [Dictionary('PES_SITUACAOFUNCIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_SITUACAOFUNCIONAL: String read FPES_SITUACAOFUNCIONAL write FPES_SITUACAOFUNCIONAL;
    const PES_SITUACAOFUNCIONAL_Name = 'PES_SITUACAOFUNCIONAL';

    [Restrictions([NoValidate])]
    [Column('PES_PAI', ftString, 50)]
    [Dictionary('PES_PAI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAI: String read FPES_PAI write FPES_PAI;
    const PES_PAI_Name = 'PES_PAI';

    [Restrictions([NoValidate])]
    [Column('PES_MAE', ftString, 50)]
    [Dictionary('PES_MAE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_MAE: String read FPES_MAE write FPES_MAE;
    const PES_MAE_Name = 'PES_MAE';

    [Restrictions([NoValidate])]
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILXML', ftString, 300)]
    [Dictionary('PES_EMAILXML', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILXML: String read FPES_EMAILXML write FPES_EMAILXML;
    const PES_EMAILXML_Name = 'PES_EMAILXML';

    [Restrictions([NoValidate])]
    [Column('CID_IBGECOBRANCA', ftString, 7)]
    [Dictionary('CID_IBGECOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGECOBRANCA: String read FCID_IBGECOBRANCA write FCID_IBGECOBRANCA;
    const CID_IBGECOBRANCA_Name = 'CID_IBGECOBRANCA';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADECOBRANCA', ftString, 100)]
    [Dictionary('PES_CIDADECOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADECOBRANCA: String read FPES_CIDADECOBRANCA write FPES_CIDADECOBRANCA;
    const PES_CIDADECOBRANCA_Name = 'PES_CIDADECOBRANCA';

    [Restrictions([NoValidate])]
    [Column('PES_UFCOBRANCA', ftString, 2)]
    [Dictionary('PES_UFCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFCOBRANCA: String read FPES_UFCOBRANCA write FPES_UFCOBRANCA;
    const PES_UFCOBRANCA_Name = 'PES_UFCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGOCOBRANCA', ftString, 8)]
    [Dictionary('CEP_CODIGOCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGOCOBRANCA: String read FCEP_CODIGOCOBRANCA write FCEP_CODIGOCOBRANCA;
    const CEP_CODIGOCOBRANCA_Name = 'CEP_CODIGOCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECOCOBRANCA', ftString, 50)]
    [Dictionary('PES_ENDERECOCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECOCOBRANCA: String read FPES_ENDERECOCOBRANCA write FPES_ENDERECOCOBRANCA;
    const PES_ENDERECOCOBRANCA_Name = 'PES_ENDERECOCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRROCOBRANCA', ftString, 30)]
    [Dictionary('PES_BAIRROCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRROCOBRANCA: String read FPES_BAIRROCOBRANCA write FPES_BAIRROCOBRANCA;
    const PES_BAIRROCOBRANCA_Name = 'PES_BAIRROCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('PES_CAIXAPOSTALCOBRANCA', ftString, 5)]
    [Dictionary('PES_CAIXAPOSTALCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CAIXAPOSTALCOBRANCA: String read FPES_CAIXAPOSTALCOBRANCA write FPES_CAIXAPOSTALCOBRANCA;
    const PES_CAIXAPOSTALCOBRANCA_Name = 'PES_CAIXAPOSTALCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECOCOBRANCA', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECOCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECOCOBRANCA: String read FPES_NUMEROENDERECOCOBRANCA write FPES_NUMEROENDERECOCOBRANCA;
    const PES_NUMEROENDERECOCOBRANCA_Name = 'PES_NUMEROENDERECOCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('PES_HISTORICOSPC', ftBlob)]
    [Dictionary('PES_HISTORICOSPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_HISTORICOSPC: TBlob read FPES_HISTORICOSPC write FPES_HISTORICOSPC;
    const PES_HISTORICOSPC_Name = 'PES_HISTORICOSPC';

    [Restrictions([NoValidate])]
    [Column('PES_OBSERVACAO', ftString, 300)]
    [Dictionary('PES_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_OBSERVACAO: String read FPES_OBSERVACAO write FPES_OBSERVACAO;
    const PES_OBSERVACAO_Name = 'PES_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PES_ESTADOCIVIL', ftString, 1)]
    [Dictionary('PES_ESTADOCIVIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ESTADOCIVIL: String read FPES_ESTADOCIVIL write FPES_ESTADOCIVIL;
    const PES_ESTADOCIVIL_Name = 'PES_ESTADOCIVIL';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECONJUGE', ftString, 100)]
    [Dictionary('PES_NOMECONJUGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECONJUGE: String read FPES_NOMECONJUGE write FPES_NOMECONJUGE;
    const PES_NOMECONJUGE_Name = 'PES_NOMECONJUGE';

    [Restrictions([NoValidate])]
    [Column('PES_ORDEMENTREGA', ftString, 6)]
    [Dictionary('PES_ORDEMENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ORDEMENTREGA: String read FPES_ORDEMENTREGA write FPES_ORDEMENTREGA;
    const PES_ORDEMENTREGA_Name = 'PES_ORDEMENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_DATANASCIMENTO', ftDateTime)]
    [Dictionary('PES_DATANASCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATANASCIMENTO: TDateTime read FPES_DATANASCIMENTO write FPES_DATANASCIMENTO;
    const PES_DATANASCIMENTO_Name = 'PES_DATANASCIMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_IDADE', ftBCD)]
    [Dictionary('PES_IDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_IDADE: Double read FPES_IDADE write FPES_IDADE;
    const PES_IDADE_Name = 'PES_IDADE';

    [Restrictions([NoValidate])]
    [Column('PES_FUNCAO', ftString, 100)]
    [Dictionary('PES_FUNCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FUNCAO: String read FPES_FUNCAO write FPES_FUNCAO;
    const PES_FUNCAO_Name = 'PES_FUNCAO';

    [Restrictions([NoValidate])]
    [Column('PES_DATAADMISSAO', ftDateTime)]
    [Dictionary('PES_DATAADMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAADMISSAO: TDateTime read FPES_DATAADMISSAO write FPES_DATAADMISSAO;
    const PES_DATAADMISSAO_Name = 'PES_DATAADMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_TAMANHOUNIFORME', ftString, 10)]
    [Dictionary('PES_TAMANHOUNIFORME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TAMANHOUNIFORME: String read FPES_TAMANHOUNIFORME write FPES_TAMANHOUNIFORME;
    const PES_TAMANHOUNIFORME_Name = 'PES_TAMANHOUNIFORME';

    [Restrictions([NoValidate])]
    [Column('PES_DATAENTREGAUNIFORME', ftDateTime)]
    [Dictionary('PES_DATAENTREGAUNIFORME', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAENTREGAUNIFORME: TDateTime read FPES_DATAENTREGAUNIFORME write FPES_DATAENTREGAUNIFORME;
    const PES_DATAENTREGAUNIFORME_Name = 'PES_DATAENTREGAUNIFORME';

    [Restrictions([NoValidate])]
    [Column('PES_ULTIMOEXAME', ftString, 1)]
    [Dictionary('PES_ULTIMOEXAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ULTIMOEXAME: String read FPES_ULTIMOEXAME write FPES_ULTIMOEXAME;
    const PES_ULTIMOEXAME_Name = 'PES_ULTIMOEXAME';

    [Restrictions([NoValidate])]
    [Column('PES_DATAULTIMOEXAME', ftDateTime)]
    [Dictionary('PES_DATAULTIMOEXAME', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAULTIMOEXAME: TDateTime read FPES_DATAULTIMOEXAME write FPES_DATAULTIMOEXAME;
    const PES_DATAULTIMOEXAME_Name = 'PES_DATAULTIMOEXAME';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATAALTERACAO', ftDateTime)]
    [Dictionary('PES_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATAALTERACAO: TDateTime read FPES_DATAALTERACAO write FPES_DATAALTERACAO;
    const PES_DATAALTERACAO_Name = 'PES_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SEG_CODIGO', ftInteger)]
    [Dictionary('SEG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SEG_CODIGO: Integer read FSEG_CODIGO write FSEG_CODIGO;
    const SEG_CODIGO_Name = 'SEG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SEG_DESCRICAO', ftString, 30)]
    [Dictionary('SEG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SEG_DESCRICAO: String read FSEG_DESCRICAO write FSEG_DESCRICAO;
    const SEG_DESCRICAO_Name = 'SEG_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_PES)

end.
