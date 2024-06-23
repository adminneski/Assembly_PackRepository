unit express.dbo.ACCESS_PERMISSION;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.account,
  express.dbo.company,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ACCESS_PERMISSION', '')]
  [PrimaryKey('ACS_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ACS_CODIGO')]
  TDtoACCESS_PERMISSION = class
  private
    { Private declarations } 
    FACS_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FACC_CODIGO: Integer;
    FACS_ROLESALLOWED: String;
    FACS_DISABLEDPERMISSION: String;
    FACS_BLOCKEDPERMISSION: String;
    FACS_VIEWMULTIPLECOMPANY: String;

    FACCOUNT_0:  TACCOUNT  ;
    FCOMPANY_1:  TCOMPANY  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'ACCESS_PERMISSION';
     const PrimaryKey = 'ACS_CODIGO';
     const Sequence   = 'SEQ_ACS_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACS_CODIGO', ftInteger)]
    [Dictionary('ACS_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACS_CODIGO: Integer read FACS_CODIGO write FACS_CODIGO;
    const ACS_CODIGO_Name = 'ACS_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [ForeignKey('ACCESS_PERMISSION_fk', 'COM_CODIGO', 'COMPANY', 'COM_CODIGO', SetNull, SetNull)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [ForeignKey('ACCESS_PERMISSION_fk2', 'ACC_CODIGO', 'ACCOUNT', 'ACC_CODIGO', SetNull, SetNull)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;
    const ACC_CODIGO_Name = 'ACC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ACS_ROLESALLOWED', ftString, 100)]
    [Dictionary('ACS_ROLESALLOWED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACS_ROLESALLOWED: String read FACS_ROLESALLOWED write FACS_ROLESALLOWED;
    const ACS_ROLESALLOWED_Name = 'ACS_ROLESALLOWED';

    [Restrictions([NoValidate])]
    [Column('ACS_DISABLEDPERMISSION', ftString, 1)]
    [Dictionary('ACS_DISABLEDPERMISSION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACS_DISABLEDPERMISSION: String read FACS_DISABLEDPERMISSION write FACS_DISABLEDPERMISSION;
    const ACS_DISABLEDPERMISSION_Name = 'ACS_DISABLEDPERMISSION';

    [Restrictions([NoValidate])]
    [Column('ACS_BLOCKEDPERMISSION', ftString, 1)]
    [Dictionary('ACS_BLOCKEDPERMISSION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACS_BLOCKEDPERMISSION: String read FACS_BLOCKEDPERMISSION write FACS_BLOCKEDPERMISSION;
    const ACS_BLOCKEDPERMISSION_Name = 'ACS_BLOCKEDPERMISSION';

    [Restrictions([NoValidate])]
    [Column('ACS_VIEWMULTIPLECOMPANY', ftString, 50)]
    [Dictionary('ACS_VIEWMULTIPLECOMPANY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACS_VIEWMULTIPLECOMPANY: String read FACS_VIEWMULTIPLECOMPANY write FACS_VIEWMULTIPLECOMPANY;
    const ACS_VIEWMULTIPLECOMPANY_Name = 'ACS_VIEWMULTIPLECOMPANY';

    [Association(OneToOne,'ACC_CODIGO','ACCOUNT','ACC_CODIGO')]
    property ACCOUNT: TACCOUNT read FACCOUNT_0 write FACCOUNT_0;

    [Association(OneToOne,'COM_CODIGO','COMPANY','COM_CODIGO')]
    property COMPANY: TCOMPANY read FCOMPANY_1 write FCOMPANY_1;

  end;

implementation

constructor TACCESS_PERMISSION.Create;
begin
  FACCOUNT_0 := TACCOUNT.Create;
  FCOMPANY_1 := TCOMPANY.Create;
end;

destructor TACCESS_PERMISSION.Destroy;
begin
  if Assigned(FACCOUNT_0) then
    FACCOUNT_0.Free;

  if Assigned(FCOMPANY_1) then
    FCOMPANY_1.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoACCESS_PERMISSION)

end.
