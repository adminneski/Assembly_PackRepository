unit express.dbo.VW_PSQ_LEF;

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
  [Table('VW_PSQ_LEF', '')]
  TDtoVW_PSQ_LEF = class
  private
    { Private declarations } 
    FLEF_CODIGO: Integer;
    FLEF_DESCRICAO: String;
    FLEF_SIMBOLO: String;
    FLEF_STATUS: String;
    FLEF_PERCENTUALPIS: Double;
    FLEF_PERCENTUALCOFINS: Double;
    FLEF_PERCENTUALIPI: Double;
    FLEF_DESATIVADO: String;
    FLEF_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_LEF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_DESCRICAO', ftString, 100)]
    [Dictionary('LEF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_DESCRICAO: String read FLEF_DESCRICAO write FLEF_DESCRICAO;
    const LEF_DESCRICAO_Name = 'LEF_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LEF_SIMBOLO', ftString, 1)]
    [Dictionary('LEF_SIMBOLO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_SIMBOLO: String read FLEF_SIMBOLO write FLEF_SIMBOLO;
    const LEF_SIMBOLO_Name = 'LEF_SIMBOLO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_STATUS', ftString, 1)]
    [Dictionary('LEF_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_STATUS: String read FLEF_STATUS write FLEF_STATUS;
    const LEF_STATUS_Name = 'LEF_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_PERCENTUALPIS', ftBCD)]
    [Dictionary('LEF_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALPIS: Double read FLEF_PERCENTUALPIS write FLEF_PERCENTUALPIS;
    const LEF_PERCENTUALPIS_Name = 'LEF_PERCENTUALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_PERCENTUALCOFINS', ftBCD)]
    [Dictionary('LEF_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALCOFINS: Double read FLEF_PERCENTUALCOFINS write FLEF_PERCENTUALCOFINS;
    const LEF_PERCENTUALCOFINS_Name = 'LEF_PERCENTUALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_PERCENTUALIPI', ftBCD)]
    [Dictionary('LEF_PERCENTUALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALIPI: Double read FLEF_PERCENTUALIPI write FLEF_PERCENTUALIPI;
    const LEF_PERCENTUALIPI_Name = 'LEF_PERCENTUALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_DESATIVADO', ftString, 1)]
    [Dictionary('LEF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_DESATIVADO: String read FLEF_DESATIVADO write FLEF_DESATIVADO;
    const LEF_DESATIVADO_Name = 'LEF_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('LEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LEF_DATAALTERACAO: TDateTime read FLEF_DATAALTERACAO write FLEF_DATAALTERACAO;
    const LEF_DATAALTERACAO_Name = 'LEF_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_LEF)

end.
