unit express.dbo.FAT_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.fat_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('FAT_00_01', '')]
  [PrimaryKey('FAT_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_01_ID')]
  TDtoFAT_00_01 = class
  private
    { Private declarations } 
    FFAT_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FTAB_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FLEF_CODIGO: Integer;
    FCST_CODIGO: String;
    FNCM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FGRD_CODIGO: String;
    FCSTPC_CODIGO: String;
    FFAT_LEFSTATUS: String;
    FFAT_DESTAQUE_NF: String;
    FFAT_QTDFATURADA: Double;
    FFAT_QTDDEVOLVIDA: Double;
    FFAT_QTDENTREGUE: Double;
    FFAT_QTDRECOLHIDA: Double;
    FFAT_PRECOCUSTO: Double;
    FFAT_PRECOVENDA: Double;
    FFAT_PRECOTABELA: Double;
    FFAT_PRECOLIQUIDO: Double;
    FFAT_PRECODIGITADO: Double;
    FFAT_PRECOBASEDESCTO: Double;
    FFAT_NUMEROVOLUMES: Double;
    FFAT_PERCENTUALIPIITEM: Double;
    FFAT_PERCENTUALPISITEM: Double;
    FFAT_PERCENTUALMVAITEM: Double;
    FFAT_PERCENTUALICMSITEM: Double;
    FFAT_PERCENTUALCOFINSITEM: Double;
    FFAT_PERCENTUALFRETEITEM: Double;
    FFAT_PERCENTUALDESCTOITEM: Double;
    FFAT_PERCENTUALSEGUROITEM: Double;
    FFAT_PERCENTUALREDUCAOBCITEM: Double;
    FFAT_PERCENTUALICMSDESTINOITEM: Double;
    FFAT_PERCENTUALDESPACESSORIAITEM: Double;
    FFAT_PERCENTUALCOMISSAOITEM: Double;
    FFAT_VALORPISITEM: Double;
    FFAT_VALORIPIITEM: Double;
    FFAT_VALORICMSITEM: Double;
    FFAT_VALORICMSRITEM: Double;
    FFAT_VALORFRETEITEM: Double;
    FFAT_VALORCOFINSITEM: Double;
    FFAT_VALORDESCTOITEM: Double;
    FFAT_VALORSEGUROITEM: Double;
    FFAT_VALORBASEOUTROSITEM: Double;
    FFAT_VALORDESCTOPRAZOITEM: Double;
    FFAT_VALORDESCTOAVULSOITEM: Double;
    FFAT_VALORDESPACESSORIAITEM: Double;
    FFAT_VALORSUBSTRIBUTARIAITEM: Double;
    FFAT_VALORBASEISENTOICMSITEM: Double;
    FFAT_VALORBASECALCULOMVAITEM: Double;
    FFAT_VALORBASECALCULOICMSITEM: Double;
    FFAT_VALORFINANCEIROPRAZOITEM: Double;
    FFAT_VALORCOMPLEMENTONFICMSITEM: Double;
    FFAT_VALORBCALCULOPISCOFINSITEM: Double;
    FFAT_VALORCOMISSAOITEM: Double;
    FFAT_TOTALCOMISSAOITEM: Double;
    FFAT_TOTALPISITEM: Double;
    FFAT_TOTALIPIITEM: Double;
    FFAT_TOTALICMSITEM: Double;
    FFAT_TOTALICMSRITEM: Double;
    FFAT_TOTALFRETEITEM: Double;
    FFAT_TOTALCOFINSITEM: Double;
    FFAT_TOTALDESCTOITEM: Double;
    FFAT_TOTALSEGUROITEM: Double;
    FFAT_TOTALBASEOUTROSITEM: Double;
    FFAT_TOTALDESCTOPRAZOITEM: Double;
    FFAT_TOTALDESCTOAVULSOITEM: Double;
    FFAT_TOTALDESPACESSORIAITEM: Double;
    FFAT_TOTALSUBSTRIBUTARIAITEM: Double;
    FFAT_TOTALBASEISENTOICMSITEM: Double;
    FFAT_TOTALBASECALCULOMVAITEM: Double;
    FFAT_TOTALBASECALCULOICMSITEM: Double;
    FFAT_TOTALFINANCEIROPRAZOITEM: Double;
    FFAT_TOTALCOMPLEMENTONFICMSITEM: Double;
    FFAT_TOTALBCALCULOPISCOFINSITEM: Double;
    FFAT_TOTALPRECOLIQUIDO: Double;
    FFAT_TOTALPRECOVENDA: Double;
    FFAT_TOTALPRECOCUSTO: Double;
    FFAT_TOTALPRECOTABELA: Double;
    FFAT_TOTALPRECODIGITADO: Double;
    FFAT_TOTALPRECOBASEDESCTO: Double;
    FFAT_PERCENTUALIBPTITEM: Double;
    FFAT_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FFAT_PESOBRUTOITEM: Double;
    FFAT_PESOLIQUIDOITEM: Double;
    FFAT_ORDEMITEM: Integer;
    FFAT_ORDEMXMLITEM: Integer;
    FFAT_PERCENTUALIBPTMUNICIPALITEM: Double;
    FFAT_PERCENTUALIBPTESTADUALITEM: Double;
    FFAT_PERCENTUALIBPTNACIONALITEM: Double;
    FFAT_PERCENTUALIBPTIMPORTADOITEM: Double;
    FFAT_TOTALIBPTMUNICIPALITEM: Double;
    FFAT_TOTALIBPTESTADUALITEM: Double;
    FFAT_TOTALIBPTNACIONALITEM: Double;
    FFAT_TOTALIBPTIMPORTADOITEM: Double;
    FFAT_PERCENTUALFCPITEM: Double;
    FFAT_TOTALBASECALCULOFCPITEM: Double;
    FFAT_TOTALFCPITEM: Double;
    FFAT_TOTALBASECALCULOFCPSTITEM: Double;
    FFAT_TOTALFCPSTITEM: Double;
    FFAT_TOTALBASECALCULOFCPRETITEM: Double;
    FFAT_TOTALFCPRETITEM: Double;
    FFAT_TOTALREDUCAOBCSTITEM: Double;
    FFAT_VALORREDUCAOBCSTITEM: Double;
    FFAT_PERCENTUALREDUCAOBCSTITEM: Double;
    FFAT_DATAALTERACAO: TDateTime;
    FFAT_01_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_CSTIPI: String;
    FPRO_DESCRICAO: String;
    FFAT_TOTALICMSDESONERADOITEM: Double;
    FFAT_MOTIVODESONERACAO: String;
    FFAT_ICMSDESONERADO: String;
    FFAT_CODIGOBENEFICIO: String;
    FFAT_OBSERVACAOPRODUTONFE: String;
    FFAT_INTEGRACAOERP: String;
    FFAT_TABELAPRECO_PRO: String;
    FFAT_VALORDESCTOCDCITEM: Double;
    FFAT_PERCENTUALICMSCOMPETE: Double;
    FFAT_TOTALDESCTOCDCITEM: Double;
  public
    { Public declarations }
    const Table      = 'FAT_00_01';
    const PrimaryKey = 'FAT_01_ID';
    const Sequence   = 'SEQ_FAT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_01_ID', ftInteger)]
    [Dictionary('FAT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID: Integer read FFAT_01_ID write FFAT_01_ID;
    const FAT_01_ID_Name = 'FAT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [ForeignKey('FAT_00_01_fk', 'FAT_ID', 'FAT_00', 'FAT_ID', SetNull, SetNull)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

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
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_LEFSTATUS', ftString, 1)]
    [Dictionary('FAT_LEFSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_LEFSTATUS: String read FFAT_LEFSTATUS write FFAT_LEFSTATUS;
    const FAT_LEFSTATUS_Name = 'FAT_LEFSTATUS';

    [Restrictions([NoValidate])]
    [Column('FAT_DESTAQUE_NF', ftString, 1)]
    [Dictionary('FAT_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESTAQUE_NF: String read FFAT_DESTAQUE_NF write FFAT_DESTAQUE_NF;
    const FAT_DESTAQUE_NF_Name = 'FAT_DESTAQUE_NF';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Double read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDDEVOLVIDA: Double read FFAT_QTDDEVOLVIDA write FFAT_QTDDEVOLVIDA;
    const FAT_QTDDEVOLVIDA_Name = 'FAT_QTDDEVOLVIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDENTREGUE', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDENTREGUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDENTREGUE: Double read FFAT_QTDENTREGUE write FFAT_QTDENTREGUE;
    const FAT_QTDENTREGUE_Name = 'FAT_QTDENTREGUE';

    [Restrictions([NoValidate])]
    [Column('FAT_QTDRECOLHIDA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDRECOLHIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDRECOLHIDA: Double read FFAT_QTDRECOLHIDA write FFAT_QTDRECOLHIDA;
    const FAT_QTDRECOLHIDA_Name = 'FAT_QTDRECOLHIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOCUSTO: Double read FFAT_PRECOCUSTO write FFAT_PRECOCUSTO;
    const FAT_PRECOCUSTO_Name = 'FAT_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOVENDA', ftBCD)]
    [Dictionary('FAT_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOVENDA: Double read FFAT_PRECOVENDA write FFAT_PRECOVENDA;
    const FAT_PRECOVENDA_Name = 'FAT_PRECOVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOTABELA: Double read FFAT_PRECOTABELA write FFAT_PRECOTABELA;
    const FAT_PRECOTABELA_Name = 'FAT_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOLIQUIDO: Double read FFAT_PRECOLIQUIDO write FFAT_PRECOLIQUIDO;
    const FAT_PRECOLIQUIDO_Name = 'FAT_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECODIGITADO', ftBCD)]
    [Dictionary('FAT_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECODIGITADO: Double read FFAT_PRECODIGITADO write FFAT_PRECODIGITADO;
    const FAT_PRECODIGITADO_Name = 'FAT_PRECODIGITADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOBASEDESCTO', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOBASEDESCTO: Double read FFAT_PRECOBASEDESCTO write FFAT_PRECOBASEDESCTO;
    const FAT_PRECOBASEDESCTO_Name = 'FAT_PRECOBASEDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMEROVOLUMES', ftBCD)]
    [Dictionary('FAT_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_NUMEROVOLUMES: Double read FFAT_NUMEROVOLUMES write FFAT_NUMEROVOLUMES;
    const FAT_NUMEROVOLUMES_Name = 'FAT_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIPIITEM: Double read FFAT_PERCENTUALIPIITEM write FFAT_PERCENTUALIPIITEM;
    const FAT_PERCENTUALIPIITEM_Name = 'FAT_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALPISITEM: Double read FFAT_PERCENTUALPISITEM write FFAT_PERCENTUALPISITEM;
    const FAT_PERCENTUALPISITEM_Name = 'FAT_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALMVAITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALMVAITEM: Double read FFAT_PERCENTUALMVAITEM write FFAT_PERCENTUALMVAITEM;
    const FAT_PERCENTUALMVAITEM_Name = 'FAT_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALICMSITEM: Double read FFAT_PERCENTUALICMSITEM write FFAT_PERCENTUALICMSITEM;
    const FAT_PERCENTUALICMSITEM_Name = 'FAT_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOFINSITEM: Double read FFAT_PERCENTUALCOFINSITEM write FFAT_PERCENTUALCOFINSITEM;
    const FAT_PERCENTUALCOFINSITEM_Name = 'FAT_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALFRETEITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALFRETEITEM: Double read FFAT_PERCENTUALFRETEITEM write FFAT_PERCENTUALFRETEITEM;
    const FAT_PERCENTUALFRETEITEM_Name = 'FAT_PERCENTUALFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALDESCTOITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESCTOITEM: Double read FFAT_PERCENTUALDESCTOITEM write FFAT_PERCENTUALDESCTOITEM;
    const FAT_PERCENTUALDESCTOITEM_Name = 'FAT_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALSEGUROITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALSEGUROITEM: Double read FFAT_PERCENTUALSEGUROITEM write FFAT_PERCENTUALSEGUROITEM;
    const FAT_PERCENTUALSEGUROITEM_Name = 'FAT_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALREDUCAOBCITEM: Double read FFAT_PERCENTUALREDUCAOBCITEM write FFAT_PERCENTUALREDUCAOBCITEM;
    const FAT_PERCENTUALREDUCAOBCITEM_Name = 'FAT_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALICMSDESTINOITEM: Double read FFAT_PERCENTUALICMSDESTINOITEM write FFAT_PERCENTUALICMSDESTINOITEM;
    const FAT_PERCENTUALICMSDESTINOITEM_Name = 'FAT_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESPACESSORIAITEM: Double read FFAT_PERCENTUALDESPACESSORIAITEM write FFAT_PERCENTUALDESPACESSORIAITEM;
    const FAT_PERCENTUALDESPACESSORIAITEM_Name = 'FAT_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALCOMISSAOITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOMISSAOITEM: Double read FFAT_PERCENTUALCOMISSAOITEM write FFAT_PERCENTUALCOMISSAOITEM;
    const FAT_PERCENTUALCOMISSAOITEM_Name = 'FAT_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORPISITEM', ftBCD)]
    [Dictionary('FAT_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPISITEM: Double read FFAT_VALORPISITEM write FFAT_VALORPISITEM;
    const FAT_VALORPISITEM_Name = 'FAT_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORIPIITEM', ftBCD)]
    [Dictionary('FAT_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORIPIITEM: Double read FFAT_VALORIPIITEM write FFAT_VALORIPIITEM;
    const FAT_VALORIPIITEM_Name = 'FAT_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORICMSITEM: Double read FFAT_VALORICMSITEM write FFAT_VALORICMSITEM;
    const FAT_VALORICMSITEM_Name = 'FAT_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORICMSRITEM', ftBCD)]
    [Dictionary('FAT_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORICMSRITEM: Double read FFAT_VALORICMSRITEM write FFAT_VALORICMSRITEM;
    const FAT_VALORICMSRITEM_Name = 'FAT_VALORICMSRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORFRETEITEM', ftBCD)]
    [Dictionary('FAT_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORFRETEITEM: Double read FFAT_VALORFRETEITEM write FFAT_VALORFRETEITEM;
    const FAT_VALORFRETEITEM_Name = 'FAT_VALORFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORCOFINSITEM', ftBCD)]
    [Dictionary('FAT_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOFINSITEM: Double read FFAT_VALORCOFINSITEM write FFAT_VALORCOFINSITEM;
    const FAT_VALORCOFINSITEM_Name = 'FAT_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESCTOITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOITEM: Double read FFAT_VALORDESCTOITEM write FFAT_VALORDESCTOITEM;
    const FAT_VALORDESCTOITEM_Name = 'FAT_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORSEGUROITEM', ftBCD)]
    [Dictionary('FAT_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORSEGUROITEM: Double read FFAT_VALORSEGUROITEM write FFAT_VALORSEGUROITEM;
    const FAT_VALORSEGUROITEM_Name = 'FAT_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASEOUTROSITEM: Double read FFAT_VALORBASEOUTROSITEM write FFAT_VALORBASEOUTROSITEM;
    const FAT_VALORBASEOUTROSITEM_Name = 'FAT_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOPRAZOITEM: Double read FFAT_VALORDESCTOPRAZOITEM write FFAT_VALORDESCTOPRAZOITEM;
    const FAT_VALORDESCTOPRAZOITEM_Name = 'FAT_VALORDESCTOPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOAVULSOITEM: Double read FFAT_VALORDESCTOAVULSOITEM write FFAT_VALORDESCTOAVULSOITEM;
    const FAT_VALORDESCTOAVULSOITEM_Name = 'FAT_VALORDESCTOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('FAT_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESPACESSORIAITEM: Double read FFAT_VALORDESPACESSORIAITEM write FFAT_VALORDESPACESSORIAITEM;
    const FAT_VALORDESPACESSORIAITEM_Name = 'FAT_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORSUBSTRIBUTARIAITEM', ftBCD)]
    [Dictionary('FAT_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORSUBSTRIBUTARIAITEM: Double read FFAT_VALORSUBSTRIBUTARIAITEM write FFAT_VALORSUBSTRIBUTARIAITEM;
    const FAT_VALORSUBSTRIBUTARIAITEM_Name = 'FAT_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASEISENTOICMSITEM: Double read FFAT_VALORBASEISENTOICMSITEM write FFAT_VALORBASEISENTOICMSITEM;
    const FAT_VALORBASEISENTOICMSITEM_Name = 'FAT_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('FAT_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOMVAITEM: Double read FFAT_VALORBASECALCULOMVAITEM write FFAT_VALORBASECALCULOMVAITEM;
    const FAT_VALORBASECALCULOMVAITEM_Name = 'FAT_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOICMSITEM: Double read FFAT_VALORBASECALCULOICMSITEM write FFAT_VALORBASECALCULOICMSITEM;
    const FAT_VALORBASECALCULOICMSITEM_Name = 'FAT_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('FAT_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORFINANCEIROPRAZOITEM: Double read FFAT_VALORFINANCEIROPRAZOITEM write FFAT_VALORFINANCEIROPRAZOITEM;
    const FAT_VALORFINANCEIROPRAZOITEM_Name = 'FAT_VALORFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORCOMPLEMENTONFICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOMPLEMENTONFICMSITEM: Double read FFAT_VALORCOMPLEMENTONFICMSITEM write FFAT_VALORCOMPLEMENTONFICMSITEM;
    const FAT_VALORCOMPLEMENTONFICMSITEM_Name = 'FAT_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('FAT_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBCALCULOPISCOFINSITEM: Double read FFAT_VALORBCALCULOPISCOFINSITEM write FFAT_VALORBCALCULOPISCOFINSITEM;
    const FAT_VALORBCALCULOPISCOFINSITEM_Name = 'FAT_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOMISSAOITEM: Double read FFAT_VALORCOMISSAOITEM write FFAT_VALORCOMISSAOITEM;
    const FAT_VALORCOMISSAOITEM_Name = 'FAT_VALORCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOMISSAOITEM', ftBCD)]
    [Dictionary('FAT_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMISSAOITEM: Double read FFAT_TOTALCOMISSAOITEM write FFAT_TOTALCOMISSAOITEM;
    const FAT_TOTALCOMISSAOITEM_Name = 'FAT_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPISITEM', ftBCD)]
    [Dictionary('FAT_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPISITEM: Double read FFAT_TOTALPISITEM write FFAT_TOTALPISITEM;
    const FAT_TOTALPISITEM_Name = 'FAT_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIPIITEM', ftBCD)]
    [Dictionary('FAT_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIPIITEM: Double read FFAT_TOTALIPIITEM write FFAT_TOTALIPIITEM;
    const FAT_TOTALIPIITEM_Name = 'FAT_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSITEM', ftBCD)]
    [Dictionary('FAT_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSITEM: Double read FFAT_TOTALICMSITEM write FFAT_TOTALICMSITEM;
    const FAT_TOTALICMSITEM_Name = 'FAT_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSRITEM', ftBCD)]
    [Dictionary('FAT_TOTALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSRITEM: Double read FFAT_TOTALICMSRITEM write FFAT_TOTALICMSRITEM;
    const FAT_TOTALICMSRITEM_Name = 'FAT_TOTALICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFRETEITEM', ftBCD)]
    [Dictionary('FAT_TOTALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFRETEITEM: Double read FFAT_TOTALFRETEITEM write FFAT_TOTALFRETEITEM;
    const FAT_TOTALFRETEITEM_Name = 'FAT_TOTALFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('FAT_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOFINSITEM: Double read FFAT_TOTALCOFINSITEM write FFAT_TOTALCOFINSITEM;
    const FAT_TOTALCOFINSITEM_Name = 'FAT_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOITEM: Double read FFAT_TOTALDESCTOITEM write FFAT_TOTALDESCTOITEM;
    const FAT_TOTALDESCTOITEM_Name = 'FAT_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('FAT_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSEGUROITEM: Double read FFAT_TOTALSEGUROITEM write FFAT_TOTALSEGUROITEM;
    const FAT_TOTALSEGUROITEM_Name = 'FAT_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASEOUTROSITEM: Double read FFAT_TOTALBASEOUTROSITEM write FFAT_TOTALBASEOUTROSITEM;
    const FAT_TOTALBASEOUTROSITEM_Name = 'FAT_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOPRAZOITEM: Double read FFAT_TOTALDESCTOPRAZOITEM write FFAT_TOTALDESCTOPRAZOITEM;
    const FAT_TOTALDESCTOPRAZOITEM_Name = 'FAT_TOTALDESCTOPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOAVULSOITEM: Double read FFAT_TOTALDESCTOAVULSOITEM write FFAT_TOTALDESCTOAVULSOITEM;
    const FAT_TOTALDESCTOAVULSOITEM_Name = 'FAT_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('FAT_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESPACESSORIAITEM: Double read FFAT_TOTALDESPACESSORIAITEM write FFAT_TOTALDESPACESSORIAITEM;
    const FAT_TOTALDESPACESSORIAITEM_Name = 'FAT_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSUBSTRIBUTARIAITEM', ftBCD)]
    [Dictionary('FAT_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSUBSTRIBUTARIAITEM: Double read FFAT_TOTALSUBSTRIBUTARIAITEM write FFAT_TOTALSUBSTRIBUTARIAITEM;
    const FAT_TOTALSUBSTRIBUTARIAITEM_Name = 'FAT_TOTALSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASEISENTOICMSITEM: Double read FFAT_TOTALBASEISENTOICMSITEM write FFAT_TOTALBASEISENTOICMSITEM;
    const FAT_TOTALBASEISENTOICMSITEM_Name = 'FAT_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOMVAITEM: Double read FFAT_TOTALBASECALCULOMVAITEM write FFAT_TOTALBASECALCULOMVAITEM;
    const FAT_TOTALBASECALCULOMVAITEM_Name = 'FAT_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOICMSITEM: Double read FFAT_TOTALBASECALCULOICMSITEM write FFAT_TOTALBASECALCULOICMSITEM;
    const FAT_TOTALBASECALCULOICMSITEM_Name = 'FAT_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('FAT_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFINANCEIROPRAZOITEM: Double read FFAT_TOTALFINANCEIROPRAZOITEM write FFAT_TOTALFINANCEIROPRAZOITEM;
    const FAT_TOTALFINANCEIROPRAZOITEM_Name = 'FAT_TOTALFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOMPLEMENTONFICMSITEM', ftBCD)]
    [Dictionary('FAT_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMPLEMENTONFICMSITEM: Double read FFAT_TOTALCOMPLEMENTONFICMSITEM write FFAT_TOTALCOMPLEMENTONFICMSITEM;
    const FAT_TOTALCOMPLEMENTONFICMSITEM_Name = 'FAT_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('FAT_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBCALCULOPISCOFINSITEM: Double read FFAT_TOTALBCALCULOPISCOFINSITEM write FFAT_TOTALBCALCULOPISCOFINSITEM;
    const FAT_TOTALBCALCULOPISCOFINSITEM_Name = 'FAT_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOLIQUIDO: Double read FFAT_TOTALPRECOLIQUIDO write FFAT_TOTALPRECOLIQUIDO;
    const FAT_TOTALPRECOLIQUIDO_Name = 'FAT_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOVENDA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOVENDA: Double read FFAT_TOTALPRECOVENDA write FFAT_TOTALPRECOVENDA;
    const FAT_TOTALPRECOVENDA_Name = 'FAT_TOTALPRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOCUSTO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOCUSTO: Double read FFAT_TOTALPRECOCUSTO write FFAT_TOTALPRECOCUSTO;
    const FAT_TOTALPRECOCUSTO_Name = 'FAT_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOTABELA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOTABELA: Double read FFAT_TOTALPRECOTABELA write FFAT_TOTALPRECOTABELA;
    const FAT_TOTALPRECOTABELA_Name = 'FAT_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECODIGITADO', ftBCD)]
    [Dictionary('FAT_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECODIGITADO: Double read FFAT_TOTALPRECODIGITADO write FFAT_TOTALPRECODIGITADO;
    const FAT_TOTALPRECODIGITADO_Name = 'FAT_TOTALPRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOBASEDESCTO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOBASEDESCTO: Double read FFAT_TOTALPRECOBASEDESCTO write FFAT_TOTALPRECOBASEDESCTO;
    const FAT_TOTALPRECOBASEDESCTO_Name = 'FAT_TOTALPRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTITEM: Double read FFAT_PERCENTUALIBPTITEM write FFAT_PERCENTUALIBPTITEM;
    const FAT_PERCENTUALIBPTITEM_Name = 'FAT_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALAPROXIMADOIMPOSTOITEM', ftBCD)]
    [Dictionary('FAT_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALAPROXIMADOIMPOSTOITEM: Double read FFAT_TOTALAPROXIMADOIMPOSTOITEM write FFAT_TOTALAPROXIMADOIMPOSTOITEM;
    const FAT_TOTALAPROXIMADOIMPOSTOITEM_Name = 'FAT_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PESOBRUTOITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PESOBRUTOITEM: Double read FFAT_PESOBRUTOITEM write FFAT_PESOBRUTOITEM;
    const FAT_PESOBRUTOITEM_Name = 'FAT_PESOBRUTOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PESOLIQUIDOITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PESOLIQUIDOITEM: Double read FFAT_PESOLIQUIDOITEM write FFAT_PESOLIQUIDOITEM;
    const FAT_PESOLIQUIDOITEM_Name = 'FAT_PESOLIQUIDOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_ORDEMITEM', ftInteger)]
    [Dictionary('FAT_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ORDEMITEM: Integer read FFAT_ORDEMITEM write FFAT_ORDEMITEM;
    const FAT_ORDEMITEM_Name = 'FAT_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_ORDEMXMLITEM', ftInteger)]
    [Dictionary('FAT_ORDEMXMLITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ORDEMXMLITEM: Integer read FFAT_ORDEMXMLITEM write FFAT_ORDEMXMLITEM;
    const FAT_ORDEMXMLITEM_Name = 'FAT_ORDEMXMLITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTMUNICIPALITEM: Double read FFAT_PERCENTUALIBPTMUNICIPALITEM write FFAT_PERCENTUALIBPTMUNICIPALITEM;
    const FAT_PERCENTUALIBPTMUNICIPALITEM_Name = 'FAT_PERCENTUALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTESTADUALITEM: Double read FFAT_PERCENTUALIBPTESTADUALITEM write FFAT_PERCENTUALIBPTESTADUALITEM;
    const FAT_PERCENTUALIBPTESTADUALITEM_Name = 'FAT_PERCENTUALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTNACIONALITEM: Double read FFAT_PERCENTUALIBPTNACIONALITEM write FFAT_PERCENTUALIBPTNACIONALITEM;
    const FAT_PERCENTUALIBPTNACIONALITEM_Name = 'FAT_PERCENTUALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTIMPORTADOITEM: Double read FFAT_PERCENTUALIBPTIMPORTADOITEM write FFAT_PERCENTUALIBPTIMPORTADOITEM;
    const FAT_PERCENTUALIBPTIMPORTADOITEM_Name = 'FAT_PERCENTUALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('FAT_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTMUNICIPALITEM: Double read FFAT_TOTALIBPTMUNICIPALITEM write FFAT_TOTALIBPTMUNICIPALITEM;
    const FAT_TOTALIBPTMUNICIPALITEM_Name = 'FAT_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('FAT_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTESTADUALITEM: Double read FFAT_TOTALIBPTESTADUALITEM write FFAT_TOTALIBPTESTADUALITEM;
    const FAT_TOTALIBPTESTADUALITEM_Name = 'FAT_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('FAT_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTNACIONALITEM: Double read FFAT_TOTALIBPTNACIONALITEM write FFAT_TOTALIBPTNACIONALITEM;
    const FAT_TOTALIBPTNACIONALITEM_Name = 'FAT_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('FAT_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTIMPORTADOITEM: Double read FFAT_TOTALIBPTIMPORTADOITEM write FFAT_TOTALIBPTIMPORTADOITEM;
    const FAT_TOTALIBPTIMPORTADOITEM_Name = 'FAT_TOTALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALFCPITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALFCPITEM: Double read FFAT_PERCENTUALFCPITEM write FFAT_PERCENTUALFCPITEM;
    const FAT_PERCENTUALFCPITEM_Name = 'FAT_PERCENTUALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCPITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCPITEM: Double read FFAT_TOTALBASECALCULOFCPITEM write FFAT_TOTALBASECALCULOFCPITEM;
    const FAT_TOTALBASECALCULOFCPITEM_Name = 'FAT_TOTALBASECALCULOFCPITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCPITEM', ftBCD)]
    [Dictionary('FAT_TOTALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCPITEM: Double read FFAT_TOTALFCPITEM write FFAT_TOTALFCPITEM;
    const FAT_TOTALFCPITEM_Name = 'FAT_TOTALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCPSTITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCPSTITEM: Double read FFAT_TOTALBASECALCULOFCPSTITEM write FFAT_TOTALBASECALCULOFCPSTITEM;
    const FAT_TOTALBASECALCULOFCPSTITEM_Name = 'FAT_TOTALBASECALCULOFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCPSTITEM', ftBCD)]
    [Dictionary('FAT_TOTALFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCPSTITEM: Double read FFAT_TOTALFCPSTITEM write FFAT_TOTALFCPSTITEM;
    const FAT_TOTALFCPSTITEM_Name = 'FAT_TOTALFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCPRETITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCPRETITEM: Double read FFAT_TOTALBASECALCULOFCPRETITEM write FFAT_TOTALBASECALCULOFCPRETITEM;
    const FAT_TOTALBASECALCULOFCPRETITEM_Name = 'FAT_TOTALBASECALCULOFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCPRETITEM', ftBCD)]
    [Dictionary('FAT_TOTALFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCPRETITEM: Double read FFAT_TOTALFCPRETITEM write FFAT_TOTALFCPRETITEM;
    const FAT_TOTALFCPRETITEM_Name = 'FAT_TOTALFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALREDUCAOBCSTITEM', ftBCD, 1226851652, 2)]
    [Dictionary('FAT_TOTALREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALREDUCAOBCSTITEM: Double read FFAT_TOTALREDUCAOBCSTITEM write FFAT_TOTALREDUCAOBCSTITEM;
    const FAT_TOTALREDUCAOBCSTITEM_Name = 'FAT_TOTALREDUCAOBCSTITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORREDUCAOBCSTITEM', ftBCD)]
    [Dictionary('FAT_VALORREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORREDUCAOBCSTITEM: Double read FFAT_VALORREDUCAOBCSTITEM write FFAT_VALORREDUCAOBCSTITEM;
    const FAT_VALORREDUCAOBCSTITEM_Name = 'FAT_VALORREDUCAOBCSTITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALREDUCAOBCSTITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALREDUCAOBCSTITEM: Double read FFAT_PERCENTUALREDUCAOBCSTITEM write FFAT_PERCENTUALREDUCAOBCSTITEM;
    const FAT_PERCENTUALREDUCAOBCSTITEM_Name = 'FAT_PERCENTUALREDUCAOBCSTITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_01_ID_OLD', ftInteger)]
    [Dictionary('FAT_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID_OLD: Integer read FFAT_01_ID_OLD write FFAT_01_ID_OLD;
    const FAT_01_ID_OLD_Name = 'FAT_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_CSTIPI', ftString, 2)]
    [Dictionary('FAT_CSTIPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CSTIPI: String read FFAT_CSTIPI write FFAT_CSTIPI;
    const FAT_CSTIPI_Name = 'FAT_CSTIPI';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSDESONERADOITEM', ftBCD)]
    [Dictionary('FAT_TOTALICMSDESONERADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSDESONERADOITEM: Double read FFAT_TOTALICMSDESONERADOITEM write FFAT_TOTALICMSDESONERADOITEM;
    const FAT_TOTALICMSDESONERADOITEM_Name = 'FAT_TOTALICMSDESONERADOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_MOTIVODESONERACAO', ftString, 2)]
    [Dictionary('FAT_MOTIVODESONERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_MOTIVODESONERACAO: String read FFAT_MOTIVODESONERACAO write FFAT_MOTIVODESONERACAO;
    const FAT_MOTIVODESONERACAO_Name = 'FAT_MOTIVODESONERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_ICMSDESONERADO', ftString, 1)]
    [Dictionary('FAT_ICMSDESONERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_ICMSDESONERADO: String read FFAT_ICMSDESONERADO write FFAT_ICMSDESONERADO;
    const FAT_ICMSDESONERADO_Name = 'FAT_ICMSDESONERADO';

    [Restrictions([NoValidate])]
    [Column('FAT_CODIGOBENEFICIO', ftString, 10)]
    [Dictionary('FAT_CODIGOBENEFICIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CODIGOBENEFICIO: String read FFAT_CODIGOBENEFICIO write FFAT_CODIGOBENEFICIO;
    const FAT_CODIGOBENEFICIO_Name = 'FAT_CODIGOBENEFICIO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAOPRODUTONFE', ftString, 250)]
    [Dictionary('FAT_OBSERVACAOPRODUTONFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAOPRODUTONFE: String read FFAT_OBSERVACAOPRODUTONFE write FFAT_OBSERVACAOPRODUTONFE;
    const FAT_OBSERVACAOPRODUTONFE_Name = 'FAT_OBSERVACAOPRODUTONFE';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAOERP', ftString, 50)]
    [Dictionary('FAT_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAOERP: String read FFAT_INTEGRACAOERP write FFAT_INTEGRACAOERP;
    const FAT_INTEGRACAOERP_Name = 'FAT_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('FAT_TABELAPRECO_PRO', ftString, 20)]
    [Dictionary('FAT_TABELAPRECO_PRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TABELAPRECO_PRO: String read FFAT_TABELAPRECO_PRO write FFAT_TABELAPRECO_PRO;
    const FAT_TABELAPRECO_PRO_Name = 'FAT_TABELAPRECO_PRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESCTOCDCITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOCDCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOCDCITEM: Double read FFAT_VALORDESCTOCDCITEM write FFAT_VALORDESCTOCDCITEM;
    const FAT_VALORDESCTOCDCITEM_Name = 'FAT_VALORDESCTOCDCITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALICMSCOMPETE', ftBCD)]
    [Dictionary('FAT_PERCENTUALICMSCOMPETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALICMSCOMPETE: Double read FFAT_PERCENTUALICMSCOMPETE write FFAT_PERCENTUALICMSCOMPETE;
    const FAT_PERCENTUALICMSCOMPETE_Name = 'FAT_PERCENTUALICMSCOMPETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALDESCTOCDCITEM', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOCDCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOCDCITEM: Double read FFAT_TOTALDESCTOCDCITEM write FFAT_TOTALDESCTOCDCITEM;
    const FAT_TOTALDESCTOCDCITEM_Name = 'FAT_TOTALDESCTOCDCITEM';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00_01)

end.
