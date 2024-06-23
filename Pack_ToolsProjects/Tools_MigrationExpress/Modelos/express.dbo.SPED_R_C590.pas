unit express.dbo.SPED_R_C590;

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
  [Table('SPED_R_C590', '')]
  TDtoSPED_R_C590 = class
  private
    { Private declarations } 
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FTIPO_DOC: String;
    FID_DOC: Integer;
    FCST_ICMS: String;
    FCFOP: String;
    FALIQ_ICMS: Double;
    FVL_OPR: Double;
    FVL_BC_ICMS: Double;
    FVL_ICMS: Double;
    FVL_BC_ICMS_ST: Integer;
    FVL_ICMS_ST: Integer;
    FVL_RED_BC: Integer;
    FCOD_OBS: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_C590';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ID_DOC', ftInteger)]
    [Dictionary('ID_DOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ID_DOC: Integer read FID_DOC write FID_DOC;
    const ID_DOC_Name = 'ID_DOC';

    [Restrictions([NoValidate])]
    [Column('CST_ICMS', ftString, 2)]
    [Dictionary('CST_ICMS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_ICMS: String read FCST_ICMS write FCST_ICMS;
    const CST_ICMS_Name = 'CST_ICMS';

    [Restrictions([NoValidate])]
    [Column('CFOP', ftString, 4)]
    [Dictionary('CFOP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP: String read FCFOP write FCFOP;
    const CFOP_Name = 'CFOP';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALIQ_ICMS', ftBCD, 10, 2)]
    [Dictionary('ALIQ_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_ICMS: Double read FALIQ_ICMS write FALIQ_ICMS;
    const ALIQ_ICMS_Name = 'ALIQ_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_OPR', ftBCD, 10, 2)]
    [Dictionary('VL_OPR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_OPR: Double read FVL_OPR write FVL_OPR;
    const VL_OPR_Name = 'VL_OPR';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_BC_ICMS', ftBCD)]
    [Dictionary('VL_BC_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_ICMS: Double read FVL_BC_ICMS write FVL_BC_ICMS;
    const VL_BC_ICMS_Name = 'VL_BC_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ICMS', ftBCD)]
    [Dictionary('VL_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ICMS: Double read FVL_ICMS write FVL_ICMS;
    const VL_ICMS_Name = 'VL_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_BC_ICMS_ST', ftInteger)]
    [Dictionary('VL_BC_ICMS_ST', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_BC_ICMS_ST: Integer read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    const VL_BC_ICMS_ST_Name = 'VL_BC_ICMS_ST';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ICMS_ST', ftInteger)]
    [Dictionary('VL_ICMS_ST', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_ICMS_ST: Integer read FVL_ICMS_ST write FVL_ICMS_ST;
    const VL_ICMS_ST_Name = 'VL_ICMS_ST';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_RED_BC', ftInteger)]
    [Dictionary('VL_RED_BC', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_RED_BC: Integer read FVL_RED_BC write FVL_RED_BC;
    const VL_RED_BC_Name = 'VL_RED_BC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_OBS', ftString, 1)]
    [Dictionary('COD_OBS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_OBS: String read FCOD_OBS write FCOD_OBS;
    const COD_OBS_Name = 'COD_OBS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_C590)

end.
