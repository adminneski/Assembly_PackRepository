unit express.dbo.OMF_00_05;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.omf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('OMF_00_05', '')]
  [PrimaryKey('OMF_05_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_05_ID')]
  TDtoOMF_00_05 = class
  private
    { Private declarations } 
    FOMF_05_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_ID: Integer;
    FOMF_DIA: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FOMF_DATAVENCTO: TDateTime;
    FOMF_NUMERODOCTO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FOMF_NUMEROPARCELA: Integer;
    FOMF_VALORPARCELA: Double;
    FOMF_DATAALTERACAO: TDateTime;
    FCTA_CODIGO: Integer;
    FOMF_INTEGRACAOERP: String;
    FOMF_AUTORIZACAOCARTAO: String;
    FOMF_PERCENTUALFINANCEIRO: Double;
    FCRT_CODIGO: Integer;
    FOMF_VENCTOCARTAO: String;
    FOMF_05_ID_OLD: Integer;
    FOMF_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'OMF_00_05';
    const PrimaryKey = 'OMF_05_ID';
    const Sequence   = 'SEQ_OMF_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_05_ID', ftInteger)]
    [Dictionary('OMF_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_05_ID: Integer read FOMF_05_ID write FOMF_05_ID;
    const OMF_05_ID_Name = 'OMF_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_05_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DIA', ftInteger)]
    [Dictionary('OMF_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_DIA: Integer read FOMF_DIA write FOMF_DIA;
    const OMF_DIA_Name = 'OMF_DIA';

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
    [Column('OMF_DATAVENCTO', ftDateTime)]
    [Dictionary('OMF_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAVENCTO: TDateTime read FOMF_DATAVENCTO write FOMF_DATAVENCTO;
    const OMF_DATAVENCTO_Name = 'OMF_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('OMF_NUMERODOCTO', ftString, 15)]
    [Dictionary('OMF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NUMERODOCTO: String read FOMF_NUMERODOCTO write FOMF_NUMERODOCTO;
    const OMF_NUMERODOCTO_Name = 'OMF_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_NUMEROPARCELA', ftInteger)]
    [Dictionary('OMF_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_NUMEROPARCELA: Integer read FOMF_NUMEROPARCELA write FOMF_NUMEROPARCELA;
    const OMF_NUMEROPARCELA_Name = 'OMF_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORPARCELA', ftBCD)]
    [Dictionary('OMF_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORPARCELA: Double read FOMF_VALORPARCELA write FOMF_VALORPARCELA;
    const OMF_VALORPARCELA_Name = 'OMF_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: String read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;
    const OMF_INTEGRACAOERP_Name = 'OMF_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('OMF_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('OMF_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_AUTORIZACAOCARTAO: String read FOMF_AUTORIZACAOCARTAO write FOMF_AUTORIZACAOCARTAO;
    const OMF_AUTORIZACAOCARTAO_Name = 'OMF_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALFINANCEIRO', ftBCD, 16387, 2)]
    [Dictionary('OMF_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALFINANCEIRO: Double read FOMF_PERCENTUALFINANCEIRO write FOMF_PERCENTUALFINANCEIRO;
    const OMF_PERCENTUALFINANCEIRO_Name = 'OMF_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_VENCTOCARTAO', ftString, 6)]
    [Dictionary('OMF_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_VENCTOCARTAO: String read FOMF_VENCTOCARTAO write FOMF_VENCTOCARTAO;
    const OMF_VENCTOCARTAO_Name = 'OMF_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('OMF_05_ID_OLD', ftInteger)]
    [Dictionary('OMF_05_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_05_ID_OLD: Integer read FOMF_05_ID_OLD write FOMF_05_ID_OLD;
    const OMF_05_ID_OLD_Name = 'OMF_05_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_05)

end.
