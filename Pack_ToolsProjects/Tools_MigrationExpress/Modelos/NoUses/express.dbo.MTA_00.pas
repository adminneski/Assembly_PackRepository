unit express.dbo.mta_00;

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
  [Table('MTA_00', 'SELECT * FROM MTA_00')]
  [PrimaryKey('MTA_CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TMTA_00 = class(TModelBase)
  private
    { Private declarations } 
    FMTA_CODIGO: Integer;
    FMTA_DESCRICAO: String;
    FMTA_VALOR: Double;
    FMTA_DESATIVADO: String;
    FMTA_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('MTA_CODIGO', ftInteger)]
    [Dictionary('MTA_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property MTA_CODIGO: Integer read FMTA_CODIGO write FMTA_CODIGO;

    [Restrictions([NotNull])]
    [Column('MTA_DESCRICAO', ftString, 30)]
    [Dictionary('MTA_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_DESCRICAO: String read FMTA_DESCRICAO write FMTA_DESCRICAO;

    [Restrictions([NotNull])]
    [Column('MTA_VALOR', ftBCD)]
    [Dictionary('MTA_VALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MTA_VALOR: Double read FMTA_VALOR write FMTA_VALOR;

    [Restrictions([NotNull])]
    [Column('MTA_DESATIVADO', ftString, 1)]
    [Dictionary('MTA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_DESATIVADO: String read FMTA_DESATIVADO write FMTA_DESATIVADO;

    [Restrictions([NotNull])]
    [Column('MTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('MTA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTA_DATAALTERACAO: TDateTime read FMTA_DATAALTERACAO write FMTA_DATAALTERACAO;
  end;

implementation

uses ormbr.container.objectset; 

{ TMTA_00 } 

procedure TMTA_00.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TMTA_00>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TMTA_00>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TMTA_00(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TMTA_00);
  TCoreRegisterClass.RegisterEntity(TMTA_00);

end.
