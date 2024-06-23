unit express.dbo.TXS_00;

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
  [Table('TXS_00', '')]
  [PrimaryKey('TXS_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TXS_CODIGO')]
  TDtoTXS_00 = class
  private
    { Private declarations } 
    FTXS_CODIGO: Integer;
    FTXS_DESCRICAO: String;
    FTXS_UF: String;
    FTXS_DESATIVADO: String;
    FTXS_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'TXS_00';
     const PrimaryKey = 'TXS_CODIGO';
     const Sequence   = 'SEQ_TXS_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_CODIGO', ftInteger)]
    [Dictionary('TXS_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TXS_CODIGO: Integer read FTXS_CODIGO write FTXS_CODIGO;
    const TXS_CODIGO_Name = 'TXS_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TXS_DESCRICAO', ftString, 50)]
    [Dictionary('TXS_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXS_DESCRICAO: String read FTXS_DESCRICAO write FTXS_DESCRICAO;
    const TXS_DESCRICAO_Name = 'TXS_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_UF', ftString, 2)]
    [Dictionary('TXS_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXS_UF: String read FTXS_UF write FTXS_UF;
    const TXS_UF_Name = 'TXS_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_DESATIVADO', ftString, 1)]
    [Dictionary('TXS_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXS_DESATIVADO: String read FTXS_DESATIVADO write FTXS_DESATIVADO;
    const TXS_DESATIVADO_Name = 'TXS_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_DATAALTERACAO', ftDateTime)]
    [Dictionary('TXS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TXS_DATAALTERACAO: TDateTime read FTXS_DATAALTERACAO write FTXS_DATAALTERACAO;
    const TXS_DATAALTERACAO_Name = 'TXS_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTXS_00)

end.
