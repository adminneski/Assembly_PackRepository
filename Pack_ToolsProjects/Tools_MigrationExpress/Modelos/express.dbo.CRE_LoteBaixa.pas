unit express.dbo.CRE_LOTEBAIXA;

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
  [Table('CRE_LoteBaixa', '')]
  TDtoCRE_LoteBaixa = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
    FPES_CODIGO: Integer;
    FCRE_DESATIVADO: String;
    FCRE_SIGLATIPODOCUMENTO: String;
    FCRE_TIPODOCUMENTO: String;
    FCRE_PRORROGACOES: Integer;
    FCRE_STATUS: String;
    FCRE_TOTALVALOR: Double;
    FCRE_NOTAFISCAL: String;
    FCRE_NUMERODOCTO: String;
    FCRE_NOSSONUMERO: String;
    FCRE_DIGITONOSSONUMERO: String;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_DATAVENCTOORIGINAL: TDateTime;
    FCRE_DATABAIXA: TDateTime;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_COMPETENCIA: String;
    FCRE_PERCENTUALCOMISSAO: Double;
    FCRE_DC: String;
    FCRE_PLANOCONTARATEIO: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_PERCENTUALDESCTO: Double;
    FCRE_DATADESCTO: TDateTime;
    FCRE_VALORDESCTO: Double;
    FCRE_PERCENTUALMULTA: Double;
    FCRE_DATAMULTA: TDateTime;
    FCRE_VALORMULTA: Double;
    FCRE_TOTALVALORBAIXA: Double;
    FCRE_PERCENTUALMORADIARIA: Double;
    FCRE_VALORMORADIARIA: Double;
    FBCO_CODIGO: Integer;
    FCRE_AGENCIA: String;
    FCRE_CONTA: String;
    FCRE_NUMEROCHEQUE: String;
    FCRE_EMITENTE: String;
    FCRE_PERCENTUALFINANCEIRO: Double;
    FCRE_VALORFINANCEIRO: Double;
    FCRT_CODIGO: Integer;
    FCRT_DESCRICAO: String;
    FPES_NOME: String;
    FPES_CNPJ_CPF: String;
    FPES_EMAIL: String;
    FPES_EMAILCOBRANCA: String;
    FBCO_NOME: String;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FCRE_HISTORICO: String;
    FCRE_OBSERVACAO: String;
    FCGA_ID: Integer;
    FCRE_AUTORIZACAOCARTAO: String;
    FCRE_NUMEROCARTAO: String;
    FCRE_VENCTOCARTAO: String;
    FCRE_DATAULTIMOPAGTO: TDateTime;
    FCRE_INTEGRACAO: String;
    FCRE_DATANOVOCONTATO: TDateTime;
    FCRE_DIAATRASO: Integer;
    FCRE_DIAJUROS: Integer;
    FCRE_NFCUPOM: String;
    FCTA_CODIGO: Integer;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_TELEFONE_2: String;
    FPES_DDD_TELEFONE_3: String;
    FPES_DDD_CELULAR_1: String;
    FPOR_CODIGO: Integer;
    FPES_NOMEPORTADOR: String;
  public 
    { Public declarations } 
     const Table      = 'CRE_LoteBaixa';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEVENDEDOR', ftString, 100)]
    [Dictionary('PES_NOMEVENDEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEVENDEDOR: String read FPES_NOMEVENDEDOR write FPES_NOMEVENDEDOR;
    const PES_NOMEVENDEDOR_Name = 'PES_NOMEVENDEDOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DESATIVADO', ftString, 1)]
    [Dictionary('CRE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESATIVADO: String read FCRE_DESATIVADO write FCRE_DESATIVADO;
    const CRE_DESATIVADO_Name = 'CRE_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_SIGLATIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_SIGLATIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_SIGLATIPODOCUMENTO: String read FCRE_SIGLATIPODOCUMENTO write FCRE_SIGLATIPODOCUMENTO;
    const CRE_SIGLATIPODOCUMENTO_Name = 'CRE_SIGLATIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PRORROGACOES', ftInteger)]
    [Dictionary('CRE_PRORROGACOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PRORROGACOES: Integer read FCRE_PRORROGACOES write FCRE_PRORROGACOES;
    const CRE_PRORROGACOES_Name = 'CRE_PRORROGACOES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_STATUS', ftString, 1)]
    [Dictionary('CRE_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_STATUS: String read FCRE_STATUS write FCRE_STATUS;
    const CRE_STATUS_Name = 'CRE_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('CRE_NOTAFISCAL', ftString, 9)]
    [Dictionary('CRE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOTAFISCAL: String read FCRE_NOTAFISCAL write FCRE_NOTAFISCAL;
    const CRE_NOTAFISCAL_Name = 'CRE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('CRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMERODOCTO: String read FCRE_NUMERODOCTO write FCRE_NUMERODOCTO;
    const CRE_NUMERODOCTO_Name = 'CRE_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_NOSSONUMERO', ftString, 20)]
    [Dictionary('CRE_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOSSONUMERO: String read FCRE_NOSSONUMERO write FCRE_NOSSONUMERO;
    const CRE_NOSSONUMERO_Name = 'CRE_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('CRE_DIGITONOSSONUMERO', ftString, 1)]
    [Dictionary('CRE_DIGITONOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DIGITONOSSONUMERO: String read FCRE_DIGITONOSSONUMERO write FCRE_DIGITONOSSONUMERO;
    const CRE_DIGITONOSSONUMERO_Name = 'CRE_DIGITONOSSONUMERO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRE_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAEMISSAO: TDateTime read FCRE_DATAEMISSAO write FCRE_DATAEMISSAO;
    const CRE_DATAEMISSAO_Name = 'CRE_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTOORIGINAL', ftDateTime)]
    [Dictionary('CRE_DATAVENCTOORIGINAL', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTOORIGINAL: TDateTime read FCRE_DATAVENCTOORIGINAL write FCRE_DATAVENCTOORIGINAL;
    const CRE_DATAVENCTOORIGINAL_Name = 'CRE_DATAVENCTOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CRE_DATABAIXA', ftDateTime)]
    [Dictionary('CRE_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATABAIXA: TDateTime read FCRE_DATABAIXA write FCRE_DATABAIXA;
    const CRE_DATABAIXA_Name = 'CRE_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAVENCTO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAVENCTO: TDateTime read FCRE_DATAVENCTO write FCRE_DATAVENCTO;
    const CRE_DATAVENCTO_Name = 'CRE_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_COMPETENCIA', ftString, 6)]
    [Dictionary('CRE_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_COMPETENCIA: String read FCRE_COMPETENCIA write FCRE_COMPETENCIA;
    const CRE_COMPETENCIA_Name = 'CRE_COMPETENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('CRE_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALCOMISSAO: Double read FCRE_PERCENTUALCOMISSAO write FCRE_PERCENTUALCOMISSAO;
    const CRE_PERCENTUALCOMISSAO_Name = 'CRE_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DC', ftString, 1)]
    [Dictionary('CRE_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DC: String read FCRE_DC write FCRE_DC;
    const CRE_DC_Name = 'CRE_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('CRE_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PLANOCONTARATEIO: Double read FCRE_PLANOCONTARATEIO write FCRE_PLANOCONTARATEIO;
    const CRE_PLANOCONTARATEIO_Name = 'CRE_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALCARTORIO', ftBCD)]
    [Dictionary('CRE_TOTALCARTORIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIO: Double read FCRE_TOTALCARTORIO write FCRE_TOTALCARTORIO;
    const CRE_TOTALCARTORIO_Name = 'CRE_TOTALCARTORIO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CRE_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESAS: Double read FCRE_TOTALOUTRASDESPESAS write FCRE_TOTALOUTRASDESPESAS;
    const CRE_TOTALOUTRASDESPESAS_Name = 'CRE_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALDESCTO', ftBCD)]
    [Dictionary('CRE_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALDESCTO: Double read FCRE_PERCENTUALDESCTO write FCRE_PERCENTUALDESCTO;
    const CRE_PERCENTUALDESCTO_Name = 'CRE_PERCENTUALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATADESCTO', ftDateTime)]
    [Dictionary('CRE_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATADESCTO: TDateTime read FCRE_DATADESCTO write FCRE_DATADESCTO;
    const CRE_DATADESCTO_Name = 'CRE_DATADESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORDESCTO', ftBCD)]
    [Dictionary('CRE_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORDESCTO: Double read FCRE_VALORDESCTO write FCRE_VALORDESCTO;
    const CRE_VALORDESCTO_Name = 'CRE_VALORDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALMULTA', ftBCD)]
    [Dictionary('CRE_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALMULTA: Double read FCRE_PERCENTUALMULTA write FCRE_PERCENTUALMULTA;
    const CRE_PERCENTUALMULTA_Name = 'CRE_PERCENTUALMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAMULTA', ftDateTime)]
    [Dictionary('CRE_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAMULTA: TDateTime read FCRE_DATAMULTA write FCRE_DATAMULTA;
    const CRE_DATAMULTA_Name = 'CRE_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORMULTA', ftBCD)]
    [Dictionary('CRE_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORMULTA: Double read FCRE_VALORMULTA write FCRE_VALORMULTA;
    const CRE_VALORMULTA_Name = 'CRE_VALORMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXA: Double read FCRE_TOTALVALORBAIXA write FCRE_TOTALVALORBAIXA;
    const CRE_TOTALVALORBAIXA_Name = 'CRE_TOTALVALORBAIXA';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALMORADIARIA', ftBCD)]
    [Dictionary('CRE_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALMORADIARIA: Double read FCRE_PERCENTUALMORADIARIA write FCRE_PERCENTUALMORADIARIA;
    const CRE_PERCENTUALMORADIARIA_Name = 'CRE_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORMORADIARIA', ftBCD)]
    [Dictionary('CRE_VALORMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORMORADIARIA: Double read FCRE_VALORMORADIARIA write FCRE_VALORMORADIARIA;
    const CRE_VALORMORADIARIA_Name = 'CRE_VALORMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_AGENCIA', ftString, 6)]
    [Dictionary('CRE_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_AGENCIA: String read FCRE_AGENCIA write FCRE_AGENCIA;
    const CRE_AGENCIA_Name = 'CRE_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CRE_CONTA', ftString, 15)]
    [Dictionary('CRE_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_CONTA: String read FCRE_CONTA write FCRE_CONTA;
    const CRE_CONTA_Name = 'CRE_CONTA';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('CRE_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROCHEQUE: String read FCRE_NUMEROCHEQUE write FCRE_NUMEROCHEQUE;
    const CRE_NUMEROCHEQUE_Name = 'CRE_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CRE_EMITENTE', ftString, 50)]
    [Dictionary('CRE_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_EMITENTE: String read FCRE_EMITENTE write FCRE_EMITENTE;
    const CRE_EMITENTE_Name = 'CRE_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALFINANCEIRO: Double read FCRE_PERCENTUALFINANCEIRO write FCRE_PERCENTUALFINANCEIRO;
    const CRE_PERCENTUALFINANCEIRO_Name = 'CRE_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORFINANCEIRO', ftBCD)]
    [Dictionary('CRE_VALORFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORFINANCEIRO: Double read FCRE_VALORFINANCEIRO write FCRE_VALORFINANCEIRO;
    const CRE_VALORFINANCEIRO_Name = 'CRE_VALORFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRT_DESCRICAO', ftString, 30)]
    [Dictionary('CRT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRT_DESCRICAO: String read FCRT_DESCRICAO write FCRT_DESCRICAO;
    const CRT_DESCRICAO_Name = 'CRT_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILCOBRANCA', ftString, 300)]
    [Dictionary('PES_EMAILCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILCOBRANCA: String read FPES_EMAILCOBRANCA write FPES_EMAILCOBRANCA;
    const PES_EMAILCOBRANCA_Name = 'PES_EMAILCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: String read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;
    const FPG_TIPOPAGTOCOMISSAO_Name = 'FPG_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRE_HISTORICO', ftString, 5000)]
    [Dictionary('CRE_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_HISTORICO: String read FCRE_HISTORICO write FCRE_HISTORICO;
    const CRE_HISTORICO_Name = 'CRE_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CRE_OBSERVACAO', ftString, 5000)]
    [Dictionary('CRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSERVACAO: String read FCRE_OBSERVACAO write FCRE_OBSERVACAO;
    const CRE_OBSERVACAO_Name = 'CRE_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate])]
    [Column('CRE_AUTORIZACAOCARTAO', ftString, 50)]
    [Dictionary('CRE_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_AUTORIZACAOCARTAO: String read FCRE_AUTORIZACAOCARTAO write FCRE_AUTORIZACAOCARTAO;
    const CRE_AUTORIZACAOCARTAO_Name = 'CRE_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROCARTAO', ftString, 20)]
    [Dictionary('CRE_NUMEROCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROCARTAO: String read FCRE_NUMEROCARTAO write FCRE_NUMEROCARTAO;
    const CRE_NUMEROCARTAO_Name = 'CRE_NUMEROCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRE_VENCTOCARTAO', ftString, 6)]
    [Dictionary('CRE_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_VENCTOCARTAO: String read FCRE_VENCTOCARTAO write FCRE_VENCTOCARTAO;
    const CRE_VENCTOCARTAO_Name = 'CRE_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAULTIMOPAGTO', ftDateTime)]
    [Dictionary('CRE_DATAULTIMOPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAULTIMOPAGTO: TDateTime read FCRE_DATAULTIMOPAGTO write FCRE_DATAULTIMOPAGTO;
    const CRE_DATAULTIMOPAGTO_Name = 'CRE_DATAULTIMOPAGTO';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO', ftString, 50)]
    [Dictionary('CRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO: String read FCRE_INTEGRACAO write FCRE_INTEGRACAO;
    const CRE_INTEGRACAO_Name = 'CRE_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATANOVOCONTATO', ftDateTime)]
    [Dictionary('CRE_DATANOVOCONTATO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATANOVOCONTATO: TDateTime read FCRE_DATANOVOCONTATO write FCRE_DATANOVOCONTATO;
    const CRE_DATANOVOCONTATO_Name = 'CRE_DATANOVOCONTATO';

    [Restrictions([NoValidate])]
    [Column('CRE_DIAATRASO', ftInteger)]
    [Dictionary('CRE_DIAATRASO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_DIAATRASO: Integer read FCRE_DIAATRASO write FCRE_DIAATRASO;
    const CRE_DIAATRASO_Name = 'CRE_DIAATRASO';

    [Restrictions([NoValidate])]
    [Column('CRE_DIAJUROS', ftInteger)]
    [Dictionary('CRE_DIAJUROS', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_DIAJUROS: Integer read FCRE_DIAJUROS write FCRE_DIAJUROS;
    const CRE_DIAJUROS_Name = 'CRE_DIAJUROS';

    [Restrictions([NoValidate])]
    [Column('CRE_NFCUPOM', ftString, 13)]
    [Dictionary('CRE_NFCUPOM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NFCUPOM: String read FCRE_NFCUPOM write FCRE_NFCUPOM;
    const CRE_NFCUPOM_Name = 'CRE_NFCUPOM';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_2: String read FPES_DDD_TELEFONE_2 write FPES_DDD_TELEFONE_2;
    const PES_DDD_TELEFONE_2_Name = 'PES_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_3', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_3: String read FPES_DDD_TELEFONE_3 write FPES_DDD_TELEFONE_3;
    const PES_DDD_TELEFONE_3_Name = 'PES_DDD_TELEFONE_3';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('POR_CODIGO', ftInteger)]
    [Dictionary('POR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property POR_CODIGO: Integer read FPOR_CODIGO write FPOR_CODIGO;
    const POR_CODIGO_Name = 'POR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEPORTADOR', ftString, 100)]
    [Dictionary('PES_NOMEPORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEPORTADOR: String read FPES_NOMEPORTADOR write FPES_NOMEPORTADOR;
    const PES_NOMEPORTADOR_Name = 'PES_NOMEPORTADOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRE_LoteBaixa)

end.
