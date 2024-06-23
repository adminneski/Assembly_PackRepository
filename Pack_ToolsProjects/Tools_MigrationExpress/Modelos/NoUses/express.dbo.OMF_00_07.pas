unit express.dbo.omf_00_07;

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
  [Table('OMF_00_07', 'SELECT * FROM OMF_00_07')]
  [PrimaryKey('OMF_ID', NotInc, NoSort, False, 'Chave primária')]
  TOMF_00_07 = class(TModelBase)
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: String;
    FOMF_TIPOMERCADORIA: Nullable<String>;
    FPRI_CODIGO: Nullable<Integer>;
    FOMF_NIVELCONTA: Nullable<String>;
    FOMF_TIPOCONTA: Nullable<String>;
    FOMF_CODIGOCONTA: Nullable<String>;
    FOMF_NOMECONTA: Nullable<String>;
    FOMF_TOTALNUMEROPARCELAS: Nullable<Integer>;
    FOMF_CODIGONATUREZACONTA: Nullable<String>;
    FOMF_CODIGOCENTROCUSTO: Nullable<String>;
    FOMF_NOMECENTROCUSTO: Nullable<String>;
    FOMF_TIPOEMITENTE: Nullable<String>;
    FOMF_DATAALTERACAO: Nullable<TDateTime>;
    FOMF_INTEGRACAOERP: Nullable<String>;
    FOMF_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Column('OMF_TIPOMERCADORIA', ftString, 1)]
    [Dictionary('OMF_TIPOMERCADORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPOMERCADORIA: Nullable<String> read FOMF_TIPOMERCADORIA write FOMF_TIPOMERCADORIA;

    [Column('PRI_CODIGO', ftInteger)]
    [Dictionary('PRI_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRI_CODIGO: Nullable<Integer> read FPRI_CODIGO write FPRI_CODIGO;

    [Column('OMF_NIVELCONTA', ftString, 1)]
    [Dictionary('OMF_NIVELCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NIVELCONTA: Nullable<String> read FOMF_NIVELCONTA write FOMF_NIVELCONTA;

    [Column('OMF_TIPOCONTA', ftString, 1)]
    [Dictionary('OMF_TIPOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPOCONTA: Nullable<String> read FOMF_TIPOCONTA write FOMF_TIPOCONTA;

    [Column('OMF_CODIGOCONTA', ftString, 60)]
    [Dictionary('OMF_CODIGOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CODIGOCONTA: Nullable<String> read FOMF_CODIGOCONTA write FOMF_CODIGOCONTA;

    [Column('OMF_NOMECONTA', ftString, 60)]
    [Dictionary('OMF_NOMECONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NOMECONTA: Nullable<String> read FOMF_NOMECONTA write FOMF_NOMECONTA;

    [Column('OMF_TOTALNUMEROPARCELAS', ftInteger)]
    [Dictionary('OMF_TOTALNUMEROPARCELAS', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_TOTALNUMEROPARCELAS: Nullable<Integer> read FOMF_TOTALNUMEROPARCELAS write FOMF_TOTALNUMEROPARCELAS;

    [Column('OMF_CODIGONATUREZACONTA', ftString, 2)]
    [Dictionary('OMF_CODIGONATUREZACONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CODIGONATUREZACONTA: Nullable<String> read FOMF_CODIGONATUREZACONTA write FOMF_CODIGONATUREZACONTA;

    [Column('OMF_CODIGOCENTROCUSTO', ftString, 60)]
    [Dictionary('OMF_CODIGOCENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CODIGOCENTROCUSTO: Nullable<String> read FOMF_CODIGOCENTROCUSTO write FOMF_CODIGOCENTROCUSTO;

    [Column('OMF_NOMECENTROCUSTO', ftString, 60)]
    [Dictionary('OMF_NOMECENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NOMECENTROCUSTO: Nullable<String> read FOMF_NOMECENTROCUSTO write FOMF_NOMECENTROCUSTO;

    [Column('OMF_TIPOEMITENTE', ftString, 1)]
    [Dictionary('OMF_TIPOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPOEMITENTE: Nullable<String> read FOMF_TIPOEMITENTE write FOMF_TIPOEMITENTE;

    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAALTERACAO: Nullable<TDateTime> read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;

    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: Nullable<String> read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;

    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_ID_OLD: Nullable<Integer> read FOMF_ID_OLD write FOMF_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TOMF_00_07 } 

procedure TOMF_00_07.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TOMF_00_07>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TOMF_00_07>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TOMF_00_07(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TOMF_00_07);
  TCoreRegisterClass.RegisterEntity(TOMF_00_07);

end.
