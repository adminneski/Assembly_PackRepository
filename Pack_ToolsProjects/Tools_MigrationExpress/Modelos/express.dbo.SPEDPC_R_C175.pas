unit express.dbo.SPEDPC_R_C175;

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
  [Table('SPEDPC_R_C175', '')]
  TDtoSPEDPC_R_C175 = class
  private
    { Private declarations } 
    FTIPO_DOC: String;
    FCOM_CODIGO: Integer;
    FID_DOC: Integer;
    FCFOP: String;
    FVL_OPR: Double;
    FVL_DESC: Double;
    FCST_PIS: String;
    FVL_BC_PIS: Double;
    FALIQ_PIS: Double;
    FQUANT_BC_PIS: Integer;
    FALIQ_PIS_QUANT: Integer;
    FVL_PIS: Double;
    FCST_COFINS: String;
    FVL_BC_COFINS: Double;
    FALIQ_COFINS: Double;
    FQUANT_BC_COFINS: Integer;
    FALIQ_COFINS_QUANT: Integer;
    FVL_COFINS: Double;
    FCOD_CTA: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_C175';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP', ftString, 4)]
    [Dictionary('CFOP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP: String read FCFOP write FCFOP;
    const CFOP_Name = 'CFOP';

    [Restrictions([NoValidate])]
    [Column('VL_OPR', ftBCD)]
    [Dictionary('VL_OPR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_OPR: Double read FVL_OPR write FVL_OPR;
    const VL_OPR_Name = 'VL_OPR';

    [Restrictions([NoValidate])]
    [Column('VL_DESC', ftBCD)]
    [Dictionary('VL_DESC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DESC: Double read FVL_DESC write FVL_DESC;
    const VL_DESC_Name = 'VL_DESC';

    [Restrictions([NoValidate])]
    [Column('CST_PIS', ftString, 2)]
    [Dictionary('CST_PIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_PIS: String read FCST_PIS write FCST_PIS;
    const CST_PIS_Name = 'CST_PIS';

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
    [Column('QUANT_BC_PIS', ftInteger)]
    [Dictionary('QUANT_BC_PIS', 'Mensagem de validação', '0', '', '', taCenter)]
    property QUANT_BC_PIS: Integer read FQUANT_BC_PIS write FQUANT_BC_PIS;
    const QUANT_BC_PIS_Name = 'QUANT_BC_PIS';

    [Restrictions([NoValidate])]
    [Column('ALIQ_PIS_QUANT', ftInteger)]
    [Dictionary('ALIQ_PIS_QUANT', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALIQ_PIS_QUANT: Integer read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    const ALIQ_PIS_QUANT_Name = 'ALIQ_PIS_QUANT';

    [Restrictions([NoValidate])]
    [Column('VL_PIS', ftBCD)]
    [Dictionary('VL_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PIS: Double read FVL_PIS write FVL_PIS;
    const VL_PIS_Name = 'VL_PIS';

    [Restrictions([NoValidate])]
    [Column('CST_COFINS', ftString, 2)]
    [Dictionary('CST_COFINS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_COFINS: String read FCST_COFINS write FCST_COFINS;
    const CST_COFINS_Name = 'CST_COFINS';

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
    [Column('QUANT_BC_COFINS', ftInteger)]
    [Dictionary('QUANT_BC_COFINS', 'Mensagem de validação', '0', '', '', taCenter)]
    property QUANT_BC_COFINS: Integer read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    const QUANT_BC_COFINS_Name = 'QUANT_BC_COFINS';

    [Restrictions([NoValidate])]
    [Column('ALIQ_COFINS_QUANT', ftInteger)]
    [Dictionary('ALIQ_COFINS_QUANT', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALIQ_COFINS_QUANT: Integer read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    const ALIQ_COFINS_QUANT_Name = 'ALIQ_COFINS_QUANT';

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
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_C175)

end.
