unit express.dbo.SPEDPC_R_D101;

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
  [Table('SPEDPC_R_D101', '')]
  TDtoSPEDPC_R_D101 = class
  private
    { Private declarations } 
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FID_DOC: Integer;
    FIND_NAT_FRT: String;
    FVL_ITEM: Double;
    FCST_PIS: String;
    FNAT_BC_CRED: String;
    FVL_BC_PIS: Double;
    FALIQ_PIS: Double;
    FVL_PIS: Double;
    FCOD_CTA: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_D101';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

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
    [Column('IND_NAT_FRT', ftString, 1)]
    [Dictionary('IND_NAT_FRT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_NAT_FRT: String read FIND_NAT_FRT write FIND_NAT_FRT;
    const IND_NAT_FRT_Name = 'IND_NAT_FRT';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ITEM', ftBCD)]
    [Dictionary('VL_ITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ITEM: Double read FVL_ITEM write FVL_ITEM;
    const VL_ITEM_Name = 'VL_ITEM';

    [Restrictions([NoValidate])]
    [Column('CST_PIS', ftString, 2)]
    [Dictionary('CST_PIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_PIS: String read FCST_PIS write FCST_PIS;
    const CST_PIS_Name = 'CST_PIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NAT_BC_CRED', ftString, 2)]
    [Dictionary('NAT_BC_CRED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NAT_BC_CRED: String read FNAT_BC_CRED write FNAT_BC_CRED;
    const NAT_BC_CRED_Name = 'NAT_BC_CRED';

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
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_D101)

end.
