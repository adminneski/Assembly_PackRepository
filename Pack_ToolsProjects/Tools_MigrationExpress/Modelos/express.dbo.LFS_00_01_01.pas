unit express.dbo.LFS_00_01_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfs_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFS_00_01_01', '')]
  [PrimaryKey('LFS_01_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_01_01_ID')]
  TDtoLFS_00_01_01 = class
  private
    { Private declarations } 
    FLFS_01_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_01_ID: Integer;
    FLFS_ID: Integer;
    FLFS_CSOSN: String;
    FPRO_CODIGO: Integer;
    FCST_CODIGO: String;
    FLEF_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FGRD_CODIGO: String;
    FCTB_CODIGO: Integer;
    FCSTPC_CODIGO: String;
    FCST_CODIGOIPI: String;
    FLFS_ORDEMITEM: Integer;
    FLFS_QTDSAIDA: Double;
    FLFS_VALORITEM: Double;
    FLFS_VALORITEMBRUTO: Double;
    FLFS_VALORIPIITEM: Double;
    FLFS_VALORPISITEM: Double;
    FLFS_VALORICMSITEM: Double;
    FLFS_VALORCOFINSITEM: Double;
    FLFS_VALORSEGUROITEM: Double;
    FLFS_VALORDESCTOITEM: Double;
    FLFS_VALORICMSRNFITEM: Double;
    FLFS_VALORFRETENFITEM: Double;
    FLFS_VALORICMSSNTBITEM: Double;
    FLFS_VALORBASEOUTROSITEM: Double;
    FLFS_VALORBASEISENTOICMSITEM: Double;
    FLFS_VALORBASECALCULOMVAITEM: Double;
    FLFS_VALORBASECALCULOICMSITEM: Double;
    FLFS_VALORDESPACESSORIAITEM: Double;
    FLFS_VALORICMSCREDITOSNSTITEM: Double;
    FLFS_VALORICMSDESTINOSNSTITEM: Double;
    FLFS_VALORBCALCULOPISCOFINSITEM: Double;
    FLFS_PERCENTUALIPIITEM: Double;
    FLFS_PERCENTUALPISITEM: Double;
    FLFS_PERCENTUALICMSITEM: Double;
    FLFS_PERCENTUALMVAITEM: Double;
    FLFS_PERCENTUALCOFINSITEM: Double;
    FLFS_PERCENTUALICMSDESTINOITEM: Double;
    FLFS_PERCENTUALREDUCAOBCITEM: Double;
    FLFS_PERCENTUALICMSSNTBITEM: Double;
    FLFS_PERCICMSCREDITOSNSTITEM: Double;
    FLFS_PERCICMSDESTINOSNSTITEM: Double;
    FLFS_TOTALITEM: Double;
    FLFS_TOTALITEMBRUTO: Double;
    FLFS_TOTALIPIITEM: Double;
    FLFS_TOTALPISITEM: Double;
    FLFS_TOTALICMSITEM: Double;
    FLFS_TOTALCOFINSITEM: Double;
    FLFS_TOTALSEGUROITEM: Double;
    FLFS_TOTALDESCTOITEM: Double;
    FLFS_TOTALICMSRNFITEM: Double;
    FLFS_TOTALFRETENFITEM: Double;
    FLFS_TOTALBASEOUTROSITEM: Double;
    FLFS_TOTALBASEISENTOICMSITEM: Double;
    FLFS_TOTALBASECALCULOMVAITEM: Double;
    FLFS_TOTALBASECALCULOICMSITEM: Double;
    FLFS_TOTALBCALCULOPISCOFINSITEM: Double;
    FLFS_TOTALDESPACESSORIAITEM: Double;
    FLFS_TOTALICMSCREDITOSNSTITEM: Double;
    FLFS_TOTALICMSDESTINOSNSTITEM: Double;
    FLFS_TOTALICMSSNTBITEM: Double;
    FLFS_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FLFS_ORDEMXMLITEM: Integer;
    FLFS_EXTIPI: String;
    FLFS_PERCENTUALIBPTITEM: Double;
    FLFS_PERCENTUALIBPTMUNICIPALITEM: Double;
    FLFS_PERCENTUALIBPTESTADUALITEM: Double;
    FLFS_PERCENTUALIBPTNACIONALITEM: Double;
    FLFS_PERCENTUALIBPTIMPORTADOITEM: Double;
    FLFS_TOTALIBPTMUNICIPALITEM: Double;
    FLFS_TOTALIBPTESTADUALITEM: Double;
    FLFS_TOTALIBPTNACIONALITEM: Double;
    FLFS_TOTALIBPTIMPORTADOITEM: Double;
    FLFS_PERCENTUALFCPITEM: Double;
    FLFS_TOTALBASECALCULOFCPITEM: Double;
    FLFS_TOTALFCPITEM: Double;
    FLFS_TOTALBASECALCULOFCPSTITEM: Double;
    FLFS_TOTALFCPSTITEM: Double;
    FLFS_TOTALBASECALCULOFCPRETITEM: Double;
    FLFS_TOTALFCPRETITEM: Double;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_ID_OLD: Integer;
    FLFS_01_ID_OLD: Integer;
    FLFS_01_01_ID_OLD: Integer;
    FLFS_TOTALICMSDESONERADOITEM: Double;
    FLFS_MOTIVODESONERACAO: String;
    FLFS_CODIGOBENEFICIO: String;
  public
    { Public declarations }
    const Table      = 'LFS_00_01_01';
    const PrimaryKey = 'LFS_01_01_ID';
    const Sequence   = 'SEQ_LFS_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_01_01_ID', ftInteger)]
    [Dictionary('LFS_01_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_01_ID: Integer read FLFS_01_01_ID write FLFS_01_01_ID;
    const LFS_01_01_ID_Name = 'LFS_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_01_ID', ftInteger)]
    [Dictionary('LFS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_ID: Integer read FLFS_01_ID write FLFS_01_ID;
    const LFS_01_ID_Name = 'LFS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_01_01_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_CSOSN', ftString, 3)]
    [Dictionary('LFS_CSOSN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CSOSN: String read FLFS_CSOSN write FLFS_CSOSN;
    const LFS_CSOSN_Name = 'LFS_CSOSN';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOIPI', ftString, 2)]
    [Dictionary('CST_CODIGOIPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOIPI: String read FCST_CODIGOIPI write FCST_CODIGOIPI;
    const CST_CODIGOIPI_Name = 'CST_CODIGOIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ORDEMITEM', ftInteger)]
    [Dictionary('LFS_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ORDEMITEM: Integer read FLFS_ORDEMITEM write FLFS_ORDEMITEM;
    const LFS_ORDEMITEM_Name = 'LFS_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('LFS_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_QTDSAIDA: Double read FLFS_QTDSAIDA write FLFS_QTDSAIDA;
    const LFS_QTDSAIDA_Name = 'LFS_QTDSAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORITEM', ftBCD)]
    [Dictionary('LFS_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEM: Double read FLFS_VALORITEM write FLFS_VALORITEM;
    const LFS_VALORITEM_Name = 'LFS_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORITEMBRUTO', ftBCD)]
    [Dictionary('LFS_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEMBRUTO: Double read FLFS_VALORITEMBRUTO write FLFS_VALORITEMBRUTO;
    const LFS_VALORITEMBRUTO_Name = 'LFS_VALORITEMBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORIPIITEM', ftBCD)]
    [Dictionary('LFS_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORIPIITEM: Double read FLFS_VALORIPIITEM write FLFS_VALORIPIITEM;
    const LFS_VALORIPIITEM_Name = 'LFS_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPISITEM', ftBCD)]
    [Dictionary('LFS_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPISITEM: Double read FLFS_VALORPISITEM write FLFS_VALORPISITEM;
    const LFS_VALORPISITEM_Name = 'LFS_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSITEM: Double read FLFS_VALORICMSITEM write FLFS_VALORICMSITEM;
    const LFS_VALORICMSITEM_Name = 'LFS_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORCOFINSITEM', ftBCD)]
    [Dictionary('LFS_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORCOFINSITEM: Double read FLFS_VALORCOFINSITEM write FLFS_VALORCOFINSITEM;
    const LFS_VALORCOFINSITEM_Name = 'LFS_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORSEGUROITEM', ftBCD)]
    [Dictionary('LFS_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORSEGUROITEM: Double read FLFS_VALORSEGUROITEM write FLFS_VALORSEGUROITEM;
    const LFS_VALORSEGUROITEM_Name = 'LFS_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORDESCTOITEM', ftBCD)]
    [Dictionary('LFS_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDESCTOITEM: Double read FLFS_VALORDESCTOITEM write FLFS_VALORDESCTOITEM;
    const LFS_VALORDESCTOITEM_Name = 'LFS_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSRNFITEM: Double read FLFS_VALORICMSRNFITEM write FLFS_VALORICMSRNFITEM;
    const LFS_VALORICMSRNFITEM_Name = 'LFS_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORFRETENFITEM', ftBCD)]
    [Dictionary('LFS_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORFRETENFITEM: Double read FLFS_VALORFRETENFITEM write FLFS_VALORFRETENFITEM;
    const LFS_VALORFRETENFITEM_Name = 'LFS_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSSNTBITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSSNTBITEM: Double read FLFS_VALORICMSSNTBITEM write FLFS_VALORICMSSNTBITEM;
    const LFS_VALORICMSSNTBITEM_Name = 'LFS_VALORICMSSNTBITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEOUTROSITEM: Double read FLFS_VALORBASEOUTROSITEM write FLFS_VALORBASEOUTROSITEM;
    const LFS_VALORBASEOUTROSITEM_Name = 'LFS_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEISENTOICMSITEM: Double read FLFS_VALORBASEISENTOICMSITEM write FLFS_VALORBASEISENTOICMSITEM;
    const LFS_VALORBASEISENTOICMSITEM_Name = 'LFS_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOMVAITEM: Double read FLFS_VALORBASECALCULOMVAITEM write FLFS_VALORBASECALCULOMVAITEM;
    const LFS_VALORBASECALCULOMVAITEM_Name = 'LFS_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMSITEM: Double read FLFS_VALORBASECALCULOICMSITEM write FLFS_VALORBASECALCULOICMSITEM;
    const LFS_VALORBASECALCULOICMSITEM_Name = 'LFS_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('LFS_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDESPACESSORIAITEM: Double read FLFS_VALORDESPACESSORIAITEM write FLFS_VALORDESPACESSORIAITEM;
    const LFS_VALORDESPACESSORIAITEM_Name = 'LFS_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSCREDITOSNSTITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSCREDITOSNSTITEM: Double read FLFS_VALORICMSCREDITOSNSTITEM write FLFS_VALORICMSCREDITOSNSTITEM;
    const LFS_VALORICMSCREDITOSNSTITEM_Name = 'LFS_VALORICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSDESTINOSNSTITEM', ftBCD, 10, 6)]
    [Dictionary('LFS_VALORICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSDESTINOSNSTITEM: Double read FLFS_VALORICMSDESTINOSNSTITEM write FLFS_VALORICMSDESTINOSNSTITEM;
    const LFS_VALORICMSDESTINOSNSTITEM_Name = 'LFS_VALORICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('LFS_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBCALCULOPISCOFINSITEM: Double read FLFS_VALORBCALCULOPISCOFINSITEM write FLFS_VALORBCALCULOPISCOFINSITEM;
    const LFS_VALORBCALCULOPISCOFINSITEM_Name = 'LFS_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIPIITEM: Double read FLFS_PERCENTUALIPIITEM write FLFS_PERCENTUALIPIITEM;
    const LFS_PERCENTUALIPIITEM_Name = 'LFS_PERCENTUALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALPISITEM: Double read FLFS_PERCENTUALPISITEM write FLFS_PERCENTUALPISITEM;
    const LFS_PERCENTUALPISITEM_Name = 'LFS_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMSITEM: Double read FLFS_PERCENTUALICMSITEM write FLFS_PERCENTUALICMSITEM;
    const LFS_PERCENTUALICMSITEM_Name = 'LFS_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALMVAITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALMVAITEM: Double read FLFS_PERCENTUALMVAITEM write FLFS_PERCENTUALMVAITEM;
    const LFS_PERCENTUALMVAITEM_Name = 'LFS_PERCENTUALMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALCOFINSITEM: Double read FLFS_PERCENTUALCOFINSITEM write FLFS_PERCENTUALCOFINSITEM;
    const LFS_PERCENTUALCOFINSITEM_Name = 'LFS_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMSDESTINOITEM: Double read FLFS_PERCENTUALICMSDESTINOITEM write FLFS_PERCENTUALICMSDESTINOITEM;
    const LFS_PERCENTUALICMSDESTINOITEM_Name = 'LFS_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALREDUCAOBCITEM: Double read FLFS_PERCENTUALREDUCAOBCITEM write FLFS_PERCENTUALREDUCAOBCITEM;
    const LFS_PERCENTUALREDUCAOBCITEM_Name = 'LFS_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALICMSSNTBITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMSSNTBITEM: Double read FLFS_PERCENTUALICMSSNTBITEM write FLFS_PERCENTUALICMSSNTBITEM;
    const LFS_PERCENTUALICMSSNTBITEM_Name = 'LFS_PERCENTUALICMSSNTBITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCICMSCREDITOSNSTITEM', ftBCD)]
    [Dictionary('LFS_PERCICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCICMSCREDITOSNSTITEM: Double read FLFS_PERCICMSCREDITOSNSTITEM write FLFS_PERCICMSCREDITOSNSTITEM;
    const LFS_PERCICMSCREDITOSNSTITEM_Name = 'LFS_PERCICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCICMSDESTINOSNSTITEM', ftBCD)]
    [Dictionary('LFS_PERCICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCICMSDESTINOSNSTITEM: Double read FLFS_PERCICMSDESTINOSNSTITEM write FLFS_PERCICMSDESTINOSNSTITEM;
    const LFS_PERCICMSDESTINOSNSTITEM_Name = 'LFS_PERCICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALITEM', ftBCD)]
    [Dictionary('LFS_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALITEM: Double read FLFS_TOTALITEM write FLFS_TOTALITEM;
    const LFS_TOTALITEM_Name = 'LFS_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALITEMBRUTO', ftBCD)]
    [Dictionary('LFS_TOTALITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALITEMBRUTO: Double read FLFS_TOTALITEMBRUTO write FLFS_TOTALITEMBRUTO;
    const LFS_TOTALITEMBRUTO_Name = 'LFS_TOTALITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIPIITEM', ftBCD)]
    [Dictionary('LFS_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIPIITEM: Double read FLFS_TOTALIPIITEM write FLFS_TOTALIPIITEM;
    const LFS_TOTALIPIITEM_Name = 'LFS_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPISITEM', ftBCD)]
    [Dictionary('LFS_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPISITEM: Double read FLFS_TOTALPISITEM write FLFS_TOTALPISITEM;
    const LFS_TOTALPISITEM_Name = 'LFS_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSITEM', ftBCD)]
    [Dictionary('LFS_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSITEM: Double read FLFS_TOTALICMSITEM write FLFS_TOTALICMSITEM;
    const LFS_TOTALICMSITEM_Name = 'LFS_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOFINSITEM: Double read FLFS_TOTALCOFINSITEM write FLFS_TOTALCOFINSITEM;
    const LFS_TOTALCOFINSITEM_Name = 'LFS_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('LFS_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSEGUROITEM: Double read FLFS_TOTALSEGUROITEM write FLFS_TOTALSEGUROITEM;
    const LFS_TOTALSEGUROITEM_Name = 'LFS_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('LFS_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESCTOITEM: Double read FLFS_TOTALDESCTOITEM write FLFS_TOTALDESCTOITEM;
    const LFS_TOTALDESCTOITEM_Name = 'LFS_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSRNFITEM', ftBCD)]
    [Dictionary('LFS_TOTALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSRNFITEM: Double read FLFS_TOTALICMSRNFITEM write FLFS_TOTALICMSRNFITEM;
    const LFS_TOTALICMSRNFITEM_Name = 'LFS_TOTALICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFRETENFITEM', ftBCD)]
    [Dictionary('LFS_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFRETENFITEM: Double read FLFS_TOTALFRETENFITEM write FLFS_TOTALFRETENFITEM;
    const LFS_TOTALFRETENFITEM_Name = 'LFS_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASEOUTROSITEM: Double read FLFS_TOTALBASEOUTROSITEM write FLFS_TOTALBASEOUTROSITEM;
    const LFS_TOTALBASEOUTROSITEM_Name = 'LFS_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASEISENTOICMSITEM: Double read FLFS_TOTALBASEISENTOICMSITEM write FLFS_TOTALBASEISENTOICMSITEM;
    const LFS_TOTALBASEISENTOICMSITEM_Name = 'LFS_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOMVAITEM: Double read FLFS_TOTALBASECALCULOMVAITEM write FLFS_TOTALBASECALCULOMVAITEM;
    const LFS_TOTALBASECALCULOMVAITEM_Name = 'LFS_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOICMSITEM: Double read FLFS_TOTALBASECALCULOICMSITEM write FLFS_TOTALBASECALCULOICMSITEM;
    const LFS_TOTALBASECALCULOICMSITEM_Name = 'LFS_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBCALCULOPISCOFINSITEM: Double read FLFS_TOTALBCALCULOPISCOFINSITEM write FLFS_TOTALBCALCULOPISCOFINSITEM;
    const LFS_TOTALBCALCULOPISCOFINSITEM_Name = 'LFS_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('LFS_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESPACESSORIAITEM: Double read FLFS_TOTALDESPACESSORIAITEM write FLFS_TOTALDESPACESSORIAITEM;
    const LFS_TOTALDESPACESSORIAITEM_Name = 'LFS_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSCREDITOSNSTITEM', ftBCD)]
    [Dictionary('LFS_TOTALICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSCREDITOSNSTITEM: Double read FLFS_TOTALICMSCREDITOSNSTITEM write FLFS_TOTALICMSCREDITOSNSTITEM;
    const LFS_TOTALICMSCREDITOSNSTITEM_Name = 'LFS_TOTALICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSDESTINOSNSTITEM', ftBCD)]
    [Dictionary('LFS_TOTALICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSDESTINOSNSTITEM: Double read FLFS_TOTALICMSDESTINOSNSTITEM write FLFS_TOTALICMSDESTINOSNSTITEM;
    const LFS_TOTALICMSDESTINOSNSTITEM_Name = 'LFS_TOTALICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSSNTBITEM', ftBCD)]
    [Dictionary('LFS_TOTALICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSSNTBITEM: Double read FLFS_TOTALICMSSNTBITEM write FLFS_TOTALICMSSNTBITEM;
    const LFS_TOTALICMSSNTBITEM_Name = 'LFS_TOTALICMSSNTBITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALAPROXIMADOIMPOSTOITEM', ftBCD)]
    [Dictionary('LFS_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALAPROXIMADOIMPOSTOITEM: Double read FLFS_TOTALAPROXIMADOIMPOSTOITEM write FLFS_TOTALAPROXIMADOIMPOSTOITEM;
    const LFS_TOTALAPROXIMADOIMPOSTOITEM_Name = 'LFS_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_ORDEMXMLITEM', ftInteger)]
    [Dictionary('LFS_ORDEMXMLITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ORDEMXMLITEM: Integer read FLFS_ORDEMXMLITEM write FLFS_ORDEMXMLITEM;
    const LFS_ORDEMXMLITEM_Name = 'LFS_ORDEMXMLITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_EXTIPI', ftString, 3)]
    [Dictionary('LFS_EXTIPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_EXTIPI: String read FLFS_EXTIPI write FLFS_EXTIPI;
    const LFS_EXTIPI_Name = 'LFS_EXTIPI';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTITEM: Double read FLFS_PERCENTUALIBPTITEM write FLFS_PERCENTUALIBPTITEM;
    const LFS_PERCENTUALIBPTITEM_Name = 'LFS_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTMUNICIPALITEM: Double read FLFS_PERCENTUALIBPTMUNICIPALITEM write FLFS_PERCENTUALIBPTMUNICIPALITEM;
    const LFS_PERCENTUALIBPTMUNICIPALITEM_Name = 'LFS_PERCENTUALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTESTADUALITEM: Double read FLFS_PERCENTUALIBPTESTADUALITEM write FLFS_PERCENTUALIBPTESTADUALITEM;
    const LFS_PERCENTUALIBPTESTADUALITEM_Name = 'LFS_PERCENTUALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTNACIONALITEM: Double read FLFS_PERCENTUALIBPTNACIONALITEM write FLFS_PERCENTUALIBPTNACIONALITEM;
    const LFS_PERCENTUALIBPTNACIONALITEM_Name = 'LFS_PERCENTUALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIBPTIMPORTADOITEM: Double read FLFS_PERCENTUALIBPTIMPORTADOITEM write FLFS_PERCENTUALIBPTIMPORTADOITEM;
    const LFS_PERCENTUALIBPTIMPORTADOITEM_Name = 'LFS_PERCENTUALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('LFS_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTMUNICIPALITEM: Double read FLFS_TOTALIBPTMUNICIPALITEM write FLFS_TOTALIBPTMUNICIPALITEM;
    const LFS_TOTALIBPTMUNICIPALITEM_Name = 'LFS_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('LFS_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTESTADUALITEM: Double read FLFS_TOTALIBPTESTADUALITEM write FLFS_TOTALIBPTESTADUALITEM;
    const LFS_TOTALIBPTESTADUALITEM_Name = 'LFS_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('LFS_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTNACIONALITEM: Double read FLFS_TOTALIBPTNACIONALITEM write FLFS_TOTALIBPTNACIONALITEM;
    const LFS_TOTALIBPTNACIONALITEM_Name = 'LFS_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('LFS_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIBPTIMPORTADOITEM: Double read FLFS_TOTALIBPTIMPORTADOITEM write FLFS_TOTALIBPTIMPORTADOITEM;
    const LFS_TOTALIBPTIMPORTADOITEM_Name = 'LFS_TOTALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALFCPITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALFCPITEM: Double read FLFS_PERCENTUALFCPITEM write FLFS_PERCENTUALFCPITEM;
    const LFS_PERCENTUALFCPITEM_Name = 'LFS_PERCENTUALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOFCPITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOFCPITEM: Double read FLFS_TOTALBASECALCULOFCPITEM write FLFS_TOTALBASECALCULOFCPITEM;
    const LFS_TOTALBASECALCULOFCPITEM_Name = 'LFS_TOTALBASECALCULOFCPITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFCPITEM', ftBCD)]
    [Dictionary('LFS_TOTALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFCPITEM: Double read FLFS_TOTALFCPITEM write FLFS_TOTALFCPITEM;
    const LFS_TOTALFCPITEM_Name = 'LFS_TOTALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOFCPSTITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOFCPSTITEM: Double read FLFS_TOTALBASECALCULOFCPSTITEM write FLFS_TOTALBASECALCULOFCPSTITEM;
    const LFS_TOTALBASECALCULOFCPSTITEM_Name = 'LFS_TOTALBASECALCULOFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFCPSTITEM', ftBCD)]
    [Dictionary('LFS_TOTALFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFCPSTITEM: Double read FLFS_TOTALFCPSTITEM write FLFS_TOTALFCPSTITEM;
    const LFS_TOTALFCPSTITEM_Name = 'LFS_TOTALFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOFCPRETITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOFCPRETITEM: Double read FLFS_TOTALBASECALCULOFCPRETITEM write FLFS_TOTALBASECALCULOFCPRETITEM;
    const LFS_TOTALBASECALCULOFCPRETITEM_Name = 'LFS_TOTALBASECALCULOFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFCPRETITEM', ftBCD)]
    [Dictionary('LFS_TOTALFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFCPRETITEM: Double read FLFS_TOTALFCPRETITEM write FLFS_TOTALFCPRETITEM;
    const LFS_TOTALFCPRETITEM_Name = 'LFS_TOTALFCPRETITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_01_ID_OLD', ftInteger)]
    [Dictionary('LFS_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_ID_OLD: Integer read FLFS_01_ID_OLD write FLFS_01_ID_OLD;
    const LFS_01_ID_OLD_Name = 'LFS_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_01_01_ID_OLD', ftInteger)]
    [Dictionary('LFS_01_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_01_ID_OLD: Integer read FLFS_01_01_ID_OLD write FLFS_01_01_ID_OLD;
    const LFS_01_01_ID_OLD_Name = 'LFS_01_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSDESONERADOITEM', ftBCD)]
    [Dictionary('LFS_TOTALICMSDESONERADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSDESONERADOITEM: Double read FLFS_TOTALICMSDESONERADOITEM write FLFS_TOTALICMSDESONERADOITEM;
    const LFS_TOTALICMSDESONERADOITEM_Name = 'LFS_TOTALICMSDESONERADOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_MOTIVODESONERACAO', ftString, 2)]
    [Dictionary('LFS_MOTIVODESONERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_MOTIVODESONERACAO: String read FLFS_MOTIVODESONERACAO write FLFS_MOTIVODESONERACAO;
    const LFS_MOTIVODESONERACAO_Name = 'LFS_MOTIVODESONERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_CODIGOBENEFICIO', ftString, 10)]
    [Dictionary('LFS_CODIGOBENEFICIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CODIGOBENEFICIO: String read FLFS_CODIGOBENEFICIO write FLFS_CODIGOBENEFICIO;
    const LFS_CODIGOBENEFICIO_Name = 'LFS_CODIGOBENEFICIO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_01_01)

end.
