unit express.dbo.VW_PSQ_CMD;

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
  [Table('VW_PSQ_CMD', '')]
  TDtoVW_PSQ_CMD = class
  private
    { Private declarations } 
    FCMD_ID: Integer;
    FCOM_CODIGO: Integer;
    FCMD_NUMERODOCTO: String;
    FCMD_DATALANCAMENTO: TDateTime;
    FCMD_TOTALQTDCOMODATO: Double;
    FCMD_CANCELADO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CMD';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_ID', ftInteger)]
    [Dictionary('CMD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMD_ID: Integer read FCMD_ID write FCMD_ID;
    const CMD_ID_Name = 'CMD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CMD_NUMERODOCTO', ftString, 10)]
    [Dictionary('CMD_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMD_NUMERODOCTO: String read FCMD_NUMERODOCTO write FCMD_NUMERODOCTO;
    const CMD_NUMERODOCTO_Name = 'CMD_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CMD_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMD_DATALANCAMENTO: TDateTime read FCMD_DATALANCAMENTO write FCMD_DATALANCAMENTO;
    const CMD_DATALANCAMENTO_Name = 'CMD_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_TOTALQTDCOMODATO', ftBCD)]
    [Dictionary('CMD_TOTALQTDCOMODATO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMD_TOTALQTDCOMODATO: Double read FCMD_TOTALQTDCOMODATO write FCMD_TOTALQTDCOMODATO;
    const CMD_TOTALQTDCOMODATO_Name = 'CMD_TOTALQTDCOMODATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_CANCELADO', ftString, 1)]
    [Dictionary('CMD_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMD_CANCELADO: String read FCMD_CANCELADO write FCMD_CANCELADO;
    const CMD_CANCELADO_Name = 'CMD_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CMD)

end.
