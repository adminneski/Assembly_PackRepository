unit express.dbo.SPEDPC_R_F600;

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
  [Table('SPEDPC_R_F600', '')]
  TDtoSPEDPC_R_F600 = class
  private
    { Private declarations } 
    FTIPO: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FIND_NAT_RET: String;
    FPR_REC_RET: String;
    FDT_RET: TDateTime;
    FVL_BC_RET: Double;
    FVL_RET: Double;
    FCOD_REC: String;
    FIND_NAT_REC: String;
    FCNPJ: String;
    FVL_RET_PIS: Double;
    FVL_RET_COFINS: Double;
    FIND_DEC: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_F600';

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
    [Column('IND_NAT_RET', ftString, 2)]
    [Dictionary('IND_NAT_RET', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_NAT_RET: String read FIND_NAT_RET write FIND_NAT_RET;
    const IND_NAT_RET_Name = 'IND_NAT_RET';

    [Restrictions([NoValidate])]
    [Column('PR_REC_RET', ftString, 6)]
    [Dictionary('PR_REC_RET', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PR_REC_RET: String read FPR_REC_RET write FPR_REC_RET;
    const PR_REC_RET_Name = 'PR_REC_RET';

    [Restrictions([NoValidate])]
    [Column('DT_RET', ftDateTime)]
    [Dictionary('DT_RET', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_RET: TDateTime read FDT_RET write FDT_RET;
    const DT_RET_Name = 'DT_RET';

    [Restrictions([NoValidate])]
    [Column('VL_BC_RET', ftBCD)]
    [Dictionary('VL_BC_RET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_BC_RET: Double read FVL_BC_RET write FVL_BC_RET;
    const VL_BC_RET_Name = 'VL_BC_RET';

    [Restrictions([NoValidate])]
    [Column('VL_RET', ftBCD)]
    [Dictionary('VL_RET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_RET: Double read FVL_RET write FVL_RET;
    const VL_RET_Name = 'VL_RET';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_REC', ftString, 1)]
    [Dictionary('COD_REC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_REC: String read FCOD_REC write FCOD_REC;
    const COD_REC_Name = 'COD_REC';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_NAT_REC', ftString, 1)]
    [Dictionary('IND_NAT_REC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_NAT_REC: String read FIND_NAT_REC write FIND_NAT_REC;
    const IND_NAT_REC_Name = 'IND_NAT_REC';

    [Restrictions([NoValidate])]
    [Column('CNPJ', ftString, 14)]
    [Dictionary('CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNPJ: String read FCNPJ write FCNPJ;
    const CNPJ_Name = 'CNPJ';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_RET_PIS', ftBCD)]
    [Dictionary('VL_RET_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_RET_PIS: Double read FVL_RET_PIS write FVL_RET_PIS;
    const VL_RET_PIS_Name = 'VL_RET_PIS';

    [Restrictions([NoValidate])]
    [Column('VL_RET_COFINS', ftBCD)]
    [Dictionary('VL_RET_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_RET_COFINS: Double read FVL_RET_COFINS write FVL_RET_COFINS;
    const VL_RET_COFINS_Name = 'VL_RET_COFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_DEC', ftInteger)]
    [Dictionary('IND_DEC', 'Mensagem de validação', '0', '', '', taCenter)]
    property IND_DEC: Integer read FIND_DEC write FIND_DEC;
    const IND_DEC_Name = 'IND_DEC';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_F600)

end.
