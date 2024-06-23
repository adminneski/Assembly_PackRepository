unit express.dbo.AUDIT_SQLINFORMATION;

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
  [Table('AUDIT_SQLINFORMATION', '')]
  [PrimaryKey('AUD_GUID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AUD_GUID')]
  TDtoAUDIT_SQLINFORMATION = class
  private
    { Private declarations } 
    FAUD_GUID: String;
    FPES_CNPJ_CPF: String;
    FAUD_PROPERTY: String;
    FAUD_VALUE: String;
    FAUD_DATAHORAALTERACAO: TDateTime;
    FAUD_ORDER: Integer;
  public 
    { Public declarations } 
     const Table      = 'AUDIT_SQLINFORMATION';
     const PrimaryKey = 'AUD_GUID';
     const Sequence   = 'SEQ_AUD_GUID';

    [Restrictions([NoValidate, NotNull])]
    [Column('AUD_GUID', ftString, 38)]
    [Dictionary('AUD_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_GUID: String read FAUD_GUID write FAUD_GUID;
    const AUD_GUID_Name = 'AUD_GUID';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('AUD_PROPERTY', ftString, 100)]
    [Dictionary('AUD_PROPERTY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_PROPERTY: String read FAUD_PROPERTY write FAUD_PROPERTY;
    const AUD_PROPERTY_Name = 'AUD_PROPERTY';

    [Restrictions([NoValidate])]
    [Column('AUD_VALUE', ftString, 1000)]
    [Dictionary('AUD_VALUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_VALUE: String read FAUD_VALUE write FAUD_VALUE;
    const AUD_VALUE_Name = 'AUD_VALUE';

    [Restrictions([NoValidate])]
    [Column('AUD_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('AUD_DATAHORAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property AUD_DATAHORAALTERACAO: TDateTime read FAUD_DATAHORAALTERACAO write FAUD_DATAHORAALTERACAO;
    const AUD_DATAHORAALTERACAO_Name = 'AUD_DATAHORAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('AUD_ORDER', ftInteger)]
    [Dictionary('AUD_ORDER', 'Mensagem de validação', '0', '', '', taCenter)]
    property AUD_ORDER: Integer read FAUD_ORDER write FAUD_ORDER;
    const AUD_ORDER_Name = 'AUD_ORDER';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAUDIT_SQLINFORMATION)

end.
