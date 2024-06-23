unit express.dbo.ROT_00;

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
  [Table('ROT_00', '')]
  [PrimaryKey('ROT_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ROT_CODIGO')]
  TDtoROT_00 = class
  private
    { Private declarations } 
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FROT_NOMEAPELIDO: String;
    FROT_DESATIVADO: String;
    FROT_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'ROT_00';
     const PrimaryKey = 'ROT_CODIGO';
     const Sequence   = 'SEQ_ROT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ROT_DESCRICAO', ftString, 30)]
    [Dictionary('ROT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_DESCRICAO: String read FROT_DESCRICAO write FROT_DESCRICAO;
    const ROT_DESCRICAO_Name = 'ROT_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('ROT_NOMEAPELIDO', ftString, 10)]
    [Dictionary('ROT_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_NOMEAPELIDO: String read FROT_NOMEAPELIDO write FROT_NOMEAPELIDO;
    const ROT_NOMEAPELIDO_Name = 'ROT_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ROT_DESATIVADO', ftString, 1)]
    [Dictionary('ROT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_DESATIVADO: String read FROT_DESATIVADO write FROT_DESATIVADO;
    const ROT_DESATIVADO_Name = 'ROT_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ROT_DATAALTERACAO', ftDateTime)]
    [Dictionary('ROT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ROT_DATAALTERACAO: TDateTime read FROT_DATAALTERACAO write FROT_DATAALTERACAO;
    const ROT_DATAALTERACAO_Name = 'ROT_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoROT_00)

end.
