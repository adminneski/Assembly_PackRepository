unit express.dbo.VW_PSQ_MNF;

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
  [Table('VW_PSQ_MNF', '')]
  TDtoVW_PSQ_MNF = class
  private
    { Private declarations } 
    FMNF_CODIGO: String;
    FMNF_DESCRICAO: String;
    FMNF_DESATIVADO: String;
    FMNF_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MNF';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_DESCRICAO', ftString, 100)]
    [Dictionary('MNF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_DESCRICAO: String read FMNF_DESCRICAO write FMNF_DESCRICAO;
    const MNF_DESCRICAO_Name = 'MNF_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_DESATIVADO', ftString, 1)]
    [Dictionary('MNF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_DESATIVADO: String read FMNF_DESATIVADO write FMNF_DESATIVADO;
    const MNF_DESATIVADO_Name = 'MNF_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_DATAALTERACAO', ftDateTime)]
    [Dictionary('MNF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MNF_DATAALTERACAO: TDateTime read FMNF_DATAALTERACAO write FMNF_DATAALTERACAO;
    const MNF_DATAALTERACAO_Name = 'MNF_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MNF)

end.
