unit express.dbo.CTR_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ctr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CTR_00_02', '')]
  [PrimaryKey('CTR_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTR_02_ID')]
  TDtoCTR_00_02 = class
  private
    { Private declarations } 
    FCTR_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FCTR_DIA: Integer;
    FFPG_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCID_IBGE: String;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FCTR_DATAVENCIMENTO: TDateTime;
    FCTR_DOCTOEMITENTE: String;
    FCTR_NUMERODOCTO: String;
    FCTR_EMITENTE: String;
    FCTR_CONTA: String;
    FCTR_AGENCIA: String;
    FCTR_CIDADE: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FCTR_VENCTOCARTAO: String;
    FCTR_AUTORIZACAOCARTAO: String;
    FCTR_PERCENTUALFINANCEIRO: Double;
    FCTR_NUMEROPARCELA: Integer;
    FCTR_VALORPARCELA: Double;
    FCTR_DATAALTERACAO: TDateTime;
    FCTR_NUMEROCHEQUE: String;
    FCTR_02_ID_OLD: Integer;
    FCTR_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CTR_00_02';
    const PrimaryKey = 'CTR_02_ID';
    const Sequence   = 'SEQ_CTR_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_02_ID', ftInteger)]
    [Dictionary('CTR_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_02_ID: Integer read FCTR_02_ID write FCTR_02_ID;
    const CTR_02_ID_Name = 'CTR_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [ForeignKey('CTR_00_02_fk', 'CTR_ID', 'CTR_00', 'CTR_ID', SetNull, SetNull)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DIA', ftInteger)]
    [Dictionary('CTR_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_DIA: Integer read FCTR_DIA write FCTR_DIA;
    const CTR_DIA_Name = 'CTR_DIA';

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
    [Column('CTR_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('CTR_DATAVENCIMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAVENCIMENTO: TDateTime read FCTR_DATAVENCIMENTO write FCTR_DATAVENCIMENTO;
    const CTR_DATAVENCIMENTO_Name = 'CTR_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('CTR_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_DOCTOEMITENTE: String read FCTR_DOCTOEMITENTE write FCTR_DOCTOEMITENTE;
    const CTR_DOCTOEMITENTE_Name = 'CTR_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 20)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMITENTE', ftString, 50)]
    [Dictionary('CTR_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMITENTE: String read FCTR_EMITENTE write FCTR_EMITENTE;
    const CTR_EMITENTE_Name = 'CTR_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTR_CONTA', ftString, 15)]
    [Dictionary('CTR_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CONTA: String read FCTR_CONTA write FCTR_CONTA;
    const CTR_CONTA_Name = 'CTR_CONTA';

    [Restrictions([NoValidate])]
    [Column('CTR_AGENCIA', ftString, 6)]
    [Dictionary('CTR_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_AGENCIA: String read FCTR_AGENCIA write FCTR_AGENCIA;
    const CTR_AGENCIA_Name = 'CTR_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTR_CIDADE', ftString, 30)]
    [Dictionary('CTR_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CIDADE: String read FCTR_CIDADE write FCTR_CIDADE;
    const CTR_CIDADE_Name = 'CTR_CIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_VENCTOCARTAO', ftString, 6)]
    [Dictionary('CTR_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_VENCTOCARTAO: String read FCTR_VENCTOCARTAO write FCTR_VENCTOCARTAO;
    const CTR_VENCTOCARTAO_Name = 'CTR_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('CTR_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('CTR_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_AUTORIZACAOCARTAO: String read FCTR_AUTORIZACAOCARTAO write FCTR_AUTORIZACAOCARTAO;
    const CTR_AUTORIZACAOCARTAO_Name = 'CTR_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CTR_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALFINANCEIRO: Double read FCTR_PERCENTUALFINANCEIRO write FCTR_PERCENTUALFINANCEIRO;
    const CTR_PERCENTUALFINANCEIRO_Name = 'CTR_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_NUMEROPARCELA', ftInteger)]
    [Dictionary('CTR_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_NUMEROPARCELA: Integer read FCTR_NUMEROPARCELA write FCTR_NUMEROPARCELA;
    const CTR_NUMEROPARCELA_Name = 'CTR_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_VALORPARCELA', ftBCD)]
    [Dictionary('CTR_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORPARCELA: Double read FCTR_VALORPARCELA write FCTR_VALORPARCELA;
    const CTR_VALORPARCELA_Name = 'CTR_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAALTERACAO: TDateTime read FCTR_DATAALTERACAO write FCTR_DATAALTERACAO;
    const CTR_DATAALTERACAO_Name = 'CTR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('CTR_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMEROCHEQUE: String read FCTR_NUMEROCHEQUE write FCTR_NUMEROCHEQUE;
    const CTR_NUMEROCHEQUE_Name = 'CTR_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CTR_02_ID_OLD', ftInteger)]
    [Dictionary('CTR_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_02_ID_OLD: Integer read FCTR_02_ID_OLD write FCTR_02_ID_OLD;
    const CTR_02_ID_OLD_Name = 'CTR_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';

  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCTR_00_02)

end.
