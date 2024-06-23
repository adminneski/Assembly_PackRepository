unit express.dbo.LOG_XX;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LOG_XX', '')]
  [PrimaryKey('LOG_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LOG_ID')]
  TDtoLOG_XX = class
  private
    { Private declarations } 
    FLOG_ID: Integer;
    FCOM_CODIGO: Integer;
    FLOG_DATA: TDateTime;
    FLOG_HORA: String;
    FLOG_USUARIO: String;
    FLOG_TIPO: String;
    FLOG_TELASIGLA: String;
    FLOG_TELANOME: String;
    FLOG_TABELA: String;
    FLOG_TABELADESCRICAO: String;
    FLOG_VALUE_OLD: TBlob;
    FLOG_VALUE_NEW: TBlob;
    FLOG_VERSAONESKI: String;
    FLOG_NOMECOMPUTADOR: String;
    FLOG_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'LOG_XX';
     const PrimaryKey = 'LOG_ID';
     const Sequence   = 'SEQ_LOG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LOG_ID', ftInteger)]
    [Dictionary('LOG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LOG_ID: Integer read FLOG_ID write FLOG_ID;
    const LOG_ID_Name = 'LOG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LOG_DATA', ftDateTime)]
    [Dictionary('LOG_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property LOG_DATA: TDateTime read FLOG_DATA write FLOG_DATA;
    const LOG_DATA_Name = 'LOG_DATA';

    [Restrictions([NoValidate])]
    [Column('LOG_HORA', ftString, 8)]
    [Dictionary('LOG_HORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_HORA: String read FLOG_HORA write FLOG_HORA;
    const LOG_HORA_Name = 'LOG_HORA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LOG_USUARIO', ftString, 250)]
    [Dictionary('LOG_USUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_USUARIO: String read FLOG_USUARIO write FLOG_USUARIO;
    const LOG_USUARIO_Name = 'LOG_USUARIO';

    [Restrictions([NoValidate])]
    [Column('LOG_TIPO', ftString, 1)]
    [Dictionary('LOG_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_TIPO: String read FLOG_TIPO write FLOG_TIPO;
    const LOG_TIPO_Name = 'LOG_TIPO';

    [Restrictions([NoValidate])]
    [Column('LOG_TELASIGLA', ftString, 10)]
    [Dictionary('LOG_TELASIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_TELASIGLA: String read FLOG_TELASIGLA write FLOG_TELASIGLA;
    const LOG_TELASIGLA_Name = 'LOG_TELASIGLA';

    [Restrictions([NoValidate])]
    [Column('LOG_TELANOME', ftString, 50)]
    [Dictionary('LOG_TELANOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_TELANOME: String read FLOG_TELANOME write FLOG_TELANOME;
    const LOG_TELANOME_Name = 'LOG_TELANOME';

    [Restrictions([NoValidate])]
    [Column('LOG_TABELA', ftString, 50)]
    [Dictionary('LOG_TABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_TABELA: String read FLOG_TABELA write FLOG_TABELA;
    const LOG_TABELA_Name = 'LOG_TABELA';

    [Restrictions([NoValidate])]
    [Column('LOG_TABELADESCRICAO', ftString, 100)]
    [Dictionary('LOG_TABELADESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_TABELADESCRICAO: String read FLOG_TABELADESCRICAO write FLOG_TABELADESCRICAO;
    const LOG_TABELADESCRICAO_Name = 'LOG_TABELADESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LOG_VALUE_OLD', ftBlob)]
    [Dictionary('LOG_VALUE_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_VALUE_OLD: TBlob read FLOG_VALUE_OLD write FLOG_VALUE_OLD;
    const LOG_VALUE_OLD_Name = 'LOG_VALUE_OLD';

    [Restrictions([NoValidate])]
    [Column('LOG_VALUE_NEW', ftBlob)]
    [Dictionary('LOG_VALUE_NEW', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_VALUE_NEW: TBlob read FLOG_VALUE_NEW write FLOG_VALUE_NEW;
    const LOG_VALUE_NEW_Name = 'LOG_VALUE_NEW';

    [Restrictions([NoValidate])]
    [Column('LOG_VERSAONESKI', ftString, 20)]
    [Dictionary('LOG_VERSAONESKI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_VERSAONESKI: String read FLOG_VERSAONESKI write FLOG_VERSAONESKI;
    const LOG_VERSAONESKI_Name = 'LOG_VERSAONESKI';

    [Restrictions([NoValidate])]
    [Column('LOG_NOMECOMPUTADOR', ftString, 50)]
    [Dictionary('LOG_NOMECOMPUTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_NOMECOMPUTADOR: String read FLOG_NOMECOMPUTADOR write FLOG_NOMECOMPUTADOR;
    const LOG_NOMECOMPUTADOR_Name = 'LOG_NOMECOMPUTADOR';

    [Restrictions([NoValidate])]
    [Column('LOG_DESCRICAO', ftString, 500)]
    [Dictionary('LOG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LOG_DESCRICAO: String read FLOG_DESCRICAO write FLOG_DESCRICAO;
    const LOG_DESCRICAO_Name = 'LOG_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLOG_XX)

end.
