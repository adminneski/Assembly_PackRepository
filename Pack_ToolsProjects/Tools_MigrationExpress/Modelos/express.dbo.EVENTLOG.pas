unit express.dbo.EVENTLOG;

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
  [Table('EVENTLOG', '')]
  [PrimaryKey('EVE_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_EVE_CODIGO')]
  TDtoEVENTLOG = class
  private
    { Private declarations } 
    FEVE_CODIGO: Integer;
    FEVE_DATA: TDateTime;
    FEVE_HORA: TTime;
    FEVE_FONTE: String;
    FEVE_TIPO: String;
    FEVE_TEXTO: TBlob;
    FCOM_CODIGO: Integer;
    FACC_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'EVENTLOG';
     const PrimaryKey = 'EVE_CODIGO';
     const Sequence   = 'SEQ_EVE_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('EVE_CODIGO', ftInteger)]
    [Dictionary('EVE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property EVE_CODIGO: Integer read FEVE_CODIGO write FEVE_CODIGO;
    const EVE_CODIGO_Name = 'EVE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('EVE_DATA', ftDateTime)]
    [Dictionary('EVE_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property EVE_DATA: TDateTime read FEVE_DATA write FEVE_DATA;
    const EVE_DATA_Name = 'EVE_DATA';

    [Restrictions([NoValidate])]
    [Column('EVE_HORA', ftTime)]
    [Dictionary('EVE_HORA', 'Mensagem de validação', '', '', '', taCenter)]
    property EVE_HORA: TTime read FEVE_HORA write FEVE_HORA;
    const EVE_HORA_Name = 'EVE_HORA';

    [Restrictions([NoValidate])]
    [Column('EVE_FONTE', ftString, 50)]
    [Dictionary('EVE_FONTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EVE_FONTE: String read FEVE_FONTE write FEVE_FONTE;
    const EVE_FONTE_Name = 'EVE_FONTE';

    [Restrictions([NoValidate])]
    [Column('EVE_TIPO', ftString, 30)]
    [Dictionary('EVE_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EVE_TIPO: String read FEVE_TIPO write FEVE_TIPO;
    const EVE_TIPO_Name = 'EVE_TIPO';

    [Restrictions([NoValidate])]
    [Column('EVE_TEXTO', ftBlob)]
    [Dictionary('EVE_TEXTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EVE_TEXTO: TBlob read FEVE_TEXTO write FEVE_TEXTO;
    const EVE_TEXTO_Name = 'EVE_TEXTO';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;
    const ACC_CODIGO_Name = 'ACC_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEVENTLOG)

end.
