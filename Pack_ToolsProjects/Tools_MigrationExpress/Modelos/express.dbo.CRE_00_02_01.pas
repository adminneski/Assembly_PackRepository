unit express.dbo.CRE_00_02_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cre_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CRE_00_02_01', '')]
  [PrimaryKey('CRE_02_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRE_02_01_ID')]
  TDtoCRE_00_02_01 = class
  private
    { Private declarations } 
    FCRE_02_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRE_ID: Integer;
    FCRE_STATUS: String;
    FCRE_DATAVENCTOVELHO: TDateTime;
    FCRE_DATAPRORROGACAO: TDateTime;
    FCRE_PERCENTUALJUROS: Double;
    FCRE_VALORJUROS: Double;
    FCRE_INTEGRACAO: String;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_02_01_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
    FCRE_INTEGRACAO_OLD: String;
  public
    { Public declarations }
    const Table      = 'CRE_00_02_01';
    const PrimaryKey = 'CRE_02_01_ID';
    const Sequence   = 'SEQ_CRE_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_02_01_ID', ftInteger)]
    [Dictionary('CRE_02_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_02_01_ID: Integer read FCRE_02_01_ID write FCRE_02_01_ID;
    const CRE_02_01_ID_Name = 'CRE_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [ForeignKey('CRE_00_02_01_fk', 'CRE_ID', 'CRE_00', 'CRE_ID', SetNull, SetNull)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_STATUS', ftString, 1)]
    [Dictionary('CRE_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_STATUS: String read FCRE_STATUS write FCRE_STATUS;
    const CRE_STATUS_Name = 'CRE_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTOVELHO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTOVELHO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTOVELHO: TDateTime read FCRE_DATAVENCTOVELHO write FCRE_DATAVENCTOVELHO;
    const CRE_DATAVENCTOVELHO_Name = 'CRE_DATAVENCTOVELHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAPRORROGACAO', ftDateTime)]
    [Dictionary('CRE_DATAPRORROGACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAPRORROGACAO: TDateTime read FCRE_DATAPRORROGACAO write FCRE_DATAPRORROGACAO;
    const CRE_DATAPRORROGACAO_Name = 'CRE_DATAPRORROGACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALJUROS', ftBCD)]
    [Dictionary('CRE_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALJUROS: Double read FCRE_PERCENTUALJUROS write FCRE_PERCENTUALJUROS;
    const CRE_PERCENTUALJUROS_Name = 'CRE_PERCENTUALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_VALORJUROS', ftBCD)]
    [Dictionary('CRE_VALORJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORJUROS: Double read FCRE_VALORJUROS write FCRE_VALORJUROS;
    const CRE_VALORJUROS_Name = 'CRE_VALORJUROS';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO', ftString, 20)]
    [Dictionary('CRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO: String read FCRE_INTEGRACAO write FCRE_INTEGRACAO;
    const CRE_INTEGRACAO_Name = 'CRE_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_02_01_ID_OLD', ftInteger)]
    [Dictionary('CRE_02_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_02_01_ID_OLD: Integer read FCRE_02_01_ID_OLD write FCRE_02_01_ID_OLD;
    const CRE_02_01_ID_OLD_Name = 'CRE_02_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('CRE_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO_OLD: String read FCRE_INTEGRACAO_OLD write FCRE_INTEGRACAO_OLD;
    const CRE_INTEGRACAO_OLD_Name = 'CRE_INTEGRACAO_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCRE_00_02_01)

end.
