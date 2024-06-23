unit express.dbo.FAT_LIVROFISCAL;

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
  [Table('FAT_LivroFiscal', '')]
  TDtoFAT_LivroFiscal = class
  private
    { Private declarations } 
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FCGA_ID: Integer;
    FPES_CODIGO: Integer;
    FFAT_CPFCLIENTE: String;
    FFAT_NOMECLIENTE: String;
    FPES_NOME: String;
    FPES_CLIENTECONTRIBUINTENAOSIMPLES: String;
    FPES_UF: String;
    FFAT_NOTAFISCAL: String;
    FFAT_NOTAFISCALSERVICO: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_DATAENTREGA: TDateTime;
    FFAT_NUMEROORDEMCOMPRA: String;
    FTDC_CODIGO: String;
    FMNF_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FTRP_CODIGO: Integer;
    FFAT_SERIE: String;
    FFAT_EMITENTE: String;
    FFAT_TOTALFRETE: Double;
    FFAT_TOTALSEGURO: Double;
    FFAT_TOTALDESPACESSORIA: Double;
    FFAT_TOTALPIS: Double;
    FFAT_TOTALCOFINS: Double;
    FFAT_TOTALCOMPLEMENTONFICMS: Double;
    FFAT_TOTALSERVICO: Double;
    FFAT_TOTALDESCTO: Double;
    FFAT_TOTALLIQUIDO: Double;
    FFAT_TOTALPESOLIQUIDO: Double;
    FFAT_OBSERVACAO: String;
    FFAT_CANCELADA: String;
    FFAT_DESATIVADO: String;
    FFAT_TIPOFRETE: String;
    FFAT_TOTALIPI: Double;
    FFAT_TOTALICMS: Double;
    FFAT_TOTALICMSR: Double;
    FFAT_TOTALPRODUTOS: Double;
    FFAT_TOTALPESOBRUTO: Double;
    FFAT_TOTALBASEISENTOICMS: Double;
    FFAT_TOTALBASECALCULOICMS: Double;
    FFAT_TOTALBCALCULOPISCOFINS: Double;
    FFAT_TOTALBASECALCULOMVA: Double;
    FFAT_TOTALNUMEROVOLUMES: Double;
    FFAT_NUMERACAOVOLUMES: String;
    FFAT_ESPECIEVOLUMES: String;
    FFAT_MARCAVOLUMES: String;
    FFAT_INFCOMPLEMENTAR: String;
    FPES_TIPOPESSOA: String;
    FFAT_PLACAVEICULO: String;
    FFAT_UFVEICULO: String;
    FFAT_TOTALBASECALCULOISS: Double;
    FFAT_TOTALISS: Double;
    FFAT_INTEGRACAO: String;
    FPES_CODIGOENTREGA: Integer;
    FPES_CODIGORETIRADA: Integer;
    FFAT_TIPOPAGAMENTO: String;
    FPES_PONTOREFERENCIA: String;
    FFAT_PERCENTUALIBPT: Double;
    FFAT_TOTALAPROXIMADOIMPOSTO: Double;
    FFAT_TOTALIBPTMUNICIPAL: Double;
    FFAT_TOTALIBPTESTADUAL: Double;
    FFAT_TOTALIBPTNACIONAL: Double;
    FFAT_TOTALIBPTIMPORTADO: Double;
    FFAT_PERCENTUALIBPTMUNICIPAL: Double;
    FFAT_PERCENTUALIBPTESTADUAL: Double;
    FFAT_PERCENTUALIBPTNACIONAL: Double;
    FFAT_PERCENTUALIBPTIMPORTADO: Double;
    FFAT_TOTALBASECALCULOFCP: Double;
    FFAT_TOTALFCP: Double;
    FFAT_TOTALBASECALCULOFCPST: Double;
    FFAT_TOTALFCPST: Double;
    FFAT_TOTALBASECALCULOFCPRET: Double;
    FFAT_TOTALFCPRET: Double;
    FFAT_TOTALTROCO: Double;
    FFAT_TOTALICMSDESONERADO: Double;
    FFAT_RPS: Integer;
    FFAT_TOTALIR: Double;
    FFAT_TOTALINSS: Double;
    FFAT_TOTALCSLL: Double;
    FFAT_ISSRETIDO: String;
  public 
    { Public declarations } 
     const Table      = 'FAT_LivroFiscal';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_CPFCLIENTE', ftString, 11)]
    [Dictionary('FAT_CPFCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CPFCLIENTE: String read FFAT_CPFCLIENTE write FFAT_CPFCLIENTE;
    const FAT_CPFCLIENTE_Name = 'FAT_CPFCLIENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_NOMECLIENTE', ftString, 100)]
    [Dictionary('FAT_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOMECLIENTE: String read FFAT_NOMECLIENTE write FFAT_NOMECLIENTE;
    const FAT_NOMECLIENTE_Name = 'FAT_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTECONTRIBUINTENAOSIMPLES', ftString, 1)]
    [Dictionary('PES_CLIENTECONTRIBUINTENAOSIMPLES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CLIENTECONTRIBUINTENAOSIMPLES: String read FPES_CLIENTECONTRIBUINTENAOSIMPLES write FPES_CLIENTECONTRIBUINTENAOSIMPLES;
    const PES_CLIENTECONTRIBUINTENAOSIMPLES_Name = 'PES_CLIENTECONTRIBUINTENAOSIMPLES';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('FAT_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCALSERVICO: String read FFAT_NOTAFISCALSERVICO write FFAT_NOTAFISCALSERVICO;
    const FAT_NOTAFISCALSERVICO_Name = 'FAT_NOTAFISCALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAENTREGA', ftDateTime)]
    [Dictionary('FAT_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAENTREGA: TDateTime read FFAT_DATAENTREGA write FFAT_DATAENTREGA;
    const FAT_DATAENTREGA_Name = 'FAT_DATAENTREGA';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('FAT_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROORDEMCOMPRA: String read FFAT_NUMEROORDEMCOMPRA write FFAT_NUMEROORDEMCOMPRA;
    const FAT_NUMEROORDEMCOMPRA_Name = 'FAT_NUMEROORDEMCOMPRA';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_SERIE', ftString, 3)]
    [Dictionary('FAT_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SERIE: String read FFAT_SERIE write FFAT_SERIE;
    const FAT_SERIE_Name = 'FAT_SERIE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_EMITENTE', ftString, 1)]
    [Dictionary('FAT_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_EMITENTE: String read FFAT_EMITENTE write FFAT_EMITENTE;
    const FAT_EMITENTE_Name = 'FAT_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALFRETE', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFRETE: Double read FFAT_TOTALFRETE write FFAT_TOTALFRETE;
    const FAT_TOTALFRETE_Name = 'FAT_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALSEGURO', ftBCD)]
    [Dictionary('FAT_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSEGURO: Double read FFAT_TOTALSEGURO write FFAT_TOTALSEGURO;
    const FAT_TOTALSEGURO_Name = 'FAT_TOTALSEGURO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('FAT_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESPACESSORIA: Double read FFAT_TOTALDESPACESSORIA write FFAT_TOTALDESPACESSORIA;
    const FAT_TOTALDESPACESSORIA_Name = 'FAT_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPIS', ftBCD)]
    [Dictionary('FAT_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPIS: Double read FFAT_TOTALPIS write FFAT_TOTALPIS;
    const FAT_TOTALPIS_Name = 'FAT_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALCOFINS', ftBCD)]
    [Dictionary('FAT_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOFINS: Double read FFAT_TOTALCOFINS write FFAT_TOTALCOFINS;
    const FAT_TOTALCOFINS_Name = 'FAT_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('FAT_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMPLEMENTONFICMS: Double read FFAT_TOTALCOMPLEMENTONFICMS write FFAT_TOTALCOMPLEMENTONFICMS;
    const FAT_TOTALCOMPLEMENTONFICMS_Name = 'FAT_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSERVICO', ftBCD)]
    [Dictionary('FAT_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSERVICO: Double read FFAT_TOTALSERVICO write FFAT_TOTALSERVICO;
    const FAT_TOTALSERVICO_Name = 'FAT_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTO', ftBCD)]
    [Dictionary('FAT_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTO: Double read FFAT_TOTALDESCTO write FFAT_TOTALDESCTO;
    const FAT_TOTALDESCTO_Name = 'FAT_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALLIQUIDO', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('FAT_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPESOLIQUIDO: Double read FFAT_TOTALPESOLIQUIDO write FFAT_TOTALPESOLIQUIDO;
    const FAT_TOTALPESOLIQUIDO_Name = 'FAT_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAO', ftString, 5000)]
    [Dictionary('FAT_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAO: String read FFAT_OBSERVACAO write FFAT_OBSERVACAO;
    const FAT_OBSERVACAO_Name = 'FAT_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DESATIVADO', ftString, 1)]
    [Dictionary('FAT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESATIVADO: String read FFAT_DESATIVADO write FFAT_DESATIVADO;
    const FAT_DESATIVADO_Name = 'FAT_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPOFRETE', ftString, 1)]
    [Dictionary('FAT_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOFRETE: String read FFAT_TIPOFRETE write FFAT_TIPOFRETE;
    const FAT_TIPOFRETE_Name = 'FAT_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALIPI', ftBCD)]
    [Dictionary('FAT_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIPI: Double read FFAT_TOTALIPI write FFAT_TOTALIPI;
    const FAT_TOTALIPI_Name = 'FAT_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALICMS', ftBCD)]
    [Dictionary('FAT_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMS: Double read FFAT_TOTALICMS write FFAT_TOTALICMS;
    const FAT_TOTALICMS_Name = 'FAT_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALICMSR', ftBCD)]
    [Dictionary('FAT_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSR: Double read FFAT_TOTALICMSR write FFAT_TOTALICMSR;
    const FAT_TOTALICMSR_Name = 'FAT_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPRODUTOS', ftBCD, 10, 2)]
    [Dictionary('FAT_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRODUTOS: Double read FFAT_TOTALPRODUTOS write FFAT_TOTALPRODUTOS;
    const FAT_TOTALPRODUTOS_Name = 'FAT_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('FAT_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPESOBRUTO: Double read FFAT_TOTALPESOBRUTO write FFAT_TOTALPESOBRUTO;
    const FAT_TOTALPESOBRUTO_Name = 'FAT_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('FAT_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASEISENTOICMS: Double read FFAT_TOTALBASEISENTOICMS write FFAT_TOTALBASEISENTOICMS;
    const FAT_TOTALBASEISENTOICMS_Name = 'FAT_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOICMS: Double read FFAT_TOTALBASECALCULOICMS write FFAT_TOTALBASECALCULOICMS;
    const FAT_TOTALBASECALCULOICMS_Name = 'FAT_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('FAT_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBCALCULOPISCOFINS: Double read FFAT_TOTALBCALCULOPISCOFINS write FFAT_TOTALBCALCULOPISCOFINS;
    const FAT_TOTALBCALCULOPISCOFINS_Name = 'FAT_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOMVA: Double read FFAT_TOTALBASECALCULOMVA write FFAT_TOTALBASECALCULOMVA;
    const FAT_TOTALBASECALCULOMVA_Name = 'FAT_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('FAT_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALNUMEROVOLUMES: Double read FFAT_TOTALNUMEROVOLUMES write FFAT_TOTALNUMEROVOLUMES;
    const FAT_TOTALNUMEROVOLUMES_Name = 'FAT_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('FAT_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERACAOVOLUMES: String read FFAT_NUMERACAOVOLUMES write FFAT_NUMERACAOVOLUMES;
    const FAT_NUMERACAOVOLUMES_Name = 'FAT_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('FAT_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('FAT_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_ESPECIEVOLUMES: String read FFAT_ESPECIEVOLUMES write FFAT_ESPECIEVOLUMES;
    const FAT_ESPECIEVOLUMES_Name = 'FAT_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('FAT_MARCAVOLUMES', ftString, 30)]
    [Dictionary('FAT_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_MARCAVOLUMES: String read FFAT_MARCAVOLUMES write FFAT_MARCAVOLUMES;
    const FAT_MARCAVOLUMES_Name = 'FAT_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('FAT_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('FAT_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INFCOMPLEMENTAR: String read FFAT_INFCOMPLEMENTAR write FFAT_INFCOMPLEMENTAR;
    const FAT_INFCOMPLEMENTAR_Name = 'FAT_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('FAT_PLACAVEICULO', ftString, 7)]
    [Dictionary('FAT_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_PLACAVEICULO: String read FFAT_PLACAVEICULO write FFAT_PLACAVEICULO;
    const FAT_PLACAVEICULO_Name = 'FAT_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_UFVEICULO', ftString, 2)]
    [Dictionary('FAT_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_UFVEICULO: String read FFAT_UFVEICULO write FFAT_UFVEICULO;
    const FAT_UFVEICULO_Name = 'FAT_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOISS', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOISS: Double read FFAT_TOTALBASECALCULOISS write FFAT_TOTALBASECALCULOISS;
    const FAT_TOTALBASECALCULOISS_Name = 'FAT_TOTALBASECALCULOISS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALISS', ftBCD)]
    [Dictionary('FAT_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALISS: Double read FFAT_TOTALISS write FFAT_TOTALISS;
    const FAT_TOTALISS_Name = 'FAT_TOTALISS';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO', ftString, 20)]
    [Dictionary('FAT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO: String read FFAT_INTEGRACAO write FFAT_INTEGRACAO;
    const FAT_INTEGRACAO_Name = 'FAT_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOENTREGA', ftInteger)]
    [Dictionary('PES_CODIGOENTREGA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOENTREGA: Integer read FPES_CODIGOENTREGA write FPES_CODIGOENTREGA;
    const PES_CODIGOENTREGA_Name = 'PES_CODIGOENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGORETIRADA', ftInteger)]
    [Dictionary('PES_CODIGORETIRADA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGORETIRADA: Integer read FPES_CODIGORETIRADA write FPES_CODIGORETIRADA;
    const PES_CODIGORETIRADA_Name = 'PES_CODIGORETIRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPOPAGAMENTO', ftString, 1)]
    [Dictionary('FAT_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOPAGAMENTO: String read FFAT_TIPOPAGAMENTO write FFAT_TIPOPAGAMENTO;
    const FAT_TIPOPAGAMENTO_Name = 'FAT_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA: String read FPES_PONTOREFERENCIA write FPES_PONTOREFERENCIA;
    const PES_PONTOREFERENCIA_Name = 'PES_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPT', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPT: Double read FFAT_PERCENTUALIBPT write FFAT_PERCENTUALIBPT;
    const FAT_PERCENTUALIBPT_Name = 'FAT_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('FAT_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALAPROXIMADOIMPOSTO: Double read FFAT_TOTALAPROXIMADOIMPOSTO write FFAT_TOTALAPROXIMADOIMPOSTO;
    const FAT_TOTALAPROXIMADOIMPOSTO_Name = 'FAT_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('FAT_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTMUNICIPAL: Double read FFAT_TOTALIBPTMUNICIPAL write FFAT_TOTALIBPTMUNICIPAL;
    const FAT_TOTALIBPTMUNICIPAL_Name = 'FAT_TOTALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('FAT_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTESTADUAL: Double read FFAT_TOTALIBPTESTADUAL write FFAT_TOTALIBPTESTADUAL;
    const FAT_TOTALIBPTESTADUAL_Name = 'FAT_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('FAT_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTNACIONAL: Double read FFAT_TOTALIBPTNACIONAL write FFAT_TOTALIBPTNACIONAL;
    const FAT_TOTALIBPTNACIONAL_Name = 'FAT_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('FAT_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTIMPORTADO: Double read FFAT_TOTALIBPTIMPORTADO write FFAT_TOTALIBPTIMPORTADO;
    const FAT_TOTALIBPTIMPORTADO_Name = 'FAT_TOTALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTMUNICIPAL: Double read FFAT_PERCENTUALIBPTMUNICIPAL write FFAT_PERCENTUALIBPTMUNICIPAL;
    const FAT_PERCENTUALIBPTMUNICIPAL_Name = 'FAT_PERCENTUALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTESTADUAL: Double read FFAT_PERCENTUALIBPTESTADUAL write FFAT_PERCENTUALIBPTESTADUAL;
    const FAT_PERCENTUALIBPTESTADUAL_Name = 'FAT_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTNACIONAL: Double read FFAT_PERCENTUALIBPTNACIONAL write FFAT_PERCENTUALIBPTNACIONAL;
    const FAT_PERCENTUALIBPTNACIONAL_Name = 'FAT_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTIMPORTADO', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTIMPORTADO: Double read FFAT_PERCENTUALIBPTIMPORTADO write FFAT_PERCENTUALIBPTIMPORTADO;
    const FAT_PERCENTUALIBPTIMPORTADO_Name = 'FAT_PERCENTUALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCP', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCP: Double read FFAT_TOTALBASECALCULOFCP write FFAT_TOTALBASECALCULOFCP;
    const FAT_TOTALBASECALCULOFCP_Name = 'FAT_TOTALBASECALCULOFCP';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCP', ftBCD)]
    [Dictionary('FAT_TOTALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCP: Double read FFAT_TOTALFCP write FFAT_TOTALFCP;
    const FAT_TOTALFCP_Name = 'FAT_TOTALFCP';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCPST', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCPST: Double read FFAT_TOTALBASECALCULOFCPST write FFAT_TOTALBASECALCULOFCPST;
    const FAT_TOTALBASECALCULOFCPST_Name = 'FAT_TOTALBASECALCULOFCPST';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCPST', ftBCD)]
    [Dictionary('FAT_TOTALFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCPST: Double read FFAT_TOTALFCPST write FFAT_TOTALFCPST;
    const FAT_TOTALFCPST_Name = 'FAT_TOTALFCPST';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCPRET', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCPRET: Double read FFAT_TOTALBASECALCULOFCPRET write FFAT_TOTALBASECALCULOFCPRET;
    const FAT_TOTALBASECALCULOFCPRET_Name = 'FAT_TOTALBASECALCULOFCPRET';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCPRET', ftBCD)]
    [Dictionary('FAT_TOTALFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCPRET: Double read FFAT_TOTALFCPRET write FFAT_TOTALFCPRET;
    const FAT_TOTALFCPRET_Name = 'FAT_TOTALFCPRET';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALTROCO', ftBCD)]
    [Dictionary('FAT_TOTALTROCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALTROCO: Double read FFAT_TOTALTROCO write FFAT_TOTALTROCO;
    const FAT_TOTALTROCO_Name = 'FAT_TOTALTROCO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSDESONERADO', ftBCD)]
    [Dictionary('FAT_TOTALICMSDESONERADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSDESONERADO: Double read FFAT_TOTALICMSDESONERADO write FFAT_TOTALICMSDESONERADO;
    const FAT_TOTALICMSDESONERADO_Name = 'FAT_TOTALICMSDESONERADO';

    [Restrictions([NoValidate])]
    [Column('FAT_RPS', ftInteger)]
    [Dictionary('FAT_RPS', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_RPS: Integer read FFAT_RPS write FFAT_RPS;
    const FAT_RPS_Name = 'FAT_RPS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIR', ftBCD)]
    [Dictionary('FAT_TOTALIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIR: Double read FFAT_TOTALIR write FFAT_TOTALIR;
    const FAT_TOTALIR_Name = 'FAT_TOTALIR';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALINSS', ftBCD)]
    [Dictionary('FAT_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALINSS: Double read FFAT_TOTALINSS write FFAT_TOTALINSS;
    const FAT_TOTALINSS_Name = 'FAT_TOTALINSS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCSLL', ftBCD)]
    [Dictionary('FAT_TOTALCSLL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCSLL: Double read FFAT_TOTALCSLL write FFAT_TOTALCSLL;
    const FAT_TOTALCSLL_Name = 'FAT_TOTALCSLL';

    [Restrictions([NoValidate])]
    [Column('FAT_ISSRETIDO', ftString, 1)]
    [Dictionary('FAT_ISSRETIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_ISSRETIDO: String read FFAT_ISSRETIDO write FFAT_ISSRETIDO;
    const FAT_ISSRETIDO_Name = 'FAT_ISSRETIDO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_LivroFiscal)

end.
