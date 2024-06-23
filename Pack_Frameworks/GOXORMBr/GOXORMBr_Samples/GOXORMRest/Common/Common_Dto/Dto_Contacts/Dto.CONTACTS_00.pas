unit Dto.contacts_00;

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
  goxormbr.core.mapping.attributes,
  Dto.contacts_00_01;

type
  [Entity]
  [Table('CONTACTS_00', '')]
  [PrimaryKey('CONTACT_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CONTACTS_CODIGO')]
  [Resource('contacts')]
  TDtoCONTACTS_00 = class
  private
    { Private declarations }
    FCONTACT_CODIGO: Integer;
    FCONTACT_BIRTHDATE: TDateTime;
    FCONTACT_NAME: String;
    FCONTACT_LASTNAME: String;
    FCONTACT_SALARY: Double;
    FCONTACT_AGE: Integer;
    FCONTACTS_00_01: TObjectList<TDtoCONTACTS_00_01>;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    [Restrictions([NotNull])]
    [Column('CONTACT_CODIGO', ftInteger)]
    [Dictionary('CONTACT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CONTACT_CODIGO: Integer read FCONTACT_CODIGO write FCONTACT_CODIGO;

    [Column('CONTACT_BIRTHDATE', ftDateTime)]
    [Dictionary('CONTACT_BIRTHDATE', 'Mensagem de validação', '', '', '', taCenter)]
    property CONTACT_BIRTHDATE: TDateTime read FCONTACT_BIRTHDATE write FCONTACT_BIRTHDATE;

    [Column('CONTACT_NAME', ftString, 50)]
    [Dictionary('CONTACT_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CONTACT_NAME: String read FCONTACT_NAME write FCONTACT_NAME;

    [Column('CONTACT_LASTNAME', ftString, 50)]
    [Dictionary('CONTACT_LASTNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CONTACT_LASTNAME: String read FCONTACT_LASTNAME write FCONTACT_LASTNAME;

    [Column('CONTACT_SALARY', ftBCD)]
    [Dictionary('CONTACT_SALARY', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CONTACT_SALARY: Double read FCONTACT_SALARY write FCONTACT_SALARY;

    [Column('CONTACT_AGE', ftInteger)]
    [Dictionary('CONTACT_AGE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CONTACT_AGE: Integer read FCONTACT_AGE write FCONTACT_AGE;

    [Association(OneToMany,'CONTACT_CODIGO','CONTACTS_00_01','CONTACT_CODIGO')]
    [CascadeActions([CascadeAutoInc, CascadeInsert, CascadeUpdate, CascadeDelete])]
    property CONTACTS_00_01: TObjectList<TDtoCONTACTS_00_01> read FCONTACTS_00_01 write FCONTACTS_00_01;

  end;

implementation

constructor TDtoCONTACTS_00.Create;
begin
  FCONTACTS_00_01 := TObjectList<TDtoCONTACTS_00_01>.Create;
end;

destructor TDtoCONTACTS_00.Destroy;
begin
  FreeAndNil(FCONTACTS_00_01);
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoCONTACTS_00)

end.
