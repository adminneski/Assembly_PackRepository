unit express.dbo.VW_PSQ_LIC;

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
  [Table('VW_PSQ_LIC', '')]
  TDtoVW_PSQ_LIC = class
  private
    { Private declarations } 
    FLIC_ID: Integer;
    FCOM_CODIGO: Integer;
    FLIC_DATACADASTRO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_EMAIL: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_1: String;
    FLIC_VALORMENSALIDADE: Double;
    FLIC_VALORNOTAFISCAL: Double;
    FLIC_DIAPAGAMENTO: String;
    FLIC_RESPONSAVELFINANCEIRO: String;
    FLIC_MODULO: String;
    FLIC_STATUSLICENCA: String;
    FLIC_ROTINAS: String;
    FLIC_QTDCONEXOES: Integer;
    FLIC_OBSERVACAO: String;
    FLIC_BLOQUEADO: String;
    FLIC_DESATIVADO: String;
    FLIC_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_LIC';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_ID', ftInteger)]
    [Dictionary('LIC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_ID: Integer read FLIC_ID write FLIC_ID;
    const LIC_ID_Name = 'LIC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LIC_DATACADASTRO', ftDateTime)]
    [Dictionary('LIC_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property LIC_DATACADASTRO: TDateTime read FLIC_DATACADASTRO write FLIC_DATACADASTRO;
    const LIC_DATACADASTRO_Name = 'LIC_DATACADASTRO';

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
    [Column('LIC_VALORMENSALIDADE', ftBCD, 10, 2)]
    [Dictionary('LIC_VALORMENSALIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE: Double read FLIC_VALORMENSALIDADE write FLIC_VALORMENSALIDADE;
    const LIC_VALORMENSALIDADE_Name = 'LIC_VALORMENSALIDADE';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('LIC_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORNOTAFISCAL: Double read FLIC_VALORNOTAFISCAL write FLIC_VALORNOTAFISCAL;
    const LIC_VALORNOTAFISCAL_Name = 'LIC_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LIC_DIAPAGAMENTO', ftString, 2)]
    [Dictionary('LIC_DIAPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_DIAPAGAMENTO: String read FLIC_DIAPAGAMENTO write FLIC_DIAPAGAMENTO;
    const LIC_DIAPAGAMENTO_Name = 'LIC_DIAPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('LIC_RESPONSAVELFINANCEIRO', ftString, 50)]
    [Dictionary('LIC_RESPONSAVELFINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_RESPONSAVELFINANCEIRO: String read FLIC_RESPONSAVELFINANCEIRO write FLIC_RESPONSAVELFINANCEIRO;
    const LIC_RESPONSAVELFINANCEIRO_Name = 'LIC_RESPONSAVELFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('LIC_MODULO', ftString, 3)]
    [Dictionary('LIC_MODULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_MODULO: String read FLIC_MODULO write FLIC_MODULO;
    const LIC_MODULO_Name = 'LIC_MODULO';

    [Restrictions([NoValidate])]
    [Column('LIC_STATUSLICENCA', ftString, 1)]
    [Dictionary('LIC_STATUSLICENCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_STATUSLICENCA: String read FLIC_STATUSLICENCA write FLIC_STATUSLICENCA;
    const LIC_STATUSLICENCA_Name = 'LIC_STATUSLICENCA';

    [Restrictions([NoValidate])]
    [Column('LIC_ROTINAS', ftString, 30)]
    [Dictionary('LIC_ROTINAS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_ROTINAS: String read FLIC_ROTINAS write FLIC_ROTINAS;
    const LIC_ROTINAS_Name = 'LIC_ROTINAS';

    [Restrictions([NoValidate])]
    [Column('LIC_QTDCONEXOES', ftInteger)]
    [Dictionary('LIC_QTDCONEXOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_QTDCONEXOES: Integer read FLIC_QTDCONEXOES write FLIC_QTDCONEXOES;
    const LIC_QTDCONEXOES_Name = 'LIC_QTDCONEXOES';

    [Restrictions([NoValidate])]
    [Column('LIC_OBSERVACAO', ftString, 5000)]
    [Dictionary('LIC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_OBSERVACAO: String read FLIC_OBSERVACAO write FLIC_OBSERVACAO;
    const LIC_OBSERVACAO_Name = 'LIC_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_BLOQUEADO', ftString, 1)]
    [Dictionary('LIC_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_BLOQUEADO: String read FLIC_BLOQUEADO write FLIC_BLOQUEADO;
    const LIC_BLOQUEADO_Name = 'LIC_BLOQUEADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_DESATIVADO', ftString, 1)]
    [Dictionary('LIC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_DESATIVADO: String read FLIC_DESATIVADO write FLIC_DESATIVADO;
    const LIC_DESATIVADO_Name = 'LIC_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_DATAALTERACAO', ftDateTime)]
    [Dictionary('LIC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LIC_DATAALTERACAO: TDateTime read FLIC_DATAALTERACAO write FLIC_DATAALTERACAO;
    const LIC_DATAALTERACAO_Name = 'LIC_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_LIC)

end.
