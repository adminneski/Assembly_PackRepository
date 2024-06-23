unit express.dbo.HSP_00;

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
  [Table('HSP_00', '')]
  [PrimaryKey('HSP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_HSP_CODIGO')]
  TDtoHSP_00 = class
  private
    { Private declarations } 
    FHSP_CODIGO: Integer;
    FHSP_DESCRICAO: String;
    FHSP_DATAALTERACAO: TDateTime;
    FHSP_DESATIVADO: String;
    FHSP_TIPO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'HSP_00';
     const PrimaryKey = 'HSP_CODIGO';
     const Sequence   = 'SEQ_HSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HSP_DESCRICAO', ftString, 50)]
    [Dictionary('HSP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HSP_DESCRICAO: String read FHSP_DESCRICAO write FHSP_DESCRICAO;
    const HSP_DESCRICAO_Name = 'HSP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HSP_DATAALTERACAO', ftDateTime)]
    [Dictionary('HSP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property HSP_DATAALTERACAO: TDateTime read FHSP_DATAALTERACAO write FHSP_DATAALTERACAO;
    const HSP_DATAALTERACAO_Name = 'HSP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HSP_DESATIVADO', ftString, 1)]
    [Dictionary('HSP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HSP_DESATIVADO: String read FHSP_DESATIVADO write FHSP_DESATIVADO;
    const HSP_DESATIVADO_Name = 'HSP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('HSP_TIPO', ftString, 1)]
    [Dictionary('HSP_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HSP_TIPO: String read FHSP_TIPO write FHSP_TIPO;
    const HSP_TIPO_Name = 'HSP_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoHSP_00)

end.
