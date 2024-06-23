unit express.dbo.TXS_00_01;

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
  [Table('TXS_00_01', '')]
  [PrimaryKey('TXS_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TXS_01_ID')]
  TDtoTXS_00_01 = class
  private
    { Private declarations } 
    FTXS_01_ID: Integer;
    FTXS_CODIGO: Integer;
    FTXS_UF: String;
    FTXS_PERCENTUALSEGURO: Double;
    FTXS_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'TXS_00_01';
     const PrimaryKey = 'TXS_01_ID';
     const Sequence   = 'SEQ_TXS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_01_ID', ftInteger)]
    [Dictionary('TXS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TXS_01_ID: Integer read FTXS_01_ID write FTXS_01_ID;
    const TXS_01_ID_Name = 'TXS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_CODIGO', ftInteger)]
    [Dictionary('TXS_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TXS_CODIGO: Integer read FTXS_CODIGO write FTXS_CODIGO;
    const TXS_CODIGO_Name = 'TXS_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_UF', ftString, 2)]
    [Dictionary('TXS_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXS_UF: String read FTXS_UF write FTXS_UF;
    const TXS_UF_Name = 'TXS_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXS_PERCENTUALSEGURO', ftBCD, 18, 4)]
    [Dictionary('TXS_PERCENTUALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TXS_PERCENTUALSEGURO: Double read FTXS_PERCENTUALSEGURO write FTXS_PERCENTUALSEGURO;
    const TXS_PERCENTUALSEGURO_Name = 'TXS_PERCENTUALSEGURO';

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
  TRegisterClass.RegisterEntity(TDtoTXS_00_01)

end.
