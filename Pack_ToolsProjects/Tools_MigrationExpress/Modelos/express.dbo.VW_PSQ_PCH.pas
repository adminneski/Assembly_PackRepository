unit express.dbo.VW_PSQ_PCH;

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
  [Table('VW_PSQ_PCH', '')]
  TDtoVW_PSQ_PCH = class
  private
    { Private declarations } 
    FPCH_ID: Integer;
    FPCH_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FPCH_PROCESSADO: String;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PCH';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_ID', ftInteger)]
    [Dictionary('PCH_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_ID: Integer read FPCH_ID write FPCH_ID;
    const PCH_ID_Name = 'PCH_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PCH_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PCH_DATALANCAMENTO: TDateTime read FPCH_DATALANCAMENTO write FPCH_DATALANCAMENTO;
    const PCH_DATALANCAMENTO_Name = 'PCH_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_PROCESSADO', ftString, 1)]
    [Dictionary('PCH_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PCH_PROCESSADO: String read FPCH_PROCESSADO write FPCH_PROCESSADO;
    const PCH_PROCESSADO_Name = 'PCH_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PCH)

end.
