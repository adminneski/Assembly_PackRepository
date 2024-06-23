unit express.dbo.G_KEY_00;

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
  [Table('G_KEY_00', '')]
  [PrimaryKey('KEY_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_KEY_ID')]
  TDtoG_KEY_00 = class
  private
    { Private declarations } 
    FKEY_ID: Integer;
    FPES_CODIGO: Integer;
    FPES_CNPJ_CPF: String;
    FKEY_DATAHORAGERACAO: TDateTime;
    FKEY_TIPOLICENCIAMENTO: String;
    FKEY_CHAVEGERADA: String;
    FACC_ID: Integer;
    FKEY_ATENDENTE: String;
    FKEY_OPERADOR: String;
    FKEY_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'G_KEY_00';
     const PrimaryKey = 'KEY_ID';
     const Sequence   = 'SEQ_KEY_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('KEY_ID', ftInteger)]
    [Dictionary('KEY_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property KEY_ID: Integer read FKEY_ID write FKEY_ID;
    const KEY_ID_Name = 'KEY_ID';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('KEY_DATAHORAGERACAO', ftDateTime)]
    [Dictionary('KEY_DATAHORAGERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property KEY_DATAHORAGERACAO: TDateTime read FKEY_DATAHORAGERACAO write FKEY_DATAHORAGERACAO;
    const KEY_DATAHORAGERACAO_Name = 'KEY_DATAHORAGERACAO';

    [Restrictions([NoValidate])]
    [Column('KEY_TIPOLICENCIAMENTO', ftString, 1)]
    [Dictionary('KEY_TIPOLICENCIAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_TIPOLICENCIAMENTO: String read FKEY_TIPOLICENCIAMENTO write FKEY_TIPOLICENCIAMENTO;
    const KEY_TIPOLICENCIAMENTO_Name = 'KEY_TIPOLICENCIAMENTO';

    [Restrictions([NoValidate])]
    [Column('KEY_CHAVEGERADA', ftString, 30)]
    [Dictionary('KEY_CHAVEGERADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_CHAVEGERADA: String read FKEY_CHAVEGERADA write FKEY_CHAVEGERADA;
    const KEY_CHAVEGERADA_Name = 'KEY_CHAVEGERADA';

    [Restrictions([NoValidate])]
    [Column('ACC_ID', ftInteger)]
    [Dictionary('ACC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_ID: Integer read FACC_ID write FACC_ID;
    const ACC_ID_Name = 'ACC_ID';

    [Restrictions([NoValidate])]
    [Column('KEY_ATENDENTE', ftString, 100)]
    [Dictionary('KEY_ATENDENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_ATENDENTE: String read FKEY_ATENDENTE write FKEY_ATENDENTE;
    const KEY_ATENDENTE_Name = 'KEY_ATENDENTE';

    [Restrictions([NoValidate])]
    [Column('KEY_OPERADOR', ftString, 50)]
    [Dictionary('KEY_OPERADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_OPERADOR: String read FKEY_OPERADOR write FKEY_OPERADOR;
    const KEY_OPERADOR_Name = 'KEY_OPERADOR';

    [Restrictions([NoValidate])]
    [Column('KEY_OBSERVACAO', ftString, 3000)]
    [Dictionary('KEY_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property KEY_OBSERVACAO: String read FKEY_OBSERVACAO write FKEY_OBSERVACAO;
    const KEY_OBSERVACAO_Name = 'KEY_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_KEY_00)

end.
