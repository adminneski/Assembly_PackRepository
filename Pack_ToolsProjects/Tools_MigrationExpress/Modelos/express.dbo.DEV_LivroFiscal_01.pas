unit express.dbo.DEV_LIVROFISCAL_01;

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
  [Table('DEV_LivroFiscal_01', '')]
  TDtoDEV_LivroFiscal_01 = class
  private
    { Private declarations } 
    FDEV_ID: Integer;
    FCOM_CODIGO: Integer;
    FDEV_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FDEV_VALORITEMBRUTO: Double;
    FDEV_VALORITEM: Double;
    FDEV_VALORBASECALCULOICMSITEM: Double;
    FDEV_VALORICMSITEM: Double;
    FDEV_PERCENTUALICMSITEM: Double;
    FDEV_VALORBASECALCULOMVAITEM: Double;
    FDEV_VALORICMSRITEM: Double;
    FDEV_VALORBASEISENTOICMSITEM: Double;
    FDEV_VALORBASEOUTROSITEM: Double;
    FDEV_VALORIPIITEM: Double;
    FDEV_VALORDESPACESSORIAITEM: Double;
    FDEV_VALORFRETEITEM: Double;
    FDEV_VALORBCALCULOPISCOFINSITEM: Double;
    FDEV_VALORPISITEM: Double;
    FDEV_VALORCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'DEV_LivroFiscal_01';

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
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORITEMBRUTO', ftBCD)]
    [Dictionary('DEV_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORITEMBRUTO: Double read FDEV_VALORITEMBRUTO write FDEV_VALORITEMBRUTO;
    const DEV_VALORITEMBRUTO_Name = 'DEV_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORITEM', ftBCD)]
    [Dictionary('DEV_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORITEM: Double read FDEV_VALORITEM write FDEV_VALORITEM;
    const DEV_VALORITEM_Name = 'DEV_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('DEV_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOICMSITEM: Double read FDEV_VALORBASECALCULOICMSITEM write FDEV_VALORBASECALCULOICMSITEM;
    const DEV_VALORBASECALCULOICMSITEM_Name = 'DEV_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORICMSITEM', ftBCD)]
    [Dictionary('DEV_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSITEM: Double read FDEV_VALORICMSITEM write FDEV_VALORICMSITEM;
    const DEV_VALORICMSITEM_Name = 'DEV_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALICMSITEM: Double read FDEV_PERCENTUALICMSITEM write FDEV_PERCENTUALICMSITEM;
    const DEV_PERCENTUALICMSITEM_Name = 'DEV_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('DEV_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOMVAITEM: Double read FDEV_VALORBASECALCULOMVAITEM write FDEV_VALORBASECALCULOMVAITEM;
    const DEV_VALORBASECALCULOMVAITEM_Name = 'DEV_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORICMSRITEM', ftBCD)]
    [Dictionary('DEV_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSRITEM: Double read FDEV_VALORICMSRITEM write FDEV_VALORICMSRITEM;
    const DEV_VALORICMSRITEM_Name = 'DEV_VALORICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBASEISENTOICMSITEM', ftBCD, 10, 2)]
    [Dictionary('DEV_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEISENTOICMSITEM: Double read FDEV_VALORBASEISENTOICMSITEM write FDEV_VALORBASEISENTOICMSITEM;
    const DEV_VALORBASEISENTOICMSITEM_Name = 'DEV_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('DEV_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEOUTROSITEM: Double read FDEV_VALORBASEOUTROSITEM write FDEV_VALORBASEOUTROSITEM;
    const DEV_VALORBASEOUTROSITEM_Name = 'DEV_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORIPIITEM', ftBCD)]
    [Dictionary('DEV_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORIPIITEM: Double read FDEV_VALORIPIITEM write FDEV_VALORIPIITEM;
    const DEV_VALORIPIITEM_Name = 'DEV_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('DEV_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESPACESSORIAITEM: Double read FDEV_VALORDESPACESSORIAITEM write FDEV_VALORDESPACESSORIAITEM;
    const DEV_VALORDESPACESSORIAITEM_Name = 'DEV_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORFRETEITEM', ftBCD)]
    [Dictionary('DEV_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORFRETEITEM: Double read FDEV_VALORFRETEITEM write FDEV_VALORFRETEITEM;
    const DEV_VALORFRETEITEM_Name = 'DEV_VALORFRETEITEM';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDEV_LivroFiscal_01)

end.
