unit express.dbo.SPED_R_C190;

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
  [Table('SPED_R_C190', '')]
  TDtoSPED_R_C190 = class
  private
    { Private declarations } 
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FID_DOC: Integer;
    FCST_ICMS: String;
    FCFOP: String;
    FALIQ_ICMS: Double;
    FVL_OPR: Double;
    FVL_BC_ICMS: Double;
    FVL_ICMS: Double;
    FVL_BC_ICMS_ST: Double;
    FVL_ICMS_ST: Double;
    FVL_RED_BC: Double;
    FVL_IPI: Double;
    FCOD_OBS: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_C190';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de valida��o', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ID_DOC', ftInteger)]
    [Dictionary('ID_DOC', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property ID_DOC: Integer read FID_DOC write FID_DOC;
    const ID_DOC_Name = 'ID_DOC';

    [Restrictions([NoValidate])]
    [Column('CST_ICMS', ftString, 2)]
    [Dictionary('CST_ICMS', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_ICMS: String read FCST_ICMS write FCST_ICMS;
    const CST_ICMS_Name = 'CST_ICMS';

    [Restrictions([NoValidate])]
    [Column('CFOP', ftString, 4)]
    [Dictionary('CFOP', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CFOP: String read FCFOP write FCFOP;
    const CFOP_Name = 'CFOP';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALIQ_ICMS', ftBCD)]
    [Dictionary('ALIQ_ICMS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property ALIQ_ICMS: Double read FALIQ_ICMS write FALIQ_ICMS;
    const ALIQ_ICMS_Name = 'ALIQ_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_OPR', ftBCD, 10, 2)]
    [Dictionary('VL_OPR', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VL_OPR: Double read FVL_OPR write FVL_OPR;
    const VL_OPR_Name = 'VL_OPR';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_BC_ICMS', ftBCD, 10, 2)]
    [Dictionary('VL_BC_ICMS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VL_BC_ICMS: Double read FVL_BC_ICMS write FVL_BC_ICMS;
    const VL_BC_ICMS_Name = 'VL_BC_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ICMS', ftBCD)]
    [Dictionary('VL_ICMS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VL_ICMS: Double read FVL_ICMS write FVL_ICMS;
    const VL_ICMS_Name = 'VL_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_BC_ICMS_ST', ftBCD)]
    [Dictionary('VL_BC_ICMS_ST', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VL_BC_ICMS_ST: Double read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    const VL_BC_ICMS_ST_Name = 'VL_BC_ICMS_ST';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ICMS_ST', ftBCD)]
    [Dictionary('VL_ICMS_ST', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VL_ICMS_ST: Double read FVL_ICMS_ST write FVL_ICMS_ST;
    const VL_ICMS_ST_Name = 'VL_ICMS_ST';

    [Restrictions([NoValidate])]
    [Column('VL_RED_BC', ftBCD)]
    [Dictionary('VL_RED_BC', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VL_RED_BC: Double read FVL_RED_BC write FVL_RED_BC;
    const VL_RED_BC_Name = 'VL_RED_BC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_IPI', ftBCD)]
    [Dictionary('VL_IPI', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property VL_IPI: Double read FVL_IPI write FVL_IPI;
    const VL_IPI_Name = 'VL_IPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_OBS', ftString, 1)]
    [Dictionary('COD_OBS', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property COD_OBS: String read FCOD_OBS write FCOD_OBS;
    const COD_OBS_Name = 'COD_OBS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_C190)

end.