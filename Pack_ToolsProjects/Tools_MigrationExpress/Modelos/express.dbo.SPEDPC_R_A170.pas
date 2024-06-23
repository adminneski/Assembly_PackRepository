unit express.dbo.SPEDPC_R_A170;

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
  [Table('SPEDPC_R_A170', '')]
  TDtoSPEDPC_R_A170 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FID_DOC: Integer;
    FNUM_ITEM: Integer;
    FCOD_ITEM: Integer;
    FDESCR_COMPL: String;
    FVL_ITEM: Double;
    FVL_DESC: Double;
    FNAT_BC_CRED: String;
    FIND_ORIG_CRED: String;
    FCST_PIS: String;
    FVL_BC_PIS: Double;
    FALIQ_PIS: Double;
    FVL_PIS: Double;
    FCST_COFINS: String;
    FVL_BC_COFINS: Double;
    FALIQ_COFINS: Double;
    FVL_COFINS: Double;
    FCOD_CTA: String;
    FCOD_CCUS: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_A170';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

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
    [Column('ID_DOC', ftInteger)]
    [Dictionary('ID_DOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ID_DOC: Integer read FID_DOC write FID_DOC;
    const ID_DOC_Name = 'ID_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('NUM_ITEM', ftInteger)]
    [Dictionary('NUM_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NUM_ITEM: Integer read FNUM_ITEM write FNUM_ITEM;
    const NUM_ITEM_Name = 'NUM_ITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ITEM', ftInteger)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ITEM: Integer read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DESCR_COMPL', ftString, 1)]
    [Dictionary('DESCR_COMPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCR_COMPL: String read FDESCR_COMPL write FDESCR_COMPL;
    const DESCR_COMPL_Name = 'DESCR_COMPL';

    [Restrictions([NoValidate])]
    [Column('VL_ITEM', ftBCD)]
    [Dictionary('VL_ITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ITEM: Double read FVL_ITEM write FVL_ITEM;
    const VL_ITEM_Name = 'VL_ITEM';

    [Restrictions([NoValidate])]
    [Column('VL_DESC', ftBCD)]
    [Dictionary('VL_DESC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DESC: Double read FVL_DESC write FVL_DESC;
    const VL_DESC_Name = 'VL_DESC';

    [Restrictions([NoValidate, NotNull])]
    [Column('NAT_BC_CRED', ftString, 2)]
    [Dictionary('NAT_BC_CRED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NAT_BC_CRED: String read FNAT_BC_CRED write FNAT_BC_CRED;
    const NAT_BC_CRED_Name = 'NAT_BC_CRED';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_ORIG_CRED', ftString, 1)]
    [Dictionary('IND_ORIG_CRED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_ORIG_CRED: String read FIND_ORIG_CRED write FIND_ORIG_CRED;
    const IND_ORIG_CRED_Name = 'IND_ORIG_CRED';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('VL_PIS', ftBCD, 48, 2)]
    [Dictionary('VL_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_PIS: Double read FVL_PIS write FVL_PIS;
    const VL_PIS_Name = 'VL_PIS';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('VL_COFINS', ftBCD)]
    [Dictionary('VL_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_COFINS: Double read FVL_COFINS write FVL_COFINS;
    const VL_COFINS_Name = 'VL_COFINS';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate])]
    [Column('COD_CCUS', ftString, 60)]
    [Dictionary('COD_CCUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CCUS: String read FCOD_CCUS write FCOD_CCUS;
    const COD_CCUS_Name = 'COD_CCUS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_A170)

end.
