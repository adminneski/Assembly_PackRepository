unit express.dbo.RBC_00;

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
  [Table('RBC_00', '')]
  [PrimaryKey('RBC_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RBC_CODIGO')]
  TDtoRBC_00 = class
  private
    { Private declarations } 
    FRBC_CODIGO: Integer;
    FRBC_DESCRICAO: String;
    FRBC_PERCENTUALREDUCAO: Double;
    FRBC_DATAALTERACAO: TDateTime;
    FRBC_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'RBC_00';
     const PrimaryKey = 'RBC_CODIGO';
     const Sequence   = 'SEQ_RBC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RBC_CODIGO', ftInteger)]
    [Dictionary('RBC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property RBC_CODIGO: Integer read FRBC_CODIGO write FRBC_CODIGO;
    const RBC_CODIGO_Name = 'RBC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RBC_DESCRICAO', ftString, 30)]
    [Dictionary('RBC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RBC_DESCRICAO: String read FRBC_DESCRICAO write FRBC_DESCRICAO;
    const RBC_DESCRICAO_Name = 'RBC_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RBC_PERCENTUALREDUCAO', ftBCD, 18, 4)]
    [Dictionary('RBC_PERCENTUALREDUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RBC_PERCENTUALREDUCAO: Double read FRBC_PERCENTUALREDUCAO write FRBC_PERCENTUALREDUCAO;
    const RBC_PERCENTUALREDUCAO_Name = 'RBC_PERCENTUALREDUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RBC_DATAALTERACAO', ftDateTime)]
    [Dictionary('RBC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RBC_DATAALTERACAO: TDateTime read FRBC_DATAALTERACAO write FRBC_DATAALTERACAO;
    const RBC_DATAALTERACAO_Name = 'RBC_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RBC_DESATIVADO', ftString, 1)]
    [Dictionary('RBC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RBC_DESATIVADO: String read FRBC_DESATIVADO write FRBC_DESATIVADO;
    const RBC_DESATIVADO_Name = 'RBC_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRBC_00)

end.
