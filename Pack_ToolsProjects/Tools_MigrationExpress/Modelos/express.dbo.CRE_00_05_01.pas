unit express.dbo.CRE_00_05_01;

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
  [Table('CRE_00_05_01', '')]
  [PrimaryKey('CRE_05_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRE_05_01_ID')]
  TDtoCRE_00_05_01 = class
  private
    { Private declarations } 
    FCRE_05_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRE_ID: Integer;
    FCRE_05_ID: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FCRE_VALORRATEIO: Double;
    FCRE_PERCENTUALRATEIO: Double;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_ID_OLD: Integer;
    FCRE_05_ID_OLD: Integer;
    FCRE_05_01_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CRE_00_05_01';
    const PrimaryKey = 'CRE_05_01_ID';
    const Sequence   = 'SEQ_CRE_05_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_05_01_ID', ftInteger)]
    [Dictionary('CRE_05_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_05_01_ID: Integer read FCRE_05_01_ID write FCRE_05_01_ID;
    const CRE_05_01_ID_Name = 'CRE_05_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [ForeignKey('CRE_00_05_01_fk', 'CRE_ID', 'CRE_00', 'CRE_ID', SetNull, SetNull)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_05_ID', ftInteger)]
    [Dictionary('CRE_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_05_ID: Integer read FCRE_05_ID write FCRE_05_ID;
    const CRE_05_ID_Name = 'CRE_05_ID';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_VALORRATEIO', ftBCD)]
    [Dictionary('CRE_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORRATEIO: Double read FCRE_VALORRATEIO write FCRE_VALORRATEIO;
    const CRE_VALORRATEIO_Name = 'CRE_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('CRE_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALRATEIO: Double read FCRE_PERCENTUALRATEIO write FCRE_PERCENTUALRATEIO;
    const CRE_PERCENTUALRATEIO_Name = 'CRE_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_05_ID_OLD', ftInteger)]
    [Dictionary('CRE_05_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_05_ID_OLD: Integer read FCRE_05_ID_OLD write FCRE_05_ID_OLD;
    const CRE_05_ID_OLD_Name = 'CRE_05_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_05_01_ID_OLD', ftInteger)]
    [Dictionary('CRE_05_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_05_01_ID_OLD: Integer read FCRE_05_01_ID_OLD write FCRE_05_01_ID_OLD;
    const CRE_05_01_ID_OLD_Name = 'CRE_05_01_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCRE_00_05_01)

end.
