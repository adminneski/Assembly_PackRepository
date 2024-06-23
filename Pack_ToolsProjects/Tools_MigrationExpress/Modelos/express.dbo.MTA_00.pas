unit express.dbo.MTA_00;

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
  [Table('MTA_00', '')]
  [PrimaryKey('MTA_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MTA_CODIGO')]
  TDtoMTA_00 = class
  private
    { Private declarations } 
    FMTA_CODIGO: Integer;
    FMTA_DESCRICAO: String;
    FMTA_VALOR: Double;
    FMTA_DESATIVADO: String;
    FMTA_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MTA_00';
     const PrimaryKey = 'MTA_CODIGO';
     const Sequence   = 'SEQ_MTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_CODIGO', ftInteger)]
    [Dictionary('MTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTA_CODIGO: Integer read FMTA_CODIGO write FMTA_CODIGO;
    const MTA_CODIGO_Name = 'MTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_DESCRICAO', ftString, 30)]
    [Dictionary('MTA_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_DESCRICAO: String read FMTA_DESCRICAO write FMTA_DESCRICAO;
    const MTA_DESCRICAO_Name = 'MTA_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_VALOR', ftBCD)]
    [Dictionary('MTA_VALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MTA_VALOR: Double read FMTA_VALOR write FMTA_VALOR;
    const MTA_VALOR_Name = 'MTA_VALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_DESATIVADO', ftString, 1)]
    [Dictionary('MTA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_DESATIVADO: String read FMTA_DESATIVADO write FMTA_DESATIVADO;
    const MTA_DESATIVADO_Name = 'MTA_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('MTA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTA_DATAALTERACAO: TDateTime read FMTA_DATAALTERACAO write FMTA_DATAALTERACAO;
    const MTA_DATAALTERACAO_Name = 'MTA_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMTA_00)

end.
