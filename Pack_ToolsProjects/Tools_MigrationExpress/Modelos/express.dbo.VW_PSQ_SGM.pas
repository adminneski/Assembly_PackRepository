unit express.dbo.VW_PSQ_SGM;

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
  [Table('VW_PSQ_SGM', '')]
  TDtoVW_PSQ_SGM = class
  private
    { Private declarations } 
    FSGM_CODIGO: String;
    FSGM_DESCRICAO: String;
    FSGM_SIGLA: String;
    FSGM_CASADECIMAL: Integer;
    FSGM_DESATIVADO: String;
    FSGM_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_SGM';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGM_DESCRICAO', ftString, 30)]
    [Dictionary('SGM_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_DESCRICAO: String read FSGM_DESCRICAO write FSGM_DESCRICAO;
    const SGM_DESCRICAO_Name = 'SGM_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_SIGLA', ftString, 2)]
    [Dictionary('SGM_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_SIGLA: String read FSGM_SIGLA write FSGM_SIGLA;
    const SGM_SIGLA_Name = 'SGM_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGM_CASADECIMAL', ftInteger)]
    [Dictionary('SGM_CASADECIMAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGM_CASADECIMAL: Integer read FSGM_CASADECIMAL write FSGM_CASADECIMAL;
    const SGM_CASADECIMAL_Name = 'SGM_CASADECIMAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGM_DESATIVADO', ftString, 1)]
    [Dictionary('SGM_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_DESATIVADO: String read FSGM_DESATIVADO write FSGM_DESATIVADO;
    const SGM_DESATIVADO_Name = 'SGM_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGM_DATAALTERACAO', ftDateTime)]
    [Dictionary('SGM_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SGM_DATAALTERACAO: TDateTime read FSGM_DATAALTERACAO write FSGM_DATAALTERACAO;
    const SGM_DATAALTERACAO_Name = 'SGM_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_SGM)

end.
