unit express.dbo.SPED_R_G125;

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
  [Table('SPED_R_G125', '')]
  TDtoSPED_R_G125 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FCOD_IND_BEM: Integer;
    FDT_MOV: TDateTime;
    FTIPO_MOV: String;
    FVL_IMOB_ICMS_OP: Double;
    FVL_IMOB_ICMS_ST: Double;
    FVL_IMOB_ICMS_FRT: Double;
    FVL_IMOB_ICMS_DIF: Double;
    FNUM_PARC: Integer;
    FVL_PARC_PASS: Double;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_G125';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_IND_BEM', ftInteger)]
    [Dictionary('COD_IND_BEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_IND_BEM: Integer read FCOD_IND_BEM write FCOD_IND_BEM;
    const COD_IND_BEM_Name = 'COD_IND_BEM';

    [Restrictions([NoValidate])]
    [Column('DT_MOV', ftDateTime)]
    [Dictionary('DT_MOV', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_MOV: TDateTime read FDT_MOV write FDT_MOV;
    const DT_MOV_Name = 'DT_MOV';

    [Restrictions([NoValidate])]
    [Column('TIPO_MOV', ftString, 2)]
    [Dictionary('TIPO_MOV', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_MOV: String read FTIPO_MOV write FTIPO_MOV;
    const TIPO_MOV_Name = 'TIPO_MOV';

    [Restrictions([NoValidate])]
    [Column('VL_IMOB_ICMS_OP', ftBCD, 10, 2)]
    [Dictionary('VL_IMOB_ICMS_OP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_IMOB_ICMS_OP: Double read FVL_IMOB_ICMS_OP write FVL_IMOB_ICMS_OP;
    const VL_IMOB_ICMS_OP_Name = 'VL_IMOB_ICMS_OP';

    [Restrictions([NoValidate])]
    [Column('VL_IMOB_ICMS_ST', ftBCD)]
    [Dictionary('VL_IMOB_ICMS_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_IMOB_ICMS_ST: Double read FVL_IMOB_ICMS_ST write FVL_IMOB_ICMS_ST;
    const VL_IMOB_ICMS_ST_Name = 'VL_IMOB_ICMS_ST';

    [Restrictions([NoValidate])]
    [Column('VL_IMOB_ICMS_FRT', ftBCD)]
    [Dictionary('VL_IMOB_ICMS_FRT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_IMOB_ICMS_FRT: Double read FVL_IMOB_ICMS_FRT write FVL_IMOB_ICMS_FRT;
    const VL_IMOB_ICMS_FRT_Name = 'VL_IMOB_ICMS_FRT';

    [Restrictions([NoValidate])]
    [Column('VL_IMOB_ICMS_DIF', ftBCD)]
    [Dictionary('VL_IMOB_ICMS_DIF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_IMOB_ICMS_DIF: Double read FVL_IMOB_ICMS_DIF write FVL_IMOB_ICMS_DIF;
    const VL_IMOB_ICMS_DIF_Name = 'VL_IMOB_ICMS_DIF';

    [Restrictions([NoValidate])]
    [Column('NUM_PARC', ftInteger)]
    [Dictionary('NUM_PARC', 'Mensagem de validação', '0', '', '', taCenter)]
    property NUM_PARC: Integer read FNUM_PARC write FNUM_PARC;
    const NUM_PARC_Name = 'NUM_PARC';

    [Restrictions([NoValidate])]
    [Column('VL_PARC_PASS', ftBCD, 10, 2)]
    [Dictionary('VL_PARC_PASS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PARC_PASS: Double read FVL_PARC_PASS write FVL_PARC_PASS;
    const VL_PARC_PASS_Name = 'VL_PARC_PASS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_G125)

end.
