unit express.dbo.VW_PSQ_TAB;

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
  [Table('VW_PSQ_TAB', '')]
  TDtoVW_PSQ_TAB = class
  private
    { Private declarations } 
    FTAB_CODIGO: Integer;
    FTAB_DESCRICAO: String;
    FTAB_PERCENTUALACRESCIMO: Double;
    FTAB_PERCENTUALDESCONTO: Double;
    FTAB_PERCENTUALCOMISSAO: Double;
    FTAB_DESATIVADO: String;
    FTAB_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_TAB';

    [Restrictions([NoValidate, NotNull])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TAB_DESCRICAO', ftString, 30)]
    [Dictionary('TAB_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TAB_DESCRICAO: String read FTAB_DESCRICAO write FTAB_DESCRICAO;
    const TAB_DESCRICAO_Name = 'TAB_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('TAB_PERCENTUALACRESCIMO', ftBCD, 10, 2)]
    [Dictionary('TAB_PERCENTUALACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TAB_PERCENTUALACRESCIMO: Double read FTAB_PERCENTUALACRESCIMO write FTAB_PERCENTUALACRESCIMO;
    const TAB_PERCENTUALACRESCIMO_Name = 'TAB_PERCENTUALACRESCIMO';

    [Restrictions([NoValidate])]
    [Column('TAB_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('TAB_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TAB_PERCENTUALDESCONTO: Double read FTAB_PERCENTUALDESCONTO write FTAB_PERCENTUALDESCONTO;
    const TAB_PERCENTUALDESCONTO_Name = 'TAB_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('TAB_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('TAB_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TAB_PERCENTUALCOMISSAO: Double read FTAB_PERCENTUALCOMISSAO write FTAB_PERCENTUALCOMISSAO;
    const TAB_PERCENTUALCOMISSAO_Name = 'TAB_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TAB_DESATIVADO', ftString, 1)]
    [Dictionary('TAB_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TAB_DESATIVADO: String read FTAB_DESATIVADO write FTAB_DESATIVADO;
    const TAB_DESATIVADO_Name = 'TAB_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TAB_DATAALTERACAO', ftDateTime)]
    [Dictionary('TAB_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TAB_DATAALTERACAO: TDateTime read FTAB_DATAALTERACAO write FTAB_DATAALTERACAO;
    const TAB_DATAALTERACAO_Name = 'TAB_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_TAB)

end.
