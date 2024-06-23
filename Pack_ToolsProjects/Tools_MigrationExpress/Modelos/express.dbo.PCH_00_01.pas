unit express.dbo.PCH_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.pch_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PCH_00_01', '')]
  [PrimaryKey('PCH_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PCH_01_ID')]
  TDtoPCH_00_01 = class
  private
    { Private declarations } 
    FPCH_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPCH_ID: Integer;
    FCRE_ID: Integer;
    FCRE_DATAPRORROGACAO: TDateTime;
    FCRE_DATAVENCTOVELHO: TDateTime;
    FCRE_DATAVENCTONOVO: TDateTime;
    FCRE_TOTALVALOR: Double;
    FCRE_PRORROGACOES: Integer;
    FCRE_STATUS: String;
    FCRE_VALORJUROS: Double;
    FCRE_PERCENTUALJUROS: Double;
    FCRE_NUMERODOCTO: String;
    FPCH_DATAALTERACAO: TDateTime;
    FPCH_01_ID_OLD: Integer;
    FPCH_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PCH_00_01';
    const PrimaryKey = 'PCH_01_ID';
    const Sequence   = 'SEQ_PCH_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_01_ID', ftInteger)]
    [Dictionary('PCH_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_01_ID: Integer read FPCH_01_ID write FPCH_01_ID;
    const PCH_01_ID_Name = 'PCH_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_ID', ftInteger)]
    [ForeignKey('PCH_00_01_fk', 'PCH_ID', 'PCH_00', 'PCH_ID', SetNull, SetNull)]
    [Dictionary('PCH_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_ID: Integer read FPCH_ID write FPCH_ID;
    const PCH_ID_Name = 'PCH_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAPRORROGACAO', ftDateTime)]
    [Dictionary('CRE_DATAPRORROGACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAPRORROGACAO: TDateTime read FCRE_DATAPRORROGACAO write FCRE_DATAPRORROGACAO;
    const CRE_DATAPRORROGACAO_Name = 'CRE_DATAPRORROGACAO';

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
    [Column('CRE_TOTALVALOR', ftBCD, 5374017, 2)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PRORROGACOES', ftInteger)]
    [Dictionary('CRE_PRORROGACOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PRORROGACOES: Integer read FCRE_PRORROGACOES write FCRE_PRORROGACOES;
    const CRE_PRORROGACOES_Name = 'CRE_PRORROGACOES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_STATUS', ftString, 1)]
    [Dictionary('CRE_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_STATUS: String read FCRE_STATUS write FCRE_STATUS;
    const CRE_STATUS_Name = 'CRE_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_VALORJUROS', ftBCD, 538970637, 2)]
    [Dictionary('CRE_VALORJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORJUROS: Double read FCRE_VALORJUROS write FCRE_VALORJUROS;
    const CRE_VALORJUROS_Name = 'CRE_VALORJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALJUROS', ftBCD, 1953391939, 2)]
    [Dictionary('CRE_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALJUROS: Double read FCRE_PERCENTUALJUROS write FCRE_PERCENTUALJUROS;
    const CRE_PERCENTUALJUROS_Name = 'CRE_PERCENTUALJUROS';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMERODOCTO', ftString, 15)]
    [Dictionary('CRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMERODOCTO: String read FCRE_NUMERODOCTO write FCRE_NUMERODOCTO;
    const CRE_NUMERODOCTO_Name = 'CRE_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PCH_DATAALTERACAO', ftDateTime)]
    [Dictionary('PCH_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PCH_DATAALTERACAO: TDateTime read FPCH_DATAALTERACAO write FPCH_DATAALTERACAO;
    const PCH_DATAALTERACAO_Name = 'PCH_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PCH_01_ID_OLD', ftInteger)]
    [Dictionary('PCH_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_01_ID_OLD: Integer read FPCH_01_ID_OLD write FPCH_01_ID_OLD;
    const PCH_01_ID_OLD_Name = 'PCH_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PCH_ID_OLD', ftInteger)]
    [Dictionary('PCH_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_ID_OLD: Integer read FPCH_ID_OLD write FPCH_ID_OLD;
    const PCH_ID_OLD_Name = 'PCH_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPCH_00_01)

end.
