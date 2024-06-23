unit express.dbo.NFE_TRIBUTACAOPRODUTOS;

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
  [Table('NFE_TributacaoProdutos', '')]
  TDtoNFE_TributacaoProdutos = class
  private
    { Private declarations } 
    FNFE_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_ID: Integer;
    FCMP_ID: Integer;
    FPRO_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FNCM_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FNFE_QTDENTRADA: Double;
    FNFE_VALORITEM: Double;
    FNFE_VALORIPIITEM: Double;
    FNFE_VALORPISITEM: Double;
    FNFE_VALORICMSITEM: Double;
    FNFE_VALORVERBAITEM: Double;
    FNFE_VALORCOFINSITEM: Double;
    FNFE_VALORSEGUROITEM: Double;
    FNFE_VALORSERVICOITEM: Double;
    FNFE_VALORDESCTOITEM: Double;
    FNFE_VALORICMSRNFITEM: Double;
    FNFE_VALORFRETENFITEM: Double;
    FNFE_VALORFRETERPAITEM: Double;
    FNFE_VALORICMSRDUAITEM: Double;
    FNFE_VALORADICIONALITEM: Double;
    FNFE_VALORFRETECTRITEM: Double;
    FNFE_VALORICMSSIMPLESITEM: Double;
    FNFE_VALORBONIFICACAOITEM: Double;
    FNFE_VALORBASEOUTROSITEM: Double;
    FNFE_VALORICMSFRETENFITEM: Double;
    FNFE_VALORICMSFRETECTRITEM: Double;
    FNFE_VALORICMSACESSORIAITEM: Double;
    FNFE_VALORDESPACESSORIAITEM: Double;
    FNFE_VALORSUBSTRIBUTARIAITEM: Double;
    FNFE_VALORBASEISENTOICMSITEM: Double;
    FNFE_VALORBASECALCULOMVAITEM: Double;
    FNFE_VALORBASECALCULOICMSITEM: Double;
    FNFE_VALORCOMPLEMENTONFICMSITEM: Double;
    FNFE_PERCENTUALIPIITEM: Double;
    FNFE_PERCENTUALPISITEM: Double;
    FNFE_PERCENTUALMVAITEM: Double;
    FNFE_PERCENTUALICMSITEM: Double;
    FNFE_PERCENTUALCOFINSITEM: Double;
    FNFE_PERCENTUALVERBAITEM: Double;
    FNFE_PERCENTUALDESCTOITEM: Double;
    FNFE_PERCENTUALICMSRNFITEM: Double;
    FNFE_PERCENTUALSERVICOITEM: Double;
    FNFE_PERCENTUALSEGUROITEM: Double;
    FNFE_PERCENTUALFRETENFITEM: Double;
    FNFE_PERCENTUALICMSRDUAITEM: Double;
    FNFE_PERCENTUALFRETECTRITEM: Double;
    FNFE_PERCENTUALFRETERPAITEM: Double;
    FNFE_PERCENTUALICMSSAIDAITEM: Double;
    FNFE_PERCENTUALREDUCAOBCITEM: Double;
    FNFE_PERCENTUALICMSSIMPLESITEM: Double;
    FNFE_PERCENTUALICMSDESTINOITEM: Double;
    FNFE_PERCENTUALBONIFICACAOITEM: Double;
    FNFE_PERCENTUALICMSFRETENFITEM: Double;
    FNFE_PERCENTUALICMSFRETECTRITEM: Double;
    FNFE_PERCENTUALDESPACESSORIAITEM: Double;
    FNFE_PERCENTUALICMSACESSORIAITEM: Double;
    FNFE_VALORCUSTOCOMPRANFE: Double;
    FNFE_VALORCUSTOLIQUIDONFE: Double;
    FNFE_VALORCUSTOINVENTARIONFE: Double;
    FNFE_VALORCUSTOCOMPRAMEDIO: Double;
    FNFE_VALORCUSTOLIQUIDOMEDIO: Double;
    FNFE_VALORCUSTOINVENTARIOMEDIO: Double;
    FNFE_ULTIMOCUSTOCOMPRA: Double;
    FNFE_ULTIMOCUSTOLIQUIDO: Double;
    FNFE_ULTIMOCUSTOINVENTARIO: Double;
    FNFE_ULTIMOCUSTOCOMPRAMEDIO: Double;
    FNFE_ULTIMOCUSTOLIQUIDOMEDIO: Double;
    FNFE_ULTIMOCUSTOINVENTARIOMEDIO: Double;
    FNFE_PRECOZEROMKP: Double;
    FNFE_PRECOVENDAMKP: Double;
    FNFE_PRECOSUGERIDOMKP: Double;
    FNFE_PERCENTUALLUCROVENDAMKP: Double;
    FNFE_PERCENTUALLUCROSUGERIDOMKP: Double;
    FNFE_PERCENTUALDESPESASLUCROMKP: Double;
    FNFE_PERCENTUALMARKUPLUCRO: Double;
    FNFE_PERCENTUALMARKUPZERO: Double;
    FNFE_PERCENTUALICMSMARKUP: Double;
    FNFE_VALORBCICMSFRETECTRITEM: Double;
    FNFE_PERCBCICMSFRETECTRITEM: Double;
    FNFE_VALORBCALCULOPISCOFINSITEM: Double;
    FCSTPC_CODIGO: String;
    FNFE_TOTALIPIITEM: Double;
    FNFE_TOTALPISITEM: Double;
    FNFE_TOTALICMSITEM: Double;
    FNFE_TOTALVERBAITEM: Double;
    FNFE_TOTALCOFINSITEM: Double;
    FNFE_TOTALSEGUROITEM: Double;
    FNFE_TOTALSERVICOITEM: Double;
    FNFE_TOTALDESCTOITEM: Double;
    FNFE_TOTALICMSRNFITEM: Double;
    FNFE_TOTALFRETENFITEM: Double;
    FNFE_TOTALFRETERPAITEM: Double;
    FNFE_TOTALICMSRDUAITEM: Double;
    FNFE_TOTALADICIONALITEM: Double;
    FNFE_TOTALFRETECTRITEM: Double;
    FNFE_TOTALICMSSIMPLESITEM: Double;
    FNFE_TOTALBONIFICACAOITEM: Double;
    FNFE_TOTALBASEOUTROSITEM: Double;
    FNFE_TOTALICMSFRETENFITEM: Double;
    FNFE_TOTALICMSFRETECTRITEM: Double;
    FNFE_TOTALICMSACESSORIAITEM: Double;
    FNFE_TOTALDESPACESSORIAITEM: Double;
    FNFE_TOTALSUBSTRIBUTARIAITEM: Double;
    FNFE_TOTALBASEISENTOICMSITEM: Double;
    FNFE_TOTALBASECALCULOMVAITEM: Double;
    FNFE_TOTALBASECALCULOICMSITEM: Double;
    FNFE_TOTALCOMPLEMENTONFICMSITEM: Double;
    FNFE_TOTALBCICMSFRETECTRITEM: Double;
    FNFE_TOTALBCALCULOPISCOFINSITEM: Double;
    FNFE_VALORBCICMSFRETENFITEM: Double;
    FNFE_TOTALBCICMSFRETENFITEM: Double;
    FNFE_PERCENTUALDESPESASMKP: Double;
    FTAB_DESCRICAO: String;
    FFIL_TRIBUTACAOENTRADACST: String;
  public 
    { Public declarations } 
     const Table      = 'NFE_TributacaoProdutos';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_01_ID', ftInteger)]
    [Dictionary('NFE_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_01_ID: Integer read FNFE_01_ID write FNFE_01_ID;
    const NFE_01_ID_Name = 'NFE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate])]
    [Column('CMP_ID', ftInteger)]
    [Dictionary('CMP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_ID: Integer read FCMP_ID write FCMP_ID;
    const CMP_ID_Name = 'CMP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

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
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('NFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_QTDENTRADA: Double read FNFE_QTDENTRADA write FNFE_QTDENTRADA;
    const NFE_QTDENTRADA_Name = 'NFE_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORITEM', ftBCD, 16385, 5)]
    [Dictionary('NFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEM: Double read FNFE_VALORITEM write FNFE_VALORITEM;
    const NFE_VALORITEM_Name = 'NFE_VALORITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORIPIITEM', ftBCD, 1, 5)]
    [Dictionary('NFE_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORIPIITEM: Double read FNFE_VALORIPIITEM write FNFE_VALORIPIITEM;
    const NFE_VALORIPIITEM_Name = 'NFE_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORPISITEM', ftBCD)]
    [Dictionary('NFE_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORPISITEM: Double read FNFE_VALORPISITEM write FNFE_VALORPISITEM;
    const NFE_VALORPISITEM_Name = 'NFE_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORICMSITEM', ftBCD, 52, 5)]
    [Dictionary('NFE_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSITEM: Double read FNFE_VALORICMSITEM write FNFE_VALORICMSITEM;
    const NFE_VALORICMSITEM_Name = 'NFE_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORVERBAITEM', ftBCD)]
    [Dictionary('NFE_VALORVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORVERBAITEM: Double read FNFE_VALORVERBAITEM write FNFE_VALORVERBAITEM;
    const NFE_VALORVERBAITEM_Name = 'NFE_VALORVERBAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCOFINSITEM', ftBCD, 2097184, 5)]
    [Dictionary('NFE_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCOFINSITEM: Double read FNFE_VALORCOFINSITEM write FNFE_VALORCOFINSITEM;
    const NFE_VALORCOFINSITEM_Name = 'NFE_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORSEGUROITEM', ftBCD, 5177428, 5)]
    [Dictionary('NFE_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORSEGUROITEM: Double read FNFE_VALORSEGUROITEM write FNFE_VALORSEGUROITEM;
    const NFE_VALORSEGUROITEM_Name = 'NFE_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORSERVICOITEM', ftBCD, 7274610, 5)]
    [Dictionary('NFE_VALORSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORSERVICOITEM: Double read FNFE_VALORSERVICOITEM write FNFE_VALORSERVICOITEM;
    const NFE_VALORSERVICOITEM_Name = 'NFE_VALORSERVICOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORDESCTOITEM', ftBCD, 5374017, 5)]
    [Dictionary('NFE_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORDESCTOITEM: Double read FNFE_VALORDESCTOITEM write FNFE_VALORDESCTOITEM;
    const NFE_VALORDESCTOITEM_Name = 'NFE_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORICMSRNFITEM', ftBCD, 4522067, 5)]
    [Dictionary('NFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSRNFITEM: Double read FNFE_VALORICMSRNFITEM write FNFE_VALORICMSRNFITEM;
    const NFE_VALORICMSRNFITEM_Name = 'NFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORFRETENFITEM', ftBCD, 538970637, 5)]
    [Dictionary('NFE_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORFRETENFITEM: Double read FNFE_VALORFRETENFITEM write FNFE_VALORFRETENFITEM;
    const NFE_VALORFRETENFITEM_Name = 'NFE_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORFRETERPAITEM', ftBCD, 1953391939, 5)]
    [Dictionary('NFE_VALORFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORFRETERPAITEM: Double read FNFE_VALORFRETERPAITEM write FNFE_VALORFRETERPAITEM;
    const NFE_VALORFRETERPAITEM_Name = 'NFE_VALORFRETERPAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORICMSRDUAITEM', ftBCD, 4784197, 5)]
    [Dictionary('NFE_VALORICMSRDUAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSRDUAITEM: Double read FNFE_VALORICMSRDUAITEM write FNFE_VALORICMSRDUAITEM;
    const NFE_VALORICMSRDUAITEM_Name = 'NFE_VALORICMSRDUAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORADICIONALITEM', ftBCD, 4587552, 5)]
    [Dictionary('NFE_VALORADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORADICIONALITEM: Double read FNFE_VALORADICIONALITEM write FNFE_VALORADICIONALITEM;
    const NFE_VALORADICIONALITEM_Name = 'NFE_VALORADICIONALITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORFRETECTRITEM', ftBCD, 2097196, 5)]
    [Dictionary('NFE_VALORFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORFRETECTRITEM: Double read FNFE_VALORFRETECTRITEM write FNFE_VALORFRETECTRITEM;
    const NFE_VALORFRETECTRITEM_Name = 'NFE_VALORFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORICMSSIMPLESITEM', ftBCD, 1818453348, 5)]
    [Dictionary('NFE_VALORICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSSIMPLESITEM: Double read FNFE_VALORICMSSIMPLESITEM write FNFE_VALORICMSSIMPLESITEM;
    const NFE_VALORICMSSIMPLESITEM_Name = 'NFE_VALORICMSSIMPLESITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBONIFICACAOITEM', ftBCD, 221996910, 5)]
    [Dictionary('NFE_VALORBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBONIFICACAOITEM: Double read FNFE_VALORBONIFICACAOITEM write FNFE_VALORBONIFICACAOITEM;
    const NFE_VALORBONIFICACAOITEM_Name = 'NFE_VALORBONIFICACAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBASEOUTROSITEM', ftBCD, 1179206738, 5)]
    [Dictionary('NFE_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASEOUTROSITEM: Double read FNFE_VALORBASEOUTROSITEM write FNFE_VALORBASEOUTROSITEM;
    const NFE_VALORBASEOUTROSITEM_Name = 'NFE_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORICMSFRETENFITEM', ftBCD, 538970637, 5)]
    [Dictionary('NFE_VALORICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSFRETENFITEM: Double read FNFE_VALORICMSFRETENFITEM write FNFE_VALORICMSFRETENFITEM;
    const NFE_VALORICMSFRETENFITEM_Name = 'NFE_VALORICMSFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORICMSFRETECTRITEM', ftBCD, 1936617321, 5)]
    [Dictionary('NFE_VALORICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSFRETECTRITEM: Double read FNFE_VALORICMSFRETECTRITEM write FNFE_VALORICMSFRETECTRITEM;
    const NFE_VALORICMSFRETECTRITEM_Name = 'NFE_VALORICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORICMSACESSORIAITEM', ftBCD, 1818439271, 5)]
    [Dictionary('NFE_VALORICMSACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSACESSORIAITEM: Double read FNFE_VALORICMSACESSORIAITEM write FNFE_VALORICMSACESSORIAITEM;
    const NFE_VALORICMSACESSORIAITEM_Name = 'NFE_VALORICMSACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORDESPACESSORIAITEM', ftBCD, 5111903, 5)]
    [Dictionary('NFE_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORDESPACESSORIAITEM: Double read FNFE_VALORDESPACESSORIAITEM write FNFE_VALORDESPACESSORIAITEM;
    const NFE_VALORDESPACESSORIAITEM_Name = 'NFE_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORSUBSTRIBUTARIAITEM', ftBCD, 53, 5)]
    [Dictionary('NFE_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORSUBSTRIBUTARIAITEM: Double read FNFE_VALORSUBSTRIBUTARIAITEM write FNFE_VALORSUBSTRIBUTARIAITEM;
    const NFE_VALORSUBSTRIBUTARIAITEM_Name = 'NFE_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBASEISENTOICMSITEM', ftBCD, 30, 5)]
    [Dictionary('NFE_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASEISENTOICMSITEM: Double read FNFE_VALORBASEISENTOICMSITEM write FNFE_VALORBASEISENTOICMSITEM;
    const NFE_VALORBASEISENTOICMSITEM_Name = 'NFE_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('NFE_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASECALCULOMVAITEM: Double read FNFE_VALORBASECALCULOMVAITEM write FNFE_VALORBASECALCULOMVAITEM;
    const NFE_VALORBASECALCULOMVAITEM_Name = 'NFE_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('NFE_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBASECALCULOICMSITEM: Double read FNFE_VALORBASECALCULOICMSITEM write FNFE_VALORBASECALCULOICMSITEM;
    const NFE_VALORBASECALCULOICMSITEM_Name = 'NFE_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCOMPLEMENTONFICMSITEM', ftBCD, 16387, 5)]
    [Dictionary('NFE_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCOMPLEMENTONFICMSITEM: Double read FNFE_VALORCOMPLEMENTONFICMSITEM write FNFE_VALORCOMPLEMENTONFICMSITEM;
    const NFE_VALORCOMPLEMENTONFICMSITEM_Name = 'NFE_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALIPIITEM: Double read FNFE_PERCENTUALIPIITEM write FNFE_PERCENTUALIPIITEM;
    const NFE_PERCENTUALIPIITEM_Name = 'NFE_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALPISITEM: Double read FNFE_PERCENTUALPISITEM write FNFE_PERCENTUALPISITEM;
    const NFE_PERCENTUALPISITEM_Name = 'NFE_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALMVAITEM: Double read FNFE_PERCENTUALMVAITEM write FNFE_PERCENTUALMVAITEM;
    const NFE_PERCENTUALMVAITEM_Name = 'NFE_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSITEM: Double read FNFE_PERCENTUALICMSITEM write FNFE_PERCENTUALICMSITEM;
    const NFE_PERCENTUALICMSITEM_Name = 'NFE_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALCOFINSITEM: Double read FNFE_PERCENTUALCOFINSITEM write FNFE_PERCENTUALCOFINSITEM;
    const NFE_PERCENTUALCOFINSITEM_Name = 'NFE_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALVERBAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALVERBAITEM: Double read FNFE_PERCENTUALVERBAITEM write FNFE_PERCENTUALVERBAITEM;
    const NFE_PERCENTUALVERBAITEM_Name = 'NFE_PERCENTUALVERBAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALDESCTOITEM: Double read FNFE_PERCENTUALDESCTOITEM write FNFE_PERCENTUALDESCTOITEM;
    const NFE_PERCENTUALDESCTOITEM_Name = 'NFE_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSRNFITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSRNFITEM: Double read FNFE_PERCENTUALICMSRNFITEM write FNFE_PERCENTUALICMSRNFITEM;
    const NFE_PERCENTUALICMSRNFITEM_Name = 'NFE_PERCENTUALICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALSERVICOITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALSERVICOITEM: Double read FNFE_PERCENTUALSERVICOITEM write FNFE_PERCENTUALSERVICOITEM;
    const NFE_PERCENTUALSERVICOITEM_Name = 'NFE_PERCENTUALSERVICOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALSEGUROITEM: Double read FNFE_PERCENTUALSEGUROITEM write FNFE_PERCENTUALSEGUROITEM;
    const NFE_PERCENTUALSEGUROITEM_Name = 'NFE_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALFRETENFITEM: Double read FNFE_PERCENTUALFRETENFITEM write FNFE_PERCENTUALFRETENFITEM;
    const NFE_PERCENTUALFRETENFITEM_Name = 'NFE_PERCENTUALFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSRDUAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSRDUAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSRDUAITEM: Double read FNFE_PERCENTUALICMSRDUAITEM write FNFE_PERCENTUALICMSRDUAITEM;
    const NFE_PERCENTUALICMSRDUAITEM_Name = 'NFE_PERCENTUALICMSRDUAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALFRETECTRITEM: Double read FNFE_PERCENTUALFRETECTRITEM write FNFE_PERCENTUALFRETECTRITEM;
    const NFE_PERCENTUALFRETECTRITEM_Name = 'NFE_PERCENTUALFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALFRETERPAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALFRETERPAITEM: Double read FNFE_PERCENTUALFRETERPAITEM write FNFE_PERCENTUALFRETERPAITEM;
    const NFE_PERCENTUALFRETERPAITEM_Name = 'NFE_PERCENTUALFRETERPAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSSAIDAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSSAIDAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSSAIDAITEM: Double read FNFE_PERCENTUALICMSSAIDAITEM write FNFE_PERCENTUALICMSSAIDAITEM;
    const NFE_PERCENTUALICMSSAIDAITEM_Name = 'NFE_PERCENTUALICMSSAIDAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALREDUCAOBCITEM: Double read FNFE_PERCENTUALREDUCAOBCITEM write FNFE_PERCENTUALREDUCAOBCITEM;
    const NFE_PERCENTUALREDUCAOBCITEM_Name = 'NFE_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSSIMPLESITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSSIMPLESITEM: Double read FNFE_PERCENTUALICMSSIMPLESITEM write FNFE_PERCENTUALICMSSIMPLESITEM;
    const NFE_PERCENTUALICMSSIMPLESITEM_Name = 'NFE_PERCENTUALICMSSIMPLESITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSDESTINOITEM: Double read FNFE_PERCENTUALICMSDESTINOITEM write FNFE_PERCENTUALICMSDESTINOITEM;
    const NFE_PERCENTUALICMSDESTINOITEM_Name = 'NFE_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALBONIFICACAOITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALBONIFICACAOITEM: Double read FNFE_PERCENTUALBONIFICACAOITEM write FNFE_PERCENTUALBONIFICACAOITEM;
    const NFE_PERCENTUALBONIFICACAOITEM_Name = 'NFE_PERCENTUALBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSFRETENFITEM: Double read FNFE_PERCENTUALICMSFRETENFITEM write FNFE_PERCENTUALICMSFRETENFITEM;
    const NFE_PERCENTUALICMSFRETENFITEM_Name = 'NFE_PERCENTUALICMSFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALICMSFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSFRETECTRITEM: Double read FNFE_PERCENTUALICMSFRETECTRITEM write FNFE_PERCENTUALICMSFRETECTRITEM;
    const NFE_PERCENTUALICMSFRETECTRITEM_Name = 'NFE_PERCENTUALICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALDESPACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALDESPACESSORIAITEM: Double read FNFE_PERCENTUALDESPACESSORIAITEM write FNFE_PERCENTUALDESPACESSORIAITEM;
    const NFE_PERCENTUALDESPACESSORIAITEM_Name = 'NFE_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSACESSORIAITEM: Double read FNFE_PERCENTUALICMSACESSORIAITEM write FNFE_PERCENTUALICMSACESSORIAITEM;
    const NFE_PERCENTUALICMSACESSORIAITEM_Name = 'NFE_PERCENTUALICMSACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOCOMPRANFE', ftBCD, 5636178, 5)]
    [Dictionary('NFE_VALORCUSTOCOMPRANFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOCOMPRANFE: Double read FNFE_VALORCUSTOCOMPRANFE write FNFE_VALORCUSTOCOMPRANFE;
    const NFE_VALORCUSTOCOMPRANFE_Name = 'NFE_VALORCUSTOCOMPRANFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOLIQUIDONFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOLIQUIDONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOLIQUIDONFE: Double read FNFE_VALORCUSTOLIQUIDONFE write FNFE_VALORCUSTOLIQUIDONFE;
    const NFE_VALORCUSTOLIQUIDONFE_Name = 'NFE_VALORCUSTOLIQUIDONFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOINVENTARIONFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOINVENTARIONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOINVENTARIONFE: Double read FNFE_VALORCUSTOINVENTARIONFE write FNFE_VALORCUSTOINVENTARIONFE;
    const NFE_VALORCUSTOINVENTARIONFE_Name = 'NFE_VALORCUSTOINVENTARIONFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOCOMPRAMEDIO', ftBCD, 16387, 5)]
    [Dictionary('NFE_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOCOMPRAMEDIO: Double read FNFE_VALORCUSTOCOMPRAMEDIO write FNFE_VALORCUSTOCOMPRAMEDIO;
    const NFE_VALORCUSTOCOMPRAMEDIO_Name = 'NFE_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOLIQUIDOMEDIO', ftBCD, 16387, 5)]
    [Dictionary('NFE_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOLIQUIDOMEDIO: Double read FNFE_VALORCUSTOLIQUIDOMEDIO write FNFE_VALORCUSTOLIQUIDOMEDIO;
    const NFE_VALORCUSTOLIQUIDOMEDIO_Name = 'NFE_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOINVENTARIOMEDIO', ftBCD, 300, 5)]
    [Dictionary('NFE_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOINVENTARIOMEDIO: Double read FNFE_VALORCUSTOINVENTARIOMEDIO write FNFE_VALORCUSTOINVENTARIOMEDIO;
    const NFE_VALORCUSTOINVENTARIOMEDIO_Name = 'NFE_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOCOMPRA', ftBCD, 16387, 5)]
    [Dictionary('NFE_ULTIMOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_ULTIMOCUSTOCOMPRA: Double read FNFE_ULTIMOCUSTOCOMPRA write FNFE_ULTIMOCUSTOCOMPRA;
    const NFE_ULTIMOCUSTOCOMPRA_Name = 'NFE_ULTIMOCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOLIQUIDO', ftBCD)]
    [Dictionary('NFE_ULTIMOCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_ULTIMOCUSTOLIQUIDO: Double read FNFE_ULTIMOCUSTOLIQUIDO write FNFE_ULTIMOCUSTOLIQUIDO;
    const NFE_ULTIMOCUSTOLIQUIDO_Name = 'NFE_ULTIMOCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOINVENTARIO', ftBCD)]
    [Dictionary('NFE_ULTIMOCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_ULTIMOCUSTOINVENTARIO: Double read FNFE_ULTIMOCUSTOINVENTARIO write FNFE_ULTIMOCUSTOINVENTARIO;
    const NFE_ULTIMOCUSTOINVENTARIO_Name = 'NFE_ULTIMOCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOCOMPRAMEDIO', ftBCD)]
    [Dictionary('NFE_ULTIMOCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_ULTIMOCUSTOCOMPRAMEDIO: Double read FNFE_ULTIMOCUSTOCOMPRAMEDIO write FNFE_ULTIMOCUSTOCOMPRAMEDIO;
    const NFE_ULTIMOCUSTOCOMPRAMEDIO_Name = 'NFE_ULTIMOCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOLIQUIDOMEDIO', ftBCD)]
    [Dictionary('NFE_ULTIMOCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_ULTIMOCUSTOLIQUIDOMEDIO: Double read FNFE_ULTIMOCUSTOLIQUIDOMEDIO write FNFE_ULTIMOCUSTOLIQUIDOMEDIO;
    const NFE_ULTIMOCUSTOLIQUIDOMEDIO_Name = 'NFE_ULTIMOCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOINVENTARIOMEDIO', ftBCD)]
    [Dictionary('NFE_ULTIMOCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_ULTIMOCUSTOINVENTARIOMEDIO: Double read FNFE_ULTIMOCUSTOINVENTARIOMEDIO write FNFE_ULTIMOCUSTOINVENTARIOMEDIO;
    const NFE_ULTIMOCUSTOINVENTARIOMEDIO_Name = 'NFE_ULTIMOCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFE_PRECOZEROMKP', ftBCD)]
    [Dictionary('NFE_PRECOZEROMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PRECOZEROMKP: Double read FNFE_PRECOZEROMKP write FNFE_PRECOZEROMKP;
    const NFE_PRECOZEROMKP_Name = 'NFE_PRECOZEROMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PRECOVENDAMKP', ftBCD, 1952867660, 5)]
    [Dictionary('NFE_PRECOVENDAMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PRECOVENDAMKP: Double read FNFE_PRECOVENDAMKP write FNFE_PRECOVENDAMKP;
    const NFE_PRECOVENDAMKP_Name = 'NFE_PRECOVENDAMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PRECOSUGERIDOMKP', ftBCD, 1195983951, 5)]
    [Dictionary('NFE_PRECOSUGERIDOMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PRECOSUGERIDOMKP: Double read FNFE_PRECOSUGERIDOMKP write FNFE_PRECOSUGERIDOMKP;
    const NFE_PRECOSUGERIDOMKP_Name = 'NFE_PRECOSUGERIDOMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALLUCROVENDAMKP', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALLUCROVENDAMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALLUCROVENDAMKP: Double read FNFE_PERCENTUALLUCROVENDAMKP write FNFE_PERCENTUALLUCROVENDAMKP;
    const NFE_PERCENTUALLUCROVENDAMKP_Name = 'NFE_PERCENTUALLUCROVENDAMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALLUCROSUGERIDOMKP', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALLUCROSUGERIDOMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALLUCROSUGERIDOMKP: Double read FNFE_PERCENTUALLUCROSUGERIDOMKP write FNFE_PERCENTUALLUCROSUGERIDOMKP;
    const NFE_PERCENTUALLUCROSUGERIDOMKP_Name = 'NFE_PERCENTUALLUCROSUGERIDOMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALDESPESASLUCROMKP', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALDESPESASLUCROMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALDESPESASLUCROMKP: Double read FNFE_PERCENTUALDESPESASLUCROMKP write FNFE_PERCENTUALDESPESASLUCROMKP;
    const NFE_PERCENTUALDESPESASLUCROMKP_Name = 'NFE_PERCENTUALDESPESASLUCROMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALMARKUPLUCRO', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALMARKUPLUCRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALMARKUPLUCRO: Double read FNFE_PERCENTUALMARKUPLUCRO write FNFE_PERCENTUALMARKUPLUCRO;
    const NFE_PERCENTUALMARKUPLUCRO_Name = 'NFE_PERCENTUALMARKUPLUCRO';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALMARKUPZERO', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALMARKUPZERO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALMARKUPZERO: Double read FNFE_PERCENTUALMARKUPZERO write FNFE_PERCENTUALMARKUPZERO;
    const NFE_PERCENTUALMARKUPZERO_Name = 'NFE_PERCENTUALMARKUPZERO';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSMARKUP', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALICMSMARKUP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSMARKUP: Double read FNFE_PERCENTUALICMSMARKUP write FNFE_PERCENTUALICMSMARKUP;
    const NFE_PERCENTUALICMSMARKUP_Name = 'NFE_PERCENTUALICMSMARKUP';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBCICMSFRETECTRITEM', ftBCD, 1869770784, 5)]
    [Dictionary('NFE_VALORBCICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBCICMSFRETECTRITEM: Double read FNFE_VALORBCICMSFRETECTRITEM write FNFE_VALORBCICMSFRETECTRITEM;
    const NFE_VALORBCICMSFRETECTRITEM_Name = 'NFE_VALORBCICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCBCICMSFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCBCICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCBCICMSFRETECTRITEM: Double read FNFE_PERCBCICMSFRETECTRITEM write FNFE_PERCBCICMSFRETECTRITEM;
    const NFE_PERCBCICMSFRETECTRITEM_Name = 'NFE_PERCBCICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBCALCULOPISCOFINSITEM', ftBCD, 4522064, 5)]
    [Dictionary('NFE_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBCALCULOPISCOFINSITEM: Double read FNFE_VALORBCALCULOPISCOFINSITEM write FNFE_VALORBCALCULOPISCOFINSITEM;
    const NFE_VALORBCALCULOPISCOFINSITEM_Name = 'NFE_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALIPIITEM', ftBCD, 4456531, 2)]
    [Dictionary('NFE_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALIPIITEM: Double read FNFE_TOTALIPIITEM write FNFE_TOTALIPIITEM;
    const NFE_TOTALIPIITEM_Name = 'NFE_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALPISITEM', ftBCD, 1380275039, 2)]
    [Dictionary('NFE_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALPISITEM: Double read FNFE_TOTALPISITEM write FNFE_TOTALPISITEM;
    const NFE_TOTALPISITEM_Name = 'NFE_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSITEM', ftBCD, 659507017, 2)]
    [Dictionary('NFE_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSITEM: Double read FNFE_TOTALICMSITEM write FNFE_TOTALICMSITEM;
    const NFE_TOTALICMSITEM_Name = 'NFE_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALVERBAITEM', ftBCD, 7077999, 2)]
    [Dictionary('NFE_TOTALVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALVERBAITEM: Double read FNFE_TOTALVERBAITEM write FNFE_TOTALVERBAITEM;
    const NFE_TOTALVERBAITEM_Name = 'NFE_TOTALVERBAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALCOFINSITEM', ftBCD, 1952531540, 2)]
    [Dictionary('NFE_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALCOFINSITEM: Double read FNFE_TOTALCOFINSITEM write FNFE_TOTALCOFINSITEM;
    const NFE_TOTALCOFINSITEM_Name = 'NFE_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALSEGUROITEM', ftBCD, 1529377646, 2)]
    [Dictionary('NFE_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALSEGUROITEM: Double read FNFE_TOTALSEGUROITEM write FNFE_TOTALSEGUROITEM;
    const NFE_TOTALSEGUROITEM_Name = 'NFE_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALSERVICOITEM', ftBCD, 544040295, 2)]
    [Dictionary('NFE_TOTALSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALSERVICOITEM: Double read FNFE_TOTALSERVICOITEM write FNFE_TOTALSERVICOITEM;
    const NFE_TOTALSERVICOITEM_Name = 'NFE_TOTALSERVICOITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALDESCTOITEM', ftBCD, 2097273, 2)]
    [Dictionary('NFE_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALDESCTOITEM: Double read FNFE_TOTALDESCTOITEM write FNFE_TOTALDESCTOITEM;
    const NFE_TOTALDESCTOITEM_Name = 'NFE_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSRNFITEM', ftBCD, 1397311055, 2)]
    [Dictionary('NFE_TOTALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSRNFITEM: Double read FNFE_TOTALICMSRNFITEM write FNFE_TOTALICMSRNFITEM;
    const NFE_TOTALICMSRNFITEM_Name = 'NFE_TOTALICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALFRETENFITEM', ftBCD, 218762555, 2)]
    [Dictionary('NFE_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETENFITEM: Double read FNFE_TOTALFRETENFITEM write FNFE_TOTALFRETENFITEM;
    const NFE_TOTALFRETENFITEM_Name = 'NFE_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALFRETERPAITEM', ftBCD, 1952672068, 2)]
    [Dictionary('NFE_TOTALFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETERPAITEM: Double read FNFE_TOTALFRETERPAITEM write FNFE_TOTALFRETERPAITEM;
    const NFE_TOTALFRETERPAITEM_Name = 'NFE_TOTALFRETERPAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSRDUAITEM', ftBCD)]
    [Dictionary('NFE_TOTALICMSRDUAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSRDUAITEM: Double read FNFE_TOTALICMSRDUAITEM write FNFE_TOTALICMSRDUAITEM;
    const NFE_TOTALICMSRDUAITEM_Name = 'NFE_TOTALICMSRDUAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALADICIONALITEM', ftBCD)]
    [Dictionary('NFE_TOTALADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALADICIONALITEM: Double read FNFE_TOTALADICIONALITEM write FNFE_TOTALADICIONALITEM;
    const NFE_TOTALADICIONALITEM_Name = 'NFE_TOTALADICIONALITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALFRETECTRITEM', ftBCD, 537529693, 2)]
    [Dictionary('NFE_TOTALFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETECTRITEM: Double read FNFE_TOTALFRETECTRITEM write FNFE_TOTALFRETECTRITEM;
    const NFE_TOTALFRETECTRITEM_Name = 'NFE_TOTALFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSSIMPLESITEM', ftBCD, 1162039111, 2)]
    [Dictionary('NFE_TOTALICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSSIMPLESITEM: Double read FNFE_TOTALICMSSIMPLESITEM write FNFE_TOTALICMSSIMPLESITEM;
    const NFE_TOTALICMSSIMPLESITEM_Name = 'NFE_TOTALICMSSIMPLESITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBONIFICACAOITEM', ftBCD, 1699555104, 2)]
    [Dictionary('NFE_TOTALBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBONIFICACAOITEM: Double read FNFE_TOTALBONIFICACAOITEM write FNFE_TOTALBONIFICACAOITEM;
    const NFE_TOTALBONIFICACAOITEM_Name = 'NFE_TOTALBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASEOUTROSITEM', ftBCD, 1936020059, 2)]
    [Dictionary('NFE_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASEOUTROSITEM: Double read FNFE_TOTALBASEOUTROSITEM write FNFE_TOTALBASEOUTROSITEM;
    const NFE_TOTALBASEOUTROSITEM_Name = 'NFE_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSFRETENFITEM', ftBCD, 1702129225, 2)]
    [Dictionary('NFE_TOTALICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSFRETENFITEM: Double read FNFE_TOTALICMSFRETENFITEM write FNFE_TOTALICMSFRETENFITEM;
    const NFE_TOTALICMSFRETENFITEM_Name = 'NFE_TOTALICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSFRETECTRITEM', ftBCD, 1142962771, 2)]
    [Dictionary('NFE_TOTALICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSFRETECTRITEM: Double read FNFE_TOTALICMSFRETECTRITEM write FNFE_TOTALICMSFRETECTRITEM;
    const NFE_TOTALICMSFRETECTRITEM_Name = 'NFE_TOTALICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALICMSACESSORIAITEM', ftBCD, 1599096398, 2)]
    [Dictionary('NFE_TOTALICMSACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSACESSORIAITEM: Double read FNFE_TOTALICMSACESSORIAITEM write FNFE_TOTALICMSACESSORIAITEM;
    const NFE_TOTALICMSACESSORIAITEM_Name = 'NFE_TOTALICMSACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALDESPACESSORIAITEM', ftBCD, 1415532614, 2)]
    [Dictionary('NFE_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALDESPACESSORIAITEM: Double read FNFE_TOTALDESPACESSORIAITEM write FNFE_TOTALDESPACESSORIAITEM;
    const NFE_TOTALDESPACESSORIAITEM_Name = 'NFE_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALSUBSTRIBUTARIAITEM', ftBCD, 539780974, 2)]
    [Dictionary('NFE_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALSUBSTRIBUTARIAITEM: Double read FNFE_TOTALSUBSTRIBUTARIAITEM write FNFE_TOTALSUBSTRIBUTARIAITEM;
    const NFE_TOTALSUBSTRIBUTARIAITEM_Name = 'NFE_TOTALSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASEISENTOICMSITEM', ftBCD, 1981834596, 2)]
    [Dictionary('NFE_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASEISENTOICMSITEM: Double read FNFE_TOTALBASEISENTOICMSITEM write FNFE_TOTALBASEISENTOICMSITEM;
    const NFE_TOTALBASEISENTOICMSITEM_Name = 'NFE_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASECALCULOMVAITEM', ftBCD, 1146045279, 2)]
    [Dictionary('NFE_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASECALCULOMVAITEM: Double read FNFE_TOTALBASECALCULOMVAITEM write FNFE_TOTALBASECALCULOMVAITEM;
    const NFE_TOTALBASECALCULOMVAITEM_Name = 'NFE_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBASECALCULOICMSITEM', ftBCD, 656419879, 2)]
    [Dictionary('NFE_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBASECALCULOICMSITEM: Double read FNFE_TOTALBASECALCULOICMSITEM write FNFE_TOTALBASECALCULOICMSITEM;
    const NFE_TOTALBASECALCULOICMSITEM_Name = 'NFE_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALCOMPLEMENTONFICMSITEM', ftBCD, 6881394, 2)]
    [Dictionary('NFE_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALCOMPLEMENTONFICMSITEM: Double read FNFE_TOTALCOMPLEMENTONFICMSITEM write FNFE_TOTALCOMPLEMENTONFICMSITEM;
    const NFE_TOTALCOMPLEMENTONFICMSITEM_Name = 'NFE_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBCICMSFRETECTRITEM', ftBCD, 1411398223, 2)]
    [Dictionary('NFE_TOTALBCICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCICMSFRETECTRITEM: Double read FNFE_TOTALBCICMSFRETECTRITEM write FNFE_TOTALBCICMSFRETECTRITEM;
    const NFE_TOTALBCICMSFRETECTRITEM_Name = 'NFE_TOTALBCICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBCALCULOPISCOFINSITEM', ftBCD, 1145132617, 2)]
    [Dictionary('NFE_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCALCULOPISCOFINSITEM: Double read FNFE_TOTALBCALCULOPISCOFINSITEM write FNFE_TOTALBCALCULOPISCOFINSITEM;
    const NFE_TOTALBCALCULOPISCOFINSITEM_Name = 'NFE_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBCICMSFRETENFITEM', ftBCD, 1835362145, 5)]
    [Dictionary('NFE_VALORBCICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBCICMSFRETENFITEM: Double read FNFE_VALORBCICMSFRETENFITEM write FNFE_VALORBCICMSFRETENFITEM;
    const NFE_VALORBCICMSFRETENFITEM_Name = 'NFE_VALORBCICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALBCICMSFRETENFITEM', ftBCD, 5177428, 2)]
    [Dictionary('NFE_TOTALBCICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCICMSFRETENFITEM: Double read FNFE_TOTALBCICMSFRETENFITEM write FNFE_TOTALBCICMSFRETENFITEM;
    const NFE_TOTALBCICMSFRETENFITEM_Name = 'NFE_TOTALBCICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALDESPESASMKP', ftBCD, 1769238085, 4)]
    [Dictionary('NFE_PERCENTUALDESPESASMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALDESPESASMKP: Double read FNFE_PERCENTUALDESPESASMKP write FNFE_PERCENTUALDESPESASMKP;
    const NFE_PERCENTUALDESPESASMKP_Name = 'NFE_PERCENTUALDESPESASMKP';

    [Restrictions([NoValidate])]
    [Column('TAB_DESCRICAO', ftString, 70)]
    [Dictionary('TAB_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TAB_DESCRICAO: String read FTAB_DESCRICAO write FTAB_DESCRICAO;
    const TAB_DESCRICAO_Name = 'TAB_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FIL_TRIBUTACAOENTRADACST', ftString, 1)]
    [Dictionary('FIL_TRIBUTACAOENTRADACST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FIL_TRIBUTACAOENTRADACST: String read FFIL_TRIBUTACAOENTRADACST write FFIL_TRIBUTACAOENTRADACST;
    const FIL_TRIBUTACAOENTRADACST_Name = 'FIL_TRIBUTACAOENTRADACST';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_TributacaoProdutos)

end.
