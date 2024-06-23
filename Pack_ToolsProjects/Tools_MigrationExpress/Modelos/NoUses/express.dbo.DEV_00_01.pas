unit express.dbo.dev_00_01;

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
  [Table('DEV_00_01', 'SELECT * FROM DEV_00_01')]
  [PrimaryKey('DEV_01_ID', NotInc, NoSort, False, 'Chave primária')]
  TDEV_00_01 = class(TModelBase)
  private
    { Private declarations } 
    FDEV_01_ID: Integer;
    FCOM_CODIGO: String;
    FDEV_ID: Integer;
    FDEV_TIPODOCTO: Nullable<String>;
    FFAT_ID: Nullable<Integer>;
    FFAT_01_ID: Nullable<Integer>;
    FFAT_NOTAFISCAL: Nullable<String>;
    FFAT_DATAEMISSAO: Nullable<TDateTime>;
    FTAB_CODIGO: Nullable<Integer>;
    FLEE_CODIGO: Nullable<Integer>;
    FGAI_CODIGO: Nullable<Integer>;
    FPRO_CODIGO: Nullable<Integer>;
    FLEF_CODIGO: Nullable<Integer>;
    FCST_CODIGO: Nullable<String>;
    FNCM_CODIGO: Nullable<Integer>;
    FCFOP_CODIGO: Nullable<String>;
    FCSTPC_CODIGO: Nullable<String>;
    FGRD_CODIGO: Nullable<String>;
    FDEV_LEFSTATUS: Nullable<String>;
    FDEV_DESTAQUE_NF: Nullable<String>;
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
    FDEV_PERCENTUALCOMISSAOITEM: Nullable<Double>;
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
    FDEV_VALORBCALCULOPISCOFINSITEM: Nullable<Double>;
    FDEV_VALORBASEDESCTOCOMISSAOITEM: Nullable<Double>;
    FDEV_VALORCOMISSAOITEM: Nullable<Double>;
    FDEV_TOTALPISITEM: Nullable<Double>;
    FDEV_TOTALIPIITEM: Nullable<Double>;
    FDEV_TOTALICMSITEM: Nullable<Double>;
    FDEV_TOTALICMSRITEM: Nullable<Double>;
    FDEV_TOTALFRETEITEM: Nullable<Double>;
    FDEV_TOTALCOFINSITEM: Nullable<Double>;
    FDEV_TOTALDESCTOITEM: Nullable<Double>;
    FDEV_TOTALSEGUROITEM: Nullable<Double>;
    FDEV_TOTALCOMISSAOITEM: Nullable<Double>;
    FDEV_TOTALBASEOUTROSITEM: Nullable<Double>;
    FDEV_TOTALDESCTOPRAZOITEM: Nullable<Double>;
    FDEV_TOTALDESCTOAVULSOITEM: Nullable<Double>;
    FDEV_TOTALDESPACESSORIAITEM: Nullable<Double>;
    FDEV_TOTALSUBSTRIBUTARIAITEM: Nullable<Double>;
    FDEV_TOTALBASEISENTOICMSITEM: Nullable<Double>;
    FDEV_TOTALBASECALCULOMVAITEM: Nullable<Double>;
    FDEV_TOTALBASECALCULOICMSITEM: Nullable<Double>;
    FDEV_TOTALFINANCEIROPRAZOITEM: Nullable<Double>;
    FDEV_TOTALCOMPLEMENTONFICMSITEM: Nullable<Double>;
    FDEV_TOTALBCALCULOPISCOFINSITEM: Nullable<Double>;
    FDEV_TOTALBASEDESCTOCOMISSAOITEM: Nullable<Double>;
    FDEV_PERCENTUALIBPTITEM: Nullable<Double>;
    FDEV_TOTALAPROXIMADOIMPOSTOITEM: Nullable<Double>;
    FDEV_PESOLIQUIDOITEM: Nullable<Double>;
    FDEV_PESOBRUTOITEM: Nullable<Double>;
    FDEV_DATAALTERACAO: TDateTime;
    FDEV_TOTALPRECOCUSTO: Nullable<Double>;
    FDEV_TOTALPRECOVENDA: Nullable<Double>;
    FDEV_TOTALPRECOTABELA: Nullable<Double>;
    FDEV_TOTALPRECOLIQUIDO: Nullable<Double>;
    FDEV_TOTALPRECODIGITADO: Nullable<Double>;
    FDEV_TOTALPRECOBASEDESCTO: Nullable<Double>;
    FDEV_ORDEMITEM: Nullable<Integer>;
    FDEV_PERCENTUALIBPTMUNICIPALITEM: Nullable<Double>;
    FDEV_PERCENTUALIBPTESTADUALITEM: Nullable<Double>;
    FDEV_PERCENTUALIBPTNACIONALITEM: Nullable<Double>;
    FDEV_PERCENTUALIBPTIMPORTADOITEM: Nullable<Double>;
    FDEV_TOTALIBPTMUNICIPALITEM: Nullable<Double>;
    FDEV_TOTALIBPTESTADUALITEM: Nullable<Double>;
    FDEV_TOTALIBPTNACIONALITEM: Nullable<Double>;
    FDEV_TOTALIBPTIMPORTADOITEM: Nullable<Double>;
    FDEV_01_ID_OLD: Nullable<Integer>;
    FDEV_ID_OLD: Nullable<Integer>;
    FFAT_ID_OLD: Nullable<Integer>;
    FFAT_01_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('DEV_01_ID', ftInteger)]
    [Dictionary('DEV_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_01_ID: Integer read FDEV_01_ID write FDEV_01_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('DEV_ID', ftInteger)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;

    [Column('DEV_TIPODOCTO', ftString, 3)]
    [Dictionary('DEV_TIPODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_TIPODOCTO: Nullable<String> read FDEV_TIPODOCTO write FDEV_TIPODOCTO;

    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_ID: Nullable<Integer> read FFAT_ID write FFAT_ID;

    [Column('FAT_01_ID', ftInteger)]
    [Dictionary('FAT_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_01_ID: Nullable<Integer> read FFAT_01_ID write FFAT_01_ID;

    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: Nullable<String> read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;

    [Column('FAT_DATAEMISSAO', ftDateTime)]
    [Dictionary('FAT_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAEMISSAO: Nullable<TDateTime> read FFAT_DATAEMISSAO write FFAT_DATAEMISSAO;

    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property TAB_CODIGO: Nullable<Integer> read FTAB_CODIGO write FTAB_CODIGO;

    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property LEE_CODIGO: Nullable<Integer> read FLEE_CODIGO write FLEE_CODIGO;

    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property GAI_CODIGO: Nullable<Integer> read FGAI_CODIGO write FGAI_CODIGO;

    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_CODIGO: Nullable<Integer> read FPRO_CODIGO write FPRO_CODIGO;

    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property LEF_CODIGO: Nullable<Integer> read FLEF_CODIGO write FLEF_CODIGO;

    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: Nullable<String> read FCST_CODIGO write FCST_CODIGO;

    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property NCM_CODIGO: Nullable<Integer> read FNCM_CODIGO write FNCM_CODIGO;

    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: Nullable<String> read FCFOP_CODIGO write FCFOP_CODIGO;

    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: Nullable<String> read FCSTPC_CODIGO write FCSTPC_CODIGO;

    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: Nullable<String> read FGRD_CODIGO write FGRD_CODIGO;

    [Column('DEV_LEFSTATUS', ftString, 1)]
    [Dictionary('DEV_LEFSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_LEFSTATUS: Nullable<String> read FDEV_LEFSTATUS write FDEV_LEFSTATUS;

    [Column('DEV_DESTAQUE_NF', ftString, 1)]
    [Dictionary('DEV_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_DESTAQUE_NF: Nullable<String> read FDEV_DESTAQUE_NF write FDEV_DESTAQUE_NF;

    [Restrictions([NotNull])]
    [Column('DEV_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('DEV_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_QTDFATURADA: Double read FDEV_QTDFATURADA write FDEV_QTDFATURADA;

    [Restrictions([NotNull])]
    [Column('DEV_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('DEV_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_QTDDEVOLVIDA: Double read FDEV_QTDDEVOLVIDA write FDEV_QTDDEVOLVIDA;

    [Restrictions([NotNull])]
    [Column('DEV_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOCUSTO: Double read FDEV_PRECOCUSTO write FDEV_PRECOCUSTO;

    [Restrictions([NotNull])]
    [Column('DEV_PRECOVENDA', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOVENDA: Double read FDEV_PRECOVENDA write FDEV_PRECOVENDA;

    [Restrictions([NotNull])]
    [Column('DEV_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOTABELA: Double read FDEV_PRECOTABELA write FDEV_PRECOTABELA;

    [Restrictions([NotNull])]
    [Column('DEV_PRECOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOLIQUIDO: Double read FDEV_PRECOLIQUIDO write FDEV_PRECOLIQUIDO;

    [Restrictions([NotNull])]
    [Column('DEV_PRECODIGITADO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECODIGITADO: Double read FDEV_PRECODIGITADO write FDEV_PRECODIGITADO;

    [Restrictions([NotNull])]
    [Column('DEV_PRECOBASEDESCTO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOBASEDESCTO: Double read FDEV_PRECOBASEDESCTO write FDEV_PRECOBASEDESCTO;

    [Restrictions([NotNull])]
    [Column('DEV_NUMEROVOLUMES', ftBCD)]
    [Dictionary('DEV_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_NUMEROVOLUMES: Double read FDEV_NUMEROVOLUMES write FDEV_NUMEROVOLUMES;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIPIITEM: Double read FDEV_PERCENTUALIPIITEM write FDEV_PERCENTUALIPIITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALPISITEM: Double read FDEV_PERCENTUALPISITEM write FDEV_PERCENTUALPISITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALMVAITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALMVAITEM: Double read FDEV_PERCENTUALMVAITEM write FDEV_PERCENTUALMVAITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALICMSITEM: Double read FDEV_PERCENTUALICMSITEM write FDEV_PERCENTUALICMSITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOFINSITEM: Double read FDEV_PERCENTUALCOFINSITEM write FDEV_PERCENTUALCOFINSITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALFRETEITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALFRETEITEM: Double read FDEV_PERCENTUALFRETEITEM write FDEV_PERCENTUALFRETEITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALDESCTOITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESCTOITEM: Double read FDEV_PERCENTUALDESCTOITEM write FDEV_PERCENTUALDESCTOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALSEGUROITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALSEGUROITEM: Double read FDEV_PERCENTUALSEGUROITEM write FDEV_PERCENTUALSEGUROITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALREDUCAOBCITEM: Double read FDEV_PERCENTUALREDUCAOBCITEM write FDEV_PERCENTUALREDUCAOBCITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALICMSDESTINOITEM: Double read FDEV_PERCENTUALICMSDESTINOITEM write FDEV_PERCENTUALICMSDESTINOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_PERCENTUALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESPACESSORIAITEM: Double read FDEV_PERCENTUALDESPACESSORIAITEM write FDEV_PERCENTUALDESPACESSORIAITEM;

    [Column('DEV_PERCENTUALCOMISSAOITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOMISSAOITEM: Nullable<Double> read FDEV_PERCENTUALCOMISSAOITEM write FDEV_PERCENTUALCOMISSAOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORPISITEM', ftBCD)]
    [Dictionary('DEV_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORPISITEM: Double read FDEV_VALORPISITEM write FDEV_VALORPISITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORIPIITEM', ftBCD)]
    [Dictionary('DEV_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORIPIITEM: Double read FDEV_VALORIPIITEM write FDEV_VALORIPIITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORICMSITEM', ftBCD)]
    [Dictionary('DEV_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSITEM: Double read FDEV_VALORICMSITEM write FDEV_VALORICMSITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORICMSRITEM', ftBCD)]
    [Dictionary('DEV_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSRITEM: Double read FDEV_VALORICMSRITEM write FDEV_VALORICMSRITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORFRETEITEM', ftBCD)]
    [Dictionary('DEV_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORFRETEITEM: Double read FDEV_VALORFRETEITEM write FDEV_VALORFRETEITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORCOFINSITEM', ftBCD)]
    [Dictionary('DEV_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOFINSITEM: Double read FDEV_VALORCOFINSITEM write FDEV_VALORCOFINSITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORDESCTOITEM', ftBCD)]
    [Dictionary('DEV_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOITEM: Double read FDEV_VALORDESCTOITEM write FDEV_VALORDESCTOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORSEGUROITEM', ftBCD)]
    [Dictionary('DEV_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORSEGUROITEM: Double read FDEV_VALORSEGUROITEM write FDEV_VALORSEGUROITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('DEV_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEOUTROSITEM: Double read FDEV_VALORBASEOUTROSITEM write FDEV_VALORBASEOUTROSITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('DEV_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOPRAZOITEM: Double read FDEV_VALORDESCTOPRAZOITEM write FDEV_VALORDESCTOPRAZOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('DEV_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOAVULSOITEM: Double read FDEV_VALORDESCTOAVULSOITEM write FDEV_VALORDESCTOAVULSOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORDESPACESSORIAITEM', ftBCD, 19398656, 6)]
    [Dictionary('DEV_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESPACESSORIAITEM: Double read FDEV_VALORDESPACESSORIAITEM write FDEV_VALORDESPACESSORIAITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORSUBSTRIBUTARIAITEM', ftBCD, 19440536, 6)]
    [Dictionary('DEV_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORSUBSTRIBUTARIAITEM: Double read FDEV_VALORSUBSTRIBUTARIAITEM write FDEV_VALORSUBSTRIBUTARIAITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORBASEISENTOICMSITEM', ftBCD, 19445720, 6)]
    [Dictionary('DEV_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEISENTOICMSITEM: Double read FDEV_VALORBASEISENTOICMSITEM write FDEV_VALORBASEISENTOICMSITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORBASECALCULOMVAITEM', ftBCD, 19450904, 6)]
    [Dictionary('DEV_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOMVAITEM: Double read FDEV_VALORBASECALCULOMVAITEM write FDEV_VALORBASECALCULOMVAITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORBASECALCULOICMSITEM', ftBCD, 53289736, 6)]
    [Dictionary('DEV_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOICMSITEM: Double read FDEV_VALORBASECALCULOICMSITEM write FDEV_VALORBASECALCULOICMSITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORFINANCEIROPRAZOITEM', ftBCD, 53294920, 6)]
    [Dictionary('DEV_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORFINANCEIROPRAZOITEM: Double read FDEV_VALORFINANCEIROPRAZOITEM write FDEV_VALORFINANCEIROPRAZOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_VALORCOMPLEMENTONFICMSITEM', ftBCD, 53300104, 6)]
    [Dictionary('DEV_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOMPLEMENTONFICMSITEM: Double read FDEV_VALORCOMPLEMENTONFICMSITEM write FDEV_VALORCOMPLEMENTONFICMSITEM;

    [Column('DEV_VALORBCALCULOPISCOFINSITEM', ftBCD, 53305288, 6)]
    [Dictionary('DEV_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBCALCULOPISCOFINSITEM: Nullable<Double> read FDEV_VALORBCALCULOPISCOFINSITEM write FDEV_VALORBCALCULOPISCOFINSITEM;

    [Column('DEV_VALORBASEDESCTOCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('DEV_VALORBASEDESCTOCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEDESCTOCOMISSAOITEM: Nullable<Double> read FDEV_VALORBASEDESCTOCOMISSAOITEM write FDEV_VALORBASEDESCTOCOMISSAOITEM;

    [Column('DEV_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('DEV_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOMISSAOITEM: Nullable<Double> read FDEV_VALORCOMISSAOITEM write FDEV_VALORCOMISSAOITEM;

    [Column('DEV_TOTALPISITEM', ftBCD, 53310472, 2)]
    [Dictionary('DEV_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPISITEM: Nullable<Double> read FDEV_TOTALPISITEM write FDEV_TOTALPISITEM;

    [Column('DEV_TOTALIPIITEM', ftBCD, 53315656, 2)]
    [Dictionary('DEV_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIPIITEM: Nullable<Double> read FDEV_TOTALIPIITEM write FDEV_TOTALIPIITEM;

    [Column('DEV_TOTALICMSITEM', ftBCD, 52817616, 2)]
    [Dictionary('DEV_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSITEM: Nullable<Double> read FDEV_TOTALICMSITEM write FDEV_TOTALICMSITEM;

    [Column('DEV_TOTALICMSRITEM', ftBCD, 53435936, 2)]
    [Dictionary('DEV_TOTALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSRITEM: Nullable<Double> read FDEV_TOTALICMSRITEM write FDEV_TOTALICMSRITEM;

    [Column('DEV_TOTALFRETEITEM', ftBCD, 53441120, 2)]
    [Dictionary('DEV_TOTALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFRETEITEM: Nullable<Double> read FDEV_TOTALFRETEITEM write FDEV_TOTALFRETEITEM;

    [Column('DEV_TOTALCOFINSITEM', ftBCD, 53446304, 2)]
    [Dictionary('DEV_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOFINSITEM: Nullable<Double> read FDEV_TOTALCOFINSITEM write FDEV_TOTALCOFINSITEM;

    [Column('DEV_TOTALDESCTOITEM', ftBCD, 96704656, 2)]
    [Dictionary('DEV_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOITEM: Nullable<Double> read FDEV_TOTALDESCTOITEM write FDEV_TOTALDESCTOITEM;

    [Column('DEV_TOTALSEGUROITEM', ftBCD, 96709840, 2)]
    [Dictionary('DEV_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSEGUROITEM: Nullable<Double> read FDEV_TOTALSEGUROITEM write FDEV_TOTALSEGUROITEM;

    [Column('DEV_TOTALCOMISSAOITEM', ftBCD, 96714952, 2)]
    [Dictionary('DEV_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMISSAOITEM: Nullable<Double> read FDEV_TOTALCOMISSAOITEM write FDEV_TOTALCOMISSAOITEM;

    [Column('DEV_TOTALBASEOUTROSITEM', ftBCD, 96720136, 2)]
    [Dictionary('DEV_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEOUTROSITEM: Nullable<Double> read FDEV_TOTALBASEOUTROSITEM write FDEV_TOTALBASEOUTROSITEM;

    [Column('DEV_TOTALDESCTOPRAZOITEM', ftBCD, 96725320, 2)]
    [Dictionary('DEV_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOPRAZOITEM: Nullable<Double> read FDEV_TOTALDESCTOPRAZOITEM write FDEV_TOTALDESCTOPRAZOITEM;

    [Column('DEV_TOTALDESCTOAVULSOITEM', ftBCD, 96730504, 2)]
    [Dictionary('DEV_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOAVULSOITEM: Nullable<Double> read FDEV_TOTALDESCTOAVULSOITEM write FDEV_TOTALDESCTOAVULSOITEM;

    [Column('DEV_TOTALDESPACESSORIAITEM', ftBCD, 96635744, 2)]
    [Dictionary('DEV_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESPACESSORIAITEM: Nullable<Double> read FDEV_TOTALDESPACESSORIAITEM write FDEV_TOTALDESPACESSORIAITEM;

    [Column('DEV_TOTALSUBSTRIBUTARIAITEM', ftBCD, 52814008, 2)]
    [Dictionary('DEV_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSUBSTRIBUTARIAITEM: Nullable<Double> read FDEV_TOTALSUBSTRIBUTARIAITEM write FDEV_TOTALSUBSTRIBUTARIAITEM;

    [Column('DEV_TOTALBASEISENTOICMSITEM', ftBCD, 98479344, 2)]
    [Dictionary('DEV_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEISENTOICMSITEM: Nullable<Double> read FDEV_TOTALBASEISENTOICMSITEM write FDEV_TOTALBASEISENTOICMSITEM;

    [Column('DEV_TOTALBASECALCULOMVAITEM', ftBCD, 98484528, 2)]
    [Dictionary('DEV_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOMVAITEM: Nullable<Double> read FDEV_TOTALBASECALCULOMVAITEM write FDEV_TOTALBASECALCULOMVAITEM;

    [Column('DEV_TOTALBASECALCULOICMSITEM', ftBCD, 98489712, 2)]
    [Dictionary('DEV_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOICMSITEM: Nullable<Double> read FDEV_TOTALBASECALCULOICMSITEM write FDEV_TOTALBASECALCULOICMSITEM;

    [Column('DEV_TOTALFINANCEIROPRAZOITEM', ftBCD, 98494896, 2)]
    [Dictionary('DEV_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFINANCEIROPRAZOITEM: Nullable<Double> read FDEV_TOTALFINANCEIROPRAZOITEM write FDEV_TOTALFINANCEIROPRAZOITEM;

    [Column('DEV_TOTALCOMPLEMENTONFICMSITEM', ftBCD, 98500080, 2)]
    [Dictionary('DEV_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMPLEMENTONFICMSITEM: Nullable<Double> read FDEV_TOTALCOMPLEMENTONFICMSITEM write FDEV_TOTALCOMPLEMENTONFICMSITEM;

    [Column('DEV_TOTALBCALCULOPISCOFINSITEM', ftBCD, 96236536, 2)]
    [Dictionary('DEV_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBCALCULOPISCOFINSITEM: Nullable<Double> read FDEV_TOTALBCALCULOPISCOFINSITEM write FDEV_TOTALBCALCULOPISCOFINSITEM;

    [Column('DEV_TOTALBASEDESCTOCOMISSAOITEM', ftBCD, 3014770, 2)]
    [Dictionary('DEV_TOTALBASEDESCTOCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEDESCTOCOMISSAOITEM: Nullable<Double> read FDEV_TOTALBASEDESCTOCOMISSAOITEM write FDEV_TOTALBASEDESCTOCOMISSAOITEM;

    [Column('DEV_PERCENTUALIBPTITEM', ftBCD, 7602293, 2)]
    [Dictionary('DEV_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTITEM: Nullable<Double> read FDEV_PERCENTUALIBPTITEM write FDEV_PERCENTUALIBPTITEM;

    [Column('DEV_TOTALAPROXIMADOIMPOSTOITEM', ftBCD, 7143529, 2)]
    [Dictionary('DEV_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALAPROXIMADOIMPOSTOITEM: Nullable<Double> read FDEV_TOTALAPROXIMADOIMPOSTOITEM write FDEV_TOTALAPROXIMADOIMPOSTOITEM;

    [Column('DEV_PESOLIQUIDOITEM', ftBCD, 4456521, 3)]
    [Dictionary('DEV_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PESOLIQUIDOITEM: Nullable<Double> read FDEV_PESOLIQUIDOITEM write FDEV_PESOLIQUIDOITEM;

    [Column('DEV_PESOBRUTOITEM', ftBCD, 4063335, 3)]
    [Dictionary('DEV_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PESOBRUTOITEM: Nullable<Double> read FDEV_PESOBRUTOITEM write FDEV_PESOBRUTOITEM;

    [Restrictions([NotNull])]
    [Column('DEV_DATAALTERACAO', ftDateTime)]
    [Dictionary('DEV_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATAALTERACAO: TDateTime read FDEV_DATAALTERACAO write FDEV_DATAALTERACAO;

    [Column('DEV_TOTALPRECOCUSTO', ftBCD, 6619252, 2)]
    [Dictionary('DEV_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOCUSTO: Nullable<Double> read FDEV_TOTALPRECOCUSTO write FDEV_TOTALPRECOCUSTO;

    [Column('DEV_TOTALPRECOVENDA', ftBCD, 2097210, 2)]
    [Dictionary('DEV_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOVENDA: Nullable<Double> read FDEV_TOTALPRECOVENDA write FDEV_TOTALPRECOVENDA;

    [Column('DEV_TOTALPRECOTABELA', ftBCD, 4456518, 2)]
    [Dictionary('DEV_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOTABELA: Nullable<Double> read FDEV_TOTALPRECOTABELA write FDEV_TOTALPRECOTABELA;

    [Column('DEV_TOTALPRECOLIQUIDO', ftBCD, 7077986, 2)]
    [Dictionary('DEV_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOLIQUIDO: Nullable<Double> read FDEV_TOTALPRECOLIQUIDO write FDEV_TOTALPRECOLIQUIDO;

    [Column('DEV_TOTALPRECODIGITADO', ftBCD, 5308489, 2)]
    [Dictionary('DEV_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECODIGITADO: Nullable<Double> read FDEV_TOTALPRECODIGITADO write FDEV_TOTALPRECODIGITADO;

    [Column('DEV_TOTALPRECOBASEDESCTO', ftBCD, 4325452, 2)]
    [Dictionary('DEV_TOTALPRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPRECOBASEDESCTO: Nullable<Double> read FDEV_TOTALPRECOBASEDESCTO write FDEV_TOTALPRECOBASEDESCTO;

    [Column('DEV_ORDEMITEM', ftInteger)]
    [Dictionary('DEV_ORDEMITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_ORDEMITEM: Nullable<Integer> read FDEV_ORDEMITEM write FDEV_ORDEMITEM;

    [Column('DEV_PERCENTUALIBPTMUNICIPALITEM', ftBCD, 5505103, 2)]
    [Dictionary('DEV_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTMUNICIPALITEM: Nullable<Double> read FDEV_PERCENTUALIBPTMUNICIPALITEM write FDEV_PERCENTUALIBPTMUNICIPALITEM;

    [Column('DEV_PERCENTUALIBPTESTADUALITEM', ftBCD, 3801171, 2)]
    [Dictionary('DEV_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTESTADUALITEM: Nullable<Double> read FDEV_PERCENTUALIBPTESTADUALITEM write FDEV_PERCENTUALIBPTESTADUALITEM;

    [Column('DEV_PERCENTUALIBPTNACIONALITEM', ftBCD, 5177434, 2)]
    [Dictionary('DEV_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTNACIONALITEM: Nullable<Double> read FDEV_PERCENTUALIBPTNACIONALITEM write FDEV_PERCENTUALIBPTNACIONALITEM;

    [Column('DEV_PERCENTUALIBPTIMPORTADOITEM', ftBCD, 2097184, 2)]
    [Dictionary('DEV_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTIMPORTADOITEM: Nullable<Double> read FDEV_PERCENTUALIBPTIMPORTADOITEM write FDEV_PERCENTUALIBPTIMPORTADOITEM;

    [Column('DEV_TOTALIBPTMUNICIPALITEM', ftBCD, 4784195, 2)]
    [Dictionary('DEV_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTMUNICIPALITEM: Nullable<Double> read FDEV_TOTALIBPTMUNICIPALITEM write FDEV_TOTALIBPTMUNICIPALITEM;

    [Column('DEV_TOTALIBPTESTADUALITEM', ftBCD, 3866686, 2)]
    [Dictionary('DEV_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTESTADUALITEM: Nullable<Double> read FDEV_TOTALIBPTESTADUALITEM write FDEV_TOTALIBPTESTADUALITEM;

    [Column('DEV_TOTALIBPTNACIONALITEM', ftBCD, 6357100, 2)]
    [Dictionary('DEV_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTNACIONALITEM: Nullable<Double> read FDEV_TOTALIBPTNACIONALITEM write FDEV_TOTALIBPTNACIONALITEM;

    [Column('DEV_TOTALIBPTIMPORTADOITEM', ftBCD, 6226006, 2)]
    [Dictionary('DEV_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTIMPORTADOITEM: Nullable<Double> read FDEV_TOTALIBPTIMPORTADOITEM write FDEV_TOTALIBPTIMPORTADOITEM;

    [Column('DEV_01_ID_OLD', ftInteger)]
    [Dictionary('DEV_01_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_01_ID_OLD: Nullable<Integer> read FDEV_01_ID_OLD write FDEV_01_ID_OLD;

    [Column('DEV_ID_OLD', ftInteger)]
    [Dictionary('DEV_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property DEV_ID_OLD: Nullable<Integer> read FDEV_ID_OLD write FDEV_ID_OLD;

    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_ID_OLD: Nullable<Integer> read FFAT_ID_OLD write FFAT_ID_OLD;

    [Column('FAT_01_ID_OLD', ftInteger)]
    [Dictionary('FAT_01_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_01_ID_OLD: Nullable<Integer> read FFAT_01_ID_OLD write FFAT_01_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TDEV_00_01 } 

procedure TDEV_00_01.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TDEV_00_01>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TDEV_00_01>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TDEV_00_01(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TDEV_00_01);
  TCoreRegisterClass.RegisterEntity(TDEV_00_01);

end.
