unit express.dbo.company_license;

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
  [Table('COMPANY_LICENSE', 'SELECT * FROM COMPANY_LICENSE')]
  [PrimaryKey('COM_01_ID', NotInc, NoSort, False, 'Chave primária')]
  TCOMPANY_LICENSE = class(TModelBase)
  private
    { Private declarations } 
    FCOM_01_ID: Integer;
    FCOM_CODIGO: Nullable<Integer>;
    FCOM_CNPJ_CPF: String;
    FSER_CODIGO: Integer;
    FSER_CHAVE: Nullable<String>;
    FCOM_VALORCONTRATO: Double;
    FCOM_DATACONTRATO: TDateTime;
    FCOM_DIASVALIDADECONTRATO: Integer;
    FCOM_DATAATIVACAOCONTRATO: TDateTime;
    FCOM_DATAHORAULTIMOACESSO: Nullable<TDateTime>;
    FCOM_INTEGRACAO: Nullable<String>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('COM_01_ID', ftInteger)]
    [Dictionary('COM_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property COM_01_ID: Integer read FCOM_01_ID write FCOM_01_ID;

    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property COM_CODIGO: Nullable<Integer> read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;

    [Restrictions([NotNull])]
    [Column('SER_CODIGO', ftInteger)]
    [Dictionary('SER_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property SER_CODIGO: Integer read FSER_CODIGO write FSER_CODIGO;

    [Column('SER_CHAVE', ftString, 30)]
    [Dictionary('SER_CHAVE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SER_CHAVE: Nullable<String> read FSER_CHAVE write FSER_CHAVE;

    [Restrictions([NotNull])]
    [Column('COM_VALORCONTRATO', ftBCD)]
    [Dictionary('COM_VALORCONTRATO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property COM_VALORCONTRATO: Double read FCOM_VALORCONTRATO write FCOM_VALORCONTRATO;

    [Restrictions([NotNull])]
    [Column('COM_DATACONTRATO', ftDateTime)]
    [Dictionary('COM_DATACONTRATO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property COM_DATACONTRATO: TDateTime read FCOM_DATACONTRATO write FCOM_DATACONTRATO;

    [Restrictions([NotNull])]
    [Column('COM_DIASVALIDADECONTRATO', ftInteger)]
    [Dictionary('COM_DIASVALIDADECONTRATO', 'Mensagem de validação', '', '', '', taCenter)]
    property COM_DIASVALIDADECONTRATO: Integer read FCOM_DIASVALIDADECONTRATO write FCOM_DIASVALIDADECONTRATO;

    [Restrictions([NotNull])]
    [Column('COM_DATAATIVACAOCONTRATO', ftDateTime)]
    [Dictionary('COM_DATAATIVACAOCONTRATO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property COM_DATAATIVACAOCONTRATO: TDateTime read FCOM_DATAATIVACAOCONTRATO write FCOM_DATAATIVACAOCONTRATO;

    [Column('COM_DATAHORAULTIMOACESSO', ftDateTime)]
    [Dictionary('COM_DATAHORAULTIMOACESSO', 'Mensagem de validação', '', '', '', taCenter)]
    property COM_DATAHORAULTIMOACESSO: Nullable<TDateTime> read FCOM_DATAHORAULTIMOACESSO write FCOM_DATAHORAULTIMOACESSO;

    [Column('COM_INTEGRACAO', ftString, 30)]
    [Dictionary('COM_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_INTEGRACAO: Nullable<String> read FCOM_INTEGRACAO write FCOM_INTEGRACAO;
  end;

implementation

uses ormbr.container.objectset; 

{ TCOMPANY_LICENSE } 

procedure TCOMPANY_LICENSE.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TCOMPANY_LICENSE>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TCOMPANY_LICENSE>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TCOMPANY_LICENSE(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TCOMPANY_LICENSE);
  TCoreRegisterClass.RegisterEntity(TCOMPANY_LICENSE);

end.
