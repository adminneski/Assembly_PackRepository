unit express.dbo.LFS_00;

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
  [Table('LFS_00', '')]
  [PrimaryKey('LFS_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_ID')]
  TDtoLFS_00 = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFG_PORTEFEDERAL: String;
    FCFG_PORTEESTADUAL: String;
    FCGA_ID: Integer;
    FPES_CODIGO: Integer;
    FLFS_CPFCLIENTE: String;
    FLFS_NOMECLIENTE: String;
    FLFS_SERIE: String;
    FLFS_NOTAFISCAL: String;
    FLFS_FINALIDADE: String;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FLFS_UFVEICULO: String;
    FLFS_PLACAVEICULO: String;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
    FCST_CODIGOCTR: String;
    FCSTPC_CODIGO: String;
    FLFS_EMITENTE: String;
    FLFS_STATUSNFE: String;
    FLFS_DATASAIDA: TDateTime;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_DATALANCAMENTO: TDateTime;
    FLFS_TOTALIPI: Double;
    FLFS_TOTALPIS: Double;
    FLFS_TOTALISS: Double;
    FLFS_TOTALICMS: Double;
    FLFS_TIPOFRETE: String;
    FLFS_TOTALICMSR: Double;
    FLFS_TOTALCOFINS: Double;
    FLFS_TOTALSEGURO: Double;
    FLFS_TOTALDESCTO: Double;
    FLFS_TOTALSERVICO: Double;
    FLFS_TOTALFRETENF: Double;
    FLFS_TOTALPRODUTOS: Double;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_TOTALPESOBRUTO: Double;
    FLFS_TOTALPESOLIQUIDO: Double;
    FLFS_TOTALDESPACESSORIA: Double;
    FLFS_TOTALBASEISENTOICMS: Double;
    FLFS_TOTALBASECALCULOMVA: Double;
    FLFS_TOTALBASECALCULOICMS: Double;
    FLFS_TOTALCOMPLEMENTONFICMS: Double;
    FLFS_TOTALBASECALCULOISS: Double;
    FLFS_TOTALNUMEROVOLUMES: Integer;
    FLFS_TOTALBCALCULOPISCOFINS: Double;
    FLFS_TOTALAPROXIMADOIMPOSTO: Double;
    FLFS_NUMERACAOVOLUMES: String;
    FLFS_INFCOMPLEMENTAR: String;
    FLFS_ESPECIEVOLUMES: String;
    FLFS_MARCAVOLUMES: String;
    FLFS_CHAVEREFERENCIANFE: TBlob;
    FLFS_NUMEROORDEMCOMPRA: String;
    FLFS_CHAVEACESSO: String;
    FLFS_TIPONOTAFISCAL: String;
    FPES_CODIGOENTREGA: Integer;
    FPES_CODIGORETIRADA: Integer;
    FLFS_XMLNFEGERADO: String;
    FLFS_TIPOPAGAMENTO: String;
    FLFS_PISCOFINSCTR: String;
    FLFS_PERCENTUALPIS: Double;
    FLFS_PERCENTUALCOFINS: Double;
    FLFS_PERCENTUALIBPT: Double;
    FLFS_NOTAFISCALRETIDAFONTE: String;
    FLFS_PERIODORETENCAO: String;
    FLFS_TOTALIBPTMUNICIPAL: Double;
    FLFS_TOTALIBPTESTADUAL: Double;
    FLFS_TOTALIBPTNACIONAL: Double;
    FLFS_TOTALIBPTIMPORTADO: Double;
    FLFS_PERCENTUALIBPTMUNICIPAL: Double;
    FLFS_PERCENTUALIBPTESTADUAL: Double;
    FLFS_PERCENTUALIBPTNACIONAL: Double;
    FLFS_PERCENTUALIBPTIMPORTADO: Double;
    FLFS_RNTRC: String;
    FLFS_TOTALBASECALCULOFCP: Double;
    FLFS_TOTALFCP: Double;
    FLFS_TOTALBASECALCULOFCPST: Double;
    FLFS_TOTALFCPST: Double;
    FLFS_TOTALBASECALCULOFCPRET: Double;
    FLFS_TOTALFCPRET: Double;
    FLFS_TOTALTROCO: Double;
    FLFS_OBSERVACAO: String;
    FLFS_DENEGADA: String;
    FLFS_CANCELADO: String;
    FLFS_DESATIVADO: String;
    FLFS_INTEGRACAO: String;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_RPS: Integer;
    FLFS_ID_OLD: Integer;
    FLFS_INTEGRACAO_OLD: String;
    FCGA_ID_OLD: Integer;
    FLFS_QUANTIDADECARGA: Double;
    FLFS_UNIDADEMEDIDACARGA: String;
    FLFS_TOTALIR: Double;
    FLFS_TOTALINSS: Double;
    FLFS_TOTALCSLL: Double;
    FLFS_ISSRETIDO: String;
    FLFS_TOTALICMSDESONERADO: Double;
  public 
    { Public declarations } 
     const Table      = 'LFS_00';
     const PrimaryKey = 'LFS_ID';
     const Sequence   = 'SEQ_LFS_ID';

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
    [Column('CFG_PORTEFEDERAL', ftString, 1)]
    [Dictionary('CFG_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PORTEFEDERAL: String read FCFG_PORTEFEDERAL write FCFG_PORTEFEDERAL;
    const CFG_PORTEFEDERAL_Name = 'CFG_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('CFG_PORTEESTADUAL', ftString, 1)]
    [Dictionary('CFG_PORTEESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PORTEESTADUAL: String read FCFG_PORTEESTADUAL write FCFG_PORTEESTADUAL;
    const CFG_PORTEESTADUAL_Name = 'CFG_PORTEESTADUAL';

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
    [Column('LFS_CPFCLIENTE', ftString, 11)]
    [Dictionary('LFS_CPFCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CPFCLIENTE: String read FLFS_CPFCLIENTE write FLFS_CPFCLIENTE;
    const LFS_CPFCLIENTE_Name = 'LFS_CPFCLIENTE';

    [Restrictions([NoValidate])]
    [Column('LFS_NOMECLIENTE', ftString, 100)]
    [Dictionary('LFS_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOMECLIENTE: String read FLFS_NOMECLIENTE write FLFS_NOMECLIENTE;
    const LFS_NOMECLIENTE_Name = 'LFS_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIE', ftString, 3)]
    [Dictionary('LFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIE: String read FLFS_SERIE write FLFS_SERIE;
    const LFS_SERIE_Name = 'LFS_SERIE';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_FINALIDADE', ftString, 1)]
    [Dictionary('LFS_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_FINALIDADE: String read FLFS_FINALIDADE write FLFS_FINALIDADE;
    const LFS_FINALIDADE_Name = 'LFS_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

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
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOCTR', ftString, 2)]
    [Dictionary('CST_CODIGOCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOCTR: String read FCST_CODIGOCTR write FCST_CODIGOCTR;
    const CST_CODIGOCTR_Name = 'CST_CODIGOCTR';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_EMITENTE', ftString, 50)]
    [Dictionary('LFS_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_EMITENTE: String read FLFS_EMITENTE write FLFS_EMITENTE;
    const LFS_EMITENTE_Name = 'LFS_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('LFS_STATUSNFE', ftString, 2)]
    [Dictionary('LFS_STATUSNFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_STATUSNFE: String read FLFS_STATUSNFE write FLFS_STATUSNFE;
    const LFS_STATUSNFE_Name = 'LFS_STATUSNFE';

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
    [Column('LFS_TOTALIPI', ftBCD)]
    [Dictionary('LFS_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIPI: Double read FLFS_TOTALIPI write FLFS_TOTALIPI;
    const LFS_TOTALIPI_Name = 'LFS_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALPIS', ftBCD)]
    [Dictionary('LFS_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPIS: Double read FLFS_TOTALPIS write FLFS_TOTALPIS;
    const LFS_TOTALPIS_Name = 'LFS_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALISS', ftBCD)]
    [Dictionary('LFS_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALISS: Double read FLFS_TOTALISS write FLFS_TOTALISS;
    const LFS_TOTALISS_Name = 'LFS_TOTALISS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMS', ftBCD)]
    [Dictionary('LFS_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMS: Double read FLFS_TOTALICMS write FLFS_TOTALICMS;
    const LFS_TOTALICMS_Name = 'LFS_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOFRETE', ftString, 1)]
    [Dictionary('LFS_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOFRETE: String read FLFS_TIPOFRETE write FLFS_TIPOFRETE;
    const LFS_TIPOFRETE_Name = 'LFS_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSR', ftBCD)]
    [Dictionary('LFS_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSR: Double read FLFS_TOTALICMSR write FLFS_TOTALICMSR;
    const LFS_TOTALICMSR_Name = 'LFS_TOTALICMSR';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALCOFINS', ftBCD)]
    [Dictionary('LFS_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOFINS: Double read FLFS_TOTALCOFINS write FLFS_TOTALCOFINS;
    const LFS_TOTALCOFINS_Name = 'LFS_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALSEGURO', ftBCD)]
    [Dictionary('LFS_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSEGURO: Double read FLFS_TOTALSEGURO write FLFS_TOTALSEGURO;
    const LFS_TOTALSEGURO_Name = 'LFS_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALDESCTO', ftBCD)]
    [Dictionary('LFS_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESCTO: Double read FLFS_TOTALDESCTO write FLFS_TOTALDESCTO;
    const LFS_TOTALDESCTO_Name = 'LFS_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALSERVICO', ftBCD)]
    [Dictionary('LFS_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSERVICO: Double read FLFS_TOTALSERVICO write FLFS_TOTALSERVICO;
    const LFS_TOTALSERVICO_Name = 'LFS_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALFRETENF', ftBCD)]
    [Dictionary('LFS_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFRETENF: Double read FLFS_TOTALFRETENF write FLFS_TOTALFRETENF;
    const LFS_TOTALFRETENF_Name = 'LFS_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPRODUTOS', ftBCD)]
    [Dictionary('LFS_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPRODUTOS: Double read FLFS_TOTALPRODUTOS write FLFS_TOTALPRODUTOS;
    const LFS_TOTALPRODUTOS_Name = 'LFS_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('LFS_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPESOBRUTO: Double read FLFS_TOTALPESOBRUTO write FLFS_TOTALPESOBRUTO;
    const LFS_TOTALPESOBRUTO_Name = 'LFS_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('LFS_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPESOLIQUIDO: Double read FLFS_TOTALPESOLIQUIDO write FLFS_TOTALPESOLIQUIDO;
    const LFS_TOTALPESOLIQUIDO_Name = 'LFS_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('LFS_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESPACESSORIA: Double read FLFS_TOTALDESPACESSORIA write FLFS_TOTALDESPACESSORIA;
    const LFS_TOTALDESPACESSORIA_Name = 'LFS_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASEISENTOICMS', ftBCD, 66256176, 2)]
    [Dictionary('LFS_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASEISENTOICMS: Double read FLFS_TOTALBASEISENTOICMS write FLFS_TOTALBASEISENTOICMS;
    const LFS_TOTALBASEISENTOICMS_Name = 'LFS_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOMVA: Double read FLFS_TOTALBASECALCULOMVA write FLFS_TOTALBASECALCULOMVA;
    const LFS_TOTALBASECALCULOMVA_Name = 'LFS_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOICMS', ftBCD, 1650, 2)]
    [Dictionary('LFS_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOICMS: Double read FLFS_TOTALBASECALCULOICMS write FLFS_TOTALBASECALCULOICMS;
    const LFS_TOTALBASECALCULOICMS_Name = 'LFS_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('LFS_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOMPLEMENTONFICMS: Double read FLFS_TOTALCOMPLEMENTONFICMS write FLFS_TOTALCOMPLEMENTONFICMS;
    const LFS_TOTALCOMPLEMENTONFICMS_Name = 'LFS_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOISS', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOISS: Double read FLFS_TOTALBASECALCULOISS write FLFS_TOTALBASECALCULOISS;
    const LFS_TOTALBASECALCULOISS_Name = 'LFS_TOTALBASECALCULOISS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('LFS_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_TOTALNUMEROVOLUMES: Integer read FLFS_TOTALNUMEROVOLUMES write FLFS_TOTALNUMEROVOLUMES;
    const LFS_TOTALNUMEROVOLUMES_Name = 'LFS_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('LFS_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBCALCULOPISCOFINS: Double read FLFS_TOTALBCALCULOPISCOFINS write FLFS_TOTALBCALCULOPISCOFINS;
    const LFS_TOTALBCALCULOPISCOFINS_Name = 'LFS_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('LFS_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALAPROXIMADOIMPOSTO: Double read FLFS_TOTALAPROXIMADOIMPOSTO write FLFS_TOTALAPROXIMADOIMPOSTO;
    const LFS_TOTALAPROXIMADOIMPOSTO_Name = 'LFS_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('LFS_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMERACAOVOLUMES: String read FLFS_NUMERACAOVOLUMES write FLFS_NUMERACAOVOLUMES;
    const LFS_NUMERACAOVOLUMES_Name = 'LFS_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_INFCOMPLEMENTAR', ftString, 5000)]
    [Dictionary('LFS_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_INFCOMPLEMENTAR: String read FLFS_INFCOMPLEMENTAR write FLFS_INFCOMPLEMENTAR;
    const LFS_INFCOMPLEMENTAR_Name = 'LFS_INFCOMPLEMENTAR';

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
    [Column('LFS_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('LFS_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEREFERENCIANFE: TBlob read FLFS_CHAVEREFERENCIANFE write FLFS_CHAVEREFERENCIANFE;
    const LFS_CHAVEREFERENCIANFE_Name = 'LFS_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('LFS_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROORDEMCOMPRA: String read FLFS_NUMEROORDEMCOMPRA write FLFS_NUMEROORDEMCOMPRA;
    const LFS_NUMEROORDEMCOMPRA_Name = 'LFS_NUMEROORDEMCOMPRA';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSO: String read FLFS_CHAVEACESSO write FLFS_CHAVEACESSO;
    const LFS_CHAVEACESSO_Name = 'LFS_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPONOTAFISCAL', ftString, 4)]
    [Dictionary('LFS_TIPONOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPONOTAFISCAL: String read FLFS_TIPONOTAFISCAL write FLFS_TIPONOTAFISCAL;
    const LFS_TIPONOTAFISCAL_Name = 'LFS_TIPONOTAFISCAL';

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

    [Restrictions([NoValidate])]
    [Column('LFS_XMLNFEGERADO', ftString, 1)]
    [Dictionary('LFS_XMLNFEGERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_XMLNFEGERADO: String read FLFS_XMLNFEGERADO write FLFS_XMLNFEGERADO;
    const LFS_XMLNFEGERADO_Name = 'LFS_XMLNFEGERADO';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOPAGAMENTO', ftString, 1)]
    [Dictionary('LFS_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOPAGAMENTO: String read FLFS_TIPOPAGAMENTO write FLFS_TIPOPAGAMENTO;
    const LFS_TIPOPAGAMENTO_Name = 'LFS_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_PISCOFINSCTR', ftString, 2)]
    [Dictionary('LFS_PISCOFINSCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_PISCOFINSCTR: String read FLFS_PISCOFINSCTR write FLFS_PISCOFINSCTR;
    const LFS_PISCOFINSCTR_Name = 'LFS_PISCOFINSCTR';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALPIS', ftBCD)]
    [Dictionary('LFS_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALPIS: Double read FLFS_PERCENTUALPIS write FLFS_PERCENTUALPIS;
    const LFS_PERCENTUALPIS_Name = 'LFS_PERCENTUALPIS';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALCOFINS', ftBCD)]
    [Dictionary('LFS_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALCOFINS: Double read FLFS_PERCENTUALCOFINS write FLFS_PERCENTUALCOFINS;
    const LFS_PERCENTUALCOFINS_Name = 'LFS_PERCENTUALCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPT', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPT: Double read FLFS_PERCENTUALIBPT write FLFS_PERCENTUALIBPT;
    const LFS_PERCENTUALIBPT_Name = 'LFS_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCALRETIDAFONTE', ftString, 1)]
    [Dictionary('LFS_NOTAFISCALRETIDAFONTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCALRETIDAFONTE: String read FLFS_NOTAFISCALRETIDAFONTE write FLFS_NOTAFISCALRETIDAFONTE;
    const LFS_NOTAFISCALRETIDAFONTE_Name = 'LFS_NOTAFISCALRETIDAFONTE';

    [Restrictions([NoValidate])]
    [Column('LFS_PERIODORETENCAO', ftString, 6)]
    [Dictionary('LFS_PERIODORETENCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_PERIODORETENCAO: String read FLFS_PERIODORETENCAO write FLFS_PERIODORETENCAO;
    const LFS_PERIODORETENCAO_Name = 'LFS_PERIODORETENCAO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('LFS_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTMUNICIPAL: Double read FLFS_TOTALIBPTMUNICIPAL write FLFS_TOTALIBPTMUNICIPAL;
    const LFS_TOTALIBPTMUNICIPAL_Name = 'LFS_TOTALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('LFS_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTESTADUAL: Double read FLFS_TOTALIBPTESTADUAL write FLFS_TOTALIBPTESTADUAL;
    const LFS_TOTALIBPTESTADUAL_Name = 'LFS_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('LFS_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTNACIONAL: Double read FLFS_TOTALIBPTNACIONAL write FLFS_TOTALIBPTNACIONAL;
    const LFS_TOTALIBPTNACIONAL_Name = 'LFS_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('LFS_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTIMPORTADO: Double read FLFS_TOTALIBPTIMPORTADO write FLFS_TOTALIBPTIMPORTADO;
    const LFS_TOTALIBPTIMPORTADO_Name = 'LFS_TOTALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTMUNICIPAL: Double read FLFS_PERCENTUALIBPTMUNICIPAL write FLFS_PERCENTUALIBPTMUNICIPAL;
    const LFS_PERCENTUALIBPTMUNICIPAL_Name = 'LFS_PERCENTUALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTESTADUAL: Double read FLFS_PERCENTUALIBPTESTADUAL write FLFS_PERCENTUALIBPTESTADUAL;
    const LFS_PERCENTUALIBPTESTADUAL_Name = 'LFS_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTNACIONAL: Double read FLFS_PERCENTUALIBPTNACIONAL write FLFS_PERCENTUALIBPTNACIONAL;
    const LFS_PERCENTUALIBPTNACIONAL_Name = 'LFS_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTIMPORTADO', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTIMPORTADO: Double read FLFS_PERCENTUALIBPTIMPORTADO write FLFS_PERCENTUALIBPTIMPORTADO;
    const LFS_PERCENTUALIBPTIMPORTADO_Name = 'LFS_PERCENTUALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('LFS_RNTRC', ftString, 14)]
    [Dictionary('LFS_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_RNTRC: String read FLFS_RNTRC write FLFS_RNTRC;
    const LFS_RNTRC_Name = 'LFS_RNTRC';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOFCP', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOFCP: Double read FLFS_TOTALBASECALCULOFCP write FLFS_TOTALBASECALCULOFCP;
    const LFS_TOTALBASECALCULOFCP_Name = 'LFS_TOTALBASECALCULOFCP';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFCP', ftBCD)]
    [Dictionary('LFS_TOTALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFCP: Double read FLFS_TOTALFCP write FLFS_TOTALFCP;
    const LFS_TOTALFCP_Name = 'LFS_TOTALFCP';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOFCPST', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOFCPST: Double read FLFS_TOTALBASECALCULOFCPST write FLFS_TOTALBASECALCULOFCPST;
    const LFS_TOTALBASECALCULOFCPST_Name = 'LFS_TOTALBASECALCULOFCPST';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFCPST', ftBCD)]
    [Dictionary('LFS_TOTALFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFCPST: Double read FLFS_TOTALFCPST write FLFS_TOTALFCPST;
    const LFS_TOTALFCPST_Name = 'LFS_TOTALFCPST';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOFCPRET', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOFCPRET: Double read FLFS_TOTALBASECALCULOFCPRET write FLFS_TOTALBASECALCULOFCPRET;
    const LFS_TOTALBASECALCULOFCPRET_Name = 'LFS_TOTALBASECALCULOFCPRET';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFCPRET', ftBCD)]
    [Dictionary('LFS_TOTALFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFCPRET: Double read FLFS_TOTALFCPRET write FLFS_TOTALFCPRET;
    const LFS_TOTALFCPRET_Name = 'LFS_TOTALFCPRET';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALTROCO', ftBCD, 10, 2)]
    [Dictionary('LFS_TOTALTROCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALTROCO: Double read FLFS_TOTALTROCO write FLFS_TOTALTROCO;
    const LFS_TOTALTROCO_Name = 'LFS_TOTALTROCO';

    [Restrictions([NoValidate])]
    [Column('LFS_OBSERVACAO', ftString, 5000)]
    [Dictionary('LFS_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_OBSERVACAO: String read FLFS_OBSERVACAO write FLFS_OBSERVACAO;
    const LFS_OBSERVACAO_Name = 'LFS_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DENEGADA', ftString, 1)]
    [Dictionary('LFS_DENEGADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_DENEGADA: String read FLFS_DENEGADA write FLFS_DENEGADA;
    const LFS_DENEGADA_Name = 'LFS_DENEGADA';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_RPS', ftInteger)]
    [Dictionary('LFS_RPS', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_RPS: Integer read FLFS_RPS write FLFS_RPS;
    const LFS_RPS_Name = 'LFS_RPS';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('LFS_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_INTEGRACAO_OLD: String read FLFS_INTEGRACAO_OLD write FLFS_INTEGRACAO_OLD;
    const LFS_INTEGRACAO_OLD_Name = 'LFS_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('CGA_ID_OLD', ftInteger)]
    [Dictionary('CGA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID_OLD: Integer read FCGA_ID_OLD write FCGA_ID_OLD;
    const CGA_ID_OLD_Name = 'CGA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_QUANTIDADECARGA', ftBCD, 18, 4)]
    [Dictionary('LFS_QUANTIDADECARGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_QUANTIDADECARGA: Double read FLFS_QUANTIDADECARGA write FLFS_QUANTIDADECARGA;
    const LFS_QUANTIDADECARGA_Name = 'LFS_QUANTIDADECARGA';

    [Restrictions([NoValidate])]
    [Column('LFS_UNIDADEMEDIDACARGA', ftString, 2)]
    [Dictionary('LFS_UNIDADEMEDIDACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UNIDADEMEDIDACARGA: String read FLFS_UNIDADEMEDIDACARGA write FLFS_UNIDADEMEDIDACARGA;
    const LFS_UNIDADEMEDIDACARGA_Name = 'LFS_UNIDADEMEDIDACARGA';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIR', ftBCD)]
    [Dictionary('LFS_TOTALIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIR: Double read FLFS_TOTALIR write FLFS_TOTALIR;
    const LFS_TOTALIR_Name = 'LFS_TOTALIR';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALINSS', ftBCD)]
    [Dictionary('LFS_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALINSS: Double read FLFS_TOTALINSS write FLFS_TOTALINSS;
    const LFS_TOTALINSS_Name = 'LFS_TOTALINSS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALCSLL', ftBCD)]
    [Dictionary('LFS_TOTALCSLL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCSLL: Double read FLFS_TOTALCSLL write FLFS_TOTALCSLL;
    const LFS_TOTALCSLL_Name = 'LFS_TOTALCSLL';

    [Restrictions([NoValidate])]
    [Column('LFS_ISSRETIDO', ftString, 1)]
    [Dictionary('LFS_ISSRETIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_ISSRETIDO: String read FLFS_ISSRETIDO write FLFS_ISSRETIDO;
    const LFS_ISSRETIDO_Name = 'LFS_ISSRETIDO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSDESONERADO', ftBCD)]
    [Dictionary('LFS_TOTALICMSDESONERADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSDESONERADO: Double read FLFS_TOTALICMSDESONERADO write FLFS_TOTALICMSDESONERADO;
    const LFS_TOTALICMSDESONERADO_Name = 'LFS_TOTALICMSDESONERADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00)

end.
