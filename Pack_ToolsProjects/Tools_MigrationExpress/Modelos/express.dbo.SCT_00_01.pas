unit express.dbo.SCT_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.sct_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('SCT_00_01', '')]
  [PrimaryKey('SCT_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCT_01_ID')]
  TDtoSCT_00_01 = class
  private
    { Private declarations } 
    FSCT_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCT_ID: Integer;
    FCRE_ID: Integer;
    FCTR_ID: Integer;
    FCRE_DATAVENCTOVELHO: TDateTime;
    FCRE_DATAVENCTONOVO: TDateTime;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALICMS: Double;
    FCRE_TOTALFRETE: Double;
    FCRE_TOTALSEGURO: Double;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALMULTA: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_PERCENTUALJUROS: Double;
    FCRE_TOTALSUBSTITUIDO: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_TIPODOCUMENTO: String;
    FSCT_DATAALTERACAO: TDateTime;
    FSCT_01_ID_OLD: Integer;
    FSCT_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
    FCTR_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCT_00_01';
    const PrimaryKey = 'SCT_01_ID';
    const Sequence   = 'SEQ_SCT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_01_ID', ftInteger)]
    [Dictionary('SCT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_01_ID: Integer read FSCT_01_ID write FSCT_01_ID;
    const SCT_01_ID_Name = 'SCT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_ID', ftInteger)]
    [ForeignKey('SCT_00_01_fk', 'SCT_ID', 'SCT_00', 'SCT_ID', SetNull, SetNull)]
    [Dictionary('SCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID: Integer read FSCT_ID write FSCT_ID;
    const SCT_ID_Name = 'SCT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTOVELHO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTOVELHO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTOVELHO: TDateTime read FCRE_DATAVENCTOVELHO write FCRE_DATAVENCTOVELHO;
    const CRE_DATAVENCTOVELHO_Name = 'CRE_DATAVENCTOVELHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTONOVO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTONOVO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTONOVO: TDateTime read FCRE_DATAVENCTONOVO write FCRE_DATAVENCTONOVO;
    const CRE_DATAVENCTONOVO_Name = 'CRE_DATAVENCTONOVO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD, 4456531, 2)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALICMS', ftBCD, 1195983951, 2)]
    [Dictionary('CRE_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALICMS: Double read FCRE_TOTALICMS write FCRE_TOTALICMS;
    const CRE_TOTALICMS_Name = 'CRE_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFRETE', ftBCD, 1397311055, 2)]
    [Dictionary('CRE_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFRETE: Double read FCRE_TOTALFRETE write FCRE_TOTALFRETE;
    const CRE_TOTALFRETE_Name = 'CRE_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALSEGURO', ftBCD, 218762555, 2)]
    [Dictionary('CRE_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALSEGURO: Double read FCRE_TOTALSEGURO write FCRE_TOTALSEGURO;
    const CRE_TOTALSEGURO_Name = 'CRE_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROS', ftBCD, 1952672068, 2)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTA', ftBCD, 537529693, 2)]
    [Dictionary('CRE_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTA: Double read FCRE_TOTALMULTA write FCRE_TOTALMULTA;
    const CRE_TOTALMULTA_Name = 'CRE_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTO', ftBCD, 1162039111, 2)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIO', ftBCD, 659507017, 2)]
    [Dictionary('CRE_TOTALCARTORIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIO: Double read FCRE_TOTALCARTORIO write FCRE_TOTALCARTORIO;
    const CRE_TOTALCARTORIO_Name = 'CRE_TOTALCARTORIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALJUROS', ftBCD, 1380275039, 2)]
    [Dictionary('CRE_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALJUROS: Double read FCRE_PERCENTUALJUROS write FCRE_PERCENTUALJUROS;
    const CRE_PERCENTUALJUROS_Name = 'CRE_PERCENTUALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALSUBSTITUIDO', ftBCD, 1699555104, 2)]
    [Dictionary('CRE_TOTALSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALSUBSTITUIDO: Double read FCRE_TOTALSUBSTITUIDO write FCRE_TOTALSUBSTITUIDO;
    const CRE_TOTALSUBSTITUIDO_Name = 'CRE_TOTALSUBSTITUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESAS', ftBCD, 1936020059, 2)]
    [Dictionary('CRE_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESAS: Double read FCRE_TOTALOUTRASDESPESAS write FCRE_TOTALOUTRASDESPESAS;
    const CRE_TOTALOUTRASDESPESAS_Name = 'CRE_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAALTERACAO: TDateTime read FSCT_DATAALTERACAO write FSCT_DATAALTERACAO;
    const SCT_DATAALTERACAO_Name = 'SCT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCT_01_ID_OLD', ftInteger)]
    [Dictionary('SCT_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_01_ID_OLD: Integer read FSCT_01_ID_OLD write FSCT_01_ID_OLD;
    const SCT_01_ID_OLD_Name = 'SCT_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCT_ID_OLD', ftInteger)]
    [Dictionary('SCT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID_OLD: Integer read FSCT_ID_OLD write FSCT_ID_OLD;
    const SCT_ID_OLD_Name = 'SCT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoSCT_00_01)

end.
