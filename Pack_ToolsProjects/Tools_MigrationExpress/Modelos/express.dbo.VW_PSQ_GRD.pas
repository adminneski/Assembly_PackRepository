unit express.dbo.VW_PSQ_GRD;

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
  [Table('VW_PSQ_GRD', '')]
  TDtoVW_PSQ_GRD = class
  private
    { Private declarations } 
    FGRD_CODIGO: String;
    FGRD_DESCRICAO: String;
    FGRD_DESATIVADO: String;
    FGRD_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_GRD';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_DESCRICAO', ftString, 50)]
    [Dictionary('GRD_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_DESCRICAO: String read FGRD_DESCRICAO write FGRD_DESCRICAO;
    const GRD_DESCRICAO_Name = 'GRD_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_DESATIVADO', ftString, 1)]
    [Dictionary('GRD_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_DESATIVADO: String read FGRD_DESATIVADO write FGRD_DESATIVADO;
    const GRD_DESATIVADO_Name = 'GRD_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_DATAALTERACAO', ftDateTime)]
    [Dictionary('GRD_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property GRD_DATAALTERACAO: TDateTime read FGRD_DATAALTERACAO write FGRD_DATAALTERACAO;
    const GRD_DATAALTERACAO_Name = 'GRD_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_GRD)

end.
