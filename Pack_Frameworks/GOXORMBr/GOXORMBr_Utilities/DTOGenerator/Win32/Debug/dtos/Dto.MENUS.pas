unit Dto.MENUS;

interface

uses
  System.SysUtils, 
  System.Classes, 
  Vcl.Graphics, 
  Data.DB, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.consts,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes,
  //Application 
  Core.Mapping.Attributes;

type
  [Entity]
  [Table('MENUS', '')]
  [PrimaryKey('MEN_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MEN_CODIGO')]
  TDtoMENUS = class
  private
    { Private declarations } 
    FMEN_CODIGO: Integer;
    FMEN_CATEGORY: String;
    FMEN_SUBCATEGORY: String;
    FMEN_CAPTION: String;
    FMEN_CAPTIONREDUCED: String;
    FMEN_CLASSNAME: String;
    FMEN_REPORTNAME: String;
    FMEN_SYSTEMIDENTIFICATIONKEYS: String;
    FIMG_CODIGO: Integer;
    FMEN_ORDERCATEGORY: Integer;
    FMEN_ORDERSUBCATEGORY: Integer;
    FMEN_INFORMATION: String;
    FMEN_KEYWORDS: String;
    FMEN_TOVIEW: String;
  public 
    { Public declarations } 
    const Table      = 'MENUS';
    const PrimaryKey = 'MEN_CODIGO';
    const Sequence   = 'SEQ_MEN_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [ColumnDBGrid('MEN_CODIGO', 'MEN_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('MEN_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CATEGORY', ftString, 50)]
    [ColumnDBGrid('MEN_CATEGORY', 'MEN_CATEGORY', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_CATEGORY', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_CATEGORY: String read FMEN_CATEGORY write FMEN_CATEGORY;

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_SUBCATEGORY', ftString, 50)]
    [ColumnDBGrid('MEN_SUBCATEGORY', 'MEN_SUBCATEGORY', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_SUBCATEGORY', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_SUBCATEGORY: String read FMEN_SUBCATEGORY write FMEN_SUBCATEGORY;

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CAPTION', ftString, 100)]
    [ColumnDBGrid('MEN_CAPTION', 'MEN_CAPTION', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_CAPTION', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_CAPTION: String read FMEN_CAPTION write FMEN_CAPTION;

    [Restrictions([NoValidate])]
    [Column('MEN_CAPTIONREDUCED', ftString, 50)]
    [ColumnDBGrid('MEN_CAPTIONREDUCED', 'MEN_CAPTIONREDUCED', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_CAPTIONREDUCED', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_CAPTIONREDUCED: String read FMEN_CAPTIONREDUCED write FMEN_CAPTIONREDUCED;

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CLASSNAME', ftString, 50)]
    [ColumnDBGrid('MEN_CLASSNAME', 'MEN_CLASSNAME', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_CLASSNAME', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_CLASSNAME: String read FMEN_CLASSNAME write FMEN_CLASSNAME;

    [Restrictions([NoValidate])]
    [Column('MEN_REPORTNAME', ftString, 50)]
    [ColumnDBGrid('MEN_REPORTNAME', 'MEN_REPORTNAME', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_REPORTNAME', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_REPORTNAME: String read FMEN_REPORTNAME write FMEN_REPORTNAME;

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_SYSTEMIDENTIFICATIONKEYS', ftString, 100)]
    [ColumnDBGrid('MEN_SYSTEMIDENTIFICATIONKEYS', 'MEN_SYSTEMIDENTIFICATIONKEYS', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_SYSTEMIDENTIFICATIONKEYS', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_SYSTEMIDENTIFICATIONKEYS: String read FMEN_SYSTEMIDENTIFICATIONKEYS write FMEN_SYSTEMIDENTIFICATIONKEYS;

    [Restrictions([NoValidate])]
    [Column('IMG_CODIGO', ftInteger)]
    [ColumnDBGrid('IMG_CODIGO', 'IMG_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('IMG_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property IMG_CODIGO: Integer read FIMG_CODIGO write FIMG_CODIGO;

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_ORDERCATEGORY', ftInteger)]
    [ColumnDBGrid('MEN_ORDERCATEGORY', 'MEN_ORDERCATEGORY', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('MEN_ORDERCATEGORY', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property MEN_ORDERCATEGORY: Integer read FMEN_ORDERCATEGORY write FMEN_ORDERCATEGORY;

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_ORDERSUBCATEGORY', ftInteger)]
    [ColumnDBGrid('MEN_ORDERSUBCATEGORY', 'MEN_ORDERSUBCATEGORY', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('MEN_ORDERSUBCATEGORY', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property MEN_ORDERSUBCATEGORY: Integer read FMEN_ORDERSUBCATEGORY write FMEN_ORDERSUBCATEGORY;

    [Restrictions([NoValidate])]
    [Column('MEN_INFORMATION', ftString, 3000)]
    [ColumnDBGrid('MEN_INFORMATION', 'MEN_INFORMATION', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_INFORMATION', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_INFORMATION: String read FMEN_INFORMATION write FMEN_INFORMATION;

    [Restrictions([NoValidate])]
    [Column('MEN_KEYWORDS', ftString, 500)]
    [ColumnDBGrid('MEN_KEYWORDS', 'MEN_KEYWORDS', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_KEYWORDS', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_KEYWORDS: String read FMEN_KEYWORDS write FMEN_KEYWORDS;

    [Restrictions([NoValidate])]
    [Column('MEN_TOVIEW', ftString, 1)]
    [ColumnDBGrid('MEN_TOVIEW', 'MEN_TOVIEW', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('MEN_TOVIEW', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property MEN_TOVIEW: String read FMEN_TOVIEW write FMEN_TOVIEW;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMENUS)

end.
