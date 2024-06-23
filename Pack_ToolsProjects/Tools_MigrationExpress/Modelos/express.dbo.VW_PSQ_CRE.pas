unit express.dbo.VW_PSQ_CRE;

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
  [Table('VW_PSQ_CRE', '')]
  TDtoVW_PSQ_CRE = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRE_NOTAFISCAL: String;
    FCRE_NOTAFISCALSERVICO: String;
    FCRE_NUMERODOCTO: String;
    FCRE_ORDEMPARCIAL: Integer;
    FCRE_PRORROGACOES: Integer;
    FCGA_ID: Integer;
    FCRE_DC: String;
    FCRE_STATUS: String;
    FCTA_CODIGOBAIXA: Integer;
    FPES_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPOR_CODIGO: Integer;
    FCRE_TIPODOCUMENTO: String;
    FCRE_HISTORICO: String;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_DATABAIXA: TDateTime;
    FCRE_DATALANCAMENTO: TDateTime;
    FCRE_COMPETENCIA: String;
    FCRE_DATAVENCTOORIGINAL: TDateTime;
    FCRE_TOTALIPI: Double;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALFRETE: Double;
    FCRE_PERCENTUALCOMISSAO: Double;
    FCRE_TOTALVALORBAIXA: Double;
    FCRE_DESATIVADO: String;
    FCRE_DATAULTIMOPAGTO: TDateTime;
    FCRE_PLANOCONTARATEIO: Double;
    FCRE_INTEGRACAO: String;
    FCRE_NUMEROFATURA: String;
    FCRE_OBSERVACAO: String;
    FUSERS_LOGIN: String;
    FCRE_DATAALTERACAO: TDateTime;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FNTO_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FCRE_DESCONTADO: String;
    FCRE_DATADESCONTADO: TDateTime;
    FCRE_BOLETOIMPRESSO: String;
    FCRE_REMESSAGERADA: String;
    FCRE_MSGBOLETO: String;
    FCRE_ACEITE: String;
    FCRE_EMAILENVIADO: String;
    FCRE_TOTALNOTAFISCAL: Double;
    FCRE_DATABOLETOIMPRESSO: TDateTime;
    FCRE_DATAREMESSAGERADA: TDateTime;
    FCRE_DATAEMAILENVIADO: TDateTime;
    FCRE_PES_CODIGO: Integer;
    FCRE_OBSCOBRANCA: String;
    FCRE_DATANOVOCONTATO: TDateTime;
    FCRE_NOSSONUMERO: String;
    FPES_CNPJ_CPF: String;
    FCOM_CODIGO_INTEGRACAO_AUTHENTICATOR: Integer;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CRE';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ORDEMPARCIAL', ftInteger)]
    [Dictionary('CRE_ORDEMPARCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ORDEMPARCIAL: Integer read FCRE_ORDEMPARCIAL write FCRE_ORDEMPARCIAL;
    const CRE_ORDEMPARCIAL_Name = 'CRE_ORDEMPARCIAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PRORROGACOES', ftInteger)]
    [Dictionary('CRE_PRORROGACOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PRORROGACOES: Integer read FCRE_PRORROGACOES write FCRE_PRORROGACOES;
    const CRE_PRORROGACOES_Name = 'CRE_PRORROGACOES';

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
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('POR_CODIGO', ftInteger)]
    [Dictionary('POR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property POR_CODIGO: Integer read FPOR_CODIGO write FPOR_CODIGO;
    const POR_CODIGO_Name = 'POR_CODIGO';

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
    [Column('CRE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CRE_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATALANCAMENTO: TDateTime read FCRE_DATALANCAMENTO write FCRE_DATALANCAMENTO;
    const CRE_DATALANCAMENTO_Name = 'CRE_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CRE_COMPETENCIA', ftString, 6)]
    [Dictionary('CRE_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_COMPETENCIA: String read FCRE_COMPETENCIA write FCRE_COMPETENCIA;
    const CRE_COMPETENCIA_Name = 'CRE_COMPETENCIA';

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
    [Column('CRE_TOTALVALOR', ftBCD, 48, 2)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFRETE', ftBCD)]
    [Dictionary('CRE_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFRETE: Double read FCRE_TOTALFRETE write FCRE_TOTALFRETE;
    const CRE_TOTALFRETE_Name = 'CRE_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('CRE_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALCOMISSAO: Double read FCRE_PERCENTUALCOMISSAO write FCRE_PERCENTUALCOMISSAO;
    const CRE_PERCENTUALCOMISSAO_Name = 'CRE_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXA', ftBCD, 48, 2)]
    [Dictionary('CRE_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXA: Double read FCRE_TOTALVALORBAIXA write FCRE_TOTALVALORBAIXA;
    const CRE_TOTALVALORBAIXA_Name = 'CRE_TOTALVALORBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DESATIVADO', ftString, 1)]
    [Dictionary('CRE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESATIVADO: String read FCRE_DESATIVADO write FCRE_DESATIVADO;
    const CRE_DESATIVADO_Name = 'CRE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAULTIMOPAGTO', ftDateTime)]
    [Dictionary('CRE_DATAULTIMOPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAULTIMOPAGTO: TDateTime read FCRE_DATAULTIMOPAGTO write FCRE_DATAULTIMOPAGTO;
    const CRE_DATAULTIMOPAGTO_Name = 'CRE_DATAULTIMOPAGTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PLANOCONTARATEIO', ftBCD, 48, 2)]
    [Dictionary('CRE_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PLANOCONTARATEIO: Double read FCRE_PLANOCONTARATEIO write FCRE_PLANOCONTARATEIO;
    const CRE_PLANOCONTARATEIO_Name = 'CRE_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO', ftString, 50)]
    [Dictionary('CRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO: String read FCRE_INTEGRACAO write FCRE_INTEGRACAO;
    const CRE_INTEGRACAO_Name = 'CRE_INTEGRACAO';

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

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: String read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;
    const FPG_TIPOPAGTOCOMISSAO_Name = 'FPG_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

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

    [Restrictions([NoValidate])]
    [Column('CRE_BOLETOIMPRESSO', ftString, 1)]
    [Dictionary('CRE_BOLETOIMPRESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_BOLETOIMPRESSO: String read FCRE_BOLETOIMPRESSO write FCRE_BOLETOIMPRESSO;
    const CRE_BOLETOIMPRESSO_Name = 'CRE_BOLETOIMPRESSO';

    [Restrictions([NoValidate])]
    [Column('CRE_REMESSAGERADA', ftString, 1)]
    [Dictionary('CRE_REMESSAGERADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_REMESSAGERADA: String read FCRE_REMESSAGERADA write FCRE_REMESSAGERADA;
    const CRE_REMESSAGERADA_Name = 'CRE_REMESSAGERADA';

    [Restrictions([NoValidate])]
    [Column('CRE_MSGBOLETO', ftString, 80)]
    [Dictionary('CRE_MSGBOLETO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_MSGBOLETO: String read FCRE_MSGBOLETO write FCRE_MSGBOLETO;
    const CRE_MSGBOLETO_Name = 'CRE_MSGBOLETO';

    [Restrictions([NoValidate])]
    [Column('CRE_ACEITE', ftString, 1)]
    [Dictionary('CRE_ACEITE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_ACEITE: String read FCRE_ACEITE write FCRE_ACEITE;
    const CRE_ACEITE_Name = 'CRE_ACEITE';

    [Restrictions([NoValidate])]
    [Column('CRE_EMAILENVIADO', ftString, 1)]
    [Dictionary('CRE_EMAILENVIADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_EMAILENVIADO: String read FCRE_EMAILENVIADO write FCRE_EMAILENVIADO;
    const CRE_EMAILENVIADO_Name = 'CRE_EMAILENVIADO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CRE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALNOTAFISCAL: Double read FCRE_TOTALNOTAFISCAL write FCRE_TOTALNOTAFISCAL;
    const CRE_TOTALNOTAFISCAL_Name = 'CRE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CRE_DATABOLETOIMPRESSO', ftDateTime)]
    [Dictionary('CRE_DATABOLETOIMPRESSO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATABOLETOIMPRESSO: TDateTime read FCRE_DATABOLETOIMPRESSO write FCRE_DATABOLETOIMPRESSO;
    const CRE_DATABOLETOIMPRESSO_Name = 'CRE_DATABOLETOIMPRESSO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAREMESSAGERADA', ftDateTime)]
    [Dictionary('CRE_DATAREMESSAGERADA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAREMESSAGERADA: TDateTime read FCRE_DATAREMESSAGERADA write FCRE_DATAREMESSAGERADA;
    const CRE_DATAREMESSAGERADA_Name = 'CRE_DATAREMESSAGERADA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAEMAILENVIADO', ftDateTime)]
    [Dictionary('CRE_DATAEMAILENVIADO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAEMAILENVIADO: TDateTime read FCRE_DATAEMAILENVIADO write FCRE_DATAEMAILENVIADO;
    const CRE_DATAEMAILENVIADO_Name = 'CRE_DATAEMAILENVIADO';

    [Restrictions([NoValidate])]
    [Column('CRE_PES_CODIGO', ftInteger)]
    [Dictionary('CRE_PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PES_CODIGO: Integer read FCRE_PES_CODIGO write FCRE_PES_CODIGO;
    const CRE_PES_CODIGO_Name = 'CRE_PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_OBSCOBRANCA', ftString, 2000)]
    [Dictionary('CRE_OBSCOBRANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSCOBRANCA: String read FCRE_OBSCOBRANCA write FCRE_OBSCOBRANCA;
    const CRE_OBSCOBRANCA_Name = 'CRE_OBSCOBRANCA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATANOVOCONTATO', ftDateTime)]
    [Dictionary('CRE_DATANOVOCONTATO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATANOVOCONTATO: TDateTime read FCRE_DATANOVOCONTATO write FCRE_DATANOVOCONTATO;
    const CRE_DATANOVOCONTATO_Name = 'CRE_DATANOVOCONTATO';

    [Restrictions([NoValidate])]
    [Column('CRE_NOSSONUMERO', ftString, 20)]
    [Dictionary('CRE_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOSSONUMERO: String read FCRE_NOSSONUMERO write FCRE_NOSSONUMERO;
    const CRE_NOSSONUMERO_Name = 'CRE_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO_INTEGRACAO_AUTHENTICATOR', ftInteger)]
    [Dictionary('COM_CODIGO_INTEGRACAO_AUTHENTICATOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO_INTEGRACAO_AUTHENTICATOR: Integer read FCOM_CODIGO_INTEGRACAO_AUTHENTICATOR write FCOM_CODIGO_INTEGRACAO_AUTHENTICATOR;
    const COM_CODIGO_INTEGRACAO_AUTHENTICATOR_Name = 'COM_CODIGO_INTEGRACAO_AUTHENTICATOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CRE)

end.
