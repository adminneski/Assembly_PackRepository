unit express.dbo.G_TICKET_00;

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
  [Table('G_TICKET_00', '')]
  [PrimaryKey('TKT_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TKT_CODIGO')]
  TDtoG_TICKET_00 = class
  private
    { Private declarations } 
    FTKT_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FTKT_DATAABERTURA: TDateTime;
    FTKT_HORAABERTURA: String;
    FCOM_CODIGO_CLIENTE: Integer;
    FACC_CODIGO_OPERADOR: Integer;
    FTKT_ASSUNTO: String;
    FACC_CODIGO_ATENDENTE: Integer;
    FTKT_STATUS: String;
  public 
    { Public declarations } 
     const Table      = 'G_TICKET_00';
     const PrimaryKey = 'TKT_CODIGO';
     const Sequence   = 'SEQ_TKT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TKT_CODIGO', ftInteger)]
    [Dictionary('TKT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TKT_CODIGO: Integer read FTKT_CODIGO write FTKT_CODIGO;
    const TKT_CODIGO_Name = 'TKT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TKT_DATAABERTURA', ftDateTime)]
    [Dictionary('TKT_DATAABERTURA', 'Mensagem de validação', '', '', '', taCenter)]
    property TKT_DATAABERTURA: TDateTime read FTKT_DATAABERTURA write FTKT_DATAABERTURA;
    const TKT_DATAABERTURA_Name = 'TKT_DATAABERTURA';

    [Restrictions([NoValidate])]
    [Column('TKT_HORAABERTURA', ftString, 6)]
    [Dictionary('TKT_HORAABERTURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TKT_HORAABERTURA: String read FTKT_HORAABERTURA write FTKT_HORAABERTURA;
    const TKT_HORAABERTURA_Name = 'TKT_HORAABERTURA';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO_CLIENTE', ftInteger)]
    [Dictionary('COM_CODIGO_CLIENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO_CLIENTE: Integer read FCOM_CODIGO_CLIENTE write FCOM_CODIGO_CLIENTE;
    const COM_CODIGO_CLIENTE_Name = 'COM_CODIGO_CLIENTE';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_OPERADOR', ftInteger)]
    [Dictionary('ACC_CODIGO_OPERADOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_OPERADOR: Integer read FACC_CODIGO_OPERADOR write FACC_CODIGO_OPERADOR;
    const ACC_CODIGO_OPERADOR_Name = 'ACC_CODIGO_OPERADOR';

    [Restrictions([NoValidate])]
    [Column('TKT_ASSUNTO', ftString, 30)]
    [Dictionary('TKT_ASSUNTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TKT_ASSUNTO: String read FTKT_ASSUNTO write FTKT_ASSUNTO;
    const TKT_ASSUNTO_Name = 'TKT_ASSUNTO';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_ATENDENTE', ftInteger)]
    [Dictionary('ACC_CODIGO_ATENDENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_ATENDENTE: Integer read FACC_CODIGO_ATENDENTE write FACC_CODIGO_ATENDENTE;
    const ACC_CODIGO_ATENDENTE_Name = 'ACC_CODIGO_ATENDENTE';

    [Restrictions([NoValidate])]
    [Column('TKT_STATUS', ftString, 3)]
    [Dictionary('TKT_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TKT_STATUS: String read FTKT_STATUS write FTKT_STATUS;
    const TKT_STATUS_Name = 'TKT_STATUS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_TICKET_00)

end.
