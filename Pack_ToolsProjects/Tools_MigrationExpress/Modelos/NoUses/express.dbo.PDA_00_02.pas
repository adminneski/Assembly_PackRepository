unit express.dbo.pda_00_02;

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
  [Table('PDA_00_02', 'SELECT * FROM PDA_00_02')]
  [PrimaryKey('PDA_02_ID', NotInc, NoSort, False, 'Chave primária')]
  TPDA_00_02 = class(TModelBase)
  private
    { Private declarations } 
    FPDA_02_ID: Integer;
    FCOM_CODIGO: String;
    FPDA_ID: Integer;
    FPDA_DIA: Integer;
    FFPG_CODIGO: Nullable<Integer>;
    FBCO_CODIGO: Nullable<Integer>;
    FCID_IBGE: Nullable<String>;
    FCRT_CODIGO: Nullable<Integer>;
    FCTA_CODIGO: Nullable<Integer>;
    FPDA_DATAVENCIMENTO: Nullable<TDateTime>;
    FPDA_DOCTOEMITENTE: Nullable<String>;
    FPDA_NUMERODOCTO: Nullable<String>;
    FPDA_EMITENTE: Nullable<String>;
    FPDA_CONTA: Nullable<String>;
    FPDA_AGENCIA: Nullable<String>;
    FPDA_CIDADE: Nullable<String>;
    FPDA_VALORPARCELA: Nullable<Double>;
    FPDA_VENCTOCARTAO: Nullable<String>;
    FPDA_NUMEROPARCELA: Nullable<Integer>;
    FPDA_AUTORIZACAOCARTAO: Nullable<String>;
    FPDA_PERCENTUALFINANCEIRO: Nullable<Double>;
    FFPG_TIPOPAGAMENTO: Nullable<Integer>;
    FFPG_TIPOPAGTOCOMISSAO: Nullable<String>;
    FPDA_DATAALTERACAO: TDateTime;
    FPDA_02_ID_OLD: Nullable<Integer>;
    FPDA_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('PDA_02_ID', ftInteger)]
    [Dictionary('PDA_02_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_02_ID: Integer read FPDA_02_ID write FPDA_02_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;

    [Restrictions([NotNull])]
    [Column('PDA_DIA', ftInteger)]
    [Dictionary('PDA_DIA', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DIA: Integer read FPDA_DIA write FPDA_DIA;

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

    [Column('PDA_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('PDA_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATAVENCIMENTO: Nullable<TDateTime> read FPDA_DATAVENCIMENTO write FPDA_DATAVENCIMENTO;

    [Column('PDA_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('PDA_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DOCTOEMITENTE: Nullable<String> read FPDA_DOCTOEMITENTE write FPDA_DOCTOEMITENTE;

    [Column('PDA_NUMERODOCTO', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTO: Nullable<String> read FPDA_NUMERODOCTO write FPDA_NUMERODOCTO;

    [Column('PDA_EMITENTE', ftString, 50)]
    [Dictionary('PDA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_EMITENTE: Nullable<String> read FPDA_EMITENTE write FPDA_EMITENTE;

    [Column('PDA_CONTA', ftString, 15)]
    [Dictionary('PDA_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CONTA: Nullable<String> read FPDA_CONTA write FPDA_CONTA;

    [Column('PDA_AGENCIA', ftString, 6)]
    [Dictionary('PDA_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_AGENCIA: Nullable<String> read FPDA_AGENCIA write FPDA_AGENCIA;

    [Column('PDA_CIDADE', ftString, 30)]
    [Dictionary('PDA_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CIDADE: Nullable<String> read FPDA_CIDADE write FPDA_CIDADE;

    [Column('PDA_VALORPARCELA', ftBCD)]
    [Dictionary('PDA_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORPARCELA: Nullable<Double> read FPDA_VALORPARCELA write FPDA_VALORPARCELA;

    [Column('PDA_VENCTOCARTAO', ftString, 6)]
    [Dictionary('PDA_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_VENCTOCARTAO: Nullable<String> read FPDA_VENCTOCARTAO write FPDA_VENCTOCARTAO;

    [Column('PDA_NUMEROPARCELA', ftInteger)]
    [Dictionary('PDA_NUMEROPARCELA', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_NUMEROPARCELA: Nullable<Integer> read FPDA_NUMEROPARCELA write FPDA_NUMEROPARCELA;

    [Column('PDA_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('PDA_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_AUTORIZACAOCARTAO: Nullable<String> read FPDA_AUTORIZACAOCARTAO write FPDA_AUTORIZACAOCARTAO;

    [Column('PDA_PERCENTUALFINANCEIRO', ftBCD, 59, 2)]
    [Dictionary('PDA_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFINANCEIRO: Nullable<Double> read FPDA_PERCENTUALFINANCEIRO write FPDA_PERCENTUALFINANCEIRO;

    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Nullable<Integer> read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;

    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: Nullable<String> read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;

    [Restrictions([NotNull])]
    [Column('PDA_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATAALTERACAO: TDateTime read FPDA_DATAALTERACAO write FPDA_DATAALTERACAO;

    [Column('PDA_02_ID_OLD', ftInteger)]
    [Dictionary('PDA_02_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_02_ID_OLD: Nullable<Integer> read FPDA_02_ID_OLD write FPDA_02_ID_OLD;

    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_ID_OLD: Nullable<Integer> read FPDA_ID_OLD write FPDA_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TPDA_00_02 } 

procedure TPDA_00_02.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TPDA_00_02>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TPDA_00_02>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TPDA_00_02(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization //RETIRADO POIS FOI MIGRADO TUDO PARA TABELAS DE FATURAMENTO
  //TRegisterClass.RegisterEntity(TPDA_00_02);
  //TCoreRegisterClass.RegisterEntity(TPDA_00_02);

end.
