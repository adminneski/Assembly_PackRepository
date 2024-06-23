unit express.dbo.SPED_R_C500;

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
  [Table('SPED_R_C500', '')]
  TDtoSPED_R_C500 = class
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
    FCOD_CONS: String;
    FNUM_DOC: String;
    FDT_DOC: TDateTime;
    FDT_E_S: TDateTime;
    FVL_DOC: Double;
    FVL_DESC: Double;
    FVL_FORN: Double;
    FVL_SERV_NT: Double;
    FVL_TERC: Integer;
    FVL_DA: Integer;
    FVL_BC_ICMS: Integer;
    FVL_ICMS: Integer;
    FVL_BC_ICMS_ST: Integer;
    FVL_ICMS_ST: Integer;
    FCOD_INF: String;
    FVL_PIS: Integer;
    FVL_COFINS: Integer;
    FTP_LIGACAO: String;
    FCOD_GRUPO_TENSAO: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_C500';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_CONS', ftString, 2)]
    [Dictionary('COD_CONS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CONS: String read FCOD_CONS write FCOD_CONS;
    const COD_CONS_Name = 'COD_CONS';

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
    [Column('DT_E_S', ftDateTime)]
    [Dictionary('DT_E_S', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_E_S: TDateTime read FDT_E_S write FDT_E_S;
    const DT_E_S_Name = 'DT_E_S';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DOC', ftBCD)]
    [Dictionary('VL_DOC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DOC: Double read FVL_DOC write FVL_DOC;
    const VL_DOC_Name = 'VL_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DESC', ftBCD, 10, 2)]
    [Dictionary('VL_DESC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DESC: Double read FVL_DESC write FVL_DESC;
    const VL_DESC_Name = 'VL_DESC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_FORN', ftBCD, 10, 2)]
    [Dictionary('VL_FORN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_FORN: Double read FVL_FORN write FVL_FORN;
    const VL_FORN_Name = 'VL_FORN';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_BC_ICMS', ftInteger)]
    [Dictionary('VL_BC_ICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_BC_ICMS: Integer read FVL_BC_ICMS write FVL_BC_ICMS;
    const VL_BC_ICMS_Name = 'VL_BC_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ICMS', ftInteger)]
    [Dictionary('VL_ICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_ICMS: Integer read FVL_ICMS write FVL_ICMS;
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
    [Column('COD_INF', ftString, 1)]
    [Dictionary('COD_INF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_INF: String read FCOD_INF write FCOD_INF;
    const COD_INF_Name = 'COD_INF';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_PIS', ftInteger)]
    [Dictionary('VL_PIS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_PIS: Integer read FVL_PIS write FVL_PIS;
    const VL_PIS_Name = 'VL_PIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_COFINS', ftInteger)]
    [Dictionary('VL_COFINS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_COFINS: Integer read FVL_COFINS write FVL_COFINS;
    const VL_COFINS_Name = 'VL_COFINS';

    [Restrictions([NoValidate])]
    [Column('TP_LIGACAO', ftString, 1)]
    [Dictionary('TP_LIGACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TP_LIGACAO: String read FTP_LIGACAO write FTP_LIGACAO;
    const TP_LIGACAO_Name = 'TP_LIGACAO';

    [Restrictions([NoValidate])]
    [Column('COD_GRUPO_TENSAO', ftString, 2)]
    [Dictionary('COD_GRUPO_TENSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_GRUPO_TENSAO: String read FCOD_GRUPO_TENSAO write FCOD_GRUPO_TENSAO;
    const COD_GRUPO_TENSAO_Name = 'COD_GRUPO_TENSAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_C500)

end.
