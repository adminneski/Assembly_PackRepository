unit express.dbo.SPEDPC_R_P100;

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
  [Table('SPEDPC_R_P100', '')]
  TDtoSPEDPC_R_P100 = class
  private
    { Private declarations } 
    FTIPO: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FID_DOC: Integer;
    FDT_DOC: TDateTime;
    FVL_REC_TOT_EST: Double;
    FCOD_ATIV_ECON: String;
    FVL_REC_ATIV_ESTAB: Double;
    FVL_EXC: Integer;
    FVL_BC_CONT: Double;
    FALIQ_CONT: Double;
    FVL_CONT_APU: Double;
    FCOD_CTA: String;
    FINFO_COMPL: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_P100';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO', ftString, 3)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO: String read FTIPO write FTIPO;
    const TIPO_Name = 'TIPO';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ID_DOC', ftInteger)]
    [Dictionary('ID_DOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ID_DOC: Integer read FID_DOC write FID_DOC;
    const ID_DOC_Name = 'ID_DOC';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate])]
    [Column('VL_REC_TOT_EST', ftBCD)]
    [Dictionary('VL_REC_TOT_EST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_REC_TOT_EST: Double read FVL_REC_TOT_EST write FVL_REC_TOT_EST;
    const VL_REC_TOT_EST_Name = 'VL_REC_TOT_EST';

    [Restrictions([NoValidate])]
    [Column('COD_ATIV_ECON', ftString, 8)]
    [Dictionary('COD_ATIV_ECON', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_ATIV_ECON: String read FCOD_ATIV_ECON write FCOD_ATIV_ECON;
    const COD_ATIV_ECON_Name = 'COD_ATIV_ECON';

    [Restrictions([NoValidate])]
    [Column('VL_REC_ATIV_ESTAB', ftBCD)]
    [Dictionary('VL_REC_ATIV_ESTAB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_REC_ATIV_ESTAB: Double read FVL_REC_ATIV_ESTAB write FVL_REC_ATIV_ESTAB;
    const VL_REC_ATIV_ESTAB_Name = 'VL_REC_ATIV_ESTAB';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_EXC', ftInteger)]
    [Dictionary('VL_EXC', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_EXC: Integer read FVL_EXC write FVL_EXC;
    const VL_EXC_Name = 'VL_EXC';

    [Restrictions([NoValidate])]
    [Column('VL_BC_CONT', ftBCD)]
    [Dictionary('VL_BC_CONT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_CONT: Double read FVL_BC_CONT write FVL_BC_CONT;
    const VL_BC_CONT_Name = 'VL_BC_CONT';

    [Restrictions([NoValidate])]
    [Column('ALIQ_CONT', ftBCD)]
    [Dictionary('ALIQ_CONT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_CONT: Double read FALIQ_CONT write FALIQ_CONT;
    const ALIQ_CONT_Name = 'ALIQ_CONT';

    [Restrictions([NoValidate])]
    [Column('VL_CONT_APU', ftBCD, 48, 6)]
    [Dictionary('VL_CONT_APU', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_CONT_APU: Double read FVL_CONT_APU write FVL_CONT_APU;
    const VL_CONT_APU_Name = 'VL_CONT_APU';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate])]
    [Column('INFO_COMPL', ftString, 300)]
    [Dictionary('INFO_COMPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INFO_COMPL: String read FINFO_COMPL write FINFO_COMPL;
    const INFO_COMPL_Name = 'INFO_COMPL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_P100)

end.
