unit express.dbo.MDV_00;

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
  [Table('MDV_00', '')]
  [PrimaryKey('MDV_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MDV_ID')]
  TDtoMDV_00 = class
  private
    { Private declarations } 
    FMDV_ID: Integer;
    FMDV_CODIGO: String;
    FMDV_DESCRICAO: String;
    FMDV_TIPODEVOLUCAO: String;
    FMDV_DESATIVADO: String;
    FMDV_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MDV_00';
     const PrimaryKey = 'MDV_ID';
     const Sequence   = 'SEQ_MDV_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMDV_00)

end.
