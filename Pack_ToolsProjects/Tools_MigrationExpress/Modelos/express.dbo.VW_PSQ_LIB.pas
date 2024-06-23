unit express.dbo.VW_PSQ_LIB;

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
  [Table('VW_PSQ_LIB', '')]
  TDtoVW_PSQ_LIB = class
  private
    { Private declarations } 
    FLIB_ID: Integer;
    FCOM_CODIGO: Integer;
    FLIB_DATALIBERACAO: TDateTime;
    FLIB_NUMEROLIBERACAO: String;
    FFAT_NUMERODOCTO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_LIB';

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
    [Column('LIB_DATALIBERACAO', ftDateTime)]
    [Dictionary('LIB_DATALIBERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LIB_DATALIBERACAO: TDateTime read FLIB_DATALIBERACAO write FLIB_DATALIBERACAO;
    const LIB_DATALIBERACAO_Name = 'LIB_DATALIBERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_LIB)

end.
