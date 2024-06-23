unit express.dbo.G_NEIA;

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
  [Table('G_NEIA', '')]
  [PrimaryKey('NEIA_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NEIA_ID')]
  TDtoG_NEIA = class
  private
    { Private declarations } 
    FNEIA_ID: Integer;
    FNEIA_CAPTION: String;
    FNEIA_DESCRIPTION: String;
    FNEIA_LINK: String;
    FNEIA_KEYWORDS: String;
    FNEIA_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'G_NEIA';
     const PrimaryKey = 'NEIA_ID';
     const Sequence   = 'SEQ_NEIA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NEIA_ID', ftInteger)]
    [Dictionary('NEIA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NEIA_ID: Integer read FNEIA_ID write FNEIA_ID;
    const NEIA_ID_Name = 'NEIA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NEIA_CAPTION', ftString, 100)]
    [Dictionary('NEIA_CAPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NEIA_CAPTION: String read FNEIA_CAPTION write FNEIA_CAPTION;
    const NEIA_CAPTION_Name = 'NEIA_CAPTION';

    [Restrictions([NoValidate])]
    [Column('NEIA_DESCRIPTION', ftString, 8000)]
    [Dictionary('NEIA_DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NEIA_DESCRIPTION: String read FNEIA_DESCRIPTION write FNEIA_DESCRIPTION;
    const NEIA_DESCRIPTION_Name = 'NEIA_DESCRIPTION';

    [Restrictions([NoValidate])]
    [Column('NEIA_LINK', ftString, 100)]
    [Dictionary('NEIA_LINK', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NEIA_LINK: String read FNEIA_LINK write FNEIA_LINK;
    const NEIA_LINK_Name = 'NEIA_LINK';

    [Restrictions([NoValidate])]
    [Column('NEIA_KEYWORDS', ftString, 500)]
    [Dictionary('NEIA_KEYWORDS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NEIA_KEYWORDS: String read FNEIA_KEYWORDS write FNEIA_KEYWORDS;
    const NEIA_KEYWORDS_Name = 'NEIA_KEYWORDS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NEIA_DATAALTERACAO', ftDateTime)]
    [Dictionary('NEIA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NEIA_DATAALTERACAO: TDateTime read FNEIA_DATAALTERACAO write FNEIA_DATAALTERACAO;
    const NEIA_DATAALTERACAO_Name = 'NEIA_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_NEIA)

end.
