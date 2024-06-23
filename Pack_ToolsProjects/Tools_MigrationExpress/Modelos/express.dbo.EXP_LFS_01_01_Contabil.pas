unit express.dbo.EXP_LFS_01_01_CONTABIL;

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
  [Table('EXP_LFS_01_01_Contabil', '')]
  TDtoEXP_LFS_01_01_Contabil = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FPRO_CODIGO: Integer;
    FSGM_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FCTB_CODIGO: Integer;
    FLFS_PERCENTUALICMS: Double;
    FLFS_PERCENTUALIPIITEM: Double;
    FLFS_PERCENTUALREDUCAOBCITEM: Double;
    FCOM_CODIGO: Integer;
    FLFS_NOTAFISCAL: String;
    FLFS_QTDSAIDA: Double;
    FLFS_ORDEMITEM: Integer;
    FLFS_VALORITEM: Double;
    FLFS_VALORIPIITEM: Double;
    FLFS_VALORDESCTOITEM: Double;
    FLFS_VALORICMSITEM: Double;
    FLFS_VALORICMSRNFITEM: Double;
    FLFS_VALORBASEOUTROSITEM: Double;
    FLFS_VALORDESPACESSORIAITEM: Double;
    FLFS_VALORBASEISENTOICMSITEM: Double;
    FLFS_VALORBASECALCULOICMSITEM: Double;
    FLFS_VALORBASECALCULOMVAITEM: Double;
    FLFS_TOTALITEM: Double;
    FPRO_DESCRICAO: String;
    FCLF_CODIGO: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_LFS_01_01_Contabil';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_PERCENTUALICMS', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMS: Double read FLFS_PERCENTUALICMS write FLFS_PERCENTUALICMS;
    const LFS_PERCENTUALICMS_Name = 'LFS_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIPIITEM: Double read FLFS_PERCENTUALIPIITEM write FLFS_PERCENTUALIPIITEM;
    const LFS_PERCENTUALIPIITEM_Name = 'LFS_PERCENTUALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALREDUCAOBCITEM: Double read FLFS_PERCENTUALREDUCAOBCITEM write FLFS_PERCENTUALREDUCAOBCITEM;
    const LFS_PERCENTUALREDUCAOBCITEM_Name = 'LFS_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('LFS_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_QTDSAIDA: Double read FLFS_QTDSAIDA write FLFS_QTDSAIDA;
    const LFS_QTDSAIDA_Name = 'LFS_QTDSAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ORDEMITEM', ftInteger)]
    [Dictionary('LFS_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ORDEMITEM: Integer read FLFS_ORDEMITEM write FLFS_ORDEMITEM;
    const LFS_ORDEMITEM_Name = 'LFS_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORITEM', ftBCD)]
    [Dictionary('LFS_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEM: Double read FLFS_VALORITEM write FLFS_VALORITEM;
    const LFS_VALORITEM_Name = 'LFS_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORIPIITEM', ftBCD)]
    [Dictionary('LFS_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORIPIITEM: Double read FLFS_VALORIPIITEM write FLFS_VALORIPIITEM;
    const LFS_VALORIPIITEM_Name = 'LFS_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORDESCTOITEM', ftBCD)]
    [Dictionary('LFS_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDESCTOITEM: Double read FLFS_VALORDESCTOITEM write FLFS_VALORDESCTOITEM;
    const LFS_VALORDESCTOITEM_Name = 'LFS_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSITEM: Double read FLFS_VALORICMSITEM write FLFS_VALORICMSITEM;
    const LFS_VALORICMSITEM_Name = 'LFS_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSRNFITEM: Double read FLFS_VALORICMSRNFITEM write FLFS_VALORICMSRNFITEM;
    const LFS_VALORICMSRNFITEM_Name = 'LFS_VALORICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASEOUTROSITEM', ftBCD, 10, 18)]
    [Dictionary('LFS_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEOUTROSITEM: Double read FLFS_VALORBASEOUTROSITEM write FLFS_VALORBASEOUTROSITEM;
    const LFS_VALORBASEOUTROSITEM_Name = 'LFS_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('LFS_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDESPACESSORIAITEM: Double read FLFS_VALORDESPACESSORIAITEM write FLFS_VALORDESPACESSORIAITEM;
    const LFS_VALORDESPACESSORIAITEM_Name = 'LFS_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASEISENTOICMSITEM', ftBCD, 48, 18)]
    [Dictionary('LFS_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEISENTOICMSITEM: Double read FLFS_VALORBASEISENTOICMSITEM write FLFS_VALORBASEISENTOICMSITEM;
    const LFS_VALORBASEISENTOICMSITEM_Name = 'LFS_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMSITEM: Double read FLFS_VALORBASECALCULOICMSITEM write FLFS_VALORBASECALCULOICMSITEM;
    const LFS_VALORBASECALCULOICMSITEM_Name = 'LFS_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOMVAITEM: Double read FLFS_VALORBASECALCULOMVAITEM write FLFS_VALORBASECALCULOMVAITEM;
    const LFS_VALORBASECALCULOMVAITEM_Name = 'LFS_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALITEM', ftBCD)]
    [Dictionary('LFS_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALITEM: Double read FLFS_TOTALITEM write FLFS_TOTALITEM;
    const LFS_TOTALITEM_Name = 'LFS_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_LFS_01_01_Contabil)

end.
