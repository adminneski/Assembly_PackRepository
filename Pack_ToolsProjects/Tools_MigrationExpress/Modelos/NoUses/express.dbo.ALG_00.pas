unit express.dbo.alg_00;

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
  [Table('ALG_00', 'SELECT * FROM ALG_00')]
  [PrimaryKey('ALG_ID', NotInc, NoSort, False, 'Chave primária')]
  TALG_00 = class(TModelBase)
  private
    { Private declarations } 
    FALG_ID: Integer;
    FCOM_CODIGO: String;
    FALG_NUMERODOCTO: String;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FFPG_CODIGO: Nullable<Integer>;
    FPRZ_CODIGO: Nullable<Integer>;
    FALG_DATAPROVA: Nullable<TDateTime>;
    FALG_DATARETIRADA: Nullable<TDateTime>;
    FALG_DATAUTILIZACAO: Nullable<TDateTime>;
    FALG_DATADEVOLUCAO: Nullable<TDateTime>;
    FALG_TOTALLIQUIDO: Double;
    FALG_TOTALPRODUTOS: Double;
    FALG_TOTALDESCTOAVULSO: Double;
    FALG_TOTALQTDPEDIDA: Nullable<Double>;
    FALG_PERCENTUALDESCTOAVULSO: Nullable<Double>;
    FALG_OBSERVACAO: Nullable<String>;
    FPLC_CODIGO: Nullable<Integer>;
    FCCU_CODIGO: Nullable<Integer>;
    FALG_DATALANCAMENTO: TDateTime;
    FALG_DATAALTERACAO: TDateTime;
    FALG_CANCELADO: Nullable<String>;
    FALG_PROCESSADO: Nullable<String>;
    FALG_DATACANCELAMENTO: Nullable<TDateTime>;
    FALG_OBSERVACAOCANCELAMENTO: Nullable<String>;
    FALG_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('ALG_ID', ftInteger)]
    [Dictionary('ALG_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_ID: Integer read FALG_ID write FALG_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('ALG_NUMERODOCTO', ftString, 10)]
    [Dictionary('ALG_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_NUMERODOCTO: String read FALG_NUMERODOCTO write FALG_NUMERODOCTO;

    [Restrictions([NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;

    [Restrictions([NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;

    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property FPG_CODIGO: Nullable<Integer> read FFPG_CODIGO write FFPG_CODIGO;

    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRZ_CODIGO: Nullable<Integer> read FPRZ_CODIGO write FPRZ_CODIGO;

    [Column('ALG_DATAPROVA', ftDateTime)]
    [Dictionary('ALG_DATAPROVA', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATAPROVA: Nullable<TDateTime> read FALG_DATAPROVA write FALG_DATAPROVA;

    [Column('ALG_DATARETIRADA', ftDateTime)]
    [Dictionary('ALG_DATARETIRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATARETIRADA: Nullable<TDateTime> read FALG_DATARETIRADA write FALG_DATARETIRADA;

    [Column('ALG_DATAUTILIZACAO', ftDateTime)]
    [Dictionary('ALG_DATAUTILIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATAUTILIZACAO: Nullable<TDateTime> read FALG_DATAUTILIZACAO write FALG_DATAUTILIZACAO;

    [Column('ALG_DATADEVOLUCAO', ftDateTime)]
    [Dictionary('ALG_DATADEVOLUCAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATADEVOLUCAO: Nullable<TDateTime> read FALG_DATADEVOLUCAO write FALG_DATADEVOLUCAO;

    [Restrictions([NotNull])]
    [Column('ALG_TOTALLIQUIDO', ftBCD)]
    [Dictionary('ALG_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALLIQUIDO: Double read FALG_TOTALLIQUIDO write FALG_TOTALLIQUIDO;

    [Restrictions([NotNull])]
    [Column('ALG_TOTALPRODUTOS', ftBCD)]
    [Dictionary('ALG_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALPRODUTOS: Double read FALG_TOTALPRODUTOS write FALG_TOTALPRODUTOS;

    [Restrictions([NotNull])]
    [Column('ALG_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('ALG_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALDESCTOAVULSO: Double read FALG_TOTALDESCTOAVULSO write FALG_TOTALDESCTOAVULSO;

    [Column('ALG_TOTALQTDPEDIDA', ftBCD)]
    [Dictionary('ALG_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALQTDPEDIDA: Nullable<Double> read FALG_TOTALQTDPEDIDA write FALG_TOTALQTDPEDIDA;

    [Column('ALG_PERCENTUALDESCTOAVULSO', ftBCD, 18, 4)]
    [Dictionary('ALG_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_PERCENTUALDESCTOAVULSO: Nullable<Double> read FALG_PERCENTUALDESCTOAVULSO write FALG_PERCENTUALDESCTOAVULSO;

    [Column('ALG_OBSERVACAO', ftString, 5000)]
    [Dictionary('ALG_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_OBSERVACAO: Nullable<String> read FALG_OBSERVACAO write FALG_OBSERVACAO;

    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PLC_CODIGO: Nullable<Integer> read FPLC_CODIGO write FPLC_CODIGO;

    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCU_CODIGO: Nullable<Integer> read FCCU_CODIGO write FCCU_CODIGO;

    [Restrictions([NotNull])]
    [Column('ALG_DATALANCAMENTO', ftDateTime)]
    [Dictionary('ALG_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATALANCAMENTO: TDateTime read FALG_DATALANCAMENTO write FALG_DATALANCAMENTO;

    [Restrictions([NotNull])]
    [Column('ALG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ALG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAALTERACAO: TDateTime read FALG_DATAALTERACAO write FALG_DATAALTERACAO;

    [Column('ALG_CANCELADO', ftString, 1)]
    [Dictionary('ALG_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_CANCELADO: Nullable<String> read FALG_CANCELADO write FALG_CANCELADO;

    [Column('ALG_PROCESSADO', ftString, 1)]
    [Dictionary('ALG_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_PROCESSADO: Nullable<String> read FALG_PROCESSADO write FALG_PROCESSADO;

    [Column('ALG_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('ALG_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATACANCELAMENTO: Nullable<TDateTime> read FALG_DATACANCELAMENTO write FALG_DATACANCELAMENTO;

    [Column('ALG_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('ALG_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_OBSERVACAOCANCELAMENTO: Nullable<String> read FALG_OBSERVACAOCANCELAMENTO write FALG_OBSERVACAOCANCELAMENTO;

    [Column('ALG_ID_OLD', ftInteger)]
    [Dictionary('ALG_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_ID_OLD: Nullable<Integer> read FALG_ID_OLD write FALG_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TALG_00 } 

procedure TALG_00.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TALG_00>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TALG_00>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TALG_00(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TALG_00);
  TCoreRegisterClass.RegisterEntity(TALG_00);

end.
