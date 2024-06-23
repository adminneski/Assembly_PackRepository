unit express.dbo.AUDIT_BACKUPEXECUTED;

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
  [Table('AUDIT_BACKUPEXECUTED', '')]
  [PrimaryKey('AUD_GUID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AUD_GUID')]
  TDtoAUDIT_BACKUPEXECUTED = class
  private
    { Private declarations } 
    FAUD_GUID: String;
    FPES_CNPJ_CPF: String;
    FAUD_DATABASE_NAME: String;
    FAUD_BACKUP_NAME: String;
    FAUD_BACKUP_START_DATE: TDateTime;
    FAUD_TEMPO_MINUTOS: Integer;
    FAUD_POSITION: Integer;
    FAUD_SERVER_NAME: String;
    FAUD_PHYSICAL_DEVICE_NAME: String;
    FAUD_LOGICAL_DEVICE_NAME: String;
    FAUD_DEVICE_TYPE: String;
    FAUD_TYPE: String;
    FAUD_TAMANHO_MB: Double;
    FAUD_USER_NAME: String;
    FAUD_RECOVERY_MODEL: String;
    FAUD_COMPATIBILITY_LEVEL: String;
    FAUD_COLLATION_NAME: String;
    FAUD_DATAHORAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'AUDIT_BACKUPEXECUTED';
     const PrimaryKey = 'AUD_GUID';
     const Sequence   = 'SEQ_AUD_GUID';

    [Restrictions([NoValidate, NotNull])]
    [Column('AUD_GUID', ftString, 38)]
    [Dictionary('AUD_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_GUID: String read FAUD_GUID write FAUD_GUID;
    const AUD_GUID_Name = 'AUD_GUID';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('AUD_DATABASE_NAME', ftString, 50)]
    [Dictionary('AUD_DATABASE_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_DATABASE_NAME: String read FAUD_DATABASE_NAME write FAUD_DATABASE_NAME;
    const AUD_DATABASE_NAME_Name = 'AUD_DATABASE_NAME';

    [Restrictions([NoValidate])]
    [Column('AUD_BACKUP_NAME', ftString, 100)]
    [Dictionary('AUD_BACKUP_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_BACKUP_NAME: String read FAUD_BACKUP_NAME write FAUD_BACKUP_NAME;
    const AUD_BACKUP_NAME_Name = 'AUD_BACKUP_NAME';

    [Restrictions([NoValidate])]
    [Column('AUD_BACKUP_START_DATE', ftDateTime)]
    [Dictionary('AUD_BACKUP_START_DATE', 'Mensagem de validação', '', '', '', taCenter)]
    property AUD_BACKUP_START_DATE: TDateTime read FAUD_BACKUP_START_DATE write FAUD_BACKUP_START_DATE;
    const AUD_BACKUP_START_DATE_Name = 'AUD_BACKUP_START_DATE';

    [Restrictions([NoValidate])]
    [Column('AUD_TEMPO_MINUTOS', ftInteger)]
    [Dictionary('AUD_TEMPO_MINUTOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property AUD_TEMPO_MINUTOS: Integer read FAUD_TEMPO_MINUTOS write FAUD_TEMPO_MINUTOS;
    const AUD_TEMPO_MINUTOS_Name = 'AUD_TEMPO_MINUTOS';

    [Restrictions([NoValidate])]
    [Column('AUD_POSITION', ftInteger)]
    [Dictionary('AUD_POSITION', 'Mensagem de validação', '0', '', '', taCenter)]
    property AUD_POSITION: Integer read FAUD_POSITION write FAUD_POSITION;
    const AUD_POSITION_Name = 'AUD_POSITION';

    [Restrictions([NoValidate])]
    [Column('AUD_SERVER_NAME', ftString, 50)]
    [Dictionary('AUD_SERVER_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_SERVER_NAME: String read FAUD_SERVER_NAME write FAUD_SERVER_NAME;
    const AUD_SERVER_NAME_Name = 'AUD_SERVER_NAME';

    [Restrictions([NoValidate])]
    [Column('AUD_PHYSICAL_DEVICE_NAME', ftString, 300)]
    [Dictionary('AUD_PHYSICAL_DEVICE_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_PHYSICAL_DEVICE_NAME: String read FAUD_PHYSICAL_DEVICE_NAME write FAUD_PHYSICAL_DEVICE_NAME;
    const AUD_PHYSICAL_DEVICE_NAME_Name = 'AUD_PHYSICAL_DEVICE_NAME';

    [Restrictions([NoValidate])]
    [Column('AUD_LOGICAL_DEVICE_NAME', ftString, 100)]
    [Dictionary('AUD_LOGICAL_DEVICE_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_LOGICAL_DEVICE_NAME: String read FAUD_LOGICAL_DEVICE_NAME write FAUD_LOGICAL_DEVICE_NAME;
    const AUD_LOGICAL_DEVICE_NAME_Name = 'AUD_LOGICAL_DEVICE_NAME';

    [Restrictions([NoValidate])]
    [Column('AUD_DEVICE_TYPE', ftString, 100)]
    [Dictionary('AUD_DEVICE_TYPE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_DEVICE_TYPE: String read FAUD_DEVICE_TYPE write FAUD_DEVICE_TYPE;
    const AUD_DEVICE_TYPE_Name = 'AUD_DEVICE_TYPE';

    [Restrictions([NoValidate])]
    [Column('AUD_TYPE', ftString, 5)]
    [Dictionary('AUD_TYPE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_TYPE: String read FAUD_TYPE write FAUD_TYPE;
    const AUD_TYPE_Name = 'AUD_TYPE';

    [Restrictions([NoValidate])]
    [Column('AUD_TAMANHO_MB', ftBCD)]
    [Dictionary('AUD_TAMANHO_MB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_TAMANHO_MB: Double read FAUD_TAMANHO_MB write FAUD_TAMANHO_MB;
    const AUD_TAMANHO_MB_Name = 'AUD_TAMANHO_MB';

    [Restrictions([NoValidate])]
    [Column('AUD_USER_NAME', ftString, 50)]
    [Dictionary('AUD_USER_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_USER_NAME: String read FAUD_USER_NAME write FAUD_USER_NAME;
    const AUD_USER_NAME_Name = 'AUD_USER_NAME';

    [Restrictions([NoValidate])]
    [Column('AUD_RECOVERY_MODEL', ftString, 50)]
    [Dictionary('AUD_RECOVERY_MODEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_RECOVERY_MODEL: String read FAUD_RECOVERY_MODEL write FAUD_RECOVERY_MODEL;
    const AUD_RECOVERY_MODEL_Name = 'AUD_RECOVERY_MODEL';

    [Restrictions([NoValidate])]
    [Column('AUD_COMPATIBILITY_LEVEL', ftString, 5)]
    [Dictionary('AUD_COMPATIBILITY_LEVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_COMPATIBILITY_LEVEL: String read FAUD_COMPATIBILITY_LEVEL write FAUD_COMPATIBILITY_LEVEL;
    const AUD_COMPATIBILITY_LEVEL_Name = 'AUD_COMPATIBILITY_LEVEL';

    [Restrictions([NoValidate])]
    [Column('AUD_COLLATION_NAME', ftString, 100)]
    [Dictionary('AUD_COLLATION_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_COLLATION_NAME: String read FAUD_COLLATION_NAME write FAUD_COLLATION_NAME;
    const AUD_COLLATION_NAME_Name = 'AUD_COLLATION_NAME';

    [Restrictions([NoValidate])]
    [Column('AUD_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('AUD_DATAHORAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property AUD_DATAHORAALTERACAO: TDateTime read FAUD_DATAHORAALTERACAO write FAUD_DATAHORAALTERACAO;
    const AUD_DATAHORAALTERACAO_Name = 'AUD_DATAHORAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAUDIT_BACKUPEXECUTED)

end.
