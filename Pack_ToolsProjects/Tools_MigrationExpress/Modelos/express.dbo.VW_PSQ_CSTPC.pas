unit express.dbo.VW_PSQ_CSTPC;

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
  [Table('VW_PSQ_CSTPC', '')]
  TDtoVW_PSQ_CSTPC = class
  private
    { Private declarations } 
    FCSTPC_CODIGO: String;
    FCSTPC_DESCRICAO: String;
    FCSTPC_DESATIVADO: String;
    FCSTPC_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CSTPC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_DESCRICAO', ftString, 300)]
    [Dictionary('CSTPC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_DESCRICAO: String read FCSTPC_DESCRICAO write FCSTPC_DESCRICAO;
    const CSTPC_DESCRICAO_Name = 'CSTPC_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_DESATIVADO', ftString, 1)]
    [Dictionary('CSTPC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_DESATIVADO: String read FCSTPC_DESATIVADO write FCSTPC_DESATIVADO;
    const CSTPC_DESATIVADO_Name = 'CSTPC_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_DATAALTERACAO', ftDateTime)]
    [Dictionary('CSTPC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CSTPC_DATAALTERACAO: TDateTime read FCSTPC_DATAALTERACAO write FCSTPC_DATAALTERACAO;
    const CSTPC_DATAALTERACAO_Name = 'CSTPC_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CSTPC)

end.
