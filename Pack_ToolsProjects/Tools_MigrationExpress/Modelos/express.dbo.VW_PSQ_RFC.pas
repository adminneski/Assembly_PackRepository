unit express.dbo.VW_PSQ_RFC;

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
  [Table('VW_PSQ_RFC', '')]
  TDtoVW_PSQ_RFC = class
  private
    { Private declarations } 
    FRFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FRFC_DATALANCAMENTO: TDateTime;
    FRFC_PROCESSADO: String;
    FCGA_ID: Integer;
    FCGA_TITULOCARGA: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_RFC';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_ID', ftInteger)]
    [Dictionary('RFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID: Integer read FRFC_ID write FRFC_ID;
    const RFC_ID_Name = 'RFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('RFC_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RFC_DATALANCAMENTO: TDateTime read FRFC_DATALANCAMENTO write FRFC_DATALANCAMENTO;
    const RFC_DATALANCAMENTO_Name = 'RFC_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_PROCESSADO', ftString, 1)]
    [Dictionary('RFC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_PROCESSADO: String read FRFC_PROCESSADO write FRFC_PROCESSADO;
    const RFC_PROCESSADO_Name = 'RFC_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_TITULOCARGA', ftString, 40)]
    [Dictionary('CGA_TITULOCARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_TITULOCARGA: String read FCGA_TITULOCARGA write FCGA_TITULOCARGA;
    const CGA_TITULOCARGA_Name = 'CGA_TITULOCARGA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_RFC)

end.
