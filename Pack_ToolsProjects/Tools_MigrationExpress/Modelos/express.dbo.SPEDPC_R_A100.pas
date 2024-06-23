unit express.dbo.SPEDPC_R_A100;

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
  [Table('SPEDPC_R_A100', '')]
  TDtoSPEDPC_R_A100 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FTIPO_DOC: String;
    FID_DOC: Integer;
    FIND_OPER: String;
    FIND_EMIT: String;
    FCOD_PART: Integer;
    FCOD_SIT: String;
    FSER: String;
    FSUB: String;
    FNUM_DOC: String;
    FCHV_NFSE: String;
    FDT_DOC: TDateTime;
    FDT_EXE_SERV: TDateTime;
    FVL_DOC: Double;
    FIND_PGTO: String;
    FVL_DESC: Double;
    FVL_BC_PIS: Double;
    FVL_PIS: Double;
    FVL_BC_COFINS: Double;
    FVL_COFINS: Double;
    FVL_PIS_RET: Double;
    FVL_COFINS_RE: Double;
    FVL_ISS: Double;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_A100';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('SUB', ftString, 1)]
    [Dictionary('SUB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SUB: String read FSUB write FSUB;
    const SUB_Name = 'SUB';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

    [Restrictions([NoValidate])]
    [Column('CHV_NFSE', ftString, 44)]
    [Dictionary('CHV_NFSE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CHV_NFSE: String read FCHV_NFSE write FCHV_NFSE;
    const CHV_NFSE_Name = 'CHV_NFSE';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate])]
    [Column('DT_EXE_SERV', ftDateTime)]
    [Dictionary('DT_EXE_SERV', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_EXE_SERV: TDateTime read FDT_EXE_SERV write FDT_EXE_SERV;
    const DT_EXE_SERV_Name = 'DT_EXE_SERV';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DOC', ftBCD, 10, 2)]
    [Dictionary('VL_DOC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DOC: Double read FVL_DOC write FVL_DOC;
    const VL_DOC_Name = 'VL_DOC';

    [Restrictions([NoValidate])]
    [Column('IND_PGTO', ftString, 1)]
    [Dictionary('IND_PGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_PGTO: String read FIND_PGTO write FIND_PGTO;
    const IND_PGTO_Name = 'IND_PGTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DESC', ftBCD)]
    [Dictionary('VL_DESC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DESC: Double read FVL_DESC write FVL_DESC;
    const VL_DESC_Name = 'VL_DESC';

    [Restrictions([NoValidate])]
    [Column('VL_BC_PIS', ftBCD)]
    [Dictionary('VL_BC_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_PIS: Double read FVL_BC_PIS write FVL_BC_PIS;
    const VL_BC_PIS_Name = 'VL_BC_PIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_PIS', ftBCD)]
    [Dictionary('VL_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PIS: Double read FVL_PIS write FVL_PIS;
    const VL_PIS_Name = 'VL_PIS';

    [Restrictions([NoValidate])]
    [Column('VL_BC_COFINS', ftBCD)]
    [Dictionary('VL_BC_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_COFINS: Double read FVL_BC_COFINS write FVL_BC_COFINS;
    const VL_BC_COFINS_Name = 'VL_BC_COFINS';

    [Restrictions([NoValidate])]
    [Column('VL_COFINS', ftBCD, 48, 2)]
    [Dictionary('VL_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_COFINS: Double read FVL_COFINS write FVL_COFINS;
    const VL_COFINS_Name = 'VL_COFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_PIS_RET', ftBCD)]
    [Dictionary('VL_PIS_RET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PIS_RET: Double read FVL_PIS_RET write FVL_PIS_RET;
    const VL_PIS_RET_Name = 'VL_PIS_RET';

    [Restrictions([NoValidate])]
    [Column('VL_COFINS_RE', ftBCD)]
    [Dictionary('VL_COFINS_RE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_COFINS_RE: Double read FVL_COFINS_RE write FVL_COFINS_RE;
    const VL_COFINS_RE_Name = 'VL_COFINS_RE';

    [Restrictions([NoValidate])]
    [Column('VL_ISS', ftBCD)]
    [Dictionary('VL_ISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ISS: Double read FVL_ISS write FVL_ISS;
    const VL_ISS_Name = 'VL_ISS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_A100)

end.
