unit express.dbo.images;

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
  [Table('IMAGES', 'SELECT * FROM IMAGES')]
  [PrimaryKey('IMG_CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TIMAGES = class(TModelBase)
  private
    { Private declarations } 
    FIMG_CODIGO: Integer;
    FIMG_DESCRICAO: Nullable<String>;
    FIMG_CATEGORIA: Nullable<String>;
    FIMG_HEIGHT: Nullable<Integer>;
    FIMG_WIDTH: Nullable<Integer>;
    FIMG_IMAGEM_B64: TBlob;
    FIMG_IMAGEM_B64_HOT: TBlob;
    FIMG_IMAGEM_B64_DISABLED: TBlob;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('IMG_CODIGO', ftInteger)]
    [Dictionary('IMG_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property IMG_CODIGO: Integer read FIMG_CODIGO write FIMG_CODIGO;

    [Column('IMG_DESCRICAO', ftString, 50)]
    [Dictionary('IMG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_DESCRICAO: Nullable<String> read FIMG_DESCRICAO write FIMG_DESCRICAO;

    [Column('IMG_CATEGORIA', ftString, 30)]
    [Dictionary('IMG_CATEGORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_CATEGORIA: Nullable<String> read FIMG_CATEGORIA write FIMG_CATEGORIA;

    [Column('IMG_HEIGHT', ftInteger)]
    [Dictionary('IMG_HEIGHT', 'Mensagem de validação', '', '', '', taCenter)]
    property IMG_HEIGHT: Nullable<Integer> read FIMG_HEIGHT write FIMG_HEIGHT;

    [Column('IMG_WIDTH', ftInteger)]
    [Dictionary('IMG_WIDTH', 'Mensagem de validação', '', '', '', taCenter)]
    property IMG_WIDTH: Nullable<Integer> read FIMG_WIDTH write FIMG_WIDTH;

    [Column('IMG_IMAGEM_B64', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64: TBlob read FIMG_IMAGEM_B64 write FIMG_IMAGEM_B64;

    [Column('IMG_IMAGEM_B64_HOT', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64_HOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64_HOT: TBlob read FIMG_IMAGEM_B64_HOT write FIMG_IMAGEM_B64_HOT;

    [Column('IMG_IMAGEM_B64_DISABLED', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64_DISABLED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64_DISABLED: TBlob read FIMG_IMAGEM_B64_DISABLED write FIMG_IMAGEM_B64_DISABLED;
  end;

implementation

uses ormbr.container.objectset; 

{ TIMAGES } 

procedure TIMAGES.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TIMAGES>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TIMAGES>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TIMAGES(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TIMAGES);
  TCoreRegisterClass.RegisterEntity(TIMAGES);

end.
