unit express.dbo.SCP_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.scp_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('SCP_00_03', '')]
  [PrimaryKey('SCP_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCP_03_ID')]
  TDtoSCP_00_03 = class
  private
    { Private declarations } 
    FSCP_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCP_ID: Integer;
    FSCP_DC: String;
    FPLC_CODIGO: Integer;
    FSCP_PERCENTUALRATEIO: Double;
    FSCP_VALORRATEIO: Double;
    FSCP_CENTROCUSTORATEIO: Double;
    FSCP_DATAALTERACAO: TDateTime;
    FSCP_03_ID_OLD: Integer;
    FSCP_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCP_00_03';
    const PrimaryKey = 'SCP_03_ID';
    const Sequence   = 'SEQ_SCP_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_03_ID', ftInteger)]
    [Dictionary('SCP_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_03_ID: Integer read FSCP_03_ID write FSCP_03_ID;
    const SCP_03_ID_Name = 'SCP_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_ID', ftInteger)]
    [ForeignKey('SCP_00_03_fk', 'SCP_ID', 'SCP_00', 'SCP_ID', SetNull, SetNull)]
    [Dictionary('SCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID: Integer read FSCP_ID write FSCP_ID;
    const SCP_ID_Name = 'SCP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DC', ftString, 1)]
    [Dictionary('SCP_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCP_DC: String read FSCP_DC write FSCP_DC;
    const SCP_DC_Name = 'SCP_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_PERCENTUALRATEIO', ftBCD, 1835362145, 6)]
    [Dictionary('SCP_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_PERCENTUALRATEIO: Double read FSCP_PERCENTUALRATEIO write FSCP_PERCENTUALRATEIO;
    const SCP_PERCENTUALRATEIO_Name = 'SCP_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_VALORRATEIO', ftBCD, 1145132617, 2)]
    [Dictionary('SCP_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_VALORRATEIO: Double read FSCP_VALORRATEIO write FSCP_VALORRATEIO;
    const SCP_VALORRATEIO_Name = 'SCP_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_CENTROCUSTORATEIO', ftBCD, 1411398223, 2)]
    [Dictionary('SCP_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_CENTROCUSTORATEIO: Double read FSCP_CENTROCUSTORATEIO write FSCP_CENTROCUSTORATEIO;
    const SCP_CENTROCUSTORATEIO_Name = 'SCP_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATAALTERACAO: TDateTime read FSCP_DATAALTERACAO write FSCP_DATAALTERACAO;
    const SCP_DATAALTERACAO_Name = 'SCP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCP_03_ID_OLD', ftInteger)]
    [Dictionary('SCP_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_03_ID_OLD: Integer read FSCP_03_ID_OLD write FSCP_03_ID_OLD;
    const SCP_03_ID_OLD_Name = 'SCP_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCP_ID_OLD', ftInteger)]
    [Dictionary('SCP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID_OLD: Integer read FSCP_ID_OLD write FSCP_ID_OLD;
    const SCP_ID_OLD_Name = 'SCP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCP_00_03)

end.
