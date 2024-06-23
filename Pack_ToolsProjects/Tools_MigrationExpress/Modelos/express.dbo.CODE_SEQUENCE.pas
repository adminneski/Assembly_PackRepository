unit express.dbo.CODE_SEQUENCE;

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
  [Table('CODE_SEQUENCE', '')]
  [PrimaryKey('COD_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_COD_ID')]
  TDtoCODE_SEQUENCE = class
  private
    { Private declarations } 
    FCOD_ID: Integer;
    FCOD_KEYNAME: String;
    FCOD_SUBKEYNAME: String;
    FCOD_SEQUENCE: Integer;
  public 
    { Public declarations } 
     const Table      = 'CODE_SEQUENCE';
     const PrimaryKey = 'COD_ID';
     const Sequence   = 'SEQ_COD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ID', ftInteger)]
    [Dictionary('COD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ID: Integer read FCOD_ID write FCOD_ID;
    const COD_ID_Name = 'COD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_KEYNAME', ftString, 30)]
    [Dictionary('COD_KEYNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_KEYNAME: String read FCOD_KEYNAME write FCOD_KEYNAME;
    const COD_KEYNAME_Name = 'COD_KEYNAME';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_SUBKEYNAME', ftString, 30)]
    [Dictionary('COD_SUBKEYNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_SUBKEYNAME: String read FCOD_SUBKEYNAME write FCOD_SUBKEYNAME;
    const COD_SUBKEYNAME_Name = 'COD_SUBKEYNAME';

    [Restrictions([NoValidate])]
    [Column('COD_SEQUENCE', ftInteger)]
    [Dictionary('COD_SEQUENCE', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_SEQUENCE: Integer read FCOD_SEQUENCE write FCOD_SEQUENCE;
    const COD_SEQUENCE_Name = 'COD_SEQUENCE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCODE_SEQUENCE)

end.
