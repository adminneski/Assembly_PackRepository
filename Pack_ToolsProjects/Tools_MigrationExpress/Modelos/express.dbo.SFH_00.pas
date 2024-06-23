unit express.dbo.SFH_00;

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
  [Table('SFH_00', '')]
  [PrimaryKey('SFH_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SFH_CODIGO')]
  TDtoSFH_00 = class
  private
    { Private declarations } 
    FSFH_CODIGO: Integer;
    FCEP_CODIGO: String;
    FCID_IBGE: String;
    FSFH_CNPJ: String;
    FSFH_IE: String;
    FSFH_UF: String;
    FSFH_RAZAO: String;
    FSFH_FANTASIA_OU_APELIDO: String;
    FSFH_ENDERECO: String;
    FSFH_NUMEROENDERECO: String;
    FSFH_BAIRRO: String;
    FSFH_PONTOREFERENCIA: String;
    FSFH_DDD_TELEFONE: String;
    FSFH_DDD_CELULAR: String;
    FSFH_DDD_FAX: String;
    FSFH_EMAIL: String;
    FSFH_HTTP: String;
    FSFH_CAIXAPOSTAL: String;
    FSFH_IE_MUNICIPAL: String;
    FSFH_CONTATO: String;
    FSFH_OBSERVACAO: String;
    FSFH_NUMEROLAUDO: String;
    FSFH_DESATIVADO: String;
    FSFH_DATAALTERACAO: TDateTime;
    FSFH_VERSAOER: String;
    FSFH_IDCSTR: Integer;
    FSFH_CSTR: String;
    FSFH_CIDADE: String;
  public 
    { Public declarations } 
     const Table      = 'SFH_00';
     const PrimaryKey = 'SFH_CODIGO';
     const Sequence   = 'SEQ_SFH_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_CODIGO', ftInteger)]
    [Dictionary('SFH_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SFH_CODIGO: Integer read FSFH_CODIGO write FSFH_CODIGO;
    const SFH_CODIGO_Name = 'SFH_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_CNPJ', ftString, 14)]
    [Dictionary('SFH_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_CNPJ: String read FSFH_CNPJ write FSFH_CNPJ;
    const SFH_CNPJ_Name = 'SFH_CNPJ';

    [Restrictions([NoValidate])]
    [Column('SFH_IE', ftString, 16)]
    [Dictionary('SFH_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_IE: String read FSFH_IE write FSFH_IE;
    const SFH_IE_Name = 'SFH_IE';

    [Restrictions([NoValidate])]
    [Column('SFH_UF', ftString, 2)]
    [Dictionary('SFH_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_UF: String read FSFH_UF write FSFH_UF;
    const SFH_UF_Name = 'SFH_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_RAZAO', ftString, 50)]
    [Dictionary('SFH_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_RAZAO: String read FSFH_RAZAO write FSFH_RAZAO;
    const SFH_RAZAO_Name = 'SFH_RAZAO';

    [Restrictions([NoValidate])]
    [Column('SFH_FANTASIA_OU_APELIDO', ftString, 50)]
    [Dictionary('SFH_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_FANTASIA_OU_APELIDO: String read FSFH_FANTASIA_OU_APELIDO write FSFH_FANTASIA_OU_APELIDO;
    const SFH_FANTASIA_OU_APELIDO_Name = 'SFH_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate])]
    [Column('SFH_ENDERECO', ftString, 50)]
    [Dictionary('SFH_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_ENDERECO: String read FSFH_ENDERECO write FSFH_ENDERECO;
    const SFH_ENDERECO_Name = 'SFH_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('SFH_NUMEROENDERECO', ftString, 5)]
    [Dictionary('SFH_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_NUMEROENDERECO: String read FSFH_NUMEROENDERECO write FSFH_NUMEROENDERECO;
    const SFH_NUMEROENDERECO_Name = 'SFH_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('SFH_BAIRRO', ftString, 30)]
    [Dictionary('SFH_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_BAIRRO: String read FSFH_BAIRRO write FSFH_BAIRRO;
    const SFH_BAIRRO_Name = 'SFH_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('SFH_PONTOREFERENCIA', ftString, 50)]
    [Dictionary('SFH_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_PONTOREFERENCIA: String read FSFH_PONTOREFERENCIA write FSFH_PONTOREFERENCIA;
    const SFH_PONTOREFERENCIA_Name = 'SFH_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('SFH_DDD_TELEFONE', ftString, 11)]
    [Dictionary('SFH_DDD_TELEFONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DDD_TELEFONE: String read FSFH_DDD_TELEFONE write FSFH_DDD_TELEFONE;
    const SFH_DDD_TELEFONE_Name = 'SFH_DDD_TELEFONE';

    [Restrictions([NoValidate])]
    [Column('SFH_DDD_CELULAR', ftString, 11)]
    [Dictionary('SFH_DDD_CELULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DDD_CELULAR: String read FSFH_DDD_CELULAR write FSFH_DDD_CELULAR;
    const SFH_DDD_CELULAR_Name = 'SFH_DDD_CELULAR';

    [Restrictions([NoValidate])]
    [Column('SFH_DDD_FAX', ftString, 11)]
    [Dictionary('SFH_DDD_FAX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DDD_FAX: String read FSFH_DDD_FAX write FSFH_DDD_FAX;
    const SFH_DDD_FAX_Name = 'SFH_DDD_FAX';

    [Restrictions([NoValidate])]
    [Column('SFH_EMAIL', ftString, 50)]
    [Dictionary('SFH_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_EMAIL: String read FSFH_EMAIL write FSFH_EMAIL;
    const SFH_EMAIL_Name = 'SFH_EMAIL';

    [Restrictions([NoValidate])]
    [Column('SFH_HTTP', ftString, 50)]
    [Dictionary('SFH_HTTP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_HTTP: String read FSFH_HTTP write FSFH_HTTP;
    const SFH_HTTP_Name = 'SFH_HTTP';

    [Restrictions([NoValidate])]
    [Column('SFH_CAIXAPOSTAL', ftString, 5)]
    [Dictionary('SFH_CAIXAPOSTAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_CAIXAPOSTAL: String read FSFH_CAIXAPOSTAL write FSFH_CAIXAPOSTAL;
    const SFH_CAIXAPOSTAL_Name = 'SFH_CAIXAPOSTAL';

    [Restrictions([NoValidate])]
    [Column('SFH_IE_MUNICIPAL', ftString, 16)]
    [Dictionary('SFH_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_IE_MUNICIPAL: String read FSFH_IE_MUNICIPAL write FSFH_IE_MUNICIPAL;
    const SFH_IE_MUNICIPAL_Name = 'SFH_IE_MUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('SFH_CONTATO', ftString, 50)]
    [Dictionary('SFH_CONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_CONTATO: String read FSFH_CONTATO write FSFH_CONTATO;
    const SFH_CONTATO_Name = 'SFH_CONTATO';

    [Restrictions([NoValidate])]
    [Column('SFH_OBSERVACAO', ftString, 300)]
    [Dictionary('SFH_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_OBSERVACAO: String read FSFH_OBSERVACAO write FSFH_OBSERVACAO;
    const SFH_OBSERVACAO_Name = 'SFH_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_NUMEROLAUDO', ftString, 25)]
    [Dictionary('SFH_NUMEROLAUDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_NUMEROLAUDO: String read FSFH_NUMEROLAUDO write FSFH_NUMEROLAUDO;
    const SFH_NUMEROLAUDO_Name = 'SFH_NUMEROLAUDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_DESATIVADO', ftString, 1)]
    [Dictionary('SFH_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DESATIVADO: String read FSFH_DESATIVADO write FSFH_DESATIVADO;
    const SFH_DESATIVADO_Name = 'SFH_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_DATAALTERACAO', ftDateTime)]
    [Dictionary('SFH_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SFH_DATAALTERACAO: TDateTime read FSFH_DATAALTERACAO write FSFH_DATAALTERACAO;
    const SFH_DATAALTERACAO_Name = 'SFH_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SFH_VERSAOER', ftString, 4)]
    [Dictionary('SFH_VERSAOER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_VERSAOER: String read FSFH_VERSAOER write FSFH_VERSAOER;
    const SFH_VERSAOER_Name = 'SFH_VERSAOER';

    [Restrictions([NoValidate])]
    [Column('SFH_IDCSTR', ftInteger)]
    [Dictionary('SFH_IDCSTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property SFH_IDCSTR: Integer read FSFH_IDCSTR write FSFH_IDCSTR;
    const SFH_IDCSTR_Name = 'SFH_IDCSTR';

    [Restrictions([NoValidate])]
    [Column('SFH_CSTR', ftString, 30)]
    [Dictionary('SFH_CSTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_CSTR: String read FSFH_CSTR write FSFH_CSTR;
    const SFH_CSTR_Name = 'SFH_CSTR';

    [Restrictions([NoValidate])]
    [Column('SFH_CIDADE', ftString, 100)]
    [Dictionary('SFH_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_CIDADE: String read FSFH_CIDADE write FSFH_CIDADE;
    const SFH_CIDADE_Name = 'SFH_CIDADE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSFH_00)

end.
