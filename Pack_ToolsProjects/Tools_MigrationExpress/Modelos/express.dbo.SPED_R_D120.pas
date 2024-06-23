unit express.dbo.SPED_R_D120;

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
  [Table('SPED_R_D120', '')]
  TDtoSPED_R_D120 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FTIPO_DOC: String;
    FID_DOC: Integer;
    FCOD_MUN_ORIG: Integer;
    FCOD_MUN_DEST: String;
    FVEIC_ID: String;
    FUF_ID: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_D120';

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

    [Restrictions([NoValidate])]
    [Column('COD_MUN_ORIG', ftInteger)]
    [Dictionary('COD_MUN_ORIG', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_MUN_ORIG: Integer read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    const COD_MUN_ORIG_Name = 'COD_MUN_ORIG';

    [Restrictions([NoValidate])]
    [Column('COD_MUN_DEST', ftString, 7)]
    [Dictionary('COD_MUN_DEST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_MUN_DEST: String read FCOD_MUN_DEST write FCOD_MUN_DEST;
    const COD_MUN_DEST_Name = 'COD_MUN_DEST';

    [Restrictions([NoValidate])]
    [Column('VEIC_ID', ftString, 7)]
    [Dictionary('VEIC_ID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEIC_ID: String read FVEIC_ID write FVEIC_ID;
    const VEIC_ID_Name = 'VEIC_ID';

    [Restrictions([NoValidate])]
    [Column('UF_ID', ftString, 2)]
    [Dictionary('UF_ID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UF_ID: String read FUF_ID write FUF_ID;
    const UF_ID_Name = 'UF_ID';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_D120)

end.
