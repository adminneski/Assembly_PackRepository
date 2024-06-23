unit express.dbo.REL_V01_CRE;

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
  [Table('REL_V01_CRE', '')]
  TDtoREL_V01_CRE = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCRE_NOTAFISCAL: String;
    FCRE_NOTAFISCALSERVICO: String;
    FCRE_NUMERODOCTO: String;
    FCRE_NUMEROFATURA: String;
    FCRE_OBSERVACAO: String;
    FCRE_ORDEMPARCIAL: Integer;
    FCGA_ID: Integer;
    FCRE_DC: String;
    FCRE_STATUS: String;
    FCOM_CODIGO: Integer;
    FCTA_CODIGOBAIXA: Integer;
    FPES_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
    FPES_PERCENTUALCOMISSAO: Double;
    FPOR_CODIGO: Integer;
    FPES_NOMEPORTADOR: String;
    FPES_FONEPORTADOR: String;
    FPES_CELULARPORTADOR: String;
    FPES_CNPJ_CPFPORTADOR: String;
    FCRE_TIPODOCUMENTO: String;
    FCRE_HISTORICO: String;
    FCRE_INTEGRACAO: String;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_COMPETENCIA: String;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_DATABAIXA: TDateTime;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_DATALANCAMENTO: TDateTime;
    FCRE_DATAVENCTOORIGINAL: TDateTime;
    FCRE_TOTALIPI: Double;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALFRETE: Double;
    FCRE_PERCENTUALCOMISSAO: Double;
    FCRE_TOTALVALORBAIXA: Double;
    FCRE_PRORROGACOES: Integer;
    FCRE_DESATIVADO: String;
    FCTA_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCRE_VALORDESCTO: Double;
    FCRE_VALORMULTA: Double;
    FCRE_DATADESCTO: TDateTime;
    FCRE_DATAMULTA: TDateTime;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_TOTALMULTA: Double;
    FCRE_NUMEROCHEQUE: String;
    FCRE_EMITENTE: String;
    FBCO_CODIGOCHE: Integer;
    FBCO_NOMECHE: String;
    FCRT_CODIGO: Integer;
    FCRE_NUMEROCARTAO: String;
    FCRE_AUTORIZACAOCARTAO: String;
    FCRT_DESCRICAO: String;
    FPES_NOME: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_TELEFONE_2: String;
    FPES_DDD_TELEFONE_3: String;
    FPES_DDD_CELULAR_1: String;
    FCID_IBGE: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FBCO_NOME: String;
    FCRE_TIPOBAIXA: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_TIPOPESSOA: String;
    FPES_BAIRRO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FCEP_CODIGO: String;
    FUSERS_LOGIN: String;
    FCRE_TOTALVALORORIGINAL: Double;
    FCRE_DESCONTADO: String;
    FCRE_DATADESCONTADO: TDateTime;
    FCRE_SIGLATIPODOCUMENTO: String;
    FCRE_NFCUPOM: String;
    FCRE_TOTALFINANCEIRO: Double;
    FFIL_TAXADEJUROSAOMES: Double;
    FFIL_DIASATRASOPERMITIDO: Integer;
    FCRE_TOTALNOTAFISCAL: Double;
    FCRE_DIAATRASO: Integer;
    FCRE_DIAJUROS: Integer;
    FCRE_DIAJUROSPAGO: Integer;
    FPES_EMAIL: String;
    FCRE_NOSSONUMERO: String;
    FCRE_DIGITONOSSONUMERO: String;
    FCRE_DATAULTIMOPAGTO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CRE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('CRE_NOTAFISCAL', ftString, 9)]
    [Dictionary('CRE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOTAFISCAL: String read FCRE_NOTAFISCAL write FCRE_NOTAFISCAL;
    const CRE_NOTAFISCAL_Name = 'CRE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CRE_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('CRE_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOTAFISCALSERVICO: String read FCRE_NOTAFISCALSERVICO write FCRE_NOTAFISCALSERVICO;
    const CRE_NOTAFISCALSERVICO_Name = 'CRE_NOTAFISCALSERVICO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('CRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMERODOCTO: String read FCRE_NUMERODOCTO write FCRE_NUMERODOCTO;
    const CRE_NUMERODOCTO_Name = 'CRE_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROFATURA', ftString, 20)]
    [Dictionary('CRE_NUMEROFATURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROFATURA: String read FCRE_NUMEROFATURA write FCRE_NUMEROFATURA;
    const CRE_NUMEROFATURA_Name = 'CRE_NUMEROFATURA';

    [Restrictions([NoValidate])]
    [Column('CRE_OBSERVACAO', ftString, 5000)]
    [Dictionary('CRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSERVACAO: String read FCRE_OBSERVACAO write FCRE_OBSERVACAO;
    const CRE_OBSERVACAO_Name = 'CRE_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ORDEMPARCIAL', ftInteger)]
    [Dictionary('CRE_ORDEMPARCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ORDEMPARCIAL: Integer read FCRE_ORDEMPARCIAL write FCRE_ORDEMPARCIAL;
    const CRE_ORDEMPARCIAL_Name = 'CRE_ORDEMPARCIAL';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DC', ftString, 1)]
    [Dictionary('CRE_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DC: String read FCRE_DC write FCRE_DC;
    const CRE_DC_Name = 'CRE_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_STATUS', ftString, 1)]
    [Dictionary('CRE_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_STATUS: String read FCRE_STATUS write FCRE_STATUS;
    const CRE_STATUS_Name = 'CRE_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

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
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

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

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PES_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALCOMISSAO: Double read FPES_PERCENTUALCOMISSAO write FPES_PERCENTUALCOMISSAO;
    const PES_PERCENTUALCOMISSAO_Name = 'PES_PERCENTUALCOMISSAO';

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

    [Restrictions([NoValidate])]
    [Column('PES_FONEPORTADOR', ftString, 11)]
    [Dictionary('PES_FONEPORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FONEPORTADOR: String read FPES_FONEPORTADOR write FPES_FONEPORTADOR;
    const PES_FONEPORTADOR_Name = 'PES_FONEPORTADOR';

    [Restrictions([NoValidate])]
    [Column('PES_CELULARPORTADOR', ftString, 11)]
    [Dictionary('PES_CELULARPORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CELULARPORTADOR: String read FPES_CELULARPORTADOR write FPES_CELULARPORTADOR;
    const PES_CELULARPORTADOR_Name = 'PES_CELULARPORTADOR';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPFPORTADOR', ftString, 14)]
    [Dictionary('PES_CNPJ_CPFPORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPFPORTADOR: String read FPES_CNPJ_CPFPORTADOR write FPES_CNPJ_CPFPORTADOR;
    const PES_CNPJ_CPFPORTADOR_Name = 'PES_CNPJ_CPFPORTADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CRE_HISTORICO', ftString, 5000)]
    [Dictionary('CRE_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_HISTORICO: String read FCRE_HISTORICO write FCRE_HISTORICO;
    const CRE_HISTORICO_Name = 'CRE_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO', ftString, 50)]
    [Dictionary('CRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO: String read FCRE_INTEGRACAO write FCRE_INTEGRACAO;
    const CRE_INTEGRACAO_Name = 'CRE_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRE_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAEMISSAO: TDateTime read FCRE_DATAEMISSAO write FCRE_DATAEMISSAO;
    const CRE_DATAEMISSAO_Name = 'CRE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRE_COMPETENCIA', ftString, 6)]
    [Dictionary('CRE_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_COMPETENCIA: String read FCRE_COMPETENCIA write FCRE_COMPETENCIA;
    const CRE_COMPETENCIA_Name = 'CRE_COMPETENCIA';

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

    [Restrictions([NoValidate])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CRE_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATALANCAMENTO: TDateTime read FCRE_DATALANCAMENTO write FCRE_DATALANCAMENTO;
    const CRE_DATALANCAMENTO_Name = 'CRE_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTOORIGINAL', ftDateTime)]
    [Dictionary('CRE_DATAVENCTOORIGINAL', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTOORIGINAL: TDateTime read FCRE_DATAVENCTOORIGINAL write FCRE_DATAVENCTOORIGINAL;
    const CRE_DATAVENCTOORIGINAL_Name = 'CRE_DATAVENCTOORIGINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALIPI', ftBCD)]
    [Dictionary('CRE_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALIPI: Double read FCRE_TOTALIPI write FCRE_TOTALIPI;
    const CRE_TOTALIPI_Name = 'CRE_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFRETE', ftBCD)]
    [Dictionary('CRE_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFRETE: Double read FCRE_TOTALFRETE write FCRE_TOTALFRETE;
    const CRE_TOTALFRETE_Name = 'CRE_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALCOMISSAO', ftBCD, 10, 2)]
    [Dictionary('CRE_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALCOMISSAO: Double read FCRE_PERCENTUALCOMISSAO write FCRE_PERCENTUALCOMISSAO;
    const CRE_PERCENTUALCOMISSAO_Name = 'CRE_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXA: Double read FCRE_TOTALVALORBAIXA write FCRE_TOTALVALORBAIXA;
    const CRE_TOTALVALORBAIXA_Name = 'CRE_TOTALVALORBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PRORROGACOES', ftInteger)]
    [Dictionary('CRE_PRORROGACOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PRORROGACOES: Integer read FCRE_PRORROGACOES write FCRE_PRORROGACOES;
    const CRE_PRORROGACOES_Name = 'CRE_PRORROGACOES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DESATIVADO', ftString, 1)]
    [Dictionary('CRE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESATIVADO: String read FCRE_DESATIVADO write FCRE_DESATIVADO;
    const CRE_DESATIVADO_Name = 'CRE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORDESCTO', ftBCD)]
    [Dictionary('CRE_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORDESCTO: Double read FCRE_VALORDESCTO write FCRE_VALORDESCTO;
    const CRE_VALORDESCTO_Name = 'CRE_VALORDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORMULTA', ftBCD, 48, 2)]
    [Dictionary('CRE_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORMULTA: Double read FCRE_VALORMULTA write FCRE_VALORMULTA;
    const CRE_VALORMULTA_Name = 'CRE_VALORMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATADESCTO', ftDateTime)]
    [Dictionary('CRE_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATADESCTO: TDateTime read FCRE_DATADESCTO write FCRE_DATADESCTO;
    const CRE_DATADESCTO_Name = 'CRE_DATADESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAMULTA', ftDateTime)]
    [Dictionary('CRE_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAMULTA: TDateTime read FCRE_DATAMULTA write FCRE_DATAMULTA;
    const CRE_DATAMULTA_Name = 'CRE_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALJUROS', ftBCD, 48, 2)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALDESCTO', ftBCD)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALMULTA', ftBCD)]
    [Dictionary('CRE_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTA: Double read FCRE_TOTALMULTA write FCRE_TOTALMULTA;
    const CRE_TOTALMULTA_Name = 'CRE_TOTALMULTA';

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
    [Column('BCO_CODIGOCHE', ftInteger)]
    [Dictionary('BCO_CODIGOCHE', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGOCHE: Integer read FBCO_CODIGOCHE write FBCO_CODIGOCHE;
    const BCO_CODIGOCHE_Name = 'BCO_CODIGOCHE';

    [Restrictions([NoValidate])]
    [Column('BCO_NOMECHE', ftString, 50)]
    [Dictionary('BCO_NOMECHE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOMECHE: String read FBCO_NOMECHE write FBCO_NOMECHE;
    const BCO_NOMECHE_Name = 'BCO_NOMECHE';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROCARTAO', ftString, 20)]
    [Dictionary('CRE_NUMEROCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROCARTAO: String read FCRE_NUMEROCARTAO write FCRE_NUMEROCARTAO;
    const CRE_NUMEROCARTAO_Name = 'CRE_NUMEROCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRE_AUTORIZACAOCARTAO', ftString, 50)]
    [Dictionary('CRE_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_AUTORIZACAOCARTAO: String read FCRE_AUTORIZACAOCARTAO write FCRE_AUTORIZACAOCARTAO;
    const CRE_AUTORIZACAOCARTAO_Name = 'CRE_AUTORIZACAOCARTAO';

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
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_DESCRICAO', ftString, 30)]
    [Dictionary('ROT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_DESCRICAO: String read FROT_DESCRICAO write FROT_DESCRICAO;
    const ROT_DESCRICAO_Name = 'ROT_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('CRE_TIPOBAIXA', ftString, 1)]
    [Dictionary('CRE_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPOBAIXA: String read FCRE_TIPOBAIXA write FCRE_TIPOBAIXA;
    const CRE_TIPOBAIXA_Name = 'CRE_TIPOBAIXA';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO', ftString, 100)]
    [Dictionary('PES_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO: String read FPES_ENDERECO write FPES_ENDERECO;
    const PES_ENDERECO_Name = 'PES_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO: String read FPES_NUMEROENDERECO write FPES_NUMEROENDERECO;
    const PES_NUMEROENDERECO_Name = 'PES_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALVALORORIGINAL', ftBCD)]
    [Dictionary('CRE_TOTALVALORORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORORIGINAL: Double read FCRE_TOTALVALORORIGINAL write FCRE_TOTALVALORORIGINAL;
    const CRE_TOTALVALORORIGINAL_Name = 'CRE_TOTALVALORORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CRE_DESCONTADO', ftString, 1)]
    [Dictionary('CRE_DESCONTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESCONTADO: String read FCRE_DESCONTADO write FCRE_DESCONTADO;
    const CRE_DESCONTADO_Name = 'CRE_DESCONTADO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATADESCONTADO', ftDateTime)]
    [Dictionary('CRE_DATADESCONTADO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATADESCONTADO: TDateTime read FCRE_DATADESCONTADO write FCRE_DATADESCONTADO;
    const CRE_DATADESCONTADO_Name = 'CRE_DATADESCONTADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_SIGLATIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_SIGLATIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_SIGLATIPODOCUMENTO: String read FCRE_SIGLATIPODOCUMENTO write FCRE_SIGLATIPODOCUMENTO;
    const CRE_SIGLATIPODOCUMENTO_Name = 'CRE_SIGLATIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CRE_NFCUPOM', ftString, 13)]
    [Dictionary('CRE_NFCUPOM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NFCUPOM: String read FCRE_NFCUPOM write FCRE_NFCUPOM;
    const CRE_NFCUPOM_Name = 'CRE_NFCUPOM';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_TOTALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFINANCEIRO: Double read FCRE_TOTALFINANCEIRO write FCRE_TOTALFINANCEIRO;
    const CRE_TOTALFINANCEIRO_Name = 'CRE_TOTALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('FIL_TAXADEJUROSAOMES', ftBCD)]
    [Dictionary('FIL_TAXADEJUROSAOMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FIL_TAXADEJUROSAOMES: Double read FFIL_TAXADEJUROSAOMES write FFIL_TAXADEJUROSAOMES;
    const FIL_TAXADEJUROSAOMES_Name = 'FIL_TAXADEJUROSAOMES';

    [Restrictions([NoValidate])]
    [Column('FIL_DIASATRASOPERMITIDO', ftInteger)]
    [Dictionary('FIL_DIASATRASOPERMITIDO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FIL_DIASATRASOPERMITIDO: Integer read FFIL_DIASATRASOPERMITIDO write FFIL_DIASATRASOPERMITIDO;
    const FIL_DIASATRASOPERMITIDO_Name = 'FIL_DIASATRASOPERMITIDO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CRE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALNOTAFISCAL: Double read FCRE_TOTALNOTAFISCAL write FCRE_TOTALNOTAFISCAL;
    const CRE_TOTALNOTAFISCAL_Name = 'CRE_TOTALNOTAFISCAL';

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
    [Column('CRE_DIAJUROSPAGO', ftInteger)]
    [Dictionary('CRE_DIAJUROSPAGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_DIAJUROSPAGO: Integer read FCRE_DIAJUROSPAGO write FCRE_DIAJUROSPAGO;
    const CRE_DIAJUROSPAGO_Name = 'CRE_DIAJUROSPAGO';

    [Restrictions([NoValidate])]
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

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
    [Column('CRE_DATAULTIMOPAGTO', ftDateTime)]
    [Dictionary('CRE_DATAULTIMOPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAULTIMOPAGTO: TDateTime read FCRE_DATAULTIMOPAGTO write FCRE_DATAULTIMOPAGTO;
    const CRE_DATAULTIMOPAGTO_Name = 'CRE_DATAULTIMOPAGTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_CRE)

end.
