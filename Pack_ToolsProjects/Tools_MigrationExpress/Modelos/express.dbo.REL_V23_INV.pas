unit express.dbo.REL_V23_INV;

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
  [Table('REL_V23_INV', '')]
  TDtoREL_V23_INV = class
  private
    { Private declarations } 
    FINV_ID: Integer;
    FCOM_CODIGO: Integer;
    FCOM_UF: String;
    FCFG_TIPOEMPRESA: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_PROCEDENCIA: String;
    FPRO_PRODUTOFINAL: String;
    FSGM_CODIGO: String;
    FCLF_CODIGO: String;
    FSGM_SIGLA: String;
    FGAI_CODIGO: Integer;
    FGAI_DESCRICAO: String;
    FNCM_CODIGO: Integer;
    FLEE_DESCRICAO: String;
    FINV_DATAFECHAMENTO: TDateTime;
    FINV_SALDOFECHAMENTO: Double;
    FINV_VALORPIS: Double;
    FINV_VALORCOFINS: Double;
    FINV_VALORIPI: Double;
    FINV_VALORICMS: Double;
    FINV_VALORCUSTOCOMPRA: Double;
    FINV_VALORCUSTOINVENTARIO: Double;
    FINV_VALORCUSTOCOMPRAMEDIO: Double;
    FINV_VALORCUSTOINVENTARIOMEDIO: Double;
    FINV_QTDENTRADA: Double;
    FINV_QTDSAIDA: Double;
    FINV_QTDOUTRASENTRADAS: Double;
    FINV_QTDOUTRASAIDAS: Double;
    FINV_QTDPRODUZIDAENTRADA: Double;
    FINV_QTDPRODUZIDASAIDA: Double;
    FCST_CODIGO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V23_INV';

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
    [Column('COM_UF', ftString, 2)]
    [Dictionary('COM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;
    const COM_UF_Name = 'COM_UF';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOEMPRESA', ftString, 1)]
    [Dictionary('CFG_TIPOEMPRESA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOEMPRESA: String read FCFG_TIPOEMPRESA write FCFG_TIPOEMPRESA;
    const CFG_TIPOEMPRESA_Name = 'CFG_TIPOEMPRESA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_PROCEDENCIA', ftString, 1)]
    [Dictionary('PRO_PROCEDENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PROCEDENCIA: String read FPRO_PROCEDENCIA write FPRO_PROCEDENCIA;
    const PRO_PROCEDENCIA_Name = 'PRO_PROCEDENCIA';

    [Restrictions([NoValidate])]
    [Column('PRO_PRODUTOFINAL', ftString, 1)]
    [Dictionary('PRO_PRODUTOFINAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOFINAL: String read FPRO_PRODUTOFINAL write FPRO_PRODUTOFINAL;
    const PRO_PRODUTOFINAL_Name = 'PRO_PRODUTOFINAL';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_SIGLA', ftString, 2)]
    [Dictionary('SGM_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_SIGLA: String read FSGM_SIGLA write FSGM_SIGLA;
    const SGM_SIGLA_Name = 'SGM_SIGLA';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_DESCRICAO', ftString, 30)]
    [Dictionary('GAI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_DESCRICAO: String read FGAI_DESCRICAO write FGAI_DESCRICAO;
    const GAI_DESCRICAO_Name = 'GAI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_DESCRICAO', ftString, 100)]
    [Dictionary('LEE_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESCRICAO: String read FLEE_DESCRICAO write FLEE_DESCRICAO;
    const LEE_DESCRICAO_Name = 'LEE_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('INV_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property INV_DATAFECHAMENTO: TDateTime read FINV_DATAFECHAMENTO write FINV_DATAFECHAMENTO;
    const INV_DATAFECHAMENTO_Name = 'INV_DATAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SALDOFECHAMENTO', ftBCD, 18, 4)]
    [Dictionary('INV_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_SALDOFECHAMENTO: Double read FINV_SALDOFECHAMENTO write FINV_SALDOFECHAMENTO;
    const INV_SALDOFECHAMENTO_Name = 'INV_SALDOFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORPIS', ftBCD, 18, 4)]
    [Dictionary('INV_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORPIS: Double read FINV_VALORPIS write FINV_VALORPIS;
    const INV_VALORPIS_Name = 'INV_VALORPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCOFINS', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCOFINS: Double read FINV_VALORCOFINS write FINV_VALORCOFINS;
    const INV_VALORCOFINS_Name = 'INV_VALORCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORIPI', ftBCD, 18, 4)]
    [Dictionary('INV_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORIPI: Double read FINV_VALORIPI write FINV_VALORIPI;
    const INV_VALORIPI_Name = 'INV_VALORIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORICMS', ftBCD, 18, 4)]
    [Dictionary('INV_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMS: Double read FINV_VALORICMS write FINV_VALORICMS;
    const INV_VALORICMS_Name = 'INV_VALORICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRA: Double read FINV_VALORCUSTOCOMPRA write FINV_VALORCUSTOCOMPRA;
    const INV_VALORCUSTOCOMPRA_Name = 'INV_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIO: Double read FINV_VALORCUSTOINVENTARIO write FINV_VALORCUSTOINVENTARIO;
    const INV_VALORCUSTOINVENTARIO_Name = 'INV_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRAMEDIO: Double read FINV_VALORCUSTOCOMPRAMEDIO write FINV_VALORCUSTOCOMPRAMEDIO;
    const INV_VALORCUSTOCOMPRAMEDIO_Name = 'INV_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIOMEDIO: Double read FINV_VALORCUSTOINVENTARIOMEDIO write FINV_VALORCUSTOINVENTARIOMEDIO;
    const INV_VALORCUSTOINVENTARIOMEDIO_Name = 'INV_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDENTRADA: Double read FINV_QTDENTRADA write FINV_QTDENTRADA;
    const INV_QTDENTRADA_Name = 'INV_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDSAIDA: Double read FINV_QTDSAIDA write FINV_QTDSAIDA;
    const INV_QTDSAIDA_Name = 'INV_QTDSAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDOUTRASENTRADAS', ftBCD, 18, 4)]
    [Dictionary('INV_QTDOUTRASENTRADAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDOUTRASENTRADAS: Double read FINV_QTDOUTRASENTRADAS write FINV_QTDOUTRASENTRADAS;
    const INV_QTDOUTRASENTRADAS_Name = 'INV_QTDOUTRASENTRADAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDOUTRASAIDAS', ftBCD, 18, 4)]
    [Dictionary('INV_QTDOUTRASAIDAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDOUTRASAIDAS: Double read FINV_QTDOUTRASAIDAS write FINV_QTDOUTRASAIDAS;
    const INV_QTDOUTRASAIDAS_Name = 'INV_QTDOUTRASAIDAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDPRODUZIDAENTRADA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDPRODUZIDAENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDPRODUZIDAENTRADA: Double read FINV_QTDPRODUZIDAENTRADA write FINV_QTDPRODUZIDAENTRADA;
    const INV_QTDPRODUZIDAENTRADA_Name = 'INV_QTDPRODUZIDAENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDPRODUZIDASAIDA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDPRODUZIDASAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDPRODUZIDASAIDA: Double read FINV_QTDPRODUZIDASAIDA write FINV_QTDPRODUZIDASAIDA;
    const INV_QTDPRODUZIDASAIDA_Name = 'INV_QTDPRODUZIDASAIDA';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V23_INV)

end.
