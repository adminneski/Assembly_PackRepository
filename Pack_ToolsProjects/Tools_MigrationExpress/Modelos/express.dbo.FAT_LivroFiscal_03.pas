unit express.dbo.FAT_LIVROFISCAL_03;

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
  [Table('FAT_LivroFiscal_03', '')]
  TDtoFAT_LivroFiscal_03 = class
  private
    { Private declarations } 
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FFAT_VALORITEM: Double;
    FFAT_VALORITEMBRUTO: Double;
    FFAT_VALORBCALCULOPISCOFINSITEM: Double;
    FFAT_VALORPISITEM: Double;
    FFAT_VALORCOFINSITEM: Double;
    FFAT_PERCENTUALPISITEM: Double;
    FFAT_PERCENTUALCOFINSITEM: Double;
    FFAT_TOTALICMSDESONERADO: Double;
  public 
    { Public declarations } 
     const Table      = 'FAT_LivroFiscal_03';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

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
    [Column('FAT_VALORITEM', ftBCD, 10, 2)]
    [Dictionary('FAT_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORITEM: Double read FFAT_VALORITEM write FFAT_VALORITEM;
    const FAT_VALORITEM_Name = 'FAT_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORITEMBRUTO', ftBCD)]
    [Dictionary('FAT_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORITEMBRUTO: Double read FFAT_VALORITEMBRUTO write FFAT_VALORITEMBRUTO;
    const FAT_VALORITEMBRUTO_Name = 'FAT_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('FAT_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBCALCULOPISCOFINSITEM: Double read FFAT_VALORBCALCULOPISCOFINSITEM write FFAT_VALORBCALCULOPISCOFINSITEM;
    const FAT_VALORBCALCULOPISCOFINSITEM_Name = 'FAT_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPISITEM', ftBCD)]
    [Dictionary('FAT_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPISITEM: Double read FFAT_VALORPISITEM write FFAT_VALORPISITEM;
    const FAT_VALORPISITEM_Name = 'FAT_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORCOFINSITEM', ftBCD)]
    [Dictionary('FAT_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOFINSITEM: Double read FFAT_VALORCOFINSITEM write FFAT_VALORCOFINSITEM;
    const FAT_VALORCOFINSITEM_Name = 'FAT_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALPISITEM: Double read FFAT_PERCENTUALPISITEM write FFAT_PERCENTUALPISITEM;
    const FAT_PERCENTUALPISITEM_Name = 'FAT_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOFINSITEM: Double read FFAT_PERCENTUALCOFINSITEM write FFAT_PERCENTUALCOFINSITEM;
    const FAT_PERCENTUALCOFINSITEM_Name = 'FAT_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSDESONERADO', ftBCD)]
    [Dictionary('FAT_TOTALICMSDESONERADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSDESONERADO: Double read FFAT_TOTALICMSDESONERADO write FFAT_TOTALICMSDESONERADO;
    const FAT_TOTALICMSDESONERADO_Name = 'FAT_TOTALICMSDESONERADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_LivroFiscal_03)

end.
