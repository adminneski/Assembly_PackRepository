unit express.dbo.acess_permission;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  // ORMbr
  ormbr.types.blob,
  ormbr.types.lazy,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes,
  dbebr.factory.interfaces,
  Core.Register, 
  Model.Base;  

type
  [Entity]
  [Table('ACESS_PERMISSION', 'SELECT * FROM ACESS_PERMISSION')]
  [PrimaryKey('USERS_LOGIN', NotInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('PERMISSION_KEY', NotInc, NoSort, False, 'Chave primária')]
  TACESS_PERMISSION = class(TModelBase)
  private
    { Private declarations } 
    FUSERS_LOGIN: String;
    FPERMISSION_KEY: String;
    FACESS_OPTIONS: Nullable<String>;
    FCOM_CODIGO: Nullable<String>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;

    [Restrictions([NotNull])]
    [Column('PERMISSION_KEY', ftString, 50)]
    [Dictionary('PERMISSION_KEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PERMISSION_KEY: String read FPERMISSION_KEY write FPERMISSION_KEY;

    [Column('ACESS_OPTIONS', ftString, 3)]
    [Dictionary('ACESS_OPTIONS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACESS_OPTIONS: Nullable<String> read FACESS_OPTIONS write FACESS_OPTIONS;

    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: Nullable<String> read FCOM_CODIGO write FCOM_CODIGO;
  end;

implementation

uses ormbr.container.objectset; 

{ TACESS_PERMISSION } 

procedure TACESS_PERMISSION.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TACESS_PERMISSION>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TACESS_PERMISSION>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TACESS_PERMISSION(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TACESS_PERMISSION);
  TCoreRegisterClass.RegisterEntity(TACESS_PERMISSION);

end.
