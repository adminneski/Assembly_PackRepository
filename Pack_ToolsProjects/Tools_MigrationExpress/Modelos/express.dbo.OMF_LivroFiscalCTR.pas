unit express.dbo.OMF_LIVROFISCALCTR;

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
  [Table('OMF_LivroFiscalCTR', '')]
  TDtoOMF_LivroFiscalCTR = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_TIPOPAGAMENTO: String;
    FPES_CODIGO: Integer;
    FPES_UF: String;
    FOMF_NOTAFISCAL: String;
    FOMF_DATAEMISSAO: TDateTime;
    FOMF_DATAENTRADA: TDateTime;
    FOMF_DATALANCAMENTO: TDateTime;
    FMNF_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FTDC_CODIGO: String;
    FOMF_SERIE: String;
    FOMF_EMITENTE: String;
    FOMF_TOTALFRETECTR: Double;
    FOMF_TOTALSEGURO: Integer;
    FOMF_TOTALDESPACESSORIA: Integer;
    FOMF_TOTALPIS: Integer;
    FOMF_TOTALCOMPLEMENTONFICMS: Integer;
    FOMF_TOTALSERVICO: Integer;
    FOMF_TOTALDESCTO: Integer;
    FOMF_TOTALNOTAFISCAL: Double;
    FOMF_TOTALPESOLIQUIDO: Integer;
    FOMF_OBSERVACAO: String;
    FOMF_CANCELADA: String;
    FOMF_TOTALICMSFRETECTR: Double;
    FOMF_PERCENTUALICMSFRETECTR: Double;
    FOMF_TOTALBCICMSFRETECTR: Double;
    FOMF_TIPOFRETE: String;
    FOMF_TOTALIPI: Integer;
    FOMF_TOTALICMS: Integer;
    FOMF_TOTALICMSR: Integer;
    FOMF_TOTALCOFINS: Integer;
    FOMF_TOTALPRODUTOS: Integer;
    FOMF_TOTALPESOBRUTO: Integer;
    FOMF_TOTALBASEISENTOICMS: Integer;
    FOMF_TOTALBASECALCULOICMS: Integer;
    FOMF_TOTALBASECALCULOMVA: Integer;
    FOMF_DATAVENCIMENTO: TDateTime;
    FOMF_CHAVEACESSO: String;
    FOMF_TOTALBASEOUTROS: Double;
  public 
    { Public declarations } 
     const Table      = 'OMF_LivroFiscalCTR';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TIPOPAGAMENTO', ftString, 1)]
    [Dictionary('OMF_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPOPAGAMENTO: String read FOMF_TIPOPAGAMENTO write FOMF_TIPOPAGAMENTO;
    const OMF_TIPOPAGAMENTO_Name = 'OMF_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_NOTAFISCAL', ftString, 9)]
    [Dictionary('OMF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NOTAFISCAL: String read FOMF_NOTAFISCAL write FOMF_NOTAFISCAL;
    const OMF_NOTAFISCAL_Name = 'OMF_NOTAFISCAL';

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

    [Restrictions([NoValidate])]
    [Column('OMF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('OMF_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATALANCAMENTO: TDateTime read FOMF_DATALANCAMENTO write FOMF_DATALANCAMENTO;
    const OMF_DATALANCAMENTO_Name = 'OMF_DATALANCAMENTO';

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
    [Column('TDC_CODIGO', ftString, 3)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_SERIE', ftString, 3)]
    [Dictionary('OMF_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_SERIE: String read FOMF_SERIE write FOMF_SERIE;
    const OMF_SERIE_Name = 'OMF_SERIE';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_EMITENTE', ftString, 1)]
    [Dictionary('OMF_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_EMITENTE: String read FOMF_EMITENTE write FOMF_EMITENTE;
    const OMF_EMITENTE_Name = 'OMF_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALFRETECTR', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETECTR: Double read FOMF_TOTALFRETECTR write FOMF_TOTALFRETECTR;
    const OMF_TOTALFRETECTR_Name = 'OMF_TOTALFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALSEGURO', ftInteger)]
    [Dictionary('OMF_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALSEGURO: Integer read FOMF_TOTALSEGURO write FOMF_TOTALSEGURO;
    const OMF_TOTALSEGURO_Name = 'OMF_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALDESPACESSORIA', ftInteger)]
    [Dictionary('OMF_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALDESPACESSORIA: Integer read FOMF_TOTALDESPACESSORIA write FOMF_TOTALDESPACESSORIA;
    const OMF_TOTALDESPACESSORIA_Name = 'OMF_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPIS', ftInteger)]
    [Dictionary('OMF_TOTALPIS', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALPIS: Integer read FOMF_TOTALPIS write FOMF_TOTALPIS;
    const OMF_TOTALPIS_Name = 'OMF_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALCOMPLEMENTONFICMS', ftInteger)]
    [Dictionary('OMF_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALCOMPLEMENTONFICMS: Integer read FOMF_TOTALCOMPLEMENTONFICMS write FOMF_TOTALCOMPLEMENTONFICMS;
    const OMF_TOTALCOMPLEMENTONFICMS_Name = 'OMF_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALSERVICO', ftInteger)]
    [Dictionary('OMF_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALSERVICO: Integer read FOMF_TOTALSERVICO write FOMF_TOTALSERVICO;
    const OMF_TOTALSERVICO_Name = 'OMF_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALDESCTO', ftInteger)]
    [Dictionary('OMF_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALDESCTO: Integer read FOMF_TOTALDESCTO write FOMF_TOTALDESCTO;
    const OMF_TOTALDESCTO_Name = 'OMF_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('OMF_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALNOTAFISCAL: Double read FOMF_TOTALNOTAFISCAL write FOMF_TOTALNOTAFISCAL;
    const OMF_TOTALNOTAFISCAL_Name = 'OMF_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPESOLIQUIDO', ftInteger)]
    [Dictionary('OMF_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALPESOLIQUIDO: Integer read FOMF_TOTALPESOLIQUIDO write FOMF_TOTALPESOLIQUIDO;
    const OMF_TOTALPESOLIQUIDO_Name = 'OMF_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('OMF_OBSERVACAO', ftString, 300)]
    [Dictionary('OMF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_OBSERVACAO: String read FOMF_OBSERVACAO write FOMF_OBSERVACAO;
    const OMF_OBSERVACAO_Name = 'OMF_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_CANCELADA', ftString, 1)]
    [Dictionary('OMF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CANCELADA: String read FOMF_CANCELADA write FOMF_CANCELADA;
    const OMF_CANCELADA_Name = 'OMF_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMSFRETECTR', ftBCD)]
    [Dictionary('OMF_TOTALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSFRETECTR: Double read FOMF_TOTALICMSFRETECTR write FOMF_TOTALICMSFRETECTR;
    const OMF_TOTALICMSFRETECTR_Name = 'OMF_TOTALICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSFRETECTR', ftBCD)]
    [Dictionary('OMF_PERCENTUALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSFRETECTR: Double read FOMF_PERCENTUALICMSFRETECTR write FOMF_PERCENTUALICMSFRETECTR;
    const OMF_PERCENTUALICMSFRETECTR_Name = 'OMF_PERCENTUALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBCICMSFRETECTR', ftBCD)]
    [Dictionary('OMF_TOTALBCICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCICMSFRETECTR: Double read FOMF_TOTALBCICMSFRETECTR write FOMF_TOTALBCICMSFRETECTR;
    const OMF_TOTALBCICMSFRETECTR_Name = 'OMF_TOTALBCICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPOFRETE', ftString, 1)]
    [Dictionary('OMF_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPOFRETE: String read FOMF_TIPOFRETE write FOMF_TIPOFRETE;
    const OMF_TIPOFRETE_Name = 'OMF_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALIPI', ftInteger)]
    [Dictionary('OMF_TOTALIPI', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALIPI: Integer read FOMF_TOTALIPI write FOMF_TOTALIPI;
    const OMF_TOTALIPI_Name = 'OMF_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMS', ftInteger)]
    [Dictionary('OMF_TOTALICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALICMS: Integer read FOMF_TOTALICMS write FOMF_TOTALICMS;
    const OMF_TOTALICMS_Name = 'OMF_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMSR', ftInteger)]
    [Dictionary('OMF_TOTALICMSR', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALICMSR: Integer read FOMF_TOTALICMSR write FOMF_TOTALICMSR;
    const OMF_TOTALICMSR_Name = 'OMF_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALCOFINS', ftInteger)]
    [Dictionary('OMF_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALCOFINS: Integer read FOMF_TOTALCOFINS write FOMF_TOTALCOFINS;
    const OMF_TOTALCOFINS_Name = 'OMF_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPRODUTOS', ftInteger)]
    [Dictionary('OMF_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALPRODUTOS: Integer read FOMF_TOTALPRODUTOS write FOMF_TOTALPRODUTOS;
    const OMF_TOTALPRODUTOS_Name = 'OMF_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPESOBRUTO', ftInteger)]
    [Dictionary('OMF_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALPESOBRUTO: Integer read FOMF_TOTALPESOBRUTO write FOMF_TOTALPESOBRUTO;
    const OMF_TOTALPESOBRUTO_Name = 'OMF_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBASEISENTOICMS', ftInteger)]
    [Dictionary('OMF_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALBASEISENTOICMS: Integer read FOMF_TOTALBASEISENTOICMS write FOMF_TOTALBASEISENTOICMS;
    const OMF_TOTALBASEISENTOICMS_Name = 'OMF_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBASECALCULOICMS', ftInteger)]
    [Dictionary('OMF_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALBASECALCULOICMS: Integer read FOMF_TOTALBASECALCULOICMS write FOMF_TOTALBASECALCULOICMS;
    const OMF_TOTALBASECALCULOICMS_Name = 'OMF_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBASECALCULOMVA', ftInteger)]
    [Dictionary('OMF_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_TOTALBASECALCULOMVA: Integer read FOMF_TOTALBASECALCULOMVA write FOMF_TOTALBASECALCULOMVA;
    const OMF_TOTALBASECALCULOMVA_Name = 'OMF_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('OMF_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAVENCIMENTO: TDateTime read FOMF_DATAVENCIMENTO write FOMF_DATAVENCIMENTO;
    const OMF_DATAVENCIMENTO_Name = 'OMF_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('OMF_CHAVEACESSO', ftString, 44)]
    [Dictionary('OMF_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CHAVEACESSO: String read FOMF_CHAVEACESSO write FOMF_CHAVEACESSO;
    const OMF_CHAVEACESSO_Name = 'OMF_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBASEOUTROS', ftBCD)]
    [Dictionary('OMF_TOTALBASEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASEOUTROS: Double read FOMF_TOTALBASEOUTROS write FOMF_TOTALBASEOUTROS;
    const OMF_TOTALBASEOUTROS_Name = 'OMF_TOTALBASEOUTROS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_LivroFiscalCTR)

end.
