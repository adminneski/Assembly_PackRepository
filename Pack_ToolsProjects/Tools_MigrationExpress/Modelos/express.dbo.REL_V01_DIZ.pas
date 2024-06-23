unit express.dbo.REL_V01_DIZ;

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
  [Table('REL_V01_DIZ', '')]
  TDtoREL_V01_DIZ = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_DATACADASTRO: TDateTime;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_CAIXAPOSTAL: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_TELEFONE_2: String;
    FPES_DDD_TELEFONE_3: String;
    FPES_DDD_CELULAR_1: String;
    FCEP_CODIGO: String;
    FCID_IBGE: String;
    FTAB_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_TIPOPESSOA: String;
    FPES_DESATIVADO: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_DATANASCIMENTO: TDateTime;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_EMAIL: String;
    FPES_OBSERVACAO: String;
    FPES_ESTADOCIVIL: String;
    FPES_NOMECONJUGE: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_DIZ';

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
    [Column('PES_DATANASCIMENTO', ftDateTime)]
    [Dictionary('PES_DATANASCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATANASCIMENTO: TDateTime read FPES_DATANASCIMENTO write FPES_DATANASCIMENTO;
    const PES_DATANASCIMENTO_Name = 'PES_DATANASCIMENTO';

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
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

    [Restrictions([NoValidate])]
    [Column('PES_OBSERVACAO', ftString, 300)]
    [Dictionary('PES_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_OBSERVACAO: String read FPES_OBSERVACAO write FPES_OBSERVACAO;
    const PES_OBSERVACAO_Name = 'PES_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_ESTADOCIVIL', ftString, 8)]
    [Dictionary('PES_ESTADOCIVIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ESTADOCIVIL: String read FPES_ESTADOCIVIL write FPES_ESTADOCIVIL;
    const PES_ESTADOCIVIL_Name = 'PES_ESTADOCIVIL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOMECONJUGE', ftString, 100)]
    [Dictionary('PES_NOMECONJUGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECONJUGE: String read FPES_NOMECONJUGE write FPES_NOMECONJUGE;
    const PES_NOMECONJUGE_Name = 'PES_NOMECONJUGE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_DIZ)

end.
