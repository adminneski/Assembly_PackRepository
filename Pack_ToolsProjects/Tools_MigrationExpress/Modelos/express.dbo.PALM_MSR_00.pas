unit express.dbo.PALM_MSR_00;

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
  [Table('PALM_MSR_00', '')]
  [PrimaryKey('MSR_ID', AutoInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('COM_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MSR_ID')]
  [Sequence('SEQ_COM_CODIGO')]
  TDtoPALM_MSR_00 = class
  private
    { Private declarations } 
    FMSR_ID: Integer;
    FCOM_CODIGO: Integer;
    FMSR_DATALANCAMENTO: TDateTime;
    FPES_CODIGOREMETENTE: Integer;
    FPES_CODIGODESTINATARIO: Integer;
    FMSR_MENSAGEM: String;
    FMSR_IMPORTADO: String;
    FMSR_DESATIVADO: String;
    FMSR_EXPORTADO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_MSR_00';
     const PrimaryKey = 'MSR_ID';
     const Sequence   = 'SEQ_MSR_ID';

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
    [Column('MSR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('MSR_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MSR_DATALANCAMENTO: TDateTime read FMSR_DATALANCAMENTO write FMSR_DATALANCAMENTO;
    const MSR_DATALANCAMENTO_Name = 'MSR_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGOREMETENTE', ftInteger)]
    [Dictionary('PES_CODIGOREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOREMETENTE: Integer read FPES_CODIGOREMETENTE write FPES_CODIGOREMETENTE;
    const PES_CODIGOREMETENTE_Name = 'PES_CODIGOREMETENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGODESTINATARIO', ftInteger)]
    [Dictionary('PES_CODIGODESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGODESTINATARIO: Integer read FPES_CODIGODESTINATARIO write FPES_CODIGODESTINATARIO;
    const PES_CODIGODESTINATARIO_Name = 'PES_CODIGODESTINATARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSR_MENSAGEM', ftString, 300)]
    [Dictionary('MSR_MENSAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSR_MENSAGEM: String read FMSR_MENSAGEM write FMSR_MENSAGEM;
    const MSR_MENSAGEM_Name = 'MSR_MENSAGEM';

    [Restrictions([NoValidate])]
    [Column('MSR_IMPORTADO', ftString, 1)]
    [Dictionary('MSR_IMPORTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSR_IMPORTADO: String read FMSR_IMPORTADO write FMSR_IMPORTADO;
    const MSR_IMPORTADO_Name = 'MSR_IMPORTADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSR_DESATIVADO', ftString, 1)]
    [Dictionary('MSR_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSR_DESATIVADO: String read FMSR_DESATIVADO write FMSR_DESATIVADO;
    const MSR_DESATIVADO_Name = 'MSR_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('MSR_EXPORTADO', ftString, 1)]
    [Dictionary('MSR_EXPORTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSR_EXPORTADO: String read FMSR_EXPORTADO write FMSR_EXPORTADO;
    const MSR_EXPORTADO_Name = 'MSR_EXPORTADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_MSR_00)

end.
