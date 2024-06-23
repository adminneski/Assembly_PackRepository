unit express.dbo.DEV_00;

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
  [Table('DEV_00', '')]
  [PrimaryKey('DEV_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DEV_ID')]
  TDtoDEV_00 = class
  private
    { Private declarations } 
    FDEV_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FMNF_CODIGO: String;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FVND_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FDEV_SERIE: String;
    FDEV_NOTAFISCAL: String;
    FDEV_DATALANCAMENTO: TDateTime;
    FDEV_NUMERODOCTO: String;
    FDEV_TOTALIPI: Double;
    FDEV_TOTALPIS: Double;
    FDEV_TOTALICMS: Double;
    FDEV_TOTALICMSR: Double;
    FDEV_TOTALFRETE: Double;
    FDEV_TOTALCOFINS: Double;
    FDEV_TOTALLIQUIDO: Double;
    FDEV_TOTALSEGURO: Double;
    FDEV_TOTALSERVICO: Double;
    FDEV_TOTALPRODUTOS: Double;
    FDEV_TOTALPESOBRUTO: Double;
    FDEV_TOTALPESOLIQUIDO: Double;
    FDEV_TOTALQTDDEVOLVIDA: Double;
    FDEV_TOTALSUBSTRIBUTARIA: Double;
    FDEV_TOTALDESPACESSORIA: Double;
    FDEV_TOTALBASEISENTOICMS: Double;
    FDEV_TOTALBASECALCULOICMS: Double;
    FDEV_TOTALBASECALCULOMVA: Double;
    FDEV_TOTALFINANCEIROPRAZO: Double;
    FDEV_TOTALCOMPLEMENTONFICMS: Double;
    FDEV_TOTALDESCTOITEM: Double;
    FDEV_TOTALDESCTOPRAZO: Double;
    FDEV_TOTALDESCTOAVULSO: Double;
    FDEV_TOTALCOMISSAO: Double;
    FDEV_TOTALADICIONAL: Double;
    FDEV_TOTALBCALCULOPISCOFINS: Double;
    FDEV_TOTALAPROXIMADOIMPOSTO: Double;
    FDEV_TOTALNUMEROVOLUMES: Double;
    FDEV_PERCENTUALFINANCEIROPRAZO: Double;
    FDEV_PERCENTUALDESCONTOPRAZO: Double;
    FDEV_PERCENTUALDESCTOAVULSO: Double;
    FDEV_PERCENTUALIBPT: Double;
    FDEV_NUMERACAOVOLUMES: String;
    FDEV_INFCOMPLEMENTAR: String;
    FDEV_MARCAVOLUMES: String;
    FDEV_ESPECIEVOLUMES: String;
    FUSERS_LOGIN: String;
    FDEV_PROCESSADO: String;
    FDEV_OBSERVACAO: String;
    FDEV_DATAALTERACAO: TDateTime;
    FDEV_TIPOFRETE: String;
    FDEV_CANCELADA: String;
    FDEV_PLACAVEICULO: String;
    FDEV_UFVEICULO: String;
    FDEV_LIVROFISCAL: String;
    FDEV_CHAVEACESSO: String;
    FDEV_DATACANCELAMENTO: TDateTime;
    FDEV_OBSERVACAOCANCELAMENTO: String;
    FDEV_TOTALBASEDESCONTOCOMISSAO: Double;
    FDEV_PERCENTUALCOMISSAO: Double;
    FDEV_TOTALBASECALCULOCOMISSAO: Double;
    FDEV_DENEGADA: String;
    FDEV_TOTALPRODUTOSLIQUIDO: Double;
    FDEV_TOTALIBPTMUNICIPAL: Double;
    FDEV_TOTALIBPTESTADUAL: Double;
    FDEV_TOTALIBPTNACIONAL: Double;
    FDEV_TOTALIBPTIMPORTADO: Double;
    FDEV_PERCENTUALIBPTMUNICIPAL: Double;
    FDEV_PERCENTUALIBPTESTADUAL: Double;
    FDEV_PERCENTUALIBPTNACIONAL: Double;
    FDEV_PERCENTUALIBPTIMPORTADO: Double;
    FDEV_CHAVEREFERENCIANFE: String;
    FDEV_ID_OLD: Integer;
    FCON_CODIGO: String;
  public 
    { Public declarations } 
     const Table      = 'DEV_00';
     const PrimaryKey = 'DEV_ID';
     const Sequence   = 'SEQ_DEV_ID';

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
    [Column('DEV_SERIE', ftString, 3)]
    [Dictionary('DEV_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_SERIE: String read FDEV_SERIE write FDEV_SERIE;
    const DEV_SERIE_Name = 'DEV_SERIE';

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
    [Column('DEV_NUMERODOCTO', ftString, 10)]
    [Dictionary('DEV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NUMERODOCTO: String read FDEV_NUMERODOCTO write FDEV_NUMERODOCTO;
    const DEV_NUMERODOCTO_Name = 'DEV_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALIPI', ftBCD)]
    [Dictionary('DEV_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIPI: Double read FDEV_TOTALIPI write FDEV_TOTALIPI;
    const DEV_TOTALIPI_Name = 'DEV_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALPIS', ftBCD)]
    [Dictionary('DEV_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPIS: Double read FDEV_TOTALPIS write FDEV_TOTALPIS;
    const DEV_TOTALPIS_Name = 'DEV_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALICMS', ftBCD)]
    [Dictionary('DEV_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMS: Double read FDEV_TOTALICMS write FDEV_TOTALICMS;
    const DEV_TOTALICMS_Name = 'DEV_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALICMSR', ftBCD)]
    [Dictionary('DEV_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSR: Double read FDEV_TOTALICMSR write FDEV_TOTALICMSR;
    const DEV_TOTALICMSR_Name = 'DEV_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALFRETE', ftBCD)]
    [Dictionary('DEV_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFRETE: Double read FDEV_TOTALFRETE write FDEV_TOTALFRETE;
    const DEV_TOTALFRETE_Name = 'DEV_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALCOFINS', ftBCD)]
    [Dictionary('DEV_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOFINS: Double read FDEV_TOTALCOFINS write FDEV_TOTALCOFINS;
    const DEV_TOTALCOFINS_Name = 'DEV_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALLIQUIDO: Double read FDEV_TOTALLIQUIDO write FDEV_TOTALLIQUIDO;
    const DEV_TOTALLIQUIDO_Name = 'DEV_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALSEGURO', ftBCD)]
    [Dictionary('DEV_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSEGURO: Double read FDEV_TOTALSEGURO write FDEV_TOTALSEGURO;
    const DEV_TOTALSEGURO_Name = 'DEV_TOTALSEGURO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALSERVICO', ftBCD)]
    [Dictionary('DEV_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSERVICO: Double read FDEV_TOTALSERVICO write FDEV_TOTALSERVICO;
    const DEV_TOTALSERVICO_Name = 'DEV_TOTALSERVICO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALPESOLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPESOLIQUIDO: Double read FDEV_TOTALPESOLIQUIDO write FDEV_TOTALPESOLIQUIDO;
    const DEV_TOTALPESOLIQUIDO_Name = 'DEV_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALQTDDEVOLVIDA', ftBCD)]
    [Dictionary('DEV_TOTALQTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALQTDDEVOLVIDA: Double read FDEV_TOTALQTDDEVOLVIDA write FDEV_TOTALQTDDEVOLVIDA;
    const DEV_TOTALQTDDEVOLVIDA_Name = 'DEV_TOTALQTDDEVOLVIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('DEV_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSUBSTRIBUTARIA: Double read FDEV_TOTALSUBSTRIBUTARIA write FDEV_TOTALSUBSTRIBUTARIA;
    const DEV_TOTALSUBSTRIBUTARIA_Name = 'DEV_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('DEV_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESPACESSORIA: Double read FDEV_TOTALDESPACESSORIA write FDEV_TOTALDESPACESSORIA;
    const DEV_TOTALDESPACESSORIA_Name = 'DEV_TOTALDESPACESSORIA';

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
    [Column('DEV_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOMVA: Double read FDEV_TOTALBASECALCULOMVA write FDEV_TOTALBASECALCULOMVA;
    const DEV_TOTALBASECALCULOMVA_Name = 'DEV_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('DEV_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFINANCEIROPRAZO: Double read FDEV_TOTALFINANCEIROPRAZO write FDEV_TOTALFINANCEIROPRAZO;
    const DEV_TOTALFINANCEIROPRAZO_Name = 'DEV_TOTALFINANCEIROPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('DEV_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMPLEMENTONFICMS: Double read FDEV_TOTALCOMPLEMENTONFICMS write FDEV_TOTALCOMPLEMENTONFICMS;
    const DEV_TOTALCOMPLEMENTONFICMS_Name = 'DEV_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOITEM: Double read FDEV_TOTALDESCTOITEM write FDEV_TOTALDESCTOITEM;
    const DEV_TOTALDESCTOITEM_Name = 'DEV_TOTALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALDESCTOPRAZO', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOPRAZO: Double read FDEV_TOTALDESCTOPRAZO write FDEV_TOTALDESCTOPRAZO;
    const DEV_TOTALDESCTOPRAZO_Name = 'DEV_TOTALDESCTOPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOAVULSO: Double read FDEV_TOTALDESCTOAVULSO write FDEV_TOTALDESCTOAVULSO;
    const DEV_TOTALDESCTOAVULSO_Name = 'DEV_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALCOMISSAO', ftBCD)]
    [Dictionary('DEV_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMISSAO: Double read FDEV_TOTALCOMISSAO write FDEV_TOTALCOMISSAO;
    const DEV_TOTALCOMISSAO_Name = 'DEV_TOTALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALADICIONAL', ftBCD)]
    [Dictionary('DEV_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALADICIONAL: Double read FDEV_TOTALADICIONAL write FDEV_TOTALADICIONAL;
    const DEV_TOTALADICIONAL_Name = 'DEV_TOTALADICIONAL';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('DEV_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBCALCULOPISCOFINS: Double read FDEV_TOTALBCALCULOPISCOFINS write FDEV_TOTALBCALCULOPISCOFINS;
    const DEV_TOTALBCALCULOPISCOFINS_Name = 'DEV_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('DEV_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALAPROXIMADOIMPOSTO: Double read FDEV_TOTALAPROXIMADOIMPOSTO write FDEV_TOTALAPROXIMADOIMPOSTO;
    const DEV_TOTALAPROXIMADOIMPOSTO_Name = 'DEV_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('DEV_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALNUMEROVOLUMES: Double read FDEV_TOTALNUMEROVOLUMES write FDEV_TOTALNUMEROVOLUMES;
    const DEV_TOTALNUMEROVOLUMES_Name = 'DEV_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('DEV_PERCENTUALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALFINANCEIROPRAZO: Double read FDEV_PERCENTUALFINANCEIROPRAZO write FDEV_PERCENTUALFINANCEIROPRAZO;
    const DEV_PERCENTUALFINANCEIROPRAZO_Name = 'DEV_PERCENTUALFINANCEIROPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALDESCONTOPRAZO', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESCONTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESCONTOPRAZO: Double read FDEV_PERCENTUALDESCONTOPRAZO write FDEV_PERCENTUALDESCONTOPRAZO;
    const DEV_PERCENTUALDESCONTOPRAZO_Name = 'DEV_PERCENTUALDESCONTOPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALDESCTOAVULSO', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESCTOAVULSO: Double read FDEV_PERCENTUALDESCTOAVULSO write FDEV_PERCENTUALDESCTOAVULSO;
    const DEV_PERCENTUALDESCTOAVULSO_Name = 'DEV_PERCENTUALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPT', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPT: Double read FDEV_PERCENTUALIBPT write FDEV_PERCENTUALIBPT;
    const DEV_PERCENTUALIBPT_Name = 'DEV_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('DEV_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('DEV_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NUMERACAOVOLUMES: String read FDEV_NUMERACAOVOLUMES write FDEV_NUMERACAOVOLUMES;
    const DEV_NUMERACAOVOLUMES_Name = 'DEV_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('DEV_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('DEV_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_INFCOMPLEMENTAR: String read FDEV_INFCOMPLEMENTAR write FDEV_INFCOMPLEMENTAR;
    const DEV_INFCOMPLEMENTAR_Name = 'DEV_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('DEV_MARCAVOLUMES', ftString, 30)]
    [Dictionary('DEV_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_MARCAVOLUMES: String read FDEV_MARCAVOLUMES write FDEV_MARCAVOLUMES;
    const DEV_MARCAVOLUMES_Name = 'DEV_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('DEV_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('DEV_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_ESPECIEVOLUMES: String read FDEV_ESPECIEVOLUMES write FDEV_ESPECIEVOLUMES;
    const DEV_ESPECIEVOLUMES_Name = 'DEV_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('DEV_PROCESSADO', ftString, 1)]
    [Dictionary('DEV_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_PROCESSADO: String read FDEV_PROCESSADO write FDEV_PROCESSADO;
    const DEV_PROCESSADO_Name = 'DEV_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('DEV_OBSERVACAO', ftString, 5000)]
    [Dictionary('DEV_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_OBSERVACAO: String read FDEV_OBSERVACAO write FDEV_OBSERVACAO;
    const DEV_OBSERVACAO_Name = 'DEV_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_DATAALTERACAO', ftDateTime)]
    [Dictionary('DEV_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATAALTERACAO: TDateTime read FDEV_DATAALTERACAO write FDEV_DATAALTERACAO;
    const DEV_DATAALTERACAO_Name = 'DEV_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DEV_TIPOFRETE', ftString, 1)]
    [Dictionary('DEV_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_TIPOFRETE: String read FDEV_TIPOFRETE write FDEV_TIPOFRETE;
    const DEV_TIPOFRETE_Name = 'DEV_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('DEV_CANCELADA', ftString, 1)]
    [Dictionary('DEV_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CANCELADA: String read FDEV_CANCELADA write FDEV_CANCELADA;
    const DEV_CANCELADA_Name = 'DEV_CANCELADA';

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
    [Column('DEV_LIVROFISCAL', ftString, 1)]
    [Dictionary('DEV_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_LIVROFISCAL: String read FDEV_LIVROFISCAL write FDEV_LIVROFISCAL;
    const DEV_LIVROFISCAL_Name = 'DEV_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('DEV_CHAVEACESSO', ftString, 44)]
    [Dictionary('DEV_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CHAVEACESSO: String read FDEV_CHAVEACESSO write FDEV_CHAVEACESSO;
    const DEV_CHAVEACESSO_Name = 'DEV_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('DEV_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('DEV_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_DATACANCELAMENTO: TDateTime read FDEV_DATACANCELAMENTO write FDEV_DATACANCELAMENTO;
    const DEV_DATACANCELAMENTO_Name = 'DEV_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('DEV_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('DEV_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_OBSERVACAOCANCELAMENTO: String read FDEV_OBSERVACAOCANCELAMENTO write FDEV_OBSERVACAOCANCELAMENTO;
    const DEV_OBSERVACAOCANCELAMENTO_Name = 'DEV_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASEDESCONTOCOMISSAO', ftBCD)]
    [Dictionary('DEV_TOTALBASEDESCONTOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEDESCONTOCOMISSAO: Double read FDEV_TOTALBASEDESCONTOCOMISSAO write FDEV_TOTALBASEDESCONTOCOMISSAO;
    const DEV_TOTALBASEDESCONTOCOMISSAO_Name = 'DEV_TOTALBASEDESCONTOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('DEV_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOMISSAO: Double read FDEV_PERCENTUALCOMISSAO write FDEV_PERCENTUALCOMISSAO;
    const DEV_PERCENTUALCOMISSAO_Name = 'DEV_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASECALCULOCOMISSAO', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOCOMISSAO: Double read FDEV_TOTALBASECALCULOCOMISSAO write FDEV_TOTALBASECALCULOCOMISSAO;
    const DEV_TOTALBASECALCULOCOMISSAO_Name = 'DEV_TOTALBASECALCULOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('DEV_DENEGADA', ftString, 1)]
    [Dictionary('DEV_DENEGADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_DENEGADA: String read FDEV_DENEGADA write FDEV_DENEGADA;
    const DEV_DENEGADA_Name = 'DEV_DENEGADA';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPRODUTOSLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRODUTOSLIQUIDO: Double read FDEV_TOTALPRODUTOSLIQUIDO write FDEV_TOTALPRODUTOSLIQUIDO;
    const DEV_TOTALPRODUTOSLIQUIDO_Name = 'DEV_TOTALPRODUTOSLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('DEV_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTMUNICIPAL: Double read FDEV_TOTALIBPTMUNICIPAL write FDEV_TOTALIBPTMUNICIPAL;
    const DEV_TOTALIBPTMUNICIPAL_Name = 'DEV_TOTALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('DEV_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTESTADUAL: Double read FDEV_TOTALIBPTESTADUAL write FDEV_TOTALIBPTESTADUAL;
    const DEV_TOTALIBPTESTADUAL_Name = 'DEV_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('DEV_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTNACIONAL: Double read FDEV_TOTALIBPTNACIONAL write FDEV_TOTALIBPTNACIONAL;
    const DEV_TOTALIBPTNACIONAL_Name = 'DEV_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('DEV_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTIMPORTADO: Double read FDEV_TOTALIBPTIMPORTADO write FDEV_TOTALIBPTIMPORTADO;
    const DEV_TOTALIBPTIMPORTADO_Name = 'DEV_TOTALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTMUNICIPAL: Double read FDEV_PERCENTUALIBPTMUNICIPAL write FDEV_PERCENTUALIBPTMUNICIPAL;
    const DEV_PERCENTUALIBPTMUNICIPAL_Name = 'DEV_PERCENTUALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTESTADUAL: Double read FDEV_PERCENTUALIBPTESTADUAL write FDEV_PERCENTUALIBPTESTADUAL;
    const DEV_PERCENTUALIBPTESTADUAL_Name = 'DEV_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTNACIONAL: Double read FDEV_PERCENTUALIBPTNACIONAL write FDEV_PERCENTUALIBPTNACIONAL;
    const DEV_PERCENTUALIBPTNACIONAL_Name = 'DEV_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTIMPORTADO', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTIMPORTADO: Double read FDEV_PERCENTUALIBPTIMPORTADO write FDEV_PERCENTUALIBPTIMPORTADO;
    const DEV_PERCENTUALIBPTIMPORTADO_Name = 'DEV_PERCENTUALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('DEV_CHAVEREFERENCIANFE', ftString, 44)]
    [Dictionary('DEV_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CHAVEREFERENCIANFE: String read FDEV_CHAVEREFERENCIANFE write FDEV_CHAVEREFERENCIANFE;
    const DEV_CHAVEREFERENCIANFE_Name = 'DEV_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate])]
    [Column('DEV_ID_OLD', ftInteger)]
    [Dictionary('DEV_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID_OLD: Integer read FDEV_ID_OLD write FDEV_ID_OLD;
    const DEV_ID_OLD_Name = 'DEV_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CON_CODIGO', ftString, 6)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CON_CODIGO: String read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDEV_00)

end.
