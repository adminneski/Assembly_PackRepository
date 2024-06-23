unit express.dbo.CPA_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cpa_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CPA_00_03', '')]
  [PrimaryKey('CPA_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPA_03_ID')]
  TDtoCPA_00_03 = class
  private
    { Private declarations } 
    FCPA_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FCPA_ID: Integer;
    FCPA_DC: String;
    FPLC_CODIGO: Integer;
    FCPA_VALORRATEIO: Double;
    FCPA_PERCENTUALRATEIO: Double;
    FCPA_CENTROCUSTORATEIO: Double;
    FCPA_DATAALTERACAO: TDateTime;
    FCPA_03_ID_OLD: Integer;
    FCPA_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CPA_00_03';
    const PrimaryKey = 'CPA_03_ID';
    const Sequence   = 'SEQ_CPA_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_03_ID', ftInteger)]
    [Dictionary('CPA_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_03_ID: Integer read FCPA_03_ID write FCPA_03_ID;
    const CPA_03_ID_Name = 'CPA_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [ForeignKey('CPA_00_03_fk', 'CPA_ID', 'CPA_00', 'CPA_ID', SetNull, SetNull)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DC', ftString, 1)]
    [Dictionary('CPA_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DC: String read FCPA_DC write FCPA_DC;
    const CPA_DC_Name = 'CPA_DC';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_VALORRATEIO', ftBCD)]
    [Dictionary('CPA_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORRATEIO: Double read FCPA_VALORRATEIO write FCPA_VALORRATEIO;
    const CPA_VALORRATEIO_Name = 'CPA_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('CPA_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALRATEIO: Double read FCPA_PERCENTUALRATEIO write FCPA_PERCENTUALRATEIO;
    const CPA_PERCENTUALRATEIO_Name = 'CPA_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_CENTROCUSTORATEIO', ftBCD)]
    [Dictionary('CPA_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_CENTROCUSTORATEIO: Double read FCPA_CENTROCUSTORATEIO write FCPA_CENTROCUSTORATEIO;
    const CPA_CENTROCUSTORATEIO_Name = 'CPA_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPA_DATAALTERACAO: TDateTime read FCPA_DATAALTERACAO write FCPA_DATAALTERACAO;
    const CPA_DATAALTERACAO_Name = 'CPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_03_ID_OLD', ftInteger)]
    [Dictionary('CPA_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_03_ID_OLD: Integer read FCPA_03_ID_OLD write FCPA_03_ID_OLD;
    const CPA_03_ID_OLD_Name = 'CPA_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_ID_OLD', ftInteger)]
    [Dictionary('CPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID_OLD: Integer read FCPA_ID_OLD write FCPA_ID_OLD;
    const CPA_ID_OLD_Name = 'CPA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPA_00_03)

end.
