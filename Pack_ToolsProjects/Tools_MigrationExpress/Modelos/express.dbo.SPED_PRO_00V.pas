unit express.dbo.SPED_PRO_00V;

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
  [Table('SPED_PRO_00V', '')]
  TDtoSPED_PRO_00V = class
  private
    { Private declarations } 
    FPRO_TIPO: String;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FNCM_CODIGO: Integer;
    FGRP_CODIGO: Integer;
    FSGM_CODIGO: String;
    FSGM_DESCRICAO: String;
    FPRO_EMBALAGEM: String;
    FPRO_PARAMETROS: String;
    FPRO_PRECOVENDAPDV: Double;
    FPRO_ESTOQUE: Double;
    FPRO_DATAATUALIZACAOESTOQUE: TDateTime;
    FPRO_DESATIVADO: String;
    FPRO_PRODUTOFINAL: String;
    FPRO_DATAALTERACAO: TDateTime;
    FGRP_GRUPO: String;
    FGRP_DESCRICAO: String;
    FGRP_IMAGEM: Integer;
    FCLF_CODIGO: String;
    FCFOP_CODIGO: String;
    FAQT_CODIGO: Integer;
    FAQT_ALIQUOTAECF: String;
    FAQT_ALIQUOTA: Double;
    FPRO_CODIGOBARRA01: String;
    FPRO_CODIGOBARRA02: String;
    FPRO_PERCENTUALPIS: Double;
    FPRO_PERCENTUALCOFINS: Double;
    FLEE_CODIGO: Integer;
    FPRO_PERCENTUALCOMISSAO: Double;
    FCST_CODIGO: String;
    FLEF_CODIGO: Integer;
    FPRO_PRECOCUSTO: Double;
    FCSTPC_CODIGO: String;
    FPRO_CEST: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_PRO_00V';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_TIPO', ftString, 3)]
    [Dictionary('PRO_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_TIPO: String read FPRO_TIPO write FPRO_TIPO;
    const PRO_TIPO_Name = 'PRO_TIPO';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESCRICAO', ftString, 401)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_DESCRICAO', ftString, 30)]
    [Dictionary('SGM_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_DESCRICAO: String read FSGM_DESCRICAO write FSGM_DESCRICAO;
    const SGM_DESCRICAO_Name = 'SGM_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_PARAMETROS', ftString, 10)]
    [Dictionary('PRO_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PARAMETROS: String read FPRO_PARAMETROS write FPRO_PARAMETROS;
    const PRO_PARAMETROS_Name = 'PRO_PARAMETROS';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOVENDAPDV', ftBCD, 10, 4)]
    [Dictionary('PRO_PRECOVENDAPDV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOVENDAPDV: Double read FPRO_PRECOVENDAPDV write FPRO_PRECOVENDAPDV;
    const PRO_PRECOVENDAPDV_Name = 'PRO_PRECOVENDAPDV';

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUE', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUE: Double read FPRO_ESTOQUE write FPRO_ESTOQUE;
    const PRO_ESTOQUE_Name = 'PRO_ESTOQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATAATUALIZACAOESTOQUE', ftDateTime)]
    [Dictionary('PRO_DATAATUALIZACAOESTOQUE', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRO_DATAATUALIZACAOESTOQUE: TDateTime read FPRO_DATAATUALIZACAOESTOQUE write FPRO_DATAATUALIZACAOESTOQUE;
    const PRO_DATAATUALIZACAOESTOQUE_Name = 'PRO_DATAATUALIZACAOESTOQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESATIVADO', ftString, 1)]
    [Dictionary('PRO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESATIVADO: String read FPRO_DESATIVADO write FPRO_DESATIVADO;
    const PRO_DESATIVADO_Name = 'PRO_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOFINAL', ftString, 1)]
    [Dictionary('PRO_PRODUTOFINAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOFINAL: String read FPRO_PRODUTOFINAL write FPRO_PRODUTOFINAL;
    const PRO_PRODUTOFINAL_Name = 'PRO_PRODUTOFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('GRP_GRUPO', ftString, 4)]
    [Dictionary('GRP_GRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_GRUPO: String read FGRP_GRUPO write FGRP_GRUPO;
    const GRP_GRUPO_Name = 'GRP_GRUPO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('GRP_IMAGEM', ftInteger)]
    [Dictionary('GRP_IMAGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_IMAGEM: Integer read FGRP_IMAGEM write FGRP_IMAGEM;
    const GRP_IMAGEM_Name = 'GRP_IMAGEM';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO', ftInteger)]
    [Dictionary('AQT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO: Integer read FAQT_CODIGO write FAQT_CODIGO;
    const AQT_CODIGO_Name = 'AQT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTAECF', ftString, 5)]
    [Dictionary('AQT_ALIQUOTAECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_ALIQUOTAECF: String read FAQT_ALIQUOTAECF write FAQT_ALIQUOTAECF;
    const AQT_ALIQUOTAECF_Name = 'AQT_ALIQUOTAECF';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTA', ftBCD)]
    [Dictionary('AQT_ALIQUOTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AQT_ALIQUOTA: Double read FAQT_ALIQUOTA write FAQT_ALIQUOTA;
    const AQT_ALIQUOTA_Name = 'AQT_ALIQUOTA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA01', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA01: String read FPRO_CODIGOBARRA01 write FPRO_CODIGOBARRA01;
    const PRO_CODIGOBARRA01_Name = 'PRO_CODIGOBARRA01';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA02', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA02', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA02: String read FPRO_CODIGOBARRA02 write FPRO_CODIGOBARRA02;
    const PRO_CODIGOBARRA02_Name = 'PRO_CODIGOBARRA02';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PERCENTUALPIS', ftBCD)]
    [Dictionary('PRO_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALPIS: Double read FPRO_PERCENTUALPIS write FPRO_PERCENTUALPIS;
    const PRO_PERCENTUALPIS_Name = 'PRO_PERCENTUALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PERCENTUALCOFINS', ftBCD)]
    [Dictionary('PRO_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALCOFINS: Double read FPRO_PERCENTUALCOFINS write FPRO_PERCENTUALCOFINS;
    const PRO_PERCENTUALCOFINS_Name = 'PRO_PERCENTUALCOFINS';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PRO_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALCOMISSAO: Double read FPRO_PERCENTUALCOMISSAO write FPRO_PERCENTUALCOMISSAO;
    const PRO_PERCENTUALCOMISSAO_Name = 'PRO_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PRO_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOCUSTO: Double read FPRO_PRECOCUSTO write FPRO_PRECOCUSTO;
    const PRO_PRECOCUSTO_Name = 'PRO_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CEST', ftString, 7)]
    [Dictionary('PRO_CEST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CEST: String read FPRO_CEST write FPRO_CEST;
    const PRO_CEST_Name = 'PRO_CEST';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_PRO_00V)

end.
