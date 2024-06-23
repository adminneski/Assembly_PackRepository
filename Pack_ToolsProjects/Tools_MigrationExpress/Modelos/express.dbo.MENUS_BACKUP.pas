unit express.dbo.MENUS_BACKUP;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MENUS_BACKUP', '')]
  [PrimaryKey('MEN_CODIGO', AutoInc, NoSort, False, 'Chave prim�ria')]
  [Sequence('SEQ_MEN_CODIGO')]
  TDtoMENUS_BACKUP = class
  private
    { Private declarations } 
    FMEN_CODIGO: Integer;
    FMEN_MOBILE: String;
    FMEN_CATEGORY: String;
    FMEN_ORDERCATEGORY: Integer;
    FMEN_SUBCATEGORY: String;
    FMEN_ORDERSUBCATEGORY: Integer;
    FMEN_CLASSNAME: String;
    FMEN_REPORTNAME: String;
    FMEN_CAPTION: String;
    FMEN_CAPTIONREDUCED: String;
    FMEN_SYSTEMIDENTIFICATIONKEYS: String;
    FMEN_INFORMATION: String;
    FMEN_IMAGEFILENAME: String;
    FMEN_KEYWORDS: String;
    FIMG_CODIGO: Integer;
    FIMG_CODIGOCATEGORY: Integer;
    FMEN_TOVIEW: String;
  public 
    { Public declarations } 
     const Table      = 'MENUS_BACKUP';
     const PrimaryKey = 'MEN_CODIGO';
     const Sequence   = 'SEQ_MEN_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [Dictionary('MEN_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;
    const MEN_CODIGO_Name = 'MEN_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_MOBILE', ftString, 1)]
    [Dictionary('MEN_MOBILE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_MOBILE: String read FMEN_MOBILE write FMEN_MOBILE;
    const MEN_MOBILE_Name = 'MEN_MOBILE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CATEGORY', ftString, 50)]
    [Dictionary('MEN_CATEGORY', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_CATEGORY: String read FMEN_CATEGORY write FMEN_CATEGORY;
    const MEN_CATEGORY_Name = 'MEN_CATEGORY';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_ORDERCATEGORY', ftInteger)]
    [Dictionary('MEN_ORDERCATEGORY', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property MEN_ORDERCATEGORY: Integer read FMEN_ORDERCATEGORY write FMEN_ORDERCATEGORY;
    const MEN_ORDERCATEGORY_Name = 'MEN_ORDERCATEGORY';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_SUBCATEGORY', ftString, 50)]
    [Dictionary('MEN_SUBCATEGORY', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_SUBCATEGORY: String read FMEN_SUBCATEGORY write FMEN_SUBCATEGORY;
    const MEN_SUBCATEGORY_Name = 'MEN_SUBCATEGORY';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_ORDERSUBCATEGORY', ftInteger)]
    [Dictionary('MEN_ORDERSUBCATEGORY', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property MEN_ORDERSUBCATEGORY: Integer read FMEN_ORDERSUBCATEGORY write FMEN_ORDERSUBCATEGORY;
    const MEN_ORDERSUBCATEGORY_Name = 'MEN_ORDERSUBCATEGORY';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CLASSNAME', ftString, 50)]
    [Dictionary('MEN_CLASSNAME', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_CLASSNAME: String read FMEN_CLASSNAME write FMEN_CLASSNAME;
    const MEN_CLASSNAME_Name = 'MEN_CLASSNAME';

    [Restrictions([NoValidate])]
    [Column('MEN_REPORTNAME', ftString, 50)]
    [Dictionary('MEN_REPORTNAME', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_REPORTNAME: String read FMEN_REPORTNAME write FMEN_REPORTNAME;
    const MEN_REPORTNAME_Name = 'MEN_REPORTNAME';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CAPTION', ftString, 100)]
    [Dictionary('MEN_CAPTION', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_CAPTION: String read FMEN_CAPTION write FMEN_CAPTION;
    const MEN_CAPTION_Name = 'MEN_CAPTION';

    [Restrictions([NoValidate])]
    [Column('MEN_CAPTIONREDUCED', ftString, 50)]
    [Dictionary('MEN_CAPTIONREDUCED', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_CAPTIONREDUCED: String read FMEN_CAPTIONREDUCED write FMEN_CAPTIONREDUCED;
    const MEN_CAPTIONREDUCED_Name = 'MEN_CAPTIONREDUCED';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_SYSTEMIDENTIFICATIONKEYS', ftString, 100)]
    [Dictionary('MEN_SYSTEMIDENTIFICATIONKEYS', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_SYSTEMIDENTIFICATIONKEYS: String read FMEN_SYSTEMIDENTIFICATIONKEYS write FMEN_SYSTEMIDENTIFICATIONKEYS;
    const MEN_SYSTEMIDENTIFICATIONKEYS_Name = 'MEN_SYSTEMIDENTIFICATIONKEYS';

    [Restrictions([NoValidate])]
    [Column('MEN_INFORMATION', ftString, 8000)]
    [Dictionary('MEN_INFORMATION', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_INFORMATION: String read FMEN_INFORMATION write FMEN_INFORMATION;
    const MEN_INFORMATION_Name = 'MEN_INFORMATION';

    [Restrictions([NoValidate])]
    [Column('MEN_IMAGEFILENAME', ftString, 50)]
    [Dictionary('MEN_IMAGEFILENAME', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_IMAGEFILENAME: String read FMEN_IMAGEFILENAME write FMEN_IMAGEFILENAME;
    const MEN_IMAGEFILENAME_Name = 'MEN_IMAGEFILENAME';

    [Restrictions([NoValidate])]
    [Column('MEN_KEYWORDS', ftString, 500)]
    [Dictionary('MEN_KEYWORDS', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_KEYWORDS: String read FMEN_KEYWORDS write FMEN_KEYWORDS;
    const MEN_KEYWORDS_Name = 'MEN_KEYWORDS';

    [Restrictions([NoValidate])]
    [Column('IMG_CODIGO', ftInteger)]
    [Dictionary('IMG_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property IMG_CODIGO: Integer read FIMG_CODIGO write FIMG_CODIGO;
    const IMG_CODIGO_Name = 'IMG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('IMG_CODIGOCATEGORY', ftInteger)]
    [Dictionary('IMG_CODIGOCATEGORY', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property IMG_CODIGOCATEGORY: Integer read FIMG_CODIGOCATEGORY write FIMG_CODIGOCATEGORY;
    const IMG_CODIGOCATEGORY_Name = 'IMG_CODIGOCATEGORY';

    [Restrictions([NoValidate])]
    [Column('MEN_TOVIEW', ftString, 1)]
    [Dictionary('MEN_TOVIEW', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property MEN_TOVIEW: String read FMEN_TOVIEW write FMEN_TOVIEW;
    const MEN_TOVIEW_Name = 'MEN_TOVIEW';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMENUS_BACKUP)

end.