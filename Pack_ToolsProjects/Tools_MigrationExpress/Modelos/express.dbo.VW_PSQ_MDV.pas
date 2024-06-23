unit express.dbo.VW_PSQ_MDV;

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
  [Table('VW_PSQ_MDV', '')]
  TDtoVW_PSQ_MDV = class
  private
    { Private declarations } 
    FMDV_ID: Integer;
    FMDV_CODIGO: String;
    FMDV_DESCRICAO: String;
    FMDV_TIPODEVOLUCAO: String;
    FMDV_DESATIVADO: String;
    FMDV_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MDV';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDV_ID', ftInteger)]
    [Dictionary('MDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDV_ID: Integer read FMDV_ID write FMDV_ID;
    const MDV_ID_Name = 'MDV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDV_CODIGO', ftString, 2)]
    [Dictionary('MDV_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDV_CODIGO: String read FMDV_CODIGO write FMDV_CODIGO;
    const MDV_CODIGO_Name = 'MDV_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDV_DESCRICAO', ftString, 100)]
    [Dictionary('MDV_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDV_DESCRICAO: String read FMDV_DESCRICAO write FMDV_DESCRICAO;
    const MDV_DESCRICAO_Name = 'MDV_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDV_TIPODEVOLUCAO', ftString, 3)]
    [Dictionary('MDV_TIPODEVOLUCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDV_TIPODEVOLUCAO: String read FMDV_TIPODEVOLUCAO write FMDV_TIPODEVOLUCAO;
    const MDV_TIPODEVOLUCAO_Name = 'MDV_TIPODEVOLUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDV_DESATIVADO', ftString, 1)]
    [Dictionary('MDV_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDV_DESATIVADO: String read FMDV_DESATIVADO write FMDV_DESATIVADO;
    const MDV_DESATIVADO_Name = 'MDV_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDV_DATAALTERACAO', ftDateTime)]
    [Dictionary('MDV_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MDV_DATAALTERACAO: TDateTime read FMDV_DATAALTERACAO write FMDV_DATAALTERACAO;
    const MDV_DATAALTERACAO_Name = 'MDV_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MDV)

end.
