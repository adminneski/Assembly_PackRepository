unit express.dbo.REL_V02_NFE;

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
  [Table('REL_V02_NFE', '')]
  TDtoREL_V02_NFE = class
  private
    { Private declarations } 
    FNFE_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_ID: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FNFE_QTDENTRADA: Double;
    FNFE_VALORITEM: Double;
    FNFE_TOTALITEM: Double;
    FNFE_VALORICMSRNFITEM: Double;
    FNFE_VALORICMSRDUAITEM: Double;
    FNFE_VALORADICIONALITEM: Double;
    FNFE_VALORDESPACESSORIAITEM: Double;
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
    FNFE_PRECOZEROMKP: Double;
    FNFE_PRECOVENDAMKP: Double;
    FNFE_PRECOSUGERIDOMKP: Double;
    FNFE_PERCENTUALLUCROVENDAMKP: Double;
    FNFE_PERCENTUALLUCROSUGERIDOMKP: Double;
    FNFE_PERCENTUALDESPESASLUCROMKP: Double;
    FNFE_PERCENTUALMARKUPLUCRO: Double;
    FNFE_PERCENTUALMARKUPZERO: Double;
    FSGM_CODIGO: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FPRO_PERCENTUALLUCROMKP: Double;
    FPRO_PERCENTUALCOMISSAO: Double;
    FAQT_ALIQUOTA: Double;
    FAQT_ALIQUOTAECF: String;
    FLEF_PERCENTUALPIS: Double;
    FLEF_PERCENTUALCOFINS: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_NFE';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('NFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_QTDENTRADA: Double read FNFE_QTDENTRADA write FNFE_QTDENTRADA;
    const NFE_QTDENTRADA_Name = 'NFE_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORITEM', ftBCD)]
    [Dictionary('NFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEM: Double read FNFE_VALORITEM write FNFE_VALORITEM;
    const NFE_VALORITEM_Name = 'NFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALITEM', ftBCD)]
    [Dictionary('NFE_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALITEM: Double read FNFE_TOTALITEM write FNFE_TOTALITEM;
    const NFE_TOTALITEM_Name = 'NFE_TOTALITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('NFE_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSRNFITEM: Double read FNFE_VALORICMSRNFITEM write FNFE_VALORICMSRNFITEM;
    const NFE_VALORICMSRNFITEM_Name = 'NFE_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORICMSRDUAITEM', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORICMSRDUAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORICMSRDUAITEM: Double read FNFE_VALORICMSRDUAITEM write FNFE_VALORICMSRDUAITEM;
    const NFE_VALORICMSRDUAITEM_Name = 'NFE_VALORICMSRDUAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORADICIONALITEM', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORADICIONALITEM: Double read FNFE_VALORADICIONALITEM write FNFE_VALORADICIONALITEM;
    const NFE_VALORADICIONALITEM_Name = 'NFE_VALORADICIONALITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NFE_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORDESPACESSORIAITEM: Double read FNFE_VALORDESPACESSORIAITEM write FNFE_VALORDESPACESSORIAITEM;
    const NFE_VALORDESPACESSORIAITEM_Name = 'NFE_VALORDESPACESSORIAITEM';

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
    [Column('NFE_VALORCUSTOCOMPRANFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOCOMPRANFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOCOMPRANFE: Double read FNFE_VALORCUSTOCOMPRANFE write FNFE_VALORCUSTOCOMPRANFE;
    const NFE_VALORCUSTOCOMPRANFE_Name = 'NFE_VALORCUSTOCOMPRANFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOLIQUIDONFE', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORCUSTOLIQUIDONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOLIQUIDONFE: Double read FNFE_VALORCUSTOLIQUIDONFE write FNFE_VALORCUSTOLIQUIDONFE;
    const NFE_VALORCUSTOLIQUIDONFE_Name = 'NFE_VALORCUSTOLIQUIDONFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOINVENTARIONFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOINVENTARIONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOINVENTARIONFE: Double read FNFE_VALORCUSTOINVENTARIONFE write FNFE_VALORCUSTOINVENTARIONFE;
    const NFE_VALORCUSTOINVENTARIONFE_Name = 'NFE_VALORCUSTOINVENTARIONFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOCOMPRAMEDIO', ftBCD)]
    [Dictionary('NFE_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOCOMPRAMEDIO: Double read FNFE_VALORCUSTOCOMPRAMEDIO write FNFE_VALORCUSTOCOMPRAMEDIO;
    const NFE_VALORCUSTOCOMPRAMEDIO_Name = 'NFE_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOLIQUIDOMEDIO', ftBCD, 10, 5)]
    [Dictionary('NFE_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOLIQUIDOMEDIO: Double read FNFE_VALORCUSTOLIQUIDOMEDIO write FNFE_VALORCUSTOLIQUIDOMEDIO;
    const NFE_VALORCUSTOLIQUIDOMEDIO_Name = 'NFE_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOINVENTARIOMEDIO', ftBCD)]
    [Dictionary('NFE_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOINVENTARIOMEDIO: Double read FNFE_VALORCUSTOINVENTARIOMEDIO write FNFE_VALORCUSTOINVENTARIOMEDIO;
    const NFE_VALORCUSTOINVENTARIOMEDIO_Name = 'NFE_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOCOMPRA', ftBCD)]
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
    [Column('NFE_PRECOZEROMKP', ftBCD)]
    [Dictionary('NFE_PRECOZEROMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PRECOZEROMKP: Double read FNFE_PRECOZEROMKP write FNFE_PRECOZEROMKP;
    const NFE_PRECOZEROMKP_Name = 'NFE_PRECOZEROMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PRECOVENDAMKP', ftBCD, 48, 5)]
    [Dictionary('NFE_PRECOVENDAMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PRECOVENDAMKP: Double read FNFE_PRECOVENDAMKP write FNFE_PRECOVENDAMKP;
    const NFE_PRECOVENDAMKP_Name = 'NFE_PRECOVENDAMKP';

    [Restrictions([NoValidate])]
    [Column('NFE_PRECOSUGERIDOMKP', ftBCD)]
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
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LCZ_CODIGO', ftInteger)]
    [Dictionary('LCZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LCZ_CODIGO: Integer read FLCZ_CODIGO write FLCZ_CODIGO;
    const LCZ_CODIGO_Name = 'LCZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LCZ_DESCRICAO', ftString, 30)]
    [Dictionary('LCZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_DESCRICAO: String read FLCZ_DESCRICAO write FLCZ_DESCRICAO;
    const LCZ_DESCRICAO_Name = 'LCZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALLUCROMKP', ftBCD, 10, 2)]
    [Dictionary('PRO_PERCENTUALLUCROMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALLUCROMKP: Double read FPRO_PERCENTUALLUCROMKP write FPRO_PERCENTUALLUCROMKP;
    const PRO_PERCENTUALLUCROMKP_Name = 'PRO_PERCENTUALLUCROMKP';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PRO_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALCOMISSAO: Double read FPRO_PERCENTUALCOMISSAO write FPRO_PERCENTUALCOMISSAO;
    const PRO_PERCENTUALCOMISSAO_Name = 'PRO_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTA', ftBCD, 48, 2)]
    [Dictionary('AQT_ALIQUOTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AQT_ALIQUOTA: Double read FAQT_ALIQUOTA write FAQT_ALIQUOTA;
    const AQT_ALIQUOTA_Name = 'AQT_ALIQUOTA';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTAECF', ftString, 5)]
    [Dictionary('AQT_ALIQUOTAECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_ALIQUOTAECF: String read FAQT_ALIQUOTAECF write FAQT_ALIQUOTAECF;
    const AQT_ALIQUOTAECF_Name = 'AQT_ALIQUOTAECF';

    [Restrictions([NoValidate])]
    [Column('LEF_PERCENTUALPIS', ftBCD)]
    [Dictionary('LEF_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALPIS: Double read FLEF_PERCENTUALPIS write FLEF_PERCENTUALPIS;
    const LEF_PERCENTUALPIS_Name = 'LEF_PERCENTUALPIS';

    [Restrictions([NoValidate])]
    [Column('LEF_PERCENTUALCOFINS', ftBCD)]
    [Dictionary('LEF_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALCOFINS: Double read FLEF_PERCENTUALCOFINS write FLEF_PERCENTUALCOFINS;
    const LEF_PERCENTUALCOFINS_Name = 'LEF_PERCENTUALCOFINS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_NFE)

end.
