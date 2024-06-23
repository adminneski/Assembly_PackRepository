unit express.dbo.VW_PSQ_RPA;

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
  [Table('VW_PSQ_RPA', '')]
  TDtoVW_PSQ_RPA = class
  private
    { Private declarations } 
    FRPA_ID: Integer;
    FCOM_CODIGO: Integer;
    FRPA_NUMERODOCTO: String;
    FRPA_PROCESSADO: String;
    FRPA_CANCELADO: String;
    FRPA_DATALANCAMENTO: TDateTime;
    FRPA_TOTALLIQUIDO: Double;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_RPA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_ID', ftInteger)]
    [Dictionary('RPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID: Integer read FRPA_ID write FRPA_ID;
    const RPA_ID_Name = 'RPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RPA_NUMERODOCTO', ftString, 6)]
    [Dictionary('RPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_NUMERODOCTO: String read FRPA_NUMERODOCTO write FRPA_NUMERODOCTO;
    const RPA_NUMERODOCTO_Name = 'RPA_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_PROCESSADO', ftString, 1)]
    [Dictionary('RPA_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_PROCESSADO: String read FRPA_PROCESSADO write FRPA_PROCESSADO;
    const RPA_PROCESSADO_Name = 'RPA_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_CANCELADO', ftString, 1)]
    [Dictionary('RPA_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CANCELADO: String read FRPA_CANCELADO write FRPA_CANCELADO;
    const RPA_CANCELADO_Name = 'RPA_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('RPA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RPA_DATALANCAMENTO: TDateTime read FRPA_DATALANCAMENTO write FRPA_DATALANCAMENTO;
    const RPA_DATALANCAMENTO_Name = 'RPA_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALLIQUIDO', ftBCD)]
    [Dictionary('RPA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALLIQUIDO: Double read FRPA_TOTALLIQUIDO write FRPA_TOTALLIQUIDO;
    const RPA_TOTALLIQUIDO_Name = 'RPA_TOTALLIQUIDO';

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
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_RPA)

end.
