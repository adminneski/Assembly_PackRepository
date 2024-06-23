unit express.dbo.REQ_00_02;

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
  [Table('REQ_00_02', '')]
  [PrimaryKey('REQ_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_REQ_02_ID')]
  TDtoREQ_00_02 = class
  private
    { Private declarations } 
    FREQ_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FREQ_ID: Integer;
    FREQ_DC: String;
    FPLC_CODIGO: Integer;
    FREQ_VALORRATEIO: Double;
    FREQ_PERCENTUALRATEIO: Double;
    FREQ_CENTROCUSTORATEIO: Double;
    FREQ_DATAALTERACAO: TDateTime;
    FREQ_02_ID_OLD: Integer;
    FREQ_ID_OLD: Integer;
  public
    { Public declarations }
    const PrimaryKey = 'REQ_02_ID';
    const Sequence   = 'SEQ_REQ_02_ID';
   [Restrictions([NoValidate, NotNull])]
  [Column('REQ_02_ID', ftInteger)]
  [Dictionary('REQ_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_02_ID: Integer read FREQ_02_ID write FREQ_02_ID;
    const REQ_02_ID_Name = 'REQ_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_ID', ftInteger)]
    [ForeignKey('REQ_00_02_fk', 'REQ_ID', 'REQ_00', 'REQ_ID', SetNull, SetNull)]
    [Dictionary('REQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_ID: Integer read FREQ_ID write FREQ_ID;
    const REQ_ID_Name = 'REQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_DC', ftString, 1)]
    [Dictionary('REQ_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_DC: String read FREQ_DC write FREQ_DC;
    const REQ_DC_Name = 'REQ_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_VALORRATEIO', ftBCD, 1411398223, 2)]
    [Dictionary('REQ_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORRATEIO: Double read FREQ_VALORRATEIO write FREQ_VALORRATEIO;
    const REQ_VALORRATEIO_Name = 'REQ_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_PERCENTUALRATEIO', ftBCD, 1142962771, 6)]
    [Dictionary('REQ_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_PERCENTUALRATEIO: Double read FREQ_PERCENTUALRATEIO write FREQ_PERCENTUALRATEIO;
    const REQ_PERCENTUALRATEIO_Name = 'REQ_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_CENTROCUSTORATEIO', ftBCD, 1599096398, 2)]
    [Dictionary('REQ_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_CENTROCUSTORATEIO: Double read FREQ_CENTROCUSTORATEIO write FREQ_CENTROCUSTORATEIO;
    const REQ_CENTROCUSTORATEIO_Name = 'REQ_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('REQ_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property REQ_DATAALTERACAO: TDateTime read FREQ_DATAALTERACAO write FREQ_DATAALTERACAO;
    const REQ_DATAALTERACAO_Name = 'REQ_DATAALTERACAO';

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
  TRegisterClass.RegisterEntity(TDtoREQ_00_02)

end.
