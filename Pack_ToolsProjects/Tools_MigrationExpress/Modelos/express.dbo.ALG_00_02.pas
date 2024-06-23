unit express.dbo.ALG_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.alg_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ALG_00_02', '')]
  [PrimaryKey('ALG_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ALG_02_ID')]
  TDtoALG_00_02 = class
  private
    { Private declarations } 
    FALG_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FALG_ID: Integer;
    FALG_DIA: Integer;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCID_IBGE: String;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FALG_DATAVENCIMENTO: TDateTime;
    FALG_DOCTOEMITENTE: String;
    FALG_NUMERODOCTO: String;
    FALG_NUMEROCHEQUE: String;
    FALG_NUMEROPARCELA: Integer;
    FALG_VALORPARCELA: Double;
    FALG_EMITENTE: String;
    FALG_CONTA: String;
    FALG_AGENCIA: String;
    FALG_CIDADE: String;
    FALG_VENCTOCARTAO: String;
    FALG_AUTORIZACAOCARTAO: String;
    FALG_PERCENTUALFINANCEIRO: Double;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FALG_DATAALTERACAO: TDateTime;
    FALG_02_ID_OLD: Integer;
    FALG_ID_OLD: Integer;

    FALG_00_0:  TALG_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'ALG_00_02';
     const PrimaryKey = 'ALG_02_ID';
     const Sequence   = 'SEQ_ALG_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_02_ID', ftInteger)]
    [Dictionary('ALG_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_02_ID: Integer read FALG_02_ID write FALG_02_ID;
    const ALG_02_ID_Name = 'ALG_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_ID', ftInteger)]
    [ForeignKey('ALG_00_02_fk', 'ALG_ID', 'ALG_00', 'ALG_ID', SetNull, SetNull)]
    [Dictionary('ALG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_ID: Integer read FALG_ID write FALG_ID;
    const ALG_ID_Name = 'ALG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DIA', ftInteger)]
    [Dictionary('ALG_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_DIA: Integer read FALG_DIA write FALG_DIA;
    const ALG_DIA_Name = 'ALG_DIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('ALG_DATAVENCIMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAVENCIMENTO: TDateTime read FALG_DATAVENCIMENTO write FALG_DATAVENCIMENTO;
    const ALG_DATAVENCIMENTO_Name = 'ALG_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('ALG_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('ALG_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_DOCTOEMITENTE: String read FALG_DOCTOEMITENTE write FALG_DOCTOEMITENTE;
    const ALG_DOCTOEMITENTE_Name = 'ALG_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('ALG_NUMERODOCTO', ftString, 20)]
    [Dictionary('ALG_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_NUMERODOCTO: String read FALG_NUMERODOCTO write FALG_NUMERODOCTO;
    const ALG_NUMERODOCTO_Name = 'ALG_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('ALG_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('ALG_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_NUMEROCHEQUE: String read FALG_NUMEROCHEQUE write FALG_NUMEROCHEQUE;
    const ALG_NUMEROCHEQUE_Name = 'ALG_NUMEROCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_NUMEROPARCELA', ftInteger)]
    [Dictionary('ALG_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_NUMEROPARCELA: Integer read FALG_NUMEROPARCELA write FALG_NUMEROPARCELA;
    const ALG_NUMEROPARCELA_Name = 'ALG_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_VALORPARCELA', ftBCD)]
    [Dictionary('ALG_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_VALORPARCELA: Double read FALG_VALORPARCELA write FALG_VALORPARCELA;
    const ALG_VALORPARCELA_Name = 'ALG_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('ALG_EMITENTE', ftString, 50)]
    [Dictionary('ALG_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_EMITENTE: String read FALG_EMITENTE write FALG_EMITENTE;
    const ALG_EMITENTE_Name = 'ALG_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('ALG_CONTA', ftString, 15)]
    [Dictionary('ALG_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_CONTA: String read FALG_CONTA write FALG_CONTA;
    const ALG_CONTA_Name = 'ALG_CONTA';

    [Restrictions([NoValidate])]
    [Column('ALG_AGENCIA', ftString, 6)]
    [Dictionary('ALG_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_AGENCIA: String read FALG_AGENCIA write FALG_AGENCIA;
    const ALG_AGENCIA_Name = 'ALG_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('ALG_CIDADE', ftString, 30)]
    [Dictionary('ALG_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_CIDADE: String read FALG_CIDADE write FALG_CIDADE;
    const ALG_CIDADE_Name = 'ALG_CIDADE';

    [Restrictions([NoValidate])]
    [Column('ALG_VENCTOCARTAO', ftString, 6)]
    [Dictionary('ALG_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_VENCTOCARTAO: String read FALG_VENCTOCARTAO write FALG_VENCTOCARTAO;
    const ALG_VENCTOCARTAO_Name = 'ALG_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('ALG_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('ALG_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_AUTORIZACAOCARTAO: String read FALG_AUTORIZACAOCARTAO write FALG_AUTORIZACAOCARTAO;
    const ALG_AUTORIZACAOCARTAO_Name = 'ALG_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('ALG_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_PERCENTUALFINANCEIRO: Double read FALG_PERCENTUALFINANCEIRO write FALG_PERCENTUALFINANCEIRO;
    const ALG_PERCENTUALFINANCEIRO_Name = 'ALG_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: String read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;
    const FPG_TIPOPAGTOCOMISSAO_Name = 'FPG_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ALG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAALTERACAO: TDateTime read FALG_DATAALTERACAO write FALG_DATAALTERACAO;
    const ALG_DATAALTERACAO_Name = 'ALG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ALG_02_ID_OLD', ftInteger)]
    [Dictionary('ALG_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_02_ID_OLD: Integer read FALG_02_ID_OLD write FALG_02_ID_OLD;
    const ALG_02_ID_OLD_Name = 'ALG_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ALG_ID_OLD', ftInteger)]
    [Dictionary('ALG_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_ID_OLD: Integer read FALG_ID_OLD write FALG_ID_OLD;
    const ALG_ID_OLD_Name = 'ALG_ID_OLD';

    [Association(OneToOne,'ALG_ID','ALG_00','ALG_ID')]
    property ALG_00: TALG_00 read FALG_00_0 write FALG_00_0;

  end;

implementation

constructor TALG_00_02.Create;
begin
  FALG_00_0 := TALG_00.Create;
end;

destructor TALG_00_02.Destroy;
begin
  if Assigned(FALG_00_0) then
    FALG_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoALG_00_02)

end.
