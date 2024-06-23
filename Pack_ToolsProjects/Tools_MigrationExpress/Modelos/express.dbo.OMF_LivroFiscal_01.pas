unit express.dbo.OMF_LIVROFISCAL_01;

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
  [Table('OMF_LivroFiscal_01', '')]
  TDtoOMF_LivroFiscal_01 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FOMF_VALORITEMBRUTO: Double;
    FOMF_VALORITEM: Double;
    FOMF_VALORBASECALCULOICMSITEM: Double;
    FOMF_VALORICMSITEM: Double;
    FOMF_PERCENTUALICMSITEM: Double;
    FOMF_VALORBASECALCULOMVAITEM: Double;
    FOMF_VALORICMSRNFITEM: Double;
    FOMF_VALORBASEISENTOICMSITEM: Double;
    FOMF_VALORBASEOUTROSITEM: Double;
    FOMF_VALORIPIITEM: Double;
    FOMF_VALORDESPACESSORIAITEM: Double;
    FOMF_VALORFRETENFITEM: Double;
    FOMF_VALORBCALCULOPISCOFINSITEM: Double;
    FOMF_VALORPISITEM: Double;
    FOMF_VALORCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'OMF_LivroFiscal_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('OMF_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATALANCAMENTO: TDateTime read FOMF_DATALANCAMENTO write FOMF_DATALANCAMENTO;
    const OMF_DATALANCAMENTO_Name = 'OMF_DATALANCAMENTO';

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
    [Column('OMF_VALORITEMBRUTO', ftBCD)]
    [Dictionary('OMF_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORITEMBRUTO: Double read FOMF_VALORITEMBRUTO write FOMF_VALORITEMBRUTO;
    const OMF_VALORITEMBRUTO_Name = 'OMF_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORITEM', ftBCD)]
    [Dictionary('OMF_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORITEM: Double read FOMF_VALORITEM write FOMF_VALORITEM;
    const OMF_VALORITEM_Name = 'OMF_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('OMF_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASECALCULOICMSITEM: Double read FOMF_VALORBASECALCULOICMSITEM write FOMF_VALORBASECALCULOICMSITEM;
    const OMF_VALORBASECALCULOICMSITEM_Name = 'OMF_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORICMSITEM', ftBCD)]
    [Dictionary('OMF_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSITEM: Double read FOMF_VALORICMSITEM write FOMF_VALORICMSITEM;
    const OMF_VALORICMSITEM_Name = 'OMF_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSITEM: Double read FOMF_PERCENTUALICMSITEM write FOMF_PERCENTUALICMSITEM;
    const OMF_PERCENTUALICMSITEM_Name = 'OMF_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('OMF_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASECALCULOMVAITEM: Double read FOMF_VALORBASECALCULOMVAITEM write FOMF_VALORBASECALCULOMVAITEM;
    const OMF_VALORBASECALCULOMVAITEM_Name = 'OMF_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('OMF_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSRNFITEM: Double read FOMF_VALORICMSRNFITEM write FOMF_VALORICMSRNFITEM;
    const OMF_VALORICMSRNFITEM_Name = 'OMF_VALORICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('OMF_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASEISENTOICMSITEM: Double read FOMF_VALORBASEISENTOICMSITEM write FOMF_VALORBASEISENTOICMSITEM;
    const OMF_VALORBASEISENTOICMSITEM_Name = 'OMF_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBASEOUTROSITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASEOUTROSITEM: Double read FOMF_VALORBASEOUTROSITEM write FOMF_VALORBASEOUTROSITEM;
    const OMF_VALORBASEOUTROSITEM_Name = 'OMF_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORIPIITEM', ftBCD)]
    [Dictionary('OMF_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORIPIITEM: Double read FOMF_VALORIPIITEM write FOMF_VALORIPIITEM;
    const OMF_VALORIPIITEM_Name = 'OMF_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('OMF_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORDESPACESSORIAITEM: Double read FOMF_VALORDESPACESSORIAITEM write FOMF_VALORDESPACESSORIAITEM;
    const OMF_VALORDESPACESSORIAITEM_Name = 'OMF_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORFRETENFITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORFRETENFITEM: Double read FOMF_VALORFRETENFITEM write FOMF_VALORFRETENFITEM;
    const OMF_VALORFRETENFITEM_Name = 'OMF_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBCALCULOPISCOFINSITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBCALCULOPISCOFINSITEM: Double read FOMF_VALORBCALCULOPISCOFINSITEM write FOMF_VALORBCALCULOPISCOFINSITEM;
    const OMF_VALORBCALCULOPISCOFINSITEM_Name = 'OMF_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORPISITEM', ftBCD)]
    [Dictionary('OMF_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORPISITEM: Double read FOMF_VALORPISITEM write FOMF_VALORPISITEM;
    const OMF_VALORPISITEM_Name = 'OMF_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORCOFINSITEM', ftBCD)]
    [Dictionary('OMF_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCOFINSITEM: Double read FOMF_VALORCOFINSITEM write FOMF_VALORCOFINSITEM;
    const OMF_VALORCOFINSITEM_Name = 'OMF_VALORCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_LivroFiscal_01)

end.
