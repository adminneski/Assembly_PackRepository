unit express.dbo.SCR_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.scr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('SCR_00_03', '')]
  [PrimaryKey('SCR_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCR_03_ID')]
  TDtoSCR_00_03 = class
  private
    { Private declarations } 
    FSCR_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCR_ID: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FSCR_DATAVENCTO: TDateTime;
    FSCR_TOTALVALOR: Double;
    FSCR_DATAEMISSAO: TDateTime;
    FSCR_NUMERODOCTO: String;
    FSCR_NOSSONUMERO: String;
    FSCR_DATAMULTA: TDateTime;
    FSCR_DATADESCTO: TDateTime;
    FSCR_VALORMULTA: Double;
    FSCR_VALORDESCTO: Double;
    FSCR_PERCENTUALMULTA: Double;
    FSCR_PERCENTUALDESCTO: Double;
    FSCR_PERCENTUALMORADIARIA: Double;
    FSCR_DATAALTERACAO: TDateTime;
    FSCR_COMPETENCIA: String;
    FCTA_CODIGO: Integer;
    FSCR_03_ID_OLD: Integer;
    FSCR_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCR_00_03';
    const PrimaryKey = 'SCR_03_ID';
    const Sequence   = 'SEQ_SCR_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_03_ID', ftInteger)]
    [Dictionary('SCR_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_03_ID: Integer read FSCR_03_ID write FSCR_03_ID;
    const SCR_03_ID_Name = 'SCR_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [ForeignKey('SCR_00_03_fk', 'SCR_ID', 'SCR_00', 'SCR_ID', SetNull, SetNull)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAVENCTO', ftDateTime)]
    [Dictionary('SCR_DATAVENCTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAVENCTO: TDateTime read FSCR_DATAVENCTO write FSCR_DATAVENCTO;
    const SCR_DATAVENCTO_Name = 'SCR_DATAVENCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALOR', ftBCD, 656419879, 2)]
    [Dictionary('SCR_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALOR: Double read FSCR_TOTALVALOR write FSCR_TOTALVALOR;
    const SCR_TOTALVALOR_Name = 'SCR_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAEMISSAO: TDateTime read FSCR_DATAEMISSAO write FSCR_DATAEMISSAO;
    const SCR_DATAEMISSAO_Name = 'SCR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMERODOCTO: String read FSCR_NUMERODOCTO write FSCR_NUMERODOCTO;
    const SCR_NUMERODOCTO_Name = 'SCR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCR_NOSSONUMERO', ftString, 20)]
    [Dictionary('SCR_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NOSSONUMERO: String read FSCR_NOSSONUMERO write FSCR_NOSSONUMERO;
    const SCR_NOSSONUMERO_Name = 'SCR_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('SCR_DATAMULTA', ftDateTime)]
    [Dictionary('SCR_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property SCR_DATAMULTA: TDateTime read FSCR_DATAMULTA write FSCR_DATAMULTA;
    const SCR_DATAMULTA_Name = 'SCR_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('SCR_DATADESCTO', ftDateTime)]
    [Dictionary('SCR_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCR_DATADESCTO: TDateTime read FSCR_DATADESCTO write FSCR_DATADESCTO;
    const SCR_DATADESCTO_Name = 'SCR_DATADESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_VALORMULTA', ftBCD, 1146045279, 2)]
    [Dictionary('SCR_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_VALORMULTA: Double read FSCR_VALORMULTA write FSCR_VALORMULTA;
    const SCR_VALORMULTA_Name = 'SCR_VALORMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_VALORDESCTO', ftBCD, 1981834596, 2)]
    [Dictionary('SCR_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_VALORDESCTO: Double read FSCR_VALORDESCTO write FSCR_VALORDESCTO;
    const SCR_VALORDESCTO_Name = 'SCR_VALORDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PERCENTUALMULTA', ftBCD, 1142962771, 2)]
    [Dictionary('SCR_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_PERCENTUALMULTA: Double read FSCR_PERCENTUALMULTA write FSCR_PERCENTUALMULTA;
    const SCR_PERCENTUALMULTA_Name = 'SCR_PERCENTUALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PERCENTUALDESCTO', ftBCD, 544040295, 2)]
    [Dictionary('SCR_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_PERCENTUALDESCTO: Double read FSCR_PERCENTUALDESCTO write FSCR_PERCENTUALDESCTO;
    const SCR_PERCENTUALDESCTO_Name = 'SCR_PERCENTUALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PERCENTUALMORADIARIA', ftBCD, 2097273, 2)]
    [Dictionary('SCR_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_PERCENTUALMORADIARIA: Double read FSCR_PERCENTUALMORADIARIA write FSCR_PERCENTUALMORADIARIA;
    const SCR_PERCENTUALMORADIARIA_Name = 'SCR_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAALTERACAO: TDateTime read FSCR_DATAALTERACAO write FSCR_DATAALTERACAO;
    const SCR_DATAALTERACAO_Name = 'SCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCR_COMPETENCIA', ftString, 6)]
    [Dictionary('SCR_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_COMPETENCIA: String read FSCR_COMPETENCIA write FSCR_COMPETENCIA;
    const SCR_COMPETENCIA_Name = 'SCR_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SCR_03_ID_OLD', ftInteger)]
    [Dictionary('SCR_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_03_ID_OLD: Integer read FSCR_03_ID_OLD write FSCR_03_ID_OLD;
    const SCR_03_ID_OLD_Name = 'SCR_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCR_ID_OLD', ftInteger)]
    [Dictionary('SCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID_OLD: Integer read FSCR_ID_OLD write FSCR_ID_OLD;
    const SCR_ID_OLD_Name = 'SCR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCR_00_03)

end.
