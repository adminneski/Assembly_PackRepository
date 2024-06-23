unit express.dbo.EXP_NFEENTRADA_01_01;

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
  [Table('EXP_NFeEntrada_01_01', '')]
  TDtoEXP_NFeEntrada_01_01 = class
  private
    { Private declarations } 
    FLFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FPRO_CODIGO: Integer;
    FSGM_SIGLA: String;
    FSGM_CODIGO: String;
    FCLF_CODIGO: String;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_PROCEDENCIA: String;
    FPRO_OBSERVACAO: String;
    FNCM_CODIGONCM: String;
    FLFE_ORDEMITEM: Integer;
    FLFE_QTDENTRADA: Double;
    FLFE_VALORITEM: Double;
    FLFE_VALORIPIITEM: Double;
    FLFE_VALORICMSITEM: Double;
    FLFE_VALORICMSRNFITEM: Double;
    FLFE_VALORBASECALCULOMVAITEM: Double;
    FLFE_VALORBASECALCULOICMSITEM: Double;
    FLFE_PERCENTUALMVAITEM: Double;
    FLFE_PERCENTUALIPIITEM: Double;
    FLFE_PERCENTUALPISITEM: Double;
    FLFE_PERCENTUALICMSITEM: Double;
    FLFE_PERCENTUALCOFINSITEM: Double;
    FLFE_PERCENTUALREDUCAOBCITEM: Double;
    FLFE_PERCENTUALICMSDESTINOITEM: Double;
    FLFE_TOTALVALORITEM: Double;
    FLFE_TOTALIPIITEM: Double;
    FLFE_TOTALPISITEM: Double;
    FLFE_TOTALCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'EXP_NFeEntrada_01_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_SIGLA', ftString, 2)]
    [Dictionary('SGM_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_SIGLA: String read FSGM_SIGLA write FSGM_SIGLA;
    const SGM_SIGLA_Name = 'SGM_SIGLA';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('PRO_PROCEDENCIA', ftString, 1)]
    [Dictionary('PRO_PROCEDENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PROCEDENCIA: String read FPRO_PROCEDENCIA write FPRO_PROCEDENCIA;
    const PRO_PROCEDENCIA_Name = 'PRO_PROCEDENCIA';

    [Restrictions([NoValidate])]
    [Column('PRO_OBSERVACAO', ftString, 300)]
    [Dictionary('PRO_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_OBSERVACAO: String read FPRO_OBSERVACAO write FPRO_OBSERVACAO;
    const PRO_OBSERVACAO_Name = 'PRO_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGONCM', ftString, 12)]
    [Dictionary('NCM_CODIGONCM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NCM_CODIGONCM: String read FNCM_CODIGONCM write FNCM_CODIGONCM;
    const NCM_CODIGONCM_Name = 'NCM_CODIGONCM';

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
    [Column('LFE_VALORICMSITEM', ftBCD)]
    [Dictionary('LFE_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSITEM: Double read FLFE_VALORICMSITEM write FLFE_VALORICMSITEM;
    const LFE_VALORICMSITEM_Name = 'LFE_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORICMSRNFITEM', ftBCD, 10, 2)]
    [Dictionary('LFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSRNFITEM: Double read FLFE_VALORICMSRNFITEM write FLFE_VALORICMSRNFITEM;
    const LFE_VALORICMSRNFITEM_Name = 'LFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('LFE_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOMVAITEM: Double read FLFE_VALORBASECALCULOMVAITEM write FLFE_VALORBASECALCULOMVAITEM;
    const LFE_VALORBASECALCULOMVAITEM_Name = 'LFE_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFE_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOICMSITEM: Double read FLFE_VALORBASECALCULOICMSITEM write FLFE_VALORBASECALCULOICMSITEM;
    const LFE_VALORBASECALCULOICMSITEM_Name = 'LFE_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALMVAITEM: Double read FLFE_PERCENTUALMVAITEM write FLFE_PERCENTUALMVAITEM;
    const LFE_PERCENTUALMVAITEM_Name = 'LFE_PERCENTUALMVAITEM';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_PERCENTUALICMSITEM', ftBCD, 48, 2)]
    [Dictionary('LFE_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMSITEM: Double read FLFE_PERCENTUALICMSITEM write FLFE_PERCENTUALICMSITEM;
    const LFE_PERCENTUALICMSITEM_Name = 'LFE_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALCOFINSITEM: Double read FLFE_PERCENTUALCOFINSITEM write FLFE_PERCENTUALCOFINSITEM;
    const LFE_PERCENTUALCOFINSITEM_Name = 'LFE_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('LFE_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALREDUCAOBCITEM: Double read FLFE_PERCENTUALREDUCAOBCITEM write FLFE_PERCENTUALREDUCAOBCITEM;
    const LFE_PERCENTUALREDUCAOBCITEM_Name = 'LFE_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMSDESTINOITEM: Double read FLFE_PERCENTUALICMSDESTINOITEM write FLFE_PERCENTUALICMSDESTINOITEM;
    const LFE_PERCENTUALICMSDESTINOITEM_Name = 'LFE_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALVALORITEM', ftBCD)]
    [Dictionary('LFE_TOTALVALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALVALORITEM: Double read FLFE_TOTALVALORITEM write FLFE_TOTALVALORITEM;
    const LFE_TOTALVALORITEM_Name = 'LFE_TOTALVALORITEM';

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
    [Column('LFE_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('LFE_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALCOFINSITEM: Double read FLFE_TOTALCOFINSITEM write FLFE_TOTALCOFINSITEM;
    const LFE_TOTALCOFINSITEM_Name = 'LFE_TOTALCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_NFeEntrada_01_01)

end.
