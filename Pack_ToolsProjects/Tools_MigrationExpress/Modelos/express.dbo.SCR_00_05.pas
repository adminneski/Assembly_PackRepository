unit express.dbo.SCR_00_05;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.scr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('SCR_00_05', '')]
  [PrimaryKey('SCR_05_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCR_05_ID')]
  TDtoSCR_00_05 = class
  private
    { Private declarations } 
    FSCR_05_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCR_ID: Integer;
    FFPG_CODIGO: Integer;
    FCRT_CODIGO: Integer;
    FSCR_EMITENTE: String;
    FSCR_TOTALVALOR: Double;
    FSCR_DATAEMISSAO: TDateTime;
    FSCR_DATAVENCTO: TDateTime;
    FSCR_NUMERODOCTO: String;
    FSCR_NUMEROCARTAO: String;
    FSCR_VENCTOCARTAO: String;
    FSCR_AUTORIZACAOCARTAO: String;
    FSCR_PERCENTUALFINANCEIRO: Double;
    FSCR_COMPETENCIA: String;
    FSCR_DATAALTERACAO: TDateTime;
    FSCR_05_ID_OLD: Integer;
    FSCR_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCR_00_05';
    const PrimaryKey = 'SCR_05_ID';
    const Sequence   = 'SEQ_SCR_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_05_ID', ftInteger)]
    [Dictionary('SCR_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_05_ID: Integer read FSCR_05_ID write FSCR_05_ID;
    const SCR_05_ID_Name = 'SCR_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [ForeignKey('SCR_00_05_fk', 'SCR_ID', 'SCR_00', 'SCR_ID', SetNull, SetNull)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

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
    [Column('SCR_EMITENTE', ftString, 50)]
    [Dictionary('SCR_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_EMITENTE: String read FSCR_EMITENTE write FSCR_EMITENTE;
    const SCR_EMITENTE_Name = 'SCR_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALOR', ftBCD, 1162891087, 2)]
    [Dictionary('SCR_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALOR: Double read FSCR_TOTALVALOR write FSCR_TOTALVALOR;
    const SCR_TOTALVALOR_Name = 'SCR_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAEMISSAO: TDateTime read FSCR_DATAEMISSAO write FSCR_DATAEMISSAO;
    const SCR_DATAEMISSAO_Name = 'SCR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAVENCTO', ftDateTime)]
    [Dictionary('SCR_DATAVENCTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAVENCTO: TDateTime read FSCR_DATAVENCTO write FSCR_DATAVENCTO;
    const SCR_DATAVENCTO_Name = 'SCR_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('SCR_NUMERODOCTO', ftString, 20)]
    [Dictionary('SCR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMERODOCTO: String read FSCR_NUMERODOCTO write FSCR_NUMERODOCTO;
    const SCR_NUMERODOCTO_Name = 'SCR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCR_NUMEROCARTAO', ftString, 20)]
    [Dictionary('SCR_NUMEROCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMEROCARTAO: String read FSCR_NUMEROCARTAO write FSCR_NUMEROCARTAO;
    const SCR_NUMEROCARTAO_Name = 'SCR_NUMEROCARTAO';

    [Restrictions([NoValidate])]
    [Column('SCR_VENCTOCARTAO', ftString, 6)]
    [Dictionary('SCR_VENCTOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_VENCTOCARTAO: String read FSCR_VENCTOCARTAO write FSCR_VENCTOCARTAO;
    const SCR_VENCTOCARTAO_Name = 'SCR_VENCTOCARTAO';

    [Restrictions([NoValidate])]
    [Column('SCR_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('SCR_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_AUTORIZACAOCARTAO: String read FSCR_AUTORIZACAOCARTAO write FSCR_AUTORIZACAOCARTAO;
    const SCR_AUTORIZACAOCARTAO_Name = 'SCR_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('SCR_PERCENTUALFINANCEIRO', ftBCD, 1529377646, 2)]
    [Dictionary('SCR_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_PERCENTUALFINANCEIRO: Double read FSCR_PERCENTUALFINANCEIRO write FSCR_PERCENTUALFINANCEIRO;
    const SCR_PERCENTUALFINANCEIRO_Name = 'SCR_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('SCR_COMPETENCIA', ftString, 6)]
    [Dictionary('SCR_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_COMPETENCIA: String read FSCR_COMPETENCIA write FSCR_COMPETENCIA;
    const SCR_COMPETENCIA_Name = 'SCR_COMPETENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAALTERACAO: TDateTime read FSCR_DATAALTERACAO write FSCR_DATAALTERACAO;
    const SCR_DATAALTERACAO_Name = 'SCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCR_05_ID_OLD', ftInteger)]
    [Dictionary('SCR_05_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_05_ID_OLD: Integer read FSCR_05_ID_OLD write FSCR_05_ID_OLD;
    const SCR_05_ID_OLD_Name = 'SCR_05_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCR_ID_OLD', ftInteger)]
    [Dictionary('SCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID_OLD: Integer read FSCR_ID_OLD write FSCR_ID_OLD;
    const SCR_ID_OLD_Name = 'SCR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCR_00_05)

end.
