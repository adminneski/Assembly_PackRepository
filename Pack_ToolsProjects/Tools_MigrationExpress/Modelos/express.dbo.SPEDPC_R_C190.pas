unit express.dbo.SPEDPC_R_C190;

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
  [Table('SPEDPC_R_C190', '')]
  TDtoSPEDPC_R_C190 = class
  private
    { Private declarations } 
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FCOM_CODIGO: Integer;
    FCOD_MOD: String;
    FDT_DOC: TDateTime;
    FCOD_ITEM: Integer;
    FCOD_NCM: String;
    FEX_IPI: String;
    FVL_TOT_ITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_C190';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_MOD', ftString, 2)]
    [Dictionary('COD_MOD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    const COD_MOD_Name = 'COD_MOD';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ITEM', ftInteger)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ITEM: Integer read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';

    [Restrictions([NoValidate])]
    [Column('COD_NCM', ftString, 8)]
    [Dictionary('COD_NCM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_NCM: String read FCOD_NCM write FCOD_NCM;
    const COD_NCM_Name = 'COD_NCM';

    [Restrictions([NoValidate, NotNull])]
    [Column('EX_IPI', ftString, 1)]
    [Dictionary('EX_IPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EX_IPI: String read FEX_IPI write FEX_IPI;
    const EX_IPI_Name = 'EX_IPI';

    [Restrictions([NoValidate])]
    [Column('VL_TOT_ITEM', ftBCD)]
    [Dictionary('VL_TOT_ITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_TOT_ITEM: Double read FVL_TOT_ITEM write FVL_TOT_ITEM;
    const VL_TOT_ITEM_Name = 'VL_TOT_ITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_C190)

end.
