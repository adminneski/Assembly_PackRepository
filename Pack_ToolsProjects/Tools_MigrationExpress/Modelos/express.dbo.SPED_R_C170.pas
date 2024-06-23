unit express.dbo.SPED_R_C170;

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
  [Table('SPED_R_C170', '')]
  TDtoSPED_R_C170 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FTIPO_DOC: String;
    FID_DOC: Integer;
    FNUM_ITEM: Integer;
    FCOD_ITEM: Integer;
    FDESCR_COMPL: String;
    FQTD: Double;
    FUNID: String;
    FVL_ITEM: Double;
    FVL_DESC: Double;
    FIND_MOV: String;
    FCST_ICMS: String;
    FCFOP: String;
    FCOD_NAT: Integer;
    FVL_BC_ICMS: Double;
    FALIQ_ICMS: Double;
    FVL_ICMS: Double;
    FVL_BC_ICMS_ST: Double;
    FALIQ_ST: Double;
    FVL_ICMS_ST: Double;
    FIND_APUR: String;
    FCST_IPI: String;
    FCOD_ENQ: String;
    FVL_BC_IPI: Integer;
    FALIQ_IPI: Double;
    FVL_IPI: Double;
    FCST_PIS: String;
    FVL_BC_PIS: Double;
    FALIQ_PIS_P: Double;
    FQUANT_BC_PIS: Integer;
    FALIQ_PIS_R: Integer;
    FVL_PIS: Double;
    FCST_COFINS: String;
    FVL_BC_COFINS: Double;
    FALIQ_COFINS_P: Double;
    FQUANT_BC_COFINS: Integer;
    FALIQ_COFINS_R: Integer;
    FVL_COFINS: Double;
    FCOD_CTA: String;
    FVL_ABAT_NT: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_C170';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('QTD', ftBCD, 18, 4)]
    [Dictionary('QTD', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property QTD: Double read FQTD write FQTD;
    const QTD_Name = 'QTD';

    [Restrictions([NoValidate])]
    [Column('UNID', ftString, 2)]
    [Dictionary('UNID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UNID: String read FUNID write FUNID;
    const UNID_Name = 'UNID';

    [Restrictions([NoValidate])]
    [Column('VL_ITEM', ftBCD)]
    [Dictionary('VL_ITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ITEM: Double read FVL_ITEM write FVL_ITEM;
    const VL_ITEM_Name = 'VL_ITEM';

    [Restrictions([NoValidate])]
    [Column('VL_DESC', ftBCD, 10, 2)]
    [Dictionary('VL_DESC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_DESC: Double read FVL_DESC write FVL_DESC;
    const VL_DESC_Name = 'VL_DESC';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_MOV', ftString, 1)]
    [Dictionary('IND_MOV', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_MOV: String read FIND_MOV write FIND_MOV;
    const IND_MOV_Name = 'IND_MOV';

    [Restrictions([NoValidate])]
    [Column('CST_ICMS', ftString, 2)]
    [Dictionary('CST_ICMS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_ICMS: String read FCST_ICMS write FCST_ICMS;
    const CST_ICMS_Name = 'CST_ICMS';

    [Restrictions([NoValidate])]
    [Column('CFOP', ftString, 4)]
    [Dictionary('CFOP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP: String read FCFOP write FCFOP;
    const CFOP_Name = 'CFOP';

    [Restrictions([NoValidate])]
    [Column('COD_NAT', ftInteger)]
    [Dictionary('COD_NAT', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_NAT: Integer read FCOD_NAT write FCOD_NAT;
    const COD_NAT_Name = 'COD_NAT';

    [Restrictions([NoValidate])]
    [Column('VL_BC_ICMS', ftBCD)]
    [Dictionary('VL_BC_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_ICMS: Double read FVL_BC_ICMS write FVL_BC_ICMS;
    const VL_BC_ICMS_Name = 'VL_BC_ICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALIQ_ICMS', ftBCD)]
    [Dictionary('ALIQ_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_ICMS: Double read FALIQ_ICMS write FALIQ_ICMS;
    const ALIQ_ICMS_Name = 'ALIQ_ICMS';

    [Restrictions([NoValidate])]
    [Column('VL_ICMS', ftBCD)]
    [Dictionary('VL_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ICMS: Double read FVL_ICMS write FVL_ICMS;
    const VL_ICMS_Name = 'VL_ICMS';

    [Restrictions([NoValidate])]
    [Column('VL_BC_ICMS_ST', ftBCD)]
    [Dictionary('VL_BC_ICMS_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_ICMS_ST: Double read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    const VL_BC_ICMS_ST_Name = 'VL_BC_ICMS_ST';

    [Restrictions([NoValidate])]
    [Column('ALIQ_ST', ftBCD)]
    [Dictionary('ALIQ_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_ST: Double read FALIQ_ST write FALIQ_ST;
    const ALIQ_ST_Name = 'ALIQ_ST';

    [Restrictions([NoValidate])]
    [Column('VL_ICMS_ST', ftBCD)]
    [Dictionary('VL_ICMS_ST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ICMS_ST: Double read FVL_ICMS_ST write FVL_ICMS_ST;
    const VL_ICMS_ST_Name = 'VL_ICMS_ST';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_APUR', ftString, 1)]
    [Dictionary('IND_APUR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_APUR: String read FIND_APUR write FIND_APUR;
    const IND_APUR_Name = 'IND_APUR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_IPI', ftString, 2)]
    [Dictionary('CST_IPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_IPI: String read FCST_IPI write FCST_IPI;
    const CST_IPI_Name = 'CST_IPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ENQ', ftString, 1)]
    [Dictionary('COD_ENQ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_ENQ: String read FCOD_ENQ write FCOD_ENQ;
    const COD_ENQ_Name = 'COD_ENQ';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_BC_IPI', ftInteger)]
    [Dictionary('VL_BC_IPI', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_BC_IPI: Integer read FVL_BC_IPI write FVL_BC_IPI;
    const VL_BC_IPI_Name = 'VL_BC_IPI';

    [Restrictions([NoValidate])]
    [Column('ALIQ_IPI', ftBCD)]
    [Dictionary('ALIQ_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_IPI: Double read FALIQ_IPI write FALIQ_IPI;
    const ALIQ_IPI_Name = 'ALIQ_IPI';

    [Restrictions([NoValidate])]
    [Column('VL_IPI', ftBCD)]
    [Dictionary('VL_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_IPI: Double read FVL_IPI write FVL_IPI;
    const VL_IPI_Name = 'VL_IPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_PIS', ftString, 2)]
    [Dictionary('CST_PIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_PIS: String read FCST_PIS write FCST_PIS;
    const CST_PIS_Name = 'CST_PIS';

    [Restrictions([NoValidate])]
    [Column('VL_BC_PIS', ftBCD, 48, 2)]
    [Dictionary('VL_BC_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_PIS: Double read FVL_BC_PIS write FVL_BC_PIS;
    const VL_BC_PIS_Name = 'VL_BC_PIS';

    [Restrictions([NoValidate])]
    [Column('ALIQ_PIS_P', ftBCD)]
    [Dictionary('ALIQ_PIS_P', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_PIS_P: Double read FALIQ_PIS_P write FALIQ_PIS_P;
    const ALIQ_PIS_P_Name = 'ALIQ_PIS_P';

    [Restrictions([NoValidate, NotNull])]
    [Column('QUANT_BC_PIS', ftInteger)]
    [Dictionary('QUANT_BC_PIS', 'Mensagem de validação', '0', '', '', taCenter)]
    property QUANT_BC_PIS: Integer read FQUANT_BC_PIS write FQUANT_BC_PIS;
    const QUANT_BC_PIS_Name = 'QUANT_BC_PIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALIQ_PIS_R', ftInteger)]
    [Dictionary('ALIQ_PIS_R', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALIQ_PIS_R: Integer read FALIQ_PIS_R write FALIQ_PIS_R;
    const ALIQ_PIS_R_Name = 'ALIQ_PIS_R';

    [Restrictions([NoValidate])]
    [Column('VL_PIS', ftBCD)]
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
    [Column('ALIQ_COFINS_P', ftBCD, 48, 6)]
    [Dictionary('ALIQ_COFINS_P', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_COFINS_P: Double read FALIQ_COFINS_P write FALIQ_COFINS_P;
    const ALIQ_COFINS_P_Name = 'ALIQ_COFINS_P';

    [Restrictions([NoValidate, NotNull])]
    [Column('QUANT_BC_COFINS', ftInteger)]
    [Dictionary('QUANT_BC_COFINS', 'Mensagem de validação', '0', '', '', taCenter)]
    property QUANT_BC_COFINS: Integer read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    const QUANT_BC_COFINS_Name = 'QUANT_BC_COFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALIQ_COFINS_R', ftInteger)]
    [Dictionary('ALIQ_COFINS_R', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALIQ_COFINS_R: Integer read FALIQ_COFINS_R write FALIQ_COFINS_R;
    const ALIQ_COFINS_R_Name = 'ALIQ_COFINS_R';

    [Restrictions([NoValidate])]
    [Column('VL_COFINS', ftBCD, 48, 2)]
    [Dictionary('VL_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_COFINS: Double read FVL_COFINS write FVL_COFINS;
    const VL_COFINS_Name = 'VL_COFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_CTA', ftString, 1)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ABAT_NT', ftInteger)]
    [Dictionary('VL_ABAT_NT', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_ABAT_NT: Integer read FVL_ABAT_NT write FVL_ABAT_NT;
    const VL_ABAT_NT_Name = 'VL_ABAT_NT';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_C170)

end.
