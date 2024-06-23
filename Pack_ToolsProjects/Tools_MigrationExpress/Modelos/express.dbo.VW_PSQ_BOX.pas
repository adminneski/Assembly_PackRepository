unit express.dbo.VW_PSQ_BOX;

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
  [Table('VW_PSQ_BOX', '')]
  TDtoVW_PSQ_BOX = class
  private
    { Private declarations } 
    FBOX_CODIGO: String;
    FBOX_DESCRICAO: String;
    FBOX_DESATIVADO: String;
    FBOX_ORDEM: Integer;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_BOX';

    [Restrictions([NoValidate, NotNull])]
    [Column('BOX_CODIGO', ftString, 3)]
    [Dictionary('BOX_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BOX_CODIGO: String read FBOX_CODIGO write FBOX_CODIGO;
    const BOX_CODIGO_Name = 'BOX_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BOX_DESCRICAO', ftString, 100)]
    [Dictionary('BOX_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BOX_DESCRICAO: String read FBOX_DESCRICAO write FBOX_DESCRICAO;
    const BOX_DESCRICAO_Name = 'BOX_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('BOX_DESATIVADO', ftString, 1)]
    [Dictionary('BOX_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BOX_DESATIVADO: String read FBOX_DESATIVADO write FBOX_DESATIVADO;
    const BOX_DESATIVADO_Name = 'BOX_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('BOX_ORDEM', ftInteger)]
    [Dictionary('BOX_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property BOX_ORDEM: Integer read FBOX_ORDEM write FBOX_ORDEM;
    const BOX_ORDEM_Name = 'BOX_ORDEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_BOX)

end.
