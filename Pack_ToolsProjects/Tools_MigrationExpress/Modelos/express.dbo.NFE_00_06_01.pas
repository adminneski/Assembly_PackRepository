unit express.dbo.NFE_00_06_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.nfe_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('NFE_00_06_01', '')]
  [PrimaryKey('NFE_06_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFE_06_01_ID')]
  TDtoNFE_00_06_01 = class
  private
    { Private declarations } 
    FNFE_06_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_ID: Integer;
    FNFE_06_ID: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FNFE_VALORRATEIO: Double;
    FNFE_PERCENTUALRATEIO: Double;
    FNFE_DATAALTERACAO: TDateTime;
    FNFE_06_01_ID_OLD: Integer;
    FNFE_06_ID_OLD: Integer;
    FNFE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'NFE_00_06_01';
    const PrimaryKey = 'NFE_06_01_ID';
    const Sequence   = 'SEQ_NFE_06_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_06_01_ID', ftInteger)]
    [Dictionary('NFE_06_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_06_01_ID: Integer read FNFE_06_01_ID write FNFE_06_01_ID;
    const NFE_06_01_ID_Name = 'NFE_06_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [ForeignKey('NFE_00_06_01_fk', 'NFE_ID', 'NFE_00', 'NFE_ID', SetNull, SetNull)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_06_ID', ftInteger)]
    [Dictionary('NFE_06_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_06_ID: Integer read FNFE_06_ID write FNFE_06_ID;
    const NFE_06_ID_Name = 'NFE_06_ID';

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
    [Column('NFE_VALORRATEIO', ftBCD)]
    [Dictionary('NFE_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORRATEIO: Double read FNFE_VALORRATEIO write FNFE_VALORRATEIO;
    const NFE_VALORRATEIO_Name = 'NFE_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('NFE_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALRATEIO: Double read FNFE_PERCENTUALRATEIO write FNFE_PERCENTUALRATEIO;
    const NFE_PERCENTUALRATEIO_Name = 'NFE_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATAALTERACAO: TDateTime read FNFE_DATAALTERACAO write FNFE_DATAALTERACAO;
    const NFE_DATAALTERACAO_Name = 'NFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_06_01_ID_OLD', ftInteger)]
    [Dictionary('NFE_06_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_06_01_ID_OLD: Integer read FNFE_06_01_ID_OLD write FNFE_06_01_ID_OLD;
    const NFE_06_01_ID_OLD_Name = 'NFE_06_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_06_ID_OLD', ftInteger)]
    [Dictionary('NFE_06_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_06_ID_OLD: Integer read FNFE_06_ID_OLD write FNFE_06_ID_OLD;
    const NFE_06_ID_OLD_Name = 'NFE_06_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_ID_OLD', ftInteger)]
    [Dictionary('NFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID_OLD: Integer read FNFE_ID_OLD write FNFE_ID_OLD;
    const NFE_ID_OLD_Name = 'NFE_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoNFE_00_06_01)

end.
