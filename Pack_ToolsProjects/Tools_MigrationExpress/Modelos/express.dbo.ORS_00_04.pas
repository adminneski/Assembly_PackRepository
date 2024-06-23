unit express.dbo.ORS_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ors_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ORS_00_04', '')]
  [PrimaryKey('ORS_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_04_ID')]
  TDtoORS_00_04 = class
  private
    { Private declarations } 
    FORS_04_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_ID: Integer;
    FORS_DIA: Integer;
    FFPG_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCID_IBGE: String;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FORS_DATAVENCIMENTO: TDateTime;
    FORS_DOCTOEMITENTE: String;
    FORS_NUMERODOCTO: String;
    FORS_EMITENTE: String;
    FORS_CONTA: String;
    FORS_AGENCIA: String;
    FORS_CIDADE: String;
    FORS_VALORPARCELA: Double;
    FORS_VENCTOCARTAO: String;
    FORS_NUMEROPARCELA: Integer;
    FORS_AUTORIZACAOCARTAO: String;
    FORS_PERCENTUALFINANCEIRO: Double;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FORS_DATAALTERACAO: TDateTime;
    FORS_04_ID_OLD: Integer;
    FORS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'ORS_00_04';
    const PrimaryKey = 'ORS_04_ID';
    const Sequence   = 'SEQ_ORS_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_04_ID', ftInteger)]
    [Dictionary('ORS_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_04_ID: Integer read FORS_04_ID write FORS_04_ID;
    const ORS_04_ID_Name = 'ORS_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_ID', ftInteger)]
    [ForeignKey('ORS_00_04_fk', 'ORS_ID', 'ORS_00', 'ORS_ID', SetNull, SetNull)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate])]
    [Column('ORS_DIA', ftInteger)]
    [Dictionary('ORS_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_DIA: Integer read FORS_DIA write FORS_DIA;
    const ORS_DIA_Name = 'ORS_DIA';

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
    [Column('ORS_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('ORS_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAVENCIMENTO: TDateTime read FORS_DATAVENCIMENTO write FORS_DATAVENCIMENTO;
    const ORS_DATAVENCIMENTO_Name = 'ORS_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('ORS_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_DOCTOEMITENTE: String read FORS_DOCTOEMITENTE write FORS_DOCTOEMITENTE;
    const ORS_DOCTOEMITENTE_Name = 'ORS_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMERODOCTO', ftString, 20)]
    [Dictionary('ORS_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NUMERODOCTO: String read FORS_NUMERODOCTO write FORS_NUMERODOCTO;
    const ORS_NUMERODOCTO_Name = 'ORS_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('ORS_EMITENTE', ftString, 50)]
    [Dictionary('ORS_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_EMITENTE: String read FORS_EMITENTE write FORS_EMITENTE;
    const ORS_EMITENTE_Name = 'ORS_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('ORS_CONTA', ftString, 15)]
    [Dictionary('ORS_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_CONTA: String read FORS_CONTA write FORS_CONTA;
    const ORS_CONTA_Name = 'ORS_CONTA';

    [Restrictions([NoValidate])]
    [Column('ORS_AGENCIA', ftString, 6)]
    [Dictionary('ORS_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_AGENCIA: String read FORS_AGENCIA write FORS_AGENCIA;
    const ORS_AGENCIA_Name = 'ORS_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('ORS_CIDADE', ftString, 30)]
    [Dictionary('ORS_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_CIDADE: String read FORS_CIDADE write FORS_CIDADE;
    const ORS_CIDADE_Name = 'ORS_CIDADE';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORPARCELA', ftBCD, 1818453348, 2)]
    [Dictionary('ORS_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORPARCELA: Double read FORS_VALORPARCELA write FORS_VALORPARCELA;
    const ORS_VALORPARCELA_Name = 'ORS_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('ORS_VENCTOCARTAO', ftString, 6)]
    [Dictionary('ORS_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_VENCTOCARTAO: String read FORS_VENCTOCARTAO write FORS_VENCTOCARTAO;
    const ORS_VENCTOCARTAO_Name = 'ORS_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROPARCELA', ftInteger)]
    [Dictionary('ORS_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROPARCELA: Integer read FORS_NUMEROPARCELA write FORS_NUMEROPARCELA;
    const ORS_NUMEROPARCELA_Name = 'ORS_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('ORS_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('ORS_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_AUTORIZACAOCARTAO: String read FORS_AUTORIZACAOCARTAO write FORS_AUTORIZACAOCARTAO;
    const ORS_AUTORIZACAOCARTAO_Name = 'ORS_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALFINANCEIRO', ftBCD, 1179206738, 2)]
    [Dictionary('ORS_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALFINANCEIRO: Double read FORS_PERCENTUALFINANCEIRO write FORS_PERCENTUALFINANCEIRO;
    const ORS_PERCENTUALFINANCEIRO_Name = 'ORS_PERCENTUALFINANCEIRO';

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

    [Restrictions([NoValidate])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_04_ID_OLD', ftInteger)]
    [Dictionary('ORS_04_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_04_ID_OLD: Integer read FORS_04_ID_OLD write FORS_04_ID_OLD;
    const ORS_04_ID_OLD_Name = 'ORS_04_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_00_04)

end.
