unit express.dbo.EXP_TRC_CONTABIL;

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
  [Table('EXP_TRC_Contabil', '')]
  TDtoEXP_TRC_Contabil = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FTRC_DATA: TDateTime;
    FPES_TIPOPESSOA: String;
    FPES_NOME: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_2: String;
    FPES_EMAIL: String;
    FPES_HTTP: String;
    FPES_IE_MUNICIPAL: String;
    FPES_CODIGOPAIS: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_DATANASCIMENTO: TDateTime;
    FPES_CI_ORGAOEMISSOR: String;
    FPES_SEXO: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_TRC_Contabil';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_DATA', ftDateTime)]
    [Dictionary('TRC_DATA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TRC_DATA: TDateTime read FTRC_DATA write FTRC_DATA;
    const TRC_DATA_Name = 'TRC_DATA';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
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
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_2', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_2: String read FPES_DDD_CELULAR_2 write FPES_DDD_CELULAR_2;
    const PES_DDD_CELULAR_2_Name = 'PES_DDD_CELULAR_2';

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

    [Restrictions([NoValidate])]
    [Column('PES_IE_MUNICIPAL', ftString, 16)]
    [Dictionary('PES_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_MUNICIPAL: String read FPES_IE_MUNICIPAL write FPES_IE_MUNICIPAL;
    const PES_IE_MUNICIPAL_Name = 'PES_IE_MUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS: String read FPES_CODIGOPAIS write FPES_CODIGOPAIS;
    const PES_CODIGOPAIS_Name = 'PES_CODIGOPAIS';

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
    [Column('PES_CI_ORGAOEMISSOR', ftString, 30)]
    [Dictionary('PES_CI_ORGAOEMISSOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CI_ORGAOEMISSOR: String read FPES_CI_ORGAOEMISSOR write FPES_CI_ORGAOEMISSOR;
    const PES_CI_ORGAOEMISSOR_Name = 'PES_CI_ORGAOEMISSOR';

    [Restrictions([NoValidate])]
    [Column('PES_SEXO', ftString, 1)]
    [Dictionary('PES_SEXO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_SEXO: String read FPES_SEXO write FPES_SEXO;
    const PES_SEXO_Name = 'PES_SEXO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_TRC_Contabil)

end.
