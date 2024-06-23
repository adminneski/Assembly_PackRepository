unit express.dbo.CMP_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cmp_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CMP_00_01', '')]
  [PrimaryKey('CMP_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CMP_01_ID')]
  TDtoCMP_00_01 = class
  private
    { Private declarations } 
    FCMP_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCMP_ID: Integer;
    FPRO_CODIGO: Integer;
    FCST_CODIGO: String;
    FNCM_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCMP_ORDEMITEM: Integer;
    FCMP_QTDPEDIDA: Double;
    FCMP_QTDATENDIDA: Double;
    FCMP_VALORITEM: Double;
    FCMP_VALORIPIITEM: Double;
    FCMP_VALORPISITEM: Double;
    FCMP_VALORICMSITEM: Double;
    FCMP_VALORICMSRITEM: Double;
    FCMP_VALORVERBAITEM: Double;
    FCMP_VALORFRETEITEM: Double;
    FCMP_VALORCOFINSITEM: Double;
    FCMP_VALORDESCTOITEM: Double;
    FCMP_VALORSEGUROITEM: Double;
    FCMP_VALORSERVICOITEM: Double;
    FCMP_VALORADICIONALITEM: Double;
    FCMP_VALORBONIFICACAOITEM: Double;
    FCMP_VALORBASEOUTROSITEM: Double;
    FCMP_VALORDESPACESSORIAITEM: Double;
    FCMP_VALORSUBSTRIBUTARIAITEM: Double;
    FCMP_VALORBASEISENTOICMSITEM: Double;
    FCMP_VALORBASECALCULOMVAITEM: Double;
    FCMP_VALORBASECALCULOICMSITEM: Double;
    FCMP_VALORCOMPLEMENTONFICMSITEM: Double;
    FCMP_PERCENTUALIPIITEM: Double;
    FCMP_PERCENTUALPISITEM: Double;
    FCMP_PERCENTUALMVAITEM: Double;
    FCMP_PERCENTUALICMSITEM: Double;
    FCMP_PERCENTUALICMSRITEM: Double;
    FCMP_PERCENTUALCOFINSITEM: Double;
    FCMP_PERCENTUALVERBAITEM: Double;
    FCMP_PERCENTUALFRETEITEM: Double;
    FCMP_PERCENTUALDESCTOITEM: Double;
    FCMP_PERCENTUALSERVICOITEM: Double;
    FCMP_PERCENTUALSEGUROITEM: Double;
    FCMP_PERCENTUALICMSSAIDAITEM: Double;
    FCMP_PERCENTUALREDUCAOBCITEM: Double;
    FCMP_PERCENTUALICMSDESTINOITEM: Double;
    FCMP_PERCENTUALBONIFICACAOITEM: Double;
    FCMP_PERCENTUALDESPACESSORIAITEM: Double;
    FCMP_VALORCUSTOCOMPRACMP: Double;
    FCMP_VALORCUSTOLIQUIDOCMP: Double;
    FCMP_VALORCUSTOINVENTARIOCMP: Double;
    FCMP_VALORCUSTOLIQUIDOMEDIO: Double;
    FCMP_VALORCUSTOCOMPRAMEDIO: Double;
    FCMP_VALORCUSTOINVENTARIOMEDIO: Double;
    FCMP_DATAALTERACAO: TDateTime;
    FCMP_VALORFORNECEDOR: Double;
    FCMP_01_ID_OLD: Integer;
    FCMP_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CMP_00_01';
    const PrimaryKey = 'CMP_01_ID';
    const Sequence   = 'SEQ_CMP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_01_ID', ftInteger)]
    [Dictionary('CMP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_01_ID: Integer read FCMP_01_ID write FCMP_01_ID;
    const CMP_01_ID_Name = 'CMP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_ID', ftInteger)]
    [ForeignKey('CMP_00_01_fk', 'CMP_ID', 'CMP_00', 'CMP_ID', SetNull, SetNull)]
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

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_ORDEMITEM', ftInteger)]
    [Dictionary('CMP_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_ORDEMITEM: Integer read FCMP_ORDEMITEM write FCMP_ORDEMITEM;
    const CMP_ORDEMITEM_Name = 'CMP_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('CMP_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_QTDPEDIDA: Double read FCMP_QTDPEDIDA write FCMP_QTDPEDIDA;
    const CMP_QTDPEDIDA_Name = 'CMP_QTDPEDIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_QTDATENDIDA', ftBCD, 18, 4)]
    [Dictionary('CMP_QTDATENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_QTDATENDIDA: Double read FCMP_QTDATENDIDA write FCMP_QTDATENDIDA;
    const CMP_QTDATENDIDA_Name = 'CMP_QTDATENDIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_VALORITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORITEM: Double read FCMP_VALORITEM write FCMP_VALORITEM;
    const CMP_VALORITEM_Name = 'CMP_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORIPIITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORIPIITEM: Double read FCMP_VALORIPIITEM write FCMP_VALORIPIITEM;
    const CMP_VALORIPIITEM_Name = 'CMP_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORPISITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORPISITEM: Double read FCMP_VALORPISITEM write FCMP_VALORPISITEM;
    const CMP_VALORPISITEM_Name = 'CMP_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORICMSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORICMSITEM: Double read FCMP_VALORICMSITEM write FCMP_VALORICMSITEM;
    const CMP_VALORICMSITEM_Name = 'CMP_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORICMSRITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORICMSRITEM: Double read FCMP_VALORICMSRITEM write FCMP_VALORICMSRITEM;
    const CMP_VALORICMSRITEM_Name = 'CMP_VALORICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORVERBAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORVERBAITEM: Double read FCMP_VALORVERBAITEM write FCMP_VALORVERBAITEM;
    const CMP_VALORVERBAITEM_Name = 'CMP_VALORVERBAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORFRETEITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORFRETEITEM: Double read FCMP_VALORFRETEITEM write FCMP_VALORFRETEITEM;
    const CMP_VALORFRETEITEM_Name = 'CMP_VALORFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCOFINSITEM: Double read FCMP_VALORCOFINSITEM write FCMP_VALORCOFINSITEM;
    const CMP_VALORCOFINSITEM_Name = 'CMP_VALORCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORDESCTOITEM: Double read FCMP_VALORDESCTOITEM write FCMP_VALORDESCTOITEM;
    const CMP_VALORDESCTOITEM_Name = 'CMP_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORSEGUROITEM: Double read FCMP_VALORSEGUROITEM write FCMP_VALORSEGUROITEM;
    const CMP_VALORSEGUROITEM_Name = 'CMP_VALORSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORSERVICOITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORSERVICOITEM: Double read FCMP_VALORSERVICOITEM write FCMP_VALORSERVICOITEM;
    const CMP_VALORSERVICOITEM_Name = 'CMP_VALORSERVICOITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORADICIONALITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORADICIONALITEM: Double read FCMP_VALORADICIONALITEM write FCMP_VALORADICIONALITEM;
    const CMP_VALORADICIONALITEM_Name = 'CMP_VALORADICIONALITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORBONIFICACAOITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORBONIFICACAOITEM: Double read FCMP_VALORBONIFICACAOITEM write FCMP_VALORBONIFICACAOITEM;
    const CMP_VALORBONIFICACAOITEM_Name = 'CMP_VALORBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORBASEOUTROSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORBASEOUTROSITEM: Double read FCMP_VALORBASEOUTROSITEM write FCMP_VALORBASEOUTROSITEM;
    const CMP_VALORBASEOUTROSITEM_Name = 'CMP_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORDESPACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORDESPACESSORIAITEM: Double read FCMP_VALORDESPACESSORIAITEM write FCMP_VALORDESPACESSORIAITEM;
    const CMP_VALORDESPACESSORIAITEM_Name = 'CMP_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORSUBSTRIBUTARIAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORSUBSTRIBUTARIAITEM: Double read FCMP_VALORSUBSTRIBUTARIAITEM write FCMP_VALORSUBSTRIBUTARIAITEM;
    const CMP_VALORSUBSTRIBUTARIAITEM_Name = 'CMP_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORBASEISENTOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORBASEISENTOICMSITEM: Double read FCMP_VALORBASEISENTOICMSITEM write FCMP_VALORBASEISENTOICMSITEM;
    const CMP_VALORBASEISENTOICMSITEM_Name = 'CMP_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORBASECALCULOMVAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORBASECALCULOMVAITEM: Double read FCMP_VALORBASECALCULOMVAITEM write FCMP_VALORBASECALCULOMVAITEM;
    const CMP_VALORBASECALCULOMVAITEM_Name = 'CMP_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORBASECALCULOICMSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORBASECALCULOICMSITEM: Double read FCMP_VALORBASECALCULOICMSITEM write FCMP_VALORBASECALCULOICMSITEM;
    const CMP_VALORBASECALCULOICMSITEM_Name = 'CMP_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCOMPLEMENTONFICMSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCOMPLEMENTONFICMSITEM: Double read FCMP_VALORCOMPLEMENTONFICMSITEM write FCMP_VALORCOMPLEMENTONFICMSITEM;
    const CMP_VALORCOMPLEMENTONFICMSITEM_Name = 'CMP_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALIPIITEM: Double read FCMP_PERCENTUALIPIITEM write FCMP_PERCENTUALIPIITEM;
    const CMP_PERCENTUALIPIITEM_Name = 'CMP_PERCENTUALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALPISITEM: Double read FCMP_PERCENTUALPISITEM write FCMP_PERCENTUALPISITEM;
    const CMP_PERCENTUALPISITEM_Name = 'CMP_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALMVAITEM: Double read FCMP_PERCENTUALMVAITEM write FCMP_PERCENTUALMVAITEM;
    const CMP_PERCENTUALMVAITEM_Name = 'CMP_PERCENTUALMVAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALICMSITEM: Double read FCMP_PERCENTUALICMSITEM write FCMP_PERCENTUALICMSITEM;
    const CMP_PERCENTUALICMSITEM_Name = 'CMP_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALICMSRITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALICMSRITEM: Double read FCMP_PERCENTUALICMSRITEM write FCMP_PERCENTUALICMSRITEM;
    const CMP_PERCENTUALICMSRITEM_Name = 'CMP_PERCENTUALICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALCOFINSITEM: Double read FCMP_PERCENTUALCOFINSITEM write FCMP_PERCENTUALCOFINSITEM;
    const CMP_PERCENTUALCOFINSITEM_Name = 'CMP_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALVERBAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALVERBAITEM: Double read FCMP_PERCENTUALVERBAITEM write FCMP_PERCENTUALVERBAITEM;
    const CMP_PERCENTUALVERBAITEM_Name = 'CMP_PERCENTUALVERBAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALFRETEITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALFRETEITEM: Double read FCMP_PERCENTUALFRETEITEM write FCMP_PERCENTUALFRETEITEM;
    const CMP_PERCENTUALFRETEITEM_Name = 'CMP_PERCENTUALFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALDESCTOITEM: Double read FCMP_PERCENTUALDESCTOITEM write FCMP_PERCENTUALDESCTOITEM;
    const CMP_PERCENTUALDESCTOITEM_Name = 'CMP_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALSERVICOITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALSERVICOITEM: Double read FCMP_PERCENTUALSERVICOITEM write FCMP_PERCENTUALSERVICOITEM;
    const CMP_PERCENTUALSERVICOITEM_Name = 'CMP_PERCENTUALSERVICOITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALSEGUROITEM: Double read FCMP_PERCENTUALSEGUROITEM write FCMP_PERCENTUALSEGUROITEM;
    const CMP_PERCENTUALSEGUROITEM_Name = 'CMP_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALICMSSAIDAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALICMSSAIDAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALICMSSAIDAITEM: Double read FCMP_PERCENTUALICMSSAIDAITEM write FCMP_PERCENTUALICMSSAIDAITEM;
    const CMP_PERCENTUALICMSSAIDAITEM_Name = 'CMP_PERCENTUALICMSSAIDAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALREDUCAOBCITEM: Double read FCMP_PERCENTUALREDUCAOBCITEM write FCMP_PERCENTUALREDUCAOBCITEM;
    const CMP_PERCENTUALREDUCAOBCITEM_Name = 'CMP_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALICMSDESTINOITEM: Double read FCMP_PERCENTUALICMSDESTINOITEM write FCMP_PERCENTUALICMSDESTINOITEM;
    const CMP_PERCENTUALICMSDESTINOITEM_Name = 'CMP_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALBONIFICACAOITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALBONIFICACAOITEM: Double read FCMP_PERCENTUALBONIFICACAOITEM write FCMP_PERCENTUALBONIFICACAOITEM;
    const CMP_PERCENTUALBONIFICACAOITEM_Name = 'CMP_PERCENTUALBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_PERCENTUALDESPACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_PERCENTUALDESPACESSORIAITEM: Double read FCMP_PERCENTUALDESPACESSORIAITEM write FCMP_PERCENTUALDESPACESSORIAITEM;
    const CMP_PERCENTUALDESPACESSORIAITEM_Name = 'CMP_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCUSTOCOMPRACMP', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCUSTOCOMPRACMP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCUSTOCOMPRACMP: Double read FCMP_VALORCUSTOCOMPRACMP write FCMP_VALORCUSTOCOMPRACMP;
    const CMP_VALORCUSTOCOMPRACMP_Name = 'CMP_VALORCUSTOCOMPRACMP';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCUSTOLIQUIDOCMP', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCUSTOLIQUIDOCMP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCUSTOLIQUIDOCMP: Double read FCMP_VALORCUSTOLIQUIDOCMP write FCMP_VALORCUSTOLIQUIDOCMP;
    const CMP_VALORCUSTOLIQUIDOCMP_Name = 'CMP_VALORCUSTOLIQUIDOCMP';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCUSTOINVENTARIOCMP', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCUSTOINVENTARIOCMP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCUSTOINVENTARIOCMP: Double read FCMP_VALORCUSTOINVENTARIOCMP write FCMP_VALORCUSTOINVENTARIOCMP;
    const CMP_VALORCUSTOINVENTARIOCMP_Name = 'CMP_VALORCUSTOINVENTARIOCMP';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCUSTOLIQUIDOMEDIO: Double read FCMP_VALORCUSTOLIQUIDOMEDIO write FCMP_VALORCUSTOLIQUIDOMEDIO;
    const CMP_VALORCUSTOLIQUIDOMEDIO_Name = 'CMP_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCUSTOCOMPRAMEDIO: Double read FCMP_VALORCUSTOCOMPRAMEDIO write FCMP_VALORCUSTOCOMPRAMEDIO;
    const CMP_VALORCUSTOCOMPRAMEDIO_Name = 'CMP_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('CMP_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORCUSTOINVENTARIOMEDIO: Double read FCMP_VALORCUSTOINVENTARIOMEDIO write FCMP_VALORCUSTOINVENTARIOMEDIO;
    const CMP_VALORCUSTOINVENTARIOMEDIO_Name = 'CMP_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CMP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMP_DATAALTERACAO: TDateTime read FCMP_DATAALTERACAO write FCMP_DATAALTERACAO;
    const CMP_DATAALTERACAO_Name = 'CMP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_VALORFORNECEDOR', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORFORNECEDOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORFORNECEDOR: Double read FCMP_VALORFORNECEDOR write FCMP_VALORFORNECEDOR;
    const CMP_VALORFORNECEDOR_Name = 'CMP_VALORFORNECEDOR';

    [Restrictions([NoValidate])]
    [Column('CMP_01_ID_OLD', ftInteger)]
    [Dictionary('CMP_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_01_ID_OLD: Integer read FCMP_01_ID_OLD write FCMP_01_ID_OLD;
    const CMP_01_ID_OLD_Name = 'CMP_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CMP_ID_OLD', ftInteger)]
    [Dictionary('CMP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_ID_OLD: Integer read FCMP_ID_OLD write FCMP_ID_OLD;
    const CMP_ID_OLD_Name = 'CMP_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCMP_00_01)

end.
