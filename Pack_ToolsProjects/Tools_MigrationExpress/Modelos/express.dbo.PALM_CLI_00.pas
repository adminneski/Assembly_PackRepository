unit express.dbo.PALM_CLI_00;

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
  [Table('PALM_CLI_00', '')]
  [PrimaryKey('CLI_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CLI_CODIGO')]
  TDtoPALM_CLI_00 = class
  private
    { Private declarations } 
    FCLI_CODIGO: Integer;
    FCLI_NOME: String;
    FCLI_FANTASIA_OU_APELIDO: String;
    FCLI_ENDERECO: String;
    FCLI_NUMEROENDERECO: String;
    FCLI_BAIRRO: String;
    FCID_IBGE: String;
    FCEP_CODIGO: String;
    FCLI_OBSERVACAO: String;
    FCLI_DDD_TELEFONE_1: String;
    FCLI_COMPLEMENTO_1: String;
    FCLI_DDD_TELEFONE_2: String;
    FCLI_COMPLEMENTO_2: String;
    FCLI_DDD_FAX: String;
    FCLI_EMAIL: String;
    FCLI_HTTP: String;
    FCLI_CONTATO: String;
    FCLI_TIPOCLIENTE: String;
    FCLI_TIPOPESSOA: String;
    FCLI_CNPJ_CPF: String;
    FCLI_IE: String;
    FCLI_IE_MUNICIPAL: String;
    FCLI_IE_RURAL: String;
    FCLI_DDD_REFERENCIAS_TELEFONE_1: String;
    FCLI_REFERENCIAS_1: String;
    FCLI_DDD_REFERENCIAS_TELEFONE_2: String;
    FCLI_REFERENCIAS_2: String;
    FCLI_CODIGORCA: Integer;
    FCLI_DATACADASTRO: TDateTime;
    FCLI_IMPORTADO: String;
    FCLI_CODIGOPRECADASTRO: Integer;
    FCLI_EXPORTADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PALM_CLI_00';
     const PrimaryKey = 'CLI_CODIGO';
     const Sequence   = 'SEQ_CLI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLI_CODIGO', ftInteger)]
    [Dictionary('CLI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLI_CODIGO: Integer read FCLI_CODIGO write FCLI_CODIGO;
    const CLI_CODIGO_Name = 'CLI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLI_NOME', ftString, 50)]
    [Dictionary('CLI_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_NOME: String read FCLI_NOME write FCLI_NOME;
    const CLI_NOME_Name = 'CLI_NOME';

    [Restrictions([NoValidate])]
    [Column('CLI_FANTASIA_OU_APELIDO', ftString, 50)]
    [Dictionary('CLI_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_FANTASIA_OU_APELIDO: String read FCLI_FANTASIA_OU_APELIDO write FCLI_FANTASIA_OU_APELIDO;
    const CLI_FANTASIA_OU_APELIDO_Name = 'CLI_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate])]
    [Column('CLI_ENDERECO', ftString, 50)]
    [Dictionary('CLI_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_ENDERECO: String read FCLI_ENDERECO write FCLI_ENDERECO;
    const CLI_ENDERECO_Name = 'CLI_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('CLI_NUMEROENDERECO', ftString, 5)]
    [Dictionary('CLI_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_NUMEROENDERECO: String read FCLI_NUMEROENDERECO write FCLI_NUMEROENDERECO;
    const CLI_NUMEROENDERECO_Name = 'CLI_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('CLI_BAIRRO', ftString, 30)]
    [Dictionary('CLI_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_BAIRRO: String read FCLI_BAIRRO write FCLI_BAIRRO;
    const CLI_BAIRRO_Name = 'CLI_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 15)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLI_OBSERVACAO', ftString, 300)]
    [Dictionary('CLI_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_OBSERVACAO: String read FCLI_OBSERVACAO write FCLI_OBSERVACAO;
    const CLI_OBSERVACAO_Name = 'CLI_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CLI_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('CLI_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_DDD_TELEFONE_1: String read FCLI_DDD_TELEFONE_1 write FCLI_DDD_TELEFONE_1;
    const CLI_DDD_TELEFONE_1_Name = 'CLI_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('CLI_COMPLEMENTO_1', ftString, 50)]
    [Dictionary('CLI_COMPLEMENTO_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_COMPLEMENTO_1: String read FCLI_COMPLEMENTO_1 write FCLI_COMPLEMENTO_1;
    const CLI_COMPLEMENTO_1_Name = 'CLI_COMPLEMENTO_1';

    [Restrictions([NoValidate])]
    [Column('CLI_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('CLI_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_DDD_TELEFONE_2: String read FCLI_DDD_TELEFONE_2 write FCLI_DDD_TELEFONE_2;
    const CLI_DDD_TELEFONE_2_Name = 'CLI_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('CLI_COMPLEMENTO_2', ftString, 50)]
    [Dictionary('CLI_COMPLEMENTO_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_COMPLEMENTO_2: String read FCLI_COMPLEMENTO_2 write FCLI_COMPLEMENTO_2;
    const CLI_COMPLEMENTO_2_Name = 'CLI_COMPLEMENTO_2';

    [Restrictions([NoValidate])]
    [Column('CLI_DDD_FAX', ftString, 11)]
    [Dictionary('CLI_DDD_FAX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_DDD_FAX: String read FCLI_DDD_FAX write FCLI_DDD_FAX;
    const CLI_DDD_FAX_Name = 'CLI_DDD_FAX';

    [Restrictions([NoValidate])]
    [Column('CLI_EMAIL', ftString, 50)]
    [Dictionary('CLI_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_EMAIL: String read FCLI_EMAIL write FCLI_EMAIL;
    const CLI_EMAIL_Name = 'CLI_EMAIL';

    [Restrictions([NoValidate])]
    [Column('CLI_HTTP', ftString, 50)]
    [Dictionary('CLI_HTTP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_HTTP: String read FCLI_HTTP write FCLI_HTTP;
    const CLI_HTTP_Name = 'CLI_HTTP';

    [Restrictions([NoValidate])]
    [Column('CLI_CONTATO', ftString, 50)]
    [Dictionary('CLI_CONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_CONTATO: String read FCLI_CONTATO write FCLI_CONTATO;
    const CLI_CONTATO_Name = 'CLI_CONTATO';

    [Restrictions([NoValidate])]
    [Column('CLI_TIPOCLIENTE', ftString, 4)]
    [Dictionary('CLI_TIPOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_TIPOCLIENTE: String read FCLI_TIPOCLIENTE write FCLI_TIPOCLIENTE;
    const CLI_TIPOCLIENTE_Name = 'CLI_TIPOCLIENTE';

    [Restrictions([NoValidate])]
    [Column('CLI_TIPOPESSOA', ftString, 1)]
    [Dictionary('CLI_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_TIPOPESSOA: String read FCLI_TIPOPESSOA write FCLI_TIPOPESSOA;
    const CLI_TIPOPESSOA_Name = 'CLI_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('CLI_CNPJ_CPF', ftString, 14)]
    [Dictionary('CLI_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_CNPJ_CPF: String read FCLI_CNPJ_CPF write FCLI_CNPJ_CPF;
    const CLI_CNPJ_CPF_Name = 'CLI_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('CLI_IE', ftString, 16)]
    [Dictionary('CLI_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_IE: String read FCLI_IE write FCLI_IE;
    const CLI_IE_Name = 'CLI_IE';

    [Restrictions([NoValidate])]
    [Column('CLI_IE_MUNICIPAL', ftString, 16)]
    [Dictionary('CLI_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_IE_MUNICIPAL: String read FCLI_IE_MUNICIPAL write FCLI_IE_MUNICIPAL;
    const CLI_IE_MUNICIPAL_Name = 'CLI_IE_MUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('CLI_IE_RURAL', ftString, 16)]
    [Dictionary('CLI_IE_RURAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_IE_RURAL: String read FCLI_IE_RURAL write FCLI_IE_RURAL;
    const CLI_IE_RURAL_Name = 'CLI_IE_RURAL';

    [Restrictions([NoValidate])]
    [Column('CLI_DDD_REFERENCIAS_TELEFONE_1', ftString, 11)]
    [Dictionary('CLI_DDD_REFERENCIAS_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_DDD_REFERENCIAS_TELEFONE_1: String read FCLI_DDD_REFERENCIAS_TELEFONE_1 write FCLI_DDD_REFERENCIAS_TELEFONE_1;
    const CLI_DDD_REFERENCIAS_TELEFONE_1_Name = 'CLI_DDD_REFERENCIAS_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('CLI_REFERENCIAS_1', ftString, 50)]
    [Dictionary('CLI_REFERENCIAS_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_REFERENCIAS_1: String read FCLI_REFERENCIAS_1 write FCLI_REFERENCIAS_1;
    const CLI_REFERENCIAS_1_Name = 'CLI_REFERENCIAS_1';

    [Restrictions([NoValidate])]
    [Column('CLI_DDD_REFERENCIAS_TELEFONE_2', ftString, 11)]
    [Dictionary('CLI_DDD_REFERENCIAS_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_DDD_REFERENCIAS_TELEFONE_2: String read FCLI_DDD_REFERENCIAS_TELEFONE_2 write FCLI_DDD_REFERENCIAS_TELEFONE_2;
    const CLI_DDD_REFERENCIAS_TELEFONE_2_Name = 'CLI_DDD_REFERENCIAS_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('CLI_REFERENCIAS_2', ftString, 50)]
    [Dictionary('CLI_REFERENCIAS_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_REFERENCIAS_2: String read FCLI_REFERENCIAS_2 write FCLI_REFERENCIAS_2;
    const CLI_REFERENCIAS_2_Name = 'CLI_REFERENCIAS_2';

    [Restrictions([NoValidate])]
    [Column('CLI_CODIGORCA', ftInteger)]
    [Dictionary('CLI_CODIGORCA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLI_CODIGORCA: Integer read FCLI_CODIGORCA write FCLI_CODIGORCA;
    const CLI_CODIGORCA_Name = 'CLI_CODIGORCA';

    [Restrictions([NoValidate])]
    [Column('CLI_DATACADASTRO', ftDateTime)]
    [Dictionary('CLI_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property CLI_DATACADASTRO: TDateTime read FCLI_DATACADASTRO write FCLI_DATACADASTRO;
    const CLI_DATACADASTRO_Name = 'CLI_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('CLI_IMPORTADO', ftString, 1)]
    [Dictionary('CLI_IMPORTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_IMPORTADO: String read FCLI_IMPORTADO write FCLI_IMPORTADO;
    const CLI_IMPORTADO_Name = 'CLI_IMPORTADO';

    [Restrictions([NoValidate])]
    [Column('CLI_CODIGOPRECADASTRO', ftInteger)]
    [Dictionary('CLI_CODIGOPRECADASTRO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLI_CODIGOPRECADASTRO: Integer read FCLI_CODIGOPRECADASTRO write FCLI_CODIGOPRECADASTRO;
    const CLI_CODIGOPRECADASTRO_Name = 'CLI_CODIGOPRECADASTRO';

    [Restrictions([NoValidate])]
    [Column('CLI_EXPORTADO', ftString, 1)]
    [Dictionary('CLI_EXPORTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_EXPORTADO: String read FCLI_EXPORTADO write FCLI_EXPORTADO;
    const CLI_EXPORTADO_Name = 'CLI_EXPORTADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_CLI_00)

end.
