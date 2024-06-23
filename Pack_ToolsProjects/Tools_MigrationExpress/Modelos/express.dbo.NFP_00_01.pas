unit express.dbo.NFP_00_01;

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
  [Table('NFP_00_01', '')]
  [PrimaryKey('NFP_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFP_01_ID')]
  TDtoNFP_00_01 = class
  private
    { Private declarations } 
    FNFP_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFP_ID: Integer;
    FCST_CODIGO: String;
    FPRO_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FNFP_QTDENTRADA: Double;
    FNFP_VALORITEM: Double;
    FNFP_VALORIPIITEM: Double;
    FNFP_VALORICMSITEM: Double;
    FNFP_VALORVERBAITEM: Double;
    FNFP_VALORDESCTOITEM: Double;
    FNFP_VALORSEGUROITEM: Double;
    FNFP_VALORSERVICOITEM: Double;
    FNFP_VALORFRETENFITEM: Double;
    FNFP_VALORFRETECTRITEM: Double;
    FNFP_VALORFRETERPAITEM: Double;
    FNFP_VALORADICIONALITEM: Double;
    FNFP_VALORICMSFRETENFITEM: Double;
    FNFP_VALORBASEOUTROSITEM: Double;
    FNFP_VALORBONIFICACAOITEM: Double;
    FNFP_VALORICMSFRETECTRITEM: Double;
    FNFP_VALORDESPACESSORIAITEM: Double;
    FNFP_VALORBASEISENTOICMSITEM: Double;
    FNFP_VALORBASECALCULOICMSITEM: Double;
    FNFP_VALORCOMPLEMENTONFICMSITEM: Double;
    FNFP_PERCENTUALIPIITEM: Double;
    FNFP_PERCENTUALICMSITEM: Double;
    FNFP_PERCENTUALVERBAITEM: Double;
    FNFP_PERCENTUALDESCTOITEM: Double;
    FNFP_PERCENTUALSEGUROITEM: Double;
    FNFP_PERCENTUALSERVICOITEM: Double;
    FNFP_PERCENTUALFRETENFITEM: Double;
    FNFP_PERCENTUALFRETERPAITEM: Double;
    FNFP_PERCENTUALFRETECTRITEM: Double;
    FNFP_PERCENTUALREDUCAOBCITEM: Double;
    FNFP_PERCENTUALICMSSIMPLESITEM: Double;
    FNFP_PERCENTUALICMSFRETENFITEM: Double;
    FNFP_PERCENTUALBONIFICACAOITEM: Double;
    FNFP_PERCENTUALICMSDESTINOITEM: Double;
    FNFP_PERCENTUALICMSFRETECTRITEM: Double;
    FNFP_PERCENTUALDESPACESSORIAITEM: Double;
    FNFP_VALORICMSSIMPLESITEM: Double;
    FNFP_VALORCUSTOCOMPRANFE: Double;
    FNFP_VALORCUSTOLIQUIDONFE: Double;
    FNFP_VALORCUSTOINVENTARIONFE: Double;
    FNFP_VALORCUSTOCOMPRAMEDIO: Double;
    FNFP_VALORCUSTOLIQUIDOMEDIO: Double;
    FNFP_VALORCUSTOINVENTARIOMEDIO: Double;
    FNFP_ULTIMOCUSTOCOMPRA: Double;
    FNFP_ULTIMOCUSTOLIQUIDO: Double;
    FNFP_ULTIMOCUSTOINVENTARIO: Double;
    FNFP_DATAALTERACAO: TDateTime;
    FNFP_ULTIMOCUSTOCOMPRAMEDIO: Double;
    FNFP_ULTIMOCUSTOLIQUIDOMEDIO: Double;
    FNFP_ULTIMOCUSTOINVENTARIOMEDIO: Double;
    FNFP_PERCENTUALCOFINSITEM: Double;
    FNFP_PERCENTUALPISITEM: Double;
    FNFP_VALORCOFINSITEM: Double;
    FNFP_VALORPISITEM: Double;
    FNFP_VALORBCALCULOPISCOFINSITEM: Double;
    FCSTPC_CODIGO: String;
    FNFP_TOTALIPIITEM: Double;
    FNFP_TOTALICMSITEM: Double;
    FNFP_TOTALVERBAITEM: Double;
    FNFP_TOTALDESCTOITEM: Double;
    FNFP_TOTALSEGUROITEM: Double;
    FNFP_TOTALSERVICOITEM: Double;
    FNFP_TOTALFRETENFITEM: Double;
    FNFP_TOTALFRETECTRITEM: Double;
    FNFP_TOTALFRETERPAITEM: Double;
    FNFP_TOTALADICIONALITEM: Double;
    FNFP_TOTALICMSFRETENFITEM: Double;
    FNFP_TOTALBASEOUTROSITEM: Double;
    FNFP_TOTALBONIFICACAOITEM: Double;
    FNFP_TOTALICMSFRETECTRITEM: Double;
    FNFP_TOTALDESPACESSORIAITEM: Double;
    FNFP_TOTALBASEISENTOICMSITEM: Double;
    FNFP_TOTALBASECALCULOICMSITEM: Double;
    FNFP_TOTALCOMPLEMENTONFICMSITEM: Double;
    FNFP_TOTALICMSSIMPLESITEM: Double;
    FNFP_TOTALCOFINSITEM: Double;
    FNFP_TOTALPISITEM: Double;
    FNFP_TOTALBCALCULOPISCOFINSITEM: Double;
    FNFP_TOTALITEM: Double;
    FNFP_01_ID_OLD: Integer;
    FNFP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'NFP_00_01';
     const PrimaryKey = 'NFP_01_ID';
     const Sequence   = 'SEQ_NFP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_01_ID', ftInteger)]
    [Dictionary('NFP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_01_ID: Integer read FNFP_01_ID write FNFP_01_ID;
    const NFP_01_ID_Name = 'NFP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_QTDENTRADA', ftBCD)]
    [Dictionary('NFP_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_QTDENTRADA: Double read FNFP_QTDENTRADA write FNFP_QTDENTRADA;
    const NFP_QTDENTRADA_Name = 'NFP_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORITEM: Double read FNFP_VALORITEM write FNFP_VALORITEM;
    const NFP_VALORITEM_Name = 'NFP_VALORITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORIPIITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORIPIITEM: Double read FNFP_VALORIPIITEM write FNFP_VALORIPIITEM;
    const NFP_VALORIPIITEM_Name = 'NFP_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORICMSITEM: Double read FNFP_VALORICMSITEM write FNFP_VALORICMSITEM;
    const NFP_VALORICMSITEM_Name = 'NFP_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORVERBAITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORVERBAITEM: Double read FNFP_VALORVERBAITEM write FNFP_VALORVERBAITEM;
    const NFP_VALORVERBAITEM_Name = 'NFP_VALORVERBAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORDESCTOITEM: Double read FNFP_VALORDESCTOITEM write FNFP_VALORDESCTOITEM;
    const NFP_VALORDESCTOITEM_Name = 'NFP_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORSEGUROITEM: Double read FNFP_VALORSEGUROITEM write FNFP_VALORSEGUROITEM;
    const NFP_VALORSEGUROITEM_Name = 'NFP_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORSERVICOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORSERVICOITEM: Double read FNFP_VALORSERVICOITEM write FNFP_VALORSERVICOITEM;
    const NFP_VALORSERVICOITEM_Name = 'NFP_VALORSERVICOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORFRETENFITEM: Double read FNFP_VALORFRETENFITEM write FNFP_VALORFRETENFITEM;
    const NFP_VALORFRETENFITEM_Name = 'NFP_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORFRETECTRITEM: Double read FNFP_VALORFRETECTRITEM write FNFP_VALORFRETECTRITEM;
    const NFP_VALORFRETECTRITEM_Name = 'NFP_VALORFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORFRETERPAITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORFRETERPAITEM: Double read FNFP_VALORFRETERPAITEM write FNFP_VALORFRETERPAITEM;
    const NFP_VALORFRETERPAITEM_Name = 'NFP_VALORFRETERPAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORADICIONALITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORADICIONALITEM: Double read FNFP_VALORADICIONALITEM write FNFP_VALORADICIONALITEM;
    const NFP_VALORADICIONALITEM_Name = 'NFP_VALORADICIONALITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORICMSFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORICMSFRETENFITEM: Double read FNFP_VALORICMSFRETENFITEM write FNFP_VALORICMSFRETENFITEM;
    const NFP_VALORICMSFRETENFITEM_Name = 'NFP_VALORICMSFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORBASEOUTROSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASEOUTROSITEM: Double read FNFP_VALORBASEOUTROSITEM write FNFP_VALORBASEOUTROSITEM;
    const NFP_VALORBASEOUTROSITEM_Name = 'NFP_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBONIFICACAOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBONIFICACAOITEM: Double read FNFP_VALORBONIFICACAOITEM write FNFP_VALORBONIFICACAOITEM;
    const NFP_VALORBONIFICACAOITEM_Name = 'NFP_VALORBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORICMSFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORICMSFRETECTRITEM: Double read FNFP_VALORICMSFRETECTRITEM write FNFP_VALORICMSFRETECTRITEM;
    const NFP_VALORICMSFRETECTRITEM_Name = 'NFP_VALORICMSFRETECTRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORDESPACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORDESPACESSORIAITEM: Double read FNFP_VALORDESPACESSORIAITEM write FNFP_VALORDESPACESSORIAITEM;
    const NFP_VALORDESPACESSORIAITEM_Name = 'NFP_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORBASEISENTOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASEISENTOICMSITEM: Double read FNFP_VALORBASEISENTOICMSITEM write FNFP_VALORBASEISENTOICMSITEM;
    const NFP_VALORBASEISENTOICMSITEM_Name = 'NFP_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORBASECALCULOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBASECALCULOICMSITEM: Double read FNFP_VALORBASECALCULOICMSITEM write FNFP_VALORBASECALCULOICMSITEM;
    const NFP_VALORBASECALCULOICMSITEM_Name = 'NFP_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORCOMPLEMENTONFICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCOMPLEMENTONFICMSITEM: Double read FNFP_VALORCOMPLEMENTONFICMSITEM write FNFP_VALORCOMPLEMENTONFICMSITEM;
    const NFP_VALORCOMPLEMENTONFICMSITEM_Name = 'NFP_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALIPIITEM: Double read FNFP_PERCENTUALIPIITEM write FNFP_PERCENTUALIPIITEM;
    const NFP_PERCENTUALIPIITEM_Name = 'NFP_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSITEM: Double read FNFP_PERCENTUALICMSITEM write FNFP_PERCENTUALICMSITEM;
    const NFP_PERCENTUALICMSITEM_Name = 'NFP_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALVERBAITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALVERBAITEM: Double read FNFP_PERCENTUALVERBAITEM write FNFP_PERCENTUALVERBAITEM;
    const NFP_PERCENTUALVERBAITEM_Name = 'NFP_PERCENTUALVERBAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALDESCTOITEM: Double read FNFP_PERCENTUALDESCTOITEM write FNFP_PERCENTUALDESCTOITEM;
    const NFP_PERCENTUALDESCTOITEM_Name = 'NFP_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALSEGUROITEM: Double read FNFP_PERCENTUALSEGUROITEM write FNFP_PERCENTUALSEGUROITEM;
    const NFP_PERCENTUALSEGUROITEM_Name = 'NFP_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALSERVICOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALSERVICOITEM: Double read FNFP_PERCENTUALSERVICOITEM write FNFP_PERCENTUALSERVICOITEM;
    const NFP_PERCENTUALSERVICOITEM_Name = 'NFP_PERCENTUALSERVICOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALFRETENFITEM', ftBCD)]
    [Dictionary('NFP_PERCENTUALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALFRETENFITEM: Double read FNFP_PERCENTUALFRETENFITEM write FNFP_PERCENTUALFRETENFITEM;
    const NFP_PERCENTUALFRETENFITEM_Name = 'NFP_PERCENTUALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALFRETERPAITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALFRETERPAITEM: Double read FNFP_PERCENTUALFRETERPAITEM write FNFP_PERCENTUALFRETERPAITEM;
    const NFP_PERCENTUALFRETERPAITEM_Name = 'NFP_PERCENTUALFRETERPAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALFRETECTRITEM: Double read FNFP_PERCENTUALFRETECTRITEM write FNFP_PERCENTUALFRETECTRITEM;
    const NFP_PERCENTUALFRETECTRITEM_Name = 'NFP_PERCENTUALFRETECTRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALREDUCAOBCITEM: Double read FNFP_PERCENTUALREDUCAOBCITEM write FNFP_PERCENTUALREDUCAOBCITEM;
    const NFP_PERCENTUALREDUCAOBCITEM_Name = 'NFP_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALICMSSIMPLESITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSSIMPLESITEM: Double read FNFP_PERCENTUALICMSSIMPLESITEM write FNFP_PERCENTUALICMSSIMPLESITEM;
    const NFP_PERCENTUALICMSSIMPLESITEM_Name = 'NFP_PERCENTUALICMSSIMPLESITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALICMSFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSFRETENFITEM: Double read FNFP_PERCENTUALICMSFRETENFITEM write FNFP_PERCENTUALICMSFRETENFITEM;
    const NFP_PERCENTUALICMSFRETENFITEM_Name = 'NFP_PERCENTUALICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALBONIFICACAOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALBONIFICACAOITEM: Double read FNFP_PERCENTUALBONIFICACAOITEM write FNFP_PERCENTUALBONIFICACAOITEM;
    const NFP_PERCENTUALBONIFICACAOITEM_Name = 'NFP_PERCENTUALBONIFICACAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSDESTINOITEM: Double read FNFP_PERCENTUALICMSDESTINOITEM write FNFP_PERCENTUALICMSDESTINOITEM;
    const NFP_PERCENTUALICMSDESTINOITEM_Name = 'NFP_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALICMSFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSFRETECTRITEM: Double read FNFP_PERCENTUALICMSFRETECTRITEM write FNFP_PERCENTUALICMSFRETECTRITEM;
    const NFP_PERCENTUALICMSFRETECTRITEM_Name = 'NFP_PERCENTUALICMSFRETECTRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NFP_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALDESPACESSORIAITEM: Double read FNFP_PERCENTUALDESPACESSORIAITEM write FNFP_PERCENTUALDESPACESSORIAITEM;
    const NFP_PERCENTUALDESPACESSORIAITEM_Name = 'NFP_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORICMSSIMPLESITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORICMSSIMPLESITEM: Double read FNFP_VALORICMSSIMPLESITEM write FNFP_VALORICMSSIMPLESITEM;
    const NFP_VALORICMSSIMPLESITEM_Name = 'NFP_VALORICMSSIMPLESITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCUSTOCOMPRANFE', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCUSTOCOMPRANFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCUSTOCOMPRANFE: Double read FNFP_VALORCUSTOCOMPRANFE write FNFP_VALORCUSTOCOMPRANFE;
    const NFP_VALORCUSTOCOMPRANFE_Name = 'NFP_VALORCUSTOCOMPRANFE';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCUSTOLIQUIDONFE', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCUSTOLIQUIDONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCUSTOLIQUIDONFE: Double read FNFP_VALORCUSTOLIQUIDONFE write FNFP_VALORCUSTOLIQUIDONFE;
    const NFP_VALORCUSTOLIQUIDONFE_Name = 'NFP_VALORCUSTOLIQUIDONFE';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCUSTOINVENTARIONFE', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCUSTOINVENTARIONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCUSTOINVENTARIONFE: Double read FNFP_VALORCUSTOINVENTARIONFE write FNFP_VALORCUSTOINVENTARIONFE;
    const NFP_VALORCUSTOINVENTARIONFE_Name = 'NFP_VALORCUSTOINVENTARIONFE';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCUSTOCOMPRAMEDIO: Double read FNFP_VALORCUSTOCOMPRAMEDIO write FNFP_VALORCUSTOCOMPRAMEDIO;
    const NFP_VALORCUSTOCOMPRAMEDIO_Name = 'NFP_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCUSTOLIQUIDOMEDIO: Double read FNFP_VALORCUSTOLIQUIDOMEDIO write FNFP_VALORCUSTOLIQUIDOMEDIO;
    const NFP_VALORCUSTOLIQUIDOMEDIO_Name = 'NFP_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCUSTOINVENTARIOMEDIO: Double read FNFP_VALORCUSTOINVENTARIOMEDIO write FNFP_VALORCUSTOINVENTARIOMEDIO;
    const NFP_VALORCUSTOINVENTARIOMEDIO_Name = 'NFP_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFP_ULTIMOCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('NFP_ULTIMOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_ULTIMOCUSTOCOMPRA: Double read FNFP_ULTIMOCUSTOCOMPRA write FNFP_ULTIMOCUSTOCOMPRA;
    const NFP_ULTIMOCUSTOCOMPRA_Name = 'NFP_ULTIMOCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('NFP_ULTIMOCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('NFP_ULTIMOCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_ULTIMOCUSTOLIQUIDO: Double read FNFP_ULTIMOCUSTOLIQUIDO write FNFP_ULTIMOCUSTOLIQUIDO;
    const NFP_ULTIMOCUSTOLIQUIDO_Name = 'NFP_ULTIMOCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NFP_ULTIMOCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('NFP_ULTIMOCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_ULTIMOCUSTOINVENTARIO: Double read FNFP_ULTIMOCUSTOINVENTARIO write FNFP_ULTIMOCUSTOINVENTARIO;
    const NFP_ULTIMOCUSTOINVENTARIO_Name = 'NFP_ULTIMOCUSTOINVENTARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAALTERACAO: TDateTime read FNFP_DATAALTERACAO write FNFP_DATAALTERACAO;
    const NFP_DATAALTERACAO_Name = 'NFP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFP_ULTIMOCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('NFP_ULTIMOCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_ULTIMOCUSTOCOMPRAMEDIO: Double read FNFP_ULTIMOCUSTOCOMPRAMEDIO write FNFP_ULTIMOCUSTOCOMPRAMEDIO;
    const NFP_ULTIMOCUSTOCOMPRAMEDIO_Name = 'NFP_ULTIMOCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFP_ULTIMOCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('NFP_ULTIMOCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_ULTIMOCUSTOLIQUIDOMEDIO: Double read FNFP_ULTIMOCUSTOLIQUIDOMEDIO write FNFP_ULTIMOCUSTOLIQUIDOMEDIO;
    const NFP_ULTIMOCUSTOLIQUIDOMEDIO_Name = 'NFP_ULTIMOCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFP_ULTIMOCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('NFP_ULTIMOCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_ULTIMOCUSTOINVENTARIOMEDIO: Double read FNFP_ULTIMOCUSTOINVENTARIOMEDIO write FNFP_ULTIMOCUSTOINVENTARIOMEDIO;
    const NFP_ULTIMOCUSTOINVENTARIOMEDIO_Name = 'NFP_ULTIMOCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('NFP_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALCOFINSITEM: Double read FNFP_PERCENTUALCOFINSITEM write FNFP_PERCENTUALCOFINSITEM;
    const NFP_PERCENTUALCOFINSITEM_Name = 'NFP_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALPISITEM: Double read FNFP_PERCENTUALPISITEM write FNFP_PERCENTUALPISITEM;
    const NFP_PERCENTUALPISITEM_Name = 'NFP_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCOFINSITEM: Double read FNFP_VALORCOFINSITEM write FNFP_VALORCOFINSITEM;
    const NFP_VALORCOFINSITEM_Name = 'NFP_VALORCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORPISITEM: Double read FNFP_VALORPISITEM write FNFP_VALORPISITEM;
    const NFP_VALORPISITEM_Name = 'NFP_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBCALCULOPISCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBCALCULOPISCOFINSITEM: Double read FNFP_VALORBCALCULOPISCOFINSITEM write FNFP_VALORBCALCULOPISCOFINSITEM;
    const NFP_VALORBCALCULOPISCOFINSITEM_Name = 'NFP_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALIPIITEM', ftBCD)]
    [Dictionary('NFP_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALIPIITEM: Double read FNFP_TOTALIPIITEM write FNFP_TOTALIPIITEM;
    const NFP_TOTALIPIITEM_Name = 'NFP_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALICMSITEM', ftBCD)]
    [Dictionary('NFP_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSITEM: Double read FNFP_TOTALICMSITEM write FNFP_TOTALICMSITEM;
    const NFP_TOTALICMSITEM_Name = 'NFP_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALVERBAITEM', ftBCD)]
    [Dictionary('NFP_TOTALVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALVERBAITEM: Double read FNFP_TOTALVERBAITEM write FNFP_TOTALVERBAITEM;
    const NFP_TOTALVERBAITEM_Name = 'NFP_TOTALVERBAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('NFP_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESCTOITEM: Double read FNFP_TOTALDESCTOITEM write FNFP_TOTALDESCTOITEM;
    const NFP_TOTALDESCTOITEM_Name = 'NFP_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('NFP_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALSEGUROITEM: Double read FNFP_TOTALSEGUROITEM write FNFP_TOTALSEGUROITEM;
    const NFP_TOTALSEGUROITEM_Name = 'NFP_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALSERVICOITEM', ftBCD)]
    [Dictionary('NFP_TOTALSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALSERVICOITEM: Double read FNFP_TOTALSERVICOITEM write FNFP_TOTALSERVICOITEM;
    const NFP_TOTALSERVICOITEM_Name = 'NFP_TOTALSERVICOITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALFRETENFITEM', ftBCD)]
    [Dictionary('NFP_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETENFITEM: Double read FNFP_TOTALFRETENFITEM write FNFP_TOTALFRETENFITEM;
    const NFP_TOTALFRETENFITEM_Name = 'NFP_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALFRETECTRITEM', ftBCD)]
    [Dictionary('NFP_TOTALFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETECTRITEM: Double read FNFP_TOTALFRETECTRITEM write FNFP_TOTALFRETECTRITEM;
    const NFP_TOTALFRETECTRITEM_Name = 'NFP_TOTALFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALFRETERPAITEM', ftBCD)]
    [Dictionary('NFP_TOTALFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETERPAITEM: Double read FNFP_TOTALFRETERPAITEM write FNFP_TOTALFRETERPAITEM;
    const NFP_TOTALFRETERPAITEM_Name = 'NFP_TOTALFRETERPAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALADICIONALITEM', ftBCD)]
    [Dictionary('NFP_TOTALADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALADICIONALITEM: Double read FNFP_TOTALADICIONALITEM write FNFP_TOTALADICIONALITEM;
    const NFP_TOTALADICIONALITEM_Name = 'NFP_TOTALADICIONALITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALICMSFRETENFITEM', ftBCD)]
    [Dictionary('NFP_TOTALICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSFRETENFITEM: Double read FNFP_TOTALICMSFRETENFITEM write FNFP_TOTALICMSFRETENFITEM;
    const NFP_TOTALICMSFRETENFITEM_Name = 'NFP_TOTALICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASEOUTROSITEM', ftBCD)]
    [Dictionary('NFP_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASEOUTROSITEM: Double read FNFP_TOTALBASEOUTROSITEM write FNFP_TOTALBASEOUTROSITEM;
    const NFP_TOTALBASEOUTROSITEM_Name = 'NFP_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBONIFICACAOITEM', ftBCD)]
    [Dictionary('NFP_TOTALBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBONIFICACAOITEM: Double read FNFP_TOTALBONIFICACAOITEM write FNFP_TOTALBONIFICACAOITEM;
    const NFP_TOTALBONIFICACAOITEM_Name = 'NFP_TOTALBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALICMSFRETECTRITEM', ftBCD)]
    [Dictionary('NFP_TOTALICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSFRETECTRITEM: Double read FNFP_TOTALICMSFRETECTRITEM write FNFP_TOTALICMSFRETECTRITEM;
    const NFP_TOTALICMSFRETECTRITEM_Name = 'NFP_TOTALICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NFP_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALDESPACESSORIAITEM: Double read FNFP_TOTALDESPACESSORIAITEM write FNFP_TOTALDESPACESSORIAITEM;
    const NFP_TOTALDESPACESSORIAITEM_Name = 'NFP_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('NFP_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASEISENTOICMSITEM: Double read FNFP_TOTALBASEISENTOICMSITEM write FNFP_TOTALBASEISENTOICMSITEM;
    const NFP_TOTALBASEISENTOICMSITEM_Name = 'NFP_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('NFP_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBASECALCULOICMSITEM: Double read FNFP_TOTALBASECALCULOICMSITEM write FNFP_TOTALBASECALCULOICMSITEM;
    const NFP_TOTALBASECALCULOICMSITEM_Name = 'NFP_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALCOMPLEMENTONFICMSITEM', ftBCD)]
    [Dictionary('NFP_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALCOMPLEMENTONFICMSITEM: Double read FNFP_TOTALCOMPLEMENTONFICMSITEM write FNFP_TOTALCOMPLEMENTONFICMSITEM;
    const NFP_TOTALCOMPLEMENTONFICMSITEM_Name = 'NFP_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALICMSSIMPLESITEM', ftBCD)]
    [Dictionary('NFP_TOTALICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSSIMPLESITEM: Double read FNFP_TOTALICMSSIMPLESITEM write FNFP_TOTALICMSSIMPLESITEM;
    const NFP_TOTALICMSSIMPLESITEM_Name = 'NFP_TOTALICMSSIMPLESITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('NFP_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALCOFINSITEM: Double read FNFP_TOTALCOFINSITEM write FNFP_TOTALCOFINSITEM;
    const NFP_TOTALCOFINSITEM_Name = 'NFP_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALPISITEM', ftBCD)]
    [Dictionary('NFP_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPISITEM: Double read FNFP_TOTALPISITEM write FNFP_TOTALPISITEM;
    const NFP_TOTALPISITEM_Name = 'NFP_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFP_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALBCALCULOPISCOFINSITEM: Double read FNFP_TOTALBCALCULOPISCOFINSITEM write FNFP_TOTALBCALCULOPISCOFINSITEM;
    const NFP_TOTALBCALCULOPISCOFINSITEM_Name = 'NFP_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_TOTALITEM', ftBCD)]
    [Dictionary('NFP_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALITEM: Double read FNFP_TOTALITEM write FNFP_TOTALITEM;
    const NFP_TOTALITEM_Name = 'NFP_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_01_ID_OLD', ftInteger)]
    [Dictionary('NFP_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_01_ID_OLD: Integer read FNFP_01_ID_OLD write FNFP_01_ID_OLD;
    const NFP_01_ID_OLD_Name = 'NFP_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFP_ID_OLD', ftInteger)]
    [Dictionary('NFP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID_OLD: Integer read FNFP_ID_OLD write FNFP_ID_OLD;
    const NFP_ID_OLD_Name = 'NFP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_00_01)

end.
