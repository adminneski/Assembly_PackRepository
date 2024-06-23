unit express.dbo.ZVERSION;

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
  [Table('ZVERSION', '')]
  TDtoZVERSION = class
  private
    { Private declarations } 
    FVRS_NUMBER_2332: Integer;
  public 
    { Public declarations } 
     const Table      = 'ZVERSION';

    [Restrictions([NoValidate])]
    [Column('VRS_NUMBER_2332', ftInteger)]
    [Dictionary('VRS_NUMBER_2332', 'Mensagem de validação', '0', '', '', taCenter)]
    property VRS_NUMBER_2332: Integer read FVRS_NUMBER_2332 write FVRS_NUMBER_2332;
    const VRS_NUMBER_2332_Name = 'VRS_NUMBER_2332';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoZVERSION)

end.
