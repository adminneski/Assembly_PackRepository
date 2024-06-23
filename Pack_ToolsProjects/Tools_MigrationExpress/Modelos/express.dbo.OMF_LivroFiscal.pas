unit express.dbo.OMF_LIVROFISCAL;

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
  [Table('OMF_LivroFiscal', '')]
  TDtoOMF_LivroFiscal = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_TIPOPAGAMENTO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_UF: String;
    FOMF_NOTAFISCAL: String;
    FOMF_FINALIDADE: String;
    FOMF_DATAEMISSAO: TDateTime;
    FOMF_DATAENTRADA: TDateTime;
    FOMF_DATALANCAMENTO: TDateTime;
    FMNF_CODIGO: String;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FOMF_SERIE: String;
    FOMF_EMITENTE: String;
    FOMF_TOTALFRETENF: Double;
    FOMF_TOTALSEGURO: Double;
    FOMF_TOTALDESPACESSORIA: Double;
    FOMF_TOTALPIS: Double;
    FOMF_TOTALCOMPLEMENTONFICMS: Double;
    FOMF_TOTALSERVICO: Double;
    FOMF_TOTALDESCTO: Double;
    FOMF_TOTALNOTAFISCAL: Double;
    FOMF_TOTALPESOLIQUIDO: Double;
    FOMF_OBSERVACAO: String;
    FOMF_CANCELADA: String;
    FOMF_TIPOFRETE: String;
    FOMF_TOTALIPI: Double;
    FOMF_TOTALICMS: Double;
    FOMF_TOTALICMSR: Double;
    FOMF_TOTALCOFINS: Double;
    FOMF_TOTALPRODUTOS: Double;
    FOMF_TOTALPESOBRUTO: Double;
    FOMF_TOTALBASEISENTOICMS: Double;
    FOMF_TOTALBASECALCULOICMS: Double;
    FOMF_TOTALBASECALCULOMVA: Double;
    FOMF_TOTALBCICMSDESPACESSORIA: Double;
    FOMF_TOTALBASECALCULOICMSFRETENF: Double;
    FOMF_PERCENTUALICMSFRETENF: Double;
    FOMF_PERCENTUALICMSDESPACESSORIA: Double;
    FOMF_TOTALBCALCULOPISCOFINS: Double;
    FOMF_CHAVEACESSO: String;
    FOMF_INFCOMPLEMENTAR: String;
    FPES_CLIENTECONTRIBUINTENAOSIMPLES: String;
    FOMF_TIPODOCUMENTO: String;
    FOMF_CHAVEREFERENCIANFE: TBlob;
    FOMF_TOTALNUMEROVOLUMES: Double;
    FOMF_NUMERACAOVOLUMES: String;
    FOMF_ESPECIEVOLUMES: String;
    FOMF_MARCAVOLUMES: String;
  public 
    { Public declarations } 
     const Table      = 'OMF_LivroFiscal';

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
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('OMF_NOTAFISCAL', ftString, 9)]
    [Dictionary('OMF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NOTAFISCAL: String read FOMF_NOTAFISCAL write FOMF_NOTAFISCAL;
    const OMF_NOTAFISCAL_Name = 'OMF_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('OMF_FINALIDADE', ftString, 1)]
    [Dictionary('OMF_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_FINALIDADE: String read FOMF_FINALIDADE write FOMF_FINALIDADE;
    const OMF_FINALIDADE_Name = 'OMF_FINALIDADE';

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

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

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
    [Column('OMF_TOTALFRETENF', ftBCD)]
    [Dictionary('OMF_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETENF: Double read FOMF_TOTALFRETENF write FOMF_TOTALFRETENF;
    const OMF_TOTALFRETENF_Name = 'OMF_TOTALFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALSEGURO', ftBCD)]
    [Dictionary('OMF_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSEGURO: Double read FOMF_TOTALSEGURO write FOMF_TOTALSEGURO;
    const OMF_TOTALSEGURO_Name = 'OMF_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('OMF_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESPACESSORIA: Double read FOMF_TOTALDESPACESSORIA write FOMF_TOTALDESPACESSORIA;
    const OMF_TOTALDESPACESSORIA_Name = 'OMF_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPIS', ftBCD)]
    [Dictionary('OMF_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPIS: Double read FOMF_TOTALPIS write FOMF_TOTALPIS;
    const OMF_TOTALPIS_Name = 'OMF_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('OMF_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOMPLEMENTONFICMS: Double read FOMF_TOTALCOMPLEMENTONFICMS write FOMF_TOTALCOMPLEMENTONFICMS;
    const OMF_TOTALCOMPLEMENTONFICMS_Name = 'OMF_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALSERVICO', ftBCD)]
    [Dictionary('OMF_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSERVICO: Double read FOMF_TOTALSERVICO write FOMF_TOTALSERVICO;
    const OMF_TOTALSERVICO_Name = 'OMF_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALDESCTO', ftBCD)]
    [Dictionary('OMF_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESCTO: Double read FOMF_TOTALDESCTO write FOMF_TOTALDESCTO;
    const OMF_TOTALDESCTO_Name = 'OMF_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('OMF_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALNOTAFISCAL: Double read FOMF_TOTALNOTAFISCAL write FOMF_TOTALNOTAFISCAL;
    const OMF_TOTALNOTAFISCAL_Name = 'OMF_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('OMF_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPESOLIQUIDO: Double read FOMF_TOTALPESOLIQUIDO write FOMF_TOTALPESOLIQUIDO;
    const OMF_TOTALPESOLIQUIDO_Name = 'OMF_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('OMF_OBSERVACAO', ftString, 300)]
    [Dictionary('OMF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_OBSERVACAO: String read FOMF_OBSERVACAO write FOMF_OBSERVACAO;
    const OMF_OBSERVACAO_Name = 'OMF_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_CANCELADA', ftString, 1)]
    [Dictionary('OMF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CANCELADA: String read FOMF_CANCELADA write FOMF_CANCELADA;
    const OMF_CANCELADA_Name = 'OMF_CANCELADA';

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
    [Column('OMF_TOTALICMS', ftBCD)]
    [Dictionary('OMF_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMS: Double read FOMF_TOTALICMS write FOMF_TOTALICMS;
    const OMF_TOTALICMS_Name = 'OMF_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMSR', ftBCD)]
    [Dictionary('OMF_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSR: Double read FOMF_TOTALICMSR write FOMF_TOTALICMSR;
    const OMF_TOTALICMSR_Name = 'OMF_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALCOFINS', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOFINS: Double read FOMF_TOTALCOFINS write FOMF_TOTALCOFINS;
    const OMF_TOTALCOFINS_Name = 'OMF_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPRODUTOS', ftBCD)]
    [Dictionary('OMF_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPRODUTOS: Double read FOMF_TOTALPRODUTOS write FOMF_TOTALPRODUTOS;
    const OMF_TOTALPRODUTOS_Name = 'OMF_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('OMF_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPESOBRUTO: Double read FOMF_TOTALPESOBRUTO write FOMF_TOTALPESOBRUTO;
    const OMF_TOTALPESOBRUTO_Name = 'OMF_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('OMF_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASEISENTOICMS: Double read FOMF_TOTALBASEISENTOICMS write FOMF_TOTALBASEISENTOICMS;
    const OMF_TOTALBASEISENTOICMS_Name = 'OMF_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBASECALCULOICMS', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOICMS: Double read FOMF_TOTALBASECALCULOICMS write FOMF_TOTALBASECALCULOICMS;
    const OMF_TOTALBASECALCULOICMS_Name = 'OMF_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOMVA', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOMVA: Double read FOMF_TOTALBASECALCULOMVA write FOMF_TOTALBASECALCULOMVA;
    const OMF_TOTALBASECALCULOMVA_Name = 'OMF_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCICMSDESPACESSORIA', ftBCD)]
    [Dictionary('OMF_TOTALBCICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCICMSDESPACESSORIA: Double read FOMF_TOTALBCICMSDESPACESSORIA write FOMF_TOTALBCICMSDESPACESSORIA;
    const OMF_TOTALBCICMSDESPACESSORIA_Name = 'OMF_TOTALBCICMSDESPACESSORIA';

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
    [Column('OMF_PERCENTUALICMSDESPACESSORIA', ftBCD, 48, 2)]
    [Dictionary('OMF_PERCENTUALICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSDESPACESSORIA: Double read FOMF_PERCENTUALICMSDESPACESSORIA write FOMF_PERCENTUALICMSDESPACESSORIA;
    const OMF_PERCENTUALICMSDESPACESSORIA_Name = 'OMF_PERCENTUALICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('OMF_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCALCULOPISCOFINS: Double read FOMF_TOTALBCALCULOPISCOFINS write FOMF_TOTALBCALCULOPISCOFINS;
    const OMF_TOTALBCALCULOPISCOFINS_Name = 'OMF_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('OMF_CHAVEACESSO', ftString, 44)]
    [Dictionary('OMF_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CHAVEACESSO: String read FOMF_CHAVEACESSO write FOMF_CHAVEACESSO;
    const OMF_CHAVEACESSO_Name = 'OMF_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('OMF_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('OMF_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INFCOMPLEMENTAR: String read FOMF_INFCOMPLEMENTAR write FOMF_INFCOMPLEMENTAR;
    const OMF_INFCOMPLEMENTAR_Name = 'OMF_INFCOMPLEMENTAR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CLIENTECONTRIBUINTENAOSIMPLES', ftString, 1)]
    [Dictionary('PES_CLIENTECONTRIBUINTENAOSIMPLES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CLIENTECONTRIBUINTENAOSIMPLES: String read FPES_CLIENTECONTRIBUINTENAOSIMPLES write FPES_CLIENTECONTRIBUINTENAOSIMPLES;
    const PES_CLIENTECONTRIBUINTENAOSIMPLES_Name = 'PES_CLIENTECONTRIBUINTENAOSIMPLES';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('OMF_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPODOCUMENTO: String read FOMF_TIPODOCUMENTO write FOMF_TIPODOCUMENTO;
    const OMF_TIPODOCUMENTO_Name = 'OMF_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('OMF_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('OMF_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CHAVEREFERENCIANFE: TBlob read FOMF_CHAVEREFERENCIANFE write FOMF_CHAVEREFERENCIANFE;
    const OMF_CHAVEREFERENCIANFE_Name = 'OMF_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('OMF_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALNUMEROVOLUMES: Double read FOMF_TOTALNUMEROVOLUMES write FOMF_TOTALNUMEROVOLUMES;
    const OMF_TOTALNUMEROVOLUMES_Name = 'OMF_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('OMF_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NUMERACAOVOLUMES: String read FOMF_NUMERACAOVOLUMES write FOMF_NUMERACAOVOLUMES;
    const OMF_NUMERACAOVOLUMES_Name = 'OMF_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('OMF_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_ESPECIEVOLUMES: String read FOMF_ESPECIEVOLUMES write FOMF_ESPECIEVOLUMES;
    const OMF_ESPECIEVOLUMES_Name = 'OMF_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_MARCAVOLUMES', ftString, 30)]
    [Dictionary('OMF_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_MARCAVOLUMES: String read FOMF_MARCAVOLUMES write FOMF_MARCAVOLUMES;
    const OMF_MARCAVOLUMES_Name = 'OMF_MARCAVOLUMES';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_LivroFiscal)

end.
