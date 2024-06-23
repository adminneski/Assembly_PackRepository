unit express.dbo.VW_PSQ_FPG;

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
  [Table('VW_PSQ_FPG', '')]
  TDtoVW_PSQ_FPG = class
  private
    { Private declarations } 
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FFPG_DESATIVADO: String;
    FFPG_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_FPG';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_DESATIVADO', ftString, 1)]
    [Dictionary('FPG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESATIVADO: String read FFPG_DESATIVADO write FFPG_DESATIVADO;
    const FPG_DESATIVADO_Name = 'FPG_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_DATAALTERACAO', ftDateTime)]
    [Dictionary('FPG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FPG_DATAALTERACAO: TDateTime read FFPG_DATAALTERACAO write FFPG_DATAALTERACAO;
    const FPG_DATAALTERACAO_Name = 'FPG_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_FPG)

end.
