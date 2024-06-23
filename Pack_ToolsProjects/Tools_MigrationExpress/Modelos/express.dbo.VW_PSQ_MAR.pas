unit express.dbo.VW_PSQ_MAR;

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
  [Table('VW_PSQ_MAR', '')]
  TDtoVW_PSQ_MAR = class
  private
    { Private declarations } 
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FMAR_DESATIVADO: String;
    FMAR_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MAR';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('MAR_DESATIVADO', ftString, 1)]
    [Dictionary('MAR_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_DESATIVADO: String read FMAR_DESATIVADO write FMAR_DESATIVADO;
    const MAR_DESATIVADO_Name = 'MAR_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MAR_DATAALTERACAO', ftDateTime)]
    [Dictionary('MAR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MAR_DATAALTERACAO: TDateTime read FMAR_DATAALTERACAO write FMAR_DATAALTERACAO;
    const MAR_DATAALTERACAO_Name = 'MAR_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MAR)

end.
