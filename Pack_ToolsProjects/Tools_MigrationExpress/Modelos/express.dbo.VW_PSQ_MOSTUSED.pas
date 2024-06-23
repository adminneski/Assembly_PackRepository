unit express.dbo.VW_PSQ_MOSTUSED;

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
  [Table('VW_PSQ_MOSTUSED', '')]
  TDtoVW_PSQ_MOSTUSED = class
  private
    { Private declarations } 
    FMUS_ID: Integer;
    FACC_CODIGO: Integer;
    FMUS_MOSTUSED: Integer;
    FMUS_DATETIMELASTACCESS: TDateTime;
    FMEN_CODIGO: Integer;
    FMEN_CATEGORY: String;
    FMEN_SUBCATEGORY: String;
    FMEN_CLASSNAME: String;
    FMEN_REPORTNAME: String;
    FMEN_CAPTION: String;
    FMEN_ORDERCATEGORY: Integer;
    FMEN_ORDERSUBCATEGORY: Integer;
    FMEN_SYSTEMIDENTIFICATIONKEYS: String;
    FMEN_TOVIEW: String;
    FMEN_INFORMATION: String;
    FMEN_IMAGEFILENAME: String;
    FMEN_KEYWORDS: String;
    FIMG_IMAGEM_B64: TBlob;
    FIMG_IMAGEM_B64_HOT: TBlob;
    FIMG_IMAGEM_B64_DISABLED: TBlob;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MOSTUSED';

    [Restrictions([NoValidate, NotNull])]
    [Column('MUS_ID', ftInteger)]
    [Dictionary('MUS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MUS_ID: Integer read FMUS_ID write FMUS_ID;
    const MUS_ID_Name = 'MUS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;
    const ACC_CODIGO_Name = 'ACC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MUS_MOSTUSED', ftInteger)]
    [Dictionary('MUS_MOSTUSED', 'Mensagem de validação', '0', '', '', taCenter)]
    property MUS_MOSTUSED: Integer read FMUS_MOSTUSED write FMUS_MOSTUSED;
    const MUS_MOSTUSED_Name = 'MUS_MOSTUSED';

    [Restrictions([NoValidate])]
    [Column('MUS_DATETIMELASTACCESS', ftDateTime)]
    [Dictionary('MUS_DATETIMELASTACCESS', 'Mensagem de validação', '', '', '', taCenter)]
    property MUS_DATETIMELASTACCESS: TDateTime read FMUS_DATETIMELASTACCESS write FMUS_DATETIMELASTACCESS;
    const MUS_DATETIMELASTACCESS_Name = 'MUS_DATETIMELASTACCESS';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [Dictionary('MEN_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;
    const MEN_CODIGO_Name = 'MEN_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MEN_CATEGORY', ftString, 50)]
    [Dictionary('MEN_CATEGORY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CATEGORY: String read FMEN_CATEGORY write FMEN_CATEGORY;
    const MEN_CATEGORY_Name = 'MEN_CATEGORY';

    [Restrictions([NoValidate])]
    [Column('MEN_SUBCATEGORY', ftString, 50)]
    [Dictionary('MEN_SUBCATEGORY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_SUBCATEGORY: String read FMEN_SUBCATEGORY write FMEN_SUBCATEGORY;
    const MEN_SUBCATEGORY_Name = 'MEN_SUBCATEGORY';

    [Restrictions([NoValidate])]
    [Column('MEN_CLASSNAME', ftString, 50)]
    [Dictionary('MEN_CLASSNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CLASSNAME: String read FMEN_CLASSNAME write FMEN_CLASSNAME;
    const MEN_CLASSNAME_Name = 'MEN_CLASSNAME';

    [Restrictions([NoValidate])]
    [Column('MEN_REPORTNAME', ftString, 50)]
    [Dictionary('MEN_REPORTNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_REPORTNAME: String read FMEN_REPORTNAME write FMEN_REPORTNAME;
    const MEN_REPORTNAME_Name = 'MEN_REPORTNAME';

    [Restrictions([NoValidate])]
    [Column('MEN_CAPTION', ftString, 100)]
    [Dictionary('MEN_CAPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_CAPTION: String read FMEN_CAPTION write FMEN_CAPTION;
    const MEN_CAPTION_Name = 'MEN_CAPTION';

    [Restrictions([NoValidate])]
    [Column('MEN_ORDERCATEGORY', ftInteger)]
    [Dictionary('MEN_ORDERCATEGORY', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEN_ORDERCATEGORY: Integer read FMEN_ORDERCATEGORY write FMEN_ORDERCATEGORY;
    const MEN_ORDERCATEGORY_Name = 'MEN_ORDERCATEGORY';

    [Restrictions([NoValidate])]
    [Column('MEN_ORDERSUBCATEGORY', ftInteger)]
    [Dictionary('MEN_ORDERSUBCATEGORY', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEN_ORDERSUBCATEGORY: Integer read FMEN_ORDERSUBCATEGORY write FMEN_ORDERSUBCATEGORY;
    const MEN_ORDERSUBCATEGORY_Name = 'MEN_ORDERSUBCATEGORY';

    [Restrictions([NoValidate])]
    [Column('MEN_SYSTEMIDENTIFICATIONKEYS', ftString, 100)]
    [Dictionary('MEN_SYSTEMIDENTIFICATIONKEYS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_SYSTEMIDENTIFICATIONKEYS: String read FMEN_SYSTEMIDENTIFICATIONKEYS write FMEN_SYSTEMIDENTIFICATIONKEYS;
    const MEN_SYSTEMIDENTIFICATIONKEYS_Name = 'MEN_SYSTEMIDENTIFICATIONKEYS';

    [Restrictions([NoValidate])]
    [Column('MEN_TOVIEW', ftString, 1)]
    [Dictionary('MEN_TOVIEW', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_TOVIEW: String read FMEN_TOVIEW write FMEN_TOVIEW;
    const MEN_TOVIEW_Name = 'MEN_TOVIEW';

    [Restrictions([NoValidate])]
    [Column('MEN_INFORMATION', ftString, 8000)]
    [Dictionary('MEN_INFORMATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_INFORMATION: String read FMEN_INFORMATION write FMEN_INFORMATION;
    const MEN_INFORMATION_Name = 'MEN_INFORMATION';

    [Restrictions([NoValidate])]
    [Column('MEN_IMAGEFILENAME', ftString, 50)]
    [Dictionary('MEN_IMAGEFILENAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_IMAGEFILENAME: String read FMEN_IMAGEFILENAME write FMEN_IMAGEFILENAME;
    const MEN_IMAGEFILENAME_Name = 'MEN_IMAGEFILENAME';

    [Restrictions([NoValidate])]
    [Column('MEN_KEYWORDS', ftString, 500)]
    [Dictionary('MEN_KEYWORDS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEN_KEYWORDS: String read FMEN_KEYWORDS write FMEN_KEYWORDS;
    const MEN_KEYWORDS_Name = 'MEN_KEYWORDS';

    [Restrictions([NoValidate])]
    [Column('IMG_IMAGEM_B64', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64: TBlob read FIMG_IMAGEM_B64 write FIMG_IMAGEM_B64;
    const IMG_IMAGEM_B64_Name = 'IMG_IMAGEM_B64';

    [Restrictions([NoValidate])]
    [Column('IMG_IMAGEM_B64_HOT', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64_HOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64_HOT: TBlob read FIMG_IMAGEM_B64_HOT write FIMG_IMAGEM_B64_HOT;
    const IMG_IMAGEM_B64_HOT_Name = 'IMG_IMAGEM_B64_HOT';

    [Restrictions([NoValidate])]
    [Column('IMG_IMAGEM_B64_DISABLED', ftBlob)]
    [Dictionary('IMG_IMAGEM_B64_DISABLED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_IMAGEM_B64_DISABLED: TBlob read FIMG_IMAGEM_B64_DISABLED write FIMG_IMAGEM_B64_DISABLED;
    const IMG_IMAGEM_B64_DISABLED_Name = 'IMG_IMAGEM_B64_DISABLED';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MOSTUSED)

end.
