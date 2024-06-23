unit express.dbo.REG_00;

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
  [Table('REG_00', '')]
  [PrimaryKey('REG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_REG_CODIGO')]
  TDtoREG_00 = class
  private
    { Private declarations } 
    FREG_CODIGO: Integer;
    FREG_DESCRICAO: String;
    FREG_NOMEAPELIDO: String;
    FREG_DATAALTERACAO: TDateTime;
    FREG_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'REG_00';
     const PrimaryKey = 'REG_CODIGO';
     const Sequence   = 'SEQ_REG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_CODIGO', ftInteger)]
    [Dictionary('REG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property REG_CODIGO: Integer read FREG_CODIGO write FREG_CODIGO;
    const REG_CODIGO_Name = 'REG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_DESCRICAO', ftString, 30)]
    [Dictionary('REG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REG_DESCRICAO: String read FREG_DESCRICAO write FREG_DESCRICAO;
    const REG_DESCRICAO_Name = 'REG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('REG_NOMEAPELIDO', ftString, 10)]
    [Dictionary('REG_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REG_NOMEAPELIDO: String read FREG_NOMEAPELIDO write FREG_NOMEAPELIDO;
    const REG_NOMEAPELIDO_Name = 'REG_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_DATAALTERACAO', ftDateTime)]
    [Dictionary('REG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property REG_DATAALTERACAO: TDateTime read FREG_DATAALTERACAO write FREG_DATAALTERACAO;
    const REG_DATAALTERACAO_Name = 'REG_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_DESATIVADO', ftString, 1)]
    [Dictionary('REG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REG_DESATIVADO: String read FREG_DESATIVADO write FREG_DESATIVADO;
    const REG_DESATIVADO_Name = 'REG_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREG_00)

end.
