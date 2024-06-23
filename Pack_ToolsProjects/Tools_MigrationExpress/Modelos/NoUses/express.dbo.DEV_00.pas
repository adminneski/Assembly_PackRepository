unit express.dbo.dev_00;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  // ORMbr
  ormbr.types.blob,
  ormbr.types.lazy,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes,
  dbebr.factory.interfaces,
  Core.Register, 
  Model.Base;  

type
  [Entity]
  [Table('DEV_00', 'SELECT * FROM DEV_00')]
  [PrimaryKey('DEV_ID', NotInc, NoSort, False, 'Chave primária')]
  TDEV_00 = class(TModelBase)
  private
    { Private declarations } 
    FDEV_ID: Integer;
    FCOM_CODIGO: String;
    FPES_CODIGO: Nullable<Integer>;
    FMNF_CODIGO: Nullable<String>;
    FTDC_CODIGO: Nullable<String>;
    FNTO_CODIGO: Nullable<Integer>;
    FCTB_CODIGO: Nullable<Integer>;
    FCFOP_CODIGO: Nullable<String>;
    FVND_CODIGO: Nullable<Integer>;
    FTRP_CODIGO: Nullable<Integer>;
    FDEV_SERIE: Nullable<String>;
    FDEV_NOTAFISCAL: Nullable<String>;
    FDEV_DATALANCAMENTO: TDateTime;
    FDEV_NUMERODOCTO: Nullable<String>;
    FDEV_TOTALIPI: Double;
    FDEV_TOTALPIS: Double;
    FDEV_TOTALICMS: Double;
    FDEV_TOTALICMSR: Double;
    FDEV_TOTALFRETE: Double;
    FDEV_TOTALCOFINS: Double;
    FDEV_TOTALLIQUIDO: Double;
    FDEV_TOTALSEGURO: Double;
    FDEV_TOTALSERVICO: Nullable<Double>;
    FDEV_TOTALPRODUTOS: Double;
    FDEV_TOTALPESOBRUTO: Nullable<Double>;
    FDEV_TOTALPESOLIQUIDO: Double;
    FDEV_TOTALQTDDEVOLVIDA: Double;
    FDEV_TOTALSUBSTRIBUTARIA: Double;
    FDEV_TOTALDESPACESSORIA: Double;
    FDEV_TOTALBASEISENTOICMS: Nullable<Double>;
    FDEV_TOTALBASECALCULOICMS: Double;
    FDEV_TOTALBASECALCULOMVA: Nullable<Double>;
    FDEV_TOTALFINANCEIROPRAZO: Double;
    FDEV_TOTALCOMPLEMENTONFICMS: Double;
    FDEV_TOTALDESCTOITEM: Double;
    FDEV_TOTALDESCTOPRAZO: Double;
    FDEV_TOTALDESCTOAVULSO: Double;
    FDEV_TOTALCOMISSAO: Nullable<Double>;
    FDEV_TOTALADICIONAL: Nullable<Double>;
    FDEV_TOTALBCALCULOPISCOFINS: Nullable<Double>;
    FDEV_TOTALAPROXIMADOIMPOSTO: Nullable<Double>;
    FDEV_TOTALNUMEROVOLUMES: Double;
    FDEV_PERCENTUALFINANCEIROPRAZO: Double;
    FDEV_PERCENTUALDESCONTOPRAZO: Double;
    FDEV_PERCENTUALDESCTOAVULSO: Double;
    FDEV_PERCENTUALIBPT: Nullable<Double>;
    FDEV_NUMERACAOVOLUMES: Nullable<String>;
    FDEV_INFCOMPLEMENTAR: Nullable<String>;
    FDEV_MARCAVOLUMES: Nullable<String>;
    FDEV_ESPECIEVOLUMES: Nullable<String>;
    FUSERS_LOGIN: Nullable<String>;
    FDEV_PROCESSADO: Nullable<String>;
    FDEV_OBSERVACAO: Nullable<String>;
    FDEV_DATAALTERACAO: TDateTime;
    FDEV_TIPOFRETE: Nullable<String>;
    FDEV_CANCELADA: Nullable<String>;
    FDEV_PLACAVEICULO: Nullable<String>;
    FDEV_UFVEICULO: Nullable<String>;
    FDEV_LIVROFISCAL: Nullable<String>;
    FDEV_CHAVEACESSO: Nullable<String>;
    FDEV_DATACANCELAMENTO: Nullable<TDateTime>;
    FDEV_OBSERVACAOCANCELAMENTO: Nullable<String>;
    FDEV_TOTALBASEDESCONTOCOMISSAO: Nullable<Double>;
    FDEV_PERCENTUALCOMISSAO: Nullable<Double>;
    FDEV_TOTALBASECALCULOCOMISSAO: Nullable<Double>;
    FDEV_DENEGADA: Nullable<String>;
    FDEV_TOTALPRODUTOSLIQUIDO: Nullable<Double>;
    FDEV_TOTALIBPTMUNICIPAL: Nullable<Double>;
    FDEV_TOTALIBPTESTADUAL: Nullable<Double>;
    FDEV_TOTALIBPTNACIONAL: Nullable<Double>;
    FDEV_TOTALIBPTIMPORTADO: Nullable<Double>;
    FDEV_PERCENTUALIBPTMUNICIPAL: Nullable<Double>;
    FDEV_PERCENTUALIBPTESTADUAL: Nullable<Double>;
    FDEV_PERCENTUALIBPTNACIONAL: Nullable<Double>;
    FDEV_PERCENTUALIBPTIMPORTADO: Nullable<Double>;
    FDEV_CHAVEREFERENCIANFE: Nullable<String>;
    FDEV_ID_OLD: Nullable<Integer>;
    FCON_CODIGO: Nullable<String>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('DEV_ID', ftInteger)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGO: Nullable<Integer> read FPES_CODIGO write FPES_CODIGO;

    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: Nullable<String> read FMNF_CODIGO write FMNF_CODIGO;

    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: Nullable<String> read FTDC_CODIGO write FTDC_CODIGO;

    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property NTO_CODIGO: Nullable<Integer> read FNTO_CODIGO write FNTO_CODIGO;

    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTB_CODIGO: Nullable<Integer> read FCTB_CODIGO write FCTB_CODIGO;

    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: Nullable<String> read FCFOP_CODIGO write FCFOP_CODIGO;

    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property VND_CODIGO: Nullable<Integer> read FVND_CODIGO write FVND_CODIGO;

    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property TRP_CODIGO: Nullable<Integer> read FTRP_CODIGO write FTRP_CODIGO;

    [Column('DEV_SERIE', ftString, 3)]
    [Dictionary('DEV_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_SERIE: Nullable<String> read FDEV_SERIE write FDEV_SERIE;

    [Column('DEV_NOTAFISCAL', ftString, 9)]
    [Dictionary('DEV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NOTAFISCAL: Nullable<String> read FDEV_NOTAFISCAL write FDEV_NOTAFISCAL;

    [Restrictions([NotNull])]
    [Column('DEV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DEV_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATALANCAMENTO: TDateTime read FDEV_DATALANCAMENTO write FDEV_DATALANCAMENTO;

    [Column('DEV_NUMERODOCTO', ftString, 10)]
    [Dictionary('DEV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NUMERODOCTO: Nullable<String> read FDEV_NUMERODOCTO write FDEV_NUMERODOCTO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALIPI', ftBCD)]
    [Dictionary('DEV_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIPI: Double read FDEV_TOTALIPI write FDEV_TOTALIPI;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALPIS', ftBCD, 59, 2)]
    [Dictionary('DEV_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPIS: Double read FDEV_TOTALPIS write FDEV_TOTALPIS;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALICMS', ftBCD, 59, 2)]
    [Dictionary('DEV_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMS: Double read FDEV_TOTALICMS write FDEV_TOTALICMS;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALICMSR', ftBCD, 59, 2)]
    [Dictionary('DEV_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSR: Double read FDEV_TOTALICMSR write FDEV_TOTALICMSR;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALFRETE', ftBCD)]
    [Dictionary('DEV_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFRETE: Double read FDEV_TOTALFRETE write FDEV_TOTALFRETE;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALCOFINS', ftBCD)]
    [Dictionary('DEV_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOFINS: Double read FDEV_TOTALCOFINS write FDEV_TOTALCOFINS;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALLIQUIDO: Double read FDEV_TOTALLIQUIDO write FDEV_TOTALLIQUIDO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALSEGURO', ftBCD)]
    [Dictionary('DEV_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSEGURO: Double read FDEV_TOTALSEGURO write FDEV_TOTALSEGURO;

    [Column('DEV_TOTALSERVICO', ftBCD)]
    [Dictionary('DEV_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSERVICO: Nullable<Double> read FDEV_TOTALSERVICO write FDEV_TOTALSERVICO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALPRODUTOS', ftBCD)]
    [Dictionary('DEV_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRODUTOS: Double read FDEV_TOTALPRODUTOS write FDEV_TOTALPRODUTOS;

    [Column('DEV_TOTALPESOBRUTO', ftBCD)]
    [Dictionary('DEV_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPESOBRUTO: Nullable<Double> read FDEV_TOTALPESOBRUTO write FDEV_TOTALPESOBRUTO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALPESOLIQUIDO', ftBCD, 59, 3)]
    [Dictionary('DEV_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPESOLIQUIDO: Double read FDEV_TOTALPESOLIQUIDO write FDEV_TOTALPESOLIQUIDO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALQTDDEVOLVIDA', ftBCD)]
    [Dictionary('DEV_TOTALQTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALQTDDEVOLVIDA: Double read FDEV_TOTALQTDDEVOLVIDA write FDEV_TOTALQTDDEVOLVIDA;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('DEV_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSUBSTRIBUTARIA: Double read FDEV_TOTALSUBSTRIBUTARIA write FDEV_TOTALSUBSTRIBUTARIA;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('DEV_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESPACESSORIA: Double read FDEV_TOTALDESPACESSORIA write FDEV_TOTALDESPACESSORIA;

    [Column('DEV_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('DEV_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEISENTOICMS: Nullable<Double> read FDEV_TOTALBASEISENTOICMS write FDEV_TOTALBASEISENTOICMS;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOICMS: Double read FDEV_TOTALBASECALCULOICMS write FDEV_TOTALBASECALCULOICMS;

    [Column('DEV_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOMVA: Nullable<Double> read FDEV_TOTALBASECALCULOMVA write FDEV_TOTALBASECALCULOMVA;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('DEV_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFINANCEIROPRAZO: Double read FDEV_TOTALFINANCEIROPRAZO write FDEV_TOTALFINANCEIROPRAZO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('DEV_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMPLEMENTONFICMS: Double read FDEV_TOTALCOMPLEMENTONFICMS write FDEV_TOTALCOMPLEMENTONFICMS;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOITEM: Double read FDEV_TOTALDESCTOITEM write FDEV_TOTALDESCTOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALDESCTOPRAZO', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOPRAZO: Double read FDEV_TOTALDESCTOPRAZO write FDEV_TOTALDESCTOPRAZO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOAVULSO: Double read FDEV_TOTALDESCTOAVULSO write FDEV_TOTALDESCTOAVULSO;

    [Column('DEV_TOTALCOMISSAO', ftBCD)]
    [Dictionary('DEV_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMISSAO: Nullable<Double> read FDEV_TOTALCOMISSAO write FDEV_TOTALCOMISSAO;

    [Column('DEV_TOTALADICIONAL', ftBCD)]
    [Dictionary('DEV_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALADICIONAL: Nullable<Double> read FDEV_TOTALADICIONAL write FDEV_TOTALADICIONAL;

    [Column('DEV_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('DEV_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBCALCULOPISCOFINS: Nullable<Double> read FDEV_TOTALBCALCULOPISCOFINS write FDEV_TOTALBCALCULOPISCOFINS;

    [Column('DEV_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('DEV_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALAPROXIMADOIMPOSTO: Nullable<Double> read FDEV_TOTALAPROXIMADOIMPOSTO write FDEV_TOTALAPROXIMADOIMPOSTO;

    [Restrictions([NotNull])]
    [Column('DEV_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('DEV_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALNUMEROVOLUMES: Double read FDEV_TOTALNUMEROVOLUMES write FDEV_TOTALNUMEROVOLUMES;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('DEV_PERCENTUALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALFINANCEIROPRAZO: Double read FDEV_PERCENTUALFINANCEIROPRAZO write FDEV_PERCENTUALFINANCEIROPRAZO;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALDESCONTOPRAZO', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESCONTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESCONTOPRAZO: Double read FDEV_PERCENTUALDESCONTOPRAZO write FDEV_PERCENTUALDESCONTOPRAZO;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALDESCTOAVULSO', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESCTOAVULSO: Double read FDEV_PERCENTUALDESCTOAVULSO write FDEV_PERCENTUALDESCTOAVULSO;

    [Column('DEV_PERCENTUALIBPT', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPT: Nullable<Double> read FDEV_PERCENTUALIBPT write FDEV_PERCENTUALIBPT;

    [Column('DEV_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('DEV_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NUMERACAOVOLUMES: Nullable<String> read FDEV_NUMERACAOVOLUMES write FDEV_NUMERACAOVOLUMES;

    [Column('DEV_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('DEV_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_INFCOMPLEMENTAR: Nullable<String> read FDEV_INFCOMPLEMENTAR write FDEV_INFCOMPLEMENTAR;

    [Column('DEV_MARCAVOLUMES', ftString, 30)]
    [Dictionary('DEV_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_MARCAVOLUMES: Nullable<String> read FDEV_MARCAVOLUMES write FDEV_MARCAVOLUMES;

    [Column('DEV_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('DEV_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_ESPECIEVOLUMES: Nullable<String> read FDEV_ESPECIEVOLUMES write FDEV_ESPECIEVOLUMES;

    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: Nullable<String> read FUSERS_LOGIN write FUSERS_LOGIN;

    [Column('DEV_PROCESSADO', ftString, 1)]
    [Dictionary('DEV_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_PROCESSADO: Nullable<String> read FDEV_PROCESSADO write FDEV_PROCESSADO;

    [Column('DEV_OBSERVACAO', ftString, 5000)]
    [Dictionary('DEV_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_OBSERVACAO: Nullable<String> read FDEV_OBSERVACAO write FDEV_OBSERVACAO;

    [Restrictions([NotNull])]
    [Column('DEV_DATAALTERACAO', ftDateTime)]
    [Dictionary('DEV_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATAALTERACAO: TDateTime read FDEV_DATAALTERACAO write FDEV_DATAALTERACAO;

    [Column('DEV_TIPOFRETE', ftString, 1)]
    [Dictionary('DEV_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_TIPOFRETE: Nullable<String> read FDEV_TIPOFRETE write FDEV_TIPOFRETE;

    [Column('DEV_CANCELADA', ftString, 1)]
    [Dictionary('DEV_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CANCELADA: Nullable<String> read FDEV_CANCELADA write FDEV_CANCELADA;

    [Column('DEV_PLACAVEICULO', ftString, 7)]
    [Dictionary('DEV_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_PLACAVEICULO: Nullable<String> read FDEV_PLACAVEICULO write FDEV_PLACAVEICULO;

    [Column('DEV_UFVEICULO', ftString, 2)]
    [Dictionary('DEV_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_UFVEICULO: Nullable<String> read FDEV_UFVEICULO write FDEV_UFVEICULO;

    [Column('DEV_LIVROFISCAL', ftString, 1)]
    [Dictionary('DEV_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_LIVROFISCAL: Nullable<String> read FDEV_LIVROFISCAL write FDEV_LIVROFISCAL;

    [Column('DEV_CHAVEACESSO', ftString, 44)]
    [Dictionary('DEV_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CHAVEACESSO: Nullable<String> read FDEV_CHAVEACESSO write FDEV_CHAVEACESSO;

    [Column('DEV_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('DEV_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_DATACANCELAMENTO: Nullable<TDateTime> read FDEV_DATACANCELAMENTO write FDEV_DATACANCELAMENTO;

    [Column('DEV_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('DEV_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_OBSERVACAOCANCELAMENTO: Nullable<String> read FDEV_OBSERVACAOCANCELAMENTO write FDEV_OBSERVACAOCANCELAMENTO;

    [Column('DEV_TOTALBASEDESCONTOCOMISSAO', ftBCD)]
    [Dictionary('DEV_TOTALBASEDESCONTOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEDESCONTOCOMISSAO: Nullable<Double> read FDEV_TOTALBASEDESCONTOCOMISSAO write FDEV_TOTALBASEDESCONTOCOMISSAO;

    [Column('DEV_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('DEV_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOMISSAO: Nullable<Double> read FDEV_PERCENTUALCOMISSAO write FDEV_PERCENTUALCOMISSAO;

    [Column('DEV_TOTALBASECALCULOCOMISSAO', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOCOMISSAO: Nullable<Double> read FDEV_TOTALBASECALCULOCOMISSAO write FDEV_TOTALBASECALCULOCOMISSAO;

    [Column('DEV_DENEGADA', ftString, 1)]
    [Dictionary('DEV_DENEGADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_DENEGADA: Nullable<String> read FDEV_DENEGADA write FDEV_DENEGADA;

    [Column('DEV_TOTALPRODUTOSLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRODUTOSLIQUIDO: Nullable<Double> read FDEV_TOTALPRODUTOSLIQUIDO write FDEV_TOTALPRODUTOSLIQUIDO;

    [Column('DEV_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('DEV_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTMUNICIPAL: Nullable<Double> read FDEV_TOTALIBPTMUNICIPAL write FDEV_TOTALIBPTMUNICIPAL;

    [Column('DEV_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('DEV_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTESTADUAL: Nullable<Double> read FDEV_TOTALIBPTESTADUAL write FDEV_TOTALIBPTESTADUAL;

    [Column('DEV_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('DEV_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTNACIONAL: Nullable<Double> read FDEV_TOTALIBPTNACIONAL write FDEV_TOTALIBPTNACIONAL;

    [Column('DEV_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('DEV_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTIMPORTADO: Nullable<Double> read FDEV_TOTALIBPTIMPORTADO write FDEV_TOTALIBPTIMPORTADO;

    [Column('DEV_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTMUNICIPAL: Nullable<Double> read FDEV_PERCENTUALIBPTMUNICIPAL write FDEV_PERCENTUALIBPTMUNICIPAL;

    [Column('DEV_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTESTADUAL: Nullable<Double> read FDEV_PERCENTUALIBPTESTADUAL write FDEV_PERCENTUALIBPTESTADUAL;

    [Column('DEV_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTNACIONAL: Nullable<Double> read FDEV_PERCENTUALIBPTNACIONAL write FDEV_PERCENTUALIBPTNACIONAL;

    [Column('DEV_PERCENTUALIBPTIMPORTADO', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTIMPORTADO: Nullable<Double> read FDEV_PERCENTUALIBPTIMPORTADO write FDEV_PERCENTUALIBPTIMPORTADO;

    [Column('DEV_CHAVEREFERENCIANFE', ftString, 44)]
    [Dictionary('DEV_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CHAVEREFERENCIANFE: Nullable<String> read FDEV_CHAVEREFERENCIANFE write FDEV_CHAVEREFERENCIANFE;

    [Column('DEV_ID_OLD', ftInteger)]
    [Dictionary('DEV_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_ID_OLD: Nullable<Integer> read FDEV_ID_OLD write FDEV_ID_OLD;

    [Column('CON_CODIGO', ftString, 6)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CON_CODIGO: Nullable<String> read FCON_CODIGO write FCON_CODIGO;
  end;

implementation

uses ormbr.container.objectset; 

{ TDEV_00 } 

procedure TDEV_00.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TDEV_00>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TDEV_00>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TDEV_00(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TDEV_00);
  TCoreRegisterClass.RegisterEntity(TDEV_00);

end.
