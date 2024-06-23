unit express.dbo.XML_NOTASFISCAISSERVICO;

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
  [Table('XML_NOTASFISCAISSERVICO', '')]
  TDtoXML_NOTASFISCAISSERVICO = class
  private
    { Private declarations } 
    FNFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FMNF_CODIGO: String;
    FCGA_ID: Integer;
    FCFOP_CODIGO: String;
    FNTO_CODIGO: Integer;
    FNTO_PARAMETROS: String;
    FNTO_DESCRICAO: String;
    FNTO_CODIGONATUREZASERVICO: String;
    FNFS_ISSRETIDO: String;
    FNFS_DATAEMISSAO: TDateTime;
    FNFS_DATASAIDAENTRADA: TDateTime;
    FNFS_SITUACAO: String;
    FNFS_FINALIDADE: String;
    FNFS_NOTAFISCAL: String;
    FNFS_SERIE: String;
    FNFS_RPS: Integer;
    FNFS_CHAVEREFERENCIANFE: TBlob;
    FNFS_EMITENTE: String;
    FNFS_TOTALIPI: Double;
    FNFS_TOTALPIS: Double;
    FNFS_TOTALICMS: Double;
    FNFS_TIPOFRETE: String;
    FNFS_TOTALICMSR: Double;
    FNFS_TOTALCOFINS: Double;
    FNFS_TOTALSEGURO: Double;
    FNFS_TOTALDESCTO: Double;
    FNFS_TOTALSERVICO: Double;
    FNFS_TOTALFRETENF: Double;
    FNFS_TOTALPRODUTOS: Double;
    FNFS_TOTALNOTAFISCAL: Double;
    FNFS_TOTALPESOBRUTO: Double;
    FNFS_TOTALPESOLIQUIDO: Double;
    FNFS_TOTALDESPACESSORIA: Double;
    FNFS_TOTALBASEISENTOICMS: Double;
    FNFS_TOTALBASECALCULOMVA: Double;
    FNFS_TOTALBASECALCULOICMS: Double;
    FNFS_TOTALCOMPLEMENTONFICMS: Double;
    FNFS_TOTALNUMEROVOLUMES: Integer;
    FNFS_NUMERACAOVOLUMES: String;
    FNFS_INFCOMPLEMENTAR: String;
    FNFS_ESPECIEVOLUMES: String;
    FNFS_MARCAVOLUMES: String;
    FNFS_INTEGRACAO: String;
    FNFS_INTEGRACAOLIVRO: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_TIPOPESSOA: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_IE_MUNICIPAL: String;
    FPES_NOME: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_EMAIL: String;
    FPES_CODIGOPAIS: String;
    FPES_PAIS: String;
    FCEP_CODIGO: String;
    FPES_UF: String;
    FTRP_CODIGO: Integer;
    FNFS_PLACAVEICULO: String;
    FNFS_UFVEICULO: String;
    FNFS_OBSERVACAO: String;
    FNFS_STATUSNFe: String;
    FNFS_PORTEESTADUAL: String;
    FNFS_PORTEFEDERAL: String;
    FNFS_TOTALISS: Double;
    FNFS_TOTALIR: Double;
    FNFS_TOTALINSS: Double;
    FNFS_TOTALCSLL: Double;
    FNFS_TOTALBASECALCULOISS: Double;
    FNFS_PERCENTUALIBPT: Double;
    FNFS_TOTALAPROXIMADOIMPOSTO: Double;
    FPES_CODIGOENTREGA: Integer;
    FPES_TIPOPESSOA_ENTREGA: String;
    FPES_NOME_ENTREGA: String;
    FPES_CNPJ_CPF_ENTREGA: String;
    FCEP_CODIGO_ENTREGA: String;
    FCID_IBGE_ENTREGA: String;
    FPES_CIDADE_ENTREGA: String;
    FPES_UF_ENTREGA: String;
    FPES_ENDERECO_ENTREGA: String;
    FPES_NUMEROENDERECO_ENTREGA: String;
    FPES_BAIRRO_ENTREGA: String;
    FPES_CODIGORETIRADA: Integer;
    FPES_TIPOPESSOA_RETIRADA: String;
    FPES_NOME_RETIRADA: String;
    FPES_CNPJ_CPF_RETIRADA: String;
    FCEP_CODIGO_RETIRADA: String;
    FCID_IBGE_RETIRADA: String;
    FPES_CIDADE_RETIRADA: String;
    FPES_UF_RETIRADA: String;
    FPES_ENDERECO_RETIRADA: String;
    FPES_NUMEROENDERECO_RETIRADA: String;
    FPES_BAIRRO_RETIRADA: String;
  public 
    { Public declarations } 
     const Table      = 'XML_NOTASFISCAISSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_ID', ftInteger)]
    [Dictionary('NFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_ID: Integer read FNFS_ID write FNFS_ID;
    const NFS_ID_Name = 'NFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_PARAMETROS', ftString, 50)]
    [Dictionary('NTO_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_PARAMETROS: String read FNTO_PARAMETROS write FNTO_PARAMETROS;
    const NTO_PARAMETROS_Name = 'NTO_PARAMETROS';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGONATUREZASERVICO', ftString, 3)]
    [Dictionary('NTO_CODIGONATUREZASERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_CODIGONATUREZASERVICO: String read FNTO_CODIGONATUREZASERVICO write FNTO_CODIGONATUREZASERVICO;
    const NTO_CODIGONATUREZASERVICO_Name = 'NTO_CODIGONATUREZASERVICO';

    [Restrictions([NoValidate])]
    [Column('NFS_ISSRETIDO', ftString, 1)]
    [Dictionary('NFS_ISSRETIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_ISSRETIDO: String read FNFS_ISSRETIDO write FNFS_ISSRETIDO;
    const NFS_ISSRETIDO_Name = 'NFS_ISSRETIDO';

    [Restrictions([NoValidate])]
    [Column('NFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('NFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFS_DATAEMISSAO: TDateTime read FNFS_DATAEMISSAO write FNFS_DATAEMISSAO;
    const NFS_DATAEMISSAO_Name = 'NFS_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_DATASAIDAENTRADA', ftDateTime)]
    [Dictionary('NFS_DATASAIDAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFS_DATASAIDAENTRADA: TDateTime read FNFS_DATASAIDAENTRADA write FNFS_DATASAIDAENTRADA;
    const NFS_DATASAIDAENTRADA_Name = 'NFS_DATASAIDAENTRADA';

    [Restrictions([NoValidate])]
    [Column('NFS_SITUACAO', ftString, 1)]
    [Dictionary('NFS_SITUACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_SITUACAO: String read FNFS_SITUACAO write FNFS_SITUACAO;
    const NFS_SITUACAO_Name = 'NFS_SITUACAO';

    [Restrictions([NoValidate])]
    [Column('NFS_FINALIDADE', ftString, 1)]
    [Dictionary('NFS_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_FINALIDADE: String read FNFS_FINALIDADE write FNFS_FINALIDADE;
    const NFS_FINALIDADE_Name = 'NFS_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('NFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_NOTAFISCAL: String read FNFS_NOTAFISCAL write FNFS_NOTAFISCAL;
    const NFS_NOTAFISCAL_Name = 'NFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFS_SERIE', ftString, 3)]
    [Dictionary('NFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_SERIE: String read FNFS_SERIE write FNFS_SERIE;
    const NFS_SERIE_Name = 'NFS_SERIE';

    [Restrictions([NoValidate])]
    [Column('NFS_RPS', ftInteger)]
    [Dictionary('NFS_RPS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_RPS: Integer read FNFS_RPS write FNFS_RPS;
    const NFS_RPS_Name = 'NFS_RPS';

    [Restrictions([NoValidate])]
    [Column('NFS_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('NFS_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_CHAVEREFERENCIANFE: TBlob read FNFS_CHAVEREFERENCIANFE write FNFS_CHAVEREFERENCIANFE;
    const NFS_CHAVEREFERENCIANFE_Name = 'NFS_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate])]
    [Column('NFS_EMITENTE', ftString, 50)]
    [Dictionary('NFS_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_EMITENTE: String read FNFS_EMITENTE write FNFS_EMITENTE;
    const NFS_EMITENTE_Name = 'NFS_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALIPI', ftBCD)]
    [Dictionary('NFS_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALIPI: Double read FNFS_TOTALIPI write FNFS_TOTALIPI;
    const NFS_TOTALIPI_Name = 'NFS_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALPIS', ftBCD)]
    [Dictionary('NFS_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALPIS: Double read FNFS_TOTALPIS write FNFS_TOTALPIS;
    const NFS_TOTALPIS_Name = 'NFS_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALICMS', ftBCD)]
    [Dictionary('NFS_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALICMS: Double read FNFS_TOTALICMS write FNFS_TOTALICMS;
    const NFS_TOTALICMS_Name = 'NFS_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('NFS_TIPOFRETE', ftString, 1)]
    [Dictionary('NFS_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_TIPOFRETE: String read FNFS_TIPOFRETE write FNFS_TIPOFRETE;
    const NFS_TIPOFRETE_Name = 'NFS_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALICMSR', ftBCD)]
    [Dictionary('NFS_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALICMSR: Double read FNFS_TOTALICMSR write FNFS_TOTALICMSR;
    const NFS_TOTALICMSR_Name = 'NFS_TOTALICMSR';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALCOFINS', ftBCD)]
    [Dictionary('NFS_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALCOFINS: Double read FNFS_TOTALCOFINS write FNFS_TOTALCOFINS;
    const NFS_TOTALCOFINS_Name = 'NFS_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALSEGURO', ftBCD, 48, 2)]
    [Dictionary('NFS_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALSEGURO: Double read FNFS_TOTALSEGURO write FNFS_TOTALSEGURO;
    const NFS_TOTALSEGURO_Name = 'NFS_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALDESCTO', ftBCD, 10, 2)]
    [Dictionary('NFS_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALDESCTO: Double read FNFS_TOTALDESCTO write FNFS_TOTALDESCTO;
    const NFS_TOTALDESCTO_Name = 'NFS_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALSERVICO', ftBCD)]
    [Dictionary('NFS_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALSERVICO: Double read FNFS_TOTALSERVICO write FNFS_TOTALSERVICO;
    const NFS_TOTALSERVICO_Name = 'NFS_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALFRETENF', ftBCD)]
    [Dictionary('NFS_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALFRETENF: Double read FNFS_TOTALFRETENF write FNFS_TOTALFRETENF;
    const NFS_TOTALFRETENF_Name = 'NFS_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALPRODUTOS', ftBCD)]
    [Dictionary('NFS_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALPRODUTOS: Double read FNFS_TOTALPRODUTOS write FNFS_TOTALPRODUTOS;
    const NFS_TOTALPRODUTOS_Name = 'NFS_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALNOTAFISCAL', ftBCD, 48, 2)]
    [Dictionary('NFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALNOTAFISCAL: Double read FNFS_TOTALNOTAFISCAL write FNFS_TOTALNOTAFISCAL;
    const NFS_TOTALNOTAFISCAL_Name = 'NFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('NFS_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALPESOBRUTO: Double read FNFS_TOTALPESOBRUTO write FNFS_TOTALPESOBRUTO;
    const NFS_TOTALPESOBRUTO_Name = 'NFS_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('NFS_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALPESOLIQUIDO: Double read FNFS_TOTALPESOLIQUIDO write FNFS_TOTALPESOLIQUIDO;
    const NFS_TOTALPESOLIQUIDO_Name = 'NFS_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALDESPACESSORIA', ftBCD, 10, 2)]
    [Dictionary('NFS_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALDESPACESSORIA: Double read FNFS_TOTALDESPACESSORIA write FNFS_TOTALDESPACESSORIA;
    const NFS_TOTALDESPACESSORIA_Name = 'NFS_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('NFS_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALBASEISENTOICMS: Double read FNFS_TOTALBASEISENTOICMS write FNFS_TOTALBASEISENTOICMS;
    const NFS_TOTALBASEISENTOICMS_Name = 'NFS_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('NFS_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALBASECALCULOMVA: Double read FNFS_TOTALBASECALCULOMVA write FNFS_TOTALBASECALCULOMVA;
    const NFS_TOTALBASECALCULOMVA_Name = 'NFS_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('NFS_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALBASECALCULOICMS: Double read FNFS_TOTALBASECALCULOICMS write FNFS_TOTALBASECALCULOICMS;
    const NFS_TOTALBASECALCULOICMS_Name = 'NFS_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('NFS_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALCOMPLEMENTONFICMS: Double read FNFS_TOTALCOMPLEMENTONFICMS write FNFS_TOTALCOMPLEMENTONFICMS;
    const NFS_TOTALCOMPLEMENTONFICMS_Name = 'NFS_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('NFS_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_TOTALNUMEROVOLUMES: Integer read FNFS_TOTALNUMEROVOLUMES write FNFS_TOTALNUMEROVOLUMES;
    const NFS_TOTALNUMEROVOLUMES_Name = 'NFS_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFS_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('NFS_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_NUMERACAOVOLUMES: String read FNFS_NUMERACAOVOLUMES write FNFS_NUMERACAOVOLUMES;
    const NFS_NUMERACAOVOLUMES_Name = 'NFS_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFS_INFCOMPLEMENTAR', ftString, 5000)]
    [Dictionary('NFS_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_INFCOMPLEMENTAR: String read FNFS_INFCOMPLEMENTAR write FNFS_INFCOMPLEMENTAR;
    const NFS_INFCOMPLEMENTAR_Name = 'NFS_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('NFS_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('NFS_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_ESPECIEVOLUMES: String read FNFS_ESPECIEVOLUMES write FNFS_ESPECIEVOLUMES;
    const NFS_ESPECIEVOLUMES_Name = 'NFS_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFS_MARCAVOLUMES', ftString, 30)]
    [Dictionary('NFS_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_MARCAVOLUMES: String read FNFS_MARCAVOLUMES write FNFS_MARCAVOLUMES;
    const NFS_MARCAVOLUMES_Name = 'NFS_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFS_INTEGRACAO', ftString, 20)]
    [Dictionary('NFS_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_INTEGRACAO: String read FNFS_INTEGRACAO write FNFS_INTEGRACAO;
    const NFS_INTEGRACAO_Name = 'NFS_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('NFS_INTEGRACAOLIVRO', ftString, 33)]
    [Dictionary('NFS_INTEGRACAOLIVRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_INTEGRACAOLIVRO: String read FNFS_INTEGRACAOLIVRO write FNFS_INTEGRACAOLIVRO;
    const NFS_INTEGRACAOLIVRO_Name = 'NFS_INTEGRACAOLIVRO';

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
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

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
    [Column('PES_IE_MUNICIPAL', ftString, 16)]
    [Dictionary('PES_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_MUNICIPAL: String read FPES_IE_MUNICIPAL write FPES_IE_MUNICIPAL;
    const PES_IE_MUNICIPAL_Name = 'PES_IE_MUNICIPAL';

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
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS: String read FPES_CODIGOPAIS write FPES_CODIGOPAIS;
    const PES_CODIGOPAIS_Name = 'PES_CODIGOPAIS';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS', ftString, 100)]
    [Dictionary('PES_PAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS: String read FPES_PAIS write FPES_PAIS;
    const PES_PAIS_Name = 'PES_PAIS';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFS_PLACAVEICULO', ftString, 7)]
    [Dictionary('NFS_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_PLACAVEICULO: String read FNFS_PLACAVEICULO write FNFS_PLACAVEICULO;
    const NFS_PLACAVEICULO_Name = 'NFS_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('NFS_UFVEICULO', ftString, 2)]
    [Dictionary('NFS_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_UFVEICULO: String read FNFS_UFVEICULO write FNFS_UFVEICULO;
    const NFS_UFVEICULO_Name = 'NFS_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('NFS_OBSERVACAO', ftString, 5000)]
    [Dictionary('NFS_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_OBSERVACAO: String read FNFS_OBSERVACAO write FNFS_OBSERVACAO;
    const NFS_OBSERVACAO_Name = 'NFS_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('NFS_STATUSNFe', ftString, 2)]
    [Dictionary('NFS_STATUSNFe', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_STATUSNFe: String read FNFS_STATUSNFe write FNFS_STATUSNFe;
    const NFS_STATUSNFe_Name = 'NFS_STATUSNFe';

    [Restrictions([NoValidate])]
    [Column('NFS_PORTEESTADUAL', ftString, 1)]
    [Dictionary('NFS_PORTEESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_PORTEESTADUAL: String read FNFS_PORTEESTADUAL write FNFS_PORTEESTADUAL;
    const NFS_PORTEESTADUAL_Name = 'NFS_PORTEESTADUAL';

    [Restrictions([NoValidate])]
    [Column('NFS_PORTEFEDERAL', ftString, 1)]
    [Dictionary('NFS_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFS_PORTEFEDERAL: String read FNFS_PORTEFEDERAL write FNFS_PORTEFEDERAL;
    const NFS_PORTEFEDERAL_Name = 'NFS_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALISS', ftBCD)]
    [Dictionary('NFS_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALISS: Double read FNFS_TOTALISS write FNFS_TOTALISS;
    const NFS_TOTALISS_Name = 'NFS_TOTALISS';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALIR', ftBCD, 48, 2)]
    [Dictionary('NFS_TOTALIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALIR: Double read FNFS_TOTALIR write FNFS_TOTALIR;
    const NFS_TOTALIR_Name = 'NFS_TOTALIR';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALINSS', ftBCD)]
    [Dictionary('NFS_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALINSS: Double read FNFS_TOTALINSS write FNFS_TOTALINSS;
    const NFS_TOTALINSS_Name = 'NFS_TOTALINSS';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALCSLL', ftBCD)]
    [Dictionary('NFS_TOTALCSLL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALCSLL: Double read FNFS_TOTALCSLL write FNFS_TOTALCSLL;
    const NFS_TOTALCSLL_Name = 'NFS_TOTALCSLL';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALBASECALCULOISS', ftBCD)]
    [Dictionary('NFS_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALBASECALCULOISS: Double read FNFS_TOTALBASECALCULOISS write FNFS_TOTALBASECALCULOISS;
    const NFS_TOTALBASECALCULOISS_Name = 'NFS_TOTALBASECALCULOISS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_PERCENTUALIBPT', ftBCD)]
    [Dictionary('NFS_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_PERCENTUALIBPT: Double read FNFS_PERCENTUALIBPT write FNFS_PERCENTUALIBPT;
    const NFS_PERCENTUALIBPT_Name = 'NFS_PERCENTUALIBPT';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('NFS_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALAPROXIMADOIMPOSTO: Double read FNFS_TOTALAPROXIMADOIMPOSTO write FNFS_TOTALAPROXIMADOIMPOSTO;
    const NFS_TOTALAPROXIMADOIMPOSTO_Name = 'NFS_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOENTREGA', ftInteger)]
    [Dictionary('PES_CODIGOENTREGA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOENTREGA: Integer read FPES_CODIGOENTREGA write FPES_CODIGOENTREGA;
    const PES_CODIGOENTREGA_Name = 'PES_CODIGOENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_ENTREGA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_ENTREGA: String read FPES_TIPOPESSOA_ENTREGA write FPES_TIPOPESSOA_ENTREGA;
    const PES_TIPOPESSOA_ENTREGA_Name = 'PES_TIPOPESSOA_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_ENTREGA', ftString, 100)]
    [Dictionary('PES_NOME_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_ENTREGA: String read FPES_NOME_ENTREGA write FPES_NOME_ENTREGA;
    const PES_NOME_ENTREGA_Name = 'PES_NOME_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_ENTREGA', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_ENTREGA: String read FPES_CNPJ_CPF_ENTREGA write FPES_CNPJ_CPF_ENTREGA;
    const PES_CNPJ_CPF_ENTREGA_Name = 'PES_CNPJ_CPF_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO_ENTREGA', ftString, 8)]
    [Dictionary('CEP_CODIGO_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO_ENTREGA: String read FCEP_CODIGO_ENTREGA write FCEP_CODIGO_ENTREGA;
    const CEP_CODIGO_ENTREGA_Name = 'CEP_CODIGO_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_ENTREGA', ftString, 7)]
    [Dictionary('CID_IBGE_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_ENTREGA: String read FCID_IBGE_ENTREGA write FCID_IBGE_ENTREGA;
    const CID_IBGE_ENTREGA_Name = 'CID_IBGE_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_ENTREGA', ftString, 100)]
    [Dictionary('PES_CIDADE_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_ENTREGA: String read FPES_CIDADE_ENTREGA write FPES_CIDADE_ENTREGA;
    const PES_CIDADE_ENTREGA_Name = 'PES_CIDADE_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_UF_ENTREGA', ftString, 2)]
    [Dictionary('PES_UF_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_ENTREGA: String read FPES_UF_ENTREGA write FPES_UF_ENTREGA;
    const PES_UF_ENTREGA_Name = 'PES_UF_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_ENTREGA', ftString, 100)]
    [Dictionary('PES_ENDERECO_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_ENTREGA: String read FPES_ENDERECO_ENTREGA write FPES_ENDERECO_ENTREGA;
    const PES_ENDERECO_ENTREGA_Name = 'PES_ENDERECO_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_ENTREGA', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_ENTREGA: String read FPES_NUMEROENDERECO_ENTREGA write FPES_NUMEROENDERECO_ENTREGA;
    const PES_NUMEROENDERECO_ENTREGA_Name = 'PES_NUMEROENDERECO_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_ENTREGA', ftString, 50)]
    [Dictionary('PES_BAIRRO_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_ENTREGA: String read FPES_BAIRRO_ENTREGA write FPES_BAIRRO_ENTREGA;
    const PES_BAIRRO_ENTREGA_Name = 'PES_BAIRRO_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGORETIRADA', ftInteger)]
    [Dictionary('PES_CODIGORETIRADA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGORETIRADA: Integer read FPES_CODIGORETIRADA write FPES_CODIGORETIRADA;
    const PES_CODIGORETIRADA_Name = 'PES_CODIGORETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_RETIRADA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_RETIRADA: String read FPES_TIPOPESSOA_RETIRADA write FPES_TIPOPESSOA_RETIRADA;
    const PES_TIPOPESSOA_RETIRADA_Name = 'PES_TIPOPESSOA_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_RETIRADA', ftString, 100)]
    [Dictionary('PES_NOME_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_RETIRADA: String read FPES_NOME_RETIRADA write FPES_NOME_RETIRADA;
    const PES_NOME_RETIRADA_Name = 'PES_NOME_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_RETIRADA', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_RETIRADA: String read FPES_CNPJ_CPF_RETIRADA write FPES_CNPJ_CPF_RETIRADA;
    const PES_CNPJ_CPF_RETIRADA_Name = 'PES_CNPJ_CPF_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO_RETIRADA', ftString, 8)]
    [Dictionary('CEP_CODIGO_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO_RETIRADA: String read FCEP_CODIGO_RETIRADA write FCEP_CODIGO_RETIRADA;
    const CEP_CODIGO_RETIRADA_Name = 'CEP_CODIGO_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_RETIRADA', ftString, 7)]
    [Dictionary('CID_IBGE_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_RETIRADA: String read FCID_IBGE_RETIRADA write FCID_IBGE_RETIRADA;
    const CID_IBGE_RETIRADA_Name = 'CID_IBGE_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_RETIRADA', ftString, 100)]
    [Dictionary('PES_CIDADE_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_RETIRADA: String read FPES_CIDADE_RETIRADA write FPES_CIDADE_RETIRADA;
    const PES_CIDADE_RETIRADA_Name = 'PES_CIDADE_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_UF_RETIRADA', ftString, 2)]
    [Dictionary('PES_UF_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_RETIRADA: String read FPES_UF_RETIRADA write FPES_UF_RETIRADA;
    const PES_UF_RETIRADA_Name = 'PES_UF_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_RETIRADA', ftString, 100)]
    [Dictionary('PES_ENDERECO_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_RETIRADA: String read FPES_ENDERECO_RETIRADA write FPES_ENDERECO_RETIRADA;
    const PES_ENDERECO_RETIRADA_Name = 'PES_ENDERECO_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_RETIRADA', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_RETIRADA: String read FPES_NUMEROENDERECO_RETIRADA write FPES_NUMEROENDERECO_RETIRADA;
    const PES_NUMEROENDERECO_RETIRADA_Name = 'PES_NUMEROENDERECO_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_RETIRADA', ftString, 50)]
    [Dictionary('PES_BAIRRO_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_RETIRADA: String read FPES_BAIRRO_RETIRADA write FPES_BAIRRO_RETIRADA;
    const PES_BAIRRO_RETIRADA_Name = 'PES_BAIRRO_RETIRADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_NOTASFISCAISSERVICO)

end.
