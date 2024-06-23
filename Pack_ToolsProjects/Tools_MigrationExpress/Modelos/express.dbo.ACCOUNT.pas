unit express.dbo.ACCOUNT;

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
  [Table('ACCOUNT', '')]
  [PrimaryKey('ACC_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ACC_CODIGO')]
  TDtoACCOUNT = class
  private
    { Private declarations } 
    FACC_CODIGO: Integer;
    FACC_USER: String;
    FACC_FULLNAME: String;
    FACC_PASSWORD: String;
    FACC_CPF_CNPJ: String;
    FACC_DDD_CELULAR: String;
    FACC_DDD_CELULAR_RECOVERY: String;
    FACC_DDD_CELULAR_OUTRO: String;
    FACC_RECOVERYEMAIL: String;
    FACC_DESCRIPTION: String;
    FACC_PROFILEPICTURE: String;
    FACC_ACTIVATION: String;
    FACC_ACTIVATIONCODE: Integer;
    FACC_LASTCOMPANYACCESSED: Integer;
    FACC_DATACADASTRO: TDateTime;
    FACC_DATANASCIMENTO: TDateTime;
    FACC_FUNCIONARIONESKI: String;
    FACC_ADMINISTRATIVONESKI: String;
    FACC_VENDEDORNESKI: String;
    FACC_FRANQUIANESKI: String;
    FACC_CODIGO_RELACIONAMENTO: Integer;
    FACC_CODIGO_VENDEDOR: Integer;
    FACC_CODIGO_FRANQUIA: Integer;
    FACC_DATAHORAALTERACAO: TDateTime;
    FPES_CODIGO_INTEGRACAO_GESTOR: Integer;
  public 
    { Public declarations } 
     const Table      = 'ACCOUNT';
     const PrimaryKey = 'ACC_CODIGO';
     const Sequence   = 'SEQ_ACC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;
    const ACC_CODIGO_Name = 'ACC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_USER', ftString, 250)]
    [Dictionary('ACC_USER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_USER: String read FACC_USER write FACC_USER;
    const ACC_USER_Name = 'ACC_USER';

    [Restrictions([NoValidate])]
    [Column('ACC_FULLNAME', ftString, 100)]
    [Dictionary('ACC_FULLNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FULLNAME: String read FACC_FULLNAME write FACC_FULLNAME;
    const ACC_FULLNAME_Name = 'ACC_FULLNAME';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_PASSWORD', ftString, 50)]
    [Dictionary('ACC_PASSWORD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_PASSWORD: String read FACC_PASSWORD write FACC_PASSWORD;
    const ACC_PASSWORD_Name = 'ACC_PASSWORD';

    [Restrictions([NoValidate])]
    [Column('ACC_CPF_CNPJ', ftString, 14)]
    [Dictionary('ACC_CPF_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_CPF_CNPJ: String read FACC_CPF_CNPJ write FACC_CPF_CNPJ;
    const ACC_CPF_CNPJ_Name = 'ACC_CPF_CNPJ';

    [Restrictions([NoValidate])]
    [Column('ACC_DDD_CELULAR', ftString, 12)]
    [Dictionary('ACC_DDD_CELULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_DDD_CELULAR: String read FACC_DDD_CELULAR write FACC_DDD_CELULAR;
    const ACC_DDD_CELULAR_Name = 'ACC_DDD_CELULAR';

    [Restrictions([NoValidate])]
    [Column('ACC_DDD_CELULAR_RECOVERY', ftString, 12)]
    [Dictionary('ACC_DDD_CELULAR_RECOVERY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_DDD_CELULAR_RECOVERY: String read FACC_DDD_CELULAR_RECOVERY write FACC_DDD_CELULAR_RECOVERY;
    const ACC_DDD_CELULAR_RECOVERY_Name = 'ACC_DDD_CELULAR_RECOVERY';

    [Restrictions([NoValidate])]
    [Column('ACC_DDD_CELULAR_OUTRO', ftString, 12)]
    [Dictionary('ACC_DDD_CELULAR_OUTRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_DDD_CELULAR_OUTRO: String read FACC_DDD_CELULAR_OUTRO write FACC_DDD_CELULAR_OUTRO;
    const ACC_DDD_CELULAR_OUTRO_Name = 'ACC_DDD_CELULAR_OUTRO';

    [Restrictions([NoValidate])]
    [Column('ACC_RECOVERYEMAIL', ftString, 250)]
    [Dictionary('ACC_RECOVERYEMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_RECOVERYEMAIL: String read FACC_RECOVERYEMAIL write FACC_RECOVERYEMAIL;
    const ACC_RECOVERYEMAIL_Name = 'ACC_RECOVERYEMAIL';

    [Restrictions([NoValidate])]
    [Column('ACC_DESCRIPTION', ftString, 500)]
    [Dictionary('ACC_DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_DESCRIPTION: String read FACC_DESCRIPTION write FACC_DESCRIPTION;
    const ACC_DESCRIPTION_Name = 'ACC_DESCRIPTION';

    [Restrictions([NoValidate])]
    [Column('ACC_PROFILEPICTURE', ftString, 300)]
    [Dictionary('ACC_PROFILEPICTURE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_PROFILEPICTURE: String read FACC_PROFILEPICTURE write FACC_PROFILEPICTURE;
    const ACC_PROFILEPICTURE_Name = 'ACC_PROFILEPICTURE';

    [Restrictions([NoValidate])]
    [Column('ACC_ACTIVATION', ftString, 1)]
    [Dictionary('ACC_ACTIVATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_ACTIVATION: String read FACC_ACTIVATION write FACC_ACTIVATION;
    const ACC_ACTIVATION_Name = 'ACC_ACTIVATION';

    [Restrictions([NoValidate])]
    [Column('ACC_ACTIVATIONCODE', ftInteger)]
    [Dictionary('ACC_ACTIVATIONCODE', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_ACTIVATIONCODE: Integer read FACC_ACTIVATIONCODE write FACC_ACTIVATIONCODE;
    const ACC_ACTIVATIONCODE_Name = 'ACC_ACTIVATIONCODE';

    [Restrictions([NoValidate])]
    [Column('ACC_LASTCOMPANYACCESSED', ftInteger)]
    [Dictionary('ACC_LASTCOMPANYACCESSED', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_LASTCOMPANYACCESSED: Integer read FACC_LASTCOMPANYACCESSED write FACC_LASTCOMPANYACCESSED;
    const ACC_LASTCOMPANYACCESSED_Name = 'ACC_LASTCOMPANYACCESSED';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_DATACADASTRO', ftDateTime)]
    [Dictionary('ACC_DATACADASTRO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ACC_DATACADASTRO: TDateTime read FACC_DATACADASTRO write FACC_DATACADASTRO;
    const ACC_DATACADASTRO_Name = 'ACC_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('ACC_DATANASCIMENTO', ftDateTime)]
    [Dictionary('ACC_DATANASCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_DATANASCIMENTO: TDateTime read FACC_DATANASCIMENTO write FACC_DATANASCIMENTO;
    const ACC_DATANASCIMENTO_Name = 'ACC_DATANASCIMENTO';

    [Restrictions([NoValidate])]
    [Column('ACC_FUNCIONARIONESKI', ftString, 1)]
    [Dictionary('ACC_FUNCIONARIONESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FUNCIONARIONESKI: String read FACC_FUNCIONARIONESKI write FACC_FUNCIONARIONESKI;
    const ACC_FUNCIONARIONESKI_Name = 'ACC_FUNCIONARIONESKI';

    [Restrictions([NoValidate])]
    [Column('ACC_ADMINISTRATIVONESKI', ftString, 1)]
    [Dictionary('ACC_ADMINISTRATIVONESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_ADMINISTRATIVONESKI: String read FACC_ADMINISTRATIVONESKI write FACC_ADMINISTRATIVONESKI;
    const ACC_ADMINISTRATIVONESKI_Name = 'ACC_ADMINISTRATIVONESKI';

    [Restrictions([NoValidate])]
    [Column('ACC_VENDEDORNESKI', ftString, 1)]
    [Dictionary('ACC_VENDEDORNESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_VENDEDORNESKI: String read FACC_VENDEDORNESKI write FACC_VENDEDORNESKI;
    const ACC_VENDEDORNESKI_Name = 'ACC_VENDEDORNESKI';

    [Restrictions([NoValidate])]
    [Column('ACC_FRANQUIANESKI', ftString, 1)]
    [Dictionary('ACC_FRANQUIANESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FRANQUIANESKI: String read FACC_FRANQUIANESKI write FACC_FRANQUIANESKI;
    const ACC_FRANQUIANESKI_Name = 'ACC_FRANQUIANESKI';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_RELACIONAMENTO', ftInteger)]
    [Dictionary('ACC_CODIGO_RELACIONAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_RELACIONAMENTO: Integer read FACC_CODIGO_RELACIONAMENTO write FACC_CODIGO_RELACIONAMENTO;
    const ACC_CODIGO_RELACIONAMENTO_Name = 'ACC_CODIGO_RELACIONAMENTO';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_VENDEDOR', ftInteger)]
    [Dictionary('ACC_CODIGO_VENDEDOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_VENDEDOR: Integer read FACC_CODIGO_VENDEDOR write FACC_CODIGO_VENDEDOR;
    const ACC_CODIGO_VENDEDOR_Name = 'ACC_CODIGO_VENDEDOR';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_FRANQUIA', ftInteger)]
    [Dictionary('ACC_CODIGO_FRANQUIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_FRANQUIA: Integer read FACC_CODIGO_FRANQUIA write FACC_CODIGO_FRANQUIA;
    const ACC_CODIGO_FRANQUIA_Name = 'ACC_CODIGO_FRANQUIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('ACC_DATAHORAALTERACAO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property ACC_DATAHORAALTERACAO: TDateTime read FACC_DATAHORAALTERACAO write FACC_DATAHORAALTERACAO;
    const ACC_DATAHORAALTERACAO_Name = 'ACC_DATAHORAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO_INTEGRACAO_GESTOR', ftInteger)]
    [Dictionary('PES_CODIGO_INTEGRACAO_GESTOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO_INTEGRACAO_GESTOR: Integer read FPES_CODIGO_INTEGRACAO_GESTOR write FPES_CODIGO_INTEGRACAO_GESTOR;
    const PES_CODIGO_INTEGRACAO_GESTOR_Name = 'PES_CODIGO_INTEGRACAO_GESTOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoACCOUNT)

end.
