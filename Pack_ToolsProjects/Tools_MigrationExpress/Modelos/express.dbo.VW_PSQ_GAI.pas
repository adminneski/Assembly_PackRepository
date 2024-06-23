unit express.dbo.VW_PSQ_GAI;

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
  [Table('VW_PSQ_GAI', '')]
  TDtoVW_PSQ_GAI = class
  private
    { Private declarations } 
    FGAI_CODIGO: Integer;
    FGAI_DESCRICAO: String;
    FGAI_DESATIVADO: String;
    FGAI_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_GAI';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_DESCRICAO', ftString, 30)]
    [Dictionary('GAI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_DESCRICAO: String read FGAI_DESCRICAO write FGAI_DESCRICAO;
    const GAI_DESCRICAO_Name = 'GAI_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_DESATIVADO', ftString, 1)]
    [Dictionary('GAI_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_DESATIVADO: String read FGAI_DESATIVADO write FGAI_DESATIVADO;
    const GAI_DESATIVADO_Name = 'GAI_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_DATAALTERACAO', ftDateTime)]
    [Dictionary('GAI_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property GAI_DATAALTERACAO: TDateTime read FGAI_DATAALTERACAO write FGAI_DATAALTERACAO;
    const GAI_DATAALTERACAO_Name = 'GAI_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_GAI)

end.
