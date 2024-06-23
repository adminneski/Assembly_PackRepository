unit express.dbo.SCR_00_02;

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
  [Table('SCR_00_02', '')]
  [PrimaryKey('SCR_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCR_02_ID')]
  TDtoSCR_00_02 = class
  private
    { Private declarations } 
    FSCR_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCR_ID: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FSCR_CONTA: String;
    FSCR_AGENCIA: String;
    FSCR_EMITENTE: String;
    FSCR_COMPETENCIA: String;
    FSCR_DATAEMISSAO: TDateTime;
    FSCR_DATAVENCTO: TDateTime;
    FSCR_TOTALVALOR: Double;
    FSCR_DOCTOEMITENTE: String;
    FSCR_NUMEROCHEQUE: String;
    FSCR_NUMERODOCTO: String;
    FSCR_DATAALTERACAO: TDateTime;
    FSCR_02_ID_OLD: Integer;
    FSCR_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCR_00_02';
    const PrimaryKey = 'SCR_02_ID';
    const Sequence   = 'SEQ_SCR_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_02_ID', ftInteger)]
    [Dictionary('SCR_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_02_ID: Integer read FSCR_02_ID write FSCR_02_ID;
    const SCR_02_ID_Name = 'SCR_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [ForeignKey('SCR_00_02_fk', 'SCR_ID', 'SCR_00', 'SCR_ID', SetNull, SetNull)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_CONTA', ftString, 15)]
    [Dictionary('SCR_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_CONTA: String read FSCR_CONTA write FSCR_CONTA;
    const SCR_CONTA_Name = 'SCR_CONTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_AGENCIA', ftString, 6)]
    [Dictionary('SCR_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_AGENCIA: String read FSCR_AGENCIA write FSCR_AGENCIA;
    const SCR_AGENCIA_Name = 'SCR_AGENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_EMITENTE', ftString, 50)]
    [Dictionary('SCR_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_EMITENTE: String read FSCR_EMITENTE write FSCR_EMITENTE;
    const SCR_EMITENTE_Name = 'SCR_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('SCR_COMPETENCIA', ftString, 6)]
    [Dictionary('SCR_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_COMPETENCIA: String read FSCR_COMPETENCIA write FSCR_COMPETENCIA;
    const SCR_COMPETENCIA_Name = 'SCR_COMPETENCIA';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALOR', ftBCD, 6881394, 2)]
    [Dictionary('SCR_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALOR: Double read FSCR_TOTALVALOR write FSCR_TOTALVALOR;
    const SCR_TOTALVALOR_Name = 'SCR_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('SCR_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('SCR_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_DOCTOEMITENTE: String read FSCR_DOCTOEMITENTE write FSCR_DOCTOEMITENTE;
    const SCR_DOCTOEMITENTE_Name = 'SCR_DOCTOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('SCR_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('SCR_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMEROCHEQUE: String read FSCR_NUMEROCHEQUE write FSCR_NUMEROCHEQUE;
    const SCR_NUMEROCHEQUE_Name = 'SCR_NUMEROCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMERODOCTO: String read FSCR_NUMERODOCTO write FSCR_NUMERODOCTO;
    const SCR_NUMERODOCTO_Name = 'SCR_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAALTERACAO: TDateTime read FSCR_DATAALTERACAO write FSCR_DATAALTERACAO;
    const SCR_DATAALTERACAO_Name = 'SCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCR_02_ID_OLD', ftInteger)]
    [Dictionary('SCR_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_02_ID_OLD: Integer read FSCR_02_ID_OLD write FSCR_02_ID_OLD;
    const SCR_02_ID_OLD_Name = 'SCR_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCR_ID_OLD', ftInteger)]
    [Dictionary('SCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID_OLD: Integer read FSCR_ID_OLD write FSCR_ID_OLD;
    const SCR_ID_OLD_Name = 'SCR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCR_00_02)

end.
