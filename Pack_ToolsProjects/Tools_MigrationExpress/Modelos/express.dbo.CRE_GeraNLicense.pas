unit express.dbo.CRE_GERANLICENSE;

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
  [Table('CRE_GeraNLicense', '')]
  TDtoCRE_GeraNLicense = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_CNPJ_CPF: String;
    FCRE_DESATIVADO: String;
    FCRE_TIPODOCUMENTO: String;
    FCRE_PRORROGACOES: Integer;
    FCRE_STATUS: String;
    FCRE_TOTALVALOR: Double;
    FCRE_NOTAFISCAL: String;
    FCRE_NUMERODOCTO: String;
    FCRE_NUMEROFATURA: String;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_DATABAIXA: TDateTime;
    FCRE_COMPETENCIA: String;
    FCRE_DC: String;
    FCRE_TOTALCARTORIO: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_PERCENTUALDESCTO: Double;
    FCRE_DATADESCTO: TDateTime;
    FCRE_VALORDESCTO: Double;
    FCRE_PERCENTUALMULTA: Double;
    FCRE_DATAMULTA: TDateTime;
    FCRE_VALORMULTA: Double;
    FCRE_PERCENTUALMORADIARIA: Double;
    FCRE_VALORMORADIARIA: Double;
    FPES_NOME: String;
    FPES_DDD_TELEFONE: String;
    FPES_DDD_CELULAR: String;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FCRE_HISTORICO: String;
    FCRE_OBSERVACAO: String;
    FCGA_ID: Integer;
    FCRE_DATAULTIMOPAGTO: TDateTime;
    FCRE_INTEGRACAO: String;
    FCRE_DIAATRASO: Integer;
    FCRE_DIAJUROS: Integer;
    FCRE_NFCUPOM: String;
    FCRE_BOLETOIMPRESSO: String;
    FCRE_DATABOLETOIMPRESSO: TDateTime;
    FCRE_REMESSAGERADA: String;
    FCRE_DATAREMESSAGERADA: TDateTime;
    FCRE_EMAILENVIADO: String;
    FCRE_DATAEMAILENVIADO: TDateTime;
    FBCO_CODIGO: Integer;
    FBCO_NOME: String;
    FCTA_CODIGO: Integer;
    FCTA_EMITENTE: String;
    FCTA_MSGBOLETO: String;
    FCRE_ACEITE: String;
    FCTA_AGENCIA: String;
    FCTA_DIGITOAGENCIA: String;
    FCTA_CODCEDENTE: String;
    FCTA_PERCENTUALJUROS: Double;
    FCTA_PERCENTUALMULTABOLETO: Double;
    FCTA_CARENCIA: Integer;
    FCTA_PERCENTUALDESCONTOBOLETO: Double;
    FCTA_DIASDESCONTOBOLETO: Integer;
    FCTA_DIASPROTESTO: Integer;
    FCRE_NOSSONUMERO: String;
    FCRE_DIGITONOSSONUMERO: String;
    FCRE_OBSERVACAOBOLETO: String;
  public 
    { Public declarations } 
     const Table      = 'CRE_GeraNLicense';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

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
    [Column('CRE_NUMEROFATURA', ftString, 20)]
    [Dictionary('CRE_NUMEROFATURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROFATURA: String read FCRE_NUMEROFATURA write FCRE_NUMEROFATURA;
    const CRE_NUMEROFATURA_Name = 'CRE_NUMEROFATURA';

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

    [Restrictions([NoValidate])]
    [Column('CRE_COMPETENCIA', ftString, 6)]
    [Dictionary('CRE_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_COMPETENCIA: String read FCRE_COMPETENCIA write FCRE_COMPETENCIA;
    const CRE_COMPETENCIA_Name = 'CRE_COMPETENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DC', ftString, 1)]
    [Dictionary('CRE_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DC: String read FCRE_DC write FCRE_DC;
    const CRE_DC_Name = 'CRE_DC';

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
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE: String read FPES_DDD_TELEFONE write FPES_DDD_TELEFONE;
    const PES_DDD_TELEFONE_Name = 'PES_DDD_TELEFONE';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR: String read FPES_DDD_CELULAR write FPES_DDD_CELULAR;
    const PES_DDD_CELULAR_Name = 'PES_DDD_CELULAR';

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
    [Column('CRE_BOLETOIMPRESSO', ftString, 1)]
    [Dictionary('CRE_BOLETOIMPRESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_BOLETOIMPRESSO: String read FCRE_BOLETOIMPRESSO write FCRE_BOLETOIMPRESSO;
    const CRE_BOLETOIMPRESSO_Name = 'CRE_BOLETOIMPRESSO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATABOLETOIMPRESSO', ftDateTime)]
    [Dictionary('CRE_DATABOLETOIMPRESSO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATABOLETOIMPRESSO: TDateTime read FCRE_DATABOLETOIMPRESSO write FCRE_DATABOLETOIMPRESSO;
    const CRE_DATABOLETOIMPRESSO_Name = 'CRE_DATABOLETOIMPRESSO';

    [Restrictions([NoValidate])]
    [Column('CRE_REMESSAGERADA', ftString, 1)]
    [Dictionary('CRE_REMESSAGERADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_REMESSAGERADA: String read FCRE_REMESSAGERADA write FCRE_REMESSAGERADA;
    const CRE_REMESSAGERADA_Name = 'CRE_REMESSAGERADA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAREMESSAGERADA', ftDateTime)]
    [Dictionary('CRE_DATAREMESSAGERADA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAREMESSAGERADA: TDateTime read FCRE_DATAREMESSAGERADA write FCRE_DATAREMESSAGERADA;
    const CRE_DATAREMESSAGERADA_Name = 'CRE_DATAREMESSAGERADA';

    [Restrictions([NoValidate])]
    [Column('CRE_EMAILENVIADO', ftString, 1)]
    [Dictionary('CRE_EMAILENVIADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_EMAILENVIADO: String read FCRE_EMAILENVIADO write FCRE_EMAILENVIADO;
    const CRE_EMAILENVIADO_Name = 'CRE_EMAILENVIADO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAEMAILENVIADO', ftDateTime)]
    [Dictionary('CRE_DATAEMAILENVIADO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAEMAILENVIADO: TDateTime read FCRE_DATAEMAILENVIADO write FCRE_DATAEMAILENVIADO;
    const CRE_DATAEMAILENVIADO_Name = 'CRE_DATAEMAILENVIADO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTA_MSGBOLETO', ftString, 80)]
    [Dictionary('CTA_MSGBOLETO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_MSGBOLETO: String read FCTA_MSGBOLETO write FCTA_MSGBOLETO;
    const CTA_MSGBOLETO_Name = 'CTA_MSGBOLETO';

    [Restrictions([NoValidate])]
    [Column('CRE_ACEITE', ftString, 1)]
    [Dictionary('CRE_ACEITE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_ACEITE: String read FCRE_ACEITE write FCRE_ACEITE;
    const CRE_ACEITE_Name = 'CRE_ACEITE';

    [Restrictions([NoValidate])]
    [Column('CTA_AGENCIA', ftString, 10)]
    [Dictionary('CTA_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_AGENCIA: String read FCTA_AGENCIA write FCTA_AGENCIA;
    const CTA_AGENCIA_Name = 'CTA_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_DIGITOAGENCIA', ftString, 1)]
    [Dictionary('CTA_DIGITOAGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DIGITOAGENCIA: String read FCTA_DIGITOAGENCIA write FCTA_DIGITOAGENCIA;
    const CTA_DIGITOAGENCIA_Name = 'CTA_DIGITOAGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODCEDENTE', ftString, 30)]
    [Dictionary('CTA_CODCEDENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CODCEDENTE: String read FCTA_CODCEDENTE write FCTA_CODCEDENTE;
    const CTA_CODCEDENTE_Name = 'CTA_CODCEDENTE';

    [Restrictions([NoValidate])]
    [Column('CTA_PERCENTUALJUROS', ftBCD)]
    [Dictionary('CTA_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_PERCENTUALJUROS: Double read FCTA_PERCENTUALJUROS write FCTA_PERCENTUALJUROS;
    const CTA_PERCENTUALJUROS_Name = 'CTA_PERCENTUALJUROS';

    [Restrictions([NoValidate])]
    [Column('CTA_PERCENTUALMULTABOLETO', ftBCD)]
    [Dictionary('CTA_PERCENTUALMULTABOLETO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_PERCENTUALMULTABOLETO: Double read FCTA_PERCENTUALMULTABOLETO write FCTA_PERCENTUALMULTABOLETO;
    const CTA_PERCENTUALMULTABOLETO_Name = 'CTA_PERCENTUALMULTABOLETO';

    [Restrictions([NoValidate])]
    [Column('CTA_CARENCIA', ftInteger)]
    [Dictionary('CTA_CARENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CARENCIA: Integer read FCTA_CARENCIA write FCTA_CARENCIA;
    const CTA_CARENCIA_Name = 'CTA_CARENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_PERCENTUALDESCONTOBOLETO', ftBCD)]
    [Dictionary('CTA_PERCENTUALDESCONTOBOLETO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_PERCENTUALDESCONTOBOLETO: Double read FCTA_PERCENTUALDESCONTOBOLETO write FCTA_PERCENTUALDESCONTOBOLETO;
    const CTA_PERCENTUALDESCONTOBOLETO_Name = 'CTA_PERCENTUALDESCONTOBOLETO';

    [Restrictions([NoValidate])]
    [Column('CTA_DIASDESCONTOBOLETO', ftInteger)]
    [Dictionary('CTA_DIASDESCONTOBOLETO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_DIASDESCONTOBOLETO: Integer read FCTA_DIASDESCONTOBOLETO write FCTA_DIASDESCONTOBOLETO;
    const CTA_DIASDESCONTOBOLETO_Name = 'CTA_DIASDESCONTOBOLETO';

    [Restrictions([NoValidate])]
    [Column('CTA_DIASPROTESTO', ftInteger)]
    [Dictionary('CTA_DIASPROTESTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_DIASPROTESTO: Integer read FCTA_DIASPROTESTO write FCTA_DIASPROTESTO;
    const CTA_DIASPROTESTO_Name = 'CTA_DIASPROTESTO';

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
    [Column('CRE_OBSERVACAOBOLETO', ftString, 5000)]
    [Dictionary('CRE_OBSERVACAOBOLETO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSERVACAOBOLETO: String read FCRE_OBSERVACAOBOLETO write FCRE_OBSERVACAOBOLETO;
    const CRE_OBSERVACAOBOLETO_Name = 'CRE_OBSERVACAOBOLETO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRE_GeraNLicense)

end.
