unit express.dbo.FAT_00_07;

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
  [Table('FAT_00_07', '')]
  [PrimaryKey('FAT_07_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_07_ID')]
  TDtoFAT_00_07 = class
  private
    { Private declarations } 
    FFAT_07_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_TIPOOPERACAO: String;
    FFAT_DATAOPERACAO: TDateTime;
    FFAT_VALOROPERACAO: Double;
    FUSERS_LOGIN: String;
    FFAT_DATAALTERACAO: TDateTime;
    FFAT_OBSERVACAOOPERACAO: String;
    FFAT_07_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'FAT_00_07';
     const PrimaryKey = 'FAT_07_ID';
     const Sequence   = 'SEQ_FAT_07_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_07_ID', ftInteger)]
    [Dictionary('FAT_07_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_07_ID: Integer read FFAT_07_ID write FFAT_07_ID;
    const FAT_07_ID_Name = 'FAT_07_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPOOPERACAO', ftString, 1)]
    [Dictionary('FAT_TIPOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOOPERACAO: String read FFAT_TIPOOPERACAO write FFAT_TIPOOPERACAO;
    const FAT_TIPOOPERACAO_Name = 'FAT_TIPOOPERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATAOPERACAO', ftDateTime)]
    [Dictionary('FAT_DATAOPERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATAOPERACAO: TDateTime read FFAT_DATAOPERACAO write FFAT_DATAOPERACAO;
    const FAT_DATAOPERACAO_Name = 'FAT_DATAOPERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALOROPERACAO', ftBCD)]
    [Dictionary('FAT_VALOROPERACAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALOROPERACAO: Double read FFAT_VALOROPERACAO write FFAT_VALOROPERACAO;
    const FAT_VALOROPERACAO_Name = 'FAT_VALOROPERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAOOPERACAO', ftString, 5000)]
    [Dictionary('FAT_OBSERVACAOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAOOPERACAO: String read FFAT_OBSERVACAOOPERACAO write FFAT_OBSERVACAOOPERACAO;
    const FAT_OBSERVACAOOPERACAO_Name = 'FAT_OBSERVACAOOPERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_07_ID_OLD', ftInteger)]
    [Dictionary('FAT_07_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_07_ID_OLD: Integer read FFAT_07_ID_OLD write FFAT_07_ID_OLD;
    const FAT_07_ID_OLD_Name = 'FAT_07_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00_07)

end.
