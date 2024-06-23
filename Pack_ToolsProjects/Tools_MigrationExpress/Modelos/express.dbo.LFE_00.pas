unit express.dbo.LFE_00;

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
  [Table('LFE_00', '')]
  [PrimaryKey('LFE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFE_ID')]
  TDtoLFE_00 = class
  private
    { Private declarations } 
    FLFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFG_PORTEFEDERAL: String;
    FCFG_PORTEESTADUAL: String;
    FPES_CODIGO: Integer;
    FLFE_SERIE: String;
    FTRP_CODIGO: Integer;
    FLFE_UFVEICULO: String;
    FLFE_PLACAVEICULO: String;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FLFE_EMITENTE: String;
    FLFE_NOTAFISCAL: String;
    FLFE_FINALIDADE: String;
    FLFE_DATAEMISSAO: TDateTime;
    FLFE_DATAENTRADA: TDateTime;
    FLFE_DATALANCAMENTO: TDateTime;
    FLFE_TIPOFRETE: String;
    FLFE_STATUSNFE: String;
    FLFE_TIPOLIGACAO: String;
    FLFE_TIPOPAGAMENTO: String;
    FLFE_TOTALPIS: Double;
    FLFE_TOTALIPI: Double;
    FLFE_TOTALICMS: Double;
    FLFE_TOTALICMSR: Double;
    FLFE_TOTALCOFINS: Double;
    FLFE_TOTALDESCTO: Double;
    FLFE_TOTALSEGURO: Double;
    FLFE_TOTALSERVICO: Double;
    FLFE_TOTALFRETENF: Double;
    FLFE_TOTALPRODUTOS: Double;
    FLFE_TIPONOTAFISCAL: String;
    FLFE_TOTALPESOBRUTO: Double;
    FLFE_TOTALNOTAFISCAL: Double;
    FLFE_TOTALPESOLIQUIDO: Double;
    FLFE_TOTALDESPACESSORIA: Double;
    FLFE_TOTALBASEISENTOICMS: Double;
    FLFE_TOTALBASECALCULOMVA: Double;
    FLFE_TOTALBASECALCULOICMS: Double;
    FLFE_TOTALCOMPLEMENTONFICMS: Double;
    FLFE_TOTALBASECALCULOICMSFRETENF: Double;
    FLFE_TOTALBCICMSDESPACESSORIA: Double;
    FLFE_TOTALBCALCULOPISCOFINS: Double;
    FLFE_TOTALNUMEROVOLUMES: Integer;
    FLFE_PERCENTUALICMSFRETENF: Double;
    FLFE_PERCENTUALICMSDESPACESSORIA: Double;
    FLFE_PERCENTUALPIS: Double;
    FLFE_PERCENTUALCOFINS: Double;
    FLFE_NUMERACAOVOLUMES: String;
    FLFE_INFCOMPLEMENTAR: String;
    FLFE_ESPECIEVOLUMES: String;
    FLFE_MARCAVOLUMES: String;
    FLFE_XMLNFEGERADO: String;
    FLFE_GRUPOTENSAO: String;
    FLFE_PISCOFINSCTR: String;
    FLFE_CHAVEACESSO: String;
    FLFE_CHAVEREFERENCIANFE: TBlob;
    FLFE_RNTRC: String;
    FLFE_OBSERVACAO: String;
    FLFE_DENEGADA: String;
    FLFE_DESATIVADO: String;
    FLFE_CANCELADO: String;
    FLFE_INTEGRACAO: String;
    FLFE_DATAALTERACAO: TDateTime;
    FLFE_ID_OLD: Integer;
    FLFE_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'LFE_00';
     const PrimaryKey = 'LFE_ID';
     const Sequence   = 'SEQ_LFE_ID';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_SERIE', ftString, 3)]
    [Dictionary('LFE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_SERIE: String read FLFE_SERIE write FLFE_SERIE;
    const LFE_SERIE_Name = 'LFE_SERIE';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

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
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_EMITENTE', ftString, 50)]
    [Dictionary('LFE_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_EMITENTE: String read FLFE_EMITENTE write FLFE_EMITENTE;
    const LFE_EMITENTE_Name = 'LFE_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('LFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NOTAFISCAL: String read FLFE_NOTAFISCAL write FLFE_NOTAFISCAL;
    const LFE_NOTAFISCAL_Name = 'LFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFE_FINALIDADE', ftString, 1)]
    [Dictionary('LFE_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_FINALIDADE: String read FLFE_FINALIDADE write FLFE_FINALIDADE;
    const LFE_FINALIDADE_Name = 'LFE_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('LFE_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFE_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFE_DATAEMISSAO: TDateTime read FLFE_DATAEMISSAO write FLFE_DATAEMISSAO;
    const LFE_DATAEMISSAO_Name = 'LFE_DATAEMISSAO';

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

    [Restrictions([NoValidate])]
    [Column('LFE_TIPOFRETE', ftString, 1)]
    [Dictionary('LFE_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_TIPOFRETE: String read FLFE_TIPOFRETE write FLFE_TIPOFRETE;
    const LFE_TIPOFRETE_Name = 'LFE_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('LFE_STATUSNFE', ftString, 2)]
    [Dictionary('LFE_STATUSNFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_STATUSNFE: String read FLFE_STATUSNFE write FLFE_STATUSNFE;
    const LFE_STATUSNFE_Name = 'LFE_STATUSNFE';

    [Restrictions([NoValidate])]
    [Column('LFE_TIPOLIGACAO', ftString, 1)]
    [Dictionary('LFE_TIPOLIGACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_TIPOLIGACAO: String read FLFE_TIPOLIGACAO write FLFE_TIPOLIGACAO;
    const LFE_TIPOLIGACAO_Name = 'LFE_TIPOLIGACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_TIPOPAGAMENTO', ftString, 1)]
    [Dictionary('LFE_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_TIPOPAGAMENTO: String read FLFE_TIPOPAGAMENTO write FLFE_TIPOPAGAMENTO;
    const LFE_TIPOPAGAMENTO_Name = 'LFE_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALPIS', ftBCD)]
    [Dictionary('LFE_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPIS: Double read FLFE_TOTALPIS write FLFE_TOTALPIS;
    const LFE_TOTALPIS_Name = 'LFE_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALIPI', ftBCD)]
    [Dictionary('LFE_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALIPI: Double read FLFE_TOTALIPI write FLFE_TOTALIPI;
    const LFE_TOTALIPI_Name = 'LFE_TOTALIPI';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALICMS', ftBCD)]
    [Dictionary('LFE_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALICMS: Double read FLFE_TOTALICMS write FLFE_TOTALICMS;
    const LFE_TOTALICMS_Name = 'LFE_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALICMSR', ftBCD)]
    [Dictionary('LFE_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALICMSR: Double read FLFE_TOTALICMSR write FLFE_TOTALICMSR;
    const LFE_TOTALICMSR_Name = 'LFE_TOTALICMSR';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALCOFINS', ftBCD)]
    [Dictionary('LFE_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALCOFINS: Double read FLFE_TOTALCOFINS write FLFE_TOTALCOFINS;
    const LFE_TOTALCOFINS_Name = 'LFE_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALDESCTO', ftBCD)]
    [Dictionary('LFE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESCTO: Double read FLFE_TOTALDESCTO write FLFE_TOTALDESCTO;
    const LFE_TOTALDESCTO_Name = 'LFE_TOTALDESCTO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALFRETENF', ftBCD)]
    [Dictionary('LFE_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALFRETENF: Double read FLFE_TOTALFRETENF write FLFE_TOTALFRETENF;
    const LFE_TOTALFRETENF_Name = 'LFE_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPRODUTOS', ftBCD)]
    [Dictionary('LFE_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPRODUTOS: Double read FLFE_TOTALPRODUTOS write FLFE_TOTALPRODUTOS;
    const LFE_TOTALPRODUTOS_Name = 'LFE_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('LFE_TIPONOTAFISCAL', ftString, 4)]
    [Dictionary('LFE_TIPONOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_TIPONOTAFISCAL: String read FLFE_TIPONOTAFISCAL write FLFE_TIPONOTAFISCAL;
    const LFE_TIPONOTAFISCAL_Name = 'LFE_TIPONOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('LFE_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPESOBRUTO: Double read FLFE_TOTALPESOBRUTO write FLFE_TOTALPESOBRUTO;
    const LFE_TOTALPESOBRUTO_Name = 'LFE_TOTALPESOBRUTO';

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
    [Column('LFE_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('LFE_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESPACESSORIA: Double read FLFE_TOTALDESPACESSORIA write FLFE_TOTALDESPACESSORIA;
    const LFE_TOTALDESPACESSORIA_Name = 'LFE_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('LFE_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASEISENTOICMS: Double read FLFE_TOTALBASEISENTOICMS write FLFE_TOTALBASEISENTOICMS;
    const LFE_TOTALBASEISENTOICMS_Name = 'LFE_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('LFE_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASECALCULOMVA: Double read FLFE_TOTALBASECALCULOMVA write FLFE_TOTALBASECALCULOMVA;
    const LFE_TOTALBASECALCULOMVA_Name = 'LFE_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('LFE_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASECALCULOICMS: Double read FLFE_TOTALBASECALCULOICMS write FLFE_TOTALBASECALCULOICMS;
    const LFE_TOTALBASECALCULOICMS_Name = 'LFE_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('LFE_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALCOMPLEMENTONFICMS: Double read FLFE_TOTALCOMPLEMENTONFICMS write FLFE_TOTALCOMPLEMENTONFICMS;
    const LFE_TOTALCOMPLEMENTONFICMS_Name = 'LFE_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASECALCULOICMSFRETENF', ftBCD)]
    [Dictionary('LFE_TOTALBASECALCULOICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASECALCULOICMSFRETENF: Double read FLFE_TOTALBASECALCULOICMSFRETENF write FLFE_TOTALBASECALCULOICMSFRETENF;
    const LFE_TOTALBASECALCULOICMSFRETENF_Name = 'LFE_TOTALBASECALCULOICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBCICMSDESPACESSORIA', ftBCD, 18, 4)]
    [Dictionary('LFE_TOTALBCICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBCICMSDESPACESSORIA: Double read FLFE_TOTALBCICMSDESPACESSORIA write FLFE_TOTALBCICMSDESPACESSORIA;
    const LFE_TOTALBCICMSDESPACESSORIA_Name = 'LFE_TOTALBCICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('LFE_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBCALCULOPISCOFINS: Double read FLFE_TOTALBCALCULOPISCOFINS write FLFE_TOTALBCALCULOPISCOFINS;
    const LFE_TOTALBCALCULOPISCOFINS_Name = 'LFE_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('LFE_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_TOTALNUMEROVOLUMES: Integer read FLFE_TOTALNUMEROVOLUMES write FLFE_TOTALNUMEROVOLUMES;
    const LFE_TOTALNUMEROVOLUMES_Name = 'LFE_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALICMSFRETENF', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMSFRETENF: Double read FLFE_PERCENTUALICMSFRETENF write FLFE_PERCENTUALICMSFRETENF;
    const LFE_PERCENTUALICMSFRETENF_Name = 'LFE_PERCENTUALICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALICMSDESPACESSORIA', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMSDESPACESSORIA: Double read FLFE_PERCENTUALICMSDESPACESSORIA write FLFE_PERCENTUALICMSDESPACESSORIA;
    const LFE_PERCENTUALICMSDESPACESSORIA_Name = 'LFE_PERCENTUALICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALPIS', ftBCD)]
    [Dictionary('LFE_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALPIS: Double read FLFE_PERCENTUALPIS write FLFE_PERCENTUALPIS;
    const LFE_PERCENTUALPIS_Name = 'LFE_PERCENTUALPIS';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALCOFINS', ftBCD)]
    [Dictionary('LFE_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALCOFINS: Double read FLFE_PERCENTUALCOFINS write FLFE_PERCENTUALCOFINS;
    const LFE_PERCENTUALCOFINS_Name = 'LFE_PERCENTUALCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFE_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('LFE_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NUMERACAOVOLUMES: String read FLFE_NUMERACAOVOLUMES write FLFE_NUMERACAOVOLUMES;
    const LFE_NUMERACAOVOLUMES_Name = 'LFE_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('LFE_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_INFCOMPLEMENTAR: String read FLFE_INFCOMPLEMENTAR write FLFE_INFCOMPLEMENTAR;
    const LFE_INFCOMPLEMENTAR_Name = 'LFE_INFCOMPLEMENTAR';

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
    [Column('LFE_XMLNFEGERADO', ftString, 1)]
    [Dictionary('LFE_XMLNFEGERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_XMLNFEGERADO: String read FLFE_XMLNFEGERADO write FLFE_XMLNFEGERADO;
    const LFE_XMLNFEGERADO_Name = 'LFE_XMLNFEGERADO';

    [Restrictions([NoValidate])]
    [Column('LFE_GRUPOTENSAO', ftString, 2)]
    [Dictionary('LFE_GRUPOTENSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_GRUPOTENSAO: String read FLFE_GRUPOTENSAO write FLFE_GRUPOTENSAO;
    const LFE_GRUPOTENSAO_Name = 'LFE_GRUPOTENSAO';

    [Restrictions([NoValidate])]
    [Column('LFE_PISCOFINSCTR', ftString, 2)]
    [Dictionary('LFE_PISCOFINSCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_PISCOFINSCTR: String read FLFE_PISCOFINSCTR write FLFE_PISCOFINSCTR;
    const LFE_PISCOFINSCTR_Name = 'LFE_PISCOFINSCTR';

    [Restrictions([NoValidate])]
    [Column('LFE_CHAVEACESSO', ftString, 44)]
    [Dictionary('LFE_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_CHAVEACESSO: String read FLFE_CHAVEACESSO write FLFE_CHAVEACESSO;
    const LFE_CHAVEACESSO_Name = 'LFE_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('LFE_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('LFE_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_CHAVEREFERENCIANFE: TBlob read FLFE_CHAVEREFERENCIANFE write FLFE_CHAVEREFERENCIANFE;
    const LFE_CHAVEREFERENCIANFE_Name = 'LFE_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate])]
    [Column('LFE_RNTRC', ftString, 14)]
    [Dictionary('LFE_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_RNTRC: String read FLFE_RNTRC write FLFE_RNTRC;
    const LFE_RNTRC_Name = 'LFE_RNTRC';

    [Restrictions([NoValidate])]
    [Column('LFE_OBSERVACAO', ftString, 300)]
    [Dictionary('LFE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_OBSERVACAO: String read FLFE_OBSERVACAO write FLFE_OBSERVACAO;
    const LFE_OBSERVACAO_Name = 'LFE_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_DENEGADA', ftString, 1)]
    [Dictionary('LFE_DENEGADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_DENEGADA: String read FLFE_DENEGADA write FLFE_DENEGADA;
    const LFE_DENEGADA_Name = 'LFE_DENEGADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DESATIVADO', ftString, 1)]
    [Dictionary('LFE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_DESATIVADO: String read FLFE_DESATIVADO write FLFE_DESATIVADO;
    const LFE_DESATIVADO_Name = 'LFE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('LFE_CANCELADO', ftString, 1)]
    [Dictionary('LFE_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_CANCELADO: String read FLFE_CANCELADO write FLFE_CANCELADO;
    const LFE_CANCELADO_Name = 'LFE_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('LFE_INTEGRACAO', ftString, 20)]
    [Dictionary('LFE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_INTEGRACAO: String read FLFE_INTEGRACAO write FLFE_INTEGRACAO;
    const LFE_INTEGRACAO_Name = 'LFE_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAALTERACAO: TDateTime read FLFE_DATAALTERACAO write FLFE_DATAALTERACAO;
    const LFE_DATAALTERACAO_Name = 'LFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_ID_OLD', ftInteger)]
    [Dictionary('LFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID_OLD: Integer read FLFE_ID_OLD write FLFE_ID_OLD;
    const LFE_ID_OLD_Name = 'LFE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFE_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('LFE_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_INTEGRACAO_OLD: String read FLFE_INTEGRACAO_OLD write FLFE_INTEGRACAO_OLD;
    const LFE_INTEGRACAO_OLD_Name = 'LFE_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFE_00)

end.
