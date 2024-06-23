unit express.dbo.BCP_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.bcp_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('BCP_00_02', '')]
  [PrimaryKey('BCP_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCP_02_ID')]
  TDtoBCP_00_02 = class
  private
    { Private declarations } 
    FBCP_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCP_ID: Integer;
    FCPA_ID: Integer;
    FCPA_DC: String;
    FCPA_NUMERODOCTO: String;
    FCPA_TIPOBAIXA: String;
    FBCO_CODIGOBAIXA: Integer;
    FCPA_DATABAIXA: TDateTime;
    FCPA_TOTALJUROS: Double;
    FCPA_TOTALMULTA: Double;
    FCPA_TOTALDESCTO: Double;
    FCPA_TOTALVALOR: Double;
    FCPA_TOTALVALORBAIXA: Double;
    FCPA_TOTALOUTRASDESPESAS: Double;
    FCPA_PERCENTUALJUROS: Double;
    FCPA_PLANOCONTARATEIO: Double;
    FCPA_HISTORICO: String;
    FBCP_DATAALTERACAO: TDateTime;
    FBCP_ID_OLD: Integer;
    FCPA_ID_OLD: Integer;
    FBCP_02_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'BCP_00_02';
    const PrimaryKey = 'BCP_02_ID';
    const Sequence   = 'SEQ_BCP_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_02_ID', ftInteger)]
    [Dictionary('BCP_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_02_ID: Integer read FBCP_02_ID write FBCP_02_ID;
    const BCP_02_ID_Name = 'BCP_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_ID', ftInteger)]
    [ForeignKey('BCP_00_02_fk', 'BCP_ID', 'BCP_00', 'BCP_ID', SetNull, SetNull)]
    [Dictionary('BCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID: Integer read FBCP_ID write FBCP_ID;
    const BCP_ID_Name = 'BCP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DC', ftString, 1)]
    [Dictionary('CPA_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DC: String read FCPA_DC write FCPA_DC;
    const CPA_DC_Name = 'CPA_DC';

    [Restrictions([NoValidate])]
    [Column('CPA_NUMERODOCTO', ftString, 20)]
    [Dictionary('CPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NUMERODOCTO: String read FCPA_NUMERODOCTO write FCPA_NUMERODOCTO;
    const CPA_NUMERODOCTO_Name = 'CPA_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TIPOBAIXA', ftString, 1)]
    [Dictionary('CPA_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPOBAIXA: String read FCPA_TIPOBAIXA write FCPA_TIPOBAIXA;
    const CPA_TIPOBAIXA_Name = 'CPA_TIPOBAIXA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGOBAIXA', ftInteger)]
    [Dictionary('BCO_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGOBAIXA: Integer read FBCO_CODIGOBAIXA write FBCO_CODIGOBAIXA;
    const BCO_CODIGOBAIXA_Name = 'BCO_CODIGOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DATABAIXA', ftDateTime)]
    [Dictionary('CPA_DATABAIXA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPA_DATABAIXA: TDateTime read FCPA_DATABAIXA write FCPA_DATABAIXA;
    const CPA_DATABAIXA_Name = 'CPA_DATABAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALJUROS', ftBCD)]
    [Dictionary('CPA_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROS: Double read FCPA_TOTALJUROS write FCPA_TOTALJUROS;
    const CPA_TOTALJUROS_Name = 'CPA_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALMULTA', ftBCD)]
    [Dictionary('CPA_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALMULTA: Double read FCPA_TOTALMULTA write FCPA_TOTALMULTA;
    const CPA_TOTALMULTA_Name = 'CPA_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALDESCTO', ftBCD)]
    [Dictionary('CPA_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTO: Double read FCPA_TOTALDESCTO write FCPA_TOTALDESCTO;
    const CPA_TOTALDESCTO_Name = 'CPA_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALVALOR', ftBCD)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CPA_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORBAIXA: Double read FCPA_TOTALVALORBAIXA write FCPA_TOTALVALORBAIXA;
    const CPA_TOTALVALORBAIXA_Name = 'CPA_TOTALVALORBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CPA_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESAS: Double read FCPA_TOTALOUTRASDESPESAS write FCPA_TOTALOUTRASDESPESAS;
    const CPA_TOTALOUTRASDESPESAS_Name = 'CPA_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_PERCENTUALJUROS', ftBCD)]
    [Dictionary('CPA_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALJUROS: Double read FCPA_PERCENTUALJUROS write FCPA_PERCENTUALJUROS;
    const CPA_PERCENTUALJUROS_Name = 'CPA_PERCENTUALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('CPA_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PLANOCONTARATEIO: Double read FCPA_PLANOCONTARATEIO write FCPA_PLANOCONTARATEIO;
    const CPA_PLANOCONTARATEIO_Name = 'CPA_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CPA_HISTORICO', ftString, 5000)]
    [Dictionary('CPA_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_HISTORICO: String read FCPA_HISTORICO write FCPA_HISTORICO;
    const CPA_HISTORICO_Name = 'CPA_HISTORICO';

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
    [Column('CPA_ID_OLD', ftInteger)]
    [Dictionary('CPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID_OLD: Integer read FCPA_ID_OLD write FCPA_ID_OLD;
    const CPA_ID_OLD_Name = 'CPA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCP_02_ID_OLD', ftInteger)]
    [Dictionary('BCP_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_02_ID_OLD: Integer read FBCP_02_ID_OLD write FBCP_02_ID_OLD;
    const BCP_02_ID_OLD_Name = 'BCP_02_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCP_00_02)

end.
