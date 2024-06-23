unit express.dbo.SPEDPC_R_F550;

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
  [Table('SPEDPC_R_F550', '')]
  TDtoSPEDPC_R_F550 = class
  private
    { Private declarations } 
    FTIPO: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FID_DOC: Integer;
    FDT_DOC: TDateTime;
    FVL_REC_COMP: Double;
    FCST_PIS: String;
    FVL_DESC_PIS: Integer;
    FVL_BC_PIS: Double;
    FALIQ_PIS: Double;
    FVL_PIS: Double;
    FCST_COFINS: String;
    FVL_DESC_COFINS: Integer;
    FVL_BC_COFINS: Double;
    FALIQ_COFINS: Double;
    FVL_COFINS: Double;
    FCOD_MOD: String;
    FCFOP: String;
    FCOD_CTA: String;
    FINFO_COMPL: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_F550';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO', ftString, 3)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO: String read FTIPO write FTIPO;
    const TIPO_Name = 'TIPO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('ID_DOC', ftInteger)]
    [Dictionary('ID_DOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ID_DOC: Integer read FID_DOC write FID_DOC;
    const ID_DOC_Name = 'ID_DOC';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_REC_COMP', ftBCD)]
    [Dictionary('VL_REC_COMP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_REC_COMP: Double read FVL_REC_COMP write FVL_REC_COMP;
    const VL_REC_COMP_Name = 'VL_REC_COMP';

    [Restrictions([NoValidate])]
    [Column('CST_PIS', ftString, 2)]
    [Dictionary('CST_PIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_PIS: String read FCST_PIS write FCST_PIS;
    const CST_PIS_Name = 'CST_PIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DESC_PIS', ftInteger)]
    [Dictionary('VL_DESC_PIS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_DESC_PIS: Integer read FVL_DESC_PIS write FVL_DESC_PIS;
    const VL_DESC_PIS_Name = 'VL_DESC_PIS';

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
    [Column('CST_COFINS', ftString, 2)]
    [Dictionary('CST_COFINS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_COFINS: String read FCST_COFINS write FCST_COFINS;
    const CST_COFINS_Name = 'CST_COFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_DESC_COFINS', ftInteger)]
    [Dictionary('VL_DESC_COFINS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_DESC_COFINS: Integer read FVL_DESC_COFINS write FVL_DESC_COFINS;
    const VL_DESC_COFINS_Name = 'VL_DESC_COFINS';

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
    [Column('COD_MOD', ftString, 2)]
    [Dictionary('COD_MOD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    const COD_MOD_Name = 'COD_MOD';

    [Restrictions([NoValidate])]
    [Column('CFOP', ftString, 4)]
    [Dictionary('CFOP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP: String read FCFOP write FCFOP;
    const CFOP_Name = 'CFOP';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INFO_COMPL', ftString, 1)]
    [Dictionary('INFO_COMPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INFO_COMPL: String read FINFO_COMPL write FINFO_COMPL;
    const INFO_COMPL_Name = 'INFO_COMPL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_F550)

end.
