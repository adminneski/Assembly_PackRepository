unit express.dbo.REL_V01_LFE_01;

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
  [Table('REL_V01_LFE_01', '')]
  TDtoREL_V01_LFE_01 = class
  private
    { Private declarations } 
    FLFE_01_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_01_ID: Integer;
    FLFE_ID: Integer;
    FPRO_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FLFE_ORDEMITEM: Integer;
    FLFE_QTDENTRADA: Double;
    FLFE_VALORITEM: Double;
    FLFE_VALORICMSITEM: Double;
    FLFE_VALORFRETEITEM: Double;
    FLFE_VALORSEGUROITEM: Double;
    FLFE_VALORIPIITEM: Double;
    FLFE_VALORDESCTOITEM: Double;
    FLFE_VALORICMSRNFITEM: Double;
    FLFE_PERCENTUALICMSITEM: Double;
    FLFE_VALORBASEOUTROSITEM: Double;
    FLFE_VALORBASEISENTOICMSITEM: Double;
    FLFE_VALORBASECALCULOMVAITEM: Double;
    FLFE_VALORBASECALCULOICMSITEM: Double;
    FLFE_VALORDESPACESSORIAITEM: Double;
    FLFE_DATAALTERACAO: TDateTime;
    FLFE_NOTAFISCAL: String;
    FPRO_DESCRICAO: String;
    FPRO_PROCEDENCIA: String;
    FSGM_CODIGO: String;
    FSGM_SIGLA: String;
    FCFOP_NOMEAPELIDO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_LFE_01';

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
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

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
    [Column('LFE_VALORICMSITEM', ftBCD, 48, 2)]
    [Dictionary('LFE_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSITEM: Double read FLFE_VALORICMSITEM write FLFE_VALORICMSITEM;
    const LFE_VALORICMSITEM_Name = 'LFE_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORFRETEITEM', ftBCD)]
    [Dictionary('LFE_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORFRETEITEM: Double read FLFE_VALORFRETEITEM write FLFE_VALORFRETEITEM;
    const LFE_VALORFRETEITEM_Name = 'LFE_VALORFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORSEGUROITEM', ftBCD)]
    [Dictionary('LFE_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORSEGUROITEM: Double read FLFE_VALORSEGUROITEM write FLFE_VALORSEGUROITEM;
    const LFE_VALORSEGUROITEM_Name = 'LFE_VALORSEGUROITEM';

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
    [Column('LFE_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('LFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSRNFITEM: Double read FLFE_VALORICMSRNFITEM write FLFE_VALORICMSRNFITEM;
    const LFE_VALORICMSRNFITEM_Name = 'LFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMSITEM: Double read FLFE_PERCENTUALICMSITEM write FLFE_PERCENTUALICMSITEM;
    const LFE_PERCENTUALICMSITEM_Name = 'LFE_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('LFE_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEOUTROSITEM: Double read FLFE_VALORBASEOUTROSITEM write FLFE_VALORBASEOUTROSITEM;
    const LFE_VALORBASEOUTROSITEM_Name = 'LFE_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('LFE_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEISENTOICMSITEM: Double read FLFE_VALORBASEISENTOICMSITEM write FLFE_VALORBASEISENTOICMSITEM;
    const LFE_VALORBASEISENTOICMSITEM_Name = 'LFE_VALORBASEISENTOICMSITEM';

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
    [Column('LFE_VALORDESPACESSORIAITEM', ftBCD, 10, 2)]
    [Dictionary('LFE_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORDESPACESSORIAITEM: Double read FLFE_VALORDESPACESSORIAITEM write FLFE_VALORDESPACESSORIAITEM;
    const LFE_VALORDESPACESSORIAITEM_Name = 'LFE_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAALTERACAO: TDateTime read FLFE_DATAALTERACAO write FLFE_DATAALTERACAO;
    const LFE_DATAALTERACAO_Name = 'LFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NOTAFISCAL: String read FLFE_NOTAFISCAL write FLFE_NOTAFISCAL;
    const LFE_NOTAFISCAL_Name = 'LFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_PROCEDENCIA', ftString, 1)]
    [Dictionary('PRO_PROCEDENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PROCEDENCIA: String read FPRO_PROCEDENCIA write FPRO_PROCEDENCIA;
    const PRO_PROCEDENCIA_Name = 'PRO_PROCEDENCIA';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_SIGLA', ftString, 2)]
    [Dictionary('SGM_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_SIGLA: String read FSGM_SIGLA write FSGM_SIGLA;
    const SGM_SIGLA_Name = 'SGM_SIGLA';

    [Restrictions([NoValidate])]
    [Column('CFOP_NOMEAPELIDO', ftString, 25)]
    [Dictionary('CFOP_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_NOMEAPELIDO: String read FCFOP_NOMEAPELIDO write FCFOP_NOMEAPELIDO;
    const CFOP_NOMEAPELIDO_Name = 'CFOP_NOMEAPELIDO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_LFE_01)

end.
