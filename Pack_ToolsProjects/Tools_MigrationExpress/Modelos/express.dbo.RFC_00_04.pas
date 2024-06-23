unit express.dbo.RFC_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.rfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('RFC_00_04', '')]
  [PrimaryKey('RFC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RFC_ID')]
  TDtoRFC_00_04 = class
  private
    { Private declarations } 
    FRFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FRFC_TOTALAVISTA: Double;
    FRFC_TOTALCHEQUE: Double;
    FRFC_TOTALCARTEIRA: Double;
    FRFC_TOTALBOLETO: Double;
    FRFC_TOTALCARTAOCREDITO: Double;
    FRFC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'RFC_00_04';
    const PrimaryKey = 'RFC_ID';
    const Sequence   = 'SEQ_RFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_ID', ftInteger)]
    [ForeignKey('RFC_00_04_fk', 'RFC_ID', 'RFC_00', 'RFC_ID', SetNull, SetNull)]
    [Dictionary('RFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID: Integer read FRFC_ID write FRFC_ID;
    const RFC_ID_Name = 'RFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALAVISTA', ftBCD, 1702129225, 2)]
    [Dictionary('RFC_TOTALAVISTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALAVISTA: Double read FRFC_TOTALAVISTA write FRFC_TOTALAVISTA;
    const RFC_TOTALAVISTA_Name = 'RFC_TOTALAVISTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALCHEQUE', ftBCD, 659507017, 2)]
    [Dictionary('RFC_TOTALCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALCHEQUE: Double read FRFC_TOTALCHEQUE write FRFC_TOTALCHEQUE;
    const RFC_TOTALCHEQUE_Name = 'RFC_TOTALCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALCARTEIRA', ftBCD, 1869770784, 2)]
    [Dictionary('RFC_TOTALCARTEIRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALCARTEIRA: Double read FRFC_TOTALCARTEIRA write FRFC_TOTALCARTEIRA;
    const RFC_TOTALCARTEIRA_Name = 'RFC_TOTALCARTEIRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALBOLETO', ftBCD, 1529377646, 2)]
    [Dictionary('RFC_TOTALBOLETO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALBOLETO: Double read FRFC_TOTALBOLETO write FRFC_TOTALBOLETO;
    const RFC_TOTALBOLETO_Name = 'RFC_TOTALBOLETO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALCARTAOCREDITO', ftBCD, 4522064, 2)]
    [Dictionary('RFC_TOTALCARTAOCREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALCARTAOCREDITO: Double read FRFC_TOTALCARTAOCREDITO write FRFC_TOTALCARTAOCREDITO;
    const RFC_TOTALCARTAOCREDITO_Name = 'RFC_TOTALCARTAOCREDITO';

    [Restrictions([NoValidate])]
    [Column('RFC_ID_OLD', ftInteger)]
    [Dictionary('RFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID_OLD: Integer read FRFC_ID_OLD write FRFC_ID_OLD;
    const RFC_ID_OLD_Name = 'RFC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRFC_00_04)

end.
