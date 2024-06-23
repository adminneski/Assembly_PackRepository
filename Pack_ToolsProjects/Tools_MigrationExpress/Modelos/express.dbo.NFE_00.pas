unit express.dbo.NFE_00;

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
  [Table('NFE_00', '')]
  [PrimaryKey('NFE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFE_ID')]
  TDtoNFE_00 = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FMNF_CODIGO: String;
    FNFE_SERIE: String;
    FNFE_NOTAFISCAL: String;
    FNFE_PEDIDOCOMPRA: Integer;
    FNFE_DATAEMISSAO: TDateTime;
    FNFE_DATAENTRADA: TDateTime;
    FNFE_DATALANCAMENTO: TDateTime;
    FNFE_TIPOFRETE: String;
    FNFE_TOTALIPI: Double;
    FNFE_TOTALPIS: Double;
    FNFE_TOTALICMS: Double;
    FNFE_TOTALCOFINS: Double;
    FNFE_TOTALDESCTO: Double;
    FNFE_TOTALSEGURO: Double;
    FNFE_TOTALSERVICO: Double;
    FNFE_TOTALFRETENF: Double;
    FNFE_TOTALICMSRNF: Double;
    FNFE_TOTALADICIONAL: Double;
    FNFE_TOTALPRODUTOS: Double;
    FNFE_TOTALNOTAFISCAL: Double;
    FNFE_TOTALICMSSIMPLES: Double;
    FNFE_TOTALFRETERPA: Double;
    FNFE_TOTALICMSFRETENF: Double;
    FNFE_TOTALDESPACESSORIA: Double;
    FNFE_TOTALSUBSTRIBUTARIA: Double;
    FNFE_TOTALBASEISENTOICMS: Double;
    FNFE_TOTALBASECALCULOMVA: Double;
    FNFE_TOTALBASECALCULOICMS: Double;
    FNFE_TOTALBCALCULOPISCOFINS: Double;
    FNFE_TOTALBCICMSDESPACESSORIA: Double;
    FNFE_TOTALCOMPLEMENTONFICMS: Double;
    FNFE_TOTALICMSDESPACESSORIA: Double;
    FNFE_TOTALBASECALCULOICMSFRETENF: Double;
    FNFE_PERCENTUALICMSFRETENF: Double;
    FNFE_PERCENTUALICMSDESPACESSORIA: Double;
    FNFE_TOTALPESOBRUTO: Double;
    FNFE_TOTALPESOLIQUIDO: Double;
    FNFE_DATACANCELAMENTO: TDateTime;
    FNFE_OBSERVACAOCANCELAMENTO: String;
    FNFE_NUMERORPA: String;
    FNFE_PLANOCONTARATEIO: Double;
    FNFE_CHAVEACESSO: String;
    FNFE_OBSERVACAO: String;
    FNFE_PROCESSADO: String;
    FNFE_LIVROFISCAL: String;
    FNFE_CANCELADA: String;
    FNFE_INTEGRACAO: String;
    FNFE_DATAALTERACAO: TDateTime;
    FNFE_ID_OLD: Integer;
    FNFE_INTEGRACAO_OLD: String;
    FNFE_XMLIMPORTADO: TBlob;
  public 
    { Public declarations } 
     const Table      = 'NFE_00';
     const PrimaryKey = 'NFE_ID';
     const Sequence   = 'SEQ_NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIE', ftString, 3)]
    [Dictionary('NFE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIE: String read FNFE_SERIE write FNFE_SERIE;
    const NFE_SERIE_Name = 'NFE_SERIE';

    [Restrictions([NoValidate])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFE_PEDIDOCOMPRA', ftInteger)]
    [Dictionary('NFE_PEDIDOCOMPRA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_PEDIDOCOMPRA: Integer read FNFE_PEDIDOCOMPRA write FNFE_PEDIDOCOMPRA;
    const NFE_PEDIDOCOMPRA_Name = 'NFE_PEDIDOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAEMISSAO', ftDateTime)]
    [Dictionary('NFE_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAEMISSAO: TDateTime read FNFE_DATAEMISSAO write FNFE_DATAEMISSAO;
    const NFE_DATAEMISSAO_Name = 'NFE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAENTRADA', ftDateTime)]
    [Dictionary('NFE_DATAENTRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAENTRADA: TDateTime read FNFE_DATAENTRADA write FNFE_DATAENTRADA;
    const NFE_DATAENTRADA_Name = 'NFE_DATAENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFE_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATALANCAMENTO: TDateTime read FNFE_DATALANCAMENTO write FNFE_DATALANCAMENTO;
    const NFE_DATALANCAMENTO_Name = 'NFE_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPOFRETE', ftString, 1)]
    [Dictionary('NFE_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOFRETE: String read FNFE_TIPOFRETE write FNFE_TIPOFRETE;
    const NFE_TIPOFRETE_Name = 'NFE_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALIPI', ftBCD)]
    [Dictionary('NFE_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALIPI: Double read FNFE_TOTALIPI write FNFE_TOTALIPI;
    const NFE_TOTALIPI_Name = 'NFE_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALPIS', ftBCD)]
    [Dictionary('NFE_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALPIS: Double read FNFE_TOTALPIS write FNFE_TOTALPIS;
    const NFE_TOTALPIS_Name = 'NFE_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALICMS', ftBCD)]
    [Dictionary('NFE_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMS: Double read FNFE_TOTALICMS write FNFE_TOTALICMS;
    const NFE_TOTALICMS_Name = 'NFE_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALCOFINS', ftBCD)]
    [Dictionary('NFE_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALCOFINS: Double read FNFE_TOTALCOFINS write FNFE_TOTALCOFINS;
    const NFE_TOTALCOFINS_Name = 'NFE_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALDESCTO', ftBCD)]
    [Dictionary('NFE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALDESCTO: Double read FNFE_TOTALDESCTO write FNFE_TOTALDESCTO;
    const NFE_TOTALDESCTO_Name = 'NFE_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALSEGURO', ftBCD)]
    [Dictionary('NFE_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALSEGURO: Double read FNFE_TOTALSEGURO write FNFE_TOTALSEGURO;
    const NFE_TOTALSEGURO_Name = 'NFE_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALSERVICO', ftBCD, 66256176, 2)]
    [Dictionary('NFE_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALSERVICO: Double read FNFE_TOTALSERVICO write FNFE_TOTALSERVICO;
    const NFE_TOTALSERVICO_Name = 'NFE_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALFRETENF', ftBCD)]
    [Dictionary('NFE_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETENF: Double read FNFE_TOTALFRETENF write FNFE_TOTALFRETENF;
    const NFE_TOTALFRETENF_Name = 'NFE_TOTALFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALICMSRNF', ftBCD)]
    [Dictionary('NFE_TOTALICMSRNF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSRNF: Double read FNFE_TOTALICMSRNF write FNFE_TOTALICMSRNF;
    const NFE_TOTALICMSRNF_Name = 'NFE_TOTALICMSRNF';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALADICIONAL', ftBCD)]
    [Dictionary('NFE_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALADICIONAL: Double read FNFE_TOTALADICIONAL write FNFE_TOTALADICIONAL;
    const NFE_TOTALADICIONAL_Name = 'NFE_TOTALADICIONAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALPRODUTOS', ftBCD)]
    [Dictionary('NFE_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALPRODUTOS: Double read FNFE_TOTALPRODUTOS write FNFE_TOTALPRODUTOS;
    const NFE_TOTALPRODUTOS_Name = 'NFE_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALNOTAFISCAL: Double read FNFE_TOTALNOTAFISCAL write FNFE_TOTALNOTAFISCAL;
    const NFE_TOTALNOTAFISCAL_Name = 'NFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSSIMPLES', ftBCD)]
    [Dictionary('NFE_TOTALICMSSIMPLES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSSIMPLES: Double read FNFE_TOTALICMSSIMPLES write FNFE_TOTALICMSSIMPLES;
    const NFE_TOTALICMSSIMPLES_Name = 'NFE_TOTALICMSSIMPLES';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALFRETERPA', ftBCD)]
    [Dictionary('NFE_TOTALFRETERPA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETERPA: Double read FNFE_TOTALFRETERPA write FNFE_TOTALFRETERPA;
    const NFE_TOTALFRETERPA_Name = 'NFE_TOTALFRETERPA';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSFRETENF', ftBCD)]
    [Dictionary('NFE_TOTALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSFRETENF: Double read FNFE_TOTALICMSFRETENF write FNFE_TOTALICMSFRETENF;
    const NFE_TOTALICMSFRETENF_Name = 'NFE_TOTALICMSFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('NFE_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALDESPACESSORIA: Double read FNFE_TOTALDESPACESSORIA write FNFE_TOTALDESPACESSORIA;
    const NFE_TOTALDESPACESSORIA_Name = 'NFE_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('NFE_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALSUBSTRIBUTARIA: Double read FNFE_TOTALSUBSTRIBUTARIA write FNFE_TOTALSUBSTRIBUTARIA;
    const NFE_TOTALSUBSTRIBUTARIA_Name = 'NFE_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('NFE_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASEISENTOICMS: Double read FNFE_TOTALBASEISENTOICMS write FNFE_TOTALBASEISENTOICMS;
    const NFE_TOTALBASEISENTOICMS_Name = 'NFE_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('NFE_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASECALCULOMVA: Double read FNFE_TOTALBASECALCULOMVA write FNFE_TOTALBASECALCULOMVA;
    const NFE_TOTALBASECALCULOMVA_Name = 'NFE_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('NFE_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASECALCULOICMS: Double read FNFE_TOTALBASECALCULOICMS write FNFE_TOTALBASECALCULOICMS;
    const NFE_TOTALBASECALCULOICMS_Name = 'NFE_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('NFE_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCALCULOPISCOFINS: Double read FNFE_TOTALBCALCULOPISCOFINS write FNFE_TOTALBCALCULOPISCOFINS;
    const NFE_TOTALBCALCULOPISCOFINS_Name = 'NFE_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBCICMSDESPACESSORIA', ftBCD)]
    [Dictionary('NFE_TOTALBCICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCICMSDESPACESSORIA: Double read FNFE_TOTALBCICMSDESPACESSORIA write FNFE_TOTALBCICMSDESPACESSORIA;
    const NFE_TOTALBCICMSDESPACESSORIA_Name = 'NFE_TOTALBCICMSDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALCOMPLEMENTONFICMS', ftBCD, 1650, 2)]
    [Dictionary('NFE_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALCOMPLEMENTONFICMS: Double read FNFE_TOTALCOMPLEMENTONFICMS write FNFE_TOTALCOMPLEMENTONFICMS;
    const NFE_TOTALCOMPLEMENTONFICMS_Name = 'NFE_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSDESPACESSORIA', ftBCD)]
    [Dictionary('NFE_TOTALICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSDESPACESSORIA: Double read FNFE_TOTALICMSDESPACESSORIA write FNFE_TOTALICMSDESPACESSORIA;
    const NFE_TOTALICMSDESPACESSORIA_Name = 'NFE_TOTALICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASECALCULOICMSFRETENF', ftBCD)]
    [Dictionary('NFE_TOTALBASECALCULOICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASECALCULOICMSFRETENF: Double read FNFE_TOTALBASECALCULOICMSFRETENF write FNFE_TOTALBASECALCULOICMSFRETENF;
    const NFE_TOTALBASECALCULOICMSFRETENF_Name = 'NFE_TOTALBASECALCULOICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSFRETENF', ftBCD)]
    [Dictionary('NFE_PERCENTUALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSFRETENF: Double read FNFE_PERCENTUALICMSFRETENF write FNFE_PERCENTUALICMSFRETENF;
    const NFE_PERCENTUALICMSFRETENF_Name = 'NFE_PERCENTUALICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSDESPACESSORIA', ftBCD)]
    [Dictionary('NFE_PERCENTUALICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSDESPACESSORIA: Double read FNFE_PERCENTUALICMSDESPACESSORIA write FNFE_PERCENTUALICMSDESPACESSORIA;
    const NFE_PERCENTUALICMSDESPACESSORIA_Name = 'NFE_PERCENTUALICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('NFE_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALPESOBRUTO: Double read FNFE_TOTALPESOBRUTO write FNFE_TOTALPESOBRUTO;
    const NFE_TOTALPESOBRUTO_Name = 'NFE_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('NFE_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALPESOLIQUIDO: Double read FNFE_TOTALPESOLIQUIDO write FNFE_TOTALPESOLIQUIDO;
    const NFE_TOTALPESOLIQUIDO_Name = 'NFE_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NFE_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('NFE_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATACANCELAMENTO: TDateTime read FNFE_DATACANCELAMENTO write FNFE_DATACANCELAMENTO;
    const NFE_DATACANCELAMENTO_Name = 'NFE_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('NFE_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('NFE_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_OBSERVACAOCANCELAMENTO: String read FNFE_OBSERVACAOCANCELAMENTO write FNFE_OBSERVACAOCANCELAMENTO;
    const NFE_OBSERVACAOCANCELAMENTO_Name = 'NFE_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('NFE_NUMERORPA', ftString, 6)]
    [Dictionary('NFE_NUMERORPA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NUMERORPA: String read FNFE_NUMERORPA write FNFE_NUMERORPA;
    const NFE_NUMERORPA_Name = 'NFE_NUMERORPA';

    [Restrictions([NoValidate])]
    [Column('NFE_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('NFE_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PLANOCONTARATEIO: Double read FNFE_PLANOCONTARATEIO write FNFE_PLANOCONTARATEIO;
    const NFE_PLANOCONTARATEIO_Name = 'NFE_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('NFE_CHAVEACESSO', ftString, 44)]
    [Dictionary('NFE_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CHAVEACESSO: String read FNFE_CHAVEACESSO write FNFE_CHAVEACESSO;
    const NFE_CHAVEACESSO_Name = 'NFE_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('NFE_OBSERVACAO', ftString, 300)]
    [Dictionary('NFE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_OBSERVACAO: String read FNFE_OBSERVACAO write FNFE_OBSERVACAO;
    const NFE_OBSERVACAO_Name = 'NFE_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PROCESSADO', ftString, 1)]
    [Dictionary('NFE_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROCESSADO: String read FNFE_PROCESSADO write FNFE_PROCESSADO;
    const NFE_PROCESSADO_Name = 'NFE_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('NFE_LIVROFISCAL', ftString, 1)]
    [Dictionary('NFE_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_LIVROFISCAL: String read FNFE_LIVROFISCAL write FNFE_LIVROFISCAL;
    const NFE_LIVROFISCAL_Name = 'NFE_LIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_CANCELADA', ftString, 1)]
    [Dictionary('NFE_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CANCELADA: String read FNFE_CANCELADA write FNFE_CANCELADA;
    const NFE_CANCELADA_Name = 'NFE_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('NFE_INTEGRACAO', ftString, 20)]
    [Dictionary('NFE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_INTEGRACAO: String read FNFE_INTEGRACAO write FNFE_INTEGRACAO;
    const NFE_INTEGRACAO_Name = 'NFE_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATAALTERACAO: TDateTime read FNFE_DATAALTERACAO write FNFE_DATAALTERACAO;
    const NFE_DATAALTERACAO_Name = 'NFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_ID_OLD', ftInteger)]
    [Dictionary('NFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID_OLD: Integer read FNFE_ID_OLD write FNFE_ID_OLD;
    const NFE_ID_OLD_Name = 'NFE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('NFE_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_INTEGRACAO_OLD: String read FNFE_INTEGRACAO_OLD write FNFE_INTEGRACAO_OLD;
    const NFE_INTEGRACAO_OLD_Name = 'NFE_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_XMLIMPORTADO', ftBlob)]
    [Dictionary('NFE_XMLIMPORTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_XMLIMPORTADO: TBlob read FNFE_XMLIMPORTADO write FNFE_XMLIMPORTADO;
    const NFE_XMLIMPORTADO_Name = 'NFE_XMLIMPORTADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_00)

end.
