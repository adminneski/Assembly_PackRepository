unit express.dbo.MOSTUSED;

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
  [Table('MOSTUSED', '')]
  [PrimaryKey('MUS_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MUS_ID')]
  TDtoMOSTUSED = class
  private
    { Private declarations } 
    FMUS_ID: Integer;
    FACC_CODIGO: Integer;
    FMEN_CODIGO: Integer;
    FMUS_MOSTUSED: Integer;
    FMUS_DATETIMELASTACCESS: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'MOSTUSED';
     const PrimaryKey = 'MUS_ID';
     const Sequence   = 'SEQ_MUS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MUS_ID', ftInteger)]
    [Dictionary('MUS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MUS_ID: Integer read FMUS_ID write FMUS_ID;
    const MUS_ID_Name = 'MUS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;
    const ACC_CODIGO_Name = 'ACC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [Dictionary('MEN_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;
    const MEN_CODIGO_Name = 'MEN_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MUS_MOSTUSED', ftInteger)]
    [Dictionary('MUS_MOSTUSED', 'Mensagem de validação', '0', '', '', taCenter)]
    property MUS_MOSTUSED: Integer read FMUS_MOSTUSED write FMUS_MOSTUSED;
    const MUS_MOSTUSED_Name = 'MUS_MOSTUSED';

    [Restrictions([NoValidate])]
    [Column('MUS_DATETIMELASTACCESS', ftDateTime)]
    [Dictionary('MUS_DATETIMELASTACCESS', 'Mensagem de validação', '', '', '', taCenter)]
    property MUS_DATETIMELASTACCESS: TDateTime read FMUS_DATETIMELASTACCESS write FMUS_DATETIMELASTACCESS;
    const MUS_DATETIMELASTACCESS_Name = 'MUS_DATETIMELASTACCESS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMOSTUSED)

end.
