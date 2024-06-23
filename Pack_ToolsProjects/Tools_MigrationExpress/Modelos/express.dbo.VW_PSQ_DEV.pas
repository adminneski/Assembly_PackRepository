unit express.dbo.VW_PSQ_DEV;

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
  [Table('VW_PSQ_DEV', '')]
  TDtoVW_PSQ_DEV = class
  private
    { Private declarations } 
    FDEV_ID: Integer;
    FCOM_CODIGO: Integer;
    FDEV_NOTAFISCAL: String;
    FDEV_NUMERODOCTO: String;
    FDEV_PROCESSADO: String;
    FDEV_LIVROFISCAL: String;
    FDEV_CANCELADA: String;
    FDEV_DATALANCAMENTO: TDateTime;
    FDEV_TOTALLIQUIDO: Double;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_DEV';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_ID', ftInteger)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;
    const DEV_ID_Name = 'DEV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEV_NOTAFISCAL', ftString, 9)]
    [Dictionary('DEV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NOTAFISCAL: String read FDEV_NOTAFISCAL write FDEV_NOTAFISCAL;
    const DEV_NOTAFISCAL_Name = 'DEV_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('DEV_NUMERODOCTO', ftString, 10)]
    [Dictionary('DEV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NUMERODOCTO: String read FDEV_NUMERODOCTO write FDEV_NUMERODOCTO;
    const DEV_NUMERODOCTO_Name = 'DEV_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('DEV_PROCESSADO', ftString, 1)]
    [Dictionary('DEV_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_PROCESSADO: String read FDEV_PROCESSADO write FDEV_PROCESSADO;
    const DEV_PROCESSADO_Name = 'DEV_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('DEV_LIVROFISCAL', ftString, 1)]
    [Dictionary('DEV_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_LIVROFISCAL: String read FDEV_LIVROFISCAL write FDEV_LIVROFISCAL;
    const DEV_LIVROFISCAL_Name = 'DEV_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('DEV_CANCELADA', ftString, 1)]
    [Dictionary('DEV_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CANCELADA: String read FDEV_CANCELADA write FDEV_CANCELADA;
    const DEV_CANCELADA_Name = 'DEV_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DEV_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATALANCAMENTO: TDateTime read FDEV_DATALANCAMENTO write FDEV_DATALANCAMENTO;
    const DEV_DATALANCAMENTO_Name = 'DEV_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TOTALLIQUIDO', ftBCD)]
    [Dictionary('DEV_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALLIQUIDO: Double read FDEV_TOTALLIQUIDO write FDEV_TOTALLIQUIDO;
    const DEV_TOTALLIQUIDO_Name = 'DEV_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
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
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_DEV)

end.
