unit express.dbo.SCT_00_02;

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
  [Table('SCT_00_02', '')]
  [PrimaryKey('SCT_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCT_02_ID')]
  TDtoSCT_00_02 = class
  private
    { Private declarations } 
    FSCT_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCT_ID: Integer;
    FPES_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FSCT_DATAVENCTO: TDateTime;
    FSCT_TOTALVALOR: Double;
    FSCT_DATAEMISSAO: TDateTime;
    FSCT_NUMERODOCTO: String;
    FSCT_NOSSONUMERO: String;
    FSCT_DATAMULTA: TDateTime;
    FSCT_DATADESCTO: TDateTime;
    FSCT_VALORMULTA: Double;
    FSCT_VALORDESCTO: Double;
    FSCT_PERCENTUALMULTA: Double;
    FSCT_PERCENTUALDESCTO: Double;
    FSCT_PERCENTUALMORADIARIA: Double;
    FSCT_DATAALTERACAO: TDateTime;
    FSCT_COMPETENCIA: String;
    FCTA_CODIGO: Integer;
    FSCT_REFERENCIATRANSPORTE: String;
    FSCT_02_ID_OLD: Integer;
    FSCT_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCT_00_02';
    const PrimaryKey = 'SCT_02_ID';
    const Sequence   = 'SEQ_SCT_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_02_ID', ftInteger)]
    [Dictionary('SCT_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_02_ID: Integer read FSCT_02_ID write FSCT_02_ID;
    const SCT_02_ID_Name = 'SCT_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_ID', ftInteger)]
    [ForeignKey('SCT_00_02_fk', 'SCT_ID', 'SCT_00', 'SCT_ID', SetNull, SetNull)]
    [Dictionary('SCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID: Integer read FSCT_ID write FSCT_ID;
    const SCT_ID_Name = 'SCT_ID';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

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
    [Column('SCT_DATAVENCTO', ftDateTime)]
    [Dictionary('SCT_DATAVENCTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAVENCTO: TDateTime read FSCT_DATAVENCTO write FSCT_DATAVENCTO;
    const SCT_DATAVENCTO_Name = 'SCT_DATAVENCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_TOTALVALOR', ftBCD, 218762555, 2)]
    [Dictionary('SCT_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALOR: Double read FSCT_TOTALVALOR write FSCT_TOTALVALOR;
    const SCT_TOTALVALOR_Name = 'SCT_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCT_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAEMISSAO: TDateTime read FSCT_DATAEMISSAO write FSCT_DATAEMISSAO;
    const SCT_DATAEMISSAO_Name = 'SCT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('SCT_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_NUMERODOCTO: String read FSCT_NUMERODOCTO write FSCT_NUMERODOCTO;
    const SCT_NUMERODOCTO_Name = 'SCT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCT_NOSSONUMERO', ftString, 20)]
    [Dictionary('SCT_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_NOSSONUMERO: String read FSCT_NOSSONUMERO write FSCT_NOSSONUMERO;
    const SCT_NOSSONUMERO_Name = 'SCT_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('SCT_DATAMULTA', ftDateTime)]
    [Dictionary('SCT_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property SCT_DATAMULTA: TDateTime read FSCT_DATAMULTA write FSCT_DATAMULTA;
    const SCT_DATAMULTA_Name = 'SCT_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('SCT_DATADESCTO', ftDateTime)]
    [Dictionary('SCT_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCT_DATADESCTO: TDateTime read FSCT_DATADESCTO write FSCT_DATADESCTO;
    const SCT_DATADESCTO_Name = 'SCT_DATADESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_VALORMULTA', ftBCD, 1952672068, 2)]
    [Dictionary('SCT_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_VALORMULTA: Double read FSCT_VALORMULTA write FSCT_VALORMULTA;
    const SCT_VALORMULTA_Name = 'SCT_VALORMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_VALORDESCTO', ftBCD, 537529693, 2)]
    [Dictionary('SCT_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_VALORDESCTO: Double read FSCT_VALORDESCTO write FSCT_VALORDESCTO;
    const SCT_VALORDESCTO_Name = 'SCT_VALORDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_PERCENTUALMULTA', ftBCD, 1162039111, 2)]
    [Dictionary('SCT_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_PERCENTUALMULTA: Double read FSCT_PERCENTUALMULTA write FSCT_PERCENTUALMULTA;
    const SCT_PERCENTUALMULTA_Name = 'SCT_PERCENTUALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_PERCENTUALDESCTO', ftBCD, 659507017, 2)]
    [Dictionary('SCT_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_PERCENTUALDESCTO: Double read FSCT_PERCENTUALDESCTO write FSCT_PERCENTUALDESCTO;
    const SCT_PERCENTUALDESCTO_Name = 'SCT_PERCENTUALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_PERCENTUALMORADIARIA', ftBCD, 1380275039, 2)]
    [Dictionary('SCT_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_PERCENTUALMORADIARIA: Double read FSCT_PERCENTUALMORADIARIA write FSCT_PERCENTUALMORADIARIA;
    const SCT_PERCENTUALMORADIARIA_Name = 'SCT_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAALTERACAO: TDateTime read FSCT_DATAALTERACAO write FSCT_DATAALTERACAO;
    const SCT_DATAALTERACAO_Name = 'SCT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCT_COMPETENCIA', ftString, 6)]
    [Dictionary('SCT_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_COMPETENCIA: String read FSCT_COMPETENCIA write FSCT_COMPETENCIA;
    const SCT_COMPETENCIA_Name = 'SCT_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SCT_REFERENCIATRANSPORTE', ftString, 100)]
    [Dictionary('SCT_REFERENCIATRANSPORTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_REFERENCIATRANSPORTE: String read FSCT_REFERENCIATRANSPORTE write FSCT_REFERENCIATRANSPORTE;
    const SCT_REFERENCIATRANSPORTE_Name = 'SCT_REFERENCIATRANSPORTE';

    [Restrictions([NoValidate])]
    [Column('SCT_02_ID_OLD', ftInteger)]
    [Dictionary('SCT_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_02_ID_OLD: Integer read FSCT_02_ID_OLD write FSCT_02_ID_OLD;
    const SCT_02_ID_OLD_Name = 'SCT_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCT_ID_OLD', ftInteger)]
    [Dictionary('SCT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID_OLD: Integer read FSCT_ID_OLD write FSCT_ID_OLD;
    const SCT_ID_OLD_Name = 'SCT_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoSCT_00_02)

end.
