unit express.dbo.VW_PSQ_CCU;

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
  [Table('VW_PSQ_CCU', '')]
  TDtoVW_PSQ_CCU = class
  private
    { Private declarations } 
    FCCU_CODIGO: Integer;
    FCCU_CENTROCUSTO: String;
    FCCU_DESCRICAO: String;
    FCCU_DESATIVADO: String;
    FCCU_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CCU';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_CENTROCUSTO', ftString, 6)]
    [Dictionary('CCU_CENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCU_CENTROCUSTO: String read FCCU_CENTROCUSTO write FCCU_CENTROCUSTO;
    const CCU_CENTROCUSTO_Name = 'CCU_CENTROCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_DESCRICAO', ftString, 50)]
    [Dictionary('CCU_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCU_DESCRICAO: String read FCCU_DESCRICAO write FCCU_DESCRICAO;
    const CCU_DESCRICAO_Name = 'CCU_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_DESATIVADO', ftString, 1)]
    [Dictionary('CCU_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCU_DESATIVADO: String read FCCU_DESATIVADO write FCCU_DESATIVADO;
    const CCU_DESATIVADO_Name = 'CCU_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_DATAALTERACAO', ftDateTime)]
    [Dictionary('CCU_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CCU_DATAALTERACAO: TDateTime read FCCU_DATAALTERACAO write FCCU_DATAALTERACAO;
    const CCU_DATAALTERACAO_Name = 'CCU_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CCU)

end.
