unit express.dbo.SPEDPC_R_P200;

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
  [Table('SPEDPC_R_P200', '')]
  TDtoSPEDPC_R_P200 = class
  private
    { Private declarations } 
    FTIPO: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FID_DOC: Integer;
    FDT_DOC: TDateTime;
    FPER_REF: String;
    FVL_TOT_CONT_APU: Double;
    FVL_TOT_AJ_REDUC: Integer;
    FVL_TOT_AJ_ACRES: Integer;
    FVL_TOT_CONT_DEV: Double;
    FCOD_REC: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_P200';

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
    [Column('PER_REF', ftString, 60)]
    [Dictionary('PER_REF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PER_REF: String read FPER_REF write FPER_REF;
    const PER_REF_Name = 'PER_REF';

    [Restrictions([NoValidate])]
    [Column('VL_TOT_CONT_APU', ftBCD)]
    [Dictionary('VL_TOT_CONT_APU', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_TOT_CONT_APU: Double read FVL_TOT_CONT_APU write FVL_TOT_CONT_APU;
    const VL_TOT_CONT_APU_Name = 'VL_TOT_CONT_APU';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_AJ_REDUC', ftInteger)]
    [Dictionary('VL_TOT_AJ_REDUC', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TOT_AJ_REDUC: Integer read FVL_TOT_AJ_REDUC write FVL_TOT_AJ_REDUC;
    const VL_TOT_AJ_REDUC_Name = 'VL_TOT_AJ_REDUC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_AJ_ACRES', ftInteger)]
    [Dictionary('VL_TOT_AJ_ACRES', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TOT_AJ_ACRES: Integer read FVL_TOT_AJ_ACRES write FVL_TOT_AJ_ACRES;
    const VL_TOT_AJ_ACRES_Name = 'VL_TOT_AJ_ACRES';

    [Restrictions([NoValidate])]
    [Column('VL_TOT_CONT_DEV', ftBCD)]
    [Dictionary('VL_TOT_CONT_DEV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_TOT_CONT_DEV: Double read FVL_TOT_CONT_DEV write FVL_TOT_CONT_DEV;
    const VL_TOT_CONT_DEV_Name = 'VL_TOT_CONT_DEV';

    [Restrictions([NoValidate])]
    [Column('COD_REC', ftString, 6)]
    [Dictionary('COD_REC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_REC: String read FCOD_REC write FCOD_REC;
    const COD_REC_Name = 'COD_REC';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_P200)

end.
