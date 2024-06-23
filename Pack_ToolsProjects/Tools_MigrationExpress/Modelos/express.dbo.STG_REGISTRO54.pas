unit express.dbo.STG_REGISTRO54;

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
  [Table('STG_REGISTRO54', '')]
  TDtoSTG_REGISTRO54 = class
  private
    { Private declarations } 
    FSTG_TIPO: String;
    FSTG_ID: Integer;
    FSTG_NOTAFISCAL: String;
    FCOM_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FPRO_CODIGO: Integer;
    FSTG_ORDEMITEM: Integer;
    FSTG_QUANTIDADE: Double;
    FSTG_VALORITEM: Double;
    FSTG_VALORIPIITEM: Double;
    FSTG_VALORDESCTOITEM: Double;
    FSTG_VALORBASECALCULOICMSITEM: Double;
    FSTG_VALORBASECALCULOMVAITEM: Double;
    FSTG_PERCENTUALICMSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO54';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TIPO', ftString, 3)]
    [Dictionary('STG_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPO: String read FSTG_TIPO write FSTG_TIPO;
    const STG_TIPO_Name = 'STG_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_ID', ftInteger)]
    [Dictionary('STG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ID: Integer read FSTG_ID write FSTG_ID;
    const STG_ID_Name = 'STG_ID';

    [Restrictions([NoValidate])]
    [Column('STG_NOTAFISCAL', ftString, 9)]
    [Dictionary('STG_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NOTAFISCAL: String read FSTG_NOTAFISCAL write FSTG_NOTAFISCAL;
    const STG_NOTAFISCAL_Name = 'STG_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_ORDEMITEM', ftInteger)]
    [Dictionary('STG_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ORDEMITEM: Integer read FSTG_ORDEMITEM write FSTG_ORDEMITEM;
    const STG_ORDEMITEM_Name = 'STG_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_QUANTIDADE', ftBCD, 18, 4)]
    [Dictionary('STG_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_QUANTIDADE: Double read FSTG_QUANTIDADE write FSTG_QUANTIDADE;
    const STG_QUANTIDADE_Name = 'STG_QUANTIDADE';

    [Restrictions([NoValidate])]
    [Column('STG_VALORITEM', ftBCD)]
    [Dictionary('STG_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORITEM: Double read FSTG_VALORITEM write FSTG_VALORITEM;
    const STG_VALORITEM_Name = 'STG_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('STG_VALORIPIITEM', ftBCD)]
    [Dictionary('STG_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORIPIITEM: Double read FSTG_VALORIPIITEM write FSTG_VALORIPIITEM;
    const STG_VALORIPIITEM_Name = 'STG_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('STG_VALORDESCTOITEM', ftBCD, 10, 2)]
    [Dictionary('STG_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORDESCTOITEM: Double read FSTG_VALORDESCTOITEM write FSTG_VALORDESCTOITEM;
    const STG_VALORDESCTOITEM_Name = 'STG_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('STG_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASECALCULOICMSITEM: Double read FSTG_VALORBASECALCULOICMSITEM write FSTG_VALORBASECALCULOICMSITEM;
    const STG_VALORBASECALCULOICMSITEM_Name = 'STG_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('STG_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASECALCULOMVAITEM: Double read FSTG_VALORBASECALCULOMVAITEM write FSTG_VALORBASECALCULOMVAITEM;
    const STG_VALORBASECALCULOMVAITEM_Name = 'STG_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('STG_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_PERCENTUALICMSITEM: Double read FSTG_PERCENTUALICMSITEM write FSTG_PERCENTUALICMSITEM;
    const STG_PERCENTUALICMSITEM_Name = 'STG_PERCENTUALICMSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO54)

end.
