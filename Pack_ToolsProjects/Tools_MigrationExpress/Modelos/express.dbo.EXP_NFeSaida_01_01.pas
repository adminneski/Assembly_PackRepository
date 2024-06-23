unit express.dbo.EXP_NFESAIDA_01_01;

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
  [Table('EXP_NFeSaida_01_01', '')]
  TDtoEXP_NFeSaida_01_01 = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
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
    FLEF_CODIGO: Integer;
    FLEF_VALORIPI: Double;
    FLEF_PERCENTUALIPI: Double;
    FLFS_QTDSAIDA: Double;
    FLFS_ORDEMITEM: Integer;
    FLFS_VALORITEM: Double;
    FLFS_VALORDESCTOITEM: Double;
    FLFS_VALORIPIITEM: Double;
    FLFS_VALORICMSITEM: Double;
    FLFS_VALORICMSRNFITEM: Double;
    FLFS_VALORBASECALCULOMVAITEM: Double;
    FLFS_VALORBASECALCULOICMSITEM: Double;
    FLFS_PERCENTUALMVAITEM: Double;
    FLFS_PERCENTUALIPIITEM: Double;
    FLFS_PERCENTUALPISITEM: Double;
    FLFS_PERCENTUALICMSITEM: Double;
    FLFS_PERCENTUALCOFINSITEM: Double;
    FLFS_PERCENTUALREDUCAOBCITEM: Double;
    FLFS_PERCENTUALICMSDESTINOITEM: Double;
    FLFS_TOTALVALORITEM: Double;
    FLFS_TOTALIPIITEM: Double;
    FLFS_TOTALPISITEM: Double;
    FLFS_TOTALCOFINSITEM: Double;
    FLFS_PERCICMSDESTINOSNSTITEM: Double;
    FLFS_VALORICMSDESTINOSNSTITEM: Double;
    FLFS_PERCICMSCREDITOSNSTITEM: Double;
    FLFS_VALORICMSCREDITOSNSTITEM: Double;
    FLFS_PERCENTUALICMSSNTBITEM: Double;
    FLFS_VALORICMSSNTBITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'EXP_NFeSaida_01_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
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

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_VALORIPI', ftBCD)]
    [Dictionary('LEF_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_VALORIPI: Double read FLEF_VALORIPI write FLEF_VALORIPI;
    const LEF_VALORIPI_Name = 'LEF_VALORIPI';

    [Restrictions([NoValidate])]
    [Column('LEF_PERCENTUALIPI', ftBCD)]
    [Dictionary('LEF_PERCENTUALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALIPI: Double read FLEF_PERCENTUALIPI write FLEF_PERCENTUALIPI;
    const LEF_PERCENTUALIPI_Name = 'LEF_PERCENTUALIPI';

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
    [Column('LFS_VALORDESCTOITEM', ftBCD)]
    [Dictionary('LFS_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDESCTOITEM: Double read FLFS_VALORDESCTOITEM write FLFS_VALORDESCTOITEM;
    const LFS_VALORDESCTOITEM_Name = 'LFS_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORIPIITEM', ftBCD)]
    [Dictionary('LFS_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORIPIITEM: Double read FLFS_VALORIPIITEM write FLFS_VALORIPIITEM;
    const LFS_VALORIPIITEM_Name = 'LFS_VALORIPIITEM';

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
    [Column('LFS_VALORBASECALCULOMVAITEM', ftBCD, 48, 2)]
    [Dictionary('LFS_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOMVAITEM: Double read FLFS_VALORBASECALCULOMVAITEM write FLFS_VALORBASECALCULOMVAITEM;
    const LFS_VALORBASECALCULOMVAITEM_Name = 'LFS_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMSITEM: Double read FLFS_VALORBASECALCULOICMSITEM write FLFS_VALORBASECALCULOICMSITEM;
    const LFS_VALORBASECALCULOICMSITEM_Name = 'LFS_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALMVAITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALMVAITEM: Double read FLFS_PERCENTUALMVAITEM write FLFS_PERCENTUALMVAITEM;
    const LFS_PERCENTUALMVAITEM_Name = 'LFS_PERCENTUALMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIPIITEM', ftBCD, 48, 6)]
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
    [Column('LFS_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALCOFINSITEM: Double read FLFS_PERCENTUALCOFINSITEM write FLFS_PERCENTUALCOFINSITEM;
    const LFS_PERCENTUALCOFINSITEM_Name = 'LFS_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALREDUCAOBCITEM: Double read FLFS_PERCENTUALREDUCAOBCITEM write FLFS_PERCENTUALREDUCAOBCITEM;
    const LFS_PERCENTUALREDUCAOBCITEM_Name = 'LFS_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMSDESTINOITEM: Double read FLFS_PERCENTUALICMSDESTINOITEM write FLFS_PERCENTUALICMSDESTINOITEM;
    const LFS_PERCENTUALICMSDESTINOITEM_Name = 'LFS_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALVALORITEM', ftBCD)]
    [Dictionary('LFS_TOTALVALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALVALORITEM: Double read FLFS_TOTALVALORITEM write FLFS_TOTALVALORITEM;
    const LFS_TOTALVALORITEM_Name = 'LFS_TOTALVALORITEM';

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
    [Column('LFS_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOFINSITEM: Double read FLFS_TOTALCOFINSITEM write FLFS_TOTALCOFINSITEM;
    const LFS_TOTALCOFINSITEM_Name = 'LFS_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCICMSDESTINOSNSTITEM', ftBCD, 66260064, 6)]
    [Dictionary('LFS_PERCICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCICMSDESTINOSNSTITEM: Double read FLFS_PERCICMSDESTINOSNSTITEM write FLFS_PERCICMSDESTINOSNSTITEM;
    const LFS_PERCICMSDESTINOSNSTITEM_Name = 'LFS_PERCICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSDESTINOSNSTITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSDESTINOSNSTITEM: Double read FLFS_VALORICMSDESTINOSNSTITEM write FLFS_VALORICMSDESTINOSNSTITEM;
    const LFS_VALORICMSDESTINOSNSTITEM_Name = 'LFS_VALORICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCICMSCREDITOSNSTITEM', ftBCD)]
    [Dictionary('LFS_PERCICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCICMSCREDITOSNSTITEM: Double read FLFS_PERCICMSCREDITOSNSTITEM write FLFS_PERCICMSCREDITOSNSTITEM;
    const LFS_PERCICMSCREDITOSNSTITEM_Name = 'LFS_PERCICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSCREDITOSNSTITEM', ftBCD, 10, 18)]
    [Dictionary('LFS_VALORICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSCREDITOSNSTITEM: Double read FLFS_VALORICMSCREDITOSNSTITEM write FLFS_VALORICMSCREDITOSNSTITEM;
    const LFS_VALORICMSCREDITOSNSTITEM_Name = 'LFS_VALORICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALICMSSNTBITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMSSNTBITEM: Double read FLFS_PERCENTUALICMSSNTBITEM write FLFS_PERCENTUALICMSSNTBITEM;
    const LFS_PERCENTUALICMSSNTBITEM_Name = 'LFS_PERCENTUALICMSSNTBITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSSNTBITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSSNTBITEM: Double read FLFS_VALORICMSSNTBITEM write FLFS_VALORICMSSNTBITEM;
    const LFS_VALORICMSSNTBITEM_Name = 'LFS_VALORICMSSNTBITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_NFeSaida_01_01)

end.
