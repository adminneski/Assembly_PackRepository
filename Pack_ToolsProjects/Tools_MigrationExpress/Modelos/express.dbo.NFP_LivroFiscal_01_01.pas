unit express.dbo.NFP_LIVROFISCAL_01_01;

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
  [Table('NFP_LivroFiscal_01_01', '')]
  TDtoNFP_LivroFiscal_01_01 = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FNFP_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FNFP_QTDENTRADA: Double;
    FNFP_VALORITEMBRUTO: Double;
    FNFP_VALORITEM: Double;
    FNFP_VALORICMSITEM: Double;
    FNFP_VALORIPIITEM: Double;
    FNFP_VALORDESCTOITEM: Double;
    FNFP_PERCENTUALICMSITEM: Double;
    FNFP_PERCENTUALIPIITEM: Double;
    FNFP_VALORBASEOUTROSITEM: Double;
    FNFP_VALORBASEISENTOICMSITEM: Double;
    FNFP_VALORBASECALCULOICMSITEM: Double;
    FNFP_VALORDESPACESSORIAITEM: Double;
    FNFP_PERCENTUALICMSDESTINOITEM: Double;
    FNFP_PERCENTUALREDUCAOBCITEM: Double;
    FNFP_VALORFRETENFITEM: Double;
    FNFP_VALORSEGUROITEM: Double;
    FNFP_VALORPISITEM: Double;
    FNFP_VALORCOFINSITEM: Double;
    FNFP_PERCENTUALPISITEM: Double;
    FNFP_PERCENTUALCOFINSITEM: Double;
    FNFP_VALORBCALCULOPISCOFINSITEM: Double;
    FCSTPC_CODIGO: String;
    FNFP_TOTALITEMBRUTO: Double;
    FNFP_TOTALITEM: Double;
    FNFP_TOTALIPIITEM: Double;
    FNFP_TOTALPISITEM: Double;
    FNFP_TOTALICMSITEM: Double;
    FNFP_TOTALCOFINSITEM: Double;
    FNFP_TOTALSEGUROITEM: Double;
    FNFP_TOTALDESCTOITEM: Double;
    FNFP_TOTALFRETENFITEM: Double;
    FNFP_TOTALBASEOUTROSITEM: Double;
    FNFP_TOTALBASEISENTOICMSITEM: Double;
    FNFP_TOTALBASECALCULOICMSITEM: Double;
    FNFP_TOTALDESPACESSORIAITEM: Double;
    FNFP_TOTALBCALCULOPISCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'NFP_LivroFiscal_01_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_01_ID', ftInteger)]
    [Dictionary('NFP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_01_ID: Integer read FNFP_01_ID write FNFP_01_ID;
    const NFP_01_ID_Name = 'NFP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_QTDENTRADA', ftBCD, 48, 3)]
    [Dictionary('NFP_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_QTDENTRADA: Double read FNFP_QTDENTRADA write FNFP_QTDENTRADA;
    const NFP_QTDENTRADA_Name = 'NFP_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORITEMBRUTO', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORITEMBRUTO: Double read FNFP_VALORITEMBRUTO write FNFP_VALORITEMBRUTO;
    const NFP_VALORITEMBRUTO_Name = 'NFP_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORITEM', ftBCD, 48, 4)]
    [Dictionary('NFP_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORITEM: Double read FNFP_VALORITEM write FNFP_VALORITEM;
    const NFP_VALORITEM_Name = 'NFP_VALORITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORICMSITEM: Double read FNFP_VALORICMSITEM write FNFP_VALORICMSITEM;
    const NFP_VALORICMSITEM_Name = 'NFP_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORIPIITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORIPIITEM: Double read FNFP_VALORIPIITEM write FNFP_VALORIPIITEM;
    const NFP_VALORIPIITEM_Name = 'NFP_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORDESCTOITEM: Double read FNFP_VALORDESCTOITEM write FNFP_VALORDESCTOITEM;
    const NFP_VALORDESCTOITEM_Name = 'NFP_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSITEM: Double read FNFP_PERCENTUALICMSITEM write FNFP_PERCENTUALICMSITEM;
    const NFP_PERCENTUALICMSITEM_Name = 'NFP_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALIPIITEM: Double read FNFP_PERCENTUALIPIITEM write FNFP_PERCENTUALIPIITEM;
    const NFP_PERCENTUALIPIITEM_Name = 'NFP_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORBASEOUTROSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASEOUTROSITEM: Double read FNFP_VALORBASEOUTROSITEM write FNFP_VALORBASEOUTROSITEM;
    const NFP_VALORBASEOUTROSITEM_Name = 'NFP_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORBASEISENTOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASEISENTOICMSITEM: Double read FNFP_VALORBASEISENTOICMSITEM write FNFP_VALORBASEISENTOICMSITEM;
    const NFP_VALORBASEISENTOICMSITEM_Name = 'NFP_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORBASECALCULOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASECALCULOICMSITEM: Double read FNFP_VALORBASECALCULOICMSITEM write FNFP_VALORBASECALCULOICMSITEM;
    const NFP_VALORBASECALCULOICMSITEM_Name = 'NFP_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORDESPACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORDESPACESSORIAITEM: Double read FNFP_VALORDESPACESSORIAITEM write FNFP_VALORDESPACESSORIAITEM;
    const NFP_VALORDESPACESSORIAITEM_Name = 'NFP_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSDESTINOITEM: Double read FNFP_PERCENTUALICMSDESTINOITEM write FNFP_PERCENTUALICMSDESTINOITEM;
    const NFP_PERCENTUALICMSDESTINOITEM_Name = 'NFP_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALREDUCAOBCITEM: Double read FNFP_PERCENTUALREDUCAOBCITEM write FNFP_PERCENTUALREDUCAOBCITEM;
    const NFP_PERCENTUALREDUCAOBCITEM_Name = 'NFP_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORFRETENFITEM: Double read FNFP_VALORFRETENFITEM write FNFP_VALORFRETENFITEM;
    const NFP_VALORFRETENFITEM_Name = 'NFP_VALORFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORSEGUROITEM: Double read FNFP_VALORSEGUROITEM write FNFP_VALORSEGUROITEM;
    const NFP_VALORSEGUROITEM_Name = 'NFP_VALORSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORPISITEM: Double read FNFP_VALORPISITEM write FNFP_VALORPISITEM;
    const NFP_VALORPISITEM_Name = 'NFP_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCOFINSITEM: Double read FNFP_VALORCOFINSITEM write FNFP_VALORCOFINSITEM;
    const NFP_VALORCOFINSITEM_Name = 'NFP_VALORCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALPISITEM: Double read FNFP_PERCENTUALPISITEM write FNFP_PERCENTUALPISITEM;
    const NFP_PERCENTUALPISITEM_Name = 'NFP_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('NFP_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALCOFINSITEM: Double read FNFP_PERCENTUALCOFINSITEM write FNFP_PERCENTUALCOFINSITEM;
    const NFP_PERCENTUALCOFINSITEM_Name = 'NFP_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBCALCULOPISCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBCALCULOPISCOFINSITEM: Double read FNFP_VALORBCALCULOPISCOFINSITEM write FNFP_VALORBCALCULOPISCOFINSITEM;
    const NFP_VALORBCALCULOPISCOFINSITEM_Name = 'NFP_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALITEMBRUTO', ftBCD)]
    [Dictionary('NFP_TOTALITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALITEMBRUTO: Double read FNFP_TOTALITEMBRUTO write FNFP_TOTALITEMBRUTO;
    const NFP_TOTALITEMBRUTO_Name = 'NFP_TOTALITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALITEM', ftBCD)]
    [Dictionary('NFP_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALITEM: Double read FNFP_TOTALITEM write FNFP_TOTALITEM;
    const NFP_TOTALITEM_Name = 'NFP_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALIPIITEM', ftBCD)]
    [Dictionary('NFP_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALIPIITEM: Double read FNFP_TOTALIPIITEM write FNFP_TOTALIPIITEM;
    const NFP_TOTALIPIITEM_Name = 'NFP_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALPISITEM', ftBCD)]
    [Dictionary('NFP_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPISITEM: Double read FNFP_TOTALPISITEM write FNFP_TOTALPISITEM;
    const NFP_TOTALPISITEM_Name = 'NFP_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALICMSITEM', ftBCD)]
    [Dictionary('NFP_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSITEM: Double read FNFP_TOTALICMSITEM write FNFP_TOTALICMSITEM;
    const NFP_TOTALICMSITEM_Name = 'NFP_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('NFP_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALCOFINSITEM: Double read FNFP_TOTALCOFINSITEM write FNFP_TOTALCOFINSITEM;
    const NFP_TOTALCOFINSITEM_Name = 'NFP_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('NFP_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALSEGUROITEM: Double read FNFP_TOTALSEGUROITEM write FNFP_TOTALSEGUROITEM;
    const NFP_TOTALSEGUROITEM_Name = 'NFP_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('NFP_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESCTOITEM: Double read FNFP_TOTALDESCTOITEM write FNFP_TOTALDESCTOITEM;
    const NFP_TOTALDESCTOITEM_Name = 'NFP_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALFRETENFITEM', ftBCD)]
    [Dictionary('NFP_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETENFITEM: Double read FNFP_TOTALFRETENFITEM write FNFP_TOTALFRETENFITEM;
    const NFP_TOTALFRETENFITEM_Name = 'NFP_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('NFP_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASEOUTROSITEM: Double read FNFP_TOTALBASEOUTROSITEM write FNFP_TOTALBASEOUTROSITEM;
    const NFP_TOTALBASEOUTROSITEM_Name = 'NFP_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('NFP_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASEISENTOICMSITEM: Double read FNFP_TOTALBASEISENTOICMSITEM write FNFP_TOTALBASEISENTOICMSITEM;
    const NFP_TOTALBASEISENTOICMSITEM_Name = 'NFP_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASECALCULOICMSITEM', ftBCD, 48, 2)]
    [Dictionary('NFP_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASECALCULOICMSITEM: Double read FNFP_TOTALBASECALCULOICMSITEM write FNFP_TOTALBASECALCULOICMSITEM;
    const NFP_TOTALBASECALCULOICMSITEM_Name = 'NFP_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALDESPACESSORIAITEM', ftBCD, 48, 2)]
    [Dictionary('NFP_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESPACESSORIAITEM: Double read FNFP_TOTALDESPACESSORIAITEM write FNFP_TOTALDESPACESSORIAITEM;
    const NFP_TOTALDESPACESSORIAITEM_Name = 'NFP_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFP_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBCALCULOPISCOFINSITEM: Double read FNFP_TOTALBCALCULOPISCOFINSITEM write FNFP_TOTALBCALCULOPISCOFINSITEM;
    const NFP_TOTALBCALCULOPISCOFINSITEM_Name = 'NFP_TOTALBCALCULOPISCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_LivroFiscal_01_01)

end.
