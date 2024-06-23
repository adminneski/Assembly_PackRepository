unit express.dbo.REL_V01_LFE;

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
  [Table('REL_V01_LFE', '')]
  TDtoREL_V01_LFE = class
  private
    { Private declarations } 
    FLFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_NOTAFISCAL: String;
    FNTO_CODIGO: Integer;
    FNTO_DESCRICAO: String;
    FLFE_DATAENTRADA: TDateTime;
    FLFE_DATALANCAMENTO: TDateTime;
    FLFE_TOTALNOTAFISCAL: Double;
    FLFE_TOTALPESOLIQUIDO: Double;
    FLFE_TOTALCOMPLEMENTONFICMS: Double;
    FLFE_TOTALDESCTO: Double;
    FLFE_TOTALDESPACESSORIA: Double;
    FLFE_TOTALFRETENF: Double;
    FLFE_TOTALPISCOFINS: Double;
    FLFE_TOTALSEGURO: Double;
    FLFE_TOTALSERVICO: Double;
    FPES_CODIGO: Integer;
    FLFE_CANCELADO: String;
    FLFE_DESATIVADO: String;
    FLFE_INTEGRACAO: String;
    FPES_NOME: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_TIPOPESSOA: String;
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
    FLFE_ESPECIEVOLUMES: String;
    FLFE_MARCAVOLUMES: String;
    FLFE_NUMERACAOVOLUMES: String;
    FLFE_TOTALNUMEROVOLUMES: Integer;
    FLFE_UFVEICULO: String;
    FLFE_PLACAVEICULO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_LFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NOTAFISCAL: String read FLFE_NOTAFISCAL write FLFE_NOTAFISCAL;
    const LFE_NOTAFISCAL_Name = 'LFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAENTRADA', ftDateTime)]
    [Dictionary('LFE_DATAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAENTRADA: TDateTime read FLFE_DATAENTRADA write FLFE_DATAENTRADA;
    const LFE_DATAENTRADA_Name = 'LFE_DATAENTRADA';

    [Restrictions([NoValidate])]
    [Column('LFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('LFE_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFE_DATALANCAMENTO: TDateTime read FLFE_DATALANCAMENTO write FLFE_DATALANCAMENTO;
    const LFE_DATALANCAMENTO_Name = 'LFE_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALNOTAFISCAL: Double read FLFE_TOTALNOTAFISCAL write FLFE_TOTALNOTAFISCAL;
    const LFE_TOTALNOTAFISCAL_Name = 'LFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('LFE_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPESOLIQUIDO: Double read FLFE_TOTALPESOLIQUIDO write FLFE_TOTALPESOLIQUIDO;
    const LFE_TOTALPESOLIQUIDO_Name = 'LFE_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('LFE_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALCOMPLEMENTONFICMS: Double read FLFE_TOTALCOMPLEMENTONFICMS write FLFE_TOTALCOMPLEMENTONFICMS;
    const LFE_TOTALCOMPLEMENTONFICMS_Name = 'LFE_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALDESCTO', ftBCD)]
    [Dictionary('LFE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESCTO: Double read FLFE_TOTALDESCTO write FLFE_TOTALDESCTO;
    const LFE_TOTALDESCTO_Name = 'LFE_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('LFE_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESPACESSORIA: Double read FLFE_TOTALDESPACESSORIA write FLFE_TOTALDESPACESSORIA;
    const LFE_TOTALDESPACESSORIA_Name = 'LFE_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALFRETENF', ftBCD)]
    [Dictionary('LFE_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALFRETENF: Double read FLFE_TOTALFRETENF write FLFE_TOTALFRETENF;
    const LFE_TOTALFRETENF_Name = 'LFE_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPISCOFINS', ftBCD)]
    [Dictionary('LFE_TOTALPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPISCOFINS: Double read FLFE_TOTALPISCOFINS write FLFE_TOTALPISCOFINS;
    const LFE_TOTALPISCOFINS_Name = 'LFE_TOTALPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALSEGURO', ftBCD)]
    [Dictionary('LFE_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALSEGURO: Double read FLFE_TOTALSEGURO write FLFE_TOTALSEGURO;
    const LFE_TOTALSEGURO_Name = 'LFE_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALSERVICO', ftBCD)]
    [Dictionary('LFE_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALSERVICO: Double read FLFE_TOTALSERVICO write FLFE_TOTALSERVICO;
    const LFE_TOTALSERVICO_Name = 'LFE_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_CANCELADO', ftString, 1)]
    [Dictionary('LFE_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_CANCELADO: String read FLFE_CANCELADO write FLFE_CANCELADO;
    const LFE_CANCELADO_Name = 'LFE_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DESATIVADO', ftString, 1)]
    [Dictionary('LFE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_DESATIVADO: String read FLFE_DESATIVADO write FLFE_DESATIVADO;
    const LFE_DESATIVADO_Name = 'LFE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('LFE_INTEGRACAO', ftString, 20)]
    [Dictionary('LFE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_INTEGRACAO: String read FLFE_INTEGRACAO write FLFE_INTEGRACAO;
    const LFE_INTEGRACAO_Name = 'LFE_INTEGRACAO';

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
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

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
    [Column('LFE_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('LFE_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_ESPECIEVOLUMES: String read FLFE_ESPECIEVOLUMES write FLFE_ESPECIEVOLUMES;
    const LFE_ESPECIEVOLUMES_Name = 'LFE_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_MARCAVOLUMES', ftString, 30)]
    [Dictionary('LFE_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_MARCAVOLUMES: String read FLFE_MARCAVOLUMES write FLFE_MARCAVOLUMES;
    const LFE_MARCAVOLUMES_Name = 'LFE_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('LFE_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NUMERACAOVOLUMES: String read FLFE_NUMERACAOVOLUMES write FLFE_NUMERACAOVOLUMES;
    const LFE_NUMERACAOVOLUMES_Name = 'LFE_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('LFE_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_TOTALNUMEROVOLUMES: Integer read FLFE_TOTALNUMEROVOLUMES write FLFE_TOTALNUMEROVOLUMES;
    const LFE_TOTALNUMEROVOLUMES_Name = 'LFE_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_UFVEICULO', ftString, 2)]
    [Dictionary('LFE_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_UFVEICULO: String read FLFE_UFVEICULO write FLFE_UFVEICULO;
    const LFE_UFVEICULO_Name = 'LFE_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('LFE_PLACAVEICULO', ftString, 7)]
    [Dictionary('LFE_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_PLACAVEICULO: String read FLFE_PLACAVEICULO write FLFE_PLACAVEICULO;
    const LFE_PLACAVEICULO_Name = 'LFE_PLACAVEICULO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_LFE)

end.
