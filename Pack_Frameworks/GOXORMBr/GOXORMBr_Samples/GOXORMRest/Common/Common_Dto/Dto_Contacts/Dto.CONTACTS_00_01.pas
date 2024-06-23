unit Dto.contacts_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  // goxormbr 
  goxormbr.core.types.blob, 
  goxormbr.core.types.mapping, 
  goxormbr.core.mapping.classes, 
  goxormbr.core.mapping.register, 
  goxormbr.core.mapping.attributes; 

type
  [Entity]
  [Table('CONTACTS_00_01', '')]
  [PrimaryKey('CONTACT_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CONTACTS_01_ID')]
  TDtoCONTACTS_00_01 = class
  private
    { Private declarations } 
    FCONTACT_01_ID: Integer;
    FCONTACT_CODIGO: Integer;
    FCONTACT_CELL: String;
    FCONTACT_PHONE: String;
    FCONTACT_EMAIL: String;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('CONTACT_01_ID', ftInteger)]
    [Dictionary('CONTACT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CONTACT_01_ID: Integer read FCONTACT_01_ID write FCONTACT_01_ID;

    [Restrictions([NotNull])]
    [Column('CONTACT_CODIGO', ftInteger)]
    [Dictionary('CONTACT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CONTACT_CODIGO: Integer read FCONTACT_CODIGO write FCONTACT_CODIGO;

    [Column('CONTACT_CELL', ftString, 50)]
    [Dictionary('CONTACT_CELL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CONTACT_CELL: String read FCONTACT_CELL write FCONTACT_CELL;

    [Column('CONTACT_PHONE', ftString, 50)]
    [Dictionary('CONTACT_PHONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CONTACT_PHONE: String read FCONTACT_PHONE write FCONTACT_PHONE;

    [Column('CONTACT_EMAIL', ftString, 50)]
    [Dictionary('CONTACT_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CONTACT_EMAIL: String read FCONTACT_EMAIL write FCONTACT_EMAIL;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONTACTS_00_01)

end.
