unit express.dbo.VW_PSQ_FSP;

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
  [Table('VW_PSQ_FSP', '')]
  TDtoVW_PSQ_FSP = class
  private
    { Private declarations } 
    FFSP_CODIGO: Integer;
    FFSP_DESCRICAO: String;
    FFSP_DESATIVADO: String;
    FFSP_DATAALTERACAO: TDateTime;
    FFSP_TIPO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_FSP';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_CODIGO', ftInteger)]
    [Dictionary('FSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FSP_CODIGO: Integer read FFSP_CODIGO write FFSP_CODIGO;
    const FSP_CODIGO_Name = 'FSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_DESCRICAO', ftString, 50)]
    [Dictionary('FSP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FSP_DESCRICAO: String read FFSP_DESCRICAO write FFSP_DESCRICAO;
    const FSP_DESCRICAO_Name = 'FSP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_DESATIVADO', ftString, 1)]
    [Dictionary('FSP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FSP_DESATIVADO: String read FFSP_DESATIVADO write FFSP_DESATIVADO;
    const FSP_DESATIVADO_Name = 'FSP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_DATAALTERACAO', ftDateTime)]
    [Dictionary('FSP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FSP_DATAALTERACAO: TDateTime read FFSP_DATAALTERACAO write FFSP_DATAALTERACAO;
    const FSP_DATAALTERACAO_Name = 'FSP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_TIPO', ftString, 1)]
    [Dictionary('FSP_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FSP_TIPO: String read FFSP_TIPO write FFSP_TIPO;
    const FSP_TIPO_Name = 'FSP_TIPO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_FSP)

end.
