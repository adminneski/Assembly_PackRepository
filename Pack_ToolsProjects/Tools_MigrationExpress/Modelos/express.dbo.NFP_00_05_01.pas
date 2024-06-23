unit express.dbo.NFP_00_05_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('NFP_00_05_01', '')]
  [PrimaryKey('NFP_05_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFP_05_01_ID')]
  TDtoNFP_00_05_01 = class
  private
    { Private declarations } 
    FNFP_05_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFP_ID: Integer;
    FNFP_05_ID: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FNFP_VALORRATEIO: Double;
    FNFP_PERCENTUALRATEIO: Double;
    FNFP_DATAALTERACAO: TDateTime;
    FNFP_05_01_ID_OLD: Integer;
    FNFP_05_ID_OLD: Integer;
    FNFP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'NFP_00_05_01';
     const PrimaryKey = 'NFP_05_01_ID';
     const Sequence   = 'SEQ_NFP_05_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_05_01_ID', ftInteger)]
    [Dictionary('NFP_05_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_05_01_ID: Integer read FNFP_05_01_ID write FNFP_05_01_ID;
    const NFP_05_01_ID_Name = 'NFP_05_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_05_ID', ftInteger)]
    [Dictionary('NFP_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_05_ID: Integer read FNFP_05_ID write FNFP_05_ID;
    const NFP_05_ID_Name = 'NFP_05_ID';

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
    [Column('NFP_VALORRATEIO', ftBCD)]
    [Dictionary('NFP_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORRATEIO: Double read FNFP_VALORRATEIO write FNFP_VALORRATEIO;
    const NFP_VALORRATEIO_Name = 'NFP_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('NFP_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALRATEIO: Double read FNFP_PERCENTUALRATEIO write FNFP_PERCENTUALRATEIO;
    const NFP_PERCENTUALRATEIO_Name = 'NFP_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAALTERACAO: TDateTime read FNFP_DATAALTERACAO write FNFP_DATAALTERACAO;
    const NFP_DATAALTERACAO_Name = 'NFP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFP_05_01_ID_OLD', ftInteger)]
    [Dictionary('NFP_05_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_05_01_ID_OLD: Integer read FNFP_05_01_ID_OLD write FNFP_05_01_ID_OLD;
    const NFP_05_01_ID_OLD_Name = 'NFP_05_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFP_05_ID_OLD', ftInteger)]
    [Dictionary('NFP_05_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_05_ID_OLD: Integer read FNFP_05_ID_OLD write FNFP_05_ID_OLD;
    const NFP_05_ID_OLD_Name = 'NFP_05_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFP_ID_OLD', ftInteger)]
    [Dictionary('NFP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID_OLD: Integer read FNFP_ID_OLD write FNFP_ID_OLD;
    const NFP_ID_OLD_Name = 'NFP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_00_05_01)

end.
