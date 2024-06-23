unit express.dbo.SPEDPC_R_D200;

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
  [Table('SPEDPC_R_D200', '')]
  TDtoSPEDPC_R_D200 = class
  private
    { Private declarations } 
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FCOD_MOD: String;
    FCOD_SIT: String;
    FSER: String;
    FSUB: String;
    FNUM_DOC_INI: String;
    FNUM_DOC_FIN: String;
    FCFOP: String;
    FDT_REF: TDateTime;
    FVL_DOC: Double;
    FVL_DESC: Double;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_D200';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

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
    [Column('NUM_DOC_INI', ftString, 9)]
    [Dictionary('NUM_DOC_INI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC_INI: String read FNUM_DOC_INI write FNUM_DOC_INI;
    const NUM_DOC_INI_Name = 'NUM_DOC_INI';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC_FIN', ftString, 9)]
    [Dictionary('NUM_DOC_FIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC_FIN: String read FNUM_DOC_FIN write FNUM_DOC_FIN;
    const NUM_DOC_FIN_Name = 'NUM_DOC_FIN';

    [Restrictions([NoValidate])]
    [Column('CFOP', ftString, 4)]
    [Dictionary('CFOP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP: String read FCFOP write FCFOP;
    const CFOP_Name = 'CFOP';

    [Restrictions([NoValidate])]
    [Column('DT_REF', ftDateTime)]
    [Dictionary('DT_REF', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
    const DT_REF_Name = 'DT_REF';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_D200)

end.
