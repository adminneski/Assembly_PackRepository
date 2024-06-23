unit express.dbo.pro_img;

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
  [Table('PRO_IMG', 'SELECT * FROM PRO_IMG')]
  [PrimaryKey('PRO_IMG_ID', NotInc, NoSort, False, 'Chave primária')]
  TPRO_IMG = class(TModelBase)
  private
    { Private declarations } 
    FPRO_IMG_ID: Integer;
    FPRO_CODIGO: Integer;
    FPRO_IMAGEM: TBlob;
    FPRO_DATAALTERACAO: Nullable<TDateTime>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('PRO_IMG_ID', ftInteger)]
    [Dictionary('PRO_IMG_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_IMG_ID: Integer read FPRO_IMG_ID write FPRO_IMG_ID;

    [Restrictions([NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;

    [Column('PRO_IMAGEM', ftBlob)]
    [Dictionary('PRO_IMAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_IMAGEM: TBlob read FPRO_IMAGEM write FPRO_IMAGEM;

    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAALTERACAO: Nullable<TDateTime> read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
  end;

implementation

uses ormbr.container.objectset; 

{ TPRO_IMG } 

procedure TPRO_IMG.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TPRO_IMG>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TPRO_IMG>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TPRO_IMG(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TPRO_IMG);
  TCoreRegisterClass.RegisterEntity(TPRO_IMG);

end.
