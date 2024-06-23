unit express.dbo.VW_PSQ_TDC;

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
  [Table('VW_PSQ_TDC', '')]
  TDtoVW_PSQ_TDC = class
  private
    { Private declarations } 
    FTDC_CODIGO: String;
    FTDC_DESCRICAO: String;
    FTDC_DESATIVADO: String;
    FTDC_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_TDC';

    [Restrictions([NoValidate, NotNull])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TDC_DESCRICAO', ftString, 50)]
    [Dictionary('TDC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_DESCRICAO: String read FTDC_DESCRICAO write FTDC_DESCRICAO;
    const TDC_DESCRICAO_Name = 'TDC_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TDC_DESATIVADO', ftString, 1)]
    [Dictionary('TDC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_DESATIVADO: String read FTDC_DESATIVADO write FTDC_DESATIVADO;
    const TDC_DESATIVADO_Name = 'TDC_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TDC_DATAALTERACAO', ftDateTime)]
    [Dictionary('TDC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TDC_DATAALTERACAO: TDateTime read FTDC_DATAALTERACAO write FTDC_DATAALTERACAO;
    const TDC_DATAALTERACAO_Name = 'TDC_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_TDC)

end.
