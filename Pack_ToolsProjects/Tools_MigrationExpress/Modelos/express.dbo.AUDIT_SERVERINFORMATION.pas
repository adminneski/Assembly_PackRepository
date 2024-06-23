unit express.dbo.AUDIT_SERVERINFORMATION;

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
  [Table('AUDIT_SERVERINFORMATION', '')]
  [PrimaryKey('AUD_GUID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AUD_GUID')]
  TDtoAUDIT_SERVERINFORMATION = class
  private
    { Private declarations } 
    FAUD_GUID: String;
    FPES_CNPJ_CPF: String;
    FAUD_INFORMATION: String;
    FAUD_DATAHORAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'AUDIT_SERVERINFORMATION';
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
    [Column('AUD_INFORMATION', ftString, 8000)]
    [Dictionary('AUD_INFORMATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_INFORMATION: String read FAUD_INFORMATION write FAUD_INFORMATION;
    const AUD_INFORMATION_Name = 'AUD_INFORMATION';

    [Restrictions([NoValidate])]
    [Column('AUD_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('AUD_DATAHORAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property AUD_DATAHORAALTERACAO: TDateTime read FAUD_DATAHORAALTERACAO write FAUD_DATAHORAALTERACAO;
    const AUD_DATAHORAALTERACAO_Name = 'AUD_DATAHORAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAUDIT_SERVERINFORMATION)

end.
