unit express.dbo.PDA_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.pda_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PDA_00_02', '')]
  [PrimaryKey('PDA_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDA_02_ID')]
  TDtoPDA_00_02 = class
  private
    { Private declarations } 
    FPDA_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDA_ID: Integer;
    FPDA_DIA: Integer;
    FFPG_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCID_IBGE: String;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FPDA_DATAVENCIMENTO: TDateTime;
    FPDA_DOCTOEMITENTE: String;
    FPDA_NUMERODOCTO: String;
    FPDA_EMITENTE: String;
    FPDA_CONTA: String;
    FPDA_AGENCIA: String;
    FPDA_CIDADE: String;
    FPDA_VALORPARCELA: Double;
    FPDA_VENCTOCARTAO: String;
    FPDA_NUMEROPARCELA: Integer;
    FPDA_AUTORIZACAOCARTAO: String;
    FPDA_PERCENTUALFINANCEIRO: Double;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FPDA_DATAALTERACAO: TDateTime;
    FPDA_02_ID_OLD: Integer;
    FPDA_ID_OLD: Integer;

    FPDA_00_0:  TPDA_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'PDA_00_02';
     const PrimaryKey = 'PDA_02_ID';
     const Sequence   = 'SEQ_PDA_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_02_ID', ftInteger)]
    [Dictionary('PDA_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_02_ID: Integer read FPDA_02_ID write FPDA_02_ID;
    const PDA_02_ID_Name = 'PDA_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [ForeignKey('PDA_00_02_fk', 'PDA_ID', 'PDA_00', 'PDA_ID', SetNull, SetNull)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DIA', ftInteger)]
    [Dictionary('PDA_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_DIA: Integer read FPDA_DIA write FPDA_DIA;
    const PDA_DIA_Name = 'PDA_DIA';

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

    [Restrictions([NoValidate])]
    [Column('PDA_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('PDA_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATAVENCIMENTO: TDateTime read FPDA_DATAVENCIMENTO write FPDA_DATAVENCIMENTO;
    const PDA_DATAVENCIMENTO_Name = 'PDA_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('PDA_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('PDA_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DOCTOEMITENTE: String read FPDA_DOCTOEMITENTE write FPDA_DOCTOEMITENTE;
    const PDA_DOCTOEMITENTE_Name = 'PDA_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMERODOCTO', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTO: String read FPDA_NUMERODOCTO write FPDA_NUMERODOCTO;
    const PDA_NUMERODOCTO_Name = 'PDA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PDA_EMITENTE', ftString, 50)]
    [Dictionary('PDA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_EMITENTE: String read FPDA_EMITENTE write FPDA_EMITENTE;
    const PDA_EMITENTE_Name = 'PDA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('PDA_CONTA', ftString, 15)]
    [Dictionary('PDA_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CONTA: String read FPDA_CONTA write FPDA_CONTA;
    const PDA_CONTA_Name = 'PDA_CONTA';

    [Restrictions([NoValidate])]
    [Column('PDA_AGENCIA', ftString, 6)]
    [Dictionary('PDA_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_AGENCIA: String read FPDA_AGENCIA write FPDA_AGENCIA;
    const PDA_AGENCIA_Name = 'PDA_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('PDA_CIDADE', ftString, 30)]
    [Dictionary('PDA_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CIDADE: String read FPDA_CIDADE write FPDA_CIDADE;
    const PDA_CIDADE_Name = 'PDA_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PDA_VALORPARCELA', ftBCD, 1162891087, 2)]
    [Dictionary('PDA_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORPARCELA: Double read FPDA_VALORPARCELA write FPDA_VALORPARCELA;
    const PDA_VALORPARCELA_Name = 'PDA_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('PDA_VENCTOCARTAO', ftString, 6)]
    [Dictionary('PDA_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_VENCTOCARTAO: String read FPDA_VENCTOCARTAO write FPDA_VENCTOCARTAO;
    const PDA_VENCTOCARTAO_Name = 'PDA_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMEROPARCELA', ftInteger)]
    [Dictionary('PDA_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_NUMEROPARCELA: Integer read FPDA_NUMEROPARCELA write FPDA_NUMEROPARCELA;
    const PDA_NUMEROPARCELA_Name = 'PDA_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('PDA_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('PDA_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_AUTORIZACAOCARTAO: String read FPDA_AUTORIZACAOCARTAO write FPDA_AUTORIZACAOCARTAO;
    const PDA_AUTORIZACAOCARTAO_Name = 'PDA_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALFINANCEIRO', ftBCD, 1981834596, 2)]
    [Dictionary('PDA_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFINANCEIRO: Double read FPDA_PERCENTUALFINANCEIRO write FPDA_PERCENTUALFINANCEIRO;
    const PDA_PERCENTUALFINANCEIRO_Name = 'PDA_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: String read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;
    const FPG_TIPOPAGTOCOMISSAO_Name = 'FPG_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATAALTERACAO: TDateTime read FPDA_DATAALTERACAO write FPDA_DATAALTERACAO;
    const PDA_DATAALTERACAO_Name = 'PDA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDA_02_ID_OLD', ftInteger)]
    [Dictionary('PDA_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_02_ID_OLD: Integer read FPDA_02_ID_OLD write FPDA_02_ID_OLD;
    const PDA_02_ID_OLD_Name = 'PDA_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID_OLD: Integer read FPDA_ID_OLD write FPDA_ID_OLD;
    const PDA_ID_OLD_Name = 'PDA_ID_OLD';

    [Association(OneToOne,'PDA_ID','PDA_00','PDA_ID')]
    property PDA_00: TPDA_00 read FPDA_00_0 write FPDA_00_0;

  end;

implementation

constructor TPDA_00_02.Create;
begin
  FPDA_00_0 := TPDA_00.Create;
end;

destructor TPDA_00_02.Destroy;
begin
  if Assigned(FPDA_00_0) then
    FPDA_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoPDA_00_02)

end.
