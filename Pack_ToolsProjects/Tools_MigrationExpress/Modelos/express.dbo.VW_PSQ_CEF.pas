unit express.dbo.VW_PSQ_CEF;

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
  [Table('VW_PSQ_CEF', '')]
  TDtoVW_PSQ_CEF = class
  private
    { Private declarations } 
    FCEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FCEF_NUMERODOCTO: String;
    FCEF_DATALANCAMENTO: TDateTime;
    FCEF_TOTALQTDENTREGUE: Double;
    FCEF_CANCELADO: String;
    FCEF_PROCESSADO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CEF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_ID', ftInteger)]
    [Dictionary('CEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_ID: Integer read FCEF_ID write FCEF_ID;
    const CEF_ID_Name = 'CEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CEF_NUMERODOCTO', ftString, 15)]
    [Dictionary('CEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_NUMERODOCTO: String read FCEF_NUMERODOCTO write FCEF_NUMERODOCTO;
    const CEF_NUMERODOCTO_Name = 'CEF_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CEF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CEF_DATALANCAMENTO: TDateTime read FCEF_DATALANCAMENTO write FCEF_DATALANCAMENTO;
    const CEF_DATALANCAMENTO_Name = 'CEF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_TOTALQTDENTREGUE', ftBCD, 18, 4)]
    [Dictionary('CEF_TOTALQTDENTREGUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CEF_TOTALQTDENTREGUE: Double read FCEF_TOTALQTDENTREGUE write FCEF_TOTALQTDENTREGUE;
    const CEF_TOTALQTDENTREGUE_Name = 'CEF_TOTALQTDENTREGUE';

    [Restrictions([NoValidate])]
    [Column('CEF_CANCELADO', ftString, 1)]
    [Dictionary('CEF_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_CANCELADO: String read FCEF_CANCELADO write FCEF_CANCELADO;
    const CEF_CANCELADO_Name = 'CEF_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CEF_PROCESSADO', ftString, 1)]
    [Dictionary('CEF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_PROCESSADO: String read FCEF_PROCESSADO write FCEF_PROCESSADO;
    const CEF_PROCESSADO_Name = 'CEF_PROCESSADO';

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
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CEF)

end.
