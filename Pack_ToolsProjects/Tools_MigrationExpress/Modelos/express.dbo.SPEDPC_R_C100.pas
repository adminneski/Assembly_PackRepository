unit express.dbo.SPEDPC_R_C100;

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
  [Table('SPEDPC_R_C100', '')]
  TDtoSPEDPC_R_C100 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FTIPO_DOC: String;
    FID_DOC: Integer;
    FIND_OPER: String;
    FIND_EMIT: String;
    FCOD_PART: Integer;
    FCOD_MOD: String;
    FCOD_SIT: String;
    FSER: String;
    FNUM_DOC: String;
    FCHV_NFE: String;
    FDT_DOC: TDateTime;
    FDT_E_S: TDateTime;
    FVL_DOC: Double;
    FIND_PGTO: String;
    FVL_DESC: Double;
    FVL_ABAT_NT: Integer;
    FVL_MERC: Double;
    FIND_FRT: String;
    FVL_FRT: Double;
    FVL_SEG: Double;
    FVL_OUT_DA: Double;
    FVL_BC_ICMS: Double;
    FVL_ICMS: Double;
    FVL_BC_ICMS_ST: Double;
    FVL_ICMS_ST: Double;
    FVL_IPI: Double;
    FVL_PIS: Double;
    FVL_COFINS: Double;
    FVL_PIS_ST: Double;
    FVL_COFINS_ST: Double;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_C100';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_OPER', ftString, 1)]
    [Dictionary('IND_OPER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_OPER: String read FIND_OPER write FIND_OPER;
    const IND_OPER_Name = 'IND_OPER';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_EMIT', ftString, 1)]
    [Dictionary('IND_EMIT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_EMIT: String read FIND_EMIT write FIND_EMIT;
    const IND_EMIT_Name = 'IND_EMIT';

    [Restrictions([NoValidate])]
    [Column('COD_PART', ftInteger)]
    [Dictionary('COD_PART', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_PART: Integer read FCOD_PART write FCOD_PART;
    const COD_PART_Name = 'COD_PART';

    [Restrictions([NoValidate])]
    [Column('COD_MOD', ftString, 2)]
    [Dictionary('COD_MOD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    const COD_MOD_Name = 'COD_MOD';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_SIT', ftString, 2)]
    [Dictionary('COD_SIT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_SIT: String read FCOD_SIT write FCOD_SIT;
    const COD_SIT_Name = 'COD_SIT';

    [Restrictions([NoValidate])]
    [Column('SER', ftString, 3)]
    [Dictionary('SER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SER: String read FSER write FSER;
    const SER_Name = 'SER';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CHV_NFE', ftString, 44)]
    [Dictionary('CHV_NFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CHV_NFE: String read FCHV_NFE write FCHV_NFE;
    const CHV_NFE_Name = 'CHV_NFE';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate])]
    [Column('DT_E_S', ftDateTime)]
    [Dictionary('DT_E_S', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_E_S: TDateTime read FDT_E_S write FDT_E_S;
    const DT_E_S_Name = 'DT_E_S';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DOC', ftBCD)]
    [Dictionary('VL_DOC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DOC: Double read FVL_DOC write FVL_DOC;
    const VL_DOC_Name = 'VL_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_PGTO', ftString, 1)]
    [Dictionary('IND_PGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_PGTO: String read FIND_PGTO write FIND_PGTO;
    const IND_PGTO_Name = 'IND_PGTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DESC', ftBCD, 10, 2)]
    [Dictionary('VL_DESC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DESC: Double read FVL_DESC write FVL_DESC;
    const VL_DESC_Name = 'VL_DESC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ABAT_NT', ftInteger)]
    [Dictionary('VL_ABAT_NT', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_ABAT_NT: Integer read FVL_ABAT_NT write FVL_ABAT_NT;
    const VL_ABAT_NT_Name = 'VL_ABAT_NT';

    [Restrictions([NoValidate])]
    [Column('VL_MERC', ftBCD)]
    [Dictionary('VL_MERC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_MERC: Double read FVL_MERC write FVL_MERC;
    const VL_MERC_Name = 'VL_MERC';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_FRT', ftString, 1)]
    [Dictionary('IND_FRT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_FRT: String read FIND_FRT write FIND_FRT;
    const IND_FRT_Name = 'IND_FRT';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_FRT', ftBCD)]
    [Dictionary('VL_FRT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_FRT: Double read FVL_FRT write FVL_FRT;
    const VL_FRT_Name = 'VL_FRT';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_SEG', ftBCD)]
    [Dictionary('VL_SEG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_SEG: Double read FVL_SEG write FVL_SEG;
    const VL_SEG_Name = 'VL_SEG';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_OUT_DA', ftBCD, 48, 2)]
    [Dictionary('VL_OUT_DA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_OUT_DA: Double read FVL_OUT_DA write FVL_OUT_DA;
    const VL_OUT_DA_Name = 'VL_OUT_DA';

    [Restrictions([NoValidate])]
    [Column('VL_BC_ICMS', ftBCD)]
    [Dictionary('VL_BC_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_ICMS: Double read FVL_BC_ICMS write FVL_BC_ICMS;
    const VL_BC_ICMS_Name = 'VL_BC_ICMS';

    [Restrictions([NoValidate])]
    [Column('VL_ICMS', ftBCD)]
    [Dictionary('VL_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ICMS: Double read FVL_ICMS write FVL_ICMS;
    const VL_ICMS_Name = 'VL_ICMS';

    [Restrictions([NoValidate])]
    [Column('VL_BC_ICMS_ST', ftBCD)]
    [Dictionary('VL_BC_ICMS_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_ICMS_ST: Double read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    const VL_BC_ICMS_ST_Name = 'VL_BC_ICMS_ST';

    [Restrictions([NoValidate])]
    [Column('VL_ICMS_ST', ftBCD)]
    [Dictionary('VL_ICMS_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ICMS_ST: Double read FVL_ICMS_ST write FVL_ICMS_ST;
    const VL_ICMS_ST_Name = 'VL_ICMS_ST';

    [Restrictions([NoValidate])]
    [Column('VL_IPI', ftBCD)]
    [Dictionary('VL_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_IPI: Double read FVL_IPI write FVL_IPI;
    const VL_IPI_Name = 'VL_IPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_PIS', ftBCD)]
    [Dictionary('VL_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PIS: Double read FVL_PIS write FVL_PIS;
    const VL_PIS_Name = 'VL_PIS';

    [Restrictions([NoValidate])]
    [Column('VL_COFINS', ftBCD)]
    [Dictionary('VL_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_COFINS: Double read FVL_COFINS write FVL_COFINS;
    const VL_COFINS_Name = 'VL_COFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_PIS_ST', ftBCD)]
    [Dictionary('VL_PIS_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PIS_ST: Double read FVL_PIS_ST write FVL_PIS_ST;
    const VL_PIS_ST_Name = 'VL_PIS_ST';

    [Restrictions([NoValidate])]
    [Column('VL_COFINS_ST', ftBCD)]
    [Dictionary('VL_COFINS_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_COFINS_ST: Double read FVL_COFINS_ST write FVL_COFINS_ST;
    const VL_COFINS_ST_Name = 'VL_COFINS_ST';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_C100)

end.
