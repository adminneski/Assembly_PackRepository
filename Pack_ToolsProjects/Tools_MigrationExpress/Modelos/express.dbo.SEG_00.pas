unit express.dbo.SEG_00;

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
  [Table('SEG_00', '')]
  [PrimaryKey('SEG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SEG_CODIGO')]
  TDtoSEG_00 = class
  private
    { Private declarations } 
    FSEG_CODIGO: Integer;
    FSEG_DESCRICAO: String;
    FSEG_NOMEAPELIDO: String;
    FSEG_DATAALTERACAO: TDateTime;
    FSEG_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'SEG_00';
     const PrimaryKey = 'SEG_CODIGO';
     const Sequence   = 'SEQ_SEG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SEG_CODIGO', ftInteger)]
    [Dictionary('SEG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SEG_CODIGO: Integer read FSEG_CODIGO write FSEG_CODIGO;
    const SEG_CODIGO_Name = 'SEG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SEG_DESCRICAO', ftString, 30)]
    [Dictionary('SEG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SEG_DESCRICAO: String read FSEG_DESCRICAO write FSEG_DESCRICAO;
    const SEG_DESCRICAO_Name = 'SEG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SEG_NOMEAPELIDO', ftString, 10)]
    [Dictionary('SEG_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SEG_NOMEAPELIDO: String read FSEG_NOMEAPELIDO write FSEG_NOMEAPELIDO;
    const SEG_NOMEAPELIDO_Name = 'SEG_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SEG_DATAALTERACAO', ftDateTime)]
    [Dictionary('SEG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SEG_DATAALTERACAO: TDateTime read FSEG_DATAALTERACAO write FSEG_DATAALTERACAO;
    const SEG_DATAALTERACAO_Name = 'SEG_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SEG_DESATIVADO', ftString, 1)]
    [Dictionary('SEG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SEG_DESATIVADO: String read FSEG_DESATIVADO write FSEG_DESATIVADO;
    const SEG_DESATIVADO_Name = 'SEG_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSEG_00)

end.
