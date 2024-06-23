unit express.dbo.OMF_DEVOLUCAOPRODUTOS;

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
  [Table('OMF_DevolucaoProdutos', '')]
  TDtoOMF_DevolucaoProdutos = class
  private
    { Private declarations } 
    FDEV_TIPOMOVTO: String;
    FDEV_MOVIMENTO: String;
    FDEV_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FDEV_ID: Integer;
    FDEV_CHAVEACESSO: String;
    FDEV_DATALANCAMENTO: TDateTime;
    FDEV_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FTAB_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_REFERENCIAINTERNA: String;
    FPRO_EMBALAGEM: String;
    FSGM_CODIGO: String;
    FLEF_CODIGO: Integer;
    FCST_CODIGO: String;
    FNCM_CODIGO: Integer;
    FCLF_CODIGO: String;
    FCFOP_CODIGO: String;
    FGRD_CODIGO: String;
    FDEV_LEFSTATUS: String;
    FDEV_DESTAQUE_NF: String;
    FDEV_QTDFATURADA: Double;
    FDEV_QTDDEVOLVIDA: Double;
    FDEV_PRECOCUSTO: Double;
    FDEV_PRECOVENDA: Double;
    FDEV_PRECOTABELA: Double;
    FDEV_PRECOLIQUIDO: Double;
    FDEV_PRECODIGITADO: Double;
    FDEV_PRECOBASEDESCTO: Double;
    FDEV_VALORCOMISSAOITEM: Double;
    FDEV_NUMEROVOLUMES: Double;
    FDEV_PERCENTUALIPIITEM: Double;
    FDEV_PERCENTUALPISITEM: Double;
    FDEV_PERCENTUALMVAITEM: Double;
    FDEV_PERCENTUALICMSITEM: Double;
    FDEV_PERCENTUALCOFINSITEM: Double;
    FDEV_PERCENTUALFRETEITEM: Double;
    FDEV_PERCENTUALDESCTOITEM: Double;
    FDEV_PERCENTUALSEGUROITEM: Double;
    FDEV_PERCENTUALREDUCAOBCITEM: Double;
    FDEV_PERCENTUALICMSDESTINOITEM: Double;
    FDEV_PERCENTUALDESPACESSORIAITEM: Double;
    FDEV_PERCENTUALCOMISSAOITEM: Double;
    FDEV_VALORPISITEM: Double;
    FDEV_VALORIPIITEM: Double;
    FDEV_VALORICMSITEM: Double;
    FDEV_VALORICMSRITEM: Double;
    FDEV_VALORFRETEITEM: Double;
    FDEV_VALORCOFINSITEM: Double;
    FDEV_VALORDESCTOITEM: Double;
    FDEV_VALORSEGUROITEM: Double;
    FDEV_VALORBASEOUTROSITEM: Double;
    FDEV_VALORDESCTOPRAZOITEM: Double;
    FDEV_VALORDESCTOAVULSOITEM: Double;
    FDEV_VALORDESPACESSORIAITEM: Double;
    FDEV_VALORSUBSTRIBUTARIAITEM: Double;
    FDEV_VALORBASEISENTOICMSITEM: Double;
    FDEV_VALORBASECALCULOMVAITEM: Double;
    FDEV_VALORBASECALCULOICMSITEM: Double;
    FDEV_VALORFINANCEIROPRAZOITEM: Double;
    FDEV_VALORCOMPLEMENTONFICMSITEM: Double;
    FDEV_VALORBCALCULOPISCOFINSITEM: Double;
    FCSTPC_CODIGO: String;
    FDEV_TOTALCOMISSAOITEM: Double;
    FDEV_TOTALPISITEM: Double;
    FDEV_TOTALIPIITEM: Double;
    FDEV_TOTALICMSITEM: Double;
    FDEV_TOTALICMSRITEM: Double;
    FDEV_TOTALFRETEITEM: Double;
    FDEV_TOTALCOFINSITEM: Double;
    FDEV_TOTALDESCTOITEM: Double;
    FDEV_TOTALSEGUROITEM: Double;
    FDEV_TOTALBASEOUTROSITEM: Double;
    FDEV_TOTALDESCTOPRAZOITEM: Double;
    FDEV_TOTALDESCTOAVULSOITEM: Double;
    FDEV_TOTALDESPACESSORIAITEM: Double;
    FDEV_TOTALSUBSTRIBUTARIAITEM: Double;
    FDEV_TOTALBASEISENTOICMSITEM: Double;
    FDEV_TOTALBASECALCULOMVAITEM: Double;
    FDEV_TOTALBASECALCULOICMSITEM: Double;
    FDEV_TOTALFINANCEIROPRAZOITEM: Double;
    FDEV_TOTALCOMPLEMENTONFICMSITEM: Double;
    FDEV_TOTALBCALCULOPISCOFINSITEM: Double;
    FDEV_PERCENTUALIBPTITEM: Double;
    FDEV_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FDEV_PESOLIQUIDOITEM: Double;
    FDEV_PESOBRUTOITEM: Double;
    FDEV_ESTOQUEDEVOLUCAO: Currency;
    FDEV_DIASDEVOLUCAO: Integer;
    FDEV_VALORBASEDESCTOCOMISSAOITEM: Double;
    FDEV_PERCENTUALIBPTMUNICIPALITEM: Double;
    FDEV_PERCENTUALIBPTESTADUALITEM: Double;
    FDEV_PERCENTUALIBPTNACIONALITEM: Double;
    FDEV_PERCENTUALIBPTIMPORTADOITEM: Double;
    FDEV_TOTALIBPTMUNICIPALITEM: Double;
    FDEV_TOTALIBPTESTADUALITEM: Double;
    FDEV_TOTALIBPTNACIONALITEM: Double;
    FDEV_TOTALIBPTIMPORTADOITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'OMF_DevolucaoProdutos';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_TIPOMOVTO', ftString, 1)]
    [Dictionary('DEV_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_TIPOMOVTO: String read FDEV_TIPOMOVTO write FDEV_TIPOMOVTO;
    const DEV_TIPOMOVTO_Name = 'DEV_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_MOVIMENTO', ftString, 3)]
    [Dictionary('DEV_MOVIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_MOVIMENTO: String read FDEV_MOVIMENTO write FDEV_MOVIMENTO;
    const DEV_MOVIMENTO_Name = 'DEV_MOVIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_01_ID', ftInteger)]
    [Dictionary('DEV_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_01_ID: Integer read FDEV_01_ID write FDEV_01_ID;
    const DEV_01_ID_Name = 'DEV_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_ID', ftInteger)]
    [Dictionary('DEV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_ID: Integer read FDEV_ID write FDEV_ID;
    const DEV_ID_Name = 'DEV_ID';

    [Restrictions([NoValidate])]
    [Column('DEV_CHAVEACESSO', ftString, 44)]
    [Dictionary('DEV_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_CHAVEACESSO: String read FDEV_CHAVEACESSO write FDEV_CHAVEACESSO;
    const DEV_CHAVEACESSO_Name = 'DEV_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DEV_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEV_DATALANCAMENTO: TDateTime read FDEV_DATALANCAMENTO write FDEV_DATALANCAMENTO;
    const DEV_DATALANCAMENTO_Name = 'DEV_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('DEV_NOTAFISCAL', ftString, 9)]
    [Dictionary('DEV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_NOTAFISCAL: String read FDEV_NOTAFISCAL write FDEV_NOTAFISCAL;
    const DEV_NOTAFISCAL_Name = 'DEV_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

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

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

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
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEV_LEFSTATUS', ftString, 1)]
    [Dictionary('DEV_LEFSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_LEFSTATUS: String read FDEV_LEFSTATUS write FDEV_LEFSTATUS;
    const DEV_LEFSTATUS_Name = 'DEV_LEFSTATUS';

    [Restrictions([NoValidate])]
    [Column('DEV_DESTAQUE_NF', ftString, 1)]
    [Dictionary('DEV_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEV_DESTAQUE_NF: String read FDEV_DESTAQUE_NF write FDEV_DESTAQUE_NF;
    const DEV_DESTAQUE_NF_Name = 'DEV_DESTAQUE_NF';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('DEV_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_QTDFATURADA: Double read FDEV_QTDFATURADA write FDEV_QTDFATURADA;
    const DEV_QTDFATURADA_Name = 'DEV_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('DEV_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('DEV_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_QTDDEVOLVIDA: Double read FDEV_QTDDEVOLVIDA write FDEV_QTDDEVOLVIDA;
    const DEV_QTDDEVOLVIDA_Name = 'DEV_QTDDEVOLVIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('DEV_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOCUSTO: Double read FDEV_PRECOCUSTO write FDEV_PRECOCUSTO;
    const DEV_PRECOCUSTO_Name = 'DEV_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOVENDA', ftBCD, 10, 10)]
    [Dictionary('DEV_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOVENDA: Double read FDEV_PRECOVENDA write FDEV_PRECOVENDA;
    const DEV_PRECOVENDA_Name = 'DEV_PRECOVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOTABELA', ftBCD)]
    [Dictionary('DEV_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOTABELA: Double read FDEV_PRECOTABELA write FDEV_PRECOTABELA;
    const DEV_PRECOTABELA_Name = 'DEV_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECOLIQUIDO', ftBCD, 66260064, 10)]
    [Dictionary('DEV_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOLIQUIDO: Double read FDEV_PRECOLIQUIDO write FDEV_PRECOLIQUIDO;
    const DEV_PRECOLIQUIDO_Name = 'DEV_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PRECODIGITADO', ftBCD)]
    [Dictionary('DEV_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECODIGITADO: Double read FDEV_PRECODIGITADO write FDEV_PRECODIGITADO;
    const DEV_PRECODIGITADO_Name = 'DEV_PRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('DEV_PRECOBASEDESCTO', ftBCD)]
    [Dictionary('DEV_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PRECOBASEDESCTO: Double read FDEV_PRECOBASEDESCTO write FDEV_PRECOBASEDESCTO;
    const DEV_PRECOBASEDESCTO_Name = 'DEV_PRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('DEV_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOMISSAOITEM: Double read FDEV_VALORCOMISSAOITEM write FDEV_VALORCOMISSAOITEM;
    const DEV_VALORCOMISSAOITEM_Name = 'DEV_VALORCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_NUMEROVOLUMES', ftBCD)]
    [Dictionary('DEV_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_NUMEROVOLUMES: Double read FDEV_NUMEROVOLUMES write FDEV_NUMEROVOLUMES;
    const DEV_NUMEROVOLUMES_Name = 'DEV_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIPIITEM: Double read FDEV_PERCENTUALIPIITEM write FDEV_PERCENTUALIPIITEM;
    const DEV_PERCENTUALIPIITEM_Name = 'DEV_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALPISITEM: Double read FDEV_PERCENTUALPISITEM write FDEV_PERCENTUALPISITEM;
    const DEV_PERCENTUALPISITEM_Name = 'DEV_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALMVAITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALMVAITEM: Double read FDEV_PERCENTUALMVAITEM write FDEV_PERCENTUALMVAITEM;
    const DEV_PERCENTUALMVAITEM_Name = 'DEV_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALICMSITEM: Double read FDEV_PERCENTUALICMSITEM write FDEV_PERCENTUALICMSITEM;
    const DEV_PERCENTUALICMSITEM_Name = 'DEV_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOFINSITEM: Double read FDEV_PERCENTUALCOFINSITEM write FDEV_PERCENTUALCOFINSITEM;
    const DEV_PERCENTUALCOFINSITEM_Name = 'DEV_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALFRETEITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALFRETEITEM: Double read FDEV_PERCENTUALFRETEITEM write FDEV_PERCENTUALFRETEITEM;
    const DEV_PERCENTUALFRETEITEM_Name = 'DEV_PERCENTUALFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALDESCTOITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESCTOITEM: Double read FDEV_PERCENTUALDESCTOITEM write FDEV_PERCENTUALDESCTOITEM;
    const DEV_PERCENTUALDESCTOITEM_Name = 'DEV_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALSEGUROITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALSEGUROITEM: Double read FDEV_PERCENTUALSEGUROITEM write FDEV_PERCENTUALSEGUROITEM;
    const DEV_PERCENTUALSEGUROITEM_Name = 'DEV_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALREDUCAOBCITEM: Double read FDEV_PERCENTUALREDUCAOBCITEM write FDEV_PERCENTUALREDUCAOBCITEM;
    const DEV_PERCENTUALREDUCAOBCITEM_Name = 'DEV_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALICMSDESTINOITEM: Double read FDEV_PERCENTUALICMSDESTINOITEM write FDEV_PERCENTUALICMSDESTINOITEM;
    const DEV_PERCENTUALICMSDESTINOITEM_Name = 'DEV_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALDESPACESSORIAITEM: Double read FDEV_PERCENTUALDESPACESSORIAITEM write FDEV_PERCENTUALDESPACESSORIAITEM;
    const DEV_PERCENTUALDESPACESSORIAITEM_Name = 'DEV_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_PERCENTUALCOMISSAOITEM', ftBCD, 48, 2)]
    [Dictionary('DEV_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALCOMISSAOITEM: Double read FDEV_PERCENTUALCOMISSAOITEM write FDEV_PERCENTUALCOMISSAOITEM;
    const DEV_PERCENTUALCOMISSAOITEM_Name = 'DEV_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORPISITEM', ftBCD)]
    [Dictionary('DEV_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORPISITEM: Double read FDEV_VALORPISITEM write FDEV_VALORPISITEM;
    const DEV_VALORPISITEM_Name = 'DEV_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORIPIITEM', ftBCD)]
    [Dictionary('DEV_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORIPIITEM: Double read FDEV_VALORIPIITEM write FDEV_VALORIPIITEM;
    const DEV_VALORIPIITEM_Name = 'DEV_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORICMSITEM', ftBCD, 48, 6)]
    [Dictionary('DEV_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSITEM: Double read FDEV_VALORICMSITEM write FDEV_VALORICMSITEM;
    const DEV_VALORICMSITEM_Name = 'DEV_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORICMSRITEM', ftBCD, 48, 6)]
    [Dictionary('DEV_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORICMSRITEM: Double read FDEV_VALORICMSRITEM write FDEV_VALORICMSRITEM;
    const DEV_VALORICMSRITEM_Name = 'DEV_VALORICMSRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORFRETEITEM', ftBCD)]
    [Dictionary('DEV_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORFRETEITEM: Double read FDEV_VALORFRETEITEM write FDEV_VALORFRETEITEM;
    const DEV_VALORFRETEITEM_Name = 'DEV_VALORFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORCOFINSITEM', ftBCD)]
    [Dictionary('DEV_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOFINSITEM: Double read FDEV_VALORCOFINSITEM write FDEV_VALORCOFINSITEM;
    const DEV_VALORCOFINSITEM_Name = 'DEV_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESCTOITEM', ftBCD)]
    [Dictionary('DEV_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOITEM: Double read FDEV_VALORDESCTOITEM write FDEV_VALORDESCTOITEM;
    const DEV_VALORDESCTOITEM_Name = 'DEV_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORSEGUROITEM', ftBCD, 48, 6)]
    [Dictionary('DEV_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORSEGUROITEM: Double read FDEV_VALORSEGUROITEM write FDEV_VALORSEGUROITEM;
    const DEV_VALORSEGUROITEM_Name = 'DEV_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('DEV_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEOUTROSITEM: Double read FDEV_VALORBASEOUTROSITEM write FDEV_VALORBASEOUTROSITEM;
    const DEV_VALORBASEOUTROSITEM_Name = 'DEV_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('DEV_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOPRAZOITEM: Double read FDEV_VALORDESCTOPRAZOITEM write FDEV_VALORDESCTOPRAZOITEM;
    const DEV_VALORDESCTOPRAZOITEM_Name = 'DEV_VALORDESCTOPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESCTOAVULSOITEM', ftBCD, 48, 6)]
    [Dictionary('DEV_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESCTOAVULSOITEM: Double read FDEV_VALORDESCTOAVULSOITEM write FDEV_VALORDESCTOAVULSOITEM;
    const DEV_VALORDESCTOAVULSOITEM_Name = 'DEV_VALORDESCTOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('DEV_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORDESPACESSORIAITEM: Double read FDEV_VALORDESPACESSORIAITEM write FDEV_VALORDESPACESSORIAITEM;
    const DEV_VALORDESPACESSORIAITEM_Name = 'DEV_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORSUBSTRIBUTARIAITEM', ftBCD)]
    [Dictionary('DEV_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORSUBSTRIBUTARIAITEM: Double read FDEV_VALORSUBSTRIBUTARIAITEM write FDEV_VALORSUBSTRIBUTARIAITEM;
    const DEV_VALORSUBSTRIBUTARIAITEM_Name = 'DEV_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('DEV_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEISENTOICMSITEM: Double read FDEV_VALORBASEISENTOICMSITEM write FDEV_VALORBASEISENTOICMSITEM;
    const DEV_VALORBASEISENTOICMSITEM_Name = 'DEV_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASECALCULOMVAITEM', ftBCD)]
    [Dictionary('DEV_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOMVAITEM: Double read FDEV_VALORBASECALCULOMVAITEM write FDEV_VALORBASECALCULOMVAITEM;
    const DEV_VALORBASECALCULOMVAITEM_Name = 'DEV_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('DEV_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASECALCULOICMSITEM: Double read FDEV_VALORBASECALCULOICMSITEM write FDEV_VALORBASECALCULOICMSITEM;
    const DEV_VALORBASECALCULOICMSITEM_Name = 'DEV_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('DEV_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORFINANCEIROPRAZOITEM: Double read FDEV_VALORFINANCEIROPRAZOITEM write FDEV_VALORFINANCEIROPRAZOITEM;
    const DEV_VALORFINANCEIROPRAZOITEM_Name = 'DEV_VALORFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEV_VALORCOMPLEMENTONFICMSITEM', ftBCD, 1329815375, 6)]
    [Dictionary('DEV_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORCOMPLEMENTONFICMSITEM: Double read FDEV_VALORCOMPLEMENTONFICMSITEM write FDEV_VALORCOMPLEMENTONFICMSITEM;
    const DEV_VALORCOMPLEMENTONFICMSITEM_Name = 'DEV_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBCALCULOPISCOFINSITEM', ftBCD, 1229213507, 6)]
    [Dictionary('DEV_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBCALCULOPISCOFINSITEM: Double read FDEV_VALORBCALCULOPISCOFINSITEM write FDEV_VALORBCALCULOPISCOFINSITEM;
    const DEV_VALORBCALCULOPISCOFINSITEM_Name = 'DEV_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALCOMISSAOITEM', ftBCD, 16385, 2)]
    [Dictionary('DEV_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMISSAOITEM: Double read FDEV_TOTALCOMISSAOITEM write FDEV_TOTALCOMISSAOITEM;
    const DEV_TOTALCOMISSAOITEM_Name = 'DEV_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALPISITEM', ftBCD, 1, 2)]
    [Dictionary('DEV_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALPISITEM: Double read FDEV_TOTALPISITEM write FDEV_TOTALPISITEM;
    const DEV_TOTALPISITEM_Name = 'DEV_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIPIITEM', ftBCD)]
    [Dictionary('DEV_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIPIITEM: Double read FDEV_TOTALIPIITEM write FDEV_TOTALIPIITEM;
    const DEV_TOTALIPIITEM_Name = 'DEV_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALICMSITEM', ftBCD, 52, 2)]
    [Dictionary('DEV_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSITEM: Double read FDEV_TOTALICMSITEM write FDEV_TOTALICMSITEM;
    const DEV_TOTALICMSITEM_Name = 'DEV_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALICMSRITEM', ftBCD)]
    [Dictionary('DEV_TOTALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALICMSRITEM: Double read FDEV_TOTALICMSRITEM write FDEV_TOTALICMSRITEM;
    const DEV_TOTALICMSRITEM_Name = 'DEV_TOTALICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALFRETEITEM', ftBCD, 2097184, 2)]
    [Dictionary('DEV_TOTALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFRETEITEM: Double read FDEV_TOTALFRETEITEM write FDEV_TOTALFRETEITEM;
    const DEV_TOTALFRETEITEM_Name = 'DEV_TOTALFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALCOFINSITEM', ftBCD, 5177428, 2)]
    [Dictionary('DEV_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOFINSITEM: Double read FDEV_TOTALCOFINSITEM write FDEV_TOTALCOFINSITEM;
    const DEV_TOTALCOFINSITEM_Name = 'DEV_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESCTOITEM', ftBCD, 7274610, 2)]
    [Dictionary('DEV_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOITEM: Double read FDEV_TOTALDESCTOITEM write FDEV_TOTALDESCTOITEM;
    const DEV_TOTALDESCTOITEM_Name = 'DEV_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALSEGUROITEM', ftBCD, 5374017, 2)]
    [Dictionary('DEV_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSEGUROITEM: Double read FDEV_TOTALSEGUROITEM write FDEV_TOTALSEGUROITEM;
    const DEV_TOTALSEGUROITEM_Name = 'DEV_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASEOUTROSITEM', ftBCD, 4522067, 2)]
    [Dictionary('DEV_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEOUTROSITEM: Double read FDEV_TOTALBASEOUTROSITEM write FDEV_TOTALBASEOUTROSITEM;
    const DEV_TOTALBASEOUTROSITEM_Name = 'DEV_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESCTOPRAZOITEM', ftBCD, 538970637, 2)]
    [Dictionary('DEV_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOPRAZOITEM: Double read FDEV_TOTALDESCTOPRAZOITEM write FDEV_TOTALDESCTOPRAZOITEM;
    const DEV_TOTALDESCTOPRAZOITEM_Name = 'DEV_TOTALDESCTOPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESCTOAVULSOITEM', ftBCD, 1953391939, 2)]
    [Dictionary('DEV_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESCTOAVULSOITEM: Double read FDEV_TOTALDESCTOAVULSOITEM write FDEV_TOTALDESCTOAVULSOITEM;
    const DEV_TOTALDESCTOAVULSOITEM_Name = 'DEV_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALDESPACESSORIAITEM', ftBCD, 4784197, 2)]
    [Dictionary('DEV_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALDESPACESSORIAITEM: Double read FDEV_TOTALDESPACESSORIAITEM write FDEV_TOTALDESPACESSORIAITEM;
    const DEV_TOTALDESPACESSORIAITEM_Name = 'DEV_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALSUBSTRIBUTARIAITEM', ftBCD, 4587552, 2)]
    [Dictionary('DEV_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALSUBSTRIBUTARIAITEM: Double read FDEV_TOTALSUBSTRIBUTARIAITEM write FDEV_TOTALSUBSTRIBUTARIAITEM;
    const DEV_TOTALSUBSTRIBUTARIAITEM_Name = 'DEV_TOTALSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASEISENTOICMSITEM', ftBCD, 2097196, 2)]
    [Dictionary('DEV_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASEISENTOICMSITEM: Double read FDEV_TOTALBASEISENTOICMSITEM write FDEV_TOTALBASEISENTOICMSITEM;
    const DEV_TOTALBASEISENTOICMSITEM_Name = 'DEV_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASECALCULOMVAITEM', ftBCD, 1818453348, 2)]
    [Dictionary('DEV_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOMVAITEM: Double read FDEV_TOTALBASECALCULOMVAITEM write FDEV_TOTALBASECALCULOMVAITEM;
    const DEV_TOTALBASECALCULOMVAITEM_Name = 'DEV_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBASECALCULOICMSITEM', ftBCD, 221996910, 2)]
    [Dictionary('DEV_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBASECALCULOICMSITEM: Double read FDEV_TOTALBASECALCULOICMSITEM write FDEV_TOTALBASECALCULOICMSITEM;
    const DEV_TOTALBASECALCULOICMSITEM_Name = 'DEV_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALFINANCEIROPRAZOITEM', ftBCD, 1179206738, 2)]
    [Dictionary('DEV_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALFINANCEIROPRAZOITEM: Double read FDEV_TOTALFINANCEIROPRAZOITEM write FDEV_TOTALFINANCEIROPRAZOITEM;
    const DEV_TOTALFINANCEIROPRAZOITEM_Name = 'DEV_TOTALFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALCOMPLEMENTONFICMSITEM', ftBCD, 538970637, 2)]
    [Dictionary('DEV_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALCOMPLEMENTONFICMSITEM: Double read FDEV_TOTALCOMPLEMENTONFICMSITEM write FDEV_TOTALCOMPLEMENTONFICMSITEM;
    const DEV_TOTALCOMPLEMENTONFICMSITEM_Name = 'DEV_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALBCALCULOPISCOFINSITEM', ftBCD, 1936617321, 2)]
    [Dictionary('DEV_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALBCALCULOPISCOFINSITEM: Double read FDEV_TOTALBCALCULOPISCOFINSITEM write FDEV_TOTALBCALCULOPISCOFINSITEM;
    const DEV_TOTALBCALCULOPISCOFINSITEM_Name = 'DEV_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTITEM', ftBCD, 1818439271, 2)]
    [Dictionary('DEV_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTITEM: Double read FDEV_PERCENTUALIBPTITEM write FDEV_PERCENTUALIBPTITEM;
    const DEV_PERCENTUALIBPTITEM_Name = 'DEV_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALAPROXIMADOIMPOSTOITEM', ftBCD, 5111903, 2)]
    [Dictionary('DEV_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALAPROXIMADOIMPOSTOITEM: Double read FDEV_TOTALAPROXIMADOIMPOSTOITEM write FDEV_TOTALAPROXIMADOIMPOSTOITEM;
    const DEV_TOTALAPROXIMADOIMPOSTOITEM_Name = 'DEV_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PESOLIQUIDOITEM', ftBCD, 18, 4)]
    [Dictionary('DEV_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PESOLIQUIDOITEM: Double read FDEV_PESOLIQUIDOITEM write FDEV_PESOLIQUIDOITEM;
    const DEV_PESOLIQUIDOITEM_Name = 'DEV_PESOLIQUIDOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PESOBRUTOITEM', ftBCD, 18, 4)]
    [Dictionary('DEV_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PESOBRUTOITEM: Double read FDEV_PESOBRUTOITEM write FDEV_PESOBRUTOITEM;
    const DEV_PESOBRUTOITEM_Name = 'DEV_PESOBRUTOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_ESTOQUEDEVOLUCAO', ftCurrency)]
    [Dictionary('DEV_ESTOQUEDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_ESTOQUEDEVOLUCAO: Currency read FDEV_ESTOQUEDEVOLUCAO write FDEV_ESTOQUEDEVOLUCAO;
    const DEV_ESTOQUEDEVOLUCAO_Name = 'DEV_ESTOQUEDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('DEV_DIASDEVOLUCAO', ftInteger)]
    [Dictionary('DEV_DIASDEVOLUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEV_DIASDEVOLUCAO: Integer read FDEV_DIASDEVOLUCAO write FDEV_DIASDEVOLUCAO;
    const DEV_DIASDEVOLUCAO_Name = 'DEV_DIASDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('DEV_VALORBASEDESCTOCOMISSAOITEM', ftBCD)]
    [Dictionary('DEV_VALORBASEDESCTOCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_VALORBASEDESCTOCOMISSAOITEM: Double read FDEV_VALORBASEDESCTOCOMISSAOITEM write FDEV_VALORBASEDESCTOCOMISSAOITEM;
    const DEV_VALORBASEDESCTOCOMISSAOITEM_Name = 'DEV_VALORBASEDESCTOCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTMUNICIPALITEM: Double read FDEV_PERCENTUALIBPTMUNICIPALITEM write FDEV_PERCENTUALIBPTMUNICIPALITEM;
    const DEV_PERCENTUALIBPTMUNICIPALITEM_Name = 'DEV_PERCENTUALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTESTADUALITEM', ftBCD, 16387, 2)]
    [Dictionary('DEV_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTESTADUALITEM: Double read FDEV_PERCENTUALIBPTESTADUALITEM write FDEV_PERCENTUALIBPTESTADUALITEM;
    const DEV_PERCENTUALIBPTESTADUALITEM_Name = 'DEV_PERCENTUALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTNACIONALITEM', ftBCD, 5636178, 2)]
    [Dictionary('DEV_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTNACIONALITEM: Double read FDEV_PERCENTUALIBPTNACIONALITEM write FDEV_PERCENTUALIBPTNACIONALITEM;
    const DEV_PERCENTUALIBPTNACIONALITEM_Name = 'DEV_PERCENTUALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_PERCENTUALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('DEV_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_PERCENTUALIBPTIMPORTADOITEM: Double read FDEV_PERCENTUALIBPTIMPORTADOITEM write FDEV_PERCENTUALIBPTIMPORTADOITEM;
    const DEV_PERCENTUALIBPTIMPORTADOITEM_Name = 'DEV_PERCENTUALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTMUNICIPALITEM', ftBCD)]
    [Dictionary('DEV_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTMUNICIPALITEM: Double read FDEV_TOTALIBPTMUNICIPALITEM write FDEV_TOTALIBPTMUNICIPALITEM;
    const DEV_TOTALIBPTMUNICIPALITEM_Name = 'DEV_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTESTADUALITEM', ftBCD, 16387, 2)]
    [Dictionary('DEV_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTESTADUALITEM: Double read FDEV_TOTALIBPTESTADUALITEM write FDEV_TOTALIBPTESTADUALITEM;
    const DEV_TOTALIBPTESTADUALITEM_Name = 'DEV_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTNACIONALITEM', ftBCD, 16387, 2)]
    [Dictionary('DEV_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTNACIONALITEM: Double read FDEV_TOTALIBPTNACIONALITEM write FDEV_TOTALIBPTNACIONALITEM;
    const DEV_TOTALIBPTNACIONALITEM_Name = 'DEV_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('DEV_TOTALIBPTIMPORTADOITEM', ftBCD, 300, 2)]
    [Dictionary('DEV_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DEV_TOTALIBPTIMPORTADOITEM: Double read FDEV_TOTALIBPTIMPORTADOITEM write FDEV_TOTALIBPTIMPORTADOITEM;
    const DEV_TOTALIBPTIMPORTADOITEM_Name = 'DEV_TOTALIBPTIMPORTADOITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_DevolucaoProdutos)

end.
