unit express.dbo.mta_00_01;

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
  [Table('MTA_00_01', 'SELECT * FROM MTA_00_01')]
  [PrimaryKey('MTA_01_ID', NotInc, NoSort, False, 'Chave primária')]
  TMTA_00_01 = class(TModelBase)
  private
    { Private declarations } 
    FMTA_01_ID: Integer;
    FMTA_CODIGO: Integer;
    FCID_IBGE: String;
    FMTA_UF: Nullable<String>;
    FMTA_VALORCIDADE: Double;
    FMTA_DATAALTERACAO: TDateTime;
    FMTA_CIDADE: Nullable<String>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('MTA_01_ID', ftInteger)]
    [Dictionary('MTA_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property MTA_01_ID: Integer read FMTA_01_ID write FMTA_01_ID;

    [Restrictions([NotNull])]
    [Column('MTA_CODIGO', ftInteger)]
    [Dictionary('MTA_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property MTA_CODIGO: Integer read FMTA_CODIGO write FMTA_CODIGO;

    [Restrictions([NotNull])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;

    [Column('MTA_UF', ftString, 2)]
    [Dictionary('MTA_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_UF: Nullable<String> read FMTA_UF write FMTA_UF;

    [Restrictions([NotNull])]
    [Column('MTA_VALORCIDADE', ftBCD)]
    [Dictionary('MTA_VALORCIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MTA_VALORCIDADE: Double read FMTA_VALORCIDADE write FMTA_VALORCIDADE;

    [Restrictions([NotNull])]
    [Column('MTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('MTA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTA_DATAALTERACAO: TDateTime read FMTA_DATAALTERACAO write FMTA_DATAALTERACAO;

    [Column('MTA_CIDADE', ftString, 100)]
    [Dictionary('MTA_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_CIDADE: Nullable<String> read FMTA_CIDADE write FMTA_CIDADE;
  end;

implementation

uses ormbr.container.objectset; 

{ TMTA_00_01 } 

procedure TMTA_00_01.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TMTA_00_01>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TMTA_00_01>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TMTA_00_01(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TMTA_00_01);
  TCoreRegisterClass.RegisterEntity(TMTA_00_01);

end.
