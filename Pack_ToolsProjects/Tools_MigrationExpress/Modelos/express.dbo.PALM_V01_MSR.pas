unit express.dbo.PALM_V01_MSR;

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
  [Table('PALM_V01_MSR', '')]
  TDtoPALM_V01_MSR = class
  private
    { Private declarations } 
    FMSR_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGOREMETENTE: Integer;
    FPES_NOMEREMETENTE: String;
    FPES_CODIGODESTINATARIO: Integer;
    FPES_NOMEDESTINATARIO: String;
    FMSR_MENSAGEM: String;
    FMSR_DATALANCAMENTO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_MSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSR_ID', ftInteger)]
    [Dictionary('MSR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MSR_ID: Integer read FMSR_ID write FMSR_ID;
    const MSR_ID_Name = 'MSR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGOREMETENTE', ftInteger)]
    [Dictionary('PES_CODIGOREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOREMETENTE: Integer read FPES_CODIGOREMETENTE write FPES_CODIGOREMETENTE;
    const PES_CODIGOREMETENTE_Name = 'PES_CODIGOREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEREMETENTE: String read FPES_NOMEREMETENTE write FPES_NOMEREMETENTE;
    const PES_NOMEREMETENTE_Name = 'PES_NOMEREMETENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGODESTINATARIO', ftInteger)]
    [Dictionary('PES_CODIGODESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGODESTINATARIO: Integer read FPES_CODIGODESTINATARIO write FPES_CODIGODESTINATARIO;
    const PES_CODIGODESTINATARIO_Name = 'PES_CODIGODESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEDESTINATARIO: String read FPES_NOMEDESTINATARIO write FPES_NOMEDESTINATARIO;
    const PES_NOMEDESTINATARIO_Name = 'PES_NOMEDESTINATARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSR_MENSAGEM', ftString, 300)]
    [Dictionary('MSR_MENSAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSR_MENSAGEM: String read FMSR_MENSAGEM write FMSR_MENSAGEM;
    const MSR_MENSAGEM_Name = 'MSR_MENSAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('MSR_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MSR_DATALANCAMENTO: TDateTime read FMSR_DATALANCAMENTO write FMSR_DATALANCAMENTO;
    const MSR_DATALANCAMENTO_Name = 'MSR_DATALANCAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_MSR)

end.
