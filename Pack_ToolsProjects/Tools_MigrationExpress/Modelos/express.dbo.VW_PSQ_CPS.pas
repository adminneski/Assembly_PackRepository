unit express.dbo.VW_PSQ_CPS;

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
  [Table('VW_PSQ_CPS', '')]
  TDtoVW_PSQ_CPS = class
  private
    { Private declarations } 
    FCPS_ID: Integer;
    FCOM_CODIGO: Integer;
    FCPS_DATACADASTRO: TDateTime;
    FCPS_PLANO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_EMAIL: String;
    FCEP_CODIGO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_TIPOPESSOA: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_1: String;
    FCPS_VALORMENSALIDADE: Double;
    FCPS_VALORNOTAFISCAL: Double;
    FCPS_DIAPAGAMENTO: String;
    FMDO_CODIGO: Integer;
    FMDO_DESCRICAO: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FCPS_RESPONSAVELFINANCEIRO: String;
    FCPS_ULTIMANOTAFISCALGERADA: Integer;
    FCPS_ULTIMOMESANOGERADO: String;
    FCPS_OBSERVACAO: String;
    FCPS_DESATIVADO: String;
    FCPS_DATAALTERACAO: TDateTime;
    FCPS_GERAFINANCEIRO: String;
    FCPS_EMITENFSE: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CPS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPS_ID', ftInteger)]
    [Dictionary('CPS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPS_ID: Integer read FCPS_ID write FCPS_ID;
    const CPS_ID_Name = 'CPS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPS_DATACADASTRO', ftDateTime)]
    [Dictionary('CPS_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPS_DATACADASTRO: TDateTime read FCPS_DATACADASTRO write FCPS_DATACADASTRO;
    const CPS_DATACADASTRO_Name = 'CPS_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('CPS_PLANO', ftString, 100)]
    [Dictionary('CPS_PLANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_PLANO: String read FCPS_PLANO write FCPS_PLANO;
    const CPS_PLANO_Name = 'CPS_PLANO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_EMAIL', ftString, 300)]
    [Dictionary('PES_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL: String read FPES_EMAIL write FPES_EMAIL;
    const PES_EMAIL_Name = 'PES_EMAIL';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

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
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

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
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('CPS_VALORMENSALIDADE', ftBCD)]
    [Dictionary('CPS_VALORMENSALIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPS_VALORMENSALIDADE: Double read FCPS_VALORMENSALIDADE write FCPS_VALORMENSALIDADE;
    const CPS_VALORMENSALIDADE_Name = 'CPS_VALORMENSALIDADE';

    [Restrictions([NoValidate])]
    [Column('CPS_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('CPS_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPS_VALORNOTAFISCAL: Double read FCPS_VALORNOTAFISCAL write FCPS_VALORNOTAFISCAL;
    const CPS_VALORNOTAFISCAL_Name = 'CPS_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPS_DIAPAGAMENTO', ftString, 2)]
    [Dictionary('CPS_DIAPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_DIAPAGAMENTO: String read FCPS_DIAPAGAMENTO write FCPS_DIAPAGAMENTO;
    const CPS_DIAPAGAMENTO_Name = 'CPS_DIAPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MDO_DESCRICAO', ftString, 300)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

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
    [Column('CPS_RESPONSAVELFINANCEIRO', ftString, 50)]
    [Dictionary('CPS_RESPONSAVELFINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_RESPONSAVELFINANCEIRO: String read FCPS_RESPONSAVELFINANCEIRO write FCPS_RESPONSAVELFINANCEIRO;
    const CPS_RESPONSAVELFINANCEIRO_Name = 'CPS_RESPONSAVELFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CPS_ULTIMANOTAFISCALGERADA', ftInteger)]
    [Dictionary('CPS_ULTIMANOTAFISCALGERADA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPS_ULTIMANOTAFISCALGERADA: Integer read FCPS_ULTIMANOTAFISCALGERADA write FCPS_ULTIMANOTAFISCALGERADA;
    const CPS_ULTIMANOTAFISCALGERADA_Name = 'CPS_ULTIMANOTAFISCALGERADA';

    [Restrictions([NoValidate])]
    [Column('CPS_ULTIMOMESANOGERADO', ftString, 6)]
    [Dictionary('CPS_ULTIMOMESANOGERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_ULTIMOMESANOGERADO: String read FCPS_ULTIMOMESANOGERADO write FCPS_ULTIMOMESANOGERADO;
    const CPS_ULTIMOMESANOGERADO_Name = 'CPS_ULTIMOMESANOGERADO';

    [Restrictions([NoValidate])]
    [Column('CPS_OBSERVACAO', ftString, 5000)]
    [Dictionary('CPS_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_OBSERVACAO: String read FCPS_OBSERVACAO write FCPS_OBSERVACAO;
    const CPS_OBSERVACAO_Name = 'CPS_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPS_DESATIVADO', ftString, 1)]
    [Dictionary('CPS_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_DESATIVADO: String read FCPS_DESATIVADO write FCPS_DESATIVADO;
    const CPS_DESATIVADO_Name = 'CPS_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPS_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPS_DATAALTERACAO: TDateTime read FCPS_DATAALTERACAO write FCPS_DATAALTERACAO;
    const CPS_DATAALTERACAO_Name = 'CPS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPS_GERAFINANCEIRO', ftString, 1)]
    [Dictionary('CPS_GERAFINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_GERAFINANCEIRO: String read FCPS_GERAFINANCEIRO write FCPS_GERAFINANCEIRO;
    const CPS_GERAFINANCEIRO_Name = 'CPS_GERAFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CPS_EMITENFSE', ftString, 1)]
    [Dictionary('CPS_EMITENFSE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_EMITENFSE: String read FCPS_EMITENFSE write FCPS_EMITENFSE;
    const CPS_EMITENFSE_Name = 'CPS_EMITENFSE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CPS)

end.
