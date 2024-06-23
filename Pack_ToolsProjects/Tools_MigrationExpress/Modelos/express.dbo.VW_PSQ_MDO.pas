unit express.dbo.VW_PSQ_MDO;

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
  [Table('VW_PSQ_MDO', '')]
  TDtoVW_PSQ_MDO = class
  private
    { Private declarations } 
    FMDO_CODIGO: Integer;
    FMDO_DESCRICAO: String;
    FMDO_PERIODOGARANTIA: String;
    FMDO_QUANTIDADEROHORA: Double;
    FMDO_VALORHORA: Double;
    FMDO_DESATIVADO: String;
    FMDO_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_DESCRICAO', ftString, 300)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('MDO_PERIODOGARANTIA', ftString, 2)]
    [Dictionary('MDO_PERIODOGARANTIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_PERIODOGARANTIA: String read FMDO_PERIODOGARANTIA write FMDO_PERIODOGARANTIA;
    const MDO_PERIODOGARANTIA_Name = 'MDO_PERIODOGARANTIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_QUANTIDADEROHORA', ftBCD)]
    [Dictionary('MDO_QUANTIDADEROHORA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MDO_QUANTIDADEROHORA: Double read FMDO_QUANTIDADEROHORA write FMDO_QUANTIDADEROHORA;
    const MDO_QUANTIDADEROHORA_Name = 'MDO_QUANTIDADEROHORA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_VALORHORA', ftBCD, 18, 4)]
    [Dictionary('MDO_VALORHORA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MDO_VALORHORA: Double read FMDO_VALORHORA write FMDO_VALORHORA;
    const MDO_VALORHORA_Name = 'MDO_VALORHORA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_DESATIVADO', ftString, 1)]
    [Dictionary('MDO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESATIVADO: String read FMDO_DESATIVADO write FMDO_DESATIVADO;
    const MDO_DESATIVADO_Name = 'MDO_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_DATAALTERACAO', ftDateTime)]
    [Dictionary('MDO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MDO_DATAALTERACAO: TDateTime read FMDO_DATAALTERACAO write FMDO_DATAALTERACAO;
    const MDO_DATAALTERACAO_Name = 'MDO_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MDO)

end.
