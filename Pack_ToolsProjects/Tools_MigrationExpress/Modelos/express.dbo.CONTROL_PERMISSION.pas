unit express.dbo.CONTROL_PERMISSION;

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
  [Table('CONTROL_PERMISSION', '')]
  [PrimaryKey('USERS_LOGIN', AutoInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('PERMISSION_KEY', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_USERS_LOGIN')]
  [Sequence('SEQ_PERMISSION_KEY')]
  TDtoCONTROL_PERMISSION = class
  private
    { Private declarations } 
    FUSERS_LOGIN: String;
    FPERMISSION_KEY: String;
    FACESS_OPTIONS: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CONTROL_PERMISSION';
     const PrimaryKey = 'USERS_LOGIN';
     const Sequence   = 'SEQ_USERS_LOGIN';

    [Restrictions([NoValidate, NotNull])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate, NotNull])]
    [Column('PERMISSION_KEY', ftString, 50)]
    [Dictionary('PERMISSION_KEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PERMISSION_KEY: String read FPERMISSION_KEY write FPERMISSION_KEY;
    const PERMISSION_KEY_Name = 'PERMISSION_KEY';

    [Restrictions([NoValidate])]
    [Column('ACESS_OPTIONS', ftString, 3)]
    [Dictionary('ACESS_OPTIONS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACESS_OPTIONS: String read FACESS_OPTIONS write FACESS_OPTIONS;
    const ACESS_OPTIONS_Name = 'ACESS_OPTIONS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONTROL_PERMISSION)

end.
