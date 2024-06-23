unit express.dbo.SCP_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.scp_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('SCP_00_01', '')]
  [PrimaryKey('SCP_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCP_01_ID')]
  TDtoSCP_00_01 = class
  private
    { Private declarations } 
    FSCP_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCP_ID: Integer;
    FCPA_ID: Integer;
    FCPA_DATAVENCTONOVO: TDateTime;
    FCPA_DATAVENCTOVELHO: TDateTime;
    FCPA_TOTALJUROS: Double;
    FCPA_TOTALVALOR: Double;
    FCPA_TOTALMULTA: Double;
    FCPA_TOTALDESCTO: Double;
    FCPA_PERCENTUALJUROS: Double;
    FCPA_TOTALOUTRASDESPESAS: Double;
    FCPA_TOTALSUBSTITUIDO: Double;
    FSCP_DATAALTERACAO: TDateTime;
    FSCP_01_ID_OLD: Integer;
    FSCP_ID_OLD: Integer;
    FCPA_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCP_00_01';
    const PrimaryKey = 'SCP_01_ID';
    const Sequence   = 'SEQ_SCP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_01_ID', ftInteger)]
    [Dictionary('SCP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_01_ID: Integer read FSCP_01_ID write FSCP_01_ID;
    const SCP_01_ID_Name = 'SCP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_ID', ftInteger)]
    [ForeignKey('SCP_00_01_fk', 'SCP_ID', 'SCP_00', 'SCP_ID', SetNull, SetNull)]
    [Dictionary('SCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID: Integer read FSCP_ID write FSCP_ID;
    const SCP_ID_Name = 'SCP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DATAVENCTONOVO', ftDateTime)]
    [Dictionary('CPA_DATAVENCTONOVO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPA_DATAVENCTONOVO: TDateTime read FCPA_DATAVENCTONOVO write FCPA_DATAVENCTONOVO;
    const CPA_DATAVENCTONOVO_Name = 'CPA_DATAVENCTONOVO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DATAVENCTOVELHO', ftDateTime)]
    [Dictionary('CPA_DATAVENCTOVELHO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPA_DATAVENCTOVELHO: TDateTime read FCPA_DATAVENCTOVELHO write FCPA_DATAVENCTOVELHO;
    const CPA_DATAVENCTOVELHO_Name = 'CPA_DATAVENCTOVELHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALJUROS', ftBCD, 5177428, 2)]
    [Dictionary('CPA_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROS: Double read FCPA_TOTALJUROS write FCPA_TOTALJUROS;
    const CPA_TOTALJUROS_Name = 'CPA_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALVALOR', ftBCD, 1835362145, 2)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALMULTA', ftBCD, 1145132617, 2)]
    [Dictionary('CPA_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALMULTA: Double read FCPA_TOTALMULTA write FCPA_TOTALMULTA;
    const CPA_TOTALMULTA_Name = 'CPA_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALDESCTO', ftBCD, 1411398223, 2)]
    [Dictionary('CPA_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTO: Double read FCPA_TOTALDESCTO write FCPA_TOTALDESCTO;
    const CPA_TOTALDESCTO_Name = 'CPA_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_PERCENTUALJUROS', ftBCD, 539780974, 2)]
    [Dictionary('CPA_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALJUROS: Double read FCPA_PERCENTUALJUROS write FCPA_PERCENTUALJUROS;
    const CPA_PERCENTUALJUROS_Name = 'CPA_PERCENTUALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALOUTRASDESPESAS', ftBCD, 1415532614, 2)]
    [Dictionary('CPA_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESAS: Double read FCPA_TOTALOUTRASDESPESAS write FCPA_TOTALOUTRASDESPESAS;
    const CPA_TOTALOUTRASDESPESAS_Name = 'CPA_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALSUBSTITUIDO', ftBCD, 1952867660, 2)]
    [Dictionary('CPA_TOTALSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALSUBSTITUIDO: Double read FCPA_TOTALSUBSTITUIDO write FCPA_TOTALSUBSTITUIDO;
    const CPA_TOTALSUBSTITUIDO_Name = 'CPA_TOTALSUBSTITUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATAALTERACAO: TDateTime read FSCP_DATAALTERACAO write FSCP_DATAALTERACAO;
    const SCP_DATAALTERACAO_Name = 'SCP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCP_01_ID_OLD', ftInteger)]
    [Dictionary('SCP_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_01_ID_OLD: Integer read FSCP_01_ID_OLD write FSCP_01_ID_OLD;
    const SCP_01_ID_OLD_Name = 'SCP_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCP_ID_OLD', ftInteger)]
    [Dictionary('SCP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID_OLD: Integer read FSCP_ID_OLD write FSCP_ID_OLD;
    const SCP_ID_OLD_Name = 'SCP_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_ID_OLD', ftInteger)]
    [Dictionary('CPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID_OLD: Integer read FCPA_ID_OLD write FCPA_ID_OLD;
    const CPA_ID_OLD_Name = 'CPA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCP_00_01)

end.
