unit express.dbo.NFP_LIVROFISCALCTR;

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
  [Table('NFP_LivroFiscalCTR', '')]
  TDtoNFP_LivroFiscalCTR = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_UF: String;
    FNFP_NOTAFISCAL: String;
    FNFP_DATAEMISSAO: TDateTime;
    FNFP_DATAENTRADA: TDateTime;
    FNFP_DATALANCAMENTO: TDateTime;
    FNFP_DATAVENCIMENTO: TDateTime;
    FMNF_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FTDC_CODIGO: String;
    FNFP_SERIE: String;
    FNFP_EMITENTE: String;
    FNFP_TOTALFRETECTR: Double;
    FNFP_TOTALSEGURO: Integer;
    FNFP_TOTALDESPACESSORIA: Integer;
    FNFP_TOTALPIS: Integer;
    FNFP_TOTALCOMPLEMENTONFICMS: Integer;
    FNFP_TOTALSERVICO: Integer;
    FNFP_TOTALDESCTO: Integer;
    FNFP_TOTALNOTAFISCAL: Double;
    FNFP_TOTALPESOLIQUIDO: Integer;
    FNFP_OBSERVACAO: String;
    FNFP_CANCELADA: String;
    FNFP_DESATIVADO: String;
    FNFP_TOTALICMSFRETECTR: Double;
    FNFP_PERCENTUALICMSFRETECTR: Double;
    FNFP_TOTALRBCICMSFRETECTR: Double;
    FNFP_TIPOFRETE: String;
    FNFP_TOTALIPI: Integer;
    FNFP_TOTALICMS: Integer;
    FNFP_TOTALICMSR: Integer;
    FNFP_TOTALCOFINS: Integer;
    FNFP_TOTALPRODUTOS: Integer;
    FNFP_TOTALPESOBRUTO: Integer;
    FNFP_TOTALBASEISENTOICMS: Integer;
    FNFP_TOTALBASECALCULOICMS: Integer;
    FNFP_TOTALBASECALCULOMVA: Integer;
    FNFP_PLACAVEICULO: String;
    FNFP_UFVEICULO: String;
    FNFP_CHAVEACESSO: String;
  public 
    { Public declarations } 
     const Table      = 'NFP_LivroFiscalCTR';

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
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NOTAFISCAL: String read FNFP_NOTAFISCAL write FNFP_NOTAFISCAL;
    const NFP_NOTAFISCAL_Name = 'NFP_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAEMISSAO', ftDateTime)]
    [Dictionary('NFP_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAEMISSAO: TDateTime read FNFP_DATAEMISSAO write FNFP_DATAEMISSAO;
    const NFP_DATAEMISSAO_Name = 'NFP_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAENTRADA', ftDateTime)]
    [Dictionary('NFP_DATAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAENTRADA: TDateTime read FNFP_DATAENTRADA write FNFP_DATAENTRADA;
    const NFP_DATAENTRADA_Name = 'NFP_DATAENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATALANCAMENTO: TDateTime read FNFP_DATALANCAMENTO write FNFP_DATALANCAMENTO;
    const NFP_DATALANCAMENTO_Name = 'NFP_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('NFP_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('NFP_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFP_DATAVENCIMENTO: TDateTime read FNFP_DATAVENCIMENTO write FNFP_DATAVENCIMENTO;
    const NFP_DATAVENCIMENTO_Name = 'NFP_DATAVENCIMENTO';

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
    [Column('NFP_SERIE', ftString, 3)]
    [Dictionary('NFP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_SERIE: String read FNFP_SERIE write FNFP_SERIE;
    const NFP_SERIE_Name = 'NFP_SERIE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_EMITENTE', ftString, 1)]
    [Dictionary('NFP_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_EMITENTE: String read FNFP_EMITENTE write FNFP_EMITENTE;
    const NFP_EMITENTE_Name = 'NFP_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALFRETECTR', ftBCD)]
    [Dictionary('NFP_TOTALFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETECTR: Double read FNFP_TOTALFRETECTR write FNFP_TOTALFRETECTR;
    const NFP_TOTALFRETECTR_Name = 'NFP_TOTALFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALSEGURO', ftInteger)]
    [Dictionary('NFP_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALSEGURO: Integer read FNFP_TOTALSEGURO write FNFP_TOTALSEGURO;
    const NFP_TOTALSEGURO_Name = 'NFP_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALDESPACESSORIA', ftInteger)]
    [Dictionary('NFP_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALDESPACESSORIA: Integer read FNFP_TOTALDESPACESSORIA write FNFP_TOTALDESPACESSORIA;
    const NFP_TOTALDESPACESSORIA_Name = 'NFP_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPIS', ftInteger)]
    [Dictionary('NFP_TOTALPIS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALPIS: Integer read FNFP_TOTALPIS write FNFP_TOTALPIS;
    const NFP_TOTALPIS_Name = 'NFP_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALCOMPLEMENTONFICMS', ftInteger)]
    [Dictionary('NFP_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALCOMPLEMENTONFICMS: Integer read FNFP_TOTALCOMPLEMENTONFICMS write FNFP_TOTALCOMPLEMENTONFICMS;
    const NFP_TOTALCOMPLEMENTONFICMS_Name = 'NFP_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALSERVICO', ftInteger)]
    [Dictionary('NFP_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALSERVICO: Integer read FNFP_TOTALSERVICO write FNFP_TOTALSERVICO;
    const NFP_TOTALSERVICO_Name = 'NFP_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALDESCTO', ftInteger)]
    [Dictionary('NFP_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALDESCTO: Integer read FNFP_TOTALDESCTO write FNFP_TOTALDESCTO;
    const NFP_TOTALDESCTO_Name = 'NFP_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NFP_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALNOTAFISCAL: Double read FNFP_TOTALNOTAFISCAL write FNFP_TOTALNOTAFISCAL;
    const NFP_TOTALNOTAFISCAL_Name = 'NFP_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPESOLIQUIDO', ftInteger)]
    [Dictionary('NFP_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALPESOLIQUIDO: Integer read FNFP_TOTALPESOLIQUIDO write FNFP_TOTALPESOLIQUIDO;
    const NFP_TOTALPESOLIQUIDO_Name = 'NFP_TOTALPESOLIQUIDO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DESATIVADO', ftString, 1)]
    [Dictionary('NFP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_DESATIVADO: String read FNFP_DESATIVADO write FNFP_DESATIVADO;
    const NFP_DESATIVADO_Name = 'NFP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALICMSFRETECTR', ftBCD, 48, 2)]
    [Dictionary('NFP_TOTALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSFRETECTR: Double read FNFP_TOTALICMSFRETECTR write FNFP_TOTALICMSFRETECTR;
    const NFP_TOTALICMSFRETECTR_Name = 'NFP_TOTALICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALICMSFRETECTR', ftBCD)]
    [Dictionary('NFP_PERCENTUALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSFRETECTR: Double read FNFP_PERCENTUALICMSFRETECTR write FNFP_PERCENTUALICMSFRETECTR;
    const NFP_PERCENTUALICMSFRETECTR_Name = 'NFP_PERCENTUALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALRBCICMSFRETECTR', ftBCD)]
    [Dictionary('NFP_TOTALRBCICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALRBCICMSFRETECTR: Double read FNFP_TOTALRBCICMSFRETECTR write FNFP_TOTALRBCICMSFRETECTR;
    const NFP_TOTALRBCICMSFRETECTR_Name = 'NFP_TOTALRBCICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TIPOFRETE', ftString, 1)]
    [Dictionary('NFP_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_TIPOFRETE: String read FNFP_TIPOFRETE write FNFP_TIPOFRETE;
    const NFP_TIPOFRETE_Name = 'NFP_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALIPI', ftInteger)]
    [Dictionary('NFP_TOTALIPI', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALIPI: Integer read FNFP_TOTALIPI write FNFP_TOTALIPI;
    const NFP_TOTALIPI_Name = 'NFP_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALICMS', ftInteger)]
    [Dictionary('NFP_TOTALICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALICMS: Integer read FNFP_TOTALICMS write FNFP_TOTALICMS;
    const NFP_TOTALICMS_Name = 'NFP_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALICMSR', ftInteger)]
    [Dictionary('NFP_TOTALICMSR', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALICMSR: Integer read FNFP_TOTALICMSR write FNFP_TOTALICMSR;
    const NFP_TOTALICMSR_Name = 'NFP_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALCOFINS', ftInteger)]
    [Dictionary('NFP_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALCOFINS: Integer read FNFP_TOTALCOFINS write FNFP_TOTALCOFINS;
    const NFP_TOTALCOFINS_Name = 'NFP_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPRODUTOS', ftInteger)]
    [Dictionary('NFP_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALPRODUTOS: Integer read FNFP_TOTALPRODUTOS write FNFP_TOTALPRODUTOS;
    const NFP_TOTALPRODUTOS_Name = 'NFP_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPESOBRUTO', ftInteger)]
    [Dictionary('NFP_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALPESOBRUTO: Integer read FNFP_TOTALPESOBRUTO write FNFP_TOTALPESOBRUTO;
    const NFP_TOTALPESOBRUTO_Name = 'NFP_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALBASEISENTOICMS', ftInteger)]
    [Dictionary('NFP_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALBASEISENTOICMS: Integer read FNFP_TOTALBASEISENTOICMS write FNFP_TOTALBASEISENTOICMS;
    const NFP_TOTALBASEISENTOICMS_Name = 'NFP_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALBASECALCULOICMS', ftInteger)]
    [Dictionary('NFP_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALBASECALCULOICMS: Integer read FNFP_TOTALBASECALCULOICMS write FNFP_TOTALBASECALCULOICMS;
    const NFP_TOTALBASECALCULOICMS_Name = 'NFP_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALBASECALCULOMVA', ftInteger)]
    [Dictionary('NFP_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALBASECALCULOMVA: Integer read FNFP_TOTALBASECALCULOMVA write FNFP_TOTALBASECALCULOMVA;
    const NFP_TOTALBASECALCULOMVA_Name = 'NFP_TOTALBASECALCULOMVA';

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
    [Column('NFP_CHAVEACESSO', ftString, 44)]
    [Dictionary('NFP_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_CHAVEACESSO: String read FNFP_CHAVEACESSO write FNFP_CHAVEACESSO;
    const NFP_CHAVEACESSO_Name = 'NFP_CHAVEACESSO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_LivroFiscalCTR)

end.
