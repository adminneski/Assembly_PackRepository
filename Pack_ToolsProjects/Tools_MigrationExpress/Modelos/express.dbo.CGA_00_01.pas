unit express.dbo.CGA_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cga_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CGA_00_01', '')]
  [PrimaryKey('CGA_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CGA_01_ID')]
  TDtoCGA_00_01 = class
  private
    { Private declarations } 
    FCGA_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCGA_ID: Integer;
    FPDA_ID: Integer;
    FCGA_STATUS: String;
    FPDA_NUMERODOCTO: String;
    FLIB_NUMEROLIBERACAO: String;
    FCGA_NUMEROORDEMENTREGA: Integer;
    FCGA_DATAALTERACAO: TDateTime;
    FCGA_01_ID_OLD: Integer;
    FCGA_ID_OLD: Integer;
    FPDA_ID_OLD: Integer;
    FFAT_ID: Integer;
    FFAT_NUMERODOCTO: String;
  public
    { Public declarations }
    const Table      = 'CGA_00_01';
    const PrimaryKey = 'CGA_01_ID';
    const Sequence   = 'SEQ_CGA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_01_ID', ftInteger)]
    [Dictionary('CGA_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_01_ID: Integer read FCGA_01_ID write FCGA_01_ID;
    const CGA_01_ID_Name = 'CGA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_ID', ftInteger)]
    [ForeignKey('CGA_00_01_fk', 'CGA_ID', 'CGA_00', 'CGA_ID', SetNull, SetNull)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_STATUS', ftString, 1)]
    [Dictionary('CGA_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_STATUS: String read FCGA_STATUS write FCGA_STATUS;
    const CGA_STATUS_Name = 'CGA_STATUS';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMERODOCTO', ftString, 10)]
    [Dictionary('PDA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTO: String read FPDA_NUMERODOCTO write FPDA_NUMERODOCTO;
    const PDA_NUMERODOCTO_Name = 'PDA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_NUMEROORDEMENTREGA', ftInteger)]
    [Dictionary('CGA_NUMEROORDEMENTREGA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_NUMEROORDEMENTREGA: Integer read FCGA_NUMEROORDEMENTREGA write FCGA_NUMEROORDEMENTREGA;
    const CGA_NUMEROORDEMENTREGA_Name = 'CGA_NUMEROORDEMENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CGA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CGA_DATAALTERACAO: TDateTime read FCGA_DATAALTERACAO write FCGA_DATAALTERACAO;
    const CGA_DATAALTERACAO_Name = 'CGA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CGA_01_ID_OLD', ftInteger)]
    [Dictionary('CGA_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_01_ID_OLD: Integer read FCGA_01_ID_OLD write FCGA_01_ID_OLD;
    const CGA_01_ID_OLD_Name = 'CGA_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CGA_ID_OLD', ftInteger)]
    [Dictionary('CGA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID_OLD: Integer read FCGA_ID_OLD write FCGA_ID_OLD;
    const CGA_ID_OLD_Name = 'CGA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID_OLD: Integer read FPDA_ID_OLD write FPDA_ID_OLD;
    const PDA_ID_OLD_Name = 'PDA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 10)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCGA_00_01)

end.
