unit express.dbo.BCO_00;

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
  [Table('BCO_00', '')]
  [PrimaryKey('BCO_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCO_CODIGO')]
  TDtoBCO_00 = class
  private
    { Private declarations } 
    FBCO_CODIGO: Integer;
    FBCO_NOME: String;
    FBCO_NOMEAPELIDO: String;
    FBCO_DESATIVADO: String;
    FBCO_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'BCO_00';
     const PrimaryKey = 'BCO_CODIGO';
     const Sequence   = 'SEQ_BCO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('BCO_NOMEAPELIDO', ftString, 10)]
    [Dictionary('BCO_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOMEAPELIDO: String read FBCO_NOMEAPELIDO write FBCO_NOMEAPELIDO;
    const BCO_NOMEAPELIDO_Name = 'BCO_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCO_DESATIVADO', ftString, 1)]
    [Dictionary('BCO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_DESATIVADO: String read FBCO_DESATIVADO write FBCO_DESATIVADO;
    const BCO_DESATIVADO_Name = 'BCO_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCO_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCO_DATAALTERACAO: TDateTime read FBCO_DATAALTERACAO write FBCO_DATAALTERACAO;
    const BCO_DATAALTERACAO_Name = 'BCO_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCO_00)

end.
