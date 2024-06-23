unit express.dbo.SPED_R_G140;

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
  [Table('SPED_R_G140', '')]
  TDtoSPED_R_G140 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FIND_EMIT: String;
    FCOD_PART: Integer;
    FCOD_MOD: String;
    FSERIE: String;
    FNUM_DOC: String;
    FCHV_NFE_CTE: String;
    FDT_DOC_NF: TDateTime;
    FCOD_ITEM: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_G140';

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

    [Restrictions([NoValidate])]
    [Column('IND_EMIT', ftString, 1)]
    [Dictionary('IND_EMIT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_EMIT: String read FIND_EMIT write FIND_EMIT;
    const IND_EMIT_Name = 'IND_EMIT';

    [Restrictions([NoValidate])]
    [Column('COD_PART', ftInteger)]
    [Dictionary('COD_PART', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_PART: Integer read FCOD_PART write FCOD_PART;
    const COD_PART_Name = 'COD_PART';

    [Restrictions([NoValidate])]
    [Column('COD_MOD', ftString, 2)]
    [Dictionary('COD_MOD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    const COD_MOD_Name = 'COD_MOD';

    [Restrictions([NoValidate])]
    [Column('SERIE', ftString, 3)]
    [Dictionary('SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SERIE: String read FSERIE write FSERIE;
    const SERIE_Name = 'SERIE';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

    [Restrictions([NoValidate])]
    [Column('CHV_NFE_CTE', ftString, 44)]
    [Dictionary('CHV_NFE_CTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CHV_NFE_CTE: String read FCHV_NFE_CTE write FCHV_NFE_CTE;
    const CHV_NFE_CTE_Name = 'CHV_NFE_CTE';

    [Restrictions([NoValidate])]
    [Column('DT_DOC_NF', ftDateTime)]
    [Dictionary('DT_DOC_NF', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC_NF: TDateTime read FDT_DOC_NF write FDT_DOC_NF;
    const DT_DOC_NF_Name = 'DT_DOC_NF';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ITEM', ftInteger)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ITEM: Integer read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_G140)

end.
