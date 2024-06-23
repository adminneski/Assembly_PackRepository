unit express.dbo.menus;

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
  [Table('MENUS', 'SELECT * FROM MENUS')]
  [PrimaryKey('MEN_CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TMENUS = class(TModelBase)
  private
    { Private declarations } 
    FMEN_CODIGO: Integer;
    FMEN_MOBILE: String;
    FMEN_CATEGORY: String;
    FMEN_ORDERCATEGORY: Integer;
    FMEN_SUBCATEGORY: String;
    FMEN_ORDERSUBCATEGORY: Integer;
    FMEN_CLASSNAME: String;
    FMEN_REPORTNAME: Nullable<String>;
    FMEN_CAPTION: String;
    FMEN_CAPTIONREDUCED: Nullable<String>;
    FMEN_SYSTEMIDENTIFICATIONKEYS: String;
    FMEN_INFORMATION: Nullable<String>;
    FMEN_IMAGEFILENAME: Nullable<String>;
    FMEN_KEYWORDS: Nullable<String>;
    FIMG_CODIGO: Nullable<Integer>;
    FIMG_CODIGOCATEGORY: Nullable<Integer>;
    FMEN_TOVIEW: Nullable<String>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [Dictionary('MEN_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;

    [Restrictions([NotNull])]
    [Column('MEN_MOBILE', ftString, 1)]
    [Dictionary('MEN_MOBILE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_MOBILE: String read FMEN_MOBILE write FMEN_MOBILE;

    [Restrictions([NotNull])]
    [Column('MEN_CATEGORY', ftString, 50)]
    [Dictionary('MEN_CATEGORY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CATEGORY: String read FMEN_CATEGORY write FMEN_CATEGORY;

    [Restrictions([NotNull])]
    [Column('MEN_ORDERCATEGORY', ftInteger)]
    [Dictionary('MEN_ORDERCATEGORY', 'Mensagem de validação', '', '', '', taCenter)]
    property MEN_ORDERCATEGORY: Integer read FMEN_ORDERCATEGORY write FMEN_ORDERCATEGORY;

    [Restrictions([NotNull])]
    [Column('MEN_SUBCATEGORY', ftString, 50)]
    [Dictionary('MEN_SUBCATEGORY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_SUBCATEGORY: String read FMEN_SUBCATEGORY write FMEN_SUBCATEGORY;

    [Restrictions([NotNull])]
    [Column('MEN_ORDERSUBCATEGORY', ftInteger)]
    [Dictionary('MEN_ORDERSUBCATEGORY', 'Mensagem de validação', '', '', '', taCenter)]
    property MEN_ORDERSUBCATEGORY: Integer read FMEN_ORDERSUBCATEGORY write FMEN_ORDERSUBCATEGORY;

    [Restrictions([NotNull])]
    [Column('MEN_CLASSNAME', ftString, 50)]
    [Dictionary('MEN_CLASSNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CLASSNAME: String read FMEN_CLASSNAME write FMEN_CLASSNAME;

    [Column('MEN_REPORTNAME', ftString, 50)]
    [Dictionary('MEN_REPORTNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_REPORTNAME: Nullable<String> read FMEN_REPORTNAME write FMEN_REPORTNAME;

    [Restrictions([NotNull])]
    [Column('MEN_CAPTION', ftString, 100)]
    [Dictionary('MEN_CAPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CAPTION: String read FMEN_CAPTION write FMEN_CAPTION;

    [Column('MEN_CAPTIONREDUCED', ftString, 50)]
    [Dictionary('MEN_CAPTIONREDUCED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CAPTIONREDUCED: Nullable<String> read FMEN_CAPTIONREDUCED write FMEN_CAPTIONREDUCED;

    [Restrictions([NotNull])]
    [Column('MEN_SYSTEMIDENTIFICATIONKEYS', ftString, 100)]
    [Dictionary('MEN_SYSTEMIDENTIFICATIONKEYS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_SYSTEMIDENTIFICATIONKEYS: String read FMEN_SYSTEMIDENTIFICATIONKEYS write FMEN_SYSTEMIDENTIFICATIONKEYS;

    [Column('MEN_INFORMATION', ftString, 8000)]
    [Dictionary('MEN_INFORMATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_INFORMATION: Nullable<String> read FMEN_INFORMATION write FMEN_INFORMATION;

    [Column('MEN_IMAGEFILENAME', ftString, 50)]
    [Dictionary('MEN_IMAGEFILENAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_IMAGEFILENAME: Nullable<String> read FMEN_IMAGEFILENAME write FMEN_IMAGEFILENAME;

    [Column('MEN_KEYWORDS', ftString, 500)]
    [Dictionary('MEN_KEYWORDS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_KEYWORDS: Nullable<String> read FMEN_KEYWORDS write FMEN_KEYWORDS;

    [Column('IMG_CODIGO', ftInteger)]
    [Dictionary('IMG_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property IMG_CODIGO: Nullable<Integer> read FIMG_CODIGO write FIMG_CODIGO;

    [Column('IMG_CODIGOCATEGORY', ftInteger)]
    [Dictionary('IMG_CODIGOCATEGORY', 'Mensagem de validação', '', '', '', taCenter)]
    property IMG_CODIGOCATEGORY: Nullable<Integer> read FIMG_CODIGOCATEGORY write FIMG_CODIGOCATEGORY;

    [Column('MEN_TOVIEW', ftString, 1)]
    [Dictionary('MEN_TOVIEW', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_TOVIEW: Nullable<String> read FMEN_TOVIEW write FMEN_TOVIEW;
  end;

implementation

uses ormbr.container.objectset; 

{ TMENUS } 

procedure TMENUS.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TMENUS>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TMENUS>.Create(ATargetConn); 
  try 
    //LContainerObjectSet.Insert(TMENUS(AObject));
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TMENUS);
  TCoreRegisterClass.RegisterEntity(TMENUS);

end.
