unit express.dbo.RFC_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.rfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('RFC_00_03', '')]
  [PrimaryKey('RFC_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RFC_03_ID')]
  TDtoRFC_00_03 = class
  private
    { Private declarations } 
    FRFC_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FRFC_ID: Integer;
    FFAT_ID: Integer;
    FRFC_DIA: Integer;
    FFPG_CODIGO: Integer;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FCID_IBGE: String;
    FRFC_CIDADE: String;
    FBCO_CODIGO: Integer;
    FRFC_CONTA: String;
    FRFC_AGENCIA: String;
    FRFC_EMITENTE: String;
    FRFC_NUMEROPARCELA: Integer;
    FRFC_DATAVENCIMENTO: TDateTime;
    FRFC_VALORPARCELA: Double;
    FRFC_NUMERODOCTO: String;
    FRFC_VENCTOCARTAO: String;
    FRFC_DOCTOEMITENTE: String;
    FRFC_NUMEROCHEQUE: String;
    FRFC_AUTORIZACAOCARTAO: String;
    FRFC_PERCENTUALFINANCEIRO: Double;
    FRFC_DATAALTERACAO: TDateTime;
    FRFC_03_ID_OLD: Integer;
    FRFC_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'RFC_00_03';
    const PrimaryKey = 'RFC_03_ID';
    const Sequence   = 'SEQ_RFC_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_03_ID', ftInteger)]
    [Dictionary('RFC_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_03_ID: Integer read FRFC_03_ID write FRFC_03_ID;
    const RFC_03_ID_Name = 'RFC_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_ID', ftInteger)]
    [ForeignKey('RFC_00_03_fk', 'RFC_ID', 'RFC_00', 'RFC_ID', SetNull, SetNull)]
    [Dictionary('RFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID: Integer read FRFC_ID write FRFC_ID;
    const RFC_ID_Name = 'RFC_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_DIA', ftInteger)]
    [Dictionary('RFC_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_DIA: Integer read FRFC_DIA write FRFC_DIA;
    const RFC_DIA_Name = 'RFC_DIA';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

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
    [Column('RFC_CIDADE', ftString, 30)]
    [Dictionary('RFC_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_CIDADE: String read FRFC_CIDADE write FRFC_CIDADE;
    const RFC_CIDADE_Name = 'RFC_CIDADE';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RFC_CONTA', ftString, 15)]
    [Dictionary('RFC_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_CONTA: String read FRFC_CONTA write FRFC_CONTA;
    const RFC_CONTA_Name = 'RFC_CONTA';

    [Restrictions([NoValidate])]
    [Column('RFC_AGENCIA', ftString, 6)]
    [Dictionary('RFC_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_AGENCIA: String read FRFC_AGENCIA write FRFC_AGENCIA;
    const RFC_AGENCIA_Name = 'RFC_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('RFC_EMITENTE', ftString, 50)]
    [Dictionary('RFC_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_EMITENTE: String read FRFC_EMITENTE write FRFC_EMITENTE;
    const RFC_EMITENTE_Name = 'RFC_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_NUMEROPARCELA', ftInteger)]
    [Dictionary('RFC_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_NUMEROPARCELA: Integer read FRFC_NUMEROPARCELA write FRFC_NUMEROPARCELA;
    const RFC_NUMEROPARCELA_Name = 'RFC_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('RFC_DATAVENCIMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RFC_DATAVENCIMENTO: TDateTime read FRFC_DATAVENCIMENTO write FRFC_DATAVENCIMENTO;
    const RFC_DATAVENCIMENTO_Name = 'RFC_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_VALORPARCELA', ftBCD, 656419879, 2)]
    [Dictionary('RFC_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_VALORPARCELA: Double read FRFC_VALORPARCELA write FRFC_VALORPARCELA;
    const RFC_VALORPARCELA_Name = 'RFC_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('RFC_NUMERODOCTO', ftString, 20)]
    [Dictionary('RFC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_NUMERODOCTO: String read FRFC_NUMERODOCTO write FRFC_NUMERODOCTO;
    const RFC_NUMERODOCTO_Name = 'RFC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('RFC_VENCTOCARTAO', ftString, 6)]
    [Dictionary('RFC_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_VENCTOCARTAO: String read FRFC_VENCTOCARTAO write FRFC_VENCTOCARTAO;
    const RFC_VENCTOCARTAO_Name = 'RFC_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('RFC_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('RFC_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_DOCTOEMITENTE: String read FRFC_DOCTOEMITENTE write FRFC_DOCTOEMITENTE;
    const RFC_DOCTOEMITENTE_Name = 'RFC_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('RFC_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('RFC_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_NUMEROCHEQUE: String read FRFC_NUMEROCHEQUE write FRFC_NUMEROCHEQUE;
    const RFC_NUMEROCHEQUE_Name = 'RFC_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('RFC_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('RFC_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_AUTORIZACAOCARTAO: String read FRFC_AUTORIZACAOCARTAO write FRFC_AUTORIZACAOCARTAO;
    const RFC_AUTORIZACAOCARTAO_Name = 'RFC_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('RFC_PERCENTUALFINANCEIRO', ftBCD, 6881394, 2)]
    [Dictionary('RFC_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_PERCENTUALFINANCEIRO: Double read FRFC_PERCENTUALFINANCEIRO write FRFC_PERCENTUALFINANCEIRO;
    const RFC_PERCENTUALFINANCEIRO_Name = 'RFC_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('RFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RFC_DATAALTERACAO: TDateTime read FRFC_DATAALTERACAO write FRFC_DATAALTERACAO;
    const RFC_DATAALTERACAO_Name = 'RFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('RFC_03_ID_OLD', ftInteger)]
    [Dictionary('RFC_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_03_ID_OLD: Integer read FRFC_03_ID_OLD write FRFC_03_ID_OLD;
    const RFC_03_ID_OLD_Name = 'RFC_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('RFC_ID_OLD', ftInteger)]
    [Dictionary('RFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID_OLD: Integer read FRFC_ID_OLD write FRFC_ID_OLD;
    const RFC_ID_OLD_Name = 'RFC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoRFC_00_03)

end.
