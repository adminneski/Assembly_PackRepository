unit express.dbo.COMPANY;

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
  [Table('COMPANY', '')]
  [PrimaryKey('COM_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_COM_CODIGO')]
  TDtoCOMPANY = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FCOM_TIPOPESSOA: String;
    FCOM_CNPJ_CPF: String;
    FCOM_IE_RG: String;
    FCOM_RAZAO: String;
    FCOM_FANTASIA: String;
    FCEP_CODIGO: String;
    FCOM_ENDERECO: String;
    FCOM_NUMEROENDERECO: String;
    FCOM_BAIRRO: String;
    FCOM_PONTOREFERENCIA: String;
    FCID_IBGE: Integer;
    FCOM_CIDADE: String;
    FCOM_UF: String;
    FCOM_DDD_TELEFONE_1: String;
    FCOM_DDD_TELEFONE_2: String;
    FCOM_DDD_CELULAR_1: String;
    FCOM_DDD_CELULAR_2: String;
    FCOM_EMAIL: String;
    FCOM_HTTP: String;
    FCOM_OBSERVACAO: String;
    FCOM_IE_MUNICIPAL: String;
    FCOM_STATUS: String;
    FCFG_CODIGO: Integer;
    FCOA_CODIGO: Integer;
    FCOM_DATACADASTRO: TDateTime;
    FCOM_DATAHORAALTERACAO: TDateTime;
    FACC_CODIGO_PROPRIETARIO: Integer;
    FPES_CODIGO_INTEGRACAO_GESTOR: Integer;
    FCOM_CAIXAPOSTAL: String;
    FCOM_COMPLEMENTORAZAO: String;
  public 
    { Public declarations } 
     const Table      = 'COMPANY';
     const PrimaryKey = 'COM_CODIGO';
     const Sequence   = 'SEQ_COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_TIPOPESSOA', ftString, 1)]
    [Dictionary('COM_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_TIPOPESSOA: String read FCOM_TIPOPESSOA write FCOM_TIPOPESSOA;
    const COM_TIPOPESSOA_Name = 'COM_TIPOPESSOA';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('COM_IE_RG', ftString, 16)]
    [Dictionary('COM_IE_RG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE_RG: String read FCOM_IE_RG write FCOM_IE_RG;
    const COM_IE_RG_Name = 'COM_IE_RG';

    [Restrictions([NoValidate])]
    [Column('COM_RAZAO', ftString, 100)]
    [Dictionary('COM_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;
    const COM_RAZAO_Name = 'COM_RAZAO';

    [Restrictions([NoValidate])]
    [Column('COM_FANTASIA', ftString, 100)]
    [Dictionary('COM_FANTASIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_FANTASIA: String read FCOM_FANTASIA write FCOM_FANTASIA;
    const COM_FANTASIA_Name = 'COM_FANTASIA';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_ENDERECO', ftString, 100)]
    [Dictionary('COM_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_ENDERECO: String read FCOM_ENDERECO write FCOM_ENDERECO;
    const COM_ENDERECO_Name = 'COM_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('COM_NUMEROENDERECO', ftString, 5)]
    [Dictionary('COM_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_NUMEROENDERECO: String read FCOM_NUMEROENDERECO write FCOM_NUMEROENDERECO;
    const COM_NUMEROENDERECO_Name = 'COM_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('COM_BAIRRO', ftString, 50)]
    [Dictionary('COM_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_BAIRRO: String read FCOM_BAIRRO write FCOM_BAIRRO;
    const COM_BAIRRO_Name = 'COM_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('COM_PONTOREFERENCIA', ftString, 100)]
    [Dictionary('COM_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_PONTOREFERENCIA: String read FCOM_PONTOREFERENCIA write FCOM_PONTOREFERENCIA;
    const COM_PONTOREFERENCIA_Name = 'COM_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftInteger)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGE: Integer read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('COM_CIDADE', ftString, 100)]
    [Dictionary('COM_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CIDADE: String read FCOM_CIDADE write FCOM_CIDADE;
    const COM_CIDADE_Name = 'COM_CIDADE';

    [Restrictions([NoValidate])]
    [Column('COM_UF', ftString, 2)]
    [Dictionary('COM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;
    const COM_UF_Name = 'COM_UF';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('COM_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_1: String read FCOM_DDD_TELEFONE_1 write FCOM_DDD_TELEFONE_1;
    const COM_DDD_TELEFONE_1_Name = 'COM_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('COM_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_2: String read FCOM_DDD_TELEFONE_2 write FCOM_DDD_TELEFONE_2;
    const COM_DDD_TELEFONE_2_Name = 'COM_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('COM_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_CELULAR_1: String read FCOM_DDD_CELULAR_1 write FCOM_DDD_CELULAR_1;
    const COM_DDD_CELULAR_1_Name = 'COM_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_CELULAR_2', ftString, 11)]
    [Dictionary('COM_DDD_CELULAR_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_CELULAR_2: String read FCOM_DDD_CELULAR_2 write FCOM_DDD_CELULAR_2;
    const COM_DDD_CELULAR_2_Name = 'COM_DDD_CELULAR_2';

    [Restrictions([NoValidate])]
    [Column('COM_EMAIL', ftString, 50)]
    [Dictionary('COM_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_EMAIL: String read FCOM_EMAIL write FCOM_EMAIL;
    const COM_EMAIL_Name = 'COM_EMAIL';

    [Restrictions([NoValidate])]
    [Column('COM_HTTP', ftString, 50)]
    [Dictionary('COM_HTTP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_HTTP: String read FCOM_HTTP write FCOM_HTTP;
    const COM_HTTP_Name = 'COM_HTTP';

    [Restrictions([NoValidate])]
    [Column('COM_OBSERVACAO', ftString, 500)]
    [Dictionary('COM_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_OBSERVACAO: String read FCOM_OBSERVACAO write FCOM_OBSERVACAO;
    const COM_OBSERVACAO_Name = 'COM_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('COM_IE_MUNICIPAL', ftString, 30)]
    [Dictionary('COM_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE_MUNICIPAL: String read FCOM_IE_MUNICIPAL write FCOM_IE_MUNICIPAL;
    const COM_IE_MUNICIPAL_Name = 'COM_IE_MUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('COM_STATUS', ftString, 1)]
    [Dictionary('COM_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_STATUS: String read FCOM_STATUS write FCOM_STATUS;
    const COM_STATUS_Name = 'COM_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COA_CODIGO', ftInteger)]
    [Dictionary('COA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COA_CODIGO: Integer read FCOA_CODIGO write FCOA_CODIGO;
    const COA_CODIGO_Name = 'COA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_DATACADASTRO', ftDateTime)]
    [Dictionary('COM_DATACADASTRO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property COM_DATACADASTRO: TDateTime read FCOM_DATACADASTRO write FCOM_DATACADASTRO;
    const COM_DATACADASTRO_Name = 'COM_DATACADASTRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('COM_DATAHORAALTERACAO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property COM_DATAHORAALTERACAO: TDateTime read FCOM_DATAHORAALTERACAO write FCOM_DATAHORAALTERACAO;
    const COM_DATAHORAALTERACAO_Name = 'COM_DATAHORAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO_PROPRIETARIO', ftInteger)]
    [Dictionary('ACC_CODIGO_PROPRIETARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_PROPRIETARIO: Integer read FACC_CODIGO_PROPRIETARIO write FACC_CODIGO_PROPRIETARIO;
    const ACC_CODIGO_PROPRIETARIO_Name = 'ACC_CODIGO_PROPRIETARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO_INTEGRACAO_GESTOR', ftInteger)]
    [Dictionary('PES_CODIGO_INTEGRACAO_GESTOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO_INTEGRACAO_GESTOR: Integer read FPES_CODIGO_INTEGRACAO_GESTOR write FPES_CODIGO_INTEGRACAO_GESTOR;
    const PES_CODIGO_INTEGRACAO_GESTOR_Name = 'PES_CODIGO_INTEGRACAO_GESTOR';

    [Restrictions([NoValidate])]
    [Column('COM_CAIXAPOSTAL', ftString, 30)]
    [Dictionary('COM_CAIXAPOSTAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CAIXAPOSTAL: String read FCOM_CAIXAPOSTAL write FCOM_CAIXAPOSTAL;
    const COM_CAIXAPOSTAL_Name = 'COM_CAIXAPOSTAL';

    [Restrictions([NoValidate])]
    [Column('COM_COMPLEMENTORAZAO', ftString, 20)]
    [Dictionary('COM_COMPLEMENTORAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_COMPLEMENTORAZAO: String read FCOM_COMPLEMENTORAZAO write FCOM_COMPLEMENTORAZAO;
    const COM_COMPLEMENTORAZAO_Name = 'COM_COMPLEMENTORAZAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCOMPANY)

end.
