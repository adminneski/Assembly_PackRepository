unit express.dbo.build;

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
  [Table('BUILD', 'SELECT * FROM BUILD')]
  [PrimaryKey('BUILD_NUMBER', NotInc, NoSort, False, 'Chave primária')]
  TBUILD = class(TModelBase)
  private
    { Private declarations } 
    FBUILD_NUMBER: Integer;
    FBUILD_DATAATUALIZACAO: Nullable<TDateTime>;
    FBUILD_HORAATUALIZACAO: Nullable<String>;
    FBUILD_NESKI_EXPRESS_DB: Nullable<String>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('BUILD_NUMBER', ftInteger)]
    [Dictionary('BUILD_NUMBER', 'Mensagem de validação', '', '', '', taCenter)]
    property BUILD_NUMBER: Integer read FBUILD_NUMBER write FBUILD_NUMBER;

    [Column('BUILD_DATAATUALIZACAO', ftDateTime)]
    [Dictionary('BUILD_DATAATUALIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property BUILD_DATAATUALIZACAO: Nullable<TDateTime> read FBUILD_DATAATUALIZACAO write FBUILD_DATAATUALIZACAO;

    [Column('BUILD_HORAATUALIZACAO', ftString, 8)]
    [Dictionary('BUILD_HORAATUALIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BUILD_HORAATUALIZACAO: Nullable<String> read FBUILD_HORAATUALIZACAO write FBUILD_HORAATUALIZACAO;

    [Column('BUILD_NESKI_EXPRESS_DB', ftString, 1)]
    [Dictionary('BUILD_NESKI_EXPRESS_DB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BUILD_NESKI_EXPRESS_DB: Nullable<String> read FBUILD_NESKI_EXPRESS_DB write FBUILD_NESKI_EXPRESS_DB;
  end;

implementation

uses ormbr.container.objectset; 

{ TBUILD } 

procedure TBUILD.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TBUILD>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TBUILD>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TBUILD(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TBUILD);
  TCoreRegisterClass.RegisterEntity(TBUILD);

end.
