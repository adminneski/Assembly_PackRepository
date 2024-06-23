unit Dto.COMPANY;

interface

uses
  System.SysUtils, 
  System.Classes, 
  Vcl.Graphics, 
  Data.DB, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.consts,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes,
  //Application 
  Core.Mapping.Attributes;

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
    FCOM_COMPLEMENTORAZAO: String;
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
    FCOM_VERSION_NUMBER: Integer;
    FCOM_VERSION_APPNAME: String;
    FGRC_CODIGO: Integer;
    FCOM_CAIXAPOSTAL: String;
  public 
    { Public declarations } 
    const Table      = 'COMPANY';
    const PrimaryKey = 'COM_CODIGO';
    const Sequence   = 'SEQ_COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [ColumnDBGrid('COM_CODIGO', 'COM_CODIGO', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('COM_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NoValidate])]
    [Column('COM_TIPOPESSOA', ftString, 1)]
    [ColumnDBGrid('COM_TIPOPESSOA', 'COM_TIPOPESSOA', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_TIPOPESSOA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_TIPOPESSOA: String read FCOM_TIPOPESSOA write FCOM_TIPOPESSOA;

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [ColumnDBGrid('COM_CNPJ_CPF', 'COM_CNPJ_CPF', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_CNPJ_CPF', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;

    [Restrictions([NoValidate])]
    [Column('COM_IE_RG', ftString, 16)]
    [ColumnDBGrid('COM_IE_RG', 'COM_IE_RG', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_IE_RG', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_IE_RG: String read FCOM_IE_RG write FCOM_IE_RG;

    [Restrictions([NoValidate])]
    [Column('COM_RAZAO', ftString, 100)]
    [ColumnDBGrid('COM_RAZAO', 'COM_RAZAO', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_RAZAO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;

    [Restrictions([NoValidate])]
    [Column('COM_COMPLEMENTORAZAO', ftString, 20)]
    [ColumnDBGrid('COM_COMPLEMENTORAZAO', 'COM_COMPLEMENTORAZAO', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_COMPLEMENTORAZAO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_COMPLEMENTORAZAO: String read FCOM_COMPLEMENTORAZAO write FCOM_COMPLEMENTORAZAO;

    [Restrictions([NoValidate])]
    [Column('COM_FANTASIA', ftString, 100)]
    [ColumnDBGrid('COM_FANTASIA', 'COM_FANTASIA', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_FANTASIA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_FANTASIA: String read FCOM_FANTASIA write FCOM_FANTASIA;

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [ColumnDBGrid('CEP_CODIGO', 'CEP_CODIGO', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('CEP_CODIGO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;

    [Restrictions([NoValidate])]
    [Column('COM_ENDERECO', ftString, 100)]
    [ColumnDBGrid('COM_ENDERECO', 'COM_ENDERECO', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_ENDERECO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_ENDERECO: String read FCOM_ENDERECO write FCOM_ENDERECO;

    [Restrictions([NoValidate])]
    [Column('COM_NUMEROENDERECO', ftString, 5)]
    [ColumnDBGrid('COM_NUMEROENDERECO', 'COM_NUMEROENDERECO', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_NUMEROENDERECO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_NUMEROENDERECO: String read FCOM_NUMEROENDERECO write FCOM_NUMEROENDERECO;

    [Restrictions([NoValidate])]
    [Column('COM_BAIRRO', ftString, 50)]
    [ColumnDBGrid('COM_BAIRRO', 'COM_BAIRRO', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_BAIRRO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_BAIRRO: String read FCOM_BAIRRO write FCOM_BAIRRO;

    [Restrictions([NoValidate])]
    [Column('COM_PONTOREFERENCIA', ftString, 100)]
    [ColumnDBGrid('COM_PONTOREFERENCIA', 'COM_PONTOREFERENCIA', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_PONTOREFERENCIA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_PONTOREFERENCIA: String read FCOM_PONTOREFERENCIA write FCOM_PONTOREFERENCIA;

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftInteger)]
    [ColumnDBGrid('CID_IBGE', 'CID_IBGE', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('CID_IBGE', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property CID_IBGE: Integer read FCID_IBGE write FCID_IBGE;

    [Restrictions([NoValidate])]
    [Column('COM_CIDADE', ftString, 100)]
    [ColumnDBGrid('COM_CIDADE', 'COM_CIDADE', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_CIDADE', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_CIDADE: String read FCOM_CIDADE write FCOM_CIDADE;

    [Restrictions([NoValidate])]
    [Column('COM_UF', ftString, 2)]
    [ColumnDBGrid('COM_UF', 'COM_UF', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_UF', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_1', ftString, 11)]
    [ColumnDBGrid('COM_DDD_TELEFONE_1', 'COM_DDD_TELEFONE_1', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_DDD_TELEFONE_1', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_1: String read FCOM_DDD_TELEFONE_1 write FCOM_DDD_TELEFONE_1;

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_2', ftString, 11)]
    [ColumnDBGrid('COM_DDD_TELEFONE_2', 'COM_DDD_TELEFONE_2', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_DDD_TELEFONE_2', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_2: String read FCOM_DDD_TELEFONE_2 write FCOM_DDD_TELEFONE_2;

    [Restrictions([NoValidate])]
    [Column('COM_DDD_CELULAR_1', ftString, 11)]
    [ColumnDBGrid('COM_DDD_CELULAR_1', 'COM_DDD_CELULAR_1', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_DDD_CELULAR_1', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_DDD_CELULAR_1: String read FCOM_DDD_CELULAR_1 write FCOM_DDD_CELULAR_1;

    [Restrictions([NoValidate])]
    [Column('COM_DDD_CELULAR_2', ftString, 11)]
    [ColumnDBGrid('COM_DDD_CELULAR_2', 'COM_DDD_CELULAR_2', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_DDD_CELULAR_2', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_DDD_CELULAR_2: String read FCOM_DDD_CELULAR_2 write FCOM_DDD_CELULAR_2;

    [Restrictions([NoValidate])]
    [Column('COM_EMAIL', ftString, 50)]
    [ColumnDBGrid('COM_EMAIL', 'COM_EMAIL', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_EMAIL', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_EMAIL: String read FCOM_EMAIL write FCOM_EMAIL;

    [Restrictions([NoValidate])]
    [Column('COM_HTTP', ftString, 50)]
    [ColumnDBGrid('COM_HTTP', 'COM_HTTP', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_HTTP', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_HTTP: String read FCOM_HTTP write FCOM_HTTP;

    [Restrictions([NoValidate])]
    [Column('COM_OBSERVACAO', ftString, 500)]
    [ColumnDBGrid('COM_OBSERVACAO', 'COM_OBSERVACAO', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_OBSERVACAO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_OBSERVACAO: String read FCOM_OBSERVACAO write FCOM_OBSERVACAO;

    [Restrictions([NoValidate])]
    [Column('COM_IE_MUNICIPAL', ftString, 30)]
    [ColumnDBGrid('COM_IE_MUNICIPAL', 'COM_IE_MUNICIPAL', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_IE_MUNICIPAL', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_IE_MUNICIPAL: String read FCOM_IE_MUNICIPAL write FCOM_IE_MUNICIPAL;

    [Restrictions([NoValidate])]
    [Column('COM_STATUS', ftString, 1)]
    [ColumnDBGrid('COM_STATUS', 'COM_STATUS', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_STATUS', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_STATUS: String read FCOM_STATUS write FCOM_STATUS;

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [ColumnDBGrid('CFG_CODIGO', 'CFG_CODIGO', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('CFG_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;

    [Restrictions([NoValidate])]
    [Column('COA_CODIGO', ftInteger)]
    [ColumnDBGrid('COA_CODIGO', 'COA_CODIGO', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('COA_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property COA_CODIGO: Integer read FCOA_CODIGO write FCOA_CODIGO;

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_DATACADASTRO', ftDateTime)]
    [ColumnDBGrid('COM_DATACADASTRO', 'COM_DATACADASTRO', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('COM_DATACADASTRO', 'Divergente do valor esperado.', 'Date', '', '!##/##/####;1;_', taCenter)]
    property COM_DATACADASTRO: TDateTime read FCOM_DATACADASTRO write FCOM_DATACADASTRO;

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_DATAHORAALTERACAO', ftDateTime)]
    [ColumnDBGrid('COM_DATAHORAALTERACAO', 'COM_DATAHORAALTERACAO', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('COM_DATAHORAALTERACAO', 'Divergente do valor esperado.', 'Now', '', '!##/##/####;1;_', taCenter)]
    property COM_DATAHORAALTERACAO: TDateTime read FCOM_DATAHORAALTERACAO write FCOM_DATAHORAALTERACAO;

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO_PROPRIETARIO', ftInteger)]
    [ColumnDBGrid('ACC_CODIGO_PROPRIETARIO', 'ACC_CODIGO_PROPRIETARIO', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('ACC_CODIGO_PROPRIETARIO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property ACC_CODIGO_PROPRIETARIO: Integer read FACC_CODIGO_PROPRIETARIO write FACC_CODIGO_PROPRIETARIO;

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO_INTEGRACAO_GESTOR', ftInteger)]
    [ColumnDBGrid('PES_CODIGO_INTEGRACAO_GESTOR', 'PES_CODIGO_INTEGRACAO_GESTOR', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('PES_CODIGO_INTEGRACAO_GESTOR', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PES_CODIGO_INTEGRACAO_GESTOR: Integer read FPES_CODIGO_INTEGRACAO_GESTOR write FPES_CODIGO_INTEGRACAO_GESTOR;

    [Restrictions([NoValidate])]
    [Column('COM_VERSION_NUMBER', ftInteger)]
    [ColumnDBGrid('COM_VERSION_NUMBER', 'COM_VERSION_NUMBER', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('COM_VERSION_NUMBER', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property COM_VERSION_NUMBER: Integer read FCOM_VERSION_NUMBER write FCOM_VERSION_NUMBER;

    [Restrictions([NoValidate])]
    [Column('COM_VERSION_APPNAME', ftString, 100)]
    [ColumnDBGrid('COM_VERSION_APPNAME', 'COM_VERSION_APPNAME', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_VERSION_APPNAME', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_VERSION_APPNAME: String read FCOM_VERSION_APPNAME write FCOM_VERSION_APPNAME;

    [Restrictions([NoValidate, NotNull])]
    [Column('GRC_CODIGO', ftInteger)]
    [ColumnDBGrid('GRC_CODIGO', 'GRC_CODIGO', 100, 'Arial', 12, clWindowText, False, taCenter)]
    [Dictionary('GRC_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property GRC_CODIGO: Integer read FGRC_CODIGO write FGRC_CODIGO;

    [Restrictions([NoValidate])]
    [Column('COM_CAIXAPOSTAL', ftString, 30)]
    [ColumnDBGrid('COM_CAIXAPOSTAL', 'COM_CAIXAPOSTAL', 100, 'Arial', 12, clWindowText, False, taLeftJustify)]
    [Dictionary('COM_CAIXAPOSTAL', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property COM_CAIXAPOSTAL: String read FCOM_CAIXAPOSTAL write FCOM_CAIXAPOSTAL;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCOMPANY)

end.
