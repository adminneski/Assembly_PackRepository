unit express.dbo.MAR_00;

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
  [Table('MAR_00', '')]
  [PrimaryKey('MAR_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MAR_CODIGO')]
  TDtoMAR_00 = class
  private
    { Private declarations } 
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FMAR_NOMEAPELIDO: String;
    FMAR_DATAALTERACAO: TDateTime;
    FMAR_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MAR_00';
     const PrimaryKey = 'MAR_CODIGO';
     const Sequence   = 'SEQ_MAR_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MAR_NOME', ftString, 30)]
    [Dictionary('MAR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_NOME: String read FMAR_NOME write FMAR_NOME;
    const MAR_NOME_Name = 'MAR_NOME';

    [Restrictions([NoValidate])]
    [Column('MAR_NOMEAPELIDO', ftString, 10)]
    [Dictionary('MAR_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_NOMEAPELIDO: String read FMAR_NOMEAPELIDO write FMAR_NOMEAPELIDO;
    const MAR_NOMEAPELIDO_Name = 'MAR_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MAR_DATAALTERACAO', ftDateTime)]
    [Dictionary('MAR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MAR_DATAALTERACAO: TDateTime read FMAR_DATAALTERACAO write FMAR_DATAALTERACAO;
    const MAR_DATAALTERACAO_Name = 'MAR_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MAR_DESATIVADO', ftString, 1)]
    [Dictionary('MAR_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_DESATIVADO: String read FMAR_DESATIVADO write FMAR_DESATIVADO;
    const MAR_DESATIVADO_Name = 'MAR_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMAR_00)

end.
