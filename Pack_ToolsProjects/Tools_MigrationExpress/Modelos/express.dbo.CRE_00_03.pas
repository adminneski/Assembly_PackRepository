unit express.dbo.CRE_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cre_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CRE_00_03', '')]
  [PrimaryKey('CRE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRE_ID')]
  TDtoCRE_00_03 = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRT_CODIGO: Integer;
    FCRE_VENCTOCARTAO: String;
    FCRE_NUMEROCARTAO: String;
    FCRE_AUTORIZACAOCARTAO: String;
    FCRE_TOTALFINANCEIRO: Double;
    FCRE_VALORFINANCEIRO: Double;
    FCRE_PERCENTUALFINANCEIRO: Double;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CRE_00_03';
    const PrimaryKey = 'CRE_ID';
    const Sequence   = 'SEQ_CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [ForeignKey('CRE_00_03_fk', 'CRE_ID', 'CRE_00', 'CRE_ID', SetNull, SetNull)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_VENCTOCARTAO', ftString, 6)]
    [Dictionary('CRE_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_VENCTOCARTAO: String read FCRE_VENCTOCARTAO write FCRE_VENCTOCARTAO;
    const CRE_VENCTOCARTAO_Name = 'CRE_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROCARTAO', ftString, 20)]
    [Dictionary('CRE_NUMEROCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROCARTAO: String read FCRE_NUMEROCARTAO write FCRE_NUMEROCARTAO;
    const CRE_NUMEROCARTAO_Name = 'CRE_NUMEROCARTAO';

    [Restrictions([NoValidate])]
    [Column('CRE_AUTORIZACAOCARTAO', ftString, 50)]
    [Dictionary('CRE_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_AUTORIZACAOCARTAO: String read FCRE_AUTORIZACAOCARTAO write FCRE_AUTORIZACAOCARTAO;
    const CRE_AUTORIZACAOCARTAO_Name = 'CRE_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_TOTALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFINANCEIRO: Double read FCRE_TOTALFINANCEIRO write FCRE_TOTALFINANCEIRO;
    const CRE_TOTALFINANCEIRO_Name = 'CRE_TOTALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_VALORFINANCEIRO', ftBCD)]
    [Dictionary('CRE_VALORFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORFINANCEIRO: Double read FCRE_VALORFINANCEIRO write FCRE_VALORFINANCEIRO;
    const CRE_VALORFINANCEIRO_Name = 'CRE_VALORFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CRE_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALFINANCEIRO: Double read FCRE_PERCENTUALFINANCEIRO write FCRE_PERCENTUALFINANCEIRO;
    const CRE_PERCENTUALFINANCEIRO_Name = 'CRE_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCRE_00_03)

end.
