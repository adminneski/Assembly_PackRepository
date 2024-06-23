unit express.dbo.INV_FECHAMENTOESTOQUE;

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
  [Table('INV_FechamentoEstoque', '')]
  TDtoINV_FechamentoEstoque = class
  private
    { Private declarations } 
    FINV_TIPOMOVTO: String;
    FINV_SIGLA: String;
    FINV_ORDEM: Integer;
    FINV_DATA: TDateTime;
    FINV_NUMERODOCTO: String;
    FINV_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCST_CODIGO: String;
    FINV_QUANTIDADE: Double;
    FINV_VALORCUSTOCOMPRA: Double;
    FINV_VALORCUSTOINVENTARIO: Double;
    FINV_VALORCUSTOLIQUIDO: Double;
    FINV_VALORCUSTOCOMPRAMEDIO: Double;
    FINV_VALORCUSTOLIQUIDOMEDIO: Double;
    FINV_VALORCUSTOINVENTARIOMEDIO: Double;
    FINV_VALORICMS: Double;
    FINV_VALORIPI: Double;
    FINV_VALORPIS: Double;
    FINV_VALORCOFINS: Double;
    FINV_VALORICMSRNF: Double;
    FINV_VALORICMSRDUA: Double;
    FINV_VALORICMSSIMPLES: Double;
    FINV_VALORICMSFRETENF: Double;
    FINV_VALORICMSFRETECTR: Double;
  public 
    { Public declarations } 
     const Table      = 'INV_FechamentoEstoque';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_TIPOMOVTO', ftString, 44)]
    [Dictionary('INV_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_TIPOMOVTO: String read FINV_TIPOMOVTO write FINV_TIPOMOVTO;
    const INV_TIPOMOVTO_Name = 'INV_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SIGLA', ftString, 3)]
    [Dictionary('INV_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SIGLA: String read FINV_SIGLA write FINV_SIGLA;
    const INV_SIGLA_Name = 'INV_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ORDEM', ftInteger)]
    [Dictionary('INV_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ORDEM: Integer read FINV_ORDEM write FINV_ORDEM;
    const INV_ORDEM_Name = 'INV_ORDEM';

    [Restrictions([NoValidate])]
    [Column('INV_DATA', ftDateTime)]
    [Dictionary('INV_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATA: TDateTime read FINV_DATA write FINV_DATA;
    const INV_DATA_Name = 'INV_DATA';

    [Restrictions([NoValidate])]
    [Column('INV_NUMERODOCTO', ftString, 20)]
    [Dictionary('INV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_NUMERODOCTO: String read FINV_NUMERODOCTO write FINV_NUMERODOCTO;
    const INV_NUMERODOCTO_Name = 'INV_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ID', ftInteger)]
    [Dictionary('INV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ID: Integer read FINV_ID write FINV_ID;
    const INV_ID_Name = 'INV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('INV_QUANTIDADE', ftBCD)]
    [Dictionary('INV_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QUANTIDADE: Double read FINV_QUANTIDADE write FINV_QUANTIDADE;
    const INV_QUANTIDADE_Name = 'INV_QUANTIDADE';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOCOMPRA', ftBCD)]
    [Dictionary('INV_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRA: Double read FINV_VALORCUSTOCOMPRA write FINV_VALORCUSTOCOMPRA;
    const INV_VALORCUSTOCOMPRA_Name = 'INV_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOINVENTARIO', ftBCD)]
    [Dictionary('INV_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIO: Double read FINV_VALORCUSTOINVENTARIO write FINV_VALORCUSTOINVENTARIO;
    const INV_VALORCUSTOINVENTARIO_Name = 'INV_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOLIQUIDO', ftBCD)]
    [Dictionary('INV_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOLIQUIDO: Double read FINV_VALORCUSTOLIQUIDO write FINV_VALORCUSTOLIQUIDO;
    const INV_VALORCUSTOLIQUIDO_Name = 'INV_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOCOMPRAMEDIO', ftBCD)]
    [Dictionary('INV_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRAMEDIO: Double read FINV_VALORCUSTOCOMPRAMEDIO write FINV_VALORCUSTOCOMPRAMEDIO;
    const INV_VALORCUSTOCOMPRAMEDIO_Name = 'INV_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOLIQUIDOMEDIO', ftBCD)]
    [Dictionary('INV_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOLIQUIDOMEDIO: Double read FINV_VALORCUSTOLIQUIDOMEDIO write FINV_VALORCUSTOLIQUIDOMEDIO;
    const INV_VALORCUSTOLIQUIDOMEDIO_Name = 'INV_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOINVENTARIOMEDIO', ftBCD, 48, 5)]
    [Dictionary('INV_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIOMEDIO: Double read FINV_VALORCUSTOINVENTARIOMEDIO write FINV_VALORCUSTOINVENTARIOMEDIO;
    const INV_VALORCUSTOINVENTARIOMEDIO_Name = 'INV_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORICMS', ftBCD)]
    [Dictionary('INV_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMS: Double read FINV_VALORICMS write FINV_VALORICMS;
    const INV_VALORICMS_Name = 'INV_VALORICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORIPI', ftBCD)]
    [Dictionary('INV_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORIPI: Double read FINV_VALORIPI write FINV_VALORIPI;
    const INV_VALORIPI_Name = 'INV_VALORIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORPIS', ftBCD)]
    [Dictionary('INV_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORPIS: Double read FINV_VALORPIS write FINV_VALORPIS;
    const INV_VALORPIS_Name = 'INV_VALORPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCOFINS', ftBCD)]
    [Dictionary('INV_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCOFINS: Double read FINV_VALORCOFINS write FINV_VALORCOFINS;
    const INV_VALORCOFINS_Name = 'INV_VALORCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORICMSRNF', ftBCD)]
    [Dictionary('INV_VALORICMSRNF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMSRNF: Double read FINV_VALORICMSRNF write FINV_VALORICMSRNF;
    const INV_VALORICMSRNF_Name = 'INV_VALORICMSRNF';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORICMSRDUA', ftBCD, 48, 5)]
    [Dictionary('INV_VALORICMSRDUA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMSRDUA: Double read FINV_VALORICMSRDUA write FINV_VALORICMSRDUA;
    const INV_VALORICMSRDUA_Name = 'INV_VALORICMSRDUA';

    [Restrictions([NoValidate])]
    [Column('INV_VALORICMSSIMPLES', ftBCD)]
    [Dictionary('INV_VALORICMSSIMPLES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMSSIMPLES: Double read FINV_VALORICMSSIMPLES write FINV_VALORICMSSIMPLES;
    const INV_VALORICMSSIMPLES_Name = 'INV_VALORICMSSIMPLES';

    [Restrictions([NoValidate])]
    [Column('INV_VALORICMSFRETENF', ftBCD)]
    [Dictionary('INV_VALORICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMSFRETENF: Double read FINV_VALORICMSFRETENF write FINV_VALORICMSFRETENF;
    const INV_VALORICMSFRETENF_Name = 'INV_VALORICMSFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORICMSFRETECTR', ftBCD, 48, 5)]
    [Dictionary('INV_VALORICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMSFRETECTR: Double read FINV_VALORICMSFRETECTR write FINV_VALORICMSFRETECTR;
    const INV_VALORICMSFRETECTR_Name = 'INV_VALORICMSFRETECTR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoINV_FechamentoEstoque)

end.
