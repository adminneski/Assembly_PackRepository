unit express.dbo.VW_PSQ_TXS;

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
  [Table('VW_PSQ_TXS', '')]
  TDtoVW_PSQ_TXS = class
  private
    { Private declarations } 
    FTXS_CODIGO: Integer;
    FTXS_DESCRICAO: String;
    FTXS_DESATIVADO: String;
    FTXS_DATAALTERACAO: TDateTime;
    FTXS_UF: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_TXS';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_CODIGO', ftInteger)]
    [Dictionary('TXS_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TXS_CODIGO: Integer read FTXS_CODIGO write FTXS_CODIGO;
    const TXS_CODIGO_Name = 'TXS_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TXS_DESCRICAO', ftString, 50)]
    [Dictionary('TXS_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXS_DESCRICAO: String read FTXS_DESCRICAO write FTXS_DESCRICAO;
    const TXS_DESCRICAO_Name = 'TXS_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_DESATIVADO', ftString, 1)]
    [Dictionary('TXS_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXS_DESATIVADO: String read FTXS_DESATIVADO write FTXS_DESATIVADO;
    const TXS_DESATIVADO_Name = 'TXS_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_DATAALTERACAO', ftDateTime)]
    [Dictionary('TXS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TXS_DATAALTERACAO: TDateTime read FTXS_DATAALTERACAO write FTXS_DATAALTERACAO;
    const TXS_DATAALTERACAO_Name = 'TXS_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_UF', ftString, 2)]
    [Dictionary('TXS_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXS_UF: String read FTXS_UF write FTXS_UF;
    const TXS_UF_Name = 'TXS_UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_TXS)

end.
