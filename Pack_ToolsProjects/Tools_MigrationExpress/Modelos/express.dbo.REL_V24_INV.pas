unit express.dbo.REL_V24_INV;

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
  [Table('REL_V24_INV', '')]
  TDtoREL_V24_INV = class
  private
    { Private declarations } 
    FINV_ID: Integer;
    FCOM_CODIGO: Integer;
    FCOM_UF: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_PROCEDENCIA: String;
    FPRO_REFERENCIAINTERNA: String;
    FCLF_CODIGO: String;
    FSGM_CODIGO: String;
    FINV_DATAFECHAMENTO: TDateTime;
    FINV_SALDOFECHAMENTO: Double;
    FINV_VALORPIS: Double;
    FINV_VALORCOFINS: Double;
    FINV_VALORIPI: Double;
    FINV_VALORICMS: Double;
    FINV_VALORCUSTOCOMPRA: Double;
    FINV_VALORCUSTOCOMPRAMEDIO: Double;
    FINV_VALORCUSTOINVENTARIOMEDIO: Double;
    FINV_QTDENTRADA: Double;
    FINV_QTDSAIDA: Double;
    FINV_QTDOUTRASENTRADAS: Double;
    FINV_QTDOUTRASAIDAS: Double;
    FINV_QTDPRODUZIDAENTRADA: Double;
    FINV_QTDPRODUZIDASAIDA: Double;
    FGRP_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FGRP_GRUPO: String;
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FSGP_SUBGRUPO: String;
    FPRO_MAIORPRECOVENDA: Double;
    FCST_CODIGO: String;
    FPRO_PRECOTABELA: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V24_INV';

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
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

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
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_GRUPO', ftString, 4)]
    [Dictionary('GRP_GRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_GRUPO: String read FGRP_GRUPO write FGRP_GRUPO;
    const GRP_GRUPO_Name = 'GRP_GRUPO';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_SUBGRUPO', ftString, 4)]
    [Dictionary('SGP_SUBGRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_SUBGRUPO: String read FSGP_SUBGRUPO write FSGP_SUBGRUPO;
    const SGP_SUBGRUPO_Name = 'SGP_SUBGRUPO';

    [Restrictions([NoValidate])]
    [Column('PRO_MAIORPRECOVENDA', ftBCD)]
    [Dictionary('PRO_MAIORPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_MAIORPRECOVENDA: Double read FPRO_MAIORPRECOVENDA write FPRO_MAIORPRECOVENDA;
    const PRO_MAIORPRECOVENDA_Name = 'PRO_MAIORPRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOTABELA', ftBCD)]
    [Dictionary('PRO_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOTABELA: Double read FPRO_PRECOTABELA write FPRO_PRECOTABELA;
    const PRO_PRECOTABELA_Name = 'PRO_PRECOTABELA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V24_INV)

end.
