unit express.dbo.SPEDPC_R_1700;

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
  [Table('SPEDPC_R_1700', '')]
  TDtoSPEDPC_R_1700 = class
  private
    { Private declarations } 
    FTIPO: String;
    FCOM_CODIGO: Integer;
    FIND_NAT_RET: String;
    FPR_REC_RET: String;
    FVL_RET_APU: Double;
    FVL_RET_DED: Double;
    FVL_RET_PER: Integer;
    FVL_RET_DCOMP: Integer;
    FSLD_RET: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_1700';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO', ftString, 3)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO: String read FTIPO write FTIPO;
    const TIPO_Name = 'TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_NAT_RET', ftString, 2)]
    [Dictionary('IND_NAT_RET', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_NAT_RET: String read FIND_NAT_RET write FIND_NAT_RET;
    const IND_NAT_RET_Name = 'IND_NAT_RET';

    [Restrictions([NoValidate])]
    [Column('PR_REC_RET', ftString, 6)]
    [Dictionary('PR_REC_RET', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PR_REC_RET: String read FPR_REC_RET write FPR_REC_RET;
    const PR_REC_RET_Name = 'PR_REC_RET';

    [Restrictions([NoValidate])]
    [Column('VL_RET_APU', ftBCD)]
    [Dictionary('VL_RET_APU', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_RET_APU: Double read FVL_RET_APU write FVL_RET_APU;
    const VL_RET_APU_Name = 'VL_RET_APU';

    [Restrictions([NoValidate])]
    [Column('VL_RET_DED', ftBCD)]
    [Dictionary('VL_RET_DED', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_RET_DED: Double read FVL_RET_DED write FVL_RET_DED;
    const VL_RET_DED_Name = 'VL_RET_DED';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_RET_PER', ftInteger)]
    [Dictionary('VL_RET_PER', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_RET_PER: Integer read FVL_RET_PER write FVL_RET_PER;
    const VL_RET_PER_Name = 'VL_RET_PER';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_RET_DCOMP', ftInteger)]
    [Dictionary('VL_RET_DCOMP', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_RET_DCOMP: Integer read FVL_RET_DCOMP write FVL_RET_DCOMP;
    const VL_RET_DCOMP_Name = 'VL_RET_DCOMP';

    [Restrictions([NoValidate, NotNull])]
    [Column('SLD_RET', ftInteger)]
    [Dictionary('SLD_RET', 'Mensagem de validação', '0', '', '', taCenter)]
    property SLD_RET: Integer read FSLD_RET write FSLD_RET;
    const SLD_RET_Name = 'SLD_RET';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_1700)

end.
