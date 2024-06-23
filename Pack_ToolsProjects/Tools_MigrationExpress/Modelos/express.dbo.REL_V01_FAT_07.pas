unit express.dbo.REL_V01_FAT_07;

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
  [Table('REL_V01_FAT_07', '')]
  TDtoREL_V01_FAT_07 = class
  private
    { Private declarations } 
    FFAT_TIPO: String;
    FFAT_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_NUMERODOCTO: String;
    FFAT_NOTAFISCAL: String;
    FMNF_CODIGO: String;
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
    FCFOP_CODIGO: String;
    FFAT_LEFSTATUS: String;
    FFAT_DESTAQUE_NF: String;
    FFAT_QTDFATURADA: Double;
    FFAT_QTDDEVOLVIDA: Double;
    FFAT_QTDENTREGUE: Double;
    FFAT_QTDRECOLHIDA: Double;
    FFAT_PRECOCUSTO: Double;
    FFAT_PRECOVENDA: Double;
    FFAT_PRECOTABELA: Double;
    FFAT_PRECOLIQUIDO: Double;
    FFAT_PRECODIGITADO: Double;
    FFAT_PRECOBASEDESCTO: Double;
    FFAT_VALORCOMISSAOITEM: Double;
    FFAT_NUMEROVOLUMES: Double;
    FFAT_PERCENTUALIPIITEM: Double;
    FFAT_PERCENTUALPISITEM: Double;
    FFAT_PERCENTUALMVAITEM: Double;
    FFAT_PERCENTUALICMSITEM: Double;
    FFAT_PERCENTUALCOFINSITEM: Double;
    FFAT_PERCENTUALFRETEITEM: Double;
    FFAT_PERCENTUALDESCTOITEM: Double;
    FFAT_PERCENTUALSEGUROITEM: Double;
    FFAT_PERCENTUALREDUCAOBCITEM: Double;
    FFAT_PERCENTUALICMSDESTINOITEM: Double;
    FFAT_PERCENTUALDESPACESSORIAITEM: Double;
    FFAT_PERCENTUALCOMISSAOITEM: Double;
    FFAT_VALORPISITEM: Double;
    FFAT_VALORIPIITEM: Double;
    FFAT_VALORICMSITEM: Double;
    FFAT_VALORICMSRITEM: Double;
    FFAT_VALORFRETEITEM: Double;
    FFAT_VALORCOFINSITEM: Double;
    FFAT_VALORDESCTOITEM: Double;
    FFAT_VALORSEGUROITEM: Double;
    FFAT_VALORBASEOUTROSITEM: Double;
    FFAT_VALORDESCTOPRAZOITEM: Double;
    FFAT_VALORDESCTOAVULSOITEM: Double;
    FFAT_VALORDESPACESSORIAITEM: Double;
    FFAT_VALORSUBSTRIBUTARIAITEM: Double;
    FFAT_VALORBASEISENTOICMSITEM: Double;
    FFAT_VALORBASECALCULOMVAITEM: Double;
    FFAT_VALORBASECALCULOICMSITEM: Double;
    FFAT_VALORFINANCEIROPRAZOITEM: Double;
    FFAT_VALORCOMPLEMENTONFICMSITEM: Double;
    FFAT_VALORBCALCULOPISCOFINSITEM: Double;
    FCSTPC_CODIGO: String;
    FFAT_TOTALCOMISSAOITEM: Double;
    FFAT_TOTALPISITEM: Double;
    FFAT_TOTALIPIITEM: Double;
    FFAT_TOTALICMSITEM: Double;
    FFAT_TOTALICMSRITEM: Double;
    FFAT_TOTALFRETEITEM: Double;
    FFAT_TOTALCOFINSITEM: Double;
    FFAT_TOTALDESCTOITEM: Double;
    FFAT_TOTALSEGUROITEM: Double;
    FFAT_TOTALBASEOUTROSITEM: Double;
    FFAT_TOTALDESCTOPRAZOITEM: Double;
    FFAT_TOTALDESCTOAVULSOITEM: Double;
    FFAT_TOTALDESPACESSORIAITEM: Double;
    FFAT_TOTALSUBSTRIBUTARIAITEM: Double;
    FFAT_TOTALBASEISENTOICMSITEM: Double;
    FFAT_TOTALBASECALCULOMVAITEM: Double;
    FFAT_TOTALBASECALCULOICMSITEM: Double;
    FFAT_TOTALFINANCEIROPRAZOITEM: Double;
    FFAT_TOTALCOMPLEMENTONFICMSITEM: Double;
    FFAT_TOTALBCALCULOPISCOFINSITEM: Double;
    FFAT_PERCENTUALIBPTITEM: Double;
    FFAT_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FFAT_PESOLIQUIDOITEM: Double;
    FFAT_PESOBRUTOITEM: Double;
    FFAT_ESTOQUEDEVOLUCAO: Currency;
    FFAT_DIASDEVOLUCAO: Integer;
    FFAT_VALORBASEDESCTOCOMISSAOITEM: Double;
    FGRD_CODIGO: String;
    FFAT_PERCENTUALIBPTMUNICIPALITEM: Double;
    FFAT_PERCENTUALIBPTESTADUALITEM: Double;
    FFAT_PERCENTUALIBPTNACIONALITEM: Double;
    FFAT_PERCENTUALIBPTIMPORTADOITEM: Double;
    FFAT_TOTALIBPTMUNICIPALITEM: Double;
    FFAT_TOTALIBPTESTADUALITEM: Double;
    FFAT_TOTALIBPTNACIONALITEM: Double;
    FFAT_TOTALIBPTIMPORTADOITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_FAT_07';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPO', ftString, 3)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_01_ID', ftInteger)]
    [Dictionary('FAT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID: Integer read FFAT_01_ID write FFAT_01_ID;
    const FAT_01_ID_Name = 'FAT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

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
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_LEFSTATUS', ftString, 1)]
    [Dictionary('FAT_LEFSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_LEFSTATUS: String read FFAT_LEFSTATUS write FFAT_LEFSTATUS;
    const FAT_LEFSTATUS_Name = 'FAT_LEFSTATUS';

    [Restrictions([NoValidate])]
    [Column('FAT_DESTAQUE_NF', ftString, 1)]
    [Dictionary('FAT_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESTAQUE_NF: String read FFAT_DESTAQUE_NF write FFAT_DESTAQUE_NF;
    const FAT_DESTAQUE_NF_Name = 'FAT_DESTAQUE_NF';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Double read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDDEVOLVIDA: Double read FFAT_QTDDEVOLVIDA write FFAT_QTDDEVOLVIDA;
    const FAT_QTDDEVOLVIDA_Name = 'FAT_QTDDEVOLVIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDENTREGUE', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDENTREGUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDENTREGUE: Double read FFAT_QTDENTREGUE write FFAT_QTDENTREGUE;
    const FAT_QTDENTREGUE_Name = 'FAT_QTDENTREGUE';

    [Restrictions([NoValidate])]
    [Column('FAT_QTDRECOLHIDA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDRECOLHIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDRECOLHIDA: Double read FFAT_QTDRECOLHIDA write FFAT_QTDRECOLHIDA;
    const FAT_QTDRECOLHIDA_Name = 'FAT_QTDRECOLHIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOCUSTO: Double read FFAT_PRECOCUSTO write FFAT_PRECOCUSTO;
    const FAT_PRECOCUSTO_Name = 'FAT_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOVENDA', ftBCD)]
    [Dictionary('FAT_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOVENDA: Double read FFAT_PRECOVENDA write FFAT_PRECOVENDA;
    const FAT_PRECOVENDA_Name = 'FAT_PRECOVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOTABELA: Double read FFAT_PRECOTABELA write FFAT_PRECOTABELA;
    const FAT_PRECOTABELA_Name = 'FAT_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOLIQUIDO: Double read FFAT_PRECOLIQUIDO write FFAT_PRECOLIQUIDO;
    const FAT_PRECOLIQUIDO_Name = 'FAT_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECODIGITADO', ftBCD, 48, 10)]
    [Dictionary('FAT_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECODIGITADO: Double read FFAT_PRECODIGITADO write FFAT_PRECODIGITADO;
    const FAT_PRECODIGITADO_Name = 'FAT_PRECODIGITADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOBASEDESCTO', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOBASEDESCTO: Double read FFAT_PRECOBASEDESCTO write FFAT_PRECOBASEDESCTO;
    const FAT_PRECOBASEDESCTO_Name = 'FAT_PRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOMISSAOITEM: Double read FFAT_VALORCOMISSAOITEM write FFAT_VALORCOMISSAOITEM;
    const FAT_VALORCOMISSAOITEM_Name = 'FAT_VALORCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMEROVOLUMES', ftBCD)]
    [Dictionary('FAT_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_NUMEROVOLUMES: Double read FFAT_NUMEROVOLUMES write FFAT_NUMEROVOLUMES;
    const FAT_NUMEROVOLUMES_Name = 'FAT_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIPIITEM: Double read FFAT_PERCENTUALIPIITEM write FFAT_PERCENTUALIPIITEM;
    const FAT_PERCENTUALIPIITEM_Name = 'FAT_PERCENTUALIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALPISITEM', ftBCD, 10, 6)]
    [Dictionary('FAT_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALPISITEM: Double read FFAT_PERCENTUALPISITEM write FFAT_PERCENTUALPISITEM;
    const FAT_PERCENTUALPISITEM_Name = 'FAT_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALMVAITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALMVAITEM: Double read FFAT_PERCENTUALMVAITEM write FFAT_PERCENTUALMVAITEM;
    const FAT_PERCENTUALMVAITEM_Name = 'FAT_PERCENTUALMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALICMSITEM: Double read FFAT_PERCENTUALICMSITEM write FFAT_PERCENTUALICMSITEM;
    const FAT_PERCENTUALICMSITEM_Name = 'FAT_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOFINSITEM: Double read FFAT_PERCENTUALCOFINSITEM write FFAT_PERCENTUALCOFINSITEM;
    const FAT_PERCENTUALCOFINSITEM_Name = 'FAT_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALFRETEITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALFRETEITEM: Double read FFAT_PERCENTUALFRETEITEM write FFAT_PERCENTUALFRETEITEM;
    const FAT_PERCENTUALFRETEITEM_Name = 'FAT_PERCENTUALFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALDESCTOITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESCTOITEM: Double read FFAT_PERCENTUALDESCTOITEM write FFAT_PERCENTUALDESCTOITEM;
    const FAT_PERCENTUALDESCTOITEM_Name = 'FAT_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALSEGUROITEM', ftBCD, 48, 6)]
    [Dictionary('FAT_PERCENTUALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALSEGUROITEM: Double read FFAT_PERCENTUALSEGUROITEM write FFAT_PERCENTUALSEGUROITEM;
    const FAT_PERCENTUALSEGUROITEM_Name = 'FAT_PERCENTUALSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALREDUCAOBCITEM: Double read FFAT_PERCENTUALREDUCAOBCITEM write FFAT_PERCENTUALREDUCAOBCITEM;
    const FAT_PERCENTUALREDUCAOBCITEM_Name = 'FAT_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALICMSDESTINOITEM: Double read FFAT_PERCENTUALICMSDESTINOITEM write FFAT_PERCENTUALICMSDESTINOITEM;
    const FAT_PERCENTUALICMSDESTINOITEM_Name = 'FAT_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALDESPACESSORIAITEM', ftBCD, 10, 6)]
    [Dictionary('FAT_PERCENTUALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESPACESSORIAITEM: Double read FFAT_PERCENTUALDESPACESSORIAITEM write FFAT_PERCENTUALDESPACESSORIAITEM;
    const FAT_PERCENTUALDESPACESSORIAITEM_Name = 'FAT_PERCENTUALDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALCOMISSAOITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOMISSAOITEM: Double read FFAT_PERCENTUALCOMISSAOITEM write FFAT_PERCENTUALCOMISSAOITEM;
    const FAT_PERCENTUALCOMISSAOITEM_Name = 'FAT_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORPISITEM', ftBCD, 48, 6)]
    [Dictionary('FAT_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPISITEM: Double read FFAT_VALORPISITEM write FFAT_VALORPISITEM;
    const FAT_VALORPISITEM_Name = 'FAT_VALORPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORIPIITEM', ftBCD)]
    [Dictionary('FAT_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORIPIITEM: Double read FFAT_VALORIPIITEM write FFAT_VALORIPIITEM;
    const FAT_VALORIPIITEM_Name = 'FAT_VALORIPIITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORICMSITEM: Double read FFAT_VALORICMSITEM write FFAT_VALORICMSITEM;
    const FAT_VALORICMSITEM_Name = 'FAT_VALORICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORICMSRITEM', ftBCD, 48, 6)]
    [Dictionary('FAT_VALORICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORICMSRITEM: Double read FFAT_VALORICMSRITEM write FFAT_VALORICMSRITEM;
    const FAT_VALORICMSRITEM_Name = 'FAT_VALORICMSRITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORFRETEITEM', ftBCD)]
    [Dictionary('FAT_VALORFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORFRETEITEM: Double read FFAT_VALORFRETEITEM write FFAT_VALORFRETEITEM;
    const FAT_VALORFRETEITEM_Name = 'FAT_VALORFRETEITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORCOFINSITEM', ftBCD)]
    [Dictionary('FAT_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOFINSITEM: Double read FFAT_VALORCOFINSITEM write FFAT_VALORCOFINSITEM;
    const FAT_VALORCOFINSITEM_Name = 'FAT_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESCTOITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOITEM: Double read FFAT_VALORDESCTOITEM write FFAT_VALORDESCTOITEM;
    const FAT_VALORDESCTOITEM_Name = 'FAT_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORSEGUROITEM', ftBCD, 48, 6)]
    [Dictionary('FAT_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORSEGUROITEM: Double read FFAT_VALORSEGUROITEM write FFAT_VALORSEGUROITEM;
    const FAT_VALORSEGUROITEM_Name = 'FAT_VALORSEGUROITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASEOUTROSITEM: Double read FFAT_VALORBASEOUTROSITEM write FFAT_VALORBASEOUTROSITEM;
    const FAT_VALORBASEOUTROSITEM_Name = 'FAT_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESCTOPRAZOITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOPRAZOITEM: Double read FFAT_VALORDESCTOPRAZOITEM write FFAT_VALORDESCTOPRAZOITEM;
    const FAT_VALORDESCTOPRAZOITEM_Name = 'FAT_VALORDESCTOPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOAVULSOITEM: Double read FFAT_VALORDESCTOAVULSOITEM write FFAT_VALORDESCTOAVULSOITEM;
    const FAT_VALORDESCTOAVULSOITEM_Name = 'FAT_VALORDESCTOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('FAT_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESPACESSORIAITEM: Double read FFAT_VALORDESPACESSORIAITEM write FFAT_VALORDESPACESSORIAITEM;
    const FAT_VALORDESPACESSORIAITEM_Name = 'FAT_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORSUBSTRIBUTARIAITEM', ftBCD)]
    [Dictionary('FAT_VALORSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORSUBSTRIBUTARIAITEM: Double read FFAT_VALORSUBSTRIBUTARIAITEM write FFAT_VALORSUBSTRIBUTARIAITEM;
    const FAT_VALORSUBSTRIBUTARIAITEM_Name = 'FAT_VALORSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASEISENTOICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASEISENTOICMSITEM: Double read FFAT_VALORBASEISENTOICMSITEM write FFAT_VALORBASEISENTOICMSITEM;
    const FAT_VALORBASEISENTOICMSITEM_Name = 'FAT_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASECALCULOMVAITEM', ftBCD, 16387, 6)]
    [Dictionary('FAT_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOMVAITEM: Double read FFAT_VALORBASECALCULOMVAITEM write FFAT_VALORBASECALCULOMVAITEM;
    const FAT_VALORBASECALCULOMVAITEM_Name = 'FAT_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('FAT_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOICMSITEM: Double read FFAT_VALORBASECALCULOICMSITEM write FFAT_VALORBASECALCULOICMSITEM;
    const FAT_VALORBASECALCULOICMSITEM_Name = 'FAT_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORFINANCEIROPRAZOITEM', ftBCD)]
    [Dictionary('FAT_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORFINANCEIROPRAZOITEM: Double read FFAT_VALORFINANCEIROPRAZOITEM write FFAT_VALORFINANCEIROPRAZOITEM;
    const FAT_VALORFINANCEIROPRAZOITEM_Name = 'FAT_VALORFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_VALORCOMPLEMENTONFICMSITEM', ftBCD, 30, 6)]
    [Dictionary('FAT_VALORCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOMPLEMENTONFICMSITEM: Double read FFAT_VALORCOMPLEMENTONFICMSITEM write FFAT_VALORCOMPLEMENTONFICMSITEM;
    const FAT_VALORCOMPLEMENTONFICMSITEM_Name = 'FAT_VALORCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBCALCULOPISCOFINSITEM', ftBCD, 16387, 6)]
    [Dictionary('FAT_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBCALCULOPISCOFINSITEM: Double read FFAT_VALORBCALCULOPISCOFINSITEM write FFAT_VALORBCALCULOPISCOFINSITEM;
    const FAT_VALORBCALCULOPISCOFINSITEM_Name = 'FAT_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOMISSAOITEM', ftBCD, 1329815375, 2)]
    [Dictionary('FAT_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMISSAOITEM: Double read FFAT_TOTALCOMISSAOITEM write FFAT_TOTALCOMISSAOITEM;
    const FAT_TOTALCOMISSAOITEM_Name = 'FAT_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPISITEM', ftBCD, 1229213507, 2)]
    [Dictionary('FAT_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPISITEM: Double read FFAT_TOTALPISITEM write FFAT_TOTALPISITEM;
    const FAT_TOTALPISITEM_Name = 'FAT_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIPIITEM', ftBCD, 16385, 2)]
    [Dictionary('FAT_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIPIITEM: Double read FFAT_TOTALIPIITEM write FFAT_TOTALIPIITEM;
    const FAT_TOTALIPIITEM_Name = 'FAT_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSITEM', ftBCD, 1, 2)]
    [Dictionary('FAT_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSITEM: Double read FFAT_TOTALICMSITEM write FFAT_TOTALICMSITEM;
    const FAT_TOTALICMSITEM_Name = 'FAT_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSRITEM', ftBCD)]
    [Dictionary('FAT_TOTALICMSRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSRITEM: Double read FFAT_TOTALICMSRITEM write FFAT_TOTALICMSRITEM;
    const FAT_TOTALICMSRITEM_Name = 'FAT_TOTALICMSRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFRETEITEM', ftBCD, 52, 2)]
    [Dictionary('FAT_TOTALFRETEITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFRETEITEM: Double read FFAT_TOTALFRETEITEM write FFAT_TOTALFRETEITEM;
    const FAT_TOTALFRETEITEM_Name = 'FAT_TOTALFRETEITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('FAT_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOFINSITEM: Double read FFAT_TOTALCOFINSITEM write FFAT_TOTALCOFINSITEM;
    const FAT_TOTALCOFINSITEM_Name = 'FAT_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTOITEM', ftBCD, 2097184, 2)]
    [Dictionary('FAT_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOITEM: Double read FFAT_TOTALDESCTOITEM write FFAT_TOTALDESCTOITEM;
    const FAT_TOTALDESCTOITEM_Name = 'FAT_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSEGUROITEM', ftBCD, 5177428, 2)]
    [Dictionary('FAT_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSEGUROITEM: Double read FFAT_TOTALSEGUROITEM write FFAT_TOTALSEGUROITEM;
    const FAT_TOTALSEGUROITEM_Name = 'FAT_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASEOUTROSITEM', ftBCD, 7274610, 2)]
    [Dictionary('FAT_TOTALBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASEOUTROSITEM: Double read FFAT_TOTALBASEOUTROSITEM write FFAT_TOTALBASEOUTROSITEM;
    const FAT_TOTALBASEOUTROSITEM_Name = 'FAT_TOTALBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTOPRAZOITEM', ftBCD, 5374017, 2)]
    [Dictionary('FAT_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOPRAZOITEM: Double read FFAT_TOTALDESCTOPRAZOITEM write FFAT_TOTALDESCTOPRAZOITEM;
    const FAT_TOTALDESCTOPRAZOITEM_Name = 'FAT_TOTALDESCTOPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTOAVULSOITEM', ftBCD, 4522067, 2)]
    [Dictionary('FAT_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOAVULSOITEM: Double read FFAT_TOTALDESCTOAVULSOITEM write FFAT_TOTALDESCTOAVULSOITEM;
    const FAT_TOTALDESCTOAVULSOITEM_Name = 'FAT_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESPACESSORIAITEM', ftBCD, 538970637, 2)]
    [Dictionary('FAT_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESPACESSORIAITEM: Double read FFAT_TOTALDESPACESSORIAITEM write FFAT_TOTALDESPACESSORIAITEM;
    const FAT_TOTALDESPACESSORIAITEM_Name = 'FAT_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSUBSTRIBUTARIAITEM', ftBCD, 1953391939, 2)]
    [Dictionary('FAT_TOTALSUBSTRIBUTARIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSUBSTRIBUTARIAITEM: Double read FFAT_TOTALSUBSTRIBUTARIAITEM write FFAT_TOTALSUBSTRIBUTARIAITEM;
    const FAT_TOTALSUBSTRIBUTARIAITEM_Name = 'FAT_TOTALSUBSTRIBUTARIAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASEISENTOICMSITEM', ftBCD, 4784197, 2)]
    [Dictionary('FAT_TOTALBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASEISENTOICMSITEM: Double read FFAT_TOTALBASEISENTOICMSITEM write FFAT_TOTALBASEISENTOICMSITEM;
    const FAT_TOTALBASEISENTOICMSITEM_Name = 'FAT_TOTALBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOMVAITEM', ftBCD, 4587552, 2)]
    [Dictionary('FAT_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOMVAITEM: Double read FFAT_TOTALBASECALCULOMVAITEM write FFAT_TOTALBASECALCULOMVAITEM;
    const FAT_TOTALBASECALCULOMVAITEM_Name = 'FAT_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOICMSITEM', ftBCD, 2097196, 2)]
    [Dictionary('FAT_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOICMSITEM: Double read FFAT_TOTALBASECALCULOICMSITEM write FFAT_TOTALBASECALCULOICMSITEM;
    const FAT_TOTALBASECALCULOICMSITEM_Name = 'FAT_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFINANCEIROPRAZOITEM', ftBCD, 1818453348, 2)]
    [Dictionary('FAT_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFINANCEIROPRAZOITEM: Double read FFAT_TOTALFINANCEIROPRAZOITEM write FFAT_TOTALFINANCEIROPRAZOITEM;
    const FAT_TOTALFINANCEIROPRAZOITEM_Name = 'FAT_TOTALFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOMPLEMENTONFICMSITEM', ftBCD, 221996910, 2)]
    [Dictionary('FAT_TOTALCOMPLEMENTONFICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMPLEMENTONFICMSITEM: Double read FFAT_TOTALCOMPLEMENTONFICMSITEM write FFAT_TOTALCOMPLEMENTONFICMSITEM;
    const FAT_TOTALCOMPLEMENTONFICMSITEM_Name = 'FAT_TOTALCOMPLEMENTONFICMSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBCALCULOPISCOFINSITEM', ftBCD, 1179206738, 2)]
    [Dictionary('FAT_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBCALCULOPISCOFINSITEM: Double read FFAT_TOTALBCALCULOPISCOFINSITEM write FFAT_TOTALBCALCULOPISCOFINSITEM;
    const FAT_TOTALBCALCULOPISCOFINSITEM_Name = 'FAT_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTITEM', ftBCD, 538970637, 2)]
    [Dictionary('FAT_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTITEM: Double read FFAT_PERCENTUALIBPTITEM write FFAT_PERCENTUALIBPTITEM;
    const FAT_PERCENTUALIBPTITEM_Name = 'FAT_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALAPROXIMADOIMPOSTOITEM', ftBCD, 1936617321, 2)]
    [Dictionary('FAT_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALAPROXIMADOIMPOSTOITEM: Double read FFAT_TOTALAPROXIMADOIMPOSTOITEM write FFAT_TOTALAPROXIMADOIMPOSTOITEM;
    const FAT_TOTALAPROXIMADOIMPOSTOITEM_Name = 'FAT_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PESOLIQUIDOITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_PESOLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PESOLIQUIDOITEM: Double read FFAT_PESOLIQUIDOITEM write FFAT_PESOLIQUIDOITEM;
    const FAT_PESOLIQUIDOITEM_Name = 'FAT_PESOLIQUIDOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PESOBRUTOITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_PESOBRUTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PESOBRUTOITEM: Double read FFAT_PESOBRUTOITEM write FFAT_PESOBRUTOITEM;
    const FAT_PESOBRUTOITEM_Name = 'FAT_PESOBRUTOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_ESTOQUEDEVOLUCAO', ftCurrency)]
    [Dictionary('FAT_ESTOQUEDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_ESTOQUEDEVOLUCAO: Currency read FFAT_ESTOQUEDEVOLUCAO write FFAT_ESTOQUEDEVOLUCAO;
    const FAT_ESTOQUEDEVOLUCAO_Name = 'FAT_ESTOQUEDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('FAT_DIASDEVOLUCAO', ftInteger)]
    [Dictionary('FAT_DIASDEVOLUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_DIASDEVOLUCAO: Integer read FFAT_DIASDEVOLUCAO write FFAT_DIASDEVOLUCAO;
    const FAT_DIASDEVOLUCAO_Name = 'FAT_DIASDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBASEDESCTOCOMISSAOITEM', ftBCD)]
    [Dictionary('FAT_VALORBASEDESCTOCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASEDESCTOCOMISSAOITEM: Double read FFAT_VALORBASEDESCTOCOMISSAOITEM write FFAT_VALORBASEDESCTOCOMISSAOITEM;
    const FAT_VALORBASEDESCTOCOMISSAOITEM_Name = 'FAT_VALORBASEDESCTOCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTMUNICIPALITEM', ftBCD, 5636178, 2)]
    [Dictionary('FAT_PERCENTUALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTMUNICIPALITEM: Double read FFAT_PERCENTUALIBPTMUNICIPALITEM write FFAT_PERCENTUALIBPTMUNICIPALITEM;
    const FAT_PERCENTUALIBPTMUNICIPALITEM_Name = 'FAT_PERCENTUALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTESTADUALITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTESTADUALITEM: Double read FFAT_PERCENTUALIBPTESTADUALITEM write FFAT_PERCENTUALIBPTESTADUALITEM;
    const FAT_PERCENTUALIBPTESTADUALITEM_Name = 'FAT_PERCENTUALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTNACIONALITEM: Double read FFAT_PERCENTUALIBPTNACIONALITEM write FFAT_PERCENTUALIBPTNACIONALITEM;
    const FAT_PERCENTUALIBPTNACIONALITEM_Name = 'FAT_PERCENTUALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTIMPORTADOITEM', ftBCD, 16387, 2)]
    [Dictionary('FAT_PERCENTUALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTIMPORTADOITEM: Double read FFAT_PERCENTUALIBPTIMPORTADOITEM write FFAT_PERCENTUALIBPTIMPORTADOITEM;
    const FAT_PERCENTUALIBPTIMPORTADOITEM_Name = 'FAT_PERCENTUALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTMUNICIPALITEM', ftBCD, 16387, 2)]
    [Dictionary('FAT_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTMUNICIPALITEM: Double read FFAT_TOTALIBPTMUNICIPALITEM write FFAT_TOTALIBPTMUNICIPALITEM;
    const FAT_TOTALIBPTMUNICIPALITEM_Name = 'FAT_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTESTADUALITEM', ftBCD, 300, 2)]
    [Dictionary('FAT_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTESTADUALITEM: Double read FFAT_TOTALIBPTESTADUALITEM write FFAT_TOTALIBPTESTADUALITEM;
    const FAT_TOTALIBPTESTADUALITEM_Name = 'FAT_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTNACIONALITEM', ftBCD)]
    [Dictionary('FAT_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTNACIONALITEM: Double read FFAT_TOTALIBPTNACIONALITEM write FFAT_TOTALIBPTNACIONALITEM;
    const FAT_TOTALIBPTNACIONALITEM_Name = 'FAT_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTIMPORTADOITEM', ftBCD)]
    [Dictionary('FAT_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTIMPORTADOITEM: Double read FFAT_TOTALIBPTIMPORTADOITEM write FFAT_TOTALIBPTIMPORTADOITEM;
    const FAT_TOTALIBPTIMPORTADOITEM_Name = 'FAT_TOTALIBPTIMPORTADOITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_FAT_07)

end.
