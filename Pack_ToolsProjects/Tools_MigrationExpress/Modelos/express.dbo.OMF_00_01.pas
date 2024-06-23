unit express.dbo.OMF_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.omf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('OMF_00_01', '')]
  [PrimaryKey('OMF_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_01_ID')]
  TDtoOMF_00_01 = class
  private
    { Private declarations } 
    FOMF_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_ID: Integer;
    FDEV_ID: Integer;
    FDEV_01_ID: Integer;
    FDEV_NOTAFISCAL: String;
    FPRO_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FNCM_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FCLF_CODIGO: String;
    FLEF_CODIGO: Integer;
    FGRD_CODIGO: String;
    FCSTPC_CODIGO: String;
    FOMF_ORDEMITEM: Integer;
    FOMF_QTDFATURADA: Double;
    FOMF_QTDDEVOLVIDA: Double;
    FOMF_ITEMALTERADO: String;
    FOMF_VALORITEM: Double;
    FOMF_VALORIPIITEM: Double;
    FOMF_VALORPISITEM: Double;
    FOMF_VALORICMSITEM: Double;
    FOMF_VALORVERBAITEM: Double;
    FOMF_VALORCOFINSITEM: Double;
    FOMF_VALORSEGUROITEM: Double;
    FOMF_VALORSERVICOITEM: Double;
    FOMF_VALORDESCTOITEM: Double;
    FOMF_VALORICMSRNFITEM: Double;
    FOMF_VALORFRETENFITEM: Double;
    FOMF_VALORFRETERPAITEM: Double;
    FOMF_VALORICMSRDUAITEM: Double;
    FOMF_VALORADICIONALITEM: Double;
    FOMF_VALORFRETECTRITEM: Double;
    FOMF_VALORICMSSIMPLESITEM: Double;
    FOMF_VALORBONIFICACAOITEM: Double;
    FOMF_VALORBASEOUTROSITEM: Double;
    FOMF_VALORICMSFRETENFITEM: Double;
    FOMF_VALORICMSFRETECTRITEM: Double;
    FOMF_VALORICMSACESSORIAITEM: Double;
    FOMF_VALORDESPACESSORIAITEM: Double;
    FOMF_VALORSUBSTRIBUTARIAITEM: Double;
    FOMF_VALORBASEISENTOICMSITEM: Double;
    FOMF_VALORBASECALCULOMVAITEM: Double;
    FOMF_VALORBASECALCULOICMSITEM: Double;
    FOMF_VALORCOMPLEMENTONFICMSITEM: Double;
    FOMF_PERCENTUALIPIITEM: Double;
    FOMF_PERCENTUALPISITEM: Double;
    FOMF_PERCENTUALMVAITEM: Double;
    FOMF_PERCENTUALICMSITEM: Double;
    FOMF_PERCENTUALCOFINSITEM: Double;
    FOMF_PERCENTUALVERBAITEM: Double;
    FOMF_PERCENTUALDESCTOITEM: Double;
    FOMF_PERCENTUALICMSRNFITEM: Double;
    FOMF_PERCENTUALSERVICOITEM: Double;
    FOMF_PERCENTUALSEGUROITEM: Double;
    FOMF_PERCENTUALFRETENFITEM: Double;
    FOMF_PERCBCICMSFRETECTRITEM: Double;
    FOMF_PERCENTUALICMSRDUAITEM: Double;
    FOMF_PERCENTUALFRETECTRITEM: Double;
    FOMF_PERCENTUALFRETERPAITEM: Double;
    FOMF_PERCENTUALICMSSAIDAITEM: Double;
    FOMF_PERCENTUALREDUCAOBCITEM: Double;
    FOMF_PERCENTUALICMSSIMPLESITEM: Double;
    FOMF_PERCENTUALICMSDESTINOITEM: Double;
    FOMF_PERCENTUALBONIFICACAOITEM: Double;
    FOMF_PERCENTUALICMSFRETENFITEM: Double;
    FOMF_PERCENTUALICMSFRETECTRITEM: Double;
    FOMF_PERCENTUALDESPACESSORIAITEM: Double;
    FOMF_PERCENTUALICMSACESSORIAITEM: Double;
    FOMF_VALORCUSTOCOMPRAOMF: Double;
    FOMF_VALORCUSTOLIQUIDOOMF: Double;
    FOMF_VALORCUSTOINVENTARIOOMF: Double;
    FOMF_VALORCUSTOCOMPRAMEDIO: Double;
    FOMF_VALORCUSTOLIQUIDOMEDIO: Double;
    FOMF_VALORCUSTOINVENTARIOMEDIO: Double;
    FOMF_VALORBCICMSFRETECTRITEM: Double;
    FOMF_VALORBCICMSFRETENFITEM: Double;
    FOMF_VALORBCALCULOPISCOFINSITEM: Double;
    FOMF_ULTIMOCUSTOCOMPRA: Double;
    FOMF_ULTIMOCUSTOLIQUIDO: Double;
    FOMF_ULTIMOCUSTOINVENTARIO: Double;
    FOMF_ULTIMOCUSTOCOMPRAMEDIO: Double;
    FOMF_ULTIMOCUSTOLIQUIDOMEDIO: Double;
    FOMF_ULTIMOCUSTOINVENTARIOMEDIO: Double;
    FOMF_PRECOZEROMKP: Double;
    FOMF_PRECOVENDAMKP: Double;
    FOMF_PRECOSUGERIDOMKP: Double;
    FOMF_PERCENTUALLUCROVENDAMKP: Double;
    FOMF_PERCENTUALLUCROSUGERIDOMKP: Double;
    FOMF_PERCENTUALDESPESASLUCROMKP: Double;
    FOMF_PERCENTUALMARKUPLUCRO: Double;
    FOMF_PERCENTUALMARKUPZERO: Double;
    FOMF_PERCENTUALICMSMARKUP: Double;
    FOMF_TOTALITEM: Double;
    FOMF_TOTALIPIITEM: Double;
    FOMF_TOTALPISITEM: Double;
    FOMF_TOTALICMSITEM: Double;
    FOMF_TOTALVERBAITEM: Double;
    FOMF_TOTALCOFINSITEM: Double;
    FOMF_TOTALSEGUROITEM: Double;
    FOMF_TOTALSERVICOITEM: Double;
    FOMF_TOTALDESCTOITEM: Double;
    FOMF_TOTALICMSRNFITEM: Double;
    FOMF_TOTALFRETENFITEM: Double;
    FOMF_TOTALFRETERPAITEM: Double;
    FOMF_TOTALICMSRDUAITEM: Double;
    FOMF_TOTALADICIONALITEM: Double;
    FOMF_TOTALFRETECTRITEM: Double;
    FOMF_TOTALICMSSIMPLESITEM: Double;
    FOMF_TOTALBONIFICACAOITEM: Double;
    FOMF_TOTALBASEOUTROSITEM: Double;
    FOMF_TOTALICMSFRETENFITEM: Double;
    FOMF_TOTALICMSFRETECTRITEM: Double;
    FOMF_TOTALICMSACESSORIAITEM: Double;
    FOMF_TOTALDESPACESSORIAITEM: Double;
    FOMF_TOTALSUBSTRIBUTARIAITEM: Double;
    FOMF_TOTALBASEISENTOICMSITEM: Double;
    FOMF_TOTALBASECALCULOMVAITEM: Double;
    FOMF_TOTALBASECALCULOICMSITEM: Double;
    FOMF_TOTALCOMPLEMENTONFICMSITEM: Double;
    FOMF_TOTALBCICMSFRETECTRITEM: Double;
    FOMF_TOTALBCALCULOPISCOFINSITEM: Double;
    FOMF_TOTALBCICMSFRETENFITEM: Double;
    FOMF_RATEADO: String;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: String;
    FOMF_NUMEROVOLUMES: Double;
    FOMF_PESOBRUTOITEM: Double;
    FOMF_PESOLIQUIDOITEM: Double;
    FOMF_01_ID_OLD: Integer;
    FOMF_ID_OLD: Integer;
    FDEV_ID_OLD: Integer;
    FDEV_01_ID_OLD: Integer;
    FOMF_TIPODOCTO: String;
    FOMF_PERCENTUALCOMISSAOITEM: Double;
    FOMF_VALORBASECALCULOPISCOFINSITEM: Double;
    FOMF_VALORBASEDESCTOCOMISSAOITEM: Double;
    FOMF_VALORCOMISSAOITEM: Double;
    FOMF_TOTALCOMISSAOITEM: Double;
    FOMF_TOTALBASECALCULOPISCOFINSITEM: Double;
    FOMF_PERCENTUALIBPTITEM: Double;
    FOMF_PERCENTUALIBPTMUNICIPALITEM: Double;
    FOMF_PERCENTUALIBPTESTADUALITEM: Double;
    FOMF_PERCENTUALIBPTNACIONALITEM: Double;
    FOMF_PERCENTUALIBPTIMPORTADOITEM: Double;
    FOMF_TOTALIBPTMUNICIPALITEM: Double;
    FOMF_TOTALIBPTESTADUALITEM: Double;
    FOMF_TOTALIBPTNACIONALITEM: Double;
    FOMF_TOTALIBPTIMPORTADOITEM: Double;
    FOMF_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FOMF_PERCENTUALFCPITEM: Double;
    FOMF_TOTALBASECALCULOFCPITEM: Double;
    FOMF_TOTALFCPITEM: Double;
    FOMF_TOTALBASECALCULOFCPSTITEM: Double;
    FOMF_TOTALFCPSTITEM: Double;
    FOMF_TOTALBASECALCULOFCPRETITEM: Double;
    FOMF_TOTALFCPRETITEM: Double;
  public
    { Public declarations }
    const Table      = 'OMF_00_01';
    const PrimaryKey = 'OMF_01_ID';
    const Sequence   = 'SEQ_OMF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_01_ID', ftInteger)]
    [Dictionary('OMF_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_01_ID: Integer read FOMF_01_ID write FOMF_01_ID;
    const OMF_01_ID_Name = 'OMF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_01_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate])]
    [Column('DEV_ID', ftInteger)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;
    const DEV_ID_Name = 'DEV_ID';

    [Restrictions([NoValidate])]
    [Column('DEV_01_ID', ftInteger)]
    [Dictionary('DEV_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_01_ID: Integer read FDEV_01_ID write FDEV_01_ID;
    const DEV_01_ID_Name = 'DEV_01_ID';

    [Restrictions([NoValidate])]
    [Column('DEV_NOTAFISCAL', ftString, 9)]
    [Dictionary('DEV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NOTAFISCAL: String read FDEV_NOTAFISCAL write FDEV_NOTAFISCAL;
    const DEV_NOTAFISCAL_Name = 'DEV_NOTAFISCAL';

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

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_ORDEMITEM', ftInteger)]
    [Dictionary('OMF_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ORDEMITEM: Integer read FOMF_ORDEMITEM write FOMF_ORDEMITEM;
    const OMF_ORDEMITEM_Name = 'OMF_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('OMF_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_QTDFATURADA: Double read FOMF_QTDFATURADA write FOMF_QTDFATURADA;
    const OMF_QTDFATURADA_Name = 'OMF_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('OMF_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('OMF_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_QTDDEVOLVIDA: Double read FOMF_QTDDEVOLVIDA write FOMF_QTDDEVOLVIDA;
    const OMF_QTDDEVOLVIDA_Name = 'OMF_QTDDEVOLVIDA';

    [Restrictions([NoValidate])]
    [Column('OMF_ITEMALTERADO', ftString, 1)]
    [Dictionary('OMF_ITEMALTERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_ITEMALTERADO: String read FOMF_ITEMALTERADO write FOMF_ITEMALTERADO;
    const OMF_ITEMALTERADO_Name = 'OMF_ITEMALTERADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORITEM', ftBCD)]
    [Dictionary('OMF_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORITEM: Double read FOMF_VALORITEM write FOMF_VALORITEM;
    const OMF_VALORITEM_Name = 'OMF_VALORITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORIPIITEM', ftBCD, 16387, 5)]
    [Dictionary('OMF_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORIPIITEM: Double read FOMF_VALORIPIITEM write FOMF_VALORIPIITEM;
    const OMF_VALORIPIITEM_Name = 'OMF_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORPISITEM', ftBCD)]
    [Dictionary('OMF_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORPISITEM: Double read FOMF_VALORPISITEM write FOMF_VALORPISITEM;
    const OMF_VALORPISITEM_Name = 'OMF_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORICMSITEM', ftBCD)]
    [Dictionary('OMF_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSITEM: Double read FOMF_VALORICMSITEM write FOMF_VALORICMSITEM;
    const OMF_VALORICMSITEM_Name = 'OMF_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORVERBAITEM', ftBCD)]
    [Dictionary('OMF_VALORVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORVERBAITEM: Double read FOMF_VALORVERBAITEM write FOMF_VALORVERBAITEM;
    const OMF_VALORVERBAITEM_Name = 'OMF_VALORVERBAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCOFINSITEM', ftBCD, 16387, 5)]
    [Dictionary('OMF_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCOFINSITEM: Double read FOMF_VALORCOFINSITEM write FOMF_VALORCOFINSITEM;
    const OMF_VALORCOFINSITEM_Name = 'OMF_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORSEGUROITEM', ftBCD)]
    [Dictionary('OMF_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORSEGUROITEM: Double read FOMF_VALORSEGUROITEM write FOMF_VALORSEGUROITEM;
    const OMF_VALORSEGUROITEM_Name = 'OMF_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORSERVICOITEM', ftBCD, 5636178, 5)]
    [Dictionary('OMF_VALORSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORSERVICOITEM: Double read FOMF_VALORSERVICOITEM write FOMF_VALORSERVICOITEM;
    const OMF_VALORSERVICOITEM_Name = 'OMF_VALORSERVICOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORDESCTOITEM', ftBCD, 53, 5)]
    [Dictionary('OMF_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORDESCTOITEM: Double read FOMF_VALORDESCTOITEM write FOMF_VALORDESCTOITEM;
    const OMF_VALORDESCTOITEM_Name = 'OMF_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORICMSRNFITEM', ftBCD, 5177428, 5)]
    [Dictionary('OMF_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSRNFITEM: Double read FOMF_VALORICMSRNFITEM write FOMF_VALORICMSRNFITEM;
    const OMF_VALORICMSRNFITEM_Name = 'OMF_VALORICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORFRETENFITEM', ftBCD, 4456531, 5)]
    [Dictionary('OMF_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORFRETENFITEM: Double read FOMF_VALORFRETENFITEM write FOMF_VALORFRETENFITEM;
    const OMF_VALORFRETENFITEM_Name = 'OMF_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORFRETERPAITEM', ftBCD, 4587552, 5)]
    [Dictionary('OMF_VALORFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORFRETERPAITEM: Double read FOMF_VALORFRETERPAITEM write FOMF_VALORFRETERPAITEM;
    const OMF_VALORFRETERPAITEM_Name = 'OMF_VALORFRETERPAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORICMSRDUAITEM', ftBCD, 52, 5)]
    [Dictionary('OMF_VALORICMSRDUAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSRDUAITEM: Double read FOMF_VALORICMSRDUAITEM write FOMF_VALORICMSRDUAITEM;
    const OMF_VALORICMSRDUAITEM_Name = 'OMF_VALORICMSRDUAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORADICIONALITEM', ftBCD, 7274723, 5)]
    [Dictionary('OMF_VALORADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORADICIONALITEM: Double read FOMF_VALORADICIONALITEM write FOMF_VALORADICIONALITEM;
    const OMF_VALORADICIONALITEM_Name = 'OMF_VALORADICIONALITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORFRETECTRITEM', ftBCD, 4522064, 5)]
    [Dictionary('OMF_VALORFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORFRETECTRITEM: Double read FOMF_VALORFRETECTRITEM write FOMF_VALORFRETECTRITEM;
    const OMF_VALORFRETECTRITEM_Name = 'OMF_VALORFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORICMSSIMPLESITEM', ftBCD, 5374017, 5)]
    [Dictionary('OMF_VALORICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSSIMPLESITEM: Double read FOMF_VALORICMSSIMPLESITEM write FOMF_VALORICMSSIMPLESITEM;
    const OMF_VALORICMSSIMPLESITEM_Name = 'OMF_VALORICMSSIMPLESITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBONIFICACAOITEM', ftBCD, 5111903, 5)]
    [Dictionary('OMF_VALORBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBONIFICACAOITEM: Double read FOMF_VALORBONIFICACAOITEM write FOMF_VALORBONIFICACAOITEM;
    const OMF_VALORBONIFICACAOITEM_Name = 'OMF_VALORBONIFICACAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBASEOUTROSITEM', ftBCD, 5374017, 5)]
    [Dictionary('OMF_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASEOUTROSITEM: Double read FOMF_VALORBASEOUTROSITEM write FOMF_VALORBASEOUTROSITEM;
    const OMF_VALORBASEOUTROSITEM_Name = 'OMF_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORICMSFRETENFITEM', ftBCD, 4522067, 5)]
    [Dictionary('OMF_VALORICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSFRETENFITEM: Double read FOMF_VALORICMSFRETENFITEM write FOMF_VALORICMSFRETENFITEM;
    const OMF_VALORICMSFRETENFITEM_Name = 'OMF_VALORICMSFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORICMSFRETECTRITEM', ftBCD, 6881394, 5)]
    [Dictionary('OMF_VALORICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSFRETECTRITEM: Double read FOMF_VALORICMSFRETECTRITEM write FOMF_VALORICMSFRETECTRITEM;
    const OMF_VALORICMSFRETECTRITEM_Name = 'OMF_VALORICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORICMSACESSORIAITEM', ftBCD, 2097184, 5)]
    [Dictionary('OMF_VALORICMSACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORICMSACESSORIAITEM: Double read FOMF_VALORICMSACESSORIAITEM write FOMF_VALORICMSACESSORIAITEM;
    const OMF_VALORICMSACESSORIAITEM_Name = 'OMF_VALORICMSACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORDESPACESSORIAITEM', ftBCD, 5177428, 5)]
    [Dictionary('OMF_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORDESPACESSORIAITEM: Double read FOMF_VALORDESPACESSORIAITEM write FOMF_VALORDESPACESSORIAITEM;
    const OMF_VALORDESPACESSORIAITEM_Name = 'OMF_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORSUBSTRIBUTARIAITEM', ftBCD, 2097196, 5)]
    [Dictionary('OMF_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORSUBSTRIBUTARIAITEM: Double read FOMF_VALORSUBSTRIBUTARIAITEM write FOMF_VALORSUBSTRIBUTARIAITEM;
    const OMF_VALORSUBSTRIBUTARIAITEM_Name = 'OMF_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBASEISENTOICMSITEM', ftBCD, 2097273, 5)]
    [Dictionary('OMF_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASEISENTOICMSITEM: Double read FOMF_VALORBASEISENTOICMSITEM write FOMF_VALORBASEISENTOICMSITEM;
    const OMF_VALORBASEISENTOICMSITEM_Name = 'OMF_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBASECALCULOMVAITEM', ftBCD, 7077999, 5)]
    [Dictionary('OMF_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASECALCULOMVAITEM: Double read FOMF_VALORBASECALCULOMVAITEM write FOMF_VALORBASECALCULOMVAITEM;
    const OMF_VALORBASECALCULOMVAITEM_Name = 'OMF_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORBASECALCULOICMSITEM', ftBCD, 7274610, 5)]
    [Dictionary('OMF_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASECALCULOICMSITEM: Double read FOMF_VALORBASECALCULOICMSITEM write FOMF_VALORBASECALCULOICMSITEM;
    const OMF_VALORBASECALCULOICMSITEM_Name = 'OMF_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCOMPLEMENTONFICMSITEM', ftBCD, 4784197, 5)]
    [Dictionary('OMF_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCOMPLEMENTONFICMSITEM: Double read FOMF_VALORCOMPLEMENTONFICMSITEM write FOMF_VALORCOMPLEMENTONFICMSITEM;
    const OMF_VALORCOMPLEMENTONFICMSITEM_Name = 'OMF_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALIPIITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIPIITEM: Double read FOMF_PERCENTUALIPIITEM write FOMF_PERCENTUALIPIITEM;
    const OMF_PERCENTUALIPIITEM_Name = 'OMF_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALPISITEM: Double read FOMF_PERCENTUALPISITEM write FOMF_PERCENTUALPISITEM;
    const OMF_PERCENTUALPISITEM_Name = 'OMF_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALMVAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALMVAITEM: Double read FOMF_PERCENTUALMVAITEM write FOMF_PERCENTUALMVAITEM;
    const OMF_PERCENTUALMVAITEM_Name = 'OMF_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSITEM: Double read FOMF_PERCENTUALICMSITEM write FOMF_PERCENTUALICMSITEM;
    const OMF_PERCENTUALICMSITEM_Name = 'OMF_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALCOFINSITEM: Double read FOMF_PERCENTUALCOFINSITEM write FOMF_PERCENTUALCOFINSITEM;
    const OMF_PERCENTUALCOFINSITEM_Name = 'OMF_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALVERBAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALVERBAITEM: Double read FOMF_PERCENTUALVERBAITEM write FOMF_PERCENTUALVERBAITEM;
    const OMF_PERCENTUALVERBAITEM_Name = 'OMF_PERCENTUALVERBAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALDESCTOITEM: Double read FOMF_PERCENTUALDESCTOITEM write FOMF_PERCENTUALDESCTOITEM;
    const OMF_PERCENTUALDESCTOITEM_Name = 'OMF_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSRNFITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSRNFITEM: Double read FOMF_PERCENTUALICMSRNFITEM write FOMF_PERCENTUALICMSRNFITEM;
    const OMF_PERCENTUALICMSRNFITEM_Name = 'OMF_PERCENTUALICMSRNFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALSERVICOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALSERVICOITEM: Double read FOMF_PERCENTUALSERVICOITEM write FOMF_PERCENTUALSERVICOITEM;
    const OMF_PERCENTUALSERVICOITEM_Name = 'OMF_PERCENTUALSERVICOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALSEGUROITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALSEGUROITEM: Double read FOMF_PERCENTUALSEGUROITEM write FOMF_PERCENTUALSEGUROITEM;
    const OMF_PERCENTUALSEGUROITEM_Name = 'OMF_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALFRETENFITEM: Double read FOMF_PERCENTUALFRETENFITEM write FOMF_PERCENTUALFRETENFITEM;
    const OMF_PERCENTUALFRETENFITEM_Name = 'OMF_PERCENTUALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCBCICMSFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCBCICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCBCICMSFRETECTRITEM: Double read FOMF_PERCBCICMSFRETECTRITEM write FOMF_PERCBCICMSFRETECTRITEM;
    const OMF_PERCBCICMSFRETECTRITEM_Name = 'OMF_PERCBCICMSFRETECTRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSRDUAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSRDUAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSRDUAITEM: Double read FOMF_PERCENTUALICMSRDUAITEM write FOMF_PERCENTUALICMSRDUAITEM;
    const OMF_PERCENTUALICMSRDUAITEM_Name = 'OMF_PERCENTUALICMSRDUAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALFRETECTRITEM: Double read FOMF_PERCENTUALFRETECTRITEM write FOMF_PERCENTUALFRETECTRITEM;
    const OMF_PERCENTUALFRETECTRITEM_Name = 'OMF_PERCENTUALFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALFRETERPAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALFRETERPAITEM: Double read FOMF_PERCENTUALFRETERPAITEM write FOMF_PERCENTUALFRETERPAITEM;
    const OMF_PERCENTUALFRETERPAITEM_Name = 'OMF_PERCENTUALFRETERPAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSSAIDAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSSAIDAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSSAIDAITEM: Double read FOMF_PERCENTUALICMSSAIDAITEM write FOMF_PERCENTUALICMSSAIDAITEM;
    const OMF_PERCENTUALICMSSAIDAITEM_Name = 'OMF_PERCENTUALICMSSAIDAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALREDUCAOBCITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALREDUCAOBCITEM: Double read FOMF_PERCENTUALREDUCAOBCITEM write FOMF_PERCENTUALREDUCAOBCITEM;
    const OMF_PERCENTUALREDUCAOBCITEM_Name = 'OMF_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSSIMPLESITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSSIMPLESITEM: Double read FOMF_PERCENTUALICMSSIMPLESITEM write FOMF_PERCENTUALICMSSIMPLESITEM;
    const OMF_PERCENTUALICMSSIMPLESITEM_Name = 'OMF_PERCENTUALICMSSIMPLESITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSDESTINOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSDESTINOITEM: Double read FOMF_PERCENTUALICMSDESTINOITEM write FOMF_PERCENTUALICMSDESTINOITEM;
    const OMF_PERCENTUALICMSDESTINOITEM_Name = 'OMF_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALBONIFICACAOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALBONIFICACAOITEM: Double read FOMF_PERCENTUALBONIFICACAOITEM write FOMF_PERCENTUALBONIFICACAOITEM;
    const OMF_PERCENTUALBONIFICACAOITEM_Name = 'OMF_PERCENTUALBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSFRETENFITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSFRETENFITEM: Double read FOMF_PERCENTUALICMSFRETENFITEM write FOMF_PERCENTUALICMSFRETENFITEM;
    const OMF_PERCENTUALICMSFRETENFITEM_Name = 'OMF_PERCENTUALICMSFRETENFITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALICMSFRETECTRITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSFRETECTRITEM: Double read FOMF_PERCENTUALICMSFRETECTRITEM write FOMF_PERCENTUALICMSFRETECTRITEM;
    const OMF_PERCENTUALICMSFRETECTRITEM_Name = 'OMF_PERCENTUALICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALDESPACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALDESPACESSORIAITEM: Double read FOMF_PERCENTUALDESPACESSORIAITEM write FOMF_PERCENTUALDESPACESSORIAITEM;
    const OMF_PERCENTUALDESPACESSORIAITEM_Name = 'OMF_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSACESSORIAITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSACESSORIAITEM: Double read FOMF_PERCENTUALICMSACESSORIAITEM write FOMF_PERCENTUALICMSACESSORIAITEM;
    const OMF_PERCENTUALICMSACESSORIAITEM_Name = 'OMF_PERCENTUALICMSACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCUSTOCOMPRAOMF', ftBCD)]
    [Dictionary('OMF_VALORCUSTOCOMPRAOMF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCUSTOCOMPRAOMF: Double read FOMF_VALORCUSTOCOMPRAOMF write FOMF_VALORCUSTOCOMPRAOMF;
    const OMF_VALORCUSTOCOMPRAOMF_Name = 'OMF_VALORCUSTOCOMPRAOMF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCUSTOLIQUIDOOMF', ftBCD, 1818439271, 5)]
    [Dictionary('OMF_VALORCUSTOLIQUIDOOMF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCUSTOLIQUIDOOMF: Double read FOMF_VALORCUSTOLIQUIDOOMF write FOMF_VALORCUSTOLIQUIDOOMF;
    const OMF_VALORCUSTOLIQUIDOOMF_Name = 'OMF_VALORCUSTOLIQUIDOOMF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCUSTOINVENTARIOOMF', ftBCD, 1936617321, 5)]
    [Dictionary('OMF_VALORCUSTOINVENTARIOOMF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCUSTOINVENTARIOOMF: Double read FOMF_VALORCUSTOINVENTARIOOMF write FOMF_VALORCUSTOINVENTARIOOMF;
    const OMF_VALORCUSTOINVENTARIOOMF_Name = 'OMF_VALORCUSTOINVENTARIOOMF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCUSTOCOMPRAMEDIO', ftBCD, 538970637, 5)]
    [Dictionary('OMF_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCUSTOCOMPRAMEDIO: Double read FOMF_VALORCUSTOCOMPRAMEDIO write FOMF_VALORCUSTOCOMPRAMEDIO;
    const OMF_VALORCUSTOCOMPRAMEDIO_Name = 'OMF_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCUSTOLIQUIDOMEDIO', ftBCD, 1179206738, 5)]
    [Dictionary('OMF_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCUSTOLIQUIDOMEDIO: Double read FOMF_VALORCUSTOLIQUIDOMEDIO write FOMF_VALORCUSTOLIQUIDOMEDIO;
    const OMF_VALORCUSTOLIQUIDOMEDIO_Name = 'OMF_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORCUSTOINVENTARIOMEDIO', ftBCD, 221996910, 5)]
    [Dictionary('OMF_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCUSTOINVENTARIOMEDIO: Double read FOMF_VALORCUSTOINVENTARIOMEDIO write FOMF_VALORCUSTOINVENTARIOMEDIO;
    const OMF_VALORCUSTOINVENTARIOMEDIO_Name = 'OMF_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBCICMSFRETECTRITEM', ftBCD, 1818453348, 5)]
    [Dictionary('OMF_VALORBCICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBCICMSFRETECTRITEM: Double read FOMF_VALORBCICMSFRETECTRITEM write FOMF_VALORBCICMSFRETECTRITEM;
    const OMF_VALORBCICMSFRETECTRITEM_Name = 'OMF_VALORBCICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBCICMSFRETENFITEM', ftBCD, 1953391939, 5)]
    [Dictionary('OMF_VALORBCICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBCICMSFRETENFITEM: Double read FOMF_VALORBCICMSFRETENFITEM write FOMF_VALORBCICMSFRETENFITEM;
    const OMF_VALORBCICMSFRETENFITEM_Name = 'OMF_VALORBCICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBCALCULOPISCOFINSITEM', ftBCD, 538970637, 5)]
    [Dictionary('OMF_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBCALCULOPISCOFINSITEM: Double read FOMF_VALORBCALCULOPISCOFINSITEM write FOMF_VALORBCALCULOPISCOFINSITEM;
    const OMF_VALORBCALCULOPISCOFINSITEM_Name = 'OMF_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_ULTIMOCUSTOCOMPRA', ftBCD, 1281455136, 5)]
    [Dictionary('OMF_ULTIMOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_ULTIMOCUSTOCOMPRA: Double read FOMF_ULTIMOCUSTOCOMPRA write FOMF_ULTIMOCUSTOCOMPRA;
    const OMF_ULTIMOCUSTOCOMPRA_Name = 'OMF_ULTIMOCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('OMF_ULTIMOCUSTOLIQUIDO', ftBCD, 1981834596, 5)]
    [Dictionary('OMF_ULTIMOCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_ULTIMOCUSTOLIQUIDO: Double read FOMF_ULTIMOCUSTOLIQUIDO write FOMF_ULTIMOCUSTOLIQUIDO;
    const OMF_ULTIMOCUSTOLIQUIDO_Name = 'OMF_ULTIMOCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('OMF_ULTIMOCUSTOINVENTARIO', ftBCD, 539780974, 5)]
    [Dictionary('OMF_ULTIMOCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_ULTIMOCUSTOINVENTARIO: Double read FOMF_ULTIMOCUSTOINVENTARIO write FOMF_ULTIMOCUSTOINVENTARIO;
    const OMF_ULTIMOCUSTOINVENTARIO_Name = 'OMF_ULTIMOCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('OMF_ULTIMOCUSTOCOMPRAMEDIO', ftBCD, 1162891087, 5)]
    [Dictionary('OMF_ULTIMOCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_ULTIMOCUSTOCOMPRAMEDIO: Double read FOMF_ULTIMOCUSTOCOMPRAMEDIO write FOMF_ULTIMOCUSTOCOMPRAMEDIO;
    const OMF_ULTIMOCUSTOCOMPRAMEDIO_Name = 'OMF_ULTIMOCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('OMF_ULTIMOCUSTOLIQUIDOMEDIO', ftBCD, 1529377646, 5)]
    [Dictionary('OMF_ULTIMOCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_ULTIMOCUSTOLIQUIDOMEDIO: Double read FOMF_ULTIMOCUSTOLIQUIDOMEDIO write FOMF_ULTIMOCUSTOLIQUIDOMEDIO;
    const OMF_ULTIMOCUSTOLIQUIDOMEDIO_Name = 'OMF_ULTIMOCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('OMF_ULTIMOCUSTOINVENTARIOMEDIO', ftBCD, 1146045279, 5)]
    [Dictionary('OMF_ULTIMOCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_ULTIMOCUSTOINVENTARIOMEDIO: Double read FOMF_ULTIMOCUSTOINVENTARIOMEDIO write FOMF_ULTIMOCUSTOINVENTARIOMEDIO;
    const OMF_ULTIMOCUSTOINVENTARIOMEDIO_Name = 'OMF_ULTIMOCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('OMF_PRECOZEROMKP', ftBCD, 1195983951, 5)]
    [Dictionary('OMF_PRECOZEROMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PRECOZEROMKP: Double read FOMF_PRECOZEROMKP write FOMF_PRECOZEROMKP;
    const OMF_PRECOZEROMKP_Name = 'OMF_PRECOZEROMKP';

    [Restrictions([NoValidate])]
    [Column('OMF_PRECOVENDAMKP', ftBCD, 1145132617, 5)]
    [Dictionary('OMF_PRECOVENDAMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PRECOVENDAMKP: Double read FOMF_PRECOVENDAMKP write FOMF_PRECOVENDAMKP;
    const OMF_PRECOVENDAMKP_Name = 'OMF_PRECOVENDAMKP';

    [Restrictions([NoValidate])]
    [Column('OMF_PRECOSUGERIDOMKP', ftBCD, 1952531540, 5)]
    [Dictionary('OMF_PRECOSUGERIDOMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PRECOSUGERIDOMKP: Double read FOMF_PRECOSUGERIDOMKP write FOMF_PRECOSUGERIDOMKP;
    const OMF_PRECOSUGERIDOMKP_Name = 'OMF_PRECOSUGERIDOMKP';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALLUCROVENDAMKP', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALLUCROVENDAMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALLUCROVENDAMKP: Double read FOMF_PERCENTUALLUCROVENDAMKP write FOMF_PERCENTUALLUCROVENDAMKP;
    const OMF_PERCENTUALLUCROVENDAMKP_Name = 'OMF_PERCENTUALLUCROVENDAMKP';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALLUCROSUGERIDOMKP', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALLUCROSUGERIDOMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALLUCROSUGERIDOMKP: Double read FOMF_PERCENTUALLUCROSUGERIDOMKP write FOMF_PERCENTUALLUCROSUGERIDOMKP;
    const OMF_PERCENTUALLUCROSUGERIDOMKP_Name = 'OMF_PERCENTUALLUCROSUGERIDOMKP';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALDESPESASLUCROMKP', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALDESPESASLUCROMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALDESPESASLUCROMKP: Double read FOMF_PERCENTUALDESPESASLUCROMKP write FOMF_PERCENTUALDESPESASLUCROMKP;
    const OMF_PERCENTUALDESPESASLUCROMKP_Name = 'OMF_PERCENTUALDESPESASLUCROMKP';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALMARKUPLUCRO', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALMARKUPLUCRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALMARKUPLUCRO: Double read FOMF_PERCENTUALMARKUPLUCRO write FOMF_PERCENTUALMARKUPLUCRO;
    const OMF_PERCENTUALMARKUPLUCRO_Name = 'OMF_PERCENTUALMARKUPLUCRO';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALMARKUPZERO', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALMARKUPZERO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALMARKUPZERO: Double read FOMF_PERCENTUALMARKUPZERO write FOMF_PERCENTUALMARKUPZERO;
    const OMF_PERCENTUALMARKUPZERO_Name = 'OMF_PERCENTUALMARKUPZERO';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSMARKUP', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALICMSMARKUP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSMARKUP: Double read FOMF_PERCENTUALICMSMARKUP write FOMF_PERCENTUALICMSMARKUP;
    const OMF_PERCENTUALICMSMARKUP_Name = 'OMF_PERCENTUALICMSMARKUP';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALITEM', ftBCD, 1869770784, 2)]
    [Dictionary('OMF_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALITEM: Double read FOMF_TOTALITEM write FOMF_TOTALITEM;
    const OMF_TOTALITEM_Name = 'OMF_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIPIITEM', ftBCD, 1952867660, 2)]
    [Dictionary('OMF_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIPIITEM: Double read FOMF_TOTALIPIITEM write FOMF_TOTALIPIITEM;
    const OMF_TOTALIPIITEM_Name = 'OMF_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALPISITEM', ftBCD, 740770885, 2)]
    [Dictionary('OMF_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPISITEM: Double read FOMF_TOTALPISITEM write FOMF_TOTALPISITEM;
    const OMF_TOTALPISITEM_Name = 'OMF_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSITEM', ftBCD, 539780974, 2)]
    [Dictionary('OMF_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSITEM: Double read FOMF_TOTALICMSITEM write FOMF_TOTALICMSITEM;
    const OMF_TOTALICMSITEM_Name = 'OMF_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALVERBAITEM', ftBCD, 537529610, 2)]
    [Dictionary('OMF_TOTALVERBAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALVERBAITEM: Double read FOMF_TOTALVERBAITEM write FOMF_TOTALVERBAITEM;
    const OMF_TOTALVERBAITEM_Name = 'OMF_TOTALVERBAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALCOFINSITEM', ftBCD, 1414407968, 2)]
    [Dictionary('OMF_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOFINSITEM: Double read FOMF_TOTALCOFINSITEM write FOMF_TOTALCOFINSITEM;
    const OMF_TOTALCOFINSITEM_Name = 'OMF_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALSEGUROITEM', ftBCD, 1998605377, 2)]
    [Dictionary('OMF_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSEGUROITEM: Double read FOMF_TOTALSEGUROITEM write FOMF_TOTALSEGUROITEM;
    const OMF_TOTALSEGUROITEM_Name = 'OMF_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALSERVICOITEM', ftBCD, 1598243924, 2)]
    [Dictionary('OMF_TOTALSERVICOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSERVICOITEM: Double read FOMF_TOTALSERVICOITEM write FOMF_TOTALSERVICOITEM;
    const OMF_TOTALSERVICOITEM_Name = 'OMF_TOTALSERVICOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALDESCTOITEM', ftBCD, 1919250543, 2)]
    [Dictionary('OMF_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESCTOITEM: Double read FOMF_TOTALDESCTOITEM write FOMF_TOTALDESCTOITEM;
    const OMF_TOTALDESCTOITEM_Name = 'OMF_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSRNFITEM', ftBCD, 659308878, 2)]
    [Dictionary('OMF_TOTALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSRNFITEM: Double read FOMF_TOTALICMSRNFITEM write FOMF_TOTALICMSRNFITEM;
    const OMF_TOTALICMSRNFITEM_Name = 'OMF_TOTALICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFRETENFITEM', ftBCD, 1329815375, 2)]
    [Dictionary('OMF_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETENFITEM: Double read FOMF_TOTALFRETENFITEM write FOMF_TOTALFRETENFITEM;
    const OMF_TOTALFRETENFITEM_Name = 'OMF_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFRETERPAITEM', ftBCD, 1229213507, 2)]
    [Dictionary('OMF_TOTALFRETERPAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETERPAITEM: Double read FOMF_TOTALFRETERPAITEM write FOMF_TOTALFRETERPAITEM;
    const OMF_TOTALFRETERPAITEM_Name = 'OMF_TOTALFRETERPAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSRDUAITEM', ftBCD, 543449445, 2)]
    [Dictionary('OMF_TOTALICMSRDUAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSRDUAITEM: Double read FOMF_TOTALICMSRDUAITEM write FOMF_TOTALICMSRDUAITEM;
    const OMF_TOTALICMSRDUAITEM_Name = 'OMF_TOTALICMSRDUAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALADICIONALITEM', ftBCD, 2036754804, 2)]
    [Dictionary('OMF_TOTALADICIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALADICIONALITEM: Double read FOMF_TOTALADICIONALITEM write FOMF_TOTALADICIONALITEM;
    const OMF_TOTALADICIONALITEM_Name = 'OMF_TOTALADICIONALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFRETECTRITEM', ftBCD, 1396790350, 2)]
    [Dictionary('OMF_TOTALFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETECTRITEM: Double read FOMF_TOTALFRETECTRITEM write FOMF_TOTALFRETECTRITEM;
    const OMF_TOTALFRETECTRITEM_Name = 'OMF_TOTALFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSSIMPLESITEM', ftBCD, 1329808717, 2)]
    [Dictionary('OMF_TOTALICMSSIMPLESITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSSIMPLESITEM: Double read FOMF_TOTALICMSSIMPLESITEM write FOMF_TOTALICMSSIMPLESITEM;
    const OMF_TOTALICMSSIMPLESITEM_Name = 'OMF_TOTALICMSSIMPLESITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBONIFICACAOITEM', ftBCD, 1936020059, 2)]
    [Dictionary('OMF_TOTALBONIFICACAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBONIFICACAOITEM: Double read FOMF_TOTALBONIFICACAOITEM write FOMF_TOTALBONIFICACAOITEM;
    const OMF_TOTALBONIFICACAOITEM_Name = 'OMF_TOTALBONIFICACAOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASEOUTROSITEM', ftBCD, 1162039111, 2)]
    [Dictionary('OMF_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASEOUTROSITEM: Double read FOMF_TOTALBASEOUTROSITEM write FOMF_TOTALBASEOUTROSITEM;
    const OMF_TOTALBASEOUTROSITEM_Name = 'OMF_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSFRETENFITEM', ftBCD, 537529693, 2)]
    [Dictionary('OMF_TOTALICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSFRETENFITEM: Double read FOMF_TOTALICMSFRETENFITEM write FOMF_TOTALICMSFRETENFITEM;
    const OMF_TOTALICMSFRETENFITEM_Name = 'OMF_TOTALICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSFRETECTRITEM', ftBCD, 1952672068, 2)]
    [Dictionary('OMF_TOTALICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSFRETECTRITEM: Double read FOMF_TOTALICMSFRETECTRITEM write FOMF_TOTALICMSFRETECTRITEM;
    const OMF_TOTALICMSFRETECTRITEM_Name = 'OMF_TOTALICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALICMSACESSORIAITEM', ftBCD, 218762555, 2)]
    [Dictionary('OMF_TOTALICMSACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSACESSORIAITEM: Double read FOMF_TOTALICMSACESSORIAITEM write FOMF_TOTALICMSACESSORIAITEM;
    const OMF_TOTALICMSACESSORIAITEM_Name = 'OMF_TOTALICMSACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALDESPACESSORIAITEM', ftBCD, 1397311055, 2)]
    [Dictionary('OMF_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALDESPACESSORIAITEM: Double read FOMF_TOTALDESPACESSORIAITEM write FOMF_TOTALDESPACESSORIAITEM;
    const OMF_TOTALDESPACESSORIAITEM_Name = 'OMF_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALSUBSTRIBUTARIAITEM', ftBCD, 1195983951, 2)]
    [Dictionary('OMF_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALSUBSTRIBUTARIAITEM: Double read FOMF_TOTALSUBSTRIBUTARIAITEM write FOMF_TOTALSUBSTRIBUTARIAITEM;
    const OMF_TOTALSUBSTRIBUTARIAITEM_Name = 'OMF_TOTALSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASEISENTOICMSITEM', ftBCD, 544040295, 2)]
    [Dictionary('OMF_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASEISENTOICMSITEM: Double read FOMF_TOTALBASEISENTOICMSITEM write FOMF_TOTALBASEISENTOICMSITEM;
    const OMF_TOTALBASEISENTOICMSITEM_Name = 'OMF_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOMVAITEM', ftBCD, 1699555104, 2)]
    [Dictionary('OMF_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOMVAITEM: Double read FOMF_TOTALBASECALCULOMVAITEM write FOMF_TOTALBASECALCULOMVAITEM;
    const OMF_TOTALBASECALCULOMVAITEM_Name = 'OMF_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOICMSITEM', ftBCD, 656419879, 2)]
    [Dictionary('OMF_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOICMSITEM: Double read FOMF_TOTALBASECALCULOICMSITEM write FOMF_TOTALBASECALCULOICMSITEM;
    const OMF_TOTALBASECALCULOICMSITEM_Name = 'OMF_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALCOMPLEMENTONFICMSITEM', ftBCD, 1769238085, 2)]
    [Dictionary('OMF_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOMPLEMENTONFICMSITEM: Double read FOMF_TOTALCOMPLEMENTONFICMSITEM write FOMF_TOTALCOMPLEMENTONFICMSITEM;
    const OMF_TOTALCOMPLEMENTONFICMSITEM_Name = 'OMF_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCICMSFRETECTRITEM', ftBCD, 1380275039, 2)]
    [Dictionary('OMF_TOTALBCICMSFRETECTRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCICMSFRETECTRITEM: Double read FOMF_TOTALBCICMSFRETECTRITEM write FOMF_TOTALBCICMSFRETECTRITEM;
    const OMF_TOTALBCICMSFRETECTRITEM_Name = 'OMF_TOTALBCICMSFRETECTRITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCALCULOPISCOFINSITEM', ftBCD, 1411398223, 2)]
    [Dictionary('OMF_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCALCULOPISCOFINSITEM: Double read FOMF_TOTALBCALCULOPISCOFINSITEM write FOMF_TOTALBCALCULOPISCOFINSITEM;
    const OMF_TOTALBCALCULOPISCOFINSITEM_Name = 'OMF_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBCICMSFRETENFITEM', ftBCD, 1415532614, 2)]
    [Dictionary('OMF_TOTALBCICMSFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCICMSFRETENFITEM: Double read FOMF_TOTALBCICMSFRETENFITEM write FOMF_TOTALBCICMSFRETENFITEM;
    const OMF_TOTALBCICMSFRETENFITEM_Name = 'OMF_TOTALBCICMSFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_RATEADO', ftString, 1)]
    [Dictionary('OMF_RATEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_RATEADO: String read FOMF_RATEADO write FOMF_RATEADO;
    const OMF_RATEADO_Name = 'OMF_RATEADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: String read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;
    const OMF_INTEGRACAOERP_Name = 'OMF_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('OMF_NUMEROVOLUMES', ftBCD, 1142962771, 2)]
    [Dictionary('OMF_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_NUMEROVOLUMES: Double read FOMF_NUMEROVOLUMES write FOMF_NUMEROVOLUMES;
    const OMF_NUMEROVOLUMES_Name = 'OMF_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('OMF_PESOBRUTOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PESOBRUTOITEM: Double read FOMF_PESOBRUTOITEM write FOMF_PESOBRUTOITEM;
    const OMF_PESOBRUTOITEM_Name = 'OMF_PESOBRUTOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PESOLIQUIDOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PESOLIQUIDOITEM: Double read FOMF_PESOLIQUIDOITEM write FOMF_PESOLIQUIDOITEM;
    const OMF_PESOLIQUIDOITEM_Name = 'OMF_PESOLIQUIDOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_01_ID_OLD', ftInteger)]
    [Dictionary('OMF_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_01_ID_OLD: Integer read FOMF_01_ID_OLD write FOMF_01_ID_OLD;
    const OMF_01_ID_OLD_Name = 'OMF_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('DEV_ID_OLD', ftInteger)]
    [Dictionary('DEV_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID_OLD: Integer read FDEV_ID_OLD write FDEV_ID_OLD;
    const DEV_ID_OLD_Name = 'DEV_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('DEV_01_ID_OLD', ftInteger)]
    [Dictionary('DEV_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_01_ID_OLD: Integer read FDEV_01_ID_OLD write FDEV_01_ID_OLD;
    const DEV_01_ID_OLD_Name = 'DEV_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPODOCTO', ftString, 3)]
    [Dictionary('OMF_TIPODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPODOCTO: String read FOMF_TIPODOCTO write FOMF_TIPODOCTO;
    const OMF_TIPODOCTO_Name = 'OMF_TIPODOCTO';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALCOMISSAOITEM', ftBCD, 659507017, 6)]
    [Dictionary('OMF_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALCOMISSAOITEM: Double read FOMF_PERCENTUALCOMISSAOITEM write FOMF_PERCENTUALCOMISSAOITEM;
    const OMF_PERCENTUALCOMISSAOITEM_Name = 'OMF_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBASECALCULOPISCOFINSITEM', ftBCD, 1835362145, 6)]
    [Dictionary('OMF_VALORBASECALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASECALCULOPISCOFINSITEM: Double read FOMF_VALORBASECALCULOPISCOFINSITEM write FOMF_VALORBASECALCULOPISCOFINSITEM;
    const OMF_VALORBASECALCULOPISCOFINSITEM_Name = 'OMF_VALORBASECALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBASEDESCTOCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_VALORBASEDESCTOCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBASEDESCTOCOMISSAOITEM: Double read FOMF_VALORBASEDESCTOCOMISSAOITEM write FOMF_VALORBASEDESCTOCOMISSAOITEM;
    const OMF_VALORBASEDESCTOCOMISSAOITEM_Name = 'OMF_VALORBASEDESCTOCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCOMISSAOITEM: Double read FOMF_VALORCOMISSAOITEM write FOMF_VALORCOMISSAOITEM;
    const OMF_VALORCOMISSAOITEM_Name = 'OMF_VALORCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALCOMISSAOITEM', ftBCD, 6488169, 2)]
    [Dictionary('OMF_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALCOMISSAOITEM: Double read FOMF_TOTALCOMISSAOITEM write FOMF_TOTALCOMISSAOITEM;
    const OMF_TOTALCOMISSAOITEM_Name = 'OMF_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOPISCOFINSITEM', ftBCD, 2555936, 2)]
    [Dictionary('OMF_TOTALBASECALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOPISCOFINSITEM: Double read FOMF_TOTALBASECALCULOPISCOFINSITEM write FOMF_TOTALBASECALCULOPISCOFINSITEM;
    const OMF_TOTALBASECALCULOPISCOFINSITEM_Name = 'OMF_TOTALBASECALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTITEM', ftBCD, 5177376, 2)]
    [Dictionary('OMF_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTITEM: Double read FOMF_PERCENTUALIBPTITEM write FOMF_PERCENTUALIBPTITEM;
    const OMF_PERCENTUALIBPTITEM_Name = 'OMF_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTMUNICIPALITEM', ftBCD, 6684704, 2)]
    [Dictionary('OMF_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTMUNICIPALITEM: Double read FOMF_PERCENTUALIBPTMUNICIPALITEM write FOMF_PERCENTUALIBPTMUNICIPALITEM;
    const OMF_PERCENTUALIBPTMUNICIPALITEM_Name = 'OMF_PERCENTUALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTESTADUALITEM', ftBCD, 5046339, 2)]
    [Dictionary('OMF_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTESTADUALITEM: Double read FOMF_PERCENTUALIBPTESTADUALITEM write FOMF_PERCENTUALIBPTESTADUALITEM;
    const OMF_PERCENTUALIBPTESTADUALITEM_Name = 'OMF_PERCENTUALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTNACIONALITEM', ftBCD, 3866663, 2)]
    [Dictionary('OMF_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTNACIONALITEM: Double read FOMF_PERCENTUALIBPTNACIONALITEM write FOMF_PERCENTUALIBPTNACIONALITEM;
    const OMF_PERCENTUALIBPTNACIONALITEM_Name = 'OMF_PERCENTUALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALIBPTIMPORTADOITEM', ftBCD, 7143525, 2)]
    [Dictionary('OMF_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALIBPTIMPORTADOITEM: Double read FOMF_PERCENTUALIBPTIMPORTADOITEM write FOMF_PERCENTUALIBPTIMPORTADOITEM;
    const OMF_PERCENTUALIBPTIMPORTADOITEM_Name = 'OMF_PERCENTUALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIBPTMUNICIPALITEM', ftBCD, 4980801, 2)]
    [Dictionary('OMF_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIBPTMUNICIPALITEM: Double read FOMF_TOTALIBPTMUNICIPALITEM write FOMF_TOTALIBPTMUNICIPALITEM;
    const OMF_TOTALIBPTMUNICIPALITEM_Name = 'OMF_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIBPTESTADUALITEM', ftBCD, 2555944, 2)]
    [Dictionary('OMF_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIBPTESTADUALITEM: Double read FOMF_TOTALIBPTESTADUALITEM write FOMF_TOTALIBPTESTADUALITEM;
    const OMF_TOTALIBPTESTADUALITEM_Name = 'OMF_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIBPTNACIONALITEM', ftBCD, 655373, 2)]
    [Dictionary('OMF_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIBPTNACIONALITEM: Double read FOMF_TOTALIBPTNACIONALITEM write FOMF_TOTALIBPTNACIONALITEM;
    const OMF_TOTALIBPTNACIONALITEM_Name = 'OMF_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALIBPTIMPORTADOITEM', ftBCD, 4390978, 2)]
    [Dictionary('OMF_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALIBPTIMPORTADOITEM: Double read FOMF_TOTALIBPTIMPORTADOITEM write FOMF_TOTALIBPTIMPORTADOITEM;
    const OMF_TOTALIBPTIMPORTADOITEM_Name = 'OMF_TOTALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALAPROXIMADOIMPOSTOITEM', ftBCD, 2883623, 2)]
    [Dictionary('OMF_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALAPROXIMADOIMPOSTOITEM: Double read FOMF_TOTALAPROXIMADOIMPOSTOITEM write FOMF_TOTALAPROXIMADOIMPOSTOITEM;
    const OMF_TOTALAPROXIMADOIMPOSTOITEM_Name = 'OMF_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALFCPITEM', ftBCD, 5505102, 2)]
    [Dictionary('OMF_PERCENTUALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALFCPITEM: Double read FOMF_PERCENTUALFCPITEM write FOMF_PERCENTUALFCPITEM;
    const OMF_PERCENTUALFCPITEM_Name = 'OMF_PERCENTUALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOFCPITEM', ftBCD, 4980816, 2)]
    [Dictionary('OMF_TOTALBASECALCULOFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOFCPITEM: Double read FOMF_TOTALBASECALCULOFCPITEM write FOMF_TOTALBASECALCULOFCPITEM;
    const OMF_TOTALBASECALCULOFCPITEM_Name = 'OMF_TOTALBASECALCULOFCPITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFCPITEM', ftBCD, 5374031, 2)]
    [Dictionary('OMF_TOTALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFCPITEM: Double read FOMF_TOTALFCPITEM write FOMF_TOTALFCPITEM;
    const OMF_TOTALFCPITEM_Name = 'OMF_TOTALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOFCPSTITEM', ftBCD, 7471223, 2)]
    [Dictionary('OMF_TOTALBASECALCULOFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOFCPSTITEM: Double read FOMF_TOTALBASECALCULOFCPSTITEM write FOMF_TOTALBASECALCULOFCPSTITEM;
    const OMF_TOTALBASECALCULOFCPSTITEM_Name = 'OMF_TOTALBASECALCULOFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFCPSTITEM', ftBCD, 852061, 2)]
    [Dictionary('OMF_TOTALFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFCPSTITEM: Double read FOMF_TOTALFCPSTITEM write FOMF_TOTALFCPSTITEM;
    const OMF_TOTALFCPSTITEM_Name = 'OMF_TOTALFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALBASECALCULOFCPRETITEM', ftBCD, 2555943, 2)]
    [Dictionary('OMF_TOTALBASECALCULOFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBASECALCULOFCPRETITEM: Double read FOMF_TOTALBASECALCULOFCPRETITEM write FOMF_TOTALBASECALCULOFCPRETITEM;
    const OMF_TOTALBASECALCULOFCPRETITEM_Name = 'OMF_TOTALBASECALCULOFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALFCPRETITEM', ftBCD, 5374022, 2)]
    [Dictionary('OMF_TOTALFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFCPRETITEM: Double read FOMF_TOTALFCPRETITEM write FOMF_TOTALFCPRETITEM;
    const OMF_TOTALFCPRETITEM_Name = 'OMF_TOTALFCPRETITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_01)

end.
