unit express.dbo.NFP_00;

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
  [Table('NFP_00', '')]
  [PrimaryKey('NFP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFP_ID')]
  TDtoNFP_00 = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FMNF_CODIGO: String;
    FNFP_SERIE: String;
    FTDC_CODIGO: String;
    FTRP_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FNFP_NOTAFISCAL: String;
    FNFP_NUMERODOCTO: String;
    FNFP_DATALANCAMENTO: TDateTime;
    FNFP_DATACANCELAMENTO: TDateTime;
    FNFP_OBSERVACAOCANCELAMENTO: String;
    FNFP_TOTALNOTAFISCAL: Double;
    FNFP_TOTALPRODUTOS: Double;
    FNFP_TIPOFRETE: String;
    FNFP_TOTALIPI: Double;
    FNFP_TOTALICMS: Double;
    FNFP_TOTALSERVICO: Double;
    FNFP_TOTALSEGURO: Double;
    FNFP_TOTALFRETENF: Double;
    FNFP_TOTALADICIONAL: Double;
    FNFP_TOTALFRETERPA: Double;
    FNFP_TOTALPESOBRUTO: Double;
    FNFP_TOTALPESOLIQUIDO: Double;
    FNFP_TOTALQTDENTRADA: Double;
    FNFP_TOTALDESCTOITEM: Double;
    FNFP_TOTALICMSSIMPLES: Double;
    FNFP_TOTALDESPACESSORIA: Double;
    FNFP_TOTALBASEISENTOICMS: Double;
    FNFP_TOTALNUMEROVOLUMES: Double;
    FNFP_TOTALICMSFRETENF: Double;
    FNFP_TOTALRBCICMSFRETENF: Double;
    FNFP_PERCENTUALICMSFRETENF: Double;
    FNFP_TOTALBASECALCULOICMS: Double;
    FNFP_TOTALBCALCULOPISCOFINS: Double;
    FNFP_TOTALCOMPLEMENTONFICMS: Double;
    FNFP_PLANOCONTARATEIO: Double;
    FNFP_NUMERACAOVOLUMES: String;
    FNFP_INFCOMPLEMENTAR: String;
    FNFP_ESPECIEVOLUMES: String;
    FNFP_MARCAVOLUMES: String;
    FNFP_NUMERORPA: String;
    FNFP_PLACAVEICULO: String;
    FNFP_UFVEICULO: String;
    FNFP_TOTALCOFINS: Double;
    FNFP_TOTALPIS: Double;
    FNFP_CHAVEACESSO: String;
    FNFP_OBSERVACAO: String;
    FNFP_CANCELADA: String;
    FNFP_PROCESSADO: String;
    FNFP_DESATIVADO: String;
    FNFP_LIVROFISCAL: String;
    FNFP_DATAALTERACAO: TDateTime;
    FNFP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'NFP_00';
     const PrimaryKey = 'NFP_ID';
     const Sequence   = 'SEQ_NFP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

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
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFP_SERIE', ftString, 3)]
    [Dictionary('NFP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_SERIE: String read FNFP_SERIE write FNFP_SERIE;
    const NFP_SERIE_Name = 'NFP_SERIE';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

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
    [Column('NFP_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NOTAFISCAL: String read FNFP_NOTAFISCAL write FNFP_NOTAFISCAL;
    const NFP_NOTAFISCAL_Name = 'NFP_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_NUMERODOCTO', ftString, 10)]
    [Dictionary('NFP_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMERODOCTO: String read FNFP_NUMERODOCTO write FNFP_NUMERODOCTO;
    const NFP_NUMERODOCTO_Name = 'NFP_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATALANCAMENTO: TDateTime read FNFP_DATALANCAMENTO write FNFP_DATALANCAMENTO;
    const NFP_DATALANCAMENTO_Name = 'NFP_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('NFP_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('NFP_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFP_DATACANCELAMENTO: TDateTime read FNFP_DATACANCELAMENTO write FNFP_DATACANCELAMENTO;
    const NFP_DATACANCELAMENTO_Name = 'NFP_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('NFP_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('NFP_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_OBSERVACAOCANCELAMENTO: String read FNFP_OBSERVACAOCANCELAMENTO write FNFP_OBSERVACAOCANCELAMENTO;
    const NFP_OBSERVACAOCANCELAMENTO_Name = 'NFP_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NFP_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALNOTAFISCAL: Double read FNFP_TOTALNOTAFISCAL write FNFP_TOTALNOTAFISCAL;
    const NFP_TOTALNOTAFISCAL_Name = 'NFP_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPRODUTOS', ftBCD)]
    [Dictionary('NFP_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPRODUTOS: Double read FNFP_TOTALPRODUTOS write FNFP_TOTALPRODUTOS;
    const NFP_TOTALPRODUTOS_Name = 'NFP_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TIPOFRETE', ftString, 1)]
    [Dictionary('NFP_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_TIPOFRETE: String read FNFP_TIPOFRETE write FNFP_TIPOFRETE;
    const NFP_TIPOFRETE_Name = 'NFP_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALIPI', ftBCD)]
    [Dictionary('NFP_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALIPI: Double read FNFP_TOTALIPI write FNFP_TOTALIPI;
    const NFP_TOTALIPI_Name = 'NFP_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALICMS', ftBCD)]
    [Dictionary('NFP_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMS: Double read FNFP_TOTALICMS write FNFP_TOTALICMS;
    const NFP_TOTALICMS_Name = 'NFP_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALSERVICO', ftBCD)]
    [Dictionary('NFP_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALSERVICO: Double read FNFP_TOTALSERVICO write FNFP_TOTALSERVICO;
    const NFP_TOTALSERVICO_Name = 'NFP_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALSEGURO', ftBCD)]
    [Dictionary('NFP_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALSEGURO: Double read FNFP_TOTALSEGURO write FNFP_TOTALSEGURO;
    const NFP_TOTALSEGURO_Name = 'NFP_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALFRETENF', ftBCD)]
    [Dictionary('NFP_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETENF: Double read FNFP_TOTALFRETENF write FNFP_TOTALFRETENF;
    const NFP_TOTALFRETENF_Name = 'NFP_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALADICIONAL', ftBCD, 18, 4)]
    [Dictionary('NFP_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALADICIONAL: Double read FNFP_TOTALADICIONAL write FNFP_TOTALADICIONAL;
    const NFP_TOTALADICIONAL_Name = 'NFP_TOTALADICIONAL';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALFRETERPA', ftBCD, 10, 2)]
    [Dictionary('NFP_TOTALFRETERPA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETERPA: Double read FNFP_TOTALFRETERPA write FNFP_TOTALFRETERPA;
    const NFP_TOTALFRETERPA_Name = 'NFP_TOTALFRETERPA';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('NFP_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPESOBRUTO: Double read FNFP_TOTALPESOBRUTO write FNFP_TOTALPESOBRUTO;
    const NFP_TOTALPESOBRUTO_Name = 'NFP_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('NFP_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPESOLIQUIDO: Double read FNFP_TOTALPESOLIQUIDO write FNFP_TOTALPESOLIQUIDO;
    const NFP_TOTALPESOLIQUIDO_Name = 'NFP_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALQTDENTRADA', ftBCD)]
    [Dictionary('NFP_TOTALQTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALQTDENTRADA: Double read FNFP_TOTALQTDENTRADA write FNFP_TOTALQTDENTRADA;
    const NFP_TOTALQTDENTRADA_Name = 'NFP_TOTALQTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('NFP_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESCTOITEM: Double read FNFP_TOTALDESCTOITEM write FNFP_TOTALDESCTOITEM;
    const NFP_TOTALDESCTOITEM_Name = 'NFP_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALICMSSIMPLES', ftBCD)]
    [Dictionary('NFP_TOTALICMSSIMPLES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSSIMPLES: Double read FNFP_TOTALICMSSIMPLES write FNFP_TOTALICMSSIMPLES;
    const NFP_TOTALICMSSIMPLES_Name = 'NFP_TOTALICMSSIMPLES';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('NFP_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESPACESSORIA: Double read FNFP_TOTALDESPACESSORIA write FNFP_TOTALDESPACESSORIA;
    const NFP_TOTALDESPACESSORIA_Name = 'NFP_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('NFP_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASEISENTOICMS: Double read FNFP_TOTALBASEISENTOICMS write FNFP_TOTALBASEISENTOICMS;
    const NFP_TOTALBASEISENTOICMS_Name = 'NFP_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('NFP_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALNUMEROVOLUMES: Double read FNFP_TOTALNUMEROVOLUMES write FNFP_TOTALNUMEROVOLUMES;
    const NFP_TOTALNUMEROVOLUMES_Name = 'NFP_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALICMSFRETENF', ftBCD)]
    [Dictionary('NFP_TOTALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSFRETENF: Double read FNFP_TOTALICMSFRETENF write FNFP_TOTALICMSFRETENF;
    const NFP_TOTALICMSFRETENF_Name = 'NFP_TOTALICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALRBCICMSFRETENF', ftBCD)]
    [Dictionary('NFP_TOTALRBCICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALRBCICMSFRETENF: Double read FNFP_TOTALRBCICMSFRETENF write FNFP_TOTALRBCICMSFRETENF;
    const NFP_TOTALRBCICMSFRETENF_Name = 'NFP_TOTALRBCICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALICMSFRETENF', ftBCD)]
    [Dictionary('NFP_PERCENTUALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSFRETENF: Double read FNFP_PERCENTUALICMSFRETENF write FNFP_PERCENTUALICMSFRETENF;
    const NFP_PERCENTUALICMSFRETENF_Name = 'NFP_PERCENTUALICMSFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('NFP_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASECALCULOICMS: Double read FNFP_TOTALBASECALCULOICMS write FNFP_TOTALBASECALCULOICMS;
    const NFP_TOTALBASECALCULOICMS_Name = 'NFP_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('NFP_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBCALCULOPISCOFINS: Double read FNFP_TOTALBCALCULOPISCOFINS write FNFP_TOTALBCALCULOPISCOFINS;
    const NFP_TOTALBCALCULOPISCOFINS_Name = 'NFP_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('NFP_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALCOMPLEMENTONFICMS: Double read FNFP_TOTALCOMPLEMENTONFICMS write FNFP_TOTALCOMPLEMENTONFICMS;
    const NFP_TOTALCOMPLEMENTONFICMS_Name = 'NFP_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('NFP_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('NFP_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PLANOCONTARATEIO: Double read FNFP_PLANOCONTARATEIO write FNFP_PLANOCONTARATEIO;
    const NFP_PLANOCONTARATEIO_Name = 'NFP_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('NFP_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('NFP_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMERACAOVOLUMES: String read FNFP_NUMERACAOVOLUMES write FNFP_NUMERACAOVOLUMES;
    const NFP_NUMERACAOVOLUMES_Name = 'NFP_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFP_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('NFP_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_INFCOMPLEMENTAR: String read FNFP_INFCOMPLEMENTAR write FNFP_INFCOMPLEMENTAR;
    const NFP_INFCOMPLEMENTAR_Name = 'NFP_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('NFP_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('NFP_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_ESPECIEVOLUMES: String read FNFP_ESPECIEVOLUMES write FNFP_ESPECIEVOLUMES;
    const NFP_ESPECIEVOLUMES_Name = 'NFP_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFP_MARCAVOLUMES', ftString, 30)]
    [Dictionary('NFP_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_MARCAVOLUMES: String read FNFP_MARCAVOLUMES write FNFP_MARCAVOLUMES;
    const NFP_MARCAVOLUMES_Name = 'NFP_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFP_NUMERORPA', ftString, 6)]
    [Dictionary('NFP_NUMERORPA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMERORPA: String read FNFP_NUMERORPA write FNFP_NUMERORPA;
    const NFP_NUMERORPA_Name = 'NFP_NUMERORPA';

    [Restrictions([NoValidate])]
    [Column('NFP_PLACAVEICULO', ftString, 7)]
    [Dictionary('NFP_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_PLACAVEICULO: String read FNFP_PLACAVEICULO write FNFP_PLACAVEICULO;
    const NFP_PLACAVEICULO_Name = 'NFP_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('NFP_UFVEICULO', ftString, 2)]
    [Dictionary('NFP_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_UFVEICULO: String read FNFP_UFVEICULO write FNFP_UFVEICULO;
    const NFP_UFVEICULO_Name = 'NFP_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALCOFINS', ftBCD)]
    [Dictionary('NFP_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALCOFINS: Double read FNFP_TOTALCOFINS write FNFP_TOTALCOFINS;
    const NFP_TOTALCOFINS_Name = 'NFP_TOTALCOFINS';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALPIS', ftBCD)]
    [Dictionary('NFP_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPIS: Double read FNFP_TOTALPIS write FNFP_TOTALPIS;
    const NFP_TOTALPIS_Name = 'NFP_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('NFP_CHAVEACESSO', ftString, 44)]
    [Dictionary('NFP_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_CHAVEACESSO: String read FNFP_CHAVEACESSO write FNFP_CHAVEACESSO;
    const NFP_CHAVEACESSO_Name = 'NFP_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('NFP_OBSERVACAO', ftString, 300)]
    [Dictionary('NFP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_OBSERVACAO: String read FNFP_OBSERVACAO write FNFP_OBSERVACAO;
    const NFP_OBSERVACAO_Name = 'NFP_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_CANCELADA', ftString, 1)]
    [Dictionary('NFP_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_CANCELADA: String read FNFP_CANCELADA write FNFP_CANCELADA;
    const NFP_CANCELADA_Name = 'NFP_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('NFP_PROCESSADO', ftString, 1)]
    [Dictionary('NFP_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_PROCESSADO: String read FNFP_PROCESSADO write FNFP_PROCESSADO;
    const NFP_PROCESSADO_Name = 'NFP_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DESATIVADO', ftString, 1)]
    [Dictionary('NFP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_DESATIVADO: String read FNFP_DESATIVADO write FNFP_DESATIVADO;
    const NFP_DESATIVADO_Name = 'NFP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_LIVROFISCAL', ftString, 1)]
    [Dictionary('NFP_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_LIVROFISCAL: String read FNFP_LIVROFISCAL write FNFP_LIVROFISCAL;
    const NFP_LIVROFISCAL_Name = 'NFP_LIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAALTERACAO: TDateTime read FNFP_DATAALTERACAO write FNFP_DATAALTERACAO;
    const NFP_DATAALTERACAO_Name = 'NFP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFP_ID_OLD', ftInteger)]
    [Dictionary('NFP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID_OLD: Integer read FNFP_ID_OLD write FNFP_ID_OLD;
    const NFP_ID_OLD_Name = 'NFP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_00)

end.
