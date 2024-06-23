unit express.dbo.PALM_V01_MSE;

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
  [Table('PALM_V01_MSE', '')]
  TDtoPALM_V01_MSE = class
  private
    { Private declarations } 
    FMSE_ID: Integer;
    FMSE_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FMSE_ENVIADO: String;
    FMSE_MENSAGEM: String;
    FMSE_DATALANCAMENTO: TDateTime;
    FPES_CODIGOREMETENTE: Integer;
    FPES_NOMEREMETENTE: String;
    FPES_CODIGODESTINATARIO: Integer;
    FPES_NOMEDESTINATARIO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_MSE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_ID', ftInteger)]
    [Dictionary('MSE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MSE_ID: Integer read FMSE_ID write FMSE_ID;
    const MSE_ID_Name = 'MSE_ID';

    [Restrictions([NoValidate])]
    [Column('MSE_01_ID', ftInteger)]
    [Dictionary('MSE_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MSE_01_ID: Integer read FMSE_01_ID write FMSE_01_ID;
    const MSE_01_ID_Name = 'MSE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_ENVIADO', ftString, 1)]
    [Dictionary('MSE_ENVIADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSE_ENVIADO: String read FMSE_ENVIADO write FMSE_ENVIADO;
    const MSE_ENVIADO_Name = 'MSE_ENVIADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_MENSAGEM', ftString, 300)]
    [Dictionary('MSE_MENSAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSE_MENSAGEM: String read FMSE_MENSAGEM write FMSE_MENSAGEM;
    const MSE_MENSAGEM_Name = 'MSE_MENSAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('MSE_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MSE_DATALANCAMENTO: TDateTime read FMSE_DATALANCAMENTO write FMSE_DATALANCAMENTO;
    const MSE_DATALANCAMENTO_Name = 'MSE_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOREMETENTE', ftInteger)]
    [Dictionary('PES_CODIGOREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOREMETENTE: Integer read FPES_CODIGOREMETENTE write FPES_CODIGOREMETENTE;
    const PES_CODIGOREMETENTE_Name = 'PES_CODIGOREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEREMETENTE: String read FPES_NOMEREMETENTE write FPES_NOMEREMETENTE;
    const PES_NOMEREMETENTE_Name = 'PES_NOMEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGODESTINATARIO', ftInteger)]
    [Dictionary('PES_CODIGODESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGODESTINATARIO: Integer read FPES_CODIGODESTINATARIO write FPES_CODIGODESTINATARIO;
    const PES_CODIGODESTINATARIO_Name = 'PES_CODIGODESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEDESTINATARIO: String read FPES_NOMEDESTINATARIO write FPES_NOMEDESTINATARIO;
    const PES_NOMEDESTINATARIO_Name = 'PES_NOMEDESTINATARIO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_MSE)

end.
