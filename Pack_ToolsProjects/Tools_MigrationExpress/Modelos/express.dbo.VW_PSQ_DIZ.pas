unit express.dbo.VW_PSQ_DIZ;

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
  [Table('VW_PSQ_DIZ', '')]
  TDtoVW_PSQ_DIZ = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_TIPOPESSOA: String;
    FPES_NOME: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FCEP_CODIGO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_TELEFONE_2: String;
    FPES_DDD_TELEFONE_3: String;
    FPES_DDD_CELULAR_1: String;
    FPES_DDD_CELULAR_2: String;
    FPES_CAIXAPOSTAL: String;
    FPES_EMAIL: String;
    FPES_HTTP: String;
    FPES_DESATIVADO: String;
    FPES_OBSERVACAO: String;
    FPES_DATACADASTRO: TDateTime;
    FPES_DATAALTERACAO: TDateTime;
    FPES_IE_MUNICIPAL: String;
    FPES_NUMEROCRC: String;
    FPES_BLOQUEADO: String;
    FPES_RNTRC: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_CI_ORGAOEMISSOR: String;
    FPES_CTPS: String;
    FPES_DATANASCIMENTO: TDateTime;
    FPES_ESTADOCIVIL: String;
    FPES_SEXO: String;
    FPES_NACIONALIDADE: String;
    FPES_NATURALIDADE: String;
    FPES_CIDADE: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_DIZ';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO: String read FPES_FANTASIA_OU_APELIDO write FPES_FANTASIA_OU_APELIDO;
    const PES_FANTASIA_OU_APELIDO_Name = 'PES_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

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

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_2', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_2: String read FPES_DDD_CELULAR_2 write FPES_DDD_CELULAR_2;
    const PES_DDD_CELULAR_2_Name = 'PES_DDD_CELULAR_2';

    [Restrictions([NoValidate])]
    [Column('PES_CAIXAPOSTAL', ftString, 5)]
    [Dictionary('PES_CAIXAPOSTAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CAIXAPOSTAL: String read FPES_CAIXAPOSTAL write FPES_CAIXAPOSTAL;
    const PES_CAIXAPOSTAL_Name = 'PES_CAIXAPOSTAL';

    [Restrictions([NoValidate])]
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

    [Restrictions([NoValidate])]
    [Column('PES_HTTP', ftString, 50)]
    [Dictionary('PES_HTTP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_HTTP: String read FPES_HTTP write FPES_HTTP;
    const PES_HTTP_Name = 'PES_HTTP';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DESATIVADO', ftString, 1)]
    [Dictionary('PES_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DESATIVADO: String read FPES_DESATIVADO write FPES_DESATIVADO;
    const PES_DESATIVADO_Name = 'PES_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PES_OBSERVACAO', ftString, 300)]
    [Dictionary('PES_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_OBSERVACAO: String read FPES_OBSERVACAO write FPES_OBSERVACAO;
    const PES_OBSERVACAO_Name = 'PES_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATACADASTRO', ftDateTime)]
    [Dictionary('PES_DATACADASTRO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATACADASTRO: TDateTime read FPES_DATACADASTRO write FPES_DATACADASTRO;
    const PES_DATACADASTRO_Name = 'PES_DATACADASTRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATAALTERACAO', ftDateTime)]
    [Dictionary('PES_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATAALTERACAO: TDateTime read FPES_DATAALTERACAO write FPES_DATAALTERACAO;
    const PES_DATAALTERACAO_Name = 'PES_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_MUNICIPAL', ftString, 16)]
    [Dictionary('PES_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_MUNICIPAL: String read FPES_IE_MUNICIPAL write FPES_IE_MUNICIPAL;
    const PES_IE_MUNICIPAL_Name = 'PES_IE_MUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROCRC', ftString, 20)]
    [Dictionary('PES_NUMEROCRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROCRC: String read FPES_NUMEROCRC write FPES_NUMEROCRC;
    const PES_NUMEROCRC_Name = 'PES_NUMEROCRC';

    [Restrictions([NoValidate])]
    [Column('PES_BLOQUEADO', ftString, 1)]
    [Dictionary('PES_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BLOQUEADO: String read FPES_BLOQUEADO write FPES_BLOQUEADO;
    const PES_BLOQUEADO_Name = 'PES_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('PES_RNTRC', ftString, 14)]
    [Dictionary('PES_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_RNTRC: String read FPES_RNTRC write FPES_RNTRC;
    const PES_RNTRC_Name = 'PES_RNTRC';

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
    [Column('PES_CI_ORGAOEMISSOR', ftString, 30)]
    [Dictionary('PES_CI_ORGAOEMISSOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CI_ORGAOEMISSOR: String read FPES_CI_ORGAOEMISSOR write FPES_CI_ORGAOEMISSOR;
    const PES_CI_ORGAOEMISSOR_Name = 'PES_CI_ORGAOEMISSOR';

    [Restrictions([NoValidate])]
    [Column('PES_CTPS', ftString, 30)]
    [Dictionary('PES_CTPS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CTPS: String read FPES_CTPS write FPES_CTPS;
    const PES_CTPS_Name = 'PES_CTPS';

    [Restrictions([NoValidate])]
    [Column('PES_DATANASCIMENTO', ftDateTime)]
    [Dictionary('PES_DATANASCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATANASCIMENTO: TDateTime read FPES_DATANASCIMENTO write FPES_DATANASCIMENTO;
    const PES_DATANASCIMENTO_Name = 'PES_DATANASCIMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_ESTADOCIVIL', ftString, 1)]
    [Dictionary('PES_ESTADOCIVIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ESTADOCIVIL: String read FPES_ESTADOCIVIL write FPES_ESTADOCIVIL;
    const PES_ESTADOCIVIL_Name = 'PES_ESTADOCIVIL';

    [Restrictions([NoValidate])]
    [Column('PES_SEXO', ftString, 1)]
    [Dictionary('PES_SEXO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_SEXO: String read FPES_SEXO write FPES_SEXO;
    const PES_SEXO_Name = 'PES_SEXO';

    [Restrictions([NoValidate])]
    [Column('PES_NACIONALIDADE', ftString, 30)]
    [Dictionary('PES_NACIONALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NACIONALIDADE: String read FPES_NACIONALIDADE write FPES_NACIONALIDADE;
    const PES_NACIONALIDADE_Name = 'PES_NACIONALIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_NATURALIDADE', ftString, 30)]
    [Dictionary('PES_NATURALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NATURALIDADE: String read FPES_NATURALIDADE write FPES_NATURALIDADE;
    const PES_NATURALIDADE_Name = 'PES_NATURALIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_DIZ)

end.
