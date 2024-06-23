unit express.dbo.XML_NOTASFISCAIS;

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
  [Table('XML_NOTASFISCAIS', '')]
  TDtoXML_NOTASFISCAIS = class
  private
    { Private declarations } 
    FNF_TIPO: String;
    FNF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FNF_CPFCLIENTE: String;
    FNF_NOMECLIENTE: String;
    FMNF_CODIGO: String;
    FCGA_ID: Integer;
    FCFOP_CODIGO: String;
    FNTO_CODIGO: Integer;
    FNTO_ENVIARDIFAL: String;
    FNTO_ENVIARDIFALZERADO: String;
    FNTO_PERCENTUALPOBREZADIFAL: Double;
    FNTO_PERCENTUALPARTILHADIFALREM: Integer;
    FNTO_PERCENTUALPARTILHADIFALDEST: Integer;
    FNTO_PARAMETROS: String;
    FNTO_DESCRICAO: String;
    FTDC_CODIGO: String;
    FNF_DATAEMISSAO: TDateTime;
    FNF_DATASAIDAENTRADA: TDateTime;
    FNF_SITUACAO: String;
    FNF_FINALIDADE: String;
    FNF_NOTAFISCAL: String;
    FNF_SERIE: String;
    FNF_CHAVEREFERENCIANFE: TBlob;
    FNF_EMITENTE: String;
    FNF_TOTALIPI: Double;
    FNF_TOTALPIS: Double;
    FNF_TOTALICMS: Double;
    FNF_TIPOFRETE: String;
    FNF_TOTALICMSR: Double;
    FNF_TOTALCOFINS: Double;
    FNF_TOTALSEGURO: Double;
    FNF_TOTALDESCTO: Double;
    FNF_TOTALSERVICO: Double;
    FNF_TOTALFRETENF: Double;
    FNF_TOTALPRODUTOS: Double;
    FNF_TOTALNOTAFISCAL: Double;
    FNF_TOTALPESOBRUTO: Double;
    FNF_TOTALPESOLIQUIDO: Double;
    FNF_TOTALDESPACESSORIA: Double;
    FNF_TOTALBASEISENTOICMS: Double;
    FNF_TOTALBASECALCULOMVA: Double;
    FNF_TOTALBASECALCULOICMS: Double;
    FNF_TOTALCOMPLEMENTONFICMS: Double;
    FNF_TOTALNUMEROVOLUMES: Integer;
    FNF_NUMERACAOVOLUMES: String;
    FNF_INFCOMPLEMENTAR: String;
    FNF_ESPECIEVOLUMES: String;
    FNF_MARCAVOLUMES: String;
    FNF_INTEGRACAO: String;
    FNF_INTEGRACAOLIVRO: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_TIPOPESSOA: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
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
    FNF_PLACAVEICULO: String;
    FNF_UFVEICULO: String;
    FNF_RNTRC: String;
    FNF_STATUSNFe: String;
    FNF_PORTEESTADUAL: String;
    FNF_PORTEFEDERAL: String;
    FNF_TOTALISS: Double;
    FNF_TOTALBASECALCULOISS: Double;
    FNF_PERCENTUALIBPT: Double;
    FNF_TOTALAPROXIMADOIMPOSTO: Double;
    FPES_CODIGOENTREGA: Integer;
    FPES_TIPOPESSOA_ENTREGA: String;
    FPES_NOME_ENTREGA: String;
    FPES_CNPJ_CPF_ENTREGA: String;
    FCEP_CODIGO_ENTREGA: String;
    FPES_CIDADE_ENTREGA: String;
    FCID_IBGE_ENTREGA: String;
    FPES_UF_ENTREGA: String;
    FPES_ENDERECO_ENTREGA: String;
    FPES_NUMEROENDERECO_ENTREGA: String;
    FPES_BAIRRO_ENTREGA: String;
    FPES_CODIGORETIRADA: Integer;
    FPES_TIPOPESSOA_RETIRADA: String;
    FPES_NOME_RETIRADA: String;
    FPES_CNPJ_CPF_RETIRADA: String;
    FCEP_CODIGO_RETIRADA: String;
    FPES_CIDADE_RETIRADA: String;
    FCID_IBGE_RETIRADA: String;
    FPES_UF_RETIRADA: String;
    FPES_ENDERECO_RETIRADA: String;
    FPES_NUMEROENDERECO_RETIRADA: String;
    FPES_BAIRRO_RETIRADA: String;
    FNF_NUMEROORDEMCOMPRA: String;
    FNF_TOTALIBPTMUNICIPAL: Double;
    FNF_TOTALIBPTESTADUAL: Double;
    FNF_TOTALIBPTNACIONAL: Double;
    FNF_TOTALIBPTIMPORTADO: Double;
    FNF_TOTALBASECALCULOFCP: Double;
    FNF_TOTALFCP: Double;
    FNF_TOTALBASECALCULOFCPST: Double;
    FNF_TOTALFCPST: Double;
    FNF_TOTALBASECALCULOFCPRET: Double;
    FNF_TOTALFCPRET: Double;
    FNF_TOTALTROCO: Double;
  public 
    { Public declarations } 
     const Table      = 'XML_NOTASFISCAIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TIPO', ftString, 3)]
    [Dictionary('NF_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_TIPO: String read FNF_TIPO write FNF_TIPO;
    const NF_TIPO_Name = 'NF_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_ID', ftInteger)]
    [Dictionary('NF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NF_ID: Integer read FNF_ID write FNF_ID;
    const NF_ID_Name = 'NF_ID';

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
    [Column('NF_CPFCLIENTE', ftString, 11)]
    [Dictionary('NF_CPFCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CPFCLIENTE: String read FNF_CPFCLIENTE write FNF_CPFCLIENTE;
    const NF_CPFCLIENTE_Name = 'NF_CPFCLIENTE';

    [Restrictions([NoValidate])]
    [Column('NF_NOMECLIENTE', ftString, 100)]
    [Dictionary('NF_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_NOMECLIENTE: String read FNF_NOMECLIENTE write FNF_NOMECLIENTE;
    const NF_NOMECLIENTE_Name = 'NF_NOMECLIENTE';

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
    [Column('NTO_ENVIARDIFAL', ftString, 1)]
    [Dictionary('NTO_ENVIARDIFAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ENVIARDIFAL: String read FNTO_ENVIARDIFAL write FNTO_ENVIARDIFAL;
    const NTO_ENVIARDIFAL_Name = 'NTO_ENVIARDIFAL';

    [Restrictions([NoValidate])]
    [Column('NTO_ENVIARDIFALZERADO', ftString, 1)]
    [Dictionary('NTO_ENVIARDIFALZERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ENVIARDIFALZERADO: String read FNTO_ENVIARDIFALZERADO write FNTO_ENVIARDIFALZERADO;
    const NTO_ENVIARDIFALZERADO_Name = 'NTO_ENVIARDIFALZERADO';

    [Restrictions([NoValidate])]
    [Column('NTO_PERCENTUALPOBREZADIFAL', ftBCD)]
    [Dictionary('NTO_PERCENTUALPOBREZADIFAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NTO_PERCENTUALPOBREZADIFAL: Double read FNTO_PERCENTUALPOBREZADIFAL write FNTO_PERCENTUALPOBREZADIFAL;
    const NTO_PERCENTUALPOBREZADIFAL_Name = 'NTO_PERCENTUALPOBREZADIFAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_PERCENTUALPARTILHADIFALREM', ftInteger)]
    [Dictionary('NTO_PERCENTUALPARTILHADIFALREM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_PERCENTUALPARTILHADIFALREM: Integer read FNTO_PERCENTUALPARTILHADIFALREM write FNTO_PERCENTUALPARTILHADIFALREM;
    const NTO_PERCENTUALPARTILHADIFALREM_Name = 'NTO_PERCENTUALPARTILHADIFALREM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_PERCENTUALPARTILHADIFALDEST', ftInteger)]
    [Dictionary('NTO_PERCENTUALPARTILHADIFALDEST', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_PERCENTUALPARTILHADIFALDEST: Integer read FNTO_PERCENTUALPARTILHADIFALDEST write FNTO_PERCENTUALPARTILHADIFALDEST;
    const NTO_PERCENTUALPARTILHADIFALDEST_Name = 'NTO_PERCENTUALPARTILHADIFALDEST';

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
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NF_DATAEMISSAO', ftDateTime)]
    [Dictionary('NF_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property NF_DATAEMISSAO: TDateTime read FNF_DATAEMISSAO write FNF_DATAEMISSAO;
    const NF_DATAEMISSAO_Name = 'NF_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_DATASAIDAENTRADA', ftDateTime)]
    [Dictionary('NF_DATASAIDAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NF_DATASAIDAENTRADA: TDateTime read FNF_DATASAIDAENTRADA write FNF_DATASAIDAENTRADA;
    const NF_DATASAIDAENTRADA_Name = 'NF_DATASAIDAENTRADA';

    [Restrictions([NoValidate])]
    [Column('NF_SITUACAO', ftString, 1)]
    [Dictionary('NF_SITUACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_SITUACAO: String read FNF_SITUACAO write FNF_SITUACAO;
    const NF_SITUACAO_Name = 'NF_SITUACAO';

    [Restrictions([NoValidate])]
    [Column('NF_FINALIDADE', ftString, 1)]
    [Dictionary('NF_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_FINALIDADE: String read FNF_FINALIDADE write FNF_FINALIDADE;
    const NF_FINALIDADE_Name = 'NF_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('NF_NOTAFISCAL', ftString, 9)]
    [Dictionary('NF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_NOTAFISCAL: String read FNF_NOTAFISCAL write FNF_NOTAFISCAL;
    const NF_NOTAFISCAL_Name = 'NF_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NF_SERIE', ftString, 3)]
    [Dictionary('NF_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_SERIE: String read FNF_SERIE write FNF_SERIE;
    const NF_SERIE_Name = 'NF_SERIE';

    [Restrictions([NoValidate])]
    [Column('NF_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('NF_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CHAVEREFERENCIANFE: TBlob read FNF_CHAVEREFERENCIANFE write FNF_CHAVEREFERENCIANFE;
    const NF_CHAVEREFERENCIANFE_Name = 'NF_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate])]
    [Column('NF_EMITENTE', ftString, 50)]
    [Dictionary('NF_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_EMITENTE: String read FNF_EMITENTE write FNF_EMITENTE;
    const NF_EMITENTE_Name = 'NF_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALIPI', ftBCD)]
    [Dictionary('NF_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIPI: Double read FNF_TOTALIPI write FNF_TOTALIPI;
    const NF_TOTALIPI_Name = 'NF_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALPIS', ftBCD)]
    [Dictionary('NF_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALPIS: Double read FNF_TOTALPIS write FNF_TOTALPIS;
    const NF_TOTALPIS_Name = 'NF_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMS', ftBCD)]
    [Dictionary('NF_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMS: Double read FNF_TOTALICMS write FNF_TOTALICMS;
    const NF_TOTALICMS_Name = 'NF_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('NF_TIPOFRETE', ftString, 1)]
    [Dictionary('NF_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_TIPOFRETE: String read FNF_TIPOFRETE write FNF_TIPOFRETE;
    const NF_TIPOFRETE_Name = 'NF_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMSR', ftBCD)]
    [Dictionary('NF_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMSR: Double read FNF_TOTALICMSR write FNF_TOTALICMSR;
    const NF_TOTALICMSR_Name = 'NF_TOTALICMSR';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALCOFINS', ftBCD)]
    [Dictionary('NF_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALCOFINS: Double read FNF_TOTALCOFINS write FNF_TOTALCOFINS;
    const NF_TOTALCOFINS_Name = 'NF_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALSEGURO', ftBCD)]
    [Dictionary('NF_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALSEGURO: Double read FNF_TOTALSEGURO write FNF_TOTALSEGURO;
    const NF_TOTALSEGURO_Name = 'NF_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALDESCTO', ftBCD)]
    [Dictionary('NF_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALDESCTO: Double read FNF_TOTALDESCTO write FNF_TOTALDESCTO;
    const NF_TOTALDESCTO_Name = 'NF_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALSERVICO', ftBCD)]
    [Dictionary('NF_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALSERVICO: Double read FNF_TOTALSERVICO write FNF_TOTALSERVICO;
    const NF_TOTALSERVICO_Name = 'NF_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALFRETENF', ftBCD)]
    [Dictionary('NF_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFRETENF: Double read FNF_TOTALFRETENF write FNF_TOTALFRETENF;
    const NF_TOTALFRETENF_Name = 'NF_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALPRODUTOS', ftBCD)]
    [Dictionary('NF_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALPRODUTOS: Double read FNF_TOTALPRODUTOS write FNF_TOTALPRODUTOS;
    const NF_TOTALPRODUTOS_Name = 'NF_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NF_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALNOTAFISCAL: Double read FNF_TOTALNOTAFISCAL write FNF_TOTALNOTAFISCAL;
    const NF_TOTALNOTAFISCAL_Name = 'NF_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('NF_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALPESOBRUTO: Double read FNF_TOTALPESOBRUTO write FNF_TOTALPESOBRUTO;
    const NF_TOTALPESOBRUTO_Name = 'NF_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('NF_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALPESOLIQUIDO: Double read FNF_TOTALPESOLIQUIDO write FNF_TOTALPESOLIQUIDO;
    const NF_TOTALPESOLIQUIDO_Name = 'NF_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALDESPACESSORIA', ftBCD, 48, 2)]
    [Dictionary('NF_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALDESPACESSORIA: Double read FNF_TOTALDESPACESSORIA write FNF_TOTALDESPACESSORIA;
    const NF_TOTALDESPACESSORIA_Name = 'NF_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASEISENTOICMS', ftBCD, 10, 2)]
    [Dictionary('NF_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASEISENTOICMS: Double read FNF_TOTALBASEISENTOICMS write FNF_TOTALBASEISENTOICMS;
    const NF_TOTALBASEISENTOICMS_Name = 'NF_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOMVA: Double read FNF_TOTALBASECALCULOMVA write FNF_TOTALBASECALCULOMVA;
    const NF_TOTALBASECALCULOMVA_Name = 'NF_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOICMS: Double read FNF_TOTALBASECALCULOICMS write FNF_TOTALBASECALCULOICMS;
    const NF_TOTALBASECALCULOICMS_Name = 'NF_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('NF_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALCOMPLEMENTONFICMS: Double read FNF_TOTALCOMPLEMENTONFICMS write FNF_TOTALCOMPLEMENTONFICMS;
    const NF_TOTALCOMPLEMENTONFICMS_Name = 'NF_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('NF_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property NF_TOTALNUMEROVOLUMES: Integer read FNF_TOTALNUMEROVOLUMES write FNF_TOTALNUMEROVOLUMES;
    const NF_TOTALNUMEROVOLUMES_Name = 'NF_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NF_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('NF_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_NUMERACAOVOLUMES: String read FNF_NUMERACAOVOLUMES write FNF_NUMERACAOVOLUMES;
    const NF_NUMERACAOVOLUMES_Name = 'NF_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NF_INFCOMPLEMENTAR', ftString, 5000)]
    [Dictionary('NF_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_INFCOMPLEMENTAR: String read FNF_INFCOMPLEMENTAR write FNF_INFCOMPLEMENTAR;
    const NF_INFCOMPLEMENTAR_Name = 'NF_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('NF_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('NF_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_ESPECIEVOLUMES: String read FNF_ESPECIEVOLUMES write FNF_ESPECIEVOLUMES;
    const NF_ESPECIEVOLUMES_Name = 'NF_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NF_MARCAVOLUMES', ftString, 30)]
    [Dictionary('NF_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_MARCAVOLUMES: String read FNF_MARCAVOLUMES write FNF_MARCAVOLUMES;
    const NF_MARCAVOLUMES_Name = 'NF_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NF_INTEGRACAO', ftString, 20)]
    [Dictionary('NF_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_INTEGRACAO: String read FNF_INTEGRACAO write FNF_INTEGRACAO;
    const NF_INTEGRACAO_Name = 'NF_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('NF_INTEGRACAOLIVRO', ftString, 33)]
    [Dictionary('NF_INTEGRACAOLIVRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_INTEGRACAOLIVRO: String read FNF_INTEGRACAOLIVRO write FNF_INTEGRACAOLIVRO;
    const NF_INTEGRACAOLIVRO_Name = 'NF_INTEGRACAOLIVRO';

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
    [Column('NF_PLACAVEICULO', ftString, 7)]
    [Dictionary('NF_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_PLACAVEICULO: String read FNF_PLACAVEICULO write FNF_PLACAVEICULO;
    const NF_PLACAVEICULO_Name = 'NF_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('NF_UFVEICULO', ftString, 2)]
    [Dictionary('NF_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_UFVEICULO: String read FNF_UFVEICULO write FNF_UFVEICULO;
    const NF_UFVEICULO_Name = 'NF_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('NF_RNTRC', ftString, 14)]
    [Dictionary('NF_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_RNTRC: String read FNF_RNTRC write FNF_RNTRC;
    const NF_RNTRC_Name = 'NF_RNTRC';

    [Restrictions([NoValidate])]
    [Column('NF_STATUSNFe', ftString, 2)]
    [Dictionary('NF_STATUSNFe', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_STATUSNFe: String read FNF_STATUSNFe write FNF_STATUSNFe;
    const NF_STATUSNFe_Name = 'NF_STATUSNFe';

    [Restrictions([NoValidate])]
    [Column('NF_PORTEESTADUAL', ftString, 1)]
    [Dictionary('NF_PORTEESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_PORTEESTADUAL: String read FNF_PORTEESTADUAL write FNF_PORTEESTADUAL;
    const NF_PORTEESTADUAL_Name = 'NF_PORTEESTADUAL';

    [Restrictions([NoValidate])]
    [Column('NF_PORTEFEDERAL', ftString, 1)]
    [Dictionary('NF_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_PORTEFEDERAL: String read FNF_PORTEFEDERAL write FNF_PORTEFEDERAL;
    const NF_PORTEFEDERAL_Name = 'NF_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALISS', ftBCD)]
    [Dictionary('NF_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALISS: Double read FNF_TOTALISS write FNF_TOTALISS;
    const NF_TOTALISS_Name = 'NF_TOTALISS';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOISS', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOISS: Double read FNF_TOTALBASECALCULOISS write FNF_TOTALBASECALCULOISS;
    const NF_TOTALBASECALCULOISS_Name = 'NF_TOTALBASECALCULOISS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_PERCENTUALIBPT', ftBCD)]
    [Dictionary('NF_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALIBPT: Double read FNF_PERCENTUALIBPT write FNF_PERCENTUALIBPT;
    const NF_PERCENTUALIBPT_Name = 'NF_PERCENTUALIBPT';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('NF_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALAPROXIMADOIMPOSTO: Double read FNF_TOTALAPROXIMADOIMPOSTO write FNF_TOTALAPROXIMADOIMPOSTO;
    const NF_TOTALAPROXIMADOIMPOSTO_Name = 'NF_TOTALAPROXIMADOIMPOSTO';

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
    [Column('PES_CIDADE_ENTREGA', ftString, 100)]
    [Dictionary('PES_CIDADE_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_ENTREGA: String read FPES_CIDADE_ENTREGA write FPES_CIDADE_ENTREGA;
    const PES_CIDADE_ENTREGA_Name = 'PES_CIDADE_ENTREGA';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_ENTREGA', ftString, 7)]
    [Dictionary('CID_IBGE_ENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_ENTREGA: String read FCID_IBGE_ENTREGA write FCID_IBGE_ENTREGA;
    const CID_IBGE_ENTREGA_Name = 'CID_IBGE_ENTREGA';

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
    [Column('PES_CIDADE_RETIRADA', ftString, 100)]
    [Dictionary('PES_CIDADE_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_RETIRADA: String read FPES_CIDADE_RETIRADA write FPES_CIDADE_RETIRADA;
    const PES_CIDADE_RETIRADA_Name = 'PES_CIDADE_RETIRADA';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_RETIRADA', ftString, 7)]
    [Dictionary('CID_IBGE_RETIRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_RETIRADA: String read FCID_IBGE_RETIRADA write FCID_IBGE_RETIRADA;
    const CID_IBGE_RETIRADA_Name = 'CID_IBGE_RETIRADA';

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

    [Restrictions([NoValidate])]
    [Column('NF_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('NF_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_NUMEROORDEMCOMPRA: String read FNF_NUMEROORDEMCOMPRA write FNF_NUMEROORDEMCOMPRA;
    const NF_NUMEROORDEMCOMPRA_Name = 'NF_NUMEROORDEMCOMPRA';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('NF_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTMUNICIPAL: Double read FNF_TOTALIBPTMUNICIPAL write FNF_TOTALIBPTMUNICIPAL;
    const NF_TOTALIBPTMUNICIPAL_Name = 'NF_TOTALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('NF_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTESTADUAL: Double read FNF_TOTALIBPTESTADUAL write FNF_TOTALIBPTESTADUAL;
    const NF_TOTALIBPTESTADUAL_Name = 'NF_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('NF_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTNACIONAL: Double read FNF_TOTALIBPTNACIONAL write FNF_TOTALIBPTNACIONAL;
    const NF_TOTALIBPTNACIONAL_Name = 'NF_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('NF_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTIMPORTADO: Double read FNF_TOTALIBPTIMPORTADO write FNF_TOTALIBPTIMPORTADO;
    const NF_TOTALIBPTIMPORTADO_Name = 'NF_TOTALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOFCP', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOFCP: Double read FNF_TOTALBASECALCULOFCP write FNF_TOTALBASECALCULOFCP;
    const NF_TOTALBASECALCULOFCP_Name = 'NF_TOTALBASECALCULOFCP';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALFCP', ftBCD)]
    [Dictionary('NF_TOTALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFCP: Double read FNF_TOTALFCP write FNF_TOTALFCP;
    const NF_TOTALFCP_Name = 'NF_TOTALFCP';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOFCPST', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOFCPST: Double read FNF_TOTALBASECALCULOFCPST write FNF_TOTALBASECALCULOFCPST;
    const NF_TOTALBASECALCULOFCPST_Name = 'NF_TOTALBASECALCULOFCPST';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALFCPST', ftBCD, 48, 2)]
    [Dictionary('NF_TOTALFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFCPST: Double read FNF_TOTALFCPST write FNF_TOTALFCPST;
    const NF_TOTALFCPST_Name = 'NF_TOTALFCPST';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOFCPRET', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOFCPRET: Double read FNF_TOTALBASECALCULOFCPRET write FNF_TOTALBASECALCULOFCPRET;
    const NF_TOTALBASECALCULOFCPRET_Name = 'NF_TOTALBASECALCULOFCPRET';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALFCPRET', ftBCD)]
    [Dictionary('NF_TOTALFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFCPRET: Double read FNF_TOTALFCPRET write FNF_TOTALFCPRET;
    const NF_TOTALFCPRET_Name = 'NF_TOTALFCPRET';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALTROCO', ftBCD, 48, 2)]
    [Dictionary('NF_TOTALTROCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALTROCO: Double read FNF_TOTALTROCO write FNF_TOTALTROCO;
    const NF_TOTALTROCO_Name = 'NF_TOTALTROCO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_NOTASFISCAIS)

end.
