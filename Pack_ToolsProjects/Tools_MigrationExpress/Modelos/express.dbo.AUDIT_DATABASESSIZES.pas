unit express.dbo.AUDIT_DATABASESSIZES;

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
  [Table('AUDIT_DATABASESSIZES', '')]
  [PrimaryKey('AUD_GUID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AUD_GUID')]
  TDtoAUDIT_DATABASESSIZES = class
  private
    { Private declarations } 
    FAUD_GUID: String;
    FPES_CNPJ_CPF: String;
    FAUD_DATABASENAME: String;
    FAUD_TYPEDATABASE: String;
    FAUD_SERVERNAME: String;
    FAUD_FILENAME: String;
    FAUD_TOTAL_RESERVED_MB: Double;
    FAUD_TOTAL_USED_MB: Double;
    FAUD_FREE_SPACE_MB: Double;
    FAUD_FREE_SPACE_PERCENTUAL: Double;
    FAUD_GROWTH: String;
    FAUD_DATAHORAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'AUDIT_DATABASESSIZES';
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
    [Column('AUD_DATABASENAME', ftString, 50)]
    [Dictionary('AUD_DATABASENAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_DATABASENAME: String read FAUD_DATABASENAME write FAUD_DATABASENAME;
    const AUD_DATABASENAME_Name = 'AUD_DATABASENAME';

    [Restrictions([NoValidate])]
    [Column('AUD_TYPEDATABASE', ftString, 5)]
    [Dictionary('AUD_TYPEDATABASE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_TYPEDATABASE: String read FAUD_TYPEDATABASE write FAUD_TYPEDATABASE;
    const AUD_TYPEDATABASE_Name = 'AUD_TYPEDATABASE';

    [Restrictions([NoValidate])]
    [Column('AUD_SERVERNAME', ftString, 100)]
    [Dictionary('AUD_SERVERNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_SERVERNAME: String read FAUD_SERVERNAME write FAUD_SERVERNAME;
    const AUD_SERVERNAME_Name = 'AUD_SERVERNAME';

    [Restrictions([NoValidate])]
    [Column('AUD_FILENAME', ftString, 300)]
    [Dictionary('AUD_FILENAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_FILENAME: String read FAUD_FILENAME write FAUD_FILENAME;
    const AUD_FILENAME_Name = 'AUD_FILENAME';

    [Restrictions([NoValidate])]
    [Column('AUD_TOTAL_RESERVED_MB', ftBCD)]
    [Dictionary('AUD_TOTAL_RESERVED_MB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_TOTAL_RESERVED_MB: Double read FAUD_TOTAL_RESERVED_MB write FAUD_TOTAL_RESERVED_MB;
    const AUD_TOTAL_RESERVED_MB_Name = 'AUD_TOTAL_RESERVED_MB';

    [Restrictions([NoValidate])]
    [Column('AUD_TOTAL_USED_MB', ftBCD)]
    [Dictionary('AUD_TOTAL_USED_MB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_TOTAL_USED_MB: Double read FAUD_TOTAL_USED_MB write FAUD_TOTAL_USED_MB;
    const AUD_TOTAL_USED_MB_Name = 'AUD_TOTAL_USED_MB';

    [Restrictions([NoValidate])]
    [Column('AUD_FREE_SPACE_MB', ftBCD)]
    [Dictionary('AUD_FREE_SPACE_MB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_FREE_SPACE_MB: Double read FAUD_FREE_SPACE_MB write FAUD_FREE_SPACE_MB;
    const AUD_FREE_SPACE_MB_Name = 'AUD_FREE_SPACE_MB';

    [Restrictions([NoValidate])]
    [Column('AUD_FREE_SPACE_PERCENTUAL', ftBCD)]
    [Dictionary('AUD_FREE_SPACE_PERCENTUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_FREE_SPACE_PERCENTUAL: Double read FAUD_FREE_SPACE_PERCENTUAL write FAUD_FREE_SPACE_PERCENTUAL;
    const AUD_FREE_SPACE_PERCENTUAL_Name = 'AUD_FREE_SPACE_PERCENTUAL';

    [Restrictions([NoValidate])]
    [Column('AUD_GROWTH', ftString, 100)]
    [Dictionary('AUD_GROWTH', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_GROWTH: String read FAUD_GROWTH write FAUD_GROWTH;
    const AUD_GROWTH_Name = 'AUD_GROWTH';

    [Restrictions([NoValidate])]
    [Column('AUD_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('AUD_DATAHORAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property AUD_DATAHORAALTERACAO: TDateTime read FAUD_DATAHORAALTERACAO write FAUD_DATAHORAALTERACAO;
    const AUD_DATAHORAALTERACAO_Name = 'AUD_DATAHORAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAUDIT_DATABASESSIZES)

end.
