unit express.dbo.SCR_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.scr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('SCR_00_04', '')]
  [PrimaryKey('SCR_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCR_04_ID')]
  TDtoSCR_00_04 = class
  private
    { Private declarations } 
    FSCR_04_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCR_ID: Integer;
    FSCR_DC: String;
    FPLC_CODIGO: Integer;
    FSCR_PERCENTUALRATEIO: Double;
    FSCR_VALORRATEIO: Double;
    FSCR_CENTROCUSTORATEIO: Double;
    FSCR_DATAALTERACAO: TDateTime;
    FSCR_04_ID_OLD: Integer;
    FSCR_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCR_00_04';
    const PrimaryKey = 'SCR_04_ID';
    const Sequence   = 'SEQ_SCR_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_04_ID', ftInteger)]
    [Dictionary('SCR_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_04_ID: Integer read FSCR_04_ID write FSCR_04_ID;
    const SCR_04_ID_Name = 'SCR_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [ForeignKey('SCR_00_04_fk', 'SCR_ID', 'SCR_00', 'SCR_ID', SetNull, SetNull)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DC', ftString, 1)]
    [Dictionary('SCR_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_DC: String read FSCR_DC write FSCR_DC;
    const SCR_DC_Name = 'SCR_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PERCENTUALRATEIO', ftBCD, 6881394, 6)]
    [Dictionary('SCR_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_PERCENTUALRATEIO: Double read FSCR_PERCENTUALRATEIO write FSCR_PERCENTUALRATEIO;
    const SCR_PERCENTUALRATEIO_Name = 'SCR_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_VALORRATEIO', ftBCD, 656419879, 2)]
    [Dictionary('SCR_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_VALORRATEIO: Double read FSCR_VALORRATEIO write FSCR_VALORRATEIO;
    const SCR_VALORRATEIO_Name = 'SCR_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_CENTROCUSTORATEIO', ftBCD, 1146045279, 2)]
    [Dictionary('SCR_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_CENTROCUSTORATEIO: Double read FSCR_CENTROCUSTORATEIO write FSCR_CENTROCUSTORATEIO;
    const SCR_CENTROCUSTORATEIO_Name = 'SCR_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAALTERACAO: TDateTime read FSCR_DATAALTERACAO write FSCR_DATAALTERACAO;
    const SCR_DATAALTERACAO_Name = 'SCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCR_04_ID_OLD', ftInteger)]
    [Dictionary('SCR_04_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_04_ID_OLD: Integer read FSCR_04_ID_OLD write FSCR_04_ID_OLD;
    const SCR_04_ID_OLD_Name = 'SCR_04_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCR_ID_OLD', ftInteger)]
    [Dictionary('SCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID_OLD: Integer read FSCR_ID_OLD write FSCR_ID_OLD;
    const SCR_ID_OLD_Name = 'SCR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCR_00_04)

end.
