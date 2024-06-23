unit express.dbo.SCP_00_02;

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
  [Table('SCP_00_02', '')]
  [PrimaryKey('SCP_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCP_02_ID')]
  TDtoSCP_00_02 = class
  private
    { Private declarations } 
    FSCP_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCP_ID: Integer;
    FBCO_CODIGO: Integer;
    FSCP_NUMERODOCTO: String;
    FSCP_COMPETENCIA: String;
    FSCP_DATAEMISSAO: TDateTime;
    FSCP_DATAVENCTO: TDateTime;
    FSCP_TOTALVALOR: Double;
    FSCP_DATAMULTA: TDateTime;
    FSCP_DATADESCTO: TDateTime;
    FSCP_VALORMULTA: Double;
    FSCP_VALORDESCTO: Double;
    FSCP_PERCENTUALDESCTO: Double;
    FSCP_PERCENTUALMULTA: Double;
    FSCP_PERCENTUALMORADIARIA: Double;
    FSCP_DATAALTERACAO: TDateTime;
    FSCP_02_ID_OLD: Integer;
    FSCP_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCP_00_02';
    const PrimaryKey = 'SCP_02_ID';
    const Sequence   = 'SEQ_SCP_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_02_ID', ftInteger)]
    [Dictionary('SCP_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_02_ID: Integer read FSCP_02_ID write FSCP_02_ID;
    const SCP_02_ID_Name = 'SCP_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_ID', ftInteger)]
    [ForeignKey('SCP_00_02_fk', 'SCP_ID', 'SCP_00', 'SCP_ID', SetNull, SetNull)]
    [Dictionary('SCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID: Integer read FSCP_ID write FSCP_ID;
    const SCP_ID_Name = 'SCP_ID';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCP_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCP_NUMERODOCTO: String read FSCP_NUMERODOCTO write FSCP_NUMERODOCTO;
    const SCP_NUMERODOCTO_Name = 'SCP_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCP_COMPETENCIA', ftString, 6)]
    [Dictionary('SCP_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCP_COMPETENCIA: String read FSCP_COMPETENCIA write FSCP_COMPETENCIA;
    const SCP_COMPETENCIA_Name = 'SCP_COMPETENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCP_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATAEMISSAO: TDateTime read FSCP_DATAEMISSAO write FSCP_DATAEMISSAO;
    const SCP_DATAEMISSAO_Name = 'SCP_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATAVENCTO', ftDateTime)]
    [Dictionary('SCP_DATAVENCTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATAVENCTO: TDateTime read FSCP_DATAVENCTO write FSCP_DATAVENCTO;
    const SCP_DATAVENCTO_Name = 'SCP_DATAVENCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_TOTALVALOR', ftBCD, 1835362145, 2)]
    [Dictionary('SCP_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_TOTALVALOR: Double read FSCP_TOTALVALOR write FSCP_TOTALVALOR;
    const SCP_TOTALVALOR_Name = 'SCP_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('SCP_DATAMULTA', ftDateTime)]
    [Dictionary('SCP_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property SCP_DATAMULTA: TDateTime read FSCP_DATAMULTA write FSCP_DATAMULTA;
    const SCP_DATAMULTA_Name = 'SCP_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('SCP_DATADESCTO', ftDateTime)]
    [Dictionary('SCP_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCP_DATADESCTO: TDateTime read FSCP_DATADESCTO write FSCP_DATADESCTO;
    const SCP_DATADESCTO_Name = 'SCP_DATADESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_VALORMULTA', ftBCD, 1145132617, 2)]
    [Dictionary('SCP_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_VALORMULTA: Double read FSCP_VALORMULTA write FSCP_VALORMULTA;
    const SCP_VALORMULTA_Name = 'SCP_VALORMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_VALORDESCTO', ftBCD, 1411398223, 2)]
    [Dictionary('SCP_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_VALORDESCTO: Double read FSCP_VALORDESCTO write FSCP_VALORDESCTO;
    const SCP_VALORDESCTO_Name = 'SCP_VALORDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_PERCENTUALDESCTO', ftBCD, 539780974, 2)]
    [Dictionary('SCP_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_PERCENTUALDESCTO: Double read FSCP_PERCENTUALDESCTO write FSCP_PERCENTUALDESCTO;
    const SCP_PERCENTUALDESCTO_Name = 'SCP_PERCENTUALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_PERCENTUALMULTA', ftBCD, 1415532614, 2)]
    [Dictionary('SCP_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_PERCENTUALMULTA: Double read FSCP_PERCENTUALMULTA write FSCP_PERCENTUALMULTA;
    const SCP_PERCENTUALMULTA_Name = 'SCP_PERCENTUALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_PERCENTUALMORADIARIA', ftBCD, 1952867660, 2)]
    [Dictionary('SCP_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_PERCENTUALMORADIARIA: Double read FSCP_PERCENTUALMORADIARIA write FSCP_PERCENTUALMORADIARIA;
    const SCP_PERCENTUALMORADIARIA_Name = 'SCP_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATAALTERACAO: TDateTime read FSCP_DATAALTERACAO write FSCP_DATAALTERACAO;
    const SCP_DATAALTERACAO_Name = 'SCP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCP_02_ID_OLD', ftInteger)]
    [Dictionary('SCP_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_02_ID_OLD: Integer read FSCP_02_ID_OLD write FSCP_02_ID_OLD;
    const SCP_02_ID_OLD_Name = 'SCP_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCP_ID_OLD', ftInteger)]
    [Dictionary('SCP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID_OLD: Integer read FSCP_ID_OLD write FSCP_ID_OLD;
    const SCP_ID_OLD_Name = 'SCP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCP_00_02)

end.
