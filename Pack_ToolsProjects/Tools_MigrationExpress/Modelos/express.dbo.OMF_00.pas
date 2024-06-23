unit express.dbo.OMF_00;

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
  [Table('OMF_00', '')]
  [PrimaryKey('OMF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_ID')]
  TDtoOMF_00 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_TIPODOCUMENTO: String;
    FMNF_CODIGO: String;
    FOMF_SERIE: String;
    FOMF_NOTAFISCAL: String;
    FOMF_PEDIDOCOMPRA: Integer;
    FOMF_DATAEMISSAO: TDateTime;
    FOMF_DATAENTRADA: TDateTime;
    FOMF_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FOMF_TIPOFRETE: String;
    FOMF_TOTALIPI: Double;
    FOMF_TOTALPIS: Double;
    FOMF_TOTALICMS: Double;
    FOMF_TOTALCOFINS: Double;
    FOMF_TOTALDESCTO: Double;
    FOMF_TOTALSEGURO: Double;
    FOMF_TOTALSERVICO: Double;
    FOMF_TOTALFRETENF: Double;
    FOMF_TOTALICMSRNF: Double;
    FOMF_TOTALADICIONAL: Double;
    FOMF_TOTALPRODUTOS: Double;
    FOMF_TOTALNOTAFISCAL: Double;
    FOMF_TOTALICMSSIMPLES: Double;
    FOMF_TOTALFRETERPA: Double;
    FOMF_TOTALICMSFRETENF: Double;
    FOMF_TOTALDESPACESSORIA: Double;
    FOMF_TOTALSUBSTRIBUTARIA: Double;
    FOMF_TOTALBASEISENTOICMS: Double;
    FOMF_TOTALBASECALCULOMVA: Double;
    FOMF_TOTALBASECALCULOICMS: Double;
    FOMF_TOTALBCALCULOPISCOFINS: Double;
    FOMF_TOTALBCICMSDESPACESSORIA: Double;
    FOMF_TOTALCOMPLEMENTONFICMS: Double;
    FOMF_TOTALICMSDESPACESSORIA: Double;
    FOMF_TOTALBASECALCULOICMSFRETENF: Double;
    FOMF_PERCENTUALICMSFRETENF: Double;
    FOMF_PERCENTUALICMSDESPACESSORIA: Double;
    FOMF_TOTALPESOBRUTO: Double;
    FOMF_TOTALPESOLIQUIDO: Double;
    FOMF_DATACANCELAMENTO: TDateTime;
    FOMF_OBSERVACAOCANCELAMENTO: String;
    FOMF_INFCOMPLEMENTAR: String;
    FOMF_NUMERORPA: String;
    FOMF_PLANOCONTARATEIO: Double;
    FOMF_CHAVEACESSO: String;
    FOMF_OBSERVACAO: String;
    FOMF_FINANCEIRO: String;
    FOMF_PROCESSADO: String;
    FOMF_LIVROFISCAL: String;
    FOMF_CANCELADA: String;
    FOMF_INTEGRACAO: String;
    FOMF_DATAALTERACAO: TDateTime;
    FFAT_NOTAFISCAL: String;
    FFAT_SERIE: String;
    FOMF_CHAVEREFERENCIANFE: TBlob;
    FOMF_FINALIDADE: String;
    FOMF_ES: String;
    FOMF_ESPECIEVOLUMES: String;
    FOMF_NUMERACAOVOLUMES: String;
    FOMF_TOTALNUMEROVOLUMES: Double;
    FOMF_MARCAVOLUMES: String;
    FOMF_ID_OLD: Integer;
    FOMF_INTEGRACAO_OLD: String;
    FVND_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FOMF_TOTALCOMISSAO: Double;
    FOMF_TOTALAPROXIMADOIMPOSTO: Double;
    FOMF_PERCENTUALDESCTO: Double;
    FOMF_PERCENTUALIBPT: Double;
    FUSERS_LOGIN: String;
    FOMF_PERCENTUALCOMISSAO: Double;
    FOMF_TOTALBASECALCULOCOMISSAO: Double;
    FOMF_TOTALIBPTMUNICIPAL: Double;
    FOMF_TOTALIBPTESTADUAL: Double;
    FOMF_TOTALIBPTIMPORTADO: Double;
    FOMF_PERCENTUALIBPTMUNICIPAL: Double;
    FOMF_PERCENTUALIBPTESTADUAL: Double;
    FOMF_PERCENTUALIBPTNACIONAL: Double;
    FOMF_PERCENTUALIBPTIMPORTADO: Double;
    FCON_CODIGO: Integer;
    FOMF_TOTALBASECALCULOFCP: Double;
    FOMF_TOTALFCP: Double;
    FOMF_TOTALBASECALCULOFCPST: Double;
    FOMF_TOTALFCPST: Double;
    FOMF_TOTALBASECALCULOFCPRET: Double;
    FOMF_TOTALFCPRET: Double;
    FDEV_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'OMF_00';
     const PrimaryKey = 'OMF_ID';
     const Sequence   = 'SEQ_OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('OMF_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPODOCUMENTO: String read FOMF_TIPODOCUMENTO write FOMF_TIPODOCUMENTO;
    const OMF_TIPODOCUMENTO_Name = 'OMF_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_SERIE', ftString, 3)]
    [Dictionary('OMF_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_SERIE: String read FOMF_SERIE write FOMF_SERIE;
    const OMF_SERIE_Name = 'OMF_SERIE';

    [Restrictions([NoValidate])]
    [Column('OMF_NOTAFISCAL', ftString, 9)]
    [Dictionary('OMF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NOTAFISCAL: String read FOMF_NOTAFISCAL write FOMF_NOTAFISCAL;
    const OMF_NOTAFISCAL_Name = 'OMF_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('OMF_PEDIDOCOMPRA', ftInteger)]
    [Dictionary('OMF_PEDIDOCOMPRA', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_PEDIDOCOMPRA: Integer read FOMF_PEDIDOCOMPRA write FOMF_PEDIDOCOMPRA;
    const OMF_PEDIDOCOMPRA_Name = 'OMF_PEDIDOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAEMISSAO', ftDateTime)]
    [Dictionary('OMF_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAEMISSAO: TDateTime read FOMF_DATAEMISSAO write FOMF_DATAEMISSAO;
    const OMF_DATAEMISSAO_Name = 'OMF_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAENTRADA', ftDateTime)]
    [Dictionary('OMF_DATAENTRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAENTRADA: TDateTime read FOMF_DATAENTRADA write FOMF_DATAENTRADA;
    const OMF_DATAENTRADA_Name = 'OMF_DATAENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('OMF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATALANCAMENTO: TDateTime read FOMF_DATALANCAMENTO write FOMF_DATALANCAMENTO;
    const OMF_DATALANCAMENTO_Name = 'OMF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

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
    [Column('OMF_TIPOFRETE', ftString, 1)]
    [Dictionary('OMF_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPOFRETE: String read FOMF_TIPOFRETE write FOMF_TIPOFRETE;
    const OMF_TIPOFRETE_Name = 'OMF_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALIPI', ftBCD)]
    [Dictionary('OMF_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIPI: Double read FOMF_TOTALIPI write FOMF_TOTALIPI;
    const OMF_TOTALIPI_Name = 'OMF_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPIS', ftBCD)]
    [Dictionary('OMF_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPIS: Double read FOMF_TOTALPIS write FOMF_TOTALPIS;
    const OMF_TOTALPIS_Name = 'OMF_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMS', ftBCD)]
    [Dictionary('OMF_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMS: Double read FOMF_TOTALICMS write FOMF_TOTALICMS;
    const OMF_TOTALICMS_Name = 'OMF_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALCOFINS', ftBCD)]
    [Dictionary('OMF_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOFINS: Double read FOMF_TOTALCOFINS write FOMF_TOTALCOFINS;
    const OMF_TOTALCOFINS_Name = 'OMF_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALDESCTO', ftBCD)]
    [Dictionary('OMF_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESCTO: Double read FOMF_TOTALDESCTO write FOMF_TOTALDESCTO;
    const OMF_TOTALDESCTO_Name = 'OMF_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALSEGURO', ftBCD)]
    [Dictionary('OMF_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSEGURO: Double read FOMF_TOTALSEGURO write FOMF_TOTALSEGURO;
    const OMF_TOTALSEGURO_Name = 'OMF_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALSERVICO', ftBCD, 10, 2)]
    [Dictionary('OMF_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSERVICO: Double read FOMF_TOTALSERVICO write FOMF_TOTALSERVICO;
    const OMF_TOTALSERVICO_Name = 'OMF_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALFRETENF', ftBCD)]
    [Dictionary('OMF_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETENF: Double read FOMF_TOTALFRETENF write FOMF_TOTALFRETENF;
    const OMF_TOTALFRETENF_Name = 'OMF_TOTALFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMSRNF', ftBCD)]
    [Dictionary('OMF_TOTALICMSRNF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSRNF: Double read FOMF_TOTALICMSRNF write FOMF_TOTALICMSRNF;
    const OMF_TOTALICMSRNF_Name = 'OMF_TOTALICMSRNF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALADICIONAL', ftBCD)]
    [Dictionary('OMF_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALADICIONAL: Double read FOMF_TOTALADICIONAL write FOMF_TOTALADICIONAL;
    const OMF_TOTALADICIONAL_Name = 'OMF_TOTALADICIONAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPRODUTOS', ftBCD)]
    [Dictionary('OMF_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPRODUTOS: Double read FOMF_TOTALPRODUTOS write FOMF_TOTALPRODUTOS;
    const OMF_TOTALPRODUTOS_Name = 'OMF_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('OMF_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALNOTAFISCAL: Double read FOMF_TOTALNOTAFISCAL write FOMF_TOTALNOTAFISCAL;
    const OMF_TOTALNOTAFISCAL_Name = 'OMF_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSSIMPLES', ftBCD)]
    [Dictionary('OMF_TOTALICMSSIMPLES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSSIMPLES: Double read FOMF_TOTALICMSSIMPLES write FOMF_TOTALICMSSIMPLES;
    const OMF_TOTALICMSSIMPLES_Name = 'OMF_TOTALICMSSIMPLES';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFRETERPA', ftBCD)]
    [Dictionary('OMF_TOTALFRETERPA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETERPA: Double read FOMF_TOTALFRETERPA write FOMF_TOTALFRETERPA;
    const OMF_TOTALFRETERPA_Name = 'OMF_TOTALFRETERPA';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSFRETENF', ftBCD)]
    [Dictionary('OMF_TOTALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSFRETENF: Double read FOMF_TOTALICMSFRETENF write FOMF_TOTALICMSFRETENF;
    const OMF_TOTALICMSFRETENF_Name = 'OMF_TOTALICMSFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('OMF_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESPACESSORIA: Double read FOMF_TOTALDESPACESSORIA write FOMF_TOTALDESPACESSORIA;
    const OMF_TOTALDESPACESSORIA_Name = 'OMF_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('OMF_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSUBSTRIBUTARIA: Double read FOMF_TOTALSUBSTRIBUTARIA write FOMF_TOTALSUBSTRIBUTARIA;
    const OMF_TOTALSUBSTRIBUTARIA_Name = 'OMF_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('OMF_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASEISENTOICMS: Double read FOMF_TOTALBASEISENTOICMS write FOMF_TOTALBASEISENTOICMS;
    const OMF_TOTALBASEISENTOICMS_Name = 'OMF_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('OMF_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOMVA: Double read FOMF_TOTALBASECALCULOMVA write FOMF_TOTALBASECALCULOMVA;
    const OMF_TOTALBASECALCULOMVA_Name = 'OMF_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('OMF_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOICMS: Double read FOMF_TOTALBASECALCULOICMS write FOMF_TOTALBASECALCULOICMS;
    const OMF_TOTALBASECALCULOICMS_Name = 'OMF_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('OMF_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCALCULOPISCOFINS: Double read FOMF_TOTALBCALCULOPISCOFINS write FOMF_TOTALBCALCULOPISCOFINS;
    const OMF_TOTALBCALCULOPISCOFINS_Name = 'OMF_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCICMSDESPACESSORIA', ftBCD)]
    [Dictionary('OMF_TOTALBCICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCICMSDESPACESSORIA: Double read FOMF_TOTALBCICMSDESPACESSORIA write FOMF_TOTALBCICMSDESPACESSORIA;
    const OMF_TOTALBCICMSDESPACESSORIA_Name = 'OMF_TOTALBCICMSDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('OMF_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOMPLEMENTONFICMS: Double read FOMF_TOTALCOMPLEMENTONFICMS write FOMF_TOTALCOMPLEMENTONFICMS;
    const OMF_TOTALCOMPLEMENTONFICMS_Name = 'OMF_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSDESPACESSORIA', ftBCD)]
    [Dictionary('OMF_TOTALICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSDESPACESSORIA: Double read FOMF_TOTALICMSDESPACESSORIA write FOMF_TOTALICMSDESPACESSORIA;
    const OMF_TOTALICMSDESPACESSORIA_Name = 'OMF_TOTALICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOICMSFRETENF', ftBCD)]
    [Dictionary('OMF_TOTALBASECALCULOICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOICMSFRETENF: Double read FOMF_TOTALBASECALCULOICMSFRETENF write FOMF_TOTALBASECALCULOICMSFRETENF;
    const OMF_TOTALBASECALCULOICMSFRETENF_Name = 'OMF_TOTALBASECALCULOICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSFRETENF', ftBCD)]
    [Dictionary('OMF_PERCENTUALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSFRETENF: Double read FOMF_PERCENTUALICMSFRETENF write FOMF_PERCENTUALICMSFRETENF;
    const OMF_PERCENTUALICMSFRETENF_Name = 'OMF_PERCENTUALICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSDESPACESSORIA', ftBCD)]
    [Dictionary('OMF_PERCENTUALICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSDESPACESSORIA: Double read FOMF_PERCENTUALICMSDESPACESSORIA write FOMF_PERCENTUALICMSDESPACESSORIA;
    const OMF_PERCENTUALICMSDESPACESSORIA_Name = 'OMF_PERCENTUALICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('OMF_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPESOBRUTO: Double read FOMF_TOTALPESOBRUTO write FOMF_TOTALPESOBRUTO;
    const OMF_TOTALPESOBRUTO_Name = 'OMF_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('OMF_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPESOLIQUIDO: Double read FOMF_TOTALPESOLIQUIDO write FOMF_TOTALPESOLIQUIDO;
    const OMF_TOTALPESOLIQUIDO_Name = 'OMF_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('OMF_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATACANCELAMENTO: TDateTime read FOMF_DATACANCELAMENTO write FOMF_DATACANCELAMENTO;
    const OMF_DATACANCELAMENTO_Name = 'OMF_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('OMF_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('OMF_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_OBSERVACAOCANCELAMENTO: String read FOMF_OBSERVACAOCANCELAMENTO write FOMF_OBSERVACAOCANCELAMENTO;
    const OMF_OBSERVACAOCANCELAMENTO_Name = 'OMF_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('OMF_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('OMF_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INFCOMPLEMENTAR: String read FOMF_INFCOMPLEMENTAR write FOMF_INFCOMPLEMENTAR;
    const OMF_INFCOMPLEMENTAR_Name = 'OMF_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('OMF_NUMERORPA', ftString, 6)]
    [Dictionary('OMF_NUMERORPA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NUMERORPA: String read FOMF_NUMERORPA write FOMF_NUMERORPA;
    const OMF_NUMERORPA_Name = 'OMF_NUMERORPA';

    [Restrictions([NoValidate])]
    [Column('OMF_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('OMF_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PLANOCONTARATEIO: Double read FOMF_PLANOCONTARATEIO write FOMF_PLANOCONTARATEIO;
    const OMF_PLANOCONTARATEIO_Name = 'OMF_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('OMF_CHAVEACESSO', ftString, 44)]
    [Dictionary('OMF_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CHAVEACESSO: String read FOMF_CHAVEACESSO write FOMF_CHAVEACESSO;
    const OMF_CHAVEACESSO_Name = 'OMF_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('OMF_OBSERVACAO', ftString, 300)]
    [Dictionary('OMF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_OBSERVACAO: String read FOMF_OBSERVACAO write FOMF_OBSERVACAO;
    const OMF_OBSERVACAO_Name = 'OMF_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_FINANCEIRO', ftString, 1)]
    [Dictionary('OMF_FINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_FINANCEIRO: String read FOMF_FINANCEIRO write FOMF_FINANCEIRO;
    const OMF_FINANCEIRO_Name = 'OMF_FINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PROCESSADO', ftString, 1)]
    [Dictionary('OMF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_PROCESSADO: String read FOMF_PROCESSADO write FOMF_PROCESSADO;
    const OMF_PROCESSADO_Name = 'OMF_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('OMF_LIVROFISCAL', ftString, 1)]
    [Dictionary('OMF_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_LIVROFISCAL: String read FOMF_LIVROFISCAL write FOMF_LIVROFISCAL;
    const OMF_LIVROFISCAL_Name = 'OMF_LIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_CANCELADA', ftString, 1)]
    [Dictionary('OMF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CANCELADA: String read FOMF_CANCELADA write FOMF_CANCELADA;
    const OMF_CANCELADA_Name = 'OMF_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAO', ftString, 20)]
    [Dictionary('OMF_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAO: String read FOMF_INTEGRACAO write FOMF_INTEGRACAO;
    const OMF_INTEGRACAO_Name = 'OMF_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_SERIE', ftString, 3)]
    [Dictionary('FAT_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SERIE: String read FFAT_SERIE write FFAT_SERIE;
    const FAT_SERIE_Name = 'FAT_SERIE';

    [Restrictions([NoValidate])]
    [Column('OMF_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('OMF_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CHAVEREFERENCIANFE: TBlob read FOMF_CHAVEREFERENCIANFE write FOMF_CHAVEREFERENCIANFE;
    const OMF_CHAVEREFERENCIANFE_Name = 'OMF_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate])]
    [Column('OMF_FINALIDADE', ftString, 1)]
    [Dictionary('OMF_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_FINALIDADE: String read FOMF_FINALIDADE write FOMF_FINALIDADE;
    const OMF_FINALIDADE_Name = 'OMF_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('OMF_ES', ftString, 1)]
    [Dictionary('OMF_ES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_ES: String read FOMF_ES write FOMF_ES;
    const OMF_ES_Name = 'OMF_ES';

    [Restrictions([NoValidate])]
    [Column('OMF_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('OMF_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_ESPECIEVOLUMES: String read FOMF_ESPECIEVOLUMES write FOMF_ESPECIEVOLUMES;
    const OMF_ESPECIEVOLUMES_Name = 'OMF_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('OMF_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NUMERACAOVOLUMES: String read FOMF_NUMERACAOVOLUMES write FOMF_NUMERACAOVOLUMES;
    const OMF_NUMERACAOVOLUMES_Name = 'OMF_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('OMF_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALNUMEROVOLUMES: Double read FOMF_TOTALNUMEROVOLUMES write FOMF_TOTALNUMEROVOLUMES;
    const OMF_TOTALNUMEROVOLUMES_Name = 'OMF_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_MARCAVOLUMES', ftString, 30)]
    [Dictionary('OMF_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_MARCAVOLUMES: String read FOMF_MARCAVOLUMES write FOMF_MARCAVOLUMES;
    const OMF_MARCAVOLUMES_Name = 'OMF_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('OMF_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAO_OLD: String read FOMF_INTEGRACAO_OLD write FOMF_INTEGRACAO_OLD;
    const OMF_INTEGRACAO_OLD_Name = 'OMF_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALCOMISSAO', ftBCD)]
    [Dictionary('OMF_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOMISSAO: Double read FOMF_TOTALCOMISSAO write FOMF_TOTALCOMISSAO;
    const OMF_TOTALCOMISSAO_Name = 'OMF_TOTALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('OMF_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALAPROXIMADOIMPOSTO: Double read FOMF_TOTALAPROXIMADOIMPOSTO write FOMF_TOTALAPROXIMADOIMPOSTO;
    const OMF_TOTALAPROXIMADOIMPOSTO_Name = 'OMF_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALDESCTO', ftBCD)]
    [Dictionary('OMF_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALDESCTO: Double read FOMF_PERCENTUALDESCTO write FOMF_PERCENTUALDESCTO;
    const OMF_PERCENTUALDESCTO_Name = 'OMF_PERCENTUALDESCTO';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPT', ftBCD)]
    [Dictionary('OMF_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPT: Double read FOMF_PERCENTUALIBPT write FOMF_PERCENTUALIBPT;
    const OMF_PERCENTUALIBPT_Name = 'OMF_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('OMF_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALCOMISSAO: Double read FOMF_PERCENTUALCOMISSAO write FOMF_PERCENTUALCOMISSAO;
    const OMF_PERCENTUALCOMISSAO_Name = 'OMF_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOCOMISSAO', ftBCD)]
    [Dictionary('OMF_TOTALBASECALCULOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOCOMISSAO: Double read FOMF_TOTALBASECALCULOCOMISSAO write FOMF_TOTALBASECALCULOCOMISSAO;
    const OMF_TOTALBASECALCULOCOMISSAO_Name = 'OMF_TOTALBASECALCULOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('OMF_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIBPTMUNICIPAL: Double read FOMF_TOTALIBPTMUNICIPAL write FOMF_TOTALIBPTMUNICIPAL;
    const OMF_TOTALIBPTMUNICIPAL_Name = 'OMF_TOTALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('OMF_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIBPTESTADUAL: Double read FOMF_TOTALIBPTESTADUAL write FOMF_TOTALIBPTESTADUAL;
    const OMF_TOTALIBPTESTADUAL_Name = 'OMF_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('OMF_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIBPTIMPORTADO: Double read FOMF_TOTALIBPTIMPORTADO write FOMF_TOTALIBPTIMPORTADO;
    const OMF_TOTALIBPTIMPORTADO_Name = 'OMF_TOTALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('OMF_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTMUNICIPAL: Double read FOMF_PERCENTUALIBPTMUNICIPAL write FOMF_PERCENTUALIBPTMUNICIPAL;
    const OMF_PERCENTUALIBPTMUNICIPAL_Name = 'OMF_PERCENTUALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('OMF_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTESTADUAL: Double read FOMF_PERCENTUALIBPTESTADUAL write FOMF_PERCENTUALIBPTESTADUAL;
    const OMF_PERCENTUALIBPTESTADUAL_Name = 'OMF_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('OMF_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTNACIONAL: Double read FOMF_PERCENTUALIBPTNACIONAL write FOMF_PERCENTUALIBPTNACIONAL;
    const OMF_PERCENTUALIBPTNACIONAL_Name = 'OMF_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTIMPORTADO', ftBCD)]
    [Dictionary('OMF_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTIMPORTADO: Double read FOMF_PERCENTUALIBPTIMPORTADO write FOMF_PERCENTUALIBPTIMPORTADO;
    const OMF_PERCENTUALIBPTIMPORTADO_Name = 'OMF_PERCENTUALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CON_CODIGO: Integer read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOFCP', ftBCD, 4456515, 2)]
    [Dictionary('OMF_TOTALBASECALCULOFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOFCP: Double read FOMF_TOTALBASECALCULOFCP write FOMF_TOTALBASECALCULOFCP;
    const OMF_TOTALBASECALCULOFCP_Name = 'OMF_TOTALBASECALCULOFCP';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFCP', ftBCD, 6422645, 2)]
    [Dictionary('OMF_TOTALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFCP: Double read FOMF_TOTALFCP write FOMF_TOTALFCP;
    const OMF_TOTALFCP_Name = 'OMF_TOTALFCP';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOFCPST', ftBCD, 6357078, 2)]
    [Dictionary('OMF_TOTALBASECALCULOFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOFCPST: Double read FOMF_TOTALBASECALCULOFCPST write FOMF_TOTALBASECALCULOFCPST;
    const OMF_TOTALBASECALCULOFCPST_Name = 'OMF_TOTALBASECALCULOFCPST';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFCPST', ftBCD, 2555943, 2)]
    [Dictionary('OMF_TOTALFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFCPST: Double read FOMF_TOTALFCPST write FOMF_TOTALFCPST;
    const OMF_TOTALFCPST_Name = 'OMF_TOTALFCPST';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOFCPRET', ftBCD, 4522067, 2)]
    [Dictionary('OMF_TOTALBASECALCULOFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOFCPRET: Double read FOMF_TOTALBASECALCULOFCPRET write FOMF_TOTALBASECALCULOFCPRET;
    const OMF_TOTALBASECALCULOFCPRET_Name = 'OMF_TOTALBASECALCULOFCPRET';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFCPRET', ftBCD, 5963808, 2)]
    [Dictionary('OMF_TOTALFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFCPRET: Double read FOMF_TOTALFCPRET write FOMF_TOTALFCPRET;
    const OMF_TOTALFCPRET_Name = 'OMF_TOTALFCPRET';

    [Restrictions([NoValidate])]
    [Column('DEV_ID_OLD', ftInteger)]
    [Dictionary('DEV_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID_OLD: Integer read FDEV_ID_OLD write FDEV_ID_OLD;
    const DEV_ID_OLD_Name = 'DEV_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00)

end.
