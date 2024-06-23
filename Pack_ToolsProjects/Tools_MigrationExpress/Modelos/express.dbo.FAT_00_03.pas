unit express.dbo.FAT_00_03;

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
  [Table('FAT_00_03', '')]
  [PrimaryKey('FAT_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_03_ID')]
  TDtoFAT_00_03 = class
  private
    { Private declarations } 
    FFAT_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FFAT_DESCRICAO: String;
    FFAT_RECOLHERPRODUTO: String;
    FFAT_DATAALTERACAO: TDateTime;
    FFAT_03_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_INTEGRACAOERP: String;
  public
    { Public declarations }
    const Table      = 'FAT_00_03';
    const PrimaryKey = 'FAT_03_ID';
    const Sequence   = 'SEQ_FAT_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_03_ID', ftInteger)]
    [Dictionary('FAT_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_03_ID: Integer read FFAT_03_ID write FFAT_03_ID;
    const FAT_03_ID_Name = 'FAT_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [ForeignKey('FAT_00_03_fk', 'FAT_ID', 'FAT_00', 'FAT_ID', SetNull, SetNull)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_DESCRICAO', ftString, 50)]
    [Dictionary('FAT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESCRICAO: String read FFAT_DESCRICAO write FFAT_DESCRICAO;
    const FAT_DESCRICAO_Name = 'FAT_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_RECOLHERPRODUTO', ftString, 1)]
    [Dictionary('FAT_RECOLHERPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_RECOLHERPRODUTO: String read FFAT_RECOLHERPRODUTO write FFAT_RECOLHERPRODUTO;
    const FAT_RECOLHERPRODUTO_Name = 'FAT_RECOLHERPRODUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_03_ID_OLD', ftInteger)]
    [Dictionary('FAT_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_03_ID_OLD: Integer read FFAT_03_ID_OLD write FFAT_03_ID_OLD;
    const FAT_03_ID_OLD_Name = 'FAT_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAOERP', ftString, 50)]
    [Dictionary('FAT_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAOERP: String read FFAT_INTEGRACAOERP write FFAT_INTEGRACAOERP;
    const FAT_INTEGRACAOERP_Name = 'FAT_INTEGRACAOERP';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00_03)

end.
