unit express.dbo.DCH_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.dch_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('DCH_00_01', '')]
  [PrimaryKey('DCH_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DCH_01_ID')]
  TDtoDCH_00_01 = class
  private
    { Private declarations } 
    FDCH_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FDCH_ID: Integer;
    FCRE_ID: Integer;
    FMDV_ID: Integer;
    FDCH_HISTORICO: String;
    FCRE_DATABAIXA: TDateTime;
    FCTA_CODIGOBAIXA: Integer;
    FDCH_TOTALVALOR: Double;
    FDCH_NUMERODOCTO: String;
    FDCH_DATADEVOLUCAO: TDateTime;
    FDCH_DATAALTERACAO: TDateTime;
    FDCH_01_ID_OLD: Integer;
    FDCH_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'DCH_00_01';
    const PrimaryKey = 'DCH_01_ID';
    const Sequence   = 'SEQ_DCH_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_01_ID', ftInteger)]
    [Dictionary('DCH_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DCH_01_ID: Integer read FDCH_01_ID write FDCH_01_ID;
    const DCH_01_ID_Name = 'DCH_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_ID', ftInteger)]
    [ForeignKey('DCH_00_01_fk', 'DCH_ID', 'DCH_00', 'DCH_ID', SetNull, SetNull)]
    [Dictionary('DCH_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DCH_ID: Integer read FDCH_ID write FDCH_ID;
    const DCH_ID_Name = 'DCH_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('MDV_ID', ftInteger)]
    [Dictionary('MDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDV_ID: Integer read FMDV_ID write FMDV_ID;
    const MDV_ID_Name = 'MDV_ID';

    [Restrictions([NoValidate])]
    [Column('DCH_HISTORICO', ftString, 300)]
    [Dictionary('DCH_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DCH_HISTORICO: String read FDCH_HISTORICO write FDCH_HISTORICO;
    const DCH_HISTORICO_Name = 'DCH_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATABAIXA', ftDateTime)]
    [Dictionary('CRE_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATABAIXA: TDateTime read FCRE_DATABAIXA write FCRE_DATABAIXA;
    const CRE_DATABAIXA_Name = 'CRE_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_TOTALVALOR', ftBCD)]
    [Dictionary('DCH_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DCH_TOTALVALOR: Double read FDCH_TOTALVALOR write FDCH_TOTALVALOR;
    const DCH_TOTALVALOR_Name = 'DCH_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_NUMERODOCTO', ftString, 15)]
    [Dictionary('DCH_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DCH_NUMERODOCTO: String read FDCH_NUMERODOCTO write FDCH_NUMERODOCTO;
    const DCH_NUMERODOCTO_Name = 'DCH_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_DATADEVOLUCAO', ftDateTime)]
    [Dictionary('DCH_DATADEVOLUCAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DCH_DATADEVOLUCAO: TDateTime read FDCH_DATADEVOLUCAO write FDCH_DATADEVOLUCAO;
    const DCH_DATADEVOLUCAO_Name = 'DCH_DATADEVOLUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_DATAALTERACAO', ftDateTime)]
    [Dictionary('DCH_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DCH_DATAALTERACAO: TDateTime read FDCH_DATAALTERACAO write FDCH_DATAALTERACAO;
    const DCH_DATAALTERACAO_Name = 'DCH_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DCH_01_ID_OLD', ftInteger)]
    [Dictionary('DCH_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DCH_01_ID_OLD: Integer read FDCH_01_ID_OLD write FDCH_01_ID_OLD;
    const DCH_01_ID_OLD_Name = 'DCH_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('DCH_ID_OLD', ftInteger)]
    [Dictionary('DCH_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DCH_ID_OLD: Integer read FDCH_ID_OLD write FDCH_ID_OLD;
    const DCH_ID_OLD_Name = 'DCH_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoDCH_00_01)

end.
