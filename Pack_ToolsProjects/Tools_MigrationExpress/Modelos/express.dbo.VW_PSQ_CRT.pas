unit express.dbo.VW_PSQ_CRT;

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
  [Table('VW_PSQ_CRT', '')]
  TDtoVW_PSQ_CRT = class
  private
    { Private declarations } 
    FCRT_CODIGO: Integer;
    FCRT_DESCRICAO: String;
    FCRT_DIARECEBIMENTO: Integer;
    FCRT_PERCENTUALFINANCEIRO: Double;
    FCRT_DESATIVADO: String;
    FCRT_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CRT';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DESCRICAO', ftString, 30)]
    [Dictionary('CRT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRT_DESCRICAO: String read FCRT_DESCRICAO write FCRT_DESCRICAO;
    const CRT_DESCRICAO_Name = 'CRT_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DIARECEBIMENTO', ftInteger)]
    [Dictionary('CRT_DIARECEBIMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_DIARECEBIMENTO: Integer read FCRT_DIARECEBIMENTO write FCRT_DIARECEBIMENTO;
    const CRT_DIARECEBIMENTO_Name = 'CRT_DIARECEBIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CRT_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRT_PERCENTUALFINANCEIRO: Double read FCRT_PERCENTUALFINANCEIRO write FCRT_PERCENTUALFINANCEIRO;
    const CRT_PERCENTUALFINANCEIRO_Name = 'CRT_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DESATIVADO', ftString, 1)]
    [Dictionary('CRT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRT_DESATIVADO: String read FCRT_DESATIVADO write FCRT_DESATIVADO;
    const CRT_DESATIVADO_Name = 'CRT_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRT_DATAALTERACAO: TDateTime read FCRT_DATAALTERACAO write FCRT_DATAALTERACAO;
    const CRT_DATAALTERACAO_Name = 'CRT_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CRT)

end.
