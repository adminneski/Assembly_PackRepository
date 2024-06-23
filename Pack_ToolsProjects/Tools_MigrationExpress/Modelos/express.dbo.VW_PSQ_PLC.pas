unit express.dbo.VW_PSQ_PLC;

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
  [Table('VW_PSQ_PLC', '')]
  TDtoVW_PSQ_PLC = class
  private
    { Private declarations } 
    FPLC_CODIGO: Integer;
    FPLC_PLANOCONTA: String;
    FPLC_DESCRICAO: String;
    FPLC_DESATIVADO: String;
    FPLC_DATAALTERACAO: TDateTime;
    FPLC_SIGLA: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PLC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_PLANOCONTA', ftString, 10)]
    [Dictionary('PLC_PLANOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_PLANOCONTA: String read FPLC_PLANOCONTA write FPLC_PLANOCONTA;
    const PLC_PLANOCONTA_Name = 'PLC_PLANOCONTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DESCRICAO', ftString, 30)]
    [Dictionary('PLC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESCRICAO: String read FPLC_DESCRICAO write FPLC_DESCRICAO;
    const PLC_DESCRICAO_Name = 'PLC_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DESATIVADO', ftString, 1)]
    [Dictionary('PLC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESATIVADO: String read FPLC_DESATIVADO write FPLC_DESATIVADO;
    const PLC_DESATIVADO_Name = 'PLC_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PLC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PLC_DATAALTERACAO: TDateTime read FPLC_DATAALTERACAO write FPLC_DATAALTERACAO;
    const PLC_DATAALTERACAO_Name = 'PLC_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_SIGLA', ftString, 3)]
    [Dictionary('PLC_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_SIGLA: String read FPLC_SIGLA write FPLC_SIGLA;
    const PLC_SIGLA_Name = 'PLC_SIGLA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PLC)

end.
