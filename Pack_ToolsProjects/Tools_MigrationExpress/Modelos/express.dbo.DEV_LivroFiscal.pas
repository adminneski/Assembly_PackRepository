unit express.dbo.DEV_LIVROFISCAL;

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
  [Table('DEV_LivroFiscal', '')]
  TDtoDEV_LivroFiscal = class
  private
    { Private declarations } 
    FDEV_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_CLIENTECONTRIBUINTENAOSIMPLES: String;
    FDEV_TIPOPAGAMENTO: String;
    FPES_UF: String;
    FDEV_NOTAFISCAL: String;
    FDEV_DATALANCAMENTO: TDateTime;
    FTDC_CODIGO: String;
    FMNF_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FTRP_CODIGO: Integer;
    FDEV_SERIE: String;
    FDEV_EMITENTE: String;
    FDEV_TOTALFRETE: Double;
    FDEV_TOTALSEGURO: Double;
    FDEV_TOTALDESPACESSORIA: Double;
    FDEV_TOTALPIS: Double;
    FDEV_TOTALCOFINS: Double;
    FDEV_TOTALCOMPLEMENTONFICMS: Double;
    FDEV_TOTALSERVICO: Double;
    FDEV_TOTALDESCTO: Double;
    FDEV_TOTALLIQUIDO: Double;
    FDEV_TOTALPESOLIQUIDO: Double;
    FDEV_OBSERVACAO: String;
    FDEV_CANCELADA: String;
    FDEV_TIPOFRETE: String;
    FDEV_TOTALIPI: Double;
    FDEV_TOTALICMS: Double;
    FDEV_TOTALICMSR: Double;
    FDEV_TOTALPRODUTOS: Double;
    FDEV_TOTALPESOBRUTO: Double;
    FDEV_TOTALBASEISENTOICMS: Double;
    FDEV_TOTALBASECALCULOICMS: Double;
    FDEV_TOTALBCALCULOPISCOFINS: Double;
    FDEV_TOTALBASECALCULOMVA: Double;
    FDEV_TOTALNUMEROVOLUMES: Double;
    FDEV_NUMERACAOVOLUMES: String;
    FDEV_ESPECIEVOLUMES: String;
    FDEV_MARCAVOLUMES: String;
    FDEV_INFCOMPLEMENTAR: String;
    FPES_TIPOPESSOA: String;
    FDEV_PLACAVEICULO: String;
    FDEV_UFVEICULO: String;
    FPES_PONTOREFERENCIA: String;
    FDEV_PERCENTUALIBPT: Double;
    FDEV_TOTALAPROXIMADOIMPOSTO: Double;
    FDEV_CHAVEACESSO: String;
    FDEV_CHAVEREFERENCIANFE: String;
  public 
    { Public declarations } 
     const Table      = 'DEV_LivroFiscal';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_ID', ftInteger)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;
    const DEV_ID_Name = 'DEV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
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
    [Column('PES_CLIENTECONTRIBUINTENAOSIMPLES', ftString, 1)]
    [Dictionary('PES_CLIENTECONTRIBUINTENAOSIMPLES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CLIENTECONTRIBUINTENAOSIMPLES: String read FPES_CLIENTECONTRIBUINTENAOSIMPLES write FPES_CLIENTECONTRIBUINTENAOSIMPLES;
    const PES_CLIENTECONTRIBUINTENAOSIMPLES_Name = 'PES_CLIENTECONTRIBUINTENAOSIMPLES';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TIPOPAGAMENTO', ftString, 1)]
    [Dictionary('DEV_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_TIPOPAGAMENTO: String read FDEV_TIPOPAGAMENTO write FDEV_TIPOPAGAMENTO;
    const DEV_TIPOPAGAMENTO_Name = 'DEV_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('DEV_NOTAFISCAL', ftString, 9)]
    [Dictionary('DEV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NOTAFISCAL: String read FDEV_NOTAFISCAL write FDEV_NOTAFISCAL;
    const DEV_NOTAFISCAL_Name = 'DEV_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DEV_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATALANCAMENTO: TDateTime read FDEV_DATALANCAMENTO write FDEV_DATALANCAMENTO;
    const DEV_DATALANCAMENTO_Name = 'DEV_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

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
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEV_SERIE', ftString, 3)]
    [Dictionary('DEV_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_SERIE: String read FDEV_SERIE write FDEV_SERIE;
    const DEV_SERIE_Name = 'DEV_SERIE';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_EMITENTE', ftString, 1)]
    [Dictionary('DEV_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_EMITENTE: String read FDEV_EMITENTE write FDEV_EMITENTE;
    const DEV_EMITENTE_Name = 'DEV_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALFRETE', ftBCD, 10, 2)]
    [Dictionary('DEV_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFRETE: Double read FDEV_TOTALFRETE write FDEV_TOTALFRETE;
    const DEV_TOTALFRETE_Name = 'DEV_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALSEGURO', ftBCD)]
    [Dictionary('DEV_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSEGURO: Double read FDEV_TOTALSEGURO write FDEV_TOTALSEGURO;
    const DEV_TOTALSEGURO_Name = 'DEV_TOTALSEGURO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('DEV_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESPACESSORIA: Double read FDEV_TOTALDESPACESSORIA write FDEV_TOTALDESPACESSORIA;
    const DEV_TOTALDESPACESSORIA_Name = 'DEV_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALPIS', ftBCD)]
    [Dictionary('DEV_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPIS: Double read FDEV_TOTALPIS write FDEV_TOTALPIS;
    const DEV_TOTALPIS_Name = 'DEV_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALCOFINS', ftBCD)]
    [Dictionary('DEV_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOFINS: Double read FDEV_TOTALCOFINS write FDEV_TOTALCOFINS;
    const DEV_TOTALCOFINS_Name = 'DEV_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('DEV_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMPLEMENTONFICMS: Double read FDEV_TOTALCOMPLEMENTONFICMS write FDEV_TOTALCOMPLEMENTONFICMS;
    const DEV_TOTALCOMPLEMENTONFICMS_Name = 'DEV_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALSERVICO', ftBCD)]
    [Dictionary('DEV_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSERVICO: Double read FDEV_TOTALSERVICO write FDEV_TOTALSERVICO;
    const DEV_TOTALSERVICO_Name = 'DEV_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESCTO', ftBCD)]
    [Dictionary('DEV_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTO: Double read FDEV_TOTALDESCTO write FDEV_TOTALDESCTO;
    const DEV_TOTALDESCTO_Name = 'DEV_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALLIQUIDO: Double read FDEV_TOTALLIQUIDO write FDEV_TOTALLIQUIDO;
    const DEV_TOTALLIQUIDO_Name = 'DEV_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALPESOLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPESOLIQUIDO: Double read FDEV_TOTALPESOLIQUIDO write FDEV_TOTALPESOLIQUIDO;
    const DEV_TOTALPESOLIQUIDO_Name = 'DEV_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('DEV_OBSERVACAO', ftString, 5000)]
    [Dictionary('DEV_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_OBSERVACAO: String read FDEV_OBSERVACAO write FDEV_OBSERVACAO;
    const DEV_OBSERVACAO_Name = 'DEV_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('DEV_CANCELADA', ftString, 1)]
    [Dictionary('DEV_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CANCELADA: String read FDEV_CANCELADA write FDEV_CANCELADA;
    const DEV_CANCELADA_Name = 'DEV_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('DEV_TIPOFRETE', ftString, 1)]
    [Dictionary('DEV_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_TIPOFRETE: String read FDEV_TIPOFRETE write FDEV_TIPOFRETE;
    const DEV_TIPOFRETE_Name = 'DEV_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALIPI', ftBCD)]
    [Dictionary('DEV_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIPI: Double read FDEV_TOTALIPI write FDEV_TOTALIPI;
    const DEV_TOTALIPI_Name = 'DEV_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALICMS', ftBCD)]
    [Dictionary('DEV_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMS: Double read FDEV_TOTALICMS write FDEV_TOTALICMS;
    const DEV_TOTALICMS_Name = 'DEV_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALICMSR', ftBCD, 10, 2)]
    [Dictionary('DEV_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSR: Double read FDEV_TOTALICMSR write FDEV_TOTALICMSR;
    const DEV_TOTALICMSR_Name = 'DEV_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALPRODUTOS', ftBCD)]
    [Dictionary('DEV_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRODUTOS: Double read FDEV_TOTALPRODUTOS write FDEV_TOTALPRODUTOS;
    const DEV_TOTALPRODUTOS_Name = 'DEV_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPESOBRUTO', ftBCD)]
    [Dictionary('DEV_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPESOBRUTO: Double read FDEV_TOTALPESOBRUTO write FDEV_TOTALPESOBRUTO;
    const DEV_TOTALPESOBRUTO_Name = 'DEV_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('DEV_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEISENTOICMS: Double read FDEV_TOTALBASEISENTOICMS write FDEV_TOTALBASEISENTOICMS;
    const DEV_TOTALBASEISENTOICMS_Name = 'DEV_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOICMS: Double read FDEV_TOTALBASECALCULOICMS write FDEV_TOTALBASECALCULOICMS;
    const DEV_TOTALBASECALCULOICMS_Name = 'DEV_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('DEV_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBCALCULOPISCOFINS: Double read FDEV_TOTALBCALCULOPISCOFINS write FDEV_TOTALBCALCULOPISCOFINS;
    const DEV_TOTALBCALCULOPISCOFINS_Name = 'DEV_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOMVA: Double read FDEV_TOTALBASECALCULOMVA write FDEV_TOTALBASECALCULOMVA;
    const DEV_TOTALBASECALCULOMVA_Name = 'DEV_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('DEV_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALNUMEROVOLUMES: Double read FDEV_TOTALNUMEROVOLUMES write FDEV_TOTALNUMEROVOLUMES;
    const DEV_TOTALNUMEROVOLUMES_Name = 'DEV_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('DEV_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('DEV_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NUMERACAOVOLUMES: String read FDEV_NUMERACAOVOLUMES write FDEV_NUMERACAOVOLUMES;
    const DEV_NUMERACAOVOLUMES_Name = 'DEV_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('DEV_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('DEV_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_ESPECIEVOLUMES: String read FDEV_ESPECIEVOLUMES write FDEV_ESPECIEVOLUMES;
    const DEV_ESPECIEVOLUMES_Name = 'DEV_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('DEV_MARCAVOLUMES', ftString, 30)]
    [Dictionary('DEV_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_MARCAVOLUMES: String read FDEV_MARCAVOLUMES write FDEV_MARCAVOLUMES;
    const DEV_MARCAVOLUMES_Name = 'DEV_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('DEV_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('DEV_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_INFCOMPLEMENTAR: String read FDEV_INFCOMPLEMENTAR write FDEV_INFCOMPLEMENTAR;
    const DEV_INFCOMPLEMENTAR_Name = 'DEV_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('DEV_PLACAVEICULO', ftString, 7)]
    [Dictionary('DEV_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_PLACAVEICULO: String read FDEV_PLACAVEICULO write FDEV_PLACAVEICULO;
    const DEV_PLACAVEICULO_Name = 'DEV_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('DEV_UFVEICULO', ftString, 2)]
    [Dictionary('DEV_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_UFVEICULO: String read FDEV_UFVEICULO write FDEV_UFVEICULO;
    const DEV_UFVEICULO_Name = 'DEV_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA: String read FPES_PONTOREFERENCIA write FPES_PONTOREFERENCIA;
    const PES_PONTOREFERENCIA_Name = 'PES_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPT', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPT: Double read FDEV_PERCENTUALIBPT write FDEV_PERCENTUALIBPT;
    const DEV_PERCENTUALIBPT_Name = 'DEV_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('DEV_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALAPROXIMADOIMPOSTO: Double read FDEV_TOTALAPROXIMADOIMPOSTO write FDEV_TOTALAPROXIMADOIMPOSTO;
    const DEV_TOTALAPROXIMADOIMPOSTO_Name = 'DEV_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('DEV_CHAVEACESSO', ftString, 44)]
    [Dictionary('DEV_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CHAVEACESSO: String read FDEV_CHAVEACESSO write FDEV_CHAVEACESSO;
    const DEV_CHAVEACESSO_Name = 'DEV_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('DEV_CHAVEREFERENCIANFE', ftString, 44)]
    [Dictionary('DEV_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CHAVEREFERENCIANFE: String read FDEV_CHAVEREFERENCIANFE write FDEV_CHAVEREFERENCIANFE;
    const DEV_CHAVEREFERENCIANFE_Name = 'DEV_CHAVEREFERENCIANFE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDEV_LivroFiscal)

end.
