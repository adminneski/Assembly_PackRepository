unit express.dbo.account;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  // ORMbr
  ormbr.types.blob,
  ormbr.types.lazy,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes,
  dbebr.factory.interfaces,
  Core.Register, 
  Model.Base;  

type
  [Entity]
  [Table('ACCOUNT', 'SELECT * FROM ACCOUNT')]
  [PrimaryKey('ACC_CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TACCOUNT = class(TModelBase)
  private
    { Private declarations } 
    FACC_CODIGO: Integer;
    FACC_USER: String;
    FACC_FULLNAME: Nullable<String>;
    FACC_PASSWORD: String;
    FACC_CPF_CNPJ: Nullable<String>;
    FACC_DDD_CELULAR: Nullable<String>;
    FACC_RECOVERYEMAIL: Nullable<String>;
    FACC_DESCRIPTION: Nullable<String>;
    FACC_PROFILEPICTURE: Nullable<String>;
    FACC_ACTIVATION: Nullable<String>;
    FACC_ACTIVATIONCODE: Nullable<Integer>;
    FACC_LASTCOMPANYACCESSED: Nullable<Integer>;
    FACC_DATACADASTRO: TDateTime;
    FACC_DATANASCIMENTO: Nullable<TDateTime>;
    FACC_FUNCIONARIONESKI: Nullable<String>;
    FACC_ADMINISTRATIVONESKI: Nullable<String>;
    FACC_VENDEDORNESKI: Nullable<String>;
    FACC_FRANQUIANESKI: Nullable<String>;
    FACC_CODIGO_RELACIONAMENTO: Nullable<Integer>;
    FACC_CODIGO_VENDEDOR: Nullable<Integer>;
    FACC_CODIGO_FRANQUIA: Nullable<Integer>;
    FACC_DATAHORAALTERACAO: TDateTime;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;

    [Restrictions([NotNull])]
    [Column('ACC_USER', ftString, 250)]
    [Dictionary('ACC_USER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_USER: String read FACC_USER write FACC_USER;

    [Column('ACC_FULLNAME', ftString, 100)]
    [Dictionary('ACC_FULLNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FULLNAME: Nullable<String> read FACC_FULLNAME write FACC_FULLNAME;

    [Restrictions([NotNull])]
    [Column('ACC_PASSWORD', ftString, 50)]
    [Dictionary('ACC_PASSWORD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_PASSWORD: String read FACC_PASSWORD write FACC_PASSWORD;

    [Column('ACC_CPF_CNPJ', ftString, 14)]
    [Dictionary('ACC_CPF_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_CPF_CNPJ: Nullable<String> read FACC_CPF_CNPJ write FACC_CPF_CNPJ;

    [Column('ACC_DDD_CELULAR', ftString, 12)]
    [Dictionary('ACC_DDD_CELULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_DDD_CELULAR: Nullable<String> read FACC_DDD_CELULAR write FACC_DDD_CELULAR;

    [Column('ACC_RECOVERYEMAIL', ftString, 250)]
    [Dictionary('ACC_RECOVERYEMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_RECOVERYEMAIL: Nullable<String> read FACC_RECOVERYEMAIL write FACC_RECOVERYEMAIL;

    [Column('ACC_DESCRIPTION', ftString, 500)]
    [Dictionary('ACC_DESCRIPTION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_DESCRIPTION: Nullable<String> read FACC_DESCRIPTION write FACC_DESCRIPTION;

    [Column('ACC_PROFILEPICTURE', ftString, 300)]
    [Dictionary('ACC_PROFILEPICTURE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_PROFILEPICTURE: Nullable<String> read FACC_PROFILEPICTURE write FACC_PROFILEPICTURE;

    [Column('ACC_ACTIVATION', ftString, 1)]
    [Dictionary('ACC_ACTIVATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_ACTIVATION: Nullable<String> read FACC_ACTIVATION write FACC_ACTIVATION;

    [Column('ACC_ACTIVATIONCODE', ftInteger)]
    [Dictionary('ACC_ACTIVATIONCODE', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_ACTIVATIONCODE: Nullable<Integer> read FACC_ACTIVATIONCODE write FACC_ACTIVATIONCODE;

    [Column('ACC_LASTCOMPANYACCESSED', ftInteger)]
    [Dictionary('ACC_LASTCOMPANYACCESSED', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_LASTCOMPANYACCESSED: Nullable<Integer> read FACC_LASTCOMPANYACCESSED write FACC_LASTCOMPANYACCESSED;

    [Restrictions([NotNull])]
    [Column('ACC_DATACADASTRO', ftDateTime)]
    [Dictionary('ACC_DATACADASTRO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ACC_DATACADASTRO: TDateTime read FACC_DATACADASTRO write FACC_DATACADASTRO;

    [Column('ACC_DATANASCIMENTO', ftDateTime)]
    [Dictionary('ACC_DATANASCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_DATANASCIMENTO: Nullable<TDateTime> read FACC_DATANASCIMENTO write FACC_DATANASCIMENTO;

    [Column('ACC_FUNCIONARIONESKI', ftString, 1)]
    [Dictionary('ACC_FUNCIONARIONESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FUNCIONARIONESKI: Nullable<String> read FACC_FUNCIONARIONESKI write FACC_FUNCIONARIONESKI;

    [Column('ACC_ADMINISTRATIVONESKI', ftString, 1)]
    [Dictionary('ACC_ADMINISTRATIVONESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_ADMINISTRATIVONESKI: Nullable<String> read FACC_ADMINISTRATIVONESKI write FACC_ADMINISTRATIVONESKI;

    [Column('ACC_VENDEDORNESKI', ftString, 1)]
    [Dictionary('ACC_VENDEDORNESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_VENDEDORNESKI: Nullable<String> read FACC_VENDEDORNESKI write FACC_VENDEDORNESKI;

    [Column('ACC_FRANQUIANESKI', ftString, 1)]
    [Dictionary('ACC_FRANQUIANESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FRANQUIANESKI: Nullable<String> read FACC_FRANQUIANESKI write FACC_FRANQUIANESKI;

    [Column('ACC_CODIGO_RELACIONAMENTO', ftInteger)]
    [Dictionary('ACC_CODIGO_RELACIONAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_CODIGO_RELACIONAMENTO: Nullable<Integer> read FACC_CODIGO_RELACIONAMENTO write FACC_CODIGO_RELACIONAMENTO;

    [Column('ACC_CODIGO_VENDEDOR', ftInteger)]
    [Dictionary('ACC_CODIGO_VENDEDOR', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_CODIGO_VENDEDOR: Nullable<Integer> read FACC_CODIGO_VENDEDOR write FACC_CODIGO_VENDEDOR;

    [Column('ACC_CODIGO_FRANQUIA', ftInteger)]
    [Dictionary('ACC_CODIGO_FRANQUIA', 'Mensagem de validação', '', '', '', taCenter)]
    property ACC_CODIGO_FRANQUIA: Nullable<Integer> read FACC_CODIGO_FRANQUIA write FACC_CODIGO_FRANQUIA;

    [Restrictions([NotNull])]
    [Column('ACC_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('ACC_DATAHORAALTERACAO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property ACC_DATAHORAALTERACAO: TDateTime read FACC_DATAHORAALTERACAO write FACC_DATAHORAALTERACAO;
  end;

implementation

uses ormbr.container.objectset; 

{ TACCOUNT } 

procedure TACCOUNT.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TACCOUNT>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TACCOUNT>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TACCOUNT(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TACCOUNT);
  TCoreRegisterClass.RegisterEntity(TACCOUNT);

end.
