unit express.dbo.pda_00_01;

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
  [Table('PDA_00_01', 'SELECT * FROM PDA_00_01')]
  [PrimaryKey('PDA_01_ID', NotInc, NoSort, False, 'Chave primária')]
  TPDA_00_01 = class(TModelBase)
  private
    { Private declarations } 
    FPDA_01_ID: Integer;
    FCOM_CODIGO: String;
    FPDA_ID: Integer;
    FTAB_CODIGO: Nullable<Integer>;
    FCST_CODIGO: Nullable<String>;
    FPRO_CODIGO: Integer;
    FLEE_CODIGO: Nullable<Integer>;
    FLEF_CODIGO: Nullable<Integer>;
    FNCM_CODIGO: Nullable<Integer>;
    FGAI_CODIGO: Nullable<Integer>;
    FCFOP_CODIGO: Nullable<String>;
    FCSTPC_CODIGO: Nullable<String>;
    FGRD_CODIGO: Nullable<String>;
    FPDA_LEFSTATUS: Nullable<String>;
    FPDA_DESTAQUE_NF: Nullable<String>;
    FPDA_QTDPEDIDA: Double;
    FPDA_NUMEROVOLUMES: Double;
    FPDA_PRECOTABELA: Double;
    FPDA_PRECOCUSTO: Double;
    FPDA_PRECOVENDA: Double;
    FPDA_PRECOLIQUIDO: Double;
    FPDA_PRECODIGITADO: Double;
    FPDA_PRECOBASEDESCTO: Double;
    FPDA_VALORCOMISSAOITEM: Nullable<Double>;
    FPDA_VALORIPIITEM: Double;
    FPDA_VALORPISITEM: Double;
    FPDA_VALORICMSITEM: Double;
    FPDA_VALORICMSRITEM: Double;
    FPDA_VALORFRETEITEM: Double;
    FPDA_VALORCOFINSITEM: Double;
    FPDA_VALORDESCTOITEM: Double;
    FPDA_VALORSEGUROITEM: Double;
    FPDA_VALORBASEOUTROSITEM: Double;
    FPDA_VALORDESCTOPRAZOITEM: Double;
    FPDA_VALORDESCTOAVULSOITEM: Double;
    FPDA_VALORDESPACESSORIAITEM: Double;
    FPDA_VALORSUBSTRIBUTARIAITEM: Double;
    FPDA_VALORBASEISENTOICMSITEM: Double;
    FPDA_VALORBASECALCULOMVAITEM: Double;
    FPDA_VALORBASECALCULOICMSITEM: Double;
    FPDA_VALORFINANCEIROPRAZOITEM: Double;
    FPDA_VALORCOMPLEMENTONFICMSITEM: Double;
    FPDA_VALORBCALCULOPISCOFINSITEM: Nullable<Double>;
    FPDA_PERCENTUALIPIITEM: Double;
    FPDA_PERCENTUALPISITEM: Double;
    FPDA_PERCENTUALMVAITEM: Double;
    FPDA_PERCENTUALICMSITEM: Double;
    FPDA_PERCENTUALCOFINSITEM: Double;
    FPDA_PERCENTUALFRETEITEM: Double;
    FPDA_PERCENTUALDESCTOITEM: Double;
    FPDA_PERCENTUALSEGUROITEM: Double;
    FPDA_PERCENTUALREDUCAOBCITEM: Double;
    FPDA_PERCENTUALICMSDESTINOITEM: Double;
    FPDA_PERCENTUALDESPACESSORIAITEM: Double;
    FPDA_PERCENTUALCOMISSAOITEM: Nullable<Double>;
    FPDA_TOTALCOMISSAOITEM: Nullable<Double>;
    FPDA_TOTALIPIITEM: Nullable<Double>;
    FPDA_TOTALPISITEM: Nullable<Double>;
    FPDA_TOTALICMSITEM: Nullable<Double>;
    FPDA_TOTALICMSRITEM: Nullable<Double>;
    FPDA_TOTALFRETEITEM: Nullable<Double>;
    FPDA_TOTALCOFINSITEM: Nullable<Double>;
    FPDA_TOTALDESCTOITEM: Nullable<Double>;
    FPDA_TOTALSEGUROITEM: Nullable<Double>;
    FPDA_TOTALBASEOUTROSITEM: Nullable<Double>;
    FPDA_TOTALDESCTOPRAZOITEM: Nullable<Double>;
    FPDA_TOTALDESCTOAVULSOITEM: Nullable<Double>;
    FPDA_TOTALDESPACESSORIAITEM: Nullable<Double>;
    FPDA_TOTALSUBSTRIBUTARIAITEM: Nullable<Double>;
    FPDA_TOTALBASEISENTOICMSITEM: Nullable<Double>;
    FPDA_TOTALBASECALCULOMVAITEM: Nullable<Double>;
    FPDA_TOTALBASECALCULOICMSITEM: Nullable<Double>;
    FPDA_TOTALFINANCEIROPRAZOITEM: Nullable<Double>;
    FPDA_TOTALCOMPLEMENTONFICMSITEM: Nullable<Double>;
    FPDA_TOTALBCALCULOPISCOFINSITEM: Nullable<Double>;
    FPDA_TOTALPRECOLIQUIDO: Nullable<Double>;
    FPDA_TOTALPRECOVENDA: Nullable<Double>;
    FPDA_TOTALPRECOCUSTO: Nullable<Double>;
    FPDA_TOTALPRECOTABELA: Nullable<Double>;
    FPDA_TOTALPRECODIGITADO: Nullable<Double>;
    FPDA_TOTALPRECOBASEDESCTO: Nullable<Double>;
    FPDA_PESOBRUTOITEM: Nullable<Double>;
    FPDA_PESOLIQUIDOITEM: Nullable<Double>;
    FPDA_ORDEMITEM: Nullable<Integer>;
    FPDA_ORDEMXMLITEM: Nullable<Integer>;
    FPDA_PERCENTUALIBPTITEM: Nullable<Double>;
    FPDA_TOTALAPROXIMADOIMPOSTOITEM: Nullable<Double>;
    FPDA_PERCENTUALIBPTMUNICIPALITEM: Nullable<Double>;
    FPDA_PERCENTUALIBPTESTADUALITEM: Nullable<Double>;
    FPDA_PERCENTUALIBPTNACIONALITEM: Nullable<Double>;
    FPDA_PERCENTUALIBPTIMPORTADOITEM: Nullable<Double>;
    FPDA_TOTALIBPTMUNICIPALITEM: Nullable<Double>;
    FPDA_TOTALIBPTESTADUALITEM: Nullable<Double>;
    FPDA_TOTALIBPTNACIONALITEM: Nullable<Double>;
    FPDA_TOTALIBPTIMPORTADOITEM: Nullable<Double>;
    FPDA_PERCENTUALFCPITEM: Nullable<Double>;
    FPDA_TOTALBASECALCULOFCPITEM: Nullable<Double>;
    FPDA_TOTALFCPITEM: Nullable<Double>;
    FPDA_TOTALBASECALCULOFCPSTITEM: Nullable<Double>;
    FPDA_TOTALFCPSTITEM: Nullable<Double>;
    FPDA_TOTALBASECALCULOFCPRETITEM: Nullable<Double>;
    FPDA_TOTALFCPRETITEM: Nullable<Double>;
    FPDA_TOTALREDUCAOBCSTITEM: Nullable<Double>;
    FPDA_VALORREDUCAOBCSTITEM: Nullable<Double>;
    FPDA_PERCENTUALREDUCAOBCSTITEM: Nullable<Double>;
    FPDA_DATAALTERACAO: TDateTime;
    FPDA_01_ID_OLD: Nullable<Integer>;
    FPDA_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('PDA_01_ID', ftInteger)]
    [Dictionary('PDA_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_01_ID: Integer read FPDA_01_ID write FPDA_01_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;

    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property TAB_CODIGO: Nullable<Integer> read FTAB_CODIGO write FTAB_CODIGO;

    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: Nullable<String> read FCST_CODIGO write FCST_CODIGO;

    [Restrictions([NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;

    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property LEE_CODIGO: Nullable<Integer> read FLEE_CODIGO write FLEE_CODIGO;

    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property LEF_CODIGO: Nullable<Integer> read FLEF_CODIGO write FLEF_CODIGO;

    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property NCM_CODIGO: Nullable<Integer> read FNCM_CODIGO write FNCM_CODIGO;

    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property GAI_CODIGO: Nullable<Integer> read FGAI_CODIGO write FGAI_CODIGO;

    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: Nullable<String> read FCFOP_CODIGO write FCFOP_CODIGO;

    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: Nullable<String> read FCSTPC_CODIGO write FCSTPC_CODIGO;

    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: Nullable<String> read FGRD_CODIGO write FGRD_CODIGO;

    [Column('PDA_LEFSTATUS', ftString, 1)]
    [Dictionary('PDA_LEFSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_LEFSTATUS: Nullable<String> read FPDA_LEFSTATUS write FPDA_LEFSTATUS;

    [Column('PDA_DESTAQUE_NF', ftString, 1)]
    [Dictionary('PDA_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DESTAQUE_NF: Nullable<String> read FPDA_DESTAQUE_NF write FPDA_DESTAQUE_NF;

    [Restrictions([NotNull])]
    [Column('PDA_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('PDA_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_QTDPEDIDA: Double read FPDA_QTDPEDIDA write FPDA_QTDPEDIDA;

    [Restrictions([NotNull])]
    [Column('PDA_NUMEROVOLUMES', ftBCD, 10, 2)]
    [Dictionary('PDA_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_NUMEROVOLUMES: Double read FPDA_NUMEROVOLUMES write FPDA_NUMEROVOLUMES;

    [Restrictions([NotNull])]
    [Column('PDA_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOTABELA: Double read FPDA_PRECOTABELA write FPDA_PRECOTABELA;

    [Restrictions([NotNull])]
    [Column('PDA_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOCUSTO: Double read FPDA_PRECOCUSTO write FPDA_PRECOCUSTO;

    [Restrictions([NotNull])]
    [Column('PDA_PRECOVENDA', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOVENDA: Double read FPDA_PRECOVENDA write FPDA_PRECOVENDA;

    [Restrictions([NotNull])]
    [Column('PDA_PRECOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOLIQUIDO: Double read FPDA_PRECOLIQUIDO write FPDA_PRECOLIQUIDO;

    [Restrictions([NotNull])]
    [Column('PDA_PRECODIGITADO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECODIGITADO: Double read FPDA_PRECODIGITADO write FPDA_PRECODIGITADO;

    [Restrictions([NotNull])]
    [Column('PDA_PRECOBASEDESCTO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOBASEDESCTO: Double read FPDA_PRECOBASEDESCTO write FPDA_PRECOBASEDESCTO;

    [Column('PDA_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORCOMISSAOITEM: Nullable<Double> read FPDA_VALORCOMISSAOITEM write FPDA_VALORCOMISSAOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORIPIITEM', ftBCD)]
    [Dictionary('PDA_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORIPIITEM: Double read FPDA_VALORIPIITEM write FPDA_VALORIPIITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORPISITEM', ftBCD)]
    [Dictionary('PDA_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORPISITEM: Double read FPDA_VALORPISITEM write FPDA_VALORPISITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORICMSITEM', ftBCD)]
    [Dictionary('PDA_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORICMSITEM: Double read FPDA_VALORICMSITEM write FPDA_VALORICMSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORICMSRITEM', ftBCD, 24, 5)]
    [Dictionary('PDA_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORICMSRITEM: Double read FPDA_VALORICMSRITEM write FPDA_VALORICMSRITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORFRETEITEM', ftBCD, 27, 5)]
    [Dictionary('PDA_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORFRETEITEM: Double read FPDA_VALORFRETEITEM write FPDA_VALORFRETEITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORCOFINSITEM', ftBCD, 53305288, 5)]
    [Dictionary('PDA_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORCOFINSITEM: Double read FPDA_VALORCOFINSITEM write FPDA_VALORCOFINSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORDESCTOITEM', ftBCD, 53310472, 5)]
    [Dictionary('PDA_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESCTOITEM: Double read FPDA_VALORDESCTOITEM write FPDA_VALORDESCTOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORSEGUROITEM', ftBCD, 53315656, 5)]
    [Dictionary('PDA_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORSEGUROITEM: Double read FPDA_VALORSEGUROITEM write FPDA_VALORSEGUROITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORBASEOUTROSITEM', ftBCD, 52817616, 5)]
    [Dictionary('PDA_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASEOUTROSITEM: Double read FPDA_VALORBASEOUTROSITEM write FPDA_VALORBASEOUTROSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORDESCTOPRAZOITEM', ftBCD, 53435936, 5)]
    [Dictionary('PDA_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESCTOPRAZOITEM: Double read FPDA_VALORDESCTOPRAZOITEM write FPDA_VALORDESCTOPRAZOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORDESCTOAVULSOITEM', ftBCD, 53441120, 5)]
    [Dictionary('PDA_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESCTOAVULSOITEM: Double read FPDA_VALORDESCTOAVULSOITEM write FPDA_VALORDESCTOAVULSOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORDESPACESSORIAITEM', ftBCD, 53446304, 5)]
    [Dictionary('PDA_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESPACESSORIAITEM: Double read FPDA_VALORDESPACESSORIAITEM write FPDA_VALORDESPACESSORIAITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORSUBSTRIBUTARIAITEM', ftBCD, 96704656, 5)]
    [Dictionary('PDA_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORSUBSTRIBUTARIAITEM: Double read FPDA_VALORSUBSTRIBUTARIAITEM write FPDA_VALORSUBSTRIBUTARIAITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORBASEISENTOICMSITEM', ftBCD, 96709840, 5)]
    [Dictionary('PDA_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASEISENTOICMSITEM: Double read FPDA_VALORBASEISENTOICMSITEM write FPDA_VALORBASEISENTOICMSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORBASECALCULOMVAITEM', ftBCD, 96714952, 5)]
    [Dictionary('PDA_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASECALCULOMVAITEM: Double read FPDA_VALORBASECALCULOMVAITEM write FPDA_VALORBASECALCULOMVAITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('PDA_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASECALCULOICMSITEM: Double read FPDA_VALORBASECALCULOICMSITEM write FPDA_VALORBASECALCULOICMSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('PDA_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORFINANCEIROPRAZOITEM: Double read FPDA_VALORFINANCEIROPRAZOITEM write FPDA_VALORFINANCEIROPRAZOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_VALORCOMPLEMENTONFICMSITEM', ftBCD, 96730504, 5)]
    [Dictionary('PDA_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORCOMPLEMENTONFICMSITEM: Double read FPDA_VALORCOMPLEMENTONFICMSITEM write FPDA_VALORCOMPLEMENTONFICMSITEM;

    [Column('PDA_VALORBCALCULOPISCOFINSITEM', ftBCD, 96635744, 5)]
    [Dictionary('PDA_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBCALCULOPISCOFINSITEM: Nullable<Double> read FPDA_VALORBCALCULOPISCOFINSITEM write FPDA_VALORBCALCULOPISCOFINSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIPIITEM: Double read FPDA_PERCENTUALIPIITEM write FPDA_PERCENTUALIPIITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALPISITEM: Double read FPDA_PERCENTUALPISITEM write FPDA_PERCENTUALPISITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALMVAITEM: Double read FPDA_PERCENTUALMVAITEM write FPDA_PERCENTUALMVAITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALICMSITEM: Double read FPDA_PERCENTUALICMSITEM write FPDA_PERCENTUALICMSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALCOFINSITEM: Double read FPDA_PERCENTUALCOFINSITEM write FPDA_PERCENTUALCOFINSITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALFRETEITEM', ftBCD, 52814008, 6)]
    [Dictionary('PDA_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFRETEITEM: Double read FPDA_PERCENTUALFRETEITEM write FPDA_PERCENTUALFRETEITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESCTOITEM: Double read FPDA_PERCENTUALDESCTOITEM write FPDA_PERCENTUALDESCTOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALSEGUROITEM: Double read FPDA_PERCENTUALSEGUROITEM write FPDA_PERCENTUALSEGUROITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALREDUCAOBCITEM: Double read FPDA_PERCENTUALREDUCAOBCITEM write FPDA_PERCENTUALREDUCAOBCITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALICMSDESTINOITEM: Double read FPDA_PERCENTUALICMSDESTINOITEM write FPDA_PERCENTUALICMSDESTINOITEM;

    [Restrictions([NotNull])]
    [Column('PDA_PERCENTUALDESPACESSORIAITEM', ftBCD, 98479344, 6)]
    [Dictionary('PDA_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESPACESSORIAITEM: Double read FPDA_PERCENTUALDESPACESSORIAITEM write FPDA_PERCENTUALDESPACESSORIAITEM;

    [Column('PDA_PERCENTUALCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALCOMISSAOITEM: Nullable<Double> read FPDA_PERCENTUALCOMISSAOITEM write FPDA_PERCENTUALCOMISSAOITEM;

    [Column('PDA_TOTALCOMISSAOITEM', ftBCD, 98484528, 2)]
    [Dictionary('PDA_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMISSAOITEM: Nullable<Double> read FPDA_TOTALCOMISSAOITEM write FPDA_TOTALCOMISSAOITEM;

    [Column('PDA_TOTALIPIITEM', ftBCD, 98489712, 2)]
    [Dictionary('PDA_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIPIITEM: Nullable<Double> read FPDA_TOTALIPIITEM write FPDA_TOTALIPIITEM;

    [Column('PDA_TOTALPISITEM', ftBCD, 98494896, 2)]
    [Dictionary('PDA_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPISITEM: Nullable<Double> read FPDA_TOTALPISITEM write FPDA_TOTALPISITEM;

    [Column('PDA_TOTALICMSITEM', ftBCD, 98500080, 2)]
    [Dictionary('PDA_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMSITEM: Nullable<Double> read FPDA_TOTALICMSITEM write FPDA_TOTALICMSITEM;

    [Column('PDA_TOTALICMSRITEM', ftBCD, 96236536, 2)]
    [Dictionary('PDA_TOTALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMSRITEM: Nullable<Double> read FPDA_TOTALICMSRITEM write FPDA_TOTALICMSRITEM;

    [Column('PDA_TOTALFRETEITEM', ftBCD, 96241720, 2)]
    [Dictionary('PDA_TOTALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFRETEITEM: Nullable<Double> read FPDA_TOTALFRETEITEM write FPDA_TOTALFRETEITEM;

    [Column('PDA_TOTALCOFINSITEM', ftBCD, 52895552, 2)]
    [Dictionary('PDA_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOFINSITEM: Nullable<Double> read FPDA_TOTALCOFINSITEM write FPDA_TOTALCOFINSITEM;

    [Column('PDA_TOTALDESCTOITEM', ftBCD, 97574608, 2)]
    [Dictionary('PDA_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOITEM: Nullable<Double> read FPDA_TOTALDESCTOITEM write FPDA_TOTALDESCTOITEM;

    [Column('PDA_TOTALSEGUROITEM', ftBCD, 97579792, 2)]
    [Dictionary('PDA_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSEGUROITEM: Nullable<Double> read FPDA_TOTALSEGUROITEM write FPDA_TOTALSEGUROITEM;

    [Column('PDA_TOTALBASEOUTROSITEM', ftBCD, 97584976, 2)]
    [Dictionary('PDA_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASEOUTROSITEM: Nullable<Double> read FPDA_TOTALBASEOUTROSITEM write FPDA_TOTALBASEOUTROSITEM;

    [Column('PDA_TOTALDESCTOPRAZOITEM', ftBCD, 97590232, 2)]
    [Dictionary('PDA_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOPRAZOITEM: Nullable<Double> read FPDA_TOTALDESCTOPRAZOITEM write FPDA_TOTALDESCTOPRAZOITEM;

    [Column('PDA_TOTALDESCTOAVULSOITEM', ftBCD, 97595344, 2)]
    [Dictionary('PDA_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOAVULSOITEM: Nullable<Double> read FPDA_TOTALDESCTOAVULSOITEM write FPDA_TOTALDESCTOAVULSOITEM;

    [Column('PDA_TOTALDESPACESSORIAITEM', ftBCD, 97600528, 2)]
    [Dictionary('PDA_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESPACESSORIAITEM: Nullable<Double> read FPDA_TOTALDESPACESSORIAITEM write FPDA_TOTALDESPACESSORIAITEM;

    [Column('PDA_TOTALSUBSTRIBUTARIAITEM', ftBCD, 99208272, 2)]
    [Dictionary('PDA_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSUBSTRIBUTARIAITEM: Nullable<Double> read FPDA_TOTALSUBSTRIBUTARIAITEM write FPDA_TOTALSUBSTRIBUTARIAITEM;

    [Column('PDA_TOTALBASEISENTOICMSITEM', ftBCD, 99677360, 2)]
    [Dictionary('PDA_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASEISENTOICMSITEM: Nullable<Double> read FPDA_TOTALBASEISENTOICMSITEM write FPDA_TOTALBASEISENTOICMSITEM;

    [Column('PDA_TOTALBASECALCULOMVAITEM', ftBCD, 99684344, 2)]
    [Dictionary('PDA_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOMVAITEM: Nullable<Double> read FPDA_TOTALBASECALCULOMVAITEM write FPDA_TOTALBASECALCULOMVAITEM;

    [Column('PDA_TOTALBASECALCULOICMSITEM', ftBCD, 97743840, 2)]
    [Dictionary('PDA_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOICMSITEM: Nullable<Double> read FPDA_TOTALBASECALCULOICMSITEM write FPDA_TOTALBASECALCULOICMSITEM;

    [Column('PDA_TOTALFINANCEIROPRAZOITEM', ftBCD, 98333072, 2)]
    [Dictionary('PDA_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFINANCEIROPRAZOITEM: Nullable<Double> read FPDA_TOTALFINANCEIROPRAZOITEM write FPDA_TOTALFINANCEIROPRAZOITEM;

    [Column('PDA_TOTALCOMPLEMENTONFICMSITEM', ftBCD, 99431448, 2)]
    [Dictionary('PDA_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMPLEMENTONFICMSITEM: Nullable<Double> read FPDA_TOTALCOMPLEMENTONFICMSITEM write FPDA_TOTALCOMPLEMENTONFICMSITEM;

    [Column('PDA_TOTALBCALCULOPISCOFINSITEM', ftBCD, 99436416, 2)]
    [Dictionary('PDA_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBCALCULOPISCOFINSITEM: Nullable<Double> read FPDA_TOTALBCALCULOPISCOFINSITEM write FPDA_TOTALBCALCULOPISCOFINSITEM;

    [Column('PDA_TOTALPRECOLIQUIDO', ftBCD, 16061496, 2)]
    [Dictionary('PDA_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOLIQUIDO: Nullable<Double> read FPDA_TOTALPRECOLIQUIDO write FPDA_TOTALPRECOLIQUIDO;

    [Column('PDA_TOTALPRECOVENDA', ftBCD, 16063224, 2)]
    [Dictionary('PDA_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOVENDA: Nullable<Double> read FPDA_TOTALPRECOVENDA write FPDA_TOTALPRECOVENDA;

    [Column('PDA_TOTALPRECOCUSTO', ftBCD, 16072008, 2)]
    [Dictionary('PDA_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOCUSTO: Nullable<Double> read FPDA_TOTALPRECOCUSTO write FPDA_TOTALPRECOCUSTO;

    [Column('PDA_TOTALPRECOTABELA', ftBCD, 24, 2)]
    [Dictionary('PDA_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOTABELA: Nullable<Double> read FPDA_TOTALPRECOTABELA write FPDA_TOTALPRECOTABELA;

    [Column('PDA_TOTALPRECODIGITADO', ftBCD, 10, 2)]
    [Dictionary('PDA_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECODIGITADO: Nullable<Double> read FPDA_TOTALPRECODIGITADO write FPDA_TOTALPRECODIGITADO;

    [Column('PDA_TOTALPRECOBASEDESCTO', ftBCD)]
    [Dictionary('PDA_TOTALPRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOBASEDESCTO: Nullable<Double> read FPDA_TOTALPRECOBASEDESCTO write FPDA_TOTALPRECOBASEDESCTO;

    [Column('PDA_PESOBRUTOITEM', ftBCD)]
    [Dictionary('PDA_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PESOBRUTOITEM: Nullable<Double> read FPDA_PESOBRUTOITEM write FPDA_PESOBRUTOITEM;

    [Column('PDA_PESOLIQUIDOITEM', ftBCD)]
    [Dictionary('PDA_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PESOLIQUIDOITEM: Nullable<Double> read FPDA_PESOLIQUIDOITEM write FPDA_PESOLIQUIDOITEM;

    [Column('PDA_ORDEMITEM', ftInteger)]
    [Dictionary('PDA_ORDEMITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ORDEMITEM: Nullable<Integer> read FPDA_ORDEMITEM write FPDA_ORDEMITEM;

    [Column('PDA_ORDEMXMLITEM', ftInteger)]
    [Dictionary('PDA_ORDEMXMLITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ORDEMXMLITEM: Nullable<Integer> read FPDA_ORDEMXMLITEM write FPDA_ORDEMXMLITEM;

    [Column('PDA_PERCENTUALIBPTITEM', ftBCD, 53305288, 2)]
    [Dictionary('PDA_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTITEM: Nullable<Double> read FPDA_PERCENTUALIBPTITEM write FPDA_PERCENTUALIBPTITEM;

    [Column('PDA_TOTALAPROXIMADOIMPOSTOITEM', ftBCD, 53310472, 2)]
    [Dictionary('PDA_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALAPROXIMADOIMPOSTOITEM: Nullable<Double> read FPDA_TOTALAPROXIMADOIMPOSTOITEM write FPDA_TOTALAPROXIMADOIMPOSTOITEM;

    [Column('PDA_PERCENTUALIBPTMUNICIPALITEM', ftBCD, 53315656, 2)]
    [Dictionary('PDA_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTMUNICIPALITEM: Nullable<Double> read FPDA_PERCENTUALIBPTMUNICIPALITEM write FPDA_PERCENTUALIBPTMUNICIPALITEM;

    [Column('PDA_PERCENTUALIBPTESTADUALITEM', ftBCD, 52817616, 2)]
    [Dictionary('PDA_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTESTADUALITEM: Nullable<Double> read FPDA_PERCENTUALIBPTESTADUALITEM write FPDA_PERCENTUALIBPTESTADUALITEM;

    [Column('PDA_PERCENTUALIBPTNACIONALITEM', ftBCD, 53435936, 2)]
    [Dictionary('PDA_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTNACIONALITEM: Nullable<Double> read FPDA_PERCENTUALIBPTNACIONALITEM write FPDA_PERCENTUALIBPTNACIONALITEM;

    [Column('PDA_PERCENTUALIBPTIMPORTADOITEM', ftBCD, 53441120, 2)]
    [Dictionary('PDA_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTIMPORTADOITEM: Nullable<Double> read FPDA_PERCENTUALIBPTIMPORTADOITEM write FPDA_PERCENTUALIBPTIMPORTADOITEM;

    [Column('PDA_TOTALIBPTMUNICIPALITEM', ftBCD, 53446304, 2)]
    [Dictionary('PDA_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTMUNICIPALITEM: Nullable<Double> read FPDA_TOTALIBPTMUNICIPALITEM write FPDA_TOTALIBPTMUNICIPALITEM;

    [Column('PDA_TOTALIBPTESTADUALITEM', ftBCD, 96704656, 2)]
    [Dictionary('PDA_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTESTADUALITEM: Nullable<Double> read FPDA_TOTALIBPTESTADUALITEM write FPDA_TOTALIBPTESTADUALITEM;

    [Column('PDA_TOTALIBPTNACIONALITEM', ftBCD, 96709840, 2)]
    [Dictionary('PDA_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTNACIONALITEM: Nullable<Double> read FPDA_TOTALIBPTNACIONALITEM write FPDA_TOTALIBPTNACIONALITEM;

    [Column('PDA_TOTALIBPTIMPORTADOITEM', ftBCD, 96714952, 2)]
    [Dictionary('PDA_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTIMPORTADOITEM: Nullable<Double> read FPDA_TOTALIBPTIMPORTADOITEM write FPDA_TOTALIBPTIMPORTADOITEM;

    [Column('PDA_PERCENTUALFCPITEM', ftBCD, 96720136, 2)]
    [Dictionary('PDA_PERCENTUALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFCPITEM: Nullable<Double> read FPDA_PERCENTUALFCPITEM write FPDA_PERCENTUALFCPITEM;

    [Column('PDA_TOTALBASECALCULOFCPITEM', ftBCD, 96725320, 2)]
    [Dictionary('PDA_TOTALBASECALCULOFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPITEM: Nullable<Double> read FPDA_TOTALBASECALCULOFCPITEM write FPDA_TOTALBASECALCULOFCPITEM;

    [Column('PDA_TOTALFCPITEM', ftBCD, 96730504, 2)]
    [Dictionary('PDA_TOTALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPITEM: Nullable<Double> read FPDA_TOTALFCPITEM write FPDA_TOTALFCPITEM;

    [Column('PDA_TOTALBASECALCULOFCPSTITEM', ftBCD, 96635744, 2)]
    [Dictionary('PDA_TOTALBASECALCULOFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPSTITEM: Nullable<Double> read FPDA_TOTALBASECALCULOFCPSTITEM write FPDA_TOTALBASECALCULOFCPSTITEM;

    [Column('PDA_TOTALFCPSTITEM', ftBCD, 52814008, 2)]
    [Dictionary('PDA_TOTALFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPSTITEM: Nullable<Double> read FPDA_TOTALFCPSTITEM write FPDA_TOTALFCPSTITEM;

    [Column('PDA_TOTALBASECALCULOFCPRETITEM', ftBCD, 98479344, 2)]
    [Dictionary('PDA_TOTALBASECALCULOFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPRETITEM: Nullable<Double> read FPDA_TOTALBASECALCULOFCPRETITEM write FPDA_TOTALBASECALCULOFCPRETITEM;

    [Column('PDA_TOTALFCPRETITEM', ftBCD, 98484528, 2)]
    [Dictionary('PDA_TOTALFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPRETITEM: Nullable<Double> read FPDA_TOTALFCPRETITEM write FPDA_TOTALFCPRETITEM;

    [Column('PDA_TOTALREDUCAOBCSTITEM', ftBCD, 98489712, 2)]
    [Dictionary('PDA_TOTALREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALREDUCAOBCSTITEM: Nullable<Double> read FPDA_TOTALREDUCAOBCSTITEM write FPDA_TOTALREDUCAOBCSTITEM;

    [Column('PDA_VALORREDUCAOBCSTITEM', ftBCD, 98494896, 6)]
    [Dictionary('PDA_VALORREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORREDUCAOBCSTITEM: Nullable<Double> read FPDA_VALORREDUCAOBCSTITEM write FPDA_VALORREDUCAOBCSTITEM;

    [Column('PDA_PERCENTUALREDUCAOBCSTITEM', ftBCD, 98500080, 2)]
    [Dictionary('PDA_PERCENTUALREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALREDUCAOBCSTITEM: Nullable<Double> read FPDA_PERCENTUALREDUCAOBCSTITEM write FPDA_PERCENTUALREDUCAOBCSTITEM;

    [Restrictions([NotNull])]
    [Column('PDA_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATAALTERACAO: TDateTime read FPDA_DATAALTERACAO write FPDA_DATAALTERACAO;

    [Column('PDA_01_ID_OLD', ftInteger)]
    [Dictionary('PDA_01_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_01_ID_OLD: Nullable<Integer> read FPDA_01_ID_OLD write FPDA_01_ID_OLD;

    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ID_OLD: Nullable<Integer> read FPDA_ID_OLD write FPDA_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TPDA_00_01 } 

procedure TPDA_00_01.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TPDA_00_01>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TPDA_00_01>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TPDA_00_01(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization //RETIRADO POIS FOI MIGRADO TUDO PARA TABELAS DE FATURAMENTO
  //TRegisterClass.RegisterEntity(TPDA_00_01);
  //TCoreRegisterClass.RegisterEntity(TPDA_00_01);

end.
