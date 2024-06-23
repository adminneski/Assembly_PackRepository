unit express.dbo.NFP_LIVROFISCAL_01;

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
  [Table('NFP_LivroFiscal_01', '')]
  TDtoNFP_LivroFiscal_01 = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFP_DATALANCAMENTO: TDateTime;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FNFP_VALORITEMBRUTO: Double;
    FNFP_VALORITEM: Double;
    FNFP_VALORBASECALCULOICMSITEM: Double;
    FNFP_VALORICMSITEM: Double;
    FNFP_PERCENTUALICMSITEM: Double;
    FNFP_VALORBASECALCULOMVAITEM: Integer;
    FNFP_VALORICMSRITEM: Integer;
    FNFP_VALORBASEISENTOICMSITEM: Double;
    FNFP_VALORBASEOUTROSITEM: Double;
    FNFP_VALORIPIITEM: Double;
    FNFP_VALORDESPACESSORIAITEM: Double;
    FNFP_VALORFRETENFITEM: Double;
    FNFP_VALORBCALCULOPISCOFINSITEM: Double;
    FNFP_VALORPISITEM: Double;
    FNFP_VALORCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'NFP_LivroFiscal_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATALANCAMENTO: TDateTime read FNFP_DATALANCAMENTO write FNFP_DATALANCAMENTO;
    const NFP_DATALANCAMENTO_Name = 'NFP_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORITEMBRUTO', ftBCD)]
    [Dictionary('NFP_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORITEMBRUTO: Double read FNFP_VALORITEMBRUTO write FNFP_VALORITEMBRUTO;
    const NFP_VALORITEMBRUTO_Name = 'NFP_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORITEM', ftBCD)]
    [Dictionary('NFP_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORITEM: Double read FNFP_VALORITEM write FNFP_VALORITEM;
    const NFP_VALORITEM_Name = 'NFP_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('NFP_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASECALCULOICMSITEM: Double read FNFP_VALORBASECALCULOICMSITEM write FNFP_VALORBASECALCULOICMSITEM;
    const NFP_VALORBASECALCULOICMSITEM_Name = 'NFP_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORICMSITEM', ftBCD)]
    [Dictionary('NFP_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORICMSITEM: Double read FNFP_VALORICMSITEM write FNFP_VALORICMSITEM;
    const NFP_VALORICMSITEM_Name = 'NFP_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSITEM: Double read FNFP_PERCENTUALICMSITEM write FNFP_PERCENTUALICMSITEM;
    const NFP_PERCENTUALICMSITEM_Name = 'NFP_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORBASECALCULOMVAITEM', ftInteger)]
    [Dictionary('NFP_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_VALORBASECALCULOMVAITEM: Integer read FNFP_VALORBASECALCULOMVAITEM write FNFP_VALORBASECALCULOMVAITEM;
    const NFP_VALORBASECALCULOMVAITEM_Name = 'NFP_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORICMSRITEM', ftInteger)]
    [Dictionary('NFP_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_VALORICMSRITEM: Integer read FNFP_VALORICMSRITEM write FNFP_VALORICMSRITEM;
    const NFP_VALORICMSRITEM_Name = 'NFP_VALORICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('NFP_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASEISENTOICMSITEM: Double read FNFP_VALORBASEISENTOICMSITEM write FNFP_VALORBASEISENTOICMSITEM;
    const NFP_VALORBASEISENTOICMSITEM_Name = 'NFP_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('NFP_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASEOUTROSITEM: Double read FNFP_VALORBASEOUTROSITEM write FNFP_VALORBASEOUTROSITEM;
    const NFP_VALORBASEOUTROSITEM_Name = 'NFP_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORIPIITEM', ftBCD)]
    [Dictionary('NFP_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORIPIITEM: Double read FNFP_VALORIPIITEM write FNFP_VALORIPIITEM;
    const NFP_VALORIPIITEM_Name = 'NFP_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NFP_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORDESPACESSORIAITEM: Double read FNFP_VALORDESPACESSORIAITEM write FNFP_VALORDESPACESSORIAITEM;
    const NFP_VALORDESPACESSORIAITEM_Name = 'NFP_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORFRETENFITEM', ftBCD)]
    [Dictionary('NFP_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORFRETENFITEM: Double read FNFP_VALORFRETENFITEM write FNFP_VALORFRETENFITEM;
    const NFP_VALORFRETENFITEM_Name = 'NFP_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFP_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBCALCULOPISCOFINSITEM: Double read FNFP_VALORBCALCULOPISCOFINSITEM write FNFP_VALORBCALCULOPISCOFINSITEM;
    const NFP_VALORBCALCULOPISCOFINSITEM_Name = 'NFP_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORPISITEM', ftBCD)]
    [Dictionary('NFP_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORPISITEM: Double read FNFP_VALORPISITEM write FNFP_VALORPISITEM;
    const NFP_VALORPISITEM_Name = 'NFP_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCOFINSITEM', ftBCD)]
    [Dictionary('NFP_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCOFINSITEM: Double read FNFP_VALORCOFINSITEM write FNFP_VALORCOFINSITEM;
    const NFP_VALORCOFINSITEM_Name = 'NFP_VALORCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_LivroFiscal_01)

end.
