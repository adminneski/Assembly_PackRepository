unit express.dbo.PALM_V01_PMC;

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
  [Table('PALM_V01_PMC', '')]
  TDtoPALM_V01_PMC = class
  private
    { Private declarations } 
    FPMC_ID: Integer;
    FCOM_CODIGO: Integer;
    FTAB_CODIGO: Integer;
    FPMC_DATAPROMOCAOINICIAL: TDateTime;
    FPMC_DATAPROMOCAOFINAL: TDateTime;
    FPMC_PERCENTUALACRESCIMO: Double;
    FPMC_PERCENTUALDESCONTO: Double;
    FPRO_CODIGO: Integer;
    FPMC_PRECOPROMOCAO: Double;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_PMC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PMC_ID', ftInteger)]
    [Dictionary('PMC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PMC_ID: Integer read FPMC_ID write FPMC_ID;
    const PMC_ID_Name = 'PMC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PMC_DATAPROMOCAOINICIAL', ftDateTime)]
    [Dictionary('PMC_DATAPROMOCAOINICIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PMC_DATAPROMOCAOINICIAL: TDateTime read FPMC_DATAPROMOCAOINICIAL write FPMC_DATAPROMOCAOINICIAL;
    const PMC_DATAPROMOCAOINICIAL_Name = 'PMC_DATAPROMOCAOINICIAL';

    [Restrictions([NoValidate])]
    [Column('PMC_DATAPROMOCAOFINAL', ftDateTime)]
    [Dictionary('PMC_DATAPROMOCAOFINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PMC_DATAPROMOCAOFINAL: TDateTime read FPMC_DATAPROMOCAOFINAL write FPMC_DATAPROMOCAOFINAL;
    const PMC_DATAPROMOCAOFINAL_Name = 'PMC_DATAPROMOCAOFINAL';

    [Restrictions([NoValidate])]
    [Column('PMC_PERCENTUALACRESCIMO', ftBCD)]
    [Dictionary('PMC_PERCENTUALACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PMC_PERCENTUALACRESCIMO: Double read FPMC_PERCENTUALACRESCIMO write FPMC_PERCENTUALACRESCIMO;
    const PMC_PERCENTUALACRESCIMO_Name = 'PMC_PERCENTUALACRESCIMO';

    [Restrictions([NoValidate])]
    [Column('PMC_PERCENTUALDESCONTO', ftBCD, 48, 2)]
    [Dictionary('PMC_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PMC_PERCENTUALDESCONTO: Double read FPMC_PERCENTUALDESCONTO write FPMC_PERCENTUALDESCONTO;
    const PMC_PERCENTUALDESCONTO_Name = 'PMC_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PMC_PRECOPROMOCAO', ftBCD, 10, 2)]
    [Dictionary('PMC_PRECOPROMOCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PMC_PRECOPROMOCAO: Double read FPMC_PRECOPROMOCAO write FPMC_PRECOPROMOCAO;
    const PMC_PRECOPROMOCAO_Name = 'PMC_PRECOPROMOCAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_PMC)

end.
