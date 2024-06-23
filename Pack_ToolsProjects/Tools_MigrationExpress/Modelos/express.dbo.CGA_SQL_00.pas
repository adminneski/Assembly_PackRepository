unit express.dbo.CGA_SQL_00;

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
  [Table('CGA_SQL_00', '')]
  TDtoCGA_SQL_00 = class
  private
    { Private declarations } 
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCGA_FATURADA: String;
    FCGA_LACRADA: String;
    FCGA_LIVROFISCAL: String;
    FCGA_DESATIVADO: String;
    FCGA_CANCELADA: String;
    FCGA_TITULOCARGA: String;
    FCGA_DATAFORMACAO: TDateTime;
    FCGA_TIPODOCUMENTO: String;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'CGA_SQL_00';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_FATURADA', ftString, 1)]
    [Dictionary('CGA_FATURADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_FATURADA: String read FCGA_FATURADA write FCGA_FATURADA;
    const CGA_FATURADA_Name = 'CGA_FATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_LACRADA', ftString, 1)]
    [Dictionary('CGA_LACRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_LACRADA: String read FCGA_LACRADA write FCGA_LACRADA;
    const CGA_LACRADA_Name = 'CGA_LACRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_LIVROFISCAL', ftString, 1)]
    [Dictionary('CGA_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_LIVROFISCAL: String read FCGA_LIVROFISCAL write FCGA_LIVROFISCAL;
    const CGA_LIVROFISCAL_Name = 'CGA_LIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_DESATIVADO', ftString, 1)]
    [Dictionary('CGA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_DESATIVADO: String read FCGA_DESATIVADO write FCGA_DESATIVADO;
    const CGA_DESATIVADO_Name = 'CGA_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_CANCELADA', ftString, 1)]
    [Dictionary('CGA_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_CANCELADA: String read FCGA_CANCELADA write FCGA_CANCELADA;
    const CGA_CANCELADA_Name = 'CGA_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_TITULOCARGA', ftString, 40)]
    [Dictionary('CGA_TITULOCARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_TITULOCARGA: String read FCGA_TITULOCARGA write FCGA_TITULOCARGA;
    const CGA_TITULOCARGA_Name = 'CGA_TITULOCARGA';

    [Restrictions([NoValidate])]
    [Column('CGA_DATAFORMACAO', ftDateTime)]
    [Dictionary('CGA_DATAFORMACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATAFORMACAO: TDateTime read FCGA_DATAFORMACAO write FCGA_DATAFORMACAO;
    const CGA_DATAFORMACAO_Name = 'CGA_DATAFORMACAO';

    [Restrictions([NoValidate])]
    [Column('CGA_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CGA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_TIPODOCUMENTO: String read FCGA_TIPODOCUMENTO write FCGA_TIPODOCUMENTO;
    const CGA_TIPODOCUMENTO_Name = 'CGA_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCGA_SQL_00)

end.
