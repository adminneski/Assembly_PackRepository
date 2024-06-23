unit express.dbo.PES_00_05;

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
  [Table('PES_00_05', '')]
  [PrimaryKey('PES_05_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PES_05_ID')]
  TDtoPES_00_05 = class
  private
    { Private declarations } 
    FPES_05_ID: Integer;
    FPES_CODIGO: Integer;
    FPES_NOMECONTATO: String;
    FPES_EMAILCONTATO: String;
    FPES_DDD_TELEFONECONTATO: String;
    FPES_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PES_00_05';
     const PrimaryKey = 'PES_05_ID';
     const Sequence   = 'SEQ_PES_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_05_ID', ftInteger)]
    [Dictionary('PES_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_05_ID: Integer read FPES_05_ID write FPES_05_ID;
    const PES_05_ID_Name = 'PES_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECONTATO', ftString, 50)]
    [Dictionary('PES_NOMECONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECONTATO: String read FPES_NOMECONTATO write FPES_NOMECONTATO;
    const PES_NOMECONTATO_Name = 'PES_NOMECONTATO';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILCONTATO', ftString, 50)]
    [Dictionary('PES_EMAILCONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILCONTATO: String read FPES_EMAILCONTATO write FPES_EMAILCONTATO;
    const PES_EMAILCONTATO_Name = 'PES_EMAILCONTATO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONECONTATO', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONECONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONECONTATO: String read FPES_DDD_TELEFONECONTATO write FPES_DDD_TELEFONECONTATO;
    const PES_DDD_TELEFONECONTATO_Name = 'PES_DDD_TELEFONECONTATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATAALTERACAO', ftDateTime)]
    [Dictionary('PES_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATAALTERACAO: TDateTime read FPES_DATAALTERACAO write FPES_DATAALTERACAO;
    const PES_DATAALTERACAO_Name = 'PES_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPES_00_05)

end.
