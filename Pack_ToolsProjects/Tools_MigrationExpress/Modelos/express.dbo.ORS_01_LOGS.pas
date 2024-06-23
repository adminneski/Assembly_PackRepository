unit express.dbo.ORS_01_LOGS;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ors_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ORS_01_LOGS', '')]
  [PrimaryKey('ORS_ID_LOG', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_ID_LOG')]
  TDtoORS_01_LOGS = class
  private
    { Private declarations } 
    FORS_ID_LOG: Integer;
    FCOM_CODIGO: Integer;
    FORS_DATALOG: TDateTime;
    FORS_HORALOG: String;
    FORS_LOG: Integer;
    FORS_ID: Integer;
    FORS_NUMEROOS: Integer;
    FPRO_CODIGO: Integer;
    FORS_QTDPEDIDA: Double;
    FUSERS_LOGIN: String;
    FORS_TIPOLOG: String;
    FORS_TIPODOCUMENTO: String;
    FORS_TIPOPRODUTO: String;
    FORS_ID_OLD: Integer;

    FORS_00_0:  TORS_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'ORS_01_LOGS';
     const PrimaryKey = 'ORS_ID_LOG';
     const Sequence   = 'SEQ_ORS_ID_LOG';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_LOG', ftInteger)]
    [Dictionary('ORS_ID_LOG', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_LOG: Integer read FORS_ID_LOG write FORS_ID_LOG;
    const ORS_ID_LOG_Name = 'ORS_ID_LOG';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_DATALOG', ftDateTime)]
    [Dictionary('ORS_DATALOG', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATALOG: TDateTime read FORS_DATALOG write FORS_DATALOG;
    const ORS_DATALOG_Name = 'ORS_DATALOG';

    [Restrictions([NoValidate])]
    [Column('ORS_HORALOG', ftString, 8)]
    [Dictionary('ORS_HORALOG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_HORALOG: String read FORS_HORALOG write FORS_HORALOG;
    const ORS_HORALOG_Name = 'ORS_HORALOG';

    [Restrictions([NoValidate])]
    [Column('ORS_LOG', ftInteger)]
    [Dictionary('ORS_LOG', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_LOG: Integer read FORS_LOG write FORS_LOG;
    const ORS_LOG_Name = 'ORS_LOG';

    [Restrictions([NoValidate])]
    [Column('ORS_ID', ftInteger)]
    [ForeignKey('ORS_01_LOGS_fk', 'ORS_ID', 'ORS_00', 'ORS_ID', SetNull, SetNull)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOS', ftInteger)]
    [Dictionary('ORS_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOS: Integer read FORS_NUMEROOS write FORS_NUMEROOS;
    const ORS_NUMEROOS_Name = 'ORS_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_QTDPEDIDA', ftBCD, 4784197, 3)]
    [Dictionary('ORS_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_QTDPEDIDA: Double read FORS_QTDPEDIDA write FORS_QTDPEDIDA;
    const ORS_QTDPEDIDA_Name = 'ORS_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPOLOG', ftString, 3)]
    [Dictionary('ORS_TIPOLOG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPOLOG: String read FORS_TIPOLOG write FORS_TIPOLOG;
    const ORS_TIPOLOG_Name = 'ORS_TIPOLOG';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPODOCUMENTO', ftString, 5)]
    [Dictionary('ORS_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPODOCUMENTO: String read FORS_TIPODOCUMENTO write FORS_TIPODOCUMENTO;
    const ORS_TIPODOCUMENTO_Name = 'ORS_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPOPRODUTO', ftString, 3)]
    [Dictionary('ORS_TIPOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPOPRODUTO: String read FORS_TIPOPRODUTO write FORS_TIPOPRODUTO;
    const ORS_TIPOPRODUTO_Name = 'ORS_TIPOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';

    [Association(OneToOne,'ORS_ID','ORS_00','ORS_ID')]
    property ORS_00: TORS_00 read FORS_00_0 write FORS_00_0;

  end;

implementation

constructor TORS_01_LOGS.Create;
begin
  FORS_00_0 := TORS_00.Create;
end;

destructor TORS_01_LOGS.Destroy;
begin
  if Assigned(FORS_00_0) then
    FORS_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoORS_01_LOGS)

end.
