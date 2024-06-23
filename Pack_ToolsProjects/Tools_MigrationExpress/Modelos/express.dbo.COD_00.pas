unit express.dbo.COD_00;

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
  [Table('COD_00', '')]
  TDtoCOD_00 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FCOD_FIELD: String;
    FCOD_SERIE: String;
    FCOD_SEQUENCIA: Integer;
  public 
    { Public declarations } 
     const Table      = 'COD_00';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_FIELD', ftString, 30)]
    [Dictionary('COD_FIELD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_FIELD: String read FCOD_FIELD write FCOD_FIELD;
    const COD_FIELD_Name = 'COD_FIELD';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_SERIE', ftString, 3)]
    [Dictionary('COD_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_SERIE: String read FCOD_SERIE write FCOD_SERIE;
    const COD_SERIE_Name = 'COD_SERIE';

    [Restrictions([NoValidate])]
    [Column('COD_SEQUENCIA', ftInteger)]
    [Dictionary('COD_SEQUENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_SEQUENCIA: Integer read FCOD_SEQUENCIA write FCOD_SEQUENCIA;
    const COD_SEQUENCIA_Name = 'COD_SEQUENCIA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCOD_00)

end.
