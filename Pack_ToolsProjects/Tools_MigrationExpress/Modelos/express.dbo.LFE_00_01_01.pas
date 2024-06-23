unit express.dbo.LFE_00_01_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfe_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFE_00_01_01', '')]
  [PrimaryKey('LFE_01_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFE_01_01_ID')]
  TDtoLFE_00_01_01 = class
  private
    { Private declarations } 
    FLFE_01_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_01_ID: Integer;
    FLFE_ID: Integer;
    FPRO_CODIGO: Integer;
    FLFE_CSOSN: String;
    FCTB_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FCST_CODIGOIPI: String;
    FCSTPC_CODIGO: String;
    FLFE_ORDEMITEM: Integer;
    FLFE_QTDENTRADA: Double;
    FLFE_VALORITEM: Double;
    FLFE_VALORITEMBRUTO: Double;
    FLFE_VALORIPIITEM: Double;
    FLFE_VALORPISITEM: Double;
    FLFE_VALORICMSITEM: Double;
    FLFE_VALORCOFINSITEM: Double;
    FLFE_VALORSEGUROITEM: Double;
    FLFE_VALORDESCTOITEM: Double;
    FLFE_VALORICMSRNFITEM: Double;
    FLFE_VALORFRETENFITEM: Double;
    FLFE_VALORBASEOUTROSITEM: Double;
    FLFE_VALORBASEISENTOICMSITEM: Double;
    FLFE_VALORDESPACESSORIAITEM: Double;
    FLFE_VALORBASECALCULOMVAITEM: Double;
    FLFE_VALORBASECALCULOICMSITEM: Double;
    FLFE_VALORBCALCULOPISCOFINSITEM: Double;
    FLFE_PERCENTUALIPIITEM: Double;
    FLFE_PERCENTUALPISITEM: Double;
    FLFE_PERCENTUALMVAITEM: Double;
    FLFE_PERCENTUALICMSITEM: Double;
    FLFE_PERCENTUALCOFINSITEM: Double;
    FLFE_PERCENTUALICMSDESTINOITEM: Double;
    FLFE_PERCENTUALREDUCAOBCITEM: Double;
    FLFE_TOTALITEM: Double;
    FLFE_TOTALITEMBRUTO: Double;
    FLFE_TOTALIPIITEM: Double;
    FLFE_TOTALPISITEM: Double;
    FLFE_TOTALICMSITEM: Double;
    FLFE_TOTALCOFINSITEM: Double;
    FLFE_TOTALSEGUROITEM: Double;
    FLFE_TOTALDESCTOITEM: Double;
    FLFE_TOTALICMSRNFITEM: Double;
    FLFE_TOTALFRETENFITEM: Double;
    FLFE_TOTALBASEOUTROSITEM: Double;
    FLFE_TOTALBASEISENTOICMSITEM: Double;
    FLFE_TOTALBASECALCULOMVAITEM: Double;
    FLFE_TOTALBASECALCULOICMSITEM: Double;
    FLFE_TOTALDESPACESSORIAITEM: Double;
    FLFE_TOTALBCALCULOPISCOFINSITEM: Double;
    FLFE_DATAALTERACAO: TDateTime;
    FLFE_ID_OLD: Integer;
    FLFE_01_ID_OLD: Integer;
    FLFE_01_01_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFE_00_01_01';
    const PrimaryKey = 'LFE_01_01_ID';
    const Sequence   = 'SEQ_LFE_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_01_01_ID', ftInteger)]
    [Dictionary('LFE_01_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_01_01_ID: Integer read FLFE_01_01_ID write FLFE_01_01_ID;
    const LFE_01_01_ID_Name = 'LFE_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_01_ID', ftInteger)]
    [Dictionary('LFE_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_01_ID: Integer read FLFE_01_ID write FLFE_01_ID;
    const LFE_01_ID_Name = 'LFE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [ForeignKey('LFE_00_01_01_fk', 'LFE_ID', 'LFE_00', 'LFE_ID', SetNull, SetNull)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_CSOSN', ftString, 3)]
    [Dictionary('LFE_CSOSN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_CSOSN: String read FLFE_CSOSN write FLFE_CSOSN;
    const LFE_CSOSN_Name = 'LFE_CSOSN';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOIPI', ftString, 2)]
    [Dictionary('CST_CODIGOIPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOIPI: String read FCST_CODIGOIPI write FCST_CODIGOIPI;
    const CST_CODIGOIPI_Name = 'CST_CODIGOIPI';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ORDEMITEM', ftInteger)]
    [Dictionary('LFE_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ORDEMITEM: Integer read FLFE_ORDEMITEM write FLFE_ORDEMITEM;
    const LFE_ORDEMITEM_Name = 'LFE_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('LFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_QTDENTRADA: Double read FLFE_QTDENTRADA write FLFE_QTDENTRADA;
    const LFE_QTDENTRADA_Name = 'LFE_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEM: Double read FLFE_VALORITEM write FLFE_VALORITEM;
    const LFE_VALORITEM_Name = 'LFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORITEMBRUTO', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEMBRUTO: Double read FLFE_VALORITEMBRUTO write FLFE_VALORITEMBRUTO;
    const LFE_VALORITEMBRUTO_Name = 'LFE_VALORITEMBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORIPIITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORIPIITEM: Double read FLFE_VALORIPIITEM write FLFE_VALORIPIITEM;
    const LFE_VALORIPIITEM_Name = 'LFE_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORPISITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORPISITEM: Double read FLFE_VALORPISITEM write FLFE_VALORPISITEM;
    const LFE_VALORPISITEM_Name = 'LFE_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORICMSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSITEM: Double read FLFE_VALORICMSITEM write FLFE_VALORICMSITEM;
    const LFE_VALORICMSITEM_Name = 'LFE_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORCOFINSITEM: Double read FLFE_VALORCOFINSITEM write FLFE_VALORCOFINSITEM;
    const LFE_VALORCOFINSITEM_Name = 'LFE_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORSEGUROITEM: Double read FLFE_VALORSEGUROITEM write FLFE_VALORSEGUROITEM;
    const LFE_VALORSEGUROITEM_Name = 'LFE_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORDESCTOITEM: Double read FLFE_VALORDESCTOITEM write FLFE_VALORDESCTOITEM;
    const LFE_VALORDESCTOITEM_Name = 'LFE_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORICMSRNFITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSRNFITEM: Double read FLFE_VALORICMSRNFITEM write FLFE_VALORICMSRNFITEM;
    const LFE_VALORICMSRNFITEM_Name = 'LFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORFRETENFITEM: Double read FLFE_VALORFRETENFITEM write FLFE_VALORFRETENFITEM;
    const LFE_VALORFRETENFITEM_Name = 'LFE_VALORFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASEOUTROSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEOUTROSITEM: Double read FLFE_VALORBASEOUTROSITEM write FLFE_VALORBASEOUTROSITEM;
    const LFE_VALORBASEOUTROSITEM_Name = 'LFE_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASEISENTOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEISENTOICMSITEM: Double read FLFE_VALORBASEISENTOICMSITEM write FLFE_VALORBASEISENTOICMSITEM;
    const LFE_VALORBASEISENTOICMSITEM_Name = 'LFE_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORDESPACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORDESPACESSORIAITEM: Double read FLFE_VALORDESPACESSORIAITEM write FLFE_VALORDESPACESSORIAITEM;
    const LFE_VALORDESPACESSORIAITEM_Name = 'LFE_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASECALCULOMVAITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOMVAITEM: Double read FLFE_VALORBASECALCULOMVAITEM write FLFE_VALORBASECALCULOMVAITEM;
    const LFE_VALORBASECALCULOMVAITEM_Name = 'LFE_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASECALCULOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOICMSITEM: Double read FLFE_VALORBASECALCULOICMSITEM write FLFE_VALORBASECALCULOICMSITEM;
    const LFE_VALORBASECALCULOICMSITEM_Name = 'LFE_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBCALCULOPISCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBCALCULOPISCOFINSITEM: Double read FLFE_VALORBCALCULOPISCOFINSITEM write FLFE_VALORBCALCULOPISCOFINSITEM;
    const LFE_VALORBCALCULOPISCOFINSITEM_Name = 'LFE_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALIPIITEM: Double read FLFE_PERCENTUALIPIITEM write FLFE_PERCENTUALIPIITEM;
    const LFE_PERCENTUALIPIITEM_Name = 'LFE_PERCENTUALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALPISITEM: Double read FLFE_PERCENTUALPISITEM write FLFE_PERCENTUALPISITEM;
    const LFE_PERCENTUALPISITEM_Name = 'LFE_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALMVAITEM: Double read FLFE_PERCENTUALMVAITEM write FLFE_PERCENTUALMVAITEM;
    const LFE_PERCENTUALMVAITEM_Name = 'LFE_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMSITEM: Double read FLFE_PERCENTUALICMSITEM write FLFE_PERCENTUALICMSITEM;
    const LFE_PERCENTUALICMSITEM_Name = 'LFE_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALCOFINSITEM: Double read FLFE_PERCENTUALCOFINSITEM write FLFE_PERCENTUALCOFINSITEM;
    const LFE_PERCENTUALCOFINSITEM_Name = 'LFE_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMSDESTINOITEM: Double read FLFE_PERCENTUALICMSDESTINOITEM write FLFE_PERCENTUALICMSDESTINOITEM;
    const LFE_PERCENTUALICMSDESTINOITEM_Name = 'LFE_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALREDUCAOBCITEM: Double read FLFE_PERCENTUALREDUCAOBCITEM write FLFE_PERCENTUALREDUCAOBCITEM;
    const LFE_PERCENTUALREDUCAOBCITEM_Name = 'LFE_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALITEM', ftBCD)]
    [Dictionary('LFE_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALITEM: Double read FLFE_TOTALITEM write FLFE_TOTALITEM;
    const LFE_TOTALITEM_Name = 'LFE_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALITEMBRUTO', ftBCD)]
    [Dictionary('LFE_TOTALITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALITEMBRUTO: Double read FLFE_TOTALITEMBRUTO write FLFE_TOTALITEMBRUTO;
    const LFE_TOTALITEMBRUTO_Name = 'LFE_TOTALITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALIPIITEM', ftBCD)]
    [Dictionary('LFE_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALIPIITEM: Double read FLFE_TOTALIPIITEM write FLFE_TOTALIPIITEM;
    const LFE_TOTALIPIITEM_Name = 'LFE_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPISITEM', ftBCD)]
    [Dictionary('LFE_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPISITEM: Double read FLFE_TOTALPISITEM write FLFE_TOTALPISITEM;
    const LFE_TOTALPISITEM_Name = 'LFE_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALICMSITEM', ftBCD)]
    [Dictionary('LFE_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALICMSITEM: Double read FLFE_TOTALICMSITEM write FLFE_TOTALICMSITEM;
    const LFE_TOTALICMSITEM_Name = 'LFE_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('LFE_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALCOFINSITEM: Double read FLFE_TOTALCOFINSITEM write FLFE_TOTALCOFINSITEM;
    const LFE_TOTALCOFINSITEM_Name = 'LFE_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('LFE_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALSEGUROITEM: Double read FLFE_TOTALSEGUROITEM write FLFE_TOTALSEGUROITEM;
    const LFE_TOTALSEGUROITEM_Name = 'LFE_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('LFE_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESCTOITEM: Double read FLFE_TOTALDESCTOITEM write FLFE_TOTALDESCTOITEM;
    const LFE_TOTALDESCTOITEM_Name = 'LFE_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALICMSRNFITEM', ftBCD)]
    [Dictionary('LFE_TOTALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALICMSRNFITEM: Double read FLFE_TOTALICMSRNFITEM write FLFE_TOTALICMSRNFITEM;
    const LFE_TOTALICMSRNFITEM_Name = 'LFE_TOTALICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALFRETENFITEM', ftBCD)]
    [Dictionary('LFE_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALFRETENFITEM: Double read FLFE_TOTALFRETENFITEM write FLFE_TOTALFRETENFITEM;
    const LFE_TOTALFRETENFITEM_Name = 'LFE_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('LFE_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASEOUTROSITEM: Double read FLFE_TOTALBASEOUTROSITEM write FLFE_TOTALBASEOUTROSITEM;
    const LFE_TOTALBASEOUTROSITEM_Name = 'LFE_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('LFE_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASEISENTOICMSITEM: Double read FLFE_TOTALBASEISENTOICMSITEM write FLFE_TOTALBASEISENTOICMSITEM;
    const LFE_TOTALBASEISENTOICMSITEM_Name = 'LFE_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('LFE_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASECALCULOMVAITEM: Double read FLFE_TOTALBASECALCULOMVAITEM write FLFE_TOTALBASECALCULOMVAITEM;
    const LFE_TOTALBASECALCULOMVAITEM_Name = 'LFE_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFE_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASECALCULOICMSITEM: Double read FLFE_TOTALBASECALCULOICMSITEM write FLFE_TOTALBASECALCULOICMSITEM;
    const LFE_TOTALBASECALCULOICMSITEM_Name = 'LFE_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('LFE_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESPACESSORIAITEM: Double read FLFE_TOTALDESPACESSORIAITEM write FLFE_TOTALDESPACESSORIAITEM;
    const LFE_TOTALDESPACESSORIAITEM_Name = 'LFE_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('LFE_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBCALCULOPISCOFINSITEM: Double read FLFE_TOTALBCALCULOPISCOFINSITEM write FLFE_TOTALBCALCULOPISCOFINSITEM;
    const LFE_TOTALBCALCULOPISCOFINSITEM_Name = 'LFE_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAALTERACAO: TDateTime read FLFE_DATAALTERACAO write FLFE_DATAALTERACAO;
    const LFE_DATAALTERACAO_Name = 'LFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_ID_OLD', ftInteger)]
    [Dictionary('LFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID_OLD: Integer read FLFE_ID_OLD write FLFE_ID_OLD;
    const LFE_ID_OLD_Name = 'LFE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFE_01_ID_OLD', ftInteger)]
    [Dictionary('LFE_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_01_ID_OLD: Integer read FLFE_01_ID_OLD write FLFE_01_ID_OLD;
    const LFE_01_ID_OLD_Name = 'LFE_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFE_01_01_ID_OLD', ftInteger)]
    [Dictionary('LFE_01_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_01_01_ID_OLD: Integer read FLFE_01_01_ID_OLD write FLFE_01_01_ID_OLD;
    const LFE_01_01_ID_OLD_Name = 'LFE_01_01_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFE_00_01_01)

end.
