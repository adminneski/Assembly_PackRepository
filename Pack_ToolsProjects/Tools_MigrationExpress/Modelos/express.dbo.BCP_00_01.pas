unit express.dbo.BCP_00_01;

interface

uses
  DB,
  Classes,
  SysUtils,
  Generics.Collections,
  //goxormbr
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('BCP_00_01', '')]
  [PrimaryKey('BCP_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCP_01_ID')]
  TDtoBCP_00_01 = class
  private
    { Private declarations }
    FBCP_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCP_ID: Integer;
    FCRE_ID: Integer;
    FCRE_DC: String;
    FCRE_TIPOBAIXA: String;
    FCRE_TIPODOCUMENTO: String;
    FCRE_NUMERODOCTO: String;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALMULTA: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_TOTALVALORBAIXA: Double;
    FCRE_PERCENTUALJUROS: Double;
    FCRE_PLANOCONTARATEIO: Double;
    FCRE_HISTORICO: String;
    FBCP_DATAALTERACAO: TDateTime;
    FBCP_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
    FBCP_01_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'BCP_00_01';
    const PrimaryKey = 'BCP_01_ID';
    const Sequence   = 'SEQ_BCP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_01_ID', ftInteger)]
    [Dictionary('BCP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_01_ID: Integer read FBCP_01_ID write FBCP_01_ID;
    const BCP_01_ID_Name = 'BCP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_ID', ftInteger)]
    [ForeignKey('BCP_00_01_fk', 'BCP_ID', 'BCP_00', 'BCP_ID', SetNull, SetNull)]
    [Dictionary('BCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID: Integer read FBCP_ID write FBCP_ID;
    const BCP_ID_Name = 'BCP_ID';

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
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('CRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMERODOCTO: String read FCRE_NUMERODOCTO write FCRE_NUMERODOCTO;
    const CRE_NUMERODOCTO_Name = 'CRE_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

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
    [Column('CRE_PERCENTUALJUROS', ftBCD)]
    [Dictionary('CRE_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALJUROS: Double read FCRE_PERCENTUALJUROS write FCRE_PERCENTUALJUROS;
    const CRE_PERCENTUALJUROS_Name = 'CRE_PERCENTUALJUROS';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCP_DATAALTERACAO: TDateTime read FBCP_DATAALTERACAO write FBCP_DATAALTERACAO;
    const BCP_DATAALTERACAO_Name = 'BCP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BCP_ID_OLD', ftInteger)]
    [Dictionary('BCP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID_OLD: Integer read FBCP_ID_OLD write FBCP_ID_OLD;
    const BCP_ID_OLD_Name = 'BCP_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCP_01_ID_OLD', ftInteger)]
    [Dictionary('BCP_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_01_ID_OLD: Integer read FBCP_01_ID_OLD write FBCP_01_ID_OLD;
    const BCP_01_ID_OLD_Name = 'BCP_01_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCP_00_01)

end.
