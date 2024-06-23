unit express.dbo.MFC_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.mfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MFC_00_03', '')]
  [PrimaryKey('MFC_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MFC_03_ID')]
  TDtoMFC_00_03 = class
  private
    { Private declarations } 
    FMFC_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_ID: Integer;
    FMFC_DC: String;
    FPLC_CODIGO: Integer;
    FMFC_VALORRATEIO: Double;
    FMFC_PERCENTUALRATEIO: Double;
    FMFC_CENTROCUSTORATEIO: Double;
    FMFC_DATAALTERACAO: TDateTime;
    FMFC_03_ID_OLD: Integer;
    FMFC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'MFC_00_03';
    const PrimaryKey = 'MFC_03_ID';
    const Sequence   = 'SEQ_MFC_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_03_ID', ftInteger)]
    [Dictionary('MFC_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_03_ID: Integer read FMFC_03_ID write FMFC_03_ID;
    const MFC_03_ID_Name = 'MFC_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [ForeignKey('MFC_00_03_fk', 'MFC_ID', 'MFC_00', 'MFC_ID', SetNull, SetNull)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DC', ftString, 1)]
    [Dictionary('MFC_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_DC: String read FMFC_DC write FMFC_DC;
    const MFC_DC_Name = 'MFC_DC';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_VALORRATEIO', ftBCD)]
    [Dictionary('MFC_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORRATEIO: Double read FMFC_VALORRATEIO write FMFC_VALORRATEIO;
    const MFC_VALORRATEIO_Name = 'MFC_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('MFC_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_PERCENTUALRATEIO: Double read FMFC_PERCENTUALRATEIO write FMFC_PERCENTUALRATEIO;
    const MFC_PERCENTUALRATEIO_Name = 'MFC_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_CENTROCUSTORATEIO', ftBCD)]
    [Dictionary('MFC_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_CENTROCUSTORATEIO: Double read FMFC_CENTROCUSTORATEIO write FMFC_CENTROCUSTORATEIO;
    const MFC_CENTROCUSTORATEIO_Name = 'MFC_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('MFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATAALTERACAO: TDateTime read FMFC_DATAALTERACAO write FMFC_DATAALTERACAO;
    const MFC_DATAALTERACAO_Name = 'MFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_03_ID_OLD', ftInteger)]
    [Dictionary('MFC_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_03_ID_OLD: Integer read FMFC_03_ID_OLD write FMFC_03_ID_OLD;
    const MFC_03_ID_OLD_Name = 'MFC_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_ID_OLD', ftInteger)]
    [Dictionary('MFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID_OLD: Integer read FMFC_ID_OLD write FMFC_ID_OLD;
    const MFC_ID_OLD_Name = 'MFC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_00_03)

end.
