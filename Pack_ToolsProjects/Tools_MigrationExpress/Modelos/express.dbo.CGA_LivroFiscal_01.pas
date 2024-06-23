unit express.dbo.CGA_LIVROFISCAL_01;

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
  [Table('CGA_LivroFiscal_01', '')]
  TDtoCGA_LivroFiscal_01 = class
  private
    { Private declarations } 
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FGAI_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FLEE_COMENTARIO: String;
    FFAT_VALORITEMBRUTO: Double;
    FFAT_VALORITEM: Double;
    FFAT_VALORBASECALCULOICMSITEM: Double;
    FFAT_VALORICMSITEM: Double;
    FFAT_PERCENTUALICMSITEM: Double;
    FFAT_VALORBASECALCULOMVAITEM: Double;
    FFAT_VALORICMSRITEM: Double;
    FFAT_VALORBASEISENTOICMSITEM: Double;
    FFAT_VALORBASEOUTROSITEM: Double;
    FFAT_VALORIPIITEM: Double;
    FFAT_VALORDESPACESSORIAITEM: Double;
    FFAT_VALORFRETEITEM: Double;
    FFAT_VALORBCALCULOPISCOFINSITEM: Double;
    FFAT_VALORPISITEM: Double;
    FFAT_VALORCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'CGA_LivroFiscal_01';

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
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_COMENTARIO', ftString, 300)]
    [Dictionary('LEE_COMENTARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_COMENTARIO: String read FLEE_COMENTARIO write FLEE_COMENTARIO;
    const LEE_COMENTARIO_Name = 'LEE_COMENTARIO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORITEMBRUTO', ftBCD)]
    [Dictionary('FAT_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORITEMBRUTO: Double read FFAT_VALORITEMBRUTO write FFAT_VALORITEMBRUTO;
    const FAT_VALORITEMBRUTO_Name = 'FAT_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORITEM', ftBCD)]
    [Dictionary('FAT_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORITEM: Double read FFAT_VALORITEM write FFAT_VALORITEM;
    const FAT_VALORITEM_Name = 'FAT_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOICMSITEM: Double read FFAT_VALORBASECALCULOICMSITEM write FFAT_VALORBASECALCULOICMSITEM;
    const FAT_VALORBASECALCULOICMSITEM_Name = 'FAT_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORICMSITEM', ftBCD, 16387, 2)]
    [Dictionary('FAT_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORICMSITEM: Double read FFAT_VALORICMSITEM write FFAT_VALORICMSITEM;
    const FAT_VALORICMSITEM_Name = 'FAT_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALICMSITEM: Double read FFAT_PERCENTUALICMSITEM write FFAT_PERCENTUALICMSITEM;
    const FAT_PERCENTUALICMSITEM_Name = 'FAT_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('FAT_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOMVAITEM: Double read FFAT_VALORBASECALCULOMVAITEM write FFAT_VALORBASECALCULOMVAITEM;
    const FAT_VALORBASECALCULOMVAITEM_Name = 'FAT_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORICMSRITEM', ftBCD)]
    [Dictionary('FAT_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORICMSRITEM: Double read FFAT_VALORICMSRITEM write FFAT_VALORICMSRITEM;
    const FAT_VALORICMSRITEM_Name = 'FAT_VALORICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASEISENTOICMSITEM: Double read FFAT_VALORBASEISENTOICMSITEM write FFAT_VALORBASEISENTOICMSITEM;
    const FAT_VALORBASEISENTOICMSITEM_Name = 'FAT_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASEOUTROSITEM: Double read FFAT_VALORBASEOUTROSITEM write FFAT_VALORBASEOUTROSITEM;
    const FAT_VALORBASEOUTROSITEM_Name = 'FAT_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORIPIITEM', ftBCD)]
    [Dictionary('FAT_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORIPIITEM: Double read FFAT_VALORIPIITEM write FFAT_VALORIPIITEM;
    const FAT_VALORIPIITEM_Name = 'FAT_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('FAT_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESPACESSORIAITEM: Double read FFAT_VALORDESPACESSORIAITEM write FFAT_VALORDESPACESSORIAITEM;
    const FAT_VALORDESPACESSORIAITEM_Name = 'FAT_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORFRETEITEM', ftBCD)]
    [Dictionary('FAT_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORFRETEITEM: Double read FFAT_VALORFRETEITEM write FFAT_VALORFRETEITEM;
    const FAT_VALORFRETEITEM_Name = 'FAT_VALORFRETEITEM';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCGA_LivroFiscal_01)

end.
