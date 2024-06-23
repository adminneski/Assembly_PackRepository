unit express.dbo.pda_00;

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
  [Table('PDA_00', 'SELECT * FROM PDA_00')]
  [PrimaryKey('PDA_ID', NotInc, NoSort, False, 'Chave primária')]
  TPDA_00 = class(TModelBase)
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FCOM_CODIGO: String;
    FCGA_ID: Nullable<Integer>;
    FFPG_CODIGO: Nullable<Integer>;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPRZ_CODIGO: Nullable<Integer>;
    FTDC_CODIGO: Nullable<String>;
    FNTO_CODIGO: Nullable<Integer>;
    FCCU_CODIGO: Nullable<Integer>;
    FCTB_CODIGO: Nullable<Integer>;
    FCFOP_CODIGO: Nullable<String>;
    FPDA_SERIE: Nullable<String>;
    FMNF_CODIGO: Nullable<String>;
    FPDA_NOTAFISCAL: Nullable<String>;
    FLIB_NUMEROLIBERACAO: Nullable<String>;
    FPDA_NUMERODOCTO: String;
    FPDA_DATAENTREGA: Nullable<TDateTime>;
    FPDA_DATALANCAMENTO: TDateTime;
    FPDA_DATACANCELAMENTO: Nullable<TDateTime>;
    FPDA_COMISSAONEGOCIADA: String;
    FPDA_NUMEROORDEMCOMPRA: Nullable<String>;
    FPDA_NUMERODOCTOREPRESENTANTE: Nullable<String>;
    FPDA_CODIGOLIBERACAOVENDA: Nullable<String>;
    FPDA_TOTALQTDPEDIDA: Double;
    FPDA_TOTALPESOLIQUIDO: Double;
    FPDA_TOTALPRODUTOS: Double;
    FPDA_TOTALPRODUTOSLIQUIDO: Nullable<Double>;
    FPDA_TOTALLIQUIDO: Double;
    FPDA_TOTALPESOBRUTO: Nullable<Double>;
    FPDA_TIPOFRETE: String;
    FPDA_TOTALIPI: Double;
    FPDA_TOTALPIS: Double;
    FPDA_TOTALICMS: Double;
    FPDA_TOTALFRETE: Double;
    FPDA_TOTALICMSR: Double;
    FPDA_TOTALCOFINS: Double;
    FPDA_TOTALSEGURO: Double;
    FPDA_TOTALADICIONAL: Nullable<Double>;
    FPDA_TOTALSUBSTRIBUTARIA: Double;
    FPDA_TOTALDESPACESSORIA: Double;
    FPDA_TOTALBASEISENTOICMS: Nullable<Double>;
    FPDA_TOTALBASECALCULOMVA: Nullable<Double>;
    FPDA_TOTALBASECALCULOICMS: Double;
    FPDA_TOTALBCALCULOPISCOFINS: Nullable<Double>;
    FPDA_TOTALFINANCEIROPRAZO: Double;
    FPDA_TOTALCOMPLEMENTONFICMS: Double;
    FPDA_TOTALDESCTOITEM: Double;
    FPDA_TOTALDESCTOPRAZO: Double;
    FPDA_TOTALDESCTOAVULSO: Double;
    FPDA_TOTALCOMISSAO: Nullable<Double>;
    FPDA_PERCENTUALCOMISSAO: Double;
    FPDA_PERCENTUALDESCTOAVULSO: Double;
    FPDA_PERCENTUALDESCONTOPRAZO: Double;
    FPDA_PERCENTUALFINANCEIROPRAZO: Double;
    FPDA_MARCAVOLUMES: Nullable<String>;
    FPDA_ESPECIEVOLUMES: Nullable<String>;
    FPDA_NUMERACAOVOLUMES: Nullable<String>;
    FPDA_TOTALNUMEROVOLUMES: Double;
    FPES_CODIGOENTREGA: Nullable<Integer>;
    FPES_CODIGORETIRADA: Nullable<Integer>;
    FPDA_DATADIGITACAOPALM: Nullable<TDateTime>;
    FPDA_HORADIGITACAOPALM: Nullable<String>;
    FPDA_TOTALAPROXIMADOIMPOSTO: Nullable<Double>;
    FPDA_TOTALIBPTMUNICIPAL: Nullable<Double>;
    FPDA_TOTALIBPTESTADUAL: Nullable<Double>;
    FPDA_TOTALIBPTNACIONAL: Nullable<Double>;
    FPDA_TOTALIBPTIMPORTADO: Nullable<Double>;
    FPDA_PERCENTUALIBPT: Nullable<Double>;
    FPDA_PERCENTUALIBPTMUNICIPAL: Nullable<Double>;
    FPDA_PERCENTUALIBPTESTADUAL: Nullable<Double>;
    FPDA_PERCENTUALIBPTNACIONAL: Nullable<Double>;
    FPDA_PERCENTUALIBPTIMPORTADO: Nullable<Double>;
    FPDA_TOTALBASECALCULOFCP: Nullable<Double>;
    FPDA_TOTALFCP: Nullable<Double>;
    FPDA_TOTALBASECALCULOFCPST: Nullable<Double>;
    FPDA_TOTALFCPST: Nullable<Double>;
    FPDA_TOTALBASECALCULOFCPRET: Nullable<Double>;
    FPDA_TOTALFCPRET: Nullable<Double>;
    FPDA_OBSERVACAO: Nullable<String>;
    FPDA_OBSERVACAOCANCELAMENTO: Nullable<String>;
    FPDA_CANCELADA: String;
    FPDA_BLOQUEADO: Nullable<String>;
    FPDA_DESATIVADO: String;
    FPDA_FATURADO: String;
    FPDA_INTEGRACAO: Nullable<String>;
    FUSERS_LOGIN: Nullable<String>;
    FPDA_DATAALTERACAO: TDateTime;
    FPDA_TIPODOCUMENTO: Nullable<String>;
    FLIB_ID: Nullable<Integer>;
    FCON_CODIGO: Nullable<Integer>;
    FPDA_ID_OLD: Nullable<Integer>;
    FPDA_INTEGRACAO_OLD: Nullable<String>;
    FCGA_ID_OLD: Nullable<Integer>;
    FLIB_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_ID: Nullable<Integer> read FCGA_ID write FCGA_ID;

    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property FPG_CODIGO: Nullable<Integer> read FFPG_CODIGO write FFPG_CODIGO;

    [Restrictions([NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;

    [Restrictions([NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;

    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRZ_CODIGO: Nullable<Integer> read FPRZ_CODIGO write FPRZ_CODIGO;

    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: Nullable<String> read FTDC_CODIGO write FTDC_CODIGO;

    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property NTO_CODIGO: Nullable<Integer> read FNTO_CODIGO write FNTO_CODIGO;

    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCU_CODIGO: Nullable<Integer> read FCCU_CODIGO write FCCU_CODIGO;

    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTB_CODIGO: Nullable<Integer> read FCTB_CODIGO write FCTB_CODIGO;

    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: Nullable<String> read FCFOP_CODIGO write FCFOP_CODIGO;

    [Column('PDA_SERIE', ftString, 3)]
    [Dictionary('PDA_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_SERIE: Nullable<String> read FPDA_SERIE write FPDA_SERIE;

    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: Nullable<String> read FMNF_CODIGO write FMNF_CODIGO;

    [Column('PDA_NOTAFISCAL', ftString, 9)]
    [Dictionary('PDA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NOTAFISCAL: Nullable<String> read FPDA_NOTAFISCAL write FPDA_NOTAFISCAL;

    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: Nullable<String> read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;

    [Restrictions([NotNull])]
    [Column('PDA_NUMERODOCTO', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTO: String read FPDA_NUMERODOCTO write FPDA_NUMERODOCTO;

    [Column('PDA_DATAENTREGA', ftDateTime)]
    [Dictionary('PDA_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATAENTREGA: Nullable<TDateTime> read FPDA_DATAENTREGA write FPDA_DATAENTREGA;

    [Restrictions([NotNull])]
    [Column('PDA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATALANCAMENTO: TDateTime read FPDA_DATALANCAMENTO write FPDA_DATALANCAMENTO;

    [Column('PDA_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('PDA_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATACANCELAMENTO: Nullable<TDateTime> read FPDA_DATACANCELAMENTO write FPDA_DATACANCELAMENTO;

    [Restrictions([NotNull])]
    [Column('PDA_COMISSAONEGOCIADA', ftString, 1)]
    [Dictionary('PDA_COMISSAONEGOCIADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_COMISSAONEGOCIADA: String read FPDA_COMISSAONEGOCIADA write FPDA_COMISSAONEGOCIADA;

    [Column('PDA_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('PDA_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMEROORDEMCOMPRA: Nullable<String> read FPDA_NUMEROORDEMCOMPRA write FPDA_NUMEROORDEMCOMPRA;

    [Column('PDA_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTOREPRESENTANTE: Nullable<String> read FPDA_NUMERODOCTOREPRESENTANTE write FPDA_NUMERODOCTOREPRESENTANTE;

    [Column('PDA_CODIGOLIBERACAOVENDA', ftString, 6)]
    [Dictionary('PDA_CODIGOLIBERACAOVENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CODIGOLIBERACAOVENDA: Nullable<String> read FPDA_CODIGOLIBERACAOVENDA write FPDA_CODIGOLIBERACAOVENDA;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALQTDPEDIDA', ftBCD)]
    [Dictionary('PDA_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALQTDPEDIDA: Double read FPDA_TOTALQTDPEDIDA write FPDA_TOTALQTDPEDIDA;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALPESOLIQUIDO', ftBCD)]
    [Dictionary('PDA_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPESOLIQUIDO: Double read FPDA_TOTALPESOLIQUIDO write FPDA_TOTALPESOLIQUIDO;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALPRODUTOS', ftBCD)]
    [Dictionary('PDA_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRODUTOS: Double read FPDA_TOTALPRODUTOS write FPDA_TOTALPRODUTOS;

    [Column('PDA_TOTALPRODUTOSLIQUIDO', ftBCD)]
    [Dictionary('PDA_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRODUTOSLIQUIDO: Nullable<Double> read FPDA_TOTALPRODUTOSLIQUIDO write FPDA_TOTALPRODUTOSLIQUIDO;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALLIQUIDO', ftBCD, 59, 2)]
    [Dictionary('PDA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALLIQUIDO: Double read FPDA_TOTALLIQUIDO write FPDA_TOTALLIQUIDO;

    [Column('PDA_TOTALPESOBRUTO', ftBCD)]
    [Dictionary('PDA_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPESOBRUTO: Nullable<Double> read FPDA_TOTALPESOBRUTO write FPDA_TOTALPESOBRUTO;

    [Restrictions([NotNull])]
    [Column('PDA_TIPOFRETE', ftString, 1)]
    [Dictionary('PDA_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPOFRETE: String read FPDA_TIPOFRETE write FPDA_TIPOFRETE;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALIPI', ftBCD)]
    [Dictionary('PDA_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIPI: Double read FPDA_TOTALIPI write FPDA_TOTALIPI;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALPIS', ftBCD)]
    [Dictionary('PDA_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPIS: Double read FPDA_TOTALPIS write FPDA_TOTALPIS;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALICMS', ftBCD)]
    [Dictionary('PDA_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMS: Double read FPDA_TOTALICMS write FPDA_TOTALICMS;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALFRETE', ftBCD)]
    [Dictionary('PDA_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFRETE: Double read FPDA_TOTALFRETE write FPDA_TOTALFRETE;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALICMSR', ftBCD)]
    [Dictionary('PDA_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMSR: Double read FPDA_TOTALICMSR write FPDA_TOTALICMSR;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALCOFINS', ftBCD)]
    [Dictionary('PDA_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOFINS: Double read FPDA_TOTALCOFINS write FPDA_TOTALCOFINS;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALSEGURO', ftBCD, 59, 2)]
    [Dictionary('PDA_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSEGURO: Double read FPDA_TOTALSEGURO write FPDA_TOTALSEGURO;

    [Column('PDA_TOTALADICIONAL', ftBCD)]
    [Dictionary('PDA_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALADICIONAL: Nullable<Double> read FPDA_TOTALADICIONAL write FPDA_TOTALADICIONAL;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALSUBSTRIBUTARIA', ftBCD, 1045710155, 2)]
    [Dictionary('PDA_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSUBSTRIBUTARIA: Double read FPDA_TOTALSUBSTRIBUTARIA write FPDA_TOTALSUBSTRIBUTARIA;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('PDA_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESPACESSORIA: Double read FPDA_TOTALDESPACESSORIA write FPDA_TOTALDESPACESSORIA;

    [Column('PDA_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('PDA_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASEISENTOICMS: Nullable<Double> read FPDA_TOTALBASEISENTOICMS write FPDA_TOTALBASEISENTOICMS;

    [Column('PDA_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOMVA: Nullable<Double> read FPDA_TOTALBASECALCULOMVA write FPDA_TOTALBASECALCULOMVA;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOICMS: Double read FPDA_TOTALBASECALCULOICMS write FPDA_TOTALBASECALCULOICMS;

    [Column('PDA_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('PDA_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBCALCULOPISCOFINS: Nullable<Double> read FPDA_TOTALBCALCULOPISCOFINS write FPDA_TOTALBCALCULOPISCOFINS;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('PDA_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFINANCEIROPRAZO: Double read FPDA_TOTALFINANCEIROPRAZO write FPDA_TOTALFINANCEIROPRAZO;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALCOMPLEMENTONFICMS', ftBCD, 1652, 2)]
    [Dictionary('PDA_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMPLEMENTONFICMS: Double read FPDA_TOTALCOMPLEMENTONFICMS write FPDA_TOTALCOMPLEMENTONFICMS;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('PDA_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOITEM: Double read FPDA_TOTALDESCTOITEM write FPDA_TOTALDESCTOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALDESCTOPRAZO', ftBCD)]
    [Dictionary('PDA_TOTALDESCTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOPRAZO: Double read FPDA_TOTALDESCTOPRAZO write FPDA_TOTALDESCTOPRAZO;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('PDA_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOAVULSO: Double read FPDA_TOTALDESCTOAVULSO write FPDA_TOTALDESCTOAVULSO;

    [Column('PDA_TOTALCOMISSAO', ftBCD)]
    [Dictionary('PDA_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMISSAO: Nullable<Double> read FPDA_TOTALCOMISSAO write FPDA_TOTALCOMISSAO;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PDA_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALCOMISSAO: Double read FPDA_PERCENTUALCOMISSAO write FPDA_PERCENTUALCOMISSAO;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALDESCTOAVULSO', ftBCD)]
    [Dictionary('PDA_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESCTOAVULSO: Double read FPDA_PERCENTUALDESCTOAVULSO write FPDA_PERCENTUALDESCTOAVULSO;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALDESCONTOPRAZO', ftBCD)]
    [Dictionary('PDA_PERCENTUALDESCONTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESCONTOPRAZO: Double read FPDA_PERCENTUALDESCONTOPRAZO write FPDA_PERCENTUALDESCONTOPRAZO;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('PDA_PERCENTUALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFINANCEIROPRAZO: Double read FPDA_PERCENTUALFINANCEIROPRAZO write FPDA_PERCENTUALFINANCEIROPRAZO;

    [Column('PDA_MARCAVOLUMES', ftString, 30)]
    [Dictionary('PDA_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_MARCAVOLUMES: Nullable<String> read FPDA_MARCAVOLUMES write FPDA_MARCAVOLUMES;

    [Column('PDA_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('PDA_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_ESPECIEVOLUMES: Nullable<String> read FPDA_ESPECIEVOLUMES write FPDA_ESPECIEVOLUMES;

    [Column('PDA_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('PDA_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERACAOVOLUMES: Nullable<String> read FPDA_NUMERACAOVOLUMES write FPDA_NUMERACAOVOLUMES;

    [Restrictions([NotNull])]
    [Column('PDA_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('PDA_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALNUMEROVOLUMES: Double read FPDA_TOTALNUMEROVOLUMES write FPDA_TOTALNUMEROVOLUMES;

    [Column('PES_CODIGOENTREGA', ftInteger)]
    [Dictionary('PES_CODIGOENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGOENTREGA: Nullable<Integer> read FPES_CODIGOENTREGA write FPES_CODIGOENTREGA;

    [Column('PES_CODIGORETIRADA', ftInteger)]
    [Dictionary('PES_CODIGORETIRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGORETIRADA: Nullable<Integer> read FPES_CODIGORETIRADA write FPES_CODIGORETIRADA;

    [Column('PDA_DATADIGITACAOPALM', ftDateTime)]
    [Dictionary('PDA_DATADIGITACAOPALM', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATADIGITACAOPALM: Nullable<TDateTime> read FPDA_DATADIGITACAOPALM write FPDA_DATADIGITACAOPALM;

    [Column('PDA_HORADIGITACAOPALM', ftString, 10)]
    [Dictionary('PDA_HORADIGITACAOPALM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_HORADIGITACAOPALM: Nullable<String> read FPDA_HORADIGITACAOPALM write FPDA_HORADIGITACAOPALM;

    [Column('PDA_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('PDA_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALAPROXIMADOIMPOSTO: Nullable<Double> read FPDA_TOTALAPROXIMADOIMPOSTO write FPDA_TOTALAPROXIMADOIMPOSTO;

    [Column('PDA_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('PDA_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTMUNICIPAL: Nullable<Double> read FPDA_TOTALIBPTMUNICIPAL write FPDA_TOTALIBPTMUNICIPAL;

    [Column('PDA_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('PDA_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTESTADUAL: Nullable<Double> read FPDA_TOTALIBPTESTADUAL write FPDA_TOTALIBPTESTADUAL;

    [Column('PDA_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('PDA_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTNACIONAL: Nullable<Double> read FPDA_TOTALIBPTNACIONAL write FPDA_TOTALIBPTNACIONAL;

    [Column('PDA_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('PDA_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTIMPORTADO: Nullable<Double> read FPDA_TOTALIBPTIMPORTADO write FPDA_TOTALIBPTIMPORTADO;

    [Column('PDA_PERCENTUALIBPT', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPT: Nullable<Double> read FPDA_PERCENTUALIBPT write FPDA_PERCENTUALIBPT;

    [Column('PDA_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTMUNICIPAL: Nullable<Double> read FPDA_PERCENTUALIBPTMUNICIPAL write FPDA_PERCENTUALIBPTMUNICIPAL;

    [Column('PDA_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTESTADUAL: Nullable<Double> read FPDA_PERCENTUALIBPTESTADUAL write FPDA_PERCENTUALIBPTESTADUAL;

    [Column('PDA_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTNACIONAL: Nullable<Double> read FPDA_PERCENTUALIBPTNACIONAL write FPDA_PERCENTUALIBPTNACIONAL;

    [Column('PDA_PERCENTUALIBPTIMPORTADO', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTIMPORTADO: Nullable<Double> read FPDA_PERCENTUALIBPTIMPORTADO write FPDA_PERCENTUALIBPTIMPORTADO;

    [Column('PDA_TOTALBASECALCULOFCP', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCP: Nullable<Double> read FPDA_TOTALBASECALCULOFCP write FPDA_TOTALBASECALCULOFCP;

    [Column('PDA_TOTALFCP', ftBCD)]
    [Dictionary('PDA_TOTALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCP: Nullable<Double> read FPDA_TOTALFCP write FPDA_TOTALFCP;

    [Column('PDA_TOTALBASECALCULOFCPST', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPST: Nullable<Double> read FPDA_TOTALBASECALCULOFCPST write FPDA_TOTALBASECALCULOFCPST;

    [Column('PDA_TOTALFCPST', ftBCD)]
    [Dictionary('PDA_TOTALFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPST: Nullable<Double> read FPDA_TOTALFCPST write FPDA_TOTALFCPST;

    [Column('PDA_TOTALBASECALCULOFCPRET', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPRET: Nullable<Double> read FPDA_TOTALBASECALCULOFCPRET write FPDA_TOTALBASECALCULOFCPRET;

    [Column('PDA_TOTALFCPRET', ftBCD)]
    [Dictionary('PDA_TOTALFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPRET: Nullable<Double> read FPDA_TOTALFCPRET write FPDA_TOTALFCPRET;

    [Column('PDA_OBSERVACAO', ftString, 5000)]
    [Dictionary('PDA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_OBSERVACAO: Nullable<String> read FPDA_OBSERVACAO write FPDA_OBSERVACAO;

    [Column('PDA_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('PDA_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_OBSERVACAOCANCELAMENTO: Nullable<String> read FPDA_OBSERVACAOCANCELAMENTO write FPDA_OBSERVACAOCANCELAMENTO;

    [Restrictions([NotNull])]
    [Column('PDA_CANCELADA', ftString, 1)]
    [Dictionary('PDA_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CANCELADA: String read FPDA_CANCELADA write FPDA_CANCELADA;

    [Column('PDA_BLOQUEADO', ftString, 1)]
    [Dictionary('PDA_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_BLOQUEADO: Nullable<String> read FPDA_BLOQUEADO write FPDA_BLOQUEADO;

    [Restrictions([NotNull])]
    [Column('PDA_DESATIVADO', ftString, 1)]
    [Dictionary('PDA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DESATIVADO: String read FPDA_DESATIVADO write FPDA_DESATIVADO;

    [Restrictions([NotNull])]
    [Column('PDA_FATURADO', ftString, 1)]
    [Dictionary('PDA_FATURADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_FATURADO: String read FPDA_FATURADO write FPDA_FATURADO;

    [Column('PDA_INTEGRACAO', ftString, 20)]
    [Dictionary('PDA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_INTEGRACAO: Nullable<String> read FPDA_INTEGRACAO write FPDA_INTEGRACAO;

    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: Nullable<String> read FUSERS_LOGIN write FUSERS_LOGIN;

    [Restrictions([NotNull])]
    [Column('PDA_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATAALTERACAO: TDateTime read FPDA_DATAALTERACAO write FPDA_DATAALTERACAO;

    [Column('PDA_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('PDA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPODOCUMENTO: Nullable<String> read FPDA_TIPODOCUMENTO write FPDA_TIPODOCUMENTO;

    [Column('LIB_ID', ftInteger)]
    [Dictionary('LIB_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property LIB_ID: Nullable<Integer> read FLIB_ID write FLIB_ID;

    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CON_CODIGO: Nullable<Integer> read FCON_CODIGO write FCON_CODIGO;

    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ID_OLD: Nullable<Integer> read FPDA_ID_OLD write FPDA_ID_OLD;

    [Column('PDA_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('PDA_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_INTEGRACAO_OLD: Nullable<String> read FPDA_INTEGRACAO_OLD write FPDA_INTEGRACAO_OLD;

    [Column('CGA_ID_OLD', ftInteger)]
    [Dictionary('CGA_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_ID_OLD: Nullable<Integer> read FCGA_ID_OLD write FCGA_ID_OLD;

    [Column('LIB_ID_OLD', ftInteger)]
    [Dictionary('LIB_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property LIB_ID_OLD: Nullable<Integer> read FLIB_ID_OLD write FLIB_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TPDA_00 } 

procedure TPDA_00.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TPDA_00>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TPDA_00>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TPDA_00(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization //RETIRADO POIS FOI MIGRADO TUDO PARA TABELAS DE FATURAMENTO
  //TRegisterClass.RegisterEntity(TPDA_00);
  //TCoreRegisterClass.RegisterEntity(TPDA_00);

end.
