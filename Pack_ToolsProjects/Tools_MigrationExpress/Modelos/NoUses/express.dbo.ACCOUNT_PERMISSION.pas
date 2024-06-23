unit express.dbo.account_permission;

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
  [Table('ACCOUNT_PERMISSION', 'SELECT * FROM ACCOUNT_PERMISSION')]
  [PrimaryKey('ACC_01_ID', NotInc, NoSort, False, 'Chave primária')]
  TACCOUNT_PERMISSION = class(TModelBase)
  private
    { Private declarations } 
    FACC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FACC_CODIGO: Integer;
    FACC_ROLESALLOWED: Nullable<String>;
    FACC_DISABLED: Nullable<String>;
    FACC_BLOCKED: Nullable<String>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('ACC_01_ID', ftInteger)]
    [Dictionary('ACC_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_01_ID: Integer read FACC_01_ID write FACC_01_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;

    [Column('ACC_ROLESALLOWED', ftString, 100)]
    [Dictionary('ACC_ROLESALLOWED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_ROLESALLOWED: Nullable<String> read FACC_ROLESALLOWED write FACC_ROLESALLOWED;

    [Column('ACC_DISABLED', ftString, 1)]
    [Dictionary('ACC_DISABLED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_DISABLED: Nullable<String> read FACC_DISABLED write FACC_DISABLED;

    [Column('ACC_BLOCKED', ftString, 1)]
    [Dictionary('ACC_BLOCKED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_BLOCKED: Nullable<String> read FACC_BLOCKED write FACC_BLOCKED;
  end;

implementation

uses ormbr.container.objectset; 

{ TACCOUNT_PERMISSION } 

procedure TACCOUNT_PERMISSION.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TACCOUNT_PERMISSION>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TACCOUNT_PERMISSION>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TACCOUNT_PERMISSION(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TACCOUNT_PERMISSION);
  TCoreRegisterClass.RegisterEntity(TACCOUNT_PERMISSION);

end.
