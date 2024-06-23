unit express.dbo.VW_PSQ_LEE;

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
  [Table('VW_PSQ_LEE', '')]
  TDtoVW_PSQ_LEE = class
  private
    { Private declarations } 
    FLEE_CODIGO: Integer;
    FLEE_DESCRICAO: String;
    FLEE_COMENTARIO: String;
    FLEE_DESATIVADO: String;
    FLEE_DATAALTERACAO: TDateTime;
    FLEE_DESTAQUE_NF: String;
    FLEE_SIMBOLO: String;
    FLEE_UF: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_LEE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DESCRICAO', ftString, 100)]
    [Dictionary('LEE_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESCRICAO: String read FLEE_DESCRICAO write FLEE_DESCRICAO;
    const LEE_DESCRICAO_Name = 'LEE_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LEE_COMENTARIO', ftString, 300)]
    [Dictionary('LEE_COMENTARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_COMENTARIO: String read FLEE_COMENTARIO write FLEE_COMENTARIO;
    const LEE_COMENTARIO_Name = 'LEE_COMENTARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DESATIVADO', ftString, 1)]
    [Dictionary('LEE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESATIVADO: String read FLEE_DESATIVADO write FLEE_DESATIVADO;
    const LEE_DESATIVADO_Name = 'LEE_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LEE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LEE_DATAALTERACAO: TDateTime read FLEE_DATAALTERACAO write FLEE_DATAALTERACAO;
    const LEE_DATAALTERACAO_Name = 'LEE_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DESTAQUE_NF', ftString, 1)]
    [Dictionary('LEE_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESTAQUE_NF: String read FLEE_DESTAQUE_NF write FLEE_DESTAQUE_NF;
    const LEE_DESTAQUE_NF_Name = 'LEE_DESTAQUE_NF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_SIMBOLO', ftString, 1)]
    [Dictionary('LEE_SIMBOLO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_SIMBOLO: String read FLEE_SIMBOLO write FLEE_SIMBOLO;
    const LEE_SIMBOLO_Name = 'LEE_SIMBOLO';

    [Restrictions([NoValidate])]
    [Column('LEE_UF', ftString, 2)]
    [Dictionary('LEE_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_UF: String read FLEE_UF write FLEE_UF;
    const LEE_UF_Name = 'LEE_UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_LEE)

end.
