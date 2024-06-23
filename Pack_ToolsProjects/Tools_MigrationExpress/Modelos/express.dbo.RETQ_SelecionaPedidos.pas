unit express.dbo.RETQ_SELECIONAPEDIDOS;

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
  [Table('RETQ_SelecionaPedidos', '')]
  TDtoRETQ_SelecionaPedidos = class
  private
    { Private declarations } 
    FRETQ_TIPOMOVTO: String;
    FCOM_CODIGO: Integer;
    FRETQ_ID_OS: Integer;
    FRETQ_NUMERODOCTO: String;
    FRETQ_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'RETQ_SelecionaPedidos';

    [Restrictions([NoValidate])]
    [Column('RETQ_TIPOMOVTO', ftString, 5)]
    [Dictionary('RETQ_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_TIPOMOVTO: String read FRETQ_TIPOMOVTO write FRETQ_TIPOMOVTO;
    const RETQ_TIPOMOVTO_Name = 'RETQ_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RETQ_ID_OS', ftInteger)]
    [Dictionary('RETQ_ID_OS', 'Mensagem de validação', '0', '', '', taCenter)]
    property RETQ_ID_OS: Integer read FRETQ_ID_OS write FRETQ_ID_OS;
    const RETQ_ID_OS_Name = 'RETQ_ID_OS';

    [Restrictions([NoValidate])]
    [Column('RETQ_NUMERODOCTO', ftString, 15)]
    [Dictionary('RETQ_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_NUMERODOCTO: String read FRETQ_NUMERODOCTO write FRETQ_NUMERODOCTO;
    const RETQ_NUMERODOCTO_Name = 'RETQ_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('RETQ_DATALANCAMENTO', ftDateTime)]
    [Dictionary('RETQ_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RETQ_DATALANCAMENTO: TDateTime read FRETQ_DATALANCAMENTO write FRETQ_DATALANCAMENTO;
    const RETQ_DATALANCAMENTO_Name = 'RETQ_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRETQ_SelecionaPedidos)

end.
