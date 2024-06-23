unit express.dbo.DEV_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.dev_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('DEV_00_01', '')]
  [PrimaryKey('DEV_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DEV_01_ID')]
  TDtoDEV_00_01 = class
  private
    { Private declarations } 
    FDEV_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FDEV_ID: Integer;
    FDEV_TIPODOCTO: String;
    FFAT_ID: Integer;
    FFAT_01_ID: Integer;
    FFAT_NOTAFISCAL: String;
    FFAT_DATAEMISSAO: TDateTime;
    FTAB_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FLEF_CODIGO: Integer;
    FCST_CODIGO: String;
    FNCM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FGRD_CODIGO: String;
    FDEV_LEFSTATUS: String;
    FDEV_DESTAQUE_NF: String;
    FDEV_QTDFATURADA: Double;
    FDEV_QTDDEVOLVIDA: Double;
    FDEV_PRECOCUSTO: Double;
    FDEV_PRECOVENDA: Double;
    FDEV_PRECOTABELA: Double;
    FDEV_PRECOLIQUIDO: Double;
    FDEV_PRECODIGITADO: Double;
    FDEV_PRECOBASEDESCTO: Double;
    FDEV_NUMEROVOLUMES: Double;
    FDEV_PERCENTUALIPIITEM: Double;
    FDEV_PERCENTUALPISITEM: Double;
    FDEV_PERCENTUALMVAITEM: Double;
    FDEV_PERCENTUALICMSITEM: Double;
    FDEV_PERCENTUALCOFINSITEM: Double;
    FDEV_PERCENTUALFRETEITEM: Double;
    FDEV_PERCENTUALDESCTOITEM: Double;
    FDEV_PERCENTUALSEGUROITEM: Double;
    FDEV_PERCENTUALREDUCAOBCITEM: Double;
    FDEV_PERCENTUALICMSDESTINOITEM: Double;
    FDEV_PERCENTUALDESPACESSORIAITEM: Double;
    FDEV_PERCENTUALCOMISSAOITEM: Double;
    FDEV_VALORPISITEM: Double;
    FDEV_VALORIPIITEM: Double;
    FDEV_VALORICMSITEM: Double;
    FDEV_VALORICMSRITEM: Double;
    FDEV_VALORFRETEITEM: Double;
    FDEV_VALORCOFINSITEM: Double;
    FDEV_VALORDESCTOITEM: Double;
    FDEV_VALORSEGUROITEM: Double;
    FDEV_VALORBASEOUTROSITEM: Double;
    FDEV_VALORDESCTOPRAZOITEM: Double;
    FDEV_VALORDESCTOAVULSOITEM: Double;
    FDEV_VALORDESPACESSORIAITEM: Double;
    FDEV_VALORSUBSTRIBUTARIAITEM: Double;
    FDEV_VALORBASEISENTOICMSITEM: Double;
    FDEV_VALORBASECALCULOMVAITEM: Double;
    FDEV_VALORBASECALCULOICMSITEM: Double;
    FDEV_VALORFINANCEIROPRAZOITEM: Double;
    FDEV_VALORCOMPLEMENTONFICMSITEM: Double;
    FDEV_VALORBCALCULOPISCOFINSITEM: Double;
    FDEV_VALORBASEDESCTOCOMISSAOITEM: Double;
    FDEV_VALORCOMISSAOITEM: Double;
    FDEV_TOTALPISITEM: Double;
    FDEV_TOTALIPIITEM: Double;
    FDEV_TOTALICMSITEM: Double;
    FDEV_TOTALICMSRITEM: Double;
    FDEV_TOTALFRETEITEM: Double;
    FDEV_TOTALCOFINSITEM: Double;
    FDEV_TOTALDESCTOITEM: Double;
    FDEV_TOTALSEGUROITEM: Double;
    FDEV_TOTALCOMISSAOITEM: Double;
    FDEV_TOTALBASEOUTROSITEM: Double;
    FDEV_TOTALDESCTOPRAZOITEM: Double;
    FDEV_TOTALDESCTOAVULSOITEM: Double;
    FDEV_TOTALDESPACESSORIAITEM: Double;
    FDEV_TOTALSUBSTRIBUTARIAITEM: Double;
    FDEV_TOTALBASEISENTOICMSITEM: Double;
    FDEV_TOTALBASECALCULOMVAITEM: Double;
    FDEV_TOTALBASECALCULOICMSITEM: Double;
    FDEV_TOTALFINANCEIROPRAZOITEM: Double;
    FDEV_TOTALCOMPLEMENTONFICMSITEM: Double;
    FDEV_TOTALBCALCULOPISCOFINSITEM: Double;
    FDEV_TOTALBASEDESCTOCOMISSAOITEM: Double;
    FDEV_PERCENTUALIBPTITEM: Double;
    FDEV_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FDEV_PESOLIQUIDOITEM: Double;
    FDEV_PESOBRUTOITEM: Double;
    FDEV_DATAALTERACAO: TDateTime;
    FDEV_TOTALPRECOCUSTO: Double;
    FDEV_TOTALPRECOVENDA: Double;
    FDEV_TOTALPRECOTABELA: Double;
    FDEV_TOTALPRECOLIQUIDO: Double;
    FDEV_TOTALPRECODIGITADO: Double;
    FDEV_TOTALPRECOBASEDESCTO: Double;
    FDEV_ORDEMITEM: Integer;
    FDEV_PERCENTUALIBPTMUNICIPALITEM: Double;
    FDEV_PERCENTUALIBPTESTADUALITEM: Double;
    FDEV_PERCENTUALIBPTNACIONALITEM: Double;
    FDEV_PERCENTUALIBPTIMPORTADOITEM: Double;
    FDEV_TOTALIBPTMUNICIPALITEM: Double;
    FDEV_TOTALIBPTESTADUALITEM: Double;
    FDEV_TOTALIBPTNACIONALITEM: Double;
    FDEV_TOTALIBPTIMPORTADOITEM: Double;
    FDEV_01_ID_OLD: Integer;
    FDEV_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_01_ID_OLD: Integer;

    FDEV_00_0:  TDEV_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'DEV_00_01';
     const PrimaryKey = 'DEV_01_ID';
     const Sequence   = 'SEQ_DEV_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_01_ID', ftInteger)]
    [Dictionary('DEV_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_01_ID: Integer read FDEV_01_ID write FDEV_01_ID;
    const DEV_01_ID_Name = 'DEV_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_ID', ftInteger)]
    [ForeignKey('DEV_00_01_fk', 'DEV_ID', 'DEV_00', 'DEV_ID', SetNull, SetNull)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;
    const DEV_ID_Name = 'DEV_ID';

    [Restrictions([NoValidate])]
    [Column('DEV_TIPODOCTO', ftString, 3)]
    [Dictionary('DEV_TIPODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_TIPODOCTO: String read FDEV_TIPODOCTO write FDEV_TIPODOCTO;
    const DEV_TIPODOCTO_Name = 'DEV_TIPODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_01_ID', ftInteger)]
    [Dictionary('FAT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID: Integer read FFAT_01_ID write FFAT_01_ID;
    const FAT_01_ID_Name = 'FAT_01_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAEMISSAO', ftDateTime)]
    [Dictionary('FAT_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAEMISSAO: TDateTime read FFAT_DATAEMISSAO write FFAT_DATAEMISSAO;
    const FAT_DATAEMISSAO_Name = 'FAT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

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
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEV_LEFSTATUS', ftString, 1)]
    [Dictionary('DEV_LEFSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_LEFSTATUS: String read FDEV_LEFSTATUS write FDEV_LEFSTATUS;
    const DEV_LEFSTATUS_Name = 'DEV_LEFSTATUS';

    [Restrictions([NoValidate])]
    [Column('DEV_DESTAQUE_NF', ftString, 1)]
    [Dictionary('DEV_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_DESTAQUE_NF: String read FDEV_DESTAQUE_NF write FDEV_DESTAQUE_NF;
    const DEV_DESTAQUE_NF_Name = 'DEV_DESTAQUE_NF';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('DEV_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_QTDFATURADA: Double read FDEV_QTDFATURADA write FDEV_QTDFATURADA;
    const DEV_QTDFATURADA_Name = 'DEV_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('DEV_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_QTDDEVOLVIDA: Double read FDEV_QTDDEVOLVIDA write FDEV_QTDDEVOLVIDA;
    const DEV_QTDDEVOLVIDA_Name = 'DEV_QTDDEVOLVIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOCUSTO: Double read FDEV_PRECOCUSTO write FDEV_PRECOCUSTO;
    const DEV_PRECOCUSTO_Name = 'DEV_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOVENDA', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOVENDA: Double read FDEV_PRECOVENDA write FDEV_PRECOVENDA;
    const DEV_PRECOVENDA_Name = 'DEV_PRECOVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOTABELA: Double read FDEV_PRECOTABELA write FDEV_PRECOTABELA;
    const DEV_PRECOTABELA_Name = 'DEV_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOLIQUIDO: Double read FDEV_PRECOLIQUIDO write FDEV_PRECOLIQUIDO;
    const DEV_PRECOLIQUIDO_Name = 'DEV_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECODIGITADO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECODIGITADO: Double read FDEV_PRECODIGITADO write FDEV_PRECODIGITADO;
    const DEV_PRECODIGITADO_Name = 'DEV_PRECODIGITADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOBASEDESCTO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOBASEDESCTO: Double read FDEV_PRECOBASEDESCTO write FDEV_PRECOBASEDESCTO;
    const DEV_PRECOBASEDESCTO_Name = 'DEV_PRECOBASEDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_NUMEROVOLUMES', ftBCD)]
    [Dictionary('DEV_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_NUMEROVOLUMES: Double read FDEV_NUMEROVOLUMES write FDEV_NUMEROVOLUMES;
    const DEV_NUMEROVOLUMES_Name = 'DEV_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIPIITEM: Double read FDEV_PERCENTUALIPIITEM write FDEV_PERCENTUALIPIITEM;
    const DEV_PERCENTUALIPIITEM_Name = 'DEV_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALPISITEM: Double read FDEV_PERCENTUALPISITEM write FDEV_PERCENTUALPISITEM;
    const DEV_PERCENTUALPISITEM_Name = 'DEV_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALMVAITEM', ftBCD, 1147097684, 6)]
    [Dictionary('DEV_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALMVAITEM: Double read FDEV_PERCENTUALMVAITEM write FDEV_PERCENTUALMVAITEM;
    const DEV_PERCENTUALMVAITEM_Name = 'DEV_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALICMSITEM', ftBCD, 1314868549, 6)]
    [Dictionary('DEV_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALICMSITEM: Double read FDEV_PERCENTUALICMSITEM write FDEV_PERCENTUALICMSITEM;
    const DEV_PERCENTUALICMSITEM_Name = 'DEV_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALCOFINSITEM', ftBCD, 1599231043, 6)]
    [Dictionary('DEV_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOFINSITEM: Double read FDEV_PERCENTUALCOFINSITEM write FDEV_PERCENTUALCOFINSITEM;
    const DEV_PERCENTUALCOFINSITEM_Name = 'DEV_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALFRETEITEM', ftBCD, 541868355, 6)]
    [Dictionary('DEV_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALFRETEITEM: Double read FDEV_PERCENTUALFRETEITEM write FDEV_PERCENTUALFRETEITEM;
    const DEV_PERCENTUALFRETEITEM_Name = 'DEV_PERCENTUALFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALDESCTOITEM', ftBCD, 1431064406, 6)]
    [Dictionary('DEV_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESCTOITEM: Double read FDEV_PERCENTUALDESCTOITEM write FDEV_PERCENTUALDESCTOITEM;
    const DEV_PERCENTUALDESCTOITEM_Name = 'DEV_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALSEGUROITEM', ftBCD, 537529693, 6)]
    [Dictionary('DEV_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALSEGUROITEM: Double read FDEV_PERCENTUALSEGUROITEM write FDEV_PERCENTUALSEGUROITEM;
    const DEV_PERCENTUALSEGUROITEM_Name = 'DEV_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALREDUCAOBCITEM', ftBCD, 1382118432, 6)]
    [Dictionary('DEV_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALREDUCAOBCITEM: Double read FDEV_PERCENTUALREDUCAOBCITEM write FDEV_PERCENTUALREDUCAOBCITEM;
    const DEV_PERCENTUALREDUCAOBCITEM_Name = 'DEV_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALICMSDESTINOITEM', ftBCD, 1835362145, 6)]
    [Dictionary('DEV_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALICMSDESTINOITEM: Double read FDEV_PERCENTUALICMSDESTINOITEM write FDEV_PERCENTUALICMSDESTINOITEM;
    const DEV_PERCENTUALICMSDESTINOITEM_Name = 'DEV_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALDESPACESSORIAITEM', ftBCD, 1852795252, 6)]
    [Dictionary('DEV_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESPACESSORIAITEM: Double read FDEV_PERCENTUALDESPACESSORIAITEM write FDEV_PERCENTUALDESPACESSORIAITEM;
    const DEV_PERCENTUALDESPACESSORIAITEM_Name = 'DEV_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALCOMISSAOITEM', ftBCD, 1970040643, 6)]
    [Dictionary('DEV_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOMISSAOITEM: Double read FDEV_PERCENTUALCOMISSAOITEM write FDEV_PERCENTUALCOMISSAOITEM;
    const DEV_PERCENTUALCOMISSAOITEM_Name = 'DEV_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORPISITEM', ftBCD, 168639271, 6)]
    [Dictionary('DEV_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORPISITEM: Double read FDEV_VALORPISITEM write FDEV_VALORPISITEM;
    const DEV_VALORPISITEM_Name = 'DEV_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORIPIITEM', ftBCD, 1599229780, 6)]
    [Dictionary('DEV_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORIPIITEM: Double read FDEV_VALORIPIITEM write FDEV_VALORIPIITEM;
    const DEV_VALORIPIITEM_Name = 'DEV_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORICMSITEM', ftBCD, 1852793632, 6)]
    [Dictionary('DEV_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSITEM: Double read FDEV_VALORICMSITEM write FDEV_VALORICMSITEM;
    const DEV_VALORICMSITEM_Name = 'DEV_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORICMSRITEM', ftBCD, 1128669284, 6)]
    [Dictionary('DEV_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSRITEM: Double read FDEV_VALORICMSRITEM write FDEV_VALORICMSRITEM;
    const DEV_VALORICMSRITEM_Name = 'DEV_VALORICMSRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORFRETEITEM', ftBCD, 539764519, 6)]
    [Dictionary('DEV_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORFRETEITEM: Double read FDEV_VALORFRETEITEM write FDEV_VALORFRETEITEM;
    const DEV_VALORFRETEITEM_Name = 'DEV_VALORFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORCOFINSITEM', ftBCD)]
    [Dictionary('DEV_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOFINSITEM: Double read FDEV_VALORCOFINSITEM write FDEV_VALORCOFINSITEM;
    const DEV_VALORCOFINSITEM_Name = 'DEV_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESCTOITEM', ftBCD, 1981834596, 6)]
    [Dictionary('DEV_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOITEM: Double read FDEV_VALORDESCTOITEM write FDEV_VALORDESCTOITEM;
    const DEV_VALORDESCTOITEM_Name = 'DEV_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORSEGUROITEM', ftBCD, 1852795252, 6)]
    [Dictionary('DEV_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORSEGUROITEM: Double read FDEV_VALORSEGUROITEM write FDEV_VALORSEGUROITEM;
    const DEV_VALORSEGUROITEM_Name = 'DEV_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASEOUTROSITEM', ftBCD, 1280656204, 6)]
    [Dictionary('DEV_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEOUTROSITEM: Double read FDEV_VALORBASEOUTROSITEM write FDEV_VALORBASEOUTROSITEM;
    const DEV_VALORBASEOUTROSITEM_Name = 'DEV_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESCTOPRAZOITEM', ftBCD, 1129070915, 6)]
    [Dictionary('DEV_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOPRAZOITEM: Double read FDEV_VALORDESCTOPRAZOITEM write FDEV_VALORDESCTOPRAZOITEM;
    const DEV_VALORDESCTOPRAZOITEM_Name = 'DEV_VALORDESCTOPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESCTOAVULSOITEM', ftBCD, 1396785746, 6)]
    [Dictionary('DEV_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOAVULSOITEM: Double read FDEV_VALORDESCTOAVULSOITEM write FDEV_VALORDESCTOAVULSOITEM;
    const DEV_VALORDESCTOAVULSOITEM_Name = 'DEV_VALORDESCTOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESPACESSORIAITEM', ftBCD, 1380928577, 6)]
    [Dictionary('DEV_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESPACESSORIAITEM: Double read FDEV_VALORDESPACESSORIAITEM write FDEV_VALORDESPACESSORIAITEM;
    const DEV_VALORDESPACESSORIAITEM_Name = 'DEV_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORSUBSTRIBUTARIAITEM', ftBCD, 1684630625, 6)]
    [Dictionary('DEV_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORSUBSTRIBUTARIAITEM: Double read FDEV_VALORSUBSTRIBUTARIAITEM write FDEV_VALORSUBSTRIBUTARIAITEM;
    const DEV_VALORSUBSTRIBUTARIAITEM_Name = 'DEV_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASEISENTOICMSITEM', ftBCD, 1146045279, 6)]
    [Dictionary('DEV_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEISENTOICMSITEM: Double read FDEV_VALORBASEISENTOICMSITEM write FDEV_VALORBASEISENTOICMSITEM;
    const DEV_VALORBASEISENTOICMSITEM_Name = 'DEV_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASECALCULOMVAITEM', ftBCD, 1852132647, 6)]
    [Dictionary('DEV_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOMVAITEM: Double read FDEV_VALORBASECALCULOMVAITEM write FDEV_VALORBASECALCULOMVAITEM;
    const DEV_VALORBASECALCULOMVAITEM_Name = 'DEV_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('DEV_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOICMSITEM: Double read FDEV_VALORBASECALCULOICMSITEM write FDEV_VALORBASECALCULOICMSITEM;
    const DEV_VALORBASECALCULOICMSITEM_Name = 'DEV_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('DEV_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORFINANCEIROPRAZOITEM: Double read FDEV_VALORFINANCEIROPRAZOITEM write FDEV_VALORFINANCEIROPRAZOITEM;
    const DEV_VALORFINANCEIROPRAZOITEM_Name = 'DEV_VALORFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORCOMPLEMENTONFICMSITEM', ftBCD)]
    [Dictionary('DEV_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOMPLEMENTONFICMSITEM: Double read FDEV_VALORCOMPLEMENTONFICMSITEM write FDEV_VALORCOMPLEMENTONFICMSITEM;
    const DEV_VALORCOMPLEMENTONFICMSITEM_Name = 'DEV_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('DEV_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBCALCULOPISCOFINSITEM: Double read FDEV_VALORBCALCULOPISCOFINSITEM write FDEV_VALORBCALCULOPISCOFINSITEM;
    const DEV_VALORBCALCULOPISCOFINSITEM_Name = 'DEV_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBASEDESCTOCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('DEV_VALORBASEDESCTOCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEDESCTOCOMISSAOITEM: Double read FDEV_VALORBASEDESCTOCOMISSAOITEM write FDEV_VALORBASEDESCTOCOMISSAOITEM;
    const DEV_VALORBASEDESCTOCOMISSAOITEM_Name = 'DEV_VALORBASEDESCTOCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('DEV_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOMISSAOITEM: Double read FDEV_VALORCOMISSAOITEM write FDEV_VALORCOMISSAOITEM;
    const DEV_VALORCOMISSAOITEM_Name = 'DEV_VALORCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPISITEM', ftBCD)]
    [Dictionary('DEV_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPISITEM: Double read FDEV_TOTALPISITEM write FDEV_TOTALPISITEM;
    const DEV_TOTALPISITEM_Name = 'DEV_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIPIITEM', ftBCD)]
    [Dictionary('DEV_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIPIITEM: Double read FDEV_TOTALIPIITEM write FDEV_TOTALIPIITEM;
    const DEV_TOTALIPIITEM_Name = 'DEV_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALICMSITEM', ftBCD)]
    [Dictionary('DEV_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSITEM: Double read FDEV_TOTALICMSITEM write FDEV_TOTALICMSITEM;
    const DEV_TOTALICMSITEM_Name = 'DEV_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALICMSRITEM', ftBCD)]
    [Dictionary('DEV_TOTALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSRITEM: Double read FDEV_TOTALICMSRITEM write FDEV_TOTALICMSRITEM;
    const DEV_TOTALICMSRITEM_Name = 'DEV_TOTALICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALFRETEITEM', ftBCD)]
    [Dictionary('DEV_TOTALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFRETEITEM: Double read FDEV_TOTALFRETEITEM write FDEV_TOTALFRETEITEM;
    const DEV_TOTALFRETEITEM_Name = 'DEV_TOTALFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('DEV_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOFINSITEM: Double read FDEV_TOTALCOFINSITEM write FDEV_TOTALCOFINSITEM;
    const DEV_TOTALCOFINSITEM_Name = 'DEV_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOITEM: Double read FDEV_TOTALDESCTOITEM write FDEV_TOTALDESCTOITEM;
    const DEV_TOTALDESCTOITEM_Name = 'DEV_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('DEV_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSEGUROITEM: Double read FDEV_TOTALSEGUROITEM write FDEV_TOTALSEGUROITEM;
    const DEV_TOTALSEGUROITEM_Name = 'DEV_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALCOMISSAOITEM', ftBCD)]
    [Dictionary('DEV_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMISSAOITEM: Double read FDEV_TOTALCOMISSAOITEM write FDEV_TOTALCOMISSAOITEM;
    const DEV_TOTALCOMISSAOITEM_Name = 'DEV_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('DEV_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEOUTROSITEM: Double read FDEV_TOTALBASEOUTROSITEM write FDEV_TOTALBASEOUTROSITEM;
    const DEV_TOTALBASEOUTROSITEM_Name = 'DEV_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOPRAZOITEM: Double read FDEV_TOTALDESCTOPRAZOITEM write FDEV_TOTALDESCTOPRAZOITEM;
    const DEV_TOTALDESCTOPRAZOITEM_Name = 'DEV_TOTALDESCTOPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('DEV_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOAVULSOITEM: Double read FDEV_TOTALDESCTOAVULSOITEM write FDEV_TOTALDESCTOAVULSOITEM;
    const DEV_TOTALDESCTOAVULSOITEM_Name = 'DEV_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('DEV_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESPACESSORIAITEM: Double read FDEV_TOTALDESPACESSORIAITEM write FDEV_TOTALDESPACESSORIAITEM;
    const DEV_TOTALDESPACESSORIAITEM_Name = 'DEV_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALSUBSTRIBUTARIAITEM', ftBCD)]
    [Dictionary('DEV_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSUBSTRIBUTARIAITEM: Double read FDEV_TOTALSUBSTRIBUTARIAITEM write FDEV_TOTALSUBSTRIBUTARIAITEM;
    const DEV_TOTALSUBSTRIBUTARIAITEM_Name = 'DEV_TOTALSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('DEV_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEISENTOICMSITEM: Double read FDEV_TOTALBASEISENTOICMSITEM write FDEV_TOTALBASEISENTOICMSITEM;
    const DEV_TOTALBASEISENTOICMSITEM_Name = 'DEV_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOMVAITEM: Double read FDEV_TOTALBASECALCULOMVAITEM write FDEV_TOTALBASECALCULOMVAITEM;
    const DEV_TOTALBASECALCULOMVAITEM_Name = 'DEV_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('DEV_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOICMSITEM: Double read FDEV_TOTALBASECALCULOICMSITEM write FDEV_TOTALBASECALCULOICMSITEM;
    const DEV_TOTALBASECALCULOICMSITEM_Name = 'DEV_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('DEV_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFINANCEIROPRAZOITEM: Double read FDEV_TOTALFINANCEIROPRAZOITEM write FDEV_TOTALFINANCEIROPRAZOITEM;
    const DEV_TOTALFINANCEIROPRAZOITEM_Name = 'DEV_TOTALFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALCOMPLEMENTONFICMSITEM', ftBCD)]
    [Dictionary('DEV_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMPLEMENTONFICMSITEM: Double read FDEV_TOTALCOMPLEMENTONFICMSITEM write FDEV_TOTALCOMPLEMENTONFICMSITEM;
    const DEV_TOTALCOMPLEMENTONFICMSITEM_Name = 'DEV_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('DEV_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBCALCULOPISCOFINSITEM: Double read FDEV_TOTALBCALCULOPISCOFINSITEM write FDEV_TOTALBCALCULOPISCOFINSITEM;
    const DEV_TOTALBCALCULOPISCOFINSITEM_Name = 'DEV_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASEDESCTOCOMISSAOITEM', ftBCD)]
    [Dictionary('DEV_TOTALBASEDESCTOCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEDESCTOCOMISSAOITEM: Double read FDEV_TOTALBASEDESCTOCOMISSAOITEM write FDEV_TOTALBASEDESCTOCOMISSAOITEM;
    const DEV_TOTALBASEDESCTOCOMISSAOITEM_Name = 'DEV_TOTALBASEDESCTOCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTITEM: Double read FDEV_PERCENTUALIBPTITEM write FDEV_PERCENTUALIBPTITEM;
    const DEV_PERCENTUALIBPTITEM_Name = 'DEV_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALAPROXIMADOIMPOSTOITEM', ftBCD)]
    [Dictionary('DEV_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALAPROXIMADOIMPOSTOITEM: Double read FDEV_TOTALAPROXIMADOIMPOSTOITEM write FDEV_TOTALAPROXIMADOIMPOSTOITEM;
    const DEV_TOTALAPROXIMADOIMPOSTOITEM_Name = 'DEV_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PESOLIQUIDOITEM', ftBCD)]
    [Dictionary('DEV_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PESOLIQUIDOITEM: Double read FDEV_PESOLIQUIDOITEM write FDEV_PESOLIQUIDOITEM;
    const DEV_PESOLIQUIDOITEM_Name = 'DEV_PESOLIQUIDOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PESOBRUTOITEM', ftBCD)]
    [Dictionary('DEV_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PESOBRUTOITEM: Double read FDEV_PESOBRUTOITEM write FDEV_PESOBRUTOITEM;
    const DEV_PESOBRUTOITEM_Name = 'DEV_PESOBRUTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_DATAALTERACAO', ftDateTime)]
    [Dictionary('DEV_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATAALTERACAO: TDateTime read FDEV_DATAALTERACAO write FDEV_DATAALTERACAO;
    const DEV_DATAALTERACAO_Name = 'DEV_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPRECOCUSTO', ftBCD)]
    [Dictionary('DEV_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOCUSTO: Double read FDEV_TOTALPRECOCUSTO write FDEV_TOTALPRECOCUSTO;
    const DEV_TOTALPRECOCUSTO_Name = 'DEV_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPRECOVENDA', ftBCD)]
    [Dictionary('DEV_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOVENDA: Double read FDEV_TOTALPRECOVENDA write FDEV_TOTALPRECOVENDA;
    const DEV_TOTALPRECOVENDA_Name = 'DEV_TOTALPRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPRECOTABELA', ftBCD)]
    [Dictionary('DEV_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOTABELA: Double read FDEV_TOTALPRECOTABELA write FDEV_TOTALPRECOTABELA;
    const DEV_TOTALPRECOTABELA_Name = 'DEV_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOLIQUIDO: Double read FDEV_TOTALPRECOLIQUIDO write FDEV_TOTALPRECOLIQUIDO;
    const DEV_TOTALPRECOLIQUIDO_Name = 'DEV_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPRECODIGITADO', ftBCD)]
    [Dictionary('DEV_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECODIGITADO: Double read FDEV_TOTALPRECODIGITADO write FDEV_TOTALPRECODIGITADO;
    const DEV_TOTALPRECODIGITADO_Name = 'DEV_TOTALPRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPRECOBASEDESCTO', ftBCD)]
    [Dictionary('DEV_TOTALPRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOBASEDESCTO: Double read FDEV_TOTALPRECOBASEDESCTO write FDEV_TOTALPRECOBASEDESCTO;
    const DEV_TOTALPRECOBASEDESCTO_Name = 'DEV_TOTALPRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('DEV_ORDEMITEM', ftInteger)]
    [Dictionary('DEV_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ORDEMITEM: Integer read FDEV_ORDEMITEM write FDEV_ORDEMITEM;
    const DEV_ORDEMITEM_Name = 'DEV_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTMUNICIPALITEM: Double read FDEV_PERCENTUALIBPTMUNICIPALITEM write FDEV_PERCENTUALIBPTMUNICIPALITEM;
    const DEV_PERCENTUALIBPTMUNICIPALITEM_Name = 'DEV_PERCENTUALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTESTADUALITEM: Double read FDEV_PERCENTUALIBPTESTADUALITEM write FDEV_PERCENTUALIBPTESTADUALITEM;
    const DEV_PERCENTUALIBPTESTADUALITEM_Name = 'DEV_PERCENTUALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTNACIONALITEM: Double read FDEV_PERCENTUALIBPTNACIONALITEM write FDEV_PERCENTUALIBPTNACIONALITEM;
    const DEV_PERCENTUALIBPTNACIONALITEM_Name = 'DEV_PERCENTUALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTIMPORTADOITEM: Double read FDEV_PERCENTUALIBPTIMPORTADOITEM write FDEV_PERCENTUALIBPTIMPORTADOITEM;
    const DEV_PERCENTUALIBPTIMPORTADOITEM_Name = 'DEV_PERCENTUALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('DEV_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTMUNICIPALITEM: Double read FDEV_TOTALIBPTMUNICIPALITEM write FDEV_TOTALIBPTMUNICIPALITEM;
    const DEV_TOTALIBPTMUNICIPALITEM_Name = 'DEV_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('DEV_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTESTADUALITEM: Double read FDEV_TOTALIBPTESTADUALITEM write FDEV_TOTALIBPTESTADUALITEM;
    const DEV_TOTALIBPTESTADUALITEM_Name = 'DEV_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('DEV_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTNACIONALITEM: Double read FDEV_TOTALIBPTNACIONALITEM write FDEV_TOTALIBPTNACIONALITEM;
    const DEV_TOTALIBPTNACIONALITEM_Name = 'DEV_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('DEV_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTIMPORTADOITEM: Double read FDEV_TOTALIBPTIMPORTADOITEM write FDEV_TOTALIBPTIMPORTADOITEM;
    const DEV_TOTALIBPTIMPORTADOITEM_Name = 'DEV_TOTALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_01_ID_OLD', ftInteger)]
    [Dictionary('DEV_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_01_ID_OLD: Integer read FDEV_01_ID_OLD write FDEV_01_ID_OLD;
    const DEV_01_ID_OLD_Name = 'DEV_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('DEV_ID_OLD', ftInteger)]
    [Dictionary('DEV_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID_OLD: Integer read FDEV_ID_OLD write FDEV_ID_OLD;
    const DEV_ID_OLD_Name = 'DEV_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_01_ID_OLD', ftInteger)]
    [Dictionary('FAT_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID_OLD: Integer read FFAT_01_ID_OLD write FFAT_01_ID_OLD;
    const FAT_01_ID_OLD_Name = 'FAT_01_ID_OLD';

    [Association(OneToOne,'DEV_ID','DEV_00','DEV_ID')]
    property DEV_00: TDEV_00 read FDEV_00_0 write FDEV_00_0;

  end;

implementation

constructor TDEV_00_01.Create;
begin
  FDEV_00_0 := TDEV_00.Create;
end;

destructor TDEV_00_01.Destroy;
begin
  if Assigned(FDEV_00_0) then
    FDEV_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoDEV_00_01)

end.
