unit express.dbo.XML_NOTASFISCAISITENS;

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
  [Table('XML_NOTASFISCAISITENS', '')]
  TDtoXML_NOTASFISCAISITENS = class
  private
    { Private declarations } 
    FNF_TIPO: String;
    FNF_01_01_ID: Integer;
    FNF_ID: Integer;
    FPES_CODIGO: Integer;
    FNF_SERIE: String;
    FMNF_CODIGO: String;
    FNF_NOTAFISCAL: String;
    FCOM_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FPRO_CODIGO: Integer;
    FPRO_CODIGOBARRA1: String;
    FPRO_CODIGOBARRA2: String;
    FPRO_CODIGOBARRA3: String;
    FPRO_CODIGOBARRACAIXA: String;
    FPRO_QTDUNCAIXACODIGOBARRA: Double;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_EMBALAGEM: String;
    FPRO_REFERENCIAINTERNA: String;
    FPRO_QUANTIDADEUNCAIXA: Double;
    FPRO_PROCEDENCIA: String;
    FSGM_CODIGO: String;
    FCLF_CODIGO: String;
    FLEF_CODIGO: Integer;
    FNF_ORDEMITEM: Integer;
    FNF_ORDEMXMLITEM: Integer;
    FNF_QUANTIDADE: Double;
    FNF_VALORITEM: Double;
    FNF_TOTALITEM: Double;
    FNF_VALORITEMLIQUIDO: Double;
    FNF_TOTALITEMLIQUIDO: Double;
    FNF_VALORICMSITEM: Double;
    FNF_VALORIPIITEM: Double;
    FNF_VALORDESCTOITEM: Double;
    FNF_VALORFRETENFITEM: Double;
    FNF_VALORSEGUROITEM: Double;
    FNF_VALORBASECALCULOICMSITEM: Double;
    FNF_VALORBASECALCULOMVAITEM: Double;
    FNF_VALORICMSRNFITEM: Double;
    FNF_VALORPISITEM: Double;
    FNF_VALORCOFINSITEM: Double;
    FNF_PERCENTUALICMSITEM: Double;
    FNF_PERCENTUALIPIITEM: Double;
    FNF_PERCENTUALMVAITEM: Double;
    FNF_PERCENTUALICMSDESTINOITEM: Double;
    FNF_PERCENTUALREDUCAOBCITEM: Double;
    FNF_PERCENTUALPISITEM: Double;
    FNF_PERCENTUALCOFINSITEM: Double;
    FNF_CSOSN: String;
    FNF_PERCICMSDESTINOSNSTITEM: Double;
    FNF_VALORICMSDESTINOSNSTITEM: Double;
    FNF_PERCICMSCREDITOSNSTITEM: Double;
    FNF_VALORICMSCREDITOSNSTITEM: Double;
    FNF_PERCENTUALICMSSNTBITEM: Double;
    FNF_VALORICMSSNTBITEM: Double;
    FNF_VALORDESPACESSORIAITEM: Double;
    FNF_TOTALICMSITEM: Double;
    FNF_TOTALIPIITEM: Double;
    FNF_TOTALDESCTOITEM: Double;
    FNF_TOTALFRETENFITEM: Double;
    FNF_TOTALSEGUROITEM: Double;
    FNF_TOTALBASECALCULOICMSITEM: Double;
    FNF_TOTALBASECALCULOMVAITEM: Double;
    FNF_TOTALICMSRNFITEM: Double;
    FNF_TOTALBCALCULOPISCOFINSITEM: Double;
    FNF_TOTALPISITEM: Double;
    FNF_TOTALCOFINSITEM: Double;
    FNF_TOTALICMSDESTINOSNSTITEM: Double;
    FNF_TOTALICMSCREDITOSNSTITEM: Double;
    FNF_TOTALICMSSNTBITEM: Double;
    FNF_TOTALDESPACESSORIAITEM: Double;
    FCSTPC_CODIGO: String;
    FPRO_CODIGOANP: String;
    FPRO_DESCRICAOANP: String;
    FPRO_PERCENTUALGASGLP: Double;
    FPRO_PERCENTUALGASGNN: Double;
    FPRO_PERCENTUALGASGNI: Double;
    FNF_PERCENTUALIBPTITEM: Double;
    FNF_TOTALAPROXIMADOIMPOSTOITEM: Double;
    FNF_TOTALIBPTMUNICIPALITEM: Double;
    FNF_TOTALIBPTESTADUALITEM: Double;
    FNF_TOTALIBPTNACIONALITEM: Double;
    FNF_TOTALIBPTIMPORTADOITEM: Double;
    FPRO_VALORBASECALCULOMVA: Double;
    FPRO_VALORICMSR: Double;
    FNF_EXTIPI: String;
    FGRD_CODIGO: String;
    FGRD_DESCRICAO: String;
    FNF_PERCENTUALFCPITEM: Double;
    FNF_TOTALBASECALCULOFCPITEM: Double;
    FNF_TOTALFCPITEM: Double;
    FNF_TOTALBASECALCULOFCPSTITEM: Double;
    FNF_TOTALFCPSTITEM: Double;
    FNF_TOTALBASECALCULOFCPRETITEM: Double;
    FNF_TOTALFCPRETITEM: Double;
    FSGM_CODIGOTRIBUTAVEL: String;
    FPRO_QUANTIDADETRIBUTAVEL: Double;
  public 
    { Public declarations } 
     const Table      = 'XML_NOTASFISCAISITENS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TIPO', ftString, 3)]
    [Dictionary('NF_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_TIPO: String read FNF_TIPO write FNF_TIPO;
    const NF_TIPO_Name = 'NF_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_01_01_ID', ftInteger)]
    [Dictionary('NF_01_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NF_01_01_ID: Integer read FNF_01_01_ID write FNF_01_01_ID;
    const NF_01_01_ID_Name = 'NF_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_ID', ftInteger)]
    [Dictionary('NF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NF_ID: Integer read FNF_ID write FNF_ID;
    const NF_ID_Name = 'NF_ID';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NF_SERIE', ftString, 3)]
    [Dictionary('NF_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_SERIE: String read FNF_SERIE write FNF_SERIE;
    const NF_SERIE_Name = 'NF_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NF_NOTAFISCAL', ftString, 9)]
    [Dictionary('NF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_NOTAFISCAL: String read FNF_NOTAFISCAL write FNF_NOTAFISCAL;
    const NF_NOTAFISCAL_Name = 'NF_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA1', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA1: String read FPRO_CODIGOBARRA1 write FPRO_CODIGOBARRA1;
    const PRO_CODIGOBARRA1_Name = 'PRO_CODIGOBARRA1';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA2', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA2: String read FPRO_CODIGOBARRA2 write FPRO_CODIGOBARRA2;
    const PRO_CODIGOBARRA2_Name = 'PRO_CODIGOBARRA2';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA3', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA3: String read FPRO_CODIGOBARRA3 write FPRO_CODIGOBARRA3;
    const PRO_CODIGOBARRA3_Name = 'PRO_CODIGOBARRA3';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRACAIXA', ftString, 14)]
    [Dictionary('PRO_CODIGOBARRACAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRACAIXA: String read FPRO_CODIGOBARRACAIXA write FPRO_CODIGOBARRACAIXA;
    const PRO_CODIGOBARRACAIXA_Name = 'PRO_CODIGOBARRACAIXA';

    [Restrictions([NoValidate])]
    [Column('PRO_QTDUNCAIXACODIGOBARRA', ftBCD)]
    [Dictionary('PRO_QTDUNCAIXACODIGOBARRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDUNCAIXACODIGOBARRA: Double read FPRO_QTDUNCAIXACODIGOBARRA write FPRO_QTDUNCAIXACODIGOBARRA;
    const PRO_QTDUNCAIXACODIGOBARRA_Name = 'PRO_QTDUNCAIXACODIGOBARRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_QUANTIDADEUNCAIXA', ftBCD, 18, 4)]
    [Dictionary('PRO_QUANTIDADEUNCAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QUANTIDADEUNCAIXA: Double read FPRO_QUANTIDADEUNCAIXA write FPRO_QUANTIDADEUNCAIXA;
    const PRO_QUANTIDADEUNCAIXA_Name = 'PRO_QUANTIDADEUNCAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PROCEDENCIA', ftString, 1)]
    [Dictionary('PRO_PROCEDENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PROCEDENCIA: String read FPRO_PROCEDENCIA write FPRO_PROCEDENCIA;
    const PRO_PROCEDENCIA_Name = 'PRO_PROCEDENCIA';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_ORDEMITEM', ftInteger)]
    [Dictionary('NF_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NF_ORDEMITEM: Integer read FNF_ORDEMITEM write FNF_ORDEMITEM;
    const NF_ORDEMITEM_Name = 'NF_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('NF_ORDEMXMLITEM', ftInteger)]
    [Dictionary('NF_ORDEMXMLITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NF_ORDEMXMLITEM: Integer read FNF_ORDEMXMLITEM write FNF_ORDEMXMLITEM;
    const NF_ORDEMXMLITEM_Name = 'NF_ORDEMXMLITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_QUANTIDADE', ftBCD, 18, 4)]
    [Dictionary('NF_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_QUANTIDADE: Double read FNF_QUANTIDADE write FNF_QUANTIDADE;
    const NF_QUANTIDADE_Name = 'NF_QUANTIDADE';

    [Restrictions([NoValidate])]
    [Column('NF_VALORITEM', ftBCD)]
    [Dictionary('NF_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORITEM: Double read FNF_VALORITEM write FNF_VALORITEM;
    const NF_VALORITEM_Name = 'NF_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALITEM', ftBCD, 48, 2)]
    [Dictionary('NF_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALITEM: Double read FNF_TOTALITEM write FNF_TOTALITEM;
    const NF_TOTALITEM_Name = 'NF_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORITEMLIQUIDO', ftBCD, 48, 18)]
    [Dictionary('NF_VALORITEMLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORITEMLIQUIDO: Double read FNF_VALORITEMLIQUIDO write FNF_VALORITEMLIQUIDO;
    const NF_VALORITEMLIQUIDO_Name = 'NF_VALORITEMLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALITEMLIQUIDO', ftBCD)]
    [Dictionary('NF_TOTALITEMLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALITEMLIQUIDO: Double read FNF_TOTALITEMLIQUIDO write FNF_TOTALITEMLIQUIDO;
    const NF_TOTALITEMLIQUIDO_Name = 'NF_TOTALITEMLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NF_VALORICMSITEM', ftBCD)]
    [Dictionary('NF_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORICMSITEM: Double read FNF_VALORICMSITEM write FNF_VALORICMSITEM;
    const NF_VALORICMSITEM_Name = 'NF_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORIPIITEM', ftBCD)]
    [Dictionary('NF_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORIPIITEM: Double read FNF_VALORIPIITEM write FNF_VALORIPIITEM;
    const NF_VALORIPIITEM_Name = 'NF_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORDESCTOITEM', ftBCD)]
    [Dictionary('NF_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORDESCTOITEM: Double read FNF_VALORDESCTOITEM write FNF_VALORDESCTOITEM;
    const NF_VALORDESCTOITEM_Name = 'NF_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORFRETENFITEM', ftBCD, 48, 18)]
    [Dictionary('NF_VALORFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORFRETENFITEM: Double read FNF_VALORFRETENFITEM write FNF_VALORFRETENFITEM;
    const NF_VALORFRETENFITEM_Name = 'NF_VALORFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORSEGUROITEM', ftBCD, 48, 18)]
    [Dictionary('NF_VALORSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORSEGUROITEM: Double read FNF_VALORSEGUROITEM write FNF_VALORSEGUROITEM;
    const NF_VALORSEGUROITEM_Name = 'NF_VALORSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORBASECALCULOICMSITEM', ftBCD, 48, 18)]
    [Dictionary('NF_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORBASECALCULOICMSITEM: Double read FNF_VALORBASECALCULOICMSITEM write FNF_VALORBASECALCULOICMSITEM;
    const NF_VALORBASECALCULOICMSITEM_Name = 'NF_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORBASECALCULOMVAITEM', ftBCD, 48, 18)]
    [Dictionary('NF_VALORBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORBASECALCULOMVAITEM: Double read FNF_VALORBASECALCULOMVAITEM write FNF_VALORBASECALCULOMVAITEM;
    const NF_VALORBASECALCULOMVAITEM_Name = 'NF_VALORBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORICMSRNFITEM', ftBCD)]
    [Dictionary('NF_VALORICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORICMSRNFITEM: Double read FNF_VALORICMSRNFITEM write FNF_VALORICMSRNFITEM;
    const NF_VALORICMSRNFITEM_Name = 'NF_VALORICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORPISITEM', ftBCD)]
    [Dictionary('NF_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORPISITEM: Double read FNF_VALORPISITEM write FNF_VALORPISITEM;
    const NF_VALORPISITEM_Name = 'NF_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORCOFINSITEM', ftBCD)]
    [Dictionary('NF_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORCOFINSITEM: Double read FNF_VALORCOFINSITEM write FNF_VALORCOFINSITEM;
    const NF_VALORCOFINSITEM_Name = 'NF_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('NF_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALICMSITEM: Double read FNF_PERCENTUALICMSITEM write FNF_PERCENTUALICMSITEM;
    const NF_PERCENTUALICMSITEM_Name = 'NF_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALIPIITEM', ftBCD)]
    [Dictionary('NF_PERCENTUALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALIPIITEM: Double read FNF_PERCENTUALIPIITEM write FNF_PERCENTUALIPIITEM;
    const NF_PERCENTUALIPIITEM_Name = 'NF_PERCENTUALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALMVAITEM', ftBCD)]
    [Dictionary('NF_PERCENTUALMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALMVAITEM: Double read FNF_PERCENTUALMVAITEM write FNF_PERCENTUALMVAITEM;
    const NF_PERCENTUALMVAITEM_Name = 'NF_PERCENTUALMVAITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALICMSDESTINOITEM', ftBCD)]
    [Dictionary('NF_PERCENTUALICMSDESTINOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALICMSDESTINOITEM: Double read FNF_PERCENTUALICMSDESTINOITEM write FNF_PERCENTUALICMSDESTINOITEM;
    const NF_PERCENTUALICMSDESTINOITEM_Name = 'NF_PERCENTUALICMSDESTINOITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALREDUCAOBCITEM', ftBCD)]
    [Dictionary('NF_PERCENTUALREDUCAOBCITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALREDUCAOBCITEM: Double read FNF_PERCENTUALREDUCAOBCITEM write FNF_PERCENTUALREDUCAOBCITEM;
    const NF_PERCENTUALREDUCAOBCITEM_Name = 'NF_PERCENTUALREDUCAOBCITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('NF_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALPISITEM: Double read FNF_PERCENTUALPISITEM write FNF_PERCENTUALPISITEM;
    const NF_PERCENTUALPISITEM_Name = 'NF_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALCOFINSITEM', ftBCD, 48, 6)]
    [Dictionary('NF_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALCOFINSITEM: Double read FNF_PERCENTUALCOFINSITEM write FNF_PERCENTUALCOFINSITEM;
    const NF_PERCENTUALCOFINSITEM_Name = 'NF_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_CSOSN', ftString, 3)]
    [Dictionary('NF_CSOSN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CSOSN: String read FNF_CSOSN write FNF_CSOSN;
    const NF_CSOSN_Name = 'NF_CSOSN';

    [Restrictions([NoValidate])]
    [Column('NF_PERCICMSDESTINOSNSTITEM', ftBCD, 10, 6)]
    [Dictionary('NF_PERCICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCICMSDESTINOSNSTITEM: Double read FNF_PERCICMSDESTINOSNSTITEM write FNF_PERCICMSDESTINOSNSTITEM;
    const NF_PERCICMSDESTINOSNSTITEM_Name = 'NF_PERCICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORICMSDESTINOSNSTITEM', ftBCD)]
    [Dictionary('NF_VALORICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORICMSDESTINOSNSTITEM: Double read FNF_VALORICMSDESTINOSNSTITEM write FNF_VALORICMSDESTINOSNSTITEM;
    const NF_VALORICMSDESTINOSNSTITEM_Name = 'NF_VALORICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCICMSCREDITOSNSTITEM', ftBCD)]
    [Dictionary('NF_PERCICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCICMSCREDITOSNSTITEM: Double read FNF_PERCICMSCREDITOSNSTITEM write FNF_PERCICMSCREDITOSNSTITEM;
    const NF_PERCICMSCREDITOSNSTITEM_Name = 'NF_PERCICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORICMSCREDITOSNSTITEM', ftBCD)]
    [Dictionary('NF_VALORICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORICMSCREDITOSNSTITEM: Double read FNF_VALORICMSCREDITOSNSTITEM write FNF_VALORICMSCREDITOSNSTITEM;
    const NF_VALORICMSCREDITOSNSTITEM_Name = 'NF_VALORICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALICMSSNTBITEM', ftBCD, 48, 6)]
    [Dictionary('NF_PERCENTUALICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALICMSSNTBITEM: Double read FNF_PERCENTUALICMSSNTBITEM write FNF_PERCENTUALICMSSNTBITEM;
    const NF_PERCENTUALICMSSNTBITEM_Name = 'NF_PERCENTUALICMSSNTBITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORICMSSNTBITEM', ftBCD, 10, 18)]
    [Dictionary('NF_VALORICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORICMSSNTBITEM: Double read FNF_VALORICMSSNTBITEM write FNF_VALORICMSSNTBITEM;
    const NF_VALORICMSSNTBITEM_Name = 'NF_VALORICMSSNTBITEM';

    [Restrictions([NoValidate])]
    [Column('NF_VALORDESPACESSORIAITEM', ftBCD)]
    [Dictionary('NF_VALORDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_VALORDESPACESSORIAITEM: Double read FNF_VALORDESPACESSORIAITEM write FNF_VALORDESPACESSORIAITEM;
    const NF_VALORDESPACESSORIAITEM_Name = 'NF_VALORDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMSITEM', ftBCD)]
    [Dictionary('NF_TOTALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMSITEM: Double read FNF_TOTALICMSITEM write FNF_TOTALICMSITEM;
    const NF_TOTALICMSITEM_Name = 'NF_TOTALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALIPIITEM', ftBCD, 1145132617, 2)]
    [Dictionary('NF_TOTALIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIPIITEM: Double read FNF_TOTALIPIITEM write FNF_TOTALIPIITEM;
    const NF_TOTALIPIITEM_Name = 'NF_TOTALIPIITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALDESCTOITEM', ftBCD, 5177428, 2)]
    [Dictionary('NF_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALDESCTOITEM: Double read FNF_TOTALDESCTOITEM write FNF_TOTALDESCTOITEM;
    const NF_TOTALDESCTOITEM_Name = 'NF_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALFRETENFITEM', ftBCD, 1835362145, 2)]
    [Dictionary('NF_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFRETENFITEM: Double read FNF_TOTALFRETENFITEM write FNF_TOTALFRETENFITEM;
    const NF_TOTALFRETENFITEM_Name = 'NF_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALSEGUROITEM', ftBCD, 538970637, 2)]
    [Dictionary('NF_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALSEGUROITEM: Double read FNF_TOTALSEGUROITEM write FNF_TOTALSEGUROITEM;
    const NF_TOTALSEGUROITEM_Name = 'NF_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOICMSITEM', ftBCD, 1411398223, 2)]
    [Dictionary('NF_TOTALBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOICMSITEM: Double read FNF_TOTALBASECALCULOICMSITEM write FNF_TOTALBASECALCULOICMSITEM;
    const NF_TOTALBASECALCULOICMSITEM_Name = 'NF_TOTALBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOMVAITEM', ftBCD, 6881394, 2)]
    [Dictionary('NF_TOTALBASECALCULOMVAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOMVAITEM: Double read FNF_TOTALBASECALCULOMVAITEM write FNF_TOTALBASECALCULOMVAITEM;
    const NF_TOTALBASECALCULOMVAITEM_Name = 'NF_TOTALBASECALCULOMVAITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMSRNFITEM', ftBCD, 656419879, 2)]
    [Dictionary('NF_TOTALICMSRNFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMSRNFITEM: Double read FNF_TOTALICMSRNFITEM write FNF_TOTALICMSRNFITEM;
    const NF_TOTALICMSRNFITEM_Name = 'NF_TOTALICMSRNFITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBCALCULOPISCOFINSITEM', ftBCD, 1146045279, 2)]
    [Dictionary('NF_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBCALCULOPISCOFINSITEM: Double read FNF_TOTALBCALCULOPISCOFINSITEM write FNF_TOTALBCALCULOPISCOFINSITEM;
    const NF_TOTALBCALCULOPISCOFINSITEM_Name = 'NF_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALPISITEM', ftBCD, 1981834596, 2)]
    [Dictionary('NF_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALPISITEM: Double read FNF_TOTALPISITEM write FNF_TOTALPISITEM;
    const NF_TOTALPISITEM_Name = 'NF_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALCOFINSITEM', ftBCD, 539780974, 2)]
    [Dictionary('NF_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALCOFINSITEM: Double read FNF_TOTALCOFINSITEM write FNF_TOTALCOFINSITEM;
    const NF_TOTALCOFINSITEM_Name = 'NF_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMSDESTINOSNSTITEM', ftBCD, 1415532614, 2)]
    [Dictionary('NF_TOTALICMSDESTINOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMSDESTINOSNSTITEM: Double read FNF_TOTALICMSDESTINOSNSTITEM write FNF_TOTALICMSDESTINOSNSTITEM;
    const NF_TOTALICMSDESTINOSNSTITEM_Name = 'NF_TOTALICMSDESTINOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMSCREDITOSNSTITEM', ftBCD, 1599096398, 2)]
    [Dictionary('NF_TOTALICMSCREDITOSNSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMSCREDITOSNSTITEM: Double read FNF_TOTALICMSCREDITOSNSTITEM write FNF_TOTALICMSCREDITOSNSTITEM;
    const NF_TOTALICMSCREDITOSNSTITEM_Name = 'NF_TOTALICMSCREDITOSNSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMSSNTBITEM', ftBCD, 1142962771, 2)]
    [Dictionary('NF_TOTALICMSSNTBITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMSSNTBITEM: Double read FNF_TOTALICMSSNTBITEM write FNF_TOTALICMSSNTBITEM;
    const NF_TOTALICMSSNTBITEM_Name = 'NF_TOTALICMSSNTBITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALDESPACESSORIAITEM', ftBCD, 1702129225, 2)]
    [Dictionary('NF_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALDESPACESSORIAITEM: Double read FNF_TOTALDESPACESSORIAITEM write FNF_TOTALDESPACESSORIAITEM;
    const NF_TOTALDESPACESSORIAITEM_Name = 'NF_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOANP', ftString, 9)]
    [Dictionary('PRO_CODIGOANP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOANP: String read FPRO_CODIGOANP write FPRO_CODIGOANP;
    const PRO_CODIGOANP_Name = 'PRO_CODIGOANP';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOANP', ftString, 95)]
    [Dictionary('PRO_DESCRICAOANP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOANP: String read FPRO_DESCRICAOANP write FPRO_DESCRICAOANP;
    const PRO_DESCRICAOANP_Name = 'PRO_DESCRICAOANP';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALGASGLP', ftBCD, 1936020059, 2)]
    [Dictionary('PRO_PERCENTUALGASGLP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALGASGLP: Double read FPRO_PERCENTUALGASGLP write FPRO_PERCENTUALGASGLP;
    const PRO_PERCENTUALGASGLP_Name = 'PRO_PERCENTUALGASGLP';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALGASGNN', ftBCD, 2097196, 2)]
    [Dictionary('PRO_PERCENTUALGASGNN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALGASGNN: Double read FPRO_PERCENTUALGASGNN write FPRO_PERCENTUALGASGNN;
    const PRO_PERCENTUALGASGNN_Name = 'PRO_PERCENTUALGASGNN';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALGASGNI', ftBCD, 1818453348, 2)]
    [Dictionary('PRO_PERCENTUALGASGNI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALGASGNI: Double read FPRO_PERCENTUALGASGNI write FPRO_PERCENTUALGASGNI;
    const PRO_PERCENTUALGASGNI_Name = 'PRO_PERCENTUALGASGNI';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_PERCENTUALIBPTITEM', ftBCD, 221996910, 2)]
    [Dictionary('NF_PERCENTUALIBPTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALIBPTITEM: Double read FNF_PERCENTUALIBPTITEM write FNF_PERCENTUALIBPTITEM;
    const NF_PERCENTUALIBPTITEM_Name = 'NF_PERCENTUALIBPTITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALAPROXIMADOIMPOSTOITEM', ftBCD, 1179206738, 2)]
    [Dictionary('NF_TOTALAPROXIMADOIMPOSTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALAPROXIMADOIMPOSTOITEM: Double read FNF_TOTALAPROXIMADOIMPOSTOITEM write FNF_TOTALAPROXIMADOIMPOSTOITEM;
    const NF_TOTALAPROXIMADOIMPOSTOITEM_Name = 'NF_TOTALAPROXIMADOIMPOSTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALIBPTMUNICIPALITEM', ftBCD, 4587552, 2)]
    [Dictionary('NF_TOTALIBPTMUNICIPALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTMUNICIPALITEM: Double read FNF_TOTALIBPTMUNICIPALITEM write FNF_TOTALIBPTMUNICIPALITEM;
    const NF_TOTALIBPTMUNICIPALITEM_Name = 'NF_TOTALIBPTMUNICIPALITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALIBPTESTADUALITEM', ftBCD, 4784197, 2)]
    [Dictionary('NF_TOTALIBPTESTADUALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTESTADUALITEM: Double read FNF_TOTALIBPTESTADUALITEM write FNF_TOTALIBPTESTADUALITEM;
    const NF_TOTALIBPTESTADUALITEM_Name = 'NF_TOTALIBPTESTADUALITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALIBPTNACIONALITEM', ftBCD, 1953391939, 2)]
    [Dictionary('NF_TOTALIBPTNACIONALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTNACIONALITEM: Double read FNF_TOTALIBPTNACIONALITEM write FNF_TOTALIBPTNACIONALITEM;
    const NF_TOTALIBPTNACIONALITEM_Name = 'NF_TOTALIBPTNACIONALITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALIBPTIMPORTADOITEM', ftBCD, 538970637, 2)]
    [Dictionary('NF_TOTALIBPTIMPORTADOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALIBPTIMPORTADOITEM: Double read FNF_TOTALIBPTIMPORTADOITEM write FNF_TOTALIBPTIMPORTADOITEM;
    const NF_TOTALIBPTIMPORTADOITEM_Name = 'NF_TOTALIBPTIMPORTADOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VALORBASECALCULOMVA', ftBCD, 18, 4)]
    [Dictionary('PRO_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORBASECALCULOMVA: Double read FPRO_VALORBASECALCULOMVA write FPRO_VALORBASECALCULOMVA;
    const PRO_VALORBASECALCULOMVA_Name = 'PRO_VALORBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VALORICMSR', ftBCD, 18, 4)]
    [Dictionary('PRO_VALORICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORICMSR: Double read FPRO_VALORICMSR write FPRO_VALORICMSR;
    const PRO_VALORICMSR_Name = 'PRO_VALORICMSR';

    [Restrictions([NoValidate])]
    [Column('NF_EXTIPI', ftString, 3)]
    [Dictionary('NF_EXTIPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_EXTIPI: String read FNF_EXTIPI write FNF_EXTIPI;
    const NF_EXTIPI_Name = 'NF_EXTIPI';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_DESCRICAO', ftString, 50)]
    [Dictionary('GRD_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_DESCRICAO: String read FGRD_DESCRICAO write FGRD_DESCRICAO;
    const GRD_DESCRICAO_Name = 'GRD_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('NF_PERCENTUALFCPITEM', ftBCD, 4522067, 2)]
    [Dictionary('NF_PERCENTUALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_PERCENTUALFCPITEM: Double read FNF_PERCENTUALFCPITEM write FNF_PERCENTUALFCPITEM;
    const NF_PERCENTUALFCPITEM_Name = 'NF_PERCENTUALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOFCPITEM', ftBCD, 5374017, 2)]
    [Dictionary('NF_TOTALBASECALCULOFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOFCPITEM: Double read FNF_TOTALBASECALCULOFCPITEM write FNF_TOTALBASECALCULOFCPITEM;
    const NF_TOTALBASECALCULOFCPITEM_Name = 'NF_TOTALBASECALCULOFCPITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALFCPITEM', ftBCD, 7274610, 2)]
    [Dictionary('NF_TOTALFCPITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFCPITEM: Double read FNF_TOTALFCPITEM write FNF_TOTALFCPITEM;
    const NF_TOTALFCPITEM_Name = 'NF_TOTALFCPITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOFCPSTITEM', ftBCD, 5177428, 2)]
    [Dictionary('NF_TOTALBASECALCULOFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOFCPSTITEM: Double read FNF_TOTALBASECALCULOFCPSTITEM write FNF_TOTALBASECALCULOFCPSTITEM;
    const NF_TOTALBASECALCULOFCPSTITEM_Name = 'NF_TOTALBASECALCULOFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALFCPSTITEM', ftBCD, 2097184, 2)]
    [Dictionary('NF_TOTALFCPSTITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFCPSTITEM: Double read FNF_TOTALFCPSTITEM write FNF_TOTALFCPSTITEM;
    const NF_TOTALFCPSTITEM_Name = 'NF_TOTALFCPSTITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOFCPRETITEM', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOFCPRETITEM: Double read FNF_TOTALBASECALCULOFCPRETITEM write FNF_TOTALBASECALCULOFCPRETITEM;
    const NF_TOTALBASECALCULOFCPRETITEM_Name = 'NF_TOTALBASECALCULOFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALFCPRETITEM', ftBCD, 52, 2)]
    [Dictionary('NF_TOTALFCPRETITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALFCPRETITEM: Double read FNF_TOTALFCPRETITEM write FNF_TOTALFCPRETITEM;
    const NF_TOTALFCPRETITEM_Name = 'NF_TOTALFCPRETITEM';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGOTRIBUTAVEL', ftString, 2)]
    [Dictionary('SGM_CODIGOTRIBUTAVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGOTRIBUTAVEL: String read FSGM_CODIGOTRIBUTAVEL write FSGM_CODIGOTRIBUTAVEL;
    const SGM_CODIGOTRIBUTAVEL_Name = 'SGM_CODIGOTRIBUTAVEL';

    [Restrictions([NoValidate])]
    [Column('PRO_QUANTIDADETRIBUTAVEL', ftBCD, 18, 4)]
    [Dictionary('PRO_QUANTIDADETRIBUTAVEL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QUANTIDADETRIBUTAVEL: Double read FPRO_QUANTIDADETRIBUTAVEL write FPRO_QUANTIDADETRIBUTAVEL;
    const PRO_QUANTIDADETRIBUTAVEL_Name = 'PRO_QUANTIDADETRIBUTAVEL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_NOTASFISCAISITENS)

end.
