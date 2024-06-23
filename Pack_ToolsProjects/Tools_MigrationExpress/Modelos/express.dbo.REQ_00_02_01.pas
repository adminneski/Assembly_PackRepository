unit express.dbo.REQ_00_02_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.req_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('REQ_00_02_01', '')]
  [PrimaryKey('REQ_02_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_REQ_02_01_ID')]
  TDtoREQ_00_02_01 = class
  private
    { Private declarations } 
    FREQ_02_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FREQ_ID: Integer;
    FREQ_02_ID: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FREQ_VALORRATEIO: Double;
    FREQ_PERCENTUALRATEIO: Double;
    FREQ_DATAALTERACAO: TDateTime;
    FREQ_02_01_ID_OLD: Integer;
    FREQ_02_ID_OLD: Integer;
    FREQ_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'REQ_00_02_01';
    const PrimaryKey = 'REQ_02_01_ID';
    const Sequence   = 'SEQ_REQ_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_02_01_ID', ftInteger)]
    [Dictionary('REQ_02_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_02_01_ID: Integer read FREQ_02_01_ID write FREQ_02_01_ID;
    const REQ_02_01_ID_Name = 'REQ_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_ID', ftInteger)]
    [ForeignKey('REQ_00_02_01_fk', 'REQ_ID', 'REQ_00', 'REQ_ID', SetNull, SetNull)]
    [Dictionary('REQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_ID: Integer read FREQ_ID write FREQ_ID;
    const REQ_ID_Name = 'REQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_02_ID', ftInteger)]
    [Dictionary('REQ_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_02_ID: Integer read FREQ_02_ID write FREQ_02_ID;
    const REQ_02_ID_Name = 'REQ_02_ID';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_VALORRATEIO', ftBCD, 1835362145, 2)]
    [Dictionary('REQ_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORRATEIO: Double read FREQ_VALORRATEIO write FREQ_VALORRATEIO;
    const REQ_VALORRATEIO_Name = 'REQ_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_PERCENTUALRATEIO', ftBCD, 1145132617, 6)]
    [Dictionary('REQ_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_PERCENTUALRATEIO: Double read FREQ_PERCENTUALRATEIO write FREQ_PERCENTUALRATEIO;
    const REQ_PERCENTUALRATEIO_Name = 'REQ_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('REQ_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property REQ_DATAALTERACAO: TDateTime read FREQ_DATAALTERACAO write FREQ_DATAALTERACAO;
    const REQ_DATAALTERACAO_Name = 'REQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('REQ_02_01_ID_OLD', ftInteger)]
    [Dictionary('REQ_02_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_02_01_ID_OLD: Integer read FREQ_02_01_ID_OLD write FREQ_02_01_ID_OLD;
    const REQ_02_01_ID_OLD_Name = 'REQ_02_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('REQ_02_ID_OLD', ftInteger)]
    [Dictionary('REQ_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_02_ID_OLD: Integer read FREQ_02_ID_OLD write FREQ_02_ID_OLD;
    const REQ_02_ID_OLD_Name = 'REQ_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('REQ_ID_OLD', ftInteger)]
    [Dictionary('REQ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_ID_OLD: Integer read FREQ_ID_OLD write FREQ_ID_OLD;
    const REQ_ID_OLD_Name = 'REQ_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoREQ_00_02_01)

end.
