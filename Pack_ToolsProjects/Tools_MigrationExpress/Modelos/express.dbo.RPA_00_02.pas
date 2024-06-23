unit express.dbo.RPA_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.rpa_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('RPA_00_02', '')]
  [PrimaryKey('RPA_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RPA_02_ID')]
  TDtoRPA_00_02 = class
  private
    { Private declarations } 
    FRPA_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FRPA_ID: Integer;
    FRPA_DC: String;
    FPLC_CODIGO: Integer;
    FRPA_VALORRATEIO: Double;
    FRPA_PERCENTUALRATEIO: Double;
    FRPA_CENTROCUSTORATEIO: Double;
    FRPA_DATAALTERACAO: TDateTime;
    FRPA_02_ID_OLD: Integer;
    FRPA_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'RPA_00_02';
    const PrimaryKey = 'RPA_02_ID';
    const Sequence   = 'SEQ_RPA_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_02_ID', ftInteger)]
    [Dictionary('RPA_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_02_ID: Integer read FRPA_02_ID write FRPA_02_ID;
    const RPA_02_ID_Name = 'RPA_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_ID', ftInteger)]
    [ForeignKey('RPA_00_02_fk', 'RPA_ID', 'RPA_00', 'RPA_ID', SetNull, SetNull)]
    [Dictionary('RPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID: Integer read FRPA_ID write FRPA_ID;
    const RPA_ID_Name = 'RPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DC', ftString, 1)]
    [Dictionary('RPA_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_DC: String read FRPA_DC write FRPA_DC;
    const RPA_DC_Name = 'RPA_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_VALORRATEIO', ftBCD, 6881394, 2)]
    [Dictionary('RPA_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_VALORRATEIO: Double read FRPA_VALORRATEIO write FRPA_VALORRATEIO;
    const RPA_VALORRATEIO_Name = 'RPA_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_PERCENTUALRATEIO', ftBCD, 1699555104, 6)]
    [Dictionary('RPA_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_PERCENTUALRATEIO: Double read FRPA_PERCENTUALRATEIO write FRPA_PERCENTUALRATEIO;
    const RPA_PERCENTUALRATEIO_Name = 'RPA_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_CENTROCUSTORATEIO', ftBCD, 544040295, 2)]
    [Dictionary('RPA_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_CENTROCUSTORATEIO: Double read FRPA_CENTROCUSTORATEIO write FRPA_CENTROCUSTORATEIO;
    const RPA_CENTROCUSTORATEIO_Name = 'RPA_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('RPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RPA_DATAALTERACAO: TDateTime read FRPA_DATAALTERACAO write FRPA_DATAALTERACAO;
    const RPA_DATAALTERACAO_Name = 'RPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('RPA_02_ID_OLD', ftInteger)]
    [Dictionary('RPA_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_02_ID_OLD: Integer read FRPA_02_ID_OLD write FRPA_02_ID_OLD;
    const RPA_02_ID_OLD_Name = 'RPA_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('RPA_ID_OLD', ftInteger)]
    [Dictionary('RPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID_OLD: Integer read FRPA_ID_OLD write FRPA_ID_OLD;
    const RPA_ID_OLD_Name = 'RPA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRPA_00_02)

end.
