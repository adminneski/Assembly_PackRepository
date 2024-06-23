unit express.dbo.EXP_LFE_01_01_CONTABIL;

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
  [Table('EXP_LFE_01_01_Contabil', '')]
  TDtoEXP_LFE_01_01_Contabil = class
  private
    { Private declarations } 
    FLFE_ID: Integer;
    FPRO_CODIGO: Integer;
    FSGM_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FCTB_CODIGO: Integer;
    FLFE_PERCENTUALICMS: Double;
    FLFE_PERCENTUALIPIITEM: Double;
    FLFE_PERCENTUALREDUCAOBCITEM: Double;
    FCOM_CODIGO: Integer;
    FLFE_NOTAFISCAL: String;
    FLFE_QTDENTRADA: Double;
    FLFE_ORDEMITEM: Integer;
    FLFE_VALORITEM: Double;
    FLFE_VALORIPIITEM: Double;
    FLFE_VALORDESCTOITEM: Double;
    FLFE_VALORICMSITEM: Double;
    FLFE_VALORICMSRNFITEM: Double;
    FLFE_VALORBASEOUTROSITEM: Double;
    FLFE_VALORDESPACESSORIAITEM: Double;
    FLFE_VALORBASEISENTOICMSITEM: Double;
    FLFE_VALORBASECALCULOICMSITEM: Double;
    FLFE_VALORBASECALCULOMVAITEM: Double;
    FLFE_TOTALITEM: Double;
    FPRO_DESCRICAO: String;
    FCLF_CODIGO: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_LFE_01_01_Contabil';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

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
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_PERCENTUALICMS', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMS: Double read FLFE_PERCENTUALICMS write FLFE_PERCENTUALICMS;
    const LFE_PERCENTUALICMS_Name = 'LFE_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALIPIITEM: Double read FLFE_PERCENTUALIPIITEM write FLFE_PERCENTUALIPIITEM;
    const LFE_PERCENTUALIPIITEM_Name = 'LFE_PERCENTUALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALREDUCAOBCITEM: Double read FLFE_PERCENTUALREDUCAOBCITEM write FLFE_PERCENTUALREDUCAOBCITEM;
    const LFE_PERCENTUALREDUCAOBCITEM_Name = 'LFE_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NOTAFISCAL: String read FLFE_NOTAFISCAL write FLFE_NOTAFISCAL;
    const LFE_NOTAFISCAL_Name = 'LFE_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('LFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_QTDENTRADA: Double read FLFE_QTDENTRADA write FLFE_QTDENTRADA;
    const LFE_QTDENTRADA_Name = 'LFE_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ORDEMITEM', ftInteger)]
    [Dictionary('LFE_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ORDEMITEM: Integer read FLFE_ORDEMITEM write FLFE_ORDEMITEM;
    const LFE_ORDEMITEM_Name = 'LFE_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORITEM', ftBCD)]
    [Dictionary('LFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEM: Double read FLFE_VALORITEM write FLFE_VALORITEM;
    const LFE_VALORITEM_Name = 'LFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORIPIITEM', ftBCD)]
    [Dictionary('LFE_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORIPIITEM: Double read FLFE_VALORIPIITEM write FLFE_VALORIPIITEM;
    const LFE_VALORIPIITEM_Name = 'LFE_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORDESCTOITEM', ftBCD)]
    [Dictionary('LFE_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORDESCTOITEM: Double read FLFE_VALORDESCTOITEM write FLFE_VALORDESCTOITEM;
    const LFE_VALORDESCTOITEM_Name = 'LFE_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORICMSITEM', ftBCD)]
    [Dictionary('LFE_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSITEM: Double read FLFE_VALORICMSITEM write FLFE_VALORICMSITEM;
    const LFE_VALORICMSITEM_Name = 'LFE_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('LFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSRNFITEM: Double read FLFE_VALORICMSRNFITEM write FLFE_VALORICMSRNFITEM;
    const LFE_VALORICMSRNFITEM_Name = 'LFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASEOUTROSITEM', ftBCD, 10, 18)]
    [Dictionary('LFE_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEOUTROSITEM: Double read FLFE_VALORBASEOUTROSITEM write FLFE_VALORBASEOUTROSITEM;
    const LFE_VALORBASEOUTROSITEM_Name = 'LFE_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('LFE_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORDESPACESSORIAITEM: Double read FLFE_VALORDESPACESSORIAITEM write FLFE_VALORDESPACESSORIAITEM;
    const LFE_VALORDESPACESSORIAITEM_Name = 'LFE_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASEISENTOICMSITEM', ftBCD, 48, 18)]
    [Dictionary('LFE_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEISENTOICMSITEM: Double read FLFE_VALORBASEISENTOICMSITEM write FLFE_VALORBASEISENTOICMSITEM;
    const LFE_VALORBASEISENTOICMSITEM_Name = 'LFE_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFE_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOICMSITEM: Double read FLFE_VALORBASECALCULOICMSITEM write FLFE_VALORBASECALCULOICMSITEM;
    const LFE_VALORBASECALCULOICMSITEM_Name = 'LFE_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('LFE_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOMVAITEM: Double read FLFE_VALORBASECALCULOMVAITEM write FLFE_VALORBASECALCULOMVAITEM;
    const LFE_VALORBASECALCULOMVAITEM_Name = 'LFE_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALITEM', ftBCD)]
    [Dictionary('LFE_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALITEM: Double read FLFE_TOTALITEM write FLFE_TOTALITEM;
    const LFE_TOTALITEM_Name = 'LFE_TOTALITEM';

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
  TRegisterClass.RegisterEntity(TDtoEXP_LFE_01_01_Contabil)

end.
