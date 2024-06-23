unit express.dbo.NFE_LIVROFISCAL_01_01;

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
  [Table('NFE_LivroFiscal_01_01', '')]
  TDtoNFE_LivroFiscal_01_01 = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FNFE_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FNFE_QTDENTRADA: Double;
    FNFE_VALORITEMBRUTO: Double;
    FNFE_VALORITEM: Double;
    FNFE_VALORICMSITEM: Double;
    FNFE_VALORFRETENFITEM: Double;
    FNFE_VALORSEGUROITEM: Double;
    FNFE_VALORIPIITEM: Double;
    FNFE_VALORDESCTOITEM: Double;
    FNFE_VALORICMSRNFITEM: Double;
    FNFE_PERCENTUALICMSITEM: Double;
    FNFE_VALORBASEOUTROSITEM: Double;
    FNFE_VALORBASEISENTOICMSITEM: Double;
    FNFE_VALORBASECALCULOMVAITEM: Double;
    FNFE_VALORBASECALCULOICMSITEM: Double;
    FNFE_VALORDESPACESSORIAITEM: Double;
    FNFE_VALORPISITEM: Double;
    FNFE_VALORCOFINSITEM: Double;
    FNFE_PERCENTUALIPIITEM: Double;
    FNFE_PERCENTUALPISITEM: Double;
    FNFE_PERCENTUALMVAITEM: Double;
    FNFE_PERCENTUALCOFINSITEM: Double;
    FNFE_PERCENTUALICMSDESTINOITEM: Double;
    FNFE_PERCENTUALREDUCAOBCITEM: Double;
    FNFE_VALORBCALCULOPISCOFINSITEM: Double;
    FCSTPC_CODIGO: String;
    FNFE_TOTALITEMBRUTO: Double;
    FNFE_TOTALITEM: Double;
    FNFE_TOTALIPIITEM: Double;
    FNFE_TOTALPISITEM: Double;
    FNFE_TOTALICMSITEM: Double;
    FNFE_TOTALCOFINSITEM: Double;
    FNFE_TOTALSEGUROITEM: Double;
    FNFE_TOTALDESCTOITEM: Double;
    FNFE_TOTALICMSRNFITEM: Double;
    FNFE_TOTALFRETENFITEM: Double;
    FNFE_TOTALBASEOUTROSITEM: Double;
    FNFE_TOTALBASEISENTOICMSITEM: Double;
    FNFE_TOTALBASECALCULOMVAITEM: Double;
    FNFE_TOTALBASECALCULOICMSITEM: Double;
    FNFE_TOTALDESPACESSORIAITEM: Double;
    FNFE_TOTALBCALCULOPISCOFINSITEM: Double;
    FNFE_ORDEMITEM: Integer;
  public 
    { Public declarations } 
     const Table      = 'NFE_LivroFiscal_01_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_01_ID', ftInteger)]
    [Dictionary('NFE_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_01_ID: Integer read FNFE_01_ID write FNFE_01_ID;
    const NFE_01_ID_Name = 'NFE_01_ID';

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
    [Column('NFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('NFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_QTDENTRADA: Double read FNFE_QTDENTRADA write FNFE_QTDENTRADA;
    const NFE_QTDENTRADA_Name = 'NFE_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORITEMBRUTO', ftBCD)]
    [Dictionary('NFE_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEMBRUTO: Double read FNFE_VALORITEMBRUTO write FNFE_VALORITEMBRUTO;
    const NFE_VALORITEMBRUTO_Name = 'NFE_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORITEM', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEM: Double read FNFE_VALORITEM write FNFE_VALORITEM;
    const NFE_VALORITEM_Name = 'NFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORICMSITEM', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSITEM: Double read FNFE_VALORICMSITEM write FNFE_VALORICMSITEM;
    const NFE_VALORICMSITEM_Name = 'NFE_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORFRETENFITEM', ftBCD)]
    [Dictionary('NFE_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORFRETENFITEM: Double read FNFE_VALORFRETENFITEM write FNFE_VALORFRETENFITEM;
    const NFE_VALORFRETENFITEM_Name = 'NFE_VALORFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORSEGUROITEM', ftBCD)]
    [Dictionary('NFE_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORSEGUROITEM: Double read FNFE_VALORSEGUROITEM write FNFE_VALORSEGUROITEM;
    const NFE_VALORSEGUROITEM_Name = 'NFE_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORIPIITEM', ftBCD)]
    [Dictionary('NFE_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORIPIITEM: Double read FNFE_VALORIPIITEM write FNFE_VALORIPIITEM;
    const NFE_VALORIPIITEM_Name = 'NFE_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORDESCTOITEM', ftBCD)]
    [Dictionary('NFE_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORDESCTOITEM: Double read FNFE_VALORDESCTOITEM write FNFE_VALORDESCTOITEM;
    const NFE_VALORDESCTOITEM_Name = 'NFE_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('NFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSRNFITEM: Double read FNFE_VALORICMSRNFITEM write FNFE_VALORICMSRNFITEM;
    const NFE_VALORICMSRNFITEM_Name = 'NFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSITEM: Double read FNFE_PERCENTUALICMSITEM write FNFE_PERCENTUALICMSITEM;
    const NFE_PERCENTUALICMSITEM_Name = 'NFE_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBASEOUTROSITEM', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASEOUTROSITEM: Double read FNFE_VALORBASEOUTROSITEM write FNFE_VALORBASEOUTROSITEM;
    const NFE_VALORBASEOUTROSITEM_Name = 'NFE_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('NFE_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASEISENTOICMSITEM: Double read FNFE_VALORBASEISENTOICMSITEM write FNFE_VALORBASEISENTOICMSITEM;
    const NFE_VALORBASEISENTOICMSITEM_Name = 'NFE_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('NFE_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASECALCULOMVAITEM: Double read FNFE_VALORBASECALCULOMVAITEM write FNFE_VALORBASECALCULOMVAITEM;
    const NFE_VALORBASECALCULOMVAITEM_Name = 'NFE_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('NFE_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASECALCULOICMSITEM: Double read FNFE_VALORBASECALCULOICMSITEM write FNFE_VALORBASECALCULOICMSITEM;
    const NFE_VALORBASECALCULOICMSITEM_Name = 'NFE_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NFE_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORDESPACESSORIAITEM: Double read FNFE_VALORDESPACESSORIAITEM write FNFE_VALORDESPACESSORIAITEM;
    const NFE_VALORDESPACESSORIAITEM_Name = 'NFE_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORPISITEM', ftBCD)]
    [Dictionary('NFE_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORPISITEM: Double read FNFE_VALORPISITEM write FNFE_VALORPISITEM;
    const NFE_VALORPISITEM_Name = 'NFE_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCOFINSITEM', ftBCD)]
    [Dictionary('NFE_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCOFINSITEM: Double read FNFE_VALORCOFINSITEM write FNFE_VALORCOFINSITEM;
    const NFE_VALORCOFINSITEM_Name = 'NFE_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALIPIITEM: Double read FNFE_PERCENTUALIPIITEM write FNFE_PERCENTUALIPIITEM;
    const NFE_PERCENTUALIPIITEM_Name = 'NFE_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALPISITEM: Double read FNFE_PERCENTUALPISITEM write FNFE_PERCENTUALPISITEM;
    const NFE_PERCENTUALPISITEM_Name = 'NFE_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALMVAITEM: Double read FNFE_PERCENTUALMVAITEM write FNFE_PERCENTUALMVAITEM;
    const NFE_PERCENTUALMVAITEM_Name = 'NFE_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALCOFINSITEM: Double read FNFE_PERCENTUALCOFINSITEM write FNFE_PERCENTUALCOFINSITEM;
    const NFE_PERCENTUALCOFINSITEM_Name = 'NFE_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSDESTINOITEM: Double read FNFE_PERCENTUALICMSDESTINOITEM write FNFE_PERCENTUALICMSDESTINOITEM;
    const NFE_PERCENTUALICMSDESTINOITEM_Name = 'NFE_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALREDUCAOBCITEM: Double read FNFE_PERCENTUALREDUCAOBCITEM write FNFE_PERCENTUALREDUCAOBCITEM;
    const NFE_PERCENTUALREDUCAOBCITEM_Name = 'NFE_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFE_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBCALCULOPISCOFINSITEM: Double read FNFE_VALORBCALCULOPISCOFINSITEM write FNFE_VALORBCALCULOPISCOFINSITEM;
    const NFE_VALORBCALCULOPISCOFINSITEM_Name = 'NFE_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALITEMBRUTO', ftBCD)]
    [Dictionary('NFE_TOTALITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALITEMBRUTO: Double read FNFE_TOTALITEMBRUTO write FNFE_TOTALITEMBRUTO;
    const NFE_TOTALITEMBRUTO_Name = 'NFE_TOTALITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALITEM', ftBCD)]
    [Dictionary('NFE_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALITEM: Double read FNFE_TOTALITEM write FNFE_TOTALITEM;
    const NFE_TOTALITEM_Name = 'NFE_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALIPIITEM', ftBCD)]
    [Dictionary('NFE_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALIPIITEM: Double read FNFE_TOTALIPIITEM write FNFE_TOTALIPIITEM;
    const NFE_TOTALIPIITEM_Name = 'NFE_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALPISITEM', ftBCD, 66260064, 2)]
    [Dictionary('NFE_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALPISITEM: Double read FNFE_TOTALPISITEM write FNFE_TOTALPISITEM;
    const NFE_TOTALPISITEM_Name = 'NFE_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSITEM', ftBCD)]
    [Dictionary('NFE_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSITEM: Double read FNFE_TOTALICMSITEM write FNFE_TOTALICMSITEM;
    const NFE_TOTALICMSITEM_Name = 'NFE_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALCOFINSITEM', ftBCD, 10, 2)]
    [Dictionary('NFE_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALCOFINSITEM: Double read FNFE_TOTALCOFINSITEM write FNFE_TOTALCOFINSITEM;
    const NFE_TOTALCOFINSITEM_Name = 'NFE_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('NFE_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALSEGUROITEM: Double read FNFE_TOTALSEGUROITEM write FNFE_TOTALSEGUROITEM;
    const NFE_TOTALSEGUROITEM_Name = 'NFE_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('NFE_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALDESCTOITEM: Double read FNFE_TOTALDESCTOITEM write FNFE_TOTALDESCTOITEM;
    const NFE_TOTALDESCTOITEM_Name = 'NFE_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSRNFITEM', ftBCD)]
    [Dictionary('NFE_TOTALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSRNFITEM: Double read FNFE_TOTALICMSRNFITEM write FNFE_TOTALICMSRNFITEM;
    const NFE_TOTALICMSRNFITEM_Name = 'NFE_TOTALICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALFRETENFITEM', ftBCD)]
    [Dictionary('NFE_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETENFITEM: Double read FNFE_TOTALFRETENFITEM write FNFE_TOTALFRETENFITEM;
    const NFE_TOTALFRETENFITEM_Name = 'NFE_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('NFE_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASEOUTROSITEM: Double read FNFE_TOTALBASEOUTROSITEM write FNFE_TOTALBASEOUTROSITEM;
    const NFE_TOTALBASEOUTROSITEM_Name = 'NFE_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('NFE_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASEISENTOICMSITEM: Double read FNFE_TOTALBASEISENTOICMSITEM write FNFE_TOTALBASEISENTOICMSITEM;
    const NFE_TOTALBASEISENTOICMSITEM_Name = 'NFE_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('NFE_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASECALCULOMVAITEM: Double read FNFE_TOTALBASECALCULOMVAITEM write FNFE_TOTALBASECALCULOMVAITEM;
    const NFE_TOTALBASECALCULOMVAITEM_Name = 'NFE_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('NFE_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASECALCULOICMSITEM: Double read FNFE_TOTALBASECALCULOICMSITEM write FNFE_TOTALBASECALCULOICMSITEM;
    const NFE_TOTALBASECALCULOICMSITEM_Name = 'NFE_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NFE_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALDESPACESSORIAITEM: Double read FNFE_TOTALDESPACESSORIAITEM write FNFE_TOTALDESPACESSORIAITEM;
    const NFE_TOTALDESPACESSORIAITEM_Name = 'NFE_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFE_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCALCULOPISCOFINSITEM: Double read FNFE_TOTALBCALCULOPISCOFINSITEM write FNFE_TOTALBCALCULOPISCOFINSITEM;
    const NFE_TOTALBCALCULOPISCOFINSITEM_Name = 'NFE_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_ORDEMITEM', ftInteger)]
    [Dictionary('NFE_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ORDEMITEM: Integer read FNFE_ORDEMITEM write FNFE_ORDEMITEM;
    const NFE_ORDEMITEM_Name = 'NFE_ORDEMITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_LivroFiscal_01_01)

end.
