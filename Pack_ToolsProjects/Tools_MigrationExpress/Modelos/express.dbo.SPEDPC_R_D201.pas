unit express.dbo.SPEDPC_R_D201;

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
  [Table('SPEDPC_R_D201', '')]
  TDtoSPEDPC_R_D201 = class
  private
    { Private declarations } 
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FCOD_MOD: String;
    FSER: String;
    FCFOP: String;
    FDT_REF: TDateTime;
    FCST_PIS: String;
    FVL_ITEM: Double;
    FVL_BC_PIS: Double;
    FALIQ_PIS: Double;
    FVL_PIS: Double;
    FCOD_CTA: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_D201';

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
    [Column('CST_PIS', ftString, 2)]
    [Dictionary('CST_PIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_PIS: String read FCST_PIS write FCST_PIS;
    const CST_PIS_Name = 'CST_PIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ITEM', ftBCD)]
    [Dictionary('VL_ITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ITEM: Double read FVL_ITEM write FVL_ITEM;
    const VL_ITEM_Name = 'VL_ITEM';

    [Restrictions([NoValidate])]
    [Column('VL_BC_PIS', ftBCD)]
    [Dictionary('VL_BC_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_PIS: Double read FVL_BC_PIS write FVL_BC_PIS;
    const VL_BC_PIS_Name = 'VL_BC_PIS';

    [Restrictions([NoValidate])]
    [Column('ALIQ_PIS', ftBCD)]
    [Dictionary('ALIQ_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_PIS: Double read FALIQ_PIS write FALIQ_PIS;
    const ALIQ_PIS_Name = 'ALIQ_PIS';

    [Restrictions([NoValidate])]
    [Column('VL_PIS', ftBCD)]
    [Dictionary('VL_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PIS: Double read FVL_PIS write FVL_PIS;
    const VL_PIS_Name = 'VL_PIS';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_D201)

end.
