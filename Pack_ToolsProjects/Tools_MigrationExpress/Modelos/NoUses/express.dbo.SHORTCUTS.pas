unit express.dbo.shortcuts;

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
  [Table('SHORTCUTS', 'SELECT * FROM SHORTCUTS')]
  [PrimaryKey('SHO_ID', NotInc, NoSort, False, 'Chave primária')]
  TSHORTCUTS = class(TModelBase)
  private
    { Private declarations } 
    FSHO_ID: Integer;
    FACC_CODIGO: Integer;
    FMEN_CODIGO: Integer;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('SHO_ID', ftInteger)]
    [Dictionary('SHO_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property SHO_ID: Integer read FSHO_ID write FSHO_ID;

    [Restrictions([NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;

    [Restrictions([NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [Dictionary('MEN_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;
  end;

implementation

uses ormbr.container.objectset; 

{ TSHORTCUTS } 

procedure TSHORTCUTS.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TSHORTCUTS>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TSHORTCUTS>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TSHORTCUTS(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TSHORTCUTS);
  TCoreRegisterClass.RegisterEntity(TSHORTCUTS);

end.
