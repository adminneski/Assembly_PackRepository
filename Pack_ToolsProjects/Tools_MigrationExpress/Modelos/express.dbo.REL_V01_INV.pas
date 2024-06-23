unit express.dbo.REL_V01_INV;

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
  [Table('REL_V01_INV', '')]
  TDtoREL_V01_INV = class
  private
    { Private declarations } 
    FINV_ES: String;
    FINV_TIPOMOVTO: String;
    FINV_SIGLA: String;
    FINV_SIGLA2: String;
    FINV_ORDEM: Integer;
    FINV_DATA: TDateTime;
    FINV_MES: Integer;
    FINV_ANO: Integer;
    FINV_MES_ANO: String;
    FINV_SERIE: String;
    FINV_NOTAFISCAL: String;
    FINV_NUMERODOCTO: String;
    FINV_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FSGM_CODIGO: String;
    FGRP_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
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
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_INV';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ES', ftString, 1)]
    [Dictionary('INV_ES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_ES: String read FINV_ES write FINV_ES;
    const INV_ES_Name = 'INV_ES';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_TIPOMOVTO', ftString, 43)]
    [Dictionary('INV_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_TIPOMOVTO: String read FINV_TIPOMOVTO write FINV_TIPOMOVTO;
    const INV_TIPOMOVTO_Name = 'INV_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SIGLA', ftString, 3)]
    [Dictionary('INV_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SIGLA: String read FINV_SIGLA write FINV_SIGLA;
    const INV_SIGLA_Name = 'INV_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SIGLA2', ftString, 3)]
    [Dictionary('INV_SIGLA2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SIGLA2: String read FINV_SIGLA2 write FINV_SIGLA2;
    const INV_SIGLA2_Name = 'INV_SIGLA2';

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
    [Column('INV_MES', ftInteger)]
    [Dictionary('INV_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_MES: Integer read FINV_MES write FINV_MES;
    const INV_MES_Name = 'INV_MES';

    [Restrictions([NoValidate])]
    [Column('INV_ANO', ftInteger)]
    [Dictionary('INV_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ANO: Integer read FINV_ANO write FINV_ANO;
    const INV_ANO_Name = 'INV_ANO';

    [Restrictions([NoValidate])]
    [Column('INV_MES_ANO', ftString, 60)]
    [Dictionary('INV_MES_ANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_MES_ANO: String read FINV_MES_ANO write FINV_MES_ANO;
    const INV_MES_ANO_Name = 'INV_MES_ANO';

    [Restrictions([NoValidate])]
    [Column('INV_SERIE', ftString, 3)]
    [Dictionary('INV_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SERIE: String read FINV_SERIE write FINV_SERIE;
    const INV_SERIE_Name = 'INV_SERIE';

    [Restrictions([NoValidate])]
    [Column('INV_NOTAFISCAL', ftString, 15)]
    [Dictionary('INV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_NOTAFISCAL: String read FINV_NOTAFISCAL write FINV_NOTAFISCAL;
    const INV_NOTAFISCAL_Name = 'INV_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('INV_NUMERODOCTO', ftString, 30)]
    [Dictionary('INV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_NUMERODOCTO: String read FINV_NUMERODOCTO write FINV_NUMERODOCTO;
    const INV_NUMERODOCTO_Name = 'INV_NUMERODOCTO';

    [Restrictions([NoValidate])]
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
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

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
    [Column('INV_VALORCUSTOINVENTARIOMEDIO', ftBCD)]
    [Dictionary('INV_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIOMEDIO: Double read FINV_VALORCUSTOINVENTARIOMEDIO write FINV_VALORCUSTOINVENTARIOMEDIO;
    const INV_VALORCUSTOINVENTARIOMEDIO_Name = 'INV_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORICMS', ftBCD)]
    [Dictionary('INV_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMS: Double read FINV_VALORICMS write FINV_VALORICMS;
    const INV_VALORICMS_Name = 'INV_VALORICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORIPI', ftBCD, 66260064, 5)]
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
    [Column('INV_VALORICMSRDUA', ftBCD)]
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
    [Column('INV_VALORICMSFRETECTR', ftBCD)]
    [Dictionary('INV_VALORICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMSFRETECTR: Double read FINV_VALORICMSFRETECTR write FINV_VALORICMSFRETECTR;
    const INV_VALORICMSFRETECTR_Name = 'INV_VALORICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_INV)

end.
