unit express.dbo.GRD_00;

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
  [Table('GRD_00', '')]
  [PrimaryKey('GRD_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_GRD_CODIGO')]
  TDtoGRD_00 = class
  private
    { Private declarations } 
    FGRD_CODIGO: String;
    FGRD_DESCRICAO: String;
    FGRD_DESATIVADO: String;
    FGRD_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'GRD_00';
     const PrimaryKey = 'GRD_CODIGO';
     const Sequence   = 'SEQ_GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_DESCRICAO', ftString, 50)]
    [Dictionary('GRD_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_DESCRICAO: String read FGRD_DESCRICAO write FGRD_DESCRICAO;
    const GRD_DESCRICAO_Name = 'GRD_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_DESATIVADO', ftString, 1)]
    [Dictionary('GRD_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_DESATIVADO: String read FGRD_DESATIVADO write FGRD_DESATIVADO;
    const GRD_DESATIVADO_Name = 'GRD_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_DATAALTERACAO', ftDateTime)]
    [Dictionary('GRD_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property GRD_DATAALTERACAO: TDateTime read FGRD_DATAALTERACAO write FGRD_DATAALTERACAO;
    const GRD_DATAALTERACAO_Name = 'GRD_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGRD_00)

end.
