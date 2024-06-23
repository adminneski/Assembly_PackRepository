unit express.dbo.G_VW_PSQ_TICKET;

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
  [Table('G_VW_PSQ_TICKET', '')]
  TDtoG_VW_PSQ_TICKET = class
  private
    { Private declarations } 
    FTKT_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FTKT_DATAABERTURA: TDateTime;
    FTKT_HORAABERTURA: String;
    FCOM_CODIGO_CLIENTE: Integer;
    FCOM_RAZAO_CLIENTE: String;
    FCOM_FANTASIA_CLIENTE: String;
    FACC_CODIGO_OPERADOR: Integer;
    FACC_FULLNAME_OPERADOR: String;
    FTKT_ASSUNTO: String;
    FACC_CODIGO_ATENDENTE: Integer;
    FACC_FULLNAME_ATENTENDE: String;
    FTKT_STATUS: String;
  public 
    { Public declarations } 
     const Table      = 'G_VW_PSQ_TICKET';

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
    [Column('COM_RAZAO_CLIENTE', ftString, 100)]
    [Dictionary('COM_RAZAO_CLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO_CLIENTE: String read FCOM_RAZAO_CLIENTE write FCOM_RAZAO_CLIENTE;
    const COM_RAZAO_CLIENTE_Name = 'COM_RAZAO_CLIENTE';

    [Restrictions([NoValidate])]
    [Column('COM_FANTASIA_CLIENTE', ftString, 100)]
    [Dictionary('COM_FANTASIA_CLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_FANTASIA_CLIENTE: String read FCOM_FANTASIA_CLIENTE write FCOM_FANTASIA_CLIENTE;
    const COM_FANTASIA_CLIENTE_Name = 'COM_FANTASIA_CLIENTE';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_OPERADOR', ftInteger)]
    [Dictionary('ACC_CODIGO_OPERADOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_OPERADOR: Integer read FACC_CODIGO_OPERADOR write FACC_CODIGO_OPERADOR;
    const ACC_CODIGO_OPERADOR_Name = 'ACC_CODIGO_OPERADOR';

    [Restrictions([NoValidate])]
    [Column('ACC_FULLNAME_OPERADOR', ftString, 100)]
    [Dictionary('ACC_FULLNAME_OPERADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FULLNAME_OPERADOR: String read FACC_FULLNAME_OPERADOR write FACC_FULLNAME_OPERADOR;
    const ACC_FULLNAME_OPERADOR_Name = 'ACC_FULLNAME_OPERADOR';

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
    [Column('ACC_FULLNAME_ATENTENDE', ftString, 100)]
    [Dictionary('ACC_FULLNAME_ATENTENDE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACC_FULLNAME_ATENTENDE: String read FACC_FULLNAME_ATENTENDE write FACC_FULLNAME_ATENTENDE;
    const ACC_FULLNAME_ATENTENDE_Name = 'ACC_FULLNAME_ATENTENDE';

    [Restrictions([NoValidate])]
    [Column('TKT_STATUS', ftString, 3)]
    [Dictionary('TKT_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TKT_STATUS: String read FTKT_STATUS write FTKT_STATUS;
    const TKT_STATUS_Name = 'TKT_STATUS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_VW_PSQ_TICKET)

end.
