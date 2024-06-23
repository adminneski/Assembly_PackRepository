unit express.dbo.G_HPA_00;

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
  [Table('G_HPA_00', '')]
  [PrimaryKey('HPA_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_HPA_CODIGO')]
  TDtoG_HPA_00 = class
  private
    { Private declarations } 
    FHPA_CODIGO: Integer;
    FHPA_TIPO: String;
    FHPA_DESCRICAO: String;
    FHPA_ATIVO: String;
    FHPA_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'G_HPA_00';
     const PrimaryKey = 'HPA_CODIGO';
     const Sequence   = 'SEQ_HPA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HPA_CODIGO', ftInteger)]
    [Dictionary('HPA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HPA_CODIGO: Integer read FHPA_CODIGO write FHPA_CODIGO;
    const HPA_CODIGO_Name = 'HPA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('HPA_TIPO', ftString, 2)]
    [Dictionary('HPA_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HPA_TIPO: String read FHPA_TIPO write FHPA_TIPO;
    const HPA_TIPO_Name = 'HPA_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HPA_DESCRICAO', ftString, 50)]
    [Dictionary('HPA_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HPA_DESCRICAO: String read FHPA_DESCRICAO write FHPA_DESCRICAO;
    const HPA_DESCRICAO_Name = 'HPA_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HPA_ATIVO', ftString, 1)]
    [Dictionary('HPA_ATIVO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HPA_ATIVO: String read FHPA_ATIVO write FHPA_ATIVO;
    const HPA_ATIVO_Name = 'HPA_ATIVO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('HPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property HPA_DATAALTERACAO: TDateTime read FHPA_DATAALTERACAO write FHPA_DATAALTERACAO;
    const HPA_DATAALTERACAO_Name = 'HPA_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_HPA_00)

end.
