unit express.dbo.LIB_00;

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
  [Table('LIB_00', '')]
  [PrimaryKey('LIB_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LIB_ID')]
  TDtoLIB_00 = class
  private
    { Private declarations } 
    FLIB_ID: Integer;
    FCOM_CODIGO: Integer;
    FLIB_NUMEROLIBERACAO: String;
    FLIB_DATALIBERACAO: TDateTime;
    FUSERS_NAME: String;
    FFAT_ID: Integer;
    FFAT_SIGLA: String;
    FFAT_NUMERODOCTO: String;
    FFAT_TOTALLIQUIDO: Double;
    FPRZ_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FLIB_OBSERVACAO: String;
    FLIB_BLOQUEADO: String;
    FLIB_DATAALTERACAO: TDateTime;
    FLIB_TIPOLIBERACAO: String;
    FFAT_PERCENTUALDESCTOGERAL: Double;
    FLIB_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'LIB_00';
     const PrimaryKey = 'LIB_ID';
     const Sequence   = 'SEQ_LIB_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIB_ID', ftInteger)]
    [Dictionary('LIB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID: Integer read FLIB_ID write FLIB_ID;
    const LIB_ID_Name = 'LIB_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIB_DATALIBERACAO', ftDateTime)]
    [Dictionary('LIB_DATALIBERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LIB_DATALIBERACAO: TDateTime read FLIB_DATALIBERACAO write FLIB_DATALIBERACAO;
    const LIB_DATALIBERACAO_Name = 'LIB_DATALIBERACAO';

    [Restrictions([NoValidate])]
    [Column('USERS_NAME', ftString, 250)]
    [Dictionary('USERS_NAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_NAME: String read FUSERS_NAME write FUSERS_NAME;
    const USERS_NAME_Name = 'USERS_NAME';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_SIGLA', ftString, 3)]
    [Dictionary('FAT_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SIGLA: String read FFAT_SIGLA write FFAT_SIGLA;
    const FAT_SIGLA_Name = 'FAT_SIGLA';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LIB_OBSERVACAO', ftString, 300)]
    [Dictionary('LIB_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_OBSERVACAO: String read FLIB_OBSERVACAO write FLIB_OBSERVACAO;
    const LIB_OBSERVACAO_Name = 'LIB_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('LIB_BLOQUEADO', ftString, 1)]
    [Dictionary('LIB_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_BLOQUEADO: String read FLIB_BLOQUEADO write FLIB_BLOQUEADO;
    const LIB_BLOQUEADO_Name = 'LIB_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('LIB_DATAALTERACAO', ftDateTime)]
    [Dictionary('LIB_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LIB_DATAALTERACAO: TDateTime read FLIB_DATAALTERACAO write FLIB_DATAALTERACAO;
    const LIB_DATAALTERACAO_Name = 'LIB_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LIB_TIPOLIBERACAO', ftString, 4)]
    [Dictionary('LIB_TIPOLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_TIPOLIBERACAO: String read FLIB_TIPOLIBERACAO write FLIB_TIPOLIBERACAO;
    const LIB_TIPOLIBERACAO_Name = 'LIB_TIPOLIBERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALDESCTOGERAL', ftBCD)]
    [Dictionary('FAT_PERCENTUALDESCTOGERAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESCTOGERAL: Double read FFAT_PERCENTUALDESCTOGERAL write FFAT_PERCENTUALDESCTOGERAL;
    const FAT_PERCENTUALDESCTOGERAL_Name = 'FAT_PERCENTUALDESCTOGERAL';

    [Restrictions([NoValidate])]
    [Column('LIB_ID_OLD', ftInteger)]
    [Dictionary('LIB_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID_OLD: Integer read FLIB_ID_OLD write FLIB_ID_OLD;
    const LIB_ID_OLD_Name = 'LIB_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLIB_00)

end.
