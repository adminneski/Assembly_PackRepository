unit express.dbo.VW_PSQ_SCR;

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
  [Table('VW_PSQ_SCR', '')]
  TDtoVW_PSQ_SCR = class
  private
    { Private declarations } 
    FSCR_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCR_DATALANCAMENTO: TDateTime;
    FSCR_TIPODOCUMENTO: String;
    FSCR_PROCESSADO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FSCR_TOTALVALORSUBSTITUIDO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_SCR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCR_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATALANCAMENTO: TDateTime read FSCR_DATALANCAMENTO write FSCR_DATALANCAMENTO;
    const SCR_DATALANCAMENTO_Name = 'SCR_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('SCR_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_TIPODOCUMENTO: String read FSCR_TIPODOCUMENTO write FSCR_TIPODOCUMENTO;
    const SCR_TIPODOCUMENTO_Name = 'SCR_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PROCESSADO', ftString, 1)]
    [Dictionary('SCR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_PROCESSADO: String read FSCR_PROCESSADO write FSCR_PROCESSADO;
    const SCR_PROCESSADO_Name = 'SCR_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALORSUBSTITUIDO', ftBCD)]
    [Dictionary('SCR_TOTALVALORSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALORSUBSTITUIDO: Double read FSCR_TOTALVALORSUBSTITUIDO write FSCR_TOTALVALORSUBSTITUIDO;
    const SCR_TOTALVALORSUBSTITUIDO_Name = 'SCR_TOTALVALORSUBSTITUIDO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_SCR)

end.
