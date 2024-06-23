unit express.dbo.KEY_XX;

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
  [Table('KEY_XX', '')]
  [PrimaryKey('KEY_CNPJCPF', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_KEY_CNPJCPF')]
  TDtoKEY_XX = class
  private
    { Private declarations } 
    FKEY_CNPJCPF: String;
    FKEY_CODE: String;
    FKEY_CODEATIVACAO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'KEY_XX';
     const PrimaryKey = 'KEY_CNPJCPF';
     const Sequence   = 'SEQ_KEY_CNPJCPF';

    [Restrictions([NoValidate, NotNull])]
    [Column('KEY_CNPJCPF', ftString, 14)]
    [Dictionary('KEY_CNPJCPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_CNPJCPF: String read FKEY_CNPJCPF write FKEY_CNPJCPF;
    const KEY_CNPJCPF_Name = 'KEY_CNPJCPF';

    [Restrictions([NoValidate])]
    [Column('KEY_CODE', ftString, 500)]
    [Dictionary('KEY_CODE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_CODE: String read FKEY_CODE write FKEY_CODE;
    const KEY_CODE_Name = 'KEY_CODE';

    [Restrictions([NoValidate])]
    [Column('KEY_CODEATIVACAO', ftString, 200)]
    [Dictionary('KEY_CODEATIVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_CODEATIVACAO: String read FKEY_CODEATIVACAO write FKEY_CODEATIVACAO;
    const KEY_CODEATIVACAO_Name = 'KEY_CODEATIVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoKEY_XX)

end.
