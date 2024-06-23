unit express.dbo.VW_PSQ_TRC;

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
  [Table('VW_PSQ_TRC', '')]
  TDtoVW_PSQ_TRC = class
  private
    { Private declarations } 
    FTRC_ID: Integer;
    FCOM_CODIGO: Integer;
    FTRC_NUMERODOCTO: String;
    FTRC_CANCELADA: String;
    FTRC_PROCESSADO: String;
    FTRC_DATALANCAMENTO: TDateTime;
    FTRC_TOTALLIQUIDO: Double;
    FTRC_TOTALQTDTROCADA: Double;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_TRC';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_ID', ftInteger)]
    [Dictionary('TRC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_ID: Integer read FTRC_ID write FTRC_ID;
    const TRC_ID_Name = 'TRC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_NUMERODOCTO', ftString, 10)]
    [Dictionary('TRC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_NUMERODOCTO: String read FTRC_NUMERODOCTO write FTRC_NUMERODOCTO;
    const TRC_NUMERODOCTO_Name = 'TRC_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_CANCELADA', ftString, 1)]
    [Dictionary('TRC_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_CANCELADA: String read FTRC_CANCELADA write FTRC_CANCELADA;
    const TRC_CANCELADA_Name = 'TRC_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_PROCESSADO', ftString, 1)]
    [Dictionary('TRC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_PROCESSADO: String read FTRC_PROCESSADO write FTRC_PROCESSADO;
    const TRC_PROCESSADO_Name = 'TRC_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('TRC_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TRC_DATALANCAMENTO: TDateTime read FTRC_DATALANCAMENTO write FTRC_DATALANCAMENTO;
    const TRC_DATALANCAMENTO_Name = 'TRC_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALLIQUIDO', ftBCD)]
    [Dictionary('TRC_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALLIQUIDO: Double read FTRC_TOTALLIQUIDO write FTRC_TOTALLIQUIDO;
    const TRC_TOTALLIQUIDO_Name = 'TRC_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALQTDTROCADA', ftBCD)]
    [Dictionary('TRC_TOTALQTDTROCADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALQTDTROCADA: Double read FTRC_TOTALQTDTROCADA write FTRC_TOTALQTDTROCADA;
    const TRC_TOTALQTDTROCADA_Name = 'TRC_TOTALQTDTROCADA';

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
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_TRC)

end.
