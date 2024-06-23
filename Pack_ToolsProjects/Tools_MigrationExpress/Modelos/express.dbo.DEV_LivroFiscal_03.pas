unit express.dbo.DEV_LIVROFISCAL_03;

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
  [Table('DEV_LivroFiscal_03', '')]
  TDtoDEV_LivroFiscal_03 = class
  private
    { Private declarations } 
    FDEV_ID: Integer;
    FCOM_CODIGO: Integer;
    FDEV_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FDEV_VALORITEM: Double;
    FDEV_VALORITEMBRUTO: Double;
    FDEV_VALORBCALCULOPISCOFINSITEM: Double;
    FDEV_VALORPISITEM: Double;
    FDEV_VALORCOFINSITEM: Double;
    FDEV_PERCENTUALPISITEM: Double;
    FDEV_PERCENTUALCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'DEV_LivroFiscal_03';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_ID', ftInteger)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;
    const DEV_ID_Name = 'DEV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DEV_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATALANCAMENTO: TDateTime read FDEV_DATALANCAMENTO write FDEV_DATALANCAMENTO;
    const DEV_DATALANCAMENTO_Name = 'DEV_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORITEM', ftBCD)]
    [Dictionary('DEV_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORITEM: Double read FDEV_VALORITEM write FDEV_VALORITEM;
    const DEV_VALORITEM_Name = 'DEV_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORITEMBRUTO', ftBCD)]
    [Dictionary('DEV_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORITEMBRUTO: Double read FDEV_VALORITEMBRUTO write FDEV_VALORITEMBRUTO;
    const DEV_VALORITEMBRUTO_Name = 'DEV_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('DEV_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBCALCULOPISCOFINSITEM: Double read FDEV_VALORBCALCULOPISCOFINSITEM write FDEV_VALORBCALCULOPISCOFINSITEM;
    const DEV_VALORBCALCULOPISCOFINSITEM_Name = 'DEV_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORPISITEM', ftBCD)]
    [Dictionary('DEV_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORPISITEM: Double read FDEV_VALORPISITEM write FDEV_VALORPISITEM;
    const DEV_VALORPISITEM_Name = 'DEV_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORCOFINSITEM', ftBCD)]
    [Dictionary('DEV_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOFINSITEM: Double read FDEV_VALORCOFINSITEM write FDEV_VALORCOFINSITEM;
    const DEV_VALORCOFINSITEM_Name = 'DEV_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALPISITEM', ftBCD, 10, 6)]
    [Dictionary('DEV_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALPISITEM: Double read FDEV_PERCENTUALPISITEM write FDEV_PERCENTUALPISITEM;
    const DEV_PERCENTUALPISITEM_Name = 'DEV_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOFINSITEM: Double read FDEV_PERCENTUALCOFINSITEM write FDEV_PERCENTUALCOFINSITEM;
    const DEV_PERCENTUALCOFINSITEM_Name = 'DEV_PERCENTUALCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDEV_LivroFiscal_03)

end.
