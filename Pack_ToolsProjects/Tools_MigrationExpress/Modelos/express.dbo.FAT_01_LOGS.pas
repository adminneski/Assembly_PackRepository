unit express.dbo.FAT_01_LOGS;

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
  [Table('FAT_01_LOGS', '')]
  [PrimaryKey('FAT_ID_LOG', AutoInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('COM_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_ID_LOG')]
  [Sequence('SEQ_COM_CODIGO')]
  TDtoFAT_01_LOGS = class
  private
    { Private declarations } 
    FFAT_ID_LOG: Integer;
    FCOM_CODIGO: Integer;
    FFAT_DATALOG: TDateTime;
    FFAT_HORALOG: String;
    FFAT_LOG: Integer;
    FFAT_ID: Integer;
    FFAT_NUMEROOS: Integer;
    FPRO_CODIGO: String;
    FFAT_QTDPEDIDA: Double;
    FUSERS_LOGIN: String;
    FFAT_TIPOLOG: String;
    FFAT_TIPODOCUMENTO: String;
    FFAT_TIPOPRODUTO: String;
  public
    { Public declarations }
    const Table      = 'FAT_01_LOGS';
    const PrimaryKey = 'FAT_ID_LOG';
    const Sequence   = 'SEQ_FAT_ID_LOG';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_LOG', ftInteger)]
    [Dictionary('FAT_ID_LOG', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_LOG: Integer read FFAT_ID_LOG write FFAT_ID_LOG;
    const FAT_ID_LOG_Name = 'FAT_ID_LOG';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALOG', ftDateTime)]
    [Dictionary('FAT_DATALOG', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALOG: TDateTime read FFAT_DATALOG write FFAT_DATALOG;
    const FAT_DATALOG_Name = 'FAT_DATALOG';

    [Restrictions([NoValidate])]
    [Column('FAT_HORALOG', ftString, 8)]
    [Dictionary('FAT_HORALOG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_HORALOG: String read FFAT_HORALOG write FFAT_HORALOG;
    const FAT_HORALOG_Name = 'FAT_HORALOG';

    [Restrictions([NoValidate])]
    [Column('FAT_LOG', ftInteger)]
    [Dictionary('FAT_LOG', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_LOG: Integer read FFAT_LOG write FFAT_LOG;
    const FAT_LOG_Name = 'FAT_LOG';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [ForeignKey('FAT_01_LOGS_fk', 'FAT_ID', 'FAT_00', 'FAT_ID', SetNull, SetNull)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROOS', ftInteger)]
    [Dictionary('FAT_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROOS: Integer read FFAT_NUMEROOS write FFAT_NUMEROOS;
    const FAT_NUMEROOS_Name = 'FAT_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftString, 6)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGO: String read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_QTDPEDIDA', ftBCD)]
    [Dictionary('FAT_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDPEDIDA: Double read FFAT_QTDPEDIDA write FFAT_QTDPEDIDA;
    const FAT_QTDPEDIDA_Name = 'FAT_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 20)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOLOG', ftString, 3)]
    [Dictionary('FAT_TIPOLOG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOLOG: String read FFAT_TIPOLOG write FFAT_TIPOLOG;
    const FAT_TIPOLOG_Name = 'FAT_TIPOLOG';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPODOCUMENTO', ftString, 5)]
    [Dictionary('FAT_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPODOCUMENTO: String read FFAT_TIPODOCUMENTO write FFAT_TIPODOCUMENTO;
    const FAT_TIPODOCUMENTO_Name = 'FAT_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOPRODUTO', ftString, 3)]
    [Dictionary('FAT_TIPOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOPRODUTO: String read FFAT_TIPOPRODUTO write FFAT_TIPOPRODUTO;
    const FAT_TIPOPRODUTO_Name = 'FAT_TIPOPRODUTO';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoFAT_01_LOGS)

end.
