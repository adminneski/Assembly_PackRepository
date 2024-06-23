unit express.dbo.SPEDPC_R_0145;

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
  [Table('SPEDPC_R_0145', '')]
  TDtoSPEDPC_R_0145 = class
  private
    { Private declarations } 
    FTIPO: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FID_DOC: Integer;
    FDT_DOC: TDateTime;
    FCOD_INC_TRIB: String;
    FVL_REC_TOT: Double;
    FVL_REC_ATIV: Double;
    FVL_REC_DEMAIS_ATIV: Double;
    FINFO_COMPL: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0145';

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

    [Restrictions([NoValidate])]
    [Column('COD_INC_TRIB', ftString, 1)]
    [Dictionary('COD_INC_TRIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_INC_TRIB: String read FCOD_INC_TRIB write FCOD_INC_TRIB;
    const COD_INC_TRIB_Name = 'COD_INC_TRIB';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_REC_TOT', ftBCD)]
    [Dictionary('VL_REC_TOT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_REC_TOT: Double read FVL_REC_TOT write FVL_REC_TOT;
    const VL_REC_TOT_Name = 'VL_REC_TOT';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_REC_ATIV', ftBCD, 10, 2)]
    [Dictionary('VL_REC_ATIV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_REC_ATIV: Double read FVL_REC_ATIV write FVL_REC_ATIV;
    const VL_REC_ATIV_Name = 'VL_REC_ATIV';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_REC_DEMAIS_ATIV', ftBCD)]
    [Dictionary('VL_REC_DEMAIS_ATIV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_REC_DEMAIS_ATIV: Double read FVL_REC_DEMAIS_ATIV write FVL_REC_DEMAIS_ATIV;
    const VL_REC_DEMAIS_ATIV_Name = 'VL_REC_DEMAIS_ATIV';

    [Restrictions([NoValidate, NotNull])]
    [Column('INFO_COMPL', ftString, 1)]
    [Dictionary('INFO_COMPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INFO_COMPL: String read FINFO_COMPL write FINFO_COMPL;
    const INFO_COMPL_Name = 'INFO_COMPL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0145)

end.
