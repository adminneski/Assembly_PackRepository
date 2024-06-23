unit express.dbo.G_TICKET_00_01;

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
  [Table('G_TICKET_00_01', '')]
  [PrimaryKey('TKT_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TKT_01_ID')]
  TDtoG_TICKET_00_01 = class
  private
    { Private declarations } 
    FTKT_01_ID: Integer;
    FTKT_CODIGO: Integer;
    FTKT_DATAHORACONVERSATION: TDateTime;
    FTKT_CONVERSATION: TBlob;
    FTKT_IMAGECONVERSATION: TBlob;
    FACC_CODIGO_OPERADOR: Integer;
    FACC_CODIGO_ATENDENTE: Integer;
  public 
    { Public declarations } 
     const Table      = 'G_TICKET_00_01';
     const PrimaryKey = 'TKT_01_ID';
     const Sequence   = 'SEQ_TKT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TKT_01_ID', ftInteger)]
    [Dictionary('TKT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TKT_01_ID: Integer read FTKT_01_ID write FTKT_01_ID;
    const TKT_01_ID_Name = 'TKT_01_ID';

    [Restrictions([NoValidate])]
    [Column('TKT_CODIGO', ftInteger)]
    [Dictionary('TKT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TKT_CODIGO: Integer read FTKT_CODIGO write FTKT_CODIGO;
    const TKT_CODIGO_Name = 'TKT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TKT_DATAHORACONVERSATION', ftDateTime)]
    [Dictionary('TKT_DATAHORACONVERSATION', 'Mensagem de validação', '', '', '', taCenter)]
    property TKT_DATAHORACONVERSATION: TDateTime read FTKT_DATAHORACONVERSATION write FTKT_DATAHORACONVERSATION;
    const TKT_DATAHORACONVERSATION_Name = 'TKT_DATAHORACONVERSATION';

    [Restrictions([NoValidate])]
    [Column('TKT_CONVERSATION', ftBlob)]
    [Dictionary('TKT_CONVERSATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TKT_CONVERSATION: TBlob read FTKT_CONVERSATION write FTKT_CONVERSATION;
    const TKT_CONVERSATION_Name = 'TKT_CONVERSATION';

    [Restrictions([NoValidate])]
    [Column('TKT_IMAGECONVERSATION', ftBlob)]
    [Dictionary('TKT_IMAGECONVERSATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TKT_IMAGECONVERSATION: TBlob read FTKT_IMAGECONVERSATION write FTKT_IMAGECONVERSATION;
    const TKT_IMAGECONVERSATION_Name = 'TKT_IMAGECONVERSATION';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_OPERADOR', ftInteger)]
    [Dictionary('ACC_CODIGO_OPERADOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_OPERADOR: Integer read FACC_CODIGO_OPERADOR write FACC_CODIGO_OPERADOR;
    const ACC_CODIGO_OPERADOR_Name = 'ACC_CODIGO_OPERADOR';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO_ATENDENTE', ftInteger)]
    [Dictionary('ACC_CODIGO_ATENDENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO_ATENDENTE: Integer read FACC_CODIGO_ATENDENTE write FACC_CODIGO_ATENDENTE;
    const ACC_CODIGO_ATENDENTE_Name = 'ACC_CODIGO_ATENDENTE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_TICKET_00_01)

end.
