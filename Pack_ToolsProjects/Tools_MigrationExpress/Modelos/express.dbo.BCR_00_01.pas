unit express.dbo.BCR_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.bcr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('BCR_00_01', '')]
  [PrimaryKey('BCR_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCR_01_ID')]
  TDtoBCR_00_01 = class
  private
    { Private declarations } 
    FBCR_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCR_ID: Integer;
    FCRE_ID: Integer;
    FCRE_DC: String;
    FCRE_TIPOBAIXA: String;
    FCRE_TOTALMULTA: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_PERCENTUALJUROS: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_TOTALVALORBAIXA: Double;
    FCRE_TOTALFINANCEIRO: Double;
    FCRE_PERCENTUALFINANCEIRO: Double;
    FCRE_TIPODOCUMENTO: String;
    FCRE_PLANOCONTARATEIO: Double;
    FCRE_HISTORICO: String;
    FCRE_NUMERODOCTO: String;
    FBCR_DATAALTERACAO: TDateTime;
    FCRE_TOTALTARIFABANCARIA: Double;
    FCRE_NOSSONUMERO: String;
    FCRE_DATALIQUIDACAO: TDateTime;
    FCRE_ESTORNADO: String;
    FBCR_ID_OLD: Integer;
    FBCR_01_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'BCR_00_01';
    const PrimaryKey = 'BCR_01_ID';
    const Sequence   = 'SEQ_BCR_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_01_ID', ftInteger)]
    [Dictionary('BCR_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCR_01_ID: Integer read FBCR_01_ID write FBCR_01_ID;
    const BCR_01_ID_Name = 'BCR_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_ID', ftInteger)]
    [ForeignKey('BCR_00_01_fk', 'BCR_ID', 'BCR_00', 'BCR_ID', SetNull, SetNull)]
    [Dictionary('BCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCR_ID: Integer read FBCR_ID write FBCR_ID;
    const BCR_ID_Name = 'BCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DC', ftString, 1)]
    [Dictionary('CRE_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DC: String read FCRE_DC write FCRE_DC;
    const CRE_DC_Name = 'CRE_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPOBAIXA', ftString, 1)]
    [Dictionary('CRE_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPOBAIXA: String read FCRE_TIPOBAIXA write FCRE_TIPOBAIXA;
    const CRE_TIPOBAIXA_Name = 'CRE_TIPOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTA', ftBCD)]
    [Dictionary('CRE_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTA: Double read FCRE_TOTALMULTA write FCRE_TOTALMULTA;
    const CRE_TOTALMULTA_Name = 'CRE_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTO', ftBCD)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROS', ftBCD)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIO', ftBCD)]
    [Dictionary('CRE_TOTALCARTORIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIO: Double read FCRE_TOTALCARTORIO write FCRE_TOTALCARTORIO;
    const CRE_TOTALCARTORIO_Name = 'CRE_TOTALCARTORIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALJUROS', ftBCD)]
    [Dictionary('CRE_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALJUROS: Double read FCRE_PERCENTUALJUROS write FCRE_PERCENTUALJUROS;
    const CRE_PERCENTUALJUROS_Name = 'CRE_PERCENTUALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CRE_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESAS: Double read FCRE_TOTALOUTRASDESPESAS write FCRE_TOTALOUTRASDESPESAS;
    const CRE_TOTALOUTRASDESPESAS_Name = 'CRE_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXA: Double read FCRE_TOTALVALORBAIXA write FCRE_TOTALVALORBAIXA;
    const CRE_TOTALVALORBAIXA_Name = 'CRE_TOTALVALORBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_TOTALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFINANCEIRO: Double read FCRE_TOTALFINANCEIRO write FCRE_TOTALFINANCEIRO;
    const CRE_TOTALFINANCEIRO_Name = 'CRE_TOTALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALFINANCEIRO: Double read FCRE_PERCENTUALFINANCEIRO write FCRE_PERCENTUALFINANCEIRO;
    const CRE_PERCENTUALFINANCEIRO_Name = 'CRE_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('CRE_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PLANOCONTARATEIO: Double read FCRE_PLANOCONTARATEIO write FCRE_PLANOCONTARATEIO;
    const CRE_PLANOCONTARATEIO_Name = 'CRE_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CRE_HISTORICO', ftString, 5000)]
    [Dictionary('CRE_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_HISTORICO: String read FCRE_HISTORICO write FCRE_HISTORICO;
    const CRE_HISTORICO_Name = 'CRE_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('CRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMERODOCTO: String read FCRE_NUMERODOCTO write FCRE_NUMERODOCTO;
    const CRE_NUMERODOCTO_Name = 'CRE_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCR_DATAALTERACAO: TDateTime read FBCR_DATAALTERACAO write FBCR_DATAALTERACAO;
    const BCR_DATAALTERACAO_Name = 'BCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALTARIFABANCARIA', ftBCD)]
    [Dictionary('CRE_TOTALTARIFABANCARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALTARIFABANCARIA: Double read FCRE_TOTALTARIFABANCARIA write FCRE_TOTALTARIFABANCARIA;
    const CRE_TOTALTARIFABANCARIA_Name = 'CRE_TOTALTARIFABANCARIA';

    [Restrictions([NoValidate])]
    [Column('CRE_NOSSONUMERO', ftString, 20)]
    [Dictionary('CRE_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOSSONUMERO: String read FCRE_NOSSONUMERO write FCRE_NOSSONUMERO;
    const CRE_NOSSONUMERO_Name = 'CRE_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATALIQUIDACAO', ftDateTime)]
    [Dictionary('CRE_DATALIQUIDACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATALIQUIDACAO: TDateTime read FCRE_DATALIQUIDACAO write FCRE_DATALIQUIDACAO;
    const CRE_DATALIQUIDACAO_Name = 'CRE_DATALIQUIDACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_ESTORNADO', ftString, 1)]
    [Dictionary('CRE_ESTORNADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_ESTORNADO: String read FCRE_ESTORNADO write FCRE_ESTORNADO;
    const CRE_ESTORNADO_Name = 'CRE_ESTORNADO';

    [Restrictions([NoValidate])]
    [Column('BCR_ID_OLD', ftInteger)]
    [Dictionary('BCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCR_ID_OLD: Integer read FBCR_ID_OLD write FBCR_ID_OLD;
    const BCR_ID_OLD_Name = 'BCR_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCR_01_ID_OLD', ftInteger)]
    [Dictionary('BCR_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCR_01_ID_OLD: Integer read FBCR_01_ID_OLD write FBCR_01_ID_OLD;
    const BCR_01_ID_OLD_Name = 'BCR_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCR_00_01)

end.
