unit express.dbo.REL_V01_RFC;

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
  [Table('REL_V01_RFC', '')]
  TDtoREL_V01_RFC = class
  private
    { Private declarations } 
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FRFC_TOTALAVISTA: Double;
    FRFC_TOTALCHEQUE: Double;
    FRFC_TOTALCARTEIRA: Double;
    FRFC_TOTALBOLETO: Double;
    FRFC_TOTALCARTAOCREDITO: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_RFC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RFC_TOTALAVISTA', ftBCD)]
    [Dictionary('RFC_TOTALAVISTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALAVISTA: Double read FRFC_TOTALAVISTA write FRFC_TOTALAVISTA;
    const RFC_TOTALAVISTA_Name = 'RFC_TOTALAVISTA';

    [Restrictions([NoValidate])]
    [Column('RFC_TOTALCHEQUE', ftBCD)]
    [Dictionary('RFC_TOTALCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALCHEQUE: Double read FRFC_TOTALCHEQUE write FRFC_TOTALCHEQUE;
    const RFC_TOTALCHEQUE_Name = 'RFC_TOTALCHEQUE';

    [Restrictions([NoValidate])]
    [Column('RFC_TOTALCARTEIRA', ftBCD)]
    [Dictionary('RFC_TOTALCARTEIRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALCARTEIRA: Double read FRFC_TOTALCARTEIRA write FRFC_TOTALCARTEIRA;
    const RFC_TOTALCARTEIRA_Name = 'RFC_TOTALCARTEIRA';

    [Restrictions([NoValidate])]
    [Column('RFC_TOTALBOLETO', ftBCD)]
    [Dictionary('RFC_TOTALBOLETO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALBOLETO: Double read FRFC_TOTALBOLETO write FRFC_TOTALBOLETO;
    const RFC_TOTALBOLETO_Name = 'RFC_TOTALBOLETO';

    [Restrictions([NoValidate])]
    [Column('RFC_TOTALCARTAOCREDITO', ftBCD)]
    [Dictionary('RFC_TOTALCARTAOCREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALCARTAOCREDITO: Double read FRFC_TOTALCARTAOCREDITO write FRFC_TOTALCARTAOCREDITO;
    const RFC_TOTALCARTAOCREDITO_Name = 'RFC_TOTALCARTAOCREDITO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_RFC)

end.
