unit express.dbo.CCR_LOTEBAIXA;

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
  [Table('CCR_LoteBaixa', '')]
  TDtoCCR_LoteBaixa = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FCRE_TIPODOCUMENTO: String;
    FCRE_PRORROGACOES: Integer;
    FCRE_STATUS: String;
    FCRE_TOTALVALOR: Double;
    FCRE_NOTAFISCAL: String;
    FCRE_NUMERODOCTO: String;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_DATABAIXA: TDateTime;
    FCRE_DESATIVADO: String;
    FCTA_CODIGOBAIXA: Integer;
    FCRE_DC: String;
    FCRE_HISTORICO: String;
    FCRE_OBSERVACAO: String;
    FCRE_PERCENTUALFINANCEIRO: Double;
    FCRE_VALORFINANCEIRO: Double;
    FCRT_CODIGO: Integer;
    FCRE_AUTORIZACAOCARTAO: String;
    FCRT_DESCRICAO: String;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'CCR_LoteBaixa';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

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
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

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
    [Column('CRE_TOTALVALOR', ftBCD, 1280335696, 2)]
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
    [Column('CRE_DESATIVADO', ftString, 1)]
    [Dictionary('CRE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESATIVADO: String read FCRE_DESATIVADO write FCRE_DESATIVADO;
    const CRE_DESATIVADO_Name = 'CRE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DC', ftString, 1)]
    [Dictionary('CRE_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DC: String read FCRE_DC write FCRE_DC;
    const CRE_DC_Name = 'CRE_DC';

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
    [Column('CRE_PERCENTUALFINANCEIRO', ftBCD, 1329808717, 2)]
    [Dictionary('CRE_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALFINANCEIRO: Double read FCRE_PERCENTUALFINANCEIRO write FCRE_PERCENTUALFINANCEIRO;
    const CRE_PERCENTUALFINANCEIRO_Name = 'CRE_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORFINANCEIRO', ftBCD, 1281455136, 2)]
    [Dictionary('CRE_VALORFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORFINANCEIRO: Double read FCRE_VALORFINANCEIRO write FCRE_VALORFINANCEIRO;
    const CRE_VALORFINANCEIRO_Name = 'CRE_VALORFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCCR_LoteBaixa)

end.
