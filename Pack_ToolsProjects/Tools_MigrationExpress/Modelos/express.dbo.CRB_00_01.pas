unit express.dbo.CRB_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.crb_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CRB_00_01', '')]
  [PrimaryKey('CRB_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRB_01_ID')]
  TDtoCRB_00_01 = class
  private
    { Private declarations } 
    FCRB_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRB_ID: Integer;
    FCRB_DIA: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FCRB_DATAVENCTO: TDateTime;
    FCRB_NUMERODOCTO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FCRB_NUMEROPARCELA: Integer;
    FCRB_VALORPARCELA: Double;
    FCRB_DATAALTERACAO: TDateTime;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FCID_IBGE: String;
    FCRB_EMITENTE: String;
    FCRB_CONTA: String;
    FCRB_CIDADE: String;
    FCRB_AGENCIA: String;
    FCRB_VENCTOCARTAO: String;
    FCRB_NUMEROCHEQUE: String;
    FCRB_DOCTOEMITENTE: String;
    FCRB_AUTORIZACAOCARTAO: String;
    FCRB_PERCENTUALFINANCEIRO: Double;
    FCRB_01_ID_OLD: Integer;
    FCRB_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CRB_00_01';
    const PrimaryKey = 'CRB_01_ID';
    const Sequence   = 'SEQ_CRB_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_01_ID', ftInteger)]
    [Dictionary('CRB_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_01_ID: Integer read FCRB_01_ID write FCRB_01_ID;
    const CRB_01_ID_Name = 'CRB_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_ID', ftInteger)]
    [ForeignKey('CRB_00_01_fk', 'CRB_ID', 'CRB_00', 'CRB_ID', SetNull, SetNull)]
    [Dictionary('CRB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_ID: Integer read FCRB_ID write FCRB_ID;
    const CRB_ID_Name = 'CRB_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DIA', ftInteger)]
    [Dictionary('CRB_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_DIA: Integer read FCRB_DIA write FCRB_DIA;
    const CRB_DIA_Name = 'CRB_DIA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRB_DATAVENCTO', ftDateTime)]
    [Dictionary('CRB_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRB_DATAVENCTO: TDateTime read FCRB_DATAVENCTO write FCRB_DATAVENCTO;
    const CRB_DATAVENCTO_Name = 'CRB_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CRB_NUMERODOCTO', ftString, 15)]
    [Dictionary('CRB_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_NUMERODOCTO: String read FCRB_NUMERODOCTO write FCRB_NUMERODOCTO;
    const CRB_NUMERODOCTO_Name = 'CRB_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_NUMEROPARCELA', ftInteger)]
    [Dictionary('CRB_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_NUMEROPARCELA: Integer read FCRB_NUMEROPARCELA write FCRB_NUMEROPARCELA;
    const CRB_NUMEROPARCELA_Name = 'CRB_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_VALORPARCELA', ftBCD)]
    [Dictionary('CRB_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_VALORPARCELA: Double read FCRB_VALORPARCELA write FCRB_VALORPARCELA;
    const CRB_VALORPARCELA_Name = 'CRB_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRB_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATAALTERACAO: TDateTime read FCRB_DATAALTERACAO write FCRB_DATAALTERACAO;
    const CRB_DATAALTERACAO_Name = 'CRB_DATAALTERACAO';

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
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('CRB_EMITENTE', ftString, 50)]
    [Dictionary('CRB_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_EMITENTE: String read FCRB_EMITENTE write FCRB_EMITENTE;
    const CRB_EMITENTE_Name = 'CRB_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CRB_CONTA', ftString, 15)]
    [Dictionary('CRB_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CONTA: String read FCRB_CONTA write FCRB_CONTA;
    const CRB_CONTA_Name = 'CRB_CONTA';

    [Restrictions([NoValidate])]
    [Column('CRB_CIDADE', ftString, 30)]
    [Dictionary('CRB_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CIDADE: String read FCRB_CIDADE write FCRB_CIDADE;
    const CRB_CIDADE_Name = 'CRB_CIDADE';

    [Restrictions([NoValidate])]
    [Column('CRB_AGENCIA', ftString, 6)]
    [Dictionary('CRB_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_AGENCIA: String read FCRB_AGENCIA write FCRB_AGENCIA;
    const CRB_AGENCIA_Name = 'CRB_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CRB_VENCTOCARTAO', ftString, 6)]
    [Dictionary('CRB_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_VENCTOCARTAO: String read FCRB_VENCTOCARTAO write FCRB_VENCTOCARTAO;
    const CRB_VENCTOCARTAO_Name = 'CRB_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRB_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('CRB_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_NUMEROCHEQUE: String read FCRB_NUMEROCHEQUE write FCRB_NUMEROCHEQUE;
    const CRB_NUMEROCHEQUE_Name = 'CRB_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CRB_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('CRB_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_DOCTOEMITENTE: String read FCRB_DOCTOEMITENTE write FCRB_DOCTOEMITENTE;
    const CRB_DOCTOEMITENTE_Name = 'CRB_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('CRB_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('CRB_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_AUTORIZACAOCARTAO: String read FCRB_AUTORIZACAOCARTAO write FCRB_AUTORIZACAOCARTAO;
    const CRB_AUTORIZACAOCARTAO_Name = 'CRB_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRB_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CRB_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_PERCENTUALFINANCEIRO: Double read FCRB_PERCENTUALFINANCEIRO write FCRB_PERCENTUALFINANCEIRO;
    const CRB_PERCENTUALFINANCEIRO_Name = 'CRB_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CRB_01_ID_OLD', ftInteger)]
    [Dictionary('CRB_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_01_ID_OLD: Integer read FCRB_01_ID_OLD write FCRB_01_ID_OLD;
    const CRB_01_ID_OLD_Name = 'CRB_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRB_ID_OLD', ftInteger)]
    [Dictionary('CRB_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_ID_OLD: Integer read FCRB_ID_OLD write FCRB_ID_OLD;
    const CRB_ID_OLD_Name = 'CRB_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCRB_00_01)

end.
