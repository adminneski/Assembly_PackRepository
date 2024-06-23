unit express.dbo.CRE_LOTEESTORNO;

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
  [Table('CRE_LoteEstorno', '')]
  TDtoCRE_LoteEstorno = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FCOM_RAZAO: String;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
    FPES_CODIGO: Integer;
    FCRE_DESATIVADO: String;
    FCRE_TIPODOCUMENTO: String;
    FCRE_PRORROGACOES: Integer;
    FCRE_STATUS: String;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALVALORBAIXA: Double;
    FCRE_NOTAFISCAL: String;
    FCRE_NUMERODOCTO: String;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_DATABAIXA: TDateTime;
    FCRE_PERCENTUALCOMISSAO: Double;
    FCRE_DC: String;
    FCTA_CODIGOBAIXA: Integer;
    FCRE_ORDEMPARCIAL: Integer;
    FCRE_INTEGRACAO: String;
    FCRE_PLANOCONTARATEIO: Double;
    FCRE_TOTALVALORORIGINAL: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALMULTA: Double;
    FCRE_TIPOBAIXA: String;
    FBCO_CODIGO: Integer;
    FCRE_AGENCIA: String;
    FCRE_CONTA: String;
    FCRE_NUMEROCHEQUE: String;
    FCRE_EMITENTE: String;
    FCRE_TOTALFINANCEIRO: Double;
    FCRT_CODIGO: Integer;
    FCRT_DESCRICAO: String;
    FPES_NOME: String;
    FBCO_NOME: String;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FCRE_HISTORICO: String;
    FCGA_ID: Integer;
    FCRE_AUTORIZACAOCARTAO: String;
    FCRE_NUMEROCARTAO: String;
    FCRE_VENCTOCARTAO: String;
    FCRE_DATAULTIMOPAGTO: TDateTime;
    FCTA_EMITENTE: String;
    FUSERS_LOGIN: String;
    FCRE_NOSSONUMERO: String;
    FCRE_DIGITONOSSONUMERO: String;
    FCRE_NOTAFISCALSERVICO: String;
    FCRE_DESCONTADO: String;
    FCRE_TOTALNOTAFISCAL: Double;
    FCRE_NUMEROFATURA: String;
    FCRE_PERCENTUALFINANCEIRO: Double;
    FCRE_DOCTOEMITENTE: String;
    FCRE_TOTALJUROSCHEQUE: Double;
    FCRE_OBSERVACAO: String;
    FCRE_DIAJUROSPAGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CRE_LoteEstorno';

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
    [Column('COM_RAZAO', ftString, 100)]
    [Dictionary('COM_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;
    const COM_RAZAO_Name = 'COM_RAZAO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXA: Double read FCRE_TOTALVALORBAIXA write FCRE_TOTALVALORBAIXA;
    const CRE_TOTALVALORBAIXA_Name = 'CRE_TOTALVALORBAIXA';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRE_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAEMISSAO: TDateTime read FCRE_DATAEMISSAO write FCRE_DATAEMISSAO;
    const CRE_DATAEMISSAO_Name = 'CRE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAVENCTO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAVENCTO: TDateTime read FCRE_DATAVENCTO write FCRE_DATAVENCTO;
    const CRE_DATAVENCTO_Name = 'CRE_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATABAIXA', ftDateTime)]
    [Dictionary('CRE_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATABAIXA: TDateTime read FCRE_DATABAIXA write FCRE_DATABAIXA;
    const CRE_DATABAIXA_Name = 'CRE_DATABAIXA';

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

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ORDEMPARCIAL', ftInteger)]
    [Dictionary('CRE_ORDEMPARCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ORDEMPARCIAL: Integer read FCRE_ORDEMPARCIAL write FCRE_ORDEMPARCIAL;
    const CRE_ORDEMPARCIAL_Name = 'CRE_ORDEMPARCIAL';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO', ftString, 50)]
    [Dictionary('CRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO: String read FCRE_INTEGRACAO write FCRE_INTEGRACAO;
    const CRE_INTEGRACAO_Name = 'CRE_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('CRE_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PLANOCONTARATEIO: Double read FCRE_PLANOCONTARATEIO write FCRE_PLANOCONTARATEIO;
    const CRE_PLANOCONTARATEIO_Name = 'CRE_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALVALORORIGINAL', ftBCD)]
    [Dictionary('CRE_TOTALVALORORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORORIGINAL: Double read FCRE_TOTALVALORORIGINAL write FCRE_TOTALVALORORIGINAL;
    const CRE_TOTALVALORORIGINAL_Name = 'CRE_TOTALVALORORIGINAL';

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
    [Column('CRE_TOTALDESCTO', ftBCD)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALJUROS', ftBCD)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALMULTA', ftBCD)]
    [Dictionary('CRE_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTA: Double read FCRE_TOTALMULTA write FCRE_TOTALMULTA;
    const CRE_TOTALMULTA_Name = 'CRE_TOTALMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_TIPOBAIXA', ftString, 1)]
    [Dictionary('CRE_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPOBAIXA: String read FCRE_TIPOBAIXA write FCRE_TIPOBAIXA;
    const CRE_TIPOBAIXA_Name = 'CRE_TIPOBAIXA';

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
    [Column('CRE_TOTALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_TOTALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFINANCEIRO: Double read FCRE_TOTALFINANCEIRO write FCRE_TOTALFINANCEIRO;
    const CRE_TOTALFINANCEIRO_Name = 'CRE_TOTALFINANCEIRO';

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
    [Column('CRE_HISTORICO', ftString, 5000)]
    [Dictionary('CRE_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_HISTORICO: String read FCRE_HISTORICO write FCRE_HISTORICO;
    const CRE_HISTORICO_Name = 'CRE_HISTORICO';

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
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

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

    [Restrictions([NoValidate])]
    [Column('CRE_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('CRE_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOTAFISCALSERVICO: String read FCRE_NOTAFISCALSERVICO write FCRE_NOTAFISCALSERVICO;
    const CRE_NOTAFISCALSERVICO_Name = 'CRE_NOTAFISCALSERVICO';

    [Restrictions([NoValidate])]
    [Column('CRE_DESCONTADO', ftString, 1)]
    [Dictionary('CRE_DESCONTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESCONTADO: String read FCRE_DESCONTADO write FCRE_DESCONTADO;
    const CRE_DESCONTADO_Name = 'CRE_DESCONTADO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CRE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALNOTAFISCAL: Double read FCRE_TOTALNOTAFISCAL write FCRE_TOTALNOTAFISCAL;
    const CRE_TOTALNOTAFISCAL_Name = 'CRE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROFATURA', ftString, 20)]
    [Dictionary('CRE_NUMEROFATURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROFATURA: String read FCRE_NUMEROFATURA write FCRE_NUMEROFATURA;
    const CRE_NUMEROFATURA_Name = 'CRE_NUMEROFATURA';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALFINANCEIRO: Double read FCRE_PERCENTUALFINANCEIRO write FCRE_PERCENTUALFINANCEIRO;
    const CRE_PERCENTUALFINANCEIRO_Name = 'CRE_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CRE_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('CRE_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DOCTOEMITENTE: String read FCRE_DOCTOEMITENTE write FCRE_DOCTOEMITENTE;
    const CRE_DOCTOEMITENTE_Name = 'CRE_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALJUROSCHEQUE', ftBCD)]
    [Dictionary('CRE_TOTALJUROSCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROSCHEQUE: Double read FCRE_TOTALJUROSCHEQUE write FCRE_TOTALJUROSCHEQUE;
    const CRE_TOTALJUROSCHEQUE_Name = 'CRE_TOTALJUROSCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CRE_OBSERVACAO', ftString, 5000)]
    [Dictionary('CRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSERVACAO: String read FCRE_OBSERVACAO write FCRE_OBSERVACAO;
    const CRE_OBSERVACAO_Name = 'CRE_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_DIAJUROSPAGO', ftInteger)]
    [Dictionary('CRE_DIAJUROSPAGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_DIAJUROSPAGO: Integer read FCRE_DIAJUROSPAGO write FCRE_DIAJUROSPAGO;
    const CRE_DIAJUROSPAGO_Name = 'CRE_DIAJUROSPAGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRE_LoteEstorno)

end.
