unit express.dbo.SCP_SQL_00;

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
  [Table('SCP_SQL_00', '')]
  TDtoSCP_SQL_00 = class
  private
    { Private declarations } 
    FSCP_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCP_DATALANCAMENTO: TDateTime;
    FSCP_PROCESSADO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'SCP_SQL_00';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_ID', ftInteger)]
    [Dictionary('SCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID: Integer read FSCP_ID write FSCP_ID;
    const SCP_ID_Name = 'SCP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATALANCAMENTO: TDateTime read FSCP_DATALANCAMENTO write FSCP_DATALANCAMENTO;
    const SCP_DATALANCAMENTO_Name = 'SCP_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_PROCESSADO', ftString, 1)]
    [Dictionary('SCP_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCP_PROCESSADO: String read FSCP_PROCESSADO write FSCP_PROCESSADO;
    const SCP_PROCESSADO_Name = 'SCP_PROCESSADO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCP_SQL_00)

end.
