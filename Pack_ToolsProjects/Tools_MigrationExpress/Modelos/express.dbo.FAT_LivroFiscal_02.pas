unit express.dbo.FAT_LIVROFISCAL_02;

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
  [Table('FAT_LivroFiscal_02', '')]
  TDtoFAT_LivroFiscal_02 = class
  private
    { Private declarations } 
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_PERCENTUALISSITEM: Double;
    FFAT_PERCENTUALIRITEM: Double;
    FFAT_PERCENTUALCSLLITEM: Double;
    FFAT_VALORSERVICO: Double;
    FFAT_VALORISSITEM: Double;
    FFAT_VALORIRITEM: Double;
    FFAT_VALORCSLLITEM: Double;
    FFAT_VALORPISITEM: Double;
    FFAT_VALORCOFINSITEM: Double;
    FFAT_VALORBASECALCULOISSITEM: Double;
    FFAT_VALORBCALCULOPISCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'FAT_LivroFiscal_02';

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

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALISSITEM', ftBCD, 48, 2)]
    [Dictionary('FAT_PERCENTUALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALISSITEM: Double read FFAT_PERCENTUALISSITEM write FFAT_PERCENTUALISSITEM;
    const FAT_PERCENTUALISSITEM_Name = 'FAT_PERCENTUALISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIRITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIRITEM: Double read FFAT_PERCENTUALIRITEM write FFAT_PERCENTUALIRITEM;
    const FAT_PERCENTUALIRITEM_Name = 'FAT_PERCENTUALIRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALCSLLITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCSLLITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCSLLITEM: Double read FFAT_PERCENTUALCSLLITEM write FFAT_PERCENTUALCSLLITEM;
    const FAT_PERCENTUALCSLLITEM_Name = 'FAT_PERCENTUALCSLLITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORSERVICO', ftBCD)]
    [Dictionary('FAT_VALORSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORSERVICO: Double read FFAT_VALORSERVICO write FFAT_VALORSERVICO;
    const FAT_VALORSERVICO_Name = 'FAT_VALORSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORISSITEM', ftBCD, 10, 2)]
    [Dictionary('FAT_VALORISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORISSITEM: Double read FFAT_VALORISSITEM write FFAT_VALORISSITEM;
    const FAT_VALORISSITEM_Name = 'FAT_VALORISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORIRITEM', ftBCD)]
    [Dictionary('FAT_VALORIRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORIRITEM: Double read FFAT_VALORIRITEM write FFAT_VALORIRITEM;
    const FAT_VALORIRITEM_Name = 'FAT_VALORIRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORCSLLITEM', ftBCD)]
    [Dictionary('FAT_VALORCSLLITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCSLLITEM: Double read FFAT_VALORCSLLITEM write FFAT_VALORCSLLITEM;
    const FAT_VALORCSLLITEM_Name = 'FAT_VALORCSLLITEM';

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

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBASECALCULOISSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOISSITEM: Double read FFAT_VALORBASECALCULOISSITEM write FFAT_VALORBASECALCULOISSITEM;
    const FAT_VALORBASECALCULOISSITEM_Name = 'FAT_VALORBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('FAT_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBCALCULOPISCOFINSITEM: Double read FFAT_VALORBCALCULOPISCOFINSITEM write FFAT_VALORBCALCULOPISCOFINSITEM;
    const FAT_VALORBCALCULOPISCOFINSITEM_Name = 'FAT_VALORBCALCULOPISCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_LivroFiscal_02)

end.
