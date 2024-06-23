unit express.dbo.VW_PSQ_CTB;

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
  [Table('VW_PSQ_CTB', '')]
  TDtoVW_PSQ_CTB = class
  private
    { Private declarations } 
    FCTB_CODIGO: Integer;
    FCTB_DESCRICAO: String;
    FCTB_DESATIVADO: String;
    FCTB_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CTB';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTB_DESCRICAO', ftString, 50)]
    [Dictionary('CTB_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTB_DESCRICAO: String read FCTB_DESCRICAO write FCTB_DESCRICAO;
    const CTB_DESCRICAO_Name = 'CTB_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CTB_DESATIVADO', ftString, 1)]
    [Dictionary('CTB_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTB_DESATIVADO: String read FCTB_DESATIVADO write FCTB_DESATIVADO;
    const CTB_DESATIVADO_Name = 'CTB_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTB_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTB_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTB_DATAALTERACAO: TDateTime read FCTB_DATAALTERACAO write FCTB_DATAALTERACAO;
    const CTB_DATAALTERACAO_Name = 'CTB_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CTB)

end.
