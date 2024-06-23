unit express.dbo.NFP_LIVROFISCAL;

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
  [Table('NFP_LivroFiscal', '')]
  TDtoNFP_LivroFiscal = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FTDC_CODIGO: String;
    FNFP_SERIE: String;
    FMNF_CODIGO: String;
    FNFP_NOTAFISCAL: String;
    FNFP_DATALANCAMENTO: TDateTime;
    FNFP_TOTALFRETENF: Double;
    FNFP_TOTALSEGURO: Double;
    FNFP_TOTALDESPACESSORIA: Double;
    FNFP_TOTALPIS: Double;
    FNFP_TOTALCOMPLEMENTONFICMS: Double;
    FNFP_TOTALSERVICO: Double;
    FNFP_TOTALDESCTO: Double;
    FNFP_TOTALNOTAFISCAL: Double;
    FNFP_TOTALPESOLIQUIDO: Double;
    FNFP_OBSERVACAO: String;
    FNFP_CANCELADA: String;
    FNFP_DESATIVADO: String;
    FTRP_CODIGO: Integer;
    FNFP_TIPOFRETE: String;
    FNFP_TOTALIPI: Double;
    FNFP_TOTALICMS: Double;
    FNFP_TOTALICMSR: Integer;
    FNFP_TOTALCOFINS: Double;
    FNFP_TOTALPRODUTOS: Double;
    FNFP_TOTALPESOBRUTO: Double;
    FNFP_TOTALBASEISENTOICMS: Double;
    FNFP_TOTALBASECALCULOICMS: Double;
    FNFP_TOTALBASECALCULOMVA: Integer;
    FNFP_TOTALNUMEROVOLUMES: Double;
    FNFP_NUMERACAOVOLUMES: String;
    FNFP_ESPECIEVOLUMES: String;
    FNFP_MARCAVOLUMES: String;
    FNFP_TOTALBCALCULOPISCOFINS: Double;
    FNFP_CHAVEACESSO: String;
  public 
    { Public declarations } 
     const Table      = 'NFP_LivroFiscal';

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
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFP_SERIE', ftString, 3)]
    [Dictionary('NFP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_SERIE: String read FNFP_SERIE write FNFP_SERIE;
    const NFP_SERIE_Name = 'NFP_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFP_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NOTAFISCAL: String read FNFP_NOTAFISCAL write FNFP_NOTAFISCAL;
    const NFP_NOTAFISCAL_Name = 'NFP_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATALANCAMENTO: TDateTime read FNFP_DATALANCAMENTO write FNFP_DATALANCAMENTO;
    const NFP_DATALANCAMENTO_Name = 'NFP_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALFRETENF', ftBCD, 48, 2)]
    [Dictionary('NFP_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETENF: Double read FNFP_TOTALFRETENF write FNFP_TOTALFRETENF;
    const NFP_TOTALFRETENF_Name = 'NFP_TOTALFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALSEGURO', ftBCD)]
    [Dictionary('NFP_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALSEGURO: Double read FNFP_TOTALSEGURO write FNFP_TOTALSEGURO;
    const NFP_TOTALSEGURO_Name = 'NFP_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALDESPACESSORIA', ftBCD, 1329815375, 2)]
    [Dictionary('NFP_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESPACESSORIA: Double read FNFP_TOTALDESPACESSORIA write FNFP_TOTALDESPACESSORIA;
    const NFP_TOTALDESPACESSORIA_Name = 'NFP_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALPIS', ftBCD, 1229213507, 2)]
    [Dictionary('NFP_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPIS: Double read FNFP_TOTALPIS write FNFP_TOTALPIS;
    const NFP_TOTALPIS_Name = 'NFP_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALCOMPLEMENTONFICMS', ftBCD, 16385, 2)]
    [Dictionary('NFP_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALCOMPLEMENTONFICMS: Double read FNFP_TOTALCOMPLEMENTONFICMS write FNFP_TOTALCOMPLEMENTONFICMS;
    const NFP_TOTALCOMPLEMENTONFICMS_Name = 'NFP_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALSERVICO', ftBCD, 1, 2)]
    [Dictionary('NFP_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALSERVICO: Double read FNFP_TOTALSERVICO write FNFP_TOTALSERVICO;
    const NFP_TOTALSERVICO_Name = 'NFP_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALDESCTO', ftBCD)]
    [Dictionary('NFP_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESCTO: Double read FNFP_TOTALDESCTO write FNFP_TOTALDESCTO;
    const NFP_TOTALDESCTO_Name = 'NFP_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALNOTAFISCAL', ftBCD, 52, 2)]
    [Dictionary('NFP_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALNOTAFISCAL: Double read FNFP_TOTALNOTAFISCAL write FNFP_TOTALNOTAFISCAL;
    const NFP_TOTALNOTAFISCAL_Name = 'NFP_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('NFP_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPESOLIQUIDO: Double read FNFP_TOTALPESOLIQUIDO write FNFP_TOTALPESOLIQUIDO;
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

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TIPOFRETE', ftString, 1)]
    [Dictionary('NFP_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_TIPOFRETE: String read FNFP_TIPOFRETE write FNFP_TIPOFRETE;
    const NFP_TIPOFRETE_Name = 'NFP_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALIPI', ftBCD, 2097184, 2)]
    [Dictionary('NFP_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALIPI: Double read FNFP_TOTALIPI write FNFP_TOTALIPI;
    const NFP_TOTALIPI_Name = 'NFP_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALICMS', ftBCD, 5177428, 2)]
    [Dictionary('NFP_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMS: Double read FNFP_TOTALICMS write FNFP_TOTALICMS;
    const NFP_TOTALICMS_Name = 'NFP_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALICMSR', ftInteger)]
    [Dictionary('NFP_TOTALICMSR', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALICMSR: Integer read FNFP_TOTALICMSR write FNFP_TOTALICMSR;
    const NFP_TOTALICMSR_Name = 'NFP_TOTALICMSR';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALCOFINS', ftBCD, 5374017, 2)]
    [Dictionary('NFP_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALCOFINS: Double read FNFP_TOTALCOFINS write FNFP_TOTALCOFINS;
    const NFP_TOTALCOFINS_Name = 'NFP_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPRODUTOS', ftBCD, 4522067, 2)]
    [Dictionary('NFP_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPRODUTOS: Double read FNFP_TOTALPRODUTOS write FNFP_TOTALPRODUTOS;
    const NFP_TOTALPRODUTOS_Name = 'NFP_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('NFP_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPESOBRUTO: Double read FNFP_TOTALPESOBRUTO write FNFP_TOTALPESOBRUTO;
    const NFP_TOTALPESOBRUTO_Name = 'NFP_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASEISENTOICMS', ftBCD, 538970637, 2)]
    [Dictionary('NFP_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASEISENTOICMS: Double read FNFP_TOTALBASEISENTOICMS write FNFP_TOTALBASEISENTOICMS;
    const NFP_TOTALBASEISENTOICMS_Name = 'NFP_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALBASECALCULOICMS', ftBCD, 1953391939, 2)]
    [Dictionary('NFP_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASECALCULOICMS: Double read FNFP_TOTALBASECALCULOICMS write FNFP_TOTALBASECALCULOICMS;
    const NFP_TOTALBASECALCULOICMS_Name = 'NFP_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALBASECALCULOMVA', ftInteger)]
    [Dictionary('NFP_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_TOTALBASECALCULOMVA: Integer read FNFP_TOTALBASECALCULOMVA write FNFP_TOTALBASECALCULOMVA;
    const NFP_TOTALBASECALCULOMVA_Name = 'NFP_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALNUMEROVOLUMES', ftBCD, 4587552, 2)]
    [Dictionary('NFP_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALNUMEROVOLUMES: Double read FNFP_TOTALNUMEROVOLUMES write FNFP_TOTALNUMEROVOLUMES;
    const NFP_TOTALNUMEROVOLUMES_Name = 'NFP_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('NFP_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('NFP_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMERACAOVOLUMES: String read FNFP_NUMERACAOVOLUMES write FNFP_NUMERACAOVOLUMES;
    const NFP_NUMERACAOVOLUMES_Name = 'NFP_NUMERACAOVOLUMES';

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
    [Column('NFP_TOTALBCALCULOPISCOFINS', ftBCD, 2097196, 2)]
    [Dictionary('NFP_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBCALCULOPISCOFINS: Double read FNFP_TOTALBCALCULOPISCOFINS write FNFP_TOTALBCALCULOPISCOFINS;
    const NFP_TOTALBCALCULOPISCOFINS_Name = 'NFP_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('NFP_CHAVEACESSO', ftString, 44)]
    [Dictionary('NFP_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_CHAVEACESSO: String read FNFP_CHAVEACESSO write FNFP_CHAVEACESSO;
    const NFP_CHAVEACESSO_Name = 'NFP_CHAVEACESSO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_LivroFiscal)

end.
