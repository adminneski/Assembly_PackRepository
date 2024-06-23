unit express.dbo.NFE_LIVROFISCAL_01;

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
  [Table('NFE_LivroFiscal_01', '')]
  TDtoNFE_LivroFiscal_01 = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FNFE_VALORITEMBRUTO: Double;
    FNFE_VALORITEM: Double;
    FNFE_VALORBASECALCULOICMSITEM: Double;
    FNFE_VALORICMSITEM: Double;
    FNFE_PERCENTUALICMSITEM: Double;
    FNFE_VALORBASECALCULOMVAITEM: Double;
    FNFE_VALORICMSRNFITEM: Double;
    FNFE_VALORBASEISENTOICMSITEM: Double;
    FNFE_VALORBASEOUTROSITEM: Double;
    FNFE_VALORIPIITEM: Double;
    FNFE_VALORDESPACESSORIAITEM: Double;
    FNFE_VALORFRETENFITEM: Double;
    FNFE_VALORBCALCULOPISCOFINSITEM: Double;
    FNFE_VALORPISITEM: Double;
    FNFE_VALORCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'NFE_LivroFiscal_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFE_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATALANCAMENTO: TDateTime read FNFE_DATALANCAMENTO write FNFE_DATALANCAMENTO;
    const NFE_DATALANCAMENTO_Name = 'NFE_DATALANCAMENTO';

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
    [Column('NFE_VALORITEMBRUTO', ftBCD)]
    [Dictionary('NFE_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEMBRUTO: Double read FNFE_VALORITEMBRUTO write FNFE_VALORITEMBRUTO;
    const NFE_VALORITEMBRUTO_Name = 'NFE_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORITEM', ftBCD)]
    [Dictionary('NFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEM: Double read FNFE_VALORITEM write FNFE_VALORITEM;
    const NFE_VALORITEM_Name = 'NFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('NFE_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASECALCULOICMSITEM: Double read FNFE_VALORBASECALCULOICMSITEM write FNFE_VALORBASECALCULOICMSITEM;
    const NFE_VALORBASECALCULOICMSITEM_Name = 'NFE_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORICMSITEM', ftBCD)]
    [Dictionary('NFE_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSITEM: Double read FNFE_VALORICMSITEM write FNFE_VALORICMSITEM;
    const NFE_VALORICMSITEM_Name = 'NFE_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSITEM: Double read FNFE_PERCENTUALICMSITEM write FNFE_PERCENTUALICMSITEM;
    const NFE_PERCENTUALICMSITEM_Name = 'NFE_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBASECALCULOMVAITEM', ftBCD, 48, 2)]
    [Dictionary('NFE_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASECALCULOMVAITEM: Double read FNFE_VALORBASECALCULOMVAITEM write FNFE_VALORBASECALCULOMVAITEM;
    const NFE_VALORBASECALCULOMVAITEM_Name = 'NFE_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('NFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSRNFITEM: Double read FNFE_VALORICMSRNFITEM write FNFE_VALORICMSRNFITEM;
    const NFE_VALORICMSRNFITEM_Name = 'NFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('NFE_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASEISENTOICMSITEM: Double read FNFE_VALORBASEISENTOICMSITEM write FNFE_VALORBASEISENTOICMSITEM;
    const NFE_VALORBASEISENTOICMSITEM_Name = 'NFE_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBASEOUTROSITEM', ftBCD, 48, 2)]
    [Dictionary('NFE_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASEOUTROSITEM: Double read FNFE_VALORBASEOUTROSITEM write FNFE_VALORBASEOUTROSITEM;
    const NFE_VALORBASEOUTROSITEM_Name = 'NFE_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORIPIITEM', ftBCD)]
    [Dictionary('NFE_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORIPIITEM: Double read FNFE_VALORIPIITEM write FNFE_VALORIPIITEM;
    const NFE_VALORIPIITEM_Name = 'NFE_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NFE_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORDESPACESSORIAITEM: Double read FNFE_VALORDESPACESSORIAITEM write FNFE_VALORDESPACESSORIAITEM;
    const NFE_VALORDESPACESSORIAITEM_Name = 'NFE_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORFRETENFITEM', ftBCD)]
    [Dictionary('NFE_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORFRETENFITEM: Double read FNFE_VALORFRETENFITEM write FNFE_VALORFRETENFITEM;
    const NFE_VALORFRETENFITEM_Name = 'NFE_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFE_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBCALCULOPISCOFINSITEM: Double read FNFE_VALORBCALCULOPISCOFINSITEM write FNFE_VALORBCALCULOPISCOFINSITEM;
    const NFE_VALORBCALCULOPISCOFINSITEM_Name = 'NFE_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORPISITEM', ftBCD)]
    [Dictionary('NFE_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORPISITEM: Double read FNFE_VALORPISITEM write FNFE_VALORPISITEM;
    const NFE_VALORPISITEM_Name = 'NFE_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCOFINSITEM', ftBCD)]
    [Dictionary('NFE_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCOFINSITEM: Double read FNFE_VALORCOFINSITEM write FNFE_VALORCOFINSITEM;
    const NFE_VALORCOFINSITEM_Name = 'NFE_VALORCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_LivroFiscal_01)

end.
