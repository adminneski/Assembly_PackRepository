unit express.dbo.FAT_00_02_01;

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
  [Table('FAT_00_02_01', '')]
  [PrimaryKey('FAT_02_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_02_01_ID')]
  TDtoFAT_00_02_01 = class
  private
    { Private declarations } 
    FFAT_02_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FFAT_02_ID: Integer;
    FFAT_SIGLA: String;
    FMDO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FFAT_PERCENTUALRATEIO: Double;
    FFAT_DATAALTERACAO: TDateTime;
    FFAT_ID_OLD: Integer;
    FFAT_02_ID_OLD: Integer;
    FFAT_02_01_ID_OLD: Integer;
    FFAT_INTEGRACAOERP: String;
  public
    { Public declarations }
    const Table      = 'FAT_00_02_01';
    const PrimaryKey = 'FAT_02_01_ID';
    const Sequence   = 'SEQ_FAT_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_02_01_ID', ftInteger)]
    [Dictionary('FAT_02_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_02_01_ID: Integer read FFAT_02_01_ID write FFAT_02_01_ID;
    const FAT_02_01_ID_Name = 'FAT_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [ForeignKey('FAT_00_02_01_fk', 'FAT_ID', 'FAT_00', 'FAT_ID', SetNull, SetNull)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_02_ID', ftInteger)]
    [Dictionary('FAT_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_02_ID: Integer read FFAT_02_ID write FFAT_02_ID;
    const FAT_02_ID_Name = 'FAT_02_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_SIGLA', ftString, 3)]
    [Dictionary('FAT_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SIGLA: String read FFAT_SIGLA write FFAT_SIGLA;
    const FAT_SIGLA_Name = 'FAT_SIGLA';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('FAT_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALRATEIO: Double read FFAT_PERCENTUALRATEIO write FFAT_PERCENTUALRATEIO;
    const FAT_PERCENTUALRATEIO_Name = 'FAT_PERCENTUALRATEIO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_02_ID_OLD', ftInteger)]
    [Dictionary('FAT_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_02_ID_OLD: Integer read FFAT_02_ID_OLD write FFAT_02_ID_OLD;
    const FAT_02_ID_OLD_Name = 'FAT_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_02_01_ID_OLD', ftInteger)]
    [Dictionary('FAT_02_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_02_01_ID_OLD: Integer read FFAT_02_01_ID_OLD write FFAT_02_01_ID_OLD;
    const FAT_02_01_ID_OLD_Name = 'FAT_02_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAOERP', ftString, 50)]
    [Dictionary('FAT_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAOERP: String read FFAT_INTEGRACAOERP write FFAT_INTEGRACAOERP;
    const FAT_INTEGRACAOERP_Name = 'FAT_INTEGRACAOERP';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00_02_01)

end.
