unit express.dbo.IMAGES;

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
  [Table('IMAGES', '')]
  [PrimaryKey('IMG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_IMG_CODIGO')]
  TDtoIMAGES = class
  private
    { Private declarations } 
    FIMG_CODIGO: Integer;
    FIMG_DESCRICAO: String;
    FIMG_CATEGORIA: String;
    FIMG_HEIGHT: Integer;
    FIMG_WIDTH: Integer;
    FIMG_IMAGEM_B64: TBlob;
    FIMG_IMAGEM_B64_HOT: TBlob;
    FIMG_IMAGEM_B64_DISABLED: TBlob;
  public 
    { Public declarations } 
     const Table      = 'IMAGES';
     const PrimaryKey = 'IMG_CODIGO';
     const Sequence   = 'SEQ_IMG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IMG_CODIGO', ftInteger)]
    [Dictionary('IMG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property IMG_CODIGO: Integer read FIMG_CODIGO write FIMG_CODIGO;
    const IMG_CODIGO_Name = 'IMG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('IMG_DESCRICAO', ftString, 50)]
    [Dictionary('IMG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_DESCRICAO: String read FIMG_DESCRICAO write FIMG_DESCRICAO;
    const IMG_DESCRICAO_Name = 'IMG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('IMG_CATEGORIA', ftString, 30)]
    [Dictionary('IMG_CATEGORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IMG_CATEGORIA: String read FIMG_CATEGORIA write FIMG_CATEGORIA;
    const IMG_CATEGORIA_Name = 'IMG_CATEGORIA';

    [Restrictions([NoValidate])]
    [Column('IMG_HEIGHT', ftInteger)]
    [Dictionary('IMG_HEIGHT', 'Mensagem de validação', '0', '', '', taCenter)]
    property IMG_HEIGHT: Integer read FIMG_HEIGHT write FIMG_HEIGHT;
    const IMG_HEIGHT_Name = 'IMG_HEIGHT';

    [Restrictions([NoValidate])]
    [Column('IMG_WIDTH', ftInteger)]
    [Dictionary('IMG_WIDTH', 'Mensagem de validação', '0', '', '', taCenter)]
    property IMG_WIDTH: Integer read FIMG_WIDTH write FIMG_WIDTH;
    const IMG_WIDTH_Name = 'IMG_WIDTH';

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
  TRegisterClass.RegisterEntity(TDtoIMAGES)

end.
