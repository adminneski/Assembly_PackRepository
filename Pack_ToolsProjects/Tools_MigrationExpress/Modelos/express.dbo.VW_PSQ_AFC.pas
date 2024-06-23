unit express.dbo.VW_PSQ_AFC;

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
  [Table('VW_PSQ_AFC', '')]
  TDtoVW_PSQ_AFC = class
  private
    { Private declarations } 
    FAFC_ID: Integer;
    FPES_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FAFC_DATALANCAMENTO: TDateTime;
    FPES_NOME: String;
    FAFC_DATAALTERACAO: TDateTime;
    FAFC_OBSERVACAO: String;
    FAFC_VALORCREDITO: Double;
    FAFC_TIPO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_AFC';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_ID', ftInteger)]
    [Dictionary('AFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property AFC_ID: Integer read FAFC_ID write FAFC_ID;
    const AFC_ID_Name = 'AFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('AFC_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property AFC_DATALANCAMENTO: TDateTime read FAFC_DATALANCAMENTO write FAFC_DATALANCAMENTO;
    const AFC_DATALANCAMENTO_Name = 'AFC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('AFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property AFC_DATAALTERACAO: TDateTime read FAFC_DATAALTERACAO write FAFC_DATAALTERACAO;
    const AFC_DATAALTERACAO_Name = 'AFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('AFC_OBSERVACAO', ftString, 300)]
    [Dictionary('AFC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AFC_OBSERVACAO: String read FAFC_OBSERVACAO write FAFC_OBSERVACAO;
    const AFC_OBSERVACAO_Name = 'AFC_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_VALORCREDITO', ftBCD)]
    [Dictionary('AFC_VALORCREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AFC_VALORCREDITO: Double read FAFC_VALORCREDITO write FAFC_VALORCREDITO;
    const AFC_VALORCREDITO_Name = 'AFC_VALORCREDITO';

    [Restrictions([NoValidate])]
    [Column('AFC_TIPO', ftString, 3)]
    [Dictionary('AFC_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AFC_TIPO: String read FAFC_TIPO write FAFC_TIPO;
    const AFC_TIPO_Name = 'AFC_TIPO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_AFC)

end.
