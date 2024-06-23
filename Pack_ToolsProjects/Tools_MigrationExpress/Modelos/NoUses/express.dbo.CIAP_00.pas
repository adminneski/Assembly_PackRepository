unit express.dbo.ciap_00;

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
  [Table('CIAP_00', 'SELECT * FROM CIAP_00')]
  [PrimaryKey('CIAP_ID', NotInc, NoSort, False, 'Chave primária')]
  TCIAP_00 = class(TModelBase)
  private
    { Private declarations } 
    FCIAP_ID: Integer;
    FCOM_CODIGO: String;
    FPRO_CODIGO: Integer;
    FPRI_CODIGO: Nullable<Integer>;
    FCIAP_TIPOMERCADORIA: Nullable<String>;
    FCIAP_NIVELCONTA: Nullable<String>;
    FCIAP_TIPOCONTA: Nullable<String>;
    FCIAP_CODIGOCONTA: Nullable<String>;
    FCIAP_NOMECONTA: Nullable<String>;
    FCIAP_TOTALNUMEROPARCELAS: Nullable<Integer>;
    FCIAP_CODIGONATUREZACONTA: Nullable<String>;
    FCIAP_CODIGOCENTROCUSTO: Nullable<String>;
    FCIAP_NOMECENTROCUSTO: Nullable<String>;
    FCIAP_VIDAUTILBEM: Nullable<Integer>;
    FCIAP_FUNCAOBEM: Nullable<String>;
    FCIAP_TIPOEMITENTE: Nullable<String>;
    FPES_CODIGO: Nullable<Integer>;
    FMNF_CODIGO: Nullable<String>;
    FCIAP_SERIE: Nullable<String>;
    FCIAP_NOTAFISCAL: Nullable<String>;
    FCIAP_CHAVEACESSONF: Nullable<String>;
    FCIAP_DATAEMISSAONF: Nullable<TDateTime>;
    FCIAP_DATAINCLUSAOCONTA: Nullable<TDateTime>;
    FCIAP_DESATIVADO: Nullable<String>;
    FCIAP_DATAALTERACAO: Nullable<TDateTime>;
    FCIAP_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('CIAP_ID', ftInteger)]
    [Dictionary('CIAP_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_ID: Integer read FCIAP_ID write FCIAP_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;

    [Column('PRI_CODIGO', ftInteger)]
    [Dictionary('PRI_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRI_CODIGO: Nullable<Integer> read FPRI_CODIGO write FPRI_CODIGO;

    [Column('CIAP_TIPOMERCADORIA', ftString, 1)]
    [Dictionary('CIAP_TIPOMERCADORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOMERCADORIA: Nullable<String> read FCIAP_TIPOMERCADORIA write FCIAP_TIPOMERCADORIA;

    [Column('CIAP_NIVELCONTA', ftString, 1)]
    [Dictionary('CIAP_NIVELCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NIVELCONTA: Nullable<String> read FCIAP_NIVELCONTA write FCIAP_NIVELCONTA;

    [Column('CIAP_TIPOCONTA', ftString, 1)]
    [Dictionary('CIAP_TIPOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOCONTA: Nullable<String> read FCIAP_TIPOCONTA write FCIAP_TIPOCONTA;

    [Column('CIAP_CODIGOCONTA', ftString, 60)]
    [Dictionary('CIAP_CODIGOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CODIGOCONTA: Nullable<String> read FCIAP_CODIGOCONTA write FCIAP_CODIGOCONTA;

    [Column('CIAP_NOMECONTA', ftString, 60)]
    [Dictionary('CIAP_NOMECONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOMECONTA: Nullable<String> read FCIAP_NOMECONTA write FCIAP_NOMECONTA;

    [Column('CIAP_TOTALNUMEROPARCELAS', ftInteger)]
    [Dictionary('CIAP_TOTALNUMEROPARCELAS', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_TOTALNUMEROPARCELAS: Nullable<Integer> read FCIAP_TOTALNUMEROPARCELAS write FCIAP_TOTALNUMEROPARCELAS;

    [Column('CIAP_CODIGONATUREZACONTA', ftString, 2)]
    [Dictionary('CIAP_CODIGONATUREZACONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CODIGONATUREZACONTA: Nullable<String> read FCIAP_CODIGONATUREZACONTA write FCIAP_CODIGONATUREZACONTA;

    [Column('CIAP_CODIGOCENTROCUSTO', ftString, 60)]
    [Dictionary('CIAP_CODIGOCENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CODIGOCENTROCUSTO: Nullable<String> read FCIAP_CODIGOCENTROCUSTO write FCIAP_CODIGOCENTROCUSTO;

    [Column('CIAP_NOMECENTROCUSTO', ftString, 60)]
    [Dictionary('CIAP_NOMECENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOMECENTROCUSTO: Nullable<String> read FCIAP_NOMECENTROCUSTO write FCIAP_NOMECENTROCUSTO;

    [Column('CIAP_VIDAUTILBEM', ftInteger)]
    [Dictionary('CIAP_VIDAUTILBEM', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_VIDAUTILBEM: Nullable<Integer> read FCIAP_VIDAUTILBEM write FCIAP_VIDAUTILBEM;

    [Column('CIAP_FUNCAOBEM', ftString, 60)]
    [Dictionary('CIAP_FUNCAOBEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_FUNCAOBEM: Nullable<String> read FCIAP_FUNCAOBEM write FCIAP_FUNCAOBEM;

    [Column('CIAP_TIPOEMITENTE', ftString, 1)]
    [Dictionary('CIAP_TIPOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOEMITENTE: Nullable<String> read FCIAP_TIPOEMITENTE write FCIAP_TIPOEMITENTE;

    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGO: Nullable<Integer> read FPES_CODIGO write FPES_CODIGO;

    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: Nullable<String> read FMNF_CODIGO write FMNF_CODIGO;

    [Column('CIAP_SERIE', ftString, 3)]
    [Dictionary('CIAP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_SERIE: Nullable<String> read FCIAP_SERIE write FCIAP_SERIE;

    [Column('CIAP_NOTAFISCAL', ftString, 9)]
    [Dictionary('CIAP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOTAFISCAL: Nullable<String> read FCIAP_NOTAFISCAL write FCIAP_NOTAFISCAL;

    [Column('CIAP_CHAVEACESSONF', ftString, 44)]
    [Dictionary('CIAP_CHAVEACESSONF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CHAVEACESSONF: Nullable<String> read FCIAP_CHAVEACESSONF write FCIAP_CHAVEACESSONF;

    [Column('CIAP_DATAEMISSAONF', ftDateTime)]
    [Dictionary('CIAP_DATAEMISSAONF', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAEMISSAONF: Nullable<TDateTime> read FCIAP_DATAEMISSAONF write FCIAP_DATAEMISSAONF;

    [Column('CIAP_DATAINCLUSAOCONTA', ftDateTime)]
    [Dictionary('CIAP_DATAINCLUSAOCONTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAINCLUSAOCONTA: Nullable<TDateTime> read FCIAP_DATAINCLUSAOCONTA write FCIAP_DATAINCLUSAOCONTA;

    [Column('CIAP_DESATIVADO', ftString, 1)]
    [Dictionary('CIAP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_DESATIVADO: Nullable<String> read FCIAP_DESATIVADO write FCIAP_DESATIVADO;

    [Column('CIAP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CIAP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAALTERACAO: Nullable<TDateTime> read FCIAP_DATAALTERACAO write FCIAP_DATAALTERACAO;

    [Column('CIAP_ID_OLD', ftInteger)]
    [Dictionary('CIAP_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_ID_OLD: Nullable<Integer> read FCIAP_ID_OLD write FCIAP_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TCIAP_00 } 

procedure TCIAP_00.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TCIAP_00>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TCIAP_00>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TCIAP_00(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TCIAP_00);
  TCoreRegisterClass.RegisterEntity(TCIAP_00);

end.
