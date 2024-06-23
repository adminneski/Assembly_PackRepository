unit express.dbo.OMF_LIVROFISCAL_01_01;

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
  [Table('OMF_LivroFiscal_01_01', '')]
  TDtoOMF_LivroFiscal_01_01 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FOMF_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FGRD_CODIGO: String;
    FOMF_QTDFATURADA: Double;
    FOMF_QTDDEVOLVIDA: Double;
    FOMF_VALORITEMBRUTO: Double;
    FOMF_VALORITEM: Double;
    FOMF_VALORICMSITEM: Double;
    FOMF_VALORFRETENFITEM: Double;
    FOMF_VALORSEGUROITEM: Double;
    FOMF_VALORIPIITEM: Double;
    FOMF_VALORDESCTOITEM: Double;
    FOMF_VALORICMSRNFITEM: Double;
    FOMF_PERCENTUALICMSITEM: Double;
    FOMF_VALORBASEOUTROSITEM: Double;
    FOMF_VALORBASEISENTOICMSITEM: Double;
    FOMF_VALORBASECALCULOMVAITEM: Double;
    FOMF_VALORBASECALCULOICMSITEM: Double;
    FOMF_VALORDESPACESSORIAITEM: Double;
    FOMF_VALORPISITEM: Double;
    FOMF_VALORCOFINSITEM: Double;
    FOMF_PERCENTUALIPIITEM: Double;
    FOMF_PERCENTUALPISITEM: Double;
    FOMF_PERCENTUALMVAITEM: Double;
    FOMF_PERCENTUALCOFINSITEM: Double;
    FOMF_PERCENTUALICMSDESTINOITEM: Double;
    FOMF_PERCENTUALREDUCAOBCITEM: Double;
    FOMF_VALORBCALCULOPISCOFINSITEM: Double;
    FCSTPC_CODIGO: String;
    FOMF_TOTALITEMBRUTO: Double;
    FOMF_TOTALITEM: Double;
    FOMF_TOTALIPIITEM: Double;
    FOMF_TOTALPISITEM: Double;
    FOMF_TOTALICMSITEM: Double;
    FOMF_TOTALCOFINSITEM: Double;
    FOMF_TOTALSEGUROITEM: Double;
    FOMF_TOTALDESCTOITEM: Double;
    FOMF_TOTALICMSRNFITEM: Double;
    FOMF_TOTALFRETENFITEM: Double;
    FOMF_TOTALBASEOUTROSITEM: Double;
    FOMF_TOTALBASEISENTOICMSITEM: Double;
    FOMF_TOTALBASECALCULOMVAITEM: Double;
    FOMF_TOTALBASECALCULOICMSITEM: Double;
    FOMF_TOTALDESPACESSORIAITEM: Double;
    FOMF_TOTALBCALCULOPISCOFINSITEM: Double;
    FOMF_ORDEMITEM: Integer;
  public 
    { Public declarations } 
     const Table      = 'OMF_LivroFiscal_01_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_01_ID', ftInteger)]
    [Dictionary('OMF_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_01_ID: Integer read FOMF_01_ID write FOMF_01_ID;
    const OMF_01_ID_Name = 'OMF_01_ID';

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

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('OMF_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_QTDFATURADA: Double read FOMF_QTDFATURADA write FOMF_QTDFATURADA;
    const OMF_QTDFATURADA_Name = 'OMF_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('OMF_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('OMF_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_QTDDEVOLVIDA: Double read FOMF_QTDDEVOLVIDA write FOMF_QTDDEVOLVIDA;
    const OMF_QTDDEVOLVIDA_Name = 'OMF_QTDDEVOLVIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORITEMBRUTO', ftBCD)]
    [Dictionary('OMF_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORITEMBRUTO: Double read FOMF_VALORITEMBRUTO write FOMF_VALORITEMBRUTO;
    const OMF_VALORITEMBRUTO_Name = 'OMF_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORITEM', ftBCD)]
    [Dictionary('OMF_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORITEM: Double read FOMF_VALORITEM write FOMF_VALORITEM;
    const OMF_VALORITEM_Name = 'OMF_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORICMSITEM', ftBCD)]
    [Dictionary('OMF_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSITEM: Double read FOMF_VALORICMSITEM write FOMF_VALORICMSITEM;
    const OMF_VALORICMSITEM_Name = 'OMF_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORFRETENFITEM', ftBCD)]
    [Dictionary('OMF_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORFRETENFITEM: Double read FOMF_VALORFRETENFITEM write FOMF_VALORFRETENFITEM;
    const OMF_VALORFRETENFITEM_Name = 'OMF_VALORFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORSEGUROITEM', ftBCD)]
    [Dictionary('OMF_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORSEGUROITEM: Double read FOMF_VALORSEGUROITEM write FOMF_VALORSEGUROITEM;
    const OMF_VALORSEGUROITEM_Name = 'OMF_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORIPIITEM', ftBCD)]
    [Dictionary('OMF_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORIPIITEM: Double read FOMF_VALORIPIITEM write FOMF_VALORIPIITEM;
    const OMF_VALORIPIITEM_Name = 'OMF_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORDESCTOITEM', ftBCD, 48, 5)]
    [Dictionary('OMF_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORDESCTOITEM: Double read FOMF_VALORDESCTOITEM write FOMF_VALORDESCTOITEM;
    const OMF_VALORDESCTOITEM_Name = 'OMF_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('OMF_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSRNFITEM: Double read FOMF_VALORICMSRNFITEM write FOMF_VALORICMSRNFITEM;
    const OMF_VALORICMSRNFITEM_Name = 'OMF_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSITEM: Double read FOMF_PERCENTUALICMSITEM write FOMF_PERCENTUALICMSITEM;
    const OMF_PERCENTUALICMSITEM_Name = 'OMF_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('OMF_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASEOUTROSITEM: Double read FOMF_VALORBASEOUTROSITEM write FOMF_VALORBASEOUTROSITEM;
    const OMF_VALORBASEOUTROSITEM_Name = 'OMF_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('OMF_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASEISENTOICMSITEM: Double read FOMF_VALORBASEISENTOICMSITEM write FOMF_VALORBASEISENTOICMSITEM;
    const OMF_VALORBASEISENTOICMSITEM_Name = 'OMF_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('OMF_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASECALCULOMVAITEM: Double read FOMF_VALORBASECALCULOMVAITEM write FOMF_VALORBASECALCULOMVAITEM;
    const OMF_VALORBASECALCULOMVAITEM_Name = 'OMF_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('OMF_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASECALCULOICMSITEM: Double read FOMF_VALORBASECALCULOICMSITEM write FOMF_VALORBASECALCULOICMSITEM;
    const OMF_VALORBASECALCULOICMSITEM_Name = 'OMF_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('OMF_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORDESPACESSORIAITEM: Double read FOMF_VALORDESPACESSORIAITEM write FOMF_VALORDESPACESSORIAITEM;
    const OMF_VALORDESPACESSORIAITEM_Name = 'OMF_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORPISITEM', ftBCD)]
    [Dictionary('OMF_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORPISITEM: Double read FOMF_VALORPISITEM write FOMF_VALORPISITEM;
    const OMF_VALORPISITEM_Name = 'OMF_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCOFINSITEM', ftBCD)]
    [Dictionary('OMF_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCOFINSITEM: Double read FOMF_VALORCOFINSITEM write FOMF_VALORCOFINSITEM;
    const OMF_VALORCOFINSITEM_Name = 'OMF_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIPIITEM: Double read FOMF_PERCENTUALIPIITEM write FOMF_PERCENTUALIPIITEM;
    const OMF_PERCENTUALIPIITEM_Name = 'OMF_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALPISITEM: Double read FOMF_PERCENTUALPISITEM write FOMF_PERCENTUALPISITEM;
    const OMF_PERCENTUALPISITEM_Name = 'OMF_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALMVAITEM: Double read FOMF_PERCENTUALMVAITEM write FOMF_PERCENTUALMVAITEM;
    const OMF_PERCENTUALMVAITEM_Name = 'OMF_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALCOFINSITEM: Double read FOMF_PERCENTUALCOFINSITEM write FOMF_PERCENTUALCOFINSITEM;
    const OMF_PERCENTUALCOFINSITEM_Name = 'OMF_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSDESTINOITEM: Double read FOMF_PERCENTUALICMSDESTINOITEM write FOMF_PERCENTUALICMSDESTINOITEM;
    const OMF_PERCENTUALICMSDESTINOITEM_Name = 'OMF_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALREDUCAOBCITEM: Double read FOMF_PERCENTUALREDUCAOBCITEM write FOMF_PERCENTUALREDUCAOBCITEM;
    const OMF_PERCENTUALREDUCAOBCITEM_Name = 'OMF_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('OMF_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBCALCULOPISCOFINSITEM: Double read FOMF_VALORBCALCULOPISCOFINSITEM write FOMF_VALORBCALCULOPISCOFINSITEM;
    const OMF_VALORBCALCULOPISCOFINSITEM_Name = 'OMF_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALITEMBRUTO', ftBCD)]
    [Dictionary('OMF_TOTALITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALITEMBRUTO: Double read FOMF_TOTALITEMBRUTO write FOMF_TOTALITEMBRUTO;
    const OMF_TOTALITEMBRUTO_Name = 'OMF_TOTALITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALITEM', ftBCD)]
    [Dictionary('OMF_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALITEM: Double read FOMF_TOTALITEM write FOMF_TOTALITEM;
    const OMF_TOTALITEM_Name = 'OMF_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIPIITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIPIITEM: Double read FOMF_TOTALIPIITEM write FOMF_TOTALIPIITEM;
    const OMF_TOTALIPIITEM_Name = 'OMF_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALPISITEM', ftBCD)]
    [Dictionary('OMF_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPISITEM: Double read FOMF_TOTALPISITEM write FOMF_TOTALPISITEM;
    const OMF_TOTALPISITEM_Name = 'OMF_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSITEM', ftBCD)]
    [Dictionary('OMF_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSITEM: Double read FOMF_TOTALICMSITEM write FOMF_TOTALICMSITEM;
    const OMF_TOTALICMSITEM_Name = 'OMF_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('OMF_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOFINSITEM: Double read FOMF_TOTALCOFINSITEM write FOMF_TOTALCOFINSITEM;
    const OMF_TOTALCOFINSITEM_Name = 'OMF_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('OMF_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSEGUROITEM: Double read FOMF_TOTALSEGUROITEM write FOMF_TOTALSEGUROITEM;
    const OMF_TOTALSEGUROITEM_Name = 'OMF_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALDESCTOITEM', ftBCD, 10, 2)]
    [Dictionary('OMF_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESCTOITEM: Double read FOMF_TOTALDESCTOITEM write FOMF_TOTALDESCTOITEM;
    const OMF_TOTALDESCTOITEM_Name = 'OMF_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSRNFITEM', ftBCD)]
    [Dictionary('OMF_TOTALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSRNFITEM: Double read FOMF_TOTALICMSRNFITEM write FOMF_TOTALICMSRNFITEM;
    const OMF_TOTALICMSRNFITEM_Name = 'OMF_TOTALICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFRETENFITEM', ftBCD)]
    [Dictionary('OMF_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETENFITEM: Double read FOMF_TOTALFRETENFITEM write FOMF_TOTALFRETENFITEM;
    const OMF_TOTALFRETENFITEM_Name = 'OMF_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASEOUTROSITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASEOUTROSITEM: Double read FOMF_TOTALBASEOUTROSITEM write FOMF_TOTALBASEOUTROSITEM;
    const OMF_TOTALBASEOUTROSITEM_Name = 'OMF_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('OMF_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASEISENTOICMSITEM: Double read FOMF_TOTALBASEISENTOICMSITEM write FOMF_TOTALBASEISENTOICMSITEM;
    const OMF_TOTALBASEISENTOICMSITEM_Name = 'OMF_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('OMF_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOMVAITEM: Double read FOMF_TOTALBASECALCULOMVAITEM write FOMF_TOTALBASECALCULOMVAITEM;
    const OMF_TOTALBASECALCULOMVAITEM_Name = 'OMF_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOICMSITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOICMSITEM: Double read FOMF_TOTALBASECALCULOICMSITEM write FOMF_TOTALBASECALCULOICMSITEM;
    const OMF_TOTALBASECALCULOICMSITEM_Name = 'OMF_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALDESPACESSORIAITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESPACESSORIAITEM: Double read FOMF_TOTALDESPACESSORIAITEM write FOMF_TOTALDESPACESSORIAITEM;
    const OMF_TOTALDESPACESSORIAITEM_Name = 'OMF_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('OMF_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCALCULOPISCOFINSITEM: Double read FOMF_TOTALBCALCULOPISCOFINSITEM write FOMF_TOTALBCALCULOPISCOFINSITEM;
    const OMF_TOTALBCALCULOPISCOFINSITEM_Name = 'OMF_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_ORDEMITEM', ftInteger)]
    [Dictionary('OMF_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ORDEMITEM: Integer read FOMF_ORDEMITEM write FOMF_ORDEMITEM;
    const OMF_ORDEMITEM_Name = 'OMF_ORDEMITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_LivroFiscal_01_01)

end.
