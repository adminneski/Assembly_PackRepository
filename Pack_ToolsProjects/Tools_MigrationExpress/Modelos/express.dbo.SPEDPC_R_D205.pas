unit express.dbo.SPEDPC_R_D205;

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
  [Table('SPEDPC_R_D205', '')]
  TDtoSPEDPC_R_D205 = class
  private
    { Private declarations } 
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FCOD_MOD: String;
    FSER: String;
    FCFOP: String;
    FDT_REF: TDateTime;
    FCST_COFINS: String;
    FVL_ITEM: Double;
    FVL_BC_COFINS: Double;
    FALIQ_COFINS: Double;
    FVL_COFINS: Double;
    FCOD_CTA: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_D205';

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

    [Restrictions([NoValidate])]
    [Column('SER', ftString, 3)]
    [Dictionary('SER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SER: String read FSER write FSER;
    const SER_Name = 'SER';

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

    [Restrictions([NoValidate])]
    [Column('CST_COFINS', ftString, 2)]
    [Dictionary('CST_COFINS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_COFINS: String read FCST_COFINS write FCST_COFINS;
    const CST_COFINS_Name = 'CST_COFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ITEM', ftBCD)]
    [Dictionary('VL_ITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ITEM: Double read FVL_ITEM write FVL_ITEM;
    const VL_ITEM_Name = 'VL_ITEM';

    [Restrictions([NoValidate])]
    [Column('VL_BC_COFINS', ftBCD)]
    [Dictionary('VL_BC_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_COFINS: Double read FVL_BC_COFINS write FVL_BC_COFINS;
    const VL_BC_COFINS_Name = 'VL_BC_COFINS';

    [Restrictions([NoValidate])]
    [Column('ALIQ_COFINS', ftBCD)]
    [Dictionary('ALIQ_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_COFINS: Double read FALIQ_COFINS write FALIQ_COFINS;
    const ALIQ_COFINS_Name = 'ALIQ_COFINS';

    [Restrictions([NoValidate])]
    [Column('VL_COFINS', ftBCD)]
    [Dictionary('VL_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_COFINS: Double read FVL_COFINS write FVL_COFINS;
    const VL_COFINS_Name = 'VL_COFINS';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_D205)

end.
