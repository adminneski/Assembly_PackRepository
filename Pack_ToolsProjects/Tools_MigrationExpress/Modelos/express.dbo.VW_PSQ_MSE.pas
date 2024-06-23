unit express.dbo.VW_PSQ_MSE;

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
  [Table('VW_PSQ_MSE', '')]
  TDtoVW_PSQ_MSE = class
  private
    { Private declarations } 
    FMSE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGOREMETENTE: Integer;
    FMSE_MENSAGEM: String;
    FMSE_DATALANCAMENTO: TDateTime;
    FMSE_ENVIADO: String;
    FMSE_DESATIVADO: String;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MSE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_ID', ftInteger)]
    [Dictionary('MSE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MSE_ID: Integer read FMSE_ID write FMSE_ID;
    const MSE_ID_Name = 'MSE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOREMETENTE', ftInteger)]
    [Dictionary('PES_CODIGOREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOREMETENTE: Integer read FPES_CODIGOREMETENTE write FPES_CODIGOREMETENTE;
    const PES_CODIGOREMETENTE_Name = 'PES_CODIGOREMETENTE';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_ENVIADO', ftString, 1)]
    [Dictionary('MSE_ENVIADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSE_ENVIADO: String read FMSE_ENVIADO write FMSE_ENVIADO;
    const MSE_ENVIADO_Name = 'MSE_ENVIADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_DESATIVADO', ftString, 1)]
    [Dictionary('MSE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MSE_DESATIVADO: String read FMSE_DESATIVADO write FMSE_DESATIVADO;
    const MSE_DESATIVADO_Name = 'MSE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MSE)

end.
