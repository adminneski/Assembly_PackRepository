unit express.dbo.VW_DASHBOARD_FATSER;

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
  [Table('VW_DASHBOARD_FATSER', '')]
  TDtoVW_DASHBOARD_FATSER = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLABEL: String;
    FANOMES: String;
    FVALUE: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_DASHBOARD_FATSER';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LABEL', ftString, 30)]
    [Dictionary('LABEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LABEL: String read FLABEL write FLABEL;
    const LABEL_Name = 'LABEL';

    [Restrictions([NoValidate])]
    [Column('ANOMES', ftString, 6)]
    [Dictionary('ANOMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ANOMES: String read FANOMES write FANOMES;
    const ANOMES_Name = 'ANOMES';

    [Restrictions([NoValidate])]
    [Column('VALUE', ftBCD)]
    [Dictionary('VALUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VALUE: Double read FVALUE write FVALUE;
    const VALUE_Name = 'VALUE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_DASHBOARD_FATSER)

end.
