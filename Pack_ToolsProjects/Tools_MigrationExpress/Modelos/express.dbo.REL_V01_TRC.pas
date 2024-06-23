unit express.dbo.REL_V01_TRC;

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
  [Table('REL_V01_TRC', '')]
  TDtoREL_V01_TRC = class
  private
    { Private declarations } 
    FTRC_ID: Integer;
    FCOM_CODIGO: Integer;
    FTRC_NUMERODOCTO: String;
    FTRC_TOTALLIQUIDO: Double;
    FTRC_TOTALPRODUTOS: Double;
    FTRC_TOTALDESCTOITEM: Double;
    FTRC_DATALANCAMENTO: TDateTime;
    FTRC_CANCELADA: String;
    FTRC_OBSERVACAO: String;
    FPES_CODIGO: Integer;
    FPES_NOMECLIENTE: String;
    FPES_TIPOPESSOA: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_TELEFONE_1: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_TRC';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_ID', ftInteger)]
    [Dictionary('TRC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_ID: Integer read FTRC_ID write FTRC_ID;
    const TRC_ID_Name = 'TRC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_NUMERODOCTO', ftString, 10)]
    [Dictionary('TRC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_NUMERODOCTO: String read FTRC_NUMERODOCTO write FTRC_NUMERODOCTO;
    const TRC_NUMERODOCTO_Name = 'TRC_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALLIQUIDO', ftBCD)]
    [Dictionary('TRC_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALLIQUIDO: Double read FTRC_TOTALLIQUIDO write FTRC_TOTALLIQUIDO;
    const TRC_TOTALLIQUIDO_Name = 'TRC_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALPRODUTOS', ftBCD)]
    [Dictionary('TRC_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALPRODUTOS: Double read FTRC_TOTALPRODUTOS write FTRC_TOTALPRODUTOS;
    const TRC_TOTALPRODUTOS_Name = 'TRC_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('TRC_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALDESCTOITEM: Double read FTRC_TOTALDESCTOITEM write FTRC_TOTALDESCTOITEM;
    const TRC_TOTALDESCTOITEM_Name = 'TRC_TOTALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('TRC_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TRC_DATALANCAMENTO: TDateTime read FTRC_DATALANCAMENTO write FTRC_DATALANCAMENTO;
    const TRC_DATALANCAMENTO_Name = 'TRC_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_CANCELADA', ftString, 1)]
    [Dictionary('TRC_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_CANCELADA: String read FTRC_CANCELADA write FTRC_CANCELADA;
    const TRC_CANCELADA_Name = 'TRC_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('TRC_OBSERVACAO', ftString, 300)]
    [Dictionary('TRC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_OBSERVACAO: String read FTRC_OBSERVACAO write FTRC_OBSERVACAO;
    const TRC_OBSERVACAO_Name = 'TRC_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTE: String read FPES_NOMECLIENTE write FPES_NOMECLIENTE;
    const PES_NOMECLIENTE_Name = 'PES_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

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
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_DESCRICAO', ftString, 30)]
    [Dictionary('ROT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_DESCRICAO: String read FROT_DESCRICAO write FROT_DESCRICAO;
    const ROT_DESCRICAO_Name = 'ROT_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_TRC)

end.
