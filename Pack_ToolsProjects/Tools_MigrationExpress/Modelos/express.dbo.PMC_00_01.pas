unit express.dbo.PMC_00_01;

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
  [Table('PMC_00_01', '')]
  [PrimaryKey('PMC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PMC_01_ID')]
  TDtoPMC_00_01 = class
  private
    { Private declarations } 
    FPMC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPMC_ID: Integer;
    FPRO_CODIGO: Integer;
    FPMC_PRECOPROMOCAO: Double;
    FPMC_DATAALTERACAO: TDateTime;
    FPMC_01_ID_OLD: Integer;
    FPMC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PMC_00_01';
     const PrimaryKey = 'PMC_01_ID';
     const Sequence   = 'SEQ_PMC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PMC_01_ID', ftInteger)]
    [Dictionary('PMC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PMC_01_ID: Integer read FPMC_01_ID write FPMC_01_ID;
    const PMC_01_ID_Name = 'PMC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PMC_ID', ftInteger)]
    [Dictionary('PMC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PMC_ID: Integer read FPMC_ID write FPMC_ID;
    const PMC_ID_Name = 'PMC_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PMC_PRECOPROMOCAO', ftBCD, 4456531, 2)]
    [Dictionary('PMC_PRECOPROMOCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PMC_PRECOPROMOCAO: Double read FPMC_PRECOPROMOCAO write FPMC_PRECOPROMOCAO;
    const PMC_PRECOPROMOCAO_Name = 'PMC_PRECOPROMOCAO';

    [Restrictions([NoValidate])]
    [Column('PMC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PMC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PMC_DATAALTERACAO: TDateTime read FPMC_DATAALTERACAO write FPMC_DATAALTERACAO;
    const PMC_DATAALTERACAO_Name = 'PMC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PMC_01_ID_OLD', ftInteger)]
    [Dictionary('PMC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PMC_01_ID_OLD: Integer read FPMC_01_ID_OLD write FPMC_01_ID_OLD;
    const PMC_01_ID_OLD_Name = 'PMC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PMC_ID_OLD', ftInteger)]
    [Dictionary('PMC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PMC_ID_OLD: Integer read FPMC_ID_OLD write FPMC_ID_OLD;
    const PMC_ID_OLD_Name = 'PMC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPMC_00_01)

end.
