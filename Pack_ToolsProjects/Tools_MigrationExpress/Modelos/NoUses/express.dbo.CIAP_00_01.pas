unit express.dbo.ciap_00_01;

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
  [Table('CIAP_00_01', 'SELECT * FROM CIAP_00_01')]
  [PrimaryKey('CIAP_01_ID', NotInc, NoSort, False, 'Chave primária')]
  TCIAP_00_01 = class(TModelBase)
  private
    { Private declarations } 
    FCIAP_01_ID: Integer;
    FCIAP_ID: Integer;
    FCOM_CODIGO: Nullable<String>;
    FCIAP_DATAMOVTO: Nullable<TDateTime>;
    FCIAP_TIPOMOVTO: Nullable<String>;
    FCIAP_COMPETENCIA: Nullable<String>;
    FCIAP_NOTAFISCAL: Nullable<String>;
    FCIAP_VALORICMSFRETE: Nullable<Double>;
    FCIAP_VALORICMSOPEPROPRIA: Nullable<Double>;
    FCIAP_VALORICMSOPESUBTRIBUTARIA: Nullable<Double>;
    FCIAP_VALORICMSDIFALIQUOTA: Nullable<Double>;
    FCIAP_NUMEROPARCELA: Nullable<Integer>;
    FCIAP_VALORPARCELAICMSAPROPRIACAO: Nullable<Double>;
    FCIAP_DATAALTERACAO: Nullable<TDateTime>;
    FCIAP_01_ID_OLD: Nullable<Integer>;
    FCIAP_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('CIAP_01_ID', ftInteger)]
    [Dictionary('CIAP_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_01_ID: Integer read FCIAP_01_ID write FCIAP_01_ID;

    [Restrictions([NotNull])]
    [Column('CIAP_ID', ftInteger)]
    [Dictionary('CIAP_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_ID: Integer read FCIAP_ID write FCIAP_ID;

    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: Nullable<String> read FCOM_CODIGO write FCOM_CODIGO;

    [Column('CIAP_DATAMOVTO', ftDateTime)]
    [Dictionary('CIAP_DATAMOVTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAMOVTO: Nullable<TDateTime> read FCIAP_DATAMOVTO write FCIAP_DATAMOVTO;

    [Column('CIAP_TIPOMOVTO', ftString, 2)]
    [Dictionary('CIAP_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOMOVTO: Nullable<String> read FCIAP_TIPOMOVTO write FCIAP_TIPOMOVTO;

    [Column('CIAP_COMPETENCIA', ftString, 6)]
    [Dictionary('CIAP_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_COMPETENCIA: Nullable<String> read FCIAP_COMPETENCIA write FCIAP_COMPETENCIA;

    [Column('CIAP_NOTAFISCAL', ftString, 9)]
    [Dictionary('CIAP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOTAFISCAL: Nullable<String> read FCIAP_NOTAFISCAL write FCIAP_NOTAFISCAL;

    [Column('CIAP_VALORICMSFRETE', ftBCD)]
    [Dictionary('CIAP_VALORICMSFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSFRETE: Nullable<Double> read FCIAP_VALORICMSFRETE write FCIAP_VALORICMSFRETE;

    [Column('CIAP_VALORICMSOPEPROPRIA', ftBCD)]
    [Dictionary('CIAP_VALORICMSOPEPROPRIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSOPEPROPRIA: Nullable<Double> read FCIAP_VALORICMSOPEPROPRIA write FCIAP_VALORICMSOPEPROPRIA;

    [Column('CIAP_VALORICMSOPESUBTRIBUTARIA', ftBCD)]
    [Dictionary('CIAP_VALORICMSOPESUBTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSOPESUBTRIBUTARIA: Nullable<Double> read FCIAP_VALORICMSOPESUBTRIBUTARIA write FCIAP_VALORICMSOPESUBTRIBUTARIA;

    [Column('CIAP_VALORICMSDIFALIQUOTA', ftBCD)]
    [Dictionary('CIAP_VALORICMSDIFALIQUOTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSDIFALIQUOTA: Nullable<Double> read FCIAP_VALORICMSDIFALIQUOTA write FCIAP_VALORICMSDIFALIQUOTA;

    [Column('CIAP_NUMEROPARCELA', ftInteger)]
    [Dictionary('CIAP_NUMEROPARCELA', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_NUMEROPARCELA: Nullable<Integer> read FCIAP_NUMEROPARCELA write FCIAP_NUMEROPARCELA;

    [Column('CIAP_VALORPARCELAICMSAPROPRIACAO', ftBCD)]
    [Dictionary('CIAP_VALORPARCELAICMSAPROPRIACAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORPARCELAICMSAPROPRIACAO: Nullable<Double> read FCIAP_VALORPARCELAICMSAPROPRIACAO write FCIAP_VALORPARCELAICMSAPROPRIACAO;

    [Column('CIAP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CIAP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAALTERACAO: Nullable<TDateTime> read FCIAP_DATAALTERACAO write FCIAP_DATAALTERACAO;

    [Column('CIAP_01_ID_OLD', ftInteger)]
    [Dictionary('CIAP_01_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_01_ID_OLD: Nullable<Integer> read FCIAP_01_ID_OLD write FCIAP_01_ID_OLD;

    [Column('CIAP_ID_OLD', ftInteger)]
    [Dictionary('CIAP_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_ID_OLD: Nullable<Integer> read FCIAP_ID_OLD write FCIAP_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TCIAP_00_01 } 

procedure TCIAP_00_01.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TCIAP_00_01>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TCIAP_00_01>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TCIAP_00_01(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TCIAP_00_01);
  TCoreRegisterClass.RegisterEntity(TCIAP_00_01);

end.
