unit express.dbo.NFE_LIVROFISCALCTR;

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
  [Table('NFE_LivroFiscalCTR', '')]
  TDtoNFE_LivroFiscalCTR = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_TIPOPAGAMENTO: String;
    FPES_CODIGO: Integer;
    FPES_UF: String;
    FNFE_NOTAFISCAL: String;
    FNFE_DATAEMISSAO: TDateTime;
    FNFE_DATAENTRADA: TDateTime;
    FNFE_DATALANCAMENTO: TDateTime;
    FMNF_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FTDC_CODIGO: String;
    FNFE_SERIE: String;
    FNFE_EMITENTE: String;
    FNFE_TOTALFRETECTR: Double;
    FNFE_TOTALSEGURO: Integer;
    FNFE_TOTALDESPACESSORIA: Integer;
    FNFE_TOTALPIS: Integer;
    FNFE_TOTALCOMPLEMENTONFICMS: Integer;
    FNFE_TOTALSERVICO: Integer;
    FNFE_TOTALDESCTO: Integer;
    FNFE_TOTALNOTAFISCAL: Double;
    FNFE_TOTALPESOLIQUIDO: Integer;
    FNFE_OBSERVACAO: String;
    FNFE_CANCELADA: String;
    FNFE_TOTALICMSFRETECTR: Double;
    FNFE_PERCENTUALICMSFRETECTR: Double;
    FNFE_TOTALBCICMSFRETECTR: Double;
    FNFE_TIPOFRETE: String;
    FNFE_TOTALIPI: Integer;
    FNFE_TOTALICMS: Integer;
    FNFE_TOTALICMSR: Integer;
    FNFE_TOTALCOFINS: Integer;
    FNFE_TOTALPRODUTOS: Integer;
    FNFE_TOTALPESOBRUTO: Integer;
    FNFE_TOTALBASEISENTOICMS: Integer;
    FNFE_TOTALBASECALCULOICMS: Integer;
    FNFE_TOTALBASECALCULOMVA: Integer;
    FNFE_DATAVENCIMENTO: TDateTime;
    FNFE_CHAVEACESSO: String;
    FNFE_TOTALBASEOUTROS: Double;
  public 
    { Public declarations } 
     const Table      = 'NFE_LivroFiscalCTR';

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
    [Column('NFE_TIPOPAGAMENTO', ftString, 1)]
    [Dictionary('NFE_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOPAGAMENTO: String read FNFE_TIPOPAGAMENTO write FNFE_TIPOPAGAMENTO;
    const NFE_TIPOPAGAMENTO_Name = 'NFE_TIPOPAGAMENTO';

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
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

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

    [Restrictions([NoValidate])]
    [Column('NFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFE_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATALANCAMENTO: TDateTime read FNFE_DATALANCAMENTO write FNFE_DATALANCAMENTO;
    const NFE_DATALANCAMENTO_Name = 'NFE_DATALANCAMENTO';

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
    [Column('NFE_SERIE', ftString, 3)]
    [Dictionary('NFE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIE: String read FNFE_SERIE write FNFE_SERIE;
    const NFE_SERIE_Name = 'NFE_SERIE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_EMITENTE', ftString, 1)]
    [Dictionary('NFE_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMITENTE: String read FNFE_EMITENTE write FNFE_EMITENTE;
    const NFE_EMITENTE_Name = 'NFE_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALFRETECTR', ftBCD)]
    [Dictionary('NFE_TOTALFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETECTR: Double read FNFE_TOTALFRETECTR write FNFE_TOTALFRETECTR;
    const NFE_TOTALFRETECTR_Name = 'NFE_TOTALFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALSEGURO', ftInteger)]
    [Dictionary('NFE_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALSEGURO: Integer read FNFE_TOTALSEGURO write FNFE_TOTALSEGURO;
    const NFE_TOTALSEGURO_Name = 'NFE_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALDESPACESSORIA', ftInteger)]
    [Dictionary('NFE_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALDESPACESSORIA: Integer read FNFE_TOTALDESPACESSORIA write FNFE_TOTALDESPACESSORIA;
    const NFE_TOTALDESPACESSORIA_Name = 'NFE_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALPIS', ftInteger)]
    [Dictionary('NFE_TOTALPIS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALPIS: Integer read FNFE_TOTALPIS write FNFE_TOTALPIS;
    const NFE_TOTALPIS_Name = 'NFE_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALCOMPLEMENTONFICMS', ftInteger)]
    [Dictionary('NFE_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALCOMPLEMENTONFICMS: Integer read FNFE_TOTALCOMPLEMENTONFICMS write FNFE_TOTALCOMPLEMENTONFICMS;
    const NFE_TOTALCOMPLEMENTONFICMS_Name = 'NFE_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALSERVICO', ftInteger)]
    [Dictionary('NFE_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALSERVICO: Integer read FNFE_TOTALSERVICO write FNFE_TOTALSERVICO;
    const NFE_TOTALSERVICO_Name = 'NFE_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALDESCTO', ftInteger)]
    [Dictionary('NFE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALDESCTO: Integer read FNFE_TOTALDESCTO write FNFE_TOTALDESCTO;
    const NFE_TOTALDESCTO_Name = 'NFE_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALNOTAFISCAL: Double read FNFE_TOTALNOTAFISCAL write FNFE_TOTALNOTAFISCAL;
    const NFE_TOTALNOTAFISCAL_Name = 'NFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALPESOLIQUIDO', ftInteger)]
    [Dictionary('NFE_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALPESOLIQUIDO: Integer read FNFE_TOTALPESOLIQUIDO write FNFE_TOTALPESOLIQUIDO;
    const NFE_TOTALPESOLIQUIDO_Name = 'NFE_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NFE_OBSERVACAO', ftString, 300)]
    [Dictionary('NFE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_OBSERVACAO: String read FNFE_OBSERVACAO write FNFE_OBSERVACAO;
    const NFE_OBSERVACAO_Name = 'NFE_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_CANCELADA', ftString, 1)]
    [Dictionary('NFE_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CANCELADA: String read FNFE_CANCELADA write FNFE_CANCELADA;
    const NFE_CANCELADA_Name = 'NFE_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALICMSFRETECTR', ftBCD)]
    [Dictionary('NFE_TOTALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSFRETECTR: Double read FNFE_TOTALICMSFRETECTR write FNFE_TOTALICMSFRETECTR;
    const NFE_TOTALICMSFRETECTR_Name = 'NFE_TOTALICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSFRETECTR', ftBCD, 48, 2)]
    [Dictionary('NFE_PERCENTUALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSFRETECTR: Double read FNFE_PERCENTUALICMSFRETECTR write FNFE_PERCENTUALICMSFRETECTR;
    const NFE_PERCENTUALICMSFRETECTR_Name = 'NFE_PERCENTUALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALBCICMSFRETECTR', ftBCD, 48, 2)]
    [Dictionary('NFE_TOTALBCICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCICMSFRETECTR: Double read FNFE_TOTALBCICMSFRETECTR write FNFE_TOTALBCICMSFRETECTR;
    const NFE_TOTALBCICMSFRETECTR_Name = 'NFE_TOTALBCICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPOFRETE', ftString, 1)]
    [Dictionary('NFE_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOFRETE: String read FNFE_TIPOFRETE write FNFE_TIPOFRETE;
    const NFE_TIPOFRETE_Name = 'NFE_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALIPI', ftInteger)]
    [Dictionary('NFE_TOTALIPI', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALIPI: Integer read FNFE_TOTALIPI write FNFE_TOTALIPI;
    const NFE_TOTALIPI_Name = 'NFE_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALICMS', ftInteger)]
    [Dictionary('NFE_TOTALICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALICMS: Integer read FNFE_TOTALICMS write FNFE_TOTALICMS;
    const NFE_TOTALICMS_Name = 'NFE_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALICMSR', ftInteger)]
    [Dictionary('NFE_TOTALICMSR', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALICMSR: Integer read FNFE_TOTALICMSR write FNFE_TOTALICMSR;
    const NFE_TOTALICMSR_Name = 'NFE_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALCOFINS', ftInteger)]
    [Dictionary('NFE_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALCOFINS: Integer read FNFE_TOTALCOFINS write FNFE_TOTALCOFINS;
    const NFE_TOTALCOFINS_Name = 'NFE_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALPRODUTOS', ftInteger)]
    [Dictionary('NFE_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALPRODUTOS: Integer read FNFE_TOTALPRODUTOS write FNFE_TOTALPRODUTOS;
    const NFE_TOTALPRODUTOS_Name = 'NFE_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALPESOBRUTO', ftInteger)]
    [Dictionary('NFE_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALPESOBRUTO: Integer read FNFE_TOTALPESOBRUTO write FNFE_TOTALPESOBRUTO;
    const NFE_TOTALPESOBRUTO_Name = 'NFE_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALBASEISENTOICMS', ftInteger)]
    [Dictionary('NFE_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALBASEISENTOICMS: Integer read FNFE_TOTALBASEISENTOICMS write FNFE_TOTALBASEISENTOICMS;
    const NFE_TOTALBASEISENTOICMS_Name = 'NFE_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALBASECALCULOICMS', ftInteger)]
    [Dictionary('NFE_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALBASECALCULOICMS: Integer read FNFE_TOTALBASECALCULOICMS write FNFE_TOTALBASECALCULOICMS;
    const NFE_TOTALBASECALCULOICMS_Name = 'NFE_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALBASECALCULOMVA', ftInteger)]
    [Dictionary('NFE_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_TOTALBASECALCULOMVA: Integer read FNFE_TOTALBASECALCULOMVA write FNFE_TOTALBASECALCULOMVA;
    const NFE_TOTALBASECALCULOMVA_Name = 'NFE_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('NFE_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAVENCIMENTO: TDateTime read FNFE_DATAVENCIMENTO write FNFE_DATAVENCIMENTO;
    const NFE_DATAVENCIMENTO_Name = 'NFE_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('NFE_CHAVEACESSO', ftString, 44)]
    [Dictionary('NFE_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CHAVEACESSO: String read FNFE_CHAVEACESSO write FNFE_CHAVEACESSO;
    const NFE_CHAVEACESSO_Name = 'NFE_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALBASEOUTROS', ftBCD)]
    [Dictionary('NFE_TOTALBASEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASEOUTROS: Double read FNFE_TOTALBASEOUTROS write FNFE_TOTALBASEOUTROS;
    const NFE_TOTALBASEOUTROS_Name = 'NFE_TOTALBASEOUTROS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_LivroFiscalCTR)

end.
