unit express.dbo.alg_00_01;

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
  [Table('ALG_00_01', 'SELECT * FROM ALG_00_01')]
  [PrimaryKey('ALG_01_ID', NotInc, NoSort, False, 'Chave primária')]
  TALG_00_01 = class(TModelBase)
  private
    { Private declarations } 
    FALG_01_ID: Integer;
    FCOM_CODIGO: String;
    FALG_ID: Integer;
    FPRO_CODIGO: Integer;
    FTAB_CODIGO: Nullable<Integer>;
    FALG_DESCRICAO: Nullable<String>;
    FALG_QTDPEDIDA: Double;
    FALG_PRECOUNITARIO: Double;
    FALG_TOTALPRECO: Nullable<Double>;
    FALG_TOTALPRECOLIQUIDO: Nullable<Double>;
    FALG_TOTALDESCTOAVULSOITEM: Nullable<Double>;
    FALG_DATAALTERACAO: TDateTime;
    FALG_STATUS: Nullable<String>;
    FALG_DATARETIRADAITEM: Nullable<TDateTime>;
    FALG_DATADEVOLUCAOITEM: Nullable<TDateTime>;
    FALG_OBSERVACAOITEM: Nullable<String>;
    FALG_01_ID_OLD: Nullable<Integer>;
    FALG_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('ALG_01_ID', ftInteger)]
    [Dictionary('ALG_01_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_01_ID: Integer read FALG_01_ID write FALG_01_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('ALG_ID', ftInteger)]
    [Dictionary('ALG_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_ID: Integer read FALG_ID write FALG_ID;

    [Restrictions([NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;

    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property TAB_CODIGO: Nullable<Integer> read FTAB_CODIGO write FTAB_CODIGO;

    [Column('ALG_DESCRICAO', ftString, 100)]
    [Dictionary('ALG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_DESCRICAO: Nullable<String> read FALG_DESCRICAO write FALG_DESCRICAO;

    [Restrictions([NotNull])]
    [Column('ALG_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('ALG_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_QTDPEDIDA: Double read FALG_QTDPEDIDA write FALG_QTDPEDIDA;

    [Restrictions([NotNull])]
    [Column('ALG_PRECOUNITARIO', ftBCD)]
    [Dictionary('ALG_PRECOUNITARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_PRECOUNITARIO: Double read FALG_PRECOUNITARIO write FALG_PRECOUNITARIO;

    [Column('ALG_TOTALPRECO', ftBCD)]
    [Dictionary('ALG_TOTALPRECO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALPRECO: Nullable<Double> read FALG_TOTALPRECO write FALG_TOTALPRECO;

    [Column('ALG_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('ALG_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALPRECOLIQUIDO: Nullable<Double> read FALG_TOTALPRECOLIQUIDO write FALG_TOTALPRECOLIQUIDO;

    [Column('ALG_TOTALDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('ALG_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALDESCTOAVULSOITEM: Nullable<Double> read FALG_TOTALDESCTOAVULSOITEM write FALG_TOTALDESCTOAVULSOITEM;

    [Restrictions([NotNull])]
    [Column('ALG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ALG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAALTERACAO: TDateTime read FALG_DATAALTERACAO write FALG_DATAALTERACAO;

    [Column('ALG_STATUS', ftString, 1)]
    [Dictionary('ALG_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_STATUS: Nullable<String> read FALG_STATUS write FALG_STATUS;

    [Column('ALG_DATARETIRADAITEM', ftDateTime)]
    [Dictionary('ALG_DATARETIRADAITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATARETIRADAITEM: Nullable<TDateTime> read FALG_DATARETIRADAITEM write FALG_DATARETIRADAITEM;

    [Column('ALG_DATADEVOLUCAOITEM', ftDateTime)]
    [Dictionary('ALG_DATADEVOLUCAOITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATADEVOLUCAOITEM: Nullable<TDateTime> read FALG_DATADEVOLUCAOITEM write FALG_DATADEVOLUCAOITEM;

    [Column('ALG_OBSERVACAOITEM', ftString, 5000)]
    [Dictionary('ALG_OBSERVACAOITEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_OBSERVACAOITEM: Nullable<String> read FALG_OBSERVACAOITEM write FALG_OBSERVACAOITEM;

    [Column('ALG_01_ID_OLD', ftInteger)]
    [Dictionary('ALG_01_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_01_ID_OLD: Nullable<Integer> read FALG_01_ID_OLD write FALG_01_ID_OLD;

    [Column('ALG_ID_OLD', ftInteger)]
    [Dictionary('ALG_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_ID_OLD: Nullable<Integer> read FALG_ID_OLD write FALG_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TALG_00_01 } 

procedure TALG_00_01.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TALG_00_01>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TALG_00_01>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TALG_00_01(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TALG_00_01);
  TCoreRegisterClass.RegisterEntity(TALG_00_01);

end.
