unit express.dbo.mostused;

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
  [Table('MOSTUSED', 'SELECT * FROM MOSTUSED')]
  [PrimaryKey('MUS_ID', NotInc, NoSort, False, 'Chave primária')]
  TMOSTUSED = class(TModelBase)
  private
    { Private declarations } 
    FMUS_ID: Integer;
    FACC_CODIGO: Integer;
    FMEN_CODIGO: Integer;
    FMUS_MOSTUSED: Integer;
    FMUS_DATETIMELASTACCESS: Nullable<TDateTime>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('MUS_ID', ftInteger)]
    [Dictionary('MUS_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property MUS_ID: Integer read FMUS_ID write FMUS_ID;

    [Restrictions([NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;

    [Restrictions([NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [Dictionary('MEN_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;

    [Restrictions([NotNull])]
    [Column('MUS_MOSTUSED', ftInteger)]
    [Dictionary('MUS_MOSTUSED', 'Mensagem de validação', '', '', '', taCenter)]
    property MUS_MOSTUSED: Integer read FMUS_MOSTUSED write FMUS_MOSTUSED;

    [Column('MUS_DATETIMELASTACCESS', ftDateTime)]
    [Dictionary('MUS_DATETIMELASTACCESS', 'Mensagem de validação', '', '', '', taCenter)]
    property MUS_DATETIMELASTACCESS: Nullable<TDateTime> read FMUS_DATETIMELASTACCESS write FMUS_DATETIMELASTACCESS;
  end;

implementation

uses ormbr.container.objectset; 

{ TMOSTUSED } 

procedure TMOSTUSED.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TMOSTUSED>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TMOSTUSED>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TMOSTUSED(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TMOSTUSED);
  TCoreRegisterClass.RegisterEntity(TMOSTUSED);

end.
