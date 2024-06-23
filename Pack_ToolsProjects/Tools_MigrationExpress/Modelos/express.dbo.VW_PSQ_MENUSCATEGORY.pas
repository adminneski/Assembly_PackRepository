unit express.dbo.VW_PSQ_MENUSCATEGORY;

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
  [Table('VW_PSQ_MENUSCATEGORY', '')]
  TDtoVW_PSQ_MENUSCATEGORY = class
  private
    { Private declarations } 
    FMEN_CATEGORY: String;
    FIMG_CODIGOCATEGORY: Integer;
    FMEN_MOBILE: String;
    FMEN_TOVIEW: String;
    FMEN_SYSTEMIDENTIFICATIONKEYS: String;
    FIMG_IMAGEM_B64_CAT: TBlob;
    FIMG_IMAGEM_B64_HOT_CAT: TBlob;
    FIMG_IMAGEM_B64_DISABLED_CAT: TBlob;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MENUSCATEGORY';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CATEGORY', ftString, 50)]
    [Dictionary('MEN_CATEGORY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CATEGORY: String read FMEN_CATEGORY write FMEN_CATEGORY;
    const MEN_CATEGORY_Name = 'MEN_CATEGORY';

    [Restrictions([NoValidate])]
    [Column('IMG_CODIGOCATEGORY', ftInteger)]
    [Dictionary('IMG_CODIGOCATEGORY', 'Mensagem de validação', '0', '', '', taCenter)]
    property IMG_CODIGOCATEGORY: Integer read FIMG_CODIGOCATEGORY write FIMG_CODIGOCATEGORY;
    const IMG_CODIGOCATEGORY_Name = 'IMG_CODIGOCATEGORY';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_MOBILE', ftString, 1)]
    [Dictionary('MEN_MOBILE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_MOBILE: String read FMEN_MOBILE write FMEN_MOBILE;
    const MEN_MOBILE_Name = 'MEN_MOBILE';

    [Restrictions([NoValidate])]
    [Column('MEN_TOVIEW', ftString, 1)]
    [Dictionary('MEN_TOVIEW', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_TOVIEW: String read FMEN_TOVIEW write FMEN_TOVIEW;
    const MEN_TOVIEW_Name = 'MEN_TOVIEW';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_SYSTEMIDENTIFICATIONKEYS', ftString, 100)]
    [Dictionary('MEN_SYSTEMIDENTIFICATIONKEYS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_SYSTEMIDENTIFICATIONKEYS: String read FMEN_SYSTEMIDENTIFICATIONKEYS write FMEN_SYSTEMIDENTIFICATIONKEYS;
    const MEN_SYSTEMIDENTIFICATIONKEYS_Name = 'MEN_SYSTEMIDENTIFICATIONKEYS';

    [Restrictions([NoValidate])]
    [Column('IMG_IMAGEM_B64_CAT', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64_CAT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64_CAT: TBlob read FIMG_IMAGEM_B64_CAT write FIMG_IMAGEM_B64_CAT;
    const IMG_IMAGEM_B64_CAT_Name = 'IMG_IMAGEM_B64_CAT';

    [Restrictions([NoValidate])]
    [Column('IMG_IMAGEM_B64_HOT_CAT', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64_HOT_CAT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64_HOT_CAT: TBlob read FIMG_IMAGEM_B64_HOT_CAT write FIMG_IMAGEM_B64_HOT_CAT;
    const IMG_IMAGEM_B64_HOT_CAT_Name = 'IMG_IMAGEM_B64_HOT_CAT';

    [Restrictions([NoValidate])]
    [Column('IMG_IMAGEM_B64_DISABLED_CAT', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64_DISABLED_CAT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64_DISABLED_CAT: TBlob read FIMG_IMAGEM_B64_DISABLED_CAT write FIMG_IMAGEM_B64_DISABLED_CAT;
    const IMG_IMAGEM_B64_DISABLED_CAT_Name = 'IMG_IMAGEM_B64_DISABLED_CAT';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MENUSCATEGORY)

end.
