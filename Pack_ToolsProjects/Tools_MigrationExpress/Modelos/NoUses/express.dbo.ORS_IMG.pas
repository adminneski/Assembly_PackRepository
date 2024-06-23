unit express.dbo.ors_img;

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
  [Table('ORS_IMG', 'SELECT * FROM ORS_IMG')]
  [PrimaryKey('ORS_IMG_ID', NotInc, NoSort, False, 'Chave primária')]
  TORS_IMG = class(TModelBase)
  private
    { Private declarations } 
    FORS_ID: Nullable<Integer>;
    FORS_IMG_ID: Integer;
    FCOM_CODIGO: String;
    FORS_IMAGEM: TBlob;
    FORS_DATAALTERACAO: Nullable<TDateTime>;
    FORS_IMG_ID_OLD: Nullable<Integer>;
    FORS_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Column('ORS_ID', ftInteger)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_ID: Nullable<Integer> read FORS_ID write FORS_ID;

    [Restrictions([NotNull])]
    [Column('ORS_IMG_ID', ftInteger)]
    [Dictionary('ORS_IMG_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_IMG_ID: Integer read FORS_IMG_ID write FORS_IMG_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Column('ORS_IMAGEM', ftBlob)]
    [Dictionary('ORS_IMAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_IMAGEM: TBlob read FORS_IMAGEM write FORS_IMAGEM;

    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAALTERACAO: Nullable<TDateTime> read FORS_DATAALTERACAO write FORS_DATAALTERACAO;

    [Column('ORS_IMG_ID_OLD', ftInteger)]
    [Dictionary('ORS_IMG_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_IMG_ID_OLD: Nullable<Integer> read FORS_IMG_ID_OLD write FORS_IMG_ID_OLD;

    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_ID_OLD: Nullable<Integer> read FORS_ID_OLD write FORS_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TORS_IMG } 

procedure TORS_IMG.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TORS_IMG>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TORS_IMG>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TORS_IMG(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TORS_IMG);
  TCoreRegisterClass.RegisterEntity(TORS_IMG);

end.
