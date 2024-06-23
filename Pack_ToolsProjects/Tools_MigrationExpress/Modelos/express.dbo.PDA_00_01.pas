unit express.dbo.PDA_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.pda_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PDA_00_01', '')]
  [PrimaryKey('PDA_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDA_01_ID')]
  TDtoPDA_00_01 = class
  private
    { Private declarations } 
    FPDA_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDA_ID: Integer;
    FTAB_CODIGO: Integer;
    FCST_CODIGO: String;
    FPRO_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FLEF_CODIGO: Integer;
    FNCM_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FGRD_CODIGO: String;
    FPDA_LEFSTATUS: String;
    FPDA_DESTAQUE_NF: String;
    FPDA_QTDPEDIDA: Double;
    FPDA_NUMEROVOLUMES: Double;
    FPDA_PRECOTABELA: Double;
    FPDA_PRECOCUSTO: Double;
    FPDA_PRECOVENDA: Double;
    FPDA_PRECOLIQUIDO: Double;
    FPDA_PRECODIGITADO: Double;
    FPDA_PRECOBASEDESCTO: Double;
    FPDA_VALORCOMISSAOITEM: Double;
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
    FPDA_VALORBCALCULOPISCOFINSITEM: Double;
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
    FPDA_PERCENTUALCOMISSAOITEM: Double;
    FPDA_TOTALCOMISSAOITEM: Double;
    FPDA_TOTALIPIITEM: Double;
    FPDA_TOTALPISITEM: Double;
    FPDA_TOTALICMSITEM: Double;
    FPDA_TOTALICMSRITEM: Double;
    FPDA_TOTALFRETEITEM: Double;
    FPDA_TOTALCOFINSITEM: Double;
    FPDA_TOTALDESCTOITEM: Double;
    FPDA_TOTALSEGUROITEM: Double;
    FPDA_TOTALBASEOUTROSITEM: Double;
    FPDA_TOTALDESCTOPRAZOITEM: Double;
    FPDA_TOTALDESCTOAVULSOITEM: Double;
    FPDA_TOTALDESPACESSORIAITEM: Double;
    FPDA_TOTALSUBSTRIBUTARIAITEM: Double;
    FPDA_TOTALBASEISENTOICMSITEM: Double;
    FPDA_TOTALBASECALCULOMVAITEM: Double;
    FPDA_TOTALBASECALCULOICMSITEM: Double;
    FPDA_TOTALFINANCEIROPRAZOITEM: Double;
    FPDA_TOTALCOMPLEMENTONFICMSITEM: Double;
    FPDA_TOTALBCALCULOPISCOFINSITEM: Double;
    FPDA_TOTALPRECOLIQUIDO: Double;
    FPDA_TOTALPRECOVENDA: Double;
    FPDA_TOTALPRECOCUSTO: Double;
    FPDA_TOTALPRECOTABELA: Double;
    FPDA_TOTALPRECODIGITADO: Double;
    FPDA_TOTALPRECOBASEDESCTO: Double;
    FPDA_PESOBRUTOITEM: Double;
    FPDA_PESOLIQUIDOITEM: Double;
    FPDA_ORDEMITEM: Integer;
    FPDA_ORDEMXMLITEM: Integer;
    FPDA_PERCENTUALIBPTITEM: Double;
    FPDA_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FPDA_PERCENTUALIBPTMUNICIPALITEM: Double;
    FPDA_PERCENTUALIBPTESTADUALITEM: Double;
    FPDA_PERCENTUALIBPTNACIONALITEM: Double;
    FPDA_PERCENTUALIBPTIMPORTADOITEM: Double;
    FPDA_TOTALIBPTMUNICIPALITEM: Double;
    FPDA_TOTALIBPTESTADUALITEM: Double;
    FPDA_TOTALIBPTNACIONALITEM: Double;
    FPDA_TOTALIBPTIMPORTADOITEM: Double;
    FPDA_PERCENTUALFCPITEM: Double;
    FPDA_TOTALBASECALCULOFCPITEM: Double;
    FPDA_TOTALFCPITEM: Double;
    FPDA_TOTALBASECALCULOFCPSTITEM: Double;
    FPDA_TOTALFCPSTITEM: Double;
    FPDA_TOTALBASECALCULOFCPRETITEM: Double;
    FPDA_TOTALFCPRETITEM: Double;
    FPDA_TOTALREDUCAOBCSTITEM: Double;
    FPDA_VALORREDUCAOBCSTITEM: Double;
    FPDA_PERCENTUALREDUCAOBCSTITEM: Double;
    FPDA_DATAALTERACAO: TDateTime;
    FPDA_01_ID_OLD: Integer;
    FPDA_ID_OLD: Integer;

    FPDA_00_0:  TPDA_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'PDA_00_01';
     const PrimaryKey = 'PDA_01_ID';
     const Sequence   = 'SEQ_PDA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_01_ID', ftInteger)]
    [Dictionary('PDA_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_01_ID: Integer read FPDA_01_ID write FPDA_01_ID;
    const PDA_01_ID_Name = 'PDA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [ForeignKey('PDA_00_01_fk', 'PDA_ID', 'PDA_00', 'PDA_ID', SetNull, SetNull)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

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
    [Column('PDA_LEFSTATUS', ftString, 1)]
    [Dictionary('PDA_LEFSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_LEFSTATUS: String read FPDA_LEFSTATUS write FPDA_LEFSTATUS;
    const PDA_LEFSTATUS_Name = 'PDA_LEFSTATUS';

    [Restrictions([NoValidate])]
    [Column('PDA_DESTAQUE_NF', ftString, 1)]
    [Dictionary('PDA_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DESTAQUE_NF: String read FPDA_DESTAQUE_NF write FPDA_DESTAQUE_NF;
    const PDA_DESTAQUE_NF_Name = 'PDA_DESTAQUE_NF';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('PDA_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_QTDPEDIDA: Double read FPDA_QTDPEDIDA write FPDA_QTDPEDIDA;
    const PDA_QTDPEDIDA_Name = 'PDA_QTDPEDIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_NUMEROVOLUMES', ftBCD)]
    [Dictionary('PDA_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_NUMEROVOLUMES: Double read FPDA_NUMEROVOLUMES write FPDA_NUMEROVOLUMES;
    const PDA_NUMEROVOLUMES_Name = 'PDA_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOTABELA: Double read FPDA_PRECOTABELA write FPDA_PRECOTABELA;
    const PDA_PRECOTABELA_Name = 'PDA_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOCUSTO: Double read FPDA_PRECOCUSTO write FPDA_PRECOCUSTO;
    const PDA_PRECOCUSTO_Name = 'PDA_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PRECOVENDA', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOVENDA: Double read FPDA_PRECOVENDA write FPDA_PRECOVENDA;
    const PDA_PRECOVENDA_Name = 'PDA_PRECOVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PRECOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOLIQUIDO: Double read FPDA_PRECOLIQUIDO write FPDA_PRECOLIQUIDO;
    const PDA_PRECOLIQUIDO_Name = 'PDA_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PRECODIGITADO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECODIGITADO: Double read FPDA_PRECODIGITADO write FPDA_PRECODIGITADO;
    const PDA_PRECODIGITADO_Name = 'PDA_PRECODIGITADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PRECOBASEDESCTO', ftBCD, 18, 4)]
    [Dictionary('PDA_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PRECOBASEDESCTO: Double read FPDA_PRECOBASEDESCTO write FPDA_PRECOBASEDESCTO;
    const PDA_PRECOBASEDESCTO_Name = 'PDA_PRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('PDA_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORCOMISSAOITEM: Double read FPDA_VALORCOMISSAOITEM write FPDA_VALORCOMISSAOITEM;
    const PDA_VALORCOMISSAOITEM_Name = 'PDA_VALORCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORIPIITEM', ftBCD)]
    [Dictionary('PDA_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORIPIITEM: Double read FPDA_VALORIPIITEM write FPDA_VALORIPIITEM;
    const PDA_VALORIPIITEM_Name = 'PDA_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORPISITEM', ftBCD)]
    [Dictionary('PDA_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORPISITEM: Double read FPDA_VALORPISITEM write FPDA_VALORPISITEM;
    const PDA_VALORPISITEM_Name = 'PDA_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORICMSITEM', ftBCD)]
    [Dictionary('PDA_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORICMSITEM: Double read FPDA_VALORICMSITEM write FPDA_VALORICMSITEM;
    const PDA_VALORICMSITEM_Name = 'PDA_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORICMSRITEM', ftBCD)]
    [Dictionary('PDA_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORICMSRITEM: Double read FPDA_VALORICMSRITEM write FPDA_VALORICMSRITEM;
    const PDA_VALORICMSRITEM_Name = 'PDA_VALORICMSRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORFRETEITEM', ftBCD)]
    [Dictionary('PDA_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORFRETEITEM: Double read FPDA_VALORFRETEITEM write FPDA_VALORFRETEITEM;
    const PDA_VALORFRETEITEM_Name = 'PDA_VALORFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORCOFINSITEM', ftBCD)]
    [Dictionary('PDA_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORCOFINSITEM: Double read FPDA_VALORCOFINSITEM write FPDA_VALORCOFINSITEM;
    const PDA_VALORCOFINSITEM_Name = 'PDA_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORDESCTOITEM', ftBCD)]
    [Dictionary('PDA_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESCTOITEM: Double read FPDA_VALORDESCTOITEM write FPDA_VALORDESCTOITEM;
    const PDA_VALORDESCTOITEM_Name = 'PDA_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORSEGUROITEM', ftBCD)]
    [Dictionary('PDA_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORSEGUROITEM: Double read FPDA_VALORSEGUROITEM write FPDA_VALORSEGUROITEM;
    const PDA_VALORSEGUROITEM_Name = 'PDA_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('PDA_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASEOUTROSITEM: Double read FPDA_VALORBASEOUTROSITEM write FPDA_VALORBASEOUTROSITEM;
    const PDA_VALORBASEOUTROSITEM_Name = 'PDA_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('PDA_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESCTOPRAZOITEM: Double read FPDA_VALORDESCTOPRAZOITEM write FPDA_VALORDESCTOPRAZOITEM;
    const PDA_VALORDESCTOPRAZOITEM_Name = 'PDA_VALORDESCTOPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('PDA_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESCTOAVULSOITEM: Double read FPDA_VALORDESCTOAVULSOITEM write FPDA_VALORDESCTOAVULSOITEM;
    const PDA_VALORDESCTOAVULSOITEM_Name = 'PDA_VALORDESCTOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('PDA_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORDESPACESSORIAITEM: Double read FPDA_VALORDESPACESSORIAITEM write FPDA_VALORDESPACESSORIAITEM;
    const PDA_VALORDESPACESSORIAITEM_Name = 'PDA_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORSUBSTRIBUTARIAITEM', ftBCD)]
    [Dictionary('PDA_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORSUBSTRIBUTARIAITEM: Double read FPDA_VALORSUBSTRIBUTARIAITEM write FPDA_VALORSUBSTRIBUTARIAITEM;
    const PDA_VALORSUBSTRIBUTARIAITEM_Name = 'PDA_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('PDA_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASEISENTOICMSITEM: Double read FPDA_VALORBASEISENTOICMSITEM write FPDA_VALORBASEISENTOICMSITEM;
    const PDA_VALORBASEISENTOICMSITEM_Name = 'PDA_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('PDA_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASECALCULOMVAITEM: Double read FPDA_VALORBASECALCULOMVAITEM write FPDA_VALORBASECALCULOMVAITEM;
    const PDA_VALORBASECALCULOMVAITEM_Name = 'PDA_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('PDA_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBASECALCULOICMSITEM: Double read FPDA_VALORBASECALCULOICMSITEM write FPDA_VALORBASECALCULOICMSITEM;
    const PDA_VALORBASECALCULOICMSITEM_Name = 'PDA_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('PDA_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORFINANCEIROPRAZOITEM: Double read FPDA_VALORFINANCEIROPRAZOITEM write FPDA_VALORFINANCEIROPRAZOITEM;
    const PDA_VALORFINANCEIROPRAZOITEM_Name = 'PDA_VALORFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_VALORCOMPLEMENTONFICMSITEM', ftBCD)]
    [Dictionary('PDA_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORCOMPLEMENTONFICMSITEM: Double read FPDA_VALORCOMPLEMENTONFICMSITEM write FPDA_VALORCOMPLEMENTONFICMSITEM;
    const PDA_VALORCOMPLEMENTONFICMSITEM_Name = 'PDA_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('PDA_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORBCALCULOPISCOFINSITEM: Double read FPDA_VALORBCALCULOPISCOFINSITEM write FPDA_VALORBCALCULOPISCOFINSITEM;
    const PDA_VALORBCALCULOPISCOFINSITEM_Name = 'PDA_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIPIITEM: Double read FPDA_PERCENTUALIPIITEM write FPDA_PERCENTUALIPIITEM;
    const PDA_PERCENTUALIPIITEM_Name = 'PDA_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALPISITEM: Double read FPDA_PERCENTUALPISITEM write FPDA_PERCENTUALPISITEM;
    const PDA_PERCENTUALPISITEM_Name = 'PDA_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALMVAITEM: Double read FPDA_PERCENTUALMVAITEM write FPDA_PERCENTUALMVAITEM;
    const PDA_PERCENTUALMVAITEM_Name = 'PDA_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALICMSITEM: Double read FPDA_PERCENTUALICMSITEM write FPDA_PERCENTUALICMSITEM;
    const PDA_PERCENTUALICMSITEM_Name = 'PDA_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALCOFINSITEM: Double read FPDA_PERCENTUALCOFINSITEM write FPDA_PERCENTUALCOFINSITEM;
    const PDA_PERCENTUALCOFINSITEM_Name = 'PDA_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALFRETEITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFRETEITEM: Double read FPDA_PERCENTUALFRETEITEM write FPDA_PERCENTUALFRETEITEM;
    const PDA_PERCENTUALFRETEITEM_Name = 'PDA_PERCENTUALFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESCTOITEM: Double read FPDA_PERCENTUALDESCTOITEM write FPDA_PERCENTUALDESCTOITEM;
    const PDA_PERCENTUALDESCTOITEM_Name = 'PDA_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALSEGUROITEM: Double read FPDA_PERCENTUALSEGUROITEM write FPDA_PERCENTUALSEGUROITEM;
    const PDA_PERCENTUALSEGUROITEM_Name = 'PDA_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALREDUCAOBCITEM: Double read FPDA_PERCENTUALREDUCAOBCITEM write FPDA_PERCENTUALREDUCAOBCITEM;
    const PDA_PERCENTUALREDUCAOBCITEM_Name = 'PDA_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALICMSDESTINOITEM: Double read FPDA_PERCENTUALICMSDESTINOITEM write FPDA_PERCENTUALICMSDESTINOITEM;
    const PDA_PERCENTUALICMSDESTINOITEM_Name = 'PDA_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESPACESSORIAITEM: Double read FPDA_PERCENTUALDESPACESSORIAITEM write FPDA_PERCENTUALDESPACESSORIAITEM;
    const PDA_PERCENTUALDESPACESSORIAITEM_Name = 'PDA_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALCOMISSAOITEM: Double read FPDA_PERCENTUALCOMISSAOITEM write FPDA_PERCENTUALCOMISSAOITEM;
    const PDA_PERCENTUALCOMISSAOITEM_Name = 'PDA_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALCOMISSAOITEM', ftBCD)]
    [Dictionary('PDA_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMISSAOITEM: Double read FPDA_TOTALCOMISSAOITEM write FPDA_TOTALCOMISSAOITEM;
    const PDA_TOTALCOMISSAOITEM_Name = 'PDA_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIPIITEM', ftBCD)]
    [Dictionary('PDA_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIPIITEM: Double read FPDA_TOTALIPIITEM write FPDA_TOTALIPIITEM;
    const PDA_TOTALIPIITEM_Name = 'PDA_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPISITEM', ftBCD)]
    [Dictionary('PDA_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPISITEM: Double read FPDA_TOTALPISITEM write FPDA_TOTALPISITEM;
    const PDA_TOTALPISITEM_Name = 'PDA_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALICMSITEM', ftBCD)]
    [Dictionary('PDA_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMSITEM: Double read FPDA_TOTALICMSITEM write FPDA_TOTALICMSITEM;
    const PDA_TOTALICMSITEM_Name = 'PDA_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALICMSRITEM', ftBCD)]
    [Dictionary('PDA_TOTALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMSRITEM: Double read FPDA_TOTALICMSRITEM write FPDA_TOTALICMSRITEM;
    const PDA_TOTALICMSRITEM_Name = 'PDA_TOTALICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFRETEITEM', ftBCD)]
    [Dictionary('PDA_TOTALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFRETEITEM: Double read FPDA_TOTALFRETEITEM write FPDA_TOTALFRETEITEM;
    const PDA_TOTALFRETEITEM_Name = 'PDA_TOTALFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('PDA_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOFINSITEM: Double read FPDA_TOTALCOFINSITEM write FPDA_TOTALCOFINSITEM;
    const PDA_TOTALCOFINSITEM_Name = 'PDA_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('PDA_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOITEM: Double read FPDA_TOTALDESCTOITEM write FPDA_TOTALDESCTOITEM;
    const PDA_TOTALDESCTOITEM_Name = 'PDA_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('PDA_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSEGUROITEM: Double read FPDA_TOTALSEGUROITEM write FPDA_TOTALSEGUROITEM;
    const PDA_TOTALSEGUROITEM_Name = 'PDA_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('PDA_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASEOUTROSITEM: Double read FPDA_TOTALBASEOUTROSITEM write FPDA_TOTALBASEOUTROSITEM;
    const PDA_TOTALBASEOUTROSITEM_Name = 'PDA_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('PDA_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOPRAZOITEM: Double read FPDA_TOTALDESCTOPRAZOITEM write FPDA_TOTALDESCTOPRAZOITEM;
    const PDA_TOTALDESCTOPRAZOITEM_Name = 'PDA_TOTALDESCTOPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('PDA_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOAVULSOITEM: Double read FPDA_TOTALDESCTOAVULSOITEM write FPDA_TOTALDESCTOAVULSOITEM;
    const PDA_TOTALDESCTOAVULSOITEM_Name = 'PDA_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('PDA_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESPACESSORIAITEM: Double read FPDA_TOTALDESPACESSORIAITEM write FPDA_TOTALDESPACESSORIAITEM;
    const PDA_TOTALDESPACESSORIAITEM_Name = 'PDA_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALSUBSTRIBUTARIAITEM', ftBCD)]
    [Dictionary('PDA_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSUBSTRIBUTARIAITEM: Double read FPDA_TOTALSUBSTRIBUTARIAITEM write FPDA_TOTALSUBSTRIBUTARIAITEM;
    const PDA_TOTALSUBSTRIBUTARIAITEM_Name = 'PDA_TOTALSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('PDA_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASEISENTOICMSITEM: Double read FPDA_TOTALBASEISENTOICMSITEM write FPDA_TOTALBASEISENTOICMSITEM;
    const PDA_TOTALBASEISENTOICMSITEM_Name = 'PDA_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOMVAITEM: Double read FPDA_TOTALBASECALCULOMVAITEM write FPDA_TOTALBASECALCULOMVAITEM;
    const PDA_TOTALBASECALCULOMVAITEM_Name = 'PDA_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOICMSITEM: Double read FPDA_TOTALBASECALCULOICMSITEM write FPDA_TOTALBASECALCULOICMSITEM;
    const PDA_TOTALBASECALCULOICMSITEM_Name = 'PDA_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('PDA_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFINANCEIROPRAZOITEM: Double read FPDA_TOTALFINANCEIROPRAZOITEM write FPDA_TOTALFINANCEIROPRAZOITEM;
    const PDA_TOTALFINANCEIROPRAZOITEM_Name = 'PDA_TOTALFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALCOMPLEMENTONFICMSITEM', ftBCD)]
    [Dictionary('PDA_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMPLEMENTONFICMSITEM: Double read FPDA_TOTALCOMPLEMENTONFICMSITEM write FPDA_TOTALCOMPLEMENTONFICMSITEM;
    const PDA_TOTALCOMPLEMENTONFICMSITEM_Name = 'PDA_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('PDA_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBCALCULOPISCOFINSITEM: Double read FPDA_TOTALBCALCULOPISCOFINSITEM write FPDA_TOTALBCALCULOPISCOFINSITEM;
    const PDA_TOTALBCALCULOPISCOFINSITEM_Name = 'PDA_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('PDA_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOLIQUIDO: Double read FPDA_TOTALPRECOLIQUIDO write FPDA_TOTALPRECOLIQUIDO;
    const PDA_TOTALPRECOLIQUIDO_Name = 'PDA_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPRECOVENDA', ftBCD)]
    [Dictionary('PDA_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOVENDA: Double read FPDA_TOTALPRECOVENDA write FPDA_TOTALPRECOVENDA;
    const PDA_TOTALPRECOVENDA_Name = 'PDA_TOTALPRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPRECOCUSTO', ftBCD)]
    [Dictionary('PDA_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOCUSTO: Double read FPDA_TOTALPRECOCUSTO write FPDA_TOTALPRECOCUSTO;
    const PDA_TOTALPRECOCUSTO_Name = 'PDA_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPRECOTABELA', ftBCD, 10, 2)]
    [Dictionary('PDA_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOTABELA: Double read FPDA_TOTALPRECOTABELA write FPDA_TOTALPRECOTABELA;
    const PDA_TOTALPRECOTABELA_Name = 'PDA_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPRECODIGITADO', ftBCD)]
    [Dictionary('PDA_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECODIGITADO: Double read FPDA_TOTALPRECODIGITADO write FPDA_TOTALPRECODIGITADO;
    const PDA_TOTALPRECODIGITADO_Name = 'PDA_TOTALPRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPRECOBASEDESCTO', ftBCD)]
    [Dictionary('PDA_TOTALPRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRECOBASEDESCTO: Double read FPDA_TOTALPRECOBASEDESCTO write FPDA_TOTALPRECOBASEDESCTO;
    const PDA_TOTALPRECOBASEDESCTO_Name = 'PDA_TOTALPRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('PDA_PESOBRUTOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PESOBRUTOITEM: Double read FPDA_PESOBRUTOITEM write FPDA_PESOBRUTOITEM;
    const PDA_PESOBRUTOITEM_Name = 'PDA_PESOBRUTOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PESOLIQUIDOITEM', ftBCD, 18, 4)]
    [Dictionary('PDA_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PESOLIQUIDOITEM: Double read FPDA_PESOLIQUIDOITEM write FPDA_PESOLIQUIDOITEM;
    const PDA_PESOLIQUIDOITEM_Name = 'PDA_PESOLIQUIDOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_ORDEMITEM', ftInteger)]
    [Dictionary('PDA_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ORDEMITEM: Integer read FPDA_ORDEMITEM write FPDA_ORDEMITEM;
    const PDA_ORDEMITEM_Name = 'PDA_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_ORDEMXMLITEM', ftInteger)]
    [Dictionary('PDA_ORDEMXMLITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ORDEMXMLITEM: Integer read FPDA_ORDEMXMLITEM write FPDA_ORDEMXMLITEM;
    const PDA_ORDEMXMLITEM_Name = 'PDA_ORDEMXMLITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTITEM: Double read FPDA_PERCENTUALIBPTITEM write FPDA_PERCENTUALIBPTITEM;
    const PDA_PERCENTUALIBPTITEM_Name = 'PDA_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALAPROXIMADOIMPOSTOITEM', ftBCD)]
    [Dictionary('PDA_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALAPROXIMADOIMPOSTOITEM: Double read FPDA_TOTALAPROXIMADOIMPOSTOITEM write FPDA_TOTALAPROXIMADOIMPOSTOITEM;
    const PDA_TOTALAPROXIMADOIMPOSTOITEM_Name = 'PDA_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTMUNICIPALITEM: Double read FPDA_PERCENTUALIBPTMUNICIPALITEM write FPDA_PERCENTUALIBPTMUNICIPALITEM;
    const PDA_PERCENTUALIBPTMUNICIPALITEM_Name = 'PDA_PERCENTUALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTESTADUALITEM: Double read FPDA_PERCENTUALIBPTESTADUALITEM write FPDA_PERCENTUALIBPTESTADUALITEM;
    const PDA_PERCENTUALIBPTESTADUALITEM_Name = 'PDA_PERCENTUALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTNACIONALITEM: Double read FPDA_PERCENTUALIBPTNACIONALITEM write FPDA_PERCENTUALIBPTNACIONALITEM;
    const PDA_PERCENTUALIBPTNACIONALITEM_Name = 'PDA_PERCENTUALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTIMPORTADOITEM: Double read FPDA_PERCENTUALIBPTIMPORTADOITEM write FPDA_PERCENTUALIBPTIMPORTADOITEM;
    const PDA_PERCENTUALIBPTIMPORTADOITEM_Name = 'PDA_PERCENTUALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('PDA_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTMUNICIPALITEM: Double read FPDA_TOTALIBPTMUNICIPALITEM write FPDA_TOTALIBPTMUNICIPALITEM;
    const PDA_TOTALIBPTMUNICIPALITEM_Name = 'PDA_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('PDA_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTESTADUALITEM: Double read FPDA_TOTALIBPTESTADUALITEM write FPDA_TOTALIBPTESTADUALITEM;
    const PDA_TOTALIBPTESTADUALITEM_Name = 'PDA_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('PDA_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTNACIONALITEM: Double read FPDA_TOTALIBPTNACIONALITEM write FPDA_TOTALIBPTNACIONALITEM;
    const PDA_TOTALIBPTNACIONALITEM_Name = 'PDA_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('PDA_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTIMPORTADOITEM: Double read FPDA_TOTALIBPTIMPORTADOITEM write FPDA_TOTALIBPTIMPORTADOITEM;
    const PDA_TOTALIBPTIMPORTADOITEM_Name = 'PDA_TOTALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALFCPITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFCPITEM: Double read FPDA_PERCENTUALFCPITEM write FPDA_PERCENTUALFCPITEM;
    const PDA_PERCENTUALFCPITEM_Name = 'PDA_PERCENTUALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOFCPITEM', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPITEM: Double read FPDA_TOTALBASECALCULOFCPITEM write FPDA_TOTALBASECALCULOFCPITEM;
    const PDA_TOTALBASECALCULOFCPITEM_Name = 'PDA_TOTALBASECALCULOFCPITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFCPITEM', ftBCD)]
    [Dictionary('PDA_TOTALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPITEM: Double read FPDA_TOTALFCPITEM write FPDA_TOTALFCPITEM;
    const PDA_TOTALFCPITEM_Name = 'PDA_TOTALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOFCPSTITEM', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPSTITEM: Double read FPDA_TOTALBASECALCULOFCPSTITEM write FPDA_TOTALBASECALCULOFCPSTITEM;
    const PDA_TOTALBASECALCULOFCPSTITEM_Name = 'PDA_TOTALBASECALCULOFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFCPSTITEM', ftBCD)]
    [Dictionary('PDA_TOTALFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPSTITEM: Double read FPDA_TOTALFCPSTITEM write FPDA_TOTALFCPSTITEM;
    const PDA_TOTALFCPSTITEM_Name = 'PDA_TOTALFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOFCPRETITEM', ftBCD)]
    [Dictionary('PDA_TOTALBASECALCULOFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPRETITEM: Double read FPDA_TOTALBASECALCULOFCPRETITEM write FPDA_TOTALBASECALCULOFCPRETITEM;
    const PDA_TOTALBASECALCULOFCPRETITEM_Name = 'PDA_TOTALBASECALCULOFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFCPRETITEM', ftBCD)]
    [Dictionary('PDA_TOTALFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPRETITEM: Double read FPDA_TOTALFCPRETITEM write FPDA_TOTALFCPRETITEM;
    const PDA_TOTALFCPRETITEM_Name = 'PDA_TOTALFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALREDUCAOBCSTITEM', ftBCD)]
    [Dictionary('PDA_TOTALREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALREDUCAOBCSTITEM: Double read FPDA_TOTALREDUCAOBCSTITEM write FPDA_TOTALREDUCAOBCSTITEM;
    const PDA_TOTALREDUCAOBCSTITEM_Name = 'PDA_TOTALREDUCAOBCSTITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_VALORREDUCAOBCSTITEM', ftBCD)]
    [Dictionary('PDA_VALORREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORREDUCAOBCSTITEM: Double read FPDA_VALORREDUCAOBCSTITEM write FPDA_VALORREDUCAOBCSTITEM;
    const PDA_VALORREDUCAOBCSTITEM_Name = 'PDA_VALORREDUCAOBCSTITEM';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALREDUCAOBCSTITEM', ftBCD)]
    [Dictionary('PDA_PERCENTUALREDUCAOBCSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALREDUCAOBCSTITEM: Double read FPDA_PERCENTUALREDUCAOBCSTITEM write FPDA_PERCENTUALREDUCAOBCSTITEM;
    const PDA_PERCENTUALREDUCAOBCSTITEM_Name = 'PDA_PERCENTUALREDUCAOBCSTITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATAALTERACAO: TDateTime read FPDA_DATAALTERACAO write FPDA_DATAALTERACAO;
    const PDA_DATAALTERACAO_Name = 'PDA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDA_01_ID_OLD', ftInteger)]
    [Dictionary('PDA_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_01_ID_OLD: Integer read FPDA_01_ID_OLD write FPDA_01_ID_OLD;
    const PDA_01_ID_OLD_Name = 'PDA_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID_OLD: Integer read FPDA_ID_OLD write FPDA_ID_OLD;
    const PDA_ID_OLD_Name = 'PDA_ID_OLD';

    [Association(OneToOne,'PDA_ID','PDA_00','PDA_ID')]
    property PDA_00: TPDA_00 read FPDA_00_0 write FPDA_00_0;

  end;

implementation

constructor TPDA_00_01.Create;
begin
  FPDA_00_0 := TPDA_00.Create;
end;

destructor TPDA_00_01.Destroy;
begin
  if Assigned(FPDA_00_0) then
    FPDA_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoPDA_00_01)

end.
