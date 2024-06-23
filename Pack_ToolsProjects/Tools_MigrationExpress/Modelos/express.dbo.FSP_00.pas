unit express.dbo.FSP_00;

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
  [Table('FSP_00', '')]
  [PrimaryKey('FSP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FSP_CODIGO')]
  TDtoFSP_00 = class
  private
    { Private declarations } 
    FFSP_CODIGO: Integer;
    FFSP_TIPO: String;
    FFSP_DESCRICAO: String;
    FFSP_DESATIVADO: String;
    FFSP_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'FSP_00';
     const PrimaryKey = 'FSP_CODIGO';
     const Sequence   = 'SEQ_FSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_CODIGO', ftInteger)]
    [Dictionary('FSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FSP_CODIGO: Integer read FFSP_CODIGO write FFSP_CODIGO;
    const FSP_CODIGO_Name = 'FSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_TIPO', ftString, 1)]
    [Dictionary('FSP_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FSP_TIPO: String read FFSP_TIPO write FFSP_TIPO;
    const FSP_TIPO_Name = 'FSP_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_DESCRICAO', ftString, 50)]
    [Dictionary('FSP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FSP_DESCRICAO: String read FFSP_DESCRICAO write FFSP_DESCRICAO;
    const FSP_DESCRICAO_Name = 'FSP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_DESATIVADO', ftString, 1)]
    [Dictionary('FSP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FSP_DESATIVADO: String read FFSP_DESATIVADO write FFSP_DESATIVADO;
    const FSP_DESATIVADO_Name = 'FSP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FSP_DATAALTERACAO', ftDateTime)]
    [Dictionary('FSP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FSP_DATAALTERACAO: TDateTime read FFSP_DATAALTERACAO write FFSP_DATAALTERACAO;
    const FSP_DATAALTERACAO_Name = 'FSP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFSP_00)

end.
