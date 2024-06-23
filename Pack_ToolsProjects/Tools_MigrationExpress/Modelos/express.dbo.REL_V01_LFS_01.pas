unit express.dbo.REL_V01_LFS_01;

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
  [Table('REL_V01_LFS_01', '')]
  TDtoREL_V01_LFS_01 = class
  private
    { Private declarations } 
    FLFS_01_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_01_ID: Integer;
    FLFS_ID: Integer;
    FPRO_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FLFS_ORDEMITEM: Integer;
    FLFS_QTDSAIDA: Double;
    FLFS_VALORITEM: Double;
    FLFS_VALORICMSITEM: Double;
    FLFS_VALORFRETEITEM: Double;
    FLFS_VALORSEGUROITEM: Double;
    FLFS_VALORIPIITEM: Double;
    FLFS_VALORDESCTOITEM: Double;
    FLFS_VALORICMSRNFITEM: Double;
    FLFS_PERCENTUALICMSITEM: Double;
    FLFS_PERCENTUALIPIITEM: Double;
    FLFS_VALORBASEOUTROSITEM: Double;
    FLFS_VALORBASEISENTOICMSITEM: Double;
    FLFS_VALORBASECALCULOMVAITEM: Double;
    FLFS_VALORBASECALCULOICMSITEM: Double;
    FLFS_VALORDESPACESSORIAITEM: Double;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_NOTAFISCAL: String;
    FLFS_TOTALPESOLIQUIDO: Double;
    FPRO_DESCRICAO: String;
    FPRO_PROCEDENCIA: String;
    FSGM_CODIGO: String;
    FSGM_SIGLA: String;
    FCFOP_NOMEAPELIDO: String;
    FPRO_VALORICMSR: Double;
    FPRO_VALORBASECALCULOMVA: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_LFS_01';

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
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

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
    [Column('LFS_ORDEMITEM', ftInteger)]
    [Dictionary('LFS_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ORDEMITEM: Integer read FLFS_ORDEMITEM write FLFS_ORDEMITEM;
    const LFS_ORDEMITEM_Name = 'LFS_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('LFS_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_QTDSAIDA: Double read FLFS_QTDSAIDA write FLFS_QTDSAIDA;
    const LFS_QTDSAIDA_Name = 'LFS_QTDSAIDA';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORITEM', ftBCD)]
    [Dictionary('LFS_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEM: Double read FLFS_VALORITEM write FLFS_VALORITEM;
    const LFS_VALORITEM_Name = 'LFS_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSITEM: Double read FLFS_VALORICMSITEM write FLFS_VALORICMSITEM;
    const LFS_VALORICMSITEM_Name = 'LFS_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORFRETEITEM', ftBCD)]
    [Dictionary('LFS_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORFRETEITEM: Double read FLFS_VALORFRETEITEM write FLFS_VALORFRETEITEM;
    const LFS_VALORFRETEITEM_Name = 'LFS_VALORFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORSEGUROITEM', ftBCD)]
    [Dictionary('LFS_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORSEGUROITEM: Double read FLFS_VALORSEGUROITEM write FLFS_VALORSEGUROITEM;
    const LFS_VALORSEGUROITEM_Name = 'LFS_VALORSEGUROITEM';

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
    [Column('LFS_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSRNFITEM: Double read FLFS_VALORICMSRNFITEM write FLFS_VALORICMSRNFITEM;
    const LFS_VALORICMSRNFITEM_Name = 'LFS_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMSITEM: Double read FLFS_PERCENTUALICMSITEM write FLFS_PERCENTUALICMSITEM;
    const LFS_PERCENTUALICMSITEM_Name = 'LFS_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIPIITEM: Double read FLFS_PERCENTUALIPIITEM write FLFS_PERCENTUALIPIITEM;
    const LFS_PERCENTUALIPIITEM_Name = 'LFS_PERCENTUALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEOUTROSITEM: Double read FLFS_VALORBASEOUTROSITEM write FLFS_VALORBASEOUTROSITEM;
    const LFS_VALORBASEOUTROSITEM_Name = 'LFS_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEISENTOICMSITEM: Double read FLFS_VALORBASEISENTOICMSITEM write FLFS_VALORBASEISENTOICMSITEM;
    const LFS_VALORBASEISENTOICMSITEM_Name = 'LFS_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOMVAITEM: Double read FLFS_VALORBASECALCULOMVAITEM write FLFS_VALORBASECALCULOMVAITEM;
    const LFS_VALORBASECALCULOMVAITEM_Name = 'LFS_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMSITEM: Double read FLFS_VALORBASECALCULOICMSITEM write FLFS_VALORBASECALCULOICMSITEM;
    const LFS_VALORBASECALCULOICMSITEM_Name = 'LFS_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('LFS_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDESPACESSORIAITEM: Double read FLFS_VALORDESPACESSORIAITEM write FLFS_VALORDESPACESSORIAITEM;
    const LFS_VALORDESPACESSORIAITEM_Name = 'LFS_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('LFS_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPESOLIQUIDO: Double read FLFS_TOTALPESOLIQUIDO write FLFS_TOTALPESOLIQUIDO;
    const LFS_TOTALPESOLIQUIDO_Name = 'LFS_TOTALPESOLIQUIDO';

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

    [Restrictions([NoValidate])]
    [Column('PRO_VALORICMSR', ftBCD, 18, 4)]
    [Dictionary('PRO_VALORICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORICMSR: Double read FPRO_VALORICMSR write FPRO_VALORICMSR;
    const PRO_VALORICMSR_Name = 'PRO_VALORICMSR';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORBASECALCULOMVA', ftBCD, 18, 4)]
    [Dictionary('PRO_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORBASECALCULOMVA: Double read FPRO_VALORBASECALCULOMVA write FPRO_VALORBASECALCULOMVA;
    const PRO_VALORBASECALCULOMVA_Name = 'PRO_VALORBASECALCULOMVA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_LFS_01)

end.
