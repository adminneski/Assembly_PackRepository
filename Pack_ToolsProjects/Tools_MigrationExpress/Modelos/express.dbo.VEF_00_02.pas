unit express.dbo.VEF_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.vef_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('VEF_00_02', '')]
  [PrimaryKey('VEF_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_VEF_02_ID')]
  TDtoVEF_00_02 = class
  private
    { Private declarations } 
    FVEF_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FVEF_ID: Integer;
    FVEF_DIA: Integer;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCID_IBGE: String;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FVEF_DATAVENCIMENTO: TDateTime;
    FVEF_DOCTOEMITENTE: String;
    FVEF_NUMERODOCTO: String;
    FVEF_NUMEROCHEQUE: String;
    FVEF_NUMEROPARCELA: Integer;
    FVEF_VALORPARCELA: Double;
    FVEF_EMITENTE: String;
    FVEF_CONTA: String;
    FVEF_AGENCIA: String;
    FVEF_CIDADE: String;
    FVEF_VENCTOCARTAO: String;
    FVEF_AUTORIZACAOCARTAO: String;
    FVEF_PERCENTUALFINANCEIRO: Double;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FVEF_DATAALTERACAO: TDateTime;
    FVEF_02_ID_OLD: Integer;
    FVEF_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'VEF_00_02';
    const PrimaryKey = 'VEF_02_ID';
    const Sequence   = 'SEQ_VEF_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_02_ID', ftInteger)]
    [Dictionary('VEF_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_02_ID: Integer read FVEF_02_ID write FVEF_02_ID;
    const VEF_02_ID_Name = 'VEF_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [ForeignKey('VEF_00_02_fk', 'VEF_ID', 'VEF_00', 'VEF_ID', SetNull, SetNull)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DIA', ftInteger)]
    [Dictionary('VEF_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_DIA: Integer read FVEF_DIA write FVEF_DIA;
    const VEF_DIA_Name = 'VEF_DIA';

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
    [Column('VEF_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('VEF_DATAVENCIMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATAVENCIMENTO: TDateTime read FVEF_DATAVENCIMENTO write FVEF_DATAVENCIMENTO;
    const VEF_DATAVENCIMENTO_Name = 'VEF_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('VEF_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('VEF_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_DOCTOEMITENTE: String read FVEF_DOCTOEMITENTE write FVEF_DOCTOEMITENTE;
    const VEF_DOCTOEMITENTE_Name = 'VEF_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('VEF_NUMERODOCTO', ftString, 20)]
    [Dictionary('VEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_NUMERODOCTO: String read FVEF_NUMERODOCTO write FVEF_NUMERODOCTO;
    const VEF_NUMERODOCTO_Name = 'VEF_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('VEF_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('VEF_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_NUMEROCHEQUE: String read FVEF_NUMEROCHEQUE write FVEF_NUMEROCHEQUE;
    const VEF_NUMEROCHEQUE_Name = 'VEF_NUMEROCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_NUMEROPARCELA', ftInteger)]
    [Dictionary('VEF_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_NUMEROPARCELA: Integer read FVEF_NUMEROPARCELA write FVEF_NUMEROPARCELA;
    const VEF_NUMEROPARCELA_Name = 'VEF_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_VALORPARCELA', ftBCD, 537529610, 2)]
    [Dictionary('VEF_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORPARCELA: Double read FVEF_VALORPARCELA write FVEF_VALORPARCELA;
    const VEF_VALORPARCELA_Name = 'VEF_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('VEF_EMITENTE', ftString, 50)]
    [Dictionary('VEF_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_EMITENTE: String read FVEF_EMITENTE write FVEF_EMITENTE;
    const VEF_EMITENTE_Name = 'VEF_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('VEF_CONTA', ftString, 15)]
    [Dictionary('VEF_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_CONTA: String read FVEF_CONTA write FVEF_CONTA;
    const VEF_CONTA_Name = 'VEF_CONTA';

    [Restrictions([NoValidate])]
    [Column('VEF_AGENCIA', ftString, 6)]
    [Dictionary('VEF_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_AGENCIA: String read FVEF_AGENCIA write FVEF_AGENCIA;
    const VEF_AGENCIA_Name = 'VEF_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('VEF_CIDADE', ftString, 30)]
    [Dictionary('VEF_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_CIDADE: String read FVEF_CIDADE write FVEF_CIDADE;
    const VEF_CIDADE_Name = 'VEF_CIDADE';

    [Restrictions([NoValidate])]
    [Column('VEF_VENCTOCARTAO', ftString, 6)]
    [Dictionary('VEF_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_VENCTOCARTAO: String read FVEF_VENCTOCARTAO write FVEF_VENCTOCARTAO;
    const VEF_VENCTOCARTAO_Name = 'VEF_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('VEF_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('VEF_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_AUTORIZACAOCARTAO: String read FVEF_AUTORIZACAOCARTAO write FVEF_AUTORIZACAOCARTAO;
    const VEF_AUTORIZACAOCARTAO_Name = 'VEF_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PERCENTUALFINANCEIRO', ftBCD, 539780974, 2)]
    [Dictionary('VEF_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALFINANCEIRO: Double read FVEF_PERCENTUALFINANCEIRO write FVEF_PERCENTUALFINANCEIRO;
    const VEF_PERCENTUALFINANCEIRO_Name = 'VEF_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: String read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;
    const FPG_TIPOPAGTOCOMISSAO_Name = 'FPG_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('VEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATAALTERACAO: TDateTime read FVEF_DATAALTERACAO write FVEF_DATAALTERACAO;
    const VEF_DATAALTERACAO_Name = 'VEF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('VEF_02_ID_OLD', ftInteger)]
    [Dictionary('VEF_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_02_ID_OLD: Integer read FVEF_02_ID_OLD write FVEF_02_ID_OLD;
    const VEF_02_ID_OLD_Name = 'VEF_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('VEF_ID_OLD', ftInteger)]
    [Dictionary('VEF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID_OLD: Integer read FVEF_ID_OLD write FVEF_ID_OLD;
    const VEF_ID_OLD_Name = 'VEF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVEF_00_02)

end.
