unit express.dbo.SPED_R_0450;

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
  [Table('SPED_R_0450', '')]
  TDtoSPED_R_0450 = class
  private
    { Private declarations } 
    FTIPO_DOC: String;
    FCOD_INF: String;
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FTXT: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_0450';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

    [Restrictions([NoValidate])]
    [Column('COD_INF', ftString, 9)]
    [Dictionary('COD_INF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_INF: String read FCOD_INF write FCOD_INF;
    const COD_INF_Name = 'COD_INF';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TXT', ftString, 255)]
    [Dictionary('TXT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXT: String read FTXT write FTXT;
    const TXT_Name = 'TXT';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_0450)

end.
