unit express.dbo.SPEDPC_R_1900;

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
  [Table('SPEDPC_R_1900', '')]
  TDtoSPEDPC_R_1900 = class
  private
    { Private declarations } 
    FTIPO: String;
    FCOM_CODIGO: Integer;
    FID_DOC: Integer;
    FDT_DOC: TDateTime;
    FCNPJ: String;
    FCOD_MOD: String;
    FSER: String;
    FSUB_SER: String;
    FCOD_SIT: String;
    FVL_TOT_REC: Double;
    FQUANT_DOC: Integer;
    FCST_PIS: String;
    FCST_COFINS: String;
    FCFOP: String;
    FINF_COMPL: String;
    FCOD_CTA: String;
    FNUM_DOC: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_1900';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO', ftString, 3)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO: String read FTIPO write FTIPO;
    const TIPO_Name = 'TIPO';

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
    [Column('CNPJ', ftString, 14)]
    [Dictionary('CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNPJ: String read FCNPJ write FCNPJ;
    const CNPJ_Name = 'CNPJ';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('SUB_SER', ftString, 1)]
    [Dictionary('SUB_SER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SUB_SER: String read FSUB_SER write FSUB_SER;
    const SUB_SER_Name = 'SUB_SER';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_SIT', ftString, 2)]
    [Dictionary('COD_SIT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_SIT: String read FCOD_SIT write FCOD_SIT;
    const COD_SIT_Name = 'COD_SIT';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_REC', ftBCD)]
    [Dictionary('VL_TOT_REC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_TOT_REC: Double read FVL_TOT_REC write FVL_TOT_REC;
    const VL_TOT_REC_Name = 'VL_TOT_REC';

    [Restrictions([NoValidate, NotNull])]
    [Column('QUANT_DOC', ftInteger)]
    [Dictionary('QUANT_DOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property QUANT_DOC: Integer read FQUANT_DOC write FQUANT_DOC;
    const QUANT_DOC_Name = 'QUANT_DOC';

    [Restrictions([NoValidate])]
    [Column('CST_PIS', ftString, 2)]
    [Dictionary('CST_PIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_PIS: String read FCST_PIS write FCST_PIS;
    const CST_PIS_Name = 'CST_PIS';

    [Restrictions([NoValidate])]
    [Column('CST_COFINS', ftString, 2)]
    [Dictionary('CST_COFINS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_COFINS: String read FCST_COFINS write FCST_COFINS;
    const CST_COFINS_Name = 'CST_COFINS';

    [Restrictions([NoValidate])]
    [Column('CFOP', ftString, 4)]
    [Dictionary('CFOP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP: String read FCFOP write FCFOP;
    const CFOP_Name = 'CFOP';

    [Restrictions([NoValidate, NotNull])]
    [Column('INF_COMPL', ftString, 1)]
    [Dictionary('INF_COMPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INF_COMPL: String read FINF_COMPL write FINF_COMPL;
    const INF_COMPL_Name = 'INF_COMPL';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_1900)

end.
