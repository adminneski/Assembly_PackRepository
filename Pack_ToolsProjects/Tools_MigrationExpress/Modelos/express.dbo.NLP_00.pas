unit express.dbo.NLP_00;

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
  [Table('NLP_00', '')]
  [PrimaryKey('NLP_CODIGO', AutoInc, NoSort, False, 'Chave prim�ria')]
  [Sequence('SEQ_NLP_CODIGO')]
  TDtoNLP_00 = class
  private
    { Private declarations } 
    FNLP_CODIGO: Integer;
    FNLP_NUMEROLOTE: String;
    FNLP_DESCRICAO: String;
    FNLP_DESATIVADO: String;
    FNLP_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'NLP_00';
     const PrimaryKey = 'NLP_CODIGO';
     const Sequence   = 'SEQ_NLP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NLP_CODIGO', ftInteger)]
    [Dictionary('NLP_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property NLP_CODIGO: Integer read FNLP_CODIGO write FNLP_CODIGO;
    const NLP_CODIGO_Name = 'NLP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NLP_NUMEROLOTE', ftString, 15)]
    [Dictionary('NLP_NUMEROLOTE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property NLP_NUMEROLOTE: String read FNLP_NUMEROLOTE write FNLP_NUMEROLOTE;
    const NLP_NUMEROLOTE_Name = 'NLP_NUMEROLOTE';

    [Restrictions([NoValidate])]
    [Column('NLP_DESCRICAO', ftString, 100)]
    [Dictionary('NLP_DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property NLP_DESCRICAO: String read FNLP_DESCRICAO write FNLP_DESCRICAO;
    const NLP_DESCRICAO_Name = 'NLP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('NLP_DESATIVADO', ftString, 1)]
    [Dictionary('NLP_DESATIVADO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property NLP_DESATIVADO: String read FNLP_DESATIVADO write FNLP_DESATIVADO;
    const NLP_DESATIVADO_Name = 'NLP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('NLP_DATAALTERACAO', ftDateTime)]
    [Dictionary('NLP_DATAALTERACAO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property NLP_DATAALTERACAO: TDateTime read FNLP_DATAALTERACAO write FNLP_DATAALTERACAO;
    const NLP_DATAALTERACAO_Name = 'NLP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNLP_00)

end.