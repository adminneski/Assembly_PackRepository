unit express.dbo.OMF_00_06;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.omf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('OMF_00_06', '')]
  [PrimaryKey('OMF_06_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_06_ID')]
  TDtoOMF_00_06 = class
  private
    { Private declarations } 
    FOMF_06_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_ID: Integer;
    FOMF_DC: String;
    FPLC_CODIGO: Integer;
    FOMF_VALORRATEIO: Double;
    FOMF_PERCENTUALRATEIO: Double;
    FOMF_CENTROCUSTORATEIO: Double;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: String;
    FOMF_06_ID_OLD: Integer;
    FOMF_ID_OLD: Integer;

  public
    { Public declarations }
    const Table      = 'OMF_00_06';
    const PrimaryKey = 'OMF_06_ID';
    const Sequence   = 'SEQ_OMF_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_06_ID', ftInteger)]
    [Dictionary('OMF_06_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_06_ID: Integer read FOMF_06_ID write FOMF_06_ID;
    const OMF_06_ID_Name = 'OMF_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_06_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DC', ftString, 1)]
    [Dictionary('OMF_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_DC: String read FOMF_DC write FOMF_DC;
    const OMF_DC_Name = 'OMF_DC';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORRATEIO', ftBCD)]
    [Dictionary('OMF_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORRATEIO: Double read FOMF_VALORRATEIO write FOMF_VALORRATEIO;
    const OMF_VALORRATEIO_Name = 'OMF_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('OMF_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALRATEIO: Double read FOMF_PERCENTUALRATEIO write FOMF_PERCENTUALRATEIO;
    const OMF_PERCENTUALRATEIO_Name = 'OMF_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_CENTROCUSTORATEIO', ftBCD, 16387, 2)]
    [Dictionary('OMF_CENTROCUSTORATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_CENTROCUSTORATEIO: Double read FOMF_CENTROCUSTORATEIO write FOMF_CENTROCUSTORATEIO;
    const OMF_CENTROCUSTORATEIO_Name = 'OMF_CENTROCUSTORATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: String read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;
    const OMF_INTEGRACAOERP_Name = 'OMF_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('OMF_06_ID_OLD', ftInteger)]
    [Dictionary('OMF_06_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_06_ID_OLD: Integer read FOMF_06_ID_OLD write FOMF_06_ID_OLD;
    const OMF_06_ID_OLD_Name = 'OMF_06_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';

  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_06)

end.
