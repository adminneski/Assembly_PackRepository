unit express.dbo.VW_PSQ_NTO;

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
  [Table('VW_PSQ_NTO', '')]
  TDtoVW_PSQ_NTO = class
  private
    { Private declarations } 
    FNTO_CODIGO: Integer;
    FNTO_DESCRICAO: String;
    FCFOP_CODIGODENTRO: String;
    FCFOP_CODIGOFORA: String;
    FNTO_DESATIVADO: String;
    FNTO_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_NTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGODENTRO', ftString, 4)]
    [Dictionary('CFOP_CODIGODENTRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGODENTRO: String read FCFOP_CODIGODENTRO write FCFOP_CODIGODENTRO;
    const CFOP_CODIGODENTRO_Name = 'CFOP_CODIGODENTRO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOFORA', ftString, 4)]
    [Dictionary('CFOP_CODIGOFORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOFORA: String read FCFOP_CODIGOFORA write FCFOP_CODIGOFORA;
    const CFOP_CODIGOFORA_Name = 'CFOP_CODIGOFORA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_DESATIVADO', ftString, 1)]
    [Dictionary('NTO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESATIVADO: String read FNTO_DESATIVADO write FNTO_DESATIVADO;
    const NTO_DESATIVADO_Name = 'NTO_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_DATAALTERACAO', ftDateTime)]
    [Dictionary('NTO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NTO_DATAALTERACAO: TDateTime read FNTO_DATAALTERACAO write FNTO_DATAALTERACAO;
    const NTO_DATAALTERACAO_Name = 'NTO_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_NTO)

end.
