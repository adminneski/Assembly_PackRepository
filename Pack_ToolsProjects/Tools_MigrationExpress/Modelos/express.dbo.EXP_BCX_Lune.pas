unit express.dbo.EXP_BCX_LUNE;

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
  [Table('EXP_BCX_Lune', '')]
  TDtoEXP_BCX_Lune = class
  private
    { Private declarations } 
    FBCX_TIPODOCTO: String;
    FBCX_TIPO: String;
    FBCX_ID: Integer;
    FCOM_CODIGO: Integer;
    FCOM_CNPJ_CPF: String;
    FBCX_DATALANCAMENTO: TDateTime;
    FBCX_DATAVENCTO: TDateTime;
    FFPG_DESCRICAO: String;
    FBCX_NOTAFISCAL: String;
    FPES_NOME: String;
    FPES_CNPJ_CPF: String;
    FCTA_CODIGO: Integer;
    FCTA_CONTA: String;
    FBCX_VALORDOCTOLIQUIDO: Double;
    FBCX_TOTALDESCTO: Double;
    FBCX_TOTALOUTRASDESPESAS: Integer;
    FBCX_TOTALJUROS: Double;
    FBCX_TOTALMULTA: Integer;
    FBCX_VALORDOCTO: Double;
    FBCX_HISTORICO: String;
    FBCX_TIPOMOVTO: String;
    FBCX_INTEGRACAO: String;
    FBCX_DC: String;
    FPLC_DESCRICAO: String;
    FCRE_TOTALFINANCEIRO: Double;
  public 
    { Public declarations } 
     const Table      = 'EXP_BCX_Lune';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TIPODOCTO', ftString, 3)]
    [Dictionary('BCX_TIPODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPODOCTO: String read FBCX_TIPODOCTO write FBCX_TIPODOCTO;
    const BCX_TIPODOCTO_Name = 'BCX_TIPODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TIPO', ftString, 1)]
    [Dictionary('BCX_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPO: String read FBCX_TIPO write FBCX_TIPO;
    const BCX_TIPO_Name = 'BCX_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_ID', ftInteger)]
    [Dictionary('BCX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID: Integer read FBCX_ID write FBCX_ID;
    const BCX_ID_Name = 'BCX_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCX_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCX_DATALANCAMENTO: TDateTime read FBCX_DATALANCAMENTO write FBCX_DATALANCAMENTO;
    const BCX_DATALANCAMENTO_Name = 'BCX_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('BCX_DATAVENCTO', ftDateTime)]
    [Dictionary('BCX_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCX_DATAVENCTO: TDateTime read FBCX_DATAVENCTO write FBCX_DATAVENCTO;
    const BCX_DATAVENCTO_Name = 'BCX_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('BCX_NOTAFISCAL', ftString, 20)]
    [Dictionary('BCX_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NOTAFISCAL: String read FBCX_NOTAFISCAL write FBCX_NOTAFISCAL;
    const BCX_NOTAFISCAL_Name = 'BCX_NOTAFISCAL';

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
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTA', ftString, 15)]
    [Dictionary('CTA_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTA: String read FCTA_CONTA write FCTA_CONTA;
    const CTA_CONTA_Name = 'CTA_CONTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_VALORDOCTOLIQUIDO', ftBCD)]
    [Dictionary('BCX_VALORDOCTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORDOCTOLIQUIDO: Double read FBCX_VALORDOCTOLIQUIDO write FBCX_VALORDOCTOLIQUIDO;
    const BCX_VALORDOCTOLIQUIDO_Name = 'BCX_VALORDOCTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('BCX_TOTALDESCTO', ftBCD)]
    [Dictionary('BCX_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_TOTALDESCTO: Double read FBCX_TOTALDESCTO write FBCX_TOTALDESCTO;
    const BCX_TOTALDESCTO_Name = 'BCX_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TOTALOUTRASDESPESAS', ftInteger)]
    [Dictionary('BCX_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_TOTALOUTRASDESPESAS: Integer read FBCX_TOTALOUTRASDESPESAS write FBCX_TOTALOUTRASDESPESAS;
    const BCX_TOTALOUTRASDESPESAS_Name = 'BCX_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate])]
    [Column('BCX_TOTALJUROS', ftBCD, 10, 2)]
    [Dictionary('BCX_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_TOTALJUROS: Double read FBCX_TOTALJUROS write FBCX_TOTALJUROS;
    const BCX_TOTALJUROS_Name = 'BCX_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TOTALMULTA', ftInteger)]
    [Dictionary('BCX_TOTALMULTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_TOTALMULTA: Integer read FBCX_TOTALMULTA write FBCX_TOTALMULTA;
    const BCX_TOTALMULTA_Name = 'BCX_TOTALMULTA';

    [Restrictions([NoValidate])]
    [Column('BCX_VALORDOCTO', ftBCD)]
    [Dictionary('BCX_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORDOCTO: Double read FBCX_VALORDOCTO write FBCX_VALORDOCTO;
    const BCX_VALORDOCTO_Name = 'BCX_VALORDOCTO';

    [Restrictions([NoValidate])]
    [Column('BCX_HISTORICO', ftString, 5000)]
    [Dictionary('BCX_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_HISTORICO: String read FBCX_HISTORICO write FBCX_HISTORICO;
    const BCX_HISTORICO_Name = 'BCX_HISTORICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TIPOMOVTO', ftString, 1)]
    [Dictionary('BCX_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPOMOVTO: String read FBCX_TIPOMOVTO write FBCX_TIPOMOVTO;
    const BCX_TIPOMOVTO_Name = 'BCX_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('BCX_INTEGRACAO', ftString, 50)]
    [Dictionary('BCX_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_INTEGRACAO: String read FBCX_INTEGRACAO write FBCX_INTEGRACAO;
    const BCX_INTEGRACAO_Name = 'BCX_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DC', ftString, 1)]
    [Dictionary('BCX_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DC: String read FBCX_DC write FBCX_DC;
    const BCX_DC_Name = 'BCX_DC';

    [Restrictions([NoValidate])]
    [Column('PLC_DESCRICAO', ftString, 30)]
    [Dictionary('PLC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESCRICAO: String read FPLC_DESCRICAO write FPLC_DESCRICAO;
    const PLC_DESCRICAO_Name = 'PLC_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_TOTALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFINANCEIRO: Double read FCRE_TOTALFINANCEIRO write FCRE_TOTALFINANCEIRO;
    const CRE_TOTALFINANCEIRO_Name = 'CRE_TOTALFINANCEIRO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_BCX_Lune)

end.
