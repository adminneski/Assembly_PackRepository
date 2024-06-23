unit express.dbo.PMC_00;

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
  [Table('PMC_00', '')]
  [PrimaryKey('PMC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PMC_ID')]
  TDtoPMC_00 = class
  private
    { Private declarations } 
    FPMC_ID: Integer;
    FCOM_CODIGO: Integer;
    FTAB_CODIGO: Integer;
    FPMC_DESCRICAO: String;
    FPMC_DATAPROMOCAOINICIAL: TDateTime;
    FPMC_DATAPROMOCAOFINAL: TDateTime;
    FPMC_DESATIVADO: String;
    FPMC_DATAALTERACAO: TDateTime;
    FPMC_PERCENTUALACRESCIMO: Double;
    FPMC_PERCENTUALDESCONTO: Double;
    FPMC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PMC_00';
     const PrimaryKey = 'PMC_ID';
     const Sequence   = 'SEQ_PMC_ID';

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
    [Column('PMC_DESCRICAO', ftString, 50)]
    [Dictionary('PMC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PMC_DESCRICAO: String read FPMC_DESCRICAO write FPMC_DESCRICAO;
    const PMC_DESCRICAO_Name = 'PMC_DESCRICAO';

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
    [Column('PMC_DESATIVADO', ftString, 1)]
    [Dictionary('PMC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PMC_DESATIVADO: String read FPMC_DESATIVADO write FPMC_DESATIVADO;
    const PMC_DESATIVADO_Name = 'PMC_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PMC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PMC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PMC_DATAALTERACAO: TDateTime read FPMC_DATAALTERACAO write FPMC_DATAALTERACAO;
    const PMC_DATAALTERACAO_Name = 'PMC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PMC_PERCENTUALACRESCIMO', ftBCD, 1869770784, 2)]
    [Dictionary('PMC_PERCENTUALACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PMC_PERCENTUALACRESCIMO: Double read FPMC_PERCENTUALACRESCIMO write FPMC_PERCENTUALACRESCIMO;
    const PMC_PERCENTUALACRESCIMO_Name = 'PMC_PERCENTUALACRESCIMO';

    [Restrictions([NoValidate])]
    [Column('PMC_PERCENTUALDESCONTO', ftBCD, 5177428, 2)]
    [Dictionary('PMC_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PMC_PERCENTUALDESCONTO: Double read FPMC_PERCENTUALDESCONTO write FPMC_PERCENTUALDESCONTO;
    const PMC_PERCENTUALDESCONTO_Name = 'PMC_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('PMC_ID_OLD', ftInteger)]
    [Dictionary('PMC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PMC_ID_OLD: Integer read FPMC_ID_OLD write FPMC_ID_OLD;
    const PMC_ID_OLD_Name = 'PMC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPMC_00)

end.
