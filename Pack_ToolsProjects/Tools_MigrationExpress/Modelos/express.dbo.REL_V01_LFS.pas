unit express.dbo.REL_V01_LFS;

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
  [Table('REL_V01_LFS', '')]
  TDtoREL_V01_LFS = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FCGA_ID: Integer;
    FCFOP_CODIGO: String;
    FMNF_CODIGO: String;
    FLFS_NOTAFISCAL: String;
    FNTO_CODIGO: Integer;
    FNTO_DESCRICAO: String;
    FLFS_DATASAIDA: TDateTime;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_DATALANCAMENTO: TDateTime;
    FLFS_TOTALPESOLIQUIDO: Double;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_TOTALCOMPLEMENTONFICMS: Double;
    FLFS_TOTALDESCTO: Double;
    FLFS_TOTALDESPACESSORIA: Double;
    FLFS_TOTALFRETENF: Double;
    FLFS_TOTALPISCOFINS: Double;
    FLFS_TOTALSEGURO: Double;
    FLFS_TOTALSERVICO: Double;
    FPES_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FLFS_CANCELADO: String;
    FLFS_DESATIVADO: String;
    FLFS_INTEGRACAO: String;
    FLFS_INFCOMPLEMENTAR: String;
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
    FLFS_ESPECIEVOLUMES: String;
    FLFS_MARCAVOLUMES: String;
    FLFS_NUMERACAOVOLUMES: String;
    FLFS_TOTALNUMEROVOLUMES: Integer;
    FLFS_UFVEICULO: String;
    FLFS_PLACAVEICULO: String;
    FLFS_TOTALISS: Double;
    FLFS_TOTALBASECALCULOISS: Double;
    FLFS_TIPONOTAFISCAL: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_LFS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

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
    [Column('LFS_DATASAIDA', ftDateTime)]
    [Dictionary('LFS_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATASAIDA: TDateTime read FLFS_DATASAIDA write FLFS_DATASAIDA;
    const LFS_DATASAIDA_Name = 'LFS_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATALANCAMENTO', ftDateTime)]
    [Dictionary('LFS_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATALANCAMENTO: TDateTime read FLFS_DATALANCAMENTO write FLFS_DATALANCAMENTO;
    const LFS_DATALANCAMENTO_Name = 'LFS_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('LFS_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPESOLIQUIDO: Double read FLFS_TOTALPESOLIQUIDO write FLFS_TOTALPESOLIQUIDO;
    const LFS_TOTALPESOLIQUIDO_Name = 'LFS_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('LFS_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOMPLEMENTONFICMS: Double read FLFS_TOTALCOMPLEMENTONFICMS write FLFS_TOTALCOMPLEMENTONFICMS;
    const LFS_TOTALCOMPLEMENTONFICMS_Name = 'LFS_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALDESCTO', ftBCD)]
    [Dictionary('LFS_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESCTO: Double read FLFS_TOTALDESCTO write FLFS_TOTALDESCTO;
    const LFS_TOTALDESCTO_Name = 'LFS_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('LFS_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESPACESSORIA: Double read FLFS_TOTALDESPACESSORIA write FLFS_TOTALDESPACESSORIA;
    const LFS_TOTALDESPACESSORIA_Name = 'LFS_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALFRETENF', ftBCD)]
    [Dictionary('LFS_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFRETENF: Double read FLFS_TOTALFRETENF write FLFS_TOTALFRETENF;
    const LFS_TOTALFRETENF_Name = 'LFS_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPISCOFINS', ftBCD)]
    [Dictionary('LFS_TOTALPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPISCOFINS: Double read FLFS_TOTALPISCOFINS write FLFS_TOTALPISCOFINS;
    const LFS_TOTALPISCOFINS_Name = 'LFS_TOTALPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALSEGURO', ftBCD)]
    [Dictionary('LFS_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSEGURO: Double read FLFS_TOTALSEGURO write FLFS_TOTALSEGURO;
    const LFS_TOTALSEGURO_Name = 'LFS_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALSERVICO', ftBCD)]
    [Dictionary('LFS_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSERVICO: Double read FLFS_TOTALSERVICO write FLFS_TOTALSERVICO;
    const LFS_TOTALSERVICO_Name = 'LFS_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_CANCELADO', ftString, 1)]
    [Dictionary('LFS_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CANCELADO: String read FLFS_CANCELADO write FLFS_CANCELADO;
    const LFS_CANCELADO_Name = 'LFS_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DESATIVADO', ftString, 1)]
    [Dictionary('LFS_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_DESATIVADO: String read FLFS_DESATIVADO write FLFS_DESATIVADO;
    const LFS_DESATIVADO_Name = 'LFS_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('LFS_INTEGRACAO', ftString, 20)]
    [Dictionary('LFS_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_INTEGRACAO: String read FLFS_INTEGRACAO write FLFS_INTEGRACAO;
    const LFS_INTEGRACAO_Name = 'LFS_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_INFCOMPLEMENTAR', ftString, 5000)]
    [Dictionary('LFS_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_INFCOMPLEMENTAR: String read FLFS_INFCOMPLEMENTAR write FLFS_INFCOMPLEMENTAR;
    const LFS_INFCOMPLEMENTAR_Name = 'LFS_INFCOMPLEMENTAR';

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
    [Column('LFS_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('LFS_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_ESPECIEVOLUMES: String read FLFS_ESPECIEVOLUMES write FLFS_ESPECIEVOLUMES;
    const LFS_ESPECIEVOLUMES_Name = 'LFS_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_MARCAVOLUMES', ftString, 30)]
    [Dictionary('LFS_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_MARCAVOLUMES: String read FLFS_MARCAVOLUMES write FLFS_MARCAVOLUMES;
    const LFS_MARCAVOLUMES_Name = 'LFS_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('LFS_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMERACAOVOLUMES: String read FLFS_NUMERACAOVOLUMES write FLFS_NUMERACAOVOLUMES;
    const LFS_NUMERACAOVOLUMES_Name = 'LFS_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('LFS_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_TOTALNUMEROVOLUMES: Integer read FLFS_TOTALNUMEROVOLUMES write FLFS_TOTALNUMEROVOLUMES;
    const LFS_TOTALNUMEROVOLUMES_Name = 'LFS_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_UFVEICULO', ftString, 2)]
    [Dictionary('LFS_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UFVEICULO: String read FLFS_UFVEICULO write FLFS_UFVEICULO;
    const LFS_UFVEICULO_Name = 'LFS_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('LFS_PLACAVEICULO', ftString, 7)]
    [Dictionary('LFS_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_PLACAVEICULO: String read FLFS_PLACAVEICULO write FLFS_PLACAVEICULO;
    const LFS_PLACAVEICULO_Name = 'LFS_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALISS', ftBCD)]
    [Dictionary('LFS_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALISS: Double read FLFS_TOTALISS write FLFS_TOTALISS;
    const LFS_TOTALISS_Name = 'LFS_TOTALISS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOISS', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOISS: Double read FLFS_TOTALBASECALCULOISS write FLFS_TOTALBASECALCULOISS;
    const LFS_TOTALBASECALCULOISS_Name = 'LFS_TOTALBASECALCULOISS';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPONOTAFISCAL', ftString, 4)]
    [Dictionary('LFS_TIPONOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPONOTAFISCAL: String read FLFS_TIPONOTAFISCAL write FLFS_TIPONOTAFISCAL;
    const LFS_TIPONOTAFISCAL_Name = 'LFS_TIPONOTAFISCAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_LFS)

end.
