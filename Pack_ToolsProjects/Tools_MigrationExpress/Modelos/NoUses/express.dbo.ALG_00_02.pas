unit express.dbo.alg_00_02;

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
  [Table('ALG_00_02', 'SELECT * FROM ALG_00_02')]
  [PrimaryKey('ALG_02_ID', NotInc, NoSort, False, 'Chave primária')]
  TALG_00_02 = class(TModelBase)
  private
    { Private declarations } 
    FALG_02_ID: Integer;
    FCOM_CODIGO: String;
    FALG_ID: Integer;
    FALG_DIA: Integer;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_CODIGO: Nullable<Integer>;
    FBCO_CODIGO: Nullable<Integer>;
    FCID_IBGE: Nullable<String>;
    FCRT_CODIGO: Nullable<Integer>;
    FCTA_CODIGO: Nullable<Integer>;
    FALG_DATAVENCIMENTO: TDateTime;
    FALG_DOCTOEMITENTE: Nullable<String>;
    FALG_NUMERODOCTO: Nullable<String>;
    FALG_NUMEROCHEQUE: Nullable<String>;
    FALG_NUMEROPARCELA: Integer;
    FALG_VALORPARCELA: Double;
    FALG_EMITENTE: Nullable<String>;
    FALG_CONTA: Nullable<String>;
    FALG_AGENCIA: Nullable<String>;
    FALG_CIDADE: Nullable<String>;
    FALG_VENCTOCARTAO: Nullable<String>;
    FALG_AUTORIZACAOCARTAO: Nullable<String>;
    FALG_PERCENTUALFINANCEIRO: Double;
    FFPG_TIPOPAGTOCOMISSAO: Nullable<String>;
    FALG_DATAALTERACAO: TDateTime;
    FALG_02_ID_OLD: Nullable<Integer>;
    FALG_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('ALG_02_ID', ftInteger)]
    [Dictionary('ALG_02_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_02_ID: Integer read FALG_02_ID write FALG_02_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('ALG_ID', ftInteger)]
    [Dictionary('ALG_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_ID: Integer read FALG_ID write FALG_ID;

    [Restrictions([NotNull])]
    [Column('ALG_DIA', ftInteger)]
    [Dictionary('ALG_DIA', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DIA: Integer read FALG_DIA write FALG_DIA;

    [Restrictions([NotNull])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;

    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property FPG_CODIGO: Nullable<Integer> read FFPG_CODIGO write FFPG_CODIGO;

    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCO_CODIGO: Nullable<Integer> read FBCO_CODIGO write FBCO_CODIGO;

    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: Nullable<String> read FCID_IBGE write FCID_IBGE;

    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRT_CODIGO: Nullable<Integer> read FCRT_CODIGO write FCRT_CODIGO;

    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTA_CODIGO: Nullable<Integer> read FCTA_CODIGO write FCTA_CODIGO;

    [Restrictions([NotNull])]
    [Column('ALG_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('ALG_DATAVENCIMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAVENCIMENTO: TDateTime read FALG_DATAVENCIMENTO write FALG_DATAVENCIMENTO;

    [Column('ALG_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('ALG_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_DOCTOEMITENTE: Nullable<String> read FALG_DOCTOEMITENTE write FALG_DOCTOEMITENTE;

    [Column('ALG_NUMERODOCTO', ftString, 20)]
    [Dictionary('ALG_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_NUMERODOCTO: Nullable<String> read FALG_NUMERODOCTO write FALG_NUMERODOCTO;

    [Column('ALG_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('ALG_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_NUMEROCHEQUE: Nullable<String> read FALG_NUMEROCHEQUE write FALG_NUMEROCHEQUE;

    [Restrictions([NotNull])]
    [Column('ALG_NUMEROPARCELA', ftInteger)]
    [Dictionary('ALG_NUMEROPARCELA', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_NUMEROPARCELA: Integer read FALG_NUMEROPARCELA write FALG_NUMEROPARCELA;

    [Restrictions([NotNull])]
    [Column('ALG_VALORPARCELA', ftBCD)]
    [Dictionary('ALG_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_VALORPARCELA: Double read FALG_VALORPARCELA write FALG_VALORPARCELA;

    [Column('ALG_EMITENTE', ftString, 50)]
    [Dictionary('ALG_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_EMITENTE: Nullable<String> read FALG_EMITENTE write FALG_EMITENTE;

    [Column('ALG_CONTA', ftString, 15)]
    [Dictionary('ALG_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_CONTA: Nullable<String> read FALG_CONTA write FALG_CONTA;

    [Column('ALG_AGENCIA', ftString, 6)]
    [Dictionary('ALG_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_AGENCIA: Nullable<String> read FALG_AGENCIA write FALG_AGENCIA;

    [Column('ALG_CIDADE', ftString, 30)]
    [Dictionary('ALG_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_CIDADE: Nullable<String> read FALG_CIDADE write FALG_CIDADE;

    [Column('ALG_VENCTOCARTAO', ftString, 6)]
    [Dictionary('ALG_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_VENCTOCARTAO: Nullable<String> read FALG_VENCTOCARTAO write FALG_VENCTOCARTAO;

    [Column('ALG_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('ALG_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_AUTORIZACAOCARTAO: Nullable<String> read FALG_AUTORIZACAOCARTAO write FALG_AUTORIZACAOCARTAO;

    [Restrictions([NotNull])]
    [Column('ALG_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('ALG_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_PERCENTUALFINANCEIRO: Double read FALG_PERCENTUALFINANCEIRO write FALG_PERCENTUALFINANCEIRO;

    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: Nullable<String> read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;

    [Restrictions([NotNull])]
    [Column('ALG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ALG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAALTERACAO: TDateTime read FALG_DATAALTERACAO write FALG_DATAALTERACAO;

    [Column('ALG_02_ID_OLD', ftInteger)]
    [Dictionary('ALG_02_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_02_ID_OLD: Nullable<Integer> read FALG_02_ID_OLD write FALG_02_ID_OLD;

    [Column('ALG_ID_OLD', ftInteger)]
    [Dictionary('ALG_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_ID_OLD: Nullable<Integer> read FALG_ID_OLD write FALG_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TALG_00_02 } 

procedure TALG_00_02.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TALG_00_02>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TALG_00_02>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TALG_00_02(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TALG_00_02);
  TCoreRegisterClass.RegisterEntity(TALG_00_02);

end.
