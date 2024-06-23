unit express.dbo.BCX_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections,

  //goxormbr 
  express.dbo.bcx_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('BCX_00_01', '')]
  [PrimaryKey('BCX_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCX_01_ID')]
  TDtoBCX_00_01 = class
  private
    { Private declarations } 
    FBCX_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCX_ID: Integer;
    FBCX_DC: String;
    FPLC_CODIGO: Integer;
    FBCX_PERCENTUALRATEIO: Double;
    FBCX_VALORRATEIO: Double;
    FBCX_CENTROCUSTORATEIO: Double;
    FBCX_DATAALTERACAO: TDateTime;
    FBCX_01_ID_OLD: Integer;
    FBCX_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'BCX_00_01';
    const PrimaryKey = 'BCX_01_ID';
    const Sequence   = 'SEQ_BCX_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_01_ID', ftInteger)]
    [Dictionary('BCX_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_01_ID: Integer read FBCX_01_ID write FBCX_01_ID;
    const BCX_01_ID_Name = 'BCX_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_ID', ftInteger)]
    [ForeignKey('BCX_00_01_fk', 'BCX_ID', 'BCX_00', 'BCX_ID', SetNull, SetNull)]
    [Dictionary('BCX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID: Integer read FBCX_ID write FBCX_ID;
    const BCX_ID_Name = 'BCX_ID';

    [Restrictions([NoValidate])]
    [Column('BCX_DC', ftString, 1)]
    [Dictionary('BCX_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DC: String read FBCX_DC write FBCX_DC;
    const BCX_DC_Name = 'BCX_DC';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('BCX_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_PERCENTUALRATEIO: Double read FBCX_PERCENTUALRATEIO write FBCX_PERCENTUALRATEIO;
    const BCX_PERCENTUALRATEIO_Name = 'BCX_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_VALORRATEIO', ftBCD)]
    [Dictionary('BCX_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORRATEIO: Double read FBCX_VALORRATEIO write FBCX_VALORRATEIO;
    const BCX_VALORRATEIO_Name = 'BCX_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_CENTROCUSTORATEIO', ftBCD)]
    [Dictionary('BCX_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_CENTROCUSTORATEIO: Double read FBCX_CENTROCUSTORATEIO write FBCX_CENTROCUSTORATEIO;
    const BCX_CENTROCUSTORATEIO_Name = 'BCX_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCX_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCX_DATAALTERACAO: TDateTime read FBCX_DATAALTERACAO write FBCX_DATAALTERACAO;
    const BCX_DATAALTERACAO_Name = 'BCX_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BCX_01_ID_OLD', ftInteger)]
    [Dictionary('BCX_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_01_ID_OLD: Integer read FBCX_01_ID_OLD write FBCX_01_ID_OLD;
    const BCX_01_ID_OLD_Name = 'BCX_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCX_ID_OLD', ftInteger)]
    [Dictionary('BCX_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID_OLD: Integer read FBCX_ID_OLD write FBCX_ID_OLD;
    const BCX_ID_OLD_Name = 'BCX_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCX_00_01)

end.
