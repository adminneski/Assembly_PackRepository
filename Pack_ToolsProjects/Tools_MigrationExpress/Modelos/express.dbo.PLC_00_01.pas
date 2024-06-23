unit express.dbo.PLC_00_01;

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
  [Table('PLC_00_01', '')]
  [PrimaryKey('PLC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PLC_01_ID')]
  TDtoPLC_00_01 = class
  private
    { Private declarations } 
    FPLC_01_ID: Integer;
    FPLC_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FPLC_DATAFECHAMENTO: TDateTime;
    FPLC_SALDOFECHAMENTO: Double;
  public 
    { Public declarations } 
     const Table      = 'PLC_00_01';
     const PrimaryKey = 'PLC_01_ID';
     const Sequence   = 'SEQ_PLC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_01_ID', ftInteger)]
    [Dictionary('PLC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_01_ID: Integer read FPLC_01_ID write FPLC_01_ID;
    const PLC_01_ID_Name = 'PLC_01_ID';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('PLC_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PLC_DATAFECHAMENTO: TDateTime read FPLC_DATAFECHAMENTO write FPLC_DATAFECHAMENTO;
    const PLC_DATAFECHAMENTO_Name = 'PLC_DATAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_SALDOFECHAMENTO', ftBCD, 1195983951, 2)]
    [Dictionary('PLC_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PLC_SALDOFECHAMENTO: Double read FPLC_SALDOFECHAMENTO write FPLC_SALDOFECHAMENTO;
    const PLC_SALDOFECHAMENTO_Name = 'PLC_SALDOFECHAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPLC_00_01)

end.
