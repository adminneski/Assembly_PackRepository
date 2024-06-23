unit express.dbo.SPED_R_D500;

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
  [Table('SPED_R_D500', '')]
  TDtoSPED_R_D500 = class
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
    FSUB: String;
    FNUM_DOC: String;
    FDT_DOC: TDateTime;
    FDT_A_P: TDateTime;
    FVL_DOC: Double;
    FVL_DESC: Double;
    FVL_SERV: Double;
    FVL_SERV_NT: Double;
    FVL_TERC: Integer;
    FVL_DA: Integer;
    FVL_BC_ICMS: Double;
    FVL_ICMS: Double;
    FCOD_INF: String;
    FVL_PIS: Double;
    FVL_COFINS: Double;
    FCOD_CTA: String;
    FTP_ASSINANTE: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_D500';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_A_P', ftDateTime)]
    [Dictionary('DT_A_P', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    const DT_A_P_Name = 'DT_A_P';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DOC', ftBCD)]
    [Dictionary('VL_DOC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DOC: Double read FVL_DOC write FVL_DOC;
    const VL_DOC_Name = 'VL_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DESC', ftBCD)]
    [Dictionary('VL_DESC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DESC: Double read FVL_DESC write FVL_DESC;
    const VL_DESC_Name = 'VL_DESC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_SERV', ftBCD)]
    [Dictionary('VL_SERV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_SERV: Double read FVL_SERV write FVL_SERV;
    const VL_SERV_Name = 'VL_SERV';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_SERV_NT', ftBCD)]
    [Dictionary('VL_SERV_NT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_SERV_NT: Double read FVL_SERV_NT write FVL_SERV_NT;
    const VL_SERV_NT_Name = 'VL_SERV_NT';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TERC', ftInteger)]
    [Dictionary('VL_TERC', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TERC: Integer read FVL_TERC write FVL_TERC;
    const VL_TERC_Name = 'VL_TERC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DA', ftInteger)]
    [Dictionary('VL_DA', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_DA: Integer read FVL_DA write FVL_DA;
    const VL_DA_Name = 'VL_DA';

    [Restrictions([NoValidate])]
    [Column('VL_BC_ICMS', ftBCD, 48, 2)]
    [Dictionary('VL_BC_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_ICMS: Double read FVL_BC_ICMS write FVL_BC_ICMS;
    const VL_BC_ICMS_Name = 'VL_BC_ICMS';

    [Restrictions([NoValidate])]
    [Column('VL_ICMS', ftBCD)]
    [Dictionary('VL_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ICMS: Double read FVL_ICMS write FVL_ICMS;
    const VL_ICMS_Name = 'VL_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_INF', ftString, 1)]
    [Dictionary('COD_INF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_INF: String read FCOD_INF write FCOD_INF;
    const COD_INF_Name = 'COD_INF';

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
    [Column('COD_CTA', ftString, 1)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('TP_ASSINANTE', ftString, 1)]
    [Dictionary('TP_ASSINANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TP_ASSINANTE: String read FTP_ASSINANTE write FTP_ASSINANTE;
    const TP_ASSINANTE_Name = 'TP_ASSINANTE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_D500)

end.
