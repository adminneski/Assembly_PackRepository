unit express.dbo.VW_SQLINFORMATION;

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
  [Table('VW_SQLInformation', '')]
  TDtoVW_SQLInformation = class
  private
    { Private declarations } 
    FAUD_Order: Integer;
    FAUD_Property: String;
    FAUD_Value: String;
  public 
    { Public declarations } 
     const Table      = 'VW_SQLInformation';

    [Restrictions([NoValidate, NotNull])]
    [Column('AUD_Order', ftInteger)]
    [Dictionary('AUD_Order', 'Mensagem de validação', '0', '', '', taCenter)]
    property AUD_Order: Integer read FAUD_Order write FAUD_Order;
    const AUD_Order_Name = 'AUD_Order';

    [Restrictions([NoValidate, NotNull])]
    [Column('AUD_Property', ftString, 27)]
    [Dictionary('AUD_Property', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_Property: String read FAUD_Property write FAUD_Property;
    const AUD_Property_Name = 'AUD_Property';

    [Restrictions([NoValidate])]
    [Column('AUD_Value', ftString, 8000)]
    [Dictionary('AUD_Value', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_Value: String read FAUD_Value write FAUD_Value;
    const AUD_Value_Name = 'AUD_Value';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_SQLInformation)

end.
