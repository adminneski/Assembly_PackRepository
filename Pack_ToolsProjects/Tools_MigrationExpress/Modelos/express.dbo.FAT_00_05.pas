unit express.dbo.FAT_00_05;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.fat_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('FAT_00_05', '')]
  [PrimaryKey('FAT_05_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_05_ID')]
  TDtoFAT_00_05 = class
  private
    { Private declarations } 
    FFAT_05_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FFAT_DIA: Integer;
    FFPG_CODIGO: Integer;
    FCRT_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FCID_IBGE: String;
    FBCO_CODIGO: Integer;
    FFAT_EMITENTE: String;
    FFAT_CONTA: String;
    FFAT_CIDADE: String;
    FFAT_AGENCIA: String;
    FFAT_NUMERODOCTO: String;
    FFAT_NUMEROPARCELA: Integer;
    FFAT_VALORPARCELA: Double;
    FFAT_VENCTOCARTAO: String;
    FFAT_NUMEROCHEQUE: String;
    FFAT_DOCTOEMITENTE: String;
    FFAT_DATAVENCIMENTO: TDateTime;
    FFAT_AUTORIZACAOCARTAO: String;
    FFAT_PERCENTUALFINANCEIRO: Double;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FFAT_DATAALTERACAO: TDateTime;
    FFAT_NUMEROPARCELAFPG: String;
    FFAT_05_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_CREDITOCLIENTE: String;
    FFAT_TIPOPARCELA: String;
    FFAT_INTEGRACAOERP: String;
  public
    { Public declarations }
    const Table      = 'FAT_00_05';
    const PrimaryKey = 'FAT_05_ID';
    const Sequence   = 'SEQ_FAT_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_05_ID', ftInteger)]
    [Dictionary('FAT_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_05_ID: Integer read FFAT_05_ID write FFAT_05_ID;
    const FAT_05_ID_Name = 'FAT_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [ForeignKey('FAT_00_05_fk', 'FAT_ID', 'FAT_00', 'FAT_ID', SetNull, SetNull)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_DIA', ftInteger)]
    [Dictionary('FAT_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_DIA: Integer read FFAT_DIA write FFAT_DIA;
    const FAT_DIA_Name = 'FAT_DIA';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

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
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_EMITENTE', ftString, 50)]
    [Dictionary('FAT_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_EMITENTE: String read FFAT_EMITENTE write FFAT_EMITENTE;
    const FAT_EMITENTE_Name = 'FAT_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_CONTA', ftString, 15)]
    [Dictionary('FAT_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CONTA: String read FFAT_CONTA write FFAT_CONTA;
    const FAT_CONTA_Name = 'FAT_CONTA';

    [Restrictions([NoValidate])]
    [Column('FAT_CIDADE', ftString, 30)]
    [Dictionary('FAT_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CIDADE: String read FFAT_CIDADE write FFAT_CIDADE;
    const FAT_CIDADE_Name = 'FAT_CIDADE';

    [Restrictions([NoValidate])]
    [Column('FAT_AGENCIA', ftString, 6)]
    [Dictionary('FAT_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_AGENCIA: String read FFAT_AGENCIA write FFAT_AGENCIA;
    const FAT_AGENCIA_Name = 'FAT_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROPARCELA', ftInteger)]
    [Dictionary('FAT_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROPARCELA: Integer read FFAT_NUMEROPARCELA write FFAT_NUMEROPARCELA;
    const FAT_NUMEROPARCELA_Name = 'FAT_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPARCELA', ftBCD)]
    [Dictionary('FAT_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPARCELA: Double read FFAT_VALORPARCELA write FFAT_VALORPARCELA;
    const FAT_VALORPARCELA_Name = 'FAT_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('FAT_VENCTOCARTAO', ftString, 6)]
    [Dictionary('FAT_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_VENCTOCARTAO: String read FFAT_VENCTOCARTAO write FFAT_VENCTOCARTAO;
    const FAT_VENCTOCARTAO_Name = 'FAT_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('FAT_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROCHEQUE: String read FFAT_NUMEROCHEQUE write FFAT_NUMEROCHEQUE;
    const FAT_NUMEROCHEQUE_Name = 'FAT_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('FAT_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('FAT_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DOCTOEMITENTE: String read FFAT_DOCTOEMITENTE write FFAT_DOCTOEMITENTE;
    const FAT_DOCTOEMITENTE_Name = 'FAT_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('FAT_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAVENCIMENTO: TDateTime read FFAT_DATAVENCIMENTO write FFAT_DATAVENCIMENTO;
    const FAT_DATAVENCIMENTO_Name = 'FAT_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('FAT_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_AUTORIZACAOCARTAO: String read FFAT_AUTORIZACAOCARTAO write FFAT_AUTORIZACAOCARTAO;
    const FAT_AUTORIZACAOCARTAO_Name = 'FAT_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('FAT_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALFINANCEIRO: Double read FFAT_PERCENTUALFINANCEIRO write FFAT_PERCENTUALFINANCEIRO;
    const FAT_PERCENTUALFINANCEIRO_Name = 'FAT_PERCENTUALFINANCEIRO';

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
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROPARCELAFPG', ftString, 7)]
    [Dictionary('FAT_NUMEROPARCELAFPG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROPARCELAFPG: String read FFAT_NUMEROPARCELAFPG write FFAT_NUMEROPARCELAFPG;
    const FAT_NUMEROPARCELAFPG_Name = 'FAT_NUMEROPARCELAFPG';

    [Restrictions([NoValidate])]
    [Column('FAT_05_ID_OLD', ftInteger)]
    [Dictionary('FAT_05_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_05_ID_OLD: Integer read FFAT_05_ID_OLD write FFAT_05_ID_OLD;
    const FAT_05_ID_OLD_Name = 'FAT_05_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_CREDITOCLIENTE', ftString, 1)]
    [Dictionary('FAT_CREDITOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CREDITOCLIENTE: String read FFAT_CREDITOCLIENTE write FFAT_CREDITOCLIENTE;
    const FAT_CREDITOCLIENTE_Name = 'FAT_CREDITOCLIENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOPARCELA', ftString, 1)]
    [Dictionary('FAT_TIPOPARCELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOPARCELA: String read FFAT_TIPOPARCELA write FFAT_TIPOPARCELA;
    const FAT_TIPOPARCELA_Name = 'FAT_TIPOPARCELA';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAOERP', ftString, 50)]
    [Dictionary('FAT_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAOERP: String read FFAT_INTEGRACAOERP write FFAT_INTEGRACAOERP;
    const FAT_INTEGRACAOERP_Name = 'FAT_INTEGRACAOERP';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00_05)

end.
